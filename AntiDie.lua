-- AntiDie Module
local AntiDieModule = {
    Active = false,
    Connection = nil
}

function AntiDieModule:Init(core)
    self.Core = core
    print("💀 AntiDie Module Initialized")
end

function AntiDieModule:ToggleAntiDie()
    self.Active = not self.Active
    
    if self.Active then
        self:EnableAntiDie()
        self.Core:Notify("Anti Die", "Anti Die activated!")
    else
        self:DisableAntiDie()
        self.Core:Notify("Anti Die", "Anti Die deactivated!")
    end
end

function AntiDieModule:EnableAntiDie()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = self.Core.RunService.Heartbeat:Connect(function()
        if self.Active and self.Core.Humanoid then
            if self.Core.Humanoid.Health < self.Core.Humanoid.MaxHealth then
                self.Core.Humanoid.Health = self.Core.Humanoid.MaxHealth
            end
            
            if self.Core.Humanoid.Health <= 0 then
                self.Core.Humanoid.Health = self.Core.Humanoid.MaxHealth
            end
        end
    end)
end

function AntiDieModule:DisableAntiDie()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function AntiDieModule:ScanAndActivate()
    self.Core:Notify("Anti Die", "Scanning for backdoors...")
    
    -- Simple backdoor scan for anti-die
    local foundBackdoor = false
    
    for _, remote in ipairs(game:GetDescendants()) do
        if remote:IsA('RemoteEvent') or remote:IsA('RemoteFunction') then
            local fullName = remote:GetFullName()
            if not fullName:find("RobloxReplicatedStorage") then
                foundBackdoor = true
                break
            end
        end
    end
    
    if foundBackdoor then
        self:ToggleAntiDie()
        self.Core:Notify("Anti Die", "Real backdoor found! Anti Die activated!")
    else
        self.Core:Notify("Anti Die", "No backdoor found. Anti Die requires backdoor.")
    end
end

return AntiDieModule
