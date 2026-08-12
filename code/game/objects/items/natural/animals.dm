

/obj/item/natural/hide
	name = "piel"
	icon_state = "hide"
	desc = "Escondete de uno de los creadores de Dendor."
	dropshrink = 0.90
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sellprice = 5
	item_weight = 350 GRAMS

/obj/item/natural/hide/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/paper/scroll))
		return ..()

	if(!isturf(loc) || !locate(/obj/structure/table) in loc)
		to_chat(user, "<span class='warning'>Necesitas poner el [src] sobre una mesa para trabajar en el.</span>")
		return ITEM_INTERACT_BLOCKING

	var/crafttime = max(0, 100 - GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane) * 5)
	if(!do_after(user, crafttime, target = src))
		return ITEM_INTERACT_BLOCKING

	playsound(src, 'sound/items/book_close.ogg', 100, TRUE)
	to_chat(user, span_notice("Añado las primeras paginas a la cubierta de cuero..."))
	new /obj/item/spellbook_unfinished(loc)
	qdel(tool)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/natural/hide/cured
	name = "cuero curado"
	icon_state = "leather"
	desc = "Pieza de piel que ha sido curada y que ahora se puede trabajar."
	sellprice = 7
	bundletype = /obj/item/natural/bundle/curred_hide

/obj/item/natural/bundle/curred_hide
	name = "paquete de cuero curado"
	desc = "Un monton de piezas de cuero curado agrupadas."
	icon_state = "leatherroll1"
	maxamount = 10
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/hide/cured
	stackname = "cuero curado"
	icon1 = "leatherroll1"
	icon1step = 5
	icon2 = "leatherroll2"
	icon2step = 10

/obj/item/natural/cured/essence
	name = "esencia del desierto"
	icon_state = "wessence"
	desc = "Una esencia mistica imbuida del poder de Dendor. Simplemente sostenerlo transporta la mente a tiempos antiguos."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	sellprice = 20
	item_weight = 100 GRAMS

/obj/item/natural/fur // a piece of skin with animal hair on it. Could be called a fur but its untanned and also encompasses rat skins and goat skins so pelt is more suitable at least to my ears.
	name = "piel"
	icon_state = "wool1"
	desc = "Piel de uno de los creachers de Dendor."
	dropshrink = 0.90
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sellprice = 5
	item_weight = 300 GRAMS

/obj/item/natural/fur/gote
	name = "gote de pelo"
	desc = "Piel de gote."
	icon_state = "pelt_gote"

/obj/item/natural/fur/volf
	name = "lana de lobo"
	desc = "Piel de un volf."
	icon_state = "pelt_volf"

/obj/item/natural/fur/mole
	name = "Piel de topo"
	desc = "Piel de topo."
	icon_state = "pelt_mole"

/obj/item/natural/fur/rous
	name = "piel de Rous"
	desc = "Piel de un rous."
	icon_state = "pelt_rous"

/obj/item/natural/fur/cabbit
	name = "lana de cabito"
	desc = "Piel de un taxi."
	icon_state = "wool2"

/obj/item/natural/fur/direbear
	name = "pelaje de oso gigante"
	desc = "piel de uno de los creachers mas poderosos de Dendor."
	icon_state = "pelt_direbear"
	color = "#33302b"
	sellprice = 28

/obj/item/natural/fur/fox
	name = "pelaje de zorro"
	desc = "Piel de venard."
	icon_state = "pelt_fox"
	color = null

/obj/item/natural/fur/raccoon
	name = "piel de mapache"
	desc = "Piel de mapache."
	icon_state = "pelt_raccoon"
	color = null
	sellprice = 12

/obj/item/natural/fur/bobcat
	name = "piel de yaguaroundo"
	desc = "Piel de lince."
	icon_state = "pelt_bobcat"
	color = null

/obj/item/natural/head
	possible_item_intents = list(/datum/intent/use)
	layer = 3.1
	grid_height = 64
	grid_width = 64
	w_class = WEIGHT_CLASS_NORMAL
	item_weight = 750 GRAMS

	var/meat_to_give = /obj/item/reagent_containers/food/snacks/meat/steak
	var/rotten = FALSE

	/// The amount of blood this can restore when used with Hunter's Will
	var/blood_value = 0

/obj/item/natural/head/Initialize()
	. = ..()
	randomize_price() //headeater

//quality from butchering, 0 is bad, 1 is normal, 2 is good, -1 means its rotten and useless
/obj/item/natural/head/proc/ButcheringResults(butchering_quality)
	switch(butchering_quality)
		if(2)
			sellprice = floor(sellprice * 1.25)
		if(1)
			EMPTY_BLOCK_GUARD
		if(0)
			sellprice = floor(sellprice * 0.75)
		if(-1)
			sellprice = floor(sellprice * 0.1)
			var/initial_name = name
			name = "podrido [initial_name]"
			rotten = TRUE

/obj/item/natural/head/MiddleClick(mob/living/user, list/modifiers)
	var/obj/item/held_item = user.get_active_held_item()
	if(held_item)
		var/path_to_check = ispath(held_item) ? held_item : held_item.type
		if(ispath(path_to_check, /obj/item/weapon/knife))
			var/butchering_skill = GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering)
			var/used_time = 8
			used_time = (used_time - 0.5 * butchering_skill) SECONDS
			visible_message("[user] comienza a despiezar a \the [src].")
			playsound(src, 'sound/foley/gross.ogg', 100, FALSE)
			var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE)/4
			if(do_after(user, used_time, src))
				var/obj/item/I = new meat_to_give(get_turf(src))
				if(rotten && istype(I,/obj/item/reagent_containers/food/snacks))
					var/obj/item/reagent_containers/food/snacks/F = I
					F.become_rotten()

				new /obj/effect/decal/cleanable/blood/splatter(get_turf(src))
				user.adjust_experience(/datum/attribute/skill/labor/butchering, amt2raise, FALSE)
				qdel(src)
	..()

/obj/item/natural/head/volf
	name = "cabeza de lobo"
	desc = "La cabeza cortada de un temible volf."
	icon_state = "volfhead"
	sellprice = 5
	blood_value = BLOOD_VOLUME_SURVIVE
	item_weight = 1.2 KILOGRAMS

/obj/item/natural/head/saiga
	name = "cabeza de saiga"
	desc = "La cabeza cortada de un orgulloso saiga."
	icon_state = "saigahead"
	sellprice = 3
	blood_value = BLOOD_VOLUME_BAD
	item_weight = 1.2 KILOGRAMS

/obj/item/natural/head/troll
	name = "cabeza de troll"
	desc = "La cabeza cortada de un troll gigante."
	icon_state = "trollhead"
	grid_height = 96
	grid_width = 96
	w_class = WEIGHT_CLASS_BULKY
	sellprice = 20
	blood_value = BLOOD_VOLUME_OKAY
	item_weight = 2.1 KILOGRAMS

/obj/item/natural/head/troll/apply_components()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/natural/head/troll/axe
	name = "cabeza de troll"
	desc = "La cabeza cortada de un troll guerrero que alguna vez fue poderoso."
	icon_state = "trollhead_axe"
	sellprice = 30

/obj/item/natural/head/troll/cave
	name = "cabeza de troll de las cavernas"
	icon_state = "cavetrollhead"
	sellprice = 45

/obj/item/natural/head/rous
	name = "cabeza de rous"
	desc = "La cabeza cortada de una rata inusualmente grande."
	icon_state = "roushead"
	sellprice = 2
	meat_to_give = /obj/item/reagent_containers/food/snacks/meat/mince/beef
	item_weight = 500 GRAMS

/obj/item/natural/head/direbear
	name = "cabeza de oso horrendo"
	desc = "La cabeza de un aterrador oso terrible."
	icon_state = "direbearhead"
	layer = 3.1
	sellprice = 20
	blood_value = BLOOD_VOLUME_SAFE
	item_weight = 1.6 KILOGRAMS

/obj/item/natural/head/fox
	name = "cabeza venard"
	desc = "La cabeza de un majestuoso venardo."
	icon_state = "foxhead"
	layer = 3.1
	grid_height = 32
	sellprice = 12 // fur trade
	blood_value = BLOOD_VOLUME_SURVIVE
	item_weight = 400 GRAMS

/obj/item/natural/head/spider
	name = "cabeza de abeja"
	desc = "La cabeza cortada de una araña abeja venenosa."
	icon_state = "spiderhead"
	sellprice = 6
	meat_to_give = /obj/item/reagent_containers/food/snacks/meat/strange
	item_weight = 200 GRAMS

/obj/item/natural/head/bug
	name = "cabeza de chinche"
	desc = "La cabeza cortada de un chinche asqueroso."
	icon_state = "boghead"
	sellprice = 10
	meat_to_give = /obj/item/reagent_containers/food/snacks/meat/strange
	item_weight = 400 GRAMS

/obj/item/natural/head/mole
	name = "cabeza de topo"
	desc = "La cabeza cortada de un topo menor."
	icon_state = "molehead"
	grid_height = 96
	grid_width = 96
	sellprice = 8
	blood_value = BLOOD_VOLUME_SURVIVE
	item_weight = 765 GRAMS

/obj/item/natural/head/mole/apply_components()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/natural/head/gote
	name = "cabeza goteada"
	desc = "La cabeza cortada de un goto de fuego."
	icon_state = "gotehead"
	sellprice = 3
	blood_value = BLOOD_VOLUME_SURVIVE / 2
	item_weight = 1.1 KILOGRAMS

//RTD make this a storage item and make clickign on animals with things put it in storage
/obj/item/natural/saddle
	name = "montura"
	desc = "Una culminacion de cuero, pieles y pieles. Atado a la espalda de las bestias para facilitar su conduccion."
	icon_state = "saddle"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = FLAMMABLE
	gripped_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	sellprice = 30
	item_weight = 7 KILOGRAMS //heavy as shit according to equsitrian wikis (this is for an english saddle)

/obj/item/natural/saddle/apply_components()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/natural/saddle/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /mob/living/simple_animal))
		return NONE

	var/mob/living/simple_animal/simple = interacting_with

	if(!simple.can_saddle || simple.ssaddle)
		return ITEM_INTERACT_BLOCKING

	if(simple.has_buckled_mobs())
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_warning("[user] intenta montar [simple]..."))

	if(!do_after(user, 4 SECONDS, simple))
		return ITEM_INTERACT_BLOCKING

	playsound(src, 'sound/foley/saddledismount.ogg', 100, FALSE)
	user.dropItemToGround(src)
	simple.ssaddle = src
	forceMove(simple)
	simple.update_appearance(UPDATE_OVERLAYS)

	return ITEM_INTERACT_SUCCESS

/mob/living/simple_animal/onbite(mob/living/user)
	. = ..()
	if(.)
		return
	var/damage = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)*0.5
	if(HAS_TRAIT(user, TRAIT_STRONGBITE))
		damage = damage*2
	user.do_attack_animation(src, ATTACK_EFFECT_BITE)
	playsound(user, "smallslash", 100, FALSE, -1)
	user.next_attack_msg.Cut()
	if(stat == DEAD && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(user.has_status_effect(/datum/status_effect/debuff/silver_bane))
			to_chat(user, span_notice("¡Mi poder esta debilitado, no puedo sanar!"))
			return TRUE
		if(is_species(user, /datum/species/werewolf))
			visible_message(span_danger("¡[user] consume vorazmente [src]!"), span_warning("Me alimento de carne suculenta. Me siento revitalizado."))
			H.rage_datum?.update_rage(WW_RAGE_HIGH)
			gib()
		return TRUE
	if(!src.apply_damage(damage, BRUTE))
		return TRUE
	if(is_species(user, /datum/species/werewolf))
		visible_message(span_danger("[user] muerde a [src] y ¡se revuelve!"))
	else
		visible_message(span_danger("¡[user] muerde a [src]!"))
	if(HAS_TRAIT(user, TRAIT_POISONBITE) && src.reagents)
		var/poison = GET_MOB_ATTRIBUTE_VALUE(user, STAT_CONSTITUTION)/2
		src.reagents.add_reagent(/datum/reagent/toxin/venom, poison/2)
		src.reagents.add_reagent(/datum/reagent/medicine/soporpot, poison)
		to_chat(user, span_warning("¡Tus colmillos inyectan veneno en [src]!"))
