-- Lunar Script Main Core System
local Main = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local localPlayer = Players.LocalPlayer
local modules = {}
local settings = {
    Theme = "dark",
    RGBMode = true,
    AutoSave = true
}

function Main.Initialize(loadedModules)
    modules = loadedModules
    print("🔧 Initializing Lunar Script Core...")
    
    -- Show welcome notification
    StarterGui:SetCore("SendNotification", {
        Title = "Lunar Script",
        Text = "Loaded successfully!",
        Icon = "rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
        Duration = 5
    })
    
    -- Setup event handlers
    Main.SetupPlayerEvents()
    Main.SetupInputHandlers()
    
    -- Initialize GUI
    if modules.MainGui then
        modules.MainGui.Initialize(modules, settings)
    end
    
    return true
end

function Main.SetupPlayerEvents()
    -- Handle character spawn
    localPlayer.CharacterAdded:Connect(function(character)
        Main.OnCharacterSpawn(character)
    end)
    
    if localPlayer.Character then
        Main.OnCharacterSpawn(localPlayer.Character)
    end
end

function Main.SetupInputHandlers()
    -- Global keybinds
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        
        if input.KeyCode == Enum.KeyCode.RightShift then
            -- Toggle GUI
            if modules.MainGui then
                modules.MainGui.ToggleGUI()
            end
        end
    end)
end

function Main.OnCharacterSpawn(character)
    print("🎭 Character spawned, initializing modules...")
    
    -- Initialize movement system
    if modules.Movement then
        modules.Movement.Initialize(character)
    end
    
    -- Update GUI dengan character info
    if modules.MainGui then
        modules.MainGui.UpdateCharacterInfo(character)
    end
end

function Main.GetModule(moduleName)
    return modules[moduleName]
end

function Main.GetSettings()
    return settings
end

function Main.UpdateSetting(key, value)
    if settings[key] ~= nil then
        settings[key] = value
        print("⚙️ Setting updated: " .. key .. " = " .. tostring(value))
        return true
    end
    return false
end

function Main.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = "rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
        Duration = 3
    })
end

return Main
