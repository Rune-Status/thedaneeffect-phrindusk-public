include("doors.lua")
include("objects.lua")
include("actions.lua")
include("runescape_guide.lua")
include("survival_expert.lua")
include("fishing_spot.lua")

local ProgressComponent = 8680
local AlertComponent = 12227
local DesignComponent = 3559
local Aboveground = Area2(3055, 3059, 3154, 3134)
local Underground = Area2(3072, 9493, 3117, 9533)

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

hook.Add("OnItemOnItem", "TutorialItemOnItem", function(user, a, b)
	if a.id == 1511 and b.id == 590 then
		a, b = b, a
	end

	if a.id == 590 and b.id == 1511 then
		user:Act("tut_firemaking", { logs = b })
	end
end)

hook.Add("OnVarbitChanged", "Tutorial", function(player, varbit, value)
	if varbit == VbTutorialStep then
		local callback = StepCallback[value]

		if callback then
			callback(player)
		end
	end
end)

hook.Add("OnFlashingTabSelected", "Tutorial", function(player, tab)
	local step = player:GetInt(VbTutorialStep)

	if step == 3 then
		player:SetInt(VbTutorialStep, 4)
	elseif step == 6 then
		player:SetInt(VbTutorialStep, 7)
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
	player:SendTabComponent(TabGameOptions, 904)
	player:SendTabComponent(TabPlayerControls, -1)
	player:SendTabComponent(TabMusicPlayer, -1)

	StepCallback[step](player)

	player:HideComponent(AlertComponent, true)
	player:SetComponent(Overlay, ProgressComponent)

	if not player:GetBool(VbDesigned) then
		player:SetComponent(Viewport, DesignComponent)
	end
end)

hook.Add("OnRequestAppearance", "Tutorial", function(player, appearance)
	if player:GetInt(VbTutorialStep) ~= 0 then
		return
	end

	player:SetGender(appearance.gender)
	player:SetDesigns(appearance.designs)
	player:SetColors(appearance.colors)
	player:SetBool(VbDesigned, true)
	player:CloseComponents()
end)