
/obj/effect/decal/cleanable/food
	icon = 'icons/effects/tomatodecal.dmi'
	gender = NEUTER
	beauty = -100
	clean_type = CLEAN_TYPE_HARD_DECAL

/obj/effect/decal/cleanable/food/tomato_smudge
	name = "mancha de tomate"
	desc = ""
	icon_state = "tomato_floor1"
	random_icon_states = list("tomato_floor1", "tomato_floor2", "tomato_floor3")

/obj/effect/decal/cleanable/food/plant_smudge
	name = "mancha de planta"
	desc = ""
	icon_state = "smashed_plant"

/obj/effect/decal/cleanable/food/egg_smudge
	name = "huevo roto"
	desc = ""
	icon_state = "smashed_egg1"
	random_icon_states = list("smashed_egg1", "smashed_egg2", "smashed_egg3")
	alpha = 200

/obj/effect/decal/cleanable/food/pie_smudge //honk
	name = "pastel aplastado"
	desc = ""
	icon_state = "smashed_pie"

/obj/effect/decal/cleanable/food/salt
	name = "pila de sal"
	desc = ""
	icon_state = "salt_pile"
	clean_type = CLEAN_TYPE_LIGHT_DECAL

/atom/proc/salt_act()
	return

/obj/effect/decal/cleanable/food/salt/Initialize(mapload)
	. = ..()
	for(var/atom/movable/AM in loc)
		AM.salt_act()

/obj/effect/decal/cleanable/food/flour
	name = "flour"
	desc = ""
	icon_state = "flour"
	clean_type = CLEAN_TYPE_LIGHT_DECAL

