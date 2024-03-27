local gears = require("gears")
local awful = require("awful")
local cfg = require("src.util.config")

return gears.table.join(
     awful.key({ cfg.config.modkey }, "Return",
        function()
            awful.spawn(cfg.config.terminal)
        end,

        { description = "Open a terminal", group = "Launcher" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "r",
        function()
            awful.screen.focused().mypromptbox:run()
        end,

        { description = "Emergency run prompt", group = "Launcher" }
    )
)
