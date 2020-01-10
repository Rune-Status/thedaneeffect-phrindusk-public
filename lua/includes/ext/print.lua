function printt(x, depth, maxDepth, seen)
	if x == nil or type(x) ~= "table" then
		return
	end

	depth = depth or 0
	maxDepth = maxDepth or 1000
	seen = seen or {}

	if depth >= maxDepth then
		return
	end

	local indent = string.rep("\t", depth)

	for k, v in pairs(x) do
		if not seen[v] then
			seen[v] = true
			if type(v) == "table" then
				printf("%s%s:", indent, k)
				printt(v, depth + 1, maxDepth, seen)
			else
				printf("%s%s = %s", indent, k, v)
			end
		end
	end
end