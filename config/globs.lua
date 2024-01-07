-- Global Keybinds

local modkey = "Mod4"
local terminal = "xterm"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local spawn_slave = false

return {
    modkey = modkey,
    terminal = terminal,
    editor = editor,
    editor_cmd = editor_cmd,
    spawn_slave = spawn_slave
}
