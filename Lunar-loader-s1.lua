task.wait(0.15)

local function VerifyLoaderIntegrity()
    if not getgenv().__LUNAR_LOADER_TOKEN then return false end
    if not getgenv().__LUNAR_LOADER_HASH then return false end
    if not getgenv().__LUNAR_LOADER_TIMESTAMP then return false end
    
    local token = getgenv().__LUNAR_LOADER_TOKEN
    local storedHash = getgenv().__LUNAR_LOADER_HASH
    
    local calculatedHash = 0
    for i = 1, #token do
        calculatedHash = calculatedHash + string.byte(token, i) * i
    end
    calculatedHash = calculatedHash % 1000000
    
    if calculatedHash ~= storedHash then
        return false
    end
    
    local timeDiff = os.time() - getgenv().__LUNAR_LOADER_TIMESTAMP
    if timeDiff > 10 then
        return false
    end
    
    return true
end

if not VerifyLoaderIntegrity() then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

local function CheckExecutionEnvironment()
    local stack = debug.traceback()
    
    local blacklisted = {
        "hookfunction", "detour_function", "inject", "bypass",
        "debug", "getinfo", "getconstants"
    }
    
    for _, word in ipairs(blacklisted) do
        if stack:lower():find(word:lower()) then
            return false
        end
    end
    
    if not getgenv().__LUNAR_KICK_PROTECTED then
        return false
    end
    
    return true
end

if not CheckExecutionEnvironment() then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

getgenv().__LUNAR_STAGE2_COMPLETE = true

task.wait(0.1)

local scriptSuccess, scriptError = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
end)

if not scriptSuccess then
    task.wait(0.3)
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
end
