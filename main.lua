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
soundButton.Position = UDim2.new(0,50,0,70)
soundButton.Text = "Sound"
soundButton.BackgroundColor3 = Color3.fromRGB(140,0,0)
soundButton.TextColor3 = Color3.fromRGB(255,255,255)
soundButton.Font = Enum.Font.Code
soundButton.TextSize = 22
soundButton.Parent = page2

soundButton.MouseButton1Click:Connect(function()
    game:GetService('Players').PlayerAdded:connect(function(player)
        player.CharacterAdded:connect(function(character)
            local sound = Instance.new("Sound",character.Head)
            local i = (ids[math.random(1,#ids)])
            sound.SoundId = "http://www.roblox.com/asset/?id=" .. i
            sound.MaxDistance = 1111111111111
            sound.Volume = 3.2
            sound:play()
            wait(5)
            sound:stop()
            sound:remove()
            
           end
       end
   end)

------------------------------------------------------
-- TAB SWITCHING
------------------------------------------------------
page1Btn.MouseButton1Click:Connect(function() showTab(page1) end)
page2Btn.MouseButton1Click:Connect(function() showTab(page2) end)
page3Btn.MouseButton1Click:Connect(function() showTab(page3) end)
