/obj/item/storage/fancy/pilltin
	name = "lata de pastillas"
	desc = "Una lata para todas tus necesidades de pastillas."
	icon = 'icons/obj/medical.dmi'
	icon_state = "pilltin"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 1
	slot_flags = null
	contents_tag = null
	component_type = /datum/component/storage/concrete/grid/pilltin
	item_weight = 55 GRAMS

/obj/item/storage/fancy/pilltin/update_icon_state()
	. = ..()
	if(is_open)
		if(length(contents) == 0)
			icon_state = "pilltin_empty"
		else if(istype(contents[1], /obj/item/reagent_containers/pill/devour))
			icon_state = "pilltinwake_open"
		else if(istype(contents[1], /obj/item/reagent_containers/pill/sate))
			icon_state = "pilltinpink_open"
		else
			icon_state = "pilltincustom_open"
	else
		icon_state = "pilltin"

/obj/item/storage/fancy/pilltin/MiddleClick(mob/user, list/modifiers)
	is_open = !is_open
	update_appearance(UPDATE_ICON_STATE)
	to_chat(user, span_notice("Estado de [src]: [is_open ? "open" : "closed"]."))

/obj/item/storage/fancy/pilltin/sate
	name = "lata de pastillas (SATE)"
	desc = "Un recipiente de estaño etiquetado como 'SATE' evita la perdida de sangre thaumiel."
	spawn_type = /obj/item/reagent_containers/pill/sate

/obj/item/storage/fancy/pilltin/devour
	name = "lata de pastillas (DEVOUR)"
	desc = "Una pastilla etiquetada como 'DEVORAR' que devora sangre de thaumiel para inducir forzosamente la activacion de organos quimericos."
	spawn_type = /obj/item/reagent_containers/pill/devour
