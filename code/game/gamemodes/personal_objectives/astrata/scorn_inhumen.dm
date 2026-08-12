/datum/objective/personal/inhumen_scorn
	name = "Despreciar a los Inhumen"
	category = "Elegido de Astrata"
	triumph_count = 2
	rewards = list("2 Triunfos", "Astrata se fortalece", "Habilidad para silenciar a los Inhumen")
	var/spits_done = 0
	var/spits_required = 1

/datum/objective/personal/inhumen_scorn/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SPAT_ON, PROC_REF(on_spit))
	update_explanation_text()

/datum/objective/personal/inhumen_scorn/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SPAT_ON)
	return ..()

/datum/objective/personal/inhumen_scorn/proc/on_spit(datum/source, mob/living/carbon/human/target)
	SIGNAL_HANDLER
	if(completed || !istype(target) || target.stat == DEAD || (target.dna?.species.id in RACES_PLAYER_NONHERETICAL))
		return

	spits_done++

	if(spits_done < spits_required)
		to_chat(owner.current, span_notice("¡Inhumen humillado! ¡Humilla a [spits_required - spits_done] mas para completar el objetivo!"))
	else
		complete_objective()

/datum/objective/personal/inhumen_scorn/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has humillado a suficientes Inhumen y completado el objetivo de Astrata!"))
	adjust_storyteller_influence(ASTRATA, 20)
	UnregisterSignal(owner.current, COMSIG_SPAT_ON)

/datum/objective/personal/inhumen_scorn/reward_owner()
	. = ..()
	owner.current.add_spell(/datum/action/cooldown/spell/silence_inhumen, source = src)

/datum/objective/personal/inhumen_scorn/update_explanation_text()
	explanation_text = "¡Escupe a [spits_required] Inhumen para obtener la aprobacion de Astrata!"
