/mob/living/proc/give(mob/living/offered_to)
	if(!offered_to)
		return

	if(IS_DEAD_OR_INCAP(src))
		to_chat(src, span_warning("¡No puedo ofrecer nada en mi estado actual!"))
		return

	var/obj/item/offering_item = get_active_held_item()
	// if it's an abstract item, should consider it to be non-existent (unless it's a HAND_ITEM, which means it's an obj/item that is just a representation of our hand)
	if(!offering_item || ((offering_item.item_flags & ABSTRACT) && !(offering_item.item_flags & HAND_ITEM)))
		to_chat(src, span_warning("¡No tengo nada que ofrecer!"))
		return

	if(HAS_TRAIT(offering_item, TRAIT_NODROP))
		to_chat(src, span_warning("No puedo ofrecer esto."))
		return

	if(!Adjacent(offered_to))
		to_chat(src, span_warning("¡Tengo que estar al lado de [offered_to.p_them()]!"))
		return

	if(offered_to == src)
		if(offered_item_ref)
			cancel_offering_item()
			return
		to_chat(src, span_warning("¡No puedo ofrecerme un articulo!"))
		return

	if(offered_item_ref)
		var/obj/item/offered_item = offered_item_ref.resolve()
		if(QDELETED(offered_item))
			cancel_offering_item()
			return

		if(offered_item == offering_item)
			cancel_offering_item()
		else
			to_chat(src, span_notice("¡Ya estoy ofreciendo [offered_item]!"))
		return

	offer_item(offered_to, offering_item)
