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
tt.health_bar.offset = v(0, 50)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.main_script.update = kr4_scripts.hero_orc.update
tt.hero.fn_level_up = kr4_scripts.hero_orc.level_up
tt.info.portrait = "gui4_bottom_info_image_heroes_0001"
tt.info.hero_portrait = "kra_hero_portraits_0401"
tt.info.i18n_key = "HERO_VERUK"
tt.info.ultimate_icon = "0401"
tt.motion.max_speed = 2.5 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "group_orc_taunt"
tt.sound_events.death = "hero_orc_death"
tt.sound_events.hero_room_select = "hero_orc_taunt_1"
tt.sound_events.insert = "hero_orc_taunt_1"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.ui.click_rect = r(-29, -5, 58, 105)
tt.unit.head_offset = v(0, 48)
tt.unit.hit_offset = v(0, 30)
tt.unit.mod_offset = v(0, 30)
tt.unit.hide_after_death = nil
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET)
tt.soldier.melee_slot_offset = v(25, 0)
tt.hero.skills.duelist = E:clone_c("hero_skill")
tt.hero.skills.duelist.hr_order = 1
tt.hero.skills.duelist.hr_cost = {3,3,3}
tt.hero.skills.duelist.damage_config = {90,180,270}
tt.hero.skills.duelist.xp_gain = {90,180,270}
tt.hero.skills.duelist.cooldown = {15,15,15}
tt.hero.skills.brute_force = E:clone_c("hero_skill")
tt.hero.skills.brute_force.hr_order = 2
tt.hero.skills.brute_force.hr_cost = {1,2,3}
tt.hero.skills.brute_force.damage_config = {90,180,270}
tt.hero.skills.brute_force.xp_gain = {90,180,270}
tt.hero.skills.brute_force.duration = {1,2,4}
tt.hero.skills.brute_force.cooldown = {16,15,14}
tt.hero.skills.aimed_slash = E:clone_c("hero_skill")
tt.hero.skills.aimed_slash.hr_order = 3
tt.hero.skills.aimed_slash.hr_cost = {2,3,4}
tt.hero.skills.aimed_slash.damage_inc = {0.08,0.24,0.36}
tt.hero.skills.inspiring_leader = E:clone_c("hero_skill")
tt.hero.skills.inspiring_leader.hr_order = 4
tt.hero.skills.inspiring_leader.hr_cost = {1,2,3}
tt.hero.skills.inspiring_leader.instance = {"hero_veruk_ghoul_lvl1","hero_veruk_ghoul_lvl2","hero_veruk_ghoul_lvl3"}
tt.hero.skills.inspiring_leader.cooldown = {20,18,15}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.cooldown = {[0]=32,32,32,32}
tt.hero.skills.ultimate.controller_name = "hero_orc_ultimate"
tt.hero.skills.ultimate.hr_cost = {2,2,2}
tt.hero.skills.ultimate.instance = {[0] = "hero_veruk_spear_lvl1","hero_veruk_spear_lvl2","hero_veruk_spear_lvl3","hero_veruk_spear_lvl4"}



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
tt.render.sprites[1].anchor.y = 0.12
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].scale = v(1.2,1.2)
tt.render.sprites[1].prefix = "hero_orc"
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].name = "hero_orc_shadow"
tt.render.sprites[2].anchor.y = 0.12
tt.render.sprites[2].z = Z_DECALS + 1
tt.melee.range = 60
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 2.2
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].basic_attack = nil
tt.melee.attacks[2].sound = "hero_orc_slash"
tt.melee.attacks[2].animation = "special"
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[2].damage_min = 90
tt.melee.attacks[2].damage_max = 90
tt.melee.attacks[2].cooldown = 15
tt.melee.attacks[2].xp_gain = 90
tt.melee.attacks[2].mod = "mod_hero_jacko_reduce_armor"
tt.melee.attacks[3] = E:clone_c("area_attack")
tt.melee.attacks[3].animation = "stun"
tt.melee.attacks[3].mod = "mod_veruk_stun"
tt.melee.attacks[3].sound = "hero_orc_bruteforce"
tt.melee.attacks[3].damage_max = 0
tt.melee.attacks[3].damage_min = 0
tt.melee.attacks[3].damage_max_inc = 0
tt.melee.attacks[3].damage_min_inc = 0
tt.melee.attacks[3].damage_radius = 50
tt.melee.attacks[3].xp_gain = 90
tt.melee.attacks[3].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].cooldown = 20
tt.melee.attacks[3].hit_decal = "decal_orc_holystrike"
tt.melee.attacks[3].hit_offset = v(22, 0)
tt.melee.attacks[3].hit_time = fts(15)
tt.melee.attacks[3].level = 0
tt.melee.attacks[3].pop = nil
--tt.melee.attacks[3].shared_cooldown = true
tt.melee.attacks[3].vis_bans = bor(F_FLYING)
tt.melee.attacks[3].vis_flags = bor(F_BLOCK)

tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].skill = "range_at_path"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].use_center = nil
tt.timed_attacks.list[1].bullet = "hero_veruk_spawner_seed"
tt.timed_attacks.list[1].max_bullets = 2
tt.timed_attacks.list[1].range_nodes = 25
tt.timed_attacks.list[1].min_targets = 2
tt.timed_attacks.list[1].cooldown = 30
tt.timed_attacks.list[1].min_nodes = -3
tt.timed_attacks.list[1].max_nodes = -1
tt.timed_attacks.list[1].cast_time = fts(10)
tt.timed_attacks.list[1].sound = "hero_orc_leader"
tt.timed_attacks.list[1].animation = "call"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(19, 55)
}
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND, F_FLYING)
tt.timed_attacks.list[1].xp_from_skill = "inspiring_leader"

tt = RT("decal_orc_holystrike", "decal_timed")
tt.render.sprites[1].name = "decal_orc_holystrike"
tt.render.sprites[1].z = Z_DECALS

tt = RT("mod_veruk_stun", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.modifier.duration = 1

tt = E:register_t("hero_veruk_spawner_seed", "KR5Bomb")
tt.bullet.damage_min = 64
tt.bullet.damage_max = 64
tt.bullet.damage_radius = 50
tt.bullet.flight_time = fts(2)
tt.bullet.rotation_speed = 2 * FPS * math.pi / 22
tt.bullet.hit_fx = nil
tt.bullet.hit_fx_water = nil
tt.bullet.hit_decal = nil
tt.bullet.hit_payload = "hero_veruk_ghoul_lvl1"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt.render.sprites[1].name = nil
tt.render.sprites[1].hidden = true
tt.render.sprites[1].animated = false

tt = RT("hero_veruk_ghoul_lvl1", "soldier_hover")
E:add_comps(tt, "reinforcement")
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health.hp_max = 35
tt.health_bar.offset = v(0, 32)
tt.unit.hit_offset = v(0, 16)
tt.unit.head_offset = v(0, 29)
tt.unit.mod_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.info.portrait = "gui4_bottom_info_image_soldiers_0032" --gui4_bottom_info_image_soldiers_0039
tt.info.random_name_format = nil
tt.info.random_name_count = nil
tt.motion.max_speed = 30
tt.render.sprites[1].prefix = "reinforcement_goblin"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = 0.125
tt.render.sprites[1].angles.walk = {
	"walk",
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_orc_spear_goblin_shadow"
tt.render.sprites[2].anchor.y = 0.125
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(16, 0)
tt.melee.range = 75
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(9)
tt.regen.health = 0
tt.regen.cooldown = 2
tt.reinforcement.duration = 10
tt.ui.click_rect = r(-20, -5, 40, 28)
tt.hover.cooldown_min = 5
tt.hover.cooldown_max = 15
tt.hover.random_ni = 6
tt.fade_out = true
tt.insert_delay = 0.6

tt = RT("hero_veruk_ghoul_lvl2", "hero_veruk_ghoul_lvl1")
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].damage_max = 8
tt.health.hp_max = 70

tt = RT("hero_veruk_ghoul_lvl3", "hero_veruk_ghoul_lvl1")
tt.melee.attacks[1].damage_min = 9
tt.melee.attacks[1].damage_max = 12
tt.health.hp_max = 100

tt = RT("hero_veruk_spear_lvl1", "hero_veruk_ghoul_lvl1")
E:add_comps(tt, "ranged")
tt.render.sprites[1].prefix = "hero_orc_spear_goblin"
tt.melee.attacks[1].damage_min = 8
tt.melee.attacks[1].damage_max = 11
tt.info.portrait = "gui4_bottom_info_image_soldiers_0039"
tt.health.hp_max = 50
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "spear_veruk_goblin_lvl1"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 12)
}
tt.ranged.attacks[1].cooldown = 0.9
tt.ranged.attacks[1].max_range = 175
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = fts(10)
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)

tt = RT("hero_veruk_spear_lvl2", "hero_veruk_spear_lvl1")
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].damage_max = 14
tt.health.hp_max = 100
tt.ranged.attacks[1].bullet = "spear_veruk_goblin_lvl2"

tt = RT("hero_veruk_spear_lvl3", "hero_veruk_spear_lvl1")
tt.melee.attacks[1].damage_min = 19
tt.melee.attacks[1].damage_max = 29
tt.health.hp_max = 150
tt.ranged.attacks[1].bullet = "spear_veruk_goblin_lvl3"

tt = RT("hero_veruk_spear_lvl4", "hero_veruk_spear_lvl1")
tt.melee.attacks[1].damage_min = 29
tt.melee.attacks[1].damage_max = 43
tt.health.hp_max = 200
tt.ranged.attacks[1].bullet = "spear_veruk_goblin_lvl4"

tt = E:register_t("spear_veruk_goblin_lvl1", "arrow5_fixed_height")
tt.render.sprites[1].name = "hero_orc_spear_goblin_proyectile"
tt.render.sprites[1].scale = v(-1, 1)
tt.bullet.miss_decal = "hero_orc_spear_goblin_proyectile_decal_0007"
tt.bullet.miss_decal_anchor = v(1, 0.5)
tt.bullet.damage_max = 11
tt.bullet.damage_min = 5
tt.bullet.fixed_height = 35
tt.bullet.flip_x = true
tt.bullet.g = -1000
tt.bullet.hide_radius = 1
tt.bullet.reset_to_target_pos = true
tt.bullet.use_unit_damage_factor = true

tt = E:register_t("spear_veruk_goblin_lvl2", "spear_veruk_goblin_lvl1")
tt.bullet.damage_max = 24
tt.bullet.damage_min = 16

tt = E:register_t("spear_veruk_goblin_lvl3", "spear_veruk_goblin_lvl1")
tt.bullet.damage_max = 36
tt.bullet.damage_min = 24

tt = E:register_t("spear_veruk_goblin_lvl4", "spear_veruk_goblin_lvl1")
tt.bullet.damage_max = 42
tt.bullet.damage_min = 28

tt = E:register_t("hero_orc_ultimate")
E:add_comps(tt, "user_item", "pos", "main_script", "user_selection","sound_events", "attacks", "render")
tt.can_fire_fn = kr4_scripts.controller_orc_ultimate.can_fire_fn
--tt.sound_events.insert = "HeroEiskaltBreath"
tt.level = 0
tt.cooldown = 32
tt.entity = "hero_veruk_spear_lvl1"
tt.main_script.update = kr4_scripts.orc_ultimate.update

----------------------------------------------
--------------------阿斯拉---------------------
----------------------------------------------
tt = RT("hero_asra", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "teleport")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.health.dead_lifetime = 16
tt.melee.range = 60
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
tt.main_script.update = kr4_scripts.hero_asra.update
tt.hero.fn_level_up = kr4_scripts.hero_asra.level_up
tt.info.portrait = "gui4_bottom_info_image_heroes_0002"
tt.info.hero_portrait = "kra_hero_portraits_0402"
tt.info.i18n_key = "HERO_ASRA"
tt.info.ultimate_icon = "0402"
tt.motion.max_speed = 2.5 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "group_asra_taunt"
tt.sound_events.death = "hero_asra_death"
tt.sound_events.hero_room_select = "hero_asra_taunt_1"
tt.sound_events.insert = "hero_asra_taunt_1"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.teleport.min_distance = 150
tt.teleport.delay = 0
tt.teleport.sound = "hero_asra_teleport"
tt.teleport.animations = {
	"teleportOut",
	"teleportIn"
}
tt.hero.skills.spider_bite = E:clone_c("hero_skill")
tt.hero.skills.spider_bite.hr_order = 1
tt.hero.skills.spider_bite.hr_cost = {5,4,3}
tt.hero.skills.spider_bite.cooldown = {45,45,45}
tt.hero.skills.spider_bite.damage_config = {7,15,35}
tt.hero.skills.spider_bite.xp_gain = {300,600,900}
tt.hero.skills.onix_arrows = E:clone_c("hero_skill")
tt.hero.skills.onix_arrows.hr_order = 2
tt.hero.skills.onix_arrows.hr_cost = {2,2,2}
tt.hero.skills.onix_arrows.loops = {3,4,5}
tt.hero.skills.onix_arrows.damage_min = {20,28,36}
tt.hero.skills.onix_arrows.damage_max = {30,42,54}
tt.hero.skills.onix_arrows.xp_gain = {90,180,270}
tt.hero.skills.quiver_of_sorrow = E:clone_c("hero_skill")
tt.hero.skills.quiver_of_sorrow.hr_order = 3
tt.hero.skills.quiver_of_sorrow.hr_cost = {1,1,1}
tt.hero.skills.quiver_of_sorrow.damage_armor = {0.01,0.02,0.03}
tt.hero.skills.shield_of_shadows = E:clone_c("hero_skill")
tt.hero.skills.shield_of_shadows.hr_order = 4
tt.hero.skills.shield_of_shadows.hr_cost = {2,2,2}
tt.hero.skills.shield_of_shadows.shield_max_damage = {120,400,600}
tt.hero.skills.shield_of_shadows.xp_gain = {120,240,360}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {3,3,3}
tt.hero.skills.ultimate.damage_config = {[0]=10,15,30,50}
tt.hero.skills.ultimate.cooldown = {[0]=40,40,40,40}
tt.hero.skills.ultimate.controller_name = "hero_asra_ultimate"

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
tt.render.sprites[1].anchor.y = 0.12
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].scale = v(1.2,1.2)
tt.render.sprites[1].prefix = "hero_asra"
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].name = "hero_asra_shadow"
tt.render.sprites[2].anchor.y = 0.12
tt.render.sprites[2].z = Z_DECALS + 1
tt.melee.range = 60
tt.regen.cooldown = 2
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 0.8
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 5
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 2.2
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].cooldown = 45
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].sound = "hero_asra_spiderbite"
tt.melee.attacks[2].damage_max = 1
tt.melee.attacks[2].damage_min = 1
tt.melee.attacks[2].animation = "meleePoison"
tt.melee.attacks[2].hit_time = fts(9)
tt.melee.attacks[2].mod = "mod_asra_poison"
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.attacks[2].xp_gain = 300
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].xp_gain_factor = 2.2
tt.ranged.attacks[1].max_range = 200
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "bullet_asra"
tt.ranged.attacks[1].shoot_time = fts(11)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt.ranged.attacks[2] = E:clone_c("bullet_attack")
tt.ranged.attacks[2].cooldown = 18
tt.ranged.attacks[2].min_range = 25
tt.ranged.attacks[2].max_range = 200
--tt.ranged.attacks[2].animation = "shoot"
tt.ranged.attacks[2].bullet = "bullet_onix_asra"
tt.ranged.attacks[2].max_loops = 3
tt.ranged.attacks[2].loops = 3
tt.ranged.attacks[2].xp_gain = 90
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].shoot_times = {fts(5)}
tt.ranged.attacks[2].bullet_start_offset = {
	v(-8, 24)
}
tt.ranged.attacks[2].animations = {
	"multishotIn",
	"multishotLoop",
	"multishotOut"
}

tt.timed_attacks.list[1] = E:clone_c("mod_attack")
tt.timed_attacks.list[1].animation = "special"
tt.timed_attacks.list[1].cooldown = 22
tt.timed_attacks.list[1].max_range_trigger = 72
tt.timed_attacks.list[1].max_range_effect = 140
tt.timed_attacks.list[1].min_targets = 1
tt.timed_attacks.list[1].max_targets = 4
tt.timed_attacks.list[1].mod = "hero_asra_unbreakable_mod"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].cast_time = fts(6)
tt.timed_attacks.list[1].xp_from_skill = "shield_of_shadows"
tt.timed_attacks.list[1].sound = "hero_asra_shield"
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)

tt = E:register_t("hero_asra_ultimate")

E:add_comps(tt, "pos", "main_script")

tt.can_fire_fn = scripts.hero_asra_ultimate.can_fire_fn
tt.cooldown = 40
tt.sound = "hero_asra_ultimate_poison"
tt.bullet = "arrow_hero_asra_ultimate"
tt.spread = {
	[0] = 6,
	6,
	6,
	6
}
tt.damage = {
	[0] = 0,
	0,
	0,
	0
}
tt.main_script.update = scripts.hero_asra_ultimate.update

tt = E:register_t("arrow_hero_asra_ultimate", "bullet")
tt.main_script.update = scripts.arrow_hero_asra_ultimate.update
tt.bullet.damage_radius = 45
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = F_FRIEND
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.arrive_decal = "decal_hero_asra_ultimate"
tt.bullet.max_speed = 1500
tt.bullet.mod = "mod_hero_asra_ultimate_poison"
tt.render.sprites[1].name = "hero_asra_special_arrow"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = v(-1, 1)
tt.render.sprites[1].anchor.x = 0.9629629629629629
tt.sound_events.insert = "ArrowSound"

tt = RT("mod_hero_asra_ultimate_poison", "mod_poison")
tt.modifier.duration = 2.1
tt.dps.damage_max = 7
tt.dps.damage_min = 7
tt.dps.damage_every = 0.5
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)

tt = E:register_t("decal_hero_asra_ultimate", "decal_tween")
AC(tt, "main_script")
tt.main_script.insert = scripts.decal_hero_asra_ultimate.insert
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
		4,
		0
	}
}
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.render.sprites[1].name = "hero_asra_special_poison_explosion_run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "fx_hero_elves_archer_ultimate_smoke"
tt.render.sprites[2].animated = false
tt.render.sprites[2].loop = false
tt.render.sprites[2].z = Z_OBJECTS

tt = E:register_t("hero_asra_unbreakable_mod", "modifier")

E:add_comps(tt, "render", "health_bar", "health")

tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.duration = 5
tt.modifier.use_mod_offset = false
tt.shield_max_damage = 120
tt.damage_taken = 0
tt.main_script.insert = scripts.hero_asra_unbreakable_mod.insert
tt.main_script.remove = scripts.hero_asra_unbreakable_mod.remove
tt.main_script.update = scripts.hero_asra_unbreakable_mod.update
tt.health_bar.offset = v(0, 42)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.colors = {}
tt.health_bar.colors.fg = {
	255,
	255,
	0,
	255
}
tt.health_bar.colors.bg = {
	0,
	0,
	0,
	255
}
tt.health_bar.sort_y_offset = -2
tt.health_bar.disable_fade = true
--替换成asra的盾
tt.sprites_per_enemies = {
	"hero_asra_shield",
	"hero_asra_shield",
	"hero_asra_shield"
}
tt.animation_start = "start"
tt.animation_loop = "idle"
tt.animation_end = "end"
tt.render.sprites[1].prefix = nil
tt.render.sprites[1].offset = v(0, 20)
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = true

tt = RT("mod_asra_poison", "mod_poison")
tt.modifier.duration = 99999
tt.dps.damage_max = 7
tt.dps.damage_min = 7
tt.dps.damage_every = 0.5
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)

tt = E:register_t("bullet_asra", "arrow")
tt.bullet.hit_distance = 50
tt.bullet.flight_time = fts(9)
tt.bullet.flight_time_factor = fts(1 / 60)
tt.bullet.damage_max = 16
tt.bullet.damage_min = 10
tt.bullet.xp_gain_factor = 6
tt.bullet.miss_decal = "hero_asra_projectile_decal"
tt.bullet.mod = {
	"mod_arrow_asra"
}
tt.bullet.hit_fx = "fx_arrow_asra_hit"
tt.render.sprites[1].name = "hero_asra_projectile"
tt.render.sprites[1].animated = false
tt.render.sprites[1].flip_x = true

tt = E:register_t("bullet_onix_asra", "arrow")
tt.bullet.flight_time = fts(6)
--tt.bullet.flight_time_factor = fts(1 / 60)
tt.bullet.damage_max = 16
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 10
tt.bullet.miss_decal = "hero_asra_multishot_arrow_decal"
tt.bullet.mod = {
	"mod_arrow_asra"
}
tt.bullet.hit_fx = "fx_arrow_asra_hit"
tt.render.sprites[1].name = "hero_asra_multishot_arrow"

tt = E:register_t("fx_arrow_asra_hit", "fx")
tt.render.sprites[1].name = "hero_asra_multishot_arrow_hit_run"

tt = E:register_t("mod_arrow_asra", "mod_damage")
tt.damage_min = 0
tt.damage_max = 0
tt.damage_type = DAMAGE_ARMOR

----------------------------------------------
--------------------奥洛克---------------------
----------------------------------------------
tt = RT("hero_oloch", "hero")
AC(tt, "melee", "ranged", "timed_attacks", "dodge", "auras", "selfdestruct")
tt.hero_insert = false
anchor_x, anchor_y = 0.5, 0.12
image_x, image_y = 92, 110
tt.melee.range = 20
tt.health_bar.offset = v(0, 52)
tt.health.dead_lifetime = 16
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
tt.main_script.update = kr4_scripts.hero_oloch.update
tt.hero.fn_level_up = scripts.hero_oloch.level_up
tt.info.portrait = "gui4_bottom_info_image_heroes_0003"
tt.info.hero_portrait = "kra_hero_portraits_0403"
tt.info.i18n_key = "HERO_OLOCH"
tt.info.ultimate_icon = "0403"
tt.motion.max_speed = 1.83 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "group_oloch_taunt"
tt.sound_events.death = "hero_oloch_death"
tt.sound_events.hero_room_select = "hero_oloch_taunt_1"
tt.sound_events.insert = "hero_oloch_taunt_1"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.hero.skills.duplication = E:clone_c("hero_skill")
tt.hero.skills.duplication.hr_order = 1
tt.hero.skills.duplication.hr_cost = {4,4,4}
tt.hero.skills.duplication.xp_gain = {50,100,150}
tt.hero.skills.duplication.damage_min = {10,16,24}
tt.hero.skills.duplication.damage_max = {20,48,72}
tt.hero.skills.magma_eruption = E:clone_c("hero_skill")
tt.hero.skills.magma_eruption.hr_order = 2
tt.hero.skills.magma_eruption.hr_cost = {2,2,2}
tt.hero.skills.magma_eruption.xp_gain = {50,100,150}
tt.hero.skills.magma_eruption.count = {3, 4, 5}
tt.hero.skills.magma_eruption.damage_config = {20,40,60}
tt.hero.skills.magma_eruption.damage_aura_config = {7,11,13}
tt.hero.skills.hellish_infusion = E:clone_c("hero_skill")
tt.hero.skills.hellish_infusion.hr_order = 3
tt.hero.skills.hellish_infusion.hr_cost = {1,2,3}
tt.hero.skills.hellish_infusion.cooldown = {40,30,20}
tt.hero.skills.hellish_infusion.damage_factor_config = {1.1,1.2,1.3}
tt.hero.skills.hellish_infusion.xp_gain = {60,120,180}
tt.hero.skills.demonic_blast = E:clone_c("hero_skill")
tt.hero.skills.demonic_blast.hr_order = 4
tt.hero.skills.demonic_blast.hr_cost = {2,2,2}
tt.hero.skills.demonic_blast.damage_min = {60,120,180}
tt.hero.skills.demonic_blast.damage_max = {180,360,540}
tt.hero.skills.demonic_blast.xp_gain = {60,120,180}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {1,2,3}
tt.hero.skills.ultimate.cooldown = {[0]=24,21.6,19.2,16}
tt.hero.skills.ultimate.max_targets = {[0]=6,8,10,12}
tt.hero.skills.ultimate.offset_config = {[0]=-15,-25,-35,-45}
tt.hero.skills.ultimate.controller_name = "controller_hero_oloch_ultimate"

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
	180,
	198,
	216,
	234,
	252,
	270,
	288,
	306,
	324,
	342
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
tt.hero.level_stats.selfdestruct_damage_config = {
	50,
	50,
	50,
	50,
	75,
	75,
	75,
	75,
	100,
	100
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
tt.render.sprites[1].anchor.y = 0.12
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].scale = v(1.2,1.2)
tt.render.sprites[1].offset = v(0, -18)
tt.render.sprites[1].prefix = "hero_oloch"
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].offset = v(0,-15)
tt.render.sprites[2].name = "hero_oloch_shadow"
tt.render.sprites[2].anchor.y = 0.12
tt.render.sprites[2].z = Z_DECALS + 1

tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 1
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].damage_type = DAMAGE_MAGICAL
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].xp_gain_factor = 1.2
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 1
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.8
tt.ranged.attacks[1].min_range = 20
tt.ranged.attacks[1].max_range = 160
tt.ranged.attacks[1].xp_gain_factor = 1.6
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "bolt_oloch"
tt.ranged.attacks[1].shoot_time = fts(31)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 44)
}
--4技能 大火球
tt.ranged.attacks[2] = E:clone_c("bullet_attack")
tt.ranged.attacks[2].cooldown = 30
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].animation = "megaBolt"
tt.ranged.attacks[2].sound = "hero_oloch_demonic_cast"
tt.ranged.attacks[2].min_range = 20
tt.ranged.attacks[2].max_range = 175
tt.ranged.attacks[2].bullet = "bolt_oloch_big"
tt.ranged.attacks[2].shoot_time = fts(45)
tt.ranged.attacks[2].bullet_start_offset = {
	v(0, 52)
}
--1技能 分身
tt.timed_attacks.list[1] = CC("spawn_attack")
tt.timed_attacks.list[1].animation = "duplication"
tt.timed_attacks.list[1].cooldown = 25
tt.timed_attacks.list[1].cast_time = fts(12)
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_oloch_illusion"
--tt.timed_attacks.list[1].entity_rotations = {{d2r(0)},{d2r(0),d2r(180)},{d2r(0),d2r(120),d2r(240)}}
tt.timed_attacks.list[1].entity_rotations = {{d2r(0),d2r(180)},{d2r(0),d2r(180)},{d2r(0),d2r(180)}}
tt.timed_attacks.list[1].sound = "hero_oloch_respawn"
tt.timed_attacks.list[1].spawn_time = fts(19)
tt.timed_attacks.list[1].initial_rally = v(0, 30)
tt.timed_attacks.list[1].initial_pos = v(0, 33)
tt.timed_attacks.list[1].radius = 30
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 200
tt.timed_attacks.list[1].spawn_time = fts(19)
tt.timed_attacks.list[1].spawn_time = fts(19)
tt.timed_attacks.list[1].xp_from_skill = "mirage"
tt.timed_attacks.list[1].count = 2
--2技能 岩浆池
tt.timed_attacks.list[2] = E:clone_c("spawn_attack")
tt.timed_attacks.list[2].animation = "magmaEruption"
tt.timed_attacks.list[2].cooldown = 25
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "oloch_magma"
tt.timed_attacks.list[2].spawn_time = fts(30)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 175
tt.timed_attacks.list[2].damage_max = 200
tt.timed_attacks.list[2].damage_min = 200
--3技能 增伤f
tt.auras.list[1] = E:clone_c("mod_attack")
tt.auras.list[1].mod = "range_mod_oloch"
tt.auras.list[1].sound = "hero_oloch_hellish"
tt.auras.list[1].animation = "hellishInfusion"
tt.auras.list[1].cooldown = 40
tt.auras.list[1].range = 150
tt.auras.list[1].damage_inc = 1.0
tt.auras.list[1].disabled = true
tt.auras.list[1].excluded_templates = {}
tt.selfdestruct.animation = "death"
tt.selfdestruct.damage_radius = 60
tt.selfdestruct.damage_type = DAMAGE_PHYSICAL
tt.selfdestruct.damage_max = 100
tt.selfdestruct.damage_min = 100
tt.selfdestruct.hit_time = fts(29)
tt.selfdestruct.sound = "BombExplosionSound"
tt.selfdestruct.sound_args = {
	delay = fts(40)
}

--1技能 分身 参考马格努斯
tt = RT("soldier_oloch_illusion", "soldier_militia")
AC(tt, "reinforcement", "ranged", "tween")
image_x, image_y = 60, 76
anchor_y = 0.14
tt.melee = nil
tt.health.hp_max = 300
tt.health_bar.offset = v(0, 52)
tt.health.dead_lifetime = fts(14)
tt.info.portrait = "gui4_bottom_info_image_heroes_0003"
tt.info.i18n_key = "HERO_OLOCH"
tt.info.random_name_format = nil
tt.info.fn = scripts.soldier_oloch_illusion.get_info
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_reinforcement.update
tt.reinforcement.duration = 10
tt.reinforcement.fade = nil
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].bullet = "bolt_oloch_duplication"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 44)
}
tt.ranged.attacks[1].max_range = 175
tt.ranged.attacks[1].min_range = 20
tt.ranged.attacks[1].damage_max = nil
tt.ranged.attacks[1].damage_min = nil
tt.ranged.attacks[1].shoot_time = fts(31)
tt.ranged.attacks[1].cooldown = 1.8
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "hero_oloch_duplication"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].offset = v(0, -18)
tt.render.sprites[1].alpha = 180
tt.tween.props[1].name = "offset"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 0)
	},
	{
		fts(6),
		v(0, 0)
	}
}
tt.tween.remove = false
tt.tween.run_once = true
tt.ui.click_rect = r(-13, -5, 26, 32)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.price = 0
tt.vis.bans = bor(F_LYCAN, F_SKELETON, F_CANNIBALIZE, F_RANGED)

--2技能 岩浆池 参考冰龙
tt = E:register_t("oloch_magma", "bullet")
E:add_comps(tt, "tween")
tt.main_script.update = kr4_scripts.oloch_magma.update
tt.bullet.damage_max = 20
tt.bullet.damage_min = 20
tt.bullet.damage_radius = 25
tt.bullet.hit_payload = "oloch_magma_lavapool"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = F_FRIEND
tt.bullet.mod = nil
tt.bullet.hit_time = fts(4)
tt.bullet.duration = 2
tt.render.sprites[1].prefix = "hero_oloch_magma_eruption_explotion"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor.y = 0.09027777777777778
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.remove = false
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
		fts(6),
		255
	},
	{
		tt.bullet.duration,
		255
	},
	{
		tt.bullet.duration + fts(10),
		0
	}
}
--tt.tween.props[1].sprite_id = 2
tt.sound_events.delayed_insert = "hero_oloch_duplication"

tt = E:register_t("oloch_magma_lavapool", "aura")
E:add_comps(tt, "render", "tween")
tt.aura.cycle_time = 0.3
tt.aura.duration = 5
tt.aura.mod = "mod_oloch_magma"
tt.aura.radius = 25
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].name = "hero_oloch_magma_eruption_decal_run"
tt.render.sprites[1].offset.y = 20
tt.render.sprites[1].animated = true
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
tt = E:register_t("mod_oloch_magma", "modifier")
E:add_comps(tt, "dps", "render")
tt.dps.damage_min = 7
tt.dps.damage_max = 7
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_PHYSICAL
tt.dps.damage_every = fts(10)
tt.dps.kill = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = 1
tt.modifier.allows_duplicates = false
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].draw_order = 10

--3技能 增伤 参考火龙
--范围buff
local tt = E:register_t("range_mod_oloch", "modifier")

E:add_comps(tt, "render", "tween")
tt.modifier.duration = 6
tt.range_factor = 1.0
tt.range_factor_inc = 0
tt.main_script.insert = kr4_scripts.range_mod_oloch.insert
tt.main_script.remove = kr4_scripts.range_mod_oloch.remove
tt.main_script.update = kr4_scripts.range_mod_oloch.update
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
tt.render.sprites[1].prefix = "hero_oloch_hellish_infusion"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.21
tt.render.sprites[1].offset.y = -10
tt.render.sprites[1].z = Z_TOWER_BASES + 1

--普攻/4技能
tt = RT("bolt_oloch", "bolt")
tt.bullet.damage_max = 78
tt.bullet.damage_min = 42
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "fx_bolt_oloch_hit"
tt.bullet.max_speed = 600
tt.bullet.xp_gain_factor = 1.6
tt.bullet.particles_name = "ps_bolt_oloch"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "hero_oloch_bolt_0001"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "InfernalMageAttack"

tt = RT("bolt_oloch_duplication", "bolt")
tt.bullet.damage_max = 78
tt.bullet.damage_min = 42
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "fx_bolt_oloch_hit"
tt.bullet.max_speed = 600
tt.bullet.particles_name = "ps_bolt_oloch"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "hero_oloch_bolt_0001"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "InfernalMageAttack"

tt = RT("bolt_oloch_big", "bolt")
tt.bullet.damage_max = 78
tt.bullet.damage_min = 42
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "fx_bolt_oloch_big_hit"
tt.bullet.max_speed = 600
tt.bullet.particles_name = "ps_bolt_oloch_big"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].name = "hero_oloch_mega_bolt_0001"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "hero_oloch_demonic_travel"

tt = RT("fx_bolt_oloch_hit", "fx")
tt.render.sprites[1].prefix = "hero_oloch_bolt"
tt.render.sprites[1].name = "hit"

tt = E:register_t("ps_bolt_oloch","ps_bullet_tower_wicked_sisters_basic_trail")
tt.particle_system.animated = true
tt.particle_system.name = "hero_oloch_bolt_particle_run"
tt.particle_system.particle_lifetime = {
    fts(10),
    fts(10)
}

tt = RT("fx_bolt_oloch_big_hit", "fx")
tt.render.sprites[1].prefix = "hero_oloch_mega_bolt"
tt.render.sprites[1].name = "hit"

tt = E:register_t("ps_bolt_oloch_big","ps_bullet_tower_wicked_sisters_basic_trail")
tt.particle_system.animated = true
tt.particle_system.name = "hero_oloch_mega_bolt_particle_run"
tt.particle_system.particle_lifetime = {
    fts(10),
    fts(10)
}

--大招
tt = E:register_t("controller_hero_oloch_ultimate")
E:add_comps(tt, "pos", "main_script", "sound_events")
tt.main_script.update = scripts.hero_oloch_ultimate.update
tt.can_fire_fn = scripts.hero_oloch_ultimate.can_fire_fn
tt.cooldown = 24
tt.teleport_decal = "decal_hero_oloch_ultimate"
tt.vis_bans = bor(F_BOSS)
tt.vis_flags = bor(F_TELEPORT)
tt.sound_cast = "hero_oloch_ultimate"
tt.radius = 80
tt.max_targets = 4
tt.mod_mark = "mod_hero_oloch_ultimate_mark"
tt.mod_teleport = "mod_hero_oloch_ultimate_teleport"

tt = E:register_t("mod_hero_oloch_ultimate_mark", "modifier")

E:add_comps(tt, "mark_flags")

tt.mark_flags.vis_bans = F_TELEPORT
tt.modifier.duration = fts(50)
tt.main_script.queue = scripts.mod_mark_flags.queue
tt.main_script.dequeue = scripts.mod_mark_flags.dequeue
tt.main_script.update = scripts.mod_mark_flags.update

tt = E:register_t("decal_hero_oloch_ultimate", "decal_timed")
tt.render.sprites[1].name = "hero_oloch_teleport_decal_run"
tt.render.sprites[1].z = Z_DECALS

tt = E:register_t("mod_hero_oloch_ultimate_teleport", "mod_teleport")
tt.main_script.remove = scripts.mod_hero_oloch_ultimate_teleport.remove
tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.vis_bans = bor(F_BOSS)
tt.modifier.duration = 1
tt.nodes_offset = -15
tt.dest_valid_node = true
tt.max_times_applied = 1e+99
tt.delay_start = fts(3)
tt.hold_time = 0.34
tt.delay_end = fts(3)
tt.fx_start = "fx_hero_oloch_ultimate"
tt.fx_end = "fx_hero_oloch_ultimate"
--tt.sound_events.insert = "HeroDragonBoneUltimateOut"
--tt.sound_events.remove = "HeroDragonBoneUltimateIn"

tt = E:register_t("fx_hero_oloch_ultimate", "fx")
tt.render.sprites[1].name = "hero_oloch_teleport_modifier_run"


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
tt.info.portrait = "gui4_bottom_info_image_heroes_0005"
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
tt.info.portrait = "gui4_bottom_info_image_heroes_0007"
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
tt.hero.level_stats.melee_damage_min = {
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
tt.hero.level_stats.melee_damage_max = {
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
tt.info.portrait = "gui4_bottom_info_image_heroes_0006"
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
tt.info.portrait = "gui4_bottom_info_image_heroes_0004"
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
tt.hero.level_stats.melee_damage_min = {
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
tt.hero.level_stats.melee_damage_max = {
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
tt.health_bar.offset = v(0, 80)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_ranged_with_damage_factor
tt.main_script.update = kr4_scripts.hero_tank.update
tt.main_script.insert = kr4_scripts.hero_tank.insert
tt.hero.fn_level_up = kr4_scripts.hero_tank.level_up
tt.info.portrait = "gui4_bottom_info_image_heroes_0009"
tt.info.hero_portrait = "kra_hero_portraits_0408"
tt.info.i18n_key = "HERO_TANK"
tt.info.ultimate_icon = "0408"
tt.motion.max_speed = 2.5 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "group_tank_taunt"
tt.sound_events.death = "hero_tank_death"
tt.sound_events.hero_room_select = "hero_tank_taunt_1"
tt.sound_events.insert = "group_tank_taunt"
tt.sound_events.respawn = "group_tank_taunt"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 0)
tt.overwhelm_entity = "controller_overwhelm_tank"
tt.hero.skills.heat_missiles = E:clone_c("hero_skill")
tt.hero.skills.heat_missiles.hr_order = 1
tt.hero.skills.heat_missiles.count = {4,6,8}
tt.hero.skills.heat_missiles.damage_min_config = {16,22,32}
tt.hero.skills.heat_missiles.damage_max_config = {24,34,48}
tt.hero.skills.heat_missiles.xp_gain = {[0]=60,60,120,180}
tt.hero.skills.heat_missiles.hr_cost = {2,2,2}
tt.hero.skills.ground_slam = E:clone_c("hero_skill")
tt.hero.skills.ground_slam.hr_order = 2
tt.hero.skills.ground_slam.hr_cost = {2,2,2}
tt.hero.skills.ground_slam.xp_gain = {250,500,750}
tt.hero.skills.ground_slam.damage_min_config = {21,42,63}
tt.hero.skills.ground_slam.damage_max_config = {39,78,117}
tt.hero.skills.expendables = E:clone_c("hero_skill")
tt.hero.skills.expendables.hr_order = 3
tt.hero.skills.expendables.hr_cost = {1,2,3}
tt.hero.skills.expendables.entity = {"hero_tank_expendables_lvl1","hero_tank_expendables_lvl2","hero_tank_expendables_lvl3"}
tt.hero.skills.scorching_cannon = E:clone_c("hero_skill")
tt.hero.skills.scorching_cannon.hr_order = 4
tt.hero.skills.scorching_cannon.hr_cost = {2,2,2}
tt.hero.skills.scorching_cannon.cooldown = {35,33,30}
tt.hero.skills.scorching_cannon.xp_gain = {200,400,600}
tt.hero.skills.scorching_cannon.damage_config = {2,4,6}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {3,4,5}
tt.hero.skills.ultimate.cooldown = {[0]=48,48,48,48}
tt.hero.skills.ultimate.controller_name = "controller_hero_tank_ultimate"

--原版为0.03秒伤害一次，改版为0.3秒伤害一次
--动画参考5代机甲的大招，伤害机制参考浮士德的大招
tt.hero.skills.ultimate.damage_config = {[0]=7,10,24,40}--2,3,7,12/0.03

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

--动画
tt.render.sprites[1].anchor.y = 0.02
tt.render.sprites[1].offset.y = -40
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_tank"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].name = "hero_tank_ultimate_plane_shadow"
tt.render.sprites[2].z = Z_DECALS + 1

tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 3
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].vis_bans = bor(F_FLYING, F_NIGHTMARE)
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "bullet_tank"
tt.ranged.attacks[1].node_prediction = fts(25)
tt.ranged.attacks[1].shoot_time = fts(23)
tt.ranged.attacks[1].bullet_start_offset = {
	v(8, 38)
}
--1技能 导弹 参考高达的导弹发射
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].animation_pre = "HeatMissilesIn"
tt.timed_attacks.list[1].animation = "HeatMissilesLoop"
tt.timed_attacks.list[1].animation_last = "HeatMissilesLastLoop"
tt.timed_attacks.list[1].animation_post = "HeatMissilesOut"
tt.timed_attacks.list[1].cooldown = 20
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].bullet = "missle_tank"
tt.timed_attacks.list[1].start_offsets = {v(4, 60)}
tt.timed_attacks.list[1].sound = "hero_lucerna_summon"
tt.timed_attacks.list[1].hit_times = {fts(3)}
tt.timed_attacks.list[1].launch_vector = v(math.random(10, 40), math.random(30, 120))
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = F_NIGHTMARE
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 600
--2技能 震地 参考天十的震地
--[[
tt.timed_attacks.list[2] = E:clone_c("bullet_attack")
tt.timed_attacks.list[2].animation = "GroundSlam"
tt.timed_attacks.list[2].cooldown = 30
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "missle_tank"
tt.timed_attacks.list[2].sound = "hero_lucerna_summon"
tt.timed_attacks.list[2].spawn_time = fts(10)
tt.timed_attacks.list[2].vis_flags = F_RANGED
tt.timed_attacks.list[2].vis_bans = 0
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 200
]]
tt.timed_attacks.list[2] = CC("area_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].cooldown = 30
tt.timed_attacks.list[2].animation = "GroundSlam"
tt.timed_attacks.list[2].count = 10
tt.timed_attacks.list[2].sound_pre = "hero_tank_groundslam_lift"
tt.timed_attacks.list[2].sound = "hero_tank_groundslam_impact"
tt.timed_attacks.list[2].damage_max = 0
tt.timed_attacks.list[2].damage_min = 0
tt.timed_attacks.list[2].damage_radius = 50
tt.timed_attacks.list[2].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[2].hit_decal = "decal_ground_hit"
tt.timed_attacks.list[2].hit_fx = "fx_ground_hit"
tt.timed_attacks.list[2].hit_offset = v(0, 0)
tt.timed_attacks.list[2].hit_time = fts(38)
tt.timed_attacks.list[2].hit_aura = "aura_tank_skill2_bomb"
tt.timed_attacks.list[2].min_count = 1
tt.timed_attacks.list[2].min_range = 20
tt.timed_attacks.list[2].max_range = 200
tt.timed_attacks.list[2].min_nodes = 5
tt.timed_attacks.list[2].max_nodes = 20
tt.timed_attacks.list[2].pop = {
	"pop_kapow",
	"pop_whaam"
}
tt.timed_attacks.list[2].pop_chance = 0.3
tt.timed_attacks.list[2].pop_conds = DR_KILL
tt.timed_attacks.list[2].sound_short = "TenShiBuffedBombAttack"
tt.timed_attacks.list[2].sound_long = "TenShiBuffedBombAttackLong"
tt.timed_attacks.list[2].sound = tt.timed_attacks.list[2].sound_short
tt.timed_attacks.list[2].xp_from_skill = "buffed"
--4技能 旋转燃烧  参考腐森的in run out
tt.timed_attacks.list[3] = E:clone_c("bullet_attack")
tt.timed_attacks.list[3].animation_pre = "scorchingCannonIn"
tt.timed_attacks.list[3].animation = "scorchingCannonLoop"
tt.timed_attacks.list[3].animation_post = "scorchingCannonOut"
tt.timed_attacks.list[3].cooldown = 35
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].entity = "aura_roundfire_hero_tank"
tt.timed_attacks.list[3].sound_pre = "hero_tank_scorching_loopstart"
tt.timed_attacks.list[3].sound = "hero_tank_scorching_loop"
tt.timed_attacks.list[3].sound_post = "hero_tank_scorching_loopend"
tt.timed_attacks.list[3].spawn_time = fts(10)
tt.timed_attacks.list[3].vis_flags = F_RANGED
tt.timed_attacks.list[3].vis_bans = 0
tt.timed_attacks.list[3].min_range = 0
tt.timed_attacks.list[3].max_range = 100

--被动效果
tt = E:register_t("controller_overwhelm_tank", "decal_scripted")
E:add_comps(tt,"ranged")
tt.owner = nil
tt.owner_idx = nil
tt.ranged.attacks[1].cooldown_min = 30
tt.ranged.attacks[1].cooldown_max = 60
tt.ranged.attacks[1].cooldown = 0.2
tt.ranged.attacks[1].start_offset_y = 1
tt.ranged.attacks[1].bullet = "bullet_overwhelm_tank"
tt.main_script.update = scripts.controller_overwhelm_tank.update

tt = E:register_t("bullet_overwhelm_tank", "bullet")
tt.bullet.min_speed = 180 * FPS
tt.bullet.max_speed = 180 * FPS
tt.bullet.acceleration_factor = 0.05
tt.bullet.hit_fx = nil
--tt.bullet.hit_decal = "hero_murglun_ultimate_rocks_run"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_radius = 100
tt.bullet.damage_min = 1
tt.bullet.damage_max = 1
tt.bullet.damage_factor = 1
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = F_FLYING
tt.render.sprites[1].name = "hero_tank_ultimate_plane_shadow"
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.main_script.update = kr4_scripts.lava_blood_murglun.update
tt.scorch_earth = false
tt.sound_events.insert = nil
tt.sound_events.hit = nil

--普攻
tt = RT("bullet_tank", "bombKR5")
tt.bullet.flight_time = fts(25)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "fx_explosion_tank"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 40
tt.bullet.min_speed = 300
tt.bullet.damage_max = 40
tt.bullet.damage_radius = 40
tt.bullet.pop = nil
tt.bullet.to = v(0,0)
tt.bullet.from = v(0,0)
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.bullet.xp_gain_factor = 0.8
tt.render.sprites[1].name = "hero_tank_simple_proyectile"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "BombShootSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"

local fx_explosion_big = E:register_t("fx_explosion_tank", "fx")

fx_explosion_big.render.sprites[1].prefix = "hero_tank_hit"
fx_explosion_big.render.sprites[1].name = "run"
fx_explosion_big.render.sprites[1].offset = v(0,0)
fx_explosion_big.render.sprites[1].scale = v(1.2,1.2)
fx_explosion_big.render.sprites[1].anchor.y = 0.13
fx_explosion_big.render.sprites[1].z = Z_OBJECTS
fx_explosion_big.render.sprites[1].sort_y_offset = 0 -- -2

local fx_explosion_big = E:register_t("fx_explosion_tank_air", "fx")

fx_explosion_big.render.sprites[1].prefix = "hero_tank_hit_air"
fx_explosion_big.render.sprites[1].name = "run"
fx_explosion_big.render.sprites[1].offset = v(0, 0)
fx_explosion_big.render.sprites[1].scale = v(1.2,1.2)
fx_explosion_big.render.sprites[1].anchor.y = 0.13
fx_explosion_big.render.sprites[1].z = Z_OBJECTS
fx_explosion_big.render.sprites[1].sort_y_offset = 0 -- -2

--1技能 导弹
local missile_mecha = E:register_t("missle_tank", "bullet")
missile_mecha.render.sprites[1].name = "hero_tank_missile_proyectile"
missile_mecha.render.sprites[1].animated = false
missile_mecha.render.sprites[1].loop = true
missile_mecha.render.sprites[1].flip_x = true
missile_mecha.bullet.damage_type = DAMAGE_PHYSICAL
missile_mecha.bullet.min_speed = 300
missile_mecha.bullet.max_speed = 600
missile_mecha.bullet.turn_speed = 10 * math.pi / 180 * 30
missile_mecha.bullet.acceleration_factor = 0.2
missile_mecha.bullet.hit_fx = "fx_explosion_tank"
missile_mecha.bullet.hit_fx_air = "fx_explosion_tank_air"
missile_mecha.bullet.hit_fx_water = "fx_explosion_water"
missile_mecha.bullet.damage_min = 20
missile_mecha.bullet.damage_max = 80
missile_mecha.bullet.damage_radius = 40
missile_mecha.bullet.vis_flags = F_RANGED
missile_mecha.bullet.damage_flags = F_AREA
missile_mecha.bullet.particles_name = "ps_missile_tank"
missile_mecha.bullet.retarget_range = 99999
missile_mecha.bullet.pirates_pillage_rate = 0
missile_mecha.bullet.got_gold = 3
missile_mecha.main_script.insert = scripts.missile_tank.insert
missile_mecha.main_script.update = scripts.missile_tank.update
missile_mecha.sound_events.insert = "RocketLaunchSound"
missile_mecha.sound_events.hit = "BombExplosionSound"
missile_mecha.sound_events.hit_water = "RTWaterExplosion"

tt = E:register_t("ps_missile_tank")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "hero_tank_missile_particle_run"
tt.particle_system.animated = true
tt.particle_system.animation_fps = 50
tt.particle_system.loop = false
tt.particle_system.alphas = { 255, 0 }
tt.particle_system.particle_lifetime = {
	fts(16),
	fts(16)
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

--2技能 震地
tt = RT("aura_tank_skill2_bomb", "aura")
tt.aura.fx = "decal_tank_spike"
tt.sound = "hero_tank_scorching_loop"
tt.aura.damage_radius = 50
tt.aura.last_attack_damage_radius = 60
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.vis_flags = bor(F_RANGED)
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.step_delay = fts(2)
tt.aura.step_nodes = 6
tt.aura.steps = 5
tt.main_script.update = kr4_scripts.aura_tank_skill2_bomb.update
tt.stun = {}
tt.stun.vis_flags = bor(F_RANGED, F_STUN)
tt.stun.vis_bans = bor(F_BOSS)
tt.stun.mod = "mod_tank_skill2_stun"
tt.aura.damage_min = 10
tt.aura.damage_max = 20
tt.aura.stun_chance = 1
tt.aura.min_nodes = 0
tt.aura.max_nodes = 25
tt.aura.min_count = 1
tt = RT("mod_tank_skill2_stun", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.modifier.duration = 2
tt = RT("decal_tank_spike", "decal_bomb_crater")
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "hero_tank_GroundSlam_decal_run"
tt.render.sprites[2].hide_after_runs = 1
tt.render.sprites[2].anchor.y = 0.24

--大招
tt = E:register_t("controller_hero_tank_ultimate")

E:add_comps(tt, "pos", "main_script", "sound_events")

tt.can_fire_fn = scripts.hero_tank_ultimate.can_fire_fn
tt.cooldown = 48
tt.entity = "zeppelin_hero_tank"
tt.main_script.update = scripts.hero_tank_ultimate.update
tt.sound = "hero_tank_ultimate"

tt = E:register_t("zeppelin_hero_tank", "decal_scripted")
b = balance.heroes.hero_mecha.ultimate

E:add_comps(tt, "force_motion", "ranged")

tt.decal = "decal_hero_tank_ultimate"
tt.main_script.update = scripts.zeppelin_hero_tank.update
tt.force_motion.max_a = 1500
tt.force_motion.max_v = b.speed_out_of_range
tt.force_motion.ramp_radius = 30
tt.force_motion.fr = 0.05
tt.force_motion.a_step = 40
tt.flight_height = 150
tt.flight_height_attack = 30
tt.duration = b.duration
tt.start_ts = nil
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "hero_tank_ultimate_plane_fly"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].group = "layers"
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].z = Z_FLYING_HEROES

tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].bullet = "bullet_zeppelin_hero_tank"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 105)
}
tt.ranged.attacks[1].cooldown = b.ranged_attack.cooldown
tt.ranged.attacks[1].max_range = b.ranged_attack.max_range
tt.ranged.attacks[1].min_range = b.ranged_attack.min_range
tt.ranged.attacks[1].damage_type = b.ranged_attack.damage_type
tt.ranged.attacks[1].damage_min_config = b.ranged_attack.damage_min
tt.ranged.attacks[1].damage_max_config = b.ranged_attack.damage_max
tt.ranged.attacks[1].shoot_time = fts(4)
tt.ranged.attacks[1].sound_args = {
	delay = fts(14)
}
tt.ranged.attacks[1].sound_chance = 0.5
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE, F_CLIFF)
tt.ranged.attacks[1].xp_gain_factor = b.ranged_attack.xp_gain_factor
tt.ranged.attacks[1].basic_attack = true
tt.speed_out_of_range = b.speed_out_of_range
tt.speed_in_range = b.speed_in_range
tt.attack_radius = b.attack_radius

tt = E:register_t("decal_hero_tank_ultimate", "decal_tween")
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "hero_tank_ultimate_plane_shadow"
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		1,
		255
	},
	{
		9,
		255
	},
	{
		12,
		0
	}
}
tt.tween.run_once = true

--坦克大招的炸弹
tt = E:register_t("bullet_zeppelin_hero_tank", "bombKR5")
b = balance.heroes.hero_mecha.ultimate
tt.bullet.flight_time = fts(20)
tt.bullet.hit_fx = "fx_bullet_zeppelin_hero_tank"
tt.bullet.hit_payload = "decal_bullet_zeppelin_hero_tank"
tt.bullet.align_with_trajectory = false
tt.bullet.ignore_hit_offset = true
tt.bullet.pop_chance = 0.5
tt.bullet.rotation_speed = 10
tt.sound_events.insert = "HeroMechaDeathFromAboveAttack"
tt.sound_events.hit = "hero_tank_ultimate_flame"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "hero_tank_ultimate_proyectile"

tt = E:register_t("fx_bullet_zeppelin_hero_tank", "fx")
tt.render.sprites[1].name = "hero_tank_ultimate_proyectile_explosion_run"

--燃烧效果
tt = E:register_t("decal_bullet_zeppelin_hero_tank", "decal_scripted")
E:add_comps(tt,"ranged")
tt.owner = nil
tt.owner_idx = nil
tt.aura_entity = "aura_bullet_zeppelin_hero_tank"
tt.entity_count = 6
tt.main_script.update = kr4_scripts.decal_bullet_zeppelin_hero_tank.update

tt = E:register_t("aura_bullet_zeppelin_hero_tank", "aura")
E:add_comps(tt, "render")
tt.render.sprites[1].loopin = "hero_tank_ultimate_fire_in"
tt.render.sprites[1].prefix = "hero_tank_ultimate_fire"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].scale = v(1.3, 1.3)
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].z = Z_DECALS + 1
tt.aura.duration = 4.4
tt.aura.mods = {
	"mod_bullet_zeppelin_hero_tank"
}
tt.aura.cycle_time = 0.1
tt.aura.radius = 70
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD, F_AREA)
tt.main_script.insert = kr4_scripts.aura_apply_mod_tank.insert
tt.main_script.update = kr4_scripts.aura_apply_mod_tank.update

local tt = E:register_t("mod_bullet_zeppelin_hero_tank", "modifier")

E:add_comps(tt, "dps", "render")
tt.modifier.allows_duplicates = false
tt.modifier.duration = 0.4
tt.dps.damage_min = 7
tt.dps.damage_max = 7
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_PHYSICAL
tt.dps.damage_every = 0.1
tt.render.sprites[1].prefix = "hero_tank_ultimate_fire_modifier"
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
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update


tt = E:register_t("aura_roundfire_hero_tank", "aura")
E:add_comps(tt, "render")
tt.render.sprites[1].prefix = "hero_tank_fire_loop"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].z = Z_DECALS + 1
tt.aura.duration = 4
tt.aura.mods = {
	"mod_roundfire_hero_tank"
}
tt.aura.cycle_time = 0.2
tt.aura.radius = 65
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD, F_AREA)
tt.main_script.insert = kr4_scripts.aura_apply_mod_tank.insert
tt.main_script.update = kr4_scripts.aura_apply_mod_tank.update

local tt = E:register_t("mod_roundfire_hero_tank", "modifier")

E:add_comps(tt, "dps", "render")

tt.modifier.duration = 0.4
tt.dps.damage_min = 2
tt.dps.damage_max = 2
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 0.2
tt.render.sprites[1].prefix = "hero_tank_fire"
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
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update

--3技能 召唤物

tt = E:register_t_10086("fx_expendables_respawn", "fx")
tt.render.sprites[1].name = "hero_tank_expendable1_spawn"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10

tt = E:register_t_10086("fx_expendables_respawn2", "fx")
tt.render.sprites[1].name = "hero_tank_expendable2_spawn"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -10

tt = E:register_t("hero_tank_expendables_lvl1", "soldier_militia")

E:add_comps(tt, "melee", "nav_grid")
tt.info.i18n_key = "HERO_TANK_EXPENDABLES"
tt.info.enc_icon = 12
tt.info.portrait = "gui4_bottom_info_image_heroes_0010"
tt.info.is_here_pandas = 1
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk"
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_tank_expendable1"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0.11
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].name = "hero_tank_expendable2_shadow"
tt.render.sprites[2].z = Z_DECALS + 1
tt.unit.hit_offset = v(0, 16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.health_bar.offset = v(0, 28)
tt.main_script.insert = kr4_scripts.soldier_hero_tank_expendables_apprentice.insert
tt.main_script.update = kr4_scripts.soldier_hero_tank_expendables_apprentice.update
tt.regen.health = 7
tt.regen.cooldown = 1
tt.idle_flip.last_animation = "idle"
tt.melee.range = 60
tt.melee.attacks[1] = E:clone_c("melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 7
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = fts(2)
tt.melee.attacks[1].animation = "melee"
tt.respawn_fx = "fx_expendables_respawn"
tt.respawn_fx_timing = fts(9)
tt.unit.fade_time_after_death = nil
tt.ui.click_rect = r(-12, -5, 24, 30)
tt.not_draggable = true
tt.health.dead_lifetime = 15
tt.health.hp_max = 160
tt.health.ignore_delete_after = true
tt.motion.max_speed = 75
tt.soldier.melee_slot_offset = v(12, 0)
tt.ignore_linirea_true_might_revive = true

--3技能 召唤物
tt = E:register_t("hero_tank_expendables_lvl2", "hero_tank_expendables_lvl1")
tt.render.sprites[1].prefix = "hero_tank_expendable1"
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 6
tt.health.hp_max = 200

--3技能 召唤物
tt = E:register_t("hero_tank_expendables_lvl3", "hero_tank_expendables_lvl2")
E:add_comps(tt, "ranged")
tt.render.sprites[1].prefix = "hero_tank_expendable2"
tt.melee.attacks[1].damage_max = 13
tt.melee.attacks[1].damage_min = 7
tt.melee.range = 50
tt.respawn_fx = "fx_expendables_respawn2"
tt.info.portrait = "gui4_bottom_info_image_heroes_0011"
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "shotgun_hero_tank_expendables"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 12)
}
tt.ranged.attacks[1].cooldown = 0.9
tt.ranged.attacks[1].max_range = 175
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = fts(16)
tt.ranged.attacks[1].vis_bans = bor(F_NIGHTMARE)

tt = RT("shotgun_hero_tank_expendables", "shotgun")
tt.bullet.damage_max = 13
tt.bullet.damage_min = 7
tt.bullet.hit_blood_fx = "fx_blood_splat"
--tt.bullet.miss_fx = "fx_smoke_bullet"
--tt.bullet.start_fx = "fx_rifle_smoke"
tt.bullet.min_speed = 20 * FPS
tt.bullet.max_speed = 20 * FPS
tt.sound_events.insert = "ShotgunSound"

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
tt.hero.fn_level_up = kr4_scripts.hero_beresad.level_up
tt.main_script.insert = kr4_scripts.hero_beresad.insert
tt.main_script.update = kr4_scripts.hero_beresad.update
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
tt.modifier.duration = 3.99
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
tt.bullet.damage_radius = 50
tt.bullet.damage_min = 23
tt.bullet.damage_max = 23
tt.bullet.damage_factor = 1
tt.bullet.damage_flags = F_AREA
tt.render.sprites[1].name = "hero_murglun_lava_blood_proy"
tt.render.sprites[1].flip_x = true
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


--火龙增伤buff
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
E:add_comps(tt, "ranged", "timed_attacks", "auras", "teleport")
tt.health.dead_lifetime = 27
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 168)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.hero_portrait = "kra_hero_portraits_0417"
tt.info.i18n_key = "HERO_LUCERNA"
tt.info.ultimate_icon = "0417"
tt.info.fn = kr4_scripts.hero_lucerna.get_info
tt.hero.fn_level_up = kr4_scripts.hero_lucerna.level_up
tt.main_script.insert = kr4_scripts.hero_lucerna.insert
tt.main_script.update = kr4_scripts.hero_lucerna.update
tt.info.portrait = "gui4_bottom_info_image_heroes_0020"
tt.motion.max_speed = 1.3 * FPS
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "group_lucerna_taunt"
tt.sound_events.death = "hero_lucerna_death"
tt.sound_events.hero_room_select = "hero_lucerna_taunt_1"
tt.sound_events.insert = "hero_lucerna_taunt_1"
tt.sound_events.respawn = "hero_lucerna_respawn"
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
--不能飞到水上
tt.all_except_flying_nowalk = bor(TERRAIN_LAND, TERRAIN_ICE)
tt.nav_grid.valid_terrains = tt.all_except_flying_nowalk
tt.nav_grid.valid_terrains_dest = tt.all_except_flying_nowalk
tt.drag_line_origin_offset = v(0, 100)
tt.teleport.min_distance = 150
tt.teleport.delay = 0
tt.teleport.sound = "hero_lucerna_teleport"
tt.teleport.animations = {
	"teleportOut",
	"teleportIn"
}
tt.ui.click_rect = r(-45, 30, 90, 90)
tt.unit.head_offset = v(0, 130)
tt.unit.hit_offset = v(0, 92)
tt.unit.mod_offset = v(0, 91)
tt.unit.marker_offset = v(0, 130)
tt.unit.mod_offset = v(0, 130+20)
for i = 1,6 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].anchor.y = 0.04
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].prefix = "Lucerna_Ship_layer"..i
	tt.render.sprites[i].angles = {walk = "idle"}
	tt.render.sprites[i].z = Z_FLYING_HEROES
	tt.render.sprites[i].group = "layers"
end
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].animated = false
tt.render.sprites[7].is_shadow = true
tt.render.sprites[7].name = "Lucerna_Ship_shadow"
tt.render.sprites[7].z = Z_DECALS + 1
tt.hero.skills.scurvy_vissage = E:clone_c("hero_skill")
tt.hero.skills.scurvy_vissage.hr_order = 1
tt.hero.skills.scurvy_vissage.hr_cost = {3,3,3}
tt.hero.skills.scurvy_vissage.xp_gain = {125,250,375}
tt.hero.skills.scurvy_vissage.duration = {1.5,2,2.5}
tt.hero.skills.scurvy_vissage.damage_duration = {3,4,5}
tt.hero.skills.fire_at_will = E:clone_c("hero_skill")
tt.hero.skills.fire_at_will.hr_order = 2
tt.hero.skills.fire_at_will.hr_cost = {2,1,1}
tt.hero.skills.fire_at_will.damage_config = {40,60,80}
tt.hero.skills.fire_at_will.count = {6,7,8}
tt.hero.skills.fire_at_will.xp_gain = {60,120,180}
tt.hero.skills.damned_crew = E:clone_c("hero_skill")
tt.hero.skills.damned_crew.hr_order = 3
tt.hero.skills.damned_crew.hr_cost = {3,2,3}
tt.hero.skills.damned_crew.cooldown = {14,12,10}
tt.hero.skills.damned_crew.xp_gain = {60,120,180}
tt.hero.skills.pirates_pillage = E:clone_c("hero_skill")
tt.hero.skills.pirates_pillage.hr_order = 4
tt.hero.skills.pirates_pillage.hr_cost = {2,2,2}
tt.hero.skills.pirates_pillage.rate = {0.1,0.25,0.4}
tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.hr_cost = {3,3,3}
tt.hero.skills.ultimate.controller_name = "hero_lucerna_ultimate"
tt.hero.skills.ultimate.duration = {[0]=7,7,7,7}
tt.hero.skills.ultimate.cooldown = {[0]=48,48,48,48}

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
--普攻
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].cooldown = 1.8
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 250
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].bullet = "bullet_lucerna"
tt.ranged.attacks[1].shoot_time = fts(3)
tt.ranged.attacks[1].bullet_start_offset = {
	v(40, 90)
}
--3技能
tt.timed_attacks.list[1] = E:clone_c("spawn_attack")
tt.timed_attacks.list[1].animation = "summon"
tt.timed_attacks.list[1].cooldown = 14
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "hero_lucerna_golem"
tt.timed_attacks.list[1].sound = "hero_lucerna_summon"
tt.timed_attacks.list[1].spawn_time = fts(10)
tt.timed_attacks.list[1].vis_flags = F_BLOCK
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 100
--2技能 轰炸
tt.timed_attacks.list[2] = E:clone_c("spawn_attack")
tt.timed_attacks.list[2].animation = "ability"
tt.timed_attacks.list[2].cooldown = 20
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "ability_lucerna"
tt.timed_attacks.list[2].spawn_time = fts(15)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 200
tt.timed_attacks.list[2].damage_max = 40
tt.timed_attacks.list[2].damage_min = 40
--1技能 恐惧
tt.timed_attacks.list[3] = E:clone_c("bullet_attack")
tt.timed_attacks.list[3].skill = "range_unit"
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].entity = "hero_lucerna_modifier_fear"
tt.timed_attacks.list[3].damage_entity = "hero_lucerna_modifier_fear_damage"
tt.timed_attacks.list[3].max_target = 6
tt.timed_attacks.list[3].min_range = 0
tt.timed_attacks.list[3].max_range = 150
tt.timed_attacks.list[3].cooldown = 45
tt.timed_attacks.list[3].lucerna_animation = "hero_lucerna_fear_run"
tt.timed_attacks.list[3].cast_time = fts(15)
tt.timed_attacks.list[3].node_prediction = fts(17)
tt.timed_attacks.list[3].sync_animation = true
tt.timed_attacks.list[3].animation = "fear"
tt.timed_attacks.list[3].sound = "hero_lucerna_scare"
tt.timed_attacks.list[3].bullet_start_offset = {
	v(41, 72)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND, F_NIGHTMARE, F_FLYING, F_CLIFF, F_WATER)

local missile_mecha = E:register_t("bullet_lucerna", "bullet")

missile_mecha.render.sprites[1].prefix = "Lucerna_projectile"
missile_mecha.render.sprites[1].loop = true
missile_mecha.render.sprites[1].flip_x = true
missile_mecha.bullet.damage_type = DAMAGE_MAGICAL
missile_mecha.bullet.min_speed = 300
missile_mecha.bullet.max_speed = 600
missile_mecha.bullet.turn_speed = 10 * math.pi / 180 * 30
missile_mecha.bullet.acceleration_factor = 0.2
missile_mecha.bullet.hit_fx = "fx_explosion_lucerna"
missile_mecha.bullet.hit_fx_air = "fx_explosion_lucerna_air"
missile_mecha.bullet.hit_fx_water = "fx_explosion_water"
missile_mecha.bullet.damage_min = 20
missile_mecha.bullet.damage_max = 80
missile_mecha.bullet.damage_radius = 55
missile_mecha.bullet.vis_flags = F_RANGED
missile_mecha.bullet.xp_gain_factor = 0.8
missile_mecha.bullet.damage_flags = F_AREA
missile_mecha.bullet.particles_name = "ps_missile_lucerna"
missile_mecha.bullet.retarget_range = 99999
missile_mecha.bullet.pirates_pillage_rate = 0
missile_mecha.bullet.got_gold = 3
missile_mecha.main_script.insert = scripts.missile_lucerna.insert
missile_mecha.main_script.update = scripts.missile_lucerna.update
missile_mecha.sound_events.insert = "RocketLaunchSound"
missile_mecha.sound_events.hit = "BombExplosionSound"
missile_mecha.sound_events.hit_water = "RTWaterExplosion"
--[[
tt = E:register_t("ps_missile_lucerna")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "Lucerna_projectileTrail_run"
tt.particle_system.animated = true
tt.particle_system.animation_fps = 50
tt.particle_system.loop = false
tt.particle_system.alphas = { 255, 0 }
tt.particle_system.particle_lifetime = {
	fts(16),
	fts(16)
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
]]
--[[
tt = E:register_t("ps_missile_lucerna")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "Lucerna_projectileTrail_run"
tt.particle_system.animated = true
tt.particle_system.animation_fps = 15
tt.particle_system.particle_lifetime = {
	1.6,
	1.8
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_x = {
	1,
	3
}
tt.particle_system.scales_y = {
	1,
	3
}
tt.particle_system.scale_var = {
	0.4,
	0.95
}
tt.particle_system.scale_same_aspect = false
tt.particle_system.emit_spread = math.pi
tt.particle_system.emission_rate = 30
]]

tt = E:register_t("ps_missile_lucerna")
E:add_comps(tt, "pos", "particle_system")
tt.particle_system.name = "Lucerna_projectileTrail_run"
tt.particle_system.animated = true
tt.particle_system.animation_fps = 50
tt.particle_system.loop = false
tt.particle_system.alphas = { 255, 0 }
tt.particle_system.particle_lifetime = {
	fts(16),
	fts(16)
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

tt = E:register_t("hero_lucerna_ultimate")
E:add_comps(tt, "user_item", "pos", "main_script", "user_selection","sound_events", "attacks", "render")
tt.can_fire_fn = kr4_scripts.controller_lucerna_ultimate.can_fire_fn
--tt.sound_events.insert = "HeroEiskaltBreath"
tt.level = 0
tt.cooldown = 48
tt.entity = "totem_lucerna"
tt.main_script.update = kr4_scripts.lucerna_ultimate.update


tt = E:register_t("totem_lucerna")
E:add_comps(tt, "pos", "main_script","sound_events", "attacks", "render")
tt.level = 0
tt.duration = 7
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].anchor.y = 0.04
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "Lucerna_totemDecal"
tt.render.sprites[1].animated = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].offset = v(0,-38)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].offset = v(0,-38)
tt.render.sprites[2].anchor.y = 0.04
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].animated = true
tt.render.sprites[2].prefix = "Lucerna_totem"
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].animation = "summon"
tt.attacks.list[1].bullet_start_offset = {
	v(0, -11),
	v(0, 6)
}
tt.attacks.list[1].bullet = {
	"fx_bolt_possession_spawn_lucerna",
	"bolt_possession_lucerna",
}
tt.attacks.list[1].cooldown = 0.85
tt.attacks.list[1].range = 150
tt.attacks.list[1].vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING, F_NIGHTMARE, F_CLIFF, F_WATER)
tt.attacks.list[1].vis_flags = bor(F_RANGED, F_BLOCK, F_POLYMORPH)
tt.attacks.list[1].shoot_time = 0.3
tt.attacks.list[1].excluded_templates = {}
tt.main_script.update = kr4_scripts.totem_lucerna.update
tt.sound_events.sound_in = "hero_lucerna_ultimate_in"
tt.sound_events.sound_out = "hero_lucerna_ultimate_out"
tt.sound_events.sound_cast = "hero_lucerna_ultimate_flagcast"

--策反
tt = E:register_t("fx_bolt_possession_spawn_lucerna", "fx")
tt.render.sprites[1].name = "Lucerna_possession_projectile_spawn"
tt.render.sprites[1].anchor = v(0.5, 0.14)
tt.render.sprites[1].z = Z_OBJECTS + 1

tt = E:register_t("fx_bolt_possession_hit_lucerna", "fx_bolt_possession_hit")
tt.render.sprites[1].name = "Lucerna_possession_projectile_hit"

tt = RT("mod_possession_lucerna", "mod_possession")
tt.render.sprites[1].prefix = "Lucerna_possession_decal"
tt.possession_duration = {[0]=8,9,11,13}

tt = E:register_t("bolt_possession_lucerna", "initial_bolt")
tt.render.sprites[1].name = "Lucerna_possession_projectile_travel"
tt.bullet.mod = "mod_possession_lucerna"
tt.bullet.hit_fx = "fx_bolt_possession_hit_lucerna"
tt.sound_events.insert = "hero_lucerna_ultimate_flagcast"
tt.sound_events.hit = "hero_lucerna_possession_hit"

tt = E:register_t("hero_lucerna_golem", "deckhand_goblin_red_lvl1")
AC(tt, "reinforcement")
tt.main_script.update = kr4_scripts.soldier_golem_lucerna.update
tt.health_bar.offset = v(0, 50)
tt.health.armor = 0
tt.health.hp_max = 120
tt.regen.health = 0
tt.regen.cooldown = 2
tt.info.portrait = "gui4_bottom_info_image_soldiers_0059"
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.render.sprites[1].prefix = "lucerna_unitghosts"
tt.render.sprites[1].name = "idle"
tt.reinforcement.duration = 7.5
tt.reinforcement.fade = true
tt.patrol_pos_offset = v(15, 10)
tt.patrol_min_cd = 3
tt.patrol_max_cd = 6

local fx_explosion_big = E:register_t("fx_explosion_lucerna", "fx")

fx_explosion_big.render.sprites[1].prefix = "Lucerna_explosion"
fx_explosion_big.render.sprites[1].name = "run"
fx_explosion_big.render.sprites[1].offset = v(0, -30)
fx_explosion_big.render.sprites[1].scale = v(1.4,1.4)
fx_explosion_big.render.sprites[1].anchor.y = 0.13
fx_explosion_big.render.sprites[1].z = Z_OBJECTS
fx_explosion_big.render.sprites[1].sort_y_offset = 0 -- -2

local fx_explosion_big = E:register_t("fx_explosion_lucerna_air", "fx")

fx_explosion_big.render.sprites[1].prefix = "Lucerna_explosion"
fx_explosion_big.render.sprites[1].name = "run"
fx_explosion_big.render.sprites[1].offset = v(0, -15)
fx_explosion_big.render.sprites[1].scale = v(1.4,1.4)
fx_explosion_big.render.sprites[1].anchor.y = 0.13
fx_explosion_big.render.sprites[1].z = Z_OBJECTS
fx_explosion_big.render.sprites[1].sort_y_offset = 0 -- -2

local fx_explosion_big = E:register_t("fx_explosion_lucerna_ability", "fx")

fx_explosion_big.render.sprites[1].prefix = "Lucerna_Ship_ability"
fx_explosion_big.render.sprites[1].offset = v(0, -30)
fx_explosion_big.render.sprites[1].name = "run"
fx_explosion_big.render.sprites[1].anchor.y = 0.13
fx_explosion_big.render.sprites[1].z = Z_OBJECTS
fx_explosion_big.render.sprites[1].sort_y_offset = -2

tt = RT("ability_lucerna", "g1_bomb")
tt.bullet.flight_time = fts(1)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "fx_explosion_lucerna_ability"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 40
tt.bullet.damage_max = 40
tt.bullet.damage_radius = 55
tt.bullet.pop = nil
tt.bullet.to = v(0,0)
tt.bullet.from = v(0,0)
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "g1_bombs_0001"
tt.render.sprites[1].animated = false
tt.sound_events.insert = nil --"BombShootSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"

--1技能 恐惧

tt = E:register_t("hero_lucerna_fear_run", "fx")
tt.render.sprites[1].name = "Lucerna_run"
tt.render.sprites[1].anchor = v(0.5, 0.14)
tt.render.sprites[1].z = Z_OBJECTS + 1

tt = RT("hero_lucerna_modifier_fear", "mod_hero_jacko_horse_intimidation")
tt.modifier.duration = 1.5
tt.speed_factor = 1.2
tt.render.sprites[1].name = "Lucerna_fearModifier_run"

tt = E.register_t(E, "hero_lucerna_modifier_fear_damage", "modifier")
E.add_comps(E, tt, "dps", "render")
tt.dps.damage_min = 6
tt.dps.damage_max = 6
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 0.2
tt.dps.kill = true
tt.modifier.allows_duplicates = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.modifier.duration = 3
tt.render.sprites[1].prefix = "Lucerna_fearDecal"
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

