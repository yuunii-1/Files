-- Transparent GUI + ESP + Pet Randomizer with countdown
-- Made by Minami

-- Variables
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local espOn = false
local randomizerOn = false
local randomizerTime = 0
local randomizerCountdown = nil

-- Function to send Roblox notification
local function notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame (Fully transparent)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 180)
mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.Draggable = true

-- ESP Button
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0, 180, 0, 40)
espButton.Position = UDim2.new(0, 10, 0, 10)
espButton.Text = "ESP: OFF"
espButton.BackgroundTransparency = 0.3
espButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Parent = mainFrame

-- Pet Randomizer Label
local randomizerLabel = Instance.new("TextLabel")
randomizerLabel.Size = UDim2.new(0, 180, 0, 40)
randomizerLabel.Position = UDim2.new(0, 10, 0, 60)
randomizerLabel.Text = "Pet Randomizer: OFF"
randomizerLabel.BackgroundTransparency = 0.3
randomizerLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
randomizerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
randomizerLabel.Parent = mainFrame

-- ON Button
local onButton = Instance.new("TextButton")
onButton.Size = UDim2.new(0, 85, 0, 40)
onButton.Position = UDim2.new(0, 10, 0, 110)
onButton.Text = "ON"
onButton.BackgroundTransparency = 0.3
onButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
onButton.TextColor3 = Color3.fromRGB(255, 255, 255)
onButton.Parent = mainFrame

-- OFF Button
local offButton = Instance.new("TextButton")
offButton.Size = UDim2.new(0, 85, 0, 40)
offButton.Position = UDim2.new(0, 105, 0, 110)
offButton.Text = "OFF"
offButton.BackgroundTransparency = 0.3
offButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
offButton.TextColor3 = Color3.fromRGB(255, 255, 255)
offButton.Parent = mainFrame

-- Made by Minami Label
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(0, 180, 0, 20)
credit.Position = UDim2.new(0, 10, 0, 155)
credit.Text = "Made by Minami"
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.TextScaled = true
credit.Parent = mainFrame

-- ESP Button Function
espButton.MouseButton1Click:Connect(function()
    if espOn then
        espOn = false
        espButton.Text = "ESP: OFF"
        notify("ESP", "ESP Disabled", 3)
    else
        espOn = true
        espButton.Text = "ESP: Initializing..."
        notify("ESP", "ESP Initializing...", 3)
        task.delay(3, function()
            if espOn then
                espButton.Text = "ESP: ON"
                notify("ESP", "ESP Enabled", 3)
            end
        end)
    end
end)

-- Start Randomizer
local function startRandomizer()
    while randomizerOn do
        randomizerTime = math.random(30, 40)
        for i = randomizerTime, 1, -1 do
            if not randomizerOn then break end
            randomizerLabel.Text = "Pet Randomizer: " .. i .. "s"
            task.wait(1)
        end
    end
    if not randomizerOn then
        randomizerLabel.Text = "Pet Randomizer: OFF"
    end
end

-- ON Button Function
onButton.MouseButton1Click:Connect(function()
    if randomizerOn and randomizerTime > 0 then
        notify("Pet Randomizer", "Please wait (" .. randomizerTime .. "s)", 3)
        return
    end
    if not randomizerOn then
        randomizerOn = true
        notify("Pet Randomizer", "Active Randomizer On", 3)
        task.spawn(startRandomizer)
    end
end)

-- OFF Button Function
offButton.MouseButton1Click:Connect(function()
    if randomizerOn then
        randomizerOn = false
        notify("Pet Randomizer", "Pet Randomizer Turned Off", 3)
        randomizerLabel.Text = "Pet Randomizer: OFF"
    end
end)
