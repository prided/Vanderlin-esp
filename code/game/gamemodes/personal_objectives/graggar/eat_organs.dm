/datum/objective/personal/consume_organs
	name = "Consumir organos"
	category = "Elegido de Graggar"
	triumph_count = 2
	immediate_effects = list("Obtuviste una habilidad para arrancar corazones de cadaveres")
	rewards = list("2 Triunfos", "Graggar se fortalece", "Graggar te bendice (+1 Fuerza, +1 Constitucion)")
	var/organs_consumed = 0
	var/hearts_consumed = 0
	var/organs_required = 3
	var/hearts_required = 1

/datum/objective/personal/consume_organs/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ORGAN_CONSUMED, PROC_REF(on_organ_consumed))
	update_explanation_text()

/datum/objective/personal/consume_organs/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ORGAN_CONSUMED)
	return ..()

/datum/objective/personal/consume_organs/proc/on_organ_consumed(datum/source, organ_type, obj/item/organ/organ_inside)
	SIGNAL_HANDLER
	if(completed)
		return

	organs_consumed++

	if(ispath(organ_type, /obj/item/reagent_containers/food/snacks/meat/organ/heart))
		hearts_consumed++
		to_chat(owner.current, span_cult("¡Sientes el placer de Graggar mientras consumes un corazon!"))
	else
		to_chat(owner.current, span_notice("¡Organo consumido! Faltan [organs_required - organs_consumed] organo\s."))

	if(organs_consumed >= organs_required && hearts_consumed >= hearts_required)
		complete_objective()

/datum/objective/personal/consume_organs/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has consumido suficientes organos y corazones para satisfacer a Graggar!"))
	adjust_storyteller_influence(GRAGGAR, 20)
	UnregisterSignal(owner.current, COMSIG_ORGAN_CONSUMED)

/datum/objective/personal/consume_organs/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_GRAGGAR_BLESSING, list(
		STAT_STRENGTH = 1,
		STAT_CONSTITUTION = 1
	))

/datum/objective/personal/consume_organs/update_explanation_text()
	explanation_text = "¡Consume [organs_required] organo\s, incluidas [hearts_required] pieza\s de corazon, para aplacar a Graggar!"
