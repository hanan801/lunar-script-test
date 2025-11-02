-- Lunar Script Loader - Simple Version
print("🚀 Loading Lunar Script...")

-- Load Core langsung
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Core/Main.lua"))()

-- Inisialisasi Core
Core:Init()

-- Load dan inisialisasi modules
local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Movement.lua"))()
Movement:Init(Core)

local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Teleport.lua"))()
Teleport:Init(Core)

local AntiDie = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/AntiDie.lua"))()
AntiDie:Init(Core)

local Backdoor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Backdoor.lua"))()
Backdoor:Init(Core)

local Executor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Executor.lua"))()
Executor:Init(Core)

-- Load UI terakhir
local MainGUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/UI/MainGUI.lua"))()
MainGUI:Create(Core, {
    Movement = Movement,
    Teleport = Teleport,
    AntiDie = AntiDie,
    Backdoor = Backdoor,
    Executor = Executor
})

print("✅ Lunar Script Loaded Successfully!")
return Core
