/datum/blueprint_recipe/structure/wonder
	name = "wonder"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 1,
	)
	verbage = "construye"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = null
	requires_learning = TRUE
	construct_tool = null

/datum/blueprint_recipe/structure/wonder/first
	name = "primera maravilla (2 partes del cuerpo, 1 estomago)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 1,
	)
	requires_learning = TRUE

/datum/blueprint_recipe/structure/wonder/second
	name = "Segunda maravilla (2 partes del cuerpo, 2 pulmones)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/lungs = 2,
	)
	requires_learning = TRUE

/datum/blueprint_recipe/structure/wonder/third
	name = "tercera maravilla (2 partes del cuerpo, 3 cabezas, 2 estomagos)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart/head = 3,
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 2,
	)
	requires_learning = TRUE

/datum/blueprint_recipe/structure/wonder/fourth
	name = "cuarta maravilla (4 lenguas, 3 ojos, 4 higados)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/organ/tongue = 4,
		/obj/item/organ/eyes = 3,
		/obj/item/organ/liver = 4,
	)
	requires_learning = TRUE
