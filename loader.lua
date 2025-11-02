-- Lunar Script Loader
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

print("🚀 Loading Lunar Script...")

-- Load all modules
local Main = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Main.lua"))()
local MainGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/MainGui.lua"))()
local Backdoor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Backdoor.lua"))()
local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Movement.lua"))()
local Executor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Executor.lua"))()
local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Teleport.lua"))()
local AntiDie = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/AntiDie.lua"))()

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
