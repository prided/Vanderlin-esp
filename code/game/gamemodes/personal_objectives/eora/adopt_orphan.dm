/datum/objective/personal/adopt_orphan
	name = "Adoptar un huerfano"
	category = "Elegido de Eora"
	triumph_count = 3
	immediate_effects = list("Obtuviste una habilidad para adoptar niños")
	rewards = list("3 Triunfos", "Eora se fortalece", "Eora te bendice (+1 Fortuna)")

/datum/objective/personal/adopt_orphan/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ORPHAN_ADOPTED, PROC_REF(on_orphan_adopted))
	update_explanation_text()

/datum/objective/personal/adopt_orphan/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ORPHAN_ADOPTED)
	return ..()

/datum/objective/personal/adopt_orphan/proc/on_orphan_adopted(datum/source, mob/new_child)
	SIGNAL_HANDLER
	if(completed)
		return

	complete_objective()

/datum/objective/personal/adopt_orphan/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has adoptado un niño y completado el objetivo de Eora!"))
	adjust_storyteller_influence(EORA, 20)
	UnregisterSignal(owner.current, COMSIG_ORPHAN_ADOPTED)

/datum/objective/personal/adopt_orphan/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_EORA_BLESSING, list(STAT_FORTUNE = 1))

/datum/objective/personal/adopt_orphan/update_explanation_text()
	explanation_text = "¡Adopta un huerfano como hijo propio y dale un hogar lleno de amor! ¡Eora cuenta contigo!"
