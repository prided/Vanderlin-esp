import { Box } from 'tgui-core/components';
import { SectionHead, Badge, WarnFlag } from '../Primitives';
import type { Recipe } from '../types';

export const DetailChimericNode = ({ r }: { r: Recipe }) => (
  <>
    {r.desc && <Box className="RecipeBook__desc" dangerouslySetInnerHTML={{ __html: r.desc }} />}
    <Badge color={r.slot_color}>{r.slot_name}</Badge>
    {!!r.is_special && <WarnFlag color="purple">NODO ESPECIAL</WarnFlag>}
    <SectionHead>Instalacion</SectionHead>
    <Box className="RecipeBook__step-block">
      {r.allowed_slots?.length ? (
        <>
          <Box className="RecipeBook__step-row" style={{ color: 'steelblue' }}>SOLO se puede instalar en:</Box>
          {r.allowed_slots.map((s, i) => (
            <Box key={i} className="RecipeBook__step-row">• {s}</Box>
          ))}
        </>
      ) : r.forbidden_slots?.length ? (
        <>
          <Box className="RecipeBook__step-row" style={{ color: 'orange' }}>No se puede instalar en:</Box>
          {r.forbidden_slots.map((s, i) => (
            <Box key={i} className="RecipeBook__step-row">• {s}</Box>
          ))}
        </>
      ) : (
        <Box className="RecipeBook__step-row" style={{ color: 'mediumseagreen' }}>✓ Puede instalarse en cualquier organo</Box>
      )}
    </Box>
  </>
);
