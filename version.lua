-- chunkname: @./version.lua
local v
if arg[2] == "debug" or arg[2] == "release" then
    v = "DEBUG"
else
    v = "RELEASE"
end

version = {}
version.identity = "kingdom_rush_origins"
version.title = "Kingdom Rush Origins"
version.bundle_id = "com.ironhidegames.origins.windows.steam"
version.string = "kr3-desktop-4.2.10"
version.string_short = "4.2.10"
version.vc = "kr3-desktop-4.2.10"
version.build = v
version.bundle_keywords = "-origins-windows-steam"
