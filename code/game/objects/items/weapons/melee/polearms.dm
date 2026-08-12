/* POLEARMS
==========================================================*/

/obj/item/weapon/polearm
	throwforce = DAMAGE_STAFF
	icon = 'icons/roguetown/weapons/64/polearms.dmi'
	wdefense = GREAT_PARRY
	SET_BASE_PIXEL(-16, -16)
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	max_blade_int = 100
	max_integrity = INTEGRITY_STRONG
	associated_skill = /datum/attribute/skill/combat/polearms
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	thrown_bclass = BCLASS_STAB
	grid_height = 96
	grid_width = 64
	sellprice = 20
	item_weight = 2 KILOGRAMS

/obj/item/weapon/polearm/Initialize()
	. = ..()
	AddElement(/datum/element/walking_stick)

/obj/item/weapon/polearm/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


//................ Wooden Staff ............... //
/obj/item/weapon/polearm/woodstaff
	name = "baston de madera"
	desc = "La herramienta de viaje definitiva para los vagabundos cansados, soporta tu peso o rompe las cabezas que no te soportan."
	icon_state = "woodstaff"
	force =  DAMAGE_STAFF
	force_wielded =  DAMAGE_STAFF_WIELD
	wdefense = GREAT_PARRY
	wlength = WLENGTH_LONG
	possible_item_intents = list(POLEARM_BASH)
	gripped_intents = list(POLEARM_BASH, MACE_WOODSMASH)
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/fertilizer/ash
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_BLUNT
	sellprice = 5
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/woodstaff/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = -1,"nx" = 8,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//................ Quarterstaff ............... //!
/obj/item/weapon/polearm/woodstaff/quarterstaff
	name = "baston de madera"
	desc = "Un personal que hace mas facil cualquier viaje. Durable y veloz, capaz de golpear tanto a los volves perdidos como a los rufianes."
	icon_state = "quarterstaff"
	force_wielded =  DAMAGE_STAFF_WIELD + 3
	max_integrity = INTEGRITY_STRONG * 0.8
	sellprice = 10
	item_weight = 1.2 KILOGRAMS

//................ Iron-shod Staff ............... //
/obj/item/weapon/polearm/woodstaff/quarterstaff/iron
	name = "baston de hierro"
	desc = "Una herramienta perfecta para los cazarrecompensas que prefieren que sus prisioneros esten rotos y magullados, pero no asesinados. Este baston reforzado es capaz de someter incluso a un oponente armado con algunos golpes cuidadosamente colocados."
	icon_state = "quarterstaff_iron"
	force = DAMAGE_STAFF + 4
	force_wielded = DAMAGE_STAFF_WIELD + 5
	gripped_intents = list(POLEARM_BASH, MACE_SMASH)
	max_integrity = INTEGRITY_STRONG
	minstr = 7
	item_weight = 1 KILOGRAMS
	smeltresult = null
	melting_material = /datum/material/iron
	melt_amount = 75

/obj/item/weapon/polearm/woodstaff/quarterstaff/steel
	name = "baston de acero"
	desc = "Una vista inusual, un baston de combate caballeresco hecho de acero trabajado y madera reforzada. Es un arma pesada y poderosa, mas que capaz de darle una paliza a cualquier bandido."
	icon_state = "quarterstaff_steel"
	force = DAMAGE_STAFF + 6
	force_wielded =  DAMAGE_STAFF_WIELD + 7
	gripped_intents = list(POLEARM_BASH, MACE_SMASH)
	max_integrity = INTEGRITY_STRONGEST
	minstr = 7
	item_weight = 1 KILOGRAMS
	smeltresult = null
	melting_material = /datum/material/steel
	melt_amount = 75

/obj/item/weapon/polearm/woodstaff/quarterstaff/silver
	name = "baston de plata"
	desc = "Un baston con refuerzos plateados, mas eficaz contra enemigos sobrenaturales que un baston de acero."
	icon_state = "quarterstaff_silver"
	force = DAMAGE_STAFF + 6
	force_wielded =  DAMAGE_STAFF_WIELD + 7
	gripped_intents = list(POLEARM_BASH, MACE_SMASH)
	max_integrity = INTEGRITY_STRONGEST * 0.8
	minstr = 7
	item_weight = 1 KILOGRAMS
	smeltresult = null
	melting_material = /datum/material/silver
	melt_amount = 75

/obj/item/weapon/polearm/woodstaff/quarterstaff/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/polearm/woodstaff/seer
	name = "baston de la vidente rous"
	desc = "Un baston utilizado por los videntes rousman, principalmente para protegerse."
	icon_state = "seerstaff"
	force_wielded =  DAMAGE_STAFF_WIELD + 3
	sellprice = 100
	item_weight = 1.2 KILOGRAMS

//................ Spear ............... //
/obj/item/weapon/polearm/spear
	name = "lanza"
	desc = "La humilde lanza, usa el extremo puntiagudo."
	icon_state = "spear"
	force = DAMAGE_SPEARPLUS
	force_wielded = DAMAGE_SPEAR_WIELD
	throwforce = DAMAGE_SPEAR
	wbalance = GOOD_PARRY
	possible_item_intents = list(SPEAR_THRUST, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEARM_THRUST, SPEAR_CUT, POLEARM_BASH)
	max_blade_int = 150

	slot_flags = ITEM_SLOT_BACK
	smeltresult = /obj/item/ingot/iron
	thrown_bclass = BCLASS_STAB
	sellprice = 22
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/spear/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


/obj/item/weapon/polearm/spear/steel
	name = "lanza de acero"
	desc = "Una lanza con cabeza de acero, mas duradera y eficaz que una simple lanza de hierro."
	icon_state = "spear_sk"
	force = DAMAGE_SPEARPLUS + 2
	force_wielded = DAMAGE_SPEAR_WIELD + 2
	wbalance = GREAT_PARRY
	max_integrity = INTEGRITY_STRONGEST
	max_blade_int = 200
	smeltresult = /obj/item/ingot/steel_slag
	sellprice = 40
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/spear/steel/partizan
	name = "partesana"
	desc = "Una lanza con una pesada cabeza de acero, diseñada para apuñalar y cortar."
	icon_state = "partizan"
	force = DAMAGE_SPEARPLUS + 3
	force_wielded = DAMAGE_SPEAR_WIELD + 5
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST * 1.25
	sellprice = 50

/obj/item/weapon/polearm/spear/silver
	name = "lanza de plata"
	desc = "Una lanza con punta plateada, mas eficaz contra enemigos sobrenaturales que una lanza de acero."
	icon_state = "silverspear"
	force = DAMAGE_SPEARPLUS
	force_wielded = DAMAGE_SPEAR_WIELD
	wbalance = GREAT_PARRY
	max_integrity = INTEGRITY_STRONGEST * 0.8
	max_blade_int = 200
	smeltresult = /obj/item/ingot/silver
	sellprice = 60
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/spear/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/polearm/spear/abyssor
	name = "buscador de profundidades"
	desc = "Un instrumento de la ira de Abyssor para castigar a los ignorantes."
	icon = 'icons/roguetown/weapons/64/patron.dmi'
	icon_state = "gsspear"
	force = DAMAGE_SPEARPLUS + 2
	force_wielded = DAMAGE_SPEAR_WIELD + 2
	throwforce = DAMAGE_SPEAR_WIELD
	max_blade_int = 200
	smeltresult = /obj/item/ingot/steel_slag
	item_weight = 1 KILOGRAMS

//................ Psydonian Spear ............... //
/obj/item/weapon/polearm/spear/psydon
	name = "Lanza psydonian"
	desc = "Un arma de asta con una cabeza de tridente giratoria perfecta para destrozar los cuerpos de los impuros."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "psyspear"
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	force = DAMAGE_SPEARPLUS + 2
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silver
	sellprice = 60
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/spear/psydon/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/polearm/spear/psydon/noblessing
	item_weight = 2.5 KILOGRAMS

//gives this spear the generic blessing the other Psydonic weapons get
/obj/item/weapon/polearm/spear/psydon/noblessing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/polearm/spear/psydon/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


//................ Billhook ............... //
/obj/item/weapon/polearm/spear/billhook
	name = "podadera"
	desc = "Un arma de asta con un krag curvo, un diseño Valorian para desmontar guerreros montados y derribar bestias monstruosas."
	icon_state = "billhook"
	wbalance = EASY_TO_DODGE
	possible_item_intents = list(POLEARM_THRUST, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEARM_THRUST, SPEAR_CUT, POLEARM_CHOP, POLEARM_BASH)
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	smeltresult = /obj/item/ingot/steel_slag
	sellprice = 60
	item_weight = 2 KILOGRAMS

/obj/item/weapon/polearm/spear/billhook/ji
	name = "hacha-daga de acero"
	desc = "Un arma de asta oriental de diseño antiguo. Rara vez se ve en el campo de batalla estos dias."
	icon_state = "ji_steel"
	gripsprite = FALSE
	item_weight = 2 KILOGRAMS

/obj/item/weapon/polearm/spear/billhook/ji/iron
	name = "hacha-daga de hierro"
	icon_state = "ji_iron"
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEAR_WIELD - 2
	max_integrity = INTEGRITY_STANDARD
	max_blade_int = 150
	smeltresult = /obj/item/ingot/iron
	item_weight = 2 KILOGRAMS

/obj/item/weapon/polearm/spear/billhook/ji/bronze
	name = "hacha-daga de bronce"
	icon_state = "ji_bronze"
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEAR_WIELD - 3
	wdefense = GOOD_PARRY
	max_integrity = INTEGRITY_POOR
	max_blade_int = 100
	smeltresult = /obj/item/ingot/bronze
	item_weight = 2 KILOGRAMS

//................ Stone Short Spear ............... //		- Short spears got shorter reach and worse wield effect, made for one handed and throwing
/obj/item/weapon/polearm/spear/stone
	name = "lanza simple"
	desc = "Una de las primeras armas empuñadas por la humanidad, todavia tan versatil como lo era entonces."
	icon_state = "stonespear"
	force = DAMAGE_SPEAR - 2
	force_wielded = DAMAGE_SPEAR + 2
	throwforce = DAMAGE_SPEAR
	wdefense = AVERAGE_PARRY
	wlength = WLENGTH_LONG
	max_blade_int = 50
	max_integrity = INTEGRITY_WORST

	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0
	sellprice = 5
	item_weight = 0.8 KILOGRAMS

//................ Javelin ............... //
/obj/item/weapon/polearm/spear/assegai
	name = "azagaya de hierro"
	desc = "Una lanza arrojadiza larga que se origina en el este."
	icon = 'icons/roguetown/weapons/64/polearms.dmi'
	icon_state = "assegai_iron"
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEARPLUS + 2
	throwforce = DAMAGE_SPEAR_WIELD
	wbalance = GOOD_PARRY
	wlength = WLENGTH_LONG

	gripsprite = FALSE
	throw_speed = 2
	embedding = list("embedded_pain_multiplier" = 3, "embed_chance" = 50, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/polearm/spear/assegai/steel
	name = "azagaya de acero"
	icon = 'icons/roguetown/weapons/64/polearms.dmi'
	icon_state = "assegai_steel"
	force = DAMAGE_SPEARPLUS
	force_wielded = DAMAGE_SPEAR_WIELD - 3
	wbalance = GREAT_PARRY
	max_blade_int = 200

	gripsprite = FALSE
	smeltresult = /obj/item/ingot/steel_slag
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/polearm/spear/javelin
	name = "jabalina de cobre"
	desc = "Hecho para lanzar, durante mucho tiempo en desuso y usando metales inferiores, aun puede matar cuando tu punteria es correcta."
	icon_state = "cspear"
	force = DAMAGE_SPEAR - 2
	force_wielded = DAMAGE_SPEAR + 2
	wdefense = AVERAGE_PARRY
	wlength = WLENGTH_LONG
	max_blade_int = 50
	max_integrity = INTEGRITY_WORST
	throwforce = DAMAGE_SPEAR_WIELD
	max_blade_int = 70
	max_integrity = INTEGRITY_POOR
	melting_material = /datum/material/copper
	melt_amount = 75
	sellprice = 15
	throw_speed = 3
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 50, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)
	item_weight = 900 GRAMS

/obj/item/weapon/polearm/spear/javelin/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/weapon/polearm/spear/javelin/iron
	name = "jabalina de hierro"
	desc = "Mas pesada que una jabalina de cobre, mas adecuada para cazar bestias."
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "ijavelin"
	gripsprite = FALSE
	force = DAMAGE_SPEAR - 1
	force_wielded = DAMAGE_SPEAR + 3
	melting_material = /datum/material/iron
	melt_amount = 75
	throwforce = DAMAGE_SPEAR_WIELD + 5
	max_blade_int = 80
	max_integrity = INTEGRITY_STANDARD
	throw_speed = 4
	embedding = list("embedded_pain_multiplier" = 5, "embed_chance" = 60, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)

/obj/item/weapon/polearm/spear/javelin/steel
	name = "jabalina de acero"
	desc = "Una jabalina resistente hecha de acero, adecuada para cazar enemigos caballerosos."
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "javelin"
	melting_material = /datum/material/steel
	melt_amount = 75
	throwforce = DAMAGE_SPEAR_WIELD + 10
	gripsprite = FALSE
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEAR + 3
	max_blade_int = 100
	max_integrity = INTEGRITY_STANDARD * 1.25
	throw_speed = 4
	embedding = list("embedded_pain_multiplier" = 5, "embed_chance" = 75, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)

/obj/item/weapon/polearm/spear/javelin/silver
	name = "jabalina de plata"
	desc = "Una jabalina resistente hecha de plata, adecuada para cazar enemigos sobrenaturales."
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "sjavelin"
	gripsprite = FALSE
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEAR + 3
	melting_material = /datum/material/silver
	melt_amount = 75
	throwforce = DAMAGE_SPEAR_WIELD + 8
	max_blade_int = 100
	max_integrity = INTEGRITY_STANDARD * 0.8
	throw_speed = 4
	embedding = list("embedded_pain_multiplier" = 5, "embed_chance" = 70, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)

/obj/item/weapon/polearm/spear/javelin/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/polearm/spear/bone
	name = "jabalina de hueso"
	desc = "Fabricada por las tribus de la naturaleza para la caza, esta lanza eventualmente matara a tu presa, si tu punteria sigue siendo cierta."
	icon_state = "bspear"
	throwforce = DAMAGE_SPEAR_WIELD
	max_blade_int = 60
	max_integrity = INTEGRITY_POOR
	anvilrepair = /datum/attribute/skill/craft/crafting
	sellprice = 5
	throw_speed = 4
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 50, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)
	item_weight = 900 GRAMS
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0

/obj/item/weapon/polearm/spear/bone/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/weapon/polearm/spear/trollbone
	name = "jabalina de hueso de cuerno de troll"
	desc = "Fabricada por las tribus salvajes para la caza y reforzada con un cuerno de troll, esta lanza durara mas que tu presa, si tu punteria sigue siendo fiel."
	icon_state = "bspear"
	throwforce = DAMAGE_SPEAR_WIELD
	max_blade_int = 60
	max_integrity = INTEGRITY_POOR
	anvilrepair = /datum/attribute/skill/craft/crafting
	sellprice = 5
	throw_speed = 4
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 50, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)
	item_weight = 900 GRAMS
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0

/obj/item/weapon/polearm/spear/trollbone/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


//................ Halberd ............... //
/obj/item/weapon/polearm/halberd
	name = "alabarda"
	desc = "Un arma de asta reforzada para golpear con una cabeza de hacha con cresta, pico y punta afilada, un brazo real para la defensa y la agresion."
	icon_state = "halberd"
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_HALBERD_WIELD
	wbalance = EASY_TO_DODGE
	slowdown = 1
	possible_item_intents = list(POLEARM_THRUST, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEARM_THRUST, SPEAR_CUT, POLEARM_CHOP, POLEARM_BASH)
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST

	slot_flags = ITEM_SLOT_BACK
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	sellprice = 90
	item_weight = 2.3 KILOGRAMS

/obj/item/weapon/polearm/halberd/silver
	name = "alabarda de plata"
	desc = "Una alabarda forjada en plata que derriba a las bestias de la noche."
	icon = 'icons/roguetown/weapons/64/axes.dmi'
	icon_state = "silverhalberd"
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_HALBERD_WIELD
	wbalance = EASY_TO_DODGE
	max_integrity = INTEGRITY_STRONGEST * 0.8
	max_blade_int = 300
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver
	melt_amount = 150
	sellprice = 120

/obj/item/weapon/polearm/halberd/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/polearm/halberd/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//................ Psydonian Halberd ............... //
/obj/item/weapon/polearm/halberd/psydon
	name = "Alabarda psydonian"
	desc = "Una poderosa alabarda capaz de derribar al hereje con notable facilidad, ya sea una efigie, un hombre o una bestia."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "psyhalberd"
	swingsound = BLADEWOOSH_MED
	axe_cut = 10
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silverblessed
	melting_material = /datum/material/silver
	melt_amount = 150
	sellprice = 100
	item_weight = 2.3 KILOGRAMS

/obj/item/weapon/polearm/halberd/psydon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/polearm/halberd/psydon/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/polearm/halberd/psydon/relic
	name = "\proper sanctum"
	desc = "Estas armas de asta con punta plateada son el baluarte del Ordo Venatari, tomando prestadas tecnicas del Ordo Benetarus. Durante los primeros asedios, los Ordos los utilizaron para mantener a raya los horrores durante cuarenta dias y noches. Siempre llega el momento de luchar, de dar el golpe verdadero."
	icon_state = "psyhalberd"
	item_weight = 3.5 KILOGRAMS

/obj/item/weapon/polearm/halberd/psydon/relic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, TRUE, 5, 100, 100, 1, TRUE)

//................ Bardiche ............... //
/obj/item/weapon/polearm/halberd/bardiche
	name = "bardiche"
	desc = "Una gran hacha de diseño norteño, famosa por cortar facilmente extremidades con una fuerza brutal."
	icon_state = "bardiche"
	force = DAMAGE_AXE
	force_wielded = DAMAGE_HEAVYAXE_WIELD
	wdefense = AVERAGE_PARRY
	wbalance = VERY_EASY_TO_DODGE
	possible_item_intents = list(AXE_CUT)
	gripped_intents = list(AXE_CUT, AXE_GRTCHOP, SPEAR_THRUST)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG

	swingsound = BLADEWOOSH_MED
	axe_cut = 10
	smeltresult = /obj/item/ingot/iron
	melting_material = /datum/material/iron
	melt_amount = 140
	sellprice = 30
	item_weight = 2.8 KILOGRAMS

//originally in the axes.dm file, moved here because they inherit from the bardiche
//................ Woodcutter Axe ............... //
/obj/item/weapon/polearm/halberd/bardiche/woodcutter
	name = "hacha de leñador"
	desc = "La herramienta, arma y fiel compañero de los leñadores. Capaz de talar arboles poderosos y repeler las amenazas del bosque."
	icon = 'icons/roguetown/weapons/64/axes.dmi'
	icon_state = "woodcutter"
	force = DAMAGE_AXE
	force_wielded = DAMAGE_HEAVYAXE_WIELD
	gripped_intents = list(AXE_CUT, AXE_GRTCHOP)

	bigboy = TRUE
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	associated_skill = /datum/attribute/skill/combat/axesmaces //It's ultimately a massive axe
	axe_cut = 15
	smeltresult = null
	melt_amount = 75
	sellprice = 20
	item_weight = 2 KILOGRAMS

	weapon_special = /datum/special_intent/axe_swing

/obj/item/weapon/woodchopper/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 4,"sflip" = 4,"wflip" = 1,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/steel
	name = "hacha de tala"
	desc = "Esto no es solo una herramienta, un arma o un compañero leal. Es un verdadero talador de madera, capaz de derribar a los arboles y a las bestias mas poderosas."
	icon_state = "swoodcutter"
	force = DAMAGE_AXE + 2
	wlength = WLENGTH_LONG
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST
	minstr = 9

	axe_cut = 15
	smeltresult = /obj/item/ingot/steel
	melting_material = /datum/material/steel
	melt_amount = 75
	sellprice = 50
	item_weight = 2.5 KILOGRAMS

	weapon_special = /datum/special_intent/axe_swing

//................ War Axe ............... //
//attempting to fix transformation issues//it worked wohoo, don't touch it.
/obj/item/weapon/polearm/halberd/bardiche/warcutter
	name = "hacha de guerra lacayo"
	desc = "Un enorme hacha con puas. La eleccion ideal para un miliciano que quiere reducir a su tamaño a un elegante y noble hijo de puta."
	icon = 'icons/roguetown/weapons/64/axes.dmi'
	icon_state = "warcutter"
	slot_flags = ITEM_SLOT_BACK
	force = DAMAGE_AXE
	force_wielded = DAMAGE_AXE_WIELD
	wdefense = GOOD_PARRY
	gripped_intents = list(AXE_CUT, AXE_GRTCHOP, AXE_THRUST, PICK_INTENT)

	bigboy = TRUE
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	associated_skill = /datum/attribute/skill/combat/axesmaces
	axe_cut = 15
	melt_amount = 150
	sellprice = 20
	item_weight = 2.3 KILOGRAMS

/obj/item/weapon/polearm/halberd/bardiche/warcutter/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -2,"ex" = 5,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/polearm/halberd/bardiche/ancient
	name = "bardiche"
	desc = "Una gran hacha de diseño norteño, famosa por cortar facilmente extremidades con una fuerza brutal."
	icon_state = "ancient_bardiche"

/obj/item/weapon/polearm/halberd/bardiche/dendor
	name = "guadaña de verano"
	desc = "El verdor del verano corre por la cabeza de esta guadaña. Tanto mas para sembrar."
	icon = 'icons/roguetown/weapons/64/patron.dmi'
	icon_state = "dendorscythe"
	gripped_intents = list(POLEARM_THRUST, SPEAR_CUT, POLEARM_CHOP, POLEARM_BASH)
	item_weight = 2.3 KILOGRAMS

/obj/item/weapon/polearm/halberd/bardiche/captain
	name = "\proper liberacion"
	desc = "Una guja decorada con oro forjado para el Capitan junto con su armadura. Para impartir justicia con cada gran movimiento."
	sellprice = 200
	icon_state = "capglaive"
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	item_weight = 2.3 KILOGRAMS

/obj/item/weapon/polearm/halberd/bardiche/glaive
	name = "guja de acero"
	desc = "Un arma de asta de diseño exclusivo, inspirada en Deliverance. Excelente para derribar a tus enemigos."
	icon_state = "glaive"
	force = DAMAGE_AXE + 2
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150

//................ Eagle Beak ............... //
/obj/item/weapon/polearm/eaglebeak
	name = "pico de aguila"
	desc = "Un poste reforzado al que se le ha fijado una ornamentada cabeza de aguila de acero, cuyo pico pretende perforar con gran daño."
	icon_state = "eaglebeak"
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_HALBERD_WIELD
	wdefense = GOOD_PARRY
	wbalance = EASY_TO_DODGE
	slowdown = 1
	possible_item_intents = list(POLEARM_BASH, POLEARM_CHOP) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEHAMMER_STRIKE, POLEARM_THRUST, MACE_HVYSMASH, DAZE_BASH)
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST

	slot_flags = ITEM_SLOT_BACK
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	sellprice = 60
	item_weight = 2 KILOGRAMS

	weapon_special = /datum/special_intent/ground_smash

/obj/item/weapon/polearm/eaglebeak/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -8,"sy" = 6,"nx" = 8,"ny" = 6,"wx" = -5,"wy" = 6,"ex" = 0,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -32,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -2,"ex" = 5,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//................ Lucerne Hammer ............... //
/obj/item/weapon/polearm/eaglebeak/lucerne
	name = "martillo de Lucerna"
	desc = "Un martillo de asta de hierro sencillo que quiebra huesos y disidencia con pura fuerza bruta."
	icon_state = "polehammer"
	force_wielded = DAMAGE_HALBERD_WIELD -3
	wbalance = VERY_EASY_TO_DODGE
	wdefense = AVERAGE_PARRY
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	melting_material = /datum/material/iron
	melt_amount = 150
	sellprice = 40
	item_weight = 2 KILOGRAMS

//................ Hoplite Spear ............... //
/obj/item/weapon/polearm/spear/hoplite
	name = "lanza antigua"
	desc = "Una humilde lanza con cabeza de bronce, un raro superviviente de las batallas del pasado que casi destruyeron Psydonia."
	icon_state = "bronzespear"
	max_blade_int = 200
	smeltresult = /obj/item/ingot/bronze
	sellprice = 120 // A noble collector would love to get his/her hands on one of these spears
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/spear/hoplite/winged // Winged version has +1 weapon defence and sells for a bit more, but is identical otherwise
	name = "lanza alada antigua"
	desc = "Una lanza con una cabeza de bronce alada, un raro superviviente de las batallas pasadas que casi destruyeron Psydonia."
	icon_state = "bronzespear_winged"
	sellprice = 150 // A noble collector would love to get his/her hands on one of these spears
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/spear/hoplite/abyssal
	name = "lanza abisal"
	desc = "Una lanza con un extremo dentado, inspirada en los dientes de una monstruosidad abisal."
	icon = 'icons/roguetown/weapons/64/ancient.dmi'
	icon_state = "ancient_spear"
	sellprice = 40
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/spear/bronze
	name = "lanza de bronce"
	desc = "Una lanza forjada en bronce. Caro pero mas duradero que uno de hierro normal."
	icon_state = "bronzespear"
	max_blade_int = 200
	smeltresult = /obj/item/ingot/bronze
	item_weight = 1 KILOGRAMS

//scythe
/obj/item/weapon/sickle/scythe //This is supposed to be bad
	name = "guadaña"
	desc = "Una humilde herramienta agricola de largo alcance, utilizada tradicionalmente para cortar pasto o trigo."
	icon = 'icons/roguetown/weapons/64/polearms.dmi'
	icon_state = "scythe"
	force = DAMAGE_STAFF
	force_wielded = DAMAGE_SPEARPLUS + 2
	throwforce = DAMAGE_SPEAR_WIELD
	wdefense = AVERAGE_PARRY
	wlength = WLENGTH_GREAT
	possible_item_intents = list(SPEAR_CUT) //truly just a long knife
	gripped_intents = list(SPEAR_CUT)
	max_blade_int = 150
	max_integrity = INTEGRITY_STRONG

	SET_BASE_PIXEL(-16, -16)
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	associated_skill = /datum/attribute/skill/combat/polearms
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	smeltresult = /obj/item/ingot/iron
	sellprice = 10
	item_weight = 1.1 KILOGRAMS

/obj/item/weapon/sickle/scythe/Initialize()
	. = ..()
	AddElement(/datum/element/walking_stick)

/obj/item/weapon/polearm/spear/bonespear
	name = "lanza de hueso"
	desc = "Una lanza hecha de huesos."
	// icon_state = "bonespear"
	icon_state = "stonespear_sk"
	force = DAMAGE_SPEARPLUS
	force_wielded = DAMAGE_SPEAR_WIELD - 3
	throwforce = DAMAGE_SPEARPLUS + 2
	anvilrepair = /datum/attribute/skill/craft/crafting
	max_blade_int = 75
	max_integrity = INTEGRITY_WORST * 0.8

	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = null
	melting_material = null
	melt_amount = 0
	item_weight = 0.9 KILOGRAMS

/obj/item/weapon/polearm/spear/trollbonespear
	name = "lanza de hueso de cuerno de troll"
	desc = "Una lanza hecha de huesos, reforzada con un cuerno de troll."
	// icon_state = "bonespear"
	icon_state = "stonespear_sk"
	force = DAMAGE_SPEARPLUS
	force_wielded = DAMAGE_SPEAR_WIELD - 3
	throwforce = DAMAGE_SPEARPLUS + 2
	anvilrepair = /datum/attribute/skill/craft/crafting
	max_blade_int = 125
	max_integrity = INTEGRITY_WORST * 0.8 + 50

	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = null
	melting_material = null
	melt_amount = 0

/obj/item/weapon/polearm/spear/naginata
	name = "naginata"
	desc = "Un arma de asta tradicional oriental que combina el alcance de una lanza con el poder cortante de una hoja curva. Debido a la calidad fragil de cierta cuchilleria oriental, los armeros han adaptado su hoja para que sea facilmente reemplazable cuando se rompe con una clavija en el extremo del eje."
	icon = 'icons/roguetown/weapons/64/polearms.dmi'
	icon_state = "naginata"
	force_wielded = DAMAGE_SPEAR_WIELD + 3
	throwforce = DAMAGE_SPEAR - 3
	possible_item_intents = list(NAGI_CUT, POLEARM_BASH) // no stab for you little chuddy, it's a slashing weapon
	gripped_intents = list(NAGI_REND, NAGI_CUT, POLEARM_BASH)
	max_blade_int = 100 //Nippon suteeru (dogshit)
	item_weight = 2 KILOGRAMS

/obj/item/weapon/polearm/spear/naginata/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 2,"nx" = 8,"ny" = 2,"wx" = -4,"wy" = 2,"ex" = 1,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 300,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 100,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/weapon/polearm/woodstaff/psydonian
	name = "Baston de guerra psydonian"
	desc = "Un baston que porta la insignia negra y dorada de los eruditos de la guerra."
	icon_state = "naledistaff"
	force = DAMAGE_SPEARPLUS
	force_wielded = DAMAGE_SPEAR_WIELD
	possible_item_intents = list(POLEARM_BASH)
	gripped_intents = list(POLEARM_BASH, MACE_WOODSMASH)
	max_integrity = INTEGRITY_STRONG
	item_weight = 1 KILOGRAMS

/obj/item/weapon/polearm/woodstaff/psydonian/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.8,"sx" = -9,"sy" = 5,"nx" = 9,"ny" = 5,"wx" = -4,"wy" = 4,"ex" = 4,"ey" = 4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.8,"sx" = 8,"sy" = 0,"nx" = -1,"ny" = 0,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
