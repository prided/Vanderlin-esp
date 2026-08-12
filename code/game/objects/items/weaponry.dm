/obj/item/banhammer
	desc = ""
	name = "martillo de baneo"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "toyhammer"
	slot_flags = ITEM_SLOT_HIP
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 7
	attack_verb = list("baneo")
	max_integrity = 200
	armor_type = /datum/armor/immune
	resistance_flags = FIRE_PROOF

/obj/item/banhammer/suicide_act(mob/user)
		user.visible_message("¡<span class='suicide'>[user] se esta golpeando a [user.p_them()]self con [src]! Parece que [user.p_theyre()] intenta prohibir a [user.p_them()]self de la vida.</span>")
		return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)
/*
oranges says: This is a meme relating to the english translation of the ss13 russian wiki page on lurkmore.
mrdoombringer sez: and remember kids, if you try and PR a fix for this item's grammar, you are admitting that you are, indeed, a newfriend.
for further reading, please see: https://github.com/tgstation/tgstation/pull/30173 and https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=%2F%2Flurkmore.to%2FSS13&edit-text=&act=url
*/
/obj/item/banhammer/attack(mob/M, mob/user, list/modifiers)
	if(user.zone_selected == BODY_ZONE_HEAD)
		M.visible_message("<span class='danger'>[user] esta acariciando la cabeza de [M] con un martillo de banear.</span>", "<span class='danger'>[user] me esta acariciando la cabeza con un martillo de prohibicion.</span>", "<span class='hear'>Escucho un banhammer acariciando una cabeza.</span>")
	else
		M.visible_message("<span class='danger'>[M] ha sido baneado POR NO REISIN por [user]!</span>", "<span class='danger'>¡Me han expulsado por NO REISIN por [user]¡</span>", "<span class='hear'>Escucho un banhammer prohibiendo a alguien.</span>")
	playsound(src, 'sound/blank.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much
	if(user.used_intent.type != INTENT_HELP)
		return ..(M, user)

/obj/item/throwing_star
	name = "estrella arrojadiza"
	desc = ""
	icon_state = "throwingstar"
	item_state = "eshield0"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	force = 2
	throwforce = 20 //20 + 2 (WEIGHT_CLASS_SMALL) * 4 (EMBEDDED_IMPACT_PAIN_MULTIPLIER) = 28 damage on hit due to guaranteed embedding
	throw_speed = 4
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 100, "embedded_fall_chance" = 0)
	w_class = WEIGHT_CLASS_SMALL
	sharpness = IS_SHARP
	resistance_flags = FIRE_PROOF

	grid_height = 32
	grid_width = 32

/obj/item/throwing_star/ninja
	name = "estrella arrojadiza ninja"
	throwforce = 30
	embedding = list("embedded_pain_multiplier" = 6, "embed_chance" = 100, "embedded_fall_chance" = 0)

/obj/item/staff
	name = "baston de mago"
	desc = ""
	icon = 'icons/obj/wizard.dmi'
	icon_state = "staff"
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	armor_penetration = 100
	attack_verb = list("apaleado", "aporreado", "disciplinado")
	resistance_flags = FLAMMABLE

/obj/item/staff/stick
	name = "palo"
	desc = ""
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cane"
	item_state = "stick"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
