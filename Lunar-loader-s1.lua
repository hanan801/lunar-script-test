--[[
    LUNAR LOADER - STAGE 1
    Simple and Safe Version
]]

-- Tunggu sebentar untuk memastikan loader utama selesai
task.wait(0.2)

-- Cek apakah loader utama berhasil
if not _G._LUNAR_SECURE_LOADER_EXECUTED then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

-- Cek integrity signature
if not _G._LUNAR_INTEGRITY_SIG then
    game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
    return
end

-- Tunggu lagi untuk keamanan
task.wait(0.2)

-- Set flag bahwa kita di stage 2
_G._LUNAR_STAGE2_COMPLETE = true

-- Sekarang execute script utama
local success, errorMsg = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
end)

-- Jika gagal load script utama, tidak kick (hanya warn)
if not success then
    warn("[LUNAR] Main script error: " .. tostring(errorMsg))
end
