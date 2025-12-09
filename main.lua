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

local flying = false
local bv, bg

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

    if flying then
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Parent = root

        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bg.Parent = root
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if flying and bv then
        local cam = workspace.CurrentCamera.CFrame
        bv.Velocity = cam.LookVector * 50
        bg.CFrame = cam
    end
end)

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

local flingButton = Instance.new("TextButton")
flingButton.Size = UDim2.new(0, 200, 0, 40)
flingButton.Position = UDim2.new(0, 50, 0, 20)
flingButton.Text = "Fling Yourself"
flingButton.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
flingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flingButton.Font = Enum.Font.Code
flingButton.TextSize = 22
flingButton.Parent = page3

flingButton.MouseButton1Click:Connect(function()
    root.Velocity = Vector3.new(0, 200, 0)
end)

page1Btn.MouseButton1Click:Connect(function()
    showTab(page1)
end)
page2Btn.MouseButton1Click:Connect(function()
    showTab(page2)
end)
page3Btn.MouseButton1Click:Connect(function()
    showTab(page3)
end)
