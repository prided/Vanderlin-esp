type SortType = {
  label: string;
  propName: string;
  inDeciseconds: boolean;
};

export const SORTING_TYPES: readonly SortType[] = [
  {
    label: 'Alfabético',
    propName: 'name',
    inDeciseconds: false,
  },
  {
    label: 'Costo',
    propName: 'cost_ms',
    inDeciseconds: true,
  },
  {
    label: 'Orden inicial',
    propName: 'init_order',
    inDeciseconds: false,
  },
  {
    label: 'Última ejecución',
    propName: 'last_fire',
    inDeciseconds: false,
  },
  {
    label: 'Próxima ejecución',
    propName: 'next_fire',
    inDeciseconds: false,
  },
  {
    label: 'Uso por tick',
    propName: 'tick_usage',
    inDeciseconds: true,
  },
  {
    label: 'Uso promedio por tick',
    propName: 'usage_per_tick',
    inDeciseconds: true,
  },
  {
    label: 'Sobrecarga del subsistema',
    propName: 'overtime',
    inDeciseconds: true,
  },
];
