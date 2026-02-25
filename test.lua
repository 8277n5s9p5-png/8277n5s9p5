
-- ETFB GUI - Cleaned & Fixed Version
-- Works with ETFB and other games

_G.Color = Color3.fromRGB(0, 255, 255)
_G.Toggle = Enum.KeyCode.RightControl

-- PlaceId for ETFB - Change to your desired game
local ETFB_PLACE_ID = 131623223084840 -- Change this to your ETFB PlaceId

if game.PlaceId == ETFB_PLACE_ID or game.PlaceId == 10321372166 then
    repeat wait() until game:IsLoaded()
    wait(1)
    
    if game:GetService("CoreGui"):FindFirstChild("AZRAHUB GUI") then
        game:GetService("CoreGui"):FindFirstChild("AZRAHUB GUI"):Destroy()
    end
    
    local DiscordLib = {}
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local HttpService = game:GetService("HttpService")
    local pfp
    local user
    local tag
    local userinfo = {}
    
    pcall(function()
        userinfo = HttpService:JSONDecode(readfile("discordlibinfo.txt"))
    end)
    
    pfp = userinfo["pfp"] or "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png"
    user = userinfo["user"] or game.Players.LocalPlayer.DisplayName
    tag = userinfo["tag"] or tostring(math.random(0001, 9999))
    
    local function MakeDraggable(topbarobject, object)
        local Dragging = nil
        local DragInput = nil
        local DragStart = nil
        local StartPosition = nil
    
        local function Update(input)
            local Delta = input.Position - DragStart
            local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
            local Tween = TweenService:Create(object, TweenInfo.new(0.15), {Position = pos})
            Tween:Play()
        end
    
        topbarobject.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)
    
        topbarobject.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                DragInput = input
            end
        end)
    
        UserInputService.InputChanged:Connect(function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end)
    end
    
    local Discord = Instance.new("ScreenGui")
    Discord.Name = "AZRAHUB GUI"
    Discord.Parent = game:GetService("CoreGui")
    Discord.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    function DiscordLib:Window(text, mainclr, cls)
        local PresetColor = mainclr or _G.Color or Color3.fromRGB(0, 255, 255)
        local CloseBind = cls or _G.Toggle or Enum.KeyCode.RightControl
        local currentservertoggled = ""
        local minimized = false
        local fs = false
        local settingsopened = false
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Parent = Discord
        MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        MainFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
        MainFrame.BackgroundTransparency = 1
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrame.Size = UDim2.new(0, 618, 0, 407)
        
        local uitoggled = false
        UserInputService.InputBegan:Connect(function(io, p)
            pcall(function()
                if io.KeyCode == CloseBind then
                    if uitoggled == false then
                        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        wait(.3)
                        Discord.Enabled = false
                        uitoggled = true
                    else
                        Discord.Enabled = true
                        MainFrame:TweenSize(UDim2.new(0, 618, 0, 407), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        uitoggled = false
                    end
                end
            end)
        end)
        
        local GlowFrame = Instance.new("Frame")
        GlowFrame.Name = "GlowFrame"
        GlowFrame.Parent = MainFrame
        GlowFrame.BackgroundTransparency = 1
        GlowFrame.Position = UDim2.new(0, 0.5, 0, 17.5)
        GlowFrame.Size = UDim2.new(0.625, 0, 0.763, 0)
        GlowFrame.BackgroundColor3 = PresetColor
        
        local GlowFrameCorner = Instance.new("UICorner")
        GlowFrameCorner.CornerRadius = UDim.new(0, 7)
        GlowFrameCorner.Name = "GlowFrameCorner"
        GlowFrameCorner.Parent = GlowFrame
        
        local Glow = Instance.new("ImageLabel")
        Glow.Name = "Glow"
        Glow.Parent = GlowFrame
        Glow.BackgroundColor3 = PresetColor
        Glow.BackgroundTransparency = 1
        Glow.BorderSizePixel = 0
        Glow.Size = UDim2.new(0.625, 0, 0.763, 0)
        Glow.ZIndex = 2
        Glow.Image = "rbxassetid://5028857084"
        Glow.ImageColor3 = PresetColor
        Glow.ScaleType = Enum.ScaleType.Slice
        
        local TopFrame = Instance.new("Frame")
        TopFrame.Name = "TopFrame"
        TopFrame.Parent = MainFrame
        TopFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
        TopFrame.BackgroundTransparency = 1.000
        TopFrame.BorderSizePixel = 0
        TopFrame.Size = UDim2.new(0, 681, 0, 65)
        
        local TopFrameHolder = Instance.new("Frame")
        TopFrameHolder.Name = "TopFrameHolder"
        TopFrameHolder.Parent = TopFrame
        TopFrameHolder.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
        TopFrameHolder.BackgroundTransparency = 1.000
        TopFrameHolder.BorderSizePixel = 0
        TopFrameHolder.Size = UDim2.new(0, 681, 0, 22)
        
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Parent = TopFrame
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0.0102790017, 0, 0, 0)
        Title.Size = UDim2.new(0, 192, 0, 23)
        Title.Font = Enum.Font.Gotham
        Title.Text = text
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 13.000
        Title.TextXAlignment = Enum.TextXAlignment.Left
        
        local ServersHolder = Instance.new("Folder")
        ServersHolder.Name = "ServersHolder"
        ServersHolder.Parent = TopFrameHolder
        
        local Userpad = Instance.new("Frame")
        Userpad.Name = "Userpad"
        Userpad.Parent = TopFrameHolder
        Userpad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Userpad.BackgroundTransparency = 1
        Userpad.BorderSizePixel = 0
        Userpad.Position = UDim2.new(0.0010243297, 0, 15.8807148, 0)
        Userpad.Size = UDim2.new(0, 179, 0, 43)
        
        local UserIcon = Instance.new("Frame")
        UserIcon.Name = "UserIcon"
        UserIcon.Parent = Userpad
        UserIcon.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
        UserIcon.BackgroundTransparency = 1
        UserIcon.BorderSizePixel = 0
        UserIcon.Position = UDim2.new(0.0340000018, 0, 0.123999998, 0)
        UserIcon.Size = UDim2.new(0, 32, 0, 32)
        
        local UserImage = Instance.new("ImageLabel")
        UserImage.Name = "UserImage"
        UserImage.Parent = UserIcon
        UserImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserImage.BackgroundTransparency = 1.000
        UserImage.Size = UDim2.new(0, 32, 0, 32)
        UserImage.Image = pfp
        
        local UserCircleImage = Instance.new("ImageLabel")
        UserCircleImage.Name = "UserCircleImage"
        UserCircleImage.Parent = UserImage
        UserCircleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserCircleImage.BackgroundTransparency = 1.000
        UserCircleImage.ImageColor3 = Color3.fromRGB(23, 23, 23)
        UserCircleImage.Size = UDim2.new(0, 32, 0, 32)
        UserCircleImage.Image = "rbxassetid://4031889928"
        UserCircleImage.ImageColor3 = Color3.fromRGB(27, 27, 27)
        
        local UserName = Instance.new("TextLabel")
        UserName.Name = "UserName"
        UserName.Parent = Userpad
        UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserName.BackgroundTransparency = 1.000
        UserName.BorderSizePixel = 0
        UserName.Position = UDim2.new(0.230000004, 0, 0.115999997, 0)
        UserName.Size = UDim2.new(0, 98, 0, 17)
        UserName.Font = Enum.Font.GothamSemibold
        UserName.TextColor3 = PresetColor
        UserName.TextSize = 13.000
        UserName.TextXAlignment = Enum.TextXAlignment.Left
        UserName.ClipsDescendants = true
        UserName.Text = user
        
        local UserTag = Instance.new("TextLabel")
        UserTag.Name = "UserTag"
        UserTag.Parent = Userpad
        UserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserTag.BackgroundTransparency = 1.000
        UserTag.BorderSizePixel = 0
        UserTag.Position = UDim2.new(0.230000004, 0, 0.455000013, 0)
        UserTag.Size = UDim2.new(0, 95, 0, 17)
        UserTag.Font = Enum.Font.Gotham
        UserTag.TextColor3 = PresetColor
        UserTag.TextSize = 13.000
        UserTag.TextTransparency = 0.300
        UserTag.TextXAlignment = Enum.TextXAlignment.Left
        UserTag.Text = "#" .. tag
        
        local ServersHoldFrame = Instance.new("Frame")
        ServersHoldFrame.Name = "ServersHoldFrame"
        ServersHoldFrame.Parent = MainFrame
        ServersHoldFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServersHoldFrame.BackgroundTransparency = 1.000
        ServersHoldFrame.BorderColor3 = PresetColor
        ServersHoldFrame.Size = UDim2.new(0, 71, 0, 396)
        
        local ServersHold = Instance.new("ScrollingFrame")
        ServersHold.Name = "ServersHold"
        ServersHold.Parent = ServersHoldFrame
        ServersHold.Active = true
        ServersHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServersHold.BackgroundTransparency = 1.000
        ServersHold.BorderSizePixel = 0
        ServersHold.Position = UDim2.new(-0.000359333731, 0, 0.0580808073, 0)
        ServersHold.Size = UDim2.new(0, 71, 0, 373)
        ServersHold.ScrollBarThickness = 1
        ServersHold.ScrollBarImageTransparency = 1
        ServersHold.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local ServersHoldLayout = Instance.new("UIListLayout")
        ServersHoldLayout.Name = "ServersHoldLayout"
        ServersHoldLayout.Parent = ServersHold
        ServersHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ServersHoldLayout.Padding = UDim.new(0, 7)
        
        local ServersHoldPadding = Instance.new("UIPadding")
        ServersHoldPadding.Name = "ServersHoldPadding"
        ServersHoldPadding.Parent = ServersHold
        
        MakeDraggable(TopFrame, MainFrame)
        ServersHoldPadding.PaddingLeft = UDim.new(0, 14)
        
        local ServerHold = {}
        
        function ServerHold:Server(text, img)
            local fc = false
            local currentchanneltoggled = ""
            local Server = Instance.new("TextButton")
            local ServerBtnCorner = Instance.new("UICorner")
            local ServerIco = Instance.new("ImageLabel")
            local ServerWhiteFrame = Instance.new("Frame")
            local ServerWhiteFrameCorner = Instance.new("UICorner")
            
            Server.Name = text .. "Server"
            Server.Parent = ServersHold
            Server.BackgroundColor3 = Color3.fromRGB(20,20,20)
            Server.Position = UDim2.new(0.125, 0, 0, 0)
            Server.Size = UDim2.new(0, 47, 0, 47)
            Server.AutoButtonColor = false
            Server.Font = Enum.Font.Gotham
            Server.Text = ""
            Server.BackgroundTransparency = 1
            Server.TextTransparency = 1
            Server.TextColor3 = Color3.fromRGB(233, 25, 42)
            Server.TextSize = 18.000
            
            ServerBtnCorner.CornerRadius = UDim.new(1, 0)
            ServerBtnCorner.Name = "ServerCorner"
            ServerBtnCorner.Parent = Server
            
            ServerWhiteFrame.Name = "ServerWhiteFrame"
            ServerWhiteFrame.Parent = Server
            ServerWhiteFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            ServerWhiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ServerWhiteFrame.BackgroundTransparency = 1
            ServerWhiteFrame.Position = UDim2.new(-0.347378343, 0, 0.502659559, 0)
            ServerWhiteFrame.Size = UDim2.new(0, 11, 0, 10)
            
            ServerWhiteFrameCorner.CornerRadius = UDim.new(1, 0)
            ServerWhiteFrameCorner.Name = "ServerWhiteFrameCorner"
            ServerWhiteFrameCorner.Parent = ServerWhiteFrame
            ServersHold.CanvasSize = UDim2.new(0, 0, 0, ServersHoldLayout.AbsoluteContentSize.Y)
            
            local ServerFrame = Instance.new("Frame")
            local ServerTitleFrame = Instance.new("Frame")
            local ServerTitle = Instance.new("TextLabel")
            local GlowFrame2 = Instance.new("Frame")
            local Glow2 = Instance.new("ImageLabel")
            local ServerContentFrame = Instance.new("Frame")
            local ServerCorner = Instance.new("UICorner")
            local ChannelTitleFrame = Instance.new("Frame")
            local ChannelTitleFrameCorner = Instance.new("UICorner")
            local Hashtag = Instance.new("TextLabel")
            local ChannelTitle = Instance.new("TextLabel")
            local ChannelContentFrame = Instance.new("Frame")
            local ChannelContentFrameCorner = Instance.new("UICorner")
            local GlowChannel = Instance.new("ImageLabel")
            local ServerChannelHolder = Instance.new("ScrollingFrame")
            local ServerChannelHolderLayout = Instance.new("UIListLayout")
            local ServerChannelHolderPadding = Instance.new("UIPadding")
            local ServerTitleButtom = Instance.new("TextLabel")
            local TimeGlobal = Instance.new("TextLabel")

            ServerFrame.Name = "ServerFrame"
            ServerFrame.Parent = ServersHolder
            ServerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ServerFrame.BorderSizePixel = 0
            ServerFrame.ClipsDescendants = true
            ServerFrame.Position = UDim2.new(0.005356875, 0, 0.32262593, 13)
            ServerFrame.Size = UDim2.new(0, 609, 0, 373)
            ServerFrame.Visible = false
            
            ServerTitleFrame.Name = "ServerTitleFrame"
            ServerTitleFrame.Parent = ServerFrame
            ServerTitleFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
            ServerTitleFrame.BackgroundTransparency = 1.000
            ServerTitleFrame.BorderSizePixel = 0
            ServerTitleFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
            ServerTitleFrame.Size = UDim2.new(0, 180, 0, 40)
            
            ServerTitle.Name = "ServerTitle"
            ServerTitle.Parent = ServerTitleFrame
            ServerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ServerTitle.BackgroundTransparency = 1.000
            ServerTitle.BorderSizePixel = 0
            ServerTitle.Position = UDim2.new(0.0851359761, 0, 0, 0)
            ServerTitle.Size = UDim2.new(0, 97, 0, 39)
            ServerTitle.Font = Enum.Font.GothamSemibold
            ServerTitle.Text = text
            ServerTitle.TextColor3 = PresetColor
            ServerTitle.TextSize = 15.000
            ServerTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            GlowFrame2.Name = "GlowFrame"
            GlowFrame2.Parent = ServerFrame
            GlowFrame2.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
            GlowFrame2.BackgroundTransparency = 1.000
            GlowFrame2.BorderSizePixel = 0
            GlowFrame2.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
            GlowFrame2.Size = UDim2.new(0, 609, 0, 40)
            
            Glow2.Name = "Glow"
            Glow2.Parent = GlowFrame2
            Glow2.BackgroundColor3 = PresetColor
            Glow2.BackgroundTransparency = 1.000
            Glow2.BorderSizePixel = 0
            Glow2.Position = UDim2.new(0, -15, 0, -15)
            Glow2.Size = UDim2.new(1, 30, 1, 30)
            Glow2.ZIndex = 0
            Glow2.Image = "rbxassetid://4996891970"
            Glow2.ImageColor3 = Color3.fromRGB(15, 15, 15)
            Glow2.ScaleType = Enum.ScaleType.Slice
            Glow2.SliceCenter = Rect.new(20, 20, 280, 280)
            
            ServerContentFrame.Name = "ServerContentFrame"
            ServerContentFrame.Parent = ServerFrame
            ServerContentFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
            ServerContentFrame.BackgroundTransparency = 1.000
            ServerContentFrame.BorderSizePixel = 0
            ServerContentFrame.Position = UDim2.new(-0.0010054264, 0, 0.106338218, 0)
            ServerContentFrame.Size = UDim2.new(0, 180, 0, 333)
            
            ServerCorner.CornerRadius = UDim.new(0, 7)
            ServerCorner.Name = "ServerCorner"
            ServerCorner.Parent = ServerFrame
            
            ChannelTitleFrame.Name = "ChannelTitleFrame"
            ChannelTitleFrame.Parent = ServerFrame
            ChannelTitleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ChannelTitleFrame.BorderSizePixel = 0
            ChannelTitleFrame.Position = UDim2.new(0.294561088, 0, -0.000900391256, 0)
            ChannelTitleFrame.Size = UDim2.new(0, 429, 0, 40)
            
            ChannelTitleFrameCorner.CornerRadius = UDim.new(0, 7)
            ChannelTitleFrameCorner.Name = "ChannelTitleFrameCorner"
            ChannelTitleFrameCorner.Parent = ChannelTitleFrame
            
            TimeGlobal.Name = "TimeGlobal"
            TimeGlobal.Parent = ChannelTitleFrame
            TimeGlobal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TimeGlobal.Position = UDim2.new(0.7062470865, 0, 0, 0)
            TimeGlobal.Size = UDim2.new(0, 95, 0, 39)
            TimeGlobal.BackgroundTransparency = 1
            TimeGlobal.ZIndex = 3
            TimeGlobal.Font = Enum.Font.GothamSemibold
            TimeGlobal.Text = "TIME | N/A"
            TimeGlobal.TextColor3 = PresetColor
            TimeGlobal.TextSize = 15.000
            TimeGlobal.TextXAlignment = Enum.TextXAlignment.Left
            
            spawn(function()
                while wait() do
                    TimeGlobal.Text = "TIME | "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S")
                end
            end)
            
            ChannelTitle.Name = "ChannelTitle"
            ChannelTitle.Parent = ChannelTitleFrame
            ChannelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChannelTitle.BackgroundTransparency = 1.000
            ChannelTitle.BorderSizePixel = 0
            ChannelTitle.Position = UDim2.new(0.0662470865, 0, 0, 0)
            ChannelTitle.Size = UDim2.new(0, 95, 0, 39)
            ChannelTitle.Font = Enum.Font.GothamSemibold
            ChannelTitle.Text = ""
            ChannelTitle.TextColor3 = PresetColor
            ChannelTitle.TextSize = 15.000
            ChannelTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ChannelContentFrame.Name = "ChannelContentFrame"
            ChannelContentFrame.Parent = ServerFrame
            ChannelContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ChannelContentFrame.BorderSizePixel = 0
            ChannelContentFrame.ClipsDescendants = true
            ChannelContentFrame.Position = UDim2.new(0.294561088, 0, 0.106338218, 0)
            ChannelContentFrame.Size = UDim2.new(0, 429, 0, 333)
            
            ChannelContentFrameCorner.CornerRadius = UDim.new(0, 7)
            ChannelContentFrameCorner.Name = "ChannelContentFrameCorner"
            ChannelContentFrameCorner.Parent = ChannelContentFrame
            
            GlowChannel.Name = "GlowChannel"
            GlowChannel.Parent = ChannelContentFrame
            GlowChannel.BackgroundColor3 = PresetColor
            GlowChannel.BackgroundTransparency = 1.000
            GlowChannel.BorderSizePixel = 0
            GlowChannel.Position = UDim2.new(0, -33, 0, -91)
            GlowChannel.Size = UDim2.new(1.06396091, 30, 0.228228226, 30)
            GlowChannel.ZIndex = 0
            GlowChannel.Image = "rbxassetid://4996891970"
            GlowChannel.ImageColor3 = Color3.fromRGB(15, 15, 15)
            GlowChannel.ScaleType = Enum.ScaleType.Slice
            GlowChannel.SliceCenter = Rect.new(20, 20, 280, 280)
            
            ServerChannelHolder.Name = "ServerChannelHolder"
            ServerChannelHolder.Parent = ServerContentFrame
            ServerChannelHolder.Active = true
            ServerChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ServerChannelHolder.BackgroundTransparency = 1.000
            ServerChannelHolder.BorderSizePixel = 0
            ServerChannelHolder.Position = UDim2.new(0.00535549596, 0, 0.0241984241, 0)
            ServerChannelHolder.Selectable = false
            ServerChannelHolder.Size = UDim2.new(0, 179, 0, 278)
            ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            ServerChannelHolder.ScrollBarThickness = 4
            ServerChannelHolder.ScrollBarImageColor3 = PresetColor
            ServerChannelHolder.ScrollBarImageTransparency = 1
            
            ServerChannelHolderLayout.Name = "ServerChannelHolderLayout"
            ServerChannelHolderLayout.Parent = ServerChannelHolder
            ServerChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ServerChannelHolderLayout.Padding = UDim.new(0, 4)
            
            ServerChannelHolderPadding.Name = "ServerChannelHolderPadding"
            ServerChannelHolderPadding.Parent = ServerChannelHolder
            ServerChannelHolderPadding.PaddingLeft = UDim.new(0, 9)
            
            ServerChannelHolder.MouseEnter:Connect(function()
                ServerChannelHolder.ScrollBarImageTransparency = 0
            end)
            
            ServerChannelHolder.MouseLeave:Connect(function()
                ServerChannelHolder.ScrollBarImageTransparency = 1
            end)
            
            -- Server click/hover effects
            Server.MouseEnter:Connect(function()
                if currentservertoggled ~= Server.Name then
                    TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                    TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {CornerRadius = UDim.new(0, 15)}):Play()
                    ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 27), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                end
            end)
            
            Server.MouseLeave:Connect(function()
                if currentservertoggled ~= Server.Name then
                    TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {BackgroundColor3 = Color3.fromRGB(47, 49, 54)}):Play()
                    TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {CornerRadius = UDim.new(1, 0)}):Play()
                    ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 10), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                end
            end)
            
            Server.MouseButton1Click:Connect(function()
                currentservertoggled = Server.Name
                for i, v in next, ServersHolder:GetChildren() do
                    if v.Name == "ServerFrame" then
                        v.Visible = false
                    end
                    ServerFrame.Visible = true
                end
                
                for i, v in next, ServersHold:GetChildren() do
                    if v.ClassName == "TextButton" then
                        TweenService:Create(v, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = Color3.fromRGB(47, 49, 54)}):Play()
                        TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                        TweenService:Create(v.ServerCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {CornerRadius = UDim.new(1, 0)}):Play()
                        TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {CornerRadius = UDim.new(0, 15)}):Play()
                        v.ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 10), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 46), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                    end
                end
            end)
            
            if img == "" then
                Server.Text = string.sub(text, 1, 1)
            else
                ServerIco.Image = img
            end
            
            -- Auto-select first server
            if fs == false then
                TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                    {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                    {CornerRadius = UDim.new(0, 15)}):Play()
                ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 46), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                ServerFrame.Visible = true
                Server.Name = text .. "Server"
                currentservertoggled = Server.Name
                fs = true
            end
            
            local ChannelHold = {}
            
            function ChannelHold:Channel(text, ico)
                local Icon = ico or ""
                local ChannelBtnOutline = Instance.new("Frame")
                local ChannelBtnOutlineCorner = Instance.new("UICorner")
                local ChannelBtn = Instance.new("TextButton")
                local ChannelBtnCorner = Instance.new("UICorner")
                local ChannelBtnTitle = Instance.new("TextLabel")
                
                ChannelBtnOutline.Name = text.."ChannelBtn"
                ChannelBtnOutline.Parent = ServerChannelHolder
                ChannelBtnOutline.Position = UDim2.new(0.24118948, 0, 0.578947365, 0)
                ChannelBtnOutline.Size = UDim2.new(0, 162, 0, 32)
                ChannelBtnOutline.BackgroundColor3 = PresetColor
                
                ChannelBtnOutlineCorner.CornerRadius = UDim.new(0, 6)
                ChannelBtnOutlineCorner.Name = "ChannelBtnOutlineCorner"
                ChannelBtnOutlineCorner.Parent = ChannelBtnOutline
                
                ChannelBtn.Name = text .. "ChannelBtn"
                ChannelBtn.Parent = ChannelBtnOutline
                ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                ChannelBtn.BorderSizePixel = 0
                ChannelBtn.Position = UDim2.new(0.002761, 0, 0.02761, 0)
                ChannelBtn.Size = UDim2.new(0, 160, 0, 30)
                ChannelBtn.AutoButtonColor = false
                ChannelBtn.Font = Enum.Font.SourceSans
                ChannelBtn.Text = ""
                ChannelBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                ChannelBtn.TextSize = 14.000
                
                ChannelBtnCorner.CornerRadius = UDim.new(0, 6)
                ChannelBtnCorner.Name = "ChannelBtnCorner"
                ChannelBtnCorner.Parent = ChannelBtn
                
                local ChannelIcon = Instance.new("ImageLabel")
                ChannelIcon.Name = "TabIcon"
                ChannelIcon.Parent = ChannelBtn
                ChannelIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelIcon.BackgroundTransparency = 1.000
                ChannelIcon.Position = UDim2.new(0.0234146333, 0, 0.12, 0)
                ChannelIcon.Size = UDim2.new(0, 20, 0, 20)
                ChannelIcon.Image = Icon
                ChannelIcon.ImageTransparency = 0
                
                ChannelBtnTitle.Name = "ChannelBtnTitle"
                ChannelBtnTitle.Parent = ChannelBtn
                ChannelBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelBtnTitle.BackgroundTransparency = 1.000
                ChannelBtnTitle.BorderSizePixel = 0
                ChannelBtnTitle.Position = UDim2.new(0.163747092, 0, -0.166666672, 0)
                ChannelBtnTitle.Size = UDim2.new(0, 95, 0, 39)
                ChannelBtnTitle.Font = Enum.Font.Gotham
                ChannelBtnTitle.Text = text
                ChannelBtnTitle.TextColor3 = PresetColor
                ChannelBtnTitle.TextSize = 14.000
                ChannelBtnTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ServerChannelHolderLayout.AbsoluteContentSize.Y)
                
                local ChannelHolder = Instance.new("ScrollingFrame")
                local ChannelHolderLayout = Instance.new("UIListLayout")
                
                ChannelHolder.Name = "ChannelHolder"
                ChannelHolder.Parent = ChannelContentFrame
                ChannelHolder.Active = true
                ChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelHolder.BackgroundTransparency = 1.000
                ChannelHolder.BorderSizePixel = 0
                ChannelHolder.Position = UDim2.new(0.0360843192, 0, 0.0241984241, 0)
                ChannelHolder.Size = UDim2.new(0, 412, 0, 314)
                ChannelHolder.ScrollBarThickness = 6
                ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                ChannelHolder.ScrollBarImageTransparency = 0
                ChannelHolder.ScrollBarImageColor3 = PresetColor
                ChannelHolder.Visible = false
                ChannelHolder.ClipsDescendants = false
                
                ChannelHolderLayout.Name = "ChannelHolderLayout"
                ChannelHolderLayout.Parent = ChannelHolder
                ChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ChannelHolderLayout.Padding = UDim.new(0, 6)

                ChannelBtn.MouseEnter:Connect(function()
                    if currentchanneltoggled ~= ChannelBtn.Name then
                        ChannelBtn.BackgroundColor3 = PresetColor
                        ChannelBtnTitle.TextColor3 = Color3.fromRGB(27, 27, 27)
                    end
                end)
                
                ChannelBtn.MouseLeave:Connect(function()
                    if currentchanneltoggled ~= ChannelBtn.Name then
                        ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                        ChannelBtnTitle.TextColor3 = PresetColor
                    end
                end)
                
                ChannelBtn.MouseButton1Click:Connect(function()
                    for i, v in next, ChannelContentFrame:GetChildren() do
                        if v.Name == "ChannelHolder" then
                            v.Visible = false
                        end
                        ChannelHolder.Visible = true
                    end
                    
                    for i, v in next, ServerChannelHolder:GetChildren() do
                        if v.ClassName == "TextButton" then
                            v.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            v.ChannelBtnTitle.TextColor3 = PresetColor
                        end
                    end
                    
                    ChannelTitle.Text = text
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                    ChannelBtnTitle.TextColor3 = PresetColor
                    currentchanneltoggled = ChannelBtn.Name
                end)
                
                -- Auto-select first channel
                if fc == false then
                    fc = true
                    ChannelTitle.Text = text
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                    ChannelBtnTitle.TextColor3 = PresetColor
                    currentchanneltoggled = ChannelBtn.Name
                    ChannelHolder.Visible = true
                end
                
                local ChannelContent = {}
                
                function ChannelContent:Button(text, callback)
                    local Button = Instance.new("TextButton")
                    local ButtonCorner = Instance.new("UICorner")
                    
                    Button.Name = "Button"
                    Button.Parent = ChannelHolder
                    Button.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Button.Size = UDim2.new(0, 401, 0, 30)
                    Button.AutoButtonColor = false
                    Button.Font = Enum.Font.Gotham
                    Button.TextColor3 = PresetColor
                    Button.TextSize = 14.000
                    Button.Text = text
                    
                    ButtonCorner.CornerRadius = UDim.new(0, 4)
                    ButtonCorner.Name = "ButtonCorner"
                    ButtonCorner.Parent = Button
                    
                    Button.MouseEnter:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = PresetColor, TextColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                    end)
                    
                    Button.MouseButton1Click:Connect(function()
                        pcall(callback)
                        Button.TextSize = 0
                        TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {TextSize = 14}):Play()
                    end)
                    
                    Button.MouseLeave:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = Color3.fromRGB(23, 23, 23), TextColor3 = PresetColor}):Play()
                    end)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                function ChannelContent:Toggle(text, default, callback)
                    local toggled = false
                    local Toggle = Instance.new("TextButton")
                    local ToggleTitle = Instance.new("TextLabel")
                    local ToggleFrame = Instance.new("Frame")
                    local ToggleFrameCorner = Instance.new("UICorner")
                    local ToggleFrameCircle = Instance.new("Frame")
                    local ToggleFrameCircleCorner = Instance.new("UICorner")
                    local ToggleFrameOutline = Instance.new("Frame")
                    local ToggleFrameOutlineCorner = Instance.new("UICorner")
                    local Icon = Instance.new("ImageLabel")
                    
                    Toggle.Name = "Toggle"
                    Toggle.Parent = ChannelHolder
                    Toggle.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Toggle.BorderSizePixel = 0
                    Toggle.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                    Toggle.Size = UDim2.new(0, 401, 0, 30)
                    Toggle.AutoButtonColor = false
                    Toggle.Font = Enum.Font.Gotham
                    Toggle.Text = ""
                    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Toggle.TextSize = 14.000
                    
                    ToggleTitle.Name = "ToggleTitle"
                    ToggleTitle.Parent = Toggle
                    ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleTitle.BackgroundTransparency = 1.000
                    ToggleTitle.Position = UDim2.new(0, 5, 0, 0)
                    ToggleTitle.Size = UDim2.new(0, 200, 0, 30)
                    ToggleTitle.Font = Enum.Font.Gotham
                    ToggleTitle.Text = text
                    ToggleTitle.TextColor3 = PresetColor
                    ToggleTitle.TextSize = 14.000
                    ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ToggleFrameOutline.Name = "ToggleFrameOutline"
                    ToggleFrameOutline.Parent = Toggle
                    ToggleFrameOutline.BackgroundColor3 = PresetColor
                    ToggleFrameOutline.Position = UDim2.new(0.900481343, -5, 0.16300018, 0)
                    ToggleFrameOutline.Size = UDim2.new(0, 41, 0, 22)
                    
                    ToggleFrameOutlineCorner.CornerRadius = UDim.new(1, 8)
                    ToggleFrameOutlineCorner.Name = "ToggleFrameOutlineCorner"
                    ToggleFrameOutlineCorner.Parent = ToggleFrameOutline
                    
                    ToggleFrame.Name = "ToggleFrame"
                    ToggleFrame.Parent = ToggleFrameOutline
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
                    ToggleFrame.Size = UDim2.new(0, 39, 0, 20)
                    ToggleFrame.Position = UDim2.new(0, 1, 0.03761, 0)
                    
                    ToggleFrameCorner.CornerRadius = UDim.new(1, 8)
                    ToggleFrameCorner.Name = "ToggleFrameCorner"
                    ToggleFrameCorner.Parent = ToggleFrame
                    
                    ToggleFrameCircle.Name = "ToggleFrameCircle"
                    ToggleFrameCircle.Parent = ToggleFrame
                    ToggleFrameCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleFrameCircle.Position = UDim2.new(0.234999999, -5, 0.133000001, 0)
                    ToggleFrameCircle.Size = UDim2.new(0, 15, 0, 15)
                    
                    ToggleFrameCircleCorner.CornerRadius = UDim.new(1, 0)
                    ToggleFrameCircleCorner.Name = "ToggleFrameCircleCorner"
                    ToggleFrameCircleCorner.Parent = ToggleFrameCircle
                    
                    Icon.Name = "Icon"
                    Icon.Parent = ToggleFrameCircle
                    Icon.AnchorPoint = Vector2.new(0.5, 0.5)
                    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Icon.BackgroundTransparency = 1.000
                    Icon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    Icon.Position = UDim2.new(0, 8, 0, 8)
                    Icon.Size = UDim2.new(0, 13, 0, 13)
                    Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                    Icon.ImageColor3 = Color3.fromRGB(31, 31, 31)
                    
                    if default == true then
                        toggled = true
                        TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {ImageColor3 = PresetColor}):Play()
                        TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = PresetColor}):Play()
                        ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), 
                            Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {ImageTransparency = 1}):Play()
                        Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                        wait(.1)
                        TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {ImageTransparency = 0}):Play()
                        pcall(callback, toggled)
                    end
                    
                    Toggle.MouseButton1Click:Connect(function()
                        if toggled == false then
                            TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageColor3 = PresetColor}):Play()
                            TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {BackgroundColor3 = PresetColor}):Play()
                            ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), 
                                Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 1}):Play()
                            Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                            wait(.1)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 0}):Play()
                        else
                            TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageColor3 = Color3.fromRGB(31, 31, 31)}):Play()
                            TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {BackgroundColor3 = Color3.fromRGB(31, 31, 31)}):Play()
                            ToggleFrameCircle:TweenPosition(UDim2.new(0.234999999, -5, 0.133000001, 0), 
                                Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 1}):Play()
                            Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                            wait(.1)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 0}):Play()
                        end
                        toggled = not toggled
                        pcall(callback, toggled)
                    end)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                function ChannelContent:Slider(text, min, max, start, callback)
                    local SliderFunc = {}
                    local dragging = false
                    local Slider = Instance.new("TextButton")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderFrame = Instance.new("Frame")
                    local SliderFrameCorner = Instance.new("UICorner")
                    local CurrentValueFrame = Instance.new("Frame")
                    local CurrentValueFrameCorner = Instance.new("UICorner")
                    local Zip = Instance.new("Frame")
                    local ZipCorner = Instance.new("UICorner")
                    local ValueBubble = Instance.new("Frame")
                    local ValueBubbleCorner = Instance.new("UICorner")
                    local SquareBubble = Instance.new("Frame")
                    local GlowBubble = Instance.new("ImageLabel")
                    local ValueLabel = Instance.new("TextLabel")
                    
                    Slider.Name = "Slider"
                    Slider.Parent = ChannelHolder
                    Slider.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Slider.BorderSizePixel = 0
                    Slider.Position = UDim2.new(0, 0, 0.216560602, 0)
                    Slider.Size = UDim2.new(0, 401, 0, 38)
                    Slider.AutoButtonColor = false
                    Slider.Font = Enum.Font.Gotham
                    Slider.Text = ""
                    Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Slider.TextSize = 14.000
                    
                    SliderTitle.Name = "SliderTitle"
                    SliderTitle.Parent = Slider
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.Position = UDim2.new(0, 5, 0, -4)
                    SliderTitle.Size = UDim2.new(0, 200, 0, 27)
                    SliderTitle.Font = Enum.Font.Gotham
                    SliderTitle.Text = text
                    SliderTitle.TextColor3 = PresetColor
                    SliderTitle.TextSize = 14.000
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    SliderFrame.Name = "SliderFrame"
                    SliderFrame.Parent = Slider
                    SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(79, 84, 92)
                    SliderFrame.Position = UDim2.new(0.497999996, 0, 0.757000029, 0)
                    SliderFrame.Size = UDim2.new(0, 385, 0, 8)
                    
                    SliderFrameCorner.Name = "SliderFrameCorner"
                    SliderFrameCorner.Parent = SliderFrame
                    
                    CurrentValueFrame.Name = "CurrentValueFrame"
                    CurrentValueFrame.Parent = SliderFrame
                    CurrentValueFrame.BackgroundColor3 = PresetColor
                    CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 8)
                    
                    CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
                    CurrentValueFrameCorner.Parent = CurrentValueFrame
                    
                    Zip.Name = "Zip"
                    Zip.Parent = SliderFrame
                    Zip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Zip.Position = UDim2.new((start or 0) / max, -6, -0.644999981, 0)
                    Zip.Size = UDim2.new(0, 10, 0, 18)
                    ZipCorner.CornerRadius = UDim.new(0, 3)
                    ZipCorner.Name = "ZipCorner"
                    ZipCorner.Parent = Zip
                    
                    ValueBubble.Name = "ValueBubble"
                    ValueBubble.Parent = Zip
                    ValueBubble.AnchorPoint = Vector2.new(0.5, 0.5)
                    ValueBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                    ValueBubble.Position = UDim2.new(0.5, 0, -1.00800002, 0)
                    ValueBubble.Size = UDim2.new(0, 36, 0, 21)
                    ValueBubble.Visible = false
                    
                    Zip.MouseEnter:Connect(function()
                        if dragging == false then
                            ValueBubble.Visible = true
                        end
                    end)
                    
                    Zip.MouseLeave:Connect(function()
                        if dragging == false then
                            ValueBubble.Visible = false
                        end
                    end)
                    
                    ValueBubbleCorner.CornerRadius = UDim.new(0, 3)
                    ValueBubbleCorner.Name = "ValueBubbleCorner"
                    ValueBubbleCorner.Parent = ValueBubble
                    
                    SquareBubble.Name = "SquareBubble"
                    SquareBubble.Parent = ValueBubble
                    SquareBubble.AnchorPoint = Vector2.new(0.5, 0.5)
                    SquareBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                    SquareBubble.BorderSizePixel = 0
                    SquareBubble.Position = UDim2.new(0.493000001, 0, 0.637999971, 0)
                    SquareBubble.Rotation = 45.000
                    SquareBubble.Size = UDim2.new(0, 19, 0, 19)
                    
                    GlowBubble.Name = "GlowBubble"
                    GlowBubble.Parent = ValueBubble
                    GlowBubble.BackgroundColor3 = PresetColor
                    GlowBubble.BackgroundTransparency = 1.000
                    GlowBubble.BorderSizePixel = 0
                    GlowBubble.Position = UDim2.new(0, -15, 0, -15)
                    GlowBubble.Size = UDim2.new(1, 30, 1, 30)
                    GlowBubble.ZIndex = 0
                    GlowBubble.Image = "rbxassetid://4996891970"
                    GlowBubble.ImageColor3 = Color3.fromRGB(15, 15, 15)
                    GlowBubble.ScaleType = Enum.ScaleType.Slice
                    GlowBubble.SliceCenter = Rect.new(20, 20, 280, 280)
                    
                    ValueLabel.Name = "ValueLabel"
                    ValueLabel.Parent = ValueBubble
                    ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ValueLabel.BackgroundTransparency = 1.000
                    ValueLabel.Size = UDim2.new(0, 36, 0, 21)
                    ValueLabel.Font = Enum.Font.Gotham
                    ValueLabel.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
                    ValueLabel.TextColor3 = PresetColor
                    ValueLabel.TextSize = 10.000

                    local function move(input)
                        local pos = UDim2.new(math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1), -6, -0.644999981, 0)
                        local pos1 = UDim2.new(math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1), 0, 0, 8)
                        CurrentValueFrame.Size = pos1
                        Zip.Position = pos
                        local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                        ValueLabel.Text = tostring(value)
                        pcall(callback, value)
                    end
                    
                    Zip.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            ValueBubble.Visible = true
                        end
                    end)
                    
                    Zip.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                            ValueBubble.Visible = false
                        end
                    end)
                    
                    game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            move(input)
                        end
                    end)
                    
                    function SliderFunc:Change(tochange)
                        CurrentValueFrame.Size = UDim2.new((tochange or 0) / max, 0, 0, 8)
                        Zip.Position = UDim2.new((tochange or 0) / max, -6, -0.644999981, 0)
                        ValueLabel.Text = tostring(tochange and math.floor((tochange / max) * (max - min) + min) or 0)
                        pcall(callback, tochange)
                    end
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    return SliderFunc
                end
                
                function ChannelContent:Line()
                    local Line1 = Instance.new("Frame")
                    local Line2 = Instance.new("Frame")
                    
                    Line1.Name = "Line1"
                    Line1.Parent = ChannelHolder
                    Line1.BackgroundColor3 = PresetColor
                    Line1.BackgroundTransparency = 1.000
                    Line1.Position = UDim2.new(0, 0, 0.350318581, 0)
                    Line1.Size = UDim2.new(0, 100, 0, 8)
                    
                    Line2.Name = "Line2"
                    Line2.Parent = Line1
                    Line2.BackgroundColor3 = PresetColor
                    Line2.BorderSizePixel = 0
                    Line2.Position = UDim2.new(0, 0, 0, 4)
                    Line2.Size = UDim2.new(0, 401, 0, 1)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                function ChannelContent:Dropdown(text, list, callback)
                    local DropFunc = {}
                    local itemcount = 0
                    local framesize = 0
                    local DropTog = false
                    local Dropdown = Instance.new("Frame")
                    local DropdownTitle = Instance.new("TextLabel")
                    local DropdownFrameOutline = Instance.new("Frame")
                    local DropdownFrameOutlineCorner = Instance.new("UICorner")
                    local DropdownFrame = Instance.new("Frame")
                    local DropdownFrameCorner = Instance.new("UICorner")
                    local CurrentSelectedText = Instance.new("TextLabel")
                    local ArrowImg = Instance.new("ImageLabel")
                    local DropdownFrameBtn = Instance.new("TextButton")
                    
                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = ChannelHolder
                    Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Dropdown.BackgroundTransparency = 1.000
                    Dropdown.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
                    Dropdown.Size = UDim2.new(0, 403, 0, 60)
                    
                    DropdownTitle.Name = "DropdownTitle"
                    DropdownTitle.Parent = Dropdown
                    DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownTitle.BackgroundTransparency = 1.000
                    DropdownTitle.Position = UDim2.new(0, 5, 0, 0)
                    DropdownTitle.Size = UDim2.new(0, 200, 0, 29)
                    DropdownTitle.Font = Enum.Font.Gotham
                    DropdownTitle.Text = ""
                    DropdownTitle.TextColor3 = PresetColor
                    DropdownTitle.TextSize = 14.000
                    DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    DropdownFrameOutline.Name = "DropdownFrameOutline"
                    DropdownFrameOutline.Parent = DropdownTitle
                    DropdownFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
                    DropdownFrameOutline.BackgroundColor3 = PresetColor
                    DropdownFrameOutline.Position = UDim2.new(0.988442957, 0, 1.0197437, 0)
                    DropdownFrameOutline.Size = UDim2.new(0, 396, 0, 36)
                    
                    DropdownFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameOutlineCorner.Name = "DropdownFrameOutlineCorner"
                    DropdownFrameOutlineCorner.Parent = DropdownFrameOutline
                    
                    DropdownFrame.Name = "DropdownFrame"
                    DropdownFrame.Parent = DropdownTitle
                    DropdownFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    DropdownFrame.ClipsDescendants = true
                    DropdownFrame.Position = UDim2.new(0.00899999978, 0, 0.46638527, 0)
                    DropdownFrame.Selectable = true
                    DropdownFrame.Size = UDim2.new(0, 392, 0, 32)
                    
                    DropdownFrameCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameCorner.Name = "DropdownFrameCorner"
                    DropdownFrameCorner.Parent = DropdownFrame
                    
                    CurrentSelectedText.Name = "CurrentSelectedText"
                    CurrentSelectedText.Parent = DropdownFrame
                    CurrentSelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    CurrentSelectedText.BackgroundTransparency = 1.000
                    CurrentSelectedText.Position = UDim2.new(0.0178571437, 0, 0, 0)
                    CurrentSelectedText.Size = UDim2.new(0, 193, 0, 32)
                    CurrentSelectedText.Font = Enum.Font.Gotham
                    CurrentSelectedText.Text = text
                    CurrentSelectedText.TextTransparency = 0.250
                    CurrentSelectedText.TextColor3 = PresetColor
                    CurrentSelectedText.TextSize = 14.000
                    CurrentSelectedText.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ArrowImg.Name = "ArrowImg"
                    ArrowImg.Parent = CurrentSelectedText
                    ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ArrowImg.BackgroundTransparency = 1.000
                    ArrowImg.Position = UDim2.new(1.84974098, 0, 0.167428851, 0)
                    ArrowImg.Size = UDim2.new(0, 22, 0, 22)
                    ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818372"
                    ArrowImg.ImageColor3 = PresetColor
                    
                    DropdownFrameBtn.Name = "DropdownFrameBtn"
                    DropdownFrameBtn.Parent = DropdownFrame
                    DropdownFrameBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownFrameBtn.BackgroundTransparency = 1.000
                    DropdownFrameBtn.Size = UDim2.new(0, 392, 0, 32)
                    DropdownFrameBtn.Font = Enum.Font.SourceSans
                    DropdownFrameBtn.Text = ""
                    DropdownFrameBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                    DropdownFrameBtn.TextSize = 14.000
                    
                    local DropdownFrameMainOutline = Instance.new("Frame")
                    local DropdownFrameMainOutlineCorner = Instance.new("UICorner")
                    local DropdownFrameMain = Instance.new("Frame")
                    local DropdownFrameMainCorner = Instance.new("UICorner")
                    local DropItemHolderLabel = Instance.new("TextLabel")
                    local DropItemHolder = Instance.new("ScrollingFrame")
                    local DropItemHolderLayout = Instance.new("UIListLayout")
                    
                    DropdownFrameMainOutline.Name = "DropdownFrameMainOutline"
                    DropdownFrameMainOutline.Parent = DropdownTitle
                    DropdownFrameMainOutline.BackgroundColor3 = PresetColor
                    DropdownFrameMainOutline.Position = UDim2.new(-0.00155700743, 0, 1.66983342, 0)
                    DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 81)
                    DropdownFrameMainOutline.Visible = false
                    
                    DropdownFrameMainOutlineCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameMainOutlineCorner.Name = "DropdownFrameMainOutlineCorner"
                    DropdownFrameMainOutlineCorner.Parent = DropdownFrameMainOutline
                    
                    DropdownFrameMain.Name = "DropdownFrameMain"
                    DropdownFrameMain.Parent = DropdownTitle
                    DropdownFrameMain.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    DropdownFrameMain.ClipsDescendants = true
                    DropdownFrameMain.Position = UDim2.new(0.00799999978, 0, 1.7468965, 0)
                    DropdownFrameMain.Selectable = true
                    DropdownFrameMain.Size = UDim2.new(0, 392, 0, 77)
                    DropdownFrameMain.Visible = false
                    
                    DropdownFrameMainCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameMainCorner.Name = "DropdownFrameMainCorner"
                    DropdownFrameMainCorner.Parent = DropdownFrameMain
                    
                    DropItemHolderLabel.Name = "ItemHolderLabel"
                    DropItemHolderLabel.Parent = DropdownFrameMain
                    DropItemHolderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropItemHolderLabel.BackgroundTransparency = 1.000
                    DropItemHolderLabel.Position = UDim2.new(0.0178571437, 0, 0, 0)
                    DropItemHolderLabel.Size = UDim2.new(0, 193, 0, 13)
                    DropItemHolderLabel.Font = Enum.Font.Gotham
                    DropItemHolderLabel.Text = ""
                    DropItemHolderLabel.TextColor3 = PresetColor
                    DropItemHolderLabel.TextSize = 14.000
                    DropItemHolderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    DropItemHolder.Name = "ItemHolder"
                    DropItemHolder.Parent = DropItemHolderLabel
                    DropItemHolder.Active = true
                    DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropItemHolder.BackgroundTransparency = 1.000
                    DropItemHolder.Position = UDim2.new(0, 0, 0.215384638, 0)
                    DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
                    DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                    DropItemHolder.ScrollBarThickness = 6
                    DropItemHolder.BorderSizePixel = 0
                    DropItemHolder.ScrollBarImageColor3 = PresetColor
                    
                    DropItemHolderLayout.Name = "ItemHolderLayout"
                    DropItemHolderLayout.Parent = DropItemHolder
                    DropItemHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropItemHolderLayout.Padding = UDim.new(0, 0)
                    
                    DropdownFrameBtn.MouseButton1Click:Connect(function()
                        if DropTog == false then
                            DropdownFrameMain.Visible = true
                            DropdownFrameMainOutline.Visible = true
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60 + DropdownFrameMainOutline.AbsoluteSize.Y)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                        else
                            DropdownFrameMain.Visible = false
                            DropdownFrameMainOutline.Visible = false
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                            wait(.2)
                        end
                        DropTog = not DropTog
                    end)
                    
                    for i, v in next, list do
                        itemcount = itemcount + 1
                        if itemcount == 1 then
                            framesize = 29
                        elseif itemcount == 2 then
                            framesize = 58
                        elseif itemcount >= 3 then
                            framesize = 87
                        end
                        
                        local Item = Instance.new("TextButton")
                        local ItemCorner = Instance.new("UICorner")
                        local ItemText = Instance.new("TextLabel")
                        
                        Item.Name = "Item"
                        Item.Parent = DropItemHolder
                        Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        Item.Size = UDim2.new(0, 379, 0, 29)
                        Item.AutoButtonColor = false
                        Item.Font = Enum.Font.SourceSans
                        Item.Text = ""
                        Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                        Item.TextSize = 14.000
                        Item.BackgroundTransparency = 1
                        
                        ItemCorner.CornerRadius = UDim.new(0, 4)
                        ItemCorner.Name = "ItemCorner"
                        ItemCorner.Parent = Item
                        
                        ItemText.Name = "ItemText"
                        ItemText.Parent = Item
                        ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        ItemText.BackgroundTransparency = 1.000
                        ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
                        ItemText.Size = UDim2.new(0, 192, 0, 29)
                        ItemText.Font = Enum.Font.Gotham
                        ItemText.TextColor3 = PresetColor
                        ItemText.TextSize = 14.000
                        ItemText.TextXAlignment = Enum.TextXAlignment.Left
                        ItemText.Text = v
                        
                        Item.MouseEnter:Connect(function()
                            ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.BackgroundTransparency = 0
                        end)
                        
                        Item.MouseLeave:Connect(function()
                            ItemText.TextColor3 = PresetColor
                            Item.BackgroundTransparency = 1
                        end)
                        
                        Item.MouseButton1Click:Connect(function()
                            CurrentSelectedText.Text = v
                            CurrentSelectedText.TextTransparency = 0.250
                            pcall(callback, v)
                            DropdownFrameMain.Visible = false
                            DropdownFrameMainOutline.Visible = false
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                            wait(.2)
                            DropTog = not DropTog
                        end)
                        
                        DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropItemHolderLayout.AbsoluteContentSize.Y)
                        DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
                        DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
                        DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
                    end
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    
                    function DropFunc:Clear()
                        for i, v in next, DropItemHolder:GetChildren() do
                            if v.Name == "Item" then
                                v:Destroy()
                            end
                        end
                        CurrentSelectedText.Text = text
                        CurrentSelectedText.TextTransparency = 0.250
                        itemcount = 0
                        framesize = 0
                        DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
                        DropdownFrameMain.Size = UDim2.new(0, 392, 0, 0)
                        DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 0)
                        Dropdown.Size = UDim2.new(0, 403, 0, 60)
                        DropdownFrameMain.Visible = false
                        DropdownFrameMainOutline.Visible = false
                        ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    end
                    
                    -- CONTINUATION (Part 5)

                    function DropFunc:Add(textadd)
                        itemcount = itemcount + 1
                        if itemcount == 1 then
                            framesize = 29
                        elseif itemcount == 2 then
                            framesize = 58
                        elseif itemcount >= 3 then
                            framesize = 87
                        end
                        
                        local Item = Instance.new("TextButton")
                        local ItemCorner = Instance.new("UICorner")
                        local ItemText = Instance.new("TextLabel")
                        
                        Item.Name = "Item"
                        Item.Parent = DropItemHolder
                        Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        Item.Size = UDim2.new(0, 379, 0, 29)
                        Item.AutoButtonColor = false
                        Item.Font = Enum.Font.SourceSans
                        Item.Text = ""
                        Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                        Item.TextSize = 14.000
                        Item.BackgroundTransparency = 1
                        
                        ItemCorner.CornerRadius = UDim.new(0, 4)
                        ItemCorner.Name = "ItemCorner"
                        ItemCorner.Parent = Item
                        
                        ItemText.Name = "ItemText"
                        ItemText.Parent = Item
                        ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        ItemText.BackgroundTransparency = 1.000
                        ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
                        ItemText.Size = UDim2.new(0, 192, 0, 29)
                        ItemText.Font = Enum.Font.Gotham
                        ItemText.TextColor3 = PresetColor
                        ItemText.TextSize = 14.000
                        ItemText.TextXAlignment = Enum.TextXAlignment.Left
                        ItemText.Text = textadd
                        
                        Item.MouseEnter:Connect(function()
                            ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.BackgroundTransparency = 0
                        end)
                        
                        Item.MouseLeave:Connect(function()
                            ItemText.TextColor3 = PresetColor
                            Item.BackgroundTransparency = 1
                        end)
                        
                        Item.MouseButton1Click:Connect(function()
                            CurrentSelectedText.Text = textadd
                            CurrentSelectedText.TextTransparency = 0.250
                            pcall(callback, textadd)
                            DropdownFrameMain.Visible = false
                            DropdownFrameMainOutline.Visible = false
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                            wait(.2)
                            DropTog = not DropTog
                        end)
                        
                        DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropItemHolderLayout.AbsoluteContentSize.Y)
                        DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
                        DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
                        DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
                    end
                    
                    return DropFunc
                end

    function ChannelContent:MultiDropdown(text, list, callback)
    local multiSelect = {}
    local selectedItems = {}
    local DropTog = false
    local itemcount = 0
    
    local MultiDropdown = Instance.new("Frame")
    local MultiDropdownTitle = Instance.new("TextLabel")
    local MultiDropdownFrameOutline = Instance.new("Frame")
    local MultiDropdownFrameOutlineCorner = Instance.new("UICorner")
    local MultiDropdownFrame = Instance.new("Frame")
    local MultiDropdownFrameCorner = Instance.new("UICorner")
    local CurrentSelectedText = Instance.new("TextLabel")
    local ArrowImg = Instance.new("ImageLabel")
    local MultiDropdownFrameBtn = Instance.new("TextButton")
    
    MultiDropdown.Name = "MultiDropdown"
    MultiDropdown.Parent = ChannelHolder
    MultiDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropdown.BackgroundTransparency = 1.000
    MultiDropdown.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
    MultiDropdown.Size = UDim2.new(0, 403, 0, 60)
    
    MultiDropdownTitle.Name = "MultiDropdownTitle"
    MultiDropdownTitle.Parent = MultiDropdown
    MultiDropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropdownTitle.BackgroundTransparency = 1.000
    MultiDropdownTitle.Position = UDim2.new(0, 5, 0, 0)
    MultiDropdownTitle.Size = UDim2.new(0, 200, 0, 29)
    MultiDropdownTitle.Font = Enum.Font.Gotham
    MultiDropdownTitle.Text = ""
    MultiDropdownTitle.TextColor3 = PresetColor
    MultiDropdownTitle.TextSize = 14.000
    MultiDropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    MultiDropdownFrameOutline.Name = "MultiDropdownFrameOutline"
    MultiDropdownFrameOutline.Parent = MultiDropdownTitle
    MultiDropdownFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
    MultiDropdownFrameOutline.BackgroundColor3 = PresetColor
    MultiDropdownFrameOutline.Position = UDim2.new(0.988442957, 0, 1.0197437, 0)
    MultiDropdownFrameOutline.Size = UDim2.new(0, 396, 0, 36)
    
    MultiDropdownFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameOutlineCorner.Name = "MultiDropdownFrameOutlineCorner"
    MultiDropdownFrameOutlineCorner.Parent = MultiDropdownFrameOutline
    
    MultiDropdownFrame.Name = "MultiDropdownFrame"
    MultiDropdownFrame.Parent = MultiDropdownTitle
    MultiDropdownFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    MultiDropdownFrame.ClipsDescendants = true
    MultiDropdownFrame.Position = UDim2.new(0.00899999978, 0, 0.46638527, 0)
    MultiDropdownFrame.Selectable = true
    MultiDropdownFrame.Size = UDim2.new(0, 392, 0, 32)
    
    MultiDropdownFrameCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameCorner.Name = "MultiDropdownFrameCorner"
    MultiDropdownFrameCorner.Parent = MultiDropdownFrame
    
    CurrentSelectedText.Name = "CurrentSelectedText"
    CurrentSelectedText.Parent = MultiDropdownFrame
    CurrentSelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CurrentSelectedText.BackgroundTransparency = 1.000
    CurrentSelectedText.Position = UDim2.new(0.0178571437, 0, 0, 0)
    CurrentSelectedText.Size = UDim2.new(0, 300, 0, 32)
    CurrentSelectedText.Font = Enum.Font.Gotham
    CurrentSelectedText.Text = text .. " (0 selected)"
    CurrentSelectedText.TextTransparency = 0.250
    CurrentSelectedText.TextColor3 = PresetColor
    CurrentSelectedText.TextSize = 14.000
    CurrentSelectedText.TextXAlignment = Enum.TextXAlignment.Left
    
    ArrowImg.Name = "ArrowImg"
    ArrowImg.Parent = CurrentSelectedText
    ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ArrowImg.BackgroundTransparency = 1.000
    ArrowImg.Position = UDim2.new(1.1, 0, 0.167, 0)
    ArrowImg.Size = UDim2.new(0, 22, 0, 22)
    ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818372"
    ArrowImg.ImageColor3 = PresetColor
    
    MultiDropdownFrameBtn.Name = "MultiDropdownFrameBtn"
    MultiDropdownFrameBtn.Parent = MultiDropdownFrame
    MultiDropdownFrameBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropdownFrameBtn.BackgroundTransparency = 1.000
    MultiDropdownFrameBtn.Size = UDim2.new(0, 392, 0, 32)
    MultiDropdownFrameBtn.Font = Enum.Font.SourceSans
    MultiDropdownFrameBtn.Text = ""
    MultiDropdownFrameBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MultiDropdownFrameBtn.TextSize = 14.000
    
    local MultiDropdownFrameMainOutline = Instance.new("Frame")
    local MultiDropdownFrameMainOutlineCorner = Instance.new("UICorner")
    local MultiDropdownFrameMain = Instance.new("Frame")
    local MultiDropdownFrameMainCorner = Instance.new("UICorner")
    local MultiDropItemHolderLabel = Instance.new("TextLabel")
    local MultiDropItemHolder = Instance.new("ScrollingFrame")
    local MultiDropItemHolderLayout = Instance.new("UIListLayout")
    
    MultiDropdownFrameMainOutline.Name = "MultiDropdownFrameMainOutline"
    MultiDropdownFrameMainOutline.Parent = MultiDropdownTitle
    MultiDropdownFrameMainOutline.BackgroundColor3 = PresetColor
    MultiDropdownFrameMainOutline.Position = UDim2.new(-0.00155700743, 0, 1.66983342, 0)
    MultiDropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 0)
    MultiDropdownFrameMainOutline.Visible = false
    
    MultiDropdownFrameMainOutlineCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameMainOutlineCorner.Name = "MultiDropdownFrameMainOutlineCorner"
    MultiDropdownFrameMainOutlineCorner.Parent = MultiDropdownFrameMainOutline
    
    MultiDropdownFrameMain.Name = "MultiDropdownFrameMain"
    MultiDropdownFrameMain.Parent = MultiDropdownTitle
    MultiDropdownFrameMain.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    MultiDropdownFrameMain.ClipsDescendants = true
    MultiDropdownFrameMain.Position = UDim2.new(0.00799999978, 0, 1.7468965, 0)
    MultiDropdownFrameMain.Selectable = true
    MultiDropdownFrameMain.Size = UDim2.new(0, 392, 0, 0)
    MultiDropdownFrameMain.Visible = false
    
    MultiDropdownFrameMainCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameMainCorner.Name = "MultiDropdownFrameMainCorner"
    MultiDropdownFrameMainCorner.Parent = MultiDropdownFrameMain
    
    MultiDropItemHolderLabel.Name = "ItemHolderLabel"
    MultiDropItemHolderLabel.Parent = MultiDropdownFrameMain
    MultiDropItemHolderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropItemHolderLabel.BackgroundTransparency = 1.000
    MultiDropItemHolderLabel.Position = UDim2.new(0.0178571437, 0, 0, 0)
    MultiDropItemHolderLabel.Size = UDim2.new(0, 193, 0, 13)
    MultiDropItemHolderLabel.Font = Enum.Font.Gotham
    MultiDropItemHolderLabel.Text = ""
    MultiDropItemHolderLabel.TextColor3 = PresetColor
    MultiDropItemHolderLabel.TextSize = 14.000
    MultiDropItemHolderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    MultiDropItemHolder.Name = "ItemHolder"
    MultiDropItemHolder.Parent = MultiDropItemHolderLabel
    MultiDropItemHolder.Active = true
    MultiDropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropItemHolder.BackgroundTransparency = 1.000
    MultiDropItemHolder.Position = UDim2.new(0, 0, 0.215384638, 0)
    MultiDropItemHolder.Size = UDim2.new(0, 385, 0, 0)
    MultiDropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    MultiDropItemHolder.ScrollBarThickness = 6
    MultiDropItemHolder.BorderSizePixel = 0
    MultiDropItemHolder.ScrollBarImageColor3 = PresetColor
    
    MultiDropItemHolderLayout.Name = "ItemHolderLayout"
    MultiDropItemHolderLayout.Parent = MultiDropItemHolder
    MultiDropItemHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    MultiDropItemHolderLayout.Padding = UDim.new(0, 0)
    
    local function updateSelectedText()
        local count = 0
        local textDisplay = ""
        for item, isSelected in pairs(selectedItems) do
            if isSelected then
                count = count + 1
                if textDisplay == "" then
                    textDisplay = item
                elseif count <= 2 then
                    textDisplay = textDisplay .. ", " .. item
                end
            end
        end
        
        if count == 0 then
            CurrentSelectedText.Text = text .. " (0 selected)"
            CurrentSelectedText.TextTransparency = 0.250
        elseif count == 1 then
            CurrentSelectedText.Text = textDisplay .. " (1 selected)"
            CurrentSelectedText.TextTransparency = 0
        elseif count <= 3 then
            CurrentSelectedText.Text = textDisplay .. " (+" .. (count - 2) .. ") (" .. count .. " selected)"
            CurrentSelectedText.TextTransparency = 0
        else
            CurrentSelectedText.Text = textDisplay .. " (+" .. (count - 2) .. ") (" .. count .. " selected)"
            CurrentSelectedText.TextTransparency = 0
        end
        
        local selectedTable = {}
        for item, isSelected in pairs(selectedItems) do
            if isSelected then
                table.insert(selectedTable, item)
            end
        end
        pcall(callback, selectedTable)
    end
    
    MultiDropdownFrameBtn.MouseButton1Click:Connect(function()
        if DropTog == false then
            MultiDropdownFrameMain.Visible = true
            MultiDropdownFrameMainOutline.Visible = true
            TweenService:Create(MultiDropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {Size = UDim2.new(0, 403, 0, 60 + MultiDropdownFrameMainOutline.AbsoluteSize.Y)}):Play()
            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
        else
            MultiDropdownFrameMain.Visible = false
            MultiDropdownFrameMainOutline.Visible = false
            TweenService:Create(MultiDropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {Size = UDim2.new(0, 403, 0, 60)}):Play()
            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
            wait(.2)
        end
        DropTog = not DropTog
    end)
    
    for i, v in next, list do
        itemcount = itemcount + 1
        local framesize = 29 + (itemcount - 1) * 29
        
        local Item = Instance.new("TextButton")
        local ItemCorner = Instance.new("UICorner")
        local ItemText = Instance.new("TextLabel")
        local Checkbox = Instance.new("Frame")  -- Checkbox on RIGHT side
        local CheckboxCorner = Instance.new("UICorner")
        local Checkmark = Instance.new("ImageLabel")
        
        Item.Name = "Item"
        Item.Parent = MultiDropItemHolder
        Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
        Item.Size = UDim2.new(0, 379, 0, 29)
        Item.AutoButtonColor = false
        Item.Font = Enum.Font.SourceSans
        Item.Text = ""
        Item.TextColor3 = Color3.fromRGB(0, 0, 0)
        Item.TextSize = 14.000
        Item.BackgroundTransparency = 1
        
        ItemCorner.CornerRadius = UDim.new(0, 4)
        ItemCorner.Name = "ItemCorner"
        ItemCorner.Parent = Item
        
        -- Item text on LEFT
        ItemText.Name = "ItemText"
        ItemText.Parent = Item
        ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
        ItemText.BackgroundTransparency = 1.000
        ItemText.Position = UDim2.new(0.02, 0, 0, 0)
        ItemText.Size = UDim2.new(0, 270, 0, 29)
        ItemText.Font = Enum.Font.Gotham
        ItemText.TextColor3 = PresetColor
        ItemText.TextSize = 14.000
        ItemText.TextXAlignment = Enum.TextXAlignment.Left
        ItemText.Text = v
        
        -- Checkbox on RIGHT side
        Checkbox.Name = "Checkbox"
        Checkbox.Parent = Item
        Checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Checkbox.BorderSizePixel = 0
        Checkbox.Position = UDim2.new(0.78, 0, 0.17, 0)
        Checkbox.Size = UDim2.new(0, 20, 0, 20)
        
        CheckboxCorner.CornerRadius = UDim.new(0, 4)
        CheckboxCorner.Name = "CheckboxCorner"
        CheckboxCorner.Parent = Checkbox
        
        -- Checkmark inside checkbox (hidden by default)
        Checkmark.Name = "Checkmark"
        Checkmark.Parent = Checkbox
        Checkmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Checkmark.BackgroundTransparency = 1.000
        Checkmark.Position = UDim2.new(0.15, 0, 0.15, 0)
        Checkmark.Size = UDim2.new(0, 14, 0, 14)
        Checkmark.Image = "http://www.roblox.com/asset/?id=6023426926" -- Checkmark
        Checkmark.ImageTransparency = 1
        Checkmark.ImageColor3 = PresetColor
        
        selectedItems[v] = false
        
        Item.MouseEnter:Connect(function()
            ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
            Item.BackgroundTransparency = 0
        end)
        
        Item.MouseLeave:Connect(function()
            ItemText.TextColor3 = PresetColor
            Item.BackgroundTransparency = 1
        end)
        
        Item.MouseButton1Click:Connect(function()
            selectedItems[v] = not selectedItems[v]
            
            if selectedItems[v] then
                -- Selected - show checkmark, change box color
                Checkbox.BackgroundColor3 = PresetColor
                Checkmark.ImageTransparency = 0
            else
                -- Deselected - hide checkmark, reset box color
                Checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Checkmark.ImageTransparency = 1
            end
            
            updateSelectedText()
        end)
        
        MultiDropItemHolder.CanvasSize = UDim2.new(0, 0, 0, MultiDropItemHolderLayout.AbsoluteContentSize.Y)
        MultiDropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
        MultiDropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
        MultiDropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
    end
    
    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
    
    function multiSelect:GetSelectedItems()
        local selectedTable = {}
        for item, isSelected in pairs(selectedItems) do
            if isSelected then
                table.insert(selectedTable, item)
            end
        end
        return selectedTable
    end
    
    function multiSelect:Clear()
        for item, _ in pairs(selectedItems) do
            selectedItems[item] = false
        end
        for i, v in next, MultiDropItemHolder:GetChildren() do
            if v.Name == "Item" then
                v.Checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                v.Checkbox.Checkmark.ImageTransparency = 1
            end
        end
        updateSelectedText()
    end
    
    return multiSelect
end
                
                function ChannelContent:Label(text)
                    local Label = Instance.new("TextButton")
                    local LabelTitle = Instance.new("TextLabel")
                    local labelfunc = {}
                    
                    Label.Name = "Label"
                    Label.Parent = ChannelHolder
                    Label.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    Label.BorderSizePixel = 0
                    Label.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                    Label.Size = UDim2.new(0, 401, 0, 30)
                    Label.AutoButtonColor = false
                    Label.Font = Enum.Font.Gotham
                    Label.Text = ""
                    Label.TextColor3 = PresetColor
                    Label.TextSize = 14.000
                    
                    LabelTitle.Name = "LabelTitle"
                    LabelTitle.Parent = Label
                    LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    LabelTitle.BackgroundTransparency = 1.000
                    LabelTitle.Position = UDim2.new(0, 5, 0, 0)
                    LabelTitle.Size = UDim2.new(0, 200, 0, 30)
                    LabelTitle.Font = Enum.Font.Gotham
                    LabelTitle.Text = text
                    LabelTitle.TextColor3 = PresetColor
                    LabelTitle.TextSize = 14.000
                    LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    
                    function labelfunc:Refresh(tochange)
                        Label.Text = tochange
                    end
                    
                    return labelfunc
                end
                
                function ChannelContent:Bind(text, presetbind, callback)
                    local Key = presetbind.Name
                    local Keybind = Instance.new("TextButton")
                    local KeybindTitle = Instance.new("TextLabel")
                    local KeybindText = Instance.new("TextLabel")
                    
                    Keybind.Name = "Keybind"
                    Keybind.Parent = ChannelHolder
                    Keybind.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Keybind.BorderSizePixel = 0
                    Keybind.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                    Keybind.Size = UDim2.new(0, 401, 0, 30)
                    Keybind.AutoButtonColor = false
                    Keybind.Font = Enum.Font.Gotham
                    Keybind.Text = ""
                    Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Keybind.TextSize = 14.000
                    
                    KeybindTitle.Name = "KeybindTitle"
                    KeybindTitle.Parent = Keybind
                    KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    KeybindTitle.BackgroundTransparency = 1.000
                    KeybindTitle.Position = UDim2.new(0, 5, 0, 0)
                    KeybindTitle.Size = UDim2.new(0, 200, 0, 30)
                    KeybindTitle.Font = Enum.Font.Gotham
                    KeybindTitle.Text = text
                    KeybindTitle.TextColor3 = PresetColor
                    KeybindTitle.TextSize = 14.000
                    KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    KeybindText.Name = "KeybindText"
                    KeybindText.Parent = Keybind
                    KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    KeybindText.BackgroundTransparency = 1.000
                    KeybindText.Position = UDim2.new(0, 316, 0, 0)
                    KeybindText.Size = UDim2.new(0, 85, 0, 30)
                    KeybindText.Font = Enum.Font.Gotham
                    KeybindText.Text = presetbind.Name
                    KeybindText.TextColor3 = PresetColor
                    KeybindText.TextSize = 14.000
                    KeybindText.TextXAlignment = Enum.TextXAlignment.Right
                    
                    Keybind.MouseButton1Click:Connect(function()
                        KeybindText.Text = "..."
                        local inputwait = game:GetService("UserInputService").InputBegan:wait()
                        if inputwait.KeyCode.Name ~= "Unknown" then
                            KeybindText.Text = inputwait.KeyCode.Name
                            Key = inputwait.KeyCode.Name
                        end
                    end)
                    
                    game:GetService("UserInputService").InputBegan:connect(function(current, pressed)
                        if not pressed then
                            if current.KeyCode.Name == Key then
                                pcall(callback)
                            end
                        end
                    end)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                return ChannelContent
            end
            
            return ChannelHold
        end
        
        return ServerHold
    end
    
    -- MAIN GUI SETUP - Add your tabs here
    local win = DiscordLib:Window("Escape Tsunami for Brainrots", _G.Color, _G.Toggle)
    
    local serv = win:Server("Ashleng on Top", "")
    
    local main = serv:Channel("Main", "http://www.roblox.com/asset/?id=7040391851")
    
    Time = main:Label("Server Time")
    function UpdateTime()
		local GameTime = math.floor(workspace.DistributedGameTime+0.5)
		local Hour = math.floor(GameTime/(60^2))%24
		local Minute = math.floor(GameTime/(60^1))%60
		local Second = math.floor(GameTime/(60^0))%60
		Time:Refresh("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
	end
	
	spawn(function()
		while true do
			UpdateTime()
			wait()
		end
	end)

    Client = main:Label("Client")
    function UpdateClient()
		local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		local Fps = workspace:GetRealPhysicsFPS()
		Client:Refresh("Fps : "..Fps.." Ping : "..Ping)
	end
	
	spawn(function()
		while true do wait(.1)
			UpdateClient()
		end
	end)
              -- MAIN AUTOMATED MACHINE
    main:Line()
    main:Label(""):Refresh("Automated Machines")
    -- Brainrots + Sizes + Machines
local brainrotList = {
    "Draculini Meowlini",
    "Cupitron Consoletron",
    "Freezeti Cobretti",
    "Galactio Fantasma",
    "Din Din Vaultero",
    "Strawberry Elephant",
    "Grappellino D'oro",
    "Martino Gravitino",
    "Burgerini Bearini",
    "Bulbito Bandito Traktorito"
}

local brainrotsSizes = {
    "Colossal",
    "Big",
    "Normal",
    "Mini",
    "Baby",
    "Lil Baby"
}

local machineList = {
    "Doom",
    "ATM",
    "Arcade",
    "Blackhole",
    "Valentines",
    "Default"
}

-- Dropdowns
local brainrotDropdown = main:MultiDropdown("Select Brainrots", brainrotList, function(selectedItems)
    _G.SelectedBrainrots = selectedItems
end)

local sizesList = main:MultiDropdown("Select Sizes", brainrotsSizes, function(selectedItems)
    _G.SelectedSizes = selectedItems
end)

local machinesLists = main:MultiDropdown("Select Machines", machineList, function(selectedItems)
    _G.SelectedMachines = selectedItems
end)

main:Button("Clear Dropdown", function()
    brainrotDropdown:Clear()
    sizesList:Clear()
    machinesLists:Clear()
end)

-- ==========================
-- Helper Functions
-- ==========================

local function getMachine()
    local sm = game:GetService("Workspace"):FindFirstChild("GameObjects")
    if not sm then return nil, nil end
    sm = sm:FindFirstChild("PlaceSpecific")
    if not sm then return nil, nil end
    sm = sm:FindFirstChild("root")
    if not sm then return nil, nil end
    sm = sm:FindFirstChild("SpawnMachines")
    if not sm then return nil, nil end

    local machines = {
        ["Blackhole"] = "BLACKHOLE",
        ["ATM"] = "ATM",
        ["Arcade"] = "ARCADE",
        ["Valentines"] = "VALENTINES",
        ["Doom"] = "DOOM",
        ["Default"] = "DEFAULT"
    }

    for name, kind in pairs(machines) do
        if sm:FindFirstChild(name) then
            return sm[name], kind
        end
    end

    return nil, nil
end

local function machineHasPet(machine)
    if not machine then return false end
    local main = machine:FindFirstChild("Main")
    if not main then return false end
    local billboard = main:FindFirstChild("Billboard")
    if not billboard then return false end
    local gui = billboard:FindFirstChild("BillboardGui")
    if not gui then return false end
    local frame = gui:FindFirstChild("Frame")
    if not frame then return false end
    local brainrots = frame:FindFirstChild("Brainrots")
    if not brainrots then return false end
    return brainrots:FindFirstChild("Line_1") ~= nil
end

local function getHeldPetName()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local debris = game:GetService("Workspace"):FindFirstChild("Debris")
    if not debris then return nil end

    local closestPet = nil
    local closestDist = math.huge

    for _, obj in ipairs(debris:GetChildren()) do
        if obj:IsA("BasePart") and obj.Name == "BillboardTemplate" then
            local gui = obj:FindFirstChildWhichIsA("SurfaceGui") or obj:FindFirstChildWhichIsA("BillboardGui")
            if gui then
                local nameLabel = gui:FindFirstChild("BrainrotName", true)
                if nameLabel then
                    local distance = (hrp.Position - obj.Position).Magnitude
                    if distance < closestDist then
                        closestDist = distance
                        closestPet = nameLabel.Text
                    end
                end
            end
        end
    end

    return closestPet
end

-- ==========================
-- Machine Positions
-- ==========================

local MACHINE_POSITIONS = {
    ["ATM"] = Vector3.new(909.410645, 3.532636, 32.877258),
    ["BLACKHOLE"] = Vector3.new(894.619934, 3.614657, 6.723338),
    ["ARCADE"] = Vector3.new(901.143799, 3.372710, -15.076845),
    ["VALENTINES"] = Vector3.new(900.504883, 3.595896, -28.093462),
    ["DOOM"] = Vector3.new(899.169189453125, 3.669783353805542, -45.32243728637695),
    ["DEFAULT"] = Vector3.new(139.49147033691406, 3.4074761867523193, 134.97198486328125)
}

-- Build full valid pet list from dropdowns
local function getSelectedPetsList()
    local selectedBrainrots = _G.SelectedBrainrots or {}
    local selectedSizes = _G.SelectedSizes or {}

    if #selectedBrainrots == 0 then
        selectedBrainrots = brainrotList
    end
    if #selectedSizes == 0 then
        selectedSizes = brainrotsSizes
    end

    local validPets = {}
    for _, brainrot in ipairs(selectedBrainrots) do
        for _, size in ipairs(selectedSizes) do
            if size == "Normal" then
                table.insert(validPets, brainrot)
            else
                table.insert(validPets, size .. " " .. brainrot)
            end
        end
    end
    return validPets
end

-- Check if player holds a valid pet
local function isSelectedPetEquipped()
    local validPets = getSelectedPetsList()
    local held = getHeldPetName()
    if not held then return false end
    for _, pet in ipairs(validPets) do
        if held:lower() == pet:lower() then
            return true
        end
    end
    return false
end

-- ==========================
-- Auto Equip Function
-- ==========================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local delayBetweenEquip = 0.35

local function autoEquipPet()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local backpack = player:WaitForChild("Backpack")

	-- ✅ MAKE A STATIC TOOL LIST
	local tools = {}

	for _, tool in ipairs(backpack:GetChildren()) do
		if tool:IsA("Tool") then
			table.insert(tools, tool)
		end
	end

	-- ✅ LOOP OVER STATIC COPY
	for _, tool in ipairs(tools) do
		if tool and tool.Parent == backpack then
			humanoid:EquipTool(tool)

			task.wait(delayBetweenEquip)

			local heldPet = getHeldPetName()
			if heldPet then

				-- check your valid pets here
				for _, valid in ipairs(getSelectedPetsList()) do
					if heldPet:lower() == valid:lower() then
						return
					end
				end
			end
		end
	end
end

-- ==========================
-- Spawn Remote
-- ==========================

local SpawnMachineRemote = game:GetService("ReplicatedStorage")
    :WaitForChild("Shared"):WaitForChild("Remotes")
    :WaitForChild("Networking"):WaitForChild("RF/SpawnMachineAction")

local lastDeposit = 0

-- ==========================
-- Auto Machine Loop
-- ==========================

local function startAutoMachineLoop()
    task.spawn(function()
        while _G.AutoMachine do
            task.wait(0.15)
            local machine, kind = getMachine()
            if not machine then continue end

            local player = game:GetService("Players").LocalPlayer
            local char = player.Character
            if not char then continue end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end

            local selectedMachines = _G.SelectedMachines or {}
            if #selectedMachines == 0 then
                selectedMachines = {"ATM", "Arcade", "Blackhole", "Valentines", "Doom", "Default"}
            end

            local machineAllowed = false
            for _, m in ipairs(selectedMachines) do
                if string.find(string.upper(kind), string.upper(m)) then
                    machineAllowed = true
                    break
                end
            end
            if not machineAllowed then continue end

            -- Teleport
            if isSelectedPetEquipped() then
                local pos = MACHINE_POSITIONS[kind]
                if pos then
                    hrp.CFrame = CFrame.new(pos)
                end
            end

            -- Deposit
            if isSelectedPetEquipped() then
                if not machineHasPet(machine) and tick() - lastDeposit > 1 then
                    lastDeposit = tick()
                    pcall(function()
                        SpawnMachineRemote:InvokeServer("Deposit", machine)
                    end)
                end
            end

            -- Combine
            pcall(function()
                SpawnMachineRemote:InvokeServer("Combine", machine)
            end)
        end
    end)
end

-- ==========================
-- God Mode
-- ==========================

local function enableGodMode()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end

    humanoid.BreakJointsOnDeath = false
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge

    humanoid.HealthChanged:Connect(function()
        if humanoid.Health <= 0 then
            humanoid.Health = math.huge
        end
    end)
end

-- ==========================
-- GUI TOGGLES
-- ==========================

main:Toggle("Auto Equip Brainrots", false, function(equipToggle)
    _G.AutoEquip = equipToggle
    if equipToggle then
        task.spawn(function()
            while _G.AutoEquip do
                autoEquipPet() -- autoEquipPet now handles looping over backpack
                task.wait(0.1) -- optional delay to prevent spamming
            end
        end)
    end
end)

main:Toggle("Auto Machines", false, function(machineToggle)
    _G.AutoMachine = machineToggle
    if machineToggle then
        startAutoMachineLoop()
        enableGodMode()
    end
end)
    
    main:Line()
    main:Label(""):Refresh("Others")
    local speedList =
    {
        "10",
        "1"
    }

    local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function getRemote(name)
	return ReplicatedStorage:FindFirstChild(name, true)
end

local UpgradeSpeedRemote = getRemote("UpgradeSpeed")
local RebirthRemote = getRemote("Rebirth")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local Networking = ReplicatedStorage
	:WaitForChild("Shared")
	:WaitForChild("Remotes")
	:WaitForChild("Networking")

local Remote = Networking:WaitForChild("RF/PlotAction")

_G.AutoCollect = false
local cachedBaseUUID = nil

local function getBaseUUID()
	if cachedBaseUUID then
		return cachedBaseUUID
	end
	
	for _, base in pairs(Workspace:WaitForChild("Bases"):GetChildren()) do
		local title = base:FindFirstChild("Title")
		if title then
			local titleGui = title:FindFirstChild("TitleGui")
			if titleGui then
				local frame = titleGui:FindFirstChild("Frame")
				if frame and frame:FindFirstChild("PlayerName") then
					
					local nameText = frame.PlayerName.Text
					
					if nameText == player.DisplayName or nameText == player.Name then
						cachedBaseUUID = base.Name
						print("Cached Base UUID:", cachedBaseUUID)
						return cachedBaseUUID
					end
				end
			end
		end
	end
	
	return nil
end

_G.AutoSpeed = false
_G.AutoRebirth = false
_G.SelectedSpeed = {}

    local speedlistDropdown = main:MultiDropdown("Select Speed", speedList, function(selectedItems)
        print("Selected Speed:")
        for i, selectSpeed in ipairs(selectedItems) do
            print(i, selectSpeed)
        end
        _G.SelectedSpeed = selectedItems
    end)
    
    main:Toggle("Auto Buy Speed", false, function(autospeedFunc)
			if autospeedFunc == true then
				_G.AutoSpeed = true
			elseif autospeedFunc == false or destroygui then
				_G.AutoSpeed = false
			end
    end)

    -- AUTO REBIRTH
    main:Toggle("Auto Rebirth", false, function(autorebirthFunc)
			if autorebirthFunc == true then
				_G.AutoRebirth = true
			elseif autorebirthFunc == false or destroygui then
				_G.AutoRebirth = false
			end
    end)

    -- AUTO COLLECT (ALL)
    main:Toggle("Auto Collect", false, function(autocollectFunc)
			if autocollectFunc == true then
				_G.AutoCollect = true
			elseif autocollectFunc == false or destroygui then
				_G.AutoCollect = false
			end
    end)
    -- AUTO UPGRADE BRAINROTS (ALL)
    main:Toggle("Auto Upgrade All", false, function(autoupgradeFunc)
			if autoupgradeFunc == true then
				_G.AutoUpgrade = true
			elseif autoupgradeFunc == false or destroygui then
				_G.AutoUpgrade = false
			end
    end)

    task.spawn(function()
	task.wait(5)
	
	while task.wait(1) do
		if _G.AutoCollect then
			
			local baseUUID = getBaseUUID()
			
			if not baseUUID then
				warn("Base UUID not found!")
				continue
			end
			
			for slot = 1, 40 do
				if not _G.AutoCollect then
					break
				end
				
				pcall(function()
					Remote:InvokeServer("Collect Money", baseUUID, tostring(slot))
				end)
				
				task.wait(0.2)
			end
			
		end
	end
end)

    task.spawn(function()
	while task.wait(0.1) do
		if _G.AutoSpeed and UpgradeSpeedRemote then
			
			if _G.SelectedSpeed and #_G.SelectedSpeed > 0 then
				for _, speedValue in ipairs(_G.SelectedSpeed) do
					pcall(function()
						UpgradeSpeedRemote:InvokeServer(tonumber(speedValue))
					end)
				end
			end
			
		end
	end
end)

task.spawn(function()
	while task.wait(1) do
		if _G.AutoRebirth and RebirthRemote then
			pcall(function()
				RebirthRemote:InvokeServer()
			end)
		end
	end
end)


    -- PLAYERS TAB
local SelectedKillPlayer = nil
local Spectate = false

local PlayerName = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(PlayerName, v.Name)
end

local Players = serv:Channel("Players","http://www.roblox.com/asset/?id=7252023075")

local SelectPlayer = Players:Dropdown("Selected Player", PlayerName, function(vu)
    SelectedKillPlayer = vu
end)

Players:Button("Refresh Player", function()
    local newList = {}
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            table.insert(newList, v.Name)
        end
    end
    -- Clear and rebuild dropdown
    SelectPlayer:Clear()
    for i, name in ipairs(newList) do
        SelectPlayer:Add(name)
    end
end)

Players:Toggle("Spectate Player", false, function(vu)
    Spectate = vu
    if Spectate and SelectedKillPlayer then
        local targetPlayer = game.Players:FindFirstChild(SelectedKillPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
            game.Workspace.Camera.CameraSubject = targetPlayer.Character.Humanoid
        end
    else
        Spectate = false
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        end
    end
end)

Players:Line()

Players:Slider("WalkSpeed", 30, 1000, 16, function(t)
    if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = t
    end
end)

Players:Slider("Jump Power", 80, 1000, 50, function(t)
    if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = t
    end
end)

Players:Slider("Gravity", 0, 500, 196, function(t)
    workspace.Gravity = t
end)

local Trade = serv:Channel("Trade","http://www.roblox.com/asset/?id=7044284832")
local SelectedKillPlayer = nil
local Spectate = false

local PlayerName = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(PlayerName, v.Name)
end


local SelectPlayer = Trade:Dropdown("Selected Player", PlayerName, function(vu)
    SelectedKillPlayer = vu
end)

Trade:Button("Refresh Player", function()
    local newList = {}
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            table.insert(newList, v.Name)
        end
    end
    -- Clear and rebuild dropdown
    SelectPlayer:Clear()
    for i, name in ipairs(newList) do
        SelectPlayer:Add(name)
    end
end)
local insertpetList =
    {
        "9",
        "8",
        "7",
        "6",
        "5",
        "4",
        "3",
        "2",
        "1"
    }

    local insertpetDropdown = Trade:Dropdown("Select Pet Count", insertpetList, function(selectedItems)
        print("Selected Pet Count:")
        for i, insertpetList in ipairs(selectedItems) do
            print(i, insertpetList)
        end
        _G.SelectPetNumber = selectedItems
    end)

Trade:Toggle("Auto Insert Pet", false, function(vu)
    Spectate = vu
    if Spectate and SelectedKillPlayer then
    else
        Spectate = false
    end
end)

Trade:Toggle("Auto Trade", false, function(vu)
    Spectate = vu
    if Spectate and SelectedKillPlayer then
    else
        Spectate = false
    end
end)

Trade:Toggle("Auto Accept", false, function(vu)
    Spectate = vu
    if Spectate and SelectedKillPlayer then
    else
        Spectate = false
    end
end)

Trade:Toggle("Auto Accept Request", false, function(vu)
    Spectate = vu
    if Spectate and SelectedKillPlayer then
    else
        Spectate = false
    end
end)

local Other = serv:Channel("Other","http://www.roblox.com/asset/?id=7040410130")
Other:Label(""):Refresh("Coming Soon")

    -- Add more tabs/channels as needed
    local settings = serv:Channel("Settings", "http://www.roblox.com/asset/?id=7040347038")
    
    settings:Toggle("Shift + Click to TP", false, function(vu)
        local player = game:GetService("Players").LocalPlayer
        local char = player.Character
        local mouse = player:GetMouse()
        local uis = game:GetService("UserInputService")
        local shifthold = false
        
        mouse.Button1Down:Connect(function()
            if shifthold then
                char:MoveTo(mouse.Hit.p)
            end
        end)
        
        uis.InputBegan:Connect(function(input, process)
            if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
                shifthold = true
            end
        end)
        
        uis.InputEnded:Connect(function(input, process)
            if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
                shifthold = false
            end
        end)
        
        warn("Click to Teleport = Working")
    end)
    
    settings:Button("Destroy GUI", function()
        Discord:Destroy()
    end)
    
    -- Anti AFK
    local GC = getconnections or get_signal_cons
    if GC then
        for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
            if v["Disable"] then
                v["Disable"](v)
            elseif v["Disconnect"] then
                v["Disconnect"](v)
            end
        end
    else
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
    
    warn("GUI Loaded Successfully!")
    warn("Press " .. tostring(_G.Toggle) .. " to toggle GUI")
end
