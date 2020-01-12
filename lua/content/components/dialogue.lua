---Internal hook
function OnDialogueContinue(user)
	local dialogue = user.dialogue

	if not dialogue then
		user:CloseDialogue()
		return
	end

	local part = dialogue[user.dialoguePart]

	if not part or not part.continue then
		user:CloseDialogue()
		return
	end

	if type(part.continue) == "function" then
		part.continue(user)
		user:CloseDialogue()
	else
		user:OpenDialogue(user.dialogue, user.dialogueOther, part.continue)
	end
end

local function SelectOption(user, option)
	local dialogue = user.dialogue

	if not dialogue then
		user:CloseDialogue()
		return
	end

	local part = dialogue[user.dialoguePart]

	if not part then
		user:CloseDialogue()
		return
	end

	local options = part.options

	if not options then
		user:CloseDialogue()
		return
	end

	option = options[option]

	if not option or not option.continue then
		user:CloseDialogue()
		return
	end

	if type(option.continue) == "function" then
		option.continue(user)
		user:CloseDialogue()
	else
		user:OpenDialogue(user.dialogue, user.dialogueOther, option.continue)
	end
end

button.Set(2461, function(user)
	SelectOption(user, 1)
end)

button.Set(2462, function(user)
	SelectOption(user, 2)
end)

button.Set(2471, function(user)
	SelectOption(user, 1)
end)

button.Set(2472, function(user)
	SelectOption(user, 2)
end)

button.Set(2473, function(user)
	SelectOption(user, 3)
end)

button.Set(2482, function(user)
	SelectOption(user, 1)
end)

button.Set(2483, function(user)
	SelectOption(user, 2)
end)

button.Set(2484, function(user)
	SelectOption(user, 3)
end)

button.Set(2485, function(user)
	SelectOption(user, 4)
end)

button.Set(2494, function(user)
	SelectOption(user, 1)
end)

button.Set(2495, function(user)
	SelectOption(user, 2)
end)

button.Set(2496, function(user)
	SelectOption(user, 3)
end)

button.Set(2497, function(user)
	SelectOption(user, 4)
end)

button.Set(2498, function(user)
	SelectOption(user, 5)
end)