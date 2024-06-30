local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService('Players')




local Window = Rayfield:CreateWindow({
    Name = "Break In (Story)",
    LoadingTitle = "ServerScriptAPI",
    LoadingSubtitle = "",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "BreakIn"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})


local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image
local ESPTab = Window:CreateTab('ESP', 4483362458)




local ESPEnabled = false
local OnAdded = nil



local IsUsingFillColor = false
local FillColor = Color3.new(1, 1, 1)
local OutlineColor = Color3.new(1, 0, 0)


local ESPtable = {}

local function AddESP()
    local AllPlayers = Players:GetPlayers()
    

    for i, v in AllPlayers do
        if i and v then
            local Character = v.Character or v.CharacterAdded:Wait() or nil


            if Character and not Character:FindFirstChild('ESP') then
                local ESP = Instance.new('Highlight', Character)
                ESP.Adornee = Character
                ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                ESP.FillColor = FillColor
                ESP.Name = 'ESP'
                

                if IsUsingFillColor == false then
                    ESP.FillTransparency = 1
                else
                    ESP.FillTransparency = 0
                end

                ESP.OutlineColor = OutlineColor


                ESPtable[v.Name] = ESP
            end
        end
    end
end


Players.PlayerRemoving:Connect(function(plr)
    local v = plr
    local i = 1

    if ESPtable[v.Name] then
        ESPtable[v.Name] = nil
    end
end)

Players.PlayerAdded:Connect(function(plr)
    local v = plr
    local i = 1


    if OnAdded == true then
        if i and v then
            local Character = v.Character or v.CharacterAdded:Wait() or nil


            if Character and not Character:FindFirstChild('ESP') then
                local ESP = Instance.new('Highlight', Character)
                ESP.Adornee = Character
                ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                ESP.FillColor = FillColor
                ESP.Name = 'ESP'
                

                if IsUsingFillColor == false then
                    ESP.FillTransparency = 1
                else
                    ESP.FillTransparency = 0
                end

                ESP.OutlineColor = OutlineColor

                ESPtable[v.Name] = ESP
            end
        end
    end 
end)




local ESPToggle = ESPTab:CreateToggle({
    Name = 'Player-ESP',
    CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        OnAdded = Value

        if Value == true then
            AddESP()
        else
            for i, v in ESPtable do
                ESPtable[i]:Destroy()
                ESPtable[i] = nil
            end
        end
   end,
})
