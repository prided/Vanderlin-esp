/datum/objective/personal/hoard_mammons
	name = "Acumular mammons"
	category = "Matthios' Elegido"
	triumph_count = 2
	rewards = list("2 Triunfos", "Matthios se fortalece", "Habilidad para ver el valor de los objetos al examinarlos", "Matthios te bendice (+1 Fortuna)")
	var/target_mammons = 300
	var/current_amount = 0
	var/check_cooldown = 20 SECONDS
	var/next_check = 0

/datum/objective/personal/hoard_mammons/on_creation()
	. = ..()
	target_mammons = pick(250, 300, 350)
	START_PROCESSING(SSprocessing, src)
	update_explanation_text()

/datum/objective/personal/hoard_mammons/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/objective/personal/hoard_mammons/process()
	if(world.time < next_check || completed || !owner?.current)
		return

	next_check = world.time + check_cooldown
	check_mammons()

/datum/objective/personal/hoard_mammons/proc/check_mammons()
	var/mob/living/user = owner.current
	if(!istype(user) || user.stat == DEAD)
		return

	var/mammon_count = get_mammons_in_atom(user)
	if(mammon_count >= target_mammons && !completed)
		complete_objective()

/datum/objective/personal/hoard_mammons/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has acumulado suficientes mammons y completado el objetivo de Matthios!"))
	adjust_storyteller_influence(MATTHIOS, 20)
	STOP_PROCESSING(SSprocessing, src)

/datum/objective/personal/hoard_mammons/reward_owner()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_SEEPRICES, OBJECTIVE_TRAIT)
	owner.current.adjust_stat_modifier(STATMOD_MATTHIOS_BLESSING, list(STAT_FORTUNE = 1))

/datum/objective/personal/hoard_mammons/update_explanation_text()
	explanation_text = "Acumula al menos [target_mammons] mammons para demostrar tu avaricia a Matthios."
