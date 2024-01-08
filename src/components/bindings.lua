local gears = require("gears")

local clientkeys = require("src.components.bindings.client.keys")
local clientbuttons = require("src.components.bindings.client.keys")
local mousekeys = require("src.components.bindings.client.mouse")

require("awful.hotkeys_popup.keys")

local globalkeys = gears.table.join(
    require("src.components.bindings.global.awesome"),
    require("src.components.bindings.global.tag"),
    require("src.components.bindings.global.client"),
    require("src.components.bindings.global.screen"),
    require("src.components.bindings.global.launcher"),
    require("src.components.bindings.global.layout")
)

-- Set keys
root.keys(globalkeys)
root.buttons(mousekeys)

return {
    clientkeys = clientkeys,
    clientbuttons = clientbuttons
}
