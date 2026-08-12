/area/outdoors/bog
	name = "la cienaga"
	icon = 'icons/turf/areas/bog.dmi'
	icon_state = "bog"
	droning_index = DRONING_BOG_DAY
	droning_index_night = DRONING_BOG_NIGHT
	ambient_index = AMBIENCE_FROG
	ambient_index_night = AMBIENCE_GENERIC
	background_track = 'sound/music/area/bog.ogg'
	background_track_dusk = null
	background_track_night = null
	ambush_times = list(NIGHT,DAWN,DUSK,DAY)
	ambush_types = list(
				/turf/open/floor/dirt,
				/turf/open/water)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/bigrat = 20,
				/mob/living/simple_animal/hostile/retaliate/spider = 80,
				/mob/living/carbon/human/species/goblin/npc/ambush/sea = 50,
				/mob/living/simple_animal/hostile/retaliate/troll/bog = 35,
				new /datum/ambush_config/bog_guard_deserters = 50,
				new /datum/ambush_config/bog_guard_deserters/hard = 25,
				new /datum/ambush_config/mirespiders_ambush = 110,
				new /datum/ambush_config/mirespiders_crawlers = 25,
				new /datum/ambush_config/mirespiders_aragn = 10,
				new /datum/ambush_config/mirespiders_unfair = 5)

	first_time_text = "EL TERRORBOG"
	custom_area_sound = 'sound/misc/stings/BogSting.ogg'
	converted_type = /area/indoors/shelter/bog
	threat_region = THREAT_REGION_TERRORBOG
	area_flags = VALID_TERRITORY | UNIQUE_AREA | BOGGY_AREA

/area/indoors/shelter/bog
	name = "refugio de la cienaga"
	icon = 'icons/turf/areas/bog.dmi'
	icon_state = "bog_indoors"
	background_track = 'sound/music/area/bog.ogg'
	background_track_dusk = null
	background_track_night = null
	area_flags = VALID_TERRITORY | UNIQUE_AREA | BOGGY_AREA

// ###############
/area/outdoors/bog/e_highroad
	name = "el camino real oriental"
	first_time_text = "EL CAMINO REAL ORIENTAL"
	custom_area_sound = 'sound/misc/stings/RosewoodSting.ogg'

/area/indoors/shelter/bog/e_highroad_camp
	name = "el campamento de la carretera oriental"

// ###############
/area/outdoors/bog/w_highroad
	name = "el camino real occidental"
	first_time_text = "EL CAMINO REAL OCCIDENTAL"
	custom_area_sound = 'sound/misc/stings/RosewoodSting.ogg'

// ###############
/area/outdoors/bog/witch
	name = "isla de la bruja del pantano"
	icon_state = "bog_witch"
	first_time_text = "Cabaña de la Bruja del Pantano"

/area/indoors/shelter/bog/witch
	name = "cabaña de la Bruja del Pantano"
	icon_state = "bog_witch_indoors"

// ###############
/area/outdoors/bog/lich
	name = "Torre Oscura"
	icon_state = "lichtower"
	first_time_text = "Torre Oscura"

/area/indoors/shelter/bog/lich
	name = "Torre Oscura"
	icon_state = "lichtower_indoors"

// ###############
/area/outdoors/bog/central
	name = "Terrorbog central"

/area/outdoors/bog/east
	icon_state = "bog_east"
	name = "Terrorbog oriental"

/area/outdoors/bog/west
	icon_state = "bog_west"
	name = "Occidental Terrorbog"

// ###############
/area/outdoors/bog/north
	name = "Norte Terrorbog"

/area/outdoors/bog/north/east
	icon_state = "bog_east"
	name = "Noreste Terrorbog"

/area/outdoors/bog/north/west
	icon_state = "bog_west"
	name = "Noroeste Terrorbog"

// ###############
/area/outdoors/bog/south
	name = "Terrorbog meridional"

/area/outdoors/bog/south/east
	icon_state = "bog_east"
	name = "Sudeste Terrorbog"

/area/outdoors/bog/south/west
	icon_state = "bog_west"
	name = "Terrorbog sudoccidental"

// ###############
/area/outdoors/bog/beach
	name = "Terrorbog Costa"
	icon_state = "bog_beach"
	first_time_text = "LA COSTA DE TERRORBOG"

/area/outdoors/bog/beach/east
	name = "Costa Este Terrorbog"

/area/outdoors/bog/beach/west
	name = "Costa occidental Terrorbog"
