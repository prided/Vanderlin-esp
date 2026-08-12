/datum/preference/choiced/age
	savefile_key = "age"
	savefile_identifier = PREF_CHARACTER
	category = "character"

/datum/preference/choiced/age/init_possible_values(datum/preferences/prefs)
	var/datum/species/base_species = /datum/species/human/northern
	if(prefs)
		base_species = prefs.read_preference(/datum/preference/choiced/species)
	var/datum/species/S = new base_species
	var/list/ages = list()
	ages = S.possible_ages
	qdel(S)
	return ages

/datum/preference/choiced/age/create_informed_default_value(datum/preferences/prefs)
	var/datum/species/S = prefs.pref_species
	if (S && S.possible_ages && S.possible_ages.len)
		return S.possible_ages[1]
	return AGE_ADULT

/datum/preference/choiced/age/deserialize(input, datum/preferences/prefs)
	// Ages are species-dependent; validate against the species' list if available.
	var/datum/species/S = prefs?.pref_species
	var/list/valid = (S && S.possible_ages && S.possible_ages.len) ? S.possible_ages : get_choices(prefs)
	return sanitize_inlist(input, valid, create_informed_default_value(prefs))

/datum/preference/choiced/age/apply_to_human(mob/living/carbon/human/H, value, datum/preferences/prefs)
	H.age = value

/datum/preference/choiced/age/handle_link(datum/preferences/prefs, mob/user)
	var/list/labelled_ages = list()
	for(var/age_value in prefs.pref_species.possible_ages)
		labelled_ages[spanish_age_label(age_value)] = age_value
	var/current_age = prefs.read_preference(/datum/preference/choiced/age)
	var/new_age_label = browser_input_list(user, "ELIGE LA EDAD DE TU HEROE", "YILS TRANSCURRIDOS", labelled_ages, spanish_age_label(current_age))
	if(new_age_label)
		prefs.write_preference(/datum/preference/choiced/age, labelled_ages[new_age_label])
		prefs.reset_jobs(user)
