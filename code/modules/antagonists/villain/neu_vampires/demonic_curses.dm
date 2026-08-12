//////////////////////
/// DEMONIC FAMILY CURSES ///
//////////////////////

/datum/family_curse/demonic
	curse_type = "demonic"
	inherited = TRUE
	blessing = FALSE

/datum/family_curse/demonic/torment
	name = "Maldición del tormento"
	description = "The family bloodline burns with infernal agony. Every moment is suffering."
	severity = 2
	curse_effects = list(/datum/status_effect/demonic_torment)

/datum/family_curse/demonic/despair
	name = "Maldición de la desesperación"
	description = "All hope has left this bloodline. They see only darkness and futility in everything."
	severity = 2
	curse_effects = list(/datum/status_effect/demonic_despair)

/datum/family_curse/demonic/wrath
	name = "Maldición de ira"
	description = "Uncontrollable fury consumes this family. They lash out at friend and foe alike."
	severity = 3
	curse_effects = list(/datum/status_effect/demonic_wrath)

/datum/family_curse/demonic/paranoia
	name = "La maldición de la paranoia"
	description = "This family sees enemies everywhere. They believe all plot against them in shadows and whispers."
	severity = 2
	curse_effects = list(/datum/status_effect/demonic_paranoia)

/datum/family_curse/demonic/damnation
	name = "Curse of Damnation"
	description = "This bloodline's souls are marked for Hell. Holy ground burns their feet, and sacred symbols cause them pain."
	severity = 3
	curse_effects = list(/datum/status_effect/demonic_damnation)

/datum/family_curse/demonic/gluttony
	name = "La maldición de la gula"
	description = "Un hambre insaciable corroe a esta familia. Deben consumir todo lo que puedan conseguir."
	severity = 1
	curse_effects = list(/datum/status_effect/demonic_gluttony)

/datum/family_curse/demonic/pride
	name = "Maldición del orgullo"
	description = "This family believes they are superior to all others. They cannot bring themselves to accept help or admit weakness."
	severity = 2
	curse_effects = list(/datum/status_effect/demonic_pride)

/datum/family_curse/demonic/isolation
	name = "La maldición del aislamiento"
	description = "This bloodline is utterly alone. Others flee from their presence as if they carry plague."
	severity = 3
	curse_effects = list(/datum/status_effect/demonic_isolation)

/datum/family_curse/demonic/madness
	name = "Maldición de la locura"
	description = "Insanity runs through this family's blood. Reality becomes twisted and uncertain for them."
	severity = 3
	curse_effects = list(/datum/status_effect/demonic_madness)

/datum/family_curse/demonic/decay
	name = "Maldición de la decadencia"
	description = "This family rots from within. Their flesh slowly corrupts and their health deteriorates."
	severity = 2
	curse_effects = list(/datum/status_effect/demonic_decay)

//////////////////////
/// STATUS EFFECTS ///
//////////////////////

/datum/status_effect/demonic_torment
	id = "demonic_torment"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_torment
	COOLDOWN_DECLARE(next_torment)

/datum/status_effect/demonic_torment/on_apply()
	. = ..()
	owner.add_stress(/datum/stress_event/infernal_pain)

/datum/status_effect/demonic_torment/on_remove()
	. = ..()
	owner?.remove_stress(/datum/stress_event/infernal_pain)

/datum/status_effect/demonic_torment/tick()
	if(COOLDOWN_FINISHED(src, next_torment) && prob(5))
		COOLDOWN_START(src, next_torment, rand(10 SECONDS, 30 SECONDS))
		var/effect = rand(1, 3)
		switch(effect)
			if(1)
				owner.apply_damage(rand(2, 5), BURN, null, 0, null, FALSE)
				to_chat(owner, span_userdanger("Infernal flames sear your cursed flesh!"))
				owner.add_stress(/datum/stress_event/infernal_pain)
			if(2)
				owner.emote("scream", forced = TRUE)
				to_chat(owner, span_userdanger("¡La maldición familiar te atormenta!"))
			if(3)
				owner.Knockdown(10)
				to_chat(owner, span_userdanger("¡La agonía de tu linaje te abruma!"))

/datum/status_effect/demonic_despair
	id = "demonic_despair"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_despair
	effectedstats = list(STAT_CONSTITUTION = -1)
	COOLDOWN_DECLARE(next_despair)

/datum/status_effect/demonic_despair/tick()
	if(COOLDOWN_FINISHED(src, next_despair) && prob(3))
		COOLDOWN_START(src, next_despair, rand(20 SECONDS, 1 MINUTES))
		var/list/despair_messages = list(
			"La maldición familiar pesa mucho sobre mí...",
			"Why was I born into this cursed bloodline?",
			"There's no escape from our family's fate.",
			"Todos estamos condenados por los pecados de nuestros antepasados.",
			"Nothing can lift this hereditary burden.",
			"Death would be a mercy from this curse."
		)
		owner.say(pick(despair_messages), forced = "maldición familiar")
		owner.add_stress(/datum/stress_event/cursed_despair)

/datum/status_effect/demonic_wrath
	id = "demonic_wrath"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_wrath
	effectedstats = list(STAT_STRENGTH = 1, STAT_INTELLIGENCE = -1)
	COOLDOWN_DECLARE(next_wrath)

/datum/status_effect/demonic_wrath/tick()
	if(COOLDOWN_FINISHED(src, next_wrath) && prob(4))
		COOLDOWN_START(src, next_wrath, rand(15 SECONDS, 40 SECONDS))
		var/found_target = FALSE
		for(var/mob/living/carbon/human/victim in view(2, owner))
			if(victim == owner)
				continue
			owner.emote("rage", forced = TRUE)
			to_chat(owner, span_userdanger("The family curse fills you with rage!"))
			if(owner.get_active_held_item())
				victim.attacked_by(owner.get_active_held_item(), owner)
			else
				victim.attacked_by(owner, owner)
			found_target = TRUE
			break

		if(!found_target && prob(40))
			owner.apply_damage(rand(3, 6), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
			to_chat(owner, span_userdanger("In my cursed rage, I hurt myself!"))
			owner.add_stress(/datum/stress_event/cursed_wrath)

/datum/status_effect/demonic_paranoia
	id = "demonic_paranoia"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_paranoia
	effectedstats = list(STAT_PERCEPTION = 1, STAT_SPEED = -1)
	COOLDOWN_DECLARE(next_paranoia)

/datum/status_effect/demonic_paranoia/tick()
	if(COOLDOWN_FINISHED(src, next_paranoia) && prob(3))
		COOLDOWN_START(src, next_paranoia, rand(30 SECONDS, 80 SECONDS))
		var/list/paranoid_messages = list(
			"They know about our family's curse...",
			"Everyone suspects what we really are.",
			"They're watching our bloodline closely.",
			"Our cursed heritage makes us targets.",
			"No puedo confiar en nadie fuera de la familia.",
			"They plot against our cursed kind."
		)
		owner.say(pick(paranoid_messages), forced = "maldición familiar")
		owner.add_stress(/datum/stress_event/cursed_paranoia)

/datum/status_effect/demonic_damnation
	id = "demonic_damnation"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_damnation
	effectedstats = list(STAT_CONSTITUTION = -1)

/datum/status_effect/demonic_damnation/tick()
	if(prob(2))
		to_chat(owner, span_userdanger("¡Sientes el peso de la condenación de tu familia!"))
		owner.add_stress(/datum/stress_event/cursed_damnation)

/datum/status_effect/demonic_gluttony
	id = "demonic_gluttony"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_gluttony
	COOLDOWN_DECLARE(next_hunger)

/datum/status_effect/demonic_gluttony/tick()
	if(COOLDOWN_FINISHED(src, next_hunger) && prob(4))
		COOLDOWN_START(src, next_hunger, rand(20 SECONDS, 50 SECONDS))
		var/list/nearby_food = list()
		for(var/obj/item/reagent_containers/food/F in view(1, owner))
			nearby_food += F
		for(var/obj/item/reagent_containers/R in view(1, owner))
			if(R.reagents && R.reagents.total_volume > 0)
				nearby_food += R

		if(nearby_food.len)
			var/obj/item/target_food = pick(nearby_food)
			if(owner.put_in_active_hand(target_food))
				to_chat(owner, span_userdanger("¡La maldición familiar me obliga a consumir esto!"))
				target_food.attack(owner, owner)
		else
			if(!owner.has_stress_type(/datum/stress_event/cursed_hunger))
				to_chat(owner, span_userdanger("I hunger for anything to satisfy this cursed bloodline!"))
			owner.add_stress(/datum/stress_event/cursed_hunger)

/datum/status_effect/demonic_pride
	id = "demonic_pride"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_pride
	effectedstats = list(STAT_CONSTITUTION = 1)
	COOLDOWN_DECLARE(next_pride)

/datum/status_effect/demonic_pride/tick()
	if(COOLDOWN_FINISHED(src, next_pride) && prob(3))
		COOLDOWN_START(src, next_pride, rand(40 SECONDS, 80 SECONDS))
		var/list/pride_messages = list(
			"Our bloodline is superior, curse and all.",
			"No necesitamos ayuda de familias menores.",
			"Esta maldición nos hace más fuertes que ellos.",
			"Nuestra herencia nos sitúa por encima de la gente común.",
			"No mostraré debilidad, a pesar de la maldición.",
			"Llevamos esta carga porque somos elegidos."
		)
		owner.say(pick(pride_messages), forced = "maldición familiar")

/datum/status_effect/demonic_isolation
	id = "demonic_isolation"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_isolation
	effectedstats = list(STAT_SPEED = -2)
	COOLDOWN_DECLARE(next_isolation)

/datum/status_effect/demonic_isolation/tick()
	if(COOLDOWN_FINISHED(src, next_isolation) && prob(4))
		COOLDOWN_START(src, next_isolation, rand(30 SECONDS, 70 SECONDS))
		var/found_people = FALSE
		for(var/mob/living/carbon/human/victim in view(1, owner))
			if(victim == owner)
				continue
			var/turf/away_turf = get_step_away(victim, owner)
			if(away_turf)
				victim.throw_at(away_turf, 1, 1)
				to_chat(victim, span_warning("Something about [owner]'s cursed presence repels you!"))
			found_people = TRUE

		if(prob(25))
			var/list/lonely_messages = list(
				"Our cursed bloodline dooms us to solitude...",
				"The family curse drives everyone away.",
				"Estamos destinados a estar solos por lo que somos.",
				"No one can stand to be near our cursed kind."
			)
			owner.say(pick(lonely_messages), forced = "maldición familiar")
			if(!found_people)
				owner.add_stress(/datum/stress_event/cursed_isolation)

/datum/status_effect/demonic_madness
	id = "demonic_madness"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_madness
	effectedstats = list(STAT_INTELLIGENCE = -2, STAT_PERCEPTION = 1)
	COOLDOWN_DECLARE(next_madness)

/datum/status_effect/demonic_madness/tick()
	if(COOLDOWN_FINISHED(src, next_madness) && prob(3))
		COOLDOWN_START(src, next_madness, rand(20 SECONDS, 1 MINUTES))
		var/list/mad_messages = list(
			"Las voces en nuestra sangre me hablan...",
			"I see the demons that cursed our ancestors!",
			"Reality bends around our tainted heritage.",
			"¡La maldición me muestra cosas que otros no pueden ver!",
			"¡Nuestro linaje lleva susurros del infierno!",
			"¡La maldición familiar revela verdades ocultas!"
		)
		owner.say(pick(mad_messages), forced = "maldición familiar")

/datum/status_effect/demonic_decay
	id = "demonic_decay"
	duration = -1
	alert_type = /atom/movable/screen/alert/status_effect/family_curse/demonic_decay
	effectedstats = list(STAT_CONSTITUTION = -2)
	COOLDOWN_DECLARE(next_decay)

/datum/status_effect/demonic_decay/tick()
	if(COOLDOWN_FINISHED(src, next_decay) && prob(3))
		var/cooldown_time = rand(40 SECONDS, 90 SECONDS)
		var/effect = rand(1, 4)
		switch(effect)
			if(1)
				if(iscarbon(owner))
					var/mob/living/carbon/C = owner
					C.vomit()
				to_chat(owner, span_userdanger("¡La maldición familiar enferma tu cuerpo!"))
			if(2)
				owner.Unconscious(15)
				to_chat(owner, span_userdanger("¡Tu herencia maldita te debilita!"))
			if(3)
				owner.set_eye_blur_if_lower(16 SECONDS)
				to_chat(owner, span_userdanger("¡La maldición nubla tu visión!"))
			if(4)
				if(ishuman(owner))
					var/mob/living/carbon/human/H = owner
					var/obj/item/bodypart/BP = pick(H.bodyparts)
					BP.adjust_germ_level(50)
					H.regenerate_icons()
				cooldown_time = 8 MINUTES
				to_chat(owner, span_userdanger("Your cursed flesh begins to decay!"))
		COOLDOWN_START(src, next_decay, cooldown_time)

//////////////////////
/// ALERT SCREENS ///
//////////////////////

/atom/movable/screen/alert/status_effect/family_curse/demonic_torment
	name = "Maldición del tormento"
	desc = "Infernal flames burn within your cursed bloodline."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_despair
	name = "Maldición de la desesperación"
	desc = "All hope has abandoned your family line."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_wrath
	name = "Maldición de ira"
	desc = "Uncontrollable rage flows through your veins."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_paranoia
	name = "La maldición de la paranoia"
	desc = "Todos conspiran contra tu herencia maldita."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_damnation
	name = "Curse of Damnation"
	desc = "Las almas de tu familia están marcadas para el infierno."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_gluttony
	name = "La maldición de la gula"
	desc = "Insatiable hunger gnaws at your cursed bloodline."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_pride
	name = "Maldición del orgullo"
	desc = "Tu familia se cree superior a todos los demás."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_isolation
	name = "La maldición del aislamiento"
	desc = "Otros huyen de tu maldita presencia."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_madness
	name = "Maldición de la locura"
	desc = "La locura corre por la sangre de tu familia."
	icon_state = "debuff"

/atom/movable/screen/alert/status_effect/family_curse/demonic_decay
	name = "Maldición de la decadencia"
	desc = "Tu carne se pudre desde dentro debido a la maldición familiar."
	icon_state = "debuff"

//////////////////////
/// STRESS EVENTS ///
//////////////////////

/datum/stress_event/infernal_pain
	timer = 30 SECONDS
	stress_change = 3
	desc = "Infernal flames burn my cursed flesh!"

/datum/stress_event/cursed_despair
	timer = 60 SECONDS
	stress_change = 4
	desc = "La maldición familiar me llena de desesperanza."

/datum/stress_event/cursed_wrath
	timer = 45 SECONDS
	stress_change = 2
	desc = "My cursed rage turned inward."

/datum/stress_event/cursed_paranoia
	timer = 90 SECONDS
	stress_change = 3
	desc = "Everyone knows about our cursed bloodline."

/datum/stress_event/cursed_damnation
	timer = 120 SECONDS
	stress_change = 5
	desc = "Siento el peso de la condenación de mi familia."

/datum/stress_event/cursed_hunger
	timer = 60 SECONDS
	stress_change = 2
	desc = "¡La maldición me obliga a consumir, pero no puedo!"

/datum/stress_event/cursed_isolation
	timer = 90 SECONDS
	stress_change = 4
	desc = "Nuestra herencia maldita nos deja completamente solos."
