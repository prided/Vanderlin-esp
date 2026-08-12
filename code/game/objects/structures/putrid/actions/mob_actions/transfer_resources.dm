/datum/action/cooldown/meatvine/personal/transfer_resources
	name = "Transferir recursos"
	desc = "Transfiere 20 recursos personales a otra Meatvine. Debe estar adyacente. Costo: 20 recursos."
	button_icon_state = "transfer"
	cooldown_time = 15 SECONDS
	personal_resource_cost = 20
	var/transfer_amount = 20

/datum/action/cooldown/meatvine/personal/transfer_resources/Activate(atom/target)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/giver = owner
	if(!istype(giver))
		return FALSE

	// Check if target is another meatvine
	if(!istype(target, /mob/living/simple_animal/hostile/retaliate/meatvine))
		to_chat(giver, span_warning("¡Solo puedes transferir recursos a otras matas de carne!"))
		return FALSE

	var/mob/living/simple_animal/hostile/retaliate/meatvine/receiver = target

	// Check if same master
	if(giver.master != receiver.master)
		to_chat(giver, span_warning("¡Solo puedes transferir recursos a las matas de carne desde tu colmena!"))
		return FALSE

	// Check if adjacent
	if(!giver.Adjacent(receiver))
		to_chat(giver, span_warning("¡Debes estar al lado para transferir recursos!"))
		return FALSE

	// Check if receiver can accept resources
	var/can_receive = receiver.personal_resource_max - receiver.personal_resource_pool
	if(can_receive < transfer_amount)
		to_chat(giver, span_warning("¡[receiver] no puede aceptar la transferencia completa! Solo pueden aceptar [can_receive] mas recursos."))
		// Still allow partial transfer
		transfer_amount = can_receive
		if(transfer_amount <= 0)
			return FALSE

	// Perform the transfer
	giver.visible_message(
		span_notice("[giver] transfiere recursos a [receiver]."),
		span_boldnotice("Transferiras [transfer_amount] recursos a [receiver].")
	)

	to_chat(receiver, span_nicegreen("¡Recibes [transfer_amount] recursos de [giver]!"))

	receiver.adjust_personal_resources(transfer_amount)

	// Deduct resources and start cooldown
	. = ..()
	return TRUE

/datum/action/cooldown/meatvine/personal/transfer_resources/evaluate_ai_score(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(!istype(user))
		return 0

	// Don't transfer if we're low on resources ourselves
	if(user.personal_resource_pool < user.personal_resource_max * 0.6)
		return 0

	// Look for nearby allies who need resources
	for(var/mob/living/simple_animal/hostile/retaliate/meatvine/ally in range(1, user))
		if(ally == user || ally.master != user.master)
			continue

		var/ally_resource_percent = (ally.personal_resource_pool / ally.personal_resource_max) * 100
		if(ally_resource_percent < 30)
			return 70 // High priority for low-resource allies
		else if(ally_resource_percent < 60)
			return 40 // Medium priority

	return 0

/datum/action/cooldown/meatvine/personal/transfer_resources/ai_use_ability(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner

	// Find the ally with lowest resources nearby
	var/mob/living/simple_animal/hostile/retaliate/meatvine/best_target
	var/lowest_percent = 100

	for(var/mob/living/simple_animal/hostile/retaliate/meatvine/ally in range(1, user))
		if(ally == user || ally.master != user.master)
			continue

		var/ally_percent = (ally.personal_resource_pool / ally.personal_resource_max) * 100
		if(ally_percent < lowest_percent)
			lowest_percent = ally_percent
			best_target = ally

	if(!best_target)
		return FALSE

	return Activate(best_target)

/datum/action/cooldown/meatvine/personal/transfer_resources/get_movement_target(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner

	for(var/mob/living/simple_animal/hostile/retaliate/meatvine/ally in user.master?.mobs)
		if(ally == user || get_dist(user, ally) > 7)
			continue

		var/ally_percent = (ally.personal_resource_pool / ally.personal_resource_max) * 100
		if(ally_percent < 40)
			return ally

	return null

/datum/action/cooldown/meatvine/personal/transfer_resources/improved
	name = "Recursos de transferencia mejorados"
	desc = "Transfiere 40 recursos personales a otra Meatvine. Debe estar adyacente. Costo: 20 recursos."
	transfer_amount = 40
