// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.
/obj/item/organ/tail
	name = "tail"
	desc = "Una cola cortada. ¿De qué cortaste esto?"
	icon_state = "tail-lizard"
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	organ_efficiency = list(ORGAN_SLOT_TAIL = 100)
	var/can_wag = TRUE
	var/wagging = FALSE

/obj/item/organ/tail/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	if(organ_owner.dna?.species)
		organ_owner.dna.species.stop_wagging_tail(organ_owner)

/obj/item/organ/tail/cat
	name = "cola de gato"

/obj/item/organ/tail/demihuman
	name = "cola hueca"
	icon_state = "tail-furry"

/obj/item/organ/tail/harpy
	name = "harpy plumage"
	accessory_type = /datum/sprite_accessory/tail/hawk

/obj/item/organ/tail/medicator
	name = "plumaje medicador"
	desc = "A foul smelling substance drips from the tips, even without its host."
	accessory_type = /datum/sprite_accessory/tail/medicator
	var/datum/component/stillness_timer/stillness

/obj/item/organ/tail/medicator/Destroy()
	if(stillness)
		QDEL_NULL(stillness)
	return ..()

/obj/item/organ/tail/medicator/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	if(!istype(owner, /mob/living/carbon/human/dummy))
		stillness = owner.AddComponent(/datum/component/stillness_timer, 25 SECONDS, null, CALLBACK(src, PROC_REF(do_goop)))

/obj/item/organ/tail/medicator/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	if(stillness)
		QDEL_NULL(stillness)

/obj/item/organ/tail/medicator/proc/do_goop()
	if(!owner || QDELETED(src))
		return
	if(!isturf(owner.loc))
		return
	var/turf/owner_turf = owner.loc
	if(locate(/obj/effect/decal/cleanable/greenglow) in owner_turf)
		return
	var/obj/effect/decal/cleanable/greenglow/mess = new(owner_turf)
	mess.name = "goo"
	var/matrix/goo_matrix = matrix()
	goo_matrix.Scale(0.3)
	goo_matrix.Turn(-60, 60)
	mess.transform = goo_matrix
	mess.pixel_x += rand(-5, 5)
	mess.pixel_y += rand(-5, 5)

	QDEL_IN(mess, 30 SECONDS)

/obj/item/organ/tail/kobold
	name = "cola de lagarto pequeño"
	accessory_type = /datum/sprite_accessory/tail/kobold

/obj/item/organ/tail/kobold/round
	accessory_type = /datum/sprite_accessory/tail/kobold/round

/obj/item/organ/tail/triton
	name = "campana de tritón"
	accessory_type = /datum/sprite_accessory/tail/triton
