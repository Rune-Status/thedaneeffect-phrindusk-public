function OnObjectOption(user, object, option)
	user:FaceObject(object)

	-- check for a callback to this object in specific first
	if object.OnOption then
		object:OnOption(user, option)
		return
	end

	-- check for object id related callbacks
	local defined = objects.defined[object.id]

	if defined and defined[option] then
		defined[option](user, object)
		return
	end

	-- print if our object has no defined interaction
	user:Sendf("%.0f: %v", option, object)
end