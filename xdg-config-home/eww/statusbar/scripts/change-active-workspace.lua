#!/usr/bin/env lua

local function clamp(min, max, x)
	return math.max(min, math.min(x, max))
end

local direction = arg[1]
local current = tonumber(arg[2])

if direction == "down" then
	os.execute(string.format("hyprctl dispatch workspace %d", clamp(1, 10, current + 1)))
elseif direction == "up" then
	os.execute(string.format("hyprctl dispatch workspace %d", clamp(1, 10, current - 1)))
else
	error(string.format("Unknow direction: %s", direction))
end
