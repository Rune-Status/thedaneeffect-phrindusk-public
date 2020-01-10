function OnPlayerOption(player, other, option)
	if option == 2 then
		player:Follow(other)
	end
end

function OnNewPlayer(player)
	-- initialize anything here
end

function OnLogin(player)
	if not player:GetBool(VbCreated) then
		hook.Call("OnNewPlayer", player)
		player:SetBool(VbCreated, true)
	end

	player:SendPlayerOption("Follow", 2, false)
	player:SendPlayerOption("Trade with", 3, false)
end

function OnVarbitChanged(player, varbit, value)
	print(player, varbit, value)
end

function OnReconnect(player)
end

function OnLogout(player)
end

function OnMove(player, move)
end

function OnEnterRegion(player, region)
end

function OnSceneComplete(player)
end