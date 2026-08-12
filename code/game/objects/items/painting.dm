
/obj/item/painting
	name = "pintura"
	icon_state = "painting"
	desc = ""
	w_class = WEIGHT_CLASS_NORMAL
	dropshrink = 0.65
	static_price = TRUE
	sellprice = 20
	icon = 'icons/roguetown/misc/decoration.dmi'
	item_weight = 1.5 KILOGRAMS
	var/deployed_structure = /obj/structure/fluff/walldeco/painting

/obj/item/painting/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isclosedturf(interacting_with))
		return NONE

	var/direction = get_dir(interacting_with, user)
	if(!(direction in GLOB.cardinals))
		return NONE

	if(!do_after(user, 3 SECONDS, interacting_with))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_warning("Coloco [src] en la pared."))

	var/obj/structure/S = new deployed_structure(user.loc)
	switch(direction)
		if(NORTH)
			S.pixel_y = S.base_pixel_y - 32
		if(SOUTH)
			S.pixel_y = S.base_pixel_y + 32
		if(WEST)
			S.pixel_x = S.base_pixel_x + 32
		if(EAST)
			S.pixel_x = S.base_pixel_x - 32

	qdel(src)

	return ITEM_INTERACT_SUCCESS

/obj/structure/fluff/walldeco/painting
	name = "pintura"
	desc = "El artista es desconocido. El tema es desconocido. Quizas un monumento a un cadaver que fue pisoteado en el camino hacia esta realidad."
	icon = 'icons/roguetown/misc/decoration.dmi'
	icon_state = "painting_deployed"
	anchored = TRUE
	density = FALSE
	resistance_flags = INDESTRUCTIBLE
	layer = ABOVE_MOB_LAYER
	var/stolen_painting = /obj/item/painting

/obj/structure/fluff/walldeco/painting/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(do_after(user, 3 SECONDS, src))
		var/obj/item/I = new stolen_painting(user.loc)
		user.put_in_hands(I)
		qdel(src)
		return

/* Paintings */
/obj/item/painting/queen
	icon_state = "queenpainting"
	desc = "Un retrato de la reina Samantha I de Psydonia. Su repentina desaparicion marco un dia de tragedia y el duelo aun se practica este año."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/queen

/obj/structure/fluff/walldeco/painting/queen
	desc = "Un retrato de la reina Samantha I de Psydonia. Su repentina desaparicion marco un dia de tragedia y el duelo aun se practica este año."
	icon_state = "queenpainting_deployed"
	stolen_painting = /obj/item/painting/queen

/obj/item/painting/seraphina
	icon_state = "seraphinapainting"
	desc = "Un retrato de la santa sacerdote Serafina, primera de su nombre, bendito sea su nombre."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/seraphina

/obj/structure/fluff/walldeco/painting/seraphina
	desc = "Un retrato de la santa sacerdote Serafina, primera de su nombre, bendito sea su nombre."
	icon_state = "seraphinapainting_deployed"
	stolen_painting = /obj/item/painting/seraphina

/obj/item/painting/skull
	icon_state = "skullpainting"
	desc = "Una escena de mal humor que representa una calavera y velas sobre una mesa. Recuerdo mori."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/skull

/obj/structure/fluff/walldeco/painting/skull
	desc = "Una escena de mal humor que representa una calavera y velas sobre una mesa. Recuerdo mori."
	icon_state = "skullpainting_deployed"
	stolen_painting = /obj/item/painting/skull

/obj/item/painting/castle
	icon_state = "castlepainting"
	desc = "Una pintura de una torre oscura que se alza mas alla de las montañas y la niebla."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/castle

/obj/structure/fluff/walldeco/painting/castle
	desc = "Una pintura de una torre oscura que se alza mas alla de las montañas y la niebla."
	icon_state = "castlepainting_deployed"
	stolen_painting = /obj/item/painting/castle

/obj/item/painting/crown
	icon_state = "crownpainting"
	desc = "Una pintura de una corona real apoyada sobre un libro."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/crown

/obj/structure/fluff/walldeco/painting/crown
	desc = "Una pintura de una corona real apoyada sobre un libro."
	icon_state = "crownpainting_deployed"
	stolen_painting = /obj/item/painting/crown
