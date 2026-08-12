import { Box } from 'tgui-core/components';
import { SectionHead, ItemRow } from '../Primitives';
import { RecipeLink } from '../RecipeLink';
import type { NavProps } from '../shared';

export const DetailAlchCauldron = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => (
  <>
    <Box className="RecipeBook__hint">Requiere 50u de Agua en caldero</Box>
    {!!r.essences?.length && (
      <>
        <SectionHead>Esencias requeridas</SectionHead>
        {r.essences!.map((e, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {e.amount} parts{' '}
            <RecipeLink name={e.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
        ))}
      </>
    )}
    {!!r.output_reagents?.length && (
      <>
        <SectionHead>Reactivos de salida</SectionHead>
        {r.output_reagents!.map((rg, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {rg.amount} ligulas de{' '}
            <RecipeLink name={rg.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
        ))}
      </>
    )}
    {!!r.output_items?.length && (
      <>
        <SectionHead>Objetos de salida</SectionHead>
        {r.output_items!.map((item, i) => (
          <ItemRow key={i} item={item} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
        ))}
      </>
    )}
    {r.smells_like && <Box className="RecipeBook__hint">🌿 Huele a: {r.smells_like}</Box>}
  </>
);
