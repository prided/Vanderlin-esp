/obj/structure/fake_machine/lottery_roguetown
	name = "LA FORTUNA DE XYLIX"
	desc = "Un agujero infinito y enorme que hace o deshace a los hombres. ¡Ven y juega!"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "lottery"
	density = FALSE
	pixel_y = 32
	light_outer_range = 5
	light_color = "#1b7bf1"

	// Gambling variables
	var/gamblingprice = 0
	var/gamblingprob = 60
	var/gamblingbaseprob = 60
	var/oldtithe = 0

	// Roll and limit variables
	var/diceroll = 100
	var/maxtithing = 100
	var/mintithing = 5
	var/probpenalty = 2

	// State variables
	var/stopgambling = 0
	var/checkchatter = 0
	var/chatterbox = 0

/obj/structure/fake_machine/lottery_roguetown/attack_hand(mob/living/user)
	say("Tu actual diezmo es [gamblingprice] mammon. ¿Te animas a girar?")
	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/obj/structure/fake_machine/lottery_roguetown/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!ishuman(user) || stopgambling)
		return

	if(gamblingprice <= 0)
		say("Pobre cosa, estas sin dinero.")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(gamblingprice < 0)
		say("El diezmo de tu campesino es NEGATIVO.")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	// Build coin options
	var/list/choicez = list()
	if(gamblingprice > 10)
		choicez += "GOLD"
	if(gamblingprice > 5)
		choicez += "SILVER"
	choicez += "BRONZE"

	var/selection = browser_input_list(user, "Make a Selection", "[name]", choicez)
	if(!selection)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	// Calculate coin value
	var/mod = 1
	if(selection == "GOLD")
		mod = 10
	if(selection == "SILVER")
		mod = 5

	var/coin_amt = input(user, "Sayyid, tienes [gamblingprice] mammon en las diezmos. Puedes retirar [floor(gamblingprice/mod)] [selection] MONEDAS.", src) as null|num
	coin_amt = round(coin_amt)

	if(coin_amt < 1)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!Adjacent(user) || stopgambling)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if((coin_amt * mod) > gamblingprice)
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	budget2change(coin_amt * mod, user, selection)
	gamblingprice -= coin_amt * mod
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/fake_machine/lottery_roguetown/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.cmode)
		return NONE

	if(!istype(tool, /obj/item/coin) || istype(tool, /obj/item/coin/inqcoin))
		return NONE

	if(stopgambling)
		return NONE

	var/obj/item/coin/coin = tool

	var/coin_value = coin.get_real_price()
	var/new_total = gamblingprice + coin_value

	// Validate tithe amount
	if(new_total > maxtithing)
		say("Esto pone el diezmo inicial sobre [maxtithing] de las riquezas.")
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return ITEM_INTERACT_BLOCKING

	if(new_total < mintithing)
		say("Esto esta por debajo de [mintithing] los bienes materiales.")
		playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
		return ITEM_INTERACT_BLOCKING

	// Accept the coin
	gamblingprice += coin_value

	qdel(coin)
	say("Tu decima actual es ahora [gamblingprice] mammons. ¿Te animas a jugar?")
	playsound(src, 'sound/misc/machinequestion.ogg', 100, FALSE, -1)

	return ITEM_INTERACT_SUCCESS

/obj/structure/fake_machine/lottery_roguetown/MiddleClick(mob/living/user, list/modifiers)
	if(stopgambling)
		return

	// Check if player has bet
	if(gamblingprice == 0)
		say(pick(
			"Tonto ansioso; Necesitas dinero para jugar tu vida.", \
			"Te falta tu diezmo.", \
			"Un señor sin tierra no es ningun señor."\
		))
		stopgambling = 1
		sleep(20)
		stopgambling = 0
		return

	// Start gambling sequence
	diceroll = rand(1, 100)
	say(pick(
		"Doy vueltas y vueltas, donde me detengo, solo yo lo se.",\
		"Xylix sonrie ante tu idiotez, niña.",\
		"La rueda del destino gira y gira.",\
		"Oh, pobre tonto.",\
		"Esto va a doler a uno de nosotros.",\
		"Yo rio, tu lloras; Yo lloro, tu animas..",\
		"Sere tu tonto; actuare para ti...",\
		"¡Vamos a apostar!",\
		"Alrededor y alrededor abunda la locura.",\
		"Danza con la ruina y la riqueza."\
	))

	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
	playsound(src, 'sound/misc/letsgogambling.ogg', 100, FALSE, -1)

	gamblingprob += (GET_MOB_ATTRIBUTE_VALUE(user, STAT_FORTUNE) - probpenalty)
	stopgambling = 1
	checkchatter -= 1

	// Shake animation
	var/oldx = pixel_x
	animate(src, pixel_x = oldx + 1, time = 1)
	animate(pixel_x = oldx - 1, time = 1)
	animate(pixel_x = oldx, time = 1)
	sleep(50)

	// Determine result
	if(gamblingprob > diceroll)
		handle_win()
		SEND_SIGNAL(user, COMSIG_GAMBLING_WON)
	else
		handle_loss()


/obj/structure/fake_machine/lottery_roguetown/proc/handle_win()
	oldtithe = gamblingprice
	gamblingprice *= pick(1.1, 1.1, 1.1, 1.1, 1.2, 1.2, 1.2, 1.4, 1.4, 2)
	gamblingprice = round(gamblingprice)

	peasant_betting()
	letsgogamblinggamblers()

	say(pick(
		"¡Bien maniobrado, aristocrata! El diezmo de su campesino ahora es mammons [gamblingprice]. ¿Jugar de nuevo?",\
		"Este año hay una cosecha abundante: el diezmo del campesino asciende a mammons [gamblingprice]. ¿Girarme de nuevo?"\
	))

	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
	gamblingprob = gamblingbaseprob
	oldtithe = gamblingprice
	sleep(15)
	stopgambling = 0


/obj/structure/fake_machine/lottery_roguetown/proc/handle_loss()
	say(pick(
		"DIEZ, RUEDA DE LA FORTUNA - invertida.",\
		"El Castillo. ¡Oh, presagio!",\
		"¡Una cosecha de langostas...!",\
		"Mirame a los ojos y susurra tus aflicciones.",\
		"Oh, maldita sea.",\
		"Tonto. Pobre tonto.",\
		"Tus ojos se salen de tu craneo, la baba cae de tus labios.",\
		"Divina idiotez.",\
		"Estas igual que yo; perdedor y un libertino."\
	))

	playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
	sleep(20)

	say(pick(
		"Rey de los tontos, tu tierra es esteril. ¿Jugar de nuevo?",\
		"Divina comedia. ¿Jugar de nuevo?",\
		"La proxima vez, seguramente. ¿Jugar de nuevo?",\
		"¡Ja-...ja-ja-ja! ¡De nuevo! ¡Juega de nuevo, bufon!",\
		"¡Pobre mendigo! ¿Girarme de nuevo?"\
	))

	playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
	gamblingprob = gamblingbaseprob
	gamblingprice = 0
	oldtithe = 0
	sleep(15)
	stopgambling = 0

/obj/structure/fake_machine/lottery_roguetown/proc/peasant_betting()
	if(gamblingprice == oldtithe)
		gamblingprice += pick(1, 1, 1, 1, 2, 2)

/obj/structure/fake_machine/lottery_roguetown/proc/letsgogamblinggamblers()
	if(checkchatter > 1 || prob(90))
		return

	chatterbox = rand(1, 12)

	switch(chatterbox)
		if(1)
			say("Todavia recuerdo la lluvia en mi piel.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(30)
			say("El viento en mi pelaje... ¿o era el cabello? De cualquier manera...")
			playsound(src, 'sound/misc/machinequestion.ogg', 100, FALSE, -1)

		if(2)
			say("La adoracion a los dioses es perniciosa.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(20)
			say("¡Pero este castigo no es tan malo como otros! ¡Ja, ja, ja!")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

		if(3)
			say("Hay destinos peores que la muerte...")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(30)
			say("...especialmente para un pobre tonto que se creia un rey.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

		if(4)
			say("Ella no se dio cuenta de que su maquina la mataria, por supuesto.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(30)
			say("...aunque es dificil discutir que lo que paso despues no le beneficio a Ella.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

		if(5)
			say("Ah, ¿Psydon?")
			playsound(src, 'sound/misc/machinequestion.ogg', 100, FALSE, -1)
			sleep(30)
			say("Para ser honesto, ¡ya estoy harto de todo este debate! Ja, ja, ja... ¿No? ¿Demasiado pronto? Esta bien.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

		if(6)
			say("Sabes, bufon, esos eclesiales tienen la idea correcta.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(30)
			say("¡¿No le va a importar a alguien a los asesinos que aman a los muertos, que odian los impuestos y que consumen drogas?!")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

		if(7)
			say("Bueno, no me mires a mi para conversar.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
			sleep(30)
			say("He sido yo quien ha estado hablando todo el tiempo.")
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)

		if(8)
			say("¿No puedes oler el hedor en el aire? Es terrible.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
			sleep(30)
			say("No era tan malo antes. Podredumbre y pus. Oh, bueno.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

		if(9)
			say("¿No puedes oler el hedor en el aire, tonto? Es terrible.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)
			sleep(30)
			say("No se como pudiste perderla. Pus y podredumbre. Bueno, pues.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

		if(10)
			say("Tal vez deberias detenerte mientras estas adelante, bufon.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(30)
			say("...la avaricia es lo que metio a tu lote en este lio, despues de todo.")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

		if(11)
			say("Un padre y su hijo van en un carruaje por un bosque. ¡De repente, la maldicion de Z! ¡El eje se rompe!")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(30)
			say("El padre muere, pero el hijo... ¡el hijo aun vive! Lo llevan al medico del pueblo cercano.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			sleep(30)
			say("Al verlo, el medico ga-... ¿que quieres decir, que has oido esto antes?")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

		else
			say("Yo? ¿Soy alguien importante...? Oh, no.")
			playsound(src, 'sound/misc/machineyes.ogg', 100, FALSE, -1)
			sleep(25)
			say("¡Soy nada mas que un bufon miserable, igual que tu! ¡Ja, ja, ja!")
			playsound(src, 'sound/misc/bug.ogg', 100, FALSE, -1)

	sleep(40)
	checkchatter = rand(1, 11)
