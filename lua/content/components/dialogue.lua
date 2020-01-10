---Creates a table containing a text and continue option.
---@param text string
---@param continue any
function Option(text, continue)
	return { text = text, continue = continue }
end

---Internal hook
function OnDialogueContinue(user)
	local part = user:GetCurrentDialogue()

	if not part then
		return
	end

	if not part.continue then
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
	local part = user:GetCurrentDialogue()

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

buttons.Set(2461, function(user)
	SelectOption(user, 1)
end)

buttons.Set(2462, function(user)
	SelectOption(user, 2)
end)

buttons.Set(2471, function(user)
	SelectOption(user, 1)
end)

buttons.Set(2472, function(user)
	SelectOption(user, 2)
end)

buttons.Set(2473, function(user)
	SelectOption(user, 3)
end)

buttons.Set(2482, function(user)
	SelectOption(user, 1)
end)

buttons.Set(2483, function(user)
	SelectOption(user, 2)
end)

buttons.Set(2484, function(user)
	SelectOption(user, 3)
end)

buttons.Set(2485, function(user)
	SelectOption(user, 4)
end)

buttons.Set(2494, function(user)
	SelectOption(user, 1)
end)

buttons.Set(2495, function(user)
	SelectOption(user, 2)
end)

buttons.Set(2496, function(user)
	SelectOption(user, 3)
end)

buttons.Set(2497, function(user)
	SelectOption(user, 4)
end)

buttons.Set(2498, function(user)
	SelectOption(user, 5)
end)