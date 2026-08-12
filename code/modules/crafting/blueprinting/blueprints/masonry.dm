/datum/blueprint_recipe/masonry
	abstract_type = /datum/blueprint_recipe/masonry
	skillcraft = /datum/attribute/skill/craft/masonry
	category = "Albañileria"
	construct_tool = /obj/item/weapon/hammer
	craftsound = 'sound/foley/Building-01.ogg'
	verbage = "construct"
	verbage_tp = "construye"

/datum/blueprint_recipe/masonry/smelter
	name = "ore furnace"
	desc = "Un horno para fundir minerales en lingotes."
	result_type = /obj/machinery/light/fueled/smelter
	required_materials = list(
		/obj/item/ore/coal = 1,
		/obj/item/natural/stone = 4
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/masonry/great_smelter
	name = "gran horno"
	desc = "A massive furnace for advanced smelting."
	result_type = /obj/machinery/light/fueled/smelter/great
	required_materials = list(
		/obj/item/ingot/iron = 2,
		/obj/item/riddleofsteel = 1,
		/obj/item/ore/coal = 1
	)
	supports_directions = TRUE
	craftdiff = 3

/datum/blueprint_recipe/masonry/forge
	name = "forge"
	desc = "Una forja para forjar armas y herramientas."
	result_type = /obj/machinery/light/fueled/forge
	required_materials = list(
		/obj/item/ore/coal = 1,
		/obj/item/natural/stone = 4,
		/obj/item/grown/log/tree/small = 1
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/masonry/sharp_wheel
	name = "sharpening wheel"
	desc = "A wheel for sharpening bladed tools and weapons."
	result_type = /obj/structure/grindwheel
	required_materials = list(
		/obj/item/natural/stone = 1,
		/obj/item/ingot/iron = 1
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/masonry/oven
	name = "oven"
	desc = "Un horno para hornear pan y cocinar alimentos."
	result_type = /obj/machinery/light/fueled/oven
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/stone = 3
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/masonry/stone_door
	name = "puerta de piedra"
	desc = "Una puerta pesada tallada en piedra."
	result_type = /obj/structure/door/stone
	required_materials = list(/obj/item/natural/stone = 2)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/masonry/stone_table
	name = "mesa de piedra"
	desc = "Una mesa duradera tallada en piedra."
	result_type = /obj/structure/table/stone_small
	required_materials = list(/obj/item/natural/stone = 2)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/masonry/cauldron
	name = "cauldron"
	desc = "A large iron cauldron for brewing and cooking."
	result_type = /obj/machinery/light/fueled/cauldron
	required_materials = list(
		/obj/item/ingot/iron = 1,
		/obj/item/natural/stone = 3,
		/obj/item/grown/log/tree/small = 1
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/masonry/stone_stairs_down
	name = "escaleras de piedra (abajo)"
	desc = "Escaleras de piedra duraderas que conducen hacia abajo."
	result_type = /obj/structure/stairs/stone/d
	required_materials = list(/obj/item/natural/stone = 2)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/masonry/stone_stairs_down/check_craft_requirements(mob/user, turf/T, obj/structure/blueprint/blueprint)
	var/turf/partner = get_step_multiz(get_turf(blueprint), DOWN|turn(blueprint.blueprint_dir, 180))
	if(!isopenturf(partner))
		to_chat(user, span_warning("Need an openspace at the turf below!"))
		return FALSE
	. = ..()

/datum/blueprint_recipe/masonry/stone_railing
	name = "barandilla de piedra"
	desc = "A sturdy stone safety railing."
	result_type = /obj/structure/fluff/railing/stonehedge
	required_materials = list(/obj/item/natural/stone = 1)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/masonry/stained_window_silver
	name = "stained glass window (silver)"
	desc = "An ornate stained glass window with silver framing."
	result_type = /obj/structure/window/stained/silver/alt
	required_materials = list(
		/obj/item/ingot/silver = 1,
		/obj/item/natural/stone = 3,
		/obj/item/natural/glass = 2
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/masonry/stained_window_gold
	name = "stained glass window (gold)"
	desc = "A magnificent stained glass window with gold framing."
	result_type = /obj/structure/window/stained/yellow
	required_materials = list(
		/obj/item/ingot/gold = 1,
		/obj/item/natural/stone = 3,
		/obj/item/natural/glass = 2
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/masonry/openable_window
	name = "openable glass window"
	desc = "A glass window that can be opened and closed."
	result_type = /obj/structure/window/openclose
	required_materials = list(
		/obj/item/ingot/iron = 1,
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/glass = 1
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/masonry/solid_window
	name = "fixed glass window"
	desc = "A fixed glass window for letting in light."
	result_type = /obj/structure/window/solid
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/glass = 1
	)
	supports_directions = TRUE
	craftdiff = 0
