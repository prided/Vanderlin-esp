/datum/objective/personal/ultimate_sacrifice
	name = "Sacrificio definitivo"
	category = "Elegido de Ravox"
	triumph_count = 3
	immediate_effects = list("Obtuviste una habilidad para entregar tu vida y salvar a otra persona")
	rewards = list("3 Triunfos", "Ravox se fortalece", "Muerte honorable")

/datum/objective/personal/ultimate_sacrifice/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.add_spell(/datum/action/cooldown/spell/undirected/list_target/ultimate_sacrifice, source = src)
	update_explanation_text()

/datum/objective/personal/ultimate_sacrifice/complete_objective()
	. = ..()
	adjust_storyteller_influence(RAVOX, 20)

/datum/objective/personal/ultimate_sacrifice/update_explanation_text()
	explanation_text = "Haz el mayor sacrificio: entrega tu vida para salvar un alma verdaderamente inocente y digna en nombre de Ravox."
