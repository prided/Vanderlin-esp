/datum/action/cooldown/spell/blindness
	name = "Ceguera"
	desc = "Apunta a un objetivo para cegarlo durante unos segundos."
	button_icon_state = "blindness"
	sound = 'sound/magic/churn.ogg'

	required_form = FORM_ARCANE
	required_technique = TECHNIQUE_ILLUSION

	invocation = "darkness envelop them."
	invocation_type = INVOCATION_WHISPER

	spell_flags = SPELL_RITUOS
	charge_required = FALSE
	cooldown_time = 2 MINUTES
	spell_cost = 30

/datum/action/cooldown/spell/blindness/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return
	return isliving(cast_on)

/datum/action/cooldown/spell/blindness/cast(mob/living/cast_on)
	. = ..()
	cast_on.adjust_temp_blindness(6 SECONDS)
	cast_on.visible_message(span_warning("¡[owner] apunta a los ojos de [cast_on]!"), span_warning("¡Mis ojos estan cubiertos de oscuridad!"))

/datum/action/cooldown/spell/blindness/miracle
	name = "Noc's Blindness"
	charge_sound = 'sound/magic/holycharging.ogg'
	required_form = null

	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/attribute/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/divine/noc)

	invocation = "Noc blinds thee of thy sins!"
	invocation_type = INVOCATION_SHOUT

