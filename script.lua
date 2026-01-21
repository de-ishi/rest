if game.PlaceId ~= 75992362647444 then print("-") return end
print("Loading TAP SIMULATOR")
local success, errorMsg = pcall(function()
    config = {
        click = false,
        quest = false,
        egg = false,
        chosenEgg = "Basic",
        eggAmount = 1,
        rebirthAmount = 1,
        rebirth = false,
        equipBest = false,
        island = false,
        jump = false,
        button = false,
        rebirthButtonIndex = 1,
        void = false ,
        upgrades = {"RebirthButtons"},
        upgrade = false,
        chest1 = false,
        chest2 = false,
        rank = false
    }
end)

local success, errorMsg = pcall(function()
    restart = false
end)

local     config = {
    click = false,
    quest = false,
    egg = false,
    chosenEgg = "Basic",
    eggAmount = 1,
    rebirthAmount = 1,
    rebirth = false,
    equipBest = false,
    island = false,
    jump = false,
    button = false,
    rebirthButtonIndex = 1,
    void = false,
    upgrades = {"RebirthButtons"},
    upgrade = false,
    chest1 = false,
    chest2 = false,
    rank = false
}
local restart = false
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Red Night", -- theme name

    -- Red accent gradient
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#7f1d1d"), Transparency = 0 }, -- Dark red
        ["50"] = { Color = Color3.fromHex("#991b1b"), Transparency = 0 }, -- Medium red
        ["100"] = { Color = Color3.fromHex("#dc2626"), Transparency = 0 }, -- Bright red
    }, {
        Rotation = 0,
    }),

    Background = Color3.fromHex("#0a0a0a"), -- Almost pure black
    BackgroundTransparency = 0,
    Outline = Color3.fromHex("#1a1a1a"), -- Slightly lighter black
    Text = Color3.fromHex("#ffffff"),
    Placeholder = Color3.fromHex("#404040"), -- Dark gray
    Button = Color3.fromHex("#1a1a1a"), -- Dark gray
    Icon = Color3.fromHex("#dc2626"), -- Red

    Hover = Color3.fromHex("#dc2626"), -- Red on hover
    BackgroundTransparency = 0,

    WindowBackground = Color3.fromHex("#0a0a0a"), -- Pure black
    WindowShadow = Color3.fromHex("#000000"),

    DialogBackground = Color3.fromHex("#0a0a0a"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#ffffff"),
    DialogContent = Color3.fromHex("#e5e5e5"), -- Light gray
    DialogIcon = Color3.fromHex("#dc2626"), -- Red

    WindowTopbarButtonIcon = Color3.fromHex("#dc2626"), -- Red
    WindowTopbarTitle = Color3.fromHex("#ffffff"),
    WindowTopbarAuthor = Color3.fromHex("#e5e5e5"), -- Light gray
    WindowTopbarIcon = Color3.fromHex("#dc2626"), -- Red

    TabBackground = Color3.fromHex("#1a1a1a"), -- Dark gray
    TabTitle = Color3.fromHex("#ffffff"),
    TabIcon = Color3.fromHex("#dc2626"), -- Red

    ElementBackground = Color3.fromHex("#1a1a1a"), -- Dark gray
    ElementTitle = Color3.fromHex("#ffffff"),
    ElementDesc = Color3.fromHex("#e5e5e5"), -- Light gray
    ElementIcon = Color3.fromHex("#dc2626"), -- Red

    PopupBackground = Color3.fromHex("#0a0a0a"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#ffffff"),
    PopupContent = Color3.fromHex("#e5e5e5"), -- Light gray
    PopupIcon = Color3.fromHex("#dc2626"), -- Red

    DialogBackground = Color3.fromHex("#0a0a0a"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#ffffff"),
    DialogContent = Color3.fromHex("#e5e5e5"), -- Light gray
    DialogIcon = Color3.fromHex("#dc2626"), -- Red

    Toggle = Color3.fromHex("#1a1a1a"), -- Dark gray
    ToggleBar = Color3.fromHex("#dc2626"), -- Red (when on)

    Checkbox = Color3.fromHex("#1a1a1a"), -- Dark gray
    CheckboxIcon = Color3.fromHex("#dc2626"), -- Red (checkmark)

    Slider = Color3.fromHex("#1a1a1a"), -- Dark gray track
    SliderThumb = Color3.fromHex("#dc2626"), -- Red thumb
})

local requestFunc = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request

WindUI.Services.payhip = {
    Name = "Payhip",
    Icon = "credit-card",

    Args = { "ProductSecret" },

    New = function(ProductSecret)
        print("Payhip service initialized")

        function validateKey(key)
            print("Validating Payhip key:", string.sub(key, 1, 4) .. "****************")

            if not key or type(key) ~= "string" then
                print("Invalid key format")
                return false, "Invalid key format"
            end

            print("Making request to Payhip API...")
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
                print("Payhip API request failed:", response)
                return false, "Connection failed"
            end

            print("Payhip API response received")
            local decodedSuccess, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(response.Body)
            end)

            if not decodedSuccess or not data then
                print("Failed to decode Payhip response")
                return false, "Invalid response"
            end

            print("Payhip response data:", data)

            if data.data and data.data.enabled == true then
                print("Payhip license is valid")
                return true, "Valid Payhip license"
            else
                print("Payhip license is invalid or disabled")
                return false, "Invalid or disabled license"
            end
        end

        function copyLink()
            print("Copying Discord link to clipboard")
            return setclipboard("discord.gg/Ne5m7u9tkq")
        end

        print("Payhip service setup complete")
        return {
            Verify = validateKey,
            Copy = copyLink
        }
    end
}
local Window = WindUI:CreateWindow({
    Title = "rest - Tap Simulator!",
    Icon = "crown",
    Author = "by .gg/Ne5m7u9tkq",
    Folder = "Rest",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Red Night",
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

                Title = "Freemium",
                Desc = "Click to copy.",
                Icon = "badge-check",

                Type = "platoboost",
                ServiceId = 5860,
                Secret = "5c8bedfc-c800-4a34-9948-aae9381070f4",
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

Window:Tag({
    Title = "v1.0.0",
    Icon = "",
    Color = Color3.fromHex("#FAFA33"),
    Radius = 13,
})

Window:Tag({
    Title = "release",
    Icon = "",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 13,
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
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Executor Not Supported",
            Text = "Join manually: "..discordInvite,
            Duration = 5
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
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Executor Not Supported",
                Text = "Join manually: "..discordInvite,
                Duration = 5
            })
        end
    end
})
status:Divider()
-----------------------------------------

local main = Window:Tab({
    Title = "Main",
    Icon = "sword",
    Locked = false,
})

main:Divider()

local Toggle = main:Toggle({
    Title = "Auto fast click",
    Desc = "automatically clicks for you",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.click = state
    end
})

local Toggle = main:Toggle({
    Title = "Auto claim quests",
    Desc = "Damages claims quests",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.quest = state
    end
})

main:Divider()

local eggsBackup = {"Poison","Magma","Divine","Evil Xmas Egg","5M Event","Elemental","Cyborg Egg","Forest","Chronos Egg","Tropical","Frozen","GetChance","adjustForLuck","Angelic","Safari","Volcanic","Roll","Space","Samurai","cache","Christmas Event","Holy","New Years Event","Sakura","Snowman","Candy","Moonflower","Infernal","Basic","Starry","Cactus","Cryo","Void Event","Acorn","Temple","Atlantis"}
local eggs = {}

local success, eggsModule = pcall(function()
    return require(game:GetService("ReplicatedStorage").Game.Eggs)
end)

if success and eggsModule then
    for eggName, eggData in pairs(eggsModule) do
        table.insert(eggs, eggName)
    end
else
    eggs = eggsBackup
end

local Dropdown = main:Dropdown({
    Title = "Select egg to hatch:",
    Desc = "select egg to hatch",
    Values = eggs,
    AllowNone = false,
    Value = "Basic",
    Callback = function(option)
        config.chosenEgg = option
    end
})

local Dropdown = main:Dropdown({
    Title = "Egg amount:",
    Desc = "How much you open at once",
    Values = { "1", "3", "8" },
    Value = "1",
    AllowNone = false,
    Callback = function(option)
        config.eggAmount = tonumber(option)
    end
})


local Toggle = main:Toggle({
    Title = "Auto open eggs",
    Desc = "auto hatches eggs for u",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.egg = state
    end
})

local dis = main:Button({
    Title = "Unlock all eggs",
    Desc = "unlocks locked eggs without reaching the requirement",
    Locked = false,
    Callback = function()
        local Network = require(game.ReplicatedStorage.Modules.Network)
        for i,v in ipairs(eggs) do
            Network:FireServer("RemoveLockedEgg",v)
        end
    end
})


local Toggle = main:Toggle({
    Title = "Auto equip best",
    Desc = "automatically equips best pets for u(cant see in ui)",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.equipBest = state
    end
})


local function getRebirths()
    local rebirths = {}

    local success = pcall(function()
        local rightHud = game:GetService("Players").LocalPlayer.PlayerGui.RightHud
        local rebirthsList = rightHud.Main.RightUI.Rebirths.List

        for _, frame in pairs(rebirthsList:GetChildren()) do
            if frame:IsA("Frame") and frame.Name ~= "BuyMoreButtons" then
                local template = frame:FindFirstChild("Template")

                if template then
                    local main = template:FindFirstChild("Main")
                    if main then
                        local amountLabel1 = main:FindFirstChild("RebirthsAmount")

                        if amountLabel1 then

                            local amountLabel = amountLabel1:FindFirstChild("Amount")
                            local amountText = amountLabel.Text
                            local amount = tonumber(amountText:match("%+(%d+%.?%d*)%s*[kKbBmMtT]?%s*Rebirths"))

                            if not amount then
                                local num, suffix = amountText:match("%+(%d+%.?%d*)([kKmMbBtT])%s*Rebirths")
                                if num then
                                    num = tonumber(num)
                                    suffix = suffix:lower()
                                    if suffix == "k" then amount = num * 1000
                                    elseif suffix == "m" then amount = num * 1000000
                                    elseif suffix == "b" then amount = num * 1000000000
                                    elseif suffix == "t" then amount = num * 1000000000000
                                    end
                                end
                            end

                            if amount then
                                table.insert(rebirths, {
                                    frame = frame,
                                    amount = amount,
                                    displayText = amountText:match("%+[%d%.]+[kKmMbBtT]?%s*Rebirths") or amountText,
                                    buttonIndex = tonumber(frame.Name) or #rebirths + 1
                                })
                            end
                        end
                    end
                end
            end
        end

        table.sort(rebirths, function(a, b)
            return a.amount < b.amount
        end)
    end)

    if not success then return {} end
    return rebirths
end

local function getRebirthOptions()
    local rebirths = getRebirths()
    local options = {}

    for _, rebirth in ipairs(rebirths) do
        table.insert(options, rebirth.displayText)
    end

    return options
end

local function getRebirthFromDisplayText(displayText)
    local rebirths = getRebirths()

    for _, rebirth in ipairs(rebirths) do
        if rebirth.displayText == displayText then
            return rebirth
        end
    end

    return nil
end

local function getRebirthIndex(amount)
    local rebirths = getRebirths()

    for index, rebirth in ipairs(rebirths) do
        if rebirth.amount == amount then
            return index
        end
    end

    return nil
end

local function getRebirthFromIndex(index)
    local rebirths = getRebirths()
    return rebirths[index]
end

local function getRebirthFromAmount(amount)
    local rebirths = getRebirths()

    for _, rebirth in ipairs(rebirths) do
        if rebirth.amount == amount then
            return rebirth
        end
    end

    return nil
end

main:Divider()


local Dropdown = main:Dropdown({
    Title = "Select rebirth amount:",
    Desc = "select rebirth amount",
    Values = getRebirthOptions(),
    Value = getRebirthOptions()[1] or "+1 Rebirths",
    Callback = function(option)
        local rebirthData = getRebirthFromDisplayText(option)
        if rebirthData then
            config.rebirthAmount = rebirthData.amount
            config.rebirthButtonIndex = rebirthData.buttonIndex
        end
    end
})


local dis = main:Button({
    Title = "Refresh rebirth amount dropdown",
    Desc = "refreshes the dropdown above if u unlockd new buttons",
    Locked = false,
    Callback = function()
        Dropdown:Refresh(getRebirthOptions())
        Dropdown:Select(getRebirthOptions()[1] or "+1 Rebirths")
    end
})

local Toggle = main:Toggle({
    Title = "Auto rebirth",
    Desc = "auto rebirths for you",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.rebirth = state
    end
})

-----------------------------------------
local other = Window:Tab({
    Title = "Other",
    Icon = "swords",
    Locked = false,
})
other:Divider()
local upgrades = {}

local backupUpgrades = {
    "RebirthButtons",
    "FreeAutoClicker",
    "ClickMultiplier",
    "HatchSpeed",
    "GoldenLuck",
    "CriticalChance",
    "AutoClickerSpeed"
}

local success = pcall(function()
    local upgradeModule = require(game.ReplicatedStorage.Game.UpgradeData)

    for upgradeName, _ in pairs(upgradeModule) do
        table.insert(upgrades, upgradeName)
    end
end)

if not success or #upgrades == 0 then
    upgrades = backupUpgrades
end
local Dropdown = other:Dropdown({
    Title = "Select upgrades:",
    Desc = "select upgradess for auto upgrade",
    Values = upgrades,
    Value = {"RebirthButtons"},
    Multi = true,
    Callback = function(option)
        config.upgrades = option
    end
})

local Toggle = other:Toggle({
    Title = "Auto upgrade selected upgrades",
    Desc = "Upgrades the things u selected in the dropdown above",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.upgrade = state
    end
})

other:Divider()

local Toggle = other:Toggle({
    Title = "Auto unlock Jumps",
    Desc = "Upgrades jumps for you",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.jump = state
    end
})
local Toggle = other:Toggle({
    Title = "Auto unlock rebirth buttons",
    Desc = "Upgrades rebirth buttons for you",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.button = state
    end
})
local Toggle = other:Toggle({
    Title = "Auto spin void wheel",
    Desc = "Automatically spins the void wheel for you bro what else can it possibly do",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.void = state
    end
})

other:Divider()

local Toggle = other:Toggle({
    Title = "Auto unlock islands",
    Desc = "Unlocks new islands for you",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.island = state
    end
})
local islands = {}

local success = pcall(function()
    for islandName, _ in pairs(v1) do table.insert(islands, islandName) end
end)

if not success or #islands == 0 then
    islands = {"Forest","Winter","Desert","Jungle","Heaven","Dojo","Volcano","Candy","Atlantis","Space","Kryo","Magma","Celestial"}
end
local xx = other:Dropdown({
    Title = "Teleport to island",
    Desc = "Teleports to chosen island",
    Values = islands,
    Value = "",
    Callback = function(option)
        local Network = require(game.ReplicatedStorage.Modules.Network)
        Network:InvokeServer("TeleportZone",option)

    end
})
other:Divider()
local chests = {}

local backupChests = {
    "FirstChest",
    "ClicksChest",
    "CryoChest"
}

local success = pcall(function()
    local chestModule = require(game.ReplicatedStorage.Game.Chests)

    for chestName, _ in pairs(chestModule) do
        table.insert(chests, chestName)
    end
end)

if not success or #chests == 0 then
    chests = backupChests
end
local Toggle = other:Toggle({
    Title = "Auto collect BIG chests",
    Desc = "auto collect big chests buddy",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.chest1 = state
    end
})
local Toggle = other:Toggle({
    Title = "Auto collect MINI chests",
    Desc = "auto collect MINI chests buddy(on island)",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.chest2 = state
    end
})
local Toggle = other:Toggle({
    Title = "Auto collect rank reward",
    Desc = "just read the title broskie",
    Type = "Toggle",
    Value = false,
    Callback = function(state)
        config.rank = state
    end
})
other:Divider()

local dis222 = other:Button({
    Title = "Am I Leaderboard banned: LOADING",
    Desc = "this updates every 5 seconds",
    Locked = false,
    Callback = function() end
})

task.spawn(function()
    local timeLeft = 5
    local lastText = "Am I Leaderboard banned: LOADING"
    local Network1 = require(game.ReplicatedStorage.Modules.Network)

    while task.wait(0.01) do
        if timeLeft <= 0 then
            local banned = Network1:InvokeServer("IsLeaderboardBanned")
            lastText = "Am I Leaderboard banned: " .. tostring(banned)
            dis222:SetTitle(lastText)
            timeLeft = 5
        else
            timeLeft = timeLeft - 0.01
            local displayText = lastText .. " (Updating in: " .. string.format("%.1f", timeLeft) .. "s)"
            dis222:SetTitle(displayText)
        end
    end
end)
-----------------------------------------

local misc = Window:Tab({
    Title = "Misc",
    Icon = "hammer",
    Locked = false,
})

---- MISC
misc:Divider()

local ws =25
local jp = 50
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

--------------- ggs

local started  = {
    click = false,
    quest = false,
    egg = false,
    equipBest = false,
    island = false,
    jump = false,
    button = false,
    void = false,
    upgrade = false,
    chest1 = false,
    chest2 = false,
    rank = false
}



restart=true
task.spawn(function()
    while wait() do
        if not restart then break end
        if config.click and not started.click then
            started.click = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.click do
                    Network:FireServer("Tap", true, false, true)
                    task.wait()
                end
                started.click = false
            end)
        end
        if config.quest and not started.quest then
            started.quest = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.quest do
                    for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.RightHud.Main.RightUI.Quests.List:GetChildren()) do
                        if not v then break end
                        if v:IsA("Frame") then
                            if v.Bar.Title.Text == "Completed" then
                                Network:InvokeServer("ClaimQuest", v.Name)
                            end
                        end
                        if not config.quest then break end
                    end
                    task.wait()
                end
                started.quest = false
            end)
        end
        if config.egg and not started.egg then
            started.egg = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.egg do
                    Network:InvokeServer("OpenEgg", config.chosenEgg, config.eggAmount , {})
                    task.wait()
                end
                started.egg = false
            end)
        end
        if config.rebirth and not started.rebirth then
            started.rebirth = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)

                while config.rebirth do
                    if config.rebirthButtonIndex then
                        Network:InvokeServer("Rebirth", config.rebirthButtonIndex)
                    end
                    task.wait()
                end
                started.rebirth = false
            end)
        end
        if config.equipBest and not started.equipBest then
            started.equipBest = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.equipBest do
                    Network:InvokeServer("EquipBest")
                    task.wait()
                end
                started.equipBest = false
            end)
        end
        if config.island and not started.island then
            started.island = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.island do
                    for _, islandName in ipairs(islands) do
                        Network:InvokeServer("BuyPortal", islandName)
                        task.wait()
                        if not config.island then break end
                    end
                    task.wait()
                end
                started.island = false
            end)
        end
        if config.jump and not started.jump then
            started.jump = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.jump do
                    Network:InvokeServer("UpgradeDoubleJump","Main")
                    task.wait()
                end
                started.jump = false
            end)
        end
        if config.button and not started.button then
            started.button = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.button do
                    Network:InvokeServer("UpgradeGemShop","RebirthButtons")
                    task.wait()
                end
                started.button = false
            end)
        end
        if config.void and not started.void then
            started.void = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.void do
                    Network:InvokeServer("SpinWheel","VoidSpinWheel")
                    task.wait()
                end
                started.void = false
            end)
        end
        if config.upgrade and not started.upgrade then
            started.upgrade = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.upgrade do
                    for i,v in ipairs(config.upgrades) do
                        Network:InvokeServer("UpgradeGemShop",v)
                    end
                    task.wait()
                end
                started.upgrade = false
            end)
        end
        if config.chest1 and not started.chest1 then
            started.chest1 = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.chest1 do
                    for i,v in ipairs(chests) do
                        Network:InvokeServer("ClaimChest",v.Name)
                    end
                    task.wait()
                end
                started.chest1 = false
            end)
        end
        if config.chest2 and not started.chest2 then
            started.chest2 = true
            task.spawn(function()
                local Network = require(game.ReplicatedStorage.Modules.Network)
                while config.chest2 do
                    for i,v in ipairs(workspace.Game.WorldChests:GetChildren()) do
                        if v and v:FindFirstChild("Hitbox") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Hitbox, 1)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Hitbox, 0)
                        end
                    end
                    task.wait()
                end
                started.chest2 = false
            end)
            if config.rank and not started.rank then
                started.rank = true
                task.spawn(function()
                    local Network = require(game.ReplicatedStorage.Modules.Network)
                    while config.rank do
                        Network:InvokeServer("ClaimRankReward")
                        task.wait()
                    end
                    started.rank = false
                end)
            end
        end
    end
end)

