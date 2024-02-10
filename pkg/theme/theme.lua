local xresources = require("beautiful.xresources")

local dpi = xresources.apply_dpi
local themes_path = "/home/hwk/.config/awesome/pkg/theme"
local theme = {}

local function bg_check(name)
    local f = io.open(name, "r")
    if f ~= nil then io.close(f) return true end

    return false
end

-- https://github.com/dracula/dracula-theme
theme.bg_normal = "#1e2029"
theme.bg_focus = "#282a36"
theme.bg_urgent = "#ff5555"
theme.bg_minimize = "#000000"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#f8f8f2"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#f8f8f2"

theme.useless_gap = dpi(6)
theme.border_width = dpi(2)
theme.border_normal = theme.bg_normal
theme.border_focus = "#bd93f9" -- "#6272a4"
theme.border_marked = "#ff79c6"

-- Extras
theme.titlebar_bg_focus = theme.bg_normal
theme.hotkeys_modifiers_fg = "#adadad"

-- Wibar
theme.taglist_squares_sel = themes_path.."/taglist/squarefw.png"
theme.taglist_squares_unsel = themes_path.."/taglist/squarew.png"
theme.taglist_bg_focus = theme.bg_normal

-- Menu
theme.menu_height = dpi(25)
theme.menu_width = dpi(100)

-- Close Button
theme.titlebar_close_button_focus = themes_path.."/titlebar/close_focus.svg"
theme.titlebar_close_button_normal = themes_path.."/titlebar/close_normal.svg"
theme.titlebar_close_button_focus  = themes_path.."/titlebar/close_focus.svg"

-- Minimize Button
theme.titlebar_minimize_button_normal = themes_path.."/titlebar/minimize_normal.svg"
theme.titlebar_minimize_button_focus  = themes_path.."/titlebar/minimize_focus.svg"

-- Ontop Button
theme.titlebar_ontop_button_normal_inactive = themes_path.."/titlebar/ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."/titlebar/ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = themes_path.."/titlebar/ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = themes_path.."/titlebar/ontop_focus_active.svg"

-- Sticky Button
theme.titlebar_sticky_button_normal_inactive = themes_path.."/titlebar/sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."/titlebar/sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = themes_path.."/titlebar/sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = themes_path.."/titlebar/sticky_focus_active.svg"

-- Floating Button
theme.titlebar_floating_button_normal_inactive = themes_path.."/titlebar/floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = themes_path.."/titlebar/floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = themes_path.."/titlebar/floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = themes_path.."/titlebar/floating_focus_active.svg"

-- Maximized Button
theme.titlebar_maximized_button_normal_inactive = themes_path.."/titlebar/maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."/titlebar/maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = themes_path.."/titlebar/maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = themes_path.."/titlebar/maximized_focus_active.svg"

-- Hovered Close Button
theme.titlebar_close_button_normal_hover = themes_path.."/titlebar/close_normal_hover.svg"
theme.titlebar_close_button_focus_hover  = themes_path.."/titlebar/close_focus_hover.svg"

-- Hovered Minimize Buttin
theme.titlebar_minimize_button_normal_hover = themes_path.."/titlebar/minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover  = themes_path.."/titlebar/minimize_focus_hover.svg"

-- Hovered Ontop Button
theme.titlebar_ontop_button_normal_inactive_hover = themes_path.."/titlebar/ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover  = themes_path.."/titlebar/ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover = themes_path.."/titlebar/ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover  = themes_path.."/titlebar/ontop_focus_active_hover.svg"

-- Hovered Sticky Button
theme.titlebar_sticky_button_normal_inactive_hover = themes_path.."/titlebar/sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover  = themes_path.."/titlebar/sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover = themes_path.."/titlebar/sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover  = themes_path.."/titlebar/sticky_focus_active_hover.svg"

-- Hovered Floating Button
theme.titlebar_floating_button_normal_inactive_hover = themes_path.."/titlebar/floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover  = themes_path.."/titlebar/floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover = themes_path.."/titlebar/floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover  = themes_path.."/titlebar/floating_focus_active_hover.svg"

-- Hovered Maximized Button
theme.titlebar_maximized_button_normal_inactive_hover = themes_path.."/titlebar/maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = themes_path.."/titlebar/maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = themes_path.."/titlebar/maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover  = themes_path.."/titlebar/maximized_focus_active_hover.svg"

-- Layouts
theme.layout_fairh = themes_path.."/layouts/fairh.png"
theme.layout_fairv = themes_path.."/layouts/fairv.png"
theme.layout_floating = themes_path.."/layouts/floating.png"
theme.layout_magnifier = themes_path.."/layouts/magnifier.png"
theme.layout_max = themes_path.."/layouts/max.png"
theme.layout_fullscreen = themes_path.."/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path.."/layouts/tilebottom.png"
theme.layout_tileleft = themes_path.."/layouts/tileleft.png"
theme.layout_tile = themes_path.."/layouts/tile.png"
theme.layout_tiletop = themes_path.."/layouts/tiletop.png"
theme.layout_spiral = themes_path.."/layouts/spiral.png"
theme.layout_dwindle = themes_path.."/layouts/dwindle.png"
theme.layout_cornernw = themes_path.."/layouts/cornernw.png"
theme.layout_cornerne = themes_path.."/layouts/cornerne.png"
theme.layout_cornersw = themes_path.."/layouts/cornersw.png"
theme.layout_cornerse = themes_path.."/layouts/cornerse.png"

theme.font = "FreeMono 8"
theme.icon_theme = nil
theme.wallpaper = nil

if bg_check(themes_path.."/bg") then
    theme.wallpaper = themes_path.."/bg"
end

return theme
