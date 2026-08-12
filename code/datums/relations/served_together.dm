
/datum/relation/served_together
	name = "Servidos juntos"
	desc = "Se cruzaron durante el servicio militar activo."
	upgrades = list(/datum/relation/acquaintance)

/datum/relation/served_together/get_desc_string()
	return "[holder?.name] and [other?.name] served together at some point."
