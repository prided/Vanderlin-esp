import {
  Box,
  Icon,
  LabeledList,
  NoticeBox,
  Section,
  Table,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { bytes, count, exact } from './format';
import type { Footer, StorageRow } from './types';

function Flag(props: { set: BooleanLike; children: string }) {
  const { set, children } = props;

  return (
    <Box inline mr={2} color={set ? 'good' : 'average'}>
      <Icon name={set ? 'check' : 'xmark'} mr={0.5} />
      {children}
    </Box>
  );
}

type StorageMeta = {
  label: string;
  /** What the crate's text report prints in place of a number when this pass
   * did not run - not walked for a skipped walk, not resolved for a table
   * whose globals never came back. */
  missing: string;
  /** No live count to show, only bytes. */
  countless?: boolean;
  note?: string;
};

/**
 * Display names, keyed by the crate's stable label.
 *
 * Falls back to the raw key for anything unrecognised, so a storage class added
 * on the extension side still renders rather than vanishing from a section whose
 * whole job is disclosure.
 */
const STORAGE_META: Record<string, StorageMeta> = {
  table_pointer_arrays: {
    label: 'Matrices de punteros de tabla',
    missing: 'sin recorrer',
    countless: true,
    note: 'Four bytes per slot of every table this walk reaches, live or not. Counted once here rather than folded into the rows below.',
  },
  alist_records: { label: 'Registros alist', missing: 'sin recorrer' },
  alist_trees: { label: 'Arboles alist', missing: 'sin recorrer' },
  turf_var_nodes: { label: 'Nodos var de turfs', missing: 'sin recorrer' },
  string_table: {
    label: 'tabla de cadenas',
    missing: 'no resuelto',
    note: "Live entries only. A dead slot is a null pointer with nothing behind it, so it costs nothing here - BYOND's own report charges 32 B for one because it synthesizes a fallback entry rather than reading the raw table.",
  },
  suspended_proc_frames: {
    label: 'Marcos de proceso suspendidos',
    missing: 'sin recorrer',
    note: 'The frame itself only. Its parent_context chain, the proc queue and the destructor table are not walked, and neither is anything currently running.',
  },
};

/**
 * Which storage classes actually got charged this run.
 *
 * A zero here means one of two completely different things, so the state column
 * is the point of the table rather than a decoration.
 */
function StorageTable(props: { rows?: StorageRow[] }) {
  const { rows } = props;

  if (!rows?.length) {
    return (
      <Box color="label">
        Este censo no incluye un desglose del almacenamiento, por lo que se desconoce cuanto cobro la extension mas alla de instancias y listas.
      </Box>
    );
  }

  return (
    <Table>
      <Table.Row header>
        <Table.Cell>Almacenamiento</Table.Cell>
        <Table.Cell collapsing>Activos</Table.Cell>
        <Table.Cell collapsing>bytes</Table.Cell>
      </Table.Row>
      {rows.map((row) => {
        const meta = STORAGE_META[row.label];

        return (
          <Table.Row key={row.label} className="candystripe">
            <Table.Cell>
              {meta ? meta.label : row.label}
              {!!meta?.note && (
                <Tooltip content={meta.note}>
                  <Icon name="circle-info" ml={1} color="label" />
                </Tooltip>
              )}
            </Table.Cell>
            <Table.Cell collapsing className="text-right text-nowrap">
              {row.walked && !meta?.countless ? count(row.count) : ''}
            </Table.Cell>
            <Table.Cell collapsing className="text-right text-nowrap">
              {row.walked ? (
                bytes(row.bytes)
              ) : (
                <Box inline color="average">
                  {meta ? meta.missing : 'not walked'}
                </Box>
              )}
            </Table.Cell>
          </Table.Row>
        );
      })}
    </Table>
  );
}

/**
 * What the numbers above do not include.
 *
 * Every total in every report is partial, and the difference between a useful
 * profiler and a misleading one is whether it says so on the same screen.
 */
export function Honesty(props: { footer: Footer }) {
  const { footer } = props;

  return (
    <Section title="Lo que estos numeros omiten">
      {!footer.bytes_available && (
        <NoticeBox danger>
          Los informes de bytes no estan disponibles en esta plataforma, por lo que cada recuento de bytes en cada informe se lee como cero. Los recuentos de instancias y elementos siguen siendo reales.
        </NoticeBox>
      )}
      <LabeledList>
        <LabeledList.Item label="No contado">
          {footer.exclusions}
        </LabeledList.Item>
        <LabeledList.Item label="Fuentes huerfanas">
          {footer.orphan_sources}
        </LabeledList.Item>
        <LabeledList.Item
          label="Sin costo"
          color={exact(footer.uncosted_instances) > 0 ? 'average' : undefined}
        >
          {count(footer.uncosted_instances)} los casos se contaron sin un tamaño de base verificado para cobrar. Cada tipo al que llega esta caminata tiene uno, por lo que cualquier tipo distinto de cero es un tipo que se envio sin un tamaño rastreado.
        </LabeledList.Item>
        <LabeledList.Item label="Esta ejecucion">
          <Flag set={footer.bytes_available}>bytes</Flag>
          <Flag set={footer.image_base_verified}>base de imagen</Flag>
          <Flag set={footer.turfs_walked}>turfs recorridos</Flag>
          <Flag set={footer.alists_walked}>alists recorridos</Flag>
        </LabeledList.Item>
      </LabeledList>
      <Section title="El almacenamiento cargo esta ejecucion">
        <StorageTable rows={footer.storage} />
      </Section>
    </Section>
  );
}
