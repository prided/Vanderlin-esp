/datum/supply_pack/tools
	group = "Tools"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant
	abstract_type = /datum/supply_pack/tools

/datum/supply_pack/tools/rope
	name = "Rope"
	cost = 5
	contains = /obj/item/rope

/datum/supply_pack/tools/chain
	name = "Cadena"
	cost = 25
	contains = /obj/item/rope/chain

/datum/supply_pack/tools/lockpicks
	name = "Lockpicks"
	cost = 20
	contains = /obj/item/lockpickring/mundane

/datum/supply_pack/tools/keyrings
	name = "Llavero"
	cost = 5
	contains = /obj/item/storage/keyring

/datum/supply_pack/tools/needle
	name = "Aguja De Coser"
	cost = 10
	contains = /obj/item/needle

/datum/supply_pack/tools/sleepingbag
	name = "Saco de dormir"
	cost = 12
	contains = /obj/item/sleepingbag

/datum/supply_pack/tools/scroll
	name = "Pergamino x5"
	cost = 10
	contains = list(/obj/item/paper/scroll,/obj/item/paper/scroll,/obj/item/paper/scroll,/obj/item/paper/scroll,/obj/item/paper/scroll)

/datum/supply_pack/tools/parchment
	name = "Pergamino x5"
	cost = 8
	contains = list(/obj/item/paper,/obj/item/paper,/obj/item/paper,/obj/item/paper,/obj/item/paper)

/datum/supply_pack/tools/flint
	name = "Flint"
	cost = 5
	contains = /obj/item/flint

/datum/supply_pack/tools/dyebin
	name = "Dye Bin"
	cost = 50
	contains = /obj/structure/dye_bin

/datum/supply_pack/tools/plough
	name = "Arado"
	cost = 45
	contains = /obj/structure/plough

/datum/supply_pack/tools/candles
	name = "Velas (3)"
	cost = 5
	contains = list(/obj/item/candle/yellow,
	/obj/item/candle/yellow,
	/obj/item/candle/yellow)

/datum/supply_pack/tools/lamptern
	name = "Lampara de hierro"
	cost = 20
	contains = /obj/item/flashlight/flare/torch/lantern

/datum/supply_pack/tools/pick
	name = "Pico de hierro"
	cost = 25
	contains = /obj/item/weapon/pick

/datum/supply_pack/tools/pick
	name = "Steel Pick"
	cost = 45
	contains = /obj/item/weapon/pick/steel

/datum/supply_pack/tools/tongs
	name = "Tongs"
	cost = 20
	contains = /obj/item/weapon/tongs

/datum/supply_pack/tools/hammer
	name = "Martillo"
	cost = 25
	contains = /obj/item/weapon/hammer/iron

/datum/supply_pack/tools/shovel
	name = "Shovel"
	cost = 25
	contains = /obj/item/weapon/shovel

/datum/supply_pack/tools/Sickle
	name = "Hoz"
	cost = 25
	contains = /obj/item/weapon/sickle

/datum/supply_pack/tools/pitchfork
	name = "Pitchfork"
	cost = 30
	contains = /obj/item/weapon/pitchfork

/datum/supply_pack/tools/hoe
	name = "Azada"
	cost = 25
	contains = /obj/item/weapon/hoe

/datum/supply_pack/tools/thresher
	name = "Thresher"
	cost = 10
	contains = /obj/item/weapon/thresher

/datum/supply_pack/tools/bucket
	name = "Bucket"
	cost = 3
	contains = /obj/item/reagent_containers/glass/bucket/wooden

/datum/supply_pack/tools/fryingpan
	name = "Sarten"
	cost = 15
	contains = /obj/item/cooking/pan

/datum/supply_pack/tools/pot
	name = "Olla de cocina"
	cost = 10
	contains = /obj/item/reagent_containers/glass/bucket/pot

/datum/supply_pack/tools/wpipe
	name = "Westman Pipe"
	cost = 5
	contains = /obj/item/clothing/face/cigarette/pipe/westman

/datum/supply_pack/tools/fishingrod
	name = "Fishing Rod"
	cost = 10
	contains = /obj/item/fishingrod

/datum/supply_pack/tools/bait
	name = "Fishing Grub x5"
	cost = 20
	contains = list(/obj/item/fishing/lure/deluxe,/obj/item/fishing/lure/deluxe,/obj/item/fishing/lure/deluxe,/obj/item/fishing/lure/deluxe,/obj/item/fishing/lure/deluxe)

/datum/supply_pack/tools/fishingline
	name = "Premium Fishing Line"
	cost = 25
	contains = /obj/item/fishing/reel/deluxe

/datum/supply_pack/tools/fishinghook
	name = "Anzuelo de pesca premium"
	cost = 25
	contains = /obj/item/fishing/hook/deluxe

/datum/supply_pack/tools/bottle
	name = "Botella de vidrio x3"
	cost = 10
	contains = list(/obj/item/reagent_containers/glass/bottle,/obj/item/reagent_containers/glass/bottle,/obj/item/reagent_containers/glass/bottle)

/datum/supply_pack/tools/alch_bottles
	name = "Alchemy Bottles x5"
	cost = 20
	contains = list(/obj/item/reagent_containers/glass/alchemical,/obj/item/reagent_containers/glass/alchemical,
	/obj/item/reagent_containers/glass/alchemical,/obj/item/reagent_containers/glass/alchemical,/obj/item/reagent_containers/glass/alchemical)

/datum/supply_pack/tools/bottle_kit
	name = "Kit de embotellado"
	cost = 30
	contains = list(/obj/item/bottle_kit)

/datum/supply_pack/tools/medical
	group = "Medicine"
	abstract_type = /datum/supply_pack/tools/medical

/datum/supply_pack/tools/medical/health
	name = "Pocion curativa"
	cost = 75
	contains = /obj/item/reagent_containers/glass/bottle/healthpot

/datum/supply_pack/tools/medical/mana
	name = "Pocion de mana"
	cost = 75
	contains = /obj/item/reagent_containers/glass/bottle/manapot

/datum/supply_pack/tools/medical/surgerybag
	name = "Conjunto de herramientas quirurgicas"
	cost = 60
	contains = /obj/item/storage/backpack/satchel/surgbag

/datum/supply_pack/tools/medical/prarml
	name = "Brazo de madera izquierdo"
	cost = 20
	contains = /obj/item/bodypart/l_arm/prosthetic/wood

/datum/supply_pack/tools/medical/prarmr
	name = "Brazo de madera derecho"
	cost = 20
	contains = /obj/item/bodypart/r_arm/prosthetic/wood

/datum/supply_pack/tools/medical/prlegl
	name = "Pegleg Left Leg"
	cost = 20
	contains = /obj/item/bodypart/l_leg/prosthetic/wood

/datum/supply_pack/tools/medical/prlegr
	name = "Pegleg Right Leg"
	cost = 20
	contains = /obj/item/bodypart/r_leg/prosthetic/wood


