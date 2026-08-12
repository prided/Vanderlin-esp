/datum/objective/personal/get_apprentice
	name = "Conseguir un aprendiz"
	category = "Elegido de Noc"
	triumph_count = 3
	rewards = list("3 Triunfos", "Noc se fortalece", "Noc te bendice (+1 Inteligencia)")

/datum/objective/personal/get_apprentice/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_APPRENTICE_MADE, PROC_REF(on_new_apprentice))
	update_explanation_text()

/datum/objective/personal/get_apprentice/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_APPRENTICE_MADE)
	return ..()

/datum/objective/personal/get_apprentice/proc/on_new_apprentice(datum/source, mob/new_apprentice)
	SIGNAL_HANDLER
	if(completed)
		return

	complete_objective()

/datum/objective/personal/get_apprentice/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has obtenido un nuevo aprendiz, completando el objetivo de Noc!"))
	adjust_storyteller_influence(NOC, 20)
	UnregisterSignal(owner.current, COMSIG_APPRENTICE_MADE)

/datum/objective/personal/get_apprentice/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_NOC_BLESSING, list(STAT_INTELLIGENCE = 1))

/datum/objective/personal/get_apprentice/update_explanation_text()
	explanation_text = "¡Consigue un nuevo aprendiz a quien transmitir tus conocimientos! Noc estara observando."
