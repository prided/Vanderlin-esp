import { Box } from 'tgui-core/components';
import { SectionHead, HR, Sprite } from '../Primitives';
import { RecipeLink } from '../RecipeLink';
import type { NavProps } from '../shared';

export const DetailOrderlessSlapcraft = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => {
  return (
    <>
        {r.skill_name && (
          <Box className="RecipeBook__skill-bar">Con <strong>{r.skill_name}</strong> habilidad:</Box>
        )}
        <SectionHead>Pasos</SectionHead>
        <Box className="RecipeBook__step-block">
          <Box className="RecipeBook__step-row">
            <Sprite icon={r.starting_icon} icon_state={r.starting_state} />
            Empezar con <RecipeLink name={r.starting_name!} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
          </Box>
          <Box className="RecipeBook__step-row RecipeBook__step-note">luego agrega:</Box>
          <HR />
          {(r.requirements as any[])?.map((req: any, i: number) => {
            if (req.choices) {
              return (
                <Box key={i}>
                  <Box className="RecipeBook__step-row">hasta {req.count} de:</Box>
                  {req.choices.map((c: any, ci: number) => (
                    <Box key={ci} className="RecipeBook__step-row">
                      <Sprite icon={c.icon} icon_state={c.icon_state} />
                      any <RecipeLink name={c.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
                    </Box>
                  ))}
                  <HR />
                </Box>
              );
            }
            return (
              <Box key={i}>
                <Box className="RecipeBook__step-row">
                  <Sprite icon={req.icon} icon_state={req.icon_state} />
                  {req.count}× cualquiera <RecipeLink name={req.name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
                </Box>
                <HR />
              </Box>
            );
          })}
          {r.finishing_name && (
            <Box className="RecipeBook__step-row">
              <Sprite icon={r.finishing_icon} icon_state={r.finishing_state} />
              terminar con cualquier <RecipeLink name={r.finishing_name} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} />
            </Box>
          )}
        </Box>
      </>
  );
};
