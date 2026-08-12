//Fluff structures serve no purpose and exist only for enriching the environment. They can be destroyed with a wrench.

/obj/structure/well
	name = "pozo"
	desc = "Un pozo de piedra. Tiene un gancho al que se le puede acoplar un cubo para sacar agua de debajo."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "welly"
	anchored = TRUE
	density = TRUE
	opacity = FALSE
	climb_time = 40
	climbable = TRUE
	layer = 2.91
	damage_deflection = 30
	var/well_climb = FALSE

/obj/structure/well/climb_down
	desc = "Un pozo de piedra. Tiene un gancho al que se le puede acoplar un cubo para sacar agua de debajo. Parece que puedes bajar por este."
	well_climb = "DOWN"

/obj/structure/well/climb_up
	name = "cuerda de cubo"
	desc = "Una cuerda en el fondo de un pozo, puedes trepar por ella si quieres."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "rope"
	well_climb = "UP"
	density = FALSE
	layer = 4

/obj/structure/well/fountain
	name = "fuente de agua"
	desc = "Una fuente elegante digna de la realeza. No apto para beber."
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "fountain"
	layer = BELOW_MOB_LAYER
	layer = -0.1

/obj/structure/well/fountain/onbite(mob/living/user)
	. = ..()
	if(.)
		return
	playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
	user.visible_message(span_info("[user] comienza a beber de [src]."))
	if(do_after(user, 2.5 SECONDS, src))
		drink_from(user)
	return TRUE

/obj/structure/well/fountain/proc/drink_from(mob/living/user)
	var/datum/reagents/reagents = new()
	reagents.add_reagent(/datum/reagent/water/gross, 2)
	reagents.trans_to(user, reagents.total_volume, transfered_by = user, method = INGEST)
	playsound(user,pick('sound/items/drink_gen (1).ogg','sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg'), 100, TRUE)

/obj/structure/well/attackby(obj/item/I, mob/user, list/modifiers)
	if(istype(I, /obj/item/reagent_containers/glass/bucket))
		var/obj/item/reagent_containers/glass/bucket/W = I
		if(W.reagents.holder_full())
			to_chat(user, "<span class='warning'>[W] esta lleno.</span>")
			return
		if(do_after(user, 6 SECONDS, src))
			var/list/waterl = list(/datum/reagent/water = 100)
			W.reagents.add_reagent_list(waterl)
			to_chat(user, "<span class='notice'>Relleno [W] desde [src].</span>")
			playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 80, FALSE)
			return
	else ..()

/obj/structure/well/MouseDrop_T(obj/O, mob/user)
	. = ..()
	// this is mostly a copy paste of the ladder code-ish
	if(well_climb == FALSE)
		return
	if(!in_range(src, user))
		return
	playsound(src, 'sound/foley/ladder.ogg', 100, FALSE)
	if(!do_after(user, 3 SECONDS, src))
		return
	user.visible_message("<span class='notice'>[user] desciende por [src].</span>", "<span class='notice'>Me bajo de [src].</span>")
	src.add_fingerprint(user)
	var/turf/well = get_turf(src)
	var/turf/destination = locate(well.x, well.y, well.z)
	if(well_climb == "DOWN")
		destination = locate(well.x, well.y, well.z - 1)
	else
		destination = locate(well.x, well.y, well.z + 1)
	user.zMove(target = destination, z_move_flags = ZMOVE_LADDER_FLAGS)
