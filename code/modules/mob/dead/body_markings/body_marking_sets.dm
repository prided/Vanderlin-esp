/datum/body_marking_set
	///The preview name of the body marking set. HAS to be unique
	var/name
	///List of the body markings in this set
	var/body_marking_list

/datum/body_marking_set/none
	name = "None"
	body_marking_list = list()

/datum/body_marking_set/socks
	name = "Socks"
	body_marking_list = list(
		/datum/body_marking/sock
		)

/datum/body_marking_set/belly
	name = "Barriga"
	body_marking_list = list(
		/datum/body_marking/belly
		)

/datum/body_marking_set/bellysocks
	name = "Belly & Socks"
	body_marking_list = list(
		/datum/body_marking/belly,
		/datum/body_marking/sock,
	)

/datum/body_marking_set/bellysockstertiary
	name = "Belly & Socks"
	body_marking_list = list(
		/datum/body_marking/belly,
		/datum/body_marking/sock/tertiary,
	)

/datum/body_marking_set/bellyscale
	name = "Scaled Belly"
	body_marking_list = list(
		/datum/body_marking/bellyscale
	)

/datum/body_marking_set/kobold_scale
	name = "Kobold Scales"
	body_marking_list = list(
		/datum/body_marking/kobold_scale
	)

/datum/body_marking_set/tiger
	name = "Tigre"
	body_marking_list = list(
		/datum/body_marking/tiger
	)

/datum/body_marking_set/tiger_dark
	name = "Tigre (oscuro)"
	body_marking_list = list(
		/datum/body_marking/tiger/dark
	)
