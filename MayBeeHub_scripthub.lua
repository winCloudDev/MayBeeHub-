local printFn = print
local warnFn = warn or print
local loadFn = loadstring or load

local spawnFn = (type(task) == "table" and task.spawn) or function(fn, ...)
    local co = coroutine.create(fn)
    coroutine.resume(co, ...)
end

local function printLine(text)
    printFn("[MayBeeHub] " .. tostring(text))
end

local function encodeUrl(url)
    return (url:gsub("[%(%)%+]", function(char)
        return string.format("%%%02X", char:byte())
    end))
end

local function findRequestFunction()
    if type(request) == "function" then
        return request
    end
    if type(http_request) == "function" then
        return http_request
    end
    if type(syn) == "table" and type(syn.request) == "function" then
        return syn.request
    end
    if type(http) == "table" and type(http.request) == "function" then
        return http.request
    end
    if type(fluxus) == "table" and type(fluxus.request) == "function" then
        return fluxus.request
    end
    return nil
end

local function fetchOnce(url)
    local ok, body = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and type(body) == "string" and body ~= "" then
        return body
    end

    ok, body = pcall(function()
        return game:HttpGetAsync(url)
    end)
    if ok and type(body) == "string" and body ~= "" then
        return body
    end

    local requestFn = findRequestFunction()
    if requestFn then
        local reqOk, response = pcall(requestFn, { Url = url, Method = "GET" })
        if reqOk and type(response) == "table" then
            local status = response.StatusCode or response.status_code or response.Status
            local text = response.Body or response.body
            local success = status == nil or (type(status) == "number" and status >= 200 and status < 300)
            if success and type(text) == "string" and text ~= "" then
                return text
            end
        end
    end

    return nil
end

local function fetch(url)
    local body = fetchOnce(url)
    if body then
        return body
    end

    local encoded = encodeUrl(url)
    if encoded ~= url then
        body = fetchOnce(encoded)
        if body then
            return body
        end
    end

    error("Could not download: " .. url)
end

local env = _G
if type(getgenv) == "function" then
    local ok, result = pcall(getgenv)
    if ok and type(result) == "table" then
        env = result
    end
end
env.RAYFIELD_SECURE = true

if not loadFn then
    warnFn("[MayBeeHub] This executor does not support loadstring.")
    return
end

local libOk, Rayfield = pcall(function()
    local source = fetch("https://sirius.menu/gen2")
    local chunk, compileError = loadFn(source)
    if not chunk then
        error(compileError or "Unable to compile Rayfield.")
    end
    return chunk()
end)

if not libOk or not Rayfield then
    warnFn("[MayBeeHub] Failed to load Rayfield: " .. tostring(Rayfield))
    return
end

local windowOk, window = pcall(function()
    return Rayfield:CreateWindow({
        name = "MayBeeHub",
        subtitle = "Enjoy MayBeeHub",
        sidebarLayout = true,
        theme = "cobalt",
        configuration = {
            autoSave = true,
            autoLoad = true,
            fileName = "MayBeeHub Config",
            customFolder = "ScriptHub",
        },
    })
end)

if not windowOk or not window then
    warnFn("[MayBeeHub] Failed to create window: " .. tostring(window))
    return
end

local homeTab = window:CreateTab({ name = "Home", icon = 93364949241311 })
local trollTab = window:CreateTab({ name = "Troll", icon = 93364949241311 })
local usefulTab = window:CreateTab({ name = "Useful", icon = 93364949241311 })

local console
do
    local ok, result = pcall(function()
        return homeTab:CreateConsole({
            name = "Console",
            height = 130,
            follow = true,
            maxLines = 200,
        })
    end)
    if ok then
        console = result
    end
end

local function log(text)
    printLine(text)
    if console then
        pcall(function()
            console:Append(text)
        end)
    end
end

local function notify(title, content)
    pcall(function()
        window:Notify({
            title = title,
            content = content,
            duration = 5,
        })
    end)
end

log("Opening MayBeeHub")

local function runRemote(label, url)
    log("Loading " .. label .. "...")

    local ok, err = pcall(function()
        local source = fetch(url)
        local chunk, compileError = loadFn(source)

        if not chunk then
            error(compileError or "Script could not be compiled.")
        end

        chunk()
    end)

    if ok then
        log(label .. " loaded.")
    else
        local message = tostring(err):sub(1, 120)
        log("ERROR " .. label .. ": " .. message)
        notify("Failed to load " .. label, message)
    end
end

local function addScriptButton(tab, label, url)
    tab:CreateButton({
        name = label,
        callback = function()
            spawnFn(runRemote, label, url)
        end,
    })
end

addScriptButton(homeTab, "Huss Valley",
    "https://scriptblox.com/raw/Huss-Valley-MayBeeHub-232549")

addScriptButton(homeTab, "MayBeeHub TSB",
    "https://scriptblox.com/raw/The-Strongest-Battlegrounds-MayBeeHub-TSB-(FixedUnpatchedUpgrade)-229100")

addScriptButton(homeTab, "MayBeeHub TSB 2",
    "https://scriptblox.com/raw/The-Strongest-Battlegrounds-TSB-OpHub-224220")

addScriptButton(homeTab, "Rivals MayBeeHub",
    "https://scriptblox.com/raw/RIVALS-MayBeeHub-229831")

addScriptButton(homeTab, "Jujutsu Shenanigans",
    "https://scriptblox.com/raw/SKY-ASSASSIN-Jujutsu-Shenanigans-(OP)-227910")

addScriptButton(homeTab, "Animal Hospital",
    "https://scriptblox.com/raw/2nd-FLOOR-Animal-Hospital-(Anomaly)-Animal-hospital-(auto-farm-Infinte-Sanity-and-more-70+)-227579")

addScriptButton(homeTab, "Keyboard Escape",
    "https://scriptblox.com/raw/X7-+1-Speed-Keyboard-Escape-or-Candy-and-Chocolate-Keyboard-escape-(auto-farmFinish-instantand-another)-227317")

addScriptButton(homeTab, "Rivals OP MayBeeHub",
    "https://scriptblox.com/raw/RIVALS-RivalHub-(Jnkie-keysystem)-226870")

addScriptButton(trollTab, "Touch Fling",
    "https://pastebin.com/raw/Y3PZaLp7")

addScriptButton(trollTab, "Dropkick",
    "https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/universal/DropKick.lua")

usefulTab:CreateSlider({
    name = "Field of view",
    range = { 70, 120 },
    increment = 1,
    value = 90,
    suffix = "\194\176",
    callback = function(value)
        local camera = workspace.CurrentCamera
        if camera then
            camera.FieldOfView = value
        end
    end,
})

usefulTab:CreateColorPicker({
    name = "Highlight",
    color = Color3.fromRGB(96, 205, 255),
    callback = function(color, alpha)
        printFn(color, alpha)
    end,
})
