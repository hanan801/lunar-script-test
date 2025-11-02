-- Teleport Module - Simple
local TeleportModule = {}

function TeleportModule:Init(core)
    self.Core = core
    print("📍 Teleport Module Initialized")
end

function TeleportModule:SetSpawnPoint()
    if self.Core.Character then
        local root = self.Core.Character:FindFirstChild("HumanoidRootPart")
        if root then
            self.SpawnPosition = root.Position
            self.Core:Notify("Spawn", "Spawn point set!")
        end
    end
end

function TeleportModule:TeleportToSpawn()
    if self.SpawnPosition and self.Core.Character then
        local root = self.Core.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(self.SpawnPosition)
            self.Core:Notify("Teleport", "Teleported to spawn!")
        end
    else
        self.Core:Notify("Teleport Error", "Set spawn point first!")
    end
end

return TeleportModule
