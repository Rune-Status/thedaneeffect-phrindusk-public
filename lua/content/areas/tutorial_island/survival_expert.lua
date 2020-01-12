local expert = GetActor("survival_expert")

if expert then
	expert:Remove()
end

expert = NewActor(943)
expert:SetPosition(3104, 3096, 0)
expert:SetTag("survival_expert")
expert:Add()

function expert:OnOption(user)
	local step = user:GetInt(VbTutorialStep)

	if step >= 8 then
		user:OpenDialogue(self.Dialogue, self, "help")
	elseif step == 7 then
		user:OpenDialogue(self.Dialogue, self, "catch_shrimp")
	elseif step >= 3 then
		user:OpenDialogue(self.Dialogue, self, "help")
	elseif step == 2 then
		user:OpenDialogue(self.Dialogue, self, "intro")
	end
end

expert.Dialogue = {
	["intro"] = {
		actor = {
			"Hello there newcomer. My name is Brynna. My job is",
			"to teach you a few survival tips and tricks. First off",
			"we're going to start with the most basic survival skill of",
			"all; making a fire.",
		},
		continue = "intro_player",
	},

	["intro_player"] = {
		emotion = "angry",
		player = {
			"Derp"
		},
		continue = "give_woodcutting_items",
	},

	["give_woodcutting_items"] = {
		message = {
			"The Survival Guide gives you a @blu@Tinderbox@bla@ and a",
			"@blu@Bronze Axe@bla@!",
		},
		continue = function(player)
			local inventory = player:GetInventory()
			inventory:Add(tools.tinderbox.item)
			inventory:Add(tools.bronze_axe.item)
			player:SetInt(VbTutorialStep, 3)
		end
	},

	["catch_shrimp"] = {
		actor = {
			"There's nothing like a good fire to warm the bones.",
			"Next thing is getting food in our bellies. We'll need",
			"something to cook. there are shrimp in the pond there.",
			"So let's catch and cook some."
		},
		continue = function(player)
			local inventory = player:GetInventory()
			inventory:Add(tools.small_net.item)
			player:SetInt(VbTutorialStep, 8)
		end
	},

	["help"] = {
		options = {
			DialogueOption("I lost some items!", function(player)
				local step = player:GetInt(VbTutorialStep)
				local inventory = player:GetInventory()

				if step >= 4 then
					if not inventory:Contains(tools.tinderbox.item) then
						inventory:Add(tools.tinderbox.item)
					end

					if not inventory:Contains(tools.bronze_axe.item) then
						inventory:Add(tools.bronze_axe.item)
					end
				end

				if step >= 8 and not inventory:Contains(tools.small_net.item) then
					inventory:Add(tools.small_net.item)
				end
			end),

			DialogueOption("Nevermind.")
		},
	},
}