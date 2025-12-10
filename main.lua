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
local X_POS_RIGHT = 235 -- (FRAME_WIDTH - 10 - X_MARGIN - BUTTON_WIDTH) = 225, using 235 for visual margin
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
-- PAGE 1 - FLY, KICK, FLING (Two Columns Layout Applied)
------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
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
    if gp then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = true end
    if input.KeyCode == Enum.KeyCode.A then keys.A = true end
    if input.KeyCode == Enum.KeyCode.S then keys.S = true end
    if input.KeyCode == Enum.KeyCode.D then keys.D = true end
    if input.KeyCode == Enum.KeyCode.LeftShift then keys.Shift = true end
end)
UIS.InputEnded:Connect(function(input)
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

-- Kick Button (Right Column, Row 1 - MOVED TO RIGHT)
local kickButton = Instance.new("TextButton")
kickButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
kickButton.Position = UDim2.new(0,X_POS_RIGHT,0,Y_START) -- **CHANGED TO X_POS_RIGHT**
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
------------------------------------------------------
-- PAGE 2 - SKYBOX, DECAL SPAM, SOUND (Two Columns Layout Applied)
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

-- Decal Spam Button (Right Column, Row 1 - MOVED TO RIGHT)
local ID = 116838267742664 
local Skybox_Toggle = true
local particle_Toggle = true
local decalspamButton = Instance.new("TextButton")
decalspamButton.Size = UDim2.new(0,BUTTON_WIDTH,0,BUTTON_HEIGHT)
decalspamButton.Position = UDim2.new(0,X_POS_RIGHT,0,Y_START) -- **CHANGED TO X_POS_RIGHT**
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
-- PAGE 3 - FLING YOURSELF, NOCLIP, KILL ALL (Correct)
------------------------------------------------------
local Players = game:GetService("Players")
local player = Players.LocalPlayer

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

------------------------------------------------------
-- TAB SWITCHING
------------------------------------------------------
page1Btn.MouseButton1Click:Connect(function() showTab(page1) end)
page2Btn.MouseButton1Click:Connect(function() showTab(page2) end)
page3Btn.MouseButton1Click:Connect(function() showTab(page3) end)
page4Btn.MouseButton1Click:Connect(function() showTab(page4) end)
