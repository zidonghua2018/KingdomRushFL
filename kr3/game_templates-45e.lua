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
local kr4_scripts = require("game_scripts-45e")

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


--本文件：使用5代底层代码实现4代关卡
--4-0
tt = E:register_t("fade_loop", "fx")
tt.render.sprites[1].name = "fade_loop"

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
tt.enemy.gold = 8
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
tt.enemy.gold = 8
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 50
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
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 40
tt.render.sprites[1].prefix = "bruiser"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)


tt = E:register_t("enemy_warhammer_guard", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 8
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 50
tt.health.armor = 0
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
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = 40
tt.render.sprites[1].prefix = "warhammer_guard"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)

tt = E:register_t("enemy_clockwork_spider", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 8
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 50
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 4
tt.info.portrait = "gui4_bottom_info_image_enemies_0005"
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
tt.render.sprites[1].prefix = "clockwork_spider"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)


tt = E:register_t("enemy_chomp_bot", "enemy_KR5")
E:add_comps(tt, "melee")
tt.enemy.gold = 8
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 50
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 32)
tt.info.enc_icon = 4
tt.info.portrait = "gui4_bottom_info_image_enemies_0006"
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
tt.render.sprites[1].prefix = "chompbot"
tt.render.sprites[1].offset.y = 15
tt.sound_events.death = "EnemyDarksteelHammererDeath"
tt.ui.click_rect = r(-17, 0, 34, 30)