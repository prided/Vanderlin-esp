import { Box } from 'tgui-core/components';
import { SectionHead, ItemRow, Sprite } from '../Primitives';
import { RecipeLink } from '../RecipeLink';
import type { NavProps } from '../shared';

export const DetailSnackProcessing = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => (
  <>
    {r.mill_name && (
      <>
        <SectionHead>Molienda</SectionHead>
        <Box className="RecipeBook__output-banner">
          <span className="RecipeBook__output-label">Se muele en</span>
          <Box className="RecipeBook__output-body">
            <Sprite icon={r.mill_icon} icon_state={r.mill_state} />
            <RecipeLink name={r.mill_name} path={r.mill_path} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
        </Box>
      </>
    )}
    {!!r.milled_from?.length && (
      <>
        <SectionHead>molido de</SectionHead>
        {r.milled_from!.map((item, i) => (
          <ItemRow key={i} item={item} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
        ))}
      </>
    )}
    {!!r.sliced_from?.length && (
      <>
        <SectionHead>Se obtiene al cortar</SectionHead>
        {r.sliced_from!.map((item, i) => (
          <ItemRow key={i} item={item} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
        ))}
      </>
    )}
    {!!r.sources?.length && (
      <>
        <SectionHead>Obtenido de</SectionHead>
        <Box className="RecipeBook__step-block">
          {r.sources!.map((s, i) => (
            <Box key={i} className="RecipeBook__step-row">
              <Sprite icon={s.icon} icon_state={s.icon_state} />
              <RecipeLink name={s.name} path={s._path} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
              <span className="RecipeBook__step-note"> — {s.label}</span>
            </Box>
          ))}
        </Box>
      </>
    )}
    {!!r.grind_results?.length && (
      <>
        <SectionHead>Molienda</SectionHead>
        {r.grind_results!.map((rg, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {rg.amount} lígulas de{' '}
            <RecipeLink name={rg.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
        ))}
      </>
    )}
    {!!r.juice_results?.length && (
      <>
        <SectionHead>Extracción de jugo</SectionHead>
        {r.juice_results!.map((rg, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {rg.amount} lígulas de{' '}
            <RecipeLink name={rg.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
        ))}
      </>
    )}
    {r.slice_name && (
      <>
        <SectionHead>Corte</SectionHead>
        <Box className="RecipeBook__output-banner">
          <span className="RecipeBook__output-label">Se corta en</span>
          <Box className="RecipeBook__output-body">
            <Sprite icon={r.slice_icon} icon_state={r.slice_state} />
            {r.slice_num !== undefined && r.slice_num > 1 ? `${r.slice_num}× ` : ''}
            <RecipeLink name={r.slice_name} path={r.slice_path} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
            {r.slice_skill && <span className="RecipeBook__step-note"> - requiere {r.slice_skill}</span>}
          </Box>
        </Box>
      </>
    )}
  </>
);
