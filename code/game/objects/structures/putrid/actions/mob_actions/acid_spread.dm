/datum/action/cooldown/meatvine/personal/ranged/spread/lethal
	name = "Escupir acido para untar"
	desc = "Escupe una cantidad de acido a alguien y lo quema."
	acid_projectile = null
	acid_casing = /obj/item/ammo_casing/xenospit/spread/lethal
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"

/datum/action/cooldown/meatvine/personal/ranged/spread/evaluate_ai_score(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/mob = owner
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]

	if(!target || QDELETED(target))
		return 0

	var/dist = get_dist(mob, target)

	// Spread is good at medium range with multiple enemies
	if(dist < 2 || dist > 8)
		return 0

	// Count nearby enemies
	var/nearby_enemies = 0
	for(var/mob/living/L in range(3, target))
		if(L == mob || L.stat == DEAD)
			continue
		if(mob.faction_check_atom(L))
			continue
		nearby_enemies++

	// Score higher with multiple targets
	if(nearby_enemies >= 2)
		return 90
	else if(nearby_enemies == 1)
		return 50

	return 0

/obj/item/ammo_casing/xenospit/spread/lethal
	name = "gran masa de acido"
	projectile_type = /obj/projectile/neurotoxin/acid/spitter_spread
	pellets = 4
	variance = 30

/obj/projectile/neurotoxin/acid/spitter_spread
	name = "saliva acida"
	icon_state = "toxin"
	damage = 15
	damage_type = BURN
