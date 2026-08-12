/datum/objective/personal/taste_lux
	name = "Taste Divine Essence"
	category = "Elegido de Baotha"
	triumph_count = 3
	rewards = list("3 Triunfos", "Baotha se fortalece", "Baotha te bendice (+2 Fortuna)")

/datum/objective/personal/taste_lux/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_LUX_TASTED, PROC_REF(on_lux_tasted))
	update_explanation_text()

/datum/objective/personal/taste_lux/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_LUX_TASTED)
	return ..()

/datum/objective/personal/taste_lux/proc/on_lux_tasted()
	SIGNAL_HANDLER
	if(completed)
		return

	complete_objective()

/datum/objective/personal/taste_lux/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has probado la esencia divina y completado el objetivo de Baotha!"))
	adjust_storyteller_influence(BAOTHA, 20)
	UnregisterSignal(owner.current, COMSIG_LUX_TASTED)

/datum/objective/personal/taste_lux/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_BAOTHA_BLESSING, list(STAT_FORTUNE = 2))

/datum/objective/personal/taste_lux/update_explanation_text()
	explanation_text = "¡Experimenta lo divino al probar la esencia prohibida Lux! Baotha observa..."
