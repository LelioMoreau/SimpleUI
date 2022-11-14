-- import roblox services --

CoreGui = game:GetService("CoreGui")
Players = game:GetService("Players")
UserInputService = game:GetService("UserInputService")
TweenService = game:GetService("TweenService")
RunService = game:GetService("RunService")
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer

-- import global modules --
if not SaveLibrary then
    SaveLibrary = loadfile("SimpleUI/save.lua")()
end

if not Config then
    Config = loadfile("SimpleUI/config.lua")()
end

local Library = {}

Library.new = function()

    UserInputService.MouseIconEnabled = true

    local self = {}
    local tabs = {}
    local popups = {}

    -- Variables --

    local selected_tab
    local searchToggle
    local dragging
    local dragInput
    local dragStart
    local startPos

    -- UI elements --

        -- base frame --
        local base_gui = Instance.new("ScreenGui")
        local base_frame = Instance.new("Frame")
        local base_frame_corner = Instance.new("UICorner")
        local base_frame_gradient = Instance.new("UIGradient")

        -- search frame --
        local search_frame = Instance.new("Frame")
        local search_input = Instance.new("TextBox")
        local search_frame_corner = Instance.new("UICorner")
        local search_frame_stroke = Instance.new("UIStroke")
        local search_icon = Instance.new("ImageButton")

        -- tabs frame --
        local tabs_mouse_override = Instance.new("TextButton")
        local tabs_frame = Instance.new("Frame")
        local tabs_frame_corner = Instance.new("UICorner")
        local tabs_frame_stroke = Instance.new("UIStroke")
        local tabs_frame_container = Instance.new("ScrollingFrame")
        local tabs_frame_container_list_layout = Instance.new("UIListLayout")
        local tabs_frame_overlay = Instance.new("Frame")
        local tabs_frame_overlay_corner = Instance.new("UICorner")

        -- content frame --
        local content_frame = Instance.new("Frame")
        local content_frame_corner = Instance.new("UICorner")
        local content_frame_stroke = Instance.new("UIStroke")
        local content_frame_container = Instance.new("ScrollingFrame")
        local content_frame_list_layout = Instance.new("UIListLayout")

    -- UI properties --

        -- base frame --
        base_gui.Name = "base_gui"
        base_gui.Parent = CoreGui
        base_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        -- mouse override --
        tabs_mouse_override.Name = "tabs_mouse_override"
        tabs_mouse_override.Parent = base_gui
        tabs_mouse_override.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabs_mouse_override.BackgroundTransparency = 1.000
        tabs_mouse_override.Position = UDim2.new(0, 0, 0, 0)
        tabs_mouse_override.Size = UDim2.new(1, 0, 1, 0)
        tabs_mouse_override.Modal = true
        tabs_mouse_override.Text = ""

        -- search frame --
        search_frame.Name = "search_frame"
        search_frame.Parent = base_frame
        search_frame.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
        search_frame.Position = UDim2.new(0.0270000119, 0, 0.0500000007, 0)
        search_frame.Size = UDim2.new(0, 24, 0, 24)

        search_input.Name = "search_input"
        search_input.Parent = search_frame
        search_input.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
        search_input.BackgroundTransparency = 1.000
        search_input.Position = UDim2.new(0, 24, 0, 0)
        search_input.Size = UDim2.new(0, 0, 0, 24)
        search_input.Font = Enum.Font.SourceSans
        search_input.Text = ""
        search_input.TextColor3 = Color3.fromRGB(0, 0, 0)
        search_input.TextSize = 14.000
        search_input.TextWrapped = true
        search_input.ClearTextOnFocus = false
        search_input.TextXAlignment = Enum.TextXAlignment.Left

        search_frame_corner.Name = "search_frame_corner"
        search_frame_corner.Parent = search_frame

        search_frame_stroke.Name = "search_frame_stroke"
        search_frame_stroke.Parent = search_frame
        search_frame_stroke.Color = Color3.fromRGB(0,0,0)
        search_frame_stroke.Thickness = 1.6

        search_icon.Name = "search_icon"
        search_icon.Parent = search_frame
        search_icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        search_icon.BackgroundTransparency = 1.000
        search_icon.Position = UDim2.new(7.4505806e-09, 0, 0, 0)
        search_icon.Size = UDim2.new(0, 24, 0, 24)
        search_icon.Image = "http://www.roblox.com/asset/?id=6031154871"

        -- base frame --
        base_frame.Name = "base_frame"
        base_frame.Parent = tabs_mouse_override
        base_frame.BackgroundColor3 = Config.theme.base_frame.background_color
        base_frame.Position = UDim2.new(0, 310, 0, 214)
        base_frame.Size = UDim2.new(0, 0, 0, 0)

        base_frame_corner.CornerRadius = UDim.new(0, 15)
        base_frame_corner.Name = "base_frame_corner"
        base_frame_corner.Parent = base_frame

        base_frame_gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(97, 46, 94)), ColorSequenceKeypoint.new(0.48, Color3.fromRGB(76, 37, 170)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(4, 4, 161))}
        base_frame_gradient.Rotation = 45
        base_frame_gradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.05), NumberSequenceKeypoint.new(1.00, 0.05)}
        base_frame_gradient.Name = "base_frame_gradient"

        -- tabs frame --
        tabs_frame.Name = "tabs_frame"
        tabs_frame.Parent = base_frame
        tabs_frame.BackgroundColor3 = Config.theme.tabs_frame.background_color
        tabs_frame.Position = UDim2.new(0, 15, 0, 49)
        tabs_frame.Size = UDim2.new(0, 0, 0, 0)

        tabs_frame_corner.Name = "tabs_frame_corner"
        tabs_frame_corner.Parent = tabs_frame

        tabs_frame_stroke.Color = Config.theme.tabs_frame.stroke_color
        tabs_frame_stroke.Thickness = 1.6
        tabs_frame_stroke.Name = "tabs_frame_stroke"
        tabs_frame_stroke.Parent = tabs_frame

        tabs_frame_container.Name = "tabs_frame_container"
        tabs_frame_container.Parent = tabs_frame
        tabs_frame_container.Active = true
        tabs_frame_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabs_frame_container.BackgroundTransparency = 1.000
        tabs_frame_container.BorderSizePixel = 0
        tabs_frame_container.Size = UDim2.new(0, 0, 0, 0)
        tabs_frame_container.SizeConstraint = Enum.SizeConstraint.RelativeYY
        tabs_frame_container.ScrollBarThickness = 7

        tabs_frame_container_list_layout.Name = "tabs_frame_container_list_layout"
        tabs_frame_container_list_layout.Parent = tabs_frame_container
        tabs_frame_container_list_layout.SortOrder = Enum.SortOrder.LayoutOrder

        tabs_frame_overlay.Name = "tabs_frame_overlay"
        tabs_frame_overlay.Parent = tabs_frame
        tabs_frame_overlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabs_frame_overlay.BackgroundTransparency = 0.7
        tabs_frame_overlay.BorderSizePixel = 0
        tabs_frame_overlay.Position = UDim2.new(0, 0, 0, 0)
        tabs_frame_overlay.Size = UDim2.new(0, 142, 0, 40)

        tabs_frame_overlay_corner.Name = "tabs_frame_overlay_corner"
        tabs_frame_overlay_corner.Parent = tabs_frame_overlay

        -- content frame --
        content_frame.Name = "content_frame"
        content_frame.Parent = base_frame
        content_frame.BackgroundColor3 = Config.theme.content_frame.background_color
        content_frame.Position = UDim2.new(0.345454544, 0, 0.0500000007, 0)
        content_frame.Size = UDim2.new(0, 0, 0, 0)

        content_frame_stroke.Color = Config.theme.content_frame.stroke_color
        content_frame_stroke.Thickness = 1.6
        content_frame_stroke.Name = "content_frame_stroke"
        content_frame_stroke.Parent = content_frame

        content_frame_corner.Name = "content_frame_corner"
        content_frame_corner.Parent = content_frame

        content_frame_container.Name = "content_frame_container"
        content_frame_container.Parent = content_frame
        content_frame_container.Active = true
        content_frame_container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        content_frame_container.BackgroundTransparency = 1.000
        content_frame_container.BorderSizePixel = 0
        content_frame_container.Size = UDim2.new(0, 0, 0, 0)
        content_frame_container.ScrollBarThickness = 7
        content_frame_container.AutomaticCanvasSize = Enum.AutomaticSize.Y

        content_frame_list_layout.Name = "content_frame_list_layout"
        content_frame_list_layout.Parent = content_frame_container
        content_frame_list_layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- UI functions --

    self.set_pos = function(x, y)
        base_frame.Position = UDim2.new(0, x, 0, y)
    end
    
    self.add_tab = function(name,icon)
        local tab = {}
        local elements = {}
        -- UI elements --
        local tab_frame = Instance.new("Frame")
        local tab_frame_corner = Instance.new("UICorner")
        local tab_icon = Instance.new("ImageLabel")
        local tab_name = Instance.new("TextLabel")
        local tab_button = Instance.new("TextButton")

        -- UI properties --
        tab_frame.Name = "tab_frame"
        tab_frame.Parent = tabs_frame_container
        tab_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tab_frame.BackgroundTransparency = 1.000
        tab_frame.Size = UDim2.new(0, 142, 0, 40)

        tab_frame_corner.Name = "tab_frame_corner"
        tab_frame_corner.Parent = tab_frame

        tab_icon.Name = "tab_icon"
        tab_icon.Parent = tab_frame
        tab_icon.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
        tab_icon.BackgroundTransparency = 1.000
        tab_icon.Size = UDim2.new(0, 40, 0, 40)
        tab_icon.Image = "http://www.roblox.com/asset/?id=" .. icon

        tab_name.Name = "tab_name"
        tab_name.Parent = tab_frame
        tab_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tab_name.BackgroundTransparency = 1.000
        tab_name.Position = UDim2.new(0.28169015, 0, 0, 0)
        tab_name.Size = UDim2.new(0, 102, 0, 40)
        tab_name.Font = Enum.Font.SourceSansBold
        tab_name.Text = name
        tab_name.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab_name.TextSize = 18.000

        tab_button.Name = "tab_button"
        tab_button.Parent = tab_frame
        tab_button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tab_button.BackgroundTransparency = 1.000
        tab_button.Size = UDim2.new(0, 142, 0, 40)
        tab_button.Font = Enum.Font.SourceSans
        tab_button.TextColor3 = Color3.fromRGB(0, 0, 0)
        tab_button.TextSize = 14.000
        tab_button.TextTransparency = 1.000

        -- Functions --

        tab.add = function(element)
            if element.init then
                element.init(self)
            end
            table.insert(elements,element)
            return element
        end

        tab.remove = function(element)
            for i,v in pairs(elements) do
                if v == element then
                    table.remove(elements,i)
                    element.destroy()
                    break
                end
            end
        end

        tab.destroy = function()
            tab_frame:Destroy()
            tab = nil
        end

        tab.getChildren = function()
            return elements
        end

        -- UI Events --

        tab_button.MouseButton1Click:Connect(function()

            selected_tab = tab

            tabs_frame_overlay:TweenPosition(UDim2.new(0,0,0,tab_frame.AbsolutePosition.Y - tabs_frame.AbsolutePosition.Y),"Out","Quad",0.2,true)

            -- remove all elements from content frame --
            for k,v in pairs(content_frame_container:GetChildren()) do
                if v:IsA("UIListLayout") then continue end
                v.Parent = nil
            end
            -- add elements to content frame --
            for k,v in pairs(elements) do
                v.set_parent(content_frame_container)
                v.set_visible(true)
            end
        end)

        -- draggable --

        local function update(input)
            local delta = input.Position - dragStart
            base_frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        base_frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = base_frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        base_frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)

        -- Initialize --

        table.insert(tabs,tab)
        
        return tab
    end

    self.add_popup = function(name)
        local popup = {}
        local dragInput
        local dragStart
        local startPos
        local dragging

        -- UI elements --
        local popup_frame = Instance.new("Frame")
        local popup_frame_corner = Instance.new("UICorner")
        local popup_frame_header = Instance.new("Frame")
        local popup_frame_header_fixed = Instance.new("Frame")
        local popup_frame_header_corner = Instance.new("UICorner")
        local popup_frame_header_name = Instance.new("TextLabel")

        -- UI properties --
        popup_frame.Name = "popup_frame"
        popup_frame.Parent = popup_frame_header
        popup_frame.BackgroundColor3 = Color3.fromRGB(41, 40, 40)
        popup_frame.Size = UDim2.new(0, 210, 0, 215)
        popup_frame.Position = UDim2.new(0, 0, 0, 20)

        popup_frame_corner.Name = "popup_frame_corner"
        popup_frame_corner.Parent = popup_frame

        popup_frame_header.Name = "popup_frame_header"
        popup_frame_header.Parent = base_frame
        popup_frame_header.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
        popup_frame_header.Size = UDim2.new(0, 210, 0, 30)
        popup_frame_header.Position = UDim2.new(0, base_frame.AbsoluteSize.X + 20, 0, 0)

        popup_frame_header_corner.Name = "popup_frame_header_corner"
        popup_frame_header_corner.Parent = popup_frame_header

        popup_frame_header_name.Name = "popup_frame_header_name"
        popup_frame_header_name.Parent = popup_frame_header
        popup_frame_header_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        popup_frame_header_name.BackgroundTransparency = 1.000
        popup_frame_header_name.Size = UDim2.new(0, 210, 0, 25)
        popup_frame_header_name.Font = Enum.Font.SourceSansBold
        popup_frame_header_name.Text = name
        popup_frame_header_name.TextColor3 = Color3.fromRGB(255, 255, 255)
        popup_frame_header_name.TextSize = 14.000
        popup_frame_header.Visible = false

        popup_frame_header_fixed.Name = "popup_frame_header_fixed"
        popup_frame_header_fixed.Parent = popup_frame
        popup_frame_header_fixed.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
        popup_frame_header_fixed.Size = UDim2.new(0, 210, 0, 5)
        popup_frame_header_fixed.Position = UDim2.new(0, 0, 0, 0)
        popup_frame_header_fixed.BorderSizePixel = 0

        -- Functions --

        popup.destroy = function()
            popup_frame_header:Destroy()
            popup = nil
        end

        popup.get_parent = function()
            return popup_frame
        end

        popup.set_visible = function(bool)
            popup_frame_header.Visible = bool
        end

        popup.set_position = function(x,y)
            popup_frame_header.Position = UDim2.new(0, x, 0, y)
        end

        -- draggable --

        local function update(input)
            local delta = input.Position - dragStart
            popup_frame_header.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        popup_frame_header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = popup_frame_header.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        popup_frame_header.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
        
        -- Initialize --

        table.insert(popups,popup)

        return popup
    end

    -- Search UI Events --

    search_icon.MouseButton1Click:Connect(function()
        if not searchToggle then
            search_frame:TweenSize(UDim2.new(0, 150, 0, 24),"Out","Quad",0.2,true)
            search_input:TweenSize(UDim2.new(0, 126, 0, 24),"Out","Quad",0.2,true)
            search_input:CaptureFocus()
        else
            search_frame:TweenSize(UDim2.new(0, 24, 0, 24),"Out","Quad",0.2,true)
            search_input:TweenSize(UDim2.new(0, 0, 0, 24),"Out","Quad",0.2,true)
            search_input.Text = ""
            search_input:ReleaseFocus()
        end
        searchToggle = not searchToggle
    end)

    -- On Text Changed --

    search_input:GetPropertyChangedSignal("Text"):Connect(function()
        local search = search_input.Text
        if search == "" then
            for i,v in pairs(tabs) do
                if v == selected_tab then
                    for i,v in pairs(v.getChildren()) do
                        v.set_visible(true)
                        v.set_parent(content_frame_container)
                    end
                else
                    for i,v in pairs(v.getChildren()) do
                        v.set_visible(false)
                        v.set_parent(nil)
                    end
                end
            end
        else
            for i,v in pairs(tabs) do
                for i,v in pairs(v.getChildren()) do
                    if string.find(string.lower(v.get_name()),string.lower(search)) then
                        v.set_visible(true)
                        v.set_parent(content_frame_container)
                    else
                        v.set_visible(false)
                        v.set_parent(nil)
                    end
                end
            end
        end
    end)

    self.init = function()
        -- show first tab elements --
        for k,v in pairs(tabs[1].getChildren()) do
            v.set_parent(content_frame_container)
            v.set_visible(true)
        end
    end

    self.toggle = function()
        tabs_mouse_override.Visible = not tabs_mouse_override.Visible
        UserInputService.MouseIconEnabled = tabs_mouse_override.Visible
    end

    self.get_size = function()
        return base_frame.AbsoluteSize
    end

    self.get_position = function()
        return base_frame.AbsolutePosition
    end

    self.get_tabs = function()
        return tabs
    end

    self.get_current_tab = function()
        return selected_tab
    end

    self.get_popups = function()
        return popups
    end

    self.remove_tab = function(tab)
        for i,v in pairs(tabs) do
            if v == tab then
                table.remove(tabs,i)
                tab.destroy()
                break
            end
        end
    end

    self.remove_popup = function(popup)
        for i,v in pairs(popups) do
            if v == popup then
                table.remove(popups,i)
                popup.destroy()
                break
            end
        end
    end

    self.set_save_name = function(name)
        SaveLibrary.set_save_name(name)
        SaveLibrary.load()
    end

    -- Initialize --
    TweenService:Create(base_frame,TweenInfo.new(Config.animation.open_time),{Size = UDim2.new(0, 550, 0, 300)}):Play()
    TweenService:Create(tabs_frame,TweenInfo.new(Config.animation.open_time),{Size = UDim2.new(0, 150, 0, 235)}):Play()
    TweenService:Create(tabs_frame_container,TweenInfo.new(Config.animation.open_time),{Size = UDim2.new(0, 150, 0, 235)}):Play()
    TweenService:Create(content_frame,TweenInfo.new(Config.animation.open_time),{Size = UDim2.new(0, 345, 0, 270)}):Play()
    TweenService:Create(content_frame_container,TweenInfo.new(Config.animation.open_time),{Size = UDim2.new(0, 345, 0, 270)}):Play()
    return self
end

return Library
