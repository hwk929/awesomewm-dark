local beautiful = require("beautiful")
local json = require("src.util.json")

Data = { config = {} }

function Data:new(path, theme)
    local file = io.open(path, "rb")

    if not file then
        error("invalid config.json")
        return ""
    end

    Data.config = json.decode(file:read("*a"))
    Data:layout()

    beautiful.init(theme)
    file:close()
end

-- Awful rules
function Data:layout()
    local t = {}

    for _, v in ipairs(Data.config.window.layouts) do
        t[#t+1] = "awful.layout.suit." .. tostring(v)
    end

    load(
        "local awful=require(\"awful\");" ..
        "awful.layout.layouts={"..table.concat(t,",").."}"
    )()
end

return Data
