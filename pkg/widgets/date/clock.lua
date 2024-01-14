local wibox = require("wibox")
local calendar_widget = require("pkg.widgets.date.calendar")

local cc = wibox.widget.textclock("<span weight='ultrabold'>%a, %l:%M%P</span>", 30)
local clock = {
    cc,
    left = 10,
    right = 10,
    widget = wibox.container.margin,
}

local calendar = calendar_widget{
    placement = "top_right",
}

cc:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then calendar.toggle() end
end)

return clock
