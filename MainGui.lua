-- Main GUI - Simple Working Version
local MainGUI = {}

function MainGUI:Create(core, modules)
    self.Core = core
    self.Modules = modules
    
    -- Create GUI
    local CoreGui = game:GetService("CoreGui")
    
    self.MainGui = Instance.new("ScreenGui")
    self.MainGui.Name = "LunarScriptGUI"
    self.MainGui.ResetOnSpawn = false
    self.MainGui.Parent = CoreGui
    
    self:CreateMainWindow()
    
    return self
end

function MainGUI:CreateMainWindow()
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = self.MainGui
    
    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    title.Text = "Lunar Script v" .. self.Core.Version
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = title
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        self.MainGui:Destroy()
    end)
    
    -- Content Area
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -60)
    content.Position = UDim2.new(0, 10, 0, 50)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame
    
    -- Create Buttons
    self:CreateButtons(content)
end

function MainGUI:CreateButtons(content)
    local buttons = {
        {
            Name = "Infinity Jump: OFF",
            Color = Color3.fromRGB(65, 105, 225),
            Action = function(btn)
                if self.Modules.Movement then
                    self.Modules.Movement:ToggleInfinityJump()
                    btn.Text = "Infinity Jump: " .. (self.Core.States.InfinityJump and "ON" or "OFF")
                end
            end
        },
        {
            Name = "Walk Speed: OFF", 
            Color = Color3.fromRGB(70, 130, 180),
            Action = function(btn)
                if self.Modules.Movement then
                    self.Modules.Movement:ToggleWalkSpeed()
                    btn.Text = "Walk Speed: " .. (self.Core.States.WalkSpeedEnabled and "ON" or "OFF")
                end
            end
        },
        {
            Name = "SCAN BACKDOOR",
            Color = Color3.fromRGB(255, 165, 0),
            Action = function()
                if self.Modules.Backdoor then
                    self.Modules.Backdoor:ScanBackdoors()
                end
            end
        },
        {
            Name = "ANTI DIE: OFF",
            Color = Color3.fromRGB(220, 20, 60),
            Action = function(btn)
                if self.Modules.AntiDie then
                    self.Modules.AntiDie:ToggleAntiDie()
                    btn.Text = "ANTI DIE: " .. (self.Modules.AntiDie.Active and "ON" or "OFF")
                end
            end
        },
        {
            Name = "SET SPAWN POINT",
            Color = Color3.fromRGB(60, 179, 113),
            Action = function()
                if self.Modules.Teleport then
                    self.Modules.Teleport:SetSpawnPoint()
                end
            end
        }
    }
    
    for i, buttonInfo in ipairs(buttons) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 35)
        button.Position = UDim2.new(0, 0, 0, (i-1) * 45)
        button.BackgroundColor3 = buttonInfo.Color
        button.Text = buttonInfo.Name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 12
        button.Parent = content
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            buttonInfo.Action(button)
        end)
    end
end

return MainGUI
