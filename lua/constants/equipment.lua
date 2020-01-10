local sounds = {
	default = 1347,

	head = 1342,
	cape = 1347,
	neck = 1347,
	platebody = 1346,
	body = 1347,
	shield = 1343,
	legs = 1347,
	hands = 1791,
	feet = 1664,
	ring = 1347,
	ammo = 1350,

	weapon = {
		whips = 1344,
		claws = 1344,
		blunt_weapons = 1344,
		spiked_weappons = 1344,
		stabbing_swords = 1344,
		slashing_swords = 1344,
		crossbows = 1344,
		staves = 1351,
		spears = 1351,
		halberds = 1351,
		pickaxes = 1352,
		axes = 1353,
		bows = 1793,
		thrown_weapons = 1793
	}
}

function GetEquipmentSound(item)
	if not item then
		return sounds.default
	end

	local sound

	if item.equipableWeapon then
		sound = sounds.weapon[item.weapon.typeName] or sounds.default
	else
		sound = sounds[item.slotName] or sounds.default
	end

	return sound
end