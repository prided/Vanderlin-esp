import {
  Box,
  Button,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { bytes, count } from './format';
import type { Data } from './types';

export function Dumps() {
  const { act, data } = useBackend<Data>();
  const { dumps, busy, dump_row_options, census, lists_report } = data;

  const knownLists = lists_report?.lists_total ?? census?.lists_total;

  return (
    <Section title="Volcados de archivos">
      <Stack vertical>
        <Stack.Item>
          <NoticeBox info>
            Un informe devuelto tiene un límite de 40 filas superiores por sección, por lo que un archivo es la única forma de verlo todo. El servidor permanece congelado durante todo el recorrido y toda la escritura, y un censo completo en un mundo vivo alcanza cientos de megabytes.
          </NoticeBox>
        </Stack.Item>
        <Stack.Item>
          <Stack align="center" wrap>
            <Stack.Item>
              <Button.Confirm
                icon="file-arrow-down"
                disabled={!!busy}
                onClick={() => act('dump', { kind: 'census' })}
              >
                Volcar censo completo
              </Button.Confirm>
            </Stack.Item>
            <Stack.Item color="label">Listas de volcado:</Stack.Item>
            {dump_row_options.map((option) =>
              option === 'all' ? (
                <Stack.Item key={option}>
                  <Button.Confirm
                    icon="triangle-exclamation"
                    color="bad"
                    disabled={!!busy}
                    confirmContent={
                      knownLists
                        ? `All ${count(knownLists)} lists?`
                        : 'Every list?'
                    }
                    onClick={() => act('dump', { kind: 'lists', rows: option })}
                  >
                    all
                  </Button.Confirm>
                </Stack.Item>
              ) : (
                <Stack.Item key={option}>
                  <Button
                    disabled={!!busy}
                    onClick={() => act('dump', { kind: 'lists', rows: option })}
                  >
                    {count(option)}
                  </Button>
                </Stack.Item>
              ),
            )}
          </Stack>
        </Stack.Item>
        <Stack.Item>
          {dumps.length === 0 ? (
            <Box color="label">No se generaron volcados esta ronda.</Box>
          ) : (
            <Table>
              <Table.Row header>
                <Table.Cell collapsing>Cuando</Table.Cell>
                <Table.Cell>Archivo</Table.Cell>
                <Table.Cell collapsing>Filas</Table.Cell>
                <Table.Cell collapsing>Tamaño</Table.Cell>
                <Table.Cell collapsing />
              </Table.Row>
              {dumps.map((entry, index) => (
                <Table.Row key={entry.path} className="candystripe">
                  <Table.Cell collapsing className="text-nowrap">
                    {entry.at}
                  </Table.Cell>
                  <Table.Cell>
                    <Box inline style={{ fontFamily: 'monospace' }}>
                      {entry.name}
                    </Box>
                  </Table.Cell>
                  <Table.Cell
                    collapsing
                    className="text-right text-nowrap"
                    color={entry.truncated ? 'average' : undefined}
                  >
                    {count(entry.rows)} of {count(entry.total)}
                  </Table.Cell>
                  {/* BYOND measured this, so past 16 MB it is an estimate. It is a
                      "should you really click download" hint, not an accounting
                      figure. */}
                  <Table.Cell collapsing className="text-right text-nowrap">
                    ~{bytes(entry.size)}
                  </Table.Cell>
                  <Table.Cell collapsing>
                    <Button
                      icon="download"
                      onClick={() => act('download', { index: index + 1 })}
                    >
                      Descargar
                    </Button>
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          )}
        </Stack.Item>
      </Stack>
    </Section>
  );
}
