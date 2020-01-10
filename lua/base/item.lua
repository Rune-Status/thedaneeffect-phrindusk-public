function OnItemOption(user, item, option)
	local inventory = item.container

	if inventory.id == Inventory then
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

			user:Invalidate()
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
end

function OnItemOnPlayer(player, item, other)
	player:FaceEntity(other)
end

function OnItemOnActor(player, item, actor)
	player:FaceEntity(actor)
end

function OnItemOnObject(player, item, object)
	player:FaceObject(object)
end

function OnItemOnGroundItem(player, item, grounditem)
end
