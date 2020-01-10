command.Add("actor", {
	args = {"command:s", "id:a"},
	callback = function(caller, args)
		if args.command == "remove_tag" then
			local actor = GetActor(args.id)

			if actor then
				actor:Remove()
				caller:Sendf("You have successfully removed %s from this world.", actor.name)
			end
		end
	end
})

command.Add("grounditems", {
	callback = function(caller)
		local items = GetGroundItems(caller.x, caller.y, caller.z)

		for i = 1, #items do
			printf("%.0f: %+v", i, items[i])
		end
	end
})
command.Add("logout", {
	callback = function(caller)
		caller:Logout()
	end
})

command.Add("refresh", {
	callback = function(caller)
		include("../base.lua")
		caller:Send("Successfully reloaded all lua scripts.")
	end
})

command.Add("get", {
	args = { "name:s" },
	callback = function(caller, args)
		caller:Sendf("%s = %v", args.name, _G[args.name])
	end
})

local mark = {
	[true] = 'x',
	[false] = 'o'
}

command.Add("move", {
	args = { "x:n", "y:n", "z:n:0" },
	callback = function(caller, args)
		caller:SetPosition(caller.x + args.x, caller.y + args.y, caller.z + args.z)
	end
})

command.Add("tile", {
	callback = function(caller)
		caller:Sendf("%+v", GetTile(caller.x, caller.y, caller.z))
	end
})

command.Add("objects", {
	callback = function(caller)
		local objects = GetObjects(caller.x, caller.y, caller.z)

		caller:Sendf("%.0f", #objects)

		for i = 1, #objects do
			caller:Sendf("%v", objects[i])
		end
	end
})

command.Add("steps", {
	callback = function(caller)
		local x = caller.x
		local y = caller.y
		local z = caller.z
		local nw = MoveBlocked(1, x, y, z, NorthWest, PlayerObstacles)
		local n = MoveBlocked(1, x, y, z, North, PlayerObstacles)
		local ne = MoveBlocked(1, x, y, z, NorthEast, PlayerObstacles)
		local e = MoveBlocked(1, x, y, z, East, PlayerObstacles)
		local w = MoveBlocked(1, x, y, z, West, PlayerObstacles)
		local sw = MoveBlocked(1, x, y, z, SouthWest, PlayerObstacles)
		local s = MoveBlocked(1, x, y, z, South, PlayerObstacles)
		local se = MoveBlocked(1, x, y, z, SouthEast, PlayerObstacles)

		caller:Send("")
		caller:Send("")
		caller:Sendf("%v, %v, %v", mark[nw], mark[n], mark[ne])
		caller:Sendf("%v, P, %v", mark[w], mark[e])
		caller:Sendf("%v, %v, %v", mark[sw], mark[s], mark[se])
	end
})

command.Add("animate", {
	args = { "index:n:-1" },
	callback = function(caller, args)
		caller:Animate(args.index)

		if args.index == -1 then
			caller:Send("You've reset your animation.")
		else
			caller:Sendf("Playing animation: %.0f", args.index)
		end
	end
})

command.Add("mine", {
	callback = function(caller)
		caller:Act("mine")
	end
})

command.Add("set", {
	args = { "key:s", "value:n" },
	callback = function(caller, args)
		local var = _G[args.key]

		if var then
			caller:SetInt(var, args.value)
			caller:Sendf("Your varbit `%s` changed to `%.0f`.", args.key, args.value)
		else
			caller[args.key] = args.value
			caller:Sendf("Your value `%s` changed to `%.0f`.", args.key, args.value)
		end
	end
})

command.Add("players", {
	callback = function(caller)
		caller:Sendf("There are currently %.0f other players online.", #Players - 1)
	end
})

command.Add("yell", {
	callback = function(caller, args)
		local msg = {}

		for i = 1, #args do
			table.insert(msg, args[i])
		end

		Broadcastf("%s: %s", caller, table.concat(msg, " "))
	end
})

command.Add("crate", {
	callback = function(caller)
		caller:Send("A crate appears from nowhere.")

		local crate = NewObject(0)
		crate.x = caller.x
		crate.y = caller.y
		crate:Add()
	end
})

command.Add("component", {
	args = { "component:n:-1" },
	callback = function(caller, args)
		caller:SetComponent(Viewport, args.component)
	end
})

command.Add("exactmove", {
	args = { "x:n", "y:n", "delay:n", "duration:n", "direction:n" },
	callback = function(caller, args)
		caller:ExactMove(args.x, args.y, args.delay * Second, args.duration * Second, args.direction)
	end
})

command.Add("sound", {
	args = { "index:n", "delay:n:0" },
	callback = function(caller, args)
		caller:SendSoundEx(args.index, args.delay)
		caller:Sendf("Playing local sound %.0f", args.index)
	end
})

command.Add("tobject", {
	args = { "id:n", "kind:n", "facing:n", "delay:n", "restore:n" },
	callback = function(caller, args)
		EmitTemporaryObject(args.id, caller.x, caller.y, caller.z, args.kind, args.facing, args.delay, args.restore)
	end
})

command.Add("object", {
	args = { "id:n", "kind:n:10", "facing:n:0" },
	callback = function(caller, args)
		NewObject(args.id, caller.x, caller.y, caller.z, args.kind, args.facing):Add()
	end
})

command.Add("region", {
	args = { "x:n", "y:n", "offsetX:n:32", "offsetY:n:32" },
	callback = function(caller, args)
		caller:SetPosition((args.x * 64) + args.offsetX, (args.y * 64) + args.offsetY, caller.z)
	end
})

command.Add("pos", {
	args = { "x:n:-1", "y:n:-1", "z:n:-1" },
	callback = function(caller, args)
		if args.x == -1 then
			local region = caller:Region()
			caller:Sendf("%.0f, %.0f, %.0f (%.0f, %.0f)", caller.x, caller.y, caller.z, region.x, region.y)
			return
		end
		if args.z == -1 then
			args.z = caller.z
		end
		caller:SetPosition(args.x, args.y, args.z)
	end
})

command.Add("spotanim", {
	args = { "id:n", "x:n:-1", "y:n:-1", "z:n:-1", "height:n:0", "delay:n:0" },
	callback = function(caller, args)
		if args.x == -1 then
			args.x = caller.x
		end
		if args.y == -1 then
			args.y = caller.y
		end
		if args.z == -1 then
			args.z = caller.z
		end
		EmitSpotAnim(args.id, args.x, args.y, args.z, args.height, args.delay)
		caller:Sendf("Emitting spotanim %.0f", args.id)
	end
})

command.Add("emitsound", {
	args = {
		"id:n", "x:n:-1", "y:n:-1", "z:n:-1", "distance:n:15", "repeats:n:0"
	},
	callback = function(caller, args)
		if args.x == -1 then
			args.x = caller.x
		end
		if args.y == -1 then
			args.y = caller.y
		end
		if args.z == -1 then
			args.z = caller.z
		end
		EmitSound(args.id, args.x, args.y, args.z, args.distance, args.repeats)
		caller:Sendf("Emitting sound %.0f", args.id)
	end
})

command.Add("item", {
	args = { "id:n", "amount:n:1" },
	callback = function(caller, args)
		local item = NewItem(args.id, args.amount)
		if item then
			caller:GetInventory():Add(item)
		end
	end
})

command.Add("song", {
	args = { "id:n" },
	callback = function(caller, args)
		caller:SendSong(args.id)
		caller:Sendf("Playing song: %0.f", args.id)
	end
})

command.Add("jingle", {
	args = { "id:n" },
	callback = function(caller, args)
		caller:SendJingle(args.id)
		caller:Sendf("Playing jingle: %0.f", args.id)
	end
})

command.Add("empty", {
	callback = function(caller)
		caller:GetInventory():Empty()
	end
})

command.Add("update", {
	args = { "hours:n", "minutes:n", "seconds:n" },
	callback = function(caller, args)
		local duration = (args.hours * Hour) + (args.minutes * Minute) + (args.seconds * Second)
		caller:SendSystemUpdate(duration)
	end
})