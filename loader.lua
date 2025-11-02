-- Lunar Script Loader
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

print("🚀 Loading Lunar Script...")

-- Load all modules from GitHub
local Main = loadstring(game:HttpGet("YOUR_URL/Main.lua"))()
local MainGui = loadstring(game:HttpGet("YOUR_URL/MainGui.lua"))()
local Backdoor = loadstring(game:HttpGet("YOUR_URL/Backdoor.lua"))()
local Movement = loadstring(game:HttpGet("YOUR_URL/Movement.lua"))()
local Executor = loadstring(game:HttpGet("YOUR_URL/Executor.lua"))()
local Teleport = loadstring(game:HttpGet("YOUR_URL/Teleport.lua"))()
local AntiDie = loadstring(game:HttpGet("YOUR_URL/AntiDie.lua"))()

-- Collect modules
local Modules = {
    Main = Main,
    MainGui = MainGui,
    Backdoor = Backdoor,
    Movement = Movement,
    Executor = Executor,
    Teleport = Teleport,
    AntiDie = AntiDie
}

-- Initialize main system
if Modules.Main then
    Modules.Main.Initialize(Modules)
end

print("🎯 Lunar Script fully loaded!")
return Modules
