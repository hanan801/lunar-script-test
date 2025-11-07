-- LunarScript GUI Utama
-- Hanya bisa di-load melalui sistem login

-- CEK APAKAH SUDAH LOGIN
if not _G.LunarLoginVerified then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ACCESS DENIED",
        Text = "Please login first!",
        Duration = 5
    })
    wait(2)
    game.Players.LocalPlayer:Kick("❌ Please use LunarScript Login system!")
    return
end

-- JIKA BERHASIL LOGIN, TAMPILKAN GUI UTAMA
print("deepseek goblok")  -- Contoh sederhana

-- TRY-CATCH untuk menangani error saat load GUI
local success, errorMessage = pcall(function()
    -- Buat GUI Utama
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "LunarMainGUI"
    mainGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = mainGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    title.Text = "LunarScript - MAIN GUI"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = mainFrame

    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, -20, 1, -70)
    content.Position = UDim2.new(0, 10, 0, 60)
    content.BackgroundTransparency = 1
    content.Text = "Welcome to LunarScript!\n\nKey Type: " .. (_G.LunarKeyType or "UNKNOWN") .. "\nStatus: VERIFIED\n\nGUI Utama berhasil di-load melalui sistem login!"
    content.TextColor3 = Color3.fromRGB(255, 255, 255)
    content.Font = Enum.Font.Gotham
    content.TextSize = 14
    content.TextWrapped = true
    content.Parent = mainFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 100, 0, 40)
    closeButton.Position = UDim2.new(0.5, -50, 1, -50)
    closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    closeButton.Text = "CLOSE"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 14
    closeButton.Parent = mainFrame

    closeButton.MouseButton1Click:Connect(function()
        mainGui:Destroy()
    end)

    mainGui.Parent = playerGui

    -- Notifikasi sukses
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LunarScript Loaded!",
        Text = "Main GUI successfully loaded",
        Duration = 5
    })

    print("LunarScript GUI Utama berhasil di-load!")
end)

-- JIKA TERJADI ERROR SAAT LOAD GUI
if not success then
    warn("Loader failed: " .. tostring(errorMessage))
    
    -- Tampilkan notifikasi error
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LOADER FAILED",
        Text = "Found bug? Join our Discord",
        Duration = 5
    })
    
    wait(2)
    
    -- Keluar dari game dengan pesan error
    game.Players.LocalPlayer:Kick("loader failed, found bug? join discord https://discord.gg/hajjgruEH")
end
