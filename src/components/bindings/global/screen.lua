local gears = require("gears")
local awful = require("awful")
local cfg = require("src.util.config")

return gears.table.join(
    awful.key({ cfg.config.modkey, "Control" }, "j",
        function()
            awful.screen.focus_relative(1)
        end,

        { description = "Focus the next screen", group = "Screen" }
    ),

    awful.key({ cfg.config.modkey, "Control" }, "k",
        function()
            awful.screen.focus_relative(-1)
        end,

        { description = "Focus the previous screen", group = "Screen" }
    )
)
