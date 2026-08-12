////// Roguetown version of the kitchen spike
/obj/structure/meathook
	name = "gancho para carne"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "meathook"
	desc = "Un gancho utilizado para asegurar el ganado para su matanza."
	density = TRUE
	anchored = TRUE
	max_integrity = 250
	buckle_lying = TRUE
	can_buckle = TRUE
	buckle_prevents_pull = TRUE

	var/draining_blood = FALSE

/obj/structure/meathook/attackby(obj/item/I, mob/user, list/modifiers)
	if(istype(I, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/container = I
		if(!container.is_open_container())
			return
		container.forceMove(get_turf(src))
		to_chat(user, span_notice("Debes colocar [I] debajo de [src]"))
		return TRUE
	. = ..()

/obj/structure/meathook/examine(mob/user)
	. = ..()
	if(has_buckled_mobs())
		var/mob/living/L = buckled_mobs[1]
		if(L.stat == DEAD)
			if(L.blood_drained >= 60)
				if(L.skinned)
					. += span_warning("[L] ha sido completamente desangrado y desollado. Puedo descuartizarlo con un cuchillo.")
				else
					. += span_warning("[L] ha sido completamente desangrado. Puedo despellejarlo con un cuchillo.")
			else
				if(draining_blood && L.blood_drained > 0)
					. += span_warning("[L] esta perdiendo sangre. Si intento curtir o desollarlo ahora, podria perder algunas partes.")
				else
					. += span_warning("Hay un cadaver listo para ser intervenido. Podria necesitar un cuchillo para esto.")

/obj/structure/meathook/get_mechanics_examine(mob/user)
	. = ..()
	. += span_notice("Para ver el siguiente paso del despiece, examine el gancho para carne.")
	. += span_notice("Para colgar a un mob de un gancho de carne, agarralo con fuerza y luego haz clic y arrastralo sobre el gancho de carne.")
	. += span_notice("Si la multitud esta muerta, al hacer clic en el medio se comenzara a drenar la sangre, al usar un balde en el gancho para carne podras recoger la sangre.")
	. += span_notice("Esperar a que la sangre se escurra por completo permitira obtener mayores cantidades de recursos, pero no es necesario.")
	. += span_notice("Haz clic en el medio con un objeto corto y afilado en el enemigo para despielarlo.")
	. += span_notice("Haz clic en el medio con un objeto corto y afilado en el monstruo despues de despielarlo para desmembrarlo.")

/obj/structure/meathook/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/meathook/user_buckle_mob(mob/living/M, mob/user, check_loc)
	if(!isliving(user.pulling))
		return FALSE
	if(has_buckled_mobs())
		return FALSE

	var/mob/living/L = user.pulling
	playsound(src, 'sound/foley/butcher.ogg', 25, TRUE)
	L.visible_message(span_danger("¡[user] comienza a colgar [L] en [src]!"), span_danger("[user] comienza a colgarte en [src]"), span_hear("Escucho el sonido de las cadenas tintineantes..."))
	if(!do_after(user, 12 SECONDS, src))
		return FALSE

	if(has_buckled_mobs())
		return FALSE
	if(L.buckled)
		return FALSE
	if(user.pulling != L)
		return FALSE

	L.visible_message(span_danger("¡[user] cuelga [L] en [src]!"), span_danger("[user] te cuelga en [src] ¡!"))
	L.forceMove(drop_location())
	L.emote("scream")
	L.add_splatter_floor()
	L.adjustBruteLoss(30, damage_type = BCLASS_PIERCE)
	L.setDir(SOUTH)
	ADD_TRAIT(L, TRAIT_EASYDISMEMBER, "[type]")
	buckle_mob(L, force=1)
	L.set_lying_angle(180)
	playsound(src, 'sound/combat/newstuck.ogg', 80, vary = TRUE)
	draining_blood = FALSE
	return TRUE

/obj/structure/meathook/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(buckled_mob)
		var/mob/living/M = buckled_mob
		if (M != user)
			M.visible_message(span_notice("¡[user] esta intentando liberar a [M] de [src]!"),\
				span_notice("¡[user] esta intentando despegarme de [src]! ¡Duele!"),\
				span_hear("Escucho el sonido de carne desgarrada y lamentos..."))
			if(!do_after(user, 12 SECONDS, src))
				if(M && M.buckled)
					M.visible_message(span_notice("¡[user] no logra liberar a [M]!"),\
					span_notice("¡[user] no logra sacarme de [src]!"))
				return
		else
			M.visible_message(span_warning("¡[M] lucha por liberarse de [src]!"),\
				span_notice("¡Lucho por liberarme de [src], desgarrando mis piernas! (Quedate quieto por dos minutos.)"),\
				span_hear("Escucho el sonido de carne desgarrada y lamentos..."))
			M.adjustBruteLoss(30, damage_type = BCLASS_PIERCE)
			if(!do_after(M, 30 SECONDS, src))
				if(M && M.buckled)
					to_chat(M, span_warning("¡No logro liberarme!"))
				return
			if(!M.buckled)
				return
		release_mob(M)

/obj/structure/meathook/process()
	if(!length(buckled_mobs) || !draining_blood)
		draining_blood = FALSE
		STOP_PROCESSING(SSmachines, src)
		return
	var/mob/living/L = buckled_mobs[1]
	if(L.blood_drained >= 60)
		L.blood_drained = 60
		draining_blood = FALSE
		STOP_PROCESSING(SSmachines, src)
		return
	L.blood_drained++
	var/datum/blood_type/bloodtype = L.get_blood_type()

	var/obj/item/reagent_containers/container = locate(/obj/item/reagent_containers) in get_turf(src)
	playsound(src, 'sound/misc/bleed (3).ogg', 100, FALSE)
	if(container && container.is_open_container() && container.reagents.total_volume < container.reagents.maximum_volume)
		container.reagents.add_reagent(initial(bloodtype.reagent_type), 5, data = bloodtype.get_blood_data(L))
	else
		var/obj/effect/decal/cleanable/blood/puddle/P = locate() in get_turf(src)
		if(P)
			P.blood_vol += 5
			P.update_appearance(UPDATE_ICON_STATE)
		else
			var/obj/effect/decal/cleanable/blood/drip/D = locate() in get_turf(src)
			if(D)
				D.blood_vol += 5
				D.drips++
				D.update_appearance(UPDATE_ICON_STATE)
			else
				new /obj/effect/decal/cleanable/blood/drip(get_turf(src), bloodtype.color)

/obj/structure/meathook/proc/release_mob(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_EASYDISMEMBER, "[type]")
	M.adjustBruteLoss(30, damage_type = BCLASS_PIERCE)
	src.visible_message(span_danger("¡[M] cae libremente de [src]!"))
	unbuckle_mob(M,force=1)
	M.set_lying_angle(pick(90,270))
	M.emote("painscream", forced = TRUE)
	M.AdjustParalyzed(20)
	draining_blood = FALSE

/obj/structure/meathook/Destroy()
	if(has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			release_mob(L)
	return ..()

/obj/structure/meathook/atom_deconstruct(disassembled)
	new /obj/item/grown/log/tree/small(loc, 1)
	new /obj/item/rope(loc, 1)

/obj/structure/meathook/proc/butchery(mob/living/user, mob/living/simple_animal/butchery_target)
	var/list/butcher = list()
	if(butchery_target.butcher_results)
		if(prob(50 + (GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering) * 25))) // need level 2 to get consistent result
			if(prob((GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering) * 25) - 50)) // level 3 to 6 get better result
				butcher = butchery_target.perfect_butcher_results
			else
				butcher = butchery_target.butcher_results
		else
			butcher = butchery_target.botched_butcher_results

	// Get happiness bonus for yield calculations
	var/happiness_bonus = butchery_target.get_happiness_yield_bonus(1)

	if(!draining_blood && butchery_target.blood_drained < 60)
		if(!(user.used_intent.type == /datum/intent/dagger/cut || user.used_intent.type == /datum/intent/dagger/chop/cleaver || user.used_intent.type == /datum/intent/sword/cut || user.used_intent.type == /datum/intent/axe/cut))
			return
		var/cut_time = 4 SECONDS - (0.5 SECONDS * GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering))
		to_chat(user, span_notice("Me preparo para drenar la sangre de [butchery_target] cortando la piel..."))
		if(do_after(user, cut_time, src, (IGNORE_HELD_ITEM)))
			butchery_target.blood_drained++
			draining_blood = TRUE
			START_PROCESSING(SSmachines, src)
		return

	if(!butchery_target.skinned && (user.used_intent.type == /datum/intent/dagger/cut || user.used_intent.type == /datum/intent/dagger/chop/cleaver || user.used_intent.type == /datum/intent/sword/cut || user.used_intent.type == /datum/intent/axe/cut))
		var/cut_time = 6 SECONDS - (0.5 SECONDS * GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering))
		to_chat(user, span_notice("Empiezo a despellejar [butchery_target]."))
		if(do_after(user, cut_time, src, (IGNORE_HELD_ITEM)))
			var/first_fail = TRUE
			var/total_bonus_items = 0
			for(var/listed_item in butcher)
				if(ispath(listed_item, /obj/item/natural/hide) || ispath(listed_item, /obj/item/natural/fur))
					var/base_amount = butcher[listed_item]
					var/final_amount = base_amount

					// Apply skill-based bonuses
					if(prob(40 + (GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering) * 10) - (60 - butchery_target.blood_drained)))
						final_amount += round(base_amount * 0.5)
					if(prob(10 + (GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering) * 5)) - (60 - butchery_target.blood_drained))
						final_amount += round(base_amount * 0.5)
					if(prob((60 - butchery_target.blood_drained)))
						if(first_fail)
							to_chat(user, span_notice("La sangre fluida se interpuso en el camino y ensucio algo de la piel."))
							first_fail = FALSE
						final_amount -= round(base_amount * 0.5)

					// Apply happiness bonus (only if we have items to bonus)
					var/bonus_amount = 0
					if(final_amount > 0 && happiness_bonus > 0)
						var/total_bonus = final_amount * happiness_bonus
						bonus_amount = round(total_bonus)
						// Handle fractional bonuses with probability
						var/fractional_part = total_bonus - bonus_amount
						if(fractional_part > 0 && prob(fractional_part * 100))
							bonus_amount++
						total_bonus_items += bonus_amount

					final_amount += bonus_amount

					var/current_happiness = SEND_SIGNAL(butchery_target, COMSIG_HAPPINESS_RETURN_VALUE)
					var/recipe_quality = clamp(FLOOR(current_happiness / 30, 1) + 1, 1, 4)
					for(var/i in 1 to final_amount)
						var/obj/item/I = new listed_item(get_turf(user))
						I.add_mob_blood(butchery_target)
						if(istype(I, /obj/item/reagent_containers/food))
							var/obj/item/reagent_containers/food/F = I
							F.set_quality(recipe_quality)
					butcher -= listed_item

			// Show happiness message for skinning if we got bonus items
			if(total_bonus_items > 0)
				var/happiness_message = butchery_target.get_happiness_butcher_message(happiness_bonus)
				if(happiness_message)
					to_chat(user, span_notice("[happiness_message] (+[total_bonus_items] piel/lana extra)"))

			var/boon = user.get_learning_boon(/datum/attribute/skill/labor/butchering)
			var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE)
			user.mind.add_sleep_experience(/datum/attribute/skill/labor/butchering, amt2raise * boon, FALSE)
			butchery_target.skinned = TRUE
		return

	if(!butchery_target.skinned)
		return

	if(user.used_intent.type == /datum/intent/dagger/cut || user.used_intent.type == /datum/intent/dagger/chop/cleaver || user.used_intent.type == /datum/intent/sword/cut || user.used_intent.type == /datum/intent/axe/cut)
		var/cut_time = 6 SECONDS - (0.5 SECONDS * GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering))
		to_chat(user, span_notice("Empiezo a desollar [butchery_target]."))
		if(do_after(user, cut_time, src, (IGNORE_HELD_ITEM)))
			var/first_fail = TRUE
			var/total_bonus_items = 0

			// Handle meat and fat with skill bonuses and happiness
			for(var/listed_item in butcher)
				if(ispath(listed_item, /obj/item/reagent_containers/food/snacks/meat) || ispath(listed_item, /obj/item/reagent_containers/food/snacks/fat))
					var/base_amount = butcher[listed_item]
					var/final_amount = base_amount

					// Apply skill-based bonuses
					if(prob(40 + (GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering) * 10) - (60 - butchery_target.blood_drained)))
						final_amount += round(base_amount * 0.5)
					if(prob(10 + (GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/labor/butchering) * 5)) - (60 - butchery_target.blood_drained))
						final_amount += round(base_amount * 0.5)
					if(prob((60 - butchery_target.blood_drained)))
						if(first_fail)
							to_chat(user, span_notice("La sangre que fluia se interpuso en el camino y ensucio un poco la carne."))
							first_fail = FALSE
						final_amount -= round(base_amount * 0.5)

					// Apply happiness bonus (only if we have items to bonus)
					var/bonus_amount = 0
					if(final_amount > 0 && happiness_bonus > 0)
						var/total_bonus = final_amount * happiness_bonus
						bonus_amount = round(total_bonus)
						// Handle fractional bonuses with probability
						var/fractional_part = total_bonus - bonus_amount
						if(fractional_part > 0 && prob(fractional_part * 100))
							bonus_amount++
						total_bonus_items += bonus_amount

					final_amount += bonus_amount

					var/current_happiness = SEND_SIGNAL(butchery_target, COMSIG_HAPPINESS_RETURN_VALUE)
					var/recipe_quality = clamp(FLOOR(current_happiness / 30, 1) + 1, 1, 4)
					for(var/i in 1 to final_amount)
						var/obj/item/I = new listed_item(get_turf(user))
						I.add_mob_blood(butchery_target)
						var/rotstuff = FALSE
						var/datum/component/rot/simple/CR = butchery_target.GetComponent(/datum/component/rot/simple)
						if(CR)
							if(CR.amount >= 10 MINUTES)
								rotstuff = TRUE
						if(istype(I, /obj/item/reagent_containers/food/snacks))
							var/obj/item/reagent_containers/food/snacks/F = I
							F.set_quality(recipe_quality)
							if(rotstuff)
								F.become_rotten()
						else if(rotstuff && istype(I,/obj/item/reagent_containers/food/snacks))
							var/obj/item/reagent_containers/food/snacks/F = I
							F.become_rotten()
					butcher -= listed_item

			// Handle remaining items (bones, organs, etc.) with happiness bonus
			for(var/listed_item in butcher)
				var/base_amount = butcher[listed_item]
				var/bonus_amount = 0

				// Apply happiness bonus to remaining items too
				if(base_amount > 0 && happiness_bonus > 0)
					var/total_bonus = base_amount * happiness_bonus
					bonus_amount = round(total_bonus)
					// Handle fractional bonuses with probability
					var/fractional_part = total_bonus - bonus_amount
					if(fractional_part > 0 && prob(fractional_part * 100))
						bonus_amount++
					total_bonus_items += bonus_amount

				var/final_amount = base_amount + bonus_amount

				var/current_happiness = SEND_SIGNAL(butchery_target, COMSIG_HAPPINESS_RETURN_VALUE)
				var/recipe_quality = clamp(FLOOR(current_happiness / 30, 1) + 1, 1, 4)
				for(var/i in 1 to final_amount)
					var/obj/item/I = new listed_item(get_turf(user))
					I.add_mob_blood(butchery_target)
					if(istype(I, /obj/item/reagent_containers/food))
						var/obj/item/reagent_containers/food/F = I
						F.set_quality(recipe_quality)

			// Show happiness message for butchering if we got bonus items
			if(total_bonus_items > 0)
				var/happiness_message = butchery_target.get_happiness_butcher_message(happiness_bonus)
				if(happiness_message)
					to_chat(user, span_notice("[happiness_message] (+[total_bonus_items] articulos de bonificacion)"))

			butchery_target.gib()
			var/boon = user.get_learning_boon(/datum/attribute/skill/labor/butchering)
			var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(user, STAT_INTELLIGENCE)
			user.mind.add_sleep_experience(/datum/attribute/skill/labor/butchering, amt2raise * boon, FALSE)
