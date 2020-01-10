
function OnGroundItemOption(user, item, option)
	local _, err = user:GetInventory():Add(item:Item())

	if err then
		if err == ErrNoSpace then
			user:Send("You do not have enough inventory space.")
		end
		return
	end

	item:Remove()
	user:SendSound(356)
end