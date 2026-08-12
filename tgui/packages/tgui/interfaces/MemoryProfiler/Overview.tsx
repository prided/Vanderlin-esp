import { useMemo } from 'react';
import { Box, LabeledList, Section, Stack, Table } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Dumps } from './Dumps';
import { bytes, count, exact, metaFor } from './format';
import { Honesty } from './Honesty';
import { BytesBar, EmptyState, ReportHeader, SkipBreakdown } from './parts';
import type { Data } from './types';

export function Overview() {
  const { act, data } = useBackend<Data>();
  const { census, busy, report_meta, base_sizes } = data;

  const largestRetained = useMemo(
    () =>
      Math.max(
        1,
        ...(census?.retained.by_type ?? []).map((row) => exact(row.bytes)),
      ),
    [census],
  );

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <ReportHeader
            label="Capturar censo"
            busy={busy}
            onCapture={() => act('capture_census')}
            meta={metaFor(report_meta, 'census')}
          />
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable>
          <Stack vertical>
            {!census ? (
              <Stack.Item>
                <EmptyState>
                  Nada capturado todavia. Un censo recorre todo el monton, lo que lleva unos segundos y congela el servidor para todos ellos. Es un diagnostico que se ejecuta deliberadamente, no algo que se debe dejar en un cronometro.
                </EmptyState>
              </Stack.Item>
            ) : (
              <>
                <Stack.Item>
                  <Section title="Totales">
                    <LabeledList>
                      <LabeledList.Item label="Instancias">
                        {count(census.total_instances)} across{' '}
                        {count(census.types_total)} rutas de tipo, sosteniendo{' '}
                        {bytes(census.total_self_bytes)}
                      </LabeledList.Item>
                      <LabeledList.Item label="Listas">
                        {count(census.lists_total)} holding{' '}
                        {bytes(census.list_bytes)}
                      </LabeledList.Item>
                      <LabeledList.Item
                        label="Huerfanos"
                        color={
                          exact(census.orphan_lists) > 0 ? 'average' : undefined
                        }
                      >
                        {count(census.orphan_lists)} no enumera ningun alcance raiz con nombre
                      </LabeledList.Item>
                      <SkipBreakdown skipped={census.skipped} />
                      <LabeledList.Item label="Filas var">
                        {count(census.var_rows_total)} filas a lo largo{' '}
                        {count(census.vars_total)} nombres, costos{' '}
                        {bytes(census.var_bytes)}
                      </LabeledList.Item>
                      <LabeledList.Item label="Construir">
                        {census.build}
                      </LabeledList.Item>
                    </LabeledList>
                  </Section>
                </Stack.Item>
                <Stack.Item>
                  <Section title="Bytes de lista retenidos, atribuidos">
                    <LabeledList>
                      <LabeledList.Item label="Compartido">
                        {bytes(census.retained.shared_bytes)} se mantiene mas de una vez, por lo que la propiedad es genuinamente ambigua
                      </LabeledList.Item>
                      <LabeledList.Item label="Globales">
                        {bytes(census.retained.global_bytes)}
                      </LabeledList.Item>
                      <LabeledList.Item label="Alists">
                        {bytes(census.retained.alist_bytes)}
                      </LabeledList.Item>
                      <LabeledList.Item label="Huerfanos">
                        {bytes(census.retained.orphan_bytes)}
                      </LabeledList.Item>
                      <LabeledList.Item label="demasiado profundo">
                        {bytes(census.retained.deep_bytes)} en cadenas que superaron el limite de saltos
                      </LabeledList.Item>
                      <LabeledList.Item label="Sin atribuir">
                        {bytes(census.retained.unattributed_bytes)}, resumieron los cinco anteriores. Esto es a lo que renuncia la aproximacion del refcount; no es un arbol dominador.
                      </LabeledList.Item>
                    </LabeledList>
                    <Table mt={1}>
                      <Table.Row header>
                        <Table.Cell>Atribuido a la ruta de tipo</Table.Cell>
                        <Table.Cell>bytes</Table.Cell>
                      </Table.Row>
                      {census.retained.by_type.map((row) => (
                        <Table.Row key={row.typepath} className="candystripe">
                          <Table.Cell>{row.typepath}</Table.Cell>
                          <Table.Cell>
                            <BytesBar
                              value={row.bytes}
                              max={largestRetained}
                              color="olive"
                            />
                          </Table.Cell>
                        </Table.Row>
                      ))}
                    </Table>
                  </Section>
                </Stack.Item>
                <Stack.Item>
                  <Honesty footer={census.footer} />
                </Stack.Item>
              </>
            )}
            <Stack.Item>
              <Dumps />
            </Stack.Item>
            <Stack.Item>
              <Section title="Cuanto cuesta una fila">
                <Box color="label" mb={1}>
                  Tamaños base, cada uno rastreado hasta un punto de asignacion en byondcore. A cada instancia se le suma esto y su bloque var; a cada lista, esto y su arbol asociativo. Por tanto, representan el minimo de una fila, no su totalidad.
                </Box>
                <LabeledList>
                  {base_sizes.map((entry) => (
                    <LabeledList.Item key={entry.label} label={entry.label}>
                      {entry.bytes} B
                      {!!entry.note && (
                        <Box inline color="average" ml={1}>
                          - {entry.note}
                        </Box>
                      )}
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
}
