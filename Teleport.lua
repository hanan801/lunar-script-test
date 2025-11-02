-- Lunar Script Teleport Module
local Teleport = {}

-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

-- Variables
local localPlayer = Players.LocalPlayer
local character
local humanoidRootPart

function Teleport.Initialize(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    print("📍 Teleport module initialized")
end

function Teleport.CreateGUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 300)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    -- Teleport Title
    local teleportTitle = Instance.new("TextLabel")
    teleportTitle.Size = UDim2.new(1, -10, 0, 25)
    teleportTitle.Position = UDim2.new(0, 5, 0, 5)
    teleportTitle.BackgroundTransparency = 1
    teleportTitle.Text = "TELEPORT"
    teleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportTitle.Font = Enum.Font.GothamBold
    teleportTitle.TextSize = 14
    teleportTitle.TextXAlignment = Enum.TextXAlignment.Left
    teleportTitle.Parent = container
    
    -- Teleport to Player
    local tpPlayerBtn = Instance.new("TextButton")
    tpPlayerBtn.Size = UDim2.new(0.48, -5, 0, 25)
    tpPlayerBtn.Position = UDim2.new(0, 5, 0, 35)
    tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    tpPlayerBtn.Text = "TP TO PLAYER"
    tpPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpPlayerBtn.Font = Enum.Font.Gotham
    tpPlayerBtn.TextSize = 12
    tpPlayerBtn.Parent = container
    
    local tpPlayerCorner = Instance.new("UICorner")
    tpPlayerCorner.CornerRadius = UDim.new(0, 6)
    tpPlayerCorner.Parent = tpPlayerBtn
    
    local refreshBtn = Instance.new("TextButton")
    refreshBtn.Size = UDim2.new(0.48, -5, 0, 25)
    refreshBtn.Position = UDim2.new(0.52, 0, 0, 35)
    refreshBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    refreshBtn.Text = "REFRESH"
    refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    refreshBtn.Font = Enum.Font.Gotham
    refreshBtn.TextSize = 12
    refreshBtn.Parent = container
    
    local refreshCorner = Instance.new("UICorner")
    refreshCorner.CornerRadius = UDim.new(0, 6)
    refreshCorner.Parent = refreshBtn
    
    -- Coordinates Teleport
    local coordsFrame = Instance.new("Frame")
    coordsFrame.Size = UDim2.new(1, -10, 0, 110)
    coordsFrame.Position = UDim2.new(0, 5, 0, 65)
    coordsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    coordsFrame.Parent = container
    
    local coordsCorner = Instance.new("UICorner")
    coordsCorner.CornerRadius = UDim.new(0, 6)
    coordsCorner.Parent = coordsFrame
    
    local xLabel = Instance.new("TextLabel")
    xLabel.Size = UDim2.new(0.3, -5, 0.2, 0)
    xLabel.Position = UDim2.new(0, 5, 0.05, 0)
    xLabel.BackgroundTransparency = 1
    xLabel.Text = "X:"
    xLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    xLabel.Font = Enum.Font.Gotham
    xLabel.TextSize = 12
    xLabel.Parent = coordsFrame
    
    local xBox = Instance.new("TextBox")
    xBox.Size = UDim2.new(0.7, -5, 0.2, 0)
    xBox.Position = UDim2.new(0.3, 0, 0.05, 0)
    xBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    xBox.Text = "0"
    xBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    xBox.Font = Enum.Font.Gotham
    xBox.TextSize = 12
    xBox.Parent = coordsFrame
    
    local xCorner = Instance.new("UICorner")
    xCorner.CornerRadius = UDim.new(0, 4)
    xCorner.Parent = xBox
    
    local yLabel = Instance.new("TextLabel")
    yLabel.Size = UDim2.new(0.3, -5, 0.2, 0)
    yLabel.Position = UDim2.new(0, 5, 0.3, 0)
    yLabel.BackgroundTransparency = 1
    yLabel.Text = "Y:"
    yLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    yLabel.Font = Enum.Font.Gotham
    yLabel.TextSize = 12
    yLabel.Parent = coordsFrame
    
    local yBox = Instance.new("TextBox")
    yBox.Size = UDim2.new(0.7, -5, 0.2, 0)
    yBox.Position = UDim2.new(0.3, 0, 0.3, 0)
    yBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    yBox.Text = "0"
    yBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    yBox.Font = Enum.Font.Gotham
    yBox.TextSize = 12
    yBox.Parent = coordsFrame
    
    local yCorner = Instance.new("UICorner")
    yCorner.CornerRadius = UDim.new(0, 4)
    yCorner.Parent = yBox
    
    local zLabel = Instance.new("TextLabel")
    zLabel.Size = UDim2.new(0.3, -5, 0.2, 0)
    zLabel.Position = UDim2.new(0, 5, 0.55, 0)
    zLabel.BackgroundTransparency = 1
    zLabel.Text = "Z:"
    zLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    zLabel.Font = Enum.Font.Gotham
    zLabel.TextSize = 12
    zLabel.Parent = coordsFrame
    
    local zBox = Instance.new("TextBox")
    zBox.Size = UDim2.new(0.7, -5, 0.2, 0)
    zBox.Position = UDim2.new(0.3, 0, 0.55, 0)
    zBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    zBox.Text = "0"
    zBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    zBox.Font = Enum.Font.Gotham
    zBox.TextSize = 12
    zBox.Parent = coordsFrame
    
    local zCorner = Instance.new("UICorner")
    zCorner.CornerRadius = UDim.new(0, 4)
    zCorner.Parent = zBox
    
    local setCurrentBtn = Instance.new("TextButton")
    setCurrentBtn.Size = UDim2.new(0.9, 0, 0.2, 0)
    setCurrentBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
    setCurrentBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    setCurrentBtn.Text = "SET CURRENT POSITION"
    setCurrentBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    setCurrentBtn.Font = Enum.Font.Gotham
    setCurrentBtn.TextSize = 12
    setCurrentBtn.Parent = coordsFrame
    
    local setCurrentCorner = Instance.new("UICorner")
    setCurrentCorner.CornerRadius = UDim.new(0, 4)
    setCurrentCorner.Parent = setCurrentBtn
    
    local teleportCoordsBtn = Instance.new("TextButton")
    teleportCoordsBtn.Size = UDim2.new(1, -10, 0, 25)
    teleportCoordsBtn.Position = UDim2.new(0, 5, 0, 180)
    teleportCoordsBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    teleportCoordsBtn.Text = "TELEPORT TO COORDINATES"
    teleportCoordsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportCoordsBtn.Font = Enum.Font.Gotham
    teleportCoordsBtn.TextSize = 12
    teleportCoordsBtn.Parent = container
    
    local teleportCoordsCorner = Instance.new("UICorner")
    teleportCoordsCorner.CornerRadius = UDim.new(0, 6)
    teleportCoordsCorner.Parent = teleportCoordsBtn
    
    -- Button Events
    tpPlayerBtn.MouseButton1Click:Connect(function()
        Teleport.ShowPlayerList()
    end)
    
    refreshBtn.MouseButton1Click:Connect(function()
        Teleport.ShowPlayerList()
    end)
    
    setCurrentBtn.MouseButton1Click:Connect(function()
        Teleport.SetCurrentPosition(xBox, yBox, zBox)
    end)
    
    teleportCoordsBtn.MouseButton1Click:Connect(function()
        Teleport.TeleportToCoordinates(xBox, yBox, zBox)
    end)
end

function Teleport.ShowPlayerList()
    -- Create player list GUI
    local playerGui = Instance.new("ScreenGui")
    playerGui.Name = "PlayerListGUI"
    playerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    playerGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 200, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.Parent = playerGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    title.Text = "SELECT PLAYER"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = title
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = title
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -40)
    scrollFrame.Position = UDim2.new(0, 5, 0, 35)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 5
    scrollFrame.Parent = mainFrame
    
    -- Add players
    local yPos = 5
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local playerBtn = Instance.new("TextButton")
            playerBtn.Size = UDim2.new(1, -10, 0, 25)
            playerBtn.Position = UDim2.new(0, 5, 0, yPos)
            playerBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            playerBtn.Text = player.Name
            playerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerBtn.Font = Enum.Font.Gotham
            playerBtn.TextSize = 12
            playerBtn.Parent = scrollFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = playerBtn
            
            playerBtn.MouseButton1Click:Connect(function()
                Teleport.TeleportToPlayer(player)
                playerGui:Destroy()
            end)
            
            yPos = yPos + 30
        end
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
    
    closeBtn.MouseButton1Click:Connect(function()
        playerGui:Destroy()
    end)
    
    playerGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

function Teleport.TeleportToPlayer(player)
    if character and player.Character then
        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot and humanoidRootPart then
            humanoidRootPart.CFrame = targetRoot.CFrame
            Teleport.ShowNotification("Teleport", "Teleported to " .. player.Name)
        end
    end
end

function Teleport.SetCurrentPosition(xBox, yBox, zBox)
    if humanoidRootPart then
        local position = humanoidRootPart.Position
        xBox.Text = tostring(math.floor(position.X))
        yBox.Text = tostring(math.floor(position.Y))
        zBox.Text = tostring(math.floor(position.Z))
        Teleport.ShowNotification("Coordinates", "Current position set!")
    end
end

function Teleport.TeleportToCoordinates(xBox, yBox, zBox)
    if humanoidRootPart then
        local x = tonumber(xBox.Text) or 0
        local y = tonumber(yBox.Text) or 0
        local z = tonumber(zBox.Text) or 0
        
        humanoidRootPart.CFrame = CFrame.new(x, y, z)
        Teleport.ShowNotification("Teleport", "Teleported to coordinates!")
    end
end

function Teleport.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

return Teleport
