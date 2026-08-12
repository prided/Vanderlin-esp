import { Box } from 'tgui-core/components';
import { SectionHead, ItemRow, Badge } from '../Primitives';
import type { NavProps } from '../shared';

export const DetailRuneRitual = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => (
  <>
    <Badge>Nivel de complejidad {r.tier}</Badge>
    {!!r.items?.length && (
      <>
        <SectionHead>Artículos requeridos</SectionHead>
        {r.items!.map((item, i) => (
          <ItemRow key={i} item={item} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
        ))}
      </>
    )}
    <SectionHead>Instrucciones</SectionHead>
    <Box className="RecipeBook__step-block">
      <Box className="RecipeBook__step-row">
        Dibuja la runa requerida con tiza Arcyne y luego proporcione los elementos anteriores.
      </Box>
    </Box>
  </>
);
