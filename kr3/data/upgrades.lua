-- chunkname: @./kr3/upgrades.lua

local log = require("klua.log"):new("upgrades")
local km = require("klua.macros")
local E = require("entity_db")
local bit = require("bit")
local balance = require("balance/balance")
local storage = require("storage")

require("constants")

local function T(name)
	return E:get_template(name)
end

local epsilon = 1e-09
local upgrades = {}

upgrades.max_level = nil
upgrades.levels = {}
upgrades.levels.archers = 0
upgrades.levels.barracks = 0
upgrades.levels.mages = 0
upgrades.levels.reinforcements = 0
upgrades.levels.rocks = 0
upgrades.levels.thunder = 0
upgrades.display_order = {
	"archers",
	"barracks",
	"mages",
	"rocks",
	"thunder",
	"reinforcements"
}
upgrades.list = {
	archer_el_master_shooter = {
		damage_factor = 1.05,
		class = "archers",
		icon = 1,
		price = 1,
		level = 1
	},
	archer_salvage = {
		refund_factor = 0.9,
		class = "archers",
		price = 1,
		level = 1,
		icon = 1
	},
	archer_improved_aim = {
		range_factor = 1.1,
		class = "archers",
		icon = 1,
		price = 1,
		level = 1
	},
	
	archer_el_treesinged_bow = {
		range_factor = 1.1,
		class = "archers",
		icon = 2,
		price = 1,
		level = 2
	},
	archer_eagle_eye = {
		range_factor = 1.1,
		class = "archers",
		price = 1,
		level = 2,
		icon = 2
	},
	archer_lumbermill = {
		cost_reduction = 10,
		class = "archers",
		icon = 2,
		price = 1,
		level = 2
	},
	
	archer_el_obsidian_heads = {
		price = 2,
		icon = 3,
		class = "archers",
		level = 3
	},
	archer_focused_aim = {
		damage_factor = 1.05,
		class = "archers",
		icon = 3,
		price = 2,
		level = 3
	},
	archer_piercing = {
		class = "archers",
		reduce_armor_factor = 0.1,
		price = 2,
		level = 3,
		icon = 3
	},
	
	archer_el_elven_training = {
		burst_damage_factor = 1.1,
		sentence_chance_factor = 1.1,
		damage_factor = 1.1,
		class = "archers",
		mark_damage_factor = 1.1,
		slumber_duration_factor = 1.1,
		icon = 4,
		price = 2,
		level = 4
	},
	archer_far_shots = {
		range_factor = 1.1,
		class = "archers",
		price = 2,
		level = 4,
		icon = 4
	},
	archer_master_marksmanship = {
		range_factor = 1.05,
		damage_factor = 1.1,
		class = "archers",
		icon = 4,
		price = 2,
		level = 4
	},
	
	archer_el_bloodletting_shoot = {
		price = 3,
		icon = 5,
		class = "archers",
		level = 5
	},
	archer_twin_shot = {
		class = "archers",
		chance = 0.1,
		icon = 5,
		price = 3,
		level = 5
	},
	archer_precision = {
		damage_factor = 2,
		class = "archers",
		chance = 0.1,
		price = 3,
		level = 5,
		icon = 5
	},
	
	barrack_el_elven_fencing = {
		class = "barracks",
		cost_factor = 0.9,
		icon = 6,
		price = 1,
		level = 1
	},
	barrack_el_expert_tactician = {
		rally_range_factor = 1.1,
		class = "barracks",
		icon = 7,
		price = 1,
		level = 2
	},
	barrack_el_enchanted_armor = {
		class = "barracks",
		armor_increase = 0.1,
		icon = 8,
		price = 2,
		level = 3
	},
	barrack_el_moon_forged_blades = {
		price = 2,
		icon = 9,
		class = "barracks",
		level = 4
	},
	barrack_el_cheat_death = {
		class = "barracks",
		chance = 0.1,
		revivechance = 0.1,
		icon = 10,
		price = 3,
		level = 5
	},
	
	barrack_survival = {
		health_factor = 1.1,
		class = "barracks",
		price = 1,
		level = 1,
		icon = 6
	},
	barrack_better_armor = {
		class = "barracks",
		armor_increase = 0.1,
		price = 1,
		level = 2,
		icon = 7
	},
	barrack_improved_deployment = {
		cooldown_factor = 0.8,
		rally_range_factor = 1.2,
		class = "barracks",
		price = 2,
		level = 3,
		icon = 8
	},
	barrack_survival_2 = {
		health_factor = 1.0909,
		class = "barracks",
		price = 2,
		level = 4,
		icon = 9
	},
	barrack_barbed_armor = {
		spiked_armor_factor = 0.1,
		class = "barracks",
		price = 3,
		level = 5,
		icon = 10
	},
	
	barrack_defensive_techniques = {
		class = "barracks",
		armor_increase = 0.1,
		icon = 6,
		price = 1,
		level = 1
	},
	barrack_boot_camp = {
		class = "barracks",
		icon = 7,
		price = 1,
		level = 2,
		health_factor = 1.1 - epsilon
	},
	barrack_esprit_des_corps = {
		rally_range_factor = 1.2,
		regen_factor = 1.2,
		class = "barracks",
		icon = 8,
		price = 2,
		level = 3
	},
	barrack_veteran_squad = {
		respawn_reduction = 2,
		class = "barracks",
		armor_increase = 0.1,
		icon = 9,
		price = 2,
		level = 4
	},
	barrack_courage = {
		regen_cooldown = 1,
		regen_factor = 0.01,
		class = "barracks",
		icon = 10,
		price = 3,
		level = 5
	},
	
	mage_el_crystal_focus = {
		range_factor = 1.05,
		class = "mages",
		icon = 11,
		price = 1,
		level = 1
	},
	mage_el_bane_spell = {
		damage_factor = 1.15,
		class = "mages",
		icon = 12,
		price = 1,
		level = 2
	},
	mage_el_crystal_gazing = {
		range_factor = 1.05,
		class = "mages",
		icon = 13,
		price = 2,
		level = 3
	},
	mage_el_empowerment = {
		damage_factor = 3,
		class = "mages",
		chance = 0.05,
		icon = 14,
		price = 2,
		level = 4
	},
	mage_el_alter_reality = {
		price = 3,
		icon = 15,
		class = "mages",
		level = 5
	},
	
	mage_rune_of_power = {
		range_factor = 1.1,
		class = "mages",
		icon = 11,
		price = 1,
		level = 1
	},
	mage_spell_of_penetration = {
		class = "mages",
		chance = 0.1,
		icon = 12,
		price = 1,
		level = 2
	},
	mage_eldrich_power = {
		damage_factor = 1.1,
		class = "mages",
		icon = 13,
		price = 2,
		level = 3
	},
	mage_wizard_academy = {
		class = "mages",
		cost_factor = 0.9,
		icon = 14,
		price = 2,
		level = 4
	},
	mage_brilliance = {
		class = "mages",
		icon = 15,
		price = 3,
		level = 5,
		damage_factors = {
			1,
			1.05,
			1.1,
			1.14,
			1.18,
			1.21,
			1.24,
			1.27,
			1.3
		}
	},
	
	mage_spell_reach = {
		range_factor = 1.1,
		class = "mages",
		price = 1,
		level = 1,
		icon = 11
	},
	mage_arcane_shatter = {
		mod = "mod_arcane_shatter",
		class = "mages",
		price = 1,
		level = 2,
		icon = 12
	},
	mage_hermetic_study = {
		class = "mages",
		cost_factor = 0.9,
		price = 2,
		level = 3,
		icon = 13
	},
	mage_empowered_magic = {
		damage_factor = 1.15,
		class = "mages",
		price = 2,
		level = 4,
		icon = 14
	},
	mage_slow_curse = {
		mod = "mod_slow_curse",
		class = "mages",
		price = 3,
		level = 5,
		icon = 15
	},
	
	stone_el_druid_hardened_boulders = {
		damage_factor = 1.1,
		class = "rocks",
		icon = 16,
		price = 1,
		level = 1
	},
	stone_el_druid_sharp_splinters = {
		damage_area_factor = 1.1,
		armor_increase = 0.5,
		class = "rocks",
		icon = 17,
		price = 1,
		level = 2
	},
	stone_el_druid_earth_mastery = {
		range_factor = 1.1,
		class = "rocks",
		icon = 18,
		price = 2,
		level = 3
	},
	stone_el_druid_heavy_load = {
		price = 3,
		icon = 19,
		class = "rocks",
		level = 4
	},
	stone_el_druid_shocking_impact = {
		price = 3,
		icon = 20,
		class = "rocks",
		level = 5
	},
	
	engineer_concentrated_fire = {
		damage_factor = 1.1,
		class = "rocks",
		price = 1,
		level = 1,
		icon = 16
	},
	engineer_range_finder = {
		range_factor = 1.1,
		class = "rocks",
		price = 1,
		level = 2,
		icon = 17
	},
	engineer_field_logistics = {
		class = "rocks",
		cost_factor = 0.9,
		price = 2,
		level = 3,
		icon = 18
	},
	engineer_industrialization = {
		class = "rocks",
		cost_factor = 0.75,
		price = 3,
		level = 4,
		icon = 19
	},
	engineer_efficiency = {
		price = 3,
		class = "rocks",
		level = 5,
		icon = 20
	},
	
	engineer_smoothbore = {
		range_factor = 1.1,
		class = "rocks",
		icon = 16,
		price = 1,
		level = 1
	},
	engineer_alchemical_powder = {
		class = "rocks",
		chance = 0.1,
		icon = 17,
		price = 1,
		level = 2
	},
	engineer_improved_ordnance = {
		damage_factor = 1.1,
		class = "rocks",
		icon = 18,
		price = 2,
		level = 3
	},
	engineer_gnomish_tinkering = {
		cooldown_factor = 0.9,
		class = "rocks",
		icon = 19,
		price = 3,
		level = 4
	},
	engineer_shock_and_awe = {
		class = "rocks",
		chance = 0.2,
		icon = 20,
		price = 3,
		level = 5
	},
	
	thunder_level_1 = {
		hits = 6,
		class = "thunder",
		icon = 21,
		price = 2,
		level = 1
	},
	thunder_level_2 = {
		price = 2,
		icon = 22,
		class = "thunder",
		level = 2
	},
	thunder_level_3 = {
		price = 3,
		icon = 23,
		class = "thunder",
		level = 3
	},
	thunder_level_4 = {
		price = 3,
		icon = 24,
		class = "thunder",
		level = 4
	},
	thunder_level_5 = {
		price = 3,
		icon = 25,
		class = "thunder",
		level = 5
	},

	rain_blazing_skies = {
		fireball_count_increase = 2,
		class = "thunder",
		damage_increase = 20,
		price = 2,
		level = 1,
		icon = 21
	},
	rain_scorched_earth = {
		price = 2,
		class = "thunder",
		level = 2,
		icon = 22
	},
	rain_bigger_and_meaner = {
		range_factor = 1.25,
		cooldown_reduction = 10,
		class = "thunder",
		damage_increase = 40,
		price = 3,
		level = 3,
		icon = 23
	},
	rain_blazing_earth = {
		cooldown_reduction = 10,
		class = "thunder",
		price = 3,
		level = 4,
		icon = 24
	},
	rain_cataclysm = {
		class = "thunder",
		damage_increase = 60,
		price = 3,
		level = 5,
		icon = 25
	},

	reinforcement_level_1 = {
		class = "reinforcements",
		template_name = "soldier_re_1",
		icon = 26,
		price = 2,
		level = 1
	},
	reinforcement_level_2 = {
		class = "reinforcements",
		template_name = "soldier_re_2",
		icon = 27,
		price = 3,
		level = 2
	},
	reinforcement_level_3 = {
		class = "reinforcements",
		template_name = "soldier_re_3",
		icon = 28,
		price = 3,
		level = 3
	},
	reinforcement_level_4 = {
		class = "reinforcements",
		template_name = "soldier_re_4",
		icon = 29,
		price = 3,
		level = 4
	},
	reinforcement_level_5 = {
		class = "reinforcements",
		template_name = "soldier_re_5",
		icon = 30,
		price = 4,
		level = 5
	}
}

function upgrades:set_levels(levels)
	for k, v in pairs(levels) do
		self.levels[k] = v
	end
end

function upgrades:has_upgrade(name)
	local u = self.list[name]

	return u and u.level <= self.levels[u.class] and (not self.max_level or u.level <= self.max_level)
end

function upgrades:get_upgrade(name)
	local u = self.list[name]

	if not u or u.level > self.levels[u.class] or not self.max_level or u.level > self.max_level then
		return nil
	else
		return u
	end
end

function upgrades:get_total_stars()
	local total = 0

	for k, v in pairs(self.list) do
		total = total + v.price
	end

	return total
end

G5_HP_RATE = 1.5
G5_ATK_RATE = 1.38
G5_CD_RATE = 0.72


function upgrades:enhance_hero5()
	local hero_list = {
		"hero_bird",
		"hero_builder",
		"hero_dragon_bone",
		"hero_dragon_gem",
		"hero_hunter",
		"hero_lumenir",
		"hero_mecha",
		"hero_muyrn",
		"hero_raelyn",
		"hero_robot",
		"hero_space_elf",
		"hero_venom",
		"hero_vesper",
		"hero_witch",
		"hero_dragon_arb",
		"hero_lava",
		"hero_spider",
		"hero_wukong",
		"hero_douzhanshengfo",
	}
	for k, hero in ipairs(hero_list) do
		for i= 1,10 do
			T(hero).hero.level_stats.hp_max[i] = math.ceil(T(hero).hero.level_stats.hp_max[i] * G5_HP_RATE)
			T(hero).hero.level_stats.regen_health[i] = math.ceil(T(hero).hero.level_stats.regen_health[i] * G5_HP_RATE)
			if T(hero).hero.level_stats.melee_damage_max then
				if hero == "hero_wukong" or hero == "hero_douzhanshengfo" then
					for j = 1,4 do
						T(hero).hero.level_stats.melee_damage_min[j][i] = math.ceil(T(hero).hero.level_stats.melee_damage_min[j][i] * G5_ATK_RATE)
						T(hero).hero.level_stats.melee_damage_max[j][i] = math.ceil(T(hero).hero.level_stats.melee_damage_max[j][i] * G5_ATK_RATE)
					end
				else
					T(hero).hero.level_stats.melee_damage_min[i] = math.ceil(T(hero).hero.level_stats.melee_damage_min[i] * G5_ATK_RATE)
					T(hero).hero.level_stats.melee_damage_max[i] = math.ceil(T(hero).hero.level_stats.melee_damage_max[i] * G5_ATK_RATE)
				end
			end
			if T(hero).hero.level_stats.ranged_damage_max then
				T(hero).hero.level_stats.ranged_damage_max[i] = math.ceil(T(hero).hero.level_stats.ranged_damage_max[i] * G5_ATK_RATE)
				T(hero).hero.level_stats.ranged_damage_min[i] = math.ceil(T(hero).hero.level_stats.ranged_damage_min[i] * G5_ATK_RATE)
			end
			if T(hero).hero.level_stats.damage_min then
				T(hero).hero.level_stats.damage_min[i] = math.ceil(T(hero).hero.level_stats.damage_min[i] * G5_ATK_RATE)
				T(hero).hero.level_stats.damage_max[i] = math.ceil(T(hero).hero.level_stats.damage_max[i] * G5_ATK_RATE)
			end
		end
		for i = 0, 3 do
			T(hero).hero.skills.ultimate.cooldown[i] = T(hero).hero.skills.ultimate.cooldown[i] * G5_CD_RATE
		end
	end
end

function upgrades:patch_templates(max_level)
--限制最大科技等级
	if max_level then
		self.max_level = max_level
	end
--4代原始范围
	user_data = storage:load_slot()
	local upgrades_FL = require("upgrades_FL")
	if user_data.liuhui.g4range_balance~= nil and user_data.liuhui.g4range_balance == false then --这个开关默认是打开的
		upgrades_FL:range_g4()
	end
--平衡性调整
	
	local upgrades_lockson = require("upgrades_lockson")
	if user_data.liuhui.balance and user_data.liuhui.balance == true then
		upgrades_FL:enhance1()
		upgrades_FL:enhance2()
		upgrades_FL:enhance3()
		upgrades_FL:enhance4()
		upgrades_FL:enhance5()
		upgrades_lockson:enhancecreeps()
	end
	
	--5代英雄折算科技
	upgrades:enhance_hero5()

	local u
--3代射手科技
	u = self:get_upgrade("archer_el_master_shooter")

	if u then
		for _, n in pairs({
			"tower_archer_1",
			"tower_archer_2",
			"tower_archer_3",
			"tower_arcane",
			"tower_silver",
			"tower_ground_archer",
			"tower_green_archer",			
			"tower_ewok_archer_re",			
			"tower_ewok_archer"		
		}) do
			T(n).tower.damage_factor = T(n).tower.damage_factor * u.damage_factor
		end
	end

	u = self:get_upgrade("archer_el_treesinged_bow")

	if u then
		for _, n in pairs({
			"tower_archer_1",
			"tower_archer_2",
			"tower_archer_3",
			"tower_arcane",
			"tower_silver",
			"tower_ground_archer",
			"tower_green_archer",			
			"tower_ewok_archer_re",			
			"tower_ewok_archer"					
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("archer_el_elven_training")

	if u then
		T("aura_arcane_burst").aura.damage_inc = T("aura_arcane_burst").aura.damage_inc * u.burst_damage_factor
		T("tower_arcane").attacks.list[2].cooldown_inc = -1
		T("mod_arrow_arcane_slumber").modifier.duration = T("mod_arrow_arcane_slumber").modifier.duration * u.slumber_duration_factor

		for _, chance_group in pairs(T("tower_silver").powers.sentence.chances) do
			for _, chance in pairs(chance_group) do
				chance = chance * u.sentence_chance_factor
			end
		end

		T("mod_arrow_silver_mark").received_damage_factor = T("mod_arrow_silver_mark").received_damage_factor * u.mark_damage_factor
		for _, n in pairs({
			"arrow_1",
			"arrow_2",
			"arrow_3",
			"arrow_arcane",
			"arrow_arcane_burst",
			"arrow_arcane_slumber",
			"arrow_silver",
			"arrow_silver_long",
			"arrow_silver_mark",
			"arrow_silver_mark_long",
			"arrow_ground_archer",
			"arrow_green_archer",
			"arrow_green_burst",
			"arrow_green_sentence",
			"spear_ewok",								
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end

	u = self:get_upgrade("archer_el_bloodletting_shoot")

	if u then
		for _, n in pairs({
			"arrow_1",
			"arrow_2",
			"arrow_3",
			"arrow_arcane",
			"arrow_arcane_burst",
			"arrow_arcane_slumber",
			"arrow_silver",
			"arrow_silver_long",
			"arrow_silver_mark",
			"arrow_silver_mark_long",
			"arrow_ground_archer",
			"arrow_green_archer",
			"arrow_green_burst",
			"arrow_green_sentence",
			"spear_ewok",				
		}) do
			local b = T(n).bullet

			if type(b.mod) == "table" then
				table.insert(b.mod, "mod_blood_elves")
			elseif b.mod ~= nil then
				b.mod = {
					b.mod,
					"mod_blood_elves"
				}
			else
				b.mod = "mod_blood_elves"
			end
		end
	end
--2代射手科技
	u = self:get_upgrade("archer_improved_aim")

	if u then
		for _, n in pairs({
			"g2_tower_archer_1",
			"g2_tower_archer_2",
			"g2_tower_archer_3",
			"tower_totem",
			"tower_crossbow",
			"tower_archer_hammerhold",
			"tower_archer_hammerhold_1",
			"tower_hammerhold_elite",
			"tower_archer_dwarf",
			"tower_pirate_watchtower",
			"tower_archer_dwarf_d",
			"tower_pirate_watchtower_d",			
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("archer_lumbermill")

	if u then
		for _, n in pairs({
			"g2_tower_archer_1",
			"g2_tower_archer_2",
			"g2_tower_archer_3",
			"tower_archer_hammerhold_1",
			"tower_hammerhold_elite"
		}) do
			T(n).tower.price = T(n).tower.price - u.cost_reduction
		end
	end

	u = self:get_upgrade("archer_focused_aim")

	if u then
		for _, n in pairs({
			"g2_arrow_1",
			"g2_arrow_2",
			"g2_arrow_3",
			"arrow_crossbow",
			"axe_totem",			
			"arrow_hammerhold_elite",
			"arrow_hammerhold",
			"arrow_hammerhold_1",

			"dwarf_shotgun",
			"pirate_watchtower_shotgun",	
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end

	u = self:get_upgrade("archer_master_marksmanship")

	if u then
		for _, n in pairs({
			"g2_tower_archer_1",
			"g2_tower_archer_2",
			"g2_tower_archer_3",
			"tower_totem",
			"tower_crossbow",
			"tower_archer_dwarf_d",
			"tower_pirate_watchtower_d",
			"tower_archer_hammerhold",
			"tower_archer_hammerhold_1",
			"tower_hammerhold_elite",
			"tower_archer_dwarf",
			"tower_pirate_watchtower",			
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end

		for _, n in pairs({
			"g2_arrow_1",
			"g2_arrow_2",
			"g2_arrow_3",
			"arrow_crossbow",
			"axe_totem",			
			"arrow_hammerhold_elite",
			"arrow_hammerhold",
			"arrow_hammerhold_1",
			"dwarf_shotgun",
			"pirate_watchtower_shotgun",			
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end
--1代射手科技
	local archer_towers = {
		"g1_tower_archer_1",
		"g1_tower_archer_2",
		"g1_tower_archer_3",
		"tower_ranger",
		"tower_musketeer"
	}

	u = self:get_upgrade("archer_salvage")

	if u then
		for _, n in pairs(archer_towers) do
			T(n).tower.refund_factor = u.refund_factor
		end
	end

	u = self:get_upgrade("archer_eagle_eye")

	if u then
		for _, n in pairs(archer_towers) do
			T(n).attacks.range = T(n).attacks.range * u.range_factor
		end

		T("aura_ranger_thorn").aura.radius = T("aura_ranger_thorn").aura.radius * u.range_factor
		T("tower_musketeer").attacks.list[2].range = T("tower_musketeer").attacks.list[2].range * u.range_factor
		T("tower_musketeer").attacks.list[3].range = T("tower_musketeer").attacks.list[3].range * u.range_factor
		T("tower_musketeer").attacks.list[4].range = T("tower_musketeer").attacks.list[4].range * u.range_factor
	end

	u = self:get_upgrade("archer_piercing")

	if u then
		for _, n in pairs({
			"g1_arrow_1",
			"g1_arrow_2",
			"g1_arrow_3",
			"arrow_ranger",
			"shotgun_musketeer",
			"shotgun_musketeer_sniper",
		}) do
			T(n).bullet.reduce_armor = u.reduce_armor_factor
		end
	end

	u = self:get_upgrade("archer_far_shots")

	if u then
		for _, n in pairs(archer_towers) do
			T(n).attacks.range = T(n).attacks.range * u.range_factor
		end

		T("aura_ranger_thorn").aura.radius = T("aura_ranger_thorn").aura.radius * u.range_factor
		T("tower_musketeer").attacks.list[2].range = T("tower_musketeer").attacks.list[2].range * u.range_factor
		T("tower_musketeer").attacks.list[3].range = T("tower_musketeer").attacks.list[3].range * u.range_factor
		T("tower_musketeer").attacks.list[4].range = T("tower_musketeer").attacks.list[4].range * u.range_factor
	end
--3代兵营科技

	u = self:get_upgrade("barrack_el_elven_fencing")

	if u then
		for _, n in pairs({
			"tower_barrack_1",
			"tower_barrack_2",
			"tower_barrack_3"
		}) do
			T(n).tower.price = math.ceil(T(n).tower.price * u.cost_factor)
		end
	end

	u = self:get_upgrade("barrack_el_expert_tactician")

	if u then
		for _, n in pairs({
			"tower_barrack_1",
			"tower_barrack_2",
			"tower_barrack_3",
			"tower_barrack_3_a",
			"tower_barrack_3_b",			
			"tower_blade",
			"tower_forest",
			"tower_drow",
			"tower_drow_d",
			"tower_baby_ashbite",
			"tower_baby_ashbite_d",							
			"tower_ewok",
			"tower_ewok_d",
			"tower_ewok_archer_re",					
			"tower_ewok_rework",
			"tower_elf_kr1",
			"tower_elf_1",					
		}) do
			T(n).barrack.rally_range = math.ceil(T(n).barrack.rally_range * u.rally_range_factor)
		end
	end

	u = self:get_upgrade("barrack_el_enchanted_armor")

	if u then
		for _, n in pairs({
			"soldier_barrack_1",
			"soldier_barrack_2",
			"soldier_barrack_3",
			"soldier_blade",
			"soldier_forest",						
			"soldier_drow",
			"soldier_baby_ashbite",			
			"soldier_ewok",
			"soldier_ewok_re",
			"soldier_ewok_re_1",			
		}) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
		end
	end

	u = self:get_upgrade("barrack_el_moon_forged_blades")

	if u then
		T("soldier_barrack_1").melee.attacks[1].mod = "mod_moon_forged_blades_barrack_1"
		T("soldier_barrack_2").melee.attacks[1].mod = "mod_moon_forged_blades_barrack_2"
		T("soldier_barrack_3").melee.attacks[1].mod = "mod_moon_forged_blades_barrack_3"
		T("soldier_blade").melee.attacks[1].mod = "mod_moon_forged_blades_blade"
		T("soldier_blade").melee.attacks[2].mod = "mod_moon_forged_blades_blade"
		T("soldier_blade").melee.attacks[3].mod = "mod_moon_forged_blades_blade"
		T("soldier_forest").melee.attacks[1].mod = "mod_moon_forged_blades_forest"
		T("soldier_drow").melee.attacks[1].mod = "mod_moon_forged_blades_drow"
		T("soldier_ewok").melee.attacks[1].mod = "mod_moon_forged_blades_drow"
		T("soldier_ewok_re").melee.attacks[1].mod = "mod_moon_forged_blades_drow"
		T("soldier_ewok_re_1").melee.attacks[1].mod = "mod_moon_forged_blades_drow"				
		T("soldier_elf_kr1").melee.attacks[1].mod = "mod_moon_forged_blades_blade"
		T("soldier_elf_1").melee.attacks[1].mod = "mod_moon_forged_blades_blade"
	end

	u = self:get_upgrade("barrack_el_cheat_death")

	if u then
		for _, n in pairs({
			"soldier_barrack_1",
			"soldier_barrack_2",
			"soldier_barrack_3",
			"soldier_blade",
			"soldier_forest",						
			"soldier_drow",
			"soldier_baby_ashbite",			
			"soldier_ewok",
			"soldier_ewok_re",
			"soldier_ewok_re_1",			
			"soldier_druid_bear",
			"soldier_elf_kr1",	
			"soldier_elf_1"		
		}) do
			T(n).revive.disabled = nil
		end
	end
	
--2代兵营科技
	u = self:get_upgrade("barrack_defensive_techniques")

	if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_templar",
			"soldier_assassin",
			"soldier_pirate_captain",
			"soldier_pirate_flamer",
			"soldier_pirate_anchor",
			"soldier_pirate_captain_2",
			"soldier_pirate_flamer_2",
			"soldier_pirate_anchor_2",
			"soldier_amazona",
			"soldier_amazona_re",			
			"soldier_legionnaire",
			"soldier_djinn",
			"soldier_legionnaire_2",
			"soldier_djinn_2",
			"soldier_cannibal"
		}) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
		end
	end

	u = self:get_upgrade("barrack_boot_camp")

	if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_templar",
			"soldier_assassin",
			"soldier_pirate_captain",
			"soldier_pirate_flamer",
			"soldier_pirate_anchor",
			"soldier_pirate_captain_2",
			"soldier_pirate_flamer_2",
			"soldier_pirate_anchor_2",
			"soldier_amazona",
			"soldier_amazona_re",			
			"soldier_legionnaire",
			"soldier_djinn",
			"soldier_legionnaire_2",
			"soldier_djinn_2",
			"soldier_dwarf",	
			"soldier_cannibal"		
		}) do
			T(n).health.hp_max = math.ceil(T(n).health.hp_max * u.health_factor)
		end
	end

	u = self:get_upgrade("barrack_esprit_des_corps")

	if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_templar",
			"soldier_assassin",
			"soldier_pirate_captain",
			"soldier_pirate_flamer",
			"soldier_pirate_anchor",
			"soldier_pirate_captain_2",
			"soldier_pirate_flamer_2",
			"soldier_pirate_anchor_2",
			"soldier_amazona",
			"soldier_amazona_re",			
			"soldier_legionnaire",
			"soldier_djinn",
			"soldier_legionnaire_2",
			"soldier_djinn_2",
			"soldier_dwarf",
		}) do
			T(n).regen.health = math.ceil(T(n).regen.health * u.regen_factor)
		end

		for _, n in pairs({
			"g2_tower_barrack_1",
			"g2_tower_barrack_2",
			"g2_tower_barrack_3",
			"g2_tower_barrack_3_a",
			"g2_tower_barrack_3_b",
			"tower_templar",
			"tower_assassin",
			"tower_barrack_dwarf",
			"tower_barrack_dwarf_d",			
			"tower_barrack_pirates",
			"tower_barrack_pirates_d",			
			"tower_barrack_pirate_captain",
			"tower_barrack_pirate_captain_2",  
			"tower_barrack_pirate_flamer_2",  
			"tower_barrack_pirate_anchor_2", 
			"tower_barrack_amazonas",
			"tower_barrack_amazonas_d",
			"tower_barrack_amazonas_re",						
			"tower_barrack_mercenaries",
			"tower_barrack_mercenaries_d",
			"tower_barrack_mercenaries_2",
			"tower_barrack_legion_2",
			"tower_barrack_djinn_2",
			"tower_barrack_canibal"
		}) do
			T(n).barrack.rally_range = math.ceil(T(n).barrack.rally_range * u.rally_range_factor)
		end
	end

	u = self:get_upgrade("barrack_veteran_squad")

	if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_templar",
			"soldier_assassin",
			"soldier_pirate_captain",
			"soldier_pirate_flamer",
			"soldier_pirate_anchor",
			"soldier_pirate_captain_2",
			"soldier_pirate_flamer_2",
			"soldier_pirate_anchor_2",
			"soldier_amazona",
			"soldier_amazona_re",			
			"soldier_legionnaire",
			"soldier_djinn",
			"soldier_legionnaire_2",
			"soldier_djinn_2",
			"soldier_dwarf",
			"soldier_cannibal"
		}) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
			T(n).health.dead_lifetime = T(n).health.dead_lifetime - u.respawn_reduction
		end

	end
--1代兵营科技
	local barrack_soldiers = {
		"g1_soldier_militia",
		"g1_soldier_footmen",
		"g1_soldier_knight",
		"soldier_paladin",
		"soldier_barbarian",
		"soldier_steam_troop",		
		"soldier_elf",
		"soldier_elf_kr1",
		"soldier_elf_1",		
		"soldier_sasquash",
		"soldier_sasquash_2",
		"soldier_s6_imperial_guard",
		"soldier_imperial_guard",
		"soldier_s6_imperial_guard_2",		
		"soldier_paladin_rider"
	}
	local barrack_towers = {
		"g1_tower_barrack_1",
		"g1_tower_barrack_2",
		"g1_tower_barrack_3",
		"tower_paladin",
		"tower_barbarian",
		"tower_steam_troop",		
		"tower_elf",
		"tower_elf_d",
		"tower_elf_kr1",
		"tower_elf_1",		
		"tower_sasquash",
		"tower_sasquash_d",
		"tower_sasquash_rework",		
	    "tower_imperial_patrol",
		"tower_imperial_patrol_2",
		"tower_imperialguard",		
		"tower_paladin_rider"
	}

	u = self:get_upgrade("barrack_survival")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.hp_max = km.round(T(n).health.hp_max * u.health_factor)
		end
	end

	u = self:get_upgrade("barrack_better_armor")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
		end
	end

	u = self:get_upgrade("barrack_improved_deployment")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.dead_lifetime = math.floor(T(n).health.dead_lifetime * u.cooldown_factor)
		end

		for _, n in pairs(barrack_towers) do
			T(n).barrack.rally_range = T(n).barrack.rally_range * u.rally_range_factor
		end
	end

	u = self:get_upgrade("barrack_survival_2")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.hp_max = km.round(T(n).health.hp_max * u.health_factor)
		end
	end

	u = self:get_upgrade("barrack_barbed_armor")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.spiked_armor = u.spiked_armor_factor
		end
		for _, n in pairs({
			"soldier_elemental",
			"soldier_ancient_guardian",			
			"soldier_magnus_illusion",
			"soldier_ingvar_ancestor",
			"soldier_alleria_wildcat",
			"hero_alleria",
			"hero_alleria_2",
			"hero_alleria_g3",
			"hero_gerald",
			"hero_gerald_2",
			"hero_bolin",
			"hero_bolin_2",
			"hero_magnus",
			"hero_magnus_2",
			"hero_ignus",
			"hero_ignus_2",
			"hero_malik",
			"hero_malik_2",
			"hero_denas",
			"hero_denas_2",
			"hero_ingvar",
			"hero_ingvar_2",
			"hero_elora",
			"hero_elora_2",
			"hero_oni",
			"hero_oni_2",
			"hero_hacksaw",
			"hero_hacksaw_2",
			"hero_thor",
			"hero_thor_2",
			"hero_10yr",
			"hero_10yr_2",
			"hero_voltaire",
			"hero_voltaire_2",
			"hero_viper",
			"hero_viper_2",
			"g1_soldier_militia",
			"g1_soldier_footmen",
			"g1_soldier_knight",
			"soldier_paladin",
			"soldier_barbarian",
			"soldier_steam_troop",		
			"soldier_elf",
			"soldier_elf_kr1",
			"soldier_elf_1",		
			"soldier_sasquash",
			"soldier_sasquash_2",
			"soldier_s6_imperial_guard",
			"soldier_imperial_guard",
			"soldier_s6_imperial_guard_2",		
			"soldier_paladin_rider"
		}) do
			T(n).health.spiked_armor = u.spiked_armor_factor
		end
		
	end

--3代法师科技
	u = self:get_upgrade("mage_el_crystal_focus")

	if u then
		for _, n in pairs({
			"tower_mage_1",
			"tower_mage_2",
			"tower_mage_3",
			"tower_wild_magus",
			"tower_high_elven",
			"tower_pixie",
			"tower_faerie_dragon",
			"tower_pixie_d",
			"tower_pixie_re",
			"tower_faerie_dragon_d",
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("mage_el_bane_spell")

	if u then
		for _, n in pairs({
			"bolt_elves_1",
			"bolt_elves_2",
			"bolt_elves_3",
			"bolt_wild_magus",
			"bolt_high_elven_strong",
			"bolt_faerie_dragon",
			--
			"fireball_baby_ashbite",
			"ray_high_elven_sentinel",
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end

	u = self:get_upgrade("mage_el_crystal_gazing")

	if u then
		for _, n in pairs({
			"tower_mage_1",
			"tower_mage_2",
			"tower_mage_3",
			"tower_wild_magus",
			"tower_high_elven",
			"tower_pixie",
			"tower_faerie_dragon",
			"tower_pixie_d",
			"tower_pixie_re",
			"tower_faerie_dragon_d",
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end
--2代法师科技
	u = self:get_upgrade("mage_rune_of_power")

	if u then
		for _, n in pairs({
			"g2_tower_mage_1",
			"g2_tower_mage_2",
			"g2_tower_mage_3",
			"tower_archmage",
			"tower_necromancer"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("mage_eldrich_power")

	if u then
		for _, n in pairs({
			"bolt_1",
			"bolt_2",
			"bolt_3",
			"bolt_archmage",
			"bolt_necromancer"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
		T("ray_neptune").bullet.damage_min_levels[1] = math.ceil(T("ray_neptune").bullet.damage_min_levels[1]*u.damage_factor)
		T("ray_neptune").bullet.damage_min_levels[2] = math.ceil(T("ray_neptune").bullet.damage_min_levels[2]*u.damage_factor)
		T("ray_neptune").bullet.damage_min_levels[3] = math.ceil(T("ray_neptune").bullet.damage_min_levels[3]*u.damage_factor)
		T("ray_neptune").bullet.damage_max_levels[1] = math.ceil(T("ray_neptune").bullet.damage_max_levels[1]*u.damage_factor)
		T("ray_neptune").bullet.damage_max_levels[2] = math.ceil(T("ray_neptune").bullet.damage_max_levels[2]*u.damage_factor)
		T("ray_neptune").bullet.damage_max_levels[3] = math.ceil(T("ray_neptune").bullet.damage_max_levels[3]*u.damage_factor)
	end

	u = self:get_upgrade("mage_wizard_academy")

	if u then
		for _, p in pairs({
			T("tower_archmage").powers.twister,
			T("tower_archmage").powers.blast,
			T("tower_necromancer").powers.pestilence,
			T("tower_necromancer").powers.rider,
			T("tower_neptune").powers.ray,
			T("tower_neptune_d").powers.ray,
		}) do
			p.price_base = math.floor(p.price_base * u.cost_factor)
			p.price_inc = math.floor(p.price_inc * u.cost_factor)
		end
	end

--1代法师科技
		local mage_towers = {
			"g1_tower_mage_1",
			"g1_tower_mage_2",
			"g1_tower_mage_3",
			"tower_arcane_wizard",
			"tower_sorcerer",
			"tower_time_wizard"
	}

	u = self:get_upgrade("mage_spell_reach")

	if u then
		for _, n in pairs(mage_towers) do
			T(n).attacks.range = T(n).attacks.range * u.range_factor
		end
	end

	u = self:get_upgrade("mage_arcane_shatter")

	if u then
		for _, n in pairs({
			"g1_bolt_1",
			"g1_bolt_2",
			"g1_bolt_3",
			"bolt_sorcerer",
			"ray_arcane",
			"bolt_time_wizard",			
			"bolt_elora_freeze",
			"bolt_elora_slow",
			"bolt_magnus",
			"bolt_magnus_illusion",
			"ray_sunray"
		}) do
			local mods = {
				u.mod
			}
			local b = T(n).bullet

			if b.mod then
				table.insert(mods, b.mod)
			end

			if b.mods then
				table.append(mods, b.mods)
			end

			b.mod = nil
			b.mods = mods
		end
	end

	u = self:get_upgrade("mage_hermetic_study")

	if u then
		for _, n in pairs(mage_towers) do
			T(n).tower.price = math.ceil(T(n).tower.price * u.cost_factor)
		end
		T("tower_sunray").tower.price = math.ceil(T("tower_sunray").tower.price*u.cost_factor)
		T("tower_sunray_d").tower.price = math.ceil(T("tower_sunray_d").tower.price*u.cost_factor)
	end

	u = self:get_upgrade("mage_empowered_magic")

	if u then
		for _, n in pairs({
			"g1_bolt_1",
			"g1_bolt_2",
			"g1_bolt_3",
			"bolt_sorcerer",
			"bolt_time_wizard",
			"ray_sunray"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end

		T("mod_ray_arcane").dps.damage_min = math.ceil(T("mod_ray_arcane").dps.damage_min * u.damage_factor)
		T("mod_ray_arcane").dps.damage_max = math.ceil(T("mod_ray_arcane").dps.damage_max * u.damage_factor)
	end

	u = self:get_upgrade("mage_slow_curse")

	if u then
		for _, n in pairs({
			"g1_bolt_1",
			"g1_bolt_2",
			"g1_bolt_3",
			"bolt_sorcerer",
			"ray_arcane",
			"bolt_elora_freeze",
			"bolt_elora_slow",
			"bolt_magnus",
			"bolt_magnus_illusion",			
			"bolt_time_wizard",
			"ray_sunray"
		}) do
			local mods = {
				u.mod
			}
			local b = T(n).bullet

			if b.mod then
				table.insert(mods, b.mod)
			end

			if b.mods then
				table.append(mods, b.mods)
			end

			b.mod = nil
			b.mods = mods
		end
	end
--3代巨炮科技
	

	u = self:get_upgrade("stone_el_druid_sharp_splinters")

	if u then
		for _, n in pairs({
			"rock_1",
			"rock_2",
			"rock_3",
			"rock_druid",
			"rock_entwood",
			"rock_firey_nut"			
		}) do
			T(n).bullet.damage_radius = math.ceil(T(n).bullet.damage_radius * u.damage_area_factor)
		end
		T("aura_razor_edge").aura.radius = math.floor(T("aura_razor_edge").aura.radius*u.damage_area_factor)
		T("aura_black_baby_dragon").aura.radius = math.floor(T("aura_black_baby_dragon").aura.radius*u.damage_area_factor)
		T("aura_black_baby_dragon_d").aura.radius = math.floor(T("aura_black_baby_dragon_d").aura.radius*u.damage_area_factor)
	end

	u = self:get_upgrade("stone_el_druid_earth_mastery")

	if u then
		for _, n in pairs({
			"tower_rock_thrower_1",
			"tower_rock_thrower_2",
			"tower_rock_thrower_3",
			"tower_druid",
			"tower_entwood",
			"tower_bastion",
			"tower_bastion_d"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("stone_el_druid_heavy_load")

	if u then
		for _, n in pairs({
			"rock_1",
			"rock_2",
			"rock_3",
			"rock_druid",
			"rock_entwood",
			"rock_firey_nut"
		}) do
			T(n).bullet.damage_type = bit.bor(DAMAGE_TRUE, DAMAGE_FX_EXPLODE)
		end
	end

	u = self:get_upgrade("stone_el_druid_shocking_impact")

	if u then
		for _, n in pairs({
			"rock_1",
			"rock_2",
			"rock_3",
			"rock_druid",
			"rock_entwood",
			"rock_firey_nut"
		}) do
			T(n).bullet.mod = "mod_shocking_impact"
		end
		T("aura_razor_edge").aura.mod = "mod_shocking_impact"
		T("aura_black_baby_dragon").aura.mods = {"mod_black_baby_dragon","mod_shocking_impact"}
		T("aura_black_baby_dragon_d").aura.mods = {"mod_black_baby_dragon","mod_shocking_impact",}		
	end

	u = self:get_upgrade("stone_el_druid_hardened_boulders")

	if u then
		for _, n in pairs({
			"rock_1",
			"rock_2",
			"rock_3",
			"rock_druid",
			"rock_entwood",
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
		T("aura_razor_edge").aura.duration = 2
		T("mod_black_baby_dragon").insert_damage = math.floor(T("mod_black_baby_dragon").insert_damage * u.damage_factor)		
	end
--2代巨炮科技
	u = self:get_upgrade("engineer_smoothbore")

	if u then
		for _, n in pairs({
			"g2_tower_engineer_1",
			"g2_tower_engineer_2",
			"g2_tower_engineer_3",
			"tower_dwaarp",
			"tower_sandworm",
			"tower_frankenstein"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end

		T("soldier_mecha").attacks.list[1].max_range = T("soldier_mecha").attacks.list[1].max_range * u.range_factor
		T("soldier_mecha").attacks.list[2].max_range = T("soldier_mecha").attacks.list[2].max_range * u.range_factor
	end

	u = self:get_upgrade("engineer_alchemical_powder")

	if u then
		for _, n in pairs({
			"bomb",
			"bomb_dynamite",
			"bomb_black",
			"bomb_mecha",
			"bomb_pirate_camp"
		}) do
			T(n).up_alchemical_powder_chance = u.chance
		end
		T("ray_frankenstein").bounce_damage_factor = 1
		T("ray_frankenstein").bounce_damage_factor_min = 1
	end

	u = self:get_upgrade("engineer_improved_ordnance")

	if u then
		for _, n in pairs({
			"bomb",
			"bomb_dynamite",
			"bomb_black",
			"bomb_mecha",
			"bomb_pirate_camp"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end

		T("tower_dwaarp").attacks.list[1].damage_min = T("tower_dwaarp").attacks.list[1].damage_min * u.damage_factor
		T("tower_dwaarp").attacks.list[1].damage_max = T("tower_dwaarp").attacks.list[1].damage_max * u.damage_factor
		T("mod_teeth").dps.damage_min = T("mod_teeth").dps.damage_min * u.damage_factor
		T("mod_teeth").dps.damage_max = T("mod_teeth").dps.damage_max * u.damage_factor
		T("mod_ray_frankenstein").dps.damage_min = math.ceil(T("mod_ray_frankenstein").dps.damage_min * u.damage_factor)
		T("mod_ray_frankenstein").dps.damage_max = math.ceil(T("mod_ray_frankenstein").dps.damage_max * u.damage_factor)
		T("mod_ray_frankenstein").dps.damage_inc = math.ceil(T("mod_ray_frankenstein").dps.damage_inc * u.damage_factor)			
	end

	u = self:get_upgrade("engineer_gnomish_tinkering")

	if u then
		for _, a in pairs({
			T("tower_dwaarp").attacks.list[2],
			T("tower_dwaarp").attacks.list[3],
			T("soldier_mecha").attacks.list[2],
			T("soldier_mecha").attacks.list[3],
			T("tower_sandworm").attacks.list[1],
			T("tower_sandworm").attacks.list[2],
			T("tower_frankenstein").attacks.list[1],	
			T("soldier_frankenstein").melee.attacks[2]
		}) do
			a.cooldown = a.cooldown * u.cooldown_factor
		end
		T("soldier_tremor").health.dead_lifetime = T("soldier_tremor").health.dead_lifetime * u.cooldown_factor
		T("soldier_frankenstein").health.dead_lifetime = T("soldier_frankenstein").health.dead_lifetime * u.cooldown_factor
	end

	u = self:get_upgrade("engineer_shock_and_awe")

	if u then
		for _, n in pairs({
			"bomb",
			"bomb_dynamite",
			"bomb_black",
			"bomb_mecha",
			"missile_mecha",
			"bomb_teeth",		
			"pirate_watchtower_bomb",
			"dwarf_barrel",
			"bomb_pirate_camp",			
		}) do
			T(n).up_shock_and_awe_chance = u.chance
		end
		T("soldier_frankenstein").melee.attacks[2].mod = "mod_frankenstein_pound"
	end
--1代巨炮科技
	local engineer_towers = {
		"g1_tower_engineer_1",
		"g1_tower_engineer_2",
		"g1_tower_engineer_3",
		"tower_bfg",
		"tower_tesla"
	}
	local engineer_bombs = {
		"g1_bomb",
		"g1_bomb_dynamite",
		"g1_bomb_black",
		"airstrike_steam_troop",
		"bomb_steam_troop"
	}

	u = self:get_upgrade("engineer_efficiency")
	if u then
--		T("bomb_bfg").bullet.damage_min = T("bomb_bfg").bullet.damage_max
		T("bomb_musketeer").bullet.damage_min_inc = T("bomb_musketeer").bullet.damage_max_inc
--		T("g1_bomb").bullet.damage_min = T("g1_bomb").bullet.damage_max
--		T("g1_bomb_dynamite").bullet.damage_min = T("g1_bomb_dynamite").bullet.damage_max
--		T("g1_bomb_black").bullet.damage_min = T("g1_bomb_black").bullet.damage_max
		T("missile_bfg").bullet.damage_min = T("missile_bfg").bullet.damage_max
		T("bomb_bfg_fragment").bullet.damage_min = T("bomb_bfg_fragment").bullet.damage_max
		T("ray_tesla").bounce_damage_factor = 1
		T("ray_tesla").bounce_damage_factor_min = 1
		T("b_tesla").bounce_damage_factor = 1
		T("b_tesla").bounce_damage_factor_min = 1
		T("bomb_steam_troop").bullet.damage_min = T("bomb_steam_troop").bullet.damage_max
		T("airstrike_steam_troop").bullet.damage_min = T("airstrike_steam_troop").bullet.damage_max		
		T("denas_catapult_rock").bullet.damage_min = T("denas_catapult_rock").bullet.damage_max
		T("bomb_mine_bolin").bullet.damage_min = T("bomb_mine_bolin").bullet.damage_max		
	end

	u = self:get_upgrade("engineer_concentrated_fire")

	if u then
		for _, n in pairs(engineer_bombs) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
		T("bomb_bfg").bullet.damage_min = math.floor(T("bomb_bfg").bullet.damage_min * u.damage_factor)
		T("bomb_bfg").bullet.damage_max = math.floor(T("bomb_bfg").bullet.damage_max * u.damage_factor)
		T("ray_tesla").bounce_damage_min = math.floor(T("ray_tesla").bounce_damage_min * u.damage_factor)
		T("ray_tesla").bounce_damage_max = math.floor(T("ray_tesla").bounce_damage_max * u.damage_factor)
	end

	u = self:get_upgrade("engineer_range_finder")

	if u then
		for _, n in pairs({
			"g1_tower_engineer_1",
			"g1_tower_engineer_2",
			"g1_tower_engineer_3",
			"tower_bfg",
			"tower_tesla"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end

		T("tower_bfg").attacks.list[1].range = math.ceil(T("tower_bfg").attacks.list[1].range * u.range_factor)
		T("tower_bfg").attacks.list[2].range_base = math.ceil(T("tower_bfg").attacks.list[2].range_base * u.range_factor)
		T("tower_tesla").attacks.list[1].range = math.ceil(T("tower_tesla").attacks.list[1].range * u.range_factor)
	end

	u = self:get_upgrade("engineer_field_logistics")

	if u then
		for _, n in pairs(engineer_towers) do
			T(n).tower.price = math.floor(T(n).tower.price * u.cost_factor)
		end
	end

	u = self:get_upgrade("engineer_industrialization")

	if u then
		for _, n in pairs({
			"tower_bfg",
			"tower_tesla",
		}) do
			for pk, pv in pairs(T(n).powers) do
				pv.price_base = math.floor(pv.price_base * u.cost_factor)
				pv.price_inc = math.floor(pv.price_inc * u.cost_factor)
			end
		end
	end

	T("power_thunder_control").user_power.level = self.levels.thunder
	u = self:get_upgrade("thunder_level_1")

	if u then
		T("power_thunder_control").thunders[1].count = 6
	end

	u = self:get_upgrade("thunder_level_2")

	if u then
		T("power_thunder_control").cooldown = 60
		T("power_thunder_control").thunders[1].damage_max = 100
		T("power_thunder_control").thunders[1].damage_min = 80
	end

	u = self:get_upgrade("thunder_level_3")

	if u then
		T("power_thunder_control").thunders[1].count = 8
		T("power_thunder_control").rain.disabled = nil
		T("power_thunder_control").slow.disabled = nil
		T("mod_power_thunder_slow").slow.factor = 0.6
	end

	u = self:get_upgrade("thunder_level_4")

	if u then
		T("mod_power_thunder_slow").slow.factor = 0.4
		T("power_thunder_control").thunders[1].damage_max = 130
		T("power_thunder_control").thunders[1].damage_min = 110
	end

	u = self:get_upgrade("thunder_level_5")

	if u then
		T("power_thunder_control").thunders[1].damage_max = 200
		T("power_thunder_control").thunders[1].damage_min = 150
		T("power_thunder_control").thunders[2].count = 6
	end

	T("power_fireball_control").user_power.level = self.levels.thunder
	u = self:get_upgrade("rain_blazing_skies")

	if u then
		T("power_fireball_control").fireball_count = T("power_fireball_control").fireball_count + u.fireball_count_increase
		T("power_fireball").bullet.damage_min = T("power_fireball").bullet.damage_min + u.damage_increase
		T("power_fireball").bullet.damage_max = T("power_fireball").bullet.damage_max + u.damage_increase
	end

	u = self:get_upgrade("rain_scorched_earth")

	if u then
		T("power_fireball").scorch_earth = true
	end

	u = self:get_upgrade("rain_bigger_and_meaner")

	if u then
		T("power_fireball_control").cooldown = T("power_fireball_control").cooldown - u.cooldown_reduction
		T("power_fireball").bullet.damage_radius = T("power_fireball").bullet.damage_radius * u.range_factor
		T("power_fireball").bullet.damage_min = T("power_fireball").bullet.damage_min + u.damage_increase
		T("power_fireball").bullet.damage_max = T("power_fireball").bullet.damage_max + u.damage_increase
	end

	u = self:get_upgrade("rain_blazing_earth")

	if u then
		T("power_fireball_control").cooldown = T("power_fireball_control").cooldown - u.cooldown_reduction
		T("power_scorched_earth").aura.damage_min = 20
		T("power_scorched_earth").aura.damage_max = 30
		T("power_scorched_earth").aura.duration = 10
		T("power_scorched_water").aura.damage_min = 20
		T("power_scorched_water").aura.damage_max = 30
		T("power_scorched_water").aura.duration = 10
	end

	u = self:get_upgrade("rain_cataclysm")

	if u then
		T("power_fireball_control").cataclysm_count = 5
		T("power_fireball").bullet.damage_min = T("power_fireball").bullet.damage_min + u.damage_increase
		T("power_fireball").bullet.damage_max = T("power_fireball").bullet.damage_max + u.damage_increase
	end

	if self.levels.reinforcements > 0 then
		local rl = math.min(self.levels.reinforcements, self.max_level)

		u = self:get_upgrade("reinforcement_level_" .. rl)

		if u then
			for i = 1, 3 do
				E:set_template("re1_current_" .. i, T(u.template_name .. "_" .. i))
				E:set_template("re2_current_" .. i, T(u.template_name .. "_" .. i))
				E:set_template("re3_current_" .. i, T(u.template_name .. "_" .. i))
			end

			T("power_reinforcements_control").cooldown = E:get_template("re1_current_1").cooldown
		end
	end

--5代防御塔科技
	local b = balance.upgrades
	local u
	local all_towers = {
		"tower_paladin_covenant_lvl",
		"tower_demon_pit_lvl",
		"tower_tricannon_lvl",
		"tower_royal_archers_lvl",
		"tower_arborean_emissary_lvl",
		"tower_elven_stargazers_lvl",
		"tower_arcane_wizard_lvl",
		"tower_necromancer_lvl",
		"tower_ballista_lvl",
		"tower_flamespitter_lvl",
		"tower_rocket_gunners_lvl",
		"tower_barrel_lvl",
		"tower_sand_lvl",
		"tower_ghost_lvl",
		"tower_ray_lvl",
		"tower_dark_elf_lvl",
		"tower_hermit_toad_lvl",
		"tower_dwarf_lvl",
		"tower_sparking_geode_lvl",
		"tower_pandas_lvl",
	}

	-- towers_war_rations 我方单位加血10%->20%
	u = true --self:get_upgrade("towers_war_rations")
	local b_towers_war_rations_hp_factor = b.towers_war_rations.hp_factor
	--5代兵营血量调整。
	--if user_data.liuhui.balance ~= nil and user_data.liuhui.balance == false then
	--	upgrades_FL:deenhance_barrack5()
	--	b_towers_war_rations_hp_factor = 1.1
	--end
	if u then
		for _, n in pairs(all_towers) do
			for i = 1, 4 do
				if T(n .. i).barrack then
					local st = T(T(n .. i).barrack.soldier_type)

					st.health.hp_max = km.round(st.health.hp_max * b_towers_war_rations_hp_factor)
				end
			end
		end

		for i = 1, 4 do
			for _, n in pairs({
				"soldier_tower_necromancer_skeleton_lvl",
				"soldier_tower_necromancer_skeleton_golem_lvl",
				"soldier_tower_demon_pit_basic_attack_lvl"
			}) do
				T(n .. i).health.hp_max = km.round(T(n .. i).health.hp_max * b_towers_war_rations_hp_factor)
			end
		end

		T("big_guy_tower_demon_pit_lvl4").health.hp_max = km.round(T("big_guy_tower_demon_pit_lvl4").health.hp_max * b_towers_war_rations_hp_factor)
		T("soldier_tower_barrel_skill_warrior").war_rations_hp_factor = b_towers_war_rations_hp_factor
		T("tower_paladin_covenant_soldier_lvl4").powers.lead.b.hp = T("tower_paladin_covenant_soldier_lvl4").powers.lead.b.hp * b_towers_war_rations_hp_factor
		T("soldier_tower_dark_elf").war_rations_hp_factor = b_towers_war_rations_hp_factor

		for i = 1, 4 do
			T("soldier_tower_pandas_red_lvl" .. i).health.hp_max = km.round(T("soldier_tower_pandas_red_lvl" .. i).health.hp_max * b.towers_war_rations.hp_factor)
			T("soldier_tower_pandas_green_lvl" .. i).health.hp_max = km.round(T("soldier_tower_pandas_green_lvl" .. i).health.hp_max * b.towers_war_rations.hp_factor)
		end
	end

	-- towers_wise_investment 防御塔售价返还90%金币
	u = true --trueself:get_upgrade("towers_wise_investment")
	if u then
		for _, n in pairs(all_towers) do
			for i = 1, 4 do
				T(n .. i).tower.refund_factor = b.towers_wise_investment.refund_factor
			end
		end
	end

	-- towers_scoping_mechanism 防御塔范围提升10%
	u = true -- self:get_upgrade("towers_scoping_mechanism")
	if u then
		local range_factor = b.towers_scoping_mechanism.range_factor
		local rally_range_factor = b.towers_scoping_mechanism.rally_range_factor

		for _, n in pairs(all_towers) do
			for i = 1, 4 do
				local t = T(n .. i)

				if t.barrack then
					t.barrack.rally_range = t.barrack.rally_range * rally_range_factor
				end

				if t.attacks then
					t.attacks.range = t.attacks.range * range_factor
				end
			end
		end
	end

	-- towers_golden_time 提前召唤多给80%金币，不给这个科技
	u = true --self:get_upgrade("towers_golden_time")

	--if u then
	--	GS.early_wave_reward_per_second = GS.early_wave_reward_per_second_default * b.towers_golden_time.early_wave_reward_per_second_factor
	--else
	--	GS.early_wave_reward_per_second = GS.early_wave_reward_per_second_default
	--end

	-- towers_improved_formulas 智能瞄准
	u = true --self:get_upgrade("towers_improved_formulas")
	if u then
		local r_factor = b.towers_improved_formulas.range_factor

		for _, n in pairs({
			"soldier_tower_demon_pit_basic_attack_lvl"
		}) do
			for i = 1, 4 do
				for j = 1, 4 do
					T(n .. i).explosion_range[j] = T(n .. i).explosion_range[j] * r_factor
					T(n .. i).explosion_damage_min[j] = T(n .. i).explosion_damage_max[j]
				end
			end
		end

		for i = 1, 4 do
			T("tower_tricannon_bomb_" .. i).bullet.damage_radius = T("tower_tricannon_bomb_" .. i).bullet.damage_radius * r_factor
			T("tower_tricannon_bomb_" .. i).bullet.damage_min = T("tower_tricannon_bomb_" .. i).bullet.damage_max
		end

		for i = 1, 4 do
			T("bullet_tower_hermit_toad_engineer_basic_lvl" .. i).bullet.damage_radius = T("bullet_tower_hermit_toad_engineer_basic_lvl" .. i).bullet.damage_radius * r_factor
		end

		for i = 1, 4 do
			T("bullet_tower_hermit_toad_engineer_basic_lvl" .. i).bullet.damage_min = T("bullet_tower_hermit_toad_engineer_basic_lvl" .. i).bullet.damage_max
		end

		T("tower_tricannon_bomb_bombardment_bomb").bullet.damage_radius = T("tower_tricannon_bomb_bombardment_bomb").bullet.damage_radius * r_factor
		for i = 1,3 do
			T("tower_tricannon_bomb_bombardment_bomb").bullet.damage_min_config[i] = T("tower_tricannon_bomb_bombardment_bomb").bullet.damage_max_config[i]
		end

		T("soldier_tower_rocket_gunners_lvl4").melee.attacks[2].damage_radius = T("soldier_tower_rocket_gunners_lvl4").melee.attacks[2].damage_radius * r_factor
		T("bullet_tower_ballista_skill_bomb").bullet.damage_radius = T("bullet_tower_ballista_skill_bomb").bullet.damage_radius * r_factor
		--for i = 1,3 do
		--	T("bullet_tower_ballista_skill_bomb").bullet.damage_min_config[i] = T("bullet_tower_ballista_skill_bomb").bullet.damage_max_config[i]
		--end

		T("bullet_tower_flamespitter_skill_bomb").bullet.damage_radius = T("bullet_tower_flamespitter_skill_bomb").bullet.damage_radius * r_factor
		T("controller_tower_flamespitter_column").radius_in = T("controller_tower_flamespitter_column").radius_in * r_factor
		T("controller_tower_flamespitter_column").radius_out = T("controller_tower_flamespitter_column").radius_out * r_factor

		for i = 1, 4 do
			T("bullet_tower_barrel_lvl" .. i).bullet.damage_radius = T("bullet_tower_barrel_lvl" .. i).bullet.damage_radius * r_factor
			T("bullet_tower_barrel_lvl" .. i).bullet.damage_min = T("bullet_tower_barrel_lvl" .. i).bullet.damage_max
		end

		T("aura_bullet_tower_barrel_skill_barrel").explosion_damage_radius = T("aura_bullet_tower_barrel_skill_barrel").explosion_damage_radius * r_factor
		for i = 1,3 do
			T("aura_bullet_tower_barrel_skill_barrel").explosion_damage_min[i] = T("aura_bullet_tower_barrel_skill_barrel").explosion_damage_max[i]
		end
	end

	-- towers_favorite_customer 最后一级技能价格下降
	-- 由于提前开波的技能在此无法复现，所以提升本技能的效果。
	-- 1级技能返还20%金币，3级技能返还25%金币。
	--u = self:get_upgrade("towers_favorite_customer")

	if true then
		for _, n in pairs({
		"tower_paladin_covenant_lvl4",
		"tower_demon_pit_lvl4",
		"tower_tricannon_lvl4",
		"tower_royal_archers_lvl4",
		"tower_arborean_emissary_lvl4",
		"tower_elven_stargazers_lvl4",
		"tower_arcane_wizard_lvl4",
		"tower_necromancer_lvl4",
		"tower_ballista_lvl4",
		"tower_flamespitter_lvl4",
		"tower_rocket_gunners_lvl4",
		"tower_barrel_lvl4",
		"tower_sand_lvl4",
		"tower_ghost_lvl4",
		"tower_ray_lvl4",
		"tower_dark_elf_lvl4",
		"tower_hermit_toad_lvl4",
		"tower_dwarf_lvl4",
		"tower_sparking_geode_lvl4",
		"tower_pandas_lvl4",
			--"tower_entwood"
		}) do
			for pk, pv in pairs(T(n).powers) do
				pv.price_inc = math.floor(pv.price_inc * b.towers_favorite_customer.refund_cost_factor)
				if pv.price_inc == 0 then
					pv.price_base = math.floor(pv.price_base * b.towers_favorite_customer.refund_cost_factor_one_level)
				end
			end
		end
	end

	--if u then
	--	u.refund_cost_factor = b.towers_favorite_customer.refund_cost_factor
	--	u.refund_cost_factor_one_level = b.towers_favorite_customer.refund_cost_factor_one_level
	--end

	--towers_keen_accuracy 技能CD降低20%
	u = true --self:get_upgrade("towers_keen_accuracy")

	if u then
		for _, n in pairs(all_towers) do
			local template = T(n .. 4)

			for _, p in pairs(T(n .. 4).powers) do
				if p.cooldown then
					for k, _ in pairs(p.cooldown) do
						p.cooldown[k] = p.cooldown[k] * b.towers_keen_accuracy.cooldown_mult
					end
				end
			end
		end
	end

	-- towers_royal_training 复活时间-2秒，只缩短复活时间，不缩短援军复活时间。
	-- 为了折合复活科技，复活时间-3秒。
	u = true--self:get_upgrade("towers_royal_training")

	if u then
		for _, n in pairs(all_towers) do
			if n == "tower_pandas_lvl" then
				for i = 1, 4 do
					T(n .. i).attacks.list[2].cooldown = T(n .. i).attacks.list[2].cooldown - b.towers_royal_training.reduce_cooldown
				end
			else
				for i = 1, 4 do
					if T(n .. i).barrack then
						local st = T(T(n .. i).barrack.soldier_type)

						st.health.dead_lifetime = st.health.dead_lifetime - b.towers_royal_training.reduce_cooldown
					end
				end
			end
		end

		for i = 1, 3 do
			T("tower_barrel_lvl4").attacks.list[3].cooldown[i] = T("tower_barrel_lvl4").attacks.list[3].cooldown[i] - b.towers_royal_training.reinforcements_cooldown
		end

		T("re_current_1").cooldown = T("re_current_1").cooldown - b.towers_royal_training.reinforcements_cooldown
	end

	u = true --self:get_upgrade("alliance_shady_company")

	if u then
		local heroes = user_data.liuhui.g5_hero_dark_count
		--local heroes = 0

		--for _, h in ipairs(slot.heroes.team) do
		--	if T(h).hero.team == TEAM_DARK_ARMY then
		--		heroes = heroes + 1
		--	end
		--end

		if heroes and heroes > 0 then
			local tower_t, bullet_t, soldier_t
			local d_mult = 1 + b.alliance_shady_company.damage_extra * heroes

			for i = 1, 4 do
				tower_t = T("tower_royal_archers_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			tower_t = T("tower_arcane_wizard_lvl1")
			bullet_t = T(tower_t.attacks.list[1].bullet)

			for i = 1, 4 do
				bullet_t.bullet.damage_min_config[i] = math.ceil(bullet_t.bullet.damage_min_config[i] * d_mult)
				bullet_t.bullet.damage_max_config[i] = math.ceil(bullet_t.bullet.damage_max_config[i] * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_paladin_covenant_lvl" .. i)
				soldier_t = T(tower_t.barrack.soldier_type)
				soldier_t.melee.attacks[1].damage_min = math.ceil(soldier_t.melee.attacks[1].damage_min * d_mult)
				soldier_t.melee.attacks[1].damage_max = math.ceil(soldier_t.melee.attacks[1].damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_arborean_emissary_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			tower_t = T("tower_elven_stargazers_lvl1")
			bullet_t = T(tower_t.attacks.list[1].bullet)

			for i = 1, 4 do
				bullet_t.bullet.damage_min_config[i] = math.ceil(bullet_t.bullet.damage_min_config[i] * d_mult)
				bullet_t.bullet.damage_max_config[i] = math.ceil(bullet_t.bullet.damage_max_config[i] * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_tricannon_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_demon_pit_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				soldier_t = T(bullet_t.bullet.hit_payload)
				soldier_t.melee.attacks[1].damage_min = math.ceil(soldier_t.melee.attacks[1].damage_min * d_mult)
				soldier_t.melee.attacks[1].damage_max = math.ceil(soldier_t.melee.attacks[1].damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_ballista_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_rocket_gunners_lvl" .. i)
				soldier_t = T(tower_t.barrack.soldier_type)
				soldier_t.melee.attacks[1].damage_min = math.ceil(soldier_t.melee.attacks[1].damage_min * d_mult)
				soldier_t.melee.attacks[1].damage_max = math.ceil(soldier_t.melee.attacks[1].damage_max * d_mult)
				bullet_t = T(soldier_t.ranged.attacks[1].bullet)
				bullet_t.bullet.damage_min_config[i] = math.ceil(bullet_t.bullet.damage_min_config[i] * d_mult)
				bullet_t.bullet.damage_max_config[i] = math.ceil(bullet_t.bullet.damage_max_config[i] * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_necromancer_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_flamespitter_lvl" .. i)

				local aura_t = T(tower_t.attacks.list[1].aura)

				aura_t.damage_min_config[i] = math.ceil(aura_t.damage_min_config[i] * d_mult)
				aura_t.damage_max_config[i] = math.ceil(aura_t.damage_max_config[i] * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_barrel_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_sand_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_ghost_lvl" .. i)
				soldier_t = T(tower_t.barrack.soldier_type)
				soldier_t.melee.attacks[1].damage_min = math.ceil(soldier_t.melee.attacks[1].damage_min * d_mult)
				soldier_t.melee.attacks[1].damage_max = math.ceil(soldier_t.melee.attacks[1].damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_ray_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			tower_t = T("tower_ray_lvl4")
			bullet_t = T(tower_t.attacks.list[2].bullet)
			bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
			bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)

			for i = 1, 4 do
				tower_t = T("tower_dwarf_lvl" .. i)
				soldier_t = T(tower_t.barrack.soldier_type)
				soldier_t.melee.attacks[1].damage_min = math.ceil(soldier_t.melee.attacks[1].damage_min * d_mult)
				soldier_t.melee.attacks[1].damage_max = math.ceil(soldier_t.melee.attacks[1].damage_max * d_mult)
			end
			
			for i = 1, 4 do
				tower_t = T("tower_dark_elf_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_hermit_toad_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_hermit_toad_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[2].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_sparking_geode_lvl" .. i)
				bullet_t = T(tower_t.attacks.list[1].bullet)
				bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
				bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
			end

			for i = 1, 4 do
				tower_t = T("tower_pandas_lvl" .. i)

				for _, b_cfg in pairs(tower_t.attacks.list[1].bullet_list) do
					bullet_t = T(b_cfg.b)
					bullet_t.bullet.damage_min = math.ceil(bullet_t.bullet.damage_min * d_mult)
					bullet_t.bullet.damage_max = math.ceil(bullet_t.bullet.damage_max * d_mult)
				end

				for _, s in pairs(tower_t.attacks.list[2].soldiers) do
					soldier_t = T(s)
					soldier_t.melee.attacks[1].damage_min = math.ceil(soldier_t.melee.attacks[1].damage_min * d_mult)
					soldier_t.melee.attacks[1].damage_max = math.ceil(soldier_t.melee.attacks[1].damage_max * d_mult)
				end
			end
		end
	end

	u = true --self:get_upgrade("alliance_friends_of_the_crown")

	if u then
		--local cost_red = 0

		--for _, h in ipairs(slot.heroes.team) do
		--	if T(h).hero.team == TEAM_LINIREA then
		--		cost_red = cost_red + b.alliance_friends_of_the_crown.cost_red_per_hero
		--	end
		--end
		local cost_red = 5*(2 - user_data.liuhui.g5_hero_dark_count)

		if cost_red > 0 then
			for _, n in pairs(all_towers) do
				for i = 1, 4 do
					T(n .. i).tower.price = T(n .. i).tower.price - cost_red
				end
			end
		end
	end

--5代援军科技，只能在5代援军的时候使用
	u = self:get_upgrade("reinforcement_level_1")

	if u and game and game.store and game.store.level_idx and game.store.level_idx >= 101 then
		local portrait_idxs = {
			25,
			26,
			27
		}

		for i = 1, 3 do
			local t = T("soldier_reinforcement_basic_0" .. i)

			t.unit.damage_factor = b.reinforcements_master_blacksmiths.damage_factor
			t.health.armor = b.reinforcements_master_blacksmiths.armor
			t.render.sprites[1].prefix = "reinforcements_lvl2_0" .. i
			t.info.portrait = "gui_bottom_info_image_soldiers_00" .. portrait_idxs[i]
		end
	end

	u = self:get_upgrade("reinforcement_level_2")

	if u and game and game.store and game.store.level_idx and game.store.level_idx >= 101  then
		for i = 1, 3 do
			local t = T("soldier_reinforcement_basic_0" .. i)

			t.health.hp_max = t.health.hp_max * b.reinforcements_intense_workout.hp_factor
			t.reinforcement.duration = t.reinforcement.duration + b.reinforcements_intense_workout.duration_extra
		end
	end

	u = self:get_upgrade("reinforcement_level_3")

	if u and user_data.liuhui.reinforcement_5 ~= "dark"  and game and game.store and game.store.level_idx and game.store.level_idx >= 101  then
		for i = 1, 2 do
			local num = km.zmod(i, 2)

			E:set_template("re_current_" .. i, E:get_template("soldier_reinforcement_rebel_militia_0" .. num))
		end
	end

	u = self:get_upgrade("reinforcement_level_3")

	if u and user_data.liuhui.reinforcement_5 == "dark" and game and game.store and game.store.level_idx and game.store.level_idx >= 101  then
		for i = 1, 1 do
			local num = km.zmod(i, 2)

			E:set_template("re_current_" .. i, E:get_template("soldier_reinforcement_shadow_archer_0" .. num))
		end
	end

	u = self:get_upgrade("reinforcement_level_2")

	if u and game and game.store and game.store.level_idx and game.store.level_idx >= 101  then
		T("re_current_1").cooldown = T("re_current_1").cooldown - b.towers_royal_training.reinforcements_cooldown
	end

	u = self:get_upgrade("reinforcement_level_4")

	if u and user_data.liuhui.reinforcement_5 ~= "dark" and game and game.store and game.store.level_idx and game.store.level_idx >= 101  then
		local portrait_idxs = {
			31,
			33
		}

		for i = 1, 2 do
			local num = km.zmod(i, 2)
			local t = T("soldier_reinforcement_rebel_militia_0" .. num)

			t.health.spiked_armor = b.reinforcements_thorny_armor.spiked_armor
			t.render.sprites[1].prefix = "reinforcements_lvl4_0" .. num
			t.info.portrait = "gui_bottom_info_image_soldiers_00" .. portrait_idxs[i]
		end
	end

	u = self:get_upgrade("reinforcement_level_4")

	if u and user_data.liuhui.reinforcement_5 == "dark" and game and game.store and game.store.level_idx and game.store.level_idx >= 101  then
		for i = 1, 1 do
			local num = km.zmod(i, 2)
			local t = T("soldier_reinforcement_shadow_archer_0" .. num)

			t.ranged.attacks[1].max_range = t.ranged.attacks[1].max_range + b.reinforcements_night_veil.extra_range
			t.ranged.attacks[1].cooldown = t.ranged.attacks[1].cooldown - b.reinforcements_night_veil.cooldown_red
			t.render.sprites[1].prefix = "reinforcements_lvl4_0" .. num + 2
			t.info.portrait = "gui_bottom_info_image_soldiers_0032"

			local t = T("arrow_soldier_re_shadow_archer")

			t.render.sprites[1].name = "reinforcements_lvl4_03_arrow"
		end
	end

	--出口科技
	if game and game.store and game.store.level_idx and game.store.level_idx >= 101 then
			c_upg = E:create_entity("controller_upgrades_alliance")
			c_upg.seal = "decal_upgrade_alliance_seal_of_punishment"
			c_upg.coil = "decal_upgrade_alliance_flux_altering_coils"
			simulation:queue_insert_entity_exit(c_upg)
	end
	

	--所有科技结算完之后：refund_factor在随机塔模式下降低到0.6
	if user_data.liuhui.rand_tower and user_data.liuhui.rand_tower > 0 then
		for _, t in pairs(E:filter_templates("tower")) do
			t.tower.refund_factor = 0.6
		end
	end

end

return upgrades