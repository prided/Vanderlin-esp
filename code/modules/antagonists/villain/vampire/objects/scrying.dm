/obj/structure/vampire/scryingorb // Method of spying on the town
	name = "Ojo de la noche"
	icon_state = "scrying"

/obj/structure/vampire/scryingorb/attack_hand(mob/living/carbon/human/user)
	if(user?.mind.has_antag_datum(/datum/antagonist/vampire/lord))
		user.visible_message("<font color='red'>[user]'s eyes turn dark red, as they channel the [src]</font>", "<font color='red'>I begin to channel my consciousness into a Predator's Eye.</font>")
		if(do_after(user, 6 SECONDS, src))
			user.scry(can_reenter_corpse = 1, force_respawn = FALSE)
	else
		to_chat(user, span_warning("¡No tengo el poder para usar esto!"))

/mob/dead/observer/rogue/arcaneeye
	name = "Ojo Arcano"
	icon_state = "arcaneeye"
	sight = 0
	see_in_dark = 2
	invisibility = INVISIBILITY_GHOST
	see_invisible = SEE_INVISIBLE_GHOST

	draw_icon = FALSE
	hud_type = /datum/hud/eye

	var/mob/living/carbon/human/vampirelord = null

/mob/dead/observer/rogue/arcaneeye/Initialize(mapload)
	. = ..()
	set_invisibility(GLOB.observer_default_invisibility)
	add_movespeed_modifier(MOVESPEED_ID_GHOST, override = TRUE, multiplicative_slowdown = 3)
	var/list/verbs = list(
		/mob/dead/observer/rogue/arcaneeye/proc/scry_tele,
		/mob/dead/observer/rogue/arcaneeye/proc/cancel_scry,
		/mob/dead/observer/rogue/arcaneeye/proc/eye_down,
		/mob/dead/observer/rogue/arcaneeye/proc/eye_up,
		/mob/dead/observer/rogue/arcaneeye/proc/vampire_telepathy
	)
	add_verb(src, verbs)

/mob/dead/observer/rogue/arcaneeye/Destroy()
	vampirelord = null
	return ..()

/mob/dead/observer/rogue/arcaneeye/Crossed(mob/living/L)
	if(istype(L, /mob/living/carbon/human))
		var/mob/living/carbon/human/V = L
		var/holyskill = GET_MOB_SKILL_VALUE_OLD(V, /datum/attribute/skill/magic/holy)
		var/magicskill = GET_MOB_SKILL_VALUE_OLD(V, /datum/attribute/skill/magic/arcane)
		if(magicskill >= 2)
			to_chat(V, "<font color='red'>An ancient and unusual magic looms in the air around you.</font>")
			return
		if(holyskill >= 2)
			to_chat(V, "<font color='red'>An ancient and unholy magic looms in the air around you.</font>")
			return
		if(prob(20))
			to_chat(V, "<font color='red'>You feel like someone is watching you, or something.</font>")
			return

/mob/dead/observer/rogue/arcaneeye/proc/cancel_scry()
	set category = "RoleUnique.Arcane Eye"
	set name = "Cancel Eye"
	set desc= "Return to Body"

	if(vampirelord)
		vampirelord.ckey = ckey
		qdel(src)
	else
		to_chat(src, "¡Mi cuerpo ha sido destruido! ¡Estoy atrapado!")

/mob/dead/observer/rogue/arcaneeye/proc/vampire_telepathy()
	set name = "Telepatía"
	set category = "RoleUnique.Arcane Eye"

	var/msg = input("Envía un mensaje.", "Command") as text|null
	if(!msg)
		return
	for(var/datum/mind/V in SSmapping.retainer.vampires)
		to_chat(V, span_boldnotice("Un mensaje de [src.real_name]:[msg]"))
	for(var/datum/mind/D in SSmapping.retainer.death_knights)
		to_chat(D, span_boldnotice("Un mensaje de [src.real_name]:[msg]"))
	for(var/mob/dead/observer/rogue/arcaneeye/A in GLOB.mob_list)
		to_chat(A, span_boldnotice("Un mensaje de [src.real_name]:[msg]"))

/mob/dead/observer/rogue/arcaneeye/proc/eye_up()
	set category = "RoleUnique.Arcane Eye"
	set name = "Subir"

	if(zMove(UP, z_move_flags = ZMOVE_FEEDBACK))
		to_chat(src, span_notice("Me muevo hacia arriba."))

/mob/dead/observer/rogue/arcaneeye/proc/eye_down()
	set category = "RoleUnique.Arcane Eye"
	set name = "Mover hacia abajo"

	if(zMove(DOWN, z_move_flags = ZMOVE_FEEDBACK))
		to_chat(src, span_notice("Me muevo hacia abajo."))

/mob/dead/observer/rogue/arcaneeye/proc/scry_tele()
	set category = "RoleUnique.Arcane Eye"
	set name = "Teleport"
	set desc= "Teleport to a location"

	if(!isobserver(src))
		to_chat(src, span_warning("¡No eres un ojo!"))
		return

	var/list/filtered = list()
	for(var/area/A as anything in get_sorted_areas())
		if(A.area_flags & (HIDDEN_AREA|NO_TELEPORT))
			continue
		filtered += A

	var/area/thearea  = browser_input_list(src, "Area to jump to", "VANDERLIN", filtered)

	if(!thearea)
		return

	var/list/L = list()
	for(var/turf/T as anything in get_area_turfs(thearea.type))
		L += T

	if(!length(L))
		to_chat(src, span_warning("No hay área disponible."))
		return

	forceMove(pick(L))

/mob/proc/scry(can_reenter_corpse = 1, force_respawn = FALSE, drawskip)
	stop_sound_channel(CHANNEL_HEARTBEAT) //Stop heartbeat sounds because You Are A Ghost Now
	var/mob/dead/observer/rogue/arcaneeye/eye = new(src)	// Transfer safety to observer spawning proc.
	SStgui.on_transfer(src, eye) // Transfer NanoUIs.
	eye.can_reenter_corpse = can_reenter_corpse
	eye.vampirelord = src
	eye.ghostize_time = world.time
	eye.key = key
	qdel(eye.language_holder)
	eye.language_holder = language_holder.copy(eye)
	return eye
