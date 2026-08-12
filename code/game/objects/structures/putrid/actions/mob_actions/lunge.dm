
/datum/action/cooldown/meatvine/personal/lunge
	name = "Estocada"
	desc = "Preparate durante 1 segundo y luego lanza un devastador ataque de dos fichas que inflige 1,2 veces mas daño a la extremidad objetivo. Requiere clic directo del sprite. Costo: 10 recursos."
	button_icon_state = "lunge"
	cooldown_time = 10 SECONDS
	personal_resource_cost = 10
	var/is_winding_up = FALSE
	var/windup_time = 1 SECONDS

/datum/action/cooldown/meatvine/personal/lunge/IsAvailable()
	. = ..()
	if(!.)
		return FALSE
	if(is_winding_up)
		return FALSE
	return TRUE

/datum/action/cooldown/meatvine/personal/lunge/Activate(atom/target)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(!istype(user))
		return FALSE

	// Check if target is valid and in range (2 tiles)
	if(!isliving(target))
		to_chat(user, span_warning("¡Debes dirigirte a una criatura viva!"))
		return FALSE

	var/distance = get_dist(user, target)
	if(distance > 2 || distance < 1)
		to_chat(user, span_warning("¡El objetivo debe estar a 2 casillas de distancia!"))
		return FALSE

	// Begin windup
	is_winding_up = TRUE
	to_chat(user, span_boldnotice("¡Te preparas para asestar un golpe a [target]!"))
	user.visible_message(span_danger("¡[user] se enrosca, preparandose para atacar!"))

	if(!do_after(user, windup_time, target))
		is_winding_up = FALSE
		to_chat(user, span_warning("¡Tu ataque fue interrumpido!"))
		return FALSE

	is_winding_up = FALSE

	// Check if target is still valid
	if(QDELETED(target) || get_dist(user, target) > 2)
		to_chat(user, span_warning("¡Tu objetivo se ha movido fuera de alcance!"))
		// Apply standard cooldown as a "miss"
		user.changeNext_move(CLICK_CD_MELEE)
		return FALSE

	// Execute the lunge
	var/mob/living/victim = target

	// Calculate damage (1.2x max melee damage)
	var/damage = user.melee_damage_upper * 1.2

	// Determine targeted limb (use click params if available, otherwise random)
	var/obj/item/bodypart/targeted_limb
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		var/zone = user.zone_selected || BODY_ZONE_CHEST
		targeted_limb = human_victim.get_bodypart(zone)

	// Visual and audio feedback
	user.visible_message(
		span_danger("[user] da un salto hacia adelante y golpea a [victim][targeted_limb ? " in the [targeted_limb.name]" : ""]"),
		span_boldnotice("Das un salto hacia adelante y golpeas a [victim][targeted_limb ? " in the [targeted_limb]" : ""]")
	)

	playsound(user, pick('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg'), 50, TRUE)

	if(targeted_limb)
		targeted_limb.receive_damage(brute = damage)
	else
		victim.apply_damage(damage, BRUTE, user.zone_selected, damage_type = BCLASS_CUT)
	. = ..()
	return TRUE

/datum/action/cooldown/meatvine/personal/lunge/evaluate_ai_score(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/user = owner
	if(!istype(user))
		return 0

	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return 0

	var/distance = get_dist(user, target)
	if(distance < 1 || distance > 2)
		return 0

	// High priority if target is low health
	var/target_health_percent = (target.health / target.maxHealth) * 100
	if(target_health_percent < 30)
		return 80

	return 50

/datum/action/cooldown/meatvine/personal/lunge/ai_use_ability(datum/ai_controller/controller)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return FALSE

	return Activate(target)
