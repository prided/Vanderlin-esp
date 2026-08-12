/datum/action/cooldown/spell/essence/warmth
	name = "Calor"
	desc = "Proporciona resistencia al frio y calienta el cuerpo."
	button_icon_state = "warmth"
	cast_range = 1
	essences = list(/datum/thaumaturgical_essence/fire)

/datum/action/cooldown/spell/essence/warmth/cast(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(!istype(target))
		target = owner
	owner.visible_message(span_notice("[target] radiates gentle warmth."))
	target.apply_status_effect(/datum/status_effect/buff/warmth, 120 SECONDS)

/atom/movable/screen/alert/status_effect/warmth
	name = "Calor"
	desc = "El calor magico te protege del frio."
	icon_state = "buff"

/datum/status_effect/buff/warmth
	id = "warmth"
	alert_type = /atom/movable/screen/alert/status_effect/warmth
	duration = 120 SECONDS

/datum/status_effect/buff/warmth/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_RESISTCOLD, TRAIT_STATUS_EFFECT(id))
	owner.bodytemperature = max(owner.bodytemperature, BODYTEMP_NORMAL)
	to_chat(owner, span_notice("A gentle warmth spreads through your body."))

/datum/status_effect/buff/warmth/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_RESISTCOLD, TRAIT_STATUS_EFFECT(id))
	to_chat(owner, span_notice("El calor magico se desvanece."))

/datum/action/cooldown/spell/essence/warmth/spell
	name = "Lesser Warmth"
	charge_required = TRUE
	charge_time = 1 SECONDS
	spell_cost = 40
	spell_type = SPELL_MANA

	required_form = FORM_FIRE
