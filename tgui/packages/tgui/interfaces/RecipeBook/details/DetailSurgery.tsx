import { Box } from 'tgui-core/components';
import { SectionHead, WarnFlag, HR } from '../Primitives';
import { RecipeLink } from '../RecipeLink';
import type { NavProps } from '../shared';
import { capitalize } from 'tgui-core/string';

export const DetailSurgery = ({ r, lookup, pickerMap, allRecipes, essenceIndex, nav }: NavProps) => {
  return (
    <>
      {!!r.heretical && <WarnFlag color="#cc3333">INVESTIGACIÓN HERÉTICA</WarnFlag>}
      {r.desc && <Box className="RecipeBook__desc" dangerouslySetInnerHTML={{ __html: r.desc }} />}
      <SectionHead>Procedimiento</SectionHead>
      <Box className="RecipeBook__surgery-step">
        {!!r.implements?.length && (
          <Box className="RecipeBook__step-block">
            <strong>Herramientas:</strong>
            {r.implements!.map((t, ti) => (
              <Box key={ti} className="RecipeBook__step-row">
                <RecipeLink name={t.name.replace("_", " ")} allRecipes={allRecipes} essenceIndex={essenceIndex} lookup={lookup} pickerMap={pickerMap} onNavigate={nav} /> {t.modifier}x tiempo de operación
              </Box>
            ))}
          </Box>
        )}
        {r.skill_name && (
          <Box className="RecipeBook__step-block">
            <strong>Habilidad {r.skill_name}:</strong>
            <Box>
              Mínimo: <span dangerouslySetInnerHTML={{ __html: r.min_skill || 'None' }} /> / Óptimo: <span dangerouslySetInnerHTML={{ __html: r.median_skill || 'None' }} />
            </Box>
          </Box>
        )}
        <Box>
        {!!r.hard_requirements?.length && (
          <Box className="RecipeBook__step-block">
            <strong>Requisitos obligatorios:</strong>
            {r.hard_requirements.map((string, index) => (
              <Box key={index} className="RecipeBook__step-row">
                {capitalize(string)}
              </Box>
            ))}
          </Box>
        )}
        </Box>
        <Box>
        {!!r.soft_requirements?.length && (
          <Box className="RecipeBook__step-block">
            <strong>Requisitos alternativos:</strong>
            {r.soft_requirements.map((string, index) => (
              <Box key={index} className="RecipeBook__step-row">
                {capitalize(string)}
              </Box>
            ))}
          </Box>
        )}
        </Box>
        <Box>
        {!!r.optional_requirements?.length && (
          <Box className="RecipeBook__step-block">
            <strong>Requisitos opcionales:</strong>
            {r.optional_requirements.map((string, index) => (
              <Box key={index} className="RecipeBook__step-row">
                {capitalize(string)}
              </Box>
            ))}
          </Box>
        )}
        </Box>
        <Box>
        {!!r.blocker_requirements?.length && (
          <Box className="RecipeBook__step-block">
            <strong>Requisitos de bloqueo:</strong>
            {r.blocker_requirements.map((string, index) => (
              <Box key={index} className="RecipeBook__step-row">
                {capitalize(string)}
              </Box>
            ))}
          </Box>
        )}
        </Box>
        <HR />
      </Box>
    </>
  );
};
