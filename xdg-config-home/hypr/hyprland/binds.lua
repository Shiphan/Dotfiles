-- https://wiki.hypr.land/Configuring/Basics/Binds

local mainMod = "SUPER"
local alternative = "SHIFT"
local terminal = "alacritty" -- kitty
local fileManager = "nautilus"
local menu = "rofi -show drun"

---@param keys string | string[]
---@param dispatcher any
---@param flags? any
local function bind(keys, dispatcher, flags)
	if type(keys) == "table" then
		keys = table.concat(keys, " + ")
	end
	hl.bind(keys, dispatcher, flags)
end

-- Open things
bind({ mainMod, "Q" }, hl.dsp.exec_cmd(terminal))
bind({ mainMod, "E" }, hl.dsp.exec_cmd(fileManager))
bind({ mainMod, "Space" }, hl.dsp.exec_cmd(menu))
bind({ mainMod, "V" }, hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

bind({ mainMod, "A" }, function() hl.config({ input = { tablet = { relative_input = not hl.get_config("input.tablet.relative_input") } } }) end)

bind({ mainMod, "C" }, hl.dsp.window.close())
bind({ mainMod, "Delete" }, hl.dsp.window.close())
bind({ mainMod, "Backspace" }, hl.dsp.window.close())
bind({ mainMod, "F" }, hl.dsp.window.fullscreen({ mode = "maximized" }))
bind({ mainMod, alternative, "F" }, hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind({ mainMod, "R" }, hl.dsp.window.fullscreen_state({ internal = 0, client = 3, action = "toggle" }))
bind({ mainMod, "M" }, hl.dsp.layout("togglesplit"))
bind({ mainMod, "B" }, hl.dsp.window.float())
bind({ mainMod, alternative, "B" }, hl.dsp.window.pin())

bind({ mainMod, "G" }, hl.dsp.group.toggle())
bind({ mainMod, alternative, "G" }, hl.dsp.window.move({ out_of_group = true }))
bind({ mainMod, "I" }, hl.dsp.group.next())
bind({ mainMod, "O" }, hl.dsp.group.prev())
bind({ mainMod, "Tab" }, hl.dsp.window.cycle_next())
bind({ mainMod, alternative, "Tab" }, hl.dsp.window.cycle_next({ next = false }))
bind({ mainMod, "equal" }, function() hl.config({ cursor = { zoom_factor = hl.get_config("cursor.zoom_factor") + 0.1 } }) end, { repeating = true })
bind({ mainMod, "minus" }, function() hl.config({ cursor = { zoom_factor = math.max(hl.get_config("cursor.zoom_factor") - 0.1, 1) } }) end, { repeating = true })

-- Move focus with mainMod + hjkl
bind({ mainMod, "H" }, hl.dsp.focus({ direction = "l" }))
bind({ mainMod, "L" }, hl.dsp.focus({ direction = "r" }))
bind({ mainMod, "K" }, hl.dsp.focus({ direction = "u" }))
bind({ mainMod, "J" }, hl.dsp.focus({ direction = "d" }))
bind({ mainMod, alternative, "H" }, hl.dsp.window.swap({ direction = "l" }))
bind({ mainMod, alternative, "L" }, hl.dsp.window.swap({ direction = "r" }))
bind({ mainMod, alternative, "K" }, hl.dsp.window.swap({ direction = "u" }))
bind({ mainMod, alternative, "J" }, hl.dsp.window.swap({ direction = "d" }))

bind({ mainMod, "left" }, hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
bind({ mainMod, "right" }, hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
bind({ mainMod, "up" }, hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
bind({ mainMod, "down" }, hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- Switch workspaces with mainMod + [0-9]
bind({ mainMod, "1" }, hl.dsp.focus({ workspace = 1, on_current_monitor = true }))
bind({ mainMod, "2" }, hl.dsp.focus({ workspace = 2, on_current_monitor = true }))
bind({ mainMod, "3" }, hl.dsp.focus({ workspace = 3, on_current_monitor = true }))
bind({ mainMod, "4" }, hl.dsp.focus({ workspace = 4, on_current_monitor = true }))
bind({ mainMod, "5" }, hl.dsp.focus({ workspace = 5, on_current_monitor = true }))
bind({ mainMod, "6" }, hl.dsp.focus({ workspace = 6, on_current_monitor = true }))
bind({ mainMod, "7" }, hl.dsp.focus({ workspace = 7, on_current_monitor = true }))
bind({ mainMod, "8" }, hl.dsp.focus({ workspace = 8, on_current_monitor = true }))
bind({ mainMod, "9" }, hl.dsp.focus({ workspace = 9, on_current_monitor = true }))
bind({ mainMod, "0" }, hl.dsp.focus({ workspace = 10, on_current_monitor = true }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
bind({ mainMod, alternative, "1" }, hl.dsp.window.move({ workspace = 1 }))
bind({ mainMod, alternative, "2" }, hl.dsp.window.move({ workspace = 2 }))
bind({ mainMod, alternative, "3" }, hl.dsp.window.move({ workspace = 3 }))
bind({ mainMod, alternative, "4" }, hl.dsp.window.move({ workspace = 4 }))
bind({ mainMod, alternative, "5" }, hl.dsp.window.move({ workspace = 5 }))
bind({ mainMod, alternative, "6" }, hl.dsp.window.move({ workspace = 6 }))
bind({ mainMod, alternative, "7" }, hl.dsp.window.move({ workspace = 7 }))
bind({ mainMod, alternative, "8" }, hl.dsp.window.move({ workspace = 8 }))
bind({ mainMod, alternative, "9" }, hl.dsp.window.move({ workspace = 9 }))
bind({ mainMod, alternative, "0" }, hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
bind({ mainMod, "S" }, hl.dsp.workspace.toggle_special("magic"))
bind({ mainMod, alternative, "S" }, hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
bind({ mainMod, "mouse_up" }, hl.dsp.focus({ workspace = "e+1", on_current_monitor = true }))
bind({ mainMod, "mouse_down" }, hl.dsp.focus({ workspace = "e-1", on_current_monitor = true }))

bind({ mainMod, "N" }, hl.dsp.focus({ workspace = "e+1", on_current_monitor = true }))
bind({ mainMod, "P" }, hl.dsp.focus({ workspace = "e-1", on_current_monitor = true }))
bind({ mainMod, alternative, "N" }, hl.dsp.window.move({ workspace = "e+1" }))
bind({ mainMod, alternative, "P" }, hl.dsp.window.move({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind({ mainMod, "mouse:272" }, hl.dsp.window.drag(), { mouse = true })
bind({ mainMod, "mouse:273" }, hl.dsp.window.resize(), { mouse = true })
bind({ mainMod, alternative, "mouse:272" }, hl.dsp.window.resize(), { mouse = true })

-- Function keys
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; snackdaemon update volume"), { locked = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; snackdaemon update volume"), { locked = true, repeating = true })
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+; snackdaemon update volume"), { locked = true, repeating = true })
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous; snackdaemon update player"))
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause; snackdaemon update player"))
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next; snackdaemon update player"))
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("snackdaemon update screenbrightness; ~/Projects/eucalyptus-gumnut/target/release/eucalyptus-gumnut activate backlight; ~/Projects/lilight/target/release/lilight set -5%; eww update brightness=$(~/Projects/lilight/target/release/lilight get --percentage)"), { locked = true, repeating = true })
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("snackdaemon update screenbrightness; ~/Projects/eucalyptus-gumnut/target/release/eucalyptus-gumnut activate backlight; ~/Projects/lilight/target/release/lilight set +5%; eww update brightness=$(~/Projects/lilight/target/release/lilight get --percentage)"), { locked = true, repeating = true })
bind("Print", hl.dsp.exec_cmd("grim && notify-send -e \"Screenshot stored.\""))
bind({ alternative, "Print" }, hl.dsp.exec_cmd("grim - | wl-copy && notify-send -e \"Screenshot copied to clipboard.\""))
bind({ mainMod, "Print" }, hl.dsp.exec_cmd("grim -g \"$(slurp)\" && notify-send -e \"Screenshot stored.\""))
bind({ mainMod, alternative, "Print" }, hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy && notify-send -e \"Screenshot copied to clipboard.\""))
bind("XF86AudioMedia", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/toggle-powerprofile.sh; snackdaemon update powerprofiles; ~/Projects/eucalyptus-gumnut/target/release/eucalyptus-gumnut activate power-profile"), { locked = true })
bind({ alternative, "XF86AudioMedia" }, hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/toggle-powerprofile.sh prev; snackdaemon update powerprofiles; ~/Projects/eucalyptus-gumnut/target/release/eucalyptus-gumnut activate power-profile"), { locked = true })
