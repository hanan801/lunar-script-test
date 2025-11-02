-- Movement Module - Fixed
local MovementModule = {}

function MovementModule:Init(core)
    self.Core = core
    self.Connections = {}
    print("🏃 Movement Module Initialized")
    return self
end

function MovementModule:ToggleInfinityJump()
    if self.Core.States.InfinityJump then
        -- Turn off
        if self.Connections.jump then
            self.Connections.jump:Disconnect()
            self.Connections.jump = nil
        end
        self.Core.States.InfinityJump = false
        self.Core:Notify("Infinity Jump", "Disabled!")
    else
        -- Turn on
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
    if self.Core.States.WalkSpeedEnabled then
        -- Turn off
        if self.Connections.walkSpeed then
            self.Connections.walkSpeed:Disconnect()
            self.Connections.walkSpeed = nil
        end
        if self.Core.Humanoid then
            self.Core.Humanoid.WalkSpeed = 16
        end
        self.Core.States.WalkSpeedEnabled = false
        self.Core:Notify("Walk Speed", "Disabled!")
    else
        -- Turn on
        local speed = tonumber(self.Core.Settings.WalkSpeed) or 16
        if self.Connections.walkSpeed then
            self.Connections.walkSpeed:Disconnect()
        end
        self.Connections.walkSpeed = self.Core.RunService.Heartbeat:Connect(function()
            if self.Core.Humanoid then
                self.Core.Humanoid.WalkSpeed = speed
            end
        end)
        self.Core.States.WalkSpeedEnabled = true
        self.Core:Notify("Walk Speed", "Enabled: " .. speed)
    end
end

function MovementModule:SetWalkSpeed(speed)
    local numSpeed = tonumber(speed)
    if numSpeed then
        self.Core.Settings.WalkSpeed = numSpeed
        if self.Core.States.WalkSpeedEnabled and self.Core.Humanoid then
            self.Core.Humanoid.WalkSpeed = numSpeed
        end
        self.Core:Notify("Walk Speed", "Set to: " .. numSpeed)
    else
        self.Core:Notify("Error", "Invalid speed number!")
    end
end

function MovementModule:ToggleJumpPower()
    if self.Core.States.JumpPowerEnabled then
        -- Turn off
        if self.Connections.jumpPower then
            self.Connections.jumpPower:Disconnect()
            self.Connections.jumpPower = nil
        end
        if self.Core.Humanoid then
            self.Core.Humanoid.JumpPower = 50
        end
        self.Core.States.JumpPowerEnabled = false
        self.Core:Notify("Jump Power", "Disabled!")
    else
        -- Turn on
        local power = tonumber(self.Core.Settings.JumpPower) or 50
        if self.Connections.jumpPower then
            self.Connections.jumpPower:Disconnect()
        end
        self.Connections.jumpPower = self.Core.RunService.Heartbeat:Connect(function()
            if self.Core.Humanoid then
                self.Core.Humanoid.JumpPower = power
            end
        end)
        self.Core.States.JumpPowerEnabled = true
        self.Core:Notify("Jump Power", "Enabled: " .. power)
    end
end

function MovementModule:SetJumpPower(power)
    local numPower = tonumber(power)
    if numPower then
        self.Core.Settings.JumpPower = numPower
        if self.Core.States.JumpPowerEnabled and self.Core.Humanoid then
            self.Core.Humanoid.JumpPower = numPower
        end
        self.Core:Notify("Jump Power", "Set to: " .. numPower)
    else
        self.Core:Notify("Error", "Invalid jump power number!")
    end
end

return MovementModule
