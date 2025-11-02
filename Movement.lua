-- Lunar Script Movement Module
local Movement = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local localPlayer = Players.LocalPlayer
local character
local humanoid
local walkSpeedEnabled = false
local jumpPowerEnabled = false
local infinityJumpEnabled = false
local antiSlowEnabled = false
local antiLowJumpEnabled = false

function Movement.Initialize(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    print("🏃 Movement module initialized")
end

function Movement.CreateGUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 200)
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
    
    local walkSpeedToggle = Instance.new("TextButton")
    walkSpeedToggle.Size = UDim2.new(0.3, -5, 0, 25)
    walkSpeedToggle.Position = UDim2.new(0, 5, 0, 90)
    walkSpeedToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    walkSpeedToggle.Text = "OFF"
    walkSpeedToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    walkSpeedToggle.Font = Enum.Font.Gotham
    walkSpeedToggle.TextSize = 12
    walkSpeedToggle.Parent = container
    
    local walkSpeedCorner = Instance.new("UICorner")
    walkSpeedCorner.CornerRadius = UDim.new(0, 6)
    walkSpeedCorner.Parent = walkSpeedToggle
    
    local walkSpeedContainer = Instance.new("Frame")
    walkSpeedContainer.Size = UDim2.new(0.65, -5, 0, 25)
    walkSpeedContainer.Position = UDim2.new(0.35, 0, 0, 90)
    walkSpeedContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    walkSpeedContainer.Parent = container
    
    local walkSpeedCorner2 = Instance.new("UICorner")
    walkSpeedCorner2.CornerRadius = UDim.new(0, 6)
    walkSpeedCorner2.Parent = walkSpeedContainer
    
    local walkSpeedBox = Instance.new("TextBox")
    walkSpeedBox.Size = UDim2.new(0.7, 0, 1, 0)
    walkSpeedBox.Position = UDim2.new(0, 5, 0, 0)
    walkSpeedBox.BackgroundTransparency = 1
    walkSpeedBox.Text = "16"
    walkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedBox.Font = Enum.Font.Gotham
    walkSpeedBox.TextSize = 12
    walkSpeedBox.PlaceholderText = "Enter speed"
    walkSpeedBox.Parent = walkSpeedContainer
    
    local walkSpeedSet = Instance.new("TextButton")
    walkSpeedSet.Size = UDim2.new(0.25, -5, 0.8, 0)
    walkSpeedSet.Position = UDim2.new(0.75, 0, 0.1, 0)
    walkSpeedSet.BackgroundColor3 = Color3.fromRGB(60, 179, 113)
    walkSpeedSet.Text = "SET"
    walkSpeedSet.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedSet.Font = Enum.Font.Gotham
    walkSpeedSet.TextSize = 10
    walkSpeedSet.Parent = walkSpeedContainer
    
    local setCorner = Instance.new("UICorner")
    setCorner.CornerRadius = UDim.new(0, 4)
    setCorner.Parent = walkSpeedSet
    
    -- Button Events
    infinityJumpBtn.MouseButton1Click:Connect(function()
        Movement.ToggleInfinityJump(infinityJumpBtn)
    end)
    
    walkSpeedToggle.MouseButton1Click:Connect(function()
        Movement.ToggleWalkSpeed(walkSpeedToggle, walkSpeedBox)
    end)
    
    walkSpeedSet.MouseButton1Click:Connect(function()
        Movement.SetWalkSpeed(walkSpeedBox)
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
    connection = game:GetService("UserInputService").JumpRequest:Connect(function()
        if infinityJumpEnabled and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

function Movement.DisableInfinityJump()
    -- Connection akan terputus ketika di-disable
end

function Movement.ToggleWalkSpeed(button, textBox)
    walkSpeedEnabled = not walkSpeedEnabled
    
    if walkSpeedEnabled then
        button.Text = "ON"
        button.TextColor3 = Color3.fromRGB(100, 255, 100)
        Movement.SetWalkSpeed(textBox)
    else
        button.Text = "OFF"
        button.TextColor3 = Color3.fromRGB(255, 100, 100)
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
end

function Movement.SetWalkSpeed(textBox)
    if not walkSpeedEnabled then
        Movement.ShowNotification("Walk Speed", "Please enable Walk Speed first!")
        return
    end
    
    local speed = tonumber(textBox.Text)
    if speed and humanoid then
        humanoid.WalkSpeed = speed
        Movement.ShowNotification("Walk Speed", "Speed set to " .. speed)
    else
        Movement.ShowNotification("Error", "Please enter a valid number!")
    end
end

function Movement.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

return Movement
