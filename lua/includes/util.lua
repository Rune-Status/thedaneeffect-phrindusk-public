
---Enumerates the provided arguments into global constants.
---For example: Enum("Test", "A", "B", "C") generates the following constants:
---	TestA = 0
---	TestB = 1
---	TestC = 2
---An empty ("") vararg is skipped.
---@param name string
---@vararg
function Enum(name, ...)
	for k, v in ipairs({...}) do
		if v ~= "" then
			_G[name .. v] = k - 1
		end
	end
end

---Overrides the indexing methods of the provided metatable to access
---the table defined in Go. This function should not be used elsewhere
---as its effects may not be apparent.
---@param meta table
local function MakeAccessible(meta)
	if not meta or meta.accessible then
		return
	end

	meta.accessible = true

	local index = meta.__index
	local newindex = meta.__newindex

	function meta.__index(self, k)
		local v = index(self, k)
		if v == nil then
			return index(self, "table")[k]
		end
		return v
	end

	function meta.__newindex(self, k, v)
		index(self, "table")[k] = v
	end
end

MakeAccessible(BaseTask)
MakeAccessible(BasePlayer)
MakeAccessible(BaseObject)
MakeAccessible(BaseActor)