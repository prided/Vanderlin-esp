/datum/bee_disease/foulbrood
	name = "Loque de las abejas"
	description = "Una enfermedad bacteriana que impide el desarrollo de nuevas abejas"

/datum/bee_disease/foulbrood/apply_effects(obj/structure/apiary/hive)
	if(prob(hive.disease_severity))
		hive.comb_progress = max(0, hive.comb_progress - 1)

/datum/bee_disease/foulbrood/get_inspection_message()
	return span_warning("¡El panal tiene un olor desagradable y parece descolorido!")
