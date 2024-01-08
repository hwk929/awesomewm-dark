local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local cfg = require("src.util.config")
local drop = require("src.components.drop")

require("awful.hotkeys_popup.keys")

local mousekeys = gears.table.join(
    awful.button({}, 3, function()
        drop.mymainmenu:toggle()
    end),

    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
)

local globalkeys = gears.table.join(
    -- Awesome
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
    ),

    -- Tag
    awful.key({ cfg.config.modkey }, "Left", awful.tag.viewprev, { description = "View previous", group = "Tag" }),
    awful.key({ cfg.config.modkey }, "Right", awful.tag.viewnext, { description = "View next", group = "Tag" }),
    awful.key({ cfg.config.modkey }, "Escape", awful.tag.history.restore, { description = "Go back", group = "Tag" }),

    -- Client
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
    ),

    -- Screen
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
    ),

    -- Launcher
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
    ),

    -- Layout
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

local clientkeys = gears.table.join(
    awful.key( { cfg.config.modkey, "Control" }, "space", awful.client.floating.toggle, { description = "Toggle floating", group = "Client" }),
    awful.key({ cfg.config.modkey }, "f",
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
            c:swap(awful.client.getmaster())
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
    ),

    awful.key({ cfg.config.modkey, "Control" }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,

        { description = "(un)maximize vertically", group = "Client" }
    ),

    awful.key({ cfg.config.modkey, "Shift" }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,

        { description = "(un)maximize horizontally", group = "Client" }
    )
)

-- Bind all key # to tags
for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys,
        awful.key(
            { cfg.config.modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,

            { description = "View tag #" .. i, group = "Tag" }
        ),

        awful.key({ cfg.config.modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,

            { description = "Toggle tag #" .. i, group = "Tag" }
        ),

        awful.key({ cfg.config.modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,

            { description = "Move focused client to tag #" .. i, group = "Tag" }
        ),

        awful.key({ cfg.config.modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,

            { description = "Toggle focused client on tag #" .. i, group = "Tag" }
        )
    )
end

local clientbuttons = gears.table.join(
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

-- Set keys
root.keys(globalkeys)
root.buttons(mousekeys)

return {
    clientkeys = clientkeys,
    clientbuttons = clientbuttons
}
