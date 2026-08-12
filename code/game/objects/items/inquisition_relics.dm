
/obj/structure/closet/crate/chest/inqreliquary
	name = "relicario oratorium"
	desc = "Un cofre rojo premonitorio con un intrincado diseño de cerradura. Parece que solo encaja en una clave muy especifica. Elige sabiamente."
	icon_state = "chestweird1"
	base_icon_state = "chestweird1"

/obj/structure/closet/crate/chest/inqcrate
	name = "Cofre oratorium"
	desc = "Un cofre rojo premonitorio con adornos plateados lavados con tinte negro."
	icon_state = "chestweird2"
	base_icon_state = "chestweird2"

// Reliquary Box and key - The Box Which contains these
/obj/structure/reliquarybox
	name = "relicario oratorium"
	desc = "Un cofre rojo premonitorio con un intrincado diseño de cerradura. Parece que solo encaja en una clave muy especifica. Elige sabiamente."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "chestweird1"
	anchored = TRUE
	density = TRUE
	var/opened = FALSE

/obj/item/key/psydonkey
	icon_state = "birdkey"
	name = "Llave del relicario"
	desc = "La llave de un solo uso con la que desatar el dolor. Elige sabiamente."

/obj/structure/reliquarybox/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/key/psydonkey))
		return NONE

	if(opened)
		to_chat(user, span_info("La caja del relicario ya ha sido abierta..."))
		return ITEM_INTERACT_BLOCKING

	qdel(tool)
	to_chat(user, span_info("La cerradura del relicario toma mi llave al abrirse, me tomo un momento para reflexionar sobre que poder nos fue entregado..."))
	playsound(src, 'sound/foley/doors/woodlock.ogg', 60)
	to_chat(user,)
	var/relics = list("Melancholic Crankbox - Antimagic", "Daybreak - Silver Whip", "Sanctum - Silver Halberd", "Crusade - Silver Greatsword", "Censer of Penitence")
	var/relicchoice = tgui_input_list(user, "Elige tu herramienta", "RELICS", relics)
	var/obj/choice
	switch(relicchoice)
		if("Melancholic Crankbox - Antimagic")
			choice = /obj/item/psydonmusicbox
		if("Daybreak - Silver Whip")
			choice = /obj/item/weapon/whip/psydon/relic
		if("Sanctum - Silver Halberd")
			choice = /obj/item/weapon/polearm/halberd/psydon/relic
			user.clamped_adjust_skill_level(/datum/attribute/skill/combat/polearms, 40, 40, TRUE)	//We make sure the weapon is usable by the Inquisitor.
		if("Crusade - Silver Greatsword")
			choice = /obj/item/weapon/sword/long/greatsword/psydon
			user.clamped_adjust_skill_level(/datum/attribute/skill/combat/swords, 40, 40, TRUE)		//Ditto.
		if("Censer of Penitence")
			choice = /obj/item/flashlight/flare/torch/lantern/psycenser
	to_chat(user, span_info("He elegido la reliquia, que EL guie mi mano."))
	var/obj/structure/closet/crate/chest/inqreliquary/realchest = new /obj/structure/closet/crate/chest/inqreliquary(get_turf(src))
	realchest.populate_contents()
	choice = new choice(realchest)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

// Soul Churner - Music box which applies magic resistance to Inquisition members, greatly mood debuffs everyone not a Psydon worshipper.
/obj/item/psydonmusicbox
	name = "manivela melancolica"
	desc = ""
	icon_state = "psydonmusicbox"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_HUGE
	var/cranking = FALSE
	force = 15
	max_integrity = 100
	attacked_sound = 'sound/combat/hits/onwood/education2.ogg'
	gripped_intents = list(/datum/intent/hit)
	possible_item_intents = list(/datum/intent/hit)
	obj_flags = CAN_BE_HIT
	bigboy = TRUE
	item_weight = 4 KILOGRAMS
	var/datum/looping_sound/psydonmusicboxsound/soundloop

/obj/item/psydonmusicbox/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_INQUISITION))
		desc = "Una reliquia de las entrañas de los talleres taumaturgicos del Oratorium. Catorce almas de herejes, todas unidas, gritaran y nos protegeran de la magia. Seria prudente no enseñar a los herejes su verdadera naturaleza, y solo utilizarla en circunstancias extremas."
	else
		desc = "Una caja de musica con manivela, tiene el sello del Oratorium Throni Vacui en el lateral. Lleva una sensacion sombria..."

/obj/item/psydonmusicbox/attack_self(mob/living/user)
	. = ..()
	if(!HAS_TRAIT(user, TRAIT_INQUISITION))
		user.add_stress(/datum/stress_event/soulchurnerhorror)
		to_chat(user, (span_cultsmall("SIENTO SUFRIR CON CADA GIRAR, ¿QUE ESTA PASANDO CONMIGO?!")))
	cranking = !cranking
	update_appearance(UPDATE_ICON_STATE)
	if(cranking)
		user.apply_status_effect(/datum/status_effect/buff/cranking_soulchurner)
		soundloop.start()
		var/songhearers = view(7, user)
		for(var/mob/living/carbon/human/fixation in songhearers)
			to_chat(fixation,span_cultsmall("[user] comienza a hacer girar el molino de almas..."))
	if(!cranking)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/cranking_soulchurner)

/obj/item/psydonmusicbox/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/item/psydonmusicbox/Destroy()
	if(soundloop)
		QDEL_NULL(soundloop)
	return ..()

/obj/item/psydonmusicbox/update_icon_state()
	. = ..()
	if(cranking)
		icon_state = "psydonmusicbox_active"
	else
		icon_state = "psydonmusicbox"

/obj/item/psydonmusicbox/dropped(mob/living/user, silent)
	. = ..()
	cranking = FALSE
	update_appearance(UPDATE_ICON_STATE)
	if(soundloop)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/cranking_soulchurner)

/obj/item/psydonmusicbox/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 0,"nx" = 11,"ny" = 1,"wx" = 0,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = 0,"wturn" = 0,"eturn" = 39,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8)

/// Called by burial_rites, gives some fluff messages before deleting the box.
/obj/item/psydonmusicbox/proc/free_souls(mob/living/savior)
	var/list/soul_lines = list(
		SPAN_GOD_ASTRATA("Su luz una vez mas... gracias..."),
		SPAN_GOD_ASTRATA("Calor por fin..."),
		SPAN_GOD_NOC("Puedo verlas... las estrellas..."),
		SPAN_GOD_NECRA("Finalmente... paz..."),
		SPAN_GOD_NECRA("Has hecho un noble servicio, pariente..."),
		SPAN_GOD_NECRA("Me asegurare de informar a la Submaja de su servicio..."),
		SPAN_GOD_ABYSSOR("Que el mar te trate bien..."),
		SPAN_GOD_RAVOX("¡Libertad por fin! Que se haga justicia por lo que he sufrido..."),
		SPAN_GOD_PESTRA("El sufrimiento ha terminado..."),
		SPAN_GOD_EORA("¡Paz por fin! Que encuentres amor, extraño..."),
		SPAN_GOD_DENDOR("¡ESOS GRENZEL ESCIENTES PAGARAN POR LO QUE HICIERON!"),
		SPAN_GOD_XYLIX("¡Finalmente! A esa audiencia le estaba saliendo el aburrimiento de todas maneras..."),
		SPAN_GOD_MALUM("¡He sido liberado! Debo encontrar a mi aprendiz..."),
		SPAN_GOD_MALUM("Que Malum maldiga al creador de esa artesania maldita... gracias..."),
		SPAN_GOD_MATTHIOS("Gracias amigo, te debo una..."),
		SPAN_GOD_ZIZO("Gracias IDIOTA! Es hora de causar algo de caos ~"),
		SPAN_GOD_GRAGGAR("¡Voy a desgarrar a esos Grenzels miembro por miembro!"),
		SPAN_GOD_BAOTHA("¡Que experiencia tan horrible... Necesito una bebida..."),
		SPAN_GOD_PSYDON("No esperes agradecimiento de mi, sirviente del traidor...")
	)

	savior.visible_message(span_info("A medida que \the [src] se desmorona en polvo, puedes ver unas cuantas luces tenues flotando y desvaneciendose."), span_info("Mientras \the [src] se desmorona, puedes ver vagamente catorce almas que se alejan lentamente y se desvanecen en el aire. Una de ellas pronuncia algunas palabras antes de unirse al resto..."), vision_distance = COMBAT_MESSAGE_RANGE)

	sleep(1 SECONDS)
	to_chat(savior, pick(soul_lines))

	savior.add_stress(/datum/stress_event/soulchurnerdestroyed)
	qdel(src)


/atom/movable/screen/alert/status_effect/buff/cranking_soulchurner
	name = "Agitador de almas en marcha"
	desc = "Le estoy dando vida al dispositivo retorcido..."
	icon_state = "buff"

/datum/status_effect/buff/cranking_soulchurner
	id = "crankchurner"
	alert_type = /atom/movable/screen/alert/status_effect/buff/cranking_soulchurner
	var/effect_color
	var/pulse = 0
	var/ticks_to_apply = 10

	var/list/patron_lines = list(
		/datum/patron/divine/astrata = list("'HER LIGHT HAS LEFT ME! WHERE AM I?!'", "'SHATTER THIS CONTRAPTION, SO I MAY FEEL HER WARMTH ONE LAST TIME!'", "'I am royal.. Why did they do this to me...?'"),
		/datum/patron/divine/noc = list("'Colder than moonlight...'", "'No wisdom can reach me here...'", "'Please help me, I miss the stars...'"),
		/datum/patron/divine/necra = list("'They snatched me from her grasp, for eternal torment...'", "'Necra! Please! I am so tired! Release me!'", "'I am lost, lost in a sea of stolen ends.'"),
		/datum/patron/divine/abyssor = list("'I cannot feel the coast's breeze...'", "'We churn tighter here than schooling fish...'", "'Free me, please, so I may return to the sea...'"),
		/datum/patron/divine/ravox = list("'Ravoxian kin! Tear this Grenzelhoftian dog's head off! Free me from this damnable witchery!'", "'There is no justice nor glory to be found here, just endless fatigue...'", "'I begged for a death by the sword...'"),
		/datum/patron/divine/pestra = list("'I only wanted to perfect my cures...'", "'A thousand plagues upon the holder of this accursed machine! Pestra! Can you not hear me?!'", "'I can feel their suffering as they brush against me...'"),
		/datum/patron/divine/eora  =list("'Every caress feels like a thousand splintering bones...'", "'She was a heretic, but how could I hurt her?!'", "'I'm sorry! I only wanted peace! Please release me!'"),
		/datum/patron/divine/dendor =list("'HIS MADNESS CALLS FOR ME! RRGHNN...'", "'SHATTER THIS BOX, SO WE MAY CHOKE THIS GRENZEL ON DIRT AND ROOTS!'", "'I miss His voice in the leaves... Free me, please...'"),
		/datum/patron/divine/xylix  =list("'ONE, TWO, THREE, FOUR- TWO, TWO, THREE, FOUR. --What do you mean, annoying?'", "'There are thirteen others in here, you know! What a good audience- they literally can't get out of their seats!'", "'Of course I went all-in! I thought he had an ace-high!'", "'No, the XYLIX'S FORTUNE was right- this definitely is quite bad.'"),
		/datum/patron/divine/malum =list("'The structure of this cursed machine is malleable.. Shatter it, please...'", "'My craft could've changed the world...'", "'Free me, so I may return to my apprentice, please...'"),
		/datum/patron/inhumen/matthios  =list("'My final transaction... He will never receive my value... Stolen away by these monsters...'", "'Comrade, I have been shackled into this HORRIFIC CONTRAPTION, FREE ME!'", "'I feel our shackles twist with eachother's...'"),
		/datum/patron/inhumen/zizo = list("'ZIZO! MY MAGICKS FAIL ME! STRIKE DOWN THESE PSYDONIAN DOGS!'", "'CABALIST? There is TWISTED MAGICK HERE, BEWARE THE MUSIC! OUR VOICES ARE FORCED!'", "'DESTROY THE BOX, KILL THE WIELDER. YOUR MAGICKS WILL BE FREE.'"),
		/datum/patron/inhumen/graggar =list("'ANOINTED! TEAR THIS GRENZELHOFTIAN'S HEAD OFF!'", "'ANOINTED! SHATTER THE BOX, AND WE WILL KILL THEM TOGETHER!'", "'GRAGGAR, GIVE ME STRENGTH TO BREAK MY BONDS!'"),
		/datum/patron/inhumen/baotha =list("'I miss the warmth of ozium... There is no feeling in here for me...'", "'Debauched one, rescue me from this contraption, I have such things to share with you.'", "'MY PERFECTION WAS TAKEN FROM ME BY THESE PSYDONIAN MONSTERS!'"),
		/datum/patron/psydon = list("'FREE US! FREE US! WE HAVE SUFFERED ENOUGH!'", "'PLEASE, RELEASE US!", "WE MISS OUR FAMILIES!'", "'WHEN WE ESCAPE, WE ARE GOING TO CHASE YOU INTO YOUR GRAVE.'"),
		/datum/patron/psydon/extremist = list("'FREE US! FREE US! WE HAVE SUFFERED ENOUGH!'", "'PLEASE, RELEASE US!", "WE MISS OUR FAMILIES!'", "'WHEN WE ESCAPE, WE ARE GOING TO CHASE YOU INTO YOUR GRAVE.'"), // i hate having to duplicate this
	)


/datum/status_effect/buff/cranking_soulchurner/on_creation(mob/living/new_owner, stress, colour)
	effect_color = "#800000"
	return ..()

/datum/status_effect/buff/cranking_soulchurner/tick()
	var/obj/effect/temp_visual/music_rogue/M = new /obj/effect/temp_visual/music_rogue(get_turf(owner))
	M.color = "#800000"
	pulse += 1
	if (pulse >= ticks_to_apply)
		pulse = 0
		if(!HAS_TRAIT(owner, TRAIT_INQUISITION))
			owner.add_stress(/datum/stress_event/soulchurnerhorror)
		for (var/mob/living/carbon/human/H in hearers(7, owner))
			if (!H.client || !H.patron)
				continue
			if (!H.has_stress_type(/datum/stress_event/soulchurner))
				var/list/lines = patron_lines[H.patron.type]
				if(lines)
					if(istype(H.patron, /datum/patron/psydon))
						H.add_stress(/datum/stress_event/soulchurnerpsydon)
						if(HAS_TRAIT(H, TRAIT_INQUISITION))
							H.apply_status_effect(/datum/status_effect/buff/churnerprotection)
					else
						H.add_stress(/datum/stress_event/soulchurner)
						if(!H.has_status_effect(/datum/status_effect/buff/churnernegative))
							H.apply_status_effect(/datum/status_effect/buff/churnernegative)
					to_chat(H, (span_hypnophrase("Una voz te llama desde la cancion...")))
					to_chat(H, (span_cultsmall(pick(lines))))

/atom/movable/screen/alert/status_effect/buff/censerbuff
	name = "Inspirado en Psydon."
	desc = "La bendicion persistente de Psydon me dice que AGUARE."
	icon_state = "censerbuff"

/datum/status_effect/buff/censerbuff
	id = "censer"
	alert_type = /atom/movable/screen/alert/status_effect/buff/censerbuff
	duration = 15 MINUTES
	effectedstats = list(STAT_ENDURANCE = 1, STAT_CONSTITUTION = 1)

/datum/stress_event/syoncalamity
	stress_change = 15
	desc = span_boldred("¡Otra parte mas de Psydon perdida!")
	timer = 15 MINUTES

/datum/intent/flail/strike/smash/golgotha
	hitsound = list('sound/items/beartrap2.ogg')

/obj/effect/temp_visual/censer_dust
	icon = 'icons/effects/effects.dmi'
	icon_state = "extinguish"
	duration = 8

/datum/intent/bless
	name = "bendecir"
	icon_state = "inbless"
	no_attack = TRUE
	candodge = TRUE
	canparry = TRUE

/datum/intent/weep
	name = "llorar"
	icon_state = "inweep"
	no_attack = TRUE
	candodge = FALSE
	canparry = FALSE

/datum/intent/flail/strike/smash/golgotha
	hitsound = list('sound/items/beartrap2.ogg')

/obj/item/flashlight/flare/torch/lantern/psycenser
	name = "Cencerro de Penitencia"
	desc = "Un dispositivo lleno de plata burbujeante. Su estado inestable es peligroso para quienes no conocen su verdadera naturaleza, pero manejarlo es un gran honor para Psydon."
	icon = 'icons/roguetown/weapons/32/psydonite.dmi'
	icon_state = "psycenser"
	item_state = "psycenser"
	light_outer_range = 8
	light_color ="#70d1e2"
	possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha)
	fuel = 999 MINUTES
	force = 30
	item_weight = 800 GRAMS
	var/next_smoke
	var/smoke_interval = 2 SECONDS

/obj/item/flashlight/flare/torch/lantern/psycenser/examine(mob/user)
	. = ..()
	if(fuel > 0)
		. += span_info("Si se abre, puede bendecir las Psydon armas y las de Psydon fe.")
		. += span_warning("Si lo usas para aplastar a una criatura, crearas una explosion devastadora y la volveras inutilizable.")
	if(fuel <= 0)
		. += span_info("Se ha ido.")

/obj/item/flashlight/flare/torch/lantern/psycenser/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -2,"sy" = -4,"nx" = 9,"ny" = -4,"wx" = -3,"wy" = -4,"ex" = 2,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 45, "sturn" = 45,"wturn" = 45,"eturn" = 45,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 45,"sturn" = 45,"wturn" = 45,"eturn" = 45,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/flashlight/flare/torch/lantern/psycenser/attack_self(mob/user)
	if(fuel > 0)
		if(on)
			turn_off()
			possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha)
			user.update_a_intents()
		else
			playsound(src.loc, 'sound/items/censer_on.ogg', 100)
			possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha, /datum/intent/bless)
			user.update_a_intents()
			on = TRUE
			update_brightness()
			//force = on_damage
			if(ismob(loc))
				var/mob/M = loc
				M.update_inv_hands()
			START_PROCESSING(SSobj, src)
	else if(fuel <= 0 && user.used_intent.type == /datum/intent/weep)
		to_chat(user, span_info("Se ha ido. Lloras."))
		user.emote("cry")

/obj/item/flashlight/flare/torch/lantern/psycenser/process()
	if(on && next_smoke < world.time)
		new /obj/effect/temp_visual/censer_dust(get_turf(src))
		next_smoke = world.time + smoke_interval

/obj/item/flashlight/flare/torch/lantern/psycenser/turn_off()
	playsound(src.loc, 'sound/items/censer_off.ogg', 100)
	STOP_PROCESSING(SSobj, src)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
		M.update_inv_belt()
	damtype = BRUTE

/obj/item/flashlight/flare/torch/lantern/psycenser/fire_act(added, maxstacks)
	return

/obj/item/flashlight/flare/torch/lantern/psycenser/afterattack(atom/movable/A, mob/user, proximity, list/modifiers)
	. = ..()	//We smashed a guy with it turned on. Bad idea!
	if(ismob(A) && on && (user.used_intent.type == /datum/intent/flail/strike/smash/golgotha) && user.cmode)
		user.visible_message(span_warningbig("¡Ves una chispa extrañamente brillante antes de que detone!"))
		cell_explosion(get_turf(A), 40, 2)
		explosion(get_turf(A),devastation_range = -1, heavy_impact_range = -1, light_impact_range = -1, flame_range = 2, flash_range = 4, smoke = FALSE)
		fuel = 0
		turn_off()
		//icon_state = "psycenser-broken"
		possible_item_intents = list(/datum/intent/weep)
		user.update_a_intents()
		for(var/mob/living/carbon/human/H in view(get_turf(src)))
			if(istype(H.patron, /datum/patron/psydon)) //Psydonites get VERY depressed seeing an artifact get turned into an ulapool caber.
				H.add_stress(/datum/stress_event/syoncalamity)
	if(isitem(A) && on && user.used_intent.type == /datum/intent/bless)
		var/datum/component/psyblessed/CP = A.GetComponent(/datum/component/psyblessed)
		if(CP)
			if(!CP.is_blessed)
				playsound(user, 'sound/magic/censercharging.ogg', 100)
				user.visible_message(span_info("[user] tiene \the [src] sobre \the [A]..."))
				if(do_after(user, 50, A))
					CP.try_bless()
					new /obj/effect/temp_visual/censer_dust(get_turf(A))
			else
				to_chat(user, span_info("Ya ha sido bendecido."))
	if(ishuman(A) && on && (user.used_intent.type == /datum/intent/bless))
		var/mob/living/carbon/human/H = A
		if(istype(H.patron, /datum/patron/psydon))
			if(!H.has_status_effect(/datum/status_effect/buff/censerbuff))
				playsound(user, 'sound/magic/censercharging.ogg', 100)
				user.visible_message(span_info("[user] tiene \the [src] sobre \the [A]..."))
				if(do_after(user, 50, A))
					H.apply_status_effect(/datum/status_effect/buff/censerbuff)
					to_chat(H, span_notice("El polvo del cometa te revitaliza."))
					playsound(H, 'sound/magic/holyshield.ogg', 100)
					new /obj/effect/temp_visual/censer_dust(get_turf(H))
			else
				to_chat(user, span_warning("Ya han sido bendecidos."))

		else
			to_chat(user, span_warning("No comparten nuestra fe."))


/datum/component/psyblessed
	var/is_blessed
	var/pre_blessed
	var/added_force
	var/added_blade_int
	var/added_int
	var/silver

/datum/component/psyblessed/Initialize(preblessed = FALSE, force, blade_int, int, makesilver)
	if(!istype(parent, /obj/item/weapon))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	pre_blessed = preblessed
	added_force = force
	added_blade_int = blade_int
	added_int = int
	silver = makesilver
	if(pre_blessed)
		apply_bless()

/datum/component/psyblessed/proc/on_examine(datum/source, mob/user, list/examine_list)
	if(!is_blessed)
		examine_list += span_info("<font color = '#cfa446'>Este objeto puede estar bendecido por el fragmento persistente de Psydon. Hasta entonces, su aleacion impura de plata y acero no puede arruinar a los enemigos de inhumen por si sola.</font>")
	if(is_blessed)
		examine_list += span_info("<font color = '#46bacf'>Este objeto ha sido bendecido por el fragmento de Psydon.</font>")
		if(silver)
			examine_list += span_info("Ha sido imbuido con <b>plata</b>.")

/datum/component/psyblessed/proc/try_bless()
	if(!is_blessed)
		apply_bless()
		play_effects()
		return TRUE
	else
		return FALSE

/datum/component/psyblessed/proc/play_effects()
	if(isitem(parent))
		var/obj/item/I = parent
		playsound(I, 'sound/magic/holyshield.ogg', 100)
		I.visible_message(span_notice("¡[I] brilla con poder!"))

/datum/component/psyblessed/proc/apply_bless()
	if(isitem(parent))
		var/obj/item/I = parent
		is_blessed = TRUE
		I.force += added_force
		if(I.force_wielded)
			I.force_wielded += added_force
		if(I.max_blade_int)
			I.max_blade_int += added_blade_int
			I.blade_int = I.max_blade_int
		I.modify_max_integrity(I.max_integrity + added_int)
		I.name = "bendito [I.name]"
		if(silver)
			I.enchant(/datum/enchantment/silver)

/obj/effect/temp_visual/censer_dust
	icon = 'icons/effects/effects.dmi'
	icon_state = "extinguish"
	duration = 8

/obj/item/inqarticles
	item_flags = ITEM_ONLY_BREAK

/obj/item/inqarticles/indexer
	name = "\improper INDEXER"
	desc = "Una ampolla bendecida con una punta de cuchilla retractil, diseñada para recopilar mas informacion a traves de la hematologia. Sifon sangre de un individuo hasta que el INDEXER haga clic y se cierre, luego enviela por correo a Oratorium para catalogacion."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "indexer"
	item_state = "indexer"
	throw_speed = 3
	throw_range = 7
	grid_height = 32
	grid_width = 32
	throwforce = 15
	force = 4
	tool_behaviour = null
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	sharpness = IS_SHARP
	experimental_inhand = TRUE
	w_class = WEIGHT_CLASS_SMALL
	sellprice = 0
	verb_exclaim = "blares"
	item_weight = 80 GRAMS
	var/cursedblood
	var/active
	var/full
	var/timestaken
	var/working
	var/datum/weakref/subject = null

/obj/item/inqarticles/indexer/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(active)
		playsound(user, 'sound/items/indexer_shut.ogg', 65, TRUE)
		possible_item_intents = list(/datum/intent/use)
		user.update_a_intents()
		if(!full)
			active = FALSE
			working = FALSE
		update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/indexer/dropped(mob/living/carbon/human/user, slot)
	. = ..()
	if(active)
		possible_item_intents = list(/datum/intent/use)
		user.update_a_intents()
		playsound(user, 'sound/items/indexer_shut.ogg', 65, TRUE)
		if(!full)
			active = FALSE
			working = FALSE
		update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/indexer/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/inqarticles/indexer/attack_self(mob/user)
	. = ..()
	if(!HAS_TRAIT(user, TRAIT_INQUISITION))
		return
	if(working)
		return
	if(active)
		playsound(src, 'sound/items/indexer_shut.ogg', 75, FALSE, 3)
		possible_item_intents = list(/datum/intent/use)
		tool_behaviour = initial(tool_behaviour)
		user.update_a_intents()
		if(!full)
			active = FALSE
		update_appearance(UPDATE_ICON_STATE)
		return

	if(full)
		to_chat(user, span_notice("Esta listo para ser enviado de vuelta al Oratorium."))
		return

	possible_item_intents = list(/datum/intent/use, /datum/intent/dagger/cut)
	tool_behaviour = TOOL_SCALPEL
	user.update_a_intents()
	playsound(src, 'sound/items/indexer_open.ogg', 75, FALSE, 3)
	active = TRUE
	update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/indexer/update_icon_state()
	. = ..()

	if(full)
		if(cursedblood)
			icon_state = "indexer_cursed"
		else
			icon_state = "indexer_primed"
		return

	if(active)
		if(timestaken)
			icon_state = "indexer_used"
		else
			icon_state = "indexer_ready"
		return

	if(timestaken)
		icon_state = "indexer_full"
	else
		icon_state = initial(icon_state)

/obj/item/inqarticles/indexer/proc/fullreset(mob/user)
	possible_item_intents = list(/datum/intent/use)
	user.update_a_intents()
	cursedblood = initial(cursedblood)
	working = initial(working)
	full = initial(full)
	timestaken = initial(timestaken)
	desc = initial(desc)
	active = FALSE
	update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/indexer/attack_hand_secondary(mob/user)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!HAS_TRAIT(user, TRAIT_INQUISITION))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!full)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(tgui_alert(user, "¿VACIAR EL INDEXER?", "INDEXING...", list("SI", "NO")) != "NO")
		playsound(src, 'sound/items/indexer_empty.ogg', 75, FALSE, 3)
		visible_message(span_warning("¡[src] hierve su contenido!"))
		fullreset(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/inqarticles/indexer/proc/takeblood(mob/living/M, mob/living/user)
	if(timestaken >= 8)
		playsound(src, 'sound/items/indexer_finished.ogg', 75, FALSE, 3)
		working = FALSE
		full = TRUE
		visible_message(span_warning("¡[src] termina sacando sangre!"))
		active = FALSE
		desc += span_notice(" ¡Esta lleno!")
		if(cursedblood)
			playsound(src, 'sound/items/indexer_cursed.ogg', 100, FALSE, 3)
			possible_item_intents = list(/datum/intent/use)
			user.update_a_intents()
			active = FALSE
			update_appearance(UPDATE_ICON_STATE)
			say("¡SANGRE MALDITA!")
			return
		update_appearance(UPDATE_ICON_STATE)
		return

	working = TRUE
	playsound(src, 'sound/items/indexer_working.ogg', 75, FALSE, 3)
	if(active && working && !full)
		if(do_after(user, 20, M))
			M.flash_fullscreen("redflash3")
			if(M.can_feel_pain())
				if(prob(15))
					M.emote("whimper")
				else if(prob(15))
					M.emote("painmoan")
			desc = initial(desc)
			subject = WEAKREF(M)
			desc += span_notice(" ¡Contiene la sangre de [M.real_name]!")
			visible_message(span_warning("¡[src] obtiene energia de [M]!"))
			playsound(M, 'sound/combat/hits/bladed/genstab (1).ogg', 30, FALSE, -1)
			timestaken++
			M.adjust_blood_volume(-30)
			if(M.mind)
				if(M.mind.has_antag_datum(/datum/antagonist/werewolf, FALSE))
					cursedblood = 3
				if(M.mind.has_antag_datum(/datum/antagonist/werewolf/lesser, FALSE))
					cursedblood = 2
				if(M.mind.has_antag_datum(/datum/antagonist/vampire/lords_spawn, FALSE))
					cursedblood = 1
				if(M.mind.has_antag_datum(/datum/antagonist/vampire, FALSE))
					cursedblood = 2
				if(M.mind.has_antag_datum(/datum/antagonist/vampire/lord, FALSE))
					cursedblood = 3
				if(M.mind.has_antag_datum(/datum/antagonist/vampire/lord/daewalker))
					cursedblood = 5 //hoo mama
			update_appearance(UPDATE_ICON_STATE)
			takeblood(M, user)
		else
			working = FALSE

/obj/item/inqarticles/indexer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE

	if(!HAS_TRAIT(user, TRAIT_INQUISITION))
		to_chat(user, span_warning("No se como usar esto."))
		return ITEM_INTERACT_BLOCKING

	if(!active)
		to_chat(user, span_warning("No esta preparado."))
		return ITEM_INTERACT_BLOCKING

	if(full)
		to_chat(user, span_warning("Esta lleno."))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/L = interacting_with

	if(!CAN_HAVE_BLOOD(L) || !L.get_blood_volume())
		to_chat(user, span_warning("[L] no tiene sangre para tomar una muestra."))
		return ITEM_INTERACT_BLOCKING

	visible_message(span_warning("¡[user] va a golpear a [L] con [src]!"))

	if(!do_after(user, 2 SECONDS, L))
		return ITEM_INTERACT_BLOCKING

	takeblood(L, user)

	return ITEM_INTERACT_SUCCESS

/obj/item/inqarticles/tallowpot
	name = "caldero de sebo"
	desc = "Un pequeño recipiente de metal destinado a contener ceras o sebo rojo derretido. Conveniente para recubrir anillos de sello y hacer una impresion. El calor de una antorcha o lampara deberia ser suficiente para derretir el sebo rojo para sellar escrituras."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "tallowpot"
	item_state = "tallowpot"
	dropshrink = 0.9
	throw_speed = 1
	throw_range = 3
	throwforce = 5
	possible_item_intents = list(/datum/intent/use)
	grid_height = 32
	grid_width = 32
	obj_flags = CAN_BE_HIT
	experimental_inhand = TRUE
	w_class = WEIGHT_CLASS_SMALL
	embedding = null
	item_weight = 150 GRAMS
	var/tallow
	var/remaining
	var/heatedup
	var/messageshown = 1
	sellprice = 0

/obj/item/inqarticles/tallowpot/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)	// For making sure it melts.

/obj/item/inqarticles/tallowpot/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/inqarticles/tallowpot/process()
	if(heatedup > 0)
		heatedup -= 4
		remaining = max(remaining - 20, 0)
		messageshown = 0
	else
		if(tallow)
			if(!messageshown)
				visible_message(span_info("La grasa roja en [src] se endurece de nuevo."))
				messageshown = 1
			update_appearance(UPDATE_ICON_STATE)
	if(remaining == 0)
		qdel(tallow)
		tallow = initial(tallow)
		update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/tallowpot/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(istype(I, /obj/item/reagent_containers/food/snacks/tallow))
		if(!istype(I,/obj/item/reagent_containers/food/snacks/tallow/red)) // Tells players to make redtallow.
			to_chat(user,span_warning("La grasa normal carece de las propiedades para actuar como cera. Añadele visceras primero."))
			return
		if(!tallow)
			var/obj/item/reagent_containers/food/snacks/tallow/red/Q = I
			tallow = Q
			user.transferItemToLoc(Q, src, TRUE)
			remaining = 300
			update_appearance(UPDATE_ICON_STATE)
		else
			to_chat(user, span_info("[src] ya tiene grasa roja en el."))


	if(istype(I, /obj/item/flashlight/flare/torch))
		heatedup = 28
		visible_message(span_info("[user] calienta a [src] con [I]."))
		update_appearance(UPDATE_ICON_STATE)

	if(istype(I, /obj/item/clothing/ring/signet))
		if(tallow && heatedup)
			var/obj/item/clothing/ring/signet/ring = I
			ring.tallowed = TRUE
			ring.update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/tallowpot/afterattack(atom/target, mob/living/user, proximity_flag, list/modifiers)
	. = ..()
	if(!proximity_flag)
		return
	//Both static light sources and torches/lanterns have on bool so this invalid cast... it just works yeah
	var/obj/machinery/light/fueled/F = target

	if((istype(target, /obj/machinery/light/fueled) || istype(target, /obj/item/flashlight/flare/torch)) && F.on)
		heatedup = 28
		visible_message(span_info("[user] calienta [src] usando [target]."))
		update_appearance(UPDATE_ICON_STATE)


/obj/item/inqarticles/tallowpot/update_icon_state()
	. = ..()
	if(tallow)
		icon_state = "[initial(icon_state)]_filled"
		if(heatedup)
			icon_state = "[initial(icon_state)]_melted"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/rope/inqarticles/inquirycord
	name = "cordaje de consulta"
	desc = "Un trozo de cordel de cuero grueso que se ha sumergido en agua bendita y tinte antes de ser consagrado y adornado con hechizos. Diseñado para capturar enemigos y reenhebrar herramientas en el peor de los casos."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "inqcordage"
	item_state = "inqcordage"
	throw_speed = 1
	throw_range = 3
	throwforce = 5
	breakouttime = 8 SECONDS
	slipouttime = 900 // 1:30.
	possible_item_intents = list(/datum/intent/tie)
	//cuffsound = 'sound/misc/cordage.ogg'
	grid_height = 32
	grid_width = 32
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	experimental_inhand = TRUE
	w_class = WEIGHT_CLASS_SMALL
	embedding = null
	sellprice = 0
	item_weight = 100 GRAMS

/obj/item/rope/inqarticles/inquirycord/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 90,"wturn" = 93,"eturn" = -12,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 90,"wturn" = 93,"eturn" = -12,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/inqarticles/garrote // Do not give this item out freely to other classes. Do not subtype this item for other classes. This is intended purely as the Confessor's identifying sidegrade, and as a bonus for the Inspector INQ. I will be very sad if you disregard this comment. Thank you. - Yische.
	name = "\proper agarrando garrote" // It's nonlethal. It's so silly and fun.
	desc = "Un instrumento macabro favorecido por los mas clandestinos de la Orden de Plata Psydonian; Un trozo de cordel de cuero grueso que ha sido sumergido en agua bendita y tinte antes de ser consagrado y hechizado, sostenido y enhebrado entre dos eslabones de hierro. Perfecto para la aprehension."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "garrote"
	throw_speed = 3
	throw_range = 7
	grid_height = 32
	grid_width = 32
	throwforce = 15
	force_wielded = 0
	force = 0
	obj_flags = CAN_BE_HIT | NO_DEBRIS_AFTER_DECONSTRUCTION
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	experimental_inhand = TRUE
	max_integrity = 400
	w_class = WEIGHT_CLASS_SMALL
	can_parry = FALSE
	break_sound = 'sound/items/garrotebreak.ogg'
	gripped_intents = list(/datum/intent/garrote/grab, /datum/intent/garrote/choke)
	item_weight = 150 GRAMS
	var/datum/weakref/victim
	var/datum/weakref/lastuser
	var/obj/item/grabbing/currentgrab
	var/active = FALSE
	var/choke_damage = 8
	integrity_failure = 0.01
	sellprice = 0
	wield_block = FALSE

	var/static/list/wield_sounds = list('sound/items/garrote.ogg', 'sound/items/garrote2.ogg')

/obj/item/inqarticles/garrote/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 90,"wturn" = 93,"eturn" = -12,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 9,"ny" = -6,"wx" = -6,"wy" = -4,"ex" = 4,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 90,"wturn" = 93,"eturn" = -12,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/datum/intent/garrote/choke
	name = "ahogar"
	icon_state = "inchoke"
	desc = "Se utiliza para empezar a asfixiar al objetivo."
	no_attack = TRUE

/datum/intent/garrote/grab
	name = "agarra."
	icon_state = "ingrab"
	desc = "Se utiliza para envolver al objetivo."
	no_attack = TRUE

/obj/item/inqarticles/garrote/Destroy()
	reset_garrote()
	. = ..()

/obj/item/inqarticles/garrote/atom_break(damage_flag, silent)
	. = ..()
	if(!ismob(loc))
		return
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		var/datum/component/two_handed/twohanded = GetComponent(/datum/component/two_handed)
		if(ismob(loc))
			var/mob/M = loc
			twohanded.unwield(M)
			to_chat(M, span_warning("¡El [src] SE ROMPE y se rompe en pedazos!"))
	update_appearance()

/obj/item/inqarticles/garrote/atom_fix()
	. = ..()
	update_appearance()

/obj/item/inqarticles/garrote/update_name(updates)
	. = ..()
	if(obj_broken)
		name = "\proper rompio el garrote de incautacion"
	else
		name = initial(name)

/obj/item/inqarticles/garrote/update_icon_state()
	icon_state = initial(icon_state)
	. = ..()
	if(obj_broken)
		icon_state = "garrote_snap"

/obj/item/inqarticles/garrote/apply_components()
	AddComponent(/datum/component/two_handed, \
		wieldsound = wield_sounds, \
		unwieldsound = 'sound/items/garroteshut.ogg', \
		force_unwielded = force, \
		force_wielded = force_wielded, \
		icon_wielded = "garrote1", \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
		wield_block_offhand = wield_block)

/obj/item/inqarticles/garrote/proc/reset_garrote()
	SIGNAL_HANDLER

	var/mob/living/garrote_victim = victim?.resolve()
	if(garrote_victim)
		REMOVE_TRAIT(garrote_victim, TRAIT_MUTE, "garroteCordage")
	UnregisterSignal(garrote_victim, list(COMSIG_LIVING_RESIST_GRAB, COMSIG_QDELETING, COMSIG_CARBON_ATTEMPT_BREATHE))
	victim = null

	var/mob/living/last_garrote_user = lastuser?.resolve()
	UnregisterSignal(last_garrote_user, COMSIG_ATOM_NO_LONGER_PULLING)
	lastuser = null

	// If stop_pulling() is called, this will be qdeleted already. If reset_garrote is called first, this qdel should call stop_pulling().
	if(!QDELETED(currentgrab))
		QDEL_NULL(currentgrab)

	active = FALSE

/obj/item/inqarticles/garrote/on_unwield(obj/item/source, mob/living/carbon/user)
	. = ..()
	reset_garrote()

/obj/item/inqarticles/garrote/attack_self(mob/user)
	if(obj_broken)
		to_chat(user, span_warning("No sirve de nada ahora mismo, pero puedo volver a enhebrarlo con cuerda."))
		return TRUE
	return ..()

/obj/item/inqarticles/garrote/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(istype(I, /obj/item/rope/inqarticles/inquirycord))
		user.visible_message(span_notice("[user] comienza a reensamblar el [src] usando \the [I]."))
		if(do_after(user, 12 SECONDS, user))
			qdel(I)
			update_integrity(max_integrity)
		else
			user.visible_message(span_warning("[user] deja de reensartar el [src]."))
		return TRUE

/obj/item/inqarticles/garrote/afterattack(mob/living/target, mob/living/user, proximity_flag, list/modifiers)
	. = ..()
	var/mob/living/garrote_victim = victim?.resolve()
	if(istype(user.used_intent, /datum/intent/garrote/grab))	// Grab your target first.
		if(!iscarbon(target))
			return
		if(!proximity_flag)
			return
		if(garrote_victim == target)
			return
		/*
		if(HAS_TRAIT(target, TRAIT_GRABIMMUNE))
			playsound(src, pick('sound/items/garrote.ogg', 'sound/items/garrote2.ogg'), 65, TRUE)
			user.visible_message(span_danger("[target] slips past [user]'s attempt to [src] them!"))
			return
		*/
		// THROAT TARGET RESTRICTION. HEAVILY REQUESTED.
		if(user.zone_selected != "neck")
			to_chat(user, span_warning("Necesito envolverlo alrededor de su garganta."))
			return
		if(user.pulling)
			user.stop_pulling()
		reset_garrote()
		ADD_TRAIT(user, TRAIT_NOSTRUGGLE, TRAIT_GENERIC)
		if(!user.start_pulling(target, state = GRAB_AGGRESSIVE, suppress_message = TRUE, accurate = TRUE))
			REMOVE_TRAIT(user, TRAIT_NOSTRUGGLE, TRAIT_GENERIC)
			return
		REMOVE_TRAIT(user, TRAIT_NOSTRUGGLE, TRAIT_GENERIC)
		begin_garrote(target, user)
		var/obj/item/grabbing/I = user.get_inactive_held_item()
		if(istype(I, /obj/item/grabbing)) // generate an invisible grabbing item to simulate grabbing behavior
			I.icon_state = null
			currentgrab = I
		playsound(loc, 'sound/items/garrotegrab.ogg', 100, TRUE)
		user.visible_message(span_danger("¡[user] envuelve el [src] alrededor de la garganta de [target]!"))
		user.adjust_stamina(25)
		user.changeNext_move(CLICK_CD_MELEE)

	if(istype(user.used_intent, /datum/intent/garrote/choke))	// Get started.
		if(!garrote_victim)
			to_chat(user, span_warning("¿A quien estoy asfixiando? ¿Que?"))
			return
		if(!proximity_flag)
			return
		if(user.zone_selected != "neck")
			to_chat(user, span_warning("Necesito constreñir la garganta."))
			return
		user.adjust_stamina(rand(4, 8))
		var/mob/living/carbon/C = garrote_victim
		// if(get_location_accessible(C, BODY_ZONE_PRECISE_NECK))
		playsound(src, pick('sound/items/garrotechoke1.ogg', 'sound/items/garrotechoke2.ogg', 'sound/items/garrotechoke3.ogg', 'sound/items/garrotechoke4.ogg', 'sound/items/garrotechoke5.ogg'), 100, TRUE)
		if(prob(40))
			C.emote("choke")
		C.adjustOxyLoss(choke_damage)
		C.visible_message(span_danger("[user] [pick("garrotes", "asphyxiates")] [C]!"), \
		span_userdanger("¡[user] ¡[pick("garrotes", "asphyxiates")] ¡Mirame!"), span_hear("¡Escucho el sonido desagradable de las cuerdas!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("¡Yo [pick("garrote", "asphyxiate")] [C]!"))
		user.changeNext_move(CLICK_CD_RESIST)	//Stops spam for choking.

/obj/item/inqarticles/garrote/proc/begin_garrote(mob/living/target, mob/living/user)
	active = TRUE
	ADD_TRAIT(target, TRAIT_MUTE, "garroteCordage")
	RegisterSignal(target, COMSIG_LIVING_RESIST_GRAB, PROC_REF(on_victim_resist))
	RegisterSignal(target, COMSIG_QDELETING, PROC_REF(reset_garrote))
	RegisterSignal(target, COMSIG_CARBON_ATTEMPT_BREATHE, PROC_REF(block_breath))
	RegisterSignal(user, COMSIG_ATOM_NO_LONGER_PULLING, PROC_REF(reset_garrote))
	victim = WEAKREF(target)
	lastuser = WEAKREF(user)

/obj/item/inqarticles/garrote/proc/on_victim_resist(datum/source, mob/living/resistor, mob/living/pulledby, moving_resist, resist_outcome)
	SIGNAL_HANDLER
	if(resist_outcome) // true means resist_grab() failed
		if(!resistor.mind) // NPCs do less damage to the garrote
			take_damage(max_integrity * 0.0125) // 400 max = 5 damage
		else
			take_damage(max_integrity * 0.025) // 400 max = 10 damage
	else
		if(!resistor.mind)
			take_damage(max_integrity * 0.05)
		else
			take_damage(max_integrity * 0.1)

/obj/item/inqarticles/garrote/proc/block_breath(datum/source)
	return BREATHE_SKIP_BREATH

/obj/item/inqarticles/garrote/razor // To yische, who said not to give this out constantly, I respectfully disagree when it comes to assassin
	name = "navaja profana" // It's very not non lethal now.  Strangle your prey with glee
	desc = "Un fino hilo de alambre negro fantasma colgado entre agarres de acero. Frio al tacto incluso con guantes. El hilo de alambre, aunque parece fragil, es aparentemente irrompible."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "garrote"
	item_state = "garrote"
	resistance_flags = INDESTRUCTIBLE
	choke_damage = 16
	sellprice = 100
	item_weight = 100 GRAMS

/obj/item/clothing/head/inqarticles/blackbag
	name = "bolso negro"
	desc = "Un saco acolchado fuertemente tejido con hechizos destinado a amortiguar los gritos que se producen en su interior. Debido al peso de los materiales involucrados, su aplicacion y eliminacion suele ser dificil para personas no capacitadas."
	icon_state = "blackbag"
	item_state = "blackbag"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
	blocksound = SOFTHIT
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	armor_type = /datum/armor/blackbag
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_PIERCE, BCLASS_CHOP, BCLASS_LASHING, BCLASS_STAB)
	unequip_delay_self = 45
	equip_delay_other = 360 SECONDS // No getting around it. Cheater. LEFT CLICK THEM!!!
	equip_delay_self = 360 SECONDS
	max_integrity = 10000 // No breaking it. NO CHEAP FRAGS.
	strip_delay = 10
	slot_flags = ITEM_SLOT_HEAD
	body_parts_covered = FULL_HEAD
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = NONE
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	grid_width = 32
	grid_height = 64
	item_weight = 300 GRAMS
	var/worn = FALSE
	var/bagging = FALSE

/obj/item/clothing/head/inqarticles/blackbag/proc/bagsound(mob/living/M)
	if(bagging)
		playsound(M, pick('sound/misc/blackbag.ogg','sound/misc/blackbag2.ogg','sound/misc/blackbag3.ogg','sound/misc/blackbag4.ogg','sound/misc/blackbag5.ogg'), 100, TRUE, 4)

/obj/item/clothing/head/inqarticles/blackbag/proc/bagcheck(mob/living/M)
	var/timer = 10
	bagsound(M)
	for(timer, timer < 120, timer += 10)
		if(bagging)
			addtimer(CALLBACK(src, PROC_REF(bagsound), M), timer)

/obj/item/clothing/head/inqarticles/blackbag/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!iscarbon(interacting_with))
		return NONE

	var/mob/living/carbon/M = interacting_with

	if(HAS_TRAIT(M, TRAIT_BAGGED))
		to_chat(user, span_warning("Ya han sido embolsados."))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/headgear = M.get_item_by_slot(ITEM_SLOT_HEAD)

	var/trained = FALSE
	var/timetobag = 8 SECONDS
	if(HAS_TRAIT(user, TRAIT_BLACKBAGGER))
		trained = TRUE
		timetobag = 4 SECONDS

	user.visible_message(span_danger("[user] va a [trained ? "expertly" : "clumsily"] bolsa negra [M] ¡!"))

	if(M.stat)
		timetobag /= 2

	bagging = TRUE
	bagcheck(M)
	if(do_after(user, timetobag, M))
		bagging = FALSE
		headgear?.doStrip(user, M)
		M.equip_to_slot(src, ITEM_SLOT_HEAD) // Has to be unsafe otherwise it won't work on unconscious people. Ugh.
	else
		bagging = FALSE

	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/head/inqarticles/blackbag/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(user.head == src)
		bagging = FALSE
		user.become_blind("blindfold_[REF(src)]")
		playsound(user, pick('sound/misc/blackbagequip.ogg', 'sound/misc/blackbagequip2.ogg'), 100, TRUE, 4)
		user.playsound_local(src, 'sound/misc/blackbagloop.ogg', 100, FALSE)
		worn = TRUE
		ADD_TRAIT(user, TRAIT_BAGGED, TRAIT_GENERIC)

/obj/item/clothing/head/inqarticles/blackbag/dropped(mob/living/carbon/human/user)
	..()
	if(worn == TRUE)
		user.cure_blind("blindfold_[REF(src)]")
		worn = FALSE
		update_integrity(max_integrity)
		REMOVE_TRAIT(user, TRAIT_BAGGED, TRAIT_GENERIC)
		playsound(user, pick('sound/misc/blackunbag.ogg'), 100, TRUE, 4)
		user.emote("gasp", forced = TRUE)

/obj/item/clothing/head/inqarticles/blackbag/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,
				"sx" = -4,
				"sy" = -7,
				"nx" = 6,
				"ny" = -6,
				"wx" = -2,
				"wy" = -7,
				"ex" = -1,
				"ey" = -7,
				"northabove" = 0,
				"southabove" = 1,
				"eastabove" = 1,
				"westabove" = 0,
				"nturn" = 0,
				"sturn" = 0,
				"wturn" = 0,
				"eturn" = 0,
				"nflip" = 8,
				"sflip" = 0,
				"wflip" = 0,
				"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/inqarticles/bmirror
	name = "espejo negro"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "bmirror"
	item_state = "bmirror"
	grid_height = 64
	grid_width = 32
	throw_speed = 3
	throw_range = 7
	throwforce = 15
	force = 15
	dropshrink = 0
	hitsound = 'sound/blank.ogg'
	sellprice = 0
	resistance_flags = FIRE_PROOF
	item_weight = 400 GRAMS
	var/opened = FALSE
	var/fedblood = FALSE
	var/bloody = FALSE
	var/openstate = "open"
	var/usesleft = 3
	var/active = FALSE
	var/broken = FALSE
	/// Target name
	var/datum/weakref/fixation
	/// One with the bleed in the mirror
	var/datum/weakref/feeder
	var/atom/movable/screen/alert/blackmirror/effect
	var/datum/looping_sound/blackmirror/soundloop

/obj/item/inqarticles/bmirror/Initialize()
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/inqarticles/bmirror/Destroy()
	if(soundloop)
		QDEL_NULL(soundloop)
	if(effect)
		QDEL_NULL(effect)
	fixation = null
	feeder = null
	return ..()

/obj/item/inqarticles/bmirror/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_INQUISITION))
		desc = "Una reliquia producida en masa del Oratorium Throni Vacui. El metodo exacto de operacion del Black Mirror sigue siendo un secreto bien guardado. Uno por el que supuestamente vale la pena morir."
	else
		desc = ""

/obj/item/inqarticles/bmirror/proc/donefixating()
	bloody = TRUE
	active = FALSE
	fedblood = FALSE
	openstate = "bloody"
	feeder = null
	var/mob/living/fixated = fixation?.resolve()
	if(fixated)
		fixated.clear_alert("blackmirror", TRUE)
		fixated.playsound_local(src, 'sound/items/blackeye.ogg', 40, FALSE)
	effect = null
	fixation = null
	usesleft--
	soundloop.stop()
	visible_message(span_info("[src] se nubla con una niebla escalofriante."))
	playsound(src, 'sound/items/blackmirror_no.ogg', 100, FALSE)
	update_appearance(UPDATE_ICON_STATE)
	if(usesleft == 0)
		addtimer(CALLBACK(src, PROC_REF(try_break)), 2 SECONDS)

/obj/item/inqarticles/bmirror/proc/try_break()
	if(QDELETED(src))
		return
	broken = TRUE
	playsound(src, 'sound/items/blackmirror_break.ogg', 100, FALSE)
	visible_message(span_info("[src] se rompe, niebla saliendo de los fragmentos desmenuzados hacia el aire muerto."))
	openstate = "broken"
	update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/bmirror/attack_self(mob/user, list/modifiers)
	. = ..()
	if(!user.mind)
		return

	if(!opened)
		to_chat(user, span_warning("No esta abierto."))
		return

	if(broken && bloody)
		to_chat(user, span_warning("El espejo se ha roto, dejandolo inservible."))
		if(HAS_TRAIT(user, TRAIT_INQUISITION))
			to_chat(user, span_notice("Si lo limpio, puedo enviarlo de vuelta a la Inquisicion para repararlo."))
		return

	if(broken && !bloody)
		to_chat(user, span_warning("El espejo se ha roto, lo que lo hace inutilizable. Al menos esta limpio."))
		if(HAS_TRAIT(user, TRAIT_INQUISITION))
			to_chat(user, span_notice("Ahora se puede devolver a traves de HERMES. Deberia recuperar dos Marques."))
		return

	if(bloody)
		to_chat(user, span_warning("El espejo esta empañado. Necesito limpiarle la sangre con un paño antes de volver a usarlo."))
		return

	if(!fedblood)
		to_chat(user, span_warning("Parece que necesita sangre para funcionar correctamente."))
		return

	if(!active)
		var/mob/living/carbon/human/target = fixation?.resolve()
		var/input
		if(!target)
			input = "FIXATION" //skips through the tgui alert if target isn't set
		else
			input = tgui_alert(user, "EL ESPEJO ESTA FIJADO EN [uppertext(target.real_name)]. ¿REVELARAS TU MIRADA?", "EL PRECIO ESTA PAGADO", list("SANGRE DEL TALLO", "FIJACION"))
		if(!input || QDELETED(user) || QDELETED(src))
			return
		if(input == "FIXATION")
			var/name = html_decode(browser_input_text(user, "¿A QUIEN BUSCAS?", "EL PRECIO ESTA PAGADO"))
			if(!name)
				return
			for(var/mob/living/carbon/human/HL as anything in GLOB.player_list)
				if(LOWER_TEXT(HL.real_name) == LOWER_TEXT(name))
					fixation = WEAKREF(HL)
					target = HL
					playsound(src, 'sound/items/blackmirror_no.ogg', 100, FALSE)
					to_chat(user, span_warning("[src] hace un sonido chirriante."))
					return
			to_chat(user, span_warning("El espejo no hace ningun sonido... No pudo localizar a una persona de ese nombre."))
			return
		active = TRUE
		openstate = "active"
		update_appearance(UPDATE_ICON_STATE)
		soundloop.start()

		effect = target.throw_alert("blackmirror", /atom/movable/screen/alert/blackmirror, override = TRUE)
		effect.source = src

		target.playsound_local(target, 'sound/items/blackeye_warn.ogg', 100, FALSE)

		playsound(src, 'sound/items/blackmirror_active.ogg', 100, FALSE)
		addtimer(CALLBACK(src, PROC_REF(donefixating)), 2 MINUTES, TIMER_UNIQUE)

		message_admins("SCRYING: [user.real_name] ([user.ckey]) has fixated on [target.real_name] ([target.ckey]) via black mirror.")
		log_game("SCRYING: [user.real_name] ([user.ckey]) has fixated on [target.real_name] ([target.ckey]) via black mirror.")
		return

	var/datum/weakref/lookat = fixation ? fixation : feeder
	var/mob/living/target = lookat?.resolve()
	if(!target)
		to_chat(user, span_notice("El espejo sigue intacto..."))
		return

	playsound(src, 'sound/items/blackmirror_use.ogg', 100, FALSE)

	if(target.real_name == user.real_name) //prevents bugging the timer through looking at yourself
		to_chat(user, span_danger("Veo mi reflejo en el espejo... Esta bastante distorsionado, pero ¿que estoy intentando lograr?"))
		return

	ADD_TRAIT(user, TRAIT_NOSSDINDICATOR, "blackmirror")

	var/mob/dead/observer/screye/blackmirror/S = user.scry_ghost()
	if(!S)
		return
	S.ManualFollow(target)
	S.add_client_colour(/datum/client_colour/nocshaded)
	user.visible_message(span_warning("[user] se fija en [src], sus ojos se empapan..."))

	addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 4 SECONDS)
	addtimer(CALLBACK(user, GLOBAL_PROC_REF(playsound), user, 'sound/items/blackeye.ogg', 100, FALSE), 4 SECONDS)
	addtimer(TRAIT_CALLBACK_REMOVE(user, TRAIT_NOSSDINDICATOR, "blackmirror"), 4 SECONDS)

/obj/item/inqarticles/bmirror/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE

	var/mob/living/attacked = interacting_with

	if(!opened)
		to_chat(user, span_warning("Necesito abrirlo primero."))
		return ITEM_INTERACT_BLOCKING

	if(feeder)
		to_chat(user, span_warning("Ya se le ha dado de comer."))
		return ITEM_INTERACT_BLOCKING

	if(broken)
		to_chat(user, span_warning("Esta roto."))
		return ITEM_INTERACT_BLOCKING

	if(bloody)
		to_chat(user, span_warning("El espejo esta empañado. Necesito limpiarlo con un paño antes de volver a usarlo."))
		return ITEM_INTERACT_BLOCKING

	var/time_taken = 3 SECONDS

	if(attacked == user)
		user.visible_message(span_notice("[user] presiona sobre la aguja de [src]."))
	else
		user.visible_message(span_notice("[user] va a imprimir [attacked] con la aguja de [src]."))
		time_taken *= 2

	if(!do_after(user, time_taken, attacked))
		return ITEM_INTERACT_BLOCKING

	playsound(src, 'sound/items/blackmirror_needle.ogg', 95, FALSE, 3)
	attacked.flash_fullscreen("redflash3")
	attacked.adjustBruteLoss(40, damage_type = BCLASS_PIERCE, can_crit = FALSE)
	attacked.adjust_bloodpool(-240)
	feeder = WEAKREF(attacked)
	openstate = "bloody"
	fedblood = TRUE
	update_appearance(UPDATE_ICON_STATE)

	return ITEM_INTERACT_SUCCESS

/obj/item/inqarticles/bmirror/attackby(obj/item/I, mob/user, list/modifiers)
	. = ..()
	if(!istype(I, /obj/item/natural/cloth))
		return

	if(broken && bloody && do_after(user, 3 SECONDS, user))
		user.visible_message(span_info("[user] limpia [src] con [I]."))
		openstate = "cleaned"
		bloody = FALSE
		update_appearance(UPDATE_ICON_STATE)
	else if(bloody && do_after(user, 3 SECONDS, user))
		user.visible_message(span_info("[user] limpia la niebla y la sangre de [src] con [I]."))
		openstate = "open"
		bloody = FALSE
		update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/bmirror/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	openorshut(user)
/obj/item/inqarticles/bmirror/proc/openorshut(mob/user)
	if(active)
		to_chat(user, span_warning("No puedo cerrar el espejo mientras este activo."))
		return

	var/mob/living/fixated = fixation?.resolve()
	if(opened)
		if(fixated)
			fixated.clear_alert("blackmirror", TRUE)
			fixated.playsound_local(src, 'sound/items/blackeye.ogg', 40, FALSE)
		else if(effect)
			QDEL_NULL(effect)
		playsound(src, 'sound/items/blackmirror_shut.ogg', 100, FALSE)
		opened = FALSE
		update_appearance(UPDATE_ICON_STATE)
		return

	playsound(src, 'sound/items/blackmirror_open.ogg', 100, FALSE)

	if(fixated)
		fixated.playsound_local(src, 'sound/items/blackeye_warn.ogg', 100, FALSE)
		effect = fixated.throw_alert("blackmirror", /atom/movable/screen/alert/blackmirror, override = TRUE)
		effect.source = src

	opened = TRUE
	update_appearance(UPDATE_ICON_STATE)

/obj/item/inqarticles/bmirror/update_icon_state()
	. = ..()

	if(opened)
		icon_state = "[initial(icon_state)]_[openstate]"
	else
		icon_state = "[initial(icon_state)]"

/atom/movable/screen/alert/blackmirror
	name = "OJO MORADO"
	desc = "MIRAME. TE VEO."
	icon_state = "blackeye"
	var/obj/item/inqarticles/bmirror/source

/atom/movable/screen/alert/blackmirror/Destroy()
	source = null
	return ..()

/atom/movable/screen/alert/blackmirror/Click()
	var/mob/living/L = usr
	if(!istype(L))
		return
	var/mob/living/target = null
	var/input = tgui_alert(L, "SIENTES UNA MIRADA DESCONOCIDA. ¿MIRARAS DETRAS A ABYSS?", "PRESENCIA VIGILANDO", list("TRAZA SANGRE", "MIENTITATE."))
	if(input == "TRACE BLOOD")
		target = source.feeder?.resolve()
	else if(input == "LOOK BACK")
		target = source
	playsound(L, 'sound/items/blackmirror_use.ogg', 100, FALSE)
	ADD_TRAIT(L, TRAIT_NOSSDINDICATOR, "blackmirror")
	if(!target)
		return
	var/mob/dead/observer/screye/blackmirror/S = L.scry_ghost()
	if(!S)
		return
	S.ManualFollow(target)
	S.add_client_colour(/datum/client_colour/nocshaded)
	L.visible_message(span_warning("[L] mira hacia adentro mientras sus ojos se empañan..."))

	addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 4 SECONDS)
	addtimer(CALLBACK(L, GLOBAL_PROC_REF(playsound), L, 'sound/items/blackeye.ogg', 100, FALSE), 4 SECONDS)
	addtimer(TRAIT_CALLBACK_REMOVE(L, TRAIT_NOSSDINDICATOR, "blackmirror"), 4 SECONDS)

// FINISH THIS AT YOUR LEISURE. I'M JUST LEAVING IT HERE UNIMPLEMENTED. IT'S INTENDED TO WORK AS A COMBINATION OF THE NOC FAR-SIGHT AND THE NOCSHADES. HAVE FUN! - YISCHE
/obj/item/inqarticles/spyglass
	name = "ocular otavan nocshade"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "spyglass"
	item_state = "spyglass"
	grid_height = 32
	grid_width = 32
	item_weight = 200 GRAMS

/obj/item/inqarticles/spyglass/attack_self(mob/living/user)
	. = ..()
