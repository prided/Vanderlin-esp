
/datum/penance/prayer
	name = "Prayers of Atonement"
	desc = "Debes orar extensamente para mostrar tu devoción."
	signal_type = COMSIG_PRAYER_COMPLETED
	required_count = 10
	devotion_reward = 30
	progression_reward = 20

/datum/penance/donation
	name = "Charitable Donation"
	desc = "Debes donar monedas a la iglesia."
	signal_type = COMSIG_DONATION_MADE
	required_count = 5 // 5 separate donations
	devotion_reward = 40
	progression_reward = 25

/datum/penance/healing
	name = "Healing the Sick"
	desc = "Debes sanar a los que sufren."
	signal_type = COMSIG_LIVING_HEALED_OTHER
	required_count = 10
	devotion_reward = 55
	progression_reward = 35

/datum/penance/combat
	name = "Trial by Combat"
	desc = "Debes demostrar tu valía en la batalla."
	signal_type = COMSIG_LIVING_COMBAT_KILL
	required_count = 3
	time_limit = 20 MINUTES
	devotion_reward = 70
	progression_reward = 45
