// KNIFE INTENTS //

/datum/intent/dagger
	clickcd = 8

/datum/intent/dagger/cut
	name = "cortar"
	icon_state = "incut"
	attack_verb = list("corta", "corta")
	animname = "cut"
	blade_class = BCLASS_CUT
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	penfactor = 10
	swingdelay = 1
	clickcd = 10	// between normal and fast
	item_damage_type = "slash"
	acc_bonus = 12

/datum/intent/dagger/cut/stiletto
	penfactor = 5

/datum/intent/dagger/thrust
	name = "apuntar con la espada"
	icon_state = "instab"
	attack_verb = list("apuñala")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 30
	clickcd = CLICK_CD_FAST
	swingdelay = 1
	item_damage_type = "stab"

/datum/intent/dagger/thrust/stiletto
	penfactor = 35

/datum/intent/peculate
	name = "robar"
	hitsound = null
	desc = "Robar la apariencia de otro."
	icon_state = "peculate"

/datum/intent/dagger/chop
	name = "cortar"
	icon_state = "inchop"
	attack_verb = list("taja")
	animname = "chop"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	penfactor = 10
	damfactor = 1.5
	swingdelay = 1
	clickcd = CLICK_CD_MELEE
	item_damage_type = "slash"

/datum/intent/dagger/chop/cleaver
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	damfactor = 2

/datum/intent/snip // The salvaging intent! Used only for the scissors for now!
	name = "recorte"
	icon_state = "insnip"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0
	no_attack = TRUE
	releasedrain = 0
	blade_class = BCLASS_PUNCH
