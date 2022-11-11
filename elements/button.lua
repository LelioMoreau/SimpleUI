local Library = {}

Library.new = function(name: string, btnText: string)
    local self = {}

    -- Variables --
    local callback = function() end

    -- UI objects --
    local button_frame = Instance.new("Frame")
    local button_name = Instance.new("TextLabel")
    local button_button = Instance.new("TextButton")
    local button_button_corner = Instance.new("UICorner")

    -- UI properties --
    button_frame.Name = "button_frame"
    button_frame.Parent = nil
    button_frame.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
    button_frame.BackgroundTransparency = 0.700
    button_frame.Size = UDim2.new(0, 337, 0, 30)

    button_name.Name = "button_name"
    button_name.Parent = button_frame
    button_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button_name.BackgroundTransparency = 1.000
    button_name.Size = UDim2.new(0, 110, 0, 30)
    button_name.Font = Enum.Font.SourceSansBold
    button_name.Text = name
    button_name.TextColor3 = Color3.fromRGB(255, 255, 255)
    button_name.TextSize = 15.000
    button_name.TextTruncate = Enum.TextTruncate.AtEnd

    button_button.Name = "button_button"
    button_button.Parent = button_frame
    button_button.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
    button_button.Position = UDim2.new(0.406528205, 0, 0, 7.5)
    button_button.Size = UDim2.new(0, 135, 0, 15)
    button_button.Font = Enum.Font.SourceSans
    button_button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button_button.TextSize = 14.000
    button_button.Text = btnText

    button_button_corner.Name = "button_button_corner"
    button_button_corner.Parent = button_button

    -- Functions --

    self.set_callback = function(func: () -> ())
        callback = func
    end

    self.destroy = function()
        button_frame:Destroy()
    end

    self.get_name = function() : string
        return name
    end

    self.set_parent = function(parent)
        button_frame.Parent = parent
    end

    self.set_visible = function(bool)
        button_frame.Visible = bool
    end

    -- UI Events --
    button_button.MouseButton1Click:Connect(function()
        callback()
    end)

    return self
end

return Library
