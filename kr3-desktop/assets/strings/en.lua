-- chunkname: @./kr3-desktop/assets/strings/zh-Hans.lua

local z1 = require("assets.strings." .. "en_1")
local z2 = require("assets.strings." .. "en_2")
local z3 = require("assets.strings." .. "en_3")
--local z4 = require("assets.strings." .. "en_4")
local z5 = require("assets.strings." .. "en_5")
local z={}
local count = 0



for k, v in pairs(z5) do
	z[k] = v
end

for k, v in pairs(z1) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end
--[[
for k, v in pairs(z4) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end
]]--
for k, v in pairs(z2) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z3) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

z["BUTTON_NEXT_PAGE"] = "Next Page"
z["Rush"] = "Rush"
z["Frontier"] = "Frontier"
z["Origin"] = "Origin"
z["SETTINGS_MAX_THREADS"] = "Max threads"
z["TOWER_G45_PICK"] = "pick=%i"
z["MAGIC_ARMOR_DESC"] = "magicarmor"

return z