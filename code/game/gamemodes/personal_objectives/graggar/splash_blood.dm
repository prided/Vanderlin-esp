/datum/objective/personal/blood_splash
	name = "Salpicarse con sangre"
	category = "Elegido de Graggar"
	triumph_count = 2
	rewards = list("2 Triunfos", "Graggar se fortalece", "Graggar te bendice (+1 Fuerza, +1 Constitucion)")

/datum/objective/personal/blood_splash/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SPLASHED_MOB, PROC_REF(on_blood_splashed))
	update_explanation_text()

/datum/objective/personal/blood_splash/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)
	return ..()

/datum/objective/personal/blood_splash/proc/on_blood_splashed(datum/source, mob/target, list/reagents_splashed)
	SIGNAL_HANDLER
	if(completed || target != owner.current)
		return

	var/blood_amount = 0
	for(var/datum/reagent/reagent_type as anything in reagents_splashed)
		if(istype(reagent_type, /datum/reagent/blood))
			blood_amount += reagent_type.volume

	if(blood_amount >= 30)
		complete_objective()

/datum/objective/personal/blood_splash/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has realizado el ritual de sangre y aplacado a Graggar!"))
	adjust_storyteller_influence(GRAGGAR, 20)
	UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)

/datum/objective/personal/blood_splash/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_GRAGGAR_BLESSING, list(
		STAT_STRENGTH = 1,
		STAT_CONSTITUTION =1,
	))

/datum/objective/personal/blood_splash/update_explanation_text()
	explanation_text = "Hay gran poder en la sangre. ¡Vierte sobre ti un balde lleno de sangre para aplacar a Graggar!"
