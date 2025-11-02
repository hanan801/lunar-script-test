-- Teleport Module
local TeleportModule = {}

function TeleportModule:Init(core)
    self.Core = core
    self.SpawnPoints = {}
    self.CurrentSpawn = nil
    print("📍 Teleport Module Initialized")
end

function TeleportModule:SetSpawnPoint()
    if self.Core.Character then
        local root = self.Core.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local spawnPoint = {
                position = root.Position,
                name = "Spawn " .. (#self.SpawnPoints + 1)
            }
            table.insert(self.SpawnPoints, spawnPoint)
            self.CurrentSpawn = spawnPoint
            self.Core:Notify("Spawn Point", "Spawn point set!")
        end
    end
end

function TeleportModule:TeleportToSpawn()
    if self.CurrentSpawn and self.Core.Character then
        local root = self.Core.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(self.CurrentSpawn.position)
            self.Core:Notify("Teleport", "Teleported to spawn point!")
        end
    else
        self.Core:Notify("Teleport Error", "No spawn point set!")
    end
end

function TeleportModule:TeleportToPlayer(playerName)
    local targetPlayer = nil
    for _, player in pairs(self.Core.Players:GetPlayers()) do
        if player.Name:lower():find(playerName:lower()) then
            targetPlayer = player
            break
        end
    end
    
    if targetPlayer and targetPlayer.Character then
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localRoot = self.Core.Character:FindFirstChild("HumanoidRootPart")
        
        if targetRoot and localRoot then
            localRoot.CFrame = targetRoot.CFrame
            self.Core:Notify("Teleport", "Teleported to " .. targetPlayer.Name)
        end
    else
        self.Core:Notify("Teleport Error", "Player not found!")
    end
end

function TeleportModule:TeleportToCoordinates(x, y, z)
    if self.Core.Character then
        local root = self.Core.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(x, y, z)
            self.Core:Notify("Teleport", "Teleported to coordinates!")
        end
    end
end

return TeleportModule
