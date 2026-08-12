///// KEEP AREAS //////

/area/indoors/town/keep
	name = "Fortaleza"
	icon = 'icons/turf/areas/manor.dmi'
	icon_state = "manor"
	background_track = 'sound/music/area/manor.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/manorgarri

/area/indoors/town/keep/Initialize()
	. = ..()
	first_time_text = "LA FORTALEZA DE [uppertext(SSmapping.config.map_name)]"

/area/indoors/town/keep/thewall
	name = "muro de la fortaleza"
	icon_state = "wall"

/area/outdoors/town/keep
	name = "terrenos de la fortaleza"
	icon = 'icons/turf/areas/manor.dmi'
	icon_state = "manor_out"

/area/outdoors/town/keep/Initialize()
	. = ..()
	first_time_text = "[uppertext(SSmapping.config.map_name)]: TERRENOS DE LA FORTALEZA"

/area/outdoors/town/keep/roof
	name = "tejado de la fortaleza"
	icon_state = "manor_roof"

/area/indoors/town/keep/throne
	name = "Salon del Trono"
	icon_state = "throne"

/area/indoors/town/keep/lord_appt
	name = "Apartamento del Señor"
	icon_state = "lord_appt"

/area/indoors/town/keep/captain
	name = "habitacion del Capitan"
	icon_state = "captain"

/area/indoors/town/keep/hand
	name = "habitacion de la Mano"
	icon_state = "hand"

/area/indoors/town/keep/courtagent
	name = "escondite del Agente de la Corte"
	icon_state = "court agent"
	background_track = 'sound/music/area/manorgarri.ogg'
	background_track_dusk = null
	background_track_night = null

/area/indoors/town/keep/passages
	name = "pasadizos de la fortaleza"
	icon_state = "passage"

/area/indoors/town/keep/passages/basement
	name = "pasadizos de la fortaleza (sotano)"
	icon_state = "passage_base"
	converted_type = /area/outdoors/exposed

/area/indoors/town/keep/passages/groundfloor
	name = "pasadizos de la fortaleza (planta baja)"
	icon_state = "passage_ground"

/area/indoors/town/keep/passages/firstfloor
	name = "pasadizos de la fortaleza (primer piso)"
	icon_state = "passage_first"

/area/indoors/town/keep/passages/secondfloor
	name = "pasadizos de la fortaleza (segundo piso)"
	icon_state = "passage_second"

/area/indoors/town/keep/phys
	name = "consultorio del Medico de la Corte"
	icon_state = "physician"

/area/indoors/town/keep/heir
	name = "aposentos de los herederos"
	icon_state = "heir"

/area/indoors/town/keep/heir/heir1
	name = "Habitacion del primer heredero"
	icon_state = "heir1"

/area/indoors/town/keep/heir/heir2
	name = "Habitacion del segundo heredero"
	icon_state = "heir2"

/area/indoors/town/keep/knight
	name = "aposentos de los caballeros"
	icon_state = "knight"

/area/indoors/town/keep/knight/knight1
	name = "Cuartos del primer caballero"
	icon_state = "knight1"

/area/indoors/town/keep/knight/knight2
	name = "aposentos del segundo caballero"
	icon_state = "knight2"

/area/indoors/town/keep/squire
	name = "aposentos de los escuderos"
	icon_state = "squire"

/area/indoors/town/keep/squire/squire1
	name = "aposentos del primer escudero"
	icon_state = "squire1"

/area/indoors/town/keep/squire/squire2
	name = "aposentos del segundo escudero"
	icon_state = "squire2"

/area/indoors/town/keep/kitchen
	name = "cocina de la fortaleza"
	icon_state = "kitchen"

/area/indoors/town/keep/kitchen/cellar
	name = "bodega de la cocina de la fortaleza"
	icon_state = "kitchen"

/area/indoors/town/keep/servant
	name = "aposentos de los sirvientes"
	icon_state = "servant"

/area/indoors/town/keep/servanthead
	name = "aposentos del jefe de sirvientes"
	icon_state = "servant_head"

/area/indoors/town/keep/library
	name = "biblioteca de la fortaleza"
	icon_state = "library"

/area/indoors/town/keep/archivist
	name = "aposentos del archivista"
	icon_state = "archivists_quarters"

/area/indoors/town/keep/feast
	name = "salon de banquetes de la fortaleza"
	icon_state = "feast_hall"

/area/indoors/town/keep/dungeoneer
	name = "aposentos del Dungeoneer de la Corte"
	icon_state = "dungeoneer"

/area/indoors/town/keep/jester
	name = "Cuartos del bufon"
	icon_state = "jester"

/area/indoors/town/keep/guest
	name = "habitacion de invitados de la fortaleza"
	icon_state = "guest"

/area/indoors/town/keep/guest/guest1
	name = "habitacion de invitados 1 de la fortaleza"
	icon_state = "guest1"

/area/indoors/town/keep/guest/guest2
	name = "habitacion de invitados 2 de la fortaleza"
	icon_state = "guest2"

/area/indoors/town/keep/guest/guest3
	name = "Mantenga la habitacion de invitados 3"
	icon_state = "guest3"

/area/indoors/town/keep/guest/meeting
	name = "sala de reuniones de la fortaleza"
	icon_state = "meeting"

/area/indoors/town/keep/halls
	name = "salones de la fortaleza"
	icon_state = "halls"

/area/indoors/town/keep/halls/n
	name = "salones de la fortaleza (norte)"
	icon_state = "halls_n"

/area/indoors/town/keep/halls/e
	name = "salones de la fortaleza (este)"
	icon_state = "halls_e"

/area/indoors/town/keep/halls/s
	name = "salones de la fortaleza (sur)"
	icon_state = "halls_s"

/area/indoors/town/keep/halls/w
	name = "salones de la fortaleza (oeste)"
	icon_state = "halls_w"

/area/indoors/town/keep/garrison
	name = "guarnicion de la fortaleza"
	icon_state = "manorgarri"

/area/indoors/town/keep/gate
	name = "puerta de la fortaleza"
	icon_state = "manorgate"
	background_track = 'sound/music/area/manorgarri.ogg'
	background_track_dusk = null
	background_track_night = 'sound/music/area/deliverer.ogg'

/area/indoors/town/keep/basement
	name = "sotano de la fortaleza"
	icon_state = "manor_basement"
	converted_type = /area/outdoors/exposed

/area/indoors/town/keep/basement/royalknight
	name = "almacen de la Guardia Real"
	icon_state = "manor_knightstore"

/area/indoors/town/keep/basement/thepit
	name = "foso de ejecucion"
	icon_state = "manor_pit"

/area/indoors/town/keep/basement/wine
	name = "bodega real de vino"
	icon_state = "manor_wine"

/area/indoors/town/keep/basement/ale
	name = "bodega real de cerveza"
	icon_state = "manor_ale"

/area/indoors/town/keep/basement/bath
	name = "baños reales"
	icon_state = "manor_bath"

/area/outdoors/exposed/manorgarri
	icon_state = "manorgarri"
	background_track = 'sound/music/area/manor.ogg'
	background_track_dusk = null
	background_track_night = null

/area/outdoors/exposed/cell
	icon_state = "cell"
	background_track = 'sound/music/area/manorgarri.ogg'
	background_track_dusk = null
	background_track_night = null

/area/indoors/town/keep/magician
	name = "torre del mago"
	icon_state = "magiciantower"
	ambient_index = AMBIENCE_MYSTICAL
	background_track = 'sound/music/area/magiciantower.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/magiciantower

/area/outdoors/exposed/magiciantower
	icon_state = "magiciantower"
	background_track = 'sound/music/area/magiciantower.ogg'
	background_track_dusk = null
	background_track_night = null


// Minor Nobles
/area/indoors/town/noble_manor
	icon = 'icons/turf/areas/manor.dmi'
	icon_state = "noble"
	background_track = 'sound/music/area/manor.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/manorgarri

/area/outdoors/town/noble_manor
	icon = 'icons/turf/areas/manor.dmi'
	icon_state = "noble_out"

/area/indoors/town/noble_manor/blue
	name = "Mansion Noble Azul"
	icon_state = "noble1"

/area/outdoors/town/noble_manor/blue
	first_time_text = "Mansion Noble Azul"
	icon_state = "noble1_out"

/area/indoors/town/noble_manor/yellow
	name = "Mansion Noble Amarilla"
	icon_state = "noble2"

/area/outdoors/town/noble_manor/yellow
	icon_state = "noble2_out"
	first_time_text = "Mansion Noble Verde"

/area/indoors/town/noble_manor/red
	name = "Mansion Noble Roja"
	icon_state = "noble3"

/area/outdoors/town/noble_manor/red
	icon_state = "noble3_out"
	first_time_text = "Mansion Noble Roja"
