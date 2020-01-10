local guide = GetActor("tutorial_guide")

if guide then
	return
end

guide = NewActor(945)
guide:SetPosition(3094, 3109, 0)
guide:SetTag("tutorial_guide")
guide:Add()

function guide:OnOption(user)
	local step = user:GetInt(VbTutorialStep)

	if step >= 1 then
		user:OpenDialogue(self.Dialogue, self, 3)
	else
		user:OpenDialogue(self.Dialogue, self, "intro")
	end
end

guide.Dialogue = {
	["intro"] = {
		emotion = "happy",
		type = "actor",
		lines = {
			"Greetings! I see you are a new arrival to this land. My",
			"job is to welcome all new visitors. So welcome!",
		},
		continue = 1,
	},
	[1] = {
		emotion = "happy",
		type = "actor",
		lines = {
			"You have already learned the first thing needed to",
			"succeed in this world: talking to other people!",
		},
		continue = 2,
	},
	[2] = {
		emotion = "happy",
		type = "actor",
		lines = {
			"You will find many inhabitants of this world have useful",
			"things to say to you. By clicking on them with your",
			"mouse you can talk to them."
		},
		continue = 3,
	},
	[3] = {
		emotion = "happy",
		type = "actor",
		lines = {
			"To continue the tutorial go through that door over",
			"there and speak to your first instructor!",
		},
		continue = function(player)
			player:SetInt(VbTutorialStep, 1)
		end
	},
}