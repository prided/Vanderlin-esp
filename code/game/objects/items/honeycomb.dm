
/obj/item/reagent_containers/food/snacks/spiderhoney
	name = "panal"
	desc = ""
	icon_state = "honey"
	dropshrink = 0.8
	possible_transfer_amounts = list()
	spillable = FALSE
	volume = 10
	amount_per_transfer_from_this = 0
	nutrition = HONEY_NUTRITION
	list_reagents = list(/datum/reagent/consumable/honey = 5)
	grind_results = list()
	tastes = list("dulzura" = 1)
	item_weight = 30 GRAMS
	var/honey_color

/obj/item/reagent_containers/food/snacks/spiderhoney/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(8,-8)
	pixel_y = base_pixel_y + rand(8,-8)

/obj/item/reagent_containers/food/snacks/spiderhoney/proc/set_reagent(reagent)
	var/datum/reagent/R = GLOB.chemical_reagents_list[reagent]
	if(istype(R))
		name = "panal ([R.name])"
		reagents.add_reagent(R.type,5)

/obj/item/reagent_containers/food/snacks/spiderhoney/honey
	name = "miel"
	icon_state = "honeycomb"
	item_weight = 50 GRAMS
	tastes = list("dulzura" = 1)

/obj/item/reagent_containers/food/snacks/spiderhoney/honey/mad
	name = "miel loca"
	desc = "Miel de color verde oscuro contaminada por las extrañas plantas del pantano, pero a menudo buscada por Dendorite Melissae."
	icon_state = "honey_green"
	volume = 20
	tastes = list("dulzura terrosa" = 1, "algo picante" = 1)
	list_reagents = list(/datum/reagent/consumable/honey = 4, /datum/reagent/druqks = 10, /datum/reagent/toxin = 5)

/obj/item/reagent_containers/food/snacks/spiderhoney/honey/poppy
	name = "miel roja"
	desc = "Una rica miel roja, todavia utilizada en la medicina tradicional y apreciada por los fieles de Pestra."
	icon_state = "honey_red"
	volume = 20
	tastes = list("dulzura entumecedora" = 1, "un destello de blanco" = 1)
	list_reagents = list(/datum/reagent/consumable/honey = 4, /datum/reagent/ozium = 10, /datum/reagent/medicine/herbal/herbalist_panacea = 5)

/obj/item/reagent_containers/food/snacks/spiderhoney/honey/toxic
	name = "miel"
	desc = ""
	icon_state = "honeycomb"
	tastes = list("amargura" = 1)
	list_reagents = list(/datum/reagent/consumable/honey = 5, /datum/reagent/berrypoison = 5)

/obj/item/reagent_containers/food/snacks/spiderhoney/honey/luminescent
	name = "miel de luna"
	desc = "Extraña miel azul, que brilla suavemente con toda la promesa y el peligro del conocimiento estelar de Noc."
	icon_state = "honey_glowing"
	volume = 20
	tastes = list("dulzura compleja" = 1, "tonos florales nitidos" = 1)
	list_reagents = list(/datum/reagent/consumable/honey = 5, /datum/reagent/toxin/manabloom_juice = 2, /datum/reagent/medicine/manapot = 10)
	light_system = MOVABLE_LIGHT
	light_outer_range = 2
	light_power = 1
	light_color = "#CCFF99"

/obj/item/reagent_containers/food/snacks/spiderhoney/honey/wild
	name = "miel silvestre"
	desc = "Dulce miel silvestre. Tiene un sabor mas complejo que la miel normal."
	icon_state = "honey_wild"
	honey_color = "#6d4633"
	list_reagents = list(/datum/reagent/consumable/honey = 7)
