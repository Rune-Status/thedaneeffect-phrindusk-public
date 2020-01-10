objects = objects or {}
objects.defined = objects.defined or {}

function objects.SetCallback(id, x, y, z, callback)
	local object = GetObject(id, x, y, z)

	if not object then
		error("non-existant object")
	end

	-- by default objects are accessible, however their
	-- tables do not exist. This is to save memory.
	object:CreateTable()

	-- set the callback
	object.OnOption = callback
end

function objects.Set(id, option, callback)
	if type(id) == "table" then
		for _, v in pairs(id) do
			objects.Set(v, option, callback)
		end
		return
	end

	local info = Object(id)
	local index = -1

	if type(option) == "string" then
		for i = 0, #info.options do
			if info.options[i] == option then
				index = i
				break
			end
		end
	else
		index = option
	end

	if index == -1 then
		error("invalid object option: " .. option)
	end

	objects.defined[id] = objects.defined[id] or {}
	objects.defined[id][index] = callback
end