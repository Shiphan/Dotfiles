-- https://wiki.hypr.land/Configuring/Basics/Autostart

hl.on("hyprland.start", function ()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("snackdaemon daemon")
	-- hl.exec_cmd("hyprpm reload -n")
	-- hl.exec_cmd("nm-applet")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("eww daemon")
	-- hl.exec_cmd("eww open statusbar")
	-- hl.exec_cmd("eucalyptus-twig")
	-- hl.exec_cmd("eucalyptus-gumnut daemon")
	hl.exec_cmd("~/Projects/eucalyptus-twig/target/release/eucalyptus-twig")
	-- hl.exec_cmd("~/Projects/eucalyptus-gumnut/target/release/eucalyptus-gumnut daemon")
	hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
	hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
end)

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables

---@param t table<string, string>
local function env(t)
	for k, v in pairs(t) do
		hl.env(k, v)
	end
end

env({
	-- Some default env vars.
	["XCURSOR_SIZE"] = "24",
	["QT_QPA_PLATFORMTHEME"] = "qt6ct",  -- change to qt6ct if you have that

	["ELECTRON_OZONE_PLATFORM_HINT"] = "auto",
	["GDK_BACKEND"] = "wayland,x11",
	["QT_QPA_PLATFORM"] = "wayland;xcb",
	-- ["SDL_VIDEODRIVER"] = "wayland",
	["CLUTTER_BACKEND"] = "wayland",
	["XDG_CURRENT_DESKTOP"] = "Hyprland",
	["XDG_SESSION_TYPE"] = "wayland",
	["XDG_SESSION_DESKTOP"] = "Hyprland",
	["QT_AUTO_SCREEN_SCALE_FACTOR"] = "1",
	-- Variables for nvidia, see https://wiki.hyprland.org/Nvidia/
	-- ["LIBVA_DRIVER_NAME"] = "nvidia",
	-- ["XDG_SESSION_TYPE"] = "wayland",
	-- ["GBM_BACKEND"] = "nvidia-drm",
	-- ["__GLX_VENDOR_LIBRARY_NAME"] = "nvidia",
	-- ["WLR_NO_HARDWARE_CURSORS"] = "1",

	-- env for driver
	["LIBVA_DRIVER_NAME"] = "radeonsi",
	["VDPAU_DRIVER"] = "radeonsi",
})
