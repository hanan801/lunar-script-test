-- AntiDie Module - Simple
local AntiDieModule = {}

function AntiDieModule:Init(core)
    self.Core = core
    self.Active = false
    self.Connection = nil
    print("💀 AntiDie Module Initialized")
end

function AntiDieModule:ToggleAntiDie()
    if self.Active then
        if self.Connection then
            self.Connection:Disconnect()
            self.Connection = nil
        end
        self.Active = false
        self.Core:Notify("Anti Die", "Disabled!")
    else
        self.Connection = self.Core.RunService.Heartbeat:Connect(function()
            if self.Core.Humanoid and self.Core.Humanoid.Health < self.Core.Humanoid.MaxHealth then
                self.Core.Humanoid.Health = self.Core.Humanoid.MaxHealth
            end
        end)
        self.Active = true
        self.Core:Notify("Anti Die", "Enabled!")
    end
end

return AntiDieModule
