/datum/passive
	var/name = "Pasivo desconocido"
	var/description = "Un misterioso efecto pasivo"
	var/icon_state = "passive_unknown"
	var/passive_level = 1

/datum/passive/proc/apply(mob/target)
	// Override in subclasses to apply the passive effect
	// Return TRUE if successful, FALSE if failed
	return TRUE

/datum/passive/proc/unapply(mob/target)
	// Override in subclasses to remove the passive effect
	// Called when passive is removed or mob changes profession
	return
