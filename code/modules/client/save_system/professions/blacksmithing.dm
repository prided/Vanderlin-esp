/datum/profession/blacksmith
	name = "Blacksmith"
	description = "Una profesion dedicada a convertir minerales en armas y armaduras utiles."

/datum/profession/blacksmith/initialize_unlocks()
	level_unlocks[1] = list(
		PASSIVE_KEY = list(
			/datum/passive/smelting,
			/datum/passive/repair,
			/datum/passive/sharpening,
			),
		RECIPE_KEY = list(
			/datum/anvil_recipe/weapons/copper,
		)
	)
