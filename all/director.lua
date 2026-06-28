-- chunkname: @./all/director.lua

local log = require("klua.log"):new("director")
local km = require("klua.macros")
local signal = require("hump.signal")
local mod = require("mod")

require("klua.dump")
require("klua.table")

local features = require("features")
local i18n = require("i18n")
local V = require("klua.vector")
local I = require("klove.image_db")
local F = require("klove.font_db")
local SH = require("klove.shader_db")
local KDB = require("klove.kui_db")
local S = require("sound_db")
local G = love.graphics
local AC = require("achievements")
local LU = require("level_utils")
local RC = require("remote_config")
local ISM = require("input_state_machine")
local marketing = require("marketing")
local storage = require("storage")
local services = require("platform_services")
local director_data = require("data.director_data")
local E = require("entity_db")
local UPGR = require("upgrades")
local function T(name)
	return E:get_template(name)
end


local function replace_locale(list, locale)
	local out = {}

	for _, v in pairs(list) do
		local ns = string.gsub(v, "LOCALE", locale or i18n.current_locale)

		table.insert(out, ns)
	end

	return out
end

director = {}
director.item_props = director_data.item_props

function director:init(params)
	KDB:init(KR_PATH_GAME_TARGET .. "/data/kui_templates" .. ";" .. KR_PATH_ALL_TARGET .. "/data/kui_templates", DEBUG)
	SH:init(KR_PATH_ALL_TARGET .. "/assets/shaders", true)
	S:init(KR_PATH_GAME_TARGET .. "/assets/sounds")

	I.use_canvas = params.image_db_uses_canvas

	RC:init()
	AC:init()
	services:init()
	marketing:init()

	self.params = params

	self:reset_screen_params()

	I:setMaxThreads(params.max_threads)
	if params.locale then
		main:set_locale(params.locale)
		love.window.setTitle(string.format(_("GAME_TITLE_" .. string.upper(KR_GAME)), KR_FL_VERSION))
	end

	if features.overrides and table.contains(features.overrides, "censored_cn") then
		BLOOD_RED = BLOOD_GRAY
	end

	if KR_TARGET == "phone" and KR_PLATFORM == "android" then
		local filename = "/data/data/" .. version.bundle_id .. "/files/.Defaults.plist"

		storage:import_plist(filename)
	elseif KR_TARGET == "desktop" and KR_GAME == "kr1" and services.services then
		local dir

		if services.services.steam then
			dir = services.services.steam:get_install_dir()
		elseif services.services.gamecenter then
			dir = services.services.gamecenter:get_install_dir()
		elseif services.services.kart then
			dir = services.services.kart:get_install_dir()
		end

		if not dir then
			log.error("Could not find original install dir. Skipping savegame import")
		else
			storage:import_dotnet(dir)
		end
	end

	self.next_item_name = "splash"

	if params.level or params.screen then
		if not storage:load_slot(1) then
			storage:create_slot(1)
		end

		storage:set_active_slot(1)

		if params.screen then
			self.next_item_name = params.screen
			self.next_item_args = {
				custom = params.custom,
				texture_size = params.texture_size
			}
		elseif params.level then
			self.next_item_name = "game"
			self.next_item_args = {
				level_idx = tonumber(params.level),
				level_mode = params.mode and tonumber(params.mode) or GAME_MODE_CAMPAIGN,
				level_difficulty = params.diff and tonumber(params.diff) or DIFFICULTY_NORMAL
			}
		end
	end

	if KR_TARGET == "desktop" then
		if params.screen == "game_editor" then
			local c = love.mouse.newCursor(KR_PATH_ALL_TARGET .. "/assets/cursors/crosshair.png", 16, 16)

			love.mouse.setCursor(c)
		else
			local cursor_name = "hand_32"

			if params.large_pointer then
				cursor_name = params.height < 1080 and "hand_48" or "hand_64"
			end

			self.cursor_up = love.mouse.newCursor(string.format(KR_PATH_ALL_TARGET .. "/assets/cursors/%s_0001.png", cursor_name), 3, 2)
			self.cursor_down = love.mouse.newCursor(string.format(KR_PATH_ALL_TARGET .. "/assets/cursors/%s_0002.png", cursor_name), 3, 2)

			love.mouse.setCursor(self.cursor_up)
		end
	end

	mod:init()
end

function director:quit()
	log.debug("quitting...")
	services:shutdown()
	love.event.quit()
end

function director:get_texture_scale(item_name, ref_res)
	local scale = ref_res / TEXTURE_SIZE_ALIAS[self.params.texture_size]
	local factors = TEXTURE_SIZE_FACTOR[self.params.texture_size]

	if factors and factors[item_name] then
		scale = scale / factors[item_name]
	end

	log.debug("item:%s ref_res:%s texture_size:%s -> scale:%s", item_name, ref_res, self.params.texture_size, scale)

	return scale
end

function director:reset_screen_params(force_scissor)
	local params = self.params
	local aw, ah = love.graphics.getDimensions()

	params.width, params.height = aw, ah

	local screen_aspect = params.width / params.height
	local max_aspect = MAX_SCREEN_ASPECT
	local min_aspect = MIN_SCREEN_ASPECT

	if screen_aspect < min_aspect then
		self.scissor_w = params.width
		self.scissor_h = params.width / min_aspect
		self.scissor_x = 0
		self.scissor_y = (params.height - self.scissor_h) / 2
		self.scissor_enabled = true
	elseif max_aspect < screen_aspect then
		self.scissor_w = params.height * max_aspect
		self.scissor_h = params.height
		self.scissor_x = (params.width - self.scissor_w) / 2
		self.scissor_y = 0
		self.scissor_enabled = true
	else
		self.scissor_enabled = false
	end

	if force_scissor ~= nil then
		log.info("forcing scissor value to %s", force_scissor)

		self.scissor_enabled = force_scissor
	end

	log.info("resetting screen params. w,h:%s,%s scissor:%s %s,%s,%s,%s", aw, ah, self.scissor_enabled, self.scissor_x, self.scissor_y, self.scissor_w, self.scissor_h)
end

function director:item_done_callback(item_name, outcome)
	if self.active_item and self.active_item.done_callback_called then
		log.error("  Done callback already called... Ignoring!")

		return
	end

	self.active_item.done_callback_called = true

	if self.active_item then
		local w = self.active_item.game_gui and self.active_item.game_gui.window or self.active_item.window

		if w then
			log.debug("disabling events for item:%s window:%s", self.active_item.item_name, w)
			w:disable(false)

			if ISM then
				ISM:destroy(w)
			end
		end
	end

	log.debug("DONE CALLBACK FROM %s with outcome %s", item_name, getdump(outcome))

	if outcome then
		if outcome.quit then
			self:quit()

			return
		elseif outcome.next_item_name then
			self.next_item_name = outcome.next_item_name
			self.next_item_args = outcome

			return
		elseif outcome.prevent_loading then
			self.next_item_prevent_loading = true
		end
	end

	if item_name == "comics" then
		self.queued_item = self.active_item.game_item

		return
	end

	local props = self.item_props[item_name]

	if props.next then
		self.next_item_name = props.next
		self.next_item_args = {}

		return
	end
end

function director:get_comic_data_file(comic_idx)
	local suffix = string.format("/data/comics/%02i.csv", comic_idx)
	local file = KR_PATH_GAME_TARGET .. suffix

	if not love.filesystem.isFile(file) then
		file = KR_PATH_GAME .. suffix
	end

	return file
end

function director:unload_item(item)
	if not item then
		log.debug("item nil")

		return
	end
	
	if item.item_name == "game" then
		local game = item
		for _, group in pairs(replace_locale(game.game_gui.required_textures)) do
			local scale = self:get_texture_scale("game_gui", game.game_gui.ref_res)

			I:unload_atlas(group, scale)
		end
		-- collectgarbage()

		local groups = {}

		groups = table.append(groups, replace_locale(game.required_textures))
		groups = table.append(groups, replace_locale(game.store.level.required_textures))
		
		-- if game.store.selected_hero then
			-- table.insert(groups, "go_" .. game.store.selected_hero)
		-- end

		for _, group in pairs(groups) do
			local scale = self:get_texture_scale("game", game.ref_res)
			I:unload_atlas(group, scale)
		end

		for _, group in pairs(replace_locale(game.scale_required_textures)) do
			local scale = self:get_texture_scale("game", game.ref_res * TEXTURE_SIZE_FACTOR.kr_45)
			I:unload_atlas(group, scale)
		end

		for _, group in pairs(replace_locale(game.scale_required_textures_enemy)) do
			local scale = self:get_texture_scale("game", game.ref_res * TEXTURE_SIZE_FACTOR.kr_45 * 2)
			I:unload_atlas(group, scale)
		end
		-- collectgarbage()

		I:unload_atlas("temp_game_texts", game.store.screen_scale)

		if item.required_sounds then
			for _, group in pairs(item.required_sounds) do
				S:unload_group(group)
			end
		end

		if game.store.level.required_sounds then
			for _, group in pairs(game.store.level.required_sounds) do
				S:unload_group(group)
			end
		end

		-- if game.store.selected_hero then
			-- S:unload_group(game.store.selected_hero)
		-- end

		game:destroy()

		game.store = nil

		collectgarbage()
	elseif not item.keep_loaded then
		local textures = item.required_textures

		if textures then
			local scale = self:get_texture_scale(item.item_name, item.ref_res)

			for _, group in pairs(replace_locale(textures, item.locale_at_requirement)) do
				I:unload_atlas(group, scale)
			end
		end

		if item.required_sounds then
			for _, group in pairs(item.required_sounds) do
				S:unload_group(group)
			end
		end

		if item.destroy then
			item:destroy()
		end

		collectgarbage()
	end
end

--第6关结束后props出了问题（应该是漫画）
function director:queue_load_item_named(name, force_reload)
	local function _require(name, force)
		if force_reload or force then
			package.loaded[name] = nil
		end

		local r = require(name)

		r.locale_at_requirement = i18n.current_locale

		return r
	end

	local props = self.item_props[name]

	self:reset_screen_params(props and props.scissor)

	local show_loading = props.show_loading

	if self.next_item_prevent_loading then
		show_loading = false
		self.next_item_prevent_loading = nil
	end

	if show_loading then
		local loading = _require("screen_loading")
		local level_idx

		if game and game.store and game.store.level_idx then
			level_idx = game.store.level_idx
		elseif self.next_item_args then
			level_idx = self.next_item_args.level_idx
		end

		if loading.update_required_textures then
			loading:update_required_textures(name, level_idx)
		end

		self:load_texture_groups(loading.required_textures, self.params.texture_size, loading.ref_res, false)

		if loading.required_sounds then
			self:load_sound_groups(loading.required_sounds)
		end

		loading:init(self.params.width, self.params.height)
		loading:close()

		self.queue_unload_item = self.active_item
		self.active_item = loading
	end

	if props.type == "screen" then
		local item = _require(props.src, self.next_item_args and self.next_item_args.force_reload)

		item.item_name = name
		item.args = self.next_item_args
		if item.required_textures then
			self:load_texture_groups(replace_locale(item.required_textures), self.params.texture_size, item.ref_res, true, name)
		end

		if item.ref_res then
			item.screen_scale = self:get_texture_scale(name, item.ref_res)
		end

		self.queued_item = item

		if item.required_sounds then
			self:load_sound_groups(item.required_sounds)
		end
	elseif props.type == "comic" then
		local args = self.next_item_args
		local comic_idx = args.custom
		local item = _require("screen_comics")

		item.item_name = "comics"
		item.required_textures = {
			"loading_common",
			"comic_" .. comic_idx
		}
		item.comic_data = love.filesystem.read(KR_PATH_GAME_TARGET .. string.format("/data/comics/%02i.csv", comic_idx))

		self:load_texture_groups(replace_locale(item.required_textures), self.params.texture_size, item.ref_res, true)

		self.queued_item = item
	elseif props.type == "game" then
		local game_gui = _require("game_gui")
		local game = _require("game")
		local args = self.next_item_args
		local user_data = storage:load_slot()
		game.item_name = "game"
		game.max_fps = DRAW_FPS

		game.store = {}
		game.store.level_idx = args.level_idx

		local map_data = require("data.map_data")
		local hero_game_ver = map_data.hero_game_ver

		local tower_5_data_tmp = map_data.tower_5_data

		local HERO_5_START = 48

		
		game.scale_required_textures_enemy = {
			--在这里添加5代敌人的图像，修改每关的出怪列表，注释掉前面的“--”即可添加敌人。
			--"go_enemies_sea_of_trees", 	--5代第1大关敌人
			--"go_enemies_terrain_2",  		--5代第2大关敌人
			--"go_enemies_terrain_3",  		--5代第3大关敌人
			--"go_enemies_terrain_4",  		--5代第4大关敌人（亡魂支线）
			--"go_enemies_terrain_5",  		--5代第5大关敌人（鳄鱼支线）
			--"go_enemies_terrain_6",  		--5代第6大关敌人（矮人支线）
			--"go_enemies_terrain_7",  		--5代第7大关敌人（蜘蛛支线）
		}

		math.randomseed(os.time())
		local function random_hero()
			local random_result = nil
			while true do
				random_result = math.random(1, #map_data.hero_data)
				if map_data.hero_data[random_result].transplanting == nil then
					break
				end
			end
			return random_result
		end
		--对英雄进行随机
		if user_data.liuhui.rand_hero and user_data.liuhui.rand_hero == 1 then
			local hero_data = map_data.hero_data
			if user_data.liuhui_hero.usedoublehero then
				user_data.liuhui_hero.herolist[1] = random_hero()--math.random(1, #hero_data)
				user_data.liuhui_hero.herolist[2] = random_hero()--math.random(1, #hero_data)
				--local ht1 = hero_data[user_data.liuhui_hero.herolist[1]].name
				--local ht = hero_data[user_data.liuhui_hero.herolist[2]].name
			else
				rand_hero = random_hero()--math.random(1, #hero_data)
				user_data.heroes.selected = hero_data[rand_hero].name
			end
			storage:save_slot(user_data)
		end
		user_data = storage:load_slot()
		local ht = user_data.heroes.selected 

		--对塔进行随机
		--string.sub(name, 1, -5)
		local tower_list = {
			archer = {},
			barrack = {},
			mage = {},
			engineer = {},
		}
		game.store.random_tower_list = {
			random0 = {},
			random1 = {},
			random2 = {},
			random3 = {},
			random4 = {},
			random20 = {},
			random21 = {},
			random22 = {},
			random23 = {},
			random24 = {},
		}
		game.store.tmp_random_menu = {}
		game.store.liuhui_rand_tower = 0
		if user_data.liuhui.rand_tower and user_data.liuhui.rand_tower >= 1 then
			game.store.liuhui_rand_tower = 1
			--抽箭塔
			for it = 1, user_data.liuhui.rand_tower do
				local finished = false
				local tower_id = 0
				while finished == false do
					tower_id = math.random(1, #map_data.random.archer)
					if not table.contains(tower_list.archer, map_data.random.archer[tower_id]) then
						table.insert(tower_list.archer, map_data.random.archer[tower_id])
						finished = true
					end
				end

				local rank1 = table.find(map_data.tower_5_data, function(k, v)
					return v.name == map_data.random.archer[tower_id]
				end)
				local rank2 = table.find(map_data.tower_3_data, function(k, v)
					return v.name == map_data.random.archer[tower_id]
				end)
				local rank3 = table.find(map_data.tower_4_data, function(k, v)
					return v.name == map_data.random.archer[tower_id]
				end)
				--加入template
				local template_name = ""
				local template_json = {}
				if rank2 then
					template_name = T(map_data.tower3_menu_json[1][rank2].action_arg).build_name
					template_json = table.deepclone(map_data.tower3_menu_json[1][rank2])
				elseif rank3 then
					template_name = T(map_data.tower4_menu_json[1][rank3].action_arg).build_name
					template_json = table.deepclone(map_data.tower4_menu_json[1][rank2])
				else
					template_name = T(map_data.tower_menu_json[rank1].action_arg).build_name
					template_json = table.deepclone(map_data.tower_menu_json[rank1])
				end
				table.insert(game.store.random_tower_list.random1, template_name)
				table.insert(game.store.random_tower_list.random0, template_name)
				table.insert(game.store.random_tower_list.random21, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.random_tower_list.random20, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.tmp_random_menu, template_json)
			end
			--抽兵营
			for it = 1, user_data.liuhui.rand_tower do
				local finished = false
				local tower_id = 0
				while finished == false do
					tower_id = math.random(1, #map_data.random.barrack)
					if not table.contains(tower_list.barrack, map_data.random.barrack[tower_id]) then
						table.insert(tower_list.barrack, map_data.random.barrack[tower_id])
						finished = true
					end
				end

				local rank1 = table.find(map_data.tower_5_data, function(k, v)
					return v.name == map_data.random.barrack[tower_id]
				end)
				local rank2 = table.find(map_data.tower_3_data, function(k, v)
					return v.name == map_data.random.barrack[tower_id]
				end)
				local rank3 = table.find(map_data.tower_4_data, function(k, v)
					return v.name == map_data.random.barrack[tower_id]
				end)
				--加入template
				local template_name = ""
				local template_json = {}
				if rank2 then
					template_name = T(map_data.tower3_menu_json[1][rank2].action_arg).build_name
					template_json = table.deepclone(map_data.tower3_menu_json[1][rank2])
				elseif rank3 then
					template_name = T(map_data.tower4_menu_json[1][rank3].action_arg).build_name
					template_json = table.deepclone(map_data.tower4_menu_json[1][rank3])
				else
					template_name = T(map_data.tower_menu_json[rank1].action_arg).build_name
					template_json = table.deepclone(map_data.tower_menu_json[rank1])
				end
				table.insert(game.store.random_tower_list.random2, template_name)
				table.insert(game.store.random_tower_list.random0, template_name)
				table.insert(game.store.random_tower_list.random22, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.random_tower_list.random20, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.tmp_random_menu, template_json)
			end
			--抽法师
			for it = 1, user_data.liuhui.rand_tower do
				local finished = false
				local tower_id = 0
				while finished == false do
					tower_id = math.random(1, #map_data.random.mage)
					if not table.contains(tower_list.mage, map_data.random.mage[tower_id]) then
						table.insert(tower_list.mage, map_data.random.mage[tower_id])
						finished = true
					end
				end

				local rank1 = table.find(map_data.tower_5_data, function(k, v)
					return v.name == map_data.random.mage[tower_id]
				end)
				local rank2 = table.find(map_data.tower_3_data, function(k, v)
					return v.name == map_data.random.mage[tower_id]
				end)
				local rank3 = table.find(map_data.tower_4_data, function(k, v)
					return v.name == map_data.random.mage[tower_id]
				end)
				--加入template
				local template_name = ""
				local template_json = {}
				if rank2 then
					template_name = T(map_data.tower3_menu_json[1][rank2].action_arg).build_name
					template_json = table.deepclone(map_data.tower3_menu_json[1][rank2])
				elseif rank3 then
					template_name = T(map_data.tower4_menu_json[1][rank3].action_arg).build_name
					template_json = table.deepclone(map_data.tower4_menu_json[1][rank3])
				else
					template_name = T(map_data.tower_menu_json[rank1].action_arg).build_name
					template_json = table.deepclone(map_data.tower_menu_json[rank1])
				end
				table.insert(game.store.random_tower_list.random3, template_name)
				table.insert(game.store.random_tower_list.random0, template_name)
				table.insert(game.store.random_tower_list.random23, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.random_tower_list.random20, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.tmp_random_menu, template_json)
			end
			--抽炮塔
			for it = 1, user_data.liuhui.rand_tower do
				local finished = false
				local tower_id = 0
				while finished == false do
					tower_id = math.random(1, #map_data.random.engineer)
					if not table.contains(tower_list.engineer, map_data.random.engineer[tower_id]) then
						table.insert(tower_list.engineer, map_data.random.engineer[tower_id])
						finished = true
					end
				end

				local rank1 = table.find(map_data.tower_5_data, function(k, v)
					return v.name == map_data.random.engineer[tower_id]
				end)
				local rank2 = table.find(map_data.tower_3_data, function(k, v)
					return v.name == map_data.random.engineer[tower_id]
				end)
				local rank3 = table.find(map_data.tower_4_data, function(k, v)
					return v.name == map_data.random.engineer[tower_id]
				end)
				--加入template
				local template_name = ""
				local template_json = {}
				if rank2 then
					template_name = T(map_data.tower3_menu_json[1][rank2].action_arg).build_name
					template_json = table.deepclone(map_data.tower3_menu_json[1][rank2])
				elseif rank3 then
					template_name = T(map_data.tower4_menu_json[1][rank3].action_arg).build_name
					template_json = table.deepclone(map_data.tower4_menu_json[1][rank3])
				else
					template_name = T(map_data.tower_menu_json[rank1].action_arg).build_name
					template_json = table.deepclone(map_data.tower_menu_json[rank1])
				end
				table.insert(game.store.random_tower_list.random4, template_name)
				table.insert(game.store.random_tower_list.random0, template_name)
				table.insert(game.store.random_tower_list.random24, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.random_tower_list.random20, string.sub(template_name, 1,-2).."2")
				table.insert(game.store.tmp_random_menu, template_json)
			end
			
		end

		

		--if user_data.liuhui.cp_mode == false then
		--禁用兼容模式
		if true then
			game.required_textures = {
				--必需品
				"go_decals",
				"go_enemies_common",
				"go_towers_44",
				"go_towers_1-galaxy",
				"rebbborn_fig",
				"gui_common_123mod",
				"go_towers_special",
			 	"go_barrack_pirates",
				"go_enemies_desert_b",
				"go_enemies_desert",
				"go_hero_munra",
				"go_towers_1",--防御塔
				"go_towers_2",--援兵相关
				"go_reinforcement_skin_0",
				"go_reinforcement_skin_1",
				"go_reinforcement_skin_2",
				"go_reinforcement_skin_3",
				"kr4_sapos",
				--"ultimate45",
				--"kr4_herogui",
				"kr4_hero_power",
				--"kr4_hero_room",
				"kr5_hero_power",
				--神灯许愿台
				"go_hero_baby_malik",
				"go_hero_alleria_g3",
				"go_hero_bolverk",
				"go_hero_vampiress",
				--征服
				"gui_common_v",
				"gui_portraits_v",
				"go_towers_v",
			}
			game.scale_required_textures = {
				"go_towers",
				"terrains_5",
				"go_commons",--5代相关
			}
			
			if user_data.liuhui_hero.usedoublehero then
				local hero_data = map_data.hero_data
				local ht1 = hero_data[user_data.liuhui_hero.herolist[1]].name
				local ht = hero_data[user_data.liuhui_hero.herolist[2]].name
				if ht1 and ht1 == "hero_alleria" then
					table.insert(game.required_textures, "go_"..ht1)
				else
					if hero_game_ver(ht1) >= 4 then
						table.insert(game.scale_required_textures, "go_"..ht1)
					else
						table.insert(game.required_textures, "go_"..ht1)
					end
				end
				if ht and ht == "hero_alleria" then
					table.insert(game.required_textures, "go_"..ht)
				else
					if hero_game_ver(ht) >= 4 then
						table.insert(game.scale_required_textures, "go_"..ht)
					else
						table.insert(game.required_textures, "go_"..ht)
					end
				end
			else
				if hero_game_ver(ht) >= 4 then
					table.insert(game.scale_required_textures, "go_"..ht)
				else
					table.insert(game.required_textures, "go_"..ht)
				end
			end
			if user_data.liuhui.cheathero then
				table.insert(game.required_textures, "go_hero_all_1")
				table.insert(game.required_textures, "go_hero_all_2")
				table.insert(game.required_textures, "go_hero_all_3-1")
				table.insert(game.required_textures, "go_hero_all_3-2")
				table.insert(game.required_textures, "go_hero_voltaire")
				table.insert(game.required_textures, "go_hero_viper")
				table.insert(game.required_textures, "go_hero_munra")
			end

			--防御塔加载
			if not user_data.liuhui.rand_tower or user_data.liuhui.rand_tower == 0 then
				for i = 1,user_data.tower_pick do
					local num = user_data.towers[i]
					local strs = ("go_towers_"..tower_5_data_tmp[num].name)
					table.insert(game.scale_required_textures, strs)
				end
			else
				for kk, vv in pairs(tower_list) do
					for i = 1,#vv do
						local rank1 = table.find(map_data.tower_5_data, function(k, v)
							return v.name == vv[i]
						end)
						if rank1 then
							local strs = ("go_towers_"..vv[i])
							table.insert(game.scale_required_textures, strs)
						end
					end
				end
			end
			
			if user_data.liuhui.cheat5 == true then
				table.insert(game.scale_required_textures, "go_g5_stage528")
				table.insert(game.scale_required_textures, "go_stage137")
				table.insert(game.required_textures, "go_stage104")
				table.insert(game.required_textures, "go_stage113")
				table.insert(game.required_textures, "go_stage117")
				table.insert(game.required_textures, "go_stage118")
				table.insert(game.required_textures, "go_stage120")
				table.insert(game.required_textures, "go_stage122")
				table.insert(game.required_textures, "gui_common_5_D")
				
				for i = HERO_5_START, #map_data.hero_data do
					if map_data.hero_data[i].transplanting == nil then
						table.insert(game.scale_required_textures, "go_"..map_data.hero_data[i].name)
					end
				end
			end

			if user_data.liuhui.cheat5_dragon == true then
				table.insert(game.required_textures, "go_stage135")
				table.insert(game.required_textures, "go_wukong_elemental_holders")
			end
			
			if args.level_idx == 5 then
				table.insert(game.required_textures, "go_hero_alleria_g3")
			end
		end
		
		--然后再补全sound
		game.required_sounds = {
			"common",
			"common5",
			"ElvesTowerTaunts",
			"ElvesCommonSounds",
			"stage_20",
			"stage_13",
			"terrain_wukong_common"
		}
		table.insert(game.required_sounds, "tower_hermit_toad")
		for i = 1,user_data.tower_pick do
			local num = user_data.towers[i]
			local strs = ("tower_"..tower_5_data_tmp[num].name)
			table.insert(game.required_sounds, strs)
		end
		if not user_data.liuhui.rand_tower or user_data.liuhui.rand_tower == 0 then
			for i = 1,user_data.tower_pick do
				local num = user_data.towers[i]
				local strs = ("tower_"..tower_5_data_tmp[num].name)
				table.insert(game.required_sounds, strs)
			end
		else
			for kk, vv in pairs(tower_list) do
				for i = 1,#vv do
					local rank1 = table.find(map_data.tower_5_data, function(k, v)
						return v.name == vv[i]
					end)
					if rank1 then
						local strs = ("tower_"..vv[i])
						table.insert(game.required_sounds, strs)
					end
				end
			end
		end
		if user_data.liuhui.cheat5 == true then
			for i = HERO_5_START, #map_data.hero_data do
				if map_data.hero_data[i].transplanting == nil then
					table.insert(game.required_sounds, map_data.hero_data[i].name)
				end
			end
			table.insert(game.required_sounds, "stage_137")
		end
		local hero_data = map_data.hero_data
		local ht1 = hero_data[user_data.liuhui_hero.herolist[1]].name
		local ht2 = hero_data[user_data.liuhui_hero.herolist[2]].name
		local ht = user_data.heroes.selected 
		if hero_game_ver(ht1) >= 4 then
			table.insert(game.required_sounds, ht1)
		end

		if hero_game_ver(ht2) >= 4 then
			table.insert(game.required_sounds, ht2)
		end

		if hero_game_ver(ht) >= 4 then
			table.insert(game.required_sounds, ht)
		end

		game.store.level_name = "level" .. string.format("%02i", args.level_idx)
		if args.level_idx >= 101 then
			local local_level = require(string.format("data.levels.level%02i_data",args.level_idx))
			--game.scale_required_textures = game.scale_required_textures + local_level.scale_required_textures
			if local_level.scale_required_textures then
				for k, v in pairs(local_level.scale_required_textures) do
					table.insert(game.scale_required_textures, v)
				end
			end
		end
		game.store.level_mode = args.level_mode
		game.store.level_difficulty = args.level_difficulty
		game.store.screen_scale = self:get_texture_scale("game", REF_H)
		game.store.texture_size = self.params.texture_size
		game.store.level = LU.load_level(game.store, game.store.level_name)
		game.store.user_data = user_data
		
		-- collectgarbage()
		self:load_texture_groups(replace_locale(game.scale_required_textures), self.params.texture_size, game.ref_res * TEXTURE_SIZE_FACTOR.kr_45, true, "game")
		self:load_texture_groups(replace_locale(game.scale_required_textures_enemy), self.params.texture_size, game.ref_res * TEXTURE_SIZE_FACTOR.kr_45 * 2, true, "game")
		self:load_texture_groups(replace_locale(game.required_textures), self.params.texture_size, game.ref_res, true, "game")
		self:load_texture_groups(replace_locale(game.store.level.required_textures), self.params.texture_size, game.ref_res, true, "game")
		self:load_texture_groups(replace_locale(game_gui.required_textures), self.params.texture_size, game_gui.ref_res, true, "game_gui")
		self:load_sound_groups(game.required_sounds)
		self:load_sound_groups(game.store.level.required_sounds)

		if game.store.level.show_comic_idx and game.store.level_mode == GAME_MODE_CAMPAIGN then
			local comic_idx = game.store.level.show_comic_idx
			local item = _require("screen_comics")

			item.item_name = "comics"
			item.required_textures = {
				"comic_" .. comic_idx
			}
			item.level_idx = game.store.level_idx
			local comic_idx_2 = comic_idx
			local comic_scale = 1
			if args.level_idx >= 101 then
				comic_scale = TEXTURE_SIZE_FACTOR.kr_45
			end
			item.comic_data = love.filesystem.read(KR_PATH_GAME_TARGET .. string.format("/data/comics/%02i.csv", comic_idx_2))
			
			self:load_texture_groups(replace_locale(item.required_textures), self.params.texture_size, item.ref_res, true, "comic")

			self.queued_item = item
			item.game_item = game
		else
			self.queued_item = game
		end
	end

	log.debug("queued item: %s", self.queued_item.item_name)
end

function director:load_texture_groups(groups, texture_size, ref_height, queue, item_name)
	local scale = 1

	if ref_height then
		scale = self:get_texture_scale(item_name, ref_height)
	end

	for _, group in pairs(groups) do
		local texture_path = KR_PATH_GAME_TARGET .. "/assets/images/" .. texture_size

		if features.overrides then
			for _, n in pairs(features.overrides) do
				local ov_path = texture_path .. "/_ov/" .. n

				if love.filesystem.exists(ov_path .. "/" .. group .. ".lua") then
					log.debug("  +++ texture group %s overriden by %s", group, n)

					texture_path = ov_path
				end
			end
		end

		if queue then
			I:queue_load_atlas(scale, texture_path, group)
		else
			I:load_atlas(scale, texture_path, group)
		end
	end
end

function director:load_sound_groups(groups)
	S.global_source_mode = self.params.audio_mode

	if groups then
		for _, group in pairs(groups) do
			S:queue_load_group(group)
		end
	end
end

function director:queued_item_ready(dt)
	return I:queue_load_done() and S:queue_load_done()
end

function director:update(dt)
	S:update(dt)

	if self.next_item_name then
		self:queue_load_item_named(self.next_item_name, self.force_reload)

		self.queued_item_init = false
		self.queued_item_first_draw = false
		self.last_item_name = self.next_item_name
		self.next_item_name = nil
		self.force_reload = nil
	end

	if self.active_item then
		local ai = self.active_item

		if ai.limit_fps then
			ai.next_frame_ts = ai.limit_fps and ai.next_frame_ts + 1 / ai.limit_fps or nil
		end

		ai:update(dt)
	end

	local ai = self.active_item
	local aits = ai and ai.is_transition and ai.transition_state or nil

	if aits == "closing" or aits == "opening" then
		-- block empty
	else
		if self.queue_unload_item and (not aits or aits == "closed") then
			self:unload_item(self.queue_unload_item)

			self.queue_unload_item = nil
		end
		
		if self.queued_item and self:queued_item_ready(dt) then
			local ai = self.active_item

			if ai and ai.hold_enabled then
				-- block empty
			else
				if not self.queued_item_init then
					local item = self.queued_item

					local function cb(outcome)
						self:item_done_callback(item.item_name, outcome)
					end

					self.queued_item:init(self.params.width, self.params.height, cb)

					self.queued_item.done_callback_called = nil
					self.queued_item_init = true
					self.queued_item_first_draw = false

					self.queued_item:update(2 * TICK_LENGTH)

					goto label_13_0
				end

				if ai then
					if ai.transition_state == "closing" then
						goto label_13_0
					elseif ai.transition_state == "closed" and self.queued_item_first_draw then
						ai:open()

						goto label_13_0
					elseif ai.transition_state == "opening" then
						goto label_13_0
					end
				end

				self:unload_item(self.active_item)

				self.active_item = self.queued_item
				self.queued_item = nil
				self.queued_item_init = nil

				signal.emit(SGN_DIRECTOR_ITEM_SHOWN, self.active_item.item_name, self.active_item)

				local item = self.active_item
				local fps

				if item.max_fps then
					fps = item.max_fps
				else
					fps = not self.params.vsync and 60 or nil
				end

				item.limit_fps = fps
				item.next_frame_ts = love.timer.getTime()
			end
		end
	end

	::label_13_0::

	if ISM then
		local state = self.active_item and self.active_item.get_ism_state and self.active_item:get_ism_state()

		ISM:update(dt, state)
	end

	services:update(dt)
end

function director:draw()
	if self.active_item then
		if self.scissor_w and self.scissor_enabled then
			G.setScissor(self.scissor_x, self.scissor_y, self.scissor_w, self.scissor_h)
		end

		local ai = self.active_item

		if ai.transition_state == "closing" and self.queue_unload_item then
			self.queue_unload_item:draw()
		elseif self.queued_item and self.queued_item_init then
			self.queued_item:draw()

			self.queued_item_first_draw = true
		end

		ai:draw()

		if self.scissor_w and self.scissor_enabled then
			G.setScissor()
		end
	end
end

function director:limit_fps()
	if self.active_item then
		local ai = self.active_item

		if ai.next_frame_ts then
			local current_ts = love.timer.getTime()

			if current_ts >= ai.next_frame_ts then
				ai.next_frame_ts = current_ts

				return
			end

			love.timer.sleep(ai.next_frame_ts - current_ts)
		end
	end
end

function director:keypressed(key, isrepeat)
	if key == "tab" and love.window.getFullscreen() and love.system.getOS() == "OS X" and (love.keyboard.isDown("lgui") or love.keyboard.isDown("rgui")) then
		love.window.minimize()

		return
	end

	if DEBUG and key == "r" and love.keyboard.isDown("lshift") and not isrepeat then
		RC:reload()

		if self.active_item and self.active_item.item_name == "game" then
			log.error("FORCING RELOAD OF GUI ONLY")
			game:reload_gui()
		else
			log.error("FORCING RELOAD OF %s", self.last_item_name)

			self.force_reload = true
			self.next_item_name = self.last_item_name
		end

		return
	end

	if self.active_item and self.active_item.keypressed and self.active_item:keypressed(key, isrepeat) then
		return
	end

	if ISM then
		local state = self.active_item and self.active_item.get_ism_state and self.active_item:get_ism_state()

		ISM:proc_key(state, key, isrepeat)
	end
end

function director:keyreleased(key, isrepeat)
	if self.active_item and self.active_item.keyreleased then
		self.active_item:keyreleased(key, isrepeat)
	end
end

function director:textinput(t)
	if self.active_item and self.active_item.textinput then
		self.active_item:textinput(t)
	end
end

function director:mousepressed(x, y, button, istouch)
	if self.cursor_down then
		love.mouse.setCursor(self.cursor_down)
	end

	if self.active_item and self.active_item.mousepressed then
		self.active_item:mousepressed(x, y, button, istouch)
	end
end

function director:mousereleased(x, y, button, istouch)
	if self.cursor_up then
		love.mouse.setCursor(self.cursor_up)
	end

	if self.active_item and self.active_item.mousereleased then
		self.active_item:mousereleased(x, y, button, istouch)
	end
end

function director:wheelmoved(dx, dy)
	if self.active_item and self.active_item.wheelmoved then
		self.active_item:wheelmoved(dx, dy)
	end
end

function director:touchpressed(id, x, y, dx, dy, pressure)
	if self.active_item and self.active_item.touchpressed then
		self.active_item:touchpressed(id, x, y, dx, dy, pressure)
	end
end

function director:touchreleased(id, x, y, dx, dy, pressure)
	if self.active_item and self.active_item.touchreleased then
		self.active_item:touchreleased(id, x, y, dx, dy, pressure)
	end
end

function director:touchmoved(id, x, y, dx, dy, pressure)
	if self.active_item and self.active_item.touchmoved then
		self.active_item:touchmoved(id, x, y, dx, dy, pressure)
	end
end

function director:gamepadaxis(joystick, axis, value)
	if self.active_item and self.active_item.gamepadaxis then
		self.active_item:gamepadaxis(joystick, axis, value)
	end
end

function director:gamepadpressed(joystick, button)
	if self.active_item then
		if self.active_item.gamepadpressed then
			self.active_item:gamepadpressed(joystick, button)
		end

		local state = self.active_item and self.active_item.get_ism_state and self.active_item:get_ism_state()

		if ISM then
			ISM:proc_button(state, joystick, button)
		end
	end
end

function director:gamepadreleased(joystick, button)
	if self.active_item and self.active_item.gamepadreleased then
		self.active_item:gamepadreleased(joystick, button)
	end
end

function director:joystickpressed(joystick, button)
	if self.active_item and self.active_item.joystickpressed then
		self.active_item:joystickpressed(joystick, button)
	end
end

function director:joystickreleased(joystick, button)
	if self.active_item and self.active_item.joystickreleased then
		self.active_item:joystickreleased(joystick, button)
	end
end

function director:joystickadded(joystick)
	if ISM then
		ISM:joystickadded(joystick)
	end

	if self.active_item and self.active_item.joystickadded then
		self.active_item:joystickadded(joystick)
	end

	signal.emit("joystick-added", joystick)
end

function director:joystickremoved(joystick)
	if ISM then
		ISM:joystickremoved(joystick)
	end

	if self.active_item and self.active_item.joystickremoved then
		self.active_item:joystickremoved(joystick)
	end

	signal.emit("joystick-removed", joystick)
end

function director:resize(w, h)
	log.debug(">>>>>>>>> screen size changed to %s,%s", w, h)
	self:reset_screen_params()
end

function director:focus(focus)
	log.paranoid("++++++++++ focus changed to :%s ++++++++++", focus)

	if self.active_item and self.active_item.focus then
		self.active_item:focus(focus)
	end
end

return director
