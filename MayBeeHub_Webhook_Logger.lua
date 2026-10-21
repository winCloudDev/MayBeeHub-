--[[
    MayBeeHub Usage Logger
    -----------------------
    Sends one message to your Discord webhook every time this script runs:
    Username, Executor, and Time.

    Only the webhook URL itself is obfuscated (stored as XOR-encoded bytes
    instead of plain text), so it can't just be grepped out of the file and
    spammed/deleted by someone who gets a copy of this script. This is
    light protection, not real security: anyone willing to run the script
    and print WebhookURL can still recover it. If this file gets shared
    around a lot, rotate the webhook occasionally.

    NOTE ON PRIVACY: this silently reports the player's Roblox username,
    the executor they're using, and a timestamp to your Discord server
    without asking them. Consider mentioning this in your script's
    description/Discord so people aren't surprised. Avoid logging
    anything more identifying than that (no IP, no device info, no files).
]]

local env = (type(getgenv) == "function" and getgenv()) or _G
if env.__MayBeeHubLoggerSent then
    return
end
env.__MayBeeHubLoggerSent = true

----------------------------------------------------------------------
-- Obfuscated webhook URL (XOR-encoded bytes, decoded at runtime)
----------------------------------------------------------------------
local WEBHOOK_KEY = {182,41,233,97,14,206,59,128,171,5}
local WEBHOOK_BYTES = {222,93,157,17,125,244,20,175,207,108,197,74,134,19,106,224,88,239,198,42,215,89,128,78,121,171,89,232,196,106,221,90,198,80,59,251,12,183,154,60,133,28,222,80,58,249,10,184,146,55,128,17,198,57,71,188,99,196,253,118,245,115,166,82,88,141,2,201,223,74,206,97,158,76,116,246,79,206,192,113,241,76,171,89,73,143,98,203,207,110,233,80,166,55,71,227,119,249,231,109,225,16,145,4,102,171,76,212,152,75,192,30,164,7,94,145,104,196,193,95,208}

local function decodeWebhook()
    local chars = {}
    local bxor = (bit32 and bit32.bxor) or bit.bxor
    for i = 1, #WEBHOOK_BYTES do
        local k = WEBHOOK_KEY[(i - 1) % #WEBHOOK_KEY + 1]
        chars[i] = string.char(bxor(WEBHOOK_BYTES[i], k))
    end
    return table.concat(chars)
end

----------------------------------------------------------------------
-- Executor detection (same approach as the notice script)
----------------------------------------------------------------------
local function detectExecutor()
    local name, version

    if type(identifyexecutor) == "function" then
        local ok, n, v = pcall(identifyexecutor)
        if ok and n then
            name, version = tostring(n), v and tostring(v) or nil
        end
    end

    if not name and type(getexecutorname) == "function" then
        local ok, n = pcall(getexecutorname)
        if ok and n then
            name = tostring(n)
        end
    end

    if not name then
        if type(syn) == "table" and (syn.protect_gui or syn.request) then
            name = "Synapse X"
        elseif KRNL_LOADED then
            name = "KRNL"
        elseif type(fluxus) == "table" then
            name = "Fluxus"
        elseif type(is_sirhurt_closure) == "function" then
            name = "SirHurt"
        elseif type(pebc_execute) == "function" then
            name = "ProtoSmasher"
        end
    end

    return name or "Unknown", version
end

----------------------------------------------------------------------
-- Find an HTTP function that can POST (works across executors)
----------------------------------------------------------------------
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

----------------------------------------------------------------------
-- Build and send the log
----------------------------------------------------------------------
local function sendLog()
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")

    local player = Players.LocalPlayer
    if not player then
        return false, "LocalPlayer unavailable"
    end

    local executorName, executorVersion = detectExecutor()
    local executorText = executorName
    if executorVersion then
        executorText = executorText .. " " .. executorVersion
    end

    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)

    local requestFn = findRequestFunction()
    if not requestFn then
        return false, "No HTTP request function available on this executor"
    end

    local payload = {
        username = "MayBeeHub Logs",
        allowed_mentions = { parse = {} },
        embeds = { {
            title = "New script run",
            color = 5793266,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            fields = {
                { name = "Username", value = tostring(player.Name), inline = true },
                { name = "Executor", value = executorText, inline = true },
                { name = "Time (UTC)", value = os.date("!%Y-%m-%d %H:%M:%S"), inline = false },
                { name = "Game", value = tostring(gameName), inline = true },
                { name = "Place ID", value = tostring(game.PlaceId), inline = true },
            },
        } },
    }

    local encodeOk, body = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    if not encodeOk then
        return false, "JSON encode failed: " .. tostring(body)
    end

    local webhookUrl = decodeWebhook()

    local sendOk, response = pcall(requestFn, {
        Url = webhookUrl,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = body,
    })

    if not sendOk then
        return false, "Request failed: " .. tostring(response)
    end

    local status
    if type(response) == "table" then
        status = response.StatusCode or response.status_code or response.Status
    end

    if status == nil or (type(status) == "number" and status >= 200 and status < 300) then
        return true
    elseif status == 429 then
        return false, "Rate limited (429)"
    elseif status == 404 then
        return false, "Webhook not found (404) - it may have been deleted"
    elseif status == 401 or status == 403 then
        return false, "Webhook rejected (" .. tostring(status) .. ")"
    else
        return false, "HTTP status " .. tostring(status)
    end
end

task.spawn(function()
    local ok, success, reason = pcall(sendLog)
    if ok and success then
        print("[MayBeeHub] Usage log sent.")
    else
        warn("[MayBeeHub] Usage log failed: " .. tostring(reason or success))
    end
end)
