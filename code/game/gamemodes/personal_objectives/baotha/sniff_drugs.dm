/datum/objective/personal/sniff_drugs
	name = "Oler drogas"
	category = "Elegido de Baotha"
	triumph_count = 2
	rewards = list("2 Triunfos", "Baotha se fortalece", "Habilidad para reconocer alcoholicos y drogadictos al examinarlos", "Baotha te bendice (+1 Fortuna)")
	var/sniff_count = 0
	var/required_count = 2

/datum/objective/personal/sniff_drugs/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_DRUG_SNIFFED, PROC_REF(on_drug_sniffed))
	update_explanation_text()

/datum/objective/personal/sniff_drugs/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_DRUG_SNIFFED)
	return ..()

/datum/objective/personal/sniff_drugs/proc/on_drug_sniffed(datum/source, mob/living/sniffer)
	SIGNAL_HANDLER
	if(completed)
		return

	sniff_count++
	if(sniff_count >= required_count)
		complete_objective()
	else
		to_chat(owner.current, span_notice("¡Droga inhalada! Inhala [required_count - sniff_count] mas para completar el objetivo de Baotha."))

/datum/objective/personal/sniff_drugs/complete_objective()
	. = ..()
	to_chat(owner.current, span_greentext("¡Has olido suficientes drogas para completar el objetivo de Baotha!"))
	adjust_storyteller_influence(BAOTHA, 20)
	UnregisterSignal(owner.current, COMSIG_DRUG_SNIFFED)

/datum/objective/personal/sniff_drugs/reward_owner()
	. = ..()
	ADD_TRAIT(owner.current, TRAIT_RECOGNIZE_ADDICTS, OBJECTIVE_TRAIT)
	owner.current.adjust_stat_modifier(STATMOD_BAOTHA_BLESSING, list(STAT_FORTUNE = 1))

/datum/objective/personal/sniff_drugs/update_explanation_text()
	explanation_text = "¡Inhala [required_count] drogas para complacer a Baotha!"
