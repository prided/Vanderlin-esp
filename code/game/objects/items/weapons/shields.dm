#define SHIELD_BANG_COOLDOWN (3 SECONDS)

/obj/item/weapon/shield
	name = ""
	desc = ""
	icon_state = ""
	icon = 'icons/roguetown/weapons/32/shields.dmi'
	slot_flags = ITEM_SLOT_BACK
	flags_1 = null
	force = DAMAGE_SHIELD
	throwforce = DAMAGE_SHIELD / 2
	wdefense = ULTMATE_PARRY
	throw_speed = 1
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	possible_item_intents = list(SHIELD_BASH, SHIELD_BLOCK)
	block_chance = 0
	sharpness = IS_BLUNT
	wlength = WLENGTH_SHORT
	resistance_flags = FLAMMABLE
	can_parry = TRUE
	associated_skill = /datum/attribute/skill/combat/shields
	destroy_sound = 'sound/foley/shielddestroy.ogg'
	var/coverage = 90
	parrysound = "parrywood"
	attacked_sound = "parrywood"
	max_integrity = INTEGRITY_WORST
	anvilrepair = /datum/attribute/skill/craft/armor_repair
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	item_weight = 2 KILOGRAMS
	COOLDOWN_DECLARE(shield_bang)
	var/design_chosen

// Shield banging
/obj/item/weapon/shield/attackby(obj/item/attackby_item, mob/user, list/modifiers)
	if(istype(attackby_item, /obj/item/weapon) && !istype(attackby_item, /obj/item/weapon/hammer))
		if(!COOLDOWN_FINISHED(src, shield_bang))
			return
		user.visible_message("<span class='danger'>[user] golpea [src] con [attackby_item]!</span>")
		playsound(user, 'sound/combat/shieldbang.ogg', 50, TRUE)
		COOLDOWN_START(src, shield_bang, SHIELD_BANG_COOLDOWN)
		return

	return ..()

/obj/item/weapon/shield/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "el proyectil", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, args)
	if(attack_type == THROWN_PROJECTILE_ATTACK || attack_type == PROJECTILE_ATTACK)
		if(istype(hitby, /obj/projectile))
			var/obj/projectile/P = hitby
			if(P.armor_penetration >= 80)
				owner.visible_message("<span class='danger'>La [hitby] espada atraviesa el [owner] [src]¡</span>")
				return 0
		if(owner.client?.chargedprog == 100 && owner.used_intent?.tranged)
			owner.visible_message("<span class='danger'>[owner] bloquea [hitby] con [src]!</span>")
			return 1
		else
			if(prob(coverage))
				owner.visible_message("<span class='danger'>[owner] bloquea [hitby] con [src]!</span>")
				return 1
	return 0

/obj/item/weapon/shield/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(design_chosen)
		return
	return choose_design(., user)

/obj/item/weapon/shield/proc/choose_design(proc_value, mob/user)
	design_chosen = TRUE
	return proc_value

/datum/intent/shield/bash
	name = "golpe"
	icon_state = "inbash"
	hitsound = list('sound/combat/shieldbash_wood.ogg')
	chargetime = 0
	item_damage_type = "blunt"

/datum/intent/shield/bash/metal
	hitsound = list('sound/combat/shieldbash_metal.ogg')

/datum/intent/shield/block
	name = "bloquear"
	icon_state = "inblock"
	tranged = 1 //we can't attack directly with this intent, but we can charge it
	tshield = 1
	chargetime = 5
	hitsound = list('sound/combat/shieldbash_wood.ogg')
	warnie = "shieldwarn"
	item_damage_type = "blunt"
	charge_pointer = 'icons/effects/mousemice/charge/shield_charging.dmi'
	charged_pointer = 'icons/effects/mousemice/charge/shield_charged.dmi'

/datum/intent/shield/block/metal
	hitsound = list('sound/combat/shieldbash_metal.ogg')

/obj/item/weapon/shield/wood
	name = "escudo de madera"
	desc = "Un escudo redondo de madera sencillo, blasonado y acolchado de cuero. \nCan bloquea excepcionalmente los ataques, pero es mas fragil que los de metal."
	icon_state = "woodsh"
	coverage = 60
	max_integrity = INTEGRITY_STANDARD - 25
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/shield/wood/choose_design(proc_value, mob/user)
	. = proc_value
	if(design_chosen)
		return

	if(isnull(GLOB.IconStates_cache['icons/roguetown/weapons/wood_heraldry.dmi']))
		GLOB.IconStates_cache['icons/roguetown/weapons/wood_heraldry.dmi'] = icon_states('icons/roguetown/weapons/wood_heraldry.dmi')

	var/picked_name = browser_input_list(user, "Choose a Heraldry", "Heraldry", GLOB.IconStates_cache['icons/roguetown/weapons/wood_heraldry.dmi'])
	if(!picked_name)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/wood_heraldry.dmi', picked_name)
	M.alpha = 178
	add_overlay(M)
	var/mutable_appearance/MU = mutable_appearance(icon, "woodsh_detail")
	MU.alpha = 114
	add_overlay(MU)

	design_chosen = TRUE
	if(tgui_alert(user, "¿Esta satisfecho con su heraldica?", "Heraldicia", DEFAULT_INPUT_CHOICES) != CHOICE_YES)
		cut_overlays()
		design_chosen = FALSE

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/weapon/shield/wood/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/shield/wood/adept/Initialize()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/weapon/shield/wood/adept/update_overlays()
	. = ..()
	var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/wood_heraldry.dmi', "Psydon")
	M.alpha = 174
	. += M
	M = mutable_appearance(icon, "woodsh_detail")
	. += M

/obj/item/weapon/shield/tower
	name = "escudo de la torre"
	desc = "Un gigantesco escudo reforzado con hierro que cubre todo el cuerpo, una copia del diseño de los escudos Aasimar de una epoca pasada."
	icon_state = "shield_tower"
	force = DAMAGE_SHIELD + 5
	throwforce = DAMAGE_SHIELD
	wdefense = ULTMATE_PARRY + 1
	wbalance = EASY_TO_DODGE // Heavy, big shield
	coverage = 65
	wlength = WLENGTH_NORMAL
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = INTEGRITY_STRONG
	melting_material = /datum/material/iron
	melt_amount = 75
	item_weight = 4 KILOGRAMS

/obj/item/weapon/shield/tower/spidershield
	name = "escudo de araña"
	desc = "Un escudo voluminoso de longitudes en forma de puas fundidas. Los motivos evocan todo menos seguridad y proteccion."
	icon = 'icons/roguetown/weapons/32/elven.dmi'
	icon_state = "spidershield"

/obj/item/weapon/shield/tower/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/shield/tower/hoplite
	name = "escudo antiguo"
	desc = "Un gigantesco escudo reforzado con bronce que cubre todo el cuerpo. Una reliquia Aasimar de una epoca pasada."
	icon_state = "boeotian"
	force = DAMAGE_SHIELD + 5
	wdefense = ULTMATE_PARRY + 3
	coverage = 75 // Rare shield from unique job, gets a tiny bit of additional coverage
	possible_item_intents = list(METAL_BASH, METAL_BLOCK)
	resistance_flags = FIRE_PROOF
	flags_1 = CONDUCT_1
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = INTEGRITY_STRONGEST
	melting_material = /datum/material/bronze
	sellprice = 150 // A noble collector would love to get their hands on one of these
	item_weight = 4 KILOGRAMS

/obj/item/weapon/shield/tower/hoplite/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/shield/tower/metal
	name = "escudo de cometa"
	desc = "Un escudo de acero caballeroso con forma de cometa y adornado con heraldica. \nBoasts cobertura y durabilidad superiores, debido a su exquisita artesania."
	icon_state = "ironsh"
	force = DAMAGE_SHIELD * 2
	wdefense = ULTMATE_PARRY + 2
	coverage = 70
	possible_item_intents = list(METAL_BASH, METAL_BLOCK)
	resistance_flags = FIRE_PROOF
	flags_1 = CONDUCT_1
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = INTEGRITY_STRONGEST
	sellprice = 30
	smeltresult = /obj/item/ingot/steel_slag
	melting_material = /datum/material/steel
	design_chosen = FALSE
	item_weight = 4 KILOGRAMS

/obj/item/weapon/shield/tower/metal/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
	return ..()

/obj/item/weapon/shield/tower/metal/choose_design(proc_value, user)
	. = proc_value
	if(design_chosen)
		return

	if(isnull(GLOB.IconStates_cache['icons/roguetown/weapons/shield_heraldry.dmi']))
		GLOB.IconStates_cache['icons/roguetown/weapons/shield_heraldry.dmi'] = icon_states('icons/roguetown/weapons/shield_heraldry.dmi')

	var/picked_name = browser_input_list(user, "Choose a Heraldry", "Heraldry", sortList(GLOB.IconStates_cache['icons/roguetown/weapons/shield_heraldry.dmi']))
	if(!picked_name)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/shield_heraldry.dmi', picked_name)
	M.alpha = 190
	add_overlay(M)
	var/mutable_appearance/MU = mutable_appearance(icon, "ironsh_detail")
	MU.alpha = 90
	add_overlay(MU)

	design_chosen = TRUE
	if(tgui_alert(user, "¿Esta satisfecho con su heraldica?", "Heraldicia", DEFAULT_INPUT_CHOICES) != CHOICE_YES)
		cut_overlays()
		design_chosen = FALSE

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef SHIELD_BANG_COOLDOWN

/obj/item/weapon/shield/tower/metal/ancient
	name = "escudo antiguo"
	desc = "Un antiguo escudo de acero con forma de cometa y caballero."
	icon_state = "ancientsh"

/obj/item/weapon/shield/tower/metal/psy
	name = "Pacto"
	desc = "El Ordo Benetarus tiene un mantra: un Psydonian perdura. Un Psydonian se conserva. A Psydonian preserva Su rebaño. Protegelos."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psyshield"
	wdefense = ULTMATE_PARRY + 3
	coverage = 50
	max_integrity = INTEGRITY_STRONG
	item_weight = 5 KILOGRAMS

/obj/item/weapon/shield/tower/metal/psy/Initialize(mapload)
	. = ..()							//+0 force, +100 int, +1 def, make silver
	AddComponent(/datum/component/psyblessed, TRUE, 0, FALSE, 100, 1, TRUE)

/obj/item/weapon/shield/tower/buckleriron
	name = "escudo de hierro"
	desc = "Un escudo de hierro de pequeño tamaño, popular entre los mercenarios debido a su peso ligero y facilidad de movilidad."
	icon_state = "ironbuckler"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	force = DAMAGE_SHIELD * 1.5
	wdefense = ULTMATE_PARRY
	wbalance = HARD_TO_DODGE // small, tiny shield
	coverage = 10
	max_integrity = INTEGRITY_STANDARD

	resistance_flags = FIRE_PROOF
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	item_weight = 0.7 KILOGRAMS

/obj/item/weapon/shield/tower/buckleriron/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/shield/tower/buckleriron/captain
	name = "Orden"
	desc = "Un escudo decorado con oro hecho especificamente para el Capitan junto con su armadura. Poner orden en las tierras con cada golpe desviado."
	icon_state = "capbuckler"
	sellprice = 60
	max_integrity = INTEGRITY_STRONG
	melting_material = /datum/material/steel
	wdefense = 7
	item_weight = 0.7 KILOGRAMS

/obj/item/weapon/shield/heater
	name = "escudo calentador"
	desc = "Un escudo resistente de madera y cuero. Hecho para no ser demasiado pesado y al mismo tiempo brindar una buena proteccion."
	icon_state = "heatershield"
	force = DAMAGE_SHIELD + 5
	throwforce = DAMAGE_SHIELD
	coverage = 60
	attacked_sound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = INTEGRITY_STANDARD
	item_weight = 1.4 KILOGRAMS

/obj/item/weapon/shield/heater/choose_design(proc_value, mob/user)
	. = proc_value
	if(design_chosen)
		return

	var/icon/icon_file = new('icons/roguetown/weapons/heater_heraldry.dmi')
	var/picked_name = browser_input_list(user, "Choose a Heraldry", "Heraldry", sortList(icon_file.IconStates()))
	if(!picked_name)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/heater_heraldry.dmi', picked_name)
	M.alpha = 178
	add_overlay(M)
	var/mutable_appearance/MU = mutable_appearance(icon, "heatershield_detail")
	MU.alpha = 114
	add_overlay(MU)

	design_chosen = TRUE
	if(tgui_alert(user, "¿Esta satisfecho con su heraldica?", "Heraldicia", DEFAULT_INPUT_CHOICES) != CHOICE_YES)
		cut_overlays()
		design_chosen = FALSE

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/weapon/shield/heater/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
