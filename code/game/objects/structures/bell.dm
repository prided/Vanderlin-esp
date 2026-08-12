/obj/structure/warningbell
	name = "Campana de advertencia"
	desc = "Una gran campana solia advertir a todos los que se encontraban en las proximidades de un peligro inminente."
	icon = 'icons/roguetown/misc/96x96.dmi'  // Ensure you have an appropriate icon for the bell
	icon_state = "churchbell"
	density = FALSE
	anchored = TRUE
	var/last_ring_time = 0
	var/ring_cooldown = 50 // Cooldown in deciseconds before the bell can be rung again
	var/ring_range = 50    // Define the range within which players will be alerted

/obj/structure/warningbell/attack_hand(mob/user)
	if(world.time < last_ring_time + ring_cooldown)
		to_chat(user, "<span class='warning'>La campana todavia esta resonando desde el ultimo toque.</span>")
		return

	// Ring the bell
	last_ring_time = world.time
	user.visible_message(
		"<span class='notice'>[user] suena la [src]</span>.",
		"<span class='notice'>Llamas al [src].</span>"
	)

	// Play bell sound for everyone in the vicinity
	playsound(src, 'sound/misc/deadbell.ogg', 100, TRUE)

	// Alert all players in the area
	var/list/nearby_players = get_hearers_in_view(ring_range, src)
	for(var/mob/M in nearby_players)
		if(ismob(M))
			to_chat(M, "<span class='warning'>Alerta! ¡La campana de advertencia suena siniestramente, indicando peligro cercano!</span>")


/obj/structure/warningbell/townhall
	name = "Campana del Ayuntamiento"
	desc = "Una gran campana solia convocar a la gente del pueblo a reunirse."
	icon = 'icons/roguetown/misc/96x96.dmi'  // Ensure you have an appropriate icon for the bell

/obj/structure/warningbell/townhall/attack_hand(mob/user)
	if(world.time < last_ring_time + ring_cooldown)
		to_chat(user, "<span class='warning'>La campana todavia esta resonando desde el ultimo toque.</span>")
		return

	// Ring the bell
	last_ring_time = world.time
	user.visible_message(
		"<span class='notice'>[user] suena la [src]</span>.",
		"<span class='notice'>Llamas al [src].</span>"
	)

	// Play bell sound for everyone in the vicinity
	playsound(src, 'sound/misc/deadbell.ogg', 100, TRUE)

	// Alert all players in the area
	var/list/nearby_players = get_hearers_in_view(ring_range, src)
	for(var/mob/M in nearby_players)
		if(ismob(M))
			to_chat(M, "<span class='warning'>La campana del ayuntamiento repiquetea, convocando a los habitantes del pueblo a la taberna para una reunion.</span>")
