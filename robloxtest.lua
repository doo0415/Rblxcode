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
-- AIMBOT TAB (Exunys Aimbot V3 - Using your exact loadstring)
---------------------------------------------------------------------
local AimbotTab = Window:CreateTab("Aimbot", nil)
AimbotTab:CreateSection("cool dude 😂")

local AimbotLoaded = false
local Aimbot = nil

AimbotTab:CreateButton({
    Name = "Toggle Aimbot (Exunys V3)",
    Callback = function()
        if not AimbotLoaded then
            local success, err = pcall(function()
                Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
                ExunysDeveloperAimbot.Load()
                getgenv().ExunysDeveloperAimbot = {
	DeveloperSettings = {
		UpdateMode = "RenderStepped",
		TeamCheckOption = "TeamColor",
		RainbowSpeed = 1 -- Bigger = Slower
	},

	Settings = {
		Enabled = true,

		TeamCheck = false,
		AliveCheck = true,
		WallCheck = false,

		OffsetToMoveDirection = false, -- Prediction
		OffsetIncrement = 15, -- Min: 1; Max: 30 -- Amplitude

		Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target / CFrame Sensitivity
		Sensitivity2 = 3.5, -- mousemoverel Sensitivity

		LockMode = 1, -- 1 = CFrame; 2 = mousemoverel
		LockPart = "Head", -- Body part to lock on

		TriggerKey = Enum.UserInputType.MouseButton2,
		Toggle = false
	},

	FOVSettings = {
		Enabled = true,
		Visible = true,

		Radius = 640, -- Field Of View
		NumSides = 60,

		Thickness = 1,
		Transparency = 1,
		Filled = false,

		RainbowColor = true,
		RainbowOutlineColor = false,
		Color = Color3.fromRGB(255, 255, 255),
		OutlineColor = Color3.fromRGB(0, 0, 0),
		LockedColor = Color3.fromRGB(255, 150, 150)
	}
}
            end)

            if success then
                AimbotLoaded = true
                Rayfield:Notify({
                    Title = "Aimbot",
                    Content = "Exunys Aimbot V3 Loaded! Use the trigger key (default: MouseButton2/RMB)",
                    Duration = 7
                })
            else
                Rayfield:Notify({
                    Title = "Aimbot Failed",
                    Content = "Failed to load: " .. tostring(err),
                    Duration = 8
                })
                return
            end
        else
            -- Toggle enabled state
            if Aimbot and Aimbot.Settings then
                Aimbot.Settings.Enabled = not Aimbot.Settings.Enabled
                Rayfield:Notify({
                    Title = "Aimbot",
                    Content = Aimbot.Settings.Enabled and "Enabled" or "Disabled",
                    Duration = 4
                })
            end
        end
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
                return loadstring(game:HttpGet("https://raw.githubusercontent.com/wa0101/Roblox-ESP/refs/heads/main/esp.lua",true))()

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
-- FLY TAB (Fly GUI V3 - Smooth)
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
                Content = "Loaded! GUI appears on screen - toggle fly & adjust speed for perfect smoothness!",
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
