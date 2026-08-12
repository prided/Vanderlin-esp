/datum/objective/personal/build_zizo_shrine
	name = "Construir cruces invertidas"
	category = "Elegido de Zizo"
	triumph_count = 2
	immediate_effects = list("Obtuviste una habilidad para construir cruces invertidas")
	rewards = list("2 Triunfos", "Zizo se fortalece", "Zizo te bendice (+2 Fortuna)")
	var/target_type = /obj/structure/fluff/psycross/zizocross
	var/target_count = 2
	var/current_count = 0

/datum/objective/personal/build_zizo_shrine/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ITEM_CRAFTED, PROC_REF(on_item_crafted))
	update_explanation_text()

/datum/objective/personal/build_zizo_shrine/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)
	return ..()

/datum/objective/personal/build_zizo_shrine/proc/on_item_crafted(datum/source, mob/user, craft_path)
	SIGNAL_HANDLER
	if(completed || !ispath(craft_path, target_type))
		return

	current_count++
	if(current_count < target_count)
		to_chat(owner.current, span_notice("Has construido [current_count] de [target_count] cruces invertidas."))
		return

	complete_objective()

/datum/objective/personal/build_zizo_shrine/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has construido todas las cruces invertidas necesarias, completando el objetivo de Zizo!"))
	adjust_storyteller_influence(ZIZO, 20)
	UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)

/datum/objective/personal/build_zizo_shrine/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_ZIZO_BLESSING, list(STAT_FORTUNE = 2))

/datum/objective/personal/build_zizo_shrine/update_explanation_text()
	explanation_text = "¡Construye [target_count] altar[target_count > 1 ? "s" : ""] con cruces invertidas para propagar la corrupcion de Zizo!"
