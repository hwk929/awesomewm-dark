local gears = require("gears")
local awful = require("awful")
local cfg = require("src.util.config")

return gears.table.join(
    awful.button({}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),

    awful.button({ cfg.config.modkey }, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),

    awful.button({ cfg.config.modkey }, 3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)
