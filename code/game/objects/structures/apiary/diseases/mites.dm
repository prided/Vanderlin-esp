/datum/bee_disease/varroa_mites
	name = "Acaros de la Varroa"
	description = "Acaros parasitos que debilitan y matan a las abejas."

/datum/bee_disease/varroa_mites/apply_effects(obj/structure/apiary/hive)
	if(prob(hive.disease_severity / 10) && hive.bee_count > 0)
		hive.bee_count--
		if(prob(10))
			hive.visible_message(span_warning("Una abeja cae de [hive], contoneandose."))
			var/obj/effect/decal/cleanable/insect/dead_bee = new(get_turf(hive))
			dead_bee.name = "abeja muerta"

/datum/bee_disease/varroa_mites/get_inspection_message()
	return span_warning("¡Ves diminutos acaros trepando sobre las abejas!")
