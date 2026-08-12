
/obj/item/reagent_containers/food/snacks/egg
	name = "egg"
	desc = "Tambien conocido como cackleberries entre los campesinos."
	icon_state = "egg"
	list_reagents = list(/datum/reagent/consumable/eggyolk = 5)
	filling_color = "#F0E68C"
	foodtype = MEAT
	grind_results = list()
	rotprocess = SHELFLIFE_DECENT
	become_rot_type = /obj/item/reagent_containers/food/snacks/rotten/egg
	cooktime = 20 SECONDS
	var/fertile = FALSE

/obj/item/reagent_containers/food/snacks/egg/Initialize(mapload)
	. = ..()
	icon_state = pick("egg","eggB")

/obj/item/reagent_containers/food/snacks/egg/become_rotten()
	. = ..()
	if(.)
		fertile = FALSE

/obj/item/reagent_containers/food/snacks/egg/Crossed(mob/living/carbon/human/H)
	..()
	if(istype(H))
		var/turf/T = get_turf(src)
		var/obj/O = new /obj/effect/decal/cleanable/food/egg_smudge(T)
		O.pixel_x = O.base_pixel_x + rand(-8,8)
		O.pixel_y = O.base_pixel_y + rand(-8,8)
		visible_message("<span class='warning'>[H] aplasta [src] bajo sus pies.</span>")
		qdel(src)

/obj/item/reagent_containers/food/snacks/egg/proc/hatch(mob/living/simple_animal/hostile/retaliate/chicken/parent, mob/living/simple_animal/hostile/retaliate/chicken/father)
	record_round_statistic(STATS_ANIMALS_BRED)
	var/mob/living/simple_animal/hostile/retaliate/chicken/chick/new_chick = new /mob/living/simple_animal/hostile/retaliate/chicken/chick(get_turf(parent))
	SEND_SIGNAL(parent, COMSIG_FRIENDSHIP_PASS_FRIENDSHIP, new_chick)
	SEND_SIGNAL(parent, COMSIG_HAPPINESS_PASS_HAPPINESS, new_chick)
	if(parent.genetics && !ispath(parent.genetics))
		parent.genetics.inherit_to(new_chick, father)
