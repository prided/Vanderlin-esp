/datum/objective/personal/mock
	name = "Burlarse"
	category = "Elegido de Xylix"
	triumph_count = 2
	rewards = list("2 Triunfos", "Xylix se fortalece")

/datum/objective/personal/mock/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED, PROC_REF(on_mock_used))
	update_explanation_text()

/datum/objective/personal/mock/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED)
	return ..()

/datum/objective/personal/mock/proc/on_mock_used(datum/source, mob/living/target, mob/living/user)
	SIGNAL_HANDLER
	return

/// Monarch variant
/datum/objective/personal/mock/monarch
	name = "Burlarse del monarca"
	immediate_effects = list("Obtuviste una habilidad para burlarte cruelmente de otros")

/datum/objective/personal/mock/monarch/on_mock_used(datum/source, mob/living/victim)
	. = ..()
	if((istype(victim.mind?.assigned_role, /datum/job/lord) || victim.job == JOB_MONARCH) && (source == owner.current))
		complete_objective()

/datum/objective/personal/mock/monarch/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Te has burlado del monarca y completado el objetivo!"))
	adjust_storyteller_influence(XYLIX, 20)
	UnregisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED)

/datum/objective/personal/mock/monarch/update_explanation_text()
	. = ..()
	explanation_text = "¡Burlate cruelmente del monarca por Xylix!"

/// Noble variant
/datum/objective/personal/mock/noble
	name = "Burlarse de los nobles"
	rewards = list("2 Triunfos", "Xylix se fortalece", "Xylix te bendice (+1 Fortuna)")
	var/mocked_targets = 0
	var/required_count = 2

/datum/objective/personal/mock/noble/on_mock_used(datum/source, mob/living/victim)
	. = ..()
	var/mob/living/carbon/human/human_victim = victim
	if(!istype(human_victim) || human_victim.stat == DEAD || human_victim == source)
		return

	if(human_victim.is_noble() && (source == owner.current))
		mocked_targets++
		if(mocked_targets >= required_count)
			complete_objective()
		else
			to_chat(owner.current, span_notice("¡Noble ridiculizado! ¡Burlate cruelmente de [required_count - mocked_targets] noble mas para completar el objetivo!"))

/datum/objective/personal/mock/noble/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Te has burlado de suficientes nobles y completado el objetivo!"))
	adjust_storyteller_influence(XYLIX, 20)
	UnregisterSignal(owner.current, COMSIG_VICIOUSLY_MOCKED)

/datum/objective/personal/mock/noble/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_XYLIX_BLESSING, list(STAT_FORTUNE = 1))

/datum/objective/personal/mock/noble/update_explanation_text()
	. = ..()
	explanation_text = "¡Burlate cruelmente de [required_count] nobles por Xylix!"
