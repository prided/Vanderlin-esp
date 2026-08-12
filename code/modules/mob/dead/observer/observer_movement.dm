/mob/dead/observer/down()
	set name = "Bajar"
	set category = "IC"

	if(zMove(DOWN, z_move_flags = ZMOVE_FEEDBACK))
		to_chat(src, span_notice("Te mueves hacia abajo."))

/mob/dead/observer/up()
	set name = "Subir"
	set category = "IC"

	if(zMove(UP, z_move_flags = ZMOVE_FEEDBACK))
		to_chat(src, span_notice("Te mueves hacia arriba."))

/mob/dead/observer/can_z_move(direction, turf/start, turf/destination, z_move_flags = NONE, mob/living/rider)
	z_move_flags |= ZMOVE_IGNORE_OBSTACLES  //observers do not respect these FLOORS you speak so much of.
	return ..()
