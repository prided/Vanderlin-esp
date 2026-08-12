/obj/item/ore/dust
	name = "polvo de mineral"
	icon_state = "dust"
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 32
	grid_height = 32
	item_weight = 300 GRAMS

/obj/item/ore/dust/Initialize(mapload)
	. = ..()
	if(melting_material)
		color = initial(melting_material.color)

/obj/item/ore/dust/gold
	name = "polvo de oro"
	desc = "Finas particulas de mineral de oro."
	melting_material = /datum/material/gold
	item_weight = 500 GRAMS

/obj/item/ore/dust/silver
	name = "polvo de plata"
	desc = "Finas particulas de mineral de plata."
	melting_material = /datum/material/silver
	item_weight = 400 GRAMS

/obj/item/ore/dust/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/ore/dust/iron
	name = "polvo de hierro"
	desc = "Finas particulas de mineral de hierro."
	melting_material = /datum/material/iron
	item_weight = 350 GRAMS

/obj/item/ore/dust/copper
	name = "polvo de cobre"
	desc = "Finas particulas de mineral de cobre."
	melting_material = /datum/material/copper
	item_weight = 350 GRAMS

/obj/item/ore/dust/tin
	name = "polvo de estaño"
	desc = "Finas particulas de mineral de estaño."
	melting_material = /datum/material/tin
	item_weight = 300 GRAMS
