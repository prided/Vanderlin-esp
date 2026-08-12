/* Kitchen tools
 * Contains:
 *		Fork
 *		Kitchen knives
 *		Ritual Knife
 *		Butcher's cleaver
 *		Combat Knife
 *		Rolling Pins
 *		Plastic Utensils
 */

/obj/item/kitchen/fork
	name = "tenedor"
	desc = "Un utensilio de madera con puas puntiagudas en el extremo. Te ayuda a comer sin ensuciarte las manos. "
	icon_state = "fork"
	force = 5
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 1
	throw_range = 5
	flags_1 = CONDUCT_1
	possible_item_intents = list(/datum/intent/food, /datum/intent/stab)
	attack_verb = list("ataco", "apuñalado", "pinchado")
	hitsound = 'sound/blank.ogg'
	armor_type = /datum/armor/fork
	item_weight = 30 GRAMS
	tool_behaviour = TOOL_FORK

/obj/item/kitchen/fork/suicide_act(mob/living/carbon/user)
	user.visible_message("¡<span class='suicide'>[user] apuñala a \the [src] en el cofre de [user.p_their()]! ¡Parece que [user.p_theyre()] intenta darle un mordisco a [user.p_them()]self!</span>")
	playsound(src, 'sound/blank.ogg', 50, TRUE)
	return BRUTELOSS

/obj/item/kitchen/fork/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.cmode)
		return NONE

	if(!istype(interacting_with, /obj/item/reagent_containers/food/snacks))
		return NONE

	var/obj/item/reagent_containers/food/snacks/S = interacting_with
	S.interact_with_atom(user, user)

	return ITEM_INTERACT_SUCCESS

/obj/item/kitchen/rollingpin
	name = "rodillo"
	desc = "Un alfiler de madera que se utiliza principalmente para dar forma y aplanar la masa para hornear."
	icon_state = "rolling_pin"
	item_state = "rolling_pin"
	slot_flags = ITEM_SLOT_HIP
	force = DAMAGE_CLUB - 1
	force_wielded = DAMAGE_CLUB_WIELD - 1
	throwforce = DAMAGE_CLUB / 2
	max_integrity = INTEGRITY_WORST
	associated_skill = /datum/attribute/skill/combat/axesmaces
	throw_speed = 1
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("golpeado", "aporreado", "apaleado", "azotado", "aporreado")
	custom_price = 5
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	possible_item_intents = list(/datum/intent/use, /datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/mace/strike/wood)
	smeltresult = /obj/item/fertilizer/ash
	experimental_inhand = TRUE
	item_weight = 500 GRAMS
	grid_height = 64
	grid_width = 32

/obj/item/kitchen/rollingpin/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
	return ..()

/obj/item/kitchen/rollingpin/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] comienza a aplanar la cabeza de [user.p_their()] con \the [src] ¡Parece que [user.p_theyre()] esta intentando suicidarse!</span>")
	return BRUTELOSS
