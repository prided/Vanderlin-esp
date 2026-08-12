/obj/item/key
	name = "llave vieja"
	examine_name = "key"
	desc = "Una clave sencilla de usos sencillos."
	icon_state = "brownkey"
	icon = 'icons/roguetown/items/keys.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_weight = 20 GRAMS
	dropshrink = 0.75
	throwforce = 0
	drop_sound = 'sound/items/gems (1).ogg'
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK|ITEM_SLOT_RING
	grid_height = 32
	grid_width = 32
	slot_equipment_priority = list(
		ITEM_SLOT_NECK,
		ITEM_SLOT_HIP,
		ITEM_SLOT_RING,
		ITEM_SLOT_MOUTH,
	)


/obj/item/lockpick
	name = "ganzua"
	desc = "Una pequeña pieza de metal afilada para ayudar a abrir cerraduras en ausencia de llave."
	icon_state = "lockpick"
	icon = 'icons/roguetown/items/keys.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10
	var/picklvl = 1
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK
	destroy_sound = 'sound/items/pickbreak.ogg'
	grid_width = 32
	grid_height = 64
	item_weight = 10 GRAMS

//custom key
/obj/item/key/custom
	name = "llave personalizada"
	desc = "Una llave personalizada diseñada por un herrero."
	icon_state = "brownkey"
	var/access2add

/obj/item/key/custom/copy_access(obj/O)
	if(istype(O, /obj/item/key/custom))
		var/obj/item/key/custom/k = O
		if(k.access2add)
			src.access2add = k.access2add
			return TRUE
	var/list/access = O.get_access()
	if(access)
		access2add = access.Copy()
		return TRUE
	return FALSE

/obj/item/key/custom/examine()
	. += ..()
	if(lockids)
		. += span_info("Ha sido grabado con [access2string()].")
		. += span_info("Puede tener un nombre grabado con un martillo.")
		return
	. += span_info("Sus dientes pueden ajustarse con un martillo o copiarse de una cerradura o llave existente.")
	if(access2add)
		. += span_info("Ha sido marcado con [access2add[1]], pero no ha sido terminado.")

/obj/item/key/custom/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.cmode)
		return NONE

	if(!istype(tool, /obj/item/weapon/hammer))
		return NONE

	if(lockids)
		var/input = (input(user, "¿Como llamarias a esta clave?", "", "") as text)
		if(!input)
			return ITEM_INTERACT_BLOCKING
		name = input + " llave"
		to_chat(user, span_notice("Renombraras la llave a [name]."))
		return ITEM_INTERACT_SUCCESS

	var/input = input(user, "¿En que le gustaria configurar la ID de clave?", "", 0) as num
	input = abs(input)
	if(!input)
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Usted configuro el ID de la llave como [input]."))
	access2add = list("[input]")

	return ITEM_INTERACT_SUCCESS

/obj/item/key/custom/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(user.cmode)
		return NONE

	if(lockids)
		to_chat(user, span_warning("[src] ha terminado, ¡no se puede ajustar de nuevo!"))
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/weapon/hammer))
		if(!access2add)
			to_chat(user, span_warning("[src] no esta listo, ¡sus dientes no estan puestos!"))
			return ITEM_INTERACT_BLOCKING
		lockids = access2add
		access2add = null
		to_chat(user, span_notice("Terminas [src]."))
		return ITEM_INTERACT_SUCCESS

	if(!copy_access(tool))
		to_chat(user, span_warning("¡No puedo forjar una llave a partir de [tool]!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Forjo la llave basandome en el funcionamiento de [tool]."))

	return ITEM_INTERACT_SUCCESS

/obj/item/key/lord
	name = "llave maestra"
	desc = "La llave del Señor."
	icon_state = "bosskey"
	lockids = list(ACCESS_LORD)

/obj/item/key/lord/Initialize()
	. = ..()
	if(!istype(loc, /mob/living/carbon/human/dummy))
		SSroguemachine.key = src

/obj/item/key/lord/Destroy()
	if(SSroguemachine.key == src)
		SSroguemachine.key = null
	return ..()

/obj/item/key/lord/proc/anti_stall()
	visible_message(span_warning("[src] vuela hacia el cielo y en direccion a la fortaleza."))
	qdel(src) //Anti-stall

///// TOWN KEYS

// Worksmen

/obj/item/key/apothecary
	name = "llave de boticario"
	desc = "Llave maestra de la casa de baños."
	icon_state = "rustkey"
	lockids = list(ACCESS_APOTHECARY)

/obj/item/key/blacksmith
	name = "llave de herrero"
	desc = "La llave maestra de la herreria del pueblo."
	icon_state = "brownkey"
	lockids = list(ACCESS_SMITH)

/obj/item/key/butcher
	name = "llave de carnicero"
	desc = "Hay algo de sangre seca en esta llave, probablemente sean los carniceros."
	icon_state = "rustkey"
	lockids = list(ACCESS_BUTCHER)

/obj/item/key/tailor
	name = "llave de sastre"
	icon_state = "rustkey"
	lockids = list(ACCESS_TAILOR)

/obj/item/key/clinic
	name = "llave de la clinica"
	desc = "La llave del Medico, para las puertas de la Clinica."
	icon_state = "mazekey"
	lockids = list(ACCESS_CLINIC)

/obj/item/key/soilson
	name = "llave Soilson"
	desc = "Esta clave es utilizada por los Soilson."
	icon_state = "rustkey"
	lockids = list(ACCESS_FARM, ACCESS_BUTCHER)

/obj/item/key/merchant
	name = "llave del comerciante"
	desc = "Una llave utilizada por el Gremio de Comerciantes."
	icon_state = "cheesekey"
	lockids = list(ACCESS_MERCHANT)

/obj/item/key/tavern // Room keys at bottom of file
	name = "llave de posada"
	desc = "Esta llave deberia abrir y cerrar cualquier puerta de la posada."
	icon_state = "hornkey"
	lockids = list(ACCESS_INN)

/obj/item/key/hunter
	name = "llave del cazador"
	desc = "Esta llave deberia abrir Hunter's Lodge."
	icon_state = "hornkey"
	lockids = list(ACCESS_HUNTER)

/obj/item/key/artificer
	name = "llave del artifice"
	desc = "Esta llave de bronce deberia abrir el gremio de artifices."
	icon_state = "brownkey"
	lockids = list(ACCESS_ARTIFICER)

/obj/item/key/miner
	name = "llave de minero"
	desc = "Esta llave de bronce deberia abrir las habitaciones del minero."
	icon_state = "brownkey"
	lockids = list(ACCESS_MINER)

/obj/item/key/sweeper
	name = "llave del barrendero"
	desc = "Esta llave abre la habitacion del barrendero. Huele mal."
	icon_state = "rustkey"
	lockids = list(ACCESS_SWEEPER)

// Residents

/obj/item/key/matron
	name = "llave de matrona"
	icon_state = "rustkey"
	lockids = list(ACCESS_MATRON)

/obj/item/key/elder
	name = "llave del anciano"
	icon_state = "rustkey"
	lockids = list(ACCESS_ELDER)

/obj/item/key/feldsher
	name = "llave de feldsher"
	desc = "La llave de la propia clinica del Feldsher."
	icon_state = "birdkey"
	lockids = list(ACCESS_FELDSHER)

/obj/item/key/tower
	name = "llave de la torre"
	desc = "Esta llave deberia abrir cualquier cosa dentro de la torre."
	icon_state = "greenkey"
	lockids = list(ACCESS_TOWER)

/obj/item/key/bathhouse
	name = "llave de la casa de baños"
	desc = "Una llave para la casa de baños."
	icon_state = "brownkey"
	lockids = list(ACCESS_BATHHOUSE)

// Garrison

/obj/item/key/garrison
	name = "llave de vigilancia de la ciudad"
	desc = "Esta llave pertenece a la Guardia de la Ciudad."
	icon_state = "spikekey"
	lockids = list(ACCESS_GARRISON)

/obj/item/key/lieutenant
	name = "llave del teniente de vigilancia de la ciudad"
	desc = "Esta llave pertenece al teniente de la guardia de la ciudad."
	icon_state = "spikekey"
	lockids = list(ACCESSS_LIEUTENANT)

/obj/item/key/forrestgarrison
	name = "llave de guardia forestal"
	desc = "Esta llave pertenece a la Guardia Forestal."
	icon_state = "spikekey"
	lockids = list(ACCESS_FOREST)

/obj/item/key/captain
	name = "llave del capitan"
	desc = "Esta llave pertenece al Capitan de la Guardia de la Ciudad."
	icon_state = "cheesekey"
	lockids = list(ACCESS_CAPTAIN)

/// Mercs

/obj/item/key/tombwarden
	name = "llave del guardian"
	icon_state = "rustkey"
	lockids = list(ACCESS_TOMBWARDEN)

/obj/item/key/mercenary
	name = "llave mercenaria"
	desc = "Vaya, un mercenario no derribaria puertas a patadas."
	icon_state = "greenkey"
	lockids = list(ACCESS_MERC)

/obj/item/key/tomb
	name = "llave del excavador"
	desc = span_red("Bajamos...")
	icon_state = "tombkey"
	lockids = list(ACCESS_TOMB)

/obj/item/key/warehouse
	name = "llave del almacen"
	desc = "Esta llave abre el almacen del mayordomo."
	icon_state = "rustkey"
	lockids = list(ACCESS_WAREHOUSE)

/obj/item/key/bogwitch
	name = "llave de la bruja"
	desc = "Esta llave abre la cabaña de Bog Witch."
	icon_state = "hornkey"
	lockids = list(ACCESS_BOGWITCH)

////// MANOR

/obj/item/key/manor
	name = "mantener la llave"
	desc = "Esta llave abrira la mayoria de las puertas de la Fortaleza."
	icon_state = "mazekey"
	lockids = list(ACCESS_MANOR)

/obj/item/key/butler
	name = "llave maestra de la fortaleza"
	desc = "Esta llave abrira casi todas las puertas de la Fortaleza."
	icon_state = "royalkey"
	lockids = list(ACCESS_MANOR, ACCESS_BUTLER, ACCESS_SERVANT)

/obj/item/key/servant
	name = "llave de servicio de la fortaleza"
	lockids = list(ACCESS_MANOR, ACCESS_SERVANT)
	icon_state = "servekey"

/obj/item/key/hand
	name = "llave de la mano"
	desc = "Esta llave regia pertenece a la Mano Derecha del Monarca."
	icon_state = "cheesekey"
	lockids = list(ACCESS_HAND, ACCESS_COURTAGENT, ACCESS_SERVANT)

/obj/item/key/courtagent
	name = "llave del escondite del agente judicial"
	desc = "Esta llave deberia abrir las puertas del escondite del agente judicial."
	icon_state = "rustkey"
	lockids = list(ACCESS_COURTAGENT)

/obj/item/key/steward
	name = "llave del mayordomo"
	desc = "Esta llave pertenece al codicioso mayordomo del Monarca."
	icon_state = "cheesekey"
	lockids = list(ACCESS_STEWARD)

/obj/item/key/vault
	name = "llave de la boveda"
	desc = "Esta llave abre la poderosa Boveda."
	icon_state = "cheesekey"
	lockids = list(ACCESS_VAULT)

/obj/item/key/dungeon
	name = "llave de mazmorra"
	desc = "Esta llave deberia abrir las barras y puertas oxidadas de la mazmorra."
	icon_state = "rustkey"
	lockids = list(ACCESS_DUNGEON)

/obj/item/key/consort
	name = "llave consorte"
	desc = "La llave de la Consorte."
	icon_state = "royalkey"
	lockids = list(ACCESS_MANOR, ACCESS_SERVANT, ACCESS_BUTLER, ACCESS_CONSORT)

/obj/item/key/consort/monarch
	name = "llave de repuesto del monarca"
	desc = "La llave de repuesto del monarca."

/obj/item/key/heir
	name = "llave del heredero"
	desc = "La llave de un culo real."
	icon_state = "lessroyalkey"
	lockids = list(ACCESS_HEIR, ACCESS_MANOR)

/obj/item/key/gatehouse
	name = "llave de la entrada de la fortaleza"
	desc = "Esta es una llave oxidada de Keep Gatehouse."
	icon_state = "rustkey"
	lockids = list(ACCESS_MANOR_GATE)

/obj/item/key/archivist
	name = "llave del archivero"
	desc = "Un olor a tinta, pergamino y polvo se pega a esta llave."
	icon_state = "ekey"
	lockids = list(ACCESS_ARCHIVIST)

/obj/item/key/archive
	name = "clave de archivo"
	desc = "Esta llave parece apenas utilizada."
	icon_state = "ekey"
	lockids = list(ACCESS_LIBRARY)

/obj/item/key/mage
	name = "la llave de los magos"
	desc = "Esta es la clave del Mago de la Corte. Te observa..."
	icon_state = "eyekey"
	lockids = list(ACCESS_MAGE)

/obj/item/key/atarms
	name = "llave de la guarnicion de la fortaleza"
	desc = "Una llave entregada a los hombres de armas del Monarca."
	icon_state = "spikekey"
	lockids = list(ACCESS_AT_ARMS)

/obj/item/key/guest
	name = "llave maestra de la habitacion de invitados"
	desc = "La llave de las habitaciones de huespedes. No para distribucion."
	icon_state = "greenkey"
	lockids = list(ACCESS_GUEST1, ACCESS_GUEST2, ACCESS_GUEST3)

/obj/item/key/guest/one
	name = "habitacion de invitados 1 llave"
	desc = "La llave de la habitacion de invitados. Entregado a los nobles visitantes."
	icon_state = "brownkey"
	lockids = list(ACCESS_GUEST1)

/obj/item/key/guest/two
	name = "llave de la habitacion de invitados 2"
	desc = "La llave de la habitacion de invitados. Entregado a los nobles visitantes."
	icon_state = "brownkey"
	lockids = list(ACCESS_GUEST2)

/obj/item/key/guest/three
	name = "llave de la habitacion de invitados 3"
	desc = "La llave de la habitacion de invitados. Entregado a los nobles visitantes."
	icon_state = "brownkey"
	lockids = list(ACCESS_GUEST3)

/obj/item/key/courtphys
	name = "llave del medico de la corte"
	desc = "Una llave concedida al honorable Medico de la Corte."
	icon_state = "ankhkey"
	lockids = list(ACCESS_PHYSICIAN)

////// CHURCH

/obj/item/key/church
	name = "llave de la iglesia"
	desc = "Esta llave de bronce deberia abrir casi todas las puertas de la iglesia."
	icon_state = "brownkey"
	lockids = list(ACCESS_CHURCH)

/obj/item/key/priest
	name = "llave del sacerdote"
	desc = "La llave de los aposentos del sacerdote."
	icon_state = "cheesekey"
	lockids = list(ACCESS_PRIEST)

/obj/item/key/graveyard
	desc = "Esta llave oxidada pertenece a los Gravetenders."
	icon_state = "rustkey"
	lockids = list(ACCESS_GRAVE)

/obj/item/key/inquisition
	name = "llave de la inquisicion"
	desc = "Esta es una clave compleja."
	icon_state = "mazekey"
	lockids = list(ACCESS_RITTER)

// HOUSES

/obj/item/key/houses
	name = "REPORT TO MAPPERS"
	icon_state = "brownkey"

/obj/item/key/houses/house1
	name = "llave de la casa I"
	lockids = list("house1")

/obj/item/key/houses/house2
	name = "llave de la casa II"
	lockids = list("house2")

/obj/item/key/houses/house3
	name = "llave de la casa III"
	lockids = list("house3")

/obj/item/key/houses/house4
	name = "llave de la casa IV"
	lockids = list("house4")

/obj/item/key/houses/house5
	name = "llave de la casa V"
	lockids = list("house5")

/obj/item/key/houses/house6
	name = "llave de la casa VI"
	lockids = list("house6")

/obj/item/key/houses/house7
	name = "llave de la casa VII"
	lockids = list("house7")

/obj/item/key/houses/house8
	name = "llave de la casa VIII"
	lockids = list("house8")

/obj/item/key/houses/house9
	name = "llave de la casa IX"
	lockids = list("house9")

/obj/item/key/houses/waterfront1
	name = "llave de la calle costera I"
	lockids = list("waterfront1")

/obj/item/key/houses/waterfront2
	name = "llave de la calle costera II"
	lockids = list("waterfront2")

/obj/item/key/houses/waterfront3
	name = "llave de la calle costera III"
	lockids = list("waterfront3")

/obj/item/key/houses/waterfront4
	name = "llave de la calle costera IV"
	lockids = list("waterfront4")

/obj/item/key/houses/waterfront5
	name = "llave de la calle costera V"
	lockids = list("waterfront5")

// APARTMENTS AND PENTHOUSES

/obj/item/key/apartments
	name = "REPORT TO MAPPERS"
	icon_state = "brownkey"

/obj/item/key/apartments/slums1
	name = "llave de los barrios bajos I"
	lockids = list("slums1")

/obj/item/key/apartments/slums2
	name = "llave de los barrios bajos II"
	lockids = list("slums2")

/obj/item/key/apartments/slums3
	name = "llave de los barrios bajos III"
	lockids = list("slums3")

/obj/item/key/apartments/slums4
	name = "llave de los barrios bajos IV"
	lockids = list("slums4")

/obj/item/key/apartments/slums5
	name = "llave de los barrios bajos V"
	lockids = list("slums5")

/obj/item/key/apartments/slums6
	name = "llave de los barrios bajos VI"
	lockids = list("slums6")

/obj/item/key/apartments/apartment1
	name = "apartamento i llave"
	lockids = list("apartment1")

/obj/item/key/apartments/apartment2
	name = "llave del apartamento ii"
	lockids = list("apartment2")

/obj/item/key/apartments/apartment3
	name = "llave del apartamento iii"
	lockids = list("apartment3")

/obj/item/key/apartments/apartment4
	name = "llave del apartamento IV"
	lockids = list("apartment4")

/obj/item/key/apartments/apartment5
	name = "apartamento v llave"
	lockids = list("apartment5")

/obj/item/key/apartments/apartment6
	name = "llave del apartamento VI"
	lockids = list("apartment6")

/obj/item/key/apartments/apartment7
	name = "llave del apartamento vii"
	lockids = list("apartment7")

/obj/item/key/apartments/apartment8
	name = "llave del apartamento viii"
	lockids = list("apartment8")

/obj/item/key/apartments/apartment9
	name = "llave del apartamento ix"
	lockids = list("apartment9")

/obj/item/key/apartments/apartment10
	name = "llave del apartamento X"
	lockids = list("apartment10")

/obj/item/key/apartments/apartment11
	name = "llave del apartamento xi"
	lockids = list("apartment11")

/obj/item/key/apartments/apartment12
	name = "llave del apartamento XII"
	lockids = list("apartment12")

/obj/item/key/apartments/apartment13
	name = "llave del apartamento xiii"
	lockids = list("apartment13")

/obj/item/key/apartments/apartment14
	name = "llave del apartamento XIV"
	lockids = list("apartment14")

/obj/item/key/apartments/apartment15
	name = "llave del apartamento xv"
	lockids = list("apartment15")

/obj/item/key/apartments/apartment16
	name = "llave del apartamento XVI"
	lockids = list("apartment16")

/obj/item/key/apartments/apartment17
	name = "llave del apartamento xvii"
	lockids = list("apartment17")

/obj/item/key/apartments/apartment18
	name = "llave del apartamento xviii"
	lockids = list("apartment18")

/obj/item/key/apartments/apartment19
	name = "llave del apartamento XIX"
	lockids = list("apartment19")

/obj/item/key/apartments/apartment20
	name = "llave del apartamento xx"
	lockids = list("apartment20")

/obj/item/key/apartments/apartment21
	name = "llave del apartamento xxi"
	lockids = list("apartment21")

/obj/item/key/apartments/apartment22
	name = "llave del apartamento XXII"
	lockids = list("apartment22")

/obj/item/key/apartments/apartment23
	name = "llave del apartamento XXIII"
	lockids = list("apartment23")

/obj/item/key/apartments/apartment24
	name = "llave del apartamento XXIV"
	lockids = list("apartment24")

/obj/item/key/apartments/apartment25
	name = "llave del apartamento XXV"
	lockids = list("apartment25")

/obj/item/key/apartments/penthouse1
	name = "llave del atico I"
	lockids = list("penthouse1")

/obj/item/key/apartments/penthouse2
	name = "llave del atico II"
	lockids = list("penthouse2")

/obj/item/key/apartments/merc1
	name = "llave del apartamento de mercenarios I"
	lockids = list("merc1")

/obj/item/key/apartments/merc2
	name = "llave del apartamento de mercenarios II"
	lockids = list("merc2")

/obj/item/key/apartments/merc3
	name = "llave del apartamento de mercenarios III"
	lockids = list("merc3")

/obj/item/key/apartments/merc4
	name = "llave del apartamento de mercenarios IV"
	lockids = list("merc4")

/obj/item/key/apartments/merc5
	name = "apartamento mercenario v llave"
	lockids = list("merc5")

/obj/item/key/apartments/merc6
	name = "llave del apartamento de mercenarios VI"
	lockids = list("merc6")

/obj/item/key/apartments/adv1
	name = "llave del apartamento de aventureros I"
	lockids = list("adv1")

/obj/item/key/apartments/adv2
	name = "llave del apartamento de aventureros II"
	lockids = list("adv2")

/obj/item/key/apartments/adv3
	name = "llave del apartamento de aventureros III"
	lockids = list("adv3")

/obj/item/key/apartments/adv4
	name = "llave del apartamento de aventureros IV"
	lockids = list("adv4")

/obj/item/key/apartments/adv5
	name = "llave del apartamento de aventureros V"
	lockids = list("adv5")

/obj/item/key/apartments/adv6
	name = "llave del apartamento de aventureros VI"
	lockids = list("adv6")

// SHOP KEYS

/obj/item/key/shops
	name = "REPORT TO MAPPERS"
	icon_state = "rustkey"

/obj/item/key/shops/shop1
	name = "llave de la tienda I"
	lockids = list("shop1")

/obj/item/key/shops/shop2
	name = "llave de la tienda II"
	lockids = list("shop2")

/obj/item/key/shops/shop3
	name = "llave de la tienda III"
	lockids = list("shop3")

/obj/item/key/shops/shop4
	name = "llave de la tienda IV"
	lockids = list("shop4")

/obj/item/key/shops/shop5
	name = "llave de la tienda V"
	lockids = list("shop5")

/obj/item/key/shops/shop6
	name = "llave de la tienda VI"
	lockids = list("shop6")

/obj/item/key/shops/shop7
	name = "llave de la tienda VII"
	lockids = list("shop7")

/obj/item/key/shops/shop8
	name = "llave de la tienda VIII"
	lockids = list("shop8")

/obj/item/key/shops/shop9
	name = "llave de la tienda IX"
	lockids = list("shop9")

// INN ROOMS

/obj/item/key/roomi
	name = "llave de la habitacion I"
	desc = "La llave de la primera habitacion."
	icon_state = "brownkey"
	lockids = list("roomi")

/obj/item/key/roomii
	name = "llave de la habitacion II"
	desc = "La llave de la segunda habitacion."
	icon_state = "brownkey"
	lockids = list("roomii")

/obj/item/key/roomiii
	name = "llave de la habitacion III"
	desc = "La llave de la tercera habitacion."
	icon_state = "brownkey"
	lockids = list("roomiii")

/obj/item/key/roomiv
	name = "llave de la habitacion IV"
	desc = "La llave de la cuarta habitacion."
	icon_state = "brownkey"
	lockids = list("roomiv")

/obj/item/key/roomv
	name = "llave de la habitacion V"
	desc = "La llave de la quinta habitacion."
	icon_state = "brownkey"
	lockids = list("roomv")

/obj/item/key/roomvi
	name = "llave de la habitacion VI"
	desc = "La llave de la sexta habitacion."
	icon_state = "brownkey"
	lockids = list("roomvi")

/obj/item/key/medroomi
	name = "llave de la habitacion mediana I"
	desc = "La llave de la primera habitacion mediana."
	icon_state = "brownkey"
	lockids = list("medroomi")

/obj/item/key/medroomii
	name = "llave de la habitacion mediana II"
	desc = "La llave de la segunda habitacion mediana."
	icon_state = "brownkey"
	lockids = list("medroomii")

/obj/item/key/medroomiii
	name = "llave de la habitacion mediana III"
	desc = "La llave de la tercera habitacion mediana."
	icon_state = "brownkey"
	lockids = list("medroomiii")

/obj/item/key/medroomiv
	name = "llave de la habitacion mediana IV"
	desc = "La llave de la cuarta habitacion mediana."
	icon_state = "brownkey"
	lockids = list("medroomiv")

/obj/item/key/medroomv
	name = "llave de la habitacion mediana V"
	desc = "La llave de la quinta habitacion mediana."
	icon_state = "brownkey"
	lockids = list("medroomv")

/obj/item/key/medroomvi
	name = "llave de la habitacion mediana VI"
	desc = "La llave de la sexta habitacion mediana."
	icon_state = "brownkey"
	lockids = list("medroomvi")

/obj/item/key/luxroomi
	name = "llave de la habitacion de lujo I"
	desc = "La llave de la primera habitacion de lujo."
	icon_state = "brownkey"
	lockids = list("luxroomi")

/obj/item/key/luxroomii
	name = "llave de la habitacion de lujo II"
	desc = "La llave de la segunda habitacion de lujo."
	icon_state = "brownkey"
	lockids = list("luxroomii")

/obj/item/key/luxroomiii
	name = "llave de la habitacion de lujo III"
	desc = "La llave de la tercera habitacion de lujo."
	icon_state = "brownkey"
	lockids = list("luxroomiii")

/obj/item/key/luxroomiv
	name = "llave de la habitacion de lujo IV"
	desc = "La llave de la cuarta habitacion de lujo."
	icon_state = "brownkey"
	lockids = list("luxroomiv")

/obj/item/key/luxroomv
	name = "llave de la habitacion de lujo V"
	desc = "La llave de la quinta habitacion de lujo."
	icon_state = "brownkey"
	lockids = list("luxroomv")

/obj/item/key/luxroomvi
	name = "llave de la habitacion de lujo VI"
	desc = "La llave de la sexta habitacion de lujo."
	icon_state = "brownkey"
	lockids = list("luxroomvi")

/obj/item/key/roomhunt
	name = "llave de la habitacion HUNT"
	desc = "La llave de la posada mas lujosa."
	icon_state = "brownkey"
	lockids = list("roomhunt")

/obj/item/key/thatchwood
	name = "ABSTRACT THATCHWOOD KEY CALL CODERS"
	desc = "Pongase en contacto con un desarrollador en Discord o haga un informe de error"
	icon_state = "brownkey"
	abstract_type = /obj/item/key/thatchwood

/obj/item/key/thatchwood/farm
	name = "antigua llave de granja"
	desc = "Una llave oxidada. Motas de suciedad y tierra cubren su mango."
	lockids = list("oldfarm")

/obj/item/key/thatchwood/smithy
	name = "vieja llave de herreria"
	desc = "Una llave oxidada."
	lockids = list("oldsmith")

/obj/item/key/thatchwood/inn1
	name = "llave de la habitacion I"
	desc = "Una llave oxidada. En su mango lleva grabado el numero I."
	lockids = list("oldinn1")

/obj/item/key/thatchwood/inn2
	name = "llave de la habitacion II"
	desc = "Una llave oxidada. En su mango lleva grabado el numero II."
	lockids = list("oldinn2")

/obj/item/key/thatchwood/inn3
	name = "llave de la habitacion lateral"
	desc = "Una llave oxidada. Algo estaba grabado en su mango, pero ya no puedes distinguirlo."
	lockids = list("oldinn3")

// Special Keys

// grenchensnacker
/obj/item/key/porta
	name = "llave extraña"
	desc = "¿Esta llave fue encantada por un cerrajero...?"
	icon_state = "eyekey"
	lockids = list("porta")

/obj/item/key/vampire
	desc = "Esta llave es terriblemente rosa y tiene una forma extraña."
	icon_state = "vampkey"
	lockids = list("mansionvampire")

/obj/item/key/bandit
	icon_state = "mazekey"
	lockids = list("banditcamp")


////// MINOR NOBLES
/obj/item/key/mnoble1_blue
	name = "Llave de la casa noble 1"
	desc = "Una llave de acero muy detallada, tiene detalles dorados y una piedra preciosa morada... es para la casa noble numero uno."
	icon_state = "noble1"
	lockids = list(ACCESS_NOBLE1)

/obj/item/key/mnoble2_yellow
	name = "Llave de la casa noble 2"
	desc = "Una llave de acero muy detallada, tiene detalles dorados y una piedra preciosa amarilla... es para la casa noble numero dos."
	icon_state = "noble2"
	lockids = list(ACCESS_NOBLE2)

/obj/item/key/mnoble3_red
	name = "Llave de la casa noble 3"
	desc = "Una llave de acero muy detallada, tiene detalles dorados y una piedra preciosa roja... ¿es para la casa noble numero tres?"
	icon_state = "noble3"
	lockids = list(ACCESS_NOBLE3)
