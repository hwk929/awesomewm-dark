local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local cfg = require("src.util.config")
local drop = require("src.components.drop")

return gears.table.join(
    awful.key({ cfg.config.modkey }, "s", hotkeys_popup.show_help, { description = "Show help", group = "Awesome" }),
    awful.key({ cfg.config.modkey, "Control" }, "r", awesome.restart, { description = "Reload awesome", group = "Awesome" }),
    awful.key({ cfg.config.modkey, "Shift" }, "q", awesome.quit, { description = "Quit awesome", group = "Awesome" }),
    awful.key({ cfg.config.modkey }, "w",
        function()
            drop.mymainmenu:show()
        end,

        { description = "Show main menu", group = "Awesome" }
    ),

    awful.key({ cfg.config.modkey }, "x",
        function()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,

        { description = "Lua execute prompt", group = "Awesome" }
    )
)
