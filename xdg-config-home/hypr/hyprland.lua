-- https://wiki.hypr.land/Configuring/Basics/Monitors
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1.5666666,
})

require("hyprland/initialize")
require("hyprland/layout")
require("hyprland/binds")
require("hyprland/rules")
require("hyprland/style")

-- https://wiki.hypr.land/Configuring/Basics/Variables
hl.config({
	debug = {
		disable_logs = true,
	},
	general = {
		allow_tearing = false,
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		middle_click_paste = false,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.config({
	input = {
		-- mouse
		sensitivity = 0,
		-- keyboard
		follow_mouse = 1,
		touchpad = {
			disable_while_typing = true,
			natural_scroll = true,
			scroll_factor = 0.25,
			drag_lock = 0,
		},
		tablet = {
			output = "current",
			relative_input = false,
		},
	},
	gestures = {
		workspace_swipe_cancel_ratio = 0.4,
		workspace_swipe_forever = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.gesture({
	fingers = 4,
	direction = "pinchin",
	action = "cursor_zoom",
	mode = "live",
})
hl.gesture({
	fingers = 4,
	direction = "pinchout",
	action = "cursor_zoom",
	mode = "live",
})

hl.config({
	animations = {
		enabled = true,
		workspace_wraparound = false,
	},
})

hl.curve("myBezier", {
	type = "bezier",
	points = {
		{0, 1},
		{0.2, 1},
	},
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 7,
	bezier = "myBezier",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 7,
	bezier = "default",
	style = "popin 80%",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 10,
	bezier = "default",
})
hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 8,
	bezier = "default",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 7,
	bezier = "default",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 6,
	bezier = "default",
})
hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 4,
	bezier = "default",
})
