import { useState } from 'react';
import { NoticeBox, Stack, Tabs } from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { CompatTab } from './CompatTab';
import { DiffTab } from './DiffTab';
import { ListsTab } from './ListsTab';
import { Overview } from './Overview';
import { TypesTab } from './TypesTab';
import type { Data } from './types';
import { VarsTab } from './VarsTab';

enum TAB {
  Overview = 'overview',
  Types = 'types',
  Lists = 'lists',
  Vars = 'vars',
  Diff = 'diff',
  Compat = 'compat',
}

function renderTab(tab: TAB) {
  switch (tab) {
    case TAB.Overview:
      return <Overview />;
    case TAB.Types:
      return <TypesTab />;
    case TAB.Lists:
      return <ListsTab />;
    case TAB.Vars:
      return <VarsTab />;
    case TAB.Diff:
      return <DiffTab />;
    case TAB.Compat:
      return <CompatTab />;
    default:
      return exhaustiveCheck(tab);
  }
}

/** Anything that would make the numbers below a lie, said before you read them. */
function StatusBanner() {
  const { data } = useBackend<Data>();
  const { last_error, coverage } = data;

  return (
    <>
      {!!last_error && <NoticeBox danger>{last_error}</NoticeBox>}
      {!!coverage && !coverage.complete && (
        <NoticeBox danger>
          Cobertura parcial de tablas: {coverage.unavailable.join(', ')} no se pudo alcanzar en esta construcción, por lo que cada total en cada informe está corto por lo que vive en ellos. Consulte la pestaña Compatibilidad.
        </NoticeBox>
      )}
    </>
  );
}

export function MemoryProfiler() {
  const { data } = useBackend<Data>();
  const { enabled, error } = data;
  const [tab, setTab] = useState(TAB.Overview);

  return (
    <Window title="Perfilador de memoria" width={1100} height={760}>
      <Window.Content>
        {!enabled ? (
          <NoticeBox danger>
            byond_memprofile no está disponible: {error || 'unknown reason'}
          </NoticeBox>
        ) : (
          <Stack fill vertical>
            <Stack.Item>
              <StatusBanner />
            </Stack.Item>
            <Stack.Item>
              <Tabs fluid>
                <Tabs.Tab
                  icon="gauge"
                  selected={tab === TAB.Overview}
                  onClick={() => setTab(TAB.Overview)}
                >
                  Descripción general
                </Tabs.Tab>
                <Tabs.Tab
                  icon="sitemap"
                  selected={tab === TAB.Types}
                  onClick={() => setTab(TAB.Types)}
                >
                  Tipos
                </Tabs.Tab>
                <Tabs.Tab
                  icon="list"
                  selected={tab === TAB.Lists}
                  onClick={() => setTab(TAB.Lists)}
                >
                  Listas
                </Tabs.Tab>
                <Tabs.Tab
                  icon="tag"
                  selected={tab === TAB.Vars}
                  onClick={() => setTab(TAB.Vars)}
                >
                  Vars
                </Tabs.Tab>
                <Tabs.Tab
                  icon="scale-balanced"
                  selected={tab === TAB.Diff}
                  onClick={() => setTab(TAB.Diff)}
                >
                  diferencia
                </Tabs.Tab>
                <Tabs.Tab
                  icon="microscope"
                  selected={tab === TAB.Compat}
                  onClick={() => setTab(TAB.Compat)}
                >
                  compatible
                </Tabs.Tab>
              </Tabs>
            </Stack.Item>
            <Stack.Item grow>{renderTab(tab)}</Stack.Item>
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
}
