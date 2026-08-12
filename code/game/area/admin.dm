/area/indoors/town/church/dreamcave
	name = "La Cueva de los Sueños"
	icon = 'icons/turf/areas/manor.dmi'
	icon_state = "magician"
	ambient_index = AMBIENCE_MYSTICAL
	first_time_text = "La Cueva de los Sueños"
	background_track = 'sound/music/area/magiciantower.ogg'
	outdoors = FALSE
	alpha = 0

/area/indoors/town/church/dreamcave/starchamber
	name = "La Camara Estelar"
	first_time_text = "La Camara Estelar"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NO_TELEPORT

/area/indoors/town/church/dreamcave/starchamber/can_craft_here()
	return FALSE
