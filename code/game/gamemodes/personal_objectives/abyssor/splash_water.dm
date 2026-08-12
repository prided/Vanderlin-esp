/datum/objective/personal/abyssor_splash
	name = "Salpicar con agua"
	category = "Elegido de Abyssor"
	triumph_count = 2
	rewards = list("2 Triunfos", "Abyssor se fortalece", "Abyssor te bendice (+1 Fuerza)")

/datum/objective/personal/abyssor_splash/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SPLASHED_MOB, PROC_REF(on_mob_splashed))
	update_explanation_text()

/datum/objective/personal/abyssor_splash/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)
	return ..()

/datum/objective/personal/abyssor_splash/proc/on_mob_splashed(datum/source, mob/target, list/reagents_splashed)
	SIGNAL_HANDLER
	if(completed || target == owner.current || target.stat == DEAD || !target.client)
		return

	var/water_volume = 0
	for(var/datum/reagent/reagent_type as anything in reagents_splashed)
		if(istype(reagent_type, /datum/reagent/water))
			water_volume += reagent_type.volume

	if(water_volume >= 30)
		complete_objective()

/datum/objective/personal/abyssor_splash/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has desatado la furia de Abyssor y completado el objetivo!"))
	adjust_storyteller_influence(ABYSSOR, 20)
	UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)

/datum/objective/personal/abyssor_splash/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_ABYSSOR_BLESSING, list(STAT_STRENGTH =  1))

/datum/objective/personal/abyssor_splash/update_explanation_text()
	explanation_text = "¡Abyssor esta FURIOSO! ¡Vacia un balde de agua sobre algun ingrato que haya olvidado su nombre!"
