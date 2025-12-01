--[[
    ULTRA SECURE STAGE 1 LOADER
    Final Verification & Main Script Execution
]]

do
    -- Wait for stability
    task.wait(0.3)
    
    -- LAYER 1: VERIFY STAGE 0 COMPLETION
    local function VerifyStage0()
        local g = getgenv()
        
        -- Check all required flags
        if not g.__LOADER_ALREADY_EXECUTED then
            return false, "STAGE0_NOT_COMPLETE"
        end
        
        if not g.__LOADER_TOKEN then
            return false, "TOKEN_MISSING"
        end
        
        if not g.__LOADER_ENCRYPTED then
            return false, "ENCRYPTED_TOKEN_MISSING"
        end
        
        -- Verify token integrity
        local token = g.__LOADER_TOKEN
        if type(token) ~= "string" then
            return false, "INVALID_TOKEN_TYPE"
        end
        
        if #token < 10 then
            return false, "TOKEN_TOO_SHORT"
        end
        
        -- Check timestamp (should be recent)
        if g.__LOADER_TIMESTAMP then
            local diff = os.time() - g.__LOADER_TIMESTAMP
            if diff > 30 then -- 30 seconds max
                return false, "TOKEN_EXPIRED"
            end
        end
        
        return true, token
    end
    
    -- LAYER 2: ANTI-INJECTION PROTECTION
    local function AntiInjection()
        -- Check for unauthorized scripts
        local suspicious = {
            "Synapse",
            "ScriptWare",
            "Krnl",
            "Fluxus",
            "Comet"
        }
        
        local trace = debug.traceback():lower()
        for _, name in ipairs(suspicious) do
            if trace:find(name:lower()) then
                return false
            end
        end
        
        return true
    end
    
    -- LAYER 3: SAFE EXECUTION
    local function ExecuteSafely()
        -- Verify everything
        local verified, data = VerifyStage0()
        if not verified then
            error("VERIFICATION_FAILED: " .. tostring(data))
        end
        
        if not AntiInjection() then
            error("ANTI_INJECTION_TRIGGERED")
        end
        
        -- Mark as verified
        getgenv().__STAGE1_VERIFIED = true
        getgenv().__STAGE1_TIME = os.time()
        
        -- Execute main script with protection
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/hanan801/LunarScript/main/Lunar-Script.lua"))()
        end)
        
        if not success then
            -- Don't kick, just warn
            warn("[SECURE LOADER] Main script failed: " .. tostring(result))
        else
            print("[SECURE LOADER] Main script loaded successfully!")
        end
        
        return true
    end
    
    -- MAIN EXECUTION WITH FALLBACK
    local function Main()
        local s1, e1 = pcall(ExecuteSafely)
        
        if not s1 then
            -- One retry attempt
            task.wait(0.2)
            local s2, e2 = pcall(ExecuteSafely)
            
            if not s2 then
                -- Still no kick - just exit silently
                warn("[SECURE LOADER] Stage 1 failed silently: " .. tostring(e2))
                return false
            end
        end
        
        return true
    end
    
    -- START
    pcall(Main)
end
