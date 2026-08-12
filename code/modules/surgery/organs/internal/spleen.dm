//Spleen: Regenerates blood over time
//Without it, you cannot generate blood without transfusions.
/obj/item/organ/spleen
	name = "spleen"
	desc = "El organo mas subestimado del cuerpo humano."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "kidney-l" //placeholder
	zone = BODY_ZONE_CHEST
	organ_efficiency = list(ORGAN_SLOT_SPLEEN = 100)

	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.7
	high_threshold = STANDARD_ORGAN_THRESHOLD * 0.6
	low_threshold = STANDARD_ORGAN_THRESHOLD * 0.2
	w_class = WEIGHT_CLASS_SMALL

	organ_volume = 0.5
	max_blood_storage = 20
	current_blood = 20
	blood_req = 1
	oxygen_req = 2
	nutriment_req = 2.4
	hydration_req = 0.9

	var/blood_regen_factor = BLOOD_REGEN_FACTOR // how much blood the spleen regenerates per efficiency point, per 2 seconds

/obj/item/organ/spleen/on_owner_examine(datum/source, mob/user, list/examine_list)
	if(!ishuman(owner))
		return
	if(is_failing())
		examine_list += span_danger("<b>[owner]</b> tiene el rostro ceniciento, con una palidez cerosa y sin sangre en la piel de [owner.p_their()].")
	else if(damage >= high_threshold)
		examine_list += span_warning("<b>[owner]</b> looks unusually pale and drawn.")
	else if(damage >= low_threshold)
		examine_list += span_notice("<b>[owner]</b> parece un poco palido.")

/obj/item/organ/spleen/get_availability(datum/species/S, mob/living/carbon/owner_mob)
	return !(TRAIT_NOBLOOD in S.inherent_traits)
