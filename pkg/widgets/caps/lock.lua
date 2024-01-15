local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/pkg/widgets/caps/icons/"

local caps_lock_script = "bash -c 'xset -q | sed -n \"s/^.*Caps Lock:\\s*\\(\\S*\\).*$/\\1/p\"'"
local caps_lock_status_old = nil

-- Check capslock state, if its on, emit a true, else emit false, initialized as nil
local function emit_caps_lock_status()
    awful.spawn.easy_async_with_shell(caps_lock_script, function(stdout)
        local caps_lock_status = stdout:match("on") == "on"

        if caps_lock_status ~= caps_lock_status_old then
            awesome.emit_signal("signal::capslock", caps_lock_status)
            caps_lock_status_old = caps_lock_status
        end
    end)
end

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = emit_caps_lock_status
}

-- Create the widget
local locks = wibox.widget {
    {
        {
            {
                image = ICON_DIR .. "lock.svg",
                widget = wibox.widget.imagebox
            },

            margins = 4,
            widget = wibox.layout.margin
        },

        {
            markup = "<span weight='bold' color='#a5a6a9'> Caps</span>",
            widget = wibox.widget.textbox
        },

        layout = wibox.layout.fixed.horizontal
    },

    visible = false,
    left = 8, -- push taskbar left
    layout = wibox.layout.margin
}

awesome.connect_signal("signal::capslock", function(c)
    locks:set_visible(c)
end)

return locks
