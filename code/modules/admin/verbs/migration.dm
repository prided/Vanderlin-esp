/client/proc/toggle_migrations()
	set category = "GameMaster.Interacciones"
	set name = "Toggle Migrations"
	if(!check_rights(R_ADMIN))
		return FALSE

	var/choice = tgui_alert(src, "Esto habilitará o deshabilitará las migraciones, la configuración actual es [SSmigrants.get_current_disabled_status()]", "Are you sure?", list("Sí.", "No."))
	if(choice == "No.")
		return

	SSmigrants.toggle_admin_disabled()

	log_admin("[key_name(src)] [SSmigrants.get_current_disabled_status()] migrations.")
	message_admins("[key_name_admin(src)] [SSmigrants.get_current_disabled_status()] migrations.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle Migrations") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
