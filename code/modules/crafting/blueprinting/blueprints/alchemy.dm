/datum/blueprint_recipe/alchemy
	abstract_type = /datum/blueprint_recipe/alchemy
	skillcraft = /datum/attribute/skill/craft/alchemy
	category = "Alchemy"
	construct_tool = /obj/item/weapon/hammer
	craftsound = 'sound/foley/Building-01.ogg'
	verbage = "infundir"
	verbage_tp = "infunde"

/datum/blueprint_recipe/alchemy/essence_reservoir
	name = "Essence Reservoir"
	desc = "Un recipiente para almacenar esencias alquimicas."
	result_type = /obj/machinery/essence/reservoir
	required_materials = list(
		/obj/item/ingot/thaumic = 1,
		/obj/item/natural/glass = 3
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/alchemy/essence_combiner
	name = "Combinador de esencias"
	desc = "Un dispositivo para combinar diferentes esencias alquimicas."
	result_type = /obj/machinery/essence/combiner
	required_materials = list(
		/obj/item/ingot/thaumic = 2,
		/obj/item/natural/glass = 2
	)
	supports_directions = TRUE
	craftdiff = 3

/datum/blueprint_recipe/alchemy/research_matrix
	name = "Matriz de investigacion"
	desc = "Una matriz para investigar nuevas formulas alquimicas."
	result_type = /obj/machinery/essence/research_matrix
	required_materials = list(
		/obj/item/ingot/thaumic = 2,
		/obj/item/mana_battery/mana_crystal = 1
	)

/datum/blueprint_recipe/alchemy/essence_infuser
	name = "Infusor de esencia"
	desc = "Un dispositivo para infundir elementos con esencia alquimica."
	result_type = /obj/machinery/essence/infuser
	required_materials = list(
		/obj/item/natural/stone = 2,
		/obj/item/ingot/iron = 1
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/alchemy/essence_splitter
	name = "Divisor de esencia"
	desc = "Un dispositivo para dividir esencias alquimicas."
	result_type = /obj/machinery/essence/splitter
	required_materials = list(
		/obj/item/ingot/thaumic = 2,
		/obj/item/mana_battery/mana_crystal = 1
	)
	supports_directions = TRUE
	craftdiff = 3

/datum/blueprint_recipe/alchemy/enchantment_altar
	name = "Altar de encantamiento"
	desc = "Un altar para objetos encantadores con propiedades alquimicas."
	result_type = /obj/machinery/essence/enchantment_altar
	required_materials = list(
		/obj/item/natural/stone = 2,
		/obj/item/ingot/thaumic = 2,
		/obj/item/mana_battery/mana_crystal = 1
	)
	supports_directions = TRUE
	craftdiff = 4

/datum/blueprint_recipe/alchemy/essence_harvester
	name = "Essence Harvester"
	desc = "A device for harvesting alchemical essence from various sources."
	result_type = /obj/machinery/essence/harvester
	required_materials = list(
		/obj/item/ingot/thaumic = 2,
		/obj/item/mana_battery/mana_crystal = 1,
		/obj/item/natural/glass = 1
	)
	supports_directions = TRUE
	craftdiff = 3

/datum/blueprint_recipe/alchemy/separator
	name = "Alembic"
	desc = "Dispositivo para separar liquidos entre si mediante destilacion."
	result_type = /obj/structure/chem_separator
	required_materials = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/natural/glass = 1
	)
	craftdiff = 1

/datum/blueprint_recipe/alchemy/shisha
	name = "Shisha Pipe"
	desc = "Una pipa de agua tradicional para fumar hierbas y otras sustancias."
	result_type = /obj/structure/fluff/statue/shisha
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/glass = 2,
		/obj/item/natural/stone = 1
	)
	supports_directions = FALSE
	craftdiff = 2
