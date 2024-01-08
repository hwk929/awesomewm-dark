local gears = require("gears")
local awful = require("awful")
local cfg = require("src.util.config")

local tags = gears.table.join(
    awful.key({ cfg.config.modkey }, "Left", awful.tag.viewprev, { description = "View previous", group = "Tag" }),
    awful.key({ cfg.config.modkey }, "Right", awful.tag.viewnext, { description = "View next", group = "Tag" }),
    awful.key({ cfg.config.modkey }, "Escape", awful.tag.history.restore, { description = "Go back", group = "Tag" })
)

-- Bind all key # to tags
for i = 1, 9 do
    tags = gears.table.join(
        tags,
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

return tags
