local loader
if isfile("simpleui.lua") then
    loader = loadfile("simpleui.lua")()
else
    loader = loadstring(game:HttpGet("https://raw.githubusercontent.com/LelioMoreau/SimpleUI/main/simpleui.lua?t="..os.time()))()
end

-- create new simpleUI instance --
local simpleui = loader.simpleUI()

-- create new window --
local ui = simpleui.new()

-- load ui elements --
local button = loader.element("button")
local textbox = loader.element("textbox")
local toggle = loader.element("toggle")
local dropdown = loader.element("dropdown")
local slider = loader.element("slider")
local colorpicker = loader.element("colorpicker")

-- set config file name and load save system --
ui.set_save_name("my_exemple_menu.json")

-- create new tabs --
local tab = ui.add_tab("Tab Name", "6026568213")
local tab2 = ui.add_tab("Other Tab", "6031229361")

-- create ui elements --

local example_btn = tab.add(button.new("My Button", "button"))
local example_txt = tab.add(textbox.new("My Textbox", ""))
local example_tgl = tab.add(toggle.new("My Toggle"))

local example_colorpicker = tab2.add(colorpicker.new("My Colorpicker", Color3.fromRGB(255, 255, 255)))
local example_slider = tab2.add(slider.new("My Slider", 0, 100, 50))
local example_dropdown = tab2.add(dropdown.new("My Dropdown", {"Option 1", "Option 2", "Option 3", "Fish 🐟"}, "Option 2"))


-- set ui element properties --
example_btn.set_callback(function()
    print("button clicked!")
end)

example_txt.set_callback(function(text)
    print("textbox text changed to: " .. text)
end)

example_tgl.set_callback(function(toggled)
    print("toggle toggled to: " .. tostring(toggled))
end)

example_colorpicker.set_callback(function(color)
    print("colorpicker color changed to: " .. tostring(color))
end)

example_slider.set_callback(function(value)
    print("slider value changed to: " .. tostring(value))
end)

example_dropdown.set_callback(function(value)
    print("dropdown value changed to: " .. tostring(value))
end)

-- load first tab by default --
ui.init()
