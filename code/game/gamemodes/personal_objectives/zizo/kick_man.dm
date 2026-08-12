/datum/objective/personal/kick_groin
	name = "Patear la entrepierna"
	category = "Elegido de Zizo"
	triumph_count = 2
	rewards = list("2 Triunfos", "Zizo se fortalece", "Tus golpes en los huevos seran mas fuertes", "Zizo te bendice (+1 Fuerza)")

/datum/objective/personal/kick_groin/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_KICK, PROC_REF(on_kick_attempted))
	update_explanation_text()

/datum/objective/personal/kick_groin/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_MOB_KICK)
	return ..()

/datum/objective/personal/kick_groin/proc/on_kick_attempted(datum/source, mob/living/target, zone_hit, damage_blocked)
	SIGNAL_HANDLER
	if(completed || !target.client || target.gender != MALE || target.stat == DEAD || zone_hit != BODY_ZONE_PRECISE_GROIN)
		return

	if(damage_blocked)
		to_chat(owner.current, span_notice("¡La patada debe infligir DOLOR real para complacer a Zizo!"))
	else
		complete_objective()

/datum/objective/personal/kick_groin/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has impuesto tu dominio sobre este hombre y completado el objetivo de Zizo!"))
	adjust_storyteller_influence(ZIZO, 20)
	UnregisterSignal(owner.current, COMSIG_MOB_KICK)

/datum/objective/personal/kick_groin/reward_owner()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_NUTCRACKER, OBJECTIVE_TRAIT)
	owner.current.adjust_stat_modifier(STATMOD_ZIZO_BLESSING, list(STAT_STRENGTH = 1))

/datum/objective/personal/kick_groin/update_explanation_text()
	explanation_text = "¡Patea a un hombre en los huevos para demostrar tu dominio y obtener la aprobacion de Zizo!"
