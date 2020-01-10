function OnCommand(caller, cmd, args)
	cmd = command.list[cmd]

	if not cmd then
		return
	end

	if not caller:HasRights(cmd.rights) then
		caller:Send("You cannot use that command.")
		return
	end

	local parsed

	if cmd.args then
		for k, v in ipairs(cmd.args) do
			local arg

			if k > #args or not args[k] then
				if v.default then
					arg = v.default
				else
					caller:Send("(required) [optional] :n = number, :s = string")
					caller:Sendf("::%s %s", cmd.name, cmd.usage)
					return
				end
			else
				arg = v.convert(args[k])
			end

			if not parsed then
				parsed = {}
			end

			parsed[v.name] = arg
		end
	else
		parsed = args
	end

	cmd.callback(caller, parsed)
end