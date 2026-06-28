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
local base_scripts = require("custom_scripts_0")
local kr1_scripts = require("game_scripts-1")
local scripts_rebbborn = require("game_scripts-1-rebbborn")
local kr4_scripts = require("game_scripts-45e")

require("templates")

local H = require("helpers")
local U = require("utils_pld")
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


--本文件：使用5代底层代码实现4代关卡
--4-0
tt = E:register_t("fade_loop", "fx")
tt.render.sprites[1].name = "fade_loop"

-------------------------------------------------------
------------------------矮人主线------------------------
-------------------------------------------------------

tt = E:register_t("enemy_human_woodcutter", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 5
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 30
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 1
tt.info.portrait = "gui4_bottom_info_image_enemies_0001"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 40
tt.render.sprites[1].prefix = "human_woodcutter"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)

tt = E:register_t("enemy_human_worker", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 5
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 50
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 2
tt.info.portrait = "gui4_bottom_info_image_enemies_0002"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 40
tt.render.sprites[1].prefix = "human_worker"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)

tt = E:register_t("enemy_bruiser", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 3
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 30
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 3
tt.info.portrait = "gui4_bottom_info_image_enemies_0003"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 30
tt.render.sprites[1].prefix = "bruiser"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)


tt = E:register_t("enemy_warhammer_guard", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 8
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 70
tt.health.armor = 0.2
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 4
tt.info.portrait = "gui4_bottom_info_image_enemies_0004"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 7
tt.melee.attacks[1].damage_min = 5
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 40
tt.render.sprites[1].prefix = "warhammer_guard"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)

tt = E:register_t("enemy_clockwork_spider", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 3
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 40
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 5
tt.info.portrait = "gui4_bottom_info_image_enemies_0005"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 90
tt.render.sprites[1].prefix = "clockwork_spider"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)


tt = E:register_t("enemy_chomp_bot", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 15
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 120
tt.health.armor = 0.2
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 6
tt.info.portrait = "gui4_bottom_info_image_enemies_0006"
tt.unit.hit_offset = v(0, 14)
tt.unit.head_offset = v(0, 5)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 0.4
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 39
tt.render.sprites[1].prefix = "chompbot"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)

---------------------------------------------------------
------------------------阿努瑞支线------------------------
---------------------------------------------------------
--阿努瑞追猎者
tt = RT("enemy_chaser", "enemy")
AC(tt, "melee", "timed_attacks")
tt.enemy.gold = 16
tt.enemy.lives_cost = 1
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0.5
tt.health.hp_max = 180
tt.health_bar.offset = v(0, 25)
tt.info.i18n_key = "ENEMY_ANURIAN_CHASER"
tt.info.portrait = "gui4_bottom_info_image_enemies_0061"
tt.info.enc_icon = 58
tt.motion.max_speed = 26
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 16
tt.melee.attacks[1].hit_time = fts(18)
tt.melee.attacks[1].basic_attack = true
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].vis_bans = bor(F_ENEMY, F_FLYING)
tt.timed_attacks.list[1] = E:clone_c("jump_attack")
tt.timed_attacks.list[1].skill = "jump_target"
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].damage_max = 60
tt.timed_attacks.list[1].damage_min = 60
tt.timed_attacks.list[1].max_range = 260
tt.timed_attacks.list[1].min_range = 30
tt.timed_attacks.list[1].is_area_damage = true
tt.timed_attacks.list[1].damage_radius = 60
tt.timed_attacks.list[1].flight_time = fts(18)
tt.timed_attacks.list[1].min_targets = 2
tt.timed_attacks.list[1].node_limit = 80
tt.timed_attacks.list[1].search_type = U.search_type.nearest
tt.timed_attacks.list[1].search_stream = U.search_stream.only_upstream
tt.timed_attacks.list[1].need_back = false
tt.timed_attacks.list[1].backed_attack = true
tt.timed_attacks.list[1].loops = 1
tt.timed_attacks.list[1].animations = {
	"jumpIn",
	"loop",
	"jumpOut"
}
tt.timed_attacks.list[1].sounds = {
	nil,
	nil,
	"frog_chaser_jump"
}
tt.timed_attacks.list[1].hit_fx = {
	"chaser_jump_hit_fx",
	"chaser_jump_effect"
}
tt.timed_attacks.list[1].hit_decal = "chaser_decal"
tt.timed_attacks.list[1].vis_bans = bor(F_ENEMY, F_FLYING)
tt.render.sprites[1].anchor = v(0.5, 0.132)
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].prefix = "chaser"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[1].animated = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "chaser_shadow"
tt.render.sprites[2].anchor = v(0.5, 0.137)
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hit_offset = v(0, 18)
tt.unit.mod_offset = v(0, 15)
tt.unit.head_offset = v(0, 40)
tt.ui.click_rect = r(-30, -8, 45, 30)
tt.vis.flags = bor(F_ENEMY)
tt.main_script.update = base_scripts.kr4_enemy_mixed.update

tt = RT("chaser_jump_hit_fx", "fx")
tt.render.sprites[1].prefix = "chaser_jump_hit_fx"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor = v(0.5, 0.475)

tt = RT("chaser_decal", "decal_tween")
tt.render.sprites[1].name = "chaser_decal"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.5)
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

tt = RT("chaser_jump_effect", "decal_tween")
tt.render.sprites[1].name = "chaser_jump_effect"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		vv(0.35)
	},
	{
		0.23,
		vv(1)
	}
}

--阿努瑞看守者
--buff名：shield_in
tt = RT("enemy_warden", "enemy")
AC(tt, "melee", "timed_attacks")
tt.enemy.gold = 55
tt.enemy.lives_cost = 1
tt.enemy.melee_slot = v(25, 0)
tt.health.armor = 0.8
tt.health.hp_max = 600
tt.health_bar.offset = v(0, 40)
tt.info.enc_icon = 59
tt.info.i18n_key = "ENEMY_ANURIAN_WARDEN"
tt.info.portrait = "gui4_bottom_info_image_enemies_0064"
tt.motion.max_speed = 25
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].basic_attack = true
tt.melee.attacks[1].animation = "hit"
tt.melee.attacks[1].vis_bans = bor(F_ENEMY, F_FLYING)
tt.render.sprites[1].anchor = v(0.5, 0.15)
tt.render.sprites[1].prefix = "warden"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[1].animated = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "warden_shadow"
tt.render.sprites[2].anchor = v(0.5, 0.174)
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(0, 20)
tt.unit.head_offset = v(0, 40)
tt.ui.click_rect = r(-23, 3, 45, 40)
tt.vis.flags = bor(F_ENEMY)
tt.main_script.update = base_scripts.kr4_enemy_mixed.update

--水晶异蛇龙
tt = RT("enemy_amphiptere", "enemy")
tt.enemy.gold = 7
tt.health.hp_max = 70
tt.health_bar.offset = v(0, 70)
tt.info.enc_icon = 60
tt.info.i18n_key = "ENEMY_CRYSTAL_AMPHIPTERE"
tt.info.portrait = "gui4_bottom_info_image_enemies_0063"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = 60
tt.render.sprites[1].prefix = "amphiptere"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[1].offset = v(0, 38)
tt.render.sprites[1].anchor = v(0.5, 0.264)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "amphiptere_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].anchor = v(0.5, 0.044)
tt.ui.click_rect = r(-18, 23, 28, 27)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(-3, 36)
tt.unit.mod_offset = v(-3, 50)
tt.unit.hide_after_death = true
tt.unit.show_blood_pool = false
tt.unit.blood_color = BLOOD_GREEN
tt.vis.bans = bor(F_BLOCK, F_THORN, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)

--水晶毁灭者
tt = RT("enemy_bullywags_golem", "enemy")

AC(tt, "melee", "death")

tt.enemy.gold = 80
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(30, 0)
tt.health.armor = 0
tt.health.hp_max = 1400
tt.health_bar.offset = v(0, 60)
tt.info.enc_icon = 64
tt.info.i18n_key = "ENEMY_CRYSTAL_DEMOLISHER"
tt.info.portrait = "gui4_bottom_info_image_enemies_0067"
tt.motion.max_speed = 16
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].damage_max = 240
tt.melee.attacks[1].damage_min = 130
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[1].basic_attack = true
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].vis_bans = bor(F_ENEMY, F_FLYING)
tt.render.sprites[1].anchor = v(0.523, 0.213)
tt.render.sprites[1].prefix = "bullywags_golem"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[1].animated = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "bullywags_golem_shadow"
tt.render.sprites[2].anchor = v(0.5, 0.219)
tt.render.sprites[2].z = Z_DECALS + 1
tt.unit.blood_color = BLOOD_RED
tt.unit.hit_offset = v(0, 10)
tt.unit.mod_offset = v(0, 25)
tt.unit.head_offset = v(0, 40)
tt.ui.click_rect = r(-12, 12, 53, 65)
tt.vis.flags = bor(F_ENEMY)
tt.main_script.update = base_scripts.kr4_enemy_mixed.update
tt.death.death_fn = scripts.enemy_crystal_demolisher.death_fn
tt.death.damage = 300
tt.death.damage_type = DAMAGE_PHYSICAL
tt.death.min_range = 0
tt.death.max_range = 60
tt.death.count = 5
tt.death.vis_flags = 0
tt.death.vis_ban = 0

--阿努瑞注魔师
tt = RT("enemy_infuser", "enemy")
AC(tt, "melee", "ranged", "timed_attacks")
tt.enemy.gold = 30
tt.enemy.lives_cost = 1
tt.enemy.melee_slot = v(28, 0)
tt.health.armor = 0
tt.health.magic_armor = 0.6
tt.health.hp_max = 250
tt.health_bar.offset = v(0, 30)
tt.info.enc_icon = 61
tt.info.i18n_key = "ENEMY_ANURIAN_INFUSER"
tt.info.portrait = "gui4_bottom_info_image_enemies_0062"
tt.motion.max_speed = 25
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 15
tt.melee.attacks[1].damage_min = 11
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].basic_attack = true
tt.melee.attacks[1].animation = "melee"
tt.melee.attacks[1].vis_bans = bor(F_ENEMY, F_FLYING)
tt.ranged.attacks[1].bullet = "enemy_infuser_bolt"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-5, 38.5),
	v(5, 38.5)
}
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].shoot_time = fts(9)
tt.timed_attacks.list[1] = E:clone_c("bullet_attack")
tt.timed_attacks.list[1].skill = "range_unit"
tt.timed_attacks.list[1].skill_id = 1
tt.timed_attacks.list[1].extra_cooldowns = { { 2, 5 },{ 3, 10 } }
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].bullet_start_offset = {
	v(-13, 42.5),
	v(13, 42.5)
}
tt.timed_attacks.list[1].max_range = 150
tt.timed_attacks.list[1].min_range = 25
tt.timed_attacks.list[1].cast_time = fts(9)
tt.timed_attacks.list[1].hold_advance = true
tt.timed_attacks.list[1].ignore_hit_offset = true
tt.timed_attacks.list[1].animation = "cast"
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND)
tt.timed_attacks.list[1].can_be_silenced = true
tt.timed_attacks.list[1].bullet = "infuser_cast_ray_shield"
tt.timed_attacks.list[1].allowed_templates = { "enemy_warden" }
tt.timed_attacks.list[1].sound = "frog_infuser_shield-complete"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(8)
}
tt.timed_attacks.list[2] = table.deepclone(tt.timed_attacks.list[1])
tt.timed_attacks.list[2].skill_id = 2
tt.timed_attacks.list[2].disabled = false
tt.timed_attacks.list[2].extra_cooldowns = { { 1, 5 },{3, 10} }
tt.timed_attacks.list[2].bullet = "infuser_cast_ray_speed"
tt.timed_attacks.list[2].allowed_templates = { "enemy_amphiptere" }
tt.timed_attacks.list[2].sound = nil
tt.timed_attacks.list[3] = E:clone_c("custom_attack")
tt.timed_attacks.list[3].skill_id = 3
tt.timed_attacks.list[3].vis_bans = bor(F_ENEMY)
tt.timed_attacks.list[3].disabled = false
tt.timed_attacks.list[3].cast_time = fts(9)
tt.timed_attacks.list[3].bullet_start_offset = {
	v(-13, 42.5),
	v(13, 42.5)
}
tt.timed_attacks.list[3].loop_time = fts(150)
tt.timed_attacks.list[3].cooldown = 10
tt.timed_attacks.list[3].animation_start = "cast"
tt.timed_attacks.list[3].animation_loop = "cast_loop"
tt.timed_attacks.list[3].animation_end = "cast_end"
tt.timed_attacks.list[3].skill = "object_on_crystal"
tt.timed_attacks.list[3].target_id = nil
tt.timed_attacks.list[3].can_be_silenced = true
tt.timed_attacks.list[3].max_range = 150
tt.timed_attacks.list[3].min_range = 25
tt.timed_attacks.list[3].radius = 150
tt.timed_attacks.list[3].extra_cooldowns = { { 1, 5 }, {2,5} }
tt.timed_attacks.list[3].bullet = "infuser_cast_ray_silent"
tt.timed_attacks.list[3].allowed_templates = { "overcharge_crystal" }
tt.timed_attacks.list[3].sound = nil
tt.render.sprites[1].anchor = v(0.5, 0.106)
tt.render.sprites[1].offset = v(0, 3)
tt.render.sprites[1].prefix = "infuser"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[1].animated = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "chaser_shadow"
tt.render.sprites[2].anchor = v(0.5, 0.127)
tt.render.sprites[2].offset = v(0, 1)
tt.render.sprites[2].z = Z_DECALS + 1
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, 12)
tt.unit.head_offset = v(0, 40)
tt.ui.click_rect = r(-18, -3, 32, 36)
tt.vis.flags = bor(F_ENEMY)
tt.main_script.update = base_scripts.kr4_enemy_mixed.update

--阿努瑞通灵师  代码来自2代
tt = E:register_t("enemy_bullywags_channeler", "enemy")
E:add_comps(tt, "melee", "ranged", "auras")
anchor_y = 0.16
image_y = 62
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "channeler_shield_aura"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E:clone_c("aura_attack")
tt.auras.list[2].name = "channeler_damage_aura"
tt.auras.list[2].cooldown = 0
tt.enemy.gold = 25
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0
tt.health.hp_max = 300
tt.health.magic_armor = 0.6
tt.health_bar.offset = v(0, ady(47))
tt.info.portrait = "gui4_bottom_info_image_enemies_0065"
tt.info.enc_icon = 63
tt.info.i18n_key = "ENEMY_ANURIAN_CHANNELER"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = base_scripts.kr4_enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 42
tt.melee.attacks[1].damage_min = 28
tt.melee.attacks[1].hit_time = fts(12)
tt.ranged.attacks[1].bullet = "enemy_bullywags_channeler_bolt"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-5, 38.5),
	v(5, 38.5)
}
tt.ranged.attacks[1].cooldown = 1.2
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 100
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].shoot_time = fts(9)
tt.motion.max_speed = 1.1 * FPS
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "bullywags_channeler"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "chaser_shadow"
tt.render.sprites[2].anchor = v(0.5, 0.127)
tt.render.sprites[2].offset = v(0, -8)
tt.render.sprites[2].z = Z_DECALS + 1
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(26))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)

--阿努瑞博学者  代码来自2代
tt = E:register_t("enemy_bullywags_erudite", "enemy")
E:add_comps(tt, "melee", "ranged")
anchor_y = 0.16
image_y = 62
tt.enemy.gold = 60
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0
tt.health.hp_max = 500
tt.health.magic_armor = 0.8
tt.health_bar.offset = v(0, ady(47))
tt.info.portrait = "gui4_bottom_info_image_enemies_0066"
tt.info.enc_icon = 62
tt.info.i18n_key = "ENEMY_ANURIAN_ERUDITE"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = base_scripts.kr4_enemy_mixed.update
tt.main_script.remove = scripts.enemy_bullywags_erudite.remove
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 42
tt.melee.attacks[1].damage_min = 28
tt.melee.attacks[1].hit_time = fts(12)
tt.ranged.attacks[1].bullet = "enemy_bullywags_erudite_bolt"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 38.5),
	v(0, 38.5)
}
tt.ranged.attacks[1].cooldown = 2.0
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 125
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_stored_bullets = 3
tt.ranged.attacks[1].storage_offsets = {
	v(0, 50),
	v(-20, 47),
	v(20, 47)
}
tt.ranged.attacks[1]._stored_bullets = {}
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].shoot_time = fts(9)
tt.motion.max_speed = 1 * FPS
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "bullywags_erudite"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(26))
tt.sound_events.death = "frog_erudite_death"
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)

--阿努瑞
tt = E:register_t("boss_anurian", "boss")
E:add_comps(tt, "melee")
anchor_y = 0.16
image_y = 62
tt.enemy.gold = 0
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0
tt.health.hp_max = 7000
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(47))
tt.info.portrait = "gui4_bottom_info_image_enemies_0068"
tt.info.enc_icon = 87
tt.info.i18n_key = "ENEMY_POLYX"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = base_scripts.kr4_enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 9999
tt.melee.attacks[1].damage_min = 9999
tt.melee.attacks[1].damage_type = DAMAGE_INSTAKILL
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = 0.26 * FPS
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "bullywags_boss"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(26))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)

tt = RT("enemy_infuser_bolt", "bolt")
tt.render.sprites[1].prefix = "infuser_bolt"
tt.bullet.damage_min = 22
tt.bullet.damage_max = 30
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "enemy_infuser_bolt_hit_fx"

tt = RT("enemy_infuser_bolt_hit_fx", "fx")
tt.render.sprites[1].prefix = "infuser_bolt"
tt.render.sprites[1].name = "hit"

tt = RT("enemy_bullywags_channeler_bolt", "bolt")
tt.render.sprites[1].prefix = "bullywags_channeler_bolt"
tt.bullet.damage_min = 25
tt.bullet.damage_max = 35
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "enemy_bullywags_channeler_bolt_hit_fx"

tt = RT("enemy_bullywags_channeler_bolt_hit_fx", "fx")
tt.render.sprites[1].prefix = "infuser_bolt"
tt.render.sprites[1].name = "hit"

tt = RT("enemy_bullywags_erudite_bolt", "bolt")
tt.sound_events.insert = "frog_erudite_shot"
tt.render.sprites[1].prefix = "bullywags_erudite_bolt"
tt.bullet.damage_min = 42
tt.bullet.damage_max = 64
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "enemy_bullywags_erudite_bolt_hit_fx"

tt = RT("enemy_bullywags_erudite_bolt_hit_fx", "fx")
tt.render.sprites[1].prefix = "bullywags_erudite_bolt"
tt.render.sprites[1].name = "hit"

tt = RT("enemy_bullywags_erudite_upgrade_bolt", "bolt")
tt.sound_events.insert = "frog_erudite_shot"
tt.render.sprites[1].prefix = "bullywags_erudite_bolt_upgraded"
tt.bullet.damage_min = 80
tt.bullet.damage_max = 120
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "enemy_bullywags_eruditer_upgrade_bolt_hit_fx"

tt = RT("enemy_bullywags_eruditer_upgrade_bolt_hit_fx", "fx")
tt.render.sprites[1].prefix = "bullywags_erudite_bolt_upgraded"
tt.render.sprites[1].name = "hit"

tt = RT("infuser_cast_ray_shield", "bullet")
tt.render.sprites[1].prefix = "infuser_cast_ray"
tt.render.sprites[1].name = "flying"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.008, 0.54)
tt.bullet.flight_time = fts(2)
tt.bullet.hit_time = fts(3)
tt.image_width = 110
tt.main_script.update = scripts.ray_simple.update
tt.bullet.mod = "infuser_cast_shield_mod"

tt = RT("infuser_cast_ray_speed", "infuser_cast_ray_shield")
tt.bullet.mod = "infuser_cast_speed_mod"

tt = RT("infuser_cast_ray_silent", "infuser_cast_ray_shield")
tt.render.sprites[1].prefix = "infuser_gem_ray"
tt.render.sprites[1].name = "flying"
tt.render.sprites[1].animated = true
--tt.render.sprites[1].scale = v(1.2,1.2)
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BULLETS
tt.bullet.ignore_hit_offset = false
tt.main_script.update = scripts.ray_simple_silent.update
tt.bullet.flight_time = fts(3)
tt.bullet.hit_time = fts(150)
tt.bullet.mod = nil
tt.sound_events.insert = "frog_infuser_crystalcharge-loop"
tt.sound_events.interrupt = "frog_infuser_crystalcharge-loop-end"

tt = RT("infuser_cast_shield_mod", "modifier")
AC(tt, "render", "health")
tt.render.sprites[1].prefix = "warden_shield"
tt.render.sprites[1].loop = false
tt.animations = {
	"in",
	"loop",
	"out"
}
tt.main_script.insert = scripts.infuser_cast_shield_mod.insert
tt.main_script.update = scripts.infuser_cast_shield_mod.update
tt.main_script.remove = scripts.infuser_cast_shield_mod.remove
tt.modifier.shield_hp = 200
tt.modifier.duration = -1

tt = RT("infuser_cast_speed_mod", "mod_slow")
tt.main_script.insert = scripts.infuser_cast_speed_mod.insert
tt.main_script.remove = scripts.infuser_cast_speed_mod.remove
tt.slow.factor = 3
tt.modifier.duration = 2
tt.walk_animations = {
	"speedWalk",
	"speedWalkUp",
	"speedWalkDown"
}

tt = RT("bullywag_spawner", "decal_scripted")
AC(tt, "spawner", "editor")
tt.render.sprites[1].prefix = "bullywag_spawner_layer1"
tt.render.sprites[1].animated = true
tt.render.sprites[1].group = 1
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "bullywag_spawner_layer2"
tt.render.sprites[2].animated = true
tt.render.sprites[2].group = 1
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "bullywag_spawner_splash"
tt.render.sprites[3].anchor = v(0.5, 0.187)
tt.render.sprites[3].offset = v(0, 0)
tt.render.sprites[3].animated = true
tt.spawner.animations = {
	{
		["name"] = "idle",
		["group"] = 1
	},
	{
		["name"] = "active",
		["group"] = 1
	},
	{
		["name"] = "end",
		["times"] = 1,
		["sprite"] = 3
	},
	{
		["name"] = "idle",
		["sprite"] = 3
	}
}
tt.main_script.update = scripts.bullywag_spawner.update

--通灵师的buff
tt = E:register_t("channeler_shield_aura", "aura")
tt.aura.mod = "mod_bullywags_channeler_shield"
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 115.2
tt.aura.track_source = true
tt.aura.targets_per_cycle = 10
tt.aura.vis_flags = F_MOD
tt.aura.allowed_templates = {
	"enemy_bullywags_golem",
}
--tt.aura.requires_magic = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update

tt = E:register_t("channeler_damage_aura", "aura")
tt.aura.mod = "mod_bullywags_channeler_damage"
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 115.2
tt.aura.track_source = true
tt.aura.targets_per_cycle = 10
tt.aura.vis_flags = F_MOD
tt.aura.allowed_templates = {
	"enemy_bullywags_erudite",
}
tt.aura.requires_magic = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update

tt = E:register_t("mod_bullywags_channeler_shield", "modifier")
E:add_comps(tt, "render", "armor_buff")
tt.modifier.duration = 2
tt.modifier.allows_duplicates = false
tt.modifier.use_mod_offset = false
tt.armor_buff.magic = false
tt.armor_buff.max_factor = 0.25
tt.armor_buff.step_factor = 0.03
tt.armor_buff.cycle_time = 1
tt.render.sprites[1].prefix = "bullywags_channeler_upgrade_effect_particles"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.15625
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "bullywags_channeler_upgrade_effect_decal"
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0
tt.render.sprites[2].offset.y = -15
tt.render.sprites[2].z = Z_DECALS
tt.main_script.insert = scripts.mod_armor_buff.insert
tt.main_script.remove = scripts.mod_armor_buff.remove
tt.main_script.update = scripts.mod_armor_buff.update

tt = E:register_t("mod_bullywags_channeler_damage", "modifier")
E:add_comps(tt, "render", "armor_buff")
tt.modifier.duration = 2
tt.modifier.use_mod_offset = false
tt.armor_buff.magic = false
tt.armor_buff.max_factor = 0
tt.armor_buff.step_factor = 0
tt.armor_buff.cycle_time = 1
tt.render.sprites[1].prefix = "bullywags_channeler_upgrade_effect_particles"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.15625
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "bullywags_channeler_upgrade_effect_decal"
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0
tt.render.sprites[2].offset.y = -15
tt.render.sprites[2].z = Z_DECALS
tt.main_script.insert = scripts.mod_erudite_buff.insert
tt.main_script.remove = scripts.mod_erudite_buff.remove
tt.main_script.update = scripts.mod_erudite_buff.update

--第18关场景：阿努瑞神龛
tt = E:register_t("bullywag_bubble_crystal", "decal_scripted")
E:add_comps(tt, "ui", "attacks", "tween")
tt.ui.can_click = true
tt.ui.click_rect = r(-37, -16, 74, 65)
tt.tween.disabled = true
tt.tween.remove = nil
tt.tween.reverse = nil
tt.tween.props[1].sprite_id = {}
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
tt.tween_duration = 0.5
tt.animation_group1 = "bubble_crystal_layer"
for i = 1, 10 do
	if i > 1 then
		tt.render.sprites[i] = E:clone_c("sprite")
	end
	tt.render.sprites[i].prefix = "bullywag_bubble_crystals_layer" .. i
	tt.render.sprites[i].name = "ready"
	tt.render.sprites[i].anchor = v(0.5, 0.246)
	tt.render.sprites[i].group = tt.animation_group1
end
tt.attacks.list[1] = E:clone_c("area_attack")
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].mod = "mod_bullywag_bubble_crystal"
tt.attacks.list[1].mod2 = "mod_bullywag_bubble_crystal_2"
tt.attacks.list[1].max_targets = 8
tt.attacks.list[1].cooldown = 30
tt.attacks.list[1].range = 187.5
tt.attacks.list[1].sound = "frog_infuser_shield-complete"
tt.attacks.list[1].sound_args = {
	delay = fts(2)
}
tt.main_script.update = scripts.bullywag_bubble_crystal.update

local decal_dwaarp_pulse = E:register_t("decal_bubble_crystal_pulse", "decal_tween")

decal_dwaarp_pulse.tween.props[1].name = "scale"
decal_dwaarp_pulse.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.32,
		v(4, 4)
	}
}
decal_dwaarp_pulse.tween.props[1].sprite_id = 1
decal_dwaarp_pulse.tween.props[2] = E:clone_c("tween_prop")
decal_dwaarp_pulse.tween.props[2].name = "alpha"
decal_dwaarp_pulse.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		0.32,
		0
	}
}
decal_dwaarp_pulse.tween.props[2].sprite_id = 1
decal_dwaarp_pulse.render.sprites[1].animated = false
decal_dwaarp_pulse.render.sprites[1].name = "bullywag_bubble_crystals_blast_0001"
decal_dwaarp_pulse.render.sprites[1].z = Z_DECALSlocal 

tt = E:register_t("mod_bullywag_bubble_crystal", "modifier")
E:add_comps(tt, "render", "armor_buff")
tt.modifier.duration = 6
tt.modifier.use_mod_offset = false
tt.armor_buff.magic = false
tt.armor_buff.max_factor = 2
tt.armor_buff.step_factor = 2
tt.armor_buff.cycle_time = 1
tt.render.sprites[1].prefix = "bullywag_bubble_crystals_shield_modifier"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.15625
tt.main_script.insert = scripts.mod_armor_buff.insert
tt.main_script.remove = scripts.mod_armor_buff.remove
tt.main_script.update = scripts.mod_armor_buff.update

tt = E:register_t("mod_bullywag_bubble_crystal_2", "modifier")
E:add_comps(tt, "armor_buff")
tt.modifier.duration = 6
tt.modifier.use_mod_offset = false
tt.armor_buff.magic = true
tt.armor_buff.max_factor = 2
tt.armor_buff.step_factor = 2
tt.armor_buff.cycle_time = 1
tt.main_script.insert = scripts.mod_armor_buff.insert
tt.main_script.remove = scripts.mod_armor_buff.remove
tt.main_script.update = scripts.mod_armor_buff.update

--第18关场景:注魔水晶
tt = E:register_t("overcharge_crystal", "decal_scripted")
E:add_comps(tt, "attacks", "tween", "crystal", "vis", "health", "unit")
tt.health.hp_max = 999999
tt.charging = false
tt.charged = false
tt.decharge = false
tt.unit.hit_offset = v(0,38)
tt.tween.disabled = true
tt.tween.remove = nil
tt.tween.reverse = nil
tt.tween.props[1].sprite_id = {}
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
tt.tween_duration = 0.5
tt.animation_group1 = "overcharge_crystal_layer"
for i = 1, 2 do
	if i > 1 then
		tt.render.sprites[i] = E:clone_c("sprite")
	end
	tt.render.sprites[i].prefix = "overcharge_crystals_base_layer" .. i
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].anchor = v(0.5, 0.246)
	tt.render.sprites[i].group = tt.animation_group1
end
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].mod = "mod_overcharge_crystal_serpent"
tt.attacks.list[1].exclude_tower_kind = {}
tt.attacks.list[1].cooldown = 5.1
tt.attacks.list[1].max_range = 9999
tt.attacks.list[1].min_range = 0
tt.attacks.list[1].vis_flags = bor(F_MOD, F_CUSTOM)
tt.attacks.list[1].vis_bans = bor(F_CUSTOM)
--tt.attacks.list[1].sound = "frog_infuser_crystal_blockedtower-loop"
--tt.attacks.list[1].sound_args = {
--	delay = fts(2)
--}
tt.main_script.update = scripts.overcharge_crystal.update

tt = E:register_t("mod_overcharge_crystal_serpent", "modifier")
E:add_comps(tt, "render")
tt.sound_events.insert = "frog_infuser_crystal_blockedtower-loop"
tt.sound_events.finish = "frog_infuser_crystal_blockedtower-loop-end"
tt.main_script.update = scripts.mod_tower_block.update
tt.modifier.duration = 14
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].draw_order = 10
tt.render.sprites[1].name = "start"
tt.render.sprites[1].prefix = "overcharge_crystals_modifier"

tt = E:register_t_10086("fx_lightining_crystal", "decal_scripted")
tt.main_script.update = scripts.multi_sprite_fx.update
tt.render.sprites[1].name = "overcharge_crystals_ray_loop_loop"
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = vv(2)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "overcharge_crystals_explotion_run"
tt.render.sprites[2].animated = true
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].delay_start = fts(6)