-- Modified version of:
-- https://github.com/streetturtle/awesome-wm-widgets/

local spawn = require("awful.spawn")
local pactl = {}

-- TODO: Change this if pactl decides to get silly
local device = "@DEFAULT_SINK@"

local function popen_and_return(cmd)
    local handle = io.popen(cmd)
    if handle == nil then return "" end

    local result = handle:read("*a")

    handle:close()
    return result
end


function pactl.show_gui()
    spawn("pavucontrol")
end

function pactl.get_volume()
    local stdout = popen_and_return("pactl get-sink-volume " .. device)
    local volsum, volcnt = 0, 0

    for vol in string.gmatch(stdout, "(%d?%d?%d)%%") do
        local vvol = tonumber(vol)

        if vvol ~= nil then
            volsum = volsum + vvol
            volcnt = volcnt + 1
        end
    end

    if volcnt == 0 then
        return nil
    end

    return volsum / volcnt
end

function pactl.get_mute()
    local stdout = popen_and_return("LC_ALL=C pactl get-sink-mute " .. device)
    if string.find(stdout, "yes") then
        return true
    else
        return false
    end
end

return pactl
