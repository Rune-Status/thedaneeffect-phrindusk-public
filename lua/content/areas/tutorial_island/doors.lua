local OpenDuration = 1.5 * Second

objects.SetCallback(3014, 3098, 3107, 0, function(door, user)
	local step = user:GetInt(VbTutorialStep)

	if step < 1 then
		player:Send("I'm not done with this area yet.")
		return
	end

	if step == 1 then
		user:SetInt(VbTutorialProgress, 2)
		user:SetInt(VbTutorialStep, 2)
	end

	if not door.open then
		door.open = NewObject(door.id, door.x - 1, door.y, door.z, door:Kind(), FaceSouth)
	end

	door:Hide(OpenDuration)
	door.open:Show(OpenDuration)

	user:SendSound(2676)
	user:SendSoundEx(2678, OpenDuration)

	if user.x < 3098 then
		user:WalkTo(3098, 3107)
	else
		user:WalkPath(Position2(3098, 3107), Position2(3097, 3107))
	end
end)

objects.SetCallback(3017, 3079, 3084, 0, function(door, user)
	local step = user:GetInt(VbTutorialStep)

	if step < 12 then
		player:Send("I'm not done with this area yet.")
		return
	end

	if step == 12 then
		user:SetInt(VbTutorialProgress, 4)
		user:SetInt(VbTutorialStep, 13)
	end

	if not door.open then
		door.open = NewObject(door.id, door.x - 1, door.y, door.z, door:Kind(), FaceSouth)
	end

	door:Hide(OpenDuration)
	door.open:Show(OpenDuration)
	user:SendSoundEx(2678, OpenDuration)

	user:SendSound(2676)

	if user.x >= 3079 then
		user:WalkPath(Position2(3079, 3084), Position2(3078, 3084))
	else
		user:WalkTo(3079, 3084)
	end
end)

local gate0_0 = GetObject(3016, 3089, 3091, 0)
local gate0_1 = GetObject(3015, 3089, 3092, 0)

gate0_0.open = NewObject(3015, 3090, 3092, 0, StraightWall, FaceSouth)
gate0_1.open = NewObject(3016, 3091, 3092, 0, StraightWall, FaceSouth)

local function OpenGate0(gate, user, option)
	local step = user:GetInt(VbTutorialStep)

	if step < 11 then
		user:Send("I am not finished with this area yet.")
		return
	end

	if step == 11 then
		user:SetInt(VbTutorialStep, 12)
	end

	gate0_0:Hide(OpenDuration)
	gate0_1:Hide(OpenDuration)
	gate0_0.open:Show(OpenDuration)
	gate0_1.open:Show(OpenDuration)

	user:SendSound(891)
	user:SendSoundEx(890, OpenDuration)

	if user.x >= 3090 then
		user:WalkTo(user.x - 1, user.y)
	else
		user:WalkTo(user.x + 1, user.y)
	end
end

gate0_0.OnOption = OpenGate0
gate0_1.OnOption = OpenGate0
