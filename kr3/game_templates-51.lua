-- chunkname: @./kr5/game_templates.lua

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
local scripts = require("game_scripts-5")
local my_lua = require("my_lua")

require("templates")

local H = require("helpers")
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
	return E:register_t(name, ref)
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

tt = E:register_t("ps_tower_sparking_geode_sparks_1")

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
tt = E:register_t("ps_tower_sparking_geode_sparks_2", "ps_tower_sparking_geode_sparks_1")
tt.particle_system.name = "sparking_geode_electric_decal_2_idle"
tt.particle_system.particle_lifetime = {
	fts(34),
	fts(34)
}
tt = E:register_t("fx_tower_sparking_geode_evolve", "fx")
tt.render.sprites[1].name = "sparking_geode_evolve_run"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = vv(1)
tt = E:register_t("fx_mod_tower_sparking_geode_stun_death", "fx")
tt.render.sprites[1].prefix = "sparking_geode_cystal_fx"
tt.render.sprites[1].name = "death"
tt.render.sprites[1].z = Z_OBJECTS
tt = E:register_t("fx_tower_sparking_geode_up_ray", "fx")
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
tt = E:register_t("fx_tower_sparking_geode_hit", "fx")
tt.render.sprites[1].prefix = "sparking_geode_ray_rebote"
tt.render.sprites[1].name = "hit"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].scale = v(0.72, 1.08)
tt = E:register_t("decal_tower_sparking_geode_burst_crystal", "decal_scripted")
tt.render.sprites[1].animated = true
tt.render.sprites[1].prefix = "sparking_geode_crystal_small"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts.decal_tower_sparking_geode_burst_crystal.update
tt = E:register_t("tower_build_sparking_geode", "tower_build")
tt.build_name = "tower_sparking_geode_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[1].hidden = true
tt.render.sprites[2].name = "sparking_geode_construction"
tt.render.sprites[2].offset = v(0, 10)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
tt = E:register_t("tower_sparking_geode_lvl1", "tower_KR5")
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
tt = E:register_t("tower_sparking_geode_lvl2", "tower_sparking_geode_lvl1")
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
tt = E:register_t("tower_sparking_geode_lvl3", "tower_sparking_geode_lvl1")
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
tt = E:register_t("tower_sparking_geode_lvl4", "tower_sparking_geode_lvl1")
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
tt.powers.crystalize.price_base = b.crystalize.price[1]
tt.powers.crystalize.price_inc = b.crystalize.price[2]
tt.powers.crystalize.cooldown = b.crystalize.cooldown
tt.powers.crystalize.enc_icon = 537
tt.powers.crystalize.name = "crystalize"
tt.powers.crystalize.key = "CRYSTALIZE"
tt.powers.spike_burst = CC("power")
tt.powers.spike_burst.price_base = b.spike_burst.price[1]
tt.powers.spike_burst.price_inc = b.spike_burst.price[2]
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
tt = E:register_t("tower_sparking_geode_ray_lvl1", "bullet")
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
tt = E:register_t("tower_sparking_geode_ray_lvl2", "tower_sparking_geode_ray_lvl1")
b = balance.towers.sparking_geode
tt.bullet.level = 2
tt.bounces_min = b.basic_attack.bounces_min[tt.bullet.level]
tt.bounces_max = b.basic_attack.bounces_max[tt.bullet.level]
tt.bounce_damage_factor = b.basic_attack.bounce_damage_factor[2]
tt.bullet.damage_min = b.basic_attack.damage_min[tt.bullet.level]
tt.bullet.damage_max = b.basic_attack.damage_max[tt.bullet.level]
tt = E:register_t("tower_sparking_geode_ray_lvl3", "tower_sparking_geode_ray_lvl1")
b = balance.towers.sparking_geode
tt.bullet.level = 3
tt.bounces_min = b.basic_attack.bounces_min[tt.bullet.level]
tt.bounces_max = b.basic_attack.bounces_max[tt.bullet.level]
tt.bounce_damage_factor = b.basic_attack.bounce_damage_factor[3]
tt.bullet.damage_min = b.basic_attack.damage_min[tt.bullet.level]
tt.bullet.damage_max = b.basic_attack.damage_max[tt.bullet.level]
tt = E:register_t("tower_sparking_geode_ray_lvl4", "tower_sparking_geode_ray_lvl1")
b = balance.towers.sparking_geode
tt.bullet.level = 4
tt.bounces_min = b.basic_attack.bounces_min[tt.bullet.level]
tt.bounces_max = b.basic_attack.bounces_max[tt.bullet.level]
tt.bounce_damage_factor = b.basic_attack.bounce_damage_factor[4]
tt.bullet.damage_min = b.basic_attack.damage_min[tt.bullet.level]
tt.bullet.damage_max = b.basic_attack.damage_max[tt.bullet.level]
tt = E:register_t("aura_tower_sparking_geode_spike_burst", "aura")
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
tt = E:register_t("mod_tower_sparking_geode_stun", "mod_stun")
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
tt = E:register_t("mod_tower_sparking_geode_burst_slow", "mod_slow")
b = balance.towers.sparking_geode.spike_burst
tt.modifier.duration = b.damage_every + fts(1)
tt.slow.factor = b.speed_factor

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.slow.factor[this.modifier.level]

	return scripts.mod_slow.insert(this, store, script)
end

tt = E:register_t("mod_tower_sparking_geode_burst_damage", "modifier")
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

tt = E:register_t("tower_stage_28_priests_barrack", "tower_KR5")
b = balance.specials.towers.tower_stage_28_priests_barrack

E:add_comps(tt, "vis", "barrack")

tt.tower.type = "tower_priests_barrack"
tt.tower.level = 1
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.can_be_sold = true
--tt.tower.can_be_mod = false
tt.tower.range_offset = v(0, 10)
tt.tower.price = 360
tt.tower.menu_offset = v(0, 25)


function tt.info.fn(this)
	return {
		type = STATS_TYPE_TEXT,
		desc = this.info.desc
	}
end

tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_barrack_mercenaries_KR52.update
tt.main_script.remove = scripts.tower_barrack.remove

function tt.main_script.insert(this, store, script)
	if this.render.sprites[1].flip_x == true then
		this.barrack.respawn_offset.x = this.barrack.respawn_offset.x * -1
	end

	return scripts.tower_barrack.insert(this, store, script)
end

--tt.info.portrait = "portraits_towers_0029"
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
tt.barrack.max_soldiers = 3
tt.sound_events.change_rally_point = "Stage04ArboreanThornspears"
tt.ui.click_rect = r(-35, -15, 70, 70)
tt = E:register_t("soldier_priests_barrack", "soldier_militia")
b = balance.specials.towers.tower_stage_28_priests_barrack.priest

E:add_comps(tt, "nav_grid", "ranged", "death_spawns")

tt.health.armor = b.armor
tt.health.hp_max = 160 --b.hp_max
tt.regen.health = 10 --b.regen_health
tt.health_bar.offset = v(0, 35)
tt.health.dead_lifetime = 12
tt.nav_rally.delay_max = nil
tt.info.fn = scripts.soldier_priests_barrack.get_info
tt.info.damage_icon = b.melee.damage_type == DAMAGE_MAGICAL and "magic" or nil
--tt.info.portrait = "gui_bottom_info_image_soldiers_0058"
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
--tt.death_spawns.concurrent_with_death = false
--tt.death_spawns.delay = nil
--tt.death_spawns.offset = v(0, 2)
--tt.death_spawns.dead_lifetime = 0
tt.transform_chances = b.transform_chances
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.price = b.price
tt.unit.fade_time_after_death = 1
tt.sound_events.insert = "Stage04ArboreanThornspears"
tt = E:register_t("soldier_abomination_priests_barrack", "soldier_militia")
b = balance.specials.towers.tower_stage_28_priests_barrack.abomination

E:add_comps(tt, "nav_grid", "reinforcement", "tween")

tt.health.hp_max = 600--b.hp_max
tt.health.armor = b.armor
tt.regen.health = b.regen_health
tt.health.dead_lifetime = 12
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
--tt.info.portrait = "gui_bottom_info_image_soldiers_0059"
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
tt.reinforcement.duration = 26 --b.duration
tt.reinforcement.fade = false
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
tt = E:register_t("decal_tentacle_priests_barrack", "decal_scripted")
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

tt = E:register_t("bullet_soldier_priests_barrack", "bolt")
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
tt = E:register_t("priests_tentacle_aura", "aura")
b = balance.specials.towers.tower_stage_28_priests_barrack.tentacle.area_attack
tt.aura.cycles = 1
tt.aura.damage_min = b.damage_min
tt.aura.damage_max = b.damage_max
tt.aura.damage_type = b.damage_type
tt.aura.radius = b.radius
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.main_script.update = scripts.aura_apply_damage.update
tt = E:register_t("mod_priests_abomination_eat", "modifier")
b = balance.specials.towers.tower_stage_28_priests_barrack.abomination
tt.main_script.queue = scripts.mod_enemy_unblinded_abomination_eat.queue
tt.main_script.update = scripts.mod_enemy_unblinded_abomination_eat.update
tt.explode_fx = "fx_soldier_priests_barrack_abomination_eat"
tt.required_hp = b.eat.hp_required
tt = E:register_t("fx_soldier_priests_barrack_melee_hit", "fx")
tt.render.sprites[1].name = "priest_melee_hit"
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t("fx_soldier_priests_barrack_abomination_melee_hit", "fx")
tt.render.sprites[1].name = "redemeed_cultist_barraca_unblinded_abomination_hit_fx_idle"
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t("fx_soldier_priests_barrack_abomination_eat", "fx")
tt.render.sprites[1].name = "redemeed_cultist_barraca_unblinded_abomination_eat_fx"
tt.render.sprites[1].sort_y_offset = -30
tt = E:register_t("fx_soldier_priests_barrack_bolt_hit", "fx")
tt.render.sprites[1].name = "priest_ranged_hit_idle"
tt = E:register_t("ps_bullet_soldier_priests_barrack_trail")

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

tt = RT("g5_special_buy", "Goldfinger")
tt.tower.type = "g5_special_buy"

tt.info.enc_icon = 14
tt.info.portrait = "portraits_goldfinger_0001"
tt.info.i18n_key = "CHEAT"
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.can_be_mod = false
tt.tower.cant_be_move = true
tt.barrack.has_door = nil
tt.tower.price = 0
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.remove = scripts.tower_barrack.remove
tt.main_script.update = scripts.tower_barrack_mercenaries.update
tt.barrack.max_soldiers = 999
tt.barrack.rally_angle_offset = math.pi / 5.55
tt.barrack.soldier_type = "enemy_twilight_brute"
tt.barrack.rally_range = 99999
tt.render.sprites[1].prefix = "bolt_sorcerer"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = v(0, 0)
tt.render.sprites[1].scale = v(0.1, 0.1)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
--tt.render.sprites[2].name = "mage_shooter_0016"
tt.render.sprites[2].name = "sorcerer_shooter_0001"
tt.render.sprites[2].offset = v(0, 18)
tt.render.sprites[2].scale = v(1.2, 1.2)
tt.render.sprites[3] = nil
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		9e+99,
		255
	}
}
tt.sound_events.insert = "GUITowerBuilding"
tt.sound_events.change_rally_point = nil
tt = RT("g5_special_tower", "g5_special_buy")
tt.tower.type = "g5_special_tower"

---龙魂
tt = RT("g5_special_elemental", "Goldfinger")
tt.tower.type = "g5_special_elemental"

tt.info.enc_icon = 14
tt.info.portrait = "portraits_goldfinger_0001"
tt.info.i18n_key = "CHEAT"
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.can_be_mod = false
tt.tower.cant_be_move = true
tt.barrack.has_door = nil
tt.tower.price = 0
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.remove = scripts.tower_barrack.remove
tt.main_script.update = scripts.tower_barrack_mercenaries.update
tt.barrack.max_soldiers = 999
tt.barrack.rally_angle_offset = math.pi / 5.55
tt.barrack.soldier_type = "enemy_twilight_brute"
tt.barrack.rally_range = 99999
tt.render.sprites[1].prefix = "bolt_sorcerer"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = v(0, 0)
tt.render.sprites[1].scale = v(0.1, 0.1)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
--tt.render.sprites[2].name = "mage_shooter_0016"
tt.render.sprites[2].name = "sorcerer_shooter_0001"
tt.render.sprites[2].offset = v(0, 18)
tt.render.sprites[2].scale = v(1.2, 1.2)
tt.render.sprites[3] = nil
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		9e+99,
		255
	}
}
tt.sound_events.insert = "GUITowerBuilding"
tt.sound_events.change_rally_point = nil
---
tt = RT("tower_hero_buy_c", "tower_hero_buy")
tt.tower.type = "hero_buy_c"
tt.tower.kind = TOWER_KIND_BARRACK
tt.render.sprites[2].name = "sorcerer_shooter_0001"
tt.attacks.list[1].price = 80
tt.attacks.list[1].entities = {
	{
		1,
		{
		"hero_vesper_2"
		}
	}
}
tt.attacks.list[2].price = 80
tt.attacks.list[2].entities = {
	{
		1,
		{
		"hero_raelyn_2"
		}
	}
}
tt.attacks.list[3].price = 110
tt.attacks.list[3].entities = {
	{
		1,
		{
		"hero_muyrn_2"
		}
	}
}
tt.attacks.list[4].price = 80
tt.attacks.list[4].entities = {
	{
		1,
		{
		"hero_venom_2"
		}
	}
}
tt.attacks.list[5].price = 80
tt.attacks.list[5].entities = {
	{
		1,
		{
		"hero_builder_2"
		}
	}
}
tt.attacks.list[6].price = 100
tt.attacks.list[6].entities = {
	{
		1,
		{
		"hero_robot_2"
		}
	}
}
tt.attacks.list[7].price = 110
tt.attacks.list[7].entities = {
	{
		1,
		{
		"hero_space_elf_2"
		}
	}
}
tt.attacks.list[8].price = 100
tt.attacks.list[8].entities = {
	{
		1,
		{
		"hero_mecha_2"
		}
	}
}
tt.attacks.list[9].price = 140
tt.attacks.list[9].entities = {
	{
		1,
		{
		"hero_lumenir_2"
		}
	}
}
tt.attacks.list[10].price = 100
tt.attacks.list[10].entities = {
	{
		1,
		{
		"hero_hunter_2"
		}
	}
}
tt.attacks.list[11].price = 140
tt.attacks.list[11].entities = {
	{
		1,
		{
		"hero_dragon_gem_2"
		}
	}
}
tt.attacks.list[12].price = 130
tt.attacks.list[12].entities = {
	{
		1,
		{
		"hero_bird_2"
		}
	}
}
tt.attacks.list[13].price = 150
tt.attacks.list[13].entities = {
	{
		1,
		{
		"hero_dragon_bone_2"
		}
	}
}
tt.attacks.list[14].price = 100
tt.attacks.list[14].entities = {
	{
		1,
		{
		"hero_witch_2"
		}
	}
}
tt.attacks.list[15].price = 140
tt.attacks.list[15].entities = {
	{
		1,
		{
		"hero_dragon_arb_2"
		}
	}
}
tt.attacks.list[16].price = 100
tt.attacks.list[16].entities = {
	{
		1,
		{
		"hero_lava_2"
		}
	}
}
tt.attacks.list[17].price = 110
tt.attacks.list[17].entities = {
	{
		1,
		{
		"hero_spider_2"
		}
	}
}
tt.attacks.list[18] = nil
tt.attacks.list[19] = nil

tt = RT("tower_hero_buy_d", "tower_hero_buy")
tt.tower.type = "hero_buy_d"
tt.tower.kind = TOWER_KIND_BARRACK
tt.render.sprites[2].name = "sorcerer_shooter_0001"
tt.attacks.list[1].price = 300
tt.attacks.list[1].entities = {
	{
		1,
		{
		"hero_eiskalt_2"
		}
	}
}
tt.attacks.list[2].price = 180
tt.attacks.list[2].entities = {
	{
		1,
		{
		"hero_dianyun_2"
		}
	}
}

tt.attacks.list[3].price = 150
tt.attacks.list[3].entities = {
	{
		1,
		{
		"hero_jack_o_lantern_2"
		}
	}
}

tt.attacks.list[4].price = 120
tt.attacks.list[4].entities = {
	{
		1,
		{
		"hero_wukong_2"
		}
	}
}

tt.attacks.list[5].price = 300
tt.attacks.list[5].entities = {
	{
		1,
		{
		"hero_douzhanshengfo_2"
		}
	}
}

tt.attacks.list[6].price = 180
tt.attacks.list[6].entities = {
	{
		1,
		{
		"hero_murglun_2"
		}
	}
}

tt.attacks.list[7].price = 150
tt.attacks.list[7].entities = {
	{
		1,
		{
		"hero_beresad_2"
		}
	}
}

tt.attacks.list[8].price = 150
tt.attacks.list[8].entities = {
	{
		1,
		{
		"hero_lucerna_2"
		}
	}
}

tt.attacks.list[9].price = 150
tt.attacks.list[9].entities = {
	{
		1,
		{
		"hero_tank_2"
		}
	}
}

tt.attacks.list[10].price = 90
tt.attacks.list[10].entities = {
	{
		1,
		{
		"hero_orc_2"
		}
	}
}

tt.attacks.list[11].price = 90
tt.attacks.list[11].entities = {
	{
		1,
		{
		"hero_asra_2"
		}
	}
}

tt.attacks.list[12].price = 90
tt.attacks.list[12].entities = {
	{
		1,
		{
		"hero_oloch_2"
		}
	}
}

for i = 13, 19 do
	tt.attacks.list[i] = nil
end


tt = E:register_t("hero_vesper_2", "hero_vesper")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_raelyn_2", "hero_raelyn")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_muyrn_2", "hero_muyrn")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_venom_2", "hero_venom")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_builder_2", "hero_builder")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_robot_2", "hero_robot")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_space_elf_2", "hero_space_elf")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_mecha_2", "hero_mecha")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_lumenir_2", "hero_lumenir")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_hunter_2", "hero_hunter")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_dragon_gem_2", "hero_dragon_gem")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_bird_2", "hero_bird")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_dragon_bone_2", "hero_dragon_bone")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_witch_2", "hero_witch")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_dragon_arb_2", "hero_dragon_arb")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_lava_2", "hero_lava")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_spider_2", "hero_spider")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_eiskalt_2", "hero_eiskalt")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_dianyun_2", "hero_dianyun")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_jack_o_lantern_2", "hero_jack_o_lantern")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_murglun_2", "hero_murglun")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_beresad_2", "hero_beresad")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_lucerna_2", "hero_lucerna")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_tank_2", "hero_tank")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_asra_2", "hero_asra")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_orc_2", "hero_orc")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end

tt = E:register_t("hero_oloch_2", "hero_oloch")
tt.hero_insert = false
tt.hero.level = 10
for i, aa in pairs(tt.hero.skills) do
	aa.level = 3
end


tt = E:register_t("tower_stage_13_sunray_d", "tower_stage_13_sunray")
tt.tower.type = "tower_stage_13_sunray_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 0

tt = E:register_t("tower_stage_18_elven_barrack_d", "tower_stage_18_elven_barrack")
tt.tower.type = "tower_stage_18_elven_barrack_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 0
tt.tower.terrain_style = nil

tt = E:register_t("tower_stage_20_arborean_honey_d", "tower_stage_20_arborean_honey")
tt.tower.type = "arborean_honey_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 0
tt.price_repair_heroic = 96
tt.price_repair = 160

tt = E:register_t("tower_arborean_sentinels_d", "tower_arborean_sentinels")
tt.tower.type = "tower_arborean_sentinels_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 0

tt = E:register_t("tower_stage_20_arborean_oldtree_d", "tower_stage_20_arborean_oldtree")
tt.tower.type = "arborean_oldtree_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 225

tt = E:register_t("tower_stage_20_arborean_barrack_d", "tower_stage_20_arborean_barrack")
tt.tower.type = "arborean_barrack_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 0

tt = E:register_t("tower_stage_22_arborean_mages_d", "tower_stage_22_arborean_mages")
tt.tower.type = "weirdwood_d"
tt.appear = true
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 150

tt = E:register_t("tower_stage_17_weirdwood_d", "tower_stage_17_weirdwood")
tt.tower.type = "weirdwood_d"
tt.tower.can_be_sold = true
tt.tower.can_be_mod = false
tt.tower.price = 135

tt = E:register_t("tower_build_random_1", "tower_build")
tt.build_name = "tower_random_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[2].name = "sorcerer_shooter_0001"
tt.render.sprites[2].offset = v(0, 30)

tt = E:register_t("tower_random_lvl1", "tower_KR5")
E:add_comps(tt, "powers", "vis")
tt.info.i18n_key = "TOWER_RANDOM"
tt.info.fn = scripts.tower_random.get_info
tt.tower.type = "random1"--据此区分箭兵法炮
tt.tower.kind = TOWER_KIND_ARCHER
tt.tower.team = TEAM_LINIREA
tt.info.tower_portrait = "tower_room_portraits_big_tower_random_0001"
tt.info.room_portrait = "quickmenu_tower_icons_0108_0001"
tt.info.stat_damage = 0
tt.info.stat_cooldown = 0
tt.info.stat_range = 0
tt.tower.price = 80
tt.powers.unknown1 = E:clone_c("power")
tt.powers.unknown1.price = { 0 }
tt.powers.unknown1.enc_icon = 105
tt.powers.unknown1.max_level = 1
tt.powers.unknown2 = E:clone_c("power")
tt.powers.unknown2.price = { 0 }
tt.powers.unknown2.enc_icon = 105
tt.powers.unknown2.max_level = 1
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.main_script.insert = scripts.tower_random.insert
tt.sound_events.insert = nil
tt.sound_events.tower_room_select = nil

tt = E:register_t("tower_build_random_2", "tower_build_random_1")
tt.build_name = "tower_random_lvl2"


tt = E:register_t("tower_build_random_3", "tower_build_random_1")
tt.build_name = "tower_random_lvl3"


tt = E:register_t("tower_build_random_4", "tower_build_random_1")
tt.build_name = "tower_random_lvl4"


tt = E:register_t("tower_build_random_0", "tower_build_random_1")
tt.build_name = "tower_random_lvl0"


tt = E:register_t("tower_random_lvl2", "tower_random_lvl1")
tt.tower.type = "random2"--据此区分箭兵法炮
tt.tower.price = 80

tt = E:register_t("tower_random_lvl3", "tower_random_lvl1")
tt.tower.type = "random3"--据此区分箭兵法炮
tt.tower.price = 110

tt = E:register_t("tower_random_lvl4", "tower_random_lvl1")
tt.tower.type = "random4"--据此区分箭兵法炮
tt.tower.price = 125

tt = E:register_t("tower_random_lvl0", "tower_random_lvl1")
tt.tower.type = "random0"--据此区分箭兵法炮
tt.tower.price = 100

tt = E:register_t("tower_build_random_21", "tower_build_random_1")
tt.build_name = "tower_random_lvl21"


tt = E:register_t("tower_build_random_22", "tower_build_random_1")
tt.build_name = "tower_random_lvl22"


tt = E:register_t("tower_build_random_23", "tower_build_random_1")
tt.build_name = "tower_random_lvl23"


tt = E:register_t("tower_build_random_24", "tower_build_random_1")
tt.build_name = "tower_random_lvl24"


tt = E:register_t("tower_build_random_20", "tower_build_random_1")
tt.build_name = "tower_random_lvl20"


tt = E:register_t("tower_random_lvl21", "tower_random_lvl1")
tt.tower.type = "random21"--据此区分箭兵法炮
tt.tower.price = 200

tt = E:register_t("tower_random_lvl22", "tower_random_lvl1")
tt.tower.type = "random22"--据此区分箭兵法炮
tt.tower.price = 210

tt = E:register_t("tower_random_lvl23", "tower_random_lvl1")
tt.tower.type = "random23"--据此区分箭兵法炮
tt.tower.price = 260

tt = E:register_t("tower_random_lvl24", "tower_random_lvl1")
tt.tower.type = "random24"--据此区分箭兵法炮
tt.tower.price = 320

tt = E:register_t("tower_random_lvl20", "tower_random_lvl1")
tt.tower.type = "random20"--据此区分箭兵法炮
tt.tower.price = 250

--第87关自创怪物
tt = RT("enemy_witch_strong", "enemy_witch")
tt.enemy.gold = 144
tt.health.hp_max = 1500
tt.info.i18n_key = "ENEMY_WITCH_STRONG"
tt.vis.bans = bor(F_BLOCK, F_THORN, F_POISON)

tt = RT("enemy_spectral_knight_strong", "enemy_spectral_knight")
tt.health.hp_max = 800
tt.enemy.gold = 222
tt.info.i18n_key = "ENEMY_SPECTRAL_KNIGHT_STRONG_NAME"

tt = RT("enemy_fallen_knight_strong", "enemy_fallen_knight")
tt.death_spawns.name = "enemy_spectral_knight_strong_spawn"
tt.enemy.gold = 222
tt.health.hp_max = 2000
tt.info.i18n_key = "ENEMY_FALLEN_KNIGHT_STRONG"

tt = RT("enemy_spectral_knight_strong_spawn", "enemy_spectral_knight_strong")
tt.enemy.gold = 0

tt = E:register_t("enemy_abomination_strong", "enemy_abomination_1")
tt.info.i18n_key = "ENEMY_ABOMINATION_STRONG"
tt.motion.max_speed = 1.28 * 0.5 * FPS
tt.health.hp_max = 6400
tt.enemy.gold = 333
