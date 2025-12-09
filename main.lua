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
	character,humanoid,root = getChar()
end)

----------------------------------------------------------
-- GUI
----------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,420)
frame.Position = UDim2.new(0.5,-200,0.5,-210)
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
-- HELPER BUTTON
----------------------------------------------------------
local nextY = 40

local function makeButton(text, func)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,300,0,40)
	b.Position = UDim2.new(0,50,0,nextY)
	nextY += 50
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(140,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.Code
	b.TextSize = 20
	b.Parent = frame
	if func then b.MouseButton1Click:Connect(func) end
	return b
end

----------------------------------------------------------
-- MOVEMENT FEATURES
----------------------------------------------------------

-- Fly
local flying = false
local bv,bg

makeButton("Toggle Fly", function()
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

makeButton("Toggle Noclip", function()
	noclip = not noclip
end)

Run.Stepped:Connect(function()
	for _,p in ipairs(parts) do
		p.CanCollide = not noclip
	end
	if humanoid then
		humanoid.RootPart.CanCollide = true
	end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- Fling
makeButton("Fling Yourself", function()
	if root then
		root.Velocity = Vector3.new(0,250,0)
	end
end)

----------------------------------------------------------
-- EFFECTS
----------------------------------------------------------

makeButton("Change Skybox", function()
	local s = Instance.new("Sky")
	local id = "rbxassetid://116838267742664"
	s.SkyboxBk=s.SkyboxDn=s.SkyboxFt=s.SkyboxLf=s.SkyboxRt=s.SkyboxUp=id
	s.Parent = game.Lighting
end)

local god = false
makeButton("Toggle Godmode", function()
	god = not god
end)

humanoid.HealthChanged:Connect(function()
	if god then
		humanoid.Health = humanoid.MaxHealth
	end
end)

----------------------------------------------------------
-- SLIDERS
----------------------------------------------------------

local function slider(name,min,max,def,x,y,callback)

	local label = Instance.new("TextLabel")
	label.Parent = frame
	label.Position = UDim2.new(0,50,0,nextY)
	label.Size = UDim2.new(0,300,0,20)
	label.Text = name
	label.TextColor3 = Color3.new(1,1,1)

	nextY += 25

	local bg = Instance.new("Frame")
	bg.Parent = frame
	bg.Size = UDim2.new(0,300,0,20)
	bg.Position = UDim2.new(0,50,0,nextY)
	bg.BackgroundColor3 = Color3.fromRGB(80,0,0)

	local knob = Instance.new("Frame")
	knob.Parent = bg
	knob.Size = UDim2.new(0,20,1,0)
	knob.BackgroundColor3 = Color3.new(1,1,1)

	local drag = false

	knob.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = true
		end
	end)
	knob.InputEnded:Connect(function()
		drag = false
	end)

	UIS.InputChanged:Connect(function(i)
		if drag then
			local pos = math.clamp((i.Position.X - bg.AbsolutePosition.X)/bg.AbsoluteSize.X,0,1)
			knob.Position = UDim2.new(pos,-10,0,0)
			callback(min + (max-min)*pos)
		end
	end)

	callback(def)

	nextY += 40
end

slider("WalkSpeed",16,200,50,0,0,function(v)
	if humanoid then humanoid.WalkSpeed = v end
end)

slider("JumpPower",50,400,150,0,0,function(v)
	if humanoid then humanoid.JumpPower = v end
end)

print("Red Glitch King Loaded!")
