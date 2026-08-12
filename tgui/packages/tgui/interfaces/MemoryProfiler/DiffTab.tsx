import { sortBy } from 'es-toolkit';
import { useMemo, useState } from 'react';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';
import { createSearch } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { SearchBar } from '../common/SearchBar';
import {
  bytes,
  count,
  deltaColor,
  exact,
  metaFor,
  signedBytes,
  signedCount,
} from './format';
import { EmptyState, SortCell, TruncatedNotice, useSort } from './parts';
import type { Data, DiffRow } from './types';

type SortKey = 'typepath' | 'count_change' | 'bytes_change' | 'count_after';

function sortValue(row: DiffRow, key: SortKey): number | string {
  switch (key) {
    case 'typepath':
      return row.typepath;
    case 'count_change':
      return exact(row.count_change);
    case 'bytes_change':
      return exact(row.bytes_change);
    case 'count_after':
      return exact(row.count_after);
    default:
      return exhaustiveCheck(key);
  }
}

export function DiffTab() {
  const { act, data } = useBackend<Data>();
  const { diff_report, busy, report_meta, baseline_at, baseline_by } = data;
  const [search, setSearch] = useState('');
  const { sort, toggle } = useSort<SortKey>('bytes_change');

  const rows = useMemo(() => {
    if (!diff_report) {
      return [];
    }
    const searchFn = createSearch(search, (row: DiffRow) => row.typepath);
    const sorted = sortBy(diff_report.types.filter(searchFn), [
      (row) => sortValue(row, sort.key),
    ]);
    return sort.desc ? sorted.reverse() : sorted;
  }, [diff_report, search, sort]);

  const meta = metaFor(report_meta, 'diff');

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section title="Linea base">
          <Stack vertical>
            <Stack.Item>
              <Stack align="center">
                <Stack.Item>
                  <Button
                    icon="flag"
                    disabled={!!busy}
                    onClick={() => act('set_baseline')}
                  >
                    Establecer linea de base
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="scale-balanced"
                    disabled={!!busy || !baseline_at}
                    onClick={() => act('capture_diff')}
                  >
                    Diferencia con respecto a la linea de base
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button.Confirm
                    icon="trash"
                    color="bad"
                    disabled={!!busy}
                    onClick={() => act('clear')}
                  >
                    Limpiar
                  </Button.Confirm>
                </Stack.Item>
                <Stack.Item grow>
                  <Box color="label" textAlign="right">
                    {baseline_at
                      ? `baseline set by ${baseline_by} at ${baseline_at}`
                      : 'no baseline recorded'}
                    {meta
                      ? `, last walk froze the server for ${(meta.duration_ds / 10).toFixed(1)}s`
                      : ''}
                  </Box>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <NoticeBox info>
                El comienzo de la ronda contra el final de la ronda es lo que realmente encuentra una fuga; los numeros absolutos rara vez lo son. La extension mantiene exactamente una linea de base y cada diferencia instala una nueva, por lo que cada medida es consecutiva a partir de la anterior. El verbo Censo de Memoria (Texto) comparte esa linea de base con este panel.
              </NoticeBox>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      {!diff_report ? (
        <Stack.Item>
          <EmptyState>
            Establezca una linea de base, deje que la ronda se ejecute y luego diferencie. Los tipos que no se movieron se descartan y lo que queda se clasifica por crecimiento.
          </EmptyState>
        </Stack.Item>
      ) : diff_report.no_baseline ? (
        <Stack.Item>
          <NoticeBox color="yellow">
            Esa llamada solo registro una linea de base, por lo que no habia nada con que comparar. Vuelve a comparar para ver que se ha movido desde entonces.
          </NoticeBox>
        </Stack.Item>
      ) : (
        <>
          <Stack.Item>
            <Section>
              <LabeledList>
                <LabeledList.Item
                  label="Listas"
                  color={deltaColor(diff_report.list_count_change)}
                >
                  {signedCount(diff_report.list_count_change)} listas,{' '}
                  {signedBytes(diff_report.list_bytes_change)}
                </LabeledList.Item>
                <LabeledList.Item label="Tipos movidos">
                  {count(diff_report.types_total)}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <TruncatedNotice
              truncated={diff_report.types_truncated}
              shown={diff_report.types.length}
              total={diff_report.types_total}
              noun="changed typepaths"
            />
          </Stack.Item>
          <Stack.Item grow>
            <Section
              fill
              scrollable
              title="Rutas de tipo modificadas"
              buttons={
                <SearchBar
                  expensive
                  query={search}
                  onSearch={setSearch}
                  placeholder="Filtrar rutas de tipo..."
                  style={{ width: '20rem' }}
                />
              }
            >
              <Table>
                <Table.Row header>
                  <SortCell
                    active={sort.key === 'typepath'}
                    desc={sort.desc}
                    onClick={() => toggle('typepath')}
                  >
                    Ruta de tipo
                  </SortCell>
                  <SortCell
                    collapsing
                    active={sort.key === 'count_after'}
                    desc={sort.desc}
                    onClick={() => toggle('count_after')}
                  >
                    Instancias
                  </SortCell>
                  <SortCell
                    collapsing
                    active={sort.key === 'count_change'}
                    desc={sort.desc}
                    onClick={() => toggle('count_change')}
                  >
                    Cambiar
                  </SortCell>
                  <Table.Cell collapsing>bytes</Table.Cell>
                  <SortCell
                    collapsing
                    active={sort.key === 'bytes_change'}
                    desc={sort.desc}
                    onClick={() => toggle('bytes_change')}
                  >
                    Cambiar
                  </SortCell>
                </Table.Row>
                {rows.map((row) => (
                  <Table.Row key={row.typepath} className="candystripe">
                    <Table.Cell>{row.typepath}</Table.Cell>
                    <Table.Cell collapsing className="text-right text-nowrap">
                      {count(row.count_before)} to {count(row.count_after)}
                    </Table.Cell>
                    <Table.Cell
                      collapsing
                      className="text-right text-nowrap"
                      color={deltaColor(row.count_change)}
                    >
                      {signedCount(row.count_change)}
                    </Table.Cell>
                    <Table.Cell collapsing className="text-right text-nowrap">
                      {bytes(row.bytes_before)} to {bytes(row.bytes_after)}
                    </Table.Cell>
                    <Table.Cell
                      collapsing
                      className="text-right text-nowrap"
                      color={deltaColor(row.bytes_change)}
                    >
                      {signedBytes(row.bytes_change)}
                    </Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          </Stack.Item>
        </>
      )}
    </Stack>
  );
}
