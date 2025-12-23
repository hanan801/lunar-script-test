setfenv(1, _G)

local function executeMAIN()
    if not getgenv().__LUNAR_START_TIME then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/SvtShqv5a")
    end
    return
end

if not getgenv().__LUNAR_VERIFY_CODE then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/SvtShqv5a")
    end
    return
end

if os.time() - getgenv().__LUNAR_START_TIME > 15 then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/SvtShqv5a")
    end
    return
end

local verify_code = getgenv().__LUNAR_VERIFY_CODE
if type(verify_code) ~= "string" then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/SvtShqv5a")
    end
    return
end

if not verify_code:find("LUNAR_") then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/SvtShqv5a")
    end
    return
end

if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local TextService = game:GetService("TextService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local m = {}
local n = nil;
local o = false;
local p = false;
local q = false;
local r = false;
local s = false;
local t = false;
local u = false;
local v = false;
local walkSpeed = 16;
local jumpPower = 50;
local isMaximized = false;
local z = nil;
local A = nil;
local B = nil;
local C = false;
local D = nil;
local E = false;
local F = {}
local G = nil;
local H = false;
local I = {Main=0,Info=0,Settings=0,Executor=0,Skybox=0,Backdoor=0,Visual=0}
local rgbLineMode = true;
local isDeleteToolEnabled = false
local isBuilderToolEnabled = false
local godModeEnabled = false

-- Delete Tool Variables
local deleteModeActive = false
local selectedPart = nil
local selectionBox = nil
local highlight = nil
local deleteGUI = nil
local undoRedoGUI = nil
local deletedParts = {}
local mouseConnection = nil

-- Builder Tool Variables
local builderModeActive = false
local builderMainGUI = nil
local builderScrollFrame = nil
local selectedBuilderPartType = 1
local placedParts = {}
local currentHistoryIndex = 0
local builderMouseConnection = nil

-- Multi Teleport System
local MultiTeleport = {
    Coordinates = {},
    History = {},
    RedoHistory = {},
    Markers = {},
    MaxCoordinates = 100,
    TeleportSpeed = 1, -- Default speed untuk Multi Teleport
    Delay = 1.0 -- Default delay 1 detik
}

-- AFK Anti-Kick System
local AFKSystem = {
    Enabled = false,
    AutoJumpEnabled = false,
    AutoJumpInterval = 5, -- Default 5 menit
    LastActionTime = tick()
}

-- AI Chat System Configuration (100% KODE ASLI ANDA)
local AIChat = {
    API_KEY = "AIzaSyD2mI5OGcXgpB-cRiORzdOfNKIJOFkWuPw",
    IsReady = false,
    IsConnected = false,
    Model = "gemini-2.5-flash",
    SystemInstruction = "You are LunarScript AI chat bot created by h4000_audio8 and DarkLua_script. Respond in English only. Be helpful, friendly, and informative about LunarScript features.",
    ChatHistory = {},
    LastResponse = ""
}

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title="Lunar Script v3",
    Text="LunarScript v3\nCreated by h4000_audio8",
    Icon="rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
    Duration=5
})

local J = Instance.new("ScreenGui")
J.Name = "LunarScript"
J.ResetOnSpawn = false;

local K = Instance.new("ScreenGui")
K.Name = "CoordsGui"
K.ResetOnSpawn = false;

local L = Instance.new("TextLabel")
L.Size = UDim2.new(0,200,0,40)
L.Position = UDim2.new(0,10,0,10)
L.BackgroundColor3 = Color3.fromRGB(0,0,0)
L.BackgroundTransparency = 0.5;
L.Text = "X: 0, Y: 0, Z: 0"
L.TextColor3 = Color3.fromRGB(255,255,255)
L.Font = Enum.Font.Gotham;
L.TextSize = 14;
L.Visible = false;
L.Parent = K;
Instance.new("UICorner",L).CornerRadius = UDim.new(0,6)

local M = {
    dark={backgroundColor=Color3.fromRGB(30,30,40),topBarColor=Color3.fromRGB(20,20,30),buttonColor=Color3.fromRGB(45,45,60),textColor=Color3.fromRGB(255,255,255)},
    ocean={backgroundColor=Color3.fromRGB(0,120,190),topBarColor=Color3.fromRGB(0,90,150),buttonColor=Color3.fromRGB(0,140,210),textColor=Color3.fromRGB(255,255,255)},
    night={backgroundColor=Color3.fromRGB(15,15,25),topBarColor=Color3.fromRGB(10,10,20),buttonColor=Color3.fromRGB(40,40,60),textColor=Color3.fromRGB(255,255,255)}
}

local N = "night"

local function ShowNotification(Title,Text)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title=Title,
        Text=Text,
        Icon="rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
        Duration=2
    })
end;

local function CopyToClipboard(Text)
    local ClipboardFunction = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set);
    if ClipboardFunction then 
        ClipboardFunction(Text)
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title="Copied!",
            Text="Text copied to clipboard!",
            Icon="rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
            Duration=2
        })
    else 
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title="Error",
            Text="Clipboard not available",
            Icon="rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
            Duration=2
        })
    end 
end;

local function CreateBlurEffect()
    if B then B:Destroy()end;
    B = Instance.new("BlurEffect")
    B.Parent = Lighting;
    B.Size = 0;
    B.Name = "LunarScriptBlur"
    return B 
end;

local function ApplyBlur()
    local V = CreateBlurEffect()
    local W = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    local X = TweenService:Create(V,W,{Size=24})
    X:Play()
end;

local function RemoveBlur()
    if B then 
        local W = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
        local X = TweenService:Create(B,W,{Size=0})
        X:Play()
        X.Completed:Connect(function()
            wait(0.5)
            if B then 
                B:Destroy()
                B=nil 
            end 
        end)
    end 
end;

local Z = Instance.new("Frame",J)
Z.Name = "MainFrame"
Z.Size = UDim2.new(0,500,0,350)
Z.Position = UDim2.new(0.5,-250,0.5,-175)
Z.BackgroundColor3 = M.night.backgroundColor;
Z.Active = true;
Z.Draggable = true;
Instance.new("UICorner",Z).CornerRadius = UDim.new(0,12)

local da = Instance.new("UIStroke",Z)
da.Thickness = 3;
local db = 0;
RunService.Heartbeat:Connect(function(dc)
    if rgbLineMode then 
        db=(db+dc*30)%360;
        da.Color = Color3.fromHSV(db/360,1,1)
    else 
        da.Color = M[N].topBarColor 
    end 
end)

local TopBar = Instance.new("Frame",Z)
TopBar.Size = UDim2.new(1,0,0,30)
TopBar.BackgroundColor3 = M.night.topBarColor;
Instance.new("UICorner",TopBar).CornerRadius = UDim.new(0,12)

local TitleContainer = Instance.new("Frame",TopBar)
TitleContainer.Size = UDim2.new(0,200,1,0)
TitleContainer.Position = UDim2.new(0,10,0,0)
TitleContainer.BackgroundTransparency = 1;

local Logo = Instance.new("ImageLabel",TitleContainer)
Logo.Size = UDim2.new(0,33,0,33)
Logo.Position = UDim2.new(0,0,0.5,-15.5)
Logo.BackgroundTransparency = 1;
Logo.Image = "rbxassetid://106770496050708"
Logo.ScaleType = Enum.ScaleType.Fit;

local TitleText = Instance.new("TextLabel",TitleContainer)
TitleText.Size = UDim2.new(0,150,1,0)
TitleText.Position = UDim2.new(0,40,0,0)
TitleText.BackgroundTransparency = 1;
TitleText.Text = "Lunar Script v3"
TitleText.TextColor3 = Color3.fromRGB(255,255,255)
TitleText.Font = Enum.Font.GothamBold;
TitleText.TextSize = 14;

local MaximizeButton = Instance.new("TextButton",TopBar)
MaximizeButton.Size = UDim2.new(0,30,0,30)
MaximizeButton.Position = UDim2.new(1,-90,0,0)
MaximizeButton.BackgroundTransparency = 1;
MaximizeButton.Text = "□"
MaximizeButton.TextColor3 = Color3.fromRGB(255,255,255)
MaximizeButton.Font = Enum.Font.GothamBold;
MaximizeButton.TextSize = 14;

local MinimizeButton = Instance.new("TextButton",TopBar)
MinimizeButton.Size = UDim2.new(0,30,0,30)
MinimizeButton.Position = UDim2.new(1,-60,0,0)
MinimizeButton.BackgroundTransparency = 1;
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255,255,255)
MinimizeButton.Font = Enum.Font.GothamBold;
MinimizeButton.TextSize = 16;

local CloseButton = Instance.new("TextButton",TopBar)
CloseButton.Size = UDim2.new(0,30,0,30)
CloseButton.Position = UDim2.new(1,-30,0,0)
CloseButton.BackgroundTransparency = 1;
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
CloseButton.Font = Enum.Font.GothamBold;
CloseButton.TextSize = 14;

local ContentArea = Instance.new("Frame",Z)
ContentArea.Size = UDim2.new(1,0,1,-30)
ContentArea.Position = UDim2.new(0,0,0,30)
ContentArea.BackgroundTransparency = 1;

-- Navigation Panel
local NavigationFrame = Instance.new("ScrollingFrame",ContentArea)
NavigationFrame.Size = UDim2.new(0.25,0,1,0)
NavigationFrame.BackgroundTransparency = 1;
NavigationFrame.ScrollBarThickness = 6;
NavigationFrame.CanvasSize = UDim2.new(0,0,0,350) -- Diperbesar untuk menampung AFK
NavigationFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
NavigationFrame.BorderSizePixel = 0;

local NavContainer = Instance.new("Frame",NavigationFrame)
NavContainer.Size = UDim2.new(1,0,0,350) -- Diperbesar untuk menampung AFK
NavContainer.BackgroundTransparency = 1;
NavContainer.Name = "NavContainer"

-- Navigation Buttons - MAIN, INFO, SETTINGS, TOOLS, MULTI TELEPORT, AI, AFK
local MainButton = Instance.new("TextButton",NavContainer)
MainButton.Size = UDim2.new(1,-10,0,35)
MainButton.Position = UDim2.new(0,5,0,5)
MainButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
MainButton.Text = "MAIN"
MainButton.TextColor3 = Color3.fromRGB(255,255,255)
MainButton.Font = Enum.Font.GothamBold;
MainButton.TextSize = 12;
Instance.new("UICorner",MainButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",MainButton).Color = M.night.topBarColor

local InfoButton = Instance.new("TextButton",NavContainer)
InfoButton.Size = UDim2.new(1,-10,0,35)
InfoButton.Position = UDim2.new(0,5,0,45)
InfoButton.BackgroundColor3 = M.night.buttonColor;
InfoButton.Text = "INFO"
InfoButton.TextColor3 = Color3.fromRGB(255,255,255)
InfoButton.Font = Enum.Font.GothamBold;
InfoButton.TextSize = 12;
Instance.new("UICorner",InfoButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",InfoButton).Color = M.night.topBarColor

local SettingsButton = Instance.new("TextButton",NavContainer)
SettingsButton.Size = UDim2.new(1,-10,0,35)
SettingsButton.Position = UDim2.new(0,5,0,85)
SettingsButton.BackgroundColor3 = M.night.buttonColor;
SettingsButton.Text = "SETTINGS"
SettingsButton.TextColor3 = Color3.fromRGB(255,255,255)
SettingsButton.Font = Enum.Font.GothamBold;
SettingsButton.TextSize = 12;
Instance.new("UICorner",SettingsButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",SettingsButton).Color = M.night.topBarColor

local ToolsButton = Instance.new("TextButton",NavContainer)
ToolsButton.Size = UDim2.new(1,-10,0,35)
ToolsButton.Position = UDim2.new(0,5,0,125)
ToolsButton.BackgroundColor3 = M.night.buttonColor;
ToolsButton.Text = "TOOLS"
ToolsButton.TextColor3 = Color3.fromRGB(255,255,255)
ToolsButton.Font = Enum.Font.GothamBold;
ToolsButton.TextSize = 12;
Instance.new("UICorner",ToolsButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",ToolsButton).Color = M.night.topBarColor

local MultiTeleportButton = Instance.new("TextButton",NavContainer)
MultiTeleportButton.Size = UDim2.new(1,-10,0,35)
MultiTeleportButton.Position = UDim2.new(0,5,0,165)
MultiTeleportButton.BackgroundColor3 = M.night.buttonColor;
MultiTeleportButton.Text = "MULTI TELEPORT"
MultiTeleportButton.TextColor3 = Color3.fromRGB(255,255,255)
MultiTeleportButton.Font = Enum.Font.GothamBold;
MultiTeleportButton.TextSize = 12;
Instance.new("UICorner",MultiTeleportButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",MultiTeleportButton).Color = M.night.topBarColor

local AIButton = Instance.new("TextButton",NavContainer)
AIButton.Size = UDim2.new(1,-10,0,35)
AIButton.Position = UDim2.new(0,5,0,205)
AIButton.BackgroundColor3 = M.night.buttonColor;
AIButton.Text = "AI CHAT BOT"
AIButton.TextColor3 = Color3.fromRGB(255,255,255)
AIButton.Font = Enum.Font.GothamBold;
AIButton.TextSize = 12;
Instance.new("UICorner",AIButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",AIButton).Color = M.night.topBarColor

-- TAMBAHAN: Tombol AFK
local AFKButton = Instance.new("TextButton",NavContainer)
AFKButton.Size = UDim2.new(1,-10,0,35)
AFKButton.Position = UDim2.new(0,5,0,245)
AFKButton.BackgroundColor3 = M.night.buttonColor;
AFKButton.Text = "AFK ANTI-KICK"
AFKButton.TextColor3 = Color3.fromRGB(255,255,255)
AFKButton.Font = Enum.Font.GothamBold;
AFKButton.TextSize = 12;
Instance.new("UICorner",AFKButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",AFKButton).Color = M.night.topBarColor

local ContentFrame = Instance.new("Frame",ContentArea)
ContentFrame.Size = UDim2.new(0.75,0,1,0)
ContentFrame.Position = UDim2.new(0.25,0,0,0)
ContentFrame.BackgroundTransparency = 1;

-- =================================================================
-- MAIN FRAME
-- =================================================================
local MainContentFrame = Instance.new("ScrollingFrame",ContentFrame)
MainContentFrame.Size = UDim2.new(1,0,1,0)
MainContentFrame.BackgroundTransparency = 1;
MainContentFrame.ScrollBarThickness = 8;
MainContentFrame.CanvasSize = UDim2.new(0,0,0,300)
MainContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
MainContentFrame.Visible = true;

local MainContent = Instance.new("Frame",MainContentFrame)
MainContent.Size = UDim2.new(1,0,0,300)
MainContent.BackgroundTransparency = 1;

local GodModeSection = Instance.new("Frame",MainContent)
GodModeSection.Size = UDim2.new(1,-10,0,150)
GodModeSection.Position = UDim2.new(0,5,0,5)
GodModeSection.BackgroundColor3 = Color3.fromRGB(40,40,50)
Instance.new("UICorner",GodModeSection).CornerRadius = UDim.new(0,8)

local GodModeTitle = Instance.new("TextLabel",GodModeSection)
GodModeTitle.Size = UDim2.new(1,0,0,30)
GodModeTitle.Position = UDim2.new(0,0,0,5)
GodModeTitle.BackgroundTransparency = 1;
GodModeTitle.Text = "VISUAL GOD MODE (FAKE GOD MODE)"
GodModeTitle.TextColor3 = Color3.fromRGB(255,255,255)
GodModeTitle.Font = Enum.Font.GothamBold;
GodModeTitle.TextSize = 14;
GodModeTitle.TextXAlignment = Enum.TextXAlignment.Center;

local GodModeDescription = Instance.new("TextLabel",GodModeSection)
GodModeDescription.Size = UDim2.new(1,-20,0,40)
GodModeDescription.Position = UDim2.new(0,10,0,35)
GodModeDescription.BackgroundTransparency = 1;
GodModeDescription.Text = "Only provides visual ForceField effect. Does not provide actual damage immunity."
GodModeDescription.TextColor3 = Color3.fromRGB(200,200,200)
GodModeDescription.Font = Enum.Font.Gotham;
GodModeDescription.TextSize = 11;
GodModeDescription.TextXAlignment = Enum.TextXAlignment.Left;
GodModeDescription.TextWrapped = true;

local GodModeToggleButton = Instance.new("TextButton",GodModeSection)
GodModeToggleButton.Size = UDim2.new(1,-20,0,40)
GodModeToggleButton.Position = UDim2.new(0,10,0,80)
GodModeToggleButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
GodModeToggleButton.Text = "GOD MODE: OFF"
GodModeToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
GodModeToggleButton.Font = Enum.Font.GothamBold;
GodModeToggleButton.TextSize = 14;
Instance.new("UICorner",GodModeToggleButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",GodModeToggleButton).Color = Color3.fromRGB(255,255,255)

local GodModeStatus = Instance.new("TextLabel",GodModeSection)
GodModeStatus.Size = UDim2.new(1,-20,0,20)
GodModeStatus.Position = UDim2.new(0,10,0,125)
GodModeStatus.BackgroundTransparency = 1;
GodModeStatus.Text = "Status: ForceField inactive"
GodModeStatus.TextColor3 = Color3.fromRGB(255,100,100)
GodModeStatus.Font = Enum.Font.Gotham;
GodModeStatus.TextSize = 12;
GodModeStatus.TextXAlignment = Enum.TextXAlignment.Left;

-- =================================================================
-- MULTI TELEPORT FRAME (DIMODIFIKASI DENGAN KECEPATAN DAN TOMBOL DELAY)
-- =================================================================
local MultiTeleportFrame = Instance.new("ScrollingFrame",ContentFrame)
MultiTeleportFrame.Size = UDim2.new(1,0,1,0)
MultiTeleportFrame.BackgroundTransparency = 1;
MultiTeleportFrame.ScrollBarThickness = 8;
MultiTeleportFrame.CanvasSize = UDim2.new(0,0,0,500) -- Diperbesar untuk kecepatan dan delay
MultiTeleportFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
MultiTeleportFrame.Visible = false;

local MultiTeleportContent = Instance.new("Frame",MultiTeleportFrame)
MultiTeleportContent.Size = UDim2.new(1,0,0,500)
MultiTeleportContent.BackgroundTransparency = 1;

local MultiTeleportSection = Instance.new("Frame",MultiTeleportContent)
MultiTeleportSection.Size = UDim2.new(1,-10,0,480)
MultiTeleportSection.Position = UDim2.new(0,5,0,5)
MultiTeleportSection.BackgroundColor3 = Color3.fromRGB(40,40,50)
Instance.new("UICorner",MultiTeleportSection).CornerRadius = UDim.new(0,8)

local MultiTeleportTitle = Instance.new("TextLabel",MultiTeleportSection)
MultiTeleportTitle.Size = UDim2.new(1,0,0,30)
MultiTeleportTitle.Position = UDim2.new(0,0,0,5)
MultiTeleportTitle.BackgroundTransparency = 1;
MultiTeleportTitle.Text = "MULTI TELEPORT SYSTEM"
MultiTeleportTitle.TextColor3 = Color3.fromRGB(255,255,255)
MultiTeleportTitle.Font = Enum.Font.GothamBold;
MultiTeleportTitle.TextSize = 14;
MultiTeleportTitle.TextXAlignment = Enum.TextXAlignment.Center;

-- TAMBAHAN: Bagian Kecepatan Teleport
local SpeedSection = Instance.new("Frame",MultiTeleportSection)
SpeedSection.Size = UDim2.new(1,-20,0,70)
SpeedSection.Position = UDim2.new(0,10,0,40)
SpeedSection.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner",SpeedSection).CornerRadius = UDim.new(0,6)

local SpeedTitle = Instance.new("TextLabel",SpeedSection)
SpeedTitle.Size = UDim2.new(1,0,0,25)
SpeedTitle.Position = UDim2.new(0,0,0,0)
SpeedTitle.BackgroundTransparency = 1;
SpeedTitle.Text = "TELEPORT SPEED"
SpeedTitle.TextColor3 = Color3.fromRGB(255,255,255)
SpeedTitle.Font = Enum.Font.GothamBold;
SpeedTitle.TextSize = 12;
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Center;

local SpeedLabel = Instance.new("TextLabel",SpeedSection)
SpeedLabel.Size = UDim2.new(0.3,0,0,25)
SpeedLabel.Position = UDim2.new(0,10,0,30)
SpeedLabel.BackgroundTransparency = 1;
SpeedLabel.Text = "Speed:"
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.Font = Enum.Font.Gotham;
SpeedLabel.TextSize = 12;
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left;

local SpeedTextBox = Instance.new("TextBox",SpeedSection)
SpeedTextBox.Size = UDim2.new(0.4,0,0,25)
SpeedTextBox.Position = UDim2.new(0.35,0,0,30)
SpeedTextBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
SpeedTextBox.TextColor3 = Color3.fromRGB(255,255,255)
SpeedTextBox.Font = Enum.Font.Gotham;
SpeedTextBox.TextSize = 12;
SpeedTextBox.PlaceholderText = "1-10"
SpeedTextBox.Text = "1"
Instance.new("UICorner",SpeedTextBox).CornerRadius = UDim.new(0,4)

local SpeedInfo = Instance.new("TextLabel",SpeedSection)
SpeedInfo.Size = UDim2.new(0.2,0,0,25)
SpeedInfo.Position = UDim2.new(0.8,0,0,30)
SpeedInfo.BackgroundTransparency = 1;
SpeedInfo.Text = "(1-10)"
SpeedInfo.TextColor3 = Color3.fromRGB(150,150,150)
SpeedInfo.Font = Enum.Font.Gotham;
SpeedInfo.TextSize = 10;
SpeedInfo.TextXAlignment = Enum.TextXAlignment.Left;

-- TAMBAHAN: Bagian Delay Settings dengan tombol "<" dan ">"
local DelaySection = Instance.new("Frame",MultiTeleportSection)
DelaySection.Size = UDim2.new(1,-20,0,90)
DelaySection.Position = UDim2.new(0,10,0,120)
DelaySection.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner",DelaySection).CornerRadius = UDim.new(0,6)

local DelayTitle = Instance.new("TextLabel",DelaySection)
DelayTitle.Size = UDim2.new(1,0,0,25)
DelayTitle.Position = UDim2.new(0,0,0,0)
DelayTitle.BackgroundTransparency = 1;
DelayTitle.Text = "TELEPORT DELAY (SECONDS)"
DelayTitle.TextColor3 = Color3.fromRGB(255,255,255)
DelayTitle.Font = Enum.Font.GothamBold;
DelayTitle.TextSize = 12;
DelayTitle.TextXAlignment = Enum.TextXAlignment.Center;

local DelayLabel = Instance.new("TextLabel",DelaySection)
DelayLabel.Size = UDim2.new(0.3,0,0,25)
DelayLabel.Position = UDim2.new(0,10,0,30)
DelayLabel.BackgroundTransparency = 1;
DelayLabel.Text = "Delay:"
DelayLabel.TextColor3 = Color3.fromRGB(255,255,255)
DelayLabel.Font = Enum.Font.Gotham;
DelayLabel.TextSize = 12;
DelayLabel.TextXAlignment = Enum.TextXAlignment.Left;

local DelayDecreaseButton = Instance.new("TextButton",DelaySection)
DelayDecreaseButton.Size = UDim2.new(0,30,0,25)
DelayDecreaseButton.Position = UDim2.new(0.35,0,0,30)
DelayDecreaseButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
DelayDecreaseButton.Text = "<"
DelayDecreaseButton.TextColor3 = Color3.fromRGB(255,255,255)
DelayDecreaseButton.Font = Enum.Font.GothamBold;
DelayDecreaseButton.TextSize = 14;
DelayDecreaseButton.Name = "DelayDecreaseButton"
Instance.new("UICorner",DelayDecreaseButton).CornerRadius = UDim.new(0,4)

local DelayTextBox = Instance.new("TextBox",DelaySection)
DelayTextBox.Size = UDim2.new(0.2,0,0,25)
DelayTextBox.Position = UDim2.new(0.43,0,0,30)
DelayTextBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
DelayTextBox.TextColor3 = Color3.fromRGB(255,255,255)
DelayTextBox.Font = Enum.Font.Gotham;
DelayTextBox.TextSize = 12;
DelayTextBox.PlaceholderText = "0.10-60"
DelayTextBox.Text = "1.00"
Instance.new("UICorner",DelayTextBox).CornerRadius = UDim.new(0,4)

local DelayIncreaseButton = Instance.new("TextButton",DelaySection)
DelayIncreaseButton.Size = UDim2.new(0,30,0,25)
DelayIncreaseButton.Position = UDim2.new(0.68,0,0,30)
DelayIncreaseButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
DelayIncreaseButton.Text = ">"
DelayIncreaseButton.TextColor3 = Color3.fromRGB(255,255,255)
DelayIncreaseButton.Font = Enum.Font.GothamBold;
DelayIncreaseButton.TextSize = 14;
DelayIncreaseButton.Name = "DelayIncreaseButton"
Instance.new("UICorner",DelayIncreaseButton).CornerRadius = UDim.new(0,4)

local DelayInfo = Instance.new("TextLabel",DelaySection)
DelayInfo.Size = UDim2.new(1,-20,0,20)
DelayInfo.Position = UDim2.new(0,10,0,60)
DelayInfo.BackgroundTransparency = 1;
DelayInfo.Text = "Adjust delay between teleports (0.10 to 60 seconds)"
DelayInfo.TextColor3 = Color3.fromRGB(150,150,150)
DelayInfo.Font = Enum.Font.Gotham;
DelayInfo.TextSize = 10;
DelayInfo.TextXAlignment = Enum.TextXAlignment.Center;

-- Bagian Koordinat Input (dipindahkan ke bawah)
local CoordInputSection = Instance.new("Frame",MultiTeleportSection)
CoordInputSection.Size = UDim2.new(1,-20,0,120)
CoordInputSection.Position = UDim2.new(0,10,0,220)
CoordInputSection.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner",CoordInputSection).CornerRadius = UDim.new(0,6)

local XLabel = Instance.new("TextLabel",CoordInputSection)
XLabel.Size = UDim2.new(0.3,0,0,25)
XLabel.Position = UDim2.new(0,5,0,5)
XLabel.BackgroundTransparency = 1;
XLabel.Text = "X Coordinate:"
XLabel.TextColor3 = Color3.fromRGB(255,255,255)
XLabel.Font = Enum.Font.Gotham;
XLabel.TextSize = 12;
XLabel.TextXAlignment = Enum.TextXAlignment.Left;

local XTextBox = Instance.new("TextBox",CoordInputSection)
XTextBox.Size = UDim2.new(0.6,0,0,25)
XTextBox.Position = UDim2.new(0.35,0,0,5)
XTextBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
XTextBox.TextColor3 = Color3.fromRGB(255,255,255)
XTextBox.Font = Enum.Font.Gotham;
XTextBox.TextSize = 12;
XTextBox.PlaceholderText = "Enter X coordinate"
XTextBox.Text = ""
Instance.new("UICorner",XTextBox).CornerRadius = UDim.new(0,4)

local YLabel = Instance.new("TextLabel",CoordInputSection)
YLabel.Size = UDim2.new(0.3,0,0,25)
YLabel.Position = UDim2.new(0,5,0,35)
YLabel.BackgroundTransparency = 1;
YLabel.Text = "Y Coordinate:"
YLabel.TextColor3 = Color3.fromRGB(255,255,255)
YLabel.Font = Enum.Font.Gotham;
YLabel.TextSize = 12;
YLabel.TextXAlignment = Enum.TextXAlignment.Left;

local YTextBox = Instance.new("TextBox",CoordInputSection)
YTextBox.Size = UDim2.new(0.6,0,0,25)
YTextBox.Position = UDim2.new(0.35,0,0,35)
YTextBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
YTextBox.TextColor3 = Color3.fromRGB(255,255,255)
YTextBox.Font = Enum.Font.Gotham;
YTextBox.TextSize = 12;
YTextBox.PlaceholderText = "Enter Y coordinate"
YTextBox.Text = ""
Instance.new("UICorner",YTextBox).CornerRadius = UDim.new(0,4)

local ZLabel = Instance.new("TextLabel",CoordInputSection)
ZLabel.Size = UDim2.new(0.3,0,0,25)
ZLabel.Position = UDim2.new(0,5,0,65)
ZLabel.BackgroundTransparency = 1;
ZLabel.Text = "Z Coordinate:"
ZLabel.TextColor3 = Color3.fromRGB(255,255,255)
ZLabel.Font = Enum.Font.Gotham;
ZLabel.TextSize = 12;
ZLabel.TextXAlignment = Enum.TextXAlignment.Left;

local ZTextBox = Instance.new("TextBox",CoordInputSection)
ZTextBox.Size = UDim2.new(0.6,0,0,25)
ZTextBox.Position = UDim2.new(0.35,0,0,65)
ZTextBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
ZTextBox.TextColor3 = Color3.fromRGB(255,255,255)
ZTextBox.Font = Enum.Font.Gotham;
ZTextBox.TextSize = 12;
ZTextBox.PlaceholderText = "Enter Z coordinate"
ZTextBox.Text = ""
Instance.new("UICorner",ZTextBox).CornerRadius = UDim.new(0,4)

local ButtonsSection = Instance.new("Frame",MultiTeleportSection)
ButtonsSection.Size = UDim2.new(1,-20,0,150)
ButtonsSection.Position = UDim2.new(0,10,0,350)
ButtonsSection.BackgroundTransparency = 1;

local SetCoordinateButton = Instance.new("TextButton",ButtonsSection)
SetCoordinateButton.Size = UDim2.new(1,0,0,35)
SetCoordinateButton.Position = UDim2.new(0,0,0,0)
SetCoordinateButton.BackgroundColor3 = Color3.fromRGB(0,150,255)
SetCoordinateButton.Text = "SET COORDINATE"
SetCoordinateButton.TextColor3 = Color3.fromRGB(255,255,255)
SetCoordinateButton.Font = Enum.Font.GothamBold;
SetCoordinateButton.TextSize = 14;
Instance.new("UICorner",SetCoordinateButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",SetCoordinateButton).Color = Color3.fromRGB(255,255,255)

local TeleportAllButton = Instance.new("TextButton",ButtonsSection)
TeleportAllButton.Size = UDim2.new(1,0,0,35)
TeleportAllButton.Position = UDim2.new(0,0,0,40)
TeleportAllButton.BackgroundColor3 = Color3.fromRGB(0,180,0)
TeleportAllButton.Text = "TELEPORT TO ALL COORDINATES"
TeleportAllButton.TextColor3 = Color3.fromRGB(255,255,255)
TeleportAllButton.Font = Enum.Font.GothamBold;
TeleportAllButton.TextSize = 14;
Instance.new("UICorner",TeleportAllButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",TeleportAllButton).Color = Color3.fromRGB(255,255,255)

local UndoRedoSection = Instance.new("Frame",ButtonsSection)
UndoRedoSection.Size = UDim2.new(1,0,0,35)
UndoRedoSection.Position = UDim2.new(0,0,0,80)
UndoRedoSection.BackgroundTransparency = 1;

local UndoButton = Instance.new("TextButton",UndoRedoSection)
UndoButton.Size = UDim2.new(0.48,0,1,0)
UndoButton.Position = UDim2.new(0,0,0,0)
UndoButton.BackgroundColor3 = Color3.fromRGB(255,150,0)
UndoButton.Text = "< UNDO"
UndoButton.TextColor3 = Color3.fromRGB(255,255,255)
UndoButton.Font = Enum.Font.GothamBold;
UndoButton.TextSize = 14;
Instance.new("UICorner",UndoButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",UndoButton).Color = Color3.fromRGB(255,255,255)

local RedoButton = Instance.new("TextButton",UndoRedoSection)
RedoButton.Size = UDim2.new(0.48,0,1,0)
RedoButton.Position = UDim2.new(0.52,0,0,0)
RedoButton.BackgroundColor3 = Color3.fromRGB(0,150,255)
RedoButton.Text = "REDO >"
RedoButton.TextColor3 = Color3.fromRGB(255,255,255)
RedoButton.Font = Enum.Font.GothamBold;
RedoButton.TextSize = 14;
Instance.new("UICorner",RedoButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",RedoButton).Color = Color3.fromRGB(255,255,255)

local ClearAllButton = Instance.new("TextButton",ButtonsSection)
ClearAllButton.Size = UDim2.new(1,0,0,35)
ClearAllButton.Position = UDim2.new(0,0,0,120)
ClearAllButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
ClearAllButton.Text = "CLEAR ALL COORDINATES"
ClearAllButton.TextColor3 = Color3.fromRGB(255,255,255)
ClearAllButton.Font = Enum.Font.GothamBold;
ClearAllButton.TextSize = 14;
Instance.new("UICorner",ClearAllButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",ClearAllButton).Color = Color3.fromRGB(255,255,255)

local CoordinatesListSection = Instance.new("Frame",MultiTeleportSection)
CoordinatesListSection.Size = UDim2.new(1,-20,0,150)
CoordinatesListSection.Position = UDim2.new(0,10,0,510)
CoordinatesListSection.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner",CoordinatesListSection).CornerRadius = UDim.new(0,6)

local CoordinatesListTitle = Instance.new("TextLabel",CoordinatesListSection)
CoordinatesListTitle.Size = UDim2.new(1,0,0,25)
CoordinatesListTitle.Position = UDim2.new(0,0,0,0)
CoordinatesListTitle.BackgroundTransparency = 1;
CoordinatesListTitle.Text = "SAVED COORDINATES (0/" .. MultiTeleport.MaxCoordinates .. ")"
CoordinatesListTitle.TextColor3 = Color3.fromRGB(255,255,255)
CoordinatesListTitle.Font = Enum.Font.GothamBold;
CoordinatesListTitle.TextSize = 12;
CoordinatesListTitle.TextXAlignment = Enum.TextXAlignment.Center;

local CoordinatesList = Instance.new("ScrollingFrame",CoordinatesListSection)
CoordinatesList.Size = UDim2.new(1,-10,0,115)
CoordinatesList.Position = UDim2.new(0,5,0,30)
CoordinatesList.BackgroundTransparency = 1;
CoordinatesList.ScrollBarThickness = 6;
CoordinatesList.CanvasSize = UDim2.new(0,0,0,0)
CoordinatesList.ScrollingDirection = Enum.ScrollingDirection.Y;

-- =================================================================
-- AFK ANTI-KICK FRAME (BARU)
-- =================================================================
local AFKFrame = Instance.new("ScrollingFrame",ContentFrame)
AFKFrame.Size = UDim2.new(1,0,1,0)
AFKFrame.BackgroundTransparency = 1;
AFKFrame.ScrollBarThickness = 8;
AFKFrame.CanvasSize = UDim2.new(0,0,0,350)
AFKFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
AFKFrame.Visible = false;

local AFKContent = Instance.new("Frame",AFKFrame)
AFKContent.Size = UDim2.new(1,0,0,350)
AFKContent.BackgroundTransparency = 1;

local AFKSection = Instance.new("Frame",AFKContent)
AFKSection.Size = UDim2.new(1,-10,0,330)
AFKSection.Position = UDim2.new(0,5,0,5)
AFKSection.BackgroundColor3 = Color3.fromRGB(40,40,50)
Instance.new("UICorner",AFKSection).CornerRadius = UDim.new(0,8)

local AFKTitle = Instance.new("TextLabel",AFKSection)
AFKTitle.Size = UDim2.new(1,0,0,30)
AFKTitle.Position = UDim2.new(0,0,0,5)
AFKTitle.BackgroundTransparency = 1;
AFKTitle.Text = "AFK ANTI-KICK SYSTEM"
AFKTitle.TextColor3 = Color3.fromRGB(255,255,255)
AFKTitle.Font = Enum.Font.GothamBold;
AFKTitle.TextSize = 14;
AFKTitle.TextXAlignment = Enum.TextXAlignment.Center;

-- Anti AFK Mode
local AntiAFKFrame = Instance.new("Frame",AFKSection)
AntiAFKFrame.Size = UDim2.new(1,-20,0,80)
AntiAFKFrame.Position = UDim2.new(0,10,0,40)
AntiAFKFrame.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner",AntiAFKFrame).CornerRadius = UDim.new(0,6)

local AntiAFKTitle = Instance.new("TextLabel",AntiAFKFrame)
AntiAFKTitle.Size = UDim2.new(1,0,0,30)
AntiAFKTitle.Position = UDim2.new(0,0,0,0)
AntiAFKTitle.BackgroundTransparency = 1;
AntiAFKTitle.Text = "ANTI AFK MODE"
AntiAFKTitle.TextColor3 = Color3.fromRGB(255,255,255)
AntiAFKTitle.Font = Enum.Font.GothamBold;
AntiAFKTitle.TextSize = 12;
AntiAFKTitle.TextXAlignment = Enum.TextXAlignment.Center;

local AntiAFKDescription = Instance.new("TextLabel",AntiAFKFrame)
AntiAFKDescription.Size = UDim2.new(1,-10,0,20)
AntiAFKDescription.Position = UDim2.new(0,5,0,30)
AntiAFKDescription.BackgroundTransparency = 1;
AntiAFKDescription.Text = "Prevents kick when AFK by moving mouse"
AntiAFKDescription.TextColor3 = Color3.fromRGB(200,200,200)
AntiAFKDescription.Font = Enum.Font.Gotham;
AntiAFKDescription.TextSize = 10;
AntiAFKDescription.TextXAlignment = Enum.TextXAlignment.Center;

local AntiAFKButton = Instance.new("TextButton",AntiAFKFrame)
AntiAFKButton.Size = UDim2.new(0.8,0,0,25)
AntiAFKButton.Position = UDim2.new(0.1,0,0,55)
AntiAFKButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
AntiAFKButton.Text = "ANTI AFK: OFF"
AntiAFKButton.TextColor3 = Color3.fromRGB(255,255,255)
AntiAFKButton.Font = Enum.Font.GothamBold;
AntiAFKButton.TextSize = 12;
Instance.new("UICorner",AntiAFKButton).CornerRadius = UDim.new(0,6)

-- Auto Jump Mode
local AutoJumpFrame = Instance.new("Frame",AFKSection)
AutoJumpFrame.Size = UDim2.new(1,-20,0,130)
AutoJumpFrame.Position = UDim2.new(0,10,0,130)
AutoJumpFrame.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner",AutoJumpFrame).CornerRadius = UDim.new(0,6)

local AutoJumpTitle = Instance.new("TextLabel",AutoJumpFrame)
AutoJumpTitle.Size = UDim2.new(1,0,0,30)
AutoJumpTitle.Position = UDim2.new(0,0,0,0)
AutoJumpTitle.BackgroundTransparency = 1;
AutoJumpTitle.Text = "AUTO JUMP MODE"
AutoJumpTitle.TextColor3 = Color3.fromRGB(255,255,255)
AutoJumpTitle.Font = Enum.Font.GothamBold;
AutoJumpTitle.TextSize = 12;
AutoJumpTitle.TextXAlignment = Enum.TextXAlignment.Center;

local AutoJumpDescription = Instance.new("TextLabel",AutoJumpFrame)
AutoJumpDescription.Size = UDim2.new(1,-10,0,40)
AutoJumpDescription.Position = UDim2.new(0,5,0,30)
AutoJumpDescription.BackgroundTransparency = 1;
AutoJumpDescription.Text = "Automatically jumps at set interval to prevent AFK kick"
AutoJumpDescription.TextColor3 = Color3.fromRGB(200,200,200)
AutoJumpDescription.Font = Enum.Font.Gotham;
AutoJumpDescription.TextSize = 10;
AutoJumpDescription.TextWrapped = true;
AutoJumpDescription.TextXAlignment = Enum.TextXAlignment.Center;

local AutoJumpButton = Instance.new("TextButton",AutoJumpFrame)
AutoJumpButton.Size = UDim2.new(0.8,0,0,25)
AutoJumpButton.Position = UDim2.new(0.1,0,0,75)
AutoJumpButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
AutoJumpButton.Text = "AUTO JUMP: OFF"
AutoJumpButton.TextColor3 = Color3.fromRGB(255,255,255)
AutoJumpButton.Font = Enum.Font.GothamBold;
AutoJumpButton.TextSize = 12;
Instance.new("UICorner",AutoJumpButton).CornerRadius = UDim.new(0,6)

local JumpIntervalFrame = Instance.new("Frame",AutoJumpFrame)
JumpIntervalFrame.Size = UDim2.new(1,0,0,30)
JumpIntervalFrame.Position = UDim2.new(0,0,0,105)
JumpIntervalFrame.BackgroundTransparency = 1;

local JumpIntervalLabel = Instance.new("TextLabel",JumpIntervalFrame)
JumpIntervalLabel.Size = UDim2.new(0.4,0,1,0)
JumpIntervalLabel.Position = UDim2.new(0.1,0,0,0)
JumpIntervalLabel.BackgroundTransparency = 1;
JumpIntervalLabel.Text = "Interval (minutes):"
JumpIntervalLabel.TextColor3 = Color3.fromRGB(255,255,255)
JumpIntervalLabel.Font = Enum.Font.Gotham;
JumpIntervalLabel.TextSize = 11;
JumpIntervalLabel.TextXAlignment = Enum.TextXAlignment.Left;

local JumpIntervalBox = Instance.new("TextBox",JumpIntervalFrame)
JumpIntervalBox.Size = UDim2.new(0.3,0,1,0)
JumpIntervalBox.Position = UDim2.new(0.5,0,0,0)
JumpIntervalBox.BackgroundColor3 = Color3.fromRGB(30,30,40)
JumpIntervalBox.TextColor3 = Color3.fromRGB(255,255,255)
JumpIntervalBox.Font = Enum.Font.Gotham;
JumpIntervalBox.TextSize = 11;
JumpIntervalBox.PlaceholderText = "1-20"
JumpIntervalBox.Text = "5"
Instance.new("UICorner",JumpIntervalBox).CornerRadius = UDim.new(0,4)

local JumpIntervalInfo = Instance.new("TextLabel",JumpIntervalFrame)
JumpIntervalInfo.Size = UDim2.new(0.15,0,1,0)
JumpIntervalInfo.Position = UDim2.new(0.85,0,0,0)
JumpIntervalInfo.BackgroundTransparency = 1;
JumpIntervalInfo.Text = "(max 20)"
JumpIntervalInfo.TextColor3 = Color3.fromRGB(150,150,150)
JumpIntervalInfo.Font = Enum.Font.Gotham;
JumpIntervalInfo.TextSize = 10;
JumpIntervalInfo.TextXAlignment = Enum.TextXAlignment.Left;

-- Status AFK
local AFKStatusFrame = Instance.new("Frame",AFKSection)
AFKStatusFrame.Size = UDim2.new(1,-20,0,80)
AFKStatusFrame.Position = UDim2.new(0,10,0,270)
AFKStatusFrame.BackgroundColor3 = Color3.fromRGB(50,50,60)
Instance.new("UICorner",AFKStatusFrame).CornerRadius = UDim.new(0,6)

local AFKStatusTitle = Instance.new("TextLabel",AFKStatusFrame)
AFKStatusTitle.Size = UDim2.new(1,0,0,30)
AFKStatusTitle.Position = UDim2.new(0,0,0,0)
AFKStatusTitle.BackgroundTransparency = 1;
AFKStatusTitle.Text = "AFK STATUS"
AFKStatusTitle.TextColor3 = Color3.fromRGB(255,255,255)
AFKStatusTitle.Font = Enum.Font.GothamBold;
AFKStatusTitle.TextSize = 12;
AFKStatusTitle.TextXAlignment = Enum.TextXAlignment.Center;

local AFKStatusLabel = Instance.new("TextLabel",AFKStatusFrame)
AFKStatusLabel.Size = UDim2.new(1,-10,0,40)
AFKStatusLabel.Position = UDim2.new(0,5,0,30)
AFKStatusLabel.BackgroundTransparency = 1;
AFKStatusLabel.Text = "System Ready"
AFKStatusLabel.TextColor3 = Color3.fromRGB(100,255,100)
AFKStatusLabel.Font = Enum.Font.Gotham;
AFKStatusLabel.TextSize = 12;
AFKStatusLabel.TextWrapped = true;
AFKStatusLabel.TextXAlignment = Enum.TextXAlignment.Center;

-- =================================================================
-- INFO FRAME
-- =================================================================
local InfoFrame = Instance.new("ScrollingFrame",ContentFrame)
InfoFrame.Size = UDim2.new(1,0,1,0)
InfoFrame.BackgroundTransparency = 1;
InfoFrame.ScrollBarThickness = 8;
InfoFrame.CanvasSize = UDim2.new(0,0,0,680)
InfoFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
InfoFrame.Visible = false;

local InfoContent = Instance.new("Frame",InfoFrame)
InfoContent.Size = UDim2.new(1,0,0,680)
InfoContent.BackgroundTransparency = 1;

local GameNameLabel = Instance.new("TextLabel",InfoContent)
GameNameLabel.Size = UDim2.new(1,-10,0,25)
GameNameLabel.Position = UDim2.new(0,5,0,5)
GameNameLabel.BackgroundTransparency = 1;
GameNameLabel.Text = "Game: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name;
GameNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
GameNameLabel.Font = Enum.Font.Gotham;
GameNameLabel.TextSize = 14;
GameNameLabel.TextXAlignment = Enum.TextXAlignment.Left;

local PlayerNameLabel = Instance.new("TextLabel",InfoContent)
PlayerNameLabel.Size = UDim2.new(1,-10,0,25)
PlayerNameLabel.Position = UDim2.new(0,5,0,35)
PlayerNameLabel.BackgroundTransparency = 1;
PlayerNameLabel.Text = "Player: "..localPlayer.Name;
PlayerNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
PlayerNameLabel.Font = Enum.Font.Gotham;
PlayerNameLabel.TextSize = 14;
PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left;

local UserIdLabel = Instance.new("TextLabel",InfoContent)
UserIdLabel.Size = UDim2.new(1,-10,0,25)
UserIdLabel.Position = UDim2.new(0,5,0,65)
UserIdLabel.BackgroundTransparency = 1;
UserIdLabel.Text = "User ID: "..localPlayer.UserId;
UserIdLabel.TextColor3 = Color3.fromRGB(255,255,255)
UserIdLabel.Font = Enum.Font.Gotham;
UserIdLabel.TextSize = 14;
UserIdLabel.TextXAlignment = Enum.TextXAlignment.Left;

local AccountAgeLabel = Instance.new("TextLabel",InfoContent)
AccountAgeLabel.Size = UDim2.new(1,-10,0,25)
AccountAgeLabel.Position = UDim2.new(0,5,0,95)
AccountAgeLabel.BackgroundTransparency = 1;
AccountAgeLabel.Text = "Account Age: "..localPlayer.AccountAge.." days"
AccountAgeLabel.TextColor3 = Color3.fromRGB(255,255,255)
AccountAgeLabel.Font = Enum.Font.Gotham;
AccountAgeLabel.TextSize = 14;
AccountAgeLabel.TextXAlignment = Enum.TextXAlignment.Left;

local LastUpdateLabel = Instance.new("TextLabel",InfoContent)
LastUpdateLabel.Size = UDim2.new(1,-10,0,25)
LastUpdateLabel.Position = UDim2.new(0,5,0,125)
LastUpdateLabel.BackgroundTransparency = 1;
LastUpdateLabel.Text = "Last Update: December 2025"
LastUpdateLabel.TextColor3 = Color3.fromRGB(255,255,255)
LastUpdateLabel.Font = Enum.Font.Gotham;
LastUpdateLabel.TextSize = 14;
LastUpdateLabel.TextXAlignment = Enum.TextXAlignment.Left;

local VersionLabel = Instance.new("TextLabel",InfoContent)
VersionLabel.Size = UDim2.new(1,-10,0,25)
VersionLabel.Position = UDim2.new(0,5,0,155)
VersionLabel.BackgroundTransparency = 1;
VersionLabel.Text = "Lunar Script Version: v3.0"
VersionLabel.TextColor3 = Color3.fromRGB(255,255,255)
VersionLabel.Font = Enum.Font.Gotham;
VersionLabel.TextSize = 14;
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left;

local CopyGameLinkButton = Instance.new("TextButton",InfoContent)
CopyGameLinkButton.Size = UDim2.new(1,-10,0,35)
CopyGameLinkButton.Position = UDim2.new(0,5,0,185)
CopyGameLinkButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
CopyGameLinkButton.Text = "COPY GAME LINK"
CopyGameLinkButton.TextColor3 = Color3.fromRGB(255,255,255)
CopyGameLinkButton.Font = Enum.Font.GothamBold;
CopyGameLinkButton.TextSize = 12;
Instance.new("UICorner",CopyGameLinkButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",CopyGameLinkButton).Color = Color3.fromRGB(255,255,255)

local DiscordButton = Instance.new("TextButton",InfoContent)
DiscordButton.Size = UDim2.new(1,-10,0,35)
DiscordButton.Position = UDim2.new(0,5,0,225)
DiscordButton.BackgroundColor3 = Color3.fromRGB(88,101,242)
DiscordButton.Text = "COPY DISCORD LINK"
DiscordButton.TextColor3 = Color3.fromRGB(255,255,255)
DiscordButton.Font = Enum.Font.GothamBold;
DiscordButton.TextSize = 12;
Instance.new("UICorner",DiscordButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",DiscordButton).Color = Color3.fromRGB(255,255,255)

local CreatorSection = Instance.new("Frame",InfoContent)
CreatorSection.Size = UDim2.new(1,-10,0,120)
CreatorSection.Position = UDim2.new(0,5,0,265)
CreatorSection.BackgroundTransparency = 1;

local CreatorTitle = Instance.new("TextLabel",CreatorSection)
CreatorTitle.Size = UDim2.new(1,0,0,20)
CreatorTitle.Position = UDim2.new(0,0,0,0)
CreatorTitle.BackgroundTransparency = 1;
CreatorTitle.Text = "Created by"
CreatorTitle.TextColor3 = Color3.fromRGB(255,255,255)
CreatorTitle.Font = Enum.Font.GothamBold;
CreatorTitle.TextSize = 14;
CreatorTitle.TextXAlignment = Enum.TextXAlignment.Center;

local CreatorContainer = Instance.new("Frame",CreatorSection)
CreatorContainer.Size = UDim2.new(1,0,0,100)
CreatorContainer.Position = UDim2.new(0,0,0,25)
CreatorContainer.BackgroundTransparency = 1;

local Creator1Frame = Instance.new("Frame",CreatorContainer)
Creator1Frame.Size = UDim2.new(0,80,0,100)
Creator1Frame.Position = UDim2.new(0.2,-40,0,0)
Creator1Frame.BackgroundTransparency = 1;

local Creator1Image = Instance.new("ImageLabel",Creator1Frame)
Creator1Image.Size = UDim2.new(1,0,0,80)
Creator1Image.BackgroundTransparency = 1;
Creator1Image.Image = "rbxassetid://73700667119693"
Creator1Image.ScaleType = Enum.ScaleType.Fit;

local Creator1Name = Instance.new("TextLabel",Creator1Frame)
Creator1Name.Size = UDim2.new(1,0,0,20)
Creator1Name.Position = UDim2.new(0,0,0,80)
Creator1Name.BackgroundTransparency = 1;
Creator1Name.Text = "H4000audio"
Creator1Name.TextColor3 = Color3.fromRGB(255,255,255)
Creator1Name.Font = Enum.Font.Gotham;
Creator1Name.TextSize = 12;
Creator1Name.TextYAlignment = Enum.TextYAlignment.Top;
Creator1Name.TextXAlignment = Enum.TextXAlignment.Center;

local XSymbol = Instance.new("TextLabel",CreatorContainer)
XSymbol.Size = UDim2.new(0,60,0,80)
XSymbol.Position = UDim2.new(0.5,-30,0,0)
XSymbol.BackgroundTransparency = 1;
XSymbol.Text = "X"
XSymbol.TextColor3 = Color3.fromRGB(255,255,255)
XSymbol.Font = Enum.Font.GothamBold;
XSymbol.TextSize = 36;
XSymbol.TextYAlignment = Enum.TextYAlignment.Center;
XSymbol.TextXAlignment = Enum.TextXAlignment.Center;

local Creator2Frame = Instance.new("Frame",CreatorContainer)
Creator2Frame.Size = UDim2.new(0,80,0,100)
Creator2Frame.Position = UDim2.new(0.8,-40,0,0)
Creator2Frame.BackgroundTransparency = 1;

local Creator2Image = Instance.new("ImageLabel",Creator2Frame)
Creator2Image.Size = UDim2.new(1,0,0,80)
Creator2Image.BackgroundTransparency = 1;
Creator2Image.Image = "rbxassetid://98683864421535"
Creator2Image.ScaleType = Enum.ScaleType.Fit;

local Creator2Name = Instance.new("TextLabel",Creator2Frame)
Creator2Name.Size = UDim2.new(1,0,0,20)
Creator2Name.Position = UDim2.new(0,0,0,80)
Creator2Name.BackgroundTransparency = 1;
Creator2Name.Text = "DarkLua_script"
Creator2Name.TextColor3 = Color3.fromRGB(255,255,255)
Creator2Name.Font = Enum.Font.Gotham;
Creator2Name.TextSize = 12;
Creator2Name.TextYAlignment = Enum.TextYAlignment.Top;
Creator2Name.TextXAlignment = Enum.TextXAlignment.Center;

local BigPhoto = Instance.new("ImageLabel",InfoContent)
BigPhoto.Size = UDim2.new(0,200,0,200)
BigPhoto.Position = UDim2.new(0.5,-100,0,390)
BigPhoto.BackgroundTransparency = 1;
BigPhoto.Image = "rbxassetid://86649674261241"
BigPhoto.ScaleType = Enum.ScaleType.Fit;

local FooterText = Instance.new("TextLabel",InfoContent)
FooterText.Size = UDim2.new(1,-10,0,40)
FooterText.Position = UDim2.new(0,5,0,595)
FooterText.BackgroundTransparency = 1;
FooterText.Text = "Created by: h4000_audio8 & DarkLua_script\nThanks for using Lunar Script v3!"
FooterText.TextColor3 = Color3.fromRGB(255,255,255)
FooterText.Font = Enum.Font.Gotham;
FooterText.TextSize = 12;
FooterText.TextXAlignment = Enum.TextXAlignment.Left;

-- =================================================================
-- SETTINGS FRAME
-- =================================================================
local SettingsFrame = Instance.new("ScrollingFrame",ContentFrame)
SettingsFrame.Size = UDim2.new(1,0,1,0)
SettingsFrame.BackgroundTransparency = 1;
SettingsFrame.ScrollBarThickness = 8;
SettingsFrame.CanvasSize = UDim2.new(0,0,0,360)
SettingsFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
SettingsFrame.Visible = false;

local SettingsContent = Instance.new("Frame",SettingsFrame)
SettingsContent.Size = UDim2.new(1,0,0,360)
SettingsContent.BackgroundTransparency = 1;

local ThemeTitle = Instance.new("TextLabel",SettingsContent)
ThemeTitle.Size = UDim2.new(1,-10,0,25)
ThemeTitle.Position = UDim2.new(0,5,0,5)
ThemeTitle.BackgroundTransparency = 1;
ThemeTitle.Text = "BACKGROUND THEME"
ThemeTitle.TextColor3 = Color3.fromRGB(255,255,255)
ThemeTitle.Font = Enum.Font.GothamBold;
ThemeTitle.TextSize = 14;
ThemeTitle.TextXAlignment = Enum.TextXAlignment.Left;

local DarkThemeButton = Instance.new("TextButton",SettingsContent)
DarkThemeButton.Size = UDim2.new(1,-10,0,25)
DarkThemeButton.Position = UDim2.new(0,5,0,35)
DarkThemeButton.BackgroundColor3 = M.night.buttonColor;
DarkThemeButton.Text = "DARK"
DarkThemeButton.TextColor3 = Color3.fromRGB(255,255,255)
DarkThemeButton.Font = Enum.Font.Gotham;
DarkThemeButton.TextSize = 12;
Instance.new("UICorner",DarkThemeButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",DarkThemeButton).Color = M.night.topBarColor

local OceanThemeButton = Instance.new("TextButton",SettingsContent)
OceanThemeButton.Size = UDim2.new(1,-10,0,25)
OceanThemeButton.Position = UDim2.new(0,5,0,65)
OceanThemeButton.BackgroundColor3 = M.ocean.buttonColor;
OceanThemeButton.Text = "OCEAN"
OceanThemeButton.TextColor3 = Color3.fromRGB(255,255,255)
OceanThemeButton.Font = Enum.Font.Gotham;
OceanThemeButton.TextSize = 12;
Instance.new("UICorner",OceanThemeButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",OceanThemeButton).Color = M.ocean.topBarColor

local NightThemeButton = Instance.new("TextButton",SettingsContent)
NightThemeButton.Size = UDim2.new(1,-10,0,25)
NightThemeButton.Position = UDim2.new(0,5,0,95)
NightThemeButton.BackgroundColor3 = M.night.buttonColor;
NightThemeButton.Text = "NIGHT SKY"
NightThemeButton.TextColor3 = Color3.fromRGB(255,255,255)
NightThemeButton.Font = Enum.Font.Gotham;
NightThemeButton.TextSize = 12;
Instance.new("UICorner",NightThemeButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",NightThemeButton).Color = M.night.topBarColor

local RGBModeButton = Instance.new("TextButton",SettingsContent)
RGBModeButton.Size = UDim2.new(1,-10,0,25)
RGBModeButton.Position = UDim2.new(0,5,0,125)
RGBModeButton.BackgroundColor3 = M.night.buttonColor;
RGBModeButton.Text = "RGB LINE MODE: ON"
RGBModeButton.TextColor3 = Color3.fromRGB(100,255,100)
RGBModeButton.Font = Enum.Font.Gotham;
RGBModeButton.TextSize = 12;
Instance.new("UICorner",RGBModeButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",RGBModeButton).Color = M.night.topBarColor

local ServerManagementTitle = Instance.new("TextLabel",SettingsContent)
ServerManagementTitle.Size = UDim2.new(1,-10,0,25)
ServerManagementTitle.Position = UDim2.new(0,5,0,155)
ServerManagementTitle.BackgroundTransparency = 1;
ServerManagementTitle.Text = "SERVER MANAGEMENT"
ServerManagementTitle.TextColor3 = Color3.fromRGB(255,255,255)
ServerManagementTitle.Font = Enum.Font.GothamBold;
ServerManagementTitle.TextSize = 14;
ServerManagementTitle.TextXAlignment = Enum.TextXAlignment.Left;

local RejoinButton = Instance.new("TextButton",SettingsContent)
RejoinButton.Size = UDim2.new(1,-10,0,25)
RejoinButton.Position = UDim2.new(0,5,0,185)
RejoinButton.BackgroundColor3 = M.night.buttonColor;
RejoinButton.Text = "REJOIN SERVER"
RejoinButton.TextColor3 = Color3.fromRGB(255,255,255)
RejoinButton.Font = Enum.Font.Gotham;
RejoinButton.TextSize = 12;
Instance.new("UICorner",RejoinButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",RejoinButton).Color = M.night.topBarColor

local NewServerButton = Instance.new("TextButton",SettingsContent)
NewServerButton.Size = UDim2.new(1,-10,0,25)
NewServerButton.Position = UDim2.new(0,5,0,215)
NewServerButton.BackgroundColor3 = M.night.buttonColor;
NewServerButton.Text = "JOIN NEW SERVER"
NewServerButton.TextColor3 = Color3.fromRGB(255,255,255)
NewServerButton.Font = Enum.Font.Gotham;
NewServerButton.TextSize = 12;
Instance.new("UICorner",NewServerButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",NewServerButton).Color = M.night.topBarColor

local LowPlayerServerButton = Instance.new("TextButton",SettingsContent)
LowPlayerServerButton.Size = UDim2.new(1,-10,0,25)
LowPlayerServerButton.Position = UDim2.new(0,5,0,245)
LowPlayerServerButton.BackgroundColor3 = M.night.buttonColor;
LowPlayerServerButton.Text = "JOIN LOW PLAYER SERVER"
LowPlayerServerButton.TextColor3 = Color3.fromRGB(255,255,255)
LowPlayerServerButton.Font = Enum.Font.Gotham;
LowPlayerServerButton.TextSize = 12;
Instance.new("UICorner",LowPlayerServerButton).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",LowPlayerServerButton).Color = M.night.topBarColor

-- =================================================================
-- TOOLS FRAME (Tanpa Clear Tools)
-- =================================================================
local ToolsFrame = Instance.new("ScrollingFrame",ContentFrame)
ToolsFrame.Size = UDim2.new(1,0,1,0)
ToolsFrame.BackgroundTransparency = 1;
ToolsFrame.ScrollBarThickness = 8;
ToolsFrame.CanvasSize = UDim2.new(0,0,0,250)
ToolsFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
ToolsFrame.Visible = false;

local ToolsContent = Instance.new("Frame",ToolsFrame)
ToolsContent.Size = UDim2.new(1,0,0,250)
ToolsContent.BackgroundTransparency = 1;

local VisualToolsSection = Instance.new("Frame",ToolsContent)
VisualToolsSection.Size = UDim2.new(1,-10,0,180)
VisualToolsSection.Position = UDim2.new(0,5,0,5)
VisualToolsSection.BackgroundColor3 = Color3.fromRGB(40,40,50)
Instance.new("UICorner",VisualToolsSection).CornerRadius = UDim.new(0,8)

local VisualToolsTitle = Instance.new("TextLabel",VisualToolsSection)
VisualToolsTitle.Size = UDim2.new(1,0,0,30)
VisualToolsTitle.Position = UDim2.new(0,0,0,5)
VisualToolsTitle.BackgroundTransparency = 1;
VisualToolsTitle.Text = "VISUAL TOOLS"
VisualToolsTitle.TextColor3 = Color3.fromRGB(255,255,255)
VisualToolsTitle.Font = Enum.Font.GothamBold;
VisualToolsTitle.TextSize = 14;
VisualToolsTitle.TextXAlignment = Enum.TextXAlignment.Center;

local DeletePartButton = Instance.new("TextButton",VisualToolsSection)
DeletePartButton.Size = UDim2.new(1,-20,0,40)
DeletePartButton.Position = UDim2.new(0,10,0,40)
DeletePartButton.BackgroundColor3 = Color3.fromRGB(50,150,200)
DeletePartButton.Text = "DELETE PART: OFF"
DeletePartButton.TextColor3 = Color3.fromRGB(255,255,255)
DeletePartButton.Font = Enum.Font.GothamBold;
DeletePartButton.TextSize = 14;
Instance.new("UICorner",DeletePartButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",DeletePartButton).Color = Color3.fromRGB(255,255,255)

local BuilderToolsButton = Instance.new("TextButton",VisualToolsSection)
BuilderToolsButton.Size = UDim2.new(1,-20,0,40)
BuilderToolsButton.Position = UDim2.new(0,10,0,90)
BuilderToolsButton.BackgroundColor3 = Color3.fromRGB(0,150,100)
BuilderToolsButton.Text = "BUILDER TOOLS: OFF"
BuilderToolsButton.TextColor3 = Color3.fromRGB(255,255,255)
BuilderToolsButton.Font = Enum.Font.GothamBold;
BuilderToolsButton.TextSize = 14;
Instance.new("UICorner",BuilderToolsButton).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke",BuilderToolsButton).Color = Color3.fromRGB(255,255,255)

-- Builder Tools GUI yang akan muncul di bawah daftar visual tools
local BuilderToolsGUISection = Instance.new("Frame",ToolsContent)
BuilderToolsGUISection.Size = UDim2.new(1,-10,0,300)
BuilderToolsGUISection.Position = UDim2.new(0,5,0,190)
BuilderToolsGUISection.BackgroundColor3 = Color3.fromRGB(40,40,50)
BuilderToolsGUISection.Visible = false
Instance.new("UICorner",BuilderToolsGUISection).CornerRadius = UDim.new(0,8)

local BuilderToolsTitle = Instance.new("TextLabel",BuilderToolsGUISection)
BuilderToolsTitle.Size = UDim2.new(1,0,0,30)
BuilderToolsTitle.Position = UDim2.new(0,0,0,5)
BuilderToolsTitle.BackgroundTransparency = 1;
BuilderToolsTitle.Text = "BUILDER TOOLS"
BuilderToolsTitle.TextColor3 = Color3.fromRGB(255,255,255)
BuilderToolsTitle.Font = Enum.Font.GothamBold;
BuilderToolsTitle.TextSize = 14;
BuilderToolsTitle.TextXAlignment = Enum.TextXAlignment.Center;

-- Scrolling frame untuk part types
builderScrollFrame = Instance.new("ScrollingFrame",BuilderToolsGUISection)
builderScrollFrame.Size = UDim2.new(1,-20,0,150)
builderScrollFrame.Position = UDim2.new(0,10,0,40)
builderScrollFrame.BackgroundTransparency = 1
builderScrollFrame.BorderSizePixel = 0
builderScrollFrame.ScrollBarThickness = 6
builderScrollFrame.CanvasSize = UDim2.new(0,0,0,0)
builderScrollFrame.Parent = BuilderToolsGUISection

local DeleteAllMapButton = Instance.new("TextButton",BuilderToolsGUISection)
DeleteAllMapButton.Size = UDim2.new(1,-20,0,35)
DeleteAllMapButton.Position = UDim2.new(0,10,0,200)
DeleteAllMapButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
DeleteAllMapButton.TextColor3 = Color3.fromRGB(255,255,255)
DeleteAllMapButton.Text = "DELETE ALL MAP"
DeleteAllMapButton.Font = Enum.Font.GothamBold
DeleteAllMapButton.TextSize = 14
DeleteAllMapButton.Parent = BuilderToolsGUISection
Instance.new("UICorner",DeleteAllMapButton).CornerRadius = UDim.new(0,6)

local SpawnBaseplateButton = Instance.new("TextButton",BuilderToolsGUISection)
SpawnBaseplateButton.Size = UDim2.new(1,-20,0,35)
SpawnBaseplateButton.Position = UDim2.new(0,10,0,245)
SpawnBaseplateButton.BackgroundColor3 = Color3.fromRGB(100,100,100)
SpawnBaseplateButton.TextColor3 = Color3.fromRGB(255,255,255)
SpawnBaseplateButton.Text = "SPAWN BASEPLATE"
SpawnBaseplateButton.Font = Enum.Font.GothamBold
SpawnBaseplateButton.TextSize = 14
SpawnBaseplateButton.Parent = BuilderToolsGUISection
Instance.new("UICorner",SpawnBaseplateButton).CornerRadius = UDim.new(0,6)

-- Undo/Redo Buttons untuk Builder Tools
local BuilderUndoRedoFrame = Instance.new("Frame",ToolsContent)
BuilderUndoRedoFrame.Size = UDim2.new(1,-10,0,40)
BuilderUndoRedoFrame.Position = UDim2.new(0,5,0,495)
BuilderUndoRedoFrame.BackgroundTransparency = 1
BuilderUndoRedoFrame.Visible = false

local BuilderUndoButton = Instance.new("TextButton",BuilderUndoRedoFrame)
BuilderUndoButton.Size = UDim2.new(0.4,0,1,0)
BuilderUndoButton.Position = UDim2.new(0,0,0,0)
BuilderUndoButton.BackgroundColor3 = Color3.fromRGB(0,150,255)
BuilderUndoButton.TextColor3 = Color3.fromRGB(255,255,255)
BuilderUndoButton.Text = "< UNDO"
BuilderUndoButton.Font = Enum.Font.GothamBold
BuilderUndoButton.TextSize = 14
BuilderUndoButton.Parent = BuilderUndoRedoFrame
Instance.new("UICorner",BuilderUndoButton).CornerRadius = UDim.new(0,6)

local BuilderRedoButton = Instance.new("TextButton",BuilderUndoRedoFrame)
BuilderRedoButton.Size = UDim2.new(0.4,0,1,0)
BuilderRedoButton.Position = UDim2.new(0.6,0,0,0)
BuilderRedoButton.BackgroundColor3 = Color3.fromRGB(255,150,0)
BuilderRedoButton.TextColor3 = Color3.fromRGB(255,255,255)
BuilderRedoButton.Text = "REDO >"
BuilderRedoButton.Font = Enum.Font.GothamBold
BuilderRedoButton.TextSize = 14
BuilderRedoButton.Parent = BuilderUndoRedoFrame
Instance.new("UICorner",BuilderRedoButton).CornerRadius = UDim.new(0,6)

-- Update Tools Frame height
ToolsFrame.CanvasSize = UDim2.new(0,0,0,540)

-- =================================================================
-- DELETE TOOL FUNCTIONS
-- =================================================================

local function CreateDeleteTool()
    -- Buat ScreenGui untuk Delete Tool
    local deleteScreenGui = Instance.new("ScreenGui")
    deleteScreenGui.Name = "DeleteToolGUI"
    deleteScreenGui.ResetOnSpawn = false
    deleteScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    -- Delete GUI (Kanan Atas)
    deleteGUI = Instance.new("Frame")
    deleteGUI.Name = "DeleteGUI"
    deleteGUI.Size = UDim2.new(0, 200, 0, 120)
    deleteGUI.Position = UDim2.new(1, -220, 0, 10)
    deleteGUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    deleteGUI.BorderSizePixel = 2
    deleteGUI.BorderColor3 = Color3.fromRGB(255, 0, 0)
    deleteGUI.Visible = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = deleteGUI
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = "DELETE PART"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = deleteGUI
    
    local deleteButton = Instance.new("TextButton")
    deleteButton.Name = "DeleteButton"
    deleteButton.Size = UDim2.new(0, 160, 0, 35)
    deleteButton.Position = UDim2.new(0.5, -80, 0.4, 0)
    deleteButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    deleteButton.Text = "CONFIRM DELETE"
    deleteButton.Font = Enum.Font.GothamBold
    deleteButton.TextSize = 14
    deleteButton.Parent = deleteGUI
    
    local cancelButton = Instance.new("TextButton")
    cancelButton.Name = "CancelButton"
    cancelButton.Size = UDim2.new(0, 160, 0, 35)
    cancelButton.Position = UDim2.new(0.5, -80, 0.75, 0)
    cancelButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelButton.Text = "CANCEL"
    cancelButton.Font = Enum.Font.GothamBold
    cancelButton.TextSize = 14
    cancelButton.Parent = deleteGUI
    
    deleteGUI.Parent = deleteScreenGui
    
    -- Undo/Redo GUI (Tengah Atas - tanpa background)
    undoRedoGUI = Instance.new("Frame")
    undoRedoGUI.Name = "UndoRedoGUI"
    undoRedoGUI.Size = UDim2.new(0, 100, 0, 40)
    undoRedoGUI.Position = UDim2.new(0.5, -50, 0, 5)
    undoRedoGUI.BackgroundTransparency = 1
    undoRedoGUI.BorderSizePixel = 0
    undoRedoGUI.Visible = false
    
    local undoButton = Instance.new("TextButton")
    undoButton.Name = "UndoButton"
    undoButton.Size = UDim2.new(0, 40, 0, 40)
    undoButton.Position = UDim2.new(0, 0, 0, 0)
    undoButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    undoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    undoButton.Text = "<"
    undoButton.Font = Enum.Font.GothamBold
    undoButton.TextSize = 20
    undoButton.Parent = undoRedoGUI
    
    local redoButton = Instance.new("TextButton")
    redoButton.Name = "RedoButton"
    redoButton.Size = UDim2.new(0, 40, 0, 40)
    redoButton.Position = UDim2.new(1, -40, 0, 0)
    redoButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Disabled untuk redo
    redoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    redoButton.Text = ">"
    redoButton.Font = Enum.Font.GothamBold
    redoButton.TextSize = 20
    redoButton.Parent = undoRedoGUI
    
    undoRedoGUI.Parent = deleteScreenGui
    
    -- Fungsi Highlight dengan Box + Fill
    local function createHighlight(part)
        -- Hapus highlight sebelumnya
        if selectionBox then
            selectionBox:Destroy()
            selectionBox = nil
        end
        if highlight then
            highlight:Destroy()
            highlight = nil
        end
        
        -- Buat Selection Box (garis merah)
        selectionBox = Instance.new("SelectionBox")
        selectionBox.Adornee = part
        selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
        selectionBox.LineThickness = 0.05
        selectionBox.Parent = part
        
        -- Buat Highlight (warna merah pudar di seluruh objek)
        highlight = Instance.new("BoxHandleAdornment")
        highlight.Adornee = part
        highlight.AlwaysOnTop = false
        highlight.ZIndex = 0
        highlight.Size = part.Size
        highlight.Color3 = Color3.fromRGB(255, 0, 0)
        highlight.Transparency = 0.7 -- Sedikit pudar
        highlight.Parent = part
    end
    
    local function clearHighlight()
        if selectionBox then
            selectionBox:Destroy()
            selectionBox = nil
        end
        if highlight then
            highlight:Destroy()
            highlight = nil
        end
        selectedPart = nil
    end
    
    -- Update Undo/Redo Buttons
    local function updateUndoRedoButtons()
        if #deletedParts > 0 then
            undoRedoGUI.Visible = true
        else
            undoRedoGUI.Visible = false
        end
    end
    
    -- Event Handlers
    deleteButton.MouseButton1Click:Connect(function()
        if selectedPart and selectedPart.Parent then
            -- Clone part TANPA highlight/selection box
            local partClone = selectedPart:Clone()
            
            -- Bersihkan semua SelectionBox dan Highlight dari clone
            local descendants = partClone:GetDescendants()
            for _, descendant in ipairs(descendants) do
                if descendant:IsA("SelectionBox") or descendant:IsA("BoxHandleAdornment") then
                    descendant:Destroy()
                end
            end
            
            table.insert(deletedParts, {
                Part = partClone,
                Position = selectedPart.Position,
                Parent = selectedPart.Parent
            })
            
            selectedPart:Destroy()
            clearHighlight()
            deleteGUI.Visible = false
            updateUndoRedoButtons()
        end
    end)
    
    cancelButton.MouseButton1Click:Connect(function()
        clearHighlight()
        deleteGUI.Visible = false
    end)
    
    undoButton.MouseButton1Click:Connect(function()
        if #deletedParts > 0 then
            local lastPart = table.remove(deletedParts)
            
            -- Restore part yang sudah dibersihkan dari highlight
            local restored = lastPart.Part:Clone()
            
            -- Pastikan tidak ada highlight/selection box di part yang di-restore
            local descendants = restored:GetDescendants()
            for _, descendant in ipairs(descendants) do
                if descendant:IsA("SelectionBox") or descendant:IsA("BoxHandleAdornment") then
                    descendant:Destroy()
                end
            end
            
            restored.Parent = workspace
            restored.Position = lastPart.Position
            updateUndoRedoButtons()
        end
    end)
    
    return deleteScreenGui, updateUndoRedoButtons, createHighlight, clearHighlight
end

local function ToggleDeleteMode()
    deleteModeActive = not deleteModeActive
    
    if deleteModeActive then
        DeletePartButton.Text = "DELETE PART: ON"
        DeletePartButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        ShowNotification("Delete Tool", "Delete mode activated! Click on any part to delete it.")
        
        -- Inisialisasi delete tool jika belum ada
        if not deleteGUI then
            CreateDeleteTool()
        end
        
        -- Aktifkan mode delete (seperti memegang tool)
        local mouse = localPlayer:GetMouse()
        
        if mouseConnection then
            mouseConnection:Disconnect()
        end
        
        mouseConnection = mouse.Button1Down:Connect(function()
            if not deleteModeActive then return end
            
            local target = mouse.Target
            if target and target:IsA("BasePart") and target.Parent ~= localPlayer.Character then
                selectedPart = target
                
                -- Buat highlight
                if selectionBox then selectionBox:Destroy() end
                if highlight then highlight:Destroy() end
                
                -- Buat Selection Box (garis merah)
                selectionBox = Instance.new("SelectionBox")
                selectionBox.Adornee = target
                selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
                selectionBox.LineThickness = 0.05
                selectionBox.Parent = target
                
                -- Buat Highlight (warna merah pudar di seluruh objek)
                highlight = Instance.new("BoxHandleAdornment")
                highlight.Adornee = target
                highlight.AlwaysOnTop = false
                highlight.ZIndex = 0
                highlight.Size = target.Size
                highlight.Color3 = Color3.fromRGB(255, 0, 0)
                highlight.Transparency = 0.7
                highlight.Parent = target
                
                deleteGUI.Visible = true
            end
        end)
        
    else
        DeletePartButton.Text = "DELETE PART: OFF"
        DeletePartButton.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
        ShowNotification("Delete Tool", "Delete mode deactivated!")
        
        -- Nonaktifkan mode delete (seperti melepas tool)
        if mouseConnection then
            mouseConnection:Disconnect()
            mouseConnection = nil
        end
        
        -- Hapus highlight
        if selectionBox then
            selectionBox:Destroy()
            selectionBox = nil
        end
        if highlight then
            highlight:Destroy()
            highlight = nil
        end
        
        selectedPart = nil
        deleteGUI.Visible = false
        undoRedoGUI.Visible = false
    end
end

-- =================================================================
-- BUILDER TOOL FUNCTIONS
-- =================================================================

local partTypes = {
    {"Brick", Vector3.new(4, 2, 4), "Bright red"},
    {"Grass", Vector3.new(6, 1, 6), "Bright green"},
    {"Plank", Vector3.new(8, 0.5, 2), "Brown"},
    {"Stair", Vector3.new(4, 1, 2), "Medium stone grey"},
    {"Plate", Vector3.new(10, 0.3, 10), "Light stone grey"},
    {"Pillar", Vector3.new(2, 8, 2), "Dark stone grey"},
    {"Wall", Vector3.new(10, 6, 1), "Light stone grey"},
    {"Window", Vector3.new(4, 4, 0.5), "Light blue"},
    {"Door", Vector3.new(3, 6, 0.2), "Brown"},
    {"Roof", Vector3.new(8, 0.5, 6), "Red"},
    {"Glass", Vector3.new(4, 4, 0.2), "Light blue"},
    {"Metal", Vector3.new(4, 4, 4), "Medium grey"},
    {"Stone", Vector3.new(5, 3, 5), "Dark stone grey"},
    {"Gold", Vector3.new(3, 3, 3), "Bright yellow"},
    {"Diamond", Vector3.new(3, 3, 3), "Bright blue"},
    {"Lava", Vector3.new(4, 1, 4), "Bright orange"},
    {"Water", Vector3.new(6, 1, 6), "Bright blue"},
    {"Ice", Vector3.new(4, 2, 4), "Light blue"},
    {"Neon Red", Vector3.new(3, 3, 3), "Bright red"},
    {"Neon Blue", Vector3.new(3, 3, 3), "Bright blue"},
    {"Neon Green", Vector3.new(3, 3, 3), "Bright green"},
    {"Neon Yellow", Vector3.new(3, 3, 3), "Bright yellow"},
    {"Black", Vector3.new(4, 4, 4), "Black"},
    {"White", Vector3.new(4, 4, 4), "White"},
    {"Checkpoint", Vector3.new(5, 1, 5), "Lime green"}
}

local function UpdateBuilderUndoButtons()
    BuilderUndoRedoFrame.Visible = #placedParts > 0
end

local function createPart(partType, position)
    local partData = partTypes[partType]
    local part = Instance.new("Part")
    part.Size = partData[2]
    part.Position = position
    part.Anchored = true
    part.CanCollide = true
    part.Material = Enum.Material.Plastic
    
    if partData[1] == "Grass" then
        part.BrickColor = BrickColor.new("Bright green")
        part.Material = Enum.Material.Grass
    elseif partData[1] == "Plank" then
        part.BrickColor = BrickColor.new("Brown")
        part.Material = Enum.Material.Wood
    elseif partData[1] == "Stair" then
        part.BrickColor = BrickColor.new("Medium stone grey")
        local wedge = Instance.new("WedgePart")
        wedge.Size = partData[2]
        wedge.Position = position
        wedge.Anchored = true
        wedge.CanCollide = true
        wedge.BrickColor = BrickColor.new("Medium stone grey")
        wedge.Parent = workspace
        part:Destroy()
        part = wedge
    elseif partData[1] == "Glass" then
        part.BrickColor = BrickColor.new("Light blue")
        part.Material = Enum.Material.Glass
        part.Transparency = 0.3
    elseif partData[1] == "Metal" then
        part.BrickColor = BrickColor.new("Medium grey")
        part.Material = Enum.Material.Metal
    elseif partData[1] == "Stone" then
        part.BrickColor = BrickColor.new("Dark stone grey")
        part.Material = Enum.Material.Slate
    elseif partData[1] == "Gold" then
        part.BrickColor = BrickColor.new("Bright yellow")
        part.Material = Enum.Material.Metal
    elseif partData[1] == "Diamond" then
        part.BrickColor = BrickColor.new("Bright blue")
        part.Material = Enum.Material.DiamondPlate
    elseif partData[1] == "Lava" then
        part.BrickColor = BrickColor.new("Bright orange")
        part.Material = Enum.Material.Neon
    elseif partData[1] == "Water" then
        part.BrickColor = BrickColor.new("Bright blue")
        part.Material = Enum.Material.Water
        part.Transparency = 0.5
    elseif partData[1] == "Ice" then
        part.BrickColor = BrickColor.new("Light blue")
        part.Material = Enum.Material.Ice
    elseif partData[1]:find("Neon") then
        part.BrickColor = BrickColor.new(partData[3])
        part.Material = Enum.Material.Neon
    else
        part.BrickColor = BrickColor.new(partData[3])
    end
    
    if partData[1] ~= "Stair" then
        part.Parent = workspace
    end
    
    return part
end

local function InitializeBuilderGUI()
    -- Clear existing buttons
    for _, child in ipairs(builderScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Create part type buttons
    for i, partData in ipairs(partTypes) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 25)
        button.Position = UDim2.new(0, 0, 0, (i-1)*25)
        button.BackgroundColor3 = i == 1 and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(80, 80, 80)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = partData[1] .. " (" .. partData[3] .. ")"
        button.Font = Enum.Font.Gotham
        button.TextSize = 11
        button.Parent = builderScrollFrame
        
        button.MouseButton1Click:Connect(function()
            selectedBuilderPartType = i
            for j, btn in ipairs(builderScrollFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = j == i and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(80, 80, 80)
                end
            end
        end)
    end
    
    builderScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #partTypes * 25)
end

local function ToggleBuilderTools()
    builderModeActive = not builderModeActive
    
    if builderModeActive then
        BuilderToolsButton.Text = "BUILDER TOOLS: ON"
        BuilderToolsButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        ShowNotification("Builder Tools", "Builder tools activated!")
        
        -- Tampilkan GUI builder tools di bawah daftar visual tools
        BuilderToolsGUISection.Visible = true
        
        -- Inisialisasi GUI jika belum diinisialisasi
        if builderScrollFrame:GetChildren() == 0 then
            InitializeBuilderGUI()
        end
        
        -- Aktifkan mode builder (seperti memegang tool)
        local mouse = localPlayer:GetMouse()
        
        if builderMouseConnection then
            builderMouseConnection:Disconnect()
        end
        
        builderMouseConnection = mouse.Button1Down:Connect(function()
            if not builderModeActive then return end
            
            local hit = mouse.Hit
            if hit then
                local newPart = createPart(selectedBuilderPartType, hit.p + Vector3.new(0, partTypes[selectedBuilderPartType][2].Y/2, 0))
                table.insert(placedParts, {
                    Parts = {newPart},
                    Type = "Place"
                })
                UpdateBuilderUndoButtons()
            end
        end)
        
    else
        BuilderToolsButton.Text = "BUILDER TOOLS: OFF"
        BuilderToolsButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        ShowNotification("Builder Tools", "Builder tools deactivated!")
        
        -- Nonaktifkan mode builder (seperti melepas tool)
        if builderMouseConnection then
            builderMouseConnection:Disconnect()
            builderMouseConnection = nil
        end
        
        -- Sembunyikan GUI builder tools
        BuilderToolsGUISection.Visible = false
        BuilderUndoRedoFrame.Visible = false
    end
end

-- =================================================================
-- AFK ANTI-KICK FUNCTIONS (BARU)
-- =================================================================

local function EnableAntiAFK()
    AFKSystem.Enabled = true
    AntiAFKButton.Text = "ANTI AFK: ON"
    AntiAFKButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    AFKStatusLabel.Text = "Anti AFK Mode Active\nPreventing kick..."
    AFKStatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    -- Simulasi aktivitas mouse untuk mencegah AFK
    spawn(function()
        local mouse = localPlayer:GetMouse()
        while AFKSystem.Enabled do
            wait(30) -- Setiap 30 detik
            
            if AFKSystem.Enabled then
                -- Simulasi gerakan mouse kecil
                local currentPos = Vector2.new(mouse.X, mouse.Y)
                if mousemoverel then
                    mousemoverel(1, 0)
                    wait(0.05)
                    mousemoverel(-1, 0)
                end
                
                AFKSystem.LastActionTime = tick()
                ShowNotification("Anti AFK", "Mouse moved to prevent AFK kick")
            end
        end
    end)
end

local function DisableAntiAFK()
    AFKSystem.Enabled = false
    AntiAFKButton.Text = "ANTI AFK: OFF"
    AntiAFKButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    AFKStatusLabel.Text = "Anti AFK Mode Inactive"
    AFKStatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
end

local function Jump()
    local character = localPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

local function EnableAutoJump()
    AFKSystem.AutoJumpEnabled = true
    AutoJumpButton.Text = "AUTO JUMP: ON"
    AutoJumpButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    
    -- Validasi interval
    local interval = tonumber(JumpIntervalBox.Text)
    if not interval or interval > 20 or interval < 1 then
        interval = 5
        JumpIntervalBox.Text = "5"
    end
    
    AFKSystem.AutoJumpInterval = interval
    
    AFKStatusLabel.Text = "Auto Jump Active\nJumping every " .. interval .. " minutes"
    AFKStatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    -- Auto jump loop
    spawn(function()
        while AFKSystem.AutoJumpEnabled do
            wait(interval * 60) -- Convert menit ke detik
            
            if AFKSystem.AutoJumpEnabled and AFKSystem.Enabled then
                Jump()
                ShowNotification("Auto Jump", "Auto jump to prevent AFK kick")
                AFKSystem.LastActionTime = tick()
            end
        end
    end)
end

local function DisableAutoJump()
    AFKSystem.AutoJumpEnabled = false
    AutoJumpButton.Text = "AUTO JUMP: OFF"
    AutoJumpButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    if AFKSystem.Enabled then
        AFKStatusLabel.Text = "Only Anti AFK Mode Active"
    else
        AFKStatusLabel.Text = "System Ready"
    end
end

-- =================================================================
-- AI CHAT BOT FRAME (100% KODE ASLI ANDA TANPA MODIFIKASI)
-- =================================================================
local AIFrame = Instance.new("ScrollingFrame", ContentFrame)
AIFrame.Size = UDim2.new(1, 0, 1, 0)
AIFrame.BackgroundTransparency = 1
AIFrame.ScrollBarThickness = 8
AIFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
AIFrame.ScrollingDirection = Enum.ScrollingDirection.Y
AIFrame.Visible = false
AIFrame.Name = "AIFrame"

local AIContent = Instance.new("Frame", AIFrame)
AIContent.Size = UDim2.new(1, 0, 0, 500)
AIContent.BackgroundTransparency = 1
AIContent.Name = "AIContent"

local AISection = Instance.new("Frame", AIContent)
AISection.Size = UDim2.new(1, -10, 0, 480)
AISection.Position = UDim2.new(0, 5, 0, 5)
AISection.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
AISection.Name = "AISection"
Instance.new("UICorner", AISection).CornerRadius = UDim.new(0, 8)

-- AI Title
local AITitle = Instance.new("TextLabel", AISection)
AITitle.Size = UDim2.new(1, 0, 0, 30)
AITitle.Position = UDim2.new(0, 0, 0, 5)
AITitle.BackgroundTransparency = 1
AITitle.Text = "🤖 LUNARSCRIPT AI CHAT BOT"
AITitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AITitle.Font = Enum.Font.GothamBold
AITitle.TextSize = 14
AITitle.TextXAlignment = Enum.TextXAlignment.Center

-- Chat Messages Area
local MessagesContainer = Instance.new("ScrollingFrame", AISection)
MessagesContainer.Size = UDim2.new(1, -20, 0, 250)
MessagesContainer.Position = UDim2.new(0, 10, 0, 40)
MessagesContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MessagesContainer.BorderSizePixel = 0
MessagesContainer.ScrollBarThickness = 6
MessagesContainer.CanvasSize = UDim2.new(0, 0, 0, 100)
MessagesContainer.ScrollingDirection = Enum.ScrollingDirection.Y
MessagesContainer.Name = "MessagesContainer"
Instance.new("UICorner", MessagesContainer).CornerRadius = UDim.new(0, 6)

-- Container untuk semua pesan
local MessagesList = Instance.new("Frame", MessagesContainer)
MessagesList.Size = UDim2.new(1, 0, 0, 0)
MessagesList.BackgroundTransparency = 1
MessagesList.Name = "MessagesList"

-- UIListLayout untuk menyusun pesan secara vertikal
local MessagesLayout = Instance.new("UIListLayout", MessagesList)
MessagesLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
MessagesLayout.VerticalAlignment = Enum.VerticalAlignment.Top
MessagesLayout.SortOrder = Enum.SortOrder.LayoutOrder
MessagesLayout.Padding = UDim.new(0, 10)

-- Input Area
local InputSection = Instance.new("Frame", AISection)
InputSection.Size = UDim2.new(1, -20, 0, 100)
InputSection.Position = UDim2.new(0, 10, 0, 300)
InputSection.BackgroundTransparency = 1
InputSection.Name = "InputSection"

local InputTextBox = Instance.new("TextBox", InputSection)
InputTextBox.Size = UDim2.new(1, 0, 0, 70)
InputTextBox.Position = UDim2.new(0, 0, 0, 0)
InputTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
InputTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputTextBox.Font = Enum.Font.Gotham
InputTextBox.TextSize = 12
InputTextBox.PlaceholderText = "Type your message here... (Press Enter to send)"
InputTextBox.Text = ""
InputTextBox.TextWrapped = true
InputTextBox.ClearTextOnFocus = false
InputTextBox.Name = "InputTextBox"
Instance.new("UICorner", InputTextBox).CornerRadius = UDim.new(0, 6)

local SendButton = Instance.new("TextButton", InputSection)
SendButton.Size = UDim2.new(1, 0, 0, 30)
SendButton.Position = UDim2.new(0, 0, 0, 75)
SendButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.Text = "SEND MESSAGE"
SendButton.Font = Enum.Font.GothamBold
SendButton.TextSize = 14
SendButton.AutoButtonColor = true
SendButton.Name = "SendButton"
Instance.new("UICorner", SendButton).CornerRadius = UDim.new(0, 6)

-- Status Area
local StatusSection = Instance.new("Frame", AISection)
StatusSection.Size = UDim2.new(1, -20, 0, 40)
StatusSection.Position = UDim2.new(0, 10, 0, 410)
StatusSection.BackgroundTransparency = 1
StatusSection.Name = "StatusSection"

local StatusLabel = Instance.new("TextLabel", StatusSection)
StatusLabel.Size = UDim2.new(0.6, 0, 1, 0)
StatusLabel.Position = UDim2.new(0, 0, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Ready to connect"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 13
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Name = "StatusLabel"

local TestConnectionButton = Instance.new("TextButton", StatusSection)
TestConnectionButton.Size = UDim2.new(0.35, 0, 0, 30)
TestConnectionButton.Position = UDim2.new(0.63, 0, 0.5, -15)
TestConnectionButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
TestConnectionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TestConnectionButton.Text = "TEST CONNECTION"
TestConnectionButton.Font = Enum.Font.GothamBold
TestConnectionButton.TextSize = 12
TestConnectionButton.Name = "TestConnectionButton"
Instance.new("UICorner", TestConnectionButton).CornerRadius = UDim.new(0, 6)

-- Creator Info in AI Section
local AICreatorInfo = Instance.new("TextLabel", AISection)
AICreatorInfo.Size = UDim2.new(1, 0, 0, 20)
AICreatorInfo.Position = UDim2.new(0, 0, 0, 455)
AICreatorInfo.BackgroundTransparency = 1
AICreatorInfo.Text = "Created by DarkLua_script & h4000_audio8 • Powered by LunarScript AI"
AICreatorInfo.TextColor3 = Color3.fromRGB(150, 150, 200)
AICreatorInfo.Font = Enum.Font.Gotham
AICreatorInfo.TextSize = 11
AICreatorInfo.TextXAlignment = Enum.TextXAlignment.Center

-- =================================================================
-- AI CHAT FUNCTIONS (100% KODE ASLI ANDA TANPA MODIFIKASI)
-- =================================================================

-- Fungsi untuk menambahkan pesan dengan layout vertikal
local function AddMessageToChatVertical(sender, messageText)
    if not messageText or messageText == "" then return end
    
    -- Buat frame untuk pesan
    local messageFrame = Instance.new("Frame")
    messageFrame.BackgroundTransparency = 1
    messageFrame.Size = UDim2.new(0.95, 0, 0, 0)
    messageFrame.LayoutOrder = #MessagesList:GetChildren()
    messageFrame.Parent = MessagesList
    
    -- Tentukan warna berdasarkan pengirim
    local backgroundColor, textColor
    if sender == "user" then
        backgroundColor = Color3.fromRGB(0, 120, 215)  -- Biru untuk user
        textColor = Color3.fromRGB(255, 255, 255)
    else
        backgroundColor = Color3.fromRGB(60, 60, 80)   -- Abu-abu untuk AI
        textColor = Color3.fromRGB(255, 255, 255)
    end
    
    -- Buat background untuk pesan
    local messageBackground = Instance.new("Frame")
    messageBackground.BackgroundColor3 = backgroundColor
    messageBackground.Size = UDim2.new(1, 0, 0, 0)
    messageBackground.Parent = messageFrame
    
    local corner = Instance.new("UICorner", messageBackground)
    corner.CornerRadius = UDim.new(0, 12)
    
    -- Tambahkan ikon pengirim
    local senderIcon = Instance.new("TextLabel")
    senderIcon.Size = UDim2.new(0, 30, 0, 30)
    senderIcon.Position = UDim2.new(0, 8, 0, 8)
    senderIcon.BackgroundTransparency = 1
    senderIcon.Text = sender == "user" and "👤" or "🤖"
    senderIcon.TextColor3 = textColor
    senderIcon.Font = Enum.Font.GothamBold
    senderIcon.TextSize = 16
    senderIcon.TextXAlignment = Enum.TextXAlignment.Center
    senderIcon.Parent = messageBackground
    
    -- Buat label untuk teks pesan
    local messageLabel = Instance.new("TextLabel")
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextColor3 = textColor
    messageLabel.Text = (sender == "user" and "You: " or "AI: ") .. messageText
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 12
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = messageBackground
    
    -- Hitung ukuran teks yang dibutuhkan
    local maxWidth = MessagesContainer.AbsoluteSize.X * 0.95 - 50
    local textSize = TextService:GetTextSize(
        messageLabel.Text,
        12,
        Enum.Font.Gotham,
        Vector2.new(maxWidth, math.huge)
    )
    
    -- Atur ukuran frame berdasarkan teks
    local messageHeight = math.max(50, textSize.Y + 20)
    local messageWidth = math.min(maxWidth + 60, textSize.X + 80)
    
    messageLabel.Size = UDim2.new(1, -50, 0, textSize.Y)
    messageLabel.Position = UDim2.new(0, 50, 0, 10)
    
    messageBackground.Size = UDim2.new(0, messageWidth + 60, 0, messageHeight)
    messageFrame.Size = UDim2.new(0.95, 0, 0, messageHeight + 10)
    
    -- Update ukuran canvas scrolling
    local totalHeight = 0
    for _, child in ipairs(MessagesList:GetChildren()) do
        if child:IsA("Frame") then
            totalHeight = totalHeight + child.Size.Y.Offset + 10
        end
    end
    
    MessagesContainer.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
    
    -- Auto-scroll ke bawah
    wait(0.1)
    MessagesContainer.CanvasPosition = Vector2.new(0, MessagesContainer.CanvasSize.Y.Offset)
    
    return messageFrame
end

-- Fungsi untuk menampilkan welcome message
local function AddWelcomeMessage()
    local welcomeFrame = Instance.new("Frame")
    welcomeFrame.BackgroundTransparency = 1
    welcomeFrame.Size = UDim2.new(0.95, 0, 0, 0)
    welcomeFrame.LayoutOrder = 1
    welcomeFrame.Parent = MessagesList
    
    local welcomeBackground = Instance.new("Frame")
    welcomeBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    welcomeBackground.Size = UDim2.new(1, 0, 0, 0)
    welcomeBackground.Parent = welcomeFrame
    
    local corner = Instance.new("UICorner", welcomeBackground)
    corner.CornerRadius = UDim.new(0, 12)
    
    local welcomeIcon = Instance.new("TextLabel")
    welcomeIcon.Size = UDim2.new(0, 30, 0, 30)
    welcomeIcon.Position = UDim2.new(0, 8, 0, 8)
    welcomeIcon.BackgroundTransparency = 1
    welcomeIcon.Text = "🤖"
    welcomeIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeIcon.Font = Enum.Font.GothamBold
    welcomeIcon.TextSize = 16
    welcomeIcon.TextXAlignment = Enum.TextXAlignment.Center
    welcomeIcon.Parent = welcomeBackground
    
    local welcomeText = "Welcome to LunarScript AI Chat Bot!\n\n• Powered by LunarScript AI\n• Created by DarkLua_script & h4000_audio8\n• Click 'TEST CONNECTION' to verify API\n• Type your message and click SEND"
    
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeLabel.Text = welcomeText
    welcomeLabel.Font = Enum.Font.Gotham
    welcomeLabel.TextSize = 12
    welcomeLabel.TextWrapped = true
    welcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
    welcomeLabel.Parent = welcomeBackground
    
    local maxWidth = MessagesContainer.AbsoluteSize.X * 0.95 - 50
    local textSize = TextService:GetTextSize(
        welcomeText,
        12,
        Enum.Font.Gotham,
        Vector2.new(maxWidth, math.huge)
    )
    
    welcomeLabel.Size = UDim2.new(1, -50, 0, textSize.Y)
    welcomeLabel.Position = UDim2.new(0, 50, 0, 10)
    
    welcomeBackground.Size = UDim2.new(0, maxWidth + 60, 0, textSize.Y + 20)
    welcomeFrame.Size = UDim2.new(0.95, 0, 0, textSize.Y + 30)
    
    MessagesContainer.CanvasSize = UDim2.new(0, 0, 0, textSize.Y + 40)
end

-- HTTP Request function for AI API (100% KODE ASLI ANDA)
local function MakeAIRequest(prompt)
    print("🌐 Sending request to LunarScript AI API...")
    
    -- Try different HTTP methods
    local methods = {
        function()
            -- Method 1: Simple GET with parameters
            local encodedPrompt = HttpService:UrlEncode(prompt)
            local url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent" ..
                       "?key=" .. AIChat.API_KEY ..
                       "&prompt=" .. encodedPrompt
            
            local success, result = pcall(function()
                return game:HttpGet(url, true)
            end)
            return success and result or nil
        end,
        function()
            -- Method 2: Using request library if available
            if request then
                local url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" .. AIChat.API_KEY
                local body = HttpService:JSONEncode({
                    contents = {{parts = {{text = prompt}}}},
                    generationConfig = {temperature = 0.7, maxOutputTokens = 1000}
                })
                
                local success, result = pcall(function()
                    return request({
                        Url = url,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = body
                    })
                end)
                return success and result.Body or nil
            end
        end
    }
    
    for _, method in ipairs(methods) do
        local response = method()
        if response then
            print("✅ Received API response")
            
            -- Parse response
            local success, data = pcall(function()
                return HttpService:JSONDecode(response)
            end)
            
            if success and data and data.candidates and data.candidates[1] then
                return data.candidates[1].content.parts[1].text
            end
        end
    end
    
    return nil
end

-- Test connection function (100% KODE ASLI ANDA)
local function TestAIConnection()
    StatusLabel.Text = "Status: Testing LunarScript AI API..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    TestConnectionButton.Text = "TESTING..."
    TestConnectionButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    spawn(function()
        local testPrompt = "Say 'LunarScript AI is connected successfully!'"
        
        local success, response = pcall(function()
            return MakeAIRequest(testPrompt)
        end)
        
        if success and response then
            AIChat.IsConnected = true
            StatusLabel.Text = "Status: Connected to LunarScript AI!"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            TestConnectionButton.Text = "CONNECTED ✓"
            TestConnectionButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            
            AddMessageToChatVertical("ai", "✅ Successfully connected to LunarScript AI! I'm ready to help you!")
            ShowNotification("AI Connected", "LunarScript AI connection established!")
        else
            StatusLabel.Text = "Status: Connection Failed"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            TestConnectionButton.Text = "RETRY CONNECTION"
            TestConnectionButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            
            AddMessageToChatVertical("ai", "❌ Failed to connect to LunarScript AI. Please check your API key and internet connection.")
        end
    end)
end

-- Send message function (100% KODE ASLI ANDA)
local function SendMessageToAI()
    if not AIChat.IsConnected then
        AddMessageToChatVertical("ai", "⚠️ Please click 'TEST CONNECTION' first to verify API access.")
        return
    end
    
    local message = InputTextBox.Text:gsub("^%s*(.-)%s*$", "%1")
    if message == "" then return end
    
    -- Add user message
    AddMessageToChatVertical("user", message)
    InputTextBox.Text = ""
    SendButton.Text = "PROCESSING..."
    SendButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    StatusLabel.Text = "Status: AI is thinking..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    
    InputTextBox.TextEditable = false
    
    spawn(function()
        local success, response = pcall(function()
            return MakeAIRequest(message)
        end)
        
        -- Re-enable input
        InputTextBox.TextEditable = true
        SendButton.Text = "SEND MESSAGE"
        SendButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        if success and response then
            AddMessageToChatVertical("ai", response)
            StatusLabel.Text = "Status: Ready"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            -- Save to history
            table.insert(AIChat.ChatHistory, {role = "user", content = message})
            table.insert(AIChat.ChatHistory, {role = "assistant", content = response})
            AIChat.LastResponse = response
        else
            AddMessageToChatVertical("ai", "⚠️ Sorry, I couldn't process your request. Please try again.")
            StatusLabel.Text = "Status: Error occurred"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

-- =================================================================
-- WINDOW CONTROLS SYSTEM
-- =================================================================

local OceanBackground = Instance.new("Frame",Z)
OceanBackground.Size = UDim2.new(1,0,1,0)
OceanBackground.BackgroundColor3 = M.ocean.backgroundColor;
OceanBackground.Visible = false;
OceanBackground.ZIndex = 0;

local OceanGradient = Instance.new("UIGradient",OceanBackground)
OceanGradient.Rotation = 45;
OceanGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,100,160)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,150,220)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,120,190))
})

local NightBackground = Instance.new("Frame",Z)
NightBackground.Size = UDim2.new(1,0,1,0)
NightBackground.BackgroundColor3 = M.night.backgroundColor;
NightBackground.Visible = true;
NightBackground.ZIndex = 0;

local function CreateStars()
    for i=1,15 do 
        local star = Instance.new("Frame",NightBackground)
        star.Size = UDim2.new(0,math.random(2,4),0,math.random(2,4))
        star.Position = UDim2.new(0,math.random(0,500),0,math.random(0,350))
        star.BackgroundColor3 = Color3.fromRGB(255,255,255)
        star.BorderSizePixel = 0;
        star.ZIndex = 1;
        spawn(function()
            while star.Parent do 
                local transparency = math.random(0,100)/100;
                star.BackgroundTransparency = transparency;
                wait(math.random(0.5,2))
            end 
        end)
    end 
end;

CreateStars()

local MinimizedButton = Instance.new("ImageButton",J)
MinimizedButton.Size = UDim2.new(0,75,0,75)
MinimizedButton.Position = UDim2.new(0.5,-37.5,0,10)
MinimizedButton.BackgroundTransparency = 1
MinimizedButton.Image = "rbxassetid://84811902418513"
MinimizedButton.Visible = false;
MinimizedButton.Active = true;
MinimizedButton.Draggable = true;
local MinimizedCorner = Instance.new("UICorner", MinimizedButton)
MinimizedCorner.CornerRadius = UDim.new(1, 0)

local CloseDialog = Instance.new("Frame",J)
CloseDialog.Size = UDim2.new(0,300,0,150)
CloseDialog.Position = UDim2.new(0.5,-150,0.5,-75)
CloseDialog.BackgroundColor3 = Color3.fromRGB(40,40,50)
CloseDialog.Visible = false;
CloseDialog.ZIndex = 10;
Instance.new("UICorner",CloseDialog).CornerRadius = UDim.new(0,12)

local CloseDialogTitle = Instance.new("TextLabel",CloseDialog)
CloseDialogTitle.Size = UDim2.new(1,0,0.4,0)
CloseDialogTitle.BackgroundTransparency = 1;
CloseDialogTitle.Text = "Close the window?"
CloseDialogTitle.TextColor3 = Color3.fromRGB(255,255,255)
CloseDialogTitle.Font = Enum.Font.GothamBold;
CloseDialogTitle.TextSize = 16;
CloseDialogTitle.ZIndex = 11;

local CloseDialogNo = Instance.new("TextButton",CloseDialog)
CloseDialogNo.Size = UDim2.new(0.4,0,0.3,0)
CloseDialogNo.Position = UDim2.new(0.05,0,0.5,0)
CloseDialogNo.BackgroundColor3 = Color3.fromRGB(60,60,80)
CloseDialogNo.Text = "NO"
CloseDialogNo.TextColor3 = Color3.fromRGB(255,255,255)
CloseDialogNo.Font = Enum.Font.Gotham;
CloseDialogNo.TextSize = 12;
CloseDialogNo.ZIndex = 11;
Instance.new("UICorner",CloseDialogNo).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",CloseDialogNo).Color = Color3.fromRGB(255,255,255)

local CloseDialogYes = Instance.new("TextButton",CloseDialog)
CloseDialogYes.Size = UDim2.new(0.4,0,0.3,0)
CloseDialogYes.Position = UDim2.new(0.55,0,0.5,0)
CloseDialogYes.BackgroundColor3 = Color3.fromRGB(220,20,60)
CloseDialogYes.Text = "CLOSE WINDOW"
CloseDialogYes.TextColor3 = Color3.fromRGB(255,255,255)
CloseDialogYes.Font = Enum.Font.Gotham;
CloseDialogYes.TextSize = 12;
CloseDialogYes.ZIndex = 11;
Instance.new("UICorner",CloseDialogYes).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",CloseDialogYes).Color = Color3.fromRGB(255,255,255)

local function ApplyTheme()
    local currentTheme = M[N]
    Z.BackgroundColor3 = currentTheme.backgroundColor;
    TopBar.BackgroundColor3 = currentTheme.topBarColor;
    local navigationButtons = {MainButton,InfoButton,SettingsButton,ToolsButton,MultiTeleportButton,AIButton,AFKButton}
    for _,button in pairs(navigationButtons)do 
        button.BackgroundColor3 = currentTheme.buttonColor 
    end;
    if not rgbLineMode then 
        da.Color = currentTheme.topBarColor 
    end;
    OceanBackground.Visible = N=="ocean"
    NightBackground.Visible = N=="night"
end;

local function updateNavPanelForMaximize()
    if isMaximized then
        NavigationFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
        NavContainer.Size = UDim2.new(1, 0, 0, 350)
        NavigationFrame.ScrollBarThickness = 8
    else
        NavigationFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
        NavContainer.Size = UDim2.new(1, 0, 0, 350)
        NavigationFrame.ScrollBarThickness = 6
    end
end

local function ToggleMaximize()
    if isMaximized then 
        Z.Size = UDim2.new(0,500,0,350)
        Z.Position = UDim2.new(0.5,-250,0.5,-175)
        MaximizeButton.Text = "□"
        isMaximized = false 
    else 
        Z.Size = UDim2.new(0.9,0,0.8,0)
        Z.Position = UDim2.new(0.05,0,0.1,0)
        MaximizeButton.Text = "❐"
        isMaximized = true 
    end
    updateNavPanelForMaximize()
end;

local function TweenObject(object,properties)
    local tweenInfo = TweenInfo.new(0.3,Enum.EasingStyle.Quad)
    local tween = TweenService:Create(object,tweenInfo,properties)
    tween:Play()
end;

local function ShowCloseDialog()
    C = true;
    ApplyBlur()
    local tweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    local tween = TweenService:Create(Z,tweenInfo,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)})
    tween:Play()
    tween.Completed:Wait()
    Z.Visible = false;
    CloseDialog.Visible = true 
end;

local function RestoreWindow()
    Z.Visible = true;
    Z.Size = UDim2.new(0,0,0,0)
    Z.Position = UDim2.new(0.5,0,0.5,0)
    local tweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    local tween = TweenService:Create(Z,tweenInfo,{Size=UDim2.new(0,500,0,350),Position=UDim2.new(0.5,-250,0.5,-175)})
    tween:Play()
    CloseDialog.Visible = false;
    RemoveBlur()
    C = false 
    updateNavPanelForMaximize()
end;

local function CloseScript()
    RemoveBlur()
    J:Destroy()
    K:Destroy()
end;

-- =================================================================
-- TOMBOL COPY GAME LINK
-- =================================================================
CopyGameLinkButton.MouseButton1Click:Connect(function()
    local gameLink = "https://www.roblox.com/games/" .. game.PlaceId
    CopyToClipboard(gameLink)
    ShowNotification("Game Link", "Game link copied to clipboard!\n" .. gameLink)
end)

-- =================================================================
-- GOD MODE FUNCTIONS
-- =================================================================
local function EnableGodmode(enable)
    if enable then
        if not character or not character.Parent then return end
        
        local oldFF = character:FindFirstChild("LunarGodmodeForcefield")
        if oldFF then
            oldFF:Destroy()
        end
        
        local forcefield = Instance.new("ForceField")
        forcefield.Name = "LunarGodmodeForcefield"
        forcefield.Visible = true
        forcefield.Parent = character
        
        ShowNotification("God Mode", "Visual God Mode activated! (Visual effect only)")
    else
        local ff = character:FindFirstChild("LunarGodmodeForcefield")
        if ff then
            ff:Destroy()
        end
        ShowNotification("God Mode", "Visual God Mode deactivated!")
    end
end

localPlayer.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    
    if godModeEnabled then
        wait(2)
        EnableGodmode(true)
    end
end)

-- =================================================================
-- MULTI TELEPORT FUNCTIONS (DIMODIFIKASI DENGAN KECEPATAN DAN DELAY)
-- =================================================================
local function CreateMarker(position, index)
    if MultiTeleport.Markers[index] then
        MultiTeleport.Markers[index]:Destroy()
    end
    
    local point = Instance.new("Part")
    point.Name = "TeleportMarker_" .. index
    point.Size = Vector3.new(2, 2, 2)
    point.Position = position
    point.Anchored = true
    point.CanCollide = false
    point.Material = Enum.Material.Neon
    point.BrickColor = BrickColor.new("Bright red")
    point.Shape = Enum.PartType.Ball
    point.Parent = workspace
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "MarkerInfo"
    billboard.Size = UDim2.new(0, 200, 0, 100)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = point
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 1, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "Coordinate " .. index .. "\nX: " .. math.floor(position.X) .. "\nY: " .. math.floor(position.Y) .. "\nZ: " .. math.floor(position.Z)
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.TextSize = 14
    infoLabel.TextStrokeTransparency = 0
    infoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    infoLabel.Parent = billboard
    
    MultiTeleport.Markers[index] = point
    return point
end

local function UpdateCoordinatesList()
    CoordinatesListTitle.Text = "SAVED COORDINATES (" .. #MultiTeleport.Coordinates .. "/" .. MultiTeleport.MaxCoordinates .. ")"
    
    for _, child in ipairs(CoordinatesList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    CoordinatesList.CanvasSize = UDim2.new(0, 0, 0, #MultiTeleport.Coordinates * 30)
    
    for i, coord in ipairs(MultiTeleport.Coordinates) do
        local coordFrame = Instance.new("Frame")
        coordFrame.Size = UDim2.new(1, 0, 0, 25)
        coordFrame.Position = UDim2.new(0, 0, 0, (i-1)*30)
        coordFrame.BackgroundColor3 = i % 2 == 0 and Color3.fromRGB(60, 60, 70) or Color3.fromRGB(50, 50, 60)
        coordFrame.BackgroundTransparency = 0.5
        coordFrame.Parent = CoordinatesList
        
        local coordText = Instance.new("TextLabel")
        coordText.Size = UDim2.new(1, -10, 1, 0)
        coordText.Position = UDim2.new(0, 5, 0, 0)
        coordText.BackgroundTransparency = 1
        coordText.Text = i .. ". X: " .. math.floor(coord.X) .. " Y: " .. math.floor(coord.Y) .. " Z: " .. math.floor(coord.Z)
        coordText.TextColor3 = Color3.fromRGB(255, 255, 255)
        coordText.Font = Enum.Font.Gotham
        coordText.TextSize = 11
        coordText.TextXAlignment = Enum.TextXAlignment.Left
        coordText.Parent = coordFrame
        
        -- TOMBOL DELETE HANYA MUNCUL JIKA ADA ITEM
        if coord and workspace:FindFirstChild("TeleportMarker_" .. i) then
            local deleteButton = Instance.new("TextButton")
            deleteButton.Size = UDim2.new(0, 60, 0, 20)
            deleteButton.Position = UDim2.new(1, -65, 0.5, -10)
            deleteButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            deleteButton.Text = "DELETE"
            deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            deleteButton.Font = Enum.Font.Gotham
            deleteButton.TextSize = 10
            deleteButton.Parent = coordFrame
            
            local deleteButtonCorner = Instance.new("UICorner")
            deleteButtonCorner.CornerRadius = UDim.new(0, 4)
            deleteButtonCorner.Parent = deleteButton
            
            deleteButton.MouseButton1Click:Connect(function()
                table.remove(MultiTeleport.Coordinates, i)
                if MultiTeleport.Markers[i] then
                    MultiTeleport.Markers[i]:Destroy()
                    MultiTeleport.Markers[i] = nil
                end
                UpdateCoordinatesList()
                ShowNotification("Multi Teleport", "Coordinate " .. i .. " deleted!")
            end)
        end
    end
end

local function SetCoordinate()
    if #MultiTeleport.Coordinates >= MultiTeleport.MaxCoordinates then
        ShowNotification("Multi Teleport", "Maximum coordinates reached! (" .. MultiTeleport.MaxCoordinates .. ")")
        return
    end
    
    local character = localPlayer.Character
    if not character then
        ShowNotification("Multi Teleport", "Character not found!")
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        ShowNotification("Multi Teleport", "HumanoidRootPart not found!")
        return
    end
    
    local position = humanoidRootPart.Position
    
    table.insert(MultiTeleport.Coordinates, position)
    
    CreateMarker(position, #MultiTeleport.Coordinates)
    
    XTextBox.Text = tostring(math.floor(position.X))
    YTextBox.Text = tostring(math.floor(position.Y))
    ZTextBox.Text = tostring(math.floor(position.Z))
    
    UpdateCoordinatesList()
    ShowNotification("Multi Teleport", "Coordinate " .. #MultiTeleport.Coordinates .. " set! (" .. math.floor(position.X) .. ", " .. math.floor(position.Y) .. ", " .. math.floor(position.Z) .. ")")
end

local function TeleportToCoordinates()
    if #MultiTeleport.Coordinates == 0 then
        ShowNotification("Multi Teleport", "No coordinates set!")
        return
    end
    
    local character = localPlayer.Character
    if not character then
        ShowNotification("Multi Teleport", "Character not found!")
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        ShowNotification("Multi Teleport", "HumanoidRootPart not found!")
        return
    end
    
    -- Ambil kecepatan teleport dari textbox
    local speed = tonumber(SpeedTextBox.Text) or 1
    if speed < 1 then speed = 1 end
    if speed > 10 then speed = 10 end
    
    -- Ambil delay dari textbox
    local delay = tonumber(DelayTextBox.Text) or 1.0
    if delay < 0.10 then delay = 0.10 end
    if delay > 60 then delay = 60 end
    
    -- Update speed dan delay di sistem
    MultiTeleport.TeleportSpeed = speed
    MultiTeleport.Delay = delay
    
    ShowNotification("Multi Teleport", "Teleporting to " .. #MultiTeleport.Coordinates .. " coordinates...\nSpeed: " .. speed .. " | Delay: " .. delay .. "s")
    
    for i = #MultiTeleport.Coordinates, 1, -1 do
        local coord = MultiTeleport.Coordinates[i]
        humanoidRootPart.CFrame = CFrame.new(coord)
        ShowNotification("Multi Teleport", "Teleported to coordinate " .. i .. "\nSpeed: " .. speed .. " | Delay: " .. delay .. "s")
        wait(delay) -- Menggunakan delay yang bisa disesuaikan
    end
    
    ShowNotification("Multi Teleport", "Teleportation complete!\nUsed speed: " .. speed .. " | Delay: " .. delay .. "s")
end

local function UndoCoordinate()
    if #MultiTeleport.Coordinates == 0 then
        ShowNotification("Multi Teleport", "No coordinates to undo!")
        return
    end
    
    local lastCoord = table.remove(MultiTeleport.Coordinates)
    table.insert(MultiTeleport.History, lastCoord)
    
    local markerIndex = #MultiTeleport.Coordinates + 1
    if MultiTeleport.Markers[markerIndex] then
        MultiTeleport.Markers[markerIndex]:Destroy()
        MultiTeleport.Markers[markerIndex] = nil
    end
    
    UpdateCoordinatesList()
    ShowNotification("Multi Teleport", "Coordinate " .. markerIndex .. " undone!")
end

local function RedoCoordinate()
    if #MultiTeleport.History == 0 then
        ShowNotification("Multi Teleport", "No coordinates to redo!")
        return
    end
    
    local coord = table.remove(MultiTeleport.History)
    table.insert(MultiTeleport.Coordinates, coord)
    
    CreateMarker(coord, #MultiTeleport.Coordinates)
    
    UpdateCoordinatesList()
    ShowNotification("Multi Teleport", "Coordinate " .. #MultiTeleport.Coordinates .. " redone!")
end

local function ClearAllCoordinates()
    if #MultiTeleport.Coordinates == 0 then
        ShowNotification("Multi Teleport", "No coordinates to clear!")
        return
    end
    
    for _, marker in pairs(MultiTeleport.Markers) do
        if marker then
            marker:Destroy()
        end
    end
    
    MultiTeleport.Markers = {}
    MultiTeleport.Coordinates = {}
    MultiTeleport.History = {}
    MultiTeleport.RedoHistory = {}
    
    UpdateCoordinatesList()
    ShowNotification("Multi Teleport", "All coordinates cleared!")
end

-- =================================================================
-- FUNGSI UNTUK TOMBOL DELAY (TAMBAHAN BARU)
-- =================================================================
local function UpdateDelay(value)
    local current = tonumber(DelayTextBox.Text) or 1.0
    local newValue = current + value
    
    -- Batasi antara 0.10 dan 60
    if newValue < 0.10 then newValue = 0.10 end
    if newValue > 60 then newValue = 60 end
    
    -- Format ke 2 angka desimal
    newValue = math.floor(newValue * 100) / 100
    
    DelayTextBox.Text = string.format("%.2f", newValue)
    MultiTeleport.Delay = newValue
    
    ShowNotification("Multi Teleport", "Delay set to " .. string.format("%.2f", newValue) .. " seconds")
end

-- =================================================================
-- NAVIGATION SYSTEM (DITAMBAH AFK)
-- =================================================================
local function ShowMain()
    MainContentFrame.Visible = true
    InfoFrame.Visible = false
    SettingsFrame.Visible = false
    ToolsFrame.Visible = false
    MultiTeleportFrame.Visible = false
    AIFrame.Visible = false
    AFKFrame.Visible = false
    MainButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    InfoButton.BackgroundColor3 = M.night.buttonColor
    SettingsButton.BackgroundColor3 = M.night.buttonColor
    ToolsButton.BackgroundColor3 = M.night.buttonColor
    MultiTeleportButton.BackgroundColor3 = M.night.buttonColor
    AIButton.BackgroundColor3 = M.night.buttonColor
    AFKButton.BackgroundColor3 = M.night.buttonColor
end

local function ShowInfo()
    MainContentFrame.Visible = false
    InfoFrame.Visible = true
    SettingsFrame.Visible = false
    ToolsFrame.Visible = false
    MultiTeleportFrame.Visible = false
    AIFrame.Visible = false
    AFKFrame.Visible = false
    InfoButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    MainButton.BackgroundColor3 = M.night.buttonColor
    SettingsButton.BackgroundColor3 = M.night.buttonColor
    ToolsButton.BackgroundColor3 = M.night.buttonColor
    MultiTeleportButton.BackgroundColor3 = M.night.buttonColor
    AIButton.BackgroundColor3 = M.night.buttonColor
    AFKButton.BackgroundColor3 = M.night.buttonColor
end

local function ShowSettings()
    MainContentFrame.Visible = false
    InfoFrame.Visible = false
    SettingsFrame.Visible = true
    ToolsFrame.Visible = false
    MultiTeleportFrame.Visible = false
    AIFrame.Visible = false
    AFKFrame.Visible = false
    SettingsButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    MainButton.BackgroundColor3 = M.night.buttonColor
    InfoButton.BackgroundColor3 = M.night.buttonColor
    ToolsButton.BackgroundColor3 = M.night.buttonColor
    MultiTeleportButton.BackgroundColor3 = M.night.buttonColor
    AIButton.BackgroundColor3 = M.night.buttonColor
    AFKButton.BackgroundColor3 = M.night.buttonColor
end

local function ShowTools()
    MainContentFrame.Visible = false
    InfoFrame.Visible = false
    SettingsFrame.Visible = false
    ToolsFrame.Visible = true
    MultiTeleportFrame.Visible = false
    AIFrame.Visible = false
    AFKFrame.Visible = false
    ToolsButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    MainButton.BackgroundColor3 = M.night.buttonColor
    InfoButton.BackgroundColor3 = M.night.buttonColor
    SettingsButton.BackgroundColor3 = M.night.buttonColor
    MultiTeleportButton.BackgroundColor3 = M.night.buttonColor
    AIButton.BackgroundColor3 = M.night.buttonColor
    AFKButton.BackgroundColor3 = M.night.buttonColor
end

local function ShowMultiTeleport()
    MainContentFrame.Visible = false
    InfoFrame.Visible = false
    SettingsFrame.Visible = false
    ToolsFrame.Visible = false
    MultiTeleportFrame.Visible = true
    AIFrame.Visible = false
    AFKFrame.Visible = false
    MultiTeleportButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    MainButton.BackgroundColor3 = M.night.buttonColor
    InfoButton.BackgroundColor3 = M.night.buttonColor
    SettingsButton.BackgroundColor3 = M.night.buttonColor
    ToolsButton.BackgroundColor3 = M.night.buttonColor
    AIButton.BackgroundColor3 = M.night.buttonColor
    AFKButton.BackgroundColor3 = M.night.buttonColor
end

local function ShowAI()
    MainContentFrame.Visible = false
    InfoFrame.Visible = false
    SettingsFrame.Visible = false
    ToolsFrame.Visible = false
    MultiTeleportFrame.Visible = false
    AIFrame.Visible = true
    AFKFrame.Visible = false
    AIButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    MainButton.BackgroundColor3 = M.night.buttonColor
    InfoButton.BackgroundColor3 = M.night.buttonColor
    SettingsButton.BackgroundColor3 = M.night.buttonColor
    ToolsButton.BackgroundColor3 = M.night.buttonColor
    MultiTeleportButton.BackgroundColor3 = M.night.buttonColor
    AFKButton.BackgroundColor3 = M.night.buttonColor
    
    -- Bersihkan messages container dan tambahkan welcome message
    for _, child in ipairs(MessagesList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    AddWelcomeMessage()
    
    -- Auto-test connection when opening AI tab
    if not AIChat.IsConnected then
        spawn(function()
            wait(1)
            TestAIConnection()
        end)
    end
end

-- TAMBAHAN: Fungsi ShowAFK
local function ShowAFK()
    MainContentFrame.Visible = false
    InfoFrame.Visible = false
    SettingsFrame.Visible = false
    ToolsFrame.Visible = false
    MultiTeleportFrame.Visible = false
    AIFrame.Visible = false
    AFKFrame.Visible = true
    AFKButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    MainButton.BackgroundColor3 = M.night.buttonColor
    InfoButton.BackgroundColor3 = M.night.buttonColor
    SettingsButton.BackgroundColor3 = M.night.buttonColor
    ToolsButton.BackgroundColor3 = M.night.buttonColor
    MultiTeleportButton.BackgroundColor3 = M.night.buttonColor
    AIButton.BackgroundColor3 = M.night.buttonColor
end

-- =================================================================
-- CONNECT EVENT HANDLERS (DITAMBAH AFK DAN TOMBOL DELAY)
-- =================================================================

-- Navigation buttons
MainButton.MouseButton1Click:Connect(ShowMain)
InfoButton.MouseButton1Click:Connect(ShowInfo)
SettingsButton.MouseButton1Click:Connect(ShowSettings)
ToolsButton.MouseButton1Click:Connect(ShowTools)
MultiTeleportButton.MouseButton1Click:Connect(ShowMultiTeleport)
AIButton.MouseButton1Click:Connect(ShowAI)
AFKButton.MouseButton1Click:Connect(ShowAFK) -- TAMBAHAN

-- AI Chat handlers (100% KODE ASLI ANDA)
SendButton.MouseButton1Click:Connect(SendMessageToAI)
TestConnectionButton.MouseButton1Click:Connect(TestAIConnection)

InputTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SendMessageToAI()
    end
end)

-- Enter key support for AI chat
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Return and InputTextBox:IsFocused() then
        SendMessageToAI()
    end
end)

-- Tools handlers
DeletePartButton.MouseButton1Click:Connect(ToggleDeleteMode)

BuilderToolsButton.MouseButton1Click:Connect(ToggleBuilderTools)

DeleteAllMapButton.MouseButton1Click:Connect(function()
    local allParts = {}
    for _, part in ipairs(workspace:GetChildren()) do
        if part:IsA("Part") or part:IsA("WedgePart") then
            table.insert(allParts, part)
        end
    end
    
    if #allParts > 0 then
        table.insert(placedParts, {
            Parts = allParts,
            Type = "DeleteAll"
        })
        
        for _, part in ipairs(allParts) do
            part:Destroy()
        end
        UpdateBuilderUndoButtons()
        ShowNotification("Builder Tools", "All map parts deleted!")
    end
end)

SpawnBaseplateButton.MouseButton1Click:Connect(function()
    local baseplate = Instance.new("Part")
    baseplate.Size = Vector3.new(1000, 35, 1000)
    baseplate.Position = Vector3.new(0, -17.5, 0)
    baseplate.Anchored = true
    baseplate.CanCollide = true
    baseplate.BrickColor = BrickColor.new("Medium stone grey")
    baseplate.Material = Enum.Material.Concrete
    baseplate.Parent = workspace
    
    table.insert(placedParts, {
        Parts = {baseplate},
        Type = "Baseplate"
    })
    UpdateBuilderUndoButtons()
    ShowNotification("Builder Tools", "Baseplate spawned!")
end)

BuilderUndoButton.MouseButton1Click:Connect(function()
    if #placedParts > 0 then
        local lastAction = table.remove(placedParts)
        
        if lastAction.Type == "DeleteAll" then
            -- Undo delete all: restore all parts
            for _, part in ipairs(lastAction.Parts) do
                if part then
                    local newPart = part:Clone()
                    newPart.Parent = workspace
                end
            end
        else
            -- Undo place or baseplate: delete the parts
            for _, part in ipairs(lastAction.Parts) do
                if part and part.Parent then
                    part:Destroy()
                end
            end
        end
        
        UpdateBuilderUndoButtons()
        ShowNotification("Builder Tools", "Undo successful!")
    end
end)

BuilderRedoButton.MouseButton1Click:Connect(function()
    -- Redo functionality can be implemented here if needed
    ShowNotification("Builder Tools", "Redo feature coming soon!")
end)

-- Multi Teleport handlers
SetCoordinateButton.MouseButton1Click:Connect(SetCoordinate)
TeleportAllButton.MouseButton1Click:Connect(TeleportToCoordinates)
UndoButton.MouseButton1Click:Connect(UndoCoordinate)
RedoButton.MouseButton1Click:Connect(RedoCoordinate)
ClearAllButton.MouseButton1Click:Connect(ClearAllCoordinates)

-- TOMBOL DELAY BUTTONS HANDLERS (TAMBAHAN BARU)
DelayDecreaseButton.MouseButton1Click:Connect(function()
    UpdateDelay(-0.10)
end)

DelayIncreaseButton.MouseButton1Click:Connect(function()
    UpdateDelay(0.10)
end)

-- Validasi input kecepatan Multi Teleport
SpeedTextBox.FocusLost:Connect(function()
    local speed = tonumber(SpeedTextBox.Text)
    if not speed or speed < 1 or speed > 10 then
        SpeedTextBox.Text = "1"
        MultiTeleport.TeleportSpeed = 1
        ShowNotification("Multi Teleport", "Speed set to 1 (min: 1, max: 10)")
    else
        MultiTeleport.TeleportSpeed = speed
        ShowNotification("Multi Teleport", "Speed set to " .. speed)
    end
end)

-- Validasi input delay Multi Teleport
DelayTextBox.FocusLost:Connect(function()
    local delay = tonumber(DelayTextBox.Text)
    if not delay or delay < 0.10 or delay > 60 then
        DelayTextBox.Text = "1.00"
        MultiTeleport.Delay = 1.0
        ShowNotification("Multi Teleport", "Delay set to 1.00 seconds (min: 0.10, max: 60)")
    else
        -- Format ke 2 angka desimal
        delay = math.floor(delay * 100) / 100
        DelayTextBox.Text = string.format("%.2f", delay)
        MultiTeleport.Delay = delay
        ShowNotification("Multi Teleport", "Delay set to " .. string.format("%.2f", delay) .. " seconds")
    end
end)

-- AFK Anti-Kick handlers (TAMBAHAN)
AntiAFKButton.MouseButton1Click:Connect(function()
    if AFKSystem.Enabled then
        DisableAntiAFK()
        ShowNotification("AFK System", "Anti AFK mode disabled")
    else
        EnableAntiAFK()
        ShowNotification("AFK System", "Anti AFK mode enabled\nPreventing kick...")
    end
end)

AutoJumpButton.MouseButton1Click:Connect(function()
    if AFKSystem.AutoJumpEnabled then
        DisableAutoJump()
        ShowNotification("AFK System", "Auto Jump mode disabled")
    else
        if not AFKSystem.Enabled then
            ShowNotification("AFK System", "Please enable Anti AFK mode first!")
            return
        end
        EnableAutoJump()
        ShowNotification("AFK System", "Auto Jump mode enabled\nJumping every " .. AFKSystem.AutoJumpInterval .. " minutes")
    end
end)

-- Validasi input interval Auto Jump
JumpIntervalBox.FocusLost:Connect(function()
    local interval = tonumber(JumpIntervalBox.Text)
    if not interval or interval < 1 or interval > 20 then
        JumpIntervalBox.Text = "5"
        AFKSystem.AutoJumpInterval = 5
        ShowNotification("AFK System", "Interval set to 5 minutes (max: 20)")
    else
        AFKSystem.AutoJumpInterval = interval
        if AFKSystem.AutoJumpEnabled then
            ShowNotification("AFK System", "Auto Jump interval updated to " .. interval .. " minutes")
        end
    end
end)

-- God Mode handler
GodModeToggleButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    EnableGodmode(godModeEnabled)
    
    if godModeEnabled then
        GodModeToggleButton.Text = "GOD MODE: ON"
        GodModeToggleButton.BackgroundColor3 = Color3.fromRGB(80, 160, 80)
        GodModeStatus.Text = "Status: ForceField active (Visual)"
        GodModeStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        GodModeToggleButton.Text = "GOD MODE: OFF"
        GodModeToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        GodModeStatus.Text = "Status: ForceField inactive"
        GodModeStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Window controls
MinimizeButton.MouseButton1Click:Connect(function()
    TweenObject(Z,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0)})
    wait(0.3)
    Z.Visible = false;
    MinimizedButton.Visible = true 
    updateNavPanelForMaximize()
end)

MinimizedButton.MouseButton1Click:Connect(function()
    MinimizedButton.Visible = false;
    Z.Visible = true;
    TweenObject(Z,{Size=UDim2.new(0,500,0,350),Position=UDim2.new(0.5,-250,0.5,-175)})
    updateNavPanelForMaximize()
end)

MaximizeButton.MouseButton1Click:Connect(ToggleMaximize)
CloseButton.MouseButton1Click:Connect(function()
    if not C then 
        ShowCloseDialog()
    end 
end)

CloseDialogYes.MouseButton1Click:Connect(function()
    CloseScript()
end)

CloseDialogNo.MouseButton1Click:Connect(function()
    RestoreWindow()
end)

-- Theme buttons
DarkThemeButton.MouseButton1Click:Connect(function()
    N="dark"
    ApplyTheme()
    ShowNotification("Theme","Dark theme applied!")
end)

OceanThemeButton.MouseButton1Click:Connect(function()
    N="ocean"
    ApplyTheme()
    ShowNotification("Theme","Ocean theme applied!")
end)

NightThemeButton.MouseButton1Click:Connect(function()
    N="night"
    ApplyTheme()
    ShowNotification("Theme","Night sky theme applied!")
end)

RGBModeButton.MouseButton1Click:Connect(function()
    rgbLineMode=not rgbLineMode;
    if rgbLineMode then 
        RGBModeButton.Text="RGB LINE MODE: ON"
        RGBModeButton.TextColor3=Color3.fromRGB(100,255,100)
        ShowNotification("RGB Line Mode","RGB Line Mode enabled! Colorful border is now active.")
    else 
        RGBModeButton.Text="RGB LINE MODE: OFF"
        RGBModeButton.TextColor3=Color3.fromRGB(255,100,100)
        da.Color=M[N].topBarColor;
        ShowNotification("RGB Line Mode","RGB Line Mode disabled! Border uses theme color.")
    end 
end)

-- Server buttons
RejoinButton.MouseButton1Click:Connect(function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId,localPlayer)
end)

NewServerButton.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId,localPlayer)
end)

LowPlayerServerButton.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId,localPlayer)
end)

-- Info buttons
DiscordButton.MouseButton1Click:Connect(function()
    CopyToClipboard("https://discord.gg/SvtShqv5a")
end)

-- =================================================================
-- INITIALIZATION AND FINAL SETUP
-- =================================================================
ApplyTheme()
MinimizedButton.Position=UDim2.new(0.5,-37.5,0,10)
MinimizedButton.Visible=true;
wait(0.5)
MinimizedButton.Visible=false;
Z.Visible=true;
J.Parent=localPlayer:WaitForChild("PlayerGui")
K.Parent=localPlayer:WaitForChild("PlayerGui")

ShowMain()
UpdateCoordinatesList()

-- Inisialisasi Builder GUI
InitializeBuilderGUI()

-- Tambahkan demo messages ke AI chat (TANPA MODIFIKASI)
spawn(function()
    wait(3)
    AddMessageToChatVertical("ai", "Hello! I'm LunarScript AI Assistant. How can I help you today?")
end)

localPlayer.CharacterAdded:Connect(function(newChar)
    character=newChar;
    humanoid=newChar:WaitForChild("Humanoid")
    walkSpeed=humanoid.WalkSpeed;
    jumpPower=humanoid.JumpPower;
end)

ShowNotification("Lunar Script v3", "Loaded Successfully!\nFeatures: Main, Info, Settings, Tools, Multi Teleport, AI Chat, and AFK Anti-Kick!")

end
end
if not game:IsLoaded() then return end

local t1 = tick()
local n1 = pcall(function() game:HttpGet("https://google.com", false) end)
if not n1 then return end

if (tick() - t1) * 1000 > 1000 then return end

if not pcall(function() game:GetService("Workspace") end) then return end

if not pcall(function() game:GetService("Lighting") end) then return end

if not pcall(function() game:GetService("ReplicatedStorage") end) then return end

if not pcall(function() game:GetService("ReplicatedFirst") end) then return end

local found1 = false
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("LocalScript") then
        found1 = true
        break
    end
end
if not found1 then return end

local t2 = tick()
local n2 = pcall(function() game:HttpGet("https://google.com", false) end)
if not n2 then return end

if (tick() - t2) * 1000 > 800 then return end

if not pcall(function() game:GetService("StarterGui") end) then return end

if not pcall(function() game:GetService("StarterPack") end) then return end

if not pcall(function() game:GetService("SoundService") end) then return end

if not pcall(function() game:GetService("Chat") end) then return end

local found2 = false
for _, v in pairs(game.Workspace:GetDescendants()) do
    if v:IsA("Script") then
        found2 = true
        break
    end
end
if not found2 then return end

executeMAIN()
