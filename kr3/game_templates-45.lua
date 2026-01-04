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
local kr1_scripts = require("game_scripts-1")
local scripts_rebbborn = require("game_scripts-1-rebbborn")
local kr4_scripts = require("game_scripts-45")

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


--本文件：使用5代底层代码实现4代防御塔
----------------------------------------------
------------------精英骚扰者-------------------
----------------------------------------------
tt = E:register_t("tower_build_twilight_elves_barrack", "tower_build")
tt.build_name = "tower_twilight_elves_barrack_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "twilight_elves_barrack_tower_lvl1_layer1_0001"
tt.render.sprites[2].offset = v(0, 30)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E:register_t("tower_twilight_elves_barrack_lvl2", "tower_KR5")

E:add_comps(tt, "barrack", "vis")

tt.barrack.rally_range = 198
tt.info.i18n_key = "TOWER_TWILIGHT_ELVES_BARRACK_LVL2"
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "elves_soldier_harasser_lvl2"
tt.barrack.max_soldiers = 2
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0020"
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.remove = scripts.tower_barrack.remove
tt.main_script.update = scripts.tower_barrack.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].anchor.y = 0.13
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "twilight_elves_barrack_tower_lvl2_layer1_0001"
tt.render.sprites[2].offset = v(0, -5)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].anchor.y = 0.13
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, -5)
tt.render.sprites[3].prefix = "twilight_elves_barrack_tower_lvl2"
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "kr4_elves_barrack_taunt"
tt.sound_events.insert = "kr4_elves_barrack_taunt"
tt.tower.level = 2
tt.tower.price = 150
tt.tower.type = "twilight_elves_barrack"
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.team = TEAM_DARK_ARMY
tt.tower.menu_offset = v(0, 15)
tt.ui.click_rect = r(-40, 0, 80, 70)

tt = E:register_t("tower_twilight_elves_barrack_lvl3", "tower_twilight_elves_barrack_lvl2")
tt.info.i18n_key = "TOWER_TWILIGHT_ELVES_BARRACK_LVL3"
tt.barrack.soldier_type = "elves_soldier_harasser_lvl3"
tt.render.sprites[2].name = "twilight_elves_barrack_tower_lvl3_layer1_0001"
tt.render.sprites[3].prefix = "twilight_elves_barrack_tower_lvl3"
tt.tower.level = 3
tt.tower.price = 200

tt = E:register_t("tower_twilight_elves_barrack_lvl1", "tower_twilight_elves_barrack_lvl2")
tt.info.i18n_key = "TOWER_TWILIGHT_ELVES_BARRACK_LVL1"
tt.barrack.soldier_type = "elves_soldier_harasser_lvl1"
tt.render.sprites[2].name = "twilight_elves_barrack_tower_lvl1_layer1_0002"
tt.render.sprites[3].prefix = "twilight_elves_barrack_tower_lvl1"
tt.tower.level = 1
tt.tower.price = 100

tt = E:register_t("tower_twilight_elves_barrack_lvl4", "tower_twilight_elves_barrack_lvl3")
E:add_comps(tt, "powers")
tt.info.i18n_key = "TOWER_TWILIGHT_ELVES_BARRACK_LVL4"
tt.powers.backstab = E:clone_c("power")
tt.powers.backstab.price_base = 153
tt.powers.backstab.price_inc = 153
tt.powers.backstab.max_level = 2
tt.powers.backstab.enc_icon = 351
tt.powers.arrow_storm = E:clone_c("power")
tt.powers.arrow_storm.price_base = 119
tt.powers.arrow_storm.price_inc = 119
tt.powers.arrow_storm.max_level = 3
tt.powers.arrow_storm.enc_icon = 350
tt.powers.last_breath = E:clone_c("power")
tt.powers.last_breath.max_level = 1
tt.powers.last_breath.price_base = 187
tt.powers.last_breath.enc_icon = 352
tt.barrack.soldier_type = "elves_soldier_harasser_lvl4"
tt.render.sprites[2].name = "twilight_elves_barrack_tower_lvl4_layer1_0001"
tt.render.sprites[2].anchor.y = 0.11
tt.render.sprites[2].offset = v(0, -2)
tt.render.sprites[3].prefix = "twilight_elves_barrack_tower_lvl4"
tt.render.sprites[3].anchor.y = 0.11
tt.render.sprites[3].offset = v(0, -2)
tt.tower.level = 4
tt.tower.price = 250

tt = E:register_t("elves_soldier_harasser_lvl2", "soldier_militia")
E:add_comps(tt, "dodge", "ranged", "nav_grid")
tt.info.i18n_key = "ELVES_SOLDIER_ESPECTRAL_HARASSER_NAME"
tt.health.armor = 0
tt.health.dead_lifetime = 12
tt.health.hp_max = 169
tt.health_bar.offset = v(0, 31)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = "gui4_bottom_info_image_soldiers_0034"
tt.info.random_name_count = 10
tt.info.random_name_format = "ELVES_SOLDIER_HARASSER_%i_NAME"
tt.main_script.insert = scripts.soldier_barrack.insert
tt.main_script.update = kr4_scripts.kr4_soldier_barrack.update
tt.main_script.remove = scripts.soldier_barrack.remove
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 0.8
tt.melee.attacks[1].damage_max = 14
tt.melee.attacks[1].damage_min = 11
tt.melee.attacks[1].hit_time = 0.33
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].hit_time = 0.3
tt.melee.attacks[2].chance = 0.5
tt.melee.range = 50
tt.melee.cooldown = 0.8
tt.dodge.animation = "dodge"
tt.dodge.hide_shadow = true
tt.dodge.chance = 0.3
tt.dodge.chance_inc = 0.1
tt.dodge.power_name = "backstab"
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "elves_soldier_harasser_arrow_lvl2"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 24)
}
tt.ranged.attacks[1].cooldown = 0.9
tt.ranged.attacks[1].max_range = 180
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = 0.3
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.motion.max_speed = 85
tt.regen.cooldown = 2
tt.regen.health = 13
tt.render.sprites[1].anchor.y = 0.142
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].prefix = "elves_soldier_harasser_lvl2"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "elves_soldier_harasser_lvl2_shadow"
tt.render.sprites[2].anchor.y = 0.142
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(11, 0)
tt.ui.click_rect = r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 9)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt.vis.flags = bor(tt.vis.flags, F_DARK_ELF)

tt = E:register_t("elves_soldier_harasser_lvl3", "elves_soldier_harasser_lvl2")
tt.info.i18n_key = "ELVES_SOLDIER_ESPECTRAL_HARASSER_NAME"
tt.health.hp_max = 208
tt.health_bar.offset = v(0, 31)
tt.info.portrait = "gui4_bottom_info_image_soldiers_0035"
tt.melee.attacks[1].damage_max = 27
tt.melee.attacks[1].damage_min = 16
tt.melee.attacks[2].damage_max = 27
tt.melee.attacks[2].damage_min = 16
tt.ranged.attacks[1].bullet = "elves_soldier_harasser_arrow_lvl3"
tt.ranged.attacks[1].bullet_start_offset = {
	v(7, 24)
}
tt.regen.health = 16
tt.render.sprites[1].prefix = "elves_soldier_harasser_lvl3"
tt.render.sprites[2].name = "elves_soldier_harasser_lvl3_shadow"

tt = E:register_t("elves_soldier_harasser_lvl1", "elves_soldier_harasser_lvl2")
tt.info.i18n_key = "ELVES_SOLDIER_ESPECTRAL_HARASSER_NAME"
tt.health.hp_max = 91
tt.health_bar.offset = v(0, 31)
tt.info.portrait = "gui4_bottom_info_image_soldiers_0033"
tt.melee.attacks[1].damage_max = 7
tt.melee.attacks[1].damage_min = 5
tt.melee.attacks[2].damage_max = 7
tt.melee.attacks[2].damage_min = 5
tt.ranged.attacks[1].bullet = "elves_soldier_harasser_arrow_lvl1"
tt.ranged.attacks[1].bullet_start_offset = {
	v(7, 24)
}
tt.regen.health = 6
tt.render.sprites[1].prefix = "elves_soldier_harasser_lvl1"
tt.render.sprites[2].name = "elves_soldier_harasser_lvl1_shadow"

tt = E:register_t("elves_soldier_harasser_lvl4", "elves_soldier_harasser_lvl3")
E:add_comps(tt, "powers", "death_spawns")

tt.info.i18n_key = "ELVES_SOLDIER_ESPECTRAL_HARASSER_NAME"
tt.health.hp_max = 286
tt.health_bar.offset = v(0, 28)
tt.info.portrait = "gui4_bottom_info_image_soldiers_0036"
tt.powers.backstab = E:clone_c("power")
tt.powers.arrow_storm = E:clone_c("power")
tt.powers.last_breath = E:clone_c("power")
tt.melee.attacks[1].damage_max = 38
tt.melee.attacks[1].damage_min = 27
tt.melee.attacks[2].damage_max = 38
tt.melee.attacks[2].damage_min = 27
tt.dodge.animation = "backstab"
tt.dodge.counter_attack = E:clone_c("melee_attack")
tt.dodge.counter_attack.animation = "backstabHit"
tt.dodge.counter_attack.cooldown = 0.5
tt.dodge.counter_attack.damage_type = DAMAGE_PHYSICAL
tt.dodge.counter_attack.damage_max = 15
tt.dodge.counter_attack.damage_min = 10
tt.dodge.counter_attack.damage_max_config = { 15, 30 }
tt.dodge.counter_attack.damage_min_config = { 10, 20 }
tt.dodge.counter_attack.hit_time = 0.1
tt.dodge.counter_attack.power_name = "backstab"
tt.ranged.attacks[1].bullet = "elves_soldier_harasser_arrow_lvl4"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 23)
}
tt.ranged.attacks[2] = E:clone_c("bullet_attack")
tt.ranged.attacks[2].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].power_name = "arrow_storm"
tt.ranged.attacks[2].bullet = "elves_soldier_harasser_arrow_multishoot"
tt.ranged.attacks[2].bullet_start_offset = {
	v(4, 22)
}
tt.ranged.attacks[2].animations = {
	"inshoot",
	"multishoot",
	"outshoot"
}
tt.ranged.attacks[2].loops = 5
tt.ranged.attacks[2].shoot_times = {
	0.1
}
tt.ranged.attacks[2].cooldown = 12
tt.ranged.attacks[2].max_range = 200
tt.ranged.attacks[2].min_range = 50
tt.regen.health = 22
tt.render.sprites[1].anchor.y = 0.125
tt.render.sprites[1].prefix = "elves_soldier_harasser_lvl4"
tt.render.sprites[2].anchor.y = 0.125
tt.render.sprites[2].name = "elves_soldier_harasser_lvl4_shadow"
tt.soldier.melee_slot_offset = v(12, 0)
tt.death_spawns.name = "elves_soldier_espectral_harasser"
tt.death_spawns.quantity = 1
tt.main_script.update = kr4_scripts.elves_soldier_harasser_lvl4.update

tt = E:register_t("elves_soldier_espectral_harasser", "soldier_militia")
E:add_comps(tt, "reinforcement", "nav_grid")
tt.health.armor = 0
tt.health.hp_max = 325
tt.health.dead_lifetime = 6
tt.health_bar.offset = v(0, 33)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.info.portrait = "gui4_bottom_info_image_soldiers_0037"
tt.reinforcement.duration = 6
tt.reinforcement.fade = false
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = kr4_scripts.elves_soldier_espectral_harasser.update
tt.sound_events.raise = "elves_eliteharassers_lastbreath1"
tt.sound_events.raise_args = {
	delay = fts(13)
}
tt.sound_events.death = "elves_eliteharassers_lastbreath2"
tt.sound_events.death_args = {
	delay = fts(10)
}
tt.melee.range = 65
tt.melee.attacks[1].cooldown = 0.5
tt.melee.attacks[1].damage_min = 32
tt.melee.attacks[1].damage_max = 48
tt.melee.attacks[1].hit_time = 0.3
tt.motion.max_speed = 150
tt.regen.health = 0
tt.render.sprites[1].anchor.y = 0.116
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].prefix = "elves_soldier_espectral_harasser"
tt.render.sprites[1].name = "raise"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "elves_soldier_espectral_harasser_shadow"
tt.render.sprites[2].anchor.y = 0.116
tt.render.sprites[2].offset = v(0, 0)
tt.soldier.melee_slot_offset = v(12, 0)
tt.ui.click_rect = r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 11)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt.unit.hide_after_death = true
tt.particle = "ps_elves_soldier_espectral_harasser_run_effect"

tt = E:register_t("ps_elves_soldier_espectral_harasser_run_effect")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "elves_soldier_espectral_harasser_run_effect_run"
tt.particle_system.anchor = v(0.5, 0.116)
tt.particle_system.sort_y_offset = -5
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.animation_fps = 20
tt.particle_system.emission_rate = 35
tt.particle_system.z = Z_DECALS

tt = E:register_t("elves_soldier_harasser_arrow_lvl2", "arrow5_fixed_height")
tt.render.sprites[1].name = "elves_soldier_harasser_arrow"
tt.bullet.miss_decal = "elves_soldier_harasser_arrow_decal_0009"
tt.bullet.miss_decal_anchor = v(1, 0.5)
tt.bullet.damage_max = 14
tt.bullet.damage_min = 11
tt.bullet.fixed_height = 35
tt.bullet.g = -1000
tt.bullet.hide_radius = 1
tt.bullet.reset_to_target_pos = true
tt.bullet.use_unit_damage_factor = true

tt = E:register_t("elves_soldier_harasser_arrow_lvl1", "elves_soldier_harasser_arrow_lvl2")
tt.bullet.damage_max = 5
tt.bullet.damage_min = 7

tt = E:register_t("elves_soldier_harasser_arrow_lvl3", "elves_soldier_harasser_arrow_lvl2")
tt.bullet.damage_max = 27
tt.bullet.damage_min = 16

tt = E:register_t("elves_soldier_harasser_arrow_lvl4", "elves_soldier_harasser_arrow_lvl3")
tt.bullet.damage_max = 38
tt.bullet.damage_min = 27

tt = E:register_t("elves_soldier_harasser_arrow_multishoot", "arrow5_45degrees")
tt.render.sprites[1].name = "elves_soldier_harasser_arrow_multishoot"
tt.bullet.miss_decal = "elves_soldier_harasser_arrow_multishoot_decal_0009"
tt.bullet.miss_decal_anchor = v(1, 0.5)
tt.sound_events.insert = "elves_arrow_release_sound"
tt.bullet.flight_time = fts(10)
tt.bullet.g = -0.7 / (fts(1) * fts(1))
tt.bullet.reset_to_target_pos = true
tt.bullet.damage_max = 72
tt.bullet.damage_min = 48
tt.bullet.damage_inc = 0

--炙热宝石

tt = E:register_t("tower_build_blazing_watcher", "tower_build")
tt.build_name = "tower_blazing_watcher_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2].name = "blazing_watcher_tower_lvl1_0001"
tt.render.sprites[2].offset = v(0, 40)
--tt.render.sprites[3].offset.y = 62
--tt.render.sprites[4].offset.y = 62
tt = E:register_t("tower_blazing_watcher_lvl1", "tower_KR5")
E:add_comps(tt, "attacks", "vis")
--防御塔基本信息
tt.attack_stage = 1
tt.tower.type = "blazing_watcher"
tt.tower.kind = TOWER_KIND_MAGE
tt.tower.team = TEAM_LINIREA
tt.tower.level = 1
tt.tower.price = 140
tt.tower.menu_offset = v(0, 20)
--脚本
tt.main_script.insert = kr4_scripts.tower_blazing_watcher.insert
tt.main_script.update = kr4_scripts.tower_blazing_watcher.update
--信息栏
tt.info.portrait = "gui4_bottom_info_image_towers_0013"
tt.info.room_portrait = "towerselect_quickmenu_icons_0014"
tt.info.enc_icon = 17
tt.info.i18n_key = "TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL1"
tt.info.tower_portrait = "towerselect_portraits_big_" .. "0002"
tt.info.damage_icon = "magic"
tt.info.stat_damage = 9
tt.info.stat_range = 5
tt.info.stat_cooldown = 3
tt.info.fn = kr4_scripts.tower_blazing_watcher.get_info
--攻击方式

tt.attacks.min_cooldown = 1.2
tt.attacks.range = 150
tt.attacks.extra_range = 15
tt.attacks.attack_delay_on_spawn = fts(5)
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bullet_tower_blazing_watcher_lvl1"
tt.attacks.list[1].cooldown = 1.2 
tt.attacks.list[1].max_rate = 3
tt.attacks.list[1].action_time = 0.1
tt.attacks.list[1].duration = 9999
tt.attacks.list[1].bullet_start_offset = v(1, 72)
tt.attacks.list[1].ignore_out_of_range_check = 1
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[1].vis_flags = bor(F_RANGED, F_AREA)

--动画
--第一个是要保留的。动画默认设置为true，如果不是动画需要手动false
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 14)
--第二个是防御塔
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "blazing_watcher_tower_lvl1_0002"
tt.render.sprites[2].offset = v(1, 40)
--第三个是宝石
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "blazing_watcher_gem"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(2, 67)
--第四个是塔上人物
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "blazing_watcher_mage_1"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(2, 18)
tt.render.sprites[4].group = "mage"
--声音和其他信息
tt.mage_offset = v(0, 80)
tt.sound_events.insert = "kr4_blazing_watcher_taunt"
tt.sound_events.tower_room_select = "TowerRayTauntSelect"
tt.ui.click_rect = r(-30, 0, 60, 65)


tt = E:register_t("tower_blazing_watcher_lvl2", "tower_blazing_watcher_lvl1")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL2"
tt.tower.level = 2
tt.tower.price = 210
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 162.5
tt.attacks.list[1].bullet = "bullet_tower_blazing_watcher_lvl2"
tt.attacks.list[1].bullet_start_offset = v(1, 74)
tt.render.sprites[2].name = "blazing_watcher_tower_lvl2_0001"
tt.render.sprites[3].offset = v(2, 69)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "blazing_watcher_mage_2"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].group = "mage"
tt.render.sprites[5].offset = v(-23, 40)
tt.ui.click_rect = r(-30, 0, 60, 65)

tt = E:register_t("tower_blazing_watcher_lvl3", "tower_blazing_watcher_lvl2")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL3"
tt.tower.level = 3
tt.tower.price = 240
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 175
tt.attacks.list[1].bullet = "bullet_tower_blazing_watcher_lvl3"
tt.attacks.list[1].bullet_start_offset = v(1, 76)
tt.render.sprites[2].name = "blazing_watcher_tower_lvl3_0001"--3和4不需要动
tt.render.sprites[3].offset = v(2, 71)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "blazing_watcher_mage_3"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].group = "mage"
tt.render.sprites[6].offset = v(26, 40)
tt.ui.click_rect = r(-30, 10, 70, 70)


tt = E:register_t("tower_blazing_watcher_lvl4", "tower_blazing_watcher_lvl3")
E:add_comps(tt, "powers")
tt.info.enc_icon = 15
tt.info.i18n_key = "TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4"
tt.tower.level = 4
tt.tower.price = 300
tt.tower.menu_offset = v(0, 22)
tt.tower.size = TOWER_SIZE_LARGE
tt.attack_stage_max = 4
tt.attacks.range = 187.5
tt.attacks.list[1].bullet = "bullet_tower_blazing_watcher_lvl4"
tt.attacks.list[1].bullet_start_offset = v(1, 76)
tt.attacks.list[1].payload_bullet = "blazing_watcher_bolt_blast"
--额外的进攻方式。攻击类型2：秒杀
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].bullet = "blazing_watcher_ray_chargedBlast"
tt.attacks.list[2].cooldown = 25
tt.attacks.list[2].range = 187.5
tt.attacks.list[2].vis_flags = bor(F_DISINTEGRATED) --
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].shoot_time = fts(20)
tt.attacks.list[2].bullet_start_offset = tt.attacks.list[1].bullet_start_offset
tt.attacks.list[2].node_prediction = fts(10)
tt.attacks.list[2].disabled = true
tt.attacks.list[2].sound = "blazing_watcher_disintegrate"

tt.render.sprites[2].name = "blazing_watcher_tower_lvl4_0001"
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "blazing_watcher_mage_2"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].group = "mage"
tt.render.sprites[4].offset = v(-24,57)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "blazing_watcher_mage_3"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].group = "mage"
tt.render.sprites[5].offset = v(28,57)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "blazing_watcher_mage_4"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].group = "mage"
tt.render.sprites[6].offset = v(-25,40)
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].prefix = "blazing_watcher_mage_5"
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].group = "mage"
tt.render.sprites[7].offset = v(29,40)

tt.ui.click_rect = r(-30, 10, 70, 70)
--4级防御塔的技能
tt.powers.disintegrate = CC("power")
tt.powers.disintegrate.price_base = 212
tt.powers.disintegrate.price_inc = 148
tt.powers.disintegrate.cooldown = {25,23,20}
tt.powers.disintegrate.enc_icon = 341
tt.powers.charging = CC("power")
tt.powers.charging.price_base = 170
tt.powers.charging.max_level = 1
tt.powers.charging.enc_icon = 339
tt.powers.explosion = CC("power")
tt.powers.explosion.price_base = 170
tt.powers.explosion.price_inc = 170
tt.powers.explosion.max_level = 2
tt.powers.explosion.damage_min = 32
tt.powers.explosion.damage_max = 38
tt.powers.explosion.enc_icon = 340

--攻击到怪物身上的效果
tt = E:register_t("fx_tower_blazing_watcher_hit_start", "fx")
--tt.render.sprites[1].name = "blazing_watcher_hit_run"
tt = E:register_t("fx_tower_blazing_watcher_hit_source", "fx")
tt.render.sprites[1].name = "blazing_watcher_hit_level4Run"
tt.render.sprites[1].loop = true
tt.timed.runs = 1e+99
--攻击
tt = E:register_t("bullet_tower_blazing_watcher_lvl1", "bullet")
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 2
tt.bullet.damage_max = 4
tt.bullet.hit_time = fts(4)
tt.bullet.mods = {"mod_tower_blazing_watcher_damage"}
tt.bullet.out_start_fx = "fx_tower_blazing_watcher_hit_start"
tt.bullet.out_fx = "fx_tower_blazing_watcher_hit_source"
--后续要尝试改成4阶段打击效果
tt.hit_fx_only_no_target = true
tt.image_width = 152.5
tt.main_script.update = scripts.bullet_tower_blazing_watcher.update
tt.render.sprites[1].anchor = v(0, 0.5)--v(0.5,0.5)--v(1.0,1.0)--v(0.5, 0.5)
tt.render.sprites[1].prefix = "blazing_watcher_ray"
tt.render.sprites[1].name = "loop"--后续要尝试改成234阶段的效果
tt.render.sprites[1].loop = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].anchor = v(0.5, 0.5)
tt.render.sprites[2].prefix = "blazing_watcher_gem_sparkles"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].z = Z_BULLETS + 1
tt.render.sprites[2].loop = true
tt.render.sprites[2].hidden = true
tt.sound_events.insert = "blazing_watcher_attack_loop"
tt.sound_events.interrupt = "blazing_watcher_attack_end"
tt.track_target = true
tt.ray_duration = 9999
tt.damage_mult = 1
tt.vis_flags = F_RANGED

tt = E:register_t("bullet_tower_blazing_watcher_lvl2", "bullet_tower_blazing_watcher_lvl1")
tt.bullet.damage_min = 7
tt.bullet.damage_max = 10
tt = E:register_t("bullet_tower_blazing_watcher_lvl3", "bullet_tower_blazing_watcher_lvl1")
tt.bullet.damage_min = 13
tt.bullet.damage_max = 19

tt = E:register_t("bullet_tower_blazing_watcher_lvl4", "bullet_tower_blazing_watcher_lvl1")
tt.bullet.damage_min = 19
tt.bullet.damage_max = 29

tt = E:register_t("mod_tower_blazing_watcher_damage", "modifier")

AC(tt, "render", "dps", "tween")

tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_type = bor(DAMAGE_MAGICAL, DAMAGE_ONE_SHIELD_HIT)
tt.dps.damage_every = 0.4
tt.dps.pop = {
	"pop_zap_arcane"
}
tt.dps.pop_conds = DR_KILL
tt.main_script.update = scripts.mod_tower_blazing_watcher_damage.update
tt.modifier.duration = 9999
tt.modifier.allows_duplicates = true
tt.modifier.use_mod_offset = true
tt.render.sprites[1].name = "blazing_watcher_hit_run"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].scale = vv(1)
tt.damage_from_bullet = true
tt.damage_tiers = {1,2,3,4,5,6,7,8,9,10}
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(2),
		0
	}
}
tt.tween.remove = true
tt.tween.disabled = true

--秒杀
tt = E:register_t("fx_blazing_watcher_ray_chargedBlast_mod_start", "fx")

tt = E:register_t("fx_blazing_watcher_ray_chargedBlast_mod_hit", "fx")
tt.render.sprites[1].name = "blazing_watcher_charged_blast_explotion_run"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].fps = 25
tt.timed.duration = fts(18)
tt.timed.runs = 1e+99
tt = E:register_t("blazing_watcher_ray_chargedBlast", "bullet_tower_blazing_watcher_lvl4")
tt.main_script.update = scripts.bullet_tower_blazing_watcher_chargedBlast.update
tt.sound_events.insert = nil
tt.sound_events.interrupt = nil
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.mods = {"blazing_watcher_ray_chargedBlast_mod"}
tt.bullet.out_fx = "fx_blazing_watcher_ray_chargedBlast_mod_start"
tt.bullet.hit_fx = "fx_blazing_watcher_ray_chargedBlast_mod_hit"
tt.image_width = 155
tt.render.sprites[1].prefix = "blazing_watcher_ray"
tt.render.sprites[1].name = "chargedBlast"
tt.render.sprites[1].loop = false
tt.bullet.hit_time = fts(1)
tt.hit_fx_only_no_target = false

tt = E:register_t("blazing_watcher_ray_chargedBlast_mod", "modifier")

AC(tt, "render")
tt.render.sprites[1].name = "blazing_watcher_hit_run"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].scale = vv(1)
tt.main_script.update = scripts.blazing_watcher_ray_chargedBlast_mod.update
tt.modifier.pop = {
	"pop_zap_arcane"
}
tt.modifier.pop_conds = DR_KILL
tt.modifier.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS, DAMAGE_IGNORE_SHIELD)
tt.modifier.damage = 1
tt.modifier.duration = fts(5)

tt = E:register_t("blazing_watcher_bolt_blast", "bullet")
tt.main_script.insert = scripts.blazing_watcher_bolt_blast.insert
tt.main_script.update = scripts.blazing_watcher_bolt_blast.update
tt.render.sprites[1].prefix = "blazing_watcher_explotion"
tt.render.sprites[1].name = "run"
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 32
tt.bullet.damage_max = 38
tt.bullet.damage_radius = 50
tt.bullet.damage_flags = F_AREA
tt.sound_events.insert = "blazing_watcher_explosion"


----------------------------------------------
-------------火光祭坛 Ignis Altar--------------
----------------------------------------------
tt = E:register_t("tower_build_ignis_altar", "tower_build")
tt.build_name = "tower_ignis_altar_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "ignis_altar_lvl1_build_0001"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
tt = E:register_t("tower_ignis_altar_lvl1", "tower_KR5")
E:add_comps(tt, "attacks", "vis")
--防御塔基本信息
tt.tower.type = "ignis_altar"
tt.tower.kind = TOWER_KIND_ENGINEER
tt.tower.team = TEAM_LINIREA
tt.tower.level = 1
tt.tower.price = 120
tt.tower.menu_offset = v(0, 20)
--脚本
tt.main_script.update = kr4_scripts.tower_ignis_altar.update
--tt.main_script.insert = kr4_scripts.tower_ray.insert
--tt.main_script.update = kr4_scripts.tower_ray.update
--信息栏
tt.info.portrait = "gui4_bottom_info_image_towers_0024"
--tt.info.room_portrait = "towerselect_quickmenu_icons_0021"
tt.info.enc_icon = 17
tt.info.i18n_key = "TOWER_DINOS_IGNIS_ALTAR_LEVEL1"
--tt.info.tower_portrait = "towerselect_portraits_big_" .. "0002"
tt.info.damage_icon = "fireball"
tt.info.stat_damage = 5
tt.info.stat_range = 7
tt.info.stat_cooldown = 2
tt.info.fn = kr4_scripts.tower_ignis_altar.get_info
--动画
--第一个是要保留的。动画默认设置为true，如果不是动画需要手动false
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
--第二个是防御塔
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "ignis_altar_lvl1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].exo = true
tt.render.sprites[2].offset = v(-3, 0)

--声音和其他信息
tt.mage_offset = v(0, 80)
tt.sound_events.insert = "kr4_ignis_altar_taunt"
tt.sound_events.tower_room_select = "TowerRayTauntSelect"
tt.ui.click_rect = r(-30, 0, 60, 65)

--攻击信息
tt.attacks.range = 165
tt.attacks.attack_delay_on_spawn = fts(5)
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].range = 165
tt.attacks.list[1].bullet = "bullet_tower_ignis_altar_lvl1"
tt.attacks.list[1].cooldown = 4.0 --应该和script有关
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].first_cooldown = 2
tt.attacks.list[1].node_prediction = fts(25)
tt.attacks.list[1].bullet_start_offset = v(2, 40)
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE, F_FLYING)
tt.attacks.list[1].vis_flags = bor(F_RANGED, F_AREA)

tt = E:register_t("tower_ignis_altar_lvl2", "tower_ignis_altar_lvl1")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_DINOS_IGNIS_ALTAR_LEVEL2"
tt.tower.level = 2
tt.tower.price = 160
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 180
tt.attacks.list[1].range = 180
tt.attacks.list[1].bullet = "bullet_tower_ignis_altar_lvl2"
tt.attacks.list[1].bullet_start_offset = v(2, 45)
tt.render.sprites[2].prefix = "ignis_altar_lvl2"--3和4不需要动
tt.ui.click_rect = r(-30, 0, 60, 65)

tt = E:register_t("tower_ignis_altar_lvl3", "tower_ignis_altar_lvl1")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_DINOS_IGNIS_ALTAR_LEVEL3"
tt.tower.level = 3
tt.tower.price = 220
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 195
tt.attacks.list[1].range = 195
tt.attacks.list[1].cooldown = 3.5
tt.attacks.list[1].bullet = "bullet_tower_ignis_altar_lvl3"
tt.attacks.list[1].bullet_start_offset = v(2, 50)
tt.render.sprites[2].prefix = "ignis_altar_lvl3"--3和4不需要动
tt.ui.click_rect = r(-30, 0, 65, 70)

tt = E:register_t("tower_ignis_altar_lvl4", "tower_ignis_altar_lvl1")
E:add_comps(tt, "powers","barrack")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_DINOS_IGNIS_ALTAR_LEVEL4"
tt.tower.level = 4
tt.tower.price = 300
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 210
tt.attacks.list[1].range = 205
tt.attacks.list[1].bullet = "bullet_tower_ignis_altar_lvl4"
tt.attacks.list[1].bullet_start_offset = v(2, 55)
tt.attacks.list[1].cooldown = 3.5 --应该和script有关
tt.attacks.list[2] = E:clone_c("bullet_attack")
--tt.attacks.list[2].animation = "attack"
tt.attacks.list[2].bullet = "tower_ignis_altar_bolt"
tt.attacks.list[2].disabled = true
tt.attacks.list[2].cooldown = 18
tt.attacks.list[2].range = 210
tt.attacks.list[2].shoot_time = fts(20)
tt.attacks.list[2].bullet_start_offset = v(2, 55)
tt.attacks.list[2].node_prediction = 0
tt.attacks.list[2].sound = "TowerArboreanEmissaryBasicAttack"
tt.attacks.list[2].vis_bans = bor(F_NIGHTMARE)
tt.render.sprites[2].prefix = "ignis_altar_lvl4"--3和4不需要动

tt.ui.click_rect = r(-30, 0, 65, 70)
tt.powers.golemstone = CC("power")
tt.powers.golemstone.price_base = 255
tt.powers.golemstone.enc_icon = 368
tt.powers.golemstone.max_level = 1
tt.powers.firewheel = CC("power")
tt.powers.firewheel.price_base = 153
tt.powers.firewheel.price_inc = 85
tt.powers.firewheel.cooldown = 18
tt.powers.firewheel.max_level = 3
tt.powers.firewheel.enc_icon = 370
tt.powers.firewheel.damage = {32,54,76}
tt.powers.stickylava = CC("power")
tt.powers.stickylava.price_base = 212
tt.powers.stickylava.max_level = 1
tt.powers.stickylava.enc_icon = 369
tt.barrack.soldier_type = "soldier_lavagolem"
tt.barrack.rally_range = 195
tt.main_script.insert = kr1_scripts.tower_barrack.insert
--tt.main_script.update = scripts.tower_sorcerer.update
tt.main_script.remove = kr1_scripts.tower_barrack.remove

tt = E:register_t("fx_bullet_tower_ignis_altar_basic_hit", "fx")
tt.render.sprites[1].name = "ignis_altar_base_explosion"
tt.render.sprites[1].scale = v(2,2)
tt.render.sprites[1].offset = v(0, 26)

tt = E:register_t("ps_bullet_tower_ignis_altar_basic_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "ignis_altar_bullet_smoke"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(6),
	fts(6)
}
tt.particle_system.emission_rate = 50
tt.particle_system.emit_rotation_spread = math.pi * 2

tt = E:register_t("bullet_tower_ignis_altar_lvl1", "bombKR5")
AC(tt, "aura")
tt.bullet.level = 1
tt.main_script.update = scripts.ignis_altar_bomb.update
tt.bullet.flight_time = fts(25)
tt.sound_events.insert = "BombShootSound"
tt.sound_events.hit = "TowerHermitToadShootEngineerImpact"
tt.bullet.hit_fx = "fx_bullet_tower_ignis_altar_basic_hit"
tt.bullet.pop = nil
tt.bullet.align_with_trajectory = true
tt.bullet.mod = "mod_tower_ignis_altar_lava"
tt.bullet.ignore_hit_offset = true
tt.bullet.pop_chance = 0.5
tt.bullet.rotation_speed = nil
tt.bullet.hit_payload = "aura_bullet_tower_ignis_altar"
tt.bullet.damage_max = 2
tt.bullet.damage_min = 2
tt.bullet.damage_every = 0.4
tt.bullet.damage_type = DAMAGE_ELECTRICAL--DAMAGE_EXPLOSION
tt.bullet.damage_radius = 50
tt.bullet.aura_duration = 3.5
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "ignis_altar_base_bullet"
tt.render.sprites[1].anchor = v(0.4, 0.5)
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.bullet.particles_name = "ps_bullet_tower_ignis_altar_basic_trail"
tt.aura_duration = 3.5

tt = E:register_t("bullet_tower_ignis_altar_lvl2", "bullet_tower_ignis_altar_lvl1")
tt.bullet.level = 2
tt.bullet.damage_max = 4
tt.bullet.damage_min = 4
tt.bullet.damage_every = 0.35

tt = E:register_t("bullet_tower_ignis_altar_lvl3", "bullet_tower_ignis_altar_lvl1")
tt.bullet.level = 3
tt.bullet.damage_max = 6
tt.bullet.damage_min = 6
tt.bullet.damage_every = 0.3

tt = E:register_t("bullet_tower_ignis_altar_lvl4", "bullet_tower_ignis_altar_lvl1")
tt.bullet.level = 4
tt.bullet.damage_max = 8
tt.bullet.damage_min = 8
tt.bullet.damage_every = 0.2

tt = E:register_t("mod_tower_ignis_altar_slow", "mod_slow")
tt.balance_slow_factor = 1
tt.balance_duration = 0
tt.slow.factor = nil
tt.modifier.duration = nil

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.balance_slow_factor
	this.modifier.duration = this.balance_duration

	return scripts.mod_slow.insert(this, store, script)
end

tt = E:register_t("aura_bullet_tower_ignis_altar", "aura")

E:add_comps(tt, "render", "tween")

tt.aura.mod = "mod_tower_ignis_altar_slow"
tt.aura.radius = 50
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.cycle_time = fts(5)
tt.render.sprites[1].prefix = "ignis_altar_decal"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.tween.props[1].name = "alpha"
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		tt.aura.duration - 0.5,
		255
	},
	{
		tt.aura.duration,
		0
	}
}

tt = E:register_t("mod2_tower_ignis_altar_slow", "mod_slow")
tt.balance_slow_factor = 0.5
tt.balance_duration = 0.3
tt.slow.factor = nil
tt.modifier.duration = nil

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.balance_slow_factor
	this.modifier.duration = this.balance_duration

	return scripts.mod_slow.insert(this, store, script)
end

tt = E:register_t("aura2_bullet_tower_ignis_altar", "aura")

E:add_comps(tt, "render", "tween")

tt.aura.mod = "mod2_tower_ignis_altar_slow"
tt.aura.radius = 50
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.cycle_time = fts(5)
tt.render.sprites[1].prefix = "ignis_altar_decal_lava"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.tween.props[1].name = "alpha"
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		tt.aura.duration - 0.5,
		255
	},
	{
		tt.aura.duration,
		0
	}
}

tt = RT("soldier_lavagolem", "soldier_militia")

AC(tt, "melee", "nav_grid")

image_y = 64
anchor_y = 0.15
tt.health.armor = 0
tt.health.armor_inc = 0
tt.health.dead_lifetime = 10
tt.health.hp_max = 585
tt.health.hp_inc = 0
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "TOWER_DINOS_IGNIS_ALTAR_LEVEL4_BURNING_ELEMENTAL_TITLE_1"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0057"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].count = 1
tt.melee.attacks[1].damage_inc = 0
tt.melee.attacks[1].damage_max = 43
tt.melee.attacks[1].damage_min = 19
tt.melee.attacks[1].damage_radius = 37.5
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.range = 50
tt.motion.max_speed = 30
tt.regen.health = 30
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].name = "raise"

--tt.render.sprites[1].prefix = "soldier_elemental"
tt.render.sprites[1].prefix = "ignis_altar_lava_golem"
tt.render.sprites[1].exo = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "asst_lavagolem_shadow"
tt.render.sprites[2].anchor.y = 0.5
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1

tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "RockElementalDeath"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)

tt = E:register_t("fx_tower_ignis_altar_bolt_hit", "fx")
tt.render.sprites[1].name = "ignis_altar_taunt2_bullet_flying"

tt = E:register_t("tower_ignis_altar_bolt", "bolt")

E:add_comps(tt, "force_motion")

tt.render.sprites[1].prefix = "ignis_altar_taunt2_bullet"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BULLETS
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.height_attack = 70
tt.initial_vel_y = 50
tt.transition_time = 1
tt.target_distance_detection = 20
tt.main_script.update = kr4_scripts.tower_ignis_altar_bolt.update
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 30
tt.bullet.max_speed = 300
--tt.bullet.hit_fx = "fx_tower_ignis_altar_bolt_hit"
tt.bullet.mod = "mod_tower_ignis_altar_firewheel"
--tt.bullet.particles_name = "ps_tower_ignis_altar_bolt_trail"
tt.bullet.max_speed = 1800
tt.bullet.min_speed = 30
tt.initial_impulse = 9000
tt.initial_impulse_duration = 0.1
tt.initial_impulse_angle = math.pi / 2
tt.force_motion.a_step = 10
tt.force_motion.max_a = 1800
tt.force_motion.max_v = 450
tt.sound_events.insert = nil

tt = E:register_t("mod_tower_ignis_altar_firewheel", "modifier")

E:add_comps(tt, "render")

tt.received_damage_factor_config = {1.5,1.75,2}
tt.modifier_duration = {10,10,10}
tt.main_script.insert = kr4_scripts.mod_ignis_altar_weak.insert
tt.main_script.remove = kr4_scripts.mod_ignis_altar_weak.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.vis_flags = F_MOD
tt.modifier.type = MOD_TYPE_POISON
tt.inflicted_damage_factor = nil
tt.received_damage_factor = nil
tt.render.sprites[1].name = "ignis_altar_taunt2_debuff"
tt.render.sprites[1].draw_order = DO_MOD_FX
tt.render.sprites[1].size_names = {
	"ignis_altar_taunt2_debuff",
	"ignis_altar_taunt2_debuff",
	"ignis_altar_taunt2_debuff"
}

tt = E:register_t("mod_tower_ignis_altar_lava", "bullet")
tt.main_script.update = scripts.tower_ignis_altar_lava.update

tt.bullet.damage_type = DAMAGE_ELECTRICAL--DAMAGE_EXPLOSION

tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_radius = 50
tt.bullet.damage_bans = bor(F_FLYING)
tt.bullet.damage_flags = F_AREA
--tt.sound_events.insert = "blazing_watcher_explosion"



----------------------------------------------
------------------食人魔沉船-------------------
----------------------------------------------
--模仿圣骑士巢穴的插入功能
--tower_build_ogre_shipwreck
tt = E:register_t("tower_build_ogre_shipwreck", "tower_build")
tt.build_name = "tower_ogre_shipwreck_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2].name = "ogre_shipwreck_tower_lvl1_layer1_0001"
tt.render.sprites[2].offset = v(0, 34)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E:register_t("tower_ogre_shipwreck_lvl1", "tower_KR5")

E:add_comps(tt, "barrack", "vis")
tt.info.i18n_key = "TOWER_OGRES_BARRACK_LEVEL1"
tt.barrack.rally_range = 165
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "cook_ogre_lvl1"
tt.barrack.max_soldiers = 1
tt.info.fn = kr4_scripts.tower_ogre_shipwreck.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0027"
tt.main_script.insert = kr4_scripts.tower_ogre_shipwreck.insert
tt.main_script.remove = kr4_scripts.tower_ogre_shipwreck.remove
tt.main_script.update = kr4_scripts.tower_ogre_shipwreck.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].anchor.y = 0.13
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "ogre_shipwreck_tower_lvl1_layer1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].anchor.y = 0.13
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 0)
tt.render.sprites[3].prefix = "ogre_shipwreck_tower_lvl1_layer2"
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "OgreShipwreckTaunt"
tt.sound_events.insert = "OgreShipwreckTaunt"
tt.tower.level = 1
tt.tower.price = 130
tt.tower.type = "ogre_shipwreck"
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.team = TEAM_DARK_ARMY
tt.tower.menu_offset = v(0, 15)
tt.ui.click_rect = r(-40, 0, 80, 70)

tt = E:register_t("tower_ogre_shipwreck_lvl2", "tower_ogre_shipwreck_lvl1")
tt.info.i18n_key = "TOWER_OGRES_BARRACK_LEVEL2"
tt.barrack.soldier_type = "cook_ogre_lvl2"
tt.barrack.max_soldiers = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "ogre_shipwreck_tower_lvl2_layer1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 0)
tt.render.sprites[3].prefix = "ogre_shipwreck_tower_lvl2_layer2"

tt.tower.level = 2
tt.tower.price = 170
tt.tower.type = "ogre_shipwreck"
tt.tower.kind = TOWER_KIND_BARRACK
tt.tower.team = TEAM_DARK_ARMY

tt = E:register_t("tower_ogre_shipwreck_lvl3", "tower_ogre_shipwreck_lvl2")
E:add_comps(tt, "attacks")
tt.info.i18n_key = "TOWER_OGRES_BARRACK_LEVEL3"
tt.tower.level = 3
tt.tower.price = 220
tt.tower.type = "ogre_shipwreck"
tt.attacks.range = 186.375
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].range = 186.375
tt.attacks.list[1].shoot_time = fts(6)
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet = "bullet_tower_ogre_shipwreck_lvl3"
tt.attacks.list[1].bullet_start_offset = v(0, 55)
tt.attacks.list[1].cooldown = 1.5 
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].sound = "TowerArboreanEmissaryBasicAttack"
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "ogre_shipwreck_tower_lvl3_layer1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].animated = true
tt.render.sprites[3].prefix = "musketer_tower_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 55)
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
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].anchor.y = 0.13
tt.render.sprites[4].loop = false
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(0, 0)
tt.render.sprites[4].prefix = "ogre_shipwreck_tower_lvl3_layer2"


tt = E:register_t("tower_ogre_shipwreck_lvl4", "tower_ogre_shipwreck_lvl3")
E:add_comps(tt, "powers")
tt.info.i18n_key = "TOWER_OGRES_BARRACK_LEVEL4"
tt.tower.level = 4
tt.tower.price = 280
tt.tower.type = "ogre_shipwreck"
tt.powers.enhance = E:clone_c("power")
tt.powers.enhance.price_base = 127
tt.powers.enhance.enc_icon = 374
tt.powers.enhance.max_level = 1
tt.powers.multishoot = CC("power")
tt.powers.multishoot.price_base = 119
tt.powers.multishoot.price_inc = 119
tt.powers.multishoot.cooldown = 15
tt.powers.multishoot.max_level = 2
tt.powers.multishoot.enc_icon = 375
tt.powers.goblin = CC("power")
tt.powers.goblin.price_base = 170
tt.powers.goblin.price_inc = 85
tt.powers.goblin.max_level = 2
tt.powers.goblin.enc_icon = 376
tt.powers.goblin.cooldown = {15, 10}
tt.attacks.range = 210
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].bullet = "bomb_tower_ogre_shipwreck_lvl4"
tt.attacks.list[2].cooldown = 4
tt.attacks.list[2].range = 210
tt.attacks.list[2].shoot_time = fts(39)
tt.attacks.list[2].bullet_start_offset = v(-39, 43)
tt.attacks.list[2].node_prediction = fts(26)
--tt.attacks.list[2].sound = "TowerArboreanEmissaryBasicAttack"
tt.attacks.list[2].vis_bans = bor(F_NIGHTMARE, F_FLYING)
tt.attacks.list[3] = E:clone_c("bullet_attack")
tt.attacks.list[3].bullet = "skillbomb_tower_ogre_shipwreck_lvl1"
tt.attacks.list[3].cooldown = nil
tt.attacks.list[3].range = 210
tt.attacks.list[3].shoot_time = fts(39)
tt.attacks.list[3].bullet_start_offset = v(-39, 43)
tt.attacks.list[3].node_prediction = fts(26)
--tt.attacks.list[3].sound = "TowerArboreanEmissaryBasicAttack"
tt.attacks.list[3].vis_bans = bor(F_NIGHTMARE, F_FLYING)
tt.attacks.list[3].disabled = true
tt.attacks.list[4] = E:clone_c("bullet_attack")
tt.attacks.list[4].range = 178.5
tt.attacks.list[4].shoot_time = fts(1)
tt.attacks.list[4].bullet = "bullet_tower_ogre_shipwreck_skill1"
tt.attacks.list[4].bullet_start_offset = v(0, 45)
tt.attacks.list[4].cooldown = 15
tt.attacks.list[4].shots = 15 
tt.attacks.list[4].near_range = 96
tt.attacks.list[4].animation = "skillin"
tt.attacks.list[4].sound = "OgreShipwreckMultishooting"
tt.attacks.list[4].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[4].cycle_time = fts(2)
tt.attacks.list[4].disabled = true

tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].anchor.y = 0.13
tt.render.sprites[2].loop = true
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "ogre_shipwreck_tower_lvl4_flags"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].anchor.y = 0.13
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 0)
tt.render.sprites[3].prefix = "ogre_shipwreck_tower_lvl4_layer1"
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].animated = true
tt.render.sprites[4].prefix = "musketer_tower_shooter"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(0, 55)
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	skillin = {
		"skillUpIn",
		"skillDownIn"
	},
	skillloop = {
		"skillUpLoop",
		"skillDownLoop"
	},
	skillend = {
		"skillUpEnd",
		"skillDownEnd"
	},
}
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].anchor.y = 0.13
tt.render.sprites[5].loop = false
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(0, 0)
tt.render.sprites[5].prefix = "ogre_shipwreck_tower_lvl4_layer2"

tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].animated = true
tt.render.sprites[6].prefix = "goblin_bomber"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].offset = v(-41, 35)

tt = RT("cook_ogre_lvl1", "soldier_militia")

AC(tt, "melee", "nav_grid")
--tt.main_script.update = kr4_scripts.tower_ogre_shipwreck.soldier_update
tt.main_script.insert = kr4_scripts.tower_ogre_shipwreck.soldier_insert
image_y = 64
anchor_y = 0.21
tt.health.armor = 0
tt.health.dead_lifetime = 10
tt.health.hp_max = 585
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.drag_from_current = true
tt.info.i18n_key = "SOLDIER_COOK_OGRE"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0060"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].count = 5
tt.melee.attacks[1].damage_max = 66
tt.melee.attacks[1].damage_min = 44
tt.melee.attacks[1].damage_radius = 35
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.2
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.range = 75
tt.motion.max_speed = 20
tt.regen.cooldown = 2
tt.regen.health = 16
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].angles.running = {
	"walk"
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "cook_ogre"
tt.soldier.melee_slot_offset = v(15, 0)
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)

tt = RT("cook_ogre_lvl2", "cook_ogre_lvl1")
tt.health.hp_max = 760
tt.melee.attacks[1].damage_max = 85
tt.melee.attacks[1].damage_min = 57

tt = RT("cook_ogre_lvl3", "cook_ogre_lvl1")
tt.health.armor = 0.3
tt.health.hp_max = 760
tt.melee.attacks[1].damage_max = 105
tt.melee.attacks[1].damage_min = 77

tt = E:register_t("deckhand_goblin_blue_lvl1", "cook_ogre_lvl1")
anchor_y = 0.18
image_y = 42
tt.health.armor = 0
tt.health.dead_lifetime = 6
tt.health.hp_max = 169
tt.health.dark_damage_type = DAMAGE_PHYSICAL
tt.health_bar.offset = v(0, 32)
tt.info.i18n_key = "SOLDIER_DECKHAND_GOBLIN"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0061"
tt.melee.attacks[1].cooldown = 0.7
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 13
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.health = 13
tt.regen.cooldown = 2
tt.render.sprites[1].prefix = "deckhand_goblin"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = anchor_y
--tt.render.sprites[2] = E:clone_c("sprite")
--tt.render.sprites[2].is_shadow = true
--tt.render.sprites[2].animated = false
--tt.render.sprites[2].name = "deckhand_goblin_shadow"
--tt.render.sprites[2].anchor.y = anchor_y
--tt.render.sprites[2].offset = v(0, 0)
--tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))

tt = E:register_t("deckhand_goblin_blue_lvl2", "deckhand_goblin_blue_lvl1")
tt.health.armor = 0.3
tt.melee.attacks[1].damage_max = 23
tt.melee.attacks[1].damage_min = 17

tt = E:register_t("deckhand_goblin_red_lvl1", "soldier_militia")
AC(tt, "reinforcement")
tt.main_script.update = kr4_scripts.red_soldier_tower_ogrc_shipwreck.update
tt.health.armor = 0
tt.health.hp_max = 169
tt.regen.health = 0
tt.regen.cooldown = 2
tt.info.portrait = "gui4_bottom_info_image_soldiers_0062"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 16
tt.melee.attacks[1].damage_min = 11
tt.render.sprites[1].prefix = "skill_goblin"
tt.render.sprites[1].name = "idle"
tt.reinforcement.duration = 5
tt.reinforcement.fade = true
tt.patrol_pos_offset = v(15, 10)
tt.patrol_min_cd = 3
tt.patrol_max_cd = 6

tt = E:register_t("deckhand_goblin_red_lvl2", "deckhand_goblin_red_lvl1")
tt.health.armor = 0.3
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 14

tt = E:register_t("fx_musket_hit_hit", "fx")
tt.render.sprites[1].name = "musket_hit_hit"
tt.render.sprites[1].scale = v(2,2)
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false

tt = E:register_t("bullet_tower_ogre_shipwreck_lvl3", "shotgun")
tt.bullet.damage_max = 44
tt.bullet.damage_min = 30
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.hit_fx = "musket_hit_hit"
tt.bullet.start_fx = "fx_rifle_smoke"
tt.bullet.min_speed = 20 * FPS
tt.bullet.max_speed = 20 * FPS
tt.sound_events.insert = "ShotgunSound"

tt = E:register_t("bullet_tower_ogre_shipwreck_skill1", "shotgun")
tt.bullet.damage_max = 18
tt.bullet.damage_min = 18
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.hit_fx = "musket_hit_hit"
tt.bullet.start_fx = "fx_rifle_smoke"
tt.bullet.min_speed = 20 * FPS
tt.bullet.max_speed = 20 * FPS

tt = E:register_t("bullet_tower_ogre_shipwreck_skill2", "bullet_tower_ogre_shipwreck_skill1")
tt.bullet.damage_max = 29
tt.bullet.damage_min = 29

tt = E:register_t("fx_goblin_bomber_burst_burst", "fx")
tt.render.sprites[1].name = "goblin_bomber_burst_burst"
tt.render.sprites[1].scale = v(1.5,1.5)
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false

tt = RT("bomb_tower_ogre_shipwreck_lvl4", "bomb")
tt.bullet.flight_time = fts(31)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "fx_goblin_bomber_burst_burst"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 55
tt.bullet.damage_max = 77
tt.bullet.damage_radius = 63
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "goblin_bomber_projectil_0001"
tt.render.sprites[1].animated = false
tt.main_script.insert = kr1_scripts.bomb.insert
tt.main_script.update = kr1_scripts.bomb.update
tt.sound_events.insert = "BombShootSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"

tt = RT("skillbomb_tower_ogre_shipwreck_lvl1", "bomb")
tt.bullet.flight_time = fts(31)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
--tt.bullet.hit_fx = "fx_goblin_bomber_burst_burst"
--tt.bullet.hit_decal = "decal_bomb_crater"
--tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 55
tt.bullet.damage_max = 77
tt.bullet.damage_radius = 63
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "skill_goblin_projectile_basic_0001"
tt.render.sprites[1].animated = false
tt.main_script.insert = kr1_scripts.bomb.insert
tt.main_script.update = kr1_scripts.bomb.update
tt.sound_events.insert = "BombShootSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"
tt.bullet.hit_payload = "deckhand_goblin_red_lvl1"

tt = RT("skillbomb_tower_ogre_shipwreck_lvl2", "skillbomb_tower_ogre_shipwreck_lvl1")
tt.bullet.hit_payload = "deckhand_goblin_red_lvl2"

---------------------------------------------
--------------------死灵墓--------------------
---------------------------------------------
--建造
tt = E:register_t("tower_build_spirit_mausoleum", "tower_build")
tt.build_name = "tower_spirit_mausoleum_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2].name = "spirit_mausoleum_lvl1_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 35)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

--2级防御塔
tt = E:register_t("tower_spirit_mausoleum_lvl2", "tower_KR5")
E:add_comps(tt, "attacks", "vis")
tt.tower.type = "spirit_mausoleum"
tt.tower.kind = TOWER_KIND_MAGE
tt.tower.team = TEAM_DARK_ARMY
tt.tower.level = 2
tt.tower.price = 130
tt.tower.menu_offset = v(0, 19)
tt.info.i18n_key = "TOWER_FALLEN_ONES_SPIRITS_LEVEL2"
tt.info.portrait = "gui4_bottom_info_image_towers_0008"
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.update = kr4_scripts.tower_spirit_mausoleum.update
tt.main_script.remove = kr4_scripts.tower_spirit_mausoleum.remove
tt.attacks.range = 170
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].animation = "shootEmpty"
tt.attacks.list[1].charge_animation = "shoot"
tt.attacks.list[1].bullet = "tower_spirit_mausoleum_lvl2_bolt"
tt.attacks.list[1].max_charges = 3
tt.attacks.list[1].stored_bullets = {}
tt.attacks.list[1].cooldown = 1.45
tt.attacks.list[1].shoot_time = 0.6
tt.attacks.list[1].bullet_start_offset = v(-3, 65)
tt.attacks.list[1].node_prediction = 0
tt.attacks.list[1].sound = "fallen_ones_spirit_mausoleum_attack_preload"
tt.attacks.list[1].release_sound = "fallen_ones_spirit_mausoleum_attack"
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 13)
for i = 2, 4 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "spirit_mausoleum_lvl2_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 11)
	tt.render.sprites[i].anchor.y = 0.228
	tt.render.sprites[i].group = "layers"
end
tt.sound_events.insert = "fallen_ones_spirit_mausoleum_build_taunt"
tt.ui.click_rect = r(-37, 0, 74, 62)

tt = E:register_t("tower_spirit_mausoleum_lvl1", "tower_spirit_mausoleum_lvl2")
tt.tower.level = 1
tt.tower.price = 110
tt.attacks.range = 160
tt.info.i18n_key = "TOWER_FALLEN_ONES_SPIRITS_LEVEL1"
tt.attacks.list[1].bullet = "tower_spirit_mausoleum_lvl1_bolt"
for i = 2, 4 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "spirit_mausoleum_lvl1_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 11)
	tt.render.sprites[i].anchor.y = 0.228
	tt.render.sprites[i].group = "layers"
end
tt.ui.click_rect = r(-35, 0, 70, 60)

tt = E:register_t("tower_spirit_mausoleum_lvl3", "tower_spirit_mausoleum_lvl2")
tt.tower.level = 3
tt.tower.price = 170
tt.attacks.range = 185
tt.info.i18n_key = "TOWER_FALLEN_ONES_SPIRITS_LEVEL3"
tt.attacks.list[1].bullet = "tower_spirit_mausoleum_lvl3_bolt"
for i = 2, 4 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "spirit_mausoleum_lvl3_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 11)
	tt.render.sprites[i].anchor.y = 0.228
	tt.render.sprites[i].group = "layers"
end
tt.ui.click_rect = r(-39, 0, 78, 64)

tt = E:register_t("tower_spirit_mausoleum_lvl4", "tower_spirit_mausoleum_lvl2")
b = balance.towers.spirit_mausoleum
E:add_comps(tt, "barrack", "powers")
tt.tower.level = 4
tt.tower.price = 230
tt.attacks.range = 200
tt.info.i18n_key = "TOWER_FALLEN_ONES_SPIRITS_LEVEL4"
tt.barrack.soldier_type = "fallen_ones_gargoyle"
tt.barrack.rally_range = 160
tt.barrack.max_soldiers = 0
tt.sound_events.change_rally_point = "fallen_ones_spirit_mausoleum_build_taunt"
tt.powers.spectral_communion = E:clone_c("power")
tt.powers.spectral_communion.price_base = 127
tt.powers.spectral_communion.price_inc = 85
tt.powers.spectral_communion.max_level = 2
tt.powers.spectral_communion.max_charges = {
	4,
	5
}
tt.powers.spectral_communion.unit_type = {
	"draugr",
	"draugr"
}
tt.powers.spectral_communion.enc_icon = 326
tt.powers.spectral_communion.hp = {100,150,200}
tt.powers.spectral_communion.cooldown = {30,15}
tt.powers.spectral_communion.cooldown_inc = 0
tt.powers.spectral_communion.bullet_list = {"tower_spirit_mausoleum_lvl4_bolt", "tower_spirit_mausoleum_lvl4_bolt"}
tt.powers.possession = E:clone_c("power")
tt.powers.possession.price_base = 170
tt.powers.possession.price_inc = 85
tt.powers.possession.cooldown = {23,20,17}
tt.powers.possession.enc_icon = 324
tt.powers.gargoyles = E:clone_c("power")
tt.powers.gargoyles.price_base = 212
tt.powers.gargoyles.price_inc = 212
tt.powers.gargoyles.max_level = 2
tt.powers.gargoyles.spawn_positions = {
	v(2, -5),
	v(35, 3)
}
tt.powers.gargoyles.spawn_fx = "fx_gargoyle_spawn"
tt.powers.gargoyles.spawn_time = 0.26
tt.powers.gargoyles.enc_icon = 325
tt.attacks.list[1].bullet = "tower_spirit_mausoleum_lvl4_bolt"
tt.attacks.list[1].bullet_start_offset = v(-7, 85)
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].animation = "cast"
tt.attacks.list[2].bullet_start_offset = {
	v(27, 17),
	v(29, 34)
}
tt.attacks.list[2].bullet = {
	"fx_bolt_possession_spawn",
	"bolt_possession"
}
tt.attacks.list[2].cooldown = 23
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING, F_NIGHTMARE, F_CLIFF, F_WATER)
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_BLOCK, F_POLYMORPH)
tt.attacks.list[2].shoot_time = 0.6
tt.attacks.list[2].excluded_templates = {}
--尸兵需要删掉
--[[
tt.attacks.list[3] = E:clone_c("custom_attack")
tt.attacks.list[3].animation = "cast"
tt.attacks.list[3].cooldown = 30
tt.attacks.list[3].cast_time = 0.6
tt.attacks.list[3].entity = "draugr"
tt.attacks.list[3].spawn_offset = v(25, 0)
tt.attacks.list[3].range = 120
]]--

for i = 2, 4 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "spirit_mausoleum_lvl4_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 8)
	tt.render.sprites[i].anchor.y = 0.24
	tt.render.sprites[i].group = "layers"
end
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].animated = false
tt.render.sprites[5].hidden = false
tt.render.sprites[5].name = "spirit_mausoleum_lvl4_gargoyle_idle_left"
tt.render.sprites[5].anchor.y = 0.07000000000000001
tt.render.sprites[5].offset = v(2, -5)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].animated = false
tt.render.sprites[6].hidden = false
tt.render.sprites[6].name = "spirit_mausoleum_lvl4_gargoyle_idle_right"
tt.render.sprites[6].anchor.y = 0.07000000000000001
tt.render.sprites[6].offset = v(35, 3)
tt.main_script.insert = scripts.tower_barrack.insert
tt.ui.click_rect = r(-43, 0, 86, 68)

--死灵墓子弹


tt = E:register_t("ps_tower_spirit_mausoleum_bolt")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "spirit_mausoleum_particle"
tt.particle_system.animated = false
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	0.25,
	0.25
}
tt.particle_system.emission_rate = 50
tt.particle_system.scales_y = {
	1,
	0.1
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.alphas = {
	255,
	12
}

tt = E:register_t("fx_tower_spirit_mausoleum_bolt_hit", "fx")
tt.render.sprites[1].name = "spirit_mausoleum_bolt_hit"

tt = E:register_t("initial_bolt", "bolt")
tt.render.sprites[1].prefix = nil
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.flip_x = nil
tt.sound_events.insert = nil
tt.main_script.insert = nil
tt.main_script.update = kr4_scripts.initial_bolt.update


tt = E:register_t("tower_spirit_mausoleum_lvl2_bolt", "initial_bolt")
E:add_comps(tt, "force_motion")
tt.render.sprites[1].name = "spirit_mausoleum_bolt_0001"
tt.render.sprites[1].prefix = nil
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_max = 24--20
tt.bullet.damage_min = 15--13
tt.bullet.hit_fx = "fx_tower_spirit_mausoleum_bolt_hit"
tt.bullet.particles_name = "ps_tower_spirit_mausoleum_bolt"
tt.bullet.align_with_trajectory = true
tt.bullet.max_speed = 90
tt.bullet.destination_offsets = {
	v(-25, 5),
	v(25, -5),
	v(-25, -5),
	v(25, 5)
}
tt.initial_angle = math.pi * 5 / 12
tt.travel_impulse = 360
tt.max_acceleration = 600
tt.travel_step = 5
tt.travel_peak = 1
tt.travel_impulse_duration = fts(25)
tt.step_y = -2
tt.step_times = 12
tt.target_found = nil
tt.main_script.insert = nil
tt.main_script.update = kr4_scripts.tower_spirit_mausoleum_bolt.update
tt.initial_impulse = 848
tt.initial_impulse_duration = 0.1
tt.initial_impulse_angle = math.pi / 4
tt.force_motion.a_step = 10
tt.force_motion.max_a = 12000
tt.force_motion.max_v = 500
tt.sound_events.insert = nil

tt = E:register_t("tower_spirit_mausoleum_lvl1_bolt", "tower_spirit_mausoleum_lvl2_bolt")
tt.bullet.damage_max = 10--8
tt.bullet.damage_min = 6--5

tt = E:register_t("tower_spirit_mausoleum_lvl3_bolt", "tower_spirit_mausoleum_lvl2_bolt")
tt.bullet.damage_max = 46--38
tt.bullet.damage_min = 31--26

tt = E:register_t("tower_spirit_mausoleum_lvl4_bolt", "tower_spirit_mausoleum_lvl2_bolt")
tt.bullet.damage_max = 86--71
tt.bullet.damage_min = 58--48

tt = E:register_t("tower_spirit_mausoleum_lvl41_bolt", "tower_spirit_mausoleum_lvl2_bolt")
tt.bullet.damage_max = 111
tt.bullet.damage_min = 68

tt = E:register_t("tower_spirit_mausoleum_lvl42_bolt", "tower_spirit_mausoleum_lvl2_bolt")
tt.bullet.damage_max = 136
tt.bullet.damage_min = 78

--策反
tt = E:register_t("fx_bolt_possession_spawn", "fx")
tt.render.sprites[1].name = "spirit_mausoleum_lvl4_possession_spawn_run"
tt.render.sprites[1].anchor = v(0.5, 0.14)
tt.render.sprites[1].z = Z_OBJECTS + 1

tt = E:register_t("fx_bolt_possession_hit", "fx")
tt.render.sprites[1].name = "spirit_mausoleum_lvl4_possession_proyectile_hit"

tt = RT("mod_possession", "modifier")
E:add_comps(tt, "render")
b = balance.towers.spirit_mausoleum
tt.render.sprites[1].prefix = "spirit_mausoleum_lvl4_possession_decal"
tt.render.sprites[1].anchor = v(0.5, 0.211)
tt.render.sprites[1].draw_order = DO_MOD_FX
tt.possession_duration = {10,10,10}
tt.modifier.duration = 10
tt.modifier.use_mod_offset = nil
tt.main_script.insert = kr4_scripts.mod_possession.insert
tt.main_script.update = kr4_scripts.mod_possession.update
tt.main_script.remove = kr4_scripts.mod_possession.remove

tt = E:register_t("bolt_possession", "initial_bolt")
E:add_comps(tt, "tween")
tt.render.sprites[1].name = "spirit_mausoleum_lvl4_possession_proyectile_travel"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.tween.remove = false
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
tt.bullet.damage_type = 0
tt.bullet.acceleration_factor = 0.01
tt.bullet.min_speed = 100
tt.bullet.max_speed = 200
tt.bullet.max_track_distance = REF_H / 2
tt.bullet.flip_x = true
tt.bullet.mod = "mod_possession"
tt.bullet.hit_fx = "fx_bolt_possession_hit"
tt.sound_events.insert = "fallen_ones_spirit_mausoleum_possession_cast"
tt.sound_events.hit = "fallen_ones_spirit_mausoleum_possession_hit"

tt = E:register_t("fx_gargoyle_spawn", "fx")
tt.render.sprites[1].name = "spirit_mausoleum_lvl4_gargoyle_spawn_run"
tt.render.sprites[1].anchor = v(0.5, 0.14)
tt.render.sprites[1].offset = v(0, 2)
tt.render.sprites[1].z = Z_OBJECTS + 1

--石像鬼
tt = RT("fallen_ones_gargoyle", "soldier_militia")
E:add_comps(tt, "nav_grid")
tt.health.armor = 0.6
tt.health.dead_lifetime = 15
tt.health.hp_max = 234
tt.health_bar.offset = v(0, 34)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.unit.hit_offset = v(0, 15)
tt.unit.head_offset = v(0, 24)
tt.unit.mod_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.info.portrait = "gui4_bottom_info_image_soldiers_0024"
tt.info.random_name_count = 7
tt.info.random_name_format = "FALLEN_ONES_ZOMBIE_%i_NAME"
tt.motion.max_speed = 50
tt.regen.health = 30
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "spirit_mausoleum_lvl4_gargoyle"
tt.render.sprites[1].anchor.y = 0.14
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "spirit_mausoleum_lvl4_gargoyle_shadow"
tt.render.sprites[2].anchor.y = 0.14
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(15, 0)
tt.melee.range = 60
tt.melee.attacks[1].damage_max = 24
tt.melee.attacks[1].damage_min = 16
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(14)
tt.ui.click_rect = r(-15, -2, 30, 35)
tt.main_script.update = kr4_scripts.kr4_soldier_barrack.update



--尸兵
--[[
tt = RT("draugr", "soldier_militia")
E:add_comps(tt, "nav_path", "reinforcement", "tween")
tt.health.armor = 0
tt.health.magic_armor = 0.8
tt.health.hp_max = 150
tt.health_bar.offset = v(0, 35)
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(-9, 30)
tt.unit.mod_offset = v(0, 13)
tt.unit.marker_offset = v(0, 0)
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.info.portrait = "bottom_info_image_soldiers_0029"
tt.info.random_name_count = 7
tt.info.random_name_format = "FALLEN_ONES_ZOMBIE_%i_NAME"
tt.motion.max_speed = 24
tt.render.sprites[1].prefix = "draugr"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].sort_y_offset = -1
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "draugr_shadow"
tt.render.sprites[2].anchor.y = 0.24
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].sort_y_offset = -1
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(10, 0)
tt.melee.range = 60
tt.melee.attacks[1].damage_max = 9
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].cooldown = 1.2
tt.melee.attacks[1].hit_time = fts(11)
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
tt.tween.disabled = true
tt.nav_path.dir = -1
tt.main_script.update = kr4_scripts.soldier_wander.update
]]--


---------------------------------------------
-------------------腐朽森林-------------------
---------------------------------------------
--建造
tt = E:register_t("tower_build_rotten_forest", "tower_build")
tt.build_name = "tower_rotten_forest_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "rotten_forest_tower_lvl1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 25)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
--1级塔


--1级防御塔
tt = E:register_t("tower_rotten_forest_lvl1", "tower_KR5")
E:add_comps(tt, "auras", "attacks", "vis")
tt.tower.type = "rotten_forest"
tt.tower.kind = TOWER_KIND_ENGINEER
tt.tower.team = TEAM_DARK_ARMY
tt.tower.level = 1
tt.tower.price = 120
tt.tower.menu_offset = v(0, 19)
tt.info.i18n_key = "TOWER_ROTTEN_FOREST_LEVEL1"
tt.info.portrait = "gui4_bottom_info_image_towers_0016"
tt.info.fn = kr4_scripts.tower_rotten_forest.get_info
tt.main_script.insert = kr4_scripts.tower_rotten_forest.insert
tt.main_script.update = kr4_scripts.tower_rotten_forest.update
tt.main_script.remove = kr4_scripts.tower_rotten_forest.remove
tt.attacks.range = 186
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].cooldown = 0.4
tt.attacks.list[1].bullet = "bullet_rotten_forest_lvl1"
tt.attacks.list[1].disabled = true
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_tower_rotten_forest_spike_burst"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E:clone_c("aura_attack")
tt.auras.list[2].name = "aura_tower_rotten_forest_fog"
tt.auras.list[2].cooldown = 0
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "rotten_forest_tower_lvl1_floor"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "rotten_forest_tower_lvl1_idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "rotten_forest_tower_mist_run"
tt.render.sprites[3].offset = v(0, 30)
tt.sound_events.insert = "RottenForestTaunt"
tt.ui.click_rect = r(-37, -6, 74, 62)

tt = E:register_t("tower_rotten_forest_lvl2", "tower_rotten_forest_lvl1")
tt.tower.level = 2
tt.tower.price = 140
tt.info.i18n_key = "TOWER_ROTTEN_FOREST_LEVEL2"
tt.attacks.list[1].bullet = "bullet_rotten_forest_lvl2"
tt.render.sprites[2].name = "rotten_forest_tower_lvl2_idle"

tt = E:register_t("tower_rotten_forest_lvl3", "tower_rotten_forest_lvl1")
tt.tower.level = 3
tt.tower.price = 190
tt.info.i18n_key = "TOWER_ROTTEN_FOREST_LEVEL3"
tt.attacks.list[1].bullet = "bullet_rotten_forest_lvl3"
tt.render.sprites[2].name = "rotten_forest_tower_lvl3_idle"

tt = E:register_t("tower_rotten_forest_lvl4", "tower_rotten_forest_lvl1")
E:add_comps(tt, "powers")
tt.tower.level = 4
tt.tower.price = 220
tt.info.i18n_key = "TOWER_ROTTEN_FOREST_LEVEL4"
tt.attacks.list[1].bullet = "bullet_rotten_forest_lvl4"
tt.attacks.list[2] = E:clone_c("custom_attack")
tt.attacks.list[2].cooldown = 23
tt.attacks.list[2].cast_time = 0.6
tt.attacks.list[2].entity = "rotten_forest_tree"
tt.attacks.list[2].spawn_offset = v(25, 0)
tt.attacks.list[2].range = 186
tt.attacks.list[2].disabled = true
tt.attacks.list[2].vis_flags = F_BLOCK
tt.attacks.list[2].vis_bans = bor(F_FLYING, F_NIGHTMARE)
tt.render.sprites[1].name = "rotten_forest_tower_lvl4_floor"
tt.render.sprites[2].name = "rotten_forest_tower_lvl4_idle"
tt.render.sprites[3].name = "rotten_forest_tower_mist_lvl4_run"
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].name = "rotten_forest_tower_mist_lvl4_run"
tt.render.sprites[4].offset = v(0, 30)
tt.render.sprites[4].hidden = true
tt.powers.fog = CC("power")
tt.powers.fog.price_base = 102
tt.powers.fog.price_inc = 102
tt.powers.fog.max_level = 2
tt.powers.fog.aura = "mod_ranger_poison"
tt.powers.fog.enc_icon = 348
tt.powers.warp = CC("power")
tt.powers.warp.price_base = 136
tt.powers.warp.price_inc = 136
tt.powers.warp.max_level = 2
tt.powers.warp.aura = "aura_rotten_forest_thorn"
tt.powers.warp.enc_icon = 347
tt.powers.tree = CC("power")
tt.powers.tree.price_base = 170
tt.powers.tree.price_inc = 85
tt.powers.tree.aura = "aura_rotten_forest_thorn"
tt.powers.tree.enc_icon = 349
tt.powers.tree.max_level = 2
tt.powers.tree.hp = 260
tt.powers.tree.cooldown = 23
tt.powers.tree.cooldown_inc = -5

tt = RT("mod_rf_thorn", "modifier")

AC(tt, "render")

tt.animation_start = "thorn"
tt.animation_end = "thornFree"
tt.modifier.duration = 0
tt.modifier.duration_inc = 3
tt.modifier.type = MOD_TYPE_FREEZE
tt.modifier.vis_flags = bor(F_THORN, F_MOD)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.max_times_applied = 10000
tt.damage_min = 0
tt.damage_max = 0
tt.damage_type = DAMAGE_PHYSICAL
tt.damage_every = 1
tt.render.sprites[1].prefix = "rotten_forest_towers_root"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_prefixes = {
	"rotten_forest_towers_root",
	"rotten_forest_towers_root",
	"rotten_forest_towers_root"
}
tt.render.sprites[1].size_scales = {
	vv(1.0),
	vv(1.3),
	vv(1.8)
}
tt.render.sprites[1].anchor.y = 0.22
tt.main_script.queue = kr1_scripts.mod_thorn.queue
tt.main_script.dequeue = kr1_scripts.mod_thorn.dequeue
tt.main_script.insert = kr1_scripts.mod_thorn.insert
tt.main_script.update = kr1_scripts.mod_thorn.update
tt.main_script.remove = kr1_scripts.mod_thorn.remove

tt = RT("aura_rotten_forest_thorn", "aura")
tt.aura.mod = "mod_rf_thorn"
tt.aura.duration = -1
tt.aura.radius = 200
tt.aura.vis_flags = bor(F_THORN, F_MOD)
tt.aura.vis_bans = bor(F_FLYING, F_BOSS)
tt.aura.cooldown = 15
tt.aura.max_times = 10
tt.aura.max_count = 5
tt.aura.max_count_inc = 0
tt.aura.min_count = 2
--tt.aura.owner_animation = "shoot"
--tt.aura.owner_sid = 5
tt.aura.hit_time = fts(17)
tt.aura.hit_sound = "ThornSound"
tt.main_script.update = scripts.aura_rotten_forest_thorn.update

tt = E:register_t("ps_tower_rotten_forest_sparks_1")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "rotten_forest_tower_decal_loop"
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

tt = E:register_t("decal_rotten_forest_smoke", "aura")
E:add_comps(tt, "pos", "render")
tt.aura.duration = 1e+99
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "rotten_forest_tower_decal_floor"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "rotten_forest_tower_decal"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].loop = true
tt.render.sprites[2].z = Z_DECALS
tt.main_script.update = scripts.decal_rotten_forest_smoke.update

tt = E:register_t("decal_rotten_forest_fog", "aura")
E:add_comps(tt, "pos", "render")
tt.aura.duration = 1e+99
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "rotten_forest_tower_fog"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS


tt = E:register_t("aura_tower_rotten_forest_spike_burst", "aura")
--b = balance.towers.sparking_geode.spike_burst
tt.aura.mods = {
	"mod_tower_rotten_forest_burst_slow",
	"mod_tower_rotten_forest_burst_damage"
}
tt.aura.radius = 186 --可能需要科技
tt.aura.vis_flags = bor(F_MOD)
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.duration = 1e+99
tt.aura.cycle_time = 0.4
tt.distance_between_crystals = {
	115,
	110,
	70
}
tt.main_script.insert = scripts.aura_tower_rotten_forest_spike_burst.insert
tt.main_script.update = scripts.aura_tower_rotten_forest_spike_burst.update
tt.ps_names = {
	--"ps_tower_rotten_forest_sparks_1",
	--"ps_tower_rotten_forest_sparks_1"
}

tt = E:register_t("aura_tower_rotten_forest_fog", "aura")
--b = balance.towers.sparking_geode.spike_burst
tt.aura.mods = {
	"mod_tower_rotten_forest_fog_slow",
	"mod_tower_rotten_forest_fog_miss"
}
tt.aura.radius = 186 --可能需要科技
tt.aura.vis_flags = bor(F_MOD)
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.duration = 1e+99
tt.aura.cycle_time = 0.4
tt.distance_between_crystals = {
	115,
	110,
	70
}
tt.main_script.insert = scripts.aura_tower_rotten_forest_fog.insert
tt.main_script.update = scripts.aura_tower_rotten_forest_fog.update
tt.ps_names = {
	--"ps_tower_rotten_forest_sparks_1",
	--"ps_tower_rotten_forest_sparks_1"
}

tt = E:register_t("mod_tower_rotten_forest_fog_slow", "mod_slow")
--b = balance.towers.sparking_geode.spike_burst
tt.modifier.duration = 0.4 + fts(1)
tt.slow.factor = {0.9, 0.9, 0.9, 0.9}

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.slow.factor[this.modifier.level]

	return scripts.mod_slow.insert(this, store, script)
end

tt = E:register_t("mod_tower_rotten_forest_fog_miss", "modifier")
b = balance.towers.barrel.basic_attack.debuff

E:add_comps(tt, "render")

tt.modifier.duration = 0.4 + fts(1)
tt.modifier.vis_flags = F_MOD
tt.modifier.type = MOD_TYPE_POISON
tt.modifier.level = 1
tt.modifier.resets_same = true
tt.modifier.replaces_lower = true
tt.damage_reduction = 0.325
tt.main_script.insert = scripts.mod_bullet_tower_barrel.insert
tt.main_script.remove = scripts.mod_bullet_tower_barrel.remove
tt.main_script.update = scripts.mod_track_target.update


tt = E:register_t("mod_tower_rotten_forest_burst_slow", "mod_slow")
--b = balance.towers.sparking_geode.spike_burst
tt.modifier.duration = 0.4 + fts(1)
tt.slow.factor = {0.8, 0.8, 0.7, 0.7}

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.slow.factor[this.modifier.level]

	return scripts.mod_slow.insert(this, store, script)
end


tt = E:register_t("mod_tower_rotten_forest_burst_damage", "modifier")
--b = balance.towers.sparking_geode.spike_burst

E:add_comps(tt, "dps")

--tt.render.sprites[1].name = "sparking_geode_modifier_run"
tt.modifier.duration = 0.4
tt.modifier.vis_bans = bor(F_FLYING)
tt.modifier.allows_duplicates = true
tt.dps.damage_every = 0.4
tt.dps.damage_min = {3,4,5,7}
tt.dps.damage_max = {3,4,5,7}
tt.dps.damage_type = DAMAGE_PHYSICAL

function tt.main_script.insert(this, store, script)
	this.dps.damage_min = this.dps.damage_min[this.modifier.level]
	this.dps.damage_max = this.dps.damage_max[this.modifier.level]

	return scripts.mod_dps.insert(this, store, script)
end

tt.main_script.update = scripts.mod_dps.update

tt = E:register_t("bullet_rotten_forest_lvl1", "arrow_3")
tt.bullet.damage_min = 3
tt.bullet.damage_max = 3

tt = E:register_t("bullet_rotten_forest_lvl2", "arrow_3")
tt.bullet.damage_min = 4
tt.bullet.damage_max = 4

tt = E:register_t("bullet_rotten_forest_lvl3", "arrow_3")
tt.bullet.damage_min = 5
tt.bullet.damage_max = 5

tt = E:register_t("bullet_rotten_forest_lvl4", "arrow_3")
tt.bullet.damage_min = 7
tt.bullet.damage_max = 7

tt = E:register_t("rotten_forest_tree", "soldier_militia")
AC(tt, "reinforcement")
tt.info.i18n_key = "ROTTEN_FOREST_SPAWN"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0038"
tt.main_script.update = kr4_scripts.red_soldier_tower_ogrc_shipwreck.update
tt.health.armor = 0
tt.health.hp_max = 260
tt.regen.health = 0
tt.regen.cooldown = 1
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 24
tt.melee.attacks[1].damage_min = 16
tt.melee.range = 60
tt.render.sprites[1].prefix = "rotten_forest_towers_spawn"
tt.render.sprites[1].name = "idle"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "rotten_forest_towers_spawn_shadow"
tt.render.sprites[2].anchor.y = 0.2
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.reinforcement.duration = 5
tt.reinforcement.fade = true
tt.patrol_pos_offset = v(15, 10)
tt.patrol_min_cd = 3
tt.patrol_max_cd = 6

--电云


tt = E:register_t("hero_dianyun", "hero5")
b = balance.heroes.hero_dianyun
E:add_comps(tt, "ranged", "timed_attacks", "auras")

tt.hero.level_stats.hp_max = {
	385,
	406,
	428,
	449,
	470,
	492,
	514,
	535,
	557,
	578
}
tt.hero.level_stats.regen_health = {
	22,
	25,
	28,
	31,
	34,
	37,
	40,
	43,
	46,
	49
}
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.ranged_damage_min = {
	2,
	4,
	6,
	9,
	11,
	13,
	16,
	18,
	19,
	21
}
tt.hero.level_stats.ranged_damage_max = {
	6,
	11,
	16,
	20,
	25,
	31,
	35,
	40,
	44,
	49
}
-- ricochet
tt.hero.skills.ricochet = E:clone_c("hero_skill")
tt.hero.skills.ricochet.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.ricochet.hr_order = 1
tt.hero.skills.ricochet.hr_icon = 409
tt.hero.skills.ricochet.hr_available = true
tt.hero.skills.ricochet.damage_min = b.ricochet.damage_min
tt.hero.skills.ricochet.damage_max = b.ricochet.damage_max
tt.hero.skills.ricochet.bounce = b.ricochet.bounce
tt.hero.skills.ricochet.cooldown = {
	18,
	18,
	18
}
tt.hero.skills.ricochet.xp_gain = {
	60,
	120,
	180
}
tt.hero.skills.ricochet.key = "RICOCHET"
-- lord storm
tt.hero.skills.lord_storm = E:clone_c("hero_skill")
tt.hero.skills.lord_storm.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.lord_storm.hr_order = 2
tt.hero.skills.lord_storm.hr_icon = 408
tt.hero.skills.lord_storm.hr_available = true
tt.hero.skills.lord_storm.max_targets = {
	2,
	3,
	4
}
tt.hero.skills.lord_storm.key = "LORD_STORM"
-- divine rain
tt.hero.skills.divine_rain = E:clone_c("hero_skill")
tt.hero.skills.divine_rain.hr_cost = {
	2,
	1,
	1
}
tt.hero.skills.divine_rain.hr_order = 3
tt.hero.skills.divine_rain.hr_icon = 407
tt.hero.skills.divine_rain.hr_available = true
tt.hero.skills.divine_rain.xp_gain = {
	104,
	208,
	312
}
tt.hero.skills.divine_rain.cooldown = {
	15,
	15,
	15
}
tt.hero.skills.divine_rain.duration = {
	5,
	5,
	5
}
tt.hero.skills.divine_rain.healing_points_tick = b.divine_rain.healing_points_tick
tt.hero.skills.divine_rain.key = "DIVINE_RAIN"
-- supreme wave
tt.hero.skills.supreme_wave = E:clone_c("hero_skill")
tt.hero.skills.supreme_wave.hr_cost = {
	3,
	2,
	2
}
tt.hero.skills.supreme_wave.hr_order = 4
tt.hero.skills.supreme_wave.hr_icon = 406
tt.hero.skills.supreme_wave.hr_available = true
tt.hero.skills.supreme_wave.cooldown = {
	21,
	21,
	21
}
tt.hero.skills.supreme_wave.stun = {
	2,
	3,
	4
}
tt.hero.skills.supreme_wave.xp_gain = {
	70,
	140,
	210
}
tt.hero.skills.supreme_wave.key = "SUPREME_WAVE"

tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.controller_name = "hero_dianyun_ultimate"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_icon = 410
tt.hero.skills.ultimate.hr_cost = {
	6,
	5,
	5
}
tt.hero.skills.ultimate.hr_available = true
tt.hero.skills.ultimate.key = "ULTIMATE"
tt.hero.skills.ultimate.bullets_to_death = {
	[0] = 3,
	5,
	10,
	15
}
tt.hero.skills.ultimate.cooldown = b.ultimate.cooldown

tt.hero.team = TEAM_DARK_ARMY
tt.health.dead_lifetime = 22.5
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 130)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
-- tt.health_bar.z = Z_FLYING_HEROES
tt.hero.fn_level_up = kr4_scripts.hero_dianyun.level_up
tt.hero.tombstone_show_time = nil
tt.hero.tombstone_decal = nil
tt.hero.use_custom_spawn_point = true
tt.idle_flip.chance = 0
tt.info.damage_icon = "magic"
tt.info.fn = kr4_scripts.hero_dianyun.get_info
tt.info.hero_portrait = "kra_hero_portraits_0413"
tt.info.i18n_key = "HERO_DIANYUN"
tt.info.portrait = "gui4_bottom_info_image_heroes_0016"
tt.info.ultimate_icon = "0413"
tt.info.stat_hp = 8
tt.info.stat_armor = 0
tt.info.stat_damage = 5
tt.info.stat_cooldown = 4
tt.main_script.insert = kr4_scripts.hero_dianyun.insert
tt.main_script.update = kr4_scripts.hero_dianyun.update
tt.motion.max_speed = 42
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.all_except_flying_nowalk = bor(TERRAIN_NONE, TERRAIN_LAND, TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK, TERRAIN_SHALLOW, TERRAIN_FAERIE, TERRAIN_ICE)
tt.nav_grid.valid_terrains = tt.all_except_flying_nowalk
tt.nav_grid.valid_terrains_dest = tt.all_except_flying_nowalk
tt.drag_line_origin_offset = v(0, 80)
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = 0.04
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].exo = true
tt.render.sprites[1].prefix = "hero_dianyun"
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_dianyun_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
-- cloud 1
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[3].offset = v(15, 50)
tt.render.sprites[3].alpha = 204
tt.render.sprites[3].z = Z_FLYING_HEROES + 1
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "hero_storm_dragon_cloud_l2"
tt.render.sprites[4].offset = v(15, 50)
tt.render.sprites[4].alpha = 204
tt.render.sprites[4].z = Z_FLYING_HEROES + 1
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "hero_storm_dragon_cloud_l3"
tt.render.sprites[5].offset = v(15, 50)
tt.render.sprites[5].alpha = 204
tt.render.sprites[5].z = Z_FLYING_HEROES + 1
-- cloud 2
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[6].scale = v(0.75, 0.75)
tt.render.sprites[6].offset = v(-20, 60)
tt.render.sprites[6].alpha = 204
tt.render.sprites[6].z = Z_FLYING_HEROES
-- cloud 3
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[7].scale = v(0.666, 0.666)
tt.render.sprites[7].offset = v(5, 70)
tt.render.sprites[7].alpha = 204
tt.render.sprites[7].z = Z_FLYING_HEROES + 1
-- cloud 4
tt.render.sprites[8] = E:clone_c("sprite")
tt.render.sprites[8].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[8].scale = v(0.6, 0.6)
tt.render.sprites[8].offset = v(-5, 83)
tt.render.sprites[8].alpha = 204
tt.render.sprites[8].z = Z_FLYING_HEROES
-- cloud 5
tt.render.sprites[9] = E:clone_c("sprite")
tt.render.sprites[9].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[9].scale = v(0.666, 0.666)
tt.render.sprites[9].offset = v(50, 60)
tt.render.sprites[9].alpha = 204
tt.render.sprites[9].z = Z_FLYING_HEROES - 2
-- cloud 6
tt.render.sprites[10] = E:clone_c("sprite")
tt.render.sprites[10].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[10].scale = v(0.6, 0.6)
tt.render.sprites[10].offset = v(57, 70)
tt.render.sprites[10].alpha = 204
tt.render.sprites[10].z = Z_FLYING_HEROES - 1
-- cloud 7
tt.render.sprites[11] = E:clone_c("sprite")
tt.render.sprites[11].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[11].scale = v(0.75, 0.75)
tt.render.sprites[11].offset = v(40, 80)
tt.render.sprites[11].alpha = 204
tt.render.sprites[11].z = Z_FLYING_HEROES - 2
-- cloud 8
tt.render.sprites[12] = E:clone_c("sprite")
tt.render.sprites[12].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[12].scale = v(0.6, 0.6)
tt.render.sprites[12].offset = v(-40, 75)
tt.render.sprites[12].alpha = 204
tt.render.sprites[12].z = Z_FLYING_HEROES
-- cloud 9
tt.render.sprites[13] = E:clone_c("sprite")
tt.render.sprites[13].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[13].scale = v(0.6, 0.6)
tt.render.sprites[13].offset = v(-40, 88)
tt.render.sprites[13].alpha = 204
tt.render.sprites[13].z = Z_FLYING_HEROES
-- cloud 10
tt.render.sprites[14] = E:clone_c("sprite")
tt.render.sprites[14].prefix = "hero_storm_dragon_cloud_l1"
tt.render.sprites[14].scale = v(0.6, 0.6)
tt.render.sprites[14].offset = v(-55, 88)
tt.render.sprites[14].alpha = 204
tt.render.sprites[14].z = Z_FLYING_HEROES + 1

tt.sound_events.change_rally_point = "HeroDianyunTaunt"
tt.sound_events.death = "HeroDianyunTauntDeath"
tt.sound_events.respawn = "HeroLevelUp"
tt.sound_events.hero_room_select = "HeroDianyunTauntSelect"
tt.ui.click_rect = r(-60, 30, 120, 90)
tt.unit.hit_offset = v(0, 85)
tt.unit.hide_after_death = nil
tt.unit.mod_offset = v(0, 90)
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
-- lord storm
tt.ranged.attacks[1] = E:clone_c("spawn_attack")
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].entity = "controller_lord_storm"
tt.ranged.attacks[1].bullet = "hero_dianyun_lightning"
tt.ranged.attacks[1].min_range = b.basic_attack.min_range
tt.ranged.attacks[1].max_range = b.basic_attack.max_range
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.ranged.attacks[1].basic_attack = true
tt.ranged.attacks[1].xp_gain_factor = 1.5
-- ricochet
tt.ranged.attacks[2] = E:clone_c("bullet_attack")
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].cooldown = 18
tt.ranged.attacks[2].min_cooldown = 1
tt.ranged.attacks[2].min_range = b.ricochet.min_range
tt.ranged.attacks[2].max_range = b.ricochet.max_range
tt.ranged.attacks[2].bullet = "hero_dianyun_lightning_ricochet_cloud"
tt.ranged.attacks[2].spawn_pos_offset = v(0, 81)
tt.ranged.attacks[2].start_fx = "fx_hero_dianyun_lightning_ricochet"
tt.ranged.attacks[2].start_offset = v(0, 90)
tt.ranged.attacks[2].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[2].vis_flags = bor(F_RANGED)
tt.ranged.attacks[2].min_targets = 2
tt.ranged.attacks[2].crowds_range = 90
tt.ranged.attacks[2].xp_from_skill = "ricochet"
-- divine rain
tt.timed_attacks.list[1] = E:clone_c("aura_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].aura = "aura_hero_dianyun_divine_rain"
tt.timed_attacks.list[1].min_targets = 2
tt.timed_attacks.list[1].crowds_range = 50
tt.timed_attacks.list[1].health_trigger_factor = 0.75
tt.timed_attacks.list[1].min_range = b.divine_rain.min_range
tt.timed_attacks.list[1].max_range = b.divine_rain.max_range
tt.timed_attacks.list[1].cast_time = fts(20)
tt.timed_attacks.list[1].animation = "healingRain"
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].vis_bans = bor(F_ENEMY)
tt.timed_attacks.list[1].xp_from_skill = "divine_rain"
-- supreme wave
tt.timed_attacks.list[2] = E:clone_c("aura_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].cast_time = fts(24)
tt.timed_attacks.list[2].entity = "aura_hero_dianyun_supreme_wave"
tt.timed_attacks.list[2].floor_decal = "floor_decal_hero_dianyun_supreme_wave"
tt.timed_attacks.list[2].controller = "controller_decal_hero_dianyun_supreme_wave_spawner"
tt.timed_attacks.list[2].animation = "supremeWave"
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_NIGHTMARE, F_CLIFF, F_BOSS)
tt.timed_attacks.list[2].min_range = b.supreme_wave.min_range
tt.timed_attacks.list[2].max_range = b.supreme_wave.max_range
tt.timed_attacks.list[2].min_targets = 3
tt.timed_attacks.list[2].crowds_range = 150
tt.timed_attacks.list[2].start_nodes_offset = 3
tt.timed_attacks.list[2].distance_to_start_node = 20
tt.timed_attacks.list[2].max_objects = 5
tt.timed_attacks.list[2].nodes_between_objects = 6
tt.timed_attacks.list[2].delay_between_objects = fts(3)
tt.timed_attacks.list[2].xp_from_skill = "supreme_wave"
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_dianyun_passive"

tt = E:register_t("hero_dianyun_lightning", "bullet")
tt.main_script.update = kr4_scripts.hero_dianyun_lightning.update
tt.render.sprites[1].name = "hero_storm_dragon_lightning"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].r = -math.pi / 2
tt.bullet.hit_time = fts(2)
tt.bullet.hit_fx = "fx_hero_dianyun_lightning_hit"
tt.bullet.mod = "mod_hero_dianyun_lightning"
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.use_unit_damage_factor = true
tt.sound_events.insert = "WarmongerMageAttack"

tt = E:register_t("fx_hero_dianyun_lightning_hit", "fx")
tt.render.sprites[1].name = "hero_storm_dragon_lightning_hit"
tt.render.sprites[1].anchor = v(0.5, 0.5)

tt = E:register_t("mod_common_stun", "mod_stun")
tt.modifier.vis_flags = bor(F_STUN, F_MOD)
tt.modifier.vis_bans = bor(F_BOSS)

tt = E:register_t("mod_hero_dianyun_lightning", "mod_common_stun")
E:add_comps(tt, "tween")
tt.modifier.duration = fts(20)
tt.render.sprites[1].prefix = "hero_storm_dragon_lightning_modifier"
tt.render.sprites[1].anchor = v(0.5, 0.625)
tt.render.sprites[1].size_names = nil
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		tt.modifier.duration - fts(8),
		255
	},
	{
		tt.modifier.duration,
		0
	}
}

tt = E:register_t("controller_lord_storm")
E:add_comps(tt, "pos", "main_script", "sound_events")
tt.bullet = "hero_dianyun_lightning"
tt.spawn_pos_offset = v(0, 81)
tt.delay_between_rays = 0.5
tt.max_targets = 1
tt.main_script.update = kr4_scripts.controller_lord_storm.update

tt = E:register_t("hero_dianyun_lightning_ricochet_cloud", "bullet")
tt.main_script.update = kr4_scripts.hero_dianyun_lightning_ricochet_cloud.update
tt.render.sprites[1].name = "hero_storm_dragon_lightning_ricochet_cloud"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].r = -math.pi / 2
tt.bullet.hit_time = fts(2)
tt.bullet.hit_fx = "fx_hero_dianyun_lightning_ricochet_hit"
tt.bullet.mod = "mod_hero_dianyun_storm_ray"
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bounce_bullet = "hero_dianyun_lightning_ricochet"
tt.bounce_range = 90
tt.bounce_vis_flags = bor(F_RANGED)
tt.bounce_vis_bans = bor(F_NIGHTMARE)
tt.bounce_delay = fts(2)
tt.sound_events.insert = "WarmongerMageAttack"

tt = E:register_t("fx_hero_dianyun_lightning_ricochet_hit", "fx")
tt.render.sprites[1].name = "hero_storm_dragon_lightning_ricochet_hit"
tt.render.sprites[1].anchor = v(0.5, 0.5)

tt = E:register_t("mod_hero_dianyun_storm_ray", "mod_hero_dianyun_lightning")
tt.render.sprites[1].prefix = "hero_storm_ray_modifier"

tt = E:register_t("hero_dianyun_lightning_ricochet", "bullet")
tt.main_script.update = kr4_scripts.hero_dianyun_lightning_ricochet.update
tt.render.sprites[1].name = "hero_storm_dragon_lightning_ricochet"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.image_width = 69
tt.bullet.hit_time = fts(2)
tt.bullet.hit_fx = "fx_hero_dianyun_lightning_ricochet_hit"
tt.bullet.mod = "mod_hero_dianyun_storm_ray"
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.sound_events.insert = "WarmongerMageAttack"

tt = E:register_t("fx_hero_dianyun_lightning_ricochet", "fx")
for i = 1, 3, 1 do
	if i > 1 then
		tt.render.sprites[i] = E:clone_c("sprite")
	end
	tt.render.sprites[i].name = "hero_storm_dragon_lightning_ricochet_fx_l" .. tostring(i)
	tt.render.sprites[i].anchor = v(0.5, 0.5)
	tt.render.sprites[i].z = Z_FLYING_HEROES + 1
end

tt = E:register_t("aura_hero_dianyun_divine_rain", "aura")
E:add_comps(tt, "render", "tween")
tt.render.sprites[1].prefix = "hero_dianyun_health_rain"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor = v(0.5, 0)
tt.render.sprites[1].exo = true
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.aura.duration = 5
tt.aura.mods = {
	"mod_kr4_heal"
}
tt.aura.cycle_time = 0.5
tt.aura.radius = b.divine_rain.radius
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_MOD, F_AREA)
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
		tt.aura.duration - 0.3,
		255
	},
	{
		tt.aura.duration,
		0
	}
}
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update

tt = E:register_t("mod_kr4_heal", "modifier")
E:add_comps(tt, "hps", "render")
tt.modifier.duration = 0.6
tt.hps.heal_min = nil
tt.hps.heal_max = nil
tt.hps.heal_every = 0.5
tt.render.sprites[1].name = "kr4_heal_loop"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].loop = true
tt.render.sprites[1].draw_order = DO_MOD_FX
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update

tt = E:register_t("aura_hero_dianyun_supreme_wave", "aura")
E:add_comps(tt, "render")
tt.render.sprites[1].name = "hero_storm_dragon_supreme_wave"
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].z = Z_DECALS + 1
tt.aura.duration = fts(70)
tt.aura.mods = {
	"mod_kr4_stun",
	"mod_supreme_wave_damage"
}
tt.aura.cycle_time = 10
tt.aura.radius = 50
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.vis_flags = bor(F_MOD, F_AREA)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update

tt = E:register_t("mod_kr4_stun", "mod_common_stun")
tt.render.sprites[1].prefix = "kr4_stun"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].size_names = nil
tt.modifier.use_mod_offset = nil
tt.modifier.health_bar_offset = v(0, -2)

tt = E:register_t("mod_supreme_wave_damage", "mod_damage")
b = balance.heroes.hero_dianyun
tt.damage_max = b.supreme_wave.damage
tt.damage_min = b.supreme_wave.damage
tt.damage_type = b.supreme_wave.damage_type

tt = E:register_t("floor_decal_hero_dianyun_supreme_wave", "decal_tween")
tt.render.sprites[1].name = "hero_storm_dragon_supreme_wave_decal"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].animated = false
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(14),
		0
	},
	{
		fts(14),
		255
	},
	{
		fts(49),
		0
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0, 0)
	},
	{
		fts(14),
		v(0, 0)
	},
	{
		fts(14),
		v(0.7, 0.7)
	},
	{
		fts(49),
		v(1, 1)
	}
}
tt.tween.props[2].sprite_id = 1

tt = E:register_t("controller_decal_hero_dianyun_supreme_wave_spawner")
E:add_comps(tt, "main_script")
tt.main_script.update = kr4_scripts.controller_decal_hero_dianyun_supreme_wave_spawner.update

tt = E:register_t("aura_dianyun_passive", "aura")
tt.aura.mod = "mod_dianyun_passive"
tt.aura.cycle_time = fts(3)
tt.aura.duration = -1
tt.aura.radius = 200
tt.aura.track_source = true
tt.aura.track_dead = true
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update

tt = E:register_t("mod_dianyun_passive", "modifier")
tt.modifier.duration = fts(4)
tt.modifier.vis_flags = F_MOD
tt.main_script.insert = kr4_scripts.mod_dianyun_passive.insert
tt.main_script.remove = kr4_scripts.mod_dianyun_passive.remove
tt.main_script.update = scripts.mod_track_target.update
tt.fx = "fx_hero_dianyun_lantern"
tt.gold_reward = b.passive.gold_reward

tt = E:register_t("fx_hero_dianyun_lantern", "fx")
tt.render.sprites[1].name = "hero_storm_dragon_lantern"
tt.render.sprites[1].anchor = v(0.5, 0.111)
tt.render.sprites[1].draw_order = DO_MOD_FX

tt = E:register_t("hero_dianyun_ultimate")
E:add_comps(tt, "pos", "main_script", "sound_events")
tt.can_fire_fn = kr4_scripts.hero_dianyun_ultimate.can_fire_fn
tt.main_script.update = kr4_scripts.hero_dianyun_ultimate.update
tt.cooldown = 45
tt.entity = "hero_dianyun_electric_son"
tt.sound_events.insert = "HeroDianyunSon"

tt = E:register_t("hero_dianyun_electric_son", "decal_scripted")
E:add_comps(tt, "ranged", "idle_flip")
tt.main_script.update = kr4_scripts.hero_dianyun_electric_son.update
tt.duration = b.ultimate.duration
tt.render.sprites[1].prefix = "hero_storm_dragon_electric_son"
tt.render.sprites[1].anchor = v(0.5, 0.16)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "hero_storm_dragon_electric_son_shadow"
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].anchor = v(0.5, 0.16)
tt.render.sprites[2].offset = v(0, 0)
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].max_range = b.ultimate.max_range
tt.ranged.attacks[1].min_range = b.ultimate.min_range
tt.ranged.attacks[1].bullet = "bolt_hero_dianyun_electric_son"
tt.ranged.attacks[1].shoot_time = 0.4
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[1].basic_attack = true
tt.ranged.attacks[1].bullet_start_offset = v(10, 40)


tt = E:register_t("bolt_hero_dianyun_electric_son", "bolt")
E:add_comps(tt, "force_motion")
tt.bullet.damage_type = b.ultimate.damage_type
tt.bullet.damage_min = 120
tt.bullet.damage_max = 180
tt.bullet.hit_fx = "fx_hero_dianyun_lightning_hit"
--tt.bullet.mod = "mod_stun_electric_son"
tt.bullet.max_speed = 600
tt.bullet.align_with_trajectory = true
tt.bullet.min_speed = 30
tt.bullet.pop_chance = 0
tt.bullet.shot_index = 1
tt.initial_impulse = 10
tt.initial_impulse_duration = 10
tt.initial_impulse_angle = math.pi / 4
tt.force_motion.a_step = 5
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 600
tt.render.sprites[1].name = "hero_storm_dragon_electric_son_bolt"
tt.render.sprites[1].prefix = nil
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
function tt.main_script.insert(this, store, script)
	return true
end
tt.main_script.update = kr4_scripts.custom_bolt.update
tt.sound_events.insert = "BoltReleaseSound"

tt = E:register_t("mod_stun_electric_son", "mod_common_stun")
tt.modifier.duration = b.ultimate.stun


----------------------------------------------
------------------女巫姐妹花-------------------
----------------------------------------------
tt = E:register_t("tower_build_wicked_sisters", "tower_build")
tt.build_name = "tower_wicked_sisters_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "wicked_sisters_0001"
tt.render.sprites[2].offset = v(0, 24)
tt.render.sprites[3].offset.y = 65
tt.render.sprites[4].offset.y = 65

tt = E:register_t("tower_wicked_sisters_lvl1", "tower_KR5")

E:add_comps(tt, "barrack")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_WICKED_SISTERS_LEVEL1"
tt.tower.type = "wicked_sisters"
tt.tower.kind = TOWER_KIND_MAGE
tt.tower.level = 1
tt.tower.price = 120
tt.info.fn = kr4_scripts.tower_wicked_sisters.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0017"
tt.info.enc_icon = 213
tt.main_script.insert = kr4_scripts.tower_wicked_sisters.insert
tt.main_script.update = kr4_scripts.tower_wicked_sisters.update
tt.main_script.remove = kr4_scripts.tower_barrack.remove
tt.barrack.soldier_type = "soldier_wicked_sisters_lvl1"
tt.barrack.rally_range = 165
tt.barrack.rally_terrains = bor(TERRAIN_ICE, TERRAIN_CLIFF, TERRAIN_WATER, TERRAIN_LAND)
tt.barrack.range_upgradable = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "wicked_sisters_0002"
tt.render.sprites[2].offset = v(0, 24)
--锅炉火
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "wicked_sisters_cauldron_fire"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].offset = v(-6, 13)
--锅
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "wicked_sisters_cauldron"
tt.render.sprites[4].name = "Green"
tt.render.sprites[4].offset = v(-6, 25)
--法台女巫
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "wicked_sisters_witch"
tt.render.sprites[5].name = "stir"
tt.render.sprites[5].offset = v(6, 27)
--烟雾
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "wicked_sisters_cauldron_smoke"
tt.render.sprites[6].name = "green"
tt.render.sprites[6].offset = v(-6, 35)
tt.sound_events.insert = "WickedSistersTaunt"
tt.sound_events.change_rally_point = "WickedSistersTauntChange"
tt.ui.click_rect = r(-40, -10, 80, 50)

tt = E:register_t("tower_wicked_sisters_lvl2", "tower_wicked_sisters_lvl1")
tt.info.i18n_key = "TOWER_WICKED_SISTERS_LEVEL2"
tt.tower.level = 2
tt.tower.price = 160
tt.barrack.soldier_type = "soldier_wicked_sisters_lvl2"
tt.render.sprites[2].name = "wicked_sisters_0003"
tt.render.sprites[2].offset = v(0, 25)
local offset = 9
local offsex = 5
tt.render.sprites[3].offset = v(-6+offsex, 13+offset)
tt.render.sprites[4].offset = v(-6+offsex, 25+offset)
tt.render.sprites[5].offset = v(6+offsex, 27+offset)
tt.render.sprites[6].offset = v(-6+offsex, 35+offset)


tt = E:register_t("tower_wicked_sisters_lvl3", "tower_wicked_sisters_lvl2")
tt.info.i18n_key = "TOWER_WICKED_SISTERS_LEVEL3"
tt.tower.level = 3
tt.tower.price = 200
tt.barrack.soldier_type = "soldier_wicked_sisters_lvl3"
tt.render.sprites[2].name = "wicked_sisters_0004"
tt.render.sprites[2].offset = v(0, 25)
local offset = 16
local offsex = 2
tt.render.sprites[3].offset = v(-6+offsex, 13+offset)
tt.render.sprites[4].offset = v(-6+offsex, 25+offset)
tt.render.sprites[5].offset = v(6+offsex, 27+offset)
tt.render.sprites[6].offset = v(-6+offsex, 35+offset)

tt = E:register_t("tower_wicked_sisters_lvl4", "tower_wicked_sisters_lvl3")
E:add_comps(tt, "powers", "attacks")
tt.info.i18n_key = "TOWER_WICKED_SISTERS_LEVEL4"
tt.tower.level = 4
tt.tower.price = 250
tt.barrack.soldier_type = "soldier_wicked_sisters_lvl4"
tt.render.sprites[2].name = "wicked_sisters_0005"
tt.render.sprites[2].offset = v(0, 25)
local offset = 36
local offsex = 4
tt.render.sprites[3].offset = v(-6+offsex, 13+offset)
tt.render.sprites[4].offset = v(-6+offsex, 25+offset)
tt.render.sprites[5].offset = v(6+offsex, 27+offset)
tt.render.sprites[6].offset = v(-6+offsex, 35+offset)
--烟囱
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].prefix = "wicked_sisters_lvl4_chimney"
tt.render.sprites[7].name = "loop"
tt.render.sprites[7].offset = v(41, 31)
--小孩 锅33/76对应-2/61  -35/-15
tt.render.sprites[8] = E:clone_c("sprite")
tt.render.sprites[8].prefix = "wicked_sisters_lvl4_kid"
tt.render.sprites[8].name = "run"
tt.render.sprites[8].offset = v(19, 15)
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "totem_silence_wicked_sisters"
tt.attacks.list[1].cooldown = 15
tt.attacks.list[1].max_range = {[0]=137.5,[1]=192.5,[2]=247.5}
tt.attacks.list[1].vis_bans = bor(F_CLIFF, F_BOSS)
tt.powers.silent = E:clone_c("power")
tt.powers.silent.price_base = 153--170
tt.powers.silent.max_level = 1
tt.powers.silent.enc_icon = 344
tt.powers.silent.cooldown = 15
tt.powers.frog = E:clone_c("power")
tt.powers.frog.price_base = 195--230
tt.powers.frog.price_inc = 153--180
tt.powers.frog.enc_icon = 345
tt.powers.frog.cooldown = {22,18}
tt.powers.frog.max_level = 2
tt.powers.range = E:clone_c("power")
tt.powers.range.price_base = 85--100
tt.powers.range.price_inc = 85
tt.powers.range.range = {187.5,247.5}
tt.powers.range.max_level = 2
tt.powers.range.enc_icon = 346

tt = E:register_t("soldier_wicked_sisters_lvl1", "soldier")

E:add_comps(tt, "melee", "attacks", "powers", "nav_grid")
tt.health.ignore_damage = true
tt.ui.can_select = false
tt.ui.click_rect = r(-15, 50, 30, 30)
tt.melee.attacks = {}
tt.health_bar = nil
tt.regen = nil
tt.drag_line_origin_offset = v(0, 60)

tt.powers.range = E:clone_c("power")
tt.powers.frog = E:clone_c("power")
tt.powers.frog.cooldown = { 22, 18 }
tt.powers.silent = E:clone_c("power")
tt.powers.silent.cooldown = 15
tt.idle_flip.cooldown = 5
tt.idle_flip.last_dir = fts(1)
--tt.idle_flip.walk_dist = 27
tt.main_script.insert = scripts.soldier_wicked_sisters.insert
tt.main_script.remove = scripts.soldier_wicked_sisters.remove
tt.main_script.update = scripts.soldier_wicked_sisters.update
tt.vis.bans = F_RANGED
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "wicked_witch"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].offset = v(0, 35)
tt.render.sprites[1].anchor.y = 0.11
tt.render.sprites[1].hidden = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "wicked_witch_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.motion.max_speed = 75
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = { "proy_pink_lvl1", "proy_green_lvl1" }
tt.attacks.list[1].vis_bans = 0
tt.attacks.list[1].animations = {
    "shoot",
	"shootGreen"
}
tt.attacks.list[1].hit_times = {
	fts(21),
	fts(21)
}
tt.attacks.list[1].max_range = 150
tt.attacks.list[1].min_range = 0
tt.attacks.list[1].start_offsets = {
	v(0, 70),
	v(0, 70)
}
tt.attacks.list[1].cooldown = 2.5

tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].bullet = "ray_wicked_sisters_polymorph"
tt.attacks.list[2].animations = "shootPower"
tt.attacks.list[2].cooldown = 22
tt.attacks.list[2].max_range = 150
tt.attacks.list[2].min_range = 0
tt.attacks.list[2].disabled = true
tt.attacks.list[2].start_offset = v(-5, 100)
tt.attacks.list[2].hit_times = fts(29)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED, F_POLYMORPH)
--tt.attacks.list[2].launch_vector = v(math.random(80, 240), math.random(15, 60))
--[[
tt.attacks.list[3] = E:clone_c("bullet_attack")
tt.attacks.list[3].bullet = "oil_mecha"
tt.attacks.list[3].power_name = "oil"
tt.attacks.list[3].vis_bans = F_FLYING
tt.attacks.list[3].animation = "oilposture"
tt.attacks.list[3].cooldown = 10
tt.attacks.list[3].hit_time = fts(17)
tt.attacks.list[3].start_offset = v(-24, 0)
tt.attacks.list[3].sprite_ids = {
	1,
	2
}
tt.attacks.list[3].max_range = 57.6
]]--

tt = E:register_t("soldier_wicked_sisters_lvl2","soldier_wicked_sisters_lvl1")
tt.attacks.list[1].bullet = {"proy_pink_lvl2","proy_green_lvl2"}
tt.render.sprites[1].hidden = true

tt = E:register_t("soldier_wicked_sisters_lvl3","soldier_wicked_sisters_lvl1")
tt.attacks.list[1].bullet = {"proy_pink_lvl3","proy_green_lvl3"}
tt.render.sprites[1].hidden = true

tt = E:register_t("soldier_wicked_sisters_lvl4","soldier_wicked_sisters_lvl1")
tt.attacks.list[1].bullet = {"proy_pink_lvl4","proy_green_lvl4"}
tt.render.sprites[1].hidden = true

local mod_silence_totem = E:register_t("mod_silence_totem_wicked_sisters", "modifier")

E:add_comps(mod_silence_totem, "render")

mod_silence_totem.modifier.duration = 1
mod_silence_totem.modifier.bans = {
	"mod_shaman_armor",
	"mod_shaman_magic_armor",
	"mod_shaman_priest_heal",
	"mod_xerxes_invisibility",

	"mod_twilight_evoker_heal",
	"mod_twilight_heretic_consume",
	"mod_gnoll_boss",
	"mod_shadow_champion",
}
mod_silence_totem.modifier.remove_banned = true
mod_silence_totem.main_script.insert = scripts.mod_silence.insert
mod_silence_totem.main_script.remove = scripts.mod_silence.remove
mod_silence_totem.main_script.update = scripts.mod_track_target.update
mod_silence_totem.render.sprites[1].prefix = "wicked_sisters_lvl4_totem_modifier"
mod_silence_totem.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
mod_silence_totem.render.sprites[1].name = "run"
mod_silence_totem.render.sprites[1].loop = true
mod_silence_totem.render.sprites[1].draw_order = 2

local totem_silence = E:register_t("totem_silence_wicked_sisters", "aura")

E:add_comps(totem_silence, "render", "tween")

totem_silence.aura.mod = "mod_silence_totem_wicked_sisters"
totem_silence.aura.cycle_time = 0.3
totem_silence.aura.duration = 10
totem_silence.aura.duration_inc = 0
totem_silence.aura.radius = 100
totem_silence.aura.vis_bans = F_BOSS
totem_silence.aura.vis_flags = F_MOD
totem_silence.render.sprites[1].name = "TotemTower_GroundEffect-Violet_0002"
totem_silence.render.sprites[1].animated = false
totem_silence.render.sprites[1].scale = v(0.64, 0.64)
totem_silence.render.sprites[1].hidden = true
totem_silence.render.sprites[1].alpha = 50
totem_silence.render.sprites[1].z = Z_DECALS
totem_silence.render.sprites[2] = E:clone_c("sprite")
totem_silence.render.sprites[2].name = "TotemTower_GroundEffect-Violet_0001"
totem_silence.render.sprites[2].animated = false
totem_silence.render.sprites[2].hidden = true
totem_silence.render.sprites[2].z = Z_DECALS
totem_silence.render.sprites[3] = E:clone_c("sprite")
totem_silence.render.sprites[3].prefix = "wicked_sisters_lvl4_totem"
totem_silence.render.sprites[3].name = "start"
totem_silence.render.sprites[3].loop = false
totem_silence.render.sprites[3].anchor = v(0.5, 0.11)
totem_silence.main_script.update = scripts.aura_totem_wicked_sisters.update
totem_silence.sound_events.insert = "TotemSpirits"
totem_silence.tween.remove = false
totem_silence.tween.props[1].name = "scale"
totem_silence.tween.props[1].keys = {
	{
		0,
		v(0.64, 0.64)
	},
	{
		fts(15),
		v(1, 1)
	},
	{
		fts(30),
		v(1.6, 1.6)
	}
}
totem_silence.tween.props[1].loop = true
totem_silence.tween.props[2] = E:clone_c("tween_prop")
totem_silence.tween.props[2].keys = {
	{
		0,
		50
	},
	{
		fts(10),
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
totem_silence.tween.props[2].loop = true

tt = E:register_t("fx_wick_splat", "fx")
tt.render.sprites[1].name = "wicked_sisters_proyectile_hit_run"

tt = E:register_t("fx_wick_pink_splat", "fx")
tt.render.sprites[1].name = "wicked_sisters_proyectile_hit_violet_run"

tt = E:register_t("ps_bullet_tower_wicked_sisters_basic_trail")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "wicked_sisters_proyectile_particle_run"
tt.particle_system.animated = true
tt.particle_system.animation_fps = 50
tt.particle_system.loop = false
tt.particle_system.alphas = { 255, 0 }
tt.particle_system.particle_lifetime = {
	fts(12),
	fts(12)
}
tt.particle_system.track_rotation = true
tt.particle_system.scales_x = {
    1,
    1.25
}
tt.particle_system.scales_y = {
    1,
    1.25
}
tt.particle_system.emission_rate = 30

tt = E:register_t("ps_bullet_tower_wicked_sisters_violet_trail","ps_bullet_tower_wicked_sisters_basic_trail")
tt.particle_system.animated = false
tt.particle_system.name = "wicked_sisters_proy_pink_particle"
tt.particle_system.particle_lifetime = {
    fts(8),
    fts(8)
}

local fx_blood_splat = E:register_t("fx_blood_splat_wicked_sisters", "fx")

E:add_comps(fx_blood_splat, "sound_events")

fx_blood_splat.render.sprites[1].name = "wicked_sisters_proyectile_particle_run"
fx_blood_splat.render.sprites[1].anchor.x = 0.42857142857142855
fx_blood_splat.use_blood_color = false
fx_blood_splat.sound_events.insert = "BoltSorcererSound"

local fx_blood_splat = E:register_t("fx_blood_splat_wicked_sisters_violet", "fx")

E:add_comps(fx_blood_splat, "sound_events")

fx_blood_splat.render.sprites[1].name = "wicked_sisters_proyectile_particle_run"
fx_blood_splat.render.sprites[1].hidden = true
fx_blood_splat.render.sprites[1].anchor.x = 0.42857142857142855
fx_blood_splat.use_blood_color = false
fx_blood_splat.sound_events.insert = "BoltSorcererSound"

local arrow = E:register_t("proy_green_lvl1", "arrow")

arrow.bullet.hit_distance = 32
arrow.bullet.hit_fx = "fx_wick_splat"
arrow.bullet.miss_fx = "fx_wick_splat"
arrow.bullet.miss_decal = nil
arrow.bullet.hit_blood_fx = "fx_blood_splat_wicked_sisters"
arrow.bullet.flight_time = fts(22)
arrow.bullet.damage_type = DAMAGE_MAGICAL
arrow.render.sprites[1].name = "wicked_sisters_proyectile_travel"
arrow.render.sprites[1].animated = true
arrow.sound_events.insert = "WickedSistersAttack"
arrow.bullet.prediction_error = false
arrow.bullet.predict_target_pos = true
arrow.bullet.damage_min = 0
arrow.bullet.damage_max = 0
arrow.bullet.mod = "mod_wicked_sister_poison_lvl1"
arrow.bullet.particles_name = "ps_bullet_tower_wicked_sisters_basic_trail"

tt = RT("mod_wicked_sister_poison_lvl1", "mod_poison")
tt.modifier.duration = 2.4
tt.dps.damage_max = 12--10
tt.dps.damage_min = 12
tt.dps.damage_every = 0.8
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)

local arrow = E:register_t("proy_green_lvl2", "proy_green_lvl1")
arrow.bullet.mod = "mod_wicked_sister_poison_lvl2"

tt = RT("mod_wicked_sister_poison_lvl2", "mod_wicked_sister_poison_lvl1")
tt.dps.damage_max = 30--25
tt.dps.damage_min = 30

local arrow = E:register_t("proy_green_lvl3", "proy_green_lvl1")
arrow.bullet.mod = "mod_wicked_sister_poison_lvl3"

tt = RT("mod_wicked_sister_poison_lvl3", "mod_wicked_sister_poison_lvl1")
tt.dps.damage_max = 51--43
tt.dps.damage_min = 51

local arrow = E:register_t("proy_green_lvl4", "proy_green_lvl1")
arrow.bullet.mod = "mod_wicked_sister_poison_lvl4"

tt = RT("mod_wicked_sister_poison_lvl4", "mod_wicked_sister_poison_lvl1")
tt.dps.damage_max = 84--70
tt.dps.damage_min = 77

local arrow = E:register_t("proy_pink_lvl1", "arrow")
arrow.bullet.hit_distance = 32
arrow.bullet.hit_fx = "fx_wick_pink_splat"
arrow.bullet.miss_fx = "fx_wick_pink_splat"
arrow.bullet.miss_decal = nil
arrow.bullet.flight_time = fts(22)
arrow.bullet.damage_type = DAMAGE_MAGICAL
arrow.bullet.hit_blood_fx = "fx_blood_splat_wicked_sisters_violet"
arrow.render.sprites[1].name = "wicked_sisters_proyectile_violet_travel"
arrow.render.sprites[1].animated = true
arrow.sound_events.insert = "WickedSistersAttack"
arrow.bullet.prediction_error = false
arrow.bullet.predict_target_pos = true
arrow.bullet.damage_min = 13--11
arrow.bullet.damage_max = 30--25
arrow.bullet.particles_name = "ps_bullet_tower_wicked_sisters_violet_trail"

local arrow = E:register_t("proy_pink_lvl2", "proy_pink_lvl1")
arrow.bullet.damage_min = 32--27
arrow.bullet.damage_max = 76--63
arrow.bullet.mod = nil--"mod_wicked_sisters_stun_lvl2"
local arrow = E:register_t("proy_pink_lvl3", "proy_pink_lvl1")
arrow.bullet.damage_min = 58--48
arrow.bullet.damage_max = 135--112
arrow.bullet.mod = nil--"mod_wicked_sisters_stun_lvl3"
local arrow = E:register_t("proy_pink_lvl4", "proy_pink_lvl1")
arrow.bullet.damage_min = 94--78
arrow.bullet.damage_max = 220--182
arrow.bullet.mod = nil--"mod_wicked_sisters_stun_lvl4"

tt = RT("mod_wicked_sisters_stun_lvl1", "mod_stun")
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

tt = RT("mod_wicked_sisters_stun_lvl2", "mod_wicked_sisters_stun_lvl1")
tt.modifier.duration = 1.4
tt = RT("mod_wicked_sisters_stun_lvl3", "mod_wicked_sisters_stun_lvl1")
tt.modifier.duration = 1.6
tt = RT("mod_wicked_sisters_stun_lvl4", "mod_wicked_sisters_stun_lvl1")
tt.modifier.duration = 2.0


tt = RT("fx_mod_polymorph_wicked_sisters_big", "fx_mod_polymorph_sorcerer_small")
tt.render.sprites[1].name = "wicked_sisters_froggification_hit_run"

tt = RT("mod_polymorph_wicked_sisters", "mod_polymorph")
tt.modifier.use_mod_offset = true
tt.modifier.remove_banned = true
tt.modifier.ban_types = {
	MOD_TYPE_FAST
}
tt.polymorph.custom_entity_names.default = "enemy_frog_ground"
tt.polymorph.custom_entity_names.enemy_demon_imp = "enemy_frog_ground"
tt.polymorph.custom_entity_names.enemy_gargoyle = "enemy_frog_ground"
tt.polymorph.custom_entity_names.enemy_rocketeer = "enemy_frog_ground"
tt.polymorph.custom_entity_names.enemy_witch = "enemy_frog_ground"
tt.polymorph.hit_fx_sizes = {
	"fx_mod_polymorph_wicked_sisters_big",
	"fx_mod_polymorph_wicked_sisters_big",
	"fx_mod_polymorph_wicked_sisters_big"
}
tt.polymorph.pop = {
	"pop_puff"
}
tt.polymorph.transfer_gold_factor = 1
tt.polymorph.transfer_health_factor = 0.75
tt.polymorph.transfer_lives_cost_factor = 1
tt.polymorph.transfer_speed_factor = 0.5

tt = RT("ray_wicked_sisters_polymorph", "bullet")
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_time = fts(8)
tt.bullet.mod = "mod_polymorph_wicked_sisters"
tt.image_width = 70
tt.main_script.update = scripts.ray_simple.update
tt.ray_duration = fts(13)
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "wicked_sisters_froggification_ray_travel"
tt.sound_events.insert = "WickedSistersFrog"
tt.track_target = true

tt = RT("enemy_frog_ground", "enemy")
anchor_y = 0.2
image_y = 38
tt.enemy.gold = 0
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 80
tt.health_bar.offset = v(0, ady(32))
tt.info.i18n_key = "TOWER_WICKED_SISTERS_LEVEL4_FROGGIFICATION_BOTTOM_TEXT"
tt.info.portrait = "gui4_bottom_info_image_enemies_0056"
tt.info.enc_icon = nil
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = kr4_scripts.enemy_frog.update
tt.motion.max_speed = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "wicked_sisters_frog"
tt.sound_events.insert = "WickedSistersFrogSound"
tt.sound_events.death = "WickedSistersFrogSound"
tt.unit.can_explode = true
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 10)
tt.unit.mod_offset = v(0, ady(15))
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY)
tt.clicks_to_destroy = 3


----------------------------------------------
-------------------战争飞艇--------------------
----------------------------------------------

--建造
tt = E:register_t("tower_build_balloon", "tower_build")
tt.build_name = "tower_balloon_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "warmongers_baloon_tower_base_lvl1_layer1_0061"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 30)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E:register_t("tower_balloon_lvl1", "tower")
E:add_comps(tt, "barrack")

tt.tower.type = "balloon"
tt.tower.kind = TOWER_KIND_ENGINEER
tt.tower.level = 1
tt.tower.price = 160
tt.info.fn = kr4_scripts.tower_balloon.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0004"
tt.info.enc_icon = 213
tt.info.i18n_key = "TOWER_WARMONGER_BALLOON_LEVEL1"
tt.main_script.insert = kr4_scripts.tower_balloon.insert
tt.main_script.update = kr4_scripts.tower_balloon.update
tt.main_script.remove = kr4_scripts.tower_balloon.remove
tt.barrack.soldier_type = "soldier_balloon_lvl1"
tt.barrack.rally_range = 150
--tt.barrack.rally_terrains = bor(TERRAIN_ICE, TERRAIN_CLIFF, TERRAIN_WATER, TERRAIN_LAND)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
for i = 2, 3 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "warmongers_baloon_tower_base_lvl1_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].group = "layers"
	tt.render.sprites[i].offset = v(0, 31)
	tt.render.sprites[i].z = Z_OBJECTS--Z_TOWER_BASES
end
--动画？
tt.sound_events.insert = "BalloonTaunt"
tt.sound_events.change_rally_point = "BalloonTauntChange"
tt.ui.click_rect = r(-40, -10, 80, 50)

tt = E:register_t("tower_balloon_lvl2", "tower_balloon_lvl1")
tt.info.i18n_key = "TOWER_WARMONGER_BALLOON_LEVEL2"
tt.tower.level = 2
tt.tower.price = 260
tt.barrack.rally_range = 165
tt.barrack.soldier_type = "soldier_balloon_lvl2"
for i = 2, 3 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "warmongers_baloon_tower_base_lvl2_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].group = "layers"
	tt.render.sprites[i].offset = v(0, 31)
	tt.render.sprites[i].z = Z_OBJECTS--Z_TOWER_BASES
end
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "warmongers_baloon_tower_base_flag"
tt.render.sprites[4].name = "run"
tt.render.sprites[4].offset = v(25, 82)
tt.render.sprites[4].z = Z_OBJECTS--Z_TOWER_BASES

tt = E:register_t("tower_balloon_lvl3", "tower_balloon_lvl1")
tt.info.i18n_key = "TOWER_WARMONGER_BALLOON_LEVEL3"
tt.tower.level = 3
tt.tower.price = 300
tt.barrack.rally_range = 180
tt.barrack.soldier_type = "soldier_balloon_lvl3"
for i = 2, 3 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "warmongers_baloon_tower_base_lvl3_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].group = "layers"
	tt.render.sprites[i].offset = v(0, 31)
	tt.render.sprites[i].z = Z_OBJECTS--Z_TOWER_BASES
end
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "warmongers_baloon_tower_base_flag"
tt.render.sprites[4].name = "run"
tt.render.sprites[4].offset = v(29, 88)
tt.render.sprites[4].z = Z_OBJECTS--Z_TOWER_BASES

tt = E:register_t("tower_balloon_lvl4", "tower_balloon_lvl1")
E:add_comps(tt, "powers", "attacks")
tt.info.i18n_key = "TOWER_WARMONGER_BALLOON_LEVEL4"
tt.tower.level = 4
tt.tower.price = 360
tt.barrack.rally_range = 209
tt.barrack.soldier_type = "soldier_balloon_lvl4"
for i = 2, 3 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "warmongers_baloon_tower_base_lvl4_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].group = "layers"
	tt.render.sprites[i].offset = v(0, 31)
	tt.render.sprites[i].z = Z_OBJECTS--Z_TOWER_BASES
end
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "warmongers_baloon_tower_base_lvl4_light"
tt.render.sprites[4].name = "run"
tt.render.sprites[4].offset = v(25, 95)
tt.render.sprites[4].z = Z_OBJECTS--Z_TOWER_BASES

tt.powers.bomber = E:clone_c("power")
tt.powers.bomber.price_base = 136
tt.powers.bomber.max_level = 1
tt.powers.bomber.enc_icon = 314
tt.powers.oil = E:clone_c("power")
tt.powers.oil.price_base = 68
tt.powers.oil.price_inc = 68
tt.powers.oil.enc_icon = 313
tt.powers.watcher = E:clone_c("power")
tt.powers.watcher.price_base = 212
tt.powers.watcher.max_level = 1
tt.powers.watcher.enc_icon = 315

--飞艇本体
local balloon_offset_y = 50
tt = E:register_t("soldier_balloon_lvl1")

E:add_comps(tt, "pos", "render", "motion", "nav_rally", "main_script", "vis", "idle_flip", "attacks", "nav_grid")

--tt.powers.missile = E:clone_c("power")
--tt.powers.oil = E:clone_c("power")
tt.flight_height = 65
tt.idle_flip.cooldown = 10
tt.idle_flip.last_dir = 1
tt.idle_flip.walk_dist = 0--27
tt.main_script.insert = kr4_scripts.soldier_balloon.insert
tt.main_script.remove = kr4_scripts.soldier_balloon.remove
tt.main_script.update = kr4_scripts.soldier_balloon.update
tt.vis.bans = F_RANGED
tt.motion.max_speed = 85
tt.balloon_layer_count = 2
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "GoblinBalloon_Lvl1"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = 0.11
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "warmongers_baloon_tower_shooter_lvl1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 6)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].is_shadow = true
tt.render.sprites[3].animated = false
tt.render.sprites[3].name = "warmongers_baloon_tower_shadow"
tt.render.sprites[3].z = Z_DECALS + 1
for i = 1, tt.balloon_layer_count do
	tt.render.sprites[i].offset.y = tt.render.sprites[i].offset.y + balloon_offset_y
end
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bomb_balloon_lvl1"
tt.attacks.list[1].vis_bans = F_FLYING
tt.attacks.list[1].animations = {
	"shoot",
	"shoot"
}
tt.attacks.list[1].hit_times = {
	fts(12),
	fts(12)
}
tt.attacks.list[1].max_range = 105
tt.attacks.list[1].start_offsets = {
	v(0, 10 + balloon_offset_y),
	v(0, 10 + balloon_offset_y)
}
tt.attacks.list[1].cooldown = 1.36
tt.attacks.list[1].node_prediction = fts(26)

tt = E:register_t("soldier_balloon_lvl2", "soldier_balloon_lvl1")
tt.attacks.list[1].bullet = "bomb_balloon_lvl2"
tt.attacks.list[1].start_offsets = {
	v(0, 12 + balloon_offset_y),
	v(0, 12 + balloon_offset_y)
}
tt.render.sprites[1].prefix = "GoblinBalloon_Lvl2"
tt.render.sprites[2].prefix = "warmongers_baloon_tower_shooter_lvl2"
tt.render.sprites[2].offset = v(0, 8)
--for i = 1, 2 do
tt.render.sprites[2].offset.y = tt.render.sprites[2].offset.y + balloon_offset_y
--end

tt = E:register_t("soldier_balloon_lvl3", "soldier_balloon_lvl1")
tt.attacks.list[1].bullet = "bomb_balloon_lvl3"
tt.attacks.list[1].start_offsets = {
	v(0, 14 + balloon_offset_y),
	v(0, 14 + balloon_offset_y)
}
tt.render.sprites[1].prefix = "GoblinBalloon_Lvl3"
tt.render.sprites[2].prefix = "warmongers_baloon_tower_shooter_lvl3"
tt.render.sprites[2].offset = v(0, 10)
--for i = 1, 2 do
tt.render.sprites[2].offset.y = tt.render.sprites[2].offset.y + balloon_offset_y
--end

tt = E:register_t("soldier_balloon_lvl4", "soldier_balloon_lvl1")
E:add_comps(tt, "powers")
tt.powers.bomber = E:clone_c("power")
tt.powers.oil = E:clone_c("power")
tt.powers.watcher = E:clone_c("power")
tt.balloon_layer_count = 7
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "baloon_tower_pitch"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].offset = v(10, 70)
for i = 2, 4 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "warmongers_baloon_tower_lvl4_layer" .. i-1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].group = "layers"
    tt.render.sprites[i].anchor.y = 0.11
end
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "warmongers_baloon_tower_shooter_lvl4"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(-10, 20)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "warmongers_baloon_tower_shooter_lvl4"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].offset = v(10, 20)
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].prefix = "warmongers_baloon_tower_lookout_lvl4"
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].anchor.y = 0.11
tt.render.sprites[7].offset = v(0, 96)
tt.render.sprites[8] = E:clone_c("sprite")
tt.render.sprites[8].is_shadow = true
tt.render.sprites[8].animated = false
tt.render.sprites[8].name = "warmongers_baloon_tower_shadow"
tt.render.sprites[8].z = Z_DECALS + 1
for i = 1, tt.balloon_layer_count do
	tt.render.sprites[i].offset.y = tt.render.sprites[i].offset.y + balloon_offset_y
end
tt.attacks.list[1].bullet = "bomb_balloon_lvl4"
tt.attacks.list[1].start_offsets = {
	v(0, 20+balloon_offset_y),
	v(0, 20+balloon_offset_y)
}

tt.attacks.list[2] = E:clone_c("mod_attack")
tt.attacks.list[2].mod = "range_mod_balloon"
tt.attacks.list[2].cooldown = 0.5
tt.attacks.list[2].range = 200
tt.attacks.list[2].range_inc = 0
tt.attacks.list[2].disabled = true
tt.attacks.list[2].excluded_templates = {
	"g1_tower_barrack_1",
	"g1_tower_barrack_2",
	"g1_tower_barrack_3",
	"g1_tower_barrack_3_a",
	"g1_tower_barrack_3_b",
	"g2_tower_barrack_1",
	"g2_tower_barrack_2",
	"g2_tower_barrack_3",
	"g2_tower_barrack_3_a",
	"g2_tower_barrack_3_b",
	"tower_barrack_1",
	"tower_barrack_2",
	"tower_barrack_3",
	"tower_barrack_3_a",
	"tower_barrack_3_b",
	"tower_drow",
	"tower_drow_2",
	"Goldfinger",
	"tower_hero_buy",
	"tower_hero_buy_a",
	"tower_hero_buy_b",
	"tower_hero_buy_c",
	"tower_hero_buy_d",
	"tower_blade",
	"tower_forest",
	"tower_barrack_dwarf_d",
	"tower_barbarian",
	"tower_paladin",
	"tower_assassin",
	"tower_templar",
	"tower_elf_d",
	"tower_barrack_pirates_d",
	"tower_barrack_amazonas_d",
	"tower_barrack_mercenaries_d",
	"tower_ewok_d",
	"tower_baby_ashbite_d",
	"tower_sasquash_d",
	"tower_black_baby_dragon_d",
	"tower_pirate_camp_d",
	
	"tower_paladin_covenant_lvl1",
	"tower_paladin_covenant_lvl2",
	"tower_paladin_covenant_lvl3",
	"tower_paladin_covenant_lvl4",
	"tower_rocket_gunners_lvl1",
	"tower_rocket_gunners_lvl2",
	"tower_rocket_gunners_lvl3",
	"tower_rocket_gunners_lvl4",
	"tower_dwarf_lvl1",
	"tower_dwarf_lvl2",
	"tower_dwarf_lvl3",
	"tower_dwarf_lvl4",
	"tower_ghost_lvl1",
	"tower_ghost_lvl2",
	"tower_ghost_lvl3",
	"tower_ghost_lvl4",
	--[[
	"tower_ogre_shipwreck_lvl1",
	"tower_ogre_shipwreck_lvl2", 
	"tower_ogre_shipwreck_lvl3", 
	"tower_ogre_shipwreck_lvl4", 
	"tower_twilight_elves_barrack_lvl1",
	"tower_twilight_elves_barrack_lvl2",
	"tower_twilight_elves_barrack_lvl3",
	"tower_twilight_elves_barrack_lvl4",
	"tower_dark_knights_lvl1",
	"tower_dark_knights_lvl2",
	"tower_dark_knights_lvl3",
	"tower_dark_knights_lvl4",
	]]--
}

tt.attacks.list[3] = E:clone_c("bullet_attack")
tt.attacks.list[3].bullet = "bullet_balloon_oil"
tt.attacks.list[3].power_name = "oil"
tt.attacks.list[3].vis_bans = F_FLYING
tt.attacks.list[3].animation = "run"
tt.attacks.list[3].cooldown = 15
tt.attacks.list[3].hit_time = fts(17)
tt.attacks.list[3].start_offset = v(0, -10+balloon_offset_y)
tt.attacks.list[3].max_range = 75
tt.attacks.list[3].min_range = 0
tt.attacks.list[4] = E:clone_c("custom_attack")
tt.attacks.list[4].bullet = "bullet_tower_balloon_big_guy_lvl4"
tt.attacks.list[4].cooldown = 12
tt.attacks.list[4].shoot_time = fts(41)
tt.attacks.list[4].bullet_start_offset = v(-7, 70)
tt.attacks.list[4].max_range = 180
tt.attacks.list[4].node_prediction = fts(80)
tt.attacks.list[4].animation = "paratrooper"
tt.attacks.list[4].animation_reload = "big_guy_reload_big_guy"
tt.attacks.list[4].vis_flags = bor(F_RANGED)
tt.attacks.list[4].vis_bans = bor(F_FLYING)

tt = RT("bullet_tower_balloon_big_guy_lvl4", "bomb")
tt.bullet.flight_time = fts(31)
tt.bullet.rotation_speed = nil--20 * FPS * math.pi / 180
--tt.bullet.hit_fx = "fx_goblin_bomber_burst_burst"
--tt.bullet.hit_decal = "decal_bomb_crater"
--tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 55
tt.bullet.damage_max = 77
tt.bullet.damage_radius = 63
tt.bullet.pop = nil
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "warmongers_baloon_tower_lvl4_paratrooper_0001"
tt.render.sprites[1].animated = false
tt.main_script.insert = kr1_scripts.bomb.insert
tt.main_script.update = kr1_scripts.bomb.update
tt.sound_events.insert = "BalloonTrooper" --"BombShootSound"
tt.sound_events.hit = "BalloonTrooper" --"BombExplosionSound"
tt.sound_events.hit_water = nil--"RTWaterExplosion"
tt.bullet.hit_payload = "soldier_balloon_goblin"


tt = RT("bomb_balloon_lvl1", "bomb")
tt.bullet.flight_time = fts(26)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "fx_explosion_small"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 6
tt.bullet.damage_max = 13--12
tt.bullet.damage_radius = 42
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "warmongers_baloon_tower_shooter_lvl1_proyectile"
tt.render.sprites[1].animated = false
tt.main_script.insert = kr1_scripts.bomb.insert
tt.main_script.update = kr1_scripts.bomb.update
--tt.sound_events.insert = "BombShootSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"

tt = RT("bomb_balloon_lvl2", "bomb_balloon_lvl1")
tt.bullet.damage_min = 17--16
tt.bullet.damage_max = 35--32
tt.render.sprites[1].name = "warmongers_baloon_tower_shooter_lvl2_proyectile"

tt = RT("bomb_balloon_lvl3", "bomb_balloon_lvl1")
tt.bullet.damage_min = 33--30
tt.bullet.damage_max = 66--60
tt.render.sprites[1].name = "warmongers_baloon_tower_shooter_lvl3_proyectile"

tt = RT("bomb_balloon_lvl4", "bomb_balloon_lvl1")
tt.bullet.damage_min = 55--50
tt.bullet.damage_max = 110--100
tt.render.sprites[1].name = "warmongers_baloon_tower_shooter_lvl4_proyectile"



local mod_slow_oil = E:register_t("mod_slow_oil_balloon_lvl1", "mod_slow")
mod_slow_oil.modifier.duration = 0.4
mod_slow_oil.slow.factor = 0.8
local mod_slow_oil = E:register_t("mod_slow_oil_balloon_lvl2", "mod_slow")
mod_slow_oil.modifier.duration = 0.4
mod_slow_oil.slow.factor = 0.6
local mod_slow_oil = E:register_t("mod_slow_oil_balloon_lvl3", "mod_slow")
mod_slow_oil.modifier.duration = 0.4
mod_slow_oil.slow.factor = 0.4

local fx_explosion_big = E:register_t("baloon_tower_splash_run", "fx")

fx_explosion_big.render.sprites[1].prefix = "baloon_tower_splash"
fx_explosion_big.render.sprites[1].name = "run"
fx_explosion_big.render.sprites[1].anchor.y = 0.13
fx_explosion_big.render.sprites[1].z = Z_OBJECTS
fx_explosion_big.render.sprites[1].sort_y_offset = -2

--bullet_balloon_oil
tt = RT("bullet_balloon_oil", "bomb")
tt.bullet.flight_time = fts(12)
tt.bullet.hit_payload = "oil_balloon_lvl"
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "baloon_tower_splash_run"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 55
tt.bullet.damage_max = 110--12
tt.bullet.damage_radius = 60
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "warmongers_baloon_tower_lvl4_pitch_barrel"
tt.render.sprites[1].animated = false
tt.main_script.insert = kr1_scripts.bomb.insert
tt.main_script.update = kr1_scripts.bomb.update
tt.sound_events.insert = "BalloonTarbomb"
tt.sound_events.hit = "BalloonTarbomb"
tt.sound_events.hit_water = "RTWaterExplosion"

--漏油
local oil_mecha = E:register_t("oil_balloon_lvl1", "aura")
E:add_comps(oil_mecha, "render", "tween")

oil_mecha.aura.mod = "mod_slow_oil_balloon_lvl1"
oil_mecha.aura.duration = 6
oil_mecha.aura.cycle_time = 0.3
oil_mecha.aura.radius = 60
oil_mecha.aura.vis_bans = bor(F_FRIEND, F_FLYING)
oil_mecha.aura.vis_flags = F_MOD
oil_mecha.main_script.insert = scripts.aura_apply_mod.insert
oil_mecha.main_script.update = scripts.aura_apply_mod.update
oil_mecha.render.sprites[1].animated = false
oil_mecha.render.sprites[1].name = "warmongers_baloon_tower_lvl4_splash_decal"
oil_mecha.render.sprites[1].z = Z_DECALS
oil_mecha.tween.props[1].name = "alpha"
oil_mecha.tween.props[1].keys = {
	{
		"this.actual_duration-0.6",
		255
	},
	{
		"this.actual_duration",
		0
	}
}
oil_mecha.tween.props[2] = E:clone_c("tween_prop")
oil_mecha.tween.props[2].name = "scale"
oil_mecha.tween.props[2].keys = {
	{
		0,
		v(0.6, 0.6)
	},
	{
		0.3,
		v(1, 1)
	}
}
oil_mecha.tween.remove = false
oil_mecha.sound_events.insert = "MechOil"

local oil_mecha = E:register_t("oil_balloon_lvl2", "oil_balloon_lvl1")
oil_mecha.aura.mod = "mod_slow_oil_balloon_lvl2"

local oil_mecha = E:register_t("oil_balloon_lvl3", "oil_balloon_lvl1")
oil_mecha.aura.mod = "mod_slow_oil_balloon_lvl3"

--哥布林侦察兵
tt = E:register_t("soldier_balloon_goblin", "soldier_militia")
AC(tt, "reinforcement", "ranged")
tt.info.i18n_key = "TOWER_WARMONGER_BALLOON_LEVEL4_PARACHUTE_TITLE_1"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0029"
tt.main_script.update = kr4_scripts.soldier_balloon_goblin.update
tt.health.armor = 0
tt.health.hp_max = 60
tt.regen.health = 0
tt.regen.cooldown = 2
--tt.melee.attacks[1].cooldown = 1
--tt.melee.attacks[1].damage_max = 28
--tt.melee.attacks[1].damage_min = 18
--tt.melee.range = 0
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "bomb_soldier_balloon_goblin"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 10)
}
tt.ranged.attacks[1].cooldown = 1
tt.ranged.attacks[1].node_prediction = fts(18)
tt.ranged.attacks[1].max_range = 160
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(8)
tt.ranged.attacks[1].ts = 0
tt.ranged.attacks[1].vis_bans = bor(F_FLYING)
tt.motion.max_speed = 75
tt.render.sprites[1].prefix = "warmongers_baloon_tower_lvl4_zapper"
tt.render.sprites[1].name = "idle"
tt.reinforcement.duration = 11.2
tt.reinforcement.fade = true
tt.patrol_pos_offset = v(15, 10)
tt.patrol_min_cd = 3
tt.patrol_max_cd = 6

tt = E:register_t("bomb_soldier_balloon_goblin", "bomb")
tt.bullet.flight_time = fts(18)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "fx_explosion_big"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 18
tt.bullet.damage_max = 28
tt.bullet.damage_radius = 36
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "warmongers_baloon_tower_lvl4_zapper_proyectile"
tt.render.sprites[1].animated = false
tt.main_script.insert = kr1_scripts.bomb.insert
tt.main_script.update = kr1_scripts.bomb.update
tt.sound_events.insert = nil--"BombShootSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"

--范围buff
local tt = E:register_t("range_mod_balloon", "modifier")

E:add_comps(tt, "render", "tween")
tt.modifier.duration = 99
tt.range_factor = 1.2
tt.range_factor_inc = 0
tt.main_script.insert = kr4_scripts.range_mod_balloon.insert
tt.main_script.remove = kr4_scripts.range_mod_balloon.remove
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].loop = true
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.5,
		v(0.9, 0.9)
	},
	{
		1,
		v(1, 1)
	}
}
tt.render.sprites[1].name = "baloon_tower_buff_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.21
tt.render.sprites[1].offset.y = -15
tt.render.sprites[1].z = Z_OBJECTS + 1--Z_TOWER_BASES

--[[
for i, p in ipairs({
	v(22, 45),
	v(40, 35),
	v(58, 30),
	v(77, 35),
	v(95, 45)
}) do
	tt.render.sprites[i + 1] = E:clone_c("sprite")
	tt.render.sprites[i + 1].prefix = "baloon_tower_buff"
	tt.render.sprites[i + 1].name = "run"
	tt.render.sprites[i + 1].anchor.y = 0.21
	tt.render.sprites[i + 1].offset = v(p.x - 58, p.y - 27)
	tt.render.sprites[i + 1].ts = math.random()
end
]]--

local tt = E:register_t("decal_baloon_tower_buff", "decal_tween")

tt.render.sprites[1].name = "baloon_tower_buff_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5, 0.32)
tt.render.sprites[1].offset.y = 0
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].loop = true
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.25,
		v(1.15, 1.15)
	},
	{
		0.5,
		v(1, 1)
	}
}

local decal_crossbow_eagle_preview = E:register_t("decal_balloon_eagle_preview", "decal_tween")

decal_crossbow_eagle_preview.render.sprites[1].name = "baloon_tower_buff_aura_run"
decal_crossbow_eagle_preview.render.sprites[1].animated = true
decal_crossbow_eagle_preview.render.sprites[1].anchor = v(0.5, 0.32)
decal_crossbow_eagle_preview.render.sprites[1].offset.y = 75
decal_crossbow_eagle_preview.tween.remove = false
decal_crossbow_eagle_preview.tween.props[1].name = "scale"
decal_crossbow_eagle_preview.tween.props[1].loop = true
decal_crossbow_eagle_preview.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.25,
		v(1.15, 1.15)
	},
	{
		0.5,
		v(1, 1)
	}
}


----------------------------------------------
-----------------深渊恶魔环礁------------------
----------------------------------------------
--模仿圣骑士巢穴的插入功能
--tower_build_ogre_shipwreck
tt = E:register_t("tower_build_deep_devils", "tower_build")
tt.build_name = "tower_deep_devils_lvl1"
tt.render.sprites[1].name = "terrain_deep_devils_reef_towers"
tt.render.sprites[1].offset = v(0, 40)
tt.render.sprites[2].name = "deep_devils_reef_towers_lvl1_layer1_0001"
tt.render.sprites[2].offset = v(0, 40)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E:register_t("tower_deep_devils_lvl1", "tower_KR5")
E:add_comps(tt, "barrack", "vis", "attacks")
tt.info.i18n_key = "TOWER_DEEP_DEVILS_LEVEL1"
tt.barrack.rally_range = 159.5
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "soldier_deep_devils_lvl1"
tt.barrack.max_soldiers = 2
tt.info.fn = kr4_scripts.tower_deep_devils.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0021"
tt.main_script.insert = kr4_scripts.tower_deep_devils.insert
tt.main_script.remove = kr4_scripts.tower_deep_devils.remove
tt.main_script.update = kr4_scripts.tower_deep_devils.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_deep_devils_reef_towers"
tt.render.sprites[1].offset = v(0, 40)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "deep_devils_reef_towers_lvl1_layer1_0002"
tt.render.sprites[2].offset = v(0, 40)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 40)
tt.render.sprites[3].prefix = "deep_devils_reef_towers_lvl1"
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].animated = true
tt.render.sprites[4].prefix = "deep_devils_reef_tower_shooter_lvl1"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(0, 55)
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
}
tt.attacks.range = 150
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].range = 150
tt.attacks.list[1].shoot_time = fts(14)
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet = "bolt_tower_deep_devils_lvl1"
tt.attacks.list[1].bullet_start_offset = {v(-6, 70), v(6, 70)}
tt.attacks.list[1].cooldown = 1.5 
tt.attacks.list[1].animation = "shoot"
--tt.attacks.list[1].sound = "BoltSound"
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "DeepDevilTaunt"
tt.sound_events.insert = "DeepDevilTaunt"
tt.tower.level = 1
tt.tower.price = 120
tt.tower.type = "deep_devils"
tt.tower.kind = TOWER_KIND_MAGE
tt.tower.team = TEAM_DARK_ARMY
tt.tower.menu_offset = v(0, 15)
tt.ui.click_rect = r(-40, 0, 80, 70)

tt = RT("fx_bolt_deep_devils_hit", "fx")
tt.render.sprites[1].prefix = "deep_devils_reef_tower_shooter"
tt.render.sprites[1].name = "hit"

tt = E:register_t("ps_bolt_deep_devils","ps_bullet_tower_wicked_sisters_basic_trail")
tt.particle_system.animated = false
tt.particle_system.name = "deep_devils_reef_tower_shooter_bolt"
tt.particle_system.particle_lifetime = {
    fts(8),
    fts(8)
}

tt = RT("bolt_tower_deep_devils_lvl1", "bolt")
tt.bullet.damage_max = 14--12
tt.bullet.damage_min = 7--6
tt.bullet.hit_fx = "fx_bolt_deep_devils_hit"
tt.bullet.max_speed = 600

tt.bullet.particles_name = "ps_bolt_deep_devils"
tt.bullet.pop = {
	"pop_arcane"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "deep_devils_reef_tower_shooter_bolt"
tt.sound_events.insert = "BoltSorcererSound"

tt = E:register_t("tower_deep_devils_lvl2", "tower_deep_devils_lvl1")
tt.info.i18n_key = "TOWER_DEEP_DEVILS_LEVEL2"
tt.barrack.soldier_type = "soldier_deep_devils_lvl2"
tt.tower.level = 2
tt.tower.price = 170
tt.render.sprites[3].prefix = "deep_devils_reef_towers_lvl2"
tt.attacks.range = 157.5
tt.attacks.list[1].range = 157.5
tt.attacks.list[1].bullet = "bolt_tower_deep_devils_lvl2"
tt.attacks.list[1].bullet_start_offset = {v(-6, 75), v(6, 75)}
tt.render.sprites[2].name = "deep_devils_reef_towers_lvl2_layer1_0002"
tt.render.sprites[3].prefix = "deep_devils_reef_towers_lvl2"
tt.render.sprites[4].prefix = "deep_devils_reef_tower_shooter_lvl2"
tt.render.sprites[4].offset = v(0, 60)



tt = RT("bolt_tower_deep_devils_lvl2", "bolt_tower_deep_devils_lvl1")
tt.bullet.damage_max = 36--30
tt.bullet.damage_min = 20--17


tt = E:register_t("tower_deep_devils_lvl3", "tower_deep_devils_lvl1")
tt.info.i18n_key = "TOWER_DEEP_DEVILS_LEVEL3"
tt.barrack.soldier_type = "soldier_deep_devils_lvl3"
tt.tower.level = 3
tt.tower.price = 240
tt.render.sprites[3].prefix = "deep_devils_reef_towers_lvl3"
tt.attacks.range = 165
tt.attacks.list[1].range = 165
tt.attacks.list[1].bullet = "bolt_tower_deep_devils_lvl3"
tt.attacks.list[1].bullet_start_offset = {v(-10, 80), v(10, 80)}
tt.render.sprites[2].name = "deep_devils_reef_towers_lvl3_layer1_0002"
tt.render.sprites[3].prefix = "deep_devils_reef_towers_lvl3"
tt.render.sprites[4].prefix = "deep_devils_reef_tower_shooter_lvl3"
tt.render.sprites[4].offset = v(0, 65)

tt = RT("bolt_tower_deep_devils_lvl3", "bolt_tower_deep_devils_lvl2")
tt.bullet.damage_max = 77--64
tt.bullet.damage_min = 36--30

tt = E:register_t("tower_deep_devils_lvl4", "tower_deep_devils_lvl3")
E:add_comps(tt, "powers")
tt.info.i18n_key = "TOWER_DEEP_DEVILS_LEVEL4"
tt.barrack.soldier_type = "soldier_deep_devils_lvl4"
tt.tower.level = 4
tt.tower.price = 330
tt.powers.amph = E:clone_c("power")
tt.powers.amph.price_base = 170
tt.powers.amph.max_level = 1
tt.powers.amph.enc_icon = 359
tt.powers.net = E:clone_c("power")
tt.powers.net.enc_icon = 358
tt.powers.net.price_base = 102
tt.powers.net.price_inc = 102
tt.powers.net.max_level = 2
tt.powers.net.duration = {2, 4}
tt.powers.net.cooldown = {14, 12}
tt.powers.storm = E:clone_c("power")
tt.powers.storm.enc_icon = 357
tt.powers.storm.max_level = 3
tt.powers.storm.price_base = 170
tt.powers.storm.price_inc = 170
tt.powers.storm.damage = {25, 50, 75}
tt.powers.storm.damage_count = 5
tt.attacks.range = 177.5
tt.attacks.list[1].range = 177.5
tt.attacks.list[1].bullet_start_offset = {v(-10, 85), v(10, 85)}
tt.attacks.list[1].bullet = "bolt_tower_deep_devils_lvl4"
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].animation = "shoot"
tt.attacks.list[2].bullet = "honey_bees_proy"
tt.attacks.list[2].cooldown = 18
tt.attacks.list[2].shoot_time = 0.2
tt.attacks.list[2].shooters_delay = 0.1
tt.attacks.list[2].bullet_start_offset = {
	v(8, -1),
	v(4, -10)
}
tt.attacks.list[2].range = 177.5
tt.attacks.list[2].disabled = true
tt.attacks.list[2].vis_bans = bor(F_NIGHTMARE)
tt.render.sprites[2].name = "deep_devils_reef_towers_lvl4_0001"
tt.render.sprites[3].prefix = "deep_devils_reef_towers_lvl3"
tt.render.sprites[3].hidden = true
tt.render.sprites[4].prefix = "deep_devils_reef_tower_shooter_lvl4"
tt.render.sprites[4].offset = v(0, 70)


tt = RT("bolt_tower_deep_devils_lvl4", "bolt_tower_deep_devils_lvl3")
tt.bullet.damage_max = 126--105
tt.bullet.damage_min = 72--60

tt = E:register_t("soldier_deep_devils_lvl1", "soldier_militia")
E:add_comps(tt, "nav_grid")
anchor_y = 0.21
image_y = 42
tt.info.portrait = "gui4_bottom_info_image_soldiers_0047"
tt.health.armor = 0.1
tt.health.dead_lifetime = 12
tt.health.hp_max = 65--50
tt.health_bar.offset = v(0, 25)
tt.info.random_name_count = 7
tt.info.random_name_format = "SOLDIER_DEEP_DEVILS_SOLDIERS_%i_NAME"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 2
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 60
tt.motion.max_speed = 85
tt.regen.health = 6
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "deep_devils_reef_tower_greenfin_lvl1"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, 6)
tt.render.sprites[1].anchor.y = 0.228
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0.11
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].name = "deep_devils_reef_tower_greenfin_lvl1_shadow"
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))

tt = E:register_t("soldier_deep_devils_lvl2", "soldier_deep_devils_lvl1")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0048"
tt.health.armor = 0.15
tt.health.hp_max = 117
tt.health_bar.offset = v(0, 28)
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 2
tt.render.sprites[1].prefix = "deep_devils_reef_tower_greenfin_lvl2"
tt.render.sprites[2].name = "deep_devils_reef_tower_greenfin_lvl2_shadow"
tt.regen.health = 13

tt = E:register_t("soldier_deep_devils_lvl3", "soldier_deep_devils_lvl2")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0049"
tt.health.armor = 0.2
tt.health.hp_max = 175--135
tt.health_bar.offset = v(0, 30)
tt.melee.attacks[1].damage_max = 8
tt.melee.attacks[1].damage_min = 3
tt.render.sprites[1].prefix = "deep_devils_reef_tower_greenfin_lvl3"
tt.render.sprites[2].name = "deep_devils_reef_tower_greenfin_lvl3_shadow"
tt.regen.health = 16

tt = E:register_t("soldier_deep_devils_lvl4", "soldier_deep_devils_lvl3")
E:add_comps(tt, "powers", "ranged")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0050"
tt.powers.amph = E:clone_c("power")
tt.powers.amph.price_base = 170
tt.powers.amph.max_level = 1
tt.powers.net = E:clone_c("power")
tt.powers.net.price_base = 102
tt.powers.net.price_inc = 102
tt.powers.net.max_level = 2
tt.powers.net.duration = {2, 4}
tt.powers.net.cooldown = {14, 12}
tt.powers.storm = E:clone_c("power")
tt.powers.storm.max_level = 3
tt.powers.storm.price_base = 170
tt.powers.storm.price_inc = 170
tt.powers.storm.damage = {25, 50, 75}
tt.powers.storm.damage_count = 5
tt.health.armor = 0.25
tt.health.hp_max = 234--180
tt.health_bar.offset = v(0, 39)
tt.melee.attacks[1].damage_max = 15
tt.melee.attacks[1].damage_min = 6
tt.render.sprites[1].prefix = "deep_devils_reef_tower_greenfin_lvl4"

for i = 1, 4 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "deep_devils_reef_tower_redspine_lvl4_layer" .. i
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 6)
	tt.render.sprites[i].anchor.y = 0.32
	tt.render.sprites[i].group = "layers"
end
tt.regen.health = 16
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "deep_devil_arrow_lvl4"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 24)
}
tt.ranged.attacks[1].cooldown = 0.9
tt.ranged.attacks[1].max_range = 145
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = 0.3
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[2] = CC("bullet_attack")
tt.ranged.attacks[2].animation = "net"
tt.ranged.attacks[2].bullet = "net_deep_devils_lvl1"
tt.ranged.attacks[2].bullet_start_offset = {
	v(6, 24)
}
tt.ranged.attacks[2].cooldown = 14
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].max_range = 145
tt.ranged.attacks[2].min_range = 25
tt.ranged.attacks[2].shoot_time = 0.2
tt.ranged.attacks[2].vis_bans = bor(F_NIGHTMARE, F_BOSS, F_MINIBOSS, F_FLYING)

tt = E:register_t("soldier_deep_devils_lvl5", "soldier_deep_devils_lvl4")
tt.ranged.attacks[1].bullet = "deep_devil_arrow_lvl5"
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 12
tt.health.armor = 0.4
tt.health.hp_max = 284--230

tt = E:register_t("deep_devil_arrow_lvl4", "arrow5_fixed_height")
tt.render.sprites[1].name = "deep_devils_reef_tower_redspine_spear_lvl4"
tt.bullet.miss_decal = "deep_devils_reef_tower_redspine_spear_decal_lvl4_0009"
tt.bullet.miss_decal_anchor = v(1, 0.5)
tt.bullet.damage_max = 15
tt.bullet.damage_min = 9
tt.bullet.fixed_height = 35
tt.bullet.flip_y = true
tt.bullet.g = -1000
tt.bullet.hide_radius = 1
tt.bullet.reset_to_target_pos = true
tt.bullet.use_unit_damage_factor = true

tt = E:register_t("deep_devil_arrow_lvl5", "deep_devil_arrow_lvl4")
tt.bullet.damage_max = 20
tt.bullet.flip_y = true
tt.bullet.damage_min = 15

tt = E:register_t("net_deep_devils_lvl1", "bolt")
tt.render.sprites[1].name = "deep_devils_reef_tower_redspine_skill_net"
tt.render.sprites[1].animated = false
tt.bullet.damage_min = 15
tt.bullet.damage_max = 20
--tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.min_speed = 400
tt.bullet.max_speed = 400
tt.bullet.mod = "mod_deep_devils_net_lvl1"
tt.bullet.miss_decal = "deep_devils_reef_tower_redspine_skill_net_decal_0010"
tt.bullet.hit_fx = nil
tt.bullet.pop = nil
tt.sound_events.insert = "DeepDevilCatch"
tt.bullet.align_with_trajectory = true
tt.extra_bolt_range = 100
tt.extra_bolt = 0--2
tt.main_script.insert = scripts_rebbborn.bolt_net.insert

tt = E:register_t("mod_deep_devils_net_lvl1", "mod_stun")
AC(tt, "render")
--tt.main_script.insert = kr4_scripts.mod_deep_devils_net.insert
--tt.main_script.remove = kr4_scripts.mod_deep_devils_net.remove
tt.modifier.duration = 2
tt.render.sprites[1].prefix = "deep_devils_reef_tower_redspine_skill_net_active"
tt.render.sprites[1].animated = true
tt.render.sprites[1].size_scales = {
	vv(1.0),
	vv(1.3),
	vv(1.8)
}
tt.modifier.vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING)
tt.increase = 5

tt = E:register_t("net_deep_devils_lvl2", "net_deep_devils_lvl1")
tt.bullet.mod = "mod_deep_devils_net_lvl2"

tt = E:register_t("mod_deep_devils_net_lvl2", "mod_deep_devils_net_lvl1")
tt.modifier.duration = 4


----------------------------------------------
-------------------沙虫巢穴--------------------
----------------------------------------------

tt = E:register_t("tower_build_sandworm", "tower_build")
tt.build_name = "tower_sandworm_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 11)
tt.render.sprites[2].name = "worm_nest_level1_build"
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(0, 51)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62
tt = E:register_t("tower_sandworm_lvl1", "tower_KR5")
E:add_comps(tt, "attacks", "vis")
--防御塔基本信息
tt.tower.type = "sandworm"
tt.tower.kind = TOWER_KIND_ENGINEER
tt.tower.team = TEAM_LINIREA
tt.tower.level = 1
tt.tower.price = 130
tt.tower.menu_offset = v(0, 20)
--脚本
tt.main_script.update = kr4_scripts.tower_sandworm.update
--信息栏
tt.info.enc_icon = 17
tt.info.i18n_key = "TOWER_TREMOR_LEVEL1"
--tt.info.tower_portrait = "towerselect_portraits_big_" .. "0002"
tt.info.portrait = "gui4_bottom_info_image_towers_0025"
tt.info.damage_icon = "fireball"
tt.info.stat_damage = 5
tt.info.stat_range = 7
tt.info.stat_cooldown = 2
tt.info.fn = kr4_scripts.tower_sandworm.get_info
--动画
--第一个是要保留的。动画默认设置为true，如果不是动画需要手动false
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 11)
--第二个是防御塔
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "worm_nest_level1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 51)

--声音和其他信息
tt.mage_offset = v(0, 80)
tt.sound_events.insert = "sandwormTaunt"
tt.ui.click_rect = r(-30, 0, 60, 65)

--攻击信息
tt.attacks.range = 150
tt.attacks.attack_delay_on_spawn = fts(5)
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].range = 150
tt.attacks.list[1].bullet = "bullet_tower_sandworm_lvl1"
tt.attacks.list[1].cooldown = 6.0 --应该和script有关
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].first_cooldown = 2
tt.attacks.list[1].node_prediction = fts(25)
tt.attacks.list[1].bullet_start_offset = v(2, 40)
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE, F_FLYING)
tt.attacks.list[1].vis_flags = bor(F_RANGED, F_AREA)

tt = E:register_t("tower_sandworm_lvl2", "tower_sandworm_lvl1")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_TREMOR_LEVEL2"
tt.tower.level = 2
tt.tower.price = 220
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 157.5
tt.attacks.list[1].range = 157.5
tt.attacks.list[1].bullet = "bullet_tower_sandworm_lvl2"
tt.attacks.list[1].bullet_start_offset = v(2, 45)
tt.render.sprites[2].prefix = "worm_nest_level2"--3和4不需要动
tt.ui.click_rect = r(-30, 0, 60, 65)

tt = E:register_t("tower_sandworm_lvl3", "tower_sandworm_lvl1")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_TREMOR_LEVEL3"
tt.tower.level = 3
tt.tower.price = 270
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 165
tt.attacks.list[1].range = 165
tt.attacks.list[1].cooldown = 6
tt.attacks.list[1].bullet = "bullet_tower_sandworm_lvl3"
tt.attacks.list[1].bullet_start_offset = v(2, 50)
tt.render.sprites[2].prefix = "worm_nest_level3"--3和4不需要动
tt.ui.click_rect = r(-30, 0, 65, 70)

tt = E:register_t("tower_sandworm_lvl4", "tower_sandworm_lvl1")
E:add_comps(tt, "powers")
tt.info.enc_icon = 7
tt.info.i18n_key = "TOWER_TREMOR_LEVEL2"
tt.tower.level = 4
tt.tower.price = 350
tt.tower.menu_offset = v(0, 22)
tt.attacks.range = 177.5
tt.attacks.list[1].range = 177.5
tt.attacks.list[1].bullet = "bullet_tower_sandworm_lvl4"
tt.attacks.list[1].bullet_start_offset = v(2, 55)
tt.attacks.list[1].cooldown = 6.0 --应该和script有关
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].bullet = "tower_sandworm_eat"
tt.attacks.list[2].disabled = true
tt.attacks.list[2].cooldown = 45
tt.attacks.list[2].range = 300
tt.attacks.list[2].shoot_time = fts(75)
tt.attacks.list[2].animation = "instakill"
tt.attacks.list[2].bullet_start_offset = v(2, 55)
tt.attacks.list[2].node_prediction = fts(25)
tt.attacks.list[2].sound = "TowerArboreanEmissaryBasicAttack"
tt.attacks.list[2].vis_bans = bor(F_MINIBOSS, F_BOSS)
tt.attacks.list[3] = E:clone_c("bullet_attack")
tt.attacks.list[3].bullet = "tower_sandworm_spit"
tt.attacks.list[3].disabled = true
tt.attacks.list[3].cooldown = 14
tt.attacks.list[3].animation = "spit"
tt.attacks.list[3].range = 275
tt.attacks.list[3].shoot_time = fts(20)
tt.attacks.list[3].bullet_start_offset = v(2, 55)
tt.attacks.list[3].node_prediction = fts(25)
tt.attacks.list[3].vis_bans = bor(F_NIGHTMARE, F_FLYING)
tt.attacks.list[4] = E:clone_c("bullet_attack")
tt.attacks.list[4].bullet = "sandworm_skelebomb"
tt.attacks.list[4].cooldown = 14
tt.attacks.list[4].disabled = true
tt.attacks.list[4].range = 177.5
tt.attacks.list[4].vis_bans = bor(F_CLIFF, F_FLYING)
tt.render.sprites[2].prefix = "worm_nest_level4"--3和4不需要动

tt.ui.click_rect = r(-30, 0, 65, 70)
tt.powers.eat = CC("power")
tt.powers.eat.price_base = 255
tt.powers.eat.enc_icon = 372
tt.powers.eat.max_level = 1
tt.powers.eat.cooldown = 45
tt.powers.slime = CC("power")
tt.powers.slime.price_base = 127
tt.powers.slime.price_inc = 127
tt.powers.slime.cooldown = {14,12}
tt.powers.slime.max_level = 2
tt.powers.slime.enc_icon = 373
tt.powers.worm = CC("power")
tt.powers.worm.price_base = 144
tt.powers.worm.price_inc = 144
tt.powers.worm.max_level = 2
tt.powers.worm.enc_icon = 371
tt.powers.worm.cooldown = {14,10}

tt = E:register_t("fx_bullet_tower_sandworm_basic_hit", "fx")
tt.render.sprites[1].name = "worm_nest_level4_spit_decal_in"
tt.render.sprites[1].scale = v(1, 1)
tt.render.sprites[1].offset = v(0, 26)


tt = E:register_t("bullet_tower_sandworm_lvl1", "bombKR5")
AC(tt, "aura")
tt.bullet.level = 1
tt.main_script.update = kr4_scripts.tower_sandworm_bomb.update
tt.bullet.flight_time = fts(25)
tt.sound_events.insert = nil--"BombShootSound"
tt.sound_events.hit = "SandwormAttack"
tt.bullet.hit_fx = nil--"fx_bullet_tower_sandworm_basic_hit"
tt.bullet.pop = nil
tt.bullet.align_with_trajectory = true
tt.bullet.mod = "mod_tower_sandworm_lava"
tt.bullet.ignore_hit_offset = true
tt.bullet.pop_chance = 0.5
tt.bullet.rotation_speed = nil
tt.bullet.hit_payload = "aura_bullet_tower_sandworm"
tt.bullet.damage_max = 4
tt.bullet.damage_min = 4
tt.bullet.damage_every = 0.25
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_radius = 40
tt.bullet.aura_duration = {3.5,4,4.5,5}
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.render.sprites[1].name = nil
tt.render.sprites[1].anchor = v(0.4, 0.5)
tt.render.sprites[1].scale = v(1.5, 1.5)
--tt.bullet.particles_name = "ps_bullet_tower_sandworm_basic_trail"
tt.aura_duration = {3.5,4,4.5,5}

tt = E:register_t("ps_bullet_tower_sandworm_basic_trail")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "worm_nest_level4_spit_trail_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(11),
	fts(11)
}
tt.particle_system.emission_rate = 50
tt.particle_system.emit_rotation_spread = math.pi * 2

tt = E:register_t("fx_bullet_tower_sandworm_slime_hit", "fx")
tt.render.sprites[1].name = "worm_nest_level4_spit_decal_in"
tt.render.sprites[1].scale = v(1,1)
tt.render.sprites[1].offset = v(0, 0)

tt = E:register_t("tower_sandworm_spit", "bombKR5")
AC(tt, "aura")
tt.bullet.level = 1
tt.main_script.update = kr4_scripts.tower_sandworm_bomb.update
tt.bullet.flight_time = fts(25)
tt.sound_events.insert = "sandwormSpit"
tt.sound_events.hit = "sandwormSpitSplat"
tt.bullet.hit_fx = "fx_bullet_tower_sandworm_slime_hit"
tt.bullet.pop = nil
tt.bullet.align_with_trajectory = true
tt.bullet.mod = nil--"mod_tower_sandworm_lava"
tt.bullet.ignore_hit_offset = true
tt.bullet.pop_chance = 0.5
tt.bullet.rotation_speed = nil
tt.bullet.hit_payload = "aura2_bullet_tower_sandworm"
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_min_inc = 0
tt.bullet.damage_max_inc = 0
tt.bullet.damage_every = 0.25
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_radius = 60
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "worm_nest_level4_spit_proyectile"
tt.render.sprites[1].anchor = v(0.4, 0.5)
tt.render.sprites[1].scale = v(1, 1)
tt.bullet.particles_name = "ps_bullet_tower_sandworm_basic_trail"
tt.aura_duration = {5, 6}

tt = E:register_t("worm_nest_level4_instakill_run", "fx")
tt.render.sprites[1].name = "worm_nest_level4_instakill_run"
tt.render.sprites[1].scale = v(1,1)
tt.render.sprites[1].offset = v(0, 26)

tt = E:register_t("tower_sandworm_eat", "bombKR5")
AC(tt, "aura")
tt.bullet.level = 1
tt.main_script.update = kr4_scripts.tower_sandworm_bomb.update
tt.bullet.flight_time = fts(25)
tt.sound_events.insert = nil--"sandwormSpit"
tt.sound_events.hit = "sandwormEat"
tt.bullet.hit_fx = "worm_nest_level4_instakill_run"
tt.bullet.pop = nil
tt.bullet.align_with_trajectory = true
tt.bullet.mod = nil--"mod_tower_sandworm_lava"
tt.bullet.ignore_hit_offset = true
tt.bullet.pop_chance = 0.5
tt.bullet.rotation_speed = nil
tt.bullet.hit_payload = nil--"aura2_bullet_tower_sandworm"
tt.bullet.damage_max = 9999999
tt.bullet.damage_min = 9999999
tt.bullet.damage_every = 0.25
tt.bullet.damage_type = bor(DAMAGE_EAT, DAMAGE_NO_SPAWNS)
tt.bullet.damage_radius = 40
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = nil--"worm_nest_level4_spit_proyectile"
tt.render.sprites[1].anchor = v(0.4, 0.5)
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.bullet.particles_name = nil--"ps_bullet_tower_sandworm_basic_trail"
tt.aura_duration = nil

tt = E:register_t("bullet_tower_sandworm_lvl2", "bullet_tower_sandworm_lvl1")
tt.bullet.level = 2
tt.bullet.damage_max = 9
tt.bullet.damage_min = 9
tt.bullet.damage_every = 0.25

tt = E:register_t("bullet_tower_sandworm_lvl3", "bullet_tower_sandworm_lvl1")
tt.bullet.level = 3
tt.bullet.damage_max = 14--13
tt.bullet.damage_min = 14--13
tt.bullet.damage_every = 0.25

tt = E:register_t("bullet_tower_sandworm_lvl4", "bullet_tower_sandworm_lvl1")
tt.bullet.level = 4
tt.bullet.damage_max = 19--18
tt.bullet.damage_min = 19--18
tt.bullet.damage_every = 0.25

tt = E:register_t("mod_tower_sandworm_slow", "mod_slow")
tt.balance_slow_factor = 1
tt.balance_duration = 0
tt.slow.factor = nil
tt.modifier.duration = nil

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.balance_slow_factor
	this.modifier.duration = this.balance_duration

	return scripts.mod_slow.insert(this, store, script)
end

tt = E:register_t("aura_bullet_tower_sandworm", "aura")

E:add_comps(tt, "render", "tween")

tt.aura.mod = "mod_tower_sandworm_slow"
tt.aura.radius = 50
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.cycle_time = fts(5)
tt.render.sprites[1].prefix = "worm_nest_attack"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.aura_sandworm_apply_mod.insert
tt.main_script.update = scripts.aura_sandworm_apply_mod.update
tt.tween.props[1].name = "alpha"
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		tt.aura.duration - 0.5,
		255
	},
	{
		tt.aura.duration,
		0
	}
}

tt = E:register_t("mod2_tower_sandworm_slow", "mod_slow")
tt.balance_slow_factor = {0.5,0.3}
tt.balance_duration = 0.3
tt.slow.factor = nil
tt.modifier.duration = nil

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.balance_slow_factor[this.modifier.level]
	this.modifier.duration = this.balance_duration

	return scripts.mod_slow.insert(this, store, script)
end

--减速效果
tt = E:register_t("aura2_bullet_tower_sandworm", "aura")

E:add_comps(tt, "render", "tween")

tt.aura.mod = "mod2_tower_sandworm_slow"
tt.aura.radius = 50
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.cycle_time = fts(5)
tt.render.sprites[1].prefix = "worm_nest_level4_spit_decal"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.tween.props[1].name = "alpha"
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		tt.aura.duration - 0.5,
		255
	},
	{
		tt.aura.duration,
		0
	}
}

tt = E:register_t("mod_tower_sandworm_lava", "bullet")
tt.main_script.update = kr4_scripts.tower_sandworm_lava.update

tt.bullet.damage_type = DAMAGE_EXPLOSION

tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_radius = 50
tt.bullet.damage_bans = bor(F_FLYING)
tt.bullet.damage_flags = F_AREA
--tt.sound_events.insert = "blazing_watcher_explosion"


tt = RT("sandworm_skelebomb2", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = 0.01
tt.bullet.fragment_count = 1
tt.bullet.fragment_name = "sandworm_skelefrag2"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.fragment_node_spread = 0
tt.bullet.fragment_pos_spread = v(0, 0)
tt.bullet.dest_pos_offset = v(0, 1)
tt.bullet.dest_prediction_time = 0
tt.main_script.insert = kr1_scripts.bomb_cluster.insert
tt.main_script.update = kr4_scripts.sandworm_skeleflingerbomb.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("sandworm_skelefrag2", "bomb")
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
tt.bullet.hit_payload = "sandworm_skelespawn2"
tt.main_script.update = kr4_scripts.bomb_kro_sw.update
tt.bullet.hit_fx = nil
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("sandworm_skelespawn2", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = kr4_scripts.enemies_skelespawner_sw.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = nil
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.check_node_valid = true
tt.spawner.use_node_pos = true
tt.spawner.entity = "soldier_flingers_skeleton_warrior_sw"
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

tt = RT("sandworm_skelebomb", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = 0.01
tt.bullet.fragment_count = 1
tt.bullet.fragment_name = "sandworm_skelefrag"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.fragment_node_spread = 0
tt.bullet.fragment_pos_spread = v(0, 0)
tt.bullet.dest_pos_offset = v(0, 1)
tt.bullet.dest_prediction_time = 0
tt.main_script.insert = kr1_scripts.bomb_cluster.insert
tt.main_script.update = kr4_scripts.sandworm_skeleflingerbomb.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("sandworm_skelefrag", "bomb")
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
tt.bullet.hit_payload = "sandworm_skelespawn"
tt.main_script.update = kr4_scripts.bomb_kro_sw.update
tt.bullet.hit_fx = nil
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("sandworm_skelespawn", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = kr4_scripts.enemies_skelespawner_sw.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = nil
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "soldier_flingers_skeleton_sw"
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


tt = E:register_t("soldier_flingers_skeleton_sw", "unit")

E:add_comps(tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events")

anchor_y = 0.2
image_y = 36
tt.info.portrait = "gui4_bottom_info_image_soldiers_0058"
tt.health.armor = 0
tt.health.hp_inc = 0
tt.health.hp_max = 80
tt.health_bar.offset = v(0, 30)
tt.info.fn = kr4_scripts.soldier_flingers_skeleton_sw.get_info
tt.info.i18n_key = "SOLDIER_SANDWORM_SKELETON"
tt.main_script.insert = kr4_scripts.soldier_flingers_skeleton_sw.insert
tt.main_script.update = kr4_scripts.soldier_flingers_skeleton_sw.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 8
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 60
tt.motion.max_speed = 35
tt.nav_path.dir = -1
tt.render.sprites[1].anchor.y = 0.42
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "worm_nest_level4_tremor"
tt.soldier.melee_slot_offset.x = 5
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_LYCAN)
tt.vis.flags = F_FRIEND
tt.sound_events.insert = "sandwormUpgTaunt"
tt.sound_events.death = "sandwormSkillATaunt"

tt = E:register_t("soldier_flingers_skeleton_warrior_sw", "soldier_flingers_skeleton_sw")
tt.health.hp_max = 120
tt.info.i18n_key = "SOLDIER_SANDWORM_SKELETON_2"
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 8
tt.sound_events.insert = "sandwormUpgTaunt"
tt.sound_events.death = "sandwormSkillATaunt"

tt = E:register_t("high_elven_sentinel_dd", "decal_scripted")

E:add_comps(tt, "force_motion", "ranged", "tween")

tt.charge_time = 15
tt.flight_height = 50
tt.force_motion.max_a = 135000
tt.force_motion.max_v = 450
tt.force_motion.ramp_radius = 10
tt.main_script.update = kr4_scripts.high_elven_sentinel_dd.update
tt.owner = nil
tt.owner_idx = nil
tt.tower_rotation_speed = 7.5 * math.pi / 180 * 30
tt.tower_rotation_offset = v(0, -6)
tt.tower_rotation_radius = 20
tt.wait_time = 5
tt.wait_spent_time = 1
tt.particles_name = "ps_high_elven_sentinel_dd"
tt.ranged.attacks[1].bullet = "ray_high_elven_sentinel_dd"
tt.ranged.attacks[1].shoot_time = fts(9)
tt.ranged.attacks[1].cooldown = 0.75
tt.ranged.attacks[1].search_cooldown = 0.25
tt.ranged.attacks[1].shoot_range = 25
tt.ranged.attacks[1].launch_range = 300
tt.ranged.attacks[1].max_range = 200
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet_start_offset = v(0, 0)
tt.ranged.attacks[1].vis_flags = F_RANGED
tt.ranged.attacks[1].vis_bans = 0
tt.ranged.attacks[1].max_shots = 5
tt.render.sprites[1].prefix = "deep_devils_reef_tower_storm_cloud"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].draw_order = 4
--tt.render.sprites[2] = E:clone_c("sprite")
--tt.render.sprites[2].animated = false
--tt.render.sprites[2].name = "decal_flying_shadow"
--tt.render.sprites[2].offset = v(0, 0)
--tt.render.sprites[2].hidden = true
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
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		v(0.75, 1)
	},
	{
		fts(10),
		v(1, 1)
	}
}
tt.tween.props[2].name = "scale"

tt = E:register_t("ray_high_elven_sentinel_dd", "bullet")
tt.image_width = 72
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].name = "deep_devils_reef_tower_storm_bolt_travel"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.mod = "mod_ray_high_elven_sentinel_hit_dd"
tt.bullet.damage_min = 25
tt.bullet.damage_max = 25
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_time = fts(4)
tt.sound_events.insert = "DeepDevilLightning"

tt = E:register_t("ray_high_elven_sentinel_dd1", "ray_high_elven_sentinel_dd")

tt = E:register_t("ray_high_elven_sentinel_dd2", "ray_high_elven_sentinel_dd1")
tt.bullet.damage_min = 50
tt.bullet.damage_max = 50

tt = E:register_t("ray_high_elven_sentinel_dd3", "ray_high_elven_sentinel_dd1")
tt.bullet.damage_min = 75
tt.bullet.damage_max = 75

tt = E:register_t("mod_ray_high_elven_sentinel_hit_dd", "mod_stun")
tt.modifier.duration = 0.5
tt.render.sprites[1].prefix = "deep_devils_reef_tower_storm_bolt_hit"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].size_scales = {
	vv(1.0),
	vv(1.3),
	vv(1.8)
}
tt.modifier.vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING)
tt.increase = 5

tt = E:register_t("ps_high_elven_sentinel_dd")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "mage_highElven_balls_0020"
tt.particle_system.animated = false
tt.particle_system.alphas = {
	200,
	0
}
tt.particle_system.particle_lifetime = {
	fts(5),
	fts(5)
}
tt.particle_system.scales_y = {
	0.8,
	0.8
}
tt.particle_system.scales_x = {
	0.8,
	0.8
}
tt.particle_system.emission_rate = 60
tt.particle_system.z = Z_OBJECTS
tt.particle_system.draw_order = 4
tt.particle_system.sort_y = nil

--南瓜灯杰克
--The code is borrowed from painlessdeath.
tt = E:register_t("KR5Bomb", "bombKR5")
tt.bullet.pop_chance = 0
tt.main_script.insert = kr4_scripts.KR5Bomb.insert
tt.main_script.update = kr4_scripts.KR5Bomb.update

tt = E:register_t("entities_delay_controller")
E:add_comps(tt, "pos", "main_script", "sound_events")
tt.main_script.update = kr4_scripts.entities_delay_controller.update
tt.start_ts = nil
tt.delays = nil
tt.entities = nil

--tt = E:register_t("controller_item_hero_jack_o_lantern", "controller_item_hero")
--tt.entity = "hero_jack_o_lantern"

tt = E:register_t("hero_jack_o_lantern", "hero5")
E:add_comps(tt, "melee", "timed_attacks", "teleport")
tt.hero.level_stats.hp_max = {
	210,--175,
	230,--192,
	252,--210,
	273,--228,
	294,--245,
	314,--262,
	336,--280,
	358,--298,
	378,--315,
	400,--333
}
tt.hero.level_stats.regen_health = {
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40,
	42
}
tt.hero.level_stats.armor = {
	0.05,
	0.09,
	0.13,
	0.17,
	0.21,
	0.25,
	0.29,
	0.33,
	0.37,
	0.41
}
tt.hero.level_stats.melee_damage_min = {
	12,
	15,
	19,
	22,
	29,--26,
	34,--30,
	37,--33,
	42,--37,
	46,--40,
	50,--44
}
tt.hero.level_stats.melee_damage_max = {
	20,
	27,
	33,
	40,
	52,--46,
	59,--52,
	67,--59,
	74,--65,
	82,--72,
	90,--79
}
-- explosive_head
tt.hero.skills.explosive_head = E:clone_c("hero_skill")
tt.hero.skills.explosive_head.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.explosive_head.hr_order = 1
tt.hero.skills.explosive_head.hr_available = true
tt.hero.skills.explosive_head.damage = {
	36,
	74,
	115
}
tt.hero.skills.explosive_head.key = "EXPLOSIVE_HEAD"
tt.hero.skills.explosive_head.xp_gain = {
	60,
	60,
	60
}
-- haunted_blade
tt.hero.skills.haunted_blade = E:clone_c("hero_skill")
tt.hero.skills.haunted_blade.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.haunted_blade.hr_order = 2
tt.hero.skills.haunted_blade.hr_available = true
tt.hero.skills.haunted_blade.cooldown = {
	16,
	8,
	4
}
tt.hero.skills.haunted_blade.xp_gain = {
	135,
	270,
	405
}
tt.hero.skills.haunted_blade.key = "HAUNTED_BLADE"
-- hero_jacko_melee
tt.hero.skills.hero_jacko_melee = E:clone_c("hero_skill")
tt.hero.skills.hero_jacko_melee.hr_cost = {
	2,
	1,
	1
}
tt.hero.skills.hero_jacko_melee.accumulated_damage_factor = {
	0.2,
	0.4,
	0.6
}
tt.hero.skills.hero_jacko_melee.hr_order = 3
tt.hero.skills.hero_jacko_melee.hr_available = true
tt.hero.skills.hero_jacko_melee.key = "HERO_JACKO_MELEE"
-- hero_jacko_thriller
tt.hero.skills.hero_jacko_thriller = E:clone_c("hero_skill")
tt.hero.skills.hero_jacko_thriller.hr_cost = {
	3,
	2,
	2
}
tt.hero.skills.hero_jacko_thriller.hr_order = 4
tt.hero.skills.hero_jacko_thriller.hr_available = true
tt.hero.skills.hero_jacko_thriller.max_bullets = {
	2,
	3,
	4
}
tt.hero.skills.hero_jacko_thriller.xp_gain = {
	150,
	300,
	450
}
tt.hero.skills.hero_jacko_thriller.key = "HERO_JACKO_THRILLER"
-- ultimate
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_cost = {
	6,
	5,
	5
}
tt.hero.skills.ultimate.controller_name = "hero_jack_o_lantern_ultimate"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_available = true
tt.hero.skills.ultimate.key = "ULTIMATE"
tt.hero.skills.ultimate.cooldown = {
	[0] = 40,
	40,
	40,
	40
}
tt.hero.skills.ultimate.damage_over_time = {
	[0] = 6,
	10,
	20,
	30
}
tt.hero.skills.ultimate.max_range = 250
tt.hero.skills.ultimate.range_nodes_max = 45
tt.hero.skills.ultimate.min_targets = 5

tt.hero.team = TEAM_DARK_ARMY
tt.hero.fn_level_up = kr4_scripts.hero_jack_o_lantern.level_up
tt.hero.tombstone_show_time = nil
tt.hero.tombstone_decal = nil
tt.hero.use_custom_spawn_point = true
tt.hero.death_loop_animation = "idleDeath"
tt.health.dead_lifetime = 20
tt.health.accumulated_damage_factor = 0
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 53)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.z = Z_FLYING_HEROES
tt.idle_flip.chance = 0
tt.info.fn = scripts.hero_basic.get_info_melee
-- tt.info.hero_portrait = "hero_portraits_0120"
tt.info.hero_portrait = "kra_hero_portraits_0414"
tt.info.i18n_key = "HERO_JACK_O_LANTERN"
tt.info.portrait = "gui4_bottom_info_image_heroes_0017"
tt.info.ultimate_icon = "0414"
tt.info.stat_hp = 5
tt.info.stat_armor = 4
tt.info.stat_damage = 10
tt.info.stat_cooldown = 4
tt.main_script.update = kr4_scripts.hero_jack_o_lantern.update
tt.motion.max_speed = 80
tt.drag_line_origin_offset = v(0, 0)
tt.regen.cooldown = 2
tt.render.sprites[1].anchor.y = 0.281
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_jack_o_lantern"
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].name = "hero_jack_o_lantern_shadow"
tt.render.sprites[2].anchor.y = 0.281
tt.render.sprites[2].z = Z_DECALS + 1
tt.sound_events.change_rally_point = "group_hero_jacko_taunt"
tt.sound_events.death = "hero_jacko_taunt_death"
tt.sound_events.respawn = "HeroLevelUp"
tt.sound_events.insert = "hero_jacko_taunt_1"
tt.sound_events.hero_room_select = "hero_jacko_taunt_1"
tt.teleport.min_distance = 150
tt.teleport.delay = 0
tt.teleport.sound = "group_hero_jacko_teleport"
tt.teleport.animations = {
	"teleportOut",
	"teleportIn"
}
tt.teleport.fx_out = "hero_jack_o_lantern_teleportfx"
tt.ui.click_rect = r(-29, -5, 58, 105)
tt.unit.head_offset = v(0, 48)
tt.unit.hit_offset = v(0, 30)
tt.unit.mod_offset = v(0, 30)
tt.unit.hide_after_death = nil
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET)
tt.soldier.melee_slot_offset = v(25, 0)
tt.melee.range = 60
tt.melee.attacks[1].basic_attack = true
tt.melee.attacks[1].fn_damage = function(this, store, attack, target)
	local value = math.ceil(this.unit.damage_factor * math.random(attack.damage_min, attack.damage_max)) + this.health.accumulated_damage
	this.health.accumulated_damage = 0
	return value
end
tt.melee.attacks[1].damage_min = 180
tt.melee.attacks[1].damage_max = 180
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].xp_gain_factor = 20
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].basic_attack = nil
tt.melee.attacks[2].animation = "hauntedBlade"
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].damage_type = DAMAGE_MAGICAL
tt.melee.attacks[2].cooldown = 4
tt.melee.attacks[2].mod = "mod_hero_jacko_reduce_armor"
-- tt.melee.attacks[2].xp_gain_factor = 270
-- explosive_head
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].skill = "range_unit"
tt.timed_attacks.list[1].disabled = true
--tt.timed_attacks.list[1].search_type = U.search_type.find_max_crowd
tt.timed_attacks.list[1].min_targets = 1
tt.timed_attacks.list[1].bullet = "bomb_explosive_head"
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 175
tt.timed_attacks.list[1].cooldown = 4
tt.timed_attacks.list[1].extra_cooldown = -5
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].node_prediction = fts(22)
tt.timed_attacks.list[1].animation = "explosiveHead"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(22, 36)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND, F_NIGHTMARE, F_CLIFF)
tt.timed_attacks.list[1].xp_from_skill = "explosive_head"
-- hero_jacko_thriller
tt.timed_attacks.list[2] = E:clone_c("bullet_attack")
tt.timed_attacks.list[2].skill = "range_at_path"
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].use_center = nil
tt.timed_attacks.list[2].bullet = "hero_jack_o_lantern_spawner_seed"
tt.timed_attacks.list[2].max_bullets = 4
tt.timed_attacks.list[2].range_nodes = 25
tt.timed_attacks.list[2].min_targets = 2
tt.timed_attacks.list[2].cooldown = 30
tt.timed_attacks.list[2].min_nodes = -3
tt.timed_attacks.list[2].max_nodes = -1
tt.timed_attacks.list[2].cast_time = fts(10)
tt.timed_attacks.list[2].animation = "spawnGhouls"
tt.timed_attacks.list[2].bullet_start_offset = {
	v(19, 55)
}
tt.timed_attacks.list[2].vis_bans = bor(F_FRIEND, F_FLYING)
tt.timed_attacks.list[2].xp_from_skill = "hero_jacko_thriller"

tt = RT("mod_damage_magical_armor", "mod_damage")
tt.damage_min = 0.01
tt.damage_max = 0.01
tt.damage_type = bor(DAMAGE_MAGICAL_ARMOR, DAMAGE_NO_SHIELD_HIT)

tt = RT("mod_hero_jacko_reduce_armor", "mod_damage_magical_armor")
tt.damage_min = 1
tt.damage_max = 1

tt = E:register_t("hero_jack_o_lantern_teleportfx", "fx")
tt.render.sprites[1].name = "hero_jack_o_lantern_teleportfx_run"
tt.render.sprites[1].anchor.y = 0.281

tt = E:register_t("bomb_explosive_head", "KR5Bomb")
tt.bullet.damage_min = 120
tt.bullet.damage_max = 120
tt.bullet.damage_radius = 75
tt.bullet.flight_time = fts(20)
tt.bullet.rotation_speed = 3 * FPS * math.pi / 20
tt.bullet.pop_chance = 0.1
tt.sound_events.insert = "ArrowSound"
tt.bullet.hit_fx = "fx_hero_jack_o_lantern_explosion"
tt.bullet.hit_fx_air = "fx_hero_jack_o_lantern_explosion"
tt.bullet.hit_fx_water = "fx_hero_jack_o_lantern_explosion"
tt.render.sprites[1].name = "hero_jack_o_lantern_head_proyectile"

tt = E:register_t("fx_hero_jack_o_lantern_explosion", "fx")
tt.render.sprites[1].name = "hero_jack_o_lantern_explotion_run"
tt.render.sprites[1].anchor.y = 0.169
tt.render.sprites[1].sort_y_offset = -2

tt = E:register_t("hero_jack_o_lantern_spawner_seed", "KR5Bomb")
tt.bullet.damage_min = 64
tt.bullet.damage_max = 64
tt.bullet.damage_radius = 50
tt.bullet.flight_time = fts(22)
tt.bullet.rotation_speed = 2 * FPS * math.pi / 22
tt.bullet.hit_fx = "fx_hero_jack_o_lantern_spawner_hit"
tt.bullet.hit_fx_water = "fx_hero_jack_o_lantern_spawner_hit"
tt.bullet.hit_decal = "hero_jack_o_lantern_spawner_seed_decal"
tt.bullet.hit_payload = "hero_jacko_ghoul"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt.render.sprites[1].name = "hero_jack_o_lantern_spawner_seed_travel"
tt.render.sprites[1].animated = true

tt = E:register_t("fx_hero_jack_o_lantern_spawner_hit", "fx_fade")
tt.render.sprites[1].name = "hero_jack_o_lantern_spawner_hit_run"
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(56),
		255
	},
	{
		fts(71),
		0
	}
}

tt = E:register_t("hero_jack_o_lantern_spawner_seed_decal", "decal_timed")
tt.render.sprites[1].name = "hero_jack_o_lantern_spawner_seed_decal_run"
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].z = Z_DECALS


tt = RT("soldier_hover", "soldier_militia")
E:add_comps(tt, "nav_path", "tween")
tt.hover = {}
tt.hover.oni = 1
tt.hover.ts = 0
tt.hover.cooldown_min = 10
tt.hover.cooldown_max = 10
tt.hover.random_ni = 0
tt.hover.random_subpath = true
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
tt.tween.disabled = true
tt.fade_in = nil
tt.fade_out = nil
tt.main_script.update = kr4_scripts.soldier_hover.update


tt = RT("hero_jacko_ghoul", "soldier_hover")
E:add_comps(tt, "reinforcement")
tt.health.armor = 0.2
tt.health.magic_armor = 0
tt.health.hp_max = 320
tt.health_bar.offset = v(0, 32)
tt.unit.hit_offset = v(0, 16)
tt.unit.head_offset = v(0, 29)
tt.unit.mod_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.info.fn = scripts.soldier_reinforcement.get_info
--tt.info.portrait = "bottom_info_image_soldiers_0048"
tt.info.random_name_format = nil
tt.info.random_name_count = nil
tt.motion.max_speed = 30
tt.render.sprites[1].prefix = "hero_jack_o_lantern_ghoul"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = 0.125
tt.render.sprites[1].angles.walk = {
	"walk",
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_jack_o_lantern_ghoul_shadow"
tt.render.sprites[2].anchor.y = 0.125
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(16, 0)
tt.melee.range = 75
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(9)
tt.regen.health = 0
tt.regen.cooldown = 2
tt.reinforcement.duration = 20
tt.ui.click_rect = r(-20, -5, 40, 28)
tt.hover.cooldown_min = 5
tt.hover.cooldown_max = 15
tt.hover.random_ni = 6
tt.fade_out = true
tt.insert_delay = 1.2

tt = E:register_t("hero_jack_o_lantern_ultimate")
E:add_comps(tt, "pos", "main_script", "sound_events")
tt.can_fire_fn = kr4_scripts.summoning_hero_ultimate.can_fire_fn
tt.main_script.update = kr4_scripts.hero_jack_o_lantern_ultimate.update
tt.cooldown = 40
tt.entity = "hero_jacko_horse"
tt.sound_events.insert = "hero_jacko_horses"


tt = RT("aura_wander", "aura")
AC(tt, "nav_path", "motion", "render", "sound_events", "tween")
tt.render.sprites[1].name = "walk"
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].z = Z_DECALS + 1
tt.main_script.update = scripts.aura_wander.update
tt.nav_path.dir = -1
tt.nav_path.pi = 1
tt.nav_path.spi = 1
tt.nav_path.ni = 1
tt.motion.max_speed = 50
tt.aura.duration = 10
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = 0
tt.aura.cycle_time = 0.1
tt.aura.radius = 60
tt.aura.damage_min = 0
tt.aura.damage_max = 0
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.hit_blood_fx = nil
tt.spawn_animation = "spawn"
tt.death_animation = "death"
tt.dead_lifetime = 5
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
tt.tween.disabled = true
tt.fade_in = nil
tt.fade_out = nil


tt = RT("hero_jacko_horse", "aura_wander")
tt.render.sprites[1].prefix = "hero_jack_o_lantern_ultimate_horse"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = 0.3
tt.render.sprites[1].sort_y_offset = -32
tt.render.sprites[2] = nil
tt.motion.max_speed = 90
tt.aura.duration = 4
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.cycle_time = 0.25
tt.aura.radius = 65
tt.aura.damage_min = 0
tt.aura.damage_max = 0
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.mods = {
	"mod_hero_jacko_horse_intimidation"
}
tt.aura.hit_blood_fx = nil
tt.spawn_animation = nil
tt.death_animation = nil
tt.dead_lifetime = nil
tt.fade_in = true
tt.fade_out = true
tt.particle = {
	"ps_hero_jack_o_lantern_ultimate_particle",
	"ps_hero_jack_o_lantern_ultimate_smoke"
}

tt = E:register_t("ps_hero_jack_o_lantern_ultimate_particle")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "hero_jack_o_lantern_ultimate_particle_run"
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.track_offset = v(0, 29)
tt.particle_system.emission_rate = 3
tt.particle_system.animation_fps = 30
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.z = Z_OBJECTS + 1

tt = E:register_t("ps_hero_jack_o_lantern_ultimate_smoke")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "hero_jack_o_lantern_ultimate_smoke_run"
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.track_offset = v(0, 29)
tt.particle_system.emission_rate = 2
tt.particle_system.animation_fps = 46
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.z = Z_OBJECTS + 2


tt = E:register_t("mod_intimidation", "modifier")
tt.speed_factor = 1
tt.modifier.vis_flags = bor(F_MOD, F_EAT)
tt.modifier.vis_bans = bor(F_BOSS, F_WATER)
tt.main_script.insert = kr4_scripts.mod_intimidation.insert
tt.main_script.remove = kr4_scripts.mod_intimidation.remove


tt = RT("mod_hero_jacko_horse_intimidation", "mod_intimidation")
E:add_comps(tt, "render")
tt.modifier.duration = fts(8)
tt.modifier.health_bar_offset = v(0, -8)
tt.speed_factor = 1.2
tt.main_script.update = kr4_scripts.mod_track_target_with_fade.update
tt.render.sprites[1].name = "hero_jack_o_lantern_ultimate_fear_modifier_run"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].loop = true
tt.render.sprites[1].draw_order = DO_MOD_FX
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.3),
	vv(1.5)
}