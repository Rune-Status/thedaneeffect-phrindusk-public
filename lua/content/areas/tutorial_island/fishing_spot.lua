-- 3101 3092

local fish = GetActor("tutorial_shrimp")

if fish then
	return
end

fish = NewActor(952)
fish:SetTag("tutorial_shrimp")
fish:SetPosition(3101, 3092, 0)
fish:Add()

function fish:OnOption(user)
	user:Act("tut_fishing")
end