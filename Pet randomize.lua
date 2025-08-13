--// Pet Randomizer (Minami) - matches layout //--

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

--==== GUI =====================================================

local gui = Instance.new("ScreenGui")
gui.Name = "MinamiPetRand_" .. math.random(1000,9999)
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 280, 0, 270)
panel.Position = UDim2.new(0.05, 0, 0.28, 0)
panel.BackgroundColor3 = Color3.fromRGB(25,25,25)
panel.BackgroundTransparency = 0.35 -- translucent like your picture
panel.Active, panel.Draggable = true, true
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

-- Title bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 48)
title.BackgroundColor3 = Color3.fromRGB(255,140,0)
title.Text = "  Pet Randomizer ✨"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- credit (small)
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, -20, 0, 18)
credit.Position = UDim2.new(0, 10, 0, 50)
credit.BackgroundTransparency = 1
credit.Text = "Made by - Minami"
credit.TextColor3 = Color3.fromRGB(230,230,230)
credit.Font = Enum.Font.Gotham
credit.TextSize = 14
credit.TextXAlignment = Enum.TextXAlignment.Left
credit.Parent = panel

-- Big orange "Randomize Pets" (shows timer when auto is on)
local btnRandomize = Instance.new("TextButton")
btnRandomize.Size = UDim2.new(1, -40, 0, 50)
btnRandomize.Position = UDim2.new(0, 20, 0, 78)
btnRandomize.BackgroundColor3 = Color3.fromRGB(255,140,0)
btnRandomize.TextColor3 = Color3.fromRGB(255,255,255)
btnRandomize.Font = Enum.Font.GothamBlack
btnRandomize.TextSize = 22
btnRandomize.Text = "Randomize Pets"
btnRandomize.Parent = panel
Instance.new("UICorner", btnRandomize).CornerRadius = UDim.new(0, 10)

-- Black ESP button
local btnESP = Instance.new("TextButton")
btnESP.Size = UDim2.new(1, -40, 0, 50)
btnESP.Position = UDim2.new(0, 20, 0, 138)
btnESP.BackgroundColor3 = Color3.fromRGB(25,25,25)
btnESP.TextColor3 = Color3.fromRGB(255,255,255)
btnESP.Font = Enum.Font.GothamBlack
btnESP.TextSize = 22
btnESP.Text = "ESP: OFF"
btnESP.Parent = panel
Instance.new("UICorner", btnESP).CornerRadius = UDim.new(0, 10)

-- Bottom ON / OFF pair (controls Auto Randomizer)
local btnOn = Instance.new("TextButton")
btnOn.Size = UDim2.new(0.48, -22, 0, 50)
btnOn.Position = UDim2.new(0, 20, 1, -62)
btnOn.BackgroundColor3 = Color3.fromRGB(0,200,0)
btnOn.TextColor3 = Color3.fromRGB(255,255,255)
btnOn.Font = Enum.Font.GothamBlack
btnOn.TextSize = 22
btnOn.Text = "ON"
btnOn.Parent = panel
Instance.new("UICorner", btnOn).CornerRadius = UDim.new(0, 10)

local btnOff = Instance.new("TextButton")
btnOff.Size = UDim2.new(0.48, -22, 0, 50)
btnOff.Position = UDim2.new(1, - (20 + math.floor((280-40)*0.48)), 1, -62)
btnOff.BackgroundColor3 = Color3.fromRGB(55,55,55)
btnOff.TextColor3 = Color3.fromRGB(255,255,255)
btnOff.Font = Enum.Font.GothamBlack
btnOff.TextSize = 22
btnOff.Text = "OFF"
btnOff.Parent = panel
Instance.new("UICorner", btnOff).CornerRadius = UDim.new(0, 10)

--==== STATE ===================================================

local espOn = false
local espInit = false

local autoOn = false         -- overall auto-randomizer enabled?
local cycleActive = false    -- currently counting down?
local remaining = 0          -- remaining seconds in the current cycle
local autoThread = nil

local function setRandomizeText(sec) -- shows countdown on the orange button
    if sec and sec > 0 then
        btnRandomize.Text = ("Randomize Pets (%ds)"):format(sec)
    else
        btnRandomize.Text = "Randomize Pets"
    end
end

--==== ESP LOGIC ===============================================

local function runEspInitAnimation()
    espInit = true
    local dots = {".", "..", "...", ".."}
    local i = 1
    for t = 1, 30 do
        if not espInit then return end
        btnESP.Text = "ESP: Turning On" .. " " .. dots[i]
        i = i % #dots + 1
        task.wait(1)
    end
    if espInit then
        espOn, espInit = true, false
        btnESP.Text = "ESP: ON"
        notify("ESP", "ESP Enabled", 3)
    end
end

btnESP.MouseButton1Click:Connect(function()
    if not espOn and not espInit then
        btnESP.Text = "ESP: Turning On ..."
        notify("ESP", "ESP initializing..", 3)
        task.spawn(runEspInitAnimation)
    elseif espInit then
        notify("ESP", "ESP initializing..", 2)
    else
        -- turn OFF
        espOn, espInit = false, false
        btnESP.Text = "ESP: OFF"
        notify("ESP", "ESP Disabled", 3)
    end
end)

--==== AUTO RANDOMIZER LOGIC ===================================

local function autoCycle()
    while autoOn do
        -- start one cycle
        remaining = math.random(30, 40)
        cycleActive = true
        notify("Randomizer", "Active Randomizer On..", 2)
        for t = remaining, 1, -1 do
            if not autoOn then break end
            remaining = t
            setRandomizeText(t)
            task.wait(1)
        end
        -- cycle ends
        cycleActive = false
        remaining = 0
        setRandomizeText(nil)

        -- tiny window to allow OFF click between cycles
        -- (OFF only works in this gap, as requested)
        for _ = 1, 10 do
            if not autoOn then break end
            task.wait(0.05)
        end
    end
end

btnOn.MouseButton1Click:Connect(function()
    if autoOn then
        if cycleActive then
            notify("Randomizer", ("Please wait (%ds)"):format(remaining), 2)
        else
            notify("Randomizer", "Already ON", 2)
        end
        return
    end
    autoOn = true
    btnOn.BackgroundColor3 = Color3.fromRGB(0,255,0)
    btnOff.BackgroundColor3 = Color3.fromRGB(55,55,55)
    if not autoThread or coroutine.status(autoThread) == "dead" then
        autoThread = task.spawn(autoCycle)
    end
end)

btnOff.MouseButton1Click:Connect(function()
    if autoOn and cycleActive then
        -- OFF not allowed during countdown
        notify("Randomizer", ("Please wait (%ds)"):format(remaining), 2)
        return
    end
    if autoOn then
        autoOn = false
        btnOn.BackgroundColor3 = Color3.fromRGB(0,200,0)
        btnOff.BackgroundColor3 = Color3.fromRGB(200,50,50)
        setRandomizeText(nil)
        notify("Randomizer", "Randomizer Turned Off", 2)
        task.wait(0.15)
        btnOff.BackgroundColor3 = Color3.fromRGB(55,55,55)
    end
end)

--==== MANUAL "Randomize Pets" BUTTON ==========================

btnRandomize.MouseButton1Click:Connect(function()
    -- This stays clickable always (even during auto). Put your real randomize logic here.
    -- For now we just notify so you can see it fires.
    notify("Randomize Pets", "Manual randomize triggered!", 2)
end)
