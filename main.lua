----------------------------------------------------------
-- SETUP
----------------------------------------------------------
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local Run = game:GetService("RunService")

local function getChar()
	local c = player.Character or player.CharacterAdded:Wait()
	local h = c:WaitForChild("Humanoid")
	local r = c:WaitForChild("HumanoidRootPart")
	return c,h,r
end

local character, humanoid, root = getChar()
player.CharacterAdded:Connect(function()
	character, humanoid, root = getChar()
end)

----------------------------------------------------------
-- GUI
----------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,350,0,300)
frame.Position = UDim2.new(0.5,-175,0.5,-150)
frame.BackgroundColor3 = Color3.fromRGB(30,0,0)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "Red Glitch King UI"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,0,0)
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

local function createTab(text)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,100,1,0)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(80,0,0)
	b.TextColor3 = Color3.new(1,0,0)
	b.Font = Enum.Font.Code
	b.TextSize = 20
	b.Parent = tabBar
	return b
end

local page1Btn = createTab("Page 1")
local page2Btn = createTab("Page 2")
local page3Btn = createTab("Page 3")

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
-- BUTTON CREATOR
----------------------------------------------------------
local function button(parent,text,y,callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,200,0,40)
	b.Position = UDim2.new(0,50,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(140,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.Code
	b.TextSize = 22
	b.Parent = parent
	if callback then
		b.MouseButton1Click:Connect(callback)
	end
	return b
end

----------------------------------------------------------
-- PAGE 1 — MOVEMENT
----------------------------------------------------------

-- Fly
local flying = false
local bv,bg

button(page1,"Toggle Fly",20,function()
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

Run.Heartbeat:Connect(function()
	if flying and bv then
		local cam = workspace.CurrentCamera.CFrame
		bv.Velocity = cam.LookVector * 50
		bg.CFrame = cam
	end
end)

-- Noclip
local noclip = false
local parts = {}

local function refresh()
	parts = {}
	if not player.Character then return end
	for _,p in ipairs(player.Character:GetChildren()) do
		if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
			table.insert(parts,p)
		end
	end
end
refresh()
player.CharacterAdded:Connect(refresh)

button(page1,"Toggle Noclip",70,function()
	noclip = not noclip
end)

Run.Stepped:Connect(function()
	for _,p in ipairs(parts) do
		p.CanCollide = not noclip
	end
	if player.Character then
		player.Character.HumanoidRootPart.CanCollide = true
	end
end)

-- Infinite Jump
local infjump = false
button(page1,"Toggle Infinite Jump",120,function()
	infjump = not infjump
end)

UIS.JumpRequest:Connect(function()
	if infjump then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- Fling
button(page1,"Fling Yourself",170,function()
	root.Velocity = Vector3.new(0,250,0)
end)

----------------------------------------------------------
-- PAGE 2 — EFFECTS
----------------------------------------------------------

button(page2,"Change Skybox",20,function()
	local s = Instance.new("Sky")
	local id = "rbxassetid://116838267742664"
	s.SkyboxBk=s.SkyboxDn=s.SkyboxFt=s.SkyboxLf=s.SkyboxRt=s.SkyboxUp=id
	s.Parent = game.Lighting
end)

local god = false
button(page2,"Toggle Godmode",70,function()
	god = not god
end)

humanoid.HealthChanged:Connect(function()
	if god then
		humanoid.Health = humanoid.MaxHealth
	end
end)

----------------------------------------------------------
-- PAGE 3 — SLIDERS
----------------------------------------------------------

local function slider(parent,name,min,max,def,y,callback)
	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(0,200,0,20)
	bg.Position = UDim2.new(0,50,0,y)
	bg.BackgroundColor3 = Color3.fromRGB(80,0,0)
	bg.Parent = parent

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0,20,1,0)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	knob.Parent = bg

	local drag = false

	knob.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then
			drag = true
		end
	end)

	knob.InputEnded:Connect(function()
		drag = false
	end)

	UIS.InputChanged:Connect(function(i)
		if drag then
			local pos = math.clamp((i.Position.X-bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)
			knob.Position = UDim2.new(pos,-10,0,0)
			callback(min + (max-min)*pos)
		end
	end)

	callback(def)
end

slider(page3,"WalkSpeed",16,200,50,20,function(v)
	humanoid.WalkSpeed = v
end)

slider(page3,"JumpPower",50,400,150,70,function(v)
	humanoid.JumpPower = v
end)

print("UI Loaded Correctly!")
