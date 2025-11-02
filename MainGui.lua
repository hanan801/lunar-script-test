-- Main GUI
local MainGUI = {}

function MainGUI:Create(core)
    self.Core = core
    
    -- Create main GUI
    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "LunarScriptGUI"
    mainGui.ResetOnSpawn = false
    mainGui.Parent = CoreGui
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = mainGui
    
    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Title Text
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -100, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "Lunar Script v" .. core.Version
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 16
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = titleBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        mainGui:Destroy()
    end)
    
    -- Create tabs
    self:CreateTabs(mainFrame, core)
    
    self.GUI = mainGui
    return self
end

function MainGUI:CreateTabs(parent, core)
    -- Tab buttons container
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -40)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = parent
    
    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 120, 1, 0)
    sidebar.BackgroundTransparency = 1
    sidebar.Parent = tabContainer
    
    -- Content area
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -120, 1, 0)
    content.Position = UDim2.new(0, 120, 0, 0)
    content.BackgroundTransparency = 1
    content.Parent = tabContainer
    
    -- Tab buttons
    local tabs = {
        {Name = "MAIN", Position = UDim2.new(0, 10, 0, 10)},
        {Name = "MOVEMENT", Position = UDim2.new(0, 10, 0, 50)},
        {Name = "BACKDOOR", Position = UDim2.new(0, 10, 0, 90)},
        {Name = "EXECUTOR", Position = UDim2.new(0, 10, 0, 130)},
        {Name = "TELEPORT", Position = UDim2.new(0, 10, 0, 170)}
    }
    
    for i, tab in ipairs(tabs) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 30)
        button.Position = tab.Position
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        button.Text = tab.Name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 12
        button.Parent = sidebar
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            self:ShowTab(tab.Name, content, core)
        end)
    end
    
    -- Show main tab by default
    self:ShowTab("MAIN", content, core)
end

function MainGUI:ShowTab(tabName, content, core)
    -- Clear previous content
    for _, child in ipairs(content:GetChildren()) do
        child:Destroy()
    end
    
    if tabName == "MAIN" then
        self:CreateMainTab(content, core)
    elseif tabName == "MOVEMENT" then
        self:CreateMovementTab(content, core)
    elseif tabName == "BACKDOOR" then
        self:CreateBackdoorTab(content, core)
    elseif tabName == "EXECUTOR" then
        self:CreateExecutorTab(content, core)
    elseif tabName == "TELEPORT" then
        self:CreateTeleportTab(content, core)
    end
end

function MainGUI:CreateMainTab(content, core)
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "LUNAR SCRIPT v" .. core.Version
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Parent = content
    
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -20, 0, 100)
    info.Position = UDim2.new(0, 10, 0, 60)
    info.BackgroundTransparency = 1
    info.Text = "Welcome to Lunar Script!\n\n• 30+ Features\n• Backdoor System\n• Anti-Die Protection\n• Movement Enhancements\n• And much more!"
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.Font = Enum.Font.Gotham
    info.TextSize = 14
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Parent = content
    
    local author = Instance.new("TextLabel")
    author.Size = UDim2.new(1, -20, 0, 30)
    author.Position = UDim2.new(0, 10, 1, -40)
    author.BackgroundTransparency = 1
    author.Text = "Created by: " .. core.Author
    author.TextColor3 = Color3.fromRGB(150, 150, 150)
    author.Font = Enum.Font.Gotham
    author.TextSize = 12
    author.TextXAlignment = Enum.TextXAlignment.Center
    author.Parent = content
end

function MainGUI:CreateMovementTab(content, core)
    local movement = core:GetModule("Movement")
    
    local yPos = 10
    
    -- Infinity Jump
    local infJumpBtn = Instance.new("TextButton")
    infJumpBtn.Size = UDim2.new(1, -20, 0, 35)
    infJumpBtn.Position = UDim2.new(0, 10, 0, yPos)
    infJumpBtn.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    infJumpBtn.Text = "Infinity Jump: OFF"
    infJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    infJumpBtn.Font = Enum.Font.GothamBold
    infJumpBtn.TextSize = 12
    infJumpBtn.Parent = content
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 6)
    corner1.Parent = infJumpBtn
    
    infJumpBtn.MouseButton1Click:Connect(function()
        movement:ToggleInfinityJump()
        infJumpBtn.Text = "Infinity Jump: " .. (core.States.InfinityJump and "ON" or "OFF")
    end)
    
    yPos = yPos + 45
    
    -- Walk Speed
    local walkSpeedFrame = Instance.new("Frame")
    walkSpeedFrame.Size = UDim2.new(1, -20, 0, 35)
    walkSpeedFrame.Position = UDim2.new(0, 10, 0, yPos)
    walkSpeedFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    walkSpeedFrame.Parent = content
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 6)
    corner2.Parent = walkSpeedFrame
    
    local walkSpeedBtn = Instance.new("TextButton")
    walkSpeedBtn.Size = UDim2.new(0.4, 0, 1, 0)
    walkSpeedBtn.Position = UDim2.new(0, 0, 0, 0)
    walkSpeedBtn.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    walkSpeedBtn.Text = "Walk Speed: OFF"
    walkSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedBtn.Font = Enum.Font.Gotham
    walkSpeedBtn.TextSize = 11
    walkSpeedBtn.Parent = walkSpeedFrame
    
    local walkSpeedBox = Instance.new("TextBox")
    walkSpeedBox.Size = UDim2.new(0.4, -5, 0.7, 0)
    walkSpeedBox.Position = UDim2.new(0.4, 5, 0.15, 0)
    walkSpeedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    walkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedBox.Text = "16"
    walkSpeedBox.Font = Enum.Font.Gotham
    walkSpeedBox.TextSize = 11
    walkSpeedBox.Parent = walkSpeedFrame
    
    local setWalkBtn = Instance.new("TextButton")
    setWalkBtn.Size = UDim2.new(0.2, -5, 0.7, 0)
    setWalkBtn.Position = UDim2.new(0.8, 5, 0.15, 0)
    setWalkBtn.BackgroundColor3 = Color3.fromRGB(60, 179, 113)
    setWalkBtn.Text = "SET"
    setWalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    setWalkBtn.Font = Enum.Font.Gotham
    setWalkBtn.TextSize = 11
    setWalkBtn.Parent = walkSpeedFrame
    
    walkSpeedBtn.MouseButton1Click:Connect(function()
        local enabled = not core.States.WalkSpeedEnabled
        local speed = tonumber(walkSpeedBox.Text) or 16
        movement:ToggleWalkSpeed(enabled, speed)
        walkSpeedBtn.Text = "Walk Speed: " .. (enabled and "ON" or "OFF")
    end)
    
    yPos = yPos + 45
end

function MainGUI:CreateBackdoorTab(content, core)
    local backdoor = core:GetModule("Backdoor")
    
    local yPos = 10
    
    -- Scan Button
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(1, -20, 0, 40)
    scanBtn.Position = UDim2.new(0, 10, 0, yPos)
    scanBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    scanBtn.Text = "SCAN BACKDOOR"
    scanBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextSize = 14
    scanBtn.Parent = content
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 6)
    corner1.Parent = scanBtn
    
    scanBtn.MouseButton1Click:Connect(function()
        backdoor:ScanBackdoors()
    end)
    
    yPos = yPos + 50
    
    -- Script Box
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(1, -20, 0, 100)
    scriptBox.Position = UDim2.new(0, 10, 0, yPos)
    scriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptBox.Text = ""
    scriptBox.MultiLine = true
    scriptBox.TextWrapped = true
    scriptBox.PlaceholderText = "Enter script to execute on all players via backdoor..."
    scriptBox.Font = Enum.Font.Gotham
    scriptBox.TextSize = 12
    scriptBox.Parent = content
    
    yPos = yPos + 110
    
    -- Execute Button
    local executeBtn = Instance.new("TextButton")
    executeBtn.Size = UDim2.new(0.48, -5, 0, 35)
    executeBtn.Position = UDim2.new(0, 10, 0, yPos)
    executeBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
    executeBtn.Text = "EXECUTE ON ALL"
    executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeBtn.Font = Enum.Font.GothamBold
    executeBtn.TextSize = 12
    executeBtn.Parent = content
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 6)
    corner2.Parent = executeBtn
    
    executeBtn.MouseButton1Click:Connect(function()
        backdoor:ExecuteBackdoorScript(scriptBox.Text)
    end)
    
    -- Clear Button
    local clearBtn = Instance.new("TextButton")
    clearBtn.Size = UDim2.new(0.48, -5, 0, 35)
    clearBtn.Position = UDim2.new(0.52, 0, 0, yPos)
    clearBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    clearBtn.Text = "CLEAR"
    clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearBtn.Font = Enum.Font.GothamBold
    clearBtn.TextSize = 12
    clearBtn.Parent = content
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 6)
    corner3.Parent = clearBtn
    
    clearBtn.MouseButton1Click:Connect(function()
        scriptBox.Text = ""
    end)
end

function MainGUI:CreateExecutorTab(content, core)
    local executor = core:GetModule("Executor")
    
    local yPos = 10
    
    -- Script Box
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(1, -20, 0, 150)
    scriptBox.Position = UDim2.new(0, 10, 0, yPos)
    scriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptBox.Text = ""
    scriptBox.MultiLine = true
    scriptBox.TextWrapped = true
    scriptBox.PlaceholderText = "Paste your Lua script here..."
    scriptBox.Font = Enum.Font.Gotham
    scriptBox.TextSize = 12
    scriptBox.Parent = content
    
    yPos = yPos + 160
    
    -- Execute Button
    local executeBtn = Instance.new("TextButton")
    executeBtn.Size = UDim2.new(0.48, -5, 0, 35)
    executeBtn.Position = UDim2.new(0, 10, 0, yPos)
    executeBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
    executeBtn.Text = "EXECUTE"
    executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeBtn.Font = Enum.Font.GothamBold
    executeBtn.TextSize = 12
    executeBtn.Parent = content
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 6)
    corner1.Parent = executeBtn
    
    executeBtn.MouseButton1Click:Connect(function()
        executor:ExecuteScript(scriptBox.Text)
    end)
    
    -- Clear Button
    local clearBtn = Instance.new("TextButton")
    clearBtn.Size = UDim2.new(0.48, -5, 0, 35)
    clearBtn.Position = UDim2.new(0.52, 0, 0, yPos)
    clearBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    clearBtn.Text = "CLEAR"
    clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearBtn.Font = Enum.Font.GothamBold
    clearBtn.TextSize = 12
    clearBtn.Parent = content
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 6)
    corner2.Parent = clearBtn
    
    clearBtn.MouseButton1Click:Connect(function()
        scriptBox.Text = ""
    end)
end

function MainGUI:CreateTeleportTab(content, core)
    local teleport = core:GetModule("Teleport")
    
    local yPos = 10
    
    -- Set Spawn Button
    local spawnBtn = Instance.new("TextButton")
    spawnBtn.Size = UDim2.new(1, -20, 0, 35)
    spawnBtn.Position = UDim2.new(0, 10, 0, yPos)
    spawnBtn.BackgroundColor3 = Color3.fromRGB(60, 179, 113)
    spawnBtn.Text = "SET SPAWN POINT"
    spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    spawnBtn.Font = Enum.Font.GothamBold
    spawnBtn.TextSize = 12
    spawnBtn.Parent = content
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 6)
    corner1.Parent = spawnBtn
    
    spawnBtn.MouseButton1Click:Connect(function()
        teleport:SetSpawnPoint()
    end)
    
    yPos = yPos + 45
    
    -- Teleport to Spawn Button
    local tpSpawnBtn = Instance.new("TextButton")
    tpSpawnBtn.Size = UDim2.new(1, -20, 0, 35)
    tpSpawnBtn.Position = UDim2.new(0, 10, 0, yPos)
    tpSpawnBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    tpSpawnBtn.Text = "TELEPORT TO SPAWN"
    tpSpawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpSpawnBtn.Font = Enum.Font.GothamBold
    tpSpawnBtn.TextSize = 12
    tpSpawnBtn.Parent = content
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 6)
    corner2.Parent = tpSpawnBtn
    
    tpSpawnBtn.MouseButton1Click:Connect(function()
        teleport:TeleportToSpawn()
    end)
end

return MainGUI
