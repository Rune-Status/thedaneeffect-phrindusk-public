objects.Set(3033, "Chop down", function(user, tree)
	user:Act("tut_woodcutting", { tree = tree })
end)

hook.Add("OnItemOnObject", "Tutorial", function(user, item, object)
	if item:Equals(fish.raw_shrimps) and object:Equals(generic.fire) then
		user:Act("tut_cooking_shrimp", { shrimp = item, fire = object })
	end
end)

hook.Add("OnItemOnItem", "Tutorial", function(user, a, b)
	if a.id == 1511 and b.id == 590 then
		a, b = b, a
	end

	if a.id == 590 and b.id == 1511 then
		user:Act("tut_firemaking", { logs = b })
	end
end)

hook.Add("OnFlashingTabSelected", "Tutorial", function(player, tab)
	local step = player:GetInt(VbTutorialStep)

	if step == 3 then
		player:SetInt(VbTutorialStep, 4)
	elseif step == 6 then
		player:SetInt(VbTutorialStep, 7)
	end
end)

hook.Add("OnRequestAppearance", "Tutorial", function(player, appearance)
	if player:GetInt(VbTutorialStep) ~= 0 then
		return
	end

	player:SetGender(appearance.gender)
	player:SetDesigns(appearance.designs)
	player:SetColors(appearance.colors)
	player:SetBool(VbDesigned, true)
	player:CloseComponents()
end)