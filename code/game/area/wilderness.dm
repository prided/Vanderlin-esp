/area/outdoors/wilderness
	name = "murderwood"
	icon = 'icons/turf/areas/forest.dmi'
	icon_state = "woods"
	droning_index = DRONING_FOREST_DAY
	droning_index_night = DRONING_FOREST_NIGHT
	ambient_index = AMBIENCE_BIRDS
	ambient_index_night = AMBIENCE_FOREST
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'
	soundenv = 15
	ambush_times = list(NIGHT,DAWN,DUSK,DAY)
	ambush_types = list(
				/turf/open/floor/grass)

	ambush_mobs = list(
		new /datum/ambush_config/wolf_pack = 15,
		new /datum/ambush_config/lone_troll = 10,
		new /datum/ambush_config/troll_and_wolves = 8,
		new /datum/ambush_config/goblin_ambush_party = 15,
		new /datum/ambush_config/goblin_raid_party = 8,
		new /datum/ambush_config/raccoon_swarm = 20,
		new /datum/ambush_config/mole_pack = 15,
		new /datum/ambush_config/deserter_patrol = 12,
		new /datum/ambush_config/highwayman_duo = 10,
		new /datum/ambush_config/highwayman_gang = 6,
		new /datum/ambush_config/mixed_wildlife = 15,
	)
	first_time_text = "THE MURDERWOOD"
	custom_area_sound = 'sound/misc/stings/ForestSting.ogg'
	converted_type = /area/indoors/shelter/woods
	threat_region = THREAT_REGION_WOODS

/area/outdoors/wilderness/outpost
	icon_state = "outpost"
	threat_region = THREAT_REGION_NORTHERN_GROVE

/area/outdoors/wilderness/outpost/vanderlin
	name = "puesto de avanzada de Thatchwood"
	first_time_text = "Puesto de Avanzada de Thatchwood"
	threat_region = THREAT_REGION_NORTHERN_GROVE

/area/outdoors/wilderness/beside_thatchwood

/area/outdoors/wilderness/outpost/salem
	name = "puesto de avanzada de Salem"
	first_time_text = "Puesto de Avanzada de Salem"

/area/indoors/wilderness
	name = "interior - desierto"
	icon = 'icons/turf/areas/forest.dmi'
	icon_state = "indoorwild"
	droning_index = DRONING_INDOORS
	droning_index_night = DRONING_INDOORS

/area/indoors/wilderness/tavern
	name = "Cackleberry fermentada"
	icon_state = "tavern"
	first_time_text = "La Cackleberry Fermentada"
	background_track = "sound/blank.ogg"
	background_track_dusk = "sound/blank.ogg"
	background_track_night = "sound/blank.ogg"
	converted_type = /area/outdoors/exposed/tavern

/area/indoors/wilderness/garrison
	name = "guarnicion"
	icon_state = "garrison"
	background_track = 'sound/music/area/manorgarri.ogg'
	background_track_dusk = null
	background_track_night = null
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/manorgarri

/area/indoors/wilderness/shop
	name = "tienda"
	icon_state = "shop"
	background_track = 'sound/music/area/shop.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/shop

/area/indoors/wilderness/magic
	name = "torre del mago"
	icon = 'icons/turf/areas/manor.dmi'
	icon_state = "magiciantower"
	ambient_index = AMBIENCE_MYSTICAL
	background_track = 'sound/music/area/magiciantower.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/magiciantower

/area/indoors/wilderness/saint_crypt
	name = "Descanso del Santo"
	icon_state = "saint_crypt"
	ambient_index = AMBIENCE_DUNGEON
	ambient_index_night = AMBIENCE_DUNGEON
	background_track = 'sound/music/area/churchnight.ogg'
	first_time_text = "DESCANSO DEL SANTO"

/area/outdoors/wilderness/safe
	ambush_mobs = null
	icon_state = "woods_safe"

/area/outdoors/wilderness/safe/gallowband_fort
	name = "fortaleza de Gallowband"
	icon_state = "gallowband_outdoors"
	first_time_text = "Fortaleza de Gallowband"

/area/indoors/wilderness/gallowband
	name = "campamento de Gallowband"
	icon_state = "gallowband_indoors"

/area/indoors/wilderness/gallowband/garrison
	name = "fortaleza de Gallowband"
	icon_state = "gallowband_garrison"
	background_track = 'sound/music/area/manorgarri.ogg'
	converted_type = /area/outdoors/exposed/manorgarri

/area/indoors/wilderness/gallowband/garrison/gatehouse
	name = "garita de Gallowband"

/area/indoors/wilderness/gallowband/garrison/watchtower
	name = "torre de vigilancia de Gallowband"
	first_time_text = "Torre de Vigilancia de Gallowband"

/area/indoors/wilderness/gallowband/ship
	name = "barco de Gallowband"
	icon_state = "gallowband_ship"
	first_time_text = "Barco de Gallowband"

/area/indoors/wilderness/gallowband/cell
	name = "celda de Gallowband"
	icon_state = "cell"
	ambient_index = AMBIENCE_DUNGEON
	ambient_index_night = AMBIENCE_DUNGEON
	background_track = 'sound/music/area/manorgarri.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/cell
