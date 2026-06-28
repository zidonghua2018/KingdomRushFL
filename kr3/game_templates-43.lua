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
local scripts = require("game_scripts")
local kr1_scripts = require("game_scripts-1")
local kr4_scripts = require("game_scripts-43")

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


local mod_gold = E:register_t("mod_gold", "modifier")

E:add_comps(mod_gold, "slow")

mod_gold.modifier.duration = 0.3
mod_gold.modifier.allows_duplicates = true
mod_gold.modifier.type = MOD_TYPE_GOLD
mod_gold.slow.factor = 1.1
mod_gold.main_script.insert = kr4_scripts.mod_gold.insert
mod_gold.main_script.remove = kr4_scripts.mod_gold.remove
mod_gold.main_script.update = scripts.mod_track_target.update

--本文件：使用前3代底层代码实现4代防御塔
----------------------------------------------
--------------------少林寺---------------------
----------------------------------------------
--建造
tt = E:register_t("tower_build_shaolin", "tower_build")
tt.build_name = "tower_shaolin_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2].name = "shaolin_temple_lvl1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 35)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62


tt = E:register_t("tower_shaolin_lvl1", "tower_kr4")

E:add_comps(tt, "attacks")
tt.info.i18n_key = "TOWER_SHAOLIN_TEMPLE_LEVEL1"
tt.info.fn = kr4_scripts.tower_shaolin.get_info
tt.info.portrait = "gui4_bottom_info_image_towers_0022"
tt.main_script.insert = kr4_scripts.tower_shaolin.insert
tt.main_script.update = kr4_scripts.tower_shaolin.update
tt.main_script.remove = kr4_scripts.tower_shaolin.remove
tt.attacks.list[1] = E:clone_c("bullet_attack")
--tt.attacks.list[1].animation = "harvester"
tt.attacks.list[1].bullet = "bullet_shaolin_lvl1"
tt.attacks.list[1].bullet_start_offset = v(10, 11)
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.attacks.list[1].chance = 1

tt.attacks.range = 168--160
tt.attacks.cooldown = fts(0)
tt.attacks.enemy_cooldown = 1.37
tt.attacks.pixie_cooldown = 1.37
tt.attacks.excluded_templates = {
	"enemy_rabbit"
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_0002"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "shaolin_temple_lvl1_0002"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[2].sort_y_offset = 30
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "shaolin_monk_lvl1_deco"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(16, 18)
--tt.render.sprites[3].sort_y_offset = 30
tt.render.sprites[3].flip_x = true
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "shaolin_monk_lvl1_deco"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(-16, 18)
--tt.render.sprites[4].sort_y_offset = 30
tt.sound_events.insert = "ShaolinTaunt"
tt.tower.level = 1
tt.tower.menu_offset = v(0, 6)
tt.tower.price = 110
tt.tower.type = "shaolin"
tt.tower.kind = TOWER_KIND_ARCHER

tt = E:register_t("tower_shaolin_lvl2", "tower_shaolin_lvl1")
tt.info.i18n_key = "TOWER_SHAOLIN_TEMPLE_LEVEL2"
tt.tower.level = 2
tt.tower.price = 150
tt.attacks.range = 178.5--170
tt.attacks.list[1].bullet = "bullet_shaolin_lvl2"
tt.render.sprites[2].name = "shaolin_temple_lvl2_0001"
tt.render.sprites[3].prefix = "shaolin_monk_lvl2_deco"
tt.render.sprites[4].prefix = "shaolin_monk_lvl2_deco"

tt = E:register_t("tower_shaolin_lvl3", "tower_shaolin_lvl1")
tt.info.i18n_key = "TOWER_SHAOLIN_TEMPLE_LEVEL3"
tt.tower.level = 3
tt.tower.price = 190
tt.attacks.range = 189--180
tt.attacks.list[1].bullet = "bullet_shaolin_lvl3"
tt.render.sprites[2].name = "shaolin_temple_lvl3_0001"
tt.render.sprites[3].prefix = "shaolin_monk_lvl3_deco"
tt.render.sprites[4].prefix = "shaolin_monk_lvl3_deco"

tt = E:register_t("tower_shaolin_lvl4", "tower_shaolin_lvl1")

E:add_comps(tt, "powers", "barrack","auras")
tt.info.i18n_key = "TOWER_SHAOLIN_TEMPLE_LEVEL4"
tt.tower.level = 4
tt.tower.price = 230
tt.attacks.range = 197--187.5
tt.attacks.list[1].bullet = "bullet_shaolin_lvl4"
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_tower_shaolin_gold"
tt.auras.list[1].cooldown = 0
tt.render.sprites[2].name = "shaolin_temple_lvl4_0001"
tt.render.sprites[3].prefix = "shaolin_monk_lvl4_deco"
tt.render.sprites[4].prefix = "shaolin_monk_lvl4_deco"
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].animated = true
tt.render.sprites[5].hidden = true
tt.render.sprites[5].name = "shaolin_temple_lvl4_lion_run"
tt.render.sprites[5].offset = v(0, 30)
--tt.render.sprites[5].sort_y_offset = 30
tt.powers.total = E:clone_c("power")
tt.powers.total.price_base = 148
tt.powers.total.price_inc = 148
tt.powers.total.max_level = 3
tt.powers.total.enc_icon = 363
tt.powers.dragon = E:clone_c("power")
tt.powers.dragon.price_base = 212
tt.powers.dragon.max_level = 1
tt.powers.dragon.enc_icon = 362
tt.powers.lion = E:clone_c("power")
tt.powers.lion.price_base = 85
tt.powers.lion.max_level = 1
tt.powers.lion.enc_icon = 361
tt.barrack.soldier_type = "soldier_dragon"
tt.barrack.rally_range = 185

tt = E:register_t("aura_tower_shaolin_gold", "aura")
--b = balance.towers.sparking_geode.spike_burst
tt.aura.mods = {
	"mod_tower_shaolin_gold",
}
tt.aura.radius = 184.8 --可能需要科技
tt.aura.vis_flags = bor(F_MOD)
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.duration = 1e+99
tt.aura.cycle_time = 0.4
tt.distance_between_crystals = {
	115,
	110,
	70
}
tt.main_script.insert = kr4_scripts.aura_tower_shaolin_gold.insert
tt.main_script.update = kr4_scripts.aura_tower_shaolin_gold.update
tt.ps_names = {
	--"ps_tower_rotten_forest_sparks_1",
	--"ps_tower_rotten_forest_sparks_1"
}

tt = E:register_t("mod_tower_shaolin_gold", "mod_gold")
--b = balance.towers.sparking_geode.spike_burst
tt.modifier.duration = 0.4
tt.slow.factor = 1.1

function tt.main_script.insert(this, store, script)
	this.slow.factor = this.slow.factor

	return kr4_scripts.mod_gold.insert(this, store, script)
end

tt = RT("soldier_dragon", "soldier_militia")
AC(tt, "melee", "nav_grid")

image_y = 64
anchor_y = 0.15
tt.health.armor = 0
tt.health.armor_inc = 0
tt.health.dead_lifetime = 13
tt.health.hp_max = 520
tt.health.hp_inc = 0
tt.health_bar.offset = v(0, 45)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "SHAOLIN_DRAGON_WARRIOR"
tt.info.portrait = "gui4_bottom_info_image_soldiers_0051"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].count = 1
tt.melee.attacks[1].damage_inc = 0
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 40
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
tt.melee.range = 60
tt.motion.max_speed = 30
tt.regen.health = 40
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "shaolin_dragon_warrior"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "shaolin_dragon_warrior_shadow"
tt.render.sprites[2].anchor.y = 0.15
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1

tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "RockElementalDeath"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_RED
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)

tt = E:register_t("shaolin_monk_lvl1_hit_fx", "fx")
E:add_comps(tt, "sound_events")
--tt.render.sprites[1].anchor.y = 0
tt.render.sprites[1].name = "shaolin_monk_lvl1_hit_effect_run"
tt.render.sprites[1].animated = true
tt.sound_events.insert = "ShaolinAttack"

tt = E:register_t("shaolin_monk_lvl4_hit_fx", "shaolin_monk_lvl1_hit_fx")
E:add_comps(tt, "sound_events")
tt.render.sprites[1].name = "shaolin_monk_lvl4_hit_effect_run"

tt = E:register_t("bullet_shaolin_lvl1", "arrow")
tt.bullet.damage_min = 3
tt.bullet.damage_max = 4
tt.bullet.hit_fx = "shaolin_monk_lvl1_hit_fx"
tt.render.sprites[1].name = nil
tt.render.sprites[1].hidden = true
tt.sound_events.insert = nil
tt.bullet.damage_type = DAMAGE_PHYSICAL

tt = E:register_t("bullet_shaolin_lvl2", "bullet_shaolin_lvl1")
tt.bullet.damage_min = 6
tt.bullet.damage_max = 11--10
tt.bullet.hit_fx = "shaolin_monk_lvl1_hit_fx"

tt = E:register_t("bullet_shaolin_lvl3", "bullet_shaolin_lvl1")
tt.bullet.damage_min = 12--11
tt.bullet.damage_max = 18--17
tt.bullet.hit_fx = "shaolin_monk_lvl1_hit_fx"

tt = E:register_t("bullet_shaolin_lvl4", "bullet_shaolin_lvl1")
tt.bullet.damage_min = 15--14
tt.bullet.damage_max = 28--26
--tt.bullet.hit_fx = "shaolin_monk_lvl4_hit_fx"

tt = E:register_t("decal_shaolin_lvl1", "decal_scripted")
E:add_comps(tt, "idle_flip", "soldier", "unit", "tween")
tt.idle_flip.animations = {
	"idle"
}
tt.idle_flip.cooldown = fts(90)
tt.idle_flip.loop = false
tt.main_script.update = kr4_scripts.decal_shaolin.update
tt.render.sprites[1].prefix = "shaolin_monk_lvl1"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = 1 / 9
tt.render.sprites[1].z = Z_BULLETS
tt.soldier.melee_slot_offset = v(0, 0)
tt.attack_ts = 0
tt.target_id = nil
tt.attack = nil
tt.attack_level = nil
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].interp = "sine"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 0)
	},
	{
		fts(6),
		v(0, 1)
	},
	{
		fts(11),
		v(0, 0)
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].disabled = true
tt.tween.props[1].sprite_id = 1

tt = E:register_t("decal_shaolin_lvl2", "decal_shaolin_lvl1")
tt.render.sprites[1].prefix = "shaolin_monk_lvl2"

tt = E:register_t("decal_shaolin_lvl3", "decal_shaolin_lvl1")
tt.render.sprites[1].prefix = "shaolin_monk_lvl3"

tt = E:register_t("decal_shaolin_lvl4", "decal_shaolin_lvl1")
tt.soldier.melee_slot_offset = v(5, 0)
tt.render.sprites[1].prefix = "shaolin_monk_lvl4"
tt.render.sprites[1].anchor.y = 2 / 9

tt = E:register_t("decal_shaolin_gold", "aura")
E:add_comps(tt, "pos", "render","sound_events")
tt.aura.duration = fts(36)
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "shaolin_abundance_coin"
tt.render.sprites[1].name = "run"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.sound_events.insert = nil


----------------------------------------------
---------------------冰龙----------------------
----------------------------------------------
tt = E:register_t("hero_eiskalt", "hero")

E:add_comps(tt, "ranged", "timed_attacks")

image_y = 308
anchor_y = 0.12962962962962962
tt.hero.level_stats.hp_max = {
	360,
	390,
	420,
	450,
	480,
	510,
	540,
	570,
	600,
	630
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
	17,
	23,
	29,
	34,
	39,
	43,
	49,
	55,
	60,
	66
}
tt.hero.level_stats.ranged_damage_max = {
	24,
	32,
	41,
	49,
	57,
	66,
	74,
	82,
	90,
	98
}

--1技能 爆炸
tt.hero.skills.explosion = E:clone_c("hero_skill")

tt.hero.skills.explosion.damage_radius = {
	[0] = 20,
	40,
	60,
	80
}

--2技能 减速
tt.hero.skills.coldfury = E:clone_c("hero_skill")
tt.hero.skills.coldfury.cooldown = {
	20,
	16,
	12
}
tt.hero.skills.coldfury.xp_gain_factor = 160

--3技能 冰球，原技能瘟疫球
tt.hero.skills.frosty = E:clone_c("hero_skill")
tt.hero.skills.frosty.xp_gain_factor = 180
tt.hero.skills.frosty.damage_min = {
	80,
	160,
	240
}
tt.hero.skills.frosty.damage_max = {
	80,
	160,
	240
}

--4技能 冰刺，原技能脊骨雨
tt.hero.skills.icepeak = E:clone_c("hero_skill")
tt.hero.skills.icepeak.xp_gain_factor = 274
tt.hero.skills.icepeak.count = {
	8,
	8,
	8
}
tt.hero.skills.icepeak.damage_min = {
	500,
	1000,
	1500
}
tt.hero.skills.icepeak.damage_max = {
	500,
	1000,
	1500
}

tt.hero.use_custom_spawn_point = true

tt.hero.skills.explosion.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.explosion.hr_icon = 401
tt.hero.skills.explosion.hr_order = 1
tt.hero.skills.coldfury.hr_cost = {
	3,
	2,
	1
}
tt.hero.skills.coldfury.cooldown_time = {
	20,
	16,
	12
}
tt.hero.skills.coldfury.hr_icon = 402
tt.hero.skills.coldfury.hr_order = 2
tt.hero.skills.frosty.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.frosty.hr_icon = 403
tt.hero.skills.frosty.hr_order = 3
tt.hero.skills.icepeak.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.icepeak.hr_icon = 404
tt.hero.skills.icepeak.hr_order = 4

tt.hero.skills.ultimate = E:clone_c("hero_skill")
tt.hero.skills.ultimate.controller_name = "hero_eiskalt_ultimate"
tt.hero.skills.ultimate.duration = {
	[0] = 4,
	6,
	8,
	12
}
tt.hero.skills.ultimate.hr_cost = {
	4,
	4,
	4
}
tt.hero.skills.ultimate.hr_icon = 405
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.key = "DRONES"


tt.health.armor = nil
tt.health.dead_lifetime = 22.5
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 157)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.draw_order = -1
tt.health_bar.sort_y_offset = -200
tt.hero.fn_level_up = kr4_scripts.hero_eiskalt.level_up
tt.hero.tombstone_show_time = nil
tt.idle_flip.cooldown = 10
tt.drag_line_origin_offset = v(0, 80)
tt.info.fn = kr4_scripts.hero_eiskalt.get_info
tt.info.hero_portrait = "kra_hero_portraits_0412"
tt.info.ultimate_icon = "0412"
tt.info.portrait = "gui4_bottom_info_image_heroes_0015"
tt.info.damage_icon = "magic"
tt.main_script.insert = kr4_scripts.hero_eiskalt.insert
tt.main_script.update = kr4_scripts.hero_eiskalt.update
tt.motion.max_speed = 90
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_eiskalt"
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].sort_y_offset = -200
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_eiskalt_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.sound_events.change_rally_point = "HeroEiskaltTaunt"
tt.sound_events.death = "HeroEiskaltTauntDeath"
tt.sound_events.respawn = "HeroDracolichRespawn"
tt.sound_events.insert = "HeroEiskaltTaunt"
tt.sound_events.hero_room_select = "HeroEiskaltTauntSelect"
tt.ui.click_rect = r(-25, 70, 50, 45)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 98)
tt.unit.hide_after_death = true
tt.unit.marker_offset = v(0, -0.15)
tt.unit.mod_offset = v(0, 101)
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_POISON)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].bullet = "fireball_eiskalt"
tt.ranged.attacks[1].bullet_start_offset = {
	v(46, 52)
}
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 220
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].animation = "range_attack"
tt.ranged.attacks[1].estimated_flight_time = fts(24)
tt.ranged.attacks[1].sound = "HeroDracolichAttack"

--瘟疫载体->大雪球
tt.timed_attacks.list[1] = E:clone_c("spawn_attack")
tt.timed_attacks.list[1].animation = "frosty"
tt.timed_attacks.list[1].cooldown = 18
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "bullet_eiskalt_frosty"--"hero_eiskalt_frosty"
tt.timed_attacks.list[1].spawn_offset = v(12, 60)
tt.timed_attacks.list[1].spawn_time = fts(20)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1].range_nodes_max = 50
tt.timed_attacks.list[1].range_nodes_min = 10
tt.timed_attacks.list[1].sound = "HeroDracolichSoulsPlague"
--脊柱雨->冰刺
tt.timed_attacks.list[2] = E:clone_c("spawn_attack")
tt.timed_attacks.list[2].animation = "icePeaks"
tt.timed_attacks.list[2].cooldown = 15
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "eiskalt_icepeaks"
tt.timed_attacks.list[2].spawn_time = fts(8)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 200
tt.timed_attacks.list[2].damage_max = 200
tt.timed_attacks.list[2].damage_min = 200
--撞击地面->冻土
tt.timed_attacks.list[3] = CC("aura_attack")
tt.timed_attacks.list[3].animation = "coldFury"
tt.timed_attacks.list[3].bullet = "aura_chill_eiskalt"
tt.timed_attacks.list[3].cast_time = fts(25)
tt.timed_attacks.list[3].cooldown = 20
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].max_range = 125
tt.timed_attacks.list[3].min_range = 20
tt.timed_attacks.list[3].sound = "HeroFrostGroundFreeze"
tt.timed_attacks.list[3].step = 3
tt.timed_attacks.list[3].nodes_offset = 6
tt.timed_attacks.list[3].vis_bans = bor(F_FLYING, F_FRIEND)
tt.timed_attacks.list[3].vis_flags = F_RANGED
tt.timed_attacks.list[3].xp_from_skill = "coldfury"


tt = RT("mod_eiskalt_chill_lvl1", "mod_slow")
tt.modifier.duration = 3
tt.slow.factor = 0.5

tt = RT("mod_eiskalt_chill_lvl2", "mod_slow")
tt.modifier.duration = fts(11)
tt.slow.factor = 0.5

tt = RT("mod_eiskalt_chill_lvl3", "mod_slow")
tt.modifier.duration = fts(15)
tt.slow.factor = 0.5


tt = RT("fx_aura_chill_eiskalt_smoke", "decal_scripted")
AC(tt, "tween")
tt.main_script.update = kr4_scripts.eiskalt_cold_fury_smoke.update
tt.render.sprites[1].name = "hero_eiskalt_cold_fury_smoke_run"
tt.render.sprites[1].animated = true
tt.tween.disabled = true
tt.tween.props[1].keys = {
    { fts(20), 255 },
    { fts(40), 0 }
}

tt = RT("aura_chill_eiskalt", "aura")

AC(tt, "render", "tween")

tt.aura.cycle_time = fts(10)
tt.aura.duration = 5
tt.aura.mod = "mod_eiskalt_chill_lvl2"
tt.aura.radius = 44.800000000000004
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_ENEMY)
tt.aura.hit_decal = "fx_aura_chill_eiskalt_smoke"
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = kr1_scripts.aura_chill_elora.update
tt.render.sprites[1].name = "hero_eiskalt_cold_fury_ice"
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.remove = true
tt.tween.disabled = true
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

tt = E:register_t("fx_fireball_eiskalt_decal", "decal_tween")
tt.render.sprites[1].name = "hero_eiskalt_proyectile_travel"
tt.render.sprites[1].animated = false
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
tt = E:register_t("fx_fireball_eiskalt_ground", "fx")
tt.render.sprites[1].name = "hero_eiskalt_explosion_run"
tt.render.sprites[1].anchor.y = 0.20512820512820512
tt.render.sprites[1].sort_y_offset = -5
tt = E:register_t("fx_fireball_eiskalt_air", "fx")
tt.render.sprites[1].name = "hero_eiskalt_explosion_air_run"
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].scale = v(0.7, 0.7)
tt = E:register_t("ps_fireball_eiskalt")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "hero_eiskalt_particle_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(11),
	fts(16)
}
tt.particle_system.scale_var = {
	0.78,
	1.43
}
tt.particle_system.scales_x = {
	1,
	1.25
}
tt.particle_system.scales_y = {
	1,
	1.25
}
tt.particle_system.emission_rate = 20
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.alphas = {
	255,
	0
}
tt = E:register_t("fireball_eiskalt", "bullet")
tt.render.sprites[1].name = "hero_eiskalt_proyectile_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor.x = 0.69
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.min_speed = 390
tt.bullet.max_speed = 390
tt.bullet.hit_fx = "fx_fireball_eiskalt_ground"
tt.bullet.hit_fx_air = "fx_fireball_eiskalt_air"
tt.bullet.hit_decal = "fx_fireball_eiskalt_decal"
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 20
tt.bullet.xp_gain_factor = 0.8
tt.bullet.particles_name = "ps_fireball_eiskalt"
tt.bullet.vis_flags = F_RANGED
tt.bullet.mod = "mod_eiskalt_chill_lvl1"
tt.main_script.update = kr4_scripts.fireball_eiskalt.update
tt.sound_events.hit = "HeroDragonAttackHit"

tt = E:register_t("eiskalt_icepeaks", "bullet")

E:add_comps(tt, "tween")

tt.main_script.update = kr4_scripts.eiskalt_icepeaks.update
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 27.5
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = F_FRIEND
tt.bullet.mod = nil
tt.bullet.hit_time = fts(4)
tt.bullet.duration = 2
tt.render.sprites[1].prefix = "hero_eiskalt_ice_peaks"
tt.render.sprites[1].name = "in"
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
tt.sound_events.delayed_insert = "HeroEiskaltPeak"


tt = E:register_t("fx_eiskalt_rider_hit", "fx")
tt.render.sprites[1].name = "hero_eiskalt_proyectile_travel"

tt = E:register_t("ps_eiskalt_rider_trail_A")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "hero_eiskalt_particle_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 6
tt.particle_system.emit_area_spread = v(15, 15)
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.z = Z_OBJECTS
tt.particle_system.particle_lifetime = {
	fts(13),
	fts(13)
}
tt.particle_system.emit_offset = v(0, 0)
tt.emit_offset_relative = v(-10, 0)
tt = E:register_t("ps_eiskalt_rider_trail_B")

E:add_comps(tt, "pos", "particle_system")

tt.particle_system.name = "hero_eiskalt_particle_run"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.emission_rate = 8
tt.particle_system.emit_area_spread = v(15, 15)
tt.particle_system.anchor = v(0.5, 0.5)
tt.particle_system.z = Z_OBJECTS + 1
tt.particle_system.particle_lifetime = {
	fts(9),
	fts(9)
}
tt.particle_system.emit_offset = v(0, 0)
tt.emit_offset_relative = v(-10, 0)

tt = E:register_t("fx_eiskalt_frosty_spawn", "fx")
tt.render.sprites[1].name = "hero_eiskalt_frosty_explotion_run"
tt.render.sprites[1].anchor.y = 0.4

tt = E:register_t("bullet_eiskalt_frosty", "bombKR5")
tt.sound_events.insert = nil
tt.sound_events.hit = nil
tt.bullet.flight_time = fts(30)
tt.bullet.hit_fx = "fx_eiskalt_frosty_spawn"
tt.bullet.pop = nil
tt.bullet.pop_chance = 0
tt.bullet.rotation_speed = 4 * math.pi
tt.bullet.hit_payload = "aura_eiskalt_rider"
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 0
tt.render.sprites[1].name = "hero_eiskalt_frosty_projectile"
tt.render.sprites[1].animated = false

tt = E:register_t("aura_eiskalt_rider", "aura")
b = balance.towers.necromancer5.skill_rider

E:add_comps(tt, "render","nav_path", "tween", "motion")

tt.aura.mod = "mod_eiskalt_chill_lvl3"
tt.aura.radius = 75
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_FLYING)
tt.aura.duration = 6
tt.aura.cycle_time = fts(5)
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].prefix = "hero_eiskalt_frosty"
tt.render.sprites[1].sort_y_offset = -60
tt.render.sprites[1].animated = true
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = kr4_scripts.aura_eiskalt_skill_rider.update
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
tt.tween.remove = false
tt.motion.max_speed = 90
tt.damage_min = nil
tt.damage_max = nil
tt.damage_min_config = {32,64,96}
tt.damage_max_config = {32,64,96}
tt.damage_type = DAMAGE_PHYSICAL
tt.hit_fx = "fx_eiskalt_rider_hit"
--tt.spawn_side_fx = "hero_eiskalt_frosty_walk"
--tt.spawn_front_fx = "hero_eiskalt_frosty_walkDown"
--tt.spawn_back_fx = "hero_eiskalt_frosty_walkUp"
tt.particles_name_A = "ps_eiskalt_rider_trail_A"--"hero_eiskalt_particle_run"
tt.particles_name_B = "ps_eiskalt_rider_trail_B"--"hero_eiskalt_particle_run"
tt.sound_events.insert = "HeroEiskaltFrosty"

--代码没问题了，但是动画可能有问题，需要参见5代亡灵骑士的动画
--[[
tt = E:register_t("hero_eiskalt_frostyx", "aura")

E:add_comps(tt, "render", "nav_path", "motion", "tween")

tt.aura.duration = 3
tt.aura.duration_var = 1.0
tt.aura.damage_min = 32
tt.aura.damage_max = 32
tt.aura.damage_radius = 50
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.damage_cycle = fts(3)
tt.aura.damage_flags = F_AREA
tt.aura.damage_bans = 0
tt.motion.max_speed = 3.5 * FPS
tt.motion.max_speed_var = 0.25 * FPS
tt.main_script.insert = kr4_scripts.hero_eiskalt_frosty.insert
tt.main_script.update = kr4_scripts.hero_eiskalt_frosty.update
tt.render.sprites[1].prefix = "hero_eiskalt_frosty"
tt.render.sprites[1].sort_y_offset = -21
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].animated = true
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.tween.disabled = true
tt.tween.remove = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		tt.aura.duration_var,
		0
	}
}
]]--
tt = E:register_t("fx_power_eiskalt_drop", "fx")

E:add_comps(tt, "tween")

tt.render.sprites[1].name = "hero_eiskalt_copo"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.x = 1
tt.render.sprites[1].scale = v(0.5,0.5)
tt.render.sprites[1].z = Z_OBJECTS_SKY

tt = RT("hero_eiskalt_ultimate")

E:add_comps(tt, "user_item", "pos", "main_script", "user_selection","sound_events")

tt.can_fire_fn = kr4_scripts.hero_eiskalt_ultimate.can_fire_fn
tt.cooldown = 40
tt.duration = 12
tt.sound_events.insert = "HeroEiskaltBreath"

tt.main_script.insert = kr4_scripts.hero_eiskalt_ultimate.insert
tt.main_script.update = kr4_scripts.hero_eiskalt_ultimate.update
tt.excluded_templates = {
		"eb_umbra",
		"enemy_umbra_piece",
		"enemy_umbra_piece_flying",
		"enemy_tremor",
		"enemy_headless_horseman"
}
tt.vis_flags = bor(F_RANGED, F_FREEZE)
tt.vis_bans = 0

tt.rain = {}
tt.rain.alpha_max = 255
tt.rain.alpha_min = 150
tt.rain.angle_between = 2 * math.pi / 180
tt.rain.angle_max = -60 * math.pi / 180
tt.rain.angle_min = -80 * math.pi / 180
tt.rain.cooldown = 0.25
tt.rain.count = 6
tt.rain.delay_max = 0.25
tt.rain.disabled = false
tt.rain.distance_max = 550
tt.rain.distance_min = 450
tt.rain.duration = 0.25
tt.rain.ts = 0

tt.freeze_alpha_min = 80
tt.freeze_alpha_max = 112

tt.mod = "mod_eiskalt_freeze"

tt = E:register_t("mod_eiskalt_freeze", "mod_freeze")
E:add_comps(tt, "render")
tt.modifier.duration = 1
tt.render.sprites[1].prefix = "freeze_creep"
tt.render.sprites[1].sort_y_offset = -2
tt.custom_offsets = {}
tt.custom_offsets.flying = v(-5, 32)
tt.custom_offsets.enemy_wasp_queen = v(-5, 38)
tt.custom_offsets.eb_efreeti = v(100, 15)
tt.custom_suffixes = {}
tt.custom_suffixes.flying = "_air"
tt.custom_animations = {
		"start",
		"end"
}

tt = RT("overlay_eiskalt_freeze", "overlay_power_thunder_flash")
tt.render.sprites[1].color = { 223, 223, 255, 255 }
tt.render.sprites[2] = nil
tt.tween.props[2] = nil


----------------------------------------------
-------------------沼泽巨人--------------------
----------------------------------------------
--建造
tt = E:register_t("tower_build_swamp_monster", "tower_build")
tt.build_name = "tower_swamp_monster_lvl1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.render.sprites[2].name = "swamp_monster_towers_lvl1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 20)--v(0, 30)
tt.render.sprites[3].offset.y = 62
tt.render.sprites[4].offset.y = 62

tt = E:register_t("tower_swamp_monster_lvl1", "tower_barrack_1")
AC(tt, "tower_upgrade_persistent_data", "attacks")
tt.info.fn = kr4_scripts.tower_swamp_monster.get_info
--tt.info.portrait = "info_portraits_towers_0002"
tt.info.portrait = "gui4_bottom_info_image_towers_0023"
tt.info.i18n_key = "TOWER_SWAMP_MONSTER_LEVEL1"
tt.main_script.insert = kr4_scripts.tower_swamp_monster.insert
tt.main_script.remove = kr4_scripts.tower_swamp_monster.remove
tt.main_script.update = kr4_scripts.tower_swamp_monster.update
tt.tower.type = "swamp_monster"
tt.tower.price = 120
tt.tower.level = 1
tt.barrack.max_soldiers = 1
tt.barrack.soldier_type = "swamp_monster_soldier_lvl1"
tt.barrack.rally_range = 137.5
tt.barrack.rally_angle_offset = -0.4
tt.render.sprites[1].name = "swamp_monster_towers_lvl1_0002"
tt.render.sprites[1].offset = v(0, 20)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "swamp_monster_tower_shooter_lvl1"
tt.render.sprites[2].angles = {
	idle = {
		"idleUp",
		"idle"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
}
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 20)
tt.attacks.range = 194.5
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet = "bullet_swamp_monster_lvl1"
tt.attacks.list[1].bullet_start_offset = v(0, 55)
tt.attacks.list[1].cooldown = 2.1
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].sound = "SwampMonsterAttack"
tt.attacks.list[1].vis_bans = bor(F_NIGHTMARE)
table.remove(tt.render.sprites, 3)
tt.sound_events.insert = "SwampMonsterTaunt"
tt.sound_events.change_rally_point = "SwampMonsterTauntChange"
tt.tower.kind = TOWER_KIND_BARRACK

tt = E.register_t(E, "tower_swamp_monster_lvl2", "tower_swamp_monster_lvl1")
tt.info.i18n_key = "TOWER_SWAMP_MONSTER_LEVEL2"
tt.tower.price = 150
tt.tower.level = 2
tt.barrack.soldier_type = "swamp_monster_soldier_lvl2"
tt.render.sprites[1].name = "swamp_monster_towers_lvl2_0001"
tt.render.sprites[2].prefix = "swamp_monster_tower_shooter_lvl2"
tt.attacks.list[1].bullet = "bullet_swamp_monster_lvl2"
tt.attacks.range = 226

tt = E.register_t(E, "tower_swamp_monster_lvl3", "tower_swamp_monster_lvl1")
tt.info.i18n_key = "TOWER_SWAMP_MONSTER_LEVEL3"
tt.tower.price = 210
tt.tower.level = 3
tt.barrack.soldier_type = "swamp_monster_soldier_lvl3"
tt.render.sprites[1].name = "swamp_monster_towers_lvl3_0001"
tt.render.sprites[2].prefix = "swamp_monster_tower_shooter_lvl3"
tt.attacks.list[1].bullet = "bullet_swamp_monster_lvl3"
tt.attacks.range = 262.5

tt = E.register_t(E, "tower_swamp_monster_lvl4", "tower_swamp_monster_lvl1")
AC(tt, "powers")

tt.info.i18n_key = "TOWER_SWAMP_MONSTER_LEVEL4"
tt.tower.price = 290
tt.tower.level = 4
tt.attacks.range = 315
tt.attacks.list[1].bullet = "bullet_swamp_monster_lvl4"
tt.barrack.soldier_type = "swamp_monster_soldier_lvl4"
tt.render.sprites[1].name = "swamp_monster_towers_lvl4_0001"
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "swamp_monster_tower_smoke"
tt.render.sprites[2].name = "run"
tt.render.sprites[2].offset = v(-5, 15)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "swamp_monster_tower_smoke"
tt.render.sprites[3].name = "run"
tt.render.sprites[3].offset = v(5, 15)

for i = 4, 6 do
	tt.render.sprites[i] = E:clone_c("sprite")
	tt.render.sprites[i].prefix = "swamp_monster_tower_shooter_lvl4_layer" .. i - 3
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, -5)
	tt.render.sprites[i].anchor.y = 0.228
	tt.render.sprites[i].group = "layers"
	tt.render.sprites[i].angles = {
		idle = {
			"idleUp",
			"idle"
		},
		shoot = {
			"shootUp",
			"shootDown"
		},
	}
end
tt.attacks.list[1].bullet = "bullet_swamp_monster_lvl4"
tt.powers.stun = CC("power")
tt.powers.stun.price_base = 102--120
tt.powers.stun.price_inc = 102--120
tt.powers.stun.mod = "mod_goblirang_stun"
tt.powers.stun.enc_icon = 365
tt.powers.stun.mod_chance = {0.2,0.4,0.6}
tt.powers.instakill = CC("power")
tt.powers.instakill.price_base = 119--140
tt.powers.instakill.price_inc = 119--140
tt.powers.instakill.enc_icon = 366
tt.powers.instakill.mod_chance = {0.02,0.04,0.06}
tt.powers.eat = CC("power")
tt.powers.eat.price_base = 119--119
tt.powers.eat.enc_icon = 367
tt.powers.eat.max_level = 1
tt.powers.eat.hp = 1050

tt = E:register_t("fx_sm_splat", "fx")
tt.render.sprites[1].name = "swamp_monster_tower_explosion_run"

local arrow = E:register_t("bullet_swamp_monster_lvl4", "arrow")
arrow.bullet.hit_distance = 50
arrow.bullet.hit_fx = "fx_sm_splat"
arrow.bullet.miss_fx = "fx_sm_splat"
arrow.bullet.miss_decal = nil
--arrow.bullet.hit_blood_fx = "fx_blood_splat_wicked_sisters"
arrow.bullet.flight_time = fts(18)
arrow.bullet.damage_type = DAMAGE_PHYSICAL
arrow.render.sprites[1].name = "swamp_monster_tower_proyectile_lvl4"
arrow.render.sprites[1].animated = false
arrow.sound_events.insert = "SwampMonsterAttack"
arrow.sound_events.hit = "SwampMonsterExplosion"
arrow.bullet.prediction_error = false
arrow.bullet.predict_target_pos = true
arrow.bullet.damage_min = 99
arrow.bullet.damage_max = 110
arrow.bullet.mod = nil--"mod_wicked_sister_poison_lvl1"
arrow.bullet.particles_name = nil --"ps_bullet_tower_wicked_sisters_basic_trail"

local arrow = E:register_t("bullet_swamp_monster_lvl1", "bullet_swamp_monster_lvl4")
arrow.render.sprites[1].name = "swamp_monster_tower_proyectile_lvl1"
arrow.bullet.damage_min = 20
arrow.bullet.damage_max = 23

local arrow = E:register_t("bullet_swamp_monster_lvl2", "bullet_swamp_monster_lvl4")
arrow.render.sprites[1].name = "swamp_monster_tower_proyectile_lvl2"
arrow.bullet.damage_min = 41
arrow.bullet.damage_max = 46

local arrow = E:register_t("bullet_swamp_monster_lvl3", "bullet_swamp_monster_lvl4")
arrow.render.sprites[1].name = "swamp_monster_tower_proyectile_lvl3"
arrow.bullet.damage_min = 71
arrow.bullet.damage_max = 78

tt = RT("swamp_monster_soldier_lvl1", "soldier_elemental")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0052"
tt.main_script.insert = kr4_scripts.soldier_swamp_monster.insert
tt.main_script.update = kr4_scripts.soldier_swamp_monster.update
tt.info.i18n_key = "TOWER_SWAMP_MONSTER_MENU"
tt.health.armor = 0
tt.health.armor_inc = 0
tt.health.dead_lifetime = 20
tt.health.hp_max = 800
tt.health.hp_inc = 0
tt.health_bar.offset = v(0, 48)

tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 5
tt.melee.attacks[1].damage_inc = 0
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].damage_radius = 75
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
--tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].sound_hit = "SwampMonsterAttack"
tt.melee.attacks[1].chance = 1
tt.melee.range = 75
tt.motion.max_speed = 35
tt.regen.health = 8
tt.render.sprites[1].anchor.y = 1 / 6
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "swamp_monster_unit_lvl1"
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].is_shadow = true
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "swamp_monster_unit_lvl1_shadow"
tt.render.sprites[2].anchor.y = 0.175
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS + 1
tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "SwampMonsterOut"
tt.sound_events.death = "SwampMonsterIn"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN, F_POISON)--bor(F_LYCAN,F_INSTAKILL,F_POLYMORPH,F_DISINTEGRATED,F_POISON)

tt = RT("swamp_monster_soldier_lvl2", "swamp_monster_soldier_lvl1")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0053"
tt.health.hp_max = 1500
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.regen.health = 16
tt.render.sprites[1].prefix = "swamp_monster_unit_lvl2"
tt.render.sprites[1].anchor.x = 0.49
tt.render.sprites[2].name = "swamp_monster_unit_lvl2_shadow"
tt.health_bar.offset = v(0, 52)

tt = RT("swamp_monster_soldier_lvl3", "swamp_monster_soldier_lvl1")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0054"
tt.health.hp_max = 2200
tt.melee.attacks[1].damage_max = 70
tt.melee.attacks[1].damage_min = 40
tt.regen.health = 24
tt.render.sprites[1].prefix = "swamp_monster_unit_lvl3"
tt.render.sprites[1].anchor.x = 0.505
tt.render.sprites[2].name = "swamp_monster_unit_lvl3_shadow"
tt.health_bar.offset = v(0, 58)

tt = RT("swamp_monster_soldier_lvl4", "swamp_monster_soldier_lvl1")
AC( tt, "powers")
tt.info.portrait = "gui4_bottom_info_image_soldiers_0055"
tt.powers.stun = CC("power")
tt.powers.stun.mod = "mod_goblirang_stun"
tt.powers.stun.enc_icon = 365
tt.powers.stun.mod_chance = {0.2,0.4,0.6}
tt.powers.instakill = CC("power")
tt.powers.instakill.enc_icon = 366
tt.powers.instakill.mod_chance = {0.02,0.04,0.06}
tt.powers.eat = CC("power")
tt.powers.eat.enc_icon = 367
tt.powers.eat.max_level = 1
tt.health.hp_max = 3000
tt.regen.health = 30
tt.render.sprites[1].prefix = "swamp_monster_unit_lvl4"
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[2].name = "swamp_monster_unit_lvl4_shadow"
tt.render.sprites[2].anchor.y = 0.22
tt.health_bar.offset = v(0, 64)
tt.melee.cooldown = 2.5
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].shared_cooldown = 2.5
tt.melee.attacks[1].count = 5
tt.melee.attacks[1].damage_inc = 0
tt.melee.attacks[1].damage_max = 90
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 75
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
--tt.melee.attacks[1].hit_decal = "decal_ground_hit"
--tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].sound_hit = "SwampMonsterAttack"
tt.melee.attacks[1].chance = 1
tt.melee.attacks[2] = CC("area_attack")
tt.melee.attacks[2].cooldown = 2.5
tt.melee.attacks[2].shared_cooldown = 2.5
tt.melee.attacks[2].count = 5
tt.melee.attacks[2].damage_inc = 0
--tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].damage_max = 90
tt.melee.attacks[2].damage_min = 50
tt.melee.attacks[2].damage_radius = 75
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
--tt.melee.attacks[2].hit_decal = "decal_ground_hit"
--tt.melee.attacks[2].hit_fx = "fx_ground_hit"
tt.melee.attacks[2].hit_offset = v(35, 0)
tt.melee.attacks[2].hit_time = fts(13)
tt.melee.attacks[2].mod ="mod_swamp_stun"
tt.melee.attacks[2].animation = "stun"
tt.melee.attacks[2].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[2].pop_chance = 0.3
tt.melee.attacks[2].sound_hit = "SwampMonsterExplosion"
tt.melee.attacks[2].chance = 0
tt.melee.attacks[2].chance_inc = 0.2
tt.melee.attacks[3] = E.clone_c(E, "melee_attack")
tt.melee.attacks[3].animation = "instakill"
tt.melee.attacks[3].chance = 0
tt.melee.attacks[3].chance_inc = 0.02
tt.melee.attacks[3].cooldown = 2.5
tt.melee.attacks[3].shared_cooldown = 2.5
--tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_time = fts(18)
tt.melee.attacks[3].instakill = true
tt.melee.attacks[3].sound_hit = "SwampMonsterExplosion"
tt.melee.attacks[3].damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_EXPLODE, DAMAGE_NO_DODGE)
tt.melee.attacks[3].pop = {
  "pop_instakill"
}
tt.melee.attacks[3].pop_chance = 1
tt.melee.attacks[3].power_name = "instakill"
tt.melee.attacks[3].forced_cooldown = true
tt.melee.attacks[3].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.melee.attacks[3].vis_flags = F_BLOCK

tt = RT("mod_swamp_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 3
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