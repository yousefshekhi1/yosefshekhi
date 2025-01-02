-- تابع برای تلپورت بازیکن به بالای سر بازیکن محلی
local function teleportPlayer(player, targetPlayer)
    local targetCharacter = targetPlayer.Character
    local playerCharacter = player.Character

    if targetCharacter and playerCharacter then
        -- تغییر موقعیت بازیکن انتخاب‌شده به بالای سر بازیکن محلی
        targetCharacter:SetPrimaryPartCFrame(playerCharacter.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
    end
end

-- ایجاد یک صفحه GUI برای همه بازیکنان
game.Players.PlayerAdded:Connect(function(player)
    -- ایجاد GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")

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

    -- متغیر برای ذخیره بازیکن انتخاب‌شده
    local selectedPlayer = nil

    -- تابع برای پر کردن لیست بازیکنان
    local function updatePlayerList()
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        local yOffset = 0
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player then
                local playerButton = Instance.new("TextButton")
                playerButton.Size = UDim2.new(0, 260, 0, 30)
                playerButton.Position = UDim2.new(0, 10, 0, yOffset)
                playerButton.Text = otherPlayer.Name
                playerButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
                playerButton.Parent = scrollFrame

                playerButton.MouseButton1Click:Connect(function()
                    teleportButton.Text = "تلپورت به " .. otherPlayer.Name
                    selectedPlayer = otherPlayer -- ذخیره بازیکن انتخاب‌شده
                end)

                yOffset = yOffset + 35
            end
        end

        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    end

    -- اتصال توابع به دکمه‌ها
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    teleportButton.MouseButton1Click:Connect(function()
        if selectedPlayer then
            -- تلپورت بازیکن انتخاب‌شده به بالای سر بازیکن محلی
            teleportPlayer(player, selectedPlayer)
        else
            warn("بازیکن انتخاب نشده است!")
        end
    end)

    -- به‌روزرسانی لیست بازیکنان
    updatePlayerList()
    game.Players.PlayerAdded:Connect(updatePlayerList)
    game.Players.PlayerRemoving:Connect(updatePlayerList)
end)
