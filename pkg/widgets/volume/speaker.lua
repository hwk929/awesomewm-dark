local gears = require("gears")
local wibox = require("wibox")

local pactl = require("pkg.widgets.volume.pactl")

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/pkg/widgets/volume/icons/"
local oldvol = 0.0
local oldmute = false

local function fetch_volume()
    local vol = pactl.get_volume()
    local mute = pactl.get_mute()

    if vol == nil or mute == nil then
        return
    end

    if oldvol ~= vol then
        awesome.emit_signal("signal::volume_update", vol)
        oldvol = vol
    end

    if oldmute ~= mute then
        awesome.emit_signal("signal::volume_mute_update", mute)
        oldmute = mute
    end
end

gears.timer {
    timeout = 1,
    autostart = true,
    callback = fetch_volume
}

-- Create the widget
local updates = wibox.widget {
    {
        {
            {
                id = "volume_mute_role",
                image = ICON_DIR .. "on.svg",
                widget = wibox.widget.imagebox
            },

            margins = 2,
            widget = wibox.container.margin
        },

        {
            id = "volume_value_role",
            markup = "<span weight='bold'> 0%</span>",
            widget = wibox.widget.textbox
        },

        visible = true,
        layout = wibox.layout.fixed.horizontal
    },

    left = 6,
    layout = wibox.container.margin
}

awesome.connect_signal("signal::volume_update", function(c)
    updates:get_children_by_id("volume_value_role")[1].markup =
        "<span weight='bold'> "
            .. tostring(c) ..
        "%</span>"
end)

awesome.connect_signal("signal::volume_mute_update", function(c)
    if c then
        updates:get_children_by_id("volume_mute_role")[1].image = ICON_DIR .. "off.svg"
        return
    end

    updates:get_children_by_id("volume_mute_role")[1].image = ICON_DIR .. "on.svg"
end)

updates:connect_signal("button::press", function()
    pactl.show_gui()
    fetch_volume()
end)

return updates
