local URLS = {
    Logger = "https://raw.githubusercontent.com/winCloudDev/MayBeeHub-/refs/heads/main/MayBeeHub_Webhook_Logger.lua",
    Hub = "https://raw.githubusercontent.com/winCloudDev/MayBeeHub-/refs/heads/main/MayBeeHub_scripthub.lua",
}

local loadFn = loadstring or load

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

local function fetch(url)
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

local function run(label, url)
    local ok, err = pcall(function()
        if not loadFn then
            error("This executor does not support loadstring.")
        end

        local source = fetch(url)
        if not source then
            error("Could not download " .. label .. ".")
        end

        local chunk, compileError = loadFn(source)
        if not chunk then
            error(compileError or (label .. " could not be compiled."))
        end

        chunk()
    end)

    if not ok then
        warn("[MayBeeHub] " .. label .. " failed: " .. tostring(err))
    end
end

run("Webhook Logger", URLS.Logger)
run("Script Hub", URLS.Hub)
