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

buttons.Set(906, function(user)
	user:SetInt(VbScreenBrightness, BrightnessDark)
end)

buttons.Set(908, function(user)
	user:SetInt(VbScreenBrightness, BrightnessNormal)
end)

buttons.Set(910, function(user)
	user:SetInt(VbScreenBrightness, BrightnessBright)
end)

buttons.Set(912, function(user)
	user:SetInt(VbScreenBrightness, BrightnessVBright)
end)

buttons.Set(913, function(user)
	user:SetInt(VbMouseButtons, MouseButtonsTwo)
end)

buttons.Set(914, function(user)
	user:SetInt(VbMouseButtons, MouseButtonsOne)
end)

buttons.Set(915, function(user)
	user:SetInt(VbChatEffects, ChatEffectsOn)
end)

buttons.Set(916, function(user)
	user:SetInt(VbChatEffects, ChatEffectsOff)
end)

buttons.Set(957, function(user)
	user:SetInt(VbSplitPrivateChat, SplitPrivateOn)
end)

buttons.Set(958, function(user)
	user:SetInt(VbSplitPrivateChat, SplitPrivateOff)
end)

buttons.Set(12464, function(user)
	user:SetInt(VbAcceptAid, AcceptAidYes)
end)

buttons.Set(12465, function(user)
	user:SetInt(VbAcceptAid, AcceptAidNo)
end)

buttons.Set(930, function(user)
	user:SetInt(VbMusicVolume, VolumeOff)
end)

buttons.Set(931, function(user)
	user:SetInt(VbMusicVolume, Volume1)
end)

buttons.Set(932, function(user)
	user:SetInt(VbMusicVolume, Volume2)
end)

buttons.Set(933, function(user)
	user:SetInt(VbMusicVolume, Volume3)
end)

buttons.Set(934, function(user)
	user:SetInt(VbMusicVolume, Volume4)
end)

buttons.Set(941, function(user)
	user:SetInt(VbEffectVolume, VolumeOff)
end)

buttons.Set(942, function(user)
	user:SetInt(VbEffectVolume, Volume1)
end)

buttons.Set(943, function(user)
	user:SetInt(VbEffectVolume, Volume2)
end)

buttons.Set(944, function(user)
	user:SetInt(VbEffectVolume, Volume3)
end)

buttons.Set(945, function(user)
	user:SetInt(VbEffectVolume, Volume4)
end)