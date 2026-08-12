/obj/item/customlock //custom lock unfinished
	name = "cerradura sin terminar"
	desc = "Una cerradura sin sus pasadores colocados. Posibilidades infinitas..."
	icon = 'icons/roguetown/items/keys.dmi'
	icon_state = "lock"
	w_class = WEIGHT_CLASS_SMALL
	dropshrink = 0.75
	can_unlock = FALSE // :D
	item_weight = 200 GRAMS

/obj/item/customlock/examine()
	. = ..()
	if(get_access())
		. += span_info("Ha sido grabado con [access2string()].")
		return
	. += span_info("Sus pasadores se pueden ajustar con un martillo o copiarse de una cerradura o llave existente.")

/obj/item/customlock/proc/check_access(obj/item/I)
	var/access
	if(istype(I, /obj/item/key/custom))
		var/obj/item/key/custom/k = I
		if(k.access2add)
			access = k.access2add
		else
			access = k.get_access()
	else
		access = I.get_access()
	if(!access)
		return FALSE
	for(var/id in lockids)
		if(id in access)
			return TRUE
	return FALSE

/obj/item/customlock/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.cmode)
		return NONE

	if(istype(tool, /obj/item/weapon/hammer))
		var/input = input(user, "¿En que le gustaria configurar la ID de bloqueo?", "", 0) as num
		input = abs(input)
		if(!input)
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("Has establecido el ID de la cerradura en [input]."))
		lockids = list("[input]")
		return ITEM_INTERACT_SUCCESS

	if(!check_access(tool))
		to_chat(user, span_warning("¡[tool] atascado en [src]!"))
		return ITEM_INTERACT_SUCCESS

	to_chat(user, span_notice("[tool] gira con facilidad en [src]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/customlock/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/weapon/hammer))
		if(!length(lockids))
			to_chat(user, span_notice("[src] no esta listo, ¡sus pines no estan ajustados!"))
			return ITEM_INTERACT_BLOCKING
		var/obj/item/customlock/finished/F = new (get_turf(src))
		F.lockids = lockids
		to_chat(user, span_notice("Usted termina [F]."))
		var/old_loc = loc
		qdel(src)
		if(user == old_loc)
			user.put_in_hands(F)
		return ITEM_INTERACT_SUCCESS

	if(!copy_access(tool))
		to_chat(user, span_warning("¡No puedo basar los pines en [tool]!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Coloque los pasadores segun [tool]."))
	return ITEM_INTERACT_SUCCESS

//finished lock
/obj/item/customlock/finished
	name = "cerradura"
	desc = "Una cerradura de hierro personalizada que se utiliza con llaves. Se puede grabar un nombre con un martillo."
	var/holdname = ""

/obj/item/customlock/finished/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/weapon/hammer))
		return NONE

	holdname = browser_input_text(user, "What would you like to name this?", "", max_length = MAX_CHARTER_LEN)

	if(holdname)
		to_chat(user, span_notice("Etiqueta el [name] con [holdname]."))

	return ITEM_INTERACT_SUCCESS

/obj/item/customlock/finished/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	return NONE

/obj/item/customlock/finished/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isobj(interacting_with))
		return NONE

	var/obj/O = interacting_with

	if(!O.can_add_lock)
		to_chat(user, span_warning("No hay lugar para una cerradura en [O]."))
		return ITEM_INTERACT_BLOCKING

	if(O.lock)
		to_chat(user, span_warning("[O] ya tiene una cerradura."))
		return ITEM_INTERACT_BLOCKING

	if(holdname)
		O.name = holdname

	O.lock = new /datum/lock/key(O, lockids)
	to_chat(user, span_notice("Apto [src] para [O]."))
	qdel(src)

	return ITEM_INTERACT_SUCCESS
