/datum/objective/personal/torture
	name = "Extraer la verdad a traves del dolor"
	category = "Elegido de Zizo"
	triumph_count = 3
	immediate_effects = list("Obtuviste una habilidad para torturar a otros y obtener informacion")
	rewards = list("3 Triunfos", "Zizo se fortalece", "Zizo te bendice (+1 Fuerza, +1 Resistencia)")
	var/torture_count = 0
	var/required_count = 1

/datum/objective/personal/torture/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_TORTURE_PERFORMED, PROC_REF(on_torture_performed))
	update_explanation_text()

/datum/objective/personal/torture/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_TORTURE_PERFORMED)
	return ..()

/datum/objective/personal/torture/proc/on_torture_performed(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	if(completed)
		return

	torture_count++
	if(torture_count >= required_count)
		complete_objective(victim)

/datum/objective/personal/torture/complete_objective(mob/living/victim)
	. = ..()
	to_chat(owner.current, span_greentext("¡Has extraido la verdad mediante el dolor y satisfecho a Zizo!"))
	adjust_storyteller_influence(ZIZO, 20)
	UnregisterSignal(owner.current, COMSIG_TORTURE_PERFORMED)

/datum/objective/personal/torture/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_ZIZO_BLESSING, list(
		STAT_STRENGTH = 1,
		STAT_ENDURANCE =1,
	))

/datum/objective/personal/torture/update_explanation_text()
	explanation_text = "¡Tortura a alguien hasta que suplique clemencia para complacer a Zizo!"
