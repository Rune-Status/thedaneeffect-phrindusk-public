
local active = timer and timer.GetActive() or {}

timer = timer or {}

function timer.GetActive()
	return active
end

function timer.Get(identifier)
	return active[identifier]
end

function timer.Remove(identifier)
	active[identifier] = nil
end

function timer.Create(params)
	params.delay = params.delay and TimeToTicks(params.delay) or 0
	params.interval = params.interval and TimeToTicks(params.interval) or params.delay
	params.repeats = params.repeats or 0
	params.identifier = params.identifier or Random64()

	active[params.identifier] = {
		delay = params.delay,
		interval = params.interval,
		callback = params.callback,
		repeats = params.repeats,
		data = params.data
	}
end