local gears = require("gears")
local awful = require("awful")
local drop = require("src.components.drop")

return gears.table.join(
    awful.button({}, 3, function()
        drop:toggle()
    end),

    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
)
