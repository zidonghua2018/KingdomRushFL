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
local kr4_scripts = require("game_scripts-45h")
local customScripts0 = require("custom_scripts_0")

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


--本文件：使用5代底层代码实现4代英雄
----------------------------------------------
--------------------维鲁克---------------------
----------------------------------------------
tt = RT("hero_orc", "hero")

AC(tt, "melee", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.health.dead_lifetime = 16
tt.melee.range = 65
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_orc.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0401"
tt.info.i18n_key = "HERO_VERUK"
tt.info.ultimate_icon = "0401"
tt.motion.max_speed = 2.5 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.duelist = E:clone_c("hero_skill")
tt.hero.skills.duelist.hr_order = 1
tt.hero.skills.duelist.hr_cost = {3,3,3}
tt.hero.skills.brute_force = E:clone_c("hero_skill")
tt.hero.skills.brute_force.hr_order = 2
tt.hero.skills.brute_force.hr_cost = {1,2,3}
tt.hero.skills.aimed_slash = E:clone_c("hero_skill")
tt.hero.skills.aimed_slash.hr_order = 3
tt.hero.skills.aimed_slash.hr_cost = {2,3,4}
tt.hero.skills.inspiring_leader = E:clone_c("hero_skill")
tt.hero.skills.inspiring_leader.hr_order = 4
tt.hero.skills.inspiring_leader.hr_cost = {1,2,3}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {2,2,2}

tt.hero.level_stats.armor = {
	0.03,
	0.06,
	0.09,
	0.12,
	0.15,
	0.18,
	0.21,
	0.24,
	0.27,
	0.3
}
tt.hero.level_stats.hp_max = {
	240,
	276,
	312,
	348,
	384,
	420,
	456,
	492,
	528,
	564
}
tt.hero.level_stats.melee_damage_max = {
	12,
	16,
	19,
	23,
	26,
	29,
	33,
	36,
	40,
	43
}
tt.hero.level_stats.melee_damage_min = {
	4,
	5,
	6,
	8,
	9,
	10,
	11,
	12,
	13,
	14
}
tt.hero.level_stats.regen_health = {
	20,
	23,
	26,
	29,
	32,
	35,
	38,
	41,
	44,
	47
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1

----------------------------------------------
--------------------阿斯拉---------------------
----------------------------------------------
tt = RT("hero_asra", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.health.dead_lifetime = 16
tt.melee.range = 60
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_asra.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0402"
tt.info.i18n_key = "HERO_ASRA"
tt.info.ultimate_icon = "0402"
tt.motion.max_speed = 2.5 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.spider_bite = E:clone_c("hero_skill")
tt.hero.skills.spider_bite.hr_order = 1
tt.hero.skills.spider_bite.hr_cost = {5,4,3}
tt.hero.skills.onix_arrows = E:clone_c("hero_skill")
tt.hero.skills.onix_arrows.hr_order = 2
tt.hero.skills.onix_arrows.hr_cost = {2,2,2}
tt.hero.skills.quiver_of_sorrow = E:clone_c("hero_skill")
tt.hero.skills.quiver_of_sorrow.hr_order = 3
tt.hero.skills.quiver_of_sorrow.hr_cost = {1,1,1}
tt.hero.skills.shield_of_shadows = E:clone_c("hero_skill")
tt.hero.skills.shield_of_shadows.hr_order = 4
tt.hero.skills.shield_of_shadows.hr_cost = {2,2,2}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {3,3,3}

tt.hero.level_stats.armor = {
	0.06,
	0.07,
	0.08,
	0.09,
	0.10,
	0.11,
	0.12,
	0.13,
	0.14,
	0.15
}
tt.hero.level_stats.hp_max = {
	120,
	144,
	168,
	192,
	216,
	240,
	264,
	288,
	312,
	336
}
tt.hero.level_stats.melee_damage_max = {
	9,
	11,
	13,
	16,
	18,
	20,
	23,
	25,
	27,
	29
}
tt.hero.level_stats.melee_damage_min = {
	6,
	8,
	9,
	11,
	12,
	13,
	14,
	17,
	18,
	19
}
tt.hero.level_stats.ranged_damage_max = {
	14,
	16,
	18,
	20,
	23,
	26,
	28,
	32,
	34,
	36
}
tt.hero.level_stats.ranged_damage_min = {
	9,
	10,
	11,
	13,
	16,
	17,
	19,
	20,
	23,
	24
}
tt.hero.level_stats.regen_health = {
	10,
	12,
	15,
	17,
	20,
	22,
	25,
	27,
	30,
	33
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_asra"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_asra", "arrow")

----------------------------------------------
--------------------奥洛克---------------------
----------------------------------------------
tt = RT("hero_oloch", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 50
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 16
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_oloch.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0403"
tt.info.i18n_key = "HERO_OLOCH"
tt.info.ultimate_icon = "0403"
tt.motion.max_speed = 1.8 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.duplication = E:clone_c("hero_skill")
tt.hero.skills.duplication.hr_order = 1
tt.hero.skills.duplication.hr_cost = {4,4,4}
tt.hero.skills.magma_eruption = E:clone_c("hero_skill")
tt.hero.skills.magma_eruption.hr_order = 2
tt.hero.skills.magma_eruption.hr_cost = {2,2,2}
tt.hero.skills.hellish_infusion = E:clone_c("hero_skill")
tt.hero.skills.hellish_infusion.hr_order = 3
tt.hero.skills.hellish_infusion.hr_cost = {1,2,3}
tt.hero.skills.demonic_blast = E:clone_c("hero_skill")
tt.hero.skills.demonic_blast.hr_order = 4
tt.hero.skills.demonic_blast.hr_cost = {2,2,2}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {1,2,3}

tt.hero.level_stats.armor = {
	0.06,
	0.07,
	0.08,
	0.09,
	0.10,
	0.11,
	0.12,
	0.13,
	0.14,
	0.15
}
tt.hero.level_stats.hp_max = {
	120,
	144,
	168,
	192,
	216,
	240,
	264,
	288,
	312,
	336
}
tt.hero.level_stats.melee_damage_max = {
	9,
	11,
	13,
	16,
	18,
	20,
	23,
	25,
	27,
	29
}
tt.hero.level_stats.melee_damage_min = {
	6,
	8,
	9,
	11,
	12,
	13,
	14,
	17,
	18,
	19
}
tt.hero.level_stats.ranged_damage_max = {
	12,
	16,
	20,
	24,
	28,
	33,
	37,
	42,
	48,
	52
}
tt.hero.level_stats.ranged_damage_min = {
	6,
	8,
	10,
	12,
	14,
	18,
	20,
	23,
	25,
	28
}
tt.hero.level_stats.regen_health = {
	16,
	17,
	18,
	20,
	21,
	22,
	24,
	25,
	27,
	28
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_oloch"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_oloch", "bolt")


----------------------------------------------
--------------------特拉敏---------------------
----------------------------------------------
tt = RT("hero_tramin", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 55
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 16
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_tramin.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0404"
tt.info.i18n_key = "HERO_TRAMIS"
tt.info.ultimate_icon = "0404"
tt.motion.max_speed = 1.7 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.bombots = E:clone_c("hero_skill")
tt.hero.skills.bombots.hr_order = 1
tt.hero.skills.bombots.hr_cost = {2,2,2}
tt.hero.skills.nitro_rush = E:clone_c("hero_skill")
tt.hero.skills.nitro_rush.hr_order = 2
tt.hero.skills.nitro_rush.hr_cost = {2,2,2}
tt.hero.skills.flashbang = E:clone_c("hero_skill")
tt.hero.skills.flashbang.hr_order = 3
tt.hero.skills.flashbang.hr_cost = {1,2,3}
tt.hero.skills.rocket_barrage = E:clone_c("hero_skill")
tt.hero.skills.rocket_barrage.hr_order = 4
tt.hero.skills.rocket_barrage.hr_cost = {2,3,4}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {3,3,3}

tt.hero.level_stats.armor = {
	0.02,
	0.04,
	0.06,
	0.08,
	0.11,
	0.14,
	0.16,
	0.19,
	0.21,
	0.24
}
tt.hero.level_stats.hp_max = {
	180,
	204,
	228,
	252,
	276,
	300,
	324,
	348,
	372,
	396
}
tt.hero.level_stats.melee_damage_max = {
	4,
	5,
	5,
	6,
	6,
	7,
	7,
	8,
	8,
	9
}
tt.hero.level_stats.melee_damage_min = {
	11,
	12,
	13,
	15,
	16,
	17,
	19,
	20,
	23,
	24
}
tt.hero.level_stats.ranged_damage_max = {
	20,
	22,
	24,
	28,
	32,
	36,
	39,
	43,
	45,
	48
}
tt.hero.level_stats.ranged_damage_min = {
	10,
	11,
	12,
	13,
	14,
	14,
	17,
	18,
	20,
	20,
}
tt.hero.level_stats.regen_health = {
	15,
	17,
	19,
	21,
	23,
	25,
	27,
	29,
	31,
	33
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_tramin"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_tramin", "arrow")

----------------------------------------------
---------------------极狗----------------------
----------------------------------------------
tt = RT("hero_jigou", "hero")
AC(tt, "melee", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 60
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 18
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_jigou.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0405"
tt.info.i18n_key = "HERO_JIGOU"
tt.info.ultimate_icon = "0405"
tt.motion.max_speed = 1.4 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.ice_shard = E:clone_c("hero_skill")
tt.hero.skills.ice_shard.hr_order = 1
tt.hero.skills.ice_shard.hr_cost = {2,3,4}
tt.hero.skills.frozen_breath = E:clone_c("hero_skill")
tt.hero.skills.frozen_breath.hr_order = 2
tt.hero.skills.frozen_breath.hr_cost = {2,2,2}
tt.hero.skills.earthshake = E:clone_c("hero_skill")
tt.hero.skills.earthshake.hr_order = 3
tt.hero.skills.earthshake.hr_cost = {3,3,3}
tt.hero.skills.glacial_form = E:clone_c("hero_skill")
tt.hero.skills.glacial_form.hr_order = 4
tt.hero.skills.glacial_form.hr_cost = {1,1,1}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {1,3,5}

tt.hero.level_stats.armor = {
	0.06,
	0.08,
	0.10,
	0.12,
	0.14,
	0.16,
	0.18,
	0.20,
	0.22,
	0.24
}
tt.hero.level_stats.hp_max = {
	360,
	420,
	480,
	540,
	600,
	660,
	720,
	780,
	840,
	900
}
tt.hero.level_stats.melee_damage_max = {
	19,
	24,
	30,
	35,
	40,
	46,
	51,
	57,
	62,
	67
}
tt.hero.level_stats.melee_damage_min = {
	26,
	35,
	43,
	52,
	60,
	69,
	77,
	85,
	94,
	102
}
tt.hero.level_stats.regen_health = {
	30,
	35,
	40,
	45,
	50,
	55,
	60,
	65,
	70,
	75
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1

----------------------------------------------
-------------------苦楝夫人--------------------
----------------------------------------------
tt = RT("hero_margosa", "hero")
AC(tt, "melee", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 80
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 16
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_margosa.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0406"
tt.info.i18n_key = "HERO_MARGOSA"
tt.info.ultimate_icon = "0406"
tt.motion.max_speed = 2.2 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.bat_familiar = E:clone_c("hero_skill")
tt.hero.skills.bat_familiar.hr_order = 1
tt.hero.skills.bat_familiar.hr_cost = {3,3,3}
tt.hero.skills.myst_form = E:clone_c("hero_skill")
tt.hero.skills.myst_form.hr_order = 2
tt.hero.skills.myst_form.hr_cost = {2,2,2}
tt.hero.skills.dark_call = E:clone_c("hero_skill")
tt.hero.skills.dark_call.hr_order = 3
tt.hero.skills.dark_call.hr_cost = {2,2,2}
tt.hero.skills.vampiric_touch = E:clone_c("hero_skill")
tt.hero.skills.vampiric_touch.hr_order = 4
tt.hero.skills.vampiric_touch.hr_cost = {1,1,1}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {4,4,4}

tt.hero.level_stats.armor = {
	0.06,
	0.07,
	0.08,
	0.09,
	0.1,
	0.11,
	0.12,
	0.13,
	0.14,
	0.15
}
tt.hero.level_stats.hp_max = {
	300,
	324,
	348,
	372,
	396,
	420,
	444,
	468,
	492,
	516
}
tt.hero.level_stats.melee_damage_max = {
	26,
	30,
	33,
	36,
	39,
	42,
	46,
	52,
	54,
	57
}
tt.hero.level_stats.melee_damage_min = {
	15,
	17,
	20,
	23,
	25,
	28,
	31,
	33,
	35,
	39
}
tt.hero.level_stats.regen_health = {
	17,
	19,
	20,
	22,
	24,
	25,
	27,
	28,
	30,
	31
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1


----------------------------------------------
-------------------墨尔弥斯--------------------
----------------------------------------------
tt = RT("hero_mortemis", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 60
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 14
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_mortemis.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0407"
tt.info.i18n_key = "HERO_MORTEMIS"
tt.info.ultimate_icon = "0407"
tt.motion.max_speed = 1.8 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.call_haunted = E:clone_c("hero_skill")
tt.hero.skills.call_haunted.hr_order = 1
tt.hero.skills.call_haunted.hr_cost = {2,2,2}
tt.hero.skills.deadly_fumes = E:clone_c("hero_skill")
tt.hero.skills.deadly_fumes.hr_order = 2
tt.hero.skills.deadly_fumes.hr_cost = {3,3,3}
tt.hero.skills.grim_presence = E:clone_c("hero_skill")
tt.hero.skills.grim_presence.hr_order = 3
tt.hero.skills.grim_presence.hr_cost = {1,1,1}
tt.hero.skills.undead_servitude = E:clone_c("hero_skill")
tt.hero.skills.undead_servitude.hr_order = 4
tt.hero.skills.undead_servitude.hr_cost = {2,2,2}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {4,4,4}

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
tt.hero.level_stats.hp_max = {
	90,
	120,
	150,
	180,
	210,
	240,
	270,
	300,
	330,
	360
}
tt.hero.level_stats.melee_damage_max = {
	7,
	8,
	10,
	12,
	13,
	14,
	16,
	18,
	19,
	21
}
tt.hero.level_stats.melee_damage_min = {
	4,
	5,
	5,
	6,
	6,
	8,
	9,
	9,
	10,
	11
}
tt.hero.level_stats.ranged_damage_max = {
	7,
	8,
	10,
	12,
	13,
	14,
	16,
	18,
	19,
	21
}
tt.hero.level_stats.ranged_damage_min = {
	35,
	46,
	58,
	69,
	75,
	81,
	92,
	103,
	115,
	120
}
tt.hero.level_stats.regen_health = {
	7,
	10,
	12,
	15,
	17,
	20,
	22,
	25,
	27,
	30
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_mortemis"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_mortemis", "arrow")


----------------------------------------------
---------------------坦克----------------------
----------------------------------------------
tt = RT("hero_tank", "hero")
E:add_comps(tt, "ranged", "timed_attacks", "auras")
tt.health.dead_lifetime = 22.5
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 70)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_tank.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0408"
tt.info.i18n_key = "HERO_TANK"
tt.info.ultimate_icon = "0408"
tt.motion.max_speed = 2.5 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.heat_missiles = E:clone_c("hero_skill")
tt.hero.skills.heat_missiles.hr_order = 1
tt.hero.skills.heat_missiles.hr_cost = {2,2,2}
tt.hero.skills.ground_slam = E:clone_c("hero_skill")
tt.hero.skills.ground_slam.hr_order = 2
tt.hero.skills.ground_slam.hr_cost = {2,2,2}
tt.hero.skills.expendables = E:clone_c("hero_skill")
tt.hero.skills.expendables.hr_order = 3
tt.hero.skills.expendables.hr_cost = {1,2,3}
tt.hero.skills.scorching_cannon = E:clone_c("hero_skill")
tt.hero.skills.scorching_cannon.hr_order = 4
tt.hero.skills.scorching_cannon.hr_cost = {2,2,2}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {3,4,5}

tt.hero.level_stats.hp_max = {
	264,
	288,
	312,
	336,
	360,
	384,
	408,
	432,
	456,
	480
}
tt.hero.level_stats.regen_health = {
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40
}
tt.hero.level_stats.armor = {
	0.06,
	0.12,
	0.18,
	0.24,
	0.3,
	0.36,
	0.42,
	0.48,
	0.54,
	0.6
}
tt.hero.level_stats.ranged_damage_min = {
	14,
	24,
	34,
	43,
	49,
	63,
	72,
	82,
	92,
	101
}
tt.hero.level_stats.ranged_damage_max = {
	31,
	48,
	65,
	82,
	99,
	116,
	135,
	153,
	170,
	188
}
tt.regen.cooldown = 2
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_tank"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_tank", "g1_bomb")

----------------------------------------------
---------------------黑龙----------------------
----------------------------------------------
tt = E:register_t("hero_beresad", "hero")

E:add_comps(tt, "ranged", "timed_attacks")

image_y = 308
anchor_y = 0.12962962962962962
E:add_comps(tt, "ranged", "timed_attacks", "auras")
tt.health.dead_lifetime = 22.5
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 145)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_beresad.level_up
tt.main_script.insert = scripts.hero_beresad.insert
tt.main_script.update = scripts.hero_beresad.update
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0409"
tt.info.portrait = "gui4_bottom_info_image_heroes_0008"
tt.info.i18n_key = "HERO_BERESAD"
tt.info.ultimate_icon = "0409"
tt.motion.max_speed = 3 * FPS
tt.unit.hide_after_death = nil
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "group_beresad_taunt"
tt.sound_events.death = "hero_beresad_death"
tt.sound_events.hero_room_select = "hero_beresad_taunt_1"
tt.sound_events.insert = "hero_beresad_taunt_1"
tt.sound_events.respawn = "group_beresad_taunt"
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.all_except_flying_nowalk = bor(TERRAIN_NONE, TERRAIN_LAND, TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK, TERRAIN_SHALLOW, TERRAIN_FAERIE, TERRAIN_ICE)
tt.nav_grid.valid_terrains = tt.all_except_flying_nowalk
tt.nav_grid.valid_terrains_dest = tt.all_except_flying_nowalk
tt.drag_line_origin_offset = v(0, 100)
tt.ui.click_rect = r(-45, 30, 90, 90)
tt.unit.head_offset = v(0, 130)
tt.unit.hit_offset = v(0, 92)
tt.unit.mod_offset = v(0, 91)
tt.unit.marker_offset = v(0, 130)
tt.unit.mod_offset = v(0, 130+20)
tt.hero.skills.conflagration = E:clone_c("hero_skill")
tt.hero.skills.conflagration.hr_order = 1
tt.hero.skills.conflagration.hr_cost = {2,2,2}
tt.hero.skills.conflagration.damage = {2,3,5}
tt.hero.skills.conflagration.cooldown = {28,26,24}
tt.hero.skills.conflagration.xp_gain = {80,160,240}
tt.hero.skills.fear_dragon = E:clone_c("hero_skill")
tt.hero.skills.fear_dragon.hr_order = 2
tt.hero.skills.fear_dragon.hr_cost = {1,1,1}
tt.hero.skills.fear_dragon.duration = {3,5,7}
tt.hero.skills.dragon_spawn = E:clone_c("hero_skill")
tt.hero.skills.dragon_spawn.hr_order = 3
tt.hero.skills.dragon_spawn.hr_cost = {2,2,2}
tt.hero.skills.dragon_spawn.xp_gain = {80,160,240}
tt.hero.skills.dragon_spawn.entity = {"bullet_golem_stone_beresad_lvl1","bullet_golem_stone_beresad_lvl2","bullet_golem_stone_beresad_lvl3"}
tt.hero.skills.remove_existence = E:clone_c("hero_skill")
tt.hero.skills.remove_existence.hr_order = 4
tt.hero.skills.remove_existence.hr_cost = {4,1,1}
tt.hero.skills.remove_existence.cooldown = {70,60,50}
tt.hero.skills.remove_existence.damage_min = {40,60,90}
tt.hero.skills.remove_existence.damage_max = {60,90,120}
tt.hero.skills.remove_existence.xp_gain = {210,420,630}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.controller_name = "controller_beresad_ultimate"
tt.hero.skills.ultimate.damage = {[0]=2,6,10,15}
tt.hero.skills.ultimate.cooldown = {[0]=54,54,54,54}
tt.hero.skills.ultimate.hr_cost = {5,5,5}

tt.hero.level_stats.hp_max = {
	450,
	480,
	510,
	540,
	570,
	600,
	630,
	660,
	690,
	720
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
	16,
	19,
	22,
	26,
	29,
	33,
	37,
	40,
	44,
	46
}
tt.hero.level_stats.ranged_damage_max = {
	27,
	34,
	40,
	47,
	54,
	61,
	67,
	76,
	81,
	87
}
tt.regen.cooldown = 2
--动画
tt.render.sprites[1].anchor.y = 0.04
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_beresad"
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].name = "hero_beresad_shadow"
tt.render.sprites[2].z = Z_DECALS + 1
--普攻
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].basic_attack = true
tt.ranged.attacks[1].skill = "range_unit"
tt.ranged.attacks[1].disabled = false
tt.ranged.attacks[1].chance = 1
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].bullet = "bolt_beresad"
tt.ranged.attacks[1].bullet_start_offset = {
	v(45, 85)
}
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 175
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].name = "attack"
tt.ranged.attacks[1].shoot_time = fts(10)
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].estimated_flight_time = 1
tt.ranged.attacks[1].sound = "hero_beresad_attack_shot"
--1技能
tt.ranged.attacks[2] = E:clone_c("bullet_attack")
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].bullet = "controller_aura_beresad_firestorm"
tt.ranged.attacks[2].bullet_start_offset = {
	v(45, 85)
}
tt.ranged.attacks[2].cooldown = 28
tt.ranged.attacks[2].min_range = 0
tt.ranged.attacks[2].max_range = 175
tt.ranged.attacks[2].shoot_time = fts(13)
tt.ranged.attacks[2].sync_animation = true
tt.ranged.attacks[2].xp_from_skill = "conflagration"
tt.ranged.attacks[2].animation = "conflagration"
tt.ranged.attacks[2].name = "conflagration"
tt.ranged.attacks[2].sound = "HeroDragonFlame"
tt.ranged.attacks[2].emit_fx = "fx_breath_dragon_mouth_glow"
--tt.ranged.attacks[2].emit_ps = "ps_breath_dragon"
tt.ranged.attacks[2].vis_bans = F_FLYING
tt.ranged.attacks[2].nodes_limit = 10

--2技能 恐吓
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].skill = "range_unit"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "hero_beresad_modifier_fear"
tt.timed_attacks.list[1].max_target = 6
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 175
tt.timed_attacks.list[1].cooldown = 22
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].node_prediction = fts(17)
tt.timed_attacks.list[1].sync_animation = true
tt.timed_attacks.list[1].animation = "fear"
tt.timed_attacks.list[1].sound = "hero_beresad_fear"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(41, 72)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND, F_NIGHTMARE, F_FLYING, F_CLIFF, F_WATER)

--3技能 傀儡
tt.timed_attacks.list[2] = E:clone_c("custom_attack")
tt.timed_attacks.list[2].skill = "range_unit"
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "aura_beresad_fireball"
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 150
tt.timed_attacks.list[2].cooldown = 45
tt.timed_attacks.list[2].cast_time = fts(15)
tt.timed_attacks.list[2].node_prediction = fts(17)
tt.timed_attacks.list[2].sync_animation = true
tt.timed_attacks.list[2].animation = "earthshake"
tt.timed_attacks.list[2].sound = "HeroDracolichAttack"
tt.timed_attacks.list[2].bullet_start_offset = {
	v(41, 72)
}
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_FRIEND, F_NIGHTMARE, F_FLYING, F_CLIFF,F_WATER)
--4技能 秒杀
tt.ranged.attacks[3] = E:clone_c("bullet_attack")
tt.ranged.attacks[3].name = "remove"
tt.ranged.attacks[3].disabled = true
tt.ranged.attacks[3].bullet = "ray_beresad_disintegrate"
tt.ranged.attacks[3].bullet_start_offset = {v(45, 85)}
tt.ranged.attacks[3].cooldown = 70
tt.ranged.attacks[3].min_range = 0
tt.ranged.attacks[3].max_range = 175
tt.ranged.attacks[3].shoot_time = fts(23)
tt.ranged.attacks[3].sync_animation = true
tt.ranged.attacks[3].xp_from_skill = "remove_existence"
tt.ranged.attacks[3].animation = "remove"
tt.ranged.attacks[3].emit_fx = "fx_breath_dragon_mouth_glow"
--tt.ranged.attacks[3].emit_ps = "ps_fierymist_dragon"
tt.ranged.attacks[3].vis_bans = bor(F_FRIEND,F_BOSS,F_MINIBOSS)
tt.ranged.attacks[3].sound = "hero_beresad_remove"
tt.ranged.attacks[3].nodes_limit = 10

--普攻
tt = E:register_t("bolt_beresad", "bullet")
E:add_comps(tt, "force_motion")
tt.render.sprites[1].name = "hero_beresad_attack_proyectile_travel"
tt.render.sprites[1].animated = true
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor.x = 0.69
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.min_speed = 390
tt.bullet.max_speed = 390
tt.bullet.got_gold = 2
tt.bullet.hit_fx = "hero_beresad_attack_explosion"
tt.bullet.hit_fx_air = "hero_beresad_attack_explosion_air"
tt.bullet.hit_decal = nil--"fx_fireball_dracolich_decal"
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 33
tt.bullet.xp_gain_factor = 0.8
tt.bullet.particles_name = "hero_beresad_attack_particle"
tt.bullet.vis_flags = F_RANGED
tt.bullet.mod = nil
tt.bullet.hit_payload = nil--"aura_basic_attack_murglun"
tt.main_script.update = scripts.fireball_beresad.update
tt.sound_events.hit = "hero_beresad_attack_impact"

tt = E:register_t("hero_beresad_attack_particle")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "hero_beresad_attack_proyectile_particle_run"
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


tt = E:register_t("hero_beresad_attack_explosion", "fx")

tt.render.sprites[1].prefix = "hero_beresad_attack_explosion"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].offset = v(0, 0)

tt = E:register_t("hero_beresad_attack_explosion_air", "fx")

tt.render.sprites[1].prefix = "hero_beresad_attack_explosion_air"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].offset = v(0, 0)

--1技能绿火
tt = E:register_t("flame", "bullet")
tt.bullet.flight_time = 1
tt.delay_betweeen_flames = fts(1)
tt.flame_bullet = nil
tt.flames_count = 30
tt.main_script.insert = kr4_scripts.flame.insert
tt.main_script.update = kr4_scripts.flame.update

tt = E:register_t("flame_bullet")
E:add_comps(tt, "pos", "render")
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS

tt = E:register_t("controller_aura_beresad_firestorm", "flame")
tt.render = nil
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_radius = 65
tt.bullet.hit_payload = {
	"aura_beresad_firestorm"
}
tt.bullet.flight_time = fts(12)
tt.bullet.ignore_hit_offset = true
tt.delay_betweeen_flames = fts(2)
tt.flame_bullet = "beresad_breath_flame"
tt.flames_count = 12

tt = E:register_t("beresad_breath_flame", "flame_bullet")
tt.render.sprites[1].name = "hero_beresad_conflagration_particle_travel"
tt.render.sprites[1].fps = 15

tt = E:register_t("hero_beresad_conflagration_particle")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.animated = true
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "hero_beresad_conflagration_particle_travel"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.source_lifetime = fts(20)

tt = E.register_t(E, "aura_beresad_firestorm", "aura")
E.add_comps(E, tt, "render", "tween","sound_events")
tt.sound_events.insert = "hero_beresad_flameloop"
tt.aura.cycle_time = 0.2
tt.aura.duration = 5
tt.aura.mod = "mod_beresad_firestorm"
tt.aura.radius = 50
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].prefix = "hero_beresad_conflagration_fire"
tt.render.sprites[1].loop = true
--tt.render.sprites[1].name = "hero_murglun_heat_wave_decal"
--tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].scale = v(1, 1)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}
tt = E.register_t(E, "mod_beresad_firestorm", "modifier")
E.add_comps(E, tt, "dps", "render")
tt.dps.damage_min = 2
tt.dps.damage_max = 2
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 0.2
tt.dps.kill = true
tt.modifier.allows_duplicates = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = 0.2
tt.render.sprites[1].prefix = "hero_beresad_conflagration_modifier"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.4),
	vv(1.8)
}
tt.render.sprites[1].draw_order = 10

--2技能 恐惧
tt = RT("hero_beresad_modifier_fear", "mod_hero_jacko_horse_intimidation")
tt.modifier.duration = 3
tt.speed_factor = 1.5
tt.render.sprites[1].name = "hero_beresad_modifier_fear_run"

--3技能 傀儡
tt = E:register_t("aura_beresad_fireball", "aura")
tt.main_script.update = kr1_scripts.aura_10yr_fireball.update
tt.aura.entity = "bullet_golem_stone_beresad_lvl1"
tt.aura.delay = fts(15)
tt.aura.loops = 1
tt.aura.min_range = E:get_template("hero_10yr").timed_attacks.list[1].min_range
tt.aura.max_range = E:get_template("hero_10yr").timed_attacks.list[1].max_range
tt.aura.vis_flags = E:get_template("hero_10yr").timed_attacks.list[1].vis_flags
tt.aura.vis_bans = E:get_template("hero_10yr").timed_attacks.list[1].vis_bans

tt = E:register_t("bullet_golem_stone_beresad_lvl1", "bullet")
tt.bullet.min_speed = 24 * FPS
tt.bullet.max_speed = 24 * FPS
tt.bullet.acceleration_factor = 0.05
tt.bullet.hit_fx = "hero_beresad_golemspawn_hit"
tt.bullet.hit_decal = "hero_beresad_golemspawn_explosion"
tt.bullet.hit_payload = "hero_beresad_golem_lvl1"
tt.bullet.particles_name = "hero_beresad_golemspawn_particle"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min = 225
tt.bullet.damage_max = 225
tt.bullet.damage_factor = 1
tt.bullet.damage_flags = F_AREA
tt.render.sprites[1].name = "hero_beresad_golemspawn_proyectile"
tt.render.sprites[1].animated = false
tt.main_script.update = kr4_scripts.power_beresad_fireball.update
tt.scorch_earth = false
tt.sound_events.insert = "FireballRelease"
tt.sound_events.hit = "FireballHit"

tt = E:register_t("bullet_golem_stone_beresad_lvl2", "bullet_golem_stone_beresad_lvl1")
tt.bullet.hit_payload = "hero_beresad_golem_lvl2"
tt.bullet.damage_min = 375
tt.bullet.damage_max = 375

tt = E:register_t("bullet_golem_stone_beresad_lvl3", "bullet_golem_stone_beresad_lvl1")
tt.bullet.hit_payload = "hero_beresad_golem_lvl3"
tt.bullet.damage_min = 525
tt.bullet.damage_max = 525

tt = E:register_t("hero_beresad_golem_lvl1", "deckhand_goblin_red_lvl1")
AC(tt, "reinforcement")
tt.main_script.update = kr4_scripts.soldier_golem_beresad.update
tt.health_bar.offset = v(0, 50)
tt.health.armor = 0
tt.health.hp_max = 300
tt.regen.health = 0
tt.regen.cooldown = 2
tt.info.portrait = "gui4_bottom_info_image_soldiers_0028"
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 27
tt.melee.attacks[1].damage_min = 18
tt.render.sprites[1].prefix = "hero_beresad_golem"
tt.render.sprites[1].name = "idle"
tt.reinforcement.duration = 24
tt.reinforcement.fade = true
tt.patrol_pos_offset = v(15, 10)
tt.patrol_min_cd = 3
tt.patrol_max_cd = 6

tt = E:register_t("hero_beresad_golem_lvl2", "hero_beresad_golem_lvl1")
tt.health.hp_max = 400
tt.melee.attacks[1].damage_max = 45
tt.melee.attacks[1].damage_min = 30

tt = E:register_t("hero_beresad_golem_lvl3", "hero_beresad_golem_lvl1")
tt.health.hp_max = 500
tt.melee.attacks[1].damage_max = 63
tt.melee.attacks[1].damage_min = 42


tt = E:register_t("hero_beresad_golemspawn_hit", "fx")
tt.render.sprites[1].name = "hero_beresad_golemspawn_hit_run"
tt.render.sprites[1].anchor.y = 0.15
tt.render.sprites[1].z = Z_OBJECTS

tt = E:register_t("hero_beresad_golemspawn_explosion", "decal_tween")
tt.render.sprites[1].name = "hero_beresad_golemspawn_explosion_run"
tt.render.sprites[1].loop = false
tt.tween.props[1].keys = {
	{
		fts(17),
		255
	},
	{
		fts(27),
		0
	}
}

tt = E:register_t("hero_beresad_golemspawn_particle")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "hero_beresad_golemspawn_particle_run"
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

--4技能 秒杀
tt = RT("ray_beresad_disintegrate", "ray_arcane_disintegrate")
tt.bullet.mod = "mod_ray_beresad_disintegrate"
tt.image_width = 100
tt.render.sprites[1].name = "hero_beresad_remove_ray_run"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "hero_beresad_remove"

tt = RT("mod_ray_beresad_disintegrate", "mod_ray_arcane_disintegrate")
tt.render.sprites[1].name = "hero_beresad_remove_explosion_run"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt.modifier.damage = 1
tt.modifier.duration = fts(10)
tt.modifier.pop = {
	"pop_sishh"
}


--5技能 大招
tt = E:register_t("controller_beresad_ultimate")
E:add_comps(tt, "pos", "main_script", "sound_events")
tt.cooldown = 54
tt.duration = 4.2
tt.can_fire_fn = scripts.controller_beresad_ultimate.can_fire_fn
tt.main_script.update = scripts.controller_beresad_ultimate.update
tt.damage_radius = 9999
tt.sound_events.insert = "hero_beresad_ultimate"
tt.mod = "mod_beresad_ultimate"
tt.mod_cooldown = 0.2
tt.flash_delay_max = 0.3
tt.flash_delay_min = 0.1
tt.flash_duration_max = 0.15
tt.flash_duration_min = 0.1
tt.flash_l1_max_alphas = {
	0,
	0
}
tt.flash_l2_max_alpha = 70
tt.flash_l2_min_alpha = 60
tt.flash_delta = 0.02
tt.nodes_spread = 10
tt.rain = {}
tt.rain.alpha_max = 255
tt.rain.alpha_min = 150
tt.rain.angle_between = 2 * math.pi / 180
tt.rain.angle_max = -60 * math.pi / 180
tt.rain.angle_min = -80 * math.pi / 180
tt.rain.cooldown = 0.1
tt.rain.count = 50
tt.rain.delay_max = 0.2
tt.rain.disabled = true
tt.rain.distance_max = 550
tt.rain.distance_min = 450
tt.rain.duration = 0.2
tt.rain.ts = 0
tt.rain.drop = "fx_power_beresad_drop"
tt.rain.splash = "fx_power_beresad_rain_splash"

tt = E:register_t("fx_power_beresad_drop", "fx")
E:add_comps(tt, "tween")
tt.render.sprites[1].name = "asset_particle_"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.x = 1
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E:register_t("fx_power_beresad_rain_splash", "fx")
tt.render.sprites[1].name = "hero_beresad_ultimate_hit_run"

tt = E.register_t(E, "mod_beresad_ultimate", "modifier")
E.add_comps(E, tt, "dps", "render")
tt.dps.damage_min = 2
tt.dps.damage_max = 2
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 0.2
tt.dps.kill = true
tt.modifier.allows_duplicates = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = 0.2
tt.render.sprites[1].prefix = "hero_beresad_ultimate_modifier"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].size_names = {
	"run",
	"run",
	"run"
}
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.6),
	vv(2.2)
}
tt.render.sprites[1].draw_order = 10

----------------------------------------------
---------------------浚湃----------------------
----------------------------------------------
tt = RT("hero_naga", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 60
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 18
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_naga.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0410"
tt.info.i18n_key = "HERO_NAGA"
tt.info.ultimate_icon = "0410"
tt.motion.max_speed = 2.5 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.wave = E:clone_c("hero_skill")
tt.hero.skills.wave.hr_order = 1
tt.hero.skills.wave.hr_cost = {1,1,1}
tt.hero.skills.banner_allies = E:clone_c("hero_skill")
tt.hero.skills.banner_allies.hr_order = 2
tt.hero.skills.banner_allies.hr_cost = {1,1,1}
tt.hero.skills.gaze = E:clone_c("hero_skill")
tt.hero.skills.gaze.hr_order = 3
tt.hero.skills.gaze.hr_cost = {3,3,3}
tt.hero.skills.splash = E:clone_c("hero_skill")
tt.hero.skills.splash.hr_order = 4
tt.hero.skills.splash.hr_cost = {4,3,2}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {4,4,4}

tt.hero.level_stats.armor = {
	0.03,
	0.06,
	0.09,
	0.12,
	0.15,
	0.18,
	0.21,
	0.24,
	0.27,
	0.30
}
tt.hero.level_stats.hp_max = {
	264,
	294,
	324,
	354,
	384,
	414,
	444,
	474,
	504,
	534
}
tt.hero.level_stats.melee_damage_max = {
	13,
	17,
	21,
	26,
	30,
	34,
	39,
	42,
	47,
	50
}
tt.hero.level_stats.melee_damage_min = {
	10,
	12,
	15,
	18,
	20,
	23,
	25,
	28,
	31,
	34
}
tt.hero.level_stats.ranged_damage_max = {
	13,
	17,
	21,
	26,
	30,
	34,
	39,
	42,
	47,
	50
}
tt.hero.level_stats.ranged_damage_min = {
	10,
	12,
	15,
	18,
	20,
	23,
	25,
	28,
	31,
	34
}
tt.hero.level_stats.regen_health = {
	22,
	25,
	27,
	29,
	32,
	34,
	37,
	39,
	42,
	44
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_naga"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_naga", "arrow")

----------------------------------------------
---------------------火龙----------------------
----------------------------------------------
tt = E:register_t("hero_murglun", "hero")

E:add_comps(tt, "ranged", "timed_attacks","auras")

image_y = 308
anchor_y = 0.12962962962962962
tt.health.dead_lifetime = 22.5
tt.health_bar.draw_order = 10
tt.health_bar.offset = v(0, 157)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.info.hero_portrait = "kra_hero_portraits_0411"
tt.info.portrait = "gui4_bottom_info_image_heroes_0014"
tt.info.i18n_key = "HERO_MURGLUN"
tt.info.ultimate_icon = "0411"
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
tt.main_script.update = kr4_scripts.hero_murglun.update
tt.hero.fn_level_up = kr4_scripts.hero_murglun.level_up
tt.motion.max_speed = 3 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "group_murglun_taunt"
tt.sound_events.death = "hero_murglun_death"
tt.sound_events.hero_room_select = "hero_murglun_taunt_1"
tt.sound_events.insert = "hero_murglun_taunt_1"
tt.sound_events.respawn = "group_murglun_taunt"
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.all_except_flying_nowalk = bor(TERRAIN_NONE, TERRAIN_LAND, TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK, TERRAIN_SHALLOW, TERRAIN_FAERIE, TERRAIN_ICE)
tt.nav_grid.valid_terrains = tt.all_except_flying_nowalk
tt.nav_grid.valid_terrains_dest = tt.all_except_flying_nowalk
tt.drag_line_origin_offset = v(0, 100)
tt.ui.click_rect = r(-45, 30, 90, 90)
tt.unit.head_offset = v(0, 130)
tt.unit.hit_offset = v(0, 92)
tt.unit.mod_offset = v(0, 91)
tt.unit.marker_offset = v(0, 130)
tt.unit.mod_offset = v(0, 130+20)
tt.unit.hide_after_death = nil
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_BURN)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.hero.skills.magma_pool = E:clone_c("hero_skill")
tt.hero.skills.magma_pool.hr_order = 1
tt.hero.skills.magma_pool.pay_load_name = "aura_basic_attack_murglun"
tt.hero.skills.magma_pool.hr_cost = {2,2,2}
tt.hero.skills.magma_pool.damage = {2,4,6}
tt.hero.skills.magma_pool.duration = {5,5,6}
tt.hero.skills.tar_maker = E:clone_c("hero_skill")
tt.hero.skills.tar_maker.hr_order = 2
tt.hero.skills.tar_maker.hr_cost = {1,1,1}
tt.hero.skills.tar_maker.rate = {1.05,1.1,1.2}
tt.hero.skills.geyser = E:clone_c("hero_skill")
tt.hero.skills.geyser.hr_order = 3
tt.hero.skills.geyser.hr_cost = {2,1,1}
tt.hero.skills.geyser.xp_gain = {200,400,600}
tt.hero.skills.geyser.cooldown = {70,60,50}
tt.hero.skills.infernal_heat = E:clone_c("hero_skill")
tt.hero.skills.infernal_heat.hr_order = 4
tt.hero.skills.infernal_heat.hr_cost = {3,2,2}
tt.hero.skills.infernal_heat.cooldown = {22,18,14}
tt.hero.skills.infernal_heat.xp_gain = {100,200,300}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.controller_name = "hero_murglun_ultimate"
tt.hero.skills.ultimate.hr_cost = {6,5,5}
tt.hero.skills.ultimate.cooldown = {[0]=96,88,80,72}
tt.hero.skills.ultimate.boss_damage = {[0]=250,300,350,400}
tt.hero.level_stats.hp_max = {
	384,
	414,
	444,
	474,
	504,
	534,
	564,
	594,
	624,
	654
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
	0.04,
	0.06,
	0.08,
	0.1,
	0.12,
	0.14,
	0.16,
	0.18,
	0.2,
	0.22
}
tt.hero.level_stats.ranged_damage_min = {
	18,
	22,
	27,
	31,
	36,
	40,
	45,
	49,
	55,
	59
}
tt.hero.level_stats.ranged_damage_max = {
	30,
	39,
	48,
	57,
	66,
	75,
	84,
	93,
	101,
	110
}
tt.regen.cooldown = 2
tt.render.sprites[1].anchor.y = 0.04
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_murglun"
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].name = "hero_murglun_shadow"
tt.render.sprites[2].z = Z_DECALS + 1
--普攻
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].basic_attack = true
tt.ranged.attacks[1].skill = "range_unit"
tt.ranged.attacks[1].disabled = false
tt.ranged.attacks[1].chance = 1
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].bullet = "bolt_murglun"
tt.ranged.attacks[1].bullet_start_offset = {
	v(45, 85)
}
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 175
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].shoot_time = fts(16)
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].estimated_flight_time = 1
tt.ranged.attacks[1].sound = "HeroDracolichAttack"
--tt.ranged.attacks[1].cast_time = fts(16)
--tt.ranged.attacks[1].node_prediction = fts(32)
--秒杀，内置代码
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].skill = "range_unit"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].bullet = "instakill_murglun"
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 175
tt.timed_attacks.list[1].cooldown = 70
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].node_prediction = fts(17)
tt.timed_attacks.list[1].sync_animation = true
tt.timed_attacks.list[1].animation = "geiser"
tt.timed_attacks.list[1].sound = "HeroDracolichAttack"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(41, 72)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND, F_NIGHTMARE, F_FLYING, F_CLIFF, F_BOSS, F_MINIBOSS)
tt.timed_attacks.list[1].xp_from_skill = "geyser"
--岩浆池，内置代码
tt.ranged.attacks[2] = E:clone_c("bullet_attack")
tt.ranged.attacks[2].skill = "range_unit"
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].use_caster_position = true
tt.ranged.attacks[2].use_center = true
tt.ranged.attacks[2].bullet = "controller_aura_firestorm"
tt.ranged.attacks[2].animation = "heatWave"
tt.ranged.attacks[2].sync_animation = true
tt.ranged.attacks[2].cooldown = 22
tt.ranged.attacks[2].chance = 1
tt.ranged.attacks[2].sound = "hero_murglun_pool_taunt"
tt.ranged.attacks[2].min_range = 0
tt.ranged.attacks[2].max_range = 175
tt.ranged.attacks[2].vis_flags = bor(F_RANGED)
tt.ranged.attacks[2].vis_bans = bor(F_FRIEND, F_NIGHTMARE, F_CLIFF, F_FLYING)
tt.ranged.attacks[2].bullet_start_offset = {
	v(45, 85)
}
tt.ranged.attacks[2].shoot_time = fts(20)
tt.ranged.attacks[2].xp_from_skill = "infernal_heat"
tt.ranged.attacks[2].estimated_flight_time = 1
tt.ranged.attacks[2].vis_flags = bor(F_RANGED)
--[[
--岩浆血，参考电云走A，无动画
tt.timed_attacks.list[2] = E:clone_c("bullet_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].use_caster_position = true
tt.timed_attacks.list[2].use_center = true
tt.timed_attacks.list[2].bullet = "lava_blood_murglun"
tt.timed_attacks.list[2].sync_animation = true
--tt.timed_attacks.list[3].cast_time = fts(11)
tt.timed_attacks.list[2].cooldown = fts(13)
--tt.timed_attacks.list[3].min_range = 20
--tt.timed_attacks.list[3].max_range = 200
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_FRIEND, F_NIGHTMARE, F_CLIFF, F_FLYING)
]]
--增伤,参考气球增伤
tt.auras.list[1] = E:clone_c("mod_attack")
tt.auras.list[1].mod = "range_mod_murglun"
tt.auras.list[1].cooldown = 0.5
tt.auras.list[1].range = 200
tt.auras.list[1].damage_inc = 1.0
tt.auras.list[1].disabled = true
tt.auras.list[1].excluded_templates = {}

tt = E:register_t("decal_lava_blood_murglun", "decal_scripted")
E:add_comps(tt,"ranged")
tt.owner = nil
tt.owner_idx = nil
tt.ranged.attacks[1].cooldown_min = 30
tt.ranged.attacks[1].cooldown_max = 60
tt.ranged.attacks[1].cooldown = 0.45
tt.ranged.attacks[1].start_offset_y = 130
tt.ranged.attacks[1].bullet = "lava_blood_murglun"
tt.main_script.update = scripts.controller_lava_blood_murglun.update

tt = E:register_t("lava_blood_murglun", "bullet")
tt.bullet.min_speed = 18 * FPS
tt.bullet.max_speed = 18 * FPS
tt.bullet.acceleration_factor = 0.05
tt.bullet.hit_fx = "fx_murglun_lavablood_explosion"
--tt.bullet.hit_decal = "hero_murglun_ultimate_rocks_run"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_radius = 43
tt.bullet.damage_min = 23
tt.bullet.damage_max = 23
tt.bullet.damage_factor = 1
tt.bullet.damage_flags = F_AREA
tt.render.sprites[1].name = "hero_murglun_lava_blood_proy"
tt.render.sprites[1].keep_flip_x = true
tt.render.sprites[1].animated = false
tt.main_script.update = kr4_scripts.lava_blood_murglun.update
tt.scorch_earth = false
tt.sound_events.insert = nil
tt.sound_events.hit = nil

tt = E:register_t("fx_murglun_lavablood_explosion", "fx")

tt.render.sprites[1].prefix = "hero_murglun_lava_blood_explotion"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].offset = v(0, 0)


tt = E:register_t("hero_murglun_attack_explotion_run", "fx")

tt.render.sprites[1].prefix = "hero_murglun_attack_explotion"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].offset = v(0, 0)


tt = E:register_t("bolt_murglun", "bullet")
E:add_comps(tt, "force_motion")
--tt.bullet.hit_decal = "hero_murglun_attack_explotion_run"
--tt.bullet.mod = "mod_eiskalt_frozen_throat_slow"

tt.render.sprites[1].name = "hero_murglun_attack_proy"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor.x = 0.69
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.min_speed = 390
tt.bullet.max_speed = 390
tt.bullet.hit_fx = "hero_murglun_attack_explotion_run"
tt.bullet.hit_fx_air = "hero_murglun_attack_explotion_run"
tt.bullet.hit_decal = nil--"fx_fireball_dracolich_decal"
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 40
tt.bullet.xp_gain_factor = 0.8
--tt.bullet.particles_name = "ps_fireball_dracolich"
tt.bullet.vis_flags = F_RANGED
tt.bullet.mod = nil
tt.bullet.hit_payload = nil--"aura_basic_attack_murglun"
tt.main_script.update = scripts.fireball_murglun.update
tt.sound_events.hit = "HeroDragonAttackHit"

tt = E:register_t("hero_murglun_geiser_death_run", "decal_tween")
tt.render.sprites[1].name = "hero_murglun_geiser_death_run"
tt.render.sprites[1].loop = false
tt.tween.props[1].keys = {
	{
		fts(17),
		255
	},
	{
		fts(27),
		0
	}
}

tt = E:register_t("hero_murglun_ultimate_rocks_run", "decal_tween")
tt.render.sprites[1].name = "hero_murglun_ultimate_rocks_run"
tt.render.sprites[1].loop = false
tt.tween.props[1].keys = {
	{
		fts(17),
		255
	},
	{
		fts(27),
		0
	}
}

tt = E:register_t("bolt_murglun_instakill", "bolt_murglun")
tt.bullet.damage_type = DAMAGE_INSTAKILL
tt.bullet.hit_fx = "hero_murglun_geiser_full_run"
tt.bullet.hit_fx_air = "hero_murglun_geiser_full_run"
tt.bullet.hit_decal = "hero_murglun_geiser_death_run"

tt = E:register_t("aura_basic_attack_murglun", "aura")

E:add_comps(tt, "render", "tween")

tt.aura.cycle_time = 0.3
tt.aura.duration = 5
tt.aura.mod = "mod_basic_attack_murglun"
tt.aura.radius = 33
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].name = "hero_murglun_attack_decals_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}

tt = E:register_t("mod_basic_attack_murglun", "modifier")
E:add_comps(tt, "dps", "render")
tt.dps.damage_min = 0
tt.dps.damage_max = 0
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = fts(6)
tt.dps.kill = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = 1
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].draw_order = 10


--范围buff
local tt = E:register_t("range_mod_murglun", "modifier")

E:add_comps(tt, "render", "tween")
tt.modifier.duration = 99
tt.range_factor = 1.0
tt.range_factor_inc = 0
tt.main_script.insert = kr4_scripts.range_mod_murglun.insert
tt.main_script.remove = kr4_scripts.range_mod_murglun.remove
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
tt.render.sprites[1].name = "hero_murglun_tower_fx_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.21
tt.render.sprites[1].offset.y = 0
tt.render.sprites[1].z = Z_TOWER_BASES + 1


local tt = E:register_t("decal_murglun_tower_buff", "decal_tween")

tt.render.sprites[1].name = "hero_murglun_tower_fx_run"
tt.render.sprites[1].offset = v(0,10)
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

--4技能 烈焰风暴
tt = E.register_t(E, "controller_aura_firestorm", "rock_entwood")
tt.bullet.flight_time = fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_max_inc = 0
tt.bullet.damage_min = 0
tt.bullet.min_speed = 390
tt.bullet.max_speed = 1e+99

tt.bullet.damage_min_inc = tt.bullet.damage_max_inc
tt.bullet.damage_radius = 75
tt.bullet.hit_payload = "aura_murglun_firestorm"
tt.bullet.hit_fx = nil--"fx_sand_worm"--"fx_fiery_nut_explosion"
tt.bullet.hit_decal = nil
tt.render.sprites[1].name = nil--"time_wizard_sandstorm_proj"
tt.sound_events.hit = "hero_murglun_pool"


tt = E.register_t(E, "aura_murglun_firestorm", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.2
tt.aura.duration = 5
tt.aura.mod = "mod_murglun_firestorm"
tt.aura.radius = 60
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].prefix = "hero_murglun_heat_wave_decal"
tt.render.sprites[1].loop = true
--tt.render.sprites[1].name = "hero_murglun_heat_wave_decal"
--tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].scale = v(1, 0.5)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "hero_murglun_heat_wave_fx1"
tt.render.sprites[2].loop = true
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].scale = v(1, 1)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "hero_murglun_heat_wave_fx2"
tt.render.sprites[3].loop = true
tt.render.sprites[3].z = Z_DECALS
tt.render.sprites[3].scale = v(1, 1)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}
tt.tween.props[3] = table.deepclone(tt.tween.props[1])
tt.tween.props[3].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}
tt = E.register_t(E, "mod_murglun_firestorm", "modifier")

E.add_comps(E, tt, "dps", "render")
tt.dps.damage_min = 5
tt.dps.damage_max = 5
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 0.2
tt.dps.kill = true
tt.modifier.allows_duplicates = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = 0.2
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].draw_order = 10

--大招
tt = E:register_t("hero_murglun_ultimate")
E:add_comps(tt, "user_item", "pos", "main_script", "user_selection","sound_events", "aura")
tt.can_fire_fn = kr4_scripts.hero_murglun_ultimate.can_fire_fn
--tt.sound_events.insert = "HeroEiskaltBreath"
tt.cooldown = 80
tt.boss_damage_config = 250
tt.main_script.update = kr4_scripts.hero_murglun_ultimate.update
tt.aura.entity = "fireball_murglun_ultimate"
tt.aura.delay = fts(15)
tt.aura.loops = 6

tt = E:register_t("fireball_murglun_ultimate", "bullet")
tt.bullet.min_speed = 24 * FPS
tt.bullet.max_speed = 24 * FPS
tt.bullet.acceleration_factor = 0.05
tt.bullet.hit_fx = "fx_murglun_fireball_explosion"
tt.bullet.hit_decal = "hero_murglun_ultimate_rocks_run"
tt.bullet.particles_name = "ps_murglun_ultimate"
tt.bullet.damage_type = DAMAGE_INSTAKILL
tt.bullet.damage_radius = 50
tt.bullet.damage_min = 250
tt.bullet.damage_max = 250
tt.bullet.damage_factor = 1
tt.bullet.damage_flags = F_AREA
tt.render.sprites[1].name = "hero_murglun_ultimate_proy"
tt.render.sprites[1].animated = false
tt.main_script.update = kr4_scripts.power_murglun_fireball.update
tt.scorch_earth = false
tt.sound_events.insert = "FireballRelease"
tt.sound_events.hit = "FireballHit"

tt = E:register_t("fx_murglun_fireball_explosion", "fx")
tt.render.sprites[1].name = "hero_murglun_ultimate_explotion_run"
tt.render.sprites[1].anchor.y = 0.15
tt.render.sprites[1].z = Z_OBJECTS


--hero_murglun_attack_particle
tt = E:register_t("ps_bolt_murglun")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "hero_murglun_attack_particle_run"
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

tt = E:register_t("ps_murglun_ultimate")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "hero_murglun_ultimate_particle_run"
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

----------------------------------------------
--------------------格洛什---------------------
----------------------------------------------
tt = RT("hero_mammoth", "hero")
AC(tt, "melee", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 65
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 18
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_mammoth.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0415"
tt.info.i18n_key = "HERO_MAMMOTH"
tt.info.ultimate_icon = "0415"
tt.motion.max_speed = 1.7 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.fissure = E:clone_c("hero_skill")
tt.hero.skills.fissure.hr_order = 1
tt.hero.skills.fissure.hr_cost = {3,3,3}
tt.hero.skills.frenzy = E:clone_c("hero_skill")
tt.hero.skills.frenzy.hr_order = 2
tt.hero.skills.frenzy.hr_cost = {2,2,2}
tt.hero.skills.whirlwind = E:clone_c("hero_skill")
tt.hero.skills.whirlwind.hr_order = 3
tt.hero.skills.whirlwind.hr_cost = {1,1,1}
tt.hero.skills.legacy = E:clone_c("hero_skill")
tt.hero.skills.legacy.hr_order = 4
tt.hero.skills.legacy.hr_cost = {2,2,2}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {4,4,4}

tt.hero.level_stats.armor = {
	0.06,
	0.08,
	0.1,
	0.12,
	0.14,
	0.16,
	0.18,
	0.2,
	0.22,
	0.24
}
tt.hero.level_stats.hp_max = {
	312,
	360,
	408,
	456,
	504,
	552,
	600,
	648,
	696,
	744
}
tt.hero.level_stats.melee_damage_max = {
	25,
	30,
	33,
	38,
	41,
	46,
	49,
	54,
	57,
	62
}
tt.hero.level_stats.melee_damage_min = {
	17,
	19,
	22,
	25,
	28,
	30,
	33,
	36,
	39,
	41
}
tt.hero.level_stats.regen_health = {
	30,
	35,
	40,
	45,
	50,
	55,
	60,
	65,
	70,
	75
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1

----------------------------------------------
-------------------伊斯菲特--------------------
----------------------------------------------
tt = RT("hero_isfet", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "dodge")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 65
tt.health_bar.offset = v(0, 36)
tt.health.dead_lifetime = 18
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_isfet.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.info.hero_portrait = "kra_hero_portraits_0416"
tt.info.i18n_key = "HERO_ISFET"
tt.info.ultimate_icon = "0416"
tt.motion.max_speed = 1.3 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.black_cloud = E:clone_c("hero_skill")
tt.hero.skills.black_cloud.hr_order = 1
tt.hero.skills.black_cloud.hr_cost = {3,3,3}
tt.hero.skills.frog_curse = E:clone_c("hero_skill")
tt.hero.skills.frog_curse.hr_order = 2
tt.hero.skills.frog_curse.hr_cost = {1,2,3}
tt.hero.skills.rain = E:clone_c("hero_skill")
tt.hero.skills.rain.hr_order = 3
tt.hero.skills.rain.hr_cost = {2,3,4}
tt.hero.skills.blood_pool = E:clone_c("hero_skill")
tt.hero.skills.blood_pool.hr_order = 4
tt.hero.skills.blood_pool.hr_cost = {1,2,3}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {2,2,2}

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
tt.hero.level_stats.hp_max = {
	204,
	228,
	252,
	276,
	300,
	324,
	348,
	372,
	396,
	420
}
tt.hero.level_stats.melee_damage_max = {
	7,
	8,
	9,
	11,
	13,
	14,
	15,
	16,
	18,
	20
}
tt.hero.level_stats.melee_damage_min = {
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	12,
	12,
	13
}
tt.hero.level_stats.ranged_damage_max = {
	22,
	26,
	31,
	35,
	39,
	44,
	48,
	53,
	58,
	62
}
tt.hero.level_stats.ranged_damage_min = {
	12,
	14,
	16,
	19,
	21,
	24,
	26,
	29,
	31,
	33
}
tt.hero.level_stats.regen_health = {
	26,
	26,
	26,
	26,
	26,
	26,
	26,
	26,
	26,
	26
}
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_isfet"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_isfet", "bolt")

----------------------------------------------
-------------------卢塞尔娜--------------------
----------------------------------------------
tt = E:register_t("hero_lucerna", "hero")

E:add_comps(tt, "ranged", "timed_attacks")

image_y = 308
anchor_y = 0.12962962962962962
E:add_comps(tt, "ranged", "timed_attacks", "auras")
tt.health.dead_lifetime = 27
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 130)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.info.hero_portrait = "kra_hero_portraits_0417"
tt.info.i18n_key = "HERO_LUCERNA"
tt.info.ultimate_icon = "0417"
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
--tt.main_script.update = kr4_scripts.hero_gerald99.update
tt.hero.fn_level_up = scripts.hero_lucerna.level_up
--暂时取消头像--tt.info.portrait = "info_portraits_hero_0005"
tt.motion.max_speed = 1.3 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 130)
tt.unit.mod_offset = v(0, 130+20)
tt.hero.skills.scurvy_vissage = E:clone_c("hero_skill")
tt.hero.skills.scurvy_vissage.hr_order = 1
tt.hero.skills.scurvy_vissage.hr_cost = {3,3,3}
tt.hero.skills.fire_at_will = E:clone_c("hero_skill")
tt.hero.skills.fire_at_will.hr_order = 2
tt.hero.skills.fire_at_will.hr_cost = {2,1,1}
tt.hero.skills.damned_crew = E:clone_c("hero_skill")
tt.hero.skills.damned_crew.hr_order = 3
tt.hero.skills.damned_crew.hr_cost = {2,3,3}
tt.hero.skills.pirates_pillage = E:clone_c("hero_skill")
tt.hero.skills.pirates_pillage.hr_order = 4
tt.hero.skills.pirates_pillage.hr_cost = {2,2,2}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {3,3,3}

tt.hero.level_stats.hp_max = {
	384,
	414,
	444,
	474,
	504,
	534,
	564,
	594,
	624,
	654
}
tt.hero.level_stats.regen_health = {
	17,
	17,
	17,
	17,
	17,
	17,
	17,
	17,
	17,
	17
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
tt.hero.level_stats.magic_armor = {
	0.13,
	0.13,
	0.13,
	0.13,
	0.13,
	0.13,
	0.13,
	0.13,
	0.13,
	0.13
}
tt.hero.level_stats.ranged_damage_min = {
	15,
	17,
	21,
	23,
	25,
	27,
	31,
	33,
	35,
	37
}
tt.hero.level_stats.ranged_damage_max = {
	26,
	29,
	32,
	36,
	39,
	42,
	46,
	49,
	54,
	57
}
tt.regen.cooldown = 2
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bullet_lucerna"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt = RT("bullet_lucerna", "bolt")