local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local cfg = require("src.util.config")

local myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", cfg.config.terminal .. " -e man awesome" },
    { "Edit Config", cfg.config.editor.cmd .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
}

local mymainmenu = awful.menu({
    items = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        { "Terminal", cfg.config.terminal }
    }
})

local mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

menubar.utils.terminal = cfg.config.terminal

return {
    mymainmenu = mymainmenu,
    mylauncher = mylauncher
}
