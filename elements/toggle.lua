local Library = {}

Library.new = function(name: string, default: boolean)
    local self = {}

    -- Variables --
    local status = SaveLibrary.get_saved_or_default(name, default)
    local callback = function() end

    -- UI objects --
    local toggle_frame = Instance.new("Frame")
    local toggle_name = Instance.new("TextLabel")
    local toggle_indicator_button = Instance.new("TextButton")
    local toggle_indicator_button_corner = Instance.new("UICorner")
    local toggle_status_image = Instance.new("ImageLabel")
    local toggle_status_corner = Instance.new("UICorner")

    -- UI properties --
    toggle_frame.Name = "toggle_frame"
    toggle_frame.Parent = nil
    toggle_frame.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
    toggle_frame.BackgroundTransparency = 0.700
    toggle_frame.Size = UDim2.new(0, 337, 0, 30)

    toggle_name.Name = "toggle_name"
    toggle_name.Parent = toggle_frame
    toggle_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggle_name.BackgroundTransparency = 1.000
    toggle_name.Size = UDim2.new(0, 110, 0, 30)
    toggle_name.Font = Enum.Font.SourceSansBold
    toggle_name.Text = name
    toggle_name.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle_name.TextSize = 15.000
    toggle_name.TextTruncate = Enum.TextTruncate.AtEnd

    toggle_indicator_button.Name = "toggle_indicator_button"
    toggle_indicator_button.Parent = toggle_frame
    toggle_indicator_button.BackgroundColor3 = Color3.fromRGB(121, 121, 121)
    toggle_indicator_button.Position = UDim2.new(0.543498516, 0, 0.133666992, 0)
    toggle_indicator_button.Size = UDim2.new(0, 40, 0, 20)
    toggle_indicator_button.Font = Enum.Font.SourceSans
    toggle_indicator_button.TextColor3 = Color3.fromRGB(0, 0, 0)
    toggle_indicator_button.TextSize = 14.000
    toggle_indicator_button.TextTransparency = 1.000

    toggle_indicator_button_corner.CornerRadius = UDim.new(0, 90)
    toggle_indicator_button_corner.Name = "toggle_indicator_button_corner"
    toggle_indicator_button_corner.Parent = toggle_indicator_button

    toggle_status_image.Name = "toggle_status_image"
    toggle_status_image.Parent = toggle_indicator_button
    toggle_status_image.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    toggle_status_image.BackgroundTransparency = 1.000
    toggle_status_image.Position = UDim2.new(0, 0, 0, 0)
    toggle_status_image.Size = UDim2.new(0, 20, 0, 20)
    toggle_status_image.Image = "http://www.roblox.com/asset/?id=6031068433"
    toggle_status_image.ImageColor3 = status and Color3.fromRGB(29, 255, 255) or Color3.fromRGB(255, 0, 0)

    toggle_status_corner.CornerRadius = UDim.new(1, 0)
    toggle_status_corner.Name = "toggle_status_corner"
    toggle_status_corner.Parent = toggle_status_image

    -- Functions --

    self.set_callback = function(func)
        callback = func
    end

    self.destroy = function()
        toggle_frame:Destroy()
        self = nil
    end
    
    self.update = function()
        TweenService:Create(toggle_status_image, TweenInfo.new(0.2), {Position = UDim2.new(status and 0.5 or 0, 0, 0, 0)}):Play()
        toggle_status_image.ImageColor3 = status and Color3.fromRGB(29, 255, 255) or Color3.fromRGB(255, 29, 29)
    end

    self.toggle = function()
        status = not status
        self.update()
        callback(status)
        SaveLibrary.save_value(name, status)
    end

    self.get = function() : boolean
        return status
    end

    self.set = function(value) : boolean
        status = value
        self.update()
        SaveLibrary.save_value(name, status)
    end
    
    self.get_name = function() : string
        return name
    end

    self.set_parent = function(parent)
        toggle_frame.Parent = parent
    end

    self.set_visible = function(value)
        toggle_frame.Visible = value
    end

    -- UI Events --

    toggle_indicator_button.MouseButton1Click:Connect(function()
        self.toggle()
    end)

    -- Initialization --

    self.set(status)

    return self
end

return Library