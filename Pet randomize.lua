local CoreGui = game:GetService("CoreGui")

-- Create ScreenGui in CoreGui so it's always on top
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PetRandomizerUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 200)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 999999
MainFrame.Parent = ScreenGui

-- UICorner for rounded edges
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Randomize Pets Button
local RandomizeBtn = Instance.new("TextButton")
RandomizeBtn.Size = UDim2.new(0, 300, 0, 50)
RandomizeBtn.Position = UDim2.new(0.5, -150, 0, 20)
RandomizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
RandomizeBtn.Text = "Randomize Pets"
RandomizeBtn.TextScaled = true
RandomizeBtn.ZIndex = 999999
RandomizeBtn.Parent = MainFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = RandomizeBtn

-- ESP Status Label
local ESPLabel = Instance.new("TextLabel")
ESPLabel.Size = UDim2.new(0, 300, 0, 40)
ESPLabel.Position = UDim2.new(0.5, -150, 0, 80)
ESPLabel.BackgroundTransparency = 1
ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPLabel.Text = "ESP: Off"
ESPLabel.TextScaled = true
ESPLabel.ZIndex = 999999
ESPLabel.Parent = MainFrame

-- ON Button
local OnBtn = Instance.new("TextButton")
OnBtn.Size = UDim2.new(0, 140, 0, 40)
OnBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
OnBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
OnBtn.Text = "ON"
OnBtn.TextScaled = true
OnBtn.ZIndex = 999999
OnBtn.Parent = MainFrame

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 8)
UICorner3.Parent = OnBtn

-- OFF Button
local OffBtn = Instance.new("TextButton")
OffBtn.Size = UDim2.new(0, 140, 0, 40)
OffBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
OffBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
OffBtn.Text = "OFF"
OffBtn.TextScaled = true
OffBtn.ZIndex = 999999
OffBtn.Parent = MainFrame

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 8)
UICorner4.Parent = OffBtn

-- Script Logic
local isRandomizing = false
local countdown = 40
local espOn = false

local function startRandomizer()
    if isRandomizing then return end
    isRandomizing = true
    RandomizeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)

    for i = countdown, 1, -1 do
        RandomizeBtn.Text = "Randomize Pets (" .. i .. "s)"
        task.wait(1)
    end

    isRandomizing = false
    RandomizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    RandomizeBtn.Text = "Randomize Pets"
end

RandomizeBtn.MouseButton1Click:Connect(function()
    if not isRandomizing then
        startRandomizer()
        -- Insert your actual pet randomizing code here
    end
end)

OnBtn.MouseButton1Click:Connect(function()
    espOn = true
    ESPLabel.Text = "ESP: Turning On ..."
    -- Your ESP enable code
end)

OffBtn.MouseButton1Click:Connect(function()
    if isRandomizing then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Wait!",
            Text = "Please wait " .. countdown .. " seconds before turning off.",
            Duration = 2
        })
    else
        espOn = false
        ESPLabel.Text = "ESP: Off"
        -- Your ESP disable code
    end
end)
