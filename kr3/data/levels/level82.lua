-- chunkname: @./kr3/data/levels/level82.lua

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

	local boss = LU.list_entities(store.entities, "eb_ainyl")[1]

	boss.phase_signal = "battle"

	while true do
		coroutine.yield()
	end
end

return level
