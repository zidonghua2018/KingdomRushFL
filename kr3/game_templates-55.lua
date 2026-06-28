-- chunkname: @./kr5/game_templates.lua
--和铁皮实时对接同步的文件
local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local E = require("entity_db")
local i18n = require("i18n")
local log = require("klua.log"):new("test_case")

require("constants")

local anchor_y = 0
local image_y = 0
local tt, b
local scripts = require("game_scripts-55")

require("templates")

local H = require("helpers")
local balance = require("balance/balance_spider")
local IS_PHONE = KR_TARGET == "phone"
local IS_PHONE_OR_TABLET = KR_TARGET == "phone" or KR_TARGET == "tablet"
local IS_CONSOLE = KR_TARGET == "console"

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local function vv(v1)
	return {
		x = v1,
		y = v1
	}
end

local function r(x, y, w, h)
	return {
		pos = v(x, y),
		size = v(w, h)
	}
end

local function fts(v)
	return v / FPS
end

local function ady(v)
	return v - anchor_y * image_y
end

local function adx(v)
	return v - anchor_x * image_x
end

local function np(pi, spi, ni)
	return {
		dir = 1,
		pi = pi,
		spi = spi,
		ni = ni
	}
end

local function d2r(d)
	return d * math.pi / 180
end

local function RT(name, ref)
	return E:register_t_10086(name, ref)
end

local function AC(tpl, ...)
	return E:add_comps(tpl, ...)
end

local function CC(comp_name)
	return E:clone_c(comp_name)
end

DO_ENEMY_BIG = 2
DO_SOLDIER_BIG = 3
DO_HEROES = 3
DO_MOD_FX = 4
DO_TOWER_MODS = 10
package.loaded["balance/balance"] = nil

if H.command_line_has_arg("balance_override") then
	local balance_override_path = H.command_line_argv("balance_override")

	package.loaded[balance_override_path] = nil

	require(balance_override_path)
end

if game and game.store and game.store.level and game.store.level.test_case and game.store.level.test_case.patch_balance then
	local new_balance = game.store.level.test_case:patch_balance()

	if new_balance then
		balance = new_balance
	end
end

tt = E:register_t_10086("ps_bullet_enemy_spider_priest")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "cultist_spider_projectile_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.z = Z_BULLET_PARTICLES
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.particle_lifetime = {
	fts(6),
	fts(6)
}
tt = E:register_t_10086("ps_tower_sparking_geode_sparks_1")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "sparking_geode_electric_decal_1_idle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 6
tt.particle_system.emit_direction = 0
tt.particle_system.emit_spread = 0
tt.particle_system.emit_speed = {
	0,
	0
}
tt.particle_system.scale_var = {
	0.5,
	1.1
}
tt.particle_system.emit_rotation_spread = 0
tt.particle_system.particle_lifetime = {
	fts(42),
	fts(42)
}
tt.particle_system.emit_area_spread = v(70, 70)
tt.particle_system.emit_offset = v(0, 20)
tt.particle_system.z = Z_OBJECTS
tt = E:register_t_10086("ps_tower_sparking_geode_sparks_2", "ps_tower_sparking_geode_sparks_1")
tt.particle_system.name = "sparking_geode_electric_decal_2_idle"
tt.particle_system.particle_lifetime = {
	fts(34),
	fts(34)
}
tt = E:register_t_10086("ps_bullet_enemy_brute_welder_death_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "brute_welder_tank_particle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(23),
	fts(23)
}
tt.particle_system.emission_rate = 50
tt.particle_system.emit_area_spread = v(5, 5)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.emit_offset = v(0, 0)
tt.particle_system.scales_y = {
	0.9,
	1.1
}
tt.particle_system.scales_x = {
	0.9,
	1.1
}
tt = E:register_t_10086("ps_enemy_scrap_speedster_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "scrap_speedster_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.emission_rate = 30
tt.particle_system.emit_area_spread = v(10, 10)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.emit_offset = v(0, 100)
tt.particle_system.scales_y = {
	0.6,
	1
}
tt.particle_system.scales_x = {
	0.6,
	1
}
tt.particle_system.z = Z_OBJECTS
tt = E:register_t_10086("ps_bullet_enemy_darksteel_guardian_death_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "darksteel_guardian_dwatf_particle_idle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(8)
}
tt.particle_system.emission_rate = 50
tt.particle_system.emit_area_spread = v(5, 5)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.emit_offset = v(0, 0)
tt.particle_system.scales_y = {
	0.9,
	1.1
}
tt.particle_system.scales_x = {
	0.9,
	1.1
}
tt = E:register_t_10086("ps_enemy_darksteel_hulk_charge_a")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "darksteel_hulk_run_particle_a"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 4
tt.particle_system.track_offset = v(0, 0)
tt.particle_system.z = Z_DECALS
tt = E:register_t_10086("ps_enemy_darksteel_hulk_charge_b")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "darksteel_hulk_run_particle_b"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 3
tt.particle_system.track_offset = v(0, 20)
tt.particle_system.animation_fps = 15
tt.particle_system.z = Z_DECALS
tt = E:register_t_10086("ps_bullet_boss_machinist")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "dlc_dwarf_boss_operator_proytrail"
tt.particle_system.animated = false
tt.particle_system.emission_rate = 15
tt.particle_system.spin = {
	math.pi / 6,
	math.pi / 4
}
tt.particle_system.emit_area_spread = v(10, 10)
tt.particle_system.particle_lifetime = {
	fts(25),
	fts(25)
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_x = {
	0.9,
	1.2
}
tt.particle_system.scales_y = {
	0.9,
	1.2
}
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_bullet_stage_25_torso_missile")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "DLC_stage_03_missile_particle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(15),
	fts(15)
}
tt.particle_system.emission_rate = 50
tt.particle_system.emit_area_spread = v(5, 5)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.emit_offset = v(0, 0)
tt.particle_system.scales_y = {
	0.9,
	1.1
}
tt.particle_system.scales_x = {
	0.9,
	1.1
}
tt = E:register_t_10086("ps_bullet_stage_27_scrap")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "dclenanos_stage05_ScrapProjectileTrail_asst_scrap_projectile_trail"
tt.particle_system.animated = false
tt.particle_system.emission_rate = 15
tt.particle_system.spin = {
	math.pi / 6,
	math.pi / 4
}
tt.particle_system.emit_area_spread = v(10, 10)
tt.particle_system.particle_lifetime = {
	fts(25),
	fts(25)
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_x = {
	0.9,
	1.2
}
tt.particle_system.scales_y = {
	0.9,
	1.2
}
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_bullet_stage_27_tower_stun")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "boss_fx_scrap_particle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 60
tt.particle_system.emit_area_spread = v(10, 10)
tt.particle_system.particle_lifetime = {
	fts(6),
	fts(6)
}
tt.particle_system.scales_x = {
	0.9,
	1.1
}
tt.particle_system.scales_y = {
	0.9,
	1.1
}
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_bullet_boss_grymbeard_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "grymbeardbossLAYERS_missiletrail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(15),
	fts(15)
}
tt.particle_system.emission_rate = 50
tt.particle_system.emit_area_spread = v(5, 5)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.emit_offset = v(0, 0)
tt.particle_system.scales_y = {
	0.9,
	1.1
}
tt.particle_system.scales_x = {
	0.9,
	1.1
}
tt.emit_offset_relative = v(0, 0)
tt = E:register_t_10086("ps_bullet_boss_grymbeard_death_boss_trail", "ps_bullet_boss_grymbeard_trail")
tt.particle_system.name = "grymbeardbossLAYERS_flytrail_run"
tt = E:register_t_10086("ps_spider_sister_bolt_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.anchor = v(0.5, 0.45)
tt.particle_system.name = "spider_sister_fx_attack_1_projectile_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(8)
}
tt.particle_system.emission_rate = 30
tt.particle_system.z = Z_BULLET_PARTICLES
tt.particle_system.scales_y = {
	0.8,
	0.5
}
tt = E:register_t_10086("ps_boss_spider_queen_bolt_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.name = "boss_effects_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(5),
	fts(12)
}
tt.particle_system.emission_rate = 30
tt.particle_system.z = Z_BULLET_PARTICLES
tt.particle_system.scales_y = {
	0.8,
	0.5
}
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t_10086("ps_boss_spider_queen_lifesteal_trail_1")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.name = "spider_queen_boss_effects_trail_0001"
tt.particle_system.animated = false
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.emission_rate = 150
tt.particle_system.z = Z_BULLET_PARTICLES
tt.particle_system.scales_x = {
	1,
	0.1
}
tt.particle_system.scales_y = {
	1,
	0.1
}
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t_10086("ps_boss_spider_queen_lifesteal_trail_2")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.name = "spider_queen_boss_effects_trail2_0001"
tt.particle_system.animated = false
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(2),
	fts(5)
}
tt.particle_system.emission_rate = 150
tt.particle_system.z = Z_BULLET_PARTICLES + 1
tt.particle_system.scales_x = {
	1,
	0.8,
	0.1
}
tt.particle_system.scales_y = {
	1,
	0.8,
	0.1
}
tt.particle_system.alphas = {
	255,
	170,
	0
}
tt = E:register_t_10086("ps_boss_spider_queen_bullet_tower_stun_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.name = "boss_effects_bolt_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(4),
	fts(4)
}
tt.particle_system.emission_rate = 30
tt.particle_system.z = Z_BULLET_PARTICLES
tt.particle_system.scales_x = {
	0.7,
	0.1
}
tt.particle_system.scales_y = {
	0.7,
	0.1
}
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t_10086("ps_boss_spider_queen_bullet_tower_stun_trail_2")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.name = "boss_effects_bolt_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.emission_rate = 15
tt.particle_system.z = Z_BULLET_PARTICLES + 1
tt.particle_system.scales_x = {
	0.7,
	0.1
}
tt.particle_system.scales_y = {
	0.7,
	0.1
}
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t_10086("ps_bullet_soldier_priests_barrack_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "priest_particle_idle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.particle_lifetime = {
	fts(7),
	fts(7)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("fx_bullet_enemy_brute_welder_death_hit", "fx")
tt.render.sprites[1].prefix = "brute_welder_tower_hit_fx"
tt.render.sprites[1].name = "idle"
tt = E:register_t_10086("fx_bullet_boss_machinist", "fx")
tt.render.sprites[1].prefix = "dlcdwarfbossstage02_particleDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("fx_bullet_stage_25_torso_missile_hit", "fx")
tt.render.sprites[1].prefix = "DLC_stage_03_missile_hit"
tt.render.sprites[1].name = "run"
tt = E:register_t_10086("fx_stage_27_cannon_shot", "fx")
tt.render.sprites[1].prefix = "dlcenanos_stage05_cannon_explosionDef"
tt.render.sprites[1].name = "shoot"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("fx_stage_27_scrap", "fx")
tt.render.sprites[1].prefix = "dclenanos_stage05_ScrapProjectileFXDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("fx_bullet_stage_27_scrap", "fx")
tt.render.sprites[1].prefix = "dclenanos_stage05_ScrapProjectileHitFXDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("fx_bullet_stage_27_tower_stun", "fx")
tt.render.sprites[1].name = "boss_fx_scrap_hit"
tt = E:register_t_10086("fx_bullet_boss_grymbeard_hit", "fx")
tt.render.sprites[1].prefix = "dclenanos_stage05_grymmissileDef"
tt.render.sprites[1].name = "explosion"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("fx_soldier_priests_barrack_melee_hit", "fx")
tt.render.sprites[1].name = "priest_melee_hit"
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t_10086("fx_soldier_priests_barrack_abomination_melee_hit", "fx")
tt.render.sprites[1].name = "redemeed_cultist_barraca_unblinded_abomination_hit_fx_idle"
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t_10086("fx_soldier_priests_barrack_abomination_eat", "fx")
tt.render.sprites[1].name = "redemeed_cultist_barraca_unblinded_abomination_eat_fx"
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t_10086("fx_soldier_priests_barrack_bolt_hit", "fx")
tt.render.sprites[1].name = "priest_ranged_hit_idle"
tt = E:register_t_10086("fx_tower_sparking_geode_evolve", "fx")
tt.render.sprites[1].name = "sparking_geode_evolve_run"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = vv(1)
tt = E:register_t_10086("fx_mod_tower_sparking_geode_stun_death", "fx")
tt.render.sprites[1].prefix = "sparking_geode_cystal_fx"
tt.render.sprites[1].name = "death"
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("fx_tower_sparking_geode_up_ray", "fx")
tt.render.sprites[1].prefix = "sparking_geode_longray_ray"
tt.render.sprites[1].name = "up"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].sort_y_offset = -80
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "sparking_geode_longray_decal_up"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = -80
tt = E:register_t_10086("fx_tower_sparking_geode_hit", "fx")
tt.render.sprites[1].prefix = "sparking_geode_ray_rebote"
tt.render.sprites[1].name = "hit"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].scale = v(0.72, 1.08)
tt = E:register_t_10086("fx_bullet_enemy_spider_priest_hit", "fx")
tt.render.sprites[1].name = "cultist_spider_spell_hit"
tt = E:register_t_10086("spider_sister_bolt_hit_fx", "fx")
tt.render.sprites[1].name = "spider_sister_fx_attack_1_hit"
tt = E:register_t_10086("fx_boss_spider_queen_bolt_hit", "fx")
tt.render.sprites[1].prefix = "boss_effects_hit"
tt.render.sprites[1].name = "run"
tt = E:register_t_10086("fx_boss_spider_queen_lifesteal_healing", "fx")
tt.render.sprites[1].name = "boss_effects_healing"
tt = E:register_t_10086("fx_boss_spider_queen_lifesteal_bleeding", "fx")
tt.render.sprites[1].prefix = "boss_effects_hit_drain"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].scale = vv(2)
tt = E:register_t_10086("fx_boss_spider_queen_melee_hit", "fx")
tt.render.sprites[1].prefix = "boss_effects_hit"
tt.render.sprites[1].name = "run"
tt = E:register_t_10086("fx_boss_spider_queen_melee_hit_decal", "fx")
tt.render.sprites[1].name = "boss_effects_decal_back"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 30
tt.render.sprites[1].offset = v(0, 20)
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "boss_effects_decal_front_run"
tt.render.sprites[2].sort_y_offset = 0
tt = E:register_t_10086("fx_glarenwarden_healing", "fx")
tt.render.sprites[1].name = "glarenwarden_healing_run"
tt = E:register_t_10086("fx_enemy_mad_tinkerer_hit", "fx")
tt.render.sprites[1].name = "mad_tinkerer_hit"
tt = E:register_t_10086("fx_enemy_common_clone_hit", "fx")
tt.render.sprites[1].name = "common_clone_hit_fx_idle"
tt = E:register_t_10086("fx_enemy_darksteel_fist_hit", "fx")
tt.render.sprites[1].name = "darksteel_fist_hit_fx_idle"
tt = E:register_t_10086("fx_enemy_darksteel_fist_area", "fx")

E:add_comps(tt, "main_script")

tt.render.sprites[1].name = "darksteel_fist_stun_explosion"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "darksteel_fist_stun_stones"
tt.render.sprites[2].z = Z_EFFECTS - 1
tt.main_script.insert = scripts.fx_enemy_darksteel_fist_area.insert
tt = E:register_t_10086("fx_enemy_darksteel_guardian_hit_1", "fx")
tt.render.sprites[1].name = "darksteel_guardian_attack_1_hit_idle"
tt = E:register_t_10086("fx_enemy_darksteel_guardian_hit_2", "fx")
tt.render.sprites[1].name = "darksteel_guardian_attack_2_hit_idle"
tt = E:register_t_10086("fx_enemy_darksteel_anvil_hit", "fx")
tt.render.sprites[1].name = "darksteel_anvil_attack_hit_idle"
tt = E:register_t_10086("fx_enemy_deformed_grymbeard_clone_shield", "fx")
tt.render.sprites[1].prefix = "clone_boss_shield"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].draw_order = 100
tt.render.sprites[1].scale = vv(0.9, 0.9)
tt.timed.runs = 1e+99
tt = E:register_t_10086("fx_bullet_enemy_rolling_sentry", "fx")
tt.render.sprites[1].name = "rolling_sentry_hit_fx_idle"
tt = E:register_t_10086("fx_boss_machinist_death_smoke", "fx")
tt.render.sprites[1].prefix = "dlcdwarfbossstage02_smokeDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("fx_boss_machinist_death_particle", "fx")
tt.render.sprites[1].prefix = "dlcdwarfbossstage02_particleDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("decal_enemy_darksteel_guardian_legs", "decal_tween")
tt.render.sprites[1].name = "darksteel_guardian_creep_grave_loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		2,
		255
	},
	{
		3,
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_bullet_enemy_darksteel_guardian_death_clone", "decal_tween")
tt.render.sprites[1].name = "common_clone_creep_boss_fall"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		2,
		255
	},
	{
		3,
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_tower_sparking_geode_burst_crystal", "decal_scripted")
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "sparking_geode_crystal_small"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts.decal_tower_sparking_geode_burst_crystal.update
tt = E:register_t_10086("decal_scrap", "decal_scripted")

E:add_comps(tt, "tween")

b = balance.enemies.hammer_and_anvil.scrap
tt.render.sprites[1].prefix = "scrap_pile"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECT
tt.main_script.update = scripts.decal_scrap.update
tt.duration = b.duration
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1,
		0
	}
}
tt = E:register_t_10086("decal_ray_mad_tinkerer", "decal")

E:add_comps(tt)

b = balance.enemies.hammer_and_anvil.scrap
tt.render.sprites[1].prefix = "mad_tinkerer_skill_ray"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt.duration = b.duration
tt = E:register_t_10086("decal_scrap_bullet_mad_tinkerer", "decal")

E:add_comps(tt)

b = balance.enemies.hammer_and_anvil.scrap
tt.render.sprites[1].name = "mad_tinkerer_skill_projectile"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.duration = b.duration
tt = E:register_t_10086("decal_enemy_darksteel_fist_stun", "decal_tween")
tt.render.sprites[1].name = "darksteel_fist_stun_floor_decal"
tt.render.sprites[1].animated = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1,
		0
	}
}
tt.tween.disabled = false
tt.tween.remove = true
tt = E:register_t_10086("decal_boss_spider_queen_spiderweb", "decal_tween")
b = balance.enemies.arachnids.boss_spider_queen.spiderweb

E:add_comps(tt, "auras", "main_script")

tt.main_script.insert = scripts.decal_boss_spider_queen_spiderweb.insert
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_spider_webs_slowness"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E:clone_c("aura_attack")
tt.auras.list[2].name = "aura_spider_webs_sprint"
tt.auras.list[2].cooldown = 0
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].name = "spider_queen_boss_effects_web_decal"
tt.render.sprites[1].animated = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.3,
		255
	},
	{
		b.duration - 0.8,
		255
	},
	{
		b.duration,
		0
	}
}
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		vv(0.8)
	},
	{
		0.3,
		vv(1.1)
	},
	{
		0.4,
		vv(1)
	}
}
tt.tween.disabled = false
tt.tween.remove = true
tt = E:register_t_10086("decal_boss_spider_queen_webspit_screen", "decal_tween")
b = balance.enemies.arachnids.boss_spider_queen.webspit
tt.render.sprites[1].z = Z_SCREEN_FIXED
tt.render.sprites[1].name = "spider_queen_web_screen"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = vv(0.5)
tt.duration = b.duration
tt.opacity = 255
tt.tween.props[1].keys = nil
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].name = "scale"
tt.tween.disabled = false
tt.tween.remove = true
tt = E:register_t_10086("decal_boss_spider_queen_spawns", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.decal_boss_spider_queen_spawns.update
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].prefix = "boss_effects_egg"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "effect_run"
tt.render.sprites[2].loop = true
tt.object = "enemy_drainbrood"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(8),
		0
	}
}
tt.tween.props[1].sprite_id = 2
tt.tween.disabled = true
tt = E:register_t_10086("decal_defense_flag5", "decal_defense_flag")

E:add_comps(tt, "main_script", "editor", "editor_script")

tt.main_script.insert = scripts.decal_defense_flag5.insert
tt.render.sprites[1].name = "defense_flag"
tt.editor.flip = 0
tt.editor_script.update = scripts.decal_defense_flag5.update_editor
tt.editor.props = {
	{
		"editor.flip",
		PT_NUMBER
	}
}
tt = E:register_t_10086("decal_wisp_1", "decal_delayed_play")
tt.render.sprites[1].name = "props_wisp"
tt.delayed_play.min_delay = 2
tt.delayed_play.max_delay = 30
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "props_wisp"
tt.editor.props = {
	{
		"render.sprites[1].r",
		PT_NUMBER,
		math.pi / 180
	},
	{
		"render.sprites[1].scale",
		PT_COORDS
	}
}
tt = E:register_t_10086("taunts_s15_controller")

E:add_comps(tt, "main_script", "taunts", "editor")

tt.load_file = "level15_taunts"
tt.main_script.insert = scripts.taunts_controller.insert
tt.taunts.delay_min = 10
tt.taunts.delay_max = 20
tt.taunts.sets = {}
tt.taunts.sets.stage_15_cult_leader_greetings = CC("taunt_set")
tt.taunts.sets.stage_15_cult_leader_greetings.format = "TAUNT_STAGE15_CULTIST_%04i"
tt.taunts.sets.stage_15_cult_leader_greetings.decal_name = "decal_stage15_cultist_shoutbox"
tt.taunts.sets.in_bossfight = CC("taunt_set")
tt.taunts.sets.in_bossfight.format = "LV15_CULTIST01_BOSSFIGHT_%02i"
tt.taunts.sets.in_bossfight.decal_name = "decal_stage11_cultist_shoutbox"
tt.taunts.sets.in_bossfight.start_idx = 1
tt.taunts.sets.in_bossfight.end_idx = 6
tt = E:register_t_10086("decal_terrain_6_exodia_arm", "decal_scripted")

E:add_comps(tt, "ui")

tt.render.sprites[1].prefix = "DLC_enanos_easter_egg_exodia_arm"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.main_script.update = scripts.decal_terrain_6_exodia_part.update
tt.ui.can_click = true
tt.ui.click_rect = r(-15, -5, 30, 20)
tt.sound_click = "Terrain6ExodiaPart"
tt = E:register_t_10086("decal_terrain_6_exodia_arm_2", "decal_terrain_6_exodia_arm")
tt.render.sprites[1].flip_x = true
tt = E:register_t_10086("decal_terrain_6_exodia_head", "decal_terrain_6_exodia_arm")
tt.render.sprites[1].prefix = "DLC_enanos_easter_egg_exodia_head"
tt = E:register_t_10086("decal_terrain_6_exodia_leg", "decal_terrain_6_exodia_arm")
tt.render.sprites[1].prefix = "DLC_enanos_easter_egg_exodia_leg"
tt.ui.click_rect = r(-15, -5, 30, 30)
tt = E:register_t_10086("decal_terrain_6_exodia_leg_2", "decal_terrain_6_exodia_arm")
tt.render.sprites[1].prefix = "DLC_enanos_easter_egg_exodia_leg"
tt.render.sprites[1].flip_x = true
tt.ui.click_rect = r(-15, -5, 30, 30)
tt = E:register_t_10086("decal_stage_23_mask_1", "decal")
tt.render.sprites[1].name = "stage23_mask1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 170
tt = E:register_t_10086("decal_stage_23_mask_2", "decal")
tt.render.sprites[1].name = "stage23_mask2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 51
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_23_mask_4", "decal")
tt.render.sprites[1].name = "stage23_mask4"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -8
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_23_mask_5", "decal")
tt.render.sprites[1].name = "stage23_mask5"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 50
tt.render.sprites[1].hidden = false
tt = E:register_t_10086("decal_stage_23_mask_6", "decal")
tt.render.sprites[1].name = "stage23_mask6"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 123
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("decal_stage_23_snow", "decal")
tt.render.sprites[1].prefix = "dclenanos_stage01_snowfallDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_stage_23_torches", "decal")
tt.render.sprites[1].prefix = "dclenanos_stage01_torchesDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_stage_23_crane", "decal_scripted")

E:add_comps(tt, "ui")

tt.render.sprites[1].prefix = "DLCenanos_stage1_deco_gruaDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.main_script.update = scripts.decal_stage_23_crane.update
tt.ui.can_click = true
tt.ui.click_rect = r(400, -220, 110, 100)
tt.sound_tap_1_2 = "Stage23TruckOneShot"
tt.sound_tap_3 = "Stage23TruckTap3"
tt = E:register_t_10086("decal_stage_23_rock", "decal")
tt.render.sprites[1].prefix = "darksteel_guardian_stage_rock"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_24_factory", "decal_scripted")

E:add_comps(tt, "spawner", "editor")

tt.render.sprites[1].prefix = "factoryDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS - 2
tt.main_script.update = scripts.decal_stage_24_factory.update
tt.spawner.eternal = true
tt.sound_factory_turn_on_end = "Stage24FactoryTurnOnEnd"
tt.sound_factory_turn_off = "Stage24FactoryTurnOff"
tt = E:register_t_10086("decal_stage_24_gear_factory", "decal")
tt.render.sprites[1].prefix = "factory2Def"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_stage_24_factory_conveyor_belt", "decal")
tt.render.sprites[1].prefix = "dlc_enanos_stage_02_LAYERS_factorygate"
tt.render.sprites[1].name = "activeloop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].draw_order = 1
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("decal_stage_24_factory_sparks", "decal_scripted")
tt.render.sprites[1].prefix = "dlc_dwarf_boss_operator_sparks"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS + 1
tt.render.sprites[1].hidden = true
tt.main_script.update = scripts.decal_stage_24_factory_sparks.update
tt = E:register_t_10086("decal_stage_24_elevator", "decal_scripted")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "ascensorDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS - 1
tt.main_script.update = scripts.decal_stage_24_elevator.update
tt.sound_machinist_in = "Stage24MachinistEnter"
tt.sound_machinist_out = "Stage24MachinistExit"
tt = E:register_t_10086("decal_stage_24_mask_1", "decal")
tt.render.sprites[1].name = "stage24_mask1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].draw_order = 1
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("decal_stage_24_mask_2", "decal")
tt.render.sprites[1].name = "stage24_mask2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_24_mask_3", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].name = "stage24_mask3"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_24_mask_4", "decal")
tt.render.sprites[1].name = "stage24_mask4"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].hidden = true
tt.render.sprites[1].sort_y_offset = 44
tt = E:register_t_10086("decal_stage_24_mask_5", "decal")
tt.render.sprites[1].name = "stage24_mask5"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_stage_24_mask_6", "decal")
tt.render.sprites[1].name = "stage24_mask6"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].hidden = true
tt.render.sprites[1].sort_y_offset = 95
tt = E:register_t_10086("decal_stage_24_fans", "decal")
tt.render.sprites[1].prefix = "stage2dlcanimsfansDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_24_gears", "decal")
tt.render.sprites[1].prefix = "stage2dlcanimstuercasDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_24_gear_floor", "decal_scripted")

E:add_comps(tt, "ui")

tt.render.sprites[1].prefix = "dlc_enanos_stage_02_LAYERS_gear"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts.decal_stage_24_gears.update
tt.ui.click_rect = r(-25, -5, 50, 35)
tt = E:register_t_10086("decal_stage_24_gear_tower", "decal_scripted")

E:add_comps(tt, "ui")

tt.render.sprites[1].prefix = "towerDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts.decal_stage_24_gears.update
tt.ui.click_rect = r(15, -35, 40, 65)
tt = E:register_t_10086("decal_stage_24_bubble", "decal_scripted")
tt.render.sprites[1].prefix = "lavabubbleDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt.render.sprites[1].hidden = true
tt.main_script.update = scripts.decal_stage_24_bubble.update
tt = E:register_t_10086("decal_stage_24_dust", "decal")
tt.render.sprites[1].prefix = "t5_dustDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS + 1
tt = E:register_t_10086("decal_stage_24_smoke", "decal")
tt.render.sprites[1].prefix = "t5_smokeDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS + 1
tt = E:register_t_10086("decal_stage_24_upgrade_station", "decal_scripted")

local b = balance.specials.stage24_upgrade_station

tt.render.sprites[1].prefix = "converterDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts.decal_stage_24_upgrade_station.update
tt.hammerer_t = "enemy_darksteel_hammerer"
tt.fist_t = "enemy_darksteel_fist"
tt.wave_config = b.wave_config
tt.path_in = 8
tt.path_out = 9
tt.sound_open = "Stage24UpgradeStationIn"
tt.sound_close = "Stage24UpgradeStationOut"
tt.sound_transform = "Stage24UpgradeStationTransform"
tt = E:register_t_10086("decal_stage_24_modes_decos", "decal_scripted")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "stage2DLC_ascensor_modosDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.main_script.update = scripts.decal_stage_24_modes_decos.update
tt = E:register_t_10086("decal_stage_25_mask_1", "decal")
tt.render.sprites[1].name = "stage25_mask1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 32
tt = E:register_t_10086("decal_stage_25_mask_2", "decal")
tt.render.sprites[1].name = "stage25_mask2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 18
tt = E:register_t_10086("decal_stage_25_mask_2_glow", "decal_tween")
tt.render.sprites[1].name = "stage25_mask2_glow"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 19
tt.render.sprites[1].alpha = 0
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(30),
		255
	}
}
tt = E:register_t_10086("decal_stage_25_mask_3", "decal")
tt.render.sprites[1].name = "stage25_mask3"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 4
tt = E:register_t_10086("decal_stage_25_mask_4", "decal")
tt.render.sprites[1].name = "stage25_mask4"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_25_torso", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "DLC_stage3_dwarf_machinistDef"
tt.render.sprites[1].name = "idle_doors"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_25_torso_modes", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "DLC_stage3_dwarf_machinist_modesDef"
tt.render.sprites[1].name = "idle_doors"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_25_fist", "decal")
tt.render.sprites[1].prefix = "DLC_stage3_robot_armDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -20
tt = E:register_t_10086("decal_stage_25_fist_shadow", "decal")
tt.render.sprites[1].prefix = "DLC_stage3_robot_arm_decalsDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_stage_25_dwarf_intro", "decal_timed")
tt.render.sprites[1].prefix = "DLC_stage3_dwarf_inDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E:register_t_10086("decal_mod_stage_25_torso_missile_stun_water", "decal_timed")
tt.render.sprites[1].name = "DLC_stage_03_missile_water_splash"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -9
tt.render.sprites[1].offset = v(0, 5)
tt = E:register_t_10086("decal_mod_stage_25_torso_missile_stun_hand", "decal_tween")
tt.render.sprites[1].prefix = "DLC_stage_03_missile_tower_block_tap"
tt.render.sprites[1].name = "tap"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt.render.sprites[1].offset = v(23, 10)
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(15),
		255
	},
	{
		fts(45),
		255
	},
	{
		fts(60),
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_mod_stage_29_holder_block_hand", "decal_tween")
tt.render.sprites[1].prefix = "spiderholder_block_tap"
tt.render.sprites[1].name = "tap"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[1].offset = v(23, 50)
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(15),
		255
	},
	{
		fts(45),
		255
	},
	{
		fts(60),
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_stage_25_solid_snake", "decal_scripted")

E:add_comps(tt, "ui")

tt.render.sprites[1].prefix = "DLC_Enanos_S3_EasterEgg_SolidSnakeDef"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.main_script.update = scripts.decal_stage_25_solid_snake.update
tt.ui.can_click = true
tt.ui.click_rect = r(-325, 290, 50, 45)
tt.click_rect_1 = r(-325, 290, 50, 45)
tt.click_rect_2 = r(-335, 283, 50, 45)
tt.sound_1_2 = "Stage25SolidSnakeTap12"
tt.sound_3 = "Stage25SolidSnakeTap3"
tt = E:register_t_10086("decal_stage_26_mask_1", "decal")
tt.render.sprites[1].name = "DLC_enanos_stage_04_mask_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = E:register_t_10086("decal_stage_26_mask_2", "decal")
tt.render.sprites[1].name = "DLC_enanos_stage_04_mask_2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = E:register_t_10086("decal_stage_26_mask_3", "decal")
tt.render.sprites[1].name = "DLC_enanos_stage_04_mask_3"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = E:register_t_10086("decal_stage_26_mask_4", "decal")
tt.render.sprites[1].name = "DLC_enanos_stage_04_mask_4"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 200
tt = E:register_t_10086("decal_stage_26_mask_5", "decal")
tt.render.sprites[1].name = "DLC_enanos_stage_04_mask_5"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_26_foreground_1", "decal")
tt.render.sprites[1].name = "DLC_enanos_stage_04_foreground_a"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E:register_t_10086("decal_stage_26_foreground_2", "decal")
tt.render.sprites[1].name = "DLC_enanos_stage_04_foreground_b"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E:register_t_10086("decal_stage_26_mewtwo_capsules", "decal_scripted")

E:add_comps(tt, "ui")

tt.render.sprites[1].prefix = "DLC_Enanos_S4_EasterEgg_Mewtwo_CanistersDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.main_script.update = scripts.decal_stage_26_mewtwo.update
tt.ui.can_click = true
tt.ui.click_rect = r(100, 270, 50, 80)
tt.mewtwo_t = "decal_stage_26_mewtwo"
tt.sound_1_2 = "Stage26MewtwoTap12"
tt.sound_3 = "Stage26MewtwoTap3"
tt.sound_end = "Stage26MewtwoFlightFullSequence"
tt = E:register_t_10086("decal_stage_26_mewtwo", "decal_timed")

E:add_comps(tt, "ui")

tt.render.sprites[1].prefix = "DLC_Enanos_S4_EasterEgg_MewtwoDef"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECT
tt = E:register_t_10086("decal_stage_26_boss", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "DLC_Enanos_S4_Boss01Def"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 104
tt = E:register_t_10086("decal_stage_26_clone_spawner", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_ElevatorDef"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_26_tube_left", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_ElevatorTubeADef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BACKGROUND
tt = E:register_t_10086("decal_stage_26_tube_right", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_ElevatorTubeBDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BACKGROUND
tt = E:register_t_10086("decal_stage_26_fist_spawner", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_CloneActivatorDef"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_stage_26_fist_spawner_light", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_ActivatorLightDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_26_hulk_spawner", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_HulkSpawnerDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "DLC_Enanos_S4_HulkSpawnerSyringeDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_26_gears_front", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_GearsDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_26_gears_back", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_GearsBackDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BACKGROUND
tt = E:register_t_10086("decal_stage_26_bubbles", "decal")
tt.render.sprites[1].prefix = "DLC_Enanos_S4_BubblesDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_26_modes_decos", "decal_scripted")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "DLCstage4_deco_modosDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.main_script.update = scripts.decal_stage_26_modes_decos.update
tt = E:register_t_10086("decal_stage_27_mask_1", "decal")
tt.render.sprites[1].name = "stage27_mask1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].draw_order = 3
tt = E:register_t_10086("decal_stage_27_mask_2", "decal")
tt.render.sprites[1].name = "stage27_mask2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_27_mask_3", "decal")
tt.render.sprites[1].name = "stage27_mask3"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("decal_stage_27_mask_4", "decal")
tt.render.sprites[1].name = "stage27_mask4"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].draw_order = 2
tt = E:register_t_10086("decal_stage_27_mask_5", "decal")
tt.render.sprites[1].name = "stage27_mask5"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].draw_order = 2
tt = E:register_t_10086("decal_stage_27_snow", "decal")
tt.render.sprites[1].prefix = "dclenanos_stage05_snowfallDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_EFFECTS
tt = E:register_t_10086("decal_stage_27_platform", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "dclenanos_stage05_platformDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = E:register_t_10086("decal_stage_27_platform_bars", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "dclenanos_stage05_platform_barsDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt = E:register_t_10086("decal_stage_27_cannon_right", "decal")
tt.render.sprites[1].prefix = "dlcenanos_stage05_cannonDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.shot_pos = v(924, 509)
tt.shot_target_pos = v(815, 364)
tt = E:register_t_10086("decal_stage_27_cannon_left", "decal")
tt.render.sprites[1].prefix = "dlcenanos_stage05_cannonDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.shot_pos = v(238, 532)
tt.shot_target_pos = v(361, 345)
tt = E:register_t_10086("decal_stage_27_clone_dead", "decal_tween")
tt.render.sprites[1].prefix = "cannonLAYERS_clonedecorative"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(30),
		255
	},
	{
		fts(55),
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_stage_27_clone_alive", "decal_timed")
tt.render.sprites[1].prefix = "cannonLAYERS_cloneland"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.timed.runs = 1
tt = E:register_t_10086("decal_stage_27_head", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "dclenanos_stage05_headDef"
tt.render.sprites[1].name = "headdeathsmokeidle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].draw_order = 1
tt = E:register_t_10086("decal_stage_27_ray", "decal")
tt.render.sprites[1].prefix = "dclenanos_stage05_headrayDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt.render.sprites[1].scale = vv(2)
tt = E:register_t_10086("decal_stage_27_goblins", "decal")
tt.render.sprites[1].prefix = "dclenanos_head_goblinsDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -350
tt = E:register_t_10086("decal_stage_27_smoke_back", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "dclenanos_stage05_HeadSmokeBackDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt = E:register_t_10086("decal_stage_27_smoke_front", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "dclenanos_stage05_HeadSmokeFrontDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 1
tt = E:register_t_10086("decal_stage_27_sparks", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].prefix = "dclenanos_stage05_HeadSparksDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 1
tt = E:register_t_10086("decal_stage_27_modes_decos", "decal_scripted")

E:add_comps(tt, "editor", "ui")

tt.render.sprites[1].prefix = "DLCstage5_deco_modosDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.main_script.update = scripts.decal_stage_27_modes_decos.update
tt.ui.can_click = true
tt.ui.click_rect = r(-33, 60, 20, 20)
tt = E:register_t_10086("decal_stage_27_beam", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.render.sprites[1].prefix = "DLCstage5_enanos_vigaDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.main_script.update = scripts.decal_stage_27_beam.update
tt.ui.can_click = true
tt.ui.click_rect = r(-470, 200, 150, 60)
tt.sound_prefix = "Stage27BeamWorkersTap"
tt = E:register_t_10086("decal_boss_grymbeard_area_attack", "decal_tween")
tt.render.sprites[1].prefix = "dclenanos_stage05_grymbossdecalDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(30),
		255
	},
	{
		fts(60),
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_bullet_boss_grymbeard", "decal_tween")
tt.render.sprites[1].prefix = "dclenanos_stage05_grymmissiledecalDef"
tt.render.sprites[1].name = "decal"
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(30),
		255
	},
	{
		fts(60),
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_bullet_boss_grymbeard_death_clone", "decal_stage_27_clone_dead")
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1e+99,
		255
	}
}
tt = E:register_t_10086("decal_bullet_boss_grymbeard_death_boss", "decal")
tt.render.sprites[1].prefix = "dclenanos_stage05_grymbossflyDef"
tt.render.sprites[1].name = "land"
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_bullet_boss_grymbeard_death_scrap_1", "decal")
tt.render.sprites[1].prefix = "dclenanos_stage05_grymdebree1Def"
tt.render.sprites[1].name = "land"
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_bullet_boss_grymbeard_death_scrap_2", "decal_bullet_boss_grymbeard_death_scrap_1")
tt.render.sprites[1].prefix = "dclenanos_stage05_grymdebree2Def"
tt = E:register_t_10086("decal_stage_28_mask_1", "decal")
tt.render.sprites[1].name = "stage_28_mask_01"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 106
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_28_mask_2", "decal")
tt.render.sprites[1].name = "stage_28_mask_02"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_28_mask_3", "decal")
tt.render.sprites[1].name = "stage_28_mask_03"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_TOWER_BASES
tt = E:register_t_10086("decal_stage_28_torches", "decal")
tt.render.sprites[1].prefix = "stage_28_antorchasDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = 200
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_achievement_into_the_ogreverse", "decal_scripted")

E:add_comps(tt, "ui")

tt.ui.can_click = true
tt.ui.click_rect = r(-20, -40, 40, 50)
tt.main_script.update = scripts.decal_achievement_into_the_ogreverse.update
tt.render.sprites[1].name = "ogreverse_web"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor = v(0.5, 0)
tt.render.sprites[1].sort_y_offset = -30
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "ogreverse_character"
tt.render.sprites[2].name = "cultist_idle"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].offset = v(0, 20)
tt.render.sprites[2].anchor = vv(0.5)
tt.render.sprites[2].sort_y_offset = -30
tt = E:register_t_10086("decal_achievement_a_coon_of_surprises_fredo", "decal_scripted")

E:add_comps(tt, "ui")

tt.ui.can_click = true
tt.ui.click_rect = r(-20, -50, 40, 40)
tt.main_script.update = scripts.decal_achievement_a_coon_of_surprises.update
tt.give_achievement = true
tt.required_touches = 3
tt.change_z_time = fts(8)
tt.change_y_sort_offset = -160
tt.render.sid_animated = 2
tt.render.sprites[1].name = "coonsuprices_cuerdafredo"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[1].anchor = v(0.5, 0.11538461538461539)
tt.render.sprites[tt.render.sid_animated] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_animated].prefix = "coonsuprices_fredo"
tt.render.sprites[tt.render.sid_animated].name = "idle"
tt.render.sprites[tt.render.sid_animated].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_animated].offset = v(5, 4)
tt.render.sprites[tt.render.sid_animated].anchor = v(0.5, 0.973404255319149)
tt = E:register_t_10086("decal_achievement_a_coon_of_surprises_silksong", "decal_achievement_a_coon_of_surprises_fredo")

E:add_comps(tt, "ui")

tt.give_achievement = false
tt.change_z_time = fts(36)
tt.change_y_sort_offset = -400
tt.ui.click_rect = r(-18, -70, 40, 60)
tt.render.sprites[1].name = "coonsuprices_cuerdasilksong"
tt.render.sprites[1].anchor = v(0.5, 0.23958333333333334)
tt.render.sprites[tt.render.sid_animated].prefix = "coonsuprices_silksong"
tt.render.sprites[tt.render.sid_animated].name = "idle"
tt.render.sprites[tt.render.sid_animated].offset = v(2, -30)
tt.render.sprites[tt.render.sid_animated].anchor = vv(0.5)
tt = E:register_t_10086("decal_achievement_a_coon_of_surprises_jarra", "decal_achievement_a_coon_of_surprises_fredo")

E:add_comps(tt, "ui")

tt.give_achievement = false
tt.change_z_time = fts(32)
tt.change_y_sort_offset = -210
tt.ui.click_rect = r(-20, -60, 47, 55)
tt.render.sprites[1].name = "coonsuprices_cuerdajarra"
tt.render.sprites[1].anchor = v(0.5, 0.23958333333333334)
tt.render.sprites[tt.render.sid_animated].prefix = "coonsuprices_jarra"
tt.render.sprites[tt.render.sid_animated].name = "idle"
tt.render.sprites[tt.render.sid_animated].offset = v(-2, -22)
tt.render.sprites[tt.render.sid_animated].anchor = vv(0.5)
tt = E:register_t_10086("decal_achievement_a_coon_of_surprises_darkcrystal", "decal_achievement_a_coon_of_surprises_fredo")

E:add_comps(tt, "ui")

tt.give_achievement = false
tt.change_z_time = fts(37)
tt.change_y_sort_offset = -260
tt.ui.click_rect = r(-20, -80, 40, 80)
tt.render.sprites[1].name = "coonsuprices_cuerdadarkcrystal"
tt.render.sprites[1].anchor = v(0.5, 0.23958333333333334)
tt.render.sprites[tt.render.sid_animated].prefix = "coonsuprices_darkcrystal"
tt.render.sprites[tt.render.sid_animated].name = "idle"
tt.render.sprites[tt.render.sid_animated].offset = v(0, 0)
tt.render.sprites[tt.render.sid_animated].anchor = vv(0.5)
tt = E:register_t_10086("decal_achievement_a_coon_of_surprises_sheepy", "decal_achievement_a_coon_of_surprises_fredo")

E:add_comps(tt, "ui")

tt.give_achievement = false
tt.change_z_time = fts(30)
tt.change_y_sort_offset = -336
tt.ui.click_rect = r(-17, -60, 40, 70)
tt.render.sprites[1].name = "coonsuprices_cuerdadarkcrystal"
tt.render.sprites[1].anchor = v(0.5, 0.23958333333333334)
tt.render.sprites[tt.render.sid_animated].prefix = "coonsuprices_sheepy"
tt.render.sprites[tt.render.sid_animated].name = "idle"
tt.render.sprites[tt.render.sid_animated].offset = v(0, 0)
tt.render.sprites[tt.render.sid_animated].anchor = v(0.5, 0.5173913043478261)
tt = E:register_t_10086("decal_achievement_a_coon_of_surprises_arak", "decal_achievement_a_coon_of_surprises_fredo")

E:add_comps(tt, "ui")

tt.give_achievement = false
tt.ui.click_rect = r(-20, -40, 62, 75)
tt.change_y_sort_offset = 0
tt.render.sid_animated = 1
tt.render.sprites[2] = nil
tt.render.sprites[tt.render.sid_animated].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_animated].prefix = "coonsuprices_arak"
tt.render.sprites[tt.render.sid_animated].name = "idle"
tt.render.sprites[tt.render.sid_animated].animated = true
tt.render.sprites[tt.render.sid_animated].anchor = vv(0.5)
tt = E:register_t_10086("decal_achievement_lucas_spider", "decal_scripted")

E:add_comps(tt, "ui")

tt.ui.can_click = true
tt.ui.click_rect = r(-20, -10, 40, 40)
tt.main_script.update = scripts.decal_achievement_lucas_spider.update
tt.render.sprites[1].prefix = "export_easter_egg_lucas"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor = vv(0.5)
tt = E:register_t_10086("decal_stage_29_background_eyes", "decal")
tt.render.sprites[1].prefix = "spiders_stage29_eyes_stageDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("mask_stage_30_1", "decal")
tt.render.sprites[1].name = "stage_30_mask_01"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -60
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("mask_stage_30_2", "decal")
tt.render.sprites[1].name = "stage_30_mask_02"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -112
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("mask_stage_30_3", "decal")
tt.render.sprites[1].name = "stage_30_mask_03"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("mask_stage_30_4", "decal")
tt.render.sprites[1].name = "stage_30_mask_04"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("mask_stage_30_5", "decal")
tt.render.sprites[1].name = "stage_30_mask_05"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("decal_stage_30_door", "decal_scripted")
b = balance.specials.stage30_door
tt.render.sprites[1].prefix = "stage_30_spider_doorDef"
tt.render.sprites[1].name = "idle1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = 100
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts.decal_stage_30_door.update
tt.animation_idle_open = "idle2"
tt.animation_idle_closed = "idle1"
tt.animation_open = "open"
tt.animation_close = "close"
tt.waves = b
tt = E:register_t_10086("decal_mod_stage_22_tower_stun_hand", "decal_tween")
tt.render.sprites[1].prefix = "crocs_tower_block_tap"
tt.render.sprites[1].name = "tap"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt.render.sprites[1].offset = v(23, 10)
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(15),
		255
	},
	{
		fts(45),
		255
	},
	{
		fts(60),
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("tower_holder_blocked_terrain_6", "tower_holder_blocked_2")
b = balance.specials.terrain_6.blocked_holders
tt.tower.type = "holder_blocked_sea_of_trees"
tt.tower_holder.unblock_price = b.price
tt.render.sprites[1].name = "terrains_holders_0008_blocked"
tt.render.sprites[2].name = "terrains_holders_0008_flag_blocked"
tt = E:register_t_10086("tower_holder_blocked_terrain_6_2", "tower_holder_blocked_2")
b = balance.specials.terrain_6.blocked_holders
tt.tower.type = "holder_blocked_sea_of_trees"
tt.tower_holder.unblock_price = b.price
tt.render.sprites[1].name = "terrains_holders_0009_blocked"
tt.render.sprites[2].name = "terrains_holders_0009_flag_blocked"
tt = E:register_t_10086("tower_holder_blocked_spiders", "tower_holder_blocked_2")

E:add_comps(tt, "main_script")

b = balance.specials.stage29_holder_block.blocked_holders
tt.main_script.insert = scripts.tower_holder_blocked_spiders.insert
tt.tower.type = "holder_blocked_spiders"
tt.tower_holder.unblock_price = b.price[1]
tt.prices = b.price
tt.render.sprites[1].name = "terrains_holders_0004"
tt.render.sprites[2].name = "terrains_holders_0018_flag_blocked"
tt = E:register_t_10086("tower_build_sparking_geode", "tower_build")
tt.build_name = "tower_sparking_geode_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[1].hidden = true
tt.render.sprites[2].name = "sparking_geode_construction"
tt.render.sprites[2].offset = v(0, 10)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
tt = E:register_t_10086("tower_sparking_geode_lvl1", "tower_KR5")
b = balance.towers.sparking_geode

E:add_comps(tt, "attacks", "vis")

tt.wakeup_duration = fts(45)
tt.tower.type = "sparking_geode"
tt.tower.kind = TOWER_KIND_ENGINEER
tt.tower.team = TEAM_LINIREA
tt.tower.level = 1
tt.tower.price = b.price[1]
tt.tower.menu_offset = v(3, 19)
tt.info.enc_icon = 3
tt.info.i18n_key = "TOWER_SPARKING_GEODE_1"
tt.info.portrait = "portraits_towers_0030"
tt.info.room_portrait = "quickmenu_main_icons_main_icons_0024_0001"
tt.info.fn = scripts.tower_sparking_geode.get_info
tt.main_script.update = scripts.tower_sparking_geode.update
tt.attacks.min_cooldown = b.shared_min_cooldown
tt.attacks.range = b.basic_attack.range[1]
tt.attacks.attack_delay_on_spawn = fts(5)
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].animation_start = "attack_in"
tt.attacks.list[1].animation_loop = "attack_loop"
tt.attacks.list[1].animation_end = "attack_out"
tt.attacks.list[1].bullet = "tower_sparking_geode_ray_lvl1"
tt.attacks.list[1].cooldown = b.basic_attack.cooldown
tt.attacks.list[1].prediction_time = fts(23)
tt.attacks.list[1].ray_timing_max = b.basic_attack.ray_timing_max[tt.tower.level]
tt.attacks.list[1].ray_timing_min = b.basic_attack.ray_timing_min[tt.tower.level]
tt.attacks.list[1].targeting_style = b.basic_attack.targeting_style
tt.attacks.list[1].ignore_out_of_range_check = 1
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[1].sound = "TowerElvenStargazersBasicAttack"
tt.attacks.list[1].bullet_start_offset = {
	v(-20, 52),
	v(-10, 60),
	v(10, 60),
	v(20, 52)
}
tt.attacks.list[1].bullet_start_offset_safe = {
	v(-20, 52),
	v(-10, 60),
	v(0, 35),
	v(10, 60),
	v(20, 52)
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[1].hidden = true
tt.render.sid_base_back = 2
tt.render.sprites[tt.render.sid_base_back] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_base_back].prefix = "sparking_geode_base"
tt.render.sprites[tt.render.sid_base_back].name = "off_idle"
tt.render.sprites[tt.render.sid_base_back].scale = vv(0.8)
tt.render.sid_base_electricity = 3
tt.render.sprites[tt.render.sid_base_electricity] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_base_electricity].prefix = "sparking_geode_base"
tt.render.sprites[tt.render.sid_base_electricity].name = "idleup"
tt.render.sprites[tt.render.sid_base_electricity].scale = vv(0.8)
tt.render.sid_base_front_rocks = 4
tt.render.sprites[tt.render.sid_base_front_rocks] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_base_front_rocks].animated = false
tt.render.sprites[tt.render.sid_base_front_rocks].name = "sparking_geode_base_lvl1"
tt.render.sid_geode = 5
tt.render.sprites[tt.render.sid_geode] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_geode].prefix = "sparking_geode_tower_lvl1"
tt.render.sprites[tt.render.sid_geode].name = "idle"
tt.render.sprites[tt.render.sid_geode].offset = v(0, 0)
tt.render.sid_attack_fx = 6
tt.render.sprites[tt.render.sid_attack_fx] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_attack_fx].prefix = "sparking_geode_tower_attack_fx_attack"
tt.render.sprites[tt.render.sid_attack_fx].name = "in"
tt.render.sprites[tt.render.sid_attack_fx].hidden = true
tt.render.sprites[tt.render.sid_attack_fx].offset = v(0, 24)
tt.render.sprites[tt.render.sid_attack_fx].scale = vv(0.92)
tt.sound_events.insert = "TowerSparkingGeodeTaunt"
tt.sound_events.tower_room_select = "TowerSparkingGeodeTauntSelect"
tt.ui.click_rect = r(-35, 0, 72, 55)
tt.fx_evolve = "fx_tower_sparking_geode_evolve"
tt.fx_evolve_offset = v(0, 0)
tt = E:register_t_10086("tower_sparking_geode_lvl2", "tower_sparking_geode_lvl1")
b = balance.towers.sparking_geode
tt.info.i18n_key = "TOWER_SPARKING_GEODE_2"
tt.tower.level = 2
tt.tower.price = b.price[2]
tt.tower.menu_offset = v(3, 22)
tt.attacks.range = b.basic_attack.range[2]
tt.attacks.list[1].bullet = "tower_sparking_geode_ray_lvl2"
tt.attacks.list[1].ray_timing_max = b.basic_attack.ray_timing_max[tt.tower.level]
tt.attacks.list[1].ray_timing_min = b.basic_attack.ray_timing_min[tt.tower.level]
tt.attacks.list[1].bullet_start_offset = {
	v(-20, 52),
	v(-10, 69),
	v(10, 69),
	v(20, 52)
}
tt.attacks.list[1].bullet_start_offset_safe = {
	v(-20, 52),
	v(-10, 69),
	v(0, 43),
	v(10, 69),
	v(20, 52)
}
tt.render.sprites[tt.render.sid_geode].prefix = "sparking_geode_tower_lvl2"
tt.render.sprites[tt.render.sid_base_back].scale = vv(0.9)
tt.render.sprites[tt.render.sid_base_electricity].scale = vv(0.9)
tt.render.sprites[tt.render.sid_base_front_rocks].hidden = true
tt.render.sprites[tt.render.sid_attack_fx].offset = v(0, 15)
tt.render.sprites[tt.render.sid_attack_fx].scale = vv(1.05)
tt.ui.click_rect = r(-36, 0, 75, 73)
tt = E:register_t_10086("tower_sparking_geode_lvl3", "tower_sparking_geode_lvl1")
b = balance.towers.sparking_geode
tt.info.i18n_key = "TOWER_SPARKING_GEODE_3"
tt.tower.level = 3
tt.tower.price = b.price[3]
tt.tower.menu_offset = v(3, 30)
tt.attacks.range = b.basic_attack.range[3]
tt.attacks.list[1].bullet = "tower_sparking_geode_ray_lvl3"
tt.attacks.list[1].ray_timing_max = b.basic_attack.ray_timing_max[tt.tower.level]
tt.attacks.list[1].ray_timing_min = b.basic_attack.ray_timing_min[tt.tower.level]
tt.attacks.list[1].bullet_start_offset = {
	v(-26, 76),
	v(-10, 69),
	v(10, 69),
	v(26, 65)
}
tt.attacks.list[1].bullet_start_offset_safe = {
	v(-26, 76),
	v(-10, 69),
	v(0, 43),
	v(10, 69),
	v(26, 65)
}
tt.render.sprites[tt.render.sid_geode].prefix = "sparking_geode_tower_lvl3"
tt.render.sprites[tt.render.sid_base_back].scale = vv(1)
tt.render.sprites[tt.render.sid_base_electricity].scale = vv(1)
tt.render.sprites[tt.render.sid_base_front_rocks].hidden = true
tt.render.sprites[tt.render.sid_attack_fx].offset = v(0, 10)
tt.render.sprites[tt.render.sid_attack_fx].scale = vv(1)
tt.ui.click_rect = r(-37, 0, 80, 76)
tt = E:register_t_10086("tower_sparking_geode_lvl4", "tower_sparking_geode_lvl1")
b = balance.towers.sparking_geode

E:add_comps(tt, "powers")

tt.info.i18n_key = "TOWER_SPARKING_GEODE_4"
tt.info.stat_damage = b.stats.damage
tt.info.stat_range = b.stats.range
tt.info.stat_cooldown = b.stats.cooldown
tt.info.damage_icon = "magic"
tt.tower.level = 4
tt.tower.price = b.price[4]
tt.tower.menu_offset = v(3, 28)
tt.attacks.range = b.basic_attack.range[4]
tt.powers.crystalize = CC("power")
tt.powers.crystalize.price = b.crystalize.price
tt.powers.crystalize.cooldown = b.crystalize.cooldown
tt.powers.crystalize.enc_icon = 537
tt.powers.crystalize.name = "crystalize"
tt.powers.crystalize.key = "CRYSTALIZE"
tt.powers.spike_burst = CC("power")
tt.powers.spike_burst.price = b.spike_burst.price
tt.powers.spike_burst.cooldown = b.spike_burst.cooldown
tt.powers.spike_burst.enc_icon = 538
tt.powers.spike_burst.name = "spike_burst"
tt.powers.spike_burst.key = "SPIKE_BURST"
tt.render.sprites[tt.render.sid_geode].prefix = "sparking_geode_tower_lvl4"
tt.render.sprites[tt.render.sid_base_back].scale = vv(1)
tt.render.sprites[tt.render.sid_base_electricity].scale = vv(1)
tt.render.sprites[tt.render.sid_base_front_rocks].hidden = true
tt.render.sprites[tt.render.sid_attack_fx].offset = v(0, 10)
tt.render.sprites[tt.render.sid_attack_fx].scale = vv(1)
tt.attacks.list[1].bullet = "tower_sparking_geode_ray_lvl4"
tt.attacks.list[1].ray_timing_max = b.basic_attack.ray_timing_max[tt.tower.level]
tt.attacks.list[1].ray_timing_min = b.basic_attack.ray_timing_min[tt.tower.level]
tt.attacks.list[1].bullet_start_offset = {
	v(-30, 90),
	v(-15, 105),
	v(15, 105),
	v(30, 90)
}
tt.attacks.list[1].bullet_start_offset_safe = {
	v(-30, 60),
	v(-30, 90),
	v(-15, 105),
	v(15, 105),
	v(30, 90),
	v(30, 60)
}
tt.attacks.list[2] = CC("custom_attack")
tt.attacks.list[2].animation = "hability_2"
tt.attacks.list[2].mod = "mod_tower_sparking_geode_stun"
tt.attacks.list[2].duration = b.crystalize.duration
tt.attacks.list[2].received_damage_factor = b.crystalize.received_damage_factor
tt.attacks.list[2].cooldown = nil
tt.attacks.list[2].vis_flags = bor(F_STUN, F_MOD, F_CUSTOM)
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_MINIBOSS, F_NIGHTMARE, F_FLYING, F_STUN, F_CUSTOM)
tt.attacks.list[2].cast_time = fts(16)
tt.attacks.list[2].max_targets = b.crystalize.max_targets
tt.attacks.list[2].up_ray_fx = "fx_tower_sparking_geode_up_ray"
tt.attacks.list[2].sound_cast = "TowerSparkingGeodeCristalizeCast"
tt.attacks.list[3] = CC("custom_attack")
tt.attacks.list[3].animation = "hability_1"
tt.attacks.list[3].cast_time = fts(26)
tt.attacks.list[3].aura = "aura_tower_sparking_geode_spike_burst"
tt.attacks.list[3].cooldown = nil
tt.attacks.list[3].vis_flags = bor(F_MOD)
tt.attacks.list[3].vis_bans = bor(F_FLYING)
tt.attacks.list[3].duration = b.spike_burst.duration
tt.attacks.list[3].range = b.spike_burst.radius
tt.attacks.list[3].sound_cast = "TowerSparkingGeodeSpikeCast"
tt.attacks.list[3].sound_loop = "TowerSparkingGeodeSpikeLoop"
tt.ui.click_rect = r(-40, 0, 85, 83)
tt = E:register_t_10086("tower_stage_28_priests_barrack", "tower_KR5")
b = balance.specials.towers.tower_stage_28_priests_barrack

E:add_comps(tt, "vis", "barrack")

tt.tower.type = "tower_priests_barrack"
tt.tower.level = 1
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.can_be_sold = false
tt.tower.can_be_mod = false
tt.tower.range_offset = v(0, 10)
tt.tower.price = 0
tt.tower.menu_offset = v(0, 25)

function tt.info.fn(this)
	return {
		type = STATS_TYPE_TEXT,
		desc = this.info.desc
	}
end

tt.main_script.update = scripts.tower_barrack_mercenaries_KR5.update
tt.main_script.remove = scripts.tower_barrack.remove

function tt.main_script.insert(this, store, script)
	if this.render.sprites[1].flip_x == true then
		this.barrack.respawn_offset.x = this.barrack.respawn_offset.x * -1
	end

	return scripts.tower_barrack.insert(this, store, script)
end

tt.info.portrait = "portraits_towers_0029"
tt.info.desc = "SPECIAL_PRIESTS_SOLDIERS_DESCRIPTION"
tt.render.tower_sid = 2
tt.render.door_sid = 3
tt.render.candles_sid = 4
tt.render.sprites[tt.render.tower_sid] = E:clone_c("sprite")
tt.render.sprites[tt.render.tower_sid].animated = true
tt.render.sprites[tt.render.tower_sid].prefix = "redemeed_cultist_barraca_base"
tt.render.sprites[tt.render.tower_sid].name = "idle"
tt.render.sprites[tt.render.door_sid] = E:clone_c("sprite")
tt.render.sprites[tt.render.door_sid].animated = true
tt.render.sprites[tt.render.door_sid].prefix = "redemeed_cultist_barraca_door"
tt.render.sprites[tt.render.door_sid].name = "closed"
tt.render.sprites[tt.render.door_sid].offset = v(0, 14)
tt.render.sprites[tt.render.candles_sid] = E:clone_c("sprite")
tt.render.sprites[tt.render.candles_sid].animated = true
tt.render.sprites[tt.render.candles_sid].prefix = "redemeed_cultist_barraca_fire_candle"
tt.render.sprites[tt.render.candles_sid].name = "idle"
tt.barrack.soldier_type = "soldier_priests_barrack"
tt.barrack.rally_range = 209.28
tt.barrack.respawn_offset = v(0, 5)
tt.barrack.max_soldiers = b.max_soldiers
tt.sound_events.change_rally_point = "Stage04ArboreanThornspears"
tt.ui.click_rect = r(-35, -15, 70, 70)
tt = E:register_t_10086("soldier_priests_barrack", "soldier_militia")
b = balance.specials.towers.tower_stage_28_priests_barrack.priest

E:add_comps(tt, "nav_grid", "ranged", "death_spawns")

tt.health.armor = b.armor
tt.health.hp_max = b.hp_max
tt.regen.health = b.regen_health
tt.health_bar.offset = v(0, 35)
tt.health.dead_lifetime = 2
tt.nav_rally.delay_max = nil
tt.info.fn = scripts.soldier_priests_barrack.get_info
tt.info.damage_icon = b.melee.damage_type == DAMAGE_MAGICAL and "magic" or nil
tt.info.portrait = "gui_bottom_info_image_soldiers_0058"
tt.info.random_name_format = "SOLDIER_PRIESTS_BARRACK_%i_NAME"
tt.info.random_name_count = 9
tt.main_script.insert = scripts.soldier_barrack.insert
tt.main_script.update = scripts.soldier_priests_barrack.update
tt.melee.attacks[1].cooldown = b.melee.cooldown
tt.melee.attacks[1].damage_max = b.melee.damage_max
tt.melee.attacks[1].damage_min = b.melee.damage_min
tt.melee.attacks[1].damage_type = b.melee.damage_type
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].animation = "melee_attack"
tt.melee.attacks[1].hit_fx = "fx_soldier_priests_barrack_melee_hit"
tt.melee.attacks[1].hit_offset = v(23, 13)
tt.motion.max_speed = b.max_speed
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "redemeed_cultist_barraca_priest"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk",
	"walk"
}
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].anchor = v(0.5, 0.5172413793103449)
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].max_range = b.ranged.range
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].cooldown = b.ranged.cooldown
tt.ranged.attacks[1].damage_min = b.ranged.damage_min
tt.ranged.attacks[1].damage_max = b.ranged.damage_max
tt.ranged.attacks[1].bullet = "bullet_soldier_priests_barrack"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 36)
}
tt.ranged.attacks[1].shoot_time = fts(24)
tt.ranged.attacks[1].node_prediction = fts(24)
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.death_spawns.name = "soldier_abomination_priests_barrack"
tt.death_spawns.death_animation = "transformation_abomination"
tt.death_spawns.concurrent_with_death = false
tt.death_spawns.delay = nil
tt.death_spawns.offset = v(0, 2)
tt.death_spawns.dead_lifetime = 0
tt.transform_chances = b.transform_chances
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.price = b.price
tt.unit.fade_time_after_death = 1
tt.sound_events.insert = "Stage04ArboreanThornspears"
tt = E:register_t_10086("soldier_abomination_priests_barrack", "soldier_militia")
b = balance.specials.towers.tower_stage_28_priests_barrack.abomination

E:add_comps(tt, "nav_grid", "reinforcement", "tween")

tt.health.hp_max = b.hp_max
tt.health.armor = b.armor
tt.regen.health = b.regen_health
tt.health.dead_lifetime = 3
tt.health_bar.offset = v(0, 50)
tt.unit.hit_offset = v(0, 21)
tt.unit.head_offset = v(0, 21)
tt.unit.mod_offset = v(0, 16)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.motion.max_speed = b.max_speed
tt.render.sprites[1].prefix = "redemeed_cultist_barraca_unblinded_abomination"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk",
	"walk"
}
tt.render.sprites[1].angles_stickiness = {
	walk = 0
}
tt.render.sprites[1].anchor = vv(0.5)
tt.info.enc_icon = 18
tt.info.portrait = "gui_bottom_info_image_soldiers_0059"
tt.eat = {}
tt.eat.hp_required = b.eat.hp_required
tt.main_script.insert = scripts.soldier_barrack.insert
tt.main_script.update = scripts.soldier_abomination_priests_barrack.update
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].hit_fx = "fx_soldier_priests_barrack_abomination_melee_hit"
tt.melee.attacks[1].hit_offset = v(30, 10)
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].animation = "eat"
tt.melee.attacks[2].cooldown = b.eat.cooldown
tt.melee.attacks[2].damage_type = bor(DAMAGE_NONE, DAMAGE_NO_DODGE)
tt.melee.attacks[2].hit_time = fts(20)
tt.melee.attacks[2].mod = "mod_priests_abomination_eat"
tt.melee.attacks[2].vis_flags = bor(F_BLOCK, F_EAT, F_INSTAKILL)
tt.melee.attacks[2].vis_bans = bor(F_HERO)
tt.melee.attacks[2].sound = "EnemyAbominationInstakill"
tt.melee.attacks[2].fn_can = function(t, s, a, target)
	return target.health and target.health.hp <= target.health.hp_max * t.eat.hp_required
end
tt.sound_events.death = "EnemyAbominationDeath"
tt.ui.click_rect = r(-30, -3, 60, 50)
tt.reinforcement.duration = b.duration
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.reverse = false
tt = E:register_t_10086("decal_tentacle_priests_barrack", "decal_scripted")
b = balance.specials.towers.tower_stage_28_priests_barrack.tentacle

E:add_comps(tt, "area_attack")

tt.render.sprites[1].prefix = "redemeed_cultist_barraca_tentacle"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].sort_y_offset = 1
tt.render.sprites[1].anchor = vv(0.5)
tt.main_script.update = scripts.decal_tentacle_priests_barrack.update
tt.area_attack.aura = "priests_tentacle_aura"
tt.area_attack.hit_time = fts(14)
tt.area_attack.max_range = b.area_attack.radius
tt.area_attack.radius = b.area_attack.radius
tt.area_attack.cooldown_min = b.area_attack.cooldown_min
tt.area_attack.cooldown_max = b.area_attack.cooldown_max
tt.area_attack.animation = "attack01"
tt.area_attack.vis_bans = 0
tt.duration = b.duration
tt = E:register_t_10086("boss_machinist", "boss")

E:add_comps(tt, "ranged", "tween")

b = balance.enemies.hammer_and_anvil.boss_machinist
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.boss_machinist.update
tt.motion.max_speed = b.speed
tt.enemy.lives_cost = 999
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.dead_lifetime = 100
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, 150)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.flight_height = 80
tt.render.sprites[1].prefix = "dlcdwarfbossstage02Def"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.idle = {
	"run",
	"run"
}
tt.render.sprites[1].angles.walk = {
	"run",
	"run"
}
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[1].offset = v(0, 500)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_hero_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.descend_duration = 2
tt.tween.remove = false
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		v(0, 500)
	},
	{
		tt.descend_duration,
		v(0, -tt.flight_height)
	}
}
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		vv(3)
	},
	{
		tt.descend_duration,
		vv(1)
	}
}
tt.tween.props[2].name = "scale"
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].interp = "sine"
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		0.1
	},
	{
		tt.descend_duration,
		255
	}
}
tt.tween.props[3].name = "alpha"
tt.tween.props[3].sprite_id = 2
tt.tween.props[3].interp = "sine"
tt.info.i18n_key = "ENEMY_BOSS_MACHINIST"
tt.info.enc_icon = 81
tt.info.portrait_boss = "boss_health_bar_icon_0006"
tt.info.portrait = "gui_bottom_info_image_enemies_0086"
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].shoot_time = fts(0)
tt.ranged.attacks[1].bullet = "bullet_boss_machinist"
tt.ranged.attacks[1].animation = "attackloop"
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].vis_flags = bor(F_RANGED, F_AREA)
tt.ranged.attacks[1].vis_bans = bor(F_FLYING, F_ENEMY)
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, tt.flight_height + 40),
	v(0, tt.flight_height + 40)
}
tt.ui.click_rect = r(-35, tt.flight_height - 20, 70, 70)
tt.unit.can_explode = false
tt.unit.hit_offset = v(8, tt.flight_height + 25)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height + 20)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_FLYING)
tt.vis.bans = bor(F_BLOCK, F_STUN)
tt.sound_death = "Stage24Outro"
tt.stop_cooldown = b.stop_cooldown
tt.attacks_count = b.attacks_count
tt.burn_aura_t = "aura_boss_machinist_burn"
tt.death_smoke_fx = "fx_boss_machinist_death_smoke"
tt.death_particle_fx = "fx_boss_machinist_death_particle"
tt = E:register_t_10086("boss_deformed_grymbeard", "boss")
b = balance.enemies.hammer_and_anvil.boss_deformed_grymbeard
tt.motion.max_speed = 0
tt.enemy.lives_cost = 999
tt.health.immune_to = DAMAGE_ALL
tt.clones_to_die = b.clones_to_die
tt.main_script.update = scripts.boss_deformed_grymbeard.update
tt.on_clone_death_f = scripts.boss_deformed_grymbeard.on_clone_death
tt.render.sprites[1].hidden = true
tt.info.i18n_key = "ENEMY_BOSS_DEFORMED_GRYMBEARD"
tt.info.enc_icon = 78
tt.info.portrait_boss = "boss_health_bar_icon_0007"
tt.ui.click_rect = r(0, 0, 0, 0)
tt.ui.can_click = false
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.vis.bans = bor(F_ALL)
tt.sound_damage = "Stage26BFGrymbeardDamaged"
tt.sound_death = "Stage19NaviraDeath"
tt.boss_decal_t = "decal_stage_26_boss"
tt = E:register_t_10086("boss_grymbeard", "boss")

E:add_comps(tt, "melee", "ranged")

b = balance.enemies.hammer_and_anvil.boss_grymbeard
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.boss_grymbeard.update
tt.motion.max_speed = b.speed
tt.enemy.lives_cost = 999
tt.enemy.melee_slot = v(40, 0)
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.dead_lifetime = 100
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, 110)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.render.sprites[1].prefix = "dclenanos_stage05_grymbossDef"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[1].angles.walk = {
	"walkside",
	"walkdown",
	"walkdown"
}
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].z = Z_OBJECTS
tt.info.i18n_key = "ENEMY_BOSS_GRYMBEARD"
tt.info.enc_icon = 83
tt.info.portrait_boss = "boss_health_bar_icon_0009"
tt.info.portrait = "gui_bottom_info_image_enemies_0088"
tt.melee.attacks[1] = E:clone_c("area_attack")
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].damage_radius = b.melee_attack.damage_radius
tt.melee.attacks[1].hit_time = fts(27)
tt.melee.attacks[1].damage_type = bor(b.melee_attack.damage_type, DAMAGE_NO_DODGE)
tt.melee.attacks[1].hit_fx_offset = v(15, -10)
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].hit_decal = "decal_boss_grymbeard_area_attack"
tt.melee.attacks[1].hit_offset = v(60, 0)
tt.melee.attacks[1].sound = "Stage27BFGrymbeardMeleeAttack"
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].shoot_time = fts(25)
tt.ranged.attacks[1].bullet = "bullet_boss_grymbeard"
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].vis_flags = bor(F_RANGED, F_AREA)
tt.ranged.attacks[1].vis_bans = bor(F_FLYING, F_ENEMY)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-35, 125),
	v(35, 125)
}
tt.ui.click_rect = r(-40, 0, 80, 85)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 60)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.vis.bans = bor(F_STUN)
tt.death_bullet_clone = "bullet_boss_grymbeard_death_clone"
tt.death_bullet_boss = "bullet_boss_grymbeard_death_boss"
tt.death_bullet_scrap = "bullet_boss_grymbeard_death_scrap_"
tt.sound_death = "Stage27BFGrymbeardDeath"
tt = E:register_t_10086("enemy_darksteel_hammerer", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.darksteel_hammerer

E:add_comps(tt, "melee")

tt.info.i18n_key = "ENEMY_DARKSTEEL_HAMMERER"
tt.info.enc_icon = 68
tt.info.portrait = "gui_bottom_info_image_enemies_0073"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(35, 0)
tt.health_bar.offset = v(0, 33)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 3
tt.unit.hit_offset = v(0, 12)
tt.unit.head_offset = v(0, 21)
tt.unit.mod_offset = v(0, 12)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-17, -3, 34, 32)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "darksteel_hammerer_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.vis.flags = bor(tt.vis.flags)
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].animation = "attack"
tt = E:register_t_10086("enemy_darksteel_shielder", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.darksteel_shielder

E:add_comps(tt, "melee", "death_spawns")

tt.info.i18n_key = "ENEMY_DARKSTEEL_SHIELDER"
tt.info.enc_icon = 69
tt.info.portrait = "gui_bottom_info_image_enemies_0074"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(25, 0)
tt.health_bar.offset = v(0, 28)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 3
tt.unit.hit_offset = v(0, 16)
tt.unit.head_offset = v(0, 21)
tt.unit.mod_offset = v(0, 10)
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.ui.click_rect = r(-17, -3, 34, 30)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "darksteel_shielder_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.sound_events.death = "EnemyDarksteelShielderDeath"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_darksteel_shielder.update
tt.vis.flags = bor(tt.vis.flags)
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].animation = "attack"
tt.death_spawns.name = "enemy_darksteel_hammerer"
tt.death_spawns.concurrent_with_death = false
tt.death_spawns.delay = fts(46.1)
tt = E:register_t_10086("enemy_surveillance_sentry", "enemy_KR5")

E:add_comps(tt, "death_spawns", "tween")

local b = balance.enemies.hammer_and_anvil.surveillance_sentry

tt.info.enc_icon = 72
tt.info.portrait = "gui_bottom_info_image_enemies_0077"
tt.enemy.gold = b.gold
tt.enemy.lives_cost = b.lives_cost
tt.flight_height = 40
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, tt.flight_height + 35)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_surveillance_sentry.update
tt.motion.max_speed = b.speed
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].prefix = "rolling_sentry_creep_flying"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "EnemyPatrollingVultureDeath"
tt.ui.click_rect = r(-18, tt.flight_height - 5, 36, 36)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 15)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height + 15)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.unit.blood_color = BLOOD_GRAY
tt.vis.bans = bor(F_BLOCK, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.death_spawns.name = "enemy_rolling_sentry"
tt.death_spawns.death_animation = "death"
tt.death_spawns.concurrent_with_death = false
tt.death_spawns.delay = fts(12)
tt.death_spawns.dead_lifetime = 0
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].sprite_id = 2
tt = E:register_t_10086("enemy_rolling_sentry", "enemy_KR5")
b = balance.enemies.hammer_and_anvil.rolling_sentry

E:add_comps(tt, "melee", "ranged", "death_spawns")

tt.info.enc_icon = 71
tt.info.portrait = "gui_bottom_info_image_enemies_0076"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, 35)
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_rolling_sentry.update
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_type = b.melee_attack.damage_type
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[1].animation_in = "walk_out"
tt.melee.attacks[1].animation = "attack_loop_side"
tt.melee.attacks[1].animation_out = "walk_in"
tt.motion.max_speed = b.speed
tt.ranged.attacks[1].animation_in = "walk_out"
tt.ranged.attacks[1].animation = "attack_loop_side"
tt.ranged.attacks[1].animation_out = "walk_in"
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].bullet = "bullet_enemy_rolling_sentry"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 23),
	v(5, 23),
	v(5, 23)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].shoot_time = fts(7)
tt.ranged.attacks[1].sound = "EnemyRollingSentryAttack"
tt.render.sprites[1].angles.walk = {
	"walk_loop",
	"walk_loop_back",
	"walk_loop_front"
}
tt.render.sprites[1].angles.attack = {
	"attack_loop_side",
	"attack_loop_back",
	"attack_loop_front"
}
tt.render.sprites[1].prefix = "rolling_sentry_creep"
tt.sound_events.death = "EnemyRollingSentryDeath"
tt.unit.hit_offset = v(0, 10)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.unit.blood_color = BLOOD_GRAY
tt.ui.click_rect = r(-16, -3, 32, 30)
tt.death_spawns.name = "decal_scrap"
tt.death_spawns.death_animation = "death"
tt.death_spawns.concurrent_with_death = false
tt.death_spawns.delay = fts(12)
tt = E:register_t_10086("enemy_mad_tinkerer", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.mad_tinkerer

E:add_comps(tt, "melee", "timed_attacks")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(35, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 3
tt.health_bar.offset = v(0, 47)
tt.unit.hit_offset = v(0, 10)
tt.unit.head_offset = v(0, 21)
tt.unit.mod_offset = v(0, 10)
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.ui.click_rect = r(-17, -3, 34, 40)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "mad_tinkerer"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.sound_events.death = "EnemyMadTinkererDeath"
tt.info.i18n_key = "ENEMY_MAD_TINKERER"
tt.info.enc_icon = 75
tt.info.portrait = "gui_bottom_info_image_enemies_0080"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mad_tinkerer.update
tt.vis.flags = bor(tt.vis.flags, F_DARK_ELF, F_SPELLCASTER)
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_fx = "fx_enemy_mad_tinkerer_hit"
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "skill"
tt.timed_attacks.list[1].loop_time = fts(30)
tt.timed_attacks.list[1].cast_time = fts(34)
tt.timed_attacks.list[1].cooldown = b.clone.cooldown
tt.timed_attacks.list[1].radius = b.clone.max_range
tt.timed_attacks.list[1].min_range = b.clone.min_range
tt.timed_attacks.list[1].entity_search = "decal_scrap"
tt.timed_attacks.list[1].entity_spawn = "enemy_scrap_drone"
tt.timed_attacks.list[1].ray = "decal_ray_mad_tinkerer"
tt.timed_attacks.list[1].bullet = "decal_scrap_bullet_mad_tinkerer"
tt.timed_attacks.list[1].spawn_delay = 0
tt.timed_attacks.list[1].sound = "EnemyMadTinkererRayCast"
tt.timed_attacks.list[1].count_group_name = "enemy_mad_tinkerer"
tt.timed_attacks.list[1].count_group_type = COUNT_GROUP_CONCURRENT
tt.timed_attacks.list[1].count_group_max = b.clone.max_total
tt.nodes_limit = b.clone.nodes_limit
tt.sound_summon = "EnemyMadTinkererSummon"
tt = E:register_t_10086("enemy_scrap_drone", "enemy_KR5")

E:add_comps(tt, "tween")

local b = balance.enemies.hammer_and_anvil.scrap_drone

tt.info.enc_icon = 76
tt.info.portrait = "gui_bottom_info_image_enemies_0081"
tt.enemy.gold = b.gold
tt.enemy.lives_cost = b.lives_cost
tt.flight_height = 40
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, tt.flight_height + 35)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_surveillance_sentry.update
tt.motion.max_speed = b.speed
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "scrap_drone_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "scrap_drone_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "EnemyScrapDroneDeath"
tt.ui.click_rect = r(-18, tt.flight_height - 5, 36, 36)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 15)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height + 15)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.unit.blood_color = BLOOD_GRAY
tt.vis.bans = bor(F_BLOCK, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].sprite_id = 2
tt = E:register_t_10086("enemy_brute_welder", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.brute_welder

E:add_comps(tt, "melee", "death_spawns")

tt.info.enc_icon = 73
tt.info.portrait = "gui_bottom_info_image_enemies_0078"
tt.info.fn = scripts.enemy_brute_welder.get_info
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(37, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 40)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_brute_welder.update
tt.melee.attacks[1] = E:clone_c("aura_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].aura = "aura_enemy_brute_welder"
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].aura_offset = v(b.basic_attack.flame.radius, 0)
tt.melee.attacks[1].vis_bans = 0
tt.melee.attacks[1].vis_flags = bor(F_AREA, F_BURN, F_ENEMY)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "brute_welder_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[1].draw_order = DO_ENEMY_BIG
tt.sound_events.death = "EnemyBruteWelderDeath"
tt.ui.click_rect = r(-20, -3, 40, 33)
tt.unit.hit_offset = v(0, 22)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 14)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.death_spawns.name = "controller_enemy_brute_welder_death"
tt.death_spawns.delay = fts(30)
tt = E:register_t_10086("controller_enemy_brute_welder_death")

local b = balance.enemies.hammer_and_anvil.brute_welder

E:add_comps(tt, "main_script", "render")

tt.main_script.update = scripts.controller_enemy_brute_welder_death.update
tt.render.sprites[1].name = "brute_welder_tank_projectile"
tt.render.sprites[1].hidden = true
tt.missile_t = "bullet_enemy_brute_welder_death"
tt.missile_range = b.death_missile.range
tt.shoot_sound = nil
tt.spawn_offset = v(-5, 20)
tt.mark_mod = "mod_bullet_enemy_brute_welder_death_mark"
tt = E:register_t_10086("enemy_scrap_speedster", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.scrap_speedster

E:add_comps(tt, "melee", "death_spawns")

tt.info.enc_icon = 70
tt.info.portrait = "gui_bottom_info_image_enemies_0075"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_scrap_speedster.update
tt.main_script.remove = scripts.enemy_scrap_speedster.remove
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "scrap_speedster_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.sound_events.death = "EnemyScrapSpeedsterDeath"
tt.ui.click_rect = r(-17, -3, 34, 30)
tt.unit.hit_offset = v(0, 11)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 11)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.can_explode = false
tt.unit.show_blood_pool = false
tt.unit.blood_color = BLOOD_GRAY
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.death_spawns.name = "decal_scrap"
tt.death_spawns.delay = fts(14)
tt.trail_t = "ps_enemy_scrap_speedster_trail"
tt = E:register_t_10086("enemy_common_clone", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.common_clone

E:add_comps(tt, "melee")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 67
tt.info.portrait = "gui_bottom_info_image_enemies_0072"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].hit_fx = "fx_enemy_common_clone_hit"
tt.melee.attacks[1].hit_offset = v(20, 10)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "common_clone_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.sound_events.death = "EnemyCommonCloneDeath"
tt.ui.click_rect = r(-13, 0, 26, 26)
tt = E:register_t_10086("enemy_darksteel_fist", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.darksteel_fist

E:add_comps(tt, "melee")

tt.info.enc_icon = 74
tt.info.portrait = "gui_bottom_info_image_enemies_0079"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_darksteel_fist.update
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_times = {
	fts(3),
	fts(12)
}
tt.melee.attacks[1].hit_fx = "fx_enemy_darksteel_fist_hit"
tt.melee.attacks[1].hit_offset = v(35, 10)
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].cooldown = b.stun_attack.cooldown
tt.melee.attacks[2].animation = "stun"
tt.melee.attacks[2].hit_time = fts(18)
tt.melee.attacks[2].hit_decal = "decal_enemy_darksteel_fist_stun"
tt.melee.attacks[2].hit_fx = "fx_enemy_darksteel_fist_area"
tt.melee.attacks[2].hit_offset = v(35, 0)
tt.melee.attacks[2].damage_min = b.stun_attack.damage_min
tt.melee.attacks[2].damage_max = b.stun_attack.damage_max
tt.melee.attacks[2].damage_radius = b.stun_attack.damage_radius
tt.melee.attacks[2].damage_type = b.stun_attack.damage_type
tt.melee.attacks[2].mod = "mod_enemy_darksteel_fist_stun"
tt.melee.attacks[2].sound = "EnemyDarksteelFistStun"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "darksteel_fist_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.sound_events.death = "EnemyDarksteelFistDeath"
tt.ui.click_rect = r(-20, -3, 40, 28)
tt.unit.hit_offset = v(0, 11)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 11)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.can_explode = false
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt = E:register_t_10086("enemy_darksteel_guardian", "enemy_KR5")
b = balance.enemies.hammer_and_anvil.darksteel_guardian

E:add_comps(tt, "melee", "death_spawns")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(37, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.info.enc_icon = 79
tt.info.portrait = "gui_bottom_info_image_enemies_0084"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_darksteel_guardian.update
tt.melee.attacks[1] = E:clone_c("area_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_time = fts(16)
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_fx = "fx_enemy_darksteel_guardian_hit_1"
tt.melee.attacks[1].hit_offset = v(40, 15)
tt.melee.attacks[1].sound = "EnemyDarksteelGuardianAttack"
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].cooldown = b.rage_attack.cooldown
tt.melee.attacks[2].damage_max = b.rage_attack.damage_max
tt.melee.attacks[2].damage_min = b.rage_attack.damage_min
tt.melee.attacks[2].damage_type = b.rage_attack.damage_type
tt.melee.attacks[2].hit_times = {
	fts(14),
	fts(24)
}
tt.melee.attacks[2].animation = "attack_2"
tt.melee.attacks[2].hit_offset = v(40, 15)
tt.melee.attacks[2].hit_fx = "fx_enemy_darksteel_guardian_hit_2"
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].sound = "EnemyDarksteelRageAttack"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "darksteel_guardian_creep"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].angles.walk = {
	"walk_1",
	"walk_front_1",
	"walk_front_1"
}
tt.render.sprites[1].draw_order = DO_ENEMY_BIG
tt.render.sprites[1].scale = vv(1.1)
tt.ui.click_rect = r(-32, -3, 64, 60)
tt.unit.hit_offset = v(0, 22)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 19)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.show_blood_pool = false
tt.unit.blood_color = BLOOD_GRAY
tt.vis.flags = bor(F_ENEMY, F_MINIBOSS)
tt.vis.bans = bor(F_STUN)
tt.start_asleep = false
tt.rage_hp_trigger = b.rage_hp_trigger
tt.death_spawns.name = "controller_darksteel_guardian_death"
tt.death_spawns.delay = fts(35)
tt.legs_t = "decal_enemy_darksteel_guardian_legs"
tt.sound_events.death = "EnemyDarksteelGuardianDeath"
tt.sound_activation = "EnemyDarksteelGuardianActivation"
tt.sound_rock = "EnemyDarksteelGuardianRock"
tt.sound_enrage = "EnemyDarksteelEnrage"
tt = E:register_t_10086("controller_darksteel_guardian")

E:add_comps(tt, "main_script", "editor")

tt.main_script.insert = scripts.controller_darksteel_guardian.insert
tt.guardian_t = "enemy_darksteel_guardian"
tt.editor.flip_x = false
tt.editor.path = 1
tt.editor.props = {
	{
		"editor.flip_x",
		PT_NUMBER
	},
	{
		"editor.path",
		PT_NUMBER
	}
}
tt = E:register_t_10086("controller_darksteel_guardian_death")
b = balance.enemies.hammer_and_anvil.darksteel_guardian

E:add_comps(tt, "main_script", "render")

tt.main_script.update = scripts.controller_darksteel_guardian_death.update
tt.render.sprites[1].name = "darksteel_guardian_dwarf_projectile"
tt.render.sprites[1].hidden = true
tt.clone_t = "bullet_enemy_darksteel_guardian_death"
tt.nodes_range = 20
tt.shoot_sound = nil
tt.spawn_offset = v(0, 20)
tt.legs_t = "decal_enemy_darksteel_guardian_legs"
tt.explotion_damage_min = b.death_explotion.damage_min
tt.explotion_damage_max = b.death_explotion.damage_max
tt.explotion_damage_radius = b.death_explotion.damage_radius
tt.explotion_damage_type = b.death_explotion.damage_type
tt.explotion_vis_bans = bor(F_ENEMY)
tt.explotion_vis_flags = bor(F_AREA, F_ENEMY)
tt = E:register_t_10086("controller_basic_clone_darksteel_guardian", "enemy_KR5")
b = balance.enemies.hammer_and_anvil.common_clone
tt.info.portrait = "gui_bottom_info_image_enemies_0067"
tt.motion.max_speed = b.speed
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.controller_basic_clone_darksteel_guardian.update
tt.render.sprites[1].prefix = "common_clone_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.vis.bans = F_ALL
tt.ui.can_click = false
tt.guardian_t = "enemy_darksteel_guardian"
tt = E:register_t_10086("enemy_darksteel_anvil", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.darksteel_anvil

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.info.enc_icon = 77
tt.info.portrait = "gui_bottom_info_image_enemies_0082"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 40)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_darksteel_anvil.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_times = {
	fts(14)
}
tt.melee.attacks[1].animation = "attack_2"
tt.melee.attacks[1].hit_offset = v(40, 15)
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = b.basic_ranged.cooldown
tt.ranged.attacks[1].max_range = b.basic_ranged.max_range
tt.ranged.attacks[1].min_range = b.basic_ranged.min_range
tt.ranged.attacks[1].bullet = "bullet_darksteel_anvil"
tt.ranged.attacks[1].bullet_start_offset = {
	v(20, 10),
	v(-20, 10)
}
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.ranged.attacks[1].shoot_times = {
	fts(12),
	fts(20)
}
tt.ranged.attacks[1].loops = 1
tt.ranged.attacks[1].animations = {
	"idle",
	"attack",
	"idle"
}
tt.timed_attacks.list[1] = E:clone_c("aura_attack")
tt.timed_attacks.list[1].animation_in = "skill_in"
tt.timed_attacks.list[1].animation_loop = "skill_loop"
tt.timed_attacks.list[1].animation_end = "skill_out"
tt.timed_attacks.list[1].cooldown = b.aura.cooldown
tt.timed_attacks.list[1].max_range = b.aura.trigger_range
tt.timed_attacks.list[1].min_targets = b.aura.min_targets
tt.timed_attacks.list[1].duration = b.aura.duration
tt.timed_attacks.list[1].nodes_limit_start = b.aura.nodes_limit_start
tt.timed_attacks.list[1].nodes_limit_end = b.aura.nodes_limit_end
tt.timed_attacks.list[1].aura = "aura_enemy_darksteel_anvil"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].sound = "EnemyDarksteelAnvilBeat"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "darksteel_anvil_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.sound_events.death = "EnemyDarksteelAnvilDeath"
tt.ui.click_rect = r(-20, -3, 40, 28)
tt.unit.hit_offset = v(0, 11)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 11)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.can_explode = false
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt = E:register_t_10086("enemy_darksteel_hulk", "enemy_KR5")

local b = balance.enemies.hammer_and_anvil.darksteel_hulk

E:add_comps(tt, "melee", "timed_attacks")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(37, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 57)
tt.info.enc_icon = 78
tt.info.portrait = "gui_bottom_info_image_enemies_0083"
tt.unit.hit_offset = v(0, 20)
tt.unit.head_offset = v(0, 0)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_darksteel_hulk.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].sound = "EnemyRazingRhinoBasicAttack"
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].cast_time = fts(21)
tt.timed_attacks.list[1].animation = "charge"
tt.timed_attacks.list[1].cooldown = b.charge.cooldown
tt.timed_attacks.list[1].speed_mult = b.charge.speed_mult
tt.timed_attacks.list[1].health_threshold = b.charge.health_threshold
tt.timed_attacks.list[1].min_distance_from_end = b.charge.min_distance_from_end
tt.timed_attacks.list[1].vis_flags = F_FRIEND
tt.timed_attacks.list[1].vis_bans = bor(F_HERO, F_FLYING)
tt.timed_attacks.list[1].vis_flags_enemies = F_RANGED
tt.timed_attacks.list[1].vis_bans_enemies = F_BOSS
tt.timed_attacks.list[1].vis_flags_soldiers = F_RANGED
tt.timed_attacks.list[1].vis_bans_soldiers = bor(F_BOSS, F_FLYING)
tt.timed_attacks.list[1].mod_enemy = "mod_enemy_darksteel_hulk_charge_enemy"
tt.timed_attacks.list[1].mod_soldier = "mod_enemy_darksteel_hulk_charge_soldier"
tt.timed_attacks.list[1].range = b.charge.range
tt.timed_attacks.list[1].particles_name_a = "ps_enemy_darksteel_hulk_charge_a"
tt.timed_attacks.list[1].particles_name_b = "ps_enemy_darksteel_hulk_charge_b"
tt.timed_attacks.list[1].sound = "EnemyDarksteelHulkCharge"
tt.timed_attacks.list[1].charge_while_blocked = b.charge.charge_while_blocked
tt.timed_attacks.list[1].damage_enemies = b.charge.damage_enemy_max > 0
tt.timed_attacks.list[1].damage_soldiers = b.charge.damage_soldier_max > 0
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "darksteel_hulk_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[1].angles.charge = {
	"charge_side",
	"charge_back",
	"charge_front"
}
tt.render.sprites[1].angles_custom = {
	charge = {
		55,
		115,
		245,
		305
	}
}
tt.ui.click_rect = r(-24, -3, 48, 46)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.unit.can_explode = false
tt.vis.flags = bor(F_ENEMY, F_MINIBOSS)
tt.sound_events.death = "EnemyDarksteelHulkDeath"
tt.base_speed = b.speed
tt = E:register_t_10086("enemy_machinist", "enemy_KR5")
b = balance.enemies.hammer_and_anvil.machinist

E:add_comps(tt, "melee", "regen")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(37, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 45)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.regen.cooldown = b.regen_cooldown
tt.regen.health = b.regen_health
tt.info.enc_icon = 80
tt.info.portrait = "gui_bottom_info_image_enemies_0085"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_machinist.update
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_offset = v(20, 12)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "dlc_dwarf_boss_operator_bossengineer"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk"
}
tt.ui.click_rect = r(-23, -3, 46, 40)
tt.unit.hit_offset = v(0, 22)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 19)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.unit.can_disintegrate = false
tt.vis.flags = bor(F_ENEMY, F_MINIBOSS)
tt.vis.bans = bor(F_TELEPORT)
tt.operation_pos = v(-1, 385)
tt.timeout = b.timeout
tt.op_cd = b.operation_cd
tt.op_needed = b.operations_needed
tt.sound_lever = {
	"Stage24MachinistLever1",
	"Stage24MachinistLever2",
	"Stage24MachinistLever3"
}
tt.sound_factory_on = "Stage24FactoryTurnOnStart"
tt = E:register_t_10086("enemy_deformed_grymbeard_clone", "enemy_KR5")

E:add_comps(tt)

local b = balance.enemies.hammer_and_anvil.deformed_grymbeard_clone

tt.info.enc_icon = 82
tt.info.portrait = "gui_bottom_info_image_enemies_0087"
tt.enemy.gold = b.gold
tt.enemy.lives_cost = b.lives_cost
tt.flight_height = 25
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, tt.flight_height + 45)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.health.armor = b.armor
tt.health.magic_armor = b.shield_magic_armor
tt.main_script.insert = scripts.enemy_deformed_grymbeard_clone.insert
tt.main_script.update = scripts.enemy_deformed_grymbeard_clone.update
tt.main_script.remove = scripts.enemy_deformed_grymbeard_clone.remove
tt.motion.max_speed = b.speed
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "clone_boss_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk",
	"walk_front"
}
tt.render.sprites[1].scale = vv(0.9)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "scrap_drone_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].scale = vv(0.9)
tt.sound_events.death = "EnemyPatrollingVultureDeath"
tt.ui.click_rect = r(-18, tt.flight_height - 5, 36, 45)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 15)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height + 15)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.unit.blood_color = BLOOD_GRAY
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.shield_hp_threshold = b.shield_hp_threshold
tt.no_shield_speed_factor = b.speed_factor
tt.shield_t = "fx_enemy_deformed_grymbeard_clone_shield"
tt = E:register_t_10086("enemy_spider_priest", "enemy_KR5")

local b = balance.enemies.arachnids.spider_priest

E:add_comps(tt, "melee", "ranged", "death_spawns")

tt.enemy.gold = b.gold
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.dead_lifetime = 5
tt.info.enc_icon = 86
tt.info.portrait = "gui_bottom_info_image_enemies_0091"
tt.main_script.insert = scripts.enemy_basic_with_random_range.insert
tt.main_script.update = scripts.enemy_spider_priest.update
tt.melee.attacks[1].animation = "hit"
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].hit_time = fts(12)
tt.ranged.attacks[1].animation = "spell"
tt.ranged.attacks[1].bullet = "bullet_enemy_spider_priest"
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].shoot_time = fts(25)
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].max_range_variance = 60
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 40)
}
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.motion.max_speed = b.speed
tt.health_trigger_factor = b.health_trigger_factor
tt.death_spawns.name = "enemy_glarenwarden"
tt.death_spawns.concurrent_with_death = false
tt.death_spawns.delay = fts(32)
tt.death_spawns.death_animation = "transformation"
tt.death_spawns.dead_lifetime = 0
tt.render.sprites[1].prefix = "cultist_spider_creep"
tt.render.sprites[1].angles.walk = {
	"side_walking",
	"walk_back",
	"walk_front"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.health_bar.offset = v(0, 39)
tt.unit.show_blood_pool = false
tt.unit.hit_offset = v(0, 16)
tt.unit.head_offset = v(0, 16)
tt.unit.mod_offset = v(0, 16)
tt.enemy.melee_slot = v(25, 0)
tt.transformation_nodes_limit = b.transformation_nodes_limit
tt.transformation_time = b.transformation_time
tt.transformation_anim = "transformation"
tt.transformation_sound = "EnemyUnblindedPriestTransformCast"
tt.transformation_end_sound = "EnemySpiderPriestTransform"
tt.sound_events.death = "EnemyUnblindedPriestDeath"
tt.ui.click_rect = r(-15, -3, 30, 32)
tt = E:register_t_10086("enemy_glarenwarden", "enemy_KR5")
b = balance.enemies.arachnids.glarenwarden

E:add_comps(tt, "melee", "cliff")

tt.enemy.gold = b.gold
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.info.enc_icon = 89
tt.info.portrait = "gui_bottom_info_image_enemies_0094"
tt.info.i18n_key = "ENEMY_GLARENWARDEN"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_glarenwarden.update
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].mod = "mod_enemy_glarenwarden_melee_lifesteal"
tt.melee.attacks[1].sound = "EnemyGlarenwardenMelee"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "glarenwarden_creep"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-20, -3, 40, 35)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 50)
tt.unit.show_blood_pool = false
tt.unit.hit_offset = v(0, 25)
tt.unit.head_offset = v(0, 25)
tt.unit.mod_offset = v(0, 19)
tt.unit.size = UNIT_SIZE_LARGE
tt.enemy.melee_slot = v(30, 0)
tt.cliff.fall_accel = 400
tt.sound_events.death = "EnemyGlarenwardenDeath"
tt = E:register_t_10086("enemy_ballooning_spider", "enemy_KR5")

E:add_comps(tt, "tween")

local b = balance.enemies.arachnids.ballooning_spider

tt.info.enc_icon = 85
tt.info.portrait = "gui_bottom_info_image_enemies_0090"
tt.enemy.gold = b.gold
tt.flight_height = 47
tt.fly_strenght = -10
tt.fly_frequency = 25
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, 23)
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_ballooning_spider.update
tt.motion.max_speed = b.speed
tt.base_speed = b.speed
tt.render.sprites[1].prefix = "balooning_spider_exo_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[1].angles.takeoff = {
	"takeoff",
	"takeoff_up",
	"takeoff_down"
}
tt.render.sprites[1].angles_stickiness = {
	takeoff = 15,
	walk = 15
}
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].scale = vv(0.9)
tt.render.sprites[2].hidden = true
tt.ui.click_rect = r(-15, -5, 30, 30)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 7)
tt.unit.head_offset = v(0, 7)
tt.unit.mod_offset = v(0, 7)
tt.unit.marker_offset = v(0, 0)
tt.vis.bans = bor(F_BLOCK)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.sound_events.death = "EnemySpiderlingDeath"
tt.detection_range = b.detection_range
tt.detection_flags = bor(F_FRIEND, F_BLOCK)
tt.detection_bans = bor(F_FLYING)
tt.takeoff = {}
tt.takeoff.health_bar_offset_mid = v(0, tt.flight_height + 20)
tt.takeoff.health_bar_offset = v(0, tt.flight_height + 75)
tt.takeoff.sprite_offset = v(0, tt.flight_height)
tt.takeoff.ui_click_rect = r(-15, tt.flight_height + 15, 30, 30)
tt.takeoff.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.takeoff.hit_offset = v(0, tt.flight_height + 20)
tt.takeoff.mod_offset = v(0, tt.flight_height + 20)
tt.takeoff.max_speed = b.speed_air
tt.takeoff.anims_prefix = "balooning_spider_exo_creep_air"
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[1].keys = {
	{
		fts(0),
		v(0, tt.flight_height)
	},
	{
		fts(tt.fly_frequency),
		v(0, tt.flight_height - tt.fly_strenght)
	},
	{
		fts(tt.fly_frequency * 2),
		v(0, tt.flight_height)
	}
}
tt.tween.props[1].loop = true
tt.tween.props[1].disabled = false
tt.tween.props[1].remove = false
tt = E:register_t_10086("enemy_ballooning_spider_flyer", "enemy_ballooning_spider")
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt = E:register_t_10086("enemy_spider_sister", "enemy_KR5")

local b = balance.enemies.arachnids.spider_sister

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(15, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 3
tt.health_bar.offset = v(0, 38)
tt.unit.hit_offset = v(0, 21)
tt.unit.head_offset = v(0, 21)
tt.unit.mod_offset = v(0, 13)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-20, -3, 40, 35)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "spider_sister_enemy"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.sound_events.death = "EnemyTwistedSisterDeath"
tt.info.i18n_key = "ENEMY_SPIDER_SISTER"
tt.info.enc_icon = 87
tt.info.portrait = "gui_bottom_info_image_enemies_0092"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_spider_sister.update
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].animation = "attack_1"
tt.melee.attacks[1].hit_time = fts(18)
tt.ranged.attacks[1].bullet = "spider_sister_bolt"
tt.ranged.attacks[1].bullet_start_offset = {
	v(20, 13)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "attack_1"
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].hold_advance = true
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "ability_1"
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].cooldown = b.spiderlings_summon.cooldown
tt.timed_attacks.list[1].cooldown_init = b.spiderlings_summon.cooldown_init
tt.timed_attacks.list[1].cooldown_increment = b.spiderlings_summon.cooldown_increment
tt.timed_attacks.list[1].cooldown_max = b.spiderlings_summon.cooldown_max
tt.timed_attacks.list[1].range = b.spiderlings_summon.max_range
tt.timed_attacks.list[1].max_targets = 1
tt.timed_attacks.list[1].entity = "enemy_glarebrood_crystal"
tt.timed_attacks.list[1].spawn_delay = 0
tt.timed_attacks.list[1].sound = "EnemySpiderSisterSpawn"
tt.timed_attacks.list[1].count_group_name = "enemy_spiderling"
tt.timed_attacks.list[1].count_group_type = COUNT_GROUP_CONCURRENT
tt.timed_attacks.list[1].count_group_max = b.spiderlings_summon.max_total
tt.nodes_limit = b.spiderlings_summon.nodes_limit
tt.node_random_min = b.spiderlings_summon.nodes_random_min
tt.node_random_max = b.spiderlings_summon.nodes_random_max
tt = E:register_t_10086("enemy_glarebrood_crystal", "enemy_KR5")
b = balance.enemies.arachnids.glarebrood_crystal

E:add_comps(tt, "death_spawns")

tt.enemy.gold = b.gold
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.info.enc_icon = 9
tt.info.portrait = "gui_bottom_info_image_enemies_0093"
tt.info.i18n_key = "ENEMY_GLAREBROOD_CRYSTAL"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_glarebrood_crystal.update
tt.render.sprites[1].prefix = "glarebrood_crystal_enemy"
tt.render.sprites[1].anchor = v(0.5, 0.5364583333333334)
tt.ui.click_rect = r(-20, -3, 40, 30)
tt.health_bar.offset = v(0, 25)
tt.unit.show_blood_pool = false
tt.unit.hit_offset = v(0, 10)
tt.unit.head_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.enemy.melee_slot = v(18, 0)
tt.unit.size = UNIT_SIZE_SMALL
tt.death_spawns.name = "enemy_spiderling_from_crystal"
tt.death_spawns.concurrent_with_death = false
tt.death_spawns.death_animation = "glarebrood_in"
tt.death_spawns.dead_lifetime = 0
tt.transform_anim = "glarebrood_in"
tt.transform_time = b.transformation_time
tt.sound_events.death = "EnemySpiderlingDeath"
tt.hp_threshold_1 = {
	0.66,
	"degradacion_1"
}
tt.hp_threshold_2 = {
	0.33,
	"degradacion_2"
}
tt = E:register_t_10086("enemy_spiderling_from_crystal", "enemy_spiderling")
b = balance.enemies.arachnids.glarebrood_crystal.spiderling_spawn
tt.enemy.gold = b.gold
tt.info.portrait = "gui_bottom_info_image_enemies_0089"
tt = E:register_t_10086("enemy_cultbrood", "enemy")
b = balance.enemies.arachnids.cultbrood

E:add_comps(tt, "melee")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 3
tt.health_bar.offset = v(0, 55)
tt.unit.hit_offset = v(0, 23)
tt.unit.head_offset = v(0, 26)
tt.unit.mod_offset = v(0, 25)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-20, -3, 40, 35)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_CULTBROOD"
tt.info.enc_icon = 90
tt.info.portrait = "gui_bottom_info_image_enemies_0095"
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "cultbrood_unit"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.ui.click_rect = r(-20, 0, 40, 45)
tt.unit.show_blood_pool = false
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_cultbrood.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack1"
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].sound = "EnemyCultbroodMelee"
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].cooldown = b.poison_attack.cooldown
tt.melee.attacks[2].cooldown_init = b.poison_attack.cooldown_init
tt.melee.attacks[2].damage_max = b.poison_attack.damage_max
tt.melee.attacks[2].damage_min = b.poison_attack.damage_min
tt.melee.attacks[2].damage_type = b.poison_attack.damage_type
tt.melee.attacks[2].hit_time = fts(14)
tt.melee.attacks[2].mod = "mod_cultbrood_poison"
tt.melee.attacks[2].sound = "EnemyCultbroodMelee"
tt.generation = 0
tt.spawn_time = b.spawn_time
tt.sound_events.death = "EnemyCultbroodDeath"
tt = E:register_t_10086("enemy_drainbrood", "enemy")
b = balance.enemies.arachnids.drainbrood

E:add_comps(tt, "melee", "timed_attacks")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 3
tt.health_bar.offset = v(0, 40)
tt.unit.hit_offset = v(0, 23)
tt.unit.head_offset = v(0, 23)
tt.unit.mod_offset = v(0, 21)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-20, -3, 40, 33)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_GREEN
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_DRAINBROOD"
tt.info.enc_icon = 91
tt.info.portrait = "gui_bottom_info_image_enemies_0096"
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "drainblood_enemy"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.unit.show_blood_pool = false
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_drainbrood.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound = "EnemyDrainbroodMelee"
tt.timed_attacks.list[1] = E:clone_c("mod_attack")
tt.timed_attacks.list[1].animation = "attack_spit"
tt.timed_attacks.list[1].cast_time = fts(11)
tt.timed_attacks.list[1].drain_time = fts(13)
tt.timed_attacks.list[1].cooldown = b.webspit.cooldown
tt.timed_attacks.list[1].mod = "mod_drainbrood_web"
tt.timed_attacks.list[1].damage_max = b.webspit.damage_max
tt.timed_attacks.list[1].damage_min = b.webspit.damage_min
tt.timed_attacks.list[1].damage_type = b.webspit.damage_type
tt.timed_attacks.list[1].heal_hp_damage_factor = b.webspit.lifesteal.damage_factor
tt.timed_attacks.list[1].heal_hp_fixed = b.webspit.lifesteal.fixed_heal
tt.timed_attacks.list[1].vis_flags = bor(F_NET, F_STUN)
tt.timed_attacks.list[1].vis_bans = bor(F_HERO)
tt = E:register_t_10086("enemy_spidead", "enemy")
b = balance.enemies.arachnids.spidead

E:add_comps(tt, "melee", "death_spawns")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 3
tt.health_bar.offset = v(0, 40)
tt.unit.hit_offset = v(0, 23)
tt.unit.head_offset = v(0, 23)
tt.unit.mod_offset = v(0, 21)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-20, -3, 40, 33)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_GREEN
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_SPIDEAD"
tt.info.enc_icon = 93
tt.info.portrait = "gui_bottom_info_image_enemies_0098"
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "spider_web_enemy"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.unit.show_blood_pool = false
tt.unit.hide_during_death = true
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_spidead.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound = "EnemyDrainbroodMelee"
tt.death_spawns.name = "decal_spidead_spiderweb"
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.delay = fts(30)
tt.nodes_to_prevent_web = b.nodes_to_prevent_web
tt = E:register_t_10086("decal_spidead_spiderweb", "decal_tween")
b = balance.enemies.arachnids.spidead.spiderweb

E:add_comps(tt, "auras", "main_script")

tt.main_script.insert = scripts.decal_spidead_spiderweb.insert
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_spider_webs_slowness"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E:clone_c("aura_attack")
tt.auras.list[2].name = "aura_spider_webs_sprint"
tt.auras.list[2].cooldown = 0
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].name = "spider_queen_boss_effects_web_decal"
tt.render.sprites[1].animated = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.3,
		255
	},
	{
		b.duration - 0.8,
		255
	},
	{
		b.duration,
		0
	}
}
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		vv(0.8)
	},
	{
		0.3,
		vv(1.1)
	},
	{
		0.4,
		vv(1)
	}
}
tt.tween.disabled = false
tt.tween.remove = true
tt = E:register_t_10086("boss_spider_queen", "boss")
b = balance.enemies.arachnids.boss_spider_queen

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.vis.flags_jumping = bor(F_ENEMY, F_BOSS)
tt.vis.bans_jumping = bor(F_RANGED, F_BLOCK, F_MOD)
tt.vis.flags_normal = bor(F_ENEMY, F_BOSS)
tt.vis.bans_normal = 0
tt.reach_nodes = b.reach_nodes
tt.jump_paths = b.jump_paths
tt.jump_nodes = b.jump_nodes
tt.enemy.gold = b.gold
tt.enemy.lives_cost = 999
tt.enemy.melee_slot = v(45, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 1e+99
tt.health_bar.offset = v(0, 110)
tt.unit.hit_offset = v(0, 53)
tt.unit.head_offset = v(0, 53)
tt.unit.mod_offset = v(0, 51)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-27, 25, 54, 45)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_GREEN
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_BOSS_SPIDER_QUEEN"
tt.info.enc_icon = 92
tt.info.portrait = "gui_bottom_info_image_enemies_0097"
tt.info.portrait_boss = "boss_health_bar_icon_0010"
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].exo = true
tt.render.sprites[1].prefix = "spider_queen_animationsDef"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk_side",
	"walk_up",
	"walk_down"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "boss_effects_circle_drain"
tt.render.sprites[2].name = "loop"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].hidden = true
tt.render.sprites[2].scale = vv(2.4)
tt.unit.show_blood_pool = false
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.boss_spider_queen.update
tt.melee.attacks[1] = E:clone_c("area_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].animation = "attack_melee"
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].hit_fx = "fx_boss_spider_queen_melee_hit"
tt.melee.attacks[1].hit_fx_offset = v(55, 10)
tt.melee.attacks[1].hit_decal = "fx_boss_spider_queen_melee_hit_decal"
tt.ranged.attacks[1].bullet = "boss_queen_spider_bolt"
tt.ranged.attacks[1].bullet_start_offset = {
	v(23, 125)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "attack_range_1"
tt.ranged.attacks[1].shoot_time = fts(35)
tt.ranged.attacks[1].hold_advance = false
tt.timed_attacks.list[1] = E:clone_c("mod_attack")
tt.timed_attacks.list[1].animation_start = "attack_tower"
tt.timed_attacks.list[1].animation_end = "call"
tt.timed_attacks.list[1].cooldown = b.stun_towers.cooldown
tt.timed_attacks.list[1].nodes_limit = b.stun_towers.nodes_limit
tt.timed_attacks.list[1].min_targets = b.stun_towers.min_targets
tt.timed_attacks.list[1].max_targets = b.stun_towers.max_targets
tt.timed_attacks.list[1].max_range = b.stun_towers.max_range
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].bullet = "bullet_boss_spider_queen_tower_stun"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(5, 100)
}
tt.timed_attacks.list[1].shoot_time = fts(41)
tt.timed_attacks.list[1].vis_flags = bor(F_STUN)
tt.timed_attacks.list[2] = E:clone_c("custom_attack")
tt.timed_attacks.list[2].animation = "attack_screen"
tt.timed_attacks.list[2].cast_time = fts(41)
tt.timed_attacks.list[2].cooldown = b.webspit.cooldown
tt.timed_attacks.list[2].first_cooldown = b.webspit.first_cooldown
tt.timed_attacks.list[2].nodes_limit = b.webspit.nodes_limit
tt.timed_attacks.list[2].decal = "decal_boss_spider_queen_webspit_screen"
tt.timed_attacks.list[3] = E:clone_c("area_attack")
tt.timed_attacks.list[3].min_targets = b.drain_life.min_targets
tt.timed_attacks.list[3].max_targets = b.drain_life.max_targets
tt.timed_attacks.list[3].min_range = 0
tt.timed_attacks.list[3].max_range = b.drain_life.max_range
tt.timed_attacks.list[3].drain_center_offset = v(5, 85)
tt.timed_attacks.list[3].animation_start = "heal_in"
tt.timed_attacks.list[3].animation_loop = "heal_loop"
tt.timed_attacks.list[3].animation_end_success = "heal_out_1"
tt.timed_attacks.list[3].animation_end_fail = "heal_out_2"
tt.timed_attacks.list[3].loop_duration = b.drain_life.loop_duration
tt.timed_attacks.list[3].cooldown = b.drain_life.cooldown
tt.timed_attacks.list[3].cooldown_init = b.drain_life.cooldown_init
tt.timed_attacks.list[3].nodes_limit = b.drain_life.nodes_limit
tt.timed_attacks.list[3].bullet = "bullet_boss_spider_queen_lifesteal"
tt.timed_attacks.list[3].fx_end_units = "fx_boss_spider_queen_lifesteal_bleeding"
tt.timed_attacks.list[3].mod_end = "mod_boss_spider_queen_area_lifesteal_end"
tt.timed_attacks.list[3].mod_loop = "mod_boss_spider_queen_area_lifesteal_loop"
tt.timed_attacks.list[3].mod_loop_every = b.drain_life.lifesteal_loop.damage_every
tt.timed_attacks.list[3].vis_bans = 0
tt.timed_attacks.list[3].damage_bans = 0
tt.timed_attacks.list[4] = E:clone_c("custom_attack")
tt.timed_attacks.list[4].animation = "spawn_units"
tt.timed_attacks.list[4].cast_time = fts(14)
tt.timed_attacks.list[4].amount = b.call_wardens.amount
tt.timed_attacks.list[4].nodes_spread_start = b.call_wardens.nodes_spread_start
tt.timed_attacks.list[4].nodes_offset = b.call_wardens.nodes_offset
tt.timed_attacks.list[4].nodes_spread = b.call_wardens.nodes_spread
tt.timed_attacks.list[4].cooldown = b.call_wardens.cooldown
tt.timed_attacks.list[4].nodes_limit = b.call_wardens.nodes_limit
tt.timed_attacks.list[4].nodes_limit_reverse = b.call_wardens.nodes_limit_reverse
tt.timed_attacks.list[4].first_cooldown = b.call_wardens.first_cooldown
tt.timed_attacks.list[4].object = "decal_boss_spider_queen_spawns"
tt.timed_attacks.list[4].use_custom_formation = b.call_wardens.use_custom_formation
tt.timed_attacks.list[4].custom_formation = b.call_wardens.custom_formation
tt.sound_death = "Stage30BossfightDead"
tt = E:register_t_10086("decal_boss_spider_queen_flying", "decal")
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "asst_spider_queen_jump"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[1].anchor = v(0.5, 0.1)
tt = E:register_t_10086("tower_sparking_geode_ray_lvl1", "bullet")
b = balance.towers.sparking_geode
tt.bullet.level = 1
tt.bullet.damage_type = b.basic_attack.damage_type
tt.bullet.damage_min = b.basic_attack.damage_min[tt.bullet.level]
tt.bullet.damage_max = b.basic_attack.damage_max[tt.bullet.level]
tt.bullet.hit_time = fts(3)
tt.bullet.hit_fx = "fx_tower_sparking_geode_hit"
tt.image_width = 174
tt.main_script.update = scripts.tower_sparking_geode_ray.update
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "sparking_geode_ray_run"
tt.render.sprites[1].loop = false
tt.track_target = false
tt.ray_duration = fts(16)
tt.bounces_min = b.basic_attack.bounces_min[tt.bullet.level]
tt.bounces_max = b.basic_attack.bounces_max[tt.bullet.level]
tt.bounce_range = b.basic_attack.bounce_range
tt.bounce_vis_flags = F_RANGED
tt.bounce_vis_bans = 0
tt.bounce_damage_factor = b.basic_attack.bounce_damage_factor[1]
tt.bounce_delay = fts(2)
tt.bounce_scale_y = 1
tt.bounce_scale_y_factor = 0.92
tt.seen_targets = {}
tt.bounce_sprite_name = "sparking_geode_ray_rebote_run"
tt.bounce_ray_duration = fts(12)
tt.bounce_image_width = 76.56
tt.sound_events.insert = "TowerSparkingGeodeRay"
tt = E:register_t_10086("tower_sparking_geode_ray_lvl2", "tower_sparking_geode_ray_lvl1")
b = balance.towers.sparking_geode
tt.bullet.level = 2
tt.bounces_min = b.basic_attack.bounces_min[tt.bullet.level]
tt.bounces_max = b.basic_attack.bounces_max[tt.bullet.level]
tt.bounce_damage_factor = b.basic_attack.bounce_damage_factor[2]
tt.bullet.damage_min = b.basic_attack.damage_min[tt.bullet.level]
tt.bullet.damage_max = b.basic_attack.damage_max[tt.bullet.level]
tt = E:register_t_10086("tower_sparking_geode_ray_lvl3", "tower_sparking_geode_ray_lvl1")
b = balance.towers.sparking_geode
tt.bullet.level = 3
tt.bounces_min = b.basic_attack.bounces_min[tt.bullet.level]
tt.bounces_max = b.basic_attack.bounces_max[tt.bullet.level]
tt.bounce_damage_factor = b.basic_attack.bounce_damage_factor[3]
tt.bullet.damage_min = b.basic_attack.damage_min[tt.bullet.level]
tt.bullet.damage_max = b.basic_attack.damage_max[tt.bullet.level]
tt = E:register_t_10086("tower_sparking_geode_ray_lvl4", "tower_sparking_geode_ray_lvl1")
b = balance.towers.sparking_geode
tt.bullet.level = 4
tt.bounces_min = b.basic_attack.bounces_min[tt.bullet.level]
tt.bounces_max = b.basic_attack.bounces_max[tt.bullet.level]
tt.bounce_damage_factor = b.basic_attack.bounce_damage_factor[4]
tt.bullet.damage_min = b.basic_attack.damage_min[tt.bullet.level]
tt.bullet.damage_max = b.basic_attack.damage_max[tt.bullet.level]
tt = E:register_t_10086("bullet_enemy_spider_priest", "bolt_enemy")
b = balance.enemies.arachnids.spider_priest
tt.render.sprites[1].prefix = "cultist_spider_projectile"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.bullet.damage_max = b.ranged_attack.damage_max
tt.bullet.damage_min = b.ranged_attack.damage_min
tt.bullet.damage_type = b.ranged_attack.damage_type
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 30
tt.bullet.max_speed = 300
tt.bullet.align_with_trajectory = true
tt.bullet.hit_fx = "fx_bullet_enemy_spider_priest_hit"
tt.bullet.particles_name = "ps_bullet_enemy_spider_priest"
tt = E:register_t_10086("spider_sister_bolt", "bolt_enemy")

local b = balance.enemies.arachnids.spider_sister

tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.render.sprites[1].prefix = "spider_sister_fx_attack_1_projectile"
tt.bullet.hit_fx = "spider_sister_bolt_hit_fx"
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.acceleration_factor = 0.5
tt.bullet.damage_min = b.ranged_attack.damage_min
tt.bullet.damage_max = b.ranged_attack.damage_max
tt.bullet.max_speed = 360
tt.bullet.particles_name = "ps_spider_sister_bolt_trail"
tt.bullet.damage_type = b.ranged_attack.damage_type
tt.sound_events.insert = "EnemySpiderSisterRange"
tt = E:register_t_10086("boss_queen_spider_bolt", "bolt_enemy")

local b = balance.enemies.arachnids.boss_spider_queen

tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "boss_effects_bolt_magic"
tt.render.sprites[1].name = "flying"
tt.render.sprites[1].anchor = vv(0.5)
tt.bullet.hit_fx = "fx_boss_spider_queen_bolt_hit"
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.acceleration_factor = 0.5
tt.bullet.damage_min = b.ranged_attack.damage_min
tt.bullet.damage_max = b.ranged_attack.damage_max
tt.bullet.max_speed = 360
tt.bullet.particles_name = "ps_boss_spider_queen_bolt_trail"
tt.bullet.damage_type = b.ranged_attack.damage_type
tt.bullet.mod = "mod_boss_spider_queen_poison"
tt.sound_events.insert = "Stage30BossfightRange"
tt = E:register_t_10086("mod_boss_spider_queen_tower_debuff", "modifier")
b = balance.enemies.arachnids.boss_spider_queen.stun_towers

E:add_comps(tt, "render", "ui")

if IS_CONSOLE then
	E:add_comps(tt, "tween")
end

tt.main_script.insert = scripts.mod_boss_spider_queen_tower_debuff.insert
tt.main_script.update = scripts.mod_boss_spider_queen_tower_debuff.update
tt.modifier.duration = b.duration
tt.modifier.duration_long = b.duration_long
tt.render.sid_mask = 1
tt.render.sprites[tt.render.sid_mask].prefix = "spider_queen_animations_stunDef"
tt.render.sprites[tt.render.sid_mask].name = "in"
tt.render.sprites[tt.render.sid_mask].exo = true
tt.render.sprites[tt.render.sid_mask].animated = true
tt.render.sprites[tt.render.sid_mask].loop = false
tt.render.sprites[tt.render.sid_mask].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_mask].offset = v(0, -30)
tt.render.sprites[tt.render.sid_mask].sort_y_offset = -5
tt.threads_separation = 38
tt.threads_amount = math.ceil(REF_H / tt.threads_separation)
tt.threads_idles = {
	"idle1",
	"idle1",
	"idle2",
	"idle3",
	"idle4",
	"idle4"
}
tt.render.sid_threads_start = 2
tt.render.sid_threads_end = tt.render.sid_threads_start + tt.threads_amount * 3 - 1
tt.spiders_offsets = {
	{
		x = -17,
		y = 0
	},
	{
		x = 0,
		y = 30
	},
	{
		x = 17,
		y = -10
	}
}

for i1 = 1, 3 do
	for i2 = 1, tt.threads_amount do
		local s = E:clone_c("sprite")

		s.prefix = "glarewarden_web_spiderweb"
		s.name = tt.threads_idles[1]
		s.loop = false
		s.anchor.y = 0
		s.offset.x = tt.spiders_offsets[i1].x
		s.offset.y = (i2 - 1) * tt.threads_separation + tt.spiders_offsets[i1].y
		s.z = Z_OBJECTS
		s.sort_y_offset = -s.offset.y
		s.group = "threads"
		tt.render.sprites[tt.render.sid_threads_start + tt.threads_amount * (i1 - 1) + i2 - 1] = s
	end
end

tt.render.sid_spiders_start = tt.render.sid_threads_end + 1
tt.render.sid_spiders_end = tt.render.sid_spiders_start + 2

for i = tt.render.sid_spiders_start, tt.render.sid_spiders_end do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].prefix = "boss_spider_minispider_tower_stun_spider"
	tt.render.sprites[i].name = "climbDown"
	tt.render.sprites[i].offset = v(tt.spiders_offsets[i - tt.render.sid_spiders_start + 1].x, tt.spiders_offsets[i - tt.render.sid_spiders_start + 1].y + 30)
	tt.render.sprites[i].group = "spiders"
end

tt.render.sid_hand = tt.render.sid_spiders_end + 1
tt.render.sprites[tt.render.sid_hand] = CC("sprite")
tt.render.sprites[tt.render.sid_hand].name = "spider_queen_tap"
tt.render.sprites[tt.render.sid_hand].offset = v(10, 20)
tt.render.sprites[tt.render.sid_hand].draw_order = 11
tt.render.sprites[tt.render.sid_hand].hidden = true
tt.render.sprites[tt.render.sid_hand].z = Z_OBJECTS_COVERS
tt.required_clicks = IS_PHONE_OR_TABLET and b.required_clics_phone_tablet or IS_CONSOLE and b.required_clics_console or b.required_clics_desktop
tt.tap_fx = "fx_boss_spider_queen_melee_hit"
tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.click_rect = r(-40, 0, 80, 60)
tt.ui.z = 1
tt.tower_type_scales = {}
tt.tower_type_offsets = {}
tt = E:register_t_10086("bullet_enemy_rolling_sentry", "bullet")
b = balance.enemies.hammer_and_anvil.rolling_sentry
tt.render = nil
tt.main_script.insert = scripts.invisible_bullet.insert
tt.main_script.update = scripts.invisible_bullet.update
tt.bullet.asymmetrical = true
tt.bullet.damage_min = b.ranged_attack.damage_min
tt.bullet.damage_max = b.ranged_attack.damage_max
tt.bullet.damage_type = b.ranged_attack.damage_type
tt.bullet.hit_fx = "fx_bullet_enemy_rolling_sentry"
tt = E:register_t_10086("bullet_enemy_brute_welder_death", "bullet")
b = balance.enemies.hammer_and_anvil.brute_welder

E:add_comps(tt, "force_motion")

tt.bullet.flight_time = fts(31)
tt.bullet.particles_name = "ps_bullet_enemy_brute_welder_death_trail"
tt.bullet.hit_fx = "fx_bullet_enemy_brute_welder_death_hit"
tt.bullet.align_with_trajectory = true
tt.bullet.ignore_hit_offset = true
tt.bullet.mod = "mod_bullet_enemy_brute_welder_death_stun"
tt.render.sprites[1].name = "brute_welder_tank_projectile"
tt.render.sprites[1].animated = false
tt.main_script.update = scripts.bullet_enemy_brute_welder_death.update
tt.initial_impulse = 3000
tt.initial_impulse_duration = 0.3
tt.initial_impulse_angle = 0
tt.force_motion.a_step = 5
tt.force_motion.max_a = 1800
tt.force_motion.max_v = 450
tt.sound_events.hit = "EnemyBruteWelderDeathImpact"
tt.mark_mod = "mod_bullet_enemy_brute_welder_death_mark"
tt.range = b.death_missile.range
tt = E:register_t_10086("bullet_enemy_darksteel_guardian_death", "bombKR5")
b = balance.enemies.hammer_and_anvil.brute_welder

E:add_comps(tt, "force_motion")

tt.bullet.flight_time = fts(31)
tt.bullet.particles_name = "ps_bullet_enemy_darksteel_guardian_death_trail"
tt.bullet.ignore_hit_offset = true
tt.bullet.rotation_speed = 10 * FPS * math.pi / 180
tt.bullet.hit_decal = "decal_bullet_enemy_darksteel_guardian_death_clone"
tt.bullet.hit_fx = nil
tt.bullet.pop_chance = 0
tt.render.sprites[1].name = "darksteel_guardian_dwarf_projectile"
tt.render.sprites[1].animated = false
tt.initial_impulse = 3000
tt.initial_impulse_duration = 0.3
tt.initial_impulse_angle = 0
tt.force_motion.a_step = 5
tt.force_motion.max_a = 1800
tt.force_motion.max_v = 450
tt.sound_events.insert = "TowerRocketGunnersStingMissileCast"
tt.sound_events.hit = "TowerRocketGunnersStingMissileExplosion"
tt.range = b.death_missile.range
tt = E:register_t_10086("bullet_boss_machinist", "bombKR5")
b = balance.enemies.hammer_and_anvil.boss_machinist.ranged_attack
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.damage_radius
tt.bullet.damage_type = b.damage_type
tt.bullet.flight_time = fts(30)
tt.bullet.hit_fx = "fx_bullet_boss_machinist"
tt.bullet.pop_chance = 0.5
tt.bullet.particles_name = "ps_bullet_boss_machinist"
tt.bullet.hit_payload = "decal_scrap"
tt.sound_events.hit_water = nil
tt.sound_events.hit = "TowerTricannonBasicAttackImpact"
tt.render.sprites[1].name = "dlc_dwarf_boss_operator_proy"
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = false
tt.sound_events.insert = "Stage24BFMachinistCannonCastShot"
tt.sound_events.hit = "Stage24BFMachinistCannonImpact"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt = E:register_t_10086("bullet_stage_25_torso_missile", "bullet")
b = balance.enemies.hammer_and_anvil.brute_welder

E:add_comps(tt, "force_motion")

tt.bullet.flight_time = fts(31)
tt.bullet.particles_name = "ps_bullet_stage_25_torso_missile"
tt.bullet.hit_fx = "fx_bullet_stage_25_torso_missile_hit"
tt.bullet.align_with_trajectory = true
tt.bullet.ignore_hit_offset = true
tt.bullet.mod = "mod_stage_25_torso_missile_stun"
tt.render.sprites[1].name = "DLC_stage_03_missile_projectile"
tt.render.sprites[1].animated = false
tt.main_script.update = scripts.bullet_stage_25_torso_missile.update
tt.force_motion.a_step = 5
tt.force_motion.max_a = 2250
tt.force_motion.max_v = 750
tt.sound_events.hit = "Stage25MissileImpact"
tt.mark_mod = "mod_stage_25_torso_missile_mark"
tt.relative_to_source = false
tt.flight_positions = {
	v(749, 608),
	v(737, 635),
	v(707, 673),
	v(673, 695),
	v(615, 707),
	v(547, 701),
	v(472, 661),
	v(431, 627),
	v(390, 580),
	v(377, 510),
	v(437, 401),
	v(553, 412),
	v(573, 524),
	v(459, 595),
	v(389, 522)
}
tt = E:register_t_10086("bullet_stage_27_clone_dead", "bombKR5")
tt.bullet.flight_time = fts(35)
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = "decal_stage_27_clone_dead"
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_radius = 0
tt.bullet.rotation_speed = 10 * FPS * math.pi / 180
tt.bullet.pop_chance = 0
tt.render.sprites[1].name = "cannonLAYERS_flyclone"
tt.render.sprites[1].animated = false
tt = E:register_t_10086("bullet_stage_27_clone_alive", "bullet_stage_27_clone_dead")
tt.bullet.hit_decal = "decal_stage_27_clone_alive"
tt.bullet.hit_payload = "controller_spawn_enemy_common_clone"
tt = E:register_t_10086("controller_spawn_enemy_common_clone")

E:add_comps(tt, "main_script", "pos")

tt.main_script.update = scripts.controller_spawn_enemy_common_clone.update
tt.spawn_t = "enemy_common_clone"
tt.spawn_delay = fts(32)
tt = E:register_t_10086("bullet_stage_27_scrap", "bombKR5")
b = balance.specials.stage27_head.scrap_attack
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.damage_radius
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_bans = bor(F_ENEMY)
tt.bullet.flight_time = fts(60)
tt.bullet.hit_fx = "fx_bullet_stage_27_scrap"
tt.bullet.particles_name = "ps_bullet_stage_27_scrap"
tt.bullet.hit_payload = "decal_scrap"
tt.sound_events.hit_water = nil
tt.sound_events.hit = "TowerTricannonBasicAttackImpact"
tt.render.sprites[1].name = "dclenanos_stage05_ScrapProjectile_asst_scrap"
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = false
tt.sound_events.insert = "TowerBallistaScrapBombCast"
tt.sound_events.hit = "TowerBallistaScrapBombExplosion"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt = E:register_t_10086("bullet_stage_27_tower_stun", "bombKR5")
b = balance.specials.stage27_head
tt.bullet.flight_time = fts(60)
tt.bullet.particles_name = "ps_bullet_stage_27_tower_stun"
tt.bullet.hit_fx = "fx_bullet_stage_27_tower_stun"
tt.bullet.ignore_hit_offset = true
tt.bullet.mod = "mod_bullet_stage_27_tower_stun"
tt.bullet.align_with_trajectory = true
tt.render.sprites[1].name = "boss_fx_scrap_projectile"
tt.render.sprites[1].animated = false
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.bullet_stage_27_tower_stun.update
tt.sound_events.insert = "TowerRocketGunnersStingMissileCast"
tt.sound_events.hit = "TowerRocketGunnersStingMissileExplosion"
tt = E:register_t_10086("bullet_boss_grymbeard", "bullet")
b = balance.enemies.hammer_and_anvil.boss_grymbeard.ranged_attack

E:add_comps(tt, "force_motion")

tt.bullet.flight_time = fts(31)
tt.bullet.particles_name = "ps_bullet_boss_grymbeard_trail"
tt.bullet.hit_fx = "fx_bullet_boss_grymbeard_hit"
tt.bullet.hit_decal = "decal_bullet_boss_grymbeard"
tt.bullet.align_with_trajectory = true
tt.bullet.ignore_hit_offset = true
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.damage_radius
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "grymbeardbossLAYERS_missile"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].loop = true
tt.main_script.update = scripts.bullet_boss_grymbeard.update
tt.initial_impulse = 3000
tt.initial_impulse_duration = 0.3
tt.initial_impulse_angle = 0
tt.force_motion.a_step = 5
tt.force_motion.max_a = 1800
tt.force_motion.max_v = 450
tt.sound_events.insert = "Stage27BFGrymbeardRangedAttackCast"
tt.sound_events.hit = "Stage27BFGrymbeardRangedAttackImpact"
tt = E:register_t_10086("bullet_boss_grymbeard_death_clone", "bullet_stage_27_clone_dead")
tt.bullet.flight_time = fts(32)
tt.bullet.hit_decal = "decal_bullet_boss_grymbeard_death_clone"
tt = E:register_t_10086("bullet_boss_grymbeard_death_boss", "bullet_stage_27_clone_dead")
tt.bullet.flight_time = fts(40)
tt.bullet.hit_decal = "decal_bullet_boss_grymbeard_death_boss"
tt.bullet.align_with_trajectory = true
tt.bullet.particles_name = "ps_bullet_boss_grymbeard_death_boss_trail"
tt.render.sprites[1].prefix = "grymbeardbossLAYERS_flyboss"
tt.render.sprites[1].name = "fly"
tt.render.sprites[1].animated = true
tt = E:register_t_10086("bullet_boss_grymbeard_death_scrap_1", "bullet_stage_27_clone_dead")
tt.bullet.hit_decal = "decal_bullet_boss_grymbeard_death_scrap_1"
tt.render.sprites[1].name = "dclenanos_stage05_grymdebree1_Asst_grymbeardebree1"
tt.render.sprites[1].animated = false
tt = E:register_t_10086("bullet_boss_grymbeard_death_scrap_2", "bullet_boss_grymbeard_death_scrap_1")
tt.bullet.hit_decal = "decal_bullet_boss_grymbeard_death_scrap_2"
tt.render.sprites[1].name = "dclenanos_stage05_grymdebree2_asst_grym3_grymbearddebree2"
tt = E:register_t_10086("bullet_darksteel_anvil", "arrow5_fixed_height")
b = balance.enemies.hammer_and_anvil.darksteel_anvil
tt.bullet.flight_time = fts(8)
tt.bullet.damage_min = b.basic_ranged.damage_min
tt.bullet.damage_max = b.basic_ranged.damage_max
tt.bullet.damage_type = b.basic_ranged.damage_type
tt.bullet.fixed_height = 15
tt.bullet.g = -1.8 / (fts(1) * fts(1))
tt.bullet.hit_blood_fx = nil
tt.bullet.miss_decal = nil
tt.bullet.pop = nil
tt.bullet.hide_radius = 6
tt.bullet.prediction_error = false
tt.bullet.predict_target_pos = false
tt.bullet.hit_fx = "fx_enemy_darksteel_anvil_hit"
tt.render.sprites[1].name = "darksteel_anvil_attack_projectile"
tt.render.sprites[1].animated = true
tt.bullet.hide_radius = 0
tt.bullet.hit_distance = 20
tt.bullet.extend_particles_cutoff = true
tt = E:register_t_10086("bullet_soldier_priests_barrack", "bolt")
b = balance.specials.towers.tower_stage_28_priests_barrack.priest.ranged
tt.render.sprites[1].name = "priest_projectile"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 30
tt.bullet.max_speed = 300
tt.bullet.align_with_trajectory = true
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt.bullet.particles_name = "ps_bullet_soldier_priests_barrack_trail"
tt.bullet.hit_fx = "fx_soldier_priests_barrack_bolt_hit"
tt = E:register_t_10086("bullet_boss_spider_queen_tower_stun", "bombKR5")
tt.main_script.update = scripts.bullet_boss_spider_queen_tower_stun.update
tt.bullet.flight_time = fts(35)
tt.bullet.vis_flags = bor(F_RANGED, F_MOD)
tt.bullet.vis_bans = 0
tt.render.sprites[1].prefix = "boss_effects_bolt"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = vv(0.7)
tt.bullet.hit_fx = nil
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.hit_mod = "mod_boss_spider_queen_tower_debuff"
tt.bullet.particles_name = "ps_boss_spider_queen_bullet_tower_stun_trail"
tt.bullet.particles_name_2 = "ps_boss_spider_queen_bullet_tower_stun_trail_2"
tt.bullet.align_with_trajectory = true
tt = E:register_t_10086("bullet_boss_spider_queen_lifesteal", "bombKR5")
tt.main_script.update = scripts.bullet_boss_spider_queen_tower_stun.update
tt.bullet.flight_time = fts(10)
tt.bullet.vis_flags = bor(F_RANGED, F_MOD)
tt.bullet.vis_bans = 0
tt.render.sprites[1].name = "spider_queen_boss_effects_trail2_0001"
tt.render.sprites[1].animated = false
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.particles_name = "ps_boss_spider_queen_lifesteal_trail_1"
tt.bullet.particles_name_2 = "ps_boss_spider_queen_lifesteal_trail_2"
tt.bullet.hit_fx = "fx_boss_spider_queen_lifesteal_healing"
tt.bullet.align_with_trajectory = true
tt = E:register_t_10086("aura_enemy_brute_welder", "aura")
b = balance.enemies.hammer_and_anvil.brute_welder.basic_attack.flame
tt.aura.duration = b.duration
tt.aura.radius = b.radius
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_RANGED, F_AREA)
tt.aura.mod = "mod_burning_enemy_brute_welder"
tt.aura.cycle_time = b.cycle_time
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E:register_t_10086("aura_enemy_darksteel_anvil", "aura")
b = balance.enemies.hammer_and_anvil.darksteel_anvil.aura
tt.aura.duration = b.duration
tt.aura.radius = b.aura_radius
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.vis_flags = bor(F_RANGED, F_AREA)
tt.aura.mod = "mod_enemy_darksteel_anvil_buff"
tt.aura.cycle_time = b.cycle_time
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E:register_t_10086("aura_boss_machinist_burn", "aura")

E:add_comps(tt, "render", "tween")

b = balance.enemies.hammer_and_anvil.boss_machinist.fire_floor
tt.aura.damage_min = b.damage_min
tt.aura.damage_max = b.damage_max
tt.aura.damage_type = b.damage_type
tt.aura._radius = b.radius
tt.aura.radius = b.radius
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING, F_ENEMY)
tt.aura.cycle_time = b.cycle_time
tt.aura.duration = 1e+99
tt.aura.track_source = true
tt.aura.mod = "mod_boss_machinist_burn"
tt.main_script.insert = scripts.aura_apply_damage.insert
tt.main_script.update = scripts.aura_apply_damage.update
tt.aura_floor_t = "aura_boss_machinist_burn_floor"
tt.render.sprites[1].prefix = "dlcdwarfbossstage02_floorsmokeDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].alpha = 0
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt = E:register_t_10086("aura_boss_spider_queen_spiderweb", "aura")
b = balance.enemies.arachnids.boss_spider_queen.spiderweb
tt.aura.track_source = true
tt.aura.cycle_time = b.cycle_time
tt.main_script.update = scripts.aura_boss_spider_queen_spiderweb.update
tt.min_decal_distance = b.min_distance
tt.decal = "decal_boss_spider_queen_spiderweb"
tt.decal_duration = b.duration
tt = E:register_t_10086("aura_spider_webs_sprint", "aura")

AC(tt, "editor", "editor_script")

tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_spider_webs.update
tt.aura.ignore_flywalk = true
tt.aura.duration = -1
tt.aura.mod = "mod_spider_web_sprint"
tt.aura.radius = 80
tt.aura.cycle_time = fts(3)
tt.aura.vis_bans = bor(F_FLYING)
tt.aura.allowed_templates = {
	"enemy_spiderling",
	"enemy_spider_priest",
	"enemy_glarenwarden",
	"enemy_ballooning_spider",
	"enemy_ballooning_spider_flyer",
	"enemy_spider_sister",
	"enemy_cultbrood",
	"enemy_drainbrood",
	"enemy_spidead",
	"hero_spider",
	"soldier_hero_spider_ultimate"
}
tt.editor.components = {
	"render"
}
tt.editor.overrides = {
	["render.sprites[1].hidden"] = false,
	["render.sprites[1].animated"] = false,
	["render.sprites[1].name"] = "editor_red_circle"
}
tt.editor.props = {
	{
		"aura.radius",
		PT_NUMBER
	}
}
tt.editor_script.update = scripts.editor_aura_spider_web_sprint.update
tt = E:register_t_10086("aura_spider_webs_slowness", "aura_spider_webs_sprint")
tt.aura.allowed_templates = nil
tt.aura.mod = "mod_spider_web_slowness"
tt.aura.vis_bans = bor(F_ENEMY, F_FLYING)
tt.aura.excluded_templates = {
	"hero_spider",
	"soldier_hero_spider_ultimate",
	"hero_witch",
	"hero_space_elf"
}
tt = E:register_t_10086("priests_tentacle_aura", "aura")
b = balance.specials.towers.tower_stage_28_priests_barrack.tentacle.area_attack
tt.aura.cycles = 1
tt.aura.damage_min = b.damage_min
tt.aura.damage_max = b.damage_max
tt.aura.damage_type = b.damage_type
tt.aura.radius = b.radius
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.main_script.update = scripts.aura_apply_damage.update
tt = E:register_t_10086("aura_tower_sparking_geode_spike_burst", "aura")
b = balance.towers.sparking_geode.spike_burst
tt.aura.mods = {
	"mod_tower_sparking_geode_burst_slow",
	"mod_tower_sparking_geode_burst_damage"
}
tt.aura.radius = b.radius
tt.aura.vis_flags = bor(F_MOD)
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.duration = nil
tt.aura.cycle_time = b.damage_every
tt.distance_between_crystals = {
	115,
	110,
	70
}
tt.main_script.insert = scripts.aura_tower_sparking_geode_spike_burst.insert
tt.main_script.update = scripts.aura_tower_sparking_geode_spike_burst.update
tt.ps_names = {
	"ps_tower_sparking_geode_sparks_1",
	"ps_tower_sparking_geode_sparks_2"
}
tt = E:register_t_10086("mod_priests_abomination_eat", "modifier")
b = balance.specials.towers.tower_stage_28_priests_barrack.abomination
tt.main_script.queue = scripts.mod_enemy_unblinded_abomination_eat.queue
tt.main_script.update = scripts.mod_enemy_unblinded_abomination_eat.update
tt.explode_fx = "fx_soldier_priests_barrack_abomination_eat"
tt.required_hp = b.eat.hp_required
tt = E:register_t_10086("mod_bullet_enemy_brute_welder_death_mark", "modifier")

E:add_comps(tt, "mark_flags")

tt.mark_flags.vis_bans = F_STUN
tt.modifier.duration = 5
tt.main_script.queue = scripts.mod_bullet_enemy_brute_welder_death_mark.queue
tt.main_script.dequeue = scripts.mod_bullet_enemy_brute_welder_death_mark.dequeue
tt.main_script.update = scripts.mod_mark_flags.update
tt = E:register_t_10086("mod_bullet_enemy_brute_welder_death_stun", "modifier")

local b = balance.enemies.hammer_and_anvil.brute_welder

E:add_comps(tt, "render", "tween")

tt.main_script.update = scripts.mod_bullet_enemy_brute_welder_death_stun.update
tt.modifier.duration = b.death_missile.block_duration
tt.render.sprites[1].prefix = "brute_welder_tower_mod"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].offset = v(2, 10)
tt.render.sprites[1].sort_y_offset = -10
tt.sound_events.insert = "EnemyRevenantSoulcallerBlockTowerIn"
tt.sound_events.remove = "EnemyRevenantSoulcallerBlockTowerOut"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0.7, 0.7)
	},
	{
		fts(10),
		v(1, 1)
	}
}
tt.tween.remove = false
tt = E:register_t_10086("mod_enemy_darksteel_fist_stun", "mod_stun")

local b = balance.enemies.hammer_and_anvil.darksteel_fist.stun_attack

tt.modifier.duration = b.stun_duration
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_BOSS)
tt = E:register_t_10086("mod_stage_25_torso_missile_mark", "modifier")

E:add_comps(tt, "mark_flags", "render", "tween")

tt.mark_flags.vis_bans = F_STUN
tt.modifier.duration = 7
tt.main_script.queue = scripts.mod_stage_25_torso_missile_mark.queue
tt.main_script.dequeue = scripts.mod_stage_25_torso_missile_mark.dequeue
tt.main_script.update = scripts.mod_mark_flags.update
tt.render.sprites[1].prefix = "DLC_stage_03_missile_decal_tower"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(15),
		255
	}
}
tt.tween.remove = false
tt = E:register_t_10086("mod_stage_25_torso_missile_stun", "modifier")

local b = balance.specials.stage25_torso.missile

E:add_comps(tt, "render", "tween")

tt.main_script.update = scripts.mod_stage_25_torso_missile_stun.update
tt.main_script.remove = scripts.mod_stage_25_torso_missile_stun.remove
tt.modifier.duration = 9--b.max_duration
tt.render.sprites[1].prefix = "DLC_stage_03_missile_tower_fx"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].offset = v(2, 10)
tt.render.sprites[1].sort_y_offset = -10
tt.sound_events.insert = "EnemyRevenantSoulcallerBlockTowerIn"
tt.sound_events.remove = "EnemyRevenantSoulcallerBlockTowerOut"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0.7, 0.7)
	},
	{
		fts(10),
		v(1, 1)
	}
}
tt.tween.remove = false
tt.repair_cost = b.repair_cost
tt.water_decal_t = "decal_mod_stage_25_torso_missile_stun_water"
tt.hand_decal_t = "decal_mod_stage_25_torso_missile_stun_hand"
tt = E:register_t_10086("mod_stage_27_ray_stun", "modifier")
b = balance.specials.stage27_head

E:add_comps(tt, "render", "tween")

tt.main_script.update = scripts.mod_stage_27_ray_stun.update
tt.modifier.duration = b.ray_stun_duration
tt.render.sprites[1].prefix = "dclenanos_stage05_headplasmaDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "dclenanos_stage05_headplasmabgDef"
tt.render.sprites[2].animated = true
tt.render.sprites[2].exo = true
tt.render.sprites[2].draw_order = 20
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = 15
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(15),
		255
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		fts(15),
		255
	}
}
tt.tween.remove = false
tt.sound_events.insert = "EnemyRevenantSoulcallerBlockTowerIn"
tt.sound_events.remove = "EnemyRevenantSoulcallerBlockTowerOut"
tt = E:register_t_10086("mod_bullet_stage_27_tower_stun", "modifier")

local b = balance.specials.stage27_head

E:add_comps(tt, "render")

tt.main_script.update = scripts.mod_bullet_stage_27_tower_stun.update
tt.main_script.remove = scripts.mod_bullet_stage_27_tower_stun.remove
tt.render.sprites[1].prefix = "boss_fx_scrap_tower_fx"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].offset = v(-1, 10)
tt.render.sprites[1].sort_y_offset = -10
tt.sound_events.insert = "EnemyRevenantSoulcallerBlockTowerIn"
tt.sound_events.remove = "EnemyRevenantSoulcallerBlockTowerOut"
tt.repair_cost = b.tower_stun_repair_cost
tt.hand_decal_t = "decal_mod_stage_25_torso_missile_stun_hand"
tt = E:register_t_10086("mod_burning_enemy_brute_welder", "modifier")
b = balance.enemies.hammer_and_anvil.brute_welder.basic_attack.burn

E:add_comps(tt, "dps", "render")

tt.modifier.duration = b.duration
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.dps.damage_every = b.cycle_time
tt.render.sprites[1].prefix = "brute_welder_attack_mod"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = E:register_t_10086("mod_enemy_darksteel_anvil_buff", "modifier")
b = balance.enemies.hammer_and_anvil.darksteel_anvil.aura

E:add_comps(tt, "render", "fast")

tt.main_script.insert = scripts.mod_enemy_darksteel_anvil_buff.insert
tt.main_script.update = scripts.mod_enemy_darksteel_anvil_buff.update
tt.main_script.remove = scripts.mod_enemy_darksteel_anvil_buff.remove
tt.modifier.use_mod_offset = true
tt.extra_armor = b.mod.extra_armor
tt.fast.factor = b.mod.speed_factor
tt.modifier.duration = b.mod.duration
tt.target_self = b.target_self
tt.render.sprites[1].prefix = "darksteel_anvil_skill_FX"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = v(0.5, 0.6)
tt = E:register_t_10086("mod_enemy_darksteel_hulk_charge_enemy", "modifier")
b = balance.enemies.hammer_and_anvil.darksteel_hulk

E:add_comps(tt, "dps", "render")

tt.dps.damage_min = b.charge.damage_enemy_min
tt.dps.damage_max = b.charge.damage_enemy_max
tt.dps.damage_type = b.charge.damage_type
tt.dps.damage_every = fts(10)
tt.modifier.duration = fts(7)
tt.modifier.use_mod_offset = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.render.sprites[1].name = "darksteel_hulk_attack_hit_idle"
tt.render.sprites[1].loop = false
tt = E:register_t_10086("mod_enemy_darksteel_hulk_charge_soldier", "mod_enemy_darksteel_hulk_charge_enemy")
b = balance.enemies.hammer_and_anvil.darksteel_hulk
tt.dps.damage_min = b.charge.damage_soldier_min
tt.dps.damage_max = b.charge.damage_soldier_max
tt = E:register_t_10086("mod_hide_tower", "modifier")
tt.main_script.insert = scripts.mod_hide_tower.insert
tt.main_script.remove = scripts.mod_hide_tower.remove
tt.skip_sprite_index = {}
tt.skip_all_modifiers = false
tt.skip_all_auras = false
tt.skip_modifiers = {}
tt.skip_auras = {}
tt.handle_stun = true
tt.skip_hide_modifier_self = true
tt.allows_duplicates = false
tt.replaces_lower = false
tt.resets_same = false
tt = E:register_t_10086("mod_stage_22_tower_destroyed", "mod_hide_tower")

local b = balance.specials.stage22_tower_destroyed

E:add_comps(tt, "render")

tt.main_script.update = scripts.mod_stage_22_tower_destroyed.update
tt.main_script.remove = nil
tt.render.sid_holder = 1
tt.render.sprites[tt.render.sid_holder].name = "terrains_holders_0007"
tt.render.sprites[tt.render.sid_holder].animated = false
tt.render.sprites[tt.render.sid_holder].z = Z_DECALS
tt.render.sprites[tt.render.sid_holder].offset = v(0, 16)
tt.render.sid_flag = 2
tt.render.sprites[tt.render.sid_flag] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_flag].name = "terrains_holders_0019_flag"
tt.render.sprites[tt.render.sid_flag].animated = false
tt.render.sprites[tt.render.sid_flag].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_flag].offset = v(-1, 17)
tt.render.sid_exo = 3
tt.render.sprites[tt.render.sid_exo] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_exo].prefix = "animations_tower_killDef"
tt.render.sprites[tt.render.sid_exo].name = "idle"
tt.render.sprites[tt.render.sid_exo].exo = true
tt.render.sprites[tt.render.sid_exo].animated = true
tt.render.sprites[tt.render.sid_exo].draw_order = 20
tt.render.sprites[tt.render.sid_exo].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_exo].offset = v(-2, -15)
tt.sound_restore = "Stage22TowerRestore"
tt.repair_cost = b.repair_cost
tt.hand_decal_t = "decal_mod_stage_22_tower_stun_hand"
tt.skip_modifiers = {
	"mod_boss_crocs_tower_eat"
}
tt.click_rect = r(-30, 0, 60, 46)
tt.menu_offset = v(0, 12)
tt = E:register_t_10086("mod_boss_machinist_burn", "modifier")
b = balance.enemies.hammer_and_anvil.boss_machinist.fire_floor.burn

E:add_comps(tt, "dps", "render")

tt.modifier.duration = b.duration
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.dps.damage_every = b.cycle_time
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = E:register_t_10086("mod_enemy_glarenwarden_melee_lifesteal", "modifier")
b = balance.enemies.arachnids.glarenwarden.basic_attack
tt.main_script.insert = scripts.mod_lifesteal_kr5.insert
tt.damage_min = b.damage_min
tt.damage_max = b.damage_max
tt.heal_hp_damage_factor = b.lifesteal.damage_factor
tt.heal_hp_fixed = b.lifesteal.fixed_heal
tt.damage_type = b.damage_type
tt.only_predict_damage = true
tt.heal_fx = "fx_glarenwarden_healing"
tt.heal_fx_offset = v(0, 12)
tt = E:register_t_10086("mod_test_head_pos_kr5", "modifier")

E:add_comps(tt, "render")

tt.modifier.duration = 5
tt.render.sprites[1].prefix = "poison"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].scale = vv(0.4)
tt.render.sprites[1].draw_order = 2

for i = 2, 20 do
	tt.render.sprites[i] = table.deepclone(tt.render.sprites[1])
	tt.render.sprites[i].r = math.rad(math.random(0, 360))
end

tt.position_test = "HEAD"
tt.main_script.update = scripts.mod_test_unit_pos_kr5.update
tt = E:register_t_10086("mod_test_mod_pos_kr5", "mod_test_head_pos_kr5")
tt.position_test = "MOD"
tt = E:register_t_10086("mod_test_hit_pos_kr5", "mod_test_head_pos_kr5")
tt.position_test = "HIT"
tt = E:register_t_10086("mod_cultbrood_poison", "modifier")
b = balance.enemies.arachnids.cultbrood.poison_attack

E:add_comps(tt, "render", "dps")

tt.modifier.duration = b.poison.duration
tt.modifier.vis_flags = bor(F_MOD)
tt.render.sprites[1].name = "cultbrood_modifier_idle"
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_cultbrood_poison.update
tt.dps.damage_every = b.poison.damage_every
tt.dps.damage_max = b.poison.damage
tt.dps.damage_min = b.poison.damage
tt.dps.damage_type = b.poison.damage_type
tt.transformation_nodes_limit = b.transformation_nodes_limit
tt = E:register_t_10086("mod_drainbrood_web", "modifier")
b = balance.enemies.arachnids.drainbrood.webspit

E:add_comps(tt, "render")

tt.main_script.insert = scripts.mod_stun.insert
tt.main_script.update = scripts.mod_drainbrood_web.update
tt.main_script.remove = scripts.mod_stun.remove
tt.modifier.animation_phases = true
tt.modifier.duration = b.duration
tt.modifier.hide_target_delay = fts(0)
tt.modifier.use_mod_offset = false
tt.render.sprites[1].prefix = "drainblood_cucoon"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt = E:register_t_10086("mod_boss_spider_queen_poison", "mod_poison")
b = balance.enemies.arachnids.boss_spider_queen.ranged_attack.poison
tt.dps.damage_every = b.damage_every
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.kill = true
tt.modifier.duration = b.duration
tt.modifier.use_mod_offset = false
tt.render.sprites[1].prefix = "boss_effects_poison"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].size_names = {
	"idle",
	"idle",
	"idle"
}
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].draw_order = DO_MOD_FX
tt = E:register_t_10086("mod_boss_spider_queen_area_lifesteal_end", "modifier")
b = balance.enemies.arachnids.boss_spider_queen.drain_life.lifesteal_end
tt.main_script.insert = scripts.mod_boss_spider_queen_area_lifesteal.insert
tt.damage_min = b.damage_min
tt.damage_max = b.damage_max
tt.heal_hp_damage_factor = b.damage_factor
tt.heal_hp_fixed = b.fixed_heal
tt.damage_type = b.damage_type
tt = E:register_t_10086("mod_boss_spider_queen_area_lifesteal_loop", "modifier")
b = balance.enemies.arachnids.boss_spider_queen.drain_life.lifesteal_loop
tt.main_script.insert = scripts.mod_lifesteal_kr5.insert
tt.damage_min = b.damage_min
tt.damage_max = b.damage_max
tt.heal_hp_damage_factor = b.damage_factor
tt.heal_hp_fixed = b.fixed_heal
tt.damage_type = b.damage_type
tt = E:register_t_10086("mod_spider_web_sprint", "mod_slow")
b = balance.specials.terrain_7.spider_floor_webs
tt.slow.factor = b.sprint_factor
tt.modifier.duration = fts(5)
tt = E:register_t_10086("mod_spider_web_slowness", "mod_spider_web_sprint")
b = balance.specials.terrain_7.spider_floor_webs
tt.slow.factor = b.slow_factor
tt = E:register_t_10086("mod_tower_sparking_geode_stun", "mod_stun")
tt.main_script.insert = scripts.mod_tower_sparking_geode_stun.insert
tt.main_script.remove = scripts.mod_tower_sparking_geode_stun.remove
tt.main_script.update = scripts.mod_tower_sparking_geode_stun.update
tt.modifier.animation_phases = true
tt.render.sid_decal = 1
tt.render.sprites[tt.render.sid_decal].prefix = "sparking_geode_longray_decal_down"
tt.render.sprites[tt.render.sid_decal].name = "run"
tt.render.sprites[tt.render.sid_decal].z = Z_DECALS
tt.render.sid_ray = 2
tt.render.sprites[tt.render.sid_ray] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_ray].size_prefixes = nil
tt.render.sprites[tt.render.sid_ray].prefix = "sparking_geode_longray_ray"
tt.render.sprites[tt.render.sid_ray].name = "down"
tt.render.sprites[tt.render.sid_ray].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_ray].scale = vv(2)
tt.render.sid_crystal = 3
tt.render.sprites[tt.render.sid_crystal] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_crystal].prefix = "sparking_geode_crystal_"
tt.render.sprites[tt.render.sid_crystal].size_prefixes = {
	"small",
	"mid",
	"big"
}
tt.render.sid_fx = 4
tt.render.sprites[tt.render.sid_fx] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_fx].prefix = "sparking_geode_cystal_fx"
tt.modifier.duration = nil
tt.inflicted_damage_factor = 1
tt.received_damage_factor = nil
tt.modifier.use_mod_offset = false
tt.health_bar_offset = {
	v(0, 40),
	v(0, 60),
	v(0, 78)
}
tt.out_fx = "fx_mod_tower_sparking_geode_stun_death"
tt.mod_sound = "TowerSparkingGeodeCristalizeBolt"
tt = E:register_t_10086("mod_tower_sparking_geode_burst_slow", "mod_slow")
b = balance.towers.sparking_geode.spike_burst
tt.modifier.duration = b.damage_every + fts(1)
tt.slow.factor = b.speed_factor

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.slow.factor[this.modifier.level]

	return scripts.mod_slow.insert(this, store, script)
end

tt = E:register_t_10086("mod_tower_sparking_geode_burst_damage", "modifier")
b = balance.towers.sparking_geode.spike_burst

E:add_comps(tt, "dps", "render")

tt.render.sprites[1].name = "sparking_geode_modifier_run"
tt.modifier.duration = b.damage_every + fts(1)
tt.modifier.vis_bans = bor(F_BOSS)
tt.dps.damage_every = b.damage_every
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type

function tt.main_script.insert(this, store, script)
	this.dps.damage_min = this.dps.damage_min[this.modifier.level]
	this.dps.damage_max = this.dps.damage_max[this.modifier.level]

	return scripts.mod_dps.insert(this, store, script)
end

tt.main_script.update = scripts.mod_dps.update
tt = E:register_t_10086("controller_stage_29_spider_holders", "decal_scripted")

E:add_comps(tt, "editor", "ui")

b = balance.specials.stage29_holder_block
tt.main_script.update = scripts.controller_stage_29_spider_holders.update
tt.render.sprites[1].prefix = "spiderholder_spiderholder"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5, 0.4)
tt.render.sprites[1].name = "climbing_up_idle"
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.waves = b.waves
tt.first_cooldown = b.first_cooldown
tt.cooldown = b.cooldown
tt.max_casts = b.max_casts
tt.game_start_blocked_holders = b.game_start_blocked_holders
tt.time_to_down = b.time_to_down
tt.time_to_up = b.time_to_up
tt.time_netting = b.time_netting
tt.taps_to_cancel = b.taps_to_cancel
tt.hand_decal_t = "decal_mod_stage_29_holder_block_hand"
tt.ui.click_rect = r(-35, -40, 70, 70)
tt.vis_bans = 0
tt.vis_flags = 0
tt.threads_separation = 38
tt.threads_amount = math.ceil(REF_H / tt.threads_separation)
tt.threads_idles = {
	"idle1",
	"idle1",
	"idle2",
	"idle3",
	"idle4",
	"idle4"
}

for i = 1, tt.threads_amount do
	local s = E:clone_c("sprite")

	s.prefix = "glarewarden_web_spiderweb"
	s.name = tt.threads_idles[1]
	s.loop = false
	s.anchor.y = 0
	s.offset.y = (i - 1) * tt.threads_separation
	s.z = Z_OBJECTS_SKY - 1
	s.hidden = true
	tt.render.sprites[i + 1] = s
end

tt.sound_loop = "EnemySpidersMechanicTowerSpiderWorkingLoop"
tt.sound_death = "EnemySpidersMechanicTowerSpiderDeath"
tt = E:register_t_10086("tower_holder_pre_blocked_spiders", "decal_scripted")
tt.render.sprites[1].name = "terrains_holders_00017_flag"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.3)
tt = E:register_t_10086("controller_stage_30_boss_spiders", "decal_scripted")

E:add_comps(tt, "editor")

b = balance.enemies.arachnids.boss_spider_queen
tt.main_script.update = scripts.controller_stage_30_boss_spiders.update
tt.spawn_path = b.spawn_path
tt.spawn_node = b.spawn_node
tt.render.sid_queen_podium = 1
tt.wave_spawns = b.wave_spawns
tt.wave_spawns_impossible = b.wave_spawns_impossible
tt.wave_spawns_object = "glarenwarden_thread_spawner"
tt.render.sprites[tt.render.sid_queen_podium].prefix = "spiderqueen_spider_queenDef"
tt.render.sprites[tt.render.sid_queen_podium].animated = true
tt.render.sprites[tt.render.sid_queen_podium].exo = true
tt.render.sprites[tt.render.sid_queen_podium].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_queen_podium].name = "walk"
tt.render.sprites[tt.render.sid_queen_podium].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_queen_podium].sort_y_offset = 0
tt.render.sid_jump = 2
tt.render.sprites[tt.render.sid_jump] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[tt.render.sid_jump].prefix = "spiderqueen_queen_assetDef"
tt.render.sprites[tt.render.sid_jump].hidden = true
tt.render.sprites[tt.render.sid_jump].name = "in"
tt.render.sid_land = 3
tt.render.sprites[tt.render.sid_land] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[tt.render.sid_land].prefix = "spiderqueen_spider_jumpDef"
tt.render.sid_smoke = 4
tt.render.sprites[tt.render.sid_smoke] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[tt.render.sid_smoke].prefix = "spiderqueen_smokeDef"
tt = E:register_t_10086("controller_stage_23_roboboots", "decal_scripted")
b = balance.specials.stage23_roboboots

E:add_comps(tt, "editor")

tt.main_script.update = scripts.controller_stage_23_roboboots.update
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "dclenanos_stage01_robobootDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(0, -1)
tt.render.sprites[1].sort_y_offset = 200
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "dclenanos_stage01_roboboot2Def"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(2.3, -3.1)
tt.render.sprites[2].sort_y_offset = 50
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "dclenanos_stage01_roboboot_topDef"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].exo = true
tt.render.sprites[3].offset = v(0, 0)
tt.render.sprites[3].sort_y_offset = 200
tt.render.sprites[3].z = Z_OBJECTS
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "dclenanos_stage01_roboboot2_topDef"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].exo = true
tt.render.sprites[4].offset = v(2.3, -2.1)
tt.render.sprites[4].sort_y_offset = 50
tt.render.sprites[4].z = Z_OBJECTS
tt.wave_config = b.wave_config
tt.sound_open = "Stage23BootOpen"
tt.sound_close = "Stage23BootClose"
tt = E:register_t_10086("controller_stage_24_machinist")
b = balance.specials.stage24_factory

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_24_machinist.update
tt.wave_config = b.wave_config
tt.machinist_t = "enemy_machinist"
tt = E:register_t_10086("decal_stage24_boss_machinist_shoutbox", "decal_stage06_cultist_shoutbox")
tt = E:register_t_10086("taunts_s24_controller")

E:add_comps(tt, "main_script", "taunts", "editor")

tt.load_file = "level101_taunts"
tt.main_script.insert = scripts.taunts_controller.insert
tt.taunts.delay_min = 10
tt.taunts.delay_max = 20
tt.taunts.sets = {}
tt.taunts.sets.stage_24_boss_machinist_before_bossfight = CC("taunt_set")
tt.taunts.sets.stage_24_boss_machinist_before_bossfight.format = "TAUNT_STAGE24_BOSS_MACHINIST_BEFORE_BOSSFIGHT_%04i"
tt.taunts.sets.stage_24_boss_machinist_before_bossfight.decal_name = "decal_stage24_boss_machinist_shoutbox"
tt.taunts.sets.stage_24_boss_machinist_before_bossfight.pos = v(460, 550)
tt = E:register_t_10086("controller_stage_25_torso")
b = balance.specials.stage25_torso

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_25_torso.update
tt.wave_config = b.wave_config
tt.action_duration = fts(220)
tt.fist_radius = b.fist.radius
tt.fist_damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS, DAMAGE_IGNORE_SHIELD, DAMAGE_NO_DODGE)
tt.torso_t = "decal_stage_25_torso"
tt.torso_modes_t = "decal_stage_25_torso_modes"
tt.fist_t = "decal_stage_25_fist"
tt.fist_decal_t = "decal_stage_25_fist_shadow"
tt.missile_shoot_time = fts(66)
tt.missile_mark_mod = "mod_stage_25_torso_missile_mark"
tt.missile_t = "bullet_stage_25_torso_missile"
tt.missile_spawn_pos = v(750, 585)
tt.sound_torso_open = "Stage25TorsoOpen"
tt.sound_torso_close = "Stage25TorsoClose"
tt.sound_torso_lever_1 = "Stage25TorsoOperateLever1"
tt.sound_torso_lever_2 = "Stage25TorsoOperateLever2"
tt.sound_torso_button = "Stage25TorsoButton"
tt.sound_fist = "Stage25FistSlam"
tt.sound_missile = "Stage25MissileLaunch"
tt = E:register_t_10086("decal_stage25_machinist_shoutbox", "decal_stage06_cultist_shoutbox")
tt = E:register_t_10086("taunts_s25_controller")

E:add_comps(tt, "main_script", "taunts", "editor")

tt.load_file = "level101_taunts"
tt.main_script.insert = scripts.taunts_controller.insert
tt.taunts.delay_min = 10
tt.taunts.delay_max = 20
tt.taunts.sets = {}
tt.taunts.sets.stage_25_machinist_end = CC("taunt_set")
tt.taunts.sets.stage_25_machinist_end.format = "TAUNT_STAGE25_MACHINIST_END_%04i"
tt.taunts.sets.stage_25_machinist_end.decal_name = "decal_stage25_machinist_shoutbox"
tt.taunts.sets.stage_25_machinist_end.pos = v(460, 550)
tt = E:register_t_10086("controller_stage_25_tunnel_glow")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_25_tunnel_glow.update
tt.glow_t = "decal_stage_25_mask_2_glow"
tt = E:register_t_10086("controller_stage_26_taunts")

E:add_comps(tt, "main_script", "taunts", "editor")

tt.main_script.update = scripts.controller_stage_26_taunts.update
tt.taunts.delay_min = 20
tt.taunts.delay_max = 30
tt.taunts.sets = {}
tt.taunts.sets.preparation = CC("taunt_set")
tt.taunts.sets.preparation.format = "LV26_GRYMBEARD_PREPARATION_TAUNT_%02i"
tt.taunts.sets.preparation.end_idx = 4
tt.taunts.sets.fight = CC("taunt_set")
tt.taunts.sets.fight.format = "LV26_GRYMBEARD_FIGHT_TAUNT_%02i"
tt.taunts.sets.fight.end_idx = 4
tt = E:register_t_10086("controller_stage_26_spawners")
b = balance.specials.stage26_spawners

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_26_spawners.update
tt.wave_config = b.wave_config
tt.fist_spawner_controller_t = "controller_stage_26_fist_spawner"
tt.tube_left_t = "decal_stage_26_tube_left"
tt.tube_right_t = "decal_stage_26_tube_right"
tt.clone_spawner_controller_t = "controller_stage_26_clone_spawner"
tt.clone_spawner_t = "decal_stage_26_clone_spawner"
tt.hulk_spawner_controller_t = "controller_stage_26_hulk_spawner"
tt.hulk_spawner_t = "decal_stage_26_hulk_spawner"
tt = E:register_t_10086("controller_stage_26_fist_spawner")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_26_fist_spawner.update
tt.boss_t = "decal_stage_26_boss"
tt.hand_controller_t = "controller_stage_26_fist_spawner_hand"
tt = E:register_t_10086("controller_stage_26_fist_spawner_hand")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_26_fist_spawner_hand.update
tt.fist_spawner_t = "decal_stage_26_fist_spawner"
tt.fist_spawner_light_t = "decal_stage_26_fist_spawner_light"
tt.sound_hand = "Stage26FistSpawnerHand"
tt.sound_open = "Stage26FistSpawnerBoothFrontDoorOpen"
tt.sound_close = "Stage26FistSpawnerBoothFrontDoorClose"
tt = E:register_t_10086("controller_stage_26_clone_spawner")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_26_clone_spawner.update
tt.clone_spawner_t = "decal_stage_26_fist_spawner"
tt.tube_t = "decal_stage_26_fist_spawner_light"
tt.boss_t = "decal_stage_26_boss"
tt.sound_in = "Stage26CloneSpawnerIn"
tt.sound_out = "Stage26CloneSpawnerOut"
tt.sound_chain = "Stage26Chain"
tt = E:register_t_10086("controller_stage_26_hulk_spawner")

E:add_comps(tt, "main_script", "events")

tt.main_script.update = scripts.controller_stage_26_hulk_spawner.update
tt.hulk_spawner_t = "decal_stage_26_hulk_spawner"
tt.hulk_t = "enemy_darksteel_hulk"
tt.hulk_spawn_delay = fts(322)
tt.path_to_spawn = 9
tt.events.list[1].name = "hulk_spawn"
tt.events.list[1].on_event = scripts.controller_stage_26_hulk_spawner.on_event
tt.sound_shot = "Stage26HulkSpawnerShotTransform"
tt = E:register_t_10086("decal_stage26_boss_shoutbox", "decal_stage06_cultist_shoutbox")
tt = E:register_t_10086("taunts_s26_controller")

E:add_comps(tt, "main_script", "taunts", "editor")

tt.load_file = "level101_taunts"
tt.main_script.insert = scripts.taunts_controller.insert
tt.taunts.delay_min = 10
tt.taunts.delay_max = 20
tt.taunts.sets = {}
tt.taunts.sets.stage_26_boss_before_bossfight = CC("taunt_set")
tt.taunts.sets.stage_26_boss_before_bossfight.format = "TAUNT_STAGE26_BOSS_BEFORE_BOSSFIGHT_%04i"
tt.taunts.sets.stage_26_boss_before_bossfight.decal_name = "decal_stage26_boss_shoutbox"
tt.taunts.sets.stage_26_boss_before_bossfight.pos = v(460, 550)
tt = E:register_t_10086("decal_stage27_boss_shoutbox", "decal_stage06_cultist_shoutbox")
tt = E:register_t_10086("controller_stage_27_platform")

E:add_comps(tt, "main_script", "events", "taunts", "editor")

tt.main_script.insert = scripts.taunts_controller.insert
tt.main_script.update = scripts.controller_stage_27_platform.update
tt.platform_t = "decal_stage_27_platform"
tt.platform_bars_t = "decal_stage_27_platform_bars"
tt.cannon_left_t = "decal_stage_27_cannon_left"
tt.cannon_right_t = "decal_stage_27_cannon_right"
tt.cannon_controller_t_l = "controller_stage_27_cannon_L"
tt.cannon_controller_t_r = "controller_stage_27_cannon_R"
tt.head_controller_t = "controller_stage_27_head"
tt.door_mask_t = "decal_stage_27_mask_3"
tt.events.list[1].name = "platform_up"
tt.events.list[1].on_event = scripts.controller_stage_27_platform.on_platform_up_event
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "platform_down"
tt.events.list[2].on_event = scripts.controller_stage_27_platform.on_platform_down_event
tt.events.list[3] = E:clone_c("event")
tt.events.list[3].name = "platform_destroy"
tt.events.list[3].on_event = scripts.controller_stage_27_platform.on_platform_destroy_event
tt.events.list[4] = E:clone_c("event")
tt.events.list[4].name = "cannons"
tt.events.list[4].on_event = scripts.controller_stage_27_platform.on_cannons_event
tt.events.list[5] = E:clone_c("event")
tt.events.list[5].name = "taunt"
tt.events.list[5].on_event = scripts.controller_stage_27_platform.on_taunt_event
tt.load_file = "level101_taunts"
tt.taunts.sets = {}
tt.taunts.sets.preparation = CC("taunt_set")
tt.taunts.sets.preparation.format = "LV27_GRYMBEARD_PREPARATION_TAUNT_%02i"
tt.taunts.sets.preparation.end_idx = 4
tt.taunts.sets.fight = CC("taunt_set")
tt.taunts.sets.fight.format = "LV27_GRYMBEARD_FIGHT_TAUNT_%02i"
tt.taunts.sets.fight.end_idx = 4
tt.sound_intro = "Stage27Intro"
tt.sound_platform_up = "Stage27PlatformUp"
tt.sound_platform_down = "Stage27PlatformDown"
tt.sound_platform_destroy_chains = "Stage27PlatformDestroyChains"
tt.sound_platform_destroy_impacts = "Stage27PlatformDestroyHeadImpacts"
tt.sound_cannon_alarm = "Stage27CloneCannonAlarm"
tt = E:register_t_10086("controller_stage_27_cannon")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_27_cannon.update
tt.cannon_shot_fx_t = "fx_stage_27_cannon_shot"
tt.cannon_shoot_time = fts(30)
tt.bullet_clone_dead_t = "bullet_stage_27_clone_dead"
tt.bullet_clone_alive_t = "bullet_stage_27_clone_alive"
tt.sound_shot = "Stage27CloneCannonOneShot"
tt = E:register_t_10086("controller_stage_27_cannon_L", "controller_stage_27_cannon")

E:add_comps(tt, "events")

tt.events.list[1].name = "shoot-cannons-L"
tt._decal = "decal_stage_27_cannon_left"
tt.events.list[1].on_event = scripts.controller_stage_27_cannon.on_cannons_event
tt = E:register_t_10086("controller_stage_27_cannon_R", "controller_stage_27_cannon")

E:add_comps(tt, "events")

tt.events.list[1].name = "shoot-cannons-R"
tt._decal = "decal_stage_27_cannon_right"
tt.events.list[1].on_event = scripts.controller_stage_27_cannon.on_cannons_event
tt = E:register_t_10086("controller_stage_27_head")
b = balance.specials.stage27_head

E:add_comps(tt, "main_script", "events", "ui", "editor")

tt.main_script.update = scripts.controller_stage_27_head.update
tt.head_t = "decal_stage_27_head"
tt.ray_t = "decal_stage_27_ray"
tt.ray_stun_mod_t = "mod_stage_27_ray_stun"
tt.ray_damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS, DAMAGE_IGNORE_SHIELD, DAMAGE_NO_DODGE)
tt.goblins_t = "decal_stage_27_goblins"
tt.smoke_back_t = "decal_stage_27_smoke_back"
tt.smoke_front_t = "decal_stage_27_smoke_front"
tt.sparks_t = "decal_stage_27_sparks"
tt.scrap_bullet_t = "bullet_stage_27_scrap"
tt.scrap_fx_t = "fx_stage_27_scrap"
tt.tower_stun_bullet_t = "bullet_stage_27_tower_stun"
tt.hand_decal_t = "decal_mod_stage_25_torso_missile_stun_hand"
tt.towers_to_stun = b.towers_to_stun
tt.events.list[1].name = "head_attack_left"
tt.events.list[1].on_event = scripts.controller_stage_27_head.on_attack_left_event
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "head_attack_right"
tt.events.list[2].on_event = scripts.controller_stage_27_head.on_attack_right_event
tt.events.list[3] = E:clone_c("event")
tt.events.list[3].name = "head_attack_left_cannon"
tt.events.list[3].on_event = scripts.controller_stage_27_head.on_attack_left_cannon_event
tt.events.list[4] = E:clone_c("event")
tt.events.list[4].name = "head_attack_right_cannon"
tt.events.list[4].on_event = scripts.controller_stage_27_head.on_attack_right_cannon_event
tt.events.list[5] = E:clone_c("event")
tt.events.list[5].name = "head_cannons"
tt.events.list[5].on_event = scripts.controller_stage_27_head.on_cannons_event
tt.events.list[6] = E:clone_c("event")
tt.events.list[6].name = "head_ears"
tt.events.list[6].on_event = scripts.controller_stage_27_head.on_ears_event
tt.events.list[7] = E:clone_c("event")
tt.events.list[7].name = "head_destroy"
tt.events.list[7].on_event = scripts.controller_stage_27_head.on_head_destroy_event
tt.events.list[8] = E:clone_c("event")
tt.events.list[8].name = "head_scrap"
tt.events.list[8].on_event = scripts.controller_stage_27_head.on_scrap_event
tt.ui.click_rect = r(-100, 50, 350, 250)
tt.charge_time = b.charge_time
tt.attack_duration = b.attack_duration
tt.taps_to_cancel = b.taps_to_cancel
tt.sound_ears_open = "Stage27HeadOpen"
tt.sound_ears_close = "Stage27HeadClose"
tt.sound_move = "Stage27HeadMove"
tt.sound_charge = "Stage27HeadFireblastCharge"
tt.sound_shoot = "Stage27HeadFireblastRelease"
tt.sound_cancel_tap = "Stage27HeadFireblastCancelTap"
tt.sound_interrupt = "Stage27HeadFireblastInterrupt"
tt.sound_return = "Stage27HeadReturn"
tt = E:register_t_10086("glarenwarden_thread_spawner", "decal_scripted")

AC(tt, "nav_path", "motion", "spawner", "sound_events")

tt.spawn = "enemy_glarenwarden"
tt.main_script.insert = scripts.glarenwarden_thread_spawner.insert
tt.main_script.update = scripts.glarenwarden_thread_spawner.update
tt.sound_events.insert = "ElvesCreepSonOfMactansLanding"
tt.render.sprites[1].prefix = "glarenwarden_creep"
tt.render.sprites[1].name = "descending_loop"
tt.render.sprites[1].offset.y = 0
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.threads_separation = 38
tt.threads_amount = math.ceil(REF_H / tt.threads_separation)
tt.threads_idles = {
	"idle1",
	"idle1",
	"idle2",
	"idle3",
	"idle4",
	"idle4"
}

for i = 1, tt.threads_amount do
	local s = E:clone_c("sprite")

	s.prefix = "glarewarden_web_spiderweb"
	s.name = tt.threads_idles[1]
	s.loop = false
	s.anchor.y = 0
	s.offset.y = (i - 1) * tt.threads_separation
	s.z = Z_OBJECTS_SKY - 1
	tt.render.sprites[i + 1] = s
end

tt = E:register_t_10086("stage_29_cocoon", "decal_scripted")

E:add_comps(tt, "spawner")

tt.render.sprites[1].prefix = "cocon_stage2_coocoon"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.animation_spawner_start = "summon_in"
tt.animation_spawner_idle = "idle_anim"
tt.animation_spawner_end = "summon_out"
tt.animation_spawner_idle_broken = "idle_broken"
tt.broken_on_heroic = true
tt.broken_on_iron = true
tt.main_script.update = scripts.stage_29_cocoon.update
tt.spawn_data = nil
tt.spawner.eternal = true
tt.sound_inflate = "EnemySpidersMechanicSpawnerInflate"
tt.sound_explode = "EnemySpidersMechanicSpawnerExplode"
tt.sound_regenerate = "EnemySpidersMechanicSpawnerRegenerate"
