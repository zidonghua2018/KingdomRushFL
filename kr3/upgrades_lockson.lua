-- chunkname: @./kr3/upgrades.lua

local log = require("klua.log"):new("upgrades")
local km = require("klua.macros")
local E = require("entity_db")
local bit = require("bit")
local balance = require("balance/balance")
local storage = require("storage")
local bor = bit.bor
local scripts = require("upgrade_scripts3")

require("constants")

local function T(name)
	return E:get_template(name)
end

local function fts(v)
	return v / FPS
end

local epsilon = 1e-09
local upgrades_lockson = {}


function upgrades_lockson:enhancecreeps()

end


return upgrades_lockson