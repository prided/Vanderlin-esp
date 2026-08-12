/datum/chimeric_node/input/death
	name = "mortis"
	desc = "Se activa cuando te matan."

/datum/chimeric_node/input/death/register_triggers(mob/living/carbon/target)
	if(!target)
		return

	unregister_triggers()
	registered_signals += COMSIG_LIVING_DEATH
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/chimeric_node/input/death/proc/on_death(datum/source)
	SIGNAL_HANDLER

	var/potency = node_purity / 10
	trigger_output(potency)
