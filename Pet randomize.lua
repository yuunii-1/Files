--// Made by Minami //--

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetRandomizer_" .. math.random(1000, 9999)
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 220)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.5
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "PET RANDOMIZER GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = mainFrame

-- Made by Minami text
local madeBy = Instance.new("TextLabel")
madeBy.Size = UDim2.new(1, 0, 0, 20)
madeBy.Position = UDim2.new(0, 0, 1, -20)
madeBy.BackgroundTransparency = 1
madeBy.Font = Enum.Font.Gotham
madeBy.Text = "Made by Minami"
madeBy.TextColor3 = Color3.fromRGB(200, 200, 200)
madeBy.TextScaled = true
madeBy.Parent = mainFrame

-- ESP Button
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.9, 0, 0, 40)
espBtn.Position = UDim2.new(0.05, 0, 0, 40)
espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espBtn.Font = Enum.Font.GothamBold
espBtn.Text = "ESP: OFF"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.TextScaled = true
espBtn.Parent = mainFrame

-- Pet Randomizer Label
local petRandomizerLabel = Instance.new("TextLabel")
petRandomizerLabel.Size = UDim2.new(0.9, 0, 0, 40)
petRandomizerLabel.Position = UDim2.new(0.05, 0, 0, 90)
petRandomizerLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
petRandomizerLabel.Font = Enum.Font.GothamBold
petRandomizerLabel.Text = "Pet Randomizer: OFF"
petRandomizerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
petRandomizerLabel.TextScaled = true
petRandomizerLabel.Parent = mainFrame

-- ON Button
local onBtn = Instance.new("TextButton")
onBtn.Size = UDim2.new(0.45, 0, 0, 40)
onBtn.Position = UDim2.new(0.05, 0, 0, 150)
onBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
onBtn.Font = Enum.Font.GothamBold
onBtn.Text = "ON"
onBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
onBtn.TextScaled = true
onBtn.Parent = mainFrame

-- OFF Button
local offBtn = Instance.new("TextButton")
offBtn.Size = UDim2.new(0.45, 0, 0, 40)
offBtn.Position = UDim2.new(0.5, 0, 0, 150)
offBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
offBtn.Font = Enum.Font.GothamBold
offBtn.Text = "OFF"
offBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
offBtn.TextScaled = true
offBtn.Parent = mainFrame

-- Logic
local espOn = false
local randomizerActive = false
local randomizerCooldown = false

-- ESP Button Function
espBtn.MouseButton1Click:Connect(function()
	if not espOn then
		StarterGui:SetCore("SendNotification", {Title = "ESP", Text = "ESP Initializing...", Duration = 3})
		task.delay(3, function()
			espOn = true
			espBtn.Text = "ESP: ON"
			espBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		end)
	else
		espOn = false
		espBtn.Text = "ESP: OFF"
		espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end
end)

-- Randomizer Function
local function startRandomizer()
	randomizerActive = true
	while randomizerActive do
		local waitTime = math.random(30, 40)
		for i = waitTime, 1, -1 do
			petRandomizerLabel.Text = "Pet Randomizer: " .. i .. "s"
			task.wait(1)
		end
		-- Cycle done (do your pet randomizing logic here)
	end
end

-- ON Button
onBtn.MouseButton1Click:Connect(function()
	if randomizerCooldown then
		StarterGui:SetCore("SendNotification", {Title = "Randomizer", Text = "Please wait...", Duration = 2})
		return
	end
	if not randomizerActive then
		randomizerActive = true
		onBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		offBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		StarterGui:SetCore("SendNotification", {Title = "Randomizer", Text = "Active Randomizer On...", Duration = 3})
		task.spawn(startRandomizer)
	end
end)

-- OFF Button
offBtn.MouseButton1Click:Connect(function()
	if randomizerActive then
		randomizerActive = false
		petRandomizerLabel.Text = "Pet Randomizer: OFF"
		onBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		offBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		StarterGui:SetCore("SendNotification", {Title = "Randomizer", Text = "Pet Randomizer Turned Off", Duration = 3})
	end
end)
