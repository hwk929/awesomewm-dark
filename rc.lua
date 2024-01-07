-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
-- local gears = require("gears")
-- local awful = require("awful")
-- require("awful.autofocus")
-- Widget and layout library
-- local wibox = require("wibox")
-- Theme handling library
-- local beautiful = require("beautiful")

-- local menubar = require("menubar")
-- local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

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
