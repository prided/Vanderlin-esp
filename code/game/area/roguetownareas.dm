/area
	name = "roguetown"
	icon_state = "rogue"

/area/oob
	name = "Fuera de limites"

/area/indoors
	name = "interior de Roguetown"
	icon_state = "indoors"
	droning_index = DRONING_INDOORS
	ambient_index = AMBIENCE_GENERIC
	background_track = 'sound/music/area/indoor.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	plane = INDOOR_PLANE
	converted_type = /area/outdoors

/area/indoors/cave
	name = "cueva de ingreso tardio"
	icon_state = "cave"
	droning_index = DRONING_CAVE_GENERIC
	soundenv = 8

/area/indoors/cave/late/can_craft_here()
	return FALSE

///// OUTDOORS AREAS //////

/area/outdoors
	name = "al aire libre roguetown"
	icon_state = "outdoors"
	outdoors = TRUE
	droning_index = DRONING_TOWN_DAY
	droning_index_night = DRONING_TOWN_NIGHT
	ambient_index = AMBIENCE_BIRDS
	ambient_index_night = AMBIENCE_GENERIC
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/indoors/shelter

/area/indoors/shelter
	icon_state = "shelter"
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'

/area/outdoors/mountains
	name = "montañas"
	icon_state = "mountains"
	droning_index = DRONING_MOUNTAIN
	ambient_index = AMBIENCE_GENERIC
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	soundenv = 17
	converted_type = /area/indoors/shelter/mountains

/area/indoors/shelter/mountains
	icon_state = "mountains"
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'

/area/outdoors/mountains/deception
	name = "engaño"
	icon_state = "deception"
	first_time_text = "EL CAÑON DEL ENGAÑO"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				new /datum/ambush_config/pair_of_direbear = 10,
				new /datum/ambush_config/trio_of_highwaymen = 10,
				new /datum/ambush_config/singular_minotaur = 10,
				new /datum/ambush_config/duo_minotaur = 5,
				new /datum/ambush_config/solo_treasure_hunter = 15,
				new /datum/ambush_config/duo_treasure_hunter = 2,
				new /datum/ambush_config/medium_skeleton_party = 10,
				new /datum/ambush_config/heavy_skeleton_party = 5,
				)
	threat_region = THREAT_REGION_MOUNT_DECAP

/area/outdoors/mountains/decap
	name = "monte de la Decapitacion"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				new /datum/ambush_config/pair_of_direbear = 10,
				new /datum/ambush_config/trio_of_highwaymen = 10,
				new /datum/ambush_config/singular_minotaur = 10,
				new /datum/ambush_config/duo_minotaur = 5,
				new /datum/ambush_config/solo_treasure_hunter = 15,
				new /datum/ambush_config/duo_treasure_hunter = 2,
				new /datum/ambush_config/medium_skeleton_party = 10,
				new /datum/ambush_config/heavy_skeleton_party = 5,
				)
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "YUNQUE DE MALUM"
	custom_area_sound = 'sound/misc/stings/MalumSting.ogg'
	ambush_times = list(NIGHT,DAWN,DUSK,DAY)

	converted_type = /area/indoors/shelter/mountains/decap
	threat_region = THREAT_REGION_MOUNT_DECAP

/area/indoors/shelter/mountains/decap
	icon_state = "decap"
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null
	threat_region = THREAT_REGION_MOUNT_DECAP

/area/outdoors/open_sky
	name = "cielo abierto"
	icon_state = "sky"

/area/outdoors/basin
	name = "cuenca de la ciudad"
	icon_state = "basin"
	soundenv = 19
	ambush_times = list(DAWN,NIGHT,DUSK)
	ambush_types = list(
				/turf/open/floor/grass)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/wolf = 60,
				/mob/living/carbon/human/species/goblin/npc/ambush/hell = 50,
				/mob/living/carbon/human/species/goblin/npc/ambush/sea = 50,
				/mob/living/carbon/human/species/goblin/npc/ambush = 50)
	background_track = 'sound/music/area/field.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/indoors/shelter/basin
	threat_region = THREAT_REGION_BASIN

/area/outdoors/basin/Initialize()
	. = ..()
	first_time_text = "CUENCA DE [uppertext(SSmapping.config.map_name)]"

/area/outdoors/basin/safe
	icon_state = "basin_safe"
	ambush_mobs = null

/area/indoors/shelter/basin
	icon_state = "basin"
	background_track = 'sound/music/area/field.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	threat_region = THREAT_REGION_BASIN

/area/indoors/shelter/woods
	icon_state = "woods"
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'

/area/outdoors/woods_safe
	name = "bosque"
	icon_state = "woods"
	droning_index = DRONING_FOREST_DAY
	droning_index_night = DRONING_FOREST_NIGHT
	ambient_index = AMBIENCE_BIRDS
	ambient_index_night = AMBIENCE_FOREST
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'
	soundenv = 15
	converted_type = /area/indoors/shelter/woods

/area/outdoors/river
	name = "rio"
	icon_state = "river"
	droning_index = DRONING_RIVER_DAY
	droning_index_night = DRONING_RIVER_NIGHT
	ambient_index = AMBIENCE_FROG
	ambient_index_night = AMBIENCE_FOREST
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'
	converted_type = /area/indoors/shelter/woods

/area/outdoors/beach
	name = "Llanto de Sophia"
	icon_state = "beach"
	droning_index = DRONING_LAKE
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'

	ambush_mobs = list(
		/mob/living/carbon/human/species/goblin/npc/ambush/sea = 20,
		new /datum/ambush_config/triple_deepone = 30,
		new /datum/ambush_config/deepone_party = 20,
	)

	threat_region = THREAT_REGION_COAST

/area/outdoors/eora
	name = "arboleda eoran"
	icon_state = "eora"
	droning_index = DRONING_FOREST_DAY
	background_track = 'sound/music/area/eora.ogg'
	background_track_dusk =  'sound/music/area/eora.ogg'
	background_track_night = 'sound/music/area/eora.ogg'

//// UNDER AREAS (no indoor rain sound usually)

// these don't get a rain sound because they're underground
/area/under
	name = "sotano"
	icon_state = "under"
	background_track = 'sound/music/area/towngen.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'
	soundenv = 8
	plane = INDOOR_PLANE
	converted_type = /area/outdoors/exposed

/area/outdoors/exposed
	icon_state = "exposed"
	background_track = 'sound/music/area/towngen.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'

/area/under/cave
	name = "cueva"
	icon_state = "cave"
	droning_index = DRONING_CAVE_GENERIC
	ambient_index = AMBIENCE_CAVE
	background_track = 'sound/music/area/caves.ogg'
	background_track_dusk = null
	background_track_night = null
	ambush_times = list(NIGHT,DAWN,DUSK,DAY)
	ambush_types = list(
		/turf/open/floor/dirt,
		/turf/open/water,)
	ambush_mobs = list(
		/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
		/mob/living/carbon/human/species/goblin/npc/ambush/cave = 20,
		/mob/living/carbon/human/species/skeleton/npc/ambush = 10)
	converted_type = /area/outdoors/caves

/area/outdoors/caves
	icon_state = "caves"
	background_track = 'sound/music/area/caves.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/cavewet
	name = "cueva humeda"
	icon_state = "cavewet"
	droning_index = DRONING_CAVE_WET
	ambient_index = AMBIENCE_CAVE
	background_track = 'sound/music/area/caves.ogg'
	background_track_dusk = null
	background_track_night = null
	ambush_times = list(NIGHT,DAWN,DUSK,DAY)
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
				/mob/living/carbon/human/species/goblin/npc/sea = 20)
	converted_type = /area/outdoors/caves

/area/under/cave/spider
	icon_state = "spider"
	first_time_text = "ARAIGNEE"
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/spider = 100)
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/spidercave

/area/outdoors/spidercave
	icon_state = "spidercave"
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/spiderbase
	name = "guarida de arañas"
	droning_index = DRONING_BASEMENT
	droning_index_night = DRONING_BASEMENT
	icon_state = "spiderbase"
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/spidercave

/area/outdoors/spidercave
	icon_state = "spidercave"
	background_track = 'sound/music/area/spidercave.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/cavelava
	name = "cueva de lava"
	icon_state = "cavelava"
	first_time_text = "ARTERIA DE MALUM"
	droning_index = DRONING_CAVE_LAVA
	ambient_index = AMBIENCE_CAVE
	ambush_times = list(NIGHT,DAWN,DUSK,DAY)
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/carbon/human/species/goblin/npc/hell = 20)
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null
	converted_type = /area/outdoors/exposed/decap

/area/under/cavelava/acid
	name = "cueva de lava"
	icon_state = "cavelava"
	first_time_text = null
	ambush_types = null
	converted_type = null

/area/outdoors/exposed/decap
	icon_state = "decap"
	background_track = 'sound/music/area/decap.ogg'
	background_track_dusk = null
	background_track_night = null

/area/under/lake
	name = "lago subterraneo"
	icon_state = "lake"
	droning_index = DRONING_LAKE
	ambient_index = AMBIENCE_CAVE
	ambient_index_night = AMBIENCE_GENERIC

/area/indoors/ship
	name = "el barco"
	droning_index = DRONING_LAKE
	droning_index_night = DRONING_LAKE
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/night.ogg'

/area/outdoors/coast
	name = "la costa"
	droning_index = DRONING_LAKE
	droning_index_night = DRONING_LAKE
	background_track = 'sound/music/area/sargoth.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'


///// UNDERWORLD AREAS //////

/area/underworld
	name = "inframundo"
	icon_state = "underworld"
	background_track = 'sound/music/area/underworlddrone.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "El bosque del arrepentimiento"

/area/underworld/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(!iscarbon(arrived))
		return
	RegisterSignal(arrived, COMSIG_EMOTE_PRAY, PROC_REF(on_underworld_prayer))

/area/underworld/Exited(atom/movable/gone, direction)
	. = ..()
	if(!iscarbon(gone))
		return
	UnregisterSignal(gone, COMSIG_EMOTE_PRAY)

/area/underworld/proc/on_underworld_prayer(mob/living/carbon/damned, message)
	// Who do the underworld spirits pray to? Good question
	. |= CARBON_PRAY_CANCEL

	if(!damned || !message)
		return

	var/static/list/profane_words = list("zizo","cock","dick","fuck","shit","pussy","cuck","cunt","asshole")
	var/prayer = SANITIZE_HEAR_MESSAGE(message)

	for(var/profanity in profane_words)
		if(findtext(prayer, profanity))
			//put this idiot SOMEWHERE
			var/static/list/unsafe_turfs = list(
				/turf/open/floor/underworld/space,
				/turf/open/openspace,
			)

			var/static/list/turfs = list()
			if(!length(turfs)) //there are a lot of turfs, let's only do this once
				for(var/turf/turf in src)
					if(turf.density)
						continue
					if(is_type_in_list(turf, unsafe_turfs))
						continue
					turfs.Add(turf)

			var/turf/safe_turf = safepick(turfs)
			if(!safe_turf) //fuck
				return

			damned.forceMove(safe_turf)
			to_chat(damned, "<font color='yellow'>MISERABLE INSOLENTE, TU LUCHA CONTINUA</font>")
			return

	if(length(prayer) <= 15)
		to_chat(damned, span_danger("Mi oracion fue un poco corta..."))
		return

	if(findtext(prayer, damned.patron.name))
		damned.playsound_local(damned, 'sound/misc/notice (2).ogg', 100, FALSE)
		to_chat(damned, "<font color='yellow'>Yo, [damned.patron], he escuchado tu plegaria, pero no puedo ayudarte.</font>")

///// DAKKATOWN AREAS //////

// Players should be fined for any damage they do to the Guild's property
/area/outdoors/beach/boat
	name = "Llanto de Sophia"
	droning_index = DRONING_LAKE
	droning_index_night = DRONING_LAKE
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'


///// ANTAGONIST AREAS //////  - used on centcom so you can teleport there easily. Each antag area just gets one unique type, if its outdoor use generic indoors, vice versa, to avoid clutter in area list

/area/indoors/bandit_lair
	name = "guarida (bandidos)"

/area/indoors/vampire_manor
	name = "guarida (Señor Vampiro)"

/area/outdoors/bog/inhumen_camp
	name = "guarida (Inhumen)"
	background_track = 'sound/music/area/decap.ogg'
	first_time_text = "LA CIENAGA PROFUNDA"

/area/indoors/shelter/bog/inhumen_camp
	name = "guarida (Inhumen) (interior)"
	background_track = 'sound/music/area/decap.ogg'

/area/indoors/lich
	name = "guarida (Lich)"
	background_track = 'sound/music/area/churchnight.ogg'

/area/delver
	delver_restrictions = TRUE
	converted_type = /area/delver

/area/ship/topdeck
	name = "upperdeck"
	icon_state = "roofs"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/topdeckdrone.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "The Voyager"
	outdoors = TRUE

/area/ship/middeck
	name = "cubierta media"
	icon_state = "indoors"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/topdeckdrone.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "cubierta central"

/area/ship/nobledeck
	name = "cubierta noble"
	icon_state = "manor"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/nobledeckdrone.ogg'
	background_track_dusk = null
	background_track_night = null

/area/ship/shipbrig
	name = "calabozo del barco"
	icon_state = "cell"
	droning_index = DRONING_BOAT
	background_track = 'sound/music/area/shipbrig.ogg'
	background_track_dusk = null
	background_track_night = null
	first_time_text = "El calabozo"
