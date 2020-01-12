include("doors.lua")
include("interactions.lua")
include("actions.lua")
include("runescape_guide.lua")
include("survival_expert.lua")
include("fishing_spot.lua")
include("master_chef.lua")

local ProgressComponent = 8680
local AlertComponent = 12227
local DesignComponent = 3559
local Aboveground = Area2(3055, 3059, 3154, 3134)
local Underground = Area2(3072, 9493, 3117, 9533)

button.Set(3651, function() end)

local StepCallback = {
	[0] = function(player)
		player:SendActorHint(GetActor("tutorial_guide"))

		player:SendMessage({
			"@blu@Getting started",
			"To start the tutorial use your left mouse-button to click on the",
			"'RuneScape Guide' in this room. He is indicated by a flashing",
			"yellow arrow above his head. If you can't see him, use your",
			"keyboard's arrow keys to rotate the view."
		}, false)
	end,
	[1] = function(player)
		player:SendTileHint(HintWest, 3098, 3107, 128)

		player:SendMessage({
			"@blu@Interacting with scenery",
			"You can interact with many items of scenery by simply clicking",
			"on them. Right clicking will also give more options. Feel free to",
			"try it with the things in this room, then click on the door indicated",
			"with the yellow arrow to go through to the next area."
		}, false)
	end,
	[2] = function(player)
		player:SendActorHint(GetActor("survival_expert"))

		player:SendMessage({
			"@blu@Moving around",
			"Follow the path to find the next instructor. Clicking on the",
			"ground will walk you to that point. Talk to the survival expert by",
			"the pond to continue the tutorial. Remember you can rotate",
			"the view by pressing the arrow keys."
		})
	end,
	[3] = function(player)
		player:RemoveHint()
		player:SendTabComponent(TabInventory, 3213)
		player:FlashTab(TabInventory)

		player:SendMessage({
			"@blu@Viewing the items that you were given.",
			"",
			"Click on the flashing backpack icon to the right side of the",
			"main window to view your inventory. Your inventory is a list of",
			"everything you have in your backpack."
		})
	end,
	[4] = function(player)
		player:SendTileHint(HintSouthWest, 3100, 3096, 140)
		player:SendMessage({
			"@blu@Cut down a tree",
			"You can click on the backpack icon at any time to view the",
			"items that you currently have in your inventory. You will see",
			"that you now have an axe in your inventory. Use this to get",
			"some logs by clicking on the indicated tree."
		})
	end,
	[5] = function(player)
		player:RemoveHint()
		player:SendMessage({
			"@blu@Building a fire",
			"Well done - you managed to cut some logs from the tree! Next",
			"use the tinderbox in your inventory to light the logs.",
			"a) First click on the tinderbox to use it.",
			"b) Then click on the logs in your inventory to light them."
		})
	end,
	[6] = function(player)
		player:SendTabComponent(TabSkills, 3917)
		player:FlashTab(TabSkills)
		player:SendMessage({
			"",
			"You gained some experience.",
			"Click on the flashing bar graph icon near the inventory button",
			"to see your skill abilities."
		})
	end,
	[7] = function(player)
		player:SendActorHint(GetActor("survival_expert"))
		player:SendMessage({
			"@blu@These are your stats",
			"Here you will see how good your skills are. As you move your",
			"mouse over any of the icons in this panel, it will show you",
			"the exact amount of experience you have and how much is needed",
			"to get to the next level. Talk to Brynna to continue."
		})
	end,
	[8] = function(player)
		player:SendActorHint(GetActor("tutorial_shrimp"))
		player:SendMessage({
			"@blu@Catch some Shrimp.",
			"",
			"Click on the fishing spot indicated by the flashing arrow.",
			"Remember you can check your inventory by clicking the",
			"backpack icon."
		})
	end,
	[9] = function(player)
		player:RemoveHint()
		player:SendMessage({
			"@blu@Cooking your shrimp.",
			"Now you have caught some shrimp let's cook it. First light a",
			"fire: Chop down a tree and then use the tinderbox on the logs.",
			"Use your shrimp on the fire too cook them. If you've lost your",
			"axe or tinderbox Brynna will give you another.",
		})
	end,
	[10] = function(player)
		player:SendMessage({
			"@blu@Burning your shrimp.",
			"You have just burnt your first shrimp. This is normal. As you",
			"get more experience in cooking you will burn stuff less. Let's",
			"try cooking, without burning it this time. First catch some",
			"shrimp, then use them on a fire."
		})
	end,
	[11] = function(player)
		player:SendTileHint(HintSouthWest, 3090, 3092, 64)
		player:SendMessage({
			"@blu@Well done, you've just cooked your first Phrindusk meal.",
			"If you'd like a recap on anything you've learned so far speak",
			"to Brynna. You can now move on to the next instructor. Click on",
			"the gate shown and follow the path. Remember you can move",
			"the camera with the arrow keys."
		})
	end,
	[12] = function(player)
		player:SendTileHint(HintWest, 3079, 3084, 128)
		player:SendMessage({
			"@blu@Find your next instructor.",
			"Follow the path until you get to the door with the yellow arrow",
			"above it. Click on the door to open it. Notice the mini-map",
			"in the top right, this shows a top down view of the area around",
			"you. This can also be used for navigation."
		})
	end,
	[13] = function(player)
		player:SendActorHint(GetActor("master_chef"))
		player:SendMessage({
			"@blu@Find your next instructor.",
			"",
			"Talk to the chef indicated. He will teach you the more advanced",
			"aspects of cooking such as combining ingredients. He will also",
			"teach you about your music player menu as well.",
		})
	end,
	[14] = function(player)
		player:RemoveHint()
		player:SendMessage({
			"@blu@Making Dough.",
			"",
			"This is the base for many of the meals. To make dough we must",
			"mix flour and water. So first right click the bucket of water and",
			"select use, then left click on the pot of flour."
		})
	end
}

-- player:SendTabComponent(TabCombatStyle, 2423)
-- player:SendTabComponent(TabSkills, 3917)
-- player:SendTabComponent(TabQuestJournal, 638)
-- player:SendTabComponent(TabInventory, 3213)
-- player:SendTabComponent(TabEquipment, 1644)
-- player:SendTabComponent(TabPrayer, 5608)
-- player:SendTabComponent(TabMagic, 1151)
-- player:SendTabComponent(TabFriends, 5065)
-- player:SendTabComponent(TabIgnores, 5715)
-- player:SendTabComponent(TabPlayerControls, 147)
-- player:SendTabComponent(TabMusicPlayer, 962)

hook.Add("OnVarbitChanged", "Tutorial", function(player, varbit, value)
	if varbit == VbTutorialStep then
		local callback = StepCallback[value]

		if callback then
			callback(player)
		end
	end
end)

hook.Add("OnLogin", "Tutorial", function(player)
	if not (player:IsWithin2(Aboveground) or player:IsWithin2(Underground)) then
		return
	end

	local step = player:GetInt(VbTutorialStep)

	player:SendTabComponent(TabCombatStyle, -1)

	if step >= 6 then
		player:SendTabComponent(TabSkills, 3917)
	else
		player:SendTabComponent(TabSkills, -1)
	end

	player:SendTabComponent(TabQuestJournal, -1)

	if step >= 3 then
		player:SendTabComponent(TabInventory, 3213)
	else
		player:SendTabComponent(TabInventory, -1)
	end

	player:SendTabComponent(TabEquipment, -1)
	player:SendTabComponent(TabPrayer, -1)
	player:SendTabComponent(TabMagic, -1)
	player:SendTabComponent(TabFriends, -1)
	player:SendTabComponent(TabIgnores, -1)
	player:SendTabComponent(TabLogout, 2449)
	player:SendTabComponent(TabGameOptions, player:IsHighDetail() and 904 or 4445)
	player:SendTabComponent(TabPlayerControls, -1)
	player:SendTabComponent(TabMusicPlayer, -1)

	StepCallback[step](player)

	player:HideComponent(AlertComponent, true)
	player:SetComponent(Overlay, ProgressComponent)

	if not player:GetBool(VbDesigned) then
		player:SetComponent(Viewport, DesignComponent)
	end
end)