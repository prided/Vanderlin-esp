/obj/structure/dock_bell
	name = "campana de muelle"
	desc = "Una campana sonora que lleva su sonido a los puertos cercanos. Indica a los comerciantes que el muelle tiene productos para vender."


	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "dock_bell"
	layer = WALL_OBJ_LAYER

	COOLDOWN_DECLARE(ring_bell)
	COOLDOWN_DECLARE(outsider_ring_bell)
	var/static/approved_jobs = list(/datum/job/merchant, /datum/job/grabber, /datum/job/shophand)
	max_integrity = 999999

/obj/structure/dock_bell/examine(mob/user)
	. = ..()
	. += span_info("La campana del muelle puede ser tocada por los trabajadores autorizados despues de [COOLDOWN_TIMELEFT(src, ring_bell)/10] segundos.")
	. += span_info("La campana del muelle puede ser tocada por personas ajenas despues de [COOLDOWN_TIMELEFT(src, outsider_ring_bell)/10] segundos.")

/obj/structure/dock_bell/attack_hand(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, ring_bell))
		return

	var/datum/job/user_job = SSjob.GetJob(user.job)
	var/merchant = FALSE
	for(var/mob/living/liver in GLOB.player_list)
		var/datum/job/liver_job = SSjob.GetJob(liver.job)
		if(!liver_job || !(liver_job.type in approved_jobs))
			continue
		merchant = TRUE
		break

	if(merchant)
		if(user_job && !(initial(user_job.type) in approved_jobs) && (SSmapping.config.map_name != "Voyager"))
			if(!COOLDOWN_FINISHED(src, outsider_ring_bell))
				return

	if(!do_after(user, 5 SECONDS, src))
		return

	if(!COOLDOWN_FINISHED(src, ring_bell))
		return

	visible_message(span_notice("[user] comienza a hacer sonar la campana del muelle."))
	playsound(src, 'sound/misc/handbell.ogg', 50, 1)

	// Handle trader return
	if(!SSmerchant.cargo_docked && SSmerchant.cargo_boat.check_living())
		recall_faction_traders()
		SSmerchant.send_cargo_ship_back()
	else if(SSmerchant.cargo_docked)
		SSmerchant.prepare_cargo_shipment()

	COOLDOWN_START(src, ring_bell, 60 SECONDS)
	COOLDOWN_START(src, outsider_ring_bell, 5 MINUTES)

/obj/structure/dock_bell/proc/recall_faction_traders()
	for(var/mob/living/simple_animal/hostile/retaliate/trader/faction_trader/trader in SSmerchant.active_faction_traders)
		playsound(trader, 'sound/items/smokebomb.ogg' , 50)
		var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread
		S.set_up(3, get_turf(trader))
		S.start()
		SSmerchant.active_faction_traders -= trader
		qdel(trader)

