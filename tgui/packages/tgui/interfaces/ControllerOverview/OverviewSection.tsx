import { Button, LabeledList, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { ControllerData } from './types';

export function OverviewSection(props) {
  const { act, data } = useBackend<ControllerData>();
  const {
    fast_update,
    rolling_length,
    map_cpu,
    subsystems = [],
    world_time,
  } = data;

  let avgUsage = 0;
  let overallOverrun = 0;
  for (let i = 0; i < subsystems.length; i++) {
    avgUsage += subsystems[i].usage_per_tick;
    overallOverrun += subsystems[i].overtime;
  }

  return (
    <Section
      fill
      title="Descripción general del maestro"
      buttons={
        <>
          <Button
            tooltip="Actualización rápida"
            icon={fast_update ? 'check-square-o' : 'square-o'}
            color={fast_update && 'average'}
            onClick={() => {
              act('toggle_fast_update');
            }}
          >
            Rápido
          </Button>
          <Button.Input
            buttonText={`Average: ${(rolling_length / 10).toFixed(2)} Second(s)`}
            value={(rolling_length / 10).toString()}
            onCommit={(value) => {
              act('set_rolling_length', {
                rolling_length: value,
              });
            }}
          />
        </>
      }
    >
      <Stack fill>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="hora mundial">
              {world_time.toFixed(1)}
            </LabeledList.Item>
            <LabeledList.Item label="Mapa de CPU">
              {map_cpu.toFixed(2)}%
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="Uso promedio general">
              {avgUsage.toFixed(2)}%
            </LabeledList.Item>
            <LabeledList.Item label="Sobrepaso general">
              {overallOverrun.toFixed(2)}%
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
