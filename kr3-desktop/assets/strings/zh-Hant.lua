-- chunkname: @./kr3-desktop/assets/strings/zh-Hans.lua

local z1 = require("assets.strings." .. "zh-Hant_1")
local z2 = require("assets.strings." .. "zh-Hant_2")
local z3 = require("assets.strings." .. "zh-Hant_3")
--local z4 = require("assets.strings." .. "zh-Hant_4")
local z5 = require("assets.strings." .. "zh-Hant_5")
local z={}
local count = 0

for k, v in pairs(z5) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z1) do
	z[k] = v
end

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

z["BUTTON_NEXT_PAGE"] = "下一頁"
z["Rush"] = "守衛軍"
z["Frontier"] = "前線"
z["Origin"] = "起源"
z["SETTINGS_MAX_THREADS"] = "最大綫程數"
z["TOWER_G45_PICK"] = "pick=%i"

return z
