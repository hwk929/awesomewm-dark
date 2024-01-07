local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local globs = require("config.awesome")
local drop = require("awesome.keys.drop")

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ globs.modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),

    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ globs.modkey }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),

    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    { raise = true }
                )
            end
        end
    ),

    awful.button({}, 3,
        function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    ),

    awful.button({}, 4, function() awful.client.focus.byidx(1) end),
    awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end

        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

local mytextclock = {
    wibox.widget.textclock("%m/%d/%y %l:%M%P", 30),
    left = 10,
    right = 10,
    widget = wibox.container.margin,
}

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag({
        "1", "2", "3",
        "4", "5", "6",
        "7", "8", "9"
    }, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutmarginbox = {
        s.mylayoutbox,
        left = 10,
        right = 10,
        widget = wibox.container.margin,
    }

    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc( 1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc( 1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end))
    )

    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                    },

                    layout = wibox.layout.fixed.horizontal,
                },

                left = 10,
                right = 10,
                widget = wibox.container.margin
            },

            id = "background_role",
            widget = wibox.container.background,
        },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = "#777777",
            shape = gears.shape.rounded_bar,
        },

        layout = {
            spacing = 5,
            layout = wibox.layout.fixed.horizontal
        },

        widget_template = {
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },

                    margins = 2,
                    widget = wibox.container.margin,
                },

                left = 10,
                right = 10,
                widget = wibox.container.margin
            },

            id = "background_role",
            widget = wibox.container.background,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = 30,
    })

    s.mywibox:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                layout = wibox.layout.fixed.horizontal,
                s.mylayoutmarginbox,
                s.mytaglist,
                s.mypromptbox,
            },

            s.mytasklist,

            {
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                mytextclock,
                drop.mylauncher,
            },
        },

        widget = wibox.container.margin,
        margins = 5,
    }
end)

screen.connect_signal("property::geometry", set_wallpaper)
