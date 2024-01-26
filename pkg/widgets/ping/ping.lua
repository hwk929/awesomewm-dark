local awful = require("awful")

local SCRIPT_DIR = os.getenv("HOME") .. "/.config/awesome/pkg/widgets/ping/bin/ping.sh"
local hosts = {}

local function update_status(url, status)
    for i, v in pairs(hosts) do
        if v.host == url then
            hosts[i].status = status
            break
        end
    end
end

-- this is potentially dangerous
-- should be fine assuming the table contains only valid urls
-- https://stackoverflow.com/questions/34898430/escaping-for-proper-shell-injection-prevention
local function get_status(url, count)
    awful.spawn.easy_async_with_shell(SCRIPT_DIR .. " " .. url .. " " .. count, function(stdout)
        local u = tonumber(stdout)

        if u ~= nil then
            update_status(url, u)
            awesome.emit_signal("signal::update_ping_status", hosts)
        end
    end)

    return 0
end

local function init(list, count)
    hosts = {}

    for _, v in pairs(list) do
        hosts[#hosts+1] = {
            name = v.name,
            host = v.host,
            status = -1
        }

       get_status(v.host, count)
    end

    return hosts
end

return init
