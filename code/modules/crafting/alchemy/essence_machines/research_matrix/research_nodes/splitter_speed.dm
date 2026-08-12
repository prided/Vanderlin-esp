/datum/thaumic_research_node/splitter_speed
	name = "Division rapida"
	desc = "Tecnicas para acelerar el proceso de division de la esencia a traves de patrones de canalizacion optimizados y metodos de enfoque mejorados."
	prerequisites = list(/datum/thaumic_research_node/splitter_efficiency)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 10,
		/datum/thaumaturgical_essence/air = 15,
		/datum/thaumaturgical_essence/energia = 10,
	)
	node_x = 480
	node_y = 20

	bonus_type = "additive"
	bonus_value = 0.4

/datum/thaumic_research_node/splitter_speed/two
	name = "Separacion rapida"
	desc = "Further acceleration of splitting processes through advanced magical circuitry and enhanced essence flow control."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/splitter_speed)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 20,
		/datum/thaumaturgical_essence/energia = 20,
		/datum/thaumaturgical_essence/cycle = 15,
	)
	node_x = 720
	node_y = 40

	bonus_value = 0.7

/datum/thaumic_research_node/splitter_speed/three
	name = "Lightning Division"
	desc = "Near-instantaneous essence separation achieved through mastery of temporal acceleration fields and perfected channeling techniques."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/splitter_speed/two)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 25,
		/datum/thaumaturgical_essence/energia = 25,
		/datum/thaumaturgical_essence/cycle = 25,
		/datum/thaumaturgical_essence/magic = 20,
	)
	node_x = 580
	node_y = 120

	bonus_value = 1.2
