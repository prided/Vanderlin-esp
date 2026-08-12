/obj/item/augment_kit
	name = "kit de mejoras"
	desc = "Un kit que contiene componentes para el aumento de automatas. Examinar para ver detalles."
	icon = 'icons/roguetown/items/new_gears.dmi'
	icon_state = "steel_gear"
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 32
	grid_height = 32
	item_weight = 372 GRAMS
	var/datum/augment/contained_augment
	color = COLOR_ASSEMBLY_PURPLE

/obj/item/augment_kit/Initialize(mapload)
	. = ..()
	if(contained_augment)
		contained_augment = new contained_augment()
		update_augment()

/obj/item/augment_kit/examine(mob/user)
	. = ..()
	if(contained_augment)
		. += span_info("Este kit contiene: [contained_augment.name]")
		. += span_info("La instalacion requiere el nivel de habilidad de Ingenieria [contained_augment.engineering_difficulty]")
		. += contained_augment.get_examine_info()
	else
		. += span_info("Esta vacio. Haz clic derecho en alguien para recoger un refuerzo de el.")

/obj/item/augment_kit/proc/update_augment()
	if(contained_augment)
		color = contained_augment.color
		name = "Kit [contained_augment.name]"
		desc = "[contained_augment.desc]\n\nStability Costo: [contained_augment.stability_cost]\nRequired Habilidad: Ingenieria [contained_augment.engineering_difficulty]"
	else
		color = initial(color)
		name = initial(name)
		desc = initial(desc)
	update_appearance(UPDATE_ICON)

/obj/item/augment_kit/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE

	if(!contained_augment)
		to_chat(user, span_warning("¡[src] esta vacio!"))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/augmented = interacting_with

	if(!SEND_SIGNAL(augmented, COMSIG_AUGMENT_GET_STABILITY))
		to_chat(user, span_warning("¡[augmented] no puede ser aumentado!"))
		return ITEM_INTERACT_BLOCKING

	if(!istype(augmented.buckled, /obj/machinery/artificer_table))
		to_chat(user, span_warning("¡[augmented] debe estar en la mesa del artifex!"))
		return ITEM_INTERACT_BLOCKING

	var/skill = GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/craft/engineering)
	if(skill < contained_augment.engineering_difficulty)
		to_chat(user, span_warning("¡Le falta la habilidad de ingenieria para instalar este aumento!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Comienzas a instalar [contained_augment.name]..."))

	if(!do_after(user, contained_augment.installation_time, target = augmented))
		return

	var/result = SEND_SIGNAL(augmented, COMSIG_AUGMENT_INSTALL, contained_augment, user)
	if(result & COMPONENT_AUGMENT_SUCCESS)
		contained_augment = null
		update_augment()
		playsound(src, 'sound/effects/sparks1.ogg', 75, TRUE)

/obj/item/augment_kit/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE

	var/mob/living/augmented = interacting_with

	if(!SEND_SIGNAL(augmented, COMSIG_AUGMENT_GET_STABILITY))
		to_chat(user, span_warning("¡[augmented] no puede ser aumentado!"))
		return ITEM_INTERACT_BLOCKING

	if(!istype(augmented.buckled, /obj/machinery/artificer_table))
		to_chat(user, span_warning("¡[augmented] debe estar en la mesa del artifex!"))
		return ITEM_INTERACT_BLOCKING

	if(contained_augment)
		to_chat(user, span_warning("¡[src] tiene un refuerzo en su interior!"))
		return ITEM_INTERACT_BLOCKING

	var/list/augments = list()
	SEND_SIGNAL(augmented, COMSIG_AUGMENT_GET_INSTALLED, augments)
	if(!length(augments))
		to_chat(user, span_warning("[augmented] no tiene ningun refuerzo."))
		return ITEM_INTERACT_BLOCKING

	var/list/names = list()
	var/i = 0
	for(var/datum/augment/A in augments)
		i++
		names["[i]. [A.name]"] = A

	var/chosen = tgui_input_list(user, "¿Recoger que aumento?", "Artificio", names, timeout = 20 SECONDS)
	var/datum/augment/to_remove = names[chosen]
	if(!chosen || QDELETED(to_remove) || QDELETED(augmented))
		return ITEM_INTERACT_BLOCKING

	var/skill = GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/craft/engineering)
	if(skill < to_remove.engineering_difficulty)
		to_chat(user, span_warning("¡Te falta la habilidad de ingenieria para desinstalar este aumento!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Comienzas a desinstalar el [to_remove.name]..."))
	if(!do_after(user, to_remove.installation_time, target = augmented))
		return ITEM_INTERACT_BLOCKING

	var/result = SEND_SIGNAL(augmented, COMSIG_AUGMENT_REMOVE, to_remove, user)
	if(result & COMPONENT_AUGMENT_SUCCESS)
		contained_augment = to_remove
		update_augment()
		playsound(src, 'sound/effects/sparks1.ogg', 75, TRUE)

	return ITEM_INTERACT_SUCCESS
