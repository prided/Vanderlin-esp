/datum/objective/personal/baptism
	name = "Recibir el bautismo"
	category = "Elegido de Noc"
	triumph_count = 3
	rewards = list("3 Triunfos", "Noc se fortalece", "Noc te bendice (+1 Inteligencia)")

/datum/objective/personal/baptism/on_creation()
	. = ..()
	if(owner?.current)
		if(owner.current.mana_pool?.intrinsic_recharge_sources & MANA_ALL_LEYLINES)
			on_baptism_received()
		else
			RegisterSignal(owner.current, COMSIG_BAPTISM_RECEIVED, PROC_REF(on_baptism_received))
	update_explanation_text()

/datum/objective/personal/baptism/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_BAPTISM_RECEIVED)
	return ..()

/datum/objective/personal/baptism/proc/on_baptism_received(datum/source, mob/living/baptizer)
	SIGNAL_HANDLER
	if(completed)
		return

	complete_objective()

/datum/objective/personal/baptism/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has sido bautizado y has completado el objetivo de Noc!"))
	adjust_storyteller_influence(NOC, 20)
	UnregisterSignal(owner.current, COMSIG_BAPTISM_RECEIVED)

/datum/objective/personal/baptism/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_NOC_BLESSING, list(STAT_INTELLIGENCE = 1))

/datum/objective/personal/baptism/update_explanation_text()
	explanation_text = "¡Recibe el bautismo de mana en nombre de Noc para obtener su favor!"
