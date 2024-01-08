local gears = require("gears")
local awful = require("awful")

local cfg = require("src.util.config")
local clientkeys = require("src.components.bindings.client.keys")
local clientbuttons = require("src.components.bindings.client.buttons")
local mousekeys = require("src.components.bindings.client.mouse")

if cfg.config.window.show_hotkeys then
    require("awful.hotkeys_popup.keys")
end

-- Load keys
local globalkeys = gears.table.join(
    require("src.components.bindings.global.awesome"),
    require("src.components.bindings.global.tag"),
    require("src.components.bindings.global.client"),
    require("src.components.bindings.global.screen"),
    require("src.components.bindings.global.launcher"),
    require("src.components.bindings.global.layout")
)

local function configkeys()
    local shortcuts = {}

    for group, tbl in pairs(cfg.config.bindings) do
        for bind in pairs(cfg.config.bindings[group]) do
            shortcuts = gears.table.join(shortcuts,
                awful.key(gears.table.join({ cfg.config.modkey }, tbl[bind].alt), tbl[bind].key,
                    function()
                        awful.spawn.with_shell(tbl[bind].cmd)
                    end,

                    { description = tbl[bind].title, group = group }
                )
            )
        end
    end

    return shortcuts
end

-- Set keys
root.keys(gears.table.join(globalkeys, configkeys()))
root.buttons(mousekeys)

return {
    clientkeys = clientkeys,
    clientbuttons = clientbuttons
}
