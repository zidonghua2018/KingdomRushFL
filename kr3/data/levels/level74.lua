local log = require("klua.log"):new("level21")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils")
local LU = require("level_utils")
local V = require("klua.vector")
local P = require("path_db")

require("constants")

local function fts(v)
	return v/FPS
end

local level = {
	update = function (self, store)
		if store.level_mode == GAME_MODE_CAMPAIGN then
		store.lives = 20
		local gold_factor_enemy = 1
			for _, t in pairs(E:filter_templates("enemy")) do
			if t.enemy.gold and gold_factor_enemy then
			t.enemy.gold = math.floor(t.enemy.gold * gold_factor_enemy)
			end
			end
			
			if store.level_mode == GAME_MODE_CAMPAIGN then
			P:deactivate_path(4)
			P:deactivate_path(5)
			while store.wave_group_number < 8 do
				coroutine.yield()
			end
			P:activate_path(4)
			P:activate_path(5)
			P:deactivate_path(9)
			local lumberjack = E:create_entity("decal_bridge_bl")
			LU.queue_insert(store, lumberjack)
			lumberjack.pos = V.v(10, 490)
			U.animation_start(lumberjack, "open", nil, store.tick_ts, false)
		end

		return 
	end
	if store.level_mode == GAME_MODE_HEROIC or store.level_mode == GAME_MODE_IRON then
		store.lives = 1
		local gold_factor_enemy = 1
			for _, t in pairs(E:filter_templates("enemy")) do
			if t.enemy.gold and gold_factor_enemy then
			t.enemy.gold = math.floor(t.enemy.gold * gold_factor_enemy)
			end
			end
			
			if store.level_mode == GAME_MODE_HEROIC or store.level_mode == GAME_MODE_IRON then
			P:deactivate_path(4)
			P:deactivate_path(5)
			P:activate_path(4)
			P:activate_path(5)
			P:deactivate_path(9)
			local lumberjack = E:create_entity("decal_bridge_bl")
			LU.queue_insert(store, lumberjack)
			lumberjack.pos = V.v(10, 490)
			U.animation_start(lumberjack, "close", nil, store.tick_ts, false)
		end

		return 
	end
end
}

return level
