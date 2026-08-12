//cleansed 9/15/2012 17:48

/*
CONTAINS:
MATCHEStype_butt
CIGARETTES
CIGARS
SMOKING PIPES
CHEAP LIGHTERS
ZIPPO

CIGARETTE PACKETS ARE IN FANCY.DM
*/

///////////
//MATCHES//
///////////
/obj/item/match
	name = "fosforo"
	desc = ""
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "match_unlit"
	var/lit = FALSE
	var/burnt = FALSE
	var/smoketime = 15 // 10 seconds
	w_class = WEIGHT_CLASS_TINY
	heat = 1000
	item_weight = 2 GRAMS

/obj/item/match/process()
	smoketime--
	if(smoketime < 1)
		matchburnout()
	else
		open_flame(heat)

/obj/item/match/fire_act(added, maxstacks)
	matchignite()

/obj/item/match/spark_act()
	fire_act()

/obj/item/match/proc/matchignite()
	if(!lit && !burnt)
		playsound(src, "sound/items/match.ogg", 100, FALSE)
		lit = TRUE
		icon_state = "match_lit"
		damtype = "fire"
		force = 3
		set_light(3)
		hitsound = list('sound/blank.ogg')
		name = "encendido [initial(name)]"
		desc = ""
		attack_verb = list("quemado","chamuscado")
		START_PROCESSING(SSobj, src)

/obj/item/match/proc/matchburnout()
	if(lit)
		lit = FALSE
		burnt = TRUE
		set_light(0)
		damtype = "brute"
		force = initial(force)
		icon_state = "match_burnt"
		item_state = "cigoff"
		name = "quemado [initial(name)]"
		desc = ""
		attack_verb = list("golpeado")
		STOP_PROCESSING(SSobj, src)

/obj/item/match/extinguish()
	. = ..()
	matchburnout()

/obj/item/match/dropped(mob/user)
	matchburnout()
	. = ..()

/obj/item/match/afterattack(atom/movable/A, mob/user, proximity, list/modifiers)
	. = ..()
	if(!proximity)
		return
	if(lit && !burnt)
		A.spark_act()

/obj/item/match/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()

	if(lit && M.IgniteMob())
		message_admins("[ADMIN_LOOKUPFLW(user)] set [key_name_admin(M)] on fire with [src] at [AREACOORD(user)]")
		user.log_message("set [key_name(M)] on fire with [src]", LOG_ATTACK)

	var/obj/item/clothing/face/cigarette/cig = help_light_cig(M)
	if(!lit || !cig || user.cmode)
		return ..()

	if(cig.lit)
		to_chat(user, span_warning("¡[cig] ya esta encendido!"))
	if(M == user)
		cig.attackby(src, user)
	else
		cig.light(span_notice("[user] sostiene [src] para [M] y enciende [cig]."))

/obj/item/proc/help_light_cig(mob/living/M)
	var/mask_item = M.get_item_by_slot(ITEM_SLOT_MOUTH)
	if(istype(mask_item, /obj/item/clothing/face/cigarette))
		return mask_item

/obj/item/match/get_temperature()
	return lit * heat

/obj/item/match/firebrand
	name = "tizon"
	desc = ""
	smoketime = 20 //40 seconds

/obj/item/match/firebrand/Initialize()
	. = ..()
	matchignite()

//////////////////
//FINE SMOKABLES//
//////////////////
/obj/item/clothing/face/cigarette
	name = "cigarrillo"
	desc = ""
	icon_state = "spliffoff"
	throw_speed = 0.5
	item_state = "spliffoff"
	w_class = WEIGHT_CLASS_TINY
	body_parts_covered = null
	grind_results = list()
	slot_flags = ITEM_SLOT_MOUTH
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/mouth_items.dmi'
	icon = 'icons/roguetown/items/lighting.dmi'
	heat = 570
	spitoutmouth = FALSE

	grid_width = 32
	grid_height = 32
	item_weight = 3 GRAMS

	var/dragtime = 100
	var/nextdragtime = 0
	var/lit = FALSE
	var/starts_lit = FALSE
	var/icon_on = "cigon"  //Note - these are in masks.dmi not in cigarette.dmi
	var/icon_off = "cigoff"
	var/type_butt = /obj/item/cigbutt
	var/lastHolder = null
	var/smoketime = 180 // 1 is 2 seconds, so a single cigarette will last 6 minutes.
	var/highest_metab_time = 0
	var/total_transferred = 0
	var/chem_volume = 30
	var/list/list_reagents = list(/datum/reagent/drug/nicotine = 15)
	abstract_type = /obj/item/clothing/face/cigarette

/obj/item/clothing/face/cigarette/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] esta inhalando [src] tan rapido como [user.p_they()] puede. Parece que [user.p_theyre()] esta intentando darle cancer a [user.p_them()] mismo."))
	return (TOXLOSS|OXYLOSS)

/obj/item/clothing/face/cigarette/Initialize()
	. = ..()
	create_reagents(chem_volume, INJECTABLE | NO_REACT)
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)
		for(var/datum/reagent/reagent_type as anything in list_reagents)
			if(ispath(reagent_type, /datum/reagent/medicine))
				flags_ai_inventory |= AI_ITEM_HEALING_DRINK

	if(starts_lit)
		light()
	AddComponent(/datum/component/knockoff, 90, list(BODY_ZONE_PRECISE_MOUTH) ,list(ITEM_SLOT_MOUTH))//90% to knock off when wearing a mask

/obj/item/clothing/face/cigarette/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/face/cigarette/attackby(obj/item/W, mob/user, list/modifiers)
	if(!lit && smoketime > 0)
		var/lighting_text = W.ignition_effect(src, user)
		if(lighting_text)
			light(lighting_text)
	else
		return ..()

/obj/item/clothing/face/cigarette/proc/light(flavor_text = null)
	if(lit)
		return
	if(smoketime <= 0)
		return
	if(!(flags_1 & INITIALIZED_1))
		icon_state = icon_on
		item_state = icon_on
		return

	lit = TRUE
	attack_verb = list("quemado", "chamuscado")
	hitsound = list('sound/blank.ogg')
	damtype = "fire"
	force = 4
	if(reagents.get_reagent_amount(/datum/reagent/toxin/plasma)) // the plasma explodes when exposed to fire
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/plasma) / 2.5, 1), get_turf(src), 0, 0)
		e.start()
		qdel(src)
		return
	if(reagents.get_reagent_amount(/datum/reagent/blood/fuel)) // the fuel explodes, too, but much less violently
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/blood/fuel) / 5, 1), get_turf(src), 0, 0)
		e.start()
		qdel(src)
		return
	// allowing reagents to react after being lit
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	icon_state = icon_on
	item_state = icon_on
	if(flavor_text)
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
	START_PROCESSING(SSobj, src)

	//can't think of any other way to update the overlays :<
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_mouth()
		M.update_inv_hands()
		playsound(src, 'sound/items/light_cig.ogg', 100, TRUE)

/obj/item/clothing/face/cigarette/extinguish()
	. = ..()
	if(!lit)
		return
	attack_verb = null
	hitsound = null
	damtype = BRUTE
	force = 0
	icon_state = icon_off
	item_state = icon_off
	STOP_PROCESSING(SSobj, src)
	ENABLE_BITFIELD(reagents.flags, NO_REACT)
	lit = FALSE
	if(ismob(loc))
		var/mob/living/M = loc
		to_chat(M, span_notice("Mi [name] se apaga."))
		M.update_inv_mouth()
		M.update_inv_hands()

/obj/item/clothing/face/cigarette/proc/handle_reagents()
	if(!reagents.total_volume)
		return
	reagents.expose_temperature(heat, 0.05)
	if(!reagents.total_volume) //may have reacted and gone to 0 after expose_temperature
		return
	var/transfer_rate = REAGENTS_METABOLISM * 0.4
	var/mob/living/carbon/smoker = loc
	// These checks are a bit messy but at least they're fairly readable
	// Check if the smoker is a carbon mob, since it needs to have wear_mask
	if(!istype(smoker))
		smoker = smoker.loc
		// If it is, check if that mask is on a carbon mob
		if(!istype(smoker) || smoker.get_item_by_slot(ITEM_SLOT_MOUTH) != loc)
			reagents.remove_all(transfer_rate)
			return
	else
		if(src != smoker.mouth)
			reagents.remove_all(transfer_rate)
			return

	reagents.reaction(smoker, INGEST, min(transfer_rate / reagents.total_volume, 1))
	if(!reagents.trans_to(smoker, transfer_rate, method = INGEST))
		reagents.remove_all(transfer_rate)

/obj/item/clothing/face/cigarette/process()
	smoketime--
	if(smoketime >= 1)
		if(reagents?.total_volume)
			handle_reagents()
		open_flame()
		return
	reagents.remove_any(reagents.total_volume)
	if(type_butt)
		var/obj/item/butt = new type_butt(get_turf(src))
		if(iscarbon(loc))
			var/mob/living/carbon/M = loc
			M.dropItemToGround(src, silent = TRUE)
			M.equip_to_slot_if_possible(butt, qdel_on_fail = FALSE, disable_warning = TRUE)
	qdel(src)

/obj/item/clothing/face/cigarette/attack_self(mob/user, list/modifiers)
	if(lit)
		user.visible_message(span_notice("[user] calmamente se cae y pisa \the [src], apagandolo de inmediato."))
		new type_butt(user.loc)
		new /obj/item/fertilizer/ash(user.loc)
		qdel(src)
	. = ..()

/obj/item/clothing/face/cigarette/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()

	if(M.on_fire && !lit)
		light(span_notice("[user] ilumina [src] con el cuerpo ardiente de [M]. ¡Que asesino frio!"))
		return

	var/obj/item/clothing/face/cigarette/cig = help_light_cig(M)
	if(!lit || !cig || user.cmode)
		..()
		return

	if(cig.lit)
		to_chat(user, span_warning("¡[cig] ya esta encendido!"))
	if(M == user)
		cig.attackby(src, user)
	else
		cig.light(span_notice("[user] sostiene [src] para [M] y enciende [cig]."))

/obj/item/clothing/face/cigarette/fire_act(added, maxstacks)
	light()

/obj/item/clothing/face/cigarette/spark_act()
	fire_act()

/obj/item/clothing/face/cigarette/get_temperature()
	return lit * heat

// Cigarette brands.

/obj/item/clothing/face/cigarette/rollie
	abstract_type = /obj/item/clothing/face/cigarette/rollie
	name = "cigarrillo enrollado"
	desc = ""
	icon_state = "spliffoff"
	icon_on = "spliffon"
	icon_off = "spliffoff"
	type_butt = /obj/item/cigbutt
	throw_speed = 0.5
	item_state = "spliffoff"
	smoketime = 120 // four minutes
	chem_volume = 60
	list_reagents = null
	muteinmouth = FALSE

/obj/item/clothing/face/cigarette/rollie/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

/obj/item/clothing/face/cigarette/rollie/nicotine
	list_reagents = list(/datum/reagent/drug/nicotine = 60)

/obj/item/clothing/face/cigarette/rollie/trippy
	list_reagents = list(/datum/reagent/drug/nicotine = 15, /datum/reagent/drug/mushroomhallucinogen = 35)
	starts_lit = TRUE

/obj/item/clothing/face/cigarette/rollie/cannabis
	list_reagents = list(/datum/reagent/drug/space_drugs = 30)

/obj/item/cigbutt
	name = "colilla de zig"
	desc = ""
	icon = 'icons/roguetown/items/lighting.dmi'
	icon_state = "roach"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	slot_flags = ITEM_SLOT_MOUTH
	spitoutmouth = TRUE
	resistance_flags = FLAMMABLE

/obj/item/cigbutt/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

//Cigars

/obj/item/clothing/face/cigarette/rollie/nicotine/zigar
	name = "zigar"
	desc = "Una version fuerte y varonil del zig comun, este no es el tratamiento tipico para los fumadores. No, esto es para los humildes, los sabios, los que estan interesados ​​en esto. Sabes quien eres."
	icon_state = "zigaroff"
	icon_on = "zigaron"
	type_butt = /obj/item/cigbutt/zigar
	chem_volume = 120
	list_reagents = list(/datum/reagent/drug/nicotine = 120)

/obj/item/cigbutt/zigar
	name = "colilla de zigar"

/////////////////
//SMOKING PIPES//
/////////////////
/obj/item/clothing/face/cigarette/pipe
	name = "pipa"
	desc = ""
	icon_state = "pipeoff"
	item_state = "pipeoff"
	icon_on = "pipeon"  //Note - these are in masks.dmi
	icon_off = "pipeoff"
	smoketime = 120
	chem_volume = 100
	list_reagents = null
	var/packeditem = 0
	slot_flags = ITEM_SLOT_MOUTH
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/mouth_items.dmi'
	icon = 'icons/roguetown/items/lighting.dmi'
	muteinmouth = FALSE

/obj/item/clothing/face/cigarette/pipe/westman
	name = "pipa westman"
	desc = ""
	icon_state = "longpipeoff"
	item_state = "longpipeoff"
	icon_on = "longpipeon"  //Note - these are in masks.dmi
	icon_off = "longpipeoff"

/obj/item/clothing/face/cigarette/pipe/crafted/Initialize()
	. = ..()
	if(prob(50))
		name = "pipa westman"
		icon_state = "longpipeoff"
		item_state = "longpipeoff"
		icon_on = "longpipeon"
		icon_off = "longpipeoff"

/obj/item/clothing/face/cigarette/pipe/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/face/cigarette/pipe/process()
	if(!packeditem)
		smoketime = 0
		extinguish()
		return
	if(!has_enchantment(/datum/enchantment/eternal_blunt))
		smoketime--
	if(smoketime >= 1)
		if(reagents?.total_volume)
			handle_reagents()
		open_flame()
		return
	packeditem = FALSE
	extinguish()

/obj/item/clothing/face/cigarette/pipe/attackby(obj/item/attacking_item, mob/user, list/modifiers)
	if(!istype(attacking_item, /obj/item/reagent_containers/food/snacks/produce) && !istype(attacking_item, /obj/item/reagent_containers/powder))
		var/lighting_text = attacking_item.ignition_effect(src, user)
		if(!lighting_text)
			return ..()
		if(!packeditem || smoketime < 0)
			to_chat(user, span_warning("¡No hay nada que fumar!"))
		else
			light(lighting_text)
		return

	if(packeditem)
		to_chat(user, span_warning("¡Ya esta empacado!"))
		return

	var/list/reagent_list = list()
	if(istype(attacking_item, /obj/item/reagent_containers/food/snacks/produce))
		var/obj/item/reagent_containers/food/snacks/produce/to_smoke = attacking_item
		if(!to_smoke.dry && to_smoke.should_dry)
			to_chat(user, span_warning("¡Primero tiene que secarse!"))
			return
		if(to_smoke.pipe_reagents)
			reagent_list = to_smoke.pipe_reagents
		else
			for(var/datum/reagent/reagent as anything in to_smoke.reagents?.reagent_list)
				reagent_list |= reagent.type
				reagent_list[reagent.type] = reagent.volume
	else
		var/obj/item/reagent_containers/powder/to_smoke = attacking_item
		for(var/datum/reagent/reagent as anything in to_smoke.reagents?.reagent_list)
			reagent_list |= reagent.type
			reagent_list[reagent.type] = reagent.volume
	to_chat(user, span_notice("Metemos [attacking_item] en [src]."))
	packeditem = TRUE
	if(length(reagent_list))
		reagents.add_reagent_list(reagent_list)
		for(var/datum/reagent/reagent as anything in reagents.reagent_list)
			if((reagent.volume / reagent.metabolization_rate) > highest_metab_time)
				highest_metab_time = reagent.volume / reagent.metabolization_rate
		smoketime = highest_metab_time
	else
		smoketime = 3 MINUTES

	qdel(attacking_item)

/obj/item/clothing/face/cigarette/pipe/attack_self(mob/user, list/modifiers)
	if(lit)
		user.visible_message(span_notice("[user] apaga [src]."), span_notice("Apago [src]."))
		extinguish()
	else if (packeditem)
		to_chat(user, span_notice("Vaso [src] en el suelo."))
		new /obj/item/fertilizer/ash(get_turf(user))
		packeditem = FALSE
		reagents.clear_reagents()

/obj/item/clothing/face/cigarette/pipe/light(flavor_text)
	if(!packeditem)
		return
	return ..()

/////////
//ZIPPO//
/////////
/obj/item/lighter
	name = "\improper Encendedor Zippo"
	desc = ""
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "zippo"
	item_state = "zippo"
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_HIP
	var/lit = 0
	var/fancy = TRUE
	var/overlay_state
	var/overlay_list = list(
		"plain",
		"dame",
		"thirteen",
		"snake"
		)
	heat = 1500
	resistance_flags = FIRE_PROOF
	light_color = LIGHT_COLOR_FIRE

/obj/item/lighter/Initialize()
	. = ..()
	if(!overlay_state)
		overlay_state = pick(overlay_list)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/lighter/suicide_act(mob/living/carbon/user)
	if (lit)
		user.visible_message(span_suicide("[user] comienza a sostener la llama de \the [src] frente al rostro de [user.p_their()]. ¡Parece que [user.p_theyre()] esta intentando suicidarse!"))
		playsound(src, 'sound/blank.ogg', 50, TRUE)
		return FIRELOSS
	else
		user.visible_message(span_suicide("[user] comienza a golpear a [user.p_them()] si mismo con \the [src] ¡Parece que [user.p_theyre()] esta intentando suicidarse!"))
		return BRUTELOSS

/obj/item/lighter/update_overlays()
	. = ..()
	var/mutable_appearance/lighter_overlay = mutable_appearance(icon, "lighter_overlay_[overlay_state][lit ? "-on" : ""]")
	icon_state = "[initial(icon_state)][lit ? "-on" : ""]"
	. += lighter_overlay

/obj/item/lighter/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_rose("Con un solo movimiento de [user.p_their()] muñeca, [user] enciende suavemente [A] con [src]. Maldita [user.p_theyre()] genial.")

/obj/item/lighter/proc/set_lit(new_lit)
	lit = new_lit
	if(lit)
		force = 5
		damtype = "fire"
		hitsound = list('sound/blank.ogg')
		attack_verb = list("quemado", "chamuscado")
		set_light(1)
		START_PROCESSING(SSobj, src)
	else
		hitsound = list("swing_hit")
		force = 0
		attack_verb = null //human_defense.dm takes care of it
		set_light(0)
		STOP_PROCESSING(SSobj, src)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/lighter/extinguish()
	. = ..()
	set_lit(FALSE)

/obj/item/lighter/attack_self(mob/living/user, list/modifiers)
	if(user.is_holding(src))
		if(!lit)
			set_lit(TRUE)
			if(fancy)
				user.visible_message(span_notice("Sin siquiera detenerse, [user] abre y enciende [src] en un solo movimiento fluido."), span_notice("Sin siquiera detenerse, abre y enciende [src] en un solo movimiento fluido."))
			else
				var/prot = FALSE
				var/mob/living/carbon/human/H = user

				if(istype(H) && H.gloves)
					var/obj/item/clothing/gloves/G = H.gloves
					if(G.max_heat_protection_temperature)
						prot = (G.max_heat_protection_temperature > 360)
				else
					prot = TRUE

				if(prot || prob(75))
					user.visible_message(span_notice("Despues de algunos intentos, [user] logra encender [src]."), span_notice("Despues de algunos intentos, logras encender [src]."))
				else
					var/hitzone = user.held_index_to_dir(user.active_hand_index) == "r" ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND
					user.apply_damage(5, BURN, hitzone)
					user.visible_message(span_warning("Despues de algunos intentos, [user] logra encender [src], pero [user.p_they()] se quema el dedo [user.p_their()] en el proceso."), span_warning("¡Me queme mientras encendia el encendedor!"))
					user.add_stress(/datum/stress_event/burnt_thumb)

		else
			set_lit(FALSE)
			if(fancy)
				user.visible_message(span_notice("Escucho un clic suave, mientras [user] apaga [src] sin siquiera mirar lo que [user.p_theyre()] esta haciendo. ¡Vaya!"), span_notice("Apague silenciosamente [src] sin siquiera mirar lo que estas haciendo. ¡Vaya!"))
			else
				user.visible_message(span_notice("[user] se apaga silenciosamente [src]."), span_notice("Silenciosamente apague [src]."))
	else
		. = ..()

/obj/item/lighter/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()

	if(lit && M.IgniteMob())
		message_admins("[ADMIN_LOOKUPFLW(user)] set [key_name_admin(M)] on fire with [src] at [AREACOORD(user)]")
		user.log_message("set [key_name(M)] on fire with [src]", LOG_ATTACK)

	var/obj/item/clothing/face/cigarette/cig = help_light_cig(M)
	if(!lit || !cig || user.cmode)
		return ..()

	if(cig.lit)
		to_chat(user, span_warning("¡[cig] ya esta encendido!"))
	if(M == user)
		cig.attackby(src, user)
	else if(fancy)
		cig.light(span_rose("[user] saca el [name] y se lo entrega a [M]. El brazo de [user.p_their(TRUE)] es tan firme como la llama incesante de la [user.p_they()] luz [user.p_s()] \the [cig]."))
	else
		cig.light(span_notice("[user] sostiene el [name] para [M] y enciende [M.p_their()] [cig.name]."))

/obj/item/lighter/process()
	open_flame()

/obj/item/lighter/get_temperature()
	return lit * heat


/obj/item/lighter/greyscale
	name = "encendedor barato"
	desc = ""
	icon_state = "lighter"
	fancy = FALSE
	overlay_list = list(
		"transp",
		"tall",
		"matte",
		"zoppo" //u cant stoppo th zoppo
		)
	var/lighter_color
	var/list/color_list = list( //Same 16 color selection as electronic assemblies
		COLOR_ASSEMBLY_BLACK,
		COLOR_FLOORTILE_GRAY,
		COLOR_ASSEMBLY_BGRAY,
		COLOR_ASSEMBLY_WHITE,
		COLOR_ASSEMBLY_RED,
		COLOR_ASSEMBLY_ORANGE,
		COLOR_ASSEMBLY_BEIGE,
		COLOR_ASSEMBLY_BROWN,
		COLOR_ASSEMBLY_GOLD,
		COLOR_ASSEMBLY_YELLOW,
		COLOR_ASSEMBLY_GURKHA,
		COLOR_ASSEMBLY_LGREEN,
		COLOR_ASSEMBLY_GREEN,
		COLOR_ASSEMBLY_LBLUE,
		COLOR_ASSEMBLY_BLUE,
		COLOR_ASSEMBLY_PURPLE
		)

/obj/item/lighter/greyscale/Initialize()
	. = ..()
	if(!lighter_color)
		lighter_color = pick(color_list)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/lighter/greyscale/update_overlays()
	. = ..()
	var/mutable_appearance/lighter_overlay = mutable_appearance(icon, "lighter_overlay_[overlay_state][lit ? "-on" : ""]")
	icon_state = "[initial(icon_state)][lit ? "-on" : ""]"
	lighter_overlay.color = lighter_color
	. += lighter_overlay

/obj/item/lighter/greyscale/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_notice("Despues de un poco de esfuerzo, [user] logra encender [A] con [src].")
