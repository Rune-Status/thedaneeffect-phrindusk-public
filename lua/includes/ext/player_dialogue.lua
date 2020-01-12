---Creates a table containing a text and continue option.
---@param text string
---@param continue any
function DialogueOption(text, continue)
	return { text = text, continue = continue }
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

	if not dialogue then
		self:CloseDialogue()
		printf("warning: (bad_dialogue) %s->%s", self, other:GetTag())
		return
	end

	local next = dialogue[part]

	if not next then
		self:CloseDialogue()
		printf("warning: (bad_dialogue_part) %s->%s:%+v", self, other:GetTag(), part)
		return
	end

	if next.callback then
		next.callback(self, other)
	end

	if next.options then
		self:SendOptions(next.options)
	elseif next.actor then
		self:SendActorDialogue(other, next.emotion, next.actor)
	elseif next.player then
		self:SendPlayerDialogue(next.emotion, next.player)
	elseif next.message then
		self:SendMessage(next.message, true)
	elseif next.type == "model_message1" then
	elseif next.type == "model_message2" then
	else
		self:CloseDialogue()
	end
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
		self:SendDialogue(component, emotion, self:GetName(), lines)
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