-- https://wiki.hypr.land/Configuring/Basics/Window-Rules

-- hl.window_rule({
--     name = "suppress-maximize",
--     match = {
--         class = ".*",
--     },
--     suppress_event = "fullscreen maximize fullscreenoutput",
-- })

hl.window_rule({
    name = "firefox-pip-float",
    match = {
        class = "firefox",
        title = "子母畫面",
    },
    float = true,
})

-- FreeCad on Wayland now has a issue where you can see the wallpaper through it: <https://github.com/FreeCAD/FreeCAD/issues/6177>
-- hl.window_rule({
--     name = "FreeCAD-opaque",
--     match = {
--         class = "org\\.freecad\\.FreeCAD",
--     },
--     opaque = true,
--     force_rgbx = true,
-- })

hl.layer_rule({
    name = "ewwStatusBar",
    match = {
        namespace = "ewwStatusBar",
    },
    blur = true,
    ignore_alpha = 0,
})
hl.layer_rule({
    name = "ewwSnackBar",
    match = {
        namespace = "ewwSnackBar",
    },
    blur = true,
    ignore_alpha = 0,
    animation = "slide",
})
hl.layer_rule({
    name = "ewwPowerMenu",
    match = {
        namespace = "ewwPowerMenu",
    },
    blur = true,
    -- ignore_alpha = 0,
    dim_around = true,
    animation = "slide",
})
hl.layer_rule({
    name = "rofi",
    match = {
        namespace = "rofi",
    },
    blur = true,
    ignore_alpha = 0,
    dim_around = true,
    animation = "slide",
})
hl.layer_rule({
    name = "eucalyptus-twig-power-menu",
    match = {
        namespace = "eucalyptus-twig-power-menu",
    },
    blur = true,
    -- ignore_alpha = 0,
    dim_around = true,
    animation = "slide",
})
