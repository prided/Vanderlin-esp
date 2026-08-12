/datum/emote/brain
	mob_type_allowed_typecache = list(/mob/living/brain)
	mob_type_blacklist_typecache = list()

/datum/emote/brain/can_run_emote(mob/user, status_check = TRUE, intentional)
	. = ..()
	var/mob/living/brain/B = user
	if(!istype(B))
		return FALSE

/datum/emote/brain/alarm
	key = "alarm"
	message = "suena una alarma."
	emote_type = EMOTE_AUDIBLE

/datum/emote/brain/alert
	key = "alert"
	message = "lets out a distressed noise."
	emote_type = EMOTE_AUDIBLE

/datum/emote/brain/flash
	key = "flash"
	message = "parpadea sus luces."

/datum/emote/brain/notice
	key = "notice"
	message = "plays a loud tone."
	emote_type = EMOTE_AUDIBLE

/datum/emote/brain/whistle
	key = "whistle"
	key_third_person = "whistles"
	message = "silbidos."
	emote_type = EMOTE_AUDIBLE
