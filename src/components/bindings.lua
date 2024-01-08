local gears = require("gears")

local cfg = require("src.util.config")
local clientkeys = require("src.components.bindings.client.keys")
local clientbuttons = require("src.components.bindings.client.buttons")
local mousekeys = require("src.components.bindings.client.mouse")

if cfg.config.window.show_hotkeys then
    require("awful.hotkeys_popup.keys")
end

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
