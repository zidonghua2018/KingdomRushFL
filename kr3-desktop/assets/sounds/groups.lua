-- chunkname: @./kr3-desktop/assets/sounds/groups.lua
local z1 = require("assets.sounds." .. "1_groups")
local z2 = require("assets.sounds." .. "2_groups")
local z3 = require("assets.sounds." .. "3_groups")
local z4 = require("assets.sounds." .. "4_groups")
local z5 = require("assets.sounds." .. "5_groups")

z1 = table.deepappend(z1,z2)
z1 = table.deepappend(z1,z3)
z1 = table.deepappend(z1,z5)
z1 = table.deepappend(z1,z4)

return z1
