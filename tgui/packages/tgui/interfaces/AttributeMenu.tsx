import {
  memo,
  useCallback,
  useEffect,
  useLayoutEffect,
  useMemo,
  useRef,
  useState,
  type CSSProperties,
} from 'react';
import { storage } from 'common/storage';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Input, Section, Stack, Tooltip } from 'tgui-core/components';
import { Window } from '../layouts';

const SEAL_SPRITESHEET_CLASS = 'attribute_seals104x104';
const SEAL_STATES = new Set([
  'strength',
  'dexterity',
  'endurance',
  'intelligence',
  'willpower',
  'perception',
]);

const SEAL_RING_RADIUS = 34;
const SEAL_LABEL_SPREAD = 48;

const sealRingPosition = (index: number, count: number) => {
  const angle = (2 * Math.PI * index) / Math.max(count, 1);
  const sin = Math.sin(angle);
  const cos = Math.cos(angle);
  return {
    left: 50 + SEAL_RING_RADIUS * sin,
    top: 50 - SEAL_RING_RADIUS * cos,
    labelShift: Math.round(SEAL_LABEL_SPREAD * sin * Math.abs(cos)),
  };
};

const statSealLabel = (name: string, shorthand?: string): string =>
  shorthand ? `${name} (${shorthand})` : name;

type TutorialAnchor = 'right' | 'left' | 'bottom' | 'top' | 'center';

interface TutorialStep {
  title: string;
  body: string;
  target?: string;
  popupAnchor?: TutorialAnchor;
}

const TUTORIAL_STEPS: TutorialStep[] = [
  {
    title: 'Bienvenido al libro de atributos',
    body: "Este libro de contabilidad establece los sellos y el registro de habilidades de tu personaje. Dejame explicarte lo que contiene cada pagina.",
    popupAnchor: 'center',
  },
  {
    title: 'Sellos de personajes',
    body: 'La pagina de la izquierda muestra los sellos de los atributos principales dispuestos alrededor de su retrato: Fuerza, Velocidad, Resistencia, Inteligencia, Percepcion, Constitucion y Fortuna. Estos fundamentos gobiernan casi todo lo que haces.',
    target: '.AttributeMenu__panel--seals',
    popupAnchor: 'right',
  },
  {
    title: 'Leyendo un sello',
    body: 'Cada sello muestra su valor actual. El verde significa que una bendicion lo ha elevado, el rojo significa que una maldicion lo ha reducido y la tinta palida significa que no esta modificado.',
    target: '.AttributeMenu__sealNodeValue',
    popupAnchor: 'right',
  },
  {
    title: 'Registro de habilidades',
    body: 'La pagina del medio es el Libro de habilidades: tus habilidades, agrupadas por categoria. Cada entrada muestra su valor actual, coloreado de la misma manera que los sellos.',
    target: '.AttributeMenu__panel--register',
    popupAnchor: 'left',
  },
  {
    title: 'Selector de todas las habilidades',
    body: 'De forma predeterminada, solo se muestran las habilidades entrenadas. Marque Todas las habilidades para revelar tambien las que no estan entrenadas, para que pueda ver lo que queda por aprender.',
    target: '.AttributeMenu__toggle',
    popupAnchor: 'bottom',
  },
  {
    title: 'Buscar en el Registro',
    body: 'Escriba aqui el nombre de una habilidad para filtrar el registro en tiempo real. La busqueda revela automaticamente habilidades no entrenadas para que nada quede oculto.',
    target: '.AttributeMenu__search',
    popupAnchor: 'bottom',
  },
  {
    title: 'Notas marginales',
    body: 'Haz clic en cualquier sello o habilidad y el escriba anotara aqui los detalles: descripcion, dificultad, atributo rector, valores predeterminados y bendiciones o maldiciones activas. Presiona la x para cerrar la nota.',
    target: '.AttributeMenu__panel--notes',
    popupAnchor: 'left',
  },
  {
    title: 'Niveles de habilidad',
    body: 'Los numeros reemplazan los nombres de niveles antiguos: Novato tenia 10-19, Aprendiz 20-29, Oficial 30-39, Experto 40-49, Maestro 50-59, Legendario 60 y superior.',
    popupAnchor: 'center',
  },
  {
    title: 'Eso es todo sobre el libro.',
    body: 'Abre los sellos para inspeccionar sus estadisticas, explore el registro en busca de sus habilidades y lea las notas marginales cuando desee detalles. presiona el ? en cualquier momento para volver a visitar este tutorial.',
    popupAnchor: 'center',
  },
];

const TUTORIAL_CARD_WIDTH = 270;
const TUTORIAL_CARD_GAP = 12;

interface HighlightRect {
  top: number;
  left: number;
  width: number;
  height: number;
}

const tutorialCardStyle = (
  anchor: TutorialAnchor,
  hl: HighlightRect | null,
): CSSProperties => {
  if (!hl || anchor === 'center') {
    return {
      top: '50%',
      left: '50%',
      transform: 'translate(-50%, -50%)',
    };
  }
  switch (anchor) {
    case 'right':
      return {
        top: `${hl.top + hl.height / 2}px`,
        left: `${hl.left + hl.width + TUTORIAL_CARD_GAP}px`,
        transform: 'translateY(-50%)',
      };
    case 'left':
      return {
        top: `${hl.top + hl.height / 2}px`,
        left: `${hl.left - TUTORIAL_CARD_WIDTH - TUTORIAL_CARD_GAP}px`,
        transform: 'translateY(-50%)',
      };
    case 'bottom':
      return {
        top: `${hl.top + hl.height + TUTORIAL_CARD_GAP}px`,
        left: `${hl.left + hl.width / 2}px`,
        transform: 'translateX(-50%)',
      };
    case 'top':
      return {
        top: `${hl.top - TUTORIAL_CARD_GAP}px`,
        left: `${hl.left + hl.width / 2}px`,
        transform: 'translate(-50%, -100%)',
      };
  }
};

const AttributeTutorial = (props: {
  onClose: () => void;
  rootRef: React.RefObject<HTMLDivElement | null>;
}) => {
  const { onClose, rootRef } = props;
  const [step, setStep] = useLocalState<number>('attribute_menu_tutorial_step', 0);
  const [rect, setRect] = useState<HighlightRect | null>(null);

  const safe = Math.min(Math.max(step, 0), TUTORIAL_STEPS.length - 1);
  const current = TUTORIAL_STEPS[safe];
  const isFirst = safe === 0;
  const isLast = safe === TUTORIAL_STEPS.length - 1;
  const anchor = current.popupAnchor ?? 'center';
  const target = current.target;

  useLayoutEffect(() => {
    if (!target || !rootRef.current) {
      setRect(null);
      return;
    }
    const measure = () => {
      const root = rootRef.current;
      if (!root) {
        return;
      }
      const el = root.querySelector<HTMLElement>(target);
      if (!el) {
        setRect(null);
        return;
      }
      const rootBox = root.getBoundingClientRect();
      const box = el.getBoundingClientRect();
      setRect({
        top: box.top - rootBox.top,
        left: box.left - rootBox.left,
        width: box.width,
        height: box.height,
      });
    };
    measure();
    const root = rootRef.current;
    const observer = new ResizeObserver(measure);
    observer.observe(root);
    window.addEventListener('resize', measure);
    return () => {
      observer.disconnect();
      window.removeEventListener('resize', measure);
    };
  }, [target, safe, rootRef]);

  const hl = rect;

  const close = () => {
    setStep(0);
    onClose();
  };

  return (
    <Box className="AttributeMenu__tutorialOverlay">
      <Box className="AttributeMenu__tutorialBackdrop" onClick={close} />
      {hl && (
        <Box
          className="AttributeMenu__tutorialHighlight"
          style={{
            top: `${hl.top}px`,
            left: `${hl.left}px`,
            width: `${hl.width}px`,
            height: `${hl.height}px`,
          }}
        />
      )}
      <Box
        className="AttributeMenu__tutorialCard"
        style={{ width: `${TUTORIAL_CARD_WIDTH}px`, ...tutorialCardStyle(anchor, hl) }}
      >
        {hl && anchor !== 'center' && (
          <Box className={`AttributeMenu__tutorialCaret AttributeMenu__tutorialCaret--${anchor}`} />
        )}
        <Box className="AttributeMenu__tutorialHeader">
          <Box className="AttributeMenu__tutorialEyebrow">
            Paso {safe + 1} of {TUTORIAL_STEPS.length}
          </Box>
          <Box className="AttributeMenu__tutorialTitle">{current.title}</Box>
          <Button
            color="transparent"
            className="AttributeMenu__tutorialClose"
            onClick={close}
          >
            ✕
          </Button>
        </Box>
        <Box className="AttributeMenu__tutorialBody">{current.body}</Box>
        <Box className="AttributeMenu__tutorialDots">
          {TUTORIAL_STEPS.map((_, i) => (
            <Button
              key={i}
              color="transparent"
              className={`AttributeMenu__tutorialDot${i === safe ? ' is-active' : ''}`}
              onClick={() => setStep(i)}
            />
          ))}
        </Box>
        <Box className="AttributeMenu__tutorialFooter">
          {isFirst ? (
            <Box as="span" style={{ minWidth: '70px', display: 'inline-block' }} />
          ) : (
            <Button
              color="transparent"
              className="AttributeMenu__tutorialNav"
              onClick={() => setStep(safe - 1)}
            >
              ← Volver
            </Button>
          )}
          <Button
            color="transparent"
            className={`AttributeMenu__tutorialNav${isLast ? ' AttributeMenu__tutorialNav--done' : ''}`}
            onClick={isLast ? close : () => setStep(safe + 1)}
          >
            {isLast ? '✓ Done' : 'Next →'}
          </Button>
        </Box>
      </Box>
    </Box>
  );
};

type AttributeValue = number | string | null;

interface AttributeModifier {
  id: string;
  value: number;
}

interface AttributeValues {
  base: AttributeValue;
  net_modifier: number | null;
  trained?: boolean;
}

interface StatMeta {
  name: string;
  desc?: string;
  icon?: string;
  shorthand?: string;
}

interface SkillMeta {
  name: string;
  desc?: string;
  icon?: string;
  difficulty?: string;
}

interface SkillCategoryMeta {
  name: string;
  skills: SkillMeta[];
}

interface DefaultMeta {
  name: string;
  desc?: string;
  icon?: string;
  default_value: number;
}

interface AttributeFullMeta {
  name: string;
  desc?: string;
  icon?: string;
  shorthand?: string;
  difficulty?: string;
  governing_attribute?: string;
  defaults?: DefaultMeta[];
  kind: 'stat' | 'skill';
}

interface CloselyInspectedDynamic {
  name: string;
  base: AttributeValue;
  net_modifier: number | null;
  desc_from_level?: string;
  modifiers: AttributeModifier[];
}

interface ResolvedStat extends StatMeta, AttributeValues {}

interface ResolvedSkill extends SkillMeta, AttributeValues {}

interface ResolvedSkillCategory {
  name: string;
  skills: ResolvedSkill[];
}

interface ResolvedInspectedAttribute extends Partial<AttributeFullMeta> {
  name: string;
  base: AttributeValue;
  net_modifier: number | null;
  desc_from_level?: string;
  modifiers: AttributeModifier[];
}

interface AttributeData {
  stats_meta?: StatMeta[];
  skills_by_category_meta?: SkillCategoryMeta[];
  attribute_meta_by_name?: Record<string, AttributeFullMeta>;

  show_bad_skills: boolean;
  parent?: string;
  preview_image?: string;
  stats_values?: Record<string, AttributeValues>;
  skills_values?: Record<string, AttributeValues>;
  closely_inspected?: CloselyInspectedDynamic | null;
}

const EMPTY_VALUES: AttributeValues = {
  base: null,
  net_modifier: null,
  trained: false,
};

type SizeMode = 'small' | 'half' | 'full';

const SIZE_MODES: SizeMode[] = ['small', 'half', 'full'];
const SIZE_MODE_STORAGE_KEY = 'attribute-menu-size-mode';
const SMALL_SIZE: [number, number] = [1100, 700];

const totalFromModifiers = (
  base: AttributeValue | undefined,
  modifiers: AttributeModifier[] | undefined,
) => {
  const modSum = (modifiers || []).reduce((sum, mod) => sum + mod.value, 0);
  if (!isNumeric(base)) {
    // Untrained: no base to add to, but a default can still stand on its own
    return modSum !== 0 ? modSum : null;
  }
  return base + modSum;
};

const displayValue = (value: AttributeValue | undefined) => {
  if (value === null || value === undefined || value === '') {
    return 'NA';
  }
  return String(value);
};

const isNumeric = (value: AttributeValue | undefined): value is number =>
  typeof value === 'number' && Number.isFinite(value);

const valueTone = (netModifier: AttributeValue | undefined) => {
  if (!isNumeric(netModifier) || netModifier === 0) {
    return 'is-muted';
  }
  return netModifier > 0 ? 'is-buffed' : 'is-debuffed';
};

const ModifierBadge = (props: { netModifier: AttributeValue | undefined }) => {
  const { netModifier } = props;
  if (!isNumeric(netModifier) || netModifier === 0) {
    return null;
  }
  const sign = netModifier > 0 ? `+${netModifier}` : `${netModifier}`;
  return (
    <Box as="span" className={`AttributeMenu__modifierBadge ${valueTone(netModifier)}`}>
      {' '}({sign})
    </Box>
  );
};

const IconSprite = memo((props: { icon?: string; size: 'small' | 'big' }) => {
  const { icon, size } = props;

  if (!icon) {
    return <Box as="span" className={`AttributeMenu__iconFallback AttributeMenu__iconFallback--${size}`} />;
  }

  return (
    <Box as="span" className={`AttributeMenu__sprite AttributeMenu__sprite--${size}`}>
      <Box as="span" className={`attributes_${size === 'big' ? 'big128x128' : 'small16x16'} ${icon}`} />
    </Box>
  );
});

const RingFigure = memo((props: { previewImage?: string; subject?: string }) => {
  const { previewImage, subject } = props;

  return (
    <>
      <div className="AttributeMenu__ringCircle AttributeMenu__ringCircle--outer" />
      <div className="AttributeMenu__ringCircle AttributeMenu__ringCircle--track" />
      {previewImage && (
        <Tooltip content={subject || 'Your character'} position="bottom">
          <img
            className="AttributeMenu__previewFigure"
            src={previewImage}
            alt={subject || 'Character portrait'}
          />
        </Tooltip>
      )}
    </>
  );
});

const AttributeSealNode = memo((props: {
  stat: ResolvedStat;
  selected: boolean;
  act: any;
  top: number;
  left: number;
  labelShift: number;
}) => {
  const { stat, selected, act, top, left, labelShift } = props;
  const hemisphere = top < 50 ? 'upper' : 'lower';
  const nodeClass = `AttributeMenu__sealNode AttributeMenu__sealNode--${hemisphere}${
    selected ? ' is-selected' : ''
  }`;

  const sealState = stat.icon;
  const hasMedallion = !!sealState && SEAL_STATES.has(sealState);

  const nodeStyle = {
    top: `${top}%`,
    left: `${left}%`,
    '--seal-label-shift': `${labelShift}px`,
  } as CSSProperties;

  return (
    <Tooltip content={stat.desc || stat.name} position="bottom">
      <button
        className={nodeClass}
        style={nodeStyle}
        onClick={() => act('inspect_closely', { attribute_name: stat.name })}
        type="button"
      >
        {hasMedallion ? (
          <Box as="span" className="AttributeMenu__sealNodeMedallion">
            <Box as="span" className={`${SEAL_SPRITESHEET_CLASS} ${sealState}`} />
          </Box>
        ) : (
          <Box as="span" className="AttributeMenu__sealNodeOrb" />
        )}
        <Box as="span" className="AttributeMenu__sealNodeName">
          {statSealLabel(stat.name, stat.shorthand)}
        </Box>
        <Box as="span" className="AttributeMenu__sealNodeValue">
          {displayValue(stat.base)}
          <ModifierBadge netModifier={stat.net_modifier} />
        </Box>
      </button>
    </Tooltip>
  );
}, (previous, next) =>
  previous.selected === next.selected &&
  previous.stat.name === next.stat.name &&
  previous.stat.base === next.stat.base &&
  previous.stat.net_modifier === next.stat.net_modifier &&
  previous.stat.shorthand === next.stat.shorthand &&
  previous.top === next.top &&
  previous.left === next.left &&
  previous.labelShift === next.labelShift);

const CoreAttributes = memo((props: {
  stats: ResolvedStat[];
  selectedName?: string | null;
  act: any;
  onHelpClick: () => void;
  previewImage?: string;
  subject?: string;
}) => {
  const { stats, selectedName, act, onHelpClick, previewImage, subject } = props;

  return (
    <Section
      fill
      className="AttributeMenu__panel AttributeMenu__panel--seals"
      title={
        <>
          <Box as="span" className="AttributeMenu__eyebrow">Sellos de personajes</Box>
          <Box as="span" className="AttributeMenu__title">Atributos principales</Box>
        </>
      }
      buttons={
        <Button
          color="transparent"
          className="AttributeMenu__helpButton"
          onClick={onHelpClick}
          tooltip="Como leer este libro mayor"
        >
          ?
        </Button>
      }
    >
      <Box className="AttributeMenu__divider" />
      <Box className="AttributeMenu__constellation">
        {!stats.length && (
          <Box className="AttributeMenu__empty">No se registraron atributos.</Box>
        )}
        {!!stats.length && (
          <Box className="AttributeMenu__ringStage">
            <RingFigure previewImage={previewImage} subject={subject} />
            {stats.map((stat, index) => {
              const position = sealRingPosition(index, stats.length);
              return (
                <AttributeSealNode
                  key={stat.name}
                  stat={stat}
                  selected={selectedName === stat.name}
                  act={act}
                  top={position.top}
                  left={position.left}
                  labelShift={position.labelShift}
                />
              );
            })}
          </Box>
        )}
      </Box>
    </Section>
  );
});

const SkillEntry = memo((props: {
  skill: ResolvedSkill;
  selected: boolean;
  act: any;
}) => {
  const { skill, selected, act } = props;

  return (
    <Tooltip
      position="bottom"
      content={
        <Box>
          {skill.desc || skill.name}
          {skill.difficulty && <Box mt={0.5}>[{skill.difficulty}]</Box>}
        </Box>
      }
    >
      <button
        className={`AttributeMenu__skill${selected ? ' is-selected' : ''}`}
        onClick={() => act('inspect_closely', { attribute_name: skill.name })}
        type="button"
      >
        <Box as="span" className="AttributeMenu__skillIcon">
          <IconSprite icon={skill.icon} size="small" />
        </Box>
        <Box as="span" className="AttributeMenu__skillName">{skill.name}</Box>
        <Box as="span" className="AttributeMenu__value">
          {displayValue(skill.base)}
          <ModifierBadge netModifier={skill.net_modifier} />
        </Box>
      </button>
    </Tooltip>
  );
}, (previous, next) =>
  previous.selected === next.selected &&
  previous.skill.name === next.skill.name &&
  previous.skill.base === next.skill.base &&
  previous.skill.net_modifier === next.skill.net_modifier &&
  previous.skill.icon === next.skill.icon &&
  previous.skill.difficulty === next.skill.difficulty &&
  previous.skill.desc === next.skill.desc);

const SkillRegister = memo((props: {
  categoriesMeta: SkillCategoryMeta[];
  skillsValues: Record<string, AttributeValues>;
  showBadSkills: boolean;
  selectedName?: string | null;
  act: any;
}) => {
  const { categoriesMeta, skillsValues, showBadSkills, selectedName, act } = props;
  const [search, setSearch] = useLocalState<string>('attribute_menu_search', '');
  const [searchForcedAllSkills, setSearchForcedAllSkills] = useLocalState<boolean>(
    'attribute_menu_search_forced_all_skills',
    false,
  );

  const searchText = search.trim().toLowerCase();
  const isSearching = searchText.length > 0;

  const handleSearch = (value: string) => {
    const wasSearching = search.trim().length > 0;
    const nowSearching = value.trim().length > 0;

    setSearch(value);

    if (nowSearching && !wasSearching && !showBadSkills) {
      setSearchForcedAllSkills(true);
      act('enable_bad_skills');
    }

    if (!nowSearching && wasSearching && searchForcedAllSkills) {
      setSearchForcedAllSkills(false);
      act('disable_bad_skills');
    }
  };

  const toggleAllSkills = () => {
    if (isSearching) {
      if (showBadSkills) {
        setSearchForcedAllSkills(!searchForcedAllSkills);
      } else {
        setSearchForcedAllSkills(false);
        act('enable_bad_skills');
      }
      return;
    }

    setSearchForcedAllSkills(false);
    act(showBadSkills ? 'disable_bad_skills' : 'enable_bad_skills');
  };

  const visibleCategories = useMemo<ResolvedSkillCategory[]>(() => {
    const result: ResolvedSkillCategory[] = [];
    for (const category of categoriesMeta) {
      const categoryNameLower = category.name.toLowerCase();
      const matchedSkills: ResolvedSkill[] = [];
      for (const skill of category.skills) {
        const values = skillsValues[skill.name] || EMPTY_VALUES;
        if (!showBadSkills && !values.trained) {
          continue;
        }
        if (searchText) {
          const nameHit = skill.name.toLowerCase().includes(searchText);
          const descHit = (skill.desc || '').toLowerCase().includes(searchText);
          const catHit = categoryNameLower.includes(searchText);
          if (!nameHit && !descHit && !catHit) {
            continue;
          }
        }
        matchedSkills.push({ ...skill, ...values });
      }
      if (matchedSkills.length > 0) {
        result.push({ name: category.name, skills: matchedSkills });
      }
    }
    return result;
  }, [categoriesMeta, skillsValues, showBadSkills, searchText]);

  return (
    <Section
      fill
      className="AttributeMenu__panel AttributeMenu__panel--register"
      title={
        <>
          <Box as="span" className="AttributeMenu__eyebrow">Registro de habilidades</Box>
          <Box as="span" className="AttributeMenu__title">Libro de habilidades</Box>
        </>
      }
      buttons={
        <Button.Checkbox
          checked={showBadSkills || isSearching}
          onClick={toggleAllSkills}
          className="AttributeMenu__toggle"
        >
          Todas las habilidades
        </Button.Checkbox>
      }
    >
      <Box className="AttributeMenu__search">
        <Input
          fluid
          placeholder="Busca en el registro..."
          value={search}
          onChange={(value: string) => handleSearch(value)}
        />
      </Box>

      <Box className="AttributeMenu__divider" />

      <Box className="AttributeMenu__scroll AttributeMenu__skillList">
        {!visibleCategories.length && (
          <Box className="AttributeMenu__empty">No hay entradas coincidentes.</Box>
        )}
        {visibleCategories.map((category) => (
          <section className="AttributeMenu__category" key={category.name}>
            <Box className="AttributeMenu__categoryTitle">{category.name}</Box>
            {category.skills.map((skill) => (
              <SkillEntry
                key={skill.name}
                skill={skill}
                selected={selectedName === skill.name}
                act={act}
              />
            ))}
          </section>
        ))}
      </Box>
    </Section>
  );
});

const DetailLine = (props: { label: string; value?: string | number | null }) => {
  const { label, value } = props;

  return (
    <Box className="AttributeMenu__detailLine">
      <Box as="span">{label}</Box>
      <strong>{displayValue(value ?? null)}</strong>
    </Box>
  );
};

const InspectionPanel = memo((props: {
  attribute: ResolvedInspectedAttribute | null;
  act: any;
}) => {
  const { attribute, act } = props;
  if (!attribute) {
    return (
      <Section
        fill
        className="AttributeMenu__panel AttributeMenu__panel--notes"
        title={
          <>
            <Box as="span" className="AttributeMenu__eyebrow">Notas marginales</Box>
            <Box as="span" className="AttributeMenu__title">Inspeccion</Box>
          </>
        }
      >
        <Box className="AttributeMenu__divider" />
        <Box className="AttributeMenu__placeholder">
          <Box className="AttributeMenu__placeholderMark">no inspeccionado</Box>
          <p>Selecciona un sello o una habilidad para leer las notas del escriba.</p>
          <p>Aqui apareceran los valores, valores predeterminados, modificadores y atributos rectores.</p>
        </Box>
      </Section>
    );
  }
  const total = totalFromModifiers(attribute.base, attribute.modifiers);
  return (
    <Section
      fill
      className="AttributeMenu__panel AttributeMenu__panel--notes"
      title={
        <>
          <Box as="span" className="AttributeMenu__eyebrow">Notas marginales</Box>
          <Box as="span" className="AttributeMenu__title">
            {attribute.name}
            {attribute.shorthand && (
              <Box as="span" className="AttributeMenu__titleShort"> ({attribute.shorthand})</Box>
            )}
          </Box>
        </>
      }
      buttons={
        <Button
          color="transparent"
          className="AttributeMenu__closeNote"
          onClick={() => act('clear_inspection')}
        >
          x
        </Button>
      }
    >
      <Box className="AttributeMenu__divider" />

      <Box className="AttributeMenu__noteScroll">
        <Stack className="AttributeMenu__inspectionIntro">
          <Stack.Item>
            <Box as="span" className="AttributeMenu__largeIcon">
              <IconSprite icon={attribute.icon} size="big" />
            </Box>
          </Stack.Item>
          <Stack.Item grow>
            <p className="AttributeMenu__description">
              {attribute.desc || 'No description has been written by the scribe.'}
            </p>
            {attribute.desc_from_level && (
              <p className="AttributeMenu__descriptionFlavor">
                {attribute.desc_from_level}
              </p>
            )}
          </Stack.Item>
        </Stack>
         <Box className="AttributeMenu__valueCard">
          <Box as="span">Valor Total</Box>
          <strong className={valueTone(attribute.net_modifier)}>
            {displayValue(total)}
          </strong>
        </Box>

        <Box className="AttributeMenu__detailGrid">
          <DetailLine label="Gobernante" value={attribute.governing_attribute || 'NA'} />
        </Box>

        {!!attribute.defaults?.length && (
          <section className="AttributeMenu__noteBlock">
            <h3>Valor predeterminado (se aplica el mas alto, no combinado)</h3>
            {attribute.defaults.map((def, index) => {
              const mod = def.default_value ?? 0;
              const tone = mod >= 0 ? 'is-buffed' : 'is-debuffed';
              const sign = mod >= 0 ? `+${mod}` : `${mod}`;
              return (
                <>
                  {index > 0 && (
                    <Box as="span" className="AttributeMenu__defaultOr">o</Box>
                  )}
                  <Tooltip
                    key={def.name}
                    position="bottom"
                    content={`Only the single highest of these applies — they are not added together. ${def.name}'s trained value, plus ${sign}, is compared against the others and against your own trained level.`}
                  >
                    <button
                      className="AttributeMenu__defaultRow"
                      onClick={() => act('inspect_closely', { attribute_name: def.name })}
                      type="button"
                    >
                      <IconSprite icon={def.icon} size="small" />
                      <Box as="span">{def.name}</Box>
                      <strong className={tone}>{sign}</strong>
                    </button>
                  </Tooltip>
                </>
              );
            })}
          </section>
        )}

        <Box className="AttributeMenu__valueCard">
          <Box as="span">Valor base</Box>
          <strong>
            {displayValue(attribute.base)}
          </strong>
        </Box>

        {!!attribute.modifiers?.length && (
          <section className="AttributeMenu__noteBlock">
            <h3>Bendiciones y maldiciones</h3>
            {attribute.modifiers.map((mod) => (
              <Box className="AttributeMenu__modifierRow" key={mod.id}>
                <Box as="span">{mod.id || 'Unnamed modifier'}</Box>
                <strong className={mod.value >= 0 ? 'is-buffed' : 'is-debuffed'}>
                  {mod.value >= 0 ? `+${mod.value}` : mod.value}
                </strong>
              </Box>
            ))}
          </section>
        )}
      </Box>
    </Section>
  );
});

export const AttributeMenu = () => {
  const { act, data, config } = useBackend<AttributeData>();
  const {
    parent,
    stats_meta,
    skills_by_category_meta,
    attribute_meta_by_name,
    stats_values,
    skills_values,
    show_bad_skills = false,
    closely_inspected,
  } = data;

  const statsMetaSafe = stats_meta || [];
  const skillsMetaSafe = skills_by_category_meta || [];
  const attributeMetaSafe = attribute_meta_by_name || {};
  const statsValuesSafe = stats_values || {};
  const skillsValuesSafe = skills_values || {};

  const stats = useMemo<ResolvedStat[]>(
    () =>
      statsMetaSafe.map((meta) => ({
        ...meta,
        ...(statsValuesSafe[meta.name] || EMPTY_VALUES),
      })),
    [statsMetaSafe, statsValuesSafe],
  );

  const inspectedAttribute = useMemo<ResolvedInspectedAttribute | null>(() => {
    if (!closely_inspected) {
      return null;
    }
    const meta = attributeMetaSafe[closely_inspected.name] || {};
    return {
      ...meta,
      ...closely_inspected,
    };
  }, [closely_inspected, attributeMetaSafe]);

  const selectedName = closely_inspected?.name ?? null;

  const [showTutorial, setShowTutorial] = useLocalState<boolean>(
    'attribute_menu_tutorial_open',
    false,
  );
  const openTutorial = useCallback(() => setShowTutorial(true), []);
  const closeTutorial = useCallback(() => setShowTutorial(false), []);

  const rootRef = useRef<HTMLDivElement>(null);

  const [sizeMode, setSizeMode] = useState<SizeMode | null>(null);
  useEffect(() => {
    storage.get(SIZE_MODE_STORAGE_KEY).then((saved) => {
      setSizeMode(SIZE_MODES.includes(saved) ? saved : 'small');
    });
  }, []);

  const geometryKey = config.window?.key || Byond.windowId;

  const selectSizeMode = (mode: SizeMode) => {
    storage.set(SIZE_MODE_STORAGE_KEY, mode);
    if (mode === 'small') {
      storage.remove(geometryKey);
    } else {
      storage.set(geometryKey, { pos: [0, 0] });
    }
    setSizeMode(mode);
  };

  const screenScale = config.window?.scale ? 1 : window.devicePixelRatio || 1;
  const screenWidth = Math.round(window.screen.availWidth * screenScale);
  const screenHeight = Math.round(window.screen.availHeight * screenScale);

  const windowSize: [number, number] =
    sizeMode === 'full'
      ? [screenWidth, screenHeight]
      : sizeMode === 'half'
        ? [Math.round(screenWidth / 2), screenHeight]
        : SMALL_SIZE;

  const windowButtons = (
    <>
      <Button
        icon="compress"
        selected={sizeMode === 'small'}
        onClick={() => selectSizeMode('small')}
        tooltip="ventana compacta"
      />
      <Button
        icon="table-columns"
        selected={sizeMode === 'half'}
        onClick={() => selectSizeMode('half')}
        tooltip="Mitad izquierda de la pantalla"
      />
      <Button
        icon="expand"
        selected={sizeMode === 'full'}
        onClick={() => selectSizeMode('full')}
        tooltip="Pantalla completa"
      />
    </>
  );

  if (!sizeMode) {
    return null;
  }

  return (
    <Window
      title={parent ? `${parent} Character Ledger` : 'Character Ledger'}
      width={windowSize[0]}
      height={windowSize[1]}
      buttons={windowButtons}
    >
      <Window.Content fitted>
        <div className="AttributeMenu" ref={rootRef}>
          <Box className="AttributeMenu__backdrop">
            <CoreAttributes
              stats={stats}
              selectedName={selectedName}
              act={act}
              onHelpClick={openTutorial}
              previewImage={data.preview_image}
              subject={parent}
            />
            <SkillRegister
              categoriesMeta={skillsMetaSafe}
              skillsValues={skillsValuesSafe}
              showBadSkills={show_bad_skills}
              selectedName={selectedName}
              act={act}
            />
            <InspectionPanel attribute={inspectedAttribute} act={act} />
          </Box>
          {showTutorial && (
            <AttributeTutorial onClose={closeTutorial} rootRef={rootRef} />
          )}
        </div>
      </Window.Content>
    </Window>
  );
};
