/datum/patron/godless
	abstract_type = /datum/patron/godless
	associated_faith = /datum/faith/godless

/datum/patron/godless/can_pray(mob/living/follower)
	// Redefined this entire proc just to tell you:
	// Yes, the godless can pray. This is intentional.
	// Maybe they pray to themselves?
	return TRUE

/datum/patron/godless/hear_prayer(mob/living/follower, message)
	return FALSE

/datum/patron/godless/godless //lol lmao
	name = "Godless"
	domain = "Abandono de los dioses"
	desc = "Worship of the gods is foolish! Gods exist, but you refuse to worship them due to your own hubris."
	flaws = "Stubborn, Unrelenting, Misguided"
	worshippers = "Egomaniacs, Heretics, the Ignorant"
	sins = "Idolatria, adoracion, fe ciega"
	boons = "None, you godless heathen."

	confess_lines = list(
		"NO GODS, NO MASTERS! THERE IS ONLY ME!",
		"UN HOMBRE ELIGE, UN ESCLAVO OBEDECE - ¡SERE LIBRE DE LOS DIOSES!",
		"THE OLD WAYS WILL CRUMBLE, THE GODS ARE UNJUST!"
	)

/datum/patron/godless/autotheist
	name = "autoteista"
	domain = "Self-Deification"
	desc = "Forget the Divine Pantheon, YOU are a god! The mortals don't know it, but you walk alongside them in your shell. You are the true ruler of this world!"
	flaws = "Stubborn, Pride, Superiority"
	worshippers = "Egomaniacs, The Self-Obsessed, Megalomaniacs"
	sins = "Humility, Self-Doubt"
	boons = "None."

	confess_lines = list(
		"¡YO SOY EL UNICO DIOS VERDADERO!",
		"¡MI VOLUNTAD ES LA UNICA LEY!",
		"WHAT IS A GOD BUT MYSELF!"
	)

/datum/patron/godless/defiant
	name = "Desafiante"
	domain = "Rechazo de los dioses"
	desc = "You have a grave distaste for authority, so much so to the point where you decided that you refuse to worship the gods! They are merely another form of authority, and you will never bow down to them."
	flaws = "Defiant, Rebellious, Unrelenting"
	worshippers = "Anarquistas, Rebeldes" //fuck the system, og
	sins = "Obediencia, Sumision"
	boons = "None."

	confess_lines = list(
		"I WILL NEVER BOW TO ANYONE- NOT EVEN THE DIVINE!",
		"¡UN HOMBRE ELIGE, UN ESCLAVO OBEDECE! ¡SERE LIBRE DE LOS DIOSES!",
		"¡NADIE TIENE AUTORIDAD SOBRE MI, NI SIQUIERA LOS DIOSES!"
	)

/datum/patron/godless/dystheist
	name = "Dystheist"
	domain = "Rechazo de los dioses"
	desc = "You see the gods for what they truly are: powerful, yet flawed and unworthy of worship."
	flaws = "Cynical, Judgmental"
	worshippers = "Escepticos, los desilusionados"
	sins = "Fe ciega"
	boons = "None."

	confess_lines = list(
		"¡LOS DIOSES NO SIGNIFICAN NADA PARA MI!",
		"¡LOS DIEZ TIENEN DEFECTOS!",
		"I WILL NEVER BOW DOWN TO ANY OF THOSE TYRANTS, DIVINE NOR INHUMEN!"
	)

/datum/patron/godless/naivety
	name = "Ingenuidad"
	domain = "Indiferencia"
	desc = "Either due to never being informed, a memory issue, or perhaps a brain injury, you have no clue what gods are!"
	flaws = "Ignorant, Naive, Stupid"
	worshippers = "Younglings, Ignorant, Fools"
	sins = "..¿Que es eso?"
	boons = "..¿Que es eso?"
	confess_lines = list(
		"I DON'T KNOW WHAT YOU'RE TALKING ABOUT!",
		"¡¿QUE ES UN DIOS?!",
		"NOBODY EVER TOLD ME ABOUT THE DIVINE!"
	)

/datum/patron/godless/rashan
	name = "Rashan-Kahl"
	domain = "Twin-faced god of ambition and chains"
	desc = "Rashan represents both creation and destruction, freedom and bondage: a duality that mirrors the rakshari's complex relationship with power. Temples to Rashan-Kahl often double as marketplaces, symbolizing the transactional nature of life."
	flaws = "Defectos de sus seguidores"
	worshippers = "Rakshari, esclavistas, Su Majestad"
	sins = "Pecados de sus seguidores"
	boons = "The will to meow"
	confess_lines = list(
		"WHAT MUST I PAY FOR THE PAIN TO STOP!",
		"I AM UNCHAINED!!",
		"I AM PROMISED FREEDOM",
		"MY GOD IS FREEDOM WHILE YOURS ARE SHACKLES!",
		"RASHAN-KAHL WILL ENSLAVE YOU!"
	)
	allowed_races = list(SPEC_ID_RAKSHARI)

/datum/patron/godless/galadros
	name = "Galadros"
	domain = "El Gran Wyrm en el corazon de Kruskros, Krusnakell"
	desc = "Galadros has brought himself to reverential status among Kobolds through generational servitude. They feed him the lux of the mountain. He gives their short lives purpose. For them, this is everything."
	flaws = "Ignorancia, codependencia, terquedad"
	worshippers = "Kobolds, su descendencia"
	sins = "Self-dependency, Failing your sire, Discouraging servantry"
	boons = "¡Un sentido de proposito y logro!"
	confess_lines = list(
		"I'LL NEVER LET YOU DOWN AGAIN!!",
		"¡TE HE FRACASADO, MAESTRO!",
		"¡TIENE HAMBRE! ¡¡TENGO QUE ALIMENTARLO!!",
		"I FIND PURPOSE THROUGH SERVITUDE!",
		"¡¡EL GRAN WYRM TE DEVORARA!!",
	)
	allowed_races = list(SPEC_ID_KOBOLD)
