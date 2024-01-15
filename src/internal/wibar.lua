local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local cfg = require("src.util.config")

local taskbar_widget = require("pkg.widgets.taskbar.tray")
local capslock_widget = require("pkg.widgets.caps.lock")
local volume_widget = require("pkg.widgets.volume.speaker")
local upgradeable_widget = require("pkg.widgets.packages.upgrade")
local date_widget = require("pkg.widgets.date.clock")
local logout_widget = require("pkg.widgets.logout.menu")

-- Full fade list:
--   "#ffffff",
--   "#e8e9ea",
--   "#d2d2d4",
--   "#bbbcbf",
--   "#a5a6a9",
--   "#8e8f94",
--   "#78797f",
--   "#616369",
--   "#4b4d54",
--   "#34363e"
--   "#30323a",
--   "#2b2d36",
--   "#272932",
--   "#22242d"

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ cfg.config.modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),

    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ cfg.config.modkey }, 3,
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
        return
    end

    gears.wallpaper.set(beautiful.bg_normal)
end

local function createFade(self, c3, index, objects)
    local sel = 1
    local weight = "normal"
    local fade = {
        "#ffffff",
        "#a5a6a9",
        "#78797f",
        "#4b4d54",
        "#34363e",
        "#30323a",
        "#2b2d36",
        "#272932",
        "#22242d"
    }

    for i in pairs(objects) do
        if objects[i].selected then
            sel = objects[i].index
        end
    end

    if (c3.selected) then
        weight = "ultrabold"
    end

    self:get_children_by_id("index_role")[1].markup =
        "<span weight='" .. weight ..
            "' color='".. fade[math.abs(index-sel)+1] ..
            "' font_desc='FreeMono 8'>" .. index ..
        "</span>"
end


awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
    awful.tag({
        "1", "2", "3",
        "4", "5", "6",
        "7", "8", "9"
    }, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()
    s.mypromptmarginbox = {
        s.mypromptbox,
        left = 10,
        right = 10,
        widget = wibox.container.margin,
    }

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

    -- Create taglist
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        widget_template = {
            {
                {
                    {
                        id = "index_role",
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
            create_callback = createFade,
            update_callback = createFade,
        },

        buttons = taglist_buttons
    }

    -- Create tasklist
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = beautiful.bg_focus,
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
        height = 30
    })

    s.mywibox:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                layout = wibox.layout.fixed.horizontal,
                s.mylayoutmarginbox,
                s.mytaglist,
                s.mypromptmarginbox,
            },

            s.mytasklist,

            {
                layout = wibox.layout.fixed.horizontal,
                taskbar_widget,

                {
                    {
                        capslock_widget,
                        volume_widget,
                        upgradeable_widget,

                        spacing = 12,
                        layout = wibox.layout.fixed.horizontal,
                    },

                    right = 10,
                    layout = wibox.layout.margin
                },

                {
                    markup = "<span weight='ultrabold'> - </span>",
                    widget = wibox.widget.textbox
                },

                date_widget,
                logout_widget,
            },
        },

        widget = wibox.container.margin,
        margins = 5,
    }
end)

screen.connect_signal("property::geometry", set_wallpaper)
