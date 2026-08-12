/* KNIVES - Low damage, bad parry, ok AP
==========================================================*/

/obj/item/weapon/knife
	name = "cuchillo"
	icon = 'icons/roguetown/weapons/32/knives.dmi'
	icon_state = "huntingknife"
	force = DAMAGE_KNIFE
	throwforce = DAMAGE_KNIFE
	wdefense = MEDIOCRE_PARRY
	wbalance = HARD_TO_DODGE
	wlength = WLENGTH_SHORT
	possible_item_intents = list(DAGGER_CUT, DAGGER_THRUST, DAGGER_CHOP)
	max_blade_int = 150
	max_integrity = INTEGRITY_STANDARD

	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	gripsprite = FALSE
	thrown_bclass = BCLASS_CUT
	w_class = WEIGHT_CLASS_SMALL
	parrysound = list('sound/combat/parry/bladed/bladedsmall (1).ogg','sound/combat/parry/bladed/bladedsmall (2).ogg','sound/combat/parry/bladed/bladedsmall (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshmed (1).ogg','sound/combat/wooshes/bladed/wooshmed (2).ogg','sound/combat/wooshes/bladed/wooshmed (3).ogg')
	associated_skill = /datum/attribute/skill/combat/knives
	pickup_sound = 'sound/foley/equip/swordsmall2.ogg'
	equip_sound = 'sound/foley/dropsound/holster_sword.ogg'
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	melting_material = /datum/material/iron
	melt_amount = 50
	sharpness = IS_SHARP
	sellprice = 30

	grid_height = 64
	grid_width = 32
	item_weight = 200 GRAMS
	tool_behaviour = TOOL_KNIFE

/obj/item/weapon/knife/Initialize()
	. = ..()
	AddElement(/datum/element/tipped_item, _max_reagents = 10, _dip_amount = 5, _inject_amount = 0.5)

/obj/item/weapon/knife/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -8,"sy" = 0,"nx" = 9,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................ Hunting Knife ............... //
/obj/item/weapon/knife/hunting
	name = "cuchillo de caza"
	desc = "Compañero leal de cazadores y cazadores furtivos, desde el hueso humilde hasta el acero mas puro, destripa a tu presa con alegria."
	icon_state = "huntingknife"
	force = DAMAGE_DAGGER
	melting_material = /datum/material/steel
	max_integrity = INTEGRITY_STRONG
	melt_amount = 75
	sellprice = 6
	item_weight = 150 GRAMS

/obj/item/weapon/knife/dagger/navaja
	name = "navaja"
	desc = "Una navaja plegable utilizada por el gremio de Mercator. Posee una empuñadura larga, lo que permite una hoja de tamaño considerable con buen alcance."
	icon_state = "navaja_c"
	item_state = "elfdag"
	force = DAMAGE_KNIFE / 2
	possible_item_intents = list(DAGGER_THRUST,DAGGER_CUT)
	var/extended = 0
	wdefense = TERRIBLE_PARRY
	sellprice = 30 //shiny :o
	item_weight = 100 GRAMS

/obj/item/weapon/knife/dagger/navaja/attack_self(mob/user)
	extended = !extended
	playsound(src, 'sound/blank.ogg', 50, TRUE)
	if(extended)
		force = DAMAGE_KNIFE * 2
		wdefense = MEDIOCRE_PARRY
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = 23
		icon_state = "navaja_o"
		attack_verb = list("cortado", "apuñalado", "rebanado", "desgarrado", "desgarrado", "picado", "corta")
		sharpness = IS_SHARP
		playsound (user, 'sound/items/knife_open.ogg', 100, TRUE)
	else
		force = DAMAGE_KNIFE / 2
		w_class = WEIGHT_CLASS_SMALL
		throwforce = DAMAGE_KNIFE / 2
		icon_state = "navaja_c"
		attack_verb = list("golpeado", "pinchado")
		sharpness = IS_BLUNT
		wdefense = TERRIBLE_PARRY

/obj/item/weapon/knife/scissors
	name = "tijeras de hierro"
	desc = "Tijeras hechas de hierro que pueden usarse para recuperar materiales utilizables de la ropa."
	icon = 'icons/roguetown/weapons/tools.dmi'
	icon_state = "iscissors"
	possible_item_intents = list(DAGGER_THRUST, DAGGER_CUT, SCISSOR_SNIP)
	max_integrity = INTEGRITY_POOR
	melt_amount = 75
	item_weight = 250 GRAMS

/datum/intent/snip // The salvaging intent! Used only for the scissors for now!
	name = "recorte"
	icon_state = "insnip"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0
	no_attack = TRUE
	releasedrain = 0
	blade_class = BCLASS_PUNCH

/obj/item/weapon/knife/scissors/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.cmode)
		return NONE

	if(!isitem(interacting_with))
		return NONE

	if(!isturf(interacting_with.loc))
		return NONE

	if(!istype(user.used_intent, /datum/intent/snip))
		return NONE

	var/obj/item/item = interacting_with

	if(!item.sewrepair || !item.salvage_result) // We can only salvage objects which can be sewn!
		return NONE

	var/skill_level = GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/misc/sewing)

	var/salvage_time = (7 SECONDS - (skill_level * 10))
	if(!do_after(user, salvage_time, item))
		return ITEM_INTERACT_BLOCKING

	if(item.fiber_salvage) //We're getting fiber as base if fiber is present on the item
		new /obj/item/natural/fibers(get_turf(item))

	if(istype(item, /obj/item/storage))
		var/obj/item/storage/bag = item
		bag.emptyStorage()

	var/probability = max(0, 50 - (skill_level * 10))
	if(prob(probability))
		to_chat(user, span_warning("Arruine algunos de los materiales debido a mi falta de habilidad..."))
		playsound(item, 'sound/foley/cloth_rip.ogg', 50, TRUE)
		qdel(item)
		user.mind.add_sleep_experience(item.sewrepair, GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE)) //Getting exp for failing
		return ITEM_INTERACT_SUCCESS

	item.salvage_amount -= item.torn_sleeve_number
	for(var/i in 1 to item.salvage_amount)
		var/obj/item/Sr = new item.salvage_result(get_turf(item))
		Sr.color = item.color

	user.visible_message(span_notice("[user] recupera [item] en materiales utilizables."))
	playsound(item, 'sound/items/flint.ogg', 100, TRUE) //In my mind this sound was more fitting for a scissor
	qdel(item)
	user.mind.add_sleep_experience(item.sewrepair, GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE))

	return ITEM_INTERACT_SUCCESS

/obj/item/weapon/knife/scissors/steel
	name = "tijeras de acero"
	desc = "Tijeras hechas de acero solido que pueden usarse para recuperar materiales utilizables de la ropa, mas duraderas y un poco mas mortales que su contraparte de hierro."
	icon_state = "sscissors"
	force = DAMAGE_DAGGER
	max_integrity = INTEGRITY_STANDARD
	melting_material = /datum/material/steel
	item_weight = 280 GRAMS

//................ Cleaver ............... //
/obj/item/weapon/knife/cleaver
	name = "cuchilla de carnicero"
	desc = "La herramienta de un chef convertida en armamento corta la carne engorrosa con una facilidad rudimentaria."
	icon_state = "cleav"
	possible_item_intents = list(DAGGER_CUT, CLEAVER_CHOP)
	force = DAMAGE_KNIFE + 1
	throwforce = DAMAGE_KNIFE + 6
	parrysound = list('sound/combat/parry/bladed/bladedmedium (1).ogg','sound/combat/parry/bladed/bladedmedium (2).ogg','sound/combat/parry/bladed/bladedmedium (3).ogg')
	swingsound = list('sound/combat/wooshes/bladed/wooshmed (1).ogg','sound/combat/wooshes/bladed/wooshmed (2).ogg','sound/combat/wooshes/bladed/wooshmed (3).ogg')
	max_integrity = INTEGRITY_POOR
	slot_flags = ITEM_SLOT_HIP
	thrown_bclass = BCLASS_CHOP
	w_class = WEIGHT_CLASS_NORMAL
	melt_amount = 75
	wbalance = DODGE_CHANCE_NORMAL // Except this one, too huge and used to chop
	item_weight = 350 GRAMS

//................ Hack-Knife ............... //
/obj/item/weapon/knife/cleaver/combat
	name = "cuchillo para cortar"
	desc = "Una espada corta con la que incluso las manos mas debiles pueden aspirar a hacer daño."
	icon_state = "combatknife"
	force = DAMAGE_KNIFE + 3
	throwforce = DAMAGE_KNIFE + 5
	possible_item_intents = list(DAGGER_CUT, CLEAVER_CHOP) // Its a steel cleaver, plus it lets you use it with a meathook as both cleaver to chop the animal and a knife to skin it
	max_integrity = INTEGRITY_STANDARD
	melting_material = /datum/material/steel
	wbalance = HARD_TO_DODGE
	sellprice = 15
	item_weight = 250 GRAMS

//................ Bronze Dagger ............... //s
/obj/item/weapon/knife/dagger/bronze
	name = "daga de bronce"
	desc = "Una daga hecha de bronce."
	icon_state = "dagger_bronze"
	max_integrity = INTEGRITY_POOR
	melting_material = /datum/material/bronze
	sellprice = 10
	item_weight = 180 GRAMS

//................ Iron Dagger ............... //
/obj/item/weapon/knife/dagger
	name = "daga de hierro"
	desc = "Muerte fina, aguda y puntiaguda."
	icon_state = "idagger"
	force = DAMAGE_DAGGER
	possible_item_intents = list(DAGGER_CUT, DAGGER_THRUST)
	sellprice = 12

	weapon_special = /datum/special_intent/triple_stab
	item_weight = 200 GRAMS

/obj/item/weapon/knife/dagger/jile
	name = "jile de hierro"
	desc = "Una daga de hierro curvada del este caido."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "jile_iron"
	item_weight = 200 GRAMS

/obj/item/weapon/knife/hunting/kukri/iron
	name = "kukri de hierro"
	icon_state = "kukri_iron"
	desc = "Un cuchillo pesado que se origino en los confines sureste de Faience. Su diseño lo hace ideal para cortar vegetacion y otros obstaculos."
	force = DAMAGE_DAGGER
	possible_item_intents = list(DAGGER_CUT, DAGGER_CHOP, DAGGER_THRUST)
	max_integrity = INTEGRITY_STANDARD
	melting_material = /datum/material/iron
	item_weight = 250 GRAMS

/obj/item/weapon/knife/dagger/njora
	name = "seme de hierro"
	desc = "Una ancha daga de hierro del este caido. Popular entre los elfos."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "njora_iron"
	possible_item_intents = list(DAGGER_CUT, DAGGER_CHOP, DAGGER_THRUST)
	sellprice = 12
	item_weight = 220 GRAMS

//................ Steel Dagger ............... //
/obj/item/weapon/knife/dagger/steel
	name = "daga de acero"
	desc = "Una daga hecha de acero refinado."
	icon_state = "sdagger"
	wdefense = AVERAGE_PARRY
	wbalance = VERY_HARD_TO_DODGE
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	melting_material = /datum/material/steel
	item_weight = 220 GRAMS

/obj/item/weapon/knife/dagger/steel/jile
	name = "jile de acero"
	desc = "Una daga de acero curvada del este caido."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "jile_steel"
	sellprice = 20
	item_weight = 220 GRAMS

/obj/item/weapon/knife/dagger/steel/njora
	name = "semeja de acero"
	desc = "Una amplia daga de acero del este caido. Popular entre los elfos."
	icon = 'icons/roguetown/weapons/32/lakkari.dmi'
	icon_state = "njora_steel"
	wbalance = HARD_TO_DODGE
	possible_item_intents = list(DAGGER_CUT, DAGGER_CHOP, DAGGER_THRUST)
	sellprice = 20
	item_weight = 240 GRAMS

/obj/item/weapon/knife/dagger/steel/special
	icon_state = "sdaggeralt"
	desc = "Una daga de acero refinado y de apariencia aun mas refinada."

/obj/item/weapon/knife/dagger/steel/royal
	name = "daga decorada"
	icon_state = "gsdagger"
	desc = "Una daga de acero refinado con suntuosa decoracion dorada, que incluso en manos de la mayoria de los nobles se considera demasiado decadente."
	item_weight = 230 GRAMS

/obj/item/weapon/knife/dagger/steel/stiletto
	name = "estilete"
	desc = "Una daga fina como una aguja hecha de acero refinado, el arma favorita de asesinos y nobles enojados."
	icon_state = "stiletto"
	possible_item_intents = list(STILETTO_THRUST, STILETTO_CUT)
	melt_amount = 45
	item_weight = 150 GRAMS

/obj/item/weapon/knife/hunting/kukri
	name = "kukri de acero"
	icon_state = "kukri_steel"
	desc = "Un cuchillo pesado que se origino en los confines sureste de Faience. Su diseño lo hace ideal para cortar vegetacion y otros obstaculos."
	force = DAMAGE_DAGGER + 1
	wdefense = AVERAGE_PARRY
	melt_amount = 75
	item_weight = 270 GRAMS

/obj/item/weapon/knife/dagger/steel/pestrasickle
	name = "hoz portadora de peste"
	desc = "Un borde perverso trae delicias feculentas."
	icon = 'icons/roguetown/weapons/32/patron.dmi'
	icon_state = "pestrasickle"
	wdefense = GOOD_PARRY //They use a dagger, but it should be fine for them to also parry with it.
	item_weight = 200 GRAMS

/obj/item/weapon/knife/dagger/steel/hand
	name = "\proper Fervor"
	desc = "Un trozo de acero muy forjado. Golpea con fervor el corazon de aquellos que ni siquiera saben donde acechas."
	icon_state = "sdaggerhand"
	sellprice = 200
	item_weight = 220 GRAMS

/obj/item/weapon/knife/dagger/steel/hand/parry
	name = "\proper apatia"
	desc = "Un trozo de acero muy forjado hecho para poder parar. Defiendete con Apatia de cualquier ataque que se acerque a ti, porque sabes que no haran contacto."
	wdefense = GOOD_PARRY
	icon_state = "spdaggerhand"
	item_weight = 220 GRAMS

//................ Fanged dagger ............... //
/obj/item/weapon/knife/dagger/steel/dirk
	name = "daga con colmillos"
	desc = "Una daga modelada a partir del colmillo de una araña con antrax."
	icon = 'icons/roguetown/weapons/32/elven.dmi'
	icon_state = "spiderdagger"
	item_weight = 200 GRAMS

/obj/item/weapon/knife/dagger/steel/dirk/baotha //this is a placeholder weapon until they actually receive a proper baothan weapon
	name = "daga entrelazada"
	desc = "Los susurros de felicidad se filtran mas profundamente que la espada."
	color = "#f78ccc"
	wdefense = GOOD_PARRY //They use a dagger, but it should be fine for them to also parry with it.
	item_weight = 200 GRAMS

/obj/item/weapon/knife/dagger/steel/dirk/baotha/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/on_hit/baothagift)


//................ Silver Dagger ............... //
/obj/item/weapon/knife/dagger/silver
	name = "daga de plata"
	desc = "Una daga hecha de plata fina, la pesadilla de los no-muertos."
	icon_state = "sildagger"
	max_blade_int = 160
	max_integrity = INTEGRITY_STRONG * 0.8
	melting_material = /datum/material/silver
	sellprice = 45
	last_used = 0
	item_weight = 210 GRAMS

/obj/item/weapon/knife/dagger/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Psydonian Dagger ............... //
/obj/item/weapon/knife/dagger/silver/psydon
	name = "Daga psydonian"
	desc = "Una daga de plata preferida por los luchadores de la Inquisicion a corta distancia."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psydagger"
	sellprice = 60
	item_weight = 210 GRAMS

//................ Profane Dagger ............... //
/obj/item/weapon/knife/dagger/steel/profane
	// name = "profane dagger"
	// desc = "A profane dagger made of cursed black steel. Whispers emanate from the gem on its hilt."
	possible_item_intents = list(DAGGER_CUT, DAGGER_THRUST, FACE_STEAL)
	max_blade_int = 300
	icon_state = "pdagger"
	melting_material = null
	melt_amount = 0
	embedding = list("embed_chance" = 0) // Embedding the cursed dagger has the potential to cause duping issues. Keep it like this unless you want to do a lot of bug hunting.
	resistance_flags = INDESTRUCTIBLE
	stealthy_audio = TRUE
	sellprice = 250
	item_weight = 200 GRAMS

/obj/item/weapon/knife/dagger/steel/profane/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_ASSASSIN))
		. += "profane dagger whispers, \"[span_danger("Here we are!")]\""

/obj/item/weapon/knife/dagger/steel/profane/get_examine_icon(mob/user)
	if(isobserver(user) || HAS_TRAIT(user, TRAIT_ASSASSIN) || get_dist(user, src) < 1)
		return ..()
	return ma2html(mutable_appearance(icon, "sdagger"), user)

/obj/item/weapon/knife/dagger/steel/profane/pickup(mob/living/M)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if (!HAS_TRAIT(H, TRAIT_ASSASSIN)) // Non-assassins don't like holding the profane dagger.
			H.add_stress(/datum/stress_event/profane)
			to_chat(M, "<span class='danger'>Tu aliento se congela cuando recoges la daga. ¡Sientes una sensacion de maldad morbosa!</span>")
			var/message = pick(
				"<span class='danger'>Help me...</span>",
				"<span class='danger'>Save me...</span>",
				"<span class='danger'>It's cold...</span>",
				"<span class='danger'>Free us...please...</span>",
				"<span class='danger'>Necra...deliver...us...</span>")
//			H.visible_message("profane dagger whispers, \"[message]\"")
			to_chat(M, "cuchillo profano susurros, \"[message]\"")
		else
			var/message = pick(
				"<span class='danger'>Why...</span>",
				"<span class='danger'>...Who sent you?</span>",
				"<span class='danger'>...You will burn for what you've done...</span>",
				"<span class='danger'>I hate you...</span>",
				"<span class='danger'>Someone stop them!</span>",
				"<span class='danger'>Guards! Help!</span>",
				"<span class='danger'>...What's that in your hand?</span>",
				"<span class='danger'>...You love me...don't you?</span>",
				"<span class='danger'>Wait...don't I know you?</span>",
				"<span class='danger'>I thought you were...my friend...</span>",
				"<span class='danger'>How long have I been in here...</span>")
//			H.visible_message("profane dagger whispers, \"[message]\"")
			to_chat(M, "cuchillo profano susurros, \"[message]\"")

/obj/item/weapon/knife/dagger/steel/profane/pre_attack(mob/living/carbon/human/target, mob/living/user, list/modifiers)
	if(!istype(target))
		return FALSE
	if(target.has_quirk(/datum/quirk/vice/hunted) || HAS_TRAIT(target, TRAIT_ZIZOID_HUNTED)) // Check to see if the dagger will do 20 damage or 14
		force = DAMAGE_KNIFE * 2
	else
		force = DAMAGE_DAGGER + 2
	return FALSE

/obj/item/weapon/knife/dagger/steel/profane/afterattack(mob/living/carbon/human/target, mob/living/user, proximity_flag, list/modifiers)
	. = ..()
	if(!ishuman(target))
		return
	if(target.stat == DEAD || HAS_TRAIT(target, TRAIT_CRITICAL_CONDITION)) // Trigger soul steal or identity theft if the target is either dead or in crit
		if(istype(user.used_intent, /datum/intent/peculate))
			if(!ishuman(user)) // carbons don't have all features of a human
				to_chat(user, span_danger("¡No puedes hacer eso!"))
				return
			var/obj/item/bodypart/head/target_head = target.get_bodypart(BODY_ZONE_HEAD)
			if(QDELETED(target_head))
				to_chat(user, span_notice("¡Necesito su cabeza o no puedo tomar su cara!"))
				return
			if(!(target.dna?.species.id in RACES_PLAYER_ALL))
				to_chat(user, span_warning("¡No puedo robar esta cara!"))
				return
			var/datum/beam/transfer_beam = user.Beam(target, icon_state = "drain_life", time = 6 SECONDS)

			playsound(
				user,
				get_sfx("changeling_absorb"), //todo: turn sound keys into defines.
				100,
			)
			to_chat(user, span_danger("Comienzo a absorber la identidad de [target]."))
			if(!do_after(user, 3 SECONDS, target = target))
				qdel(transfer_beam)
				return

			playsound( // and anotha one
				user,
				get_sfx("changeling_absorb"),
				100,
			)

			if(!do_after(user, 3 SECONDS, target = target))
				qdel(transfer_beam)
				return

			if(!user.client)
				qdel(transfer_beam)
				return
			qdel(transfer_beam)

			var/mob/living/carbon/human/human_user = user

			human_user.copy_physical_features(target)
			human_user.copy_visible_organs(target)
			to_chat(user, span_purple("Asumo una nueva cara.."))
			ADD_TRAIT(target, TRAIT_DISFIGURED, TRAIT_GENERIC)

			return

		if(target.has_quirk(/datum/quirk/vice/hunted) || HAS_TRAIT(target, TRAIT_ZIZOID_HUNTED)) // The profane dagger only thirsts for those who are hunted, by flaw or by zizoid curse.
			if(target.has_quirk(/datum/quirk/vice/hardcore))
				if(HAS_TRAIT(target, TRAIT_HARDCORE_PROFANE))
					return
				record_featured_stat(FEATURED_STATS_CRIMINALS, user)
				record_round_statistic(STATS_ASSASSINATIONS)
				user.adjust_triumphs(1)
				target.visible_message("¡El alma de <span class='danger'>[target] es arrancada de su cuerpo y succionada por la daga profana!</span>", "<span class='danger'>¡Mi alma esta atrapada dentro de la daga profana! ¡Maldita sea!</span>")
				playsound(src, 'sound/magic/soulsteal.ogg', 100, extrarange = 5)
				blade_int = max_blade_int // Stealing a soul successfully sharpens the blade.
				repair_damage(max_integrity) // And fixes the dagger. No blacksmith required!
				ADD_TRAIT(target, TRAIT_HARDCORE_PROFANE, "[type]")
			else if(target.client == null) //See if the target's soul has left their body
				to_chat(user, "<span class='danger'>El alma de tu objetivo ya ha escapado de su cadaver... ¡intentas devolverle la llamada!</span>")
				get_profane_ghost(target,user) //Proc to capture a soul that has left the body.
			else
				user.adjust_triumphs(1)
				init_profane_soul(target, user) //If they are still in their body, send them to the dagger!

/obj/item/weapon/knife/dagger/steel/profane/proc/init_profane_soul(mob/living/carbon/human/victim, mob/user)
	record_featured_stat(FEATURED_STATS_CRIMINALS, user)
	record_round_statistic(STATS_ASSASSINATIONS)

	var/mob/living/simple_animal/shade/soulstone_spirit = new /mob/living/simple_animal/shade(src)
	soulstone_spirit.AddComponent(/datum/component/soulstoned, src)
	soulstone_spirit.name = "alma de [victim.real_name]"
	soulstone_spirit.real_name = "soul of [victim.real_name]"
	soulstone_spirit.PossessByPlayer(victim.key)
	victim.language_holder?.copy(soulstone_spirit)
	if(user)
		soulstone_spirit.language_holder?.copy_known_languages_from(user)
	soulstone_spirit.get_language_holder().omnitongue = TRUE //Grants omnitongue

	soulstone_spirit.cancel_camera()

	victim.visible_message(span_danger("¡El alma de [victim] es arrancada de su cuerpo y absorbida por la daga profana!"), span_danger("Mi alma esta atrapada dentro de la daga profana. ¡Maldita sea!"))
	playsound(src, 'sound/magic/soulsteal.ogg', 100, extrarange = 5)
	blade_int = max_blade_int // Stealing a soul successfully sharpens the blade.
	repair_damage(max_integrity) // And fixes the dagger. No blacksmith required!

/obj/item/weapon/knife/dagger/steel/profane/proc/get_profane_ghost(mob/living/carbon/human/target, mob/user)
	var/mob/dead/observer/chosen_ghost
	var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit() //Check if a soul has already gone to the underworld
	if(underworld_spirit) // If they are in the underworld, pull them back to the real world and make them a normal ghost. Necra can't save you now!
		var/mob/dead/observer/ghost = underworld_spirit.ghostize()
		chosen_ghost = ghost.get_ghost(TRUE,TRUE)
	else //Otherwise, try to get a ghost from the real world
		chosen_ghost = target.get_ghost(TRUE,TRUE)
	if(!chosen_ghost || !chosen_ghost.client) // If there is no valid ghost or if that ghost has no active player
		return FALSE
	user.adjust_triumphs(1)
	init_profane_soul(target, user) // If we got the soul, store them in the dagger.
	qdel(chosen_ghost) // Get rid of that ghost!
	return TRUE

/obj/item/weapon/knife/dagger/steel/profane/proc/release_profane_souls() // For ways to release the souls trapped within a profane dagger, such as a Necrite burial rite. Returns the number of freed souls.
	var/freed_souls = 0
	for(var/mob/living/simple_animal/shade/shade in contents) // for every trapped soul in the dagger, whether they have left the game or not
		to_chat(shade, "<b>He sido liberado de mi vil prision, espero la fria garra de Necra. ¡Salvacion!</b>")
		freed_souls += 1
		shade.returntolobby()
		qdel(shade)
		visible_message(span_warning("El [shade.name] fluye fuera de la daga profana, finalmente libre de su agarre."))
	visible_message(span_warning("¡El puñal profano se desintegra en humo putrido!"))
	qdel(src) // Delete the dagger. Forevermore.
	return freed_souls

//................ Stone Knife ............... //
/obj/item/weapon/knife/stone
	name = "cuchillo de piedra"
	desc = "Una herramienta preferida por los elfos del bosque, facil de fabricar y util para desollar la carne de bestias y hombres por igual."
	icon_state = "stone_knife"
	wdefense = TERRIBLE_PARRY
	possible_item_intents = list(DAGGER_CUT, DAGGER_CHOP)
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	max_integrity = INTEGRITY_WORST - 70
	max_blade_int = 50
	smeltresult = /obj/item/fertilizer/ash
	melting_material = null
	melt_amount = 0
	sellprice = 5
	item_weight = 150 GRAMS

/obj/item/weapon/knife/stone/kukri
	name = "joapstone kukri"
	desc = "Un kukri hecho de joapstone. Es mas una pieza ceremonial que un instrumento de guerra, es algo fragil. Sea amable con eso."
	icon = 'icons/roguetown/gems/gem_jade.dmi'
	icon_state = "kukri_jade"
	wdefense = AVERAGE_PARRY
	max_integrity = INTEGRITY_WORST / 2
	max_blade_int = 35
	resistance_flags = FIRE_PROOF | ACID_PROOF
	sellprice = 75
	item_weight = 220 GRAMS

/obj/item/weapon/knife/stone/opal
	name = "cuchillo opaloise"
	desc = "Un hermoso cuchillo tallado en opaloise. No esta destinado al combate. Su presencia es vital en algunas ceremonias de Crimson Elven."
	icon = 'icons/roguetown/gems/gem_opal.dmi'
	icon_state = "knife_opal"
	wdefense = AVERAGE_PARRY
	max_integrity = INTEGRITY_WORST / 2
	max_blade_int = 35
	resistance_flags = FIRE_PROOF | ACID_PROOF
	sellprice = 105
	item_weight = 180 GRAMS

//................ Villager Knife ............... //
/obj/item/weapon/knife/villager
	name = "cuchillo aldeano"
	desc = "El fiel compañero de los sencillos campesinos, capaz de cortar pan duro y tallar madera. Un utensilio y herramienta de cocina versatil."
	icon_state = "villagernife"
	melt_amount = 25
	item_weight = 120 GRAMS

/obj/item/weapon/knife/copper
	name = "cuchillo de cobre"
	desc = "Un cuchillo de diseño antiguo, el cobre sirve bastante decente."
	icon_state = "cdagger"
	possible_item_intents = list(DAGGER_CUT, DAGGER_THRUST)
	max_blade_int = 100
	max_integrity = INTEGRITY_WORST
	melting_material = /datum/material/copper
	sellprice = 10
	item_weight = 180 GRAMS

/obj/item/weapon/knife/throwingknife
	name = "tossblade de hierro"
	desc = ""
	item_state = "bone_dagger"
	force = DAMAGE_DAGGER
	throwforce = DAMAGE_DAGGER + 13
	wdefense = MEDIOCRE_PARRY
	throw_speed = 4
	max_integrity = INTEGRITY_WORST - 50
	icon_state = "throw_knifei"
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 30, "embedded_fall_chance" = 20)
	melt_amount = 50
	sellprice = 3
	flags_ai_inventory = AI_ITEM_THROWING
	item_weight = 80 GRAMS

/obj/item/weapon/knife/throwingknife/bronze
	name = "tossblade de bronce"
	desc = "Una tossblade forjada en bronce. No es tan confiable como otras tossblades, pero es mucho mas barata de fabricar."
	item_state = "bone_dagger"
	throwforce = DAMAGE_DAGGER + 10
	throw_speed = 4
	max_integrity = INTEGRITY_WORST - 30
	icon_state = "throwing_bronze"
	embedding = list("embedded_pain_multiplier" = 3, "embed_chance" = 25, "embedded_fall_chance" = 15)
	melting_material = /datum/material/bronze
	sellprice = 2
	item_weight = 75 GRAMS

/obj/item/weapon/knife/throwingknife/steel
	name = "tossblade de acero"
	desc = ""
	icon_state = "throw_knifes"
	item_state = "bone_dagger"
	throw_speed = 4
	max_integrity = INTEGRITY_WORST
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 50, "embedded_fall_chance" = 15)
	melting_material = /datum/material/steel
	sellprice = 4
	item_weight = 85 GRAMS

/obj/item/weapon/knife/throwingknife/psydon
	name = "tossblade psydonian"
	desc = "Un metodo poco convencional de entregar plata a un hereje; pero uno PSYDON sonrie ante ello, en fin. Se puede usar como un cuchillo 'real' en caso de necesidad."
	icon_state = "throw_knifes"
	item_state = "bone_dagger"
	wdefense = GOOD_PARRY
	throw_speed = 4
	max_integrity = INTEGRITY_WORST
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 50, "embedded_fall_chance" = 0)
	sellprice = 65
	melting_material = /datum/material/silver
	item_weight = 80 GRAMS

/obj/item/weapon/knife/throwingknife/psydon/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/weapon/knife/throwingknife/rous //Rousman exclusive item, can stay a bit better
	name = "kunai rous"
	desc = "Un cuchillo tipico usado por los asesinos rous. Muy efectivo cuando se lanza."
	icon_state = "rouskunai"
	wdefense = GOOD_PARRY
	throw_speed = 4
	max_integrity = INTEGRITY_POOR
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 30, "embedded_fall_chance" = 15)
	sellprice = 5
	item_weight = 80 GRAMS

/obj/item/weapon/knife/throwingknife/throwcard
	name = "\proper tarjeta de visita"
	desc = "Una fina lamina de hierro forjado en una tarjeta de presentacion, demasiado delgada e inutil para ser fundida. Te han timado. De Heartfelt con amor."
	icon_state = "throwcard"
	throw_speed = 5
	max_integrity = INTEGRITY_WORST - 50 // It's not about how effective it is, it's about sending a message.
	embedding = list("embedded_pain_multiplier" = 2, "embed_chance" = 50, "embedded_fall_chance" = 5)
	sellprice = 2
	item_weight = 30 GRAMS
