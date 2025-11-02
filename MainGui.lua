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

-- Color themes
local Themes = {
    dark = {
        backgroundColor = Color3.fromRGB(30, 30, 40),
        topBarColor = Color3.fromRGB(20, 20, 30),
        buttonColor = Color3.fromRGB(45, 45, 60),
        textColor = Color3.fromRGB(255, 255, 255)
    },
    ocean = {
        backgroundColor = Color3.fromRGB(0, 120, 190),
        topBarColor = Color3.fromRGB(0, 90, 150),
        buttonColor = Color3.fromRGB(0, 140, 210),
        textColor = Color3.fromRGB(255, 255, 255)
    },
    night = {
        backgroundColor = Color3.fromRGB(15, 15, 25),
        topBarColor = Color3.fromRGB(10, 10, 20),
        buttonColor = Color3.fromRGB(40, 40, 60),
        textColor = Color3.fromRGB(255, 255, 255)
    }
}

function MainGui.Initialize(loadedModules, loadedSettings)
    modules = loadedModules
    settings = loadedSettings
    
    print("🎨 Initializing Main GUI...")
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
    mainFrame.BackgroundColor3 = Themes.dark.backgroundColor
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- UI Stroke with RGB mode
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
        stroke.Color = Themes.dark.topBarColor
    end
    
    -- Title bar
    MainGui.CreateTitleBar()
    
    -- Tab system
    MainGui.CreateTabSystem()
    
    -- Parent to player GUI
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    -- Set default tab
    MainGui.SwitchTab("Main")
end

function MainGui.CreateTitleBar()
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Themes.dark.topBarColor
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
        -- Create minimize button
        local miniBtn = Instance.new("ImageButton")
        miniBtn.Size = UDim2.new(0, 45, 0, 45)
        miniBtn.Position = UDim2.new(0.5, -22.5, 0, 10)
        miniBtn.BackgroundColor3 = Themes.dark.backgroundColor
        miniBtn.Image = "rbxthumb://type=Asset&id=112498285326629"
        miniBtn.Parent = screenGui
        
        local miniCorner = Instance.new("UICorner")
        miniCorner.CornerRadius = UDim.new(0, 8)
        miniCorner.Parent = miniBtn
        
        miniBtn.MouseButton1Click:Connect(function()
            mainFrame.Visible = true
            miniBtn:Destroy()
        end)
    end)
    
    maximizeBtn.MouseButton1Click:Connect(function()
        if mainFrame.Size == UDim2.new(0, 500, 0, 350) then
            mainFrame.Size = UDim2.new(0, 600, 0, 450)
            mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
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

function MainGui.CreateTabSystem()
    -- Left tabs container
    local leftFrame = Instance.new("Frame")
    leftFrame.Size = UDim2.new(0.25, 0, 1, -30)
    leftFrame.Position = UDim2.new(0, 0, 0, 30)
    leftFrame.BackgroundTransparency = 1
    leftFrame.Parent = mainFrame
    
    -- Right content container
    local rightFrame = Instance.new("Frame")
    rightFrame.Size = UDim2.new(0.75, 0, 1, -30)
    rightFrame.Position = UDim2.new(0.25, 0, 0, 30)
    rightFrame.BackgroundTransparency = 1
    rightFrame.Parent = mainFrame
    
    -- Create tabs
    local tabs = {
        {Name = "Main", Position = 5},
        {Name = "Info", Position = 45},
        {Name = "Settings", Position = 85},
        {Name = "Executor", Position = 125},
        {Name = "Backdoor", Position = 165}
    }
    
    for _, tabInfo in ipairs(tabs) do
        MainGui.CreateTabButton(leftFrame, tabInfo.Name, tabInfo.Position)
    end
    
    -- Create content frames
    MainGui.CreateMainContent(rightFrame)
    MainGui.CreateInfoContent(rightFrame)
    MainGui.CreateSettingsContent(rightFrame)
    MainGui.CreateExecutorContent(rightFrame)
    MainGui.CreateBackdoorContent(rightFrame)
end

function MainGui.CreateTabButton(parent, name, position)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 35)
    tabButton.Position = UDim2.new(0, 5, 0, position)
    tabButton.BackgroundColor3 = Themes.dark.buttonColor
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 12
    tabButton.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = tabButton
    
    tabButton.MouseButton1Click:Connect(function()
        MainGui.SwitchTab(name)
    end)
end

function MainGui.CreateMainContent(parent)
    local mainContent = Instance.new("ScrollingFrame")
    mainContent.Name = "MainContent"
    mainContent.Size = UDim2.new(1, 0, 1, 0)
    mainContent.BackgroundTransparency = 1
    mainContent.ScrollBarThickness = 8
    mainContent.CanvasSize = UDim2.new(0, 0, 0, 600)
    mainContent.Visible = false
    mainContent.Parent = parent
    
    -- Initialize movement module
    if modules.Movement then
        modules.Movement.CreateGUI(mainContent)
    end
    
    -- Initialize teleport module
    if modules.Teleport then
        modules.Teleport.CreateGUI(mainContent)
    end
    
    -- Initialize anti-die module
    if modules.AntiDie then
        modules.AntiDie.CreateGUI(mainContent)
    end
end

function MainGui.CreateInfoContent(parent)
    local infoContent = Instance.new("ScrollingFrame")
    infoContent.Name = "InfoContent"
    infoContent.Size = UDim2.new(1, 0, 1, 0)
    infoContent.BackgroundTransparency = 1
    infoContent.ScrollBarThickness = 8
    infoContent.CanvasSize = UDim2.new(0, 0, 0, 400)
    infoContent.Visible = false
    infoContent.Parent = parent
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 400)
    container.BackgroundTransparency = 1
    container.Parent = infoContent
    
    -- Game info
    local gameInfo = Instance.new("TextLabel")
    gameInfo.Size = UDim2.new(1, -10, 0, 25)
    gameInfo.Position = UDim2.new(0, 5, 0, 5)
    gameInfo.BackgroundTransparency = 1
    gameInfo.Text = "Game: " .. MarketplaceService:GetProductInfo(game.PlaceId).Name
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
    
    -- Discord button
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
        if modules.Main then
            modules.Main.CopyDiscord()
        end
    end)
end

function MainGui.CreateSettingsContent(parent)
    local settingsContent = Instance.new("ScrollingFrame")
    settingsContent.Name = "SettingsContent"
    settingsContent.Size = UDim2.new(1, 0, 1, 0)
    settingsContent.BackgroundTransparency = 1
    settingsContent.ScrollBarThickness = 8
    settingsContent.CanvasSize = UDim2.new(0, 0, 0, 300)
    settingsContent.Visible = false
    settingsContent.Parent = parent
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 300)
    container.BackgroundTransparency = 1
    container.Parent = settingsContent
    
    -- Theme settings
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
    darkThemeBtn.BackgroundColor3 = Themes.dark.buttonColor
    darkThemeBtn.Text = "DARK THEME"
    darkThemeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    darkThemeBtn.Font = Enum.Font.Gotham
    darkThemeBtn.TextSize = 12
    darkThemeBtn.Parent = container
    
    local darkCorner = Instance.new("UICorner")
    darkCorner.CornerRadius = UDim.new(0, 6)
    darkCorner.Parent = darkThemeBtn
    
    local oceanThemeBtn = Instance.new("TextButton")
    oceanThemeBtn.Size = UDim2.new(1, -10, 0, 25)
    oceanThemeBtn.Position = UDim2.new(0, 5, 0, 65)
    oceanThemeBtn.BackgroundColor3 = Themes.ocean.buttonColor
    oceanThemeBtn.Text = "OCEAN THEME"
    oceanThemeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    oceanThemeBtn.Font = Enum.Font.Gotham
    oceanThemeBtn.TextSize = 12
    oceanThemeBtn.Parent = container
    
    local oceanCorner = Instance.new("UICorner")
    oceanCorner.CornerRadius = UDim.new(0, 6)
    oceanCorner.Parent = oceanThemeBtn
    
    local rgbModeBtn = Instance.new("TextButton")
    rgbModeBtn.Size = UDim2.new(1, -10, 0, 25)
    rgbModeBtn.Position = UDim2.new(0, 5, 0, 95)
    rgbModeBtn.BackgroundColor3 = Themes.dark.buttonColor
    rgbModeBtn.Text = "RGB MODE: ON"
    rgbModeBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    rgbModeBtn.Font = Enum.Font.Gotham
    rgbModeBtn.TextSize = 12
    rgbModeBtn.Parent = container
    
    local rgbCorner = Instance.new("UICorner")
    rgbCorner.CornerRadius = UDim.new(0, 6)
    rgbCorner.Parent = rgbModeBtn
    
    -- Server management
    local serverTitle = Instance.new("TextLabel")
    serverTitle.Size = UDim2.new(1, -10, 0, 25)
    serverTitle.Position = UDim2.new(0, 5, 0, 130)
    serverTitle.BackgroundTransparency = 1
    serverTitle.Text = "SERVER MANAGEMENT"
    serverTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    serverTitle.Font = Enum.Font.GothamBold
    serverTitle.TextSize = 14
    serverTitle.TextXAlignment = Enum.TextXAlignment.Left
    serverTitle.Parent = container
    
    local rejoinBtn = Instance.new("TextButton")
    rejoinBtn.Size = UDim2.new(1, -10, 0, 25)
    rejoinBtn.Position = UDim2.new(0, 5, 0, 160)
    rejoinBtn.BackgroundColor3 = Themes.dark.buttonColor
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
        MainGui.ApplyTheme("dark")
        MainGui.ShowNotification("Theme", "Dark theme applied!")
    end)
    
    oceanThemeBtn.MouseButton1Click:Connect(function()
        MainGui.ApplyTheme("ocean")
        MainGui.ShowNotification("Theme", "Ocean theme applied!")
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
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
    end)
end

function MainGui.CreateExecutorContent(parent)
    local executorContent = Instance.new("ScrollingFrame")
    executorContent.Name = "ExecutorContent"
    executorContent.Size = UDim2.new(1, 0, 1, 0)
    executorContent.BackgroundTransparency = 1
    executorContent.ScrollBarThickness = 8
    executorContent.CanvasSize = UDim2.new(0, 0, 0, 400)
    executorContent.Visible = false
    executorContent.Parent = parent
    
    -- Initialize executor module
    if modules.Executor then
        modules.Executor.CreateGUI(executorContent)
    end
end

function MainGui.CreateBackdoorContent(parent)
    local backdoorContent = Instance.new("ScrollingFrame")
    backdoorContent.Name = "BackdoorContent"
    backdoorContent.Size = UDim2.new(1, 0, 1, 0)
    backdoorContent.BackgroundTransparency = 1
    backdoorContent.ScrollBarThickness = 8
    backdoorContent.CanvasSize = UDim2.new(0, 0, 0, 500)
    backdoorContent.Visible = false
    backdoorContent.Parent = parent
    
    -- Initialize backdoor module
    if modules.Backdoor then
        modules.Backdoor.CreateGUI(backdoorContent)
    end
end

function MainGui.SwitchTab(tabName)
    -- Hide all content
    for _, child in pairs(mainFrame:GetDescendants()) do
        if child.Name:match("Content$") and child:IsA("ScrollingFrame") then
            child.Visible = false
        end
    end
    
    -- Show selected content
    local targetContent = mainFrame:FindFirstChild(tabName .. "Content")
    if targetContent then
        targetContent.Visible = true
        currentTab = tabName
    end
    
    -- Update tab button colors
    for _, tab in pairs(mainFrame:GetDescendants()) do
        if tab:IsA("TextButton") and tab.Name:match("Tab$") then
            if tab.Name == tabName .. "Tab" then
                tab.BackgroundColor3 = Color3.fromRGB(65, 105, 225) -- Active
            else
                tab.BackgroundColor3 = Themes.dark.buttonColor -- Inactive
            end
        end
    end
end

function MainGui.ApplyTheme(themeName)
    local theme = Themes[themeName]
    if theme then
        mainFrame.BackgroundColor3 = theme.backgroundColor
        -- Update other elements as needed
    end
end

function MainGui.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

function MainGui.GetWalkSpeed()
    return 16 -- Will be implemented with movement module
end

function MainGui.GetJumpPower()
    return 50 -- Will be implemented with movement module
end

return MainGui
