/datum/patron/alternate
	abstract_type = /datum/patron/alternate
	associated_faith = /datum/faith/alternate

/datum/patron/alternate/wurm
	name = "The Wurm"
	desc = "A Belief of Pestra contorted. You live for the Wurm and you will die for it."
	domain = "\"Mineralogy\", Flesh Searing, Chimeric Enhancement"
	flaws = "Fe ciega, autolesiones, crueldad"
	worshippers = "Los desesperados, los perdidos, los fanaticos"
	sins = "Betrayal of Duty, Hesitance, Trusting Outsiders"
	boons = "Two \"blessed\" chimeric organs"

	confess_lines = list(
		"¡EL CICLO CONTINUARA!",
		"THE WURM WILL GUIDE MY PATH!",
		"¡MIS CICATRICES SON MI PRUEBA!",
		"THE POOLS WILL ERODE ALL!",
	)

	allowed_races = list(SPEC_ID_DWARF_SUBTERRAN)

/datum/patron/alternate/great_hunt
	name = "The Great Hunt"
	display_name = "La gran caza (no probada)"
	desc = "In the cold reaches of Ossland, they worship the four aspects of the Great Hunt: \
	Graggar as The Hunter, revered for the relation between predator and prey; \
	Necra as The Skull, revered for the death that awaits every living being; \
	Dendor as The Woods, revered for the wilds they live in and the beasts they hunt; \
	Abyssor as The Traveler, revered for the safe passage of travelers and the unflinching weather that scours the north."
	boons = "None. You have not proven worthy, yet."
	domain = "The Hunt, Travelers, Nature"
	flaws = "Intenso, Morboso"
	worshippers = "Hunters, the Northmen"
	sins = "Wasting any of your kills, Smashing skullmets, Exploiting nature"
	prayer_fail = "Necesito un amuleto de la caza para que mis oraciones sean escuchadas..."
	confess_lines = list(
		"I WILL BE REBORN!",
		"TO HUNT IS TO TAKE YOUR PLACE IN THE CYCLE!",
		"WE ALL DIE SOMEDAY!",
		"LET ME BE HUNTED, NOT SLAUGHTERED LIKE THIS!"
	)
	devotion_holder = /datum/devotion/alternate/great_hunt
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/great_hunt
		),
		PATRON_STRUCTURE = null
	)

/datum/patron/alternate/great_hunt/proven
	display_name = "The Great Hunt (Proven)"
	added_traits = list(TRAIT_MANEATER_IMMUNITY, TRAIT_ENTANGLER_IMMUNITY)
	boons = "You are left untouched by the flesh eating plants."

/datum/patron/alternate/great_hunt/proven/preference_accessible(datum/preferences/prefs)
	return FALSE

/datum/patron/alternate/black_briar
	name = "The Black Briar"
	desc = "The Briar is not worshipped, it is joined. Roots in the body connect the consciousnesses of those afflicted into a Gestalt. During assimilation, many Afflicted desire to spread from their infection point."
	domain = "The Black Briar"
	flaws = "...really?"
	worshippers = "The Gestalt"
	sins = "Denying Your Beauty, Resisting the Gestalt"
	boons = "Belleza de la Rosa Umbral"

	confess_lines = list(
		"¡SOMOS HERMOSOS!",
		"LISTEN TO OUR SONG!",
		"CUT MY FLESH SO I MAY SPROUT!",
		"OH NOC, SWEET NOC, YOUR GAZE IS THE NECTAR IN WHICH I DRINK!",
	)

/datum/patron/alternate/black_briar/on_gain(mob/living/pious)
	. = ..()
	pious.add_quirk(/datum/quirk/black_briar)

//todo: unique prayer system?
/datum/patron/alternate/black_briar/preference_accessible(datum/preferences/prefs)
	return FALSE
