
include("button.lua")

function OnComponentsClosed(user)
end

function OnFlashingTabSelected(user, tab)
end

function OnButton(user, button)
	local callback = buttons.defined[button]

	if callback then
		callback(user, button)
		return
	end

	user:Sendf("You pressed %.0f", button)
end

function OnRequestAppearance(user, request)
end