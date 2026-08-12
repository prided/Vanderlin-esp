import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Input,
  NumberInput,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { Window } from '../layouts';
import { TutorialOverlay, TutorialStep, PP } from '../interfaces/_common/TutorialOverlay';

type Attribute = {
  name: string;
  type: string;
  value: number;
  raw_value: number;
};

type Skill = {
  name: string;
  type: string;
  value: number;
  raw_value: number;
};

type AttributeEditorData = {
  parent: string;
  attribute_min: number;
  attribute_max: number;
  attribute_default: number;
  skill_min: number;
  skill_max: number;
  skill_default: number;
  cached_diceroll_modifier: number;
  attributes: Attribute[];
  skills: Skill[];
};

const EDITOR_TUTORIAL_STEPS: TutorialStep[] = [
  {
    title: 'Editor de atributos',
    body: "Esta herramienta te permite editar directamente los atributos y habilidades de un personaje. Los cambios entran en vigor inmediatamente.",
    popupAnchor: 'center',
  },
  {
    title: 'Variables globales',
    body: 'La banda superior establece los limites de todo el sistema, el rango minimo/maximo que pueden alcanzar los atributos y habilidades, sus valores predeterminados de respaldo y el modificador de tirada de dados.',
    highlight: { top: 4, left: 0, width: 100, height: 24 },
    popupAnchor: 'bottom',
  },
  {
    title: 'Atributos (izquierda) y habilidades (derecha)',
    body: 'La mitad inferior se divide en dos columnas desplazables. Cada fila tiene un campo BONUS y uno RAW. RAW es la base permanente. BONUS se suma encima: valor efectivo = RAW + BONUS.',
    highlight: { top: 28, left: 0, width: 100, height: 72 },
    popupAnchor: 'center',
  },
  {
    title: 'BONUS',
    body: 'Escribe un numero positivo o negativo. Se suma directamente a RAW. Establecer BONUS en -22 resta 22 al valor efectivo. NULL elimina por completo el bono; es un modificador independiente, por lo que no anulara otros efectos.',
    popupAnchor: 'center',
  },
  {
    title: 'RAW',
    body: 'El valor base permanente almacenado en el personaje. Editalo para aplicar cambios duraderos. NULL lo restablece al valor predeterminado del sistema.',
    popupAnchor: 'center',
  },
  {
    title: "¡Eso es todo!",
    body: 'Los cambios se aplican inmediatamente. Sin deshacer.',
    popupAnchor: 'center',
  },
];

const EntryRow = (props: {
  name: string;
  type: string;
  value: number;
  raw_value: number;
  min: number;
  max: number;
  act: any;
  isOdd: boolean;
}) => {
  const { name, type, value, raw_value, min, max, act, isOdd } = props;
  const bonus = value - raw_value;
  const bonusColor = bonus > 0 ? PP.green : bonus < 0 ? PP.red : PP.text;

  return (
    <tr style={{
      background: isOdd ? 'rgba(255,255,255,0.025)' : 'transparent',
    }}>
      <td style={{
        padding: '5px 8px',
        color: PP.textTitle,
        fontSize: '105%',
        borderBottom: '1px solid rgba(90,76,76,0.2)',
      }}>
        {name}
      </td>

      <td style={{
        padding: '3px 4px',
        whiteSpace: 'nowrap',
        verticalAlign: 'middle',
        borderBottom: '1px solid rgba(90,76,76,0.2)',
      }}>
        <Box style={{ fontSize: '75%', color: PP.textMuted, textAlign: 'center',
          letterSpacing: '0.05em', marginBottom: '1px' }}>BONUS</Box>
        <NumberInput
          value={bonus}
          step={1}
          onChange={(val: number) =>
            act('change_attribute', { attribute_type: type, new_value: val })
          }
          style={{ color: bonusColor }}
        />
      </td>

      <td style={{
        padding: '3px 6px 3px 2px',
        whiteSpace: 'nowrap',
        verticalAlign: 'bottom',
        borderBottom: '1px solid rgba(90,76,76,0.2)',
      }}>
        <Tooltip content="Quitar bono administrativo; el valor efectivo sera igual a RAW" position="top">
          <Button color="transparent"
            onClick={() => act('null_attribute', { attribute_type: type })}
            style={{ border: `1px solid ${PP.border}`, color: PP.textMuted,
              padding: '1px 5px', fontSize: '80%' }}>
            NULL
          </Button>
        </Tooltip>
      </td>

      <td style={{
        padding: '0 4px',
        borderBottom: '1px solid rgba(90,76,76,0.2)',
      }}>
        <Box style={{ width: '1px', height: '28px', background: PP.border }} />
      </td>

      <td style={{
        padding: '3px 4px',
        whiteSpace: 'nowrap',
        verticalAlign: 'middle',
        borderBottom: '1px solid rgba(90,76,76,0.2)',
      }}>
        <Box style={{ fontSize: '75%', color: PP.textMuted, textAlign: 'center',
          letterSpacing: '0.05em', marginBottom: '1px' }}>RAW</Box>
        <NumberInput
          value={raw_value ?? 0}
          minValue={min ?? 0}
          maxValue={max ?? 0}
          step={1}
          onChange={(val: number) =>
            act('change_raw_attribute', { attribute_type: type, new_value: val })
          }
        />
      </td>

      <td style={{
        padding: '3px 8px 3px 2px',
        whiteSpace: 'nowrap',
        verticalAlign: 'bottom',
        borderBottom: '1px solid rgba(90,76,76,0.2)',
      }}>
        <Tooltip content="Establecer RAW en NULL; se aplicara el valor predeterminado del sistema" position="top">
          <Button color="transparent"
            onClick={() => act('null_raw_attribute', { attribute_type: type })}
            style={{ border: `1px solid ${PP.border}`, color: PP.textMuted,
              padding: '1px 5px', fontSize: '80%' }}>
            NULL
          </Button>
        </Tooltip>
      </td>
    </tr>
  );
};

const EntryTable = (props: {
  entries: (Attribute | Skill)[];
  min: number;
  max: number;
  act: any;
  emptyText: string;
}) => {
  const { entries, min, max, act, emptyText } = props;
  return (
    <table style={{ width: '100%', borderCollapse: 'collapse', tableLayout: 'auto' }}>
      <thead>
        <tr style={{ borderBottom: `1px dotted ${PP.dot}` }}>
          <th style={{ padding: '2px 8px', fontSize: '72%', color: PP.textMuted,
            letterSpacing: '0.07em', fontWeight: 'normal', textAlign: 'left' }}>
            NAME
          </th>
          <th colSpan={2} style={{ padding: '2px 4px', fontSize: '72%', color: PP.textMuted,
            letterSpacing: '0.07em', fontWeight: 'normal', textAlign: 'center', whiteSpace: 'nowrap' }}>
            BONUS · NULL
          </th>
          <th style={{ padding: 0 }} />
          <th colSpan={2} style={{ padding: '2px 4px', fontSize: '72%', color: PP.textMuted,
            letterSpacing: '0.07em', fontWeight: 'normal', textAlign: 'center', whiteSpace: 'nowrap' }}>
            RAW · NULL
          </th>
        </tr>
      </thead>
      <tbody>
        {entries.length === 0 ? (
          <tr>
            <td colSpan={6} style={{ padding: '12px 8px', color: PP.textMuted, fontStyle: 'italic' }}>
              {emptyText}
            </td>
          </tr>
        ) : entries.map((e, i) => (
          <EntryRow key={e.type} name={e.name} type={e.type}
            value={e.value} raw_value={e.raw_value}
            min={min} max={max}
            act={act} isOdd={i % 2 === 1} />
        ))}
      </tbody>
    </table>
  );
};

const GlobalsTable = (props: {
  rows: [string, string, number, boolean][];  // [label, varName, value, nullable]
  act: any;
}) => (
  <table style={{ width: '100%', borderCollapse: 'collapse' }}>
    <tbody>
      {props.rows.map(([label, varName, value, nullable], i) => (
        <tr key={varName} style={{
          background: i % 2 === 1 ? 'rgba(255,255,255,0.02)' : 'transparent',
          borderBottom: '1px solid rgba(90,76,76,0.2)',
        }}>
          <td style={{ padding: '5px 10px', color: PP.text }}>{label}</td>
          <td style={{ padding: '3px 4px', whiteSpace: 'nowrap', verticalAlign: 'middle' }}>
            <NumberInput value={value ?? 0} step={1}
              onChange={(val: number) =>
                varName === 'diceroll'
                  ? props.act('change_diceroll_modifier', { new_value: val })
                  : props.act('change_var', { var_name: varName, var_value: val })
              }
            />
          </td>
          {nullable && (
            <td style={{ padding: '3px 8px 3px 4px', whiteSpace: 'nowrap', verticalAlign: 'bottom' }}>
              <Tooltip content="Establecer en NULL (sin definir)" position="top">
                <Button color="transparent"
                  onClick={() => props.act('null_var', { var_name: varName })}
                  style={{ border: `1px solid ${PP.border}`, color: PP.textMuted,
                    padding: '1px 6px', fontSize: '80%' }}>
                  NULL
                </Button>
              </Tooltip>
            </td>
          )}
          {!nullable && <td />}
        </tr>
      ))}
    </tbody>
  </table>
);

const SectionBar = (props: { title: string; count?: number; right?: React.ReactNode }) => (
  <Box style={{
    background: PP.headerBg,
    borderBottom: `2px solid ${PP.border}`,
    padding: '4px 8px',
    flexShrink: 0,
    display: 'flex',
    alignItems: 'center',
  }}>
    <Box style={{ flexGrow: 1, fontSize: '115%', fontWeight: 'bold',
      color: PP.textTitle, letterSpacing: '0.04em' }}>
      {props.title}
      {props.count !== undefined && (
        <Box as="span" style={{ fontSize: '76%', color: PP.textMuted,
          marginLeft: '6px', fontWeight: 'normal' }}>
          ({props.count})
        </Box>
      )}
    </Box>
    {props.right}
  </Box>
);

export const AttributeEditor = (props: object, context: object) => {
  const { act, data } = useBackend<AttributeEditorData>(context);
  const {
    parent,
    attribute_min = 0, attribute_max = 0, attribute_default = 0,
    skill_min = 0, skill_max = 0, skill_default = 0,
    cached_diceroll_modifier = 0,
    attributes = [], skills = [],
  } = data;

  const [showTutorial, setShowTutorial] = useLocalState('show_editor_tutorial', false);
  const [skillSearch, setSkillSearch] = useLocalState('editor_skill_search', '');

  const filteredSkills = skills.filter(
    (s) => !skillSearch.trim() || s.name.toLowerCase().includes(skillSearch.toLowerCase())
  );

  const CONTENT_H = 668;

  return (
    <Window
      title={parent ? `${parent} - Attribute Editor` : 'Attribute Editor'}
      width={900}
      height={700}>
      <Window.Content>
        <Box style={{
          position: 'relative',
          width: '100%',
          height: `${CONTENT_H}px`,
          display: 'flex',
          flexDirection: 'column',
          overflow: 'hidden',
        }}>

          {showTutorial && (
            <TutorialOverlay
              steps={EDITOR_TUTORIAL_STEPS}
              stateKey="attribute_editor_tutorial"
              onClose={() => setShowTutorial(false)}
            />
          )}

          <Box style={{
            background: PP.headerBg,
            borderBottom: `2px dotted ${PP.dot}`,
            padding: '6px 10px',
            display: 'flex',
            alignItems: 'center',
            flexShrink: 0,
          }}>
            <Box style={{ flexGrow: 1, fontSize: '130%', fontWeight: 'bold', color: PP.textTitle }}>
              {parent || 'Character'}
            </Box>
            <Tooltip content="Mostrar tutorial" position="bottom">
              <Box
                onClick={() => setShowTutorial(true)}
                style={{
                  display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                  width: '22px', height: '22px', borderRadius: '50%',
                  border: `1px solid ${PP.border}`, color: PP.textMuted,
                  fontSize: '120%', fontWeight: 'bold', cursor: 'pointer',
                  userSelect: 'none', lineHeight: 1, background: 'rgba(90,76,76,0.2)',
                }}>
                ?
              </Box>
            </Tooltip>
          </Box>

          <Box style={{
            borderBottom: `2px solid ${PP.border}`,
            flexShrink: 0,
          }}>
            <SectionBar title="Variables globales" />
            <Box style={{ display: 'flex' }}>
              <Box style={{ width: '50%', borderRight: `1px solid ${PP.border}` }}>
                <GlobalsTable act={act} rows={[
                  ['Attribute Max',     'attribute_max',     attribute_max,     true],
                  ['Attribute Min',     'attribute_min',     attribute_min,     true],
                  ['Attribute Default', 'attribute_default', attribute_default, true],
                ]} />
              </Box>
              <Box style={{ width: '50%' }}>
                <GlobalsTable act={act} rows={[
                  ['Skill Max',         'skill_max',         skill_max,         true],
                  ['Skill Min',         'skill_min',         skill_min,         true],
                  ['Skill Default',     'skill_default',     skill_default,     true],
                  ['Diceroll Modifier', 'diceroll',          cached_diceroll_modifier, false],
                ]} />
              </Box>
            </Box>
          </Box>

          <Box style={{
            display: 'flex',
            flexGrow: 1,
            overflow: 'hidden',
          }}>

            <Box style={{
              width: '50%',
              borderRight: `2px solid ${PP.border}`,
              display: 'flex',
              flexDirection: 'column',
              overflow: 'hidden',
            }}>
              <SectionBar title="Atributos" count={attributes.length} />
              <Box style={{ overflowY: 'auto', flexGrow: 1 }}>
                <EntryTable
                  entries={attributes}
                  min={attribute_min} max={attribute_max}
                  act={act} emptyText="No attributes." />
              </Box>
            </Box>

            <Box style={{
              width: '50%',
              display: 'flex',
              flexDirection: 'column',
              overflow: 'hidden',
            }}>
              <SectionBar
                title="Habilidades"
                count={filteredSkills.length}
                right={
                  <Input
                    placeholder="Buscar..."
                    value={skillSearch}
                    onInput={(e) => setSkillSearch(e.target.value)}
                    style={{ width: '120px', fontSize: '90%' }}
                  />
                }
              />
              <Box style={{ overflowY: 'auto', flexGrow: 1 }}>
                <EntryTable
                  entries={filteredSkills}
                  min={skill_min} max={skill_max}
                  act={act}
                  emptyText={skillSearch ? 'No matching skills.' : 'No skills.'} />
              </Box>
            </Box>

          </Box>

        </Box>
      </Window.Content>
    </Window>
  );
};
