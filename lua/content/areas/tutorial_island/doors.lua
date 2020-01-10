local OpenDuration = 1.5 * Second
local DoorSound = 328
local GateSound = 328

GetObject(3014, 3098, 3107, 0).OnOption = function(door, user)
	if user.x > 3097 then
		user:Send("The door seems stuck.")
		return
	end

	if not door.open then
		door.open = NewObject(door.id, door.x, door.y, door.z, door.kind, 3)
	end

	door:Hide(OpenDuration)
	door.open:Show(OpenDuration)

	user:SendSound(2676)
	user:SendSoundEx(2678, OpenDuration)
	user:MoveTo(3098, 3107)

	user:SetInt(VbTutorialProgress, 2)
	user:SetInt(VbTutorialStep, 2)
end

local gate0_0 = GetObject(3016, 3089, 3091, 0)
local gate0_1 = GetObject(3015, 3089, 3092, 0)

gate0_0.open = NewObject(3015, 3089, 3091, 0, StraightWall, FaceNorth)
gate0_1.open = NewObject(3016, 3088, 3091, 0, StraightWall, FaceNorth)

local function OpenGate0(gate, user, option)
	if user.x < 3090 then
		user:Send("This gate seems stuck.")
		return
	end

	gate0_0:Hide(OpenDuration)
	gate0_1:Hide(OpenDuration)
	gate0_0.open:Show(OpenDuration)
	gate0_1.open:Show(OpenDuration)

	user:SendSound(891)
	user:SendSoundEx(890, OpenDuration)
	user:MoveTo(user.x - 1, user.y)
end

gate0_0.OnOption = OpenGate0
gate0_1.OnOption = OpenGate0
