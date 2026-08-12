import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { bytes, count, metaFor } from './format';
import { EmptyState, ReportHeader } from './parts';
import type { Data } from './types';

const MONOSPACE = { fontFamily: 'monospace', whiteSpace: 'pre-wrap' } as const;

function bucket(labels: string[] | undefined) {
  return labels?.length ? labels.join(', ') : 'none';
}

export function CompatTab() {
  const { act, data } = useBackend<Data>();
  const { compat_report, coverage, debug_text, busy, report_meta } = data;

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section title="Verificación cruzada con BYOND">
          <ReportHeader
            label="Capturar comparación"
            busy={busy}
            onCapture={() => act('capture_compat')}
            meta={metaFor(report_meta, 'compat')}
          />
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable>
          <Stack vertical>
            <Stack.Item>
              <NoticeBox info>
                Estas filas deben coincidir con la salida GetServerMemUsage de BYOND. Si la herramienta no encuentra una tabla, el resultado parece un análisis limpio; por eso existe esta comparación. Siempre hay cinco filas y una sexta para alists cuando el mundo contiene alguna. BYOND omite esa fila cuando la cantidad es cero, y aquí se hace lo mismo: si falta en ambos lados, es una coincidencia, no una carencia.
              </NoticeBox>
            </Stack.Item>
            {!compat_report ? (
              <Stack.Item>
                <EmptyState>Nada capturado todavía.</EmptyState>
              </Stack.Item>
            ) : (
              <>
                <Stack.Item>
                  <Section title="byond_memprofile">
                    <Table>
                      <Table.Row header>
                        <Table.Cell>Tipo</Table.Cell>
                        <Table.Cell collapsing>Cantidad</Table.Cell>
                        <Table.Cell collapsing>bytes</Table.Cell>
                      </Table.Row>
                      {compat_report.memprofile.map((row) => (
                        <Table.Row key={row.label} className="candystripe">
                          <Table.Cell>{row.label}</Table.Cell>
                          <Table.Cell
                            collapsing
                            className="text-right text-nowrap"
                          >
                            {count(row.count)}
                          </Table.Cell>
                          <Table.Cell
                            collapsing
                            className="text-right text-nowrap"
                          >
                            {bytes(row.bytes)}
                          </Table.Cell>
                        </Table.Row>
                      ))}
                    </Table>
                  </Section>
                </Stack.Item>
                <Stack.Item>
                  <Section title="GetServerMemUsage de BYOND">
                    {compat_report.byond_available &&
                    compat_report.byond_raw ? (
                      <Box style={MONOSPACE}>{compat_report.byond_raw}</Box>
                    ) : (
                      <NoticeBox color="yellow">
                        Los símbolos de informe de BYOND no se resolvieron, como siempre ocurre fuera de Windows. No hay nada con qué comparar, así que una tabla ausente pasaría inadvertida.
                      </NoticeBox>
                    )}
                  </Section>
                </Stack.Item>
              </>
            )}
            <Stack.Item>
              <Section title="Cobertura de tablas">
                {!coverage ? (
                  <EmptyState>
                    La cobertura se lee una vez al inicio. Si está vacío, la extensión nunca se inicializó.
                  </EmptyState>
                ) : (
                  <>
                    {!coverage.complete && (
                      <NoticeBox danger>
                        Esta construcción no pudo llegar a todas las mesas. Cada total en cada informe está corto por lo que se encuentra en los no disponibles.
                      </NoticeBox>
                    )}
                    <LabeledList>
                      <LabeledList.Item label="Construir">
                        {coverage.build}
                      </LabeledList.Item>
                      <LabeledList.Item label="escaneado" color="good">
                        {bucket(coverage.scanned)}
                      </LabeledList.Item>
                      <LabeledList.Item label="Validado hacia adelante" color="teal">
                        {bucket(coverage.forward_validated)}
                      </LabeledList.Item>
                      <LabeledList.Item label="Alternativa" color="average">
                        {bucket(coverage.fallback)}
                      </LabeledList.Item>
                      <LabeledList.Item label="Indisponible" color="bad">
                        {bucket(coverage.unavailable)}
                      </LabeledList.Item>
                    </LabeledList>
                  </>
                )}
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Section
                title="Búfer de depuración de extensión"
                buttons={
                  <Button
                    icon="download"
                    disabled={!!busy}
                    onClick={() => act('drain_debug')}
                  >
                    Drenar
                  </Button>
                }
              >
                {debug_text ? (
                  <Box style={MONOSPACE}>{debug_text}</Box>
                ) : (
                  <Box color="label">
                    Vacío. El drenaje limpia el tope en el lado de extensión.
                  </Box>
                )}
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
}
