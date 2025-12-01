task.wait(0.15)

local function verify()
    if not getgenv().__LUNAR_LOADER_TOKEN then return false end
    if not getgenv().__LUNAR_LOADER_TIME then return false end
    
    local token = getgenv().__LUNAR_LOADER_TOKEN
    if type(token) ~= "string" then return false end
    if #token < 20 then return false end
    
    local timeDiff = os.time() - getgenv().__LUNAR_LOADER_TIME
    if timeDiff > 8 then return false end
    
    return true
end

if not verify() then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local originalKick = LocalPlayer.Kick
LocalPlayer.Kick = function(self, reason)
    if type(reason) == "string" and reason:find("loader failed") then
        return originalKick(self, reason)
    end
    return nil
end

getgenv().__LUNAR_STAGE2_VERIFIED = true

local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
end)

if not success then
    task.wait(0.3)
    LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
end
