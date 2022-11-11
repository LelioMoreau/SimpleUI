local Library = {}

Library.new = function(name: string, default: string)
    local self = {}

    -- Variables --
    local value = SaveLibrary.get_saved_or_default(name, default)
    local callback = function() end

    -- Objects --
    local text_input_frame = Instance.new("Frame")
    local text_input_name = Instance.new("TextLabel")
    local text_input_box = Instance.new("TextBox")
    local text_input_box_corner = Instance.new("UICorner")

    -- Properties --
    text_input_frame.Name = "text_input_frame"
    text_input_frame.Parent = nil
    text_input_frame.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
    text_input_frame.BackgroundTransparency = 0.700
    text_input_frame.Size = UDim2.new(0, 337, 0, 30)

    text_input_name.Name = "text_input_name"
    text_input_name.Parent = text_input_frame
    text_input_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    text_input_name.BackgroundTransparency = 1.000
    text_input_name.Size = UDim2.new(0, 110, 0, 30)
    text_input_name.Font = Enum.Font.SourceSansBold
    text_input_name.Text = name
    text_input_name.TextColor3 = Color3.fromRGB(255, 255, 255)
    text_input_name.TextSize = 15.000
    text_input_name.TextTruncate = Enum.TextTruncate.AtEnd

    text_input_box.Name = "text_input_box"
    text_input_box.Parent = text_input_frame
    text_input_box.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    text_input_box.Position = UDim2.new(0.406528205, 0, 0, 7.5)
    text_input_box.Size = UDim2.new(0, 135, 0, 15)
    text_input_box.Font = Enum.Font.SourceSans
    text_input_box.TextColor3 = Color3.fromRGB(0, 0, 0)
    text_input_box.TextSize = 14.000
    text_input_box.Text = value
    text_input_box.ClearTextOnFocus = false

    text_input_box_corner.Name = "text_input_box_corner"
    text_input_box_corner.Parent = text_input_box

    -- Functions --
    
    self.set_callback = function(func)
        callback = func
    end

    self.destroy = function()
        text_input_frame:Destroy()
    end
    
    self.get = function(): string
        return value
    end
    
    self.set = function(new_value: string)
        value = new_value
        text_input_box.Text = new_value
        SaveLibrary.save_value(name, new_value)
    end
    
    self.get_name = function() : string
        return name
    end
    
    self.set_parent = function(parent)
        text_input_frame.Parent = parent
    end
    
    self.set_visible = function(bool)
        text_input_frame.Visible = bool
    end

    -- Events --

    text_input_box.FocusLost:Connect(function(enter_pressed)
        if enter_pressed then
            value = text_input_box.Text
            callback(value)
            SaveLibrary.save_value(name, value)
        end
    end)

    return self
end

return Library