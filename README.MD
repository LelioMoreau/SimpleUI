
<div id="header" align="center">
    <h1 style="border-bottom: none;">SimpleUI Framework</h1>
    <img src="https://img.shields.io/badge/Version-1.0.1-blue.svg" alt="Version 1.0.1">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License MIT">
    <img src="https://img.shields.io/github/stars/LelioMoreau/SimpleUI?color=brightgreen&label=Stars" alt="Stars">
    <br><br>
</div>

> SimpleUI is a framework used to create simple user interfaces in roblox. It is designed to be easy to use and easy to understand. It is also designed to be easy to extend and modify.

Features 🤯
--------
* Easy to use.
* Easy to customize.
* Easy to extend.
* Easy to maintain.
* Easy to understand.
* Easy to use in other projects.

Test the menu 🤔
-------------
Execute this code to open an example.
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/LelioMoreau/SimpleUI/main/test_elements.lua"))()
```

Installation 📦
------------
Put this code at the start of your script.

```lua
local loader = loadstring(game:HttpGet("https://raw.githubusercontent.com/LelioMoreau/SimpleUI/main/simpleui.lua"))()
```

Getting started 🚀
-------------
> Create a new SimpleUI instance
```lua
local loader = loadfile("simpleui.lua")
local simpleui = loader.simpleUI()

local ui = simpleui.new()
```

> Create a new tab
```lua
local tab = ui.add_tab("Tab Name", "Tab Icon (roblox asset id)")
```

> Require elements
```lua
local button = loader.element("button")
local label = loader.element("label")
local textbox = loader.element("textbox")
local toggle = loader.element("toggle")
local dropdown = loader.element("dropdown")
local slider = loader.element("slider")
local colorpicker = loader.element("colorpicker")
```

> Create a new button
```lua
local example = tab.add(button.new("Button Name", "example"))

-- add a callback to the button
example.set_callback(function()
    print("button clicked!")
end)
```

> Get the value of a colorpicker
```lua
local example = tab.add(colorpicker.new("Colorpicker Name", Color3.fromRGB(255, 255, 255)))

-- get the value of the colorpicker
local value = example.get()
```

Elements 📚
--------
| Element | Description | Constructor |
| ------- | ----------- | ---------- |
| button | execute action on click | button.<span style="color:#eb11de">new</span>(name: <span style="color:#11eb53">string</span>, btnText: <span style="color:#11eb53">string</span>) |
| toggle | toggle a boolean value | toggle.<span style="color:#eb11de">new</span>(name: <span style="color:#11eb53">string</span>, default: <span style="color:#11eb53">bool</span>) |
| dropdown | select one option in a list of options | dropdown.<span style="color:#eb11de">new</span>(name: <span style="color:#11eb53">string</span>, options: <span style="color:#11eb53">&lt;string&gt;{}</span>, default: <span style="color:#11eb53">string</span>) |
| slider | select a number in range | slider.<span style="color:#eb11de">new</span>(name: <span style="color:#11eb53">string</span>, min: <span style="color:#11eb53">number</span>, max: <span style="color:#11eb53">number</span>, default: <span style="color:#11eb53">number</span>, decimals: <span style="color:#11eb53">number</span>) |
| textbox | enter a text input | textbox.<span style="color:#eb11de">new</span>(name: <span style="color:#11eb53">string</span>, default: <span style="color:#11eb53">string</span>) |
| keybind | execute action on key pressed | keybind.<span style="color:#eb11de">new</span>(name: <span style="color:#11eb53">string</span>, default: <span style="color:#11eb53">UserInputType</span> &#124; <span style="color:#11eb53">KeyCode</span>) |
| colorpicker | select a color with a color wheel | colorpicker.<span style="color:#eb11de">new</span>(name: <span style="color:#11eb53">string</span>, default: <span style="color:#11eb53">Color3</span>) |

Contributing 🤝
------------
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request :D

Common issues 🐛
-------------
> I get an error when I try to load the framework.
* Delete "**SimpleUI/manifest.txt**".
* Make sure you have the latest version of the framework. If you still get an error, please open an issue.

License 📜
-------
SimpleUI is licensed under the MIT license. See LICENSE for more information.
