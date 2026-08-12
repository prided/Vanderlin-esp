/datum/objective/personal/nobility
	name = "Conviertete en noble"
	category = "Elegido de Astrata"
	triumph_count = 3
	rewards = list("3 Triunfos", "Astrata se fortalece", "Astrata te bendice (+1 Fortuna)")

/datum/objective/personal/nobility/on_creation()
	. = ..()
	if(owner?.current)
		if(HAS_TRAIT(owner.current, TRAIT_NOBLE_POWER))
			on_nobility_granted()
		else
			RegisterSignal(owner.current, SIGNAL_ADDTRAIT(TRAIT_NOBLE_POWER), PROC_REF(on_nobility_granted))
	update_explanation_text()

/datum/objective/personal/nobility/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, SIGNAL_ADDTRAIT(TRAIT_NOBLE_POWER))
	return ..()

/datum/objective/personal/nobility/proc/on_nobility_granted()
	SIGNAL_HANDLER
	if(completed)
		return

	complete_objective()

/datum/objective/personal/nobility/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Te has ganado la nobleza y completado el objetivo de Astrata!"))
	adjust_storyteller_influence(ASTRATA, 20)
	UnregisterSignal(owner.current, SIGNAL_ADDTRAIT(TRAIT_NOBLE_POWER))

/datum/objective/personal/nobility/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_ASTRATA_BLESSING, list(STAT_FORTUNE = 1))

/datum/objective/personal/nobility/update_explanation_text()
	explanation_text = "¡Conviertete en parte de la nobleza por cualquier medio para obtener la aprobacion de Astrata!"
