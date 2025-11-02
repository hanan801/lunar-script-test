-- Lunar Script Core - Simple Version
local LunarCore = {
    Version = "2.0.0",
    Author = "hanan801"
}

function LunarCore:Init()
    print("🎯 Lunar Core Initialized")
    
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService") 
    self.UserInputService = game:GetService("UserInputService")
    
    self.LocalPlayer = self.Players.LocalPlayer
    self.Character = self.LocalPlayer.Character or self.LocalPlayer.CharacterAdded:Wait()
    self.Humanoid = self.Character:WaitForChild("Humanoid")
    
    self.States = {
        InfinityJump = false,
        WalkSpeedEnabled = false,
        JumpPowerEnabled = false,
        AntiDie = false
    }
    
    return self
end

function LunarCore:Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

return LunarCore
