/*
Grappling hook! Comes in 3 strict steps w/ unique intents: Grab -> Attach -> Reel.
Grab grabs onto a floor turf in range, only works for floors ABOVE the user.
Attach clasps a hook onto the chosen atom (obj / mob, has to be unanchored and not a structure or machinery)
Reel teleports the attached atom to the grabbed turf.
*/
#define GRAPPLER_ZUP 1
#define GRAPPLER_ZDOWN 2
#define GRAPPLER_NOZ 3

/obj/item/grapplinghook
	name = "luchador de bronce"
	desc = "La mejor innovacion en ingenieria industrial enana. Se utiliza para transportar cajas y barriles en pozos demasiado empinados para los vagones. Se puede usar en personas que no son demasiado grandes.\nHas un rango de mosaicos VI en el mismo plano y un rango de mosaicos III en todos los planos.\nGrappling en el mismo plano sera bloqueado por cualquier objeto denso."
	icon = 'icons/roguetown/misc/gadgets.dmi'
	icon_state = "grappler_used"
	item_state = "grappler"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	possible_item_intents = list(/datum/intent/grapple, /datum/intent/attach, /datum/intent/reel)
	experimental_inhand = TRUE
	var/is_loaded = FALSE
	var/isloading = FALSE
	var/in_use = FALSE
	var/turf/grappled_turf
	var/atom/attached
	var/mutable_appearance/tile_effect
	var/mutable_appearance/target_effect
	var/max_range_z = 3
	var/max_range_noz = 6
	var/leash_range = 7
	var/list/obj_to_destroy = list()
	grid_height = 32
	grid_width = 64
	item_weight = 2.5 KILOGRAMS

/obj/item/grapplinghook/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)	//For preventing hooking / attaching something and walking away.


/obj/item/grapplinghook/Destroy()
	STOP_PROCESSING(SSobj, src)
	reset_tile()
	reset_target()
	return ..()

//Range check for both the tool itself and anything it has attached to the turf it's hooked to.
/obj/item/grapplinghook/process()
	if(in_use && grappled_turf)
		if(get_dist(grappled_turf, src) > leash_range)
			reset_tile()
			reset_target()
	if(grappled_turf && attached)
		if(get_dist(grappled_turf, attached) > leash_range)
			reset_tile()
			reset_target()

//Grappler intents. Not meant to be functional outside of the tool.
/datum/intent/grapple
	name = "luchar"
	icon_state = "ingrab"
	desc = "Se utiliza para agarrarse a una losa abierta y sin obstaculos."
	no_attack = TRUE

/datum/intent/attach
	name = "adjuntar"
	icon_state = "inattach"
	desc = "Se utiliza para unir una entidad al anzuelo para enrollarlo. No debe ser pesado, grande ni anclado."
	no_attack = TRUE

/datum/intent/reel
	name = "bobina"
	icon_state = "inreel"
	desc = "Se utiliza para enrollar la entidad adjunta a la ficha agarrada."
	no_attack = TRUE

/obj/item/grapplinghook/examine()
	. = ..()
	if(is_loaded && !in_use)
		. += span_warning("Esta listo para usar. <b>GRAB</b> una parcela por encima de ti.")
	else if(!is_loaded && !in_use)
		. += span_warning("Se ha agotado. Debe recargarse.")
	else if(!is_loaded && grappled_turf && in_use)
		. += span_warning("Esta desplegado. Puedes <b>UNIR</b> un gancho a una entidad.")
		. += span_info("Puedo activar esto en mi mano para restablecerlo.")
	if(attached && grappled_turf && in_use && !is_loaded)
		. += span_warning("Ya esta listo para usar. Puedes <b>REEL</b> en \the [attached].")


/obj/item/grapplinghook/attack_self(mob/living/user)
	if(!is_loaded && !in_use && user.used_intent != /datum/intent/reel)
		var/stat = max(GET_MOB_ATTRIBUTE_VALUE(user, STAT_SPEED), GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION))	//We check the PER / SPD stats first
		stat = stat - 10
		if(stat > 0)
			stat = stat * 3
			if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 11)	//Then we add their strength if they had any of the previous
				stat += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) - 10) * 2
		else
			stat = 0
		stat += (GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/craft/engineering)) * 5	//And finally their Engineering level.
		stat = clamp(stat, 10, 70)	//Clamp to a very loud second just in case you're a superhuman engineer
		if(!isloading)
			user.visible_message(span_info("[user] comienza a girar el [src]..."))
			isloading = TRUE
			playsound(user, 'sound/misc/grapple_crank.ogg', 100, FALSE, 3)
			if(do_after(user, 70 - stat, user, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM|IGNORE_USER_DIR_CHANGE)))
				playsound(src, 'sound/foley/trap_arm.ogg', 100, FALSE , 5)
				to_chat(user, span_info("¡Esta cargado!"))
				isloading = FALSE
				is_loaded = TRUE
				update_appearance(UPDATE_ICON_STATE)
			else
				isloading = FALSE
				user.visible_message(span_info("¡[user] se ve interrumpido!"))
	else if(istype(user.used_intent, /datum/intent/reel))	//Alternative to clicking on an empty tile. You can self-use it to reel instead.
		if(attached && in_use)
			if(get_dist(attached, grappled_turf) <= (user.z != grappled_turf.z ? max_range_z : max_range_noz))
				user.visible_message("[user] bobinas en el [src]!")
				if(do_after(user, 10))
					reel()
			else
				to_chat(user, span_info("¡[attached] esta demasiado lejos!"))
	else if(!is_loaded && in_use && grappled_turf && tile_effect)	//Reset option.
		user.visible_message("[user] se desengancha del azulejo.")
		reset_tile()
		reset_target()

//Resets the tile effect and the grappled turf. Generally called with reset_target()
/obj/item/grapplinghook/proc/reset_tile(silent = FALSE)
	if(tile_effect && grappled_turf)
		grappled_turf.cut_overlay(tile_effect)
		qdel(tile_effect)
		grappled_turf = null
	if(!silent)	//Silent is used during a successful reel because it has its own distinct sounds
		playsound(src, 'sound/foley/trap.ogg', 100, FALSE , 5)
	is_loaded = FALSE
	update_appearance(UPDATE_ICON_STATE)

//Resets the target effect overlay and the attached atom. Generally called with reset_tile()
/obj/item/grapplinghook/proc/reset_target()
	if(attached && target_effect)
		attached.cut_overlay(target_effect)
		qdel(target_effect)
		attached = null
	in_use = FALSE
	update_appearance(UPDATE_ICON_STATE)

/obj/item/grapplinghook/proc/check_path(turf/Tu, turf/Tt, state)
	var/dist = get_dist(Tt, Tu)
	var/last_dir
	var/turf/last_step
	switch(state)
		if(GRAPPLER_ZUP)
			last_step = GET_TURF_ABOVE(Tu)
		if(GRAPPLER_ZDOWN)
			last_step = GET_TURF_BELOW(Tu)
		if(GRAPPLER_NOZ)
			last_step = Tu
	var/success = FALSE
	if(state == GRAPPLER_ZDOWN || state == GRAPPLER_ZUP)
		for(var/i = 0, i <= dist, i++)
			last_dir = get_dir(last_step, Tt)
			var/turf/Tstep = get_step(last_step, last_dir)
			if(!Tstep.density)
				success = TRUE
				var/list/cont = Tstep.GetAllContents()
				for(var/obj/structure/window/W in cont)
					if(W.climbable && !W.opacity)	//It's climable and can be seen through
						success = TRUE
						LAZYADD(obj_to_destroy, W)
						continue
					else if(!W.climbable)
						success = FALSE
						return success
				for(var/obj/structure/fluff/railing/F in cont)
					if(F)
						success = FALSE
						return success
			else
				success = FALSE
				return success
			last_step = Tstep
	if(state == GRAPPLER_NOZ)
		success = TRUE
		var/list/visible = getline(Tu, Tt)
		for(var/turf/T in visible)
			if(IS_OPAQUE_TURF(T) || T.density && T != Tu)	//Any dense or opaque turfs
				success = FALSE
				return success
			for(var/obj/O in (T.contents + Tt.contents))
				if(O)
					if(O.density || O.opacity)	//ANY dense or opaque objects. It's strict, but it's also a teleport, so.
						success = FALSE
						return success
	return success



//Successful reel, complete reset.
/obj/item/grapplinghook/proc/reel()
	if(attached && in_use && grappled_turf)
		var/mob/living/grabber
		var/mob/living/grabby
		var/grapple_buckled
		if(isliving(attached))
			grabber = attached
			if(grabber && isliving(grabber.pulling))
				grabby = grabber.pulling
				if(grabby in grabber.buckled_mobs)
					grapple_buckled = TRUE
		if(do_teleport(attached, grappled_turf))
			if(grabby)
				do_teleport(grabby, grappled_turf)
				grabber.start_pulling(grabby)
				if(grapple_buckled)
					if(grabby.mobility_flags & MOBILITY_STAND)	// piggyback carry
						grabber.buckle_mob(grabby, TRUE, TRUE, FALSE, 0, 0)
					else				// fireman carry
						grabber.buckle_mob(grabby, TRUE, TRUE, 90, 0, 0)
			playsound(attached, 'sound/misc/grapple_reel.ogg', 100, FALSE)
			playsound(grappled_turf, 'sound/misc/grapple_reel.ogg', 100, FALSE)
			destroy_eligible_objects()
			reset_tile(silent = TRUE)
			reset_target()
			unload(failure = TRUE)

/obj/item/grapplinghook/proc/destroy_eligible_objects()
	if(length(obj_to_destroy))
		for(var/obj/O in obj_to_destroy)
			if(istype(O,/obj/structure/window))
				var/obj/structure/window/W = O
				if(!W.climbable)
					O.atom_break()
		LAZYCLEARLIST(obj_to_destroy)

/obj/item/grapplinghook/afterattack(atom/target, mob/user, proximity_flag, list/modifiers)
	if(istype(user.used_intent, /datum/intent/grapple))	//First step, grappling onto a tile. Spawns an indicator on it.
		if(is_loaded && istype(target, /turf/))
			var/turf/T = target
			if(!istransparentturf(T) && !islava(T))
				if(T.z != user.z) //We are shooting at a floor turf above or below
					var/reason
					if(max_range_z >= get_dist(user, T) && !T.density)
						if(check_path(get_turf(user), T, T.z > user.z ? GRAPPLER_ZUP : GRAPPLER_ZDOWN))	//We check for opaque turfs or non-climbable windows in the way via a simple pathfind.
							to_chat(user, span_info("¡El gancho aterriza en el suelo!"))
							grapple_to(T)
							attached = user
							return
						else
							to_chat(user, span_info("¡El camino esta bloqueado!"))
							return
					else if(get_dist(user, T) > max_range_z)
						reason = "It's too far."
					else if (T.density)
						reason = "It's a wall!"
					to_chat(user, span_info("¡El gancho falla! "+"[reason]"))
					playsound(user, 'sound/foley/trap.ogg', 100, FALSE , 5)
					unload(failure = TRUE)
				else if(T.z == user.z)
					if(max_range_noz >= get_dist(user, T) && !T.density)
						if(check_path(get_turf(user), T, GRAPPLER_NOZ))	//We check for opaque turfs and ANY dense objects in the way
							to_chat(user, span_info("¡El gancho aterriza en el suelo!"))
							grapple_to(T)
							attached = user
							return
						else
							to_chat(user, span_info("¡El camino esta bloqueado!"))
							return
			else
				to_chat(user, span_info("¡Objetivo incorrecto! Necesita un azulejo de suelo despejado para agarrarse."))
		else if(!is_loaded)
			to_chat(user, span_info("Ya se ha utilizado."))
	if(istype(user.used_intent, /datum/intent/attach))	//Second step. Once we have a turf we've grappled onto, we can use this to attach to an entity.
		if(in_use && !istype(target, /turf/))	//Can't use the feature unless it's grappled already
			var/safe_to_teleport = TRUE
			if(isobj(target))
				var/obj/O = target
				if(!istype(target, /obj/structure/closet/crate) && !istype(target, /obj/structure/fermentation_keg) && !istype(target, /obj/structure/handcart))	//We DO want to move crates, barrels & carts
					if(O.density || istype(target, /obj/structure) || O.anchored || istype(target, /obj/machinery)) //This should cover most (fingers crossed) objects that shouldn't be moved around like this.
						safe_to_teleport = FALSE
			if(safe_to_teleport)
				to_chat(user, span_info("Comienzo a sujetar el gancho..."))
				if(do_after(user, 30))
					if(target != user)
						user.visible_message(span_warning("[user] sujeta el gancho a [target]."))
					if(target == user)
						user.visible_message(span_warning("¡[user] se ata el gancho a si mismo!"))
					attach(target)
			else
				to_chat(user, span_warning("¡[target] es demasiado grande o voluminoso para adjuntarlo!"))
		else
			to_chat(user, span_info("Primero necesito que este enganchado a un azulejo."))
	if(istype(user.used_intent, /datum/intent/reel))	//Last step, we reel in the attached entity to the grappled turf.
		if(attached && in_use)
			if(get_dist(attached, grappled_turf) <= (user.z != grappled_turf.z ? max_range_z : max_range_noz))
				user.visible_message("[user] enrolla \the [src]!")
				if(do_after(user, 10))
					reel()
			else
				to_chat(user, span_info("¡[target] esta demasiado lejos!"))
		else
			to_chat(user, span_info("Necesito tener algo adjunto."))
	. = ..()

//Attaches a hook to an atom. Used with the "ATTACH" intent.
/obj/item/grapplinghook/proc/attach(atom/A)
	if(A && !isturf(A))
		if(target_effect && attached)
			attached.cut_overlay(target_effect)
			qdel(target_effect)
		playsound(A,'sound/misc/grapple_attach.ogg', 100, FALSE, 5)
		attached = A
		target_effect = mutable_appearance(icon = 'icons/effects/effects.dmi', icon_state = "aimwarn", layer = 20)
		attached.add_overlay(target_effect)

//Hooks onto a turf. Used with the "GRAB" intent.
/obj/item/grapplinghook/proc/grapple_to(turf/T)
	unload()
	playsound(T, 'sound/misc/grapple_land.ogg', 100, FALSE, 5)
	tile_effect = mutable_appearance(icon = 'icons/effects/effects.dmi', icon_state = "hooked_tile", layer = 18)
	grappled_turf = T
	grappled_turf.add_overlay(tile_effect)

//Reloads the grappler.
/obj/item/grapplinghook/proc/load()
	is_loaded = TRUE
	in_use = FALSE
	update_appearance(UPDATE_ICON_STATE)

//Unloads the grappler after a successful, or not, attempt to use on a turf.
/obj/item/grapplinghook/proc/unload(failure)
	if(!failure)
		is_loaded = FALSE
		in_use = TRUE
	else
		is_loaded = FALSE
		in_use = FALSE
	update_appearance(UPDATE_ICON_STATE)

/obj/item/grapplinghook/update_icon_state()
	. = ..()
	if(is_loaded && !in_use)
		icon_state = "grappler"
	else if(!is_loaded && !in_use)
		icon_state = "grappler_used"
	else if(!is_loaded && in_use)
		icon_state = "grappler_inuse"

#undef GRAPPLER_ZUP
#undef GRAPPLER_ZDOWN
#undef GRAPPLER_NOZ
