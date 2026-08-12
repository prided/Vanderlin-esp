
/datum/blueprint_recipe/carpentry
	abstract_type = /datum/blueprint_recipe/carpentry
	skillcraft = /datum/attribute/skill/craft/carpentry
	category = "Carpintería"
	construct_tool = /obj/item/weapon/hammer
	craftsound = 'sound/foley/Building-01.ogg'
	verbage = "build"
	verbage_tp = "builds"
	edge_density = FALSE

/datum/blueprint_recipe/carpentry/barrel
	name = "barril de madera"
	desc = "A sturdy wooden barrel for fermentation."
	result_type = /obj/structure/fermentation_keg
	required_materials = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0

/datum/blueprint_recipe/carpentry/door
	name = "puerta de madera"
	desc = "Una puerta de madera básica."
	result_type = /obj/structure/door
	required_materials = list(/obj/item/grown/log/tree/small = 2)
	supports_directions = TRUE
	craftdiff = 0
	build_time = 4 SECONDS

/datum/blueprint_recipe/carpentry/swing_door
	name = "puerta batiente"
	desc = "Una puerta que se abre en ambos sentidos."
	result_type = /obj/structure/door/swing
	required_materials = list(/obj/item/grown/log/tree/small = 2)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/fish_mount
	name = "Fish Mount"
	desc = "Wooden mount to showoff your fish."
	result_type = /obj/structure/fish_mount
	required_materials = list(/obj/item/grown/log/tree/small = 2)
	category = "Wall Fixtures"
	floor_object = FALSE
	check_adjacent_wall = TRUE
	supports_directions = TRUE
	place_on_wall = TRUE


/datum/blueprint_recipe/carpentry/deadbolt_door
	name = "wooden door (deadbolt)"
	desc = "A reinforced wooden door with a deadbolt."
	result_type = /obj/structure/door/weak/bolt
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/grown/log/tree/stick = 1
	)
	supports_directions = TRUE
	craftdiff = 1
	build_time = 4 SECONDS

/datum/blueprint_recipe/carpentry/viewport_door
	name = "wooden door (viewport)"
	desc = "Una puerta de madera con una ventana de hierro."
	result_type = /obj/structure/door/viewport
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/ingot/iron = 1
	)
	supports_directions = TRUE
	craftdiff = 2
	build_time = 4 SECONDS

/datum/blueprint_recipe/carpentry/fancy_door
	name = "puerta de madera elegante"
	desc = "An ornately crafted wooden door."
	result_type = /obj/structure/door/fancy
	required_materials = list(/obj/item/grown/log/tree/small = 2)
	supports_directions = TRUE
	craftdiff = 3
	build_time = 4 SECONDS

/datum/blueprint_recipe/carpentry/bin
	name = "contenedor de madera"
	desc = "A simple wooden storage bin."
	result_type = /obj/item/bin
	required_materials = list(/obj/item/grown/log/tree/small = 2)
	craftdiff = 0

/datum/blueprint_recipe/carpentry/chair
	name = "silla de madera"
	desc = "Una silla de madera básica."
	result_type = /obj/structure/chair/wood/alt/chair3/crafted
	required_materials = list(/obj/item/grown/log/tree/small = 1)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/fancy_chair
	name = "fancy wooden chair"
	desc = "An elegant wooden chair with silk upholstery."
	result_type = /obj/structure/chair/wood/alt/fancy/crafted
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/silk = 1
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/stool
	name = "taburete de madera"
	desc = "A simple wooden stool."
	result_type = /obj/structure/chair/stool/crafted
	required_materials = list(/obj/item/grown/log/tree/small = 1)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/stool/bar
	name = "barstool"
	desc = "Taburete con cojín de tela."
	result_type = /obj/structure/chair/stool/bar
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/cloth = 1
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/loom
	name = "loom"
	desc = "Un telar para crear textiles."
	result_type = /obj/machinery/loom
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 2
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/carpentry/lantern_post
	name = "poste de linterna"
	desc = "A tall wooden post for mounting lanterns."
	result_type = /obj/machinery/light/fueled/lanternpost/unfixed
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/grown/log/tree/stick = 2
	)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/wooden_cross
	name = "cruz de madera"
	desc = "A religious wooden cross."
	result_type = /obj/structure/fluff/psycross/crafted
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stake = 3
	)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/decorative_arch
	name = "wooden decorative arch"
	desc = "A wooden decorative arch intended to complement a table or worktop while preventing intrusion."
	result_type = /obj/structure/bars/wooden_arch
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
	)
	craftdiff = 2

/datum/blueprint_recipe/carpentry/pyre
	name = "wooden pyre"
	desc = "Una pira funeraria de madera."
	result_type = /obj/machinery/light/fueled/campfire/pyre
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/grown/log/tree/stake = 3
	)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/psydon_wooden_cross
	name = "wooden psycross"
	desc = "Un psycross de madera dedicado a Psydon."
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stake = 3
	)
	result_type = /obj/structure/fluff/psycross/psydon
	craftdiff = 1

/datum/blueprint_recipe/carpentry/wooden_stairs_down
	name = "escaleras de madera (abajo)"
	desc = "Escaleras de madera que conducen hacia abajo."
	result_type = /obj/structure/stairs/d
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/wood/plank = 2
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/carpentry/wooden_stairs_down/check_craft_requirements(mob/user, turf/T, obj/structure/blueprint/blueprint)
	var/turf/partner = get_step_multiz(get_turf(blueprint), turn(blueprint.blueprint_dir, 180)|DOWN)
	if(!isopenturf(partner))
		to_chat(user, span_warning("Need an openspace at the turf below!"))
		return FALSE
	. = ..()

/datum/blueprint_recipe/carpentry/railing
	name = "railing"
	desc = "A wooden safety railing."
	result_type = /obj/structure/fluff/railing/wood
	required_materials = list(/obj/item/grown/log/tree/small = 1)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/palisade
	name = "palisade"
	desc = "Una empalizada defensiva de madera."
	result_type = /obj/structure/fluff/railing/tall/palisade
	required_materials = list(/obj/item/grown/log/tree/stake = 2)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/fence
	name = "fence"
	desc = "Una valla de madera alta."
	result_type = /obj/structure/fluff/railing/tall
	required_materials = list(/obj/item/grown/log/tree/small = 1, /obj/item/natural/wood/plank = 2)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/chest
	name = "chest"
	desc = "A wooden storage chest."
	result_type = /obj/structure/closet/crate/chest/crafted
	required_materials = list(
		/obj/item/grown/log/tree/stake = 1,
		/obj/item/grown/log/tree/small = 2
	)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/closet
	name = "closet"
	desc = "Un armario de almacenamiento de madera."
	result_type = /obj/structure/closet/crate/crafted_closet/crafted
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/wood/plank = 1
	)
	supports_directions = TRUE
	craftdiff = 1

/datum/blueprint_recipe/carpentry/coffin
	name = "ataúd de madera"
	desc = "A wooden burial coffin."
	result_type = /obj/structure/closet/crate/coffin
	required_materials = list(/obj/item/natural/wood/plank = 3)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/hay_bed
	name = "cama de heno"
	desc = "A simple bed stuffed with hay."
	result_type = /obj/structure/bed/hay
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/cloth = 1
	)
	construct_tool = /obj/item/needle // Special case - needs sewing
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/wool_bed
	name = "cama de lana"
	desc = "A comfortable bed with wool stuffing."
	result_type = /obj/structure/bed/wool
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/cloth = 1
	)
	construct_tool = /obj/item/needle // Special case - needs sewing
	supports_directions = TRUE
	craftdiff = 4

/datum/blueprint_recipe/carpentry/double_wool_bed
	name = "double wool bed"
	desc = "Una cama doble grande con relleno de lana."
	result_type = /obj/structure/bed/wool/double
	required_materials = list(
		/obj/item/natural/wood/plank = 3,
		/obj/item/natural/cloth = 3
	)
	construct_tool = /obj/item/needle // Special case - needs sewing
	supports_directions = TRUE
	craftdiff = 4

/datum/blueprint_recipe/carpentry/nice_bed
	name = "nice bed"
	desc = "A luxurious bed with fur coverings."
	result_type = /obj/structure/bed
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/cloth = 2,
		/obj/item/natural/fur = 1
	)
	construct_tool = /obj/item/needle // Special case - needs sewing
	supports_directions = TRUE
	craftdiff = 5

/datum/blueprint_recipe/carpentry/inn_bed
	name = "nice bed without sheets"
	desc = "A quality bed frame without bedding."
	result_type = /obj/structure/bed/inn
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/cloth = 2,
		/obj/item/natural/fur = 1
	)
	construct_tool = /obj/item/needle // Special case - needs sewing
	supports_directions = TRUE
	craftdiff = 5

/datum/blueprint_recipe/carpentry/double_inn_bed
	name = "double nice bed"
	desc = "A large quality bed frame."
	result_type = /obj/structure/bed/inn/double
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/cloth = 4,
		/obj/item/natural/fur = 2
	)
	construct_tool = /obj/item/needle // Special case - needs sewing
	supports_directions = TRUE
	craftdiff = 5

/datum/blueprint_recipe/carpentry/custom_sign
	name = "signo personalizado"
	desc = "A wooden sign for custom messages."
	result_type = /obj/structure/fluff/customsign
	required_materials = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/wood/plank = 1
	)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/training_dummy
	name = "training dummy"
	desc = "A practice dummy for combat training."
	result_type = /obj/structure/fluff/statue/tdummy
	required_materials = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stick = 1
	)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/display_stand
	name = "display stand"
	desc = "A stand for displaying items."
	result_type = /obj/structure/mannequin
	required_materials = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stick = 3
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/female_mannequin
	name = "maniquí femenino"
	desc = "A female display mannequin."
	result_type = /obj/structure/mannequin/male/female
	required_materials = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/small = 1,
		/obj/item/ingot/iron = 1,
		/obj/item/natural/cloth = 1
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/male_mannequin
	name = "maniquí masculino"
	desc = "Un maniquí masculino."
	result_type = /obj/structure/mannequin/male
	required_materials = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/small = 1,
		/obj/item/ingot/iron = 1,
		/obj/item/natural/cloth = 1
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/wall_ladder
	name = "escalera de pared"
	desc = "A ladder that mounts to walls."
	result_type = /obj/structure/wallladder
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/grown/log/tree/stick = 3
	)
	supports_directions = TRUE
	craftdiff = 0
	check_adjacent_wall = TRUE

/datum/blueprint_recipe/carpentry/wooden_table
	name = "mesa de madera"
	desc = "Una mesa de madera resistente."
	result_type = /obj/structure/table/wood/crafted
	required_materials = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/wood/plank = 1
	)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/pillory
	name = "pillory"
	desc = "Un dispositivo de restricción para el castigo."
	result_type = /obj/structure/pillory
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/ingot/iron = 1,
	)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/easel
	name = "wooden easel"
	desc = "An easel for painting and art."
	result_type = /obj/structure/easel
	required_materials = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/grown/log/tree/stick = 2
	)
	supports_directions = TRUE
	craftdiff = 0

/datum/blueprint_recipe/carpentry/operating_table
	name = "mesa de operaciones"
	desc = "Una mesa diseñada para procedimientos médicos."
	result_type = /obj/structure/table/optable
	required_materials = list(/obj/item/natural/wood/plank = 2)
	supports_directions = TRUE
	craftdiff = 2

/datum/blueprint_recipe/carpentry/meathook
	name = "meathook"
	desc = "Un gancho para colgar y procesar carne."
	result_type = /obj/structure/meathook
	required_materials = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/stone = 1
	)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/spider_nest
	name = "spider nesting house"
	desc = "Un nido construido para arañas."
	result_type = /obj/structure/spider/nest/constructed
	required_materials = list(/obj/item/natural/wood/plank = 3)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/composter
	name = "composter"
	desc = "Un compostador construido."
	result_type = /obj/structure/composter
	required_materials = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0

/datum/blueprint_recipe/carpentry/plough
	name = "plough"
	desc = "Un arado."
	result_type = /obj/structure/plough
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/ingot/iron = 1
	)
	build_time = 4 SECONDS

/datum/blueprint_recipe/carpentry/handcart
	name = "carro de mano de madera"
	desc = "Un carro de mano de madera."
	result_type = /obj/structure/handcart
	required_materials = list(
		/obj/item/grown/log/tree/small = 3,
		/obj/item/rope = 1
	)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/apiary
	name = "Apiary"
	desc = "Un hogar para las abejas."
	result_type = /obj/structure/apiary
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/fibers = 2
	)
	craftdiff = 1

/datum/blueprint_recipe/carpentry/dryclothes
	name = "Clothline"
	desc = "Puede secar bien la ropa."
	result_type = /obj/structure/dryclothes
	required_materials = list(
		/obj/item/grown/log/tree/small = 2,
		/obj/item/rope = 2
	)
	craftdiff = 0

/datum/blueprint_recipe/carpentry/keyrack
	name = "key rack"
	desc = "Un armario para guardar las llaves."
	result_type = /obj/structure/closet/keyrack
	required_materials = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/ingot/iron = 1
	)
	craftdiff = 2
