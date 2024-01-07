local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init("/home/hwk/.config/awesome/themes/default/theme.lua")

-- Defaults
local modkey = "Mod4"
local terminal = "xterm"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local spawn_slave = false

-- Layout
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

return {
    modkey = modkey,
    terminal = terminal,
    editor = editor,
    editor_cmd = editor_cmd,
    spawn_slave = spawn_slave
}
