/obj/item/clothing/barding
	name = "barda acolchada"
	desc = "Un conjunto de chaleco antibalas acolchado para Saiga, diseñado para proteger los organos vitales de su montura."
	slot_flags = null
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "sewingkit"
	var/barding_icon = 'icons/roguetown/mob/monster/saiga.dmi'
	var/barding_state = "barding"
	var/female_barding_state = "barding-f"
	gender = NEUTER
	var/list/valid_animal_types = list(
		/mob/living/simple_animal/hostile/retaliate/saiga
	)
	armor_type = /datum/armor/padded/good
	max_integrity = ARMOR_INT_CHEST_LIGHT_MASTER
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = /datum/attribute/skill/misc/sewing/mending
	dyeable = TRUE
	salvage_result = /obj/item/natural/cloth
	salvage_amount = 1
	fiber_salvage = TRUE
	integrity_failure = 0.1
	item_weight = 3 KILOGRAMS

/obj/item/clothing/barding/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /mob/living/simple_animal))
		return NONE

	if(!is_type_in_list(interacting_with, valid_animal_types))
		to_chat(user, span_warning("¡\The [src] no se puede usar en [interacting_with]! ¡Solo esta destinado para animales especificos!"))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/simple_animal/animal = interacting_with
	if(animal.adult_growth)
		to_chat(user, span_warning("[animal] es un joven y no puede usar una bardana."))
		return ITEM_INTERACT_BLOCKING

	if(animal.bbarding)
		to_chat(user, span_warning("¡El [animal] ya esta usando una bardana!"))
		return ITEM_INTERACT_BLOCKING

	if(!animal.ssaddle)
		to_chat(user, span_warning("¡[animal] necesita ser montada antes de que puedas ponerle un barding!"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user] esta colocando una bardilla en [animal]..."), span_notice("Empiezo a ponerle una bardilla al [animal]..."))
	if(!do_after(user, 5 SECONDS, animal))
		return ITEM_INTERACT_BLOCKING

	animal.bbarding = src
	forceMove(animal)
	animal.update_appearance(UPDATE_ICON)
	user.visible_message(span_notice("[user] encaja un bardo en [animal]."), span_notice("Pongo una bardina a [animal]."))

	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/barding/atom_break(damage_flag)
	. = ..()
	if(istype(loc, /mob/living/simple_animal))
		var/mob/living/simple_animal/A = loc
		if(A.bbarding == src)
			A.bbarding = null
	. = ..()

/obj/item/clothing/barding/chain
	name = "barda de cota de malla"
	desc = "Un conjunto de armadura de cota de malla para un Saiga, diseñado para proteger los organos vitales de tu montura."
	icon_state = "armorkit"
	barding_state = "barding_chain"
	female_barding_state = "barding_chain-f"
	armor_type = /datum/armor/maille
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	anvilrepair = /datum/attribute/skill/craft/armor_repair
	smeltresult = /obj/item/ingot/steel_slag
	sewrepair = null
	salvage_result = null
	salvage_amount = 0
	fiber_salvage = FALSE
	item_weight = 8 KILOGRAMS

/obj/item/clothing/barding/honse
	name = "barda acolchada"
	desc = "Un conjunto de armadura acolchada para un Honse, diseñada para proteger los organos vitales de tu montura."
	icon_state = "sewingkit"
	barding_icon = 'icons/mob/monster/fogbeast.dmi'
	barding_state = "barding"
	female_barding_state = "barding"
	valid_animal_types = list(
		/mob/living/simple_animal/hostile/retaliate/honse
	)
	item_weight = 4 KILOGRAMS

/obj/item/clothing/barding/honse/chain
	name = "barda de cota de malla"
	desc = "Un conjunto de armadura de cota de malla para un Honse, diseñada para proteger los organos vitales de tu montura."
	icon_state = "armorkit"
	barding_state = "barding_chain"
	female_barding_state = "barding_chain"
	armor_type = /datum/armor/maille
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	anvilrepair = /datum/attribute/skill/craft/armor_repair
	melting_material = /datum/material/steel
	melt_amount = 80
	sewrepair = null
	salvage_result = null
	salvage_amount = 0
	fiber_salvage = FALSE
	item_weight = 10 KILOGRAMS
