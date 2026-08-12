/obj/item/reagent_containers/glass/cup
	name = "taza de metal"
	desc = "Una taza de hierro, con el borde roido y sucio."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "cup_iron"
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	fill_icon_thresholds = list(0)
	reagent_flags = TRANSFERABLE | AMOUNT_VISIBLE
	force = 5
	throwforce = 10
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	dropshrink = 0.75
	w_class = WEIGHT_CLASS_NORMAL
	volume = 25
	obj_flags = CAN_BE_HIT
	sellprice = 1
	drinksounds = list('sound/items/drink_cup (1).ogg','sound/items/drink_cup (2).ogg','sound/items/drink_cup (3).ogg','sound/items/drink_cup (4).ogg','sound/items/drink_cup (5).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	gripped_intents = list(INTENT_POUR)
	item_weight = 150 GRAMS

/obj/item/reagent_containers/glass/cup/Initialize(mapload, vol)
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/cup)

/obj/item/reagent_containers/glass/cup/wooden
	name = "taza de madera"
	desc = "Una taza de madera que ha tenido una buena cantidad de uso y peleas de bar."
	icon_state = "cup_wooden"
	resistance_flags = FLAMMABLE
	grid_height = 32
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	metalizer_result = /obj/item/reagent_containers/glass/cup
	item_weight = 80 GRAMS

/obj/item/reagent_containers/glass/cup/steel
	name = "copa"
	desc = "Una copa de acero que tiene algunas abolladuras de peleas anteriores."
	icon_state = "cup_steel"
	sellprice = 10
	item_weight = 180 GRAMS

/obj/item/reagent_containers/glass/cup/silver
	name = "copa de plata"
	desc = "Una copa de plata, cuya superficie esta adornada con intrincados grabados y runas."
	icon_state = "cup_silver"
	dropshrink = 0.65
	sellprice = 30
	last_used = 0
	item_weight = 160 GRAMS

/obj/item/reagent_containers/glass/cup/silver/Initialize(mapload, vol)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/reagent_containers/glass/cup/golden
	name = "copa de oro"
	desc = "Una copa dorada que brilla pateticamente a pesar de su ilustre metal."
	icon_state = "cup_golden"
	dropshrink = 0.65
	sellprice = 50
	item_weight = 200 GRAMS

/obj/item/reagent_containers/glass/cup/skull
	name = "copa de calavera"
	desc = "Las cuencas de los ojos huecas te hablan de rituales oscuros y olvidados."
	icon_state = "cup_skull"
	dropshrink = 0.8
	item_weight = 120 GRAMS

/obj/item/reagent_containers/glass/cup/teacup
	name = "taza de te"
	desc = "Una elegante taza de te hecha de ceramica. Solia ​​​​servir te."
	icon_state = "teacup"
	volume = 25
	dropshrink = 0.7
	fill_icon_state = "teacup"
	sellprice = 10
	item_weight = 100 GRAMS

/obj/item/reagent_containers/glass/cup/teacup/fancy
	name = "taza de te elegante"
	desc = "Una elegante taza de te hecha de ceramica, decorada con un esmalte ornamentado. Solia ​​​​servir te."
	icon_state = "teacup_fancy"
	sellprice = 20

/obj/item/reagent_containers/glass/cup/jade
	name = "copa de joapstone"
	desc = "Una copa sencilla tallada en joapstone."
	dropshrink = null
	icon_state = "cup_jade"
	fill_icon_state = "fancycup"
	sellprice = 55
	item_weight = 250 GRAMS

/obj/item/reagent_containers/glass/cup/turq
	name = "taza de ceruleabaster"
	desc = "Una simple copa tallada en ceruleabaster."
	dropshrink = null
	icon_state = "cup_turq"
	fill_icon_state = "fancycup"
	sellprice = 80
	item_weight = 230 GRAMS

/obj/item/reagent_containers/glass/cup/amber
	name = "copa petriamber"
	desc = "Una copa sencilla tallada en petriamber."
	dropshrink = null
	icon_state = "cup_amber"
	fill_icon_state = "fancycup"
	sellprice = 55
	item_weight = 80 GRAMS

/obj/item/reagent_containers/glass/cup/coral
	name = "taza de aoetal"
	desc = "Una copa sencilla tallada en aoetal."
	dropshrink = null
	icon_state = "cup_coral"
	fill_icon_state = "fancycup"
	sellprice = 65
	item_weight = 200 GRAMS

/obj/item/reagent_containers/glass/cup/onyxa
	name = "taza de onyxa"
	desc = "Una taza simple tallada en onyxa."
	dropshrink = null
	icon_state = "cup_onyxa"
	fill_icon_state = "fancycup"
	sellprice = 35
	item_weight = 150 GRAMS

/obj/item/reagent_containers/glass/cup/shell
	name = "taza de concha"
	desc = "Una taza sencilla tallada en concha."
	dropshrink = null
	icon_state = "cup_shell"
	fill_icon_state = "fancycup"
	sellprice = 15
	item_weight = 100 GRAMS

/obj/item/reagent_containers/glass/cup/opal
	name = "copa opaloise"
	desc = "Una taza sencilla tallada en opaloise."
	dropshrink = null
	icon_state = "cup_opal"
	fill_icon_state = "fancycup"
	sellprice = 85
	item_weight = 180 GRAMS

/obj/item/reagent_containers/glass/cup/rose
	name = "taza de rosellusk"
	desc = "Un simple vaso tallado de rosellusk."
	dropshrink = null
	icon_state = "cup_rose"
	fill_icon_state = "fancycup"
	sellprice = 20
	item_weight = 120 GRAMS

/obj/item/reagent_containers/glass/cup/jadefancy
	name = "copa de joapstone elegante"
	desc = "Una elegante copa tallada en joapstone."
	dropshrink = null
	icon_state = "fancycup_jade"
	fill_icon_state = "fancycup"
	sellprice = 65
	item_weight = 250 GRAMS

/obj/item/reagent_containers/glass/cup/turqfancy
	name = "Taza de ceruleabaster elegante"
	desc = "Una taza elegante tallada de ceruleabaster."
	dropshrink = null
	icon_state = "fancycup_turq"
	fill_icon_state = "fancycup"
	sellprice = 90
	item_weight = 230 GRAMS

/obj/item/reagent_containers/glass/cup/opalfancy
	name = "elegante taza opaloise"
	desc = "Una elegante taza tallada en opaloise."
	dropshrink = null
	icon_state = "fancycup_opal"
	fill_icon_state = "fancycup"
	sellprice = 95
	item_weight = 180 GRAMS

/obj/item/reagent_containers/glass/cup/coralfancy
	name = "taza elegante de aoetal"
	desc = "Una elegante taza tallada en aoetal."
	dropshrink = null
	icon_state = "fancycup_coral"
	fill_icon_state = "fancycup"
	sellprice = 75
	item_weight = 200 GRAMS

/obj/item/reagent_containers/glass/cup/amberfancy
	name = "taza elegante de petriamber"
	desc = "Una elegante copa tallada en petriamber."
	dropshrink = null
	icon_state = "fancycup_amber"
	fill_icon_state = "fancycup"
	sellprice = 65
	item_weight = 80 GRAMS

/obj/item/reagent_containers/glass/cup/shellfancy
	name = "taza de concha elegante"
	desc = "Una elegante taza tallada en concha."
	dropshrink = null
	icon_state = "fancycup_shell"
	fill_icon_state = "fancycup"
	sellprice = 25
	item_weight = 100 GRAMS

/obj/item/reagent_containers/glass/cup/rosefancy
	name = "Taza de rosellusk elegante"
	desc = "Una copa elegante tallada en rosellusk."
	dropshrink = null
	icon_state = "fancycup_rose"
	fill_icon_state = "fancycup"
	sellprice = 30
	item_weight = 120 GRAMS

/obj/item/reagent_containers/glass/cup/onyxafancy
	name = "taza elegante de onyxa"
	desc = "Una taza elegante tallada de onyxa."
	dropshrink = null
	icon_state = "fancycup_onyxa"
	fill_icon_state = "fancycup"
	sellprice = 45
	item_weight = 150 GRAMS

/obj/item/reagent_containers/glass/cup/cocaudo_husk
	name = "cascara de cocaudo"
	desc = "La mitad ahuecada de un cocaudo. Contiene liquido."
	icon_state = "cocaudo_empty"
	dropshrink = 1
	fill_icon_state = "cocaudo_empty"
	grid_height = 32
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	item_weight = 200 GRAMS

/obj/item/reagent_containers/glass/cup/clay
	name = "taza de barro"
	desc = "Taza hecha de barro cocido."
	icon = 'icons/obj/handmade/cup.dmi'
	icon_state = "world"
	dropshrink = 1
	sellprice = 5
	item_weight = 120 GRAMS

/obj/item/reagent_containers/glass/cup/clay/set_material_information()
	. = ..()
	name = "Taza de arcilla [LOWER_TEXT(initial(main_material.name))]"

/obj/item/reagent_containers/glass/cup/fancy_clay
	name = "taza de arcilla elegante"
	desc = "Taza hecha de barro cocido."
	icon = 'icons/obj/handmade/cup_fancy.dmi'
	icon_state = "world"
	dropshrink = 1
	item_weight = 130 GRAMS

/obj/item/reagent_containers/glass/cup/fancy_clay/set_material_information()
	. = ..()
	name = "[LOWER_TEXT(initial(main_material.name))] taza de arcilla elegante"

/obj/item/reagent_containers/glass/cup/clay_mug
	name = "taza de arcilla"
	desc = "Taza hecha de barro cocido."
	icon = 'icons/obj/handmade/mug.dmi'
	icon_state = "world"
	dropshrink = 1
	item_weight = 150 GRAMS

/obj/item/reagent_containers/glass/cup/clay_mug/set_material_information()
	. = ..()
	name = "Taza de arcilla [LOWER_TEXT(initial(main_material.name))]"

// ----- Glassware -----

/obj/item/reagent_containers/glass/cup/glassware
	name = "taza de cristal"
	desc = "Una elegante copa de cristal; los pocos rasguños que tiene cuentan grandes historias de mentiras y traicion. Suele romperse con facilidad..."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	icon_state = "clear_cup1"
	reagent_flags = OPENCONTAINER
	sellprice = VALUE_COMMON_GOODS * 2
	dropshrink = 1
	max_integrity = 5
	volume = 25
	fill_icon_thresholds = list(0, 10, 50, 100)
	grid_width = 32
	grid_height = 64
	item_weight = 80 GRAMS

/obj/item/reagent_containers/glass/cup/glassware/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	var/turf/location = get_turf(src)
	playsound(location, "glassbreak", 100, TRUE)
	new /obj/effect/decal/cleanable/debris/glass (location)
	var/obj/item/natural/glass/shard/bottleshard = new(location)
	bottleshard.pixel_x = bottleshard.base_pixel_x + rand(-6,6)
	bottleshard.pixel_y = bottleshard.base_pixel_y + rand(-6,6)
	// If someone got hit- wound them with the glass shard
	if(ishuman(hit_atom))
		var/mob/living/carbon/victim = hit_atom
		var/mob/thrown_by = thrownby?.resolve()
		var/obj/item/bodypart/affecting = victim.get_bodypart(check_zone(thrown_by.zone_selected))
		if(!affecting)
			affecting = victim.get_bodypart(pickweight(list(BODY_ZONE_HEAD = 1, BODY_ZONE_CHEST = 1, BODY_ZONE_L_ARM = 4, BODY_ZONE_R_ARM = 4, BODY_ZONE_L_LEG = 4, BODY_ZONE_R_LEG = 4)))
		affecting.add_embedded_object(bottleshard)
		if(prob(50))
			affecting.try_crit(pickweight(list(BCLASS_STAB = 1, BCLASS_PICK = 2, BCLASS_CUT = 5)), 85) // Bottles are quite expensive and not very many people can make them- they're also made of glass...
	qdel(src)

/obj/item/reagent_containers/glass/cup/glassware/shotglass
	name = "vaso de chupito"
	desc = "Un vaso de chupito elegante; los pocos rasguños que tiene cuentan grandes historias de mentiras y traicion. Suele romperse con facilidad..."
	icon_state = "clear_shotglass1"
	sellprice = VALUE_COMMON_GOODS * 1.5
	volume = 5 //You drink 5 units at a time, now its an ACTUAL shot.
	grid_height = 32
	item_weight = 40 GRAMS

/obj/item/reagent_containers/glass/cup/glassware/wineglass
	name = "copa de vino"
	desc = "Una copa de vino elegante; los pocos rasguños que tiene cuentan grandes historias de mentiras y traicion. Suele romperse con facilidad..."
	icon_state = "clear_wineglass1"
	item_weight = 60 GRAMS
