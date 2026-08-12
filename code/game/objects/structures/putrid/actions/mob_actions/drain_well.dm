/datum/action/cooldown/meatvine/personal/drain_well
	name = "Drenar pozo curativo"
	desc = "Drena un pozo de curacion para obtener recursos personales. Debe ser adyacente. Costo: Ninguno, Enfriamiento: 60s"
	button_icon_state = "drain_well"
	cooldown_time = 0
	personal_resource_cost = 0
	click_to_activate = TRUE
	unset_after_click = TRUE

/datum/action/cooldown/meatvine/personal/drain_well/Activate(atom/target)
	var/mob/living/simple_animal/hostile/retaliate/meatvine/consumed = owner
	if(!istype(consumed))
		return FALSE

	var/obj/structure/meatvine/healing_well/well = target
	if(!istype(well))
		to_chat(owner, span_warning("¡Debe seleccionar un pozo de curacion!"))
		return FALSE

	if(!consumed.start_draining_well(well))
		return FALSE

	return TRUE
