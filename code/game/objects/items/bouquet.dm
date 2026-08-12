// BOUQUETS & FLOWER CROWNS

/obj/item/bouquet
	name = "ramo"
	desc = "El ramo que mas ama la gente es aquel que produce una hermosa exhibicion de flores."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "bouquet_base"
	item_state = ""

	grid_width = 32
	grid_height = 64
	item_weight = 27 GRAMS

/obj/item/bouquet/rosa
	name = "ramo de rosas"
	desc =  "Un ramo de rosas, una de las flores mas bonitas de Eora. Son un simbolo de amor y devocion."
	icon_state = "bouquet_rosa"

/obj/item/bouquet/salvia
	name = "ramo de salvia"
	desc = "Un ramo de salvia de olor dulce, una hermosa y real flor de color purpura."
	icon_state = "bouquet_salvia"

/obj/item/bouquet/matricaria
	name = "matricaria bouquet"
	desc = "Un ramo de maricaria."
	icon_state = "bouquet_matricaria"

/obj/item/bouquet/calendula
	name = "ramo de calendula"
	desc = "Un ramo de calendula, flor utilizada en fitoterapia por sus supuestas propiedades curativas."
	icon_state = "bouquet_calendula"

/obj/item/clothing/head/flowercrown
	name = ""
	desc = ""
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	alternate_worn_layer  = 8.9 //On top of helmet
	dynamic_hair_suffix = null
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	body_parts_covered = null
	icon_state = ""
	item_state = ""
	abstract_type = /obj/item/clothing/head/flowercrown

	grid_width = 64
	grid_height = 32
	item_weight = 22 GRAMS

/obj/item/clothing/head/flowercrown/rosa
	name = "corona rosa"
	desc = "Una corona de rosas, que a menudo se usa durante las bodas oficiadas por acolitos Eoran."
	item_state = "rosa_crown"
	icon_state = "rosa_crown"

/obj/item/clothing/head/flowercrown/cursedrosa
	name = "corona de rosa de zarza negra"
	desc = ""
	item_state = "cursedrosa_crown"
	icon_state = "cursedrosa_crown"

/obj/item/clothing/head/flowercrown/salvia
	name = "corona de salvia"
	desc = "Una corona de salvia, a menudo usada por consortes y princesas de cortes reales particularmente alegres."
	item_state = "salvia_crown"
	icon_state = "salvia_crown"

/obj/item/clothing/head/flowercrown/matricaria
	name = "corona de matricaria"
	item_state = "matricaria_crown"
	icon_state = "matricaria_crown"

/obj/item/clothing/head/flowercrown/calendula
	name = "corona de calendula"
	item_state = "calendula_crown"
	icon_state = "calendula_crown"

/obj/item/clothing/head/flowercrown/manabloom
	name = "corona de manabloom"
	desc = "Una corona formada con flores de manabloom. Suele ser usada por quienes necesitan una \
	sintonia mas profunda con lo arcyne; es la favorita tanto de aprendices jovenes como de maestros ancianos que flaquean."
	item_state = "manabloom_crown"
	icon_state = "manabloom_crown"
