import { Box } from 'tgui-core/components';
import { SectionHead } from '../Primitives';
import type { Recipe } from '../types';

export const DetailPlantDef = ({ r }: { r: Recipe }) => (
  <>
    <SectionHead>Crecimiento</SectionHead>
    <Box className="RecipeBook__step-block">
      <Box className="RecipeBook__step-row">Maduracion: {r.maturation_min} min</Box>
      <Box className="RecipeBook__step-row">Intervalo de produccion: {r.produce_min} min</Box>
      <Box className="RecipeBook__step-row">Rendimiento: {r.yield_min}–{r.yield_max}</Box>
      <Box className="RecipeBook__step-row">{r.perennial ? '♻ Perennial' : '1× Annual'}</Box>
      <Box className="RecipeBook__step-row">Drenaje de agua: {r.water_drain} ligulas/min</Box>
      {!!r.weed_immune && <Box className="RecipeBook__step-row">inmune a las malas hierbas</Box>}
      {!!r.underground && <Box className="RecipeBook__step-row">Puede crecer bajo tierra</Box>}
      <Box className="RecipeBook__step-row">Familia: {r.family}</Box>
    </Box>
    {!!(r.nitrogen_req || r.phosphorus_req || r.potassium_req) && (
      <>
        <SectionHead>Requisitos de nutrientes</SectionHead>
        <Box className="RecipeBook__step-block">
          {r.nitrogen_req ? <Box className="RecipeBook__step-row">N: {r.nitrogen_req} ligulae</Box> : null}
          {r.phosphorus_req ? <Box className="RecipeBook__step-row">P: {r.phosphorus_req} ligulae</Box> : null}
          {r.potassium_req ? <Box className="RecipeBook__step-row">K: {r.potassium_req} ligulae</Box> : null}
        </Box>
      </>
    )}
    {!!(r.nitrogen_prod || r.phosphorus_prod || r.potassium_prod) && (
      <>
        <SectionHead>Enriquecimiento del suelo</SectionHead>
        <Box className="RecipeBook__step-block">
          {r.nitrogen_prod ? <Box className="RecipeBook__step-row">+N: {r.nitrogen_prod} ligulae</Box> : null}
          {r.phosphorus_prod ? <Box className="RecipeBook__step-row">+P: {r.phosphorus_prod} ligulae</Box> : null}
          {r.potassium_prod ? <Box className="RecipeBook__step-row">+K: {r.potassium_prod} ligulae</Box> : null}
        </Box>
      </>
    )}
  </>
);
