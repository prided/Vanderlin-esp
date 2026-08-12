/datum/objective/personal/improve_combat
	name = "Mejorar las habilidades de combate"
	category = "Elegido de Ravox"
	triumph_count = 2
	rewards = list("2 Triunfos", "Ravox se fortalece", "Ravox te bendice (+1 Fuerza)")
	var/levels_gained = 0
	var/required_levels = 20

/datum/objective/personal/improve_combat/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SKILL_RANK_CHANGE, PROC_REF(on_skill_change))
	update_explanation_text()

/datum/objective/personal/improve_combat/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SKILL_RANK_CHANGE)
	return ..()

/datum/objective/personal/improve_combat/proc/on_skill_change(datum/source, datum/attribute/skill/skill_ref, new_level, old_level)
	SIGNAL_HANDLER
	if(completed)
		return

	if(!ispath(skill_ref, /datum/attribute/skill/combat))
		return

	var/real_old = (old_level == SKILL_RANK_NONE && !GET_MOB_SKILL_VALUE(owner.current, skill_ref)) ? SKILL_RANK_NONE : old_level

	if(new_level <= real_old)
		return

	var/level_diff = new_level - real_old
	levels_gained += level_diff

	if(levels_gained >= required_levels)
		complete_objective()
	else
		var/remaining = required_levels - levels_gained
		to_chat(owner.current, span_notice("¡Habilidad de combate mejorada! Faltan [remaining] punto[remaining == 1 ? "" : "s"] para cumplir la tarea de Ravox."))

/datum/objective/personal/improve_combat/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has mejorado tus habilidades de combate lo suficiente para satisfacer a Ravox!"))
	adjust_storyteller_influence(RAVOX, 20)
	UnregisterSignal(owner.current, COMSIG_SKILL_RANK_CHANGE)

/datum/objective/personal/improve_combat/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_RAVOX_BLESSING, list(STAT_STRENGTH = 1))

/datum/objective/personal/improve_combat/update_explanation_text()
	explanation_text = "Mejora tus habilidades de combate al obtener [required_levels] puntos nuevos mediante la practica o los sueños. ¡Por Ravox!"
