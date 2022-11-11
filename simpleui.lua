-- import roblox services --
local HttpService = game:GetService("HttpService")

-- Github release for last version.
local github = "https://api.github.com/repos/LelioMoreau/SimpleUI/releases/latest"

local function Set(tbl)
    local set = {}
    for _, v in pairs(tbl) do
        set[v] = true
    end
    return set
end

local base_files = Set {
    "index.lua", "config.lua", "save.lua"
}

local _M = {
    element = function(name: string)
        return loadfile("SimpleUI/elements/" .. name .. ".lua")()
    end,
    simpleUI = function()
        return loadfile("SimpleUI/index.lua")()
    end
}

local release = game:HttpGet(github)
local data = HttpService:JSONDecode(release)
local files = setmetatable({}, {
    __newindex = function(t, k, v)
        printconsole("Downloading " .. k, 0, 200, 255)
        rawset(t, k, game:HttGet(v))
    end
})

-- Check if the version is up to date.
if isfile("SimpleUI/manifest.txt") then
    local manifest = readfile("SimpleUI/manifest.txt")

    if manifest == data.id then
        return _M
    end
end

for index, value in pairs(data.assets) do
    local url = value.browser_download_url
    files[value.name] = url
end

makefolder("SimpleUI")
makefolder("SimpleUI/elements")

writefile("SimpleUI/manifest.txt", data.id)


for index, value in files do
    if base_files[index] then
        writefile("SimpleUI/" .. index, value)
    else
        writefile("SimpleUI/elements/" .. index, value)
    end
end

return _M