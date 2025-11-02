-- Lunar Script Main GUI System
local MainGui = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local localPlayer = Players.LocalPlayer
local modules = {}
local settings = {}

local screenGui
local mainFrame
local currentTab = "Main"
local tabs = {}
local tabFrames = {}

function MainGui.Initialize(loadedModules, loadedSettings)
    modules = loadedModules
    settings = loadedSettings
    
    print("🎨 Initializing Main GUI...")
    
    -- Create GUI
    MainGui.CreateMainGUI()
    
    return true
end

function MainGui.CreateMainGUI()
    -- Create main ScreenGui
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LunarScriptGUI"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    
    -- Main frame
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- UI Stroke dengan RGB mode
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Parent = mainFrame
    
    -- RGB animation
    if settings.RGBMode then
        local hue = 0
        RunService.Heartbeat:Connect(function(delta)
            hue = (hue + delta * 60) % 360
            stroke.Color = Color3.fromHSV(hue/360, 1, 1)
        end)
    else
        stroke.Color = Color3.fromRGB(20, 20, 30)
    end
    
    -- Title bar
    MainGui.CreateTitleBar()
    
    -- Tab buttons area
    MainGui.CreateTabButtons()
    
    -- Content area
    MainGui.CreateContentArea()
    
    -- Parent to player GUI
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    -- Set default tab
    MainGui.SwitchTab("Main")
end

function MainGui.CreateTitleBar()
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    titleBar.Parent = mainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = titleBar
    
    -- Logo and title
    local titleContainer = Instance.new("Frame")
    titleContainer.Size = UDim2.new(0, 200, 1, 0)
    titleContainer.Position = UDim2.new(0, 10, 0, 0)
    titleContainer.BackgroundTransparency = 1
    titleContainer.Parent = titleBar
    
    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 25, 0, 25)
    logo.Position = UDim2.new(0, 0, 0.5, -12.5)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://112498285326629"
    logo.ScaleType = Enum.ScaleType.Fit
    logo.Parent = titleContainer
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 150, 1, 0)
    title.Position = UDim2.new(0, 30, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Lunar Script"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = titleContainer
    
    -- Control buttons
    MainGui.CreateControlButtons(titleBar)
end

function MainGui.CreateControlButtons(parent)
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -90, 0, 0)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 16
    minimizeBtn.Parent = parent
    
    local maximizeBtn = Instance.new("TextButton")
    maximizeBtn.Size = UDim2.new(0, 30, 0, 30)
    maximizeBtn.Position = UDim2.new(1, -60, 0, 0)
    maximizeBtn.BackgroundTransparency = 1
    maximizeBtn.Text = "□"
    maximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    maximizeBtn.Font = Enum.Font.GothamBold
    maximizeBtn.TextSize = 14
    maximizeBtn.Parent = parent
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = parent
    
    -- Button events
    minimizeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)
    
    maximizeBtn.MouseButton1Click:Connect(function()
        if mainFrame.Size == UDim2.new(0, 500, 0, 350) then
            mainFrame.Size = UDim2.new(0, 600, 0, 400)
            mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
            maximizeBtn.Text = "❐"
        else
            mainFrame.Size = UDim2.new(0, 500, 0, 350)
            mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
            maximizeBtn.Text = "□"
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
end

function MainGui.CreateTabButtons()
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0.25, 0, 1, -30)
    tabContainer.Position = UDim2.new(0, 0, 0, 30)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame
    
    -- Define tabs
    local tabList = {
        {Name = "Main", Position = 5},
        {Name = "Info", Position = 45},
        {Name = "Settings", Position = 85},
        {Name = "Executor", Position = 125},
        {Name = "Backdoor", Position = 165}
    }
    
    for _, tabInfo in ipairs(tabList) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, -10, 0, 35)
        tabButton.Position = UDim2.new(0, 5, 0, tabInfo.Position)
        tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        tabButton.Text = tabInfo.Name
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.GothamBold
        tabButton.TextSize = 12
        tabButton.Parent = tabContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = tabButton
        
        tabButton.MouseButton1Click:Connect(function()
            MainGui.SwitchTab(tabInfo.Name)
        end)
        
        tabs[tabInfo.Name] = tabButton
    end
end

function MainGui.CreateContentArea()
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(0.75, 0, 1, -30)
    contentContainer.Position = UDim2.new(0.25, 0, 0, 30)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFrame
    
    -- Create tab frames
    MainGui.CreateMainTab(contentContainer)
    MainGui.CreateInfoTab(contentContainer)
    MainGui.CreateSettingsTab(contentContainer)
    MainGui.CreateExecutorTab(contentContainer)
    MainGui.CreateBackdoorTab(contentContainer)
end

function MainGui.CreateMainTab(parent)
    local mainTab = Instance.new("ScrollingFrame")
    mainTab.Name = "MainTab"
    mainTab.Size = UDim2.new(1, 0, 1, 0)
    mainTab.BackgroundTransparency = 1
    mainTab.ScrollBarThickness = 8
    mainTab.CanvasSize = UDim2.new(0, 0, 0, 600)
    mainTab.Visible = false
    mainTab.Parent = parent
    
    tabFrames.Main = mainTab
    
    -- Initialize Movement module GUI
    if modules.Movement then
        modules.Movement.CreateGUI(mainTab)
    end
    
    -- Initialize Teleport module GUI
    if modules.Teleport then
        modules.Teleport.CreateGUI(mainTab)
    end
    
    -- Initialize AntiDie module GUI
    if modules.AntiDie then
        modules.AntiDie.CreateGUI(mainTab)
    end
end

function MainGui.CreateInfoTab(parent)
    local infoTab = Instance.new("ScrollingFrame")
    infoTab.Name = "InfoTab"
    infoTab.Size = UDim2.new(1, 0, 1, 0)
    infoTab.BackgroundTransparency = 1
    infoTab.ScrollBarThickness = 8
    infoTab.CanvasSize = UDim2.new(0, 0, 0, 400)
    infoTab.Visible = false
    infoTab.Parent = parent
    
    tabFrames.Info = infoTab
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 400)
    container.BackgroundTransparency = 1
    container.Parent = infoTab
    
    -- Game Info
    local gameInfo = Instance.new("TextLabel")
    gameInfo.Size = UDim2.new(1, -10, 0, 25)
    gameInfo.Position = UDim2.new(0, 5, 0, 5)
    gameInfo.BackgroundTransparency = 1
    gameInfo.Text = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    gameInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    gameInfo.Font = Enum.Font.Gotham
    gameInfo.TextSize = 14
    gameInfo.TextXAlignment = Enum.TextXAlignment.Left
    gameInfo.Parent = container
    
    local playerInfo = Instance.new("TextLabel")
    playerInfo.Size = UDim2.new(1, -10, 0, 25)
    playerInfo.Position = UDim2.new(0, 5, 0, 35)
    playerInfo.BackgroundTransparency = 1
    playerInfo.Text = "Player: " .. localPlayer.Name
    playerInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerInfo.Font = Enum.Font.Gotham
    playerInfo.TextSize = 14
    playerInfo.TextXAlignment = Enum.TextXAlignment.Left
    playerInfo.Parent = container
    
    local userIdInfo = Instance.new("TextLabel")
    userIdInfo.Size = UDim2.new(1, -10, 0, 25)
    userIdInfo.Position = UDim2.new(0, 5, 0, 65)
    userIdInfo.BackgroundTransparency = 1
    userIdInfo.Text = "User ID: " .. localPlayer.UserId
    userIdInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    userIdInfo.Font = Enum.Font.Gotham
    userIdInfo.TextSize = 14
    userIdInfo.TextXAlignment = Enum.TextXAlignment.Left
    userIdInfo.Parent = container
    
    -- Discord Button
    local discordBtn = Instance.new("TextButton")
    discordBtn.Size = UDim2.new(1, -10, 0, 35)
    discordBtn.Position = UDim2.new(0, 5, 0, 100)
    discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    discordBtn.Text = "COPY DISCORD LINK"
    discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.TextSize = 12
    discordBtn.Parent = container
    
    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 6)
    discordCorner.Parent = discordBtn
    
    discordBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/MKSBJDFFd")
        MainGui.ShowNotification("Discord", "Discord link copied!")
    end)
    
    -- Credits
    local credits = Instance.new("TextLabel")
    credits.Size = UDim2.new(1, -10, 0, 60)
    credits.Position = UDim2.new(0, 5, 0, 150)
    credits.BackgroundTransparency = 1
    credits.Text = "Created by: h4000_audio8\nThanks for using Lunar Script!\nVersion: 1.0"
    credits.TextColor3 = Color3.fromRGB(255, 255, 255)
    credits.Font = Enum.Font.Gotham
    credits.TextSize = 12
    credits.TextXAlignment = Enum.TextXAlignment.Left
    credits.Parent = container
end

function MainGui.CreateSettingsTab(parent)
    local settingsTab = Instance.new("ScrollingFrame")
    settingsTab.Name = "SettingsTab"
    settingsTab.Size = UDim2.new(1, 0, 1, 0)
    settingsTab.BackgroundTransparency = 1
    settingsTab.ScrollBarThickness = 8
    settingsTab.CanvasSize = UDim2.new(0, 0, 0, 300)
    settingsTab.Visible = false
    settingsTab.Parent = parent
    
    tabFrames.Settings = settingsTab
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 300)
    container.BackgroundTransparency = 1
    container.Parent = settingsTab
    
    -- Theme Settings
    local themeTitle = Instance.new("TextLabel")
    themeTitle.Size = UDim2.new(1, -10, 0, 25)
    themeTitle.Position = UDim2.new(0, 5, 0, 5)
    themeTitle.BackgroundTransparency = 1
    themeTitle.Text = "THEME SETTINGS"
    themeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    themeTitle.Font = Enum.Font.GothamBold
    themeTitle.TextSize = 14
    themeTitle.TextXAlignment = Enum.TextXAlignment.Left
    themeTitle.Parent = container
    
    local darkThemeBtn = Instance.new("TextButton")
    darkThemeBtn.Size = UDim2.new(1, -10, 0, 25)
    darkThemeBtn.Position = UDim2.new(0, 5, 0, 35)
    darkThemeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    darkThemeBtn.Text = "DARK THEME"
    darkThemeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    darkThemeBtn.Font = Enum.Font.Gotham
    darkThemeBtn.TextSize = 12
    darkThemeBtn.Parent = container
    
    local darkCorner = Instance.new("UICorner")
    darkCorner.CornerRadius = UDim.new(0, 6)
    darkCorner.Parent = darkThemeBtn
    
    local rgbModeBtn = Instance.new("TextButton")
    rgbModeBtn.Size = UDim2.new(1, -10, 0, 25)
    rgbModeBtn.Position = UDim2.new(0, 5, 0, 65)
    rgbModeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    rgbModeBtn.Text = "RGB MODE: ON"
    rgbModeBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    rgbModeBtn.Font = Enum.Font.Gotham
    rgbModeBtn.TextSize = 12
    rgbModeBtn.Parent = container
    
    local rgbCorner = Instance.new("UICorner")
    rgbCorner.CornerRadius = UDim.new(0, 6)
    rgbCorner.Parent = rgbModeBtn
    
    -- Server Management
    local serverTitle = Instance.new("TextLabel")
    serverTitle.Size = UDim2.new(1, -10, 0, 25)
    serverTitle.Position = UDim2.new(0, 5, 0, 100)
    serverTitle.BackgroundTransparency = 1
    serverTitle.Text = "SERVER MANAGEMENT"
    serverTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    serverTitle.Font = Enum.Font.GothamBold
    serverTitle.TextSize = 14
    serverTitle.TextXAlignment = Enum.TextXAlignment.Left
    serverTitle.Parent = container
    
    local rejoinBtn = Instance.new("TextButton")
    rejoinBtn.Size = UDim2.new(1, -10, 0, 25)
    rejoinBtn.Position = UDim2.new(0, 5, 0, 130)
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    rejoinBtn.Text = "REJOIN SERVER"
    rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    rejoinBtn.Font = Enum.Font.Gotham
    rejoinBtn.TextSize = 12
    rejoinBtn.Parent = container
    
    local rejoinCorner = Instance.new("UICorner")
    rejoinCorner.CornerRadius = UDim.new(0, 6)
    rejoinCorner.Parent = rejoinBtn
    
    -- Button events
    darkThemeBtn.MouseButton1Click:Connect(function()
        MainGui.ShowNotification("Theme", "Dark theme applied!")
    end)
    
    rgbModeBtn.MouseButton1Click:Connect(function()
        settings.RGBMode = not settings.RGBMode
        if settings.RGBMode then
            rgbModeBtn.Text = "RGB MODE: ON"
            rgbModeBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            rgbModeBtn.Text = "RGB MODE: OFF"
            rgbModeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        MainGui.ShowNotification("RGB Mode", "RGB mode: " .. tostring(settings.RGBMode))
    end)
    
    rejoinBtn.MouseButton1Click:Connect(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
    end)
end

function MainGui.CreateExecutorTab(parent)
    local executorTab = Instance.new("ScrollingFrame")
    executorTab.Name = "ExecutorTab"
    executorTab.Size = UDim2.new(1, 0, 1, 0)
    executorTab.BackgroundTransparency = 1
    executorTab.ScrollBarThickness = 8
    executorTab.CanvasSize = UDim2.new(0, 0, 0, 400)
    executorTab.Visible = false
    executorTab.Parent = parent
    
    tabFrames.Executor = executorTab
    
    -- Initialize Executor module GUI
    if modules.Executor then
        modules.Executor.CreateGUI(executorTab)
    end
end

function MainGui.CreateBackdoorTab(parent)
    local backdoorTab = Instance.new("ScrollingFrame")
    backdoorTab.Name = "BackdoorTab"
    backdoorTab.Size = UDim2.new(1, 0, 1, 0)
    backdoorTab.BackgroundTransparency = 1
    backdoorTab.ScrollBarThickness = 8
    backdoorTab.CanvasSize = UDim2.new(0, 0, 0, 500)
    backdoorTab.Visible = false
    backdoorTab.Parent = parent
    
    tabFrames.Backdoor = backdoorTab
    
    -- Initialize Backdoor module GUI
    if modules.Backdoor then
        modules.Backdoor.CreateGUI(backdoorTab)
    end
end

function MainGui.SwitchTab(tabName)
    -- Hide all tabs
    for name, tabFrame in pairs(tabFrames) do
        tabFrame.Visible = false
    end
    
    -- Show selected tab
    if tabFrames[tabName] then
        tabFrames[tabName].Visible = true
        currentTab = tabName
    end
    
    -- Update tab button colors
    for name, button in pairs(tabs) do
        if name == tabName then
            button.BackgroundColor3 = Color3.fromRGB(65, 105, 225) -- Active color
        else
            button.BackgroundColor3 = Color3.fromRGB(45, 45, 60) -- Inactive color
        end
    end
end

function MainGui.ToggleGUI()
    mainFrame.Visible = not mainFrame.Visible
end

function MainGui.UpdateCharacterInfo(character)
    -- Update GUI dengan info character terbaru
end

function MainGui.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

return MainGui
