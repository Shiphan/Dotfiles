local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Unikitty"
config.window_background_opacity = 0.8
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_content_alignment = {
	horizontal = "Center",
	vertical = "Center",
}
-- config.window_background_image = "/home/shiphan/Pictures/rim-wallpaper2-2.png"
-- config.enable_scroll_bar = true

config.font = wezterm.font_with_fallback({
	"Noto Sans Mono",
	"Noto Sans CJK TC",
})

-- Tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- config.default_prog = { "nu" }

return config
