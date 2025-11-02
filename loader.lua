-- Lunar Script Loader
-- Main entry point untuk memuat semua modul

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

print("🚀 Loading Lunar Script...")

-- Load semua module
local Main = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Main.lua"))()
local MainGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/MainGui.lua"))()
local Backdoor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Backdoor.lua"))()
local Executor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Executor.lua"))()
local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Movement.lua"))()
local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Teleport.lua"))()
local AntiDie = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/AntiDie.lua"))()

-- Kumpulkan semua modul
local Modules = {
    Main = Main,
    MainGui = MainGui,
    Backdoor = Backdoor,
    Executor = Executor,
    Movement = Movement,
    Teleport = Teleport,
    AntiDie = AntiDie
}

-- Inisialisasi sistem utama
if Modules.Main then
    Modules.Main.Initialize(Modules)
end

print("🎯 Lunar Script fully loaded!")
return Modules
