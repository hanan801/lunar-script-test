--[[
    LUNAR LOADER - STAGE 1
    Secondary Security Layer
    File ini yang akan menjalankan script utama setelah semua cek
]]

-- ==================== VERIFY STAGE 1 COMPLETION ====================
local function VerifyFirstStage()
    -- Cek apakah loader pertama berhasil dieksekusi
    if not _G._LUNAR_SECURE_LOADER_EXECUTED then
        return false, "FIRST_STAGE_NOT_COMPLETED"
    end
    
    -- Cek integrity signature
    if not _G._LUNAR_INTEGRITY_SIG then
        return false, "INTEGRITY_SIGNATURE_MISSING"
    end
    
    -- Validasi signature
    local sig = _G._LUNAR_INTEGRITY_SIG
    if type(sig) ~= "string" or #sig < 8 then
        return false, "INVALID_SIGNATURE_FORMAT"
    end
    
    return true, sig
end

-- ==================== ANTI-TAMPER PROTECTION ====================
local function ApplyAntiTamper()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    -- Proteksi terhadap unauthorized kicks
    if LocalPlayer then
        local originalKick = LocalPlayer.Kick
        LocalPlayer.Kick = function(self, reason)
            -- Hanya izinkan kick dari sistem loader
            if reason and string.find(reason:lower(), "loader failed") then
                return originalKick(self, reason)
            end
            -- Block semua kick lainnya selama loader berjalan
            warn("[SECURITY] Unauthorized kick attempt blocked: " .. tostring(reason))
            return nil
        end
    end
    
    -- Set flag bahwa anti-tamper aktif
    _G._LUNAR_ANTI_TAMPER_ACTIVE = true
end

-- ==================== EXECUTE MAIN SCRIPT ====================
local function ExecuteMainScript()
    -- Verifikasi semua tahapan
    local verified, verificationData = VerifyFirstStage()
    if not verified then
        task.wait(0.5)
        game:GetService("Players").LocalPlayer:Kick("loader failed, found a bug? report it now! https://discord.gg/hajjgruEH")
        return false
    end
    
    -- Apply anti-tamper protection
    ApplyAntiTamper()
    
    -- Tunggu sebentar untuk memastikan semua proteksi aktif
    task.wait(0.3)
    
    -- Eksekusi script utama
    local success, errorMsg = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
    end)
    
    if not success then
        -- Jika gagal load script utama, tetap tidak kick
        warn("[LUNAR LOADER] Main script failed to load: " .. tostring(errorMsg))
        -- Tapi TIDAK kick user, karena loader sudah berhasil
    end
    
    return true
end

-- ==================== MAIN EXECUTION ====================
-- Gunakan protected call
local loaderSuccess, loaderError = pcall(function()
    ExecuteMainScript()
end)

-- Jika ada error di stage 1 loader, tetap TIDAK kick
-- karena mungkin script utama yang error, bukan loader
if not loaderSuccess then
    warn("[LUNAR LOADER STAGE 1] Execution error (non-critical): " .. tostring(loaderError))
end
