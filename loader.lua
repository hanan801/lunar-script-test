local function loadLunarScript()
    print("🚀 Loading Lunar Script...")
    
    -- Load Core
    local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Core/Main.lua"))()
    
    -- Load UI
    local MainGUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/UI/MainGUI.lua"))()
    
    -- Load Modules
    local Movement = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Movement.lua"))()
    local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Teleport.lua"))()
    local AntiDie = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/AntiDie.lua"))()
    local Backdoor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Backdoor.lua"))()
    local Executor = loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/lunar-script-test/main/Modules/Executor.lua"))()
    
    -- Initialize
    Core:Init()
    MainGUI:Create(Core)
    
    -- Register modules
    Core:RegisterModule("Movement", Movement)
    Core:RegisterModule("Teleport", Teleport) 
    Core:RegisterModule("AntiDie", AntiDie)
    Core:RegisterModule("Backdoor", Backdoor)
    Core:RegisterModule("Executor", Executor)
    
    print("✅ Lunar Script Loaded Successfully!")
    return Core
end

return loadLunarScript()
