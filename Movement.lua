-- Movement Module - Simple
local MovementModule = {}

function MovementModule:Init(core)
    self.Core = core
    self.Connections = {}
    print("🏃 Movement Module Initialized")
end

function MovementModule:ToggleInfinityJump()
    if self.Connections.jump then
        self.Connections.jump:Disconnect()
        self.Connections.jump = nil
        self.Core.States.InfinityJump = false
        self.Core:Notify("Infinity Jump", "Disabled!")
    else
        self.Connections.jump = self.Core.UserInputService.JumpRequest:Connect(function()
            if self.Core.Humanoid then
                self.Core.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        self.Core.States.InfinityJump = true
        self.Core:Notify("Infinity Jump", "Enabled!")
    end
end

function MovementModule:ToggleWalkSpeed()
    if self.Connections.walkSpeed then
        self.Connections.walkSpeed:Disconnect()
        self.Connections.walkSpeed = nil
        self.Core.States.WalkSpeedEnabled = false
        if self.Core.Humanoid then
            self.Core.Humanoid.WalkSpeed = 16
        end
        self.Core:Notify("Walk Speed", "Disabled!")
    else
        self.Connections.walkSpeed = self.Core.RunService.Heartbeat:Connect(function()
            if self.Core.Humanoid then
                self.Core.Humanoid.WalkSpeed = 50
            end
        end)
        self.Core.States.WalkSpeedEnabled = true
        self.Core:Notify("Walk Speed", "Enabled: 50")
    end
end

return MovementModule
