if not getgenv().__LUNAR_START_TIME then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    end
    return
end

if not getgenv().__LUNAR_VERIFY_CODE then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    end
    return
end

if os.time() - getgenv().__LUNAR_START_TIME > 15 then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    end
    return
end

local verify_code = getgenv().__LUNAR_VERIFY_CODE
if type(verify_code) ~= "string" then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    end
    return
end

if not verify_code:find("LUNAR_") then
    if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    end
    return
end

if game and game:GetService("Players") and game:GetService("Players").LocalPlayer then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
end
