
include("button.lua")

function OnComponentsClosed(user)
end

function OnFlashingTabSelected(user, tab)
end

function OnButton(user, component)
	local callback = button.defined[component]

	if callback then
		callback(user, component)
		return
	end

	user:Sendf("You pressed %.0f", component)
end

function OnRequestAppearance(user, request)
end