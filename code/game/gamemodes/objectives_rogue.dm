/datum/objective/bandit
	name = "bandido"
	explanation_text = "Entrega objetos de valor al idolo."

/datum/objective/bandit/check_completion()
	if(SSmapping.retainer.bandit_contribute >= SSmapping.retainer.bandit_goal)
		return TRUE

/datum/objective/bandit/update_explanation_text()
	..()
	explanation_text = "Entrega [SSmapping.retainer.bandit_goal] mammon a un idolo de la avaricia."


/datum/objective/delf
	name = "delf"
	explanation_text = "Dale orejas a la madre."

/datum/objective/delf/check_completion()
	if(SSmapping.retainer.delf_ears >= SSmapping.retainer.delf_goal)
		return TRUE

/datum/objective/delf/update_explanation_text()
	..()
	explanation_text = "Entrega [SSmapping.retainer.delf_goal] OREJAS a la Madre."


/datum/objective/rt_maniac
	name = "matanza"
	explanation_text = "Marca trozos de carne y dejalos para que los encuentren. Haz que al menos 4 personas distintas presencien tus crimenes."
	martyr_compatible = 0
	triumph_count = 10
	var/people_seen[0]

/datum/objective/rt_maniac/check_completion()
	if(people_seen.len >= 4)
		return TRUE

/// Vamp VS. Wolves, be the last faction standing
/datum/objective/dominate
	name = "dominar"
	triumph_count = 5
	var/faction_ident

/datum/objective/dominate/check_completion()
	return (vampire_werewolf() == faction_ident)

/datum/objective/dominate/vampire
	explanation_text = "Purga estas tierras de todos los Werevolves ancianos."
	faction_ident = "vampire"

/datum/objective/dominate/werewolf
	explanation_text = "Purga estas tierras de todos los Señores Vampiro."
	faction_ident = "werewolf"

/datum/objective/werewolf/spread
	name = "propagacion"
	explanation_text = "Ten 6 Werevolves menores."
	triumph_count = 5

/datum/objective/werewolf/spread/check_completion()
	if(length(SSmapping.retainer.werewolves) >= 6)
		return TRUE

/datum/objective/werewolf/infiltrate/one
	name = "infiltrarse1"
	explanation_text = "Infecta a un miembro de la Iglesia y conviertelo en mi engendro."
	triumph_count = 5

/datum/objective/werewolf/infiltrate/one/check_completion()
	var/list/churchjobs = list(JOB_PRIEST, JOB_PRIEST_FEM, "Cleric", JOB_ACOLYTE, JOB_TEMPLAR, JOB_CHURCHLING, "Crusader", "Inquisitor")
	for(var/datum/mind/V in SSmapping.retainer.werewolves)
		if(V.current.job in churchjobs)
			return TRUE

/datum/objective/werewolf/infiltrate/two
	name = "infiltrarse2"
	explanation_text = "Infectar a un miembro de la Nobleza."
	triumph_count = 5

/datum/objective/werewolf/infiltrate/two/check_completion()
	var/list/noblejobs = list(JOB_MONARCH, JOB_CONSORT, JOB_PRINCE, JOB_GUARD_CAPTAIN, JOB_HAND, JOB_STEWARD)
	for(var/datum/mind/V in SSmapping.retainer.werewolves)
		if(V.current.job in noblejobs)
			return TRUE

/datum/objective/werewolf/survive
	name = "sobrevivir"
	explanation_text = "Mi licantropia no me permite morir, no debo morir."
	triumph_count = 3

/datum/objective/werewolf/survive/check_completion()
	if(considered_alive(owner))
		return TRUE
