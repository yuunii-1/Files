--// Movable GUI with ESP + Pet Randomizer Toggle
--// Made custom for your request

-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Functions
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 220, 0, 150)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.Active = true
Frame.Draggable = true

local title = Instance.new("TextLabel", Frame)
title.Text = "Pet Randomizer ✨"
title.TextColor3 = Color3.fromRGB(255, 170, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1

-- Buttons
local petBtn = Instance.new("TextButton", Frame)
petBtn.Size = UDim2.new(1, -10, 0, 40)
petBtn.Position = UDim2.new(0, 5, 0, 35)
petBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
petBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
petBtn.Font = Enum.Font.GothamBold
petBtn.TextSize = 14
petBtn.Text = "Pet Randomizer: OFF"

local espBtn = Instance.new("TextButton", Frame)
espBtn.Size = UDim2.new(1, -10, 0, 40)
espBtn.Position = UDim2.new(0, 5, 0, 85)
espBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 14
espBtn.Text = "ESP: OFF"

-- Variables
local espOn = false
local espInit = false
local petOn = false
local petStartTime = 0
local minPetOnTime = 30

-- ESP Button Logic
espBtn.MouseButton1Click:Connect(function()
    if espInit then
        Notify("ESP", "Please wait "..math.max(0, 30 - math.floor(tick() - petStartTime)).."s", 2)
        return
    end
    if not espOn then
        espInit = true
        espBtn.Text = "ESP: Turning On..."
        Notify("ESP", "ESP initializing...", 3)
        task.spawn(function()
            for i = 1, 30 do
                task.wait(1)
            end
            espOn = true
            espInit = false
            espBtn.Text = "ESP: ON"
            Notify("ESP", "ESP Enabled!", 2)
            -- Add ESP function here
        end)
    else
        espOn = false
        espBtn.Text = "ESP: OFF"
        Notify("ESP", "ESP Disabled!", 2)
        -- Remove ESP here
    end
end)

-- Pet Randomizer Logic
petBtn.MouseButton1Click:Connect(function()
    if not petOn then
        petOn = true
        petStartTime = tick()
        petBtn.Text = "Pet Randomizer: ON"
        Notify("Randomizer", "Active Randomizer On...", 2)
        -- Start pet randomizer function here
    else
        local timeOn = tick() - petStartTime
        if timeOn < minPetOnTime then
            Notify("Randomizer", "Please wait "..math.ceil(minPetOnTime - timeOn).."s before turning off", 2)
            return
        end
        petOn = false
        petBtn.Text = "Pet Randomizer: OFF"
        Notify("Randomizer", "Randomizer Disabled", 2)
        -- Stop pet randomizer function here
    end
end)
