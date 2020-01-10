---@class Player
local Player = Player

---Queues an action with the provided parameters.
---@param name string
---@param params table
function Player:Act(name, params)
	local action = action.defined[name]

	if not action then
		error("action not found: " .. name)
		return
	end

	-- do not allow the same action to be queued more than once
	if self.actions:Contains(action) then
		return
	end

	-- automatically generates a new task based on the action
	local task = self.actions:PushBack(action)

	-- this should not happen
	if not task then
		error("unable to create task for action: " .. name)
		return
	end

	-- copy params to task
	if params then
		for k, v in pairs(params) do
			task[k] = v
		end
	end
end
function Player:SendMessage(lines, continuable)
	local component = dialogue.messages[continuable and "continue" or "no_continue"][#lines]

	if component then
		for k, v in ipairs(lines) do
			self:SendComponentText(component + k, v)
		end

		self:SetComponent(continuable and Chat or ChatUnclosable, component)
	end
end

function Player:OpenDialogue(dialogue, other, part)
	self.dialogue = dialogue
	self.dialogueOther = other
	self.dialoguePart = part

	local part = dialogue[part]

	if part.options then
		self:SendOptions(part.options)
		return
	end

	if part.type == "actor" then
		self:SendActorDialogue(other, part.emotion, part.lines)
	elseif part.type == "player" then
		self:SendPlayerDialogue(part.emotion, part.lines)
	elseif part.type == "message" then
		self:SendMessage(part.lines, true)
	elseif part.type == "model_message1" then

	elseif part.type == "model_message2" then

	else
		self:CloseDialogue()
	end
end

function Player:GetCurrentDialogue()
	return self.dialogue and self.dialogue[self.dialoguePart]
end

function Player:SendActorDialogue(actor, emotion, lines)
	local component = dialogue.conversation.left[#lines]

	if component then
		self:SendComponentModelActor(component + 1, actor)
		self:SendDialogue(component, emotion, actor.name, lines)
	end
end

function Player:SendPlayerDialogue(emotion, lines)
	local component = dialogue.conversation.right[#lines]

	if component then
		self:SendComponentModelPlayer(component + 1)
		self:SendDialogue(component, emotion, self.name, lines)
	end
end

function Player:SendDialogue(component, emotion, name, lines)
	emotion = dialogue.emotions[emotion] or dialogue.emotions["generic"]

	for k, v in ipairs(lines) do
		self:SendComponentText(component + k + 2, v)
	end

	self:SendComponentText(component + 2, name)
	self:SendComponentAnimation(component + 1, emotion)
	self:SetComponent(Chat, component)
end

function Player:SendOptions(options)
	local component = dialogue.options.text[#options - 1]

	if component then
		for k, v in ipairs(options) do
			self:SendComponentText(component + k + 1, v.text)
		end

		self:SetComponent(Chat, component)
	end
end

function Player:CloseDialogue()
	self:CloseComponents()
	self.dialogue = nil
	self.dialogueOther = nil
	self.dialoguePart = nil
end