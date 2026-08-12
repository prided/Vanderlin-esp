/datum/enchantment/on_hit/vampiric
	enchantment_name = "vampirico"
	examine_text = "This weapon has a dark, blood-red aura."
	enchantment_color = "#8B0000"
	enchantment_end_message = "El aura vampirica se desvanece."
	essence_recipe = list(
		/datum/thaumaturgical_essence/life = 35,
		/datum/thaumaturgical_essence/void = 35,
		/datum/thaumaturgical_essence/poison = 20
	)
	cooldown_time = 4 SECONDS

/datum/enchantment/on_hit/vampiric/apply_attack_effects(obj/item/source, mob/living/carbon/human/attacked, mob/living/carbon/attacker, actual_damage)
	if(!isliving(attacker))
		return
	var/damage_dealt = 8
	attacked.apply_damage(damage_dealt, BRUTE, damage_type = BCLASS_BITE)
	var/heal_amount = (damage_dealt + actual_damage) / 2
	attacker.heal_bodypart_damage(heal_amount, 0)
	to_chat(attacker, span_green("You feel invigorated as your weapon drains life!"))
	to_chat(attacked, span_warning("¡Sientes que tu fuerza vital se esta agotando!"))
