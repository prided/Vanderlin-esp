/obj/item/natural/clod/dirt
	name = "terron"
	desc = "Un puñado de cesped."
	icon_state = "clod1"
	pile = /obj/structure/fluff/clodpile/dirt
	clod_type = "dirt"
	item_weight = 1.3 KILOGRAMS

/obj/item/natural/clod/dirt/Initialize()
	. = ..()
	icon_state = "clod[rand(1,2)]"

/obj/structure/fluff/clodpile/dirt
	name = "monton de tierra"
	desc = "Una coleccion de tierra, amalgamada en una poderosa estructura incomparable a cualquier creacion hecha por el hombre o por un dios por igual."
	icon_state = "clodpile"
	dirt_type = /obj/item/natural/clod/dirt
