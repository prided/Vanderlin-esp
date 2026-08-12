
/obj/item/storage/fancy/ifak
	name = "kit de parches personales"
	desc = "Bolsa de tratamiento personal; tiene todo lo que necesita para evitar que usted o otra persona conozcan Necra."
	icon = 'icons/obj/medical.dmi'
	icon_state = "ifak"
	w_class = WEIGHT_CLASS_NORMAL // So you can put stuff like bottles and Vials into it
	component_type = /datum/component/storage/concrete/grid/ifak
	throwforce = 1
	slot_flags = ITEM_SLOT_HIP
	populate_contents = list(
		/obj/item/reagent_containers/syringe,
		/obj/item/natural/cloth/bandage,
		/obj/item/natural/cloth/bandage,
		/obj/item/natural/bundle/fibers/full,
		/obj/item/storage/fancy/pilltin/sate,
		/obj/item/storage/fancy/pilltin/devour,
		/obj/item/candle/yellow,
		/obj/item/needle,
	)
	item_weight = 740 GRAMS
	contents_tag = "item"

/obj/item/storage/fancy/ifak/update_icon_state()
	. = ..()
	if(is_open)
		if(length(contents) == 0)
			icon_state = "ifak_empty"
		else
			icon_state = "ifak_open"
	else
		icon_state = "ifak"

/obj/item/storage/fancy/ifak/attack_self(mob/user, list/modifiers)
	. = ..()
	to_chat(user, span_notice("Estado de [src]: [is_open ? "open" : "closed"]."))
