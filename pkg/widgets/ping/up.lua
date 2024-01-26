local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local ping = require("pkg.widgets.ping.ping")

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/pkg/widgets/ping/icons/"
local PING_COUNT = 1
local PING_FREQUANCY = 120
local PING_LIST = {}

local ping_widget = wibox.widget {
    {
        {
            {
                image = ICON_DIR .. "connection.png",
                widget = wibox.widget.imagebox
            },

            margins = 2,
            widget = wibox.container.margin
        },

        -- TODO: Fix margins
        {
            id = "ping_role",
            markup = "<span weight='bold'> 0/" .. #PING_LIST .. " </span>",
            widget = wibox.widget.textbox
        },

        layout = wibox.layout.fixed.horizontal
    },

    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,

    widget = wibox.container.background
}

local connections_list = awful.popup {
    ontop = true,
    visible = false,
    border_width = 1,
    border_color = beautiful.bg_focus,
    offset = { y = 5 },
    widget = {},

    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end
}

ping_widget:buttons(
    awful.util.table.join(awful.button({}, 1, function()
        if connections_list.visible then
            connections_list.visible = not connections_list.visible
            ping_widget:set_bg("#00000000")
        else
            connections_list:move_next_to(mouse.current_widget_geometry)
            ping_widget:set_bg(beautiful.bg_focus)

            ping(PING_LIST, PING_COUNT)
        end
    end))
)

awesome.connect_signal("signal::update_ping_status", function(hosts)
    local hosts_widget = { layout = wibox.layout.fixed.vertical }
    local failed = 0
    local icons = {
        [-1] = ICON_DIR .. "loading.png",
        [0] = ICON_DIR .. "connected.png",
        [1] = ICON_DIR .. "disconnected.png"
    }

    for _, v in pairs(hosts) do
        local ico = v.status
        local txt = ""

        if v.status < -1 or v.status > 1 then
            ico = 1
        end

        if v.status ~= 0 and v.status ~= -1 then
            txt = " (" .. v.status .. ")"
            failed = failed + 1
        end

        hosts_widget[#hosts_widget+1] = {
            {
                {
                    image = icons[ico],
                    widget = wibox.widget.imagebox
                },

                margins = 2,
                widget = wibox.container.margin
            },

            {
                markup = "<span weight='bold'> " .. v.name .. txt .. " </span>",
                widget = wibox.widget.textbox
            },

            forced_height = 25,
            layout = wibox.layout.fixed.horizontal
        }
    end

    if connections_list.visible then
        connections_list:setup(hosts_widget)
    end

    ping_widget:get_children_by_id("ping_role")[1].markup =
        "<span weight='bold'> "
            .. (#PING_LIST-failed) .. "/" .. #PING_LIST ..
        " </span>"
end)

return function(count, freq, lists)
    if count ~= nil then PING_COUNT = count end
    if freq ~= nil then PING_FREQUANCY = freq end
    if lists ~= nil then PING_LIST = lists end

    gears.timer {
        timeout = PING_FREQUANCY,
        autostart = true,
        callback = function()
            print(freq)
            ping(PING_LIST, PING_COUNT)
         end
    }

    ping(PING_LIST, PING_COUNT)
    return ping_widget
end
