/* WHIPS
==========================================================*/

/obj/item/weapon/whip
	name = "garrucha"
	desc = "Un latigo de cuero, cuerda entrelazada, cuero y una punta con colmillos para infligir un dolor enorme. Favorecido por esclavistas y domadores de bestias."
	icon_state = "whip"
	icon = 'icons/roguetown/weapons/32/whips_flails.dmi'
	force = DAMAGE_WHIP
	throwforce = DAMAGE_WHIP - 15
	wdefense = BAD_PARRY
	wbalance = VERY_HARD_TO_DODGE
	wlength = WLENGTH_GREAT
	can_parry = FALSE
	wdodgebonus = 30 //To counteract the GREAT_LENGTH penalty.
	possible_item_intents = list(WHIP_CRACK, WHIP_LASH)

	sharpness = IS_BLUNT
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	associated_skill = /datum/attribute/skill/combat/whipsflails
	anvilrepair = /datum/attribute/skill/craft/tanning
	resistance_flags = FLAMMABLE // Fully made of leather
	swingsound = WHIPWOOSH
	sellprice = 30
	grid_width = 32
	grid_height = 64

	weapon_special = /datum/special_intent/whip_coil
	item_weight = 500 GRAMS

/obj/item/weapon/whip/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//................ Repenta En ............... //
/obj/item/weapon/whip/antique
	name = "\proper repenta en"
	desc = "Un latigo muy bien cuidado, con punta de acero pulido y mango dorado."
	icon_state = "gwhip"
	force = DAMAGE_WHIP + 4
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/steel_slag
	max_integrity = INTEGRITY_STRONG
	sellprice = 50
	item_weight = 600 GRAMS

//................ Butler Whip ............... //
/obj/item/weapon/whip/butler
	name = "testamento de la corona"

//................ Silver Whip ............... //
/obj/item/weapon/whip/silver
	name = "latigo de plata"
	desc = "Un latigo con mango, nucleo y punta de plata. Ha sido modificado para infligir dolor ardiente en nitebeasts."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psywhip_lesser"
	force = DAMAGE_WHIP + 2
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silver
	max_integrity = INTEGRITY_STRONG * 0.8
	last_used = 0
	item_weight = 550 GRAMS

/obj/item/weapon/whip/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Psydon Whip ............... //
/obj/item/weapon/whip/psydon
	name = "psydonian latigo"
	desc = "Un latigo diseñado con la iconografia de Psydon y elaborado integramente en plata."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psywhip"
	force = DAMAGE_WHIP + 2
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silverblessed
	max_integrity = INTEGRITY_STRONG * 0.8
	last_used = 0
	item_weight = 550 GRAMS

/obj/item/weapon/whip/psydon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/whip/psydon/relic
	name = "Recreo de dia"
	desc = "Sostener esta plata bendita evoca recuerdos de las grandes catedrales, testimonios de la fe de la humanidad. Alli, en el techo, estaba pintada una escena de lo mas hermosa: la de Psydon, vestido con una tunica, en batalla contra los archidemonios. Lleva la luz a los fieles."
	item_weight = 550 GRAMS

/obj/item/weapon/whip/psydon/relic/Initialize(mapload)
	. = ..()					// Pre-blessed, +5 force, +100 INT, +2 Def, Silver.
	AddComponent(/datum/component/psyblessed, TRUE, 5, FALSE, 100, 2, TRUE)

//................ Caning Stick.................//
/obj/item/weapon/whip/cane
	name = "palo de azote"
	desc = "Un baston delgado destinado a golpear a otros como castigo."
	icon = 'icons/roguetown/weapons/32/special.dmi'
	icon_state = "canestick"
	force = DAMAGE_WHIP / 2
	wlength = WLENGTH_NORMAL
	possible_item_intents = list(CANE_LASH)
	max_integrity = 4 // Striking unarmoured parts doesn't take integrity, four hits to anything with an armor value will break it.
	sellprice = 0
	item_weight = 100 GRAMS

/obj/item/weapon/whip/cane/getonmobprop(tag)
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
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//................ Lashkiss Whip ............... //
/obj/item/weapon/whip/spiderwhip
	name = "latigo de beso de pestañas"
	desc = "Un latigo oscuro con espinas cenicientas segmentadas como base. Se dice que fue tallado a partir de prisioneros del terror dendrificados."
	icon = 'icons/roguetown/weapons/32/elven.dmi'
	icon_state = "spiderwhip"
	force = DAMAGE_WHIP + 3
	item_weight = 500 GRAMS

//................ Chain Whip ............... //
/obj/item/weapon/whip/chain
	name = "latigo de cadena"
	desc = "Una cadena de hierro, fijada a una empuñadura de cuero. Es increiblemente pesado y dificil de manejar. Probablemente te lastimes mas que nadie con esto."
	icon_state = "whip_chain"
	force = DAMAGE_WHIP + 3
	possible_item_intents = list(WHIP_MTLCRACK, WHIP_MTLLASH)

	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/attribute/skill/craft/weapon_repair
	smeltresult = /obj/item/ingot/iron
	item_weight = 1.5 KILOGRAMS

//................ Xylix Whip ............... //
/obj/item/weapon/whip/xylix
	name = "cackle lash"
	desc = "Se dice que las campanadas de este latigo suenan como la propia risa del embaucador."
	icon = 'icons/roguetown/weapons/32/patron.dmi'
	icon_state = "xylixwhip"
	force = DAMAGE_WHIP + 4
	anvilrepair = /datum/attribute/skill/craft/weapon_repair
	item_weight = 500 GRAMS

/obj/item/weapon/whip/nagaika //Import only
	name = "latigo nagaika"
	desc = "Un latigo de cuero corto pero pesado, con una punta roma reforzada y un mango mas largo."
	icon_state = "nagaika"
	force = DAMAGE_WHIP + 5		//Same as a cudgel/sword for intent purposes. Basically a 2 range cudgel while one-handing.
	possible_item_intents = list(WHIP_MTLCRACK, WHIP_LASH, SWORD_STRIKE)
	item_weight = 700 GRAMS

//................ Urumi ............... //

/obj/item/weapon/whip/urumi
	name = "urumi de acero"
	desc = "Una espada larga y flexible con forma de latigo desarrollada originalmente por los elfos de Savannah. Si bien es un arma eficaz, requiere mas mantenimiento en comparacion con otras espadas."
	icon_state = "urumi_steel"
	force = DAMAGE_WHIP + 3
	wbalance = HARD_TO_DODGE
	wdefense = BAD_PARRY // Parrying with a whip sword is inherently badass, plus its a small benefit for it since its supposed to have less durability.
	can_parry = TRUE
	possible_item_intents = list(WHIP_MTLCRACK, WHIP_LASH, WHIP_CUT)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG

	anvilrepair = /datum/attribute/skill/craft/weapon_repair
	resistance_flags = FIRE_PROOF
	sharpness = IS_SHARP
	blade_dulling = DULLING_BASH
	smeltresult = /obj/item/ingot/steel_slag
	item_weight = 800 GRAMS

/obj/item/weapon/whip/urumi/iron
	name = "urumi de hierro"
	icon_state = "urumi_iron"
	force = DAMAGE_WHIP
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/ingot/iron
	item_weight = 850 GRAMS

/obj/item/weapon/whip/urumi/bronze
	name = "urumi de bronce"
	icon_state = "urumi_bronze"
	force = DAMAGE_WHIP
	max_blade_int = 100
	max_integrity = INTEGRITY_POOR
	smeltresult = /obj/item/ingot/bronze
	item_weight = 800 GRAMS

/obj/item/weapon/whip/urumi/silver
	name = "urumi plateado"
	icon_state = "urumi_silver"
	force = DAMAGE_WHIP + 1
	max_blade_int = 160
	max_integrity = INTEGRITY_STRONG * 0.8
	smeltresult = /obj/item/ingot/silver
	item_weight = 750 GRAMS

/obj/item/weapon/whip/urumi/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)
