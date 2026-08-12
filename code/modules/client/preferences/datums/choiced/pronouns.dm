/datum/preference/choiced/pronouns
	savefile_key = "pronouns"
	savefile_identifier = PREF_CHARACTER
	category = "character"

/datum/preference/choiced/pronouns/init_possible_values(datum/preferences/prefs)
	return list(HE_HIM, SHE_HER, THEY_THEM, IT_ITS)

/datum/preference/choiced/pronouns/create_default_value(datum/preferences/prefs)
	return HE_HIM

/datum/preference/choiced/pronouns/apply_to_human(mob/living/carbon/human/H, value, datum/preferences/prefs)
	H.pronouns = value

/datum/preference/choiced/pronouns/handle_link(datum/preferences/prefs, mob/user)
	var/list/allowed_pronouns = prefs.pref_species.allowed_pronouns
	if(!allowed_pronouns || !length(allowed_pronouns))
		// fallback to the default pronouns list
		allowed_pronouns = PRONOUNS_LIST

	if(length(allowed_pronouns) == 1)
		prefs.write_preference(/datum/preference/choiced/pronouns, allowed_pronouns[1])
		to_chat(user, span_warning("Esta especie solo puede utilizar [spanish_pronoun_label(prefs.read_preference(/datum/preference/choiced/pronouns))]."))
		return

	var/list/labelled_pronouns = list()
	for(var/pronoun_value in allowed_pronouns)
		labelled_pronouns[spanish_pronoun_label(pronoun_value)] = pronoun_value
	var/current_pronouns = prefs.read_preference(/datum/preference/choiced/pronouns)
	var/pronouns_label = browser_input_list(user, "ELIGE COMO SE REFIEREN LOS MORTALES A TU HEROE", "DESAFIA LAS NORMAS SOCIALES", labelled_pronouns, spanish_pronoun_label(current_pronouns))
	if(pronouns_label)
		prefs.write_preference(/datum/preference/choiced/pronouns, labelled_pronouns[pronouns_label])
		to_chat(user, span_warning("Los pronombres de tu personaje ahora son [spanish_pronoun_label(prefs.read_preference(/datum/preference/choiced/pronouns))]."))
