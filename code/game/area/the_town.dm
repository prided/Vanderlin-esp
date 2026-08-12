/area/indoors/town
	name = "interior"
	icon = 'icons/turf/areas/town.dmi'
	icon_state = "indoor_town"
	background_track = 'sound/music/area/indoor.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/field.ogg'
	converted_type = /area/outdoors/exposed/town

/area/outdoors/exposed/town
	icon_state = "town"
	background_track = 'sound/music/area/towngen.ogg'
	background_track_dusk = null
	background_track_night = 'sound/music/area/field.ogg'

/area/indoors/town/shop
	name = "tienda"
	icon_state = "shop"
	background_track = 'sound/music/area/shop.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/shop

/area/outdoors/exposed/shop
	icon_state = "shop"
	background_track = 'sound/music/area/shop.ogg'

/area/indoors/town/bath
	name = "baños"
	icon_state = "bath"
	background_track = 'sound/music/area/bath.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/bath

/area/outdoors/exposed/bath
	icon_state = "bath"
	background_track = 'sound/music/area/bath.ogg'

/*	..................   Areas to play with the music a bit   ................... */
/area/indoors/town/bath/redhouse // lets try something different
	background_track = 'sound/music/area/Fulminate.ogg'
	converted_type = /area/outdoors/exposed/bath/redhouse

/area/outdoors/exposed/bath/redhouse
	background_track = 'sound/music/area/Fulminate.ogg'

/area/indoors/town/tavern/saiga
	first_time_text = "El Borracho Saiga"
	background_track = 'sound/music/area/Folia1490.ogg'
	background_track_night = 'sound/music/area/LeTourdion.ogg'
	converted_type = /area/outdoors/exposed/tavern/saiga

/area/outdoors/exposed/tavern/saiga
	background_track = 'sound/music/area/Folia1490.ogg'
	background_track_night = 'sound/music/area/LeTourdion.ogg'

/area/indoors/town/garrison
	name = "guarnicion"
	icon_state = "garrison"
	background_track = 'sound/music/area/manorgarri.ogg'
	background_track_dusk = null
	background_track_night = null
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/manorgarri

/area/indoors/town/garrison/lieutenant
	name = "Teniente de la Guardia"

/area/indoors/town/cell
	name = "celda de la mazmorra"
	icon_state = "cell"
	ambient_index = AMBIENCE_DUNGEON
	ambient_index_night = AMBIENCE_DUNGEON
	background_track = 'sound/music/area/manorgarri.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/cell

/area/indoors/town/tavern
	name = "taberna"
	icon_state = "tavern"
	droning_index = DRONING_INDOORS
	droning_index_night = DRONING_INDOORS
	background_track = "sound/blank.ogg"
	background_track_dusk = "sound/blank.ogg"
	background_track_night = "sound/blank.ogg"
	converted_type = /area/outdoors/exposed/tavern

/area/outdoors/exposed/tavern
	name = "exterior de la taberna"
	icon_state = "tavern"

/area/indoors/town/church
	name = "iglesia"
	icon_state = "church"
	background_track = 'sound/music/area/church.ogg'
	background_track_dusk = null
	background_track_night = 'sound/music/area/churchnight.ogg'
	converted_type = /area/outdoors/exposed/church
	burial_grounds = TRUE

/area/outdoors/exposed/church
	name = "exterior de la iglesia"
	icon_state = "church"
	background_track = 'sound/music/area/church.ogg'
	background_track_dusk = null
	background_track_night = 'sound/music/area/churchnight.ogg'
	burial_grounds = TRUE

/area/outdoors/exposed/church/graveyard
	name = "cementerio de la iglesia"
	icon_state = "graveyard"
	first_time_text = "EL CEMENTERIO"

/area/indoors/town/church/chapel
	name = "sala de oracion"
	icon_state = "chapel"
	first_time_text = "LA CASA DE LOS DIEZ"

/area/indoors/town/church/crypt
	name = "cripta real"
	icon_state = "crypt"
	first_time_text = "LA CRIPTA REAL"

/area/indoors/town/church/inquisition
	name = "inquisicion"
	icon_state = "inquisition"
	first_time_text = "GUARIDA DE LA INQUISICION"

/area/indoors/town/fire_chamber
	name = "incinerador"
	icon_state = "fire_chamber"

/area/indoors/town/fire_chamber/can_craft_here()
	return FALSE

/area/indoors/town/warehouse
	name = "almacen de importaciones del muelle"
	icon_state = "warehouse"

/area/indoors/town/warehouse/can_craft_here()
	return FALSE

/area/indoors/town/vault
	name = "boveda"
	icon_state = "vault"

/area/indoors/town/vault/can_craft_here()
	return FALSE

/area/indoors/town/clocktower
	name = "Torre del Reloj"
	first_time_text = "Torre del Reloj"
	icon_state = "clocktower"
	background_track = 'sound/music/area/clocktower_ambience.ogg'

/area/indoors/town/orphanage
	name = "orfanato"
	first_time_text = "El orfanato"
	icon_state = "orphanage"

/area/indoors/town/clinic_large
	name = "La clinica"
	first_time_text = "La clinica"
	icon_state = "clinic_large"

/area/indoors/town/clinic_large/apothecary
	name = "taller del boticario"
	icon_state = "clinic_apoth"

/area/indoors/town/clinic_large/feldsher
	name = "consultorio del Feldsher"
	icon_state = "clinic_feld"

/area/indoors/town/thieves_guild
	name = "Gremio de Ladrones"
	first_time_text = "Gremio de Ladrones"
	icon_state = "thieves_guild"

/area/indoors/town/merc_guild
	name = "Gremio de Mercenarios"
	first_time_text = "Gremio de Mercenarios"
	icon_state = "merc_guild"
	background_track = 'sound/music/area/shop.ogg'
	background_track_dusk = null
	background_track_night = null

/area/indoors/town/adv_guild
	name = "Gremio de aventureros"
	first_time_text = "Gremio de aventureros"
	icon_state = "adv_guild"
	background_track = 'sound/music/area/shop.ogg'
	background_track_dusk = null
	background_track_night = null

/area/indoors/town/train_station
	name = "Estacion de tren"
	first_time_text = "Estacion de Tren de Vanderlin"
	icon_state = "train_station"

/area/indoors/town/steward
	name = "Oficina del mayordomo"
	first_time_text = "Oficina del mayordomo"
	icon_state = "steward"

/area/indoors/town/smithy
	name = "herreria"
	icon_state = "smithy"
	background_track = 'sound/music/area/dwarf.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "La Herreria"
	converted_type = /area/outdoors/exposed/dwarf

/area/indoors/town/dwarfin
	name = "Barrio de los Artesanos"
	icon_state = "dwarfin"
	background_track = 'sound/music/area/dwarf.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "El Barrio de los Artesanos"
	converted_type = /area/outdoors/exposed/dwarf

/area/outdoors/exposed/dwarf
	icon_state = "dwarf"
	background_track = 'sound/music/area/dwarf.ogg'
	background_track_dusk = null
	background_track_night = null


/area/indoors/town/theatre
	name = "teatro"
	icon_state = "manor"
	background_track = null
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/theatre

/area/outdoors/exposed/theatre
	name = "teatro"
	icon_state = "manor"
	background_track = null
	background_track_dusk = null
	background_track_night = null


///// OUTDOORS AREAS (again, for some reason)

/area/outdoors/town
	name = "exterior"
	icon = 'icons/turf/areas/town.dmi'
	icon_state = "town"
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/field.ogg'
	converted_type = /area/indoors/shelter/town
	threat_region = THREAT_REGION_TOWN

/area/outdoors/town/Initialize()
	. = ..()
	first_time_text = "[uppertext(SSmapping.config.map_name)]"

/area/indoors/shelter/town
	icon_state = "town"
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/field.ogg'

/area/outdoors/town/roofs
	name = "tejados"
	icon_state = "roofs"
	droning_index = DRONING_MOUNTAIN
	ambient_index = AMBIENCE_GENERIC
	background_track = 'sound/music/area/field.ogg'
	converted_type = /area/indoors/shelter/town/roofs

/area/indoors/shelter/town/roofs
	icon_state = "roofs"
	background_track = 'sound/music/area/field.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/field.ogg'


///// UNDERGROUND AREAS //////

/area/under/town
	name = "sotano"
	icon_state = "town"
	background_track = 'sound/music/area/catacombs.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/under/town

/area/outdoors/exposed/under/town
	icon_state = "town"
	background_track = 'sound/music/area/catacombs.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/town/sewer
	name = "alcantarilla"
	icon_state = "sewer"
	droning_index = DRONING_CAVE_WET
	ambient_index = AMBIENCE_RAT
	background_track = 'sound/music/area/sewers.ogg'
	background_track_dusk = null
	background_track_night = null
	custom_area_sound = 'sound/misc/stings/SewerSting.ogg'
	converted_type = /area/outdoors/exposed/under/sewer

/area/under/town/sewer/Initialize()
	. = ..()
	first_time_text = "ALCANTARILLAS DE [uppertext(SSmapping.config.map_name)]"

/area/outdoors/exposed/under/sewer
	icon_state = "sewer"
	background_track = 'sound/music/area/sewers.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/town/basement
	name = "sotano"
	icon_state = "basement"
	droning_index = DRONING_BASEMENT
	ambient_index = AMBIENCE_DUNGEON
	background_track = 'sound/music/area/catacombs.ogg'
	background_track_dusk = null
	background_track_night = null
	soundenv = 5
	converted_type = /area/outdoors/exposed/under/basement

/area/outdoors/exposed/under/basement
	icon_state = "basement"
	background_track = 'sound/music/area/catacombs.ogg'
	background_track_dusk = null
	background_track_night = null


/// Village stuff

// so you can teleport to the farm
/area/indoors/soilsons
	name = "soilsons"

/area/indoors/butchershop
	name = "carniceria"

/area/indoors/villagegarrison
	name = "guarnicion de la aldea"
	icon_state = "garrison"

/area/outdoors/farm
	name = "granja de los Soilson"
	icon_state = "farm"
	soundenv = 19
	background_track = 'sound/music/area/field.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/indoors/shelter/basin
