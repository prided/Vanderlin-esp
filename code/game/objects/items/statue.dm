
/obj/item/statue
	icon = 'icons/roguetown/items/valuable.dmi'
	name = "estatua"
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null
	grid_width = 32
	grid_height = 64
	item_weight = 1.5 KILOGRAMS

/obj/item/statue/gold
	name = "estatua de oro"
	icon_state = "gstatue1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 120
	item_weight = 3 KILOGRAMS

/obj/item/statue/gold/Initialize()
	. = ..()
	icon_state = "gstatue[pick(1,2)]"

/obj/item/statue/gold/loot
	name = "estatuilla de oro"
	icon_state = "lstatue1"
	sellprice = 45
	item_weight = 1 KILOGRAMS

/obj/item/statue/gold/loot/Initialize()
	. = ..()
	sellprice = rand(45,100)
	icon_state = "lstatue[pick(1,2)]"

/obj/item/statue/silver
	name = "estatua de plata"
	icon_state = "sstatue1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 90
	item_weight = 2 KILOGRAMS

/obj/item/statue/silver/Initialize()
	. = ..()
	icon_state = "sstatue[pick(1,2)]"
	enchant(/datum/enchantment/silver)

/*	..................   Misc   ................... */
/obj/item/statue/silver/gnome
	name = "gnomo petrificado"
	desc = "Un gnomo literal, convertido en piedra a medio paso y colocado sobre una plataforma de piedra a juego. Bastante inquietante."
	smeltresult = null
	sellprice = 120
	item_weight = 2 KILOGRAMS

/obj/item/statue/steel
	name = "estatua de acero"
	icon_state = "ststatue1"
	melt_amount = 50
	melting_material = /datum/material/steel
	sellprice = 60
	item_weight = 2.5 KILOGRAMS

/obj/item/statue/steel/Initialize()
	. = ..()
	icon_state = "ststatue[pick(1,2)]"

/obj/item/statue/iron
	name = "estatua de hierro"
	icon_state = "istatue1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 40
	item_weight = 2 KILOGRAMS

/obj/item/statue/iron/Initialize()
	. = ..()
	icon_state = "istatue[pick(1,2)]"

/obj/item/statue/iron/deformed
	name = "estatua de hierro deformada"
	desc = "Hay algo extraño en esta estatua..."
	icon_state = "istatue1"
	smeltresult = /obj/item/ore/iron
	sellprice = 10

/*	..................   Silver  ................... */
/obj/item/statue/silver/volf
	name = "busto de volf plateado"
	desc = "Un busto plateado que se asemeja a la cabeza de un volf."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "volf_silv"
	dropshrink = 0.7
	smeltresult = /obj/item/ingot/silver
	sellprice = 45

/obj/item/statue/silver/volf/Initialize()
	. = ..()
	icon_state = "volf_silv" // whoever designed this system needs to be cursed

/obj/item/statue/silver/finger
	name = "mano de plata"
	desc = "Una estatua plateada de una mano humen que muestra un desaire xylixiano comun. Este objeto ofensivo no tiene valor."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "finger_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 0

/obj/item/statue/silver/finger/Initialize()
	. = ..()
	icon_state = "finger_silv"

/obj/item/statue/silver/urn
	name = "urna de plata"
	desc = "Una gran urna decorativa plateada."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "urn_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 50

/obj/item/statue/silver/urn/Initialize()
	. = ..()
	icon_state = "urn_silv"

/obj/item/statue/silver/vase
	name = "florero de plata"
	desc = "Un gran jarron decorativo plateado."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "vase_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 25

/obj/item/statue/silver/vase/Initialize()
	. = ..()
	icon_state = "vase_silv"

/obj/item/statue/silver/vasefancy
	name = "florero de plata de lujo"
	desc = "Un gran jarron decorativo de plata. ¡Es bastante elegante!"
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "fancyvase_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 45

/obj/item/statue/silver/vasefancy/Initialize()
	. = ..()
	icon_state = "fancyvase_silv"

/obj/item/statue/silver/bust
	name = "busto de plata"
	desc = "Un busto realizado en plata."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "bust_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 30

/obj/item/statue/silver/bust/Initialize()
	. = ..()
	icon_state = "bust_silv"

/obj/item/statue/silver/figurine
	name = "estatuilla de plata"
	desc = "Una figura hecha de plata. Popular entre los adultos como decoracion, popular entre los niños como juguete."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "figurine_silv"
	sellprice = 15

/obj/item/statue/silver/figurine/Initialize()
	. = ..()
	icon_state = "figurine_silv"

/obj/item/statue/silver/obelisk
	name = "obelisco de plata"
	desc = "Un obelisco elaborado en plata."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "obelisk_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 30

/obj/item/statue/silver/obelisk/Initialize()
	. = ..()
	icon_state = "obelisk_silv"

/obj/item/statue/silver/fish
	name = "estatuilla de pez plateado"
	desc = "Figura de pez realizada en plata."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "fish_silv"
	sellprice = 15

/obj/item/statue/silver/fish/Initialize()
	. = ..()
	icon_state = "fish_silv"

/obj/item/statue/silver/tablet
	name = "tableta de plata"
	desc = "Una tablilla hecha de plata."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "tablet_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 25

/obj/item/statue/silver/tablet/Initialize()
	. = ..()
	icon_state = "tablet_silv"

/obj/item/statue/silver/cameo
	name = "camafeo de plata"
	desc = "Un camafeo hecho de plata que representa... ¿alguien? Usa tu imaginacion para saber quien podria ser."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "cameo_silv"
	sellprice = 15

/obj/item/statue/silver/cameo/Initialize()
	. = ..()
	icon_state = "cameo_silv"

/obj/item/statue/silver/comb
	name = "peine de plata"
	desc = "Un peine plateado, ideal para peinar tu cabello o falta de el."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "combs_silv"
	sellprice = 10

/obj/item/statue/silver/comb/Initialize()
	. = ..()
	icon_state = "comb_silv"

/obj/item/statue/silver/totem
	name = "totem de plata"
	desc = "Un totem elfico hecho de plata."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "elven_silv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 35

/obj/item/statue/silver/totem/Initialize()
	. = ..()
	icon_state = "elven_silv"

/*	..................   Gold   ................... */
/obj/item/statue/gold/volf
	name = "busto de volf dorado"
	desc = "Un busto dorado que se asemeja a la cabeza de un volf."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "volf_gold"
	dropshrink = 0.7
	smeltresult = /obj/item/ingot/gold
	sellprice = 85

/obj/item/statue/gold/volf/Initialize()
	. = ..()
	icon_state = "volf_gold"

/obj/item/statue/gold/finger
	name = "mano dorada"
	desc = "Una estatua dorada de una mano humen que muestra un desaire xylixiano comun. Este objeto ofensivo tiene un valor miserable."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "finger_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 1

/obj/item/statue/gold/finger/Initialize()
	. = ..()
	icon_state = "finger_gold"

/obj/item/statue/gold/urn
	name = "urna de oro"
	desc = "Una gran urna decorativa de oro."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "urn_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 100

/obj/item/statue/gold/urn/Initialize()
	. = ..()
	icon_state = "urn_gold"

/obj/item/statue/gold/vase
	name = "florero de oro"
	desc = "Un gran jarron decorativo dorado."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "vase_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 45

/obj/item/statue/gold/vase/Initialize()
	. = ..()
	icon_state = "vase_gold"

/obj/item/statue/gold/vasefancy
	name = "florero de oro de lujo"
	desc = "Un gran jarron decorativo de oro. ¡Es bastante elegante!"
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "fancyvase_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 80

/obj/item/statue/gold/vasefancy/Initialize()
	. = ..()
	icon_state = "fancyvase_gold"

/obj/item/statue/gold/bust
	name = "busto de oro"
	desc = "Un busto hecho de oro."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "bust_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 60

/obj/item/statue/gold/bust/Initialize()
	. = ..()
	icon_state = "bust_gold"

/obj/item/statue/gold/figurine
	name = "estatuilla dorada"
	desc = "Una figura hecha de oro. Popular entre los adultos como decoracion, popular entre los niños como juguete."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "figurine_gold"
	sellprice = 30

/obj/item/statue/gold/figurine/Initialize()
	. = ..()
	icon_state = "figurine_gold"

/obj/item/statue/gold/cameo
	name = "camafeo dorado"
	desc =  "Un camafeo hecho de oro que representa... ¿alguien? Usa tu imaginacion para saber quien podria ser."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "cameo_gold"
	sellprice = 30

/obj/item/statue/gold/cameo/Initialize()
	. = ..()
	icon_state = "cameo_gold"

/obj/item/statue/gold/obelisk
	name = "obelisco de oro"
	desc =  "Un obelisco hecho de oro."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "obelisk_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 60

/obj/item/statue/gold/obelisk/Initialize()
	. = ..()
	icon_state = "obelisk_gold"

/obj/item/statue/gold/tablet
	name = "tableta de oro"
	desc =  "Una tablilla hecha de oro."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "tablet_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 45

/obj/item/statue/gold/tablet/Initialize()
	. = ..()
	icon_state = "tablet_gold"

/obj/item/statue/gold/fish
	name = "estatuilla de pez dorado"
	desc =  "Figura de pez hecha de oro."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "fish_gold"
	sellprice = 30

/obj/item/statue/gold/fish/Initialize()
	. = ..()
	icon_state = "fish_gold"

/obj/item/statue/gold/totem
	name = "totem de oro"
	desc =  "Un totem elfico hecho de oro."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "elven_gold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 65

/obj/item/statue/gold/totem/Initialize()
	. = ..()
	icon_state = "elven_gold"

/obj/item/statue/gold/comb
	name = "peine dorado "
	desc =  "Un peine dorado, ideal para peinar tu cabello o falta de el."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "comb_gold"
	sellprice = 30

/obj/item/statue/gold/comb/Initialize()
	. = ..()
	icon_state = "comb_gold"

/*	.................. Bronze  ................... */

/obj/item/statue/bronze
	name = "estatua de bronce"
	icon_state = "bstatue1"
	smeltresult = /obj/item/ingot/bronze
	sellprice = 30
	item_weight = 2.2 KILOGRAMS

/obj/item/statue/bronze/volf
	name = "busto de volf de bronce"
	desc = "Un busto de bronce que se asemeja a la cabeza de un volf."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "volf_bronze"
	dropshrink = 0.7
	sellprice = 60

/obj/item/statue/bronze/urn
	name = "urna de bronce"
	desc = "Una gran urna decorativa de bronce."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "urn_bronze"
	sellprice = 60 // because its two bronze bars

/obj/item/statue/bronze/vase
	name = "florero de bronce"
	desc = "Un gran jarron decorativo de bronce."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "vase_bronze"
	sellprice = 30

/obj/item/statue/bronze/vasefancy
	name = "elegante jarron de bronce"
	desc = "Un gran jarron decorativo de bronce. ¡Es bastante elegante!"
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "fancyvase_bronze"
	sellprice = 60

/obj/item/statue/bronze/bust
	name = "busto de bronce"
	desc = "Un busto realizado en bronce."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "bust_bronze"
	sellprice = 30

/obj/item/statue/bronze/figurine
	name = "estatuilla de bronce"
	desc = "Una figura realizada en bronce. Popular entre los adultos como decoracion, popular entre los niños como juguete."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "figurine_bronze"
	sellprice = 15

/obj/item/statue/bronze/cameo
	name = "camafeo de bronce"
	desc =  "Un camafeo hecho en bronce que representa... ¿alguien? Usa tu imaginacion para saber quien podria ser."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "cameo_bronze"
	sellprice = 15

/obj/item/statue/bronze/obelisk
	name = "obelisco de bronce"
	desc =  "Un obelisco realizado en bronce."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "obelisk_bronze"
	sellprice = 30

/obj/item/statue/bronze/tablet
	name = "tableta de bronce"
	desc =  "Una tablilla hecha de bronce."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "tablet_bronze"
	sellprice = 30

/obj/item/statue/bronze/fish
	name = "estatuilla de pez de bronce"
	desc =  "Figura de pez realizada en bronce."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "fish_bronze"
	sellprice = 15

/obj/item/statue/bronze/totem
	name = "totem de bronce"
	desc =  "Un totem elfico hecho de bronce."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "elven_bronze"
	sellprice = 30

/obj/item/statue/bronze/comb
	name = "peine de bronce"
	desc =  "Un peine de bronce, ideal para peinar tu cabello o falta de el."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "comb_bronze"
	sellprice = 15

/obj/item/statue/stone
	name = "estatua de piedra"
	icon_state = "svase1"
	smeltresult = null
	sellprice = 10
	item_weight = 1.5 KILOGRAMS

/obj/item/statue/stone/vase
	name = "florero de piedra"
	desc = "Un gran jarron decorativo de piedra."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "svase1"
	sellprice = 15

/obj/item/statue/stone/vase/Initialize()
	. = ..()
	icon_state = "svase[pick(1,2)]"

