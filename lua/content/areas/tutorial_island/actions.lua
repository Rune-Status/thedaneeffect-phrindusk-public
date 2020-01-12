local cooking = cooking
local trees = trees
local tools = tools
local fish = fish
local timer = timer

action.Create("tut_woodcutting", {
	repeats = 4,
	priority = Strong,
	callback = function(player, task)
		if task.first then
			local step = player:GetInt(VbTutorialStep)

			if step < 4 then
				player:Send("I am not ready to do that yet.")
				task:Finish()
				return
			end

			player:Animate(tools.bronze_axe.animation)

			if step == 4 then
				player:SendMessage({
					"@blu@Please wait...",
					"",
					"Your character is now attempting to cut down the tree. Sit back",
					"for a moment whilst they do all the hard work."
				})
			end
		end

		if not player:GetInventory():Contains(tools.bronze_axe.item) then
			player:Send("I need an axe to do that!")
			player:Animate(-1)
			task:Finish()
			return
		end

		if task.last then
			local tree = task.tree

			if not tree.stump then
				tree.stump = tree:MakeReplacement(trees.normal.stump)
			end

			tree:Remove()
			tree.stump:Add()

			timer.Create({
				delay = 8 * Second,
				callback = function()
					tree.stump:Remove()
					tree:Add()
				end
			})

			local _, err = player:GetInventory():Add(trees.normal.logs)

			if err then
				print(err)
			end

			EmitSound(trees.cut_sound, tree.x, tree.y, tree.z)

			player:Animate(-1)

			if player:GetInt(VbTutorialStep) == 4 then
				player:SetInt(VbTutorialStep, 5)
			end
		end
	end
})

action.Create("tut_firemaking", {
	repeats = 4,
	priority = Strong,
	callback = function(player, task)
		if task.first then
			local grounditem = NewGroundItem(task.logs.id, 1, player.x, player.y, player.z, player)

			if grounditem:Add() then
				player:SendSound(376)
				task.logs:Remove()
			end

			if player:GetInt(VbTutorialStep) < 6 then
				player:SendMessage({
					"@blu@Please wait...",
					"",
					"Your character is now attempting to light the fire.",
					"This should take only a few seconds."
				})
			end

			player:Animate(tools.tinderbox.animation)
		end

		local inventory = player:GetInventory()

		if not inventory:Contains(tools.tinderbox.item) then
			player:Send("I need a tinderbox to do that!")
			player:Animate(-1)
			task:Finish()
			return
		end

		if task.last then
			local logs = GetGroundItem(task.logs.id, player.x, player.y, player.z, player)

			if logs then
				local fire = NewObject(generic.fire, logs.x, logs.y, logs.z, Standard, 0)

				fire:Add()

				timer.Create({
					delay = 1 * Minute,
					callback = function()
						local ashes = NewGroundItem(592, 1, fire.x, fire.y, fire.z, nil)
						ashes:Add()
						fire:Remove()
					end
				})

				logs:Remove()

				EmitSound(374, logs.x, logs.y, logs.z)

				if player:GetInt(VbTutorialStep) == 5 then
					player:SetInt(VbTutorialStep, 6)
				end

				-- step in the first direction that is unblocked
				player:Step(West, East, South, North)
			end

			player:Animate(-1)
		end
	end
})

action.Create("tut_fishing", {
	repeats = 6,
	priority = Strong,
	callback = function(player, task)
		if task.first then
			local step = player:GetInt(VbTutorialStep)

			if step < 8 then
				player:Send("I don't think I'm ready to do that yet.")
				task:Finish()
				return
			end

			player:Animate(tools.small_net.animation)

			if step == 8 then
				player:SendMessage({
					"@blu@Please wait...",
					"This should only take a few seconds",
					"As you gain fishing experience you'll find that there are many",
					"types of fish and many ways to catch them."
				})
			end
		end

		local inventory = player:GetInventory()

		if not inventory:Contains(tools.small_net.item) then
			player:Send("I need a fishing net to do that!")
			player:Animate(-1)
			task:Finish()
			return
		end

		if task.last then
			inventory:Add(fish.raw_shrimps)
			player:Animate(-1)

			if player:GetInt(VbTutorialStep) == 8 then
				player:SetInt(VbTutorialStep, 9)
			end
		end
	end
})

action.Create("tut_cooking_shrimp", {
	repeats = 2,
	priority = Strong,
	callback = function(player, task)
		if not IsValid(task.shrimp) then
			player:Send("You need raw shrimp to do that.")
			task:Finish()
			return
		end

		if not IsValid(task.fire) then
			task:Finish()
			player:Animate(-1)
			return
		end

		if task.first then
			player:FaceObject(task.fire)
			player:Animate(cooking.on_fire.animation)
		end

		if task.last then
			local step = player:GetInt(VbTutorialStep)

			if step == 9 then
				task.shrimp:Replace(fish.burnt_shrimps)
				player:SetInt(VbTutorialStep, 10)
			elseif step == 10 then
				task.shrimp:Replace(fish.shrimps)
				player:SetInt(VbTutorialStep, 11)
			elseif Roll(2) then
				task.shrimp:Replace(fish.shrimps)
			else
				task.shrimp:Replace(fish.burnt_shrimps)
			end
		end
	end
})