import { Box } from 'tgui-core/components';
import { SectionHead, OutputBanner, ItemRow, WarnFlag } from '../Primitives';
import { RecipeLink } from '../RecipeLink';
import type { NavProps } from '../shared';

export const DetailBrewing = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => (
  <>
    <Box className="RecipeBook__brew-time">⏱ {r.brew_time_s}s tiempo de preparación</Box>
    {r.heat_c !== undefined && (
      <WarnFlag color="#e57c34">Requiere recipiente calentado ≥ {Math.round(r.heat_c!)}C</WarnFlag>
    )}
    {r.prereq_name && (
      <WarnFlag color="#aaaaff">Requiere {r.prereq_name} presente en barril</WarnFlag>
    )}
    {!!r.ages && (
      <WarnFlag color="#aad4aa">Continuará envejeciendo después de la elaboración de cerveza.</WarnFlag>
    )}
    {r.hints && <Box className="RecipeBook__hint">💡 {r.hints}</Box>}
    {!!(r.crops?.length || r.items?.length) && (
      <>
        <SectionHead>Artículos requeridos</SectionHead>
        {r.crops?.map((item, i) => (
          <ItemRow key={i} item={item} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
        ))}
        {r.items?.map((item, i) => (
          <ItemRow key={`it${i}`} item={item} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
        ))}
      </>
    )}
    {!!r.reagents?.length && (
      <>
        <SectionHead>Líquidos requeridos</SectionHead>
        {r.reagents.map((rg, i) => (
          <Box key={i} className="RecipeBook__item-row">
            {rg.amount} lígulas de{' '}
            <RecipeLink name={rg.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
        ))}
      </>
    )}
    <SectionHead>Salida</SectionHead>
    {r.output_liquid && (
      <Box className="RecipeBook__output-banner">
        <span className="RecipeBook__output-label">Líquido</span>
        <Box className="RecipeBook__output-body">
          {r.output_volume} lígulas de <strong>{r.output_liquid}</strong>
        </Box>
      </Box>
    )}
    {r.output_item_name && (
      <OutputBanner
        icon={r.output_item_icon}
        icon_state={r.output_item_state}
        name={r.output_item_name}
        count={r.output_item_count}
        allRecipes={allRecipes}
        essenceIndex={essenceIndex}
        lookup={lookup}
        pickerMap={pickerMap}
        onNavigate={nav}
      />
    )}
    {!!r.age_stages?.length && (
      <>
        <SectionHead>Envejecimiento</SectionHead>
        {r.age_stages!.map((ag, i) => (
          <Box key={i} className="RecipeBook__item-row">
            Después {ag.time_s}s →{' '}
            <RecipeLink name={ag.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
        ))}
      </>
    )}
  </>
);
