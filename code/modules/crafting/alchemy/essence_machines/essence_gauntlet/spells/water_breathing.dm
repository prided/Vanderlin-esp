/datum/action/cooldown/spell/essence/water_breathing
	name = "Respiracion de agua"
	desc = "Permite respirar bajo el agua por un corto periodo de tiempo."
	button_icon_state = "water_breathing"
	cast_range = 1
	essences = list(/datum/thaumaturgical_essence/water)
	var/duration = 60 SECONDS

/datum/action/cooldown/spell/essence/water_breathing/cast(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(!istype(target))
		target = owner
	owner.visible_message(span_notice("[target] gains the ability to breathe underwater."))
	target.apply_status_effect(/datum/status_effect/buff/water_breathing, duration)

/atom/movable/screen/alert/status_effect/water_breathing
	name = "Respiracion de agua"
	desc = "Puedes respirar bajo el agua."
	icon_state = "buff"

/datum/status_effect/buff/water_breathing
	id = "water_breathing"
	alert_type = /atom/movable/screen/alert/status_effect/water_breathing
	duration = 60 SECONDS

/datum/status_effect/buff/water_breathing/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_NODROWN, TRAIT_STATUS_EFFECT(id))
	to_chat(owner, span_notice("Ahora puedes respirar bajo el agua."))

/datum/status_effect/buff/water_breathing/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NODROWN, TRAIT_STATUS_EFFECT(id))
	to_chat(owner, span_notice("Tu capacidad para respirar bajo el agua se desvanece."))

/datum/action/cooldown/spell/essence/water_breathing/spell
	name = "Transmogrify: Gills"
	charge_required = TRUE
	charge_time = 3 SECONDS
	spell_cost = 50
	spell_type = SPELL_MANA

	required_form = FORM_WATER
	duration = 5 MINUTES
