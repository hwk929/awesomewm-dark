-- Modified version of:
-- https://github.com/streetturtle/awesome-wm-widgets/

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/pkg/widgets/logout/icons/"

local logout_menu_widget = wibox.widget {
    {
        {
            image = ICON_DIR .. "power_w.svg",
            resize = true,
            widget = wibox.widget.imagebox,
        },

        margins = 4,
        layout = wibox.container.margin
    },

    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,

    widget = wibox.container.background,
}

local popup = awful.popup {
    ontop = true,
    visible = false,
    border_width = 1,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {},
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end
}

-- Create menu
local rows = { layout = wibox.layout.fixed.vertical }
local font = beautiful.font

local onlock = function() awful.spawn.with_shell("i3lock") end
local onreboot = function() awful.spawn.with_shell("reboot") end
local onpoweroff = function() awful.spawn.with_shell("shutdown now") end

local menu_items = {
    { name = "Lock", icon_name = "lock.svg", command = onlock },
    { name = "Reboot", icon_name = "refresh-cw.svg", command = onreboot },
    { name = "Power off", icon_name = "power.svg", command = onpoweroff },
}

for _, item in ipairs(menu_items) do
    local row = wibox.widget {
        {
            {
                {
                    image = ICON_DIR .. item.icon_name,
                    resize = false,
                    widget = wibox.widget.imagebox
                },

                {
                    text = item.name,
                    font = font,
                    widget = wibox.widget.textbox
                },

                spacing = 12,
                layout = wibox.layout.fixed.horizontal
            },

            margins = 8,
            layout = wibox.container.margin
        },

        bg = beautiful.bg_normal,
        widget = wibox.container.background
    }

    row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
    row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

    local old_cursor, old_wibox

    row:connect_signal("mouse::enter", function()
        local wb = mouse.current_wibox

        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand1"
    end)

    row:connect_signal("mouse::leave", function()
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    row:buttons(awful.util.table.join(awful.button({}, 1, function()
        popup.visible = not popup.visible
        item.command()
    end)))

    table.insert(rows, row)
end

popup:setup(rows)

logout_menu_widget:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        if popup.visible then
            popup.visible = not popup.visible
            logout_menu_widget:set_bg("#00000000")
        else
            popup:move_next_to(mouse.current_widget_geometry)
            logout_menu_widget:set_bg(beautiful.bg_focus)
        end
    end))
)

return logout_menu_widget
