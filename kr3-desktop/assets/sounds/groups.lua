-- chunkname: @./kr3-desktop/assets/sounds/groups.lua
local z1 = require("assets.sounds." .. "1_groups")
local z2 = require("assets.sounds." .. "2_groups")
local z3 = require("assets.sounds." .. "3_groups")
local z4 = require("assets.sounds." .. "4_groups")
local z5 = require("assets.sounds." .. "5_groups")
local z6 = require("assets.sounds." .. "v_groups")

z1 = table.deepappend(z1,z2)
z1 = table.deepappend(z1,z3)
z1 = table.deepappend(z1,z5)
z1 = table.deepappend(z1,z4)
z1 = table.deepappend(z1,z6)

return z1
