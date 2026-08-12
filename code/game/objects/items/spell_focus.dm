/obj/item/spell_focus
	name = "enfoque arcyne"
	desc = "Un cristal facetado en bruto enhebrado con filamentos arcyne. Espera ser grabado con un hechizo."
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "e_cut"
	w_class = WEIGHT_CLASS_TINY
	/// The spell type etched into this focus, null if blank
	var/datum/action/cooldown/spell/stored_spell_type = null
	/// Cached spell name
	var/stored_spell_name = null
	/// Spell tier of the etched spell
	var/spell_tier = 0
	/// Charges to grant when consumed by an imbuing rune
	var/grant_charges = 1

/obj/item/spell_focus/examine(mob/user)
	. = ..()
	if(stored_spell_type)
		. += span_notice("Pulsa con memoria almacenada, [stored_spell_name], nivel [spell_tier].")
		. += span_notice("Concedera [grant_charges] carga\s cuando se imbuya.")
	else
		. += span_warning("Esta en blanco, esperando ser grabado.")

/obj/item/spell_focus/update_overlays()
	. = ..()
	if(!stored_spell_type)
		return
	var/mutable_appearance/MA = mutable_appearance(initial(stored_spell_type.button_icon), initial(stored_spell_type.button_icon_state))
	MA.alpha = 100
	. += MA

/obj/item/spell_focus/random/Initialize(mapload)
	. = ..()
	stored_spell_type = pick(subtypesof(/datum/action/cooldown/spell))
	if(IS_ABSTRACT(stored_spell_type))
		while(IS_ABSTRACT(stored_spell_type))
			stored_spell_type = pick(subtypesof(/datum/action/cooldown/spell))
	stored_spell_name = initial(stored_spell_type.name)
	name = "enfoque [initial(stored_spell_type.name)]"
	desc = "Un foco grabado con [initial(stored_spell_type.name)]. Puede ser consumido por una foca imbuyente."
	update_appearance(UPDATE_OVERLAYS)
