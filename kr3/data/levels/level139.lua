-- chunkname: @./kr5/data/levels/level39.lua

local log = require("klua.log"):new("level01")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils_57")
local LU = require("level_utils")
local V = require("klua.vector")
local P = require("path_db")
local W = require("wave_db")
local storage = require("storage")
local GR = require("grid_db")

require("constants")

local function fts(v)
	return v / FPS
end

local hero_index, selected_hero
local dragon_sun_index = false
local secondary_hero_name
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
			dragon_sun_index = true

			break
		end
	end

	if not selected_hero then
		selected_hero = store.selected_team[1]
		hero_index = 1
	elseif store.selected_team[1] == "hero_dragon_sun" then
		secondary_hero_name = store.selected_team[2]
	else
		secondary_hero_name = store.selected_team[1]
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
end

function level:update(store)

	local hero, secondary_hero
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
			hero, secondary_hero = LU.insert_double_hero_return2(store, name1, name2)
		end
		print("level 139 insert hero")
	else
		print("level 139 hero have already inserted")
	end
	if secondary_hero and secondary_hero.template_name == "hero_dragon_sun" then
		selected_hero = secondary_hero
	else
		selected_hero = hero
	end
	 

	for i = 1, 7 do
		P:add_invalid_range(i, 0, 7, nil)
	end

	for i = 8, 15 do
		P:add_invalid_range(i, 0, 7)
	end

	P:add_invalid_range(17, 0, 7)

	for i = 18, 22 do
		P:add_invalid_range(i, 0, 7, nil)
	end

	if store.level_mode == GAME_MODE_CAMPAIGN then
		self.bossfight_ended = false

		local boss_controller

		for _, e in pairs(store.entities) do
			if e.template_name == "controller_stage_39_boss" then
				boss_controller = e

				break
			end
		end

		U.mark_seen(store, "controller_stage_39_boss")

		if not store.restarted and not main.params.skip_cutscenes then
			--local hero, secondary_hero
			local fly_hero = false

			--for _, e in pairs(store.entities) do
			--	if e.template_name == selected_hero then
			--		hero = e

					if U.flag_has(selected_hero.vis.flags, F_FLYING) then
						fly_hero = true
					end

					--if not secondary_hero_name then
					--	break
					--end
				--elseif e.template_name == secondary_hero_name then
				--	secondary_hero = e
				--end
			--end

			if secondary_hero and secondary_hero.template_name == "hero_dragon_sun" then
				local temp_pos = V.vclone(hero.pos)

				hero.pos.x, hero.pos.y = secondary_hero.pos.x, secondary_hero.pos.y
				hero.nav_rally.center = V.vclone(hero.pos)
				hero.nav_rally.pos = hero.nav_rally.center
				secondary_hero.pos.x, secondary_hero.pos.y = temp_pos.x, temp_pos.y
				secondary_hero.nav_rally.center = V.vclone(secondary_hero.pos)
				secondary_hero.nav_rally.pos = secondary_hero.nav_rally.center
			end

			hero.render.sprites[1].flip_x = true

			signal.emit("show-curtains")
			signal.emit("hide-gui")
			signal.emit("start-cinematic")
			signal.emit("pan-zoom-camera", 1, {
				x = 530,
				y = 1000
			}, 1.18)
			U.y_wait(store, 1.5)

			if dragon_sun_index then
				signal.emit("show-balloon_tutorial", "LV39_INTRO_DRAGON_SUN_TAUNT_01", false)
			elseif fly_hero then
				signal.emit("show-balloon_tutorial", "LV39_INTRO_TAUNT_FLY_01", false)
			else
				signal.emit("show-balloon_tutorial", "LV39_INTRO_TAUNT_01", false)
			end

			U.y_wait(store, 4.5)

			boss_controller.do_taunt = "LV39_INTRO_BOSS_TAUNT"

			U.y_wait(store, 3)
			signal.emit("hide-curtains")
			signal.emit("show-gui")
			signal.emit("end-cinematic", true)
		end

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end

		boss_controller.start = true

		while not self.bossfight_ended do
			coroutine.yield()
		end
	end
end

return level
