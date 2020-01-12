Enum("Brightness", "", "Dark", "Normal", "Bright", "VBright")
Enum("MouseButtons", "Two", "One")
Enum("ChatEffects", "On", "Off")
Enum("SplitPrivate", "Off", "On")
Enum("AcceptAid", "No", "Yes")
Enum("Volume", "4", "3", "2", "1", "Off")

hook.Add("OnNewPlayer", "DefaultGameOptions", function(player)
	player:SetInt(VbScreenBrightness, BrightnessNormal)
	player:SetInt(VbMouseButtons, MouseButtonsTwo)
	player:SetInt(VbChatEffects, ChatEffectsOn)
	player:SetInt(VbSplitPrivateChat, SplitPrivateOn)
	player:SetInt(VbAcceptAid, AcceptAidNo)
end)

button.Set(906, function(user)
	user:SetInt(VbScreenBrightness, BrightnessDark)
end)

button.Set(908, function(user)
	user:SetInt(VbScreenBrightness, BrightnessNormal)
end)

button.Set(910, function(user)
	user:SetInt(VbScreenBrightness, BrightnessBright)
end)

button.Set(912, function(user)
	user:SetInt(VbScreenBrightness, BrightnessVBright)
end)

button.Set(913, function(user)
	user:SetInt(VbMouseButtons, MouseButtonsTwo)
end)

button.Set(914, function(user)
	user:SetInt(VbMouseButtons, MouseButtonsOne)
end)

button.Set(915, function(user)
	user:SetInt(VbChatEffects, ChatEffectsOn)
end)

button.Set(916, function(user)
	user:SetInt(VbChatEffects, ChatEffectsOff)
end)

button.Set(957, function(user)
	user:SetInt(VbSplitPrivateChat, SplitPrivateOn)
end)

button.Set(958, function(user)
	user:SetInt(VbSplitPrivateChat, SplitPrivateOff)
end)

button.Set(12464, function(user)
	user:SetInt(VbAcceptAid, AcceptAidYes)
end)

button.Set(12465, function(user)
	user:SetInt(VbAcceptAid, AcceptAidNo)
end)

button.Set(930, function(user)
	user:SetInt(VbMusicVolume, VolumeOff)
end)

button.Set(931, function(user)
	user:SetInt(VbMusicVolume, Volume1)
end)

button.Set(932, function(user)
	user:SetInt(VbMusicVolume, Volume2)
end)

button.Set(933, function(user)
	user:SetInt(VbMusicVolume, Volume3)
end)

button.Set(934, function(user)
	user:SetInt(VbMusicVolume, Volume4)
end)

button.Set(941, function(user)
	user:SetInt(VbEffectVolume, VolumeOff)
end)

button.Set(942, function(user)
	user:SetInt(VbEffectVolume, Volume1)
end)

button.Set(943, function(user)
	user:SetInt(VbEffectVolume, Volume2)
end)

button.Set(944, function(user)
	user:SetInt(VbEffectVolume, Volume3)
end)

button.Set(945, function(user)
	user:SetInt(VbEffectVolume, Volume4)
end)