--// Pet Randomizer Style GUI with Auto Randomize Timer //--
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Variables for states
local espOn = false
local autoRandomizeOn = false
local countdown = 30
local autoThread

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetRandomizer_" .. math.random(1000, 9999)
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Rounded corners
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

-- Title text
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -10, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Font = Enum.Font.GothamBold
titleText.Text = "Pet Randomizer ✨"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 18
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Subtitle
local subText = Instance.new("TextLabel")
subText.Size = UDim2.new(1, -10, 1, 0)
subText.Position = UDim2.new(0, 10, 0, 20)
subText.BackgroundTransparency = 1
subText.Font = Enum.Font.Gotham
subText.Text = "Made by – Minami"
subText.TextColor3 = Color3.fromRGB(230, 230, 230)
subText.TextSize = 12
subText.TextXAlignment = Enum.TextXAlignment.Left
subText.Parent = titleBar

-- Button template creator
local function createButton(text, color, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Parent = mainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- Buttons
local randomizeBtn = createButton("Randomize Pets", Color3.fromRGB(255, 140, 0), 50)
local espBtn = createButton("ESP: OFF", Color3.fromRGB(60, 60, 60), 100)
local autoBtn = createButton("Auto Randomize: OFF", Color3.fromRGB(200, 0, 0), 150)

-- ESP Toggle
espBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    if espOn then
        espBtn.Text = "ESP: ON"
        espBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        StarterGui:SetCore("SendNotification", {Title = "ESP", Text = "ESP Enabled", Duration = 2})
        -- Your ESP code here
    else
        espBtn.Text = "ESP: OFF"
        espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        StarterGui:SetCore("SendNotification", {Title = "ESP", Text = "ESP Disabled", Duration = 2})
        -- Your ESP disable code here
    end
end)

-- Randomize Pets button
local function doRandomize()
    StarterGui:SetCore("SendNotification", {Title = "Pet Randomizer", Text = "Randomized Pets!", Duration = 2})
    -- Your main function code here (replace this with your trade scam or pet randomizer function)
end

randomizeBtn.MouseButton1Click:Connect(doRandomize)

-- Auto Randomize toggle
autoBtn.MouseButton1Click:Connect(function()
    autoRandomizeOn = not autoRandomizeOn
    if autoRandomizeOn then
        autoBtn.Text = "Auto Randomize: ON"
        autoBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        countdown = 30
        autoThread = task.spawn(function()
            while autoRandomizeOn do
                randomizeBtn.Text = string.format("Randomize Pets (%ds)", countdown)
                task.wait(1)
                countdown -= 1
                if countdown <= 0 then
                    doRandomize()
                    countdown = 30
                end
            end
            randomizeBtn.Text = "Randomize Pets"
        end)
    else
        autoBtn.Text = "Auto Randomize: OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        randomizeBtn.Text = "Randomize Pets"
    end
end)
