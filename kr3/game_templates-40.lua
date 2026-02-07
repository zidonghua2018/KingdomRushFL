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

local scripts = require("game_scripts-1")
local scripts3 = require("game_scripts")
local scripts4 = require("game_scripts-40")

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

if H.command_line_has_arg("balance_override") then
    local balance_override_path = H.command_line_argv("balance_override")

    require(balance_override_path)
end

if game and game.store and game.store.level and game.store.level.test_case and game.store.level.test_case.patch_balance then
    local new_balance = game.store.level.test_case:patch_balance()

    if new_balance then
        balance = new_balance
    end
end

--本文件：使用rebbborn底层代码实现4代防御塔
----------------------------------------------
------------------暗黑弓箭手-------------------
----------------------------------------------
tt = E.register_t(E, "fx_arrow_shadow_shot", "fx")
tt.render.sprites[1].name = "darkarmy_archer_tower_arrow_lvl4_blood_red"
-- 310(326) 350(368) 390(410) 430(452)
--建造
tt = E:register_t("tower_build_shadow_archer", "tower_build")
tt.build_name = "tower_shadow_archer_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "darkarmy_archer_towers_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 33)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
--1级黑弓
tt = E.register_t(E, "tower_shadow_archer_lvl1", "tower")
E.add_comps(E, tt, "attacks")
tt.info.i18n_key = "TOWER_DARK_ARMY_ARCHER_LEVEL1"
tt.info.enc_icon = 18
tt.tower.type = "shadow_archer"
tt.tower.level = 1
tt.tower.price = 80
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 163
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "arrow_shadow_tower_lvl1"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = 0.2
tt.attacks.list[1].bullet_start_offset = {
		v(9, 4),
		v(6, -5)
}
tt.attacks.list[1].hit_fx = "fx_arrow_shadow_shot"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "darkarmy_archer_towers_0002"
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].offset = v(0, 46)
tt.render.sprites[3].prefix = "tower_shadow_archer_shooter_lvl1"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
}
tt.main_script.update = scripts4.tower_shadow_archer.update
tt.main_script.remove = scripts4.tower_shadow_archer.remove
tt.sound_events.insert = "ShadowArcherTaunt"

tt = E.register_t(E, "tower_shadow_archer_lvl2", "tower_shadow_archer_lvl1")
tt.info.i18n_key = "TOWER_DARK_ARMY_ARCHER_LEVEL2"
tt.tower.level = 2
tt.tower.price = 120
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 184

tt.render.sprites[2].name = "darkarmy_archer_towers_0003"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[3].offset = v(0,46)
tt.render.sprites[3].prefix = "tower_shadow_archer_shooter_lvl2"
tt.attacks.list[1].bullet = "arrow_shadow_tower_lvl2"

tt = E.register_t(E, "tower_shadow_archer_lvl3", "tower_shadow_archer_lvl1")
tt.info.i18n_key = "TOWER_DARK_ARMY_ARCHER_LEVEL3"
tt.tower.level = 3
tt.tower.price = 180
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 205
tt.render.sprites[2].name = "darkarmy_archer_towers_0004"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[3].offset = v(0,46)
tt.render.sprites[3].prefix = "tower_shadow_archer_shooter_lvl3"
tt.attacks.list[1].bullet = "arrow_shadow_tower_lvl3"

tt = E.register_t(E, "tower_shadow_archer_lvl4", "tower_shadow_archer_lvl1")

E.add_comps(E, tt, "powers")
tt.info.i18n_key = "TOWER_DARK_ARMY_ARCHER_LEVEL4"
image_y = 90
tt.info.enc_icon = 18
tt.tower.type = "shadow_archer"
tt.tower.level = 4
tt.tower.price = 260
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 226
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "arrow_shadow_tower_lvl4"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = 0.2
tt.attacks.list[1].bullet_start_offset = {
		v(9, 4),
		v(6, -5)
}
tt.attacks.list[1].hit_fx = "fx_arrow_shadow_shot"
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].cooldowns = {
	40,
	30,
	24
}
tt.attacks.list[2].shoot_time = fts(20)
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_INSTAKILL)
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING)
tt.attacks.list[2].sound = "TowerGShadowInstakillShot"
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].animation = "mark"
tt.attacks.list[3].cooldown = 18
tt.attacks.list[3].range = 225
tt.attacks.list[3].bullet = "arrow_shadow_mark"
tt.attacks.list[3].bullet_start_offset = {
		v(9, 4),
		v(6, -5)
}
tt.attacks.list[3].shoot_time = 0.2
tt.attacks.list[3].sound = "TowerShadowMarkShot"
tt.attacks.list[3].sound_args = {
	delay = fts(15)
}
tt.attacks.list[3].vis_flags = bor(F_RANGED)
tt.attacks.list[3].vis_bans = bor(F_FRIEND)
tt.info.portrait = "gui4_bottom_info_image_towers_0006"
tt.info.fn = scripts4.tower_shadow_archer.get_info
tt.powers.blade = E.clone_c(E, "power")
tt.powers.blade.attack_idx = 2
tt.powers.blade.price_base = 255
tt.powers.blade.price_inc = 85
tt.powers.blade.enc_icon = 318
tt.powers.mark = E.clone_c(E, "power")
tt.powers.mark.attack_idx = 3
tt.powers.mark.price_base = 102
tt.powers.mark.price_inc = 102
tt.powers.mark.enc_icon = 319
tt.powers.crow = E.clone_c(E, "power")
tt.powers.crow.price_base = 170
tt.powers.crow.price_inc = 170
tt.powers.crow.max_level = 2
tt.powers.crow.enc_icon = 320
tt.powers.crow.damage_min = 4
tt.powers.crow.damage_max = 4
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "darkarmy_archer_towers_layer1_0005"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_shadow_archer_shooter_lvl4"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	mark = {
		"shootSpecialUp",
		"shootSpecialDown"
	}
}
tt.render.sprites[3].offset = v(-5, 60)

tt.render.sprites[4] = E.clone_c(E, "sprite")
--tt.render.sprites[4].animated = false
tt.render.sprites[4].name = "darkarmy_archer_towers_layer2_0005"
tt.render.sprites[4].offset = v(1, 29)
tt.render.sprites[4].hidden = true
tt.main_script.update = scripts4.tower_shadow_archer.update
tt.main_script.remove = scripts4.tower_shadow_archer.remove
tt.sound_events.insert = "ShadowArcherTaunt"

tt = E:register_t("shadow_crow", "decal_scripted")

E:add_comps(tt, "force_motion", "custom_attack")

anchor_y = 0.5
image_y = 30
tt.flight_height = 50
tt.flight_speed_idle = 370
tt.ramp_dist_idle = 0
tt.flight_speed_busy = 370
tt.ramp_dist_busy = 10
tt.bombs_pos = nil
tt.idle_pos = nil
tt.main_script.update = scripts4.shadow_crow.update
tt.custom_attack = E:clone_c("custom_attack")
tt.custom_attack.min_range = 10
tt.custom_attack.max_range = 10
tt.custom_attack.damage_min = 2
tt.custom_attack.damage_max = 2
tt.custom_attack.hit_fx = "fx_crow_attack_hit"
tt.custom_attack.cooldown = 0.5
tt.custom_attack.damage_type = DAMAGE_PHYSICAL
tt.custom_attack.vis_flags = F_RANGED
tt.custom_attack.vis_bans = 0
tt.custom_attack.sound_chance = 0.3
tt.custom_attack.sound = "ShadowArcherCrowAttack"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "darkarmy_archer_tower_crow_lvl4"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop_forced = true
tt.render.sprites[1].sort_y_offset = -12
tt.render.sprites[1].scale = v(-0.7, 0.7)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.owner = nil

tt = E.register_t(E, "arrow_shadow_tower", "arrow_1")
tt.bullet.flight_time_min = fts(6)
tt.bullet.flight_time_factor = fts(1 / 60)
--tt.bullet.miss_decal = "tower_shadow_archer_arrow_decal_0001"
tt.bullet.damage_max = 1 
tt.bullet.damage_min = 1
tt.bullet.reduce_armor = 0
tt.render.sprites[1].name = "darkarmy_archer_arrow_0001"
tt.render.sprites[1].scale = v(-1, 1)

tt = E.register_t(E, "arrow_shadow_tower_lvl1", "arrow_shadow_tower")
tt.bullet.damage_max = 4
tt.bullet.damage_min = 3


tt = E.register_t(E, "arrow_shadow_tower_lvl2", "arrow_shadow_tower")
tt.bullet.damage_max = 13
tt.bullet.damage_min = 7

tt = E.register_t(E, "arrow_shadow_tower_lvl3", "arrow_shadow_tower")
tt.bullet.damage_max = 24
tt.bullet.damage_min = 15

tt = E.register_t(E, "arrow_shadow_tower_lvl4", "arrow_shadow_tower")
tt.bullet.damage_max = 39
tt.bullet.damage_min = 26
tt.render.sprites[1].name = "darkarmy_archer_arrow_lvl4_0001"

tt = E.register_t(E, "fx_crow_attack_hit", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].name = "darkarmy_archer_tower_crow_lvl4_bloodRed"
tt.render.sprites[1].offset = v(0, 0)

tt = RT("ps_shadow_mark_trail", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 50
tt.particle_system.name = "darkarmy_archer_arrow_smoke_run"
tt.particle_system.particle_lifetime = {
	fts(4),
	fts(4),
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	0.8
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = E.register_t(E, "arrow_shadow_mark", "arrow_shadow_tower")
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_fx = nil
tt.bullet.mod = "mod_arrow_shadow_mark"
tt.bullet.particles_name = "ps_shadow_mark_trail"
tt.bullet.flight_time_min = fts(9)
tt.bullet.flight_time_factor = fts(1 / 15)
tt.bullet.miss_decal = nil
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "darkarmy_archer_arrow_special_travel"
tt.render.sprites[1].scale = v(-1, -1)
tt.render.sprites[1].offset = v(3, 0)
tt.sound_events.insert = nil

tt = E.register_t(E, "mod_arrow_shadow_mark", "modifier")

E.add_comps(E, tt, "render", "sound_events", "count_group")

tt.count_group.name = "mod_arrow_shadow_mark"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.modifier.received_damage_factor = {
	1.3,
	1.6,
	2
}
tt.modifier.received_damage_factors = {
	1.3,
	1.6,
	2
}
tt.main_script.insert = scripts4.mod_arrow_shadow_mark.insert
tt.main_script.update = scripts4.mod_arrow_shadow_mark.update
tt.main_script.remove = scripts4.mod_arrow_shadow_mark.remove
tt.modifier.durations = {
	5,
	5,
	5
}
tt.custom_offsets = {
	flying = v(0, 32),
	enemy_goblin_balloon = v(0, 75)
}
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "tower_shadow_archer_shooter_lvl4_shadow_modifier_run"
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].z = Z_EFFECTS
tt.sound_events.insert = nil


----------------------------------------------
-------------------暗黑骑士--------------------
----------------------------------------------
--建造
tt = E:register_t("tower_build_dark_knights", "tower_build")
tt.build_name = "tower_dark_knights_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "darkarmy_barrack_tower_lvl1_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 30)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E.register_t(E, "tower_dark_knights_lvl1", "g1_tower_barrack_1")
--tt.info.enc_icon = 20
tt.info.i18n_key = "TOWER_DARK_ARMY_BARRACK_LEVEL1"
tt.info.portrait = "gui4_bottom_info_image_towers_0009"
tt.tower.type = "dark_knights"
tt.tower.price = 110
tt.tower.level = 1
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "dark_army_soldier_knight_lvl1"
tt.barrack.rally_range = 159.5
tt.barrack.rally_angle_offset = -0.4
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].prefix = "darkarmy_barrack_towers_lvl1_layer1"
tt.render.sprites[2].animated = true
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3].prefix = "darkarmy_barrack_towers_lvl1_layer2"
tt.render.sprites[3].offset = v(0, 30)
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].loop = false
tt.sound_events.insert = "DarkKnightsTaunt"
tt.sound_events.change_rally_point = "DarkKnightsTauntBuild"


tt = E.register_t(E, "tower_dark_knights_lvl2", "tower_dark_knights_lvl1")
tt.info.i18n_key = "TOWER_DARK_ARMY_BARRACK_LEVEL2"
tt.tower.price = 160
tt.tower.level = 2
tt.barrack.soldier_type = "dark_army_soldier_knight_lvl2"
tt.render.sprites[2].prefix = "darkarmy_barrack_towers_lvl2_layer1"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3].prefix = "darkarmy_barrack_towers_lvl2_layer2"
tt.render.sprites[3].offset = v(0, 30)

tt = E.register_t(E, "tower_dark_knights_lvl3", "tower_dark_knights_lvl1")
tt.info.i18n_key = "TOWER_DARK_ARMY_BARRACK_LEVEL3"
tt.tower.price = 220
tt.tower.level = 3
tt.barrack.soldier_type = "dark_army_soldier_knight_lvl3"
tt.render.sprites[2].prefix = "darkarmy_barrack_towers_lvl3_layer1"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3].prefix = "darkarmy_barrack_towers_lvl3_layer2"
tt.render.sprites[3].offset = v(0, 30)

tt = E.register_t(E, "tower_dark_knights_lvl4", "tower_dark_knights_lvl1")
tt.info.i18n_key = "TOWER_DARK_ARMY_BARRACK_LEVEL4"

E.add_comps(E, tt, "powers")

--tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0005") or "krv_portraits_0005"
tt.info.enc_icon = 20
tt.tower.type = "dark_knights"
tt.tower.price = 260
tt.tower.level = 4
tt.powers.instakill = E.clone_c(E, "power")
tt.powers.instakill.price_base = 238
tt.powers.instakill.price_inc = 238
tt.powers.instakill.enc_icon = 328
tt.powers.spike = CC("power")
tt.powers.spike.price_base = 127
tt.powers.spike.price_inc = 127
tt.powers.spike.enc_icon = 329
tt.powers.shield = E.clone_c(E, "power")
tt.powers.shield.price_base = 170
tt.powers.shield.price_inc = 170
tt.powers.shield.enc_icon = 327
tt.powers.shield.max_level = 1
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "soldier_dark_knight_lvl4"
tt.barrack.rally_range = 159.5
tt.barrack.rally_angle_offset = -0.4
tt.render.sprites[2].prefix = "darkarmy_barrack_towers_lvl4_layer1"
tt.render.sprites[2].animated = true
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3].prefix = "darkarmy_barrack_towers_lvl4_layer2"
tt.render.sprites[3].offset = v(0, 30)
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].loop = false
tt.sound_events.insert = "DarkKnightsTaunt"
tt.sound_events.change_rally_point = "DarkKnightsTauntBuild"

tt = E.register_t(E, "dark_army_soldier_knight_lvl1", "soldier_militia")
E:add_comps(tt, "nav_grid")
anchor_y = 0.2
image_y = 42
--tt.main_script.insert = scripts4.soldier_dark_knight.insert
--tt.main_script.update = scripts4.soldier_dark_knight.update
--tt.health.on_damage = scripts4.soldier_dark_knight.on_damage
tt.health.armor = 0.4
tt.health.dead_lifetime = 8
tt.health.hp_max = 130
tt.health.dark_spiked_armor = 0
tt.health.dark_damage_type = DAMAGE_PHYSICAL
tt.health_bar.offset = v(0, 32)
tt.info.portrait = "gui4_bottom_info_image_soldiers_0015"
tt.info.random_name_count = 9
tt.info.random_name_format = "SOLDIER_DARK_KNIGHT_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 70
tt.motion.max_speed = 75
tt.regen.health = 10
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "dark_army_soldier_knight_lvl1"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0.2
tt.render.sprites[2].name = "darkarmy_soldier_lvl1_shadow"
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))

tt = E.register_t(E, "dark_army_soldier_knight_lvl2", "dark_army_soldier_knight_lvl1")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0016"
tt.health.armor = 0.5
tt.health.hp_max = 182
tt.melee.attacks[1].damage_max = 11
tt.melee.attacks[1].damage_min = 4
tt.regen.health = 13
tt.render.sprites[1].prefix = "dark_army_soldier_knight_lvl2"
tt.render.sprites[2].name = "darkarmy_soldier_lvl2_shadow"

tt = E.register_t(E, "dark_army_soldier_knight_lvl3", "dark_army_soldier_knight_lvl1")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0017"
tt.health.armor = 0.6
tt.health.hp_max = 260
tt.melee.attacks[1].damage_max = 22
tt.melee.attacks[1].damage_min = 7
tt.regen.health = 18
tt.render.sprites[1].prefix = "dark_army_soldier_knight_lvl3"
tt.render.sprites[1].anchor.y = 0.15
tt.render.sprites[2].name = "darkarmy_soldier_lvl3_shadow"
tt.render.sprites[2].anchor.y = 0.15

tt = E.register_t(E, "soldier_dark_knight_lvl4", "soldier_militia")
E.add_comps(E, tt, "powers", "dodge", "nav_grid")
anchor_y = 0.27
image_y = 42
tt.dodge.animation = "dodge"
tt.dodge.chance = 0
tt.dodge.chance_inc = 0
tt.dodge.cooldown = 15
tt.dodge.shield = E.clone_c(E, "melee_attack")
tt.dodge.shield.animation_start = "imperviousIntro"
tt.dodge.shield.animation_end = "imperviousOut"
tt.dodge.shield.cooldown = 15
tt.dodge.shield.damage_inc = 0
tt.dodge.shield.damage_max = 0
tt.dodge.shield.damage_min = 0
tt.dodge.shield.duration = 6
tt.dodge.shield.hit_time = fts(8)
tt.dodge.shield.power_name = "shield"
tt.dodge.shield.damage_every = fts(5)
tt.dodge.shield.vis_bans = bor(F_BOSS)
tt.dodge.shield.sound = "DarkKnightsShield"
tt.dodge.power_name = "shield"
tt.dodge.ranged = false
tt.main_script.insert = scripts4.soldier_dark_knight.insert
tt.main_script.update = scripts4.soldier_dark_knight.update
tt.health.on_damage = scripts4.soldier_dark_knight.on_damage
tt.health.armor = 0.75
tt.health.dead_lifetime = 8
tt.health.hp_max = 338
tt.health.dark_spiked_armor = 0
tt.health.dark_damage_type = DAMAGE_PHYSICAL
tt.health_bar.offset = v(0, 50)
tt.info.portrait = "gui4_bottom_info_image_soldiers_0018"
tt.info.random_name_count = 9
tt.info.random_name_format = "SOLDIER_DARK_KNIGHT_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 1.6
tt.melee.attacks[1].damage_max = 39
tt.melee.attacks[1].damage_min = 13
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "merciless"
tt.melee.attacks[2].chance = 0
tt.melee.attacks[2].chance_inc = 0
tt.melee.attacks[2].cooldown = 50000000000000
tt.melee.attacks[2].damage_inc = 0
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(24)
tt.melee.attacks[2].pop = nil
tt.melee.attacks[2].forced_cooldown = true
tt.melee.attacks[2].sound_hit = "DarkKnightsInstakill"
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.attacks[3] = E.clone_c(E, "melee_attack")
tt.melee.attacks[3].animation = "merciless"
tt.melee.attacks[3].chance = 0
tt.melee.attacks[3].chance_inc = 0.02
tt.melee.attacks[3].cooldown = 1.6
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_time = fts(50)
tt.melee.attacks[3].instakill = true
tt.melee.attacks[3].damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_EXPLODE, DAMAGE_NO_DODGE)
tt.melee.attacks[3].pop = {
  "pop_instakill"
}
tt.melee.attacks[3].pop_chance = 1
tt.melee.attacks[3].power_name = "instakill"
tt.melee.attacks[3].forced_cooldown = true
tt.melee.attacks[3].sound_hit = "DarkKnightsInstakillHit"
tt.melee.attacks[3].sound = "DarkKnightsInstakill"
tt.melee.attacks[3].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 70
tt.motion.max_speed = 75
tt.powers.spike = CC("power")
tt.powers.spike.dark_spiked_armor = {
	15,
	30,
	45
}
tt.powers.shield = E.clone_c(E, "power")
tt.powers.instakill = E.clone_c(E, "power")
tt.regen.health = 24
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "darkarmy_soldier_lvl4_layer1"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "darkarmy_soldier_lvl4_layer2"
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "darkarmy_soldier_lvl4_layer3"
tt.render.sprites[3].anchor.y = anchor_y
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].is_shadow = true
tt.render.sprites[4].anchor.y = anchor_y
tt.render.sprites[4].animated = false
tt.render.sprites[4].name = "darkarmy_soldier_lvl4_shadow"
tt.render.sprites[4].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, ady(23))

----------------------------------------------
-------------------炼狱法师--------------------
----------------------------------------------
--建造
tt = E:register_t("tower_build_infernal_mage", "tower_build")
tt.build_name = "tower_infernal_mage_lvl1"
tt.render.sprites[1].name = "terrain_ember_lords_mage"
tt.render.sprites[1].offset = v(0, 46)
tt.render.sprites[2].name = "ember_lords_mage_tower_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 46)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

--1级
tt = RT("tower_infernal_mage_lvl1", "g1_tower_mage_1")

AC(tt, "attacks")

image_y = 90
tt.tower.type = "infernal_mage"
tt.tower.level = 1
tt.tower.price = 100
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 15
tt.info.portrait = "gui4_bottom_info_image_towers_0005"
tt.info.i18n_key = "TOWER_EMBER_LORDS_MAGE_LEVEL1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_ember_lords_mage"
tt.render.sprites[1].offset = v(0, 46)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "ember_lords_mage_tower_0002"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 46)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "ember_lords_mage_tower_shooter_lvl1"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUpRight",
		"shootDownRight"
	},
}
tt.render.sprites[3].offset = v(0, 52)
tt.main_script.update = scripts4.infernal_mage.update
tt.sound_events.insert = "InfernalMageTaunt"
tt.attacks.range = 160
tt.attacks.min_cooldown = 1.8
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_infernal_mage_lvl1"
tt.attacks.list[1].cooldown = 1.8
tt.attacks.list[1].node_prediction = fts(5)
tt.attacks.list[1].shoot_time = fts(15)
tt.attacks.list[1].bullet_start_offset = v(-5, 64)

--2级
tt = RT("tower_infernal_mage_lvl2", "tower_infernal_mage_lvl1")
tt.info.i18n_key = "TOWER_EMBER_LORDS_MAGE_LEVEL2"
tt.tower.level = 2
tt.tower.price = 180
tt.render.sprites[2].offset = v(0, 46)
tt.render.sprites[2].name = "ember_lords_mage_tower_0003"
tt.render.sprites[3].prefix = "ember_lords_mage_tower_shooter_lvl2"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 56)
tt.attacks.range = 170
tt.attacks.list[1].bullet = "bolt_infernal_mage_lvl2"

--3级
tt = RT("tower_infernal_mage_lvl3", "tower_infernal_mage_lvl2")
tt.info.i18n_key = "TOWER_EMBER_LORDS_MAGE_LEVEL3"
tt.tower.level = 3
tt.tower.price = 250
tt.render.sprites[2].offset = v(0, 46)
tt.render.sprites[2].name = "ember_lords_mage_tower_0004"
tt.render.sprites[3].prefix = "ember_lords_mage_tower_shooter_lvl3"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 62)
tt.attacks.range = 185
tt.attacks.list[1].bullet = "bolt_infernal_mage_lvl3"

--4级
tt = RT("tower_infernal_mage_lvl4", "g1_tower_mage_1")

AC(tt, "attacks", "powers")
tt.info.i18n_key = "TOWER_EMBER_LORDS_MAGE_LEVEL4"
image_y = 90
tt.tower.type = "infernal_mage"
tt.tower.level = 4
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 15
--tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0003") or "krv_portraits_0003"
tt.info.portrait = "gui4_bottom_info_image_towers_0005"
tt.powers.fissure = CC("power")
tt.powers.fissure.price_base = 170
tt.powers.fissure.price_inc = 170
tt.powers.fissure.cooldown_base = 20
tt.powers.fissure.cooldown_inc = 0
tt.powers.fissure.enc_icon = 321
tt.powers.fissure.name = "FISSURE"
tt.powers.teleport = CC("power")
tt.powers.teleport.price_base = 187
tt.powers.teleport.price_inc = 187
tt.powers.teleport.max_count = {
	4,
	6
}
tt.powers.teleport.enc_icon = 323
tt.powers.teleport.max_level = 2
tt.powers.curse = CC("power")
tt.powers.curse.max_level = 2
tt.powers.curse.price_base = 102 
tt.powers.curse.price_inc = 102
tt.powers.curse.enc_icon = 322
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_ember_lords_mage"
tt.render.sprites[1].offset = v(0, 46)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "ember_lords_mage_tower_lvl4_layer1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 46)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "ember_lords_mage_tower_shooter_lvl4"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUpRight",
		"shootDownRight"
	},
	affliction = {
		"afflictionUp",
		"afflictionDown"
	},
	overcharge = {
		"overchargeUp",
		"overchargeDown"
	},
	teleport = {
		"teleportUp",
		"teleportDown"
	},
	--[[
	spell = {
		"spellUp",
		"spellDown"
	},]]--
}
tt.render.sprites[3].offset = v(1, 60)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].prefix = "ember_lords_mage_tower_lvl4_layer2"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(0, 46)
tt.render.sprites[5] = CC("sprite")
tt.render.sprites[5].prefix = "ember_lords_mage_tower_lvl4_layer3"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(0, 46)
--[[
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_infernal_mage_teleport"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(-1, 85)
tt.render.sprites[5] = CC("sprite")
tt.render.sprites[5].name = "fx_tower_infernal_mage_curse"
tt.render.sprites[5].loop = false
tt.render.sprites[5].ts = -10
tt.render.sprites[5].offset = v(-1, 85)
tt.render.sprites[6] = CC("sprite")
tt.render.sprites[6].prefix = "tower_infernal_mage_bubble_2"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].animated = true
tt.render.sprites[6].loop = true
tt.render.sprites[6].offset = v(18, 41)
tt.render.sprites[7] = CC("sprite")
tt.render.sprites[7].prefix = "tower_infernal_mage_bubble_1"
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].animated = true
tt.render.sprites[7].loop = true
tt.render.sprites[7].offset = v(-18, 41)
tt.render.sprites[8] = CC("sprite")
tt.render.sprites[8].prefix = "tower_infernal_mage_bubble_3"
tt.render.sprites[8].name = "idle"
tt.render.sprites[8].animated = true
tt.render.sprites[8].loop = true
tt.render.sprites[8].offset = v(8, 33)
]]--
tt.main_script.update = scripts4.infernal_mage.update
tt.sound_events.insert = "InfernalMageTaunt"
tt.attacks.range = 200
tt.attacks.min_cooldown = 1.8
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_infernal_mage_lvl4"
tt.attacks.list[1].cooldown = 1.8
tt.attacks.list[1].node_prediction = fts(5)
tt.attacks.list[1].shoot_time = fts(15)
tt.attacks.list[1].bullet_start_offset = v(-5, 64)
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].bullet = "fissure_infernal_mage"
tt.attacks.list[2].sound = "InfernalMageFissure"
tt.attacks.list[2].shoot_time = fts(8)
tt.attacks.list[2].cooldown = 20
tt.attacks.list[2].vis_flags = bor(F_RANGED)
tt.attacks.list[2].vis_bans = bor(F_FLYING)
tt.attacks.list[2].animation = "overcharge"
tt.attacks.list[2].loops = 8
tt.attacks.list[2].bullet_start_offset = v(-5, 64)
tt.attacks.list[2].min_spread = 40
tt.attacks.list[2].max_spread = 40
tt.attacks.list[2].range = 180
tt.attacks.list[3] = CC("aura_attack")
tt.attacks.list[3].animation = "teleport"
tt.attacks.list[3].shoot_time = fts(15)
tt.attacks.list[3].cooldown = 22
tt.attacks.list[3].range = 180
tt.attacks.list[3].aura = "aura_teleport_infernal"
tt.attacks.list[3].min_nodes = 15
tt.attacks.list[3].node_prediction = fts(4)
tt.attacks.list[3].vis_flags = bor(F_RANGED, F_MOD, F_TELEPORT)
tt.attacks.list[3].vis_bans = bor(F_BOSS, F_FREEZE)
tt.attacks.list[4] = CC("aura_attack")
tt.attacks.list[4].animation = "affliction"
tt.attacks.list[4].shoot_time = fts(8)
tt.attacks.list[4].cooldown = 12
tt.attacks.list[4].range = 180
tt.attacks.list[4].aura = "aura_curse_infernal"
tt.attacks.list[4].min_nodes = 0
tt.attacks.list[4].node_prediction = fts(4)
tt.attacks.list[4].vis_flags = bor(F_RANGED, F_MOD)
tt.attacks.list[4].vis_bans = bor(F_FREEZE, F_FLYING)
tt.attacks.list[4].excluded_templates = {}

tt = RT("aura_teleport_infernal", "aura")

AC(tt, "render")

tt.aura.mod = "mod_teleport_infernal"
tt.aura.duration = fts(23)
tt.aura.apply_delay = fts(5)
tt.aura.apply_duration = fts(10)
tt.aura.max_count = 4
tt.aura.cycle_time = fts(2)
tt.aura.radius = 75
tt.aura.vis_flags = bor(F_RANGED, F_MOD, F_TELEPORT)
tt.aura.vis_bans = bor(F_BOSS, F_FRIEND, F_HERO, F_FREEZE)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].name = "ember_lords_mage_tower_shooter_lvl4_teleport_decal_run"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor.y = 0.375
tt.sound_events.insert = "TeleporthSound"

tt = RT("aura_curse_infernal", "aura")

AC(tt, "render")

tt.aura.mods = {
"mod_infernal_curse_armor",
"mod_infernal_curse_magic_armor"
}
tt.aura.duration = fts(23)
tt.aura.apply_delay = fts(5)
tt.aura.apply_duration = fts(10)
tt.aura.max_count = 100
tt.aura.cycle_time = fts(2)
tt.aura.radius = 45
tt.aura.vis_flags = bor(F_RANGED, F_MOD)
tt.aura.vis_bans = bor(F_FRIEND, F_HERO, F_FREEZE)
tt.main_script.insert = scripts4.aura_infernal_apply_mod.insert
tt.main_script.update = scripts4.aura_infernal_apply_mod.update
tt.render.sprites[1].name = "ember_lords_mage_tower_shooter_lvl4_affliction_floor_sign_run"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor.y = 0.375
tt.sound_events.insert = "InfernalMageCurse"

tt = RT("mod_infernal_curse_armor", "modifier")

AC(tt, "render")

tt.extra_armor = {
0.3,
0.6
}
tt.main_script.insert = scripts4.mod_affliction.insert
tt.main_script.remove = scripts4.mod_affliction.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = 5
tt.modifier.vis_flags = bor(F_MOD)
tt.render.sprites[1].name = "ember_lords_mage_tower_shooter_lvl4_affliction_modifier_run"
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
--tt.render.sprites[1].name = "small"

tt = RT("mod_infernal_curse_magic_armor", "modifier")

AC(tt, "render")

tt.extra_magic_armor = {
0.3,
0.6
}
tt.main_script.insert = scripts4.mod_affliction.insert
tt.main_script.remove = scripts4.mod_affliction.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = 5
tt.modifier.vis_flags = bor(F_MOD)
--tt.render.sprites[1].prefix = "infernal_curse_debuff"
--tt.render.sprites[1].loop = true
--tt.render.sprites[1].animated = true
--tt.render.sprites[1].name = "small"

tt = RT("fx_teleport_infernal", "fx")
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].name = "ember_lords_mage_tower_shooter_lvl4_teleport_effect_in" --这里原先是prefix
--[[
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}]]--
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.7,
		1.5,
		0.2,
		1.55,
	}
}

tt = RT("mod_teleport_infernal", "mod_teleport")
tt.delay_end = fts(6)
tt.delay_start = fts(1)
tt.fx_end = "fx_teleport_infernal"
tt.fx_start = "fx_teleport_infernal"
tt.max_times_applied = 4
tt.modifier.use_mod_offset = true
tt.modifier.vis_bans = bor(F_BOSS, F_FREEZE)
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.nodes_offset_min = -20
tt.nodes_offset_max = -20
tt.nodes_offset_inc = 0

tt = RT("ps_bolt_infernal_mage_lvl4", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 60
tt.particle_system.name = "ember_lords_mage_tower_lvl4_bolt_particle_run"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	0.8
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = RT("fx_bolt_infernal_mage_hit_lvl4", "fx")
tt.render.sprites[1].name = "ember_lords_mage_tower_shooter_lvl4_proyectile_hit"
--tt.render.sprites[1].name = "explosion"

tt = RT("ps_bolt_infernal_mage", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 60
tt.particle_system.name = "ember_lords_mage_tower_bolt_particle_run"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	0.8
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = RT("fx_bolt_infernal_mage_hit", "fx")
tt.render.sprites[1].name = "ember_lords_mage_tower_shooter_proyectile_hit"
--tt.render.sprites[1].name = "explosion"

tt = RT("bolt_infernal_mage_lvl4", "bolt")
tt.bullet.damage_max = 162--134
tt.bullet.damage_min = 94--78
tt.bullet.hit_fx = "fx_bolt_infernal_mage_hit_lvl4"
tt.bullet.max_speed = 300
tt.bullet.pop = nil
tt.bullet.particles_name = "ps_bolt_infernal_mage_lvl4"
tt.render.sprites[1].anchor = v(0.5, 0.5)
--tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.render.sprites[1].prefix = "ember_lords_mage_tower_shooter_lvl4_proyectile"
tt.sound_events.insert = "InfernalMageAttack"

tt = RT("bolt_infernal_mage_lvl1", "bolt_infernal_mage_lvl4")
tt.bullet.damage_max = 18--15
tt.bullet.damage_min = 10--8
tt.bullet.hit_fx = "fx_bolt_infernal_mage_hit"
tt.bullet.particles_name = "ps_bolt_infernal_mage"
--tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.render.sprites[1].prefix = "ember_lords_mage_tower_shooter_proyectile"

tt = RT("bolt_infernal_mage_lvl2", "bolt_infernal_mage_lvl1")
tt.bullet.damage_max = 53--44
tt.bullet.damage_min = 29--24

tt = RT("bolt_infernal_mage_lvl3", "bolt_infernal_mage_lvl1")
tt.bullet.damage_max = 104--86
tt.bullet.damage_min = 58--48

mod_lava = E:register_t("mod_lava_infernal_mage_lvl1", "mod_lava")
mod_lava.dps.damage_every = 0.1
mod_lava.modifier.duration = 0.75
mod_lava.dps.damage_min = 1
mod_lava.dps.damage_max = 1
mod_lava.dps.damage_inc = 0

mod_lava = E:register_t("mod_lava_infernal_mage_lvl2", "mod_lava_infernal_mage_lvl1")
mod_lava.dps.damage_min = 3
mod_lava.dps.damage_max = 3

mod_lava = E:register_t("mod_lava_infernal_mage_lvl3", "mod_lava_infernal_mage_lvl1")
mod_lava.dps.damage_min = 6
mod_lava.dps.damage_max = 6

mod_lava = E:register_t("mod_lava_infernal_mage_lvl4", "mod_lava_infernal_mage_lvl1")
mod_lava.dps.damage_min = 9
mod_lava.dps.damage_max = 9

tt = E.register_t(E, "fissure_infernal_mage", "arrow_arcane")
tt.bullet.flight_time_min = 0
tt.bullet.flight_time = 0
tt.bullet.miss_decal = nil
tt.bullet.mod = nil
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.admin = {
	32,
	66,
	100
}
tt.bullet.admax = {
	56,
	98,
	130
}
tt.main_script.update = scripts4.lava_fissure.update
tt.bullet.particles_name = nil
tt.bullet.hit_distance = 30
tt.bullet.payload = "aura_lava_fissure"
--tt.render.sprites[1].hidden = true
tt.render.sprites[1].name =  "ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_2"
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].z = Z_EFFECTS
tt.sound_events.insert = nil
tt.bullet.hit_blood_fx = nil
tt.sound_events.hit = "InfernalMageFissure"
tt.bullet.hit_fx = nil

tt = E.register_t(E, "aura_lava_fissure", "aura")

E.add_comps(E, tt, "render")

tt.aura.damage_min = nil
tt.aura.damage_max = nil
tt.aura.damage_type = DAMAGE_MAGICAL
tt.aura.radius = 30
tt.main_script.update = scripts4.aura_lava_fissure.update
tt.render.sprites[1].anchor.y = 0.2916666666666667
--tt.render.sprites[1].prefix = "decal_lava_fissure_new"
tt.render.sprites[1].prefix =  "ember_lords_mage_tower_shooter_lvl4_overcharge_meteor"
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].z = Z_EFFECTS

tt = E:register_t("decal_lords_mage", "decal_tween")
tt.render.sprites[1].name = "ember_lords_mage_tower_shooter_lvl4_overcharge_decal_1_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_1"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(4),
		255
	},
	{
		fts(6),
		0
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(4),
		v(1.84, 1.84)
	},
	{
		fts(6),
		v(2.17, 2.17)
	}
}
tt.tween.props[2].sprite_id = 1
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		255
	},
	{
		fts(4),
		48
	},
	{
		fts(9),
		0
	}
}
tt.tween.props[3].sprite_id = 2
tt.tween.props[4] = E:clone_c("tween_prop")
tt.tween.props[4].name = "scale"
tt.tween.props[4].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(4),
		v(1.64, 1.64)
	},
	{
		fts(6),
		v(2.07, 2.07)
	}
}
tt.tween.props[4].sprite_id = 2

--建造
tt = E:register_t("tower_build_melting_furnace", "tower_build")
tt.build_name = "tower_melting_furnace_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "darkarmy_melting_furnace_tower_lvl1_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 28)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E:register_t("tower_melting_furnace_lvl1", "tower")
E:add_comps(tt, "attacks")
tt.info.portrait = "gui4_bottom_info_image_towers_0007"
tt.info.i18n_key = "TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL1"
tt.info.enc_icon = 1
tt.tower.type = "melting_furnace"
tt.tower.price = 120
tt.tower.level = 1
tt.main_script.remove = scripts4.tower_melting_furnace.remove
tt.main_script.insert = scripts4.tower_melting_furnace.insert
tt.main_script.update = scripts4.tower_melting_furnace.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
for i = 2, 6 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "darkarmy_melting_furnace_tower_lvl1_layer" .. (i - 1)
	tt.render.sprites[i].name = "idle"
	--tt.render.sprites[i].group = "layer"
	tt.render.sprites[i].offset = v(0,30)
end
tt.attacks.range = 160
tt.attacks.list[1] = E:clone_c("area_attack")
tt.attacks.list[1].vis_flags = F_RANGED
tt.attacks.list[1].vis_bans = F_FLYING
tt.attacks.list[1].damage_flags = F_AREA
tt.attacks.list[1].damage_type = DAMAGE_PHYSICAL
tt.attacks.list[1].damage_bans = F_FLYING
tt.attacks.list[1].reduce_armor = 0.75
tt.attacks.list[1].cooldown = 4
tt.attacks.list[1].hit_time = 1.83
tt.attacks.list[1].mod = "mod_furnace_stun"
tt.attacks.list[1].damage_min = 6--6
tt.attacks.list[1].damage_max = 8--8
tt.attacks.list[1].sound = "MeltingFurnaceAttack"
tt.sound_events.insert = "MeltingFurnaceTaunt"

tt = E:register_t("tower_melting_furnace_lvl2", "tower_melting_furnace_lvl1")
tt.info.i18n_key = "TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL2"
tt.tower.price = 190
tt.tower.level = 2
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].offset = v(0,30)
for i = 2, 7 do
	tt.render.sprites[i].prefix = "darkarmy_melting_furnace_tower_lvl2_layer" .. (i - 1)
end
tt.attacks.range = 168
tt.attacks.list[1].damage_min = 17--16
tt.attacks.list[1].damage_max = 22--20

tt = E:register_t("tower_melting_furnace_lvl3", "tower_melting_furnace_lvl1")
tt.info.i18n_key = "TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL3"
tt.tower.price = 240
tt.tower.level = 3
for i = 2, 6 do
	tt.render.sprites[i].prefix = "darkarmy_melting_furnace_tower_lvl3_layer" .. (i - 1)
end
tt.attacks.range = 176
tt.attacks.list[1].damage_min = 30--28
tt.attacks.list[1].damage_max = 37--34

tt = E:register_t("tower_melting_furnace_lvl4", "tower_melting_furnace_lvl1")
E:add_comps(tt, "powers", "tween")
tt.info.i18n_key = "TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4"
--E:add_comps(tt, "powers")
tt.tower.price = 300
tt.tower.level = 4
tt.powers.coal = E:clone_c("power")
tt.powers.coal.price_base = 119--140
tt.powers.coal.price_inc = 119--140
tt.powers.coal.enc_icon = 330
tt.powers.coal.max_level = 2
tt.powers.coal.fragment_count_base = 1
tt.powers.coal.fragment_count_inc = 2
tt.powers.heat = E:clone_c("power")
tt.powers.heat.price_base = 170--200
tt.powers.heat.price_inc = 170--200
tt.powers.heat.name = "HEAT"
tt.powers.heat.enc_icon = 332
tt.powers.heat.max_level = 2
tt.powers.fuel = E:clone_c("power")
tt.powers.fuel.price_base = 212--250
tt.powers.fuel.price_inc = 0
tt.powers.fuel.enc_icon = 331
tt.powers.fuel.max_level = 1

for i = 2, 9 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "darkarmy_melting_furnace_tower_lvl4_layer" .. (i - 1)
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 40)
end
tt.render.sprites[10] = E:clone_c("sprite")
tt.render.sprites[10].name = "darkarmy_melting_furnace_red_glow"
tt.render.sprites[10].animated = false
tt.render.sprites[10].hidden = true
tt.render.sprites[10].offset = v(0, 40)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{0, 0},
	{fts(10), 255},
	{fts(67), 255},
	{fts(73), 0}
}
tt.tween.props[1].sprite_id = 10
tt.tween.remove = false
tt.tween.disabled = true

tt.attacks.range = 186
tt.attacks.list[1].damage_min = 48--44
tt.attacks.list[1].damage_max = 57--52
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].vis_flags = bor(F_AREA)
tt.attacks.list[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.attacks.list[2].sound = "MeltingFurnaceHotCoal"
tt.attacks.list[2].bullet = "melting_furnace_coal"
tt.attacks.list[2].bullet_start_offset = v(8, 64)
tt.attacks.list[2].fragment_node_spread = 7
tt.attacks.list[2].fragment_pos_spread = v(6, 6)
tt.attacks.list[2].range = 165
tt.attacks.list[2].cooldown = 15
tt.attacks.list[2].shoot_time = 0
tt.attacks.list[2].hit_time = 1.73
tt.attacks.list[2].node_prediction = 0.9
tt.attacks.list[3] = E:clone_c("mod_attack")
tt.attacks.list[3].mod = "mod_furnace_buff"
tt.attacks.list[3].range = 265
tt.attacks.list[3].cooldown = 0.5
tt.attacks.list[3].off_range = 20
tt.attacks.list[3].excluded_templates = {
  "tower_barrack_1",
  "tower_barrack_2",
  "tower_barrack_3",
  "tower_barbarian",
  "tower_paladin",
  "tower_assassin",
  "tower_templar",
  "tower_forest",
  "tower_blade",
  "tower_elf_kr1",
  "tower_imperial_patrol",
  "tower_barrack_pirate_captain",
  "tower_barrack_pirate_captain_2",
  "tower_barrack_pirate_flamer_2",
  "tower_barrack_pirate_anchor_2",
  "tower_barrack_amazonas_re",
  "tower_barrack_dwarf",
  "tower_ewok_rework",
  "tower_drow",
  "tower_orc_warriors_den",
  "tower_dark_knights",
  "tower_elven_barrack_1",
  "tower_elven_barrack_2",
  "tower_elven_barrack_3",
  "tower_sasquash_rework",
  "tower_baby_ashbite",
  "tower_pixie",
  "tower_barrack_1_krf",
  "tower_barrack_2_krf",
  "tower_barrack_3_krf",
  "tower_elite_harassers",
  "tower_steam_troop"
}
tt.attacks.list[4] = E:clone_c("mod_attack")
tt.attacks.list[4].mod = "mod_furnace_fuel"
tt.attacks.list[4].cooldown = 30
tt.attacks.list[4].boost = false

tt = E:register_t("decal_melting_furnace_smoke", "decal_timed")
tt.render.sprites[1].prefix = "darkarmy_melting_furnace_smoke"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].z = Z_DECALS

tt = E:register_t("mod_furnace_fuel", "modifier")
E:add_comps(tt, "render")
tt.modifier.duration = 10
tt.effect = {
	sound = "MeltingFurnaceAttackFuel",
	cooldown = 2,
	hit_time = 0.267
}
tt.main_script.update = scripts4.mod_furnace_fuel.update
tt.main_script.remove = scripts4.mod_furnace_fuel.remove
tt.render.sprites[1].prefix = "darkarmy_melting_furnace_tower_lvl4_flames"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].offset.y = 28
tt.render.sprites[1].draw_order = 10

tt = E:register_t("mod_furnace_buff", "modifier")

E:add_comps(tt, "render")

tt.extra_damage = 0.15
tt.main_script.insert = scripts4.mod_furnace_buff.insert
tt.main_script.remove = scripts4.mod_furnace_buff.remove
tt.render.sprites[1].name = "darkarmy_melting_furnace_tower_swords_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.21
tt.render.sprites[1].offset = v(0, -10)
tt.render.sprites[1].draw_order = 11

tt = RT("melting_furnace_coal", "bomb")
AC(tt, "sound_events")
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = 0.7
tt.bullet.hit_fx = nil
tt.bullet.hit_payload = "lava_furnace"
tt.bullet.hide_radius = 2
tt.bullet.rotation_speed = 2 * math.pi * 5 / 3
tt.bullet.align_with_trajectory = false
tt.main_script.update = scripts4.melting_furnace_coal.update
tt.render.sprites[1].name = "darkarmy_melting_furnace_tower_travel_particle"
tt.render.sprites[1].animated = false
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = E:register_t("lava_furnace", "aura")
E:add_comps(tt, "aura", "render", "tween")
tt.aura.duration = 6
tt.aura.cycle_time = 0.2
tt.aura.radius = 37
tt.aura.damage_min = 2
tt.aura.damage_max = 2
tt.aura.damage_inc = 3
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD, F_LAVA)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts4.melting_furnace_coal.lava_update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "darkarmy_melting_furnace_decal_fissure_0001"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "darkarmy_melting_furnace_tower_lvl4_fissure_hit"
tt.render.sprites[2].name = "start"
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_DECALS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].keys = {
	{ 0, 0 },
	{ fts(12), 255 },
	{ tt.aura.duration - 0.5, 255 },
	{ tt.aura.duration, 0 }
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].keys = {
	{ 0, 255 },
	{ tt.aura.duration - 0.5, 255 },
	{ tt.aura.duration, 0 }
}

tt = RT("mod_furnace_stun", "mod_stun")
tt.modifier.duration = 0.6
tt.modifier.vis_bans = F_BOSS
tt.render.sprites[1].hidden = true


----------------------------------------------
-----------------哥布林回旋镖------------------
----------------------------------------------
tt = E:register_t("tower_build_goblirang", "tower_build")
tt.build_name = "tower_goblirang_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2].name = "warmongers_archer_tower_lvl1_0002"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 35)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
tt = RT("tower_goblirang_lvl1", "g1_tower_archer_1")

AC(tt, "attacks")
image_y = 90
tt.tower.type = "goblirang"
tt.tower.level = 1
tt.tower.price = 90
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 13
tt.info.i18n_key = "TOWER_WARMONGER_ARCHER_LEVEL1"
tt.info.portrait = "gui4_bottom_info_image_towers_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "warmongers_archer_tower_lvl1_0001"
tt.render.sprites[2].offset = v(0, 38)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "warmongers_archer_tower_shooter_lvl1"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUpIn",
		"shootDownIn"
	},
}
tt.render.sprites[3].offset = v(-8, 53)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset.x = 8
tt.render.sprites[5] = CC("sprite")
tt.render.sprites[5].animated = false
tt.render.sprites[5].name = "warmongers_archer_tower_lvl1_over"
tt.render.sprites[5].offset = v(0, 38)
tt.main_script.update = scripts4.tower_goblirang.update
tt.attacks.range = 168
tt.attacks.node_prediction = 0.6
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "goblirang_lvl1"
tt.attacks.list[1].cooldown = 1.4
tt.attacks.list[1].shoot_time = 0.2
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet_start_offset = {
	v(8, -1),
	v(4, -1)
}
tt.sound_events.insert = "GoblirangsTaunt"

tt = RT("tower_goblirang_lvl2", "tower_goblirang_lvl1")
tt.info.i18n_key = "TOWER_WARMONGER_ARCHER_LEVEL2"
tt.tower.type = "goblirang"
tt.tower.level = 2
tt.tower.price = 140
tt.render.sprites[2].name = "warmongers_archer_tower_lvl2_0001"
tt.render.sprites[2].offset = v(0, 38) 
tt.render.sprites[3].prefix = "warmongers_archer_tower_shooter_lvl2"
tt.render.sprites[3].offset = v(-8, 58)
tt.render.sprites[4].offset.x = 8
tt.render.sprites[5].name = "warmongers_archer_tower_lvl2_over"
tt.render.sprites[5].offset = v(0, 38)
tt.attacks.range = 178.5
tt.attacks.list[1].bullet = "goblirang_lvl2"
tt.attacks.list[1].bullet_start_offset = {
	v(8, -1),
	v(4, -10)
}

tt = RT("tower_goblirang_lvl3", "tower_goblirang_lvl1")
tt.info.i18n_key = "TOWER_WARMONGER_ARCHER_LEVEL3"
tt.tower.type = "goblirang"
tt.tower.level = 3
tt.tower.price = 200
tt.render.sprites[2].name = "warmongers_archer_tower_lvl3_0001"
tt.render.sprites[2].offset = v(0, 38) 
tt.render.sprites[3].prefix = "warmongers_archer_tower_shooter_lvl3"
tt.render.sprites[3].offset = v(-8, 63)
tt.render.sprites[4].offset.x = 8
tt.render.sprites[5].name = "warmongers_archer_tower_lvl3_over"
tt.render.sprites[5].offset = v(0, 38)
tt.attacks.range = 194
tt.attacks.list[1].bullet = "goblirang_lvl3"
tt.attacks.list[1].bullet_start_offset = {
	v(8, -1),
	v(4, -10)
}

tt = RT("tower_goblirang_lvl4", "g1_tower_archer_1")

AC(tt, "powers")
image_y = 90
tt.tower.type = "goblirang"
tt.tower.level = 4
tt.tower.price = 270
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 13
tt.info.i18n_key = "TOWER_WARMONGER_ARCHER_LEVEL4"
--tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0012") or "krv_portraits_0012"
tt.powers.stun = CC("power")
tt.powers.stun.price_base = 110--130
tt.powers.stun.price_inc = 110--130
tt.powers.stun.mod = "mod_goblirang_stun"
tt.powers.stun.enc_icon = 308
tt.powers.stun.mod_chance = {0.05,0.1,0.15}
tt.powers.bees = CC("power")
tt.powers.bees.price_base = 170--200
tt.powers.bees.price_inc = 170--200
tt.powers.bees.enc_icon = 307
tt.powers.bees.name = "bees"
tt.powers.big = CC("power")
tt.powers.big.price_base = 170--200
tt.powers.big.price_inc = 85--100
tt.powers.big.enc_icon = 309
tt.powers.big.damage_min = {57,69,96}
tt.powers.big.damage_max = {85,100,115}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "warmongers_archer_tower_lvl4_0001"
tt.render.sprites[2].offset = v(0, 38)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "warmongers_archer_tower_shooter_lvl4"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUpIn",
		"shootDownIn"
	},
	big = {
		"megaShootUpIn1",
		"megaShootDownIn1"
	},
	bees = {
		"shootHoneyUp",
		"shootHoneyDown"
	}
}
tt.render.sprites[3].offset = v(-8, 68)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset.x = 8
tt.render.sprites[5] = CC("sprite")
tt.render.sprites[5].animated = false
tt.render.sprites[5].name = "warmongers_archer_tower_lvl4_over"
tt.render.sprites[5].offset = v(0, 38)
tt.main_script.update = scripts4.tower_goblirang.update
tt.attacks.range = 210
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "goblirang_lvl4"
tt.attacks.list[1].cooldown = 1.4
tt.attacks.list[1].shoot_time = 0.2
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet_start_offset = {
	v(8, -1),
	v(4, -10)
}
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].animation = "big"
tt.attacks.list[2].bullet = "goblirang_big"
tt.attacks.list[2].cooldown = 12
tt.attacks.list[2].shoot_time = 0.6
tt.attacks.list[2].shooters_delay = 0.1
tt.attacks.list[2].bullet_start_offset = {
	v(8, -1),
	v(4, -10)
}
tt.attacks.list[3] = CC("bullet_attack")
tt.attacks.list[3].animation = "bees"
tt.attacks.list[3].bullet = "honey_bees_proy"
tt.attacks.list[3].cooldown = 18
tt.attacks.list[3].shoot_time = 0.2
tt.attacks.list[3].shooters_delay = 0.1
tt.attacks.list[3].bullet_start_offset = {
	v(8, -1),
	v(4, -10)
}
tt.attacks.list[3].range = 150
tt.attacks.list[3].vis_bans = bor(F_FLYING)
tt.sound_events.insert = "GoblirangsTaunt"

tt = RT("fx_goblirang_bees", "fx")
tt.render.sprites[1].prefix = "explosion_honey"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false

tt = E.register_t(E, "honey_bees_proy", "arrow")
tt.render.sprites[1].name = "warmongers_archerhoney_tower_proyectile_lvl4"
tt.render.sprites[1].animated = false
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = nil
tt.bullet.hit_fx = "fx_goblirang_bees"
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.main_script.update = scripts4.honey_bees.update
tt.bullet.payload = "honey_bees_aura"
tt.bullet.pop = {
  "pop_thunk"
}
tt.bullet.pop_chance = 0
tt.bullet.pop_conds = DR_KILL
tt.sound_events.insert = "GoblirangBeesSound"

tt = E.register_t(E, "honey_bees_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.cycle_time = 0.2
tt.aura.duration = 7
tt.aura.mod = "mod_honey_bees"
tt.aura.radius = 40
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.aura.track_target = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts4.honey_bees_aura.update
tt.render.sprites[1].prefix = "explosion_honey"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].offset = v(0, 10)
tt.sound_events.insert = "GoblirangsBeesHit"

tt = E.register_t(E, "mod_goblirang_slow", "mod_slow")
tt.modifier.duration = 0.1
tt.slow.factor = 0.5
tt.modifier.vis_bans = bor(F_BOSS)

tt = E.register_t(E, "mod_honey_bees", "modifier")

E.add_comps(E, tt, "dps", "render")

tt.dps.damage_min = 0
tt.dps.damage_max = 0
tt.dps.damage_inc = 5
tt.dps.damage_type = DAMAGE_PHYSICAL
tt.dps.damage_every = 0.3
tt.dps.kill = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = 0.33
tt.render.sprites[1].hidden = true

tt = RT("fx_goblirang_hit", "fx")
tt.render.sprites[1].prefix = "warmongers_archer_tower_proyectile_hit"
tt.render.sprites[1].name = "run"

tt = RT("ps_goblirang", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 10
tt.particle_system.name = "goblirangs_proy_0001"
tt.particle_system.particle_lifetime = {
	0.3,
	0.3
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	1
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = RT("ps_goblirang_lvl1", "ps_goblirang")
tt.particle_system.name = "warmongers_archer_tower_proyectile_lvl1"
tt = RT("ps_goblirang_lvl2", "ps_goblirang")
tt.particle_system.name = "warmongers_archer_tower_proyectile_lvl2"
tt = RT("ps_goblirang_lvl3", "ps_goblirang")
tt.particle_system.name = "warmongers_archer_tower_proyectile_lvl3"
tt = RT("ps_goblirang_lvl4", "ps_goblirang")
tt.particle_system.name = "warmongers_archer_tower_proyectile_lvl4"

tt = E.register_t(E, "goblirang", "bullet")
tt.main_script.update = scripts4.goblirang.update
tt.bullet.particles_name = "ps_goblirang"
tt.bullet.flight_time = fts(18)
tt.bullet.damage_every = 0.01
tt.radius = 20
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.damage_min = 25
tt.bullet.damage_max = 47
tt.bullet.mod2 = "mod_goblirang_slow"
tt.bullet.mod_chance = 0
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_goblirang_hit"
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.rotation_speed = FPS * math.pi / 4
tt.render.sprites[1].name = "warmongers_archer_tower_proyectile_lvl1"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "GoblirangSound"

tt = E.register_t(E, "goblirang_lvl1", "goblirang")
tt.bullet.particles_name = "ps_goblirang_lvl1"
tt.bullet.damage_min = 3
tt.bullet.damage_max = 5
tt.render.sprites[1].name = "warmongers_archer_tower_proyectile_lvl1"

tt = E.register_t(E, "goblirang_lvl2", "goblirang")
tt.bullet.particles_name = "ps_goblirang_lvl2"
tt.bullet.damage_min = 7
tt.bullet.damage_max = 15
tt.render.sprites[1].name = "warmongers_archer_tower_proyectile_lvl2"

tt = E.register_t(E, "goblirang_lvl3", "goblirang")
tt.bullet.particles_name = "ps_goblirang_lvl3"
tt.bullet.damage_min = 15
tt.bullet.damage_max = 28
tt.render.sprites[1].name = "warmongers_archer_tower_proyectile_lvl3"

tt = E.register_t(E, "goblirang_lvl4", "goblirang")
tt.radius = 23
tt.bullet.particles_name = "ps_goblirang_lvl4"
tt.bullet.damage_min = 27
tt.bullet.damage_max = 51
tt.render.sprites[1].name = "warmongers_archer_tower_proyectile_lvl4"

tt = RT("fx_goblirang_big_hit", "fx")
tt.render.sprites[1].prefix = "warmongers_archer_tower_proyectile_special_hit"
tt.render.sprites[1].name = "run"

tt = RT("ps_goblirang_big", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 10
tt.particle_system.name = "warmongers_archer_tower_proyectile_special_lvl4"
tt.particle_system.particle_lifetime = {
	0.3,
	0.3
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	1
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = E.register_t(E, "goblirang_big", "goblirang")
tt.bullet.particles_name = "ps_goblirang_big"
tt.bullet.mod2 = "mod_goblirang_slow"
tt.bullet.mod_chance = 0
tt.bullet.damage_every = 0.01
tt.bullet.flight_time = fts(21)
tt.radius = 35
tt.bullet.damage_min = 57
tt.bullet.damage_max = 85
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_goblirang_big_hit"
tt.render.sprites[1].name = "warmongers_archer_tower_proyectile_special_lvl4"
tt.sound_events.insert = "GoblirangSound"

tt = RT("mod_goblirang_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 1.2
tt.modifier.vis_bans = F_BOSS
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "stun"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}


----------------------------------------------
--------------------掷骨者---------------------
----------------------------------------------

tt = E:register_t("tower_build_bone_flingers", "tower_build")
tt.build_name = "tower_bone_flingers_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "boneflingers_tower_lvl1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(2, 25)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E.register_t(E, "tower_bone_flingers_lvl4", "tower_archer_1")

E.add_comps(E, tt, "powers", "barrack")

tt.info.portrait = "gui4_bottom_info_image_towers_0012"
tt.info.enc_icon = 18
tt.info.i18n_key = "TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4"
tt.info.fn = scripts4.tower_bone_flingers.get_info
tt.tower.type = "bone_flingers"
tt.tower.price = 180
tt.tower.level = 4
tt.powers.skeleton = E.clone_c(E, "power")
tt.powers.skeleton.price_base = 153--180
tt.powers.skeleton.price_inc = 153--180
tt.powers.skeleton.enc_icon = 337
tt.powers.skeleton.max_level = 2
tt.powers.skeleton.cooldown = { 16, 12 }
tt.powers.skeleton.vis_flags = bor(F_BLOCK)
tt.powers.skeleton.vis_bans = bor(F_FLYING)
tt.powers.golem = E.clone_c(E, "power")
tt.powers.golem.price_base = 255--300
tt.powers.golem.price_inc = 255--300
tt.powers.golem.name = "GOLEM"
tt.powers.golem.max_level = 1
tt.powers.golem.enc_icon = 336
tt.powers.milk = E.clone_c(E, "power")
tt.powers.milk.price_base = 93--110
tt.powers.milk.price_inc = 93--110
tt.powers.milk.enc_icon = 338
tt.powers.milk.damage_inc = { 5, 10, 15 }
tt.barrack.soldier_type = "soldier_bone_golem"
tt.barrack.rally_range = 159.5
tt.barrack.max_soldiers = 0
tt.main_script.insert = scripts4.tower_bone_flingers.insert
tt.main_script.remove = scripts4.tower_bone_flingers.remove
tt.main_script.update = scripts4.tower_bone_flingers.update
tt.attacks.range = 186.375
tt.attacks.list[1].bullet = "bone_flingers_bone"
tt.attacks.list[1].cooldown = 0.6
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].bullet_start_offset = {
  v(-9, 65),
  v(17, 59)
}
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].bullet = "bone_flingers_skelebomb"
tt.attacks.list[2].cooldown = 12
tt.attacks.list[2].disabled = true
tt.attacks.list[2].vis_bans = bor(F_CLIFF)
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "boneflingers_tower_lvl4_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 27)
tt.render.sprites[3].prefix = "boneflingers_shooter"
tt.render.sprites[3].offset = v(-7, 53)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].prefix = "boneflingers_shooter"
tt.render.sprites[4].offset = v(17, 45)
--tt.render.sprites[5] = E.clone_c(E, "sprite")
--tt.render.sprites[5].name = "tower_bone_flingers_base_0002"
--tt.render.sprites[5].animated = false
--tt.render.sprites[5].offset = v(0, 27)
tt.sound_events.insert = "BoneFlingersTaunt"
tt.sound_events.change_rally_point = "BoneFlingersGolemTaunt"

tt = E.register_t(E, "tower_bone_flingers_lvl1", "tower_bone_flingers_lvl4")
tt.info.i18n_key = "TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL1"
tt.tower.price = 60
tt.tower.level = 1
tt.render.sprites[2].name = "boneflingers_tower_lvl1_0002"
tt.render.sprites[2].offset = v(2, 25)
tt.render.sprites[3].offset = v(2, 40)
tt.render.sprites[4].hidden = true
tt.attacks.range = 157.5
tt.attacks.list[1].bullet = "bone_flingers_bone_lvl1"

tt = E.register_t(E, "tower_bone_flingers_lvl2", "tower_bone_flingers_lvl4")
tt.info.i18n_key = "TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL2"
tt.tower.price = 110
tt.tower.level = 2
tt.render.sprites[2].name = "boneflingers_tower_lvl2_0001"
tt.render.sprites[2].offset = v(0, 24)
tt.render.sprites[3].offset = v(-7, 45)
tt.render.sprites[4].offset = v(15, 40)
tt.render.sprites[4].hidden = false
tt.attacks.range = 166
tt.attacks.list[1].bullet = "bone_flingers_bone_lvl2"

tt = E.register_t(E, "tower_bone_flingers_lvl3", "tower_bone_flingers_lvl4")
tt.info.i18n_key = "TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL3"
tt.tower.price = 150
tt.tower.level = 3
tt.render.sprites[2].name = "boneflingers_tower_lvl3_0001"
tt.render.sprites[2].offset = v(0, 24)
tt.render.sprites[3].offset = v(-9, 48)
tt.render.sprites[4].offset = v(15, 45)
tt.attacks.range = 174
tt.attacks.list[1].bullet = "bone_flingers_bone_lvl3"

tt = RT("bone_flingers_skelebomb2", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = 0.01
tt.bullet.fragment_count = 1
tt.bullet.fragment_name = "bone_flingers_skelefrag2"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.fragment_node_spread = 0
tt.bullet.fragment_pos_spread = v(0, 0)
tt.bullet.dest_pos_offset = v(0, 1)
tt.bullet.dest_prediction_time = 0
tt.main_script.insert = scripts.bomb_cluster.insert
tt.main_script.update = scripts4.skeleflingerbomb.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("bone_flingers_skelefrag2", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 1
tt.bullet.hit_decal = nil
tt.bullet.flight_time_base = 0
tt.bullet.flight_time_factor = 0
tt.bullet.flight_time = 0.01
tt.bullet.pop = nil
tt.bullet.hit_payload = "bone_flingers_skelespawn2"
tt.main_script.update = scripts4.bomb_kro.update
tt.bullet.hit_fx = nil
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("bone_flingers_skelespawn2", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts4.enemies_skelespawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = nil
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.check_node_valid = true
tt.spawner.use_node_pos = true
tt.spawner.entity = "soldier_flingers_skeleton_warrior"
tt.spawner.keep_gold = false
tt.spawner.node_offset = 0
tt.spawner.pos_offset = v(0, 0)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = true
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		4,
		0
	}
}
tt.tween.remove = true

tt = RT("bone_flingers_skelebomb", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = 0.01
tt.bullet.fragment_count = 1
tt.bullet.fragment_name = "bone_flingers_skelefrag"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.fragment_node_spread = 0
tt.bullet.fragment_pos_spread = v(0, 0)
tt.bullet.dest_pos_offset = v(0, 1)
tt.bullet.dest_prediction_time = 0
tt.main_script.insert = scripts.bomb_cluster.insert
tt.main_script.update = scripts4.skeleflingerbomb.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("bone_flingers_skelefrag", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 1
tt.bullet.hit_decal = nil
tt.bullet.flight_time_base = 0
tt.bullet.flight_time_factor = 0
tt.bullet.flight_time = 0.01
tt.bullet.pop = nil
tt.bullet.hit_payload = "bone_flingers_skelespawn"
tt.main_script.update = scripts4.bomb_kro.update
tt.bullet.hit_fx = nil
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("bone_flingers_skelespawn", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts4.enemies_skelespawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = nil
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "soldier_flingers_skeleton"
tt.spawner.keep_gold = false
tt.spawner.node_offset = 0
tt.spawner.pos_offset = v(0, 0)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = true
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		4,
		0
	}
}
tt.tween.remove = true

tt = E.register_t(E, "bone_flingers_bone", "arrow")
tt.render.sprites[1].name = "boneflingers_shooter_proyectiles_0004"
tt.render.sprites[1].animated = false
tt.bullet.rotation_speed = 3 * math.pi
tt.bullet.miss_decal = "boneflingers_shooter_proyectiles_decals_0004"
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.damage_min = 15
tt.bullet.damage_max = 37
tt.bullet.pop = {
  "pop_thunk"
}
tt.bullet.reset_to_target_pos = true
tt.bullet.pop_chance = 0
tt.bullet.pop_conds = DR_KILL
tt.sound_events.insert = "GoblirangSound"

tt = E.register_t(E, "bone_flingers_bone_lvl1", "bone_flingers_bone")
tt.render.sprites[1].name = "boneflingers_shooter_proyectiles_0001"
tt.bullet.miss_decal = "boneflingers_shooter_proyectiles_decals_0001"
tt.bullet.damage_min = 2
tt.bullet.damage_max = 4

tt = E.register_t(E, "bone_flingers_bone_lvl2", "bone_flingers_bone")
tt.render.sprites[1].name = "boneflingers_shooter_proyectiles_0002"
tt.bullet.miss_decal = "boneflingers_shooter_proyectiles_decals_0002"
tt.bullet.damage_min = 5
tt.bullet.damage_max = 12

tt = E.register_t(E, "bone_flingers_bone_lvl3", "bone_flingers_bone")
tt.render.sprites[1].name = "boneflingers_shooter_proyectiles_0003"
tt.bullet.miss_decal = "boneflingers_shooter_proyectiles_decals_0003"
tt.bullet.damage_min = 9
tt.bullet.damage_max = 22


tt = E.register_t(E, "bone_golem_bone", "arrow")
tt.render.sprites[1].name = "boneflingers_shooter_proyectiles_0001"
tt.render.sprites[1].animated = false
tt.bullet.rotation_speed = 3 * math.pi
tt.bullet.miss_decal = "boneflingers_shooter_proyectiles_decals_0001"
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.damage_min = 17
tt.bullet.damage_max = 31
tt.bullet.pop = {
  "pop_thunk"
}
tt.bullet.reset_to_target_pos = true
tt.bullet.pop_chance = 0
tt.bullet.pop_conds = DR_KILL
tt.sound_events.insert = "GoblirangSound"

tt = E.register_t(E, "bone_golem_bone_2", "bone_golem_bone")
tt.bullet.damage_min = 17
tt.bullet.damage_max = 31

tt = E.register_t(E, "bone_golem_bone_3", "bone_golem_bone")
tt.bullet.damage_min = 17
tt.bullet.damage_max = 31

tt = E.register_t(E, "bone_golem_bone_4", "bone_golem_bone")
tt.bullet.damage_min = 17
tt.bullet.damage_max = 31

tt = RT("soldier_bone_golem", "soldier_militia")
AC(tt, "melee", "ranged", "nav_grid")
tt.health.armor = 0
tt.health.armor_inc = 0
tt.health.dead_lifetime = 10
tt.health.hp_max = 390
tt.health.hp_inc = 0
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "SOLDIER_BONE_GOLEM"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0023"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1.3
tt.melee.attacks[1].damage_inc = 0
tt.melee.attacks[1].damage_max = 41
tt.melee.attacks[1].damage_min = 17
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].sound_hit = "KRVGenericCombat"
tt.melee.range = 60
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "bone_golem_bone"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-9, 41)
}
tt.ranged.attacks[1].cooldown = 1
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(10)
tt.motion.max_speed = 27
tt.regen.health = 30
tt.regen.cooldown = 2
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "boneflingers_tower_lvl4_golem"
tt.render.sprites[1].anchor = v(0.52, 0.15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor = v(0.52, 0.15)
tt.render.sprites[2].name = "boneflingers_tower_lvl4_golem_shadow"
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "BoneFlingersSummon"
tt.sound_events.death = "BoneFlingersSummon"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)

tt = RT("soldier_bone_golem_1", "soldier_bone_golem")
tt.ranged.attacks[1].bullet = "bone_golem_bone_2"

tt = RT("soldier_bone_golem_2", "soldier_bone_golem")
tt.ranged.attacks[1].bullet = "bone_golem_bone_3"

tt = RT("soldier_bone_golem_3", "soldier_bone_golem")
tt.ranged.attacks[1].bullet = "bone_golem_bone_4"

tt = E:register_t("soldier_flingers_skeleton", "unit")

E:add_comps(tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events")

anchor_y = 0.2
image_y = 36
tt.info.portrait = "gui4_bottom_info_image_soldiers_0019"
tt.health.armor = 0
tt.health.hp_inc = 0
tt.health.hp_max = 80
tt.health_bar.offset = v(0, ady(39))
tt.info.fn = scripts4.soldier_flingers_skeleton.get_info
tt.info.i18n_key = "SOLDIER_FLINGERS_SKELETON"
tt.main_script.insert = scripts4.soldier_flingers_skeleton.insert
tt.main_script.update = scripts4.soldier_flingers_skeleton.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 60
tt.motion.max_speed = 35
tt.nav_path.dir = -1
tt.render.sprites[1].anchor.y = 0.15
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "boneflingers_tower_lvl4_skeleton"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].anchor.y = 0.15
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "boneflingers_tower_lvl4_skeleton_shadow"
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset.x = 5
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_LYCAN)
tt.vis.flags = F_FRIEND
tt.sound_events.insert = "BoneFlingersSummon"
tt.sound_events.death = "DeathSkeleton"

tt = E:register_t("soldier_flingers_skeleton_warrior", "soldier_flingers_skeleton")
tt.health.hp_max = 160
tt.health_bar.offset = v(0, ady(39))
tt.info.i18n_key = "SOLDIER_FLINGERS_SKELETON_WARRIOR"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0020"
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.render.sprites[1].prefix = "boneflingers_tower_lvl4_skeletonwarrior"
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].name = "boneflingers_tower_lvl4_skeletonwarrior_shadow"


----------------------------------------------
-------------------兽人巢穴--------------------
----------------------------------------------

tt = E:register_t("tower_build_orc_warriors_den", "tower_build")
tt.build_name = "tower_orc_warriors_den_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "warmongers_barrack_towers_lvl1_layer1_0008"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 33)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62


tt = E.register_t(E, "tower_orc_warriors_den_lvl4", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.fn = scripts4.tower_orc_warriors_den.get_info
tt.main_script.update = scripts4.tower_orc_warriors_den.update
tt.info.enc_icon = 18
tt.info.i18n_key = "TOWER_WARMONGER_BARRACK_LEVEL4"
tt.info.portrait = "gui4_bottom_info_image_towers_0001"
tt.barrack.soldier_type = "soldier_orc_warrior_lvl4"
tt.barrack.rally_range = 159.5
tt.powers.seal = E.clone_c(E, "power")
tt.powers.seal.price_base = 102--120
tt.powers.seal.price_inc = 102--120
tt.powers.seal.max_level = 2
tt.powers.seal.enc_icon = 306
tt.powers.seal.heal_inc = {
5,
5
}
tt.powers.promotion = E.clone_c(E, "power")
tt.powers.promotion.price_base = 127--150
tt.powers.promotion.price_inc = 127--150
tt.powers.promotion.enc_icon = 305
tt.powers.promotion.max_level = 1
tt.powers.promotion.regen = 30
tt.powers.promotion.damage_min = 17
tt.powers.promotion.damage_max = 25
tt.powers.promotion.hp_max = 390
tt.powers.promotion.armor = 0.5
tt.powers.bloodlust = E.clone_c(E, "power")
tt.powers.bloodlust.price_base = 153--180
tt.powers.bloodlust.price_inc = 153--180
tt.powers.bloodlust.max_level = 2
tt.powers.bloodlust.enc_icon = 304
tt.powers.bloodlust.damage_factor = {
1.4,
1.8
}
tt.powers.bloodlust.name = "BLOODLUST"
tt.render.sprites[2].name = "warmongers_barrack_towers_lvl4_layer1_0002"
tt.render.sprites[2].offset = v(0, 33)
tt.render.sprites[3].prefix = "warmongers_barrack_towers_lvl4_layer2"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 33)

tt.sound_events.change_rally_point = "Orc_WarmongersTaunt"
tt.sound_events.insert = "Orc_WarmongersTaunt"
tt.tower.price = 230
tt.tower.level = 4
tt.tower.type = "orc_warriors_den"


tt = E.register_t(E, "tower_orc_warriors_den_lvl1", "tower_orc_warriors_den_lvl4")
tt.tower.price = 70
tt.tower.level = 1
tt.render.sprites[3].prefix = "warmongers_barrack_towers_lvl1_layer2"
tt.render.sprites[2].name = "warmongers_barrack_towers_lvl1_layer1_0002"
tt.info.i18n_key = "TOWER_WARMONGER_BARRACK_LEVEL1"
tt.barrack.soldier_type = "soldier_orc_warrior_lvl1"

tt = E.register_t(E, "tower_orc_warriors_den_lvl2", "tower_orc_warriors_den_lvl4")
tt.tower.price = 110
tt.tower.level = 2
tt.render.sprites[3].prefix = "warmongers_barrack_towers_lvl2_layer2"
tt.render.sprites[2].name = "warmongers_barrack_towers_lvl2_layer1_0002"
tt.info.i18n_key = "TOWER_WARMONGER_BARRACK_LEVEL2"
tt.barrack.soldier_type = "soldier_orc_warrior_lvl2"

tt = E.register_t(E, "tower_orc_warriors_den_lvl3", "tower_orc_warriors_den_lvl4")
tt.tower.price = 160
tt.tower.level = 3
tt.render.sprites[3].prefix = "warmongers_barrack_towers_lvl3_layer2"
tt.render.sprites[2].name = "warmongers_barrack_towers_lvl3_layer1_0002"
tt.info.i18n_key = "TOWER_WARMONGER_BARRACK_LEVEL3"
tt.barrack.soldier_type = "soldier_orc_warrior_lvl3"


tt = E.register_t(E, "soldier_orc_warrior_lvl4", "soldier_militia")

E.add_comps(E, tt, "powers", "nav_grid")

image_y = 42
anchor_y = 0.25
tt.health_bar.offset = v(0, 30)
tt.health.armor = 0.2
tt.health.dead_lifetime = 10
tt.health.hp_max = 260--200
tt.info.portrait = "gui4_bottom_info_image_soldiers_0013"
tt.info.random_name_count = 9
tt.info.random_name_format = "SOLDIER_ORC_WARRIOR_RANDOM_%i_NAME"
tt.main_script.insert = scripts4.soldier_orc_warrior.insert
tt.main_script.update = scripts4.soldier_orc_warrior.update
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 17
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].damage_maxbase = 17
tt.melee.attacks[1].damage_minbase = 12
tt.melee.attacks[1].damage_factor = {
1.4,
1.8
}
tt.melee.attacks[1].pop = {
  "pop_bladesinger"
}
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[1].power_name = "bloodlust"
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 60
tt.motion.max_speed = 75
tt.powers.seal = E.clone_c(E, "power")
tt.powers.promotion = E.clone_c(E, "power")
tt.powers.bloodlust = E.clone_c(E, "power")
tt.regen.health = 30
tt.regen.cooldown = 2
tt.render.sprites[1].prefix = "warmongers_soldier_orc_lvl4"
tt.render.sprites[1].anchor.y = anchor_y
--[[
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].animated = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].name = "warmongers_soldier_orc_captain"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].hidden = true
]]--
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0.142
tt.render.sprites[2].name = "warmongers_soldier_orc_lvl4_shadow"
tt.render.sprites[2].offset = v(0, -6)
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)

tt = E.register_t(E, "soldier_orc_warrior_lvl1", "soldier_orc_warrior_lvl4")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0010"
tt.health_bar.offset = v(0, 20)
tt.health.armor = 0
tt.health.hp_max = 78
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].damage_maxbase = 3
tt.melee.attacks[1].damage_minbase = 1
tt.render.sprites[1].prefix = "warmongers_soldier_orc_lvl1"
tt.regen.health = 7

tt = E.register_t(E, "soldier_orc_warrior_lvl2", "soldier_orc_warrior_lvl4")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0011"
tt.health_bar.offset = v(0, 22)
tt.health.armor = 0.1
tt.health.hp_max = 130
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].damage_maxbase = 4
tt.melee.attacks[1].damage_minbase = 3
tt.render.sprites[1].prefix = "warmongers_soldier_orc_lvl2"
tt.regen.health = 15

tt = E.register_t(E, "soldier_orc_warrior_lvl3", "soldier_orc_warrior_lvl4")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0012"
tt.health_bar.offset = v(0, 25)
tt.health.armor = 0.15
tt.health.hp_max = 195
tt.melee.attacks[1].damage_max = 7
tt.melee.attacks[1].damage_min = 5
tt.melee.attacks[1].damage_maxbase = 7
tt.melee.attacks[1].damage_minbase = 5
tt.render.sprites[1].prefix = "warmongers_soldier_orc_lvl3"
tt.regen.health = 22

tt = E:register_t("aura_orc_warrior_regen", "aura")

E:add_comps(tt, "hps")

tt.hps.heal_min = 0
tt.hps.heal_max = 0
tt.hps.heal_inc = {
	5,
	10
}
tt.hps.heal_every = 1
tt.aura.track_source = true
tt.main_script.update = scripts4.aura_orc_warrior_regen.update


----------------------------------------------
-------------------兽人萨满--------------------
----------------------------------------------

tt = E:register_t("tower_build_orc_shaman", "tower_build")
tt.build_name = "tower_orc_shaman_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "warmongers_mage_tower_lvl1_layer1_0032"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 33)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E.register_t(E, "tower_orc_shaman_lvl4", "tower")
E.add_comps(E, tt, "attacks", "powers")
tt.info.i18n_key = "TOWER_WARMONGER_MAGE_LEVEL4"
tt.tower.type = "orc_shaman"
tt.tower.level = 4
tt.tower.price = 320
tt.info.fn = scripts.tower_mage.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0010"
tt.info.enc_icon = 93
tt.powers.meteor = E.clone_c(E, "power")
tt.powers.meteor.price_base = 153--180
tt.powers.meteor.price_inc = 153--180
tt.powers.meteor.enc_icon = 302
tt.powers.vines = E.clone_c(E, "power")
tt.powers.vines.price_base = 110--130
tt.powers.vines.price_inc = 110--130
tt.powers.vines.enc_icon = 301
tt.powers.shock = E.clone_c(E, "power")
tt.powers.shock.price_base = 153--180
tt.powers.shock.price_inc = 153--180
tt.powers.shock.enc_icon = 303
tt.main_script.insert = scripts4.tower_orc_shaman.insert
tt.main_script.update = scripts4.tower_orc_shaman.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "warmongers_mage_tower_lvl4_layer1_0001"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "warmongers_mage_tower_shooter_lvl4"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
  idle = {
    "idleUp",
    "idleDown"
  },
  attack = {
    "shootUp",
    "shootDown"
  },
  meteor = {
    "meteoritesUp",
    "meteoritesDown"
  },
  vines = {
    "healingRootsUp",
    "healingRootsDown"
  },
}
tt.render.sprites[3].offset = v(2, 67)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].animated = true
tt.render.sprites[4].prefix = "mageFire"
tt.render.sprites[4].offset = v(30, 37)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].animated = true
tt.render.sprites[5].prefix = "mageFire"
tt.render.sprites[5].offset = v(28, 53)
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].animated = true
tt.render.sprites[6].prefix = "mageFire"
tt.render.sprites[6].offset = v(-28, 37)
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].animated = true
tt.render.sprites[7].prefix = "mageFire"
tt.render.sprites[7].offset = v(-27, 53)
tt.render.sprites[8] = E.clone_c(E, "sprite")
tt.render.sprites[8].animated = true
tt.render.sprites[8].prefix = "warmongers_mage_towers_lvl4_layer2"
tt.render.sprites[8].name = "idle"
tt.render.sprites[8].offset = v(0, 31)
tt.render.sprites[8].angles = {
  idle = {
    "idle",
    "idle"
  },
  attack = {
    "shoot",
    "shoot"
  },
  meteor = {
    "shoot",
    "shoot"
  },
  vines = {
    "shoot",
    "shoot"
  },
}
tt.attacks.range = 212.5
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "attack"
tt.attacks.list[1].bullet_start_offset = {
  v(13, 72),
  v(-9, 70)
}
tt.attacks.list[1].bullet = "bolt_orc_shaman_lvl4"
tt.attacks.list[1].cooldown = 2.3
tt.attacks.list[1].shoot_time = fts(9)
tt.attacks.list[1].payload_chance = 1
tt.attacks.list[1].payload_bullet = "bolt_shock"
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].vis_flags = bor(F_RANGED)
tt.attacks.list[2].vis_bans = bor(F_FLYING, F_ENEMY)
tt.attacks.list[2].animation = "vines"
tt.attacks.list[2].bullet = "aura_orc_shaman_vines"
tt.attacks.list[2].cooldown = 16
tt.attacks.list[2].range = 212.5
tt.attacks.list[2].min_health = 0.5
tt.attacks.list[2].target_range = 60
tt.attacks.list[2].shoot_time = 0.266
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].vis_flags = bor(F_RANGED)
tt.attacks.list[3].vis_bans = 0--bor(F_FLYING)
tt.attacks.list[3].animation = "meteor"
tt.attacks.list[3].bullet = "orc_shaman_meteor"
tt.attacks.list[3].cooldown = 20
tt.attacks.list[3].loops_base = 3
tt.attacks.list[3].loops = 3
tt.attacks.list[3].loops_inc = 1
tt.attacks.list[3].target_range = 90
tt.attacks.list[3].shoot_time = 0.15
tt.attacks.list[3].bullet_start_offset = v(100, 200)
tt.attacks.list[3].min_spread = 40
tt.attacks.list[3].max_spread = 40
tt.sound_events.insert = "OrcShamanTaunt"

tt = E.register_t(E, "tower_orc_shaman_lvl1", "tower_orc_shaman_lvl4")
tt.attacks.list[1].bullet_start_offset = {
  v(13, 72),
  v(-9, 70)
}
tt.attacks.list[1].bullet = "bolt_orc_shaman_lvl1"
tt.attacks.range = 152.5
tt.info.i18n_key = "TOWER_WARMONGER_MAGE_LEVEL1"
tt.tower.level = 1
tt.tower.price = 130
tt.render.sprites[2].name = "warmongers_mage_tower_lvl1_layer1_0001"
tt.render.sprites[3].prefix = "warmongers_mage_tower_shooter_lvl1"
tt.render.sprites[3].offset = v(0, 51)
tt.render.sprites[4].offset = v(25, 14)
tt.render.sprites[5].offset = v(25, 34)
tt.render.sprites[6].offset = v(-24, 14)
tt.render.sprites[7].offset = v(-24, 34)
tt.render.sprites[8].prefix = "warmongers_mage_towers_lvl1_layer2"

tt = E.register_t(E, "tower_orc_shaman_lvl2", "tower_orc_shaman_lvl4")
tt.attacks.list[1].bullet_start_offset = {
  v(13, 72),
  v(-9, 70)
}
tt.attacks.list[1].bullet = "bolt_orc_shaman_lvl2"
tt.attacks.range = 172.5
tt.info.i18n_key = "TOWER_WARMONGER_MAGE_LEVEL2"
tt.tower.level = 2
tt.tower.price = 200
tt.render.sprites[2].name = "warmongers_mage_tower_lvl2_layer1_0001"
tt.render.sprites[3].prefix = "warmongers_mage_tower_shooter_lvl2"
tt.render.sprites[3].offset = v(0, 57)
tt.render.sprites[4].offset = v(29, 24)
tt.render.sprites[5].offset = v(27, 44)
tt.render.sprites[6].offset = v(-27, 24)
tt.render.sprites[7].offset = v(-27, 44)
tt.render.sprites[8].prefix = "warmongers_mage_towers_lvl2_layer2"

tt = E.register_t(E, "tower_orc_shaman_lvl3", "tower_orc_shaman_lvl4")
tt.attacks.list[1].bullet_start_offset = {
  v(13, 72),
  v(-9, 70)
}
tt.attacks.list[1].bullet = "bolt_orc_shaman_lvl3"
tt.attacks.range = 192.5
tt.info.i18n_key = "TOWER_WARMONGER_MAGE_LEVEL3"
tt.tower.level = 3
tt.tower.price = 260
tt.render.sprites[2].name = "warmongers_mage_tower_lvl3_layer1_0001"
tt.render.sprites[3].prefix = "warmongers_mage_tower_shooter_lvl3"
tt.render.sprites[3].offset = v(0, 64)
tt.render.sprites[4].offset = v(32, 35)
tt.render.sprites[5].offset = v(30, 54)
tt.render.sprites[6].offset = v(-28, 34)
tt.render.sprites[7].offset = v(-25, 53)
tt.render.sprites[8].prefix = "warmongers_mage_towers_lvl3_layer2"

tt = E.register_t(E, "bolt_orc_shaman_lvl4", "bolt")
tt.render.sprites[1].hidden = true
tt.bullet.mod = "mod_orc_shaman_stun"
tt.bullet.damage_min = 133--110
tt.bullet.damage_max = 194--160
tt.bullet.max_speed = 10000
tt.bullet.hit_fx_flying = true
tt.custom_offsets = {
	flying = v(-10, 88),
	enemy_goblin_balloon = v(-10, 135)
}
tt.bullet.acceleration_factor = 1
tt.bullet.hit_time = 0.066
tt.bullet.hit_fx = "fx_bolt_orc_shaman_hit"
tt.bullet.ignore_hit_offset = true
tt.bullet.pop = {
  "pop_zapow"
}
tt.bullet.particles_name = nil
tt.sound_events.insert = "OrcShamanAttack"

tt = E.register_t(E, "bolt_orc_shaman_lvl1", "bolt_orc_shaman_lvl4")
tt.bullet.damage_min = 12--10
tt.bullet.damage_max = 24--20

tt = E.register_t(E, "bolt_orc_shaman_lvl2", "bolt_orc_shaman_lvl4")
tt.bullet.damage_min = 36--30
tt.bullet.damage_max = 66--55

tt = E.register_t(E, "bolt_orc_shaman_lvl3", "bolt_orc_shaman_lvl4")
tt.bullet.damage_min = 60--50
tt.bullet.damage_max = 133--110

tt = RT("mod_orc_shaman_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 0.666
tt.modifier.vis_bans = F_BOSS
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].prefix = "warmongers_mage_tower_ray_modifier"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
tt.render.sprites[1].size_scales = {
	vv(1.0),
	vv(1.3),
	vv(1.8)
}

tt = E.register_t(E, "fx_bolt_orc_shaman_hit", "fx")
tt.render.sprites[1].name = "warmongers_mage_tower_ray_travel"
tt.render.sprites[1].offset = v(0, 50)
tt.render.sprites[1].rotation_speed = 0
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "warmongers_mage_tower_ray_hit_run"
tt.render.sprites[2].offset = v(0, 10)

tt = E.register_t(E, "bolt_shock", "bullet")
tt.main_script.insert = scripts.bolt_blast.insert
tt.main_script.update = scripts4.bolt_shock.update
tt.render.sprites[1].prefix = "warmongers_mage_tower_electroshock"
tt.render.sprites[1].name = "hit"
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 0
tt.bullet_damage_max = 0
tt.bullet.damage_inc_min = {
	8,
	18,
	26
}
tt.bullet.damage_inc_max = {
	16,
	32,
	48
}
tt.bullet.damage_radius = 60
tt.bullet.damage_flags = F_AREA
tt.sound_events.insert = "ArchmageCriticalExplosion"

tt = E.register_t(E, "orc_shaman_vines", "rock_entwood")
tt.bullet.flight_time = fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_max_inc = 0
tt.bullet.damage_min = 0
tt.bullet.damage_min_inc = tt.bullet.damage_max_inc
tt.bullet.damage_radius = 1
tt.bullet.hit_payload = "aura_orc_shaman_vines"
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.render.sprites[1].name = "time_wizard_sandstorm_proj"
tt.sound_events.hit = nil

tt = E.register_t(E, "aura_orc_shaman_vines", "aura")

E.add_comps(E, tt, "render")

tt.aura.cycle_time = 0.1
tt.aura.duration = 6
tt.aura.mod = "mod_orc_shaman_heal"
tt.aura.radius = 60
tt.aura.vis_bans = bor(F_ENEMY, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.aura.track_source = false
tt.main_script.insert = scripts4.aura_orc_shaman_vines.insert
tt.main_script.update = scripts4.aura_orc_shaman_vines.update
tt.render.sprites[1].prefix = "warmongers_mage_tower_shooter_healingRoots"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.sound_events.insert = "OrcShamanVines"

tt = E.register_t(E, "mod_orc_shaman_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 0
tt.hps.heal_max = 0
tt.hps.heal_inc = 1
tt.hps.heal_every = 0.1
tt.render.sprites[1].prefix = "healGreen"
tt.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
tt.render.sprites[1].size_scales = {
	vv(1.0),
	vv(1.3),
	vv(1.8)
}
tt.render.sprites[1].name = "run"
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = 0.3

tt = RT("orc_shaman_meteor", "bomb")

tt.bullet.damage_max = 30
tt.bullet.damage_min = 10
tt.bullet.damage_min_inc = 20
tt.bullet.damage_max_inc = 20
tt.bullet.damage_radius = 50
tt.bullet.flight_time = 0.4
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hide_radius = 2
tt.main_script.update = scripts4.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_meteor"
tt.render.sprites[1].name = "meteorite_start"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].offset = v(0, 40)
tt.sound_events.hit_water = nil
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "OrcShamanMeteor"
tt.sound_events.hit = "OrcShamanMeteorHit"

tt = E:register_t("fx_explosion_meteor", "fx")

tt.render.sprites[1].prefix = "warmongers_mage_tower_lvl4_explotion_run"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].offset = v(0, -10)


----------------------------------------------
-------------------火箭骑兵--------------------
----------------------------------------------

--建造
tt = E:register_t("tower_build_rocket_riders", "tower_build")
tt.build_name = "tower_rocket_riders_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "warmongers_rocket_tower_lvl1_layer1_0064"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 45)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = RT("tower_rocket_riders_lvl1", "tower")

AC(tt, "attacks", "powers")

image_y = 120
tt.tower.type = "rocket_riders"
tt.tower.level = 1
tt.tower.price = 120
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 16
tt.info.i18n_key = "TOWER_WARMONGER_ROCKET_LEVEL1"
tt.info.portrait = "gui4_bottom_info_image_towers_0003"
tt.powers.mine = CC("power")
tt.powers.mine.price_base = 191--225
tt.powers.mine.price_inc = 191--225
tt.powers.mine.range_inc_factor = 0
tt.powers.mine.enc_icon = 312
tt.powers.mine.entity = "rr_mine_box"
tt.powers.engine = CC("power")
tt.powers.engine.max_level = 2
tt.powers.engine.price_base = 127--150
tt.powers.engine.price_inc = 127--150
tt.powers.engine.fragment_count = { 5, 7 }
tt.powers.engine.enc_icon = 310
tt.powers.engine.fragment_node_spread = { 7, 5 }
tt.powers.nitro = CC("power")
tt.powers.nitro.max_level = 2
tt.powers.nitro.price_base = 127--150
tt.powers.nitro.price_inc = 127--150
tt.powers.nitro.enc_icon = 311
tt.powers.nitro.damage_inc = { 110, 198 }
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
for i = 1, 4 do
	tt.render.sprites[i+1] = E:clone_c("sprite")
	tt.render.sprites[i+1].prefix = "warmongers_rocket_towers_lvl1_layer" .. i
	tt.render.sprites[i+1].name = "idle"
	tt.render.sprites[i+1].group = "layers"
	tt.render.sprites[i+1].offset = v(0, 45)
	--tt.render.sprites[i+1].z = Z_FLYING_HEROES
end
tt.main_script.remove = scripts4.tower_rocket_riders.remove
tt.main_script.update = scripts4.tower_rocket_riders.update
tt.main_script.insert = scripts4.tower_rocket_riders.insert
tt.sound_events.insert = "RocketRidersTaunt"
tt.attacks.min_cooldown = 3
tt.attacks.range = 160
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bomb_rr_lvl1"
tt.attacks.list[1].bullet_start_offset = v(4, 50)
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].node_prediction = fts(21)
tt.attacks.list[1].range = 160
tt.attacks.list[1].shoot_time = fts(14)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].animation = "shoot"--"mine"
tt.attacks.list[2].bullet = "bomb_rr_mine_intial"
tt.attacks.list[2].bullet_start_offset = v(-30, 18)
tt.attacks.list[2].cooldown = 1e+99
tt.attacks.list[2].cooldown_mixed = 1e+99
tt.attacks.list[2].cooldown_flying = 1e+99
tt.attacks.list[2].range_base = 0
tt.attacks.list[2].launch_vector = v(12, 110)
tt.attacks.list[2].range = 0
tt.attacks.list[2].shoot_time = fts(26)
tt.attacks.list[2].disabled = true
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED)
tt.attacks.list[3] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[3].bullet = "bomb_rr_cluster"
tt.attacks.list[3].bullet_start_offset = v(-6, 45)
tt.attacks.list[3].shoot_time = fts(7)
tt.attacks.list[3].cooldown = 20
tt.attacks.list[3].range = 150
tt.attacks.list[3].node_prediction = fts(40)
tt.attacks.list[4] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[4].bullet = "bomb_rr_nitro"
tt.attacks.list[4].bullet_start_offset = v(-6, 45)
tt.attacks.list[4].shoot_time = fts(7)
tt.attacks.list[4].cooldown = 12
tt.attacks.list[4].range = 250
tt.attacks.list[4].node_prediction = fts(32)
tt.attacks.list[4].animation = "shoot"--"nitro"

tt = RT("tower_rocket_riders_lvl2", "tower_rocket_riders_lvl1")
tt.tower.level = 2
tt.tower.price = 200
tt.info.i18n_key = "TOWER_WARMONGER_ROCKET_LEVEL2"
tt.attacks.list[1].bullet_start_offset = v(4, 50)
tt.attacks.list[1].bullet = "bomb_rr_lvl2"
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].range = 180
tt.attacks.range = 180
for i = 1, 4 do
	tt.render.sprites[i+1] = E:clone_c("sprite")
	tt.render.sprites[i+1].prefix = "warmongers_rocket_towers_lvl2_layer" .. i
	tt.render.sprites[i+1].name = "idle"
	tt.render.sprites[i+1].group = "layers"
	tt.render.sprites[i+1].offset = v(0, 45)
	--tt.render.sprites[i+1].z = Z_FLYING_HEROES
end

tt = RT("tower_rocket_riders_lvl3", "tower_rocket_riders_lvl1")
tt.tower.level = 3
tt.tower.price = 280
tt.info.i18n_key = "TOWER_WARMONGER_ROCKET_LEVEL3"
tt.attacks.list[1].range = 200
tt.attacks.range = 200
tt.attacks.list[1].bullet_start_offset = v(4, 50)
tt.attacks.list[1].bullet = "bomb_rr_lvl3"
tt.attacks.list[1].cooldown = 3
for i = 1, 6 do
	tt.render.sprites[i+1] = E:clone_c("sprite")
	tt.render.sprites[i+1].prefix = "warmongers_rocket_towers_lvl3_layer" .. i
	tt.render.sprites[i+1].name = "idle"
	tt.render.sprites[i+1].group = "layers"
	tt.render.sprites[i+1].offset = v(0, 45)
	--tt.render.sprites[i+1].z = Z_FLYING_HEROES
end

tt = RT("tower_rocket_riders_lvl4", "tower_rocket_riders_lvl1")
tt.tower.level = 4
tt.tower.price = 320
tt.info.i18n_key = "TOWER_WARMONGER_ROCKET_LEVEL4"
tt.attacks.range = 217.5
tt.attacks.list[1].range = 217.5
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].bullet_start_offset = v(-6, 45)
tt.attacks.list[1].bullet = "bomb_rr_lvl4"
tt.attacks.list[1].cooldown = 2.8
tt.attacks.min_cooldown = 2.8
for i = 1, 5 do
	tt.render.sprites[i+1] = E:clone_c("sprite")
	tt.render.sprites[i+1].prefix = "warmongers_rocket_towers_lvl4_layer" .. i
	tt.render.sprites[i+1].name = "idle"
	tt.render.sprites[i+1].group = "layers"
	tt.render.sprites[i+1].offset = v(0, 35)
	--tt.render.sprites[i+1].z = Z_FLYING_HEROES
end

tt = E.register_t(E, "rr_mine_box", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.render.sprites[1].loop = false
tt.render.sprites[1].draw_order = 7
tt.render.sprites[1].prefix = "warmongers_rocket_tower_lvl4_box"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].offset = v(-26, 13)
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].loop = false
tt.render.sprites[2].draw_order = 8
tt.render.sprites[2].prefix = "warmongers_rocket_tower_lvl4_box_goblin"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(-26, 13)
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shootLeft"
tt.attacks.list[1].bullet = "bomb_rr_mine_intial"
tt.attacks.list[1].bullet_start_offset = v(-30, 24)
tt.attacks.list[1].cooldown = 8
tt.attacks.list[1].shoot_time = fts(26)
tt.main_script.update = scripts4.mine_box.update

tt = RT("fx_explosion_engine_air", "fx")
tt.render.sprites[1].prefix = "warmongers_rocket_tower_lvl4_air_explosion"
tt.render.sprites[1].name = "run"

tt = RT("fx_explosion_nitro", "fx")
tt.render.sprites[1].prefix = "warmongers_rocket_tower_lvl4_blue_explosion"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.8,
	tint_color = {
		0,
		0.8,
		1,
		1
	}
}

tt = RT("ps_rocket_riders_rocket", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 60
tt.particle_system.name = "warmongers_rocket_missile_lvl4_particle1_run"
tt.particle_system.particle_lifetime = {
	fts(3),
	fts(7)
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	0.8
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = RT("ps_rocket_riders_nitro", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 60
tt.particle_system.name = "warmongers_rocket_missile_lvl4_particle_special_run"
tt.particle_system.particle_lifetime = {
	fts(3),
	fts(7)
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	0.8
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = RT("bomb_rr_lvl1", "bomb")
tt.bullet.damage_max = 13--12
tt.bullet.damage_min = 8
tt.bullet.damage_radius = 54
tt.bullet.flight_time = fts(25)
tt.main_script.update = scripts4.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.render.sprites[1].name = "warmongers_rocket_missile_lvl1_travel"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.sound_events.hit_water = nil
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "RocketRidersAttack"
tt.bullet.particles_name = "ps_rocket_riders_rocket"

tt = RT("bomb_rr_lvl2", "bomb_rr_lvl1")
tt.bullet.damage_max = 36--33
tt.bullet.damage_min = 25--23
tt.render.sprites[1].name = "warmongers_rocket_missile_lvl2_travel"

tt = RT("bomb_rr_lvl3", "bomb_rr_lvl1")
tt.bullet.damage_max = 74--68
tt.bullet.damage_min = 50--46
tt.render.sprites[1].name = "warmongers_rocket_missile_lvl3_travel"

tt = RT("bomb_rr_lvl4", "bomb_rr_lvl1")
tt.bullet.damage_max = 114--104
tt.bullet.damage_min = 81--74
tt.render.sprites[1].name = "warmongers_rocket_missile_lvl4_travel"

tt = RT("bomb_rr_nitro", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 60
tt.bullet.flight_time = fts(35)
tt.main_script.update = scripts4.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_nitro"
tt.render.sprites[1].name = "warmongers_rocket_missile_lvl4_special_travel"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.sound_events.hit_water = nil
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "RocketRidersNitro"
tt.bullet.particles_name = "ps_rocket_riders_nitro"

tt = RT("bomb_rr_mine", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_inc = {
60,
125,
190
}
tt.bullet.damage_radius = 66
tt.bullet.flight_time = 0
tt.bullet.pop = nil
tt.bullet.hit_payload = "decal_rr_mine"
tt.main_script.insert = scripts.bomb.insert
tt.main_script.update = scripts4.mine_rr.update
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.hide_radius = nil
tt.render.sprites[1].name = "warmongers_rocket_tower_lvl4_box_goblin_mine_floor_out"
tt.render.sprites[1].animated = true
tt.sound_events.insert = "RocketRidersMine"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil

tt = RT("decal_rr_mine", "decal_scripted")
tt.check_interval = fts(3)
tt.damage_max = 0
tt.damage_min = 0
tt.damage_type = DAMAGE_EXPLOSION
tt.duration = 50
tt.hit_decal = "decal_bomb_crater"
tt.hit_fx = "fx_explosion_fragment"
tt.main_script.update = scripts4.decal_rr_mine.update
tt.radius = 38
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "warmongers_rocket_tower_lvl4_box_goblin_mine_floor_loop"
tt.render.sprites[1].z = Z_DECALS
tt.sound = "BombExplosionSound"
tt.vis_bans = bor(F_FRIEND, F_FLYING)
tt.vis_bans2 = bor(F_FRIEND)
tt.vis_flags = bor(F_ENEMY)

tt = RT("bomb_rr_mine_intial", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = 0.6
tt.bullet.fragment_count = 1
tt.bullet.fragment_name = "bomb_rr_mine"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = nil
tt.bullet.fragment_node_spread = 0
tt.bullet.fragment_pos_spread = v(0, 0)
tt.bullet.dest_pos_offset = v(0, 1)
tt.bullet.dest_prediction_time = 0
tt.main_script.insert = scripts.bomb_cluster.insert
tt.main_script.update = scripts4.mine_rr_initial.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "warmongers_rocket_tower_lvl4_box_goblin_mine"
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("bomb_rr_cluster", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = fts(25)
tt.bullet.fragment_count = 5
tt.bullet.fragment_name = "bomb_rr_fragment"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = "fx_explosion_engine_air"
tt.bullet.rotation_speed = (FPS*20*math.pi)/180
tt.bullet.fragment_node_spread = 9
tt.bullet.fragment_pos_spread = v(6, 6)
tt.bullet.dest_pos_offset = v(0, 150)
tt.bullet.dest_prediction_time = 1
tt.bullet.align_with_trajectory = true
tt.bullet.particles_name = "ps_rocket_riders_rocket"
tt.bullet.damage_inc = {
22,
32
}
tt.main_script.insert = scripts.bomb_cluster.insert
tt.main_script.update = scripts4.engine_rr.update
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "warmongers_rocket_missile_lvl4_travel"
tt.sound_events.hit = "RocketRidersEngine"
tt.sound_events.insert = "RocketRidersAttack"

tt = RT("bomb_rr_fragment", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 70
tt.bullet.flight_time = fts(10)
tt.bullet.hide_radius = 2
tt.main_script.update = scripts4.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = nil
tt.render.sprites[1].name = "warmongers_rocket_tower_lvl4_cluster_projectile_000"
tt.sound_events.hit_water = nil
tt.sound_events.insert = nil
tt.bullet.particles_name = "ps_missile"

----------------------------------------------
-------------------阴森墓地--------------------
----------------------------------------------
--建造
tt = E:register_t("tower_build_grim_cemetery", "tower_build")
tt.build_name = "tower_grim_cemetery_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 7)
tt.render.sprites[2].name = "fallen_ones_grim_cemetery_tower_lvl1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 23)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E.register_t(E, "tower_grim_cemetery_lvl1", "tower")

E.add_comps(E, tt, "attacks", "powers", "auras", "tween", "tower_upgrade_persistent_data")

tt.tower.type = "grim_cemetery"
tt.tower.level = 1
tt.tower.price = 70
tt.info.i18n_key = "TOWER_FALLEN_ONES_CEMETERY_LEVEL1"
tt.info.fn = scripts4.tower_grim_cemetery.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0011"
tt.info.enc_icon = 94
tt.powers.hands = E.clone_c(E, "power")
tt.powers.hands.price_base = 110--130
tt.powers.hands.price_inc = 110--130
tt.powers.hands.max_level = 2
tt.powers.hands.enc_icon = 334
tt.powers.hands.cooldown = {
	15,
	12
}
tt.powers.hands.count = {
	10,
	15
}
tt.powers.pestilence = E.clone_c(E, "power")
tt.powers.pestilence.price_base = 93--110
tt.powers.pestilence.price_inc = 93--110
tt.powers.pestilence.max_level = 2
tt.powers.pestilence.enc_icon = 335
tt.powers.pestilence.mod = "mod_grim_cemetery_explode"
tt.powers.big = E.clone_c(E, "power")
tt.powers.big.price_base = 127--150
tt.powers.big.price_inc = 127--150
tt.powers.big.enc_icon = 333
tt.powers.big.max_level = 1
tt.main_script.insert = scripts4.tower_grim_cemetery.insert
tt.main_script.update = scripts4.tower_grim_cemetery.update
tt.main_script.remove = scripts4.tower_grim_cemetery.remove
tt.attacks.range = 181.5
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "grim_cemetery_hand"
tt.attacks.list[1].cooldown = 12
tt.attacks.list[1].range = 143
tt.attacks.list[1].sound = "GrimCemeteryHands"
tt.attacks.list[1].shoot_time = fts(6)
tt.attacks.list[1].target_range = 90
tt.attacks.list[1].max_spread = 40
tt.attacks.list[1].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "grim_cemetery_aura_lvl1"
tt.auras.list[1].cooldown = 0
tt.auras.list[1].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 7)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "fallen_ones_grim_cemetery_tower_lvl1_0002"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 23)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooternecromancer"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot_start = {
		"shootStartUp",
		"shootStartDown"
	},
	shoot_loop = {
		"shootLoopUp",
		"shootLoopDown"
	},
	shoot_end = {
		"shootEndUp",
		"shootEndDown"
	},
	pestilence = {
		"pestilenceUp",
		"pestilenceDown"
	}
}
tt.render.sprites[3].offset = v(0, 60)
tt.render.sprites[3].hidden = true
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].animated = false
tt.render.sprites[4].name = "NecromancerTowerGlow"
tt.render.sprites[4].offset = v(0, 34)
tt.render.sprites[4].hidden = true
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].name = "towernecromancer_fx"
tt.render.sprites[5].offset = v(0, 52)
tt.render.sprites[5].hidden = true
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].animated = true
tt.render.sprites[6].name = "fallen_ones_grim_cemetery_fog_run"
tt.render.sprites[6].offset = v(0, 23)
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].animated = true
tt.render.sprites[7].name = "fallen_ones_grim_cemetery_fog1_run"
tt.render.sprites[7].offset = v(0, 23)
tt.render.sprites[8] = E.clone_c(E, "sprite")
tt.render.sprites[8].animated = true
tt.render.sprites[8].name = "fallen_ones_grim_cemetery_fog2_run"
tt.render.sprites[8].offset = v(0, 23)
tt.render.sprites[9] = E.clone_c(E, "sprite")
tt.render.sprites[9].animated = true
tt.render.sprites[9].name = "fallen_ones_grim_cemetery_fog3_run"
tt.render.sprites[9].offset = v(0, 23)
tt.tween.remove = false
tt.tween.reverse = false
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
tt.tween.props[1].sprite_id = 4
tt.skeletons_count = 0
tt.sound_events.insert = "GrimCemeteryTaunt"

tt = E.register_t(E, "tower_grim_cemetery_lvl2", "tower_grim_cemetery_lvl1")
tt.tower.level = 2
tt.tower.price = 100
tt.info.i18n_key = "TOWER_FALLEN_ONES_CEMETERY_LEVEL2"
tt.auras.list[1].name = "grim_cemetery_aura_lvl2"
tt.render.sprites[2].name = "fallen_ones_grim_cemetery_tower_lvl2_0001"

tt = E.register_t(E, "tower_grim_cemetery_lvl3", "tower_grim_cemetery_lvl1")
tt.tower.level = 3
tt.tower.price = 140
tt.info.i18n_key = "TOWER_FALLEN_ONES_CEMETERY_LEVEL3"
tt.auras.list[1].name = "grim_cemetery_aura_lvl3"
tt.render.sprites[2].name = "fallen_ones_grim_cemetery_tower_lvl3_0001"

tt = E.register_t(E, "tower_grim_cemetery_lvl4", "tower_grim_cemetery_lvl1")
tt.tower.level = 4
tt.tower.price = 180
tt.info.i18n_key = "TOWER_FALLEN_ONES_CEMETERY_LEVEL4"
tt.auras.list[1].name = "grim_cemetery_aura_lvl4"
tt.render.sprites[2].name = "fallen_ones_grim_cemetery_tower_lvl4_0001"

tt = E.register_t(E, "grim_cemetery_aura_lvl4", "aura")
tt.main_script.update = scripts4.grim_cemetery_aura.update
tt.main_script.remove = scripts4.grim_cemetery_aura.remove
tt.aura.cycle_time = 0.033
tt.spawn_cooldown = 12
tt.aura.duration = -1
tt.aura.excluded_templates = {
	"enemy_skeleton",
	"enemy_skeleton_big",
	"enemy_lava_elemental",
	"enemy_cursed_golem",
	"enemy_cursed_shard"
}
tt.entity_small = "soldier_zombie_lvl4"
tt.entity_medium = "soldier_zombie_medium_lvl4"
tt.entity_big = "soldier_zombie_big"
tt.min_health_for_knight = 500
tt.pestilence_cooldown = 3
tt.pestilence_mod = "mod_grim_cemetery_explode"
tt.count_group_name = "grim_zombies"
tt.max_skeletons_tower = 5
tt.spawn_sound = "GrimCemeterySpawn"

tt = E.register_t(E, "grim_cemetery_aura_lvl1", "grim_cemetery_aura_lvl4")
tt.entity_small = "soldier_zombie_lvl1"
tt.entity_medium = "soldier_zombie_medium_lvl1"

tt = E.register_t(E, "grim_cemetery_aura_lvl2", "grim_cemetery_aura_lvl4")
tt.entity_small = "soldier_zombie_lvl2"
tt.entity_medium = "soldier_zombie_medium_lvl2"

tt = E.register_t(E, "grim_cemetery_aura_lvl3", "grim_cemetery_aura_lvl4")
tt.entity_small = "soldier_zombie_lvl3"
tt.entity_medium = "soldier_zombie_medium_lvl3"

tt = E.register_t(E, "soldier_zombie_lvl4", "soldier_militia")

E.add_comps(E, tt, "count_group", "idle_flip")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0021"
tt.anchor_y = 0.18
tt.image_y = 50
tt.pestilence_active = nil
tt.count_group.name = "grim_zombies"
tt.health.dead_lifetime = 3
tt.health.hp_max = 312--240
tt.motion.max_speed = 30
tt.health_bar.offset = v(0, 22)
tt.idle_flip.cooldown = 5
tt.idle_flip.cooldown_max = 15
tt.idle_flip.last_dir = 1
tt.idle_flip.walk_dist = 10
tt.main_script.update = scripts4.soldier_zombie.update
tt.info.fn = scripts.soldier_mercenary.get_info
--tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0022") or "krv_portraits_0022"
tt.info.random_name_count = 7
tt.info.random_name_format = "SOLDIER_ZOMBIE_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 11
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 75
tt.regen = nil
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "grim_cemetery_zombie"
tt.render.sprites[1].offset = v(0, -10)
tt.render.sprites[1].draw_order = 2
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = true
tt.render.sprites[2].hidden = true
tt.render.sprites[2].prefix = "grim_cemetery_pestilence"
tt.render.sprites[2].offset = v(0, 14)
tt.render.sprites[2].draw_order = 1
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].is_shadow = true
tt.render.sprites[3].animated = false
tt.render.sprites[3].anchor.y = 0.142
tt.render.sprites[3].name = "grim_cemetery_zombie_shadow"
tt.render.sprites[3].z = Z_DECALS + 1
tt.render.sprites[3].offset = v(0, -10)
tt.ui.click_rect_offset_y = -10
tt.sound_events.insert = "GrimCemeteryMoan"
tt.sound_events.death_xplode = "GrimCemeteryPestilence"
tt.sound_events.death_xplode_args = {
	delay = 0.1
}
tt.vis.bans = bor(F_CANNIBALIZE, F_POISON, F_LYCAN)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, ady(18))
tt.soldier.melee_slot_offset = v(12, 0)

tt = E.register_t(E, "soldier_zombie_lvl1", "soldier_zombie_lvl4")
tt.melee.attacks[1].damage_max = 2
tt.melee.attacks[1].damage_min = 1
tt.health.hp_max = 111--85

tt = E.register_t(E, "soldier_zombie_lvl2", "soldier_zombie_lvl4")
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 2
tt.health.hp_max = 169--160

tt = E.register_t(E, "soldier_zombie_lvl3", "soldier_zombie_lvl4")
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 3
tt.health.hp_max = 234--180


tt = E.register_t(E, "soldier_zombie_medium_lvl4", "soldier_zombie_lvl4")
E.add_comps(E, tt, "count_group", "idle_flip")
tt.health_bar.offset = v(0, 35)
tt.count_group.name = "grim_zombies"
tt.idle_flip.cooldown = 5
tt.idle_flip.cooldown_max = 15
tt.idle_flip.last_dir = 1
tt.idle_flip.walk_dist = 10
tt.health.hp_max = 390--300
tt.info.portrait = "gui4_bottom_info_image_soldiers_0022"
tt.melee.attacks[1].damage_max = 12--10
tt.melee.attacks[1].damage_min = 4
tt.render.sprites[1].prefix = "grim_cemetery_zombie_medium"

tt = E.register_t(E, "soldier_zombie_medium_lvl1", "soldier_zombie_medium_lvl4")
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 2
tt.health.hp_max = 130--100

tt = E.register_t(E, "soldier_zombie_medium_lvl2", "soldier_zombie_medium_lvl4")
tt.melee.attacks[1].damage_max = 8
tt.melee.attacks[1].damage_min = 2
tt.health.hp_max = 208--160

tt = E.register_t(E, "soldier_zombie_medium_lvl3", "soldier_zombie_medium_lvl4")
tt.melee.attacks[1].damage_max = 11--10
tt.melee.attacks[1].damage_min = 3
tt.health.hp_max = 292--225

tt = E.register_t(E, "soldier_zombie_big", "soldier_zombie_lvl4")

E.add_comps(E, tt, "count_group", "idle_flip")
tt.health_bar.offset = v(0, 35)
tt.count_group.name = "grim_zombies"
tt.idle_flip.cooldown = 5
tt.idle_flip.cooldown_max = 15
tt.idle_flip.last_dir = 1
tt.idle_flip.walk_dist = 10
tt.health.hp_max = 390--300
tt.info.portrait = "gui4_bottom_info_image_soldiers_0041"
tt.melee.attacks[1].damage_max = 13--12
tt.melee.attacks[1].damage_min = 7
tt.render.sprites[1].prefix = "grim_cemetery_zombie_better"

tt = E.register_t(E, "grim_cemetery_hand", "arrow_arcane")
tt.bullet.flight_time_min = 0
tt.bullet.flight_time = 0
tt.bullet.miss_decal = nil
tt.bullet.mod = nil
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.admin = {
	0,
	0,
	0
}
tt.bullet.admax = {
	0,
	0,
	0
}
tt.bullet.aura_duration = {
	6,
	6
}
tt.main_script.update = scripts4.lava_fissure_cemetery.update
tt.bullet.particles_name = nil
tt.bullet.payload = "aura_grim_cemetery_hand"
tt.render.sprites[1].hidden = true
tt.sound_events.insert = nil
tt.bullet.hit_blood_fx = nil
tt.sound_events.hit = "GrimCemeteryFissure"
tt.bullet.hit_fx = nil

tt = E.register_t(E, "aura_grim_cemetery_hand", "aura")

E.add_comps(E, tt, "render")

tt.aura.cycle_time = 0.2
tt.aura.duration = 4
tt.aura.mod = "mod_grim_cemetery_slow"
tt.aura.radius = 35
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts4.aura_grim_cemetery_hand.insert
tt.main_script.update = scripts4.aura_grim_cemetery_hand.update
tt.render.sprites[1].prefix = "fallen_ones_grim_cemetery_hand1"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS

tt = RT("mod_grim_cemetery_slow", "mod_slow")
tt.modifier.duration = 0.5
tt.slow.factor = 0.4

tt = E.register_t(E, "mod_grim_cemetery_explode", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = -1
tt.render.sprites[1].prefix = " grim_cemetery_zombie"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].size_names = {
	"pestilence",
	"pestilence",
	"pestilence"
}
tt.render.sprites[1].name = "pestilence"
tt.render.sprites[1].draw_order = 20
tt.main_script.insert = scripts.mod_track_target.insert
tt.main_script.update = scripts4.mod_grim_cemetery_explode.update
tt.main_script.remove = scripts4.mod_grim_cemetery_explode.remove
tt.explode_fx = "fx_unit_explode"
tt.explode_range = 45
tt.explode_delay = 0.633
tt.explode_max_targets = 5
tt.explode_damage_type = DAMAGE_MAGICAL
tt.explode_damage = {
	15,
	60
}
tt.explode_mod = "mod_grim_cemetery_poison"
tt.explode_vis_bans = bor(F_FRIEND)
tt.explode_vis_flags = F_RANGED
tt.explode_excluded_templates = {}

tt = RT("mod_grim_cemetery_poison", "mod_poison")
tt.modifier.duration = 3 
tt.dps.damage_max = 3
tt.dps.damage_min = 3
tt.dps.damage_inc = 0
tt.dps.damage_every = 0.33
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON)
