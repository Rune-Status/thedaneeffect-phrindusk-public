function OnActorOption(user, actor, option)
	if actor.OnOption then
		actor:OnOption(user, option)
	end
end