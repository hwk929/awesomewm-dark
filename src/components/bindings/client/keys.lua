local gears = require("gears")
local awful = require("awful")
local cfg = require("src.util.config")

return gears.table.join(
    awful.key(
        { cfg.config.modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "Toggle floating", group = "Client" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,

        { description = "Toggle fullscreen", group = "Client" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "c",
        function(c)
            c:kill()
        end,

        { description = "Close", group = "Client" }
    ),

    awful.key({ cfg.config.modkey, "Control" }, "Return",
        function(c)
            if c ~= nil then
                c:swap(awful.client.getmaster())
            end
        end,

        { description = "Move to master", group = "Client" }
    ),

    awful.key({ cfg.config.modkey }, "o",
        function(c)
            c:move_to_screen()
        end,

        { description = "Move to screen", group = "Client" }
    ),

    awful.key({ cfg.config.modkey }, "t",
        function(c)
            c.ontop = not c.ontop
        end,

        { description = "Toggle keep on top", group = "Client" }
    ),

    awful.key({ cfg.config.modkey }, "n",
        function(c)
            c.minimized = true
        end,

        { description = "Minimize", group = "Client" }
    ),

    awful.key({ cfg.config.modkey }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,

        { description = "(un)maximize", group = "Client" }
    )
)
