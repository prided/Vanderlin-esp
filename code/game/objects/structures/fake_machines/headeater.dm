
/obj/structure/fake_machine/headeater
	name = "\improper DEVORACABEZAS"
	desc = "Una maquina que se alimenta de determinadas cabezas de moneda. Vale mas que venderlo al comerciante."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "headeater"
	density = FALSE
	lock = /datum/lock/key/hailer
	blade_dulling = DULLING_BASH
	SET_BASE_PIXEL(0, 32)

/obj/structure/fake_machine/headeater/r
	SET_BASE_PIXEL(32, 0)

/obj/structure/fake_machine/headeater/l
	SET_BASE_PIXEL(-32, 0)

/obj/structure/fake_machine/headeater/attackby(obj/item/I, mob/user, list/modifiers)
	if(!is_type_in_list(I, list(/obj/item/natural/head, /obj/item/bodypart/head)))
		return ..()
	if(locked())
		to_chat(user, span_warning("Esta bloqueado. Por supuesto."))
		return
	if(I.sellprice <= 0)
		to_chat(user, span_warning("[I] no vale la pena vender."))
		return

	visible_message(span_notice("[src] consume [I], escupiendo una recompensa."), vision_distance = COMBAT_MESSAGE_RANGE)
	playsound(src, 'sound/gore/flesh_eat_03.ogg', 100,)
	var/reward = round(I.sellprice * 1.25)
	budget2change(reward, user)
	record_round_statistic(STATS_HEADEATER_EXPORTS, reward)
	qdel(I)
