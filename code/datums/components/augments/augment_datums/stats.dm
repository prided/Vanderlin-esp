/datum/augment/stats
	var/list/stat_changes = list() // List of stat changes: list(STAT_STRENGTH = 1, STAT_SPEED = -1)
	color = COLOR_ASSEMBLY_ORANGE

/datum/augment/stats/on_install(mob/living/carbon/human/H)
	. = ..()
	if(!.)
		return
	for(var/stat in stat_changes)
		H.change_stat(stat, stat_changes[stat])

/datum/augment/stats/on_remove(mob/living/carbon/human/H)
	. = ..()
	if(!.)
		return
	for(var/stat in stat_changes)
		H.change_stat(stat, -stat_changes[stat])

/datum/augment/stats/get_examine_info()
	var/list/info = list()
	info += span_info("Cambios de estadísticas:")
	for(var/stat in stat_changes)
		var/change = stat_changes[stat]
		info += span_info("  [stat]: [change > 0 ? "+" : ""][change]")
	return info

/datum/augment/stats/strength_servo
	name = "hydraulic strength servo"
	desc = "Enhances physical power through pressurized hydraulics, at the cost of core stability."
	stability_cost = -12
	stat_changes = list(STAT_STRENGTH = 2)
	engineering_difficulty = SKILL_RANK_JOURNEYMAN
	installation_time = 15 SECONDS

/datum/augment/stats/perception_lens
	name = "matriz óptica mejorada"
	desc = "Mejora la agudeza visual y la adquisición de objetivos."
	stability_cost = -10
	stat_changes = list(STAT_PERCEPTION = 2)
	engineering_difficulty = SKILL_RANK_APPRENTICE
	installation_time = 12 SECONDS

/datum/augment/stats/processing_core
	name = "overclocked logic engine"
	desc = "Aumenta la velocidad de procesamiento y la capacidad analítica, forzando la matriz central."
	stability_cost = -12
	stat_changes = list(STAT_INTELLIGENCE = 3)
	engineering_difficulty = SKILL_RANK_EXPERT
	installation_time = 20 SECONDS

/datum/augment/stats/suspension_rig
	name = "suspension rig"
	desc = "Strengthens the automaton's frame against damage."
	stability_cost = -12
	stat_changes = list(STAT_CONSTITUTION = 2)
	engineering_difficulty = SKILL_RANK_JOURNEYMAN
	installation_time = 15 SECONDS

/datum/augment/stats/pressure_tank
	name = "tanque de presión de capacidad extendida"
	desc = "Allows for longer operational periods without rest."
	stability_cost = -10
	stat_changes = list(STAT_ENDURANCE = 2)
	engineering_difficulty = SKILL_RANK_APPRENTICE
	installation_time = 12 SECONDS

/datum/augment/stats/pressure_tank/on_install(mob/living/carbon/human/H)
	. = ..()
	if(!.)
		return
	var/datum/component/steam_life/sl = H.GetComponent(/datum/component/steam_life)
	sl?.max_steam_charge += 50

/datum/augment/stats/pressure_tank/on_remove(mob/living/carbon/human/H)
	. = ..()
	if(!.)
		return
	var/datum/component/steam_life/sl = H.GetComponent(/datum/component/steam_life)
	sl?.max_steam_charge -= 50

/datum/augment/stats/mobility_actuator
	name = "actuadores de alta eficiencia"
	desc = "Improves movement speed through advanced mechanical joints."
	stability_cost = -12
	stat_changes = list(STAT_SPEED = 2)
	engineering_difficulty = SKILL_RANK_JOURNEYMAN
	installation_time = 15 SECONDS

/datum/augment/stats/power_limiter
	name = "strength governor"
	desc = "Limits power output to improve core stability."
	stability_cost = 10
	stat_changes = list(STAT_STRENGTH = -1)
	engineering_difficulty = SKILL_RANK_NOVICE
	installation_time = 8 SECONDS

/datum/augment/stats/sensor_dampener
	name = "sensor dampening module"
	desc = "Reduce la sensibilidad del sensor para disminuir la carga de procesamiento."
	stability_cost = 8
	stat_changes = list(STAT_PERCEPTION = -1)
	engineering_difficulty = SKILL_RANK_NOVICE
	installation_time = 8 SECONDS

/datum/augment/stats/lightweight_frame
	name = "chasis ligero"
	desc = "Reduce la integridad estructural para una mejor eficiencia energética."
	stability_cost = 10
	stat_changes = list(STAT_CONSTITUTION = -1)
	engineering_difficulty = SKILL_RANK_NOVICE
	installation_time = 8 SECONDS

/datum/augment/stats/efficiency_mode
	name = "modo de conservación de energía"
	desc = "Reduce la capacidad operativa para mejorar la estabilidad."
	stability_cost = 8
	stat_changes = list(STAT_ENDURANCE = -1)
	engineering_difficulty = SKILL_RANK_NOVICE
	installation_time = 8 SECONDS

/datum/augment/stats/servo_governor
	name = "limitador de movimiento"
	desc = "Restricts movement speed to reduce mechanical stress."
	stability_cost = 10
	stat_changes = list(STAT_SPEED = -1)
	engineering_difficulty = SKILL_RANK_NOVICE
	installation_time = 8 SECONDS

/datum/augment/stats/balanced_matrix
	name = "matriz estabilizadora"
	desc = "Un aumento cuidadosamente equilibrado que mejora múltiples atributos."
	stability_cost = -5
	stat_changes = list(STAT_STRENGTH = 1, STAT_CONSTITUTION = 1)
	engineering_difficulty = SKILL_RANK_EXPERT
	installation_time = 20 SECONDS

/datum/augment/stats/core_stabilizer
	name = "matriz de estabilización central"
	desc = "Mejora drásticamente la estabilidad del núcleo sin afectar el rendimiento."
	stability_cost = 25
	stat_changes = list()
	engineering_difficulty = SKILL_RANK_MASTER
	installation_time = 25 SECONDS
