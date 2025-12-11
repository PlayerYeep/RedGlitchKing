local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")
local gui = Instance.new("ScreenGui")
gui.Name = "RedGlitchKingUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
-- ******************************************************
-- FRAME SIZE AND LAYOUT VARIABLES
-- ******************************************************
local FRAME_WIDTH = 450
local FRAME_HEIGHT = 400
local BUTTON_WIDTH = 200
local BUTTON_HEIGHT = 40
local X_MARGIN = 15
local X_POS_LEFT = X_MARGIN
local X_POS_RIGHT = 235 
local Y_SPACING = 50 
local Y_START = 20
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, FRAME_WIDTH, 0, FRAME_HEIGHT)
frame.Position = UDim2.new(0.5, -FRAME_WIDTH/2, 0.5, -FRAME_HEIGHT/2) -- Centered
frame.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Parent = frame
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Red Glitch King UI"
title.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.Code
title.TextSize = 22
title.Parent = frame
-- ******************************************************
-- NEW: EXIT BUTTON (X)
-- ******************************************************
local exitButton = Instance.new("TextButton")
exitButton.Size = UDim2.new(0, 30, 0, 30)
exitButton.Position = UDim2.new(1, -30, 0, 0) -- Top Right Corner
exitButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.Font = Enum.Font.Code
exitButton.TextSize = 25
exitButton.Text = "X"
exitButton.Parent = frame
exitButton.MouseButton1Click:Connect(function()
    if gui then
        gui:Destroy() -- Destroy the entire ScreenGui
    end
end)
-- ******************************************************
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 30)
tabBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
tabBar.Parent = frame
local UIList = Instance.new("UIListLayout")
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.Parent = tabBar
local function createTabButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, FRAME_WIDTH/4, 1, 0) 
    btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.Code
    btn.TextSize = 20
    btn.Text = text
    btn.Parent = tabBar
    return btn
end
local page1Btn = createTabButton("Page 1")
local page2Btn = createTabButton("Page 2")
local page3Btn = createTabButton("Page 3")
local page4Btn = createTabButton("Page 4")
local function createTabContent()
    local tab = Instance.new("Frame")
    tab.Size = UDim2.new(1, -10, 1, -70)
    tab.Position = UDim2.new(0, 5, 0, 65)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    tab.Parent = frame
    return tab
end
local page1 = createTabContent()
local page2 = createTabContent()
local page3 = createTabContent()
local page4 = createTabContent()
local function showTab(tab)
    page1.Visible = false
    page2.Visible = false
    page3.Visible = false
    page4.Visible = false
    tab.Visible = true
end
showTab(page1)
------------------------------------------------------
-- TOGGLE UI
------------------------------------------------------
local UIS = game:GetService("UserInputService")
local KEY_TO_TOGGLE = Enum.KeyCode.RightShift -- Or any other key you prefer

local function toggleUI()
    frame.Visible = not frame.Visible
end

-- Key listener for the toggle key
UIS.InputBegan:Connect(function(input, gameProcessedEvent)
    -- Ensure the key press is not handled by the game (e.g., if a text box is focused)
    if not gameProcessedEvent and input.KeyCode == KEY_TO_TOGGLE then
        toggleUI()
    end
end)

-- ******************************************************
-- HIDE UI INITIALLY (Optional, but good practice for a key system)
-- ******************************************************
frame.Visible = false
-- ******************************************************

------------------------------------------------------
-- PAGE 1 - FLY, KICK, FLING, INFINITE YIELD, GOD MODE
------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local function getRoot()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end
local flying = false
local bv, bg
-- Key states
local keys = {
    W = false,
    A = false,
    S = false,
    D = false,
    Shift = false
}
-- Base speeds
local normalSpeed = 50
local boostSpeed = 120
-- Fly Button (Left Column, Row 1)
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, BUTTON_WIDTH, 0, BUTTON_HEIGHT)
flyButton.Position = UDim2.new(0, X_POS_LEFT, 0, Y_START)
flyButton.Text = "Toggle Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.Code
flyButton.TextSize = 22
flyButton.Parent = page1
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    local root = getRoot()
    if flying then
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = Vector3.zero
        bv.Parent = root
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bg.CFrame = workspace.CurrentCamera.CFrame
        bg.Parent = root
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end)
-- Key detection (No change)
UIS.InputBegan:Connect(function(input, gp)
    if gp or not flying then return end -- Only process flight keys if not game processed and fly is enabled
    if input.KeyCode == Enum.KeyCode.W then keys.W = true end
    if input.KeyCode == Enum.KeyCode.A then keys.A = true end
    if input.KeyCode == Enum.KeyCode.S then keys.S = true end
    if input.KeyCode == Enum.KeyCode.D then keys.D = true end
    if input.KeyCode == Enum.KeyCode.LeftShift then keys.Shift = true end
end)
UIS.InputEnded:Connect(function(input)
    -- Don't check 'gp' here, as we want to update key states even if game processed
    if input.KeyCode == Enum.KeyCode.W then keys.W = false end
    if input.KeyCode == Enum.KeyCode.A then keys.A = false end
    if input.KeyCode == Enum.KeyCode.S then keys.S = false end
    if input.KeyCode == Enum.KeyCode.D then keys.D = false end
    if input.KeyCode == Enum.KeyCode.LeftShift then keys.Shift = false end
end)
-- Flight movement (No change)
RunService.Heartbeat:Connect(function()
    if flying and bv and bg then
        local root = getRoot()
        local cam = workspace.CurrentCamera.CFrame
        bg.CFrame = cam
        local moveDir = Vector3.zero
        if keys.W then moveDir += cam.LookVector end
        if keys.S then moveDir -= cam.LookVector end
        if keys.A then moveDir -= cam.RightVector end
        if keys.D then moveDir += cam.RightVector end
        local speed = keys.Shift and boostSpeed or normalSpeed
        if moveDir.Magnitude > 0 then
            bv.Velocity = moveDir.Unit * speed
        else
            bv.Velocity = Vector3.zero -- Hover in place
        end
    end
end)
-- Kick Button (Right Column, Row 1)
local kickButton = Instance.new("TextButton")
kickButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
kickButton.Position = UDim2.new(0,X_POS_RIGHT,0,Y_START) 
kickButton.Text = "Kick"
kickButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
kickButton.TextColor3 = Color3.fromRGB(255,255,255)
kickButton.Font = Enum.Font.Code
kickButton.TextSize = 22
kickButton.Parent = page1
kickButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ZXAZyL3q",true))()
end)
-- Fling Button (Left Column, Row 2)
local flingButton = Instance.new("TextButton")
flingButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
flingButton.Position = UDim2.new(0,X_POS_LEFT,0,Y_START + Y_SPACING * 1)
flingButton.Text = "Fling Player"
flingButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
flingButton.TextColor3 = Color3.fromRGB(255,255,255)
flingButton.Font = Enum.Font.Code
flingButton.TextSize = 22
flingButton.Parent = page1
flingButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/joshclark756/joshclark756-s-scripts/refs/heads/main/fling%20player%20gui%20(unanchored%20parts).lua",true))() 
end)
-- Infinite Yield Button (Right Column, Row 2)
local IYButton = Instance.new("TextButton")
IYButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
IYButton.Position = UDim2.new(0,X_POS_RIGHT,0,Y_START + Y_SPACING * 1) -- Set to right column
IYButton.Text = "Infinite Yield FE"
IYButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
IYButton.TextColor3 = Color3.fromRGB(255,255,255)
IYButton.Font = Enum.Font.Code
IYButton.TextSize = 22
IYButton.Parent = page1
IYButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)
-- GOD MODE BUTTON (Left Column, Row 3)
local godModeEnabled = false
local godModeButton = Instance.new("TextButton")
godModeButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
godModeButton.Position = UDim2.new(0,X_POS_LEFT,0,Y_START + Y_SPACING * 2) -- Left Column, Row 3
godModeButton.Text = "Toggle God Mode"
godModeButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
godModeButton.TextColor3 = Color3.fromRGB(255,255,255)
godModeButton.Font = Enum.Font.Code
godModeButton.TextSize = 22
godModeButton.Parent = page1
godModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    if godModeEnabled then
        godModeButton.Text = "God Mode ON"
    else
        godModeButton.Text = "Toggle God Mode"
    end
end)
-- God Mode Heartbeat Loop (No change)
RunService.Heartbeat:Connect(function()
    if godModeEnabled then
        if humanoid and humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)
------------------------------------------------------
-- PAGE 2 - SKYBOX, DECAL SPAM, SOUND
------------------------------------------------------
-- Skybox Button (Left Column, Row 1)
local skyboxButton = Instance.new("TextButton")
skyboxButton.Size = UDim2.new(0, BUTTON_WIDTH, 0, BUTTON_HEIGHT)
skyboxButton.Position = UDim2.new(0, X_POS_LEFT, 0, Y_START)
skyboxButton.Text = "Change Skybox"
skyboxButton.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
skyboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
skyboxButton.Font = Enum.Font.Code
skyboxButton.TextSize = 22
skyboxButton.Parent = page2
skyboxButton.MouseButton1Click:Connect(function()
    local sky = Instance.new("Sky")
    local SKYBOX_ASSET_ID = "rbxassetid://116838267742664"
    sky.SkyboxBk = SKYBOX_ASSET_ID
    sky.SkyboxDn = SKYBOX_ASSET_ID
    sky.SkyboxFt = SKYBOX_ASSET_ID
    sky.SkyboxLf = SKYBOX_ASSET_ID
    sky.SkyboxRt = SKYBOX_ASSET_ID
    sky.SkyboxUp = SKYBOX_ASSET_ID
    sky.Parent = game.Lighting
end)
-- Decal Spam Button (Right Column, Row 1)
local ID = 116838267742664 
local Skybox_Toggle = true
local particle_Toggle = true
local decalspamButton = Instance.new("TextButton")
decalspamButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
decalspamButton.Position = UDim2.new(0,X_POS_RIGHT,0,Y_START) 
decalspamButton.Text = "Decal Spam"
decalspamButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
decalspamButton.TextColor3 = Color3.fromRGB(255,255,255)
decalspamButton.Font = Enum.Font.Code
decalspamButton.TextSize = 22
decalspamButton.Parent = page2
decalspamButton.MouseButton1Click:Connect(function()
    -- Apply decal to all parts
    for i,v in pairs (game.Workspace:GetDescendants()) do
        if v:IsA("Part") then
            for _,face in ipairs(Enum.NormalId:GetEnumItems()) do
                local decal = Instance.new("Decal")
                decal.Texture = "rbxassetid://" .. ID
                decal.Face = face
                decal.Parent = v
            end
        end
    end
    
    -- Apply Skybox
    if Skybox_Toggle == true then
        local sky = Instance.new("Sky")
        sky.Parent = game.Lighting
        sky.SkyboxBk = "rbxassetid://" .. ID
        sky.SkyboxDn = "rbxassetid://" .. ID
        sky.SkyboxFt = "rbxassetid://" .. ID
        sky.SkyboxLf = "rbxassetid://" .. ID
        sky.SkyboxRt = "rbxassetid://" .. ID
        sky.SkyboxUp = "rbxassetid://" .. ID
    end
    
    -- Apply Particle Emitters
    if particle_Toggle == true then
        for i,v in pairs (game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Parent and v.Parent ~= game.Players then 
                local particle = Instance.new("ParticleEmitter")
                particle.Texture = "rbxassetid://" .. ID
                particle.Parent = v
                particle.Rate = 200
            end
        end
    end
end)
-- Sound Button (Left Column, Row 2)
local ids = {103215672097028,103215672097028,103215672097028,103215672097028,103215672097028} 
local soundButton = Instance.new("TextButton")
soundButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
soundButton.Position = UDim2.new(0,X_POS_LEFT,0,Y_START + Y_SPACING * 1)
soundButton.Text = "Sound"
soundButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
soundButton.TextColor3 = Color3.fromRGB(255,255,255)
soundButton.Font = Enum.Font.Code
soundButton.TextSize = 22
soundButton.Parent = page2
soundButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")
    local sound = Instance.new("Sound")
    sound.Parent = head
    sound.SoundId = "rbxassetid://" .. ids[math.random(1,#ids)]
    sound.MaxDistance = 10000
    sound.Volume = 3
    sound:Play()
    task.delay(5, function()
        sound:Stop()
        sound:Destroy()
    end)
end)
------------------------------------------------------
-- PAGE 3 - FLING YOURSELF, NOCLIP, KILL ALL, SPRAY PAINT
------------------------------------------------------
-- Fling Yourself Button (Left Column, Row 1)
local flingSelfButton = Instance.new("TextButton") 
flingSelfButton.Size = UDim2.new(0, BUTTON_WIDTH, 0, BUTTON_HEIGHT)
flingSelfButton.Position = UDim2.new(0, X_POS_LEFT, 0, Y_START)
flingSelfButton.Text = "Fling Yourself"
flingSelfButton.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
flingSelfButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flingSelfButton.Font = Enum.Font.Code
flingSelfButton.TextSize = 22
flingSelfButton.Parent = page3
flingSelfButton.MouseButton1Click:Connect(function()
    local root = getRoot()
    root.Velocity = Vector3.new(0, 200, 0)
end)
-- NOCLIP (Right Column, Row 1)
local noclip = false
local parts = {}
local function updateParts()
    parts = {}
    local char = player.Character or player.CharacterAdded:Wait()
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(parts, v)
        end
    end
end
updateParts()
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart")
    task.wait(0.1)
    updateParts()
end)
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
noclipButton.Position = UDim2.new(0,X_POS_RIGHT,0,Y_START) -- RIGHT COLUMN
noclipButton.Text = "Toggle Noclip"
noclipButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
noclipButton.TextColor3 = Color3.fromRGB(255,255,255)
noclipButton.Font = Enum.Font.Code
noclipButton.TextSize = 22
noclipButton.Parent = page3
noclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        noclipButton.Text = "Noclip ON"
    else
        noclipButton.Text = "Toggle Noclip"
    end
end)
RunService.Stepped:Connect(function()
    if noclip then
        for _, part in ipairs(parts) do
            part.CanCollide = false
        end
    else
        for _, part in ipairs(parts) do
            part.CanCollide = true
        end
    end
end)
-- Kill All (Left Column, Row 2)
local killallButton = Instance.new("TextButton")
killallButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
killallButton.Position = UDim2.new(0,X_POS_LEFT,0,Y_START + Y_SPACING * 1)
killallButton.Text = "Kill All"
killallButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
killallButton.TextColor3 = Color3.fromRGB(255,255,255)
killallButton.Font = Enum.Font.Code
killallButton.TextSize = 22
killallButton.Parent = page3
killallButton.MouseButton1Click:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
     if player.Character and player.Character:FindFirstChild("Humanoid") then
      player.Character.Humanoid.Health = 0
     end
    end
end)
-- SPRAY PAINT IMAGE LOADER (Left Column, Row 3)
local SPILButton = Instance.new("TextButton")
SPILButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
SPILButton.Position = UDim2.new(0,X_POS_LEFT,0,Y_START + Y_SPACING * 2) -- Set to Row 3 (Y_SPACING * 2)
SPILButton.Text = "SP Image Loader use bypass.vip"
SPILButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
SPILButton.TextColor3 = Color3.fromRGB(255,255,255)
SPILButton.Font = Enum.Font.Code
SPILButton.TextSize = 22
SPILButton.Parent = page3
SPILButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Artem1093z/ScriptsGo/refs/heads/main/PNG_Loader.txt"))()
end)
------------------------------------------------------
-- PAGE 4 - ESP AND SLIDERS
------------------------------------------------------
-- ESP Toggle Button (Page 4, Left Column, Row 1)
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0, BUTTON_WIDTH, 0, BUTTON_HEIGHT)
espButton.Position = UDim2.new(0, X_POS_LEFT, 0, Y_START)
espButton.Text = "Load/Toggle External ESP"
espButton.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Font = Enum.Font.Code
espButton.TextSize = 22
espButton.Parent = page4
espButton.MouseButton1Click:Connect(function()
    -- Execute the external ESP script via loadstring
    loadstring(game:HttpGet("https://raw.githubusercontent.com/PlayerYeep/villager4415hub/refs/heads/main/ESP.lua"))()
    
    -- Update text to indicate load completion
    espButton.Text = "ESP Loaded (Check External UI)"
end)
--- 🚶 WALK SPEED SLIDER ---
-- Walk Speed Label (Right Column, Row 1 - Title)
local WS_Y_POS = Y_START
local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Size = UDim2.new(0, BUTTON_WIDTH, 0, 20)
walkSpeedLabel.Position = UDim2.new(0, X_POS_RIGHT, 0, WS_Y_POS)
walkSpeedLabel.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.Font = Enum.Font.Code
walkSpeedLabel.TextSize = 16
walkSpeedLabel.Text = "Walk Speed: 16"
walkSpeedLabel.Parent = page4
-- Walk Speed Slider (Right Column, Row 1 - Slider)
local walkSpeedSlider = Instance.new("TextButton")
walkSpeedSlider.Size = UDim2.new(0, BUTTON_WIDTH, 0, 20)
walkSpeedSlider.Position = UDim2.new(0, X_POS_RIGHT, 0, WS_Y_POS + 25) -- 5 pixels below the label
walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
walkSpeedSlider.BorderSizePixel = 1
walkSpeedSlider.BorderColor3 = Color3.fromRGB(255, 0, 0)
walkSpeedSlider.Text = ""
walkSpeedSlider.Parent = page4
local WSSliderBar = Instance.new("Frame")
WSSliderBar.Size = UDim2.new(0, 0, 1, 0)
WSSliderBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
WSSliderBar.BorderSizePixel = 0
WSSliderBar.Parent = walkSpeedSlider
local WSSliderHandle = Instance.new("Frame")
WSSliderHandle.Size = UDim2.new(0, 10, 1, 0)
WSSliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WSSliderHandle.BorderColor3 = Color3.fromRGB(255, 0, 0)
WSSliderHandle.BorderSizePixel = 1
WSSliderHandle.ZIndex = 2
WSSliderHandle.Parent = walkSpeedSlider
WSSliderHandle.Active = true
WSSliderHandle.Draggable = true
local MIN_SPEED = 16 
local MAX_SPEED = 100
local currentSpeed = MIN_SPEED
-- Function to update the character's speed
local function updateWalkSpeed(speed)
    speed = math.max(MIN_SPEED, math.min(MAX_SPEED, speed)) -- Clamp the speed
    currentSpeed = speed
    -- Wait for character if it hasn't loaded yet
    local currentHumanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if currentHumanoid then
        currentHumanoid.WalkSpeed = speed
    end
    walkSpeedLabel.Text = string.format("Walk Speed: %.0f", speed)
end
-- Function to convert X position to a speed value
local function getSpeedFromX(x)
    local width = walkSpeedSlider.AbsoluteSize.X
    local ratio = math.max(0, math.min(1, (x - walkSpeedSlider.AbsolutePosition.X) / width))
    return MIN_SPEED + ratio * (MAX_SPEED - MIN_SPEED)
end
-- Function to convert speed value to handle position
local function getXFromSpeed(speed)
    -- This function is no longer strictly needed for initialization, but kept for logic clarity
    local ratio = (speed - MIN_SPEED) / (MAX_SPEED - MIN_SPEED)
    return UDim2.new(ratio, -WSSliderHandle.Size.X.Offset / 2, 0, 0)
end
-- WalkSpeed Drag handling
local WS_dragging = false
WSSliderHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        WS_dragging = true
        input.Handled = true
    end
end)
UIS.InputChanged:Connect(function(input)
    if WS_dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType.Touch) then
        local newSpeed = getSpeedFromX(input.Position.X)
        updateWalkSpeed(newSpeed)
        
        -- Update UI elements based on the new speed
        local xRatio = (newSpeed - MIN_SPEED) / (MAX_SPEED - MIN_SPEED)
        WSSliderBar.Size = UDim2.new(xRatio, 0, 1, 0)
        WSSliderHandle.Position = UDim2.new(xRatio, -WSSliderHandle.Size.X.Offset / 2, 0, 0)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType.Touch then
        WS_dragging = false
    end
end)
-- Initial WalkSpeed setup
updateWalkSpeed(MIN_SPEED) 
WSSliderBar.Size = UDim2.new(0, 0, 1, 0)
WSSliderHandle.Position = getXFromSpeed(MIN_SPEED)
--- ⬆️ JUMP POWER SLIDER ---
local JP_Y_POS = WS_Y_POS + Y_SPACING -- Below the Walk Speed Slider
-- Jump Power Label (Right Column, Row 2 - Title)
local jumpPowerLabel = Instance.new("TextLabel")
jumpPowerLabel.Size = UDim2.new(0, BUTTON_WIDTH, 0, 20)
jumpPowerLabel.Position = UDim2.new(0, X_POS_RIGHT, 0, JP_Y_POS)
jumpPowerLabel.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
jumpPowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerLabel.Font = Enum.Font.Code
jumpPowerLabel.TextSize = 16
jumpPowerLabel.Text = "Jump Power: 50"
jumpPowerLabel.Parent = page4
-- Jump Power Slider (Right Column, Row 2 - Slider)
local jumpPowerSlider = Instance.new("TextButton")
jumpPowerSlider.Size = UDim2.new(0, BUTTON_WIDTH, 0, 20)
jumpPowerSlider.Position = UDim2.new(0, X_POS_RIGHT, 0, JP_Y_POS + 25) -- 5 pixels below the label
jumpPowerSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jumpPowerSlider.BorderSizePixel = 1
jumpPowerSlider.BorderColor3 = Color3.fromRGB(255, 0, 0)
jumpPowerSlider.Text = ""
jumpPowerSlider.Parent = page4
local JPSliderBar = Instance.new("Frame")
JPSliderBar.Size = UDim2.new(0, 0, 1, 0)
JPSliderBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
JPSliderBar.BorderSizePixel = 0
JPSliderBar.Parent = jumpPowerSlider
local JPSliderHandle = Instance.new("Frame")
JPSliderHandle.Size = UDim2.new(0, 10, 1, 0)
JPSliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
JPSliderHandle.BorderColor3 = Color3.fromRGB(255, 0, 0)
JPSliderHandle.BorderSizePixel = 1
JPSliderHandle.ZIndex = 2
JPSliderHandle.Parent = jumpPowerSlider
JPSliderHandle.Active = true
JPSliderHandle.Draggable = true
local MIN_JUMP = 0 
local MAX_JUMP = 150
local currentJump = 50
-- Function to update the character's jump power
local function updateJumpPower(power)
    power = math.max(MIN_JUMP, math.min(MAX_JUMP, power)) -- Clamp the power
    currentJump = power
    local currentHumanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if currentHumanoid then
        currentHumanoid.JumpPower = power
    end
    jumpPowerLabel.Text = string.format("Jump Power: %.0f", power)
end
-- Function to convert X position to a jump power value
local function getJumpPowerFromX(x)
    local width = jumpPowerSlider.AbsoluteSize.X
    local ratio = math.max(0, math.min(1, (x - jumpPowerSlider.AbsolutePosition.X) / width))
    return MIN_JUMP + ratio * (MAX_JUMP - MIN_JUMP)
end
-- JumpPower Drag handling
local JP_dragging = false
JPSliderHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        JP_dragging = true
        input.Handled = true
    end
end)
UIS.InputChanged:Connect(function(input)
    if JP_dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType.Touch) then
        local newPower = getJumpPowerFromX(input.Position.X)
        updateJumpPower(newPower)
        
        -- Update UI elements based on the new power
        local xRatio = (newPower - MIN_JUMP) / (MAX_JUMP - MIN_JUMP)
        JPSliderBar.Size = UDim2.new(xRatio, 0, 1, 0)
        JPSliderHandle.Position = UDim2.new(xRatio, -JPSliderHandle.Size.X.Offset / 2, 0, 0)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        JP_dragging = false
    end
end)
-- Initial JumpPower setup (Default Roblox JumpPower is 50)
local DEFAULT_JUMP_RATIO = (50 - MIN_JUMP) / (MAX_JUMP - MIN_JUMP)
updateJumpPower(50) 
JPSliderBar.Size = UDim2.new(DEFAULT_JUMP_RATIO, 0, 1, 0)
JPSliderHandle.Position = UDim2.new(DEFAULT_JUMP_RATIO, -JPSliderHandle.Size.X.Offset / 2, 0, 0)
------------------------------------------------------
-- TAB SWITCHING
------------------------------------------------------
page1Btn.MouseButton1Click:Connect(function() showTab(page1) end)
page2Btn.MouseButton1Click:Connect(function() showTab(page2) end)
page3Btn.MouseButton1Click:Connect(function() showTab(page3) end)
page4Btn.MouseButton1Click:Connect(function() showTab(page4) end)
