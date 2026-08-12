import { Box } from 'tgui-core/components';
import { SectionHead, OutputBanner, Sprite } from '../Primitives';
import { RecipeLink } from '../RecipeLink';
import type { NavProps } from '../shared';

export const DetailAnvil = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => (
  <>
    <SectionHead>Pasos</SectionHead>
    <Box className="RecipeBook__step-block">
      <Box className="RecipeBook__step-row">
        <Sprite icon={r.bar_icon} icon_state={r.bar_state} />
        Colocar{' '}
        <RecipeLink name={r.bar_name!} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
        {' '}sobre yunque
      </Box>
      <Box className="RecipeBook__step-row RecipeBook__step-note">🔨 Martillo</Box>
      {r.extras?.map((item, i) => (
        <Box key={i}>
          <Box className="RecipeBook__step-row">
            <Sprite icon={item.icon} icon_state={item.icon_state} />
            Agregar{' '}
            <RecipeLink name={item.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
          <Box className="RecipeBook__step-row RecipeBook__step-note">🔨 Martillo</Box>
        </Box>
      ))}
    </Box>
    {r.output_name && (
      <OutputBanner
        icon={r.output_icon}
        icon_state={r.output_state}
        name={r.output_name}
        count={r.output_count}
        allRecipes={allRecipes}
        essenceIndex={essenceIndex}
        lookup={lookup}
        pickerMap={pickerMap}
        onNavigate={nav}
      />
    )}
  </>
);
