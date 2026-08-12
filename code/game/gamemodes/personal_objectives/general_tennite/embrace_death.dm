/datum/objective/personal/embrace_death
	name = "Abrazar la muerte"
	category = "Marcado por Necra"
	triumph_count = 3
	immediate_effects = list("Obtuviste una habilidad para morir en paz")
	rewards = list("3 Triunfos", "Necra se fortalece", "Descanso eterno")

/datum/objective/personal/embrace_death/on_creation()
	. = ..()
	if(owner?.current)
		var/datum/action/innate/embrace_death/action = new(src)
		action.Grant(owner.current)
	update_explanation_text()

/datum/objective/personal/embrace_death/complete_objective()
	. = ..()
	adjust_storyteller_influence(NECRA, 20)

/datum/objective/personal/embrace_death/update_explanation_text()
	explanation_text = "Ha llegado tu hora. Abraza la muerte mediante el don de Necra para alcanzar el descanso final y asegurar tu alma."
