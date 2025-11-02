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

-- Variables
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local modules = {}

-- Movement System Variables
local walkspeedEnabled = false
local jumppowerEnabled = false
local infinityJumpEnabled = false
local antiSlowEnabled = false
local antiLowJumpEnabled = false
local flyEnabled = false
local antiDieEnabled = false
local showCoordsEnabled = false

-- Spawn System
local spawnPoints = {}
local currentSpawn = nil

-- Backdoor System
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
        modules.MainGui.Initialize(modules)
    end
    
    return true
end

function Main.SetupPlayerEvents()
    -- Character added event
    localPlayer.CharacterAdded:Connect(function(newChar)
        character = newChar
        humanoid = newChar:WaitForChild("Humanoid")
        
        -- Reapply movement settings
        if walkspeedEnabled then
            humanoid.WalkSpeed = 16
        end
        
        if jumppowerEnabled then
            humanoid.JumpPower = 50
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

-- Movement system functions
function Main.ToggleWalkSpeed(enabled)
    walkspeedEnabled = enabled
    if humanoid then
        humanoid.WalkSpeed = enabled and 16 or 16
    end
end

function Main.ToggleJumpPower(enabled)
    jumppowerEnabled = enabled
    if humanoid then
        humanoid.JumpPower = enabled and 50 or 50
    end
end

function Main.ToggleInfinityJump(enabled)
    infinityJumpEnabled = enabled
end

function Main.ToggleAntiSlow(enabled)
    antiSlowEnabled = enabled
end

function Main.ToggleAntiLowJump(enabled)
    antiLowJumpEnabled = enabled
end

function Main.ToggleAntiDie(enabled)
    antiDieEnabled = enabled
end

function Main.ToggleShowCoords(enabled)
    showCoordsEnabled = enabled
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
