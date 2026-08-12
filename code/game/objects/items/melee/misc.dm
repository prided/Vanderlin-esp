/obj/item/melee
	item_flags = NEEDS_PERMIT

/obj/item/melee/proc/check_martial_counter(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(target.check_block())
		target.visible_message("¡<span class='danger'>[target.name] bloquea [src] y gira el brazo de [user] detras de [user.p_their()] hacia atras!</span>",
					"<span class='danger'>¡Bloqueo el ataque!</span>")
		user.Stun(40)
		return TRUE
