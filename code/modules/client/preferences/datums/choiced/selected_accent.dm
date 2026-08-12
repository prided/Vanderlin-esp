/datum/preference/choiced/selected_accent
	savefile_key = "selected_accent"
	savefile_identifier = PREF_CHARACTER
	category = "character"
	should_apply = FALSE

/datum/preference/choiced/selected_accent/init_possible_values(datum/preferences/prefs)
	return GLOB.accent_list

/datum/preference/choiced/selected_accent/create_default_value(datum/preferences/prefs)
	return ACCENT_DEFAULT

/datum/preference/choiced/selected_accent/apply_to_human(mob/living/carbon/human/H, value, datum/preferences/prefs)
	H.accent = value

/datum/preference/choiced/selected_accent/handle_link(datum/preferences/prefs, mob/user)
	var/list/available = list(ACCENT_DEFAULT)

	if(length(prefs.pref_species.multiple_accents))
		for(var/accent_name in prefs.pref_species.multiple_accents)
			available |= accent_name

	var/culture_type = prefs.read_preference(/datum/preference/choiced/culture)
	if(culture_type)
		var/datum/culture/culture_datum = GLOB.culture_singletons[culture_type]
		if(culture_datum && culture_datum.accent)
			available |= culture_datum.accent

	if(length(available) > 1)
		prefs.change_accent = TRUE
	else
		prefs.change_accent = FALSE

	if(!prefs.donator && !prefs.change_accent)
		to_chat(user, "Esta opcion es exclusiva para donadores o no esta disponible para tu especie y cultura.")
		prefs.write_preference(/datum/preference/choiced/selected_accent, ACCENT_DEFAULT)
		return
	if(prefs.donator)
		for(var/accent_name in GLOB.accent_list)
			available |= accent_name

	var/list/labelled_accents = list()
	for(var/accent_name in available)
		labelled_accents[spanish_accent_label(accent_name)] = accent_name
	var/current_accent = prefs.read_preference(/datum/preference/choiced/selected_accent)
	var/accent_label = browser_input_list(user, "ELIGE EL ACENTO DE TU HEROE", "VOZ DEL MUNDO", labelled_accents, spanish_accent_label(current_accent))
	if(accent_label)
		prefs.write_preference(/datum/preference/choiced/selected_accent, labelled_accents[accent_label])
