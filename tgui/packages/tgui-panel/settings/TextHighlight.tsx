import {
  Box,
  Button,
  ColorBox,
  Divider,
  Icon,
  Input,
  Section,
  Stack,
  TextArea,
} from 'tgui-core/components';
import { chatRenderer } from '../chat/renderer';
import { WARN_AFTER_HIGHLIGHT_AMT } from './constants';
import { useHighlights } from './use-highlights';

export function TextHighlightSettings(props) {
  const {
    highlights: { highlightSettings },
    addHighlight,
  } = useHighlights();

  return (
    <Section fill scrollable height="250px">
      <Stack vertical>
        {highlightSettings.map((id, i) => (
          <TextHighlightSetting
            key={i}
            id={id}
            mb={i + 1 === highlightSettings.length ? 0 : '10px'}
          />
        ))}
        <Stack.Item>
          <Box>
            <Button
              color="transparent"
              icon="plus"
              onClick={() => addHighlight()}
            >
              Agregar configuracion de resaltado
            </Button>
            {highlightSettings.length >= WARN_AFTER_HIGHLIGHT_AMT && (
              <Box inline fontSize="0.9em" ml={1} color="red">
                <Icon mr={1} name="triangle-exclamation" />
                ¡Grandes cantidades de aspectos destacados pueden causar problemas de rendimiento!
              </Box>
            )}
          </Box>
        </Stack.Item>
      </Stack>
      <Divider />
      <Box>
        <Button icon="check" onClick={() => chatRenderer.rebuildChat()}>
          Aplicar ahora
        </Button>
        <Box inline fontSize="0.9em" ml={1} color="label">
          Puede congelar el chat por un tiempo.
        </Box>
      </Box>
    </Section>
  );
}

function TextHighlightSetting(props) {
  const { id, ...rest } = props;
  const {
    highlights: { highlightSettingById },
    updateHighlight,
    removeHighlight,
  } = useHighlights();
  const {
    highlightColor,
    highlightText,
    highlightWholeMessage,
    matchWord,
    matchCase,
  } = highlightSettingById[id];

  return (
    <Stack.Item {...rest}>
      <Stack mb={1} color="label" align="baseline">
        <Stack.Item grow>
          <Button
            color="transparent"
            icon="times"
            onClick={() => removeHighlight(id)}
          >
            Eliminar
          </Button>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            checked={highlightWholeMessage}
            tooltip="Si se selecciona esta opcion, todo el mensaje se resaltara en amarillo."
            onClick={() =>
              updateHighlight({
                id,
                highlightWholeMessage: !highlightWholeMessage,
              })
            }
          >
            Mensaje completo
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            checked={matchWord}
            tooltipPosition="bottom-start"
            tooltip="Si se selecciona esta opcion, solo se activaran coincidencias exactas (sin letras adicionales antes o despues). No compatible con la puntuacion. Se anula si se utiliza expresiones regulares."
            onClick={() =>
              updateHighlight({
                id,
                matchWord: !matchWord,
              })
            }
          >
            Exacto
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            tooltip="Si se selecciona esta opcion, el resaltado distinguira entre mayusculas y minusculas."
            checked={matchCase}
            onClick={() =>
              updateHighlight({
                id,
                matchCase: !matchCase,
              })
            }
          >
            Caso
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <ColorBox mr={1} color={highlightColor} />
          <Input
            width="5em"
            monospace
            placeholder="#ffffff"
            value={highlightColor}
            onBlur={(value) =>
              updateHighlight({
                id,
                highlightColor: value,
              })
            }
          />
        </Stack.Item>
      </Stack>
      <TextArea
        fluid
        height="3em"
        value={highlightText}
        placeholder="Pon palabras a resaltar aqui. Separe los terminos con comas, es decir (termino1, termino2, termino3)"
        onBlur={(value) =>
          updateHighlight({
            id: id,
            highlightText: value,
          })
        }
      />
    </Stack.Item>
  );
}
