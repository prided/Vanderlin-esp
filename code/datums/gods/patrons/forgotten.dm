/datum/patron/psydon
	name = "Psydon"
	display_name = "Ortodoxo Psydonite"
	domain = "Dios de la Humanidad, los Sueños y la Creación"
	desc = "Deceased, slain by Necra in His final moments. She ripped His body apart to create The Ten... we must put Him back together again. Psydon lives on, He will return."
	flaws = "Grudge-Holding, Judgemental, Self-Sacrificing"
	worshippers = "Grenzelhoftianos, Inquisidores, Héroes"
	sins = "Apostasy, Demon Worship, Betraying thy Father"
	boons = "None. His power is divided."

	associated_faith = /datum/faith/psydon
	prayer_fail = "No puedo hablar con Él... ¡Necesito Su cruz!"
	confess_lines = list(
		"¡SOLO HAY UN DIOS VERDADERO!",
		"THE SUCCESSORS HALT HIS RETURN!",
		"PSYDON WILL RETURN!",
	)

	associated_objects = alist(
		PATRON_AMULET = list(
			/obj/item/clothing/neck/psycross/silver,
			/obj/item/clothing/neck/psycross
		),
		PATRON_STRUCTURE = list(
			/obj/structure/fluff/psycross
		),
	)

/datum/patron/psydon/extremist
	display_name = "Extremista Psydonite"
	desc = "The Ten are conmen, false prophets, and heathens. The acts of the Tennite church are all tricks to beguile the mind and dissuade you from following the true path of Psydon. My actions prove my faith and His strength. Psydon lives, and you cannot convince me otherwise."
	flaws = "Stubborn, Fanatical, Spiteful"
	worshippers = "Fanáticos, tontos mal informados"
	sins = "Blasfemia, falsos profetas, engaños"
	confess_lines = list(
		"¡SOLO HAY UN DIOS!",
		"¡TU FALSO DIEZ SON MENTIRAS!",
		"PSYDON LIVES!",
	)


