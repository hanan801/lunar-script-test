-- Executor Module
local ExecutorModule = {
    SavedScripts = {}
}

function ExecutorModule:Init(core)
    self.Core = core
    print("⚡ Executor Module Initialized")
end

function ExecutorModule:ExecuteScript(scriptCode)
    local success, result = pcall(function()
        loadstring(scriptCode)()
    end)
    
    if success then
        self.Core:Notify("Executor", "Script executed successfully!")
        return true
    else
        self.Core:Notify("Executor Error", "Failed: " .. tostring(result))
        return false
    end
end

function ExecutorModule:SaveScript(name, scriptCode)
    self.SavedScripts[name] = scriptCode
    self.Core:Notify("Executor", "Script saved: " .. name)
end

function ExecutorModule:LoadScript(name)
    return self.SavedScripts[name]
end

function ExecutorModule:ClearScripts()
    self.SavedScripts = {}
    self.Core:Notify("Executor", "All scripts cleared!")
end

return ExecutorModule
