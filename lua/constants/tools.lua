local function Tool(id, animation, message)
	return { item = NewItem(id, 1), animation = animation, message = message }
end

tools = {
	tinderbox = Tool(590, 733, "You attempt to catch the logs on fire..."),

	-- woodcutting
	bronze_axe = Tool(1351, 879),
	iron_axe = Tool(1349, 877),
	steel_axe = Tool(1353, 875),
	black_axe = Tool(1361, 873),
	mithril_axe = Tool(1355, 871),
	adamant_axe = Tool(1357, 869),
	rune_axe = Tool(1359, 867),

	bronze_pickaxe = Tool(1265, 479),

	-- fishing
	small_net = Tool(303, 621, "You cast out your net..."),
	big_net = Tool(305, 621, "You cast out your net..."),
	fishing_rod = Tool(307, 622, "You cast out your line..."),
	flyfishing_rod = Tool(309, 622, "You cast out your line..."),
	harpoon = Tool(311, 618, "You start harpooning fish."),
	lobster_pot = Tool(301, 619, "You attempt to catch some lobster.")
}