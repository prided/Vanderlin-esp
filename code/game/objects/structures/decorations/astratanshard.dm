GLOBAL_LIST_EMPTY(street_lamp_lights)

/obj/structure/astratanshard
	name = "Fragmento astratan"
	max_integrity = 1500
	integrity_failure = 1
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "clockcrystal"
	desc = "El cristal dentro del cometa aterrizo en el Anvil de Malum. Reunido y contenido por los mejores artifices, ahora se encuentra aqui para iluminar el camino tanto para los viajeros como para los barcos. Disfruta de su divinidad."
	var/datum/looping_sound/the_hum
	var/broken_containment = FALSE
	anchored = TRUE
	density = TRUE
	SET_BASE_PIXEL(-16, -12)

/obj/structure/astratanshard/Initialize()
	. = ..()
	the_hum = new /datum/looping_sound/astratanshard_hum(src,FALSE)
	the_hum.start()
	set_light(5, 4, 30, l_color = LIGHT_COLOR_YELLOW)

/obj/structure/astratanshard/Destroy()
	for(var/obj/machinery/light/fueledstreet/lamp as anything in GLOB.street_lamp_lights)
		lamp.lights_out(TRUE)
	if(the_hum)
		QDEL_NULL(the_hum)
	return ..()

/obj/structure/astratanshard/atom_break(damage_flag, silent)
	. = ..()
	if(broken_containment)
		return
	broken_containment = TRUE
	QDEL_NULL(the_hum)
	the_hum = new /datum/looping_sound/astratanshard_broken(src, FALSE)
	the_hum.start()
	RegisterSignals(src, list(COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_ATTACK_PAW), PROC_REF(on_touched))
	RegisterSignal(src, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_whacked))
	RegisterSignal(src, COMSIG_ATOM_BUMPED, PROC_REF(on_bump))
	icon_state = "clockcrystal_broken"
	resistance_flags |= INDESTRUCTIBLE

/obj/structure/astratanshard/atom_deconstruct(disassembled)
	return // Nah

/obj/structure/astratanshard/proc/on_bump(atom/shard,atom/movable/movie)
	SIGNAL_HANDLER
	if(ismob(movie))
		send_to_necra(movie)
	else
		on_whacked(movie)

/obj/structure/astratanshard/proc/on_touched(atom/shard,mob/fool)
	SIGNAL_HANDLER
	send_to_necra(fool)

/obj/structure/astratanshard/proc/on_whacked(atom/shard,atom/thingy)
	SIGNAL_HANDLER
	if(ismob(thingy))
		send_to_necra(thingy)
	if(istype(thingy,/obj))
		var/obj/deadthing = thingy
		src.visible_message(span_danger("¡\The [deadthing] desaparece en un violento destello al entrar en contacto con \The [src]!"))
		qdel(deadthing)

/obj/structure/astratanshard/proc/send_to_necra(mob/living/fool,visible_message,mob_message,cause)
	if(isdead(fool))
		return
	if(!visible_message)
		visible_message = span_danger("[fool] extiende su mano y toca a \the [src], al hacer contacto, ¡[fool.p_they()] se convierten en polvo!")
	if(!mob_message)
		mob_message = span_userdanger("Extiendes la mano y tocas \the [src]. Tu cuerpo esta lleno de un dolor indescriptible, tu mente es incapaz incluso de comprender la divinidad con la que haces contacto. Tu conciencia se desvanece en un instante... perdida en una agonia infinita.")
	if(!cause)
		cause = "contact"
	fool.visible_message(visible_message,mob_message,span_hear("Escuchas un grito de dolor, que resuena."))
	src.investigate_log("has been attacked ([cause]) by [key_name(fool)]", INVESTIGATE_SUPERMATTER)
	fool.dust(drop_items = TRUE)

/datum/looping_sound/astratanshard_hum
	mid_sounds = list('sound/misc/loops/LightCrystal1.ogg')
	mid_length = 145
	volume = 100
	extra_range = 1
	vary = TRUE

/datum/looping_sound/astratanshard_broken
	mid_sounds = list('sound/misc/loops/LightCrystal2.ogg')
	mid_length = 145
	volume = 100
	extra_range = 1
	vary = TRUE
