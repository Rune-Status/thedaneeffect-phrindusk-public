Enum("MusicMode", "Manual", "Auto")
Enum("MusicLoop", "Off", "On")

local varbitBySong = {}
local nameBySong = {}
local songByName = {}
local songByButton = {}

local songs, err = json.loadarray("songs.json")

if err then
	error(err)
end

for i = 1, #songs do
	local song = songs[i]

	nameBySong[song.id] = song.name
	songByButton[song.button] = song.id
	songByName[song.name] = song.id
	varbitBySong[song.id] = _G["VbSong" .. Pascal(song.name)]

	buttons.Set(song.button, SongButton)
end

---A utility function used to get a song index by name.
---@see content/region_music.lua
---@param name string
function GetSong(name)
	return songByName[name]
end

local function AutoButton(user)
	local mode = user:GetInt(VbMusicMode)

	if mode ~= MusicModeAuto then
		user:SetInt(VbMusicMode, MusicModeAuto)
		user:SendComponentText(4439, "AUTO")

		local song = GetRegionSong(user:Region())

		if song then
			user:SendSong(song)
		end

		-- forget the manual song
		user.song = nil
	end
end

local function ManualButton(user)
	local mode = user:GetInt(VbMusicMode)

	if mode ~= MusicModeManual then
		user:SetInt(VbMusicMode, MusicModeManual)
	end

	if not user.song then
		user.song = GetRegionSong(user:Region())
	end

	if user.song then
		user:SendSong(user.song)
		user:SendComponentText(4439, nameBySong[user.song])
	end
end

local function LoopButton(user)
	user:SetBool(VbMusicLoop, not user:GetBool(VbMusicLoop))
end

buttons.Set(6269, AutoButton)
buttons.Set(6270, ManualButton)
buttons.Set(9925, LoopButton)

local function SongButton(user, button)
	local song = songByButton[button]

	if not song then
		return
	end

	local varbit = varbitBySong[song]
	local unlocked

	if varbit then
		unlocked = user:GetBool(varbit)
	else
		unlocked = true
	end

	if unlocked then
		user.song = song
		ManualButton(user)
	else
		user:Send("You have not unlocked this piece of music yet!")
	end
end

-- set defaults
hook.Add("OnNewPlayer", "DefaultMusicOptions", function(player)
	AutoButton(player)
	player:SetInt(VbMusicLoop, MusicLoopOn)
	player:SetInt(VbMusicVolume, Volume3)
	player:SetInt(VbEffectVolume, Volume3)
end)

---@param song number
function Player:UnlockSong(song)
	local varbit = varbitBySong[song]

	if varbit and not self:GetBool(varbit) then
		self:SetBool(varbit, true)
		self:Sendf("You have unlocked a new music track: %s.", nameBySong[song])
	end
end