/obj/structure/fake_machine/atm
	name = "MEISTER"
	desc = "Almacena y retira moneda para cuentas administradas por el Reino."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm"
	density = FALSE
	blade_dulling = DULLING_BASH
	SET_BASE_PIXEL(0, 32)

/obj/structure/fake_machine/atm/attack_hand(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/user_mob = user

	if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE) && prob(33))
		to_chat(user_mob, "<span class='warning'>¡La idea me repugna!</span>")
		user_mob.cursed_freak_out()
		return

	if(user_mob.real_name in GLOB.outlawed_players)
		say("¡DETECTADO UN FORAGIDO! ¡NEGAR SERVICIO!")
		return

	if(user_mob in SStreasury.bank_accounts)
		var/amt = SStreasury.bank_accounts[user_mob]
		if(!amt)
			say("Tu saldo es cero.")
			return
		if(amt < 0)
			say("Su saldo es NEGATIVO.")
			return
		var/list/choicez = list()
		if(amt >= 10)
			choicez += "GOLD"
		if(amt >= 5)
			choicez += "SILVER"
		if(amt > 1) choicez += "BRONZE"
		var/selection = input(user_mob, "Haz una seleccion", src) as null|anything in choicez
		if(!selection)
			return
		amt = SStreasury.bank_accounts[user_mob]
		var/mod = 1
		if(selection == "GOLD")
			mod = 10
		if(selection == "SILVER")
			mod = 5
		if(selection == "BRONZE") mod = 1
		var/coin_amt = input(user_mob, "Hay [SStreasury.treasury_value] mammon en el tesoro. Puedes retirar [amt/mod] [selection] MONEDAS de tu cuenta.", src) as null|num
		coin_amt = round(coin_amt)
		if(coin_amt < 1)
			return
		amt = SStreasury.bank_accounts[user_mob]
		if(!Adjacent(user_mob))
			return
		if((coin_amt*mod) > amt)
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		if(!SStreasury.withdraw_money_account(coin_amt*mod, user_mob))
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		record_round_statistic(STATS_MAMMONS_WITHDRAWN, coin_amt * mod)
		budget2change(coin_amt*mod, user_mob, selection)
	else
		to_chat(user_mob, "<span class='warning'>La maquina me muerde el dedo.</span>")
		icon_state = "atm-b"
		user_mob.flash_fullscreen("redflash3")
		playsound(user_mob, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
		SStreasury.create_bank_account(user_mob)
		if(user_mob.mind)
			var/datum/job/target_job = SSjob.GetJob(user_mob.mind.assigned_role)
			if(target_job && target_job.noble_income)
				SStreasury.noble_incomes[user_mob] = target_job.noble_income
		spawn(5)
			say("Nueva cuenta creada.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/obj/structure/fake_machine/atm/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/coin/inqcoin))
		return

	if(!istype(tool, /obj/item/coin))
		return NONE

	if(!ishuman(user))
		return NONE

	var/mob/living/carbon/human/H = user
	if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE) && prob(33))
		to_chat(H, "<span class='warning'>¡La idea me repugna!</span>")
		H.cursed_freak_out()
		return ITEM_INTERACT_SUCCESS

	if(user.real_name in GLOB.outlawed_players)
		say("¡DETECTADO UN FORAGIDO! ¡NEGAR SERVICIO!")
		return ITEM_INTERACT_SUCCESS

	if(!(H in SStreasury.bank_accounts))
		say("No se encontro ninguna cuenta. Envia tus dedos para su inspeccion.")
		return ITEM_INTERACT_SUCCESS

	var/list/deposit_results = SStreasury.generate_money_account(tool.get_real_price(), H)
	if(islist(deposit_results))
		record_round_statistic(STATS_MAMMONS_DEPOSITED, deposit_results[1] - deposit_results[2])
		if(deposit_results[2] != 0)
			say("Tu deposito fue gravado [deposit_results[2]] mammon.")
			record_featured_stat(FEATURED_STATS_TAX_PAYERS, H, deposit_results[2])
			record_round_statistic(STATS_TAXES_COLLECTED, deposit_results[2])
			add_abstract_elastic_data(ELASCAT_ECONOMY, ELASDATA_TAXES_COLLECTED, deposit_results[2])

	qdel(tool)
	playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
	return ITEM_INTERACT_SUCCESS

/obj/structure/fake_machine/atm/examine(mob/user)
	. += ..()
	. += span_info("La tasa impositiva actual sobre los depositos es del [SStreasury.tax_value * 100] por ciento. Los nobles del reino estan exentos.")
