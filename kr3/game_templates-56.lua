-- chunkname: @./kr5/templates_game.lua

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
local scripts = require("game_scripts-56")

require("templates")
--table.insert(__CHAINED_TEMPLATES, "templates_game")

local balance = require("balance/balance")
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

if table.contains(arg, "-balance_override") then
	local balance_override_path = arg[table.keyforobject(arg, "-balance_override") + 1]

	package.loaded[balance_override_path] = nil

	require(balance_override_path)
end

if game and game.store and game.store.level and game.store.level.test_case and game.store.level.test_case.patch_balance then
	local new_balance = game.store.level.test_case:patch_balance()

	if new_balance then
		balance = new_balance
	end
end

tt = E:register_t_10086("ps_stage_34_petalos_1")

E:add_comps(tt, "pos", "particle_system")

tt.pos = v(1300, 0)
tt.particle_system.alphas = {
	255,
	200,
	150,
	0
}
tt.particle_system.emit_area_spread = v(0, 1300)
tt.particle_system.emission_rate = 0.5
tt.particle_system.emit_direction = -3.3161255787892245
tt.particle_system.emit_offset = {
	x = 20,
	y = 65.71428571428572
}
tt.particle_system.emit_rotation = 2.0943951023931953
tt.particle_system.emit_rotation_spread = 5.235987755982985
tt.particle_system.emit_speed = {
	50,
	100
}
tt.particle_system.emit_spread = 0.7853981633974483
tt.particle_system.name = "stage34_petalos_1"
tt.particle_system.particle_lifetime = {
	10,
	23
}
tt.particle_system.spin = {
	0.5,
	5
}
tt.particle_system.z = Z_OBJECTS_SKY
tt = E:register_t_10086("ps_stage_34_petalos_2", "ps_stage_34_petalos_1")
tt.particle_system.name = "stage34_petalos_2"
tt = E:register_t_10086("ps_wuxian_bolt_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "wuxian_trail_idle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 60
tt.particle_system.particle_lifetime = {
	fts(6),
	fts(6)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_water_sorceress_bolt_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "watersorceress_projectile_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 20
tt.particle_system.particle_lifetime = {
	fts(14),
	fts(14)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_hellfire_warlock_bullet_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "hellfire_warlock_fireball_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 20
tt.particle_system.particle_lifetime = {
	fts(13),
	fts(13)
}
tt.particle_system.anchor = v(0.6304347826086957, 0.36363636363636365)
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_storm_elemental_bullet_trail_1")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "storm_elemental_vfx_proyectile_trail_idle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 20
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(8)
}
tt.particle_system.scales_y = {
	0.7,
	0.7
}
tt.particle_system.scales_x = {
	0.7,
	0.7
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_storm_elemental_bullet_trail_2")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "storm_elemental_vfx_ranged_attck_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 20
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(8)
}
tt.particle_system.scales_y = {
	0.7,
	0.7
}
tt.particle_system.scales_x = {
	0.7,
	0.7
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_nine_tailed_fox_underground_trail")

E:add_comps(tt, "pos", "particle_system", "motion", "nav_path", "main_script")

b = balance.enemies.wukong.nine_tailed_fox.teleport
tt.main_script.update = scripts.ps_nine_tailed_fox_underground_trail.update
tt.particle_system.animated = true
tt.particle_system.name = "ninetailedfox_teleport_smoke_particle_run"
tt.particle_system.loop = false
tt.particle_system.emit_duration = nil
tt.particle_system.emission_rate = 10
tt.particle_system.source_lifetime = nil
tt.particle_system.z = Z_OBJECTS
tt.particle_system.emit_area_spread = v(0, 5)
tt.damage_radius = b.damage_radius
tt.damage_min = b.damage_min
tt.damage_max = b.damage_max
tt.damage_type = b.damage_type
tt.vis_flags = F_AREA
tt.vis_bans = F_NONE
tt = E:register_t_10086("ps_storm_spirit_jump_ahead_trail_1")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.name = "stormspirit_trail_run"
tt.particle_system.loop = false
tt.particle_system.emit_duration = nil
tt.particle_system.emission_rate = 30
tt.particle_system.source_lifetime = nil
tt.particle_system.z = Z_OBJECTS
tt.particle_system.emit_area_spread = v(0, 5)
tt.particle_system.sort_y_offset = -10
tt = E:register_t_10086("ps_storm_spirit_jump_ahead_trail_2", "ps_storm_spirit_jump_ahead_trail_1")
tt.particle_system.name = "stormspirit_trail_nubes_run"
tt.particle_system.emission_rate = 12
tt.particle_system.sort_y_offset = 0
tt = E:register_t_10086("ps_water_spirit_trail_jump")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.name = "wukong_water_spirit_ranged_attck_trail_run"
tt.particle_system.loop = false
tt.particle_system.emission_rate = 20
tt.particle_system.source_lifetime = nil
tt.particle_system.z = Z_OBJECTS
tt.particle_system.emit_area_spread = v(0, 5)
tt.particle_system.track_rotation = true
tt = E:register_t_10086("ps_water_spirit_trail_swim")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.animated = false
tt.particle_system.name = "wukong_water_spirit_trail_nadar"
tt.particle_system.loop = false
tt.particle_system.emission_rate = 12
tt.particle_system.source_lifetime = nil
tt.particle_system.z = Z_DECALS
tt.particle_system.emit_area_spread = v(1, 5)
tt.particle_system.particle_lifetime = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	0.5
}
tt.particle_system.scales_x = {
	1,
	0.5
}
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t_10086("ps_storm_elemental_walk_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.animated = false
tt.particle_system.name = "storm_elemental_vfx_walk_trail_0001"
tt.particle_system.loop = false
tt.particle_system.emission_rate = 2
tt.particle_system.source_lifetime = nil
tt.particle_system.z = Z_DECALS
tt.particle_system.emit_area_spread = v(1, 3)
tt.particle_system.particle_lifetime = {
	4,
	4
}
tt.particle_system.scales_y = {
	1,
	0.5
}
tt.particle_system.scales_x = {
	1,
	0.5
}
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t_10086("ps_bullet_tower_panda_air")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "tower_pandas_projectile_air_flying"
tt.particle_system.animated = true
tt.particle_system.loop = true
tt.particle_system.emission_rate = 24
tt.particle_system.track_rotation = false
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(8)
}
tt.particle_system.z = Z_BULLET_PARTICLES
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t_10086("ps_bullet_tower_panda_fire")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "tower_pandas_trail_fire_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 24
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	fts(15),
	fts(15)
}
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E:register_t_10086("ps_wukong_nube_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "hero_wukong_trail_nube_run"
tt.particle_system.animated = true
tt.particle_system.emit_offset = v(0, 10)
tt.particle_system.emission_rate = 12
tt.particle_system.animation_fps = 15
tt.particle_system.track_rotation = false
tt.particle_system.particle_lifetime = {
	fts(19),
	fts(19)
}
tt.particle_system.z = Z_OBJECTS
tt = E:register_t_10086("ps_enemy_terracota_a")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "terracota_fx_walk_1_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 0.5
tt.particle_system.track_offset = v(0, 0)
tt.particle_system.emit_area_spread = v(10, 15)
tt.particle_system.z = Z_OBJECTS
tt.particle_system.sort_y_offset = -5
tt.particle_system.particle_lifetime = {
	fts(18),
	fts(18)
}
tt = E:register_t_10086("ps_enemy_terracota_b")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "terracota_fx_walk_2_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 1
tt.particle_system.track_offset = v(0, 0)
tt.particle_system.emit_area_spread = v(10, 15)
tt.particle_system.z = Z_OBJECTS
tt.particle_system.sort_y_offset = -5
tt.particle_system.particle_lifetime = {
	fts(18),
	fts(18)
}
tt = E:register_t_10086("ps_enemy_big_terracota_a")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "terracota_fx_walk_1_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 1
tt.particle_system.track_offset = v(10, 15)
tt.particle_system.emit_area_spread = v(30, 45)
tt.particle_system.z = Z_OBJECTS
tt.particle_system.sort_y_offset = -50
tt.particle_system.particle_lifetime = {
	fts(18),
	fts(18)
}
tt = E:register_t_10086("ps_enemy_big_terracota_b")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "terracota_fx_walk_2_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 1
tt.particle_system.track_offset = v(10, 15)
tt.particle_system.emit_area_spread = v(30, 45)
tt.particle_system.z = Z_OBJECTS
tt.particle_system.sort_y_offset = -50
tt.particle_system.particle_lifetime = {
	fts(18),
	fts(18)
}
tt.particle_system.ts_offset = 0.5
tt = E:register_t_10086("ps_enemy_demon_minotaur_charge_a")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "demon_minotaur_charge_dust_a"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 4
tt.particle_system.track_offset = v(0, 0)
tt.particle_system.z = Z_DECALS
tt.particle_system.particle_lifetime = {
	fts(14),
	fts(14)
}
tt = E:register_t_10086("ps_enemy_demon_minotaur_charge_b")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "demon_minotaur_charge_dust_b"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 3
tt.particle_system.track_offset = v(0, 20)
tt.particle_system.z = Z_DECALS
tt.particle_system.particle_lifetime = {
	fts(44),
	fts(44)
}
tt = E:register_t_10086("fx_enemy_fan_guard_melee_hit", "fx")
tt.render.sprites[1].name = "fan_guard_hit_run"
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t_10086("fx_tower_pandas_bullet_air_hit", "fx")
tt.render.sprites[1].name = "tower_pandas_projectile_air_hit_run"
tt.render.sprites[1].scale = vv(1.2)
tt.render.sprites[1].fps = 15
tt = E:register_t_10086("fx_tower_pandas_bullet_fire_hit", "fx")
tt.render.sprites[1].name = "tower_pandas_projectile_fire_hit_run"
tt.render.sprites[1].scale = vv(1.2)
tt.render.sprites[1].fps = 15
tt = E:register_t_10086("fx_tower_pandas_bullet_fire_ray", "fx")
tt.render.sprites[1].name = "tower_pandas_projectile_ray_hit_run"
tt.render.sprites[1].scale = vv(1.2)
tt.render.sprites[1].fps = 15
tt = E:register_t_10086("fx_tower_pandas_melee_air_hit", "fx")
tt.render.sprites[1].name = "tower_pandas_projectile_air_hit_run"
tt.render.sprites[1].scale = vv(1)
tt.render.sprites[1].fps = 15
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -16
tt = E:register_t_10086("fx_tower_pandas_melee_fire_hit", "fx")
tt.render.sprites[1].name = "tower_pandas_projectile_fire_hit_run"
tt.render.sprites[1].scale = vv(1)
tt.render.sprites[1].fps = 15
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -16
tt = E:register_t_10086("fx_tower_pandas_melee_fire_ray", "fx")
tt.render.sprites[1].name = "tower_pandas_projectile_ray_hit_run"
tt.render.sprites[1].scale = vv(1)
tt.render.sprites[1].fps = 15
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -16
tt = E:register_t_10086("fx_panda_smoke_level_up", "fx")
tt.render.sprites[1].name = "tower_pandas_level_up_fx_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = E:register_t_10086("fx_tower_panda_skill_red_tp_enemy_fire", "fx")
tt.render.sprites[1].name = "la_red_lvl4_tp_fire_enemy_run"
tt.render.sprites[1].anchor = v(0.52, 0.5)
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].size_scales = {
	vv(2),
	vv(2),
	vv(4)
}
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt = E:register_t_10086("fx_tower_panda_disappear_wood", "fx_fade")
tt.render.sprites[1].name = "tower_pandas_disappear_wood"
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.props[1].keys = {
	{
		1.2,
		255
	},
	{
		1.5,
		0
	}
}
tt = E:register_t_10086("fx_elemental_earth_holder_melee_hit", "fx")
tt.render.sprites[1].name = "golem_holder_hit_hit"
tt = E:register_t_10086("fx_blaze_raider_melee_hit", "fx")
tt.render.sprites[1].name = "blaze_rider_hit_run"
tt = E:register_t_10086("fx_fire_phoenix_death", "fx")
tt.render.sprites[1].name = "fire_phoenix_zhu_que_explosionfuego"
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("fx_nine_tailed_fox_hit", "fx")
tt.render.sprites[1].name = "ninetailedfox_hit_hit"
tt = E:register_t_10086("fx_nine_tailed_fox_hit_stun", "fx")
tt.render.sprites[1].name = "ninetailedfox_stun_run"
tt = E:register_t_10086("fx_nine_tailed_fox_tp_stun_1", "fx")
tt.render.sprites[1].name = "ninetailedfox_stunearea_explosion1_run"
tt.render.sprites[1].scale = vv(2)
tt = E:register_t_10086("fx_nine_tailed_fox_tp_stun_2", "fx")
tt.render.sprites[1].name = "ninetailedfox_stunearea_explosion2_run"
tt.render.sprites[1].scale = vv(2)
tt = E:register_t_10086("fx_nine_tailed_fox_tp_stun_decal", "fx")
tt.render.sprites[1].name = "ninetailedfox_stun_decal_run"
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("fx_nine_tailed_fox_summon", "fx")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.fx_nine_tailed_fox_summon.update
tt.render.sprites[1].name = "ninetailedfox_summon"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_DECALS
tt.spawn_offset = v(0, 0)
tt.spawn_time = fts(45)
tt.spawn_entity = "enemy_nine_tailed_fox"
tt = E:register_t_10086("fx_hellfire_warlock_summong_floor_staff", "fx")
tt.render.sprites[1].name = "hellfire_warlock_summon_stafx_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = E:register_t_10086("fx_hellfire_warlock_fireball_hit", "fx")
tt.render.sprites[1].name = "hellfire_warlock_hit_fireball"
tt = E:register_t_10086("fx_hellfire_warlock_melee_hit", "fx")
tt.render.sprites[1].name = "hellfire_warlock_hit_run"
tt = E:register_t_10086("fx_wuxian_bolt_hit", "fx")
tt.render.sprites[1].name = "wuxian_explosion_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -3
tt = E:register_t_10086("fx_wuxian_melee_hit", "fx")
tt.render.sprites[1].name = "wuxian_hit_mele_hit"
tt = E:register_t_10086("fx_wuxian_kamehame_hit", "fx")
tt.render.sprites[1].name = "wuxian_hit_run"
tt = E:register_t_10086("fx_storm_spirit_zap_in_out", "fx")
tt.render.sprites[1].name = "stormspirit_zap_in_out"
tt = E:register_t_10086("fx_storm_elemental_bullet_start", "fx")
tt.render.sprites[1].name = "storm_elemental_vfx_proyectile_fx_run"
tt.render.sprites[1].z = Z_BULLETS
tt = E:register_t_10086("fx_storm_elemental_bullet_hit", "fx")
tt.render.sprites[1].name = "storm_elemental_vfx_hit_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt = E:register_t_10086("decal_storm_elemental_bullet", "fx")
tt.render.sprites[1].name = "storm_elemental_vfx_explosion_proyectil"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt = E:register_t_10086("decal_storm_elemental_bullet_2", "fx")
tt.render.sprites[1].name = "storm_elemental_vfx_explosion_proyectil_decal"
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_ash_spirit_hit", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].name = "ashspirit_fx_floor_decal_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "ashspirit_fx_vfx_explosion"
tt.render.sprites[2].name = "attack_1"
tt.render.sprites[2].loop = false
tt.render.sprites[2].scale = vv(2)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = -3
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "ashspirit_fx_floor_decal_small"
tt.render.sprites[3].name = "decal"
tt.render.sprites[3].z = Z_DECALS
tt.render.sprites[3].offset = v(0, 0)
tt.render.sprites[3].delay_start = fts(0)
tt.render.sprites[3].hidden = true
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset = v(-30, 20)
tt.render.sprites[4].delay_start = fts(3)
tt.render.sprites[5] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[5].offset = v(0, -20)
tt.render.sprites[5].delay_start = fts(0)
tt.render.sprites[6] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[6].offset = v(30, 13)
tt.render.sprites[6].delay_start = fts(3)
tt.tween.remove = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1.9,
		255
	},
	{
		2.3,
		0
	}
}
tt = E:register_t_10086("fx_redboy_teen_floor_fire_decal", "fx")
tt.render.sprites[1].prefix = "teen_redboy_decalDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("fx_redboy_teen_hand", "fx")
tt.render.sprites[1].prefix = "teen_redboy_uiexploDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_EFFECTS
tt = E:register_t_10086("fx_redboy_teen_hit", "fx")
tt.render.sprites[1].prefix = "teen_redboy_hitDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("fx_redboy_screen", "fx")
tt.render.sprites[1].prefix = "dragon_redboy_screenDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_SCREEN_FIXED
tt = E:register_t_10086("fx_redboy_teen_smoke", "fx")
tt.render.sprites[1].prefix = "teen_redboy_smokeDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("fx_redboy_fireabsorb_decal", "fx")
tt.render.sprites[1].prefix = "teen_redboy_decal_fireabsorbDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("fx_citizen_3_melee_1_hit", "fx")
tt.render.sprites[1].name = "pueblerino_3_hit_1_run"
tt = E:register_t_10086("fx_citizen_4_melee_1_hit", "fx")
tt.render.sprites[1].name = "pueblerino_4_hit_1_run"
tt = E:register_t_10086("fx_water_sorceress_bolt_hit", "fx")
tt.render.sprites[1].name = "watersorceress_projectile_hit_run"
tt = E:register_t_10086("fx_terracota_hit", "fx")
tt.render.sprites[1].name = "terracota_fx_hit_run"
tt = E:register_t_10086("fx_demon_minotaur_hit", "fx")
tt.render.sprites[1].name = "demon_minotaur_hit_run"
tt = E:register_t_10086("fx_demon_minotaur_rebote", "fx")
tt.render.sprites[1].name = "demon_minotaur_rebote_fx_run"
tt = E:register_t_10086("fx_hero_wukong_clones_spawn", "fx")
tt.render.sprites[1].name = "hero_wukong_clone_smoke_in"
tt.render.sprites[1].sort_y_offset = -5
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("fx_hero_wukong_giant_staff", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.fx_hero_wukong_giant_staff.update
tt.render.sid_staff = 1
tt.render.sid_decal = 2
tt.render.sprites[tt.render.sid_staff].prefix = "hero_wukong_weapon"
tt.render.sprites[tt.render.sid_staff].name = "in"
tt.render.sprites[tt.render.sid_staff].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_staff].scale = vv(2)
tt.render.sprites[tt.render.sid_decal] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_decal].name = "hero_wukong_baston_crack"
tt.render.sprites[tt.render.sid_decal].animated = false
tt.render.sprites[tt.render.sid_decal].z = Z_DECALS
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
		2.5,
		0
	}
}
tt.tween.props[1].sprite_id = tt.render.sid_decal
tt.tween.disabled = true
tt.tween.remove = true
tt = E:register_t_10086("fx_zhu_apprentice_respawn", "fx")
tt.render.sprites[1].name = "hero_wukong_woolong_spawn_FX_spawn"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt = E:register_t_10086("fx_hero_wukong_giant_staff_dust_cloud_back", "fx")
tt.render.sprites[1].name = "hero_wukong_back_dust_in"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 10
tt.render.sprites[1].scale = vv(3)
tt = E:register_t_10086("fx_hero_wukong_giant_staff_dust_cloud_front", "fx")
tt.render.sprites[1].name = "hero_wukong_smoke_in"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -30
tt.render.sprites[1].scale = vv(3)
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "hero_wukong_dust_up_in"
tt.render.sprites[2].sort_y_offset = -35
tt = E:register_t_10086("fx_hero_wukong_hit_2", "fx")
tt.render.sprites[1].name = "hero_wukong_hit_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -35
tt = E:register_t_10086("fx_hero_wukong_hit", "fx")
tt.render.sprites[1].name = "hero_wukong_hit_wukong_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -35
tt = E:register_t_10086("fx_mecanicas_ray_spawner", "fx")
tt.render.sprites[1].name = "vfx_mecanicas_ray_spawner_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[1].scale = vv(1.5)
tt = E:register_t_10086("fx_stage_34_fuentes_splash", "fx")
tt.render.sprites[1].prefix = "stage_34_agua_splash"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt = E:register_t_10086("fx_stage_34_fuentes_splash_barro", "fx_stage_34_fuentes_splash")

E:add_comps(tt, "sound_events")

tt.render.sprites[1].prefix = "stage_34_barro_splash"
tt.sound_events.insert = "EnemyBossPrincessMudPoolSummon"
tt = E:register_t_10086("fx_stage_35_cannonball", "decal_scripted")
tt.main_script.update = scripts.fx_stage_35_cannonball.update
tt.render.sprites[1].prefix = "stage5_destruccion_holderDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -30
tt.escombro_camino = "decal_stage_35_escombros_cannonball_camino"
tt.escombro_holder = "decal_stage_35_escombros_cannonball_holder"
tt = E:register_t_10086("fx_stage_35_cannonball_open_path", "decal_scripted")
tt.main_script.update = scripts.fx_stage_35_cannonball_open_path.update
tt.render.sprites[1].prefix = "stage_5_pokebola_tntDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -130
tt = E:register_t_10086("fx_stage_35_cannonball_block_path", "decal_scripted")
tt.main_script.update = scripts.fx_stage_35_cannonball_block_path.update
tt.render.sprites[1].prefix = "stage_5_bloqueo_pathDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -450
tt = E:register_t_10086("fx_stage_35_small_spawner_fx", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "stage_5_spawner_fxDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].delay_start = fts(2)
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("fx_stage_31_fireball_a", "fx")
tt.render.sprites[1].prefix = "stage_31_fireball_ADef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.kill_area_id = 1
tt = E:register_t_10086("fx_stage_31_fireball_b", "fx")
tt.render.sprites[1].prefix = "stage_31_fireball_BDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.kill_area_id = 2
tt = E:register_t_10086("fx_stage_31_fireball_c", "fx")
tt.render.sprites[1].prefix = "stage_31_fireball_CDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.kill_area_id = 3
tt = E:register_t_10086("fx_stage_32_dragon_mouth_fire_left", "fx")
tt.render.sprites[1].prefix = "dragon_redboy_stun_vfx_01Def"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = DAMAGE_TRUE
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("fx_stage_32_dragon_mouth_fire_right", "fx_stage_32_dragon_mouth_fire_left")
tt.render.sprites[1].prefix = "dragon_redboy_stun_vfx_02Def"
tt = E:register_t_10086("fx_stage_32_dragon_down_splash", "fx")
tt.render.sprites[1].prefix = "dragon_redboy_splashDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -20
tt.render.sprites[1].offset = v(0, 15)
tt = E:register_t_10086("fx_stage_32_redboy_transform_fire", "fx")
tt.render.sprites[1].prefix = "dragon_redboy_transformDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(0, -30)
tt = E:register_t_10086("fx_stage_32_fireball_right", "decal_scripted")
b = balance.enemies.wukong.boss_dragon.campaign.pre_fight_meteorite
tt.main_script.update = scripts.fx_stage_32_fireball_right.update
tt.render.sprites[1].prefix = "stage_32_fireball_rDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "stage_31_sign_decal_rDef"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].exo = true
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_DECALS
tt.shake_time = 150
tt.flags_meteorite = bor(F_RANGED, F_AREA)
tt.bans_meteorite = bor(F_BOSS)
tt.ni_step = 3
tt.path = 3
tt.kill_radius = 80
tt.force_move_impact_positions = {
	v(800, 326)
}
tt.fire_duration = b.fire_duration
tt.path_fires = {
	[3] = {
		finish = 100,
		begin = 20
	},
	[4] = {
		finish = 60,
		begin = 50
	}
}
tt = E:register_t_10086("fx_stage_32_fireball_left", "fx_stage_32_fireball_right")
tt.render.sprites[1].prefix = "stage_32_fireball_lDef"
tt.render.sprites[2].prefix = "stage_31_sign_decal_lDef"
tt.path = 2
tt.force_move_impact_positions = {
	v(207, 226)
}
tt.path_fires = {
	[2] = {
		finish = 120,
		begin = 20
	},
	{
		finish = 50,
		begin = 40
	}
}
tt = E:register_t_10086("fx_stage_35_fireball_left", "fx_stage_32_fireball_right")
tt.render.sprites[1].prefix = "stage_35_fireball_lDef"
tt.render.sprites[2].prefix = "stage5_samadhi_2Def"
tt.kill_area_id = 1
tt.path_fires = {
	{
		finish = 180,
		begin = 20
	}
}
tt = E:register_t_10086("fx_stage_35_fireball_right", "fx_stage_32_fireball_right")
tt.render.sprites[1].prefix = "stage_35_fireball_rDef"
tt.render.sprites[2].prefix = "stage5_samadhi_1Def"
tt.kill_area_id = 2
tt.path_fires = {
	[2] = {
		finish = 130,
		begin = 20
	}
}
tt = E:register_t_10086("fx_stage_32_lava_splash", "fx")
tt.render.sprites[1].prefix = "stage_32_lava_splashDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = -40
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = vv(0.5599999999999999)
tt = E:register_t_10086("fx_stage_32_lava_splash_2", "fx_stage_32_lava_splash")
tt.render.sprites[1].flip_x = true
tt = E:register_t_10086("fx_stage_32_lava_splash_big", "fx")
tt.render.sprites[1].prefix = "stage_32_lava_splash_bigDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = -40
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = vv(0.7)
tt = E:register_t_10086("fx_stage_32_lava_splash_big_2", "fx_stage_32_lava_splash_big")
tt.render.sprites[1].flip_x = true
tt = E:register_t_10086("fx_stage_32_lava_geyser", "fx")
tt.render.sprites[1].prefix = "dragon_cracks_geyserDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("fx_stage_33_house_destroy", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "vfx_mecanicas_destroy_house_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = E:register_t_10086("fx_stage_35_lava_splash", "fx")
tt.render.sprites[1].prefix = "stage_5_splash_lavaDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = -40
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = vv(0.5599999999999999)
tt = E:register_t_10086("fx_stage_35_lava_splash_big", "fx_stage_35_lava_splash")
tt.render.sprites[1].scale = vv(1)
tt = E:register_t_10086("fx_stage_35_water_splash", "fx_stage_35_lava_splash")
tt.render.sprites[1].prefix = "stage_5_splash_aguaDef"
tt = E:register_t_10086("fx_stage_35_water_splash_big", "fx_stage_35_water_splash")
tt.render.sprites[1].scale = vv(1)
tt = E:register_t_10086("fx_water_spirit_splash", "fx")
tt.render.sprites[1].name = "wukong_water_spirit_fx_splash"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt = E:register_t_10086("fx_water_spirit_charco_caida", "fx")
tt.render.sprites[1].name = "wukong_water_spirit_charco_caida_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("abstract_fx_mod_in_hit_pos", "modifier")

E:add_comps(tt, "render")

tt.main_script.update = scripts.mod_fx_in_hit_pos.update
tt.multi_sprite_fx_update = scripts.multi_sprite_fx.update
tt = E:register_t_10086("fx_water_spirit_hit", "abstract_fx_mod_in_hit_pos")
tt.render.sprites[1].name = "wukong_water_spirit_hit_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = E:register_t_10086("decal_tower_panda_skill_red_tp_enemy_fire", "fx")
tt.render.sprites[1].name = "tower_pandas_red_lvl4_tp_decal_enemy_run"
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].size_scales = {
	vv(2),
	vv(2),
	vv(2.5)
}
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_tower_panda_skill_red_tp_soldier_fire", "fx")
tt.render.sprites[1].name = "tower_pandas_red_lvl4_tp_decal_run"
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("decal_zhu_apprentice_area_attack", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.decal_zhu_apprentice_area_attack.update
tt.render.sprites[1].prefix = "hero_wukong_dust_up"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].sort_y_offset = -35
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = vv(1.5)
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].prefix = nil
tt.render.sprites[2].name = "hero_wukong_woolong_decal"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].scale = vv(0.7)
tt.render.sprites[2].sort_y_offset = 0
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1,
		255
	},
	{
		1.5,
		0
	}
}
tt.tween.props[1].sprite_id = 2
tt.tween.disabled = false
tt.tween.remove = true
tt = E:register_t_10086("decal_hero_wukong_ranged_attack_staff", "decal_scripted")

E:add_comps(tt, "tween")

b = balance.heroes.hero_wukong.pole_ranged
tt.main_script.update = scripts.decal_hero_wukong_ranged_attack_staff.update
tt.render.sprites[1].prefix = "hero_wukong_attack_range"
tt.render.sprites[1].name = "projectile"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_OBJECTS
tt.decal = "decal_hero_wukong_ranged_attack_staff_decal"
tt.mod_stun = "mod_hero_wukong_ranged_pole_stun"
tt.damage_radius = b.damage_radius
tt.damage_flags = bor(F_AREA)
tt.damage_bans = bor(F_FLYING)
tt.damage_type = b.damage_type
tt.damage_max = nil
tt.damage_min = nil
tt.tween.props[1].keys = {
	{
		fts(0),
		255
	},
	{
		fts(56),
		255
	},
	{
		fts(62),
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 1
tt.tween.disabled = true
tt.tween.remove = true
tt = E:register_t_10086("decal_hero_wukong_ranged_attack_staff_decal", "decal_tween")

E:add_comps(tt, "tween")

tt.render.sprites[1].name = "hero_wukong_weapon_decal_decal"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		fts(0),
		255
	},
	{
		fts(45),
		255
	},
	{
		fts(52),
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 1
tt.tween.disabled = false
tt.tween.remove = true
tt = E:register_t_10086("decal_dlc_wukong_flaming_ground", "decal_scripted")

E:add_comps(tt, "auras")

tt.main_script.insert = scripts.decal_dlc_wukong_flaming_ground.insert
tt.main_script.update = scripts.decal_dlc_wukong_flaming_ground.update
tt.in_anim = "in"
tt.loop_anim = "idle"
tt.end_anim = "out"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].prefix = "fire_phoenix_zhu_que_fuego_camino"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.duration = nil
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_wukong_fire_ground_dps"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E:clone_c("aura_attack")
tt.auras.list[2].name = "aura_wukong_fire_ground_sprint"
tt.auras.list[2].cooldown = 0
tt.auras.list[3] = E:clone_c("aura_attack")
tt.auras.list[3].name = "aura_wukong_fire_ground_healing"
tt.auras.list[3].cooldown = 0
tt.auras.list[4] = E:clone_c("aura_attack")
tt.auras.list[4].name = "aura_wukong_fire_ground_wuxian"
tt.auras.list[4].cooldown = 0
tt.is_flaming_ground = true
tt = E:register_t_10086("decal_dlc_wukong_flaming_ground_small", "decal_dlc_wukong_flaming_ground")
tt.render.sprites[1].prefix = "fire_phoenix_zhu_que_fuego_camino_small"
tt = E:register_t_10086("decal_fire_phoenix_flaming_ground", "decal_dlc_wukong_flaming_ground")
b = balance.enemies.wukong.fire_phoenix.flaming_ground
tt.duration = b.duration
tt = E:register_t_10086("decal_burning_treant_flaming_ground", "decal_dlc_wukong_flaming_ground")
b = balance.enemies.wukong.burning_treant.area_attack.flaming_ground
tt.duration = b.duration
tt.render.sprites[1].prefix = "burning_treant_area_attk"
tt = E:register_t_10086("decal_hellfire_warlock_flaming_ground", "decal_dlc_wukong_flaming_ground")
b = balance.enemies.wukong.hellfire_warlock.ranged.flaming_ground
tt.duration = b.duration
tt = E:register_t_10086("decal_wuxian_flaming_ground", "decal_dlc_wukong_flaming_ground")
b = balance.enemies.wukong.wuxian.ranged_attack.flaming_ground
tt.duration = b.duration
tt = E:register_t_10086("decal_fire_fox_flaming_ground", "decal_dlc_wukong_flaming_ground")
b = balance.enemies.wukong.fire_fox.flaming_ground
tt.duration = b.duration
tt.sid_explotion_aura = #tt.auras.list + 1
tt.auras.list[tt.sid_explotion_aura] = E:clone_c("aura_attack")
tt.auras.list[tt.sid_explotion_aura].name = "aura_fire_fox_explotion_dps"
tt.auras.list[tt.sid_explotion_aura].cooldown = 0
tt = E:register_t_10086("decal_stage_32_boss_fissure_ability", "decal_dlc_wukong_flaming_ground")
tt.main_script.update = scripts.decal_stage_32_boss_fissure_ability.update
tt.render.sprites[1].prefix = "dragon_cracks_floorDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].pos = v(512, 384)
tt.render.sprites[1].z = Z_DECALS - 1
tt.fx = "fx_stage_32_lava_geyser"
tt.idle_anim = "idle"
tt.in_anim = "active_in"
tt.loop_anim = "active_loop"
tt.end_anim = "active_end"
tt.max_geysers = 5
tt.geyser_delay_max = 0.5
tt.geyser_delay_min = 0.2
tt = E:register_t_10086("decal_water_sorceress_heal_wave", "decal_scripted")
tt.main_script.insert = scripts.decal_water_sorceress_heal_wave.insert
tt.main_script.update = scripts.decal_water_sorceress_heal_wave.update
tt.handle_heal = nil
tt.pi = nil
tt.spi = nil
tt.ni = nil
tt.nodes_range = nil
tt.nodes_advance = 5
tt.trail_duration = 0.5
tt.hit_targets = {}
tt.vis_flags = 0
tt.vis_bans = 0
tt.mod = "mod_water_sorceress_heal_wave_healing"
tt.mod_damage = "mod_water_sorceress_heal_wave_dps"
tt.decal_mod_range = 45
tt.render.sid_wave = 1
tt.render.sprites[tt.render.sid_wave].prefix = "watersorceress_wave"
tt.render.sprites[tt.render.sid_wave].name = "run"
tt.render.sprites[tt.render.sid_wave].animated = true
tt.render.sprites[tt.render.sid_wave].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_wave].offset = v(0, 5)
tt.render.sid_trail = 2
tt.render.sprites[tt.render.sid_trail] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_trail].prefix = "watersorceress_trail_wave"
tt.render.sprites[tt.render.sid_trail].name = "idle"
tt.render.sprites[tt.render.sid_trail].animated = true
tt.render.sprites[tt.render.sid_trail].z = Z_DECALS
tt.scale_max = 1
tt.scale_min = 0.9
tt.center_gravity = vv(0.5)
tt.wave_template = "decal_water_sorceress_heal_wave"
tt.wave_small_deco_template = "decal_water_sorceress_heal_wave_small_deco"
tt = E:register_t_10086("decal_water_sorceress_heal_wave_small_deco", "decal_tween")

E:add_comps(tt, "main_script")

tt.main_script.insert = scripts.decal_water_sorceress_heal_wave.insert
tt.render.sprites[1].prefix = "watersorceress_trail_wave"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.1,
		150
	}
}
tt.center_gravity = v(0.5, 1.2)
tt.scale_max = 0.7
tt.scale_min = 0.5
tt.tween.remove = false
tt = E:register_t_10086("decal_redboy_teen_skyrock", "decal_scripted")
tt.main_script.update = scripts.decal_redboy_teen_skyrock.update
tt.render.sprites[1].prefix = "teen_redboy_skyrockDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.entity = "enemy_ash_spirit"
tt = E:register_t_10086("decal_storm_elemental_area_melee", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "storm_elemental_vfx_area_attack_crack"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "storm_elemental_vfx_asst_area_attack"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].scale = vv(2)
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(13),
		255
	},
	{
		fts(46),
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_demon_minotaur_area_crack", "decal_tween")
tt.render.sprites[1].name = "demon_minotaur_decal_crack"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		1,
		255
	},
	{
		2.5,
		0
	}
}
tt.tween.remove = true
tt = E:register_t_10086("decal_demon_minotaur_area_smoke", "fx")
tt.render.sprites[1].name = "demon_minotaur_smoke_hit_run"
tt.render.sprites[1].sort_y_offset = -5
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("stage_31_mask_burned_01", "decal")

E:add_comps(tt, "editor", "editor_script")

tt.render.sprites[1].name = "stage_31_mask_burned_01"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -60
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].hidden = true
tt.show_in_editor = true
tt.editor_script.insert = scripts.editor_mask.insert
tt = E:register_t_10086("stage_31_mask_burned_02", "stage_31_mask_burned_01")
tt.render.sprites[1].name = "stage_31_mask_burned_02"
tt.render.sprites[1].sort_y_offset = -112
tt = E:register_t_10086("stage_31_mask_burned_03", "stage_31_mask_burned_01")
tt.render.sprites[1].name = "stage_31_mask_burned_03"
tt.render.sprites[1].sort_y_offset = -80
tt = E:register_t_10086("stage_31_mask_shadow_top", "decal")
tt.render.sprites[1].prefix = "stage_31_shadowDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E:register_t_10086("stage_31_exo_fire_a", "decal")

E:add_comps(tt, "editor", "editor_script")

tt.render.sprites[1].prefix = "stage_31_fire_ADef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 1
tt.render.sprites[1].hidden = true
tt.show_in_editor = true
tt.editor_script.insert = scripts.editor_mask.insert
tt = E:register_t_10086("stage_31_exo_fire_b", "stage_31_exo_fire_a")
tt.render.sprites[1].prefix = "stage_31_fire_BDef"
tt = E:register_t_10086("stage_31_exo_fire_c", "stage_31_exo_fire_a")
tt.render.sprites[1].prefix = "stage_31_fire_CDef"

for i = 1, 3 do
	tt = E:register_t_10086("stage_31_exo_forest_" .. i, "decal")

	E:add_comps(tt, "editor", "editor_script")

	tt.render.sprites[1].prefix = "stage_31_forest_0" .. i .. "Def"
	tt.render.sprites[1].name = "loop"
	tt.render.sprites[1].animated = true
	tt.render.sprites[1].exo = true
	tt.show_in_editor = false
	tt.editor_script.insert = scripts.editor_mask.insert

	if i == 3 then
		tt.render.sprites[1].z = Z_OBJECTS + 1
		tt.render.sprites[1].sort_y_offset = -700
	else
		tt.render.sprites[1].z = Z_DECALS
	end
end

for lyr_nmbr = 1, 7 do
	tt = E:register_t_10086("stage_31_exo_waterfall_layer_" .. lyr_nmbr, "decal")
	tt.render.sprites[1].prefix = "stage_31_waterfall_layer_" .. lyr_nmbr .. "Def"
	tt.render.sprites[1].name = "loop"
	tt.render.sprites[1].animated = true
	tt.render.sprites[1].exo = true
	tt.render.sprites[1].z = Z_OBJECTS

	if lyr_nmbr == 1 then
		tt.render.sprites[1].sort_y_offset = -201
	elseif lyr_nmbr == 2 then
		tt.render.sprites[1].sort_y_offset = -200
	elseif lyr_nmbr == 3 then
		tt.render.sprites[1].sort_y_offset = 3
	elseif lyr_nmbr == 4 then
		tt.render.sprites[1].sort_y_offset = 4
	elseif lyr_nmbr == 5 then
		tt.render.sprites[1].sort_y_offset = 5
	elseif lyr_nmbr == 6 then
		tt.render.sprites[1].sort_y_offset = 220
	elseif lyr_nmbr == 7 then
		tt.render.sprites[1].sort_y_offset = 2001
	end
end

tt = RT("decal_generic_kill_area")

AC(tt, "pos", "editor", "editor_script")

tt.kill_area_fn = scripts.decal_generic_kill_area.kill_area_fn
tt.kill_radius = 200
tt.kill_area_id = 1
tt.editor.components = {
	"render"
}
tt.editor.overrides = {
	["render.sprites[1].animated"] = false,
	["render.sprites[1].name"] = "editor_red_circle_filled"
}
tt.editor.props = {
	{
		"kill_radius",
		PT_NUMBER,
		5,
		{
			50,
			800
		}
	},
	{
		"kill_area_id",
		PT_NUMBER
	}
}
tt.editor_script.update = scripts.editor_decal_generic_kill_area.update
tt = RT("decal_generic_kill_area_rect")

AC(tt, "pos", "editor", "editor_script")

tt.kill_area_fn = scripts.decal_generic_kill_area_rect.kill_area_fn
tt.kill_size = v(100, 100)
tt.kill_area_id = 1
tt.editor.components = {
	"render"
}
tt.editor.overrides = {
	["render.sprites[1].animated"] = false,
	["render.sprites[1].name"] = "editor_red_square_filled"
}
tt.editor.props = {
	{
		"kill_size",
		PT_COORDS,
		5,
		{
			{
				50,
				800
			},
			{
				50,
				800
			}
		}
	},
	{
		"kill_area_id",
		PT_NUMBER
	}
}
tt.editor_script.update = scripts.editor_decal_generic_kill_area_rect.update
tt = E:register_t_10086("stage_32_mask_heads", "decal")
tt.render.sprites[1].name = "stage_32_masks_layer_01"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 160
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("stage_32_mask_heads_2", "stage_32_mask_heads")
tt.render.sprites[1].flip_x = true
tt = E:register_t_10086("stage_32_mask_front", "decal")
tt.render.sprites[1].prefix = "stage_32_lava_shadow_dragonDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E:register_t_10086("stage_32_mask_waterfall_1", "decal")
tt.render.sprites[1].prefix = "stage_32_lava_waterfall_1Def"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = E:register_t_10086("stage_32_mask_waterfall_2", "stage_32_mask_waterfall_1")
tt.render.sprites[1].prefix = "stage_32_lava_waterfall_2Def"
tt.render.sprites[1].sort_y_offset = 175
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("stage_32_mask_waterfall_3", "stage_32_mask_waterfall_2")
tt.render.sprites[1].prefix = "stage_32_lava_waterfall_3Def"
tt = E:register_t_10086("stage_32_mask_lava_bubbles", "decal")
tt.render.sprites[1].prefix = "stage_32_lava_bubbleDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = 176
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("stage_32_mask_lava_rocks", "decal")
tt.render.sprites[1].prefix = "stage_32_rockDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("stage_32_mask_fire_decals", "decal")
tt.render.sprites[1].prefix = "stage_32_lava_buffDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("stage_33_mask_props", "decal")
tt.render.sprites[1].prefix = "stage_33_anim_propsDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("stage_33_mask_water_small", "decal")
tt.render.sprites[1].prefix = "stage_33_olas_chicasDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND - 1
tt = E:register_t_10086("stage_33_mask_water_big", "decal")
tt.render.sprites[1].prefix = "stage_33_olas_grandesDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_BACKGROUND - 2
tt = E:register_t_10086("stage_33_mask_1", "decal")
tt.render.sprites[1].name = "stage33_mask_1_casa_grande"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.pos = v(512, 384)
tt.render.sprites[1].sort_y_offset = 550 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_1_destroyed", "stage_33_mask_1")
tt.render.sprites[1].name = "stage 33_mask_intersection"
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("stage_33_mask_2", "stage_33_mask_1")
tt.render.sprites[1].name = "stage33_mask_2_casita"
tt.render.sprites[1].sort_y_offset = 581 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_3", "stage_33_mask_1")
tt.render.sprites[1].name = "stage33_mask_3_casita"
tt.render.sprites[1].sort_y_offset = 544 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_4", "stage_33_mask_1")
tt.render.sprites[1].name = "stage33_mask_4_plataforma"
tt.render.sprites[1].sort_y_offset = 371 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_5", "stage_33_mask_1")
tt.render.sprites[1].name = "stage33_mask_5_carpa"
tt.render.sprites[1].sort_y_offset = 365 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_6", "stage_33_mask_1")
tt.render.sprites[1].name = "stage33_mask_6_casita"
tt.render.sprites[1].sort_y_offset = 374 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_7", "stage_33_mask_1")
tt.render.sprites[1].name = "stage33_mask_7_casita"
tt.render.sprites[1].sort_y_offset = 374 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_8", "stage_33_mask_1")
tt.render.sprites[1].name = "stage33_mask_8_casitas"
tt.render.sprites[1].sort_y_offset = 530 - tt.pos.y
tt = E:register_t_10086("stage_33_mask_9", "stage_33_mask_1")

E:add_comps(tt, "editor")

tt.render.sprites[1].name = "stage33_mask_9_modos_relleno_holders"
tt.render.sprites[1].sort_y_offset = 450 - tt.pos.y
tt = E:register_t_10086("stage_33_house_destroyed_decal_1", "decal")
tt.render.sprites[1].name = "stage33_casa_holder_escombros_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5760714285714286, 0.3502604166666667)
tt = E:register_t_10086("stage_33_house_destroyed_decal_2", "decal")
tt.render.sprites[1].name = "stage33_casa_holder_escombros_2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.3246428571428571, 0.23697916666666666)
tt = E:register_t_10086("stage_33_house_destroyed_decal_3", "decal")
tt.render.sprites[1].name = "stage33_casa_holder_escombros_3"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.7917857142857143, 0.69140625)
tt = E:register_t_10086("stage_33_citizen_house_1", "decal_scripted")
tt.main_script.update = scripts.stage_33_citizen_house.update
tt.open_door = scripts.stage_33_citizen_house.open_door
tt.render.sid_base = 1
tt.render.sid_door = 2
tt.render.sid_floor = 3
tt.render.sprites[tt.render.sid_base].name = "stage33_casa1_pescadores_base"
tt.render.sprites[tt.render.sid_base].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_base].animated = false
tt.render.sprites[tt.render.sid_base].sort_y_offset = -10
tt.render.sprites[tt.render.sid_door] = table.deepclone(tt.render.sprites[tt.render.sid_base])
tt.render.sprites[tt.render.sid_door].prefix = "stage33_casa1_pescadores_door"
tt.render.sprites[tt.render.sid_door].name = "open"
tt.render.sprites[tt.render.sid_door].animated = true
tt.render.sprites[tt.render.sid_door].sort_y_offset = -11
tt.render.sprites[tt.render.sid_floor] = table.deepclone(tt.render.sprites[tt.render.sid_base])
tt.render.sprites[tt.render.sid_floor].name = "stage33_casa1_pescadores_sombra"
tt.render.sprites[tt.render.sid_floor].z = Z_DECALS
tt.render.sprites[tt.render.sid_floor].sort_y_offset = 0
tt = E:register_t_10086("stage_33_citizen_house_2", "stage_33_citizen_house_1")
tt.render.sprites[tt.render.sid_base].name = "stage33_casa2_pescadores_base"
tt.render.sprites[tt.render.sid_door].prefix = "stage33_casa2_pescadores_door"
tt.render.sprites[tt.render.sid_door].sort_y_offset = 0
tt.render.sprites[tt.render.sid_floor].name = "stage33_casa2_pescadores_sombra"
tt = E:register_t_10086("controller_stage_34_fuentes")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_34_fuentes.update
tt.nodes_range = 15
tt.open_duration = 3
tt = E:register_t_10086("decal_stage_34_fuente_1", "decal_scripted")

E:add_comps(tt, "events")

tt.start_remolino = scripts.decal_stage_34_fuente.start_remolino
tt.end_remolino = scripts.decal_stage_34_fuente.end_remolino
tt.main_script.update = scripts.decal_stage_34_fuente.update
tt.events.list[1].name = "fuente_remolino_start"
tt.events.list[1].on_event = scripts.decal_stage_34_fuente.on_event_start
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "fuente_remolino_end"
tt.events.list[2].on_event = scripts.decal_stage_34_fuente.on_event_end
tt.event_listen_number = 1
tt.remolino_count = 0
tt.render.sprites[1].prefix = "stage_34_fuente_1Def"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.connections = {
	{
		nil,
		12
	}
}
tt.sound_mud_pool_transformation = "EnemyBossPrincessMudPoolTransformation"
tt = E:register_t_10086("decal_stage_34_fuente_2", "decal_stage_34_fuente_1")
tt.event_listen_number = 2
tt.render.sprites[1].prefix = "stage_34_fuente_2Def"
tt.connections = {
	{
		3,
		9
	},
	{
		4,
		10
	},
	{
		5,
		11
	}
}
tt = E:register_t_10086("decal_stage_34_fuente_3", "decal_stage_34_fuente_1")
tt.event_listen_number = 3
tt.render.sprites[1].prefix = "stage_34_fuente_4Def"
tt.connections = {
	{
		6,
		9
	},
	{
		7,
		10
	},
	{
		8,
		12
	}
}
tt = E:register_t_10086("decal_stage_34_fuente_4", "decal_stage_34_fuente_1")
tt.event_listen_number = 4
tt.render.sprites[1].prefix = "stage_34_fuente_5Def"
tt.connections = {
	{
		nil,
		9
	}
}
tt = E:register_t_10086("decal_stage_34_fuente_5", "decal_stage_34_fuente_1")
tt.event_listen_number = 5
tt.render.sprites[1].prefix = "stage_34_fuente_6Def"
tt.connections = {
	{
		nil,
		10
	},
	{
		nil,
		11
	}
}
tt = E:register_t_10086("decal_stage_34_fuente_6", "decal_stage_34_fuente_1")
tt.event_listen_number = 6
tt.render.sprites[1].prefix = "stage_34_fuente_3Def"
tt.connections = nil
tt = E:register_t_10086("decal_stage_34_mask_2", "decal")
tt.render.sprites[1].name = "mascara2_puertas"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -100
tt = E:register_t_10086("decal_stage_34_mask_3", "decal")
tt.render.sprites[1].name = "mascara3_gazebo"
tt.render.sprites[1].animated = false
tt = E:register_t_10086("decal_stage_34_mask_cascadas_1", "decal")
tt.render.sprites[1].name = "stage_34_cascadas_1_run"
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt = E:register_t_10086("decal_stage_34_mask_cascadas_2", "decal_stage_34_mask_cascadas_1")
tt.render.sprites[1].name = "stage_34_cascadas_2_run"
tt = E:register_t_10086("decal_stage_34_mask_cascadas_3", "decal_stage_34_mask_cascadas_1")
tt.render.sprites[1].name = "stage_34_cascadas_3_run"
tt = E:register_t_10086("decal_stage_34_mask_cascadas_6", "decal_stage_34_mask_cascadas_1")
tt.render.sprites[1].name = "stage_34_cascadas_6_run"
tt = E:register_t_10086("decal_stage_34_easter_egg_mono", "decal_scripted")

E:add_comps(tt, "ui")

tt.main_script.update = scripts.decal_stage_34_easter_egg_mono.update
tt.render.sprites[1].prefix = "wkstatue_sixear"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "wkstatue_ofrendas"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_EFFECTS
tt.render.sprites[2].offset = v(12, -12)
tt.ui.click_rect = r(-30, -20, 60, 60)
tt = E:register_t_10086("stage_34_nubes_camino", "decal")
tt.render.sprites[1].prefix = "stage_4_nubescaminoDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("stage_34_nubes", "decal")
tt.render.sprites[1].prefix = "stage_4_nubesDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_35_mask_boss_bull", "decal")
tt.render.sprites[1].name = "stage35_mask_boss"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 200
tt = E:register_t_10086("decal_stage_35_mask_boss_bull_left", "decal")
tt.render.sprites[1].name = "stage35_mask_shadow_creeps"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_35_mask_boss_bull_right", "decal_stage_35_mask_boss_bull_left")
tt.render.sprites[1].flip_x = true
tt = E:register_t_10086("decal_stage_35_mask_path_open", "decal")
tt.render.sprites[1].name = "stage35_mask_path_open"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("stage_35_bloqueo_path", "decal")
tt.render.sprites[1].prefix = "stage_5_bloqueo_pathDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt = E:register_t_10086("decal_stage_35_mask_redboy_top", "decal")
tt.render.sprites[1].name = "stage35_mask_bosses"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -86
tt = E:register_t_10086("decal_stage_35_mask_princess_top", "decal_stage_35_mask_redboy_top")
tt.render.sprites[1].flip_x = true
tt = E:register_t_10086("decal_stage_35_mask_redboy_bottom", "decal")
tt.render.sprites[1].name = "stage35_mask_mask_creeps"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t_10086("decal_stage_35_mask_princess_bottom", "decal_stage_35_mask_redboy_bottom")
tt.render.sprites[1].flip_x = true
tt = E:register_t_10086("decal_stage_35_escombros_holder_1", "decal")
tt.render.sprites[1].name = "stage35_escombros_holder_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].offset = v(2, -16)
tt = E:register_t_10086("decal_stage_35_escombros_holder_2", "decal")
tt.render.sprites[1].name = "stage35_escombros_holder_2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].offset = v(0, -3)
tt = E:register_t_10086("decal_stage_35_escombros_holder_3", "decal")
tt.render.sprites[1].name = "stage35_escombros_holder_3"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].offset = v(0, 0)
tt = E:register_t_10086("decal_stage_35_escombros_cannonball_camino", "decal_tween")
tt.render.sprites[1].name = "destruccion_holder_escombros_camino"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		14,
		255
	},
	{
		16,
		0
	}
}
tt.tween.remove = true
tt.tween.disabled = false
tt = E:register_t_10086("decal_stage_35_escombros_cannonball_holder", "decal_stage_35_escombros_cannonball_camino")
tt.render.sprites[1].name = "destruccion_holder_escombros_oro"
tt.render.sprites[1].offset = v(0, 20)
tt = E:register_t_10086("decal_stage_35_fume_entradas", "decal_scripted")
tt.main_script.update = scripts.decal_stage_35_fume_entradas.update
tt.render.sprites[1].prefix = "stage_35_fumeDef"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt.render.sprites[1].animated = true
tt = E:register_t_10086("decal_hellfire_warlock_summon_decal", "decal_scripted")
tt.main_script.update = scripts.decal_hellfire_warlock_summon_decal.update
tt.render.sprites[1].prefix = "hellfire_warlock_summon_decal"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("tower_holder_elemental", "tower_holder")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.tower_holder_elemental.update
tt.main_script.remove = scripts.tower_holder_elemental.remove
tt.tower.terrain_style = nil

tt = E:register_t_10086("tower_holder_elemental_wood", "tower_holder_elemental")
tt.tower.terrain_style = nil
tt.render.sid_base = 1
tt.render.sid_gradiente = #tt.render.sprites + 1
tt.render.sid_dragon = #tt.render.sprites + 2
tt.render.sprites[tt.render.sid_gradiente] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_gradiente].prefix = "stage31_wood_holder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "buy"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "stage31_wood_holder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "buy"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.controller_name = "controller_elemental_wood"
tt.cannot_be_swapped = true

tt = E:register_t_10086("tower_holder_elemental_wood_enhance", "tower_holder_elemental_wood")
tt.controller_name = "controller_elemental_wood_enhance"

tt = E:register_t_10086("tower_holder_elemental_fire", "tower_holder_elemental")
tt.tower.terrain_style = nil
tt.render.sid_base = 1
tt.render.sid_gradiente = #tt.render.sprites + 1
tt.render.sid_dragon = #tt.render.sprites + 2
tt.render.sprites[tt.render.sid_gradiente] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_gradiente].prefix = "fireholder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "buy"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "fireholder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "buy"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.controller_name = "controller_elemental_fire"
tt.cannot_be_swapped = true
tt = E:register_t_10086("tower_holder_elemental_water", "tower_holder_elemental")
tt.tower.terrain_style = nil
tt.render.sid_base = 1
tt.render.sid_gradiente = #tt.render.sprites + 1
tt.render.sid_dragon = #tt.render.sprites + 2
tt.render.sprites[tt.render.sid_gradiente] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_gradiente].prefix = "stage33_water_holder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "buy"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "stage33_water_holder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "buy"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.controller_name = "controller_elemental_water"
tt.cannot_be_swapped = true
tt = E:register_t_10086("tower_holder_elemental_earth", "tower_holder_elemental")
tt.tower.terrain_style = nil
tt.render.sid_base = 1
tt.render.sprites[2].name = "terrains_holders_0014_flag"
tt.render.sid_gradiente = #tt.render.sprites + 1
tt.render.sid_dragon = #tt.render.sprites + 2
tt.render.sprites[tt.render.sid_gradiente] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_gradiente].prefix = "dirtholder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "buy"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "dirtholder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "buy"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.controller_name = "controller_elemental_earth"
tt.cannot_be_swapped = true
tt = E:register_t_10086("tower_holder_elemental_metal", "tower_holder_elemental")
b = balance.specials.terrain_8.elemental_holders.metal_holder
tt.tower.terrain_style = nil
tt.tower.upgrade_price_multiplier = b.upgrade_price_multiplier
tt.render.sid_base = 1
tt.render.sid_gradiente = #tt.render.sprites + 1
tt.render.sid_dragon = #tt.render.sprites + 2
tt.render.sprites[tt.render.sid_gradiente] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_gradiente].prefix = "goldholder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "buy"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].offset = v(0, 0)
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "goldholder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "buy"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.controller_name = "controller_elemental_metal"
tt.cannot_be_swapped = true
---龙魂宝壶
tt = E:register_t("tower_holder_blocked_elemental", "tower")

E:add_comps(tt, "tower", "tower_holder", "pos", "render", "ui", "info", "tween","sound_events", "editor")

tt.tower.level = 1
tt.tower.can_be_mod = false
tt.tower_holder.blocked = true
tt.tower.can_be_sold = false
tt.tower.type = "holder_baby_ashbite"
tt.tower.kind = TOWER_KIND_BARRACK
tt.info.fn = scripts.tower_holder_blocked_elemental_holder.get_info
tt.info.portrait =  "info_portraits_towers_0019"
tt.info.i18n_key = "BLOCKED_ELEMENTAL_TOWER"
tt.info.damage_icon = "fireball"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrains_holders_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "terrains_holders_%04i_flag"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 13.5)
tt.render.sprites[2].sort_y_offset = 13.5
tt.ui.click_rect = r(-40, -12, 80, 46)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		2,
		255
	},
	{
		2.5,
		255
	},
	{
		4.5,
		0
	}
}
tt.tween.props[1].sprite_id = 4
tt.tween.props[1].loop = true
---龙魂宝壶 金
tt = E:register_t_10086("tower_holder_blocked_elemental_metal_b", "tower_holder_blocked_elemental")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.metal_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.info.i18n_key = "BLOCKED_ELEMENTAL_TOWER_METAL"
tt.tower.type = "holder_blocked_elemental_metal"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "goldholder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 11)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "goldholder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[3].offset = v(0, 6)
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage33_water_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_33"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 9.5)
tt.render.sprites[tt.render.sid_parche].hidden = true
tt.render.sprites[tt.render.sid_parche].hidden_count = 1
tt.remove_fx = "fx_elemental_metal_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
---龙魂宝壶 木
tt = E:register_t_10086("tower_holder_blocked_elemental_wood_b", "tower_holder_blocked_elemental")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.wooden_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.info.i18n_key = "BLOCKED_ELEMENTAL_TOWER_WOOD"
tt.tower.type = "holder_blocked_elemental_wood"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "stage31_wood_holder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "stage31_wood_holder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage31_wood_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_31_clean"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_wood_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
---龙魂宝壶 水
tt = E:register_t_10086("tower_holder_blocked_elemental_water_b", "tower_holder_blocked_elemental")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.water_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.info.i18n_key = "BLOCKED_ELEMENTAL_TOWER_WATER"
tt.tower.type = "holder_blocked_elemental_water"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "stage33_water_holder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "stage33_water_holder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage33_water_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_33"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_water_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
---龙魂宝壶 火
tt = E:register_t_10086("tower_holder_blocked_elemental_fire_b", "tower_holder_blocked_elemental")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.fire_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.info.i18n_key = "BLOCKED_ELEMENTAL_TOWER_FIRE"
tt.tower.type = "holder_blocked_elemental_fire"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "fireholder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "fireholder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage31_wood_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_32"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_fire_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
---龙魂宝壶 土
tt = E:register_t_10086("tower_holder_blocked_elemental_earth_b", "tower_holder_blocked_elemental")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.earth_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.info.i18n_key = "BLOCKED_ELEMENTAL_TOWER_EARTH"
tt.tower.type = "holder_blocked_elemental_earth"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "dirtholder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "dirtholder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "dirtholder_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_33"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_earth_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
---
tt = E:register_t_10086("tower_holder_blocked_elemental_wood", "tower_holder_blocked_2")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.wooden_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.tower.type = "holder_blocked_elemental_wood"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "stage31_wood_holder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "stage31_wood_holder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage31_wood_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_31_clean"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_wood_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)


tt = E:register_t_10086("tower_holder_blocked_elemental_wood_enhance", "tower_holder_blocked_elemental_wood_b")
tt.tower.type = "holder_blocked_elemental_wood_enhance"
tt.tower_holder.unblock_price = 50

tt = E:register_t_10086("tower_holder_blocked_elemental_fire", "tower_holder_blocked_2")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.fire_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.tower.type = "holder_blocked_elemental_fire"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "fireholder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "fireholder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage31_wood_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_32"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_fire_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
tt = E:register_t_10086("tower_holder_blocked_elemental_water", "tower_holder_blocked_2")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.water_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.tower.type = "holder_blocked_elemental_water"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "stage33_water_holder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "stage33_water_holder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage33_water_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_33"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_water_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
tt = E:register_t_10086("tower_holder_blocked_elemental_earth", "tower_holder_blocked_2")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.earth_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.tower.type = "holder_blocked_elemental_earth"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "dirtholder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "dirtholder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "dirtholder_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_33"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 3.5)
tt.remove_fx = "fx_elemental_earth_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
tt = E:register_t_10086("tower_holder_blocked_elemental_metal", "tower_holder_blocked_2")

E:add_comps(tt, "main_script")

b = balance.specials.terrain_8.elemental_holders.metal_holder
tt.main_script.insert = scripts.tower_holder_blocked_elemental_holder.insert
tt.main_script.remove = scripts.tower_holder_blocked_elemental_holder.remove
tt.tower.type = "holder_blocked_elemental_metal"
tt.tower_holder.unblock_price = b.price
tt.tower.menu_offset = v(0, 35)
tt.render.sid_parche = 4
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "goldholder_jarraDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 11)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "goldholder_jarrahojasDef"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[3].offset = v(0, 6)
tt.render.sprites[tt.render.sid_parche] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_parche].prefix = "stage33_water_holder_animations_parcheDef"
tt.render.sprites[tt.render.sid_parche].name = "stage_33"
tt.render.sprites[tt.render.sid_parche].exo = true
tt.render.sprites[tt.render.sid_parche].animated = true
tt.render.sprites[tt.render.sid_parche].offset = v(-5.5, 9.5)
tt.render.sprites[tt.render.sid_parche].hidden = true
tt.render.sprites[tt.render.sid_parche].hidden_count = 1
tt.remove_fx = "fx_elemental_metal_holder_broken_jarra"
tt.ui.click_rect = r(-45, -8, 90, 90)
tt = E:register_t_10086("fx_elemental_metal_holder_broken_jarra", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "goldholder_jarraDef"
tt.render.sprites[1].name = "broken"
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(0, 5)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "goldholder_rayoDef"
tt.render.sprites[2].name = "ray_down"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "goldholder_rayo_explosionDef"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].exo = true
tt.render.sprites[3].offset = v(0, 5)
tt.render.sprites[3].z = Z_OBJECTS
tt = E:register_t_10086("tower_holder_blocked_stage_33_house_1", "tower_holder_blocked_2")
tt.pre_destroy_thunders = scripts.stage_33_house_holder.pre_destroy_thunders
tt.destroy_house = scripts.stage_33_house_holder.destroy_house
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].name = "stage33_casas_holder_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor = v(0.5760714285714286, 0.3502604166666667)
tt.render.sprites[2] = nil
tt.ui.can_click = false
tt.ui.can_select = false
tt.house_destroy_fx = "fx_stage_33_house_destroy"
tt.house_destroy_decal = "stage_33_house_destroyed_decal_1"
tt.pre_destroy_thunders_list = {
	{
		delay = 0,
		pos = v(388, 256)
	},
	{
		delay = 0.5,
		pos = v(450, 300)
	},
	{
		delay = 1.2,
		pos = v(530, 220)
	},
	{
		delay = 1.7,
		pos = v(545, 306)
	},
	{
		delay = 2,
		pos = v(692, 248)
	},
	{
		delay = 3.5,
		spawn_unit = "enemy_water_spirit_spawnless",
		pos = v(660, 343)
	},
	{
		delay = 3.8,
		spawn_unit = "enemy_water_spirit_spawnless",
		pos = v(620, 385)
	},
	{
		delay = 4.1,
		spawn_unit = "enemy_water_spirit_spawnless",
		pos = v(550, 340)
	}
}
tt = E:register_t_10086("tower_holder_blocked_stage_33_house_2", "tower_holder_blocked_stage_33_house_1")
tt.render.sprites[1].name = "stage33_casas_holder_2"
tt.render.sprites[1].anchor = v(0.3246428571428571, 0.23697916666666666)
tt.house_destroy_decal = "stage_33_house_destroyed_decal_2"
tt.pre_destroy_thunders_list = {
	{
		delay = 1.7,
		pos = v(165, 259)
	},
	{
		delay = 2,
		pos = v(196, 275)
	},
	{
		delay = 3.5,
		pos = v(333, 295)
	},
	{
		delay = 3.8,
		pos = v(428, 270)
	},
	{
		delay = 4.1,
		pos = v(512, 321)
	},
	{
		delay = 4.4,
		pos = v(615, 380)
	},
	{
		delay = 4.7,
		pos = v(630, 420)
	},
	{
		delay = 5,
		pos = v(583, 524)
	},
	{
		delay = 5.3,
		pos = v(754, 600)
	}
}
tt = E:register_t_10086("tower_holder_blocked_stage_33_house_3", "tower_holder_blocked_stage_33_house_1")
tt.render.sprites[1].name = "stage33_casas_holder_3"
tt.render.sprites[1].anchor = v(0.7917857142857143, 0.69140625)
tt.house_destroy_decal = "stage_33_house_destroyed_decal_3"
tt.pre_destroy_thunders_list = {
	{
		delay = 0,
		pos = v(388, 256)
	},
	{
		delay = 0.5,
		pos = v(450, 300)
	},
	{
		delay = 1.2,
		pos = v(530, 220)
	},
	{
		delay = 1.7,
		pos = v(545, 306)
	},
	{
		delay = 2,
		pos = v(692, 248)
	}
}
tt = E:register_t_10086("tower_holder_blocked_stage_33_invisible", "tower_holder_blocked_2")
tt.appear = scripts.tower_holder_blocked_stage_33_invisible.appear
tt.render.sprites[1].hidden = true
tt.render.sprites[2] = nil
tt.ui.can_click = false
tt.ui.can_select = false
tt = E:register_t_10086("tower_holder_blocked_stage_35_house_1", "tower_holder_blocked_2")
tt.pre_destroy = scripts.stage_35_house_holder.pre_destroy
tt.destroy_house = scripts.stage_35_house_holder.destroy_house
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].name = "stage35_deco1"
tt.render.sprites[1].animated = falses
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor = v(0.13035714285714287, 0.2727864583333333)
tt.render.sprites[2] = nil
tt.cannonball_fx = "fx_stage_35_cannonball"
tt.spawn_escombro = "holder"
tt.sound = "Stage35Cinematic1"
tt.unit_spawns = {
	{
		unit = "soldier_stage_35_cannonball",
		spi = 2,
		ni_offset = 0
	},
	{
		unit = "soldier_stage_35_cannonball",
		spi = 1,
		ni_offset = 8
	},
	{
		unit = "soldier_stage_35_cannonball",
		spi = 3,
		ni_offset = 4
	}
}
tt.pre_destroy_cannonballs_list = {
	{
		delay = 5.6,
		spawn_escombro = "camino",
		pos = v(150, 240)
	},
	{
		delay = 6,
		spawn_escombro = "camino",
		pos = v(80, 350)
	}
}
tt.cinematic_camera_duration_offset = 0
tt.ui.can_click = false
tt.ui.can_select = false
tt = E:register_t_10086("tower_holder_blocked_stage_35_house_2", "tower_holder_blocked_stage_35_house_1")
tt.render.sprites[1].name = "stage35_deco2"
tt.render.sprites[1].anchor = v(0.7857142857142857, 0.7272135416666666)
tt.unit_spawns = nil
tt.spawn_escombro = "holder"
tt.cinematic_camera_duration_offset = -1.4
tt.pre_destroy_cannonballs_list = nil
tt.sound = nil
tt = E:register_t_10086("tower_holder_blocked_stage_35_house_3", "tower_holder_blocked_stage_35_house_1")
tt.render.sprites[1].name = "stage35_deco3"
tt.render.sprites[1].anchor = v(0.23, 0.673828125)
tt.unit_spawns = nil
tt.spawn_escombro = nil
tt.pre_destroy_cannonballs_list = {
	{
		delay = 5.5,
		spawn_escombro = "camino",
		pos = v(300, 460)
	}
}
tt.sound = "Stage35Cinematic3"
tt = E:register_t_10086("tower_holder_blocked_stage_35_house_4", "tower_holder_blocked_stage_35_house_1")
tt.render.sprites[1].name = "stage35_deco4"
tt.render.sprites[1].anchor = v(0.7767857142857143, 0.3190104166666667)
tt.spawn_escombro = "holder"
tt.pre_destroy_cannonballs_list = {
	{
		delay = 5.8,
		spawn_escombro = "camino",
		pos = v(883, 397)
	}
}
tt.sound = "Stage35Cinematic2"
tt = E:register_t_10086("tower_holder_blocked_stage_35_house_5", "tower_holder_blocked_stage_35_house_1")
tt.render.sprites[1].hidden = true
tt.destroy_small_spawner_nmbr = 1
tt.decal = "decal_stage_35_escombros_holder_2"
tt.cinematic_camera_duration_offset = -0.4
tt.spawn_escombro = nil
tt.pre_destroy_cannonballs_list = {
	{
		delay = 1.1,
		spawn_escombro = "camino",
		pos = v(872, 527)
	}
}
tt.sound = nil
tt = E:register_t_10086("tower_holder_blocked_stage_35_house_6", "tower_holder_blocked_stage_35_house_1")
tt.render.sprites[1].hidden = true
tt.destroy_small_spawner_nmbr = 3
tt.decal = "decal_stage_35_escombros_holder_1"
tt.spawn_escombro = "holder"
tt.pre_destroy_cannonballs_list = nil
tt.sound = nil
tt = E:register_t_10086("tower_holder_blocked_stage_35_house_7", "tower_holder_blocked_stage_35_house_1")
tt.render.sprites[1].hidden = true
tt.destroy_small_spawner_nmbr = 2
tt.decal = "decal_stage_35_escombros_holder_3"
tt.spawn_escombro = nil
tt.pre_destroy_cannonballs_list = nil
tt.sound = nil
tt = E:register_t_10086("tower_build_pandas", "tower_build")
tt.build_name = "tower_pandas_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2].name = "tower_pandas_tower_build"
tt.render.sprites[2].offset = v(0, 10)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
tt = E:register_t_10086("tower_pandas_lvl1", "tower_KR5")
b = balance.towers.pandas

E:add_comps(tt, "attacks", "barrack", "vis", "user_selection")

tt.tower.type = "pandas"
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.team = TEAM_LINIREA
tt.tower.level = 1
tt.tower.price = b.price[1]
tt.tower.menu_offset = v(0, 28)
tt.info.i18n_key = "TOWER_PANDAS_1"
tt.info.portrait = "portraits_towers_0031"
tt.info.enc_icon = 81
tt.info.tower_portrait = "towerselect_portraits_big_" .. "0001"
tt.info.fn = scripts.tower_pandas.get_info
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_pandas_tower_lvl_01"
tt.render.sprites[2].offset = v(0, 15)
tt.render.sprites[2].sort_y_offset = 5
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_pandas_panda_blue_lvl1"
tt.render.sprites[3].name = "idle_tower"
tt.render.sprites[3].angles = {}
tt.render.sprites[3].angles.idle = {
	"idle_tower"
}
tt.render.sprites[3].angles.shoot = {
	"spell"
}
tt.render.sprites[3].offset = v(0, 18 + tt.render.sprites[2].offset.y)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "tower_pandas_panda_red_lvl1"
tt.render.sprites[4].name = "idle_torre"
tt.render.sprites[4].angles = {}
tt.render.sprites[4].angles.idle = {
	"idle_torre"
}
tt.render.sprites[4].angles.shoot = {
	"spell"
}
tt.render.sprites[4].offset = v(25, 5 + tt.render.sprites[2].offset.y)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "tower_pandas_panda_green_lvl1"
tt.render.sprites[5].name = "idle_tower"
tt.render.sprites[5].angles = {}
tt.render.sprites[5].angles.idle = {
	"idle_tower"
}
tt.render.sprites[5].angles.shoot = {
	"spell"
}
tt.render.sprites[5].offset = v(-24, 6 + tt.render.sprites[2].offset.y)
tt.barrack.soldier_type = "soldier_tower_pandas_blue_lvl1"
tt.barrack.rally_range = b.rally_range
tt.barrack.rally_radius = 30
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_pandas.update
tt.main_script.remove = scripts.tower_pandas.remove
tt.set_panda_bullet_arrived = scripts.tower_pandas.set_panda_bullet_arrived
tt.attacks.range = b.ranged_attack.range[1]
tt.attacks.attack_delay_on_spawn = fts(5)
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bullet_tower_pandas_air_lvl1"
tt.attacks.list[1].bullet_list = {
	{
		b = "bullet_tower_pandas_ray_lvl1",
		offset = v(0, 50),
		shoot_time = fts(8)
	},
	{
		b = "bullet_tower_pandas_fire_lvl1",
		offset = v(5, 8),
		shoot_time = fts(10)
	},
	{
		b = "bullet_tower_pandas_air_lvl1",
		offset = v(5, 0),
		shoot_time = fts(15)
	}
}
tt.attacks.list[1].cooldown = b.ranged_attack.cooldown
tt.attacks.list[1].bullet_start_offset = {
	v(0, 6 + tt.render.sprites[3].offset.y),
	v(25, 6 + tt.render.sprites[4].offset.y),
	v(-24, 3 + tt.render.sprites[5].offset.y)
}
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[2] = CC("custom_attack")
tt.attacks.list[2].soldiers = {
	"soldier_tower_pandas_blue_lvl1",
	"soldier_tower_pandas_red_lvl1",
	"soldier_tower_pandas_green_lvl1"
}
tt.attacks.list[2].soldiers_spawn_bullets = {
	"bullet_tower_pandas_spawn_soldier_blue_lvl1",
	"bullet_tower_pandas_spawn_soldier_red_lvl1",
	"bullet_tower_pandas_spawn_soldier_green_lvl1"
}
tt.attacks.list[2].cooldown = b.soldier.cooldown
tt.attacks.list[2].retreat_duration = b.soldier.retreat_duration
tt.sound_events.insert = "TowerPandasTauntZH"--i18n:cjk("TowerPandasTaunt", "TowerPandasTauntZH", nil, nil)
tt.sound_events.change_rally_point = "TowerPandasTauntZH"--i18n:cjk("TowerPandasTaunt", "TowerPandasTauntZH", nil, nil)
tt.sound_events.tower_room_select = "TowerPandasTauntZHSelect"--i18n:cjk("TowerPandasTauntSelect", "TowerPandasTauntZHSelect", nil, nil)
tt.ui.click_rect = r(-35, 0, 70, 65)
tt.ui.click_rect_heights_by_soldier = {
	53,
	53,
	[3] = 53,
	none = 53
}
tt.user_selection.allowed = true
tt.user_selection.actions = {
	tw_free_action = {
		allowed = false
	}
}
tt = E:register_t_10086("tower_pandas_lvl2", "tower_pandas_lvl1")
tt.info.enc_icon = 82
tt.info.i18n_key = "TOWER_PANDAS_2"
tt.tower.level = 2
tt.tower.price = b.price[2]
tt.tower.menu_offset = v(0, 30)
tt.render.sprites[2].name = "tower_pandas_tower_lvl_02"
tt.render.sprites[3].prefix = "tower_pandas_panda_blue_lvl2"
tt.render.sprites[3].offset = v(0, 22 + tt.render.sprites[2].offset.y)
tt.render.sprites[4].prefix = "tower_pandas_panda_red_lvl2"
tt.render.sprites[4].offset = v(25, 12 + tt.render.sprites[2].offset.y)
tt.render.sprites[5].prefix = "tower_pandas_panda_green_lvl2"
tt.render.sprites[5].offset = v(-25, 13 + tt.render.sprites[2].offset.y)
tt.attacks.list[1].bullet = "bullet_tower_pandas_air_lvl2"
tt.attacks.list[1].bullet_list = {
	{
		b = "bullet_tower_pandas_ray_lvl2",
		offset = v(0, 50),
		shoot_time = fts(8)
	},
	{
		b = "bullet_tower_pandas_fire_lvl2",
		offset = v(5, 8),
		shoot_time = fts(10)
	},
	{
		b = "bullet_tower_pandas_air_lvl2",
		offset = v(5, 0),
		shoot_time = fts(15)
	}
}
tt.attacks.list[1].bullet_start_offset = {
	v(0, 6 + tt.render.sprites[3].offset.y),
	v(27, 6 + tt.render.sprites[4].offset.y),
	v(-27, 3 + tt.render.sprites[5].offset.y)
}
tt.attacks.list[2].soldiers = {
	"soldier_tower_pandas_blue_lvl2",
	"soldier_tower_pandas_red_lvl2",
	"soldier_tower_pandas_green_lvl2"
}
tt.attacks.list[2].soldiers_spawn_bullets = {
	"bullet_tower_pandas_spawn_soldier_blue_lvl2",
	"bullet_tower_pandas_spawn_soldier_red_lvl2",
	"bullet_tower_pandas_spawn_soldier_green_lvl2"
}
tt.barrack.soldier_type = "soldier_tower_pandas_blue_lvl2"
tt.barrack.solder_upgrade_map = {
	soldier_tower_pandas_green_lvl1 = "soldier_tower_pandas_green_lvl2",
	soldier_tower_pandas_red_lvl1 = "soldier_tower_pandas_red_lvl2",
	soldier_tower_pandas_blue_lvl1 = "soldier_tower_pandas_blue_lvl2"
}
tt.ui.click_rect = r(-35, 0, 70, 70)
tt.ui.click_rect_heights_by_soldier = {
	55,
	53,
	[3] = 53,
	none = 53
}
tt = E:register_t_10086("tower_pandas_lvl3", "tower_pandas_lvl1")
tt.info.enc_icon = 83
tt.info.i18n_key = "TOWER_PANDAS_3"
tt.tower.level = 3
tt.tower.price = b.price[3]
tt.tower.menu_offset = v(0, 32)
tt.render.sprites[2].name = "tower_pandas_tower_lvl_03"
tt.render.sprites[3].prefix = "tower_pandas_panda_blue_lvl3"
tt.render.sprites[3].offset = v(0, 26 + tt.render.sprites[2].offset.y)
tt.render.sprites[4].prefix = "tower_pandas_panda_red_lvl3"
tt.render.sprites[4].offset = v(25, 14 + tt.render.sprites[2].offset.y)
tt.render.sprites[5].prefix = "tower_pandas_panda_green_lvl3"
tt.render.sprites[5].offset = v(-25, 15 + tt.render.sprites[2].offset.y)
tt.attacks.list[1].bullet = "bullet_tower_pandas_air_lvl3"
tt.attacks.list[1].bullet_list = {
	{
		b = "bullet_tower_pandas_ray_lvl3",
		offset = v(0, 55),
		shoot_time = fts(8)
	},
	{
		b = "bullet_tower_pandas_fire_lvl3",
		offset = v(5, 8),
		shoot_time = fts(10)
	},
	{
		b = "bullet_tower_pandas_air_lvl3",
		offset = v(5, 0),
		shoot_time = fts(15)
	}
}
tt.attacks.list[1].bullet_start_offset = {
	v(-2, 6 + tt.render.sprites[3].offset.y),
	v(27, 6 + tt.render.sprites[4].offset.y),
	v(-27, 3 + tt.render.sprites[5].offset.y)
}
tt.attacks.list[2].soldiers = {
	"soldier_tower_pandas_blue_lvl3",
	"soldier_tower_pandas_red_lvl3",
	"soldier_tower_pandas_green_lvl3"
}
tt.attacks.list[2].soldiers_spawn_bullets = {
	"bullet_tower_pandas_spawn_soldier_blue_lvl3",
	"bullet_tower_pandas_spawn_soldier_red_lvl3",
	"bullet_tower_pandas_spawn_soldier_green_lvl3"
}
tt.barrack.soldier_type = "soldier_tower_pandas_blue_lvl3"
tt.barrack.solder_upgrade_map = {
	soldier_tower_pandas_red_lvl2 = "soldier_tower_pandas_red_lvl3",
	soldier_tower_pandas_blue_lvl2 = "soldier_tower_pandas_blue_lvl3",
	soldier_tower_pandas_green_lvl2 = "soldier_tower_pandas_green_lvl3"
}
tt.ui.click_rect = r(-40, 0, 80, 75)
tt.ui.click_rect_heights_by_soldier = {
	62,
	53,
	[3] = 53,
	none = 53
}
tt = E:register_t_10086("tower_pandas_lvl4", "tower_pandas_lvl1")

E:add_comps(tt, "powers")

tt.info.portrait = "portraits_towers_0031"
tt.info.room_portrait = "quickmenu_main_icons_main_icons_0025_0001"
tt.info.enc_icon = 84
tt.info.i18n_key = "TOWER_PANDAS_4"
tt.info.stat_damage = b.stats.damage
tt.info.stat_hp = b.stats.hp
tt.info.stat_armor = b.stats.armor
tt.tower.price = b.price[4]
tt.tower.level = 4
tt.tower.menu_offset = v(0, 35)
tt.powers.thunder = CC("power")
tt.powers.thunder.price_base = b.thunder.price[1]
tt.powers.thunder.price_inc = b.thunder.price[2]
tt.powers.thunder.enc_icon = 539
tt.powers.thunder.name = "thunder"
tt.powers.thunder.key = "THUNDER"
tt.powers.thunder.max_level = 2
tt.powers.hat = CC("power")
tt.powers.hat.price_base = b.hat.price[1]
tt.powers.hat.price_inc = b.hat.price[2]
tt.powers.hat.enc_icon = 540
tt.powers.hat.name = "hat"
tt.powers.hat.max_level = 2
tt.powers.hat.key = "HAT"
tt.powers.teleport = CC("power")
tt.powers.teleport.price_base = b.teleport.price[1]
tt.powers.teleport.price_inc = b.teleport.price[2]
tt.powers.teleport.enc_icon = 541
tt.powers.teleport.name = "fiery"
tt.powers.teleport.key = "FIERY"
tt.powers.teleport.max_level = 2
tt.render.sprites[2].name = "tower_pandas_tower_lvl_04"
tt.render.sprites[3].prefix = "tower_pandas_panda_blue_lvl4"
tt.render.sprites[3].name = "idle_torre"
tt.render.sprites[3].angles.idle = {
	"idle_torre"
}
tt.render.sprites[3].offset = v(0, 35 + tt.render.sprites[2].offset.y)
tt.render.sprites[4].prefix = "tower_pandas_panda_red_lvl4"
tt.render.sprites[4].name = "idle_torre"
tt.render.sprites[4].angles.idle = {
	"idle_torre"
}
tt.render.sprites[4].offset = v(26, 24 + tt.render.sprites[2].offset.y)
tt.render.sprites[5].prefix = "tower_pandas_panda_green_lvl4"
tt.render.sprites[5].name = "idle_torre"
tt.render.sprites[5].angles.idle = {
	"idle_torre"
}
tt.render.sprites[5].offset = v(-24, 24 + tt.render.sprites[2].offset.y)
tt.attacks.list[1].bullet = "bullet_tower_pandas_air_lvl4"
tt.attacks.list[1].bullet_list = {
	{
		b = "bullet_tower_pandas_ray_lvl4",
		offset = v(0, 50),
		shoot_time = fts(8)
	},
	{
		b = "bullet_tower_pandas_fire_lvl4",
		offset = v(0, 15),
		shoot_time = fts(10)
	},
	{
		b = "bullet_tower_pandas_air_lvl4",
		offset = v(0, 5),
		shoot_time = fts(15)
	}
}
tt.attacks.list[1].bullet_start_offset = {
	v(-2, 6 + tt.render.sprites[3].offset.y),
	v(27, 6 + tt.render.sprites[4].offset.y),
	v(-27, 3 + tt.render.sprites[5].offset.y)
}
tt.sound_events.insert = "TowerPandasTauntZH"--i18n:cjk("TowerPandasTaunt", "TowerPandasTauntZH", nil, nil)
tt.sound_events.change_rally_point = "TowerPandasTauntZH"--i18n:cjk("TowerPandasTaunt", "TowerPandasTauntZH", nil, nil)
tt.attacks.list[2].soldiers = {
	"soldier_tower_pandas_blue_lvl4",
	"soldier_tower_pandas_red_lvl4",
	"soldier_tower_pandas_green_lvl4"
}
tt.attacks.list[2].soldiers_spawn_bullets = {
	"bullet_tower_pandas_spawn_soldier_blue_lvl4",
	"bullet_tower_pandas_spawn_soldier_red_lvl4",
	"bullet_tower_pandas_spawn_soldier_green_lvl4"
}
tt.barrack.soldier_type = "soldier_tower_pandas_blue_lvl4"
tt.barrack.solder_upgrade_map = {
	soldier_tower_pandas_green_lvl3 = "soldier_tower_pandas_green_lvl4",
	soldier_tower_pandas_red_lvl3 = "soldier_tower_pandas_red_lvl4",
	soldier_tower_pandas_blue_lvl3 = "soldier_tower_pandas_blue_lvl4"
}
tt.ui.click_rect = r(-42, 0, 84, 70)
tt.ui.click_rect_heights_by_soldier = {
	70,
	65,
	[3] = 58,
	none = 53
}
tt = E:register_t_10086("soldier_stage_35_cannonball", "soldier_militia")
b = balance.specials.stage35_cannonball_soldier

E:add_comps(tt, "reinforcement", "nav_path", "tween")

tt.info.portrait = "gui_bottom_info_image_soldiers_0076"
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health_bar.offset = v(0, 35)
tt.info.fn = scripts.soldier_charge.get_info
tt.info.random_name_count = 5
tt.info.random_name_format = "SOLDIER_CANNONBALL_%i_NAME"
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_stage_35_cannonball.update
tt.melee.range = b.basic_attack.range
tt.melee.attacks[1].animation = "attack_melee"
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].hit_time = fts(11)
tt.soldier.melee_slot_offset = v(8, 0)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "sate_5_mono_unit"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].anchor = vv(0.5)
tt.soldier.melee_slot_offset.x = 3
tt.reinforcement.fade = false
tt.reinforcement.fade_in = false
tt.reinforcement.fade_out = false
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.flags = F_FRIEND
tt.ui.can_click = true
tt.ui.click_rect = r(-15, -2, 30, 35)
tt.patrol_pos_offset = v(15, 10)
tt.patrol_min_cd = 5
tt.patrol_max_cd = 10
tt.nav_path.dir = -1
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
tt.tween.remove = false
tt.tween.reverse = false
tt.tween.loop = false
tt.tween.disabled = true
tt = E:register_t_10086("soldier_tower_pandas_green_lvl1", "soldier_militia")

E:add_comps(tt, "nav_grid", "powers")

b = balance.towers.pandas.soldier
tt.info.is_here_pandas = 1
tt.info.portrait = "gui_bottom_info_image_soldiers_0062"
tt.info.random_name_format = nil
tt.info.i18n_key = "SOLDIER_TOWER_PANDAS_FEMALE"
tt.info.fn = scripts.soldier_tower_pandas.get_info
tt.nav_rally.delay_min = 0
tt.nav_rally.delay_max = 0
tt.death_go_back_delay = fts(25)
tt.unit.fade_time_after_death = 1
tt.main_script.insert = scripts.soldier_tower_pandas.insert
tt.main_script.update = scripts.soldier_tower_pandas.update
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl1"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].scale = vv(1.1)
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].angles.attack = {
	"attack"
}
tt.unit.head_offset = v(0, 12)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt.unit.level = 1
tt.soldier.melee_slot_spread = v(-13, -13)
tt.soldier.melee_slot_offset = v(10, 0)
tt.vis.bans = 0
tt.health.hp_max = b.hp[1]
tt.health.armor = b.armor[1]
tt.health_bar.offset = v(0, 37)
tt.health.dead_lifetime = 3
tt.regen.health = b.regen_hp[1]
tt.motion.max_speed = b.speed
tt.melee.range = b.melee_attack.range
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].loops = 1
tt.melee.attacks[1].hit_times = {
	fts(7),
	fts(13)
}
tt.melee.attacks[1].hit_time = nil
tt.melee.attacks[1].animations = {
	nil,
	"attack"
}
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[1] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[1] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].hit_fx = "fx_tower_pandas_melee_air_hit"
tt.melee.attacks[1].hit_offset = v(30, 12)
tt.melee.attacks[1].sound_hit = "TowerPandasMelee"
tt.ui.click_rect = r(-13, 0, 25, 25)
tt.ui.click_rect_offset_y = 0
tt.max_dist_walk = 160
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_SKELETON, F_CANNIBALIZE, F_LYCAN)
tt.ignore_linirea_true_might_revive = true
tt = E:register_t_10086("soldier_tower_pandas_green_lvl2", "soldier_tower_pandas_green_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0065"
tt.unit.level = 2
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl2"
tt.health.hp_max = b.hp[2]
tt.health.armor = b.armor[2]
tt.health_bar.offset = v(0, 38)
tt.regen.health = b.regen_hp[2]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[2] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[2] / #tt.melee.attacks[1].hit_times
tt = E:register_t_10086("soldier_tower_pandas_green_lvl3", "soldier_tower_pandas_green_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0068"
tt.unit.level = 3
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl3"
tt.health.hp_max = b.hp[3]
tt.health.armor = b.armor[3]
tt.health_bar.offset = v(0, 39)
tt.regen.health = b.regen_hp[3]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[3] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[3] / #tt.melee.attacks[1].hit_times
tt = E:register_t_10086("soldier_tower_pandas_green_lvl4", "soldier_tower_pandas_green_lvl1")

E:add_comps(tt, "ranged")

tt.info.portrait = "gui_bottom_info_image_soldiers_0071"
tt.unit.level = 4
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl4"
tt.motion.max_speed = b.speed * 1.1
tt.unit.fade_time_after_death = nil
tt.unit.hide_after_death = true
tt.death_go_back_delay = fts(15)
tt.health.hp_max = b.hp[4]
tt.health.armor = b.armor[4]
tt.health_bar.offset = v(0, 44)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.regen.health = b.regen_hp[4]
tt.melee.attacks[1].hit_times = {
	fts(7),
	fts(13),
	fts(23)
}
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[4] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[4] / #tt.melee.attacks[1].hit_times
tt.powers.hat = E:clone_c("power")
tt.powers.hat.cooldown = b.hat.cooldown
tt.powers.hat.range = b.hat.range
tt.ranged.attacks[1].level = 1
tt.ranged.attacks[1].bullet = "bullet_tower_pandas_air_soldier_special_lvl"
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(15)
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[1].animation = "skill"
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].bullet_start_offset = {
	v(40, 20)
}
tt.ranged.attacks[1].sound = "TowerPandasRangedHat"
tt.ranged.attacks[1].sound_args = {
	delay = fts(12)
}
tt.ui.click_rect = r(-13, 0, 25, 30)
tt.sound_events.death = "TowerPandasDeath"
tt.sound_events.death_args = {
	delay = fts(12)
}
tt = E:register_t_10086("soldier_tower_pandas_blue_lvl1", "soldier_tower_pandas_green_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0061"
tt.info.i18n_key = "SOLDIER_TOWER_PANDAS_MALE"
tt.unit.level = 1
tt.nav_rally.delay_min = 0.12
tt.nav_rally.delay_max = 0.2
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl1"
tt.health.hp_max = b.hp[1]
tt.health.armor = b.armor[1]
tt.regen.health = b.regen_hp[1]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[1] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[1] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].hit_fx = "fx_tower_pandas_melee_fire_ray"
tt = E:register_t_10086("soldier_tower_pandas_blue_lvl2", "soldier_tower_pandas_blue_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0064"
tt.unit.level = 2
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl2"
tt.health.hp_max = b.hp[2]
tt.health.armor = b.armor[2]
tt.health_bar.offset = v(0, 38)
tt.regen.health = b.regen_hp[2]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[2] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[2] / #tt.melee.attacks[1].hit_times
tt = E:register_t_10086("soldier_tower_pandas_blue_lvl3", "soldier_tower_pandas_blue_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0067"
tt.unit.level = 3
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl3"
tt.health.hp_max = b.hp[3]
tt.health.armor = b.armor[3]
tt.health_bar.offset = v(0, 39)
tt.regen.health = b.regen_hp[3]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[3] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[3] / #tt.melee.attacks[1].hit_times
tt = E:register_t_10086("soldier_tower_pandas_blue_lvl4", "soldier_tower_pandas_blue_lvl1")

E:add_comps(tt, "attacks")

tt.info.portrait = "gui_bottom_info_image_soldiers_0070"
tt.unit.level = 4
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl4"
tt.motion.max_speed = b.speed * 0.9
tt.unit.fade_time_after_death = nil
tt.unit.hide_after_death = true
tt.death_go_back_delay = fts(22)
tt.health.hp_max = b.hp[4]
tt.health.armor = b.armor[4]
tt.health_bar.offset = v(0, 44)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.regen.health = b.regen_hp[4]
tt.melee.attacks[1].hit_times = {
	fts(7),
	fts(13),
	fts(25)
}
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[4] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[4] / #tt.melee.attacks[1].hit_times
tt.attacks.list[1] = E:clone_c("custom_attack")
tt.attacks.list[1].cooldown = nil
tt.attacks.list[1].shoot_times = {
	fts(15),
	fts(19),
	fts(23)
}
tt.attacks.list[1].animation = "skill"
tt.attacks.list[1].vis_flags = F_RANGED
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[1].range = nil
tt.attacks.list[1].damage_min = 0
tt.attacks.list[1].damage_max = 0
tt.attacks.list[1].damage_type = b.thunder.damage_type
tt.attacks.list[1].damage_area = b.thunder.damage_area
tt.attacks.list[1].min_targets = b.thunder.min_targets
tt.attacks.list[1].mod = "mod_soldier_tower_pandas_blue_stun"
tt.powers.thunder = E:clone_c("power")
tt.powers.thunder.cooldown = b.thunder.cooldown
tt.powers.thunder.range = b.thunder.range
tt.powers.thunder.damage_min = b.thunder.damage_min
tt.powers.thunder.damage_max = b.thunder.damage_max
tt.ui.click_rect = r(-17, 0, 34, 30)
tt.sound_events.death = "TowerPandasDeath"
tt.sound_events.death_args = {
	delay = fts(12)
}
tt.sound_events.thunder = "TowerPandasSkillBolt"
tt.sound_events.thunder_args = {
	delay = fts(12)
}
tt = E:register_t_10086("mod_soldier_tower_pandas_blue_stun", "mod_stun")
tt.modifier.duration = b.thunder.stun_duration
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_BOSS)
tt = E:register_t_10086("soldier_tower_pandas_red_lvl1", "soldier_tower_pandas_green_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0060"
tt.info.i18n_key = "SOLDIER_TOWER_PANDAS_MALE"
tt.unit.level = 1
tt.nav_rally.delay_min = 0.05
tt.nav_rally.delay_max = 0.07
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl1"
tt.health.hp_max = b.hp[1]
tt.health.armor = b.armor[1]
tt.regen.health = b.regen_hp[1]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[1] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[1] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].hit_fx = "fx_tower_pandas_melee_fire_hit"
tt = E:register_t_10086("soldier_tower_pandas_red_lvl2", "soldier_tower_pandas_red_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0063"
tt.unit.level = 2
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl2"
tt.health.hp_max = b.hp[2]
tt.health.armor = b.armor[2]
tt.health_bar.offset = v(0, 38)
tt.regen.health = b.regen_hp[2]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[2] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[2] / #tt.melee.attacks[1].hit_times
tt = E:register_t_10086("soldier_tower_pandas_red_lvl3", "soldier_tower_pandas_red_lvl1")
tt.info.portrait = "gui_bottom_info_image_soldiers_0066"
tt.unit.level = 3
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl3"
tt.health.hp_max = b.hp[3]
tt.health.armor = b.armor[3]
tt.health_bar.offset = v(0, 39)
tt.regen.health = b.regen_hp[3]
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[3] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[3] / #tt.melee.attacks[1].hit_times
tt = E:register_t_10086("soldier_tower_pandas_red_lvl4", "soldier_tower_pandas_red_lvl1")

E:add_comps(tt, "attacks")

tt.info.portrait = "gui_bottom_info_image_soldiers_0069"
tt.unit.level = 4
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl4"
tt.unit.fade_time_after_death = nil
tt.unit.hide_after_death = true
tt.death_go_back_delay = fts(12)
tt.health.hp_max = b.hp[4]
tt.health.armor = b.armor[4]
tt.health_bar.offset = v(0, 44)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.regen.health = b.regen_hp[4]
tt.melee.attacks[1].hit_times = {
	fts(7),
	fts(13),
	fts(25)
}
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min[4] / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max[4] / #tt.melee.attacks[1].hit_times
tt.powers.teleport = E:clone_c("power")
tt.powers.teleport.cooldown = b.teleport.cooldown
tt.powers.teleport.range = b.teleport.range
tt.powers.teleport.nodes_offset_min = b.teleport.nodes_offset_min
tt.powers.teleport.nodes_offset_max = b.teleport.nodes_offset_max
tt.powers.teleport.damage_min = b.teleport.damage_min
tt.powers.teleport.damage_max = b.teleport.damage_max
tt.attacks.list[1] = E:clone_c("custom_attack")
tt.attacks.list[1].cooldown = nil
tt.attacks.list[1].shoot_time = fts(17)
tt.attacks.list[1].animation = "skill"
tt.attacks.list[1].vis_flags = bor(F_MOD, F_TELEPORT)
tt.attacks.list[1].vis_bans = bor(F_BOSS)
tt.attacks.list[1].range = nil
tt.attacks.list[1].damage_min = 0
tt.attacks.list[1].damage_max = 0
tt.attacks.list[1].damage_type = b.teleport.damage_type
tt.attacks.list[1].max_targets = b.teleport.max_targets
tt.attacks.list[1].nodes_offset_min = 0
tt.attacks.list[1].nodes_offset_max = 0
tt.attacks.list[1].mod = "mod_soldier_tower_pandas_red_teleport"
tt.attacks.list[1].decal = "decal_tower_panda_skill_red_tp_soldier_fire"
tt.attacks.list[1].max_times_applied = b.teleport.max_times_applied
tt.ui.click_rect = r(-17, 0, 34, 30)
tt.sound_events.death = "TowerPandasDeath"
tt.sound_events.death_args = {
	delay = fts(6)
}
tt.sound_events.teleport = "TowerPandasSkillFire"
tt.sound_events.teleport_args = {
	delay = fts(12)
}
tt = E:register_t_10086("fx_lightining_soldier_tower_pandas_blue", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "tower_pandas_lighting_sky_run"
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "tower_pandas_target_ray_run"
tt.render.sprites[2].animated = true
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].delay_start = fts(6)
tt = E:register_t_10086("mod_soldier_tower_pandas_red_teleport", "mod_teleport")
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.modifier.vis_bans = bor(F_BOSS)
tt.nodes_offset_min = 0
tt.nodes_offset_max = 0
tt.nodes_offset_inc = 0
tt.dest_valid_node = true
tt.delay_start = fts(2)
tt.hold_time = 0.34
tt.delay_end = fts(4)
tt.modifier.use_mod_offset = false
tt.fx_start = "fx_tower_panda_skill_red_tp_enemy_fire"
tt.fx_end = "fx_tower_panda_skill_red_tp_enemy_fire"
tt.max_times_applied = b.teleport.max_times_applied
tt = E:register_t_10086("soldier_hero_wukong_clone", "soldier_militia")
b = balance.heroes.hero_wukong

E:add_comps(tt, "reinforcement")

tt.health.armor = b.hair_clones.soldier.armor
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 45)
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.info.portrait = "gui_bottom_info_image_soldiers_0073"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.i18n_key = "SOLDIER_HERO_WUKONG_HAIR_CLONES_1"
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].cooldown = b.hair_clones.soldier.melee_attack.cooldown
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].animation = "attack_melee"
tt.melee.attacks[1].hit_fx = "fx_hero_wukong_hit_2"
tt.melee.attacks[1].hit_offset = v(25, 20)
tt.melee.range = b.hair_clones.soldier.melee_attack.range
tt.motion.max_speed = b.hair_clones.soldier.max_speed
tt.regen.cooldown = 1
tt.regen.health = 0
tt.reinforcement.duration = nil
tt.render.sprites[1].prefix = "hero_wukong_clone_1"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.soldier.melee_slot_offset = v(10, 0)
tt.reinforcement.fade = nil
tt.reinforcement.fade_in = nil
tt.unit.head_offset = v(0, 14)
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(0, 14)
tt.unit.level = 0
tt = E:register_t_10086("soldier_hero_wukong_clone_b", "soldier_hero_wukong_clone")
tt.info.portrait = "gui_bottom_info_image_soldiers_0074"
tt.render.sprites[1].prefix = "hero_wukong_clone_2"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.i18n_key = "SOLDIER_HERO_WUKONG_HAIR_CLONES_2"
tt = E:register_t_10086("soldier_hero_wukong_zhu_apprentice", "soldier_militia")

E:add_comps(tt, "melee", "nav_grid")

b = balance.heroes.hero_wukong.zhu_apprentice
tt.info.i18n_key = "SOLDIER_ZHU_APPRENTICE"
tt.info.enc_icon = 12
tt.info.portrait = "gui_bottom_info_image_soldiers_0072"
tt.info.is_here_pandas = 1
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_wukong_woolong"
tt.unit.hit_offset = v(0, 16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.health_bar.offset = v(0, 28)
tt.main_script.insert = scripts.soldier_hero_wukong_zhu_apprentice.insert
tt.main_script.update = scripts.soldier_hero_wukong_zhu_apprentice.update
tt.regen.cooldown = 1
tt.idle_flip.last_animation = "idle"
tt.melee.range = b.melee_attack.range
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].damage_type = b.melee_attack.damage_type
tt.melee.attacks[1].hit_time = fts(2)
tt.melee.attacks[1].animation = "attack_melee"
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].cooldown = b.smash_attack.cooldown
tt.melee.attacks[2].damage_radius = b.smash_attack.damage_radius
tt.melee.attacks[2].damage_max = b.smash_attack.damage_max
tt.melee.attacks[2].damage_min = b.smash_attack.damage_min
tt.melee.attacks[2].damage_type = b.smash_attack.damage_type
tt.melee.attacks[2].hit_decal = "decal_zhu_apprentice_area_attack"
tt.melee.attacks[2].hit_offset = v(15, 0)
tt.melee.attacks[2].hit_time = fts(59)
tt.melee.attacks[2].animation = "attack_area"
tt.melee.attacks[2].sound = "HeroWukongZhuSmash"
tt.melee.attacks[2].sound_args = {
	delay = fts(33)
}
tt.respawn_fx = "fx_zhu_apprentice_respawn"
tt.respawn_fx_timing = fts(9)
tt.unit.fade_time_after_death = nil
tt.ui.click_rect = r(-12, -5, 24, 30)
tt.not_draggable = true
tt.health.dead_lifetime = b.dead_lifetime
tt.health.ignore_delete_after = true
tt.motion.max_speed = b.max_speed
tt.soldier.melee_slot_offset = v(12, 0)
tt.ignore_linirea_true_might_revive = true
tt = E:register_t_10086("fx_hero_wukong_ultimate", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "hero_wukong_dragon_ultimate_dragon"
tt.render.sprites[1].scale = vv(1)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.sound_events.insert = "HeroWukongUltimate"
tt = E:register_t_10086("fx_hero_wukong_ultimate_2", "fx_hero_wukong_ultimate")
tt.render.sprites[1].scale = vv(5)

tt = E:register_t_10086("fx_hero_wukong_ultimate_cracks", "decal_tween")
tt.render.sprites[1].name = "hero_wukong_dragon_ultimate_cracks_floor"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].sort_y_offset = 20
tt.render.sprites[1].scale = vv(1)
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].offset = v(0, 10)
tt.render.sprites[3] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[3].offset = v(-10, -10)
tt.tween.props[1].keys = {
	{
		fts(31),
		0
	},
	{
		fts(35),
		255
	},
	{
		2.5,
		255
	},
	{
		3,
		0
	},
	{
		4,
		0
	}
}
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].keys = {
	{
		fts(31) + fts(7),
		0
	},
	{
		fts(35) + fts(7),
		255
	},
	{
		2.5 + fts(7),
		255
	},
	{
		3 + fts(7),
		0
	},
	{
		4,
		0
	}
}
tt.tween.props[3] = table.deepclone(tt.tween.props[1])
tt.tween.props[3].sprite_id = 3
tt.tween.props[3].keys = {
	{
		fts(31) + fts(14),
		0
	},
	{
		fts(35) + fts(14),
		255
	},
	{
		2.5 + fts(14),
		255
	},
	{
		3 + fts(14),
		0
	},
	{
		4,
		0
	}
}
tt.tween.remove = true

tt = E:register_t_10086("fx_hero_wukong_ultimate_cracks_2", "fx_hero_wukong_ultimate_cracks")
tt.render.sprites[1].scale = vv(5)
tt.render.sprites[2].scale = vv(5)
tt.render.sprites[3].scale = vv(5)
tt = E:register_t_10086("fx_hero_wukong_ultimate_explosion", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "hero_wukong_dragon_ultimate_fire_explosion"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[1].hidden = true
tt = E:register_t_10086("fx_hero_wukong_ultimate_explosion_2", "fx_hero_wukong_ultimate_explosion")
tt.render.sprites[1].scale = vv(5)
tt = E:register_t_10086("hero_wukong", "hero5")
b = balance.heroes.hero_wukong

E:add_comps(tt, "melee", "timed_attacks")

tt.melee.sid_spin = 1
tt.melee.sid_jump = 2
tt.melee.sid_simple = 3
tt.melee.sid_fast_hits = 4
tt.hero.level_stats.armor = b.armor
tt.hero.level_stats.hp_max = b.hp_max
tt.hero.level_stats.melee_damage_max = {}
tt.hero.level_stats.melee_damage_min = {}
tt.hero.level_stats.melee_damage_max[tt.melee.sid_spin] = b.melee_attacks.spin.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_spin] = b.melee_attacks.spin.damage_min
tt.hero.level_stats.melee_damage_max[tt.melee.sid_jump] = b.melee_attacks.jump.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_jump] = b.melee_attacks.jump.damage_min
tt.hero.level_stats.melee_damage_max[tt.melee.sid_simple] = b.melee_attacks.simple.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_simple] = b.melee_attacks.simple.damage_min
tt.hero.level_stats.melee_damage_max[tt.melee.sid_fast_hits] = b.melee_attacks.fast_hits.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_fast_hits] = b.melee_attacks.fast_hits.damage_min
tt.hero.level_stats.regen_health = b.regen_health
tt.hero.skills.hair_clones = E:clone_c("hero_skill")
tt.hero.skills.hair_clones.hr_icon = "0018"
tt.hero.skills.hair_clones.hr_order = 1
tt.hero.skills.hair_clones.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.hair_clones.hr_available = true
tt.hero.skills.hair_clones.cooldown = b.hair_clones.cooldown
tt.hero.skills.hair_clones.duration = b.hair_clones.soldier.duration
tt.hero.skills.hair_clones.hp_max = b.hair_clones.soldier.hp_max
tt.hero.skills.hair_clones.damage_min = b.hair_clones.soldier.melee_attack.damage_min
tt.hero.skills.hair_clones.damage_max = b.hair_clones.soldier.melee_attack.damage_max
tt.hero.skills.hair_clones.key = "HAIR_CLONES"
tt.hero.skills.hair_clones.xp_gain = b.hair_clones.xp_gain
tt.hero.skills.zhu_apprentice = E:clone_c("hero_skill")
tt.hero.skills.zhu_apprentice.smash_chance = b.zhu_apprentice.smash_attack.chance
tt.hero.skills.zhu_apprentice.hp_max = b.zhu_apprentice.hp_max
tt.hero.skills.zhu_apprentice.damage_min = b.zhu_apprentice.melee_attack.damage_min
tt.hero.skills.zhu_apprentice.damage_max = b.zhu_apprentice.melee_attack.damage_max
tt.hero.skills.zhu_apprentice.smash_damage_min = b.zhu_apprentice.smash_attack.damage_min
tt.hero.skills.zhu_apprentice.smash_damage_max = b.zhu_apprentice.smash_attack.damage_max
tt.hero.skills.zhu_apprentice.hr_available = true
tt.hero.skills.zhu_apprentice.hr_icon = "0016"
tt.hero.skills.zhu_apprentice.hr_order = 2
tt.hero.skills.zhu_apprentice.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.zhu_apprentice.entity = "soldier_hero_wukong_zhu_apprentice"
tt.hero.skills.zhu_apprentice.key = "ZHU_APPRENTICE"
tt.hero.skills.pole_ranged = E:clone_c("hero_skill")
tt.hero.skills.pole_ranged.hr_icon = "0018"
tt.hero.skills.pole_ranged.hr_order = 3
tt.hero.skills.pole_ranged.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.pole_ranged.hr_available = true
tt.hero.skills.pole_ranged.key = "POLE_RANGED"
tt.hero.skills.pole_ranged.cooldown = b.pole_ranged.cooldown
tt.hero.skills.pole_ranged.damage_max = b.pole_ranged.damage_max
tt.hero.skills.pole_ranged.damage_min = b.pole_ranged.damage_min
tt.hero.skills.pole_ranged.pole_amounts = b.pole_ranged.pole_amounts
tt.hero.skills.pole_ranged.xp_gain = b.pole_ranged.xp_gain
tt.hero.skills.giant_staff = E:clone_c("hero_skill")
tt.hero.skills.giant_staff.hr_icon = "0018"
tt.hero.skills.giant_staff.hr_order = 4
tt.hero.skills.giant_staff.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.giant_staff.hr_available = true
tt.hero.skills.giant_staff.cooldown = b.giant_staff.cooldown
tt.hero.skills.giant_staff.area_damage_min = b.giant_staff.area_damage.damage_min
tt.hero.skills.giant_staff.area_damage_max = b.giant_staff.area_damage.damage_max
tt.hero.skills.giant_staff.key = "GIANT_STAFF"
tt.hero.skills.giant_staff.xp_gain = b.giant_staff.xp_gain
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_icon = "0018"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.ultimate.hr_available = true
tt.hero.skills.ultimate.cooldown = b.ultimate.cooldown
tt.hero.skills.ultimate.damage_total = b.ultimate.damage_total
tt.hero.skills.ultimate.controller_name = "controller_hero_wukong_ultimate"
tt.hero.skills.ultimate.key = "ULTIMATE"
tt.hero.skills.ultimate.slow_factor = b.ultimate.slow_factor
tt.hero.skills.ultimate.slow_duration = b.ultimate.slow_duration
tt.hero.team = TEAM_LINIREA
tt.health.dead_lifetime = b.dead_lifetime
tt.health_bar.offset = v(0, 45)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.hero_portrait = "kra_hero_portraits_0018"
tt.info.i18n_key = "HERO_WUKONG"
tt.info.portrait = "portraits_hero_0018"
tt.info.ultimate_icon = "0018"
tt.info.stat_hp = b.stats.hp
tt.info.stat_armor = b.stats.armor
tt.info.stat_damage = b.stats.damage
tt.info.stat_cooldown = b.stats.cooldown
tt.info.damage_icon = "magic"
tt.info.fn = scripts.hero_basic.get_info_melee
tt.hero.fn_level_up = scripts.hero_wukong.level_up
tt.main_script.insert = scripts.hero_wukong.insert
tt.main_script.update = scripts.hero_wukong.update
tt.motion.max_speed = b.speed
tt.regen.cooldown = b.regen_cooldown
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_wukong_wukong"
tt.render.sprites[1].draw_order = DO_HEROES
tt.sound_events.change_rally_point =  "HeroWukongTauntZH"--i18n:cjk("HeroWukongTaunt", "HeroWukongTauntZH", nil, nil)
tt.sound_events.death = "HeroWukongDeathZH"--i18n:cjk("HeroWukongDeath", "HeroWukongDeathZH", nil, nil)
tt.sound_events.respawn = "HeroWukongTauntZHIntro"--i18n:cjk("HeroWukongTauntIntro", "HeroWukongTauntZHIntro", nil, nil)
tt.sound_events.hero_room_select = "HeroWukongTauntZHSelect"--i18n:cjk("HeroWukongTauntSelect", "HeroWukongTauntZHSelect", nil, nil)
tt.sound_death_sfx = "HeroWukongDeathSFX"
tt.soldier.melee_slot_offset = v(20, 0)
tt.unit.hit_offset = v(0, 23)
tt.unit.mod_offset = v(0, 23)
tt.unit.marker_offset = v(0, 0)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.ui.click_rect = r(-25, -13, 50, 66)
tt.ui.click_rect_fly = r(-25, -13, 50, 66)
tt.ui.click_rect_nofly = table.deepclone(tt.ui.click_rect)
tt.melee.range = 100
tt.melee.cooldown = b.melee_attacks.cooldown
tt.melee.can_repeat_attack = b.melee_attacks.can_repeat_attack
tt.melee.hit_animation = "fx_hero_wukong_hit"
tt.melee.hit_offset = v(25, 20)
tt.melee.attacks[tt.melee.sid_spin] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_spin].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_spin].basic_attack = true
tt.melee.attacks[tt.melee.sid_spin].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_spin].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_spin].damage_max = b.melee_attacks.spin.damage_max
tt.melee.attacks[tt.melee.sid_spin].damage_min = b.melee_attacks.spin.damage_min
tt.melee.attacks[tt.melee.sid_spin].damage_type = b.melee_attacks.spin.damage_type
tt.melee.attacks[tt.melee.sid_spin].hit_times = {
	fts(11),
	fts(16)
}
tt.melee.attacks[tt.melee.sid_spin].loops = 1
tt.melee.attacks[tt.melee.sid_spin].animations = {
	nil,
	"attack_1"
}
tt.melee.attacks[tt.melee.sid_spin].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_spin].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_spin].sound = "HeroWukongMeleeSpin"
tt.melee.attacks[tt.melee.sid_spin].sound_args = {
	delay = fts(10)
}
tt.melee.attacks[tt.melee.sid_jump] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_jump].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_jump].basic_attack = true
tt.melee.attacks[tt.melee.sid_jump].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_jump].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_jump].damage_max = b.melee_attacks.jump.damage_max
tt.melee.attacks[tt.melee.sid_jump].damage_min = b.melee_attacks.jump.damage_min
tt.melee.attacks[tt.melee.sid_jump].damage_type = b.melee_attacks.jump.damage_type
tt.melee.attacks[tt.melee.sid_jump].hit_time = fts(10)
tt.melee.attacks[tt.melee.sid_jump].animation = "attack_2"
tt.melee.attacks[tt.melee.sid_jump].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_jump].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_jump].sound = "HeroWukongMeleeJump"
tt.melee.attacks[tt.melee.sid_simple] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_simple].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_simple].basic_attack = true
tt.melee.attacks[tt.melee.sid_simple].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_simple].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_simple].damage_max = b.melee_attacks.simple.damage_max
tt.melee.attacks[tt.melee.sid_simple].damage_min = b.melee_attacks.simple.damage_min
tt.melee.attacks[tt.melee.sid_simple].damage_type = b.melee_attacks.simple.damage_type
tt.melee.attacks[tt.melee.sid_simple].hit_time = fts(8)
tt.melee.attacks[tt.melee.sid_simple].animation = "attack_3"
tt.melee.attacks[tt.melee.sid_simple].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_simple].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_simple].sound = "HeroWukongMeleeSimple"
tt.melee.attacks[tt.melee.sid_simple].sound_args = {
	delay = fts(10)
}
tt.melee.attacks[tt.melee.sid_fast_hits] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_fast_hits].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_fast_hits].basic_attack = true
tt.melee.attacks[tt.melee.sid_fast_hits].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_fast_hits].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_fast_hits].damage_max = b.melee_attacks.fast_hits.damage_max
tt.melee.attacks[tt.melee.sid_fast_hits].damage_min = b.melee_attacks.fast_hits.damage_min
tt.melee.attacks[tt.melee.sid_fast_hits].damage_type = b.melee_attacks.fast_hits.damage_type
tt.melee.attacks[tt.melee.sid_fast_hits].hit_times = {
	fts(12),
	fts(16),
	fts(21)
}
tt.melee.attacks[tt.melee.sid_fast_hits].loops = 1
tt.melee.attacks[tt.melee.sid_fast_hits].animations = {
	nil,
	"attack_4"
}
tt.melee.attacks[tt.melee.sid_fast_hits].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_fast_hits].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_fast_hits].sound = "HeroWukongMeleeFast"
tt.melee.attacks[tt.melee.sid_fast_hits].sound_args = {
	delay = fts(10)
}
tt.timed_attacks.sid_hair_clones = 1
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].animation = "clones"
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].cast_time = fts(26)
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].entity = {
	"soldier_hero_wukong_clone",
	"soldier_hero_wukong_clone_b"
}
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].max_range = b.hair_clones.max_range
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].min_targets = b.hair_clones.min_targets
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].min_cooldown = 5
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].fx = "fx_hero_wukong_clones_spawn"
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].sound = "HeroWukongClones"
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].sound_args = {
	delay = fts(15)
}
tt.timed_attacks.sid_giant_staff = 2
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff] = E:clone_c("melee_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].animation = "area_attack"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_appear_time = fts(24)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].hit_time = fts(38)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].min_cooldown = 5
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_template = "fx_hero_wukong_giant_staff"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_dust_template_back = "fx_hero_wukong_giant_staff_dust_cloud_back"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_dust_template_front = "fx_hero_wukong_giant_staff_dust_cloud_front"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_offset = v(17, 0)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].vis_flags = F_INSTAKILL
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].vis_bans = bor(tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].vis_bans, F_MINIBOSS, F_BOSS)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].instakill = true
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_DODGE)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_vis_flags = F_AREA
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_vis_bans = F_FLYING
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_max = b.giant_staff.area_damage.damage_max
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_min = b.giant_staff.area_damage.damage_min
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_radius = b.giant_staff.area_damage.damage_radius
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_type = b.giant_staff.area_damage.damage_type
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_max_targets = b.giant_staff.area_damage.max_targets
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].sound = "HeroWukongInstakill"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].sound_args = {
	delay = fts(15)
}
tt.timed_attacks.sid_pole_ranged = 3
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].animation = "attack_ranged"
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].shoot_time = fts(36)
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].min_cooldown = 5
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].staff_template = "decal_hero_wukong_ranged_attack_staff"
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].damage_type = b.pole_ranged.damage_type
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].max_range = b.pole_ranged.max_range
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].min_range = b.pole_ranged.min_range
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].min_targets = b.pole_ranged.min_targets
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].sound = "HeroWukongMultiStaff"
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].sound_args = {
	delay = fts(30)
}
tt.flywalk = {}
tt.flywalk.min_distance = b.distance_to_flywalk
tt.flywalk.extra_speed_mult = b.flywalk_speed_mult
tt.flywalk.animations = {
	"cloud_in",
	"cloud_loop",
	"cloud_out"
}
tt.flywalk.sound = nil
tt = E:register_t_10086("hero_douzhanshengfo", "hero_wukong")

b = balance.heroes.hero_douzhanshengfo
E:add_comps(tt, "melee", "timed_attacks")

tt.melee.sid_spin = 1
tt.melee.sid_jump = 2
tt.melee.sid_simple = 3
tt.melee.sid_fast_hits = 4
tt.hero.level_stats.armor = b.armor
tt.hero.level_stats.hp_max = b.hp_max
tt.hero.level_stats.melee_damage_max = {}
tt.hero.level_stats.melee_damage_min = {}
tt.hero.level_stats.melee_damage_max[tt.melee.sid_spin] = b.melee_attacks.spin.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_spin] = b.melee_attacks.spin.damage_min
tt.hero.level_stats.melee_damage_max[tt.melee.sid_jump] = b.melee_attacks.jump.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_jump] = b.melee_attacks.jump.damage_min
tt.hero.level_stats.melee_damage_max[tt.melee.sid_simple] = b.melee_attacks.simple.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_simple] = b.melee_attacks.simple.damage_min
tt.hero.level_stats.melee_damage_max[tt.melee.sid_fast_hits] = b.melee_attacks.fast_hits.damage_max
tt.hero.level_stats.melee_damage_min[tt.melee.sid_fast_hits] = b.melee_attacks.fast_hits.damage_min
tt.hero.level_stats.regen_health = b.regen_health
tt.hero.skills.hair_clones = E:clone_c("hero_skill")
tt.hero.skills.hair_clones.hr_icon = "0018"
tt.hero.skills.hair_clones.hr_order = 1
tt.hero.skills.hair_clones.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.hair_clones.hr_available = true
tt.hero.skills.hair_clones.cooldown = b.hair_clones.cooldown
tt.hero.skills.hair_clones.duration = b.hair_clones.soldier.duration
tt.hero.skills.hair_clones.hp_max = b.hair_clones.soldier.hp_max
tt.hero.skills.hair_clones.damage_min = b.hair_clones.soldier.melee_attack.damage_min
tt.hero.skills.hair_clones.damage_max = b.hair_clones.soldier.melee_attack.damage_max
tt.hero.skills.hair_clones.key = "HAIR_CLONES"
tt.hero.skills.hair_clones.xp_gain = b.hair_clones.xp_gain
tt.hero.skills.zhu_apprentice = E:clone_c("hero_skill")
tt.hero.skills.zhu_apprentice.smash_chance = b.zhu_apprentice.smash_attack.chance
tt.hero.skills.zhu_apprentice.hp_max = b.zhu_apprentice.hp_max
tt.hero.skills.zhu_apprentice.damage_min = b.zhu_apprentice.melee_attack.damage_min
tt.hero.skills.zhu_apprentice.damage_max = b.zhu_apprentice.melee_attack.damage_max
tt.hero.skills.zhu_apprentice.smash_damage_min = b.zhu_apprentice.smash_attack.damage_min
tt.hero.skills.zhu_apprentice.smash_damage_max = b.zhu_apprentice.smash_attack.damage_max
tt.hero.skills.zhu_apprentice.hr_available = true
tt.hero.skills.zhu_apprentice.hr_icon = "0016"
tt.hero.skills.zhu_apprentice.hr_order = 2
tt.hero.skills.zhu_apprentice.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.zhu_apprentice.entity = "soldier_hero_wukong_zhu_apprentice"
tt.hero.skills.zhu_apprentice.key = "ZHU_APPRENTICE"
tt.hero.skills.pole_ranged = E:clone_c("hero_skill")
tt.hero.skills.pole_ranged.hr_icon = "0018"
tt.hero.skills.pole_ranged.hr_order = 3
tt.hero.skills.pole_ranged.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.pole_ranged.hr_available = true
tt.hero.skills.pole_ranged.key = "POLE_RANGED"
tt.hero.skills.pole_ranged.cooldown = b.pole_ranged.cooldown
tt.hero.skills.pole_ranged.damage_max = b.pole_ranged.damage_max
tt.hero.skills.pole_ranged.damage_min = b.pole_ranged.damage_min
tt.hero.skills.pole_ranged.pole_amounts = b.pole_ranged.pole_amounts
tt.hero.skills.pole_ranged.xp_gain = b.pole_ranged.xp_gain
tt.hero.skills.giant_staff = E:clone_c("hero_skill")
tt.hero.skills.giant_staff.hr_icon = "0018"
tt.hero.skills.giant_staff.hr_order = 4
tt.hero.skills.giant_staff.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.giant_staff.hr_available = true
tt.hero.skills.giant_staff.cooldown = b.giant_staff.cooldown
tt.hero.skills.giant_staff.area_damage_min = b.giant_staff.area_damage.damage_min
tt.hero.skills.giant_staff.area_damage_max = b.giant_staff.area_damage.damage_max
tt.hero.skills.giant_staff.key = "GIANT_STAFF"
tt.hero.skills.giant_staff.xp_gain = b.giant_staff.xp_gain
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_icon = "0018"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.ultimate.hr_available = true
tt.hero.skills.ultimate.cooldown = b.ultimate.cooldown
tt.hero.skills.ultimate.damage_total = b.ultimate.damage_total
tt.hero.skills.ultimate.controller_name = "controller_hero_douzhanshengfo_ultimate"
tt.hero.skills.ultimate.key = "ULTIMATE"
tt.hero.skills.ultimate.slow_factor = b.ultimate.slow_factor
tt.hero.skills.ultimate.slow_duration = b.ultimate.slow_duration
tt.hero.team = TEAM_LINIREA
tt.health.dead_lifetime = b.dead_lifetime
tt.health_bar.offset = v(0, 45)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.hero_portrait = "kra_hero_portraits_0018"
tt.info.i18n_key = "HERO_DOUZHANSHENGFO"
tt.info.portrait = "portraits_hero_0018"
tt.info.ultimate_icon = "0018"
tt.info.stat_hp = b.stats.hp
tt.info.stat_armor = b.stats.armor
tt.info.stat_damage = b.stats.damage
tt.info.stat_cooldown = b.stats.cooldown
tt.info.damage_icon = "magic"
tt.info.fn = scripts.hero_basic.get_info_melee
tt.hero.fn_level_up = scripts.hero_wukong.level_up
tt.main_script.insert = scripts.hero_wukong.insert
tt.main_script.update = scripts.hero_wukong.update
tt.motion.max_speed = b.speed
tt.regen.cooldown = b.regen_cooldown
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_wukong_wukong"
tt.render.sprites[1].draw_order = DO_HEROES
tt.sound_events.change_rally_point =  "HeroWukongTauntZH"--i18n:cjk("HeroWukongTaunt", "HeroWukongTauntZH", nil, nil)
tt.sound_events.death = "HeroWukongDeathZH"--i18n:cjk("HeroWukongDeath", "HeroWukongDeathZH", nil, nil)
tt.sound_events.respawn = "HeroWukongTauntZHIntro"--i18n:cjk("HeroWukongTauntIntro", "HeroWukongTauntZHIntro", nil, nil)
tt.sound_events.hero_room_select = "HeroWukongTauntZHSelect"--i18n:cjk("HeroWukongTauntSelect", "HeroWukongTauntZHSelect", nil, nil)
tt.sound_death_sfx = "HeroWukongDeathSFX"
tt.soldier.melee_slot_offset = v(20, 0)
tt.unit.hit_offset = v(0, 23)
tt.unit.mod_offset = v(0, 23)
tt.unit.marker_offset = v(0, 0)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.ui.click_rect = r(-25, -13, 50, 66)
tt.ui.click_rect_fly = r(-25, -13, 50, 66)
tt.ui.click_rect_nofly = table.deepclone(tt.ui.click_rect)
tt.melee.range = 100
tt.melee.cooldown = b.melee_attacks.cooldown
tt.melee.can_repeat_attack = b.melee_attacks.can_repeat_attack
tt.melee.hit_animation = "fx_hero_wukong_hit"
tt.melee.hit_offset = v(25, 20)
tt.melee.attacks[tt.melee.sid_spin] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_spin].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_spin].basic_attack = true
tt.melee.attacks[tt.melee.sid_spin].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_spin].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_spin].damage_max = b.melee_attacks.spin.damage_max
tt.melee.attacks[tt.melee.sid_spin].damage_min = b.melee_attacks.spin.damage_min
tt.melee.attacks[tt.melee.sid_spin].damage_type = b.melee_attacks.spin.damage_type
tt.melee.attacks[tt.melee.sid_spin].hit_times = {
	fts(11),
	fts(16)
}
tt.melee.attacks[tt.melee.sid_spin].loops = 1
tt.melee.attacks[tt.melee.sid_spin].animations = {
	nil,
	"attack_1"
}
tt.melee.attacks[tt.melee.sid_spin].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_spin].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_spin].sound = "HeroWukongMeleeSpin"
tt.melee.attacks[tt.melee.sid_spin].sound_args = {
	delay = fts(10)
}
tt.melee.attacks[tt.melee.sid_jump] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_jump].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_jump].basic_attack = true
tt.melee.attacks[tt.melee.sid_jump].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_jump].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_jump].damage_max = b.melee_attacks.jump.damage_max
tt.melee.attacks[tt.melee.sid_jump].damage_min = b.melee_attacks.jump.damage_min
tt.melee.attacks[tt.melee.sid_jump].damage_type = b.melee_attacks.jump.damage_type
tt.melee.attacks[tt.melee.sid_jump].hit_time = fts(10)
tt.melee.attacks[tt.melee.sid_jump].animation = "attack_2"
tt.melee.attacks[tt.melee.sid_jump].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_jump].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_jump].sound = "HeroWukongMeleeJump"
tt.melee.attacks[tt.melee.sid_simple] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_simple].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_simple].basic_attack = true
tt.melee.attacks[tt.melee.sid_simple].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_simple].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_simple].damage_max = b.melee_attacks.simple.damage_max
tt.melee.attacks[tt.melee.sid_simple].damage_min = b.melee_attacks.simple.damage_min
tt.melee.attacks[tt.melee.sid_simple].damage_type = b.melee_attacks.simple.damage_type
tt.melee.attacks[tt.melee.sid_simple].hit_time = fts(8)
tt.melee.attacks[tt.melee.sid_simple].animation = "attack_3"
tt.melee.attacks[tt.melee.sid_simple].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_simple].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_simple].sound = "HeroWukongMeleeSimple"
tt.melee.attacks[tt.melee.sid_simple].sound_args = {
	delay = fts(10)
}
tt.melee.attacks[tt.melee.sid_fast_hits] = E:clone_c("melee_attack")
tt.melee.attacks[tt.melee.sid_fast_hits].shared_cooldown = true
tt.melee.attacks[tt.melee.sid_fast_hits].basic_attack = true
tt.melee.attacks[tt.melee.sid_fast_hits].xp_gain_factor = b.melee_attacks.spin.xp_gain_factor
tt.melee.attacks[tt.melee.sid_fast_hits].mod = "mod_hero_wukong_attacks_combos"
tt.melee.attacks[tt.melee.sid_fast_hits].damage_max = b.melee_attacks.fast_hits.damage_max
tt.melee.attacks[tt.melee.sid_fast_hits].damage_min = b.melee_attacks.fast_hits.damage_min
tt.melee.attacks[tt.melee.sid_fast_hits].damage_type = b.melee_attacks.fast_hits.damage_type
tt.melee.attacks[tt.melee.sid_fast_hits].hit_times = {
	fts(12),
	fts(16),
	fts(21)
}
tt.melee.attacks[tt.melee.sid_fast_hits].loops = 1
tt.melee.attacks[tt.melee.sid_fast_hits].animations = {
	nil,
	"attack_4"
}
tt.melee.attacks[tt.melee.sid_fast_hits].hit_fx = tt.melee.hit_animation
tt.melee.attacks[tt.melee.sid_fast_hits].hit_offset = tt.melee.hit_offset
tt.melee.attacks[tt.melee.sid_fast_hits].sound = "HeroWukongMeleeFast"
tt.melee.attacks[tt.melee.sid_fast_hits].sound_args = {
	delay = fts(10)
}
tt.timed_attacks.sid_hair_clones = 1
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].animation = "clones"
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].cast_time = fts(26)
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].entity = {
	"soldier_hero_wukong_clone",
	"soldier_hero_wukong_clone_b"
}
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].max_range = b.hair_clones.max_range
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].min_targets = b.hair_clones.min_targets
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].min_cooldown = 5
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].fx = "fx_hero_wukong_clones_spawn"
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].sound = "HeroWukongClones"
tt.timed_attacks.list[tt.timed_attacks.sid_hair_clones].sound_args = {
	delay = fts(15)
}
tt.timed_attacks.sid_giant_staff = 2
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff] = E:clone_c("melee_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].animation = "area_attack"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_appear_time = fts(24)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].hit_time = fts(38)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].min_cooldown = 5
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_template = "fx_hero_wukong_giant_staff"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_dust_template_back = "fx_hero_wukong_giant_staff_dust_cloud_back"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_dust_template_front = "fx_hero_wukong_giant_staff_dust_cloud_front"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].staff_offset = v(17, 0)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].vis_flags = F_INSTAKILL
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].vis_bans = bor(tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].vis_bans, F_MINIBOSS, F_BOSS)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].instakill = true
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_DODGE)
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_vis_flags = F_AREA
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_vis_bans = F_FLYING
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_max = b.giant_staff.area_damage.damage_max
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_min = b.giant_staff.area_damage.damage_min
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_radius = b.giant_staff.area_damage.damage_radius
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_type = b.giant_staff.area_damage.damage_type
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].area_damage_max_targets = b.giant_staff.area_damage.max_targets
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].sound = "HeroWukongInstakill"
tt.timed_attacks.list[tt.timed_attacks.sid_giant_staff].sound_args = {
	delay = fts(15)
}
tt.timed_attacks.sid_pole_ranged = 3
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].animation = "attack_ranged"
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].shoot_time = fts(36)
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].min_cooldown = 5
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].staff_template = "decal_hero_wukong_ranged_attack_staff"
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].damage_type = b.pole_ranged.damage_type
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].max_range = b.pole_ranged.max_range
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].min_range = b.pole_ranged.min_range
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].min_targets = b.pole_ranged.min_targets
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].sound = "HeroWukongMultiStaff"
tt.timed_attacks.list[tt.timed_attacks.sid_pole_ranged].sound_args = {
	delay = fts(30)
}
tt.flywalk = {}
tt.flywalk.min_distance = b.distance_to_flywalk
tt.flywalk.extra_speed_mult = b.flywalk_speed_mult
tt.flywalk.animations = {
	"cloud_in",
	"cloud_loop",
	"cloud_out"
}
tt.flywalk.sound = nil

tt = E:register_t_10086("enemy_lesser_sister_nightmare_hit_fx", "fx")
tt.render.sprites[1].name = "lesser_sister_nightmare_hit_fx"
tt = E:register_t_10086("enemy_fire_phoenix", "enemy_KR5")
b = balance.enemies.wukong.fire_phoenix

E:add_comps(tt, "tween")

tt.info.enc_icon = 94
tt.info.portrait = "gui_bottom_info_image_enemies_0099"
tt.enemy.gold = b.gold
tt.flight_height = 47
tt.fly_strenght = -5
tt.fly_frequency = 8
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, tt.flight_height + 44)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_fire_phoenix.update
tt.motion.max_speed = b.speed
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].prefix = "fire_phoenix_zhu_que_firephoenixzhuque"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].scale = vv(0.8)
tt.sound_events.death_custom = "EnemyFirePhoenixDeath"
tt.sound_events.death = nil
tt.ui.click_rect = r(-18, tt.flight_height - 10, 36, 32)
tt.unit.death_animation = "normal_death"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 4)
tt.unit.head_offset = v(0, 17)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.tween.disabled = false
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "quad"
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
tt.explode_nodes_limit = b.explode_nodes_limit
tt.decal_flaming_ground = "decal_fire_phoenix_flaming_ground"
tt = E:register_t_10086("enemy_blaze_raider", "enemy_KR5")

E:add_comps(tt, "melee")

b = balance.enemies.wukong.blaze_raider
tt.main_script.insert = scripts.enemy_basic_kr5_stage35.insert
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(36, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.enc_icon = 97
tt.info.portrait = "gui_bottom_info_image_enemies_0101"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.melee.attacks[1].disabled = true
tt.melee.attacks[1].cooldown = b.heavy_attack.cooldown
tt.melee.attacks[1].damage_max = b.heavy_attack.damage_max
tt.melee.attacks[1].damage_min = b.heavy_attack.damage_min
tt.melee.attacks[1].damage_type = b.heavy_attack.damage_type
tt.melee.attacks[1].animation = "attk_1"
tt.melee.attacks[1].hit_time = fts(18)
tt.melee.attacks[1].hit_fx = "fx_blaze_raider_melee_hit"
tt.melee.attacks[1].hit_offset = v(35, 5)
tt.melee.attacks[1].sound = "EnemyBlazeRaiderMeleeSpecial"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].disabled = false
tt.melee.attacks[2].cooldown = b.punzada_attack.cooldown
tt.melee.attacks[2].damage_max = b.punzada_attack.damage_max
tt.melee.attacks[2].damage_min = b.punzada_attack.damage_min
tt.melee.attacks[2].damage_type = b.punzada_attack.damage_type
tt.melee.attacks[2].animation = "attk_2"
tt.melee.attacks[2].hit_time = fts(12)
tt.melee.attacks[2].hit_fx = "fx_blaze_raider_melee_hit"
tt.melee.attacks[2].hit_offset = v(40, 15)
tt.melee.attacks[2].sound = nil
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[3].disabled = false
tt.melee.attacks[3].cooldown = b.double_attack.cooldown
tt.melee.attacks[3].damage_max = b.double_attack.damage_max
tt.melee.attacks[3].damage_min = b.double_attack.damage_min
tt.melee.attacks[3].damage_type = b.double_attack.damage_type
tt.melee.attacks[3].animation = "attk_3"
tt.melee.attacks[3].hit_times = {
	fts(12),
	fts(22)
}
tt.melee.attacks[3].hit_fx = "fx_blaze_raider_melee_hit"
tt.melee.attacks[3].hit_offset = v(38, 10)
tt.melee.attacks[3].sound = nil
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "blaze_rider"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.sound_events.death = "EnemyTuskedBrawlerDeath"
tt.ui.click_rect = r(-13, -3, 26, 32)
tt = E:register_t_10086("enemy_flame_guard", "enemy_KR5")

E:add_comps(tt, "melee")

b = balance.enemies.wukong.flame_guard
tt.main_script.insert = scripts.enemy_basic_kr5_stage35.insert
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 96
tt.info.portrait = "gui_bottom_info_image_enemies_0102"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack_02"
tt.melee.attacks[1].hit_times = {
	fts(18),
	fts(26)
}
tt.melee.attacks[1].sound = "EnemyCrocBasicMelee"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack_01"
tt.melee.attacks[2].hit_times = {
	fts(18),
	fts(26)
}
tt.melee.attacks[2].cooldown = b.special_attack.cooldown
tt.melee.attacks[2].damage_max = b.special_attack.damage_max
tt.melee.attacks[2].damage_min = b.special_attack.damage_min
tt.melee.attacks[2].damage_type = b.special_attack.damage_type
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].sound = "EnemyFlameGuardMeleeSpecial"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "flame_guard"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkup",
	"walkdown"
}
tt.sound_events.death = "EnemyTuskedBrawlerDeath"
tt.ui.click_rect = r(-13, -3, 26, 32)
tt = E:register_t_10086("enemy_wuxian", "enemy_KR5")

E:add_comps(tt, "melee", "timed_attacks")

b = balance.enemies.wukong.wuxian
tt.main_script.update = scripts.enemy_wuxian.update
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(36, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 53)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.info.enc_icon = 98
tt.info.portrait = "gui_bottom_info_image_enemies_0103"
tt.unit.hit_offset = v(0, 25)
tt.unit.head_offset = v(0, 45)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 25)
tt.unit.size = UNIT_SIZE_LARGE
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack_mele_2"
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].hit_fx = "fx_wuxian_melee_hit"
tt.melee.attacks[1].hit_fx_offset = v(48, 10)
tt.melee.attacks[1].sound = "EnemyCrocBasicMelee"
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].cooldown = b.kamehame_attack.cooldown
tt.melee.attacks[2].damage_max = b.kamehame_attack.damage_max
tt.melee.attacks[2].damage_min = b.kamehame_attack.damage_min
tt.melee.attacks[2].damage_type = b.kamehame_attack.damage_type
tt.melee.attacks[2].animation = "attack_mele"
tt.melee.attacks[2].hit_time = fts(16)
tt.melee.attacks[2].hit_fx = "fx_wuxian_kamehame_hit"
tt.melee.attacks[2].hit_fx_offset = v(55, 5)
tt.melee.attacks[2].sound = "EnemyWuxianSpecial"
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].vis_flags = 0
tt.melee.attacks[2].include_blocked = true
tt.melee.attacks[2].hit_offset = v(55, 0)
tt.melee.attacks[2].damage_radius = 90
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].animation = "attack_range"
tt.timed_attacks.list[1].bullet = "bullet_wuxian_bolt"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(0, 75)
}
tt.timed_attacks.list[1].cooldown = b.ranged_attack.cooldown
tt.timed_attacks.list[1].max_range = b.ranged_attack.max_range
tt.timed_attacks.list[1].min_range = b.ranged_attack.min_range
tt.timed_attacks.list[1].shoot_time = fts(27)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1].sound = "EnemyWuxianRanged"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "wuxian_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.sound_events.death = "EnemyWuxianDeath"
tt.ui.click_rect = r(-19, -3, 38, 37)
tt = E:register_t_10086("enemy_fire_fox", "enemy_KR5")

E:add_comps(tt, "melee", "death_spawns")

b = balance.enemies.wukong.fire_fox
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 25)
tt.info.enc_icon = 95
tt.info.portrait = "gui_bottom_info_image_enemies_0100"
tt.unit.hit_offset = v(0, 10)
tt.unit.head_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.unit.hide_after_death = true
tt.unit.show_blood_pool = false
tt.main_script.update = scripts.enemy_fire_fox.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].hit_time = fts(17)
tt.melee.attacks[1].sound = "EnemyFireFoxMelee"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "firefox_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkup",
	"walkdown"
}
tt.sound_events.death = "EnemyFireFoxDeath"
tt.ui.click_rect = r(-16, -3, 32, 30)
tt.death_spawns.name = "enemy_nine_tailed_fox"
tt.death_spawns.concurrent_with_death = false
tt.death_spawns.delay = fts(19)
tt.death_spawns.death_animation = "transformation_out"
tt.death_spawns.dead_lifetime = 0
tt.flaming_ground_decal_delay = fts(8)
tt.flaming_ground_decal = "decal_fire_fox_flaming_ground"
tt.transform_duration = b.transform_duration
tt.transform_hp_threshold = b.transform_hp_threshold
tt.transformation_sound = "EnemyUnblindedPriestTransformCast"
tt.transformation_end_sound = "EnemyUnblindedPriestTransformSpawn"
tt = E:register_t_10086("enemy_nine_tailed_fox", "enemy_KR5")

E:add_comps(tt, "melee", "timed_attacks")

b = balance.enemies.wukong.nine_tailed_fox
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(50, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 62)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.info.enc_icon = 101
tt.info.portrait = "gui_bottom_info_image_enemies_0106"
tt.unit.hit_offset = v(0, 20)
tt.unit.head_offset = v(0, 35)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.unit.size = UNIT_SIZE_LARGE
tt.main_script.update = scripts.enemy_nine_tailed_fox.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack_1"
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].hit_fx = "fx_nine_tailed_fox_hit"
tt.melee.attacks[1].hit_fx_offset = v(55, 5)
tt.melee.attacks[1].sound = "EnemyNineTailedFoxMelee"
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].cooldown = b.double_attack.cooldown
tt.melee.attacks[2].damage_max = b.double_attack.damage_max
tt.melee.attacks[2].damage_min = b.double_attack.damage_min
tt.melee.attacks[2].damage_type = b.double_attack.damage_type
tt.melee.attacks[2].include_blocked = true
tt.melee.attacks[2].hit_offset = v(55, 5)
tt.melee.attacks[2].damage_radius = 50
tt.melee.attacks[2].animation = "attack_2"
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.attacks[2].hit_times = {
	fts(13),
	fts(22)
}
tt.melee.attacks[2].hit_fx = "fx_nine_tailed_fox_hit"
tt.melee.attacks[2].sound = "EnemyNineTailedFoxMeleeDouble"
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[2])
tt.melee.attacks[3].cooldown = b.stun_attack.cooldown
tt.melee.attacks[3].damage_max = b.stun_attack.damage_max
tt.melee.attacks[3].damage_min = b.stun_attack.damage_min
tt.melee.attacks[3].damage_type = b.stun_attack.damage_type
tt.melee.attacks[3].mod = b.stun_attack.has_stun and "mod_nine_tailed_fox_stun_attack" or nil
tt.melee.attacks[3].hit_fx = "fx_nine_tailed_fox_hit_stun"
tt.melee.attacks[3].animation = "stun"
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation_start = "tp_in"
tt.timed_attacks.list[1].animation_end = "tp_out"
tt.timed_attacks.list[1].cooldown = b.teleport.cooldown
tt.timed_attacks.list[1].nodes_limit = b.teleport.nodes_limit
tt.timed_attacks.list[1].first_cooldown = b.teleport.first_cooldown
tt.timed_attacks.list[1].lava_paths_first_cooldown = b.teleport.lava_paths_first_cooldown
tt.timed_attacks.list[1].nodes_max = b.teleport.nodes_max
tt.timed_attacks.list[1].nodes_min = b.teleport.nodes_min
tt.timed_attacks.list[1].tp_speed = b.teleport.tp_speed
tt.timed_attacks.list[1].trail = "ps_nine_tailed_fox_underground_trail"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].mod = "mod_nine_tailed_fox_stun_teleport"
tt.timed_attacks.list[1].stun_fx1 = "fx_nine_tailed_fox_tp_stun_1"
tt.timed_attacks.list[1].stun_fx2 = "fx_nine_tailed_fox_tp_stun_2"
tt.timed_attacks.list[1].stun_decal = "fx_nine_tailed_fox_tp_stun_decal"
tt.timed_attacks.list[1].range = 90
tt.timed_attacks.list[1].vis_flags = F_AREA
tt.timed_attacks.list[1].vis_bans = F_NONE
tt.timed_attacks.list[1].sound_in = "EnemyNineTailedFoxTeleportIn"
tt.timed_attacks.list[1].sound_out = "EnemyNineTailedFoxTeleportOut"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "ninetailedfox_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.sound_events.death = "EnemyNineTailedFoxDeath"
tt.ui.click_rect = r(-18, -3, 36, 36)
tt.unit.show_blood_pool = false
tt = E:register_t_10086("enemy_burning_treant", "enemy_KR5")
b = balance.enemies.wukong.burning_treant

E:add_comps(tt, "melee")

tt.info.enc_icon = 99
tt.info.portrait = "gui_bottom_info_image_enemies_0104"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(37, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 60)
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_time = fts(18)
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].cooldown = b.area_attack.cooldown
tt.melee.attacks[2].damage_max = b.area_attack.damage_max
tt.melee.attacks[2].damage_min = b.area_attack.damage_min
tt.melee.attacks[2].damage_type = b.area_attack.damage_type
tt.melee.attacks[2].damage_radius = b.area_attack.radius
tt.melee.attacks[2].hit_time = fts(19)
tt.melee.attacks[2].hit_offset = v(35, 0)
tt.melee.attacks[2].hit_decal = "decal_burning_treant_flaming_ground"
tt.melee.attacks[2].animation = "area_attack"
tt.melee.attacks[2].sound = "EnemyBurningTreantSpecial"
tt.melee.attacks[2].sound_args = {
	delay = tt.melee.attacks[2].hit_time
}
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "burning_treant"
tt.render.sprites[1].draw_order = DO_ENEMY_BIG
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.ui.click_rect = r(-25, 0, 50, 50)
tt.unit.hit_offset = v(0, 22)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 19)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.can_explode = false
tt.unit.blood_color = BLOOD_GRAY
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.vis.flags = bor(F_ENEMY)
tt.sound_events.death = "EnemyBurningTreantDeath"
tt = E:register_t_10086("enemy_ash_spirit", "enemy_KR5")
b = balance.enemies.wukong.ash_spirit

E:add_comps(tt, "melee")

tt.info.enc_icon = 100
tt.info.portrait = "gui_bottom_info_image_enemies_0105"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(41, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 60)
tt.melee.attacks[1] = E:clone_c("area_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_decal = "decal_ash_spirit_hit"
tt.melee.attacks[1].hit_time = fts(23)
tt.melee.attacks[1].hit_offset = v(40, 0)
tt.melee.attacks[1].sound = "EnemyAshSpiritMelee"
tt.melee.attacks[1].sound_args = {
	delay = tt.melee.attacks[1].hit_time
}
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "ash_spiritDef"
tt.render.sprites[1].exo = true
tt.render.sprites[1].draw_order = DO_ENEMY_BIG
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-28, 0, 50, 53)
tt.unit.hit_offset = v(0, 26)
tt.unit.head_offset = v(0, 40)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 23)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.can_explode = false
tt.unit.blood_color = BLOOD_GRAY
tt.unit.show_blood_pool = false
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.sound_events.death = "EnemyAshSpiritDeath"
tt = E:register_t_10086("enemy_storm_spirit", "enemy_KR5")

E:add_comps(tt, "tween")

b = balance.enemies.wukong.storm_spirit
tt.info.enc_icon = 103
tt.info.portrait = "gui_bottom_info_image_enemies_0108"
tt.enemy.gold = b.gold
tt.flight_height = 40
tt.fly_strenght = 0
tt.fly_frequency = 10
tt.enemy.melee_slot = v(41, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 80)
tt.motion.max_speed = b.speed
tt.main_script.update = scripts.enemy_storm_spirit.update
tt.render.sid_unit = 1
tt.render.sid_shadow = 2
tt.render.sprites[tt.render.sid_unit].prefix = "stormspirit"
tt.render.sprites[tt.render.sid_unit].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[tt.render.sid_shadow] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_shadow].animated = false
tt.render.sprites[tt.render.sid_shadow].name = "decal_flying_shadow_hard"
tt.render.sprites[tt.render.sid_shadow].offset = v(0, 0)
tt.render.sprites[tt.render.sid_shadow].scale = vv(0.8)
tt.jump_ahead = {}
tt.jump_ahead.nodes_limit = b.jump_ahead.nodes_limit
tt.jump_ahead.max_nodes = b.jump_ahead.max_nodes
tt.jump_ahead.min_nodes = b.jump_ahead.min_nodes
tt.jump_ahead.hp_threshold = b.jump_ahead.hp_threshold
tt.jump_ahead.speed_mult = b.jump_ahead.speed_mult
tt.jump_ahead.zap_fx = "fx_storm_spirit_zap_in_out"
tt.jump_ahead.ps1 = "ps_storm_spirit_jump_ahead_trail_1"
tt.jump_ahead.ps2 = "ps_storm_spirit_jump_ahead_trail_2"
tt.jump_ahead.sound = "EnemyStormSpiritLeap"
tt.sound_events.death = "EnemyStormSpiritDeath"
tt.ui.click_rect = r(-18, tt.flight_height, 36, 32)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 4)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.tween.disabled = false
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "quad"
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
tt = E:register_t_10086("enemy_water_spirit", "enemy_KR5")

E:add_comps(tt, "melee")

b = balance.enemies.wukong.water_spirit
tt.info.i18n_key = "ENEMY_WATER_SPIRIT"
tt.info.enc_icon = 102
tt.info.portrait = "gui_bottom_info_image_enemies_0107"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(24, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 37)
tt.motion.max_speed = b.speed
tt.water_spawn_speed = b.water_spawn_speed
tt.main_script.insert = scripts.enemy_water_spirit.insert
tt.main_script.update = scripts.enemy_water_spirit.update
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].damage_type = b.melee_attack.damage_type
tt.melee.attacks[1].mod = "fx_water_spirit_hit"
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(12)
tt.render.sprites[1].prefix = "wukong_water_spirit_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-18, 0, 36, 32)
tt.unit.hit_offset = v(0, 15)
tt.unit.head_offset = v(0, 8)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 0)
tt.unit.size = UNIT_SIZE_SMALL
tt.splash_fx = "fx_water_spirit_splash"
tt.ps_trail_jump = "ps_water_spirit_trail_jump"
tt.ps_trail_swim = "ps_water_spirit_trail_swim"
tt.charco_caida_fx = "fx_water_spirit_charco_caida"
tt.sound_events.death = nil
tt = E:register_t_10086("enemy_water_spirit_spawnless", "enemy_water_spirit")
tt.skip_spawn_anim = true
tt = E:register_t_10086("enemy_qiongqi", "enemy_KR5")

E:add_comps(tt, "ranged")

b = balance.enemies.wukong.qiongqi
tt.info.enc_icon = 104
tt.info.portrait = "gui_bottom_info_image_enemies_0109"
tt.enemy.gold = b.gold
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 94)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.motion.max_speed = b.speed
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_qiongqi.update
tt.ranged.attacks[1].bullet = "bullet_qiongqi_lightning"
tt.ranged.attacks[1].bullet_start_offset = {
	v(30, 40)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].hold_advance = b.ranged_attack.hold_advance
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].shoot_time = fts(25)
tt.ranged.attacks[1].vis_bans = bor(tt.ranged.attacks[1].vis_bans, F_FLYING)
tt.render.sprites[1].anchor = vv(0.5)
tt.ranged.attacks[1].animation = "attack"
tt.render.sprites[1].prefix = "qiongqi_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_down",
	"walk_front"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].scale = vv(1.15)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].anchor = vv(0.5)
tt.render.sprites[3].animated = true
tt.render.sprites[3].prefix = "qiongqi_fx"
tt.render.sprites[3].name = "fly"
tt.render.sprites[3].ignore_start = true
tt.sound_events.death = "EnemyQiongqiDeath"
tt.ui.click_rect = r(-22, 30, 44, 40)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, 55)
tt.unit.head_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 55)
tt.flight_height = tt.unit.hit_offset.y
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = RT("enemy_gale_warrior", "enemy_KR5")

AC(tt, "melee")

b = balance.enemies.wukong.gale_warrior
tt.enemy.gold = b.gold
tt.enemy.lives_cost = b.lives_cost
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 48)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_GALE_WARRIOR"
tt.info.enc_icon = 105
tt.info.portrait = "gui_bottom_info_image_enemies_0110"
tt.melee.cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].mod = "mod_gale_warrior_combo_counter"
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].damage_max = b.puncturing_thrust.damage_max
tt.melee.attacks[2].damage_min = b.puncturing_thrust.damage_min
tt.melee.attacks[2].hit_time = fts(12)
tt.melee.attacks[2].damage_type = b.puncturing_thrust.damage_type
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].mod = "mod_gale_warrior_dot"
tt.melee.attacks[2].animation = "special_attack"
tt.combo_attacks_needed = b.puncturing_thrust.every_x_attacks
tt.combo_attacks_done = 0
tt.motion.max_speed = b.speed
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "gale_warrior"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.sound_events.death = "DeathHuman"
tt.ui.click_rect = r(-20, -5, 40, 40)
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(0, 20)
tt.unit.size = UNIT_SIZE_MEDIUM
tt = E:register_t_10086("enemy_storm_elemental", "enemy_KR5")
b = balance.enemies.wukong.storm_elemental

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.info.enc_icon = 107
tt.info.portrait = "gui_bottom_info_image_enemies_0112"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(41, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 70)
tt.main_script.update = scripts.enemy_storm_elemental.update
tt.melee.attacks[1] = E:clone_c("area_attack")
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[1].animation = "area_attack"
tt.melee.attacks[1].hit_decal = "decal_storm_elemental_area_melee"
tt.melee.attacks[1].sound = "EnemyElementalMelee"
tt.ranged.attacks[1].bullet = "bullet_storm_elemental"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-20, 120)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].hold_advance = b.ranged_attack.hold_advance
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].shoot_time = fts(44) - fts(27)
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].vis_bans = bor(tt.ranged.attacks[1].vis_bans, F_FLYING)
tt.ranged.attacks[1].ignore_hit_offset = true
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].vis_flags = F_CUSTOM
tt.timed_attacks.list[1].max_range = b.tower_block.range
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].spawn_on_instakill = b.tower_block.spawn_on_instakill
tt.timed_attacks.list[1].mod = "mod_enemy_storm_elemental_tower_debuff"
tt.timed_attacks.list[1].mark_mod = "mod_enemy_storm_elemental_tower_mark"
tt.timed_attacks.list[1].cast_sound = "EnemyElementalDeathEffectCast"
tt.timed_attacks.list[1].stun_sound = "EnemyElementalDeathEffectStun"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "storm_elemental_storm_unit"
tt.render.sprites[1].draw_order = DO_ENEMY_BIG
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = true
tt.render.sprites[2].name = "storm_elemental_vfx_bodyfx_run"
tt.render.sprites[2].loop = true
tt.render.sprites[2].ignore_start = true
tt.render.sprites[2].anchor = vv(0.5)
tt.render.sprites[2].offset = v(-35, 25)
tt.ui.click_rect = r(-28, 0, 56, 53)
tt.unit.hit_offset = v(0, 32)
tt.unit.head_offset = v(0, 21)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 27)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.can_explode = false
tt.unit.blood_color = BLOOD_NONE
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.sound_events.death = "EnemyElementalDeath"
tt.ps_walk_trail = "ps_storm_elemental_walk_trail"
tt = E:register_t_10086("enemy_water_sorceress", "enemy_KR5")

E:add_comps(tt, "melee", "ranged", "timed_attacks")

b = balance.enemies.wukong.water_sorceress
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 38)
tt.info.enc_icon = 106
tt.info.portrait = "gui_bottom_info_image_enemies_0111"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_water_sorceress.update
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].damage_type = b.melee_attack.damage_type
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].cooldown = b.melee_attack_escupida.cooldown
tt.melee.attacks[2].damage_max = b.melee_attack_escupida.damage_max
tt.melee.attacks[2].damage_min = b.melee_attack_escupida.damage_min
tt.melee.attacks[2].damage_type = b.melee_attack_escupida.damage_type
tt.melee.attacks[2].animation = "melee_2"
tt.melee.attacks[2].hit_time = fts(12)
tt.ranged.attacks[1].animation = "basic_attack"
tt.ranged.attacks[1].bullet = "bullet_water_sorceress_bolt"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 42)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.range
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(12)
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].vis_flags = F_CUSTOM
tt.timed_attacks.list[1].safe_nodes = b.heal_wave.safe_nodes
tt.timed_attacks.list[1].cooldown = b.heal_wave.cooldown
tt.timed_attacks.list[1].first_cooldown = b.heal_wave.first_cooldown
tt.timed_attacks.list[1].nodes_range = b.heal_wave.nodes_range
tt.timed_attacks.list[1].wave_decal = "decal_water_sorceress_heal_wave"
tt.timed_attacks.list[1].animation = "special_attack"
tt.timed_attacks.list[1].sound = "EnemyWaterSorceressSpecial"
tt.unit.show_blood_pool = false
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "watersorceress"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.sound_events.death = "EnemyTuskedBrawlerDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)
tt = E:register_t_10086("enemy_fan_guard", "enemy_KR5")
b = balance.enemies.wukong.fan_guard

E:add_comps(tt, "melee")

tt.info.enc_icon = 114
tt.info.portrait = "gui_bottom_info_image_enemies_0119"
tt.main_script.update = scripts.enemy_fan_guard.update
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.walking_armor = b.walking_armor
tt.health.blocking_armor = b.blocking_armor
tt.health.walking_magic_armor = b.walking_magic_armor
tt.health.blocking_magic_armor = b.blocking_magic_armor
tt.health.armor = b.walking_armor
tt.health.magic_armor = b.walking_magic_armor
tt.health_bar.offset = v(0, 50)
tt.melee.cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].animation = "melee_1"
tt.melee.attacks[1].hit_times = {
	fts(10),
	fts(27)
}
tt.melee.attacks[1].hit_fx = "fx_enemy_fan_guard_melee_hit"
tt.melee.attacks[1].hit_offset = v(23, 13)
tt.melee.attacks[1].hit_damage_factor = b.basic_attack.hit_damage_factor
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].chance = 0.35
tt.melee.attacks[2].animation = "melee_2"
tt.melee.attacks[2].hit_times = {
	fts(8),
	fts(25)
}
tt.melee.attacks[2].hit_fx = "fx_enemy_fan_guard_melee_hit"
tt.melee.attacks[2].hit_offset = v(23, 13)
tt.melee.attacks[2].hit_damage_factor = b.basic_attack.hit_damage_factor
tt.melee.attacks[3] = E:clone_c("melee_attack")
tt.melee.attacks[3].cooldown = b.heavy_attack.cooldown
tt.melee.attacks[3].damage_max = b.heavy_attack.damage_max
tt.melee.attacks[3].damage_min = b.heavy_attack.damage_min
tt.melee.attacks[3].damage_type = b.heavy_attack.damage_type
tt.melee.attacks[3].shared_cooldown = false
tt.melee.attacks[3].animation = "melee_3"
tt.melee.attacks[3].hit_times = {
	fts(9),
	fts(43)
}
tt.melee.attacks[3].hit_fx = "fx_enemy_fan_guard_melee_hit"
tt.melee.attacks[3].hit_offset = v(23, 13)
tt.melee.attacks[3].hit_damage_factor = b.heavy_attack.hit_damage_factor
tt.melee.attacks[3].sound = "EnemyFanGuardSpecial"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "fan_guard"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.blocking_idle_in = "idle_in"
tt.render.blocking_idle_loop = "idle_loop"
tt.render.blocking_idle_out = "idleout"
tt.ui.click_rect = r(-15, 0, 30, 40)
tt.unit.hit_offset = v(0, 17)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.blood_color = BLOOD_RED
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.sound_events.death = "EnemyFanGuardDeath"
tt = E:register_t_10086("enemy_hellfire_warlock", "enemy_KR5")
b = balance.enemies.wukong.hellfire_warlock

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.info.enc_icon = 123
tt.info.portrait = "gui_bottom_info_image_enemies_0128"
tt.main_script.update = scripts.enemy_hellfire_warlock.update
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 50)
tt.health.dead_lifetime = 5
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = b.melee_horizontal.cooldown
tt.melee.attacks[1].damage_max = b.melee_horizontal.damage_max
tt.melee.attacks[1].damage_min = b.melee_horizontal.damage_min
tt.melee.attacks[1].damage_type = b.melee_horizontal.damage_type
tt.melee.attacks[1].animation = "mele_2"
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.attacks[1].hit_fx = "fx_hellfire_warlock_melee_hit"
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].max_range = b.ranged.range
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].cooldown = b.ranged.cooldown
tt.ranged.attacks[1].bullet = "bullet_hellfire_warlock_fireball"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-5, 68)
}
tt.ranged.attacks[1].shoot_time = fts(11)
tt.ranged.attacks[1].node_prediction = fts(17)
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[1].hold_advance = true
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation_start = "summon_in"
tt.timed_attacks.list[1].animation_loop = "summon_loop"
tt.timed_attacks.list[1].animation_completed = "summon_casted"
tt.timed_attacks.list[1].animation_canceled = "summon_canceled"
tt.timed_attacks.list[1].summon_floor_fx = "decal_hellfire_warlock_summon_decal"
tt.timed_attacks.list[1].staff_floor_fx = "fx_hellfire_warlock_summong_floor_staff"
tt.timed_attacks.list[1].loop_duration = b.summon_fox.loop_duration
tt.timed_attacks.list[1].summon_time = fts(0)
tt.timed_attacks.list[1].cooldown = b.summon_fox.cooldown
tt.timed_attacks.list[1].first_cooldown = b.summon_fox.first_cooldown
tt.timed_attacks.list[1].cancelled_cooldown = b.summon_fox.cancelled_cooldown
tt.timed_attacks.list[1].nodes_limit = b.summon_fox.nodes_limit
tt.timed_attacks.list[1].fox_position = v(0, -30)
tt.timed_attacks.list[1].entity = "fx_nine_tailed_fox_summon"
tt.timed_attacks.list[1].sound_channel = "EnemyWarlockSummonChannel"
tt.timed_attacks.list[1].sound_spawn = "EnemyWarlockSummonSpawn"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "hellfire_warlock_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-15, 0, 30, 40)
tt.unit.hit_offset = v(0, 17)
tt.unit.head_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.blood_color = BLOOD_RED
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.sound_events.death = "EnemyWarlockDeath"
tt = E:register_t_10086("boss_redboy_teen", "boss")
b = balance.enemies.wukong.boss_redboy_teen

E:add_comps(tt, "melee", "timed_attacks")

tt.scale = 0.8
tt.enemy.lives_cost = 999
tt.enemy.melee_slot = v(45 * tt.scale, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 1e+99
tt.health_bar.offset = v(0, 130 * tt.scale)
tt.unit.hit_offset = v(0, 40 * tt.scale)
tt.unit.head_offset = v(0, 110 * tt.scale)
tt.unit.mod_offset = v(0, 40 * tt.scale)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-27 * tt.scale, 0, 50 * tt.scale, 100 * tt.scale)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_GREEN
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_BOSS_REDBOY_TEEN"
tt.info.enc_icon = 109
tt.info.portrait = "gui_bottom_info_image_enemies_0114"
tt.info.portrait_boss = "boss_health_bar_icon_0011"
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.exo_anim_map = {
	Stun_in = "teen_redboy_ADef",
	jump_fly_down = "teen_redboy_BDef",
	idle = "teen_redboy_ADef",
	attack_basic_c = "teen_redboy_ADef",
	jump_in = "teen_redboy_BDef",
	attack_basic_b = "teen_redboy_ADef",
	attack_basic_a = "teen_redboy_ADef",
	screen_block = "teen_redboy_ADef",
	Stun_loop = "teen_redboy_ADef",
	death_in = "teen_redboy_BDef",
	samadhi_loop = "teen_redboy_BDef",
	samadhi_out = "teen_redboy_BDef",
	jump_end = "teen_redboy_BDef",
	baculo = "teen_redboy_BDef",
	death_hit = "teen_redboy_BDef",
	talk_02 = "teen_redboy_BDef",
	jump_in_02 = "teen_redboy_BDef",
	Stun_end = "teen_redboy_ADef",
	jump_fly_up_02 = "teen_redboy_BDef",
	jump_fly_up = "teen_redboy_BDef",
	jump_fly_down_02 = "teen_redboy_BDef",
	summon = "teen_redboy_ADef",
	samadhi = "teen_redboy_BDef",
	walk = "teen_redboy_ADef",
	walk_down = "teen_redboy_ADef",
	talk = "teen_redboy_BDef",
	jump_out = "teen_redboy_BDef",
	fireabsorb = "teen_redboy_BDef",
	jump_end_2 = "teen_redboy_BDef"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].exo = true
tt.render.sprites[1].prefix = "teen_redboy_ADef"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[1].scale = vv(tt.scale)
tt.render.sid_debug_circle = 2
tt.render.sprites[tt.render.sid_debug_circle] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_debug_circle].z = Z_DECALS
tt.render.sprites[tt.render.sid_debug_circle].animated = false
tt.render.sprites[tt.render.sid_debug_circle].name = "decal_tower_hover_default_0009"
tt.render.sprites[tt.render.sid_debug_circle].scale = vv(1)
tt.render.sprites[tt.render.sid_debug_circle].scale_mult = 0.7142857142857143
tt.render.sprites[tt.render.sid_debug_circle].hidden = true
tt.render.sprites[tt.render.sid_debug_circle].color = {
	255,
	0,
	0
}
tt.unit.show_blood_pool = false
tt.spawn_pos = b.spawn_pos
tt.main_script.insert = scripts.boss_redboy_teen.insert
tt.main_script.update = scripts.boss_redboy_teen.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack_basic_b"
tt.melee.attacks[1].hit_time = fts(23)
tt.melee.attacks[1].hit_fx = "fx_redboy_teen_hit"
tt.melee.attacks[1].hit_offset = v(55 * tt.scale, 5)
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack_basic_c"
tt.melee.attacks[2].chance = 0.2
tt.melee.attacks[2].hit_time = fts(20)
tt.melee.attacks[2].hit_decal = nil
tt.melee.attacks[1].hit_fx = "fx_redboy_teen_hit"
tt.melee.attacks[3] = E:clone_c("area_attack")
tt.melee.attacks[3].cooldown = b.area_attack.cooldown
tt.melee.attacks[3].damage_max = b.area_attack.damage_max
tt.melee.attacks[3].damage_min = b.area_attack.damage_min
tt.melee.attacks[3].damage_type = b.area_attack.damage_type
tt.melee.attacks[3].include_blocked = true
tt.melee.attacks[3].hit_offset = v(55 * tt.scale, 5)
tt.melee.attacks[3].damage_radius = b.area_attack.damage_radius
tt.melee.attacks[3].include_blocked = true
tt.melee.attacks[3].animation = "attack_basic_a"
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.attacks[3].hit_time = fts(19)
tt.melee.attacks[3].hit_fx = "fx_nine_tailed_fox_tp_stun_decal"
tt.melee.attacks[3].sound = "EnemyCrocBasicMelee"
tt.melee.attacks[3].chance = 0.4
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "summon"
tt.timed_attacks.list[1].first_cooldown = b.groundfire.first_cooldown
tt.timed_attacks.list[1].cooldown = b.groundfire.cooldown
tt.timed_attacks.list[1].cast_time = fts(20)
tt.timed_attacks.list[1].entity = "decal_redboy_teen_skyrock"
tt.timed_attacks.list[1].decal = "fx_redboy_teen_floor_fire_decal"
tt.timed_attacks.list[1].decal_offset = v(20 * tt.scale, 0)
tt.timed_attacks.list[1].nodes_limit = b.groundfire.nodes_limit
tt.timed_attacks.list[2] = E:clone_c("custom_attack")
tt.timed_attacks.list[2].animation = "screen_block"
tt.timed_attacks.list[2].first_cooldown = b.heartfire.first_cooldown
tt.timed_attacks.list[2].cooldown = b.heartfire.cooldown
tt.timed_attacks.list[2].cast_time = fts(44)
tt.timed_attacks.list[2].fx_time = fts(20)
tt.timed_attacks.list[2].duration = b.heartfire.duration
tt.timed_attacks.list[2].nodes_limit = b.heartfire.nodes_limit
tt.timed_attacks.list[2].hand_fx = "fx_redboy_teen_hand"
tt.timed_attacks.list[2].hand_fx_offset = v(-20 * tt.scale, 70 * tt.scale)
tt.timed_attacks.list[3] = E:clone_c("custom_attack")
tt.timed_attacks.list[3].animation_start = "samadhi"
tt.timed_attacks.list[3].animation_loop = "samadhi_loop"
tt.timed_attacks.list[3].animation_end = "samadhi_out"
tt.timed_attacks.list[3].activate_on_positions = b.skyfire.activate_on_positions
tt.timed_attacks.list[3].cast_time = fts(55)
tt.timed_attacks.list[4] = E:clone_c("area_attack")
tt.timed_attacks.list[4].animation = "fireabsorb"
tt.timed_attacks.list[4].absorb_time = fts(25)
tt.timed_attacks.list[4].cast_time = fts(46)
tt.timed_attacks.list[4].damage_max = b.fireabsorb.damage_max
tt.timed_attacks.list[4].damage_min = b.fireabsorb.damage_min
tt.timed_attacks.list[4].damage_type = b.fireabsorb.damage_type
tt.timed_attacks.list[4].damage_radius = b.fireabsorb.damage_radius
tt.timed_attacks.list[4].minimum_fires = b.fireabsorb.minimum_fires
tt.timed_attacks.list[4].absorb_radius = b.fireabsorb.absorb_radius
tt.timed_attacks.list[4].nodes_limit = b.fireabsorb.nodes_limit
tt.timed_attacks.list[4].cooldown = b.fireabsorb.cooldown
tt.timed_attacks.list[4].first_cooldown = b.fireabsorb.first_cooldown
tt.timed_attacks.list[4].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[4].vis_flags = bor(F_AREA)
tt.timed_attacks.list[4].decal = "fx_redboy_fireabsorb_decal"
tt.timed_attacks.list[5] = E:clone_c("custom_attack")
tt.timed_attacks.list[5].animation_start = "Stun_in"
tt.timed_attacks.list[5].animation_loop = "Stun_loop"
tt.timed_attacks.list[5].animation_end = "Stun_end"
tt.timed_attacks.list[5].nodes_limit = b.stun_towers.nodes_limit
tt.timed_attacks.list[5].cooldown = b.stun_towers.cooldown
tt.timed_attacks.list[5].first_cooldown = b.stun_towers.first_cooldown
tt.timed_attacks.list[5].side = b.stun_towers.side
tt.timed_attacks.list[5].disabled = true
tt.change_path_node_start_pos = b.change_path.node_start_pos
tt.change_path_target = b.change_path.target
tt.change_path_meteorite_side = b.change_path.meteorite_side
tt.vis.flags_jumping = bor(F_ENEMY, F_BOSS)
tt.vis.bans_jumping = bor(F_RANGED, F_BLOCK, F_MOD)
tt.vis.flags_normal = bor(F_ENEMY, F_BOSS)
tt.vis.bans_normal = 0
tt = E:register_t_10086("enemy_citizen", "enemy_KR5")

E:add_comps(tt, "melee")

b = balance.enemies.wukong.citizen
tt.main_script.insert = scripts.enemy_citizen.insert
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(22, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 108
tt.info.i18n_key = "ENEMY_CITIZEN"
tt.info.portrait = "gui_bottom_info_image_enemies_0113"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.melee.cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.attacks[1].sound = "EnemyCrocBasicMelee"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "stage33_pueblerino1"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.sound_events.death = "EnemyTuskedBrawlerDeath"
tt.ui.click_rect = r(-13, -3, 26, 32)
tt = E:register_t_10086("enemy_citizen_1", "enemy_citizen")
tt.info.i18n_key = "ENEMY_CITIZEN_1"
tt = E:register_t_10086("enemy_citizen_2", "enemy_citizen")
tt.melee.attacks[1].hit_time = fts(8)
tt.render.sprites[1].prefix = "stage33_pueblerino2"
tt.health_bar.offset = v(0, 43)
tt.info.portrait = "gui_bottom_info_image_enemies_0115"
tt.info.i18n_key = "ENEMY_CITIZEN_2"
tt = E:register_t_10086("enemy_citizen_3", "enemy_citizen")
tt.health_bar.offset = v(0, 35)
tt.melee.attacks[1].animation = "atack_2"
tt.melee.attacks[1].hit_times = {
	fts(19),
	fts(23),
	fts(27),
	fts(31)
}
tt.melee.attacks[1].hit_fx = "fx_citizen_3_melee_1_hit"
tt.melee.attacks[1].hit_fx_offset = v(20, 10)
tt.melee.attacks[1].hit_fx_once = true
tt.render.sprites[1].prefix = "pueblerino_3_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.info.portrait = "gui_bottom_info_image_enemies_0116"
tt.info.i18n_key = "ENEMY_CITIZEN_3"
tt = E:register_t_10086("enemy_citizen_4", "enemy_citizen")
tt.health_bar.offset = v(0, 35)
tt.melee.attacks[1].animation = "atack_1"
tt.melee.attacks[1].hit_times = {
	fts(15),
	fts(22),
	fts(30),
	fts(36)
}
tt.melee.attacks[1].hit_fx = "fx_citizen_4_melee_1_hit"
tt.melee.attacks[1].hit_fx_offset = v(20, 10)
tt.melee.attacks[1].hit_fx_once = true
tt.render.sprites[1].prefix = "pueblerino_4_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.info.portrait = "gui_bottom_info_image_enemies_0117"
tt.info.i18n_key = "ENEMY_CITIZEN_4"
tt = E:register_t_10086("generic_unit_spawn_scale")

E:add_comps(tt, "main_script")

tt.scale_down = 0.7
tt.scale_duration = 0.6
tt.scale_start_delay = 0.5
tt.push_and_pop_bans = scripts.generic_unit_spawn_scale.push_and_pop_bans
tt.main_script.update = scripts.generic_unit_spawn_scale.update
tt = E:register_t_10086("enemy_terracota", "enemy_KR5")

E:add_comps(tt, "melee")

b = balance.enemies.wukong.terracota
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(27, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 1
tt.info.portrait = "gui_bottom_info_image_enemies_0120"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.blood_color = BLOOD_NONE
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(30)
tt.melee.attacks[1].hit_fx = "fx_terracota_hit"
tt.melee.attacks[1].hit_fx_offset = v(27, 10)
tt.melee.attacks[1].hit_fx_once = true
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "terracota"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkup",
	"walkdown"
}
tt.ui.click_rect = r(-13, -3, 26, 32)
tt.main_script.update = scripts.enemy_terracota.update
tt = E:register_t_10086("enemy_big_terracota", "enemy_KR5")

E:add_comps(tt, "melee")

b = balance.enemies.wukong.big_terracota
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(27, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 48)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.enc_icon = 1
tt.info.portrait = "gui_bottom_info_image_enemies_0121"
tt.unit.hit_offset = v(0, 24)
tt.unit.head_offset = v(0, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 25)
tt.unit.blood_color = BLOOD_NONE
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[1].hit_fx = "fx_terracota_hit"
tt.melee.attacks[1].hit_fx_offset = v(27, 10)
tt.melee.attacks[1].hit_fx_once = true
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "big_terracota"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkup",
	"walkdown"
}
tt.ui.click_rect = r(-19, -5, 38, 43)
tt.main_script.update = scripts.enemy_terracota.update
tt = E:register_t_10086("enemy_palace_guard", "enemy_KR5")

E:add_comps(tt, "melee")

b = balance.enemies.wukong.palace_guard
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 113
tt.info.portrait = "gui_bottom_info_image_enemies_0118"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack_01"
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack_02"
tt.melee.attacks[2].hit_time = fts(10)
tt.melee.attacks[2].cooldown = b.special_attack.cooldown
tt.melee.attacks[2].damage_max = b.special_attack.damage_max
tt.melee.attacks[2].damage_min = b.special_attack.damage_min
tt.melee.attacks[2].damage_type = b.special_attack.damage_type
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "palace_guard"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkup",
	"walkdown"
}
tt.sound_events.death = "EnemyTuskedBrawlerDeath"
tt.ui.click_rect = r(-13, -3, 26, 32)
tt = E:register_t_10086("enemy_golden_eyed", "enemy_KR5")

local b = balance.enemies.wukong.golden_eyed

E:add_comps(tt, "melee", "timed_attacks")

tt.info.enc_icon = 121
tt.info.portrait = "gui_bottom_info_image_enemies_0126"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(55, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 80)
tt.main_script.insert = scripts.enemy_golden_eyed.insert
tt.main_script.update = scripts.enemy_golden_eyed.update
tt.main_script.remove = scripts.enemy_golden_eyed.remove
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_times = {
	fts(20)
}
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_offset = v(50, 15)
tt.melee.attacks[1].type = "area"
tt.melee.attacks[1].vis_bans = F_FLYING
tt.melee.attacks[1].vis_flags = F_RANGED
tt.melee.attacks[1].damage_bans = F_FLYING
tt.melee.attacks[1].damage_flags = F_AREA
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].hit_fx = "fx_golden_eyed_melee_hit"
tt.melee.attacks[1].sound = "EnemyGoldenEyedMelee"
tt.timed_attacks.list[1] = E:clone_c("aura_attack")
tt.timed_attacks.list[1].animation = "skill1"
tt.timed_attacks.list[1].cast_time = fts(24)
tt.timed_attacks.list[1].cooldown = b.aura.cooldown
tt.timed_attacks.list[1].max_range = b.aura.trigger_range
tt.timed_attacks.list[1].min_targets = b.aura.min_targets
tt.timed_attacks.list[1].nodes_limit_start = b.aura.nodes_limit_start
tt.timed_attacks.list[1].nodes_limit_end = b.aura.nodes_limit_end
tt.timed_attacks.list[1].aura = "aura_enemy_golden_eyed"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].sound = "EnemyGoldenEyedAura"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "goldeneye_beast_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-25, -3, 50, 50)
tt.unit.hit_offset = v(0, 23)
tt.unit.head_offset = v(0, 35)
tt.unit.marker_offset = v(-1, 0)
tt.unit.mod_offset = v(0, 23)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.vis.flags = bor(F_ENEMY, F_MINIBOSS)
tt.vis.bans = bor(F_POLYMORPH, F_DRILL, F_INSTAKILL, F_DISINTEGRATED, F_EAT)
tt.sound_events.death = "EnemyGoldenEyedDeath"
tt = E:register_t_10086("aura_enemy_golden_eyed", "aura")
b = balance.enemies.wukong.golden_eyed.aura
tt.aura.duration = b.duration
tt.aura.radius = b.aura_radius
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.vis_flags = bor(F_RANGED, F_AREA)
tt.aura.mod = "mod_enemy_golden_eyed_buff"
tt.aura.cycle_time = b.cycle_time
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.filter_source = true
tt = E:register_t_10086("fx_golden_eyed_melee_hit", "fx")
tt.render.sprites[1].exo = true
tt.render.sprites[1].prefix = "goldeneye_beast_hit"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].hide_after_runs = 1
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = E:register_t_10086("mod_enemy_golden_eyed_buff", "modifier")
b = balance.enemies.wukong.golden_eyed.aura

E:add_comps(tt, "render", "fast", "tween")

tt.main_script.insert = scripts.mod_enemy_golden_eyed_buff.insert
tt.main_script.update = scripts.mod_enemy_golden_eyed_buff.update
tt.main_script.remove = scripts.mod_enemy_golden_eyed_buff.remove
tt.modifier.use_mod_offset = false
tt.fast.factor = b.mod.speed_factor
tt.modifier.duration = b.mod.duration
tt.target_self = b.target_self
tt.render.sprites[1].name = "goldeneye_beast_modifier"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	},
	{
		b.mod.duration - 0.5,
		255
	},
	{
		b.mod.duration,
		0
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		vv(0.9)
	},
	{
		0.3,
		vv(1.1)
	},
	{
		0.6,
		vv(0.9)
	}
}
tt.tween.props[2].loop = true
tt = E:register_t_10086("golden_eyed_shadow", "decal")
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "goldeneye_beast_shadow"
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("enemy_doom_bringer", "enemy_KR5")

E:add_comps(tt, "melee", "timed_attacks")

b = balance.enemies.wukong.doom_bringer
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(38, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 59)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.enc_icon = 122
tt.info.portrait = "gui_bottom_info_image_enemies_0127"
tt.unit.hit_offset = v(0, 26)
tt.unit.head_offset = v(0, 23)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 27)
tt.main_script.update = scripts.enemy_doom_bringer.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].hit_time = fts(9)
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "skill_1"
tt.timed_attacks.list[1].first_cooldown = b.tower_curse.first_cooldown
tt.timed_attacks.list[1].cast_time = fts(22)
tt.timed_attacks.list[1].cooldown = b.tower_curse.cooldown
tt.timed_attacks.list[1].nodes_limit = b.tower_curse.nodes_limit
tt.timed_attacks.list[1].max_range = b.tower_curse.range
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].mod = "mod_doom_bringer_tower_block"
tt.timed_attacks.list[1].mark_mod = "mod_doom_bringer_tower_block_mark"
tt.timed_attacks.list[1].sound = "EnemyDoomBringerStun"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "doom_bringer_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-19, -5, 38, 43)
tt.sound_events.death = "EnemyDoomBringerDeath"
tt = E:register_t_10086("enemy_demon_minotaur", "enemy_KR5")
b = balance.enemies.wukong.demon_minotaur

E:add_comps(tt, "melee", "timed_attacks")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(37, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 80)
tt.info.enc_icon = 120
tt.info.portrait = "gui_bottom_info_image_enemies_0125"
tt.unit.hit_offset = v(0, 26)
tt.unit.head_offset = v(0, 7)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_demon_minotaur.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].hit_time = fts(41)
tt.melee.attacks[1].hit_fx = "fx_demon_minotaur_hit"
tt.melee.attacks[1].hit_offset = v(37, 10)
tt.melee.attacks[1].sound = "EnemyDemonMinotaurHeadButt"
tt.melee.attacks[1].animation = "mele_1"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "melee_2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[2].hit_time = fts(44)
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "charge"
tt.timed_attacks.list[1].max_duration = b.charge.max_duration
tt.timed_attacks.list[1].speed = b.charge.speed
tt.timed_attacks.list[1].charge_in_speed = 60
tt.timed_attacks.list[1].vis_flags = bor(F_AREA)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1].range_jump = b.charge.range_jump
tt.timed_attacks.list[1].range_damage = b.charge.range_damage
tt.timed_attacks.list[1].damage_min = b.charge.damage_min
tt.timed_attacks.list[1].damage_max = b.charge.damage_max
tt.timed_attacks.list[1].damage_type = b.charge.damage_type
tt.timed_attacks.list[1].particles_name_a = "ps_enemy_demon_minotaur_charge_a"
tt.timed_attacks.list[1].mod_stun = "mod_stun"
tt.timed_attacks.list[1].particles_name_b = "ps_enemy_demon_minotaur_charge_b"
tt.timed_attacks.list[1].sound_loop = "EnemyDemonMinotaurChargeTrample"
tt.timed_attacks.list[1].sound_attack = "EnemyDemonMinotaurChargeStop"
tt.timed_attacks.list[1].decal_crack = "decal_demon_minotaur_area_crack"
tt.timed_attacks.list[1].decal_smoke = "decal_demon_minotaur_area_smoke"
tt.timed_attacks.list[1].hit_fx = "fx_demon_minotaur_hit"
tt.timed_attacks.list[1].rebote_fx = "fx_demon_minotaur_rebote"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "demon_minotaur_unit"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[1].angles.charge = {
	"charge",
	"charge_up",
	"charge_down"
}
tt.render.sprites[1].angles.charge_attack_in = {
	"charge_attack_in",
	"charge_attack_in",
	"charge_attack_in"
}
tt.render.sprites[1].angles.rebote = {
	"rebote",
	"rebote",
	"rebote_frente"
}
tt.render.sprites[1].angles_custom = {
	charge = {
		55,
		115,
		245,
		305
	}
}
tt.ui.click_rect = r(-30, -3, 60, 65)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.vis.flags = bor(F_ENEMY, F_MINIBOSS)
tt.vis.bans = bor(F_INSTAKILL, F_POLYMORPH, F_DISINTEGRATED, F_CANNIBALIZE, F_EAT)
tt.sound_events.insert = "EnemyDemonMinotaurChargeWarning"
tt.sound_events.death = "EnemyDemonMinotaurDeath"
tt = E:register_t_10086("bullet_qiongqi_lightning", "bullet")
b = balance.enemies.wukong.qiongqi.ranged_attack
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_radius = b.damage_radius
tt.bullet.hit_time = fts(1)
tt.image_width = 100
tt.main_script.update = scripts.ray_qiongqi.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "qiongqi_attack"
tt.render.sprites[1].loop = false
tt.track_target = false
tt.ray_duration = fts(10)
tt.sound_events.insert = "EnemyQiongqiRanged"
tt = E:register_t_10086("bullet_storm_elemental", "bombKR5")
b = balance.enemies.wukong.storm_elemental.ranged_attack
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.bullet_storm_elemental.update
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_radius = 62.400000000000006
tt.render.sprites[1].prefix = "storm_elemental_vfx_proyectile"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = vv(0.7)
tt.start_fx = "fx_storm_elemental_bullet_start"
tt.bullet.pop = nil
tt.bullet.hide_radius = nil
tt.bullet.miss_fx = nil
tt.bullet.particles_name_1 = "ps_storm_elemental_bullet_trail_1"
tt.bullet.particles_name_2 = "ps_storm_elemental_bullet_trail_2"
tt.bullet.miss_decal = nil
tt.bullet.hit_blood_fx = nil
tt.bullet.hit_fx = "fx_storm_elemental_bullet_hit"
tt.bullet.hit_decal = {
	"decal_storm_elemental_bullet",
	"decal_storm_elemental_bullet_2"
}
tt.bullet.hit_fx_water = "decal_storm_elemental_bullet"
tt.bullet.flight_time_base = fts(5)
tt.bullet.flight_time_factor = fts(0.016666666666666666)
tt.bullet.g = -2 / (fts(1) * fts(1)) * 0.5
tt.bullet.align_with_trajectory = false
tt.bullet.rotation_speed = 0
tt.sound_events.hit = "EnemyElementalRangedImpact"
tt = E:register_t_10086("bullet_wuxian_bolt", "bolt_enemy")
b = balance.enemies.wukong.wuxian.ranged_attack
tt.render.sprites[1].prefix = "wuxian_bolt"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.main_script.update = scripts.bullet_wuxian_bolt.update
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.damage_radius
tt.bullet.damage_bans = bor(F_ENEMY)
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 42
tt.bullet.max_speed = 420
tt.bullet.align_with_trajectory = false
tt.bullet.hit_fx = "fx_wuxian_bolt_hit"
tt.bullet.hit_fx_ignore_offset = true
tt.bullet.hit_decal = "decal_wuxian_flaming_ground"
tt.bullet.particles_name = "ps_wuxian_bolt_trail"
tt = E:register_t_10086("bullet_water_sorceress_bolt", "bolt_enemy")

E:add_comps(tt, "force_motion")

b = balance.enemies.wukong.water_sorceress.ranged_attack
tt.render.sprites[1].prefix = "watersorceress_projectile"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.main_script.update = scripts.bolt_force_motion_kr5.update
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_type = b.damage_type
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 60
tt.bullet.max_speed = 600
tt.bullet.ignore_rotation = true
tt.bullet.align_with_trajectory = false
tt.bullet.force_align_particles_trajectory = true
tt.bullet.force_align_particles_trajectory_offset = math.rad(-90)
tt.bullet.hit_fx = "fx_water_sorceress_bolt_hit"
tt.bullet.particles_name = "ps_water_sorceress_bolt_trail"
tt.initial_impulse = 12000
tt.initial_impulse_duration = 0.15
tt.initial_impulse_angle_abs = math.pi / 2
tt.initial_impulse_reduction = 0.7
tt.force_motion.a_step = 5
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 300
tt = E:register_t_10086("bullet_hellfire_warlock_fireball", "bombKR5")
b = balance.enemies.wukong.hellfire_warlock.ranged
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.radius
tt.bullet.ignore_hit_offset = true
tt.bullet.flight_time = fts(20)
tt.bullet.hit_fx = "fx_hellfire_warlock_fireball_hit"
tt.bullet.damage_bans = bor(F_ENEMY)
tt.bullet.pop = nil
tt.bullet.particles_name = "ps_hellfire_warlock_bullet_trail"
tt.bullet.hit_decal = "decal_hellfire_warlock_flaming_ground"
tt.bullet.rotation_random = true
tt.bullet.align_with_trajectory = false
tt.bullet.rotation_speed = 60 * FPS * math.pi / 180
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.bullet_hellfire_warlock_fireball.update
tt.render.sprites[1].prefix = "hellfire_warlock_fireball"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5, 0.5128205128205128)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "hellfire_warlock_fireball"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].animated = true
tt.render.sprites[2].anchor = v(0.5, 0.5128205128205128)
tt.render.sprites[2].r = math.rad(180)
tt.sound_events.insert = "EnemyWarlockRangedCast"
tt.sound_events.hit = "EnemyWarlockRangedImpact"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_blue_lvl1", "bullet")
tt.is_bullet_tower_pandas_spawn_soldier = true
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl1"
tt.render.sprites[1].name = "scape_loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].r = 0
tt.main_script.insert = scripts.bullet_tower_pandas_spawn_soldier.insert
tt.main_script.update = scripts.bullet_tower_pandas_spawn_soldier.update
tt.bullet.flight_time = fts(26)
tt.bullet.g = -1 / (fts(1) * fts(1)) * 1
tt.bullet.rotation_speed = 0
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.hit_fx_water = nil
tt.bullet.hide_radius = nil
tt.sound_events.insert = nil
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_blue_lvl2", "bullet_tower_pandas_spawn_soldier_blue_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl2"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_blue_lvl3", "bullet_tower_pandas_spawn_soldier_blue_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl3"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_blue_lvl4", "bullet_tower_pandas_spawn_soldier_blue_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_blue_lvl4"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_red_lvl1", "bullet_tower_pandas_spawn_soldier_blue_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl1"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_red_lvl2", "bullet_tower_pandas_spawn_soldier_red_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl2"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_red_lvl3", "bullet_tower_pandas_spawn_soldier_red_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl3"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_red_lvl4", "bullet_tower_pandas_spawn_soldier_red_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_red_lvl4"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_green_lvl1", "bullet_tower_pandas_spawn_soldier_blue_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl1"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_green_lvl2", "bullet_tower_pandas_spawn_soldier_green_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl2"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_green_lvl3", "bullet_tower_pandas_spawn_soldier_green_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl3"
tt = E:register_t_10086("bullet_tower_pandas_spawn_soldier_green_lvl4", "bullet_tower_pandas_spawn_soldier_green_lvl1")
tt.render.sprites[1].prefix = "tower_pandas_panda_green_lvl4"
tt = E:register_t_10086("bullet_tower_pandas_air_lvl1", "bolt")
b = balance.towers.pandas
tt.render.sprites[1].prefix = "tower_pandas_projectile_air"
tt.render.sprites[1].name = "Run"
tt.render.sprites[1].animated = true
tt.bullet.damage_min = b.ranged_attack.damage_min[1]
tt.bullet.damage_max = b.ranged_attack.damage_max[1]
tt.bullet.damage_type = b.ranged_attack.damage_type
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 360
tt.bullet.max_speed = 480
tt.bullet.ignore_rotation = true
tt.bullet.align_with_trajectory = false
tt.bullet.hit_fx = "fx_tower_pandas_bullet_air_hit"
tt.bullet.particles_name = "ps_bullet_tower_panda_air"
tt.sound_events.insert = "TowerPandasRangedHat"
tt = E:register_t_10086("bullet_tower_pandas_air_lvl2", "bullet_tower_pandas_air_lvl1")
tt.bullet.damage_min = b.ranged_attack.damage_min[2]
tt.bullet.damage_max = b.ranged_attack.damage_max[2]
tt = E:register_t_10086("bullet_tower_pandas_air_lvl3", "bullet_tower_pandas_air_lvl1")
tt.bullet.damage_min = b.ranged_attack.damage_min[3]
tt.bullet.damage_max = b.ranged_attack.damage_max[3]
tt = E:register_t_10086("bullet_tower_pandas_air_lvl4", "bullet_tower_pandas_air_lvl1")
tt.bullet.damage_min = b.ranged_attack.damage_min[4]
tt.bullet.damage_max = b.ranged_attack.damage_max[4]
tt = E:register_t_10086("bullet_tower_pandas_air_soldier_special_lvl1", "bullet_tower_pandas_air_lvl1")
tt.main_script.update = scripts.bullet_tower_pandas_air.update
tt.bullet.damage_min = b.soldier.hat.damage_levels[1].max
tt.bullet.damage_max = b.soldier.hat.damage_levels[1].max
tt.max_bounces = b.soldier.hat.max_bounces
tt.bounce_range = b.soldier.hat.bounce_range
tt.bounce_damage_mult = b.soldier.hat.bounce_damage_mult
tt.bounce_speed_mult = b.soldier.hat.bounce_speed_mult
tt = E:register_t_10086("bullet_tower_pandas_air_soldier_special_lvl2", "bullet_tower_pandas_air_soldier_special_lvl1")
tt.bullet.damage_min = b.soldier.hat.damage_levels[2].min
tt.bullet.damage_max = b.soldier.hat.damage_levels[2].max
tt = E:register_t_10086("bullet_tower_pandas_fire_lvl1", "bolt")
tt.render.sprites[1].prefix = "tower_pandas_projectile_fire"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.bullet.damage_min = b.ranged_attack.damage_min[1]
tt.bullet.damage_max = b.ranged_attack.damage_max[1]
tt.bullet.damage_type = b.ranged_attack.damage_type
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 90
tt.bullet.max_speed = 600
tt.bullet.hide_radius = 1
tt.bullet.align_with_trajectory = true
tt.bullet.hit_fx = "fx_tower_pandas_bullet_fire_hit"
tt.bullet.particles_name = "ps_bullet_tower_panda_fire"
tt.sound_events.insert = "TowerPandasRangedFire"
tt = E:register_t_10086("bullet_tower_pandas_fire_lvl2", "bullet_tower_pandas_fire_lvl1")
tt.bullet.damage_min = b.ranged_attack.damage_min[2]
tt.bullet.damage_max = b.ranged_attack.damage_max[2]
tt = E:register_t_10086("bullet_tower_pandas_fire_lvl3", "bullet_tower_pandas_fire_lvl1")
tt.bullet.damage_min = b.ranged_attack.damage_min[3]
tt.bullet.damage_max = b.ranged_attack.damage_max[3]
tt = E:register_t_10086("bullet_tower_pandas_fire_lvl4", "bullet_tower_pandas_fire_lvl1")
tt.bullet.damage_min = b.ranged_attack.damage_min[4]
tt.bullet.damage_max = b.ranged_attack.damage_max[4]
tt = E:register_t_10086("bullet_tower_pandas_ray_lvl1", "bullet")
tt.bullet.level = 1
tt.bullet.damage_min = b.ranged_attack.damage_min[1]
tt.bullet.damage_max = b.ranged_attack.damage_max[1]
tt.bullet.damage_type = b.ranged_attack.damage_type
tt.bullet.hit_time = fts(3)
tt.bullet.hit_fx = "fx_tower_pandas_bullet_fire_ray"
tt.image_width = 104
tt.main_script.update = scripts.tower_pandas_ray.update
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "tower_pandas_projectile_ray_run"
tt.render.sprites[1].loop = false
tt.track_target = false
tt.ray_duration = fts(11)
tt.sound_events.insert = "TowerPandasRangedBolt"
tt = E:register_t_10086("bullet_tower_pandas_ray_lvl2", "bullet_tower_pandas_ray_lvl1")
tt.bullet.level = 2
tt.bullet.damage_min = b.ranged_attack.damage_min[2]
tt.bullet.damage_max = b.ranged_attack.damage_max[2]
tt = E:register_t_10086("bullet_tower_pandas_ray_lvl3", "bullet_tower_pandas_ray_lvl1")
tt.bullet.level = 3
tt.bullet.damage_min = b.ranged_attack.damage_min[3]
tt.bullet.damage_max = b.ranged_attack.damage_max[3]
tt = E:register_t_10086("bullet_tower_pandas_ray_lvl4", "bullet_tower_pandas_ray_lvl1")
tt.bullet.level = 4
tt.bullet.damage_min = b.ranged_attack.damage_min[4]
tt.bullet.damage_max = b.ranged_attack.damage_max[4]
tt = E:register_t_10086("tunnel_KR5_stage_34_ponds", "tunnel_KR5")
tt.main_script.update = scripts.tunnel_KR5_stage_34_ponds.update
tt.untargetable_distance = 5
tt.tunnel.speed_factor = 8
tt.tunnel.fx_use_unit_offset = false
tt.tunnel.pick_fx = "fx_stage_34_fuentes_splash"
tt.tunnel.place_fx = "fx_stage_34_fuentes_splash"
tt.tunnel.place_fx_barro = "fx_stage_34_fuentes_splash_barro"
tt = E:register_t_10086("aura_hero_wukong_ultimate_slow", "aura")
b = balance.heroes.hero_wukong.ultimate

E:add_comps(tt, "render", "tween")

tt.aura.mod = "mod_hero_wukong_ultimate_slow"
tt.aura.radius = 60
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.cycle_time = fts(5)
tt.aura.duration = 3
tt.render.sprites[1].prefix = "hero_wukong_dragon_ultimate_vfx_decal"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod_hero_wukong_ultimate.update

tt = E:register_t_10086("aura_hero_wukong_ultimate_slow_2", "aura_hero_wukong_ultimate_slow")
tt.aura.mod = "mod_hero_wukong_ultimate_slow_2"
tt.aura.radius = 9999
tt = RT("aura_wukong_fire_ground_apply_mod", "aura")
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.duration = -1
tt.aura.mod = nil
tt.aura.radius = 55
tt.aura.cycle_time = fts(3)
tt.aura.vis_bans = bor(F_FLYING)
tt = RT("aura_wukong_fire_ground_dps", "aura_wukong_fire_ground_apply_mod")
tt.aura.mod = "mod_wukong_flaming_ground_dps"
tt.aura.vis_bans = bor(tt.aura.vis_bans, F_ENEMY)
tt.aura.excluded_templates = {
	"hero_lava",
	"hero_ignus",
}
tt = RT("aura_wukong_fire_ground_sprint", "aura_wukong_fire_ground_apply_mod")
tt.aura.mod = "mod_wukong_flaming_ground_sprint"
tt.aura.allowed_templates = {
	"enemy_fire_fox"
}
tt = RT("aura_wukong_fire_ground_healing", "aura_wukong_fire_ground_apply_mod")
tt.aura.mod = "mod_wukong_flaming_ground_healing"
tt.aura.allowed_templates = {
	"enemy_ash_spirit"
}
tt = RT("aura_wukong_fire_ground_wuxian", "aura_wukong_fire_ground_apply_mod")
tt.aura.mod = "mod_wukong_flaming_ground_toggle_abilities"
tt.aura.allowed_templates = {
	"enemy_wuxian",
	"enemy_nine_tailed_fox",
	"enemy_blaze_raider",
	"enemy_flame_guard"
}
tt = RT("aura_fire_fox_explotion_dps", "aura")
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.duration = -1
tt.aura.mod = "mod_fire_fox_explotion_dps"
tt.aura.radius = 70
tt.aura.cycle_time = 1e+99
tt.aura.vis_bans = bor(F_FLYING, F_ENEMY)
tt = E:register_t_10086("aura_force_move_unit")

E:add_comps(tt, "main_script")

tt.main_script.insert = scripts.aura_force_move_unit.insert
tt.impact_strength = 100
tt.impact_max_dist = 1e+99
tt = E:register_t_10086("mod_hide_tower_test", "modifier")
tt.main_script.insert = scripts.mod_hide_tower_test.insert
tt.main_script.update = scripts.mod_hide_tower_test.update
tt.modifier.duration = 2
tt = E:register_t_10086("mod_stage_32_tower_block", "mod_hide_tower")

E:add_comps(tt, "render")

tt.main_script.update = scripts.mod_stage_32_tower_blocked.update
tt.main_script.remove = nil
tt.render.sid_lava = 1
tt.render.sprites[tt.render.sid_lava].prefix = "dragon_rock_stunDef"
tt.render.sprites[tt.render.sid_lava].exo = true
tt.render.sprites[tt.render.sid_lava].name = "idle"
tt.render.sprites[tt.render.sid_lava].animated = true
tt.render.sprites[tt.render.sid_lava].draw_order = 20
tt.render.sprites[tt.render.sid_lava].z = Z_OBJECTS
tt.sound_restore = "Stage22TowerRestore"
tt.repair_cost = nil
tt.hand_decal_t = "dlc2_generic_tap_hand"
tt.skip_modifiers = {
	"mod_boss_crocs_tower_eat"
}
tt.click_rect = r(-30, 0, 60, 60)
tt.menu_offset = v(0, 12)
tt.modifier.duration = nil
tt = RT("mod_wukong_flaming_ground_sprint", "mod_slow")
b = balance.specials.terrain_8.flaming_ground.sprint
tt.slow.factor = b.sprint_factor
tt.modifier.duration = b.duration
tt.modifier.is_fire_buff = true
tt = RT("mod_wukong_flaming_ground_dps", "modifier")

E:add_comps(tt, "dps", "render")

b = balance.specials.terrain_8.flaming_ground.dps
tt.dps.damage_every = b.damage_every
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.modifier.duration = b.duration
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 4
tt.render.sprites[1].loop = true
tt = RT("mod_wukong_flaming_ground_healing", "modifier")

E:add_comps(tt, "hps", "render")

b = balance.specials.terrain_8.flaming_ground.healing
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_wukong_flaming_ground_healing.update
tt.modifier.duration = b.heal_duration
tt.modifier.is_fire_buff = true
tt.hps.heal_min = b.heal_min
tt.hps.heal_max = b.heal_max
tt.hps.heal_every = b.heal_every
tt.render.sid_behind = 1
tt.render.sid_crosses = 2
tt.render.sprites[tt.render.sid_behind].prefix = "ashspirit_fx_heal_behind"
tt.render.sprites[tt.render.sid_behind].name = "run"
tt.render.sprites[tt.render.sid_behind].animated = true
tt.render.sprites[tt.render.sid_behind].loop = false
tt.render.sprites[tt.render.sid_behind].sort_y_offset = -5
tt.render.sprites[tt.render.sid_crosses] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[tt.render.sid_crosses].prefix = "ashspirit_fx_heal_croses"
tt.render.sprites[tt.render.sid_crosses].loop = true
tt.render.sprites[tt.render.sid_crosses].name = "run"
tt.render.sprites[tt.render.sid_crosses].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_crosses].offset = v(-10, 15)
tt = E:register_t_10086("mod_wukong_flaming_ground_toggle_abilities", "modifier")

E:add_comps(tt, "render")

tt.modifier.duration = fts(10)
tt.main_script.insert = scripts.mod_wukong_flaming_ground_toggle_abilities.insert
tt.main_script.update = scripts.mod_wukong_flaming_ground_toggle_abilities.update
tt.main_script.remove = scripts.mod_wukong_flaming_ground_toggle_abilities.remove
tt.modifier.is_fire_buff = true
tt.render.sid_wuxian = 1
tt.render.sprites[tt.render.sid_wuxian].prefix = "wuxian_buff"
tt.render.sprites[tt.render.sid_wuxian].name = "run"
tt.render.sprites[tt.render.sid_wuxian].animated = true
tt.render.sprites[tt.render.sid_wuxian].loop = true
tt.render.sprites[tt.render.sid_wuxian].sort_y_offset = -1
tt.render.sprites[tt.render.sid_wuxian].hidden = true
tt.render.sprites[tt.render.sid_wuxian].use_mod_offset = false
tt.template_scripts = {
	enemy_wuxian = {
		sprite_id = tt.render.sid_wuxian,
		insert = scripts.enemy_wuxian.flaming_toggle_abilities_insert,
		remove = scripts.enemy_wuxian.flaming_toggle_abilities_remove
	},
	enemy_nine_tailed_fox = {
		insert = scripts.enemy_nine_tailed_fox.flaming_toggle_abilities_insert,
		remove = scripts.enemy_nine_tailed_fox.flaming_toggle_abilities_remove
	},
	enemy_blaze_raider = {
		insert = scripts.enemy_blaze_raider.flaming_toggle_abilities_insert,
		remove = scripts.enemy_blaze_raider.flaming_toggle_abilities_remove
	},
	enemy_flame_guard = {
		insert = scripts.enemy_flame_guard.flaming_toggle_abilities_insert,
		remove = scripts.enemy_flame_guard.flaming_toggle_abilities_remove
	}
}
tt = RT("mod_fire_fox_explotion_dps", "modifier")

E:add_comps(tt, "dps")

b = balance.enemies.wukong.fire_fox.flaming_ground.explotion
tt.dps.damage_every = 1e+99
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.modifier.duration = fts(2)
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = RT("mod_nine_tailed_fox_stun_attack", "mod_stun")
b = balance.enemies.wukong.nine_tailed_fox.stun_attack
tt.modifier.duration = b.stun_duration
tt = RT("mod_nine_tailed_fox_stun_teleport", "mod_stun")
b = balance.enemies.wukong.nine_tailed_fox.teleport
tt.modifier.duration = b.stun_duration
tt = RT("mod_gale_warrior_combo_counter", "modifier")
tt.main_script.insert = scripts.mod_gale_warrior_combo_counter.insert
tt.main_script.queue = scripts.mod_gale_warrior_combo_counter.queue
tt = RT("mod_gale_warrior_dot", "modifier")

E:add_comps(tt, "dps")

b = balance.enemies.wukong.gale_warrior.puncturing_thrust.dot
tt.dps.damage_every = b.damage_every
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.dps.kill = true
tt.dps.fx = "fx_bleeding"
tt.dps.fx_with_blood_color = true
tt.dps.fx_target_flip = true
tt.dps.fx_tracks_target = true
tt.modifier.duration = b.duration
tt.modifier.vis_flags = F_BLOOD
tt.main_script.queue = scripts.mod_gale_warrior_dot.queue
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = E:register_t_10086("mod_enemy_storm_elemental_tower_mark", "modifier")

E:add_comps(tt, "mark_flags")

tt.modifier.duration = fts(30)
tt.main_script.queue = scripts.mod_mark_flags.queue
tt.main_script.dequeue = scripts.mod_mark_flags.dequeue
tt.main_script.update = scripts.mod_mark_flags.update
tt = E:register_t_10086("mod_enemy_storm_elemental_tower_debuff", "modifier")
b = balance.enemies.wukong.storm_elemental.tower_block

E:add_comps(tt, "render")

tt.main_script.insert = scripts.mod_crocs_shaman_tower_debuff.insert
tt.main_script.update = scripts.mod_crocs_shaman_tower_debuff.update
tt.main_script.remove = scripts.mod_crocs_shaman_tower_debuff.remove
tt.modifier.duration = b.duration
tt.modifier.vis_flags = F_CUSTOM
tt.render.sprites[1].prefix = "storm_elemental_vfx_stun"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.offset_y_per_tower = {
	hermit_toad = 4
}
tt = RT("mod_water_sorceress_heal_wave_healing", "modifier")

E:add_comps(tt, "hps", "render")

b = balance.enemies.wukong.water_sorceress.heal_wave
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(88)
tt.hps.heal_min = b.heal_min / (tt.modifier.duration / tt.hps.heal_every)
tt.hps.heal_max = b.heal_max / (tt.modifier.duration / tt.hps.heal_every)
tt.hps.heal_every = 0.1
tt.render.sprites[1].prefix = "watersorceress_heal"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].sort_y_offset = -5
tt = RT("mod_water_sorceress_heal_wave_dps", "modifier")

E:add_comps(tt, "dps")

b = balance.enemies.wukong.water_sorceress.heal_wave
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = fts(20)
tt.dps.damage_every = 1e+99
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.dps.fx = "fx_water_sorceress_bolt_hit"
tt = RT("mod_hero_wukong_attacks_combos", "modifier")
tt.main_script.insert = scripts.mod_hero_wukong_attacks_combos.insert
tt.main_script.queue = scripts.mod_hero_wukong_attacks_combos.queue
tt = E:register_t_10086("mod_stage31_water_mechanic_dps", "modifier")
b = balance.specials.stage31_water_mechanic

E:add_comps(tt, "dps")

tt.modifier.duration = 1
tt.dps.fx = "fx_water_sorceress_bolt_hit"
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.dps.damage_every = 1e+99
tt.main_script.insert = scripts.mod_stage31_water_mechanic_dps.insert
tt.main_script.update = scripts.mod_stage31_water_mechanic_dps.update
tt.allowed_templates = {
	"enemy_fire_phoenix",
	"enemy_fire_fox",
	"enemy_nine_tailed_fox",
	"enemy_burning_treant",
	"enemy_ash_spirit"
}
tt = RT("controller_elemental_wood")

E:add_comps(tt, "main_script", "pos", "render", "tween")

b = balance.specials.terrain_8.elemental_holders.wooden_holder
tt.main_script.update = scripts.controller_elemental_wood.update
tt.main_script.remove = scripts.controller_elemental_generic.remove
tt.first_cooldown = b.first_cooldown
tt.cooldown = b.cooldown
tt.slow_factor = b.slow_factor
tt.damage_min = b.damage_min
tt.damage_max = b.damage_max
tt.vis_bans = bor(F_FLYING, F_FRIEND)
tt.vis_flags = F_RANGED
tt.duration = b.duration
tt.root_decal = "decal_elemental_wood_holder_root"
tt.root_decal_dragon = "decal_elemental_wood_holder_root_dragon"
tt.default_max_range = b.default_max_range
tt.skill_detection_range_factor = b.skill_detection_range_factor
tt.rally_range_factor = b.rally_range_factor
tt.range_factor = b.range_factor
tt.controller_aura_name = "aura_elemental_wood"
tt.render.sid_gradiente = 1
tt.render.sid_wings = 2
tt.render.sid_hojas = 3
tt.render.sid_dragon = 4
tt.render.sid_dragon_ability = 5
tt.render.sprites[tt.render.sid_gradiente].prefix = "stage31_wood_holder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "idle"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_wings] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_wings].prefix = "stage31_wood_holder_cuernosDef"
tt.render.sprites[tt.render.sid_wings].name = "run"
tt.render.sprites[tt.render.sid_wings].exo = true
tt.render.sprites[tt.render.sid_wings].animated = true
tt.render.sprites[tt.render.sid_wings].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_wings].sort_y_offset = -10
tt.render.sprites[tt.render.sid_wings].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_wings].alpha = 0
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_hojas].prefix = "stage31_wood_holder_jarrahojasDef"
tt.render.sprites[tt.render.sid_hojas].exo = true
tt.render.sprites[tt.render.sid_hojas].name = "run"
tt.render.sprites[tt.render.sid_hojas].animated = true
tt.render.sprites[tt.render.sid_hojas].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_hojas].offset = v(0, -10)
tt.render.sprites[tt.render.sid_hojas].sort_y_offset = -10
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "stage31_wood_holder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "idle"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.render.sprites[tt.render.sid_dragon].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_dragon_ability] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon_ability].prefix = "stage31_wood_holder_habilidad_1Def"
tt.render.sprites[tt.render.sid_dragon_ability].exo = true
tt.render.sprites[tt.render.sid_dragon_ability].name = "start_hability"
tt.render.sprites[tt.render.sid_dragon_ability].animated = true
tt.render.sprites[tt.render.sid_dragon_ability].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon_ability].hidden = true
tt.render.sprites[tt.render.sid_dragon_ability].anchor = vv(0.5)
tt.update_on_path_active = {
	2,
	3,
	6
}
tt.tween.props[1].name = "alpha"
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
tt.tween.props[1].sprite_id = tt.render.sid_wings
tt.tween.props[1].loop = false
tt.tween.disabled = true
tt.tween.reverse = true
tt.tween.remove = false

tt = RT("controller_elemental_wood_enhance", "controller_elemental_wood")
b = balance.specials.terrain_8.elemental_holders.wooden_holder_enhance
tt.main_script.update = scripts.controller_elemental_wood.update
tt.main_script.remove = scripts.controller_elemental_generic.remove
tt.first_cooldown = b.first_cooldown
tt.cooldown = b.cooldown
tt.slow_factor = b.slow_factor
tt.damage_min = b.damage_min
tt.damage_max = b.damage_max
tt.vis_bans = bor(F_FLYING, F_FRIEND)
tt.vis_flags = F_RANGED
tt.duration = b.duration
tt.root_decal = "decal_elemental_wood_holder_root"
tt.root_decal_dragon = "decal_elemental_wood_holder_root_dragon"
tt.default_max_range = b.default_max_range
tt.skill_detection_range_factor = b.skill_detection_range_factor
tt.rally_range_factor = b.rally_range_factor
tt.range_factor = b.range_factor
tt.controller_aura_name = "aura_elemental_wood"
tt.render.sid_gradiente = 1
tt.render.sid_wings = 2
tt.render.sid_hojas = 3
tt.render.sid_dragon = 4
tt.render.sid_dragon_ability = 5
tt.render.sprites[tt.render.sid_gradiente].prefix = "stage31_wood_holder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "idle"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_wings] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_wings].prefix = "stage31_wood_holder_cuernosDef"
tt.render.sprites[tt.render.sid_wings].name = "run"
tt.render.sprites[tt.render.sid_wings].exo = true
tt.render.sprites[tt.render.sid_wings].animated = true
tt.render.sprites[tt.render.sid_wings].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_wings].sort_y_offset = -10
tt.render.sprites[tt.render.sid_wings].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_wings].alpha = 0
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_hojas].prefix = "stage31_wood_holder_jarrahojasDef"
tt.render.sprites[tt.render.sid_hojas].exo = true
tt.render.sprites[tt.render.sid_hojas].name = "run"
tt.render.sprites[tt.render.sid_hojas].animated = true
tt.render.sprites[tt.render.sid_hojas].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_hojas].offset = v(0, -10)
tt.render.sprites[tt.render.sid_hojas].sort_y_offset = -10
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "stage31_wood_holder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "idle"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.render.sprites[tt.render.sid_dragon].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_dragon_ability] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon_ability].prefix = "stage31_wood_holder_habilidad_1Def"
tt.render.sprites[tt.render.sid_dragon_ability].exo = true
tt.render.sprites[tt.render.sid_dragon_ability].name = "start_hability"
tt.render.sprites[tt.render.sid_dragon_ability].animated = true
tt.render.sprites[tt.render.sid_dragon_ability].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon_ability].hidden = true
tt.render.sprites[tt.render.sid_dragon_ability].anchor = vv(0.5)
tt.update_on_path_active = {
	2,
	3,
	6
}
tt.tween.props[1].name = "alpha"
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
tt.tween.props[1].sprite_id = tt.render.sid_wings
tt.tween.props[1].loop = false
tt.tween.disabled = true
tt.tween.reverse = true
tt.tween.remove = false


tt = E:register_t_10086("decal_elemental_wood_holder_root_1", "decal_scripted")
tt.render.sprites[1].prefix = "stage31_wood_holder_root1Def"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "start"
tt.render.sprites[1].hidden = true
tt.main_script.update = scripts.hero_muyrn_root_defender_root_decal.update
tt.vis_flags = bor(F_RANGED)
tt.vis_bans = bor(F_FRIEND)
tt = E:register_t_10086("decal_elemental_wood_holder_root_2", "decal_elemental_wood_holder_root_1")
tt.render.sprites[1].prefix = "stage31_wood_holder_root2Def"
tt = E:register_t_10086("decal_elemental_wood_holder_root_3", "decal_elemental_wood_holder_root_1")
tt.render.sprites[1].prefix = "stage31_wood_holder_root3Def"
tt = E:register_t_10086("decal_elemental_wood_holder_root_4", "decal_elemental_wood_holder_root_1")
tt.render.sprites[1].prefix = "stage31_wood_holder_root4Def"
tt = E:register_t_10086("decal_elemental_wood_holder_root_dragon", "decal_scripted")
tt.render.sprites[1].prefix = "stage31_wood_holder_dragon_rootDef"
tt.render.sprites[1].exo = true
tt.render.sprites[1].name = "in"
tt.loop_times = 2
tt.main_script.update = scripts.decal_elemental_wood_holder_root_dragon.update
tt = E:register_t_10086("fx_elemental_wood_holder_broken_jarra", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "stage31_wood_holder_jarraDef"
tt.render.sprites[1].name = "broken"
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(0, 5)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "stage31_wood_holder_rayoDef"
tt.render.sprites[2].name = "ray_down"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "stage31_wood_holder_rayo_explosionDef"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].exo = true
tt.render.sprites[3].offset = v(0, 5)
tt.render.sprites[3].z = Z_OBJECTS
tt = E:register_t_10086("aura_elemental_wood", "aura")
tt.aura.duration = b.duration
tt.aura.cycle_time = 0.3
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.vis_flags = F_RANGED
tt.aura.mods = {
	"mod_elemental_wood_slow",
	"mod_elemental_wood_damage"
}
tt.duration = b.duration
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.main_script.remove = scripts.aura_apply_mod.remove
tt = E:register_t_10086("mod_elemental_wood_slow", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = b.slow_factor
tt = E:register_t_10086("mod_elemental_wood_damage", "modifier")

E:add_comps(tt, "dps")

tt.modifier.duration = 1
tt.dps.damage_min = b.damage_min
tt.dps.damage_max = b.damage_max
tt.dps.damage_type = b.damage_type
tt.dps.damage_every = b.damage_every
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = RT("controller_elemental_fire")

E:add_comps(tt, "main_script", "pos", "render", "tween")

b = balance.specials.terrain_8.elemental_holders.fire_holder
tt.main_script.update = scripts.controller_elemental_fire.update
tt.main_script.remove = scripts.controller_elemental_generic.remove
tt.first_cooldown = b.first_cooldown
tt.cooldown = b.cooldown
tt.damage_factor = b.damage_factor
tt.vis_bans = bor(F_FLYING, F_FRIEND, F_BOSS, F_MINIBOSS)
tt.vis_flags = bor(F_RANGED, F_INSTAKILL)
tt.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS, DAMAGE_FX_NOT_EXPLODE)
tt.damage_delay = 0.35
tt.fx = "fx_elemental_fire_holder_explosion"
tt.root_decal_dragon = "decal_elemental_fire_holder_root_dragon"
tt.root_decal_dragon_kill = "decal_elemental_fire_holder_root_dragon_kill"
tt.render.sid_gradiente = 1
tt.render.sid_sparks = 2
tt.render.sid_wings = 3
tt.render.sid_hojas = 4
tt.render.sid_dragon = 5
tt.render.sid_dragon_ability = 6
tt.render.sprites[tt.render.sid_gradiente].prefix = "fireholder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "idle"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_sparks] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_sparks].prefix = "fireholder_jarrahojasDef"
tt.render.sprites[tt.render.sid_sparks].name = "run"
tt.render.sprites[tt.render.sid_sparks].exo = true
tt.render.sprites[tt.render.sid_sparks].animated = true
tt.render.sprites[tt.render.sid_sparks].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_sparks].sort_y_offset = -10
tt.render.sprites[tt.render.sid_sparks].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_sparks].alpha = 255
tt.render.sprites[tt.render.sid_wings] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_wings].prefix = "fireholder_cuernosDef"
tt.render.sprites[tt.render.sid_wings].name = "run"
tt.render.sprites[tt.render.sid_wings].exo = true
tt.render.sprites[tt.render.sid_wings].animated = true
tt.render.sprites[tt.render.sid_wings].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_wings].sort_y_offset = -10
tt.render.sprites[tt.render.sid_wings].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_wings].alpha = 0
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_hojas].prefix = "fireholder_jarrahojasDef"
tt.render.sprites[tt.render.sid_hojas].exo = true
tt.render.sprites[tt.render.sid_hojas].name = "run"
tt.render.sprites[tt.render.sid_hojas].animated = true
tt.render.sprites[tt.render.sid_hojas].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_hojas].offset = v(0, -10)
tt.render.sprites[tt.render.sid_hojas].sort_y_offset = -10
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "fireholder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "idle"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.render.sprites[tt.render.sid_dragon].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_dragon_ability] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon_ability].prefix = "fireholder_habilidad_1Def"
tt.render.sprites[tt.render.sid_dragon_ability].exo = true
tt.render.sprites[tt.render.sid_dragon_ability].name = "start_hability"
tt.render.sprites[tt.render.sid_dragon_ability].animated = true
tt.render.sprites[tt.render.sid_dragon_ability].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon_ability].hidden = true
tt.render.sprites[tt.render.sid_dragon_ability].anchor = vv(0.5)
tt.update_on_path_active = {
	2,
	3,
	6
}
tt.tween.props[1].name = "alpha"
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
tt.tween.props[1].sprite_id = tt.render.sid_wings
tt.tween.props[1].loop = false
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt.tween.props[2].sprite_id = tt.render.sid_sparks
tt.tween.props[2].loop = false
tt.tween.disabled = true
tt.tween.reverse = true
tt.tween.remove = false
tt = E:register_t_10086("decal_elemental_fire_holder_root_dragon", "decal_scripted")
tt.render.sprites[1].prefix = "fireholder_dragon_rootDef"
tt.render.sprites[1].exo = true
tt.render.sprites[1].name = "in"
tt.loop_times = 1
tt.main_script.update = scripts.decal_elemental_wood_holder_root_dragon.update
tt = E:register_t_10086("decal_elemental_fire_holder_root_dragon_kill", "decal_scripted")
tt.render.sprites[1].prefix = "fireholder_dragon_executionDef"
tt.render.sprites[1].exo = true
tt.render.sprites[1].name = "in"
tt.main_script.update = scripts.decal_elemental_wood_holder_root_dragon_kill.update
tt = E:register_t_10086("fx_elemental_fire_holder_explosion", "fx")
tt.render.sprites[1].prefix = "fireholder_dragon_executionDef"
tt.render.sprites[1].exo = true
tt.render.sprites[1].name = "in"
tt = E:register_t_10086("fx_elemental_fire_holder_broken_jarra", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "fireholder_jarraDef"
tt.render.sprites[1].name = "broken"
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(0, 5)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "fireholder_rayoDef"
tt.render.sprites[2].name = "ray_down"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "fireholder_rayo_explosionDef"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].exo = true
tt.render.sprites[3].offset = v(0, 5)
tt.render.sprites[3].z = Z_OBJECTS
tt = RT("controller_elemental_water")

E:add_comps(tt, "main_script", "pos", "render", "tween")

b = balance.specials.terrain_8.elemental_holders.water_holder
tt.main_script.update = scripts.controller_elemental_water.update
tt.main_script.remove = scripts.controller_elemental_generic.remove
tt.first_cooldown = b.teleport.first_cooldown
tt.cooldown = b.teleport.cooldown
tt.vis_bans = bor(F_FLYING, F_BOSS)
tt.vis_flags = bor(F_MOD)
tt.mod_teleport = "mod_eleemntal_water_holder_teleport"
tt.teleport_affect_radius = b.teleport.tp_radius
tt.decal_mist = "decal_elemental_water_holder_passive_mist"
tt.root_decal_dragon = "decal_elemental_water_holder_root_dragon"
tt.root_decal_dragon_kill = "decal_elemental_water_holder_root_dragon_kill"
tt.tp_max_targets = b.teleport.tp_max_targets
tt.delay_between_tps = b.teleport.delay_between_tps
tt.duration = b.teleport.duration
tt.chase_speed = b.teleport.chase_speed
tt.wander_interval = b.teleport.wander_interval
tt.tp_distance_nodes_min = b.teleport.tp_distance_nodes_min
tt.tp_distance_nodes_max = b.teleport.tp_distance_nodes_max
tt.controller_aura_healing = "aura_elemental_water_healing"
tt.render.sid_gradiente = 1
tt.render.sid_wings = 2
tt.render.sid_hojas = 3
tt.render.sid_dragon = 4
tt.render.sid_dragon_ability = 5
tt.render.sprites[tt.render.sid_gradiente].prefix = "stage33_water_holder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "idle"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_wings] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_wings].prefix = "stage33_water_holder_cuernosDef"
tt.render.sprites[tt.render.sid_wings].name = "run"
tt.render.sprites[tt.render.sid_wings].exo = true
tt.render.sprites[tt.render.sid_wings].animated = true
tt.render.sprites[tt.render.sid_wings].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_wings].sort_y_offset = -10
tt.render.sprites[tt.render.sid_wings].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_wings].alpha = 0
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_hojas].prefix = "stage33_water_holder_jarrahojasDef"
tt.render.sprites[tt.render.sid_hojas].exo = true
tt.render.sprites[tt.render.sid_hojas].name = "run"
tt.render.sprites[tt.render.sid_hojas].animated = true
tt.render.sprites[tt.render.sid_hojas].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_hojas].offset = v(0, -10)
tt.render.sprites[tt.render.sid_hojas].sort_y_offset = -10
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "stage33_water_holder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "idle"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.render.sprites[tt.render.sid_dragon].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_dragon_ability] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon_ability].prefix = "stage33_water_holder_habilidad_1Def"
tt.render.sprites[tt.render.sid_dragon_ability].exo = true
tt.render.sprites[tt.render.sid_dragon_ability].name = "start_hability"
tt.render.sprites[tt.render.sid_dragon_ability].animated = true
tt.render.sprites[tt.render.sid_dragon_ability].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon_ability].hidden = true
tt.render.sprites[tt.render.sid_dragon_ability].anchor = vv(0.5)
tt.update_on_path_active = {
	2,
	3,
	6
}
tt.tween.sid_wings = 1
tt.tween.sid_show_hojas = 2
tt.tween.sid_hide_hojas = 3
tt.tween.props[tt.tween.sid_wings].name = "alpha"
tt.tween.props[tt.tween.sid_wings].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[tt.tween.sid_wings].sprite_id = tt.render.sid_wings
tt.tween.props[tt.tween.sid_wings].loop = false
tt.tween.props[tt.tween.sid_wings].disabled = true
tt.tween.props[tt.tween.sid_show_hojas] = E:clone_c("tween_prop")
tt.tween.props[tt.tween.sid_show_hojas].name = "alpha"
tt.tween.props[tt.tween.sid_show_hojas].loop = false
tt.tween.props[tt.tween.sid_show_hojas].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[tt.tween.sid_show_hojas].sprite_id = tt.render.sid_hojas
tt.tween.props[tt.tween.sid_show_hojas].disabled = true
tt.tween.props[tt.tween.sid_show_hojas].ignore_reverse = true
tt.tween.props[tt.tween.sid_hide_hojas] = E:clone_c("tween_prop")
tt.tween.props[tt.tween.sid_hide_hojas].name = "alpha"
tt.tween.props[tt.tween.sid_hide_hojas].loop = false
tt.tween.props[tt.tween.sid_hide_hojas].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt.tween.props[tt.tween.sid_hide_hojas].sprite_id = tt.render.sid_hojas
tt.tween.props[tt.tween.sid_hide_hojas].disabled = true
tt.tween.props[tt.tween.sid_hide_hojas].ignore_reverse = true
tt.tween.reverse = true
tt.tween.remove = false
tt = E:register_t_10086("mod_eleemntal_water_holder_teleport", "mod_teleport")
tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.vis_bans = bor(F_BOSS)
tt.modifier.duration = 1
tt.nodes_offset = nil
tt.max_times_applied = 3
tt.dest_valid_node = true
tt.delay_start = fts(3)
tt.hold_time = 0.34
tt.delay_end = fts(3)
tt.fx_start = "fx_eleemntal_water_holder_teleport"
tt.fx_end = "fx_eleemntal_water_holder_teleport"
tt = E:register_t_10086("fx_eleemntal_water_holder_teleport", "fx")
tt.render.sprites[1].prefix = "holder_elemental_33_teleport_teleport_fx"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].size_names = {
	"idle",
	"big_idle",
	"big_idle"
}
tt.render.sprites[1].animated = true
tt = E:register_t_10086("fx_elemental_water_holder_broken_jarra", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "stage33_water_holder_jarraDef"
tt.render.sprites[1].name = "broken"
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(0, 5)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "stage33_water_holder_rayoDef"
tt.render.sprites[2].name = "ray_down"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "stage33_water_holder_rayo_explosionDef"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].exo = true
tt.render.sprites[3].offset = v(0, 5)
tt.render.sprites[3].z = Z_OBJECTS
tt = E:register_t_10086("fx_elemental_water_holder_healing", "fx")
tt.render.sprites[1].prefix = "stage33_water_holder_healDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_EFFECTS
tt = E:register_t_10086("decal_elemental_water_holder_passive_mist", "decal_tween")
tt.render.sprites[1].prefix = "stage33_water_mistDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -20
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		1,
		255
	}
}
tt.tween.props[1].loop = false
tt.tween.disabled = false
tt.tween.remove = false
tt = E:register_t_10086("decal_elemental_water_holder_root_dragon", "decal_scripted")
tt.render.sprites[1].prefix = "stage33_water_dragonrootDef"
tt.render.sprites[1].exo = true
tt.render.sprites[1].name = "in"
tt.loop_times = 2
tt.main_script.update = scripts.decal_elemental_wood_holder_root_dragon.update
tt = E:register_t_10086("decal_elemental_water_holder_root_dragon_kill", "decal_elemental_water_holder_root_dragon")
tt.render.sprites[1].prefix = "stage33_water_dragonflyDef"
tt.only_in = true
tt = E:register_t_10086("aura_elemental_water_healing", "aura")
b = balance.specials.terrain_8.elemental_holders.water_holder
tt.aura.duration = 1e+99
tt.aura.cycle_time = 0.3
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = F_AREA
tt.aura.mod = "mod_elemental_water_heal"
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_elemental_water_healing.update
tt.main_script.remove = scripts.aura_apply_mod.remove
tt.heal_fx = "fx_elemental_water_holder_healing"
tt.min_health_factor = b.healing.min_health_factor
tt = E:register_t_10086("mod_elemental_water_heal", "modifier")
b = balance.specials.terrain_8.elemental_holders.water_holder

E:add_comps(tt, "hps", "render")

tt.modifier.duration = b.healing.duration
tt.modifier.resets_same = true
tt.hps.heal_min = b.healing.heal_min
tt.hps.heal_max = b.healing.heal_max
tt.hps.heal_every = b.healing.heal_every
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.render.sprites[1].name = "instant_heal_mod_fx"
tt.render.sprites[1].sort_y_offset = -3
tt = RT("controller_elemental_earth")

E:add_comps(tt, "main_script", "pos", "render", "tween")

b = balance.specials.terrain_8.elemental_holders.earth_holder
tt.main_script.update = scripts.controller_elemental_earth.update
tt.main_script.remove = scripts.controller_elemental_generic.remove
tt.first_cooldown = b.first_cooldown
tt.cooldown = b.cooldown
tt.vis_bans = bor(F_FRIEND)
tt.vis_flags = 0
tt.unit_spawn = "soldier_earth_elemental"
tt.spawn_sound = "TerrainWukongElementalHolderEarthActive"
tt.spawns_amount = b.spawn_amount
tt.max_spawns = b.max_spawns
tt.holder_spawn_pos = b.holder_spawn_pos
tt.controller_aura_increase_health = "aura_elemental_earth_increase_health"
tt.render.sid_gradiente = 1
tt.render.sid_wings = 2
tt.render.sid_hojas = 3
tt.render.sid_dragon = 4
tt.render.sid_dragon_ability = 5
tt.render.sprites[tt.render.sid_gradiente].prefix = "dirtholder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "idle"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_gradiente].offset = v(-60, 85)
tt.render.sprites[tt.render.sid_wings] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_wings].prefix = "dirtholder_cuernosDef"
tt.render.sprites[tt.render.sid_wings].name = "run"
tt.render.sprites[tt.render.sid_wings].exo = true
tt.render.sprites[tt.render.sid_wings].animated = true
tt.render.sprites[tt.render.sid_wings].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_wings].sort_y_offset = -10
tt.render.sprites[tt.render.sid_wings].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_wings].alpha = 0
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_hojas].prefix = "dirtholder_jarrahojasDef"
tt.render.sprites[tt.render.sid_hojas].exo = true
tt.render.sprites[tt.render.sid_hojas].name = "run"
tt.render.sprites[tt.render.sid_hojas].animated = true
tt.render.sprites[tt.render.sid_hojas].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_hojas].offset = v(0, -10)
tt.render.sprites[tt.render.sid_hojas].sort_y_offset = -10
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "dirtholder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "idle"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.render.sprites[tt.render.sid_dragon].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_dragon_ability] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon_ability].prefix = "dirtholder_habilidad_1Def"
tt.render.sprites[tt.render.sid_dragon_ability].exo = true
tt.render.sprites[tt.render.sid_dragon_ability].name = "start_hability"
tt.render.sprites[tt.render.sid_dragon_ability].animated = true
tt.render.sprites[tt.render.sid_dragon_ability].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon_ability].hidden = true
tt.render.sprites[tt.render.sid_dragon_ability].anchor = vv(0.5)
tt.tween.sid_wings = 1
tt.tween.sid_show_hojas = 2
tt.tween.sid_hide_hojas = 3
tt.tween.props[tt.tween.sid_wings].name = "alpha"
tt.tween.props[tt.tween.sid_wings].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[tt.tween.sid_wings].sprite_id = tt.render.sid_wings
tt.tween.props[tt.tween.sid_wings].loop = false
tt.tween.props[tt.tween.sid_wings].disabled = true
tt.tween.props[tt.tween.sid_show_hojas] = E:clone_c("tween_prop")
tt.tween.props[tt.tween.sid_show_hojas].name = "alpha"
tt.tween.props[tt.tween.sid_show_hojas].loop = false
tt.tween.props[tt.tween.sid_show_hojas].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[tt.tween.sid_show_hojas].sprite_id = tt.render.sid_hojas
tt.tween.props[tt.tween.sid_show_hojas].disabled = true
tt.tween.props[tt.tween.sid_show_hojas].ignore_reverse = true
tt.tween.props[tt.tween.sid_hide_hojas] = E:clone_c("tween_prop")
tt.tween.props[tt.tween.sid_hide_hojas].name = "alpha"
tt.tween.props[tt.tween.sid_hide_hojas].loop = false
tt.tween.props[tt.tween.sid_hide_hojas].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt.tween.props[tt.tween.sid_hide_hojas].sprite_id = tt.render.sid_hojas
tt.tween.props[tt.tween.sid_hide_hojas].disabled = true
tt.tween.props[tt.tween.sid_hide_hojas].ignore_reverse = true
tt.tween.reverse = true
tt.tween.remove = false
tt = E:register_t_10086("fx_elemental_earth_holder_broken_jarra", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "dirtholder_jarraDef"
tt.render.sprites[1].name = "broken"
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(0, 5)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "dirtholder_rayoDef"
tt.render.sprites[2].name = "ray_down"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "dirtholder_rayo_explosionDef"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].exo = true
tt.render.sprites[3].offset = v(0, 5)
tt.render.sprites[3].z = Z_OBJECTS
tt = E:register_t_10086("aura_elemental_earth_increase_health", "aura")
tt.aura.duration = 1e+99
tt.aura.cycle_time = 0.3
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = F_AREA
tt.aura.mod = "mod_elemental_earth_increase_health"
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.main_script.remove = scripts.aura_apply_mod.remove
tt = E:register_t_10086("mod_elemental_earth_increase_health", "modifier")
b = balance.specials.terrain_8.elemental_holders.earth_holder
tt.extra_health_multiplier = b.extra_health_multiplier
tt.main_script.insert = scripts.mod_elemental_earth_increase_health.insert
tt.main_script.update = scripts.mod_elemental_earth_increase_health.update
tt.main_script.remove = scripts.mod_elemental_earth_increase_health.remove
tt.modifier.bans = {}
tt.modifier.duration = 0.5
tt.modifier.use_mod_offset = false
tt = E:register_t_10086("soldier_earth_elemental", "soldier_militia")
b = balance.specials.terrain_8.elemental_holders.earth_holder.soldier

E:add_comps(tt, "reinforcement")

tt.info.portrait = "gui_bottom_info_image_soldiers_0075"
tt.health.armor = b.armor
tt.health.hp_max = b.hp_max
tt.health_bar.offset = v(0, ady(40))
tt.info.fn = scripts.soldier_charge.get_info
tt.info.i18n_key = "SOLDIER_EARTH_HOLDER"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_earth_elemental.update
tt.reinforcement.fade = nil
tt.reinforcement.fade_in = nil
tt.reinforcement.fade_out = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].hit_fx = "fx_elemental_earth_holder_melee_hit"
tt.melee.attacks[1].hit_offset = v(28, 8)
tt.melee.attacks[1].animation = "hit1"
tt.melee.range = 64
tt.motion.max_speed = b.max_speed
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "golem_holder_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk",
	"walk"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = v(0.9, 0.9)
tt.soldier.melee_slot_offset.x = 12
tt.unit.hit_offset = v(0, 18)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_LYCAN)
tt.vis.flags = F_FRIEND
tt.patrol_pos_offset = v(15, 10)
tt.patrol_min_cd = 5
tt.patrol_max_cd = 10
tt = RT("controller_elemental_metal")

E:add_comps(tt, "main_script", "pos", "render", "tween")

b = balance.specials.terrain_8.elemental_holders.metal_holder
tt.main_script.update = scripts.controller_elemental_metal.update
tt.main_script.remove = scripts.controller_elemental_generic.remove
tt.first_cooldown = b.first_cooldown
tt.cooldown = b.cooldown
tt.vis_bans = bor(F_FRIEND, F_BOSS)
tt.vis_flags = 0
tt.upgrade_price_multiplier = b.upgrade_price_multiplier
tt.default_max_range = b.default_max_range
tt.gold_fx = "fx_elemental_metal_holder_coins"
tt.root_decal_dragon = "decal_elemental_metal_holder_root_dragon"
tt.root_decal_dragon_kill = "decal_elemental_metal_holder_root_dragon"
tt.gold_steal_group_max_size = b.steal_gold.gold_steal_group_max_size
tt.gold_steal_amount = b.steal_gold.gold_steal_amount
tt.gold_steal_amount_boss = b.steal_gold.gold_steal_amount_boss
tt.steal_affect_radius = b.steal_gold.steal_radius
tt.delay_between_steals = b.steal_gold.delay_between_steals
tt.duration = b.steal_gold.delay_between_steals
tt.chase_speed = b.steal_gold.chase_speed
tt.wander_interval = b.steal_gold.wander_interval
tt.render.sid_gradiente = 1
tt.render.sid_wings = 2
tt.render.sid_hojas = 3
tt.render.sid_dragon = 4
tt.render.sid_dragon_ability = 5
tt.render.sprites[tt.render.sid_gradiente].prefix = "goldholder_gradienteDef"
tt.render.sprites[tt.render.sid_gradiente].exo = true
tt.render.sprites[tt.render.sid_gradiente].name = "idle"
tt.render.sprites[tt.render.sid_gradiente].animated = true
tt.render.sprites[tt.render.sid_gradiente].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_gradiente].offset = v(0, 0)
tt.render.sprites[tt.render.sid_wings] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_wings].prefix = "goldholder_cuernosDef"
tt.render.sprites[tt.render.sid_wings].name = "run"
tt.render.sprites[tt.render.sid_wings].exo = true
tt.render.sprites[tt.render.sid_wings].animated = true
tt.render.sprites[tt.render.sid_wings].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_wings].sort_y_offset = -10
tt.render.sprites[tt.render.sid_wings].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_wings].alpha = 0
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_hojas].prefix = "goldholder_jarrahojasDef"
tt.render.sprites[tt.render.sid_hojas].exo = true
tt.render.sprites[tt.render.sid_hojas].name = "run"
tt.render.sprites[tt.render.sid_hojas].animated = true
tt.render.sprites[tt.render.sid_hojas].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_hojas].offset = v(0, -10)
tt.render.sprites[tt.render.sid_hojas].sort_y_offset = -10
tt.render.sprites[tt.render.sid_hojas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon].prefix = "goldholder_dragonDef"
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "idle"
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].z = Z_EFFECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, -10)
tt.render.sprites[tt.render.sid_dragon].anchor = vv(0.5)
tt.render.sprites[tt.render.sid_dragon_ability] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dragon_ability].prefix = "goldholder_habilidad_1Def"
tt.render.sprites[tt.render.sid_dragon_ability].exo = true
tt.render.sprites[tt.render.sid_dragon_ability].name = "start_hability"
tt.render.sprites[tt.render.sid_dragon_ability].animated = true
tt.render.sprites[tt.render.sid_dragon_ability].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon_ability].hidden = true
tt.render.sprites[tt.render.sid_dragon_ability].anchor = vv(0.5)
tt.update_on_path_active = {
	2,
	3,
	6
}
tt.tween.sid_wings = 1
tt.tween.sid_show_hojas = 2
tt.tween.sid_hide_hojas = 3
tt.tween.props[tt.tween.sid_wings].name = "alpha"
tt.tween.props[tt.tween.sid_wings].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[tt.tween.sid_wings].sprite_id = tt.render.sid_wings
tt.tween.props[tt.tween.sid_wings].loop = false
tt.tween.props[tt.tween.sid_wings].disabled = true
tt.tween.props[tt.tween.sid_show_hojas] = E:clone_c("tween_prop")
tt.tween.props[tt.tween.sid_show_hojas].name = "alpha"
tt.tween.props[tt.tween.sid_show_hojas].loop = false
tt.tween.props[tt.tween.sid_show_hojas].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[tt.tween.sid_show_hojas].sprite_id = tt.render.sid_hojas
tt.tween.props[tt.tween.sid_show_hojas].disabled = true
tt.tween.props[tt.tween.sid_show_hojas].ignore_reverse = true
tt.tween.props[tt.tween.sid_hide_hojas] = E:clone_c("tween_prop")
tt.tween.props[tt.tween.sid_hide_hojas].name = "alpha"
tt.tween.props[tt.tween.sid_hide_hojas].loop = false
tt.tween.props[tt.tween.sid_hide_hojas].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt.tween.props[tt.tween.sid_hide_hojas].sprite_id = tt.render.sid_hojas
tt.tween.props[tt.tween.sid_hide_hojas].disabled = true
tt.tween.props[tt.tween.sid_hide_hojas].ignore_reverse = true
tt.tween.reverse = true
tt.tween.remove = false
tt = E:register_t_10086("decal_elemental_metal_holder_root_dragon", "decal_scripted")
tt.render.sprites[1].prefix = "goldholder_dragon_rootDef"
tt.render.sprites[1].exo = true
tt.render.sprites[1].name = "in"
tt.loop_times = 2
tt.main_script.update = scripts.decal_elemental_wood_holder_root_dragon.update
tt = E:register_t_10086("fx_elemental_metal_holder_coins", "fx")
tt.render.sprites[1].prefix = "goldholder_coin_splashDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_EFFECTS
tt = E:register_t_10086("mod_elemental_metal_gold_per_damage", "modifier")
b = balance.specials.terrain_8.elemental_holders.metal_holder
tt.damage_gold_ratio = b.damage_gold_ratio
tt.main_script.insert = scripts.mod_elemental_metal_gold_per_damage.insert
tt.main_script.update = scripts.mod_elemental_metal_gold_per_damage.update
tt.modifier.bans = {}
tt.modifier.duration = 0.5
tt.modifier.use_mod_offset = false
tt = E:register_t_10086("mod_stage_32_lava_splash", "modifier")
tt.main_script.insert = scripts.mod_track_target.insert
tt.main_script.update = scripts.mod_stage_32_lava_splash.update
tt.paths_y = {
	[2] = 555
}
tt.paths_y_big = {
	[2] = 555
}
tt.modifier.duration = 1e+99
tt.fx = "fx_stage_32_lava_splash"
tt.fx_big = "fx_stage_32_lava_splash_big"
tt = E:register_t_10086("mod_stage_32_lava_splash_2", "mod_stage_32_lava_splash")
tt.paths_y = {
	[3] = 555
}
tt.paths_y_big = {
	[3] = 555
}
tt.fx = "fx_stage_32_lava_splash_2"
tt.fx_big = "fx_stage_32_lava_splash_big_2"
tt = E:register_t_10086("mod_stage_35_lava_splash", "mod_stage_32_lava_splash")
tt.main_script.insert = scripts.mod_stage_35_lava_splash.insert
tt.main_script.update = scripts.mod_stage_35_lava_splash.update
tt.main_script.remove = scripts.mod_stage_35_lava_splash.remove
tt.apply_if_enemy_is_to_right = true
tt.paths_x = {
	[15] = 0,
	[7] = 0
}
tt.paths_x_big = {
	[15] = 0,
	[7] = 0
}
tt.fx = "fx_stage_35_lava_splash"
tt.fx_big = "fx_stage_35_lava_splash_big"
tt = E:register_t_10086("mod_stage_35_water_splash", "mod_stage_35_lava_splash")
tt.apply_if_enemy_is_to_right = false
tt.paths_x = {
	[8] = 1025
}
tt.paths_x_big = {
	[8] = 1025
}
tt.fx = "fx_stage_35_water_splash"
tt.fx_big = "fx_stage_35_water_splash_big"
tt = E:register_t_10086("mod_force_move_unit", "modifier")
tt.main_script.insert = scripts.mod_track_target.insert
tt.main_script.update = scripts.mod_force_move_unit.update
tt.forced_movement = nil
tt.decay_per_second = 2
tt = E:register_t_10086("mod_hero_wukong_ranged_pole_stun", "mod_stun")
b = balance.heroes.hero_wukong.pole_ranged
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_BOSS)
tt.modifier.duration = b.stun_duration

tt = E:register_t_10086("mod_hero_wukong_ultimate_slow", "mod_slow")
b = balance.heroes.hero_wukong.ultimate
tt.slow.factor = nil
tt.modifier.duration = 0.5

tt = E:register_t_10086("mod_hero_wukong_ultimate_slow_2", "mod_slow")
b = balance.heroes.hero_douzhanshengfo.ultimate
tt.slow.factor = nil
tt.modifier.duration = 0.5

tt = E:register_t_10086("mod_doom_bringer_tower_block_mark", "modifier")

E:add_comps(tt, "mark_flags")

tt.modifier.duration = fts(30)
tt.main_script.queue = scripts.mod_mark_flags.queue
tt.main_script.dequeue = scripts.mod_mark_flags.dequeue
tt.main_script.update = scripts.mod_mark_flags.update
tt = E:register_t_10086("mod_doom_bringer_tower_block", "modifier")

E:add_comps(tt, "render", "tween")

b = balance.enemies.wukong.doom_bringer
tt.main_script.insert = scripts.mod_doom_bringer_tower_block.insert
tt.main_script.update = scripts.mod_doom_bringer_tower_block.update
tt.main_script.remove = scripts.mod_doom_bringer_tower_block.remove
tt.render.sprites[1].prefix = "doom_bringer_tower_stun_tower_block"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -15
tt.render.sprites[1].offset = v(0, 20)
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "doom_bringer_stun_explotion"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].animated = true
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = -20
tt.render.sprites[2].scale = vv(2)
tt.render.sprites[2].offset = v(0, 20)
tt.modifier.duration = b.tower_curse.duration
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		0
	},
	{
		1,
		255
	},
	{
		tt.modifier.duration - 0.5,
		255
	},
	{
		tt.modifier.duration,
		0
	}
}
tt = E:register_t_10086("decal_stage33_envelop_spawn_pos", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].name = "envelops_envelop_water_idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].hidden = true
tt.editor.overrides = {
	["render.sprites[1].hidden"] = false
}
tt = E:register_t_10086("controller_stage33_envelops")

E:add_comps(tt, "main_script")

b = balance.specials.stage33_envelops
tt.main_script.update = scripts.controller_stage33_envelops.update
tt.envelop_t = "decal_stage33_envelop"
tt.decoy_t = "decal_stage33_envelop_decoy"
tt.envelop_spawn_pos_t = "decal_stage33_envelop_spawn_pos"
tt.decoy_chance = b.decoy_chance
tt.cooldown_min = b.cooldown_min
tt.cooldown_max = b.cooldown_max
tt = E:register_t_10086("decal_stage33_envelop", "decal_scripted")

E:add_comps(tt, "ui")

b = balance.specials.stage33_envelops
tt.main_script.update = scripts.decal_stage33_envelop.update
tt.render.sprites[1].prefix = "envelops_envelop_water"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].z = Z_BACKGROUND
tt.fx_open = "fx_stage33_envelop_open"
tt.max_speed = b.max_speed
tt.min_speed = b.min_speed
tt.ui.can_click = true
tt.ui.click_rect = r(-18, -7, 36, 20)
tt = E:register_t_10086("fx_stage33_envelop_open", "decal_scripted")
b = balance.specials.stage33_envelops
tt.main_script.update = scripts.fx_stage33_envelop_open.update
tt.render.sprites[1].name = "envelops_open_run"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "envelops_money_run"
tt.render.sprites[2].z = Z_EFFECTS
tt.render.sprites[2].offset = v(0, 40)
tt.render.sprites[2].sort_y_offset = -tt.render.sprites[2].offset.y - 10
tt.render.sprites[2].hidden = true
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "envelops_portraits"
tt.render.sprites[3].name = "veznan"
tt.render.sprites[3].z = Z_EFFECTS
tt.render.sprites[3].offset = v(0, 45)
tt.render.sprites[3].sort_y_offset = -tt.render.sprites[3].offset.y - 1
tt.render.sprites[3].hidden = true
tt.cards = {
	{
		name = "veznan",
		gold = b.gold
	},
	{
		name = "versper",
		gold = b.gold
	},
	{
		name = "nyru",
		gold = b.gold
	}
}
tt.balatro_card = {
	name = "balatro",
	gold = b.gold_balatro
}
tt = E:register_t_10086("fx_stage33_envelop_balatro_coins", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "envelops_money_run"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].offset = v(-20, 45)
tt.render.sprites[1].sort_y_offset = -tt.render.sprites[1].offset.y - 10
tt.render.sprites[1].hidden = false
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "envelops_money_run"
tt.render.sprites[2].z = Z_EFFECTS
tt.render.sprites[2].offset = v(25, 20)
tt.render.sprites[2].sort_y_offset = -tt.render.sprites[2].offset.y - 10
tt.render.sprites[2].hidden = true
tt.render.sprites[2].delay_start = 0.1
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "envelops_money_run"
tt.render.sprites[3].z = Z_EFFECTS
tt.render.sprites[3].offset = v(0, 50)
tt.render.sprites[3].sort_y_offset = -tt.render.sprites[3].offset.y - 10
tt.render.sprites[3].hidden = true
tt.render.sprites[3].delay_start = 0.2
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].name = "envelops_money_run"
tt.render.sprites[4].z = Z_EFFECTS
tt.render.sprites[4].offset = v(10, 30)
tt.render.sprites[4].sort_y_offset = -tt.render.sprites[4].offset.y - 10
tt.render.sprites[4].hidden = true
tt.render.sprites[4].delay_start = 0.3
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].name = "envelops_money_run"
tt.render.sprites[5].z = Z_EFFECTS
tt.render.sprites[5].offset = v(-15, 40)
tt.render.sprites[5].sort_y_offset = -tt.render.sprites[5].offset.y - 10
tt.render.sprites[5].hidden = true
tt.render.sprites[5].delay_start = 0.4
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].name = "envelops_money_run"
tt.render.sprites[6].z = Z_EFFECTS
tt.render.sprites[6].offset = v(0, 30)
tt.render.sprites[6].sort_y_offset = -tt.render.sprites[6].offset.y - 10
tt.render.sprites[6].hidden = true
tt.render.sprites[6].delay_start = 0.5
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].name = "envelops_money_run"
tt.render.sprites[7].z = Z_EFFECTS
tt.render.sprites[7].offset = v(30, 50)
tt.render.sprites[7].sort_y_offset = -tt.render.sprites[7].offset.y - 10
tt.render.sprites[7].hidden = true
tt.render.sprites[7].delay_start = 0.6
tt = E:register_t_10086("decal_stage33_envelop_decoy", "decal_stage33_envelop")
tt.render.sprites[1].prefix = "envelops_decoy_1"
tt.decoy = true
tt.ui.click_rect = r(-18, -7, 36, 20)
tt = E:register_t_10086("controller_stage_32_boss", "decal_scripted")

E:add_comps(tt, "editor", "ui")

b = balance.enemies.wukong.boss_dragon
tt.boss_controler_balance = b
tt.main_script.insert = scripts.controller_stage_32_boss.insert
tt.main_script.update = scripts.controller_stage_32_boss.update
tt.toggle_possessed = scripts.controller_stage_32_boss.toggle_possessed
tt.show_possessed = scripts.controller_stage_32_boss.show_possessed
tt.hide_possessed = scripts.controller_stage_32_boss.hide_possessed
tt.render.sid_dragon = 1
tt.exo_anim_map = {
	under_in = "dragon_redboy_BDef",
	under_samadhi_r_end = "dragon_redboy_BDef",
	idle = "dragon_redboy_CDef",
	under_samadhi_r_in = "dragon_redboy_BDef",
	under_samadhi_r_loop = "dragon_redboy_BDef",
	death_end_01 = "dragon_redboy_ADef",
	lava_crack = "dragon_redboy_CDef",
	under_samadhi_l_end = "dragon_redboy_BDef",
	under_screen_block = "dragon_redboy_BDef",
	death_in = "dragon_redboy_ADef",
	under_transform = "dragon_redboy_BDef",
	death_end_02 = "dragon_redboy_ADef",
	attack_basic_c = "dragon_redboy_ADef",
	under_talk = "dragon_redboy_BDef",
	stun_r = "dragon_redboy_CDef",
	under_idle = "dragon_redboy_BDef",
	under_samadhi_l_loop = "dragon_redboy_BDef",
	under_out = "dragon_redboy_CDef",
	death_eat_loop_b = "dragon_redboy_ADef",
	stun_l = "dragon_redboy_CDef",
	apear_in = "dragon_redboy_ADef",
	death_eat_loop_d = "dragon_redboy_ADef",
	talk = "dragon_redboy_CDef",
	death_eat_loop_a = "dragon_redboy_ADef",
	under_samadhi_l = "dragon_redboy_BDef",
	death_eat_loop_c = "dragon_redboy_ADef"
}
tt.render.sprites[tt.render.sid_dragon].prefix = tt.exo_anim_map.idle
tt.render.sprites[tt.render.sid_dragon].animated = true
tt.render.sprites[tt.render.sid_dragon].exo = true
tt.render.sprites[tt.render.sid_dragon].name = "idle"
tt.render.sprites[tt.render.sid_dragon].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_dragon].offset = v(0, 20)
tt.death_taps_per_mouth_phase = b.death_taps_per_mouth_phase
tt.bossfight_start_meteorite_side = balance.enemies.wukong.boss_redboy_teen.skyfire.bossfight_start_meteorite_side
tt.death_duration = b.death_duration
tt.ui_block_hand_fx = "fx_redboy_teen_hand"
tt.hand_decal_t = "dlc2_generic_tap_hand"
tt.boss_unit_spawn = "boss_redboy_teen"
tt.decal_fissure_fixed = "decal_dlc_wukong_flaming_ground"
tt.decal_fissure = "decal_stage_32_boss_fissure_ability"
tt.mod_tower_block = "mod_stage_32_tower_block"
tt.tower_block_mouth_fx = "fx_stage_32_dragon_mouth_fire"
tt.tower_block_mouth_fx_offset = v(0, 0)
tt.down_bubbles_decal = "decal_stage_32_boss_bubbles"
tt.ui.can_click = false
tt.ui.can_select = false
tt.ui.has_nav_mesh = false
tt.ui.click_rect = r(-140, -100, 280, 400)
tt = E:register_t_10086("decal_stage_32_boss_bubbles", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.decal_stage_32_boss_bubbles.update
tt.render.sprites[1].prefix = "dragon_redboy_bubblesDef"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].alpha = 0
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[1].sort_y_offset = -tt.render.sprites[1].offset.y
tt.down_splash_fx = "fx_stage_32_dragon_down_splash"
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(4),
		255
	}
}
tt.tween.props[1].loop = false
tt = RT("controller_stage_31_water_mechanic", "decal_scripted")

AC(tt, "ui", "editor")

b = balance.specials.stage31_water_mechanic
tt.main_script.update = scripts.controller_stage_31_water_mechanic.update
tt.duration = b.duration
tt.cooldown = b.cooldown
tt.path = b.path
tt.nodes = b.nodes
tt.warn_duration = b.warn_duration
tt.unlock_wave = b.unlock_wave
tt.spawn_every_nodes = 9
tt.check_every = 3
tt.check_radius = 60
tt.first_warn_minimum_targets = b.first_warn_minimum_targets
tt.fx_entity = "stage_31_water_mechanic_fx"
tt.fx_entity_decal = "stage_31_water_mechanic_fx_decal"
tt.hand_decal_t = "dlc2_generic_tap_hand"
tt.sound_tap = nil
tt.render.sprites[1].prefix = "fuente_unitDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "water_cracksDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].animated = true
tt.render.sprites[2].exo = true
tt.render.sprites[2].sort_y_offset = 0
tt.render.sprites[2].z = Z_DECALS - 1
tt.render.sprites[2].pos = v(512, 384)
tt.ui.can_click = true
tt.ui.can_select = true
tt.ui.has_nav_mesh = true
tt.ui.click_rect = r(-50, -90, 103, 190)
tt.extra_ui_click_rects = {
	r(-120, -60, 243, 120),
	r(-85, -80, 173, 160)
}
tt.extra_ui_click_rect_speach_bubble = r(50, 58, 78, 67)
tt.mods = {
	"mod_stage31_water_mechanic_dps"
}
tt.enemies_detection = {
	"enemy_fire_phoenix",
	"enemy_fire_fox",
	"enemy_nine_tailed_fox",
	"enemy_burning_treant",
	"enemy_ash_spirit"
}
tt = RT("generic_extra_touch_controller")

AC(tt, "pos", "ui", "main_script")

tt.main_script.update = scripts.generic_extra_touch_controller.update
tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.has_nav_mesh = false
tt = RT("stage_31_water_mechanic_fx", "decal_scripted")
tt.main_script.update = scripts.stage_31_water_mechanic_fx.update
tt.render.sprites[1].prefix = "water_splash_unitDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("stage_31_water_mechanic_fx_decal", "decal_tween")

AC(tt, "main_script")

b = balance.specials.stage31_water_mechanic
tt.render.sprites[1].prefix = "charco_unitDef"
tt.render.sprites[1].name = "Idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.duration = b.duration
tt.added_scale = 1

function tt.main_script.insert(this, store, script)
	this.render.sprites[1].ts = store.tick_ts
	this.tween.ts = store.tick_ts
	this.render.sprites[1].flip_x = math.random() > 0.5

	local start_delay = math.random() * fts(8)

	this.tween.props[1].keys = {
		{
			0,
			0
		},
		{
			start_delay,
			0
		},
		{
			start_delay + fts(7),
			255
		},
		{
			start_delay + fts(7) + this.duration,
			255
		},
		{
			start_delay + fts(7) + this.duration + fts(27),
			0
		}
	}
	this.tween.props[2].keys = {
		{
			0,
			vv(0.8 * this.added_scale)
		},
		{
			start_delay,
			vv(0.8 * this.added_scale)
		},
		{
			start_delay + fts(7),
			vv(1 * this.added_scale)
		},
		{
			start_delay + fts(7) + this.duration,
			vv(1 * this.added_scale)
		},
		{
			start_delay + fts(7) + this.duration + fts(27),
			vv(0.8 * this.added_scale)
		}
	}

	return true
end

tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(2),
		0
	},
	{
		fts(7),
		255
	},
	{
		fts(7) + tt.duration,
		255
	},
	{
		fts(7) + tt.duration + fts(27),
		0
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		vv(0.8)
	},
	{
		fts(2),
		vv(0.8)
	},
	{
		fts(7),
		vv(1)
	},
	{
		fts(7) + tt.duration,
		vv(1)
	},
	{
		fts(7) + tt.duration + fts(27),
		vv(0.8)
	}
}
tt.tween.props[2].name = "scale"
tt.tween.props[2].sprite_id = 1
tt.tween.remove = true
tt = E:register_t_10086("decal_stage_31_easter_egg_oogway", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_31_easter_egg_oogway.update
tt.render.sprites[1].prefix = "stage_31_oogwayDef"
tt.render.sprites[1].name = "idle1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.idle_cooldown_max = 20
tt.idle_cooldown_min = 5
tt.ui.click_rect = r(-30, -20, 60, 60)
tt = E:register_t_10086("decal_stage_31_easter_egg_littledragon", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_31_easter_egg_littledragon.update
tt.render.sprites[1].prefix = "littledragon_easteregg_stage1_easteregg"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -30
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "littledragon_easteregg_stage1_easter_egg_dead"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(5, -30)
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "littledragon_easteregg_stage1_tree"
tt.render.sprites[3].animated = false
tt.render.sprites[3].anchor = v(0, 0)
tt.render.sprites[3].offset = v(-69, -23)
tt.render.sprites[3].z = Z_OBJECTS
tt.ui.click_rect = r(-30, -20, 60, 60)
tt = E:register_t_10086("decal_stage_32_easter_egg_sheepy", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_32_easter_egg_sheepy.update
tt.render.sprites[1].prefix = "sheepylava_sheepy"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "sheepylava_crater_1"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(-45, -30)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "sheepylava_crater_2"
tt.render.sprites[3].animated = false
tt.render.sprites[3].offset = v(-20, 0)
tt.render.sprites[3].sort_y_offset = 2
tt.render.sprites[3].z = Z_OBJECTS
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "sheepylava_crater_3"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].animated = true
tt.render.sprites[4].z = Z_OBJECTS
tt.render.sprites[4].offset = v(25, -20)
tt.ui.click_rect = r(-30, -20, 60, 60)
tt = E:register_t_10086("decal_achievement_saitam_stage31", "decal_scripted")

E:add_comps(tt, "ui", "editor", "tween")

tt.main_script.update = scripts.decal_achievement_saitam.update
tt.render.sprites[1].prefix = "easter_egg_saitam_saitam_stage_1"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].offset = v(-30, 5)
tt.render.sprites[1].anchor = v(0.3333333333333333, 0.5222222222222223)
tt.ui.click_rect = r(-50, -5, 40, 30)
tt.tween.remove = true
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt = E:register_t_10086("decal_achievement_saitam_stage32", "decal_achievement_saitam_stage31")
tt.render.sprites[1].prefix = "easter_egg_saitam_saitam_stage_2"
tt = E:register_t_10086("decal_achievement_saitam_stage33", "decal_achievement_saitam_stage31")
tt.render.sprites[1].prefix = "easter_egg_saitam_saitam_stage_3"
tt = E:register_t_10086("decal_achievement_saitam_stage34", "decal_achievement_saitam_stage31")
tt.render.sprites[1].prefix = "easter_egg_saitam_saitam_stage_4"
tt = E:register_t_10086("decal_achievement_saitam_stage35", "decal_achievement_saitam_stage31")
tt.render.sprites[1].prefix = "easter_egg_saitam_saitam_stage_5"
tt = E:register_t_10086("dlc2_generic_tap_hand", "decal_tween")
tt.render.sprites[1].prefix = "dlc2_generic_tap_hand"
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
		fts(15),
		255
	},
	{
		fts(60),
		0
	}
}
tt.tween.remove = true
tt = RT("controller_stage_33_lightning_strike")

AC(tt, "pos", "main_script", "editor", "editor_script")

b = balance.specials.stage32_lightning_strike
tt.main_script.update = scripts.controller_stage_33_lightning_strike.update
tt.force_target_soldier_chance = b.force_target_soldier_chance
tt.chain_strikes_chance = b.chain_strikes_chance
tt.max_chains = b.max_chains
tt.areas_configs = b.areas_configs
tt.strikes_spawn_radius = 100
tt.area_id = 1
tt.editor.components = {
	"render",
	"texts"
}
tt.editor.overrides = {
	["render.sprites[1].animated"] = false,
	["render.sprites[1].name"] = "editor_cyan_circle"
}
tt.editor.props = {
	{
		"strikes_spawn_radius",
		PT_NUMBER
	},
	{
		"area_id",
		PT_NUMBER
	}
}
tt.editor_script.update = scripts.controller_stage_33_lightning_strike.editor_update
tt = RT("stage_33_lightning_strike", "decal_scripted")

AC(tt, "tween")

b = balance.specials.stage32_lightning_strike
tt.main_script.update = scripts.stage_33_lightning_strike.update
tt.damage_config = b.damage_config
tt.warning_duration = b.warning_duration
tt.render.sid_decal = 1
tt.render.sid_deco = 2
tt.render.sid_spawner = 3
tt.vis_bans = bor(F_FLYING, F_ENEMY)
tt.vis_flags = bor(F_AREA)
tt.render.sprites[tt.render.sid_decal] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_decal].prefix = "vfx_mecanicas_ray_decal"
tt.render.sprites[tt.render.sid_decal].name = "Idle"
tt.render.sprites[tt.render.sid_decal].hidden = true
tt.render.sprites[tt.render.sid_decal].loop = false
tt.render.sprites[tt.render.sid_decal].offset = v(0, -5)
tt.render.sprites[tt.render.sid_decal].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_deco] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_deco].prefix = "vfx_mecanicas_ray_deco"
tt.render.sprites[tt.render.sid_deco].name = "idle"
tt.render.sprites[tt.render.sid_deco].hidden = true
tt.render.sprites[tt.render.sid_deco].loop = false
tt.render.sprites[tt.render.sid_deco].offset = v(0, -5)
tt.render.sprites[tt.render.sid_deco].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_spawner] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_spawner].prefix = "vfx_mecanicas_ray_portal"
tt.render.sprites[tt.render.sid_spawner].name = "run"
tt.render.sprites[tt.render.sid_spawner].hidden = true
tt.render.sprites[tt.render.sid_spawner].loop = false
tt.render.sprites[tt.render.sid_spawner].offset = v(0, 0)
tt.render.sprites[tt.render.sid_spawner].z = Z_OBJECTS
tt.flash_delay_max = 0.3
tt.flash_delay_min = 0.1
tt.flash_duration_max = 0.3
tt.flash_duration_min = 0.2
tt.flash_l1_max_alphas = {
	180,
	200
}
tt.flash_l2_max_alpha = 70
tt.flash_l2_min_alpha = 60
tt.flash_delta = 0.02
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.4,
		255
	}
}
tt.tween.props[1].keys_end = {
	{
		0,
		255
	},
	{
		0.2,
		255
	},
	{
		0.4,
		0
	}
}
tt.tween.props[1].sprite_id = tt.render.sid_decal
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = tt.render.sid_deco
tt.tween.props[3] = table.deepclone(tt.tween.props[1])
tt.tween.props[3].keys_end = {
	{
		0,
		255
	},
	{
		0.2,
		0
	},
	{
		0.4,
		0
	}
}
tt.tween.props[3].sprite_id = tt.render.sid_spawner
tt = E:register_t_10086("stage_33_lightning_strike_overlay", "decal_tween")

E:add_comps(tt, "tween")

image_y = 64
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "square_ffffff"
tt.render.sprites[1].scale = v(math.ceil(REF_H * 16 / 9 * 1.1 / image_y), math.ceil(REF_H / image_y))
tt.render.sprites[1].z = Z_OBJECTS_SKY + 2
tt.render.sprites[1].alpha = 0
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "square_ffffff"
tt.render.sprites[2].color = {
	184,
	184,
	184
}
tt.render.sprites[2].alpha = 0
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].sprite_id = 2
tt.tween.remove = false
tt.ts = 0
tt.cooldown = 0
tt = E:register_t_10086("stage_33_lightning_strike_fx_power_thunder_1", "decal_tween")

E:add_comps(tt, "sound_events")

tt.image_h = 496
tt.render.sprites[1].name = "rayo_og_ray_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(3),
		255
	},
	{
		fts(8),
		0
	}
}
tt.sound_events.insert = "Stage33StormLightning"
tt = E:register_t_10086("stage_33_lightning_strike_fx_power_thunder_2", "stage_33_lightning_strike_fx_power_thunder_1")
tt.image_h = 456
tt.render.sprites[1].name = "rayo_og_ray_2"
tt = E:register_t_10086("stage_33_lightning_strike_fx_power_thunder_explosion", "fx")
tt.render.sprites[1].name = "stage_33_lightning_strike_fx_power_thunder_explosion"
tt.render.sprites[1].sort_y_offset = -5
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].flip_x = true
tt = E:register_t_10086("stage_33_lightning_strike_fx_power_thunder_explosion_decal", "fx")
tt.render.sprites[1].name = "stage_33_lightning_strike_fx_power_thunder_explosion_decal"
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("controller_stage_32_lava_splash")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_32_lava_splash.update
tt.mod = "mod_stage_32_lava_splash"
tt.paths_y = {
	[2] = 560
}
tt.vis_flags = 0
tt.vis_bans = 0
tt = E:register_t_10086("controller_stage_32_lava_splash_2", "controller_stage_32_lava_splash")
tt.mod = "mod_stage_32_lava_splash_2"
tt.paths_y = {
	[3] = 560
}
tt = E:register_t_10086("controller_stage_34_ponds_spawner")

E:add_comps(tt, "main_script", "events")

tt.main_script.update = scripts.controller_stage_34_ponds_spawner.update
tt.unit_t = "enemy_water_spirit_spawnless"
tt.events.list[1].name = "pond_spawn_water_spirit"
tt.events.list[1].on_event = scripts.controller_stage_34_ponds_spawner.on_event
tt = E:register_t_10086("controller_boss_princess_iron_fan_waves", "decal_scripted")

E:add_comps(tt, "main_script", "editor")

b = balance.enemies.wukong.boss_princess
tt.force_capture_hero = scripts.controller_boss_princess_iron_fan_waves.force_capture_hero
tt.force_go_middle = scripts.controller_boss_princess_iron_fan_waves.force_go_middle
tt.force_go_back = scripts.controller_boss_princess_iron_fan_waves.force_go_back
tt.main_script.update = scripts.controller_boss_princess_iron_fan_waves.update
tt.render.sid_unit = 1
tt.render.sprites[tt.render.sid_unit].prefix = "boss_princessDef"
tt.render.sprites[tt.render.sid_unit].exo = true
tt.render.sprites[tt.render.sid_unit].animated = true
tt.render.sprites[tt.render.sid_unit].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_unit].name = "idle"
tt.render.sprites[tt.render.sid_unit].z = Z_OBJECTS
tt.pos_sitting = v(1060, 405)
tt.pos_standing = v(605, 355)
tt.illusory_summon = b.waves.illusory_summon
tt.block_tower = b.waves.tower_curse
tt.block_tower_loop_duration = 3
tt.block_tower_mod = "boss_princess_iron_fan_tower_debuff"
tt.boss_unit_spawn = "boss_princess_iron_fan"
tt.stun_hero = b.waves.stun_hero
tt.stun_hero_decal = "decal_boss_princess_iron_fan_stun_heroes_waves"
tt.stun_hero_warning_duration = b.waves.stun_hero.WARNING_DURATION
tt.stun_hero_vis_flags = bor(F_MOD, F_STUN, F_AREA)
tt.stun_hero_vis_bans = bor(0)
tt.shield_duration = b.waves.shield.duration
tt.shield_decal = "decal_boss_princess_iron_fan_waves_shield"
tt.sound_teleport_in = "EnemyBossPrincessTeleportIn"
tt.sound_teleport_out = "EnemyBossPrincessTeleportOut"
tt.sound_stun_hero_channel = "EnemyBossPrincessHeroStunChannel"
tt.sound_stun_hero_fail = "EnemyBossPrincessHeroStunFail"
tt.sound_stun_hero_success = "EnemyBossPrincessHeroStunSuccess"
tt = E:register_t_10086("controller_stage_33_ciclone", "decal_scripted")

E:add_comps(tt, "editor", "ui", "events")

tt.main_script.update = scripts.controller_stage_33_ciclone.update
tt.render.sid_tejas = 1
tt.render.sid_dirty = 2
tt.render.sid_shadow = 3
tt.render.sid_clouds_der = 4
tt.render.sid_clouds_izq = 5
tt.render.sid_shadow_2 = 6
tt.render.sid_clouds_fly = 7
tt.render.sid_shadows_fly = 8
tt.render.sid_storm_rayos = 9
tt.render.sid_tejas_puerta = 10
tt.render.sid_escombros = 11
tt.render.sprites[tt.render.sid_tejas] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_tejas].prefix = "stage_33_tejasDef"
tt.render.sprites[tt.render.sid_tejas].animated = true
tt.render.sprites[tt.render.sid_tejas].exo = true
tt.render.sprites[tt.render.sid_tejas].name = "idle"
tt.render.sprites[tt.render.sid_tejas].z = Z_OBJECTS_COVERS
tt.render.sprites[tt.render.sid_tejas].group = "layers"
tt.render.sprites[tt.render.sid_tejas_puerta] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_tejas_puerta].prefix = "stage_33_tejas_puertaDef"
tt.render.sprites[tt.render.sid_tejas_puerta].animated = true
tt.render.sprites[tt.render.sid_tejas_puerta].exo = true
tt.render.sprites[tt.render.sid_tejas_puerta].name = "idle"
tt.render.sprites[tt.render.sid_tejas_puerta].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_dirty] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_dirty].prefix = "stage_33_dirtyDef"
tt.render.sprites[tt.render.sid_dirty].animated = true
tt.render.sprites[tt.render.sid_dirty].exo = true
tt.render.sprites[tt.render.sid_dirty].name = "idle"
tt.render.sprites[tt.render.sid_dirty].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_dirty].group = "layers"
tt.render.sprites[tt.render.sid_shadow] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_shadow].prefix = "stage_33_shadow_screenDef"
tt.render.sprites[tt.render.sid_shadow].animated = true
tt.render.sprites[tt.render.sid_shadow].exo = true
tt.render.sprites[tt.render.sid_shadow].name = "idle"
tt.render.sprites[tt.render.sid_shadow].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_shadow].group = "layers"
tt.render.sprites[tt.render.sid_shadows_fly] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_shadows_fly].prefix = "stage_33_shadows_flyDef"
tt.render.sprites[tt.render.sid_shadows_fly].animated = true
tt.render.sprites[tt.render.sid_shadows_fly].exo = true
tt.render.sprites[tt.render.sid_shadows_fly].name = "idle"
tt.render.sprites[tt.render.sid_shadows_fly].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_clouds_der] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_clouds_der].prefix = "stage_33_storm_clouds_derDef"
tt.render.sprites[tt.render.sid_clouds_der].animated = true
tt.render.sprites[tt.render.sid_clouds_der].exo = true
tt.render.sprites[tt.render.sid_clouds_der].name = "in"
tt.render.sprites[tt.render.sid_clouds_der].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_clouds_der].group = "layers"
tt.render.sprites[tt.render.sid_clouds_izq] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_clouds_izq].prefix = "stage_33_storm_clouds_izqDef"
tt.render.sprites[tt.render.sid_clouds_izq].animated = true
tt.render.sprites[tt.render.sid_clouds_izq].exo = true
tt.render.sprites[tt.render.sid_clouds_izq].name = "in"
tt.render.sprites[tt.render.sid_clouds_izq].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_clouds_izq].group = "layers"
tt.render.sprites[tt.render.sid_storm_rayos] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_storm_rayos].prefix = "stage_33_storm_rayosDef"
tt.render.sprites[tt.render.sid_storm_rayos].animated = true
tt.render.sprites[tt.render.sid_storm_rayos].exo = true
tt.render.sprites[tt.render.sid_storm_rayos].name = "in"
tt.render.sprites[tt.render.sid_storm_rayos].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_storm_rayos].group = "layers"
tt.render.sprites[tt.render.sid_clouds_fly] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_clouds_fly].prefix = "stage_33_clouds_flyDef"
tt.render.sprites[tt.render.sid_clouds_fly].animated = true
tt.render.sprites[tt.render.sid_clouds_fly].exo = true
tt.render.sprites[tt.render.sid_clouds_fly].name = "idle"
tt.render.sprites[tt.render.sid_clouds_fly].z = Z_OBJECTS_SKY
tt.render.sprites[tt.render.sid_clouds_fly].group = "layers"
tt.render.sprites[tt.render.sid_shadow_2] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_shadow_2].prefix = "stage_33_storm_shadowDef"
tt.render.sprites[tt.render.sid_shadow_2].animated = true
tt.render.sprites[tt.render.sid_shadow_2].exo = true
tt.render.sprites[tt.render.sid_shadow_2].name = "loop"
tt.render.sprites[tt.render.sid_shadow_2].z = Z_OBJECTS_SKY + 1
tt.render.sprites[tt.render.sid_escombros] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_escombros].prefix = "stage33_explosion_escombrosDef"
tt.render.sprites[tt.render.sid_escombros].animated = true
tt.render.sprites[tt.render.sid_escombros].exo = true
tt.render.sprites[tt.render.sid_escombros].name = "idle"
tt.render.sprites[tt.render.sid_escombros].z = Z_DECALS
tt.render.sprites[tt.render.sid_escombros].hidden = true
tt.events.list[1].name = "ciclone"
tt.events.list[1].on_event = scripts.controller_stage_33_ciclone.on_event
tt = E:register_t_10086("controller_stage_33_house_doors")

E:add_comps(tt, "main_script")

tt.main_script.insert = scripts.controller_stage_33_house_doors.insert
tt.citizen_spawned = scripts.controller_stage_33_house_doors.citizen_spawned
tt.door_positions = {
	{
		template = "stage_33_citizen_house_1",
		pos = v(72, 348)
	},
	{
		template = "stage_33_citizen_house_2",
		pos = v(197, 348)
	},
	{
		template = "stage_33_citizen_house_1",
		pos = v(235, 693)
	},
	{
		template = "stage_33_citizen_house_2",
		pos = v(387, 693)
	},
	{
		template = "stage_33_citizen_house_1",
		pos = v(799, 692)
	},
	{
		template = "stage_33_citizen_house_2",
		pos = v(925, 696)
	},
	{
		template = "stage_33_citizen_house_2",
		pos = v(1030, 348)
	}
}
tt = E:register_t_10086("controller_stage_33_boat", "decal_scripted")
tt.main_script.update = scripts.controller_stage_33_boat.update

E:add_comps(tt, "events")

tt.render.sid_boat = 1
tt.render.sid_sail = 2
tt.render.sprites[tt.render.sid_boat].prefix = "stage_3_barcoDef"
tt.render.sprites[tt.render.sid_boat].animated = true
tt.render.sprites[tt.render.sid_boat].exo = true
tt.render.sprites[tt.render.sid_boat].name = "idle"
tt.render.sprites[tt.render.sid_boat].z = Z_DECALS
tt.render.sprites[tt.render.sid_boat].hidden = true
tt.render.sprites[tt.render.sid_sail] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_sail].prefix = "stage_3_barco_velaDef"
tt.render.sprites[tt.render.sid_sail].animated = true
tt.render.sprites[tt.render.sid_sail].exo = true
tt.render.sprites[tt.render.sid_sail].name = "idle"
tt.render.sprites[tt.render.sid_sail].z = Z_DECALS
tt.render.sprites[tt.render.sid_boat].hidden = true
tt.events.list[1].name = "boat"
tt.events.list[1].on_event = scripts.controller_stage_33_boat.on_event
tt = RT("controller_stage_33_tambor", "decal_scripted")
tt.do_tambor = scripts.controller_stage_33_tambor.do_tambor
tt.main_script.update = scripts.controller_stage_33_tambor.update
tt.render.sprites[1].prefix = "stage_33_barco_call_tambor"
tt.render.sprites[1].name = "idle_tambor"
tt.render.sprites[1].anchor = v(0.05777310924369748, 0.55625)
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -50
tt.render.sprites[1].group = "group"
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].prefix = "stage_33_barco_call_body"
tt.render.sprites[2].anchor = v(0.11346863468634687, 0.5290697674418605)
tt.render.sprites[2].sort_y_offset = -49
tt = E:register_t_10086("boss_princess_iron_fan", "boss")
b = balance.enemies.wukong.boss_princess.bossfight

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.enemy.lives_cost = 999
tt.enemy.melee_slot = v(45, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 1e+99
tt.health_bar.offset = v(0, 90)
tt.unit.hit_offset = v(-5, 30)
tt.unit.head_offset = v(-2, 20)
tt.unit.mod_offset = v(-5, 30)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-35, 0, 60, 80)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_RED
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_BOSS_PRINCESS_IRON_FAN"
tt.info.enc_icon = 117
tt.info.portrait = "gui_bottom_info_image_enemies_0122"
tt.info.portrait_boss = "boss_health_bar_icon_0012"
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.render.sid_unit = 1
tt.render.sprites[tt.render.sid_unit].prefix = "boss_princessDef"
tt.render.sprites[tt.render.sid_unit].exo = true
tt.render.sprites[tt.render.sid_unit].animated = true
tt.render.sprites[tt.render.sid_unit].name = "idle"
tt.render.sprites[tt.render.sid_unit].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_unit].angles = {}
tt.render.sprites[tt.render.sid_unit].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.unit.show_blood_pool = false
tt.spawn_pos = b.spawn_pos
tt.health.on_damage = scripts.boss_princess_iron_fan.on_damage
tt.main_script.insert = scripts.boss_princess_iron_fan.insert
tt.main_script.update = scripts.boss_princess_iron_fan.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack_melee"
tt.melee.attacks[1].hit_times = {
	fts(12),
	fts(18),
	fts(25)
}
tt.melee.attacks[1].hit_decal = "fx_boss_spider_queen_melee_hit_decal"
tt.melee.attacks[1].sound = "EnemyBossPrincessMelee"
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].cooldown = b.area_attack.cooldown
tt.melee.attacks[2].damage_max = b.area_attack.damage_max
tt.melee.attacks[2].damage_min = b.area_attack.damage_min
tt.melee.attacks[2].damage_type = b.area_attack.damage_type
tt.melee.attacks[2].damage_radius = b.area_attack.radius
tt.melee.attacks[2].animation = "attack_area"
tt.melee.attacks[2].hit_time = fts(28)
tt.melee.attacks[2].hit_fx = "fx_boss_spider_queen_melee_hit"
tt.melee.attacks[2].hit_fx_offset = v(55, 10)
tt.melee.attacks[2].hit_decal = "fx_boss_princess_iron_fan_area_attack"
tt.melee.attacks[2].sound = "EnemyBossPrincessMeleeArea"
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet = "bullet_boss_princess_iron_fan"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 30)
}
tt.ranged.attacks[1].cooldown = b.ranged_area_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_area_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_area_attack.min_range
tt.ranged.attacks[1].shoot_time = fts(21)
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "stun_tower"
tt.timed_attacks.list[1].first_cooldown = b.illusory_summon.first_cooldown
tt.timed_attacks.list[1].cooldown = b.illusory_summon.cooldown
tt.timed_attacks.list[1].nodes_limit = b.illusory_summon.nodes_limit
tt.timed_attacks.list[1].shield_decal = "decal_boss_princess_iron_fan_bossfight_shield"
tt.timed_attacks.list[2] = E:clone_c("custom_attack")
tt.timed_attacks.list[2].animation_in = "stun_tower_in"
tt.timed_attacks.list[2].animation_loop = "stun_tower_loop"
tt.timed_attacks.list[2].animation_end = "stun_tower_out"
tt.timed_attacks.list[2].first_cooldown = b.tower_curse.first_cooldown
tt.timed_attacks.list[2].cooldown = b.tower_curse.cooldown
tt.timed_attacks.list[2].loops_amount = 2
tt.timed_attacks.list[2].nodes_limit = b.tower_curse.nodes_limit
tt.timed_attacks.list[2].range = b.tower_curse.range
tt.timed_attacks.list[2].mod = "boss_princess_iron_fan_tower_debuff_bossfight"
tt.timed_attacks.list[2].holders_not_to_block = b.tower_curse.holders_not_to_block
tt.timed_attacks.list[3] = E:clone_c("custom_attack")
tt.timed_attacks.list[3].animation_in = "clone_in"
tt.timed_attacks.list[3].animation_loop = "clone_loop"
tt.timed_attacks.list[3].animation_end = "clone_out"
tt.timed_attacks.list[3].first_cooldown = b.illusory_self.first_cooldown
tt.timed_attacks.list[3].cooldown = b.illusory_self.cooldown
tt.timed_attacks.list[3].nodes_limit = b.illusory_self.nodes_limit
tt.timed_attacks.list[3].spawn_pos = b.illusory_self.clon_config.spawn_pos
tt.timed_attacks.list[3].casts = 0
tt.timed_attacks.list[3].loops_amount = 3
tt.timed_attacks.list[3].entity = "boss_princess_iron_fan_clone"
tt.timed_attacks.list[4] = E:clone_c("custom_attack")
tt.timed_attacks.list[4].config = b.change_paths.config
tt.timed_attacks.list[4].cooldown = b.change_paths.cooldown
tt.timed_attacks.list[4].animation_in = "teleport_in"
tt.timed_attacks.list[4].animation_out = "teleport_out"
tt.timed_attacks.list[5] = E:clone_c("custom_attack")
tt.timed_attacks.list[5].animation = "stun_hero"
tt.timed_attacks.list[5].warning_duration = b.stun_hero.warning_duration
tt.timed_attacks.list[5].first_cooldown = b.stun_hero.first_cooldown
tt.timed_attacks.list[5].cooldown = b.stun_hero.cooldown
tt.timed_attacks.list[5].nodes_limit = b.stun_hero.nodes_limit
tt.timed_attacks.list[5].range = b.stun_hero.range
tt.timed_attacks.list[5].stun_decal = "decal_boss_princess_iron_fan_stun_heroes_bossfight"
tt.timed_attacks.list[5].vis_flags = bor(F_MOD, F_STUN, F_AREA)
tt.timed_attacks.list[5].vis_bans = bor(0)
tt.sound_death = "EnemyBossPrincessDeath"
tt.sound_teleport_out = "EnemyBossPrincessTeleportOut"
tt.sound_clone = "EnemyBossPrincessClone"
tt.sound_stun_hero_channel = "EnemyBossPrincessHeroStunChannel"
tt.sound_stun_hero_fail = "EnemyBossPrincessHeroStunFail"
tt.sound_stun_hero_success = "EnemyBossPrincessHeroStunSuccess"
tt = E:register_t_10086("boss_princess_iron_fan_clone", "boss_princess_iron_fan")
b = balance.enemies.wukong.boss_princess.bossfight.illusory_self.clon_config
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_BOSS_PRINCESS_IRON_FAN"
tt.info.enc_icon = 14
tt.info.portrait = "gui_bottom_info_image_enemies_0123"
tt.info.portrait_boss = nil
tt.render.sprites[tt.render.sid_unit].prefix = "boss_princess_cloneDef"
tt.render.sprites[tt.render.sid_unit].name = "spawn_in"
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_decal = "fx_boss_spider_queen_melee_hit_decal"
tt.melee.attacks[2] = nil
tt.ranged.attacks[1].bullet = "bullet_boss_princess_iron_fan"
tt.ranged.attacks[1].cooldown = b.ranged_area_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_area_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_area_attack.min_range
tt.ranged.attacks[1].ignore_hit_offset = true
tt.timed_attacks.list[1] = nil
tt.timed_attacks.list[2] = nil
tt.timed_attacks.list[3] = nil
tt.timed_attacks.list[4] = nil
tt.timed_attacks.list[5] = nil
tt.unit.fade_time_after_death = 0.5
tt.unit.fade_duration_after_death = 0.5
tt.sound_death = nil
tt = E:register_t_10086("decal_boss_princess_iron_fan_waves_shield", "enemy_KR5")
b = balance.enemies.wukong.boss_princess
tt.health.hp_max = b.waves.shield.health
tt.health.armor = b.waves.shield.armor
tt.health.magic_armor = b.waves.shield.magic_resistance
tt.health_bar.hidden = true
tt.health_bar.offset = v(0, 90)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.health_bar.colors = {}
tt.health_bar.colors.fg = {
	255,
	65,
	240,
	255
}
tt.health_bar.colors.bg = {
	51,
	18,
	53,
	255
}
tt.health_bar.sort_y_offset = -2
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.decal_boss_princess_iron_fan_waves_shield.update
tt.render.sprites[1].name = "boss_princess_iron_fan_vfx_stun_hero_particle_loop"
tt.render.sprites[1].alpha = 0
tt.render.sprites[1].hidden = true
tt.enemy.gold = 0
tt.enemy.melee_slot = v(0, 0)
tt.enemy.lives_cost = 0
tt.motion.max_speed = 0
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_NONE
tt.unit.hit_offset = v(0, 40)
tt.unit.mod_offset = v(0, 40)
tt.ui.can_click = false
tt.ui.can_select = false
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS, F_CLIFF)
tt.vis.bans = bor(F_ALL)
tt.can_explode = false
tt.can_disintegrate = false
tt = E:register_t_10086("decal_boss_princess_iron_fan_bossfight_shield", "enemy_KR5")

E:add_comps(tt, "tween")

b = balance.enemies.wukong.boss_princess.bossfight
tt.health.hp_max = b.illusory_summon.shield_hp
tt.health.armor = b.illusory_summon.shield_armor
tt.health.magic_armor = b.illusory_summon.shield_magic_resistance
tt.health_bar.hidden = true
tt.health_bar.offset = v(0, 90)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.health_bar.colors = {}
tt.health_bar.colors.fg = {
	255,
	65,
	240,
	255
}
tt.health_bar.colors.bg = {
	51,
	18,
	53,
	255
}
tt.health_bar.sort_y_offset = -2
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.decal_boss_princess_iron_fan_bossfight_shield.update
tt.render.sprites[1].name = "s34_malicia_shield_idle"
tt.render.sprites[1].anchor.y = 0.1423076923076923
tt.render.sprites[1].offset = v(-5, -10)
tt.render.sprites[1].alpha = 0
tt.render.sprites[1].sort_y_offset = -1
tt.enemy.gold = 0
tt.enemy.melee_slot = v(0, 0)
tt.enemy.lives_cost = 0
tt.motion.max_speed = 0
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_NONE
tt.unit.hit_offset = v(0, 40)
tt.unit.mod_offset = v(0, 40)
tt.ui.can_click = false
tt.ui.can_select = false
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		vv(1.9)
	},
	{
		fts(10),
		vv(2.09)
	},
	{
		fts(20),
		vv(1.9)
	}
}
tt.tween.props[1].loop = true
tt.tween.props[1].ignore_reverse = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		fts(11),
		153
	}
}
tt.shield_dps = tt.health.hp_max / b.illusory_summon.shield_duration
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt.vis.bans = bor(F_ALL)
tt.can_explode = false
tt.can_disintegrate = false
tt.manual_wave_name = b.illusory_summon.manual_wave_name
tt = E:register_t_10086("decal_boss_princess_iron_fan_stun_heroes_waves", "decal_scripted")

E:add_comps(tt, "tween")

b = balance.enemies.wukong.boss_princess.waves.stun_hero
tt.finish = scripts.decal_boss_princess_iron_fan_stun_heroes.finish
tt.hero_escaped = scripts.decal_boss_princess_iron_fan_stun_heroes.hero_escaped
tt.capture_hero = scripts.decal_boss_princess_iron_fan_stun_heroes.capture_hero
tt.main_script.update = scripts.decal_boss_princess_iron_fan_stun_heroes.update
tt.render.sprites[1].prefix = "boss_princess_iron_fan_vfx_stun_hero_decal"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].sort_y_offset = -50
tt.render.sprites[1].group = "in_group"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "boss_princess_iron_fan_vfx_stun_hero_decal_2"
tt.render.sprites[2].name = "loop"
tt.render.sprites[2].animated = true
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].sort_y_offset = -50
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "boss_princess_iron_fan_vfx_stun_hero_decal_3"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].animated = true
tt.render.sprites[3].z = Z_DECALS
tt.render.sprites[3].sort_y_offset = -50
tt.render.sprites[3].group = "in_group"
tt.warning_duration = b.WARNING_DURATION
tt.stun_radius = 60
tt.vis_flags = bor(F_AREA, F_STUN, F_MOD)
tt.vis_bans = bor(0)
tt.stun_mod = "mod_boss_princess_iron_fan_stun_heroes_waves"
tt.tween.remove = false
tt.tween.disabled = false
tt.tween.props[1].name = "alpha"
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
tt.tween.props[1].sprite_id = 2
tt.tween.props[1].disabled = false
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt.tween.props[2].sprite_id = 1
tt.tween.props[2].disabled = true
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].name = "alpha"
tt.tween.props[3].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt.tween.props[3].sprite_id = 2
tt.tween.props[3].disabled = true
tt.tween.props[4] = E:clone_c("tween_prop")
tt.tween.props[4].name = "alpha"
tt.tween.props[4].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt.tween.props[4].sprite_id = 3
tt.tween.props[4].disabled = true
tt = E:register_t_10086("decal_boss_princess_iron_fan_stun_heroes_bossfight", "decal_boss_princess_iron_fan_stun_heroes_waves")
b = balance.enemies.wukong.boss_princess.bossfight.stun_hero
tt.stun_mod = "mod_boss_princess_iron_fan_stun_heroes_bossfight"
tt = E:register_t_10086("mod_boss_princess_iron_fan_stun_heroes_waves", "mod_stun")

E:add_comps(tt, "tween")

b = balance.enemies.wukong.boss_princess.waves.stun_hero
tt.modifier.duration = b.DURATION
tt.main_script.insert = scripts.mod_boss_princess_iron_fan_stun_heroes.insert
tt.main_script.update = scripts.mod_boss_princess_iron_fan_stun_heroes.update
tt.main_script.remove = scripts.mod_boss_princess_iron_fan_stun_heroes.remove
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "boss_princess_iron_fan_vfx_stun_hero"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt.render.sprites[1].group = "stun"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].anchor = v(0.5, 0.7121212121212122)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "boss_princess_iron_fan_vfx_stun_hero_particle_loop"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = -5
tt.render.sprites[2].hidden = true
tt.render.sprites[2].anchor = v(0.5, 0.7884615384615384)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "boss_princess_iron_fan_vfx_stun_hero_loop_shadow_0001"
tt.render.sprites[3].animated = false
tt.render.sprites[3].z = Z_DECALS
tt.render.sprites[3].hidden = true
tt.modifier.use_mod_offset = false
tt.fx_flying = "fx_boss_princess_iron_fan_stun_heroes_flying"
tt.fx_ground = "fx_boss_princess_iron_fan_stun_heroes_ground"
tt.levitate_strength = 10
tt.levitate_speed = 2
tt.minimum_y_offset = 40
tt.tween_remove_keys = {
	{
		0,
		255
	},
	{
		0.4,
		255
	},
	{
		0.7,
		0
	}
}
tt.tween.props[1].name = "alpha"
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
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].name = "alpha"
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[3].sprite_id = 3
tt.tween.remove = false
tt.tween.disabled = false
tt = E:register_t_10086("mod_boss_princess_iron_fan_stun_heroes_bossfight", "mod_boss_princess_iron_fan_stun_heroes_waves")
b = balance.enemies.wukong.boss_princess.bossfight.stun_hero
tt = E:register_t_10086("mod_boss_princess_iron_fan_death", "mod_boss_princess_iron_fan_stun_heroes_waves")
tt.main_script.insert = scripts.mod_boss_princess_iron_fan_death.insert
tt.main_script.update = scripts.mod_boss_princess_iron_fan_death.update
tt.main_script.remove = nil
tt.modifier.duration = 1e+99
tt.minimum_y_offset = 70
tt.render.sprites[1].prefix = "boss_princess_iron_fan_vfx_stun_hero_loop_copy"
tt.render.sprites[3].name = "boss_princess_iron_fan_vfx_stun_hero_loop_shadow_0002"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.2,
		255
	}
}
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.2,
		255
	}
}
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		0.2,
		255
	}
}
tt.render.sprites[1].sort_y_offset = 1
tt.render.sprites[2].sort_y_offset = 1
tt.render.sprites[2].scale = vv(1.5)
tt = E:register_t_10086("fx_boss_princess_iron_fan_stun_heroes_flying", "fx")
tt.render.sprites[1].prefix = "boss_princess_iron_fan_vfx_stun_hero_dragon"
tt.render.sprites[1].name = "in_capture"
tt.render.sprites[1].anchor = v(0.5, 0.7076612903225806)
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].sort_y_offset = -6
tt.render.sprites[1].z = Z_FLYING_HEROES
tt = E:register_t_10086("fx_boss_princess_iron_fan_stun_heroes_ground", "fx")
tt.render.sprites[1].prefix = "boss_princess_iron_fan_vfx_stun_hero"
tt.render.sprites[1].name = "in_capture"
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].sort_y_offset = -6
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t_10086("fx_boss_princess_iron_fan_area_attack", "fx")
tt.render.sprites[1].name = "boss_princess_iron_fan_vfx_fx_area_attack"
tt = E:register_t_10086("fx_boss_princess_iron_fan_special_vfx", "fx")
tt.render.sprites[1].prefix = "boss_princess_vfxDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt = E:register_t_10086("boss_princess_iron_fan_tower_debuff", "modifier")
b = balance.enemies.wukong.boss_princess.waves.tower_curse

E:add_comps(tt, "render", "sound_events")

tt.main_script.insert = scripts.boss_princess_iron_fan_tower_debuff.insert
tt.main_script.update = scripts.boss_princess_iron_fan_tower_debuff.update
tt.main_script.remove = scripts.boss_princess_iron_fan_tower_debuff.remove
tt.modifier.duration = b.DURATION
tt.modifier.vis_flags = F_CUSTOM
tt.spawn_every = b.spawn_every
tt.spawn_formations = b.spawn_formations
tt.quantity_formations_spawns = b.quantity_formations_spawns
tt.spawn_offset = v(0, 35)
tt.spawn_forced_waypoint_offset = v(0, 0)
tt.render.sid_fachada = 1
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "boss_princess_iron_fan_vfx_torre_fachada"
tt.render.sprites[1].name = "tower_in"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].sort_y_offset = -5
tt.render.sid_floor = 2
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "boss_princess_iron_fan_vfx_torre_floor"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_DECALS
tt.render.sid_door = 3
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "boss_princess_iron_fan_vfx_torre_door"
tt.render.sprites[3].name = "idle_door_on"
tt.render.sprites[3].hidden = true
tt.render.sprites[3].draw_order = 2
tt.render.sprites[3].sort_y_offset = -5
tt.render.sid_spawn_fx = 4
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "boss_princess_iron_fan_vfx_torre_fx_externos_delante"
tt.render.sprites[4].name = "run"
tt.render.sprites[4].hidden = false
tt.render.sprites[4].scale = vv(1.6666666666666667)
tt.render.sprites[4].draw_order = 3
tt.render.sprites[4].sort_y_offset = -10
tt.offset_y_per_tower = {
	hermit_toad = 4
}
tt.sound_events.insert = "EnemyBossPrincessMudTower"
tt = E:register_t_10086("boss_princess_iron_fan_tower_debuff_bossfight", "boss_princess_iron_fan_tower_debuff")
b = balance.enemies.wukong.boss_princess.bossfight.tower_curse
tt.spawn_every = b.spawn_every
tt.spawn_formations = b.spawn_formations
tt.quantity_formations_spawns = b.quantity_formations_spawns
tt = E:register_t_10086("bullet_boss_princess_iron_fan", "bullet")
b = balance.enemies.wukong.boss_princess.bossfight.ranged_area_attack
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.radius
tt.bullet.ignore_hit_offset = true
tt.bullet.damage_bans = bor(F_ENEMY)
tt.bullet.pop = nil
tt.bullet.decal_fx = "fx_boss_princess_iron_fan_proyectile_hit_explosion"
tt.main_script.update = scripts.bullet_boss_princess_iron_fan.update
tt.render.sprites[1].name = "boss_princess_iron_fan_vfx_proyectile_run"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].loop = false
tt.bullet.hit_time = fts(25)
tt.ray_duration = fts(23)
tt.image_width = 200
tt.sound_events.insert = "EnemyBossPrincessRangedCast"
tt = E:register_t_10086("fx_boss_princess_iron_fan_proyectile_hit_explosion", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "boss_princess_iron_fan_vfx_projectile_explosion_run"
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "boss_princess_iron_fan_vfx_projectile_explosion_run"
tt.render.sprites[2].scale = vv(1.3)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].offset = v(27, -14)
tt.render.sprites[2].sort_y_offset = -10
tt.render.sprites[2].hidden = true
tt.render.sprites[2].delay_start = 0.15
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "boss_princess_iron_fan_vfx_projectile_explosion_run"
tt.render.sprites[3].scale = vv(1)
tt.render.sprites[3].z = Z_OBJECTS
tt.render.sprites[3].offset = v(-38, 20)
tt.render.sprites[3].hidden = true
tt.render.sprites[3].delay_start = 0.3
tt.sound_events.insert = "EnemyBossPrincessRangedImpact"
tt = E:register_t_10086("controller_hero_wukong_ultimate")
b = balance.heroes.hero_wukong.ultimate

E:add_comps(tt, "pos", "main_script", "sound_events")

tt.can_fire_fn = scripts.controller_hero_wukong_ultimate.can_fire_fn
tt.main_script.update = scripts.controller_hero_wukong_ultimate.update
tt.damage_radius = 80
tt.damage_times = {}

for i = 1, 10 do
	local damage_start_ts = fts(31)
	local damage_end_ts = damage_start_ts + fts(44)

	tt.damage_times[i] = damage_start_ts + (damage_end_ts - damage_start_ts) / 10 * (i - 1)
end

tt.damage = nil
tt.damage_type = b.damage_type
tt.damage_flags = bor(F_AREA)
tt.damage_bans = 0
tt.dragon_fx = "fx_hero_wukong_ultimate"
tt.dragon_fx_cracks = "fx_hero_wukong_ultimate_cracks"
tt.explosion_fx = "fx_hero_wukong_ultimate_explosion"
tt.sound_events.insert = "HeroSpiderGlobalCocoons"
tt.aura_slow = "aura_hero_wukong_ultimate_slow"

tt = E:register_t_10086("controller_hero_douzhanshengfo_ultimate","controller_hero_wukong_ultimate")
tt.damage_radius = 9999
tt.dragon_fx_cracks = "fx_hero_wukong_ultimate_cracks_2"
tt.explosion_fx = "fx_hero_wukong_ultimate_explosion_2"
tt.sound_events.insert = "HeroSpiderGlobalCocoons_2"
tt.aura_slow = "aura_hero_wukong_ultimate_slow_2"

tt = E:register_t_10086("controller_stage_35_redboy_powers", "decal_scripted")

E:add_comps(tt, "events")

tt.main_script.update = scripts.controller_stage_35_redboy_powers.update
tt.render.sprites[1].prefix = "redboy_stage5Def"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -85
tt.events.list[1].name = "samadhi_right"
tt.events.list[1].on_event = scripts.controller_stage_35_redboy_powers.on_samadhi_right
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "samadhi_left"
tt.events.list[2].on_event = scripts.controller_stage_35_redboy_powers.on_samadhi_left
tt.events.list[3] = E:clone_c("event")
tt.events.list[3].name = "portal_left"
tt.events.list[3].on_event = scripts.controller_stage_35_redboy_powers.on_portal_left
tt = E:register_t_10086("controller_stage_35_princess_powers", "decal_scripted")

E:add_comps(tt, "events")

b = balance.enemies.wukong.boss_princess
tt.main_script.update = scripts.controller_stage_35_princess_powers.update
tt.render.sid_unit = 1
tt.render.sprites[tt.render.sid_unit].prefix = "ironfan_stage5Def"
tt.render.sprites[tt.render.sid_unit].exo = true
tt.render.sprites[tt.render.sid_unit].flip_x = true
tt.render.sprites[tt.render.sid_unit].animated = true
tt.render.sprites[tt.render.sid_unit].anchor = v(0.5, 0.5)
tt.render.sprites[tt.render.sid_unit].name = "idle"
tt.render.sprites[tt.render.sid_unit].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_unit].sort_y_offset = -85
tt.block_tower_mod = "boss_princess_iron_fan_tower_debuff"
tt.stun_hero_decal = "decal_boss_princess_iron_fan_stun_heroes_waves"
tt.stun_hero_vis_flags = bor(F_MOD, F_STUN, F_AREA)
tt.stun_hero_vis_bans = bor(0)
tt.stun_hero = b.waves.stun_hero
tt.stun_hero_warning_duration = b.waves.stun_hero.WARNING_DURATION
tt.events.list[1].name = "block_tower"
tt.events.list[1].on_event = scripts.controller_stage_35_princess_powers.on_block_tower
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "stun_hero"
tt.events.list[2].on_event = scripts.controller_stage_35_princess_powers.on_stun_hero
tt.events.list[3] = E:clone_c("event")
tt.events.list[3].name = "portal_right"
tt.events.list[3].on_event = scripts.controller_stage_35_princess_powers.on_portal_right
tt = E:register_t_10086("controller_stage_35_portal_left", "decal_scripted")

E:add_comps(tt, "events")

tt.main_script.update = scripts.controller_stage_35_portal_door_bosses.update
tt.render.sprites[1].prefix = "stage_5_puerta_redboyDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.events.list[1].name = "portal_left"
tt.events.list[1].on_event = scripts.controller_stage_35_portal_door_bosses.on_portal_open
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "portal_left_close"
tt.events.list[2].on_event = scripts.controller_stage_35_portal_door_bosses.on_portal_close
tt = E:register_t_10086("controller_stage_35_portal_right", "controller_stage_35_portal_left")
tt.render.sprites[1].prefix = "stage_5_puerta_princessDef"
tt.render.sprites[1].flip_x = true
tt.events.list[1].name = "portal_right"
tt.events.list[2].name = "portal_right_close"
tt.sound_open = "Stage35PortalWater"
tt = E:register_t_10086("controller_stage_35_lava_splash", "controller_stage_32_lava_splash")
tt.main_script.update = scripts.controller_stage_35_lava_splash.update
tt.apply_if_enemy_is_to_right = false
tt.mod = "mod_stage_35_lava_splash"
tt.paths_x = {
	[15] = 0,
	[7] = 0
}
tt = E:register_t_10086("controller_stage_35_water_splash", "controller_stage_35_lava_splash")
tt.apply_if_enemy_is_to_right = true
tt.mod = "mod_stage_35_water_splash"
tt.paths_x = {
	[8] = 1025
}
tt = E:register_t_10086("controller_stage_35_small_spawner", "decal_scripted")

E:add_comps(tt, "events", "editor")

tt.unit_spawned = scripts.controller_stage_35_small_spawner.unit_spawned
tt.main_script.update = scripts.controller_stage_35_small_spawner.update
tt.render.sprites[1].name = "stage35_spawner_base"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "stage35_spawner_puerta"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = -23
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "stage_5_spawnerDef"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].exo = true
tt.render.sprites[3].animated = true
tt.render.sprites[3].hidden = true
tt.render.sprites[3].z = Z_OBJECTS
tt.render.sprites[3].sort_y_offset = -23
tt.spawner_nmbr = 0
tt.events.list[1].name = "spawner_open"
tt.events.list[1].on_event = scripts.controller_stage_35_small_spawner.on_portal_open
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "spawner_close"
tt.events.list[2].on_event = scripts.controller_stage_35_small_spawner.on_portal_close
tt.sound_open = "Stage35Spawners"
tt = E:register_t_10086("controller_stage_35_bull_king", "decal_scripted")

E:add_comps(tt, "events", "editor")

tt.main_script.update = scripts.controller_stage_35_bull_king.update
tt.render.sprites[1].prefix = "stage_35_boss_bull_1Def"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 205
tt.events.list[1].name = "samadhi_right"
tt.events.list[1].on_event = scripts.controller_stage_35_bull_king.on_samadhi_right
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "samadhi_left"
tt.events.list[2].on_event = scripts.controller_stage_35_bull_king.on_samadhi_left
tt.events.list[3] = E:clone_c("event")
tt.events.list[3].name = "stun_hero"
tt.events.list[3].on_event = scripts.controller_stage_35_bull_king.on_stun_hero
tt.events.list[4] = E:clone_c("event")
tt.events.list[4].name = "golden_beast_right"
tt.events.list[4].on_event = scripts.controller_stage_35_bull_king.on_golden_eyed
tt.events.list[5] = E:clone_c("event")
tt.events.list[5].name = "golden_beast_left"
tt.events.list[5].on_event = scripts.controller_stage_35_bull_king.on_golden_eyed
tt.events.list[6] = E:clone_c("event")
tt.events.list[6].name = "portal_left"
tt.events.list[6].on_event = scripts.controller_stage_35_bull_king.on_portal_left
tt.events.list[7] = E:clone_c("event")
tt.events.list[7].name = "portal_right"
tt.events.list[7].on_event = scripts.controller_stage_35_bull_king.on_portal_right
tt = E:register_t_10086("controller_stage_35_golden_eyed_left", "decal_scripted")

E:add_comps(tt, "events")

tt.main_script.update = scripts.controller_stage_35_golden_beast.update
tt.render.sprites[1].prefix = "spawner_golden_beastDef"
tt.render.sprites[1].name = "loop_leon"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.events.list[1].name = "golden_beast_left"
tt.events.list[1].on_event = scripts.controller_stage_35_golden_beast.on_golden_eyed
tt.path_id = 5
tt.empty_wait = 2
tt.golden_eyed_entity = "enemy_golden_eyed"
tt.summon_sound = "EnemyGoldenEyedSummon"
tt = E:register_t_10086("controller_stage_35_golden_eyed_right", "controller_stage_35_golden_eyed_left")
tt.render.sprites[1].prefix = "spawner_golden_beastDef"
tt.events.list[1].name = "golden_beast_right"
tt.path_id = 6
tt = E:register_t_10086("boss_bull_king", "boss")
b = balance.enemies.wukong.boss_bull_king

E:add_comps(tt, "melee", "timed_attacks")

tt.enemy.lives_cost = 999
tt.enemy.melee_slot = v(80, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health.dead_lifetime = 1e+99
tt.health_bar.offset = v(0, 127)
tt.unit.hit_offset = v(-5, 30)
tt.unit.head_offset = v(-2, 67)
tt.unit.mod_offset = v(-5, 30)
tt.unit.show_blood_pool = false
tt.ui.click_rect = r(-45, 0, 90, 90)
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.blood_color = BLOOD_RED
tt.motion.max_speed = b.speed
tt.info.i18n_key = "ENEMY_BOSS_BULL_KING"
tt.info.enc_icon = 119
tt.info.portrait = "gui_bottom_info_image_enemies_0124"
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.portrait_boss = "boss_health_bar_icon_0013"
tt.render.sid_unit = 1
tt.render.sprites[tt.render.sid_unit].prefix = "stage_35_boss_bull_2Def"
tt.render.sprites[tt.render.sid_unit].name = "idle"
tt.render.sprites[tt.render.sid_unit].exo = true
tt.render.sprites[tt.render.sid_unit].animated = true
tt.render.sprites[tt.render.sid_unit].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_unit].angles = {}
tt.render.sprites[tt.render.sid_unit].angles.walk = {
	"walk",
	"walk",
	"walk"
}
tt.unit.show_blood_pool = false
tt.spawn_pos = b.spawn_pos
tt.spawn_fx = "fx_boss_bull_king_spawn"
tt.second_manual_wave_pos = b.second_manual_wave_pos
tt.main_script.insert = scripts.boss_bull_king.insert
tt.main_script.update = scripts.boss_bull_king.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "attack_melee"
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[1].hit_fx = "fx_boss_bull_king_hit"
tt.melee.attacks[1].hit_fx_offset = v(80, 10)
tt.melee.attacks[1].sound_hit = "Stage35BossBullKingMeleeVar1"
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].cooldown = b.melee_area_attack.cooldown
tt.melee.attacks[2].damage_max = b.melee_area_attack.damage_max
tt.melee.attacks[2].damage_min = b.melee_area_attack.damage_min
tt.melee.attacks[2].damage_type = b.melee_area_attack.damage_type
tt.melee.attacks[2].damage_radius = b.melee_area_attack.damage_radius
tt.melee.attacks[2].animation = "attack_melee_area"
tt.melee.attacks[2].hit_time = fts(35)
tt.melee.attacks[2].hit_fx = "fx_boss_bull_king_hit_area"
tt.melee.attacks[2].hit_fx_offset = v(50, 0)
tt.melee.attacks[2].hit_offset = v(50, 0)
tt.melee.attacks[2].sound_hit = "Stage35BossBullKingMeleeArea"
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation_in = "skill_area_kill_in"
tt.timed_attacks.list[1].animation_loop = "skill_area_kill_loop"
tt.timed_attacks.list[1].animation_end = "skill_area_kill_out"
tt.timed_attacks.list[1].loops_amount = 3
tt.timed_attacks.list[1].dome_fx = "fx_boss_bull_king_domo"
tt.timed_attacks.list[1].anime_fx = "fx_boss_bull_king_anime"
tt.timed_attacks.list[1].anime_fx_back_black = "fx_boss_bull_king_anime_black"
tt.timed_attacks.list[1].anime_fx_back_white = "fx_boss_bull_king_anime_white"
tt.timed_attacks.list[1].first_cooldown = b.area_attack.first_cooldown
tt.timed_attacks.list[1].cooldown = b.area_attack.cooldown
tt.timed_attacks.list[1].damage_type = b.area_attack.damage_type
tt.timed_attacks.list[1].damage_max = b.area_attack.damage_max
tt.timed_attacks.list[1].damage_min = b.area_attack.damage_min
tt.timed_attacks.list[1].damage_radius = b.area_attack.damage_radius
tt.timed_attacks.list[1].nodes_limit = b.area_attack.nodes_limit
tt.timed_attacks.list[1].mod_tower_debuff = "mod_bull_king_tower_debuff"
tt.timed_attacks.list[1].max_towers_block = b.area_attack.max_towers_block
tt.timed_attacks.list[1].max_range = b.area_attack.max_range_towers_block
tt.timed_attacks.list[1].min_range = b.area_attack.min_range_towers_block
tt.timed_attacks.list[1].mod_stun = "mod_bull_king_stun"
tt.timed_attacks.list[1].vis_flags = bor(F_AREA)
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].vis_flags_stun = bor(F_AREA)
tt.timed_attacks.list[1].vis_bans_stun = bor(F_FLYING)
tt.sound_death = "Stage35BossBullKingDeath"
tt = E:register_t_10086("mod_bull_king_tower_debuff", "mod_hide_tower")
b = balance.enemies.wukong.boss_bull_king.area_attack

E:add_comps(tt, "render")

tt.main_script.update = scripts.mod_bull_king_tower_debuff.update
tt.main_script.remove = nil
tt.modifier.duration = b.stun_tower_duration
tt.modifier.vis_flags = F_CUSTOM
tt.modifier.handle_stun = true
tt.render.sprites[1].prefix = "stage_35_stun_towerDef"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset.y = 5
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt.offset_y_per_tower = {
	hermit_toad = 4
}
tt = RT("mod_bull_king_stun", "mod_stun")
b = balance.enemies.wukong.boss_bull_king.area_attack

E:add_comps(tt, "render")

tt.modifier.duration = b.stun_duration
tt.main_script.insert = scripts.mod_bull_king_stun.insert
tt.main_script.remove = scripts.mod_bull_king_stun.remove
tt.render.sprites[1].prefix = "stage_35_stun_unitDef"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt.modifier.animation_phases = true
tt.modifier.hide_target_delay = fts(3)
tt.modifier.use_mod_offset = false
tt = E:register_t_10086("fx_boss_bull_king_spawn", "decal_scripted")
tt.main_script.update = scripts.fx_boss_bull_king_spawn.update
tt.render.sprites[1].prefix = "stage_35_stun_towerDef"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -20
tt = E:register_t_10086("fx_boss_bull_king_hit", "fx")
tt.render.sprites[1].prefix = "stage_35_hitDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = vv(2)
tt = E:register_t_10086("fx_boss_bull_king_hit_area", "fx")
tt.render.sprites[1].prefix = "stage_35_areaattackDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_DECALS
tt = E:register_t_10086("fx_boss_bull_king_domo", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "stage_35_domoDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[1].hidden = true
tt.render.sprites[1].delay_start = fts(11)
tt = E:register_t_10086("fx_boss_bull_king_anime", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "stage_35_fx_animeDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[1].hidden = true
tt.render.sprites[1].delay_start = 1
tt = E:register_t_10086("fx_boss_bull_king_anime_white", "decal_scripted")
tt.main_script.update = scripts.fx_boss_bull_king_anime_color.update
tt.render.sprites[1].name = "stage_35_box_asst_box1"
tt.render.sprites[1].scale = vv(200)
tt.render.sprites[1].z = Z_OBJECTS_SKY - 1
tt.render.sprites[1].sort_y_offset = 10
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.delay_start = 1.15
tt = E:register_t_10086("fx_boss_bull_king_anime_black", "fx_boss_bull_king_anime_white")
tt.render.sprites[1].name = "stage_35_box_asst_box2"
tt.delay_start = 1.05
tt = E:register_t_10086("fx_boss_bull_king_explosion", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "stage_35_explosion_pathDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 20
tt = E:register_t_10086("controller_stage_35", "decal_scripted")

E:add_comps(tt, "editor", "ui", "events")

tt.main_script.update = scripts.controller_stage_35.update
tt.render.sprites[1].prefix = "stage_5_cinematicaDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_SCREEN_FIXED
tt.render.sprites[1].pos = v(0, 0)
tt.events.list[1].name = "barrage"
tt.events.list[1].on_event = scripts.controller_stage_35.on_event
tt.fixed_screen_offset = v(40, 40)
tt = E:register_t_10086("debug_draw_ability_area", "decal_scripted")
tt.main_script.update = scripts.debug_draw_ability_area.update
tt.check_function = nil
tt.check_every = 0.1
tt.radius_check = 300
tt.show_red = false
tt.sprites_x = math.ceil(REF_W / 10)
tt.sprites_y = math.ceil(REF_H / 5)
tt.sprite_size = v(REF_W / tt.sprites_x, REF_H / tt.sprites_y)

for xx = 1, tt.sprites_x do
	for yy = 1, tt.sprites_y do
		local index_x = xx
		local index_y = (yy - 1) * tt.sprites_x
		local sprite_i = index_x + index_y
		local pos = v(xx * tt.sprite_size.x, yy * tt.sprite_size.y)

		tt.render.sprites[sprite_i] = E:clone_c("sprite")
		tt.render.sprites[sprite_i].pos = pos
		tt.render.sprites[sprite_i].scale = vv(0.5)
		tt.render.sprites[sprite_i].animated = false
		tt.render.sprites[sprite_i].z = Z_DECALS
		tt.render.sprites[sprite_i].name = "decal_blood_0001"
	end
end

tt = E:register_t_10086("delayed_function_call")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.delayed_function_call.update
tt.delay = 0
tt.fn = nil
tt = E:register_t_10086("TEST_CROSS_PARENT", "decal")

E:add_comps(tt, "tween")

tt.render.sprites[1].name = "zz_test_attach_asst_bg"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.x = 0.25
tt.render.sprites[1].anchor.y = 0.25
tt.tween.props[1].name = "r"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		2,
		1
	},
	{
		4,
		0
	}
}
tt.tween.props[1].disabled = false
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		vv(1)
	},
	{
		2,
		v(1.5, 2)
	},
	{
		4,
		vv(1)
	}
}
tt.tween.remove = false
tt.tween.props[1].loop = true
tt.tween.props[2].loop = true
tt = E:register_t_10086("TEST_CROSS_CHILD", "decal")
tt.render.sprites[1].name = "zz_test_attach_asst_bg"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.x = 0.25
tt.render.sprites[1].anchor.y = 0.25
tt.render.sprites[1].track_sprite_id = 1
tt = E:register_t_10086("TEST_ATTACH_ROOT", "decal")
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "zz_test_attach"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt = E:register_t_10086("TEST_ATTACH_CHILD2", "decal")
tt.render.sprites[1].name = "zz_test_attach_asst_bg"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.x = 0.25
tt.render.sprites[1].anchor.y = 0.25
tt.render.sprites[1].track_sprite_id = 1
tt.render.sprites[1].track_attach_point = "obj"
tt = E:register_t_10086("TEST_ATTACH_CHILD3", "decal")
tt.render.sprites[1].prefix = "zz_test_attach"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].track_sprite_id = 1
tt.render.sprites[1].track_attach_point = "obj"
tt = E:register_t_10086("TEST_ATTACH_PARTICLES")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "zz_test_attach_asst_point"
tt.particle_system.animated = false
tt.particle_system.loop = false
tt.particle_system.emission_rate = 5
tt.particle_system.emit_direction = math.pi / 2
tt.particle_system.emit_rotation = 0
tt.particle_system.emit_speed = {
	100,
	120
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emit_offset = v(0, 0)
tt.particle_system.z = Z_OBJECTS
tt.particle_system.particle_lifetime = {
	4,
	4
}
tt.particle_system.sort_y_offset = 0
tt.particle_system.scales_x = {
	1,
	3
}
tt.particle_system.scales_y = {
	1,
	3
}
tt.particle_system.alphas = {
	255,
	100
}
tt.particle_system.track_sprite_id = 1
tt.particle_system.track_attach_point = "obj"
tt.particle_system.track_direction = true
tt = E:register_t_10086("TEST_ARROW", "decal")
tt.render.sprites[1].name = "hero_vesper_arrow_to_the_knee_arrow"
tt.render.sprites[1].animated = false
tt = E:register_t_10086("stage_33_spawner")

E:add_comps(tt, "main_script", "spawner")

tt.main_script.update = scripts.stage_33_spawner.update
tt.spawn_data = nil
tt.spawner.eternal = true

tt = E:register_t("hero_wukong_2", "hero_wukong")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_douzhanshengfo_2", "hero_douzhanshengfo")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end