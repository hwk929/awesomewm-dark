local beautiful = require("beautiful")
local json = require("src.util.json")

Data = { config = {} }

function Data:new(path)
    local file = io.open(path, "rb")

    if not file then
        error("invalid config.json")
        return ""
    end

    Data.config = json.decode(file:read("*a"))
    file:close()
end

function Data:theme(theme)
    beautiful.init(theme)
end

function Data:layout(layouts)
    local t = {}

    for _, v in ipairs(layouts) do
        t[#t+1] = "awful.layout.suit." .. tostring(v)
    end

    load(
        "local awful=require(\"awful\");" ..
        "awful.layout.layouts={"..table.concat(t,",").."}"
    )()
end

return Data
