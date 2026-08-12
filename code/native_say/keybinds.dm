/datum/keybinding/client/ooc
	hotkey_keys = list("O")
	name = "ooc"
	full_name = "Open OOC"
	description = "Abre OOC"
	category = CATEGORY_CLIENT

/datum/keybinding/client/ooc/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	user.open_ooc()
	return TRUE

/datum/keybinding/client/say
	hotkey_keys = list("T")
	name = "say"
	full_name = "Abrir Hablar"
	description = "Abre el canal Hablar"
	category = CATEGORY_CLIENT

/datum/keybinding/client/me
	hotkey_keys = list("M")
	name = "me"
	full_name = "Abrir Yo"
	description = "Abre el canal Yo"
	category = CATEGORY_CLIENT

/datum/keybinding/client/me/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	user.open_me()
	return TRUE
