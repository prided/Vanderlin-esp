/obj/item/phantom_ear
	name = "oreja fantasma"
	desc = "Un facsimil espectral de un oido."
	var/chat_icon = 'icons/Phantom_Ear_Icon.dmi'
	var/chat_icon_state = "sparkly_ear_icon"
	icon = 'icons/roguetown/misc/phantomear.dmi'
	icon_state = "ear_ring"
	invisibility = INVISIBILITY_LEYLINES
	w_class = WEIGHT_CLASS_TINY
	item_weight = 5 GRAMS
	var/hear_radius = 2
	var/muted = FALSE
	var/datum/weakref/linked_living

/obj/item/phantom_ear/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_RUNECHAT_HIDDEN, TRAIT_GENERIC)
	become_hearing_sensitive()

/obj/item/phantom_ear/proc/setup(mob/living/user)
	if(!istype(user))
		return
	linked_living = WEAKREF(user)

/obj/item/phantom_ear/Destroy()
	lose_hearing_sensitivity()
	linked_living = null
	return ..()

/obj/item/phantom_ear/proc/hurt_caster()
	var/mob/living/linked = linked_living?.resolve()
	if(linked)
		linked.add_stress(/datum/stress_event/ear_crushed)
		linked.emote("painscream")
		linked.Immobilize(10)
		linked.Knockdown(10)
		linked.apply_damage(15, BRUTE, BODY_ZONE_HEAD)

/obj/item/phantom_ear/proc/reset_visibility()
	if(!isturf(loc))
		return
	invisibility = initial(invisibility)

/obj/item/phantom_ear/proc/timed_delete()
	if(QDELETED(src))
		return
	src.visible_message(span_warning("¡El [src] escapa del alcance de este mundo!"))
	if(linked_living)
		to_chat(linked_living.resolve(), span_warning("Siento que se me quita la tension, ¡mi oreja fantasma ha escapado con exito!"))
	qdel(src)

/obj/item/phantom_ear/attack_hand(mob/user)
	. = ..()
	user.visible_message(span_warning("[user] lanza la mano de [user.p_their()] en el aire y la aprieta con fuerza, ¡mientras una oreja palida se materializa en su agarre!"))
	playsound(src, 'sound/vo/mobs/rat/rat_life.ogg', 100, FALSE, -1)
	name = "oreja fantasma"
	desc = "Un facsimil espectral de una oreja que se retuerce en la mano."
	icon_state = "round_round_ear"
	hear_radius = 0
	invisibility = NONE
	if(linked_living)
		to_chat(linked_living.resolve(), span_warning("Siento una extraña presion en el costado de mi cabeza."))
	addtimer(CALLBACK(src, PROC_REF(timed_delete)), 2 MINUTES)

/obj/item/phantom_ear/attack_self(mob/user, list/modifiers)
	if(user != linked_living?.resolve())
		user.visible_message(span_boldwarning("¡[user] aplasto a [src] con la mano [user.p_their()]!"))
		playsound(src, 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
		if(linked_living)
			hurt_caster()
			to_chat(linked_living.resolve(), span_boldwarning("¡Siento un dolor agudo en el costado de mi cabeza, mi oreja fantasma ha sido aplastada!"))
	else
		to_chat(user, span_warning("Disimulo y le doy un cachete al oido para deshacerlo."))
	qdel(src)

/obj/item/phantom_ear/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	src.visible_message(span_warning("¡El [src] se rompe contra el [hit_atom]!"))
	playsound(src, 'sound/magic/glass.ogg', 100, FALSE, -1)
	if(linked_living)
		hurt_caster()
		to_chat(linked_living.resolve(), span_boldwarning("¡Siento como cien agujas me atraviesan el costado de la cabeza, mi oido fantasma se ha roto!"))
	qdel(src)

/obj/item/phantom_ear/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	var/mob/owner = linked_living?.resolve()
	if(QDELETED(owner))
		qdel(src)
		return
	if(speaker == owner)
		if(findtext(raw_message, "deafen") && !muted)
			to_chat(owner, span_notice("Las voces en tu cabeza se calman."))
			muted = TRUE
			return
		else if(findtext(raw_message, "listen") && muted)
			to_chat(owner, span_notice("Te bombardean de nuevo con las voces del mundo."))
			muted = FALSE
			return
	if(speaker == src)
		return
	if(get_dist(speaker.loc, loc) > hear_radius)
		return
	if(muted)
		return
	if(!message || !linked_living)
		return
	to_chat(owner, "<img src='\ref[chat_icon]?state=[chat_icon_state]'/>" + " [message]")
	if(!isliving(speaker))
		return
	var/mob/living/living_speaker = speaker
	var/perception = GET_MOB_ATTRIBUTE_VALUE(living_speaker, STAT_PERCEPTION)
	if(invisibility && !living_speaker.is_blind() && living_speaker != owner && perception > 13)
		if(!prob(20 + ((perception - 14) * 5)))
			return
		to_chat(living_speaker, span_warning("No estamos solos, las paredes tienen oidos..."))
		name = "Aura fantasmal"
		desc = "Sientes una presencia extraña observandote..."
		invisibility = NONE
		addtimer(CALLBACK(src, PROC_REF(reset_visibility)), 5 SECONDS)
