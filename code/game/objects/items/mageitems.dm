/obj/item/storage/magebag
	name = "bolsa de invocadores"
	desc = "Una bolsa para llevar puñados de ingredientes de invocacion."
	icon_state = "summoning"
	item_state = "summoning"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	resistance_flags = NONE
	max_integrity = 300
	item_weight = 150 GRAMS
	component_type = /datum/component/storage/concrete/grid/magebag

/obj/item/storage/magebag/examine(mob/user)
	. = ..()
	if(contents.len)
		. += span_notice("[contents.len] cosa[contents.len > 1 ? "s" : ""] en la bolsa.")

/obj/item/storage/magebag/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/list/things = STR.contents()
	if(length(things))
		var/obj/item/I = pick(things)
		STR.remove_from_storage(I, get_turf(user))
		user.put_in_hands(I)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/storage/magebag/update_icon_state()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/list/things = STR.contents()
	if(things.len)
		icon_state = "summoning"
		w_class = WEIGHT_CLASS_NORMAL
	else
		icon_state = "summoning"
		w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/magebag/apprentice
	populate_contents = list(
		/obj/item/natural/infernalash,
		/obj/item/natural/fairydust,
		/obj/item/natural/elementalmote,
		/obj/item/mana_battery/mana_crystal/standard,
		/obj/item/mana_battery/mana_crystal/standard,
		/obj/item/natural/obsidian,
		/obj/item/natural/obsidian,
		/obj/item/natural/obsidian,
		/obj/item/reagent_containers/food/snacks/produce/manabloom,
		/obj/item/reagent_containers/food/snacks/produce/manabloom,
		/obj/item/reagent_containers/food/snacks/produce/manabloom,
	)

/obj/item/storage/magebag/poor
	populate_contents = list(
		/obj/item/mana_battery/mana_crystal/standard,
		/obj/item/mana_battery/mana_crystal/standard,
		/obj/item/mana_battery/mana_crystal/small,
		/obj/item/mana_battery/mana_crystal/small,
		/obj/item/reagent_containers/food/snacks/produce/manabloom,
		/obj/item/reagent_containers/food/snacks/produce/manabloom,
	)

/obj/item/chalk
	name = "barra de tiza"
	desc = "Una barra de tiza de color blanco intenso, posiblemente hecha de mercurio. "
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "chalk"
	dropshrink = 0.7
	throw_speed = 2
	throw_range = 5
	throwforce = 5
	damtype = BRUTE
	force = 1
	w_class = WEIGHT_CLASS_SMALL
	grid_height = 32
	grid_width = 32
	item_weight = 20 GRAMS
	var/amount = 8

/obj/item/chalk/natural
	name = "barra de tiza natural"
	amount = 3

/obj/item/chalk/examine(mob/user)
	. = ..()
	. += span_info("Tiene [amount] usos restantes.")

/obj/item/chalk/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/ore/cinnabar))
		if(amount < 8)
			amount = 8
			to_chat(user, span_notice("Presiono arcyne la magia en \the [tool/name] y los cristales rojos dentro se derriten en mercurio, hundiendose rapidamente en \the [name]."))
			return ITEM_INTERACT_SUCCESS

/obj/item/chalk/attack_self(mob/living/carbon/human/user, list/modifiers)
	if(GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/arcane) <= SKILL_LEVEL_NONE)//We'll set up other items for other types of rune rituals
		to_chat(user, span_cult("Nada se me ocurre para dibujar con la tiza."))
		return
	var/obj/effect/decal/cleanable/ritual_rune/pickrune
	var/runenameinput = browser_input_list(user, "Runes", "Tier 1&2 Runes", GLOB.t2rune_types)
	pickrune = GLOB.rune_types[runenameinput]
	if(!pickrune)
		return
	var/turf/Turf = get_turf(user)
	if(locate(/obj/effect/decal/cleanable/ritual_rune) in Turf)
		to_chat(user, span_cult("Ya hay una runa aqui."))
		return
	var/structures_in_way = check_for_structures_and_closed_turfs(loc, pickrune)
	if(structures_in_way == TRUE)
		to_chat(user, span_cult("Hay una estructura, una runa o una pared en el camino."))
		return
	var/crafttime = (10 SECONDS - ((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane)) * 5))

	user.visible_message(span_warning("[user] comienza a escribir algo [user.p_their()] [src] ¡Vaya!"), \
		span_notice("Empiezo a arrastrar el [src] en forma de simbolos y sellos magicos"))
	playsound(src, 'sound/magic/chalkdraw.ogg', 100, TRUE)
	if(do_after(user, crafttime, target = src))
		if(QDELETED(src) || !pickrune)
			return
		user.visible_message(span_warning("¡[user] escribe una runa arcyne con [user.p_their()] [src]!"), \
		span_notice("Termine arrastrando el [src] en simbolos y circulos, dejando atras un [pickrune.name]."))
		src.amount--
		new pickrune(Turf)
	if(amount <= 0)
		qdel(src)

/obj/item/chalk/proc/check_for_structures_and_closed_turfs(loc, obj/effect/decal/cleanable/ritual_rune/rune_to_scribe)
	for(var/turf/T in range(loc, rune_to_scribe.runesize))
		//check for /sturcture subtypes in the turf's contents
		for(var/obj/structure/S in T.contents)
			if(S.density)
				return TRUE		//Found a structure, no need to continue

		//check if turf itself is a /turf/closed subtype
		if(istype(T,/turf/closed))
			return TRUE
		//check if rune in the turfs contents
		for(var/obj/effect/decal/cleanable/ritual_rune/R in T.contents)
			return TRUE
		//Return false if nothing in range was found
	return FALSE

/obj/item/weapon/knife/dagger/silver/arcyne
	name = "daga de plata purpura brillante"
	desc = "Esta daga brilla con un tenue color purpura. Quicksilver corre a traves de su espada."
	var/is_bled = FALSE

/obj/item/weapon/knife/dagger/silver/arcyne/Initialize()
	. = ..()
	filter(type="drop_shadow", x=0, y=0, size=2, offset=1, color=rgb(128, 0, 128, 1))

/obj/item/weapon/knife/dagger/silver/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/ore/cinnabar))
		return NONE

	var/crafttime = (60 - ((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane)) * 5))
	if(!do_after(user, crafttime, target = src))
		return ITEM_INTERACT_BLOCKING

	playsound(src, 'sound/magic/scrapeblade.ogg', 100, TRUE)
	to_chat(user, span_notice("Aplico arcyne magia a la hoja y vibra con un tono morado oscuro..."))
	var/obj/arcyne_knife = new /obj/item/weapon/knife/dagger/silver/arcyne
	qdel(tool)
	qdel(src)
	user.put_in_active_hand(arcyne_knife)
	return ITEM_INTERACT_SUCCESS

/obj/item/weapon/knife/dagger/silver/arcyne/attack_self(mob/living/carbon/human/user, list/modifiers)
	if(GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/arcane) <= SKILL_LEVEL_NONE)
		return
	var/obj/effect/decal/cleanable/ritual_rune/pickrune
	var/runenameinput = browser_input_list(user, "Runes", "All Runes", GLOB.t4rune_types)
	pickrune = GLOB.rune_types[runenameinput]
	if(!pickrune)
		return
	var/turf/Turf = get_turf(user)
	if(locate(/obj/effect/decal/cleanable/ritual_rune) in Turf)
		to_chat(user, span_cult("Ya hay una runa aqui."))
		return
	var/structures_in_way = check_for_structures_and_closed_turfs(loc, pickrune)
	if(structures_in_way == TRUE)
		to_chat(user, span_cult("Hay una estructura, una runa o una pared en el camino."))
		return
	var/chosen_keyword
	if(pickrune.req_keyword)
		chosen_keyword = stripped_input(user, "Keyword for the new rune", "Runes", max_length = MAX_NAME_LEN)
		if(!chosen_keyword)
			return FALSE
	if(!is_bled)
		playsound(src, get_sfx("genslash"), 100, TRUE)
		user.visible_message(span_warning("¡[user] corta la palma de [user.p_their()]!"), \
			span_cult("¡Corto mi palma!"))
		if(user.get_blood_volume())
			user.apply_damage(pickrune.scribe_damage, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM), damage_type = BCLASS_CUT, can_crit = FALSE)
		is_bled = TRUE
	var/crafttime = (10 SECONDS - ((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane)) * 5))

	user.visible_message(span_warning("[user] comienza a tallar algo con la hoja de [user.p_their()] ¡"), \
		span_notice("Empiezo a arrastrar la hoja en forma de simbolos y sellos."))
	playsound(src, 'sound/magic/bladescrape.ogg', 100, TRUE)
	if(do_after(user, crafttime, target = src))
		if(QDELETED(src) || !pickrune)
			return
		user.visible_message(span_warning("[user] talla una arcyne runa con [user.p_their()] [src]!"), \
		span_notice("Termine de arrastrar la hoja en simbolos y circulos, dejando atras un [pickrune.name]."))
		new pickrune(Turf, chosen_keyword)

/obj/item/weapon/knife/dagger/proc/check_for_structures_and_closed_turfs(loc, obj/effect/decal/cleanable/ritual_rune/rune_to_scribe)
	for(var/turf/T in range(loc, rune_to_scribe.runesize))
		//check for /sturcture subtypes in the turf's contents
		for(var/obj/structure/S in T.contents)
			return TRUE		//Found a structure, no need to continue
		//check if turf itself is a /turf/closed subtype
		if(istype(T,/turf/closed))
			return TRUE
		//check if rune in the turfs contents
		for(var/obj/effect/decal/cleanable/ritual_rune/R in T.contents)
			return TRUE
		//Return false if nothing in range was found
	return FALSE

/obj/item/gem/amethyst
	name = "amythortz"
	icon_state = "amethyst"
	sellprice = 18
	arcyne_potency = 25
	desc = "Un cristal rosa que irradia energia magica, pero su naturaleza artificial significa que vale poco."
	item_weight = 8 GRAMS
	attuned = /datum/attunement/arcyne

/obj/item/mimictrinket
	name = "imitar baratija"
	desc = "Un pequeño imitador, imbuido del arcyne para hacerlo docil. Puede transformarse en la mayoria de las cosas que toca."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "mimic_trinket"
	possible_item_intents = list(/datum/intent/use)
	item_weight = 30 GRAMS
	var/duration = 10 MINUTES
	var/oldicon
	var/oldicon_state
	var/olddesc
	var/oldname
	var/ready = TRUE
	var/timing_id

/obj/item/mimictrinket/attack_self(mob/living/carbon/human/user, list/modifiers)
	revert()

/obj/item/mimictrinket/proc/revert()
	if(oldicon_state)
		icon = oldicon
		icon_state = oldicon_state
		name = oldname
		desc = olddesc
	ready = TRUE
	if(timing_id)
		deltimer(timing_id)
		timing_id = null

/obj/item/mimictrinket/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isobj(interacting_with))
		return NONE

	if(!ready)
		return ITEM_INTERACT_BLOCKING

	var/obj/target = interacting_with

	to_chat(user, span_notice("¡[src] toma la forma de [target]!"))
	oldicon = icon
	oldicon_state = icon_state
	olddesc = desc
	oldname = name
	icon = target.icon
	icon_state = target.icon_state
	name = target.name
	desc = target.desc
	ready = FALSE
	timing_id = addtimer(CALLBACK(src, PROC_REF(revert)), duration, TIMER_STOPPABLE) // Minus two so we play the sound and decap faster

	return ITEM_INTERACT_SUCCESS

/obj/item/hourglass/temporal
	name = "reloj de arena temporal"
	desc = "Un reloj de arena infundido arcyne que brilla con magia."
	icon = 'icons/obj/hourglass.dmi'
	icon_state = "hourglass_idle"
	item_weight = 300 GRAMS
	var/turf/target
	var/mob/living/victim

/obj/item/hourglass/temporal/toggle(mob/user)
	if(!timing_id)
		to_chat(user,span_notice("Doy la vuelta al [src]."))
		start()
		flick("hourglass_flip",src)
		target = get_turf(src)
		victim = user
	else
		to_chat(user,span_notice("Dejo de lado el [src].")) //Sand magically flows back because that's more convinient to use.
		stop()

/obj/item/hourglass/temporal/stop()
	..()
	do_teleport(victim, target, channel = TELEPORT_CHANNEL_QUANTUM)

/obj/item/natural/feather/infernal
	name = "pluma infernal"
	icon_state = "hellfeather"
	possible_item_intents = list(/datum/intent/use)
	desc = "Una pluma esponjosa."

/obj/item/flashlight/flare/torch/lantern/voidlamptern
	name = "farol del vacio"
	icon_state = "voidlamp"
	item_state = "voidlamp"
	desc = "Una vieja lampara que parece cada vez mas oscura cuanto mas la miras."
	light_outer_range = 8
	light_color = "#000000"
	light_power = -3
	on = FALSE
	item_weight = 500 GRAMS

/obj/item/clothing/ring/arcanesigil
	name = "Sello arcyne"
	desc = "Un sello radiantemente reluciente dentro de un amuleto, parece palpitar con intensos flujos arcinicos."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "amulet"
	item_weight = 30 GRAMS
	var/cdtime = 30 MINUTES
	var/ready = TRUE

/obj/item/clothing/ring/arcanesigil/attack_self(mob/living/carbon/human/user, list/modifiers)
	if(ready)
		if(do_after(user, 25, target = src))
			to_chat(user,span_notice("[src] se calienta hasta una temperatura casi ardiente, inundandote con un abrumador arcyne conocimiento."))
			ready = FALSE
			addtimer(CALLBACK(src, PROC_REF(revert), user), cdtime,TIMER_STOPPABLE) // Minus two so we play the sound and decap faster
			user.adjust_stat_modifier(STATMOD_SIGIL, list(/datum/attribute/skill/magic/arcane = 10))
	else
		to_chat(user,span_notice("[src] permanece inerte. ¡Debe estar recolectando arcanas!"))

/obj/item/clothing/ring/arcanesigil/proc/revert()
	ready = TRUE

/obj/item/clothing/ring/shimmeringlens
	name = "lente brillante"
	desc = "Un cristal de lente radiantemente reluciente que brilla con magia. Mirarlo te da un poco de dolor de cabeza."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "lens"
	w_class = WEIGHT_CLASS_NORMAL
	item_weight = 80 GRAMS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/active = FALSE

/obj/item/clothing/ring/shimmeringlens/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(loc != user)
		return
	if(!active)
		user.visible_message(span_warning("¡[user] mira a traves de el [src]!"))
		active = TRUE
		activate(user)
	else
		user.visible_message(span_warning("¡[user] deja de mirar a traves del [src]!"))
		demagicify()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/ring/shimmeringlens/proc/activate(mob/user)
	ADD_TRAIT(user, TRAIT_SEE_LEYLINES, "[type]")
	user.see_invisible = SEE_INVISIBLE_LEYLINES
	user.hud_used?.plane_masters_update()

/obj/item/clothing/ring/shimmeringlens/proc/demagicify()
	var/mob/living/user = usr
	REMOVE_TRAIT(user,TRAIT_SEE_LEYLINES, "[type]")
	user.see_invisible = SEE_INVISIBLE_LIVING
	user.hud_used?.plane_masters_update()
	active = FALSE

/obj/item/sendingstonesummoner
	name = "enviando invocador de piedra"

/obj/item/sendingstonesummoner/OnCrafted(dirin, mob/user)
	. = ..()
	var/obj/item/natural/stone/sending/item1 = new /obj/item/natural/stone/sending
	var/obj/item/natural/stone/sending/item2 = new /obj/item/natural/stone/sending
	item1.paired_with = item2
	item2.paired_with = item1
	item1.icon_state = "whet"
	item2.icon_state = "whet"
	item1.color = "#d8aeff"
	item2.color = "#d8aeff"
	user.put_in_hands(item1, FALSE)
	user.put_in_hands(item2, FALSE)
	qdel(src)

/obj/item/natural/stone/sending
	name = "enviando piedra"
	desc = "Uno de un par de piedras de envio."
	item_weight = 50 GRAMS
	var/obj/item/natural/stone/sending/paired_with

/obj/item/natural/stone/sending/attack_self(mob/user, list/modifiers)
	var/input_text = input(user, "Introduce tu mensaje:", "Mensaje")
	if(input_text)
		paired_with.say(input_text)

/obj/item/clothing/gloves/nomagic
	name = "guantes de union de mana"
	icon = 'icons/roguetown/clothing/gloves.dmi'
	bloody_icon_state = "bloodyhands"
	icon_state = "angle"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF
	item_weight = 100 GRAMS
	var/active_item

/obj/item/clothing/gloves/nomagic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_magic, MAGIC_RESISTANCE, 1, ITEM_SLOT_GLOVES)
	///VANDERLIN TO DO

/obj/item/clothing/gloves/nomagic/equipped(mob/living/user, slot)
	if(active_item)
		return
	if(slot & ITEM_SLOT_GLOVES)
		active_item = TRUE
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	. = ..()

/obj/item/rope/chain/bindingshackles
	name = "grilletes de vinculacion planar"
	desc = "Grilletes arcyne imbuidos para unir la inteligencia de otras criaturas planas a este plano. No estaran bajo su esclavitud y sera necesario llegar a un acuerdo."
	item_weight = 400 GRAMS
	var/mob/living/fam
	var/tier = 1
	var/being_used = FALSE
	var/sentience_type = SENTIENCE_ORGANIC


/obj/item/rope/chain/bindingshackles/Initialize()
	.=..()
	src.filters += filter(type="drop_shadow", x=0, y=0, size=1, offset=2, color=rgb(rand(1,255),rand(1,255),rand(1,255)))

/obj/item/rope/chain/bindingshackles/attackby(obj/item/P, mob/living/carbon/human/user, list/modifiers)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t2))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(src, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("Moldeo el [P] en el [src] con mi poder arcyne."))
				new /obj/item/rope/chain/bindingshackles/t2(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>Necesitas poner el [src] sobre una mesa para trabajar en el.</span>")
	else
		return ..()
/obj/item/rope/chain/bindingshackles/t2
	name = "grilletes de union planos mas grandes"
	tier = 2

/obj/item/rope/chain/bindingshackles/t2/attackby(obj/item/P, mob/living/carbon/human/user, list/modifiers)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t3))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(src, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("Moldeo el [P] en el [src] con mi poder arcyne."))
				new /obj/item/rope/chain/bindingshackles/t3(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>Necesitas poner el [src] sobre una mesa para trabajar en el.</span>")
	else
		return ..()
/obj/item/rope/chain/bindingshackles/t3
	name = "grilletes tejidos de vinculacion planar"
	tier = 3

/obj/item/rope/chain/bindingshackles/t3/attackby(obj/item/P, mob/living/carbon/human/user, list/modifiers)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t4))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(src, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("Moldeo el [P] en el [src] con mi poder arcyne."))
				new /obj/item/rope/chain/bindingshackles/t4(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>Necesitas poner el [src] sobre una mesa para trabajar en el.</span>")
	else
		return ..()
/obj/item/rope/chain/bindingshackles/t4
	name = "grilletes de union planos confluentes"
	tier = 4

/obj/item/rope/chain/bindingshackles/t4/attackby(obj/item/P, mob/living/carbon/human/user, list/modifiers)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(P, /obj/item/natural/melded/t5))
		if(isturf(loc)&& (found_table))
			var/crafttime = (100 - ((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane))*5))
			if(do_after(user, crafttime, target = src))
				playsound(src, 'sound/items/book_close.ogg', 100, TRUE)
				to_chat(user, span_notice("Moldeo el [P] en el [src] con mi poder arcyne."))
				new /obj/item/rope/chain/bindingshackles/t5(loc)
				qdel(P)
				qdel(src)
		else
			to_chat(user, "<span class='warning'>Necesitas poner el [src] sobre una mesa para trabajar en el.</span>")
	else
		return ..()

/obj/item/rope/chain/bindingshackles/t5
	name = "grilletes de union planos aberrantes"
	tier = 5

/obj/item/rope/chain/bindingshackles/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /mob/living/simple_animal/hostile/retaliate))
		return NONE

	var/static/list/summon_types = list(
		/mob/living/simple_animal/hostile/retaliate/infernal/imp,
		/mob/living/simple_animal/hostile/retaliate/infernal/hellhound,
		/mob/living/simple_animal/hostile/retaliate/infernal/watcher,
		/mob/living/simple_animal/hostile/retaliate/infernal/fiend,
		/mob/living/simple_animal/hostile/retaliate/elemental/crawler,
		/mob/living/simple_animal/hostile/retaliate/elemental/warden,
		/mob/living/simple_animal/hostile/retaliate/elemental/behemoth,
		/mob/living/simple_animal/hostile/retaliate/elemental/collossus,
		/mob/living/simple_animal/hostile/retaliate/fae/sprite,
		/mob/living/simple_animal/hostile/retaliate/fae/glimmerwing,
		/mob/living/simple_animal/hostile/retaliate/fae/dryad,
		/mob/living/simple_animal/hostile/retaliate/fae/sylph,
		/mob/living/simple_animal/hostile/retaliate/voidstoneobelisk,
		/mob/living/simple_animal/hostile/retaliate/voiddragon,
	)

	var/mob/living/simple_animal/hostile/retaliate/captive = interacting_with

	if(!is_type_in_list(interacting_with, summon_types))
		to_chat(user, span_warning("¡[captive] no puede ser atado por estas cadenas!"))
		return ITEM_INTERACT_BLOCKING

	if(captive.tier > tier)
		to_chat(user, span_warning("¡[src] no es lo suficientemente fuerte para atar a [captive]!"))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/simple_animal/hostile/retaliate/target = captive
	target.visible_message(span_warning("El cuerpo de [target.real_name] esta atrapado por cadenas brillantes..."), runechat_message = TRUE)

	if(!target.ckey) //player is not inside body or has refused, poll for candidates
		var/list/candidates = pollCandidatesForMob("Do you want to play as a Mage's summon?", null, null, null, 100, target, POLL_IGNORE_MAGE_SUMMON, new_players = TRUE)

		// theres at least one candidate
		if(LAZYLEN(candidates))
			var/mob/C = pick(candidates)
			target.awaken_summon(user, C.ckey)
			target.visible_message(span_warning("Los ojos de [target.real_name] se iluminan con inteligencia mientras despierta completamente en este plano."), runechat_message = TRUE)
			custom_name(user, target)
		else
			to_chat(user, span_notice("El [captive] te mira con odio sin sentido. ¡El intento de enlace no logro extraer su inteligencia!"))

	return ITEM_INTERACT_SUCCESS

/mob/living/simple_animal/hostile/retaliate/proc/awaken_summon(mob/living/carbon/human/master, ckey)
	if(!master)
		return FALSE

	if(ckey) //player
		src.ckey = ckey

	to_chat(src, span_userdanger("Mi invocador es [master.real_name]. Tendran que convencerme para que les obedezca."))
	to_chat(src, span_warning("[summon_primer]"))

/obj/item/rope/chain/bindingshackles/proc/custom_name(mob/awakener, mob/chosen_one, iteration = 1)
	if(iteration > 5)
		return
	var/chosen_name = sanitize_name(stripped_input(chosen_one, "What are you named?"))
	if(!chosen_name) // with the way that sanitize_name works, it'll actually send the error message to the awakener as well.
		to_chat(awakener, span_warning("¡Tu arma no selecciono un nombre valido! Por favor, espera mientras intentan de nuevo.")) // more verbose than what sanitize_name might pass in it's error message
		return custom_name(awakener, iteration++)
	return chosen_one.fully_replace_character_name(chosen_one.name, chosen_name)

////////////////////////////////////////Magic resources go below here////////////////////

//mapfetchable items
/obj/item/natural/obsidian
	name = "fragmento de obsidiana"
	icon = 'icons/obj/shards.dmi'
	icon_state = "obsidian"
	desc = "El vidrio volcanico se enfrio rapidamente a partir de lava fundida."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	item_weight = 80 GRAMS

/obj/item/natural/leyline
	name = "fragmentos de linea ley"
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "leyline"
	desc = "Un fragmento de una linea ley fracturada que brilla con el poder perdido."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	item_weight = 30 GRAMS

/obj/item/reagent_containers/food/snacks/produce/manabloom
	name = "manabloom"
	icon_state = "manabloom"
	icon = 'icons/roguetown/items/natural.dmi'
	desc = "Mana denso que ha tomado la forma de vida vegetal."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	body_parts_covered = NONE
	alternate_worn_layer  = 8.9
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	list_reagents = list(/datum/reagent/toxin/manabloom_juice = SNACK_CHUNKY)
	seed = /obj/item/neuFarm/seed/manabloom
	item_weight = 20 GRAMS


/obj/item/natural/artifact
	name = "artefacto runico"
	icon_state = "runedartifact"
	desc = "Una piedra antigua de hace mucho tiempo, marcada con sellos brillantes."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	item_weight = 100 GRAMS

/obj/item/natural/voidstone
	name = "Piedra vacia"
	icon_state = "wessence"
	desc = "Un trozo de piedra negra, da sensacion mirarlo durante mucho tiempo."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	item_weight = 60 GRAMS

//combined items
/obj/item/natural/melded
	name = "Fusion arcyne"
	icon_state = "wessence"
	desc = "No deberias estar viendo esto"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	sellprice = 20
	item_weight = 40 GRAMS
	var/obj/item/spellbook/melded_quality = /obj/item/spellbook/adept
	var/shock_damage = 20
	var/amplifier = 1

/obj/item/natural/melded/t1
	name = "fusion arcanica"
	icon = 'icons/obj/objects.dmi'
	icon_state = "meld"
	desc = "Una fusion de ceniza infernal, polvo de hadas y mota elemental."

/obj/item/natural/melded/t2
	name = "densa fusion arcanica"
	icon = 'icons/obj/objects.dmi'
	icon_state = "dmeld"
	desc = "Una combinacion de colmillos de perro del infierno, escamas iridiscentes y fragmento elemental."
	item_flags = OBTAINED_DATA
	obtained_from = list(list("Killing a Sylph", /mob/living/simple_animal/hostile/retaliate/fae/sylph))
	item_weight = 50 GRAMS
	melded_quality = /obj/item/spellbook/expert
	shock_damage = 40
	amplifier = 1.25

/obj/item/natural/melded/t3
	name = "tejido hechicero"
	icon = 'icons/obj/objects.dmi'
	icon_state = "wessence"
	desc = "Una fusion de nucleo fundido, nucleo de duramen y fragmento elemental."
	item_weight = 60 GRAMS
	melded_quality = /obj/item/spellbook/master
	shock_damage = 60
	amplifier = 1.5

/obj/item/natural/melded/t4
	name = "confluencia magica"
	icon = 'icons/obj/objects.dmi'
	icon_state = "wessence"
	desc = "Una fusion de llama abisal, esencia selvatica y reliquia elemental."
	item_weight = 70 GRAMS
	melded_quality = /obj/item/spellbook/legendary
	shock_damage = 80
	amplifier = 1.75

/obj/item/natural/melded/t5
	name = "aberacion arcanica"
	icon_state = "wessence"
	desc = "Una fusion de fusion arcyne y piedra vacia. Pulsa de forma erratica, con un poder fuertemente enrollado en su interior y peligroso. Muchos tendrian miedo de acercarse a esto, y mucho menos de sostenerlo."
	item_weight = 80 GRAMS
	melded_quality = /obj/item/spellbook/legendary
	shock_damage = 40
	amplifier = 2

/obj/structure/soul
	name = "alma"
	desc = "El alma de los muertos"
	icon = 'icons/roguetown/misc/mana.dmi'
	icon_state = "soul"
	plane = LEYLINE_PLANE
	invisibility = INVISIBILITY_LEYLINES
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	no_over_text = TRUE

	var/mana_amount = 7
	var/datum/weakref/drainer
	var/qdel_timer

/obj/structure/soul/Initialize(mapload)
	. = ..()
	animate(src, pixel_y = 4, time = 1 SECONDS, loop = -1, flags = ANIMATION_RELATIVE)
	animate(pixel_y = -4, time = 1 SECONDS, flags = ANIMATION_RELATIVE)

/obj/structure/soul/Destroy()
	if(qdel_timer)
		deltimer(qdel_timer)
	return ..()

/obj/structure/soul/attack_hand(mob/living/user)
	. = ..()
	if(user.mana_pool?.intrinsic_recharge_sources & MANA_SOULS)
		drain_mana(user)

/obj/structure/soul/proc/init_mana(datum/weakref/dead_guy)
	drainer = dead_guy
	var/mob/living/drained = drainer?.resolve()
	if(!drained)
		return
	mana_amount = drained.mana_pool?.amount
	if(!mana_amount || mana_amount <= 0)
		qdel(src)
		return
	qdel_timer = QDEL_IN_STOPPABLE(src, 10 MINUTES)

/obj/structure/soul/proc/drain_mana(mob/living/user)
	var/datum/beam/transfer_beam = user.Beam(src, icon_state = "drain_life", time = INFINITY)

	var/failed = FALSE
	while(!failed)
		var/mob/living/drained = drainer?.resolve()
		if(!do_after(user, 3 SECONDS, target = src))
			qdel(transfer_beam)
			failed = TRUE
			break
		if(!user.client)
			failed = TRUE
			qdel(transfer_beam)
			break
		var/transfer_amount = min(mana_amount, 20)
		if(!transfer_amount)
			failed = TRUE
			qdel(transfer_beam)
			qdel(src)
			break
		if(drained)
			mana_amount -= drained.mana_pool.transfer_specific_mana(user.mana_pool, transfer_amount, decrement_budget = TRUE)
		else
			mana_amount -= transfer_amount
			user.mana_pool.adjust_mana(transfer_amount)

/obj/item/pylon_linker
	name = "enlazador de ley"
	desc = "Una herramienta mistica utilizada para unir pilones de mana, permitiendo que el mana fluya entre ellos."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "dbrush"
	grid_width = 32
	grid_height = 64

	var/obj/structure/mana_pylon/source_pylon

/obj/item/pylon_linker/afterattack(atom/target, mob/living/user, proximity_flag, list/modifiers)
	. = ..()
	if(!proximity_flag)
		return
	if(!istype(target, /obj/structure/mana_pylon))
		return

	var/obj/structure/mana_pylon/pylon = target

	if(!source_pylon)
		source_pylon = pylon
		user.balloon_alert(user, "Conjunto de origen: [pylon.name]")
		return

	if(source_pylon == pylon)
		user.balloon_alert(user, "¡No puede vincularse a si mismo!")
		return

	source_pylon.link_pylon(pylon)
	user.balloon_alert(user, "¡Pylones enlazados!")
	source_pylon = null

/obj/item/pylon_linker/afterattack_secondary(atom/target, mob/living/user, proximity_flag, list/modifiers)
	. = ..()
	if(!proximity_flag)
		return

	if(!istype(target, /obj/structure/mana_pylon))
		if(source_pylon)
			user.balloon_alert(user, "¡Fuente despejada!")
			source_pylon = null
		return

	var/obj/structure/mana_pylon/pylon = target

	if(!pylon.linked_pylon)
		user.balloon_alert(user, "¡No esta vinculado!")
		return

	pylon.unlink_pylon(pylon.linked_pylon)
	user.balloon_alert(user, "¡El enlace esta roto!")
