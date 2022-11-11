local Library = {}

Library.new = function(name: string, min: number, max: number, default: number, decimals: number | nil) : table
    local self = {}

    -- Variables --
    local value = SaveLibrary.get_saved_or_default(name, default)
    local callback = function() end
    local dragging
    local mouse = Players.LocalPlayer:GetMouse()

    -- UI objects --
    local slider_frame = Instance.new("Frame")
    local slider_name = Instance.new("TextLabel")
    local slider_bar_frame = Instance.new("Frame")
    local slider_bar_frame_corner = Instance.new("UICorner")
    local slider_select_button = Instance.new("TextButton")
    local slider_select_button_corner = Instance.new("UICorner")
    local slider_value_input = Instance.new("TextBox")
    local slider_value_input_corner = Instance.new("UICorner")

    -- UI properties --
    slider_frame.Name = "slider_frame"
    slider_frame.Parent = nil
    slider_frame.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
    slider_frame.BackgroundTransparency = 0.700
    slider_frame.Size = UDim2.new(0, 337, 0, 30)

    slider_name.Name = "slider_name"
    slider_name.Parent = slider_frame
    slider_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    slider_name.BackgroundTransparency = 1.000
    slider_name.Size = UDim2.new(0, 110, 0, 30)
    slider_name.Font = Enum.Font.SourceSansBold
    slider_name.Text = name
    slider_name.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider_name.TextSize = 15.000
    slider_name.TextTruncate = Enum.TextTruncate.AtEnd

    slider_bar_frame.Name = "slider_bar_frame"
    slider_bar_frame.Parent = slider_frame
    slider_bar_frame.BackgroundColor3 = Color3.fromRGB(121, 121, 121)
    slider_bar_frame.Position = UDim2.new(0.406528205, 0, 0.400000006, 0)
    slider_bar_frame.Size = UDim2.new(0, 135, 0, 5)

    slider_bar_frame_corner.Name = "slider_bar_frame_corner"
    slider_bar_frame_corner.Parent = slider_bar_frame

    slider_select_button.Name = "slider_select_button"
    slider_select_button.Parent = slider_bar_frame
    slider_select_button.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
    slider_select_button.Position = UDim2.new(0.5, -3, 0, -7)
    slider_select_button.Size = UDim2.new(0, 6, 0, 20)
    slider_select_button.Font = Enum.Font.SourceSans
    slider_select_button.TextColor3 = Color3.fromRGB(0, 0, 0)
    slider_select_button.TextSize = 14.000
    slider_select_button.TextTransparency = 1.000

    slider_select_button_corner.Name = "slider_select_button_corner"
    slider_select_button_corner.Parent = slider_select_button

    slider_value_input.Name = "slider_value_input"
    slider_value_input.Parent = slider_frame
    slider_value_input.BackgroundColor3 = Color3.fromRGB(121, 121, 121)
    slider_value_input.Position = UDim2.new(0.860000014, 0, 0.13333334, 0)
    slider_value_input.Size = UDim2.new(0, 30, 0, 21)
    slider_value_input.Font = Enum.Font.SourceSans
    slider_value_input.Text = tostring(value)
    slider_value_input.TextColor3 = Color3.fromRGB(0, 0, 0)
    slider_value_input.TextSize = 14.000

    slider_value_input_corner.Name = "slider_value_input_corner"
    slider_value_input_corner.Parent = slider_value_input

    -- Functions --

    self.set_callback = function(func)
        callback = func
    end

    self.destroy = function()
        slider_frame:Destroy()
        self = nil
    end

    self.round = function(num, numDecimalPlaces)
        return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
    end

    self.update = function()
        local percent = (value - min) / (max - min)
        TweenService:Create(slider_select_button, TweenInfo.new(0.1), {Position = UDim2.new(percent, -3, 0, -7)}):Play()
        slider_value_input.Text = tostring(value)
    end

    self.get = function() : number
        return value
    end

    self.set = function(val: number)
        value = self.round(val, decimals)
        if value ~= val then
            self.update()
            callback(value)
            SaveLibrary.save_value(name, value)
        end
    end

    self.get_name = function() : string
        return name
    end

    self.set_parent = function(parent)
        slider_frame.Parent = parent
    end

    self.set_visible = function(value)
        slider_frame.Visible = value
    end

    -- UI events --

    slider_select_button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    slider_select_button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    slider_value_input.Changed:Connect(function()
        local val = tonumber(slider_value_input.Text)
        if val then
            local newvalue = math.clamp(val, min, max)
            self.set(newvalue)
        end
    end)

    game.Players.LocalPlayer:GetMouse().Move:Connect(function()
        if dragging then
            local percent = (mouse.X - slider_bar_frame.AbsolutePosition.X) / slider_bar_frame.AbsoluteSize.X
            local new_value = math.clamp(min + (max - min) * percent, min, max)
            self.set(new_value)
        end
    end)

    -- Initialization --

    self.set(value)

    return self
end

return Library