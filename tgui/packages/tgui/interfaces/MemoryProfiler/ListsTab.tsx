import { useState } from 'react';
import {
  Button,
  LabeledList,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';

import { useBackend } from '../../backend';
import { ByVarTable } from './ByVarTable';
import { bytes, count, exact, metaFor } from './format';
import { PerListTable } from './PerListTable';
import { EmptyState, ReportHeader, SkipBreakdown } from './parts';
import type { Data, ListsReport } from './types';

enum VIEW {
  /** One row per list, named by whoever holds it. */
  PerList = 'per_list',
  /** One row per type var, summed over every instance of that type. */
  ByVar = 'by_var',
}

function renderView(view: VIEW, report: ListsReport) {
  switch (view) {
    case VIEW.PerList:
      return <PerListTable report={report} />;
    case VIEW.ByVar:
      return <ByVarTable report={report} />;
    default:
      return exhaustiveCheck(view);
  }
}

export function ListsTab() {
  const { act, data } = useBackend<Data>();
  const { lists_report, busy, report_meta, panel_row_options } = data;
  // Held here rather than inside the two tables, so switching views does not
  // throw away the sort and filter you set on the other one.
  const [view, setView] = useState(VIEW.PerList);

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <ReportHeader
            label="Capturar listas"
            busy={busy}
            onCapture={() =>
              act('capture_lists', { rows: panel_row_options[1] })
            }
            meta={metaFor(report_meta, 'lists')}
          >
            <Stack align="center">
              <Stack.Item color="label">Principales</Stack.Item>
              {panel_row_options.map((option) => (
                <Stack.Item key={option}>
                  <Button
                    disabled={!!busy}
                    onClick={() => act('capture_lists', { rows: option })}
                  >
                    {count(option)}
                  </Button>
                </Stack.Item>
              ))}
            </Stack>
          </ReportHeader>
        </Section>
      </Stack.Item>
      {!lists_report ? (
        <Stack.Item>
          <EmptyState>
            Este suele ser el que quieres. Cada lista recibe el nombre de la var de datos, la lista global o contenedora que la contiene, por lo que una lista inflada apunta directamente al codigo que la contiene.
          </EmptyState>
        </Stack.Item>
      ) : (
        <>
          <Stack.Item>
            <Section>
              <LabeledList>
                <LabeledList.Item label="Listas en vivo">
                  {count(lists_report.lists_total)} holding{' '}
                  {bytes(lists_report.list_bytes)}
                </LabeledList.Item>
                <LabeledList.Item
                  label="Huerfanos"
                  color={
                    exact(lists_report.orphan_lists) > 0 ? 'average' : undefined
                  }
                >
                  {count(lists_report.orphan_lists)} alcanzado por una raiz sin nombre, ya sea una fuga real o una clase de almacenamiento que esta caminata pasa por alto
                </LabeledList.Item>
                <SkipBreakdown skipped={lists_report.skipped} />
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            {/* The row buttons above cap the per-list table only. The grouped
                view is one row per type var either way, so it is not paged. */}
            <Tabs fluid>
              <Tabs.Tab
                icon="list"
                selected={view === VIEW.PerList}
                onClick={() => setView(VIEW.PerList)}
              >
                Por lista
              </Tabs.Tab>
              <Tabs.Tab
                icon="layer-group"
                selected={view === VIEW.ByVar}
                onClick={() => setView(VIEW.ByVar)}
              >
                Por tipo var ({count(lists_report.groups_total)})
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          <Stack.Item grow>{renderView(view, lists_report)}</Stack.Item>
        </>
      )}
    </Stack>
  );
}
