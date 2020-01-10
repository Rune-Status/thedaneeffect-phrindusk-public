function string.split(x, sep)
	local t = {}
	for s in string.gmatch(x, "([^" .. sep .. "]+)") do
		table.insert(t, s)
	end
	return t
end