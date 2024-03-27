local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local cfg = require("src.util.config")
local cfg_path = os.getenv("HOME") .. "/.config/awesome"

local myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Edit Config", cfg.config.editor .. " " .. cfg_path },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
}

local menu = awful.menu({
    items = gears.table.join(
        {{ "Awesome", myawesomemenu }},
        {{ "Context", cfg.config.context }},
        {{ "Terminal", cfg.config.terminal }}
    )
})

return menu
