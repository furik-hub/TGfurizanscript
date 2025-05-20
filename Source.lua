-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

-- Настройки
local TELEGRAM_LINK = "https://t.me/furizanscript"
local KEYS = {
    ["TG: С КЛЮЧОМ🔑 https://t.me/furizanscript"] = 5000,
    ["СКРИПТ ВЗЯТ С ТГ: https://t.me/furizanscript"] = 2000,
    ["@Script_furik"] = 2000,
    ["TG:furizanscript"] = 2000
}
local ACTIVATIONS = {}

-- Звуки
local SOUNDS = {
    Click = Instance.new("Sound"),
    Error = Instance.new("Sound"),
    Success = Instance.new("Sound")
}

-- Настройка звуков
SOUNDS.Click.SoundId = "rbxassetid://9047377241"
SOUNDS.Error.SoundId = "rbxassetid://9047408913"
SOUNDS.Success.SoundId = "rbxassetid://9047378877"

for _, sound in pairs(SOUNDS) do
    sound.Parent = SoundService
end

-- Функция для воспроизведения звука
local function playSound(name)
    if SOUNDS[name] then
        SOUNDS[name]:Play()
    end
end

-- Функция для проверки ключа
local function checkKey(key)
    if KEYS[key] then
        if ACTIVATIONS[key] then
            if ACTIVATIONS[key] >= KEYS[key] then
                return false, "Ключ исчерпан"
            end
            ACTIVATIONS[key] += 1
        else
            ACTIVATIONS[key] = 1
        end
        return true, KEYS[key] - ACTIVATIONS[key]
    end
    return false, "Неверный ключ"
end

-- Функция для создания кнопки (белый стиль)
local function createButton(parent, name, position, size)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = name
    button.Size = size or UDim2.new(0.8, 0, 0.1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.TextColor3 = Color3.new(0, 0, 0)
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 14
    button.Parent = parent
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0.8, 0.8, 0.8)
    stroke.Thickness = 1.5
    stroke.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.15, 0)
    corner.Parent = button
    
    button.MouseEnter:Connect(function()
        playSound("Click")
        local tween = TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(240, 240, 240), TextColor3 = Color3.new(0, 0, 0)}
        )
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextColor3 = Color3.new(0, 0, 0)}
        )
        tween:Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        playSound("Click")
    end)
    
    return button
end

-- Функция для создания окна активации (белый стиль)
local function createActivationWindow(player)
    local gui = Instance.new("ScreenGui")
    gui.Name = "ActivationWindow"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    -- Основной фрейм (белый)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.9, 0, 0.6, 0)  -- Увеличенная высота
    mainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.Parent = gui
    
    if UserInputService.TouchEnabled then -- Мобильная версия
        mainFrame.Size = UDim2.new(0.95, 0, 0.7, 0)
        mainFrame.Position = UDim2.new(0.025, 0, 0.15, 0)
    end
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = mainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0.8, 0.8, 0.8)
    stroke.Thickness = 3
    stroke.Parent = mainFrame
    
    -- Заголовок (чёрный текст)
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = "🔑 АКТИВАЦИЯ СКРИПТА"
    title.Size = UDim2.new(0.8, 0, 0.1, 0)
    title.Position = UDim2.new(0.1, 0, 0.05, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(0, 0, 0)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 20
    title.Parent = mainFrame
    
    -- Описание (серый текст)
    local desc = Instance.new("TextLabel")
    desc.Name = "Description"
    desc.Text = "Введите ключ активации в поле ниже\nКлюч можно получить в нашем Telegram"
    desc.Size = UDim2.new(0.8, 0, 0.15, 0)
    desc.Position = UDim2.new(0.1, 0, 0.15, 0)
    desc.BackgroundTransparency = 1
    desc.TextColor3 = Color3.new(0.3, 0.3, 0.3)
    desc.Font = Enum.Font.GothamMedium
    desc.TextSize = 14
    desc.TextWrapped = true
    desc.Parent = mainFrame
    
    -- Поле для ввода ключа (белое)
    local keyBox = Instance.new("TextBox")
    keyBox.Name = "KeyBox"
    keyBox.Size = UDim2.new(0.8, 0, 0.15, 0)
    keyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    keyBox.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    keyBox.TextColor3 = Color3.new(0, 0, 0)
    keyBox.Font = Enum.Font.GothamMedium
    keyBox.PlaceholderText = "Введите ключ тут..."
    keyBox.TextSize = 14
    keyBox.Parent = mainFrame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0.1, 0)
    boxCorner.Parent = keyBox
    
    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Color3.new(0.7, 0.7, 0.7)
    boxStroke.Parent = keyBox
    
    -- Кнопка для перехода в Telegram (белая)
    local telegramBtn = createButton(mainFrame, "📢 ПОЛУЧИТЬ КЛЮЧ", UDim2.new(0.1, 0, 0.55, 0), UDim2.new(0.8, 0, 0.12, 0))
    telegramBtn.MouseButton1Click:Connect(function()
        playSound("Click")
        setclipboard(TELEGRAM_LINK)
        
        local notification = Instance.new("TextLabel")
        notification.Text = "Ссылка скопирована в буфер обмена!"
        notification.Size = UDim2.new(0.8, 0, 0.08, 0)
        notification.Position = UDim2.new(0.1, 0, 0.85, 0)
        notification.BackgroundTransparency = 0.8
        notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        notification.TextColor3 = Color3.new(0, 0, 0)
        notification.Font = Enum.Font.GothamMedium
        notification.TextSize = 14
        notification.Parent = mainFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.1, 0)
        corner.Parent = notification
        
        delay(3, function()
            notification:Destroy()
        end)
    end)
    
    -- Кнопка активации (белая)
    local activateBtn = createButton(mainFrame, "✅ АКТИВИРОВАТЬ", UDim2.new(0.1, 0, 0.7, 0), UDim2.new(0.8, 0, 0.12, 0))
    activateBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text
        local success, remaining = checkKey(key)
        
        if success then
            playSound("Success")
            gui:Destroy()
            
            -- ===== МЕНЮ ПОСЛЕ АКТИВАЦИИ (БЕЛЫЙ СТИЛЬ) =====
            local mainGui = Instance.new("ScreenGui")
            mainGui.Name = "MainScriptMenu"
            mainGui.ResetOnSpawn = false
            mainGui.Parent = player:WaitForChild("PlayerGui")
            
            local mainFrame = Instance.new("Frame")
            mainFrame.Name = "MainFrame"
            mainFrame.Size = UDim2.new(0.7, 0, 0.8, 0)  -- Увеличенный размер
            mainFrame.Position = UDim2.new(0.15, 0, 0.1, 0)
            mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            mainFrame.Parent = mainGui
            
            if UserInputService.TouchEnabled then
                mainFrame.Size = UDim2.new(0.95, 0, 0.9, 0)
                mainFrame.Position = UDim2.new(0.025, 0, 0.05, 0)
            end
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0.05, 0)
            corner.Parent = mainFrame
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.new(0.8, 0.8, 0.8)
            stroke.Thickness = 2
            stroke.Parent = mainFrame
            
            -- Заголовок (чёрный)
            local title = Instance.new("TextLabel")
            title.Name = "Title"
            title.Text = "🔥TG:furizanscript🔥"
            title.Size = UDim2.new(0.8, 0, 0.08, 0)
            title.Position = UDim2.new(0.1, 0, 0.02, 0)
            title.BackgroundTransparency = 1
            title.TextColor3 = Color3.new(0, 0, 0)
            title.Font = Enum.Font.GothamBlack
            title.TextSize = 24
            title.Parent = mainFrame
            
            -- Информация о ключе (серый)
            local keyInfo = Instance.new("TextLabel")
            keyInfo.Name = "KeyInfo"
            keyInfo.Text = "Осталось активаций: "..remaining
            keyInfo.Size = UDim2.new(0.8, 0, 0.05, 0)
            keyInfo.Position = UDim2.new(0.1, 0, 0.1, 0)
            keyInfo.BackgroundTransparency = 1
            keyInfo.TextColor3 = Color3.new(0.5, 0.5, 0.5)
            keyInfo.Font = Enum.Font.GothamMedium
            keyInfo.TextSize = 14
            keyInfo.Parent = mainFrame
            
            -- Вкладки (добавлена вкладка "Дюп")
            local tabs = {"🌱 Seeds", "🍓 Fruits", "🐾 Pets", "💎 Dupes fruits "}
            local tabButtons = {}
            
            for i, tab in ipairs(tabs) do
                local button = createButton(mainFrame, tab, UDim2.new(0.05 + (i-1)*0.23, 0, 0.18, 0), UDim2.new(0.21, 0, 0.07, 0))
                table.insert(tabButtons, button)
            end
            
            -- Фреймы для разделов
            local seedFrame = Instance.new("Frame")
            seedFrame.Name = "SeedsFrame"
            seedFrame.Size = UDim2.new(1, 0, 0.7, 0)
            seedFrame.Position = UDim2.new(0, 0, 0.25, 0)
            seedFrame.BackgroundTransparency = 1
            seedFrame.Visible = true
            seedFrame.Parent = mainFrame
            
            local fruitFrame = Instance.new("Frame")
            fruitFrame.Name = "FruitsFrame"
            fruitFrame.Size = UDim2.new(1, 0, 0.7, 0)
            fruitFrame.Position = UDim2.new(0, 0, 0.25, 0)
            fruitFrame.BackgroundTransparency = 1
            fruitFrame.Visible = false
            fruitFrame.Parent = mainFrame
            
            local petFrame = Instance.new("Frame")
            petFrame.Name = "PetsFrame"
            petFrame.Size = UDim2.new(1, 0, 0.7, 0)
            petFrame.Position = UDim2.new(0, 0, 0.25, 0)
            petFrame.BackgroundTransparency = 1
            petFrame.Visible = false
            petFrame.Parent = mainFrame
            
            -- Новый фрейм для раздела "Дюп"
            local dupFrame = Instance.new("Frame")
            dupFrame.Name = "DupFrame"
            dupFrame.Size = UDim2.new(1, 0, 0.7, 0)
            dupFrame.Position = UDim2.new(0, 0, 0.25, 0)
            dupFrame.BackgroundTransparency = 1
            dupFrame.Visible = false
            dupFrame.Parent = mainFrame
            
            -- Кнопки множителей для раздела "Дюп"
            local multipliers = {"x1", "x10", "x100", "x1000"}
            for i, mult in ipairs(multipliers) do
                local btn = createButton(dupFrame, mult, UDim2.new(0.1, 0, 0.1 + (i-1)*0.2, 0), UDim2.new(0.8, 0, 0.15, 0))
                btn.MouseButton1Click:Connect(function()
                    local backpack = player:FindFirstChild("Backpack")
                    if backpack then
                        -- Создаем копии всех предметов
                        local items = {}
                        for _, item in ipairs(backpack:GetChildren()) do
                            table.insert(items, item:Clone())
                        end
                        
                        -- Очищаем инвентарь
                        for _, item in ipairs(backpack:GetChildren()) do
                            item:Destroy()
                        end
                        
                        -- Добавляем умноженные предметы
                        local multiplier = tonumber(mult:sub(2)) or 1
                        for _, item in ipairs(items) do
                            for i = 1, multiplier do
                                item:Clone().Parent = backpack
                            end
                        end
                    end
                end)
            end
            
            -- Функция добавления в инвентарь
            local function addToInventory(itemName)
                local tool = Instance.new("Tool")
                tool.Name = itemName
                tool.Parent = player:WaitForChild("Backpack")
                
                local handle = Instance.new("Part")
                handle.Name = "Handle"
                handle.Size = Vector3.new(0.5, 0.5, 0.5)
                handle.Transparency = 1
                handle.Parent = tool
                
                local billboard = Instance.new("BillboardGui")
                billboard.Size = UDim2.new(5, 0, 2, 0)
                billboard.StudsOffset = Vector3.new(0, 1, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = handle
                
                local label = Instance.new("TextLabel")
                label.Text = itemName
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.new(0, 0, 0)
                label.Font = Enum.Font.GothamBold
                label.TextSize = 14
                label.Parent = billboard
                
                -- Уведомление (белое)
                local notif = Instance.new("TextLabel")
                notif.Text = "Добавлено: "..itemName
                notif.Size = UDim2.new(0.8, 0, 0.06, 0)
                notif.Position = UDim2.new(0.1, 0, 0.92, 0)
                notif.BackgroundTransparency = 0.8
                notif.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                notif.TextColor3 = Color3.new(0, 0, 0)
                notif.Font = Enum.Font.GothamMedium
                notif.TextSize = 14
                notif.Parent = mainFrame
                
                local notifCorner = Instance.new("UICorner")
                notifCorner.CornerRadius = UDim.new(0.1, 0)
                notifCorner.Parent = notif
                
                delay(2, function()
                    notif:Destroy()
                end)
            end
            
            -- Заполняем разделы
            local seeds = {"candy Blossom Seed ", " Grape Seed", " Pepper Seed"," Beanstalk Seed"," Mushroom Seed", " Dragon Seed"}
            for i, seed in ipairs(seeds) do
                local btn = createButton(seedFrame, seed, UDim2.new(0.1, 0, 0.05 + (i-1)*0.15, 0), UDim2.new(0.8, 0, 0.12, 0))
                btn.MouseButton1Click:Connect(function()
                    addToInventory(seed)
                end)
            end
            
            local fruits = {" Grapes", " candy Blossom", " Beanstalk", " Mango"}
            for i, fruit in ipairs(fruits) do
                local btn = createButton(fruitFrame, fruit, UDim2.new(0.1, 0, 0.1 + (i-1)*0.22, 0), UDim2.new(0.8, 0, 0.18, 0))
                btn.MouseButton1Click:Connect(function()
                    addToInventory(fruit)
                end)
            end
            
            local pets = {" Frog", " Echo Frog", " Raccoon"}
            for i, pet in ipairs(pets) do
                local btn = createButton(petFrame, pet, UDim2.new(0.1, 0, 0.1 + (i-1)*0.22, 0), UDim2.new(0.8, 0, 0.18, 0))
                btn.MouseButton1Click:Connect(function()
                    addToInventory(pet)
                end)
            end
            
            -- Переключение вкладок (добавлен "Дюп")
            tabButtons[1].MouseButton1Click:Connect(function()
                seedFrame.Visible = true
                fruitFrame.Visible = false
                petFrame.Visible = false
                dupFrame.Visible = false
            end)
            
            tabButtons[2].MouseButton1Click:Connect(function()
                seedFrame.Visible = false
                fruitFrame.Visible = true
                petFrame.Visible = false
                dupFrame.Visible = false
            end)
            
            tabButtons[3].MouseButton1Click:Connect(function()
                seedFrame.Visible = false
                fruitFrame.Visible = false
                petFrame.Visible = true
                dupFrame.Visible = false
            end)
            
            tabButtons[4].MouseButton1Click:Connect(function()
                seedFrame.Visible = false
                fruitFrame.Visible = false
                petFrame.Visible = false
                dupFrame.Visible = true
            end)
            
            -- Кнопка закрытия (белая)
            local closeBtn = createButton(mainFrame, "✖", UDim2.new(0.9, 0, 0.02, 0), UDim2.new(0.08, 0, 0.08, 0))
            closeBtn.MouseButton1Click:Connect(function()
                mainGui:Destroy()
            end)
            
            -- Анимация появления
            mainFrame.Size = UDim2.new(0, 0, 0.8, 0)
            mainFrame.Position = UDim2.new(0.5, 0, 0.1, 0)
            
            local tween = TweenService:Create(
                mainFrame,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UserInputService.TouchEnabled and UDim2.new(0.95, 0, 0.9, 0) or UDim2.new(0.7, 0, 0.8, 0), 
                 Position = UserInputService.TouchEnabled and UDim2.new(0.025, 0, 0.05, 0) or UDim2.new(0.15, 0, 0.1, 0)}
            )
            tween:Play()
            
        else
            playSound("Error")
            local errorMsg = Instance.new("TextLabel")
            errorMsg.Text = "ОШИБКА: " .. tostring(remaining)
            errorMsg.Size = UDim2.new(0.8, 0, 0.08, 0)
            errorMsg.Position = UDim2.new(0.1, 0, 0.9, 0)
            errorMsg.BackgroundTransparency = 0.8
            errorMsg.BackgroundColor3 = Color3.fromRGB(255, 200, 200)
            errorMsg.TextColor3 = Color3.new(1, 0, 0)
            errorMsg.Font = Enum.Font.GothamBold
            errorMsg.TextSize = 14
            errorMsg.Parent = mainFrame
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0.1, 0)
            corner.Parent = errorMsg
            
            delay(3, function()
                errorMsg:Destroy()
            end)
            
            if remaining == "Неверный ключ" then
                wait(2)
                gui:Destroy()
            end
        end
    end)
    
    -- Анимация появления
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local tween = TweenService:Create(
        mainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UserInputService.TouchEnabled and UDim2.new(0.95, 0, 0.7, 0) or UDim2.new(0.9, 0, 0.6, 0), 
         Position = UserInputService.TouchEnabled and UDim2.new(0.025, 0, 0.15, 0) or UDim2.new(0.05, 0, 0.2, 0)}
    )
    tween:Play()
end

-- Обработчик входа игрока
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(2)
        createActivationWindow(player)
    end)
end)

-- Для уже подключенных игроков
for _, player in ipairs(Players:GetPlayers()) do
    createActivationWindow(player)
end
