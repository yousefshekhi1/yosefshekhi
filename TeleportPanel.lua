-- ایجاد یک صفحه GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui") -- استفاده از CoreGui به جای PlayerGui

-- ایجاد یک فریم برای پنل
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Parent = screenGui

-- ایجاد یک TextBox برای وارد کردن نام بازیکن
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 200, 0, 30)
textBox.Position = UDim2.new(0.5, -100, 0.3, -15)
textBox.PlaceholderText = "اسم بازیکن را وارد کنید"
textBox.Parent = frame

-- ایجاد یک دکمه برای تلپورت
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 100, 0, 40)
teleportButton.Position = UDim2.new(0.5, -50, 0.6, -20)
teleportButton.Text = "تلپورت"
teleportButton.Parent = frame

-- تابع برای تلپورت بازیکن
local function teleportPlayer()
    local playerName = textBox.Text
    local player = game.Players:FindFirstChild(playerName)
    
    if player then
        local character = player.Character
        local localPlayer = game.Players.LocalPlayer
        local localCharacter = localPlayer.Character
        
        if character and localCharacter then
            localCharacter:MoveTo(character.HumanoidRootPart.Position)
        else
            warn("کاراکتر پیدا نشد!")
        end
    else
        warn("بازیکن پیدا نشد!")
    end
end

-- اتصال تابع به دکمه
teleportButton.MouseButton1Click:Connect(teleportPlayer)
