/datum/sprite_accessory/detail
	name = ""
	icon_state = null
	gender = NEUTER
	icon = 'icons/roguetown/mob/detail.dmi'
	use_static = TRUE
	layer = BODY_LAYER
	default_colors = list("FFFFFF")
	specuse = list(SPEC_ID_HUMEN, SPEC_ID_DWARF, SPEC_ID_ELF, SPEC_ID_AASIMAR, SPEC_ID_TIEFLING, SPEC_ID_HALF_ORC)

/datum/sprite_accessory/detail/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE)

/datum/sprite_accessory/detail/nothing
	name = "Nothing"
	icon_state = "no tings"

/datum/sprite_accessory/detail/burnface_r
	name = "Quemaduras (r)"
	icon_state = "burnface_r"

/datum/sprite_accessory/detail/burnface_l
	name = "Quemaduras (l)"
	icon_state = "burnface_l"

/datum/sprite_accessory/detail/burneye_r
	name = "Ojo quemado (r)"
	icon_state = "burneye_r"

/datum/sprite_accessory/detail/burneye_l
	name = "Ojo quemado (l)"
	icon_state = "burneye_l"

/datum/sprite_accessory/detail/brows
	name = "Cejas Gruesas"
	icon_state = "brows"
	color_key_defaults = list(KEY_HAIR_COLOR)
	use_static = FALSE

/datum/sprite_accessory/detail/brows/dark
	name = "Cejas Oscuras"
	icon_state = "darkbrows"
	color_key_defaults = list(KEY_HAIR_COLOR)

/datum/sprite_accessory/detail/unibrow
	name = "Unibrow"
	icon_state = "unibrow"
	color_key_defaults = list(KEY_HAIR_COLOR)
	use_static = FALSE

/datum/sprite_accessory/detail/unibrow/dark
	name = "Dark Unibrow"
	icon_state = "darkunibrow"
	color_key_defaults = list(KEY_HAIR_COLOR)

/datum/sprite_accessory/detail/deadeye_r
	name = "Ojo muerto (r)"
	icon_state = "deadeye_r"

/datum/sprite_accessory/detail/deadeye_l
	name = "Dead Eye (l)"
	icon_state = "deadeye_l"

/datum/sprite_accessory/detail/scarhead
	name = "Cabeza cicatrizada"
	icon_state = "scarhead"

/datum/sprite_accessory/detail/scar
	name = "Cicatriz"
	icon_state = "scar"

/datum/sprite_accessory/detail/scart
	name = "Scar2"
	icon_state = "scar2"

/datum/sprite_accessory/detail/slashedeye_r
	name = "Ojo cortado (r)"
	icon_state = "slashedeye_r"

/datum/sprite_accessory/detail/slashedeye_r
	name = "Ojo cortado (r)"
	icon_state = "slashedeye_r"

/datum/sprite_accessory/detail/slashedeye_l
	name = "Ojo cortado (l)"
	icon_state = "slashedeye_l"

/datum/sprite_accessory/detail/mangled
	name = "Mandíbula destrozada"
	icon_state = "mangled"

/datum/sprite_accessory/detail/warpaint_blue
	name = "Pintura de guerra (azul)"
	icon_state = "warpaint_blue"

/datum/sprite_accessory/detail/warpaint_red
	name = "Warpaint (Red)"
	icon_state = "warpaint_red"

/datum/sprite_accessory/detail/warpaint_green
	name = "Pintura de guerra (verde)"
	icon_state = "warpaint_green"

/datum/sprite_accessory/detail/warpaint_purple
	name = "Pintura de guerra (púrpura)"
	icon_state = "warpaint_purple"

/datum/sprite_accessory/detail/warpaint_black
	name = "Pintura de guerra (negra)"
	icon_state = "warpaint_black"

/datum/sprite_accessory/detail/harlequin
	name = "Arlequín"
	icon_state = "harlequin"

/datum/sprite_accessory/detail/tattoo_lips
	name = "Tatuaje (labios)"
	icon_state = "tattoo_lips"

/datum/sprite_accessory/detail/tattoo_eye_r
	name = "Tatuaje (r Ojo)"
	icon_state = "tattoo_eye_r"

/datum/sprite_accessory/detail/tattoo_eye_l
	name = "Tattoo (l Eye)"
	icon_state = "tattoo_eye_l"
