-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Errors
require("lib.error")

-- Variables
-- local globs = require("lib.global")

-- Menu
-- local menu_drop = require("lib.menu_drop")

-- Wibar
require("lib.wibar")

-- Keys
-- local bindings = require("lib.bindings")

-- Rules
require("lib.rules")

-- Signals
require("lib.signals")
