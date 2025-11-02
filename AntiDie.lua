-- Lunar Script AntiDie Module
local AntiDie = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- Variables
local localPlayer = Players.LocalPlayer
local character
local humanoid
local antiDieEnabled = false
local backdoor = nil
local scanInProgress = false

function AntiDie.Initialize(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    print("💀 AntiDie module initialized")
end

function AntiDie.CreateGUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 100)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    -- Anti Die Button
    local antiDieBtn = Instance.new("TextButton")
    antiDieBtn.Size = UDim2.new(1, -10, 0, 30)
    antiDieBtn.Position = UDim2.new(0, 5, 0, 5)
    antiDieBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    antiDieBtn.Text = "ANTI DIE"
    antiDieBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    antiDieBtn.Font = Enum.Font.Gotham
    antiDieBtn.TextSize = 12
    antiDieBtn.Parent = container
    
    local antiDieCorner = Instance.new("UICorner")
    antiDieCorner.CornerRadius = UDim.new(0, 6)
    antiDieCorner.Parent = antiDieBtn
    
    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -10, 0, 20)
    statusLabel.Position = UDim2.new(0, 5, 0, 40)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Press ANTI DIE to scan and enable immortality"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 10
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = container
    
    -- Info Label
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -10, 0, 30)
    infoLabel.Position = UDim2.new(0, 5, 0, 65)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "Uses backdoor to make you immortal. Requires backdoor access."
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 10
    infoLabel.TextWrapped = true
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.Parent = container
    
    -- Button Event
    antiDieBtn.MouseButton1Click:Connect(function()
        AntiDie.ToggleAntiDie(antiDieBtn, statusLabel)
    end)
end

function AntiDie.ToggleAntiDie(button, statusLabel)
    if scanInProgress then
        AntiDie.ShowNotification("Anti Die", "Scan already in progress!")
        return
    end
    
    if antiDieEnabled then
        -- Disable Anti Die
        antiDieEnabled = false
        button.Text = "ANTI DIE"
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        statusLabel.Text = "Anti Die disabled"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        AntiDie.ShowNotification("Anti Die", "Anti Die disabled")
    else
        -- Start scanning for backdoor
        scanInProgress = true
        button.Text = "SCANNING..."
        button.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        statusLabel.Text = "Scanning for backdoor..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
        
        spawn(function()
            local found = AntiDie.ScanForBackdoor()
            
            if found then
                antiDieEnabled = true
                button.Text = "ANTI DIE: ACTIVE"
                button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
                statusLabel.Text = "ANTI DIE ACTIVE - You are immortal!"
                statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                AntiDie.EnableAntiDie()
                AntiDie.ShowNotification("ANTI DIE", "ACTIVATED! You are now immortal!")
            else
                button.Text = "ANTI DIE"
                button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
                statusLabel.Text = "No backdoor found. Anti Die requires backdoor access."
                statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                AntiDie.ShowNotification("Anti Die", "Failed: No backdoor found")
            end
            
            scanInProgress = false
        end)
    end
end

function AntiDie.ScanForBackdoor()
    -- Cari backdoor yang sudah ada di game
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) then
            local name = string.lower(obj.Name)
            if string.find(name, "admin") or string.find(name, "backdoor") or string.find(name, "kill") then
                backdoor = obj
                print("🎯 Found potential backdoor: " .. obj:GetFullName())
                return true
            end
        end
    end
    
    -- Cari di Workspace
    for _, obj in pairs(Workspace:GetDescendants()) do
        if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) then
            local name = string.lower(obj.Name)
            if string.find(name, "admin") or string.find(name, "backdoor") or string.find(name, "kill") then
                backdoor = obj
                print("🎯 Found potential backdoor: " .. obj:GetFullName())
                return true
            end
        end
    end
    
    return false
end

function AntiDie.EnableAntiDie()
    if not backdoor then
        AntiDie.ShowNotification("Anti Die Error", "No backdoor found!")
        return
    end
    
    -- Script immortal yang akan dijalankan via backdoor
    local immortalScript = [[
        -- Anti Die Script via Backdoor
        local Players = game:GetService("Players")
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    -- Buat immortal
                    humanoid.Health = math.huge
                    humanoid.MaxHealth = math.huge
                    
                    -- Prevent death
                    local connection
                    connection = humanoid.HealthChanged:Connect(function()
                        if humanoid.Health < humanoid.MaxHealth then
                            humanoid.Health = humanoid.MaxHealth
                        end
                    end)
                    
                    -- Anti fall damage
                    local function preventDeath()
                        if humanoid.Health <= 0 then
                            humanoid.Health = humanoid.MaxHealth
                        end
                    end
                    
                    humanoid.Died:Connect(preventDeath)
                end
            end
        end
        
        return "Anti Die activated for all players"
    ]]
    
    -- Jalankan script via backdoor
    if backdoor:IsA("RemoteEvent") then
        pcall(function()
            backdoor:FireServer(immortalScript)
        end)
    elseif backdoor:IsA("RemoteFunction") then
        pcall(function()
            backdoor:InvokeServer(immortalScript)
        end)
    end
    
    -- Juga aktifkan protection lokal sebagai backup
    AntiDie.EnableLocalProtection()
end

function AntiDie.EnableLocalProtection()
    if not character or not humanoid then return end
    
    -- Local protection sebagai backup
    spawn(function()
        while antiDieEnabled and character and humanoid do
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
            
            if humanoid.Health <= 0 then
                humanoid.Health = humanoid.MaxHealth
            end
            
            wait(0.1)
        end
    end)
    
    -- Handle character respawn
    localPlayer.CharacterAdded:Connect(function(newChar)
        character = newChar
        humanoid = newChar:WaitForChild("Humanoid")
        
        if antiDieEnabled then
            wait(1) -- Tunggu character fully loaded
            AntiDie.EnableLocalProtection()
        end
    end)
end

function AntiDie.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

return AntiDie
