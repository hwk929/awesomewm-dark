local gears = require("gears")
local awful = require("awful")
local cfg = require("src.util.config")

return gears.table.join(
    awful.key({ cfg.config.modkey }, "u", awful.client.urgent.jumpto, { description = "Jump to urgent client", group = "Client" }),
    awful.key({ cfg.config.modkey }, "j",
        function()
            awful.client.focus.byidx(1)
        end,

        { description = "Focus next by index", group = "Client" }
    ),

    awful.key({ cfg.config.modkey }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,

        { description = "Focus previous by index", group = "Client" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "j",
        function()
            awful.client.swap.byidx(1)
        end,

        { description = "Swap with next client by index", group = "Client" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "k",
        function()
            awful.client.swap.byidx(-1)
        end,

        { description = "Swap with previous client by index", group = "Client" }
    ),

    awful.key({ cfg.config.modkey }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,

        { description = "Go back", group = "Client" }
    ),

    awful.key({ cfg.config.modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,

        { description = "Restore minimized", group = "Client" }
    )
)
