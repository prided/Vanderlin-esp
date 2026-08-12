import { Box } from 'tgui-core/components';
import { SectionHead, WarnFlag } from '../Primitives';
import type { Recipe } from '../types';

export const DetailWound = ({ r }: { r: Recipe }) => (
  <>
    {r.desc && <Box className="RecipeBook__desc" dangerouslySetInnerHTML={{ __html: r.desc }} />}
    <Box className="RecipeBook__severity-badge" style={{ color: r.severity_color }}>
      Gravedad: <strong>{r.severity_text}</strong>
    </Box>
    {!!r.critical && <WarnFlag color="#cc0000">HERIDA CRÍTICA</WarnFlag>}
    {!!r.mortal && <WarnFlag color="#880000">HERIDA MORTAL</WarnFlag>}
    {!!r.disabling && <WarnFlag color="#cc6600">HERIDA INHABILITANTE</WarnFlag>}
    <SectionHead>Estadísticas de heridas</SectionHead>
    <Box className="RecipeBook__step-block">
      <Box className="RecipeBook__step-row">WHP: {r.whp}</Box>
      {r.passive_healing !== undefined && (
        <Box className="RecipeBook__step-row">Curación pasiva: {r.passive_healing}/latido</Box>
      )}
      {r.sleep_healing !== undefined && (
        <Box className="RecipeBook__step-row">Curación del sueño: {r.sleep_healing}/latido</Box>
      )}
    </Box>
    {(!!r.can_sew || !!r.can_cauterize) && (
      <>
        <SectionHead>Tratamiento</SectionHead>
        <Box className="RecipeBook__step-block">
          {!!r.can_sew && (
            <Box className="RecipeBook__step-row">✂ Cosible ({r.sew_threshold} progreso → {r.sewn_whp} WHP)</Box>
          )}
          {!!r.can_cauterize && (
            <Box className="RecipeBook__step-row">🔥Se puede cauterizar</Box>
          )}
        </Box>
      </>
    )}
    {r.bleed_rate !== undefined && (
      <>
        <SectionHead>Sangrado</SectionHead>
        <Box className="RecipeBook__step-block">
          <Box className="RecipeBook__step-row">Tasa: {r.bleed_rate}</Box>
          {r.sewn_bleed_rate !== undefined && (
            <Box className="RecipeBook__step-row">Tarifa (cosido): {r.sewn_bleed_rate}</Box>
          )}
          {r.clotting_rate && (
            <Box className="RecipeBook__step-row">
              Coagulación: {r.clotting_rate}/latido{r.clotting_threshold !== undefined ? ` → ${r.clotting_threshold}` : ''}
            </Box>
          )}
        </Box>
      </>
    )}
    {r.woundpain !== undefined && (
      <>
        <SectionHead>Dolor</SectionHead>
        <Box className="RecipeBook__step-block">
          <Box className="RecipeBook__step-row">
            Dolor: {r.woundpain}{r.sewn_woundpain !== undefined ? ` (sewn: ${r.sewn_woundpain})` : ''}
          </Box>
        </Box>
      </>
    )}
    {!!r.special_props?.length && (
      <>
        <SectionHead>Propiedades especiales</SectionHead>
        <Box className="RecipeBook__step-block">
          {r.special_props!.map((sp, i) => (
            <Box key={i} className="RecipeBook__step-row">• {sp}</Box>
          ))}
        </Box>
      </>
    )}
    {r.check_name && (
      <>
        <SectionHead>Diagnóstico</SectionHead>
        <Box className="RecipeBook__step-block">
          <Box className="RecipeBook__step-row" dangerouslySetInnerHTML={{ __html: r.check_name! }} />
        </Box>
      </>
    )}
  </>
);
