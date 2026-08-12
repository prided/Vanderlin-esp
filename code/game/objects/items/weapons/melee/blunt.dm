/* BLUNT - low-ish damage, limited defense, good AP
==========================================================*/
//................ Mace ............... //
/obj/item/weapon/mace
	name = "maza de hierro"
	desc = "Una maza de hierro pesada, preferida por aquellos que guardan rencor contra los hijos de puta de los caballeros."
	icon_state = "mace"
	icon = 'icons/roguetown/weapons/32/clubs.dmi'
	force = DAMAGE_MACE
	force_wielded = DAMAGE_MACE_WIELD
	wdefense = AVERAGE_PARRY
	wbalance = EASY_TO_DODGE
	wlength = WLENGTH_NORMAL
	possible_item_intents = list(MACE_STRIKE, DAZE_BASH)
	gripped_intents = list(MACE_STRIKE, MACE_SMASH, DAZE_BASH)
	max_integrity = INTEGRITY_STRONG

	item_state = "mace_greyscale"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	equip_sound = "rustle"
	sharpness = IS_BLUNT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP
	associated_skill = /datum/attribute/skill/combat/axesmaces
	smeltresult = /obj/item/ingot/iron
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED
	sellprice = 20

	grid_height = 64
	grid_width = 32
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/mace/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.5,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -6,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()

/obj/item/weapon/mace/rungu
	name = "rungu de hierro"
	desc = "Un hierro del este caido. Posee la cabeza alisada."
	icon_state = "rungu_iron"
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/mace/rungu/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.5,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -6,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()

/obj/item/weapon/mace/shishpar
	name = "shishpar de hierro"
	desc = "Una pesada maza extranjera con mango en forma de espada. Su peso hace que sea un poco dificil de manejar, pero es capaz de asestar golpes devastadores."
	icon_state = "shishpar_iron"
	force = DAMAGE_MACE + 1
	force_wielded = DAMAGE_MACE_WIELD + 2
	smeltresult = /obj/item/ingot/iron
	melt_amount = 150
	sellprice = 35
	item_weight = 1.8 KILOGRAMS

//................  Canes, my beloved. ............... //

/obj/item/weapon/mace/cane
	name = "baston de madera"
	desc = "Un simple baston de madera, tallado en madera. Bueno para soportar tu peso."
	icon = 'icons/roguetown/weapons/32/canes.dmi'
	icon_state = "simple_cane"
	force = DAMAGE_MACE - 4
	force_wielded = DAMAGE_MACE - 2
	wdefense = MEDIOCRE_PARRY
	sellprice = 5
	item_weight = 400 GRAMS
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0

/obj/item/weapon/mace/cane/noble
	name = "baston elegante"
	desc = "Un baston de madera oscura pulida, decorado con oro y plata. A menudo lo lleva la nobleza, incluso aquellos que no cojean, simplemente para hacer alarde de su riqueza ante el campesinado."
	icon_state = "noble_cane"
	force = DAMAGE_MACE - 3
	force_wielded = DAMAGE_MACE - 1
	sellprice = 200
	item_weight = 500 GRAMS

/obj/item/weapon/mace/cane/courtphysician
	name = "baston de medico"
	desc = "Un baston preciado. Adornado con una serpiente dorada, que representa la universidad Kingsfield. El extremo puntiagudo es bastante afilado."
	icon_state = "physician_cane"
	force = DAMAGE_MACE - 3
	force_wielded = DAMAGE_MACE - 1
	possible_item_intents = list(MACE_STRIKE, SWORD_THRUST)
	sellprice = 30
	item_weight = 450 GRAMS

/obj/item/weapon/mace/cane/merchant
	name = "baston de comerciante"
	desc = "Un baston caro, decorado con oro y con incrustaciones de una gema. Un simbolo de gran riqueza para el propietario."
	icon_state = "merchant_cane"
	sellprice = 300
	item_weight = 500 GRAMS

/obj/item/weapon/mace/cane/natural
	name = "baston de madera natural"
	desc = "Un baston primitivo, toscamente tallado en una gruesa rama de arbol. Todavia tiene una hoja."
	icon_state = "natural_cane"
	force = DAMAGE_MACE - 5
	force_wielded = DAMAGE_MACE - 3
	sellprice = 3
	item_weight = 350 GRAMS

/obj/item/weapon/mace/cane/bronze
	name = "baston de bronce"
	desc = "Baston fabricado en bronce y cobre. La luz en la parte superior esta completamente contenida en el interior y no tiene ningun proposito funcional."
	icon_state = "artificer_cane"
	force = DAMAGE_MACE - 3
	force_wielded = DAMAGE_MACE - 1
	sellprice = 35
	item_weight = 600 GRAMS
	smeltresult = /obj/item/ingot/bronze

/obj/item/weapon/mace/cane/necran
	name = "varilla de necrano"
	desc = "Tallado en piedra oscura, grabado en oro. A menudo lo llevan Necrans ancianos."
	icon_state = "necran_cane"
	force = DAMAGE_MACE - 3
	force_wielded = DAMAGE_MACE - 1
	sellprice = 40
	item_weight = 550 GRAMS

/obj/item/weapon/mace/cane/Initialize()
	. = ..()
	AddElement(/datum/element/walking_stick)

/obj/item/weapon/mace/cane/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.5,
					"sx" = -6,
					"sy" = -6,
					"nx" = 6,
					"ny" = -5,
					"wx" = -1,
					"wy" = -5,
					"ex" = -1,
					"ey" = -5,
					"nturn" = -45,
					"sturn" = -45,
					"wturn" = -45,
					"eturn" = -45,
					"nflip" = 0,
					"sflip" = 0,
					"wflip" = 0,
					"eflip" = 0,
					"northabove" = FALSE,
					"southabove" = TRUE,
					"eastabove" = TRUE,
					"westabove" = FALSE
				)
			if("wielded")
				return list(
					"shrink" = 0.5,
					"sx" = 0,
					"sy" = 0,
					"nx" = 0,
					"ny" = 0,
					"wx" = -3,
					"wy" = 0,
					"ex" = 3,
					"ey" = 0,
					"nturn" = -90,
					"sturn" = 0,
					"wturn" = -90,
					"eturn" = 0,
					"nflip" = 0,
					"sflip" = 0,
					"wflip" = 0,
					"eflip" = 0,
					"northabove" = FALSE,
					"southabove" = TRUE,
					"eastabove" = TRUE,
					"westabove" = TRUE
				)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................ Bell ringer ............... //
/obj/item/weapon/mace/church
	name = "campanero"
	desc = "A veces la fe se administra mejor con acero y sangre."
	icon_state = "churchmace"
	force = DAMAGE_MACE + 3
	force_wielded = DAMAGE_MACE_WIELD + 3
	wdefense = GOOD_PARRY
	smeltresult = /obj/item/ingot/steel_slag
	sellprice = 100
	item_weight = 1.8 KILOGRAMS

//................ Steel mace ............... //	Better wbalance and wdefense
/obj/item/weapon/mace/steel
	name = "maza de acero"
	desc = "Una maza bien elaborada con cabeza de acero. Mas facil de controlar y golpea con la misma fuerza."
	icon_state = "smace"
	force = DAMAGE_MACE + 2
	force_wielded = DAMAGE_MACE_WIELD
	wdefense = GOOD_PARRY
	wbalance = DODGE_CHANCE_NORMAL
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	sellprice = 60
	item_weight = 1.6 KILOGRAMS

/obj/item/weapon/mace/steel/rungu
	name = "rungu de acero"
	desc = "Una maza de acero del este caido. Posee la cabeza alisada."
	icon_state = "rungu_steel"
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	wdefense = AVERAGE_PARRY //Due to costing less bars
	max_integrity = INTEGRITY_STRONGEST * 0.75
	melt_amount = 100
	sellprice = 30
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/mace/steel/shishpar //More damage, but less versatile with bonuses
	name = "shishpar de acero"
	desc = "Una pesada maza extranjera con mango en forma de espada. Su peso hace que sea un poco dificil de manejar, pero es capaz de asestar golpes devastadores."
	icon_state = "shishpar_steel"
	force_wielded = DAMAGE_MACE_WIELD + 3
	wdefense = AVERAGE_PARRY
	wbalance = EASY_TO_DODGE
	sellprice = 75
	item_weight = 1.9 KILOGRAMS

//................ Spiked club ............... //
/obj/item/weapon/mace/spiked
	name = "maza con puas"
	icon_state = "spikedmace"
	force = DAMAGE_MACE + 1
	force_wielded = DAMAGE_MACE_WIELD + 1
	max_integrity = INTEGRITY_STANDARD
	melt_amount = 150
	item_weight = 1.7 KILOGRAMS

//................ Morningstar ............... //
/obj/item/weapon/mace/steel/morningstar
	name = "estrella de la mañana"
	icon_state = "spiked_club_old"
	force = DAMAGE_MACE + 2
	force_wielded = DAMAGE_MACE_WIELD + 3
	max_integrity = INTEGRITY_STRONG
	item_weight = 1.8 KILOGRAMS


//................ Iron Bludgeon ............... // Less damage, more accurate, similar to a cudgel
/obj/item/weapon/mace/bludgeon
	name = "garrote de hierro"
	desc = "Un garrote con cabeza de hierro, util para devolver la escoria a sus alcantarillas."
	icon_state = "ibludgeon"
	force = DAMAGE_CLUB + 3
	force_wielded = DAMAGE_CLUB_WIELD + 2
	wbalance = VERY_HARD_TO_DODGE
	wlength = WLENGTH_SHORT
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/mace/bludgeon/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -11,"sy" = -8,"nx" = 10,"ny" = -6,"wx" = -1,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 91,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -11,"sy" = 2,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -5,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = -15,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)


//................ Copper bludgeon ............... //
/obj/item/weapon/mace/bludgeon/copper
	name = "garrote de cobre"
	desc = "Un arma extremadamente tosca para bastardos mas toscos."
	icon_state = "cbludgeon"
	force = DAMAGE_CLUB + 1
	force_wielded = DAMAGE_CLUB_WIELD + 1
	wdefense = MEDIOCRE_PARRY
	max_integrity = INTEGRITY_POOR
	smeltresult = /obj/item/ingot/copper
	sellprice = 10
	item_weight = 900 GRAMS


//................ Club ............... //
/obj/item/weapon/mace/woodclub
	name = "garrote"
	desc = "Un arma mas antigua que el tiempo registrado."
	icon_state = "club1"
	force = DAMAGE_CLUB
	force_wielded = DAMAGE_CLUB_WIELD
	wdefense = MEDIOCRE_PARRY
	possible_item_intents = list(MACE_WDSTRIKE)
	gripped_intents = list(MACE_WDSTRIKE, MACE_WOODSMASH)
	max_integrity = INTEGRITY_WORST

	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0
	sellprice = 5
	item_weight = 700 GRAMS

/obj/item/weapon/mace/woodclub/Initialize(mapload)
	. = ..()
	if(icon_state == "club1")
		icon_state = "club[rand(1,2)]"


//................ Cudgel ............... //
/obj/item/weapon/mace/cudgel
	name = "garrote"
	icon_state = "cudgel"
	desc = "Un pequeño club rechoncho preferido por ladrones y campesinos habladores."
	force = DAMAGE_CLUB
	force_wielded = DAMAGE_CLUB_WIELD
	wdefense = MEDIOCRE_PARRY
	wbalance = HARD_TO_DODGE
	wlength = WLENGTH_SHORT
	max_integrity = INTEGRITY_STANDARD

	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0
	w_class = WEIGHT_CLASS_NORMAL
	sellprice = 15
	item_weight = 500 GRAMS

/obj/item/weapon/mace/cudgel/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -8,"sy" = -7,"nx" = 10,"ny" = -7,"wx" = -1,"wy" = -8,"ex" = 1,"ey" = -7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 91,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -3,"sy" = -4,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 70,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)

/obj/item/weapon/mace/cudgel/psy
	name = "Maza de mano psydonian"
	desc = "Una maza escasa, una comoda ayuda para dormir o un medio para erradicar la herejia. Esta todo en la muñeca."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psyflangedmace"
	wdefense = AVERAGE_PARRY
	max_integrity = INTEGRITY_STRONGEST * 0.8
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silverblessed
	item_weight = 600 GRAMS

/obj/item/weapon/mace/cudgel/psy/Initialize(mapload)
	. = ..()
	// +3 force, +100 blade int, +50 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, FALSE, 3, 100, 50, 1, TRUE)

/obj/item/weapon/mace/cudgel/shellrungu
	name = "rungu de concha"
	desc = "Un rungu ceremonial tallado en una concha de almeja. No esta destinado al combate. Se utiliza en varios rituales y ceremonias elficas costeras y marinas."
	icon = 'icons/roguetown/gems/gem_shell.dmi'
	icon_state = "rungu_shell"
	max_integrity = INTEGRITY_POOR
	sellprice = 35
	item_weight = 300 GRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

//................ Alt cudgel ............... //
/obj/item/weapon/mace/cudgel/carpenter
	name = "garrote campesino"
	icon_state = "carpentercudgel"
	desc = "Un garrote rechoncho reforzado con piezas de hierro, popular entre los vigilantes de las aldeas y las milicias campesinas. A pesar de estar reforzado y ser contundente, todavia no se puede comparar con una maza adecuada."
	item_weight = 600 GRAMS
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0

//................ Wooden sword ............... //
/obj/item/weapon/mace/woodclub/train_sword
	name = "espada de madera"
	desc = "Madera tosca ensamblada en forma de espada, un arma terrible de la que estar en el lado receptor durante una disputa de entrenamiento."
	icon = 'icons/roguetown/weapons/32/swords.dmi'
	icon_state = "wsword"
	force = DAMAGE_CLUB - 10
	force_wielded = DAMAGE_CLUB - 7
	wdefense = ULTMATE_PARRY
	wbalance = DODGE_CHANCE_NORMAL
	max_integrity = INTEGRITY_STANDARD
	associated_skill = /datum/attribute/skill/combat/swords
	metalizer_result = /obj/item/weapon/sword/iron
	item_weight = 400 GRAMS
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0

/obj/item/weapon/mace/woodclub/train_sword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................ Goedendag ............... //
/obj/item/weapon/mace/goden
	name = "club de guerra"
	desc = "Un garrote de dos manos, decorado con una corona con puntas. Una manera perfecta de decir buenos dias a cualquiera seria noble caballero."
	icon = 'icons/roguetown/weapons/64/maces.dmi'
	icon_state = "goedendag"
	force = DAMAGE_CLUB
	force_wielded = DAMAGE_HEAVYCLUB_WIELD
	wdefense = GOOD_PARRY
	wbalance = EASY_TO_DODGE
	wlength = WLENGTH_LONG
	possible_item_intents = list(MACE_HVYSTRIKE)
	gripped_intents = list(MACE_HVYSMASH, MACE_THRUST)
	sharpness = IS_SHARP
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONG

	SET_BASE_PIXEL(-16, -16)
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	parrysound = "parrywood"
	sellprice = 35

	weapon_special = /datum/special_intent/ground_smash
	item_weight = 3 KILOGRAMS

/obj/item/weapon/mace/goden/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/mace/goden/deepduke //Boss loot
	name = "baston del duque profundo"
	desc = "Un baston hecho de vidrio marino y metal resistente pero inusual, que no tiene poder despues de la muerte de su dueño engañado. Mas util como herramienta de ataque que como foco magico."
	icon = 'icons/roguetown/mob/monster/pufferboss.dmi'
	icon_state = "pufferprod"
	force = DAMAGE_MACE - 5
	force_wielded = DAMAGE_HEAVYCLUB_WIELD + 5
	gripped_intents = list(MACE_HVYSMASH, MACE_HVYSTRIKE)
	max_integrity = INTEGRITY_STRONGEST * 1.2
	item_weight = 2.5 KILOGRAMS

//................ Grand mace ............... //
/obj/item/weapon/mace/goden/steel
	name = "gran maza"
	desc = "Un arma de asta fundida, que se rumorea que es el diseño de arma utilizado por el propio Psydon."
	icon_state = "polemace"
	gripped_intents = list(MACE_HVYSMASH) // It's a 2h flanged mace, not a goedendag.
	wbalance = DODGE_CHANCE_NORMAL
	sharpness = IS_BLUNT
	max_integrity = INTEGRITY_STRONGEST

	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/steel_slag
	sellprice = 60
	item_weight = 3.5 KILOGRAMS

/obj/item/weapon/mace/goden/steel/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -8,"sy" = 6,"nx" = 8,"ny" = 6,"wx" = -5,"wy" = 6,"ex" = 0,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -32,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -2,"ex" = 5,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -24,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)

//................ Psydonian Grand Mace ............... //
/obj/item/weapon/mace/goden/psydon
	name = "psydonian gran maza"
	desc = "Una poderosa maza que parece ser un gran psycross con mango, aunque no menos efectiva para aplastar el espiritu y los huesos del inhumen."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "psymace"
	wbalance = DODGE_CHANCE_NORMAL
	max_integrity = INTEGRITY_STRONGEST * 0.8

	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silverblessed
	melting_material = /datum/material/silver
	melt_amount = 150
	sellprice = 100
	item_weight = 3.8 KILOGRAMS

/obj/item/weapon/mace/goden/psydon/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/mace/goden/psydon/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -8,"sy" = 6,"nx" = 8,"ny" = 6,"wx" = -5,"wy" = 6,"ex" = 0,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -32,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -2,"ex" = 5,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -24,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)


//................ Shillelagh ............... //
/obj/item/weapon/mace/goden/shillelagh		// The Briar signature weapon. Sturdy oak war club.
	name = "shillelagh"
	desc = "Gran y vieja rama de roble, tallada en forma de arma mortal."
	icon = 'icons/roguetown/weapons/32/clubs.dmi'
	icon_state = "shillelagh"
	gripped_intents = list(MACE_WOODSMASH)
	max_integrity = INTEGRITY_STANDARD

	SET_BASE_PIXEL(0, 0)
	bigboy = FALSE
	gripsprite = TRUE
	slot_flags = ITEM_SLOT_BACK
	sellprice = 5
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/mace/goden/shillelagh/Initialize()
	. = ..()
	AddElement(/datum/element/walking_stick)

/obj/item/weapon/mace/goden/shillelagh/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -10,"sy" = 0,"nx" = 11,"ny" = 0,"wx" = -5,"wy" = -1,"ex" = 6,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -15,"sturn" = 12,"wturn" = 0,"eturn" = 354,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 6,"sy" = -6,"nx" = -5,"ny" = -6,"wx" = 2,"wy" = -6,"ex" = 6,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 20,"eturn" = -20,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.7,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 2,"wy" = -5,"ex" = 8,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................ Dwarf Warhammer ............... // - Unique Langobardo weapon
/obj/item/weapon/mace/goden/steel/warhammer
	name = "martillo de guerra enano"
	desc = "Un gran martillo de guerra enano hecho de acero severo, grabado con juramentos de batalla y tiempo."
	icon_state = "warhammer"
	wlength = WLENGTH_GREAT
	swingsound = BLUNTWOOSH_HUGE
	item_weight = 4 KILOGRAMS

/obj/item/weapon/mace/goden/steel/warhammer/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................ Copper goden ............... //
/obj/item/weapon/mace/goden/copper
	name = "garrote de guerra de cobre"
	desc = "Un garrote de dos manos, decorado con una corona de puas. Un diseño barbaro, lo suficientemente bueno como para usarlo como arma."
	icon_state = "cwarclub"
	force = DAMAGE_CLUB - 5
	force_wielded = DAMAGE_CLUB_WIELD
	slowdown = 1
	max_integrity = INTEGRITY_POOR

	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	smeltresult = /obj/item/ingot/copper
	parrysound = "parrywood"
	sellprice = 35
	item_weight = 2.5 KILOGRAMS

//................ Warhammers ............... //
/obj/item/weapon/mace/warhammer
	name = "martillo de guerra de hierro"
	desc = "Hecho para perforar armaduras y craneos por igual."
	icon_state = "iwarhammer"
	possible_item_intents = list(MACE_STRIKE, MACE_SMASH, WARHM_IMPALE)
	gripped_intents = null
	force_wielded = null
	item_weight = 2 KILOGRAMS

/obj/item/weapon/mace/warhammer/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.55,"sx" = 3,"sy" = -3,"nx" = -3,"ny" = -3,"wx" = 0,"wy" = -4,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = -44,"sturn" = 45,"wturn" = 60,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

/obj/item/weapon/mace/warhammer/steel
	name = "martillo de guerra de acero"
	desc = "Un fino martillo de guerra de acero que produce un sonido satisfactorio cuando se combina con un yelmo de caballero."
	icon_state = "swarhammer"
	force = DAMAGE_MACE_WIELD
	wdefense = GOOD_PARRY
	possible_item_intents = list(MACE_STRIKE, MACE_SMASH, WARHM_IMPALE, WARHM_THRUST)
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	item_weight = 2.2 KILOGRAMS

/obj/item/weapon/mace/warhammer/silver
	name = "martillo de guerra de plata"
	desc = "Un martillo de guerra plateado, diseñado para luchar contra los creadores nocturnos. Produce un sonido satisfactorio cuando se combina con el craneo de un esqueleto."
	icon_state = "silverhammer"
	force = DAMAGE_MACE_WIELD
	wdefense = GOOD_PARRY
	possible_item_intents = list(MACE_STRIKE, MACE_SMASH, WARHM_IMPALE, WARHM_THRUST)
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver
	melt_amount = 150
	sellprice = 90
	item_weight = 2.1 KILOGRAMS

/obj/item/weapon/mace/warhammer/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Elven Club  ............... //

/obj/item/weapon/mace/elvenclub
	name = "club de guerra elfico"
	desc = "Un garrote de guerra de una mano con un extremo afilado."
	icon_state = "elvenclub"
	force = DAMAGE_MACE - 1
	force_wielded = DAMAGE_MACE_WIELD - 1
	possible_item_intents = list(MACE_STRIKE, AXE_CUT)
	gripped_intents = list(MACE_STRIKE, AXE_CUT, AXE_CHOP) //can't smash with this weapon.
	max_blade_int = 150
	sharpness = IS_SHARP
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/mace/elvenclub/steel
	name = "club de guerra de los elfos de acero"
	desc = "Un elegante garrote de guerra de una mano, reforjado con acero Grenzel capturado. Sus elegantes diseños de cuentas canalizan la gracia elfica. Es capaz de asestar golpes rapidos y dolorosos."
	icon_state = "elvenclubsteel"
	force = DAMAGE_MACE
	force_wielded = DAMAGE_MACE_WIELD
	wdefense = GOOD_PARRY
	wbalance = DODGE_CHANCE_NORMAL
	max_blade_int = 250
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	melt_amount = 150
	sellprice = 60
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/mace/elvenclub/bronze
	name = "garrote de guerra elfico de bronce"
	desc = "Un garrote de guerra de bronce con una sola mano y un extremo afilado. Ha sido favorecido durante mucho tiempo por los Elfos de Heartfelt, a pesar de sus origenes extranjeros."
	icon_state = "elvenclub_bronze"
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/ingot/bronze
	melting_material = /datum/material/bronze
	melt_amount = 100
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/mace/elvenclub/silver
	name = "club de guerra real de los elfos"
	desc = "Un moderno garrote de guerra plateado con diseño elfico, bellamente decorado con filigrana dorada."
	icon_state = "regalelvenclub"
	force = DAMAGE_MACE
	force_wielded = DAMAGE_MACE_WIELD
	wdefense = GOOD_PARRY
	wbalance = DODGE_CHANCE_NORMAL
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONGEST * 0.8
	item_weight = 1.4 KILOGRAMS
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver
	melt_amount = 150
	sellprice = 150

/obj/item/weapon/mace/elvenclub/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Silver ............... //
/obj/item/weapon/mace/silver
	name = "maza de plata"
	desc = "Una maza plateada con colmillos, utilizada para ahuyentar a las criaturas de la noche."
	icon_state = "silvermace"
	force = DAMAGE_MACE + 1
	force_wielded = DAMAGE_MACE_WIELD
	wdefense = GOOD_PARRY
	wbalance = DODGE_CHANCE_NORMAL
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver
	melt_amount = 150
	sellprice = 80
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/mace/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/mace/rungu/silver
	name = "rungu plateado"
	desc = "Una maza plateada del este caido. Hecho para luchar contra los noctambulos."
	icon_state = "rungu_silver"
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	wdefense = GOOD_PARRY
	wbalance = DODGE_CHANCE_NORMAL
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver
	melt_amount = 150
	sellprice = 45
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/mace/rungu/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/mace/gada
	name = "gada real"
	icon_state = "gada"
	desc = "Una lujosa maza plateada reforzada y adornada con oro. Es considerablemente mas pesado en comparacion con otras mazas."
	force = DAMAGE_MACE + 2
	wbalance = DODGE_CHANCE_NORMAL
	max_integrity = INTEGRITY_STRONGEST * 0.8
	melting_material = /datum/material/silver
	sellprice = 150 // It's silver and gold.
	item_weight = 1.8 KILOGRAMS

/obj/item/weapon/mace/gada/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ BRONZE ............... //

/obj/item/weapon/mace/bronze
	name = "maza de bronce"
	icon_state = "mace_bronze"
	desc = "Una maza de bronce con puas. Un arma que ha resurgido en medio del cataclismo en Heartfelt."
	force = DAMAGE_MACE + 1
	force_wielded = DAMAGE_MACE_WIELD + 1 //Spiked
	max_integrity = INTEGRITY_STANDARD
	sellprice = 25
	item_weight = 1.5 KILOGRAMS
	smeltresult = /obj/item/ingot/bronze

/obj/item/weapon/mace/bronze/shishpar
	name = "shishpar de bronce"
	desc = "Una pesada maza extranjera con mango en forma de espada. Su peso hace que sea un poco dificil de manejar, pero es capaz de asestar golpes devastadores."
	icon_state = "shishpar_bronze"
	force = DAMAGE_MACE_WIELD + 2
	force_wielded = DAMAGE_MACE_WIELD + 3
	wbalance = EASY_TO_DODGE
	item_weight = 1.8 KILOGRAMS
