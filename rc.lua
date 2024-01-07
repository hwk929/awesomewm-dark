pcall(require, "luarocks.loader")

-- Configuration
require("config.layout")
require("config.theme")

-- Awesome
require("src.internal.error")
require("src.internal.wibar")
require("src.internal.rules")
require("src.internal.signals")
