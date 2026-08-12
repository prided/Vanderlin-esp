/datum/objective/personal/rotten_feast
	name = "Festin podrido"
	category = "Elegido de Pestra"
	triumph_count = 2
	rewards = list("2 Triunfos", "Pestra se fortalece", "Pestra te bendice (+1 Constitucion)")
	var/meals_eaten = 0
	var/meals_required = 1

/datum/objective/personal/rotten_feast/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ROTTEN_FOOD_EATEN, PROC_REF(on_rotten_eaten))
	update_explanation_text()

/datum/objective/personal/rotten_feast/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ROTTEN_FOOD_EATEN)
	return ..()

/datum/objective/personal/rotten_feast/proc/on_rotten_eaten(datum/source, obj/item/eaten_food)
	SIGNAL_HANDLER
	if(completed)
		return

	meals_eaten++
	if(meals_eaten >= meals_required)
		complete_objective()
	else
		to_chat(owner.current, span_notice("¡Comida podrida consumida! Come [meals_required - meals_eaten] mas para completar el objetivo de Pestra."))

/datum/objective/personal/rotten_feast/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has consumido suficiente comida podrida para completar el objetivo de Pestra!"))
	adjust_storyteller_influence(PESTRA, 20)
	UnregisterSignal(owner.current, COMSIG_ROTTEN_FOOD_EATEN)

/datum/objective/personal/rotten_feast/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_PESTRA_BLESSING, list(STAT_CONSTITUTION = 1))

/datum/objective/personal/rotten_feast/update_explanation_text()
	explanation_text = "¡No desperdicies nada! ¡Consume [meals_required] porcion de comida podrida para obtener el favor de Pestra!"
