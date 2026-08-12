/obj/machinery/light/fueled/lanternpost
	name = "poste de linterna"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "streetlantern1"
	base_state = "streetlantern"
	brightness = 5
	density = FALSE
	var/obj/item/flashlight/flare/torch/torchy
	fueluse = 0 //we use the torch's fuel
	soundloop = null
	crossfire = FALSE
	plane = GAME_PLANE_UPPER
	cookonme = FALSE
	temperature_change = 10
	fog_parter_effect = null
	var/permanent

/obj/machinery/light/fueled/lanternpost/fixed
	desc = "La farola esta integrada permanentemente en la estructura de esta."
	permanent = TRUE

/obj/machinery/light/fueled/lanternpost/unfixed
	desc = "Un poste de madera al que se le puede colocar una lampara o un lazo."
	permanent = FALSE
	on = FALSE

/obj/machinery/light/fueled/lanternpost/seton(s)
	. = ..()
	if(!torchy || torchy.fuel <= 0)
		on = FALSE
		set_light_on(on)

/obj/machinery/light/fueled/lanternpost/fire_act(added, maxstacks)
	if(torchy)
		if(!on)
			if(torchy.fuel > 0)
				torchy.spark_act()
				playsound(src, 'sound/items/firelight.ogg', 100)
				on = TRUE
				update()
				update_appearance(UPDATE_ICON_STATE)
				if(soundloop)
					soundloop.start()
				return TRUE

/obj/machinery/light/fueled/lanternpost/Initialize(mapload)
	if (mapload)
		torchy = new /obj/item/flashlight/flare/torch/lantern(src)
		torchy.spark_act()
	. = ..()

/obj/machinery/light/fueled/lanternpost/Destroy()
	if(torchy)
		QDEL_NULL(torchy)
	return ..()

/obj/machinery/light/fueled/lanternpost/process()
	if(on)
		if(torchy)
			if(torchy.fuel <= 0)
				burn_out()
			if(!torchy.on)
				burn_out()
		else
			return PROCESS_KILL

/obj/machinery/light/fueled/lanternpost/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(torchy && !permanent)
		if(!istype(user) || !Adjacent(user) || !user.put_in_active_hand(torchy))
			torchy.forceMove(loc)
		torchy = null
		on = FALSE
		update()
		update_appearance(UPDATE_ICON_STATE)
		playsound(src, 'sound/foley/torchfixturetake.ogg', 100)

/obj/machinery/light/fueled/lanternpost/burn_out()
	if(torchy?.on)
		torchy.turn_off()
	..()

/obj/machinery/light/fueled/lanternpost/attackby(obj/item/W, mob/living/user, list/modifiers)
	if(istype(W, /obj/item/flashlight/flare/torch))
		var/obj/item/flashlight/flare/torch/LR = W
		if(torchy)
			if(LR.on && !on)
				if(torchy.fuel <= 0)
					to_chat(user, "<span class='warning'>La linterna montada esta quemada.</span>")
					return
				else
					torchy.spark_act()
					user.visible_message("<span class='info'>[user] ilumina [src].</span>")
					playsound(src, 'sound/items/firelight.ogg', 100)
					on = TRUE
					update()
					update_appearance(UPDATE_ICON_STATE)
					return
			if(!LR.on && on)
				if(LR.fuel > 0)
					LR.spark_act()
					user.visible_message("<span class='info'>[user] ilumina [LR] en [src].</span>")
					user.update_inv_hands()
		else
			if(LR.on)
				LR.forceMove(src)
				torchy = LR
				on = TRUE
				update()
				update_appearance(UPDATE_ICON_STATE)
			else
				LR.forceMove(src)
				torchy = LR
				update_appearance(UPDATE_ICON_STATE)
			playsound(src, 'sound/foley/torchfixtureput.ogg', 100)
		return
	if(istype(W, /obj/item/rope)&&!istype(W, /obj/item/rope/chain))
		if(!torchy)
			user.visible_message(span_notice("[user] comienza a atar una soga en [src]..."), span_notice("Comienzo a atar un nudo en [src]..."))
			if(do_after(user, 2 SECONDS, src))
				new /obj/structure/noose/gallows(loc)
				playsound(src, 'sound/foley/noose_idle.ogg', 100)
				qdel(W)
				qdel(src)
		else
			if(torchy && !permanent)
				to_chat(user, span_warning("Debo quitar [torchy] de [src] antes de poder atar [W]."))
			else
				to_chat(user, span_warning("En este caso no hay lugar para una cuerda."))
	else
		. = ..()
