hook = hook or {}
hook.defined = hook.defined or {}

local defined = hook.defined

function hook.Add(event, name, callback)
	if defined[event] == nil then
		defined[event] = {}
	end
	defined[event][name] = callback
end

function hook.Remove(event, name)
	defined[event][name] = nil
end

function hook.Call(event, ...)
	if defined[event] then
		for _, v in pairs(defined[event]) do
			local ret = v(...)

			if ret ~= nil then
				return ret
			end
		end
	end

	local fn = _G[event]

	if not fn then
		error("hook '" .. event .. "' does not exist")
	else
		return fn(...)
	end
end