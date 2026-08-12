
/datum/quality_calculator/metallurgy
	name = "Metallurgy Quality"

	quality_descriptors = alist(
		SMELTERY_QUALITY_SPOIL = list(
			"name_prefix" = "horrible",
			"description" = "",
		),
		SMELTERY_QUALITY_POOR = list(
			"name_prefix" = "",
			"description" = "",
		),
		SMELTERY_QUALITY_NORMAL = list(
			"name_prefix" = "",
			"description" = "",
		),
		SMELTERY_QUALITY_GOOD = list(
			"name_prefix" = list("refinado", "procesado"),
			"description" = "It shows signs of careful refinement.",
		),
		SMELTERY_QUALITY_GREAT = list(
			"name_prefix" = list("high-grade", "superior"),
			"description" = list(
				"Brilla con una pureza excepcional.",
				"La estructura metálica parece impecable.",
				"It radiates quality craftsmanship."
			),
		),
		SMELTERY_QUALITY_EXCELLENT = list(
			"name_prefix" = list("pristine", "legendary"),
			"description" = list(
				"Representa el pináculo de la perfección metalúrgica.",
				"The metal seems to shine with inner light.",
				"Esta es una obra maestra de refinamiento."
			),
		)
	)

/datum/quality_calculator/metallurgy/calculate_final_quality()
	/* SHOULD MATCH CALCULATIONS OF SMELTERS
	RANDOMLY PICKED NUMBER ACCORDING TO SMELTER SKILL:
		NO SKILL: 		between 10 and 30
		NOVICE:	 		between 25 and 30
		APPRENTICE:	 	between 40 and 50
		JOURNEYMAN: 	between 55 and 75
		EXPERT: 		between 70 and 100
		MASTER: 		between 85 and 125
		LEGENDARY: 		between 100 and 150
	PICKED NUMBER GETS DIVIDED BY SMELTING_DENOMINATOR.
	*/
	var/skill_factor = (rand(skill_quality*15 + 10, max(30, skill_quality*25)) / SMELTING_DENOMINATOR)
	var/material_factor = (material_quality - SMELTERY_QUALITY_SPOIL) * 0.5

	var/final_quality = floor(material_factor + skill_factor)

	return clamp(final_quality, SMELTERY_QUALITY_SPOIL, SMELTERY_QUALITY_EXCELLENT)

/datum/quality_calculator/metallurgy/apply_quality_to_item(obj/item/target, track_creation, quality_override)
	if(!target)
		return FALSE

	if(!quality_override)
		quality_override = calculate_final_quality()
	quality_override = clamp(quality_override, SMELTERY_QUALITY_SPOIL, SMELTERY_QUALITY_EXCELLENT)

	. = ..(target, track_creation, quality_override)
	target.set_quality(quality_override)

/datum/quality_calculator/metallurgy/track_item_creation(obj/item/target, final_quality)
	if(final_quality >= SMELTERY_QUALITY_EXCELLENT)
		record_round_statistic(STATS_MASTERWORKS_FORGED, 1)
