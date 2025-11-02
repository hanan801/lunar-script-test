-- Main GUI - Fixed and Simplified
local MainGUI = {}

function MainGUI:Create(core)
    self.Core = core
    
    -- Create main GUI
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
    
    -- Create simple tab system
    self:CreateSimpleTabs(mainFrame, core)
    
    self.GUI = mainGui
    return self
end

function MainGUI:CreateSimpleTabs(parent, core)
    -- Content area
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -60)
    content.Position = UDim2.new(0, 10, 0, 50)
    content.BackgroundTransparency = 1
    content.Parent = parent
    
    -- Main Tab Content
    self:CreateMainTab(content, core)
end

function MainGUI:CreateMainTab(content, core)
    -- Clear content
    for _, child in ipairs(content:GetChildren()) do
        child:Destroy()
    end
    
    local movement = core:GetModule("Movement")
    local backdoor = core:GetModule("Backdoor")
    local executor = core:GetModule("Executor")
    local teleport = core:GetModule("Teleport")
    local antDie = core:GetModule("AntiDie")
    
    local yPos = 10
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, yPos)
    title.BackgroundTransparency = 1
    title.Text = "LUNAR SCRIPT - MAIN MENU"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Parent = content
    
    yPos = yPos + 40
    
    -- Infinity Jump Button
    local infJumpBtn = Instance.new("TextButton")
    infJumpBtn.Size = UDim2.new(1, 0, 0, 35)
    infJumpBtn.Position = UDim2.new(0, 0, 0, yPos)
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
        if movement then
            movement:ToggleInfinityJump()
            infJumpBtn.Text = "Infinity Jump: " .. (core.States.InfinityJump and "ON" or "OFF")
        end
    end)
    
    yPos = yPos + 45
    
    -- Walk Speed Section
    local walkSpeedFrame = Instance.new("Frame")
    walkSpeedFrame.Size = UDim2.new(1, 0, 0, 35)
    walkSpeedFrame.Position = UDim2.new(0, 0, 0, yPos)
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
        if movement then
            movement:ToggleWalkSpeed()
            walkSpeedBtn.Text = "Walk Speed: " .. (core.States.WalkSpeedEnabled and "ON" or "OFF")
        end
    end)
    
    setWalkBtn.MouseButton1Click:Connect(function()
        if movement then
            movement:SetWalkSpeed(walkSpeedBox.Text)
        end
    end)
    
    yPos = yPos + 45
    
    -- Backdoor Scan Button
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(1, 0, 0, 35)
    scanBtn.Position = UDim2.new(0, 0, 0, yPos)
    scanBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    scanBtn.Text = "SCAN BACKDOOR"
    scanBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextSize = 12
    scanBtn.Parent = content
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 6)
    corner3.Parent = scanBtn
    
    scanBtn.MouseButton1Click:Connect(function()
        if backdoor then
            backdoor:ScanBackdoors()
        end
    end)
    
    yPos = yPos + 45
    
    -- Anti Die Button
    local antiDieBtn = Instance.new("TextButton")
    antiDieBtn.Size = UDim2.new(1, 0, 0, 35)
    antiDieBtn.Position = UDim2.new(0, 0, 0, yPos)
    antiDieBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    antiDieBtn.Text = "ANTI DIE: OFF"
    antiDieBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    antiDieBtn.Font = Enum.Font.GothamBold
    antiDieBtn.TextSize = 12
    antiDieBtn.Parent = content
    
    local corner4 = Instance.new("UICorner")
    corner4.CornerRadius = UDim.new(0, 6)
    corner4.Parent = antiDieBtn
    
    antiDieBtn.MouseButton1Click:Connect(function()
        if antDie then
            antDie:ToggleAntiDie()
            antiDieBtn.Text = "ANTI DIE: " .. (antDie.Active and "ON" or "OFF")
        end
    end)
    
    yPos = yPos + 45
    
    -- Set Spawn Button
    local spawnBtn = Instance.new("TextButton")
    spawnBtn.Size = UDim2.new(1, 0, 0, 35)
    spawnBtn.Position = UDim2.new(0, 0, 0, yPos)
    spawnBtn.BackgroundColor3 = Color3.fromRGB(60, 179, 113)
    spawnBtn.Text = "SET SPAWN POINT"
    spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    spawnBtn.Font = Enum.Font.GothamBold
    spawnBtn.TextSize = 12
    spawnBtn.Parent = content
    
    local corner5 = Instance.new("UICorner")
    corner5.CornerRadius = UDim.new(0, 6)
    corner5.Parent = spawnBtn
    
    spawnBtn.MouseButton1Click:Connect(function()
        if teleport then
            teleport:SetSpawnPoint()
        end
    end)
end

return MainGUI
