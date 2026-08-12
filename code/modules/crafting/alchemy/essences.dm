/obj/item/essence_vial
	name = "essence vial"
	desc = "A small crystalline vial designed to hold alchemical essences."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	icon_state = "essence_vial"
	w_class = WEIGHT_CLASS_TINY
	var/essence_fill = "essence_liquid"
	var/datum/thaumaturgical_essence/contained_essence = null
	var/essence_amount = 0
	var/max_essence = 10
	var/extract_amount = 10 // Amount to try to extract when used
	var/increments = 1

/obj/item/essence_vial/combat
	name = "combat flask"
	desc = "A larger crystalline flask designed to hold large amounts of essences."
	icon_state = "clear_bottle4"
	essence_fill = "combat_essence_fill"
	extract_amount = 100
	max_essence = 100
	increments = 10

/obj/item/essence_vial/Initialize()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/essence_vial/attack_self(mob/user, list/modifiers)
	if(extract_amount >= max_essence)
		extract_amount = 1
	else
		if(extract_amount == 1 && max_essence > 10)
			extract_amount = 0
		extract_amount += increments

	to_chat(user, span_info("You adjust the vial to extract [extract_amount] unit[extract_amount > 1 ? "s" : ""] of essence."))

/obj/item/essence_vial/attack_self_secondary(mob/user, list/modifiers)
	if(extract_amount != max_essence)
		extract_amount = max_essence
		to_chat(user, span_info("You adjust the vial to extract [extract_amount] unit[extract_amount > 1 ? "s" : ""] of essence."))

/obj/item/essence_vial/proc/check_vial_menu_validity(mob/user)
	return user && (src in user.contents)

/obj/item/essence_vial/update_overlays()
	. = ..()
	if(!contained_essence || essence_amount < 0)
		return
	var/used_alpha = min(255, 100 + (essence_amount * 15))
	. += mutable_appearance(icon, essence_fill, alpha = used_alpha, color = contained_essence.color)
	. += emissive_appearance(icon, essence_fill, alpha = used_alpha)

/obj/item/essence_vial/examine(mob/user)
	. = ..()
	if(contained_essence && essence_amount > 0)
		if(!HAS_TRAIT(user, TRAIT_LEGENDARY_ALCHEMIST))
			. += span_notice("Contains [essence_amount] units of essence smelling of [contained_essence.smells_like].")
		else
			. += span_notice("Contains [essence_amount] units of [contained_essence.name].")
			. += span_notice("Huele a [contained_essence.smells_like].")
	else
		. += span_notice("It appears to be empty.")

	. += span_notice("Set to extract [extract_amount] unit[extract_amount > 1 ? "s" : ""] when used. Use in hand to adjust.")

/obj/item/essence_vial/proc/can_hold_essence()
	return essence_amount < max_essence

/obj/item/essence_vial/proc/get_available_space()
	return max_essence - essence_amount

/datum/thaumaturgical_essence
	var/name = "essence"
	var/desc = "Una esencia mágica concentrada."
	var/tier = 0 // 0 = Basic, 1 = First Compound, 2 = Second Compound
	var/color = "#FFFFFF"
	var/icon_state = "essence_basic"
	var/smells_like = "magic"
	///basically what attunement we can tie this to
	var/datum/attunement/attunement

// =============================================================================
// TIER 0 - BASIC ESSENCES
// =============================================================================

/datum/thaumaturgical_essence/air
	name = "Air Essence"
	desc = "La esencia del viento y el movimiento."
	color = "#E6F3FF"
	smells_like = "brisa fresca"
	attunement = /datum/attunement/aeromancy

/datum/thaumaturgical_essence/water
	name = "Esencia de agua"
	desc = "La esencia del agua que fluye."
	color = "#4A90E2"
	smells_like = "clear streams"
	attunement = /datum/attunement/blood

/datum/thaumaturgical_essence/fire
	name = "Esencia de fuego"
	desc = "La esencia de la llama ardiente."
	color = "#FF6B35"
	smells_like = "smoke and ash"
	attunement = /datum/attunement/fire

/datum/thaumaturgical_essence/earth
	name = "Esencia de la Tierra"
	desc = "The essence of solid ground."
	color = "#8B4513"
	smells_like = "suelo rico"
	attunement = /datum/attunement/earth

/datum/thaumaturgical_essence/order
	name = "Esencia del orden"
	desc = "La esencia de la estructura y la armonía."
	color = "#FFD700"
	smells_like = "pureza y estancamiento"

/datum/thaumaturgical_essence/chaos
	name = "Chaos Essence"
	desc = "La esencia del cambio y la discordia."
	color = "#8A2BE2"
	smells_like = "libertad y caos"
	attunement = /datum/attunement/polymorph

// =============================================================================
// TIER 1 - FIRST COMPOUND ESSENCES
// =============================================================================

/datum/thaumaturgical_essence/frost
	name = "Esencia de escarcha"
	desc = "The essence of bitter cold."
	tier = 1
	color = "#87CEEB"
	smells_like = "aire de invierno"
	attunement = /datum/attunement/ice

/datum/thaumaturgical_essence/light
	name = "Esencia de luz"
	desc = "La esencia de la iluminación."
	tier = 1
	smells_like = "warm embrace"
	attunement = /datum/attunement/light

/datum/thaumaturgical_essence/motion
	name = "Motion Essence"
	desc = "La esencia del movimiento y la velocidad."
	tier = 1
	color = "#32CD32"
	smells_like = "rushing wind"
	attunement = /datum/attunement/time

/datum/thaumaturgical_essence/cycle
	name = "Cycle Essence"
	desc = "La esencia de la renovación y el tiempo."
	tier = 1
	color = "#20B2AA"
	smells_like = "changing seasons"

/datum/thaumaturgical_essence/energia
	name = "Esencia de energía"
	desc = "La esencia de la energía cruda."
	tier = 1
	color = "#FF1493"
	smells_like = "crackling energy"
	attunement = /datum/attunement/electric

/datum/thaumaturgical_essence/void
	name = "Esencia del Vacío"
	desc = "La esencia del vacío."
	tier = 1
	color = "#2F2F2F"
	smells_like = "el abismo"
	attunement = /datum/attunement/illusion

/datum/thaumaturgical_essence/poison
	name = "Esencia de veneno"
	desc = "La esencia de la toxicidad."
	tier = 1
	color = "#9ACD32"
	smells_like = "humos tóxicos"
	attunement = /datum/attunement/dark

/datum/thaumaturgical_essence/life
	name = "Esencia de vida"
	desc = "La esencia de la vitalidad."
	tier = 1
	color = "#FF69B4"
	smells_like = "blooming flowers"
	attunement = /datum/attunement/life

/datum/thaumaturgical_essence/crystal
	name = "Esencia de cristal"
	desc = "La esencia de la estructura cristalina."
	tier = 1
	color = "#DA70D6"
	smells_like = "gem dust"

// =============================================================================
// TIER 2 - SECOND COMPOUND ESSENCES
// =============================================================================

/datum/thaumaturgical_essence/magic
	name = "Esencia mágica"
	desc = "The essence of pure arcynic power."
	tier = 2
	color = "#9370DB"
	smells_like = "magia cruda"
	attunement = /datum/attunement/arcyne

/datum/thaumaturgical_essence/death
	name = "Death Essence"
	desc = "La esencia de la muerte pura."
	tier = 2
	color = "#221123"
	smells_like = "la muerte y el fin"
	attunement = /datum/attunement/death
