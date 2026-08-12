import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Input,
  LabeledList,
  Section,
  Slider,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';
import { capitalize } from 'tgui-core/string';
import { chatRenderer } from '../chat/renderer';
import { FONTS, THEMES } from './constants';
import { resetPaneSplitters, setEditPaneSplitters } from './scaling';
import { exportChatSettings, importChatSettings } from './settingsImExport';
import { useSettings, importTGSettings } from './use-settings';

export function SettingsGeneral(props) {
  const { settings, updateSettings } = useSettings();
  const [freeFont, setFreeFont] = useState(false);

  const [editingPanes, setEditingPanes] = useState(false);

  return (
    <Box>
      <Section fill scrollable height="200px">
        <LabeledList>
          <LabeledList.Item label="Tema">
            {THEMES.map((THEME) => (
              <Button
                key={THEME}
                selected={settings.theme === THEME}
                color="transparent"
                onClick={() =>
                  updateSettings({
                    theme: THEME,
                  })
                }
              >
                {capitalize(THEME)}
              </Button>
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="tamaños de interfaz de usuario">
            <Stack>
              <Stack.Item>
                <Button
                  onClick={() =>
                    setEditingPanes((val) => {
                      setEditPaneSplitters(!val);
                      return !val;
                    })
                  }
                  color={editingPanes ? 'bad' : undefined}
                  icon={editingPanes ? 'save' : undefined}
                >
                  {editingPanes ? 'Save' : 'Adjust UI Sizes'}
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button onClick={resetPaneSplitters} icon="refresh" color="bad">
                  Reiniciar
                </Button>
              </Stack.Item>
            </Stack>
          </LabeledList.Item>
          <LabeledList.Item label="Estilo de fuente">
            <Stack.Item>
              {!freeFont ? (
                <Collapsible
                  title={settings.fontFamily}
                  width="100%"
                  buttons={
                    <Button
                      icon={freeFont ? 'lock-open' : 'lock'}
                      color={freeFont ? 'good' : 'bad'}
                      onClick={() => {
                        setFreeFont(!freeFont);
                      }}
                    >
                      Fuente personalizada
                    </Button>
                  }
                >
                  {FONTS.map((FONT) => (
                    <Button
                      key={FONT}
                      fontFamily={FONT}
                      selected={settings.fontFamily === FONT}
                      color="transparent"
                      onClick={() =>
                        updateSettings({
                          fontFamily: FONT,
                        })
                      }
                    >
                      {FONT}
                    </Button>
                  ))}
                </Collapsible>
              ) : (
                <Stack>
                  <Input
                    fluid
                    value={settings.fontFamily}
                    onBlur={(value) =>
                      updateSettings({
                        fontFamily: value,
                      })
                    }
                  />
                  <Button
                    ml={0.5}
                    icon={freeFont ? 'lock-open' : 'lock'}
                    color={freeFont ? 'good' : 'bad'}
                    onClick={() => {
                      setFreeFont(!freeFont);
                    }}
                  >
                    Fuente personalizada
                  </Button>
                </Stack>
              )}
            </Stack.Item>
          </LabeledList.Item>
          <LabeledList.Item label="Tamaño de fuente" verticalAlign="middle">
            <Stack textAlign="center">
              <Stack.Item grow>
                <Slider
                  width="100%"
                  step={1}
                  stepPixelSize={20}
                  minValue={8}
                  maxValue={32}
                  value={settings.fontSize}
                  unit="px"
                  format={(value) => toFixed(value)}
                  onChange={(e, value) => updateSettings({ fontSize: value })}
                />
              </Stack.Item>
            </Stack>
          </LabeledList.Item>
          <LabeledList.Item label="altura de la línea">
            <Slider
              width="100%"
              step={0.01}
              minValue={0.8}
              maxValue={5}
              value={settings.lineHeight}
              format={(value) => toFixed(value, 2)}
              onChange={(e, value) =>
                updateSettings({
                  lineHeight: value,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="Extra">
            <Stack>
              <Stack.Item>
                <Button.Checkbox
                  checked={settings.disableCombine}
                  tooltip="Deshabilitar la combinación para mensajes duplicados"
                  onClick={() =>
                    updateSettings({
                      disableCombine: !settings.disableCombine,
                    })
                  }
                >
                  Deshabilitar la combinación
                </Button.Checkbox>
              </Stack.Item>
              <Stack.Item>
                <Button.Checkbox
                  checked={settings.zebraHighlight}
                  tooltip="Resalte el fondo de cada otro mensaje"
                  onClick={() =>
                    updateSettings({
                      zebraHighlight: !settings.zebraHighlight,
                    })
                  }
                >
                  Resaltado de cebra
                </Button.Checkbox>
              </Stack.Item>
            </Stack>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section scrollableHorizontal>
        <Stack fill>
          <Stack.Item mt={0.15}>
            <Button
              icon="compact-disc"
              tooltip="Exportar configuración de chat"
              onClick={exportChatSettings}
            >
              Exportar
            </Button>
          </Stack.Item>
          <Stack.Item mt={0.15}>
            <Button.File
              accept=".json"
              tooltip="Importar configuración de chat"
              icon="arrow-up-from-bracket"
              onSelectFiles={importChatSettings}
            >
              Importar
            </Button.File>
          </Stack.Item>
          <Stack.Item mt={0.15}>
            <Button
              icon="arrow-up-from-bracket"
              tooltip="Importar configuraciones de la llave TG a la nueva"
              onClick={importTGSettings}
            >
              Importar configuración anterior
            </Button>
          </Stack.Item>
          <Stack.Item grow mt={0.15}>
            <Button
              icon="save"
              tooltip="Exportar el historial de pestañas actual a un archivo HTML"
              onClick={() => chatRenderer.saveToDisk()}
            >
              Guardar registro de chat
            </Button>
          </Stack.Item>
          <Stack.Item mt={0.15}>
            <Button.Confirm
              icon="trash"
              tooltip="Borrar el historial de pestañas actual"
              onClick={() => chatRenderer.clearChat()}
            >
              Borrar chat
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Section>
    </Box>
  );
}
