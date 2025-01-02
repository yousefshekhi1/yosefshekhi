-- ایجاد یک صفحه GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")

-- ایجاد یک فریم برای پنل
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.5, -150, 0.5, -150)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active = true
frame.Draggable = true -- قابلیت جابه‌جایی پنل
frame.Parent = screenGui

-- ایجاد یک دکمه برای بستن پنل
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.Parent = frame

-- ایجاد یک ScrollingFrame برای لیست بازیکنان
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0, 280, 0, 200)
scrollFrame.Position = UDim2.new(0, 10, 0, 40)
scrollFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = frame

-- ایجاد یک دکمه برای تلپورت
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 100, 0, 40)
teleportButton.Position = UDim2.new(0.5, -50, 1, -50)
teleportButton.Text = "تلپورت"
teleportButton.Parent = frame

-- تابع برای پر کردن لیست بازیکنان
local function updatePlayerList()
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local yOffset = 0
    for _, player in pairs(game.Players:GetPlayers()) do
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(0, 260, 0, 30)
        playerButton.Position = UDim2.new(0, 10, 0, yOffset)
        playerButton.Text = player.Name
        playerButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
        playerButton.Parent = scrollFrame

        playerButton.MouseButton1Click:Connect(function()
            teleportButton.Text = "تلپورت به " .. player.Name
            teleportButton.PlayerToTeleport = player
        end)

        yOffset = yOffset + 35
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- تابع برای تلپورت بازیکن به بالای سر بازیکن محلی
local function teleportPlayer()
    local player = teleportButton.PlayerToTeleport
    if player then
        local character = player.Character
        local localCharacter = game.Players.LocalPlayer.Character

        if character and localCharacter then
            -- تنظیم موقعیت بازیکن انتخاب‌شده به بالای سر بازیکن محلی
            character:MoveTo(localCharacter.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
        else
            warn("کاراکتر پیدا نشد!")
        end
    else
        warn("بازیکن انتخاب نشده است!")
    end
end

-- اتصال توابع به دکمه‌ها
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

teleportButton.MouseButton1Click:Connect(teleportPlayer)

-- به‌روزرسانی لیست بازیکنان
updatePlayerList()
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
