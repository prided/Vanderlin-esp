/datum/spellobject_entry
	/// Type path of the stored spell
	var/datum/action/cooldown/spell/spell_type = null
	/// Cached display name
	var/spell_name = null
	/// Casts remaining
	var/charges = 1
	/// Live granted spell instance (passive-grant mode only)
	var/datum/action/cooldown/spell/live_spell = null

/obj/item/arcyne_spellobject
	name = "objeto de hechizo arcyne"
	desc = "Un objeto ensartado con filamentos arcyne."
	w_class = WEIGHT_CLASS_SMALL

	grid_width = 64
	grid_height = 32
	/// Maximum number of distinct spell slots
	var/max_spells = 3
	/// Minimum accepted spell tier
	var/min_spell_tier = 0
	/// Maximum accepted spell tier
	var/max_spell_tier = 99
	///if we hijack a click or obscure
	var/spellobject_flags = NONE
	/// List of /datum/spellobject_entry
	var/list/datum/spellobject_entry/stored_spells = list()
	/// TRUE while spells are actively granted (passive mode only)
	var/active = FALSE
	/// Whether or not it fills itself on spawn.
	var/has_random_spells = FALSE

/obj/item/arcyne_spellobject/Initialize(mapload)
	. = ..()
	if(has_random_spells)
		generate_random_spells()

/obj/item/arcyne_spellobject/examine(mob/user)
	. = ..()
	if(!length(stored_spells))
		. += span_warning("Esta frio y vacio.")
		return
	. += span_notice("Conjuros almacenados dentro de ([length(stored_spells)]/[max_spells]):")
	for(var/datum/spellobject_entry/E in stored_spells)
		// Chaotic items obscure their spell names
		if(spellobject_flags & SPELLOBJECT_CHAOTIC)
			. += span_notice("  ??? - [E.charges] carga\s restante.")
		else
			. += span_notice("  [E.spell_name] - [E.charges] carga\s restante.")
	if(spellobject_flags & SPELLOBJECT_HIJACK_CLICK)
		. += span_notice("Se escucha un crujido debil, haga clic para liberar su magia.")
	if(spellobject_flags & SPELLOBJECT_CHAOTIC)
		. += span_warning("La magia interior se siente salvaje e impredecible.")

/obj/item/arcyne_spellobject/update_overlays()
	. = ..()
	if(!(spellobject_flags & SPELLOBJECT_VISUAL))
		return
	var/i = 0
	for(var/datum/spellobject_entry/E in stored_spells)
		var/datum/action/cooldown/spell/S = E.spell_type
		var/mutable_appearance/MA = mutable_appearance(initial(S.button_icon), initial(S.button_icon_state))
		MA.alpha = max(40, 120 - i * 20)
		MA.pixel_z = i * 2
		. += MA
		i++

/obj/item/arcyne_spellobject/equipped(mob/user, slot)
	. = ..()
	if(spellobject_flags & SPELLOBJECT_HIJACK_CLICK)
		return
	if(!length(stored_spells))
		return
	grant_all_spells(user)

/obj/item/arcyne_spellobject/dropped(mob/user)
	. = ..()
	if(spellobject_flags & SPELLOBJECT_HIJACK_CLICK)
		return
	if(active)
		revoke_all_spells(user)

/obj/item/arcyne_spellobject/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
	if(!(spellobject_flags & SPELLOBJECT_HIJACK_CLICK))
		return ..()
	//no proximity check; works at any distance
	if(!length(stored_spells))
		to_chat(user, span_warning("No hay nada almacenado dentro."))
		return
	fire_hijack_spell(user, target)

/obj/item/arcyne_spellobject/proc/fire_hijack_spell(mob/living/user, mob/living/intended_target)
	var/datum/spellobject_entry/E = stored_spells[1]
	var/datum/action/cooldown/spell/spell_type = E.spell_type
	var/skill_level = GET_MOB_SKILL_VALUE(user, initial(spell_type.associated_skill))
	var/requirement
	if(skill_level >= SKILL_LEVEL_LEGENDARY)
		requirement = SPELLOBJECT_AIM_REQ_LEGENDARY
	else if(skill_level >= SKILL_LEVEL_MASTER)
		requirement = SPELLOBJECT_AIM_REQ_MASTER
	else if(skill_level >= SKILL_LEVEL_EXPERT)
		requirement = SPELLOBJECT_AIM_REQ_EXPERT
	else if(skill_level >= SKILL_LEVEL_JOURNEYMAN)
		requirement = SPELLOBJECT_AIM_REQ_JOURNEYMAN
	else if(skill_level >= SKILL_LEVEL_APPRENTICE)
		requirement = SPELLOBJECT_AIM_REQ_APPRENTICE
	else if(skill_level >= SKILL_LEVEL_NOVICE)
		requirement = SPELLOBJECT_AIM_REQ_NOVICE
	else
		requirement = SPELLOBJECT_AIM_REQ_NONE

	var/roll_result = user.diceroll(requirement = requirement, crit = 3)

	var/mob/living/actual_target
	if(spellobject_flags & SPELLOBJECT_STABLE)
		actual_target = intended_target
	else
		switch(roll_result)
			if(DICE_CRIT_SUCCESS)
				actual_target = intended_target
				user.visible_message(
					span_notice("[user] niveles [src], ¡un rayo abrasador se lanza recto y verdadero!"),
					span_notice("La magia responde perfectamente [E.spell_name] los disparos son precisos.")
				)
			if(DICE_SUCCESS)
				actual_target = intended_target
				user.visible_message(
					span_notice("[user] niveles [src] y una rafaga de lanzas de energia hacia [intended_target] ¡Vaya!"),
					span_notice("El hechizo se dispara hacia [intended_target].")
				)
			if(DICE_FAILURE)
				if(spellobject_flags & SPELLOBJECT_CHAOTIC)
					var/list/nearby = get_hearers_in_view(7, user) - user
					actual_target = length(nearby) ? pick(nearby) : user
					user.visible_message(
						span_warning("¡[user] ve como [src] chisporrotea y la magia se lanza descontrolada hacia [actual_target]!"),
						span_warning("La magia escapa de tu control, el hechizo se dirige hacia [actual_target] ¡!")
					)
				else
					actual_target = user
					user.visible_message(
						span_warning("¡[user] ve como [src] chisporrotea y la magia se vuelve contra su creador!"),
						span_warning("La magia se te escapa de control [E.spell_name] ¡y rebota en ti!")
					)
			if(DICE_CRIT_FAILURE)
				if(spellobject_flags & SPELLOBJECT_CHAOTIC)
					var/list/wild = get_hearers_in_view(14, user) - user
					actual_target = length(wild) ? pick(wild) : user
					user.visible_message(
						span_boldwarning("¡[user]'s [src] estalla en una luz salvaje, el hechizo grita hacia [actual_target]!"),
						span_boldwarning("¡Explosion catastrofica, el hechizo explota hacia [actual_target]!")
					)
				else
					actual_target = user
					user.visible_message(
						span_boldwarning("[user]'s [src] ¡se descontrola violentamente, el hechizo explota y rebota en ellos!"),
						span_boldwarning("¡La magia falla estrepitosamente [E.spell_name] y explota en tu cara!")
					)

	var/datum/action/cooldown/spell/instance = new E.spell_type(user)
	instance.spell_cost = 0
	instance.cooldown_time = 0
	instance.spell_flags |= SPELL_TEMPORARY
	instance.Grant(user)
	instance.cast(actual_target)
	instance.Remove(user)
	qdel(instance)

	consume_entry_charge(user, E)


/obj/item/arcyne_spellobject/proc/consume_entry_charge(mob/living/user, datum/spellobject_entry/E)
	E.charges--
	if(E.charges <= 0)
		if(active && E.live_spell)
			revoke_entry(user, E)
		stored_spells -= E
		user.visible_message(
			span_notice("Un hilo de luz se desenrolla desde [user]'s [name], [E.spell_name] se ha gastado."),
			span_notice("La ultima carga de [E.spell_name] se ha gastado.")
		)
		qdel(E)
		update_appearance(UPDATE_OVERLAYS)
		if(!length(stored_spells))
			if(active)
				UnregisterSignal(user, COMSIG_MOB_ABILITY_FINISHED)
				active = FALSE
			user.visible_message(
				span_warning("Las dimensiones de [user]'s [name] — todos los hechizos agotados."),
				span_warning("El [name] ahora esta vacio.")
			)
			if(spellobject_flags & SPELLOBJECT_CONSUMABLE)
				qdel(src)
	else
		to_chat(user, span_notice("[E.spell_name]: [E.charges] carga\s restante."))

/obj/item/arcyne_spellobject/proc/grant_all_spells(mob/user)
	if(active)
		return
	active = TRUE
	for(var/datum/spellobject_entry/E in stored_spells)
		grant_entry(user, E)
	RegisterSignal(user, COMSIG_MOB_ABILITY_FINISHED, PROC_REF(on_spell_fired))
	to_chat(user, span_hierophant_warning("Los [name] truenos, [length(stored_spells)] hechizos \s listos."))

/obj/item/arcyne_spellobject/proc/revoke_all_spells(mob/user)
	if(!active)
		return
	UnregisterSignal(user, COMSIG_MOB_ABILITY_FINISHED)
	for(var/datum/spellobject_entry/E in stored_spells)
		revoke_entry(user, E)
	active = FALSE

/obj/item/arcyne_spellobject/proc/grant_entry(mob/user, datum/spellobject_entry/E)
	if(E.live_spell || !E.spell_type)
		return
	E.live_spell = new E.spell_type(user)
	E.live_spell.cooldown_time = 0
	E.live_spell.spell_cost = 0
	E.live_spell.spell_flags |= SPELL_TEMPORARY
	E.live_spell.background_icon_state = "spelltemp"
	E.live_spell.base_background_icon_state = "spelltemp0"
	E.live_spell.active_background_icon_state = "spelltemp1"
	E.live_spell.Grant(user)

/obj/item/arcyne_spellobject/proc/revoke_entry(mob/user, datum/spellobject_entry/E)
	if(!E.live_spell)
		return
	E.live_spell.Remove(user)
	qdel(E.live_spell)
	E.live_spell = null

/obj/item/arcyne_spellobject/proc/on_spell_fired(mob/source, datum/action/cooldown/spell/fired)
	SIGNAL_HANDLER
	var/datum/spellobject_entry/fired_entry = null
	for(var/datum/spellobject_entry/E in stored_spells)
		if(E.live_spell == fired)
			fired_entry = E
			break
	if(!fired_entry)
		return
	consume_entry_charge(source, fired_entry)

/obj/item/arcyne_spellobject/Moved(atom/old_loc, movement_dir, forced, list/old_locs)
	. = ..()
	// If passive-grant item is no longer held by the mob that had it, revoke
	if(active && !istype(loc, /mob))
		var/mob/M = old_loc
		if(istype(M))
			revoke_all_spells(M)

/obj/item/arcyne_spellobject/proc/imbue_spell(mob/caster, datum/action/cooldown/spell/spell_type_path, spell_tier, charges = 1)
	if(length(stored_spells) >= max_spells)
		to_chat(caster, span_hierophant_warning("El [name] ya esta lleno ([max_spells] hechizos)."))
		return FALSE
	if(spell_tier < min_spell_tier || spell_tier > max_spell_tier)
		to_chat(caster, span_hierophant_warning("Este objeto no puede contener un hechizo de ese nivel."))
		return FALSE

	var/datum/action/cooldown/spell/live = null
	for(var/datum/action/cooldown/spell/S in caster.actions)
		if(S.type == spell_type_path)
			live = S
			break
	if(!live)
		to_chat(caster, span_warning("No conoces ese hechizo, no puedes guardar lo que no tienes."))
		return FALSE

	var/mana_cost = live.spell_cost * 2
	if(caster.mana_pool.amount < mana_cost)
		to_chat(caster, span_phobia("Necesitas [mana_cost] mana para impartir este hechizo (tienes [caster.mana_pool.amount])."))
		return FALSE
	caster.mana_pool.adjust_mana(-mana_cost)
	live.StartCooldown()

	var/datum/spellobject_entry/E = new()
	E.spell_type = spell_type_path
	E.spell_name = live.name
	E.charges = charges
	stored_spells += E

	update_appearance(UPDATE_OVERLAYS)
	to_chat(caster, span_hierophant_warning("Vierte [mana_cost] mana en el [name], [live.name] esta sellado dentro."))
	return TRUE

/obj/item/arcyne_spellobject/Destroy()
	if(active && istype(loc, /mob))
		revoke_all_spells(loc)
	stored_spells.Cut()
	return ..()

/obj/item/arcyne_spellobject/scroll
	name = "pergamino arcyne"
	icon = 'icons/roguetown/items/misc.dmi'
	desc = "Pergamino seco veteado con luz fria arcyne. Lo que este escrito aqui no esta destinado a durar."
	icon_state = "scroll"
	max_spells = 1
	w_class = WEIGHT_CLASS_SMALL
	spellobject_flags = SPELLOBJECT_HIJACK_CLICK | SPELLOBJECT_CONSUMABLE | SPELLOBJECT_VISUAL | SPELLOBJECT_STABLE

/obj/item/arcyne_spellobject/scroll/random
	has_random_spells = TRUE

/obj/item/arcyne_spellobject/spellstone
	name = "piedra de hechizo arcyne"
	desc = "Una piedra pulida roscada con filamentos arcyne. Mantenlo para canalizar sus hechizos."
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "quartz"
	max_spells = 3
	spellobject_flags = SPELLOBJECT_VISUAL

/obj/item/arcyne_spellobject/spellstone/random
	has_random_spells = TRUE

/obj/item/arcyne_spellobject/spellstone/lesser
	name = "piedra de hechizo arcyne menor"
	icon_state = "quartz"
	max_spells = 2
	max_spell_tier = 1

/obj/item/arcyne_spellobject/spellstone/greater
	name = "piedra de hechizo arcyne mayor"
	icon_state = "sapphire"
	max_spells = 3
	min_spell_tier = 1
	max_spell_tier = 2

/obj/item/arcyne_spellobject/spellstone/supreme
	name = "piedra de hechizo arcyne suprema"
	icon_state = "ruby"
	max_spells = 4
	min_spell_tier = 2
	max_spell_tier = 3

/obj/item/arcyne_spellobject/wand
	name = "Varita arcyne"
	desc = "Una varita delgada que crepita con magia almacenada. Apunta y haz clic para disparar."
	icon = 'icons/roguetown/items/wands.dmi'
	icon_state = "wand_lesser"
	w_class = WEIGHT_CLASS_SMALL
	spellobject_flags = SPELLOBJECT_HIJACK_CLICK
	max_spells = 1
	max_spell_tier = 1

/obj/item/arcyne_spellobject/wand/greater
	name = "varita mayor arcyne"
	icon_state = "wand_greater"
	max_spells = 2
	min_spell_tier = 1
	max_spell_tier = 2

/obj/item/arcyne_spellobject/wand/chaotic
	name = "varita caotica arcyne"
	desc = "Una varita deformada que burbujea con magia salvaje. Hay algo dentro pero ¿que?"
	spellobject_flags = SPELLOBJECT_HIJACK_CLICK | SPELLOBJECT_CHAOTIC
	max_spells = 1
	max_spell_tier = 2

/obj/item/arcyne_spellobject/wand/chaotic/random
	name = "varita caotica arcyne"
	desc = "Una varita deformada que burbujea con magia salvaje. Hay algo dentro pero ¿que?"
	has_random_spells = TRUE

/obj/item/arcyne_spellobject/proc/generate_random_spells()
	var/datum/action/cooldown/spell/spell_type_path = pick(subtypesof(/datum/action/cooldown/spell))
	while(IS_ABSTRACT(spell_type_path) || initial(spell_type_path.spell_tier) < min_spell_tier || initial(spell_type_path.spell_tier) > max_spell_tier || (initial(spell_type_path.spell_flags) & SPELL_UNETCHABLE) || (initial(spell_type_path.spell_flags) & SPELL_ESSENCE))
		spell_type_path = pick(subtypesof(/datum/action/cooldown/spell))

	var/datum/spellobject_entry/E = new()
	E.spell_type = spell_type_path
	E.spell_name = initial(spell_type_path.name)
	E.charges = rand(1, 3)
	stored_spells += E
	update_appearance(UPDATE_OVERLAYS)
