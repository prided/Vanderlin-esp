import { Box } from 'tgui-core/components';
import { SectionHead, OutputBanner, Sprite } from '../Primitives';
import { RecipeLink } from '../RecipeLink';
import type { NavProps } from '../shared';
import type { PotteryStep } from '../types';

export const DetailPottery = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => {
  const steps = r.steps as PotteryStep[] | undefined;
  return (
    <>
      <Box className="RecipeBook__hint">⚙ Punto dulce de rotacion: <strong>{r.speed_sweetspot}</strong></Box>
      <SectionHead>Pasos</SectionHead>
      <Box className="RecipeBook__step-block">
        {steps?.map((s, i) => (
          <Box key={i}>
            <Box className="RecipeBook__step-row">
              <Sprite icon={s.icon} icon_state={s.icon_state} />
              Agregar{' '}
              <RecipeLink name={s.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
              {' '}al torno
            </Box>
            <Box className="RecipeBook__step-row RecipeBook__step-note">↻ Girar para {s.time_s}s</Box>
          </Box>
        ))}
      </Box>
      {r.output_name && (
        <OutputBanner
          icon={r.output_icon}
          icon_state={r.output_state}
          name={r.output_name}
          allRecipes={allRecipes}
          essenceIndex={essenceIndex}
          lookup={lookup}
          pickerMap={pickerMap}
          onNavigate={nav}
        />
      )}
    </>
  );
};
