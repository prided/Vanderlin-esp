/datum/preference/choiced/family_mode
	savefile_key = "family_mode"
	savefile_identifier = PREF_CHARACTER
	category = "relations"
	can_randomize = FALSE

/datum/preference/choiced/family_mode/init_possible_values(datum/preferences/prefs)
	return list(
		"[FAMILY_NONE]",
		"[FAMILY_PARTIAL]",
		"[FAMILY_NEWLYWED]",
		"[FAMILY_FULL]",
	)

/datum/preference/choiced/family_mode/create_default_value()
	return FAMILY_NONE

/datum/preference/choiced/family_mode/apply_to_human(mob/living/carbon/human/H, value, datum/preferences/prefs)
	H.familytree_pref = value

/datum/preference/choiced/family_mode/handle_link(datum/preferences/prefs, mob/user)
	var/list/labelled = list(
		"Ninguna (desactivada)" = "[FAMILY_NONE]",
		"Parcial (unirse a una casa)" = "[FAMILY_PARTIAL]",
		"Recien casado (solo pareja)" = "[FAMILY_NEWLYWED]",
		"Completa (fundar una casa)" = "[FAMILY_FULL]",
	)
	var/current = prefs.read_preference(/datum/preference/choiced/family_mode)
	var/current_label
	for(var/family_label in labelled)
		if(labelled[family_label] == current)
			current_label = family_label
			break
	var/result = browser_input_list(user, "ELIGE EL VINCULO DE TU HEROE", "LA SANGRE PESA MAS QUE EL AGUA", labelled, current_label)
	if(!result)
		return
	prefs.write_preference(/datum/preference/choiced/family_mode, labelled[result])
	to_chat(user, span_purple("Modo familiar establecido en: [result]"))
	to_chat(user, span_notice("\
		[spanish_family_label(FAMILY_NONE)] - desactivado.\n\
		[spanish_family_label(FAMILY_PARTIAL)] - unete a una casa local como hijo, tia o tio.\n\
		[spanish_family_label(FAMILY_NEWLYWED)] - obtienes pareja; la pareja designada tiene prioridad.\n\
		[spanish_family_label(FAMILY_FULL)] - conviertete en fundador de una casa; la pareja designada bloquea coincidencias desconocidas.\
	"))
