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
	character,human oid,root = getChar()
end)

----------------------------------------------------------
-- GUI
----------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,350,0,250)
frame.Position = UDim2.new(0.5,-175,0.5,-125)
frame.BackgroundColor3 = Color3.fromRGB(30,0,0)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "Red Glitch King"
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
UIList.Parent = tabBar
UIList.FillDirection = Enum.FillDirection.Horizontal

local function btn(text)
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

local page1Btn = btn("Movement")
local page2Btn = btn("Effects")
local page3Btn = btn("Sliders")

local function page()
	local p = Instance.new("Frame")
	p.Size = UDim2.new(1,-10,1,-70)
	p.Position = UDim2.new(0,5,0,65)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.Parent = frame
	return p
end

local page1 = page()
local page2 = page()
local page3 = page()

local function show(p)
	page1.Visible = false
	page2.Visible = false
	page3.Visible = false
	p.Visible = true
end
show(page1)

page1Btn.MouseButton1Click:Connect(function()show(page1) end)
page2Btn.MouseButton1Click:Connect(function()show(page2) end)
page3Btn.MouseButton1Click:Connect(function()show(page3) end)

----------------------------------------------------------
-- MOVEMENT PAGE
----------------------------------------------------------

-- FLY
local flying = false
local bv, bg

local function makeButton(parent,text,y,func)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,200,0,40)
	b.Position = UDim2.new(0,50,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(140,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.Code
	b.TextSize = 22
	b.Parent = parent
	if func then b.MouseButton1Click:Connect(func) end
	return b
end

makeButton(page1,"Toggle Fly",20,function()
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
		local c = workspace.CurrentCamera.CFrame
		bv.Velocity = c.LookVector * 50
		bg.CFrame = c
	end
end)

-- NOCLIP
local noclip = false
local parts = {}

local function refresh()
	parts = {}
	if not player.Character then return end
	for _,v in ipairs(player.Character:GetChildren()) do
		if v:IsA("BasePart") then
			table.insert(parts,v)
		end
	end
end
refresh()
player.CharacterAdded:Connect(refresh)

makeButton(page1,"Toggle Noclip",70,function()
	noclip = not noclip
end)

Run.Stepped:Connect(function()
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

-- INFINITE JUMP
UIS.JumpRequest:Connect(function()
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- SELF FLING
makeButton(page1,"Fling Yourself",120,function()
	root.Velocity = Vector3.new(0,250,0)
end)

----------------------------------------------------------
-- EFFECTS PAGE
----------------------------------------------------------

-- SKYBOX
makeButton(page2,"Change Skybox",20,function()
	local s = Instance.new("Sky")
	local id = "rbxassetid://116838267742664"
	s.SkyboxBk=s.SkyboxDn=s.SkyboxFt=s.SkyboxLf=s.SkyboxRt=s.SkyboxUp=id
	s.Parent = game.Lighting
end)

-- GODMODE
local god = false
makeButton(page2,"Toggle Godmode",70,function()
	god = not god
end)

humanoid.HealthChanged:Connect(function()
	if god then
		humanoid.Health = humanoid.MaxHealth
	end
end)

----------------------------------------------------------
-- SLIDERS PAGE
----------------------------------------------------------

local function slider(name,min,max,def,x,y,callback)
	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(0,200,0,20)
	bg.Position = UDim2.new(0,x,0,y)
	bg.BackgroundColor3 = Color3.fromRGB(80,0,0)
	bg.Parent = page3

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
	knob.InputEnded:Connect(function() drag = false end)

	UIS.InputChanged:Connect(function(i)
		if drag then
			local pos = math.clamp((i.Position.X-bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)
			knob.Position = UDim2.new(pos,-10,0,0)
			callback(min + (max-min)*pos)
		end
	end)

	callback(def)
end

slider("Speed",16,200,50,50,20,function(v)
	humanoid.WalkSpeed = v
end)

slider("Jump",50,400,150,50,70,function(v)
	humanoid.JumpPower = v
end)

print("UI Loaded!")
