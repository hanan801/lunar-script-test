-- Executor Module - Simple
local ExecutorModule = {}

function ExecutorModule:Init(core)
    self.Core = core
    print("⚡ Executor Module Initialized")
end

function ExecutorModule:ExecuteScript(scriptCode)
    local success, err = pcall(function()
        loadstring(scriptCode)()
    end)
    
    if success then
        self.Core:Notify("Executor", "Script executed!")
    else
        self.Core:Notify("Executor Error", "Failed: " .. tostring(err))
    end
end

return ExecutorModule
