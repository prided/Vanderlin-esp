/* SWORDS
==========================================================*/

// Sword base
/obj/item/weapon/sword
	name = "espada"
	desc = "Un diseño de hoja confiable, la primera herramienta de guerra dedicada desde antes de la era de la historia."
	icon = 'icons/roguetown/weapons/32/swords.dmi'
	icon_state = "sword1"
	parrysound = "sword"
	force = DAMAGE_SWORD
	force_wielded = DAMAGE_SWORD_WIELD
	throwforce = DAMAGE_SWORD - 10
	wdefense = GREAT_PARRY
	wlength = WLENGTH_NORMAL
	possible_item_intents = list(SWORD_CUT, SWORD_THRUST)
	gripped_intents = list(SWORD_CUT, SWORD_THRUST)
	alt_intents = list(DAZE_BASH, SWORD_STRIKE, POMMEL_BASH)
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP
	swingsound = BLADEWOOSH_MED
	associated_skill = /datum/attribute/skill/combat/swords
	pickup_sound = "unsheathe_sword"
	equip_sound = 'sound/foley/dropsound/holster_sword.ogg'
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	flags_1 = CONDUCT_1
	thrown_bclass = BCLASS_CUT
	smeltresult = /obj/item/ingot/iron
	sellprice = 30
	grid_height = 96
	grid_width = 64
	item_weight = 1.2 KILOGRAMS

	weapon_special = /datum/special_intent/shin_swipe

/obj/item/weapon/sword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 270,"sturn" = 90,"wturn" = 100,"eturn" = 261,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/*-----------------\
| Onehanded Swords |
\-----------------*/

/obj/item/weapon/sword/short
	name = "espada corta"
	desc = "Una espada de acero de diseño acortado y empuñadura reducida para uso con una sola mano."
	icon_state = "swordshort"
	force = DAMAGE_SHORTSWORD
	force_wielded = 0
	wbalance = HARD_TO_DODGE
	wlength = WLENGTH_SHORT
	possible_item_intents = list(SHORT_CUT, SHORT_THRUST)
	gripped_intents = null
	alt_intents = null
	w_class = WEIGHT_CLASS_NORMAL
	sellprice = 30
	item_weight = 700 GRAMS
	smeltresult = /obj/item/ingot/steel_slag
	weapon_special = /datum/special_intent/triple_stab

/obj/item/weapon/sword/short/iron
	desc = "Una espada de hierro de diseño acortado y empuñadura reducida para uso con una sola mano."
	icon_state = "iswordshort"
	wdefense = GOOD_PARRY
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	sellprice = 15
	item_weight = 750 GRAMS

/obj/item/weapon/sword/short/bronze
	name = "espada corta de bronce"
	desc = "Una espada de bronce de diseño acortado y empuñadura reducida para uso con una sola mano."
	icon_state = "shortsword_bronze"
	wdefense = GOOD_PARRY
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/ingot/bronze
	sellprice = 10
	item_weight = 700 GRAMS

/obj/item/weapon/sword/short/silver

	name = "espada corta de plata"
	desc = "Una espada corta de plata, para aquellos que luchan contra las criaturas de la noche."
	icon_state = "silverswordshort"
	force = DAMAGE_SHORTSWORD + 2
	wdefense = GOOD_PARRY
	max_blade_int = 250
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silver
	sellprice = 60
	item_weight = 650 GRAMS

/obj/item/weapon/sword/short/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/short/psy
	name = "Espada corta psydonian"
	desc = "Los herreros Grenzelhoftian trabajaron con los artifices y nacio una espada esoterica: una espada con un diseño unico, que descartaba una cruceta en favor de un pico hueco para enganchar y alejar el daño de su usuario. De longitud corta pero letalmente ligera."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psyswordshort"
	force = DAMAGE_SHORTSWORD + 3
	grid_width = 32
	grid_height = 96
	item_weight = 650 GRAMS
	smeltresult = /obj/item/ingot/silverblessed

/obj/item/weapon/sword/short/psy/Initialize(mapload)
	. = ..()						//+2 force, +50 blade int, +50 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, FALSE, 2, 50, 50, 1, TRUE)

/obj/item/weapon/sword/short/ida //Worse thrust but more damage for cutting.
	name = "ida de acero"
	desc = "Una espada corta de acero con hoja en forma de hoja. Solia ​​ser un arma popular en el este."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "ida_steel"
	force = DAMAGE_SHORTSWORD + 4
	possible_item_intents = list(SHORT_CUT, SWORD_THRUST)
	item_weight = 700 GRAMS

/obj/item/weapon/sword/short/iron/ida
	name = "ida de hierro"
	desc = "Una espada corta con hoja en forma de hoja. Solia ​​ser un arma popular en el este."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "ida_iron"
	force = DAMAGE_SHORTSWORD + 2
	possible_item_intents = list(SHORT_CUT, SWORD_THRUST)
	item_weight = 750 GRAMS


//................ Arming Sword ............... //
/obj/item/weapon/sword/arming
	name = "espada de armar"
	desc = "Un diseño de hoja confiable, la primera herramienta de guerra dedicada desde antes de la era de la historia."
	icon_state = "sword1"
	sellprice = 30
	smeltresult = /obj/item/ingot/steel_slag

	weapon_special = /datum/special_intent/shin_swipe
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/sword/arming/Initialize()
	. = ..()
	if(icon_state == "sword1")
		icon_state = "sword[rand(1,3)]"

/obj/item/weapon/sword/decorated
	icon_state = "decsword1"
	sellprice = 140
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/sword/decorated/Initialize()
	. = ..()
	if(icon_state == "decsword1")
		icon_state = "decsword[rand(1,3)]"

/obj/item/weapon/sword/silver
	name = "espada de plata"
	desc = "Una sencilla espada plateada con un filo que brilla a la luz de la luna."
	icon_state = "silversword"
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silver
	sellprice = 45
	last_used = 0
	item_weight = 1.1 KILOGRAMS

/obj/item/weapon/sword/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/iron
	desc = "Una simple espada de hierro con un filo probado, afilado y verdadero."
	icon_state = "isword"
	wdefense = GOOD_PARRY
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/sword/bronze
	name = "espada de bronce"
	desc = "Una espada de bronce sencilla y fiable."
	icon_state = "sword_bronze"
	wdefense = GOOD_PARRY
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/ingot/bronze
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/sword/kaskara
	name = "kaskara de acero"
	desc = "Una espada de acero con una pequeña cruz."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "kaskara_steel"
	possible_item_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_CHOP)
	gripped_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_CHOP)
	alt_intents = null
	item_weight = 1.2 KILOGRAMS
	smeltresult = /obj/item/ingot/steel_slag

/obj/item/weapon/sword/kaskara/iron
	name = "kaskara de hierro"
	desc = "Una espada con una pequeña cruz."
	icon_state = "kaskara_iron"
	wdefense = GOOD_PARRY
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/sword/stone
	name = "espada de piedra"
	desc = "Una espada toscamente hecha, empuñada por salvajes."
	icon_state = "stone_sword"
	force = DAMAGE_SWORD - 6
	force_wielded = DAMAGE_SHORTSWORD - 1
	wdefense = AVERAGE_PARRY
	max_blade_int = 50
	max_integrity = INTEGRITY_WORST / 4
	item_weight = 900 GRAMS
	smeltresult = null

/*-------\
| Sabres |	Onehanded, slightly weaker thrust, better for parries. Think rapier but cutting focus.
\-------*/
/obj/item/weapon/sword/sabre
	name = "sable"
	desc = "Un sable veloz, preferido tanto por duelistas como por asesinos."
	icon_state = "saber"
	force_wielded = 0
	wdefense = ULTMATE_PARRY
	possible_item_intents = list(SWORD_CUT, CURVED_THRUST)
	gripped_intents = null
	alt_intents = null
	smeltresult = /obj/item/ingot/steel_slag
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	swingsound = BLADEWOOSH_SMALL
	item_weight = 900 GRAMS

/obj/item/weapon/sword/sabre/dec
	name = "sable decorado"
	desc = "Un sable decorado con modernos detalles dorados sin sacrificar su letal practicidad."
	icon_state = "decsaber"
	sellprice = 140
	item_weight = 900 GRAMS

/obj/item/weapon/sword/sabre/captain
	name = "\proper Ley"
	desc = "Un sable decorado con oro forjado especificamente para el Capitan junto a su armadura. Para llevar la Ley a las tierras, utilizaran esta espada."
	icon_state = "capsaber"
	sellprice = 140
	item_weight = 900 GRAMS

/obj/item/weapon/sword/sabre/stalker
	name = "sable acosador"
	desc = "Una vez elegante hoja de mitril, que disminuye bajo la mirada del sol."
	icon = 'icons/roguetown/weapons/32/elven.dmi'
	icon_state = "spidersaber"
	possible_item_intents = list(SWORD_CUT, SHORT_THRUST)
	item_weight = 850 GRAMS

/obj/item/weapon/sword/sabre/noc
	name = "khopesh luz de la luna"
	icon = 'icons/roguetown/weapons/32/patron.dmi'
	icon_state = "nockhopesh"
	desc = "La brillante luz de la luna sobre el acero azulado."
	possible_item_intents = list(SWORD_CUT, CURVED_THRUST, SWORD_CHOP)
	max_integrity = INTEGRITY_STRONGEST * 0.8
	item_weight = 950 GRAMS
	smeltresult = /obj/item/ingot/silver

/obj/item/weapon/sword/sabre/noc/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Cutlass ............... //
/obj/item/weapon/sword/sabre/cutlass
	name = "sable de abordaje"
	desc = "Tanto herramienta como arma de guerra, preferida por los cultistas y marineros de Abyssor para las batallas maritimas."
	icon_state = "cutlass"
	force = DAMAGE_SWORD + 2
	wdefense = GREAT_PARRY
	wbalance = HARD_TO_DODGE
	item_weight = 1 KILOGRAMS

/obj/item/weapon/sword/sabre/dadao
	name = "dadao de acero"
	icon_state = "dadao_steel"
	desc = "A veces tambien se denominan picadoras \"Saiga\". Los dadaos son espadas orientales pesadas, famosas por su capacidad de cortar a los hombres por la mitad."
	force = DAMAGE_SWORD + 1
	force_wielded = DAMAGE_SWORD_WIELD + 1
	wdefense = AVERAGE_PARRY
	wbalance = EASY_TO_DODGE
	gripped_intents = list(AXE_CHOP, CURVED_THRUST)
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/sword/sabre/dadao/iron
	name = "dadao de hierro"
	icon_state = "dadao_iron"
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/sword/sabre/dadao/bronze
	name = "dadao de bronce"
	icon_state = "dadao_bronze"
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/ingot/bronze
	item_weight = 1.1 KILOGRAMS

//................ Shalal Sabre ............... //
/obj/item/weapon/sword/sabre/shalal
	name = "zaladin sable de montar"
	desc = "Un arma excelente de origen Zaladin, utilizada por aquellos que dominan el manejo de la espada a caballo."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "marlin"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	parrysound = "rapier"
	force_wielded = DAMAGE_SWORD
	wdefense = GREAT_PARRY
	wlength = WLENGTH_LONG
	possible_item_intents = list(SWORD_CUT, SWORD_STRIKE)
	gripped_intents = list(SWORD_CUT, SWORD_STRIKE, SWORD_CHOP, SWORD_THRUST)

	bigboy = TRUE
	gripsprite = TRUE
	SET_BASE_PIXEL(-16, -16)
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	sellprice = 80
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/sword/sabre/shalal/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 270,"sturn" = 90,"wturn" = 90,"eturn" = 261,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/sabre/scythe
	name = "espada guadaña"
	desc = "Se ha fijado la hoja de una herramienta agricola a un mango de madera mas corto para crear un arma improvisada."
	icon_state = "scytheblade"
	force = DAMAGE_SWORD - 2
	wdefense = AVERAGE_PARRY
	item_weight = 1 KILOGRAMS

/*----------\
| Scimitars |	Normal swords with a strong cutting emphasis.
\----------*/
/obj/item/weapon/sword/scimitar
	name = "cimitarra"
	desc = "Un diseño Zaladin para espadas, estas hojas curvas son una vista comun en las tierras del Zigurat."
	icon_state = "scimitar"
	wdefense = GOOD_PARRY
	possible_item_intents = list(SWORD_CUT, SWORD_CHOP)
	swingsound = BLADEWOOSH_LARGE
	item_weight = 1.1 KILOGRAMS
	smeltresult = /obj/item/ingot/steel_slag

/obj/item/weapon/sword/scimitar/falchion
	name = "falchion"
	desc = "Hoja ancha, acero excelente, un diseño inspirado en Malum, afirman los enanos."
	icon_state = "falchion"
	wbalance = EASY_TO_DODGE
	possible_item_intents = list(SWORD_CUT, AXE_CHOP)
	gripped_intents = list(SWORD_CUT, AXE_CHOP)
	swingsound = BLADEWOOSH_HUGE
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/sword/scimitar/messer
	name = "messer"
	desc = "Hoja de hierro recta, filo simple, sensato y una hoja popular del norte."
	icon_state = "imesser"
	wbalance = EASY_TO_DODGE
	possible_item_intents = list(SWORD_CUT, AXE_CHOP)
	gripped_intents = list(SWORD_CUT, AXE_CHOP)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	sellprice = 20
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/sword/scimitar/lakkarikhopesh/iron
	name = "khopesh de hierro"
	desc = "Una espada curva en forma de media luna. Es popular entre los eruditos noccianos viajeros."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "khopesh_iron"
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	sellprice = 20
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/sword/scimitar/lakkarikhopesh
	name = "khopesh de acero"
	desc = "Una espada curva en forma de media luna. Es popular entre los eruditos noccianos viajeros."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "khopesh_steel"
	wbalance = EASY_TO_DODGE
	possible_item_intents = list(SWORD_CUT, AXE_CHOP)
	gripped_intents = list(AXE_CHOP, SWORD_THRUST)
	sellprice = 45
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/sword/scimitar/sengese/iron
	name = "sengese de hierro"
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "sengese_iron"
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	sellprice = 20
	item_weight = 1.1 KILOGRAMS

/obj/item/weapon/sword/scimitar/sengese
	name = "sengese de acero"
	desc = "Una espada curva hecha para desviar golpes. Muchos espadachines inexpertos tienen dificultades para utilizarlo bien debido a su forma, pero es una fuerza a tener en cuenta en manos de un maestro."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "sengese_steel"
	wdefense = GREAT_PARRY
	gripped_intents = list(SWORD_CUT, CURVED_THRUST)
	alt_intents = null
	swingsound = BLADEWOOSH_SMALL
	sellprice = 45
	item_weight = 1.1 KILOGRAMS

/obj/item/weapon/sword/scimitar/sengese/bronze
	name = "sengese de bronce"
	icon = 'icons/roguetown/weapons/32/swords.dmi'
	icon_state = "sengese_bronze"
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD
	smeltresult = /obj/item/ingot/bronze
	sellprice = 15
	item_weight = 1 KILOGRAMS

/obj/item/weapon/sword/scimitar/sengese/silver
	name = "sengese de plata"
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "sengese_silver"
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silver
	sellprice = 30
	item_weight = 1 KILOGRAMS

/obj/item/weapon/sword/scimitar/sengese/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/scimitar/wodao
	name = "acero wo dao"
	desc = "Hoja ligeramente curvada de origen oriental. Si bien es menos duradera en comparacion con otras espadas, su equilibrio rapido y su diseño unico la hacen ideal para dar golpes precisos."
	icon_state = "wodao_steel"
	wbalance = VERY_HARD_TO_DODGE
	possible_item_intents = list(RAPIER_THRUST,RAPIER_CUT)
	swingsound =  BLADEWOOSH_SMALL
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8
	item_weight = 900 GRAMS

/obj/item/weapon/sword/scimitar/wodao/iron
	name = "hierro wo dao"
	icon_state = "wodao_iron"
	force = DAMAGE_SWORD - 1
	force_wielded = DAMAGE_SWORD_WIELD -1
	max_blade_int = 160
	max_integrity = INTEGRITY_STRONG * 0.8
	smeltresult = /obj/item/ingot/iron
	item_weight = 950 GRAMS

/*--------\
| Rapiers |		Onehanded, slightly weaker cut, more AP thrust, harder to dodge.
\--------*/
/obj/item/weapon/sword/rapier
	name = "estoque"
	desc = "Un arma de duelista derivada de instrumentos de batalla occidentales; posee una hoja \
	afilada con una punta especializada para estocadas."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "rapier"
	force_wielded = 0
	wbalance = VERY_HARD_TO_DODGE
	possible_item_intents = list(RAPIER_THRUST, RAPIER_CUT)
	gripped_intents = null
	alt_intents = null
	smeltresult = /obj/item/ingot/steel_slag
	bigboy = TRUE
	parrysound = list('sound/combat/parry/bladed/bladedthin (1).ogg', 'sound/combat/parry/bladed/bladedthin (2).ogg', 'sound/combat/parry/bladed/bladedthin (3).ogg')
	parrysound = "rapier"
	swingsound = BLADEWOOSH_SMALL
	SET_BASE_PIXEL(-16, -16)

	weapon_special = /datum/special_intent/piercing_lunge
	item_weight = 700 GRAMS

/obj/item/weapon/sword/rapier/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list(
				"shrink" = 0.5,
				"sx" = -14,
				"sy" = -8,
				"nx" = 15,
				"ny" = -7,
				"wx" = -10,
				"wy" = -5,
				"ex" = 7,
				"ey" = -6,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				"nturn" = -13,
				"sturn" = 110,
				"wturn" = -60,
				"eturn" = -30,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 8,
				"eflip" = 1,
				)
			if("onback") return list(
				"shrink" = 0.5,
				"sx" = -1,
				"sy" = 2,
				"nx" = 0,
				"ny" = 2,
				"wx" = 2,
				"wy" = 1,
				"ex" = 0,
				"ey" = 1,
				"nturn" = 0,
				"sturn" = 0,
				"wturn" = 70,
				"eturn" = 15,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 1,
				"eflip" = 1,
				"northabove" = 1,
				"southabove" = 0,
				"eastabove" = 0,
				"westabove" = 0,
				)
			if("onbelt") return list(
				"shrink" = 0.4,
				"sx" = -4,
				"sy" = -6,
				"nx" = 5,
				"ny" = -6,
				"wx" = 0,
				"wy" = -6,
				"ex" = -1,
				"ey" = -6,
				"nturn" = 100,
				"sturn" = 156,
				"wturn" = 90,
				"eturn" = 180,
				"nflip" = 0,
				"sflip" = 0,
				"wflip" = 0,
				"eflip" = 0,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				)

/obj/item/weapon/sword/rapier/psy
	name = "Estoque psydonian"
	desc = "Un estoque de plata muy ornamentado, utilizado mas como muestra de estatus para los miembros de la Inquisicion."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "psyrapier"
	max_integrity = INTEGRITY_STRONG
	max_blade_int = 300
	item_weight = 700 GRAMS
	smeltresult = /obj/item/ingot/silverblessed

/obj/item/weapon/sword/rapier/psy/Initialize(mapload)
	. = ..()
	//Pre-blessed, +100 Blade int, +100 int, +2 def, make it silver
	AddComponent(/datum/component/psyblessed, TRUE, 5, 100, 100, 2, TRUE)

/obj/item/weapon/sword/rapier/psy/relic
	name = "venganza"
	desc = "Un estoque tan veloz como los inquisidores del Ordo Venatari. Golpea el mal en su corazon. Purga lo impio a traves de la mas minima ventana que ofrece, en nombre de Psydon."
	item_weight = 700 GRAMS

/obj/item/weapon/sword/rapier/dec
	name = "estoque decorado"
	desc = "Estoque decorado con incrustaciones de oro en la empuñadura. Un arma real digna de la nobleza."
	icon_state = "decrapier"
	sellprice = 140
	item_weight = 700 GRAMS

/obj/item/weapon/sword/rapier/nimcha
	name = "nimcha"
	desc = "Una espada veloz adornada del este."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "nimcha"
	sellprice = 140 // its made with gold and steel, thats pretty valuable
	item_weight = 750 GRAMS

/obj/item/weapon/sword/rapier/caneblade
	name = "hoja de caña"
	desc = "Una hoja de acero con mango de oro, destinada a ocultarse dentro de un baston. Se centra en apuñalar."
	icon = 'icons/roguetown/weapons/32/swords.dmi'
	icon_state = "caneblade"
	sellprice = 100 //Gold handle
	bigboy = FALSE
	SET_BASE_PIXEL(0, 0)
	item_weight = 500 GRAMS

/obj/item/weapon/sword/rapier/caneblade/courtphysician
	name = "hoja de caña"
	desc = "Una hoja de acero con mango de oro, destinada a ocultarse dentro de un baston. Este lleva en su pomo el rostro de un buitre."
	icon = 'icons/roguetown/weapons/32/swords.dmi'
	icon_state = "doccaneblade"

/obj/item/weapon/sword/rapier/caneblade/hand
	name = "hoja de caña"
	desc = "Una hoja de acero con mango plateado, destinada a ocultarse dentro de un baston. Este lleva un rontz en su pomo."
	icon_state = "staffblade"

//................ Lord's Rapier ............... //
/obj/item/weapon/sword/rapier/dec/lord
	name = "\proper estoque del señor"
	desc = "Transmitida a traves de los siglos, un arma que alguna vez creo un reino ahora relegada a una pieza decorativa."
	icon_state = "lord_rapier"
	force = DAMAGE_SWORD_WIELD
	sellprice = 200
	max_blade_int = 400
	item_weight = 750 GRAMS

/obj/item/weapon/sword/rapier/silver
	name = "estoque de plata"
	desc = "Un elegante estoque plateado. Popular entre señores y damas en Valoria."
	icon_state = "rapier_s"
	force = DAMAGE_SWORD - 2
	melt_amount = 100
	max_blade_int = 240 // .8 of base steel
	max_integrity = INTEGRITY_STRONGEST * 0.8
	smeltresult = /obj/item/ingot/silver
	sellprice = 45
	last_used = 0
	item_weight = 650 GRAMS

/obj/item/weapon/sword/rapier/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/rapier/eora
	name = "\proper corazon"
	desc = "Para cuando ya no se puedan decir palabras suaves y los corazones deban ser traspasados."
	icon = 'icons/roguetown/weapons/32/patron.dmi'
	icon_state = "eorarapier"
	item_weight = 650 GRAMS
	SET_BASE_PIXEL(0, 0)
	bigboy = FALSE

// Hoplite Kophesh
/obj/item/weapon/sword/khopesh
	name = "khopesh antiguo"
	desc = "Un arma de guerra de bronce de la epoca del reinado de Psydon. Esta espada es mas antigua que algunas generaciones de elfos, pero ha sido muy bien mantenida y aun conserva un buen filo."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "khopesh"
	item_state = "khopesh"
	force = DAMAGE_SWORD + 2 // Unique weapon from rare job, slightly more force than most one-handers
	force_wielded = 0
	wdefense = GOOD_PARRY // Lower than average sword defense (meant to pair with a shield)
	wbalance = EASY_TO_DODGE // Likely weighted towards the blade, for deep cuts and chops
	possible_item_intents = list(SWORD_CUT, SWORD_CHOP, SWORD_STRIKE)
	gripped_intents = null
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONG

	inhand_x_dimension = 64
	inhand_y_dimension = 64
	SET_BASE_PIXEL(-16, -16)
	bigboy = TRUE // WHY DOES THIS FUCKING VARIABLE CONTROL WHETHER THE BLOOD OVERLAY WORKS ON 64x64 WEAPONS
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	smeltresult = /obj/item/ingot/bronze
	sellprice = 200 // A noble collector would love to get his/her hands on one of these blades
	item_weight = 1.3 KILOGRAMS


/*-----------------\
| Twohanded Swords |
\-----------------*/

//................ Long Sword ............... //
/obj/item/weapon/sword/long
	name = "espada larga"
	desc = "Una espada larga de mano y media, empuñada tanto por los virtuosos como por los viles."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "longsword"
	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	force_wielded = DAMAGE_LONGSWORD_WIELD
	wlength = WLENGTH_LONG
	possible_item_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_STRIKE)
	gripped_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_STRIKE, SWDLONG_CHOP)
	smeltresult = /obj/item/ingot/steel_slag
	swingsound = BLADEWOOSH_LARGE
	parrysound = "largeblade"
	pickup_sound = "brandish_blade"
	bigboy = TRUE
	gripsprite = TRUE
	SET_BASE_PIXEL(-16, -16)
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	sellprice = 60
	grid_height = 96
	grid_width = 64

	weapon_special = /datum/special_intent/side_sweep
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/sword/long/shotel
	name = "escopeta de acero"
	icon_state = "shotel_steel"
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	desc = "Una hoja larga y curva en forma de media luna."
	possible_item_intents = list(SWORD_CUT, SWORD_CHOP)
	gripped_intents = list(SWDLONG_CUT, SHOTEL_CHOP)
	alt_intents = null

	gripsprite = FALSE
	sellprice = 80
	max_integrity = INTEGRITY_STRONG - 50 //this thing is long as hell, it would be more likely to break over time
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/sword/long/shotel/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/shotel/iron //Balance-patch
	name = "shotel de hierro"
	icon_state = "shotel_iron"
	max_integrity = INTEGRITY_STANDARD - 50
	smeltresult = /obj/item/ingot/iron
	sellprice = 60
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/sword/long/death
	color = CLOTHING_SOOT_BLACK

/obj/item/weapon/sword/long/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 212,"sturn" = 335,"wturn" = 165,"eturn" = 195,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 8,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.6,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/aruval
	name = "aruval de acero"
	icon_state = "aruval_steel"
	desc = "Un machete de garfio largo de origen elfo de Savannah. Originalmente fue diseñado para cortar ramas grandes, pero desde entonces se ha convertido en un arma formidable."
	possible_item_intents = list(SWORD_CUT, SWORD_CHOP)
	gripped_intents = list(SWDLONG_CUT, SWDLONG_CHOP, SWORD_DISARM)
	alt_intents = null
	gripsprite = FALSE
	max_integrity = INTEGRITY_STRONGEST
	sellprice = 60
	item_weight = 1.6 KILOGRAMS

/obj/item/weapon/sword/long/aruval/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/aruval/iron //Balance-patch
	name = "aruval de hierro"
	icon_state = "aruval_iron"
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	sellprice = 35
	item_weight = 1.7 KILOGRAMS

/obj/item/weapon/sword/long/aruval/iron/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/death
	color = CLOTHING_SOOT_BLACK

/obj/item/weapon/sword/long/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 212,"sturn" = 335,"wturn" = 165,"eturn" = 195,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 8,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.6,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................Kriegmesser...................//
/obj/item/weapon/sword/long/kriegmesser
	name = "kriegmesser"
	icon_state = "kriegmesser"
	desc = "Una espada larga de un solo filo con una guarda cruzada y una empuñadura larga. Fue diseñado para cortar puñaladas, como un cuchillo pesado."
	force = DAMAGE_SWORD + 2
	force_wielded = DAMAGE_LONGSWORD_WIELD + 3
	possible_item_intents = list(SWORD_CUT, SWORD_CHOP)
	gripped_intents = list(SWORD_CUT, SWDLONG_CHOP, SWORD_STRIKE, SWORD_CLEAVE)
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST
	item_weight = 1.8 KILOGRAMS

//................ Heirloom Sword ............... //
/obj/item/weapon/sword/long/heirloom
	icon_state = "heirloom"
	name = "espada vieja"
	desc = "Una vieja espada de acero con empuñadura de cuero verde heraldico, destrozada por años de abandono."
	force = DAMAGE_SWORD - 2
	force_wielded = DAMAGE_SWORD_WIELD - 2
	max_blade_int = 180 // Neglected, unused
	max_integrity = INTEGRITY_STRONG
	static_price = TRUE
	sellprice = 45 // Old and chipped
	item_weight = 1.5 KILOGRAMS

// Repurposing this unused sword for the Paladin job as a heavy counter against vampires.
/obj/item/weapon/sword/long/judgement// this sprite is a one handed sword, not a longsword.
	name = "juicio"
	icon_state = "judgement"
	desc = "Una espada con empuñadura plateada, empuñadura enjoyada y hoja afilada; Un diseño digno de la nobleza."
	force = DAMAGE_SWORD - 2
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8

	sellprice = 363
	static_price = TRUE
	last_used = 0
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/sword/long/judgement/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/long/judgement/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/judgement/evil
	name = "diezmador"
	desc = "Una espada horrible con empuñadura plateada, empuñadura enjoyada y hoja afilada; un diseño inadecuado para un verdadero paladin."
	color = CLOTHING_SOOT_BLACK
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/sword/long/vlord // this sprite is a one handed sword, not a longsword.
	icon_state = "vlord"
	name = "\proper colmillo hastiado"
	desc = "Una espada larga ancestral con un brillo siniestro, dentada con puas a lo largo de sus bordes. Manchado con un extraño tinte verde."
	force_wielded = DAMAGE_GREATSWORD_WIELD
	sellprice = 0
	static_price = TRUE
	randomize_blade_int = FALSE
	item_weight = 1.6 KILOGRAMS

/obj/item/weapon/sword/long/vlord/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/on_hit/vampiric)

/obj/item/weapon/sword/long/vlord/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 130,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.4,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/rider
	icon_state = "tabi"
	name = "cimitarra kilij"
	desc = "Una hoja curva de origen Zaladin que significa 'curvada'. La espada estandar que vio la conquista del continente Zalad y de los pueblos."
	possible_item_intents = list(SWORD_CUT, SWORD_STRIKE)
	gripped_intents = list(SWORD_CUT, SWORD_STRIKE, SWDLONG_CHOP)
	sellprice = 80
	item_weight = 1.3 KILOGRAMS

/obj/item/weapon/sword/long/rider/steppe
	name = "sable de estepa"
	desc = "Una hoja curva de origen nomada, utilizada por soldados de caballeria en todas las estepas lejanas."
	icon_state = "steppe"
	force_wielded = 0
	wdefense = ULTMATE_PARRY
	possible_item_intents = list(SWORD_CUT, CURVED_THRUST)
	gripped_intents = null
	item_weight = 1.2 KILOGRAMS

/obj/item/weapon/sword/long/rider/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 270,"sturn" = 90,"wturn" = 100,"eturn" = 261,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/forgotten
	name = "espada olvidada"
	desc = "Una gran espada de aleacion de plata realizada en estilo revisionista, en honor a Psydon. Mejor conocida como el arma preferida de las Logias Inquisitoriales."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "oldpsybroadsword"
	force = DAMAGE_SWORD * 0.9 // Damage is .9 of a steel sword
	max_blade_int = INTEGRITY_STRONG * 0.8 // Integrity and blade retention is .8 of a steel sword
	max_integrity = INTEGRITY_STRONGEST * 0.8

	last_used = 0
	smeltresult = /obj/item/ingot/silver
	melt_amount = 75
	sellprice = 90
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/sword/long/forgotten/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/long/ravox
	name = "duel settler"
	desc = "Los principios de los duelos ravoxianos estan inscritos en la hoja de esta espada."
	icon = 'icons/roguetown/weapons/64/patron.dmi'
	icon_state = "ravoxflamberge"
	force = DAMAGE_SWORD + 2
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/sword/long/psydon
	name = "Espada larga psydonian"
	desc = "Una gran espada larga plateada forjada con la forma de psycross."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "psysword"
	last_used = 0
	smeltresult = /obj/item/ingot/silverblessed
	sellprice = 100
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/sword/long/psydon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/sword/long/psydon/relic
	name = "\proper Recuerdo"
	desc = "Una hoja plateada equilibrada, preferida tanto por el Ordo Benetarus como por el Ordo Venetari. Que abra un camino a traves de lo Impio, en honor y recuerdo del sacrificio de Psydon."
	item_weight = 1.5 KILOGRAMS

/obj/item/weapon/sword/long/psydon/relic/Initialize(mapload)
	. = ..()
	//Pre-blessed, +5 force +100 Blade int, +100 int, +1 def, make it silver
	AddComponent(/datum/component/psyblessed, TRUE, 5, 100, 100, 1, TRUE)

/obj/item/weapon/sword/long/silver/decorated
	name = "espada larga de plata decorada"
	desc = "Una espada larga plateada finamente elaborada con una empuñadura dorada decorada."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "declongsword"
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8

	last_used = 0
	smeltresult = /obj/item/ingot/silver
	sellprice = 160

/obj/item/weapon/sword/long/silver
	name = "espada larga de plata"
	desc = "Una espada larga de plata finamente elaborada."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "silverlongsword"
	max_blade_int = 240
	max_integrity = INTEGRITY_STRONGEST * 0.8

	last_used = 0
	smeltresult = /obj/item/ingot/silver
	sellprice = 120

/obj/item/weapon/sword/long/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/long/oldpsysword //Not attainable
	name = "antigua espada larga psydonian"
	desc = "Una espada larga finamente elaborada, revestida con un desgastado revestimiento de plata sucia. Hace tiempo que se ven mejores cosas."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "opsysword"

//................ Greatsword ............... //
/obj/item/weapon/sword/long/greatsword
	name = "gran espada"
	desc = "Un trozo de metal de gran tamaño diseñado para infundir miedo a los hombres y matar bestias."
	icon_state = "gsw"
	force_wielded = DAMAGE_GREATSWORD_WIELD
	wbalance = EASY_TO_DODGE
	wlength = WLENGTH_GREAT
	possible_item_intents = list(SWORD_CUT, SWORD_STRIKE)

	swingsound = BLADEWOOSH_HUGE
	slot_flags = ITEM_SLOT_BACK
	sellprice = 90

	weapon_special = /datum/special_intent/greatsword_swing
	item_weight = 2.5 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 130,"sturn" = 220,"wturn" = 230,"eturn" = 130,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

//................ Psydonian Greatsword ............... //
/obj/item/weapon/sword/long/greatsword/psydon
	name = "psydonian gran espada"
	desc = "Una poderosa gran espada plateada diseñada para infundir miedo en el corazon incluso de los Archidemonios."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "psygsword"
	force_wielded = DAMAGE_LONGSWORD_WIELD
	gripped_intents = list(SWORD_CUT, SWDLONG_THRUST, SWORD_STRIKE, SWDLONG_CHOP)
	smeltresult = /obj/item/ingot/silverblessed
	melt_amount = 150
	sellprice = 150
	item_weight = 2.5 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/psydon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)

/obj/item/weapon/sword/long/greatsword/psydon/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 85,"sturn" = 265,"wturn" = 275,"eturn" = 85,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 4,"sflip" = 4,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/sword/long/greatsword/psydon/relic
	name = "\proper Cruzada"
	desc = "La hoja mas grandiosa del Ordo Benetarus. Su fuerza incomparable hace caer incluso al mayor de los enemigos. Atraviesa lo impio en nombre de Psydon. Que ninguno sobreviva."
	icon_state = "psygsword"
	force = DAMAGE_SWORD_WIELD
	possible_item_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_STRIKE)
	gripped_intents = list(SWORD_CUT, SWORD_THRUST, SWDLONG_CHOP)
	item_weight = 2.5 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/psydon/relic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/psyblessed, TRUE, 5, 100, 100, 1, TRUE)

/obj/item/weapon/sword/long/broadsword/psy
	name = "viejo sable psydonian"
	desc = "Incluso los fanaticos mas ignorantes saben que la plata sagrada pierde sus propiedades cuando no es bendecida por los sacerdotes durante un periodo prolongado de tiempo. Sin embargo, su ventaja sigue siendo tan letal como siempre."
	icon = 'icons/roguetown/weapons/64/psydonite.dmi'
	icon_state = "psybroadsword"
	smeltresult = /obj/item/ingot/silver
	melt_amount = 150
	item_weight = 2.5 KILOGRAMS

/obj/item/weapon/sword/long/broadsword/psy/relic
	name = "\proper Credo"
	desc = "Bañada en oraciones Psydonian, esta espada grande y pesada existe para matar al inhumen y al mal. El psycross de la cruceta esta grabado con oraciones del Ordo Benetarus. Tu eres la luz: muestrales el camino."
	item_weight = 2.5 KILOGRAMS
	smeltresult = /obj/item/ingot/silverblessed

/obj/item/weapon/sword/long/broadsword/psy/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.5, "sx" = -14, "sy" = -8, "nx" = 15, "ny" = -7, "wx" = -10, "wy" = -5, "ex" = 7, "ey" = -6, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = -13, "sturn" = 110, "wturn" = -60, "eturn" = -30, "nflip" = 1, "sflip" = 1, "wflip" = 8, "eflip" = 1)
			if("wielded") return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback") return list("shrink" = 0.5, "sx" = -1, "sy" = 2, "nx" = 0, "ny" = 2, "wx" = 2, "wy" = 1, "ex" = 0, "ey" = 1, "nturn" = 0, "sturn" = 0, "wturn" = 70, "eturn" = 15, "nflip" = 1, "sflip" = 1, "wflip" = 1, "eflip" = 1, "northabove" = 1, "southabove" = 0, "eastabove" = 0, "westabove" = 0)
			if("onbelt") return list("shrink" = 0.3, "sx" = -4, "sy" = -6, "nx" = 5, "ny" = -6, "wx" = 0, "wy" = -6, "ex" = -1, "ey" = -6, "nturn" = 100, "sturn" = 156, "wturn" = 90, "eturn" = 180, "nflip" = 0, "sflip" = 0, "wflip" = 0, "eflip" = 0, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0)

/obj/item/weapon/sword/long/broadsword/psy/relic/Initialize(mapload)
	. = ..()					//Pre-blessed, +5 DMG, +100 Blade int, +100 int, +2 def, make it silver
	AddComponent(/datum/component/psyblessed, TRUE, 5, 100, 100, 2, TRUE)

/obj/item/weapon/sword/long/greatsword/psydon/unforgotten
	name = "espada inolvidable"
	desc = "El Alto Inquisidor Archibald registro una vez una expedicion de siete valientes miembros de la orden a los paramos nevados del este para erradicar el mal. Se dice que su lider, el Santo computadora Guillemin, resistio durante siete dias y siete noches contra herejes vestidos de acero oscuro antes de que Psydon reconociera su resistencia. No quedo nada mas que su espada: su psycross envuelto alrededor de su empuñadura en recuerdo."
	icon_state = "forgottenblade"
	item_weight = 2.5 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/psydon/unforgotten/Initialize()
	. = ..()					//+50 Blade int, +3 DMG, +50 int, +1 def, make it silver
	AddComponent(/datum/component/psyblessed, FALSE, 3, 50, 50, 1, TRUE)

//................ Flamberge ............... //
/obj/item/weapon/sword/long/greatsword/flamberge
	name = "flamberge"
	desc = "Comunmente conocida como espada de hoja de fuego, esta arma tiene una hoja ondulante. Su forma ondulada distribuye mejor la fuerza y ​​es menos probable que se rompa con el impacto."
	icon_state = "flamberge"
	gripped_intents = list(SWORD_CUT, SWDLONG_THRUST, SWORD_STRIKE, SWDLONG_CHOP)
	wbalance = DODGE_CHANCE_NORMAL
	melt_amount = 300
	sellprice = 120
	item_weight = 2.8 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/zwei
	name = "zweihander"
	desc = "A veces conocida como doppelhander o beidhander, el tamaño de esta arma es tan impresionante que sus propiedades de manejo se parecen mas a las de un arma de asta que a las de una espada."
	icon_state = "steelzwei_sk"
	force_wielded = DAMAGE_LONGSWORD_WIELD
	possible_item_intents = list(ZWEI_CUT, ZWEI_THRUST, SWORD_STRIKE)
	gripped_intents = list(ZWEI_CUT_REACH, SWDLONG_THRUST, SWORD_STRIKE, SWDLONG_CHOP)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	melt_amount = 225
	sellprice = 60
	item_weight = 3 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/zwei/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 85,"sturn" = 265,"wturn" = 275,"eturn" = 85,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 4,"sflip" = 4,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/sword/long/greatsword/zwei/steel
	name = "zweihander de acero"
	desc = "Un zweihander forjado en acero, el orgullo y la alegria de cualquier mercenario que lo empuñe. Parece que podria partir a un hombre por la mitad con un solo golpe."
	icon_state = "steelzwei"
	force_wielded = DAMAGE_LONGSWORD_WIELD + 2
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST
	smeltresult = /obj/item/ingot/steel
	sellprice = 90

//................ Kriegsmesser ............... //
/obj/item/weapon/sword/long/greatsword/elfgsword
	name = "kriegsmesser elfo"
	desc = "Una enorme espada elfica curva. Su metal es de alta calidad, pero aun asi liviano, elaborado por los mejores herreros elficos."
	icon_state = "kriegsmesser"
	sellprice = 120
	item_weight = 2.3 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/elfgsword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 85,"sturn" = 265,"wturn" = 275,"eturn" = 85,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 4,"sflip" = 4,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

//................ Zizo Sword ............... //
/obj/item/weapon/sword/long/greatsword/zizo
	name = "kriegsmesser de acero oscuro"
	desc = "Una hoja curva de color rojo oscuro. Invocado por Su voluntad, si empuñas esta espada debes ser temido, si no lo haces, estas muerto."
	icon_state = "zizosword"
	wdefense = ULTMATE_PARRY
	sellprice = 0 // Super evil Zizo sword, nobody wants this
	item_weight = 2.3 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/zizo/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 130,"sturn" = 220,"wturn" = 230,"eturn" = 130,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 4,"sflip" = 4,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

//................ Claymores ............... //

/obj/item/weapon/sword/long/greatsword/claymore/iron
	name = "Claymore de hierro"
	desc = "Una gran espada originaria del norte, comunmente utilizada por los ravoxianos."
	icon_state = "ironclaymore"
	force_wielded = DAMAGE_LONGSWORD_WIELD
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ingot/iron
	sellprice = 90
	item_weight = 2.8 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/claymore/iron/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.67,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.67,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.67,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.67,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


/obj/item/weapon/sword/long/greatsword/claymore
	name = "Claymore de acero"
	desc = "Una variante de acero del Claymore estandar."
	icon_state = "steelclaymore"
	gripped_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_STRIKE, SWDLONG_CHOP)
	sellprice = 110
	item_weight = 2.7 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/claymore/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.67,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.67,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.67,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.67,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/weapon/sword/long/greatsword/claymore/silver
	name = "espada de plata"
	desc = " Una espada ancha plateada, ancha y pesada, para cortar en cubitos las hordas de muertos vivientes."
	icon_state = "silverbroadsword"
	max_integrity = INTEGRITY_STRONGEST * 0.8
	alt_intents = null
	smeltresult = /obj/item/ingot/silver
	melt_amount = 200
	sellprice = 150
	item_weight = 2.9 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/claymore/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/long/greatsword/claymore/silver/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.5, "sx" = -14, "sy" = -8, "nx" = 15, "ny" = -7, "wx" = -10, "wy" = -5, "ex" = 7, "ey" = -6, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = -13, "sturn" = 110, "wturn" = -60, "eturn" = -30, "nflip" = 1, "sflip" = 1, "wflip" = 8, "eflip" = 1)
			if("wielded") return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback") return list("shrink" = 0.5, "sx" = -1, "sy" = 2, "nx" = 0, "ny" = 2, "wx" = 2, "wy" = 1, "ex" = 0, "ey" = 1, "nturn" = 0, "sturn" = 0, "wturn" = 70, "eturn" = 15, "nflip" = 1, "sflip" = 1, "wflip" = 1, "eflip" = 1, "northabove" = 1, "southabove" = 0, "eastabove" = 0, "westabove" = 0)

/obj/item/weapon/sword/long/greatsword/claymore/gold //Uncraftable
	name = "Claymore ravoxiano"
	desc = "Una enorme espada construida con acero y oro, empuñada por ciertos Templarios de la Orden Ravoxiana."
	icon_state = "gsclaymore"
	max_blade_int = INTEGRITY_STRONG + 50
	sellprice = 200
	item_weight = 2.8 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/claymore/gold/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.67,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.67,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.67,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.67,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


/obj/item/weapon/sword/long/greatsword/gutsclaymore
	name = "espada frenetica"
	desc = "Una espada enorme construida con una losa de hierro."
	icon_state = "gutsclaymore"
	bigboy = TRUE
	force_wielded = DAMAGE_GREATSWORD_WIELD + 2
	wdefense = ULTMATE_PARRY
	possible_item_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_STRIKE)
	gripped_intents = list(GUTS_CUT, GUTS_THRUST, GUTS_STRIKE, GUTS_CHOP)
	max_blade_int = INTEGRITY_STRONG + 50
	max_integrity = INTEGRITY_STRONGEST
	minstr = 15
	sellprice = 240
	item_weight = 4 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/gutsclaymore/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.7,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.7,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


/obj/item/weapon/sword/long/greatsword/gutsclaymore/silverslab

	name = "\proper cazador de volfs"
	desc = "Se decia que su anterior portador habia matado a un hombre lobo de un solo golpe, dividiendo a la bestia en dos."
	icon_state = "machaslayer"
	force_wielded = DAMAGE_GREATSWORD_WIELD + 2
	max_blade_int = INTEGRITY_STRONG + 50
	max_integrity = INTEGRITY_STRONGEST
	sellprice = 500
	item_weight = 12 KILOGRAMS

/obj/item/weapon/sword/long/greatsword/gutsclaymore/silverslab/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/sword/long/greatsword/gutsclaymore/silverslab/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("altgrip")
				return list("shrink" = 0.6,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 167,"sturn" = 290,"wturn" = 120,"eturn" = 150,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


//................ Executioners Sword ............... //
/obj/item/weapon/sword/long/exe
	name = "espada del verdugo"
	icon_state = "exe"
	desc = "Una espada antigua de enorme estatura, con una punta redondeada. El orgullo y la alegria del mayor pasatiempo de Vanderlin, las ejecuciones."
	force_wielded = DAMAGE_GREATSWORD_WIELD + 4
	possible_item_intents = list(SWORD_STRIKE, SWORD_CUT)
	gripped_intents = list(SWORD_CUT, SWDLONG_CHOP, SWORD_STRIKE, SWORD_CLEAVE)
	slot_flags = ITEM_SLOT_BACK
	item_weight = 3.5 KILOGRAMS

/obj/item/weapon/sword/long/exe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -50,"sturn" = 40,"wturn" = 50,"eturn" = -50,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = 6,"nx" = 6,"ny" = 7,"wx" = 0,"wy" = 5,"ex" = -1,"ey" = 7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 130,"sturn" = 220,"wturn" = 230,"eturn" = 130,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 9,"sy" = -4,"nx" = -7,"ny" = 1,"wx" = -9,"wy" = 2,"ex" = 10,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 5,"sturn" = -190,"wturn" = -170,"eturn" = -10,"nflip" = 8,"sflip" = 8,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 3,"nx" = -1,"ny" = 2,"wx" = 3,"wy" = 4,"ex" = -1,"ey" = 5,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 20,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/sword/long/exe/astrata
	name = "juez solar"
	desc = "La espada de este malvado verdugo exige orden."
	icon = 'icons/roguetown/weapons/64/patron.dmi'
	icon_state = "astratasword"
	item_weight = 3.5 KILOGRAMS

/obj/item/weapon/sword/long/exe/silver
	name = "espada de verdugo de plata"
	desc = "Una espada de verdugo hecha de plata, que se usa mejor contra las bestias de la noche, para hacerlas descansar."
	icon_state = "silverexealt"
	item_weight = 3.5 KILOGRAMS

/obj/item/weapon/sword/long/exe/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Terminus Est ............... //
/obj/item/weapon/sword/long/exe/cloth
	icon_state = "terminusest"
	name = "Terminus Est"
	item_weight = 3.5 KILOGRAMS

/obj/item/weapon/sword/long/exe/cloth/attack_self_secondary(mob/user, list/modifiers)
	// . = ..()
	// if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
	// 	return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(user, "clothwipe", 100, TRUE)
	SEND_SIGNAL(src, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_SCRUB)
	user.visible_message("<span class='warning'>[user] limpia [src] con su paño.</span>", "<span class='notice'>Yo limpio [src] con su tela.</span>")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

// Copper Messer

/obj/item/weapon/sword/coppermesser
	name = "cupro messer"
	desc = "Un arma de guerra de tiempos mas simples, su material de cobre no es ideal pero sigue siendo eficiente por el precio."
	icon_state = "cmesser"
	item_state = "cmesser"
	force = DAMAGE_SWORD - 5 // Messers are heavy weapons, crude and STR based.
	force_wielded = DAMAGE_SWORD_WIELD - 5
	throwforce = DAMAGE_SWORD - 5
	wbalance = EASY_TO_DODGE
	wlength = WLENGTH_LONG
	possible_item_intents = list(SWORD_CUT, SWORD_STRIKE)
	gripped_intents = list(SWORD_CUT, SWORD_STRIKE, SWORD_CHOP)
	max_blade_int = 100
	max_integrity = INTEGRITY_STANDARD

	lefthand_file = 'icons/mob/inhands/weapons/roguebig_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/roguebig_righthand.dmi'
	swingsound = BLADEWOOSH_LARGE
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	smeltresult = /obj/item/ingot/copper
	sellprice = 10
	item_weight = 1.8 KILOGRAMS

/obj/item/weapon/sword/coppermesser/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("altgrip")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 270,"sturn" = 90,"wturn" = 100,"eturn" = 261,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/sword/long/rider/copper
	name = "hoz de cobre"
	desc = "Una \"espada\" especial de cobre, el material no es el mejor pero es lo suficientemente bueno para cortar y matar."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "copperfalx"
	item_state = "copperfalx"
	force = DAMAGE_SWORD - 10
	force_wielded = DAMAGE_SWORD_WIELD - 5
	throwforce = DAMAGE_SWORD - 5
	gripped_intents = list(SWORD_CUT, SWORD_STRIKE)
	max_blade_int = 100 // Shitty Weapon
	max_integrity = INTEGRITY_STANDARD

	parrysound = "sword"
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	slot_flags = ITEM_SLOT_BACK//how the fuck you could put this thing on your hip?
	smeltresult = /obj/item/ingot/copper
	sellprice = 25//lets make the two bars worth it
	item_weight = 1.6 KILOGRAMS

/obj/item/weapon/sword/rapier/ironestoc
	name = "estoc"
	desc = "Una espada de hoja bastante larga y afilada, diseñada para penetrar entre los \
	huecos de la armadura de un oponente. La empuñadura esta ceñida con cuero negro."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "estoc"
	force = DAMAGE_SWORD - 8
	force_wielded = DAMAGE_SWORD
	wdefense = GREAT_PARRY
	wbalance = DODGE_CHANCE_NORMAL
	wlength = WLENGTH_GREAT
	possible_item_intents = list(SWORD_CHOP, SWORD_STRIKE)
	gripped_intents = list(ESTOC_THRUST, ESTOC_LUNGE, SWORD_CHOP, SWORD_STRIKE)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG

	inhand_x_dimension = 64
	inhand_y_dimension = 64
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/ingot/iron
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/estoc/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.6,
					"sx" = -6,
					"sy" = 7,
					"nx" = 6,
					"ny" = 8,
					"wx" = 0,
					"wy" = 6,
					"ex" = -1,
					"ey" = 8,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = -50,
					"sturn" = 40,
					"wturn" = 50,
					"eturn" = -50,
					"nflip" = 0,
					"sflip" = 8,
					"wflip" = 8,
					"eflip" = 0,
					)
			if("wielded")
				return list(
					"shrink" = 0.6,
					"sx" = 3,
					"sy" = 5,
					"nx" = -3,
					"ny" = 5,
					"wx" = -9,
					"wy" = 4,
					"ex" = 9,
					"ey" = 1,
					"northabove" = 0,
					"southabove" = 1,
					"eastabove" = 1,
					"westabove" = 0,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 15,
					"nflip" = 8,
					"sflip" = 0,
					"wflip" = 8,
					"eflip" = 0,
					)

/obj/item/weapon/sword/gladius
	name = "gladius"
	desc = "Una espada corta de bronce con un extremo ligeramente mas ancho y sin guarda. Complementa un escudo."
	icon_state = "gladius"
	force = DAMAGE_SWORD + 2
	force_wielded = 0
	wdefense = AVERAGE_PARRY
	gripped_intents = null
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD

	smeltresult = /obj/item/ingot/bronze
	item_weight = 700 GRAMS

//A weapon meant to be used with two hands.
/obj/item/weapon/sword/katana
	name = "katana"
	desc = "Una espada extranjera."
	icon_state = "eastsword1"
	force_wielded = DAMAGE_SWORD_WIELD + 3
	wdefense = GOOD_PARRY
	possible_item_intents = list(KATANA_ONEHAND, SWORD_STRIKE)
	gripped_intents = list(KATANA_CUT, KATANA_ARC, SWORD_STRIKE, PRECISION_CUT)
	alt_intents = null

	parrysound = "bladedmedium"
	pickup_sound = "brandish_blade"
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	melt_amount = 75
	smeltresult = /obj/item/ingot/steel_slag
	item_weight = 1.1 KILOGRAMS

/obj/item/weapon/sword/katana/mulyeog
	name = "hoja recta extranjera"
	desc = "Una espada extranjera utilizada por asesinos y matones. Hay una borla roja en la empuñadura."
	icon_state = "eastsword1"

/obj/item/weapon/sword/katana/mulyeog/rumahench
	name = "espada hwang"
	desc = "Una espada de acero extranjera con patrones de nubes en la ranura."
	icon_state = "eastsword2"

/obj/item/weapon/sword/katana/mulyeog/rumacaptain
	name = "samjeongdo"
	desc = "Una hoja teñida de oro, con patrones de nubes en la acanaladura. Unica en su clase."
	icon_state = "eastsword3"
	force = DAMAGE_SWORD + 3
	wdefense = GREAT_PARRY

/obj/item/weapon/sword/sabre/hook
	name = "espada de gancho"
	desc = "Una espada de acero con un diseño de gancho en la punta; perfecto para desarmar enemigos. Su borde posterior esta afilado y la empuñadura parece tener una punta afilada."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "hook_sword"
	possible_item_intents = list(SWORD_CUT, CURVED_THRUST, SWORD_STRIKE, SWORD_DISARM)
	max_integrity = INTEGRITY_STRONG
	item_weight = 1 KILOGRAMS

/obj/item/weapon/sword/sabre/hook/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list(
				"shrink" = 0.5,
				"sx" = -14,
				"sy" = -8,
				"nx" = 15,
				"ny" = -7,
				"wx" = -10,
				"wy" = -5,
				"ex" = 7,
				"ey" = -6,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				"nturn" = -13,
				"sturn" = 110,
				"wturn" = -60,
				"eturn" = -30,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 8,
				"eflip" = 1,
				)
			if("onback") return list(
				"shrink" = 0.5,
				"sx" = -1,
				"sy" = 2,
				"nx" = 0,
				"ny" = 2,
				"wx" = 2,
				"wy" = 1,
				"ex" = 0,
				"ey" = 1,
				"nturn" = 0,
				"sturn" = 0,
				"wturn" = 70,
				"eturn" = 15,
				"nflip" = 1,
				"sflip" = 1,
				"wflip" = 1,
				"eflip" = 1,
				"northabove" = 1,
				"southabove" = 0,
				"eastabove" = 0,
				"westabove" = 0,
				)
			if("onbelt") return list(
				"shrink" = 0.4,
				"sx" = -4,
				"sy" = -6,
				"nx" = 5,
				"ny" = -6,
				"wx" = 0,
				"wy" = -6,
				"ex" = -1,
				"ey" = -6,
				"nturn" = 100,
				"sturn" = 156,
				"wturn" = 90,
				"eturn" = 180,
				"nflip" = 0,
				"sflip" = 0,
				"wflip" = 0,
				"eflip" = 0,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				)


//Snowflake version of hand-targeting disarm intent.
/datum/intent/sword/disarm
	name = "desarme"
	icon_state = "intake"
	animname = "strike"
	blade_class = null	//We don't use a blade class because it has on damage.
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	penfactor = -100
	swingdelay = 2	//Small delay to hook
	damfactor = 0.1	//No real damage
	clickcd = 22	//Can't spam this; long delay.
	blade_class = BCLASS_BLUNT

/obj/item/weapon/sword/sabre/hook/attack(mob/living/M, mob/living/user, list/modifiers)
	. = ..()
	var/skill_diff = 0
	if(istype(user.used_intent, /datum/intent/sword/disarm))
		var/obj/item/I
		if(user.zone_selected == BODY_ZONE_PRECISE_L_HAND && M.active_hand_index == 1)
			I = M.get_active_held_item()
		else
			if(user.zone_selected == BODY_ZONE_PRECISE_R_HAND && M.active_hand_index == 2)
				I = M.get_active_held_item()
			else
				I = M.get_inactive_held_item()
		if(user.mind)
			skill_diff += (GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/combat/swords))	//You check your sword skill
		if(M.mind)
			skill_diff -= (GET_MOB_SKILL_VALUE_OLD(M, /datum/attribute/skill/combat/wrestling))	//They check their wrestling skill to stop the weapon from being pulled.
		user.adjust_stamina(-rand(3,8))
		var/probby = clamp((((3 + (((GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) - GET_MOB_ATTRIBUTE_VALUE(M, STAT_STRENGTH))/4) + skill_diff)) * 10)), 5, 95)
		if(I)
			if(M.mind)
				if(I.associated_skill)
					probby -= GET_MOB_SKILL_VALUE_OLD(M, I.associated_skill) * 5
			var/obj/item/mainhand = user.get_active_held_item()
			var/obj/item/offhand = user.get_inactive_held_item()
			if(HAS_TRAIT(src, TRAIT_DUALWIELDER) && istype(offhand, mainhand))
				probby += 20	//We give notable bonus to dual-wielders who use two hooked swords.
			if(prob(probby))
				M.dropItemToGround(I, force = FALSE, silent = FALSE)
				user.stop_pulling()
				user.put_in_inactive_hand(I)
				M.visible_message(span_danger("¡[user] toma [I] de la mano de [M]!"), \
				span_userdanger("¡[user] se lleva [I] de mi mano!"), span_hear("¡Escucho un sonido desagradable de puñetazo!"), COMBAT_MESSAGE_RANGE)
				user.changeNext_move(12)//avoids instantly attacking with the new weapon
				playsound(src, 'sound/combat/weaponr1.ogg', 100, FALSE, -1) //sound queue to let them know that they got disarmed
				if(!M.mind)	//If you hit an NPC - they pick up weapons instantly. So, we do more stuff.
					M.Stun(10)
			else
				probby += 20
				if(prob(probby))
					M.dropItemToGround(I, force = FALSE, silent = FALSE)
					M.visible_message(span_danger("¡[user] desarma [M] de [I]!"), \
					span_userdanger("[user] me desarme de [I] ¡!"), span_hear("¡Escucho un sonido desagradable de puñetazo!"), COMBAT_MESSAGE_RANGE)
					if(!M.mind)
						M.Stun(20)	//high delay to pick up weapon
					else
						M.Stun(6)	//slight delay to pick up the weapon
				else
					user.Immobilize(10)
					M.Immobilize(10)
					M.visible_message(span_notice("¡[user.name] lucha por desarmar a [M.name]!"))
					playsound(src, 'sound/foley/struggle.ogg', 100, FALSE, -1)
		if(!isliving(M))
			to_chat(user, span_warning("¡No puedes desarmar a este enemigo!"))
			return
		else
			to_chat(user, span_warning("¡No tienen nada en esa mano!"))
			return


/obj/item/weapon/sword/long/martyr
	name = "espada martir"
	desc = "Una reliquia transmitida de generacion en generacion de fieles. Rebosa energias divinas y solo cedera en manos de aquellos que han hecho el juramento."
	icon = 'icons/roguetown/weapons/64/swords.dmi'
	icon_state = "martyrsword"
	item_state = "martyrsword"
	force = DAMAGE_GREATSWORD_WIELD
	force_wielded = DAMAGE_GREATSWORD_WIELD + 6
	throwforce = DAMAGE_SWORD - 5
	possible_item_intents = list(SWORD_CUT, SWORD_THRUST, SWORD_STRIKE)
	gripped_intents = list(/datum/intent/sword/cut/martyr, /datum/intent/sword/thrust/martyr, /datum/intent/sword/strike/martyr,/datum/intent/sword/chop/martyr)

	parrysound = "bladedmedium"
	pickup_sound = 'sound/foley/equip/swordlarge2.ogg'
	smeltresult = /obj/item/ingot/gold
	item_weight = 2.2 KILOGRAMS

/datum/intent/sword/cut/martyr
		item_damage_type = "fire"
		blade_class = BCLASS_CUT
/datum/intent/sword/thrust/martyr
		item_damage_type = "fire"
		blade_class = BCLASS_PICK // so our armor-piercing attacks in ult mode can do crits(against most armors, not having crit)
/datum/intent/sword/strike/martyr
		item_damage_type = "fire"
		blade_class = BCLASS_SMASH
/datum/intent/sword/chop/martyr
		item_damage_type = "fire"
		blade_class = BCLASS_CHOP


/obj/item/weapon/sword/long/martyr/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.6,"sx" = -14,"sy" = -8,"nx" = 15,"ny" = -7,"wx" = -10,"wy" = -5,"ex" = 7,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -13,"sturn" = 110,"wturn" = -60,"eturn" = -30,"nflip" = 1,"sflip" = 1,"wflip" = 8,"eflip" = 1)
			if("onback") return list("shrink" = 0.6,"sx" = -2,"sy" = 3,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 90,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("wielded") return list("shrink" = 0.7,"sx" = 6,"sy" = -2,"nx" = -4,"ny" = 2,"wx" = -8,"wy" = -1,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = -200,"wturn" = -160,"eturn" = -25,"nflip" = 8,"sflip" = 8,"wflip" = 0,"eflip" = 0)
			if("onbelt") return list("shrink" = 0.6,"sx" = -2,"sy" = -5,"nx" = 0,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = -3,"ey" = -5,"nturn" = 180,"sturn" = 180,"wturn" = 0,"eturn" = 90,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
