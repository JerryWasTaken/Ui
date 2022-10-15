--Services
local UserInputService = game:GetService("UserInputService")
local players = game:GetService("Workspace")
local tween_service = game:GetService("TweenService")
local run_service = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")

local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local ListenForInput = false

local Library = {}

local utility = {}

function Library:validate(defaults, options)
    local options = options or {}
    for i,v in pairs(defaults) do
        if options[i] == nil then
            options[i] = v
        end
    end
    return options
end

function Library:tween(obj, goal, callback)
    local tween = tween_service:Create(obj, tweenInfo, goal)
    tween.Completed:Connect(callback or function() end)
    tween:Play()
end

function Library:new(options)
    options = Library:validate({
        name = "UI Library Test",
        key = Enum.KeyCode.LeftShift,
        Toggled = options.default ~= false
    }, options or {})

    if coreGui:FindFirstChild("Library") then
        coreGui["Library"]:Destroy()
    end

    local GUI = {
        CurrentTab = nil
    }

    --Main Frame
    do  
        --["0"]ScreenGui
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "Library"
        ScreenGui.Parent = coreGui

        --["1"]Main
        Main = Instance.new("Frame")
        Main.Name = "Main"
        Main.Parent = ScreenGui
        Main.AnchorPoint = Vector2.new(0.5, 0.5)
        Main.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
        Main.Position = UDim2.new(0.5, 0, 0.5, 0)
        Main.Size = UDim2.new(0, 500, 0, 400)

        --["2"]]UICorner
        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Main

        --["3"]DropShadow
        DropShadowHolder = Instance.new("Frame")
        DropShadow = Instance.new("ImageLabel")

        DropShadowHolder.Name = "DropShadowHolder"
        DropShadowHolder.Parent = Main
        DropShadowHolder.BackgroundTransparency = 1.000
        DropShadowHolder.BorderSizePixel = 0
        DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
        DropShadowHolder.ZIndex = 0

        DropShadow.Name = "DropShadow"
        DropShadow.Parent = DropShadowHolder
        DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
        DropShadow.BackgroundTransparency = 1.000
        DropShadow.BorderSizePixel = 0
        DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        DropShadow.Size = UDim2.new(1, 47, 1, 47)
        DropShadow.ZIndex = 0
        DropShadow.Image = "rbxassetid://6014261993"
        DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        DropShadow.ImageTransparency = 0.500
        DropShadow.ScaleType = Enum.ScaleType.Slice
        DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

        --["4"]TopBar
        TopBar = Instance.new("Frame")
        UICorner_2 = Instance.new("UICorner")
        Extension = Instance.new("Frame")
        TopBarTitle = Instance.new("TextLabel")
        UIPadding = Instance.new("UIPadding")
        Close = Instance.new("ImageLabel")
        Line = Instance.new("Frame")

        TopBar.Name = "TopBar"
        TopBar.Parent = Main
        TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TopBar.Size = UDim2.new(1, 0, 0.00999999978, 30)

        UICorner_2.Parent = TopBar

        Extension.Name = "Extension"
        Extension.Parent = TopBar
        Extension.AnchorPoint = Vector2.new(0, 1)
        Extension.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Extension.BorderSizePixel = 0
        Extension.Position = UDim2.new(0, 0, 1, 0)
        Extension.Size = UDim2.new(1, 0, 0.5, 0)
        Extension.ZIndex = 2

        TopBarTitle.Name = "Title"
        TopBarTitle.Parent = TopBar
        TopBarTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TopBarTitle.BackgroundTransparency = 1.000
        TopBarTitle.BorderSizePixel = 0
        TopBarTitle.Size = UDim2.new(0.5, 0, 1, 0)
        TopBarTitle.ZIndex = 2
        TopBarTitle.Font = Enum.Font.Gotham
        TopBarTitle.Text = options["name"]
        TopBarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        TopBarTitle.TextSize = 16.000
        TopBarTitle.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding.Parent = TopBarTitle
        UIPadding.PaddingLeft = UDim.new(0, 8)
        UIPadding.PaddingTop = UDim.new(0, 1)

        Close.Name = "Close"
        Close.Parent = TopBar
        Close.AnchorPoint = Vector2.new(1, 0)
        Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Close.BackgroundTransparency = 1.000
        Close.Position = UDim2.new(1, -6, -0.0882352963, 6)
        Close.Size = UDim2.new(0, 32, 0, 28)
        Close.ZIndex = 2
        Close.Image = "rbxassetid://2777727756"
        Close.ScaleType = Enum.ScaleType.Fit

        Line.Name = "Line"
        Line.Parent = TopBar
        Line.AnchorPoint = Vector2.new(0, 1)
        Line.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
        Line.BorderSizePixel = 0
        Line.Position = UDim2.new(0, 0, 1, 0)
        Line.Size = UDim2.new(1, 0, 0, 1)
        Line.ZIndex = 2

        ContentContainer = Instance.new("Frame")
        ContentContainer.Name = "ContentContainer"
        ContentContainer.Parent = Main
        ContentContainer.AnchorPoint = Vector2.new(1, 0)
        ContentContainer.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
        ContentContainer.BackgroundTransparency = 1.000
        ContentContainer.Position = UDim2.new(1, -6, 0.0118749999, 36)
        ContentContainer.Size = UDim2.new(0.920000017, -132, 0.988125026, -42)
    end

    --Navigation
    do
        Navigation = Instance.new("Frame")
        UICorner_3 = Instance.new("UICorner")
        UICorner_4 = Instance.new("UICorner")
        Hide = Instance.new("Frame")
        Hide_2 = Instance.new("Frame")
        ButtonHolder = Instance.new("Frame")
        UIPadding_2 = Instance.new("UIPadding")
        UIListLayout = Instance.new("UIListLayout")

        Navigation.Name = "Navigation"
        Navigation.Parent = Main
        Navigation.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
        Navigation.BorderSizePixel = 0
        Navigation.Position = UDim2.new(0, 0, 0, 30)
        Navigation.Size = UDim2.new(0.0759999976, 120, 1.00250006, -31)

        UICorner_3.CornerRadius = UDim.new(0, 6)
        UICorner_3.Parent = Navigation

        Hide.Name = "Hide"
        Hide.Parent = Navigation
        Hide.AnchorPoint = Vector2.new(1, 0)
        Hide.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
        Hide.BorderSizePixel = 0
        Hide.Position = UDim2.new(1, 0, 0, 0)
        Hide.Size = UDim2.new(1, 0, 0, 20)

        Hide_2.Name = "Hide"
        Hide_2.Parent = Navigation
        Hide_2.AnchorPoint = Vector2.new(1, 0)
        Hide_2.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
        Hide_2.BorderSizePixel = 0
        Hide_2.Position = UDim2.new(1, 0, 0, 0)
        Hide_2.Size = UDim2.new(0, 20, 1, 0)

        ButtonHolder.Name = "ButtonHolder"
        ButtonHolder.Parent = Navigation
        ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonHolder.BackgroundTransparency = 1.000
        ButtonHolder.Size = UDim2.new(1, 0, 1, 0)

        UIPadding_2.Parent = ButtonHolder
        UIPadding_2.PaddingBottom = UDim.new(0, 8)
        UIPadding_2.PaddingTop = UDim.new(0, 8)
        UIPadding_2.PaddingLeft = UDim.new(0, 5)
        UIPadding_2.PaddingRight = UDim.new(0, 5)

        UIListLayout.Parent = ButtonHolder
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 1)

        UICorner_4.CornerRadius = UDim.new(0, 2)
        UICorner_4.Parent = ButtonHolder
    end

    --Methods

    function Library:Toggle(bool)
		local Toggled = bool
		Main.Visible = bool
	end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == options.key and not ListenForInput then
            if Main.Visible then
			    Library:Toggle(false)
            else
                Library:Toggle(true)
			end
		end
	end)

    do  
        function utility:DraggingEnabled(frame, parent)
        
            parent = parent or frame
            
            -- stolen from wally or kiriot, kek
            local dragging = false
            local dragInput, mousePos, framePos
    
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    mousePos = input.Position
                    framePos = parent.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)
    
            frame.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    dragInput = input
                end
            end)
    
            UserInputService.InputChanged:Connect(function(input)
                if input == dragInput and dragging then
                    local delta = input.Position - mousePos
                    parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
                end
            end)
    
        end
        
        function utility:DraggingEnded(callback)
            table.insert(self.ended, callback)
        end
        
    end
    
    utility:DraggingEnabled(TopBar, Main)

    function Library:CreateTab(options)
        options = Library:validate({
            name = "New Tab",
            icon = "rbxassetid://11205286197"
        }, options or {})

        local Tab = {
            Hover = false,
            Active = false
        }

        --Render
        do
            Tab["17"] = Instance.new("TextLabel")
            Tab["18"] = Instance.new("UIPadding")
            Tab["19"] = Instance.new("ImageLabel")
            Tab["20"] = Instance.new("ScrollingFrame")
            Tab["21"] = Instance.new("UIPadding")
            Tab["22"] =  Instance.new("UIListLayout")

            Tab["17"].Name = "Inactive"
            Tab["17"].Parent = ButtonHolder
            Tab["17"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Tab["17"].BackgroundTransparency = 1
            Tab["17"].BorderSizePixel = 0
            Tab["17"].Size = UDim2.new(1, 0, 0.0254237261, 24)
            Tab["17"].Font = Enum.Font.Ubuntu
            Tab["17"].Text = options.name
            Tab["17"].TextColor3 = Color3.fromRGB(200, 200, 200)
            Tab["17"].TextSize = 15
            Tab["17"].TextXAlignment = Enum.TextXAlignment.Left

            Tab["18"].Parent = Tab["17"]
            Tab["18"].PaddingLeft = UDim.new(0, 35)

            Tab["19"].Parent = Tab["17"]
            Tab["19"].AnchorPoint = Vector2.new(0, 0.5)
            Tab["19"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Tab["19"].BackgroundTransparency = 1
            Tab["19"].Position = UDim2.new(-0.0388993099, -24, 0.477272749, 0)
            Tab["19"].Size = UDim2.new(0, 26, 0, 26)
            Tab["19"].Image = options.icon
            Tab["19"].ImageColor3 = Color3.fromRGB(200, 200, 200)
            Tab["19"].ScaleType = Enum.ScaleType.Fit

            Tab["20"].Name = "HomeTab"
            Tab["20"].Parent = ContentContainer
            Tab["20"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Tab["20"].BackgroundTransparency = 1.000
            Tab["20"].Selectable = false
            Tab["20"].Size = UDim2.new(1, 0, 1, 0)
            Tab["20"].ScrollBarThickness = 0
            Tab["20"].Visible = false

            Tab["21"].Parent = Tab["20"]
            Tab["21"].PaddingBottom = UDim.new(0, 1)
            Tab["21"].PaddingLeft = UDim.new(0, 1)
            Tab["21"].PaddingRight = UDim.new(0, 2)
            Tab["21"].PaddingTop = UDim.new(0, 1)

            Tab["22"].Parent = Tab["20"]
            Tab["22"].SortOrder = Enum.SortOrder.LayoutOrder
            Tab["22"].Padding = UDim.new(0, 5)
        end

        --Methods
        function Tab:Activate()
            if not Tab.Active then
                if GUI.CurrentTab ~= nil then
                    GUI.CurrentTab:Deactivate()
                end

                Tab.Active = true
                Library:tween(Tab["17"], {BackgroundTransparency = 0.8})
                Library:tween(Tab["17"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
                Library:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
                Tab["20"].Visible = true

                GUI.CurrentTab = Tab
            end
        end

        function Tab:Deactivate()
            if Tab.Active then
                Tab.Active = false
                Tab.Hover = false
                Library:tween(Tab["17"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
                Library:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
                Library:tween(Tab["17"], {BackgroundTransparency = 1})
                Tab["20"].Visible = false
            end
        end

        --Click
        do
            Tab["17"].MouseEnter:Connect(function()
                Tab.Hover = true
                if not Tab.Active then
                    Library:tween(Tab["17"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
                    Library:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
                end
            end)
            
            Tab["17"].MouseLeave:Connect(function()
                Tab.Hover = false
    
                if not Tab.Active then
                    Library:tween(Tab["17"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
                    Library:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
                end
            end)
            
            UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if gameProcessedEvent then return end
    
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Tab.Hover then
                        Tab:Activate()
                    end
                end
            end)
        end

        if GUI.CurrentTab == nil then
            GUI.CurrentTab = Tab
        end

        function Tab:CreateButton(name, callback)
            callback = callback or function () end

            local Button = {
                Hover = false,
                MouseDown = false
            }

            do
                Button["23"] = Instance.new("Frame")
                Button["24"] = Instance.new("UICorner")
                Button["Title"] = Instance.new("TextLabel")
                Button["26"] = Instance.new("TextLabel")
                Button["27"] = Instance.new("UIPadding")
                Button["28"] = Instance.new("ImageLabel")
                Button["Stroke"] = Instance.new("UIStroke")

                Button["23"].Name = "Button"
                Button["23"].Parent = Tab["20"]
                Button["23"].BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                Button["23"].Size = UDim2.new(1, 0, 0, 32)

                Button["24"].CornerRadius = UDim.new(0, 4)
                Button["24"].Parent = Button["23"]

                Button["Title"].Name = "Title"
                Button["Title"].Parent = Button["23"]
                Button["Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Button["Title"].BackgroundTransparency = 1.000
                Button["Title"].Size = UDim2.new(0.818471313, 0, 1.05654407, 0)
                Button["Title"].Font = Enum.Font.Ubuntu
                Button["Title"].Text = name
                Button["Title"].TextColor3 = Color3.fromRGB(255, 255, 255)
                Button["Title"].TextSize = 14.000
                Button["Title"].TextXAlignment = Enum.TextXAlignment.Left

                Button["26"].Name = "Title"
                Button["26"].Parent = Button["Title"]
                Button["26"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Button["26"].BackgroundTransparency = 1.000
                Button["26"].Size = UDim2.new(1, 0, 1, 0)
                Button["26"].Font = Enum.Font.Ubuntu
                Button["26"].Text = name
                Button["26"].TextColor3 = Color3.fromRGB(255, 255, 255)
                Button["26"].TextSize = 14.000
                Button["26"].TextXAlignment = Enum.TextXAlignment.Left

                Button["27"].Parent = Button["23"]
                Button["27"].PaddingBottom = UDim.new(0, 6)
                Button["27"].PaddingLeft = UDim.new(0, 6)
                Button["27"].PaddingRight = UDim.new(0, 6)
                Button["27"].PaddingTop = UDim.new(0, 6)

                Button["28"].Parent = Button["23"]
                Button["28"].AnchorPoint = Vector2.new(1, 0)
                Button["28"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Button["28"].BackgroundTransparency = 1.000
                Button["28"].Position = UDim2.new(1, 0, 0, 0)
                Button["28"].Size = UDim2.new(0, 25, 0, 23)
                Button["28"].Image = "rbxassetid://11279552676"
                Button["28"].ScaleType = Enum.ScaleType.Fit
                Button["28"].SliceScale = 10.000

                Button["Stroke"].Parent = Button["23"]
                Button["Stroke"].Color = Color3.new(82, 82, 82)
                Button["Stroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            end

            --Logic
            do
                Button["23"].MouseEnter:Connect(function(input, gpe)
                    Button.Hover = true

                    if not Button.MouseDown then
                        Library:tween(Button["23"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
                        Library:tween(Button["Stroke"], {Color = Color3.fromRGB(102, 102, 102)})
                    end
                end)

                Button["23"].MouseLeave:Connect(function()
                    Button.Hover = false

                    if not Button.MouseDown then
                        Library:tween(Button["23"], {BackgroundColor3 = Color3.fromRGB(26, 26, 26)})
                        Library:tween(Button["Stroke"], {Color = Color3.fromRGB(82, 82, 82)})
                    end
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                    if gameProcessedEvent then return end

                    if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
                        Button.MouseDown = true
                        Library:tween(Button["23"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
                        Library:tween(Button["Stroke"], {Color = Color3.fromRGB(200, 200, 200)})
                        callback()
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
                    if gameProcessedEvent then return end

                    if Button.Hover then
                        Library:tween(Button["23"], {BackgroundColor3 = Color3.fromRGB(26, 26, 26)})
                        Library:tween(Button["Stroke"], {Color = Color3.fromRGB(102, 102, 102)})
                    else
                        Library:tween(Button["23"], {BackgroundColor3 = Color3.fromRGB(26, 26, 26)})
                        Library:tween(Button["Stroke"], {Color = Color3.fromRGB(82, 82, 82)})
                    end
                end)
            end

            --Methods
            function Button:SetText(text)
                Button["Title"].Text = text
                Button["26"].Text = text
            end

            function Button:SetCallback(fn)
                callback = fn
            end

            return Button
        end

        function Tab:CreateLabel(name, Align)
            local text = text or "New Label"
            local Align = Align or Enum.TextXAlignment.Left

            local label = {}

            do
                label["1"] = Instance.new("Frame")
                label["2"] = Instance.new("UICorner")
                label["3"] = Instance.new("TextLabel")
                label["4"] = Instance.new("TextLabel")
                label["5"] = Instance.new("UIPadding")
                label["6"] = Instance.new("UIStroke")

                label["1"].Name = "Label"
                label["1"].Parent = Tab["20"]
                label["1"].BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                label["1"].BackgroundTransparency = 0.600
                label["1"].Position = UDim2.new(0, 0, 0.11679092, 0)
                label["1"].Size = UDim2.new(1, 0,-0.006, 32)

                label["2"].CornerRadius = UDim.new(0, 4)
                label["2"].Parent = label["1"]

                label["3"].Name = "Title"
                label["3"].Parent = label["1"]
                label["3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                label["3"].BackgroundTransparency = 1.000
                label["3"].Position = UDim2.new(0, 0, -6.9340183e-07, 0)
                label["3"].Size = UDim2.new(1, 0, 1, 0)
                label["3"].Font = Enum.Font.Ubuntu
                label["3"].TextColor3 = Color3.fromRGB(255, 255, 255)
                label["3"].TextSize = 14.000
                label["3"].TextXAlignment = Align
                label["3"].TextYAlignment = Enum.TextYAlignment.Top
                label["3"].Text = text
                label["3"].TextWrapped = true

                label["4"].Name = "Title"
                label["4"].Parent = label["3"]
                label["4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                label["4"].BackgroundTransparency = 1.000
                label["4"].Position = UDim2.new(0, 0, -6.9340183e-07, 0)
                label["4"].Size = UDim2.new(1, 0, 1, 0)
                label["4"].Font = Enum.Font.Ubuntu
                label["4"].TextColor3 = Color3.fromRGB(255, 255, 255)
                label["4"].TextSize = 14.000
                label["4"].TextXAlignment = Align
                label["4"].TextYAlignment = Enum.TextYAlignment.Top
                label["4"].Text = text
                label["4"].TextWrapped = true

                label["5"].Parent = label["1"]
                label["5"].PaddingBottom = UDim.new(0, 6)
                label["5"].PaddingLeft = UDim.new(0, 6)
                label["5"].PaddingRight = UDim.new(0, 6)
                label["5"].PaddingTop = UDim.new(0, 6)

                label["6"].Parent = label["1"]
                label["6"].Color = Color3.new(127, 127, 127)
                label["6"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            end
 
            --Methods

            function label:_update()
                label["3"].Text = name
                label["4"].Text = name

                label["3"].Size = UDim2.new(label["3"].Size.X.Scale, label["3"].Size.X.Offset, 0, math.huge)
                label["4"].Size = UDim2.new(label["4"].Size.X.Scale, label["4"].Size.X.Offset, 0, math.huge)
                label["3"].Size = UDim2.new(label["3"].Size.X.Scale, label["3"].Size.X.Offset, 0, label["3"].TextBounds.Y)
                label["4"].Size = UDim2.new(label["4"].Size.X.Scale, label["4"].Size.X.Offset, 0, label["4"].TextBounds.Y)
                label["1"].Size = UDim2.new(label["1"].Size.X.Scale, label["1"].Size.X.Offset, 0, label["3"].TextBounds.Y + 12, label["4"].TextBounds.Y + 12)
            end

            function label:SetText(text)
                name = text
                label["3"].Text = text
                label["4"].Text = text
                label:_update()
            end

            label:_update()

            return label
        end

        function Tab:CreateSlider(title, min, max, default, callback)
            title = title or "New Slider"
            min = min or 0
            max = max or 100
            default = default or 50
            callback = callback or function() end

            local Slider = {
                Hover = false,
                MouseDown = false,
                Connection = nil
            }

            do
                Slider["3a"] = Instance.new("Frame")
                Slider["3b"] = Instance.new("UICorner")
                Slider["3c"] = Instance.new("UIStroke")
                Slider["3d"] = Instance.new("TextLabel")
                Slider["3e"] = Instance.new("TextLabel")
                Slider["3f"] = Instance.new("UIPadding")
                Slider["3g"] = Instance.new("TextLabel")
                Slider["3h"] = Instance.new("TextLabel")
                Slider["3i"] = Instance.new("Frame")
                Slider["3j"] = Instance.new("UICorner")
                Slider["3k"] = Instance.new("Frame")
                Slider["3l"] = Instance.new("UICorner")
                Slider["3m"] = Instance.new("UIStroke")

                Slider["3a"].Name = "Slider"
                Slider["3a"].Parent = Tab["20"]
                Slider["3a"].BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                Slider["3a"].Position = UDim2.new(0, 0, 0.199419543, 0)
                Slider["3a"].Size = UDim2.new(1, 0, -0.0028955969, 48)

                Slider["3b"].CornerRadius = UDim.new(0, 4)
                Slider["3b"].Parent = Slider["3a"]

                Slider["3d"].Name = "Title"
                Slider["3d"].Parent = Slider["3a"]
                Slider["3d"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3d"].BackgroundTransparency = 1.000
                Slider["3d"].Size = UDim2.new(0.818471313, 0, 0.634655893, 0)
                Slider["3d"].Font = Enum.Font.Ubuntu
                Slider["3d"].Text = title
                Slider["3d"].TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3d"].TextSize = 14.000
                Slider["3d"].TextXAlignment = Enum.TextXAlignment.Left

                Slider["3e"].Name = "Bold"
                Slider["3e"].Parent = Slider["3d"]
                Slider["3e"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3e"].BackgroundTransparency = 1.000
                Slider["3e"].Size = UDim2.new(1, 0, 1, 0)
                Slider["3e"].Font = Enum.Font.Ubuntu
                Slider["3e"].Text = title
                Slider["3e"].TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3e"].TextSize = 14.000
                Slider["3e"].TextXAlignment = Enum.TextXAlignment.Left

                Slider["3f"].Parent = Slider["3a"]
                Slider["3f"].PaddingBottom = UDim.new(0, 6)
                Slider["3f"].PaddingLeft = UDim.new(0, 6)
                Slider["3f"].PaddingRight = UDim.new(0, 6)
                Slider["3f"].PaddingTop = UDim.new(0, 6)

                Slider["3g"].Name = "Value"
                Slider["3g"].Parent = Slider["3a"]
                Slider["3g"].AnchorPoint = Vector2.new(1, 0)
                Slider["3g"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3g"].BackgroundTransparency = 1.000
                Slider["3g"].Position = UDim2.new(1, 0, 0, 0)
                Slider["3g"].Size = UDim2.new(0, 24, 0, 20)
                Slider["3g"].Font = Enum.Font.Ubuntu
                Slider["3g"].Text = tostring(default)
                Slider["3g"].TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3g"].TextSize = 14.000
                Slider["3g"].TextXAlignment = Enum.TextXAlignment.Right

                Slider["3h"].Name = "Bold"
                Slider["3h"].Parent = Slider["3g"]
                Slider["3h"].AnchorPoint = Vector2.new(1, 0)
                Slider["3h"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3h"].BackgroundTransparency = 1.000
                Slider["3h"].Position = UDim2.new(1, 0, 0, 0)
                Slider["3h"].Size = UDim2.new(0, 24, 0, 20)
                Slider["3h"].Font = Enum.Font.Ubuntu
                Slider["3h"].Text = tostring(default)
                Slider["3h"].TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider["3h"].TextSize = 14.000
                Slider["3h"].TextXAlignment = Enum.TextXAlignment.Right

                Slider["3i"].Name = "SliderBack"
                Slider["3i"].Parent = Slider["3a"]
                Slider["3i"].AnchorPoint = Vector2.new(0, 1)
                Slider["3i"].BackgroundColor3 = Color3.fromRGB(12, 12, 12)
                Slider["3i"].Position = UDim2.new(0, 0, 1, 0)
                Slider["3i"].Size = UDim2.new(1, 0, 0, 4)

                Slider["3j"].Parent = Slider["3i"]

                Slider["3k"].Name = "Draggable"
                Slider["3k"].Parent = Slider["3i"]
                Slider["3k"].BackgroundColor3 = Color3.fromRGB(170, 85, 255)
                Slider["3k"].Size = UDim2.new(0.5, 0, 1, 0)

                Slider["3l"].Parent = Slider["3k"]

                Slider["3c"].Parent = Slider["3a"]
                Slider["3c"].Color = Color3.new(81, 81, 81)
                Slider["3c"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                Slider["3m"].Parent = Slider["3i"]
                Slider["3m"].Color = Color3.new(81, 81, 81)
                Slider["3m"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            end

            function Slider:SetValue(v)
                if v == nil then
                    mouse = game.Players.LocalPlayer:GetMouse()
                    percentage = math.clamp((mouse.X - Slider["3i"].AbsolutePosition.X) / (Slider["3i"].AbsoluteSize.X), 0, 1)
                    value = math.floor(((max - min) * percentage) + min)

                    Slider["3g"].Text = tostring(value)
                    Slider["3h"].Text = tostring(value)
                    Slider["3k"].Size = UDim2.fromScale(percentage, 1)
                else
                    Slider["3g"].Text = tostring(v)
                    Slider["3h"].Text = tostring(v)
                    Slider["3k"].Size = UDim2.fromScale(((v - min) / (max - min)), 1)
                end
                callback(Slider:GetValue())
            end

            function Slider:GetValue()
                return tonumber(Slider["3g"].Text)
            end

            --Logic
            do
                Slider["3a"].MouseEnter:Connect(function(input, gpe)
                    Slider.Hover = true

                    if not Slider.MouseDown then
                        Library:tween(Slider["3a"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
                        Library:tween(Slider["3m"], {Color = Color3.fromRGB(102, 102, 102)})
                        Library:tween(Slider["3k"], {BackgroundColor3 = Color3.fromRGB(128, 0, 255)})
                    end
                end)

                Slider["3a"].MouseLeave:Connect(function()
                    Slider.Hover = false

                    if not Slider.MouseDown then
                        Library:tween(Slider["3a"], {BackgroundColor3 = Color3.fromRGB(26, 26, 26)})
                        Library:tween(Slider["3m"], {Color = Color3.fromRGB(82, 82, 82)})
                        Library:tween(Slider["3k"], {BackgroundColor3 = Color3.fromRGB(170, 85, 255)})
                    end
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                    if gameProcessedEvent then return end

                    if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Hover then
                        Slider.MouseDown = true
                        Library:tween(Slider["3a"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
                        Library:tween(Slider["3m"], {Color = Color3.fromRGB(200, 200, 200)})
                        
                        if not Slider.Connection then
                            Slider.Connection = run_service.RenderStepped:Connect(function()
                                Slider:SetValue()
                            end)
                        end
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
                    if gameProcessedEvent then return end

                    if Slider.Hover then
                        Library:tween(Slider["3a"], {BackgroundColor3 = Color3.fromRGB(26, 26, 26)})
                        Library:tween(Slider["3c"], {Color = Color3.fromRGB(102, 102, 102)})
                        Library:tween(Slider["3m"], {Color = Color3.fromRGB(200, 200, 200)})
                        Library:tween(Slider["3k"], {BackgroundColor3 = Color3.fromRGB(125, 0, 255)})
                    else
                        Library:tween(Slider["3a"], {BackgroundColor3 = Color3.fromRGB(26, 26, 26)})
                        Library:tween(Slider["3c"], {Color = Color3.fromRGB(82, 82, 82)})
                        Library:tween(Slider["3m"], {Color = Color3.fromRGB(82, 82, 82)})
                        Library:tween(Slider["3k"], {BackgroundColor3 = Color3.fromRGB(175, 85, 255)})
                    end

                    if Slider.Connection then Slider.Connection:Disconnect() end
                    Slider.Connection = nil
                end)
            end

            return Slider
        end

        function Tab:CreateToggle(title, callback)
            title = title or "New Toggle"
            callback = callback or function() end 

            local Toggle = {
                Hover = false,
                MouseDown = false,
                State = false
            }

            --Render
            do
                ToggleInactive = Instance.new("Frame")
                 UICorner_9 = Instance.new("UICorner")
                 Title_7 = Instance.new("TextLabel")
                 Title_8 = Instance.new("TextLabel")
                 UIPadding_9 = Instance.new("UIPadding")
                 CheckmarkHolder = Instance.new("Frame")
                 UICorner_10 = Instance.new("UICorner")
                 ImageLabel_4 = Instance.new("ImageLabel")
                 Toggle["Stroke"] = Instance.new("UIStroke")
                 Toggle["Stroke2"] = Instance.new("UIStroke")

                ToggleInactive.Name = "ToggleInactive"
                ToggleInactive.Parent = Tab["20"]
                ToggleInactive.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                ToggleInactive.Size = UDim2.new(1, 0, 0, 32)

                UICorner_9.CornerRadius = UDim.new(0, 4)
                UICorner_9.Parent = ToggleInactive

                Toggle["Stroke"].Parent = ToggleInactive
                Toggle["Stroke"].Color = Color3.fromRGB(81, 81, 81)
                Toggle["Stroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                Toggle["Stroke2"].Parent = CheckmarkHolder
                Toggle["Stroke2"].Color = Color3.fromRGB(81, 81, 81)
                Toggle["Stroke2"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                Toggle["Stroke2"].Thickness = 1

                Title_7.Name = "Title"
                Title_7.Parent = ToggleInactive
                Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title_7.BackgroundTransparency = 1.000
                Title_7.Size = UDim2.new(0.818471313, 0, 1.05654407, 0)
                Title_7.Font = Enum.Font.Ubuntu
                Title_7.Text = title
                Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_7.TextSize = 14.000
                Title_7.TextXAlignment = Enum.TextXAlignment.Left

                Title_8.Name = "Title"
                Title_8.Parent = Title_7
                Title_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title_8.BackgroundTransparency = 1.000
                Title_8.Size = UDim2.new(1, 0, 1, 0)
                Title_8.Font = Enum.Font.Ubuntu
                Title_8.Text = title
                Title_8.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_8.TextSize = 14.000
                Title_8.TextXAlignment = Enum.TextXAlignment.Left

                UIPadding_9.Parent = ToggleInactive
                UIPadding_9.PaddingBottom = UDim.new(0, 6)
                UIPadding_9.PaddingLeft = UDim.new(0, 6)
                UIPadding_9.PaddingRight = UDim.new(0, 6)
                UIPadding_9.PaddingTop = UDim.new(0, 6)

                CheckmarkHolder.Name = "CheckmarkHolder"
                CheckmarkHolder.Parent = ToggleInactive
                CheckmarkHolder.AnchorPoint = Vector2.new(1, 0)
                CheckmarkHolder.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
                CheckmarkHolder.Position = UDim2.new(0.984025538, 0, 0, 0)
                CheckmarkHolder.Size = UDim2.new(0, 20, 0, 20)

                UICorner_10.CornerRadius = UDim.new(0, 2)
                UICorner_10.Parent = CheckmarkHolder

                ImageLabel_4.Parent = CheckmarkHolder
                ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel_4.BackgroundTransparency = 1
                ImageLabel_4.Size = UDim2.new(0, 20, 0, 20)
                ImageLabel_4.Image = "rbxassetid://11279801331"
                ImageLabel_4.ImageTransparency = 1
                ImageLabel_4.ScaleType = Enum.ScaleType.Fit
            end

            --Logic
            do
                ToggleInactive.MouseEnter:Connect(function(input, gpe)
                    Toggle.Hover = true

                    if not Toggle.MouseDown then
                        Library:tween(ToggleInactive, {Color = Color3.fromRGB(102, 102, 102)})
                    end
                end)

                ToggleInactive.MouseLeave:Connect(function()
                    Toggle.Hover = false

                    if not Toggle.MouseDown then
                        Library:tween(ToggleInactive, {Color = Color3.fromRGB(102, 102, 102)})
                    end
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                    if gameProcessedEvent then return end

                    if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
                        Toggle.MouseDown = true
                        Library:tween(ToggleInactive, {BackgroundColor3 = Color3.fromRGB(68, 68, 68)})
                        Library:tween(Toggle["Stroke"], {Color = Color3.fromRGB(200, 200, 200)})
                        Toggle:toggle()
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
                    if gameProcessedEvent then return end

                    if Toggle.Hover then
                        Library:tween(ToggleInactive, {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
                        Library:tween(Toggle["Stroke"], {Color = Color3.fromRGB(102, 102, 102)})
                    else
                        Library:tween(ToggleInactive, {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
                        Library:tween(Toggle["Stroke"], {Color = Color3.fromRGB(81, 81, 81)})
                    end
                end)
            end

            do
                function Toggle:toggle(b)
                    if b == nil then
                        Toggle.State = not Toggle.State
                    else
                        Toggle.State = b
                    end

                    if Toggle.State then
                        Library:tween(CheckmarkHolder, {BackgroundColor3 = Color3.fromRGB(75, 36, 116)})
                        Library:tween(ImageLabel_4, {ImageTransparency = 0})
                    else
                        Library:tween(CheckmarkHolder, {BackgroundColor3 = Color3.fromRGB(26, 26, 26)})
                        Library:tween(ImageLabel_4, {ImageTransparency = 1})
                    end

                    callback(Toggle.State)
                end
            end

            return Toggle
        end

        return Tab
    end


    return Library
end

return Library
