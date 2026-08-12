/area/outdoors/bog
	name = "the bog"
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
	name = "bog dwelling"
	icon = 'icons/turf/areas/bog.dmi'
	icon_state = "bog_indoors"
	background_track = 'sound/music/area/bog.ogg'
	background_track_dusk = null
	background_track_night = null
	area_flags = VALID_TERRITORY | UNIQUE_AREA | BOGGY_AREA

// ###############
/area/outdoors/bog/e_highroad
	name = "the eastern highroad"
	first_time_text = "THE EASTERN HIGHROAD"
	custom_area_sound = 'sound/misc/stings/RosewoodSting.ogg'

/area/indoors/shelter/bog/e_highroad_camp
	name = "el campamento de la carretera oriental"

// ###############
/area/outdoors/bog/w_highroad
	name = "the western highroad"
	first_time_text = "THE WESTERN HIGHROAD"
	custom_area_sound = 'sound/misc/stings/RosewoodSting.ogg'

// ###############
/area/outdoors/bog/witch
	name = "isla de la bruja del pantano"
	icon_state = "bog_witch"
	first_time_text = "Bog Witch's Hut"

/area/indoors/shelter/bog/witch
	name = "bog witch's hut"
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
	name = "Central Terrorbog"

/area/outdoors/bog/east
	icon_state = "bog_east"
	name = "Eastern Terrorbog"

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
	name = "Southern Terrorbog"

/area/outdoors/bog/south/east
	icon_state = "bog_east"
	name = "Sudeste Terrorbog"

/area/outdoors/bog/south/west
	icon_state = "bog_west"
	name = "South-Western Terrorbog"

// ###############
/area/outdoors/bog/beach
	name = "Terrorbog Costa"
	icon_state = "bog_beach"
	first_time_text = "THE TERRORBOG COAST"

/area/outdoors/bog/beach/east
	name = "Costa Este Terrorbog"

/area/outdoors/bog/beach/west
	name = "Costa occidental Terrorbog"
