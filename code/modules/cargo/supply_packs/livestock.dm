/datum/supply_pack/livestock
	group = "Livestock"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant
	abstract_type = /datum/supply_pack/livestock

/datum/supply_pack/livestock/saiga
	name = "Saigabuck"
	cost = 120
	contains = list(
					/mob/living/simple_animal/hostile/retaliate/saigabuck/tame/saddled,
				)


/datum/supply_pack/livestock/chicken
	name = "Pollo"
	cost = 25
	contains = list(
					/mob/living/simple_animal/hostile/retaliate/chicken,
				)

/datum/supply_pack/livestock/cow
	name = "Vaca"
	cost = 80
	contains = list(
					/mob/living/simple_animal/hostile/retaliate/cow,
				)

/datum/supply_pack/livestock/goat
	name = "Cabra"
	cost = 45
	contains = list(
					/mob/living/simple_animal/hostile/retaliate/goat,
				)

/datum/supply_pack/livestock/cat
	name = "Gato"
	cost = 25
	contains = list(
					/mob/living/simple_animal/pet/cat,
				)

/datum/supply_pack/livestock/pig
	name = "Cerdo"
	cost = 65
	contains = list(
					/mob/living/simple_animal/hostile/retaliate/trufflepig,
				)
