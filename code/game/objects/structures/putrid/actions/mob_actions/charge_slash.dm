/datum/action/cooldown/meatvine/personal/charge_slash
	name = "Tajo de carga"
	desc = "Carga a traves de enemigos hasta 4 fichas. Al detenerte, activalo nuevamente para realizar inmediatamente un corte de area de efecto de 3x3, o espera 3 segundos para que se active automaticamente. Costo: 10 recursos."
	button_icon_state = "charge_slash"
	cooldown_time = 13 SECONDS
	personal_resource_cost = 10

	/// Delay before the charge actually occurs
	var/charge_delay = 0.3 SECONDS
	/// The amount of turfs we move past the target
	var/charge_past = 0
	/// The maximum distance we can charge
	var/charge_distance = 4
	/// The sleep time before moving in deciseconds while charging
	var/charge_speed = 0.5
	/// The damage the charger does when bumping into something during charge
	var/charge_damage = 30
	/// If we destroy objects while charging
	var/destroy_objects = FALSE
	/// If the current move is being triggered by us or not
	var/actively_moving = FALSE
	/// List of charging mobs
	var/list/charging = list()

	/// If we're in the slash-ready state
	var/slash_ready = FALSE
	/// The AoE slash range (1 = 3x3)
	var/slash_range = 1
	/// Damage for the AoE slash
	var/slash_damage = 40
	/// Auto-slash timer
	var/auto_slash_delay = 3 SECONDS
	/// Reference to the auto-slash timer
	var/slash_timer_id

/datum/action/cooldown/meatvine/personal/charge_slash/Remove(mob/living/remove_from)
	cancel_slash_state()
	return ..()

/datum/action/cooldown/meatvine/personal/charge_slash/Activate(atom/target)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(!istype(user))
		return FALSE

	// If we're in slash-ready state, execute the slash immediately
	if(slash_ready)
		execute_aoe_slash()
		return TRUE

	// Otherwise, start the charge
	if(!target)
		to_chat(user, span_warning("¡Debes seleccionar un lugar al que cargar!"))
		return FALSE

	do_charge(user, target, charge_delay, charge_past)

	// Start cooldown after charge completes
	. = ..()
	return TRUE

/datum/action/cooldown/meatvine/personal/charge_slash/proc/do_charge(atom/movable/charger, atom/target_atom, delay, past)
	if(!target_atom || target_atom == charger)
		return

	var/turf/chargeturf = get_turf(target_atom)
	if(!chargeturf)
		return

	var/dir = get_dir(charger, target_atom)
	var/turf/target = get_ranged_target_turf(chargeturf, dir, past)
	if(!target)
		return

	// Check if already charging
	if(charger in charging)
		SSmove_manager.stop_looping(charger)

	charging += charger
	actively_moving = FALSE
	RegisterSignal(charger, COMSIG_MOVABLE_BUMP, PROC_REF(on_bump), TRUE)
	RegisterSignal(charger, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_move), TRUE)
	RegisterSignal(charger, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved), TRUE)
	charger.setDir(dir)

	charger.visible_message(
		span_danger("¡[charger] carga hacia adelante con una velocidad tremenda!"),
		span_boldnotice("¡Cargas hacia adelante!")
	)

	sleep(delay)

	playsound(charger, 'sound/misc/meteorimpact.ogg', 100, TRUE, 8, 0.9)
	var/time_to_hit = min(get_dist(charger, target), charge_distance) * charge_speed

	var/datum/move_loop/new_loop = SSmove_manager.home_onto(charger, target, delay = charge_speed, timeout = time_to_hit, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	if(!new_loop)
		cleanup_charge(charger)
		return

	RegisterSignal(new_loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, PROC_REF(pre_move))
	RegisterSignal(new_loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(post_move))
	RegisterSignal(new_loop, COMSIG_QDELETING, PROC_REF(charge_end))

	sleep(time_to_hit + charge_speed)
	charger.setDir(dir)

	// Charge complete, enter slash-ready state
	enter_slash_ready_state()

	return TRUE

/datum/action/cooldown/meatvine/personal/charge_slash/proc/pre_move(datum/source)
	SIGNAL_HANDLER
	actively_moving = TRUE

/datum/action/cooldown/meatvine/personal/charge_slash/proc/post_move(datum/source)
	SIGNAL_HANDLER
	actively_moving = FALSE

/datum/action/cooldown/meatvine/personal/charge_slash/proc/charge_end(datum/move_loop/source)
	SIGNAL_HANDLER
	var/atom/movable/charger = source.moving
	cleanup_charge(charger)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/cleanup_charge(atom/movable/charger)
	UnregisterSignal(charger, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOVABLE_MOVED))
	actively_moving = FALSE
	charging -= charger

/datum/action/cooldown/meatvine/personal/charge_slash/proc/on_move(atom/source, atom/new_loc)
	SIGNAL_HANDLER
	if(!actively_moving)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE
	new /obj/effect/temp_visual/decoy/fading(source.loc, source)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/on_moved(atom/source)
	SIGNAL_HANDLER
	playsound(source, 'sound/misc/meteorimpact.ogg', 200, TRUE, 2, TRUE)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/on_bump(atom/movable/source, atom/target)
	SIGNAL_HANDLER
	if(owner == target)
		return

	if(destroy_objects)
		if(isturf(target))
			target.ex_act(2)
		if(isobj(target) && target.density)
			target.ex_act(2)

	try_hit_target(source, target)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/try_hit_target(atom/movable/source, atom/target)
	if(can_hit_target(source, target))
		hit_target(source, target, charge_damage)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/can_hit_target(atom/movable/source, atom/target)
	if(!isliving(target))
		if(!target.density || target.CanPass(source, get_dir(target, source)))
			return FALSE
		return TRUE

	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(istype(target, /mob/living/simple_animal/hostile/retaliate/meatvine))
		var/mob/living/simple_animal/hostile/retaliate/meatvine/other_vine = target
		if(other_vine.master == user.master)
			return FALSE // Don't hit allies

	return TRUE

/datum/action/cooldown/meatvine/personal/charge_slash/proc/hit_target(atom/movable/source, atom/target, damage_dealt)
	if(!isliving(target))
		source.visible_message(span_danger("¡[source] se estrella contra [target]!"))
		return

	var/mob/living/living_target = target
	living_target.visible_message(
		span_danger("[source] carga contra [living_target] ¡Uf!"),
		span_userdanger("¡[source] carga contra ti!")
	)
	living_target.Knockdown(0.6 SECONDS)
	living_target.apply_damage(damage_dealt, BRUTE, damage_type = BCLASS_CUT)
	playsound(living_target,  pick('sound/combat/hits/bladed/genslash (1).ogg','sound/combat/hits/bladed/genslash (2).ogg','sound/combat/hits/bladed/genslash (3).ogg'), 75, TRUE)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/enter_slash_ready_state()
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(!istype(user))
		return

	slash_ready = TRUE

	user.visible_message(
		span_danger("[user] se detiene de golpe, listo para asestar un golpe devastador."),
		span_boldnotice("¡Estas listo para desencadenar un devastador ataque con la espada! Haz clic en la habilidad de nuevo o espera 3 segundos.")
	)

	// Update button appearance to show it's ready
	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

	// Set auto-slash timer
	slash_timer_id = addtimer(CALLBACK(src, PROC_REF(execute_aoe_slash)), auto_slash_delay, TIMER_STOPPABLE)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/cancel_slash_state()
	if(!slash_ready)
		return

	slash_ready = FALSE

	if(slash_timer_id)
		deltimer(slash_timer_id)
		slash_timer_id = null

	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

/datum/action/cooldown/meatvine/personal/charge_slash/proc/execute_aoe_slash()
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(!istype(user))
		return

	// Cancel slash state
	slash_ready = FALSE
	if(slash_timer_id)
		deltimer(slash_timer_id)
		slash_timer_id = null

	build_all_button_icons(UPDATE_BUTTON_BACKGROUND)

	// Visual and audio effects
	user.visible_message(
		span_danger("¡[user] desencadena un torbellino de ataques de sable!"),
		span_boldnotice("¡Desencadenas un ataque devastador con un corte!")
	)

	//playsound(user, 'sound/weapons/bladeslice.ogg', 100, TRUE)
	shake_camera(user, 2, 2)

	var/hit_count = 0
	for(var/turf/affected_turf in range(slash_range, get_turf(user)))
		for(var/mob/living/victim in affected_turf)
			if(victim == user)
				continue

			if(istype(victim, /mob/living/simple_animal/hostile/retaliate/meatvine))
				var/mob/living/simple_animal/hostile/retaliate/meatvine/other_vine = victim
				if(other_vine.master == user.master)
					continue

			// Apply damage
			victim.visible_message(
				span_danger("¡[victim] esta atrapado en la furia cortante de [user]!"),
				span_userdanger("¡Estas atrapado en la furia de cortes de [user]!")
			)

			victim.apply_damage(slash_damage, BRUTE, damage_type = BCLASS_CUT)
			victim.add_splatter_floor()
			playsound(victim, pick('sound/combat/hits/bladed/genslash (1).ogg','sound/combat/hits/bladed/genslash (2).ogg','sound/combat/hits/bladed/genslash (3).ogg'), 75, TRUE)

			// Small knockback effect
			var/throw_dir = get_dir(user, victim)
			victim.throw_at(get_step(victim, throw_dir), 1, 1, user, gentle = TRUE)

			hit_count++

	if(hit_count > 0)
		to_chat(user, span_boldnotice("¡Has dado en el blanco [hit_count] [hit_count > 1 ? "s" : ""]!"))
	else
		to_chat(user, span_warning("¡Tu golpe de espada no ha alcanzado nada!"))

/datum/action/cooldown/meatvine/personal/charge_slash/evaluate_ai_score(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(!istype(user))
		return 0

	// If slash is ready, evaluate if we should use it
	if(slash_ready)
		var/nearby_enemies = 0
		for(var/mob/living/enemy in range(slash_range, user))
			if(enemy == user)
				continue
			if(istype(enemy, /mob/living/simple_animal/hostile/retaliate/meatvine))
				var/mob/living/simple_animal/hostile/retaliate/meatvine/other = enemy
				if(other.master == user.master)
					continue
			nearby_enemies++

		// High priority if enemies are nearby
		if(nearby_enemies >= 2)
			return 80
		if(nearby_enemies >= 1)
			return 60

		// Medium priority to avoid wasting it
		return 30

	// Otherwise evaluate charging
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return 0

	var/distance = get_dist(user, target)

	// Prefer charging when target is at medium range
	if(distance >= 2 && distance <= 4)
		return 50

	return 0

/datum/action/cooldown/meatvine/personal/charge_slash/ai_use_ability(datum/ai_controller/controller)
	// If slash is ready, execute it
	if(slash_ready)
		execute_aoe_slash()
		return TRUE

	// Otherwise try to charge
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return FALSE

	return Activate(target)

/datum/action/cooldown/meatvine/personal/charge_slash/get_movement_target(datum/ai_controller/controller)
	// If slash is ready and no enemies nearby, move to find targets
	if(slash_ready)
		var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(target && get_dist(owner, target) > slash_range)
			return target
	return null

/datum/action/cooldown/meatvine/personal/charge_slash/get_required_range()
	if(slash_ready)
		return slash_range
	return charge_distance
