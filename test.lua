--// COOL MENU - SINGLE SCRIPT FOR EVERYONE
-- Put this inside ServerScriptService

local Players = game:GetService("Players")

local function createGui(player)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "CoolMenu"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 260, 0, 350)
	frame.Position = UDim2.new(0.05, 0, 0.25, 0)
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame.BorderSizePixel = 0
	frame.Parent = screenGui

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 40)
	title.Text = "Cool Menu"
	title.TextColor3 = Color3.new(1,1,1)
	title.BackgroundTransparency = 1
	title.TextScaled = true
	title.Parent = frame

	local y = 50

	local function createButton(text, callback)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, -20, 0, 35)
		button.Position = UDim2.new(0, 10, 0, y)
		button.Text = text
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		button.TextColor3 = Color3.new(1,1,1)
		button.Parent = frame
		
		button.MouseButton1Click:Connect(callback)
		y = y + 45
	end

	createButton("Speed Boost", function()
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = 50 end
	end)

	createButton("Normal Speed", function()
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = 16 end
	end)

	createButton("Infinite Jump", function()
		local char = player.Character
		if not char then return end
		
		if char:FindFirstChild("InfJump") then
			char.InfJump:Destroy()
			return
		end
		
		local tag = Instance.new("BoolValue")
		tag.Name = "InfJump"
		tag.Parent = char
		
		player:GetMouse().KeyDown:Connect(function(key)
			if key == " " and char:FindFirstChild("Humanoid") then
				char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	end)

	createButton("Fly", function()
		local char = player.Character
		if not char then return end
		
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		
		if hrp:FindFirstChild("FlyVelocity") then
			hrp.FlyVelocity:Destroy()
			return
		end
		
		local bv = Instance.new("BodyVelocity")
		bv.Name = "FlyVelocity"
		bv.MaxForce = Vector3.new(100000,100000,100000)
		bv.Velocity = Vector3.new(0,50,0)
		bv.Parent = hrp
	end)

	createButton("Heal", function()
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.Health = hum.MaxHealth end
	end)

	createButton("God Mode", function()
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.MaxHealth = math.huge hum.Health = math.huge end
	end)
end

-- Add GUI to all players
for _, player in ipairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(function()
		task.wait(1)
		createGui(player)
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(1)
		createGui(player)
	end)
end)
