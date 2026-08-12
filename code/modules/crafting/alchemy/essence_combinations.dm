
/datum/essence_combination
	abstract_type = /datum/essence_combination
	var/category = "Essence Combination"
	var/name = "essence combination"
	var/list/inputs = list() // essence_type = amount_needed
	var/datum/thaumaturgical_essence/output_type = null
	var/output_amount = 1
	var/skill_required = SKILL_RANK_NOVICE

// Tier 1 combinations (Basic essences -> First Compound)
/datum/essence_combination/frost
	name = "Esencia de escarcha"
	inputs = list(
		/datum/thaumaturgical_essence/air = 2,
		/datum/thaumaturgical_essence/water = 2
	)
	output_type = /datum/thaumaturgical_essence/frost
	output_amount = 3

/datum/essence_combination/light
	name = "Esencia de luz"
	inputs = list(
		/datum/thaumaturgical_essence/fire = 2,
		/datum/thaumaturgical_essence/order = 2
	)
	output_type = /datum/thaumaturgical_essence/light
	output_amount = 3

/datum/essence_combination/motion
	name = "Motion Essence"
	inputs = list(
		/datum/thaumaturgical_essence/air = 2,
		/datum/thaumaturgical_essence/chaos = 2
	)
	output_type = /datum/thaumaturgical_essence/motion
	output_amount = 3

/datum/essence_combination/cycle
	name = "Cycle Essence"
	inputs = list(
		/datum/thaumaturgical_essence/water = 2,
		/datum/thaumaturgical_essence/earth = 2
	)
	output_type = /datum/thaumaturgical_essence/cycle
	output_amount = 3

/datum/essence_combination/energia
	name = "Esencia de energía"
	inputs = list(
		/datum/thaumaturgical_essence/fire = 2,
		/datum/thaumaturgical_essence/chaos = 2,
	)
	output_type = /datum/thaumaturgical_essence/energia
	output_amount = 3

/datum/essence_combination/void
	name = "Esencia del Vacío"
	inputs = list(
		/datum/thaumaturgical_essence/chaos = 2,
		/datum/thaumaturgical_essence/earth = 2,
	)
	output_type = /datum/thaumaturgical_essence/void
	output_amount = 3

/datum/essence_combination/poison
	name = "Esencia de veneno"
	inputs = list(
		/datum/thaumaturgical_essence/chaos = 2,
		/datum/thaumaturgical_essence/water = 2,
	)
	output_type = /datum/thaumaturgical_essence/poison
	output_amount = 3

/datum/essence_combination/life
	name = "Esencia de vida"
	inputs = list(
		/datum/thaumaturgical_essence/water = 2,
		/datum/thaumaturgical_essence/order = 2,
	)
	output_type = /datum/thaumaturgical_essence/life
	output_amount = 3

/datum/essence_combination/crystal
	name = "Esencia de cristal"
	inputs = list(
		/datum/thaumaturgical_essence/earth = 2,
		/datum/thaumaturgical_essence/order = 2,
	)
	output_type = /datum/thaumaturgical_essence/crystal
	output_amount = 3

// Tier 2 combinations (First Compound -> Second Compound)
/datum/essence_combination/magic
	name = "Esencia mágica"
	inputs = list(
		/datum/thaumaturgical_essence/energia = 2,
		/datum/thaumaturgical_essence/void = 2,
		/datum/thaumaturgical_essence/order = 1,
	)
	output_type = /datum/thaumaturgical_essence/magic
	output_amount = 2
	skill_required = SKILL_RANK_JOURNEYMAN

/datum/essence_combination/death
	name = "Death Essence"
	inputs = list(
		/datum/thaumaturgical_essence/void = 4,
		/datum/thaumaturgical_essence/poison = 2,
		/datum/thaumaturgical_essence/chaos = 2,
	)
	output_type = /datum/thaumaturgical_essence/death
	output_amount = 2
	skill_required = SKILL_RANK_JOURNEYMAN
