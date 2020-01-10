-- ! Unassigned songs
-- Hypnotized (Unlocked at Klenter's Pyramid only while hypnotized during Icthlarin's Little Helper)
-- Scape Main (No area)
-- Scape Original (No area)
-- Scape Santa (No area)
-- Scape Scared (No area)
-- Suspicious (Unlocked during cutscenes in Monkey Madness I)
-- The Navigator (Unlocked in Swensen the Navigator's puzzle during The Fremennik Trials)
-- The Power of Tears (Unlocked while collecting the Tears of Guthix)

--Song(51, 150, "The Lost Melody") this should play in the mines specifically. need to be able to define smaller area
--Song(34, 75, "La Mort")

local themes = {}
local regions, err = json.loadarray("region-songs.json")

if err then
	error(err)
end

for i = 1, #regions do
	local region = regions[i]
	local song = GetSong(region.track)

	if not song then
		printf("warning: track `%s` not defined", region.track)
	else
		themes[Position3(region.x, region.y, region.z or 0):Index3()] = song
	end
end

function GetRegionSong(region)
	return themes[region:Index3()] or themes[region:Index2()]
end

hook.Add("OnEnterRegion", "Music Player", function(player, region)
	local track = GetRegionSong(region)

	if track then
		player:UnlockSong(track)

		if player:GetInt(VbMusicMode) == MusicModeAuto then
			player:SendSong(track)
		end
	end
end)