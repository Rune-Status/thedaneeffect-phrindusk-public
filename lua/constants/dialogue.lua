
dialogue = {}

-- 306	Model + 1 Line + Continue
-- 310	Model + 2 Lines + Continue
-- 315	Model + 3 Lines + Continue
-- 321	Model + 4 Lines + Continue

-- 11859 2 Left Models + 1 Line + Continue
-- 11864 2 Left Models + 2 Lines + Continue
-- 11870 2 Left Models + 3 Lines + Continue

-- dialogue messages do not have a click here to continue
dialogue.messages = {
	model1 = {
		306, -- 1 model 1 line
		310, -- 1 model 2 lines
		315, -- 1 model 3 lines
		321, -- 1 model 4 lines
	},

	model2 = {
		11859, -- 2 models 1 line
		11864, -- 2 models 2 lines
		11870, -- 2 models 3 lines
	},

	continue = {
		356, -- 1 line
		359, -- 2 lines
		363, -- 3 lines
		368, -- 4 lines
		374, -- 5 lines
	},
	
	no_continue = {
		12788, -- 1 line
		12790, -- 2 lines
		12793, -- 3 lines
		12797, -- 4 lines
		12802, -- 5 lines
	},
}

-- conversation components follow this format:
-- model = component + 1
-- name = component + 2
-- line = component + 3 + n

dialogue.conversation = {
	left = {
		4882, -- 1 line
		4887, -- 2 lines
		4893, -- 3 lines
		4900, -- 4 lines
	},

	right = {
		968, -- 1 line
		973, -- 2 lines
		979, -- 3 lines
		986, -- 4 lines
	},
}

dialogue.options = {
	crafting = {
		8866, -- 2 options
		8880, -- 3 options
		8899, -- 4 options
		8938, -- 5 options
		11462, -- glassmaking options
	},

	model = {
		139, -- 2 options
		1741, -- 3 options
		3211, -- 4 options
	},

	-- lines start at n + 2
	text = {
		2459, -- 2 options
		2469, -- 3 options
		2480, -- 4 options
		2492 -- 5 options
	},

	-- these appear to be duplicates of the above options
	text2 = {
		13758, -- 2 options
		13768, -- 3 options
		8207, -- 4 options
		8219, -- 5 options
	},
}

dialogue.emotions = {
	["pompus"] = 554,
	["unknown_creature"] = 558,
	["very_sad"] = 562,
	["single_word"] = 566,
	["happy"] = 567,
	["shocked"] = 571,
	["wondering"] = 575,
	["blank"] = 579,
	["goblin"] = 580,
	["tree"] = 584,
	["generic"] = 588,
	["skeptical"] = 592,
	["worried"] = 596,
	["drowzy"] = 600,
	["blank_evil"] = 604,
	["laugh"] = 605,
	["sad"] = 610,
	["angry"] = 614,
	["easter_bunny"] = 1824,
}