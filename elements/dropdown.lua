local TweenService = game:GetService("TweenService")
local Library = {}

Library.new = function(name, options, default)
    local self = {}

    -- Variables --
    local selected = SaveLibrary.get_saved_or_default(name, default)
    local selecting
    local callback = function() end

    -- UI objects --
    local dropdown_frame = Instance.new("Frame")
    local dropdown_name = Instance.new("TextLabel")
    local dropdown_select_button = Instance.new("TextButton")
    local dropdown_select_button_corner = Instance.new("UICorner")
    local dropdown_select_indicator_icon = Instance.new("ImageLabel")

    -- UI properties --
    dropdown_frame.Name = "dropdown_frame"
    dropdown_frame.Parent = nil
    dropdown_frame.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
    dropdown_frame.BackgroundTransparency = 0.700
    dropdown_frame.Size = UDim2.new(0, 337, 0, 30)

    dropdown_name.Name = "dropdown_name"
    dropdown_name.Parent = dropdown_frame
    dropdown_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dropdown_name.BackgroundTransparency = 1.000
    dropdown_name.Size = UDim2.new(0, 110, 0, 30)
    dropdown_name.Font = Enum.Font.SourceSansBold
    dropdown_name.Text = "Dropdown"
    dropdown_name.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown_name.TextSize = 15.000
    dropdown_name.TextTruncate = Enum.TextTruncate.AtEnd

    dropdown_select_button.Name = "dropdown_select_button"
    dropdown_select_button.Parent = dropdown_frame
    dropdown_select_button.BackgroundColor3 = Color3.fromRGB(121, 121, 121)
    dropdown_select_button.Position = UDim2.new(0.407000005, 0, 0, 5)
    dropdown_select_button.Size = UDim2.new(0, 135, 0, 20)
    dropdown_select_button.Font = Enum.Font.SourceSans
    dropdown_select_button.Text = selected
    dropdown_select_button.TextColor3 = Color3.fromRGB(0, 0, 0)
    dropdown_select_button.TextSize = 14.000
    dropdown_select_button.ZIndex = 2

    dropdown_select_button_corner.Name = "dropdown_select_button_corner"
    dropdown_select_button_corner.Parent = dropdown_select_button

    dropdown_select_indicator_icon.Name = "dropdown_select_indicator_icon"
    dropdown_select_indicator_icon.Parent = dropdown_select_button
    dropdown_select_indicator_icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dropdown_select_indicator_icon.BackgroundTransparency = 1.000
    dropdown_select_indicator_icon.Position = UDim2.new(0.844444454, 0, 0, 0)
    dropdown_select_indicator_icon.Size = UDim2.new(0, 20, 0, 20)
    dropdown_select_indicator_icon.Image = "http://www.roblox.com/asset/?id=6031091004"
    dropdown_select_indicator_icon.Rotation = 0

    -- Functions --

    self.set_callback = function(func)
        callback = func
    end

    self.destroy = function()
        dropdown_frame:Destroy()
        self = nil
    end

    self.toggle = function()
        if selecting then
            TweenService:Create(dropdown_frame, TweenInfo.new(0.2), {Size = UDim2.new(0, 337, 0, 30)}):Play()
            for k,v in pairs(dropdown_frame:GetChildren()) do
                if v.Name ~= "option" then continue end
                TweenService:Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 1, Visible = false, Position = UDim2.new(0.407000005, 0, 0, 0)}):Play()
            end
            TweenService:Create(dropdown_select_indicator_icon, TweenInfo.new(0.2), {Rotation = 0}):Play()
            selecting = false
        else
            TweenService:Create(dropdown_frame, TweenInfo.new(0.2), {Size = UDim2.new(0, 337, 0, 30 + (#options * 25))}):Play()
            for k,v in pairs(dropdown_frame:GetChildren()) do
                if v.Name ~= "option" then continue end
                TweenService:Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 0, Visible = true, Position = UDim2.new(0.407000005, 0, 0, -30 + (k * 22))}):Play()
            end
            TweenService:Create(dropdown_select_indicator_icon, TweenInfo.new(0.2), {Rotation = 90}):Play()
            selecting = true
        end
    end

    self.update = function()
        dropdown_select_button.Text = selected
        callback(selected)
        SaveLibrary.save_value(name, selected)
    end

    self.get = function() : string
        return selected
    end

    self.set = function(value: string)
        selected = value
        self.update()
    end

    self.get_name = function() : string
        return name
    end

    self.set_parent = function(parent)
        dropdown_frame.Parent = parent
    end

    self.set_visible = function(bool)
        dropdown_frame.Visible = bool
    end

    -- UI Events --

    dropdown_select_button.MouseButton1Click:Connect(function()
        self.toggle()
    end)

    -- Add options --

    for i, v in pairs(options) do
        local option = Instance.new("TextButton")
        local option_corner = Instance.new("UICorner")

        option.Name = "option"
        option.Parent = dropdown_frame
        option.BackgroundColor3 = Color3.fromRGB(121, 121, 121)
        option.Position = UDim2.new(0.407000005, 0, 0, 10 + (i * 22))
        option.Size = UDim2.new(0, 135, 0, 20)
        option.Font = Enum.Font.SourceSans
        option.Text = v
        option.TextColor3 = Color3.fromRGB(0, 0, 0)
        option.TextSize = 14.000
        option.Visible = false

        option_corner.Name = "option_corner"
        option_corner.Parent = option

        option.MouseButton1Click:Connect(function()
            selected = v
            self.update()
            self.toggle()
        end)
    end

    return self
end

return Library