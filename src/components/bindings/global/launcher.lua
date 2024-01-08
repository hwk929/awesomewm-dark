local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local cfg = require("src.util.config")

return gears.table.join(
     awful.key({ cfg.config.modkey }, "Return",
        function()
            awful.spawn(cfg.config.terminal)
        end,

        { description = "Open a terminal", group = "Launcher" }
    ),

    awful.key({ cfg.config.modkey }, "r",
        function()
            awful.screen.focused().mypromptbox:run()
        end,

        { description = "Run prompt", group = "Launcher" }
    ),

    awful.key({ cfg.config.modkey }, "p",
        function()
            menubar.show()
        end,

        { description = "Show the menubar", group = "Launcher" }
    )
)
