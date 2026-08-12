/datum/objective/personal/retainer
	name = "Reclutar vasallo"
	category = "Elegido de Astrata"
	triumph_count = 2
	immediate_effects = list("Obtuviste una habilidad para reclutar vasallos")
	rewards = list("2 Triunfos", "Astrata se fortalece", "Astrata te bendice (+1 Fortuna)")
	var/retainers_recruited = 0

/datum/objective/personal/retainer/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.add_spell(/datum/action/cooldown/spell/undirected/list_target/convert_role/retainer, source = src)
	RegisterSignal(SSdcs, COMSIG_GLOBAL_ROLE_CONVERTED, PROC_REF(on_retainer_recruited))
	update_explanation_text()

/datum/objective/personal/retainer/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOBAL_ROLE_CONVERTED)
	return ..()

/datum/objective/personal/retainer/proc/on_retainer_recruited(datum/source, mob/living/carbon/human/recruiter, mob/living/carbon/human/recruit, new_role)
	SIGNAL_HANDLER
	if(completed || recruiter != owner.current || new_role != "Retainer of [recruiter.real_name]")
		return

	retainers_recruited++
	if(retainers_recruited >= 1)
		complete_objective()

/datum/objective/personal/retainer/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has reclutado un vasallo y completado el objetivo de Astrata!"))
	adjust_storyteller_influence(ASTRATA, 20)

/datum/objective/personal/retainer/reward_owner()
	. = ..()
	owner.current.adjust_stat_modifier(STATMOD_ASTRATA_BLESSING, list(STAT_FORTUNE = 1))

/datum/objective/personal/retainer/update_explanation_text()
	explanation_text = "Recluta al menos un vasallo que te sirva y demuestra a Astrata tu capacidad de liderazgo."

/datum/action/cooldown/spell/undirected/list_target/convert_role/retainer
	name = "Reclutar vasallo"
	button_icon_state = "recruit_servant"

	new_role = "Retainer"
	recruitment_faction = "Vasallos"
	recruitment_message = "¡Unete a mi servicio como vasallo, %RECRUIT!"
	accept_message = "¡Juro servirte!"
	refuse_message = "Debo rechazar tu oferta."

/datum/action/cooldown/spell/undirected/list_target/convert_role/retainer/cast(mob/living/carbon/human/cast_on)
	new_role = "Retainer of [owner.real_name]"
	return ..()
