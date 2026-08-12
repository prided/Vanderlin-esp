/datum/rmb_intent
	var/name = "intencion"
	var/desc = ""
	var/icon_state = ""
	/// Bonus/Malus to parry and dodge
	var/def_bonus = 0
	/// Whether the rclick will try to get turfs as target.
	var/target_turf = FALSE
	/// Needs the user to be Adjacent to the target or be in weapon range
	var/check_range = TRUE

/datum/rmb_intent/proc/get_target(atom/initial_target)
	if(target_turf)
		return get_turf(initial_target)

	if(ismob(initial_target))
		return initial_target

	for(var/mob/living/potential in get_turf(initial_target))
		return potential

/**
 * A special attack for this intent
 *
 * return TRUE to cancel the attack chain, FALSE to attack normally.
 */
/datum/rmb_intent/proc/special_attack(mob/living/user, atom/target)
	if(!user || !target)
		return FALSE

	if(target.loc == user)
		return FALSE

	if(isitem(target))
		var/obj/item/item_target = target
		if(item_target.item_flags & IN_STORAGE)
			return FALSE

	if(check_range)
		var/obj/item/attacker_item = user.get_active_held_item()
		if(!attacker_item && !user.Adjacent(target))
			return FALSE

		var/range = (user.used_intent?.reach || 1)
		if(get_dist(user, target) > range)
			return FALSE

	return TRUE

/datum/rmb_intent/aimed
	name = "apuntado"
	desc = "Tus ataques son mas precisos pero tienen un tiempo de recuperacion mas largo. Mayor probabilidad de ciertos golpes criticos. Bonificacion de esquiva reducida."
	icon_state = "rmbaimed"
	def_bonus = -10

/datum/rmb_intent/aimed/special_attack(mob/living/user, atom/target)
	. = ..()
	if(!.)
		return

	if(user == target)
		return FALSE

	if(user.incapacitated(IGNORE_GRAB))
		return FALSE

	if(user.has_status_effect(/datum/status_effect/debuff/baitcd))
		return FALSE

	var/mob/living/carbon/human/defender = get_target(target)
	if(!istype(defender))
		return FALSE

	// See effect for more info and effects
	var/datum/status_effect/stacking/baited/baited = defender.has_status_effect(/datum/status_effect/stacking/baited)
	if(baited && !COOLDOWN_FINISHED(baited, bait_cooldown))
		return FALSE

	if(defender.is_blind() || !defender.can_see_cone(user))
		to_chat(user, span_notice("¡[defender.p_they()] no me vio! ¡No paso nada!"))
		user.apply_status_effect(/datum/status_effect/debuff/baitcd, 5 SECONDS)
		return TRUE

	user.visible_message(
		span_danger("[user] provoca un ataque de [defender]."),
		span_notice("Provoco un ataque de [defender].")
	)
	user.apply_status_effect(/datum/status_effect/debuff/baitcd, BAIT_COOLDOWN_TIME)

	var/defender_zone = defender.zone_selected
	var/attacker_zone = user.zone_selected

	if(defender_zone != attacker_zone || defender_zone == BODY_ZONE_CHEST || attacker_zone == BODY_ZONE_CHEST)
		if(!check_face_subzone(defender_zone) && !check_face_subzone(attacker_zone))	//We simplify the myriad of face targeting zones
			to_chat(user, span_danger("¡No funciono! ¡[defender.p_their(TRUE)] footing regreso!"))
			to_chat(defender, span_notice("¡Me he burlado de [user.p_them()]! ¡He recuperado mi equilibrio!"))
			user.emote("groan")
			user.adjust_stamina(user.maximum_stamina * 0.2)
			defender.remove_status_effect(/datum/status_effect/stacking/baited)
			return TRUE

	defender.apply_status_effect(/datum/status_effect/debuff/exposed)
	defender.apply_status_effect(/datum/status_effect/debuff/clickcd, 5 SECONDS)

	user.changeNext_move(CLICK_CD_RAPID)

	if(!baited)
		to_chat(user, span_notice("¡[defender.p_they(TRUE)] se enamoro de mi cebo <b>perfectamente</b>! ¡Una vez mas!"))
		to_chat(defender, span_danger("Me he dejado engañar por el cebo de [user.p_their()] <b>¡perfectamente!</b> ¡Estoy perdiendo el equilibrio! <b>¡No puedo dejar que esto vuelva a suceder!</b>"))
	else
		to_chat(user, span_notice("¡[defender.p_they(TRUE)] se cayo de nuevo y esta desequilibrado! ¡AHORA!"))
		to_chat(defender, span_danger("¡Me he comido el anzuelo de [user.p_their()] <b>perfectamente</b>! ¡Mi equilibrio se ha perdido!</b>"))

	defender.apply_status_effect(/datum/status_effect/stacking/baited, null, 1)

	if(!defender.pulling)
		return TRUE

	defender.stop_pulling()
	to_chat(user, span_notice("¡[defender.p_they(TRUE)] se enamoro de mi truco sucio! ¡Estoy suelto!"))
	to_chat(defender, span_danger("¡Me he dejado engañar por el truco [user.p_their()]! ¡Mi agarre se ha roto!"))
	user.OffBalance(2 SECONDS)
	defender.OffBalance(2 SECONDS)

	playsound(user, 'sound/combat/riposte.ogg', 100, TRUE)

	return TRUE

/datum/rmb_intent/strong
	name = "fuerte"
	desc = "Tus ataques tienen mayor fuerza y ​​tienen mayor fuerza pero usan mas resistencia. Mayor probabilidad de ciertos golpes criticos. Falla intencionalmente los pasos de la cirugia. Bonificacion de esquiva reducida."
	icon_state = "rmbstrong"
	def_bonus = -10
	target_turf = TRUE
	check_range = FALSE // specials have their own range checks

/datum/rmb_intent/strong/special_attack(mob/living/user, atom/target)
	. = ..()
	if(!.)
		return

	if(user.incapacitated(IGNORE_GRAB))
		return FALSE

	if(user.has_status_effect(/datum/status_effect/debuff/specialcd))
		return FALSE

	var/turf/T = get_target(target)
	if(!istype(T))
		return FALSE

	var/obj/item/weapon/held_weapon = user.get_active_held_item()

	if(!istype(held_weapon) || !held_weapon.weapon_special)
		return FALSE

	var/datum/special_intent/special = held_weapon.weapon_special

	if(!special.deploy(user, held_weapon, target))
		return FALSE // Invalid starting args somehow

	special.apply_cost(user)

	user.changeNext_move(CLICK_CD_MELEE)

	return TRUE

/datum/rmb_intent/swift
	name = "rapido"
	desc = "Tus ataques tienen menos tiempo de recuperacion pero son menos precisos y tienen fuerza reducida."
	icon_state = "rmbswift"

/datum/rmb_intent/feint
	name = "simulacion"
	desc = "(RMB MIENTRAS ESTA EN MODO COMBATE) Un medio ataque engañoso sin seguimiento, destinado a obligar a tu oponente a abrir su guardia."
	icon_state = "rmbfeint"
	def_bonus = 10
	/// Duration of the feint expose / vulnerable effect
	var/feint_duration = 7.5 SECONDS

/datum/rmb_intent/feint/special_attack(mob/living/user, atom/target)
	. = ..()
	if(!.)
		return

	if(user == target)
		return FALSE

	if(user.incapacitated(IGNORE_GRAB))
		return FALSE

	if(user.has_status_effect(/datum/status_effect/debuff/feintcd))
		return FALSE

	var/mob/living/defender = get_target(target)
	if(!istype(defender))
		return FALSE

	var/obj/item/attacker_item = user.get_active_held_item()
	if(!attacker_item && !user.Adjacent(target))
		return FALSE

	if(get_dist(user, target) > user.used_intent?.reach)
		return FALSE

	user.visible_message(
		span_danger("¡[user] finta un ataque a [defender]!"),
		span_userdanger("¡Falto un ataque en [defender]!"),
	)

	var/perc = 50
	var/ourskill = 0
	var/theirskill = 0
	var/skill_factor = 0

	if(attacker_item?.associated_skill)
		ourskill = GET_MOB_SKILL_VALUE_OLD(user, attacker_item.associated_skill)

	var/obj/item/defender_item = defender.get_active_held_item()
	if(defender_item?.associated_skill)
		theirskill = GET_MOB_SKILL_VALUE_OLD(defender, defender_item.associated_skill)

	perc += (ourskill - theirskill) * 12 //skill is of the essence
	perc += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE) - GET_MOB_ATTRIBUTE_VALUE(defender, STAT_INTELLIGENCE)) * 8 //but it's also mostly a mindgame
	perc += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_SPEED) - GET_MOB_ATTRIBUTE_VALUE(defender, STAT_SPEED)) * 3 //yet a speedy feint is hard to counter
	perc += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION) - GET_MOB_ATTRIBUTE_VALUE(defender, STAT_PERCEPTION)) * 3 //a good eye helps

	skill_factor = (ourskill - theirskill) / 2

	var/special_message
	var/cooldown_override = 20 SECONDS

	if(defender.has_status_effect(/datum/status_effect/debuff/exposed) || \
		defender.has_status_effect(/datum/status_effect/debuff/vulnerable))
		perc = 0

	if(defender.is_blind() || !defender.can_see_cone(user))
		perc = 0
		cooldown_override = 5 SECONDS
		special_message = span_warning("¡Necesitan verme para fintarlos!")

	perc = CLAMP(perc, 0, 90)

	if(!prob(perc))
		playsound(user, 'sound/combat/feint.ogg', 100, TRUE)
		if(user.client?.prefs.read_preference(/datum/preference/toggle/showrolls))
			to_chat(user, span_warning("[defender.p_they(TRUE)] no cayo en mi trampa... [perc]%"))
		user.apply_status_effect(/datum/status_effect/debuff/feintcd)
		if(special_message)
			to_chat(user, special_message)
		return TRUE

	if(defender.has_status_effect(/datum/status_effect/buff/clash))
		defender.remove_status_effect(/datum/status_effect/buff/clash)
		defender.balloon_alert(user, "¡la guardia interrumpida!")

	var/effect_to_apply = defender.mind ? /datum/status_effect/debuff/vulnerable : /datum/status_effect/debuff/exposed

	defender.apply_status_effect(effect_to_apply, feint_duration)
	defender.apply_status_effect(/datum/status_effect/debuff/clickcd, max(1.5 SECONDS + skill_factor, 2.5 SECONDS))
	defender.Immobilize(0.5 SECONDS)
	defender.adjust_stamina(defender.stamina * 0.1)
	defender.Slowdown(2)

	user.changeNext_move(CLICK_CD_FAST)	//We don't want the feint effect to be popped instantly.
	user.apply_status_effect(/datum/status_effect/debuff/feintcd, cooldown_override)

	to_chat(user, span_notice("¡[defender.p_they(TRUE)] cayo ante mi ataque de finta!"))
	to_chat(defender, span_danger("¡Caigo en el ataque de [user.p_their()] distraccion!"))
	playsound(user, 'sound/combat/riposte.ogg', 100, TRUE)

	return TRUE

/datum/rmb_intent/riposte
	name = "defender"
	desc = "No hay demora entre las tiradas de esquivar y parar."
	icon_state = "rmbdef"
	def_bonus = 10

/datum/rmb_intent/riposte/special_attack(mob/living/user, atom/target)
	. = ..()
	if(!.)
		return

	if(user.has_status_effect(/datum/status_effect/buff/clash))
		return FALSE

	if(user.has_status_effect(/datum/status_effect/debuff/clashcd))
		return FALSE

	if(!user.get_active_held_item()) //Nothing in our hand to Guard with.
		return FALSE

	if(user.incapacitated()) //Not usable while grabs are in play.
		return FALSE

	if(user.IsImmobilized() || user.IsOffBalanced()) //Not usable while we're offbalanced or immobilized
		return FALSE

	if(user.m_intent == MOVE_INTENT_RUN)
		to_chat(user, span_warning("No puedo concentrarme en esto mientras corro."))
		return FALSE

	user.apply_status_effect(/datum/status_effect/buff/clash)

	return TRUE

/datum/rmb_intent/guard
	name = "guardia"
	desc = "(RMB MIENTRAS LA DEFENSA ESTA ACTIVA) Levanta tu arma, lista para atacar a cualquier criatura que se mueva hacia el espacio que estas protegiendo."
	icon_state = "rmbguard"

/datum/rmb_intent/weak
	name = "debil"
	desc = "Tus ataques han reducido la fuerza a la mitad y nunca daran un golpe critico. Los pasos quirurgicos solo se pueden realizar con esta intencion. Util para castigos mas prolongados, juegos de pelea y derramamientos de sangre."
	icon_state = "rmbweak"
