/obj/item/gem_device
	name = "rontz"
	icon_state = "ruby_cut"
	icon = 'icons/roguetown/items/gems.dmi'
	desc = "Sus facetas brillan tanto..."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	var/usage_prompt
	resistance_flags = FIRE_PROOF

/obj/item/gem_device/attack_self(mob/living/user, list/modifiers)
	var/alert = tgui_alert(user, "¿Quiero usar esto? \n[usage_prompt]", "Gema encantada", list("Si", "No"))
	if(alert != "Yes")
		return
	if(!on_use(user))
		to_chat(user, span_warning("\The [src] brilla y luego se desvanece."))
		return
	to_chat(user, span_warning("¡Con una chispa brillante \the [src] desaparece!"))
	qdel(src)

/obj/item/gem_device/proc/on_use(mob/living/user)
	return FALSE

/obj/item/gem_device/goldface
	name = "gemerald"
	icon_state = "emerald_cut"
	desc = "Destellos con brillo verde."
	usage_prompt = "Invocar cara de oro"

/obj/item/gem_device/goldface/on_use(mob/living/user)
	var/turf/step_turf = get_step(get_turf(user), user.dir)
	do_sparks(3, TRUE, step_turf)
	new /obj/structure/fake_machine/merchantvend(step_turf)
	to_chat(user, span_notice("¡Con un brillante destello, aparece un GOLDFACE frente a ti!"))
	return TRUE
