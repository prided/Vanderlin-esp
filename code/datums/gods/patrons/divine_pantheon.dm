GLOBAL_LIST_INIT(patron_sound_themes, list(
	ASTRATA = 'sound/magic/bless.ogg',
	NOC = 'sound/ambience/noises/mystical (4).ogg',
	EORA = 'sound/vo/female/gen/giggle (1).ogg',
	DENDOR = 'sound/magic/barbroar.ogg',
	MALUM = 'sound/magic/dwarf_chant01.ogg',
	XYLIX = 'sound/misc/gods/xylix_omen.ogg',
	NECRA = 'sound/ambience/noises/genspooky (1).ogg',
	ABYSSOR = 'sound/items/bucket_transfer (2).ogg',
	RAVOX = 'sound/vo/male/knight/rage (6).ogg',
	PESTRA = 'sound/magic/cosmic_expansion.ogg',
	ZIZO = 'sound/misc/gods/zizo_omen.ogg',
	GRAGGAR = 'sound/misc/gods/graggar_omen.ogg',
	BAOTHA = 'sound/misc/gods/baotha_omen.ogg',
	MATTHIOS = 'sound/misc/gods/matthios_omen.ogg'
))

/datum/patron/divine
	abstract_type = /datum/patron/divine
	associated_faith = /datum/faith/divine_pantheon
	church_prayer = TRUE
	prayer_fail = "I need my patron's amulet, to go to church, or to find a cross to pray at."
	profane_words = list("zizo", "cock", "dick", "fuck", "shit", "pussy", "cuck", "cunt", "asshole")

/* ----------------- */
/datum/patron/divine/centrist
	name = DIVINE_CENTRIST
	domain = "Unidad y conflicto. Habitantes del Plano Eterno."
	desc = "Worshipping The Ten equally. Worship in such a manner is tolerated, but greatly disapproved of. The Ten rarely give their blessings to those who do not give single-minded adoration to a single diety."
	flaws = "Discordante, Inflexible, Desinteresado."
	worshippers = "Los mansos y los indecisos"
	sins = "Tentación, ignorancia, negación"
	boons = "The Ten pull for your devotion."
	added_traits = list(TRAIT_DIVINE_CENTRIST)
	devotion_holder = /datum/devotion/divine/centrist
	confess_lines = list(
		"THE TEN GUIDE US!",
		"¡LOS DIEZ NOS PROTEGEN!",
		"I SERVE THE DIVINE TEN!",
	)
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine,
			/obj/item/clothing/neck/psycross/divine
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)


/datum/patron/divine/astrata
	name = ASTRATA
	domain = "Diosa del Orden, la Reina del Sol"
	desc = "Crafted from the head of Psydon, twin of Noc. She gifted mankind the Sun, protecting Psydonia from all forces which may seek it harm: from both outside and within."
	flaws = "Tyrannical, Ill-Tempered, Uncompromising"
	worshippers = "Nobles, fanáticos, plebeyos"
	sins = "Traición, Pereza, Brujería"
	boons = "Your stamina regeneration delay is lowered during daytime."
	added_traits = list(TRAIT_APRICITY)
	devotion_holder = /datum/devotion/divine/astrata
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"ASTRATA BRINGS LAW!",
		"I SERVE THE GLORY OF THE SUN!",
	)
	storyteller = /datum/storyteller/astrata
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/astrata,
			/obj/item/clothing/neck/psycross/divine/astrata
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross,
			/obj/structure/fluff/statue/astrata
		),
	)

/datum/patron/divine/noc
	name = NOC
	domain = "Dios del Conocimiento, el Príncipe de la Luna"
	desc = "Crafted from the helmet of Psydon, twin of Astrata. He gifted mankind divine wisdom."
	flaws = "Cynical, Isolationist, Unfiltered Honesty"
	worshippers = "Practicantes de magia, eruditos, escribas"
	sins = "Suppressing Truth, Burning Books, Censorship"
	boons = "Aprendes, sueñas y enseñas a los aprendices un poco mejor. Acceso a roles con magia."
	added_traits = list(TRAIT_TUTELAGE)
	devotion_holder = /datum/devotion/divine/noc
	confess_lines = list(
		"¡NOC ES LA NOCHE!",
		"NOC SEES THE TRUTH!",
		"¡BUSCO LOS MISTERIOS DE LA LUNA!",
	)
	storyteller = /datum/storyteller/noc
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/noc,
			/obj/item/clothing/neck/psycross/divine/noc
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/dendor
	name = DENDOR
	domain = "Dios de la naturaleza y las bestias."
	desc = "Crafted from the bones of Psydon as the embodiment of the natural world. Driven mad with time."
	flaws = "Locura, Rebeldía, Desorden"
	worshippers = "Druidas, Bestias, Locos"
	sins = "Deforestation, Overhunting, Disrespecting Nature"
	boons = "You are immune to kneestingers."
	added_traits = list(TRAIT_KNEESTINGER_IMMUNITY)
	devotion_holder = /datum/devotion/divine/dendor
	confess_lines = list(
		"DENDOR PROVIDES!",
		"THE TREEFATHER BRINGS BOUNTY!",
		"I ANSWER THE CALL OF THE WILD!",
	)
	storyteller = /datum/storyteller/dendor
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/dendor,
			/obj/item/clothing/neck/psycross/divine/dendor
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/abyssor
	name = ABYSSOR
	domain = "Dios de los mares y las tormentas"
	desc = "Crafted from the blood of Psydon as sovereign of the waters. Enraged by ignorance of Him from followers of The Ten."
	flaws= "Reckless, Stubborn, Destructive"
	worshippers = "Sailors of the Sea and Sky, Horrid Sea-Creachers, Fog Islanders"
	sins = "Miedo, arrogancia, olvido"
	boons = "Leeches will drain very little of your blood."
	added_traits = list(TRAIT_LEECHIMMUNE)
	devotion_holder = /datum/devotion/divine/abyssor
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
	)
	storyteller = /datum/storyteller/abyssor
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/abyssor,
			/obj/item/clothing/neck/psycross/divine/abyssor
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/necra
	name = NECRA
	domain = "Mother Goddess of Death and Time"
	desc = "The Veiled Lady, once close partner to Psydon. She created the Nine others from his corpse, guiding them from the Underworld."
	flaws = "Inmutable, apático, fácil de aburrir"
	worshippers = "Orderlies, Gravetenders, Mourners"
	sins = "Heretical Magic, Untimely Death, Disturbance of Rest"
	boons = "You may see the presence of a soul in a body."
	added_traits = list(TRAIT_SOUL_EXAMINE)
	devotion_holder = /datum/devotion/divine/necra
	confess_lines = list(
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"THE UNDERMAIDEN IS OUR FINAL REPOSE!",
		"¡NO TEMO A LA MUERTE, MI SEÑORA ME ESPERA!",
	)
	storyteller = /datum/storyteller/necra
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/necra,
			/obj/item/clothing/neck/psycross/divine/necra
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/ravox
	name = RAVOX
	domain = "God of Warfare, Justice, and Bravery"
	desc = "Crafted from the blade of Psydon, a champion of all who seek righteousness for themselves and others."
	flaws = "Carelessness, Aggression, Pride"
	worshippers = "Guerreros, mercenarios, guardias."
	sins = "Cobardía, crueldad, estancamiento"
	boons = "Your used weapons dull slower."
	added_traits = list(TRAIT_SHARPER_BLADES)
	devotion_holder = /datum/devotion/divine/ravox
	confess_lines = list(
		"RAVOX IS JUSTICE!",
		"THROUGH STRIFE, GRACE!",
		"THE DRUMS OF WAR BEAT IN MY CHEST!",
	)
	storyteller = /datum/storyteller/ravox
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/ravox,
			/obj/item/clothing/neck/psycross/divine/ravox
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/xylix
	name = XYLIX
	domain = "Deity of Trickery, Freedom, and Inspiration"
	desc = "Crafted from the silver tongue of Psydon. Xylix is a force of change and deceit, yet allows little known of their gender let alone presence."
	flaws = "Petulance, Deception, Gambling-Prone"
	worshippers = "Cheats, Performers, The Hopeless"
	sins = "Aburrimiento, Previsibilidad, Rutina"
	boons = "Puedes manipular diferentes formas de juego a tu favor."
	added_traits = list(TRAIT_BLACKLEG)
	devotion_holder = /datum/devotion/divine/xylix
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"¡NOC ES LA NOCHE!",
		"DENDOR PROVIDES!",
		"ABYSSOR COMMANDS THE WAVES!",
		"RAVOX IS JUSTICE!",
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!", //the only xylix-related confession
		"PESTRA SOOTHES ALL ILLS!",
		"MALUM IS MY FORGE!",
		"EORA BRINGS US TOGETHER!",
	)
	storyteller = /datum/storyteller/xylix
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/xylix,
			/obj/item/clothing/neck/psycross/divine/xylix
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/pestra
	name = PESTRA
	domain = "Diosa de la enfermedad, la alquimia y la medicina"
	desc = "A mistake; Psydon's intestines left behind. She slithered out, bringing forth the cycle of life and decay."
	flaws = "Drunkenness, Crudeness, Irresponsibility"
	worshippers = "The Ill and Infirm, Alchemists, Physicians"
	sins = "´Curing´ Abnormalities, Refusing to Help Unfortunates, Groveling"
	boons = "Puedes consumir comida podrida sin enfermarte."
	added_traits = list(TRAIT_ROT_EATER)
	devotion_holder = /datum/devotion/divine/pestra
	confess_lines = list(
		"PESTRA SOOTHES ALL ILLS!",
		"DECAY IS A CONTINUATION OF LIFE!",
		"¡MI AFLICCIÓN ES MI TESTAMENTO!",
	)
	storyteller = /datum/storyteller/pestra
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/pestra,
			/obj/item/clothing/neck/psycross/divine/pestra
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/pestra/preference_accessible(datum/preferences/prefs)
	. = ..()
	if(!.)
		return

	// These guys believe in a wurm, not pestra. They won't accept pestra as not being a giant acid wurm.
	return prefs.pref_species.id != SPEC_ID_DWARF_SUBTERRAN

/datum/patron/divine/malum
	name = MALUM
	domain = "Dios del trabajo, la innovación y la creación"
	desc = "Crafted from the hands of Psydon. He would later use his own to construct wondrous inventions."
	flaws = "Obsessive, Exacting, Overbearing"
	worshippers = "Smiths, Miners, Sculptors"
	sins = "Cheating, Shoddy Work, Suicide"
	boons = "You recover more energy when sleeping."
	added_traits = list(TRAIT_BETTER_SLEEP)
	devotion_holder = /datum/devotion/divine/malum
	confess_lines = list(
		"MALUM IS MY FORGE!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)
	storyteller = /datum/storyteller/malum
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/malum,
			/obj/item/clothing/neck/psycross/divine/malum
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/divine/eora
	name = EORA
	domain = "Diosa del amor, la familia y el arte"
	desc = "Crafted from the heart of Psydon, a spreader of love and beauty, and strengthener of bonds."
	flaws= "Naivete, Impulsiveness, Bigotry"
	worshippers = "Mothers, Artists, Married Couples"
	sins = "Sadism, Abandonment, Ruining Beauty"
	boons = "You can understand others' needs better."
	added_traits = list(TRAIT_EXTEROCEPTION)
	devotion_holder = /datum/devotion/divine/eora
	confess_lines = list(
		"EORA BRINGS US TOGETHER!",
		"HER BEAUTY IS EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN AS YOU TRESPASS AGAINST ME!",
	)
	storyteller = /datum/storyteller/eora
	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver/divine/eora,
			/obj/item/clothing/neck/psycross/divine/eora
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)
