getgenv().RAYFIELD_SECURE = true
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local window = Rayfield:CreateWindow({
    name = "MayBeeHub",
    subtitle = "Enjoy MayBeeHub",
    sidebarLayout = true,
})

window:Save()
window:Load()

tab:CreateConsole({
    name = "Console",
    text = [[print("Opening MayBeeHub")]],
})

Rayfield:CreateWindow({ name = "MayBeeHub", theme = "cobalt" })

window:Notify({
    title = "Auto-saved",
    content = "Your configuration was saved.",
    duration = 5,
})

window:Toast({ title = "Saved", icon = 125823673784681 })

window:Toast({
    title = "MYB",
    subtitle = "joined the server",
    avatar = 1,
})

window:Popup({
    title = "Reset everything?",
    content = "This clears every saved value. You can't undo it.",
    options = {
        { text = "Cancel" },
        { text = "Reset", style = "danger", callback = function() end },
    },
})


local tag = window:CreateTag({
    text = "us-en",
    color = Color3.fromRGB(255, 175, 15),
})

tag:Set({ text = "live", color = Color3.fromRGB(80, 200, 120) })

local console = tab:CreateConsole({
    name = "Console",
    height = 130,
    follow = true,
    maxLines = 200,
})

console:Append("player joined")

local tab = window:CreateTab({ name = "Home", icon = 93364949241311 })

tab:CreateButton({
    name = "Huss Valley",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Huss-Valley-MayBeeHub-232549"))()
    end,
})

tab:CreateButton({
    name = "MayBeeHub Tsb",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/The-Strongest-Battlegrounds-MayBeeHub-TSB-(FixedUnpatchedUpgrade)-229100"))()
    end,
})

tab:CreateButton({
    name = "MayBeeHub Tsb 2",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/The-Strongest-Battlegrounds-TSB-OpHub-224220"))()
    end,
})

tab:CreateButton({
    name = "Rivals MayBeeHub",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/RIVALS-MayBeeHub-229831"))()
    end,
})

tab:CreateButton({
    name = "jujutsu shenanigans",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/SKY-ASSASSIN-Jujutsu-Shenanigans-(OP)-227910"))()
    end,
})

tab:CreateButton({
    name = "animal hospital",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/2nd-FLOOR-Animal-Hospital-(Anomaly)-Animal-hospital-(auto-farm-Infinte-Sanity-and-more-70+)-227579"))()
    end,
})

tab:CreateButton({
    name = "animal hospital",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/X7-+1-Speed-Keyboard-Escape-or-Candy-and-Chocolate-Keyboard-escape-(auto-farmFinish-instantand-another)-227317"))()
    end,
})

tab:CreateButton({
    name = "Rivals OP MayBeeHub",
    callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/RIVALS-RivalHub-(Jnkie-keysystem)-226870"))()
    end,
})

local tab = window:CreateTab({ name = "troll", icon = 93364949241311 })

tab:CreateButton({
    name = "Touch Fling",
    callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Y3PZaLp7"))()
    end,
})

tab:CreateButton({
    name = "Dropkick",
    callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/universal/DropKick.lua"))()
    end,
})

local window = Rayfield:CreateWindow({
    name = "MayBeeHub",
    configuration = {
        autoSave = true,      -- save on change
        autoLoad = true,      -- load on first open
        fileName = "MayBeeHub Config",
        customFolder = "ScriptHub", -- optional
    },
})

local tab = window:CreateTab({ name = "Useful", icon = 93364949241311 })

tab:CreateSlider({
    name = "Field of view",
    range = { 70, 120 },
    increment = 1,
    value = 90,
    suffix = "°",
    callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
    end,
})

tab:CreateColorPicker({
    name = "Highlight",
    color = Color3.fromRGB(96, 205, 255),
    callback = function(color, alpha)
        print(color, alpha)
    end,
})