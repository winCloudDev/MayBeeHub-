local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local gameName = "Forsaken"

pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)
    if info and info.Name then
        gameName = info.Name
    end
end)
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles
Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true
local Window = Library:CreateWindow({
    Title = "Fixsaken",
    Footer = LP.Name .. " | " .. gameName,
    NotifySide = "Right",
    ShowCustomCursor = true,
    Icon = "rbxassetid://111271260721038"
})
local Tabs = {
    ["Player Info"] = Window:AddTab("Player Info", "user"),
    ["ESP"] = Window:AddTab("ESP", "eye"),
    ["Generator"] = Window:AddTab("Generator", "zap"),
    ["Player"] = Window:AddTab("Player", "user"),
    ["Aimbot"] = Window:AddTab("Aimbot", "crosshair"),
    ["Block"] = Window:AddTab("Block", "shield"),
    ["Stab"] = Window:AddTab("Stab", "sword"),
    ["Sk8"] = Window:AddTab("Sk8", "zap"),
    ["Action"] = Window:AddTab("Action", "smile"),
    ["Music"]  = Window:AddTab("Music", "music"),
    ["Misc"] = Window:AddTab("Misc", "paperclip"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}
local information = Tabs["Player Info"]:AddLeftGroupbox("Player", "user")
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarThumbnail"
avatarImage.Size = UDim2.new(0, 220, 0, 220)
avatarImage.Position = UDim2.new(0.5, -90, 0, 10)
avatarImage.Image = "rbxassetid://0"
avatarImage.BackgroundTransparency = 1
avatarImage.BorderSizePixel = 0
avatarImage.ScaleType = Enum.ScaleType.Fit
if information.Container then
    avatarImage.Parent = information.Container
elseif information.Frame then
    avatarImage.Parent = information.Frame
else
    avatarImage.Parent = information
end
spawn(function()
    local player = LP
    if not player then repeat task.wait(0.1) player = Players.LocalPlayer until player end
    task.wait(1)
    local success, thumbnail = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
    end)
    if success and thumbnail then
        avatarImage.Image = thumbnail
    else
        local alternatives = {Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailType.Avatar}
        for i, thumbnailType in ipairs(alternatives) do
            local altSuccess, altThumbnail = pcall(function()
                return Players:GetUserThumbnailAsync(player.UserId, thumbnailType, Enum.ThumbnailSize.Size180x180)
            end)
            if altSuccess and altThumbnail then avatarImage.Image = altThumbnail break end
        end
    end
end)
local executorName = "Unknown"

pcall(function()
    if type(identifyexecutor) == "function" then
        executorName = identifyexecutor()
    end
end)

information:AddLabel("Executor : " .. tostring(executorName))
information:AddLabel("Username : " .. game.Players.LocalPlayer.Name)
information:AddLabel("User ID : " .. game.Players.LocalPlayer.UserId)
information:AddLabel("Display Name : " .. game.Players.LocalPlayer.DisplayName)
information:AddLabel("Account Age : " .. game.Players.LocalPlayer.AccountAge .. " days")
local InfoGroup = Tabs["Player Info"]:AddRightGroupbox("Info", "info")
local welcomeLabel = InfoGroup:AddLabel({Text = "Welcome to Fixsaken", DoesWrap = true})
task.spawn(function()
    while true do
        task.wait(0.1)
        local accentColor = ThemeManager.ThemeData.AccentColor or Color3.fromRGB(137, 180, 250)
        local fullText = 'Welcome to <font color="#' .. string.format("%02x%02x%02x",
            math.floor(accentColor.R * 255), math.floor(accentColor.G * 255), math.floor(accentColor.B * 255)) .. '">Fixsaken</font>'
        welcomeLabel:SetText(fullText)
        if Library.Unloaded then break end
    end
end)
local DevGroup = Tabs["Player Info"]:AddRightGroupbox("Developer", "user")
DevGroup:AddLabel("[Rafan (MayBeeHub] - Owner And Developer")
local CommunityGroup = Tabs["Player Info"]:AddRightGroupbox("Community", "users")
CommunityGroup:AddButton("Copy Discord Link", function()
    pcall(function()
        setclipboard("https://discord.gg/wRDS86bW5")
        Library:Notify({Title = "Discord", Description = "Link copied to clipboard", Time = 2})
    end)
end)
CommunityGroup:AddButton("QQ", function()
    pcall(function()
        setclipboard("1058111379")
        Library:Notify({Title = "QQ", Description = "QQ number copied to clipboard", Time = 2})
    end)
end)

local EspLib = {}
local Camera = Workspace.CurrentCamera

if not Camera then
    Workspace:GetPropertyChangedSignal("CurrentCamera"):Wait()
    Camera = Workspace.CurrentCamera
end
local MapFolder = nil

local function UpdateMapFolder()
    local mapObj = Workspace:FindFirstChild("Map")
    MapFolder = mapObj and mapObj:FindFirstChild("Ingame") or nil
end

UpdateMapFolder()

Workspace.ChildAdded:Connect(function(child)
    if child.Name == "Map" then
        task.wait()
        UpdateMapFolder()
    end
end)
local DummyNames = {
    "PizzaDeliveryRig", "Mafiaso1", "Mafiaso2", "Builderman", "Elliot",
    "ShedletskyCORRUPT", "ChancecORRUPT", "ChanceCORRUPT", "Mafia1", "Mafia2",
    "Mafia3", "Mafia4", "Mafia5", "Mafia6", "Mafia7", "Mafia8", "Mafia9",
    "GreenGuy", "RedGuy", "BlueGuy", "PurpleGuy", "PinkGuy", "YellowGuy",
    "OrangeGuy", "GreyGuy"
}
local ObjectESPData = {}
local PlayerESPData = {}
local ESPSettings = {
    generatorESP = false, itemESP = false, pizzaEsp = false, pizzaDeliveryEsp = false,
    zombieEsp = false, taphTripwireEsp = false, tripMineEsp = false, twoTimeRespawnEsp = false,
    graffitiEsp = false,
    generatorColor = Color3.fromRGB(200, 100, 200), itemColor = Color3.fromRGB(200, 200, 0),
    pizzaColor = Color3.fromRGB(200, 150, 0), pizzaDeliveryColor = Color3.fromRGB(200, 100, 100),
    zombieColor = Color3.fromRGB(200, 100, 100), taphTripwireColor = Color3.fromRGB(100, 0, 100),
    tripMineColor = Color3.fromRGB(255, 0, 255), twoTimeRespawnColor = Color3.fromRGB(0, 150, 200),
    graffitiColor = Color3.fromRGB(255, 255, 255),
    limitDistance = false, maxDistance = 150,
    killerESP = false, playerESP = false, killerNameESP = true, survivorNameESP = true,
    killerHealthESP = true, survivorHealthESP = true, killerSkinESP = false, survivorSkinESP = false,
    killerColor = Color3.fromRGB(255, 100, 100), survivorColor = Color3.fromRGB(100, 255, 100),
    killerFillTransparency = 0.7, killerOutlineTransparency = 0.3,
    survivorFillTransparency = 0.7, survivorOutlineTransparency = 0.3,
    generatorTracers = false, itemTracers = false, pizzaTracers = false, pizzaDeliveryTracers = false,
    zombieTracers = false, taphTripwireTracers = false, tripMineTracers = false, twoTimeRespawnTracers = false,
    killerTracers = false, survivorTracers = false,
    showGeneratorName = true, showItemName = true, showPizzaName = true, showPizzaDeliveryName = true,
    showZombieName = true, showTaphTripwireName = true, showTripMineName = true, showTwoTimeRespawnName = true,
    showGraffitiName = true,
    azureGroundBulbESP = false,
    azureVineESP = false,
    azureGroundBulbColor = Color3.fromRGB(0, 255, 200),
    azureVineColor = Color3.fromRGB(200, 0, 255),
}
local function IsRagdoll(model)
    local ragdolls = Workspace:FindFirstChild("Ragdolls")
    return ragdolls and (model:IsDescendantOf(ragdolls) or model.Parent == ragdolls)
end
local function IsSpectating(player)
    if not player then return false end
    local pf = Workspace:FindFirstChild("Players")
    if not pf then return false end
    local sp = pf:FindFirstChild("Spectating")
    return sp and sp:FindFirstChild(player.Name) ~= nil
end
local function GetGeneratorPart(model)
    if not model then return nil end
    local instances = model:FindFirstChild("Instances")
    if instances then
        local generator = instances:FindFirstChild("Generator")
        if generator then
            local cube = generator:FindFirstChild("Cube.003")
            if cube and cube:IsA("BasePart") then return cube end
            for _, v in ipairs(generator:GetDescendants()) do if v:IsA("BasePart") then return v end end
        end
        for _, v in ipairs(instances:GetDescendants()) do if v:IsA("BasePart") and tostring(v.Name):lower():find("cube") then return v end end
    end
    for _, v in ipairs(model:GetDescendants()) do if v:IsA("BasePart") and v.Name:lower():find("cube") then return v end end
    for _, v in ipairs(model:GetDescendants()) do if v:IsA("BasePart") then return v end end
    return nil
end
local function createPlayerESP(model, color, isKiller)
    if model:FindFirstChild("Fixsaken_Highlight") then return end
    if IsRagdoll(model) then return end
    local hrp = model:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "Fixsaken_Highlight"
    highlight.Adornee = model
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = isKiller and ESPSettings.killerFillTransparency or ESPSettings.survivorFillTransparency
    highlight.OutlineTransparency = isKiller and ESPSettings.killerOutlineTransparency or ESPSettings.survivorOutlineTransparency
    highlight.Parent = model
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "Fixsaken_Billboard"
    billboard.Adornee = hrp
    billboard.Size = UDim2.new(0, 120, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = model
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Loading..."
    nameLabel.Font = Enum.Font.Jura
    nameLabel.TextColor3 = color
    nameLabel.TextSize = 8
    nameLabel.TextStrokeTransparency = 0.6
    nameLabel.Parent = billboard
    local hpLabel = Instance.new("TextLabel")
    hpLabel.Size = UDim2.new(1, 0, 0.4, 0)
    hpLabel.Position = UDim2.new(0, 0, 0.4, 0)
    hpLabel.BackgroundTransparency = 1
    hpLabel.Text = "HP: N/A"
    hpLabel.Font = Enum.Font.Jura
    hpLabel.TextColor3 = color
    hpLabel.TextSize = 8
    hpLabel.TextStrokeTransparency = 0.6
    hpLabel.Parent = billboard
    local data = { model = model, nameLabel = nameLabel, hpLabel = hpLabel, isKiller = isKiller }
    table.insert(PlayerESPData, data)
    local function updateText()
        if not data.model or not data.model.Parent then return end
        local m = data.model
        local isK = data.isKiller
        local displayName = m:GetAttribute("ActorDisplayName") or (isK and "KILLER" or "SURVIVOR")
        local skinName = m:GetAttribute("SkinNameDisplay")
        local text = displayName
        if (isK and ESPSettings.killerSkinESP) or (not isK and ESPSettings.survivorSkinESP) then
            if skinName and skinName ~= "" then text = text .. " | " .. skinName end
        end
        nameLabel.Text = text
        local humanoid = m:FindFirstChild("Humanoid")
        if humanoid then
            hpLabel.Text = string.format("HP: %d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
        end
        if highlight and highlight.Parent then
            if isK then
                highlight.FillTransparency = ESPSettings.killerFillTransparency
                highlight.OutlineTransparency = ESPSettings.killerOutlineTransparency
            else
                highlight.FillTransparency = ESPSettings.survivorFillTransparency
                highlight.OutlineTransparency = ESPSettings.survivorOutlineTransparency
            end
        end
    end
    updateText()
    model:GetAttributeChangedSignal("ActorDisplayName"):Connect(updateText)
    model:GetAttributeChangedSignal("SkinNameDisplay"):Connect(updateText)
    local humanoid = model:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:GetPropertyChangedSignal("Health"):Connect(updateText)
        humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateText)
    end
end
local function removePlayerESP(model)
    for i = #PlayerESPData, 1, -1 do if PlayerESPData[i].model == model then table.remove(PlayerESPData, i) end end
    pcall(function()
        if model:FindFirstChild("Fixsaken_Highlight") then model.Fixsaken_Highlight:Destroy() end
        if model:FindFirstChild("Fixsaken_Billboard") then model.Fixsaken_Billboard:Destroy() end
    end)
end
local function CreateObjectESP(model, color, isGenerator, isItem, isPizza, isPizzaDelivery, isZombie, isTaph, isTripMine, isRespawn, isGraffiti, displayText)
    if not model then return end
    if model:FindFirstChild("TAOWARE_Highlight") then return end
    if isGenerator and model:FindFirstChild("Progress") and model.Progress.Value == 100 then return end
    if IsRagdoll(model) then return end
    if ESPSettings.limitDistance then
        local rootPart = model:IsA("BasePart") and model or model:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local distance = (Camera.CFrame.Position - rootPart.Position).Magnitude
            if distance > ESPSettings.maxDistance then return end
        end
    end
    local targetPart
    if isGenerator then targetPart = GetGeneratorPart(model)
    elseif isItem then targetPart = model:FindFirstChild("ItemRoot")
    elseif isPizza then targetPart = model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart", true)
    elseif isPizzaDelivery then targetPart = model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart", true)
    elseif isZombie then targetPart = model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart", true)
    elseif isTaph then targetPart = model:IsA("Model") and (GetGeneratorPart(model) or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)) or model
    elseif isTripMine then targetPart = model:IsA("Model") and (GetGeneratorPart(model) or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)) or model
    elseif isRespawn then targetPart = model:IsA("Model") and (GetGeneratorPart(model) or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)) or model
    elseif isGraffiti then targetPart = model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart", true)
    else return end
    if not targetPart then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "TAOWARE_Highlight"
    highlight.Adornee = model
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0.3
    highlight.Parent = model
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "TAOWARE_Billboard"
    billboard.Adornee = targetPart
    billboard.Size = UDim2.new(0, 120, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = model
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    if displayText then
        textLabel.Text = displayText
    else
        local typeAttr = model:GetAttribute("Type")
        if typeAttr then
            textLabel.Text = typeAttr
        else
            textLabel.Text = model.Name
        end
    end
    textLabel.Font = Enum.Font.Jura
    textLabel.TextColor3 = color
    textLabel.TextSize = 8
    textLabel.TextStrokeTransparency = 0.6
    textLabel.Parent = billboard
    local espData = {model = model, highlight = highlight, billboard = billboard}
    table.insert(ObjectESPData, espData)
end
local function RemoveObjectESP(model)
    if not model then return end
    for i = #ObjectESPData, 1, -1 do if ObjectESPData[i].model == model then table.remove(ObjectESPData, i) end end
    pcall(function()
        if model:FindFirstChild("TAOWARE_Highlight") then model.TAOWARE_Highlight:Destroy() end
        if model:FindFirstChild("TAOWARE_Billboard") then model.TAOWARE_Billboard:Destroy() end
    end)
end
local function UpdateESP()
    local pf = Workspace:FindFirstChild("Players")
    if pf then
        local killersFolder = pf:FindFirstChild("Killers")
        local survivorsFolder = pf:FindFirstChild("Survivors")
        if killersFolder then
            for _, killer in ipairs(killersFolder:GetChildren()) do
                if killer == LP.Character then continue end
                if IsRagdoll(killer) then removePlayerESP(killer); continue end
                local player = Players:GetPlayerFromCharacter(killer)
                if not player or IsSpectating(player) then removePlayerESP(killer); continue end
                if ESPSettings.killerESP then
                    if not killer:FindFirstChild("Fixsaken_Highlight") then createPlayerESP(killer, ESPSettings.killerColor, true) end
                else removePlayerESP(killer) end
            end
        end
        if survivorsFolder then
            for _, survivor in ipairs(survivorsFolder:GetChildren()) do
                if survivor == LP.Character then continue end
                if IsRagdoll(survivor) then removePlayerESP(survivor); continue end
                local player = Players:GetPlayerFromCharacter(survivor)
                if not player or IsSpectating(player) then removePlayerESP(survivor); continue end
                if ESPSettings.playerESP then
                    if not survivor:FindFirstChild("Fixsaken_Highlight") then createPlayerESP(survivor, ESPSettings.survivorColor, false) end
                else removePlayerESP(survivor) end
            end
        end
    end
    if not MapFolder then return end
    local ingame = MapFolder
    if ingame:FindFirstChild("Map") then
        for _, gen in ipairs(ingame.Map:GetChildren()) do
            if gen:IsA("Model") and gen.Name:lower():find("generator") and gen.Name ~= "FakeGenerator" then
                if IsRagdoll(gen) then RemoveObjectESP(gen); continue end
                local progress = gen:FindFirstChild("Progress")
                if ESPSettings.generatorESP and progress and progress.Value < 100 and not gen:FindFirstChild("TAOWARE_Highlight") then
                    CreateObjectESP(gen, ESPSettings.generatorColor, true)
                elseif not ESPSettings.generatorESP or (progress and progress.Value >= 100) then RemoveObjectESP(gen) end
            end
        end
        for _, item in ipairs(ingame.Map:GetDescendants()) do
            if item.Name == "ItemRoot" and item.Parent and item.Parent:IsA("Model") then
                local itemModel = item.Parent
                if ESPSettings.itemESP and not itemModel:FindFirstChild("TAOWARE_Highlight") then
                    CreateObjectESP(itemModel, ESPSettings.itemColor, false, true)
                elseif not ESPSettings.itemESP then RemoveObjectESP(itemModel) end
            end
        end
    end
    for _, pizza in ipairs(ingame:GetChildren()) do
        if pizza.Name == "Pizza" and pizza:IsA("BasePart") then
            if ESPSettings.pizzaEsp and not pizza:FindFirstChild("TAOWARE_Highlight") then
                CreateObjectESP(pizza, ESPSettings.pizzaColor, false, false, true)
            elseif not ESPSettings.pizzaEsp then RemoveObjectESP(pizza) end
        end
    end
    for _, delivery in ipairs(ingame:GetChildren()) do
        if delivery:IsA("Model") and table.find(DummyNames, delivery.Name) then
            for _, delivery in ipairs(ingame:GetChildren()) do
    if delivery:IsA("Model") and table.find(DummyNames, delivery.Name) then
        if ESPSettings.pizzaDeliveryEsp
            and not delivery:FindFirstChild("TAOWARE_Highlight") then

            CreateObjectESP(
                delivery,
                ESPSettings.pizzaDeliveryColor,
                false,
                false,
                false,
                true
            )

        elseif not ESPSettings.pizzaDeliveryEsp then
            RemoveObjectESP(pizza)
        end
    end
end