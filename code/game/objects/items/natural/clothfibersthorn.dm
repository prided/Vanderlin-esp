/obj/item/natural/fibers
	name = "fibra"
	desc = "Fibra vegetal. Los campesinos se ganan la vida confeccionandolos en telas y prendas de vestir."
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	color = "#454032"
	firefuel = 1 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/fibers
	item_flags = OBTAINED_DATA
	obtained_from = list(
		list("From foraging in bushes.", /obj/structure/flora/grass/bush_meagre),
		list("From cutting grass.", /obj/structure/flora/grass),
		list("From cutting leafy mushrooms.", /obj/structure/flora/grass/mushroom),
		list("From cutting herbal flowers.", /obj/structure/flora/grass/herb/atropa),
		list("From Threshing Chaff.", /obj/item/natural/chaff/wheat)
	)
	item_weight = 1 GRAMS

/obj/item/natural/fibers/sinew
	name = "fibra de tendon"
	desc = "Fibra de tendon. Hecho de tendones de animales sacrificados, comunmente utilizado por los cazadores para trabajar el cuero y fabricar arcos."
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	color = "#b7a87c"
	firefuel = 2 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/fibers/sinew

/obj/item/natural/silk
	name = "seda"
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	desc = "Hilos de seda. Su uso en la ropa es exotico en todos los lugares excepto en la Infraoscuridad."
	force = 0
	throwforce = 0
	color = "#e6e3db"
	firefuel = 1 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/silk
	item_weight = 1 GRAMS

#ifdef TESTSERVER

/client/verb/bloodnda()
	set category = "DEBUGTEST"
	set name = "sangre"
	set desc = ""

	var/obj/item/I
	I = mob.get_active_held_item()
	if(I)
		if(GET_ATOM_BLOOD_DNA(I))
			testing("yep")
		else
			testing("nope")

#endif

/obj/item/natural/thorn
	name = "espino"
	desc = "Esta espina cultivada en el pantano es afilada y resistente como una aguja."
	icon_state = "thorn"
	force = 10
	throwforce = 0
	possible_item_intents = list(/datum/intent/stab)
	firefuel = 1 MINUTES
	embedding = list("embedded_unsafe_removal_time" = 20, "embedded_pain_chance" = 10, "embedded_pain_multiplier" = 1, "embed_chance" = 35, "embedded_fall_chance" = 0)
	resistance_flags = FLAMMABLE
	max_integrity = 20
	item_weight = 3 GRAMS
	indexed = TRUE
	grind_results = list(/datum/reagent/thorn_essence = 10)

/obj/item/natural/thorn/attack_self(mob/living/user, list/modifiers)
	user.visible_message("<span class='warning'>[user] hace *clic* [src].</span>")
	playsound(user,'sound/items/seedextract.ogg', 100, FALSE)
	qdel(src)

/obj/item/natural/thorn/Crossed(mob/living/L)
	. = ..()
	if(istype(L))
		var/prob2break = 33
		if(L.m_intent == MOVE_INTENT_SNEAK)
			prob2break = 0
		if(L.m_intent == MOVE_INTENT_RUN)
			prob2break = 100
		if(prob(prob2break))
			playsound(src,'sound/items/seedextract.ogg', 100, FALSE)
			qdel(src)
			if (L.alpha == 0 && L.rogue_sneaking) // not anymore you're not
				L.update_sneak_invis(TRUE)
			L.consider_ambush()

/obj/item/natural/bundle/fibers
	name = "haz de fibras"
	desc = "Fibras agrupadas."
	icon_state = "fibersroll1"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	maxamount = 12
	color = "#454032"
	firemod =  1 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/fibers
	icon1step = 3
	icon2step = 6
	items_per_increase = 7

/obj/item/natural/bundle/fibers/full/Initialize()
	amount = maxamount
	. = ..()

/obj/item/natural/bundle/fibers/sinew
	name = "haz de fibras tendinosas"
	desc = "Fibras fibrosas, muy unidas entre si."
	icon_state = "fibersroll1"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	maxamount = 9
	color = "#b7a87c"
	firemod =  2 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/fibers/sinew
	icon1step = 3
	icon2step = 6

/obj/item/natural/bundle/silk
	name = "tejido de seda"
	icon_state = "fibersroll1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Seda cuidadosamente tejida."
	force = 0
	throwforce = 0
	maxamount = 6
	color = "#e6e3db"
	firemod = 1 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/silk
	icon1step = 3
	icon2step = 6

/obj/item/natural/bundle/cloth
	name = "paquete de tela"
	icon_state = "clothroll1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Un rollo de tela con varios trozos de tela."
	force = 0
	throwforce = 0
	maxamount = 10
	firemod = 3 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/cloth
	stackname = "tela"
	icon1 = "clothroll1"
	icon1step = 5
	icon2 = "clothroll2"
	icon2step = 10
	flags_ai_inventory = AI_ITEM_BANDAGE

/obj/item/natural/bundle/cloth/full/Initialize()
	. = ..()
	amount = maxamount
	update_bundle()

/obj/item/natural/bundle/stick
	name = "manojo de palos"
	desc = "Un manojo de palos de madera, ¡parece que todos necesitan mantenerse unidos!"
	icon_state = "stickbundle1"
	possible_item_intents = list(/datum/intent/use)
	maxamount = 10
	force = 0
	throwforce = 0
	firemod = 5 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/grown/log/tree/stick
	stackname = "palos"
	icon1 = "stickbundle1"
	icon1step = 4
	icon2 = "stickbundle2"
	icon2step = 7
	icon3 = "stickbundle3"

/obj/item/natural/bowstring
	name = "cuerda del arco"
	desc = "Una simple cuerda de arco."
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	color = "#e9dfc2"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE

/obj/item/natural/bundle/worms
	name = "gusanos"
	desc = "Multiples gusanos retorcidos."
	icon_state = "worm2"
	color = "#964B00"
	maxamount = 6
	icon1 = "worm2"
	icon1step = 3
	icon2 = "worm3"
	icon2step = 5
	icon3 = "worm4"
	stacktype = /obj/item/natural/worms
	stackname = "gusanos"

/obj/item/natural/bundle/bone
	name = "pila de huesos"
	icon_state = "bonestack1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Huesos apilados unos sobre otros."
	force = 0
	throwforce = 0
	maxamount = 6
	color = null
	firefuel = null
	firemod = 0
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/alch/bone
	stackname = "huesos"
	icon1 = "bonestack1"
	icon1step = 2
	icon2 = "bonestack2"
	icon2step = 4

/obj/item/natural/bundle/bone/full/Initialize()
	. = ..()
	amount = maxamount
	update_bundle()
