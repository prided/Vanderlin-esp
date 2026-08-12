/datum/blueprint_recipe/arcyne
	abstract_type = /datum/blueprint_recipe/arcyne
	skillcraft = /datum/attribute/skill/magic/arcane
	category = "Arcano"
	construct_tool = /obj/item/weapon/hammer
	craftsound = 'sound/foley/Building-01.ogg'
	verbage = "tejer"
	verbage_tp = "weaves"

/datum/blueprint_recipe/arcyne/mana_pylon
	name = "mana pylon"
	desc = "A crystalline pylon that channels and focuses mana."
	result_type = /obj/structure/mana_pylon
	required_materials = list(
		/obj/item/natural/stone = 2,
		/obj/item/gem/amethyst = 1
	)
	craftdiff = 2
