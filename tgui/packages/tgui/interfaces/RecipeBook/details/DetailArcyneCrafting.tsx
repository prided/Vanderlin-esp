import { Box } from 'tgui-core/components';
import { SectionHead, OutputBanner } from './../Primitives';
import { ItemRow } from './../Primitives';
import type { NavProps } from '../shared';

export const DetailArcyneCrafting = ({
  r, lookup, pickerMap, allRecipes, essenceIndex, nav,
}: NavProps) => (
  <>
    {r.required_skill !== undefined && r.required_skill > 0 && (
      <Box className="RecipeBook__skill-bar">
        ⚑ Habilidad arcana requerida: <strong>{r.required_skill}</strong>
      </Box>
    )}

    <SectionHead>Ingredientes (el orden no importa)</SectionHead>
    {r.ingredients?.map((item, i) => (
      <ItemRow
        key={i}
        item={item}
        allRecipes={allRecipes}
        essenceIndex={essenceIndex}
        lookup={lookup}
        pickerMap={pickerMap}
        onNavigate={nav}
      />
    ))}

    <SectionHead>Instrucciones</SectionHead>
    <Box className="RecipeBook__step-block">
      <Box className="RecipeBook__step-row">
        Dibuja el <strong>Matriz de elaboración Arcyne</strong> runa con tiza Arcyne.
      </Box>
      <Box className="RecipeBook__step-row">
        Coloca todos los ingredientes sobre la runa y luego invócala con las manos vacías.
      </Box>
    </Box>

    {r.output_name && (
      <OutputBanner
        icon={r.output_icon}
        icon_state={r.output_state}
        name={r.output_name}
        allRecipes={allRecipes}
        essenceIndex={essenceIndex}
        lookup={lookup}
        pickerMap={pickerMap}
        onNavigate={nav}
      />
    )}
  </>
);
