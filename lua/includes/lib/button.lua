button = button or {}
button.defined = button.defined or {}

function button.Set(id, callback)
	button.defined[id] = callback
end