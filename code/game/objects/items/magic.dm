/////////////////////////////////////////Scrying///////////////////

/obj/item/scrying
	name = "orbe de vision"
	desc = "En sus profundidades de cristal, podras adivinar a muchos seres desprevenidos..."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state ="scrying"
	throw_speed = 3
	throw_range = 7
	throwforce = 15
	damtype = BURN
	force = 15
	hitsound = 'sound/blank.ogg'
	sellprice = 30
	dropshrink = 0.6

	grid_height = 32
	grid_width = 32
	item_weight = 400 GRAMS

	var/mob/current_owner
	var/last_scry
	var/cooldown = 30 SECONDS

/obj/item/scrying/eye
	name = "ojo maldito"
	desc = "Esta pulsando."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state ="scryeye"
	cooldown = 5 MINUTES
	item_weight = 200 GRAMS

/obj/item/scrying/attack_self(mob/user, list/modifiers)
	. = ..()
	if(world.time < last_scry + cooldown)
		to_chat(user, span_warning("Miro dentro de [src], pero solo veo humo negro. Tal vez deberia esperar."))
		return
	var/input = SANITIZE_HEAR_MESSAGE(html_decode(tgui_input_text(user, "¿A quien estas buscando?", "Esfera de adivinacion")))

	if(!input)
		return
	if(!user.key)
		return
	if(!user.mind || !user.mind.do_i_know(name=input))
		to_chat(user, span_warning("No conozco a nadie con ese nombre."))
		return
	//check is applied twice to prevent someone from bypassing the cooldown
	if(world.time < last_scry + cooldown)
		to_chat(user, span_warning("Miro dentro de [src], pero solo veo humo negro. Tal vez deberia esperar."))
		return
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.real_name == input)
			var/turf/T = get_turf(HL)
			if(!T)
				continue
			if(HAS_TRAIT(HL, TRAIT_ANTISCRYING))
				to_chat(user, span_warning("Miro dentro de [src], pero una niebla impenetrable envuelve [HL.real_name]."))
				to_chat(HL, span_warning("Mi envoltura magica reacciono a algo."))
				return
			log_game("SCRYING: [user.real_name] ([user.ckey]) has used the scrying orb to leer at [HL.real_name] ([HL.ckey])")
			ADD_TRAIT(user, TRAIT_NOSSDINDICATOR, "scryingorb")
			var/mob/dead/observer/screye/S = user.scry_ghost()
			if(!S)
				return
			S.ManualFollow(HL)
			last_scry = world.time
			user.visible_message(span_danger("[user] mira dentro de [src], los ojos de [p_their()] se enrollan hacia atras en la cabeza de [p_their()]."))
			addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 8 SECONDS)
			if(!HL.stat)
				if(GET_MOB_ATTRIBUTE_VALUE(HL, STAT_PERCEPTION) >= 15)
					if(HL.mind)
						if(HL.mind.do_i_know(name=user.real_name))
							to_chat(HL, span_warning("¡Puedo ver claramente el rostro de [user.real_name] mirandome!"))
							to_chat(user, span_warning("¡[HL.real_name] me mira!"))
							return
					to_chat(HL, span_warning("¡Puedo ver claramente el rostro de un desconocido [user.gender == FEMALE ? "woman" : "man"] que me esta mirando!"))
					return
				if(GET_MOB_ATTRIBUTE_VALUE(HL, STAT_PERCEPTION) >= 11)
					to_chat(HL, span_warning("Siento un par de ojos desconocidos sobre mi."))
			REMOVE_TRAIT(user, TRAIT_NOSSDINDICATOR, "scryingorb")
			return
	to_chat(user, span_warning("Miro en [src], pero no puedo encontrar [input]."))
	return

//23.08.2025
//crystallball and nocdevice are depreciated?

/////////////////////////////////////////Crystal ball ghsot vision///////////////////

/obj/item/crystalball/attack_self(mob/user, list/modifiers)
	user.visible_message("<span class='danger'>[user] mira dentro de [src], sus ojos se le salen de la cabeza.</span>")
	user.ghostize(1)

/*	..................   NOC Device (Fixed scrying ball)   ................... */
/obj/structure/nocdevice
	name = "Dispositivo NOC"
	desc = "Una intrincada maquina de observacion lunar que permite a su usuario estudiar la cara de Noc en el cielo, reflejando el verdadero paradero de seres ocultos..."
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "nocdevice"
	layer = 4.2
	var/last_scry

/obj/structure/nocdevice/attack_hand(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(HAS_TRAIT(H, TRAIT_VIRGIN))
		if(world.time < last_scry + 30 SECONDS)
			to_chat(user, "<span class='warning'>Miro al cielo, pero no puedo enfocar la lente en el rostro de Noc. Quizas deba esperar.</span>")
			return
		var/input = stripped_input(user, "Who are you looking for?", "Scrying Orb")
		if(!input)
			return
		if(!user.key)
			return
		if(world.time < last_scry + 30 SECONDS)
			to_chat(user, "<span class='warning'>Miro al cielo, pero no puedo enfocar la lente en el rostro de Noc. Quizas deba esperar.</span>")
			return
		if(!user.mind || !user.mind.do_i_know(name=input))
			to_chat(user, "<span class='warning'>No conozco a nadie con ese nombre.</span>")
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == input)
				var/turf/T = get_turf(HL)
				if(!T)
					continue
				var/mob/dead/observer/screye/S = user.scry_ghost()
				if(!S)
					return
				S.ManualFollow(HL)
				last_scry = world.time
				user.visible_message("<span class='danger'>[user] mira [src], [p_their()] con los ojos entrecerrados y concentrado...</span>")
				addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 8 SECONDS)
				if(!HL.stat)
					if(GET_MOB_ATTRIBUTE_VALUE(HL, STAT_PERCEPTION) >= 15)
						if(HL.mind)
							if(HL.mind.do_i_know(name=user.real_name))
								to_chat(HL, "<span class='warning'>¡Puedo ver claramente el rostro de [user.real_name] mirandome!.</span>")
								return
						to_chat(HL, "<span class='warning'>I can clearly see the face of an unknown [user.gender == FEMALE ? "woman" : "man"] staring at me!</span>")
						return
					if(GET_MOB_ATTRIBUTE_VALUE(HL, STAT_PERCEPTION) >= 11)
						to_chat(HL, "<span class='warning'>Siento un par de ojos desconocidos sobre mi.</span>")
				return
		to_chat(user, "<span class='warning'>Pirando en el mirador, pero Noc no revela donde esta [input].</span>")
		return
	else
		to_chat(user, "<span class='notice'>Noc parece enojado conmigo...</span>")
