action.Create("climb", {
	priority = Strong,
	repeats = 1,
	callback = function(player, task)
		print(task.cycle, task)

		if task.first then
			player:Animate(task.animation)
		end

		if task.last then
			player:SetZ(player.z + task.direction)
		end
	end
})

local function OnClimbUp(player, object)
	player:Act("climb", { animation = 828, direction = 1 })
end

local function OnClimbDown(player, object)
	player:Act("climb", { animation = 827, direction = -1 })
end

local function OnClimb(player, object)
	player:Send("climb")
end

for i = 0, #Objects - 1 do
	local object = Object(i)

	if object.name == "Ladder" then
		if object.options then
			for j = 0, #object.options do
				local option = object.options[j]

				if option == "Climb-up" then
					objects.Set(i, j, OnClimbUp)
				elseif option == "Climb-down" then
					objects.Set(i, j, OnClimbDown)
				elseif option == "Climb" then
					objects.Set(i, j, OnClimb)
				end
			end
		end
	end
end