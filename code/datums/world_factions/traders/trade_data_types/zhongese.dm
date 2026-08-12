/datum/outfit/zhongese
	head = /obj/item/clothing/head/takuhatsugasa
	armor = /obj/item/clothing/shirt/robe/kimono
	//cloak = /obj/item/clothing/cloak/raincloak/purple

/datum/trader_data/sake_merchant
	name = "Sake"
	base_type = list()
	initial_products = list()
	outfit_override = list(/obj/effect/mob_spawn/corpse/human/triton/zhong)
	max_custom_items = 6
	custom_items = list(
		/obj/item/reagent_containers/glass/bottle/black/huangjiu = list(3, 25, 3),
		/obj/item/reagent_containers/glass/bottle/black/baijiu = list(4, 35, 2),
		/obj/item/reagent_containers/glass/bottle/black/yaojiu = list(5, 45, 2),
		/obj/item/reagent_containers/glass/bottle/black/shejiu = list(6, 50, 1),
		/obj/item/reagent_containers/glass/bottle/black/murkwine = list(4, 30, 2),
		/obj/item/reagent_containers/glass/bottle/black/nocshine = list(7, 60, 1),
		/obj/item/reagent_containers/glass/bottle/black/whipwine = list(5, 40, 2),
		/obj/item/reagent_containers/glass/bottle/black/komuchisake = list(8, 75, 1),
	)
	initial_wanteds = list(
		/obj/item/reagent_containers/glass/bottle = list(2, INFINITY, ""),
		/obj/item/reagent_containers/food/snacks/produce/grain = list(5, INFINITY, ""),
	)
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"This dishonors my collection. Bring me something worthy of the shogun's table.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"Perhaps you will find wisdom in reconsidering, honored customer.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"May this sake bring you prosperity and honor!",
		),
		INTERESTED_PHRASE = list(
			"Ah, this item has caught my discerning eye! I would trade good coin for such quality.",
		),
		BUY_PHRASE = list(
			"¡Una transacción muy honorable! Que los espíritus te favorezcan.",
		),
		NO_CASH_PHRASE = list(
			"Honorable customer, fine sake requires proper payment. Return when your purse matches your taste!",
		),
		NO_STOCK_PHRASE = list(
			"Regrettably, that particular brew has been emptied from my stores.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"I must respectfully decline to purchase that item at this time.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"This swill brings dishonor to the art of brewing!",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"My cellars overflow with that particular item already.",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"No busco compras en este momento, honorable.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"My stores are barren at present. Please return when the next shipment arrives.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"¿Te atreves a robarle a un comerciante del shogun?",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"Esta... no es la muerte honorable que imaginé...",
		),
		TRADER_LORE_PHRASE = list(
			"Sacred brews from the temples of distant Zhong!",
			"¡Cada botella lleva la bendición de los antiguos maestros cerveceros!",
			"¡Vino de arroz envejecido a la sombra de los cerezos en flor!",
			"Sake fit for samurai and nobles alike!",
			"¡Recetas antiguas de la Tierra del Sol Naciente!",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Welcome, honored customer! Behold the finest sake from across the eastern seas!",
		),
	)

/datum/trader_data/eastern_weapons
	name = "Eastern Blades"
	base_type = list()
	initial_products = list()
	outfit_override = list(/obj/effect/mob_spawn/corpse/human/triton/zhong)
	max_custom_items = 6
	custom_items = list(
		/obj/item/weapon/sword/katana/mulyeog = list(3, 45, 3),
		/obj/item/weapon/sword/katana/mulyeog/rumahench = list(4, 65, 2),
		/obj/item/weapon/sword/katana/mulyeog/rumacaptain = list(6, 120, 1),
		/obj/item/weapon/sword/sabre/hook = list(5, 85, 2),
		/obj/item/weapon/polearm/spear/naginata = list(6, 90, 2),
		/obj/item/weapon/knife/dagger/navaja = list(6, 75, 1),
		/obj/item/weapon/whip/nagaika = list(5, 60, 2),
	)
	initial_wanteds = list(
		/obj/item/natural/stone = list(2, INFINITY, ""),
		/obj/item/ingot/iron = list(3, INFINITY, ""),
		/obj/item/ingot/steel = list(5, INFINITY, ""),
		/obj/item/natural/hide = list(2, INFINITY, ""),
	)
	say_phrases = list(
		ITEM_REJECTED_PHRASE = list(
			"This crude metal dishonors the ancient forging traditions. Bring me quality materials worthy of a master smith.",
		),
		ITEM_SELLING_CANCELED_PHRASE = list(
			"Perhaps the blade was not meant for your hands after all, honored one.",
		),
		ITEM_SELLING_ACCEPTED_PHRASE = list(
			"¡Que esta espada te sirva con honor y traiga una rápida victoria a tus enemigos!",
		),
		INTERESTED_PHRASE = list(
			"Ah! This material speaks to my craftsman's soul. I would pay handsomely for such quality!",
		),
		BUY_PHRASE = list(
			"A blade forged with honor finds its destined wielder. Fight well, warrior!",
		),
		NO_CASH_PHRASE = list(
			"Master-crafted steel demands worthy payment, friend. Return when your coin purse matches your ambition!",
		),
		NO_STOCK_PHRASE = list(
			"Alas, that particular blade has already found its destined master.",
		),
		NOT_WILLING_TO_BUY_PHRASE = list(
			"No necesito esos artículos en mi forja en este momento.",
		),
		ITEM_IS_WORTHLESS_PHRASE = list(
			"This scrap metal brings shame to all who work the forge!",
		),
		TRADER_HAS_ENOUGH_ITEM_PHRASE = list(
			"My armory already overflows with that particular material.",
		),
		TRADER_NOT_BUYING_ANYTHING = list(
			"No busco materiales en este momento, honorable herrero.",
		),
		TRADER_NOT_SELLING_ANYTHING = list(
			"My forge runs cold today. Return when the fires burn bright again.",
		),
		TRADER_BATTLE_START_PHRASE = list(
			"You dare threaten a master of the blade?! Face the steel you sought to steal!",
		),
		TRADER_BATTLE_END_PHRASE = list(
			"My... final blade... has been... forged...",
		),
		TRADER_LORE_PHRASE = list(
			"Blades forged in the sacred fires of distant mountain temples!",
			"¡Cada espada lleva el alma de su creador y el honor de los antiguos guerreros!",
			"Steel folded a thousand times under the light of the eastern moon!",
			"Hook swords - the weapon of choice for legendary duelists!",
			"Ruma clan steel, blessed by the spirits of fallen samurai!",
			"¡Espadas extranjeras que han probado la victoria en cien batallas!",
		),
		TRADER_SHOP_OPENING_PHRASE = list(
			"Welcome, warrior! Behold the finest eastern steel ever forged by mortal hands!",
		),
	)
