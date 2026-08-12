
/datum/intent/unarmed
	unarmed = TRUE

/datum/intent/unarmed/punch
	name = "golpe de puño"
	icon_state = "inpunch"
	attack_verb = list("golpea", "pincha", "relojes")
	chargetime = 0
	animname = "punch"
	hitsound = list('sound/combat/hits/punch/punch (1).ogg', 'sound/combat/hits/punch/punch (2).ogg', 'sound/combat/hits/punch/punch (3).ogg')
	misscost = 5
	releasedrain = 1
	swingdelay = 0
	rmb_ranged = TRUE
	candodge = TRUE
	canparry = TRUE
	blade_class = BCLASS_PUNCH
	miss_text = "¡mueve un puño al aire!"
	miss_sound = "punchwoosh"
	item_damage_type = "blunt"

/datum/intent/unarmed/punch/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message(span_red("¡[user] se burla de [M]!"), span_red("¡Me muevo de [M]!"), ignored_mobs = targetl)
		user.emote("taunt")
		if(M.client)
			M.taunted(user)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='red'>[user] me insulta </span>")
		else
			M.taunted(user)
	return

/datum/intent/unarmed/shove
	name = "empujar"
	icon_state = "inshove"
	attack_verb = list("empuja")
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	misscost = 5
	releasedrain = 2
	item_damage_type = "blunt"

/datum/intent/unarmed/shove/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='blue'>[user] aleja a [M] con una patada.</span>", "<span class='blue'>Ahuyento a [M].</span>", ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='blue'>[user] me aleja.</span>")
		else
			M.shood(user)
	return

/datum/intent/unarmed/grab
	name = "agarra."
	icon_state = "ingrab"
	attack_verb = list("agarra")
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	releasedrain = 3
	misscost = 6.5
	candodge = TRUE
	canparry = TRUE
	item_damage_type = "blunt"

/datum/intent/unarmed/grab/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='green'>[user] hace señas [M] para que se acerque.</span>", "<span class='green'>Señalo con la mano a [M] para que se acerque.</span>", ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='green'>[user] me hace señas para que me acerque.</span>")
		else
			M.beckoned(user)
	return

/datum/intent/unarmed/help
	name = "tocar"
	icon_state = "intouch"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0
	releasedrain = 0
	rmb_ranged = TRUE

/datum/intent/unarmed/help/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='green'>[user] hace una señal de saludo a [M].</span>", "<span class='green'>Muevo la mano de forma amigable hacia [M].</span>", ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='green'>[user] me da una amable ola.</span>")
	return
