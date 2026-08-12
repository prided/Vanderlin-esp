/obj/item/lipstick
	gender = PLURAL
	name = "lapiz labial rojo"
	desc = ""
	icon = 'icons/roguetown/items/perfume.dmi'
	icon_state = "lipstick"
	w_class = WEIGHT_CLASS_TINY
	item_weight = 20 GRAMS
	var/colour = "#821d2c"
	var/open = FALSE

/obj/item/lipstick/purple
	name = "lapiz labial morado"
	colour = "#3f1462"

/obj/item/lipstick/jade
	name = "jade lipstick"
	colour = "#0f5335"

/obj/item/lipstick/black
	name = "lapiz labial negro"
	colour = "#010517"

/obj/item/lipstick/green
	name = "lapiz labial verde"
	colour = "#27853c"

/obj/item/lipstick/blue
	name = "lapiz labial azul"
	colour = "#241e80"

/obj/item/lipstick/white
	name = "lapiz labial blanco"
	colour = "#efeff7"

/obj/item/lipstick/random
	name = "lapiz labial"
	icon_state = MAP_SWITCH("lipstick", "random_lipstick")

/obj/item/lipstick/random/Initialize()
	. = ..()
	colour = pick("#821d2c","#3f1462","#0f5335","#010517","#27853c","#241e80","#efeff7")
	name = "lapiz labial"

/obj/item/lipstick/update_icon_state()
	. = ..()
	icon_state = "lipstick[open ? "_uncap" : ""]"

/obj/item/lipstick/update_overlays()
	. = ..()
	if(open)
		var/mutable_appearance/colored_overlay = mutable_appearance(icon, "lipstick_uncap_color")
		colored_overlay.color = colour
		. += colored_overlay

/obj/item/lipstick/attack_self(mob/user, list/modifiers)
	to_chat(user, "<span class='notice'>Cambio el estado de \the [src] a [open ? "closed" : "open"].</span>")
	open = !open
	update_appearance(UPDATE_ICON)

/obj/item/lipstick/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with))
		return NONE

	if(!open)
		return ITEM_INTERACT_BLOCKING

	var/mob/living/carbon/human/H = interacting_with

	if(H.is_mouth_covered())
		to_chat(user, "<span class='warning'>Remove [ H == user ? "your" : "[H.p_their()]" ] mask!</span>")
		return ITEM_INTERACT_BLOCKING

	if(H.lip_style)	//if they already have lipstick on
		to_chat(user, "<span class='warning'>Primero tengo que quitar el lapiz labial viejo. </span>")
		return ITEM_INTERACT_BLOCKING

	if(H == user)
		user.visible_message(
			"<span class='notice'>[user] pinta los labios de [user.p_their()] con \the [src].</span>",
			"<span class='notice'>Me tomo un momento para aplicar \the [src]. ¡Perfecto!</span>",
		)
	else
		user.visible_message(
			"<span class='warning'>[user] comienza a maquillar los labios de [H] con \the [src].</span>",
			"<span class='notice'>Empiezo a aplicar \the [src] en los labios de [H]...</span>",
		)
		if(!do_after(user, 2 SECONDS, H))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(
			"<span class='notice'>[user] pinta los labios de [H] con \the [src].</span>",
			"<span class='notice'>Aplico \the [src] en los labios de [H].</span>",
		)

	H.lip_style = "lipstick"
	H.lip_color = colour
	H.update_body_parts()

	return ITEM_INTERACT_SUCCESS

//you can wipe off lipstick with paper!
/obj/item/paper/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with))
		return NONE

	if(user.zone_selected != BODY_ZONE_PRECISE_MOUTH)
		return NONE

	var/mob/living/carbon/human/H = interacting_with

	if(!H.lip_style)
		return NONE

	if(H == user)
		to_chat(user, "<span class='notice'>Me quito el lapiz labial con [src].</span>")
	else
		user.visible_message("<span class='warning'>[user] comienza a limpiar el labial de [H] con \the [src].</span>", \
							"<span class='notice'>Empiezo a limpiar el lapiz labial de [H]...</span>")
		if(do_after(user, 1 SECONDS, H))
			return ITEM_INTERACT_BLOCKING
		user.visible_message("<span class='notice'>[user] limpia el labial de [H] con \the [src].</span>", \
							"<span class='notice'>Borro el lapiz labial de [H].</span>")

	H.lip_style = null
	H.update_body_parts()

	return ITEM_INTERACT_SUCCESS
