/datum/objective/personal/energy_expenditure
	name = "Gastar energia"
	category = "Elegido de Malum"
	triumph_count = 2
	rewards = list("2 Triunfos", "Malum se fortalece", "Malum te bendice (+1 Resistencia)")
	var/energy_spent = 0
	var/energy_required = 1000

/datum/objective/personal/energy_expenditure/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_ENERGY_SPENT, PROC_REF(on_energy_spent))
	update_explanation_text()

/datum/objective/personal/energy_expenditure/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_MOB_ENERGY_SPENT)
	return ..()

/datum/objective/personal/energy_expenditure/proc/on_energy_spent(datum/source, amount)
	SIGNAL_HANDLER
	if(completed)
		return

	energy_spent += amount
	if(energy_spent >= energy_required)
		complete_objective()

/datum/objective/personal/energy_expenditure/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has gastado suficiente energia trabajando para satisfacer Malum!"))
	adjust_storyteller_influence(MALUM, 20)
	UnregisterSignal(owner.current, COMSIG_MOB_ENERGY_SPENT)

/datum/objective/personal/energy_expenditure/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_MALUM_BLESSING, list(STAT_ENDURANCE = 1))

/datum/objective/personal/energy_expenditure/update_explanation_text()
	explanation_text = "¡No seas holgazan! Gasta al menos [energy_required] de energia trabajando para satisfacer a Malum."
