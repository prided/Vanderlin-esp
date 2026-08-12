/obj/item/caparison
	name = "Caparazon"
	desc = "Pieza decorativa de tela destinada a ser utilizada como decoracion de silla de montar. Este encaja en un Saiga."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "caparison"
	gender = NEUTER
	item_weight = 500 GRAMS

	var/caparison_icon = 'icons/roguetown/mob/monster/saiga.dmi'
	var/caparison_state = "caparison"
	var/detail_state
	var/list/detail_types
	var/list/symbol_types
	var/female_caparison_state = "caparison-f"
	var/list/valid_animal_types = list(/mob/living/simple_animal/hostile/retaliate/saiga)

/obj/item/caparison/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /mob/living/simple_animal))
		return NONE

	if(!is_type_in_list(interacting_with, valid_animal_types))
		to_chat(user, span_warning("¡\The [src] no se puede usar en [interacting_with]! ¡Solo esta destinado para animales especificos!"))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/simple_animal/animal = interacting_with
	if(animal.adult_growth)
		to_chat(user, span_warning("¡[animal] es un joven y no puede usar una caparison!"))
		return ITEM_INTERACT_BLOCKING

	if(animal.ccaparison)
		to_chat(user, span_warning("¡[animal] ya lleva capa!"))
		return ITEM_INTERACT_BLOCKING

	if(!animal.ssaddle)
		to_chat(user, span_warning("¡[animal] necesita ser montada antes de que puedas ponerle una caparazon!"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user] esta ajustando una caparazon a [animal]..."), span_notice("Empiezo a ponerle un caparazon a [animal]..."))
	if(!do_after(user, 5 SECONDS, animal))
		return ITEM_INTERACT_BLOCKING

	animal.ccaparison = src
	forceMove(animal)
	animal.update_appearance(UPDATE_ICON)
	user.visible_message(span_notice("[user] ajusta una caparazon a [animal]."), span_notice("Apto un caparazon a [animal]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/caparison/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!length(detail_types))
		return

	var/list/possible_detail_types = list("None" = null) + detail_types.Copy()
	if(length(symbol_types))
		possible_detail_types += list("Symbol" = null)

	var/chosen_design = tgui_input_list(user, "Selecciona un diseño.", "Diseño de caparazon", possible_detail_types)
	if(!chosen_design)
		return

	if(chosen_design == "Symbol")
		var/chosen_symbol = tgui_input_list(user, "Seleccione un simbolo.", "Diseño de caparazon", symbol_types)
		if(!chosen_symbol)
			return
		detail_state = symbol_types[chosen_symbol]
	else
		detail_state = detail_types[chosen_design]

	var/list/colors_to_pick = list()

	if(GLOB.lordprimary)
		colors_to_pick["Primary Keep Color"] = GLOB.lordprimary

	if(GLOB.lordsecondary)
		colors_to_pick["Secondary Keep Color"] = GLOB.lordsecondary

	colors_to_pick += GLOB.noble_dyes

	var/primary_color = tgui_input_list(user, "Seleccione un color primario.", "Caparison Design", colors_to_pick)
	if(!primary_color)
		return
	color = colors_to_pick[primary_color]

	if(chosen_design != "None")
		if(chosen_design != "Symbol")
			var/secondary_color = tgui_input_list(user, "Seleccione un color secundario.", "Caparison Design", colors_to_pick)
			if(!secondary_color)
				return
			detail_color = colors_to_pick[secondary_color]
		else
			detail_color = COLOR_WHITE

//////////////////////
// SUBTYPES - SAIGA //
//////////////////////

/obj/item/caparison/psy
	name = "psydonite capazon"
	desc = "Pieza decorativa de tela destinada a ser utilizada como decoracion de silla de montar. Esta adornado con Psycrosses. Este encaja en un Saiga."
	caparison_state = "psy_caparison"
	female_caparison_state = "psy_caparison-f"

/obj/item/caparison/astrata
	name = "astratan capazon"
	desc = "Pieza decorativa de tela destinada a ser utilizada como decoracion de silla de montar. Esta adornado con cruces Astratan. Este encaja en un Saiga."
	caparison_state = "astra_caparison"
	female_caparison_state = "astra_caparison-f"

/obj/item/caparison/eora
	name = "eoran capazon"
	desc = "Pieza decorativa de tela destinada a ser utilizada como decoracion de silla de montar. Esta adornado con corazones Eoran. Este encaja en un Saiga."
	caparison_state = "eora_caparison"
	female_caparison_state = "eora_caparison-f"

/obj/item/caparison/azure
	name = "caparazon azul"
	desc = "Pieza decorativa de tela destinada a ser utilizada como decoracion de silla de montar. Esta adornado con colores ducales. Este encaja en un Saiga."
	caparison_state = "azure_caparison"
	female_caparison_state = "azure_caparison-f"

/obj/item/caparison/heartfelt
	name = "caparazon de Heartfelt"
	desc = "Pieza decorativa de tela destinada a ser utilizada como decoracion de silla de montar. Esta adornado con los colores de Heartfelt. Este encaja en un Saiga."
	caparison_state = "heartfelt_caparison"
	female_caparison_state = "heartfelt_caparison-f"

/////////////////////////
// SUBTYPES - HONSE //
/////////////////////////

/obj/item/caparison/honse
	name = "Caparazon"
	desc = "Pieza decorativa de tela destinada a ser utilizada como decoracion de silla de montar. Este encaja en un Honse."
	caparison_icon = 'icons/mob/monster/fogbeast.dmi'
	valid_animal_types = list(/mob/living/simple_animal/hostile/retaliate/honse)
	color = COLOR_WHITE
	detail_types = list("Quad" = "quad")
	symbol_types = list("Psycross" = "psycross", "Astrata" = "astrata")
	item_weight = 700 GRAMS
