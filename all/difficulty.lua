-- chunkname: @./all/difficulty.lua

local E = require("entity_db")
local GS = require("game_settings")
local storage = require("storage")
local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
require("constants")

local difficulty = {}

function difficulty:set_level(level)
	self.level = level
end

function difficulty:set_mode(hpmode)
	self.hpmode = hpmode
end

function difficulty:patch_templates()
	local function PT(t, key)
		if t and t[key] and type(t[key]) == "table" and t[key][3] then
			t[key] = t[key][self.level] or t[key][3]

			return true
		end

		return false
	end

	local function PT2(t, key)
		if t and t[key] and type(t[key]) == "table" and t[key][3] then
			--t[key] = t[key][self.level] or t[key][3]

			return true
		end

		return false
	end

	if KR_GAME == "kr1" then
		local hp_factor_soldier = GS.difficulty_soldier_hp_max_factor[self.level]

		for _, t in pairs(E:filter_templates("soldier")) do
			if t.hero and t.hero.level_stats and t.hero.level_stats.hp_max then
				local m = t.hero.level_stats.hp_max

				for i = 1, #m do
					m[i] = math.floor(m[i] * hp_factor_soldier)
				end
			elseif not PT(t.health, "hp_max") and hp_factor_soldier and hp_factor_soldier ~= 1 then
				if not t.health.hp_max then
					log.debug("no hp_max in %s", t.template_name)
				else
					t.health.hp_max = math.floor(t.health.hp_max * hp_factor_soldier)
				end
			end
		end
	end

	self.user_data = storage:load_slot()
	local hp_factor_enemy_0 = GS.difficulty_enemy_hp_max_factor[self.level]
	local speed_factor_enemy = GS.difficulty_enemy_speed_factor[self.level]
	local glod_factor_enemy = GS.difficulty_enemy_gold_factor[self.user_data.liuhui.enemy_count or 1]
	local boss_table_g1 = {"eb_moloch","eb_veznan"}
	local boss_table_g2 = {"eb_leviathan","eb_umbra","eb_gorilla","eb_efreeti","enemy_jungle_spider_tiny","enemy_desert_wolf_small","enemy_bouncer"}
	
	--print("trigger template")
	for _, t in pairs(E:filter_templates("enemy")) do
		--对boss血量进行额外处理
		local hp_factor_enemy = hp_factor_enemy_0
		if self.level == 4 and band(t.vis.flags,F_BOSS) ~= 0 and band(t.vis.flags,F_MINIBOSS) == 0 and hp_factor_enemy_0 > 1.5 then
			hp_factor_enemy = hp_factor_enemy_0 * 3 - 3
		end
		--普通1/2代怪物
		if not PT2(t.health, "hp_max") and hp_factor_enemy ~= 1 then
			if KR_GAME == "kr1" then
				t.health.hp_max = math.floor(t.health.hp_max * hp_factor_enemy + 0.5)
			else
				t.health.hp_max = math.floor(t.health.hp_max * hp_factor_enemy + 0.5)
				--t.health.hp_max = 10 * math.ceil(t.health.hp_max * hp_factor_enemy / 10)
			end
		--1代特殊怪物
		elseif self.level == 4 and table.contains(boss_table_g1, t.template_name) and hp_factor_enemy ~= 1 then
			t.health.hp_max = math.floor(t.health.hp_max[2] * hp_factor_enemy + 0.5)
		--2代特殊怪物
		elseif self.level == 4 and table.contains(boss_table_g2, t.template_name) and hp_factor_enemy ~= 1 then
			t.health.hp_max = math.floor(t.health.hp_max[3] * hp_factor_enemy + 0.5)
		--流辉349  新增3代不可能难度血量倍率设置
		elseif self.level == 4 and hp_factor_enemy and self.user_data.liuhui.g3_hprate == true and PT2(t.health, "hp_max") then
			t.health.hp_max = math.floor(t.health.hp_max[3] * hp_factor_enemy + 0.5)
			--math.max(t.health.hp_max[4] or t.health.hp_max[3],math.floor(t.health.hp_max[3] * hp_factor_enemy + 0.5))
		else
			PT(t.health, "hp_max")
		end

		if not PT(t.motion, "max_speed") and speed_factor_enemy ~= 1 then
			t.motion.max_speed = t.motion.max_speed * speed_factor_enemy
		end

		if not PT(t.enemy, "gold") and glod_factor_enemy ~= 1 and t.enemy.gold then
			t.enemy.gold = math.floor(t.enemy.gold * glod_factor_enemy + 0.5)
		end

		
		PT(t.death_spawns, "quantity")
		PT(t.enemy, "lives_cost")
		PT(t.health, "armor")
		PT(t.health, "magic_armor")
		PT(t.motion, "max_speed")
		PT(t.motion, "speed_limit")

		if t.melee then
			for i, a in ipairs(t.melee.attacks) do
				PT(a, "damage_max")
				PT(a, "damage_min")
				PT(a, "cooldown")
			end
		end

		if t.ranged then
			for i, a in ipairs(t.ranged.attacks) do
				PT(a, "cooldown")
			end
		end

		if t.timed_attacks then
			for i, a in ipairs(t.timed_attacks.list) do
				PT(a, "cooldown")
				PT(a, "damage_max")
				PT(a, "damage_min")
				PT(a, "max_clones")
			end
		end

		PT(t, "power_block_duration")
	end
	--5代大眼
	t16 = E:get_template("controller_stage_16_overseer")
	local hp_factor_enemy = hp_factor_enemy_0
	if self.level == 4 and hp_factor_enemy_0 > 1.5 then
		hp_factor_enemy = hp_factor_enemy_0 * 3 - 3
	end
	t16.health.hp_max = math.floor(t16.health.hp_max * hp_factor_enemy + 0.5)

	--5代海德拉
	t_hydra = E:get_template("enemy_crocs_hydra")
	local hp_factor_enemy = hp_factor_enemy_0
	t_hydra.health.hp_max_evolved = math.floor(t_hydra.health.hp_max_evolved * hp_factor_enemy + 0.5)

	for _, t in pairs(E:filter_templates("aura")) do
		PT(t.aura, "damage_max")
		PT(t.aura, "damage_min")
	end

	for _, t in pairs(E:filter_templates("modifier")) do
		PT(t.modifier, "duration")
	end

	for _, t in pairs(E:filter_templates("bullet")) do
		PT(t.bullet, "damage_max")
		PT(t.bullet, "damage_min")
	end
end

return difficulty
