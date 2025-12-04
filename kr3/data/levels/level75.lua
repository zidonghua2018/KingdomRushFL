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
		local spawner = E:create_entity("cursed_golem_spawner")
			LU.queue_insert(store, spawner)
			spawner.pos = V.v(745, 640)
		store.lives = 20
		local gold_factor_enemy = 1
			for _, t in pairs(E:filter_templates("enemy")) do
			if t.enemy.gold and gold_factor_enemy then
			t.enemy.gold = math.floor(t.enemy.gold * gold_factor_enemy)
			end
						end
			local coin = E:create_entity("button_steal_goblin_gold")
			LU.queue_insert(store, coin)
			coin.pos = V.v(923, 75)
			local bag = E:create_entity("decal_goldbag_bl")
			LU.queue_insert(store, bag)
			bag.pos = V.v(930, 75)
		end
		if store.level_mode == GAME_MODE_CAMPAIGN then
		while store.wave_group_number < 1 do
				coroutine.yield()
			end
			local bag = E:create_entity("decal_goldbag_bl")
			LU.queue_insert(store, bag)
			bag.pos = V.v(930, 75)
			U.animation_start(bag, "death", nil, store.tick_ts, false)
			local spark = E:create_entity("decal_spark_bl")
			LU.queue_insert(store, spark)
			spark.pos = V.v(930, 80)
		end
		if store.level_mode == GAME_MODE_HEROIC then
			local spawner = E:create_entity("cursed_golem_spawner")
			LU.queue_insert(store, spawner)
			spawner.pos = V.v(745, 640)
			local trash = E:create_entity("decal_trashcan_bl")
			LU.queue_insert(store, trash)
			trash.pos = V.v(510, 465)
			local tape = E:create_entity("decal_tape_bl")
			LU.queue_insert(store, tape)
			tape.pos = V.v(976, 158)
			local mark = E:create_entity("decal_mark_bl")
			LU.queue_insert(store, mark)
			mark.pos = V.v(774, 133)
			local dwarf = E:create_entity("decal_dwarf_bl")
			LU.queue_insert(store, dwarf)
			dwarf.pos = V.v(894, 90)
			local knight = E:create_entity("decal_knight_bl")
			LU.queue_insert(store, knight)
			knight.pos = V.v(1005, 77)
		end
		if store.level_mode == GAME_MODE_IRON then
		store.lives = 1
			local trash = E:create_entity("decal_trashcan_bl")
			LU.queue_insert(store, trash)
			trash.pos = V.v(510, 465)
			local tape = E:create_entity("decal_tape_bl")
			LU.queue_insert(store, tape)
			tape.pos = V.v(976, 158)
			local mark = E:create_entity("decal_mark_bl")
			LU.queue_insert(store, mark)
			mark.pos = V.v(774, 133)
			local dwarf = E:create_entity("decal_dwarf_bl")
			LU.queue_insert(store, dwarf)
			dwarf.pos = V.v(894, 90)
			local knight = E:create_entity("decal_knight_bl")
			LU.queue_insert(store, knight)
			knight.pos = V.v(1005, 77)
		local gold_factor_enemy = 0
			for _, t in pairs(E:filter_templates("enemy")) do
			if t.enemy.gold then
			t.enemy.gold = math.floor(t.enemy.gold * gold_factor_enemy)
			end
						end
			local coin = E:create_entity("button_steal_goblin_gold_iron")
			LU.queue_insert(store, coin)
			coin.pos = V.v(923, 75)
			local bag = E:create_entity("decal_goldbag_bl")
			LU.queue_insert(store, bag)
			bag.pos = V.v(930, 75)
			
			while store.wave_group_number < 1 do
				coroutine.yield()
			end
			
			local bag = E:create_entity("decal_goldbag_bl")
			LU.queue_insert(store, bag)
			bag.pos = V.v(930, 75)
			U.animation_start(bag, "death", nil, store.tick_ts, false)
			local spark = E:create_entity("decal_spark_bl")
			LU.queue_insert(store, spark)
			spark.pos = V.v(930, 80)
		end
		if store.level_mode == GAME_MODE_CAMPAIGN then
			while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
		U.y_wait(store, 3)
		local swap = E:create_entity("enemy_hobboss_swap")
		swap.pos.y = 542
		swap.pos.x = 653
		LU.queue_insert(store, swap)
		U.y_wait(store, 3.2)
		local e = E:create_entity("enemy_curse_aura")
		LU.queue_insert(store, e)
			e.pos = V.v(450, 740)
		local boss = E:create_entity("eb_hobgoblin_two")
		boss.pos.y = 562
		boss.pos.x = 653
		U.animation_start(boss, "death", nil, store.tick_ts, false)
		boss.nav_path.pi = 7
		boss.nav_path.spi = 1

		LU.queue_insert(store, boss)

		self.boss = boss
	
		while self.boss.phase ~= "death-end" do
			coroutine.yield()
		end
		
		local white = E:create_entity("decal_whiteness")
		white.pos.y = 465
		white.pos.x = 510
		LU.queue_insert(store, white)
		
		store.custom_game_outcome = {
			next_item_name = "kr1_fa"
		}
		
		return 
		end
end
}

return level
