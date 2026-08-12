/datum/anvil_recipe/valuables
	appro_skill = /datum/attribute/skill/craft/blacksmithing
	abstract_type = /datum/anvil_recipe/valuables
	category = "Valuables"

// --------- IRON -----------

/datum/anvil_recipe/valuables/gold_teeth
	name = "Dientes de oro"
	required_material = /obj/item/ingot/gold
	created_item = /obj/item/natural/teeth/gold
	craftdiff = 2
	output_amount = 8

/datum/anvil_recipe/valuables/gold_mask
	name = "Media máscara dorada"
	required_material = /obj/item/ingot/gold
	created_item = /obj/item/clothing/face/lordmask
	craftdiff = 2

/datum/anvil_recipe/valuables/gold_mask_left
	name = "Media máscara dorada (izquierda)"
	required_material = /obj/item/ingot/gold
	created_item = /obj/item/clothing/face/lordmask/l
	craftdiff = 2

/datum/anvil_recipe/valuables/iron
	required_material = /obj/item/ingot/iron
	abstract_type = /datum/anvil_recipe/valuables/iron
	craftdiff = 1
///////////////////////////////////////////////

/datum/anvil_recipe/valuables/iron/statue
	name = "Estatua de hierro"
	created_item = /obj/item/statue/iron

// --------- STEEL -----------


/datum/anvil_recipe/valuables/rontzs
	name = "Silver Face Mask"
	required_material = /obj/item/ingot/silver
	created_item = /obj/item/clothing/face/facemask/silver
	craftdiff = 2

/datum/anvil_recipe/valuables/steel
	abstract_type = /datum/anvil_recipe/valuables/steel
	required_material = /obj/item/ingot/steel
	craftdiff = 2
///////////////////////////////////////////////

/datum/anvil_recipe/valuables/steel/statue
	name = "Estatua de acero"
	created_item = /obj/item/statue/steel

// --------- SILVER -----------

/datum/anvil_recipe/valuables/silver
	abstract_type = /datum/anvil_recipe/valuables/silver
	required_material = /obj/item/ingot/silver
	craftdiff = 3
///////////////////////////////////////////////

/datum/anvil_recipe/valuables/silver/statue
	name = "Estatua de plata"
	created_item = /obj/item/statue/silver

/datum/anvil_recipe/valuables/silver/volf
	name = "Silver Volf Bust (+Silver Bar)"
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/statue/silver/volf

/datum/anvil_recipe/valuables/silver/urn
	name = "Urna de Plata (+Barra de Plata)"
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/statue/silver/urn

/datum/anvil_recipe/valuables/silver/vasefancy
	name = "Fancy Silver Vase (+Silver Bar)"
	additional_items = list(/obj/item/ingot/silver)
	created_item = /obj/item/statue/silver/vasefancy

/datum/anvil_recipe/valuables/silver/finger
	name = "Silver Middle Finger (+2 Silver Bar)"
	additional_items = list(/obj/item/ingot/silver/, /obj/item/ingot/silver)
	created_item = /obj/item/statue/silver/finger

/datum/anvil_recipe/valuables/silver/bust
	name = "Busto de Plata"
	created_item = /obj/item/statue/silver/bust

/datum/anvil_recipe/valuables/silver/vase
	name = "Silver Vase"
	created_item = /obj/item/statue/silver/vase

/datum/anvil_recipe/valuables/silver/totem
	name = "Silver Totem"
	created_item = /obj/item/statue/silver/totem

/datum/anvil_recipe/valuables/silver/teapot
	name = "Tetera de plata"
	created_item = /obj/item/reagent_containers/glass/carafe/teapot/silver

/datum/anvil_recipe/valuables/silver/obelisk
	name = "Obelisco de Plata"
	created_item = /obj/item/statue/silver/obelisk

/datum/anvil_recipe/valuables/silver/tablet
	name = "Tableta de plata"
	created_item = /obj/item/statue/silver/tablet

/datum/anvil_recipe/valuables/silver/comb
	name = "Peines de plata"
	created_item = /obj/item/statue/silver/comb
	output_amount = 2

/datum/anvil_recipe/valuables/silver/figurine
	name = "Figuras de plata"
	created_item = /obj/item/statue/silver/figurine
	output_amount = 2

/datum/anvil_recipe/valuables/silver/cameo
	name = "Silver Cameo's"
	created_item = /obj/item/statue/silver/cameo
	output_amount = 2

/datum/anvil_recipe/valuables/silver/fish
	name = "Silver Fish"
	created_item = /obj/item/statue/silver/fish
	output_amount = 2

/datum/anvil_recipe/valuables/silver/rings
	name = "Anillos de plata"
	created_item = /obj/item/clothing/ring/silver
	output_amount = 3

/datum/anvil_recipe/valuables/silver/diadem
	name = "Diadema de Plata"
	created_item = /obj/item/clothing/head/crown/circlet/silverdiadem

/datum/anvil_recipe/valuables/silver/nosechain
	name = "Silver Nosechain's"
	created_item = /obj/item/clothing/face/facemask/silvernosechain
	output_amount = 2
/datum/anvil_recipe/valuables/silver/faceveil
	name = "Silver Face Veil"
	created_item = /obj/item/clothing/face/facemask/silverveil

/datum/anvil_recipe/valuables/silver/headdress
	name = "Ziliquae Headdress"
	created_item = /obj/item/clothing/head/crown/circlet/silverheaddress

/datum/anvil_recipe/valuables/silver/sbracelet
	name = "Silver Bracelets"
	created_item = /obj/item/clothing/wrists/silverbracelet
	output_amount = 2

/datum/anvil_recipe/valuables/silver/amulet
	name = "Amuletos de Plata"
	created_item = /obj/item/clothing/neck/silveramulet
	output_amount = 2

/datum/anvil_recipe/valuables/silver/dorpels
	name = "Anillo Dorpel de Plata"
	additional_items = list(/obj/item/gem/diamond)
	created_item = /obj/item/clothing/ring/silver/dorpel
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/blortzs
	name = "Silver Blortz Ring"
	additional_items = list(/obj/item/gem/blue)
	created_item = /obj/item/clothing/ring/silver/blortz
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/saffiras
	name = "Silver Saffira Ring"
	additional_items = list(/obj/item/gem/violet)
	created_item = /obj/item/clothing/ring/silver/saffira
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/gemeralds
	name = "Silver Gemerald Ring"
	additional_items = list(/obj/item/gem/green)
	created_item = /obj/item/clothing/ring/silver/gemerald
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/topers
	name = "Anillo Toper de Plata"
	additional_items = list(/obj/item/gem/yellow)
	created_item = /obj/item/clothing/ring/silver/toper
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/rontzs
	name = "Silver Rontz Ring"
	additional_items = list(/obj/item/gem/red)
	created_item = /obj/item/clothing/ring/silver/rontz
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/maker_ring
	name = "Maker's guild ring"
	created_item = /obj/item/clothing/ring/silver/makers_guild
	craftdiff = 6

// --------- BS ------------
/datum/anvil_recipe/valuables/blacksteel
	required_material = /obj/item/ingot/blacksteel
	abstract_type = /datum/anvil_recipe/valuables/blacksteel
	craftdiff = 4

/datum/anvil_recipe/valuables/blacksteel/ring
	name = "Blacksteel Ring"
	created_item = /obj/item/clothing/ring/blacksteel

/datum/anvil_recipe/valuables/blacksteel/dorpels
	name = "Blacksteel Dorpel Ring"
	additional_items = list(/obj/item/gem/diamond)
	created_item = /obj/item/clothing/ring/diamondbs
	craftdiff = 4

/datum/anvil_recipe/valuables/blacksteel/blortzs
	name = "Blacksteel Blortz Ring"
	additional_items = list(/obj/item/gem/blue)
	created_item = /obj/item/clothing/ring/quartzbs
	craftdiff = 4

/datum/anvil_recipe/valuables/blacksteel/saffiras
	name = "Blacksteel Saffira Ring"
	additional_items = list(/obj/item/gem/violet)
	created_item = /obj/item/clothing/ring/sapphirebs
	craftdiff = 4

/datum/anvil_recipe/valuables/blacksteel/gemeralds
	name = "Blacksteel Gemerald Ring"
	additional_items = list(/obj/item/gem/green)
	created_item = /obj/item/clothing/ring/emeraldbs
	craftdiff = 4

/datum/anvil_recipe/valuables/blacksteel/topers
	name = "Blacksteel Toper Ring"
	additional_items = list(/obj/item/gem/yellow)
	created_item = /obj/item/clothing/ring/topazbs
	craftdiff = 4

/datum/anvil_recipe/valuables/blacksteel/rontzs
	name = "Blacksteel Rontz Ring"
	additional_items = list(/obj/item/gem/red)
	created_item = /obj/item/clothing/ring/rubybs
	craftdiff = 4

// --------- GOLD -----------

/datum/anvil_recipe/valuables/gold
	required_material = /obj/item/ingot/gold
	abstract_type = /datum/anvil_recipe/valuables/gold
	craftdiff = 4
//////////////////////////////////////////////

/datum/anvil_recipe/valuables/gold/statue
	name = "Golden Statue"
	created_item = /obj/item/statue/gold

/datum/anvil_recipe/valuables/gold/bust
	name = "Golden Bust"
	created_item = /obj/item/statue/gold/bust

/datum/anvil_recipe/valuables/gold/finger
	name = "Golden Middle Finger (2+ Gold Bars)"
	additional_items = list(/obj/item/ingot/gold/, /obj/item/ingot/gold)
	created_item = /obj/item/statue/gold/finger

/datum/anvil_recipe/valuables/gold/volf
	name = "Golden Volf Bust (+ Gold Bar)"
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/statue/gold/volf

/datum/anvil_recipe/valuables/gold/urn
	name = "Urna de Oro (+ Barra de Oro)"
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/statue/gold/urn

/datum/anvil_recipe/valuables/gold/vasefancy
	name = "Fancy Gold Vase (+ Gold Bar)"
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/statue/gold/vasefancy

/datum/anvil_recipe/valuables/gold/vase
	name = "Gold Vase"
	created_item = /obj/item/statue/gold/vase

/datum/anvil_recipe/valuables/gold/obelisk
	name = "Obelisco de oro"
	created_item = /obj/item/statue/gold/obelisk

/datum/anvil_recipe/valuables/gold/totem
	name = "Gold Totem"
	created_item = /obj/item/statue/gold/totem

/datum/anvil_recipe/valuables/gold/teapot
	name = "Golden Teapot"
	created_item = /obj/item/reagent_containers/glass/carafe/teapot/gold

/datum/anvil_recipe/valuables/gold/tablet
	name = "Golden Tablet"
	created_item = /obj/item/statue/gold/tablet

/datum/anvil_recipe/valuables/gold/cameo
	name = "Golden Cameos"
	created_item = /obj/item/statue/gold/cameo
	output_amount = 2

/datum/anvil_recipe/valuables/gold/comb
	name = "Peines de oro"
	created_item = /obj/item/statue/gold/comb
	output_amount = 2

/datum/anvil_recipe/valuables/gold/figurine
	name = "Figuras de oro"
	created_item = /obj/item/statue/gold/figurine
	output_amount = 2

/datum/anvil_recipe/valuables/gold/bracelet
	name = "Gold Bracelets"
	created_item = /obj/item/clothing/wrists/goldbracelet
	output_amount = 2

/datum/anvil_recipe/valuables/gold/amulet
	name = "Amuletos de oro"
	created_item = /obj/item/clothing/neck/goldamulet
	output_amount = 2

/datum/anvil_recipe/valuables/gold/fish
	name = "Golden Fish Figurines"
	created_item = /obj/item/statue/gold/fish
	output_amount = 2

/datum/anvil_recipe/valuables/gold/circulet
	name = "Golden Circlet"
	created_item = /obj/item/clothing/head/crown/circlet

/datum/anvil_recipe/valuables/gold/rings
	name = "Anillos de oro"
	created_item = /obj/item/clothing/ring/gold
	output_amount = 3

/datum/anvil_recipe/valuables/gold/diadem
	name = "Diadema de oro"
	created_item = /obj/item/clothing/head/crown/circlet/golddiadem

/datum/anvil_recipe/valuables/gold/nosechain
	name = "Gold Nosechain's"
	created_item = /obj/item/clothing/face/facemask/goldnosechain
	output_amount = 2

/datum/anvil_recipe/valuables/gold/faceveil
	name = "Golden Face Veil"
	created_item = /obj/item/clothing/face/facemask/goldveil

/datum/anvil_recipe/valuables/gold/headdress
	name = "Zenarii Headdress"
	created_item = /obj/item/clothing/head/crown/circlet/goldheaddress

/datum/anvil_recipe/valuables/gold/dorpel
	name = "Golden Dorpel Ring"
	additional_items = list(/obj/item/gem/diamond)
	created_item = /obj/item/clothing/ring/gold/dorpel
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/blortz
	name = "Golden Blortz Ring"
	additional_items = list(/obj/item/gem/blue)
	created_item = /obj/item/clothing/ring/gold/blortz
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/saffira
	name = "Golden Saffira Ring"
	additional_items = list(/obj/item/gem/violet)
	created_item = /obj/item/clothing/ring/gold/saffira
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/gemerald
	name = "Golden Gemerald Ring"
	additional_items = list(/obj/item/gem/green)
	created_item = /obj/item/clothing/ring/gold/gemerald
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/toper
	name = "Golden Toper Ring"
	additional_items = list(/obj/item/gem/yellow)
	created_item = /obj/item/clothing/ring/gold/toper
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/rontz
	name = "Golden Rontz Ring"
	additional_items = list(/obj/item/gem/red)
	created_item = /obj/item/clothing/ring/gold/rontz
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/mercator_ring
	name = "Golden Mercator Ring"
	created_item = /obj/item/clothing/ring/gold/guild_mercator
	craftdiff = 6

/datum/anvil_recipe/valuables/gold/sparrow_crown
	name = "Champion's circlet"
	created_item = /obj/item/clothing/head/crown/sparrowcrown
	craftdiff = 6

/datum/anvil_recipe/valuables/signet/silver
	name = "Anillo de sello de plata"
	required_material = /obj/item/ingot/silver
	craftdiff = 4
	created_item = /obj/item/clothing/ring/signet/silver

/datum/anvil_recipe/valuables/signet
	name = "Signet Ring"
	required_material = /obj/item/ingot/gold
	craftdiff = 4
	created_item = /obj/item/clothing/ring/signet

/datum/anvil_recipe/valuables/signet/psy/gold
	name = "Anillo de sello de oro"
	craftdiff = 4
	required_material = /obj/item/ingot/gold
	created_item = /obj/item/clothing/ring/signet/psy/g

/datum/anvil_recipe/valuables/signet/psy
	name = "Blessed Silver Signet Ring"
	craftdiff = 5
	required_material = /obj/item/ingot/silverblessed
	created_item = /obj/item/clothing/ring/signet/psy

// --------- BRONZE -----------

/datum/anvil_recipe/valuables/bronze
	required_material = /obj/item/ingot/bronze
	abstract_type = /datum/anvil_recipe/valuables/bronze
	craftdiff = 1
//////////////////////////////////////////////

/datum/anvil_recipe/valuables/bronze/statue
	name = "Estatua de bronce"
	created_item = /obj/item/statue/bronze

/datum/anvil_recipe/valuables/bronze/bust
	name = "Busto de Bronce"
	created_item = /obj/item/statue/bronze/bust

/datum/anvil_recipe/valuables/bronze/volf
	name = "Bronze Volf Bust (+ Bronze Bar)"
	additional_items = list(/obj/item/ingot/bronze)
	created_item = /obj/item/statue/bronze/volf

/datum/anvil_recipe/valuables/bronze/urn
	name = "Urna de Bronce (+ Barra de Bronce)"
	additional_items = list(/obj/item/ingot/bronze)
	created_item = /obj/item/statue/bronze/urn

/datum/anvil_recipe/valuables/bronze/vasefancy
	name = "Fancy Bronze Vase (+ Bronze Bar)"
	additional_items = list(/obj/item/ingot/bronze)
	created_item = /obj/item/statue/bronze/vasefancy

/datum/anvil_recipe/valuables/bronze/vase
	name = "Bronze Vase"
	created_item = /obj/item/statue/bronze/vase

/datum/anvil_recipe/valuables/bronze/obelisk
	name = "Obelisco de bronce"
	created_item = /obj/item/statue/bronze/obelisk

/datum/anvil_recipe/valuables/bronze/totem
	name = "Bronze Totem"
	created_item = /obj/item/statue/bronze/totem

/datum/anvil_recipe/valuables/bronze/teapot
	name = "Tetera de bronce"
	created_item = /obj/item/reagent_containers/glass/carafe/teapot/bronze

/datum/anvil_recipe/valuables/bronze/tablet
	name = "Tableta de Bronce"
	created_item = /obj/item/statue/bronze/tablet

/datum/anvil_recipe/valuables/bronze/cameo
	name = "Cameos de bronce"
	created_item = /obj/item/statue/bronze/cameo
	output_amount = 2

/datum/anvil_recipe/valuables/bronze/comb
	name = "Peines de bronce"
	created_item = /obj/item/statue/bronze/comb
	output_amount = 2

/datum/anvil_recipe/valuables/bronze/figurine
	name = "Figuras de bronce"
	created_item = /obj/item/statue/bronze/figurine
	output_amount = 2

/datum/anvil_recipe/valuables/bronze/fish
	name = "Bronze Fish Figurines"
	created_item = /obj/item/statue/bronze/fish
	output_amount = 2

/datum/anvil_recipe/valuables/weddingrings
	name = "Weddingbands, Silver (x2)"
	required_material = /obj/item/ingot/silver
	created_item = /obj/item/clothing/ring/band
	output_amount = 2

/datum/anvil_recipe/valuables/weddingringg
	name = "Weddingbands, Gold (x2)"
	required_material = /obj/item/ingot/gold
	created_item = /obj/item/clothing/ring/band/gold
	output_amount = 2

/datum/anvil_recipe/valuables/weddingringb
	name = "Weddingbands, Bronze (x2)"
	required_material = /obj/item/ingot/bronze
	created_item = /obj/item/clothing/ring/band/bronze
	output_amount = 2

/datum/anvil_recipe/valuables/weddingringp
	name = "Weddingbands, Ancient (x2)"
	required_material = /obj/item/ingot/purifiedaalloy
	created_item = /obj/item/clothing/ring/band/paalloy
	output_amount = 2

/datum/anvil_recipe/valuables/bronze_ring
	name = "Anillos de Bronce (x2)"
	required_material = /obj/item/ingot/bronze
	created_item = /obj/item/clothing/ring/bronze
	output_amount = 2

/datum/anvil_recipe/valuables/draconic_ring
	name = "Draconic Ring"
	required_material = /obj/item/ingot/draconic
	created_item = /obj/item/clothing/ring/dragon_ring
	craftdiff = 4
