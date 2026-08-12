/datum/bee_disease/varroa_mites
	name = "Varroa Mites"
	description = "Ácaros parásitos que debilitan y matan a las abejas."

/datum/bee_disease/varroa_mites/apply_effects(obj/structure/apiary/hive)
	if(prob(hive.disease_severity / 10) && hive.bee_count > 0)
		hive.bee_count--
		if(prob(10))
			hive.visible_message(span_warning("A bee falls from [hive], twitching."))
			var/obj/effect/decal/cleanable/insect/dead_bee = new(get_turf(hive))
			dead_bee.name = "abeja muerta"

/datum/bee_disease/varroa_mites/get_inspection_message()
	return span_warning("You spot tiny mites crawling on the bees!")
