task.wait(0.1)

local function verify_loader()
    if not getgenv().__LUNAR_SESSION_TOKEN then
        return false
    end
    
    if not getgenv().__LUNAR_START_TIME then
        return false
    end
    
    local token = getgenv().__LUNAR_SESSION_TOKEN
    
    if type(token) ~= "string" then
        return false
    end
    
    if #token < 40 then
        return false
    end
    
    local time_difference = os.time() - getgenv().__LUNAR_START_TIME
    
    if time_difference > 8 then
        return false
    end
    
    return true
end

if not verify_loader() then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local original_kick_function = LocalPlayer.Kick

LocalPlayer.Kick = function(self, reason)
    if type(reason) == "string" then
        if reason:find("loader failed") or reason:find("discord.gg/hajjgruEH") then
            return original_kick_function(self, reason)
        end
    end
    
    return nil
end

getgenv().__LUNAR_STAGE_TWO_COMPLETE = true

loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
