import { Box } from 'tgui-core/components';
import { SectionHead } from '../Primitives';
import type { Recipe } from '../types';

export const DetailFish = ({ r }: { r: Recipe }) => {
  const diffColor = r.difficulty === 'Hard' ? '#d9534f' : r.difficulty === 'Medium' ? '#f0ad4e' : '#5cb85c';
  return (
    <>
      {r.desc && <Box className="RecipeBook__desc" dangerouslySetInnerHTML={{ __html: r.desc }} />}
      <SectionHead>Fisico</SectionHead>
      <Box className="RecipeBook__step-block">
        <Box className="RecipeBook__step-row">Tamaño: {r.avg_size}cm</Box>
        <Box className="RecipeBook__step-row">Peso: {r.avg_weight}g</Box>
      </Box>
      <SectionHead>Entorno</SectionHead>
      <Box className="RecipeBook__step-block">
        <Box className="RecipeBook__step-row">Liquido: {r.fluid_type}</Box>
        <Box className="RecipeBook__step-row">Temperatura: {r.temp_min}C – {r.temp_max}C</Box>
      </Box>
      <SectionHead>Pesca</SectionHead>
      <Box className="RecipeBook__step-block">
        <Box className="RecipeBook__step-row">Encontro: {r.spots}</Box>
        <Box className="RecipeBook__step-row">
          Dificultad: <span style={{ color: diffColor }}>{r.difficulty}</span>
        </Box>
        <Box className="RecipeBook__step-row">Cebo preferido: {r.fav_bait}</Box>
        <Box className="RecipeBook__step-row">Cebo que no le gusta: {r.dislike_bait}</Box>
        {r.lures?.map((l, i) => (
          <Box key={i} className="RecipeBook__step-row">• {l}</Box>
        ))}
      </Box>
      {!!r.traits?.length && (
        <>
          <SectionHead>Comportamiento</SectionHead>
          <Box className="RecipeBook__step-block">
            {r.traits!.map((t, i) => (
              <Box key={i} className="RecipeBook__step-row">• {t}</Box>
            ))}
          </Box>
        </>
      )}
    </>
  );
};
