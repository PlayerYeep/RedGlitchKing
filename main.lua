----------------------------------------------------------
-- SETUP
----------------------------------------------------------
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

----------------------------------------------------------
-- GUI
----------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "RedGlitchKingUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30,0,0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "Red Glitch King UI"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.Code
title.TextSize = 22
title.Parent = frame

----------------------------------------------------------
-- TABS
----------------------------------------------------------
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1,0,0,30)
tabBar.Position = UDim2.new(0,0,0,30)
tabBar.BackgroundColor3 = Color3.fromRGB(40,0,0)
tabBar.Parent = frame

local UIList = Instance.new("UIListLayout")
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.Parent = tabBar

local function createTabButton(text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,100,1,0)
	btn.BackgroundColor3 = Color3.fromRGB(80,0,0)
	btn.TextColor3 = Color3.fromRGB(255,0,0)
	btn.Font = Enum.Font.Code
	btn.TextSize = 20
	btn.Text = text
	btn.Parent = tabBar
	return btn
end

local page1Btn = createTabButton("Page 1")
local page2Btn = createTabButton("Page 2")
local page3Btn = createTabButton("Page 3")

local function createPage()
	local p = Instance.new("Frame")
	p.Size = UDim2.new(1,-10,1,-70)
	p.Position = UDim2.new(0,5,0,65)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.Parent = frame
	return p
end

local page1 = createPage()
local page2 = createPage()
local page3 = createPage()

local function show(p)
	page1.Visible = false
	page2.Visible = false
	page3.Visible = false
	p.Visible = true
end
show(page1)

page1Btn.MouseButton1Click:Connect(function() show(page1) end)
page2Btn.MouseButton1Click:Connect(function() show(page2) end)
page3Btn.MouseButton1Click:Connect(function() show(page3) end)

----------------------------------------------------------
-- FLY
----------------------------------------------------------
local flying = false
local bv, bg

local fly = Instance.new("TextButton")
fly.Size = UDim2.new(0,200,0,40)
fly.Position = UDim2.new(0,50,0,20)
fly.Text = "Toggle Fly"
fly.BackgroundColor3 = Color3.fromRGB(140,0,0)
fly.TextColor3 = Color3.new(1,1,1)
fly.Font = Enum.Font.Code
fly.TextSize = 22
fly.Parent = page1

fly.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1e5,1e5,1e5)
		bv.Parent = root
		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
		bg.Parent = root
	else
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	if flying and bv then
		local c = workspace.CurrentCamera.CFrame
		bv.Velocity = c.LookVector * 50
		bg.CFrame = c
	end
end)

----------------------------------------------------------
-- SKYBOX
----------------------------------------------------------
local sky = Instance.new("TextButton")
sky.Size = UDim2.new(0,200,0,40)
sky.Position = UDim2.new(0,50,0,20)
sky.Text = "Change Skybox"
sky.BackgroundColor3 = Color3.fromRGB(140,0,0)
sky.TextColor3 = Color3.new(1,1,1)
sky.Font = Enum.Font.Code
sky.TextSize = 22
sky.Parent = page2

sky.MouseButton1Click:Connect(function()
	local s = Instance.new("Sky")
	s.SkyboxBk = "rbxassetid://116838267742664"
	s.SkyboxDn = "rbxassetid://116838267742664"
	s.SkyboxFt = "rbxassetid://116838267742664"
	s.SkyboxLf = "rbxassetid://116838267742664"
	s.SkyboxRt = "rbxassetid://116838267742664"
	s.SkyboxUp = "rbxassetid://116838267742664"
	s.Parent = game.Lighting
end)

----------------------------------------------------------
-- SELF FLING
----------------------------------------------------------
local fling = Instance.new("TextButton")
fling.Size = UDim2.new(0,200,0,40)
fling.Position = UDim2.new(0,50,0,20)
fling.Text = "Fling Yourself"
fling.BackgroundColor3 = Color3.fromRGB(140,0,0)
fling.TextColor3 = Color3.new(1,1,1)
fling.Font = Enum.Font.Code
fling.TextSize = 22
fling.Parent = page3

fling.MouseButton1Click:Connect(function()
	root.Velocity = Vector3.new(0,250,0)
end)

----------------------------------------------------------
-- NOCLIP
----------------------------------------------------------
local noclip = false
local parts = {}

local function update()
	parts = {}
	if not player.Character then return end
	for _,v in pairs(player.Character:GetChildren()) do
		if v:IsA("BasePart") then
			table.insert(parts,v)
		end
	end
end
update()
player.CharacterAdded:Connect(update)

local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0,200,0,40)
noclipBtn.Position = UDim2.new(0,50,0,70)
noclipBtn.Text = "Toggle Noclip"
noclipBtn.BackgroundColor3 = Color3.fromRGB(140,0,0)
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.Font = Enum.Font.Code
noclipBtn.TextSize = 22
noclipBtn.Parent = page3

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
end)

game:GetService("RunService").Stepped:Connect(function()
	if noclip then
		for _,p in ipairs(parts) do
			p.CanCollide = false
		end
	else
		for _,p in ipairs(parts) do
			p.CanCollide = true
		end
	end
end)

----------------------------------------------------------
-- GODMODE
----------------------------------------------------------
local god = false
local godBtn = Instance.new("TextButton")
godBtn.Size = UDim2.new(0,200,0,40)
godBtn.Position = UDim2.new(0,50,0,120)
godBtn.Text = "Toggle Godmode"
godBtn.BackgroundColor3 = Color3.fromRGB(140,0,0)
godBtn.TextColor3 = Color3.new(1,1,1)
godBtn.Font = Enum.Font.Code
godBtn.TextSize = 22
godBtn.Parent = page3

godBtn.MouseButton1Click:Connect(function()
	god = not god
end)

humanoid.HealthChanged:Connect(function()
	if god then
		humanoid.Health = humanoid.MaxHealth
	end
end)

----------------------------------------------------------
-- INFINITE JUMP
----------------------------------------------------------
game:GetService("UserInputService").JumpRequest:Connect(function()
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

----------------------------------------------------------
-- SLIDER SYSTEM
----------------------------------------------------------
local function slider(name, min, max, def, x, y, callback)
	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(0,200,0,20)
	bg.Position = UDim2.new(0,x,0,y)
	bg.BackgroundColor3 = Color3.fromRGB(80,0,0)
	bg.Parent = page3

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0,20,1,0)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	knob.Parent = bg

	local dragging = false

	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	knob.InputEnded:Connect(function()
		dragging = false
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging then
			local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)
			knob.Position = UDim2.new(pos,-10,0,0)
			local val = min + (max-min)*pos
			callback(val)
		end
	end)

	callback(def)
end

----------------------------------------------------------
-- SPEED SLIDER
----------------------------------------------------------
slider("Speed", 16, 200, 50, 50, 170, function(v)
	humanoid.WalkSpeed = v
end)

----------------------------------------------------------
-- JUMP SLIDER
----------------------------------------------------------
slider("Jump", 50, 400, 150, 50, 200, function(v)
	humanoid.JumpPower = v
end)

----------------------------------------------------------
print("Red Glitch King UI Loaded!")
----------------------------------------------------------
