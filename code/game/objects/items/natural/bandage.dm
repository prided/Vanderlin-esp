/obj/item/natural/cloth/bandage
	name = "vendaje"
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "bandageroll"
	desc = "Un tejido tratado y confeccionado especialmente para ayudar en las heridas sangrantes. Mejor y mas rapido para detener el sangrado que un paño normal."
	bundletype = /obj/item/natural/bundle/cloth/bandage
	bandage_effectiveness = 0.25
	bandage_health = 500
	bandage_speed = 4 SECONDS
	volume = 18
	item_weight = 18 GRAMS

/obj/item/natural/bundle/cloth/bandage
	name = "rollo de vendas"
	icon = 'icons/roguetown/items/surgery.dmi'
	icon_state = "bandageroll1"
	desc = "Un rollo de vendas unidas para facilitar su transporte. El mejor amigo de un hombre sangrante."
	maxamount = 4
	stacktype = /obj/item/natural/cloth/bandage
	stackname = "vendas"
	icon1 = "bandageroll1"
	icon1step = 3
	icon2 = "bandageroll2"
	icon2step = 4

/obj/item/natural/bundle/cloth/bandage/full
	icon_state = "bandageroll2"
	amount = 4
