//┌─────────────── INHUMEN PANTHEON WEAPONS BELOW ───────────────┐

// god weapons should have 720 durability, and can reach 0 and become unusable but do not break and can be repaired

#define GOREFEAST_UNWORTHY list(\
	span_danger("No digno..."),\
	span_danger("Eres demasiado debil para manejarme."),\
	span_danger("¿Como conseguiste ponerte las manos encima de mi?"),\
	span_danger("Encuentra al orco mas cercano y entregamelo."),\
	span_danger("No estas preparado."),\
)

#define GOREFEAST_WORTHY list(\
	span_danger("¡Un digno!"),\
	span_danger("Bañame en su sangre."),\
	span_danger("Puedes oler su miedo, ¿no?"),\
	span_danger("Desata tu furia, empapa el suelo con su sangre."),\
	span_danger("Delicurense con sus organos."),\
	span_danger("¡Elimina al mundo de los debiles!"),\
	span_danger("Tontos por desafiarnos, señor de la guerra."),\
)

//┌─────────────── GOREFEAST ───────────────┐//
/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast
	name = "festin de sangre"
	desc = "Se dice que solo con esta hacha, Graggar mato a mil hombres. Contigo, matara a mil mas."
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	icon_state = "gorefeast"
	parrysound = "sword"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	force = DAMAGE_HEAVYAXE_WIELD
	force_wielded = DAMAGE_HEAVYAXE_WIELD + 5
	wdefense = GOOD_PARRY
	possible_item_intents = list(AXE_CUT, AXE_CHOP)
	gripped_intents = list(AXE_CUT, AXE_GRTCHOP, SWORD_STRIKE)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONGEST + 220
	minstr = 12
	resistance_flags = FIRE_PROOF
	sellprice = 550
	item_weight = 3.5 KILOGRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/Initialize(mapload, ...)
	. = ..()
	AddElement(/datum/element/divine_intervention, /datum/patron/inhumen/graggar, PUNISHMENT_STRESS, /datum/stress_event/divine_punishment, TRUE)

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/pickup(mob/user)
	. = ..()
	var/message
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_danger("El corazon palpitante de la hoja parece disminuir al verte... desinteresado."))
		user.playsound_local(user, pick('sound/misc/godweapons/gorefeast1.ogg', 'sound/misc/godweapons/gorefeast2.ogg', 'sound/misc/godweapons/gorefeast3.ogg'), 70)
		message = pick(GOREFEAST_UNWORTHY)
	else
		to_chat(user, span_danger("Gorefeast comienza a golpear extasiado al tocar el eje oseo."))
		user.playsound_local(user, pick('sound/misc/godweapons/gorefeast4.ogg', 'sound/misc/godweapons/gorefeast5.ogg', 'sound/misc/godweapons/gorefeast6.ogg'), 70)
		message = pick(GOREFEAST_WORTHY)
	addtimer(CALLBACK(src, PROC_REF(do_message), message), 2 SECONDS)

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/proc/do_message(message)
	audible_message("Gorefeast habla, \"[message]\"", hearing_distance = 5)

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/pre_attack(atom/A, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		force = 13
		force_wielded = 23
	else
		force = initial(force)
		force_wielded = initial(force_wielded)
	return ..()

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/afterattack(atom/target, mob/living/user, proximity_flag, list/modifiers)
	if(!ishuman(target))
		return
	if(check_zone(user.zone_selected) != BODY_ZONE_CHEST)
		return
	var/mob/living/carbon/human/H = target
	var/heart_crit = H.has_wound(/datum/wound/artery/heart)
	var/dead = H.stat == DEAD
	if(HAS_TRAIT(H, TRAIT_CRITICAL_CONDITION) || heart_crit || dead)
		var/fast = heart_crit || dead
		var/obj/item/organ/heart/heart = H.getorganslot(ORGAN_SLOT_HEART)
		if(!heart)
			to_chat(user, span_warning("¡Solo queda un pecho hueco!"))
			return FALSE
		to_chat(user, span_notice("Comienzo a arrancar el corazon de [H]..."))
		if(do_after(user, fast ? 5 SECONDS : 10 SECONDS, H))
			heart.Remove(H)
			heart.forceMove(H.drop_location())

			H.add_splatter_floor()
			var/obj/item/bodypart/chest = H.get_bodypart(BODY_ZONE_CHEST)
			chest.bodypart_attacked_by(BCLASS_PIERCE, 50, incoming_germ = germ_level)
			to_chat(user, span_notice("¡Acabo de sacar el corazon de [H]!"))
	. = ..()

#undef GOREFEAST_UNWORTHY
#undef GOREFEAST_WORTHY

//┌─────────────── NEANT ───────────────┐//
/obj/item/weapon/polearm/neant
	name = "neant"
	desc = "Una guadaña oscura con una cadena larga, utilizada para cortar la esencia vital de las personas o para darles forma. La hoja es de un siniestro color purpura."
	icon_state = "neant"
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	force = DAMAGE_SPEARPLUS + 2
	force_wielded = DAMAGE_SPEAR_WIELD
	throwforce = DAMAGE_SPEAR_WIELD
	possible_item_intents = list(SPEAR_CUT)
	gripped_intents = list(POLEARM_CHOP, WHIP_STRIKE, NEANT_SHOOT)
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONGEST + 220
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF

	thrown_bclass = BCLASS_CUT
	sellprice = 550
	item_weight = 3 KILOGRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

	COOLDOWN_DECLARE(fire_projectile)

/obj/item/weapon/polearm/neant/Initialize(mapload, ...)
	. = ..()
	AddElement(/datum/element/divine_intervention, /datum/patron/inhumen/zizo, PUNISHMENT_BURN, /datum/stress_event/divine_punishment, TRUE)

/obj/item/weapon/polearm/neant/attack(mob/living/M, mob/living/user, list/modifiers)
	if(user.used_intent.tranged)
		return
	return ..()

/obj/item/weapon/polearm/neant/afterattack(atom/target, mob/living/user, proximity_flag, list/modifiers)
	. = ..()
	if(!HAS_TRAIT(user, TRAIT_CABAL) || !istype(user.patron, /datum/patron/inhumen/zizo))
		return
	if(user.used_intent?.tranged)
		handle_magick(user, target)
		return
	if(!ishuman(target))
		return
	if(check_zone(user.zone_selected) != BODY_ZONE_CHEST)
		return
	var/mob/living/carbon/human/H = target
	if(H.get_lux_status() != LUX_HAS_LUX)
		return
	var/dead = H.stat == DEAD
	if(HAS_TRAIT(H, TRAIT_CRITICAL_CONDITION) || dead)
		var/speed = dead ? 3 SECONDS : 7 SECONDS
		visible_message(user, span_notice("El Neant se ilumina y comienza a destrozar a [target]..."))
		if(!do_after(user, speed, H))
			return
		var/obj/item/bodypart/chest/C = H.get_bodypart(BODY_ZONE_CHEST)
		if(!C)
			return
		playsound(user, 'sound/surgery/scalpel2.ogg', 70)
		if(do_after(user, 0.5 SECONDS, target))
			C.create_injury(WOUND_SLASH, BLEED_DAMAGE_RATIO/6, surgical = TRUE)

		playsound(user, 'sound/surgery/organ2.ogg', 70)
		if(do_after(user, 0.5 SECONDS, target))
			C.add_wound(/datum/wound/fracture/chest)

		new /obj/item/reagent_containers/lux(get_turf(target))

		H.apply_status_effect(/datum/status_effect/debuff/lux_drained)
		SEND_SIGNAL(user, COMSIG_LUX_EXTRACTED, target)
		record_featured_stat(FEATURED_STATS_CRIMINALS, user)
		record_round_statistic(STATS_LUX_HARVESTED)

		H.add_splatter_floor()
		var/obj/item/bodypart/chest = H.get_bodypart(BODY_ZONE_CHEST)
		chest.bodypart_attacked_by(BCLASS_PIERCE, 50, incoming_germ = germ_level)
		visible_message(user, span_notice("¡La espada de Neant atrae a lux de [target]!"))

/obj/item/weapon/polearm/neant/proc/handle_magick(mob/living/user, atom/target)
	if(!COOLDOWN_FINISHED(src, fire_projectile))
		return
	var/client/client = user.client
	if(!client?.chargedprog)
		return

	var/startloc = get_turf(src)
	var/obj/projectile/bullet/neant/PJ = new(startloc)
	PJ.starting = startloc
	PJ.firer = user
	PJ.fired_from = src
	PJ.original = target
	playsound(user,'sound/effects/neantspecial.ogg', 70)

	if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION) > 8)
		PJ.accuracy += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION) - 8) * 2 //each point of perception above 8 increases standard accuracy by 2.
		PJ.bonus_accuracy += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_PERCEPTION) - 8) //Also, increases bonus accuracy by 1, which cannot fall off due to distance.

	if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE) > 10) // Every point over 10 INT adds 10% damage
		PJ.damage = PJ.damage * (GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE) / 10)
		PJ.accuracy += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE) - 10) * 3

	new /obj/effect/temp_visual/dir_setting/firing_effect/neant(get_step(user, user.dir), user.dir)
	PJ.preparePixelProjectile(target, user)
	PJ.fire()
	user.changeNext_move(CLICK_CD_RANGE)
	COOLDOWN_START(src, fire_projectile, 4 SECONDS)

/obj/projectile/bullet/neant
	name = "Evisceracion profana"
	icon = 'icons/effects/effects.dmi'
	icon_state = "neantprojectile"
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	range = 8
	damage = 20
	armor_penetration = 30
	damage_type = BRUTE
	woundclass = BCLASS_CUT
	flag =  "piercing"
	speed = 1
	accuracy = 80

/obj/effect/temp_visual/dir_setting/firing_effect/neant
	icon = 'icons/effects/effects.dmi'
	icon_state = "neantspecial"
	duration = 4

//┌─────────────── TURBULENTA ───────────────┐//

/obj/item/gun/ballistic/bow/turbulenta
	name = "turbulenta"
	desc = "Rara vez le importa el combate, pero cuando lo hace... Baotha era toda una tiradora."
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	icon_state = "turbulenta"
	base_icon_state = "turbulenta"
	slot_flags = ITEM_SLOT_BACK
	SET_BASE_PIXEL(-16, -16)
	bigboy = TRUE
	fire_sound = 'sound/combat/Ranged/turbulentafire.ogg'
	possible_item_intents = list(/datum/intent/shoot/bow/turbulenta, /datum/intent/arc/bow/turbulenta)
	force = 12

	projectile_damage_multiplier = 1.1

	item_weight = 2 KILOGRAMS

	var/obj/item/instrument/harp/turbulenta/FUCK

/obj/item/gun/ballistic/bow/turbulenta/Initialize(mapload, ...)
	. = ..()
	AddElement(/datum/element/divine_intervention, /datum/patron/inhumen/baotha, PUNISHMENT_STRESS, /datum/stress_event/divine_punishment, TRUE)

/obj/item/gun/ballistic/bow/turbulenta/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.5,
					"sx" = -3,
					"sy" = -1,
					"nx" = 2,
					"ny" = 1,
					"wx" = -3,
					"wy" = 0,
					"ex" = -2,
					"ey" = -2,
					"nturn" = 99,
					"sturn" = -100,
					"wturn" = -102,
					"eturn" = 100,
					"nflip" = NONE,
					"sflip" = EAST,
					"wflip" = EAST,
					"eflip" = NONE,
					"northabove" = FALSE,
					"southabove" = TRUE,
					"eastabove" = TRUE,
					"westabove" = FALSE,
				)
			if("onback")
				return list(
					"shrink" = 0.55,
					"sx" = 1,
					"sy" = -1,
					"nx" = 1,
					"ny" = -1,
					"wx" = 2,
					"wy" = -1,
					"ex" = -2,
					"ey" = -1,
					"nturn" = 0,
					"sturn" = 0,
					"wturn" = 0,
					"eturn" = 0,
					"nflip" = NONE,
					"sflip" = EAST,
					"wflip" = EAST,
					"eflip" = NONE,
					"northabove" = TRUE,
					"southabove" = FALSE,
					"eastabove" = FALSE,
					"westabove" = FALSE,
				)

/obj/item/gun/ballistic/bow/turbulenta/Initialize(mapload, ...)
	. = ..()
	FUCK = new(src)

/obj/item/gun/ballistic/bow/turbulenta/Destroy(force)
	QDEL_NULL(FUCK)
	return ..()

/obj/item/gun/ballistic/bow/turbulenta/attack_self(mob/living/user, list/modifiers)
	if(chambered || !HAS_TRAIT(user, TRAIT_CRACKHEAD))
		return ..()
	FUCK.attack_self(user, modifiers)

/obj/item/gun/ballistic/bow/turbulenta/dropped(mob/user, silent)
	if(FUCK.playing)
		FUCK.terminate_playing(user)
	return ..()

/obj/item/gun/ballistic/bow/turbulenta/pre_attack(atom/A, mob/living/user, list/modifiers)
	if(FUCK.playing)
		FUCK.terminate_playing(user)
	return ..()

/obj/item/gun/ballistic/bow/turbulenta/before_firing(atom/target, mob/user)
	if(!HAS_TRAIT(user, TRAIT_CRACKHEAD))
		return
	var/obj/projectile/arrow = chambered?.loaded_projectile
	var/old_dam
	var/old_pen
	if(arrow)
		old_dam = arrow.damage
		old_pen = arrow.armor_penetration
		chambered.loaded_projectile = null
		qdel(arrow)
	arrow = new /obj/projectile/bullet/reusable/arrow/spiced(chambered)
	arrow.damage = old_dam || arrow.damage
	arrow.armor_penetration = old_pen || arrow.armor_penetration
	chambered.loaded_projectile = arrow

//┌─────────────── PLEONEXIA ───────────────┐//
/obj/item/weapon/sword/long/pleonexia
	icon_state = "pleonexia"
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	name = "pleonexia"
	desc = "Una espada de leyenda. Si son ciertas, entonces esta es la espada del propio Matthios. Se rumorea que roba espacio y tiempo."
	possible_item_intents = list(SWORD_STRIKE, SWORD_CUT)
	gripped_intents = list(SWORD_STRIKE, SWORD_CHOP, SWORD_THRUST, PLEX_BLINK)
	max_integrity = INTEGRITY_STRONGEST + 220
	sellprice = 550
	item_weight = 1.5 KILOGRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

	COOLDOWN_DECLARE(pleonexia_blink)

/obj/item/weapon/sword/long/pleonexia/Initialize(mapload, ...)
	. = ..()
	AddElement(/datum/element/divine_intervention, /datum/patron/inhumen/matthios, PUNISHMENT_STRESS, /datum/stress_event/divine_punishment, TRUE)

/obj/item/weapon/sword/long/pleonexia/pre_attack(atom/A, mob/living/user, list/modifiers)
	if(!istype(user.used_intent, /datum/intent/plex_dash) || !HAS_TRAIT(user, TRAIT_MATTHIOS_EYES))
		return ..()
	. = TRUE
	if(!isturf(user.loc))
		to_chat(user, span_notice("¡No puedo hacer esto desde dentro de [user.loc]!"))
		return
	if(!COOLDOWN_FINISHED(src, pleonexia_blink))
		to_chat(user, span_notice("¡Pleonexia no esta lista para parpadear de nuevo! [COOLDOWN_TIMELEFT(src, pleonexia_blink)/10] Segundos."))
		return
	var/turf/target = get_turf(A)
	if(target.is_blocked_turf(TRUE, user))
		target = get_step(target, get_dir(target, user))
	var/turf/starting = get_turf(user)
	var/list/affected_turfs = get_line(starting, target) - starting
	if(!LAZYLEN(affected_turfs))
		to_chat(user, span_notice("¡No hay nada que cortar!"))
		return
	user.visible_message(span_warning("[user] parpadea a traves del espacio."),
		span_notice("Atraveso el espacio con Pleonexia."))
	playsound(starting, "pleonexiaphase", 70, TRUE, -1)
	new /obj/effect/temp_visual/cut(starting)
	for(var/turf/affected_turf in affected_turfs)
		for(var/mob/living/L in affected_turf)
			if(L == user)
				continue
			L.Knockdown(1 SECONDS)
			L.Stun(1 SECONDS)
	user.forceMove(target)
	new /obj/effect/temp_visual/stab(target)
	COOLDOWN_START(src, pleonexia_blink, 10 SECONDS)

/obj/effect/temp_visual/cut
	icon_state = "pcut"
	duration = 3 DECISECONDS

/obj/effect/temp_visual/stab
	icon_state = "pstab"
	duration = 3 DECISECONDS

/datum/intent/plex_dash
	name = "parpadear"
	desc = "Haz parpadear dos fichas mas adelante, aturdiendo a quienes se encuentren en tu camino."
	icon_state = "peculate"
	hitsound = null
	noaa = TRUE
	reach = 3

//┌─────────────── TENNITE PANTHEON WEAPONS BELOW ───────────────┐

/obj/item/weapon/sword/long/grandmaster
	name = "espada larga divina"
	desc = "La espada de Saint Altierre. Una espada sagrada forjada en plata, que se dice representa su voluntad de luchar por todos nosotros y la justicia que ella representa."
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	icon_state = "martyrsword"
	item_weight = 1.5 KILOGRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

/datum/intent/sword/cut/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_CUT

/datum/intent/sword/thrust/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_PICK

/datum/intent/sword/strike/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_SMASH

/datum/intent/sword/chop/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_CHOP

/obj/item/weapon/sword/long/grandmaster/Initialize()
	. = ..()
	var/list/active_intents = list(/datum/intent/sword/cut/martyr, /datum/intent/sword/thrust/martyr, /datum/intent/sword/strike/martyr)
	var/list/active_intents_wielded = list(/datum/intent/sword/cut/martyr, /datum/intent/sword/thrust/martyr, /datum/intent/sword/strike/martyr, /datum/intent/sword/chop/martyr)
	var/safe_damage = 25
	var/safe_damage_wielded = 30
	AddComponent(/datum/component/martyr_weapon, active_intents, active_intents_wielded, safe_damage, safe_damage_wielded)
	enchant(/datum/enchantment/silver)

/obj/item/weapon/greataxe/steel/grandmaster
	name = "gran hacha divina"
	desc = "El Hacha de San Altierre. Una gran hacha sagrada forjada en plata, que se dice que representa el brutal ataque con el que golpeo a Graggar, hiriendolo mortalmente y casi matandolo."
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	icon_state = "martyraxe"
	item_weight = 4.5 KILOGRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

/datum/intent/axe/cut/battle/greataxe/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_CUT

/datum/intent/axe/cut/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_CUT

/datum/intent/axe/chop/battle/greataxe/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_CHOP
	swingdelay = 5

/datum/intent/axe/chop/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_CHOP
	swingdelay = 5

/datum/intent/axe/bash/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_SMASH

/obj/item/weapon/greataxe/steel/grandmaster/Initialize()
	. = ..()
	var/list/active_intents = list(/datum/intent/axe/cut/martyr, /datum/intent/axe/chop/martyr, /datum/intent/axe/bash/martyr)
	var/list/active_intents_wielded = list(/datum/intent/axe/cut/battle/greataxe/martyr, /datum/intent/axe/chop/battle/greataxe/martyr, /datum/intent/axe/bash/martyr)
	var/safe_damage = 15
	var/safe_damage_wielded = 35
	AddComponent(/datum/component/martyr_weapon, active_intents, active_intents_wielded, safe_damage, safe_damage_wielded)
	enchant(/datum/enchantment/silver)

/datum/intent/polearm/cut/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_CUT

/datum/intent/polearm/thrust/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_PICK

/datum/intent/polearm/bash/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_SMASH

/obj/item/weapon/polearm/spear/grandmaster
	name = "tridente divino"
	desc = "El Tridente de San Altierre. Una lanza sagrada forjada en plata en forma de arma sagrada de Abyssor, que se dice que representa su insondable ira contra los dioses inhumen."
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	icon_state = "martyrtrident"
	item_weight = 2.5 KILOGRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

/obj/item/weapon/polearm/spear/grandmaster/Initialize()
	. = ..()
	var/list/active_intents = list(/datum/intent/polearm/cut/martyr, /datum/intent/polearm/bash/martyr)
	var/list/active_intents_wielded = list(/datum/intent/polearm/cut/martyr, /datum/intent/polearm/thrust/martyr, /datum/intent/polearm/bash/martyr)
	var/safe_damage = 15
	var/safe_damage_wielded = 35
	AddComponent(/datum/component/martyr_weapon, active_intents, active_intents_wielded, safe_damage, safe_damage_wielded)
	enchant(/datum/enchantment/silver)

/datum/intent/mace/strike/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_BLUNT

/datum/intent/mace/smash/martyr
	item_damage_type = "fire"
	blade_class = BCLASS_SMASH

/obj/item/weapon/mace/goden/steel/grandmaster
	name = "gran maza divina"
	desc = "La Maza de Saint Altierre. Una maza sagrada forjada en plata, que se dice representa su poder inquebrantable que se volvio contra Graggar antes de su ascension."
	icon = 'icons/roguetown/weapons/64/godweapons.dmi'
	icon_state = "martyrmace"
	item_weight = 3.5 KILOGRAMS
	smeltresult = null
	melting_material = null
	melt_amount = 0

/obj/item/weapon/mace/goden/steel/grandmaster/Initialize()
	. = ..()
	var/list/active_intents = list(/datum/intent/mace/strike/martyr)
	var/list/active_intents_wielded = list(/datum/intent/mace/strike/martyr, /datum/intent/mace/smash/martyr)
	var/safe_damage = 15
	var/safe_damage_wielded = 35
	AddComponent(/datum/component/martyr_weapon, active_intents, active_intents_wielded, safe_damage, safe_damage_wielded)
	enchant(/datum/enchantment/silver)
