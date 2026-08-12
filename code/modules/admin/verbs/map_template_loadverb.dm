/client/proc/map_template_load()
	set category = "Depuración.Mapeo personalizado"
	set name = "Plantilla de mapa - Lugar"

	var/datum/map_template/template

	var/map = tgui_input_list(src, "Elija una plantilla de mapa para colocar en su UBICACIÓN ACTUAL", "Place Map Template", sortList(SSmapping.map_templates))
	if(!map)
		return
	template = SSmapping.map_templates[map]

	var/turf/T = get_turf(mob)
	if(!T)
		return

	var/centered = alert(src, "¿Quieres que esto se cree desde el centro o desde la esquina inferior izquierda de tu mapa?", "Posición de aparición", "Centro", "Abajo a la izquierda") == "Centro" ? TRUE : FALSE
	var/delete = alert(src, "Do you want to delete atoms in your load area?", "Eliminación de átomos", "Yes", "No") == "Yes" ? TRUE : FALSE

	var/list/preview = list()
	for(var/S in template.get_affected_turfs(T, centered))
		var/image/item = image('icons/turf/overlays.dmi',S,"greenOverlay")
		item.plane = ABOVE_LIGHTING_PLANE
		preview += item
	images += preview
	if(tgui_alert(src,"Confirm location.","Template Confirm", list("Yes","No")) == "Yes")
		if(template.load(T, centered, delete))
			message_admins("<span class='adminnotice'>[key_name_admin(src)] ha colocado una plantilla de mapa ([template.name]) en [ADMIN_COORDJMP(T)]</span>")
		else
			to_chat(src, "No se pudo colocar el mapa")
	images -= preview

/client/proc/map_template_upload()
	set category = "Depuración.Mapeo personalizado"
	set name = "Map Template - Upload"

	var/map = input(src, "Choose a Map Template to upload to template storage","Upload Map Template") as null|file
	if(!map)
		return
	if(copytext("[map]",-4) != ".dmm")
		to_chat(src, "<span class='warning'>El nombre del archivo debe terminar en '.dmm': [map]</span>")
		return
	var/datum/map_template/M
	switch(tgui_alert(src, "¿Qué tipo de mapa es este?", "Tipo de mapa", list("Normal", "Cancel")))
		if("Normal")
			M = new /datum/map_template(map, "[map]", TRUE)
		else
			return
	if(!M.cached_map)
		to_chat(src, "<span class='warning'>Map template '[map]' failed to parse properly.</span>")
		return

	var/datum/map_report/report = M.cached_map.check_for_errors()
	var/report_link
	if(report)
		report.show_to(src)
		report_link = " - <a href='byond://?src=[REF(report)];[HrefToken(TRUE)];show=1'>validation report</a>"
		to_chat(src, "<span class='warning'>Map template '[map]' <a href='byond://?src=[REF(report)];[HrefToken()];show=1'>failed validation</a>.</span>")
		if(report.loadable)
			var/response = tgui_alert(src, "The map failed validation, would you like to load it anyways?", "Map Errors", list("Cancel", "Upload Anyways"))
			if(response != "Upload Anyways")
				return
		else
			alert(src, "The map failed validation and cannot be loaded.", "Map Errors", "Oh Darn")
			return

	SSmapping.map_templates[M.name] = M
	message_admins("<span class='adminnotice'>[key_name_admin(src)] ha subido una plantilla de mapa '[map]' ([M.width]x[M.height])[report_link].</span>")
	to_chat(src, "<span class='notice'>Map template '[map]' ready to place ([M.width]x[M.height])</span>")
