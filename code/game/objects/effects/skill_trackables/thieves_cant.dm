/obj/effect/skill_tracker/thieves_cant
	name = ""
	icon = 'icons/roguetown/misc/trackables.dmi'
	icon_state = "thieves_cant"
	real_icon_state = "thieves_cant"
	real_image = 150

	reveal_skill = /datum/attribute/skill/misc/sneaking
	always_revealed_trait = TRAIT_THIEVESGUILD

	var/thieves_message

/obj/effect/skill_tracker/thieves_cant/Initialize(mapload, atom/parent)
	. = ..()
	var/turf/closed/parent_turf = parent
	if(!istype(parent_turf))
		return
	parent_turf.thieves_marking = src

/obj/effect/skill_tracker/thieves_cant/examine(mob/user)
	. = ..()
	if(!user.has_language(/datum/language/thievescant))
		to_chat(user, "No puedes entender bien estas marcas.")
		return
	to_chat(user, "Los grabados dicen: [span_notice(thieves_message)]")

/obj/effect/skill_tracker/thieves_cant/proc/write_message(mob/user, message)
	if(!do_after(user, 5 SECONDS, src))
		return
	thieves_message = message

/obj/effect/skill_tracker/thieves_cant/proc/can_see(mob/user)
	if(user in known_by)
		return TRUE
	return FALSE


/obj/effect/mapping_helpers/thieves_cant_helper
	name = "Los ladrones no pueden generar"

	icon = 'icons/roguetown/misc/trackables.dmi'
	icon_state = "thieves_cant"

	var/thieves_message = ""
	var/probability = 100

/obj/effect/mapping_helpers/thieves_cant_helper/Initialize()
	. = ..()
	if(prob(probability))
		var/obj/effect/skill_tracker/thieves_cant/cant = new /obj/effect/skill_tracker/thieves_cant(get_turf(src), get_turf(src))
		cant.thieves_message = thieves_message
