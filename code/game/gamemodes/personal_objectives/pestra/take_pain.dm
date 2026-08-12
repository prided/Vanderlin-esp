/datum/objective/personal/take_pain
	name = "Asumir dolor"
	category = "Elegido de Pestra"
	triumph_count = 3
	immediate_effects = list("Obtuviste una habilidad para asumir el dolor ajeno")
	rewards = list("3 Triunfos", "Pestra se fortalece", "Pestra te bendice (+1 Constitucion)")
	var/total_pain_taken = 0
	var/target_pain = 500

/datum/objective/personal/take_pain/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_PAIN_TRANSFERRED, PROC_REF(on_pain_transferred))
	update_explanation_text()

/datum/objective/personal/take_pain/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_PAIN_TRANSFERRED)
	return ..()

/datum/objective/personal/take_pain/proc/on_pain_transferred(datum/source, amount)
	SIGNAL_HANDLER
	if(completed)
		return

	total_pain_taken += amount

	var/progress_ratio = total_pain_taken / target_pain
	if(progress_ratio < 0.25)
		to_chat(owner.current, span_green("Sientes una pequeña cantidad de dolor fluir por ti. Pestra esta complacida, pero aun queda mucho sufrimiento por aliviar."))
	else if(progress_ratio < 0.5)
		to_chat(owner.current, span_green("El dolor que has asumido pesa sobre ti. Continua; la obra de Pestra aun no termina."))
	else if(progress_ratio < 0.75)
		to_chat(owner.current, span_green("La agonia que has absorbido es considerable. Progresas bien en nombre de Pestra."))
	else if(progress_ratio < 1)
		to_chat(owner.current, span_green("El dolor es casi abrumador, pero sientes que estas cerca de completar la tarea de Pestra."))

	if(total_pain_taken >= target_pain)
		complete_objective()

/datum/objective/personal/take_pain/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has asumido suficiente dolor ajeno y completado el objetivo de Pestra! Tu sacrificio recibe recompensa."))
	adjust_storyteller_influence(PESTRA, 20)
	UnregisterSignal(owner.current, COMSIG_PAIN_TRANSFERRED)

/datum/objective/personal/take_pain/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_PESTRA_BLESSING, list(STAT_CONSTITUTION = 1))

/datum/objective/personal/take_pain/update_explanation_text()
	explanation_text = "Asume suficiente dolor ajeno como acto de misericordia y devocion a Pestra."
