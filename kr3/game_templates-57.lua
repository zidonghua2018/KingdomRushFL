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
local scripts = require("game_scripts-57")

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
package.loaded["data.balance.balance"] = nil

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

tt = RT("ps_bullet_soldier_dragon_warden_dragon_raider_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "warden_warlock_stage3_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 20
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	fts(9),
	fts(9)
}
tt = RT("ps_bullet_tower_stage_37_dragons_wardens_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "warden_warlock_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 20
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	fts(9),
	fts(9)
}
tt = RT("ps_bullet_enemy_basic_acid")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "acid_basic_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.emission_rate = 30
tt.particle_system.emit_area_spread = v(0, 0)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt = RT("ps_bullet_enemy_evolved_acid")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "evolved_acid_trail2_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.emission_rate = 30
tt.particle_system.emit_area_spread = v(0, 0)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt = RT("ps_bullet_enemy_alfa_acid")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "alpha_acid_trail2_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.emission_rate = 30
tt.particle_system.emit_area_spread = v(0, 0)
tt.particle_system.emit_rotation_spread = math.pi * 2
tt = RT("ps_bullet_enemy_evolved_acid_stun_tower")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "storm_evolve_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(12),
	fts(12)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emission_rate = 30
tt = RT("ps_bullet_alfa_lava_vomit")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "lava_alpha_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(16),
	fts(16)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emission_rate = 15
tt = RT("ps_enemy_basic_shadow_trail_dark")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "shadow_basic_shadow_trail_dark"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(14),
	fts(14)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emission_rate = 5
tt.particle_system.emit_offset = v(0, 10)
tt = RT("ps_enemy_basic_shadow_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "shadow_basic_shadow_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(14),
	fts(14)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emission_rate = 8
tt.particle_system.emit_offset = v(0, 10)
tt = RT("ps_enemy_evolved_shadow_trail_dark")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "shadow_evo_shadow_trail_2_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(18),
	fts(18)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emission_rate = 3
tt.particle_system.emit_offset = v(0, 0)
tt = RT("ps_enemy_evolved_shadow_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "shadow_evo_shadow_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(14),
	fts(14)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emission_rate = 3
tt.particle_system.emit_offset = v(0, 0)
tt = RT("ps_enemy_evolved_shadow_bullet_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "shadow_evo_projectile_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(9),
	fts(9)
}
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.emission_rate = 20
tt = RT("ps_enemy_alfa_shadow_teleport_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "shadow_alpha_teleport_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(8)
}
tt.particle_system.anchor = v(0.5, 0.25)
tt.particle_system.emission_rate = 10
tt.particle_system.z = Z_OBJECTS
tt = RT("ps_bullet_tower_dragons_dragon_split_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "dlc_dragons_tower_trail_skill_shoot_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 30
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	fts(17),
	fts(17)
}
tt = RT("ps_bullet_hero_dragon_sun_solar_stone")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "hero_aurion_projectile_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 10
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt = RT("ps_decal_boss_40_waves_stun_towers")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "vfx_dragon_projectile_stun_trail_run"
tt.particle_system.animated = true
tt.particle_system.anchor = v(0.4353932584269663, 0.5)
tt.particle_system.loop = false
tt.particle_system.emission_rate = 22
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	fts(14),
	fts(14)
}
tt = RT("fx_bullet_tower_dragons_wardens_hit", "fx")
tt.render.sprites[1].name = "warden_warlock_hit_run"
tt = RT("fx_bullet_soldier_dragon_warden_dragon_raider_hit", "fx")
tt.render.sprites[1].name = "warden_warlock_stage3_hit_run"
tt = RT("fx_warden_warrior_hit", "fx")
tt.render.sprites[1].name = "warden_warrior_hit_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -16
tt = RT("fx_tower_dragons_evolve_lvl1", "fx")
tt.render.sprites[1].name = "dlc_dragons_tower_evolve_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -30
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt = RT("fx_tower_dragons_respiracion_lvl1", "fx")
tt.render.sprites[1].name = "dlc_dragons_tower_respiracion_lvl1_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -30
tt.render.sprites[1].offset = v(0, 10)
tt = RT("fx_tower_dragons_respiracion_lvl2", "fx_tower_dragons_respiracion_lvl1")
tt.render.sprites[1].name = "dlc_dragons_tower_respiracion_lvl2_run"
tt = RT("fx_tower_dragons_respiracion_lvl3", "fx_tower_dragons_respiracion_lvl1")
tt.render.sprites[1].name = "dlc_dragons_tower_respiracion_lvl3_run"
tt = RT("fx_tower_dragons_respiracion_lvl4", "fx_tower_dragons_respiracion_lvl1")
tt.render.sprites[1].name = "dlc_dragons_tower_respiracion_lvl4_run"
tt = RT("fx_tower_dragons_respiracion_lvl4_fuego", "fx_tower_dragons_respiracion_lvl4")
tt.render.sprites[1].name = "dlc_dragons_tower_respiracion_lvl4_fuego_run"
tt.render.sprites[1].offset = v(-3, 10)
tt = RT("fx_bullet_tower_dragons_dragon_split_hit", "fx")
tt.render.sprites[1].name = "dlc_dragons_tower_hit_skill_shoot_voladores_run"
tt = RT("decal_bullet_tower_dragons_dragon_split", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.render.sprites[1].name = "dlc_dragons_tower_decal_projectile_run"
tt.render.sprites[1].anchor = v(0.5, 0.5277777777777778)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt.sound_events.insert = "TowerDragonsSpitImpact"
tt = RT("fx_enemy_basic_acid_melee_hit", "fx")
tt.render.sprites[1].name = "noxious_horror_hit_fx_idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt = RT("fx_enemy_evolved_acid_hit", "fx")
tt.render.sprites[1].name = "evolved_acid_hit_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt = RT("fx_bullet_enemy_alfa_acid_evolve_hit", "fx")
tt.render.sprites[1].name = "alpha_acid_sheep_idle"
tt.render.sprites[1].anchor = v(0.5056818181818182, 0.5988372093023255)
tt = RT("fx_enemy_tanky_draconian_hit", "fx")
tt.render.sprites[1].name = "lava_tanky_hit_run"
tt = RT("fx_enemy_evolved_lava_melee_hit", "fx")
tt.render.sprites[1].name = "lava_evolve_hit_run"
tt = RT("fx_enemy_evolved_lava_firebreath", "fx")
tt.render.sprites[1].name = "lava_evolve_fuego_firebreath_run"
tt.render.sprites[1].anchor = v(0.5, 0.6)
tt = RT("fx_enemy_evolved_lava_landing_hit", "fx")

E:add_comps(tt, "sound_events")

tt.render.sprites[1].name = "lava_evolve_engage_hit_run"
tt.sound_events.insert = "EnemyLavaEvolverSkyfall"
tt = RT("fx_enemy_evolved_storm_attack", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].prefix = "storm_evolve_electric_fx_area"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "storm_evolve_decal_area"
tt.render.sprites[2].animated = false
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_DECALS
tt.tween.remove = true
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(3),
		0
	},
	{
		fts(4),
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
tt.tween.props[1].sprite_id = 2
tt = RT("fx_bullet_enemy_alfa_storm", "fx")
tt.render.sprites[1].name = "alpha_storm_hit_run"
tt = RT("fx_enemy_evolved_shadow_burst", "fx")
tt.render.sprites[1].name = "shadow_evo_shadowmode_burst_run"
tt.render.sprites[1].offset = v(0, 10)
tt = RT("fx_enemy_evolved_shadow_bullet_hit", "fx")
tt.render.sprites[1].name = "shadow_evo_hit"
tt = RT("fx_enemy_alfa_storm_evolve_ray", "fx")
tt.render.sprites[1].name = "alpha_storm_ray_stun_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 50
tt = RT("fx_enemy_alfa_shadow_hit_melee", "fx")
tt.render.sprites[1].name = "shadow_alpha_hit_mele_run"
tt = RT("fx_enemy_alfa_shadow_teleport_in", "fx")
tt.render.sprites[1].name = "shadow_alpha_creep_teleport_in"
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("fx_boss_murglum_geiser_lava", "fx")
tt.render.sprites[1].name = "boss_murglun_geiser_lava"
tt.render.sprites[1].loop = false
tt = RT("fx_boss_murglun_area_attack", "fx")
tt.render.sprites[1].name = "boss_murglun_area_attack_run"
tt.render.sprites[1].scale = vv(2)
tt = RT("fx_boss_stage_40_breath_ray", "decal_scripted")
tt.main_script.update = scripts.fx_boss_stage_40_breath_ray.update
tt.render.sprites[1].prefix = "export_rayo_rayo"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].r = math.rad(-40)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -130
tt = RT("fx_stage_40_boss_tower_block_insert", "fx")
tt.render.sprites[1].name = "vfx_dragon_fire_particles_run"
tt.render.sprites[1].scale = vv(2)
tt = RT("fx_stage_40_boss_get_damaged", "fx")
tt.render.sprites[1].name = "vfx_dragon_hit_damage_dragon_run"
tt.render.sprites[1].hidden = true
tt = RT("fx_stage_40_boss_scar", "fx")
tt.render.sprites[1].prefix = "stage_40_splashDef"
tt.render.sprites[1].name = "splash_0"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = false
tt = RT("fx_hero_dragon_sun_solar_stones_mine_spawn", "fx")
tt.render.sprites[1].name = "hero_aurion_projectile_smoke_run"
tt.render.sprites[1].anchor = v(0.4453125, 0.5964912280701754)
tt.render.sprites[1].alpha = 128
tt = RT("fx_hero_dragon_sun_solar_stones_mine_explosion", "fx")
tt.render.sprites[1].name = "hero_aurion_explosion_skil_solar_stone__in"
tt = RT("fx_hero_dragon_sun_overcharge_mask", "fx")
tt.render.sprites[1].name = "hero_aurion_mask_overcharge_in"
tt = RT("fx_hero_dragon_sun_ultimate_in", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "hero_aurion_ulti_in_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_EFFECTS + 1
tt.render.sprites[1].delay_start = fts(13)
tt.render.sprites[1].hidden = true
tt = RT("fx_hero_dragon_sun_basic_ray_back_fire", "fx")
tt.render.sprites[1].name = "hero_aurion_fire_breath_hit_run"
tt.render.sprites[1].scale = vv(1)
tt = RT("fx_hero_dragon_sun_ultimate_back_fire", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "hero_aurion_fire_breath_hit_run"
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].loop = false
tt.render.sprites[1].delay_start = fts(0)
tt.render.sprites[1].hidden = true
tt = RT("fx_hero_dragon_sun_teleport_decal_target", "fx")
tt.render.sprites[1].name = "hero_aurion_decal_target_teleport_full"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor = vv(0.5)
tt = RT("fx_hero_dragon_sun_teleport_explotion", "fx")
tt.render.sprites[1].name = "hero_aurion_explosion_run"
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_EFFECTS + 1
tt = RT("fx_hero_dragon_sun_teleport_explotion_decal", "decal_tween")
tt.render.sprites[1].name = "hero_aurion_decal_teleport_in"
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].scale = vv(2)
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
tt.tween.disabled = false
tt = RT("fx_hero_dragon_sun_teleport_explotion_fire", "fx")
tt.render.sprites[1].name = "hero_aurion_fire_breath_hit_run"
tt.render.sprites[1].scale = vv(2)
tt = RT("fx_hero_dragon_sun_heal_particle", "fx")
tt.render.sprites[1].name = "hero_aurion_helth_run"
tt = RT("fx_stage_36_path_dust", "fx")
tt.render.sprites[1].prefix = "stage36_efecto_polvo"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].offset = v(0, -10)
tt = RT("fx_decal_stage_37_tall_tower_spawn", "fx")
tt.render.sprites[1].name = "stage_37_anim_props_dragon_eyes_spawn_in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt = RT("fx_boss_stage_37_tower_out", "fx")
tt.render.sprites[1].name = "boss_murglun_efecto_tower_out_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_EFFECTS
tt = RT("fx_spyro_smoke", "fx")
tt.render.sprites[1].name = "spyro_me_fx_humo_run"
tt.render.sprites[1].offset = v(0, -10)
tt = RT("fx_ender_egg_explosion_normal", "fx")
tt.render.sprites[1].name = "ender_egg_particle_drop_run"
tt.render.sprites[1].offset = v(0, 5)
tt = RT("fx_ender_egg_explosion_final", "fx")
tt.render.sprites[1].name = "ender_egg_particle_explosion_run"
tt.render.sprites[1].offset = v(0, 10)
tt = RT("fx_soldier_dragon_warden_dragon_raider_mounted_death", "fx")
tt.render.sprites[1].name = "warden_warlock_stage3_dragon_rider_death_rider"
tt = RT("fx_stage_40_warden_spawn_magic", "fx")
tt.render.sprites[1].prefix = "canon_vfxDef"
tt.render.sprites[1].name = "spawn_in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt = RT("fx_bullet_enemy_basic_acid", "fx")
tt.render.sprites[1].name = "acid_basic_hit_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt = RT("fx_bullet_enemy_alfa_acid", "fx")
tt.render.sprites[1].name = "alpha_acid_hit_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt = RT("fx_stage_36_portal_splash", "fx")
tt.render.sprites[1].prefix = "portal_efecto_salida"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].sort_y_offset = -40
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor = v(0.47, 0.51)
tt = RT("fx_miniboss_stage_39_hit", "fx")
tt.render.sprites[1].prefix = "mini_boss_hit"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt = RT("fx_stage_40_moving_island_explosion_dirt", "fx")
tt.render.sprites[1].prefix = "animations_landmine_explotionDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].scale = vv(3)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 0
tt = RT("fx_canon_dragon_shot_fail", "fx")
tt.render.sprites[1].prefix = "fail_shotDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].scale = vv(1)
tt = RT("decal_bullet_hero_dragon_sun_breath_ray", "decal_tween")
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.3,
		255
	},
	{
		1.3,
		0
	}
}
tt.render.sprites[1].name = "hero_aurion_fire_breath_decal_run"
tt.render.sprites[1].animated = true
tt = RT("decal_bullet_hero_dragon_sun_ultimate_base", "fx")
tt.render.sprites[1].name = "hero_aurion_decal_ulti_base_in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_bullet_hero_dragon_sun_ultimate", "decal_tween")
tt.tween.props[1].keys = {
	{
		0,
		155
	},
	{
		2,
		155
	},
	{
		3.5,
		0
	}
}
tt.render.sprites[1].name = "hero_aurion_decal_ulti_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_bullet_hero_dragon_sun_ultimate_2", "decal_tween")
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1.25,
		255
	},
	{
		2.25,
		0
	}
}
tt.render.sprites[1].name = "hero_aurion_decal_teleport_in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_DECALS + 1
tt = RT("decal_enemy_alfa_lava_dot", "decal_scripted")
b = balance.enemies.dragons.alfa_lava.lava_vomit_attack

E:add_comps(tt, "auras")

tt.main_script.insert = scripts.decal_enemy_alfa_lava_dot.insert
tt.main_script.update = scripts.decal_enemy_alfa_lava_dot.update
tt.picked = scripts.decal_enemy_alfa_lava_dot.on_picked
tt.in_anim = "in"
tt.loop_anim = "loop"
tt.end_anim = "death"
tt.picked_anim = "out"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].prefix = "lava_alpha_decal"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].sort_y_offset = -5
tt.duration = b.lava_duration
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_enemy_alfa_lava_dot"
tt.auras.list[1].cooldown = 0
tt = RT("decal_enemy_evolved_acid_bullet", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "evolved_acid_area_splash"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "evolved_acid_decal_area_splash"
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_DECALS
tt.dont_hide = {
	[2] = true
}
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1.5,
		255
	},
	{
		2,
		0
	}
}
tt.tween.props[1].sprite_id = 2
tt.tween.remove = true
tt = RT("decal_boss_murglum_bolt", "decal_tween")
tt.render.sprites[1].name = "boss_murglun_decals_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor = v(0.7461538461538462, 0.10849056603773585)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1.5,
		255
	},
	{
		2,
		0
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.remove = true
tt = RT("decal_boss_murglum_geiser_bossfight", "decal_scripted")
b = balance.enemies.dragons.dragon_boss_stage_37

E:add_comps(tt, "auras", "tween")

tt.main_script.insert = scripts.decal_boss_murglum_geiser.insert
tt.main_script.update = scripts.decal_boss_murglum_geiser.update
tt.render.sprites[1].prefix = "boss_murglun_fuego_piso"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].z = Z_DECALS - 1
tt.render.sprites[1].anchor = v(0.5, 0.5670731707317073)
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_boss_37_geiser_decal_dmg_bossfight"
tt.auras.list[1].cooldown = 0
tt.loop_anim = "loop"
tt.duration = b.geisers_bossfight.duration
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.1,
		255
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].loop = false
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		vv(0.7)
	},
	{
		0.1,
		vv(1)
	}
}
tt.tween.props[2].sprite_id = 1
tt.tween.props[2].loop = false
tt.tween.remove = false
tt = RT("decal_boss_murglum_geiser_waves_campaign", "decal_boss_murglum_geiser_bossfight")
b = balance.enemies.dragons.dragon_boss_stage_37
tt.auras.list[1].name = "aura_boss_37_geiser_decal_dmg_campaign"
tt.duration = b.campaign.area_attack_duration
tt = RT("decal_enemy_alfa_shadow_evolve", "decal_tween")
tt.render.sprites[1].name = "shadow_alpha_teleport_floor_run"
tt.render.sprites[1].loop = true
tt.tween.props[1].name = "alpha"
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
		2.5,
		255
	},
	{
		2.8,
		0
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.remove = true
tt = RT("decal_enemy_basic_shadow_evolve", "decal_enemy_alfa_shadow_evolve")
tt.render.sprites[1].offset = v(5, 5)
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
		3.8,
		255
	},
	{
		4.1,
		0
	}
}
tt = RT("decal_boss_murglum_death", "decal")
tt.render.sprites[1].name = "boss_murglun_death_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.5945945945945946, 0.14080459770114942)
tt.render.sprites[1].scale = vv(1)
tt = RT("fx_boss_stage_40_walk_fires", "decal_tween")
tt.render.sprites[1].name = "vfx_dragon_crack_fire_loop"
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].name = "alpha"
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
		2,
		255
	},
	{
		2.3,
		0
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.remove = true
tt.tween.disabled = false
tt = RT("fx_boss_stage_40_walk_thunders_explotion", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "vfx_dragon_explosion_ray_run"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "vfx_dragon_explosion_smoke_run"
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].delay_start = fts(0)
tt = RT("fx_boss_stage_40_walk_crack", "fx")
tt.render.sprites[1].name = "vfx_dragon_crack_run"
tt.render.sprites[1].z = Z_DECALS - 1
tt = RT("fx_boss_stage_40_walk_thunders_rays", "decal_scripted")
tt.main_script.update = scripts.fx_boss_stage_40_walk_thunders_rays.update
tt.render.sprites[1].name = "vfx_dragon_ray_1"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "vfx_dragon_ray_2"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].animated = false
tt.render.sprites[2].hidden = true
tt = RT("fx_boss_stage_40_walk_thunders", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.insert = scripts.fx_boss_stage_40_walk_thunders.insert
tt.main_script.update = scripts.fx_boss_stage_40_walk_thunders.update
tt.render.sprites[1].name = "vfx_dragon_ray_decal_Idle"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "vfx_dragon_ray_deco_idle"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].loop = true
tt.render.sprites[2].anchor = vv(0.5)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(5),
		255
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].disabled = true
tt.tween.disabled = false
tt.tween.remove = false
tt = RT("fx_boss_stage_40_breath_decal", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.insert = scripts.fx_boss_stage_40_breath_decal.insert
tt.main_script.update = scripts.fx_boss_stage_40_breath_decal.update
tt.render.sprites[1].name = "vfx_dragon_ray_decal_Idle"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "vfx_dragon_ray_deco_idle"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].loop = true
tt.render.sprites[2].anchor = vv(0.5)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(5),
		255
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].disabled = true
tt.tween.disabled = false
tt.tween.remove = false
tt.vis_flags = bor(F_INSTAKILL, F_RANGED, F_AREA)
tt.vis_bans = bor(F_ENEMY)
tt.ray_up = "fx_boss_stage_40_breath_ray_up"
tt = RT("fx_boss_stage_40_breath_ray_up", "fx")
tt.render.sprites[1].name = "vfx_dragon_ray_breath_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = v(1, 3)
tt.render.sprites[1].sort_y_offset = 5
tt = RT("decal_stage_40_boss_shadow_waves_warning", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.insert = scripts.decal_stage_40_boss_shadow_waves_warning.insert
tt.main_script.update = scripts.decal_stage_40_boss_shadow_waves_warning.update
tt.render.sprites[1].name = "vfx_dragon_ray_decal_Idle"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].offset = v(0, 13)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(5),
		255
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].disabled = true
tt.tween.disabled = false
tt.tween.remove = false
tt = RT("decal_stage_36_mask_path_main", "decal")
tt.render.sprites[1].name = "stage_36_mask_path"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = RT("decal_stage_36_mask_1", "decal")
tt.render.sprites[1].name = "stage_36_mask_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_OBJECTS_COVERS + 1
tt = RT("decal_stage_36_mask_portal", "decal")
tt.render.sprites[1].prefix = "stage_1_portalDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = 25
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_36_mask_islas", "decal_tween")

E:add_comps(tt, "main_script")

tt.main_script.insert = scripts.decal_stage_36_mask_islas.insert
tt.islas_levels = {
	TOP = Z_BACKGROUND_COVERS + 1,
	MID = Z_BACKGROUND_BETWEEN - 1,
	BACK = Z_BACKGROUND_BETWEEN - 2
}
tt.islas_settings = {
	{
		str = 6,
		z = "TOP",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120,
		skip = true
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = -6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	}
}
tt.temp_i = 0

for i = 1, #tt.islas_settings do
	if not tt.islas_settings[i].skip then
		tt.temp_i = tt.temp_i + 1

		local str = tt.islas_settings[i].str
		local freq = tt.islas_settings[i].freq
		local z = tt.islas_levels[tt.islas_settings[i].z]

		freq = freq + math.random(-20, 20)
		tt.render.sprites[tt.temp_i] = E:clone_c("sprite")
		tt.render.sprites[tt.temp_i].name = "stage_36_isla_" .. i
		tt.render.sprites[tt.temp_i].animated = false
		tt.render.sprites[tt.temp_i].z = z
		tt.tween.props[tt.temp_i] = E:clone_c("tween_prop")
		tt.tween.props[tt.temp_i].sprite_id = tt.temp_i
		tt.tween.props[tt.temp_i].name = "offset"
		tt.tween.props[tt.temp_i].interp = "sine"
		tt.tween.props[tt.temp_i].keys = {
			{
				fts(0),
				v(0, 0)
			},
			{
				fts(freq),
				v(0, -str)
			},
			{
				fts(freq * 2),
				v(0, 0)
			}
		}
		tt.tween.props[tt.temp_i].loop = true
	end
end

tt.temp_i = nil
tt.tween.remove = false
tt = RT("decal_stage_37_layer01", "decal")
tt.render.sprites[1].name = "stage_37_layer01"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt = RT("decal_stage_37_layer02", "decal")
tt.render.sprites[1].name = "stage_37_layer02"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN + 1
tt = RT("decal_stage_37_mask_01", "decal")
tt.render.sprites[1].name = "stage_37_mask_01"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 263
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_37_mask_02", "decal")
tt.render.sprites[1].name = "stage_37_mask_02"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 145
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_37_mask_03", "decal")
tt.render.sprites[1].name = "stage_37_mask_03"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 192
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_37_mask_04", "decal")
tt.render.sprites[1].name = "stage_37_mask_04"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 86
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_37_mask_05", "decal")
tt.render.sprites[1].name = "stage_37_mask_05"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -239
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_37_mask_islas", "decal_tween")

E:add_comps(tt, "main_script")

tt.main_script.insert = scripts.decal_stage_36_mask_islas.insert
tt.islas_levels = {
	TOP = Z_BACKGROUND_COVERS + 2,
	MID = Z_BACKGROUND_BETWEEN - 1,
	BACK = Z_BACKGROUND_BETWEEN - 2
}
tt.islas_settings = {
	{
		str = -6,
		z = "TOP",
		freq = 120
	},
	{
		str = -6,
		z = "TOP",
		freq = 120
	},
	{
		str = -6,
		z = "TOP",
		freq = 120
	},
	{
		str = -6,
		z = "TOP",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	}
}
tt.temp_i = 0

for i = 1, #tt.islas_settings do
	if not tt.islas_settings[i].skip then
		tt.temp_i = tt.temp_i + 1

		local str = tt.islas_settings[i].str
		local freq = tt.islas_settings[i].freq
		local z = tt.islas_levels[tt.islas_settings[i].z]

		freq = freq + math.random(-20, 20)
		tt.render.sprites[tt.temp_i] = E:clone_c("sprite")
		tt.render.sprites[tt.temp_i].name = "stage_02_islas_flotantes00" .. (i < 10 and "0" or "") .. i
		tt.render.sprites[tt.temp_i].animated = false
		tt.render.sprites[tt.temp_i].z = z
		tt.tween.props[tt.temp_i] = E:clone_c("tween_prop")
		tt.tween.props[tt.temp_i].sprite_id = tt.temp_i
		tt.tween.props[tt.temp_i].name = "offset"
		tt.tween.props[tt.temp_i].interp = "sine"
		tt.tween.props[tt.temp_i].keys = {
			{
				fts(0),
				v(0, 0)
			},
			{
				fts(freq),
				v(0, -str)
			},
			{
				fts(freq * 2),
				v(0, 0)
			}
		}
		tt.tween.props[tt.temp_i].loop = true
	end
end

tt.temp_i = nil
tt.tween.remove = false
tt = RT("decal_stage_37_tall_tower_mid", "decal_scripted")
tt.sid_back = 1
tt.sid_front = 2
tt.render.sprites[tt.sid_back].prefix = "destruccion_torres_stage_37_torre_2_back"
tt.render.sprites[tt.sid_back].name = "idle_sana"
tt.render.sprites[tt.sid_back].animated = true
tt.render.sprites[tt.sid_back].sort_y_offset = 0
tt.render.sprites[tt.sid_back].z = Z_OBJECTS
tt.render.sprites[tt.sid_back].group = "layers"
tt.render.sprites[tt.sid_front] = E:clone_c("sprite")
tt.render.sprites[tt.sid_front].prefix = "destruccion_torres_stage_37_torre_2_front"
tt.render.sprites[tt.sid_front].name = "idle_sana"
tt.render.sprites[tt.sid_front].animated = true
tt.render.sprites[tt.sid_front].sort_y_offset = 0
tt.render.sprites[tt.sid_front].z = Z_EFFECTS
tt.render.sprites[tt.sid_front].hidden = true
tt.render.sprites[tt.sid_front].group = "layers"
tt.render.sprites[tt.sid_front].scale = vv(2)
tt.spawn_fx = "fx_decal_stage_37_tall_tower_spawn"
tt.main_script.update = scripts.decal_stage_37_tall_tower.update
tt.spawn_anim = scripts.decal_stage_37_tall_tower.spawn_anim
tt.destroy = scripts.decal_stage_37_tall_tower.destroy
tt.destroy_warden_barrack = fts(16)
tt = RT("decal_stage_37_tall_tower_left", "decal_stage_37_tall_tower_mid")
tt.render.sprites[tt.sid_back].prefix = "destruccion_torres_stage_37_torre_3_back"
tt.render.sprites[tt.sid_back].name = "idle_sana"
tt.render.sprites[tt.sid_back].animated = true
tt.render.sprites[tt.sid_front].prefix = "destruccion_torres_stage_37_torre_3_front"
tt.render.sprites[tt.sid_front].name = "idle_sana"
tt.destroy_warden_barrack = fts(16)
tt = RT("decal_stage_37_tall_tower_right", "decal_stage_37_tall_tower_mid")
tt.render.sprites[tt.sid_back].name = "destruccion_torres_stage_37_torre_1_back_0001"
tt.render.sprites[tt.sid_back].animated = false
tt.render.sprites[tt.sid_front] = nil
tt.sid_front = nil
tt.destroy_warden_barrack = nil
tt = RT("decal_stage_37_bridge", "decal")
tt.render.sprites[1].prefix = "stage_37_anim_props_puente"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].sort_y_offset = 0
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.destroy = scripts.decal_stage_37_bridge.destroy
tt = RT("decal_stage_36_easter_egg_spyro", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.insert = scripts.decal_stage_36_easter_egg_spyro.insert
tt.main_script.update = scripts.decal_stage_36_easter_egg_spyro.update
tt.render.sprites[1].prefix = "spyro_me_creep"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN + 2
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "stage_36_isla_6_mask"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BACKGROUND_BETWEEN + 3
tt.render.sprites[2].pos = v(512, 384)
tt.fx = "fx_spyro_smoke"
tt.stay_island = {
	[1] = 5,
	[2] = 4
}
tt.ui.click_rect = r(-40, -20, 80, 80)
tt = RT("decal_stage_36_easter_egg_ranger_verde", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_36_easter_egg_ranger_verde.update
tt.render.sprites[1].prefix = "ranger_verde_character"
tt.render.sprites[1].name = "idle1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.ui.click_rect = r(-25, -10, 50, 50)
tt = RT("decal_stage_37_easter_daenerys", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_37_easter_daenerys.update
tt.render.sprites[1].prefix = "daenerys_easter_eggDef"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.ui.click_rect = r(-25, -10, 50, 50)
tt = RT("decal_stage_37_easter_egg_how_to_train_dragon", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_37_easter_egg_how_to_train_dragon.update
tt.render.sprites[1].prefix = "train_dragon_characters"
tt.render.sprites[1].name = "idle1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.ui.click_rect = r(-25, -20, 75, 40)
tt.spawn_entity = "soldier_dragon_warden_dragon_raider_mounted"
tt = RT("decal_stage_38_easter_egg_ender_egg", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.insert = scripts.decal_stage_38_easter_ender_egg.insert
tt.main_script.update = scripts.decal_stage_38_easter_ender_egg.update
tt.render.sprites[1].prefix = "ender_egg_egg"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "ender_egg_mask"
tt.render.sprites[2].animated = true
tt.render.sprites[2].ignore_start = true
tt.render.sprites[2].z = Z_OBJECTS_COVERS
tt.render.sprites[2].pos = v(811, 427)
tt.render.sprites[2].animated = false
tt.fx_normal = "fx_ender_egg_explosion_normal"
tt.fx_final = "fx_ender_egg_explosion_final"
tt.ui.click_rect = r(-20, -10, 40, 45)
tt.positions = {
	{
		v(621, 131),
		Z_OBJECTS
	},
	{
		v(558, 680),
		Z_OBJECTS
	},
	{
		v(1103, 603),
		Z_OBJECTS
	},
	{
		v(305, 282),
		Z_OBJECTS
	}
}
tt.last_position = {
	v(805, 554),
	Z_OBJECTS_COVERS
}
tt.gold_fx = "fx_elemental_metal_holder_coins"
tt.gold_amount = 150
tt = RT("decal_stage_39_easter_egg_sheepy", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_39_easter_egg_sheepy.update
tt.render.sprites[1].prefix = "dragon_sheepy"
tt.render.sprites[1].name = "idle_1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.ui.click_rect = r(-15, -5, 30, 30)
tt = RT("decal_stage_38_easter_egg_yamcha", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_38_easter_egg_yamcha.update
tt.render.sprites[1].prefix = "yamcha_warlok"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "yamcha_pozo"
tt.render.sprites[2].animated = false
tt.render.sprites[2].ignore_start = true
tt.render.sprites[2].z = Z_DECALS
tt.ui.click_rect = r(-25, -10, 50, 38)
tt = RT("decal_stage_37_fires_exo", "decal")
tt.spr_cfgs = {
	{
		sort_y_offset = 0
	},
	{
		sort_y_offset = 0
	},
	{
		sort_y_offset = -300
	},
	[6] = {
		sort_y_offset = 150
	},
	[7] = {
		sort_y_offset = -32
	}
}
tt.render.sprites[1] = nil

for k, v in pairs(tt.spr_cfgs) do
	local i = #tt.render.sprites + 1

	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "fuego_fx_stage2_fire" .. k .. "Def"
	tt.render.sprites[i].name = "run"
	tt.render.sprites[i].animated = true
	tt.render.sprites[i].exo = true
	tt.render.sprites[i].z = Z_OBJECTS
	tt.render.sprites[i].sort_y_offset = v.sort_y_offset
end

tt = RT("decal_stage_38_fires_exo", "decal")
tt.spr_cfgs = {
	{
		sort_y_offset = 0
	},
	{
		sort_y_offset = 0
	},
	{
		sort_y_offset = 0
	},
	{
		sort_y_offset = 0
	},
	[7] = {
		sort_y_offset = 94
	},
	[8] = {
		sort_y_offset = 0
	},
	[9] = {
		sort_y_offset = -100
	}
}
tt.render.sprites[1] = nil

for k, v in pairs(tt.spr_cfgs) do
	local i = #tt.render.sprites + 1

	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "fuego_fx_stage3_fire" .. k .. "Def"
	tt.render.sprites[i].name = "run"
	tt.render.sprites[i].animated = true
	tt.render.sprites[i].exo = true
	tt.render.sprites[i].z = Z_OBJECTS
	tt.render.sprites[i].sort_y_offset = v.sort_y_offset
end

tt = RT("decal_stage_38_mask_01", "decal")
tt.render.sprites[1].name = "stage_38_mask_01"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 142
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_38_mask_02", "decal")
tt.render.sprites[1].name = "stage_38_mask_02"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = 106
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_38_mask_03", "decal")
tt.render.sprites[1].name = "stage_38_mask_03"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -20
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_38_mask_04", "decal")
tt.render.sprites[1].name = "stage_38_mask_04"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -100
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_38_mask_07", "decal")
tt.render.sprites[1].name = "stage_38_mask_07"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -200
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_38_mask_08", "decal")
tt.render.sprites[1].name = "stage_38_mask_08"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = RT("decal_stage_38_mask_09", "decal")
tt.render.sprites[1].name = "stage_38_mask_09"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = RT("decal_stage_38_mask_10", "decal")
tt.render.sprites[1].name = "stage_38_mask_10"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = RT("decal_stage_38_mask_islas", "decal_tween")

E:add_comps(tt, "main_script")

tt.main_script.insert = scripts.decal_stage_36_mask_islas.insert
tt.islas_levels = {
	TOP = Z_BACKGROUND_COVERS + 2,
	MID = Z_BACKGROUND_BETWEEN - 1,
	BACK = Z_BACKGROUND_BETWEEN - 2
}
tt.islas_settings = {
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	}
}
tt.temp_i = 0

for i = 1, #tt.islas_settings do
	if not tt.islas_settings[i].skip then
		tt.temp_i = tt.temp_i + 1

		local str = tt.islas_settings[i].str
		local freq = tt.islas_settings[i].freq
		local z = tt.islas_levels[tt.islas_settings[i].z]

		freq = freq + math.random(-20, 20)
		tt.render.sprites[tt.temp_i] = E:clone_c("sprite")
		tt.render.sprites[tt.temp_i].name = "stage_03_islas_flotantes_00" .. (i < 10 and "0" or "") .. i
		tt.render.sprites[tt.temp_i].animated = false
		tt.render.sprites[tt.temp_i].z = z
		tt.tween.props[tt.temp_i] = E:clone_c("tween_prop")
		tt.tween.props[tt.temp_i].sprite_id = tt.temp_i
		tt.tween.props[tt.temp_i].name = "offset"
		tt.tween.props[tt.temp_i].interp = "sine"
		tt.tween.props[tt.temp_i].keys = {
			{
				fts(0),
				v(0, 0)
			},
			{
				fts(freq),
				v(0, -str)
			},
			{
				fts(freq * 2),
				v(0, 0)
			}
		}
		tt.tween.props[tt.temp_i].loop = true
	end
end

tt.temp_i = nil
tt.tween.remove = false
tt = RT("decal_stage_38_to_the_stars", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_38_to_the_stars.update
tt.render.sprites[1].prefix = "to_the_stars_guy"
tt.render.sprites[1].name = "idle1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.ui.click_rect = r(-60, -20, 70, 70)
tt = RT("decal_stage_38_to_the_stars_drakefx", "decal_scripted")
tt.render.sprites[1].prefix = "to_the_stars_drakefx"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("decal_stage_38_to_the_stars_stars", "decal_scripted")
tt.render.sprites[1].prefix = "to_the_stars_star"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt = RT("decal_stage_38_warden_balloon", "decal_scripted")
b = balance.specials.stage_38_dragon_wardens.soldiers.dragon_raider
tt.duration = b.balloon_duration
tt.main_script.update = scripts.decal_stage_38_warden_balloon.update
tt.render.sprites[1].prefix = "warden_warlock_stage3_globo_rider"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -50
tt = RT("decal_stage_39_floor_veins_controller")

E:add_comps(tt, "pos", "main_script")

tt.main_script.update = scripts.decal_stage_39_floor_veins_controller.update
tt.activate_veins = scripts.decal_stage_39_floor_veins_controller.activate_veins_fn
tt.veins_configs = {
	{
		holder_id = "4"
	},
	{
		holder_id = "2"
	},
	{
		holder_id = "10"
	},
	{
		holder_id = "8"
	},
	{
		holder_id = "6"
	}
}
tt.veins_sequences = {
	{
		veins = {
			{
				vein = 4
			}
		}
	},
	{
		veins = {
			{
				vein = 3
			},
			{
				vein = 5
			}
		}
	},
	{
		kill_units = "END",
		veins = {
			{
				vein = 1
			},
			{
				vein = 2
			}
		}
	},
	{
		delay = 7,
		veins_per_cast = 2,
		veins = {
			{
				vein = 1
			},
			{
				delay = 10,
				vein = 2
			},
			{
				delay = 5,
				vein = 3
			},
			{
				delay = 15,
				vein = 4
			},
			{
				vein = 5
			}
		}
	}
}
tt = RT("decal_stage_39_floor_vein", "decal_scripted")
tt.main_script.update = scripts.decal_stage_39_floor_vein.update
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].prefix = nil
tt.holder_id = nil
tt.pos = v(512, 384)
tt = RT("decal_stage_39_tower_stun_explosion", "decal_scripted")
tt.render.sprites[1].prefix = "stage_39_spawner_splashDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[1].scale = vv(1.5)
tt.render.sprites[1].offset = v(0, -30)
tt = RT("decal_stage_40_storm_decos", "decal")
tt.render.sprites[1].prefix = "stage_40_storm_01Def"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[1].scale = vv(4)
tt.render.sprites[1].pos = v(512, 384)
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].flip_y = true
tt.render.sprites[3] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[3].prefix = "stage_40_storm_02Def"
tt.render.sprites[3].z = Z_OBJECTS_COVERS
tt.render.sprites[3].scale = vv(1)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].prefix = "stage_40_storm_04Def"
tt.render.sprites[4].z = Z_BACKGROUND_COVERS
tt.render.sprites[4].sort_y_offset = -1
tt.render.sprites[5] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[5].pos = v(300, 330)
tt.render.sprites[5].prefix = "stage_40_storm_04Def"
tt.render.sprites[5].z = Z_BACKGROUND_COVERS + 2
tt.render.sprites[5].sort_y_offset = 55
tt.render.sprites[5].hidden = true
tt.render.sprites[6] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[6].prefix = "stage_40_storm_05Def"
tt.render.sprites[6].z = Z_BACKGROUND_COVERS - 1
tt.render.sprites[7] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[7].pos = v(800, 340)
tt.render.sprites[7].prefix = "stage_40_storm_04Def"
tt.render.sprites[7].z = Z_BACKGROUND_COVERS
tt.render.sprites[7].sort_y_offset = -1
tt.render.sprites[8] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[8].pos = v(800, 370)
tt.render.sprites[8].prefix = "stage_40_storm_04Def"
tt.render.sprites[8].z = Z_BACKGROUND_COVERS - 1
tt = RT("decal_stage_40_bottom_mask", "decal")
tt.render.sprites[1].name = "stage_40_mask_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 2
tt = RT("decal_stage_40_top_mask", "decal")
tt.render.sprites[1].name = "stage_40_mask_2"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = RT("decal_stage_40_holders_mask", "decal")
tt.render.sprites[1].name = "stage_40_holder_mask_1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 10
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "stage_40_holder_mask_2"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BACKGROUND_COVERS + 10
tt = RT("decal_stage_40_boss_fires_steps", "decal_scripted")
tt.main_script.update = scripts.decal_stage_40_boss_fires_steps.update
tt.start_next_fire = scripts.decal_stage_40_boss_fires_steps.start_next_fire
tt.render.sprites[1].prefix = "stage_40_fire_paso_1Def"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].prefix = "stage_40_fire_paso_2Def"
tt.render.sprites[3] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[3].prefix = "stage_40_fire_paso_3Def"
tt.render.sprites[4] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[4].prefix = "stage_40_fire_paso_4Def"
tt.render.sprites[5] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[5].prefix = "stage_40_fire_paso_5Def"
tt = RT("decal_stage_40_open_middle_mask", "decal")
tt.render.sprites[1].prefix = "mecanica_rocas_stage_40Def"
tt.render.sprites[1].name = "rocas_in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 1
tt = RT("decal_stage_40_open_middle_mask_iron", "decal_stage_40_open_middle_mask")

E:add_comps(tt, "editor")

tt.render.sprites[1].name = "rocas_idle"
tt = RT("decal_stage_40_path_rock_1", "decal_tween")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.decal_stage_40_path_rock.update
tt.tweens_go_down_fn = scripts.decal_stage_40_path_rock.tweens_go_down
tt.render.sprites[1].prefix = "roca_blockDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 1
tt.render.sprites[1].scale = vv(0.8)
tt.render.sprites[1].group = "layers"
tt.render.sprites[1].hidden = true
tt.levitate_duration = 2
tt.levitate_height_div2 = 5
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[1].loop = true

local soff = tt.render.sprites[1].offset

tt.tween.props[1].keys = {
	{
		0,
		v(soff.x, soff.y - tt.levitate_height_div2)
	},
	{
		tt.levitate_duration,
		v(soff.x, soff.y + tt.levitate_height_div2)
	},
	{
		tt.levitate_duration * 2,
		v(soff.x, soff.y - tt.levitate_height_div2)
	}
}
tt.tween.disabled = false
tt.tween.remove = false
tt.small_rocks = {
	{
		flip = false,
		pos = v(-80, 26),
		scale = vv(1.2)
	},
	{
		flip = true,
		pos = v(45, -45),
		scale = vv(1)
	}
}
tt = RT("decal_stage_40_path_rock_2", "decal_stage_40_path_rock_1")
tt.render.sprites[1].prefix = "roca_block02Def"
tt.small_rocks = {
	{
		flip = false,
		pos = v(-80, 20),
		scale = vv(0.7)
	},
	{
		flip = false,
		pos = v(-90, -25),
		scale = vv(1)
	},
	{
		flip = false,
		pos = v(55, -45),
		scale = vv(0.9)
	}
}
tt = RT("decal_stage_40_path_rock_final", "decal_stage_40_path_rock_1")
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "roca_block_dragonDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].animated = true
tt.render.sprites[2].exo = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].scale = vv(0.8)
tt.render.sprites[2].sort_y_offset = -2
tt.render.sprites[2].group = "layers"
tt.render.sprites[2].hidden = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].interp = "sine"
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].loop = true
tt.tween.props[2].keys = {
	{
		0,
		v(soff.x, soff.y - tt.levitate_height_div2)
	},
	{
		tt.levitate_duration,
		v(soff.x, soff.y + tt.levitate_height_div2)
	},
	{
		tt.levitate_duration * 2,
		v(soff.x, soff.y - tt.levitate_height_div2)
	}
}
tt.small_rocks = {
	{
		flip = true,
		pos = v(45, -40),
		scale = vv(0.6)
	},
	{
		flip = true,
		pos = v(-40, -60),
		scale = vv(0.4)
	},
	{
		flip = false,
		pos = v(-75, 0),
		scale = vv(0.4)
	},
	{
		flip = true,
		pos = v(40, 40),
		scale = vv(0.4)
	}
}
tt = RT("decal_stage_40_path_rock_small", "decal_stage_40_path_rock_1")
tt.render.sprites[1].prefix = "roca_block_smallDef"
tt.skip_sparks = true
tt.skip_big_dust = true
tt.random_delay_up = {
	0.1,
	0.5
}
tt.random_delay_down = {
	0.3,
	0.8
}
tt.small_rocks = {}
tt = RT("tower_holder_blocked")

E:add_comps(tt, "tower", "tower_holder", "pos", "render", "ui", "sound_events", "editor")

tt.tower.level = 1
tt.tower.can_be_mod = false
tt.tower_holder.blocked = true
tt.tower.can_be_sold = false
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_holders_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "terrains_holders_%04i_flag"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 13.5)
tt.render.sprites[2].sort_y_offset = 13.5
tt.ui.click_rect = r(-40, -12, 80, 46)
tt.sound_events.remove = "GUITowerSell"
tt = RT("tower_build_dragons", "tower_build")
tt.build_name = "tower_dragons_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2].name = "dlc_dragons_tower_construction"
tt.render.sprites[2].offset = v(0, 10)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
tt = RT("tower_dragons_lvl1", "tower_KR5")
b = balance.towers.dragons

E:add_comps(tt, "attacks", "barrack", "vis", "user_selection")

tt.tower.type = "dragons"
tt.tower.kind = TOWER_KIND_MAGE
tt.tower.team = TEAM_DARK_ARMY
tt.tower.level = 1
tt.tower.price = b.price[1]
tt.tower.menu_offset = v(0, 28)
tt.info.i18n_key = "TOWER_DRAGONS_1"
tt.info.room_portrait = "quickmenu_main_icons_main_icons_0026_0001"
tt.info.portrait = "portraits_towers_0033"
tt.info.enc_icon = 85
tt.info.tower_portrait = "towerselect_portraits_big_" .. "0001"
tt.info.fn = scripts.tower_dragons.get_info
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_dragons.update
tt.main_script.remove = scripts.tower_dragons.remove
tt.attacks.list[1] = E:clone_c("custom_attack")
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.attacks.range = b.ranged_attack.range[1]
tt.attacks.template_unit = "faerie_dragon_lvl1"
tt.attacks.idle_offsets = {
	v(14, 10),
	vv(0),
	vv(0),
	vv(0),
	vv(0)
}
tt.attacks.max_dragons = 1
tt.breath_fx = "fx_tower_dragons_respiracion_lvl1"
tt.breath_fx_spr_idx = 69
tt.evolve_fx = "fx_tower_dragons_evolve_lvl1"
tt.evolve_fx_offset = v(10, 7)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "dlc_dragons_tower_tower_lvl1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 10)
tt.sound_events.insert = "TowerDragonsLevelUpTaunts"
tt.sound_events.tower_room_select = "TowerDragonsEquipTaunt"
tt = RT("tower_dragons_lvl2", "tower_dragons_lvl1")
tt.info.enc_icon = 86
tt.info.i18n_key = "TOWER_DRAGONS_2"
tt.tower.level = 2
tt.tower.price = b.price[2]
tt.render.sprites[2].prefix = "dlc_dragons_tower_tower_lvl2"
tt.attacks.template_unit = "faerie_dragon_lvl2"
tt.attacks.idle_offsets = {
	v(-36, 10),
	v(42, 10),
	v(50, 10),
	v(-14, 25),
	vv(0)
}
tt.attacks.range = b.ranged_attack.range[2]
tt.attacks.max_dragons = 2
tt.breath_fx = "fx_tower_dragons_respiracion_lvl2"
tt.breath_fx_spr_idx = 69
tt = RT("tower_dragons_lvl3", "tower_dragons_lvl1")
tt.info.enc_icon = 87
tt.info.i18n_key = "TOWER_DRAGONS_3"
tt.tower.level = 3
tt.tower.price = b.price[3]
tt.render.sprites[2].prefix = "dlc_dragons_tower_tower_lvl3"
tt.attacks.template_unit = "faerie_dragon_lvl3"
tt.attacks.idle_offsets = {
	v(-44, 10),
	v(14, 25),
	v(50, 10),
	v(-14, 25),
	vv(0),
}
tt.attacks.range = b.ranged_attack.range[3]
tt.attacks.max_dragons = 3
tt.breath_fx = "fx_tower_dragons_respiracion_lvl3"
tt.breath_fx_spr_idx = 69
tt = RT("tower_dragons_lvl4", "tower_dragons_lvl1")

E:add_comps(tt, "powers")

tt.info.enc_icon = 88
tt.info.i18n_key = "TOWER_DRAGONS_4"
tt.info.stat_damage = b.stats.damage
tt.info.stat_cooldown = b.stats.cooldown
tt.info.stat_range = b.stats.range
tt.tower.level = 4
tt.tower.price = b.price[4]
tt.render.sprites[2].prefix = "dlc_dragons_tower_tower_lvl4"
tt.render.sprites[2].animated = true
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "lvl4_angry_head_run"
tt.render.sprites[3].offset = v(0, 10)
tt.render.sprites[3].ignore_start = true
tt.render.sprites[3].hidden = true
tt.attacks.template_unit = "faerie_dragon_lvl4"
tt.attacks.idle_offsets = {
	v(-44, 10),
	v(14, 25),
	v(50, 10),
	v(-14, 25),
	vv(0),
}
tt.attacks.max_dragons = 3
tt.attacks.list[2] = E:clone_c("custom_attack")
tt.attacks.list[2].animation = "scream"
tt.attacks.list[2].cast_time = fts(16)
tt.attacks.list[2].range = b.massive_fear.max_range
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].vis_flags = bor(F_RANGED)
tt.attacks.list[2].mod_stun = "mod_stun_tower_dragons_massive_fear"
tt.attacks.list[2].damage_config = 0
tt.attacks.list[2].stun_duration = 0
tt.attacks.list[2].cast_sound = "TowerDragonsScreech"
tt.attacks.list[3] = E:clone_c("bullet_attack")
tt.attacks.list[3].bullet = "bullet_tower_dragons_dragon_split"
tt.attacks.list[3].shoot_time = fts(20)
tt.attacks.list[3].vis_flags = bor(F_RANGED)
tt.attacks.list[3].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[3].node_prediction = fts(30)
tt.attacks.list[3].animation = {
	"shoot_left",
	"shoot_right"
}
tt.attacks.list[3].bullet_start_offset = {
	v(-30, 53),
	v(0, 53)
}
tt.attacks.list[3].first_cooldown = 2
tt.attacks.list[3].min_range = b.dragon_split.min_range
tt.attacks.list[3].range = b.dragon_split.max_range
tt.attacks.list[3].sound = "TowerHermitToadShootMagic"
tt.attacks.list[3].damage_min = b.dragon_split.damage_min
tt.attacks.list[3].damage_max = b.dragon_split.damage_max
tt.attacks.list[3].damage_radius = b.dragon_split.damage_radius
tt.attacks.list[3].damage_min_area = b.dragon_split.damage_min_area
tt.attacks.list[3].damage_max_area = b.dragon_split.damage_max_area
tt.attacks.list[3].damage_type = b.dragon_split.damage_type
tt.attacks.range = b.ranged_attack.range[4]
tt.powers.dragon_split = E:clone_c("power")
tt.powers.dragon_split.cooldown = b.dragon_split.cooldown
tt.powers.dragon_split.price_base = b.dragon_split.price[1]
tt.powers.dragon_split.price_inc = b.dragon_split.price[2]

tt.powers.dragon_split.enc_icon = 543
tt.powers.dragon_split.max_level = 3
tt.powers.massive_fear = E:clone_c("power")
tt.powers.massive_fear.cooldown = b.massive_fear.cooldown
tt.powers.massive_fear.price_base = b.massive_fear.price[1]
tt.powers.massive_fear.price_inc = b.massive_fear.price[2]
tt.powers.massive_fear.min_targets = b.massive_fear.min_targets
tt.powers.massive_fear.max_targets = b.massive_fear.max_targets
tt.powers.massive_fear.stun_duration = b.massive_fear.stun_duration
tt.powers.massive_fear.max_level = 2
tt.powers.massive_fear.enc_icon = 542
tt.breath_fx = "fx_tower_dragons_respiracion_lvl4"
tt.breath_fx_spr_idx = 49
tt.breath_fire_fx = "fx_tower_dragons_respiracion_lvl4_fuego"
tt.sound_events.insert = "TowerDragonsEquipTaunt"
tt = RT("mod_stun_tower_dragons_massive_fear", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_BOSS)
tt.render.sprites[1].prefix = "dlc_dragons_tower_modifier_stun"
tt.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor = v(0.5, 0.3)
tt = RT("decal_tower_dragons_stun", "decal_scripted")
tt.main_script.update = scripts.decal_tower_dragons_stun.update
tt.render.sprites[1].prefix = "dlc_dragons_tower_trail_skill_decal"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt = RT("faerie_dragon_lvl1", "decal_scripted")

E:add_comps(tt, "force_motion", "custom_attack", "tween")

b = balance.towers.dragons.ranged_attack
anchor_y = 0.5
image_y = 30
tt.flight_height = 80
tt.flight_speed_idle = 80
tt.flight_speed_busy = 120
tt.ramp_dist_idle = 80
tt.ramp_dist_busy = 80
tt.idle_pos = nil
tt.main_script.update = scripts.faerie_dragon.update
tt.custom_attack = E:clone_c("bullet_attack")
tt.custom_attack.animation = "attack"
tt.custom_attack.bullet = "bolt_faerie_dragon_lvl1"
tt.custom_attack.shoot_time = fts(12)
tt.custom_attack.bullet_start_offset = {
	v(18, -33)
}
tt.custom_attack.cooldown = b.cooldown
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "dlc_dragons_tower_drake_lvl1"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop_forced = true
tt.render.sprites[1].sort_y_offset = -12
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.owner = nil
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.8,
		0
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].keys = {
	{
		0,
		v(0, tt.flight_height)
	},
	{
		0.8,
		v(50, tt.flight_height)
	}
}
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		255
	},
	{
		0.8,
		0
	}
}
tt.tween.props[3].name = "alpha"
tt.tween.props[3].sprite_id = 2
tt.tween.props[4] = E:clone_c("tween_prop")
tt.tween.props[4].name = "offset"
tt.tween.props[4].keys = {
	{
		0,
		v(0, 0)
	},
	{
		0.8,
		v(50, 0)
	}
}
tt.tween.props[4].sprite_id = 2
tt.tween.remove = true
tt.tween.disabled = true
tt = RT("faerie_dragon_lvl2", "faerie_dragon_lvl1")
tt.custom_attack.bullet = "bolt_faerie_dragon_lvl2"
tt.render.sprites[1].prefix = "dlc_dragons_tower_drake_lvl2"
tt = RT("faerie_dragon_lvl3", "faerie_dragon_lvl1")
tt.custom_attack.bullet = "bolt_faerie_dragon_lvl3"
tt.render.sprites[1].prefix = "dlc_dragons_tower_drake_lvl3"
tt = RT("faerie_dragon_lvl4", "faerie_dragon_lvl1")
tt.custom_attack.bullet = "bolt_faerie_dragon_lvl4"
tt.render.sprites[1].prefix = "dlc_dragons_tower_drake_lvl4"
tt = RT("bolt_faerie_dragon_lvl1", "bolt")
tt.render.sprites[1].prefix = "dlc_dragons_tower_drake_proyectile"
tt.bullet.damage_type = b.damage_type
tt.bullet.acceleration_factor = 0.25
tt.bullet.min_speed = 90
tt.bullet.max_speed = 180
tt.bullet.damage_min = b.damage_min[1]
tt.bullet.damage_max = b.damage_max[1]
tt.bullet.hit_fx = "fx_bolt_faerie_dragon"
tt.bullet.mod = "mod_faerie_dragon_lvl1"
tt.bullet.particles_name = "ps_bolt_faerie_dragon"
tt.bullet.use_unit_damage_factor = true
tt.sound_events.insert = "TowerDragonsAttack"
tt = RT("bolt_faerie_dragon_lvl2", "bolt_faerie_dragon_lvl1")
tt.bullet.mod = "mod_faerie_dragon_lvl2"
tt.bullet.damage_min = b.damage_min[2]
tt.bullet.damage_max = b.damage_max[2]
tt = RT("bolt_faerie_dragon_lvl3", "bolt_faerie_dragon_lvl1")
tt.bullet.mod = "mod_faerie_dragon_lvl3"
tt.bullet.damage_min = b.damage_min[3]
tt.bullet.damage_max = b.damage_max[3]
tt = RT("bolt_faerie_dragon_lvl4", "bolt_faerie_dragon_lvl1")
tt.render.sprites[1].prefix = "dlc_dragons_tower_drake_lvl4_proyectile"
tt.bullet.mod = "mod_faerie_dragon_lvl4"
tt.bullet.particles_name = "ps_bolt_faerie_dragon_lvl4"
tt.bullet.hit_fx = "fx_bolt_faerie_dragon_lvl4"
tt.bullet.damage_min = b.damage_min[4]
tt.bullet.damage_max = b.damage_max[4]
tt = RT("fx_bolt_faerie_dragon", "fx")
tt.render.sprites[1].name = "dlc_dragons_tower_hit_run"
tt = RT("fx_bolt_faerie_dragon_lvl4", "fx")
tt.render.sprites[1].name = "dlc_dragons_tower_hit_lvl4_run"
tt = RT("ps_bolt_faerie_dragon")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "dlc_dragons_tower_drake_proyectile_trail_run"
tt.particle_system.animated = true
tt.particle_system.particle_lifetime = {
	fts(14),
	fts(14)
}
tt.particle_system.emission_rate = 15
tt.particle_system.emit_offset = v(8, 0)
tt = RT("ps_bolt_faerie_dragon_lvl4", "ps_bolt_faerie_dragon")
tt.particle_system.name = "dlc_dragons_tower_drake_lvl4_proyectile_trail_run"
tt = RT("mod_faerie_dragon_lvl1", "mod_slow")

E:add_comps(tt, "render")

tt.main_script.insert = scripts.mod_faerie_dragon_slow.insert
tt.modifier.duration = b.slow_duration[1]
tt.slow.factor = b.slow_factor[1]
tt.render.sprites[1].name = "dlc_dragons_tower_modifire_drake_attack_run"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -20
tt.render.sprites[1].anchor = v(0.5, 0.6)
tt.render.sprites[1].loop = true
tt = RT("mod_faerie_dragon_lvl2", "mod_faerie_dragon_lvl1")
tt.modifier.duration = b.slow_duration[2]
tt.slow.factor = b.slow_factor[2]
tt = RT("mod_faerie_dragon_lvl3", "mod_faerie_dragon_lvl1")
tt.modifier.duration = b.slow_duration[3]
tt.slow.factor = b.slow_factor[3]
tt = RT("mod_faerie_dragon_lvl4", "mod_faerie_dragon_lvl1")
tt.modifier.duration = b.slow_duration[4]
tt.slow.factor = b.slow_factor[4]
tt = RT("tower_dragons_warden", "tower_KR5")
b = balance.specials.towers.tower_dragons_warden

E:add_comps(tt, "attacks", "vis", "powers", "idle_flip")

tt.tower.type = "stage_37_tower_dragons_warden"
tt.tower.level = 1
tt.tower.can_be_sold = false
tt.tower.can_be_mod = false
tt.tower.range_offset = v(0, 10)
tt.tower.price = 0
tt.info.portrait = "portraits_towers_0032"
tt.info.fn = scripts.tower_mage.get_info
tt.powers.increase_damage = E:clone_c("power")
tt.powers.increase_damage.damage_factor = b.increase_damage.damage_factor
tt.powers.increase_damage.price_base = b.increase_damage.price[1]
tt.powers.increase_damage.price_inc = b.increase_damage.price[2]
tt.powers.increase_rate = E:clone_c("power")
tt.powers.increase_rate.attack_cooldown = b.increase_rate.attack_cooldown
tt.powers.increase_rate.price_base = b.increase_rate.price[1]
tt.powers.increase_rate.price_inc = b.increase_rate.price[2]
tt.main_script.update = scripts.tower_dragons_warden.update
tt.attacks.range = b.basic_attack.max_range
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bullet_stage_37_dragons_wardens"
tt.attacks.list[1].cooldown = b.basic_attack.cooldown
tt.attacks.list[1].shoot_time = fts(32)
tt.attacks.list[1].prediction_time = fts(30)
tt.attacks.list[1].bullet_start_offset = v(20, 50)
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.render.sid_rune = 1
tt.render.sprites[tt.render.sid_rune] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_rune].animated = false
tt.render.sprites[tt.render.sid_rune].z = Z_OBJECTS
tt.render.sprites[tt.render.sid_rune].name = "transparent"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "warden_warlock_warden_warrior"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].offset = v(0, 5)
tt.render.sprites[2].angles = {}
tt.render.sprites[2].angles.idle = {
	"idle_back",
	"idle"
}
tt.render.sprites[2].angles.shoot = {
	"attack_back",
	"attack_front"
}
tt.attacks.list[1].bullet_start_offset.y = tt.attacks.list[1].bullet_start_offset.y + tt.render.sprites[2].offset.y
tt.render.sprites[2].anchor = v(0.5, 0.49047619047619045)
tt.leave = false
tt.leave_anim = "out"
tt.appear = false
tt.appear_anim = "spawn"
tt.idle_flip.cooldown = 3
tt.idle_flip.chance = 0.7
tt.ui.click_rect = r(-35, -15, 70, 70)

tt = E:register_t("tower_dragons_warden_d", "tower_dragons_warden")
---3.14
tt.render.sprites[tt.render.sid_rune].name = "tower_dragon_wardens_mage"
tt.tower.type = "stage_37_tower_dragons_warden_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 225

tt = RT("tower_stage_38_dragon_wardens", "tower_KR5")
b = balance.specials.stage_38_dragon_wardens

E:add_comps(tt, "vis", "user_selection", "attacks", "events")

tt.tower.type = "stage_38_tower_dragons_warden_barrack"
tt.tower.level = 1
tt.tower.can_be_sold = false
tt.tower.can_be_mod = false
tt.tower.range_offset = v(0, 10)
tt.tower.price = 250
tt.tower.menu_offset = v(0, 25)
tt.info.fn = scripts.tower_stage_38_dragon_wardens.get_info
tt.info.portrait = "portraits_towers_0026"
tt.info.desc = "TOWER_STAGE_38_DRAGON_WARDENS_BARRACK_DESCRIPTION"
tt.main_script.update = scripts.tower_stage_38_dragon_wardens.update
tt.max_spawns = b.soldiers.dragon_raider_mounted.max_spawns
tt.wait_after_max_spawns = b.soldiers.dragon_raider_mounted.wait_after_max_spawns
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "wardens_dragon_house_spawner"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 50
tt.render.door_sid = 3
tt.user_selection.ignore_point = true
tt.ui.has_nav_mesh = true
tt.attacks.list[1] = E:clone_c("custom_attack")
tt.attacks.list[1].cast_time = fts(10)
tt.attacks.list[1].entities = {
	"soldier_dragon_warden_dragon_raider"
}
tt.events.list[1].name = "warden"
tt.events.list[1].on_event = scripts.tower_stage_38_dragon_wardens.on_event
tt.ui.can_click = false
tt.ui.can_hover = false
tt.ui.can_select = false
tt = RT("tower_stage_38_dragon_wardens_goal", "decal_scripted")

E:add_comps(tt, "attacks")

tt.main_script.update = scripts.tower_stage_38_dragon_wardens_goal.update
tt.render.sid_base = 1
tt.render.sid_domo = 2
tt.render.sid_tower = 3
tt.find_range = 130
tt.find_range_node_min = 121
tt.spawns = 0
tt.render.sprites[tt.render.sid_base] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_base].animated = false
tt.render.sprites[tt.render.sid_base].name = "wardens_dragon_house_house_floor_back"
tt.render.sprites[tt.render.sid_base].z = Z_TOWER_BASES - 2
tt.render.sprites[tt.render.sid_domo] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_domo].animated = false
tt.render.sprites[tt.render.sid_domo].name = "wardens_dragon_house_house_domo_back"
tt.render.sprites[tt.render.sid_domo].sort_y_offset = 30
tt.render.sprites[tt.render.sid_tower] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_tower].animated = false
tt.render.sprites[tt.render.sid_tower].name = "wardens_dragon_house_house_front"
tt.attacks.list[1] = E:clone_c("custom_attack")
tt.attacks.list[1].entity = "soldier_dragon_warden_dragon_raider_mounted"
tt.attacks.list[1].spawn_delay = 1
---3.14
tt = RT("tower_stage_38_dragon_wardens_goal_d", "tower_KR5")

E:add_comps(tt, "attacks","vis", "user_selection")

tt.tower.type = "stage_38_dragon_wardens_goal_d"
tt.tower.can_be_mod = false
tt.tower.can_hover = false
tt.tower.terrain_style = nil
tt.info.portrait = "gui_bottom_info_image_soldiers_0078"
tt.info.fn = scripts.tower_barrack_mercenaries.get_info
tt.main_script.update = scripts.tower_stage_38_dragon_wardens_goal_d.update
tt.render.sid_base = 1
tt.render.sid_domo = 2
tt.render.sid_tower = 3
tt.find_range = 130
tt.find_range_node_min = 121
tt.spawns = 0
tt.render.sprites[tt.render.sid_base] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_base].animated = false
tt.render.sprites[tt.render.sid_base].name = "wardens_dragon_house_house_floor_back"
tt.render.sprites[tt.render.sid_base].z = Z_TOWER_BASES - 2
tt.render.sprites[tt.render.sid_domo] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_domo].animated = false
tt.render.sprites[tt.render.sid_domo].name = "wardens_dragon_house_house_domo_back"
tt.render.sprites[tt.render.sid_domo].sort_y_offset = 30
tt.render.sprites[tt.render.sid_tower] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_tower].animated = false
tt.render.sprites[tt.render.sid_tower].name = "wardens_dragon_house_house_front"
tt.attacks.list[1] = E:clone_c("custom_attack")
tt.attacks.list[1].entity = "soldier_dragon_warden_dragon_raider_mounted"
tt.attacks.list[1].spawn_delay = 1
tt.attacks.list[1].price = 125
tt.user_selection.ignore_point = true
tt.tower.price = 0
---
tt = RT("soldier_dragon_warden_dragon_raider", "unit")
b = balance.specials.stage_38_dragon_wardens.soldiers.dragon_raider

E:add_comps(tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "sound_events", "melee", "regen")

tt.info.portrait = "gui_bottom_info_image_soldiers_0078"
tt.regen.cooldown = 1
tt.regen.health = b.health_regen
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.hp_max = b.hp_max
tt.health_bar.offset = v(0, 35)
tt.health.dead_lifetime = 3
tt.unit.fade_time_after_death = tt.health.dead_lifetime - 1
tt.unit.fade_duration_after_death = 0.3
tt.info.damage_icon = "magic"
tt.info.fn = scripts.soldier_dragon_warden_charge.get_info
tt.info.i18n_key = "SOLDIER_DRAGON_WARDEN_DRAGON_RAIDER"
tt.main_script.insert = scripts.soldier_charge.insert
tt.main_script.update = scripts.soldier_dragon_warden_charge.update
tt.melee.attacks[1].cooldown = b.melee.cooldown
tt.melee.attacks[1].hit_aura = "bullet_soldier_dragon_warden_dragon_raider"
tt.melee.attacks[1].damage_max = 0
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].damage_type = DAMAGE_NONE
tt.melee.attacks[1].hit_time = fts(18)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].animation = "attack_front"
tt.melee.range = 70
tt.motion.max_speed = b.speed
tt.nav_path.dir = -1
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "warden_warlock_stage3_warden_warrior"
tt.soldier.melee_slot_offset.x = 3
tt.unit.head_offset = v(0, 6)
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, 9)
tt.vis.bans = F_ALL
tt.vis.flags = F_FRIEND
tt.raise = "spawn"
tt.balloon_duration = b.balloon_duration
tt = RT("bullet_soldier_dragon_warden_dragon_raider", "bolt")
b = balance.specials.stage_38_dragon_wardens.soldiers.dragon_raider
tt.main_script.queue = scripts.bullet_soldier_dragon_warden_dragon_raider.queue
tt.aura = {}
tt.render.sprites[1].prefix = "warden_warlock_stage3_projectil"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BULLETS
tt.bullet_start_offset = v(12, 35)
tt.bullet.damage_min = b.melee.damage_min
tt.bullet.damage_max = b.melee.damage_max
tt.bullet.damage_type = b.melee.damage_type
tt.bullet.hit_fx = "fx_bullet_soldier_dragon_warden_dragon_raider_hit"
tt.bullet.particles_name = "ps_bullet_soldier_dragon_warden_dragon_raider_trail"
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "DragonsDLCMageWardensShoot"
tt = RT("soldier_dragon_warden_dragon_raider_mounted", "unit")
b = balance.specials.stage_38_dragon_wardens.soldiers.dragon_raider_mounted

E:add_comps(tt, "soldier", "motion", "main_script", "vis", "info", "sound_events", "ranged", "tween", "regen")

tt.health.armor = b.armor
tt.health.hp_max = b.hp_max
tt.flight_height = 60
tt.regen.cooldown = 1
tt.regen.health = b.health_regen
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, tt.flight_height + 40)
tt.health_bar.sort_y_offset = -tt.health_bar.offset.y - 1
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.z = Z_FLYING_HEROES
tt.info.damage_icon = "magic"
tt.info.portrait = "gui_bottom_info_image_soldiers_0078"
tt.info.i18n_key = "SOLDIER_DRAGON_WARDEN_DRAGON_RAIDER_MOUNTED"
tt.info.fn = scripts.soldier_dragon_warden_dragon_raider_mounted.get_info
tt.main_script.insert = scripts.soldier_dragon_warden_dragon_raider_mounted.insert
tt.main_script.update = scripts.soldier_dragon_warden_dragon_raider_mounted.update
tt.motion.max_speed = b.speed
tt.movement_cooldown_min = 0.5
tt.movement_cooldown_max = 2
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].bullet = "bullet_soldier_dragon_warden_dragon_raider_mounted"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-5, tt.flight_height + 25),
	v(-5, tt.flight_height + 25)
}
tt.ranged.attacks[1].cooldown = b.ranged.cooldown
tt.ranged.attacks[1].min_range = b.ranged.min_range
tt.ranged.attacks[1].max_range = b.ranged.max_range
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].animation = "attack"
tt.render.sprites[1].offset.y = tt.flight_height
tt.render.sprites[1].sort_y_offset = -tt.flight_height
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "warden_warlock_stage3_dragon_rider"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "warden_warlock_stage3_shadow"
tt.render.sprites[2].z = Z_DECALS
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.fade_time_after_death = 1
tt.vis.bans = 0
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.death_fade_duration = 0.6
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		tt.death_fade_duration - fts(6),
		255
	},
	{
		tt.death_fade_duration,
		0
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.props[1].disabled = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].keys = {
	{
		0,
		v(0, tt.render.sprites[1].offset.y)
	},
	{
		tt.death_fade_duration,
		v(40, tt.render.sprites[1].offset.y + 30)
	}
}
tt.tween.props[2].disabled = true
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].name = "alpha"
tt.tween.props[3].keys = {
	{
		0,
		255
	},
	{
		tt.death_fade_duration / 2,
		0
	}
}
tt.tween.props[3].sprite_id = 2
tt.tween.props[3].disabled = true
tt.tween.props[4] = E:clone_c("tween_prop")
tt.tween.props[4].name = "offset"
tt.tween.props[4].keys = {
	{
		0,
		v(0, 10)
	},
	{
		0.5,
		v(0, tt.flight_height)
	}
}
tt.tween.remove = false
tt.tween.reverse = false
tt.tween.disabled = false
tt.ui.click_rect = r(-20, tt.flight_height - 10, 40, 45)
tt.unit.hit_offset = v(0, tt.flight_height + 10)
tt.unit.mod_offset = v(0, tt.flight_height + 10)
tt.wander_radius = b.wander_radius
tt.chase_prediction_time = 1
tt.fx_death = "fx_soldier_dragon_warden_dragon_raider_mounted_death"
tt.sound_events.insert = "Stage38WardensGrowl"
tt = RT("stage_37_barrack_dragon_wardens", "tower_KR5")
b = balance.specials.stage_37_dragon_wardens

E:add_comps(tt, "barrack", "vis")

tt.tower.type = "stage_37_barrack_dragon_wardens"
tt.tower.level = 1
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.can_be_sold = false
tt.tower.can_be_mod = false
tt.info.portrait = "portraits_towers_0008"
tt.info.fn = scripts.tower_barrack_mercenaries.get_info
tt.ui.has_nav_mesh = true
tt.ui.can_click = false
tt.ui.can_hover = false
tt.ui.can_select = false
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.stage_37_barrack_dragon_wardens.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.destroy = scripts.stage_37_barrack_dragon_wardens.destroy
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "stage_37_anim_props_spawner"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 50
tt.render.door_sid = 3
tt.barrack.soldier_type = "soldier_dragon_warden_warrior"
tt.barrack.rally_range = b.rally_range
tt.barrack.respawn_offset = v(-3, 2)
tt.barrack.max_soldiers = b.max_soldiers
tt.respawn_time = b.respawn_time
tt.destroyed = false
---3.14
tt = RT("stage_37_barrack_dragon_wardens_d", "tower_KR5")
b = balance.specials.stage_37_dragon_wardens

E:add_comps(tt, "barrack", "vis")

tt.tower.type = "stage_37_barrack_dragon_wardens_d"
tt.tower.level = 1
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.can_be_sold = true
tt.tower.can_be_mod = true
--tt.info.portrait = "portraits_towers_0008"
tt.info.portrait = "gui_bottom_info_image_soldiers_0077"
tt.info.fn = scripts.tower_barrack_mercenaries.get_info
tt.info.i18n_key = "STAGE_37_BARRACK_DRAGON_WARDENS_D"
tt.ui.has_nav_mesh = true
tt.ui.can_click = true
tt.ui.can_hover = true
tt.ui.can_select = true
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.stage_37_barrack_dragon_wardens_d.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.destroy = scripts.stage_37_barrack_dragon_wardens_d.destroy
--[[
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "stage_37_anim_props_spawner"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = 50
]]--
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "stage_37_anim_props_spawner"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 50
tt.render.door_sid = 3
tt.barrack.soldier_type = "soldier_dragon_warden_warrior"
tt.barrack.rally_range = b.rally_range
tt.barrack.respawn_offset = v(-3, 2)
tt.barrack.max_soldiers = b.max_soldiers
tt.respawn_time = b.respawn_time
tt.destroyed = false
tt.tower.price = 300
---
tt = RT("soldier_dragon_warden_warrior", "soldier_militia")
tt.tower_respawn_time = b.respawn_time
b = balance.specials.stage_37_dragon_wardens

E:add_comps(tt, "reinforcement", "nav_grid", "tween", "regen")

tt.info.portrait = "gui_bottom_info_image_soldiers_0077"
tt.regen.cooldown = 1
tt.regen.health = b.soldiers.warrior.health_regen
tt.health.armor = b.soldiers.warrior.armor
tt.health.magic_armor = b.soldiers.warrior.magic_armor
tt.health.hp_max = b.soldiers.warrior.hp_max
tt.health_bar.offset = v(0, 30)
tt.health.dead_lifetime = 3
tt.info.random_name_format = "SOLDIER_WARDEN_%i_NAME"
tt.info.random_name_count = 6
tt.info.fn = scripts.soldier_dragon_warden_warrior.get_info
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_dragon_warden_warrior.update
tt.melee.attacks[1].cooldown = b.soldiers.warrior.melee.cooldown
tt.melee.attacks[1].hit_times = {
	fts(19),
	fts(25)
}
tt.melee.attacks[1].animations = {
	nil,
	"attack"
}
tt.melee.attacks[1].damage_max = b.soldiers.warrior.melee.damage_max / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_min = b.soldiers.warrior.melee.damage_min / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].loops = 1
tt.melee.attacks[1].damage_type = b.soldiers.warrior.melee.damage_type
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].hit_fx = "fx_warden_warrior_hit"
tt.melee.attacks[1].hit_offset = v(25, 16)
tt.melee.range = 70
tt.motion.max_speed = b.soldiers.warrior.speed
tt.render.sprites[1].prefix = "warden_warrior_warden_warrior"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.soldier.melee_slot_offset.x = 3
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = 0
tt.vis.flags = F_FRIEND
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
tt.reinforcement.duration = 1e+99
tt = RT("soldier_dragon_warden_warrior_reinforcement", "soldier_dragon_warden_warrior")
tt.tower_respawn_time = nil
b = balance.reinforcements
tt.info.i18n_key = "SOLDIER_WARDEN_MELEE_REINFORCEMENT"
tt.reinforcement.duration = b.soldier.duration
tt.reinforcement.fade = true
tt.reinforcement.fade_in = false
tt.reinforcement.fade_out = true
b = balance.specials.stage_40_warden_reinforcements.warrior
tt.regen.cooldown = 1
tt.regen.health = b.regen_health
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.hp_max = b.hp_max
tt.melee.attacks[1].cooldown = b.melee.cooldown
tt.melee.attacks[1].damage_max = b.melee.damage_max
tt.melee.attacks[1].damage_min = b.melee.damage_min
tt.melee.attacks[1].damage_type = b.melee.damage_type
tt.motion.max_speed = b.speed
tt.melee.range = b.melee.range
tt = RT("boss_murglum", "boss")
b = balance.enemies.dragons.dragon_boss_stage_37

E:add_comps(tt, "ranged", "timed_attacks", "tween")

tt.enemy.gold = 1
tt.enemy.lives_cost = 999
tt.enemy.melee_slot = v(40, 0)
tt.flight_height = 80
tt.fly_strenght = 5
tt.fly_frequency = 13
tt.spawn_node = b.spawn_node
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.dead_lifetime = 100
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, 100 + tt.flight_height)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.enc_icon = 138
tt.info.i18n_key = "ENEMY_BOSS_MURGLUM"
tt.info.portrait = "gui_bottom_info_image_enemies_0143"
tt.info.portrait_boss = "boss_health_bar_icon_0014"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.boss_murglum.update
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "boss_murglun_boss"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.idle = {
	"walk",
	"walk",
	"walk"
}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk",
	"walk"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].hidden = false
tt.render.sprites[2].scale = vv(2)
tt.render.sprites[2].z = Z_DECALS
tt.ui.click_rect = r(-42, -10 + tt.flight_height, 84, 80)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 40 + tt.flight_height)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 30 + tt.flight_height)
tt.unit.show_blood_pool = false
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.vis.bans = bor(tt.vis.bans, F_BLOCK)
tt.unit.size = UNIT_SIZE_LARGE
tt.ranged.attacks[1].animation = "attack_basic_full"
tt.ranged.attacks[1].shoot_time = fts(20)
tt.ranged.attacks[1].bullet = "bolt_boss_murglum"
tt.ranged.attacks[1].bullet_start_offset = {
	v(50, -10 + tt.flight_height),
	v(-50, -10 + tt.flight_height)
}
tt.ranged.attacks[1].cooldown = b.basic_attack.cooldown
tt.ranged.attacks[1].max_range = b.basic_attack.max_range
tt.ranged.attacks[1].min_range = b.basic_attack.min_range
tt.ranged.attacks[1].only_foward = b.basic_attack.only_foward
tt.ranged.attacks[1].only_foward_range = b.basic_attack.only_foward_range
tt.ranged.attacks[1].hold_advance = b.basic_attack.hold_advance
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].first_cooldown = b.block_towers_bossfight.first_cooldown
tt.timed_attacks.list[1].cooldown = b.block_towers_bossfight.cooldown
tt.timed_attacks.list[1].animation = "tower_stun"
tt.timed_attacks.list[1].duration = b.block_towers_bossfight.duration
tt.timed_attacks.list[1].max_range = b.block_towers_bossfight.max_range
tt.timed_attacks.list[1].min_range = b.block_towers_bossfight.min_range
tt.timed_attacks.list[1].max_towers_blocked = b.block_towers_bossfight.max_towers_blocked
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[1].cast_time = fts(42)
tt.timed_attacks.list[1].bullet_mod = "boss_murglun_proyectil_tower_stun"
tt.timed_attacks.list[1].nodes_limit = b.block_towers_bossfight.nodes_limit
tt.timed_attacks.list[1].repair_cost = b.block_towers_bossfight.repair_cost
tt.timed_attacks.list[2] = E:clone_c("custom_attack")
tt.timed_attacks.list[2].first_cooldown = b.geisers_bossfight.first_cooldown
tt.timed_attacks.list[2].cooldown = b.geisers_bossfight.cooldown
tt.timed_attacks.list[2].animation_in = "attack_basic_in"
tt.timed_attacks.list[2].animation_loop = "attack_basic_loop"
tt.timed_attacks.list[2].animation_out = "attack_basic_out"
tt.timed_attacks.list[2].geisers_amount = b.geisers_bossfight.geisers_amount
tt.timed_attacks.list[2].geiser_bullet = "bullet_boss_stage_37_geisers_bossfight"
tt.timed_attacks.list[2].decal_bullets_offset = v(50, -10 + tt.flight_height)
tt.timed_attacks.list[2].nodes_limit = b.geisers_bossfight.nodes_limit
tt.timed_attacks.list[2].only_foward = b.geisers_bossfight.only_foward
tt.timed_attacks.list[3] = E:clone_c("area_attack")
tt.timed_attacks.list[3].first_cooldown = b.feral_bite.first_cooldown
tt.timed_attacks.list[3].cooldown = b.feral_bite.cooldown
tt.timed_attacks.list[3].animation = "ataque_bite"
tt.timed_attacks.list[3].hit_time = fts(23)
tt.timed_attacks.list[3].nodes_limit = b.feral_bite.nodes_limit
tt.timed_attacks.list[3].min_damage = b.feral_bite.area_damage.min_damage
tt.timed_attacks.list[3].max_damage = b.feral_bite.area_damage.max_damage
tt.timed_attacks.list[3].damage_type = b.feral_bite.area_damage.damage_type
tt.timed_attacks.list[3].damage_radius = b.feral_bite.area_damage.radius
tt.timed_attacks.list[3].vis_flags = bor(F_AREA)
tt.timed_attacks.list[3].vis_bans = bor(F_FLYING)
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
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].interp = "sine"
tt.tween.props[2].keys = {
	{
		fts(9),
		v(0, 0)
	},
	{
		fts(14),
		v(0, tt.flight_height + 50)
	},
	{
		fts(20),
		v(0, tt.flight_height + 50)
	},
	{
		fts(23),
		v(0, 50)
	},
	{
		fts(30),
		v(0, 50)
	},
	{
		fts(45),
		v(0, tt.flight_height)
	}
}
tt.tween.props[2].loop = true
tt.tween.props[2].sprite_id = 1
tt.tween.props[2].disabled = true
tt.death_decal = "decal_boss_murglum_death"
tt.sound_death = "Stage37MurglunDeath"
tt.sound_death_args = {
	delay = fts(7)
}
tt = RT("hero_dragon_sun", "hero5")

E:add_comps(tt, "ranged", "timed_attacks", "tween", "nav_grid")

b = balance.heroes.hero_dragon_sun
tt.hero.level_stats.armor = b.armor
tt.hero.level_stats.hp_max = b.hp_max
tt.hero.level_stats.regen_health = b.regen_health
tt.hero.level_stats.ranged_damage_min = b.basic_attack.damage_min
tt.hero.level_stats.ranged_damage_max = b.basic_attack.damage_max
tt.hero.level_stats.ranged_damage_min_flier = b.basic_attack.flier.damage_min
tt.hero.level_stats.ranged_damage_max_flier = b.basic_attack.flier.damage_max
tt.hero.level_stats.basic_burn_dot_damage_max = b.basic_attack.burn_dot.damage_min
tt.hero.level_stats.basic_burn_dot_damage_min = b.basic_attack.burn_dot.damage_max
tt.hero.skills.worthy_foe = E:clone_c("hero_skill")
tt.hero.skills.worthy_foe.hr_icon = "0018"
tt.hero.skills.worthy_foe.hr_order = 1
tt.hero.skills.worthy_foe.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.worthy_foe.hr_available = true
tt.hero.skills.worthy_foe.cooldown = b.worthy_foe.cooldown
tt.hero.skills.worthy_foe.target_damage_min = b.worthy_foe.damages_target.damage_min
tt.hero.skills.worthy_foe.target_damage_max = b.worthy_foe.damages_target.damage_max
tt.hero.skills.worthy_foe.area_damage_min = b.worthy_foe.damages_radius.damage_min
tt.hero.skills.worthy_foe.area_damage_max = b.worthy_foe.damages_radius.damage_max
tt.hero.skills.worthy_foe.key = "WORTHY_FOE"
tt.hero.skills.worthy_foe.xp_gain = b.worthy_foe.xp_gain
tt.hero.skills.solar_cleansing = E:clone_c("hero_skill")
tt.hero.skills.solar_cleansing.hr_icon = "0018"
tt.hero.skills.solar_cleansing.hr_order = 2
tt.hero.skills.solar_cleansing.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.solar_cleansing.hr_available = true
tt.hero.skills.solar_cleansing.cooldown = b.solar_cleansing.trigger_requirements.cooldown
tt.hero.skills.solar_cleansing.duration = b.solar_cleansing.duration
tt.hero.skills.solar_cleansing.heal = b.solar_cleansing.heal
tt.hero.skills.solar_cleansing.key = "SOLAR_CLEANSING"
tt.hero.skills.solar_cleansing.xp_gain = b.solar_cleansing.xp_gain
tt.hero.skills.overcharge = E:clone_c("hero_skill")
tt.hero.skills.overcharge.hr_icon = "0019"
tt.hero.skills.overcharge.hr_order = 3
tt.hero.skills.overcharge.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.overcharge.hr_available = true
tt.hero.skills.overcharge.cooldown = b.overcharge.cooldown
tt.hero.skills.overcharge.cooldown_init = b.overcharge.cooldown_init
tt.hero.skills.overcharge.damage_min = b.overcharge.damage_min
tt.hero.skills.overcharge.damage_max = b.overcharge.damage_max
tt.hero.skills.overcharge.damage_min_flier = b.overcharge.flier.damage_min
tt.hero.skills.overcharge.damage_max_flier = b.overcharge.flier.damage_max
tt.hero.skills.overcharge.key = "OVERCHARGE"
tt.hero.skills.solar_stones = E:clone_c("hero_skill")
tt.hero.skills.solar_stones.hr_icon = "0019"
tt.hero.skills.solar_stones.hr_order = 4
tt.hero.skills.solar_stones.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.solar_stones.hr_available = true
tt.hero.skills.solar_stones.cooldown = b.solar_stones.cooldown
tt.hero.skills.solar_stones.damage_min = b.solar_stones.damage_min
tt.hero.skills.solar_stones.damage_max = b.solar_stones.damage_max
tt.hero.skills.solar_stones.max_mines = b.solar_stones.max_mines
tt.hero.skills.solar_stones.max_range = b.solar_stones.max_range
tt.hero.skills.solar_stones.key = "SOLAR_STONES"
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_available = false
tt.hero.skills.ultimate.hr_icon = "0006"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {
	[0] = 1,
	3,
	4,
	5
}
tt.hero.skills.ultimate.hr_available = true
tt.hero.skills.ultimate.cooldown = b.ultimate.cooldown
tt.hero.skills.ultimate.duration = b.ultimate.duration
tt.hero.skills.ultimate.damage_min = b.ultimate.damage_min
tt.hero.skills.ultimate.damage_max = b.ultimate.damage_max
tt.hero.skills.ultimate.controller_name = "hero_dragon_sun_ultimate"
tt.hero.skills.ultimate.key = "ULTIMATE"
tt.hero.team = TEAM_LINIREA
tt.flight_height = 80
tt.health.dead_lifetime = 30
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 120)
tt.health_bar.sort_y_offset = -121
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.health_bar.z = Z_FLYING_HEROES
tt.hero.fn_level_up = scripts.hero_dragon_sun.level_up
--tt.hero.use_custom_spawn_point = true
tt.idle_flip.cooldown = 10
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
tt.info.hero_portrait = "kra_hero_portraits_0019"
tt.info.i18n_key = "HERO_DRAGON_SUN"
tt.info.portrait = "portraits_hero_0019"
tt.info.ultimate_icon = "0019"
tt.info.stat_hp = b.stats.hp
tt.info.stat_armor = b.stats.armor
tt.info.stat_damage = b.stats.damage
tt.info.stat_cooldown = b.stats.cooldown
tt.main_script.insert = scripts.hero_dragon_sun.insert
tt.main_script.update = scripts.hero_dragon_sun.update
tt.motion.max_speed = b.speed
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.all_except_flying_nowalk = bor(TERRAIN_NONE, TERRAIN_LAND, TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK, TERRAIN_SHALLOW, TERRAIN_FAERIE, TERRAIN_ICE, TERRAIN_NO_SHADOW)
tt.nav_grid.valid_terrains = tt.all_except_flying_nowalk
tt.nav_grid.valid_terrains_dest = tt.all_except_flying_nowalk
tt.drag_line_origin_offset = v(0, tt.flight_height)
tt.regen.cooldown = 1
tt.render.sprites[1].offset.y = tt.flight_height
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "hero_aurion_dragon"
tt.render.sprites[1].name = "respawn"
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_hero_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].animated = true
tt.render.sprites[3].prefix = "hero_aurion_sun_skill_overcharge"
tt.render.sprites[3].name = "respawn"
tt.render.sprites[3].offset = tt.render.sprites[1].offset
tt.render.sprites[3].z = Z_FLYING_HEROES
tt.render.sprites[3].draw_order = 2
tt.render.sprites[3].alpha = 0
tt.render.sid_shadow = 2
tt.soldier.melee_slot_offset = v(0, 0)
tt.sound_events.change_rally_point = "HeroDragonSunTaunt"
tt.sound_events.death = "HeroDragonSunDeath"
tt.sound_events.respawn = "HeroDragonSunTaunt"
tt.sound_events.hero_room_select = "HeroDragonSunTauntSelect"
tt.ui.click_rect = r(-37, tt.flight_height - 40, 90, 85)
tt.unit.hit_offset = v(0, tt.flight_height)
tt.unit.mod_offset = v(0, tt.flight_height)
tt.unit.death_animation = "death"
tt.unit.hide_after_death = true
tt.hero.tombstone_decal = nil
tt.hero.respawn_animation = "respawn"
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_POISON)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1
tt.ranged.attacks[1].animation = "radiant_wave"
tt.ranged.attacks[1].min_range = b.basic_attack.min_range
tt.ranged.attacks[1].max_range = b.basic_attack.max_range
tt.ranged.attacks[1].shoot_time = fts(26)
tt.ranged.attacks[1].bullet = "bullet_hero_dragon_sun_breath_ray"
tt.ranged.attacks[1].bullet_start_offset = {
	v(33, tt.flight_height - 14),
	v(33, tt.flight_height - 14)
}
tt.ranged.attacks[1].bullet_flier = "bullet_hero_dragon_sun_breath_flier"
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[1].vis_flags = bor(F_RANGED, F_AREA)
tt.ranged.attacks[1].basic_attack = true
tt.ranged.attacks[1].max_angle = 140
tt.ranged.attacks[1].max_angle_fliers = 140
tt.tween.disabled = false
tt.tween.remove = false
tt.tween.props[1].sprite_id = 2
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
tt.tween.props[1].disabled = true
tt.tween.props[1].ignore_reverse = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].sprite_id = 3
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
tt.tween.props[2].disabled = true
tt.tween.props[2].loop = false
tt.timed_attacks.sid_healing_aura = 1
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].animation = "solar_cleansing"
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].cast_time = fts(20)
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].aura = "aura_hero_dragon_sun_healing"
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].hero_health_threshold = b.solar_cleansing.trigger_requirements.hero_health_threshold
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].allies_health_threshold = b.solar_cleansing.trigger_requirements.allies_health_threshold
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].ally_count_needed = b.solar_cleansing.trigger_requirements.ally_count_needed
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].cached_radius = b.solar_cleansing.radius
tt.timed_attacks.list[tt.timed_attacks.sid_healing_aura].cast_sound = "HeroDragonSunCleansing"
tt.timed_attacks.sid_overcharge = 2
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].bullet = "bullet_hero_dragon_sun_breath_ray_overcharged"
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].bullet_flier = "bullet_hero_dragon_sun_breath_flier_overcharged"
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].fx_mask = "fx_hero_dragon_sun_overcharge_mask"
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].particles_back = nil
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].shadow = nil
tt.timed_attacks.list[tt.timed_attacks.sid_overcharge].cast_sound = "HeroDragonSunOvercharge"
tt.timed_attacks.sid_worthy_foe = 3
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].enemy_minimum_hp = b.worthy_foe.enemy_minimum_hp
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].target_damage_min = nil
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].target_damage_max = nil
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].target_damage_type = b.worthy_foe.damages_target.damage_type
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].area_damage_min = nil
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].area_damage_max = nil
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].area_damage_type = b.worthy_foe.damages_radius.damage_type
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].area_damage_radius = b.worthy_foe.damages_radius.radius
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].animations = {
	"worthy_foe_in",
	"worthy_foe_out",
	"worthy_foe_in",
	"worthy_foe_out_2"
}
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].vis_bans = bor(F_FLYING, F_BOSS)
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].node_margin = 10
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].max_range = 9999
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].min_range = 0
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].decal_target = "fx_hero_dragon_sun_teleport_decal_target"
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].explotion_fx = "fx_hero_dragon_sun_teleport_explotion"
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].explotion_fire = "fx_hero_dragon_sun_teleport_explotion_fire"
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].explotion_decal = "fx_hero_dragon_sun_teleport_explotion_decal"
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].stun_mod = "mod_hero_dragon_stun_worthy_foe_stun"
tt.timed_attacks.list[tt.timed_attacks.sid_worthy_foe].cast_sound = "HeroDragonSunWorthyFoe"
tt.timed_attacks.sid_solar_stones = 4
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].animation = "skill_solar_stone"
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].cast_time = fts(26)
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].cooldown = nil
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].disabled = true
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].bullet = "bullet_hero_dragon_sun_solar_stone"
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].bullet_start_offset = {
	v(40, tt.flight_height + 50)
}
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].max_mines = nil
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].min_range = b.solar_stones.min_range
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].max_range = b.solar_stones.max_range
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].min_dist_between_mines = b.solar_stones.min_dist_between_mines
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].min_distance_from_border = 100
tt.timed_attacks.list[tt.timed_attacks.sid_solar_stones].no_targets_cooldown = b.solar_stones.no_targets_cooldown

tt = E:register_t("hero_dragon_sun_2", "hero_dragon_sun")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = RT("enemy_dragons", "enemy_KR5")
tt.main_script.insert = scripts.enemy_dragons.insert
tt.gold_multiplier = balance.enemies.dragons.gold_multiplier
tt = RT("enemy_basic_lava", "enemy_dragons")

E:add_comps(tt, "melee")

b = balance.enemies.dragons.basic_lava
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 127
tt.info.portrait = "gui_bottom_info_image_enemies_0129"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 6)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.update = scripts.enemy_basic_lava.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "mele"
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.attacks[1].sound = "EnemyCrocBasicMelee"
tt.melee.attacks[1].fn_can = scripts.enemy_basic_lava.fn_can_attack_basic
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "firebreath"
tt.melee.attacks[2].hit_times = {
	fts(18),
	fts(24)
}
tt.melee.attacks[2].cooldown = 0
tt.melee.attacks[2].damage_max = b.special_attack.damage_max
tt.melee.attacks[2].damage_min = b.special_attack.damage_min
tt.melee.attacks[2].damage_type = b.special_attack.damage_type
tt.melee.attacks[2].fn_can = scripts.enemy_basic_lava.fn_can_attack_breath
tt.melee.attacks[2].sound = "EnemyLavaBasicFlameBreath"
tt.melee.attacks[2].sound_args = {
	delay = fts(15)
}
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "lava_basic_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].scale = vv(0.7)
tt.render.sprites[2].name = "lava_evolve_shadow"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].hidden = true
tt.sound_events.death = "EnemyTuskedBrawlerDeath"
tt.ui.click_rect = r(-13, -3, 26, 32)
tt.evolve_mod = "mod_enemy_alfa_lava_evolve"
tt.evolve_sound = "EnemyLavaBasicEvolution"
tt.transform_anim_in = "evolve_in"
tt.transform_anim_loop = "evolve_loop"
tt.transform_anim_out = "evolve_out"
tt = RT("enemy_tanky_draconian", "enemy_dragons")

E:add_comps(tt, "melee")

b = balance.enemies.dragons.tanky_draconian
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 45)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.enc_icon = 129
tt.info.portrait = "gui_bottom_info_image_enemies_0131"
tt.unit.hit_offset = v(0, 18)
tt.unit.head_offset = v(0, 13)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "mele"
tt.melee.attacks[1].hit_time = fts(16)
tt.melee.attacks[1].hit_fx = "fx_enemy_tanky_draconian_hit"
tt.melee.attacks[1].hit_offset = v(30, 15)
tt.melee.attacks[1].sound = "EnemyLavaTankyAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(20)
}
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "lava_tanky_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-16, 0, 32, 36)
tt.sound_events.death = "EnemyLavaTankyDeath"
tt = RT("enemy_evolved_lava", "enemy_dragons")

E:add_comps(tt, "melee", "tween")

b = balance.enemies.dragons.evolved_lava
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.flight_height = 40
tt.fly_strenght = 5
tt.fly_frequency = 13
tt.minimum_fly_duration = b.minimum_fly_duration
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 55 + tt.flight_height)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.enc_icon = 128
tt.info.portrait = "gui_bottom_info_image_enemies_0130"
tt.unit.hit_offset = v(0, 14 + tt.flight_height)
tt.unit.head_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15 + tt.flight_height)
tt.unit.show_blood_pool = false
tt.unit.fade_time_after_death = 0.6
tt.info.fn = scripts.enemy_evolved_lava.get_info
tt.main_script.insert = scripts.enemy_evolved_lava.insert
tt.main_script.update = scripts.enemy_evolved_lava.update
tt.melee.attacks[1].hit_times = {
	fts(6),
	fts(15),
	fts(22)
}
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min / #tt.melee.attacks[1].hit_times
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].animation = "mele"
tt.melee.attacks[1].hit_fx = "fx_enemy_evolved_lava_melee_hit"
tt.melee.attacks[1].hit_offset = v(30, 5)
tt.melee.attacks[1].sound = "EnemyCrocBasicMelee"
tt.melee.attacks[2] = E:clone_c("area_attack")
tt.melee.attacks[2].animation = "firebreath"
tt.melee.attacks[2].hit_time = fts(20)
tt.melee.attacks[2].cooldown = b.special_attack.cooldown
tt.melee.attacks[2].damage_max = b.special_attack.damage_max
tt.melee.attacks[2].damage_min = b.special_attack.damage_min
tt.melee.attacks[2].damage_type = b.special_attack.damage_type
tt.melee.attacks[2].damage_radius = b.special_attack.radius
tt.melee.attacks[2].hit_offset = v(30, 0)
tt.melee.attacks[2].mod = "mod_enemy_evolved_lava_dot"
tt.melee.attacks[2].sound = "EnemyLavaEvolverFlameBreath"
tt.melee.attacks[2].sound_args = {
	delay = fts(20)
}
tt.motion.max_speed = b.speed
tt.speed_fly_mult = b.speed_fly_mult
tt.render.sprites[1].prefix = "lava_evolve_creep"
tt.render.sprites[1].angles.idle_ground = {
	"idle"
}
tt.render.sprites[1].angles.idle_fly = {
	"fly"
}
tt.render.sprites[1].angles.walk_ground = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[1].angles.walk_fly = {
	"fly",
	"fly_up",
	"fly_down"
}
tt.render.sprites[1].angles.death_ground = {
	"death"
}
tt.render.sprites[1].angles.death_fly = {
	"death_fly"
}
tt.render.sprites[1].angles.idle = tt.render.sprites[1].angles.idle_fly
tt.render.sprites[1].angles.walk = tt.render.sprites[1].angles.walk_fly
tt.render.sprites[1].angles.death = tt.render.sprites[1].angles.death_fly
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].scale = vv(1)
tt.render.sprites[2].name = "basic_storm_shadow"
tt.sound_events.death = "EnemyTuskedBrawlerDeath"
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.vis.bans = bor(F_BLOCK)
tt.ui.click_rect = r(-13, -3 + tt.flight_height, 26, 32)
tt.landing_anim = "engage"
tt.landing_duration_evolve = fts(12)
tt.landing_duration = fts(3)
tt.landing_delay = fts(11)
tt.landing_damage_fx = "fx_enemy_evolved_lava_landing_hit"
tt.landing_damage_min = b.landing_attack.damage_min
tt.landing_damage_max = b.landing_attack.damage_max
tt.landing_damage_type = b.landing_attack.damage_type
tt.landing_damage_radius = b.landing_attack.radius
tt.landing_damage_radius_find = b.landing_attack.radius_find
tt.landing_damage_offset = v(20, 0)
tt.landing_damage_vis_flags = F_AREA
tt.landing_damage_vis_bans = F_FLYING
tt.tween.remove = false
tt.tween.props[1].disabled = true
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[1].keys = {
	{
		0,
		v(0, tt.flight_height)
	},
	{
		tt.landing_duration,
		v(0, 0)
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].disabled = true
tt.tween.props[2].name = "scale"
tt.tween.props[2].interp = "sine"
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].keys = {
	{
		0,
		vv(1)
	},
	{
		tt.landing_duration,
		vv(1)
	}
}
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].disabled = true
tt.tween.props[3].name = "offset"
tt.tween.props[3].interp = "sine"
tt.tween.props[3].keys = {
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
tt.tween.props[3].loop = true
tt.tween.props[3].sprite_id = 1
tt.tween.props[4] = E:clone_c("tween_prop")
tt.tween.props[4].disabled = false
tt.tween.props[4].loop = false
tt.tween.props[4].name = "offset"
tt.tween.props[4].interp = "sine"
tt.tween.props[4].sprite_id = 1
tt.tween.props[4].keys = {
	{
		0,
		v(0, 0)
	},
	{
		tt.landing_duration_evolve,
		v(0, tt.flight_height)
	}
}
tt.tween.props[5] = E:clone_c("tween_prop")
tt.tween.props[5].disabled = false
tt.tween.props[5].loop = false
tt.tween.props[5].name = "offset"
tt.tween.props[5].interp = "sine"
tt.tween.props[5].sprite_id = 2
tt.tween.props[5].keys = {
	{
		0,
		vv(1)
	},
	{
		tt.landing_duration_evolve,
		vv(0.7)
	}
}
tt = RT("enemy_alfa_lava", "enemy_dragons")
b = balance.enemies.dragons.alfa_lava

E:add_comps(tt, "melee", "timed_attacks")

tt.info.enc_icon = 130
tt.info.portrait = "gui_bottom_info_image_enemies_0132"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(36, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 60)
tt.main_script.update = scripts.enemy_alfa_lava.update
tt.melee.attacks[1] = E:clone_c("area_attack")
tt.melee.attacks[1].animation = "mele"
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_time = fts(18)
tt.melee.attacks[1].hit_offset = v(40, 0)
tt.melee.attacks[1].sound = "EnemyLavaAlfaAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(18)
}
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].animation = "puke"
tt.timed_attacks.list[1].first_cooldown = b.lava_vomit_attack.first_cooldown
tt.timed_attacks.list[1].cooldown_max = b.lava_vomit_attack.cooldown_max
tt.timed_attacks.list[1].cooldown_min = b.lava_vomit_attack.cooldown_min
tt.timed_attacks.list[1].nodes_limit = b.lava_vomit_attack.nodes_limit
tt.timed_attacks.list[1].cast_time = fts(48)
tt.timed_attacks.list[1].jump_damage_times = {
	fts(6),
	fts(13),
	fts(21),
	fts(30),
	fts(37)
}
tt.timed_attacks.list[1].jump_damage_max = b.lava_vomit_attack.jump.damage_max / #tt.timed_attacks.list[1].jump_damage_times
tt.timed_attacks.list[1].jump_damage_min = b.lava_vomit_attack.jump.damage_min / #tt.timed_attacks.list[1].jump_damage_times
tt.timed_attacks.list[1].jump_damage_radius = b.lava_vomit_attack.jump.radius
tt.timed_attacks.list[1].jump_damage_type = b.lava_vomit_attack.jump.damage_type
tt.timed_attacks.list[1].jump_damage_vis_flags = F_AREA
tt.timed_attacks.list[1].jump_damage_vis_bans = bor(F_FLYING, F_ENEMY)
tt.timed_attacks.list[1].bullet = "bullet_alfa_lava_vomit"
tt.timed_attacks.list[1].bullet_start_offset = v(6, 40)
tt.timed_attacks.list[1].only_while_blocked = b.lava_vomit_attack.only_while_blocked
tt.timed_attacks.list[1].sound = "EnemyLavaAlfaEvolverShot"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "lava_alpha_creep"
tt.render.sprites[1].draw_order = DO_ENEMY_BIG
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-24, 0, 50, 53)
tt.unit.hit_offset = v(0, 25)
tt.unit.head_offset = v(0, 10)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.unit.blood_color = BLOOD_GRAY
tt.unit.show_blood_pool = false
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt = RT("enemy_basic_acid", "enemy_dragons")

local b = balance.enemies.dragons.basic_acid

E:add_comps(tt, "melee", "timed_attacks")

tt.info.enc_icon = 124
tt.info.portrait = "gui_bottom_info_image_enemies_0133"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 34)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.motion.max_speed = b.speed
tt.main_script.update = scripts.enemy_basic_acid.update
tt.evolve_mod = "mod_enemy_alfa_acid_evolve"
tt.evolve_sound = "EnemyAcidBasicEvolution"
tt.evolve_sound_args = {
	delay = fts(20)
}
tt.transform_anim_in = "evolve_in"
tt.transform_anim_loop = "evolve_loop"
tt.transform_anim_out = "evolve_out"
tt.render.sprites[1].prefix = "acid_basic_creep"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].ignore_start = true
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_DECALS
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].animation = "melee_attk"
tt.melee.attacks[1].hit_fx = "fx_enemy_basic_acid_melee_hit"
tt.melee.attacks[1].sound = "EnemyAcidBasicAttack"
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].bullet = "bullet_enemy_basic_acid"
tt.timed_attacks.list[1].shoot_time = fts(12)
tt.timed_attacks.list[1].cooldown = b.ranged_attack.cooldown
tt.timed_attacks.list[1].max_range = b.ranged_attack.max_range
tt.timed_attacks.list[1].min_range = b.ranged_attack.min_range
tt.timed_attacks.list[1].bullet_start_offset = {
	v(0, 50)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].animation = "ranged_attk"
tt.timed_attacks.list[1].filter_targets_with_mod = "mod_enemy_basic_acid_armor_reduction"
tt.ui.click_rect = r(-17, 0, 34, 35)
tt.unit.head_offset = v(0, 7)
tt.unit.hit_offset = v(0, 10)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 7)
tt.unit.size = UNIT_SIZE_SMALL
tt.vis.flags = bor(F_ENEMY)
tt.sound_events.death = "EnemyNoxiousHorrorDeath"
tt = RT("enemy_evolved_acid", "enemy_dragons")

local b = balance.enemies.dragons.evolved_acid

E:add_comps(tt, "timed_attacks", "tween")

tt.info.enc_icon = 125
tt.info.portrait = "gui_bottom_info_image_enemies_0134"
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(25, 0)
tt.enemy.lives_cost = b.lives_cost
tt.gold_config = b.gold
tt.health.hp_max = b.hp
tt.hp_config = b.hp
tt.flight_height = 25
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 47 + tt.flight_height)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.motion.max_speed = b.speed
tt.speed_config = b.speed
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "spawn"
tt.timed_attacks.list[1].cooldown = b.summon.cooldown
tt.timed_attacks.list[1].first_cooldown = b.summon.first_cooldown
tt.timed_attacks.list[1].nodes_limit = b.summon.nodes_limit
tt.timed_attacks.list[1].cast_time = fts(34)
tt.timed_attacks.list[1].max_nodes_range = b.summon.max_nodes_range
tt.timed_attacks.list[1].min_nodes_range = b.summon.min_nodes_range
tt.timed_attacks.list[1].bullet_start_offset = v(13, 0 + tt.flight_height)
tt.timed_attacks.list[1].bullet = "bullet_enemy_evolved_acid_spawn"
tt.timed_attacks.list[2] = E:clone_c("bullet_attack")
tt.timed_attacks.list[2].animation = "attack"
tt.timed_attacks.list[2].bullet = "bullet_enemy_evolved_acid"
tt.timed_attacks.list[2].bullet_start_offset = {
	v(5, 50 + tt.flight_height)
}
tt.timed_attacks.list[2].cooldown = b.ranged_attack.cooldown
tt.timed_attacks.list[2].max_range = b.ranged_attack.max_range
tt.timed_attacks.list[2].min_range = b.ranged_attack.min_range
tt.timed_attacks.list[2].shoot_time = fts(11)
tt.timed_attacks.list[2].vis_flags = bor(tt.timed_attacks.list[2].vis_flags, F_AREA, F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(tt.timed_attacks.list[2].vis_bans, F_FLYING)
tt.main_script.insert = scripts.enemy_evolved_acid.insert
tt.main_script.update = scripts.enemy_evolved_acid.update
tt.render.sprites[1].prefix = "evolved_acid_creep"
tt.render.sprites[1].angles.walk = {
	"run",
	"run_back",
	"run_front"
}
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].hidden = false
tt.ui.click_rect = r(-23, -3 + tt.flight_height, 46, 38)
tt.unit.head_offset = v(0, 10)
tt.unit.hit_offset = v(0, 10 + tt.flight_height)
tt.unit.mod_offset = v(0, 7 + tt.flight_height)
tt.unit.marker_offset = v(0, 0)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.can_explode = false
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.vis.bans = bor(F_BLOCK)
tt.sound_events.death = "EnemyEvolvedAcidDeath"
tt.sound_events.death_args = {
	delay = fts(20)
}
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[1].keys = {
	{
		fts(0),
		v(0, 0)
	},
	{
		fts(15),
		v(0, tt.flight_height)
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		fts(0),
		255
	},
	{
		fts(24),
		255
	},
	{
		fts(30),
		0
	}
}
tt.tween.props[2].loop = false
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].disabled = true
tt = RT("enemy_alfa_acid", "enemy_dragons")
b = balance.enemies.dragons.alfa_acid

E:add_comps(tt, "ranged", "timed_attacks", "tween")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(37, 0)
tt.enemy.lives_cost = b.lives_cost
tt.flight_height = 40
tt.fly_strenght = 5
tt.fly_frequency = 13
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 60 + tt.flight_height)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.info.enc_icon = 126
tt.info.portrait = "gui_bottom_info_image_enemies_0135"
tt.main_script.update = scripts.enemy_alfa_acid.update
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].bullet = "bullet_enemy_alfa_acid"
tt.ranged.attacks[1].bullet_start_offset = {
	v(24, 54 + tt.flight_height)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].max_range_variance = b.ranged_attack.max_range_variance
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].hold_advance = b.ranged_attack.hold_advance
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation = "evolve"
tt.timed_attacks.list[1].first_cooldown = b.evolve_shot.first_cooldown
tt.timed_attacks.list[1].cooldown = b.evolve_shot.cooldown
tt.timed_attacks.list[1].max_range = b.evolve_shot.max_range
tt.timed_attacks.list[1].min_range = b.evolve_shot.min_range
tt.timed_attacks.list[1].self_nodes_limit = b.evolve_shot.self_nodes_limit
tt.timed_attacks.list[1].target_nodes_limit = b.evolve_shot.target_nodes_limit
tt.timed_attacks.list[1].min_flight_time = fts(24)
tt.timed_attacks.list[1].max_flight_time = fts(36)
tt.timed_attacks.list[1].node_prediction_base = fts(10)
tt.timed_attacks.list[1].cast_time = fts(26)
tt.timed_attacks.list[1].bullet_start_offset = {
	v(20, 75 + tt.flight_height),
	v(-20, 75 + tt.flight_height)
}
tt.timed_attacks.list[1].bullet = "bullet_enemy_alfa_acid_evolve"
tt.timed_attacks.list[1].mark_mod = "mod_enemy_alfa_acid_evolve_mark"
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_CUSTOM)
tt.timed_attacks.list[1].allowed_templates = {
	"enemy_basic_acid"
}
tt.timed_attacks.list[1].nodes_front_offset = 7
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "alpha_acid_creep"
tt.render.sprites[1].angles.walk = {
	"run",
	"run_back",
	"run_front"
}
tt.render.sprites[1].draw_order = DO_ENEMY_BIG
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "alpha_acid_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].hidden = false
tt.ui.click_rect = r(-32, tt.flight_height, 64, 60)
tt.unit.hit_offset = v(0, 20 + tt.flight_height)
tt.unit.head_offset = v(0, 10)
tt.unit.mod_offset = v(0, 15 + tt.flight_height)
tt.unit.marker_offset = v(0, 0)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.show_blood_pool = false
tt.transformation_time = b.transformation_time
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.vis.bans = bor(tt.vis.bans, F_BLOCK)
tt.sound_events.death = "EnemyAlfaAcidDeath"
tt.sound_events.death_args = {
	delay = fts(21)
}
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
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		fts(0),
		255
	},
	{
		fts(27),
		255
	},
	{
		fts(34),
		0
	}
}
tt.tween.props[2].loop = false
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].disabled = true
tt = RT("enemy_alfa_acid_sheep", "decal_scripted")

E:add_comps(tt, "tween")

b = balance.enemies.dragons.alfa_acid.evolve_shot
tt.main_script.update = scripts.enemy_alfa_acid_sheep.update
tt.range = 30
tt.max_range_retarget = 200
tt.vis_flags_retarget = bor(F_RANGED, F_CUSTOM)
tt.vis_bans_retarget = 0
tt.allowed_templates = {
	"enemy_basic_acid"
}
tt.mod = "mod_enemy_alfa_acid_evolve"
tt.die_ts = b.sheep_ttl
tt.render.sprites[1].prefix = "alpha_acid_sheep"
tt.render.sprites[1].name = "fly_out"
tt.render.sprites[1].offset = v(0, -11)
tt.render.sprites[1].sort_y_offset = -10
tt.tween.props[1].name = "alpha"
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
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].keys = {
	{
		0,
		v(tt.render.sprites[1].offset.x, tt.render.sprites[1].offset.y)
	},
	{
		0.5,
		v(55 + tt.render.sprites[1].offset.x, tt.render.sprites[1].offset.y)
	}
}
tt.tween.remove = true
tt.tween.disabled = true
tt.sheep_sound = "EnemyAlfaAcidEvolverSheep"
tt = RT("enemy_basic_shadow", "enemy_dragons")

E:add_comps(tt, "tween")

b = balance.enemies.dragons.basic_shadow
tt.flight_height = 40
tt.info.enc_icon = 135
tt.info.portrait = "gui_bottom_info_image_enemies_0136"
tt.unit.mod_offset = v(0, 12)
tt.unit.hit_offset = v(0, 15)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.ui.click_rect = r(-16, 0, 32, 28)
tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, 31)
tt.transform_anim_in = "transform_in"
tt.transform_anim_loop = "transform_loop"
tt.transform_anim_loop_times = 1
tt.transform_anim_out = "transform_out"
tt.health.magic_armor = b.magic_armor
tt.main_script.update = scripts.enemy_basic_shadow.update
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "shadow_basic_creep"
tt.render.sprites[1].angles.walk_normal = {
	"walk",
	"walk_back",
	"walk_front"
}
tt.render.sprites[1].angles.walk_shadow = {
	"walk_shadow",
	"walk_shadow_back",
	"walk_shadow_front"
}
tt.render.sprites[1].angles.walk = table.deepclone(tt.render.sprites[1].angles.walk_normal)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].hidden = true
tt.vis.bans = bor(F_BLOCK)
tt.shadow_vis_bans = bor(F_RANGED)
tt.shadow_smoke_ps_dark = "ps_enemy_basic_shadow_trail_dark"
tt.shadow_smoke_ps = "ps_enemy_basic_shadow_trail"
tt.shadow_distance = b.shadow_distance
tt.shadow_distance_to_show = b.shadow_distance_to_show
tt.shadow_speed_mult = b.shadow_speed_mult
tt.shadow_min_duration = 1
tt.shadow_speed_nodes_limit = b.shadow_speed_nodes_limit
tt.evolve_mod = "mod_enemy_alfa_shadow_evolve"
tt.evolve_decal = "decal_enemy_basic_shadow_evolve"
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[1].keys = {
	{
		fts(0),
		v(0, 0)
	},
	{
		fts(25),
		v(0, tt.flight_height)
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 1
tt = RT("enemy_evolved_shadow", "enemy_dragons")

E:add_comps(tt, "ranged")

b = balance.enemies.dragons.evolved_shadow
tt.info.enc_icon = 136
tt.info.portrait = "gui_bottom_info_image_enemies_0137"
tt.enemy.gold = b.gold
tt.enemy.lives_cost = b.lives_cost
tt.flight_height = E:get_template("enemy_basic_shadow").flight_height
tt.health.hp_max = b.hp
tt.health_bar.offset = v(0, tt.flight_height + 50)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.main_script.insert = scripts.enemy_evolved_shadow.insert
tt.main_script.update = scripts.enemy_evolved_shadow.update
tt.motion.max_speed = b.speed
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].prefix = "shadow_evo_creep"
tt.render.sprites[1].angles.walk_normal = {
	"fly",
	"fly_up",
	"fly_down"
}
tt.render.sprites[1].angles.walk_shadow = {
	"fly_shadow",
	"fly_up_shadow",
	"fly_down_shadow"
}
tt.render.sprites[1].angles.walk = table.deepclone(tt.render.sprites[1].angles.walk_normal)
tt.render.sprites[1].angles.idle = table.deepclone(tt.render.sprites[1].angles.walk_normal)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "EnemyPatrollingVultureDeath"
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].bullet = "bullet_enemy_evolved_shadow"
tt.ranged.attacks[1].bullet_start_offset = {
	v(20, 40 + tt.flight_height)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].max_range_variance = b.ranged_attack.max_range_variance
tt.ranged.attacks[1].shoot_time = fts(16)
tt.ranged.attacks[1].hold_advance = b.ranged_attack.hold_advance
tt.ranged.attacks[1].idle_attack_anim = nil
tt.ui.click_rect = r(-18, tt.flight_height + 5, 36, 36)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 15)
tt.unit.head_offset = v(0, 7)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height + 15)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.shadow_vis_bans = bor(F_RANGED)
tt.shadow_smoke_fx = "fx_enemy_evolved_shadow_burst"
tt.shadow_min_duration = 1
tt.sound_events.death = "EnemyShadowEvolvedDeath"
tt.invisibility_safe_nodes = b.invisibility_safe_nodes
tt = RT("enemy_alfa_shadow", "enemy_dragons")

local b = balance.enemies.dragons.alfa_shadow

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.ui.click_rect = r(-23, 0, 46, 60)
tt.enemy.melee_slot = v(35, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health_bar.offset = v(0, 65)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.unit.hit_offset = v(0, 26)
tt.unit.head_offset = v(0, 21)
tt.unit.mod_offset = v(0, 16)
tt.unit.show_blood_pool = false
tt.health.dead_lifetime = fts(126)
tt.motion.max_speed = b.speed
tt.sound_events.death = "Stage11MydriasIllusionDeath"
tt.enemy.gold = b.gold
tt.info.enc_icon = 137
tt.info.portrait = "gui_bottom_info_image_enemies_0138"
tt.main_script.update = scripts.enemy_alfa_shadow.update
tt.melee.range = 72
tt.melee.attacks[1].animation = "mele"
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].hit_fx_offset = v(35, 17)
tt.melee.attacks[1].hit_fx = "fx_enemy_alfa_shadow_hit_melee"
tt.melee.attacks[1].sound = "EnemyShadowAlfaAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(10)
}
tt.ranged.attacks[1].bullet = "bullet_enemy_alfa_shadow"
tt.ranged.attacks[1].bullet_start_offset = {
	v(30, 60)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].shoot_time = fts(22)
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].animation = "ranged"
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation_in_fx = "fx_enemy_alfa_shadow_teleport_in"
tt.timed_attacks.list[1].animation_in = "teleport_in"
tt.timed_attacks.list[1].animation_loop = "teleport_loop"
tt.timed_attacks.list[1].animation_out = "teleport_out"
tt.timed_attacks.list[1].trail = "ps_enemy_alfa_shadow_teleport_trail"
tt.timed_attacks.list[1].speed_mult = 14
tt.timed_attacks.list[1].cast_time = fts(22)
tt.timed_attacks.list[1].first_cooldown = b.evolve_tp.first_cooldown
tt.timed_attacks.list[1].cooldown = b.evolve_tp.cooldown
tt.timed_attacks.list[1].max_nodes_range = b.evolve_tp.max_nodes_range
tt.timed_attacks.list[1].min_nodes_range = b.evolve_tp.min_nodes_range
tt.timed_attacks.list[1].tp_nodes_offset = 7
tt.timed_attacks.list[1].nodes_limit_end = b.evolve_tp.nodes_limit_end
tt.timed_attacks.list[1].nodes_limit_start = b.evolve_tp.nodes_limit_start
tt.timed_attacks.list[1].only_upstream = ({
	[0] = false,
	true
})[b.evolve_tp.only_upstream]
tt.timed_attacks.list[1].allowed_template = "enemy_basic_shadow"
tt.timed_attacks.list[1].mod = "mod_enemy_alfa_shadow_evolve"
tt.timed_attacks.list[1].mod_mark = "mod_enemy_alfa_shadow_evolve_mark"
tt.timed_attacks.list[1].not_while_blocked = b.evolve_tp.not_while_blocked
tt.render.sprites[1].prefix = "shadow_alpha_creep"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk",
	"fly_down",
	"walk_down"
}
tt.render.sprites[1].animated = true
tt.sound_events.death = "EnemyShadowAlfaDeath"
tt = RT("enemy_basic_storm", "enemy_dragons")

E:add_comps(tt, "tween")

b = balance.enemies.dragons.basic_storm
tt.info.enc_icon = 131
tt.info.portrait = "gui_bottom_info_image_enemies_0139"
tt.enemy.gold = b.gold
tt.flight_height = 40
tt.fly_strenght = 0
tt.fly_frequency = 10
tt.enemy.melee_slot = v(41, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 37 + tt.flight_height)
tt.motion.max_speed = b.speed
tt.evolve_mod = "mod_enemy_alfa_storm_evolve"
tt.evolve_sound = "EnemyStormBasicEvolution"
tt.transform_anim_in = "evolve_in"
tt.render.sprites[1].prefix = "basic_storm_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "basic_storm_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.main_script.update = scripts.enemy_basic_storm.update
tt.ui.click_rect = r(-18, tt.flight_height, 36, 32)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 7)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height + 7)
tt.unit.size = UNIT_SIZE_SMALL
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.sound_events.death = "EnemyStormBasicDeath"
tt.sound_events.death_args = {
	delay = fts(15)
}
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
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		0.5,
		255
	},
	{
		0.8,
		0
	}
}
tt.tween.props[2].disabled = true
tt.tween.props[1].loop = true
tt.tween.props[1].disabled = false
tt.tween.props[1].remove = false
tt = RT("enemy_evolved_storm", "enemy_dragons")

E:add_comps(tt, "timed_attacks", "tween")

b = balance.enemies.dragons.evolved_storm
tt.info.enc_icon = 132
tt.info.portrait = "gui_bottom_info_image_enemies_0140"
tt.enemy.gold = b.gold
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.flight_height = 45
tt.health_bar.offset = v(0, tt.flight_height + 44)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.motion.max_speed = b.speed
tt.main_script.insert = scripts.enemy_evolved_storm.insert
tt.main_script.update = scripts.enemy_evolved_storm.update
tt.on_storm_charged = scripts.enemy_evolved_storm.on_storm_charged
tt.on_storm_uncharged = scripts.enemy_evolved_storm.on_storm_uncharged
tt.timed_attacks.list[1] = E:clone_c("area_attack")
tt.timed_attacks.list[1].animation = "attack"
tt.timed_attacks.list[1].cooldown = b.charged_attack.cooldown
tt.timed_attacks.list[1].first_cooldown = b.charged_attack.first_cooldown
tt.timed_attacks.list[1].damage_max = b.charged_attack.damage_max
tt.timed_attacks.list[1].damage_min = b.charged_attack.damage_min
tt.timed_attacks.list[1].damage_type = b.charged_attack.damage_type
tt.timed_attacks.list[1].damage_radius = b.charged_attack.damage_radius
tt.timed_attacks.list[1].hit_time = fts(17)
tt.timed_attacks.list[1].vis_flags = bor(F_AREA)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1].min_targets = b.charged_attack.min_targets
tt.timed_attacks.list[1].removes_charged_status = b.charged_attack.removes_charged_status
tt.timed_attacks.list[1].fx = "fx_enemy_evolved_storm_attack"
tt.render.sprites[1].anchor = vv(0.5)
tt.render.sprites[1].prefix = "storm_evolve_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow_hard"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].scale = vv(1.15)
tt.ui.click_rect = r(-22, tt.flight_height - 10, 44, 40)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, tt.flight_height + 5)
tt.unit.head_offset = v(0, 6)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, tt.flight_height + 5)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.vis.bans = bor(F_BLOCK)
tt.render.sprites[1].scale = vv(1.15)
tt.render.sprites[2].scale = vv(1.15)
tt.sound_events.death = "EnemyStormBasicDeath"
tt.sound_events.death_args = {
	delay = fts(17)
}
tt.tween.props[1].name = "alpha"
tt.tween.props[1].sprite_id = 2
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.7,
		255
	},
	{
		0.9,
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].remove = false
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.loop = false
tt = RT("enemy_alfa_storm", "enemy_dragons")

local b = balance.enemies.dragons.alfa_storm

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(35, 0)
tt.health.hp_max = b.hp
tt.health.magic_armor = b.magic_armor
tt.health.armor = b.armor
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.unit.hit_offset = v(0, 13)
tt.unit.head_offset = v(0, 16)
tt.unit.mod_offset = v(0, 10)
tt.unit.show_blood_pool = false
tt.health.dead_lifetime = 7
tt.ui.click_rect = r(-18, -3, 36, 40)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "alpha_storm_creep"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"run",
	"run_back",
	"run_front"
}
tt.sound_events.death = "EnemyStormAlfaDeath"
tt.sound_events.death_args = {
	delay = fts(9)
}
tt.info.enc_icon = 133
tt.info.portrait = "gui_bottom_info_image_enemies_0141"
tt.main_script.update = scripts.enemy_alfa_storm.update
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt.melee.attacks[1].cooldown = b.melee_attack.cooldown
tt.melee.attacks[1].damage_max = b.melee_attack.damage_max
tt.melee.attacks[1].damage_min = b.melee_attack.damage_min
tt.melee.attacks[1].hit_time = fts(16)
tt.melee.attacks[1].animation = "basic_attack"
tt.melee.attacks[1].sound_hit = "EnemyStormAlfaMelee"
tt.ranged.attacks[1].bullet = "bullet_enemy_alfa_storm"
tt.ranged.attacks[1].bullet_start_offset = {
	v(38, 53)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].shoot_time = fts(21)
tt.ranged.attacks[1].animation = "spell"
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation_start = "stun_tower"
tt.timed_attacks.list[1].cast_time = fts(87)
tt.timed_attacks.list[1].cooldown = b.special_attack.cooldown
tt.timed_attacks.list[1].max_range = b.special_attack.radius
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].allowed_templates = {
	"enemy_evolved_storm",
	"enemy_executioner_storm",
	"enemy_brute_storm"
}
tt.timed_attacks.list[1].towers_mod = "mod_enemy_alfa_storm_tower_stun"
tt.timed_attacks.list[1].towers_mod_mark = "mod_enemy_alfa_storm_tower_mark"
tt.timed_attacks.list[1].max_towers_stunned = b.special_attack.max_towers_stunned
tt.timed_attacks.list[1].min_towers_target = b.special_attack.min_towers_target
tt.timed_attacks.list[1].vis_flags = F_MOD
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[2] = E:clone_c("bullet_attack")
tt.timed_attacks.list[2].animation_start = "evolve_in"
tt.timed_attacks.list[2].animation_loop = "evolve_loop"
tt.timed_attacks.list[2].animation_end = "evolve_out"
tt.timed_attacks.list[2].animation_cancelled = "evolve_bloq"
tt.timed_attacks.list[2].loop_times = b.evolve_attack.loop_times
tt.timed_attacks.list[2].first_cooldown = b.evolve_attack.first_cooldown
tt.timed_attacks.list[2].cooldown = b.evolve_attack.cooldown
tt.timed_attacks.list[2].max_range = b.evolve_attack.max_range
tt.timed_attacks.list[2].min_range = b.evolve_attack.min_range
tt.timed_attacks.list[2].max_casts = b.evolve_attack.max_casts
tt.timed_attacks.list[2].nodes_limit = b.evolve_attack.nodes_limit
tt.timed_attacks.list[2].mod = "mod_enemy_alfa_storm_evolve"
tt.timed_attacks.list[2].fx = "fx_enemy_alfa_storm_evolve_ray"
tt.timed_attacks.list[2].allowed_templates = {
	"enemy_basic_storm"
}
tt.timed_attacks.list[2].vis_flags = F_MOD
tt.timed_attacks.list[2].vis_bans = 0
tt.timed_attacks.list[2].max_count = b.evolve_attack.max_count
b = balance.enemies.dragons.executioner_storm
tt = RT("enemy_executioner_storm", "enemy_dragons")

E:add_comps(tt, "melee", "timed_attacks")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.health.dead_lifetime = 1.3
tt.unit.size = UNIT_SIZE_MEDIUM
tt.info.enc_icon = 134
tt.info.portrait = "gui_bottom_info_image_enemies_0142"
tt.unit.hit_offset = v(0, 23)
tt.unit.head_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.main_script.update = scripts.enemy_executioner_storm.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].sound = "EnemyKillertileMelee"
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].animation = "attk_melee"
tt.timed_attacks.list[1] = E:clone_c("custom_attack")
tt.timed_attacks.list[1].animation_in = "attk_charged_in"
tt.timed_attacks.list[1].animation_out = "attk_charged_out"
tt.timed_attacks.list[1].cooldown = b.charged_instakill.cooldown
tt.timed_attacks.list[1].first_cooldown = b.charged_instakill.first_cooldown
tt.timed_attacks.list[1].nodes_limit = b.charged_instakill.nodes_limit
tt.timed_attacks.list[1].damage_max = 1
tt.timed_attacks.list[1].damage_min = 1
tt.timed_attacks.list[1].damage_type = DAMAGE_INSTAKILL
tt.timed_attacks.list[1].vis_bans = bor(F_HERO)
tt.timed_attacks.list[1].vis_flags = F_INSTAKILL
tt.timed_attacks.list[1].hit_time = fts(3)
tt.timed_attacks.list[1].removes_charged_status = b.charged_instakill.removes_charged_status
tt.timed_attacks.list[1].hp_threshold = b.charged_instakill.hp_threshold
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "storm_executor_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk_up",
	"walk_down"
}
tt.ui.click_rect = r(-23, 0, 46, 45)
tt.sound_events.death = "EnemyStormExecuthosDeath"
tt.unit.fade_time_after_death = fts(100)
tt.health.dead_lifetime = fts(100)
b = balance.enemies.dragons.brute_storm
tt = RT("enemy_brute_storm", "enemy_dragons")

E:add_comps(tt, "melee")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(42, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 60)
tt.info.enc_icon = 62
tt.info.portrait = "gui_bottom_info_image_enemies_0062"
tt.unit.hit_offset = v(0, 20)
tt.unit.head_offset = v(0, 50)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 17)
tt.main_script.update = scripts.enemy_brute_storm.update
tt.on_storm_charged = scripts.enemy_brute_storm.on_storm_charged
tt.on_storm_uncharged = scripts.enemy_brute_storm.on_storm_uncharged
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.attacks[1].animation = "attack_2"
tt.melee.attacks[1].hit_fx = "fx_crocs_tank_melee_hit"
tt.melee.attacks[1].hit_offset = v(44, 15)
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "Tank_crocs_animationsDef"
tt.render.sprites[1].angles.idle = {
	"idle",
	"idle",
	"idle"
}
tt.render.sprites[1].angles.walk = {
	"walk_side",
	"walk_up",
	"walk_down"
}
tt.render.sprites[1].angles.charge = {
	"attack_1",
	"attack_1",
	"attack_1"
}
tt.render.sprites[1].angles_custom = {
	charge = {
		55,
		115,
		245,
		305
	}
}
tt.render.sprites[1].exo = true
tt.render.sprites[1].offset = v(-2, 0)
tt.ui.click_rect = r(-30, -3, 60, 50)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.can_explode = false
tt.unit.can_explode = false
tt.vis.flags = bor(F_ENEMY)
tt.sound_events.death = "EnemyRazingRhinoDeath"
tt.mod_invulneravility = "mod_enemy_brute_storm_invulnerability"
tt = RT("enemy_miniboss_stage_39", "enemy_KR5")
b = balance.enemies.dragons.miniboss_stage_39

E:add_comps(tt, "melee", "timed_attacks", "regen")

tt.enemy.gold = b.gold
tt.enemy.melee_slot = v(41, 0)
tt.enemy.lives_cost = b.lives_cost
tt.health.hp_max = b.hp
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health_bar.offset = v(0, 100)
tt.regen.cooldown = b.regen_cooldown
tt.regen.health = b.regen_health
tt.info.enc_icon = 139
tt.info.portrait = "gui_bottom_info_image_enemies_0144"
tt.unit.hit_offset = v(0, 35)
tt.unit.head_offset = v(0, 35)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 33)
tt.main_script.insert = scripts.enemy_miniboss_stage_39.insert
tt.main_script.update = scripts.enemy_miniboss_stage_39.update
tt.melee.attacks[1].cooldown = b.basic_attack.cooldown
tt.melee.attacks[1].damage_max = b.basic_attack.damage_max
tt.melee.attacks[1].damage_min = b.basic_attack.damage_min
tt.melee.attacks[1].damage_type = b.basic_attack.damage_type
tt.melee.attacks[1].damage_radius = b.basic_attack.damage_radius
tt.melee.attacks[1].animations = {
	"mele_1",
	"mele_2"
}
tt.melee.attacks[1].animation = "mele_1"
tt.melee.attacks[1].hit_offset = v(50, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].type = "area"
tt.melee.attacks[1].vis_bans = bor(F_FLYING)
tt.melee.attacks[1].vis_flags = bor(F_RANGED)
tt.melee.attacks[1].damage_bans = bor(F_FLYING)
tt.melee.attacks[1].damage_flags = bor(F_AREA)
tt.melee.attacks[1].sound = "EnemyRazingRhinoBasicAttack"
tt.melee.attacks[1].hit_fx = "fx_miniboss_stage_39_hit"
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].animation = "instakill"
tt.melee.attacks[2].cooldown = b.instakill.cooldown
tt.melee.attacks[2].damage_max = b.instakill.damage_max
tt.melee.attacks[2].damage_min = b.instakill.damage_min
tt.melee.attacks[2].damage_type = bor(b.instakill.damage_type)
tt.melee.attacks[2].damage_radius = b.instakill.damage_radius
tt.melee.attacks[2].hit_time = fts(20)
tt.melee.attacks[2].type = "area"
tt.melee.attacks[2].vis_bans = bor(F_HERO, F_FLYING)
tt.melee.attacks[2].vis_flags = bor(F_INSTAKILL, F_RANGED)
tt.melee.attacks[2].damage_bans = bor(F_HERO, F_FLYING)
tt.melee.attacks[2].damage_flags = bor(F_INSTAKILL, F_AREA)
tt.melee.attacks[2].hit_offset = v(50, 0)
tt.melee.attacks[2].sound = "Stage39MinibossInstakill"
tt.melee.attacks[2].mod = "mod_enemy_miniboss_stage_39_instakill"
tt.motion.max_speed = b.speed
tt.render.sprites[1].prefix = "mini_boss_creep"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walk",
	"walk_down"
}
tt.ui.click_rect = r(-30, -3, 60, 65)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.can_explode = false
tt.unit.can_explode = false
tt.vis.flags = bor(F_ENEMY, F_MINIBOSS)
tt.vis.bans = bor(F_TELEPORT)
tt.sound_events.death = "Stage39MinibossDeath"
tt.health.dead_lifetime = 3
tt = RT("mod_enemy_miniboss_stage_39_instakill", "modifier")
tt.main_script.insert = scripts.mod_enemy_miniboss_stage_39_instakill.insert
tt = RT("bullet_stage_37_dragons_wardens", "bolt")

E:add_comps(tt, "force_motion")

tt.main_script.update = scripts.bullet_stage_37_dragons_wardens.update
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
b = balance.specials.towers.tower_dragons_warden
tt.render.sprites[1].prefix = "warden_warlock_projectil"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor = v(0.4888888888888889, 0.5344827586206896)
tt.bullet.damage_min = b.basic_attack.damage_min
tt.bullet.damage_max = b.basic_attack.damage_max
tt.bullet.damage_type = b.basic_attack.damage_type
tt.bullet.hit_fx = "fx_bullet_tower_dragons_wardens_hit"
tt.bullet.particles_name = "ps_bullet_tower_stage_37_dragons_wardens_trail"
tt.bullet.align_with_trajectory = true
tt.initial_impulse = 600
tt.initial_impulse_reduction = 0.99
tt.initial_impulse_duration = 5
tt.initial_impulse_angle_abs = math.pi / 2
tt.force_motion.a_step = 25
tt.force_motion.max_a = 7500
tt.force_motion.max_v = 450
tt.sound_events.insert = "DragonsDLCMageWardensShoot"
tt = RT("bullet_stage_40_island_wardens", "bolt")

E:add_comps(tt, "force_motion")

tt.main_script.update = scripts.bullet_stage_37_dragons_wardens.update
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
b = balance.specials.stage_40_moving_island.soldiers.ranged
tt.render.sprites[1].prefix = "warden_warlock_projectil"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor = v(0.4888888888888889, 0.5344827586206896)
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt.bullet.hit_fx = "fx_bullet_tower_dragons_wardens_hit"
tt.bullet.particles_name = "ps_bullet_tower_stage_37_dragons_wardens_trail"
tt.bullet.align_with_trajectory = true
tt.initial_impulse = 600
tt.initial_impulse_reduction = 0.99
tt.initial_impulse_duration = 5
tt.initial_impulse_angle_abs = math.pi / 2
tt.force_motion.a_step = 25
tt.force_motion.max_a = 7500
tt.force_motion.max_v = 450
tt.sound_events.insert = "DragonsDLCMageWardensShoot"
tt = RT("bullet_stage_40_island_wardens_melee", "bolt")
b = balance.specials.stage_40_moving_island.soldiers.ranged
tt.main_script.queue = scripts.bullet_soldier_dragon_warden_dragon_raider.queue
tt.aura = {}
tt.render.sprites[1].prefix = "warden_warlock_stage3_projectil"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor = v(0.4888888888888889, 0.5344827586206896)
tt.bullet_start_offset = v(12, 35)
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt.bullet.hit_fx = "fx_bullet_soldier_dragon_warden_dragon_raider_hit"
tt.bullet.particles_name = "ps_bullet_soldier_dragon_warden_dragon_raider_trail"
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "DragonsDLCMageWardensShoot"
tt = RT("bullet_stage_40_island_wardens_reinforcement", "bullet_stage_40_island_wardens")
b = balance.specials.stage_40_warden_reinforcements.mage.ranged
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt = RT("bullet_stage_40_island_wardens_melee_reinforcement", "bullet_stage_40_island_wardens_melee")
b = balance.specials.stage_40_warden_reinforcements.mage.ranged
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt = RT("bullet_enemy_basic_acid", "arrow5")

local b = balance.enemies.dragons.basic_acid.ranged_attack

tt.render.sprites[1].prefix = "acid_basic_proyectil"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_type = b.damage_type
tt.bullet.flight_time = fts(25)
tt.bullet.hit_fx = "fx_bullet_enemy_basic_acid"
tt.bullet.hit_decal = nil
tt.bullet.particles_name = "ps_bullet_enemy_basic_acid"
tt.bullet.align_with_trajectory = true
tt.bullet.damage_bans = bor(F_ENEMY)
tt.bullet.hit_blood_fx = nil
tt.bullet.miss_decal = nil
tt.bullet.miss_fx_water = nil
tt = RT("bullet_enemy_evolved_acid", "bombKR5")

local b = balance.enemies.dragons.evolved_acid.ranged_attack

tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.radius
tt.bullet.damage_type = b.damage_type
tt.bullet.flight_time = fts(25)
tt.bullet.hit_fx = "fx_enemy_evolved_acid_hit"
tt.bullet.hit_decal = "decal_enemy_evolved_acid_bullet"
tt.bullet.particles_name = "ps_bullet_enemy_evolved_acid"
tt.bullet.align_with_trajectory = true
tt.vis_flags = bor(F_AREA)
tt.vis_bans = bor(F_FLYING, F_ENEMY)
tt.main_script.insert = scripts.bullet_enemy_evolved_acid.insert
tt.main_script.update = scripts.bullet_enemy_evolved_acid.update
tt.render.sprites[1].prefix = "evolved_acid_projectile2"
tt.render.sprites[1].name = "flying"
tt.render.sprites[1].animated = true
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.sound_events.hit = "EnemyEvolvedAcidAttack"
tt = RT("bullet_enemy_evolved_acid_spawn", "bombKR5")

local b = balance.enemies.dragons.evolved_acid.ranged_attack

tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 0
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = fts(27)
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.align_with_trajectory = false
tt.bullet.hit_payload = "enemy_basic_acid"
tt.vis_flags = bor(F_AREA)
tt.vis_bans = bor(F_FLYING, F_ENEMY)
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.bullet_enemy_evolved_acid_spawn.update
tt.render.sprites[1].name = "evolved_acid_projectil"
tt.render.sprites[1].animated = false
tt = RT("bullet_enemy_alfa_acid", "bolt_enemy")

local b = balance.enemies.dragons.alfa_acid.ranged_attack

tt.main_script.insert = scripts.bullet_enemy_alfa_acid.insert
tt.main_script.update = nil
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_type = b.damage_type
tt.bullets_templates = {
	"bullet_enemy_alfa_acid_a",
	"bullet_enemy_alfa_acid_b",
	"bullet_enemy_alfa_acid_c"
}
tt.sound_events.insert = "EnemyAlfaAcidAttack"
tt = RT("bullet_enemy_alfa_acid_a", "bolt_enemy")

E:add_comps(tt, "force_motion")

local b = balance.enemies.dragons.alfa_acid.ranged_attack

tt.render.sprites[1].prefix = "alpha_acid_projectile2"
tt.render.sprites[1].name = "flying"
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = vv(0.6)
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
tt.main_script.update = scripts.bolt_force_motion_kr5.update
tt.bullet.mod = "mod_enemy_alfa_acid_poison"
tt.bullet.damage_max = b.damage_max / 3
tt.bullet.damage_min = b.damage_min / 3
tt.bullet.damage_type = b.damage_type
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.2
tt.bullet.min_speed = 120
tt.bullet.max_speed = 1200
tt.bullet.align_with_trajectory = true
tt.bullet.hit_fx = "fx_bullet_enemy_alfa_acid"
tt.bullet.particles_name = "ps_bullet_enemy_alfa_acid"
tt.initial_impulse = 13500
tt.initial_impulse_duration = 0.15
tt.initial_impulse_angle_abs = math.pi / 2
tt.initial_impulse_reduction = 0.7
tt.force_motion.a_step = 10
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 600
tt.sound_events.insert = nil
tt = RT("bullet_enemy_alfa_acid_b", "bullet_enemy_alfa_acid_a")
tt.initial_impulse = 7500
tt.initial_impulse_duration = 0.12
tt.initial_impulse_angle_abs = tt.initial_impulse_angle_abs * 1.2
tt.initial_impulse_reduction = 0.7
tt.force_motion.max_v = tt.force_motion.max_v * 0.9
tt = RT("bullet_enemy_alfa_acid_c", "bullet_enemy_alfa_acid_a")
tt.initial_impulse = 9750
tt.initial_impulse_duration = 0.2
tt.initial_impulse_angle_abs = tt.initial_impulse_angle_abs * 0.7
tt.initial_impulse_reduction = 0.7
tt.force_motion.max_v = tt.force_motion.max_v * 1.1
tt = RT("bullet_enemy_alfa_acid_evolve", "bullet")

local b = balance.enemies.dragons.alfa_acid.evolve_shot

tt.main_script.insert = scripts.bullet_enemy_alfa_acid_evolve.insert
tt.main_script.update = scripts.bullet_enemy_alfa_acid_evolve.update
tt.render.sprites[1].name = "alpha_acid_sheep_projectile"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5056818181818182, 0.5988372093023255)
tt.bullet.align_with_trajectory = true
tt.bullet.hit_ts_offset = fts(7)
tt.bullet.hide_radius = nil
tt.bullet.hide_radius_start = 0
tt.bullet.hide_radius_end = 4
tt.bullet.flight_time = nil
tt.bullet.g = -1.2 / (fts(1) * fts(1))
tt.bullet.hit_fx = "fx_bullet_enemy_alfa_acid_evolve_hit"
tt.bullet.hit_blood_fx = nil
tt.sheep = "enemy_alfa_acid_sheep"
tt.sound_events.insert = "EnemyAlfaAcidEvolverSpit"
tt = RT("bullet_enemy_evolved_shadow", "bolt_enemy")

E:add_comps(tt, "force_motion")

b = balance.enemies.dragons.evolved_shadow.ranged_attack
tt.render.sprites[1].prefix = "shadow_evo_projectile"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_type = b.damage_type
tt.bullet.particles_name = "ps_enemy_evolved_shadow_bullet_trail"
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 30
tt.bullet.max_speed = 300
tt.bullet.align_with_trajectory = true
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
tt.main_script.update = scripts.bolt_force_motion_kr5.update
tt.target_soldiers = true
tt.initial_impulse = 3000
tt.initial_impulse_duration = 0.1
tt.initial_impulse_angle = d2r(110)
tt.force_motion.a_step = 5
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 600
tt.bullet.hit_fx = "fx_enemy_evolved_shadow_bullet_hit"
tt.sound_events.insert = "EnemyShadowEvolvedAttack"
tt = RT("bullet_enemy_alfa_shadow", "bolt_enemy")

E:add_comps(tt, "force_motion")

b = balance.enemies.dragons.alfa_shadow.ranged_attack
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.render.sprites[1].prefix = "shadow_alpha_proyectile"
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = vv(0.8)
tt.bullet.hit_fx = "fx_stage_11_cult_leader_attack_hit"
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.acceleration_factor = 0.5
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.max_speed = 360
tt.bullet.particles_name = "ps_bullet_stage_11_cult_leader"
tt.bullet.damage_type = b.damage_type
tt.bullet.align_with_trajectory = true
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
tt.main_script.update = scripts.bolt_force_motion_kr5.update
tt.target_soldiers = true
tt.initial_impulse = 3000
tt.initial_impulse_duration = 0.1
tt.initial_impulse_angle = d2r(110)
tt.force_motion.a_step = 5
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 600
tt.sound_events.insert = "EnemyShadowAlfaRangedAttack"
tt = RT("bullet_enemy_alfa_storm", "bullet")

local b = balance.enemies.dragons.alfa_storm.ranged_attack

tt.main_script.update = scripts.ray5_simple.update
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.render.sprites[1].name = "alpha_storm_projectil"
tt.bullet.hit_fx = "fx_bullet_enemy_alfa_storm"
tt.bullet.hit_fx_ignore_hit_offset = true
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_type = b.damage_type
tt.image_width = 152.5
tt.bullet.hit_time = fts(1)
tt.ray_duration = fts(8)
tt.sound_events.insert = "EnemyStormAlfaRanged"
tt = RT("bullet_hero_dragon_sun_breath_ray", "bullet")

E:add_comps(tt, "nav_path", "motion")

b = balance.heroes.hero_dragon_sun.basic_attack
tt.render.sprites[1].z = Z_FLYING_HEROES - 1
tt.render.sprites[1].prefix = "hero_aurion_ray"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].loop = false
tt.end_fire_offset_per_angle = -0.25
tt.image_width = 137.5
tt.hit_delay = fts(4)
tt.ray_duration = fts(19)
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.damage_radius
tt.bullet.xp_gain_factor = b.xp_gain_factor
tt.damage_every = b.damage_every
tt.bullet.mod = {
	"mod_hero_dragon_sun_bassic_attack_burn_dps"
}
tt.motion.max_speed = b.speed
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = 0
tt.main_script.update = scripts.bullet_hero_dragon_sun_breath_ray.update
tt.decal = "decal_bullet_hero_dragon_sun_breath_ray"
tt.fire_fx = "fx_hero_dragon_sun_basic_ray_back_fire"
tt.sound_events.insert = "HeroDragonSunBreathAttack"
tt = RT("bullet_hero_dragon_sun_breath_ray_overcharged", "bullet_hero_dragon_sun_breath_ray")
tt.render.sprites[1].prefix = "hero_aurion_ray_2"
tt = RT("bullet_hero_dragon_sun_breath_flier", "bullet")
b = balance.heroes.hero_dragon_sun.basic_attack.flier
tt.render.sprites[1].z = Z_FLYING_HEROES - 1
tt.render.sprites[1].prefix = "hero_aurion_ray"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "run"
tt.render.sprites[1].loop = false
tt.image_width = 125
tt.hit_delay = fts(4)
tt.bullet.hit_time = fts(5)
tt.ray_duration = fts(19)
tt.track_target = true
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.damage_radius
tt.bullet.xp_gain_factor = b.xp_gain_factor
tt.bullet.mod = "mod_hero_dragon_sun_bassic_attack_burn_only_render"
tt.main_script.update = scripts.bullet_hero_dragon_sun_breath_flier.update
tt.sound_events.insert = "HeroDragonSunBreathAttack"
tt = RT("bullet_hero_dragon_sun_breath_flier_overcharged", "bullet_hero_dragon_sun_breath_flier")
tt.render.sprites[1].color = {
	255,
	200,
	200,
	255
}
tt.render.sprites[1].scale = v(1, 1.5)
tt.bullet.mod = "mod_hero_dragon_sun_bassic_attack_burn_only_render_overcharged"
tt = RT("bullet_hero_dragon_sun_ultimate", "bullet")

E:add_comps(tt, "nav_path", "motion", "tween")

b = balance.heroes.hero_dragon_sun.ultimate
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -30
tt.render.sprites[1].prefix = "hero_aurion_ulti"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "in"
tt.render.sprites[1].loop = false
tt.render.sprites[1].scale = v(2, 3)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "hero_aurion_fire_base_ulti_run"
tt.render.sprites[2].ignore_start = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].hidden = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].scale = vv(2)
tt.render.sprites[2].offset = v(0, -30)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y_offset = -30
tt.image_width = 146.25
tt.hit_delay = fts(1)
tt.ray_duration = b.duration
tt.initial_damage_factor = b.initial_damage_factor
tt.final_damage_factor = b.final_damage_factor
tt.nav_path.dir = -1
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = b.damage_radius
tt.damage_every = b.damage_every
tt.motion.max_speed = b.speed
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = 0
tt.main_script.update = scripts.bullet_hero_dragon_sun_ultimate.update
tt.fx_in = "fx_hero_dragon_sun_ultimate_in"
tt.decal_in = "decal_bullet_hero_dragon_sun_ultimate_base"
tt.decal = "decal_bullet_hero_dragon_sun_ultimate"
tt.decal_2 = "decal_bullet_hero_dragon_sun_ultimate_2"
tt.fire_fx = "fx_hero_dragon_sun_ultimate_back_fire"
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.25,
		0
	}
}
tt.tween.props[1].sprite_id = 2
tt.sound_events.insert = "HeroDragonSunUltimateBegin"
tt.sound_loop = "HeroDragonSunUltimateLoop"
tt.sound_end = "HeroDragonSunUltimateEnd"
tt = RT("bullet_soldier_dragon_warden_dragon_raider_mounted", "bolt")

E:add_comps(tt, "force_motion")

tt.main_script.update = scripts.bullet_stage_37_dragons_wardens.update
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
b = balance.specials.stage_38_dragon_wardens.soldiers.dragon_raider_mounted.ranged
tt.bullet.damage_type = b.damage_type
tt.bullet.hit_fx = "fx_bullet_soldier_dragon_warden_dragon_raider_hit"
tt.bullet.particles_name = "ps_bullet_soldier_dragon_warden_dragon_raider_trail"
tt.bullet.max_speed = 600
tt.bullet.min_speed = 600
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_type = b.damage_type
tt.bullet.align_with_trajectory = true
tt.bullet.use_unit_damage_factor = true
tt.bullet.pop_chance = 0
tt.initial_impulse = 600
tt.initial_impulse_reduction = 0.99
tt.initial_impulse_duration = 5
tt.initial_impulse_angle_abs = math.pi / 2
tt.force_motion.a_step = 25
tt.force_motion.max_a = 7500
tt.force_motion.max_v = 450
tt.render.sprites[1].prefix = "warden_warlock_stage3_projectil"
tt.render.sprites[1].name = "flying"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor = v(0.4888888888888889, 0.5344827586206896)
tt.sound_events.insert = "DragonsDLCMageWardensShoot"
tt = RT("bullet_hero_dragon_sun_solar_stone", "bombKR5")
b = balance.heroes.hero_dragon_sun.solar_stones
tt.bullet.flight_time = fts(25)
tt.bullet.align_with_trajectory = true
tt.bullet.ignore_hit_offset = true
tt.bullet.rotation_speed = nil
tt.bullet.hit_payload = "aura_bullet_hero_dragon_sun_solar_stones_mine"
tt.bullet.hit_decal = nil
tt.bullet.hit_fx = nil
tt.bullet.pop_chance = 0
tt.main_script.insert = scripts.bullet_hero_dragon_sun_solar_stone.insert
tt.main_script.update = scripts.bullet_hero_dragon_sun_solar_stone.update
tt.sound_events.insert = "HeroDragonSunStonesShot"
tt.sound_events.hit = nil
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "hero_aurion_projectil_skil_solar_stone_in"
tt.particles_name = "ps_bullet_hero_dragon_sun_solar_stone"
tt = RT("bullet_alfa_lava_vomit", "bombKR5")
tt.main_script.update = scripts.bullet_alfa_lava_vomit.update
tt.render.sprites[1].prefix = "lava_alpha_proyectil"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.bullet.particles_name = "ps_bullet_alfa_lava_vomit"
tt.bullet.flight_time = fts(30)
tt.bullet.align_with_trajectory = true
tt.bullet.ignore_hit_offset = true
tt.bullet.hit_decal = "decal_enemy_alfa_lava_dot"
tt.bullet.hit_fx = nil
tt.bullet.pop_chance = 0
tt.sound_events.insert = nil
tt.sound_events.hit = nil
tt = RT("bolt_boss_murglum", "bolt_enemy")
b = balance.enemies.dragons.dragon_boss_stage_37.basic_attack
tt.bullet.damage_type = b.damage_type
tt.bullet.particles_name = "ps_bullet_murglum_geiser_bossfight"
tt.bullet.align_with_trajectory = true
tt.bullet.ignore_hit_offset = true
tt.bullet.max_speed = 600
tt.bullet.min_speed = 600
tt.bullet.pop_chance = 0
tt.bullet.damage_type = b.damage_type
tt.bullet.damage_max = b.damage_max
tt.bullet.damage_min = b.damage_min
tt.bullet.damage_radius = b.damage_radius
tt.bullet.hit_decal = "decal_boss_murglum_geiser_bossfight"
tt.bullet.hit_fx = "fx_boss_murglum_geiser_lava"
tt.render.sprites[1].prefix = "boss_murglun_proyectil_basic"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.4166666666666667, 0.5263157894736842)
tt.render.sprites[1].z = Z_BULLETS
tt.main_script.update = scripts.bolt_boss_murglum_attack.update
tt.sound_events.insert = "Stage37MurglunAttack"
tt = RT("bullet_tower_dragons_dragon_split", "bolt")

E:add_comps(tt, "force_motion")

tt.render.sprites[1].prefix = "dlc_dragons_tower_projectil_skill_shoot"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor = vv(0.5)
tt.bullet.align_with_trajectory = true
tt.main_script.update = scripts.bullet_tower_dragons_dragon_split.update
tt.main_script.insert = scripts.bolt_force_motion_kr5.insert
tt.bullet.hit_fx = "fx_bullet_tower_dragons_dragon_split_hit"
tt.bullet.hit_decal = "decal_bullet_tower_dragons_dragon_split"
tt.bullet.particles_name = "ps_bullet_tower_dragons_dragon_split_trail"
tt.bullet.max_track_distance = tt.bullet.max_track_distance * 1.5
tt.initial_impulse = 4500
tt.initial_impulse_duration = 0.1
tt.initial_impulse_angle_abs = math.pi / 2
tt.force_motion.a_step = 10
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 450
tt.sound_events.insert = "TowerDragonsSpitOut"
tt = RT("bullet_boss_stage_37_geisers_bossfight", "bolt")
tt.main_script.update = scripts.bullet_boss_stage_37_geisers_bossfight.update
tt.render.sprites[1].prefix = "boss_murglun_proyectil_basic"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.bullet.hit_blood_fx = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 360
tt.bullet.max_speed = 480
tt.bullet.ignore_rotation = false
tt.bullet.align_with_trajectory = true
tt.bullet.hit_decal = "decal_boss_murglum_geiser_bossfight"
tt.bullet.hit_fx = "fx_boss_murglum_geiser_lava"
tt.bullet.particles_name = "ps_bullet_murglum_geiser_bossfight"
tt.sound_events.insert = "Stage37MurglunAttack"
tt = RT("ps_bullet_murglum_geiser_bossfight")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "boss_murglun_trail_basic_attack_run"
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
tt = RT("bullet_boss_stage_37_geisers_waves_campaign", "bullet_boss_stage_37_geisers_bossfight")
tt.bullet.hit_decal = "decal_boss_murglum_geiser_waves_campaign"
tt = RT("aura_enemy_alfa_lava_dot", "aura")
b = balance.enemies.dragons.alfa_lava.lava_vomit_attack
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.duration = -1
tt.aura.mod = "mod_enemy_alfa_lava_dot"
tt.aura.radius = b.lava_radius
tt.aura.cycle_time = 0.1
tt.aura.vis_bans = bor(F_FLYING, F_ENEMY)
tt = RT("aura_hero_dragon_sun_healing", "aura")
b = balance.heroes.hero_dragon_sun.solar_cleansing
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_hero_dragon_sun_healing.update
tt.aura.duration = nil
tt.aura.vis_flags = bor(tt.aura.vis_flags, F_MOD, F_AREA)
tt.aura.vis_bans = bor(tt.aura.vis_bans, F_ENEMY)
tt.aura.mod = "mod_hero_dragon_sun_heal"
tt.aura.radius = b.radius
tt.aura.cycle_time = b.heal_every / 4
tt.heal_fx = "fx_hero_dragon_sun_heal_particle"
tt = RT("aura_bullet_hero_dragon_sun_solar_stones_mine", "aura")
b = balance.heroes.hero_dragon_sun.solar_stones

E:add_comps(tt, "render", "tween")

tt.aura.radius = b.damage_radius
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans_trigger = 0
tt.aura.vis_bans_damage = 0
tt.aura.cycle_time = fts(5)
tt.aura.duration = b.mines_duration
tt.render.sprites[1].prefix = "hero_aurion_decal_skil_solar_stone"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].loop = false
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "hero_aurion_object_skil_solar_stone_activate_loop"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].loop = true
tt.render.sprites[2].hidden = true
tt.main_script.insert = scripts.aura_bullet_hero_dragon_sun_solar_stones_mine.insert
tt.main_script.update = scripts.aura_bullet_hero_dragon_sun_solar_stones_mine.update
tt.spawn_fx = "fx_hero_dragon_sun_solar_stones_mine_spawn"
tt.explosion_fx = "fx_hero_dragon_sun_solar_stones_mine_explosion"
tt.explosion_decal = "decal_bullet_hero_dragon_sun_breath_ray"
tt.sound_explode = "HeroMechaMineDropExplosion"
tt.damage_type = b.damage_type
tt.time_to_activate = b.time_to_activate
tt.tween.props[1] = E:clone_c("tween_prop")
tt.tween.props[1].name = "alpha"
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
tt.tween.props[1].sprite_id = 2
tt.tween.disabled = true
tt.tween.remove = true
tt.sound_events.insert = "HeroDragonSunStonesDrop"
tt.sound_armed = "HeroDragonSunStonesArmed"
tt.sound_explotion = "HeroDragonSunStonesExplosion"
tt = RT("aura_boss_37_geiser_decal_dmg_bossfight", "aura")
b = balance.enemies.dragons.dragon_boss_stage_37.geisers_bossfight
tt.main_script.update = scripts.aura_apply_damage.update
tt.aura.duration = -1
tt.aura.radius = 55
tt.aura.vis_bans = bor(F_FLYING, F_ENEMY)
tt.aura.damage_min = b.min_damage
tt.aura.damage_max = b.max_damage
tt.aura.damage_type = b.damage_type
tt.aura.cycle_time = b.damage_every
tt = RT("aura_boss_37_geiser_decal_dmg_campaign", "aura_boss_37_geiser_decal_dmg_bossfight")
b = balance.enemies.dragons.dragon_boss_stage_37.campaign
tt.aura.damage_min = b.area_attack_damage_min
tt.aura.damage_max = b.area_attack_damage_max
tt.aura.damage_type = b.area_attack_damage_type
tt.aura.cycle_time = b.area_attack_damage_every
tt = RT("mod_stage_36_portal_splash", "mod_stage_32_lava_splash")
tt.main_script.insert = scripts.mod_stage_36_portal_splash.insert
tt.main_script.update = scripts.mod_stage_36_portal_splash.update
tt.main_script.remove = scripts.mod_stage_36_portal_splash.remove
tt.modifier.duration = 1e+99
tt.coords_portal = {
	v(991, 536),
	v(1100, 500)
}
tt.fx_wait_ts = nil
tt.fx = "fx_stage_36_portal_splash"
tt.fx_big = "fx_stage_36_portal_splash"
tt = RT("mod_enemy_evolved_lava_dot", "modifier")

E:add_comps(tt, "render", "dps")

b = balance.enemies.dragons.evolved_lava.special_attack.dot
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
tt.dps.damage_every = b.damage_every
tt.dps.damage_max = b.damage_max
tt.dps.damage_min = b.damage_min
tt.dps.damage_type = b.damage_type
tt.dps.fx = "fx_enemy_evolved_lava_firebreath"
tt.dps.fx_every = b.duration + 1
tt = RT("mod_enemy_alfa_lava_dot", "modifier")

E:add_comps(tt, "render", "dps")

b = balance.enemies.dragons.alfa_lava.lava_vomit_attack.dot
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
tt.dps.damage_every = b.damage_every
tt.dps.damage_max = b.damage_max
tt.dps.damage_min = b.damage_min
tt.dps.damage_type = b.damage_type
tt = RT("mod_enemy_alfa_lava_evolve", "modifier")
tt.modifier.duration = fts(2)
tt.main_script.insert = scripts.mod_enemy_alfa_acid_evolve.insert
tt.entity_t = {
	{
		"enemy_basic_lava",
		"enemy_evolved_lava"
	}
}
tt = RT("mod_enemy_basic_acid_armor_reduction", "modifier")

E:add_comps(tt, "render")

b = balance.enemies.dragons.basic_acid.ranged_attack
tt.modifier.duration = b.armor_reduction_duration
tt.armor_reduction = b.armor_reduction
tt.magic_armor_reduction = b.magic_armor_reduction
tt.render.sprites[1].prefix = "evolved_acid_modifier"
tt.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
tt.render.sprites[1].name = "run"
tt.render.sprites[1].draw_order = DO_MOD_FX
tt.render.sprites[1].anchor = v(0.5, 0.6)
tt.main_script.insert = scripts.mod_enemy_basic_acid_armor_reduction.insert
tt.main_script.remove = scripts.mod_enemy_basic_acid_armor_reduction.remove
tt.main_script.update = scripts.mod_track_target.update
tt = RT("mod_enemy_alfa_acid_poison", "modifier")

E:add_comps(tt, "render", "dps")

b = balance.enemies.dragons.alfa_acid.ranged_attack.poison
tt.modifier.duration = b.duration
tt.modifier.vis_flags = bor(F_MOD, F_POISON)
tt.render.sprites[1].prefix = "alpha_acid_modifier"
tt.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
tt.render.sprites[1].name = "run"
tt.render.sprites[1].draw_order = DO_MOD_FX
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_enemy_alfa_acid_poison.update
tt.dps.damage_every = b.damage_every
tt.dps.damage_max = b.damage_max
tt.dps.damage_min = b.damage_min
tt.dps.damage_type = b.damage_type
tt.transformation_nodes_limit = b.transformation_nodes_limit
tt.spawn_entity = "enemy_basic_acid"
tt = RT("mod_enemy_alfa_acid_evolve", "modifier")
tt.modifier.duration = fts(2)
tt.main_script.insert = scripts.mod_enemy_alfa_acid_evolve.insert
tt.entity_t = {
	{
		"enemy_basic_acid",
		"enemy_evolved_acid"
	}
}
tt = RT("mod_enemy_alfa_acid_evolve_mark", "modifier")

E:add_comps(tt, "mark_flags")

tt.modifier.duration = fts(210)
tt.main_script.queue = scripts.mod_mark_flags.queue
tt.main_script.dequeue = scripts.mod_mark_flags.dequeue
tt.main_script.update = scripts.mod_mark_flags.update
tt = RT("mod_enemy_alfa_shadow_evolve", "modifier")
tt.modifier.duration = fts(2)
tt.main_script.insert = scripts.mod_enemy_alfa_acid_evolve.insert
tt.entity_t = {
	{
		"enemy_basic_shadow",
		"enemy_evolved_shadow"
	}
}
tt = RT("mod_enemy_alfa_shadow_evolve_mark", "modifier")

E:add_comps(tt, "mark_flags")

tt.modifier.duration = 4
tt.main_script.queue = scripts.mod_mark_flags.queue
tt.main_script.dequeue = scripts.mod_mark_flags.dequeue
tt.main_script.update = scripts.mod_mark_flags.update
tt = RT("mod_enemy_alfa_storm_evolve", "modifier")
tt.modifier.duration = fts(2)
tt.main_script.insert = scripts.mod_enemy_alfa_acid_evolve.insert
tt.entity_t = {
	{
		"enemy_basic_storm",
		"enemy_evolved_storm"
	}
}
tt = RT("mod_enemies_storm_charged", "modifier")

E:add_comps(tt, "render")

b = balance.enemies.dragons.alfa_storm.special_attack
tt.modifier.duration = 1e+99
tt.main_script.insert = scripts.mod_enemies_storm_charged.insert
tt.main_script.update = scripts.mod_track_target.update
tt.main_script.remove = scripts.mod_enemies_storm_charged.remove
tt.allowed_templates = {
	"enemy_evolved_storm",
	"enemy_executioner_storm",
	"enemy_brute_storm"
}
tt.render.sprites[1].name = "alpha_storm_modifier_creep_run"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].loop = true
tt = RT("mod_enemy_alfa_storm_tower_stun", "modifier")
b = balance.enemies.dragons.alfa_storm.special_attack

E:add_comps(tt, "render")

tt.main_script.insert = scripts.mod_enemy_alfa_storm_tower_stun.insert
tt.main_script.update = scripts.mod_enemy_alfa_storm_tower_stun.update
tt.main_script.remove = scripts.mod_enemy_alfa_storm_tower_stun.remove
tt.modifier.duration = b.tower_stun_duration
tt.modifier.vis_flags = F_CUSTOM
tt.render.sprites[1].prefix = "alpha_storm_fx_skill"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10
tt.render.sprites[1].offset = v(10, 15)
tt.render.sprites[1].scale = vv(1.6)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "alpha_storm_decal"
tt.render.sprites[2].scale = vv(2)
tt.render.sprites[2].anchor = v(0.47183098591549294, 0.5)
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].offset = v(0, 15)
tt.offset_y_per_tower = {
	hermit_toad = 4
}
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "alpha_storm_ray_stun_run"
tt.render.sprites[3].z = Z_OBJECTS
tt.render.sprites[3].sort_y_offset = -20
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].name = "alpha_storm_stun_tower_fx_run"
tt.render.sprites[4].z = Z_OBJECTS
tt.render.sprites[4].sort_y_offset = -25
tt = RT("mod_enemy_alfa_storm_tower_mark", "modifier")

E:add_comps(tt, "mark_flags")

b = balance.enemies.dragons.alfa_storm.special_attack
tt.modifier.duration = 6
tt.main_script.queue = scripts.mod_mark_flags.queue
tt.main_script.dequeue = scripts.mod_mark_flags.dequeue
tt.main_script.update = scripts.mod_mark_flags.update
tt = RT("mod_enemy_brute_storm_invulnerability", "modifier")
b = balance.enemies.dragons.alfa_storm.special_attack
tt.modifier.duration = b.charge_duration
b = balance.enemies.dragons.brute_storm.charged_invulneravility
tt.main_script.insert = scripts.mod_enemy_brute_storm_invulnerability.insert
tt.main_script.update = scripts.mod_enemy_brute_storm_invulnerability.update
tt.main_script.remove = scripts.mod_enemy_brute_storm_invulnerability.remove
tt.hp_heal_threshold = b.hp_heal_threshold
tt.hp_healing_amount = b.hp_healing_amount
tt = RT("mod_hero_dragon_sun_bassic_attack_burn_dps", "modifier")
b = balance.heroes.hero_dragon_sun.basic_attack.burn_dot

E:add_comps(tt, "dps", "render")

tt.modifier.duration = b.duration
tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_type = b.damage_type
tt.dps.damage_every = b.damage_every
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt.modifier.use_mod_offset = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_hero_dragon_sun_bassic_attack_burn_dps.update
tt = RT("mod_hero_dragon_sun_bassic_attack_burn_only_render", "mod_hero_dragon_sun_bassic_attack_burn_dps")
tt.modifier.duration = 0.8
tt.dps.damage_min = 0
tt.dps.damage_max = 0
tt.dps.damage_type = DAMAGE_NONE
tt.dps.damage_every = 1e+99
tt.modifier.use_mod_offset = true
tt.render.sprites[1].offset = v(0, -5)
tt = RT("mod_hero_dragon_sun_bassic_attack_burn_only_render_overcharged", "mod_hero_dragon_sun_bassic_attack_burn_only_render")
tt.render.sprites[1].prefix = "hero_aurion_fire_modifier_2"
tt = RT("mod_hero_dragon_sun_heal", "modifier")

E:add_comps(tt, "hps", "render")

b = balance.heroes.hero_dragon_sun.solar_cleansing
tt.modifier.resets_same = true
tt.hps.heal_min = nil
tt.hps.heal_max = nil
tt.hps.heal_every = b.heal_every
tt.modifier.duration = 1
tt.main_script.insert = scripts.mod_hero_dragon_sun_heal.insert
tt.main_script.update = scripts.mod_hps.update
tt.render.sprites[1].name = "hero_aurion_healing_run"
tt.render.sprites[1].sort_y_offset = -3
tt.modifier.use_mod_offset = true
tt = RT("mod_hero_dragon_stun_worthy_foe_stun", "mod_stun")
tt.modifier.duration = 1.5
tt.render.sprites[1].hidden = true
tt = RT("mod_boss_murglum_tower_block", "mod_hide_tower")

E:add_comps(tt, "render")

tt.main_script.insert = scripts.mod_boss_murglum_tower_block.insert
tt.main_script.update = scripts.mod_boss_murglum_tower_block.update
tt.main_script.remove = scripts.mod_boss_murglum_tower_block.remove
tt.render.sprites[1].prefix = "boss_murglun_tower_stun"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = vv(2)
tt.modifier.duration = nil
tt = RT("mod_stage_40_boss_shadow_tower_block", "modifier")

E:add_comps(tt, "render", "tween")

b = balance.enemies.dragons.boss_stage_40.shadow_waves.tower_block
tt.main_script.insert = scripts.mod_stage_40_boss_shadow_tower_block.insert
tt.main_script.update = scripts.mod_stage_40_boss_shadow_tower_block.update
tt.main_script.remove = nil
tt.render.sprites[1].prefix = "vfx_dragon_stun_tower"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].offset = v(0, 5)
tt.click_rect = r(-30, 0, 60, 60)
tt.menu_offset = v(0, 12)
tt.modifier.duration = b.duration
tt.repair_cost = b.repair_cost
tt.hand_decal_t = "dlc2_generic_tap_hand"
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.3,
		255
	}
}
tt.tween.props[1].loop = false
tt.tween.disabled = false
tt.tween.remove = false
tt.tween.reverse = false
tt.insert_fx = "fx_stage_40_boss_tower_block_insert"
tt = RT("mod_stage_40_boss_shadow_units_stun", "mod_stun")

E:add_comps(tt, "tween")

b = balance.enemies.dragons.boss_stage_40.shadow_waves.stun_units
tt.modifier.duration = b.duration
tt.main_script.update = scripts.mod_stage_40_boss_shadow_units_stun.update
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "vfx_dragon_stun_tower"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].animated = true
tt.render.sprites[2].draw_order = 20
tt.render.sprites[2].scale = vv(1)
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].size_names = nil
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].anchor = v(0.5, 0.5555555555555556)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1.5,
		255
	},
	{
		2,
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 2
tt.tween.disabled = true
tt.tween.remove = false
tt = RT("mod_stage_40_boss_feet_death", "modifier")
tt.main_script.insert = scripts.mod_stage_40_boss_feet_death.insert
tt.main_script.update = scripts.mod_stage_40_boss_feet_death.update
tt.respawn_pos = v(0, 400)
tt = RT("mod_boss_stage_39_get_hit_dps", "modifier")

E:add_comps(tt, "dps")

tt.dps.damage_type = DAMAGE_TRUE
tt.modifier.duration = 1e+99
tt.modifier.allows_duplicates = true
tt.damage_total = 1800
tt.main_script.insert = scripts.mod_boss_stage_39_get_hit_dps.insert
tt.main_script.update = scripts.mod_boss_stage_39_get_hit_dps.update
tt = RT("mod_boss_stage_40_stun_wardens", "mod_stun")
b = balance.enemies.dragons.boss_stage_40.shadow_waves.stun_units
tt.modifier.duration = b.stun_wardens_duration
tt.render.sprites[1].prefix = "vfx_dragon_stun_tower"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].draw_order = 20
tt.render.sprites[1].scale = vv(1)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].size_names = nil
tt = RT("controller_stage_37_dragon_boss", "decal_scripted")

E:add_comps(tt, "events", "editor", "tween")

b = balance.enemies.dragons.dragon_boss_stage_37
tt.boss_controler_balance = b
tt.main_script.insert = scripts.controller_stage_37_dragon_boss.insert
tt.main_script.update = scripts.controller_stage_37_dragon_boss.update
tt.decal_bullet = {
	[GAME_MODE_CAMPAIGN] = "bullet_boss_stage_37_geisers_waves_campaign",
	[GAME_MODE_IRON] = "bullet_boss_stage_37_geisers_waves_campaign",
	[GAME_MODE_HEROIC] = "bullet_boss_stage_37_geisers_waves_campaign"
}
tt.decal_bullets_offset = v(45, -20)
tt.render.sprites[1].prefix = "boss_murglun_boss"
tt.render.sprites[1].name = "torre_idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[1].sort_y_offset = -50
tt.render.sid_shadow = 2
tt.render.sprites[tt.render.sid_shadow] = E:clone_c("sprite")
tt.render.sprites[tt.render.sid_shadow].animated = false
tt.render.sprites[tt.render.sid_shadow].name = "decal_flying_shadow_hard"
tt.render.sprites[tt.render.sid_shadow].offset = v(0, 0)
tt.render.sprites[tt.render.sid_shadow].hidden = false
tt.render.sprites[tt.render.sid_shadow].scale = vv(2)
tt.render.sprites[tt.render.sid_shadow].z = Z_DECALS
tt.render.sprites[tt.render.sid_shadow].offset = v(0, -80)
tt.events.list[1].name = "block_tower"
tt.events.list[1].on_event = scripts.controller_stage_37_dragon_boss.on_block_towers
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "go_to_tower"
tt.events.list[2].on_event = scripts.controller_stage_37_dragon_boss.on_go_to_tower
tt.flight_height = 70
tt.towers_idle_position_offset = v(0, 85)
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 0)
	},
	{
		fts(3),
		v(0, tt.flight_height * 0.8)
	},
	{
		fts(10),
		v(0, tt.flight_height)
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].disabled = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].interp = "sine"
tt.tween.props[2].keys = {
	{
		0,
		v(0, tt.flight_height)
	},
	{
		fts(6),
		v(0, tt.flight_height)
	},
	{
		fts(11),
		v(0, tt.flight_height + 50)
	},
	{
		fts(19),
		v(0, tt.flight_height + 70)
	},
	{
		fts(24),
		v(0, tt.flight_height + 70)
	},
	{
		fts(26),
		v(0, 0)
	}
}
tt.tween.props[2].sprite_id = 1
tt.tween.props[2].disabled = true
tt = RT("controller_stage_38_cinematic", "decal_scripted")

E:add_comps(tt, "editor")

tt.main_script.update = scripts.controller_stage_38_cinematic.update
tt = RT("stage_39_veins_tower_stun", "modifier")

E:add_comps(tt, "render", "sound_events")

tt.main_script.insert = scripts.stage_39_veins_tower_stun.insert
tt.main_script.update = scripts.stage_39_veins_tower_stun.update
tt.main_script.remove = scripts.stage_39_veins_tower_stun.remove
tt.modifier.duration = 1e+99
tt.modifier.vis_flags = F_CUSTOM
tt.spawn_time = fts(0)
tt.death_delay = fts(50)
tt.spawn_entity = "enemy_miniboss_stage_39"
tt.spawn_sound = "Stage39VeinsSpawnEnemy"
tt.spawn_forced_waypoint_offset = v(0, 0)
tt.spawn_delay = 2
tt.explosion_fx = "decal_stage_39_tower_stun_explosion"
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "stage_39_stun_towerDef"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = -10
tt.sound_events.pre_start = "Stage39VeinsExtend"
tt.sound_events.pre_start_args = {
	delay = fts(0)
}
tt.sound_events.start = "Stage39EggsGrow"
tt.sound_events.start_args = {
	delay = fts(25)
}
tt = RT("boss_murglun_proyectil_tower_stun", "bombKR5")
tt.main_script.update = scripts.bullet_boss_morglun_tower_stun.update
tt.bullet.flight_time = fts(45)
tt.bullet.vis_flags = bor(F_RANGED, F_MOD)
tt.bullet.vis_bans = 0
tt.render.sprites[1].prefix = "boss_murglun_proyectil_tower_stun"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.bullet.hit_fx = "fx_boss_murglun_tower_stun_hit"
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.hit_mod = "mod_boss_murglum_tower_block"
tt.bullet.particles_name = "ps_boss_murglun_bullet_tower_stun_trail"
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "Stage37MurglunTowerBlockSpit"
tt = RT("ps_boss_murglun_bullet_tower_stun_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "boss_murglun_trail_tower_stun_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.animation_fps = 30
tt.particle_system.emission_rate = 35
tt.particle_system.emit_rotation_spread = math.pi * 2
tt.particle_system.emit_area_spread = v(2, 2)
tt = RT("fx_boss_murglun_tower_stun_hit", "fx")

E:add_comps(tt, "sound_events")

tt.render.sprites[1].prefix = "boss_murglun_explosion_stun"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].scale = vv(2)
tt.sound_events.insert = "Stage37MurglunTowerBlockImpact"
tt = RT("hero_dragon_sun_ultimate")
b = balance.heroes.hero_dragon_sun.ultimate

E:add_comps(tt, "pos", "main_script", "sound_events")

tt.can_fire_fn = scripts.hero_dragon_sun_ultimate.can_fire_fn
tt.cooldown = balance.heroes.hero_dragon_sun.ultimate.cooldown
tt.main_script.update = scripts.hero_dragon_sun_ultimate.update
tt.spawn_bullet = "bullet_hero_dragon_sun_ultimate"

tt = E:register_t("decal_stage_41_mask_islas", "decal_tween")

E:add_comps(tt, "main_script")

tt.main_script.insert = scripts.decal_stage_41_mask_islas.insert
tt.islas_levels = {
	TOP = Z_BACKGROUND_COVERS + 1,
	MID = Z_BACKGROUND_BETWEEN - 1,
	BACK = Z_BACKGROUND_BETWEEN - 2
}
tt.islas_settings = {
	{
		str = 6,
		z = "TOP",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120,
		skip = true
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = -6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "MID",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = 6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	},
	{
		str = -6,
		z = "BACK",
		freq = 120
	}
}
tt.temp_i = 0

for i = 1, #tt.islas_settings do
	if not tt.islas_settings[i].skip then
		tt.temp_i = tt.temp_i + 1

		local str = tt.islas_settings[i].str
		local freq = tt.islas_settings[i].freq
		local z = tt.islas_levels[tt.islas_settings[i].z]

		freq = freq + math.random(-20, 20)
		tt.render.sprites[tt.temp_i] = E:clone_c("sprite")
		tt.render.sprites[tt.temp_i].name = "stage_36_isla_" .. i
		tt.render.sprites[tt.temp_i].animated = false
		tt.render.sprites[tt.temp_i].z = z
		tt.tween.props[tt.temp_i] = E:clone_c("tween_prop")
		tt.tween.props[tt.temp_i].sprite_id = tt.temp_i
		tt.tween.props[tt.temp_i].name = "offset"
		tt.tween.props[tt.temp_i].interp = "sine"
		tt.tween.props[tt.temp_i].keys = {
			{
				fts(0),
				v(0, 0)
			},
			{
				fts(freq),
				v(0, -str)
			},
			{
				fts(freq * 2),
				v(0, 0)
			}
		}
		tt.tween.props[tt.temp_i].loop = true
	end
end

tt.temp_i = nil
tt.tween.remove = false

tt = E:register_t("decal_stage_41_easter_egg_spyro", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.insert = scripts.decal_stage_41_easter_egg_spyro.insert
tt.main_script.update = scripts.decal_stage_41_easter_egg_spyro.update
tt.render.sprites[1].prefix = "spyro_me_creep"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN + 2
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "stage_36_isla_6_mask"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BACKGROUND_BETWEEN + 3
tt.render.sprites[2].pos = v(512, 384)
tt.fx = "fx_spyro_smoke"
tt.stay_island = {
	[1] = 5,
	[2] = 4
}
tt.ui.click_rect = r(-40, -20, 80, 80)

tt = E:register_t("decal_stage_41_easter_egg_ranger_verde", "decal_scripted")

E:add_comps(tt, "ui", "editor")

tt.main_script.update = scripts.decal_stage_41_easter_egg_ranger_verde.update
tt.render.sprites[1].prefix = "ranger_verde_character"
tt.render.sprites[1].name = "idle1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_OBJECTS
tt.ui.click_rect = r(-25, -10, 50, 50)

tt = E:register_t("stage_41_paths_controller", "decal_scripted")

E:add_comps(tt, "events", "editor")

tt.main_script.update = scripts.stage_41_paths_controller.update
tt.render.sprites[1].prefix = "mecanica_camino_1_stage_1Def"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "mecanica_camino_2_stage_1Def"
tt.render.sprites[2].name = "in"
tt.render.sprites[2].exo = true
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_BACKGROUND_BETWEEN
tt.render.sprites[2].sort_y_offset = -6
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "mecanica_camino_3_stage_1Def"
tt.render.sprites[3].name = "in"
tt.render.sprites[3].exo = true
tt.render.sprites[3].hidden = true
tt.render.sprites[3].z = Z_BACKGROUND_BETWEEN
tt.render.sprites[3].sort_y_offset = -5
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "mecanica_camino_4_stage_1Def"
tt.render.sprites[4].name = "in"
tt.render.sprites[4].exo = true
tt.render.sprites[4].hidden = true
tt.render.sprites[4].z = Z_BACKGROUND_BETWEEN
tt.render.sprites[4].sort_y_offset = 10
tt.events.list[1].name = "show_path"
tt.events.list[1].on_event = scripts.stage_41_paths_controller.on_show_path
tt.holders_list = {
	{
		{
			ts = fts(92),
			pos = v(727, 517)
		},
		{
			shake = true,
			ts = fts(115)
		},
		{
			ts = fts(120),
			pos = v(520, 550)
		}
	},
	{
		{
			ts = fts(53),
			pos = v(220, 550)
		},
		{
			ts = fts(85),
			pos = v(184, 573)
		},
		{
			shake = true,
			ts = fts(95)
		},
		{
			ts = fts(101),
			pos = v(64, 451)
		},
		{
			objects = true,
			ts = fts(102)
		}
	},
	{
		{
			shake = true,
			ts = fts(82)
		}
	}
}
tt.sprite_sids = {
	[3] = {
		3,
		4
	}
}
tt.path_unlocks = {
	{
		islands_required = {
			1
		},
		paths = {
			3
		},
		terrain_paths = {
			3
		},
		extra_terrains = {
			{
				radius = 64,
				x = 730,
				y = 510,
				terrain_type = bor(TERRAIN_LAND, TERRAIN_NOWALK)
			}
		}
	},
	{
		islands_required = {
			2
		},
		paths = {
			2
		},
		terrain_paths = {
			2
		},
		extra_terrains = {}
	},
	{
		islands_required = {
			1,
			2
		},
		paths = {
			4
		},
		terrain_paths = {},
		extra_terrains = {}
	},
	{
		islands_required = {
			3
		},
		paths = {
			5
		},
		terrain_paths = {
			5
		},
		extra_terrains = {}
	}
}
tt.hide_exits_rects = {
	{
		pos = v(-REF_W, 384),
		size = v(REF_W, REF_H)
	}
}
tt.cinematic = {
	[2] = {
		zoom = 1,
		time = fts(67),
		pos = v(200, 600)
	}
}
tt.show_fx = "fx_stage_36_path_dust"
tt.editor.overrides = {
	["render.sprites[2].name"] = "idle",
	["render.sprites[1].hidden"] = false,
	["render.sprites[3].name"] = "idle",
	["render.sprites[3].hidden"] = false,
	["render.sprites[2].hidden"] = false,
	["render.sprites[4].name"] = "idle",
	["render.sprites[4].hidden"] = false,
	["render.sprites[1].name"] = "idle"
}

tt = RT("stage_36_paths_controller", "decal_scripted")

E:add_comps(tt, "events", "editor")

tt.main_script.update = scripts.stage_36_paths_controller.update
tt.render.sprites[1].prefix = "mecanica_camino_1_stage_1Def"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "mecanica_camino_2_stage_1Def"
tt.render.sprites[2].name = "in"
tt.render.sprites[2].exo = true
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_BACKGROUND_BETWEEN
tt.events.list[1].name = "show_path"
tt.events.list[1].on_event = scripts.stage_36_paths_controller.on_show_path
tt.holders_list = {
	{
		{
			ts = fts(92),
			pos = v(727, 517)
		},
		{
			shake = true,
			ts = fts(120)
		}
	},
	{
		{
			ts = fts(80),
			pos = v(184, 573)
		},
		{
			ts = fts(88),
			pos = v(64, 451)
		},
		{
			objects = true,
			shake = true,
			ts = fts(126)
		}
	}
}
tt.path_unlocks = {
	{
		islands_required = {
			1
		},
		paths = {
			3
		},
		terrain_paths = {
			3
		},
		extra_terrains = {
			{
				radius = 64,
				x = 730,
				y = 510,
				terrain_type = bor(TERRAIN_LAND, TERRAIN_NOWALK)
			}
		}
	},
	{
		islands_required = {
			2
		},
		paths = {
			2
		},
		terrain_paths = {
			2
		},
		extra_terrains = {}
	},
	{
		islands_required = {
			1,
			2
		},
		paths = {
			4
		},
		terrain_paths = {},
		extra_terrains = {}
	}
}
tt.hide_exits_rects = {
	{
		pos = v(-REF_W, 384),
		size = v(REF_W, REF_H)
	}
}
tt.cinematic = {
	[2] = {
		zoom = 1,
		time = fts(67),
		pos = v(200, 600)
	}
}
tt.show_fx = "fx_stage_36_path_dust"
tt.editor.overrides = {
	["render.sprites[1].hidden"] = false,
	["render.sprites[1].name"] = "idle"
}
tt = RT("controller_stage_36_portal_splash")

E:add_comps(tt, "main_script")

tt.main_script.update = scripts.controller_stage_36_portal_splash.update
tt.mod = "mod_stage_36_portal_splash"
tt.paths_nodes = {
	23,
	23,
	23,
	23
}
tt.vis_flags = 0
tt.vis_bans = 0
tt = RT("stage_37_paths_controller", "decal_scripted")

E:add_comps(tt, "events", "editor")

tt.main_script.update = scripts.stage_36_paths_controller.update
tt.render.sprites[1].prefix = "mecanica_camino_2_stage_2Def"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.events.list[1].name = "show_path"
tt.events.list[1].on_event = scripts.stage_36_paths_controller.on_show_path
tt.skip_shake = true
tt.holders_list = {
	{
		{
			ts = fts(165),
			pos = v(750, 448)
		},
		{
			shake = true,
			ts = fts(165)
		}
	}
}
tt.path_unlocks = {
	{
		islands_required = {
			1
		},
		paths = {
			3,
			4
		},
		terrain_paths = {
			3,
			4
		},
		extra_terrains = {
			{
				radius = 36,
				x = 380,
				y = 260,
				terrain_type = bor(TERRAIN_LAND)
			},
			{
				radius = 36,
				x = 463,
				y = 311,
				terrain_type = bor(TERRAIN_LAND)
			},
			{
				radius = 46,
				x = 815,
				y = 416,
				terrain_type = bor(TERRAIN_LAND)
			},
			{
				radius = 32,
				x = 742,
				y = 406,
				terrain_type = bor(TERRAIN_LAND)
			}
		}
	}
}
tt.hide_exits_rects = {}
tt.cinematic = {}
tt.show_fx = "fx_stage_36_path_dust"
tt.editor.overrides = {
	["render.sprites[1].hidden"] = false,
	["render.sprites[1].name"] = "idle"
}
tt = RT("stage_38_paths_controller", "decal_scripted")

E:add_comps(tt, "events", "editor")

tt.main_script.update = scripts.stage_36_paths_controller.update
tt.render.sprites[1].prefix = "mecanica_camino_stage_3Def"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].exo = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_BACKGROUND_BETWEEN
tt.events.list[1].name = "show_path"
tt.events.list[1].on_event = scripts.stage_36_paths_controller.on_show_path
tt.skip_shake = true
tt.holders_list = {
	{
		{
			ts = fts(165),
			pos = v(235, 210)
		},
		{
			shake = true,
			ts = fts(165)
		}
	}
}
tt.path_unlocks = {
	{
		islands_required = {
			1
		},
		paths = {
			4
		},
		terrain_paths = {
			4
		},
		extra_terrains = {}
	}
}
tt.hide_exits_rects = {}
tt.cinematic = {
	{
		zoom = 1,
		time = fts(67),
		pos = v(200, 300)
	}
}
tt.show_fx = "fx_stage_36_path_dust"
tt.editor.overrides = {
	["render.sprites[1].hidden"] = false,
	["render.sprites[1].name"] = "idle"
}
tt = RT("controller_stage_39_boss")

E:add_comps(tt, "editor", "pos", "main_script", "render", "health", "info", "ui", "timed_attacks")

tt.main_script.update = scripts.controller_stage_39_boss.update
tt.info.fn = scripts.controller_stage_39_boss.get_info
tt.miniboss_died = scripts.controller_stage_39_boss.miniboss_died
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "boss_stage_39Def"
tt.render.sprites[1].name = "idle_sleep"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 2
tt.health.armor = 1
tt.health.magic_armor = 1
tt.health.hp_max = 9000
tt.health.ignore_delete_after = true
tt.info.i18n_key = "ENEMY_BOSS_DRAGON_STAGE_39"
tt.info.portrait_boss = "boss_health_bar_icon_new0015"
tt.info.enc_icon = 140
tt.ui.click_rect = r(-100, -45, 200, 120)
tt.ui.can_click = false
tt.info.portrait = "gui_bottom_info_image_enemies_0145"
tt.get_hit_mod = "mod_boss_stage_39_get_hit_dps"
tt.minibosses_dead = 0
tt = RT("controller_stage_40_ballista", "decal_scripted")

E:add_comps(tt, "ui", "editor")

b = balance.enemies.dragons.boss_stage_40.ballista
tt.main_script.update = scripts.controller_stage_40_ballista.update
tt.ready_ballista_fn = scripts.controller_stage_40_ballista.ready_ballista_fn
tt.render.sprites[1].prefix = "stage_40_canonDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "canon_balloonDef"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].exo = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(-3, 77)
tt.ui.click_rect = r(-45, -5, 105, 85)
tt.cooldown = b.cooldown
tt.damage = b.damage
tt.shoot_nmbr = 0
tt.hand_decal_t = "dlc2_generic_tap_hand"
tt = RT("controller_stage_40_boss_shadow_waves", "decal_scripted")

E:add_comps(tt, "editor", "timed_attacks", "events")

b = balance.enemies.dragons.boss_stage_40.shadow_waves
tt.main_script.update = scripts.controller_stage_40_boss_shadow_waves.update
tt.render.sprites[1].prefix = "stage_40_bossDef"
tt.render.sprites[1].name = "fly"
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[1].loop = false
tt.render.sprites[1].hidden = true
tt.render.sprites[1].exo = true
tt.attack_towers_index = 1
tt.timed_attacks.list[tt.attack_towers_index] = E:clone_c("mod_attack")
tt.timed_attacks.list[tt.attack_towers_index].decal_stun = "decal_boss_40_waves_stun_towers"
tt.timed_attacks.list[tt.attack_towers_index].decal_warning = "decal_stage_40_boss_shadow_waves_warning"
tt.timed_attacks.list[tt.attack_towers_index].max_range = 99999999
tt.timed_attacks.list[tt.attack_towers_index].min_range = 0
tt.timed_attacks.list[tt.attack_towers_index].holders_ids = b.tower_block.holders
tt.attack_units_index = 2
tt.timed_attacks.list[tt.attack_units_index] = E:clone_c("mod_attack")
tt.timed_attacks.list[tt.attack_units_index].vis_flags = bor(F_MOD, F_STUN)
tt.timed_attacks.list[tt.attack_units_index].vis_bans = 0
tt.timed_attacks.list[tt.attack_units_index].decal_stun = "decal_boss_40_waves_stun_units"
tt.timed_attacks.list[tt.attack_units_index].decal_warning = "decal_stage_40_boss_shadow_waves_warning"
tt.timed_attacks.list[tt.attack_units_index].max_range = 99999999
tt.timed_attacks.list[tt.attack_units_index].min_range = 0
tt.timed_attacks.list[tt.attack_units_index].enabled = b.stun_units.enabled
tt.timed_attacks.list[tt.attack_units_index].stun_fliers = b.stun_units.stun_fliers
tt.timed_attacks.list[tt.attack_units_index].mod_stun_wardens = "mod_boss_stage_40_stun_wardens"
tt.events.list[1].name = "stun_stage"
tt.events.list[1].on_event = scripts.controller_stage_40_boss_shadow_waves.on_stun_stage
tt = RT("controller_stage_40_boss")
b = balance.enemies.dragons.boss_stage_40.bossfight

E:add_comps(tt, "editor", "pos", "main_script", "render", "health", "info", "ui", "timed_attacks")

tt.main_script.update = scripts.controller_stage_40_boss.update
tt.get_hit_by_ballista_fn = scripts.controller_stage_40_boss.get_hit_by_ballista_fn
tt.percentage_to_death = b.percentage_to_death
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "stage_40_bossDef"
tt.render.sprites[1].name = "intro"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[1].sort_y_offset = -2000
tt.ignore_damage_sources_list = {}
tt.hit_points = {}
tt.hit_point_template = "enemy_stage_40_boss_hit_point"
tt.hit_point_offsets = {
	v(-150, 25),
	v(-100, 50),
	v(-50, 100),
	v(-50, 50),
	v(-50, 0),
	v(0, 180),
	v(0, 130),
	v(0, 80),
	v(0, 50),
	v(0, 0)
}
tt.hit_points_feet = {}
tt.hit_point_feet_template = "enemy_stage_40_boss_hit_point_feet"
tt.hit_point_feet_offsets = {
	v(100, -100),
	v(150, -120),
	v(200, -100)
}
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.hp_max = b.hp
tt.health.ignore_delete_after = true
tt.info.i18n_key = "ENEMY_BOSS_DRAGON_STAGE_40"
tt.info.portrait_boss = "boss_health_bar_icon_new0016"
tt.info.enc_icon = 141
tt.steps_config = b.steps
tt.position_offset = v(370, 0)
tt.ui.click_rect = r(-120 + tt.position_offset.x, -50 + tt.position_offset.y, 700, 200)
tt.ui.can_click = true
tt.info.fn = scripts.controller_stage_40_boss.get_info
tt.info.portrait = "gui_bottom_info_image_enemies_0146"
tt.attack_breath_index = 1
tt.timed_attacks.list[tt.attack_breath_index] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.attack_breath_index].max_range = 600
tt.timed_attacks.list[tt.attack_breath_index].min_range = 0
tt.timed_attacks.list[tt.attack_breath_index].vis_flags = bor(F_INSTAKILL, F_RANGED, F_AREA)
tt.timed_attacks.list[tt.attack_breath_index].vis_bans = bor(F_ENEMY)
tt.timed_attacks.list[tt.attack_breath_index].area_offset = v(550, 0)
tt.timed_attacks.list[tt.attack_breath_index].loop_duration = b.breath_loop_duration
tt.timed_attacks.list[tt.attack_breath_index].floor_decal = "fx_boss_stage_40_breath_decal"
tt.attack_chillido_index = 2
tt.timed_attacks.list[tt.attack_chillido_index] = E:clone_c("custom_attack")
tt.timed_attacks.list[tt.attack_chillido_index].max_range = 99999999
tt.timed_attacks.list[tt.attack_chillido_index].min_range = 0
tt.timed_attacks.list[tt.attack_chillido_index].mod_units = "mod_stage_40_boss_shadow_units_stun"
tt.timed_attacks.list[tt.attack_chillido_index].mod_towers = "mod_stage_40_boss_shadow_tower_block"
tt.timed_attacks.list[tt.attack_chillido_index].decal_base = "decal_boss_40_scream_base"
tt.timed_attacks.list[tt.attack_chillido_index].decal_chase_mod = "decal_boss_40_scream_chase_mod"
tt.timed_attacks.list[tt.attack_chillido_index].decal_chase_start_offset = v(310, -60)
tt.timed_attacks.list[tt.attack_chillido_index].vis_flags = bor(F_STUN, F_MOD)
tt.timed_attacks.list[tt.attack_chillido_index].vis_bans = bor(F_ENEMY)
tt.timed_attacks.list[tt.attack_chillido_index].loop_duration = b.scream_loop_duration
tt.aura_feet_death_zone = "aura_stage_40_boss_feet_death_zone"
tt.feet_zones = {
	{
		v(1000, 0),
		400
	},
	{
		v(600, 50),
		300
	},
	{
		v(520, -120),
		150
	},
	{
		v(650, -120),
		150
	}
}
tt.nodes_paths_block_steps = {
	{
		{
			pos = v(840, 520),
			paths = {
				3,
				5
			}
		},
		{
			pos = v(870, 340),
			paths = {
				6,
				7,
				8,
				9,
				10,
				11
			}
		},
		{
			pos = v(925, 554),
			paths = {
				16
			}
		},
		{
			pos = v(925, 496),
			paths = {
				15
			}
		},
		{
			pos = v(925, 434),
			paths = {
				12
			}
		},
		{
			pos = v(925, 371),
			paths = {
				13
			}
		},
		{
			pos = v(1150, 309),
			paths = {
				14
			}
		},
		{
			pos = v(1150, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(730, 500),
			paths = {
				3,
				5
			}
		},
		{
			pos = v(730, 340),
			paths = {
				6,
				7,
				8,
				9,
				10,
				11
			}
		},
		{
			pos = v(765, 554),
			paths = {
				16
			}
		},
		{
			pos = v(765, 496),
			paths = {
				15
			}
		},
		{
			pos = v(765, 434),
			paths = {
				12
			}
		},
		{
			pos = v(765, 371),
			paths = {
				13
			}
		},
		{
			pos = v(980, 309),
			paths = {
				14
			}
		},
		{
			pos = v(980, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(600, 528),
			paths = {
				3,
				8
			}
		},
		{
			pos = v(635, 320),
			paths = {
				5,
				6,
				7,
				9,
				10,
				11
			}
		},
		{
			pos = v(615, 554),
			paths = {
				16
			}
		},
		{
			pos = v(615, 496),
			paths = {
				15
			}
		},
		{
			pos = v(615, 434),
			paths = {
				12
			}
		},
		{
			pos = v(615, 371),
			paths = {
				13
			}
		},
		{
			pos = v(870, 309),
			paths = {
				14
			}
		},
		{
			pos = v(870, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(420, 530),
			paths = {
				3,
				8,
				9
			}
		},
		{
			pos = v(455, 338),
			paths = {
				7,
				10,
				11
			}
		},
		{
			pos = v(610, 300),
			paths = {
				5,
				6
			}
		},
		{
			pos = v(490, 554),
			paths = {
				16
			}
		},
		{
			pos = v(490, 496),
			paths = {
				15
			}
		},
		{
			pos = v(490, 434),
			paths = {
				12
			}
		},
		{
			pos = v(490, 371),
			paths = {
				13
			}
		},
		{
			pos = v(730, 309),
			paths = {
				14
			}
		},
		{
			pos = v(730, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(320, 520),
			paths = {
				2,
				3,
				8,
				9
			}
		},
		{
			pos = v(400, 366),
			paths = {
				7,
				10,
				11
			}
		},
		{
			pos = v(390, 554),
			paths = {
				16
			}
		},
		{
			pos = v(390, 496),
			paths = {
				15
			}
		},
		{
			pos = v(390, 434),
			paths = {
				12
			}
		},
		{
			pos = v(390, 371),
			paths = {
				13
			}
		},
		{
			pos = v(630, 309),
			paths = {
				14
			}
		},
		{
			pos = v(630, 259),
			paths = {
				17
			}
		}
	}
}
tt.nodes_paths_activate_steps = {
	{
		{
			pos = v(690, 554),
			paths = {
				16
			}
		},
		{
			pos = v(690, 496),
			paths = {
				15
			}
		},
		{
			pos = v(690, 434),
			paths = {
				12
			}
		},
		{
			pos = v(690, 371),
			paths = {
				13
			}
		},
		{
			pos = v(690, 309),
			paths = {
				14
			}
		},
		{
			pos = v(690, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(524, 554),
			paths = {
				16
			}
		},
		{
			pos = v(524, 496),
			paths = {
				15
			}
		},
		{
			pos = v(524, 434),
			paths = {
				12
			}
		},
		{
			pos = v(524, 371),
			paths = {
				13
			}
		},
		{
			pos = v(524, 309),
			paths = {
				14
			}
		},
		{
			pos = v(524, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(370, 554),
			paths = {
				16
			}
		},
		{
			pos = v(370, 496),
			paths = {
				15
			}
		},
		{
			pos = v(370, 434),
			paths = {
				12
			}
		},
		{
			pos = v(370, 371),
			paths = {
				13
			}
		},
		{
			pos = v(370, 309),
			paths = {
				14
			}
		},
		{
			pos = v(370, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(210, 554),
			paths = {
				16
			}
		},
		{
			pos = v(210, 496),
			paths = {
				15
			}
		},
		{
			pos = v(210, 434),
			paths = {
				12
			}
		},
		{
			pos = v(210, 371),
			paths = {
				13
			}
		},
		{
			pos = v(210, 309),
			paths = {
				14
			}
		},
		{
			pos = v(210, 259),
			paths = {
				17
			}
		}
	},
	{
		{
			pos = v(75, 554),
			paths = {
				16
			}
		},
		{
			pos = v(75, 496),
			paths = {
				15
			}
		},
		{
			pos = v(75, 434),
			paths = {
				12
			}
		},
		{
			pos = v(75, 371),
			paths = {
				13
			}
		},
		{
			pos = v(75, 309),
			paths = {
				14
			}
		},
		{
			pos = v(75, 259),
			paths = {
				17
			}
		}
	}
}
tt.nodes_paths_block_grid = {
	{
		{
			to_y = 21,
			from_x = 75,
			to_x = 88,
			from_y = 39
		},
		{
			to_y = 15,
			from_x = 82,
			to_x = 88,
			from_y = 21
		}
	},
	{
		{
			to_y = 21,
			from_x = 64,
			to_x = 75,
			from_y = 39
		},
		{
			to_y = 15,
			from_x = 71,
			to_x = 82,
			from_y = 21
		}
	},
	{
		{
			to_y = 21,
			from_x = 51,
			to_x = 63,
			from_y = 36
		},
		{
			to_y = 15,
			from_x = 62,
			to_x = 82,
			from_y = 21
		}
	},
	{
		{
			to_y = 21,
			from_x = 45,
			to_x = 51,
			from_y = 36
		}
	},
	{
		{
			to_y = 21,
			from_x = 40,
			to_x = 45,
			from_y = 36
		}
	}
}
tt.thunder_template = "fx_boss_stage_40_walk_thunders"
tt.walk_thunders_offset = {
	v(600, -190),
	v(400, -200),
	v(510, -150),
	v(380, -100),
	v(550, 30),
	v(420, 0),
	v(500, 100),
	v(350, 150),
	v(500, 200),
	v(400, 200)
}
tt = RT("decal_boss_40_scream_base", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "vfx_dragon_crack_loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].scale = vv(4)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "vfx_dragon_stun_tower_run"
tt.render.sprites[2].animated = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].scale = vv(3)
tt.render.sprites[2].z = Z_OBJECTS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(60),
		255
	},
	{
		fts(70),
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		fts(60),
		255
	},
	{
		fts(70),
		0
	}
}
tt.tween.props[2].loop = false
tt.tween.props[2].sprite_id = 2
tt.tween.disabled = false
tt.tween.remove = true
tt.dont_hide = {
	[1] = true,
	[2] = true
}
tt = RT("decal_boss_40_scream_chase_mod")

E:add_comps(tt, "pos", "main_script")

tt.main_script.update = scripts.decal_boss_40_scream_chase_mod.update
tt.speed = 250
tt.decal = "decal_boss_40_scream_chase_decal"
tt.mod = nil
tt.holder_id = nil
tt.target_id = nil
tt = RT("decal_boss_40_waves_stun_towers", "decal_scripted")

E:add_comps(tt, "pos")

tt.main_script.insert = scripts.decal_boss_40_waves_stun_towers.insert
tt.main_script.update = scripts.decal_boss_40_waves_stun_towers.update
tt.render.sprites[1].name = "vfx_dragon_projectile_stun_aereo_idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].r = math.rad(-90)
tt.render.sprites[1].z = Z_BULLETS
tt.speed = 900
tt.mod = "mod_stage_40_boss_shadow_tower_block"
tt.holder_id = nil
tt.target_id = nil
tt.particles_name = "ps_decal_boss_40_waves_stun_towers"
tt.dist_to_apply = 30
tt.oscillation_speed = 3
tt.oscillation_force = 5
tt = RT("decal_boss_40_waves_stun_units", "decal_boss_40_waves_stun_towers")
tt.mod = "mod_stage_40_boss_shadow_units_stun"
tt.dist_to_apply = 20
tt = RT("decal_boss_40_waves_stun_decoy", "decal_boss_40_waves_stun_towers")
tt.main_script.insert = scripts.decal_boss_40_waves_stun_decoy.insert
tt.main_script.update = scripts.decal_boss_40_waves_stun_decoy.update
tt.fx = "fx_decal_boss_40_waves_stun_decoy"
tt = RT("fx_decal_boss_40_waves_stun_decoy", "decal_tween")
tt.render.sprites[1].prefix = "vfx_dragon_stun_tower"
tt.render.sprites[1].name = "run"
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
		0.4,
		255
	},
	{
		0.6,
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 1
tt.tween.disabled = false
tt.tween.remove = true
tt = RT("decal_boss_40_waves_stun_decoy_position", "decal")

E:add_comps(tt, "editor")

tt.render.sprites[1].name = "waveFlag_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = vv(0.35)
tt.render.sprites[1].offset = v(-6, -6)
tt.render.sprites[1].hidden = true
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].offset = v(6, -6)
tt.render.sprites[3] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[3].offset = v(0, 6)
tt.editor.overrides = {
	["render.sprites[2].hidden"] = false,
	["render.sprites[1].hidden"] = false,
	["render.sprites[3].hidden"] = false
}
tt = RT("decal_boss_40_scream_chase_decal", "decal_scripted")

E:add_comps(tt, "tween")

tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "vfx_dragon_crack_loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = false
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "vfx_dragon_fire_particles_run"
tt.render.sprites[2].animated = true
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_OBJECTS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(20),
		255
	},
	{
		fts(30),
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 1
tt.tween.disabled = false
tt.tween.remove = true
tt = RT("controller_stage_40_moving_island", "decal_scripted")
b = balance.specials.stage_40_moving_island

E:add_comps(tt, "tween", "nav_path", "motion", "events", "attacks", "editor")

tt.main_script.insert = scripts.controller_stage_40_moving_island.insert
tt.main_script.update = scripts.controller_stage_40_moving_island.update
tt.spawn_soldiers = scripts.controller_stage_40_moving_island.spawn_soldiers_fn
tt.tp_to_next_step = scripts.controller_stage_40_moving_island.tp_to_next_step_fn
tt.on_open_path = scripts.controller_stage_40_moving_island.on_open_path
tt.talk = scripts.controller_stage_40_moving_island.talk_fn
tt.current_step = 0
tt.warden_ids = {}
tt.stop_steps = b.stop_steps
tt.warden_offsets = {
	v(0, 0),
	v(0, 0),
	v(0, 0)
}
tt.motion.max_speed = b.speed
tt.sid_egg = 1
tt.sid_main_island = 2
tt.sid_top_warden = 3
tt.sid_island_warden_1 = 4
tt.sid_island_warden_2 = 5
tt.sid_island_warden_3 = 6
tt.sid_bottom_rock = 7
tt.sid_left_rock = 8
tt.sid_right_rock = 9
tt.render.sprites[tt.sid_egg] = E:clone_c("sprite")
tt.render.sprites[tt.sid_egg].prefix = "stage_40_eggDef"
tt.render.sprites[tt.sid_egg].name = "idle"
tt.render.sprites[tt.sid_egg].animated = true
tt.render.sprites[tt.sid_egg].exo = true
tt.render.sprites[tt.sid_egg].z = Z_OBJECTS
tt.render.sprites[tt.sid_egg].sort_y_offset = 30
tt.render.sprites[tt.sid_egg].scale = v(0.93, 0.93)
tt.render.sprites[tt.sid_egg].offset = v(0, 5)
tt.render.sprites[tt.sid_main_island] = E:clone_c("sprite")
tt.render.sprites[tt.sid_main_island].prefix = "roca_eggDef"
tt.render.sprites[tt.sid_main_island].name = "idle"
tt.render.sprites[tt.sid_main_island].animated = true
tt.render.sprites[tt.sid_main_island].exo = true
tt.render.sprites[tt.sid_main_island].z = Z_BACKGROUND_COVERS
tt.render.sprites[tt.sid_main_island].sort_y_offset = -50
tt.render.sprites[tt.sid_top_warden] = E:clone_c("sprite")
tt.render.sprites[tt.sid_top_warden].prefix = "warden_eggDef"
tt.render.sprites[tt.sid_top_warden].name = "idle_loop"
tt.render.sprites[tt.sid_top_warden].animated = true
tt.render.sprites[tt.sid_top_warden].exo = true
tt.render.sprites[tt.sid_top_warden].z = Z_OBJECTS
tt.render.sprites[tt.sid_top_warden].offset = v(0, 115)
tt.original_warden_offset_y = tt.render.sprites[tt.sid_top_warden].offset.y
tt.render.sprites[tt.sid_top_warden].sort_y_offset = -30
tt.render.sprites[tt.sid_island_warden_1] = E:clone_c("sprite")
tt.render.sprites[tt.sid_island_warden_1].name = "egg_roca_wardens"
tt.render.sprites[tt.sid_island_warden_1].animated = false
tt.render.sprites[tt.sid_island_warden_1].z = Z_BACKGROUND_COVERS
tt.render.sprites[tt.sid_island_warden_1].sort_y_offset = -70
tt.render.sprites[tt.sid_island_warden_1].offset = v(135, 0)
tt.render.sprites[tt.sid_island_warden_1].hidden = true
tt.render.sprites[tt.sid_island_warden_2] = E:clone_c("sprite")
tt.render.sprites[tt.sid_island_warden_2].name = "egg_roca_wardens"
tt.render.sprites[tt.sid_island_warden_2].animated = false
tt.render.sprites[tt.sid_island_warden_2].z = Z_BACKGROUND_COVERS
tt.render.sprites[tt.sid_island_warden_2].sort_y_offset = -40
tt.render.sprites[tt.sid_island_warden_2].offset = v(110, 30)
tt.render.sprites[tt.sid_island_warden_2].hidden = true
tt.render.sprites[tt.sid_island_warden_3] = E:clone_c("sprite")
tt.render.sprites[tt.sid_island_warden_3].name = "egg_roca_wardens"
tt.render.sprites[tt.sid_island_warden_3].animated = false
tt.render.sprites[tt.sid_island_warden_3].z = Z_BACKGROUND_COVERS
tt.render.sprites[tt.sid_island_warden_3].sort_y_offset = -70
tt.render.sprites[tt.sid_island_warden_3].offset = v(110, -30)
tt.render.sprites[tt.sid_island_warden_3].hidden = true
tt.render.sprites[tt.sid_bottom_rock] = E:clone_c("sprite")
tt.render.sprites[tt.sid_bottom_rock].prefix = "roca_dragon_2Def"
tt.render.sprites[tt.sid_bottom_rock].name = "idle"
tt.render.sprites[tt.sid_bottom_rock].animated = true
tt.render.sprites[tt.sid_bottom_rock].exo = true
tt.render.sprites[tt.sid_bottom_rock].z = Z_BACKGROUND_COVERS
tt.render.sprites[tt.sid_bottom_rock].sort_y_offset = -60
tt.render.sprites[tt.sid_bottom_rock].offset = v(128, -60)
tt.render.sprites[tt.sid_left_rock] = E:clone_c("sprite")
tt.render.sprites[tt.sid_left_rock].prefix = "roca_dragon_1Def"
tt.render.sprites[tt.sid_left_rock].name = "idle"
tt.render.sprites[tt.sid_left_rock].animated = true
tt.render.sprites[tt.sid_left_rock].exo = true
tt.render.sprites[tt.sid_left_rock].z = Z_BACKGROUND_COVERS
tt.render.sprites[tt.sid_left_rock].sort_y_offset = 2
tt.render.sprites[tt.sid_left_rock].offset = v(-185, 0)
tt.render.sprites[tt.sid_right_rock] = E:clone_c("sprite")
tt.render.sprites[tt.sid_right_rock].prefix = "roca_dragon_3Def"
tt.render.sprites[tt.sid_right_rock].name = "idle"
tt.render.sprites[tt.sid_right_rock].animated = true
tt.render.sprites[tt.sid_right_rock].exo = true
tt.render.sprites[tt.sid_right_rock].z = Z_BACKGROUND_COVERS
tt.render.sprites[tt.sid_right_rock].sort_y_offset = 0
tt.render.sprites[tt.sid_right_rock].offset = v(130, 40)
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bullet_stage_40_island_wardens"
tt.attacks.list[1].cooldown = b.ranged.cooldown
tt.attacks.list[1].max_range = b.ranged.range
tt.attacks.list[1].shoot_time = fts(24)
tt.attacks.list[1].prediction_time = fts(30)
tt.attacks.list[1].bullet_start_offset = v(0, 50)
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.attacks.list[1].animation = "attack"
tt.attacks.list[1].max_count = b.ranged.max_count
tt.levitate_duration = 2
tt.levitate_height_div2 = 5

for i = 1, tt.sid_island_warden_3 do
	tt.tween.props[i] = E:clone_c("tween_prop")
	tt.tween.props[i].name = "offset"

	local soff = tt.render.sprites[i].offset

	tt.tween.props[i].keys = {
		{
			0,
			v(soff.x, soff.y - tt.levitate_height_div2)
		},
		{
			tt.levitate_duration,
			v(soff.x, soff.y + tt.levitate_height_div2)
		},
		{
			tt.levitate_duration * 2,
			v(soff.x, soff.y - tt.levitate_height_div2)
		}
	}
	tt.tween.props[i].loop = true
	tt.tween.props[i].interp = "sine"
	tt.tween.props[i].sprite_id = i
	tt.tween.props[i].disabled = true
end

for i = tt.sid_bottom_rock, tt.sid_right_rock do
	tt.tween.props[i] = E:clone_c("tween_prop")
	tt.tween.props[i].name = "offset"

	local remove_duration = 4
	local soff = tt.render.sprites[i].offset

	tt.tween.props[i].keys = {
		{
			0,
			v(soff.x, soff.y)
		},
		{
			remove_duration,
			v(soff.x, soff.y - 300)
		}
	}
	tt.tween.props[i].loop = false
	tt.tween.props[i].interp = "sine"
	tt.tween.props[i].sprite_id = i
	tt.tween.props[i].disabled = true
end

for i = tt.sid_right_rock + 1, tt.sid_right_rock + 3 do
	local sid = i - (tt.sid_right_rock + 1) + tt.sid_island_warden_1

	tt.tween.props[i] = E:clone_c("tween_prop")
	tt.tween.props[i].name = "offset"

	local show_duration = 2
	local soff = tt.render.sprites[sid].offset

	tt.tween.props[i].keys = {
		{
			0,
			v(soff.x, soff.y - 300)
		},
		{
			show_duration,
			v(soff.x, soff.y)
		}
	}
	tt.tween.props[i].loop = false
	tt.tween.props[i].interp = "sine"
	tt.tween.props[i].sprite_id = sid
	tt.tween.props[i].disabled = true
end

tt.runa = 0
tt.tween.remove = false
tt.events.list[1].name = "move_island"
tt.events.list[1].on_event = scripts.controller_stage_40_moving_island.move_island
tt.events.list[2] = E:clone_c("event")
tt.events.list[2].name = "island_soldiers"
tt.events.list[2].on_event = scripts.controller_stage_40_moving_island.island_soldiers
tt.decal_spell_effect = "decal_stage_40_moving_island_spell_effect"
tt.decal_spell_effect_offsets = {
	[tt.sid_bottom_rock] = v(4, 4),
	[tt.sid_left_rock] = v(7, 8),
	[tt.sid_right_rock] = v(10, 18),
	BLOCK_1 = v(0, 18),
	BLOCK_2 = v(0, 18),
	BLOCK_3 = v(0, 18)
}
tt = RT("decal_stage_40_moving_island_intro_egg_fx", "decal_tween")
tt.render.sprites[1].prefix = "intro_fume_eggDef"
tt.render.sprites[1].name = "idle_loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 0
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.2,
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		vv(1)
	},
	{
		0.2,
		vv(2)
	}
}
tt.tween.props[2].loop = false
tt.tween.remove = true
tt.tween.disabled = true
tt = RT("decal_stage_40_moving_island_intro_warden", "fx")
tt.render.sprites[1].prefix = "intro_wardenDef"
tt.render.sprites[1].name = "idle_loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.5, 0.2037533512064343)
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.render.sprites[1].sort_y_offset = -1000
tt = RT("decal_stage_40_moving_island_rock_sparks", "fx")
tt.render.sprites[1].prefix = "sparks_eggDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].sort_y_offset = -20
tt = RT("decal_stage_40_moving_island_intro_egg_particles", "decal_tween")
tt.render.sprites[1].prefix = "intro_particlesDef"
tt.render.sprites[1].name = "idle_loop"
tt.render.sprites[1].exo = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = v(0.5, 0.05726872246696035)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.2,
		0
	}
}
tt.tween.props[1].loop = false
tt.tween.remove = true
tt.tween.disabled = true
tt = RT("decal_stage_40_moving_island_spell_effect", "decal_tween")
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "efecto_magia_dragonesDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt.render.sprites[1].sort_y_offset = -70
tt.tween.props[1].name = "alpha"
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
tt.tween.props[1].loop = false
tt.tween.remove = false
tt = RT("soldier_warden_stage_40_moving_island", "unit")
b = balance.specials.stage_40_moving_island

E:add_comps(tt, "editor", "main_script", "vis", "soldier", "attacks", "motion", "idle_flip", "info", "sound_events", "regen")

tt.info.damage_icon = "magic"
tt.info.portrait = "gui_bottom_info_image_soldiers_0078"
tt.info.i18n_key = "WARDEN_ISLAND_STAGE_40"
tt.info.fn = scripts.soldier_warden_stage_40_moving_island.get_info
tt.info.desc = "WARDEN_ISLAND_STAGE_40_DESC"
tt.main_script.update = scripts.soldier_warden_stage_40_moving_island.update
tt.render.sprites[1].prefix = "warden_warlock_warden_warrior"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5, 0.49047619047619045)
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.idle = {
	"idle_back",
	"idle"
}
tt.render.sprites[1].angles.shoot = {
	"attack_back",
	"attack_front"
}
tt.render.sprites[1].z = Z_BACKGROUND_COVERS + 1
tt.idle_flip.animations = {
	"idle"
}
tt.unit.mod_offset = v(0, 13)
tt.unit.head_offset = v(0, 13)
tt.unit.hit_offset = v(0, 13)
tt.unit.fade_time_after_death = tt.health.dead_lifetime - 1
tt.unit.fade_duration_after_death = 1
tt.regen.cooldown = 1
tt.regen.health = b.soldiers.regen_health
tt.health.dead_lifetime = 3
tt.health.hp_max = b.soldiers.hp_max
tt.health.armor = b.soldiers.armor
tt.health.magic_armor = b.soldiers.magic_armor
tt.vis.flags = bor(F_FRIEND, F_RANGED)
tt.vis.bans = bor(F_AREA, F_BLOCK)
tt.attacks.range = b.soldiers.ranged.max_range
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bullet_stage_40_island_wardens"
tt.attacks.list[1].cooldown = b.soldiers.ranged.cooldown
tt.attacks.list[1].shoot_time = fts(32)
tt.attacks.list[1].prediction_time = fts(30)
tt.attacks.list[1].bullet_start_offset = v(20, 50)
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.motion.max_speed = b.speed
tt.raise = "spawn"
tt.raise_prefix = "warden_warlock_stage3_warden_warrior"
tt = RT("soldier_warden_stage_40_island_stopped", "unit")
b = balance.specials.stage_40_moving_island

E:add_comps(tt, "soldier", "motion", "nav_rally", "nav_grid", "main_script", "vis", "info", "sound_events", "melee", "ranged", "idle_flip", "reinforcement", "regen")

tt.info.portrait = "gui_bottom_info_image_soldiers_0078"
tt.regen.cooldown = 1
tt.regen.health = b.soldiers.regen_health
tt.health.hp_max = b.soldiers.hp_max
tt.health.armor = b.soldiers.armor
tt.health.magic_armor = b.soldiers.magic_armor
tt.health_bar.offset = v(0, 35)
tt.health.dead_lifetime = 3
tt.unit.fade_time_after_death = tt.health.dead_lifetime - 1
tt.unit.fade_duration_after_death = 0.3
tt.info.fn = scripts.soldier_dragon_warden_charge.get_info
tt.info.i18n_key = "WARDEN_ISLAND_STAGE_40"
tt.main_script.update = scripts.soldier_warden_stage_40_island_stopped.update
tt.melee.attacks[1].cooldown = b.soldiers.ranged.cooldown
tt.melee.attacks[1].hit_aura = "bullet_stage_40_island_wardens_melee"
tt.melee.attacks[1].damage_max = 0
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].damage_type = DAMAGE_NONE
tt.melee.attacks[1].hit_time = fts(18)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].animation = "attack_front"
tt.melee.range = 70
tt.ranged.attacks[1].animation = "attack_front"
tt.ranged.attacks[1].bullet = "bullet_stage_40_island_wardens"
tt.ranged.attacks[1].cooldown = b.soldiers.ranged.cooldown
tt.ranged.attacks[1].max_range = b.soldiers.ranged.max_range
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].bullet_start_offset = {
	v(20, 50),
	v(20, 50)
}
tt.motion.max_speed = b.soldiers.max_speed
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "warden_warlock_stage3_warden_warrior"
tt.soldier.melee_slot_offset.x = 3
tt.unit.head_offset = v(0, 6)
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, 9)
tt.vis.bans = 0
tt.vis.flags = F_FRIEND
tt.raise = "spawn"
tt.idle_flip.animations = {
	"idle"
}
tt.reinforcement.duration = nil
tt.reinforcement.fade = false
tt.reinforcement.fade_in = false
tt.reinforcement.fade_out = false
---3.14
tt = RT("g1_tower_barrack_soldier_warden_stage_40", "tower")

AC(tt, "barrack")

tt.tower.type = "g1_tower_barrack_soldier_warden_stage_40"
tt.tower.level = 1
tt.tower.price = 300
tt.info.i18n_key = "SOLDIER_WARDEN_STAGE_40_MOVING_ISLAND"
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = "gui_bottom_info_image_soldiers_0078"
tt.info.enc_icon = 12
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 0)
--tt.render.sprites[3].animated = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "transparent"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "wardens_dragon_house_spawner"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].z = Z_OBJECTS
tt.render.sprites[3].sort_y_offset = 50
tt.render.sprites[3].loop = false
--[[
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "g1_towerbarracklvl1_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 38)
tt.render.sprites[3].hidden = true
]]--
tt.barrack.soldier_type = "soldier_warden_stage_40_island_stopped_d"
tt.barrack.rally_range = 2000
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.g1_tower_barrack_soldier_warden_stage_40.update
tt.main_script.remove = scripts.tower_barrack.remove
tt = RT("soldier_warden_stage_40_island_stopped_d", "soldier_warden_stage_40_island_stopped")
--tt.render.sprites[1] = E:clone_c("sprite")
--tt.render.sprites[1].prefix = "warden_warlock_stage3_warden_warrior"
--tt.render.sprites[1].name = "spawn"
tt.raise = "spawn"
tt.raise_prefix = "warden_warlock_stage3_warden_warrior"
---
tt = RT("soldier_warden_stage_40_reinforcement", "soldier_warden_stage_40_island_stopped")
b = balance.reinforcements

E:add_comps(tt, "tween")

tt.info.i18n_key = "SOLDIER_WARDEN_MAGE_REINFORCEMENT"
tt.reinforcement.duration = b.soldier.duration
tt.reinforcement.fade = true
tt.reinforcement.fade_in = false
tt.reinforcement.fade_out = true
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
b = balance.specials.stage_40_warden_reinforcements.mage
tt.regen.cooldown = 1
tt.regen.health = b.regen_health
tt.health.armor = b.armor
tt.health.magic_armor = b.magic_armor
tt.health.hp_max = b.hp_max
tt.motion.max_speed = b.speed
tt.melee.attacks[1].hit_aura = "bullet_stage_40_island_wardens_melee_reinforcement"
tt.ranged.attacks[1].bullet = "bullet_stage_40_island_wardens_reinforcement"
tt.ranged.attacks[1].cooldown = b.ranged.cooldown
tt.ranged.attacks[1].max_range = b.ranged.max_range
tt = RT("aura_stage_40_boss_feet_death_zone", "aura")
tt.aura.mods = {
	"mod_stage_40_boss_feet_death"
}
tt.aura.duration = 1e+99
tt.aura.cycle_time = 0.2
tt.aura.radius = 200
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_MOD, F_TELEPORT, F_INSTAKILL)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = RT("enemy_stage_40_boss_hit_point", "enemy_KR5")
tt.enemy.gold = 0
tt.enemy.melee_slot = v(0, 0)
tt.enemy.lives_cost = 9999
tt.health.hp_max = 1e+99
tt.health.armor = 0
tt.health.magic_armor = 0
tt.unit.blood_color = BLOOD_VIOLET
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_stage_40_boss_hit_point.update
tt.health.on_damage = scripts.enemy_stage_40_boss_hit_point.on_damage
tt.update_pos = scripts.enemy_stage_40_boss_hit_point.update_pos_fn
tt.motion.max_speed = 0
tt.render = nil
tt.unit.hit_offset = v(0, 100)
tt.ui.click_rect = r(-30, -3, 60, 65)
tt.ui.can_click = false
tt.ui.can_select = false
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_FLYING)
tt.vis.bans = bor(F_MOD, F_BLOCK, F_INSTAKILL)
tt.move_bounds = v(25, 25)
tt.move_speed = v(0.2, 0.2)
tt.ui.click_rect = r(-10, -10, 20, 20)
tt.get_damaged_fx = "fx_stage_40_boss_get_damaged"
tt.sound_events.death = nil
tt = RT("enemy_stage_40_boss_hit_point_feet", "enemy_stage_40_boss_hit_point")
tt.unit.hit_offset = v(0, 0)
tt = RT("stage_39_cocoon", "decal_scripted")

E:add_comps(tt, "events", "editor")

tt.render.sprites[1].prefix = "stage_39_spawnerDef"
tt.render.sprites[1].name = "spawner_inactivo_idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].exo = true
tt.render.sprites[1].sort_y_offset = -13
tt.render.sprites[1].group = "layers"
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].prefix = "stage_39_spawner_backDef"
tt.render.sprites[2].sort_y_offset = 40
tt.animation_spawner_start = "spawner_activo_in"
tt.animation_spawner_idle = "idle_activos"
tt.animation_spawner_end = "spawner_activo_out"
tt.animation_spawner_idle_broken = "spawner_inactivo_idle"
tt.animation_spawn_in = "spawn_in"
tt.vena = nil
tt.broken_on_heroic = true
tt.broken_on_iron = true
tt.path_index = nil
tt.spawn_enemy = false
tt.active = "desactive"
tt.explosion_fx = "decal_stage_39_cocoon_explosion_2"
tt.explosion_fx_offset = v(0, -30)
tt.main_script.update = scripts.stage_39_cocoon.update
tt.sound_inflate = "Stage39EggsGrow"
tt.sound_inflate_args = {
	delay = fts(25)
}
tt.sound_vena = "Stage39VeinsExtend"
tt.sound_spawn = "Stage39VeinsSpawnEnemy"
tt.events.list[1].name = "activate_spawner"
tt.events.list[1].on_event = scripts.stage_39_cocoon.on_activate_spawner
tt.editor.props = {
	{
		"path_index",
		PT_STRING
	}
}
tt = RT("decal_stage_39_cocoon_explosion", "decal_scripted")
tt.render.sprites[1].prefix = "stage_39_spawner_splashDef"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].exo = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = vv(0.8)
tt.render.sprites[1].sort_y_offset = 15
tt = RT("decal_stage_39_cocoon_explosion_2", "decal_stage_39_cocoon_explosion")
tt.render.sprites[1].prefix = "stage_39_spawner_splash2Def"
tt = RT("stage_39_cocoon_center_1", "stage_39_cocoon")
tt.render.sprites[1].prefix = "spawner_centro_1Def"
tt.render.sprites[1].name = "idle"
tt.render.sprites[2] = nil
tt.explosion_fx = "decal_stage_39_cocoon_explosion"
tt.animation_spawn_in = "spawn"
tt.animation_spawner_idle = "idle"
tt.active = "active"
tt.events = nil
tt.render.sprites[1].sort_y_offset = -11
tt.animation_spawner_idle_broken = "idle"
tt = RT("stage_39_cocoon_center_2", "stage_39_cocoon_center_1")
tt.render.sprites[1].prefix = "spawner_centro_2_frontDef"
tt.render.sprites[1].sort_y_offset = -25
tt.back = "decal_stage_39_cocoon_center_2_back"
tt = RT("decal_stage_39_cocoon_center_2_back", "decal_scripted")
tt.render.sprites[1].prefix = "spawner_centro_2_backDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 5
tt = RT("stage_39_cocoon_center_3", "stage_39_cocoon_center_1")
tt.render.sprites[1].prefix = "spawner_centro_3Def"
tt.render.sprites[1].sort_y_offset = 68
tt = RT("stage_39_cocoon_center_4", "stage_39_cocoon_center_1")
tt.render.sprites[1].prefix = "spawner_centro_4Def"
tt.render.sprites[1].sort_y_offset = 134
tt = RT("stage_39_cocoon_center_5", "stage_39_cocoon_center_1")
tt.render.sprites[1].prefix = "spawner_centro_5_frontDef"
tt.render.sprites[1].sort_y_offset = 16
tt.back = "decal_stage_39_cocoon_center_5_back"
tt = RT("decal_stage_39_cocoon_center_5_back", "decal_scripted")
tt.render.sprites[1].prefix = "spawner_centro_5_backDef"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = 55
tt = RT("decal_stage_39_cocoon_vena_1", "decal_scripted")
tt.render.sprites[1].prefix = "stage_39_venas_spawner_01Def"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].exo = true
tt = RT("decal_stage_39_cocoon_vena_2", "decal_stage_39_cocoon_vena_1")
tt.render.sprites[1].prefix = "stage_39_venas_spawner_02Def"
tt = RT("decal_stage_39_cocoon_vena_2_2", "decal_stage_39_cocoon_vena_1")
tt.render.sprites[1].prefix = "stage_39_venas_spawner_02_02Def"
tt = RT("decal_stage_39_cocoon_vena_3", "decal_stage_39_cocoon_vena_1")
tt.render.sprites[1].prefix = "stage_39_venas_spawner_03Def"
tt = RT("decal_stage_39_cocoon_vena_4", "decal_stage_39_cocoon_vena_1")
tt.render.sprites[1].prefix = "stage_39_venas_spawner_04Def"
tt = RT("decal_stage_39_cocoon_vena_5", "decal_stage_39_cocoon_vena_1")
tt.render.sprites[1].prefix = "stage_39_venas_spawner_05Def"
