-- GUI Pet Randomizer with ESP toggle
-- Made by - Minami

-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Variables
local randomizerActive = false
local countdown = 0
local espActive = false

-- Functions
local function sendNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 3;
    })
end

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "PetRandomizerGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.7, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 0.3
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Pet Randomizer GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

-- Pet Randomizer Button
local petButton = Instance.new("TextButton")
petButton.Size = UDim2.new(1, -20, 0, 50)
petButton.Position = UDim2.new(0, 10, 0, 50)
petButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
petButton.Text = "Pet Randomizer"
petButton.TextColor3 = Color3.fromRGB(255, 255, 255)
petButton.Font = Enum.Font.SourceSansBold
petButton.TextSize = 18
petButton.Parent = frame

-- On/Off Button
local onOffButton = Instance.new("TextButton")
onOffButton.Size = UDim2.new(1, -20, 0, 40)
onOffButton.Position = UDim2.new(0, 10, 0, 110)
onOffButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
onOffButton.Text = "ON"
onOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
onOffButton.Font = Enum.Font.SourceSansBold
onOffButton.TextSize = 18
onOffButton.Parent = frame

-- ESP Toggle Button
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, -20, 0, 40)
espButton.Position = UDim2.new(0, 10, 0, 160)
espButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
espButton.Text = "ESP: OFF"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Font = Enum.Font.SourceSansBold
espButton.TextSize = 18
espButton.Parent = frame

-- Footer Label
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.Text = "Made by - Minami"
footer.TextColor3 = Color3.fromRGB(255, 255, 255)
footer.Font = Enum.Font.SourceSans
footer.TextSize = 14
footer.Parent = frame

-- Countdown Handler
local function startRandomizer()
    if randomizerActive then return end
    randomizerActive = true
    countdown = math.random(30, 40)
    sendNotification("Pet Randomizer Started", tostring(countdown).."s")
    while countdown > 0 and randomizerActive do
        petButton.Text = "Pet Randomizer ("..countdown.."s)"
        onOffButton.Text = "Wait ("..countdown.."s)"
        onOffButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        countdown = countdown - 1
        task.wait(1)
    end
    petButton.Text = "Pet Randomizer"
    onOffButton.Text = "ON"
    onOffButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    randomizerActive = false
end

-- Button Functions
onOffButton.MouseButton1Click:Connect(function()
    if randomizerActive then
        sendNotification("Please wait", tostring(countdown).."s remaining")
    else
        startRandomizer()
    end
end)

espButton.MouseButton1Click:Connect(function()
    if espActive then
        espActive = false
        espButton.Text = "ESP: OFF"
        espButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        sendNotification("ESP", "ESP Disabled")
    else
        espActive = true
        espButton.Text = "ESP: ON"
        espButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        sendNotification("ESP", "ESP Enabled")
    end
end)
