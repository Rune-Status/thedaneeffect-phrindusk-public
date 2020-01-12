function OnItemOption(user, item, option)
	local inventory = item.container

	if inventory.id == Inventory then
		local callback = items.GetOnOption(item.id, option)

		if callback then
			return callback(user, item, option)
		end

		if option == 1 then
			if not item.equipable then
				return
			end

			local worn = user:GetEquipment()
			local dst = item.equipment.slot

			if dst == TwoHanded then
				local weapon = worn:Get(Weapon)
				local shield = worn:Get(Shield)

				if weapon and shield then
					-- find empty slot for shield and swap weapon
					local vacant = inventory:FindEmptySlot()
					if vacant == -1 then
						user:Send("You do not have enough space in your inventory.")
						return
					end
					inventory:Set(vacant, worn:Set(Shield, nil))
					inventory:Set(item.slot, worn:Set(Weapon, item))
				elseif shield then
					inventory:Set(item.slot, shield) -- move shield to inventory
					worn:Set(Shield, nil) -- remove shield from equipment
					worn:Set(Weapon, item) -- add weapon to equipment
				else
					-- swap weapon for weapon
					inventory:Set(item.slot, worn:Set(Weapon, item))
				end
			elseif dst == Shield then
				local weapon = worn:Get(Weapon)

				-- shields unequip 2h weapons into the slot they came from
				if weapon and weapon.equipment.slot == TwoHanded then
					inventory:Set(item.slot, weapon) -- move weapon to inventory
					worn:Set(Weapon, nil) -- remove weapon from equipment
					worn:Set(Shield, item) -- add shield to equipment
				else
					inventory:Set(item.slot, worn:Set(Shield, item))
				end
			else
				-- no special checks for non-(shields/2h) equipables
				inventory:Set(item.slot, worn:Set(dst, item))
			end

			user:UpdateAppearance()
			user:SendSound(GetEquipmentSound(item))
		elseif option == 4 then
			local grounditem = NewGroundItem(item.id, item.amount, user.x, user.y, user.z, user)

			if grounditem:Add() then
				inventory:Set(item.slot, nil)
				user:SendSound(376)
			end
		end
	end
end

function OnItemOnItem(player, a, b)
	local callback, flip = items.GetOnItem(a.id, b.id)

	if flip then
		a, b = b, a
	end

	if callback then
		callback(player, a, b)
	end
end

function OnItemOnPlayer(player, item, other)
	local callback = items.GetOnPlayer(item.id)

	if callback then
		callback(player, item, other)
	else
		player:Send("Nothing interesting happens.")
	end

	player:FaceTile(other.x, other.y)
end

function OnItemOnActor(player, item, actor)
	local callback = items.GetOnActor(item.id, actor.id)

	if callback then
		callback(player, item, actor)
	else
		player:Send("Nothing interesting happens.")
	end

	player:FaceTile(actor.x, actor.y)
end

function OnItemOnObject(player, item, object)
	local callback = items.GetOnObject(item.id, object.id)

	if callback then
		callback(player, item, actor)
	else
		player:Send("Nothing interesting happens.")
	end

	player:FaceObject(object)
end

function OnItemOnGroundItem(player, item, grounditem)
	local callback = items.GetOnGroundItem(item.id, grounditem.id)

	if callback then
		callback(player, item, grounditem)
	else
		player:Send("Nothing interesting happens.")
	end

	player:FaceTile(grounditem.x, grounditem.y)
end
