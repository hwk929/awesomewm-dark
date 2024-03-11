local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local calendar_widget = require("pkg.widgets.date.calendar")

local cc = wibox.widget.textclock("<span weight='ultrabold'> %a, %l:%M%P </span>", 30)
local clock = wibox.widget {
    cc,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,

    widget = wibox.container.background
}

local clock_margins = {
    clock,
    left = 4,
    right = 4,
    widget = wibox.container.margin
}

local calendar = calendar_widget {
    placement = "top_right",
}

cc:connect_signal("button::press", function(_, _1, _2, button) -- luacheck: no unused
    if button == 1 then
        calendar.toggle()

        if calendar.get_toggle() then
            clock:set_bg(beautiful.bg_focus)
        else
            clock:set_bg("#00000000")
        end
    end
end)

-- ping_widget:buttons(
--     awful.util.table.join(awful.button({}, 1, function()
--         if connections_list.visible then
--             connections_list.visible = not connections_list.visible
--             ping_widget:set_bg("#00000000")
--         else
--             connections_list:move_next_to(mouse.current_widget_geometry)
--             ping_widget:set_bg(beautiful.bg_focus)

--             update_hosts_widget()
--         end
--     end))
-- )

return clock_margins
