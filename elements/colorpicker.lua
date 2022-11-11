local Library = {}

Library.new = function(name: string, default: Color3)
    local self = {}

    -- Variables --
    local value = SaveLibrary.get_saved_or_default(name, default)
    local popup
    local ref
    local btn_text = false
    local callback = function() end
    
    -- UI objects --
    local colorpicker_frame = Instance.new("Frame")
    local colorpicker_name = Instance.new("TextLabel")
    local colorpicker_indicator_button = Instance.new("TextButton")
    local colorpicker_indicator_button_corner = Instance.new("UICorner")
    local colorpicker_popup_colorpicker = Instance.new("ImageButton")

    -- UI properties --

    colorpicker_frame.Name = "colorpicker_frame"
    colorpicker_frame.Parent = nil
    colorpicker_frame.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
    colorpicker_frame.BackgroundTransparency = 0.700
    colorpicker_frame.Size = UDim2.new(0, 337, 0, 30)
    
    colorpicker_name.Name = "colorpicker_name"
    colorpicker_name.Parent = colorpicker_frame
    colorpicker_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    colorpicker_name.BackgroundTransparency = 1.000
    colorpicker_name.Size = UDim2.new(0, 110, 0, 30)
    colorpicker_name.Font = Enum.Font.SourceSansBold
    colorpicker_name.Text = name
    colorpicker_name.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorpicker_name.TextSize = 15.000
    
    colorpicker_indicator_button.Name = "colorpicker_indicator_button"
    colorpicker_indicator_button.Parent = colorpicker_frame
    colorpicker_indicator_button.BackgroundColor3 = value
    colorpicker_indicator_button.Position = UDim2.new(0.575999975, 0, 0.166999996, 0)
    colorpicker_indicator_button.Size = UDim2.new(0, 20, 0, 20)
    colorpicker_indicator_button.Font = Enum.Font.SourceSans
    colorpicker_indicator_button.TextColor3 = Color3.fromRGB(0, 0, 0)
    colorpicker_indicator_button.TextSize = 14.000
    colorpicker_indicator_button.TextTransparency = 1.000
    
    colorpicker_indicator_button_corner.Name = "colorpicker_indicator_button_corner"
    colorpicker_indicator_button_corner.Parent = colorpicker_indicator_button

    colorpicker_popup_colorpicker.Name = "colorPickerImage"
    colorpicker_popup_colorpicker.Position = UDim2.new(0, 5, 0, 10)
    colorpicker_popup_colorpicker.Size = UDim2.new(0, 200, 0, 200)
    colorpicker_popup_colorpicker.BackgroundTransparency = 1
    colorpicker_popup_colorpicker.Image = "rbxassetid://6020299385"
    colorpicker_popup_colorpicker.ImageColor3 = Color3.fromRGB(255, 255, 255)
    colorpicker_popup_colorpicker.Parent = nil
    colorpicker_popup_colorpicker.Visible = true
    colorpicker_popup_colorpicker.ZIndex = 2

    -- Functions --

    self.set_callback = function(func)
        callback = func
    end
    
    self.destroy = function()
        colorpicker_frame:Destroy()
        popup.destroy()
        self = nil
    end

    self.init = function(simpleUI)
        ref = simpleUI
        popup = ref.add_popup(name)
        colorpicker_popup_colorpicker.Parent = popup.get_parent()
    end
    
    self.get = function(): table
        return value
    end
    
    self.set = function(new_value: table)
        value = new_value
        colorpicker_indicator_button.BackgroundColor3 = value
        SaveLibrary.save_value(name, value)
    end

    self.get_name = function() : string
        return name
    end

    self.set_parent = function(parent)
        colorpicker_frame.Parent = parent
    end

    self.set_visible = function(bool)
        colorpicker_frame.Visible = bool
    end

    -- Events --

    local function update()
        local mouse = game.Players.LocalPlayer:GetMouse()
        
        local centreOfWheel = Vector2.new(colorpicker_popup_colorpicker.AbsolutePosition.X + (colorpicker_popup_colorpicker.AbsoluteSize.X/2), colorpicker_popup_colorpicker.AbsolutePosition.Y + (colorpicker_popup_colorpicker.AbsoluteSize.Y/2))
        local colourPickerCentre = Vector2.new(mouse.X, mouse.Y)
        local h = (math.pi - math.atan2(colourPickerCentre.Y - centreOfWheel.Y, colourPickerCentre.X - centreOfWheel.X)) / (math.pi * 2)
        local s = (centreOfWheel - colourPickerCentre).Magnitude / (colorpicker_popup_colorpicker.AbsoluteSize.X/2)
        local v = 50
    
    
        local color = Color3.fromHSV(math.clamp(h, 0, 1), math.clamp(s, 0, 1), math.clamp(v, 0, 1))
        
        -- Set the color of the color frame
        colorpicker_indicator_button.BackgroundColor3 = color
        
        -- Set the value of the color picker
        value = color

        -- Call the callback
        callback(value)

        -- Save the value
        SaveLibrary.save_value(name, value)
    end

    colorpicker_popup_colorpicker.MouseButton1Down:Connect(function()
        -- on mouse move, update
        
        local selectingevent = LocalPlayer:GetMouse().Move:Connect(function(input)
            update()
        end)
        -- when mouse up
        local selfevent
        local selfevent2
        local function up()
            selectingevent:Disconnect()
            selfevent:Disconnect()
            selfevent2:Disconnect()
            selfevent = nil
            selfevent2 = nil
            popup.set_visible(false)
            btn_text = false
        end
        selfevent = LocalPlayer:GetMouse().Button1Up:Connect(up)
        selfevent2 = colorpicker_popup_colorpicker.MouseButton1Up:Connect(up)
        update()
    end)

    colorpicker_indicator_button.MouseButton1Down:Connect(function()
        popup.set_position(ref.get_size().X + 20, 0)
        popup.set_visible(not btn_text)
        btn_text = not btn_text
    end)

    return self
end

return Library
