local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Doos Script Hub",
    Icon = 0,
    LoadingTitle = "hahah roblocks get rekd",
    LoadingSubtitle = "by doo",
    ShowText = "Rayfield",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },

    KeySystem = false
})

Rayfield:Notify({
    Title = "Script Loaded",
    Content = "Don't get banned! 😂",
    Duration = 6.5,
})

---------------------------------------------------------------------
-- AIMBOT TAB
---------------------------------------------------------------------
local AimbotTab = Window:CreateTab("Aimbot", nil)
AimbotTab:CreateSection("cool dude 😂")

local AimbotConnections = {}
local AimbotEnabled = false

AimbotTab:CreateButton({
    Name = "Toggle Aimbot (Hold RMB)",
    Callback = function()
        AimbotEnabled = not AimbotEnabled

        for _, conn in pairs(AimbotConnections) do
            if conn.Connected then conn:Disconnect() end
        end
        table.clear(AimbotConnections)

        if not AimbotEnabled then
            Rayfield:Notify({Title = "Aimbot", Content = "Disabled", Duration = 3})
            return
        end

        Rayfield:Notify({Title = "Aimbot", Content = "Enabled - Hold Right Click", Duration = 4})

        local Camera = workspace.CurrentCamera
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local LocalPlayer = Players.LocalPlayer
        local Holding = false

        _G.TeamCheck = false
        _G.AimPart = "Head"
        _G.Sensitivity = 0.2

        local function GetClosestPlayer()
            local closest = nil
            local maxDist = math.huge

            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        if not _G.TeamCheck or player.Team ~= LocalPlayer.Team then
                            local root = player.Character.HumanoidRootPart
                            local screenPos, onScreen = Camera:WorldToScreenPoint(root.Position)
                            if onScreen then
                                local mousePos = UserInputService:GetMouseLocation()
                                local dist = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                                if dist < maxDist then
                                    maxDist = dist
                                    closest = player
                                end
                            end
                        end
                    end
                end
            end
            return closest
        end

        table.insert(AimbotConnections, UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = true
            end
        end))

        table.insert(AimbotConnections, UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = false
            end
        end))

        table.insert(AimbotConnections, RunService.RenderStepped:Connect(function()
            if Holding and AimbotEnabled then
                local target = GetClosestPlayer()
                if target and target.Character and target.Character:FindFirstChild(_G.AimPart) then
                    TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        CFrame = CFrame.new(Camera.CFrame.Position, target.Character[_G.AimPart].Position)
                    }):Play()
                end
            end
        end))
    end,
})

---------------------------------------------------------------------
-- UTILITY TAB (Infinite Jump)
---------------------------------------------------------------------
local UtilityTab = Window:CreateTab("Utility", nil)
UtilityTab:CreateSection("Fun Stuff")

local InfJumpEnabled = false
local JumpConn

UtilityTab:CreateButton({
    Name = "Toggle Infinite Jump",
    Callback = function()
        InfJumpEnabled = not InfJumpEnabled

        if JumpConn and JumpConn.Connected then
            JumpConn:Disconnect()
        end

        if InfJumpEnabled then
            JumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
            Rayfield:Notify({Title = "Infinite Jump", Content = "Enabled", Duration = 3})
        else
            Rayfield:Notify({Title = "Infinite Jump", Content = "Disabled", Duration = 3})
        end
    end,
})

---------------------------------------------------------------------
-- ESP TAB (Exunys Advanced ESP)
---------------------------------------------------------------------
local ESPTab = Window:CreateTab("ESP", nil)
ESPTab:CreateSection("Visuals")

local ESPObject = nil

ESPTab:CreateButton({
    Name = "Toggle ESP",
    Callback = function()
        if not ESPObject then
            local success, result = pcall(function()
                return loadstring(game:HttpGet("https://raw.githubusercontent.com/doo0415/Rblxcode/refs/heads/main/ESP.lua"))()
            end)

            if success and result then
                ESPObject = result
                Rayfield:Notify({
                    Title = "ESP Loaded",
                    Content = "Advanced ESP Loaded Successfully!",
                    Duration = 5
                })
            else
                Rayfield:Notify({
                    Title = "ESP Failed",
                    Content = "Failed to load ESP: " .. tostring(result),
                    Duration = 8
                })
                return
            end
        end

        ESPObject.Settings.Enabled = not ESPObject.Settings.Enabled

        Rayfield:Notify({
            Title = "ESP",
            Content = ESPObject.Settings.Enabled and "Enabled" or "Disabled",
            Duration = 4
        })
    end,
})

---------------------------------------------------------------------
-- 67 TAB (Old Classic Touch Fling)
---------------------------------------------------------------------
local FlingTab = Window:CreateTab("67", nil)
FlingTab:CreateSection("flinger with the finger")

FlingTab:CreateButton({
    Name = "Old Touch Fling",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt"))()
        end)

        if success then
            Rayfield:Notify({
                Title = "Touch Fling",
                Content = "Classic touch fling loaded! Touch players to fling them.",
                Duration = 6
            })
        else
            Rayfield:Notify({
                Title = "Touch Fling Failed",
                Content = "Failed to load: " .. tostring(err),
                Duration = 8
            })
        end
    end,
})

---------------------------------------------------------------------
-- FLY TAB (Smooth Fly GUI V3 - No Choppy!)
---------------------------------------------------------------------
local FlyTab = Window:CreateTab("Fly", nil)
FlyTab:CreateSection("Fly gui v3 😂 (smooth - no choppy/backwards)")

FlyTab:CreateButton({
    Name = "Load Fly GUI V3",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
        end)

        if success then
            Rayfield:Notify({
                Title = "Fly GUI V3",
                Content = "Loaded! Open the GUI (usually appears on screen) - toggle fly, adjust speed slider for smoothness. Super smooth controls!",
                Duration = 8
            })
        else
            Rayfield:Notify({
                Title = "Fly Failed",
                Content = "Failed to load: " .. tostring(err),
                Duration = 8
            })
        end
    end,
})

---------------------------------------------------------------------
-- LOL TAB (Omni-Man Twerk Emote)
---------------------------------------------------------------------
local FunnyTab = Window:CreateTab("lol", nil)
FunnyTab:CreateSection("omniman")

FunnyTab:CreateButton({
    Name = "Omni-Man Twerk Emote",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-oniman-twerk-emote-from-invicble-49537"))()
        end)

        if success then
            Rayfield:Notify({
                Title = "Omni-Man Twerk",
                Content = "Loaded! Play the emote and twerk like Omni-Man 😂",
                Duration = 6
            })
        else
            Rayfield:Notify({
                Title = "Omni-Man Failed",
                Content = "Failed to load: " .. tostring(err),
                Duration = 8
            })
        end
    end,
})