//Herbal Medicine Variants - Weaker but more accessible alternatives
//Based on existing herbs: symphitum, taraxacum, urtica, mentha, rosa, hypericum, calendula, etc.

/datum/reagent/medicine/herbal
	description = "A simple herbal remedy."
	reagent_state = LIQUID
	metabolization_rate = REAGENTS_METABOLISM * 0.75
	overdose_threshold = 30
	alpha = 200

// Weak Health Potions (based on symphitum/taraxacum/urtica/calendula)
/datum/reagent/medicine/herbal/symphitum_tea
	name = "Symphitum Tea"
	description = "A mild healing tea made from symphitum leaves."
	color = "#8fbc8f"
	taste_description = "hierbas terrosas"
	scent_description = "hojas verdes"

/datum/reagent/medicine/herbal/symphitum_tea/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.adjustBruteLoss(-0.5*REM * efficiency, 0)
		M.adjustFireLoss(-0.5*REM * efficiency, 0)
		var/list/wCount = M.get_wounds()
		if(wCount.len > 0 && prob(15 * efficiency))
			M.heal_wounds(1 * efficiency)
	..()

/datum/reagent/medicine/herbal/taraxacum_extract
	name = "Extracto de Taraxacum"
	description = "Un extracto amargo que limpia toxinas menores."
	color = "#daa520"
	taste_description = "diente de leon amargo"
	scent_description = "weeds"

/datum/reagent/medicine/herbal/taraxacum_extract/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_ANTIBIOTIC, 5, "[type]")

/datum/reagent/medicine/herbal/taraxacum_extract/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_ANTIBIOTIC, "[type]")

/datum/reagent/medicine/herbal/taraxacum_extract/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.adjustToxLoss(-0.75, 0)
		M.adjustBruteLoss(-0.25*REM, 0)
	..()

/datum/reagent/medicine/herbal/urtica_brew
	name = "Urtica Brew"
	description = "Una infusion de ortiga que restaura la sangre y la energia."
	color = "#4d6b3d"
	taste_description = "stinging greens"
	scent_description = "ortigas"

/datum/reagent/medicine/herbal/urtica_brew/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_BLOODRESTORE, 2, "[type]")
	L.add_chem_effect(CE_STIMULANT, 2, "[type]")

/datum/reagent/medicine/herbal/urtica_brew/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_BLOODRESTORE, "[type]")
	L.remove_chem_effect(CE_STIMULANT, "[type]")

/datum/reagent/medicine/herbal/urtica_brew/on_mob_life(mob/living/carbon/M, efficiency)
	if(!HAS_TRAIT(M,TRAIT_NOSTAMINA))
		M.adjust_stamina(-0.75, internal_regen = FALSE)
	..()

/datum/reagent/medicine/herbal/calendula_salve
	name = "Ungüento de calendula"
	description = "A soothing salve that promotes healing when applied to areas."
	color = "#ff8c00"
	taste_description = "flores amargas"
	scent_description = "marigold"

/datum/reagent/medicine/herbal/calendula_salve/on_bodypart_absorb(mob/living/carbon/affected_mob, obj/item/bodypart/affected_bodypart, amount_to_transfer)
	for(var/datum/injury/injury in affected_bodypart.injuries)
		if(!injury.can_heal())
			continue
		injury.adjust_germ_level(-5)
		injury.salve_injury()
		if(injury.damage_type & FIRE_WOUND_TYPES)
			injury.heal_damage(3)
		if(QDELETED(injury))
			continue
		injury.heal_damage(1)
	if(affected_bodypart.post_damage_change())
		affected_mob.update_damage_overlays()
	affected_bodypart.disinfect_limb(20 SECONDS)
	return FALSE

// Weak Mana/Stamina Potions (based on hypericum/benedictus/mentha)
/datum/reagent/medicine/herbal/hypericum_tonic
	name = "Hypericum Tonic"
	description = "Un tonico que restaura la energia y la resistencia menores."
	color = "#ffff99"
	taste_description = "hierbas amargas"
	scent_description = "hierba de san juan"

/datum/reagent/medicine/herbal/hypericum_tonic/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_OXYGENATED, 1, "[type]")

/datum/reagent/medicine/herbal/hypericum_tonic/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_OXYGENATED, "[type]")

/datum/reagent/medicine/herbal/hypericum_tonic/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		if(M.mana_pool)
			M.mana_pool.adjust_mana(1.5)
		if(!HAS_TRAIT(M,TRAIT_NOSTAMINA))
			M.adjust_stamina(-0.5, internal_regen = FALSE)
	..()

/datum/reagent/medicine/herbal/mentha_tea
	name = "Te de menta"
	description = "A refreshing mint tea that clears the mind."
	color = "#90ee90"
	taste_description = "cooling mint"
	scent_description = "menta"

/datum/reagent/medicine/herbal/mentha_tea/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_ENERGETIC, 2, "[type]")
	L.add_chem_effect(CE_STABLE, 1, "[type]")

/datum/reagent/medicine/herbal/mentha_tea/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_ENERGETIC, "[type]")
	L.remove_chem_effect(CE_STABLE, "[type]")

/datum/reagent/medicine/herbal/mentha_tea/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.add_nausea(-1)
		if(M.mana_pool)
			M.mana_pool.adjust_mana(1)
	..()

// Mild Buff Potions (based on salvia/artemisia)
/datum/reagent/buff/herbal
	description = "A mild herbal enhancement."
	reagent_state = LIQUID
	metabolization_rate = REAGENTS_METABOLISM * 1.5
	overdose_threshold = 20

/datum/reagent/buff/herbal/salvia_wisdom
	name = "Te de sabiduria de salvia"
	description = "Un te que mejora ligeramente la constitucion."
	color = "#9caf88"
	taste_description = "sage"
	scent_description = "hierbas sabias"

/datum/reagent/buff/herbal/salvia_wisdom/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PULSE, 1, "[type]")

/datum/reagent/buff/herbal/salvia_wisdom/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PULSE, "[type]")

/datum/reagent/buff/herbal/salvia_wisdom/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -0.25*REM)
		M.adjustBruteLoss(-0.1*REM, 0) // Very minor toughness
	if(M.has_status_effect(/datum/status_effect/buff/alch/constitutionpot/weak))
		return ..()
	if(volume > 2)
		M.apply_status_effect(/datum/status_effect/buff/alch/constitutionpot/weak)
	..()

/datum/reagent/buff/herbal/artemisia_luck
	name = "Artemisia Fortune Tea"
	description = "Un te que mejora ligeramente la fortuna y la velocidad."
	color = "#c0c0c0"
	taste_description = "wormwood"
	scent_description = "artemisia"

/datum/reagent/buff/herbal/artemisia_luck/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_STIMULANT, 2, "[type]")
	L.add_chem_effect(CE_OXYGENATED, 1, "[type]")

/datum/reagent/buff/herbal/artemisia_luck/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_STIMULANT, "[type]")
	L.remove_chem_effect(CE_OXYGENATED, "[type]")

/datum/reagent/buff/herbal/artemisia_luck/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.adjustBruteLoss(-0.1*REM, 0)
		if(!HAS_TRAIT(M,TRAIT_NOSTAMINA))
			M.adjust_stamina(-0.25, internal_regen = FALSE)
	if(M.has_status_effect(/datum/status_effect/buff/alch/artemisia_luck))
		return ..()
	if(volume > 2)
		M.apply_status_effect(/datum/status_effect/buff/alch/artemisia_luck)
	..()

/datum/reagent/buff/herbal/euphorbia_strength
	name = "Euphorbia Strength Tea"
	description = "A bitter tea that infuses the body with strength."
	color = "#6ca22a"
	taste_description = "latex"
	scent_description = "sharp herbs"

/datum/reagent/buff/herbal/euphorbia_strength/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_STIMULANT, 2, "[type]")
	L.add_chem_effect(CE_PULSE, 2, "[type]")

/datum/reagent/buff/herbal/euphorbia_strength/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_STIMULANT, "[type]")
	L.remove_chem_effect(CE_PULSE, "[type]")

/datum/reagent/buff/herbal/euphorbia_strength/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.add_nausea(0.5)
	if(M.has_status_effect(/datum/status_effect/buff/alch/strengthpot/weak))
		return ..()
	if(volume > 2)
		M.apply_status_effect(/datum/status_effect/buff/alch/strengthpot/weak)
	..()

// Very Mild Poisons (based on atropa/matricaria/paris but much weaker)
/datum/reagent/poison/herbal
	description = "Un extracto de planta ligeramente irritante."
	reagent_state = LIQUID
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 15

/datum/reagent/poison/herbal/weak_atropa
	name = "Extracto de atropa diluido"
	description = "A very diluted extract that causes mild discomfort."
	color = "#8b0000"
	taste_description = "bitter nightshade"
	scent_description = "danger"

/datum/reagent/poison/herbal/weak_atropa/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.add_nausea(0.5)
		M.adjustToxLoss(0.1)
	..()

/datum/reagent/poison/herbal/matricaria_irritant
	name = "Matricaria Irritant"
	description = "Causes mild stomach upset and drowsiness."
	color = "#90ee90"
	taste_description = "bitter chamomile"
	scent_description = "flores agrias"

/datum/reagent/poison/herbal/matricaria_irritant/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PULSE, -1, "[type]")
	L.add_chem_effect(CE_PAINKILLER, -9, "[type]")

/datum/reagent/poison/herbal/matricaria_irritant/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PULSE, "[type]")
	L.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/poison/herbal/matricaria_irritant/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.add_nausea(1)
		if(!HAS_TRAIT(M,TRAIT_NOSTAMINA))
			M.adjust_stamina(0.5) // Very mild stamina drain
	if(M.has_status_effect(/datum/status_effect/buff/alch/perceptionpot/weak))
		return ..()
	if(volume > 2)
		M.apply_status_effect(/datum/status_effect/buff/alch/perceptionpot/weak)
	..()

//Simple Herbal Recipes using single herbs
/datum/reagent/medicine/herbal/simple_rosa
	name = "Rosa Water"
	description = "Simple rose petal water with very mild healing."
	color = "#ffb6c1"
	taste_description = "floral"
	scent_description = "rosas"

/datum/reagent/medicine/herbal/simple_rosa/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.adjustBruteLoss(-0.1*REM, 0)
		M.adjustFireLoss(-0.1*REM, 0)
		M.add_nausea(-1)
	..()

/datum/reagent/medicine/herbal/euphrasia_eye_wash
	name = "Euphrasia Eye Wash"
	description = "An eye wash that slightly improves perception."
	color = "#e6e6fa"
	taste_description = "eufrasia"
	scent_description = "hierbas limpias"

/datum/reagent/medicine/herbal/euphrasia_eye_wash/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_OXYGENATED, 1, "[type]")

/datum/reagent/medicine/herbal/euphrasia_eye_wash/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_OXYGENATED, "[type]")

/datum/reagent/medicine/herbal/euphrasia_eye_wash/on_mob_life(mob/living/carbon/M, efficiency)
	if(volume > 0.99)
		M.adjustOrganLoss(ORGAN_SLOT_EYES, -0.1*REM)
		if(!HAS_TRAIT(M,TRAIT_NOSTAMINA))
			M.adjust_stamina(-0.1, internal_regen = FALSE)

	if(M.has_status_effect(/datum/status_effect/buff/alch/perceptionpot/weak))
		return ..()
	if(volume > 2)
		M.apply_status_effect(/datum/status_effect/buff/alch/perceptionpot/weak)
	..()

// Advanced Herbal Reagents

// Sleep and Calming Reagents

/datum/reagent/medicine/herbal/valeriana_draught
	name = "Valeriana Sleep Draught"
	description = "A deeply relaxing herbal draught that promotes restful sleep and calms the mind."
	reagent_state = LIQUID
	color = "#4a3c5f"
	metabolization_rate = 0.5
	overdose_threshold = 40
	taste_description = "hierbas profundamente relajantes"
	var/sleep_power = 60 SECONDS

/datum/reagent/medicine/herbal/valeriana_draught/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_stress(/datum/stress_event/herbal_calm)
	M.add_chem_effect(CE_STABLE, 1, "[type]")

/datum/reagent/medicine/herbal/valeriana_draught/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_STABLE, "[type]")

/datum/reagent/medicine/herbal/valeriana_draught/on_mob_life(mob/living/carbon/M, efficiency)
	var/datum/status_effect/drowsiness = M.has_status_effect(/datum/status_effect/drowsiness)
	if(istype(drowsiness))
		if(drowsiness?.duration < sleep_power)
			M.adjust_drowsiness_up_to(10 SECONDS, 60 SECONDS)
	M.adjust_stamina(2)
	. = ..()

/datum/reagent/medicine/herbal/valeriana_draught/overdose_process(mob/living/M)
	M.Unconscious(60)
	. = ..()

// Stamina and Vigor Buffs

/datum/reagent/buff/herbal/benedictus_vigor
	name = "Benedictus Vigor Tea"
	description = "An invigorating tea that enhances physical stamina and endurance."
	reagent_state = LIQUID
	color = "#8b4513"
	metabolization_rate = 0.4
	overdose_threshold = 50
	taste_description = "earthy vigor"

/datum/reagent/buff/herbal/benedictus_vigor/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_stress(/datum/stress_event/herbal_vigor)
	M.add_chem_effect(CE_ENERGETIC, 2, "[type]")
	M.add_chem_effect(CE_OXYGENATED, 1, "[type]")
	M.add_chem_effect(CE_BLOODRESTORE, 1, "[type]")

/datum/reagent/buff/herbal/benedictus_vigor/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_ENERGETIC, "[type]")
	M.remove_chem_effect(CE_OXYGENATED, "[type]")
	M.remove_chem_effect(CE_BLOODRESTORE, "[type]")

/datum/reagent/buff/herbal/benedictus_vigor/on_mob_life(mob/living/carbon/M, efficiency)
	M.adjust_stamina(3)
	if(M.satiety < 600)
		M.adjust_nutrition(2)
	if(prob(10))
		M.heal_bodypart_damage(0.5, 0, 0)
	if(M.has_status_effect(/datum/status_effect/buff/alch/endurancepot/weak))
		return ..()
	if(volume > 2)
		M.apply_status_effect(/datum/status_effect/buff/alch/endurancepot/weak)
	. = ..()

// Topical Medicine

/datum/reagent/medicine/herbal/paris_poultice
	name = "Paris Numbing Poultice"
	description = "A thick medicinal poultice that numbs pain when applied topically."
	reagent_state = LIQUID
	color = "#556b2f"
	metabolization_rate = 0.2
	overdose_threshold = 30
	taste_description = "amargo entumecimiento"

/datum/reagent/medicine/herbal/paris_poultice/on_bodypart_absorb(mob/living/carbon/affected_mob, obj/item/bodypart/affected_bodypart, amount_to_transfer)
	if(affected_bodypart.heal_damage(0.5, 0.75, TRUE, required_status = BODYPART_ORGANIC))
		affected_mob.update_damage_overlays()
	affected_bodypart.add_pain(-amount_to_transfer * 0.3)
	return FALSE

/datum/reagent/medicine/herbal/paris_poultice/overdose_process(mob/living/M)
	M.adjustToxLoss(0.5)
	if(prob(5))
		to_chat(M, span_warning("You feel numbness spreading through your body..."))
	. = ..()

// Multi-Herb Healing

/datum/reagent/medicine/herbal/herbalist_panacea
	name = "Herbalist's Panacea"
	description = "Una potente mezcla de multiples hierbas curativas que proporciona una restauracion integral."
	reagent_state = LIQUID
	color = "#228b22"
	metabolization_rate = 0.6
	overdose_threshold = 35
	taste_description = "complex herbal harmony"

/datum/reagent/medicine/herbal/herbalist_panacea/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_stress(/datum/stress_event/herbal_wellness)
	M.add_chem_effect(CE_BLOODRESTORE, 4, "[type]")
	M.add_chem_effect(CE_ORGAN_REGEN, 1, "[type]")
	M.add_chem_effect(CE_ANTIBIOTIC, 4, "[type]")
	M.add_chem_effect(CE_OXYGENATED, 2, "[type]")

/datum/reagent/medicine/herbal/herbalist_panacea/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_BLOODRESTORE, "[type]")
	M.remove_chem_effect(CE_ORGAN_REGEN, "[type]")
	M.remove_chem_effect(CE_ANTIBIOTIC, "[type]")
	M.remove_chem_effect(CE_OXYGENATED, "[type]")

/datum/reagent/medicine/herbal/herbalist_panacea/on_mob_life(mob/living/carbon/M, efficiency)
	M.adjustBruteLoss(-1.5*REM*efficiency, FALSE)
	M.adjustFireLoss(-1.5*REM*efficiency, FALSE)
	M.adjustToxLoss(-1*REM*efficiency, FALSE)
	M.adjustOxyLoss(-1*efficiency, TRUE)
	M.adjust_stamina(2*REM*efficiency)
	. = ..()

// Anti-Poison Blend

/datum/reagent/medicine/herbal/witches_bane
	name = "Witch's Bane"
	description = "A purifying blend that neutralizes toxins and protects against poison."
	reagent_state = LIQUID
	color = "#dc143c"
	metabolization_rate = 0.5
	overdose_threshold = 45
	taste_description = "purificacion floral"

/datum/reagent/medicine/herbal/witches_bane/on_mob_life(mob/living/carbon/M, efficiency)
	M.adjustToxLoss(-2)
	// Purge small amounts of other poisons
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(istype(R, /datum/reagent/poison) || istype(R, /datum/reagent/toxin))
			M.reagents.remove_reagent(R.type, 0.5)
	. = ..()

// Mental Enhancement

/datum/reagent/buff/herbal/scholar_focus
	name = "Scholar's Focus Tea"
	description = "A clarifying tea that sharpens the mind and enhances intellectual capabilities."
	reagent_state = LIQUID
	color = "#40e0d0"
	metabolization_rate = 0.4
	overdose_threshold = 40
	taste_description = "minty clarity"

/datum/reagent/buff/herbal/scholar_focus/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_stress(/datum/stress_event/herbal_focus)
	M.add_chem_effect(CE_OXYGENATED, 1, "[type]")
	M.add_chem_effect(CE_STABLE, 1, "[type]")

/datum/reagent/buff/herbal/scholar_focus/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_OXYGENATED, "[type]")
	M.remove_chem_effect(CE_STABLE, "[type]")

/datum/reagent/buff/herbal/scholar_focus/on_mob_life(mob/living/carbon/M, efficiency)
	if(M.has_status_effect(/datum/status_effect/drowsiness))
		M.adjust_drowsiness(-6 SECONDS)
	if(prob(5))
		to_chat(M, span_notice("Your mind feels sharp and focused."))
	. = ..()

// Herbal Oils

/datum/reagent/consumable/herbal/rosa_oil
	name = "Rosa Perfume Oil"
	description = "A fragrant oil with a beautiful rose scent, used for cosmetic purposes."
	reagent_state = LIQUID
	color = "#ff69b4"
	metabolization_rate = 0.1
	taste_description = "floral perfume"

/datum/reagent/consumable/herbal/rosa_oil/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_stress(/datum/stress_event/pleasant_scent)

/datum/reagent/medicine/herbal/mentha_oil
	name = "Aceite refrescante de menta"
	description = "Un aceite refrescante que proporciona alivio a los musculos y articulaciones doloridos."
	reagent_state = LIQUID
	color = "#90ee90"
	metabolization_rate = 0.3
	taste_description = "cooling mint"

/datum/reagent/medicine/herbal/mentha_oil/on_bodypart_absorb(mob/living/carbon/affected_mob, obj/item/bodypart/affected_bodypart, amount_to_transfer)
	affected_bodypart.add_pain(-(amount_to_transfer * 0.3))
	return ..()

/datum/reagent/medicine/herbal/mentha_oil/on_mob_life(mob/living/carbon/M, efficiency)
	. = ..()
	M.adjust_stamina(1.5 * efficiency)
	M.adjust_bodytemperature(-0.3 * efficiency, BODYTEMP_NORMAL - 2)

// Dangerous Poisons

/datum/reagent/poison/herbal/atropa_concentrate
	name = "Atropa Death Draught"
	description = "Un veneno concentrado derivado de la belladona. Extremadamente letal."
	reagent_state = LIQUID
	color = "#2f1b2c"
	metabolization_rate = REAGENTS_SLOW_METABOLISM
	overdose_threshold = 10
	taste_description = "muerte amarga"

/datum/reagent/poison/herbal/atropa_concentrate/on_mob_life(mob/living/carbon/M, efficiency)
	M.adjustToxLoss(3 * efficiency)
	if(prob(20))
		M.set_eye_blur_if_lower(10 SECONDS * efficiency)
		M.set_confusion_if_lower(0.5 SECONDS * efficiency)
	. = ..()

/datum/reagent/poison/herbal/atropa_concentrate/overdose_process(mob/living/carbon/M)
	M.adjustToxLoss(5)
	M.vomit()
	if(prob(10))
		M.Unconscious(30)
	. = ..()

/datum/reagent/poison/herbal/swamp_miasma
	name = "Miasma del pantano"
	description = "A noxious concoction that creates poisonous vapors in the surrounding area."
	reagent_state = LIQUID
	color = "#556b2f"
	metabolization_rate = 0.6
	taste_description = "podredumbre del pantano"

/datum/reagent/poison/herbal/swamp_miasma/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_chem_effect(CE_BLOCKAGE, 2, "[type]")
	M.add_chem_effect(CE_BREATHLOSS, 2, "[type]")

/datum/reagent/poison/herbal/swamp_miasma/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_BLOCKAGE, "[type]")
	M.remove_chem_effect(CE_BREATHLOSS, "[type]")

/datum/reagent/poison/herbal/swamp_miasma/on_mob_life(mob/living/carbon/M, efficiency)
	M.adjustToxLoss(1.5 * efficiency)
	if(prob(15))
		M.emote("cough")
	var/turf/T = get_turf(M)
	if(T)
		T.pollute_turf(/datum/pollutant/rot, 16 * efficiency)
	. = ..()

// Magical Enhancement

/datum/reagent/buff/herbal/moonwater_elixir
	name = "Moonwater Elixir"
	description = "Un elixir mistico que mejora las habilidades magicas y la conciencia espiritual."
	reagent_state = LIQUID
	color = "#c0c0c0"
	metabolization_rate = 0.3
	overdose_threshold = 35
	taste_description = "moonlit magic"

/datum/reagent/buff/herbal/moonwater_elixir/on_mob_add(mob/living/L)
	. = ..()
	to_chat(L, span_notice("¡Tu comprension de las runas magicas se profundiza!"))
	ADD_TRAIT(L, TRAIT_MOONWATER_ELIXIR, "[type]")

/datum/reagent/buff/herbal/moonwater_elixir/on_mob_delete(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_MOONWATER_ELIXIR, "[type]")

/datum/reagent/buff/herbal/moonwater_elixir/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_stress(/datum/stress_event/mystical_boost)
	M.add_chem_effect(CE_OXYGENATED, 1, "[type]")

/datum/reagent/buff/herbal/moonwater_elixir/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_OXYGENATED, "[type]")

// Combat Enhancement

/datum/reagent/buff/herbal/battle_stim
	name = "Caldo de batalla del guerrero"
	description = "Un estimulante de combate que mejora la destreza fisica mientras mantiene la claridad mental."
	reagent_state = LIQUID
	color = "#8b0000"
	metabolization_rate = 0.5
	overdose_threshold = 45
	taste_description = "warrior's resolve"

/datum/reagent/buff/herbal/battle_stim/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_stress(/datum/stress_event/battle_stim)
	M.add_chem_effect(CE_STIMULANT, 4, "[type]")
	M.add_chem_effect(CE_OXYGENATED, 2, "[type]")
	M.add_chem_effect(CE_PULSE, 1, "[type]")
	M.add_chem_effect(CE_ENERGETIC, 3, "[type]")

/datum/reagent/buff/herbal/battle_stim/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_STIMULANT, "[type]")
	M.remove_chem_effect(CE_OXYGENATED, "[type]")
	M.remove_chem_effect(CE_PULSE, "[type]")
	M.remove_chem_effect(CE_ENERGETIC, "[type]")

/datum/reagent/buff/herbal/battle_stim/on_mob_life(mob/living/carbon/M, efficiency)
	M.adjust_stamina(-2 * efficiency)
	// Slight combat bonuses
	if(prob(10))
		M.heal_bodypart_damage(0.5 * efficiency, 0, 0)
	. = ..()

// Knowledge Enhancement

/datum/reagent/buff/herbal/alchemist_insight
	name = "Perspicacia del alquimista"
	description = "A brew that reveals the hidden properties of herbs and enhances alchemical knowledge."
	reagent_state = LIQUID
	color = "#daa520"
	metabolization_rate = 0.4
	overdose_threshold = 35
	taste_description = "hierbas iluminadoras"

/datum/reagent/buff/herbal/alchemist_insight/on_mob_add(mob/living/L)
	. = ..()
	to_chat(L, span_notice("¡Tu comprension de las propiedades de las hierbas se profundiza!"))
	ADD_TRAIT(L, TRAIT_LEGENDARY_ALCHEMIST, "[type]")

/datum/reagent/buff/herbal/alchemist_insight/on_mob_delete(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_LEGENDARY_ALCHEMIST, "[type]")

// Purification Medicine

/datum/reagent/medicine/herbal/purification_draught
	name = "Purification Draught"
	description = "A powerful cleansing draught that removes toxins, diseases, and negative effects."
	reagent_state = LIQUID
	color = "#f0f8ff"
	metabolization_rate = 0.7
	overdose_threshold = 30
	taste_description = "pure cleansing"

/datum/reagent/medicine/herbal/purification_draught/on_mob_metabolize(mob/living/M)
	. = ..()
	M.add_chem_effect(CE_ANTIBIOTIC, 15, "[type]")
	M.add_chem_effect(CE_OXYGENATED, 1, "[type]")
	M.add_chem_effect(CE_STABLE, 1, "[type]")

/datum/reagent/medicine/herbal/purification_draught/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_ANTIBIOTIC, "[type]")
	M.remove_chem_effect(CE_OXYGENATED, "[type]")
	M.remove_chem_effect(CE_STABLE, "[type]")

/datum/reagent/medicine/herbal/purification_draught/on_mob_life(mob/living/carbon/M, efficiency)
	M.adjustToxLoss(-2)
	//lower debuff durations
	for(var/datum/status_effect/debuff/debuff in M.status_effects)
		if(debuff.duration != -1)
			debuff.duration--
	. = ..()

// Mood Events for Herbal Effects

/datum/stress_event/herbal_calm
	desc = "Me siento profundamente relajado y en paz."
	stress_change = -3
	timer = 10 MINUTES

/datum/stress_event/herbal_vigor
	desc = "I feel energized and vigorous!"
	stress_change = -2
	timer = 15 MINUTES

/datum/stress_event/herbal_wellness
	desc = "I feel wonderfully healthy and restored."
	stress_change = -4
	timer = 20 MINUTES

/datum/stress_event/herbal_focus
	desc = "My mind is sharp and focused."
	stress_change = -2
	timer = 12 MINUTES

/datum/stress_event/pleasant_scent
	desc = "I smell wonderful!"
	stress_change = -1
	timer = 30 MINUTES

/datum/stress_event/mystical_boost
	desc = "I feel in tune with mystical forces."
	stress_change = -3
	timer = 15 MINUTES

/datum/stress_event/battle_stim
	desc = "¡Me siento listo para la batalla!"
	stress_change = -2
	timer = 10 MINUTES
