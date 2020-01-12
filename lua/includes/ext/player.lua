include("player_dialogue.lua")

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