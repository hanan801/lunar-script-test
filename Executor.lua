-- Lunar Script Executor Module
local Executor = {}

-- Services
local StarterGui = game:GetService("StarterGui")

-- Variables
local savedScripts = {}

function Executor.Initialize()
    print("📜 Executor module initialized")
end

function Executor.CreateGUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 400)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "SCRIPT EXECUTOR"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = container
    
    -- Script Box
    local scriptBox = Instance.new("TextBox")
    scriptBox.Size = UDim2.new(1, -10, 0, 200)
    scriptBox.Position = UDim2.new(0, 5, 0, 35)
    scriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptBox.Font = Enum.Font.Gotham
    scriptBox.TextSize = 12
    scriptBox.TextWrapped = true
    scriptBox.MultiLine = true
    scriptBox.PlaceholderText = "Paste your script here (supports loadstring and Lua code)..."
    
    local scriptCorner = Instance.new("UICorner")
    scriptCorner.CornerRadius = UDim.new(0, 6)
    scriptCorner.Parent = scriptBox
    
    scriptBox.Parent = container
    
    -- Button Container
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, -10, 0, 35)
    buttonContainer.Position = UDim2.new(0, 5, 0, 245)
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
    
    -- Saved Scripts
    local savedTitle = Instance.new("TextLabel")
    savedTitle.Size = UDim2.new(1, -10, 0, 25)
    savedTitle.Position = UDim2.new(0, 5, 0, 290)
    savedTitle.BackgroundTransparency = 1
    savedTitle.Text = "SAVED SCRIPTS"
    savedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    savedTitle.Font = Enum.Font.GothamBold
    savedTitle.TextSize = 14
    savedTitle.TextXAlignment = Enum.TextXAlignment.Left
    savedTitle.Parent = container
    
    local savedFrame = Instance.new("ScrollingFrame")
    savedFrame.Size = UDim2.new(1, -10, 0, 80)
    savedFrame.Position = UDim2.new(0, 5, 0, 320)
    savedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    savedFrame.ScrollBarThickness = 8
    savedFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local savedCorner = Instance.new("UICorner")
    savedCorner.CornerRadius = UDim.new(0, 6)
    savedCorner.Parent = savedFrame
    
    savedFrame.Parent = container
    
    -- Button Events
    executeButton.MouseButton1Click:Connect(function()
        Executor.ExecuteScript(scriptBox.Text)
    end)
    
    clearButton.MouseButton1Click:Connect(function()
        scriptBox.Text = ""
        Executor.ShowNotification("Executor", "Script cleared!")
    end)
    
    saveButton.MouseButton1Click:Connect(function()
        Executor.SaveScript(scriptBox.Text, savedFrame)
    end)
    
    -- Load saved scripts
    Executor.LoadSavedScripts(savedFrame)
end

function Executor.ExecuteScript(scriptText)
    if scriptText == "" then
        Executor.ShowNotification("Executor Error", "Please enter a script!")
        return
    end
    
    local success, result = pcall(function()
        if string.sub(scriptText, 1, 8) == "loadstring" or string.find(scriptText, "function") then
            local loaded = loadstring(scriptText)
            if loaded then
                loaded()
            else
                error("Failed to load script")
            end
        else
            loadstring(scriptText)()
        end
    end)
    
    if success then
        Executor.ShowNotification("Executor", "Script executed successfully!")
    else
        Executor.ShowNotification("Executor Error", "Failed: " .. tostring(result))
    end
end

function Executor.SaveScript(scriptText, savedFrame)
    if scriptText ~= "" then
        local scriptName = string.sub(scriptText, 1, 20)
        table.insert(savedScripts, {
            name = scriptName,
            script = scriptText
        })
        Executor.UpdateSavedScripts(savedFrame)
        Executor.ShowNotification("Executor", "Script saved!")
    else
        Executor.ShowNotification("Executor Error", "Cannot save empty script!")
    end
end

function Executor.UpdateSavedScripts(savedFrame)
    -- Clear existing scripts
    for _, child in ipairs(savedFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Add saved scripts
    local yPosition = 5
    for i, savedScript in ipairs(savedScripts) do
        local scriptFrame = Instance.new("Frame")
        scriptFrame.Size = UDim2.new(1, -10, 0, 30)
        scriptFrame.Position = UDim2.new(0, 5, 0, yPosition)
        scriptFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        scriptFrame.Parent = savedFrame
        
        local scriptCorner = Instance.new("UICorner")
        scriptCorner.CornerRadius = UDim.new(0, 4)
        scriptCorner.Parent = scriptFrame
        
        local scriptName = Instance.new("TextLabel")
        scriptName.Size = UDim2.new(0.5, 0, 1, 0)
        scriptName.Position = UDim2.new(0, 5, 0, 0)
        scriptName.BackgroundTransparency = 1
        scriptName.Text = savedScript.name
        scriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
        scriptName.Font = Enum.Font.Gotham
        scriptName.TextSize = 12
        scriptName.TextXAlignment = Enum.TextXAlignment.Left
        scriptName.Parent = scriptFrame
        
        local loadButton = Instance.new("TextButton")
        loadButton.Size = UDim2.new(0.2, 0, 0.8, 0)
        loadButton.Position = UDim2.new(0.5, 5, 0.1, 0)
        loadButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        loadButton.Text = "LOAD"
        loadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        loadButton.Font = Enum.Font.Gotham
        loadButton.TextSize = 10
        loadButton.Parent = scriptFrame
        
        local loadCorner = Instance.new("UICorner")
        loadCorner.CornerRadius = UDim.new(0, 4)
        loadCorner.Parent = loadButton
        
        local deleteButton = Instance.new("TextButton")
        deleteButton.Size = UDim2.new(0.2, 0, 0.8, 0)
        deleteButton.Position = UDim2.new(0.75, 5, 0.1, 0)
        deleteButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        deleteButton.Text = "DELETE"
        deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        deleteButton.Font = Enum.Font.Gotham
        deleteButton.TextSize = 10
        deleteButton.Parent = scriptFrame
        
        local deleteCorner = Instance.new("UICorner")
        deleteCorner.CornerRadius = UDim.new(0, 4)
        deleteCorner.Parent = deleteButton
        
        -- Button events
        loadButton.MouseButton1Click:Connect(function()
            -- Script akan diload ke executor utama
            Executor.ShowNotification("Executor", "Script loaded to editor!")
        end)
        
        deleteButton.MouseButton1Click:Connect(function()
            table.remove(savedScripts, i)
            Executor.UpdateSavedScripts(savedFrame)
            Executor.ShowNotification("Executor", "Script deleted!")
        end)
        
        yPosition = yPosition + 35
    end
    
    savedFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition)
end

function Executor.LoadSavedScripts(savedFrame)
    -- Load default scripts atau dari storage
    Executor.UpdateSavedScripts(savedFrame)
end

function Executor.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

return Executor
