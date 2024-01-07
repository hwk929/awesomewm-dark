local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local glob = require("config.globs")

require("awful.autofocus")

client.connect_signal("manage", function (c)
    if glob.spawn_slave then
        if not awesome.startup then awful.client.setslave(c) end
    end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- Titlebars
client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),

        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { position = "left" }) : setup {
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.minimizebutton(c),
                layout = wibox.layout.fixed.vertical
            },

            {
                {
                    {
                        halign = "left",
                        widget = awful.titlebar.widget.titlewidget(c)
                    },

                    widget = wibox.container.rotate,
                    direction = "east",
                },

                buttons = buttons,
                layout = wibox.layout.fixed.vertical,
            },

            {
                {
                    awful.titlebar.widget.iconwidget(c),
                    layout = wibox.layout.fixed.horizontal()
                },

                layout = wibox.container.margin,
                margins = 3,
            },

            expand = "none",
            layout = wibox.layout.align.vertical,
        },

        widget = wibox.container.margin,
        margins = 1,
    }
end)

-- Sloppy focus
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Toggle titlebar when floating
local function float_toggle(c)
    if c.floating then awful.titlebar.show(c, "left")
    else awful.titlebar.hide(c, "left") end
end

client.connect_signal("property::floating", float_toggle)
client.connect_signal("manage", float_toggle)
