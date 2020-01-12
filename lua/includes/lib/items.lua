items = items or {}
items.on_option = items.on_item or {}
items.on_item = items.on_item or {}
items.on_actor = items.on_actor or {}
items.on_player = items.on_player or {}
items.on_object = items.on_object or {}
items.on_grounditem = items.on_grounditem or {}

function items.GetOnOption(item, option)
	item = items.on_option[item]

	if item then
		return item[option]
	end
end

function items.GetOnItem(a, b)
	local c = items.on_item[a]

	if c then
		c = c[b]
		if c then
			return c
		end
	end

	c = items.on_item[b]

	if c then
		c = c[a]
		if c then
			return c, true
		end
	end
end

function items.GetOnActor(item, actor)
	item = items.on_actor[actor]

	if item then
		return item[actor]
	end
end

function items.GetOnPlayer(item)
	return items.on_player[item]
end

function items.GetOnObject(item, object)
	item = items.on_object[item]

	if item then
		return item[object]
	end
end

function items.GetOnGroundItem(item, grounditem)
	item = items.on_grounditem[grounditem]

	if item then
		return item[grounditem]
	end
end

function items.OnOption(item, option, callback)
	items.on_option[item] = items.on_option[item] or {}
	items.on_option[item][option] = callback
end

function items.OnItem(a, b, callback)
	items.on_item[a] = items.on_item[a] or {}
	items.on_item[a][b] = callback
end

function items.OnActor(item, actor, callback)
	items.on_actor[item] = items.on_actor[item] or {}
	items.on_actor[item][actor] = callback
end

function items.OnPlayer(item, callback)
	items.on_player[item] = callback
end

function items.OnObject(item, object, callback)
	items.on_object[item] = items.on_object[item] or {}
	items.on_object[item][object] = callback
end

function items.OnGroundItem(item, grounditem, callback)
	items.on_grounditem[item] = items.on_grounditem[item] or {}
	items.on_grounditem[item][grounditem] = callback
end