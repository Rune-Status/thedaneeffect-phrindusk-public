local chef = GetActor("master_chef")

if chef then
	chef:Remove()
end

chef = NewActor(942)
chef:SetTag("master_chef")
chef:SetPosition(3075, 3084, 0)
chef:Add()

function chef:OnOption(user)
	self:FaceTile(user.x, user.y)

	local step = user:GetInt(VbTutorialStep)

	if step == 13 then
		user:OpenDialogue(self.Dialogue, self, "intro")
	else
		user:OpenDialogue(self.Dialogue, self, "help")
	end
end

items.OnItem(cooking.pot_of_flour.id, cooking.bucket_of_water.id, function(user, flour, water)
	if user:GetInt(VbTutorialStep) == 14 then
		user:SetInt(VbTutorialStep, 15)
	end

	flour:Remove()
	water:Remove()
	user:GetInventory():Add(cooking.bread_dough)
end)

chef.Dialogue = {
	["intro"] = {
		actor = {
			"Ah... welcome newcomer. I am Lev, the chef. It is here",
			"I will teach you how to cook food truly fit for a king."
		},
		continue = 1
	},

	[1] = {
		player = {
			"I already know how to cook. Brynna taught me just",
			"now."
		},
		continue = 2
	},

	[2] = {
		emotion = "laugh",
		actor = {
			"HA HA HA HA HA HA! You call THAT cooking?",
			"Some shrimp on an open log fire? Oh no no no... I am",
			"going to teach you the fine art of cooking bread."
		},
		continue = 3
	},

	[3] = {
		actor = {
			"And no fine meal is complete without good music so",
			"we'll cover that while you're here too."
		},
		continue = 4
	},

	[4] = {
		message = {
			"The Cooking Guide gives you a @blu@Bucket of Water@bla@ and a",
			"@blu@Pot of Flour@bla@!"
		},
		callback = function(player)
			local inventory = player:GetInventory()
			inventory:Add(pot_of_flour)
			inventory:Add(cooking.bucket_of_water)
			player:SetInt(VbTutorialStep, 14)
		end
	},

	["help"] = {
		options = {
			DialogueOption("I lost some items!", function(user)
				local step = user:GetInt(VbTutorialStep)

				if step == 14 then
					local inventory = user:GetInventory()

					if not inventory:Contains(bucket_of_water) then
						inventory:Add(bucket_of_water)
					end

					if not inventory:Contains(pot_of_flour) then
						inventory:Add(pot_of_flour)
					end
				end
			end),
			DialogueOption("Nevermind."),
		}
	},
}