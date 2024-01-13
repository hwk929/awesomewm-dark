pcall(require, "luarocks.loader")

require("src.util.config"):new(
    "/home/hwk/.config/awesome/config.json",
    "/home/hwk/.config/awesome/themes/hwk/theme.lua",
    "/home/hwk/.config/awesome/bin/autostart"
)

-- Awesome
require("src.internal.error")
require("src.internal.wibar")
require("src.internal.rules")
require("src.internal.signals")
