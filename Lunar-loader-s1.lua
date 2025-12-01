task.wait(0.15)

local function decrypt_data(encrypted, key)
    local decrypted = ""
    for i = 1, #encrypted do
        local byte = string.byte(encrypted, i)
        local key_byte = string.byte(key, ((i-1) % #key) + 1)
        decrypted = decrypted .. string.char(bit32.bxor(byte, key_byte))
    end
    return decrypted
end

if not getgenv().__LUNAR_ENCRYPTED_TOKEN then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

if not getgenv().__LUNAR_SESSION_KEY then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

if not getgenv().__LUNAR_TIMESTAMP then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

if not getgenv().__LUNAR_LOADER_HASH then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

local time_diff = os.time() - getgenv().__LUNAR_TIMESTAMP
if time_diff > 5 then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

local decrypted_token = decrypt_data(getgenv().__LUNAR_ENCRYPTED_TOKEN, getgenv().__LUNAR_SESSION_KEY)

if type(decrypted_token) ~= "string" then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

if #decrypted_token ~= 128 then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

local players = game:GetService("Players")
local local_player = players.LocalPlayer

local original_kick = local_player.Kick
local_player.Kick = function(self, reason)
    if type(reason) == "string" then
        local allowed_patterns = {"loader failed", "discord.gg/hajjgruEH", "found a bug"}
        for _, pattern in ipairs(allowed_patterns) do
            if string.find(reason, pattern) then
                return original_kick(self, reason)
            end
        end
    end
    return nil
end

local environment_check = pcall(function()
    local stack = debug.traceback()
    local blacklisted = {"hookfunction", "detour", "inject", "bypass", "debug"}
    for _, word in ipairs(blacklisted) do
        if string.find(string.lower(stack), word) then
            error("Injection detected")
        end
    end
end)

if not environment_check then
    local_player:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

getgenv().__LUNAR_STAGE2_VALIDATED = true
getgenv().__LUNAR_STAGE2_TIMESTAMP = os.time()

local load_success, load_error = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
end)

if not load_success then
    task.wait(0.3)
    local_player:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
end
