-- chunkname: @./kr1/upgrades.lua

local log = require("klua.log"):new("upgrades")
local km = require("klua.macros")
local E = require("entity_db")
local bit = require("bit")

require("constants")

local function T(name)
	return E:get_template(name)
end

local function DP(desktop, phone)
	return not (KR_TARGET ~= "phone" and KR_TARGET ~= "tablet") and phone or desktop
end

local epsilon = 1e-09
local upgrades = {}

upgrades.max_level = nil
upgrades.levels = {}
upgrades.levels.archers = 0
upgrades.levels.barracks = 0
upgrades.levels.mages = 0
upgrades.levels.engineers = 0
upgrades.levels.rain = 0
upgrades.levels.reinforcements = 0
upgrades.display_order = {
	"archers",
	"barracks",
	"mages",
	"engineers",
	"rain",
	"reinforcements"
}
upgrades.list = {
	archer_salvage = {
		range_factor = 1.1,
		class = "archers",
		price = 1,
		level = 1,
		icon = DP(13, 6)
	},
	archer_eagle_eye = {
		damage_factor = 1.1,
		class = "archers",
		price = 1,
		level = 2,
		icon = DP(14, 7)
	},
	archer_piercing = {
		class = "archers",
		reduce_armor_factor = 0.03,
		max_reduction = 0.25,
		price = 2,
		level = 3,
		icon = DP(15, 8)
	},
	archer_far_shots = {
		speed_factor = 1.1,
		class = "archers",
		price = 2,
		level = 4,
		icon = DP(16, 9)
	},
	archer_precision = {
		damage_factor = 2,
		bounce_range = 120,
		class = "archers",
		chance = 0.15,
		bullet = "dark_shard",
		price = 3,
		level = 5,
		icon = DP(17, 10)
	},
	barrack_survival = {
		rally_range_factor = 1.1,
		armor_increase = 0.15,
		class = "barracks",
		price = 1,
		level = 1,
		icon = DP(8, 1)
	},
	barrack_better_armor = {
		class = "barracks",
		health_factor = 1.3,
		price = 2,
		level = 4,
		icon = DP(9, 2)
	},
	barrack_improved_deployment = {
		pickpocket_chance = 0.1,
		pickpocket_amount = 2,
		class = "barracks",
		price = 2,
		level = 3,
		icon = DP(10, 3)
	},
	barrack_survival_2 = {
		damage_factor = 1.1,
		class = "barracks",
		price = 1,
		level = 2,
		icon = DP(11, 4)
	},
	barrack_barbed_armor = {
		true_armor = 10,
		class = "barracks",
		price = 3,
		level = 5,
		icon = DP(12, 5)
	},
	mage_spell_reach = {
		damage_factor = 1.15,
		class = "mages",
		price = 1,
		level = 1,
		icon = DP(18, 11)
	},
	mage_arcane_shatter = {
		mod = "mod_v_shatter",
		chance = 0.1,
		class = "mages",
		price = 1,
		level = 2,
		icon = DP(19, 12)
	},
	mage_hermetic_study = {
		class = "mages",
		range_factor = 1.15,
		price = 2,
		level = 3,
		icon = DP(20, 13)
	},
	mage_empowered_magic = {
		damage_factor = 2,
		chance = 0.1,
		class = "mages",
		price = 2,
		level = 4,
		icon = DP(21, 14)
	},
	mage_slow_curse = {
		mod = "mod_slow_curse",
		class = "mages",
		price = 3,
		level = 5,
		icon = DP(22, 15)
	},
	engineer_concentrated_fire = {
		area_factor = 1.2,
		class = "engineers",
		price = 1,
		level = 1,
		icon = DP(23, 16)
	},
	engineer_range_finder = {
		damage_factor = 1.1,
		class = "engineers",
		price = 1,
		level = 2,
		icon = DP(24, 17)
	},
	engineer_field_logistics = {
		count = 3,
		damage_factor = 0.2,
		class = "engineers",
		price = 2,
		level = 3,
		icon = DP(25, 18)
	},
	engineer_industrialization = {
		class = "engineers",
		cost_factor = 0.85,
		price = 3,
		level = 4,
		icon = DP(26, 19)
	},
	engineer_efficiency = {
		price = 3,
		bonus = 0.05,
		max_bonus = 1.25,
		class = "engineers",
		level = 5,
		icon = DP(27, 20)
	},
	rain_blazing_skies = {
		strike_count_increase = 3,
		class = "rain",
		damage_increase = 25,
		price = 2,
		level = 1,
		icon = DP(3, 26)
	},
	rain_scorched_earth = {
		cooldown_reduction = 20,
		price = 2,
		class = "rain",
		level = 2,
		icon = DP(4, 27)
	},
	rain_bigger_and_meaner = {
		wait_reduction = 0.2,
		cooldown_reduction = 10,
		interval_reduction = 0.5,
		class = "rain",
		strike_count_increase = 2,
		price = 3,
		level = 3,
		icon = DP(5, 28)
	},
	rain_blazing_earth = {
		slow_factor = 0.25,
		damage_increase = 40,
		class = "rain",
		price = 3,
		level = 4,
		icon = DP(6, 29)
	},
	rain_cataclysm = {
		class = "rain",
		damage_increase = 40,
		cataclysm_count = 20,
		price = 3,
		level = 5,
		icon = DP(7, 30)
	},
	reinforcement_level_1 = {
		class = "reinforcements",
		template_name = "re_farmer_well_fed",
		price = 2,
		level = 1,
		icon = DP(28, 21)
	},
	reinforcement_level_2 = {
		class = "reinforcements",
		template_name = "re_conscript",
		price = 3,
		level = 2,
		icon = DP(29, 22)
	},
	reinforcement_level_3 = {
		class = "reinforcements",
		template_name = "re_warrior",
		price = 3,
		level = 3,
		icon = DP(30, 23)
	},
	reinforcement_level_4 = {
		class = "reinforcements",
		template_name = "re_legionnaire",
		price = 3,
		level = 4,
		icon = DP(1, 24)
	},
	reinforcement_level_5 = {
		class = "reinforcements",
		template_name = "re_legionnaire_ranged",
		price = 4,
		level = 5,
		icon = DP(2, 25)
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

function upgrades:get_upgrade_data(name)
	local u = self.list[name]

	if not u then
		log.error("upgrade %s not found", u)

		return nil
	end

	return u
end

function upgrades:get_total_stars()
	local total = 0

	for k, v in pairs(self.list) do
		total = total + v.price
	end

	return total
end

function upgrades:patch_templates(max_level)
	if max_level then
		self.max_level = max_level
	end

	local u
	local archer_towers = {
		"tower_archer_1_v",
		"tower_archer_2_v",
		"tower_archer_3_v",
		"tower_deathcoil"
	}

	u = self:get_upgrade("archer_salvage")

	if u then
		for _, n in pairs(archer_towers) do
			T(n).attacks.range = T(n).attacks.range * u.range_factor
		end
	end

	u = self:get_upgrade("archer_eagle_eye")

	if u then
		for _, n in pairs({
			"arrow_1_v",
			"arrow_2_v",
			"arrow_3_v",
			"bolt_sniper"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end

	u = self:get_upgrade("archer_piercing")

	if u then
		for _, n in pairs({
			"arrow_1_v",
			"arrow_2_v",
			"arrow_3_v",
			"bolt_sniper"
		}) do
			T(n).bullet.reduce_armor = u.reduce_armor_factor
			T(n).bullet.armor_damage_inc = u.reduce_armor_factor
			T(n).bullet.armor_damage_max = u.max_reduction
		end
	end

	u = self:get_upgrade("archer_far_shots")

	if u then
		for _, n in pairs(archer_towers) do
			T(n).attacks.list[1].cooldown = (math.floor((T(n).attacks.list[1].cooldown / u.speed_factor) * 10))/10
		end
		
		T("tower_deathcoil").attacks.list[1].charge_tick = (math.floor((T("tower_deathcoil").attacks.list[1].charge_tick / u.speed_factor) * 10))/10
	end

	local barrack_soldiers = {
		"soldier_thug",
		"soldier_bandit",
		"soldier_brigand",
		"soldier_redcap"
	}
	local barrack_towers = {
		"tower_barrack_1_v",
		"tower_barrack_2_v",
		"tower_barrack_3_v",
		"tower_redcap"
	}

	u = self:get_upgrade("barrack_survival")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
		end
		for _, n in pairs(barrack_towers) do
			T(n).barrack.rally_range = T(n).barrack.rally_range * u.rally_range_factor
		end
		T("soldier_skeleton_graveyard").health.armor = T("soldier_skeleton_graveyard").health.armor + u.armor_increase
	end

	u = self:get_upgrade("barrack_better_armor")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.hp_max = km.round(T(n).health.hp_max * u.health_factor)
		end
		T("soldier_skeleton_graveyard").health.hp_max = km.round(T("soldier_skeleton_graveyard").health.hp_max * u.health_factor)
	end

	u = self:get_upgrade("barrack_improved_deployment")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).pickpocket.chance = u.pickpocket_chance
			T(n).pickpocket.steal_max = u.pickpocket_amount
			T(n).pickpocket.steal_min = u.pickpocket_amount
		end
	end

	u = self:get_upgrade("barrack_survival_2")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).melee.attacks[1].damage_min = math.floor(T(n).melee.attacks[1].damage_min * u.damage_factor)
			T(n).melee.attacks[1].damage_max = math.floor(T(n).melee.attacks[1].damage_max * u.damage_factor)
			T(n).melee.attacks[1].track_damage = true
		end
		T("soldier_skeleton_graveyard").melee.attacks[1].damage_min = math.floor(T("soldier_skeleton_graveyard").melee.attacks[1].damage_min * u.damage_factor)
		T("soldier_skeleton_graveyard").melee.attacks[1].damage_max = math.floor(T("soldier_skeleton_graveyard").melee.attacks[1].damage_max * u.damage_factor)
		T("soldier_skeleton_graveyard").melee.attacks[1].track_damage = true
	end

	u = self:get_upgrade("barrack_barbed_armor")

	if u then
		for _, n in pairs(barrack_soldiers) do
			T(n).health.true_armor = u.true_armor
		end
		T("soldier_skeleton_graveyard").health.true_armor = u.true_armor
		T("hero_goblin").health.true_armor = u.true_armor
	end

	local mage_towers = {
		"tower_mage_1_v",
		"tower_mage_2_v",
		"tower_mage_3_v",
		"tower_shaman"
	}

	u = self:get_upgrade("mage_spell_reach")

	if u then
		for _, n in pairs({
			"bolt_1_v",
			"bolt_2_v",
			"bolt_3_v",
			"bolt_shaman_totem"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end

	u = self:get_upgrade("mage_hermetic_study")

	if u then
		for _, n in pairs(mage_towers) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	local engineer_towers = {
		"tower_artillery_1",
		"tower_artillery_2",
		"tower_artillery_3"
	}
	local engineer_bombs = {
		"bomb_v",
		"bomb_dynamite_v",
		"bomb_black_v"
	}

	u = self:get_upgrade("engineer_concentrated_fire")

	if u then
		for _, n in pairs(engineer_bombs) do
			T(n).bullet.damage_radius = math.ceil(T(n).bullet.damage_radius * u.area_factor)
		end
		T("decal_rotshroom_mine").damage_radius =  math.ceil(T("decal_rotshroom_mine").damage_radius * u.area_factor)
		T("decal_rotshroom_mine_mini").damage_radius =  math.ceil(T("decal_rotshroom_mine_mini").damage_radius * u.area_factor)
	end

	u = self:get_upgrade("engineer_range_finder")

	if u then
		for _, n in pairs(engineer_bombs) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
		T("decal_rotshroom_mine").damage_min =  math.ceil(T("decal_rotshroom_mine").damage_min * u.damage_factor)
		T("decal_rotshroom_mine").damage_max =  math.ceil(T("decal_rotshroom_mine").damage_max * u.damage_factor)
	end

	u = self:get_upgrade("engineer_industrialization")

	if u then
		for _, n in pairs({
			"tower_rotshroom",
			"tower_tesla"
		}) do
			for pk, pv in pairs(T(n).powers) do
				pv.price_base = math.floor(pv.price_base * u.cost_factor)
				pv.price_inc = math.floor(pv.price_inc * u.cost_factor)
			end
		end
	end

	T("power_fireball_control").user_power.level = self.levels.rain
	u = self:get_upgrade("rain_blazing_skies")

	if u then
		T("power_nova_control").fireball_count = T("power_nova_control").fireball_count + u.strike_count_increase
		T("power_nova").bullet.damage_min = T("power_nova").bullet.damage_min + u.damage_increase
		T("power_nova").bullet.damage_max = T("power_nova").bullet.damage_max + u.damage_increase
	end

	u = self:get_upgrade("rain_scorched_earth")

	if u then
		T("power_nova").bullet.mod = "mod_veznan_arcanenova"
		T("power_nova_control").cooldown = T("power_nova_control").cooldown - u.cooldown_reduction
	end

	u = self:get_upgrade("rain_bigger_and_meaner")

	if u then
		T("power_nova_control").fireball_count = T("power_nova_control").fireball_count + u.strike_count_increase
		T("power_nova_control").burst_interval = T("power_nova_control").burst_interval - u.interval_reduction
		T("power_nova").bullet.wait_time = T("power_nova").bullet.wait_time - u.wait_reduction
		T("power_nova_control").cooldown = T("power_nova_control").cooldown - u.cooldown_reduction
	end

	u = self:get_upgrade("rain_blazing_earth")

	if u then
		T("mod_veznan_arcanenova").slow.factor = T("mod_veznan_arcanenova").slow.factor - u.slow_factor
		T("power_nova").bullet.damage_min = T("power_nova").bullet.damage_min + u.damage_increase
		T("power_nova").bullet.damage_max = T("power_nova").bullet.damage_max + u.damage_increase
	end

	u = self:get_upgrade("rain_cataclysm")

	if u then
		T("power_nova_control").cataclysm_count = u.cataclysm_count
		T("power_nova").bullet.damage_min = T("power_nova").bullet.damage_min + u.damage_increase
		T("power_nova").bullet.damage_max = T("power_nova").bullet.damage_max + u.damage_increase
	end

	if self.levels.reinforcements > 0 then
		local rl = math.min(self.levels.reinforcements, self.max_level)

		u = self:get_upgrade("reinforcement_level_" .. rl)

		if u then
			for i = 1, 3 do
				E:set_template("re_current_" .. i, T(u.template_name .. "_" .. i))
			end
		end
	end
end

return upgrades
