/obj/item/explosive/deathshell
	name = "carga mortal"
	desc = "Un cilindro liso y brillante, de color y material bronce, con una hendidura estilizada en la parte superior que parece un boton. En su interior se oye un tic tac arcaico que anuncia la perdicion de quienes se atrevan a desafiar el arte de Malum.  Conocido como ´La Hacedora de Viudas´ entre los artifices por el riesgo de fabricar estos explosivos, que suelen causar amputaciones traumaticas y la muerte."
	icon_state = "deathshell"
	icon = 'icons/obj/bombs.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	grid_height = 64
	grid_width = 32
	impact_explode = FALSE

	prob2fail = 25

	ex_dev = 1
	ex_heavy = 3
	ex_light = 2
	ex_flame = 1

	shrapnel_type = /obj/projectile/bullet/shrap
	shrapnel_radius = 5
	det_time = 10 SECONDS
