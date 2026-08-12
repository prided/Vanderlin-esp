/datum/action/cooldown/spell/enslave_mortal
	name = "Enslave Mortal"
	desc = "Dominate a mortal's will through dark vampiric power, making them a slave to your clan."
	button_icon_state = "curse"
	has_visual_effects = FALSE
	cast_range = 1
	charge_time = 2 SECONDS
	spell_cost = 0
	cooldown_time = 3 MINUTES
	var/enslavement_time = 30 SECONDS
	var/blood_cost = 50

/datum/action/cooldown/spell/enslave_mortal/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return

	if(!ishuman(owner))
		if(feedback)
			to_chat(owner, span_warning("Solo los vampiros pueden esclavizar a los mortales."))
		return FALSE

	var/mob/living/carbon/human/vampire = owner

	// Check if they have enough blood
	if(!get_available_blood(vampire, blood_cost))
		if(feedback)
			to_chat(owner, span_warning("You need at least [blood_cost] blood to perform this ritual."))
		return FALSE

	if(!vampire.clan)
		if(feedback)
			to_chat(owner, span_warning("Debes pertenecer a un clan para esclavizar a otros."))
		return FALSE

/datum/action/cooldown/spell/enslave_mortal/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE

	if(!ishuman(cast_on))
		return FALSE

	var/mob/living/carbon/human/target = cast_on

	if(target == owner)
		return FALSE

	if(target.stat == DEAD)
		return FALSE

	// Can't enslave someone who already belongs to a clan
	if(target.clan)
		return FALSE

	return TRUE

/datum/action/cooldown/spell/enslave_mortal/before_cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	if(cast_on.stat == DEAD)
		to_chat(owner, span_warning("[cast_on] está muerto y no puede ser esclavizado."))
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

	if(cast_on.clan)
		to_chat(owner, span_warning("[cast_on] ya pertenece a otro."))
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/enslave_mortal/cast(mob/living/carbon/human/cast_on)
	. = ..()
	var/mob/living/carbon/human/vampire = owner

	to_chat(vampire, span_warning("You begin weaving dark magic around [cast_on.name]'s mind..."))
	to_chat(cast_on, span_userdanger("¡Sientes una abrumadora presencia vampírica invadiendo tus pensamientos!"))

	vampire.visible_message(
		span_warning("[vampire] extends their hand toward [cast_on], dark energy swirling around them both."),
		span_boldwarning("You channel your vampiric power into [cast_on]'s mind..."),
		span_hear("You hear an ominous whisper in an ancient tongue.")
	)

	create_enslavement_effects(vampire, cast_on)

	if(!do_after(vampire, enslavement_time, cast_on, IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE))
		to_chat(vampire, span_warning("The enslavement ritual was interrupted!"))
		to_chat(cast_on, span_notice("La opresiva presencia mental se desvanece de repente."))
		reset_spell_cooldown()
		return

	if(!validate_enslavement_target(cast_on))
		reset_spell_cooldown()
		return

	use_available_blood(owner, blood_cost)
	to_chat(vampire, span_warning("Te sientes significativamente debilitado mientras tu sangre alimenta el ritual oscuro."))

	complete_enslavement_ritual(vampire, cast_on)

/datum/action/cooldown/spell/enslave_mortal/proc/validate_enslavement_target(mob/living/carbon/human/target)
	if(!target)
		to_chat(owner, span_warning("¡Tu objetivo ha desaparecido!"))
		return FALSE

	if(target.stat == DEAD)
		to_chat(owner, span_warning("¡Tu objetivo ha muerto durante el ritual!"))
		return FALSE

	if(get_dist(owner, target) > cast_range)
		to_chat(owner, span_warning("¡Tu objetivo se alejó demasiado durante el ritual!"))
		return FALSE

	if(target.clan)
		to_chat(owner, span_warning("¡Tu objetivo se unió a un clan durante el ritual!"))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/enslave_mortal/proc/complete_enslavement_ritual(mob/living/carbon/human/vampire, mob/living/carbon/human/target)
	target.make_vampire_slave(vampire)

	playsound(vampire, 'sound/magic/ethereal_exit.ogg', 75, TRUE)
	playsound(target, 'sound/magic/ethereal_exit.ogg', 75, TRUE)

	vampire.visible_message(
		span_boldwarning("Dark energy erupts around [vampire] and [target] as the ritual completes! [target] staggers as their will is broken!"),
		span_boldwarning("The ritual is complete. [target.name]'s mind belongs to you and your clan now."),
		span_hear("You hear a sound like chains binding a soul, followed by a defeated whimper.")
	)

	to_chat(vampire, span_boldnotice("You have enslaved [target.name] to serve your clan. Their will is now bound to yours."))
	to_chat(target, span_userdanger("Your mind shatters under the vampiric assault! You are now enslaved to [vampire.name] and must serve their clan!"))

/datum/action/cooldown/spell/enslave_mortal/proc/create_enslavement_effects(mob/living/carbon/human/vampire, mob/living/carbon/human/target)
	make_tracker_effects(vampire.loc, vampire, 1, "soul", 3, /obj/effect/tracker/drain, 3)
