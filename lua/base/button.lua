buttons = buttons or {}
buttons.defined = buttons.defined or {}

function buttons.Set(id, callback)
	buttons.defined[id] = callback
end

buttons.Set(2458, function(user)
	user:Logout()
end)