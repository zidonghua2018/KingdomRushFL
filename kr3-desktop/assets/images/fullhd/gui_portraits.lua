--gui_portraits

local z1 = require("assets.images.fullhd." .. "gui_portraits_5")
local z2 = require("assets.images.fullhd." .. "gui_portraits_123")
local z3 = require("assets.images.fullhd." .. "gui_portraits_20251001")
local z4 = require("assets.images.fullhd." .. "gui_portraits_4")


local z={}
local count = 0
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

for k, v in pairs(z4) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end


return z
