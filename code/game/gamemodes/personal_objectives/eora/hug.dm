/datum/objective/personal/hug_beggar
	name = "Abrazar a un mendigo"
	category = "Elegido de Eora"
	triumph_count = 2
	rewards = list("2 Triunfos", "Eora se fortalece", "Te vuelves mas empatico")

/datum/objective/personal/hug_beggar/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_HUGGED, PROC_REF(on_hug))
	update_explanation_text()

/datum/objective/personal/hug_beggar/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_MOB_HUGGED)
	return ..()

/datum/objective/personal/hug_beggar/proc/on_hug(datum/source, mob/living/target)
	SIGNAL_HANDLER
	if(completed)
		return

	if(target.job == JOB_BEGGAR || istype(target.mind?.assigned_role, /datum/job/vagrant))
		complete_objective()

/datum/objective/personal/hug_beggar/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has abrazado a un mendigo y completado el objetivo de Eora!"))
	adjust_storyteller_influence(EORA, 20)
	UnregisterSignal(owner.current, COMSIG_MOB_HUGGED)

/datum/objective/personal/hug_beggar/reward_owner()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_EMPATH, OBJECTIVE_TRAIT)

/datum/objective/personal/hug_beggar/update_explanation_text()
	explanation_text = "¡Todos merecen amor! ¡Abraza a un mendigo para complacer a Eora!"
