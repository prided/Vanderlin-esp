/datum/objective/personal/grave_robbery
	name = "Saquear tumbas"
	category = "Matthios' Elegido"
	triumph_count = 2
	rewards = list("2 Triunfos", "Matthios se fortalece", "Habilidad para saquear tumbas sin recibir una maldicion", "Matthios te bendice (+1 Resistencia)")
	var/graves_robbed = 0
	var/graves_required = 2

/datum/objective/personal/grave_robbery/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_GRAVE_ROBBED, PROC_REF(on_grave_robbed))
	update_explanation_text()

/datum/objective/personal/grave_robbery/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_GRAVE_ROBBED)
	return ..()

/datum/objective/personal/grave_robbery/proc/on_grave_robbed(datum/source, mob/user)
	SIGNAL_HANDLER
	if(completed || user != owner.current)
		return

	graves_robbed++
	if(graves_robbed >= graves_required)
		complete_objective()
	else
		to_chat(owner.current, span_notice("¡Tumba saqueada! Saquea [graves_required - graves_robbed] mas para completar la tarea de Matthios."))

/datum/objective/personal/grave_robbery/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has saqueado suficientes tumbas para ganarte el respeto de Matthios!"))
	adjust_storyteller_influence(MATTHIOS, 20)
	UnregisterSignal(owner.current, COMSIG_GRAVE_ROBBED)

/datum/objective/personal/grave_robbery/reward_owner()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_GRAVEROBBER, OBJECTIVE_TRAIT)
	owner.current.adjust_stat_modifier(STATMOD_MATTHIOS_BLESSING, STAT_ENDURANCE, 1)

/datum/objective/personal/grave_robbery/update_explanation_text()
	explanation_text = "Saquea al menos [graves_required] tumbas para ganarte el respeto de Matthios."
