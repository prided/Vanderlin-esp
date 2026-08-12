/datum/objective/personal/steal_items
	name = "Robar articulos"
	category = "Matthios' Elegido"
	triumph_count = 2
	rewards = list("2 Triunfos", "Matthios se fortalece", "Conocimientos de carterismo", "Matthios te bendice (+1 Velocidad)")
	var/stolen_count = 0
	var/required_count = 2

/datum/objective/personal/steal_items/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ITEM_STOLEN, PROC_REF(on_item_stolen))
	update_explanation_text()

/datum/objective/personal/steal_items/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ITEM_STOLEN)
	return ..()

/datum/objective/personal/steal_items/proc/on_item_stolen(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	if(completed)
		return

	stolen_count++
	if(stolen_count >= required_count)
		complete_objective()
	else
		to_chat(owner.current, span_notice("¡Objeto robado! Roba [required_count - stolen_count] mas para completar el objetivo de Matthios."))

/datum/attribute_modifier/steal_items
	attribute_list = list(
		/datum/attribute/skill/misc/stealing = 10
	)

/datum/objective/personal/steal_items/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has robado suficientes objetos para completar el objetivo de Matthios!"))
	adjust_storyteller_influence(MATTHIOS, 20)
	UnregisterSignal(owner.current, COMSIG_ITEM_STOLEN)

/datum/objective/personal/steal_items/reward_owner()
	. = ..()
	owner.current.attributes?.add_attribute_modifier(/datum/attribute_modifier/steal_items)
	owner.current.adjust_stat_modifier(STATMOD_MATTHIOS_BLESSING, list(STAT_SPEED = 1))

/datum/objective/personal/steal_items/update_explanation_text()
	explanation_text = "¡Roba [required_count] objeto\s ajenos para demostrar tu astucia a Matthios!"
