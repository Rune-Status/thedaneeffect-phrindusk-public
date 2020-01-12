Enum("MoveSpeed", "Run", "Walk")
Enum("AutoRetaliate", "Off", "On")

action.Create("emote", {
	priority = Strong, -- I used this priority to avoid animation stalling. Strong actions cancel movement.
	callback = function(player, task)
		player:Animate(task.animation)
	end
})

button.Set(150, function(user)
	user:SetInt(VbAutoRetaliate, AutoRetaliateOff)
end)

button.Set(151, function(user)
	user:SetInt(VbAutoRetaliate, AutoRetaliateOn)
end)

button.Set(152, function(user)
	user:SetInt(VbMoveSpeed, MoveSpeedRun)
end)

button.Set(153, function(user)
	user:SetInt(VbMoveSpeed, MoveSpeedWalk)
end)

local function Emote(button, animation)
	return { button = button, animation = animation }
end

local emotes = {
	["Yes"] = Emote(168, 855),
	["No"] = Emote(169, 856),
	["Think"] = Emote(162, 857),
	["Bow"] = Emote(164, 858),
	["Angry"] = Emote(165, 864),
	["Cry"] = Emote(161, 860),
	["Laugh"] = Emote(170, 861),
	["Cheer"] = Emote(171, 862),
	["Wave"] = Emote(163, 863),
	["Beckon"] = Emote(167, 859),
	["Clap"] = Emote(172, 865),
	["Dance"] = Emote(166, 866),
	["Panic"] = Emote(13362, 2105),
	["Jig"] = Emote(13363, 2106),
	["Spin"] = Emote(13364, 2107),
	["Head Bang"] = Emote(13365, 2108),
	["Joy Jump"] = Emote(13366, 2109),
	["Rasp'berry"] = Emote(13367, 2110),
	["Yawn"] = Emote(13368, 2111),
	["Salute"] = Emote(13369, 2112),
	["Shrug"] = Emote(13370, 2113),
	["Blow Kiss"] = Emote(11100, 1368),
	["Glass Box"] = Emote(667, 1131),
	["Climb Rope"] = Emote(6503, 1130),
	["Lean"] = Emote(6506, 1129),
	["Glass Wall"] = Emote(666, 1128),
	["Goblin Bow"] = Emote(13383, 2127),
	["Goblin Dance"] = Emote(13384, 2128),
}

local animations = {}

local function EmoteButton(user, button)
	local animation = animations[button]

	if animation then
		user:Act("emote", { animation = animation })
	end
end

for _, emote in pairs(emotes) do
	animations[emote.button] = emote.animation
	button.Set(emote.button, EmoteButton)
end