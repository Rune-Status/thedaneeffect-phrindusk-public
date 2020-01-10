include("includes/init.lua")

include("constants/init.lua")

include("base/actor.lua")
include("base/anticheat.lua")
include("base/command.lua")
include("base/component.lua")
include("base/container.lua")
include("base/grounditem.lua")
include("base/input.lua")
include("base/item.lua")
include("base/magic.lua")
include("base/object.lua")
include("base/player.lua")
include("base/social.lua")

include("content/init.lua")

function OnGameUpdate()
	local timers = timer.GetActive()

	for k, v in pairs(timers) do
		if v.delay == 0 then
			v.callback(v.data)

			if v.repeats == 0 then
				timer.Remove(k)
			else
				v.repeats = v.repeats - 1
				v.delay = v.interval
			end
		else
			v.delay = v.delay - 1
		end
	end
end