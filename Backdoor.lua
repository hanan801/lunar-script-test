-- Backdoor Module - Simple
local BackdoorModule = {}

function BackdoorModule:Init(core)
    self.Core = core
    print("🛡️ Backdoor Module Initialized")
end

function BackdoorModule:ScanBackdoors()
    self.Core:Notify("Backdoor", "Scanning for backdoors...")
    
    -- Simple scan logic
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local fullName = obj:GetFullName()
            if not fullName:find("RobloxReplicatedStorage") then
                self.Core:Notify("Backdoor Found!", "Found: " .. obj.Name)
                self.FoundBackdoor = obj
                return true
            end
        end
    end
    
    self.Core:Notify("Backdoor", "No backdoor found")
    return false
end

function BackdoorModule:ExecuteScript(scriptText)
    if self.FoundBackdoor then
        if self.FoundBackdoor:IsA("RemoteEvent") then
            self.FoundBackdoor:FireServer(scriptText)
        else
            self.FoundBackdoor:InvokeServer(scriptText)
        end
        self.Core:Notify("Backdoor", "Script executed!")
    else
        self.Core:Notify("Backdoor Error", "Scan for backdoor first!")
    end
end

return BackdoorModule
