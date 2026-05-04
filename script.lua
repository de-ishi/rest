if game.GameId ~= 9564673841 then print("-") return end
--[[
    carryToggle.Callback = function(state)
        manageConnection("carry", state, function()
            -- Carry logic
        end)
    end
]]
print("loading monkey")
local function manageConnection(name, state, func)
    if getgenv().connections[name] then
        getgenv().connections[name]:Disconnect()
        getgenv().connections[name] = nil
    end

    if state then
        getgenv().connections[name] = game:GetService("RunService").Heartbeat:Connect(func)
    end
end

local success, errorMsg = pcall(function()
    if getgenv().connections then
        for name, conn in pairs(getgenv().connections) do
            if conn and typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
    end
end)

getgenv().connections = {}

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Abyss Depths",
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#0a3a5c"), Transparency = 0 },
        ["50"] = { Color = Color3.fromHex("#1a5b8c"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#2a8bbc"), Transparency = 0 },
    }, { Rotation = 0 }),
    Background = Color3.fromHex("#0a1520"),
    BackgroundTransparency = 0,
    Outline = Color3.fromHex("#1a2a3a"),
    Text = Color3.fromHex("#e6f7ff"),
    Placeholder = Color3.fromHex("#4a6a8a"),
    Button = Color3.fromHex("#1a2a3a"),
    Icon = Color3.fromHex("#4da6ff"),
    Hover = Color3.fromHex("#4da6ff"),
    BackgroundTransparency = 0,
    WindowBackground = Color3.fromHex("#0a1520"),
    WindowShadow = Color3.fromHex("#000000"),
    DialogBackground = Color3.fromHex("#0a1520"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#e6f7ff"),
    DialogContent = Color3.fromHex("#c2e7ff"),
    DialogIcon = Color3.fromHex("#4da6ff"),
    WindowTopbarButtonIcon = Color3.fromHex("#4da6ff"),
    WindowTopbarTitle = Color3.fromHex("#e6f7ff"),
    WindowTopbarAuthor = Color3.fromHex("#c2e7ff"),
    WindowTopbarIcon = Color3.fromHex("#4da6ff"),
    TabBackground = Color3.fromHex("#1a2a3a"),
    TabTitle = Color3.fromHex("#e6f7ff"),
    TabIcon = Color3.fromHex("#4da6ff"),
    ElementBackground = Color3.fromHex("#1a2a3a"),
    ElementTitle = Color3.fromHex("#e6f7ff"),
    ElementDesc = Color3.fromHex("#c2e7ff"),
    ElementIcon = Color3.fromHex("#4da6ff"),
    PopupBackground = Color3.fromHex("#0a1520"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#e6f7ff"),
    PopupContent = Color3.fromHex("#c2e7ff"),
    PopupIcon = Color3.fromHex("#4da6ff"),
    DialogBackground = Color3.fromHex("#0a1520"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#e6f7ff"),
    DialogContent = Color3.fromHex("#c2e7ff"),
    DialogIcon = Color3.fromHex("#4da6ff"),
    Toggle = Color3.fromHex("#1a2a3a"),
    ToggleBar = Color3.fromHex("#4da6ff"),
    Checkbox = Color3.fromHex("#1a2a3a"),
    CheckboxIcon = Color3.fromHex("#4da6ff"),
    Slider = Color3.fromHex("#1a2a3a"),
    SliderThumb = Color3.fromHex("#4da6ff"),
})

local requestFunc = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request

WindUI.Services.payhip = {
    Name = "Payhip",
    Icon = "credit-card",

    Args = { "ProductSecret" },

    New = function(ProductSecret)
        function validateKey(key)
            print("Validating payhip ", string.sub(key, 1, 4) .. "****************")

            if not key or type(key) ~= "string" then
                return false, "Invalid key format"
            end

            local success, response = pcall(function()
                return requestFunc({
                    Url = "https://payhip.com/api/v2/license/verify?license_key=" .. key,
                    Method = "GET",
                    Headers = {
                        ["product-secret-key"] = ProductSecret
                    }
                })
            end)

            if not success then
                return false, "Connection failed"
            end

            local decodedSuccess, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(response.Body)
            end)

            if not decodedSuccess or not data then
                return false, "Invalid response"
            end

            if data.data and data.data.enabled == true then
                return true, "Valid Payhip license"
            else
                return false, "Invalid or disabled license"
            end
        end

        function copyLink()
            return setclipboard("discord.gg/Ne5m7u9tkq")
        end
        return {
            Verify = validateKey,
            Copy = copyLink
        }
    end
}
WindUI.Services.nev = {
    Name = "NebulAuth",
    Icon = "key",

    Args = { "ApiKey" },

    New = function(ApiToken)
        local BASE_URL = "https://api.nebulauth.com"
        local HttpService = game:GetService("HttpService")

        function validateKey(key)
            print("Validating nev key ", string.sub(key, 1, 4) .. "****************")

            if not key or type(key) ~= "string" then
                return false, "Invalid key format"
            end

            local body_obj = {
                key = key,
                requestId = HttpService:GenerateGUID(false),
            }
            local body_string = HttpService:JSONEncode(body_obj)

            local headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. ApiToken,
            }

            local hwid = gethwid and gethwid()
            if hwid and hwid ~= "" then
                headers["X-Hwid"] = hwid
            end

            local requestFunc = syn and syn.request or http and http.request or http_request or request
            if not requestFunc then
                return false, "No request function"
            end

            local success, res = pcall(function()
                return requestFunc({
                    Url = BASE_URL .. "/api/v1/keys/verify",
                    Method = "POST",
                    Headers = headers,
                    Body = body_string,
                })
            end)

            if not success or not res then
                return false, "Connection failed"
            end

            local ok, data = pcall(function()
                return HttpService:JSONDecode(res.Body)
            end)

            if not ok or not data then
                return false, "Invalid response"
            end

            if data.valid == true then
                return true, "Valid Nev key"
            else
                return false, data.reason or "Invalid key"
            end
        end

        function copyLink()
            return setclipboard("discord.gg/Ne5m7u9tkq")
        end

        return {
            Verify = validateKey,
            Copy = copyLink
        }
    end
}
local Window = WindUI:CreateWindow({
    Title = "rest - Monkey Bomb Tag!",
    Icon = "crown",
    Author = "by .gg/Ne5m7u9tkq",
    Folder = "Rest",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Abyss Depths",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
        end,
    },
    KeySystem = {
        Note = "JOIN: https://discord.gg/zhNZa2Crvg",
        API = {
            {

                Title = "Free",
                Desc = "Click to copy.",
                Icon = "key",
                Type = "nev",

                ApiKey = "mk_at_jX5aO_OfEWxvKMiciG_bCA46Ig4vLrZ2YIlJqSiqo1M",
            },

            {
                Title = "PREMIUM",
                Desc = "Click to copy.",
                Icon = "badge-dollar-sign",
                Type = "payhip",
                ProductSecret = "prod_sk_PuZGL_f17e100f4a5eb10fda5a93f67670641c0d500d9a",
            },
        },
        SaveKey = true,
    },
})


Window:DisableTopbarButtons({
    "Fullscreen"
})

Window:SetIconSize(40)

Window:EditOpenButton({
    Title = "Open Rest",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
            Color3.fromHex("FF0F7B"),
            Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({
    Title = "v1.0",
    Icon = "",
    Color = Color3.fromHex("#FAFA33"),
    Radius = 10,
})

Window:Tag({
    Title = "Released!",
    Icon = "",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 10,
})

Window:CreateTopbarButton("Join Discord", "crown",    function()
    local discordInvite = "https://discord.com/invite/Ne5m7u9tkq"

    local http_request = (syn and syn.request) or (http and http.request) or request
    if http_request then
        http_request({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Origin"] = "https://discord.com"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                cmd = "INVITE_BROWSER",
                args = {code = string.match(discordInvite, "discord%.com/invite/(%w+)")},
                nonce = game:GetService("HttpService"):GenerateGUID(false)
            })
        })
    end


end,  990)

local status = Window:Tab({
    Title = "Dashboard",
    Icon = "chart-column-increasing",
    Locked = false,
})
status:Select()

-- STATUS

status:Divider()

local Code = status:Code({
    Title = "<3",
    Code = [[print("Thank you for using *rest*!")
print("creator: oshied")]]
})

local dis = status:Button({
    Title = "Join Discord",
    Desc = "click to copy discord link!",
    Locked = false,
    Callback = function()
        setclipboard("https://discord.gg/nmqG8GMUnn")
        if http_request then
            http_request({
                Url = "http://127.0.0.1:6463/rpc?v=1",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["Origin"] = "https://discord.com"
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    cmd = "INVITE_BROWSER",
                    args = {code = string.match(discordInvite, "discord%.com/invite/(%w+)")},
                    nonce = game:GetService("HttpService"):GenerateGUID(false)
                })
            })
        end
    end
})

----------------------

local wa = Window:Tab({
    Title = "Main",
    Icon = "sword",
    Locked = false,
})

-- STATUS

wa:Divider()



local dis = wa:Button({
    Title = "Grab Bomb",
    Desc = "click to grab bomb!",
    Locked = false,
    Callback = function()
        for _,v in workspace.Bomb:GetChildren() do
            if v:FindFirstChild("Hitbox") then
                if v.Hitbox:FindFirstChild("TouchInterest") then
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Hitbox") then
                        firetouchinterest(v.Hitbox,game.Players.LocalPlayer.Character.Hitbox,0)
                        firetouchinterest(v.Hitbox,game.Players.LocalPlayer.Character.Hitbox,1)
                        firetouchinterest(v.Hitbox,game.Players.LocalPlayer.Character.Hitbox,0)
                    end

                end
            end
        end
    end
})


local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local bombFolder = Workspace:WaitForChild("Bomb")
local runnersFolder = Workspace:WaitForChild("Runners")

-- Function to find a runner with a "Hitbox" part
local function getRunnerHitbox()
    for _, runner in ipairs(runnersFolder:GetChildren()) do
        -- Check if the model has a humanoid
        local humanoid = runner:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local hitbox = runner:FindFirstChild("Hitbox")
            if hitbox and hitbox:IsA("BasePart") then
                return hitbox
            end
        end
    end
    return nil
end
local Toggle = wa:Toggle({
    Title = "Auto give bomb",
    Desc = "Automatically gives the bomb to a random enemy (only if you got the bomb)",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        manageConnection("autoGiveBomb", state, function()
            local character = player.Character

            if character and character.Parent == bombFolder then
                local hitbox = getRunnerHitbox()

                if hitbox then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        -- Store the original position
                        local originalPosition = rootPart.CFrame

                        -- Teleport to the Hitbox
                        rootPart.CFrame = hitbox.CFrame

                        -- Wait briefly for the frame update
                        task.wait(0.1)

                        -- Teleport back
                        rootPart.CFrame = originalPosition

                        task.wait(.1)
                    end
                end
            end
        end)
    end
})


-----------------------------------------
local other = Window:Tab({
    Title = "Other",
    Icon = "swords",
    Locked = false,
})

other:Divider()

local Toggle = other:Toggle({
    Title = "-",
    Desc = "-",
    Type = "Toggle",
    Value = false,
    Callback = function(state)

    end
})
-----------
local misc = Window:Tab({
    Title = "Misc",
    Icon = "hammer",
    Locked = false,
})

---- MISC
misc:Divider()

local ws = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed
local jp = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower

local WalkSlider = misc:Slider({
    Title = "WalkSpeed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 200,
        Default = 25,
    },
    Callback = function(value)
        ws = value
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end
})

local JumpSlider = misc:Slider({
    Title = "JumpPower",
    Step = 1,
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        jp = value
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = value
            end
        end
    end
})

task.spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = ws
                humanoid.JumpPower = jp
            end
        end
    end)
end)

misc:Divider()

local dis = misc:Button({
    Title = "Execute IY (admin)",
    Desc = "tp",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

local cs = Window:Tab({
    Title = "Coming soon...",
    Icon = "bird",
    Locked = true,
})
Window:Divider()
local settings = Window:Tab({
    Title = "Settings",
    Icon = "cog",
    Locked = false,
})

