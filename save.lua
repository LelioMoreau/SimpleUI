-- import roblox services --
local HttpService = game:GetService("HttpService")

local save_folder = "SimpleUI/Saves/"

local Library = {}

Library._SaveTab = {}
Library._AutoSave = true

Library.save = function()
    if Library._ScriptSaveName == "" then return end

    for k,v in pairs(Library._SaveTab) do
        if typeof(v) == "Color3" then
            Library._SaveTab[k] = { _type = "Color3", R = v.R, G = v.G, B = v.B }
        end
        if typeof(v) == "EnumItem" then
            local st = string.split(tostring(v), ".")
            Library._SaveTab[k] = { _type = "EnumItem", n = st[#st], p = st[#st - 1] }
        end
    end
    
    local json = HttpService:JSONEncode(Library._SaveTab)
    if not isfolder(save_folder) then
        makefolder(save_folder)
    end
    writefile(save_folder .. Library._ScriptSaveName, json)
end

Library.get_saved_or_default = function(name, default)
    if typeof(default) == "Color3" then
        return default
    end
    if Library._SaveTab[name] ~= nil then
        if type(Library._SaveTab[name]) == "table" then
            local t = Library._SaveTab[name]
            if t._type == "Color3" then
                return Color3.fromHSV(t.R, t.G, t.B)
            end
            if t._type == "EnumItem" then
                return Enum[t.p][t.n]
            end
        end
        return Library._SaveTab[name]
    end
    return default
end

Library.load = function()
    if Library._ScriptSaveName ~= "" then
        if isfolder(save_folder) and isfile(save_folder .. Library._ScriptSaveName) then
            Library._SaveTab = HttpService:JSONDecode(readfile(save_folder .. Library._ScriptSaveName))
        end
    end
end

Library.set_save_name = function(name)
    Library._ScriptSaveName = name
end

Library.save_value = function(name, value)
    Library._SaveTab[name] = value
    if Library._AutoSave then
        Library.save()
    end
end


return Library