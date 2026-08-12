/datum/objective/personal/proper_burial
	name = "Consagrar tumbas"
	category = "Elegido de Necra"
	triumph_count = 2
	rewards = list("2 Triunfos", "Necra se fortalece", "No enfermaras por olores desagradables")
	var/burials_completed = 0
	var/required_burials = 1

/datum/objective/personal/proper_burial/on_creation()
	. = ..()
	if(owner?.current)
		if(owner.current.job == JOB_GRAVETENDER || istype(owner.current.mind?.assigned_role, /datum/job/undertaker))
			required_burials = 2
		RegisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED, PROC_REF(on_grave_consecrated))
	update_explanation_text()

/datum/objective/personal/proper_burial/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED)
	return ..()

/datum/objective/personal/proper_burial/proc/on_grave_consecrated(datum/source, obj/structure/closet/dirthole/hole)
	SIGNAL_HANDLER
	if(completed)
		return

	burials_completed++
	if(burials_completed >= required_burials)
		complete_objective()
	else
		to_chat(owner.current, span_notice("¡Tumba consagrada! Consagra [required_burials - burials_completed] mas para completar la prueba de Necra."))

/datum/objective/personal/proper_burial/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has consagrado suficientes tumbas para obtener la aprobacion de Necra!"))
	adjust_storyteller_influence(NECRA, 20)
	UnregisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED)

/datum/objective/personal/proper_burial/reward_owner()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_DEADNOSE, OBJECTIVE_TRAIT)

/datum/objective/personal/proper_burial/update_explanation_text()
	explanation_text = "Consagra [required_burials] tumba\s mediante una lapida o ritos funerarios para obtener la aprobacion de Necra."
