-- WORKING RedGlitchKing GUI
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local CG = game:GetService("CoreGui")
local TS = game:GetService("TweenService")

if CG:FindFirstChild("RedGlitchKingGUI") then
    CG.RedGlitchKingGUI:Destroy()
end

local RedGlitchKingGUI = Instance.new("ScreenGui")
RedGlitchKingGUI.Name = "RedGlitchKingGUI"
RedGlitchKingGUI.Parent = CG
RedGlitchKingGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 2
mainFrame.ClipsDescendants = true
mainFrame.Parent = RedGlitchKingGUI

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
title.BorderSizePixel = 0
title.Text = "RedGlitchKing GUI v7.0"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = mainFrame

local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.Size = UDim2.new(1, 0, 0, 30)
tabContainer.Position = UDim2.new(0, 0, 0, 30)
tabContainer.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
tabContainer.BorderSizePixel = 0
tabContainer.Parent = mainFrame

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -10, 1, -100)
contentFrame.Position = UDim2.new(0, 5, 0, 70)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 5
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
contentFrame.Parent = mainFrame

local statusBar = Instance.new("Frame")
statusBar.Name = "StatusBar"
statusBar.Size = UDim2.new(1, -10, 0, 30)
statusBar.Position = UDim2.new(0, 5, 1, -35)
statusBar.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
statusBar.BorderSizePixel = 0
statusBar.Parent = mainFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(0.7, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 5, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "SPEED: 0 studs/s"
speedLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = statusBar

local speedBarBg = Instance.new("Frame")
speedBarBg.Name = "SpeedBarBg"
speedBarBg.Size = UDim2.new(0.3, 0, 0.5, 0)
speedBarBg.Position = UDim2.new(0.7, -5, 0.25, 0)
speedBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedBarBg.BorderSizePixel = 0
speedBarBg.Parent = statusBar

local speedBarFill = Instance.new("Frame")
speedBarFill.Name = "SpeedBarFill"
speedBarFill.Size = UDim2.new(0, 0, 1, 0)
speedBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
speedBarFill.BorderSizePixel = 0
speedBarFill.Parent = speedBarBg

local tabs = {
    "Player",
    "Combat",
    "Visual",
    "Fun"
}

local tabButtons = {}
local currentTab = "Player"

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "Tab"
    tabButton.Size = UDim2.new(0.25, -2, 1, 0)
    tabButton.Position = UDim2.new((i-1) * 0.25, 0, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(0, 255, 0)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.Parent = tabContainer
    
    tabButton.MouseButton1Click:Connect(function()
        currentTab = tabName
        updateContent()
    end)
    
    tabButtons[tabName] = tabButton
end

function createButton(text, yPos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(0, 255, 0)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = contentFrame
    
    button.MouseEnter:Connect(function()
        TS:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 0, 0)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TS:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 0, 0)}):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

function createToggle(text, yPos, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.Position = UDim2.new(0, 5, 0, yPos)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = contentFrame
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(0.7, 0, 1, 0)
    toggleText.Position = UDim2.new(0, 0, 0, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = text
    toggleText.TextColor3 = Color3.fromRGB(0, 255, 0)
    toggleText.Font = Enum.Font.Gotham
    toggleText.TextSize = 14
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.25, 0, 0.7, 0)
    toggleButton.Position = UDim2.new(0.75, 0, 0.15, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    toggleButton.Text = "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 12
    toggleButton.Parent = toggleFrame
    
    local state = false
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TS:Create(toggleButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 60, 0)}):Play()
            toggleButton.Text = "ON"
            toggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            TS:Create(toggleButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 0, 0)}):Play()
            toggleButton.Text = "OFF"
            toggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        callback(state)
    end)
    
    return toggleButton
end

local flying = false
local noclip = false
local espEnabled = false
local speedHack = false
local infiniteJump = false
local flyVelocity
local flyConnection

function updateContent()
    for _, child in ipairs(contentFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
    
    local yPos = 0
    
    if currentTab == "Player" then
        createToggle("Fly", yPos, function(state)
            flying = state
            toggleFly(state)
        end)
        yPos = yPos + 35
        
        createToggle("Noclip", yPos, function(state)
            noclip = state
        end)
        yPos = yPos + 35
        
        createToggle("Speed Hack", yPos, function(state)
            speedHack = state
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = state and 50 or 16
            end
        end)
        yPos = yPos + 35
        
        createToggle("Infinite Jump", yPos, function(state)
            infiniteJump = state
        end)
        yPos = yPos + 35
        
        createButton("Heal Player", yPos, function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            end
        end)
    end
    
    if currentTab == "Combat" then
        createButton("Fling Nearest Player", yPos, function()
            flingNearestPlayer()
        end)
        yPos = yPos + 35
        
        createButton("Spin Nearest Player", yPos, function()
            spinNearestPlayer()
        end)
        yPos = yPos + 35
        
        createButton("Kill Nearest Player", yPos, function()
            killNearestPlayer()
        end)
        yPos = yPos + 35
        
        createButton("Fling All Players", yPos, function()
            flingAllPlayers()
        end)
    end
    
    if currentTab == "Visual" then
        createToggle("ESP Players", yPos, function(state)
            espEnabled = state
            toggleESP(state)
        end)
        yPos = yPos + 35
        
        createToggle("Fullbright", yPos, function(state)
            toggleFullbright(state)
        end)
        yPos = yPos + 35
        
        createButton("Remove ESP", yPos, function()
            espEnabled = false
            clearESP()
        end)
    end
    
    if currentTab == "Fun" then
        createButton("Dance Party", yPos, function()
            danceParty()
        end)
        yPos = yPos + 35
        
        createButton("Chat Spam", yPos, function()
            startChatSpam()
        end)
        yPos = yPos + 35
        
        createButton("Lag Server", yPos, function()
            createLag()
        end)
        
        createButton("ChangeSkybox", yPos, function()
            changeSkybox()
        end)
    end
end

function toggleFly(state)
    if state then
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
        
        -- Ð¡Ð¾Ð·Ð´Ð°ÐµÐ¼ BodyVelocity Ð´Ð»Ñ Ð¿Ð¾Ð»ÐµÑ‚Ð°
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.Name = "FlyVelocity"
        flyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        flyVelocity.P = 10000
        flyVelocity.Parent = player.Character.HumanoidRootPart
        
        -- ÐŸÐ¾Ð´ÐºÐ»ÑŽÑ‡Ð°ÐµÐ¼ Ð¾Ð±Ð½Ð¾Ð²Ð»ÐµÐ½Ð¸Ðµ Ð¿Ð¾Ð»ÐµÑ‚Ð°
        flyConnection = RS.RenderStepped:Connect(function()
            if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and flyVelocity then
                local camera = workspace.CurrentCamera
                local root = player.Character.HumanoidRootPart
                
                local direction = Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
                
                -- Ð£Ñ‡Ð¸Ñ‚Ñ‹Ð²Ð°ÐµÐ¼ ÑÐºÐ¾Ñ€Ð¾ÑÑ‚ÑŒ
                local speed = speedHack and 100 or 50
                flyVelocity.Velocity = direction * speed
                
                -- Ð”Ð¾Ð±Ð°Ð²Ð»ÑÐµÐ¼ Ð¿Ð»Ð°Ð²Ð½Ð¾Ðµ Ð´Ð²Ð¸Ð¶ÐµÐ½Ð¸Ðµ Ð²Ð²ÐµÑ€Ñ…/Ð²Ð½Ð¸Ð·
                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    flyVelocity.Velocity = flyVelocity.Velocity + Vector3.new(0, speed/2, 0)
                elseif UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                    flyVelocity.Velocity = flyVelocity.Velocity - Vector3.new(0, speed/2, 0)
                end
            end
        end)
    else
        if flyVelocity then
            flyVelocity:Destroy()
            flyVelocity = nil
        end
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
    end
end

function flingPlayer(target)
    if target == player then return end
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart
        
        -- Ð­Ñ„Ñ„ÐµÐºÑ‚Ð¸Ð²Ð½Ñ‹Ð¹ FE-ÑÐ¾Ð²Ð¼ÐµÑÑ‚Ð¸Ð¼Ñ‹Ð¹ Ñ„Ð»Ð¸Ð½Ð³
        hrp.Velocity = Vector3.new(0, 100, 0)
        wait(0.1)
        hrp.RotVelocity = Vector3.new(2000, 2000, 2000)
        
        -- Ð£Ð±Ð¸Ñ€Ð°ÐµÐ¼ Ð²Ñ€Ð°Ñ‰ÐµÐ½Ð¸Ðµ Ñ‡ÐµÑ€ÐµÐ· 2 ÑÐµÐºÑƒÐ½Ð´Ñ‹
        delay(2, function()
            if hrp then
                hrp.RotVelocity = Vector3.new(0, 0, 0)
            end
        end)
    end
end

function changeSkybox()
    DecalId = "rbxassetid://127134414593988"
     
    SkyBox = Instance.new("Sky")
    SkyBox.Name = "Plus"
    SkyBox.Parent = game.Lighting
    SkyBox.SkyboxBk = DecalId
    SkyBox.SkyboxDn = DecalId
    SkyBox.SkyboxFt = DecalId
    SkyBox.SkyboxRt = DecalId
    SkyBox.SkyboxLf = DecalId
    SkyBox.SkyboxUp = DecalId
    SkyBox.StarCount = 0

function flingNearestPlayer()
    local nearest, dist = nil, math.huge
    
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = p
                end
            end
        end
    end
    
    if nearest then 
        flingPlayer(nearest) 
        warn("Flinged: "..nearest.Name)
    end
end

function flingAllPlayers()
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player then
            flingPlayer(p)
        end
    end
end

function spinPlayer(target)
    if target == player then return end
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart
        hrp.RotVelocity = Vector3.new(0, 50, 0)
    end
end

function spinNearestPlayer()
    local nearest, dist = nil, math.huge
    
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = p
                end
            end
        end
    end
    
    if nearest then 
        spinPlayer(nearest)
        warn("Spinning: "..nearest.Name)
    end
end

local espObjects = {}
function toggleESP(state)
    clearESP()
    
    if state then
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP_"..p.Name
                highlight.OutlineColor = Color3.new(1, 0, 0)
                highlight.FillColor = Color3.new(0, 0, 0)
                highlight.FillTransparency = 0.8
                highlight.Parent = p.Character
                espObjects[p] = highlight
            end
        end
    end
end

function clearESP()
    for _, obj in pairs(espObjects) do
        if obj then obj:Destroy() end
    end
    espObjects = {}
end

-- Fullbright
function toggleFullbright(state)
    if state then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        game.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        game.Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
    end
end

function killNearestPlayer()
    local nearest, dist = nil, math.huge
    
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = p
                end
            end
        end
    end
    
    if nearest and nearest.Character:FindFirstChild("Humanoid") then
        nearest.Character.Humanoid.Health = 0
    end
end

function danceParty()
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Humanoid") then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://3189773368"
            p.Character.Humanoid:LoadAnimation(anim):Play()
        end
    end
end

function startChatSpam()
    spawn(function()
        for i = 1, 10 do
            wait(1)
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                "RedGlitchKing GUI is WORKING!", "All"
            )
        end
    end)
end

function createLag()
    for i = 1, 100 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(10, 10, 10)
        part.Position = Vector3.new(math.random(-100, 100), 50, math.random(-100, 100))
        part.Anchored = true
        part.Parent = workspace
        game.Debris:AddItem(part, 10)
    end
end

RS.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space and infiniteJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local lastPosition = Vector3.new(0,0,0)
if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    lastPosition = player.Character.HumanoidRootPart.Position
end

RS.RenderStepped:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local currentPos = player.Character.HumanoidRootPart.Position
        local distance = (currentPos - lastPosition).Magnitude
        local speed = math.floor(distance / RS.RenderStepped:Wait())
        
        speedLabel.Text = "SPEED: " .. speed .. " studs/s"
        speedBarFill.Size = UDim2.new(0, math.clamp(speed * 2, 0, speedBarBg.AbsoluteSize.X), 1, 0)
        lastPosition = currentPos
    end
end)

updateContent()

local dragging, dragInput, dragStart, startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

closeButton.MouseButton1Click:Connect(function()
    RedGlitchKingGUI:Destroy()
end)

UIS.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.F4 and not processed then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").Died:Connect(function()
        if flyVelocity then flyVelocity:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
        flying = false
    end)
end)

warn("RedGlitchKing GUI loaded! Press F4 to toggle")
