local Library = {}

Library.new = function(name: string, default: any)
    local self = {}

    -- Variables --
    local value = SaveLibrary.get_saved_or_default(name, default)
    local down = false
    local waitingForInput = false
    local is_pressed = false
    local mouse = LocalPlayer:GetMouse()
    local callback = function() end

    -- UI objects --
    local keybind_frame = Instance.new("Frame")
    local keybind_name = Instance.new("TextLabel")
    local keybind_button = Instance.new("TextButton")
    local keybind_button_corner = Instance.new("UICorner")

    -- UI properties --
    keybind_frame.Name = "keybind_frame"
    keybind_frame.Parent = nil
    keybind_frame.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
    keybind_frame.BackgroundTransparency = 0.700
    keybind_frame.Size = UDim2.new(0, 337, 0, 30)

    keybind_name.Name = "keybind_name"
    keybind_name.Parent = keybind_frame
    keybind_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    keybind_name.BackgroundTransparency = 1.000
    keybind_name.Size = UDim2.new(0, 110, 0, 30)
    keybind_name.Font = Enum.Font.SourceSansBold
    keybind_name.Text = name
    keybind_name.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybind_name.TextSize = 15.000
    keybind_name.TextTruncate = Enum.TextTruncate.AtEnd

    keybind_button.Name = "keybind_button"
    keybind_button.Parent = keybind_frame
    keybind_button.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
    keybind_button.Position = UDim2.new(0.406528205, 0, 0, 7.5)
    keybind_button.Size = UDim2.new(0, 135, 0, 15)
    keybind_button.Font = Enum.Font.SourceSans
    keybind_button.TextColor3 = Color3.fromRGB(0, 0, 0)
    keybind_button.TextSize = 14.000
    keybind_button.Text = "[ "..value.Name.." ]"

    keybind_button_corner.Name = "keybind_button_corner"
    keybind_button_corner.Parent = keybind_button

    -- Functions --
    
    self.set_callback = function(func)
        callback = func
    end

    self.destroy = function()
        keybind_frame:Destroy()
    end
    
    self.get = function(): boolean
        return is_pressed
    end
    
    self.set = function(key: Enum.UserInputType | Enum.KeyCode)
        value = key
        keybind_button.Text = key.Name
    end

    self.get_name = function() : string
        return name
    end
    
    self.set_parent = function(parent)
        keybind_frame.Parent = parent
    end

    self.set_visible = function(bool)
        keybind_frame.Visible = bool
    end

    -- UI Events --

    keybind_button.MouseButton1Click:Connect(function()
        down = true
    end)

    UserInputService.InputEnded:Connect(function(input,gp)
        if down then
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                keybind_button.Text = "[ waiting ]"
                down = false
                waitingForInput = true
            end
        else
            if waitingForInput then
                if input.KeyCode.Name == "Unknown" then
                    value = input.UserInputType
                else
                    if input.KeyCode == Enum.KeyCode.Escape then
                        value = nil
                        waitingForInput = false
                        keybind_button.Text = "[ ... ]"
                        return
                    else
                        value = input.KeyCode
                    end
                end
                keybind_button.Text = "[ "..value.Name.." ]"
                waitingForInput = false
                SaveLibrary.save_value(name, value)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(key)
        if not down and not waitingForInput then
            if key.KeyCode == value then
                is_pressed = false
            end
            if key.UserInputType == value then
                is_pressed = false
            end
        end
    end)

    UserInputService.InputBegan:Connect(function(key)
        if not down and not waitingForInput then
            if key.KeyCode == value then
                callback(value)
                is_pressed = true
            end
            if key.UserInputType == value then
                if keybind_button.Visible then
                    local buttonx = keybind_button.AbsolutePosition.X + keybind_button.AbsoluteSize.X
                    local buttony = keybind_button.AbsolutePosition.Y + keybind_button.AbsoluteSize.Y
                    if mouse.X > keybind_button.AbsolutePosition.X and mouse.X < buttonx and mouse.Y > keybind_button.AbsolutePosition.Y and mouse.Y < buttony then
                        return
                    end
                end
                callback(value)
                is_pressed = true
            end
        end
    end)

    return self
end

return Library