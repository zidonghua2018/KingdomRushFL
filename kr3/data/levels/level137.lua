-- chunkname: @./kr5/data/levels/level37.lua

local log = require("klua.log"):new("level01")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils_57")
local LU = require("level_utils")
local V = require("klua.vector")
local P = require("path_db")
local storage = require("storage")
local GR = require("grid_db")

require("constants")

local function fts(v)
	return v / FPS
end

local hero_index, selected_hero
local level = {}

function level:preprocess(store)
	return
end

--[[
function level:load(store)
	for i, h in pairs(store.selected_team) do
		if h == "hero_dragon_sun" then
			selected_hero = h
			hero_index = i

			break
		end
	end

	if not selected_hero then
		selected_hero = store.selected_team[1]
		hero_index = 1
	end

	if hero_index ~= 1 then
		store.level.custom_spawn_pos[hero_index].pos.x = 61
		store.level.custom_spawn_pos[hero_index].pos.y = 555
		store.level.custom_spawn_pos[1].pos.x = -70
		store.level.custom_spawn_pos[1].pos.y = 296
	end

	for pi = 1, 4 do
		P:add_invalid_range(pi, 0, 22)
	end
end
]]

function level:load(store)
	map_data = require("data.map_data")
	local hero_data = map_data.hero_data
	if screen_map.user_data.liuhui_hero.usedoublehero then
		selected_hero = hero_data[screen_map.user_data.liuhui_hero.herolist[1]].name
	else
		selected_hero = store.selected_hero
	end
	print("selected_hero:"..selected_hero)

		store.level.custom_spawn_pos[1].pos.x = 61
		store.level.custom_spawn_pos[1].pos.y = 555
		store.level.custom_spawn_pos[1].pos.x = -70
		store.level.custom_spawn_pos[1].pos.y = 296

	for pi = 1, 4 do
		P:add_invalid_range(pi, 0, 22)
	end
end

function level:update(store)
	local hero
	if not store.main_hero and not store.level.manual_hero_insertion then
		local user_data = storage:load_slot()
		--插入默认英雄。这里判定是否进入双英雄系统
		map_data = require("data.map_data")
		local hero_data = map_data.hero_data
		if (not user_data.liuhui_hero) or (not user_data.liuhui_hero.usedoublehero) then
			hero = LU.insert_hero(store)
		else
			name1 = hero_data[user_data.liuhui_hero.herolist[1]].name
			name2 = hero_data[user_data.liuhui_hero.herolist[2]].name
			hero = LU.insert_double_hero(store, name1, name2)
		end
		print("level 137 insert hero")
	else
		print("level 137 hero have already inserted")
	end
	if store.level_mode == GAME_MODE_CAMPAIGN then
		self.bossfight_ended = false

		local controller_boss_prefight

		for _, e in pairs(store.entities) do
			if e.template_name == "controller_stage_37_dragon_boss" then
				controller_boss_prefight = e
			end
		end

		local function y_do_boss_taunt(key)
			while controller_boss_prefight.current_taunt do
				coroutine.yield()
			end

			controller_boss_prefight.do_taunt = key

			while controller_boss_prefight.last_taunt ~= key do
				coroutine.yield()
			end
		end

		if not store.restarted and not main.params.skip_cutscenes then
			--[[
			local hero

			for _, e in pairs(store.entities) do
				if e.template_name == selected_hero then
					hero = e

					break
				end
			end
			]]

			hero.nav_grid.waypoints = {}

			local hero_path = 1
			local hero_subpath = 1
			local hero_move_start_node = P:nearest_nodes(61, 555, {
				hero_path
			}, {
				hero_subpath
			}, false)[1]
			local hero_move_end_node = P:nearest_nodes(420, 450, {
				hero_path
			}, {
				hero_subpath
			}, false)[1]
			local hero_end_pos = P:node_pos(hero_path, hero_subpath, hero_move_end_node[3])

			for ni = hero_move_start_node[3], hero_move_end_node[3], -3 do
				local pos = P:node_pos(hero_path, hero_subpath, ni)

				table.insert(hero.nav_grid.waypoints, pos)
			end

			hero.nav_rally.new = true
			hero.nav_rally.center = V.vclone(hero.nav_grid.waypoints[#hero.nav_grid.waypoints])
			hero.nav_rally.pos = V.vclone(hero.nav_rally.center)

			local old_vo = table.deepclone(hero.sound_events.change_rally_point)

			hero.sound_events.change_rally_point = nil

			local fly_hero = U.flag_has(hero.vis.flags, F_FLYING)

			signal.emit("pan-zoom-camera", 4, {
				x = 700,
				y = 384
			}, OVtargets(nil, 1.2))
			signal.emit("show-curtains")
			signal.emit("hide-gui")
			signal.emit("start-cinematic")
			U.y_wait(store, 4)
			y_do_boss_taunt("LV37_BOSS_INTRO_01")
			U.y_wait(store, 1.8)

			while V.dist(hero.pos.x, hero.pos.y, hero_end_pos.x, hero_end_pos.y) > 10 do
				coroutine.yield()
			end

			U.y_wait(store, 0.2)

			if fly_hero then
				signal.emit("show-balloon_tutorial", "LV37_BOSS_INTRO_HERO_FLYING", false)
			else
				signal.emit("show-balloon_tutorial", "LV37_BOSS_INTRO_HERO", false)
			end

			U.y_wait(store, 2)
			signal.emit("pan-zoom-camera", 2, {
				x = 400,
				y = 380
			}, OVtargets(nil, 1))
			U.y_wait(store, 2)
			signal.emit("hide-curtains")
			signal.emit("show-gui")
			signal.emit("end-cinematic", true)
		end

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end

		controller_boss_prefight.do_boss_unit_spawn = true

		while not self.bossfight_ended do
			coroutine.yield()
		end
	else
		local controller

		for _, v in pairs(store.entities) do
			if v.template_name == "stage_37_paths_controller" then
				controller = v

				break
			end
		end

		controller.modos = true

		P:activate_path(3)
		P:activate_path(4)

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end
end

return level
