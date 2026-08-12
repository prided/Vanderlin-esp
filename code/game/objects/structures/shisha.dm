/obj/structure/fluff/statue/shisha
	name = "pipa shisha"
	desc = "Una shisha tradicional. Parece que se puede envasar y fumar."
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "zbuski"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	blade_dulling = DULLING_BASH
	max_integrity = 300
	SET_BASE_PIXEL(-10, 0)

	var/datum/reagents/liquid_contents
	var/liquid_max_volume = 100

	var/obj/item/bowl_contents = null
	var/bowl_reagent_amount = 20

	var/smoke_interval = 8
	var/smoke_timer = 0

	var/mob/living/current_smoker = null

	var/puffs_remaining = 0
	var/puffs_per_pack_base = 24
	var/puffs_per_coal = 8

	var/list/loaded_coals = list()
	var/list/coal_puff_counts = list()
	var/max_coals = 3


/obj/structure/fluff/statue/shisha/Initialize(mapload)
	. = ..()
	liquid_contents = new /datum/reagents(liquid_max_volume)
	liquid_contents.my_atom = src


/obj/structure/fluff/statue/shisha/Destroy()
	QDEL_NULL(liquid_contents)
	if(bowl_contents)
		qdel(bowl_contents)
		bowl_contents = null
	for(var/obj/item/ore/coal/C in loaded_coals)
		qdel(C)
	loaded_coals.Cut()
	coal_puff_counts.Cut()
	stop_smoking()
	return ..()


/obj/structure/fluff/statue/shisha/examine(mob/user)
	. = ..()
	if(length(loaded_coals))
		. += span_notice("Tiene [length(loaded_coals)] carbon\s cargado en la parte superior.")
	else
		. += span_warning("No hay carbon cargado. Añade algo de carbon de mineral para calentar el recipiente.")
	if(bowl_contents)
		. += span_notice("El bol esta lleno de [bowl_contents.name]. ([puffs_remaining] bocanadas restantes.)")
	else
		. += span_warning("El tazon esta vacio.")
	if(liquid_contents.total_volume > 0)
		. += span_notice("La base contiene [liquid_contents.total_volume]u de liquido.")
	else
		. += span_warning("La base esta seca.")
	if(current_smoker)
		. += span_notice("[current_smoker.name] esta humeando.")
	else
		. += span_notice("Haz clic en el para fumar.")


/obj/structure/fluff/statue/shisha/attack_hand(mob/living/user, list/modifiers)
	if(!user.Adjacent(src))
		return

	if(current_smoker == user)
		stop_smoking()
		to_chat(user, span_notice("Te alejas del [name]."))
		return

	if(current_smoker)
		to_chat(user, span_warning("[current_smoker.name] ya esta utilizando el [name]."))
		return

	if(!length(loaded_coals))
		to_chat(user, span_warning("No hay carbon cargado. Coloca primero algo de carbon encima."))
		return

	if(!bowl_contents || puffs_remaining <= 0)
		to_chat(user, span_warning("El tazon esta vacio. ¡Logalo primero con algo!"))
		return

	if(liquid_contents.total_volume <= 0)
		to_chat(user, span_warning("La base esta seca. Añade un poco de liquido primero."))
		return

	start_smoking(user)


/obj/structure/fluff/statue/shisha/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/ore/coal))
		if(length(loaded_coals) >= max_coals)
			to_chat(user, span_warning("La hookah ya tiene [max_coals] carbones cargados. Eso es lo maximo."))
			return
		user.transferItemToLoc(I, src)
		loaded_coals += I
		coal_puff_counts[I] = 0
		puffs_remaining = bowl_contents ? calc_puffs() : 0
		to_chat(user, span_notice("Coloques el carbon encima del narguile. ([length(loaded_coals)]/[max_coals] carbones)"))
		return

	if(istype(I, /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/container = I
		if(!container.is_open_container())
			return
		if(liquid_contents.total_volume >= liquid_max_volume)
			to_chat(user, span_warning("La base ya esta llena."))
			return
		I.reagents.trans_to(liquid_contents, min(I.reagents.total_volume, liquid_max_volume - liquid_contents.total_volume))
		to_chat(user, span_notice("Vapora liquido en la base del [name]."))
		return

	if(istype(I, /obj/item/reagent_containers/powder))
		if(bowl_contents)
			to_chat(user, span_warning("El recipiente ya esta lleno. Valalo primero."))
			return
		user.transferItemToLoc(I, src)
		bowl_contents = I
		puffs_remaining = calc_puffs()
		to_chat(user, span_notice("Usted llena el recipiente con [I.name]."))
		return

	if(istype(I, /obj/item/reagent_containers/food/snacks))
		if(bowl_contents)
			to_chat(user, span_warning("El recipiente ya esta lleno. Valalo primero."))
			return
		user.transferItemToLoc(I, src)
		bowl_contents = I
		puffs_remaining = calc_puffs()
		to_chat(user, span_notice("Trituras [I.name] en el tazon de [name]."))
		return

	return ..()


/obj/structure/fluff/statue/shisha/proc/calc_puffs()
	var/n = length(loaded_coals)
	return max(puffs_per_pack_base - ((n - 1) * 2), 2)


/obj/structure/fluff/statue/shisha/proc/empty_bowl(mob/living/user)
	if(!bowl_contents)
		to_chat(user, span_warning("El cuenco ya esta vacio."))
		return
	bowl_contents.forceMove(get_turf(src))
	bowl_contents = null
	puffs_remaining = 0
	to_chat(user, span_notice("Vacias el recipiente del [name]."))


/obj/structure/fluff/statue/shisha/proc/start_smoking(mob/living/user)
	current_smoker = user
	var/n = length(loaded_coals)
	var/heat_desc = n >= 3 ? "feroz" : n == 2 ? "comodo" : "amable"
	to_chat(user, span_notice("Te acomodas y das un trago del [name]. El calor de las [heat_desc] brasas calienta el recipiente."))
	visible_message(span_notice("[user.name] comienza a fumar el [name]."))
	AddComponent(/datum/component/rope, user, \
		icon = 'icons/effects/beam.dmi', \
		icon_state = "shisha", \
		maximum_rope_distance = 3, \
		rope_broken_callback = CALLBACK(src, PROC_REF(on_rope_broken)), \
		override_origin_pixel_x = 10, \
		override_origin_pixel_y = 20)
	START_PROCESSING(SSobj, src)
	icon_state = "zbuski-smoker"


/obj/structure/fluff/statue/shisha/proc/stop_smoking()
	if(!current_smoker)
		return
	var/mob/living/was_smoker = current_smoker
	current_smoker = null
	STOP_PROCESSING(SSobj, src)
	qdel(GetComponent(/datum/component/rope))
	visible_message(span_notice("[was_smoker.name] se aleja de [name]."))
	icon_state = "zbuski"


/obj/structure/fluff/statue/shisha/proc/on_rope_broken()
	if(current_smoker)
		to_chat(current_smoker, span_warning("Te alejas demasiado del [name] y pierdes tu turno."))
	stop_smoking()


/obj/structure/fluff/statue/shisha/process(delta_time)
	if(!current_smoker || !bowl_contents)
		stop_smoking()
		return PROCESS_KILL

	smoke_timer += delta_time
	if(smoke_timer < smoke_interval)
		return

	smoke_timer = 0
	deliver_puff()


/obj/structure/fluff/statue/shisha/proc/deliver_puff()
	if(!bowl_contents || puffs_remaining <= 0)
		to_chat(current_smoker, span_warning("La taza se ha quemado."))
		stop_smoking()
		return

	var/n = length(loaded_coals)

	if(n >= 3 && prob(25))
		to_chat(current_smoker, span_warning("¡El carbon esta demasiado caliente, un golpe abrasador te quema la garganta!"))
		current_smoker.adjustOrganLoss(ORGAN_SLOT_LUNGS, 5)
	else if(n == 2 && prob(8))
		to_chat(current_smoker, span_warning("Un golpe un poco fuerte te golpea en la parte posterior de la garganta."))
		current_smoker.adjustOrganLoss(ORGAN_SLOT_LUNGS, 2)

	if(bowl_contents.reagents && bowl_contents.reagents.total_volume > 0)
		var/coal_bonus = (n - 1) * 5
		var/transfer_amount = min(bowl_reagent_amount + coal_bonus, bowl_contents.reagents.total_volume)
		bowl_contents.reagents.trans_to(current_smoker, transfer_amount, method = INGEST)

	if(liquid_contents && liquid_contents.total_volume > 0)
		var/liquid_transfer = min(5, liquid_contents.total_volume)
		liquid_contents.trans_to(current_smoker, liquid_transfer, method = INGEST)

	puffs_remaining--

	var/turf/T = get_turf(current_smoker)
	T.pollute_turf(/datum/pollutant/smoke, 120 + (n * 40))

	if(n >= 3)
		to_chat(current_smoker, span_notice("Das un profundo y intenso trago. El rico humo inunda tus pulmones."))
		visible_message(span_notice("[current_smoker.name] exhala una espesa nube de humo."))
	else if(n == 2)
		to_chat(current_smoker, span_notice("Tomas una suave y completa calada del [name]. El humo fragante llena tus pulmones."))
		visible_message(span_notice("[current_smoker.name] exhala una nube constante de humo."))
	else
		to_chat(current_smoker, span_notice("Das una calada suave y ligera en el [name]. Una ligera nube de humo perfumado se desliza a traves de el."))
		visible_message(span_notice("[current_smoker.name] exhala una fina rafaga de humo."))

	// tick the oldest coal and delete it if spent
	if(length(loaded_coals))
		var/obj/item/ore/coal/C = loaded_coals[1]
		coal_puff_counts[C]++
		if(coal_puff_counts[C] >= puffs_per_coal)
			coal_puff_counts.Remove(C)
			loaded_coals.Remove(C)
			qdel(C)
			to_chat(current_smoker, span_warning("El carbon se quema y se desmorona. ([length(loaded_coals)]/[max_coals] restante)"))
			if(!length(loaded_coals))
				to_chat(current_smoker, span_warning("El ultimo carbon se apaga. El recipiente se enfria."))
				stop_smoking()
				return

	if(puffs_remaining <= 0)
		to_chat(current_smoker, span_warning("La taza se quema. Es hora de volver a empaquetar."))
		if(bowl_contents)
			qdel(bowl_contents)
			bowl_contents = null
		stop_smoking()
