/datum/preference/choiced/voice_type
	savefile_key = "voice_type"
	savefile_identifier = PREF_CHARACTER
	category = "character"

/datum/preference/choiced/voice_type/init_possible_values(datum/preferences/prefs)
	return VOICE_TYPES_LIST

/datum/preference/choiced/voice_type/create_default_value(datum/preferences/prefs)
	return VOICE_TYPE_MASC

/datum/preference/choiced/voice_type/apply_to_human(mob/living/carbon/human/H, value, datum/preferences/prefs)
	H.voice_type = value

/datum/preference/choiced/voice_type/handle_link(datum/preferences/prefs, mob/user)
	var/list/allowed_voices
	if(prefs.read_preference(/datum/preference/choiced/gender) == MALE)
		allowed_voices = prefs.pref_species.allowed_voicetypes_m
	else if(prefs.read_preference(/datum/preference/choiced/gender) == FEMALE)
		allowed_voices = prefs.pref_species.allowed_voicetypes_f
	else
		allowed_voices = VOICE_TYPES_LIST
	if(!allowed_voices || !length(allowed_voices))
		allowed_voices = VOICE_TYPES_LIST
	if(length(allowed_voices) == 1)
		prefs.write_preference(/datum/preference/choiced/voice_type, allowed_voices[1])
		to_chat(user, span_warning("Esta especie solo puede usar el tipo de voz [spanish_voice_type_label(prefs.read_preference(/datum/preference/choiced/voice_type))]."))
		return

	var/list/labelled_voices = list()
	for(var/voice_value in allowed_voices)
		labelled_voices[spanish_voice_type_label(voice_value)] = voice_value
	var/current_voice = prefs.read_preference(/datum/preference/choiced/voice_type)
	var/voice_label = browser_input_list(user, "ELIGE EL TIPO DE VOZ DE TU HEROE", "IGNORA LAS EXPECTATIVAS SOCIALES", labelled_voices, spanish_voice_type_label(current_voice))
	if(voice_label)
		var/voice_value = labelled_voices[voice_label]
		prefs.write_preference(/datum/preference/choiced/voice_type, voice_value)
		if(voice_value == VOICE_TYPE_ANDRO)
			to_chat(user, span_warning("Se usara el paquete de voz femenino con un tono un poco mas grave para lograr un sonido mas androgino."))
		to_chat(user, span_warning("Tu personaje ahora vocalizara con una voz [LOWER_TEXT(spanish_voice_type_label(prefs.read_preference(/datum/preference/choiced/voice_type)))]."))
