/datum/action/cooldown/spell/status/primal_savagery
	name = "Primal Savagery"
	desc = "Los dientes del objetivo secretaran veneno."
	button_icon_state = "wolf_head"
	sound = 'sound/magic/whiteflame.ogg'

	associated_skill = /datum/attribute/skill/magic/druidic
	invocation = "Dientes de una serpiente."
	invocation_type = INVOCATION_WHISPER

	required_form = FORM_LIFE
	required_technique = TECHNIQUE_ALTERATION

	charge_required = FALSE
	cooldown_time = 60 SECONDS
	spell_cost = 50
	spell_flags = SPELL_RITUOS
	status_effect = /datum/status_effect/buff/primal_savagery
	duration_scaling = TRUE
	duration_modification = 30 SECONDS

/datum/action/cooldown/spell/status/primal_savagery/cast(mob/living/cast_on)
	. = ..()
	cast_on.visible_message(span_warning("[cast_on] looks more primal!"), span_info("Te sientes mas primitivo."))

/datum/status_effect/buff/primal_savagery
	id = "primal savagery"
	alert_type = /atom/movable/screen/alert/status_effect/buff/primal_savagery
	duration = 30 SECONDS

/datum/status_effect/buff/primal_savagery/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_POISONBITE, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/buff/primal_savagery/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_POISONBITE, TRAIT_STATUS_EFFECT(id))

/atom/movable/screen/alert/status_effect/buff/primal_savagery
	name = "Primal Savagery"
	desc = "I have grown venomous fangs inject my victims with poison."
	icon_state = "buff"
