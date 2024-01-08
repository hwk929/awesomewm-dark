local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local cfg = require("src.util.config")
local bindings = require("src.components.bindings")

awful.rules.rules = gears.table.join({
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = bindings.clientkeys,
            buttons = bindings.clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    {
        rule_any = {
            instance = cfg.config.window.floating.instance,
            class = cfg.config.window.floating.class,
            name = cfg.config.window.floating.name,
            role = cfg.config.window.floating.popup,
        },

        properties = { floating = true }
    },

    {
        rule_any = {
            type = { "normal", "dialog" }
        },

        properties = { titlebars_enabled = true }
    }
}, cfg.config.window.rules)
