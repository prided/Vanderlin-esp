/* FLAILS - Zero wdefense, can´t parry, best AP
==========================================================*/
/obj/item/weapon/flail
	name = "mayal de hierro"
	desc = "Un mango resistente sujeto a una cruel bola con puas con una desgarradora cadena de metal."
	icon_state = "iflail"
	icon = 'icons/roguetown/weapons/32/whips_flails.dmi'
	force = DAMAGE_NORMAL_FLAIL
	throwforce = DAMAGE_WEAK_FLAIL - 12
	can_parry = FALSE // You can't parry with this, it'd be awkward to tangle chains, use a shield
	wdefense = TERRIBLE_PARRY
	wlength = WLENGTH_NORMAL
	possible_item_intents = list(FLAIL_STRIKE, FLAIL_SMASH)
	max_integrity = INTEGRITY_STRONG

	sharpness = IS_BLUNT
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	associated_skill = /datum/attribute/skill/combat/whipsflails
	smeltresult = /obj/item/ingot/iron
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	swingsound = BLUNTWOOSH_MED
	sellprice = 20

	grid_width = 32
	grid_height = 96

	weapon_special = /datum/special_intent/flail_sweep
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/flail/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................ Militia Flail ............... //
/obj/item/weapon/flail/militia
	name = "mayal de la milicia"
	desc = "Un golpe afortunado de tal mayal puede aplastar un casco barato junto con el craneo de su portador."
	icon_state = "militiaflail"
	item_weight = 1.5 KILOGRAMS

//................ Wooden Flail ............... // Obsolete by the thresher? No smash so its bad
/obj/item/weapon/flail/towner
	name = "mayal de madera"
	desc = "En tiempos de paz estos mayales se utilizan para trillar el trigo. En tiempos de guerra, para ahuyentar a los merodeadores."
	icon_state = "peasantflail"
	force = DAMAGE_WEAK_FLAIL
	possible_item_intents = list(MACE_WDSTRIKE)
	gripped_intents = list(FLAIL_THRESH, MACE_WDSTRIKE)
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/fertilizer/ash
	sellprice = 10
	item_weight = 700 GRAMS


//................ Steel Flail ............... //
/obj/item/weapon/flail/sflail
	name = "mayal de acero"
	desc = "Mayal de caballero hecho de acero trabajado, con cabeza con bridas. Un diseño efectivo y brutal."
	icon_state = "flail"
	force = DAMAGE_GOOD_FLAIL
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = null
	smeltresult = /obj/item/ingot/steel_slag
	sellprice = 35
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/flail/sflail/ancient
	name = "mayal antiguo"
	desc = "Un antiguo mayal de caballero hecho de acero trabajado, con una cabeza con bridas. Un diseño efectivo y brutal."
	icon_state = "aflail"
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/flail/sflail/necraflail
	name = "viaje rapido"
	desc = "La cabeza que golpea se asemeja al craneo original de Necra, golpeando con precision con un emblema tallado de amor y sacrificio. Quizas uno de los pocos emblemas de los Diez diseñados por Psydonic."
	icon = 'icons/roguetown/weapons/32/patron.dmi'
	icon_state = "necraflail"
	item_weight = 1.4 KILOGRAMS

//................ Silver Flail ............... //
/obj/item/weapon/flail/silver
	name = "mayal de plata"
	desc = "Un mayal de plata brillante, azote de quienes acechan en la noche. Aplasta el craneo de Nitebeast."
	icon_state = "silverflail"
	force = DAMAGE_GOOD_FLAIL - 1
	max_integrity = INTEGRITY_STRONGEST * 0.8
	minstr = 4
	smeltresult = null
	smeltresult = /obj/item/ingot/silver
	sellprice = 90
	item_weight = 1 KILOGRAMS

/obj/item/weapon/flail/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/flail/silver/noc
	name = "mayal lunar"
	desc = "Un mayal plateado brillante, la pesadilla de todos los que acechan en la noche y montado con una luna creciente. Corta las nitebeasts."
	icon = 'icons/roguetown/weapons/32/patron.dmi'
	icon_state = "moonflail"
	sharpness = IS_SHARP
	max_blade_int = 160
	possible_item_intents = list(FLAIL_LNGSTRIKE, FLAIL_LNGSMASH, FLAIL_LNGCUT)
	wlength = WLENGTH_GREAT

//................ Psydon Flail ............... //
/obj/item/weapon/flail/psydon
	name = "mayal psydonian"
	desc = "Un mayal diseñado con la iconografia de Psydon y elaborado integramente en plata."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psyflail"
	force = DAMAGE_GOOD_FLAIL
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = /obj/item/ingot/silverblessed
	sellprice = 50
	last_used = 0
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/flail/psydon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/flail/psydon/relic
	name = "\proper consagraciones"
	desc = "El peso de Su angustia, Su dolor, Su esperanza y Su amor por la humanidad, todo colgando de esta cabeza ornamental de acero plateado encadenada a este brazo. Una declaracion de amor por todo aquello por lo que vive el Psydon y un recordatorio aplastante de que el Ordo Benetarus soportara cualquier cosa para defenderlo."
	icon_state = "psymorningstar"
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/flail/psydon/relic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, TRUE, 5, FALSE, 100, 1, TRUE)


//................ Peasant Flail ............... // A little confusing still
/obj/item/weapon/flail/peasant
	name = "mayal campesino"
	desc = "Lo que solia ser un humilde trillador por diseño, se ha convertido en un mayal mortal con alcance y golpe extendidos. Favorecido por la milicia campesina o los caballeros andantes."
	icon = 'icons/roguetown/weapons/64/flails.dmi'
	icon_state = "bigflail"
	force = DAMAGE_NORMAL_FLAIL
	force_wielded = DAMAGE_GOOD_FLAIL
	wbalance = DODGE_CHANCE_NORMAL
	wlength = WLENGTH_LONG
	possible_item_intents = list(FLAIL_LNGSTRIKE)
	gripped_intents = list(FLAIL_LNGSTRIKE, FLAIL_LNGSMASH)
	max_integrity = INTEGRITY_STRONG

	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	sellprice = 20
	item_weight = 2.5 KILOGRAMS

/obj/item/weapon/flail/peasant/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/weapon/flail/peasantwarflail //Unattainable
	name = "trilladora de la milicia"
	desc = "Asi como la bala de una honda puede derribar a un gigante, este gran latigo tambien sigue el principio de convertir el 'momento' en 'fuerza que rompe la placa'."
	icon = 'icons/roguetown/weapons/64/flails.dmi'
	icon_state = "peasantwarflail"
	force = DAMAGE_WEAK_FLAIL - 7
	force_wielded = DAMAGE_GOOD_FLAIL + 2
	wbalance = VERY_HARD_TO_DODGE
	wlength = WLENGTH_GREAT
	possible_item_intents = list(FLAIL_STRIKE)
	gripped_intents = list(FLAIL_LNGSTRIKE, FLAIL_LNGSMASH)
	smeltresult = /obj/item/fertilizer/ash
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	anvilrepair = /datum/attribute/skill/craft/carpentry
	resistance_flags = FLAMMABLE
	item_weight = 3.5 KILOGRAMS

/obj/item/weapon/flail/peasantwarflail/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


/obj/item/weapon/flail/peasantwarflail/matthios
	name = "\proper mayal dorado"
	desc = "El peso de la riqueza en un final mortal y sorprendente."
	icon = 'icons/roguetown/weapons/64/patron.dmi'
	icon_state = "matthiosflail"
	force_wielded = DAMAGE_GOOD_FLAIL + 7
	possible_item_intents = list(MATTHIOS_STRIKE)
	gripped_intents = list(MATTHIOS_STRIKE, MATTHIOS_SMASH)
	max_integrity = INTEGRITY_STRONGEST
	slot_flags = ITEM_SLOT_BACK
	anvilrepair = /datum/attribute/skill/craft/weapon_repair
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	sellprice = 250
	item_weight = 4 KILOGRAMS
