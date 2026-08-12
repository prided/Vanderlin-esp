/datum/objective/personal/create_abyssoids
	name = "Crear abisoides"
	category = "Elegido de Abyssor"
	triumph_count = 2
	immediate_effects = list("Obtuviste una habilidad para crear sanguijuelas abyssoid")
	rewards = list("2 Triunfos", "Abyssor se fortalece", "Abyssor te bendice (+1 Constitucion)")
	var/abyssoids_created = 0
	var/abyssoids_required = 5

/datum/objective/personal/create_abyssoids/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ABYSSOID_CREATED, PROC_REF(on_abyssoid_created))
	update_explanation_text()

/datum/objective/personal/create_abyssoids/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ABYSSOID_CREATED)
	return ..()

/datum/objective/personal/create_abyssoids/proc/on_abyssoid_created(datum/source)
	SIGNAL_HANDLER
	if(completed)
		return

	abyssoids_created++

	if(abyssoids_created >= abyssoids_required)
		complete_objective()
	else
		to_chat(owner.current, span_notice("¡Abyssoid creado! Faltan [abyssoids_required - abyssoids_created] abyssoid\s."))

/datum/objective/personal/create_abyssoids/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has creado suficientes abyssoids para satisfacer a Abyssor!"))
	adjust_storyteller_influence(ABYSSOR, 20)
	UnregisterSignal(owner.current, COMSIG_ABYSSOID_CREATED)

/datum/objective/personal/create_abyssoids/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_ABYSSOR_BLESSING, list(STAT_CONSTITUTION = 1))

/datum/objective/personal/create_abyssoids/update_explanation_text()
	explanation_text = "¡Crea [abyssoids_required] abyssoid\s a partir de sanguijuelas comunes y distribuyelos entre la poblacion ingrata!"
