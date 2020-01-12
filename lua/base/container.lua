function OnContainerOption(player, container, item, option)
	if container.id == 1688 then
		local slots = player:GetInventory():Add(item)

		if slots and slots[1] ~= -1 then
			player:SendSound(GetEquipmentSound(item))
			item:Remove()
			player:UpdateAppearance()
		end
	end
end

function OnContainerSwap(player, container, src, dst, mode)
	if mode == 1 then
		container:Insert(src, dst.slot)
	else
		container:Swap(src, dst)
	end
end

function OnContainerChanged(player, container)
	if container.id == 1688 then
		player:ClearBonuses()

		for slot = 0, container:Capacity() - 1 do
			local item = container:Get(slot)

			if item and item.equipment then
				player:AddEquipment(item.equipment)
			end
		end

		player:SendComponentTextf(1675, "Stab: %+.0f", player.attackStab)
		player:SendComponentTextf(1676, "Slash: %+.0f", player.attackSlash)
		player:SendComponentTextf(1677, "Crush: %+.0f", player.attackCrush)
		player:SendComponentTextf(1678, "Magic: %+.0f", player.attackMagic)
		player:SendComponentTextf(1679, "Range: %+.0f", player.attackRanged)
		player:SendComponentTextf(1680, "Stab: %+.0f", player.defenceStab)
		player:SendComponentTextf(1681, "Slash: %+.0f", player.defenceSlash)
		player:SendComponentTextf(1682, "Crush: %+.0f", player.defenceCrush)
		player:SendComponentTextf(1683, "Magic: %+.0f", player.defenceMagic)
		player:SendComponentTextf(1684, "Range: %+.0f", player.defenceRanged)
		player:SendComponentTextf(1686, "Strength: %+.0f", player.meleeStrength)
		player:SendComponentTextf(1687, "Prayer: %+.0f", player.prayer)

		-- todo: move me to the item equip and check if it changes our appearance first
		player:UpdateAppearance()
	end
end