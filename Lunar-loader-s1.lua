task.wait(0.1)

if not getgenv().__LUNAR_LOAD_KEY then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

if os.time() - getgenv().__LUNAR_LOAD_KEY > 10 then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
