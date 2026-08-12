/proc/merge_spellcraft_multipliers(list/target, list/source, amplifier = 1)
	for(var/key in source)
		var/base = target[key] || 1
		var/scaled_source = 1 + (source[key] - 1) * amplifier
		target[key] = base * scaled_source

/proc/merge_spellcraft_additions(list/target, list/source)
	for(var/key in source)
		target[key] = (target[key] || 0) + source[key]

/datum/spellcraft_session
	var/obj/item/spellbook_unfinished/pre_arcyne/book_base
	var/obj/item/meld
	var/list/materials = list(null, null, null, null, null, null)
	var/mob/living/user

/datum/spellcraft_session/Destroy(force)
	. = ..()
	book_base = null
	meld = null
	user = null
	materials = null

/datum/spellcraft_session/proc/try_insert_meld(obj/item/item, mob/living/user)
	if(meld)
		to_chat(user, span_warning("El centro ya esta ocupado."))
		return FALSE
	if(!item.get_spellcraft_meld_data())
		to_chat(user, span_warning("[item] no se siente arcyne lo suficientemente catalizador."))
		return FALSE
	meld = item
	user.temporarilyRemoveItemFromInventory(item)
	return TRUE

/datum/spellcraft_session/proc/try_insert_material(index, obj/item/item, mob/living/user)
	if(materials[index])
		return FALSE
	var/contribution = item.get_spellcraft_contribution()
	if(!contribution)
		to_chat(user, span_warning("[item] no tiene propiedades arcyne."))
		return FALSE
	materials[index] = item
	user.temporarilyRemoveItemFromInventory(item)
	return TRUE

/datum/spellcraft_session/proc/assemble(mob/living/user)
	if(!can_assemble())
		return FALSE
	var/list/meld_data = meld.get_spellcraft_meld_data()
	if(!meld_data)
		return FALSE

	var/born_of_rock = !!meld_data["born_of_rock"]
	var/base_crafttime = 100 - (meld_data["crafttime_bonus"] || 0)
	var/crafttime = max(0, base_crafttime - GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/arcane) * 5)
	if(!do_after(user, crafttime, target = book_base))
		return FALSE

	var/list/form_points = list()
	var/list/technique_points = list()
	var/list/form_cost_multipliers = list()
	var/list/form_cast_speed_multipliers = list()
	var/list/form_magnitude_modifications = list()
	var/list/technique_cost_multipliers = list()
	var/list/technique_cast_speed_multipliers = list()
	var/list/technique_magnitude_modifications = list()
	var/amplifier = meld_data["amplifier"] || 1

	for(var/obj/item/mat in materials)
		if(!mat)
			continue
		var/datum/spellcraft_contribution/contribution = mat.get_spellcraft_contribution()
		if(!contribution)
			continue
		for(var/form in contribution.form_points)
			form_points[form] = (form_points[form] || 0) + contribution.form_points[form] * amplifier
		for(var/tech in contribution.technique_points)
			technique_points[tech] = (technique_points[tech] || 0) + contribution.technique_points[tech] * amplifier
		merge_spellcraft_multipliers(form_cost_multipliers, contribution.form_cost_multipliers, amplifier)
		merge_spellcraft_multipliers(form_cast_speed_multipliers, contribution.form_cast_speed_multipliers, amplifier)
		merge_spellcraft_additions(form_magnitude_modifications, contribution.form_magnitude_modifications)
		merge_spellcraft_multipliers(technique_cost_multipliers, contribution.technique_cost_multipliers, amplifier)
		merge_spellcraft_multipliers(technique_cast_speed_multipliers, contribution.technique_cast_speed_multipliers, amplifier)
		merge_spellcraft_additions(technique_magnitude_modifications, contribution.technique_magnitude_modifications)
	var/book_type = meld_data["book_type"]
	var/skilled = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/arcane) > SKILL_LEVEL_NONE

	if(!skilled)
		switch(meld_data["unskilled_behavior"])
			if("cosmetic")
				to_chat(user, span_notice("Presiono [meld] en la portada del libro. ¡Que bonito diseño seria este!"))
				return FALSE

			if("fumble_chance")
				if(prob(meld_data["unskilled_prob"] || 0))
					user.visible_message(
						span_warning("[user] coloca cuidadosamente [meld] sobre [book_base]. No pasa nada por un momento o tres, luego el resplandor que lo rodea se vuelve liquido y se filtra en el tomo."),
						span_notice("¡Sabia que esta piedra era especial! ¡Su magia colorida se ha impregnado en mi tomo y me ha dado el regalo del misterio!")
					)
					to_chat(user, span_notice("¿Que diablos significa esta garabateria?"))
					var/obj/item/spellbook/newbook = book_base.finish_book(user, meld, book_type, born_of_rock, meld_data["extra_desc"])
					apply_crafting_bonuses(newbook, meld_data, form_points, technique_points, \
						form_cost_multipliers, form_cast_speed_multipliers, form_magnitude_modifications, \
						technique_cost_multipliers, technique_cast_speed_multipliers, technique_magnitude_modifications)
					clear_materials()
					return TRUE
				user.visible_message(
					span_warning("[user] coloca [meld] sobre la superficie de [book_base] y observa con expectacion. Sin previo aviso, ¡se abre violentamente como una calabaza aplastada!"),
					span_notice("¡No! ¡Mi precioso [meld]! No quiso compartir sus misterios conmigo...")
				)
				user.electrocute_act(meld_data["shock_damage"] || 5, book_base)
				qdel(meld)
				meld = null
				clear_materials()
				return TRUE

			else
				user.visible_message(
					span_warning("[user] coloca [meld] sobre la superficie de [book_base] y observa expectante. Sin previo aviso, ¡[meld] explota violentamente!"),
					span_notice("¡Deberia haber sabido que meterme con el arcyne era peligroso!")
				)
				user.electrocute_act(meld_data["shock_damage"] || 5, book_base)
				qdel(meld)
				meld = null
				clear_materials()
				return TRUE

	user.visible_message(
		span_warning("[user] imbuye [user.p_their()] [meld] ¡Se fusiona en [book_base]."),
		span_notice("Unire mi energia arcyne con la del [meld] en mis manos, que tiembla brevemente antes de disolverse en motas de energia...")
	)
	var/obj/item/spellbook/newbook = book_base.finish_book(user, meld, book_type, born_of_rock, meld_data["extra_desc"])
	apply_crafting_bonuses(newbook, meld_data, form_points, technique_points, \
		form_cost_multipliers, form_cast_speed_multipliers, form_magnitude_modifications, \
		technique_cost_multipliers, technique_cast_speed_multipliers, technique_magnitude_modifications)
	newbook.owner = user
	clear_materials()
	return TRUE

/datum/spellcraft_session/proc/apply_crafting_bonuses(obj/item/spellbook/newbook, list/meld_data, \
	list/form_points, list/technique_points, list/form_cost_multipliers, list/form_cast_speed_multipliers, \
	list/form_magnitude_modifications, list/technique_cost_multipliers, list/technique_cast_speed_multipliers, \
	list/technique_magnitude_modifications)

	if(!newbook)
		return

	var/has_modifiers = length(form_cost_multipliers) || length(form_cast_speed_multipliers) || length(form_magnitude_modifications) \
		|| length(technique_cost_multipliers) || length(technique_cast_speed_multipliers) || length(technique_magnitude_modifications)
	if(has_modifiers)
		newbook.AddComponent(/datum/component/spell_modifier, \
			form_cost_multipliers, form_cast_speed_multipliers, form_magnitude_modifications, \
			technique_cost_multipliers, technique_cast_speed_multipliers, technique_magnitude_modifications)

	var/datum/spell_mastery/mastery = newbook.get_or_make_mastery()
	if(!mastery)
		return

	var/generic_points = meld_data["generic_points"] || 0
	var/generic_points_form = meld_data["generic_points_form"] || 0
	if(generic_points_form)
		mastery.adjust_form_points(generic_points_form)
	if(generic_points)
		mastery.adjust_technique_points(generic_points)

	for(var/form in form_points)
		mastery.form_levels[form] = mastery.get_form_level(form) + form_points[form]
		mastery.initial_form_points += form_points[form]
	for(var/tech in technique_points)
		mastery.technique_levels[tech] = mastery.get_technique_level(tech) + technique_points[tech]
		mastery.initial_technique_points += technique_points[tech]

	mastery.recalculate_unspent_points()

/datum/spellcraft_session/proc/eject_meld(mob/living/user)
	if(!meld)
		return FALSE
	user.put_in_hands(meld)
	meld = null
	return TRUE

/datum/spellcraft_session/proc/eject_material(index, mob/living/user)
	if(!materials[index])
		return FALSE
	user.put_in_hands(materials[index])
	materials[index] = null
	return TRUE

/datum/visual_ui/spellcraft_star/valid()
	var/obj/item/spellbook_unfinished/pre_arcyne/book = get_book()
	if(!book)
		return FALSE
	var/mob/user = get_user()
	if(!user || !user.Adjacent(book))
		return FALSE
	return TRUE

/datum/spellcraft_session/proc/clear_materials()
	for(var/i in 1 to length(materials))
		var/obj/item/mat = materials[i]
		if(mat)
			qdel(mat)
		materials[i] = null

/datum/spellcraft_session/proc/can_assemble()
	return !!meld

///behold shitcode
/obj/item/proc/get_spellcraft_meld_data()
	return null

/obj/item/gem/get_spellcraft_meld_data()
	return list(
		"book_type" = /obj/item/spellbook/adept,
		"amplifier" = 1.0,
		"generic_points" = 0,
		"generic_points_form" = 0,
		"unskilled_behavior" = "cosmetic", // unskilled users just admire it, nothing consumed
	)

/obj/item/gem/violet/get_spellcraft_meld_data()
	return list(
		"book_type" = /obj/item/spellbook/expert,
		"amplifier" = 1.2,
		"generic_points" = 0,
		"generic_points_form" = 0,
		"unskilled_behavior" = "cosmetic",
	)

/obj/item/natural/stone/get_spellcraft_meld_data()
	if(!magic_power)
		return null
	return list(
		"book_type" = stone_quality_to_book(),
		"amplifier" = 1.0,
		"generic_points" = round(magic_power / 4),
		"generic_points_form" = round(magic_power / 2),
		"crafttime_bonus" = magic_power, // faster to bind, mirrors the old (130 - magic_power) formula
		"shock_damage" = 5,
		"born_of_rock" = TRUE,
		"extra_desc" = " Traces of multicolored stone limn its margins.",
		"unskilled_behavior" = "fumble_chance",
		"unskilled_prob" = magic_power * 5,
	)

/obj/item/natural/melded/get_spellcraft_meld_data()
	return list(
		"book_type" = melded_quality,
		"amplifier" = amplifier,
		"generic_points" = round(shock_damage / 20),
		"generic_points_form" = round(shock_damage / 10),
		"shock_damage" = shock_damage,
	)

/// Moved off spellbook_unfinished/pre_arcyne since the stone itself is the natural owner of this logic now.
/obj/item/natural/stone/proc/stone_quality_to_book()
	if(magic_power >= 10)
		return /obj/item/spellbook/apprentice
	if(magic_power > 5)
		return /obj/item/spellbook/mid
	return /obj/item/spellbook/horrible


/obj/item/proc/get_spellcraft_contribution()
	return GLOB.spellcraft_contributions[type]
