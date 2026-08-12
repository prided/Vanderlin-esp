/* AXES - Ok damage, kinda bad parry, ok AP for chops
==========================================================*/

/obj/item/weapon/axe
	icon = 'icons/roguetown/weapons/32/axes_picks.dmi'
	item_state = "axe"
	parrysound = "parrywood"
	force = DAMAGE_AXE
	force_wielded = DAMAGE_AXE_WIELD
	wdefense = AVERAGE_PARRY
	possible_item_intents = list(AXE_CUT, AXE_CHOP)
	gripped_intents = list(AXE_CUT, AXE_CHOP)
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	wlength = WLENGTH_NORMAL

	parrysound = "parrywood"
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/attribute/skill/combat/axesmaces
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	axe_cut = 10	// bonus damage to trees
	grid_height = 64
	grid_width = 32

	weapon_special = /datum/special_intent/axe_swing
	item_weight = 1.5 KILOGRAMS

//................ Stone Axe ............... //
/obj/item/weapon/axe/stone
	name = "hacha de piedra"
	desc = "Madera labrada, hilo firme, piedra labrada. Una receta para doblegar la naturaleza a tu voluntad."
	icon_state = "stoneaxe"
	force = DAMAGE_BAD_AXE
	force_wielded = DAMAGE_BAD_AXE_WIELD
	wdefense = BAD_PARRY
	wbalance = EASY_TO_DODGE
	possible_item_intents = list(AXE_CUT)
	gripped_intents = list(AXE_CHOP)
	wlength = WLENGTH_SHORT
	max_blade_int = 50
	max_integrity = INTEGRITY_WORST / 2

	smeltresult = /obj/item/fertilizer/ash //is a wooden log and a stone hammered in the top
	sellprice = 10
	item_weight = 800 GRAMS

/obj/item/weapon/axe/stone/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()


//................ Battle Axe ............... //
/obj/item/weapon/axe/battle
	name = "hacha de batalla"
	desc = "Un hacha magistralmente construida, con pesos adicionales en forma de puas ornamentadas y practicos bordes."
	icon_state = "battleaxe"
	force_wielded = DAMAGE_HEAVYAXE_WIELD
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST

	parrysound = "sword"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	sellprice = 60
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/axe/battle/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()


//................ Iron Axe ............... //
/obj/item/weapon/axe/iron
	name = "hacha de hierro"
	desc = "Herramienta, arma y fiel compañero de hierro."
	icon_state = "axe"
	wdefense = MEDIOCRE_PARRY
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG

	smeltresult = /obj/item/ingot/iron
	parrysound = "sword"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'

	sellprice = 20
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/axe/iron/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)

/obj/item/weapon/axe/iron/nsapo
	name = "kasuyu de hierro"
	desc = "Un hacha de hierro proveniente del este caido. Ideal para talar arboles y enemigos por igual."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "nsapo_iron"
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/axe/iron/nsapo/getonmobprop(tag)

	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)

/obj/item/weapon/axe/iron/troll
	name = "hacha divisoria"
	desc = "Un hacha de fabricacion tosca, que recuerda mas a una utilizada para partir troncos si esta hecha con tronco de arbol y una piedra brillante y afilada; lo cual te hace pensar, ¿para que le sirve un troll a la madera?"
	icon_state = "troll_axe"
	force = DAMAGE_AXE + 3
	force_wielded = DAMAGE_HEAVYAXE_WIELD
	wdefense = AVERAGE_PARRY
	max_blade_int = 150
	item_weight = 2.2 KILOGRAMS

//................ Bronze ............... //
/obj/item/weapon/axe/bronze
	name = "hacha de bronce"
	desc = "Herramienta, arma, leal compañera de bronce."
	icon_state = "axe_bronze"
	wdefense = MEDIOCRE_PARRY
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD

	smeltresult = /obj/item/ingot/bronze
	parrysound = "sword"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'

	sellprice = 20
	item_weight = 1.1 KILOGRAMS

/obj/item/weapon/axe/bronze/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)

//................ Psydonian Axe ............... //
/obj/item/weapon/axe/psydon
	name = "Hacha psydonian"
	desc = "Un hacha forjada en plata con un pequeño psycross adjunto, Dendor y sus repugnantes hombres bestia al diablo."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psyaxe"
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8

	resistance_flags = FIRE_PROOF //So the blessing doesn't fuck up
	smeltresult = /obj/item/ingot/silverblessed
	parrysound = "sword"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	sellprice = 60
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/axe/psydon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/axe/psydon/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)


//................ Pick Axe ............... //
// Pickaxe-axe ; Technically both a tool and weapon, but it goes here due to weapon function.
// Same stats as steel axe, but refactored for pickaxe quality purposes.
/obj/item/weapon/pick/paxe
	name = "piqueta"
	desc = "Una mezcla extraña de un frente de pico y una hoja de hacha en la parte posterior, que se pueden cambiar entre si."
	icon = 'icons/roguetown/weapons/32/axes_picks.dmi'
	icon_state = "paxe"
	force = DAMAGE_AXE
	force_wielded = DAMAGE_AXE_WIELD
	wdefense = AVERAGE_PARRY
	wlength = WLENGTH_NORMAL
	possible_item_intents = list(AXE_CUT, PICK_INTENT)
	gripped_intents = list(AXE_CUT, AXE_CHOP)
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST

	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	associated_skill = /datum/attribute/skill/combat/axesmaces
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 175
	sharpness = IS_SHARP
	resistance_flags = FIRE_PROOF
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	swingsound = BLADEWOOSH_MED
	sellprice = 50
	pickmult = 1.2 // It's a pick...
	axe_cut = 15 // ...and an Axe!
	toolspeed = 2
	item_weight = 2.5 KILOGRAMS


//................ Steel Axe ............... //
/obj/item/weapon/axe/steel
	name = "hacha de acero"
	desc = "Un hacha de acero barbuda venerada tanto por los enanos humen como por los elfos. Funciona mucho mejor que su homologo de hierro."
	icon_state = "saxe"
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = /obj/item/ingot/steel_slag
	resistance_flags = FIRE_PROOF
	sellprice = 35
	axe_cut = 15 // Better than iron
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/axe/steel/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)


//------------------ Silver Axe ---------------//
/obj/item/weapon/axe/silver
	name = "hacha de plata"
	desc = "Un hacha plateada, no tan fuerte como el acero pero mas eficaz contra enemigos sobrenaturales."
	icon_state = "silveraxe"
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONGEST * 0.8
	minstr = 6
	smeltresult = /obj/item/ingot/silver
	resistance_flags = FIRE_PROOF
	sellprice = 80
	axe_cut = 13
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/axe/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/axe/silver/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)



//.................. Bearded Axe ...............//
/obj/item/weapon/axe/steel/bearded
	name = "hacha barbuda"
	desc = "Un hacha grande que se puede manejar facilmente con una o dos manos, con una gran cabeza en forma de gancho para desgarrar carne y armaduras y arrancarlas brutalmente."
	icon_state = "atgervi_axe"
	item_state = "atgervi_axe"
	lefthand_file = 'icons/mob/inhands/weapons/rogue_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/rogue_righthand.dmi'
	wlength = WLENGTH_LONG
	experimental_onhip = TRUE
	item_weight = 2.2 KILOGRAMS

/obj/item/weapon/axe/steel/bearded/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.8,"sx" = 2,"sy" = -8,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.6,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 180,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/weapon/axe/steel/nsapo
	name = "kasuyu de acero"
	desc = "Un hacha de acero proveniente del este caido. Ideal para talar arboles y enemigos por igual."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "nsapo_steel"
	sellprice = 45
	item_weight = 1.9 KILOGRAMS

/obj/item/weapon/axe/steel/nsapo/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)


//................ Copper Hatchet ............... //
/obj/item/weapon/axe/copper
	name = "hacha de cobre"
	desc = "Un hacha de mano de diseño simple, un arma obsoleta de tiempos mas simples."
	icon_state = "chatchet"
	force = DAMAGE_BAD_AXE
	force_wielded = DAMAGE_BAD_AXE_WIELD
	throwforce = DAMAGE_BAD_AXE_WIELD
	wlength = WLENGTH_SHORT
	wdefense = AVERAGE_PARRY
	max_blade_int = 100
	max_integrity = INTEGRITY_POOR
	smeltresult = /obj/item/ingot/copper
	melting_material = /datum/material/copper
	melt_amount = 150
	pickup_sound = 'sound/foley/equip/rummaging-03.ogg'
	sellprice = 15
	item_weight = 700 GRAMS

/obj/item/weapon/axe/copper/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)

//................ Bone Axe ............... //
/obj/item/weapon/axe/boneaxe
	name = "hacha de hueso"
	desc = "Un hacha tosca hecha de huesos."
	icon_state = "boneaxe"
	force = DAMAGE_BAD_AXE
	force_wielded =	DAMAGE_BAD_AXE_WIELD
	wdefense = MEDIOCRE_PARRY
	wlength = WLENGTH_SHORT
	anvilrepair = /datum/attribute/skill/craft/crafting
	max_blade_int = 100
	max_integrity = INTEGRITY_WORST
	smeltresult = /obj/item/fertilizer/ash
	pickup_sound = 'sound/foley/equip/rummaging-03.ogg'
	item_weight = 900 GRAMS

/obj/item/weapon/axe/boneaxe/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = -7,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

/obj/item/weapon/axe/trollboneaxe
	name = "hacha de hueso de cuerno de troll"
	desc = "Un hacha tosca hecha de huesos, reforzada con un cuerno de troll."
	icon_state = "boneaxe"
	force = DAMAGE_BAD_AXE
	force_wielded =	DAMAGE_BAD_AXE_WIELD
	wdefense = MEDIOCRE_PARRY
	wlength = WLENGTH_SHORT
	anvilrepair = /datum/attribute/skill/craft/crafting
	max_blade_int = 150
	max_integrity = INTEGRITY_WORST + 50
	smeltresult = /obj/item/fertilizer/ash
	pickup_sound = 'sound/foley/equip/rummaging-03.ogg'
	item_weight = 900 GRAMS

/obj/item/weapon/axe/trollboneaxe/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = -7,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

//................ Great Axe ............... //
/obj/item/weapon/greataxe
	name = "gran hacha"
	desc = "Una gran hacha de hierro, un hacha de mango largo con una sola hoja hecha para arruinarle el dia a alguien sin medida."
	icon = 'icons/roguetown/weapons/64/axes.dmi'
	icon_state = "igreataxe"
	force = DAMAGE_AXE
	force_wielded = DAMAGE_HEAVYAXE_WIELD - 2
	wdefense = AVERAGE_PARRY
	wbalance = EASY_TO_DODGE
	wlength = WLENGTH_GREAT
	slowdown = 1
	possible_item_intents = list(AXE_CUT, AXE_CHOP, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(GREATAXE_CUT, GREATAXE_CHOP,  POLEARM_BASH)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG

	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	anvilrepair = /datum/attribute/skill/craft/weapon_repair
	associated_skill = /datum/attribute/skill/combat/axesmaces
	slot_flags = ITEM_SLOT_BACK
	smeltresult = /obj/item/ingot/iron
	melting_material = /datum/material/iron
	melt_amount = 150
	sellprice = 60
	grid_height = 96
	grid_width = 64

	weapon_special = /datum/special_intent/axe_swing
	item_weight = 4 KILOGRAMS

/obj/item/weapon/greataxe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/weapon/greataxe/psy
	name = "Hacha de asta psydonic"
	desc = "Un hacha de asta, provista de un eje reforzado y una cabeza picuda de aleacion de plata. A medida que la fragilidad de las espadas se ha vuelto mas evidente, las Ordenes Psydonic han cambiado su enfoque hacia armar a sus paladines con grandes armas mas duraderas."
	icon = 'icons/roguetown/weapons/64/axes.dmi'
	icon_state = "silverpolearm"
	possible_item_intents = list(AXE_CUT, AXE_CHOP, MACE_STRIKE) //When possible, add the longsword's 'alternate grip' mechanic to let people flip this around into a Mace-scaling weapon with swapped damage.
	gripped_intents = list(GREATAXE_CUT, GREATAXE_CHOP, MACE_STRIKE) //Axe-equivalent to the Godendag or Grand Mace.
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silverblessed
	item_weight = 3.8 KILOGRAMS

/obj/item/weapon/greataxe/psy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/greataxe/steel
	name = "gran hacha de acero"
	desc = "Una gran hacha de acero, un hacha de mango largo con una sola hoja hecha para arruinarle el dia a alguien sin medida alguna."
	icon_state = "sgreataxe"
	force_wielded = DAMAGE_HEAVYAXE_WIELD
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	sellprice = 90
	item_weight = 4.5 KILOGRAMS

/obj/item/weapon/greataxe/steel/doublehead // Trades more damage for being worse to parry with and easier to dodge of.
	name = "gran hacha de acero de doble cabeza"
	desc = "Una gran hacha de acero con una perversa cabeza de doble hoja. Perfecto para cortar hombres o arboles en tocones."
	icon_state = "doublegreataxe"
	wbalance = VERY_EASY_TO_DODGE
	possible_item_intents = list(AXE_CUT, AXE_CHOP, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(DBLGREATAXE_CUT, DBLGREATAXE_CHOP, POLEARM_BASH)
	max_blade_int = 400
	minstr = 12
	melt_amount = 180
	sellprice = 100
	item_weight = 5.5 KILOGRAMS

/obj/item/weapon/greataxe/steel/slayer
	name = "hacha matadragones"
	desc = "Una poderosa hacha hecha de metal pesado y duradero. La cabeza por si sola es tan grande como un hombre y se utiliza para cortar cabezas tanto de bestias como de hombres."
	icon_state = "oath"
	wbalance = EASY_TO_DODGE
	possible_item_intents = list(AXE_CUT, AXE_CHOP, POLEARM_BASH)
	gripped_intents = list(DBLGREATAXE_CUT, DBLGREATAXE_CHOP, POLEARM_BASH, GREATAXE_CLEAVE)
	max_blade_int = 400
	minstr = 13
	max_integrity = INTEGRITY_STRONGEST * 1.25
	item_weight = 12 KILOGRAMS

/obj/item/weapon/greataxe/steel/doublehead/graggar
	name = "vicious greataxe"
	desc = "Un gran hacha cuyo filo vibra con la fuerza motriz, violencia, ¡oh, dulce violencia!"
	icon = 'icons/roguetown/weapons/64/patron.dmi'
	icon_state = "graggargaxe"
	alt_intents = list(AXE_CUT, AXE_CHOP)
	sellprice = 0 // Graggarite axe, nobody wants this
	item_weight = 2 KILOGRAMS

/obj/item/weapon/greataxe/dreamscape
	name = "hacha de otro mundo"
	desc = "Un hacha extraña, quien sabe de donde vino. Se siente frio e inusualmente pesado."
	icon_state = "dreamaxe"
	force = DAMAGE_AXE - 10
	force_wielded = DAMAGE_HEAVYAXE_WIELD + 5
	wdefense = ULTMATE_PARRY
	max_blade_int = 250
	minstr = 13
	smeltresult = /obj/item/ingot/gold
	sellprice = 0
	item_weight = 5 KILOGRAMS

/obj/item/weapon/greataxe/dreamscape/active
	// to do, make this burn you if you don't regularly soak it.
	desc = "Un hacha extraña, quien sabe de donde vino. La hoja esta abrasadora y apenas se puede sujetar la empuñadura."
	icon_state = "dreamaxeactive"
	force = DAMAGE_AXE - 5
	force_wielded = DAMAGE_HEAVYAXE_WIELD + 10
	wdefense = ULTMATE_PARRY + 1
	max_blade_int = 500
	sellprice = 0

