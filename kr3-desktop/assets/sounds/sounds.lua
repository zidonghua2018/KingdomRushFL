-- chunkname: @./kr3-desktop/assets/sounds/sounds.lua

local z1 = require("assets.sounds." .. "1_sounds")
local z2 = require("assets.sounds." .. "2_sounds")
local z3 = require("assets.sounds." .. "3_sounds")
local z5 = require("assets.sounds." .. "5_sounds")
local z4 = require("assets.sounds." .. "4_sounds")
local z6 = require("assets.sounds." .. "v_sounds")
--local z4_pld = require("assets.sounds." .. "kr4_sounds")

z1 = table.deepmerge(z1,z2)
z1 = table.deepmerge(z1,z3)
z1 = table.deepmerge(z1,z5)
z1 = table.deepmerge(z1,z4)
z1 = table.deepmerge(z1,z6)
--z1 = table.deepmerge(z1,z4_pld)
return z1
