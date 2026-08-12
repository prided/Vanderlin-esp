/obj/item/ore
	name = "mineral"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ore"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	grid_width = 32
	grid_height = 32
	melt_amount = 100
	recipe_quality = SMELTERY_QUALITY_NORMAL
	var/atom/mill_result // What this ore becomes when milled

/obj/item/ore/set_quality(quality)
	. = ..()
	// Quality affects melt amount
	var/quality_multiplier = 1.0
	switch(recipe_quality)
		if(SMELTERY_QUALITY_GOOD)
			quality_multiplier = 1.15
		if(SMELTERY_QUALITY_GREAT)
			quality_multiplier = 1.3
		if(SMELTERY_QUALITY_EXCELLENT)
			quality_multiplier = 1.45

	melt_amount = round(initial(melt_amount) * quality_multiplier)

/obj/item/ore/gold
	name = "oro crudo"
	icon_state = "oregold1"
	smeltresult = /obj/item/ingot/gold
	melting_material = /datum/material/gold
	sellprice = 10
	item_weight = 10.1 KILOGRAMS
	mill_result = /obj/item/ore/dust/gold

/obj/item/ore/gold/Initialize(mapload)
	. = ..()
	icon_state = "oregold[rand(1,3)]"

/obj/item/ore/silver
	name = "plata cruda"
	icon_state = "oresilv1"
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver
	sellprice = 8
	item_weight = 5.5 KILOGRAMS
	mill_result = /obj/item/ore/dust/silver

/obj/item/ore/silver/Initialize(mapload)
	. = ..()
	icon_state = "oresilv[rand(1,3)]"
	enchant(/datum/enchantment/silver)

/obj/item/ore/iron
	name = "hierro crudo"
	icon_state = "oreiron1"
	smeltresult = /obj/item/ingot/iron
	melting_material = /datum/material/iron
	sellprice = 5
	item_weight = 4.15 KILOGRAMS
	mill_result = /obj/item/ore/dust/iron

/obj/item/ore/iron/Initialize(mapload)
	. = ..()
	icon_state = "oreiron[rand(1,3)]"

/obj/item/ore/copper
	name = "cobre crudo"
	icon_state = "orecop1"
	smeltresult = /obj/item/ingot/copper
	melting_material = /datum/material/copper
	sellprice = 2
	item_weight = 4.7 KILOGRAMS
	mill_result = /obj/item/ore/dust/copper

/obj/item/ore/copper/Initialize(mapload)
	. = ..()
	icon_state = "orecop[rand(1,3)]"

/obj/item/ore/tin
	name = "estaño crudo"
	desc = "Una masa de mineral blanco blando, casi maleable."
	icon_state = "oretin1"
	smeltresult = /obj/item/ingot/tin
	melting_material = /datum/material/tin
	sellprice = 4
	item_weight = 3.8 KILOGRAMS
	mill_result = /obj/item/ore/dust/tin

/obj/item/ore/tin/Initialize(mapload)
	. = ..()
	icon_state = "oretin[rand(1,3)]"

/obj/item/ore/coal
	name = "carbon"
	icon_state = "orecoal1"
	firefuel = 10 MINUTES
	smeltresult = /obj/item/ore/coal
	melting_material = /datum/material/coke
	melt_amount = 100
	sellprice = 1
	item_weight = 1.8 KILOGRAMS

/obj/item/ore/coal/Initialize(mapload)
	. = ..()
	icon_state = "orecoal[rand(1,3)]"

/obj/item/ore/cinnabar
	name = "cinabrio"
	desc = "Gemas rojas que contienen la esencia del mercurio."
	icon_state = "orecinnabar"
	grind_results = list(/datum/reagent/mercury = 15)
	sellprice = 5
	item_weight = 4.2 KILOGRAMS
	indexed = TRUE

/obj/item/ore/coal/charcoal
	name = "carbon"
	icon_state = "oreada"
	desc = "Trozos de madera quemados."
	dropshrink = 0.8
	color = "#929292"
	firefuel = 30 MINUTES
	smeltresult = /obj/item/ore/coal/charcoal
	sellprice = 1


/* ............Black Briar............ */

/obj/item/ore/cursedrosa
	name = "rosa de zarza negra"
	icon_state = "cursedrosa"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK|ITEM_SLOT_MOUTH
	item_weight = 4.7 KILOGRAMS
	sellprice = 10

	embedding = list(
		"embed_chance" = 0.1, // we're cheating to make these embed items so if this happens tough luck
		"embedded_pain_multiplier" = 0,
		"embedded_fall_chance" = 0,
	)

	max_integrity = 500
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/cursedrosa
	attacked_sound = list('sound/combat/hits/armor/chain_slashed (1).ogg', 'sound/combat/hits/armor/chain_slashed (2).ogg', 'sound/combat/hits/armor/chain_slashed (3).ogg')

/obj/item/ore/cursedrosa/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_MOUTH)
		icon_state = "cursedrosa_mouth"
	else
		icon_state = "cursedrosa"

/obj/item/ore/cursedrosa/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cursedrosa, FALSE, TRUE)

/obj/item/ore/cursedrosa/examine(mob/user)
	. = ..()
	if(GetComponent(/datum/component/cursedrosa))
		. += span_briar("Sus espinas no han sido recortadas.")
	else
		. += span_info("Sus espinas han sido recortadas.")

/obj/item/ore/cursedrosa/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.cmode)
		return NONE

	if(!(tool.tool_behaviour == TOOL_KNIFE))
		return NONE

	var/datum/component/thorns = GetComponent(/datum/component/cursedrosa)
	if(QDELETED(thorns))
		to_chat(user, span_warning("No tiene espinas para cortar."))
	else
		user.visible_message(span_notice("[user] corta las espinas de [src]."), span_notice("Recorto las espinas de [src]."))
		playsound(tool, 'sound/items/flint.ogg', 100, TRUE)
		qdel(thorns)

	return ITEM_INTERACT_SUCCESS

/* ............Ingots............ */
/obj/item/ingot
	name = "lingote"
	desc = "Una barra matriz de metal. Si ves esto, informalo en github."
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ingot"
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null
	resistance_flags = FIRE_PROOF

	grid_width = 64
	grid_height = 32
	melt_amount = 100
	recipe_quality = SMELTERY_QUALITY_NORMAL

/obj/item/ingot/examine()
	. += ..()

/obj/item/ingot/Initialize(mapload, smelt_quality)
	. = ..()
	if(smelt_quality)
		recipe_quality = smelt_quality
		var/datum/quality_calculator/metallurgy/metal_calc = new()
		metal_calc.apply_quality_to_item(src, TRUE, recipe_quality)
		qdel(metal_calc)

/obj/item/ingot/attack_hand_secondary(mob/user, list/modifiers)
	if(currecipe)
		to_chat(user, span_notice("Usted comienza a cancelar la receta de \the [currecipe.name]."))
		if(do_after(user, 5 SECONDS, src, display_over_user = TRUE))
			QDEL_NULL(currecipe)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	. = ..()

/obj/item/ingot/Destroy()
	if(istype(loc, /obj/machinery/anvil))
		var/obj/machinery/anvil/A = loc
		A.working_material = null
		A.update_appearance(UPDATE_OVERLAYS)
	return ..()

/obj/item/ingot/gold
	name = "barra de oro"
	desc = "Una barra de oro brillante."
	icon_state = "ingotgold"
	smeltresult = /obj/item/ingot/gold
	melting_material = /datum/material/gold
	sellprice = M_GOLD
	item_weight = 12.25 KILOGRAMS

/obj/item/ingot/iron
	name = "barra de hierro"
	desc = "Una barra de hierro forjado."
	icon_state = "ingotiron"
	smeltresult = /obj/item/ingot/iron
	melting_material = /datum/material/iron
	sellprice = M_IRON
	item_weight = 5 KILOGRAMS

/obj/item/ingot/thaumic
	name = "barra de hierro taumico"
	desc = "Una barra de hierro forjado templado con esencia de fuego."
	icon_state = "infused_iron"
	icon = 'icons/roguetown/misc/alchemy.dmi'
	smeltresult = /obj/item/ingot/thaumic
	melting_material = /datum/material/thaumic_iron
	sellprice = M_IRON
	item_weight = 5 KILOGRAMS

/obj/item/ingot/copper
	name = "barra de cobre"
	desc = "Una barra de cobre."
	icon_state = "ingotcop"
	smeltresult = /obj/item/ingot/copper
	melting_material = /datum/material/copper
	sellprice = M_IRON * 0.5
	item_weight = 5.7 KILOGRAMS

/obj/item/ingot/tin
	name = "barra de estaño"
	desc = "Un lingote de esencia extrañamente suave y maleable."
	icon_state = "ingottin"
	smeltresult = /obj/item/ingot/tin
	melting_material = /datum/material/tin
	sellprice = M_IRON * 0.75
	item_weight = 4.6 KILOGRAMS

/obj/item/ingot/bronze
	name = "barra de bronce"
	desc = "Una aleacion dura y duradera preferida tanto por los ingenieros como por los seguidores de Malum."
	icon_state = "ingotbronze"
	smeltresult = /obj/item/ingot/bronze
	melting_material = /datum/material/bronze
	sellprice = M_IRON * 2
	item_weight = 5.55 KILOGRAMS

/obj/item/ingot/silver
	name = "barra de plata"
	desc = "Una barra de plata reluciente. La pesadilla de los nitewalkers."
	icon_state = "ingotsilv"
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver
	sellprice = M_SILVER
	item_weight = 6.65 KILOGRAMS

/obj/item/ingot/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/ingot/steel
	name = "barra de acero"
	desc = "Una barra de acero aleado."
	icon_state = "ingotsteel"
	smeltresult = /obj/item/ingot/steel
	melting_material = /datum/material/steel
	sellprice = M_STEEL
	item_weight = 5 KILOGRAMS

/obj/item/ingot/steelholy
	name = "barra de acero santa"
	desc = "Este lingote de acero ha sido tocado por Malum. Irradia calor, incluso fuera de una fragua."
	icon_state = "ingotsteelholy"
	smeltresult = /obj/item/ingot/steel
	melting_material = /datum/material/steel //Smelting it removes the blessing
	sellprice = M_STEEL * 1.5
	item_weight = 5 KILOGRAMS

/obj/item/ingot/silverblessed
	name = "barra de plata bendita"
	desc = "Esta barra irradia una pureza divina que es atesorada por la fe Psydonic. El Psycross y las sagradas liturgias se transcriben en la superficie."
	icon_state = "ingotsilvblessed"
	smeltresult = /obj/item/ingot/silver
	melting_material = /datum/material/silver //Smelting it removes the blessing
	sellprice = M_SILVER * 1.5
	item_weight = 6.65 KILOGRAMS

/obj/item/ingot/blacksteel
	name = "Barra blacksteel"
	desc = "Sacrificando los elementos sagrados de la plata por fuerza bruta, el origen de este extraño y poderoso lingote conlleva oscuros rumores..."
	icon_state = "ingotblacksteel"
	sellprice = M_BLACKSTEEL
	smeltresult = /obj/item/ingot/blacksteel
	melting_material = /datum/material/blacksteel
	item_weight = 5.2 KILOGRAMS

/obj/item/ingot/steel_slag
	name = "escoria de acero"
	desc = "Escoria que contiene acero, resultado de la floracion del hierro y el carbon."
	icon_state = "steel_slag"
	smeltresult = /obj/item/ingot/steel
	melting_material = /datum/material/steel
	sellprice = M_STEEL - 5
	item_weight = 5.5 KILOGRAMS

/obj/item/ingot/aalloy
	name = "lingote decrepito"
	desc = "Una losa decrepitud de bronce forjado, incomodamente fria al tacto. Los vientos se convierten en susurros cuando se sostiene el objeto durante un tiempo suficiente; 'el progreso exige sacrificio'."
	icon_state = "ingotancient"
	smeltresult = /obj/item/ingot/aaslag
	melting_material = /datum/material/ancient_alloy
	color = "#bb9696"
	sellprice = 33
	item_weight = 5.5 KILOGRAMS

/obj/item/ingot/purifiedaalloy
	name = "aleacion antigua"
	desc = "Un lingote de gilbranze pulido, repleto de conocimientos prohibidos. El reflejo en su superficie no es tuyo; te devuelve la sonrisa con eterna malicia."
	icon_state = "ingotancient"
	smeltresult = /obj/item/ingot/purifiedaalloy
	melting_material = /datum/material/purified_alloy
	sellprice = 111
	item_weight = 5.5 KILOGRAMS

/obj/item/ingot/aaslag
	name = "escoria brillante"
	desc = "Una masa de bronce labrado, cojo por el calor de la forja. A veces, muerto es mejor. </br>YSin embargo, tal vez fusionarlo en partes iguales con otro trozo de mineral brillante podria resucitar sus secretos."
	icon_state = "ancientslag"
	smeltresult = /obj/item/ingot/aaslag
	melting_material = /datum/material/glimmering_slag
	sellprice = 6
	item_weight = 6.15 KILOGRAMS

/obj/item/ingot/aaslag/Initialize()
	. = ..()
	add_filter(FORCE_FILTER, 2, list("type" = "outline", "color" = "#FF4500", "alpha" = 50, "size" = 1))

//Anomalous Smeltings
/obj/item/ingot/weeping
	name = "lingote duradero"
	desc = "Una losa de metal, envejecida y desnuda. Finalmente sabes que es, pero no se puede encontrar ninguna palabra para describirlo. </br>'...nadie conocera jamas las verdades mas grandes; del alcance de Aeon, de la presencia de Adonai, del destino de Psydon...' </br>'...pero, tal vez, eso sea para mejor. El malestar ha desaparecido, pero los males de este mundo siguen siendo muy reales...' </br>'...encuentra una manera de darle una nueva vida a los restos; un nuevo recipiente que aun puede hacer llorar a los seguidores del mal..'"
	icon_state = "ingotsilv"
	smeltresult = /obj/item/ingot/weeping
	melting_material = /datum/material/weeping
	color = "#CECA9C"
	sellprice = 222
	item_weight = 6.65 KILOGRAMS

/obj/item/ingot/weeping/Initialize()
	. = ..()
	add_filter(FORCE_FILTER, 2, list("type" = "outline", "color" = "#8B0000", "alpha" = 100, "size" = 1))

/obj/item/ingot/draconic
	name = "lingote draconico"
	desc = "Una losa de obsidiana que crepitaba de energia. Tus dedos se ampollan por el puro calor que irradia su superficie vidriosa. </br>'..ningun hombre, sea santo o pecador, puede realmente resistir tal poder..' </br>'..pero, tal vez, tu eres diferente..' </br>'..encuentra una manera de darle una nueva vida a los restos; un nuevo recipiente que aun puede hacer llorar a los seguidores del mal..'"
	icon_state = "ingotblacksteel"
	smeltresult = /obj/item/ingot/draconic
	melting_material = /datum/material/draconic
	color = "#70b8ff"
	sellprice = 333
	item_weight = 5.5 KILOGRAMS

/obj/item/ingot/draconic/Initialize()
	. = ..()
	add_filter(FORCE_FILTER, 2, list("type" = "outline", "color" = "#FF4500", "alpha" = 100, "size" = 1))

/obj/item/ingot/avantyne
	name = "oblea avantyne"
	desc = "Este lingote, aunque surgio de circunstancias impias, retumba con un potencial sobrenatural. Cincelada en el acero oscuro hay una iteracion prohibida del psycross; una señal de mal augurio para aquellos que se inclinan ante dioses menores."
	icon_state = "ingotavantyne"
	smeltresult = null
	sellprice = 130
	smeltresult = /obj/item/ingot/avantyne
	melting_material = /datum/material/avantyne

/obj/item/ingot/ketryl
	name = "lingote de ketril"
	desc = "Este lingote, que lleva el nombre de su estatus mitico, esta forjado segun los estandares enanos grabados en una pequeña huella en la superficie del lingote. El Ketryl suele estar plegado en capas finas, mas resistentes que el acero y, al mismo tiempo, inusualmente ligeras."
	icon_state = "ingotketryl"
	smeltresult = null
	sellprice = 555
	smeltresult = /obj/item/ingot/ketryl
	melting_material = /datum/material/ketryl

/obj/item/ingot/lithmyc
	name = "lingote litmico"
	desc = "Un extraño lingote verde. Parece estar cubierto de un liquido metalico aceitoso, aunque se niega a dejar la forma de lingote por mucho que lo intentes. Nadie en la region sabe aun en que se puede moldear el metal, ya que es extremadamente resistente. Pero seguro que parece impagable."
	icon_state = "ingotlithmyc"
	smeltresult = /obj/item/ingot/lithmyc
	melting_material = /datum/material/lithmyc
	sellprice = 444

/obj/item/ingot/lithmyc/Initialize()
	. = ..()
	add_filter(FORCE_FILTER, 2, list("type" = "outline", "color" = "#A0E65C", "alpha" = 100, "size" = 1))


/obj/item/ingot/component //Root. Don't use under most circumstances.
	name = "presencia sin sustancia"
	desc = "Algo que probablemente nunca debiste ver. Reza a una presencia superior para que te ayude antes de volver a hacerla pedazos en las llamas de la forja."
	icon_state = "oreada"
	smeltresult = /obj/item/ingot/iron
	melting_material = /datum/material/iron
	sellprice = 1

/obj/item/ingot/component/glutcrystal
	name = "glut cristalino"
	desc = "Violencia fractal, brillando con una neblina carmesi que invita a cumplir su proposito final."
	icon_state = "component_blood"
	smeltresult = /obj/item/gem/blood_diamond //Ensures that it can be reused for any Glut-specific ritual, should one find this in its crystalline form.
	sellprice = 33

/obj/item/ingot/component/glutcrystal/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.patron.type == /datum/patron/inhumen/graggar)
			. += span_danger("Conoces bien esta gema. Nacen de una gran violencia, pero solo si involucra a los mas poderosos de los guerreros. </br>Fabricar carne con la carne de cualquier guerrero que haya dado a luz a esta gema me permitira convocar a otro de su tipo a este mundo. </br>Derretir su caparazon cristalino es ideal, si deseas asegurarte de que no haya posibilidad de error al realizar tal ritual.")

/obj/item/ingot/component/glutcrystal/Initialize()
	. = ..()
	add_filter(FORCE_FILTER, 2, list("type" = "outline", "color" = "#8B0000", "alpha" = 120, "size" = 1))

/obj/item/ingot/component/heapofrawiron
	name = "monton de hierro crudo"
	desc = "Un trozo enorme, nacido de la fusion incoherente de hierro fundido. Trozos de mineral e lingotes emergen de su superficie irregular, anhelando ser refinados, ya sea en lingotes o en algo mas util."
	icon_state = "component_berserkheap"
	melting_material = /datum/material/iron
	melt_amount = 300
	sellprice = 44

/obj/item/ingot/component/berserkswordblade
	name = "hoja de la espada berserker"
	desc = "Una hoja enorme, forjada a partir de un monton de hierro en bruto. La espiga unica en forma de pua parece ser mas larga de lo que se ve en la mayoria de las grandes espadas, y solo se puede guardar mediante las entrañas de un mango adecuadamente grande."
	icon_state = "component_berserkblade"
	melting_material = /datum/material/iron
	melt_amount = 400
	sellprice = 33

/obj/item/ingot/component/berserkswordgrip
	name = "mango de la espada berserker"
	desc = "Un mango enorme, ensamblado a partir de la empuñadura a dos manos de una espada de verdugo. La exclusiva guarda cruzada en forma de media luna parece tener una ranura, a la que solo se puede acceder mediante la espiga de una hoja adecuadamente grande."
	icon_state = "component_berserkhandle"
	sellprice = 33

/obj/item/ingot/component/threadavantyne
	name = "hilo avantyne"
	desc = "Estos hilos, aunque surgen de circunstancias impias, brillan con un potencial de otro mundo. Cada alambre de acero oscuro parece contraerse con vigor cada vez que se acerca a otra aleacion; como un parasito atraido por un huesped."
	icon_state = "component_avantynethread"
	sellprice = 66

/obj/item/ingot/component/threadketryl
	name = "hilo de ketril"
	desc = "Estas hebras brillantes, que reciben su nombre de su estatus mitico, son mas fuertes que el acero y, al mismo tiempo, inusualmente ligeras."
	icon_state = "component_ketrylthread"
	sellprice = 111

/obj/item/ingot/component/zizo
	name = "fragmento de avantyne"
	desc = "Fragmentos susurrantes de una aleacion de otro mundo. </br>La potencia siempre tiene un precio."
	icon_state = "component_zizo"
	dropshrink = 0.7

/obj/item/ingot/component/graggar
	name = "vicious fragment"
	desc = "Fragmentos sangrantes de una aleacion de otro mundo. </br>El asesinato no es mas que justicia sin arbitraje."
	icon_state = "component_graggar"
	dropshrink = 0.7

/obj/item/ingot/component/matthios
	name = "fragmento dorado"
	desc = "Fragmentos relucientes de una aleacion de otro mundo. </br>La riqueza arrastra hasta las almas mas nobles a la perdicion."
	icon_state = "component_matthios"
	dropshrink = 0.7

/obj/item/ingot/component/baotha
	name = "fragmento de sacarina"
	desc = "Fragmentos aromaticos de una aleacion de otro mundo. </br>La desesperacion es el veneno mas grave y agonizante de todos."
	icon_state = "component_baotha"
	dropshrink = 0.7
