local inactive_border = "rgba(595959aa)"

hl.config({
	general = {
		-- gaps_in = 2,
		-- gaps_out = 4,
		gaps_in = 0,
		gaps_out = 0,
		border_size = 2,
		col = {
			-- active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			-- active_border = "rgba(6688eeee)",
			active_border = "rgb(c2e8d6)",
			inactive_border = inactive_border,
		},
	},
	decoration = {
		-- rounding = 10,
		rounding = 2,
		rounding_power = 4,
		blur = {
			enabled = true,
			popups = true,
			passes = 1,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	}
})


hl.window_rule({
	name = "float-window",
	match = {
		float = true,
	},
	rounding = 8,
})

hl.window_rule({
	name = "fullscreen-window",
	match = {
		fullscreen_state_internal = 1,
	},
	border_color = "rgba(00000000)",
	border_size = 0,
	rounding = 0,
	no_shadow = true,
})

hl.config({
	group = {
		col = {
			border_active = "rgb(d0e88e)",
			border_inactive = inactive_border,
		},
		groupbar = {
			font_size = 14,
			gradients = true,
			height = 20,
			indicator_height = 0,
			-- gradient_rounding = 12,
			gradient_rounding = 0,
			gradient_rounding_power = 4,
			gradient_round_only_edges = false,
			text_color = "rgb(e0e0e0)",
			col = {
				active = "rgba(495417da)",
				inactive = "rgba(101010c0)",
			},
			gaps_in = 2,
			-- gaps_out = 2,
			gaps_out = 0,
			keep_upper_gap = false,
			blur = true,
		},
	},
})
