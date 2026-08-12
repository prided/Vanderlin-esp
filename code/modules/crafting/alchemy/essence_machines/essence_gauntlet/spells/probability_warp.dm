
/datum/action/cooldown/spell/essence/probability_warp
	name = "Probability Warp"
	desc = "Altera la probabilidad de que ocurran eventos menores."
	button_icon_state = "guidanceneu"
	cast_range = 3
	essences = list(/datum/thaumaturgical_essence/chaos, /datum/thaumaturgical_essence/void)

/datum/action/cooldown/spell/essence/probability_warp/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] deforma la probabilidad en el área local."))

	for(var/mob/living/M in range(2, target_turf))
		M.apply_status_effect(/datum/status_effect/buff/probability_flux, 60 SECONDS)

/atom/movable/screen/alert/status_effect/probability_flux
	name = "Flujo de probabilidad"
	desc = "Las probabilidades parecen estar a tu favor... o en tu contra."
	icon_state = "buff"

/datum/status_effect/buff/probability_flux
	id = "probability_flux"
	alert_type = /atom/movable/screen/alert/status_effect/probability_flux
	duration = 60 SECONDS
	effectedstats = list(STAT_FORTUNE = 2)

/datum/status_effect/buff/probability_flux/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.attributes?.add_diceroll_modifier(/datum/diceroll_modifier/probability_flux)

/datum/status_effect/buff/probability_flux/on_remove()
	. = ..()
	var/mob/living/target = owner
	target.attributes?.remove_diceroll_modifier(/datum/diceroll_modifier/probability_flux)
