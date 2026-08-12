/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const MAX_VISIBLE_MESSAGES = 2500;
export const MAX_PERSISTED_MESSAGES = 1000;
export const MESSAGE_SAVE_INTERVAL = 10000;
export const MESSAGE_PRUNE_INTERVAL = 60000;
export const COMBINE_MAX_MESSAGES = 5;
export const COMBINE_MAX_TIME_WINDOW = 5000;
export const IMAGE_RETRY_DELAY = 250;
export const IMAGE_RETRY_LIMIT = 10;
export const IMAGE_RETRY_MESSAGE_AGE = 60000;

// Default message type
export const MESSAGE_TYPE_UNKNOWN = 'unknown';

// Internal message type
export const MESSAGE_TYPE_INTERNAL = 'internal';

// Must match the set of defines in code/__DEFINES/chat.dm
export const MESSAGE_TYPE_SYSTEM = 'system';
export const MESSAGE_TYPE_LOCALCHAT = 'localchat';
export const MESSAGE_TYPE_RADIO = 'radio';
export const MESSAGE_TYPE_ENTERTAINMENT = 'entertainment';
export const MESSAGE_TYPE_INFO = 'info';
export const MESSAGE_TYPE_WARNING = 'warning';
export const MESSAGE_TYPE_DEADCHAT = 'deadchat';
export const MESSAGE_TYPE_OOC = 'ooc';
export const MESSAGE_TYPE_ADMINPM = 'adminpm';
export const MESSAGE_TYPE_COMBAT = 'combat';
export const MESSAGE_TYPE_ADMINCHAT = 'adminchat';
export const MESSAGE_TYPE_MODCHAT = 'modchat';
export const MESSAGE_TYPE_PRAYER = 'prayer';
export const MESSAGE_TYPE_EVENTCHAT = 'eventchat';
export const MESSAGE_TYPE_ADMINLOG = 'adminlog';
export const MESSAGE_TYPE_ATTACKLOG = 'attacklog';
export const MESSAGE_TYPE_DEBUG = 'debug';

type MessageType = {
  type: string;
  name: string;
  description: string;
} & Partial<{
  selector: string;
  important: boolean;
  admin: boolean;
}>;

// Metadata for each message type
export const MESSAGE_TYPES: MessageType[] = [
  // Always-on types
  {
    type: MESSAGE_TYPE_SYSTEM,
    name: 'System Messages',
    description: 'Mensajes de tu cliente, siempre habilitados',
    selector: '.boldannounce',
    important: true,
  },
  // Basic types
  {
    type: MESSAGE_TYPE_LOCALCHAT,
    name: 'Local',
    description: 'Mensajes locales en personaje (hablar, realizar acciones, etc.)',
    selector: '.say, .emote',
  },
  {
    type: MESSAGE_TYPE_INFO,
    name: 'Info',
    description: 'Mensajes no urgentes del juego y de los objetos',
    selector:
      '.notice:not(.pm), .info, .sinister, .cult, .infoplain, .announce, .hear, .smallnotice, .boldnotice',
  },
  {
    type: MESSAGE_TYPE_WARNING,
    name: 'Warnings',
    description: 'Mensajes urgentes del juego y de los objetos',
    selector:
      '.warning:not(.pm), .critical, .warning, .italics, .alertsyndie, .warningplain',
  },
  {
    type: MESSAGE_TYPE_DEADCHAT,
    name: 'Deadchat',
    description: 'Todo el chat muerto',
    selector: '.deadsay, .ghostalert',
  },
  {
    type: MESSAGE_TYPE_OOC,
    name: 'OOC',
    description: 'El muro azul de los mensajes OOC globales',
    selector: '.ooc, .adminooc, .adminobserverooc, .oocplain, .looc',
  },
  {
    type: MESSAGE_TYPE_ADMINPM,
    name: 'Admin PMs',
    description: 'Mensajes hacia/desde administradores (adminhelp)',
    selector: '.pm, .adminhelp',
  },
  {
    type: MESSAGE_TYPE_COMBAT,
    name: 'Combat Log',
    description: '¡Urist McTraitor te ha apuñalado con un cuchillo!',
    selector: '.danger, .userdanger, .crit',
  },
  {
    type: MESSAGE_TYPE_UNKNOWN,
    name: 'Unsorted',
    description: 'Todo lo que no pudimos ordenar, siempre habilitado.',
  },
  // Admin stuff
  {
    type: MESSAGE_TYPE_ADMINCHAT,
    name: 'Admin Chat',
    description: 'mensajes ASAY',
    selector: '.admin_channel, .adminsay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_PRAYER,
    name: 'Prayers',
    description: 'Oraciones de los jugadores',
    selector: '.prayer',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ADMINLOG,
    name: 'Admin Log',
    description: 'ADMIN LOG: Urist McAdmin has jumped to coordinates X, Y, Z',
    selector: '.admin',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ATTACKLOG,
    name: 'Attack Log',
    description: 'Urist McTraitor ha disparado a John Doe',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_DEBUG,
    name: 'Debug Log',
    description: 'DEBUG: Recuperacion del subsistema SSPlanets().',
    admin: true,
  },
];
