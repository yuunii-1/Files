--// Minami's Pet Randomizer UI //--
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MinamiUI_" .. math.random(1000, 9999)
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
mainFrame.BackgroundTransparency = 0.05
mainFrame.ClipsDescendants = true
mainFrame.AnchorPoint = Vector2.new(0,0)
mainFrame.ZIndex = 5
mainFrame.CornerRadius = UDim.new(0, 15)
Instance.new("UICorner", mainFrame)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "PET RANDOMIZER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = mainFrame

-- Made by
local madeBy = Instance.new("TextLabel")
madeBy.Size = UDim2.new(1, 0, 0, 20)
madeBy.Position = UDim2.new(0, 0, 0, 30)
madeBy.BackgroundTransparency = 1
madeBy.Font = Enum.Font.Gotham
madeBy.Text = "Made by Minami"
madeBy.TextColor3 = Color3.fromRGB(200, 200, 200)
madeBy.TextScaled = true
madeBy.Parent = mainFrame

-- ESP Button
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.9, 0, 0, 40)
espBtn.Position = UDim2.new(0.05, 0, 0, 60)
espBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 200)
espBtn.Font = Enum.Font.GothamBold
espBtn.Text = "ESP: OFF"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.TextScaled = true
Instance.new("UICorner", espBtn)
espBtn.Parent = mainFrame

-- Randomizer Label
local randLabel = Instance.new("TextLabel")
randLabel.Size = UDim2.new(1, 0, 0, 30)
randLabel.Position = UDim2.new(0, 0, 0, 110)
randLabel.BackgroundTransparency = 1
randLabel.Font = Enum.Font.Gotham
randLabel.Text = "Pet Randomizer: Idle"
randLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
randLabel.TextScaled = true
randLabel.Parent = mainFrame

-- ON Button
local onBtn = Instance.new("TextButton")
onBtn.Size = UDim2.new(0.45, 0, 0, 30)
onBtn.Position = UDim2.new(0.05, 0, 0, 160)
onBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
onBtn.Font = Enum.Font.GothamBold
onBtn.Text = "ON"
onBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
onBtn.TextScaled = true
Instance.new("UICorner", onBtn)
onBtn.Parent = mainFrame

-- OFF Button
local offBtn = Instance.new("TextButton")
offBtn.Size = UDim2.new(0.45, 0, 0, 30)
offBtn.Position = UDim2.new(0.5, 0, 0, 160)
offBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
offBtn.Font = Enum.Font.GothamBold
offBtn.Text = "OFF"
offBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
offBtn.TextScaled = true
Instance.new("UICorner", offBtn)
offBtn.Parent = mainFrame

-- Logic
local espState = false
local randActive = false
local randCooldown = false

-- ESP Logic
espBtn.MouseButton1Click:Connect(function()
    if not espState then
        espState = true
        StarterGui:SetCore("SendNotification", {
            Title = "ESP",
            Text = "ESP initializing...",
            Duration = 3
        })
        espBtn.Text = "ESP: Initializing..."
        task.spawn(function()
            for i = 1, 30 do
                espBtn.Text = "ESP: Initializing" .. string.rep(".", (i % 3) + 1)
                task.wait(1)
            end
            espBtn.Text = "ESP: ON"
            StarterGui:SetCore("SendNotification", {
                Title = "ESP",
                Text = "ESP ON",
                Duration = 3
            })
        end)
    else
        espState = false
        espBtn.Text = "ESP: OFF"
        StarterGui:SetCore("SendNotification", {
            Title = "ESP",
            Text = "ESP OFF",
            Duration = 3
        })
    end
end)

-- Randomizer Logic
local function startRandomizer()
    randActive = true
    while randActive do
        local waitTime = math.random(30, 40)
        randLabel.Text = "Pet Randomizer: " .. waitTime .. "s"
        StarterGui:SetCore("SendNotification", {
            Title = "Randomizer",
            Text = "Active Randomizer On...",
            Duration = 3
        })
        randCooldown = true
        for t = waitTime, 1, -1 do
            randLabel.Text = "Pet Randomizer: " .. t .. "s"
            task.wait(1)
        end
        randCooldown = false
    end
end

onBtn.MouseButton1Click:Connect(function()
    if not randActive then
        startRandomizer()
        onBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

offBtn.MouseButton1Click:Connect(function()
    if randCooldown then
        StarterGui:SetCore("SendNotification", {
            Title = "Randomizer",
            Text = "Please wait (" .. string.match(randLabel.Text, "%d+") .. "s)",
            Duration = 2
        })
    else
        randActive = false
        randLabel.Text = "Pet Randomizer: Idle"
        onBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        StarterGui:SetCore("SendNotification", {
            Title = "Randomizer",
            Text = "Randomizer Turned Off",
            Duration = 3
        })
    end
end)
