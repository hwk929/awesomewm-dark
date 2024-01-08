local gears = require("gears")
local awful = require("awful")
local cfg = require("src.util.config")

return gears.table.join(
    awful.key({ cfg.config.modkey }, "l",
        function()
            awful.tag.incmwfact(0.05)
        end,

        { description = "Increase master width factor", group = "Layout" }
    ),

    awful.key({ cfg.config.modkey },"h",
        function()
            awful.tag.incmwfact(-0.05)
        end,

        { description = "Decrease master width factor", group = "Layout" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "h",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,

        { description = "Increase the number of master clients", group = "Layout" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,

        { description = "Decrease the number of master clients", group = "Layout" }
    ),

    awful.key({ cfg.config.modkey, "Control" }, "h",
        function()
            awful.tag.incncol(1, nil, true)
        end,

        { description = "Increase the number of columns", group = "Layout" }
    ),

    awful.key({ cfg.config.modkey, "Control" }, "l",
        function()
            awful.tag.incncol(-1, nil, true)
        end,

        { description = "Decrease the number of columns", group = "Layout" }
    ),

    awful.key({ cfg.config.modkey }, "space",
        function()
            awful.layout.inc(1)
        end,

        { description = "Select next", group = "Layout" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "space",
        function()
            awful.layout.inc(-1)
        end,

        { description = "Select previous", group = "Layout" }
    )
)
