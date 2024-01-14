-- very cool
-- https://www.reddit.com/r/awesomewm/comments/11cfke8/system_tray_in_every_screen/

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/pkg/widgets/taskbar/icons/"

-- Create elements
local systray = wibox.widget.systray(); systray.base_size = 24
local sys_button = awful.widget.button {
    image = ICON_DIR .. "drop.svg",
}

local rows_tray = { layout = wibox.layout.fixed.vertical }
local pop_tray = awful.popup {
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

table.insert(rows_tray, {
    {
        systray,

        margins = 10,
        widget = wibox.container.margin,
    },

    forced_width = 150,
    widget = wibox.container.background
})

local function get_current_screen()
    local mouse_coords = mouse.coords()

    for i = 1, screen:count() do
        local screen_geom = screen[i].geometry

        if mouse_coords.x >= screen_geom.x and
                mouse_coords.x < screen_geom.x + screen_geom.width and
                mouse_coords.y >= screen_geom.y and
                mouse_coords.y < screen_geom.y + screen_geom.height then
            return i
        end
    end

    return nil
end

local function update_systray()
    local current_screen_index = get_current_screen()

    if current_screen_index ~= nil then
        systray:set_screen(screen[current_screen_index])
    end
end

sys_button:buttons(
    awful.util.table.join(awful.button({}, 1, function()
        if pop_tray.visible then
            pop_tray.visible = not pop_tray.visible
        else
            pop_tray:move_next_to(mouse.current_widget_geometry)
        end
    end))
)

pop_tray:setup(rows_tray)

-- Keep systray on the correct monitor
sys_button:connect_signal("mouse::enter", update_systray)
sys_button:connect_signal("mouse::move", update_systray)
sys_button:connect_signal("button::press", update_systray)
pop_tray:connect_signal("mouse::enter", update_systray)

return sys_button
