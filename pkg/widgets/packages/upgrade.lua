local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/pkg/widgets/packages/icons/"

-- local upgradeable = "bash -c 'checkupdates | wc -l'"
local upgradeable = "bash -c 'cat /home/hwk/.config/awesome/todo | wc -l'"
local old_upgradeable = nil

local function fetch_updates()
    awful.spawn.easy_async_with_shell(upgradeable, function(stdout)
        local u = tonumber(stdout)

        if u ~= old_upgradeable then
            awesome.emit_signal("signal::upgradeable_packages", u)
            old_upgradeable = u
        end
    end)
end

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = fetch_updates
}

-- Create the widget
local updates = wibox.widget {
    {
        {
            image = ICON_DIR .. "package.svg",
            widget = wibox.widget.imagebox
        },

        margins = 2,
        widget = wibox.layout.margin
    },

    {
        id = "upgradeable_role",
        markup = "<span weight='bold' color='#a5a6a9'>0x</span>",
        widget = wibox.widget.textbox
    },

    visible = true,
    layout = wibox.layout.fixed.horizontal
}

awesome.connect_signal("signal::upgradeable_packages", function(c)
    updates:get_children_by_id("upgradeable_role")[1].markup =
        "<span weight='bold' color='#a5a6a9'> "
            .. tostring(c) ..
        "x</span>"
end)

return updates
