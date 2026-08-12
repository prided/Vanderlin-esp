/datum/chimeric_node/output/vomit
	name = "nauseous"
	desc = "Cuando se activa provoca vómitos."

/datum/chimeric_node/output/vomit/trigger_effect(multiplier)
	. = ..()
	hosted_carbon.vomit()
