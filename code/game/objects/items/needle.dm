/obj/item/needle
	name = "aguja"
	desc = "Aguja firme fijada con un hilo simple, utilizada para coser telas y heridas por igual."
	icon_state = "needle"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throwforce = 0
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	anvilrepair = /datum/attribute/skill/craft/blacksmithing
	melting_material = /datum/material/iron
	melt_amount = 20
	tool_behaviour = TOOL_SUTURE
	item_weight = 5 GRAMS

	grid_width = 32
	grid_height = 32
	/// Amount of uses left
	var/stringamt = 24
	var/maxstring = 24
	/// If this needle is infinite
	var/infinite = FALSE
	/// If this needle can be used to repair items
	var/can_repair = TRUE

/obj/item/needle/examine()
	. = ..()
	if(!infinite)
		if(stringamt > 0)
			. += span_bold("Le quedan [stringamt] usos.")
		else
			. += span_bold("No tiene mas usos.")
	else
		. += span_bold("Se puede usar indefinidamente.")

/obj/item/needle/Initialize()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/needle/update_overlays()
	. = ..()
	if(stringamt <= 0)
		return
	. += "[icon_state]string"

/obj/item/needle/use(used)
	if(infinite)
		return TRUE
	if(used > stringamt)
		return FALSE
	stringamt = stringamt - used

	return TRUE

/obj/item/needle/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(isliving(interacting_with))
		if(sew_wounds(interacting_with, user))
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING

	if(isitem(interacting_with))
		if(sew_item(interacting_with, user))
			return ITEM_INTERACT_SUCCESS

/obj/item/needle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/natural/fibers))
		return NONE

	if(maxstring - stringamt < 5)
		to_chat(user, span_warning("¡No hay suficiente espacio para mas hilo!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, "Comienzo a enhebrar la aguja con fibras adicionales...")
	if(do_after(user, 6 SECONDS - GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/misc/sewing), tool))
		stringamt += 5
		to_chat(user, "¡Recargo el hilo de la aguja!")
		qdel(tool)
		update_appearance(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/item/needle/proc/sew_item(obj/item/I, mob/living/user)
	if(!(I.obj_flags & CAN_BE_HIT) && !istype(I, /obj/item/storage))
		return FALSE

	if(!I.ontable() || !I.sewrepair)
		return FALSE

	if(!I.uses_integrity)
		to_chat(user, span_warning("¡No se puede reparar [I]!"))
		return FALSE

	if(stringamt < 1)
		to_chat(user, span_warning("¡[src] no tiene mas hilo!"))
		return FALSE

	if(!can_repair)
		to_chat(user, span_warning("¡[src] no se puede utilizar para reparar [I]!"))
		return FALSE

	var/list/armorlist = I.get_armor().get_rating_list()
	var/armor_value = 0
	var/skill_level = GET_MOB_SKILL_VALUE(user, I.sewrepair)
	for(var/key in armorlist)
		armor_value += armorlist[key]

	if(!I.obj_broken && I.get_integrity() >= I.max_integrity && (I.max_integrity != initial(I.max_integrity)))
		if(!I.salvage_result)
			to_chat(user, span_warning("[I] no se puede unir con una aguja."))
			return FALSE

		if(I.integrity_restores >= 3)
			to_chat(user, span_warning("[I] ha sido cosida demasiadas veces. El tejido no aceptara mas material."))
			return FALSE

		var/obj/item/patch = locate(I.salvage_result) in range(1, I.loc)
		if(!patch)
			to_chat(user, span_warning("Necesitas [initial(I.salvage_result:name)] cerca para fusionar [I]."))
			return FALSE

		if(skill_level <= 0)
			to_chat(user, span_warning("No sabes lo suficiente como para fusionar [I]."))
			return FALSE

		playsound(src, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
		var/sewtime = (6 SECONDS - skill_level)
		if(!do_after(user, sewtime, I))
			return FALSE

		var/restores_done = I.integrity_restores
		var/base_restore = (skill_level / SKILL_MASTER) * 0.20
		var/diminish_factor = max(0.1, 1.0 - (restores_done * 0.30))
		var/restore_amount = round(I.max_integrity * base_restore * diminish_factor)

		if(restore_amount <= 0)
			to_chat(user, span_warning("[I] no tomara mas material."))
			return TRUE

		I.max_integrity += restore_amount
		I.integrity_restores++
		qdel(patch)

		user.visible_message(span_info("[user] mezcla nuevo material en [I], restaurando algo de su integridad."))
		if(restores_done >= 2)
			to_chat(user, span_warning("El tejido esta aceptando el nuevo material con menos prontitud ahora. La fusion adicional sera menos efectiva."))

		var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE) * 0.25
		user.mind.add_sleep_experience(I.sewrepair, amt2raise)
		return TRUE

	if(!I.obj_broken && I.get_integrity() >= I.max_integrity)
		to_chat(user, span_warning("No hay nada mas que reparar en [I]."))
		return FALSE

	var/repair_percent = 0.025
	if(skill_level <= 0)
		if(prob(30))
			repair_percent = 0.01
			to_chat(user, span_warning("Apenas puedes reparar esto..."))
		else
			repair_percent = 0
	else
		repair_percent *= skill_level

	if((armor_value == 0 && skill_level < 10) || (armor_value > 0 && skill_level < 20))
		to_chat(user, span_warning("Probablemente no deberia estar haciendo esto..."))

	playsound(src, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
	var/sewtime = (6 SECONDS - skill_level)
	if(!do_after(user, sewtime, I))
		return TRUE

	var/was_broken = I.obj_broken
	if(was_broken)
		var/integrity_penalty = 0.65 - ((skill_level / SKILL_MASTER) * 0.60)
		integrity_penalty = clamp(integrity_penalty, 0.05, 0.99)
		var/integrity_loss = round(I.max_integrity * integrity_penalty)
		I.max_integrity = max(1, I.max_integrity - integrity_loss)
		I.obj_broken = FALSE
		I.repair_damage(max(I.max_integrity * repair_percent, 10))
		to_chat(user, span_warning("Suelas [I] de nuevo, pero el daño ha dejado su huella, nunca volvera a ser tan fuerte como antes."))
		if(skill_level < SKILL_MIDDLING)
			to_chat(user, span_warning("Tu inexperiencia empeoro las cosas. El arreglo es chapucero."))
	else
		if(repair_percent)
			user.visible_message(span_info("¡[user] repara [I]!"))
			I.repair_damage(I.max_integrity * repair_percent)
		else
			I.take_damage(I.max_integrity * 0.1, BRUTE, "slash")
			user.visible_message(span_warning("¡[user] daña a [I] aun mas!"))
			playsound(src, 'sound/foley/cloth_rip.ogg', 50, TRUE)

	use(1)

	var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE) * 0.25
	if(repair_percent <= 0)
		amt2raise *= 0.25

	user.mind.add_sleep_experience(I.sewrepair, amt2raise)

	return TRUE

/obj/item/needle/proc/sew_wounds(mob/living/carbon/target, mob/living/user)
	if(!istype(user) || !istype(target))
		return FALSE
	if(stringamt < 1)
		to_chat(user, span_warning("¡La aguja no tiene hilo!"))
		return FALSE
	var/mob/living/doctor = user
	var/mob/living/carbon/patient = target
	if(!get_location_accessible(patient, check_zone(doctor.zone_selected)))
		to_chat(doctor, span_warning("Algo esta en el camino."))
		return FALSE
	var/obj/item/bodypart/affecting = patient.get_bodypart(check_zone(doctor.zone_selected))
	if(!affecting)
		to_chat(doctor, span_warning("Ese miembro falta."))
		return FALSE
	if(affecting.bandage)
		to_chat(doctor, span_warning("Hay un vendaje en el camino."))
		return FALSE

	var/doctor_skill = GET_MOB_SKILL_VALUE(doctor, /datum/attribute/skill/misc/medicine)
	var/perception_mod = 1 - 0.5 * (GET_MOB_ATTRIBUTE_VALUE(doctor, STAT_PERCEPTION) - ATTRIBUTE_MIDDLING)/(ATTRIBUTE_MAX - SKILL_MIDDLING)
	var/doctor_mod = 1 - 0.9 * (doctor_skill - SKILL_MIDDLING)/(SKILL_MAX - SKILL_MIDDLING)
	// First try to fix arteries
	if(affecting.get_cut() && affecting.is_artery_torn())
		var/time = 5 SECONDS
		time *= perception_mod * doctor_mod
		playsound(patient, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
		if(!do_after(doctor, time, patient))
			to_chat(doctor, span_warning("¡Debo permanecer quieto!"))
			return FALSE
		if(!use(1))
			to_chat(doctor, span_warning("¡La aguja no tiene hilo!"))
			return FALSE
		var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(doctor, STAT_INTELLIGENCE) * doctor.get_learning_boon(/datum/attribute/skill/misc/medicine)
		if(doctor.diceroll(doctor_skill - 1, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
			to_chat(doctor, span_warning("¡Mi mano se resbala!"))
			return FALSE
		user.adjust_experience(/datum/attribute/skill/misc/medicine, amt2raise * 0.1)
		doctor.visible_message(
			span_green("<b>[doctor]</b> sutura las arterias de <b>[patient]</b>'s [affecting.name] con \the [src]."),
			span_green("Suto <b>[patient]</b>'s [affecting.name] arterias con \the [src]."))
		for(var/obj/item/organ/artery in affecting.getorganslotlist(ORGAN_SLOT_ARTERY))
			if(artery.damage)
				artery.applyOrganDamage(-artery.maxHealth/3)
				return TRUE

	// Then try to sew wounds (crits)
	var/list/sewable = affecting.get_sewable_wounds()
	if(length(sewable))
		var/datum/wound/target_wound = browser_input_list(doctor, "Which critical wound?", "WOUND CRAFT", sewable)
		if(QDELETED(target_wound) || QDELETED(src) || QDELETED(doctor) || QDELETED(user))
			return FALSE
		if(target_wound && target_wound.do_sewing_step(doctor, src))
			return TRUE

	// Finally injuries
	for(var/datum/injury/injury as anything in affecting.injuries)
		if(!(injury.damage_type & SEWABLE_WOUND_TYPES))
			continue
		if(!injury.can_heal())
			continue
		if(injury.is_sutured())
			continue
		var/time = 2 SECONDS + min(injury.damage_per_injury() * 0.1, 2 SECONDS)
		time *= perception_mod * doctor_mod
		playsound(target, 'sound/foley/sewflesh.ogg', 65, FALSE)
		if(!do_after(user, time, target))
			to_chat(user, span_warning("¡Debo permanecer quieto!"))
			return
		if(!use(1))
			to_chat(doctor, span_warning("¡La aguja no tiene hilo!"))
			return
		var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(doctor, STAT_INTELLIGENCE) * doctor.get_learning_boon(/datum/attribute/skill/misc/medicine)
		user.adjust_experience(/datum/attribute/skill/misc/medicine, amt2raise)
		. = TRUE
		var/injury_heal = min(10, injury.damage - injury.autoheal_cutoff)
		/// We don't abs() injury_heal because we don't want to heal injuries below autoheal_cutoff
		injury.heal_damage(injury_heal, TRUE)
		if(injury.damage_per_injury() > injury.autoheal_cutoff)
			user.visible_message(span_green("<b>[user]</b> cose parcialmente \a [injury.get_desc(FALSE)] en <b>[target]</b> [affecting.name] con \the [src]."), \
								span_green("Costuro parcialmente \a [injury.get_desc(FALSE)] en \the [affecting.name] con \the [src]."))
		else
			user.visible_message(span_green("<b>[user]</b> puntos de sutura \a [injury.get_desc(FALSE)] cerraron en <b>[target]</b>'s [affecting.name] con \the [src]."), \
								span_green("Coso \a [injury.get_desc(FALSE)] para cerrar \the [affecting.name] con \the [src]."))
			injury.suture_injury()
			break

	if(.)
		return TRUE

	to_chat(doctor, span_warning("No quedan heridas ni lesiones para coser."))
	return FALSE

/obj/item/needle/thorn
	name = "aguja"
	icon_state = "thornneedle"
	desc = "Esta aguja utiliza una espina aspera, lo que limita la cantidad de hilo que se puede enhebrar."
	stringamt = 12
	maxstring = 12
	anvilrepair = null
	melting_material = null
	item_weight = 3 GRAMS

/obj/item/needle/blessed
	name = "bendita aguja"
	desc = span_hierophant("Una aguja bendecida por los Pestrans ordenados de la Iglesia. Un articulo codiciado, porque su hilo nunca terminara. \n Sin embargo, este hilo solo se puede utilizar para coser heridas.")
	infinite = TRUE
	can_repair = FALSE
	item_weight = 5 GRAMS
