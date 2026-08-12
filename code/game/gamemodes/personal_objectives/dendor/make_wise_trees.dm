/datum/objective/personal/wise_trees
	name = "Crear arboles sabios"
	category = "Elegido de Dendor"
	triumph_count = 2
	immediate_effects = list("Obtuviste una habilidad para crear arboles sabios")
	rewards = list("2 Triunfos", "Dendor se fortalece", "Dendor te bendice (+1 Fortuna)")
	var/trees_transformed = 0
	var/trees_required = 3

/datum/objective/personal/wise_trees/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_TREE_TRANSFORMED, PROC_REF(on_tree_transformed))
	update_explanation_text()

/datum/objective/personal/wise_trees/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_TREE_TRANSFORMED)
	return ..()

/datum/objective/personal/wise_trees/proc/on_tree_transformed(datum/source)
	SIGNAL_HANDLER
	if(completed)
		return

	trees_transformed++
	to_chat(owner.current, span_green("¡Arbol transformado! Aun hay [trees_required - trees_transformed] planta\s por transformar."))

	if(trees_transformed >= trees_required)
		complete_objective()

/datum/objective/personal/wise_trees/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has creado suficientes arboles sabios para satisfacer a Dendor!"))
	adjust_storyteller_influence(DENDOR, 20)
	UnregisterSignal(owner.current, COMSIG_TREE_TRANSFORMED)

/datum/objective/personal/wise_trees/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_DENDOR_BLESSING, list(STAT_FORTUNE = 1))

/datum/objective/personal/wise_trees/update_explanation_text()
	explanation_text = "Transforma [trees_required] arboles comunes en arboles sabios guardianes mediante la bendicion de Dendor."
