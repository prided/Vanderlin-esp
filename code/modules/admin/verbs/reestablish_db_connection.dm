/client/proc/reestablish_db_connection()
	set category = "Server"
	set name = "Reestablish DB Connection"
	if (!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, "<span class='adminnotice'>¡La base de datos no esta habilitada!</span>")
		return

	if (SSdbcore.IsConnected())
		if (!check_rights(R_DEBUG,0))
			alert("¡La base de datos ya esta conectada! (Solo aquellos con +debug pueden forzar una reconexion)", "¡La base de datos ya esta conectada!")
			return

		var/reconnect = tgui_alert(usr, "¡La base de datos ya esta conectada! Si *SABES* que esto es incorrecto, puedes forzar una reconexion", "¡La base de datos ya esta conectada!", list("Force Reconnect", "Cancel"))
		if (reconnect != "Force Reconnect")
			return

		SSdbcore.Disconnect()
		log_admin("[key_name(usr)] has forced the database to disconnect")
		message_admins("[key_name_admin(usr)] has <b>forced</b> the database to disconnect!")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Force Reestablished Database Connection") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	if (SSdbcore.IsConnectedCross())
		if (!check_rights(R_DEBUG,0))
			alert("¡La base de datos ya esta conectada! (Solo aquellos con +debug pueden forzar una reconexion)", "¡La base de datos ya esta conectada!")
			return

		var/reconnect = tgui_alert(usr, "¡La base de datos ya esta conectada! Si *SABES* que esto es incorrecto, puedes forzar una reconexion", "¡La base de datos ya esta conectada!", list("Force Reconnect", "Cancel"))
		if (reconnect != "Force Reconnect")
			return

		SSdbcore.DisconnectCross()
		log_admin("[key_name(usr)] has forced the database to disconnect")
		message_admins("[key_name_admin(usr)] has <b>forced</b> the database to disconnect!")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Force Reestablished Database Connection") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	log_admin("[key_name(usr)] is attempting to re-establish the DB Connection")
	message_admins("[key_name_admin(usr)] is attempting to re-establish the DB Connection")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Reestablished Database Connection") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

	SSdbcore.failed_connections = 0
	if(!SSdbcore.Connect())
		message_admins("La conexion a la base de datos fallo: " + SSdbcore.ErrorMsg())
	else
		message_admins("Database connection re-established")

	if(!SSdbcore.Connect_Cross())
		message_admins("La conexion a la base de datos fallo: " + SSdbcore.ErrorMsg())
	else
		message_admins("Database connection re-established")
