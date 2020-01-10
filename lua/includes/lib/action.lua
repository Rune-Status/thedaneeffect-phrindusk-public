action = action or {}
action.defined = action.defined or {}

function action.Create(name, settings)
	local a = Action()
	for k, v in pairs(settings) do
		a[k] = v
	end
	action.defined[name] = a
end
