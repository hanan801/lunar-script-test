-- Lunar Script Core System
local LunarCore = {
    Version = "2.0.0",
    Author = "hanan801",
    Modules = {},
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService"),
    HttpService = game:GetService("HttpService")
}

function LunarCore:Init()
    self.LocalPlayer = self.Players.LocalPlayer
    self.Character = self.LocalPlayer.Character or self.LocalPlayer.CharacterAdded:Wait()
    self.Humanoid = self.Character:WaitForChild("Humanoid")
    
    -- Default settings
    self.Settings = {
        WalkSpeed = 16,
        JumpPower = 50,
        Theme = "dark",
        RGBMode = true
    }
    
    -- State management
    self.States = {
        InfinityJump = false,
        AntiSlow = false,
        AntiLowJump = false,
        AntiDie = false,
        ShowCoords = false,
        WalkSpeedEnabled = false,
        JumpPowerEnabled = false
    }
    
    print("🎯 Lunar Core Initialized")
    return self
end

function LunarCore:RegisterModule(name, module)
    if module and module.Init then
        self.Modules[name] = module
        module:Init(self)
        print("✅ Module Registered: " .. name)
    else
        warn("❌ Invalid module: " .. name)
    end
end

function LunarCore:GetModule(name)
    return self.Modules[name]
end

function LunarCore:Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

return LunarCore
