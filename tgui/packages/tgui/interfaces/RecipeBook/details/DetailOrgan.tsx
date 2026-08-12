import { Box } from 'tgui-core/components';
import { SectionHead, ItemRow } from './../Primitives';
import type { NavProps } from '../shared';

export const DetailOrgan = ({
  r, lookup, pickerMap, allRecipes, essenceIndex, nav,
}: NavProps) => (
  <>
    {r.zone && <Box className="RecipeBook__hint">Ubicado en: <strong>{r.zone}</strong></Box>}

    <SectionHead>Umbrales de daño</SectionHead>
    <Box className="RecipeBook__step-block">
      {r.threshold_low !== undefined && (
        <Box className="RecipeBook__step-row">Magullado: {r.threshold_low}</Box>
      )}
      {r.threshold_high !== undefined && (
        <Box className="RecipeBook__step-row">Fallando: {r.threshold_high}</Box>
      )}
      {r.threshold_max !== undefined && (
        <Box className="RecipeBook__step-row">Destruido: {r.threshold_max}</Box>
      )}
    </Box>

    {!!r.healing_items?.length && (
      <>
        <SectionHead>Articulos curativos</SectionHead>
        {r.healing_items.map((item, i) => (
          <ItemRow key={i} item={item} {...{ allRecipes, essenceIndex, lookup, pickerMap, onNavigate: nav }} />
        ))}
      </>
    )}
  </>
);
