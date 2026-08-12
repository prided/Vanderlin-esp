/obj/item/gem
	name = "gema aleatoria"
	desc = "Si encuentras esto, grita a Coderbus."
	icon_state = "aros"
	icon = 'icons/roguetown/items/gems.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	drop_sound = 'sound/items/gem.ogg'
	///I am leaving this here as a note. If you leave the price null on subtypes, you're eating the infinite recursion pill.
	///I dont care if its negative just DONT LEAVE IT 0
	sellprice = 0
	static_price = FALSE
	experimental_inhand = FALSE
	item_weight = 15 GRAMS
	///For Mappers; gem_path = weight
	var/list/valid_gems = list()

	var/quality = GEM_REGULAR
	var/datum/gem_effect/effect_template
	var/is_cut = FALSE
	var/arcyne_potency = 20
	var/datum/attunement/attuned

/obj/item/gem/Initialize()
	. = ..()
	if(sellprice == 0)
		var/new_gem
		if(length(valid_gems))
			new_gem = pickweight(valid_gems)
		else
			new_gem = pick(subtypesof(/obj/item/gem))
		var/obj/item/gem/spawned = new new_gem(get_turf(src))
		if(prob(20)) //! TODO: remove this when ore nodes are created
			spawned.quality = rand(GEM_CHIPPED, GEM_PERFECT)
		spawned.generate_socketing_properties()
		spawned.update_appearance(UPDATE_ICON_STATE)
		return INITIALIZE_HINT_QDEL

	if(quality == GEM_REGULAR && prob(20))
		quality = rand(GEM_CHIPPED, GEM_PERFECT)

	generate_socketing_properties()
	update_appearance(UPDATE_ICON_STATE)

/obj/item/gem/examine(mob/user)
	. = ..()
	. += get_socketing_description()
	if(is_cut)
		. += span_notice("Esta joya ha sido cortada profesionalmente.")

/obj/item/gem/on_consume(mob/living/eater)
	. = ..()
	eater.extra_mob_weight += get_carry_weight(eater)

/obj/item/gem/on_anti_consume(mob/living/eater)
	eater.extra_mob_weight -= get_carry_weight(eater)

///This is a switch incase anyone would like to add more...
/obj/item/gem/update_icon_state()
	if(icon_state == "aros") // :(
		switch(rand(1,2))
			if(1)
				icon_state = "d_cut"
			if(2)
				icon_state = "e_cut"
	return ..()

/obj/item/gem/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -1,"sy" = 0,"nx" = 11,"ny" = 1,"wx" = 0,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = 0,"wturn" = 0,"eturn" = 39,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/gem/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(src, pick('sound/items/gems (1).ogg','sound/items/gems (2).ogg'), 100, TRUE, -2)
	..()

/obj/item/gem/proc/generate_socketing_properties()
	effect_template = create_gem_effect()

	var/quality_name = GLOB.gem_quality_names[quality]
	if(quality_name)
		name = LOWER_TEXT("[quality_name] [name]")

/obj/item/gem/proc/create_gem_effect()
	if(ispath(effect_template))
		return new effect_template(quality)
	return effect_template

/obj/item/gem/proc/get_socketing_description()
	if(!effect_template)
		return "This gem can be socketed into equipment."
	return "Socketing Effects:\n[effect_template.get_description()]"

/obj/item/gem/proc/get_slot_type(obj/item/target)
	if(istype(target, /obj/item/weapon/shield)) ///0.0000001% faster operation goes brrr
		return SLOT_SHIELD
	else if(istype(target, /obj/item/weapon))
		return SLOT_WEAPON
	else if(istype(target, /obj/item/clothing))
		return SLOT_ARMOR
	return SLOT_WEAPON

/obj/item/gem/proc/create_rune_effect_for_slot(slot_type)
	if(!effect_template)
		return null
	return effect_template.create_effect_for_slot(slot_type)

/obj/item/gem/proc/apply_cut(datum/gem_cut/cut, mob/user)
	if(is_cut)
		to_chat(user, "¡[src] ya ha sido cortado!")
		return FALSE
	var/gemcutter_level = get_profession_level(user.ckey, /datum/profession/gemcutter)
	var/downgrade_chance = initial(cut.downgrade_chance) + (100 - gemcutter_level)

	var/failed = FALSE
	var/original_quality = quality
	while(prob(downgrade_chance))
		quality = max(1, quality - 1)
		downgrade_chance -= 100
		failed = TRUE

	effect_template = create_gem_effect_with_cut(cut)
	is_cut = TRUE

	// Update name and description
	var/cut_name = initial(cut.name)
	name = "[cut_name] [name]"
	desc += " This gem has been cut with a [cut_name] pattern."

	to_chat(user, "¡Cortaste [src] con un patron [cut_name]!")
	if(failed)
		to_chat(user, "¡Te equivocaste al cortar [src] y cayo de [GLOB.gem_quality_names[original_quality]] a [GLOB.gem_quality_names[quality]]!")
	return TRUE

/obj/item/gem/proc/create_gem_effect_with_cut(cut_type)
	var/datum/gem_effect/new_effect = new effect_template.type(quality, cut_type)

	var/bonus = get_cut_quality_bonus()
	if(bonus != 1.0)
		multiply_effect_data(new_effect, bonus)

	return new_effect

/obj/item/gem/proc/multiply_effect_data(datum/gem_effect/effect, multiplier)
	for(var/i = 1 to length(effect.weapon_effect_data))
		effect.weapon_effect_data[i] = round(effect.weapon_effect_data[i] * multiplier)

	for(var/i = 1 to length(effect.armor_effect_data))
		effect.armor_effect_data[i] = round(effect.armor_effect_data[i] * multiplier)

	for(var/i = 1 to length(effect.shield_effect_data))
		effect.shield_effect_data[i] = round(effect.shield_effect_data[i] * multiplier)

/obj/item/gem/proc/get_cut_quality_bonus()
	switch(quality)
		if(GEM_CHIPPED) return 0.8
		if(GEM_REGULAR) return 1.0
		if(GEM_FLAWLESS) return 1.3
		if(GEM_PERFECT) return 1.6
	return 1.0

/obj/item/gem/blood_diamond
	name = "glut"
	icon_state = "blood"
	sellprice = 188
	desc = "Algo en esta joya simplemente no te sienta bien. Sostenerlo hace que la sangre salga de tus dedos."
	smeltresult = /obj/item/ingot/component/glutcrystal
	dropshrink = 1

/obj/item/gem/blood_diamond/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.patron.type == /datum/patron/inhumen/graggar)
			. += span_danger("Conoces bien esta gema. Nacen de una gran violencia, pero solo si involucra a los guerreros mas poderosos. </br>Fabricar carne con la carne de cualquier guerrero que haya dado a luz a esta gema me permitira convocar a otro de su tipo en este mundo.")

/obj/item/gem/blood_diamond/Initialize()
	. = ..()
	add_filter(FORCE_FILTER, 2, list("type" = "outline", "color" = "#8B0000", "alpha" = 188, "size" = 1))

/obj/item/gem/green
	name = "gemerald"
	desc = "Destellos con brillo verde."
	//color = "#15af158c"
	icon_state = "emerald_cut"
	sellprice = 44
	dropshrink = 0.4
	arcyne_potency = 7
	attuned = /datum/attunement/earth
	effect_template = /datum/gem_effect/gemerald
	item_weight = 24 GRAMS

/obj/item/gem/blue
	name = "blortz"
	desc = "Azul palido, como una lagrima congelada."
	//color = "#1ca5aa8c"
	icon_state = "quartz_cut"
	sellprice = 88
	dropshrink = 0.4
	arcyne_potency = 25
	attuned = /datum/attunement/ice
	effect_template = /datum/gem_effect/blortz
	item_weight = 18 GRAMS

/obj/item/gem/yellow
	name = "toper"
	desc = "Sus tonalidades ambarinas te recuerdan al atardecer."
	//color = "#e6a0088c"
	icon_state = "topaz_cut"
	sellprice = 25
	dropshrink = 0.4
	arcyne_potency = 5
	attuned = /datum/attunement/electric
	effect_template = /datum/gem_effect/toper
	item_weight = 21 GRAMS

/obj/item/gem/violet
	name = "Zafiro"
	desc = "Esta joya es admirada por muchos magos."
	//color = "#1733b38c"
	icon_state = "sapphire_cut"
	sellprice = 56
	dropshrink = 0.4
	arcyne_potency = 10
	attuned = /datum/attunement/arcyne
	effect_template = /datum/gem_effect/saffira
	item_weight = 21 GRAMS

/obj/item/gem/diamond
	name = "dorpel"
	desc = "Bellamente pura, exige respeto."
	//color = "#ffffff8c"
	icon_state = "diamond_cut"
	sellprice = 121
	dropshrink = 0.4
	arcyne_potency = 15
	attuned = /datum/attunement/light
	effect_template = /datum/gem_effect/dorpel
	item_weight = 15 GRAMS

/obj/item/gem/red
	name = "rontz"
	desc = "Brillando con ira descuidada."
	//color = "#ff00008c"
	icon_state = "ruby_cut"
	sellprice = 100
	attuned = /datum/attunement/fire
	effect_template = /datum/gem_effect/rubor
	item_weight = 24 GRAMS

/obj/item/gem/onyxa
	name = "onyxa cruda"
	desc = "Un trozo de miel de araña fosilizada que brilla en la oscuridad. Alguna vez fue apreciada por el Drow, pero su importancia para su cultura ha sido reemplazada durante mucho tiempo por la saffira mas comun."
	icon = 'icons/roguetown/gems/gem_onyxa.dmi'
	icon_state = "raw_onyxa"
	sellprice = 30
	item_weight = 45 GRAMS

/obj/item/gem/jade
	name = "joapstone en bruto"
	desc = "Una joya verde apagada. Joapstone es valorado en multiples culturas humen y se cree que trae buena fortuna."
	icon = 'icons/roguetown/gems/gem_jade.dmi'
	icon_state = "raw_jade"
	sellprice = 50
	item_weight = 60 GRAMS

/obj/item/gem/oyster
	name = "almeja fosilizada"
	desc = "Una concha fosilizada. Seria una buena idea abrirlo con un cuchillo."
	icon = 'icons/roguetown/gems/gem_shell.dmi'
	icon_state = "oyster_closed"
	sellprice = 5
	item_weight = 75 GRAMS

/obj/item/gem/coral
	name = "aoetal en bruto"
	desc = "Dentado como un diente de perro. Se especula que Aoetal es la sangre cristalizada de marineros caidos. Es sagrado para los abisorianos y se utiliza en numerosos rituales abisorianos."
	icon = 'icons/roguetown/gems/gem_coral.dmi'
	icon_state = "raw_coral"
	sellprice = 60
	item_weight = 54 GRAMS

/obj/item/gem/turq
	name = "ceruleabaster en bruto"
	desc = "Una hermosa gema verde azulada que se talla facilmente."
	icon = 'icons/roguetown/gems/gem_turq.dmi'
	icon_state = "raw_turq"
	sellprice = 75
	item_weight = 66 GRAMS

/obj/item/gem/amber
	name = "petriamber crudo"
	desc = "Un trozo de hongo fosilizado que brilla radiante bajo la luz del sol. Es muy apreciado entre los astratanos."
	icon = 'icons/roguetown/gems/gem_amber.dmi'
	icon_state = "raw_amber"
	sellprice = 50
	item_weight = 36 GRAMS

/obj/item/gem/opal
	name = "opaloise crudo"
	desc = "Una joya deslumbrante que es notablemente valiosa. Se especula ampliamente que la opaloise es la esencia cristalizada que deja el arco iris, y es muy apreciada por los aborigenes Crimson Elves."
	icon = 'icons/roguetown/gems/gem_opal.dmi'
	icon_state = "raw_opal"
	sellprice = 80
	item_weight = 30 GRAMS

/// riddle


/obj/item/riddleofsteel
	name = "acertijo de acero"
	icon_state = "ros"
	icon = 'icons/roguetown/items/gems.dmi'
	desc = "Carne, mente."
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	sellprice = 454
	item_weight = 4.9 KILOGRAMS

/obj/item/riddleofsteel/Initialize()
	. = ..()
	set_light(2, 2, 1, l_color = "#ff0d0d")
