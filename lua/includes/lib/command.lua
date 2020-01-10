command = command or {}
command.list = command.list or {}

local function any(a)
	return a
end

function command.Add(cmd, tbl)
	if not tbl then
		return
	end

	tbl.name = cmd
	tbl.rights = tbl.rights or 0

	command.list[cmd] = tbl

	if tbl.args then
		local args = {}
		local usage = {}

		for k, v in ipairs(tbl.args) do
			local split = string.split(v, ":")
			local name = split[1]
			local kind = split[2]
			local convert = nil

			if kind == "n" then
				convert = tonumber
			elseif kind == "s" then
				convert = tostring
			elseif kind == "a" then
				convert = any
			else
				error("bad command argument type")
			end

			args[k] = { name = name, convert = convert }

			if #split == 3 then
				local default = convert(split[3])

				if not default then
					error("bad default value")
				end

				args[k].default = default
				table.insert(usage, "[" .. name .. ":" .. kind .. "]")
			else
				table.insert(usage, "(" .. name .. ":" .. kind .. ")")
			end
		end

		tbl.usage = table.concat(usage, " ")
		tbl.args = args
	end
end