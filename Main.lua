-- Lunar Script Main System
local Main = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local TextService = game:GetService("TextService")
local Lighting = game:GetService("Lighting")
local MarketplaceService = game:GetService("MarketplaceService")

-- Variables
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local modules = {}
local settings = {
    Theme = "dark",
    RGBMode = true,
    AutoSave = true
}

-- Movement variables
local walkspeedEnabled = false
local jumppowerEnabled = false
local infinityJumpEnabled = false
local antiSlowEnabled = false
local antiLowJumpEnabled = false
local flyEnabled = false
local antiDieEnabled = false
local showCoordsEnabled = false

-- Spawn system
local spawnPoints = {}
local currentSpawn = nil

-- Backdoor variables
local backdoorFound = false
local backdoorRemote = nil

function Main.Initialize(loadedModules)
    modules = loadedModules
    print("🔧 Initializing Lunar Script...")
    
    -- Show welcome notification
    StarterGui:SetCore("SendNotification", {
        Title = "Lunar Script",
        Text = "Loaded successfully!",
        Icon = "rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
        Duration = 5
    })
    
    -- Setup player events
    Main.SetupPlayerEvents()
    
    -- Create GUI
    if modules.MainGui then
        modules.MainGui.Initialize(modules, settings)
    end
    
    return true
end

function Main.SetupPlayerEvents()
    -- Character added event
    localPlayer.CharacterAdded:Connect(function(newChar)
        character = newChar
        humanoid = newChar:WaitForChild("Humanoid")
        
        -- Reapply settings
        if walkspeedEnabled then
            local speed = modules.MainGui.GetWalkSpeed()
            humanoid.WalkSpeed = speed
        end
        
        if jumppowerEnabled then
            local power = modules.MainGui.GetJumpPower()
            humanoid.JumpPower = power
        end
        
        -- Teleport to spawn if set
        if currentSpawn then
            wait(1)
            local root = newChar:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = CFrame.new(currentSpawn.position)
            end
        end
    end)
end

function Main.ShowNotification(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Icon = "rbxthumb://type=Asset&id=112498285326629&w=150&h=150",
        Duration = 3
    })
end

function Main.CopyDiscord()
    local clipboard = setclipboard or toclipboard or set_clipboard
    if clipboard then
        clipboard("https://discord.gg/MKSBJDFFd")
        Main.ShowNotification("Discord", "Discord link copied!")
    else
        Main.ShowNotification("Error", "Clipboard not available")
    end
end

-- Getters for movement values
function Main.GetWalkSpeed()
    return 16 -- Default, will be updated from GUI
end

function Main.GetJumpPower()
    return 50 -- Default, will be updated from GUI
end

-- Backdoor functions
function Main.SetBackdoorFound(remote)
    backdoorFound = true
    backdoorRemote = remote
end

function Main.GetBackdoor()
    return backdoorRemote
end

function Main.IsBackdoorFound()
    return backdoorFound
end

return Main
