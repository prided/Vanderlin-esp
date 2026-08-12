/datum/objective/personal/craft_shrine
	name = "construir santuarios"
	category = "Elegido de Malum"
	triumph_count = 2
	rewards = list("2 Triunfos", "Malum se fortalece", "Conocimientos de artesania")
	var/target_type = /obj/structure/fluff/psycross/crafted
	var/target_count = 2
	var/current_count = 0

/datum/objective/personal/craft_shrine/New(text, datum/mind/owner, obj/target_path, count)
	if(target_path)
		target_type = target_path
	if(count)
		target_count = count
	. = ..()

/datum/objective/personal/craft_shrine/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ITEM_CRAFTED, PROC_REF(on_item_crafted))
	update_explanation_text()

/datum/objective/personal/craft_shrine/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)
	return ..()

/datum/objective/personal/craft_shrine/proc/on_item_crafted(datum/source, mob/user, craft_path)
	SIGNAL_HANDLER
	if(completed || !ispath(craft_path, target_type))
		return

	current_count++
	if(current_count < target_count)
		to_chat(owner.current, span_notice("Has construido [current_count] de [target_count] cruces sagradas."))
		return
	else
		complete_objective()

/datum/objective/personal/craft_shrine/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has construido todas las cruces sagradas necesarias y completado el objetivo de Malum!"))
	adjust_storyteller_influence(MALUM, 20)
	UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)

/datum/objective/personal/craft_shrine/reward_owner()
	. = ..()
	owner.current.adjust_skill_level(/datum/attribute/skill/craft/crafting, 10)

/datum/objective/personal/craft_shrine/update_explanation_text()
	explanation_text = "Construye [target_count] altar[target_count > 1 ? "es" : ""] de madera con la cruz del panteon para demostrar tu devocion a Malum."
