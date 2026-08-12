
/datum/talent_node/debug
	talent_tree_id = "debug"

// Tier 1 - Starting nodes (no prerequisites)
/datum/talent_node/debug/basic_power
	name = "Poder Basico"
	desc = "Aumenta tu poder basico en un 10%."
	icon_state = "spell_fireball"
	talent_cost = 1

/datum/talent_node/debug/quick_reflexes
	name = "Reflejos rapidos"
	desc = "Aumenta tu tiempo de reaccion."
	icon_state = "spell_haste"
	talent_cost = 1

/datum/talent_node/debug/sturdy_build
	name = "Sturdy Build"
	desc = "Aumenta su durabilidad"
	icon_state = "spell_armor"
	talent_cost = 1

// Tier 2 - Depends on Tier 1
/datum/talent_node/debug/enhanced_power
	name = "Enhanced Power"
	desc = "Further increases your power by 15%"
	icon_state = "spell_forcewall"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/basic_power)

/datum/talent_node/debug/combat_training
	name = "Entrenamiento de combate"
	desc = "Improves combat effectiveness"
	icon_state = "spell_summon"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/quick_reflexes)

/datum/talent_node/debug/defensive_stance
	name = "Postura defensiva"
	desc = "Reduce el daño recibido"
	icon_state = "spell_shield"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/sturdy_build)

/datum/talent_node/debug/agility_boost
	name = "Aumento de agilidad"
	desc = "Increases movement and dodge"
	icon_state = "spell_teleport"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/quick_reflexes)

// Tier 3 - Cross-dependencies
/datum/talent_node/debug/berserker_rage
	name = "Berserker Rage"
	desc = "Increases damage but reduces defense"
	icon_state = "spell_blind"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/enhanced_power, /datum/talent_node/debug/combat_training)

/datum/talent_node/debug/tactical_mind
	name = "Mente tactica"
	desc = "Improves strategic thinking and planning"
	icon_state = "spell_mindswap"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/combat_training)

/datum/talent_node/debug/fortified_defense
	name = "Defensa fortificada"
	desc = "Aumenta enormemente las capacidades defensivas."
	icon_state = "spell_forcewall"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/defensive_stance, /datum/talent_node/debug/sturdy_build)

/datum/talent_node/debug/evasive_maneuvers
	name = "Maniobras evasivas"
	desc = "Maestro de la evasion y la movilidad."
	icon_state = "spell_smoke"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/agility_boost)

// Tier 4 - Advanced combinations
/datum/talent_node/debug/unstoppable_force
	name = "Fuerza imparable"
	desc = "Cannot be stopped when charging"
	icon_state = "spell_summon"
	talent_cost = 4
	prerequisites = list(/datum/talent_node/debug/berserker_rage, /datum/talent_node/debug/enhanced_power)

/datum/talent_node/debug/master_strategist
	name = "Maestro estratega"
	desc = "Ultimate tactical awareness"
	icon_state = "spell_mindswap"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/tactical_mind, /datum/talent_node/debug/evasive_maneuvers)

/datum/talent_node/debug/immovable_object
	name = "Immovable Object"
	desc = "Nearly invulnerable to physical damage"
	icon_state = "spell_armor"
	talent_cost = 4
	prerequisites = list(/datum/talent_node/debug/fortified_defense)

// Tier 5 - Ultimate abilities
/datum/talent_node/debug/perfect_balance
	name = "Equilibrio perfecto"
	desc = "Master of both offense and defense"
	icon_state = "spell_teleport"
	talent_cost = 5
	prerequisites = list(/datum/talent_node/debug/unstoppable_force, /datum/talent_node/debug/immovable_object)

/datum/talent_node/debug/omniscient_warrior
	name = "Guerrero omnisciente"
	desc = "Knows all, sees all, defeats all"
	icon_state = "spell_blind"
	talent_cost = 5
	prerequisites = list(/datum/talent_node/debug/master_strategist, /datum/talent_node/debug/perfect_balance)

// Side branches - Utility skills
/datum/talent_node/debug/resource_management
	name = "Gestion de recursos"
	desc = "Mejor uso de consumibles y energia"
	icon_state = "spell_heal"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/tactical_mind)

/datum/talent_node/debug/efficiency_expert
	name = "Experto en eficiencia"
	desc = "Todas las acciones cuestan menos energia"
	icon_state = "spell_haste"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/resource_management, /datum/talent_node/debug/evasive_maneuvers)

// Special nodes with alternative prerequisites
/datum/talent_node/debug/adaptive_fighter
	name = "Adaptive Fighter"
	desc = "Adapta el estilo de lucha a los oponentes."
	icon_state = "spell_summon"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/combat_training)

/datum/talent_node/debug/survival_instinct
	name = "Instinto de supervivencia"
	desc = "Enhanced survival capabilities"
	icon_state = "spell_heal"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/defensive_stance)
	singular_requirement = TRUE // Can be unlocked if any defensive node is learned

/datum/talent_tree/debug
	name = "Arbol de talentos de depuracion"
	desc = "A comprehensive debug tree for testing talent systems"
	tree_identifier = "debug"
	max_talent_points = 75
	tree_nodes = list(
		// Tier 1
		/datum/talent_node/debug/basic_power,
		/datum/talent_node/debug/quick_reflexes,
		/datum/talent_node/debug/sturdy_build,
		// Tier 2
		/datum/talent_node/debug/enhanced_power,
		/datum/talent_node/debug/combat_training,
		/datum/talent_node/debug/defensive_stance,
		/datum/talent_node/debug/agility_boost,
		// Tier 3
		/datum/talent_node/debug/berserker_rage,
		/datum/talent_node/debug/tactical_mind,
		/datum/talent_node/debug/fortified_defense,
		/datum/talent_node/debug/evasive_maneuvers,
		// Tier 4
		/datum/talent_node/debug/unstoppable_force,
		/datum/talent_node/debug/master_strategist,
		/datum/talent_node/debug/immovable_object,
		// Tier 5
		/datum/talent_node/debug/perfect_balance,
		/datum/talent_node/debug/omniscient_warrior,
		// Utility
		/datum/talent_node/debug/resource_management,
		/datum/talent_node/debug/efficiency_expert,
		// Special
		/datum/talent_node/debug/adaptive_fighter,
		/datum/talent_node/debug/survival_instinct
	)
