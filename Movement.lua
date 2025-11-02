-- Movement Module
local MovementModule = {}

function MovementModule:Init(core)
    self.Core = core
    self.Connections = {}
    
    print("🏃 Movement Module Initialized")
end

function MovementModule:ToggleInfinityJump()
    self.Core.States.InfinityJump = not self.Core.States.InfinityJump
    
    if self.Core.States.InfinityJump then
        self.Connections.jump = self.Core.UserInputService.JumpRequest:Connect(function()
            if self.Core.States.InfinityJump and self.Core.Humanoid then
                self.Core.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        self.Core:Notify("Infinity Jump", "Infinity Jump enabled!")
    else
        if self.Connections.jump then
            self.Connections.jump:Disconnect()
            self.Connections.jump = nil
        end
        self.Core:Notify("Infinity Jump", "Infinity Jump disabled!")
    end
end

function MovementModule:ToggleWalkSpeed(enabled, speed)
    if enabled then
        self.Core.States.WalkSpeedEnabled = true
        self.Core.Settings.WalkSpeed = speed or 16
        
        if self.Connections.walkSpeed then
            self.Connections.walkSpeed:Disconnect()
        end
        
        self.Connections.walkSpeed = self.Core.RunService.Heartbeat:Connect(function()
            if self.Core.States.WalkSpeedEnabled and self.Core.Humanoid then
                self.Core.Humanoid.WalkSpeed = self.Core.Settings.WalkSpeed
            end
        end)
        self.Core:Notify("Walk Speed", "Walk Speed enabled: " .. self.Core.Settings.WalkSpeed)
    else
        self.Core.States.WalkSpeedEnabled = false
        if self.Connections.walkSpeed then
            self.Connections.walkSpeed:Disconnect()
            self.Connections.walkSpeed = nil
        end
        if self.Core.Humanoid then
            self.Core.Humanoid.WalkSpeed = 16
        end
        self.Core:Notify("Walk Speed", "Walk Speed disabled!")
    end
end

function MovementModule:ToggleJumpPower(enabled, power)
    if enabled then
        self.Core.States.JumpPowerEnabled = true
        self.Core.Settings.JumpPower = power or 50
        
        if self.Connections.jumpPower then
            self.Connections.jumpPower:Disconnect()
        end
        
        self.Connections.jumpPower = self.Core.RunService.Heartbeat:Connect(function()
            if self.Core.States.JumpPowerEnabled and self.Core.Humanoid then
                self.Core.Humanoid.JumpPower = self.Core.Settings.JumpPower
            end
        end)
        self.Core:Notify("Jump Power", "Jump Power enabled: " .. self.Core.Settings.JumpPower)
    else
        self.Core.States.JumpPowerEnabled = false
        if self.Connections.jumpPower then
            self.Connections.jumpPower:Disconnect()
            self.Connections.jumpPower = nil
        end
        if self.Core.Humanoid then
            self.Core.Humanoid.JumpPower = 50
        end
        self.Core:Notify("Jump Power", "Jump Power disabled!")
    end
end

function MovementModule:ToggleAntiSlow()
    self.Core.States.AntiSlow = not self.Core.States.AntiSlow
    self.Core:Notify("Anti Slow", self.Core.States.AntiSlow and "Enabled!" or "Disabled!")
end

function MovementModule:ToggleAntiLowJump()
    self.Core.States.AntiLowJump = not self.Core.States.AntiLowJump
    self.Core:Notify("Anti Low Jump", self.Core.States.AntiLowJump and "Enabled!" or "Disabled!")
end

return MovementModule
