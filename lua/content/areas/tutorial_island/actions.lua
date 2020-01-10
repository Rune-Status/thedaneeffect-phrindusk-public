action.Create("tut_woodcutting", {
	repeats = 4,
	priority = Strong,
	callback = function(player, task)
		if task.first then
			player:Animate(tools.bronze_axe.animation)

			if player:GetInt(VbTutorialStep) == 4 then
				player:SendMessage({
					"@blu@Please wait...",
					"",
					"Your character is now attempting to cut down the tree. Sit back",
					"for a moment whilst they do all the hard work."
				})
			end
		end

		if task.last then
			local tree = task.tree

			if not tree.stump then
				tree.stump = NewObject(trees.normal.stump, tree.x, tree.y, tree.z, Standard, tree.facing)
			end

			tree:Remove()
			tree.stump:Add()

			timer.Create({
				delay = 4 * Second,
				callback = function()
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
		local inventory = player:GetInventory()

		if not inventory:Contains(tools.tinderbox.item) then
			player:Send("You need a tinderbox to do that!")
			player:Animate(-1)
			task:Finish()
			return
		end

		if task.first then
			local grounditem = NewGroundItem(task.logs.id, 1, player.x, player.y, player.z, player)

			if grounditem:Add() then
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

		if task.last then
			local logs = GetGroundItem(task.logs.id, player.x, player.y, player.z, player)

			if logs then
				local fire = NewObject(2732, logs.x, logs.y, logs.z, Standard, 0)

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
			end

			if player:GetInt(VbTutorialStep) == 5 then
				player:SetInt(VbTutorialStep, 6)
			end

			-- Step(direction...) selects the first unblocked direction and steps toward it
			player:Step(West, East, South, North)
			player:Animate(-1)
		end
	end
})

action.Create("tut_fishing", {
	repeats = 6,
	priority = Strong,
	callback = function(player, task)
		local inventory = player:GetInventory()

		if not inventory:Contains(tools.small_net.item) then
			player:Send("You need a fishing net to do that!")
			player:Animate(-1)
			task:Finish()
			return
		end

		if task.first then
			player:Animate(tools.small_net.animation)

			if player:GetInt(VbTutorialStep) == 8 then
				player:SendMessage({
					"@blu@Please wait...",
					"This should only take a few seconds",
					"As you gain fishing experience you'll find that there are many",
					"types of fish and many ways to catch them."
				})
			end
		end

		if task.last then
			inventory:Add(NewItem(317, 1))
			player:Animate(-1)

			if player:GetInt(VbTutorialStep) == 8 then
				player:SetInt(VbTutorialStep, 9)
			end
		end
	end
})

-- animation: 897 sound: 235
action.Create("tut_cooking_shrimp", {
	repeats = 2,
	priority = Strong,
	callback = function(player, task)

	end
})