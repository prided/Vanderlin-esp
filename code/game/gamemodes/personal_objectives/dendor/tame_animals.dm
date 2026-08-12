/datum/objective/personal/tame_animal
	name = "Domesticar un animal"
	category = "Elegido de Dendor"
	triumph_count = 2
	rewards = list("2 Triunfos", "Dendor se fortalece", "Conocimientos de domesticacion")
	var/tamed_count = 0
	var/required_tames = 1

/datum/objective/personal/tame_animal/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ANIMAL_TAMED, PROC_REF(on_animal_tamed))
	update_explanation_text()

/datum/objective/personal/tame_animal/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ANIMAL_TAMED)
	return ..()

/datum/objective/personal/tame_animal/proc/on_animal_tamed(datum/source, mob/living/simple_animal/animal)
	SIGNAL_HANDLER
	if(completed)
		return

	tamed_count++
	if(tamed_count >= required_tames)
		complete_objective(animal)

/datum/objective/personal/tame_animal/complete_objective(mob/living/simple_animal/animal)
	. = ..()
	to_chat(owner.current, span_greentext("¡Has domesticado a [animal], cumpliendo la voluntad de Dendor!"))
	adjust_storyteller_influence(DENDOR, 20)
	UnregisterSignal(owner.current, COMSIG_ANIMAL_TAMED)

/datum/objective/personal/tame_animal/reward_owner()
	. = ..()
	owner.current.adjust_skill_level(/datum/attribute/skill/labor/taming, 10)

/datum/objective/personal/tame_animal/update_explanation_text()
	explanation_text = "Domestica un animal, alimentandolo o por cualquier otro medio, hasta que te reconozca como amigo. ¡Dendor asi lo quiere!"
