/obj/projectile/bullet/shrap
	name = "fragmento de plomo"
	icon = 'icons/obj/shards.dmi'
	icon_state = "small"
	damage = 45
	damage_type = BRUTE
	woundclass = BCLASS_SHOT
	range = 5
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	flag =  "piercing"
	speed = 0.8
	reduce_crit_chance = 7

/obj/item/ammo_casing/caseless/grenadeshell
	name = "Granada"
	desc = "Un tubo de metal con un tapon de rosca hermetico y ranuras para metralla."
	icon_state = "grenade_shell"
	icon = 'icons/obj/bombs.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	grid_height = 64
	grid_width = 32

/obj/item/explosive/canister_bomb
	name = "Bomba de bote"
	desc = "Un explosivo profesional Grenzelhoftian, lleno de metralla de plomo y polvora pegajosa. Este diseño de granada especifico fue desclasificado recientemente, siendo un vestigio de la primera guerra Grenzelhoft-Rosewood."
	icon_state = "canbomb"
	icon = 'icons/obj/bombs.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	grid_height = 64
	grid_width = 32
	impact_explode = FALSE
	item_weight = 1.7 KILOGRAMS

	prob2fail = 5

	ex_dev = 1
	ex_heavy = 3
	ex_light = 2
	ex_flame = 1

	shrapnel_type = /obj/projectile/bullet/shrap
	shrapnel_radius = 5
	det_time = 10 SECONDS
