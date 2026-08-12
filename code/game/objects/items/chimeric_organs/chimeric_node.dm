GLOBAL_LIST_EMPTY(active_chimeric_surgeries)

/obj/item/chimeric_node
	name = "humores"
	desc = "Un trozo de carne conservado que contiene un humor. Pulsa con vida antinatural."
	icon = 'icons/obj/chimeric_nodes.dmi'
	icon_state = "capillary"
	item_weight = 125 GRAMS
	var/datum/chimeric_node/stored_node
	grid_height = 64
	grid_width = 32
	var/node_tier = 1
	var/node_purity = 80
	var/datum/chimeric_table/table_type

/obj/item/chimeric_node/Destroy()
	if(GLOB.active_chimeric_surgeries?[src])
		var/datum/chimeric_surgery_state/surgery = GLOB.active_chimeric_surgeries[src]
		if(surgery.surgeon)
			to_chat(surgery.surgeon, span_warning("¡La cirugia fue interrumpida!"))
		GLOB.active_chimeric_surgeries -= src
		qdel(surgery)
	return ..()

/obj/item/chimeric_node/examine(mob/user)
	. = ..()
	if(stored_node)
		if(length(stored_node.allowed_organ_slots))
			. += span_notice("Este nodo solo puede ser instalado en: [english_list(stored_node.allowed_organ_slots)]")
		if(length(stored_node.forbidden_organ_slots))
			. += span_warning("Este nodo no se puede instalar en: [english_list(stored_node.forbidden_organ_slots)]")
		if(!length(stored_node.allowed_organ_slots) && !length(stored_node.forbidden_organ_slots))
			. += span_blue("Este nodo es compatible con cualquier organo.")
		if(length(stored_node.compatible_blood_types) || length(stored_node.preferred_blood_types))
			. += span_notice("Este nodo puede usar estos tipos de sangre:")
			for(var/datum/blood_type/blood_type as anything in stored_node.preferred_blood_types)
				. += span_notice("   - [initial(blood_type.name)] Sangre (preferida)")
			for(var/datum/blood_type/blood_type as anything in stored_node.compatible_blood_types)
				if(blood_type in stored_node.preferred_blood_types)
					continue
				. += span_notice("   -[initial(blood_type.name)] Sangre")
		if(length(stored_node.incompatible_blood_types))
			. += span_warning("Este nodo no puede usar estos tipos de sangre:")
			for(var/datum/blood_type/blood_type as anything in stored_node.incompatible_blood_types)
				. += span_warning("   -[initial(blood_type.name)] Sangre")

/obj/item/chimeric_node/proc/setup_node(datum/chimeric_node/incoming_node, list/compatible_blood_types = list(), list/incompatible_blood_types = list(), list/preferred_blood_types = list(), base_blood_cost = 0.3, preferred_blood_bonus = 0.5, incompatible_blood_penalty = 2.0)
	stored_node = new incoming_node

	stored_node.compatible_blood_types = compatible_blood_types
	stored_node.preferred_blood_types = preferred_blood_types
	stored_node.incompatible_blood_types = incompatible_blood_types
	stored_node.base_blood_cost = base_blood_cost
	stored_node.preferred_blood_bonus = preferred_blood_bonus
	stored_node.incompatible_blood_penalty = incompatible_blood_penalty

	stored_node.set_values(node_purity, node_tier)

	switch(stored_node?.slot)
		if(INPUT_NODE)
			icon_state = "input_organoid-[rand(1,7)]"
		if(OUTPUT_NODE)
			icon_state = "output_organoid-[rand(1,7)]"
		if(SPECIAL_NODE)
			icon_state = "process_organoid-[rand(1,7)]"

	update_appearance(UPDATE_NAME)

/obj/item/chimeric_node/update_name(updates)
	. = ..()
	if(!stored_node)
		return
	name = "humor [LOWER_TEXT(stored_node.name)]"

/mob/living/proc/generate_random_chimeric_organs(amount = 3)
	for(var/i=1 to amount)
		var/obj/item/organ/organ_type = pick(/obj/item/organ/heart, /obj/item/organ/lungs, /obj/item/organ/brain, /obj/item/organ/liver, /obj/item/organ/guts)
		var/obj/item/organ/new_organ = new organ_type(get_turf(src))
		new_organ.generate_chimeric_organ(src)

/obj/item/chimeric_node/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/datum/chimeric_surgery_state/surgery = GLOB.active_chimeric_surgeries?[src]

	if(istype(tool, /obj/item/weapon/surgery/scalpel))
		if(!surgery)
			start_node_surgery(user)
		return ITEM_INTERACT_SUCCESS

	if(!surgery)
		return NONE

	if(istype(tool, /obj/item/weapon/surgery/hemostat))
		if(!surgery.extracted)
			surgery_step_extract(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/weapon/surgery/retractor))
		if(surgery.extracted && !surgery.selected_node)
			surgery_step_select_node(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/weapon/surgery/cautery))
		if(surgery.selected_node)
			surgery_step_seal(user)
		return ITEM_INTERACT_SUCCESS

	to_chat(user, span_warning("Esa herramienta no es util en esta etapa de la cirugia."))
	return ITEM_INTERACT_BLOCKING

/obj/item/chimeric_node/proc/start_node_surgery(mob/user)
	if(!stored_node)
		to_chat(user, span_warning("¡No hay ningun nodo para modificar!"))
		return

	to_chat(user, span_notice("Comienzas a abrir cuidadosamente la carne preservada..."))
	if(!do_after(user, 3 SECONDS, src))
		return

	playsound(src, 'sound/surgery/scalpel1.ogg', 50, TRUE)
	to_chat(user, span_notice("El humor esta expuesto. Ahora puedes modificar su esencia con las herramientas adecuadas."))

	var/datum/chimeric_surgery_state/surgery = new()
	surgery.target_node = src
	surgery.current_tier = stored_node.tier
	surgery.current_slot = stored_node.slot
	surgery.preserved_purity = node_purity
	surgery.preserved_tier = node_tier
	surgery.surgeon = user

	LAZYADDASSOC(GLOB.active_chimeric_surgeries, src, surgery)

	to_chat(user, span_info("Utilice un <b>hemostat</b> para extraer la esencia del nodo actual."))

/obj/item/chimeric_node/proc/surgery_step_extract(mob/user)
	var/datum/chimeric_surgery_state/surgery = GLOB.active_chimeric_surgeries[src]
	if(!surgery || surgery.extracted)
		return FALSE

	to_chat(user, span_notice("Usted extrae cuidadosamente la esencia del nodo del tejido preservado..."))
	if(!do_after(user, 4 SECONDS, src))
		return FALSE

	playsound(src, 'sound/surgery/hemostat1.ogg', 50, TRUE)
	surgery.extracted = TRUE
	to_chat(user, span_notice("La esencia ha sido extraida. Usa un <b>retractor</b> para seleccionar un nuevo tipo de nodo."))
	return TRUE

/obj/item/chimeric_node/proc/surgery_step_select_node(mob/user)
	var/datum/chimeric_surgery_state/surgery = GLOB.active_chimeric_surgeries[src]
	if(!surgery || !surgery.extracted || surgery.selected_node)
		return FALSE

	// Create a list of node names for selection
	var/datum/chimeric_table/table = new table_type()
	var/list/available_nodes = table.input_nodes.Copy() + table.generic_inputs.Copy() + table.output_nodes.Copy() + table.generic_outputs.Copy()
	if(!length(available_nodes))
		to_chat(user, span_warning("¡No hay nodos compatibles disponibles!"))
		return FALSE
	var/list/node_names = list()
	var/list/node_lookup = list()
	for(var/datum/chimeric_node/node_type as anything in available_nodes)
		var/node_name = initial(node_type.name)
		var/node_tier = initial(node_type.tier)
		var/display_name = "[node_name] (Nivel [node_tier]) ([ispath(node_type, /datum/chimeric_node/input ? "Input Node" : "Trigger Node")])"
		node_names += display_name
		node_lookup[display_name] = node_type

	var/choice = browser_input_list(user, "Select a new node type:", "Node Selection", node_names)
	if(!choice || !do_after(user, 2 SECONDS, src))
		return FALSE

	surgery.selected_node = node_lookup[choice]
	playsound(src, 'sound/surgery/retractor1.ogg', 50, TRUE)
	to_chat(user, span_notice("Preparas la esencia [initial(surgery.selected_node.name)]. Utilice un cauterio <b></b> para sellar el nuevo nodo."))
	return TRUE

/obj/item/chimeric_node/proc/surgery_step_seal(mob/user)
	var/datum/chimeric_surgery_state/surgery = GLOB.active_chimeric_surgeries[src]
	if(!surgery || !surgery.selected_node)
		return FALSE

	to_chat(user, span_notice("Comienza a sellar el humor modificado..."))
	if(!do_after(user, 5 SECONDS, src))
		return FALSE

	playsound(src, 'sound/surgery/cautery1.ogg', 50, TRUE)

	var/old_name = stored_node.name
	var/new_node_type = surgery.selected_node

	var/list/old_compatible = stored_node.compatible_blood_types?.Copy()
	var/list/old_preferred = stored_node.preferred_blood_types?.Copy()
	var/list/old_incompatible = stored_node.incompatible_blood_types?.Copy()
	var/old_blood_cost = stored_node.base_blood_cost
	var/old_preferred_bonus = stored_node.preferred_blood_bonus
	var/old_incompatible_penalty = stored_node.incompatible_blood_penalty

	QDEL_NULL(stored_node)
	setup_node(
		new_node_type,
		old_compatible,
		old_incompatible,
		old_preferred,
		old_blood_cost,
		old_preferred_bonus,
		old_incompatible_penalty
	)

	GLOB.active_chimeric_surgeries -= src
	qdel(surgery)

	user.visible_message(
		span_notice("[user] completa la modificacion de \the [src]."),
		span_notice("¡Has transformado con exito el [old_name] en un [stored_node.name], preservando su esencia!")
	)

	return TRUE

// Datum to track surgery state
/datum/chimeric_surgery_state
	var/obj/item/chimeric_node/target_node
	var/mob/surgeon
	var/current_slot
	var/current_tier
	var/preserved_purity
	var/preserved_tier
	var/extracted = FALSE
	var/datum/chimeric_node/selected_node
