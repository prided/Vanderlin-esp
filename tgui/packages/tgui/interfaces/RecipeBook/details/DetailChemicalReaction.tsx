import { Box } from 'tgui-core/components';
import { SectionHead, WarnFlag } from './../Primitives';
import { RecipeLink } from './../RecipeLink';
import type { NavProps } from '../shared';

export const DetailChemicalReaction = ({
  r, lookup, pickerMap, allRecipes, essenceIndex, nav,
}: NavProps) => (
  <>
    {!!r.is_cold_recipe && (
      <WarnFlag color="#88ccff">
        Receta fría: reacciona ABAJO {r.required_temp ? `${r.required_temp - 273.15}C` : 'required temp'}
      </WarnFlag>
    )}
    {!r.is_cold_recipe && r.required_temp ? (
      <WarnFlag color="#e57c34">
        Requiere temperatura ≥ {r.required_temp - 273.15}C
      </WarnFlag>
    ) : null}

    {r.required_container && (
      <WarnFlag color="#aaaaff">
        Debe reaccionar dentro de: {r.required_container}
      </WarnFlag>
    )}

    {r.mob_react === false && (
      <WarnFlag color="#cc6600">
        No puede reaccionar dentro de un cuerpo vivo.
      </WarnFlag>
    )}

    {!!r.required_reagents?.length && (
      <>
        <SectionHead>reactivos</SectionHead>
        {r.required_reagents.map((rg, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {rg.amount} lígulas de{' '}
            <RecipeLink
              name={rg.name}
              allRecipes={allRecipes}
              essenceIndex={essenceIndex}
              lookup={lookup}
              pickerMap={pickerMap}
              onNavigate={nav}
            />
          </Box>
        ))}
      </>
    )}

    {!!r.required_catalysts?.length && (
      <>
        <SectionHead>Catalizadores (no consumidos)</SectionHead>
        {r.required_catalysts.map((rg, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {rg.amount} lígulas de{' '}
            <RecipeLink
              name={rg.name}
              allRecipes={allRecipes}
              essenceIndex={essenceIndex}
              lookup={lookup}
              pickerMap={pickerMap}
              onNavigate={nav}
            />
          </Box>
        ))}
      </>
    )}

    {!!r.results?.length && (
      <>
        <SectionHead>Reactivos de salida</SectionHead>
        {r.results.map((rg, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {rg.amount} lígulas de <strong>{rg.name}</strong>
          </Box>
        ))}
      </>
    )}

    {r.mix_message && (
      <Box className="RecipeBook__hint">💬 {r.mix_message}</Box>
    )}
  </>
);
