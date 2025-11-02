-- Lunar Script Movement Module
local Movement = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local localPlayer = Players.LocalPlayer
local character
local humanoid

-- Movement states
local walkspeedEnabled = false
local jumppowerEnabled = false
local infinityJumpEnabled = false
local antiSlowEnabled = false
local antiLowJumpEnabled = false
local flyEnabled = false

function Movement.Initialize(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    print("🏃 Movement module initialized")
end

function Movement.CreateGUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 300)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    -- Movement Title
    local movementTitle = Instance.new("TextLabel")
    movementTitle.Size = UDim2.new(1, -10, 0, 25)
    movementTitle.Position = UDim2.new(0, 5, 0, 5)
    movementTitle.BackgroundTransparency = 1
    movementTitle.Text = "MOVEMENT"
    movementTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    movementTitle.Font = Enum.Font.GothamBold
    movementTitle.TextSize = 14
    movementTitle.TextXAlignment = Enum.TextXAlignment.Left
    movementTitle.Parent = container
    
    -- Infinity Jump
    local infinityJumpBtn = Instance.new("TextButton")
    infinityJumpBtn.Size = UDim2.new(1, -10, 0, 25)
    infinityJumpBtn.Position = UDim2.new(0, 5, 0, 35)
    infinityJumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    infinityJumpBtn.Text = "Infinity Jump: OFF"
    infinityJumpBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    infinityJumpBtn.Font = Enum.Font.Gotham
    infinityJumpBtn.TextSize = 12
    infinityJumpBtn.Parent = container
    
    local infinityCorner = Instance.new("UICorner")
    infinityCorner.CornerRadius = UDim.new(0, 6)
    infinityCorner.Parent = infinityJumpBtn
    
    -- Walk Speed
    local walkSpeedTitle = Instance.new("TextLabel")
    walkSpeedTitle.Size = UDim2.new(1, -10, 0, 20)
    walkSpeedTitle.Position = UDim2.new(0, 5, 0, 65)
    walkSpeedTitle.BackgroundTransparency = 1
    walkSpeedTitle.Text = "Walk Speed"
    walkSpeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedTitle.Font = Enum.Font.Gotham
    walkSpeedTitle.TextSize = 12
    walkSpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
    walkSpeedTitle.Parent = container
    
    local walkSpeedContainer = Instance.new("Frame")
    walkSpeedContainer.Size = UDim2.new(1, -10, 0, 25)
    walkSpeedContainer.Position = UDim2.new(0, 5, 0, 90)
    walkSpeedContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    walkSpeedContainer.Parent = container
    
    local walkSpeedCorner = Instance.new("UICorner")
    walkSpeedCorner.CornerRadius = UDim.new(0, 6)
    walkSpeedCorner.Parent = walkSpeedContainer
    
    local walkSpeedBox = Instance.new("TextBox")
    walkSpeedBox.Size = UDim2.new(0.6, 0, 1, 0)
    walkSpeedBox.Position = UDim2.new(0, 5, 0, 0)
    walkSpeedBox.BackgroundTransparency = 1
    walkSpeedBox.Text = "16"
    walkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedBox.Font = Enum.Font.Gotham
    walkSpeedBox.TextSize = 12
    walkSpeedBox.PlaceholderText = "Enter speed"
    walkSpeedBox.Parent = walkSpeedContainer
    
    local walkSpeedBtn = Instance.new("TextButton")
    walkSpeedBtn.Size = UDim2.new(0.35, -5, 0.8, 0)
    walkSpeedBtn.Position = UDim2.new(0.65, 0, 0.1, 0)
    walkSpeedBtn.BackgroundColor3 = Color3.fromRGB(60, 179, 113)
    walkSpeedBtn.Text = "SET WALKSPEED"
    walkSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedBtn.Font = Enum.Font.Gotham
    walkSpeedBtn.TextSize = 10
    walkSpeedBtn.Parent = walkSpeedContainer
    
    local walkSpeedCorner2 = Instance.new("UICorner")
    walkSpeedCorner2.CornerRadius = UDim.new(0, 4)
    walkSpeedCorner2.Parent = walkSpeedBtn
    
    -- Jump Power
    local jumpPowerTitle = Instance.new("TextLabel")
    jumpPowerTitle.Size = UDim2.new(1, -10, 0, 20)
    jumpPowerTitle.Position = UDim2.new(0, 5, 0, 120)
    jumpPowerTitle.BackgroundTransparency = 1
    jumpPowerTitle.Text = "Jump Power"
    jumpPowerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpPowerTitle.Font = Enum.Font.Gotham
    jumpPowerTitle.TextSize = 12
    jumpPowerTitle.TextXAlignment = Enum.TextXAlignment.Left
    jumpPowerTitle.Parent = container
    
    local jumpPowerContainer = Instance.new("Frame")
    jumpPowerContainer.Size = UDim2.new(1, -10, 0, 25)
    jumpPowerContainer.Position = UDim2.new(0, 5, 0, 145)
    jumpPowerContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    jumpPowerContainer.Parent = container
    
    local jumpPowerCorner = Instance.new("UICorner")
    jumpPowerCorner.CornerRadius = UDim.new(0, 6)
    jumpPowerCorner.Parent = jumpPowerContainer
    
    local jumpPowerBox = Instance.new("TextBox")
    jumpPowerBox.Size = UDim2.new(0.6, 0, 1, 0)
    jumpPowerBox.Position = UDim2.new(0, 5, 0, 0)
    jumpPowerBox.BackgroundTransparency = 1
    jumpPowerBox.Text = "50"
    jumpPowerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpPowerBox.Font = Enum.Font.Gotham
    jumpPowerBox.TextSize = 12
    jumpPowerBox.PlaceholderText = "Enter jump power"
    jumpPowerBox.Parent = jumpPowerContainer
    
    local jumpPowerBtn = Instance.new("TextButton")
    jumpPowerBtn.Size = UDim2.new(0.35, -5, 0.8, 0)
    jumpPowerBtn.Position = UDim2.new(0.65, 0, 0.1, 0)
    jumpPowerBtn.BackgroundColor3 = Color3.fromRGB(60, 179, 113)
    jumpPowerBtn.Text = "SET JUMPPOWER"
    jumpPowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpPowerBtn.Font = Enum.Font.Gotham
    jumpPowerBtn.TextSize = 10
    jumpPowerBtn.Parent = jumpPowerContainer
    
    local jumpPowerCorner2 = Instance.new("UICorner")
    jumpPowerCorner2.CornerRadius = UDim.new(0, 4)
    jumpPowerCorner2.Parent = jumpPowerBtn
    
    -- Fly GUI Button
    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(1, -10, 0, 30)
    flyBtn.Position = UDim2.new(0, 5, 0, 175)
    flyBtn.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    flyBtn.Text = "FLY GUI"
    flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.TextSize = 12
    flyBtn.Parent = container
    
    local flyCorner = Instance.new("UICorner")
    flyCorner.CornerRadius = UDim.new(0, 6)
    flyCorner.Parent = flyBtn
    
    -- Anti Slow & Anti Low Jump
    local antiSlowBtn = Instance.new("TextButton")
    antiSlowBtn.Size = UDim2.new(0.48, -5, 0, 25)
    antiSlowBtn.Position = UDim2.new(0, 5, 0, 210)
    antiSlowBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    antiSlowBtn.Text = "Anti Slow: OFF"
    antiSlowBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    antiSlowBtn.Font = Enum.Font.Gotham
    antiSlowBtn.TextSize = 12
    antiSlowBtn.Parent = container
    
    local antiSlowCorner = Instance.new("UICorner")
    antiSlowCorner.CornerRadius = UDim.new(0, 6)
    antiSlowCorner.Parent = antiSlowBtn
    
    local antiLowJumpBtn = Instance.new("TextButton")
    antiLowJumpBtn.Size = UDim2.new(0.48, -5, 0, 25)
    antiLowJumpBtn.Position = UDim2.new(0.52, 0, 0, 210)
    antiLowJumpBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    antiLowJumpBtn.Text = "Anti Low Jump: OFF"
    antiLowJumpBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    antiLowJumpBtn.Font = Enum.Font.Gotham
    antiLowJumpBtn.TextSize = 12
    antiLowJumpBtn.Parent = container
    
    local antiLowJumpCorner = Instance.new("UICorner")
    antiLowJumpCorner.CornerRadius = UDim.new(0, 6)
    antiLowJumpCorner.Parent = antiLowJumpBtn
    
    -- Button Events
    infinityJumpBtn.MouseButton1Click:Connect(function()
        Movement.ToggleInfinityJump(infinityJumpBtn)
    end)
    
    walkSpeedBtn.MouseButton1Click:Connect(function()
        Movement.SetWalkSpeed(walkSpeedBox)
    end)
    
    jumpPowerBtn.MouseButton1Click:Connect(function()
        Movement.SetJumpPower(jumpPowerBox)
    end)
    
    flyBtn.MouseButton1Click:Connect(function()
        Movement.OpenFlyGUI()
    end)
    
    antiSlowBtn.MouseButton1Click:Connect(function()
        Movement.ToggleAntiSlow(antiSlowBtn)
    end)
    
    antiLowJumpBtn.MouseButton1Click:Connect(function()
        Movement.ToggleAntiLowJump(antiLowJumpBtn)
    end)
end

function Movement.ToggleInfinityJump(button)
    infinityJumpEnabled = not infinityJumpEnabled
    
    if infinityJumpEnabled then
        button.Text = "Infinity Jump: ON"
        button.TextColor3 = Color3.fromRGB(100, 255, 100)
        Movement.EnableInfinityJump()
    else
        button.Text = "Infinity Jump: OFF"
        button.TextColor3 = Color3.fromRGB(255, 100, 100)
        Movement.DisableInfinityJump()
    end
end

function Movement.EnableInfinityJump()
    local connection
    connection = UserInputService.JumpRequest:Connect(function()
        if infinityJumpEnabled and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

function Movement.DisableInfinityJump()
    -- Connection will be disconnected when disabled
end

function Movement.SetWalkSpeed(textBox)
    local speed = tonumber(textBox.Text)
    if speed and humanoid then
        humanoid.WalkSpeed = speed
        Movement.ShowNotification("Walk Speed", "Speed set to " .. speed)
    else
        Movement.ShowNotification("Error", "Please enter a valid number!")
    end
end

function Movement.SetJumpPower(textBox)
    local power = tonumber(textBox.Text)
    if power and humanoid then
        humanoid.JumpPower = power
        Movement.ShowNotification("Jump Power", "Jump power set to " .. power)
    else
        Movement.ShowNotification("Error", "Please enter a valid number!")
    end
end

function Movement.ToggleAntiSlow(button)
    antiSlowEnabled = not antiSlowEnabled
    
    if antiSlowEnabled then
        button.Text = "Anti Slow: ON"
        button.TextColor3 = Color3.fromRGB(100, 255, 100)
        Movement.ShowNotification("Anti Slow", "Anti Slow enabled!")
    else
        button.Text = "Anti Slow: OFF"
        button.TextColor3 = Color3.fromRGB(255, 100, 100)
        Movement.ShowNotification("Anti Slow", "Anti Slow disabled!")
    end
end

function Movement.ToggleAntiLowJump(button)
    antiLowJumpEnabled = not antiLowJumpEnabled
    
    if antiLowJumpEnabled then
        button.Text = "Anti Low Jump: ON"
        button.TextColor3 = Color3.fromRGB(100, 255, 100)
        Movement.ShowNotification("Anti Low Jump", "Anti Low Jump enabled!")
    else
        button.Text = "Anti Low Jump: OFF"
        button.TextColor3 = Color3.fromRGB(255, 100, 100)
        Movement.ShowNotification("Anti Low Jump", "Anti Low Jump disabled!")
    end
end

function Movement.OpenFlyGUI()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    Movement.ShowNotification("Fly GUI", "Fly script executed!")
end

function Movement.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

return Movement
