/obj/item/quicksilver
	name = "cataplasma de mercurio"
	icon_state = "quicksilver"
	possible_item_intents = list(/datum/intent/use)
	icon = 'icons/roguetown/items/quicksilver.dmi'
	desc = "Una atrevida mezcla de alquimia, sangre aberrante y plata divina. Esta panacea fortalece el cuerpo del ungido con polvo de plata bendito, protegiendolo de las maldiciones del vampirismo y la licantropia."
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 1
	drop_sound = 'sound/items/gem.ogg'
	resistance_flags = FIRE_PROOF
	item_weight = 50 GRAMS
	var/miracle_use = 0
	var/success = 0

/obj/item/quicksilver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/quicksilver/luxinfused
	name = "plata absolutoria"
	icon_state = "quicksilverlux"
	desc = "Una atrevida mezcla de trazas de lux purificador, sangre aberrante y plata divina. Esta panacea fortalece el cuerpo del ungido con polvo de plata bendito, protegiendolo de las maldiciones del vampirismo y la licantropia."

/obj/item/quicksilver/examine(mob/user)
	. = ..()
	if(miracle_use)
		. += span_notice("Por alguna casualidad milagrosa, hay suficiente para un uso mas.")

/obj/item/quicksilver/attack(mob/living/carbon/human/M, mob/living/carbon/human/user, list/modifiers)
	if(!istype(M) || !istype(user))
		return ..()

	var/inquisitor = FALSE
	if(!user.mind)
		return

	if(HAS_TRAIT(user, TRAIT_PURITAN))
		inquisitor = TRUE

	if(HAS_TRAIT(user, TRAIT_PACIFISM) && HAS_TRAIT(user, TRAIT_INQUISITION) && HAS_TRAIT(user, TRAIT_SILVER_BLESSED))
		inquisitor = TRUE

	if(!M.mind) //Stopping null lookup runtimes
		to_chat(user, span_warning("[M] no tiene la mente para beneficiarse de la uncion sagrada."))
		return

	if(HAS_TRAIT(M, TRAIT_SILVER_BLESSED))
		to_chat(user, span_warning("A simple inspeccion, [M] ya esta ungido con quicksilver."))
		return

	if(!inquisitor && !GET_MOB_SKILL_VALUE_OLD(user, /datum/attribute/skill/magic/holy) >= SKILL_EXP_EXPERT)
		to_chat(user, span_warning("No tengo el conocimiento divino para aplicar [src] correctamente."))
		return

	if(user.patron in typesof(/datum/patron/inhumen))
		to_chat(user, span_warning("Toda esta cosa de la uncion parece ser un sinsentido. ¿Por que prevenir el caos? Ademas, esta pasta me quema los dedos."))
		return

	if(user == M)
		to_chat(user, span_warning("No puedo ungirme a mi mismo con esto. Debo encontrar a alguien mas para realizar los ritos."))
		return

	if(M.stat == DEAD)
		to_chat(user, span_warning("Con su corazon calmado, el ritual no tendra ningun efecto sobre ellos. Seria una perdida de tiempo."))
		return

	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("Necesito una cruz sagrada cerca para aplicarlo correctamente.")) //Like Anastasis
		return

	var/datum/antagonist/werewolf/Were = M.mind.has_antag_datum(/datum/antagonist/werewolf/)
	var/datum/antagonist/werewolf/lesser/Wereless = M.mind.has_antag_datum(/datum/antagonist/werewolf/lesser/)
	var/datum/antagonist/vampire/Vamp = M.mind.has_antag_datum(/datum/antagonist/vampire)

	user.visible_message(span_notice("[user] comienza a ungir a [M] con [src]."))
	if(do_after(user, 10 SECONDS, target = M))
		if(!Were && !Vamp)
			user.visible_message(span_notice("[user] unge la frente de [M] con [src]."))
			ADD_TRAIT(M, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
			success = 1
		else
			to_chat(M, span_userdanger("¡Esta mezcla de plata ardiente me amenaza con arruinarme!"))
			M.emote("agony", forced = TRUE)
			M.adjustFireLoss(25)
			M.fire_act(3,3) //Not too bad, but not a single pat to put out.
			user.visible_message(span_danger("[src] estalla en llamas en la frente de [M], pero [user] intenta completar la uncion."))
			if(do_after(user, 10 SECONDS, target = M))
				user.visible_message(span_danger("[user] unge la frente de [M] con [src]."))
				success = 1
	if(!success)
		return

	//Delete the item, or if you're the inquisitor, you squeeze another dose out of it.
	miracle_use += 1
	if((miracle_use && !inquisitor) || miracle_use > 1)
		to_chat(user, span_notice("Eso es todo el emplasto. Solo queda la tela de sujecion."))
		new /obj/item/natural/cloth(user.loc)
		qdel(src)
	else
		icon_state = "[initial(icon_state)]_half"
		to_chat(user, span_notice("Mi entrenamiento inquisitorial deja justo suficiente de la pomada para una uncion mas."))


	//Werewolf deconversion
	if(Were && !Wereless) //The roundstart elder/alpha werewolf, it cannot be saved
		to_chat(M, span_userdanger("Esta plata miserable pesa mucho sobre mi frente. La bendicion de Dendor no se va a deshacer de mi tan facilmente."))
		user.visible_message(span_danger("El emplasto de plata hierve y se aleja de la frente de [M], rechazando visceralmente la uncion divina."))
		M.Stun(30)
		M.Knockdown(30)
		return

	else if(Wereless) //A lesser werewolf can be deconverted
		if(Were.transformed == TRUE)
			var/mob/living/carbon/human/I = M.stored_mob
			to_chat(M, span_userdanger("¡LA IMPURIDAD DE LA PLATA! ¡MI CUERPO SE DESGARRA ¡Mirame!"))
			Were.on_removal()
			ADD_TRAIT(I, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
			I.emote("agony", forced = TRUE)
			I.Stun(30)
			I.Knockdown(30)
			I.adjust_jitter(6 SECONDS)
			return
		else
			M.flash_fullscreen("redflash3")
			M.emote("agony", forced = TRUE)
			to_chat(M, span_userdanger("¡LA IMPURIFICACION DE LA PLATA! ¡ME QUEMA HASTA EL MAS PROFUNDO DE MIS ORGANOS!"))
			Were.on_removal()
			ADD_TRAIT(M, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
			M.Stun(30)
			M.Knockdown(30)
			M.adjust_jitter(6 SECONDS)
			return

	else if(Vamp) //We're the vampire, we can't be saved.
		to_chat(M, span_userdanger("Esta plata miserable pesa sobre mi frente. Una ofensa que nunca olvidare, mientras yo viva."))
		user.visible_message(span_danger("El emplasto de plata hierve y se aleja de la frente de [M], rechazando visceralmente la uncion divina."))
		M.Stun(30)
		M.Knockdown(30)

//A letter to give info on how to make this thing.
/obj/item/paper/inquisition_poultice_info
	name = "Misiva Inquisitorial"
	desc = "Una carta de la Gran Catedral en el Oratorium. Apesta a humo en zigzag."
	info = "<font face=\"Segoe Script\" color=#00000>Greetings to ye, distant missionaries in Azuria<br><br>This missive serves to inform of a breakthrough of alchemy. Enclosed is a substance, <b>Quicksilver</b>, that may be of keen use in the preservation of life against those unholy creechers that are repelled by divine silver. We speak of the werevolf and the vampyre. Herein lies the method.<br><br>Gather an ore of silver, a vessel of blessed water- a bottle's worth shall suffice, and a simple strip of cloth to add structure to the poultice. Take the warm bud of a fyritius flower, and immerse it in the bleeding wound of an unholy creecher. The warmth of the bud will congeal this foul ichor- but make haste, as it doth soon burn itself to ash. Induce the bloodied flower to your materials- grind the silver ore into dust via the mortar and pestle. Any expert of the craft of alchemy may intuit the process.<br><br>The ritual anointment is complex, and must be performed by a learned holy cleric in proximity of a cross of the pantheon. Inquisitor, your training doth empower you, as well. When the work is finished, the recipient now is inundated with holy silver- and shall be fortified against the fell turning of these unholy creechers.<br><br>Take heed! This act may also salvage the life of unfortunate souls who have recently been turned to beast. Their body's accursed resistance excites the Quicksilver to fire- but complete the rite, and they too are saved. All, except the eldest of Vampyre and Werevolf- we ascertain even this method cannot save them, and it will be a waste! (Albeit humbling.)<br><br>Share of this missive with any agents or employs that need direction in this rite.<br><br><b>PSYDON ENDURES,</b><br><i>Holy Fellowship of Research, the Grand Cathedral, the Oratorium Throni Vacui.</i></font>"
