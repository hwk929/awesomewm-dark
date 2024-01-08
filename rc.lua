pcall(require, "luarocks.loader")

local cfg = require("src.util.config")

cfg:new("/home/hwk/.config/awesome/config.json")
cfg:theme("/home/hwk/.config/awesome/themes/default/theme.lua")
cfg:layout(cfg.config.window.layouts)

-- Awesome
require("src.internal.error")
require("src.internal.wibar")
require("src.internal.rules")
require("src.internal.signals")
