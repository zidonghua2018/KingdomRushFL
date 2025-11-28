-- chunkname: @/var/folders/r9/xbxmw8n51957gv9ggzrytvf80000gp/T/com.ironhidegames.frontiers.windows.steam.ep3S4swo/kr2/data/levels/level82.lua

local log = require("klua.log"):new("level82")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils")
local LU = require("level_utils")
local V = require("klua.vector")
local P = require("path_db")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {}

function level:load(store)
	return
end

function level:update(store)
	while store.wave_group_number < 1 do
		coroutine.yield()
	end

	while true do
		coroutine.yield()
	end
end

return level
