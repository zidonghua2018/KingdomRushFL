local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local E = require("entity_db")
local i18n = require("i18n")

require("constants")

local anchor_y = 0
local image_x = 0
local image_y, tt = nil
local scripts = require("game_scripts")
local scripts2 = require("game_scripts_2")
local scripts3 = require("game_scripts_3")
local scripts4 = require("game_scripts_4")

require("templates")

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

local function adx(v)
	return v - anchor_x * image_x
end

local function ady(v)
	return v - anchor_y * image_y
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

--这里为1代mod的塔
tt = RT("tower_holder_lozagon", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_LOZAGON
tt.render.sprites[1].name = "build_terrain_0009"

tt = RT("tower_time_wizard", "tower_mage_1")

AC(tt, "attacks", "powers", "barrack")

image_y = 74
tt.tower.type = "time_wizard"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.tower.long_idle_cooldown = 2
tt.info.enc_icon = 19
tt.info.i18n_key = "TOWER_TIME_WIZARD"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_2223") or "info_portraits_towers_2223"
tt.barrack.soldier_type = "soldier_ancient_guardian"
tt.barrack.rally_range = 225
tt.powers.sandstorm = CC("power")
tt.powers.sandstorm.price_base = 300
tt.powers.sandstorm.price_inc = 200
tt.powers.sandstorm.cooldown_base = 24
tt.powers.sandstorm.cooldown_inc = -4
tt.powers.sandstorm.enc_icon = 93
tt.powers.sandstorm.name = "SANDSTORM"
tt.powers.guardian = CC("power")
tt.powers.guardian.price_base = 200
tt.powers.guardian.price_inc = 200
tt.powers.guardian.enc_icon = 94
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_time_wizard"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 38)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_time_wizard_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	sandstorm = {
		"sandstormUp",
		"sandstormDown"
	}
}
tt.render.sprites[3].offset = v(0, 76)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_time_wizard_polymorph"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(0, 80)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].hide_after_runs = 1
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_time_wizard.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.insert = "MageTimeWizardTaunt"
tt.sound_events.change_rally_point = "AncientGuardRally"
tt.attacks.range = 248
tt.attacks.min_cooldown = 0.1
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_time_wizard"
tt.attacks.list[1].bullet_start_offset = {
	v(8, 84),
	v(-6, 84)
}
tt.attacks.list[1].cooldown = 2
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].bullet_start_offset = {
	v(8, 84),
	v(-6, 84)
}
tt.attacks.list[2].animation = "sandstorm"
tt.attacks.list[2].bullet = "time_wizard_sandstorm"
tt.attacks.list[2].cooldown = 1
tt.attacks.list[2].shoot_time = fts(7)
tt.attacks.list[2].vis_bans = bor(F_FLYING)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED)
tt = RT("tower_steam_troop", "tower_barrack_1")

AC(tt, "powers")

tt.barrack.soldier_type = "soldier_steam_troop"
tt.info.i18n_key = "TOWER_STEAM_TROOP"
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_2224"
tt.powers.airstrike = E.clone_c(E, "power")
tt.powers.airstrike.price_base = 300
tt.powers.airstrike.price_inc = 200
tt.powers.airstrike.enc_icon = 96
tt.powers.airstrike.name = "AIRSTRIKE"
tt.powers.steam = E.clone_c(E, "power")
tt.powers.steam.price_base = 150
tt.powers.steam.price_inc = 150
tt.powers.steam.enc_icon = 97
tt.powers.ball = CC("power")
tt.powers.ball.price_base = 200
tt.powers.ball.max_level = 1
tt.powers.ball.enc_icon = 95
tt.main_script.update = scripts.tower_steam_troop.update
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_steam_troop"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].animated = true
tt.render.sprites[2].offset = v(-5, 49)
tt.render.sprites[3].prefix = "tower_steam_troop_door"
tt.render.sprites[3].offset = v(0, 14)
tt.sound_events.insert = "SteamTrooperInsert"
tt.sound_events.change_rally_point = "SteamTrooperRally"
tt.sound_events.mute_on_level_insert = true
tt.tower.price = 260
tt.tower.type = "steam_troop"
tt = RT("soldier_steam_troop", "soldier_militia")

AC(tt, "powers", "ranged", "track_damage")

tt.health.armor = 0.5
tt.health.dead_lifetime = 13
tt.health.hp_max = 220
tt.regen.health = 20
tt.health.spiked_armor = 0
tt.info.portrait = "info_portraits_soldiers_1347"
tt.info.random_name_format = "STEAM_SOLDIER_%i_NAME"
tt.info.random_name_count = 14
tt.main_script.update = scripts.soldier_steam_trooper.update
tt.powers.steam = E.clone_c(E, "power")
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 12
tt.melee.attacks[1].damage_min = 9
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "steam"
tt.melee.attacks[2].chance = 0
tt.melee.attacks[2].chance_inc = 0.11
tt.melee.attacks[2].damage_max = 17
tt.melee.attacks[2].damage_min = 14
tt.melee.attacks[2].damage_radius = 70
tt.melee.attacks[2].mod = "mod_steam_troop_freeze"
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(12)
tt.melee.attacks[2].level = 0
tt.melee.attacks[2].pop = nil
tt.melee.attacks[2].power_name = "steam"
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_BOSS)
tt.melee.attacks[2].vis_flags = bor(F_BLOCK)
tt.melee.attacks[3] = CC("melee_attack")
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].animation = "attack"
tt.melee.attacks[3].track_damage = false
tt.melee.attacks[3].damage_max = 12
tt.melee.attacks[3].damage_min = 9
tt.melee.attacks[3].cooldown = 0.5
tt.melee.attacks[3].hit_time = fts(12)
tt.melee.attacks[3].power_name = "ball"
tt.melee.cooldown = fts(11) + 1
tt.melee.range = 60
tt.motion.max_speed = 75
tt.powers.airstrike = E.clone_c(E, "power")
tt.powers.ball = CC("power")
tt.ranged.attacks[1].bullet = "bomb_steam_troop"
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet_start_offset = {
	v(14, 12)
}
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 55
tt.ranged.attacks[1].node_prediction = fts(23)
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].sound_shoot = "SteamTrooperAttack"
tt.ranged.attacks[1].vis_bans = bor(F_FLYING)
tt.ranged.attacks[2] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[2].bullet = "airstrike_steam_troop"
tt.ranged.attacks[2].animation = "call"
tt.ranged.attacks[2].bullet_start_offset = {
	v(0, 12)
}
tt.ranged.attacks[2].cooldown = 8
tt.ranged.attacks[2].vis_bans = bor(F_FLYING)
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].level = 0
tt.ranged.attacks[2].max_range = 100
tt.ranged.attacks[2].min_range = 55
tt.ranged.attacks[2].power_name = "airstrike"
tt.ranged.attacks[2].node_prediction = fts(45)
tt.ranged.attacks[2].range_inc = 50
tt.ranged.attacks[2].shoot_time = 0.5
tt.render.sprites[1].prefix = "steam_trooper"
tt.render.sprites[1].anchor.y = 0.2037037037037037
tt.render.sprites[1].offset = v(0, -5)
tt.track_damage.mod = "mod_steam_troop_death"
tt.unit.mod_offset = v(0, 15)
tt.vis.flags = bor(tt.vis.flags, F_DARK_ELF)
tt.sound_events.death = "BombExplosionSound"
tt = RT("bomb_steam_troop", "bomb")
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 20
tt.bullet.damage_min = 10
tt.bullet.damage_radius = 47.5
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.flight_time = fts(25)
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = {
	"pop_kboom"
}
tt.render.sprites[1].name = "pirateTower_bomb"
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.sound_events.insert = nil
tt.sound_events.hit = "BombExplosionSound"
tt = RT("airstrike_steam_troop", "bomb")
tt.bullet.damage_max = 120
tt.bullet.damage_min = 60
tt.bullet.damage_min_inc = 60
tt.bullet.damage_max_inc = 60
tt.bullet.damage_radius = 70
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.flight_time = fts(1)
tt.main_script.update = scripts.airstrike.update
tt.bullet.hit_fx = "fx_explosion_airstrike"
tt.bullet.pop = {
	"pop_kboom"
}
tt.render.sprites[1].name = "pirateTower_bombasticwhat"
tt.render.sprites[1].scale = v(1, 1)
tt.sound_events.insert = nil
tt.sound_events.hit = "SteamTroopersAirstrike"
tt = RT("mod_steam_troop_freeze", "mod_freeze")

AC(tt, "render")

tt.modifier.duration = 1
tt.modifier.vis_bans = bor(F_BOSS, F_FREEZE)
tt.modifier.vis_flags = bor(F_MOD, F_FREEZE)
tt.render.sprites[1].prefix = "freeze_creep"
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].loop = false
tt.custom_offsets = {
	flying = v(-5, 32)
}
tt.custom_suffixes = {
	flying = "_air"
}
tt.custom_animations = {
	"start",
	"end"
}
tt = E.register_t(E, "mod_steam_troop_death", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = -1
tt.render.sprites[1].hidden = true
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 10
tt.main_script.insert = scripts2.mod_track_target.insert
tt.main_script.update = scripts2.mod_track_target.update
tt.main_script.remove = scripts.mod_steam_soldier_explode.remove
tt.explode_fx = "fx_explosion_fragment"
tt.explode_range = 67.5
tt.explode_damage = 100
tt.explode_vis_bans = bor(F_DARK_ELF, F_BOSS, F_FRIEND)
tt.explode_vis_flags = F_RANGED
tt.explode_excluded_templates = {
	"hero_regson"
}
tt = E.register_t(E, "soldier_ancient_guardian", "soldier")

E.add_comps(E, tt, "melee", "auras")
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 999999
tt.auras.list[1].name = "ancient_guardian_aura"
tt.health.armor = 0
tt.health.armor_inc = 0.25
tt.health.dead_lifetime = 12
tt.health.hp_inc = 50
tt.health.hp_max = 150
tt.health_bar.offset = v(0, 47.76)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts2.soldier_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_1346") or "info_portraits_soldiers_1346"
tt.main_script.insert = scripts2.ancient_guardian.insert
tt.main_script.update = scripts2.ancient_guardian.update
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].damage_inc = 30
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].mod = nil
tt.melee.range = 65
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 50
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = 0.18
tt.render.sprites[1].angles = {
  walk = {
    "running"
  }
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_ancient_guardian"
tt.sound_events.insert = "AncientGuardSpawn"
tt.sound_events.death = "AncientGuardDeath"
tt.soldier.melee_slot_offset = v(15, 0)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POLYMORPH, F_LYCAN, F_CANNIBALIZE)
tt = E.register_t(E, "ancient_guardian_aura_nil", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = nil
tt.aura.cycle_time = 0
tt.aura.duration = 0
tt.aura.radius = 0
tt.aura.track_source = true
tt.aura.allowed_templates = {}
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts2.aura_apply_mod.update
tt.render.sprites[1].name = nil
tt.render.sprites[1].loop = true
tt = E.register_t(E, "ancient_guardian_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = "mod_ancient_guardian"
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 150
tt.aura.track_source = true
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts.aura_ancient_guardian.update
tt.render.sprites[1].name = "mod_ancient_aura"
tt.render.sprites[1].loop = true
tt = RT("enemy_cursed_shaman", "enemy")

AC(tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.2
anchor_x = 0.5
image_y = 60
image_x = 60
tt.enemy.lives_cost = 2
tt.enemy.gold = 70
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = {
	800,
	900,
	1000,
	1100
}
tt.health.magic_armor = 0.85
tt.health_bar.offset = v(0, 33)
tt.info.i18n_key = "ENEMY_CURSED_SHAMAN"
tt.info.enc_icon = 71
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0095") or "info_portraits_sc_0095"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_cursed_shaman.update
tt.melee.attacks[1].cooldown = fts(18) + 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*0.5
tt.ranged.attacks[1].bullet = "bolt_cursed_shaman"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 23)
}
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(7)
tt.ranged.attacks[1].cooldown = fts(50)
tt.ranged.attacks[1].hold_advance = true
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].prefix = "enemy_cursed_shaman"
tt.sound_events.death = "DeathGoblin"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "heal"
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].cooldown = 3
tt.timed_attacks.list[1].max_count = 10
tt.timed_attacks.list[1].max_range = 100
tt.timed_attacks.list[1].mod = "mod_cursed_shaman_heal"
tt.timed_attacks.list[1].mod2 = "mod_cursed_shield"
tt.timed_attacks.list[1].sound = "EnemyHealing"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[1].vis_bans = F_BOSS
tt.timed_attacks.list[1].excluded_templates = {
"enemy_cursed_shaman"
}
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_hobgoblin_small", "enemy")

AC(tt, "melee")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.enemy.gold = 20
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0.25
tt.health.hp_max = {
	200,
	240,
	280,
	320
}
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_HOBGOBLIN"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(6)
tt.motion.max_speed = {
    FPS*1.4*1.28,
    FPS*1.4*1.28,
    FPS*1.4*1.28,
    FPS*1.4*1.28*1.1
}
tt.render.sprites[1].anchor = v(0.5, 0.19)
tt.render.sprites[1].prefix = "enemy_hobgoblin_small"
tt.sound_events.death = "DeathGoblin"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt = RT("enemy_hobgoblin_rider", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.14
anchor_x = 0.5
image_y = 62
image_x = 62
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "enemy_hobgoblin_small"
tt.enemy.gold = 20
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = {
	120,
	140,
	160,
	180
}
tt.health.magic_armor = 0.2
tt.health_bar.offset = v(0, 48)
tt.main_script.insert = scripts2.enemy_basic.insert
tt.main_script.update = scripts.enemy_hobgoblin_rider.update
tt.info.i18n_key = "ENEMY_HOBGOBLIN_RIDER"
tt.info.enc_icon = 73
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.melee.attacks[1].cooldown = 1e+99
tt.melee.attacks[1].damage_max = 0
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = nil
tt.motion.max_speed = {
    FPS*1.5*1.28,
    FPS*1.5*1.28,
    FPS*1.5*1.28,
    FPS*1.5*1.28*1.1
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_hobgoblin_rider"
tt.render.sprites[1].angles_stickiness.run = 10
tt.render.sprites[1].angles.run = {
	"runningRightLeft",
	"runningUp",
	"runningDown"
}
tt.sound_events.death = "DeathPuff"
tt.sound_events.insert = "WolfAttack"
tt.ui.click_rect.size = v(32, 38)
tt.ui.click_rect.pos = v(-16, 2)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 23)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(31), ady(29))
tt.unit.show_blood_pool = false
tt.coward_duration = 1
tt.coward_speed_factor = 1.4
tt.vis.bans = bor(F_SKELETON)
tt = E.register_t(E,"enemy_hobgoblin_shield", "enemy")

E.add_comps(E, tt, "melee", "timed_attacks")

anchor_y = 0.2125
anchor_x = 0.5
image_y = 85
image_x = 104
tt.enemy.lives_cost = 3
tt.enemy.gold = 100
tt.enemy.melee_slot_offset = v(35, 0)
tt.health.armor = 0.3
tt.health.magic_armor = 0
tt.health.hp_max = {
	1600,
	2000,
	2400,
	3200
}
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 54)
tt.info.i18n_key = "ENEMY_HOBGOBLIN_SHIELD"
tt.info.enc_icon = 72
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0096") or "info_portraits_sc_0096"
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts.enemy_hobgoblin_shield.update
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].count = 3
tt.melee.attacks[1].damage_max = 138
tt.melee.attacks[1].damage_min = 60
tt.melee.attacks[1].damage_radius = 44.800000000000004
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(22, 5)
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "cast"
tt.timed_attacks.list[1].cast_time = fts(16)
tt.timed_attacks.list[1].cooldown = 7000000000000000
tt.timed_attacks.list[1].vis_bans = bor(F_BOSS, F_DARK_ELF)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_ENEMY)
tt.timed_attacks.list[1].max_range = 125
tt.timed_attacks.list[1].mod = "mod_twilight_avenger_last_service"
tt.timed_attacks.list[1].sound = "ElvesCreepAvenger"
tt.shield_extra_armor = 0.7
tt.shield_off_armor = tt.health.armor
tt.shield_on_armor = tt.health.armor + tt.shield_extra_armor
tt.motion.max_speed = {
	FPS*0.65*1.28,
	FPS*0.65*1.28,
	FPS*0.65*1.28,
	FPS*0.65*1.28
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_hobgoblin_shield"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(30, 40)
tt.ui.click_rect.pos.x = -15
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("enemy_goblin_spear", "enemy")

AC(tt, "melee", "ranged")

anchor_y = 0.2
anchor_x = 0.5
image_y = 36
image_x = 54
tt.enemy.gold = 15
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = {
	120,
	130,
	145,
	160
}
tt.health.magic_armor = {
	0,
	0,
	0,
	0
}
tt.health_bar.offset = v(0, 31)
tt.info.i18n_key = "ENEMY_GOBLIN_SPEAR"
tt.info.enc_icon = 74
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0025") or "info_portraits_sc_0097"
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(4)
tt.motion.max_speed = FPS*1.4
tt.ranged.attacks[1].bullet = "spear_goblin"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-11, 12.5)
}
tt.ranged.attacks[1].cooldown = fts(18) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 215
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(4)
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].prefix = "enemy_goblin_spear"
tt.sound_events.death = "DeathGoblin"
tt.unit.hit_offset = v(0, 15)
tt.unit.mod_offset = v(adx(26), ady(20))
tt.unit.marker_offset.y = 1
tt = RT("enemy_goblin_balloon", "enemy")

AC(tt, "ranged")
anchor_y = 0
anchor_x = 0.5
image_y = 88
image_x = 58
tt.enemy.lives_cost = 3
tt.enemy.gold = 80
tt.health.hp_max = {
	1050,
	1200,
	1350,
	1500
}
tt.health.armor = {
	0.3,
	0.3,
	0.3,
	0.5
}
tt.health_bar.offset = v(adx(29), ady(169))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_GOBLIN_BALLOON"
tt.info.enc_icon = 75
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0061") or "info_portraits_sc_0061"
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.motion.max_speed = FPS*0.5
tt.ranged.attacks[1].bullet = "goblin_balloon_bomb"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 57.5)
}
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 70
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].sync_animation = true
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_goblin_balloon"
tt.render.sprites[1].offset = v(0, 40)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "BombExplosionSound"
tt.ui.click_rect = r(-14, 49, 35, 35)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, 65)
tt.unit.hide_after_death = true
tt.unit.mod_offset = v(adx(31), ady(70))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)

tt = RT("enemy_goblin_platform", "enemy")

AC(tt, "ranged")
anchor_y = 0
anchor_x = 0.5
image_y = 88
image_x = 58
tt.enemy.lives_cost = 5
tt.enemy.gold = 160
tt.health.hp_max = {
    1400,
    1600,
    1800,
    2000
}
tt.health.armor = 0
tt.health_bar.offset = v(adx(29), ady(189))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_GOBLIN_PLATFORM"
tt.info.enc_icon = 80
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0061") or "info_portraits_sc_0061"
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.motion.max_speed = {
    FPS*0.4,
    FPS*0.4,
    FPS*0.4,
    FPS*0.4
}
tt.ranged.attacks[1].bullet = "goblin_platform_bomb"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 57.5)
}
tt.ranged.attacks[1].cooldown = 1
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 70
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].sync_animation = true
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_goblin_platform"
tt.render.sprites[1].offset = v(0, 40)
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "BombExplosionSound"
tt.ui.click_rect = r(-14, 49, 35, 35)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, 52)
tt.unit.hide_after_death = true
tt.unit.mod_offset = v(adx(31), ady(65))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)

tt = RT("hero_viper", "hero")

AC(tt, "melee", "ranged")

anchor_y = 0.13636363636363635
anchor_x = 0.5
image_y = 110
image_x = 90
tt.hero.fixed_stat_attack = 7
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 3
tt.hero.level_stats.armor = {
	0.25,
	0.25,
	0.3,
	0.3,
	0.35,
	0.35,
	0.4,
	0.4,
	0.4,
	0.4
}
tt.hero.level_stats.hp_max = {
	250,
	270,
	290,
	310,
	330,
	350,
	370,
	390,
	410,
	430
}
tt.hero.level_stats.poison_damage_min = {
	2,
	2,
	3,
	3,
	3,
	4,
	4,
	4,
	5,
	5
}
tt.hero.level_stats.poison_damage_max = {
	2,
	2,
	3,
	3,
	3,
	4,
	4,
	4,
	5,
	5
}
tt.hero.level_stats.melee_damage_max = {
	11,
	12,
	13,
	15,
	16,
	17,
	19,
	20,
	21,
	23
}
tt.hero.level_stats.melee_damage_min = {
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17
}
tt.hero.level_stats.regen_health = {
	63,
	68,
	73,
	78,
	83,
	88,
	93,
	97,
	102,
	107
}
tt.hero.skills.curse = CC("hero_skill")
tt.hero.skills.curse.cooldown = {
	12,
	12,
	12
}
tt.hero.skills.curse.duration = {
	4,
	6,
	8
}
tt.hero.skills.curse.poison = {
	6,
	8,
	10
}
tt.hero.skills.curse.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.curse.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.shuriken = CC("hero_skill")
tt.hero.skills.shuriken.bounces = {
	3,
	4,
	5
}
tt.hero.skills.shuriken.damage_min = {
	20,
	40,
	60
}
tt.hero.skills.shuriken.damage_max = {
	20,
	40,
	60
}
tt.hero.skills.shuriken.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.shuriken.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_viper.level_up
tt.hero.tombstone_show_time = fts(150)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0017") or "heroPortrait_portraits_0014"
tt.info.i18n_key = "HERO_VIPER"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0011") or "info_portraits_hero_0016"
tt.main_script.update = scripts.hero_viper.update
tt.motion.max_speed = FPS*3.3
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.13636363636363635)
tt.render.sprites[1].prefix = "hero_viper"
tt.soldier.melee_slot_offset = v(13, 0)
tt.sound_events.death = "HeroViperDeath"
tt.sound_events.change_rally_point = "HeroViperTaunt"
tt.sound_events.hero_room_select = "HeroViperTauntSelect"
tt.sound_events.insert = "HeroSamuraiTauntIntro"
tt.sound_events.respawn = "HeroSamuraiTauntIntro"
tt.unit.hit_offset = v(0, 0)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 25)
tt.unit.pop_offset = v(0, 25)
tt.unit.hit_offset = v(0, 25)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.melee.order = {
	2,
	1,
}
tt.melee.range = 50
tt.melee.cooldown = 0.6
tt.melee.attacks[1].cooldown = 0.55
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 4.8
tt.melee.attacks[1].mod = "mod_viper_poison"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].animation = "attack1"
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].animation = "timber"
tt.melee.attacks[2].cooldown = nil
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(14)
tt.melee.attacks[2].pop = {
	"pop_splat"
}
tt.melee.attacks[2].pop_chance = 0
tt.melee.attacks[2].sound = "HeroViperCurse"
tt.melee.attacks[2].damage_type = bor(DAMAGE_PHYSICAL, DAMAGE_NO_DODGE)
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].xp_from_skill = "curse"
tt.melee.attacks[2].vis_flags = bor(F_MOD)
tt.melee.attacks[2].vis_bans = bor(F_BOSS)
tt.melee.attacks[2].mod = "mod_viper_debuff_new"
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[3].shared_cooldown = true
tt.melee.attacks[3].animation = "attack2"
tt.melee.attacks[3].chance = 0.5
tt.ranged.go_back_during_cooldown = true
tt.ranged.range_while_blocking = false
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "sawblade"
tt.ranged.attacks[1].bullet = "viper_shuriken_goblirang"
tt.ranged.attacks[1].mod = "mod_viper_poison"
tt.ranged.attacks[1].bullet_start_offset = {
	v(25, 21)
}
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].max_range = 170
tt.ranged.attacks[1].min_range = 1
tt.ranged.attacks[1].shoot_time = fts(7)
tt.ranged.attacks[1].sound_shoot = nil
tt.ranged.attacks[1].cooldown = 5
tt.ranged.attacks[1].xp_from_skill = "shuriken"
tt = RT("enemy_cursed_golem", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.19
anchor_x = 0.5
image_y = 84
image_x = 108
tt.enemy.gold = 100
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.quantity = 4
tt.death_spawns.spread_nodes = 3
tt.death_spawns.name = "enemy_cursed_shard"
tt.death_spawns.path = 4
tt.death_spawns.spawn_animation = "raise"
tt.death_spawns.no_spawn_damage_types = DAMAGE_EXPLOSION
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(25, 0)
tt.main_script.insert = scripts3.enemy_basic.insert
tt.health.hp_max = {
	3000,
	3500,
	4000,
	4500
}
tt.health.magic_armor = {
	0.75,
	0.75,
	0.75,
	0.95
}
tt.health_bar.offset = v(0, 62)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0101") or "info_portraits_sc_0101"
tt.info.i18n_key = "ENEMY_CURSED_GOLEM"
tt.info.enc_icon = 76
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = {
	100,
	100,
	100,
	150
}
tt.melee.attacks[1].damage_min = {
	50,
	50,
	50,
	100
}
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_MAGICAL
tt.melee.attacks[1].hit_decal = "decal_cg_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.motion.max_speed = {
	FPS*0.5*1.28,
	FPS*0.5*1.28,
	FPS*0.5*1.28,
	FPS*0.5*1.28
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_cursed_golem"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect.size = v(50, 56)
tt.ui.click_rect.pos.x = -25
tt.unit.blood_color = BLOOD_GREEN
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 24)
tt.unit.mod_offset = v(adx(53), ady(38))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_POISON)

tt = RT("enemy_cursed_shard", "enemy")

AC(tt, "melee")

anchor_y = 0.3
anchor_x = 0.5
image_y = 42
image_x = 58
tt.enemy.gold = 28
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = {
	0.20,
	0.20,
	0.20,
	0.25
}
tt.health.magic_armor = {
	0,
	0,
	0,
	0.15
}
tt.health.hp_max = {
	187,
	218,
	250,
	281
}
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_CURSED_SHARD"
tt.info.enc_icon = 77
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0102") or "info_portraits_sc_0102"
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 22
tt.melee.attacks[1].damage_min = 8
tt.melee.attacks[1].hit_time = fts(6)
tt.motion.max_speed = FPS*1.5
tt.unit.can_explode = false
tt.render.sprites[1].anchor = v(0.5, 0.3)
tt.render.sprites[1].prefix = "enemy_cursed_shard"
tt.sound_events.death = "RockElementalDeath"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_POISON)
tt = RT("cursed_golem_spawner")

AC(tt, "main_script")

tt.main_script.update = scripts.s11_lava_spawner.update
tt.entity = "enemy_cursed_golem"
tt.cooldown = 180
tt.cooldown_after = 80
tt.pi = 4
tt.sound = "RockElementalDeath"
tt = RT("enemy_hobgoblin_miniboss", "enemy")

AC(tt, "melee")

anchor_y = 0.17532467532467533
anchor_x = 0.5
image_y = 154
image_x = 224
tt.enemy.gold = 300
tt.enemy.lives_cost = 8
tt.enemy.melee_slot = v(40, 0)
tt.health.hp_max = {
	6400,
	7200,
	8000,
	9600
}
tt.health.armor = {
	0.6,
	0.6,
	0.6,
	0.6
}
tt.health_bar.offset = v(0, 82)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_HOBGOBLIN_MINIBOSS"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0098") or "info_portraits_sc_0098"
tt.info.enc_icon = 78
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 180
tt.melee.attacks[1].damage_min = 80
tt.melee.attacks[1].damage_radius = 45
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_hobgoblin_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_hobgoblin_ground_hit"
tt.melee.attacks[1].hit_offset = v(72, -9)
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound = "AreaAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(24)
}
tt.motion.max_speed = {
	FPS*0.7*1.28,
	FPS*0.7*1.28,
	FPS*0.7*1.28,
	FPS*0.7*1.28
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_hobgoblin"
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.render.sprites[1].angles_flip_vertical = {
	walk = true
}
tt.sound_events.death = "DeathJuggernaut"
tt.ui.click_rect = r(-30, 0, 60, 70)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 34)
tt.unit.mod_offset = v(0, 34)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt = RT("eb_hobgoblin", "boss")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.08
anchor_x = 0.5
image_y = 128
image_x = 144
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "hobgoblin_spawner_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 3
tt.health.hp_max = {
12000,
15000,
18000,
21000
}
tt.health.magic_armor = {
0.2,
0.40,
0.65,
0.95
}
tt.health.armor = 0
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.offset = v(0, ady(75))
tt.info.fn = scripts.eb_juggernaut.get_info
tt.info.i18n_key = "EB_HOBGOBLIN"
tt.info.enc_icon = 79
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0099") or "info_portraits_sc_0099"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_hobgob.update
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(0.5, 0.08)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_hobgoblin"
tt.sound_events.death = "HobgobBossDeath1"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-35, 0, 70, 80)
tt.unit.blood_color = BLOOD_RED
tt.unit.hit_offset = v(0, ady(35))
tt.unit.mod_offset = v(adx(65), ady(35))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].damage_type = bor(DAMAGE_NO_DODGE, DAMAGE_INSTAKILL, DAMAGE_DISINTEGRATE_BOSS)
tt.melee.attacks[1].damage_max = 500
tt.melee.attacks[1].damage_min = 300
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].hit_fx = nil
tt.melee.attacks[1].sound_hit = "VeznanAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "shoot"
tt.timed_attacks.list[1].bullet = "missile_hobgob"
tt.timed_attacks.list[1].bullet_start_offset = v(-30, 82)
tt.timed_attacks.list[1].cooldown = 8
tt.timed_attacks.list[1].launch_vector = v(12, 170)
tt.timed_attacks.list[1].max_range = 600
tt.timed_attacks.list[1].min_range = 100
tt.timed_attacks.list[1].shoot_time = 0.2
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = F_HERO
tt.timed_attacks.list[1].sound = "VeznanPortalSummon"
tt.timed_attacks.list[2] = table.deepclone(tt.timed_attacks.list[1])
tt.timed_attacks.list[2].bullet = "bomb_hobbgoblin"
tt.timed_attacks.list[2].cooldown = 5
tt.timed_attacks.list[2].sound = "VeznanPortalSummon"
tt = RT("enemy_hobboss_swap", "enemy")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.health.dead_lifetime = 3.95
tt.ui.click_rect = r(0, 0, 0, 0)
tt.enemy.gold = 0
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.enemy.melee_slot = v(18, 0)
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_passive.update
tt.health.armor = 0
tt.health.hp_max = 0
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_BOSS_SWAP"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.motion.max_speed = 0
tt.unit.can_explode = false
tt.sound_events.death = "HobgobBossSpawn"
tt.unit.show_blood_pool = false
tt.render.sprites[1].anchor = v(0.5, 0.08)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_hobtransform"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_FRIEND, F_BLOCK, F_RANGED, F_MOD, F_STUN, F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_SKELETON)
tt = RT("enemy_tp_aura", "enemy")

AC(tt, "auras")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_teleport_hobgoblin"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.enemy.melee_slot = v(18, 0)
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_passive.update
tt.health.armor = 0
tt.health.hp_max = 0
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_TP_AURA"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.motion.max_speed = 0
tt.unit.can_explode = false
tt.sound_events.death = nil
tt.unit.show_blood_pool = false
tt.render.sprites[1].prefix = "totem_violet"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.5, 0.11)
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_FRIEND, F_BLOCK, F_RANGED, F_MOD, F_STUN, F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_SKELETON)
tt = RT("enemy_curse_aura", "enemy")

AC(tt, "auras")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_curse_hobgoblin"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.enemy.melee_slot = v(18, 0)
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_passive.update
tt.health.armor = 0
tt.health.hp_max = 0
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_CURSE_AURA"
tt.info.enc_icon = 70
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.motion.max_speed = 0
tt.unit.can_explode = false
tt.sound_events.death = nil
tt.unit.show_blood_pool = false
tt.render.sprites[1].prefix = "totem_violet"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.5, 0.11)
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.bans = bor(F_FRIEND, F_BLOCK, F_RANGED, F_MOD, F_STUN, F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_SKELETON)
tt = E.register_t(E, "missile_hobgob", "bullet")
tt.bullet.mod = "mod_hobgob_poison"
tt.render.sprites[1].prefix = "missile_hobgoblin"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.min_speed = 300
tt.bullet.max_speed = 400
tt.bullet.turn_speed = (math.pi*10)/180*30
tt.bullet.acceleration_factor = 0.1
tt.bullet.hit_fx = "fx_fireball_dracolich_ground"
tt.bullet.hit_fx_air = "fx_fireball_dracolich_ground"
tt.bullet.hit_fx_water = "fx_fireball_dracolich_ground"
tt.bullet.damage_min = 1
tt.bullet.damage_max = 1
tt.bullet.damage_radius = 80
tt.bullet.vis_flags = F_RANGED
tt.bullet.damage_flags = F_AREA
tt.bullet.retarget_range = 0
tt.main_script.update = scripts.enemy_missile.update
tt.bullet.vis_bans = bor(F_ENEMY, F_HERO, F_SKELETON)
tt.bullet.damage_bans = bor(F_ENEMY, F_HERO, F_SKELETON)
tt.bullet.particles_name = "ps_missile_hobgoblin"
tt.sound_events.insert = "ElvesHeroVeznanArcaneNova"
tt.sound_events.hit = "ElvesHeroVeznanDemonFireballHit"

tt = E.register_t(E, "ps_missile_hobgoblin")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "missile_hobgoblin_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	0.1,
	0.1
}
tt.particle_system.emission_rate = 50

tt = RT("eb_hobgoblin_two", "boss")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.1402439024390244
anchor_x = 0.5
image_y = 232
image_x = 244
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "hobgoblin_two_spawner_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 6
tt.health.hp_max = {
15000,
20000,
25000,
30000
}
tt.health.armor = {
0.4,
0.4,
0.4,
0.95
}
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_hobgob2.get_info
tt.info.i18n_key = "EB_HOBGOBLIN_TWO"
tt.info.enc_icon = 45
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0100") or "info_portraits_sc_0100"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_hobgob2.update
tt.motion.max_speed = {
	FPS*0.3,
	FPS*0.3,
	FPS*0.3,
	FPS*0.25
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_hobgoblin2"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "HobgobBossDeath2"
tt.sound_events.shoot = "ElvesHeroVeznanArcaneNova"
tt.ui.click_rect = r(-30, -5, 60, 60)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.fade_time_after_death = 100
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(0, 20)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_POISON)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 200
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].sound_hit = "HobgobBossAttack"
tt.melee.attacks[1].hit_fx = nil
tt.melee.attacks[2] = CC("area_attack")
tt.melee.attacks[2].cooldown = 9
tt.melee.attacks[2].animation = "attack3"
tt.melee.attacks[2].hit_decal = "decal_cg_ground_hit"
tt.melee.attacks[2].damage_max = 1
tt.melee.attacks[2].damage_min = 1
tt.melee.attacks[2].damage_radius = 60
tt.melee.attacks[2].count = 10
tt.melee.attacks[2].hit_time = fts(10)
tt.melee.attacks[2].mod = "mod_curse_two_hobgoblin"
tt.melee.attacks[2].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[2].sound_hit = "HobgobBossAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "shoot"
tt.timed_attacks.list[1].bullet = "bomb_hobgoblin_two"
tt.timed_attacks.list[1].count = 2
tt.timed_attacks.list[1].bullet_start_offset = v(0, 500)
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].shoot_time = fts(13)
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = F_ENEMY
tt.timed_attacks.list[1].max_range = 50
tt.timed_attacks.list[1].min_range = 50
tt.timed_attacks.list[1].sound = "ElvesHeroVeznanArcaneNova"
tt = RT("mod_hobgob_poison", "modifier")

AC(tt, "render", "dps")

tt.explode_fx = "fx_unit_explode"
tt.modifier.duration = 3
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.nodes_limit = 0
tt.modifier.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.spawn_entity = "enemy_cursed_shard"
tt.render.sprites[1].name = "mod_dark_spitters"
tt.render.sprites[1].draw_order = 10
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dark_spitters.update
tt.dps.damage_every = 1
tt.dps.damage_max = 100
tt.dps.damage_min = 100
tt.dps.damage_type = DAMAGE_POISON
tt = RT("mod_curse_two_hobgoblin", "modifier")

AC(tt, "render", "dps")

tt.explode_fx = "fx_unit_explode"
tt.modifier.duration = 0.1
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.nodes_limit = 0
tt.modifier.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.spawn_entity = "enemy_cursed_shard"
tt.render.sprites[1].name = "mod_dark_spitters"
tt.render.sprites[1].draw_order = 10
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dark_spitters.update
tt.dps.damage_every = 0.3
tt.dps.damage_max = 250
tt.dps.damage_min = 150
tt.dps.damage_type = DAMAGE_POISON
tt = RT("bomb_hobbgoblin", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 1
tt.bullet.flight_time_base = 0
tt.bullet.flight_time_factor = 0
tt.bullet.pop = nil
tt.bullet.hit_payload = "hobgoblin_bomb_spawner"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.bullet.hit_fx = nil
tt.render.sprites[1].name = "bossJuggernaut_bomb_"
tt.sound_events.insert = "VeznanPortalSummon"
tt.sound_events.hit = nil
tt = RT("bomb_hobgoblin_two", "bomb")
tt.bullet.particles_name = "ps_hobgoblin_meteor"
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 100
tt.bullet.damage_min = 100
tt.bullet.damage_radius = 1
tt.bullet.flight_time_base = fts(25)
tt.bullet.flight_time_factor = fts(0.07142857142857142)
tt.bullet.pop = nil
tt.bullet.hit_payload = "hobgoblin_meteor_spawner"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.bullet.hit_fx = "fx_giant_boulder_explosion"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.render.sprites[1].name = "hero_giant_proy_0001"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.sound_events.hit = "HeroGiantExplosionRock"
tt = E.register_t(E, "ps_hobgoblin_meteor")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "dracolich_fireball_particle_1"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(16)
}
tt.particle_system.scale_var = {
	1.78,
	2.43
}
tt.particle_system.scales_x = {
	2,
	2.25
}
tt.particle_system.scales_y = {
	2,
	2.25
}
tt.particle_system.emission_rate = 20
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.alphas = {
	255,
	0
}
tt = RT("hobgoblin_bomb_spawner", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "bomb_hobgoblin_spawner"
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = "open"
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_tp_aura"
tt.spawner.keep_gold = true
tt.spawner.node_offset = 2
tt.spawner.pos_offset = v(0, 0)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = false
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
tt = RT("hobgoblin_meteor_spawner", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "enemy_cursed_golem_death"
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = "death"
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_cursed_golem"
tt.spawner.keep_gold = true
tt.spawner.node_offset = 2
tt.spawner.pos_offset = v(0, 0)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = false
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
tt = E.register_t(E, "aura_teleport_hobgoblin", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.2
tt.aura.duration = 20
tt.aura.mods = { "mod_teleport_hobgoblin"}
tt.aura.radius = 70
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.render.sprites[1].name = "hobgoblin_teleport"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
{
0,
vv(0)
},
{
0.5,
vv(1.25)
},
{
"this.aura.duration-0.5",
vv(1.25)
},
{
"this.aura.duration",
vv(0)
}
}
tt = E.register_t(E, "aura_curse_hobgoblin", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.2
tt.aura.duration = 1
tt.aura.mods = { "mod_curse_hobgoblin"}
tt.aura.radius = 9999
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_MOD)
tt.aura.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
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
tt = RT("mod_curse_hobgoblin", "modifier")

AC(tt, "render", "dps")

tt.explode_fx = "fx_unit_explode"
tt.modifier.duration = 5
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.modifier.excluded_templates = {
	"soldier_elemental",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_frankenstein",
	"soldier_ingvar_ancestor",
	"soldier_magnus_illusion",
	"soldier_gargoyle",
	"soldier_spectral_knight_pos",
	"soldier_skeleton_knight_pos",
	"soldier_skeleton_pos",
	"soldier_bone_golem",
	"soldier_flingers_skeleton",
	"soldier_flingers_skeleton_warrior",
	"soldier_death_rider",
	"soldier_mecha"
}
tt.nodes_limit = 0
tt.spawn_entity = "enemy_cursed_shard"
tt.render.sprites[1].name = "mod_dark_spitters"
tt.render.sprites[1].draw_order = 10
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dark_spitters.update
tt.dps.damage_every = 1
tt.dps.damage_max = 55
tt.dps.damage_min = 55
tt.dps.damage_type = DAMAGE_POISON
tt = RT("fx_teleport_hobgoblin", "fx")
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].prefix = "fx_teleport_hobgoblin"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt = RT("hobgoblin_spawner_aura", "aura")
tt.main_script.update = scripts.hobgoblin_spawner_aura.update
tt.aura.track_source = true
tt.spawn_data = {
	{
		{
			"enemy_hobgoblin_rider",
			8,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			20,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			20,
			0,
			3
		}
	},
	{
		{
			"enemy_hobgoblin_rider",
			8,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			15,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			15,
			0,
			3
		}
	},
	{
		{
			"enemy_hobgoblin_rider",
			6,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			15,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			15,
			0,
			3
		}
	},
	{
		{
			"enemy_hobgoblin_rider",
			6,
			5,
			2
		},
		{
			"enemy_goblin_spear",
			4,
			5,
			6
		},
		{
			"enemy_cursed_shaman",
			10,
			0,
			5
		},
		{
			"enemy_hobgoblin_small",
			4,
			5,
			1
		},
		{
			"enemy_hobgoblin_shield",
			10,
			0,
			3
		}
	}
}
tt = RT("hobgoblin_two_spawner_aura", "aura")
tt.main_script.update = scripts.hobgoblin_spawner_aura.update
tt.aura.track_source = true
tt.spawn_data = {
	{
		{
			"enemy_cursed_shard",
			8,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			10,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			8,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			10,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			20,
			0,
			6
		},
	},
	{
		{
			"enemy_cursed_shard",
			7,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			8,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			8,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			9,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			15,
			0,
			6
		},
	},
	{
		{
			"enemy_cursed_shard",
			5,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			7,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			13,
			0,
			6
		},
	},
	{
		{
			"enemy_cursed_shard",
			5,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			4,
			0,
			1
		},
		{
			"enemy_cursed_shard",
			4,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			2
		},
		{
			"enemy_cursed_shard",
			4,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			5,
			0,
			5
		},
		{
			"enemy_cursed_shard",
			6,
			0,
			5
		},
		{
			"enemy_goblin_balloon",
			10,
			0,
			6
		},
	},
}
tt = E.register_t(E, "mod_teleport_hobgoblin", "mod_teleport")
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.modifier.vis_bans = bor(F_BOSS)
tt.fx_end = "fx_teleport_hobgoblin"
tt.fx_start = "fx_teleport_hobgoblin"
tt.max_times_applied = 100
tt.nodes_offset = 20
tt.nodeslimit = 7
tt.delay_start = fts(2)
tt.hold_time = 0.34
tt.delay_end = fts(2)
tt = E.register_t(E, "viper_shuriken_goblirang", "bullet")
tt.main_script.update = scripts.viper_shuriken_goblirang.update
tt.bullet.particles_name = "ps_fireball_dracolich"
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 50
tt.bullet.max_speed = 240
tt.bullet.damage_every = 0.2
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.radius = 40
tt.bullet.mod = "mod_viper_poison"
tt.bullet.damage_min = 19
tt.bullet.damage_max = 27
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_bolt_necromancer_hit"
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bounces_max = nil
tt.bounce_range = 150
tt.render.sprites[1].prefix = "viper_shuriken"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.sound_events.insert = "AxeSound"
tt.sound_events.bounce = "HeroAlienDiscoBounce"
tt = E.register_t(E, "goblin_balloon_bomb", "bomb")
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 160
tt.bullet.damage_min = 100
tt.bullet.damage_radius = 67.5
tt.bullet.rotation_speed = 0
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.flight_time = fts(10)
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = {
	"pop_kboom"
}
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.render.sprites[1].name = "pirateTower_bomb"
tt.sound_events.insert = nil
tt.sound_events.hit = "BombExplosionSound"

tt = E.register_t(E, "goblin_platform_bomb", "bomb")
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 300
tt.bullet.damage_min = 200
tt.bullet.damage_radius = 2000
tt.bullet.rotation_speed = 0
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.flight_time = fts(10)
tt.bullet.hit_decal = "decal_atomic_bomb_crater"
tt.bullet.hit_fx = "fx_explosion_big"
tt.bullet.align_with_trajectory = true
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.platform_bomb.update
tt.render.sprites[1].name = "bombs_0003"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.sound_events.insert = nil
tt.sound_events.hit = "BombExplosionSound"

tt = RT("spear_goblin", "arrow")
tt.bullet.damage_min = 60
tt.bullet.damage_max = 80
tt.bullet.flight_time = fts(20)
tt.bullet.hit_distance = 9e+99
tt.bullet.miss_decal = "decal_spear_goblin"
tt.render.sprites[1].name = "spear_goblin"
tt.sound_events.insert = "AxeSound"
tt = RT("bolt_time_wizard", "bolt")
tt.bullet.damage_max = 102
tt.bullet.damage_min = 55
tt.bullet.hit_fx = "fx_bolt_sorcerer_hit"
tt.bullet.max_speed = 550
tt.bullet.mod = "mod_time_wizard_bolt_slow"
tt.bullet.particles_name = "ps_bolt_sorcerer"
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "bolt_time_wizard"
tt.sound_events.insert = "BoltSorcererSound"

tt = RT("fx_bolt_cursed_shaman_hit", "fx")
tt.render.sprites[1].name = "bolt_cursed_shaman_hit"

tt = RT("bolt_cursed_shaman", "bolt_enemy")
tt.bullet.align_with_trajectory = true
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_max = 70
tt.bullet.damage_min = 40
tt.bullet.hit_fx = "fx_bolt_cursed_shaman_hit"
tt.bullet.max_speed = 350
tt.render.sprites[1].prefix = "bolt_cursed_shaman"
tt.bullet.acceleration_factor = 0.1

tt = E.register_t(E, "aura_time_wizard_sandstorm", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.3
tt.aura.duration = 6
tt.aura.mods = { "mod_sandstorm_slow", "mod_sandstormtw" }
tt.aura.radius = 80
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.render.sprites[1].name = "decal_sandstormtw"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].scale = v(1.25, 1.25)
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
tt = E.register_t(E, "mod_sandstormtw", "modifier")

E.add_comps(E, tt, "dps", "render")
tt.dps.damage_min = 4
tt.dps.damage_max = 4
tt.dps.damage_inc = 2
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 0.3
tt.dps.kill = true
tt.modifier.allows_duplicates = true
tt.main_script.insert = scripts3.mod_dps.insert
tt.main_script.update = scripts3.mod_dps.update
tt.modifier.duration = 0.2
tt.render.sprites[1].prefix = "sandstormws"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].draw_order = 10
tt = RT("mod_teleport_ancient_guardian", "mod_teleport")
tt.delay_end = fts(6)
tt.delay_start = fts(1)
tt.fx_end = "fx_teleport_ancient_guardian"
tt.fx_start = "fx_teleport_ancient_guardian"
tt.max_times_applied = 3
tt.modifier.use_mod_offset = true
tt.modifier.vis_bans = bor(F_BOSS, F_FREEZE)
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.nodes_offset_min = -26
tt.nodes_offset_max = -17
tt.nodes_offset_inc = -5
tt = RT("mod_time_wizard_bolt_slow", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = 0.8
tt = RT("mod_sandstorm_slow", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = 0.5
tt = RT("mod_cursed_shield", "modifier")

AC(tt, "render")

tt.modifier.bans = {
	"mod_sorcerer_curse_dps",
	"mod_ranger_poison",
	"mod_sandstormtw",
	"mod_viper_poison",
	"mod_fiery_nut",
	"mod_pestilence",
	"mod_lava",
	"mod_blood_elves",
	"mod_blood",
	"mod_forest_eerie_dps",
	"mod_pixie_poison",
	"mod_slow_baby_ashbite",
	"mod_lava_furnace",
	"mod_honey_bees",
	"mod_pirate_burn",
	"mod_legion_burn"
}
tt.modifier.excluded_templates = {
"enemy_cursed_shaman"
}
tt.modifier.remove_banned = true
tt.modifier.duration = 1e+99
tt.modifier.vis_flags = bor(F_MOD)
tt.shield_ignore_hits = 1
tt.main_script.insert = scripts.mod_demon_shield.insert
tt.main_script.remove = scripts.mod_demon_shield.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "cursed_shield"
tt = E.register_t(E, "mod_cursed_shaman_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 150
tt.hps.heal_max = 150
tt.hps.heal_every = 9e+99
tt.modifier.excluded_templates = {
"enemy_cursed_shaman"
}
tt.render.sprites[1].prefix = "cursed"
tt.render.sprites[1].size_names = {
	"heal",
	"heal",
	"heal"
}
tt.render.sprites[1].name = "heal"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(24)
tt.modifier.allows_duplicates = true
tt = RT("mod_ancient_guardian", "modifier")

AC(tt, "render")

tt.increase = 1
tt.main_script.insert = scripts.mod_ancient_guard.insert
tt.main_script.remove = scripts.mod_ancient_guard.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = 2
tt.modifier.type = MOD_TYPE_RAGE
tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.use_mod_offset = false
tt.render.sprites[1].name = "mod_ancient_aura"
tt = E.register_t(E, "mod_viper_debuff_new", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].prefix = "viper"
tt.render.sprites[1].name = "curse"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.modifier.use_mod_offset = false
tt.modifier.duration = 10
tt.modifier.cycle = 0.2
tt.attack = E.clone_c(E, "bullet_attack")
tt.attack.max_range = 90
tt.attack.mod = "mod_viper_poison_curse"
tt.attack.damage_factor = {
	0.35,
	0.7,
	1
}
tt.ray_cooldown = fts(15)
tt.main_script.update = scripts.viper_debuff_new.update

tt = E.register_t(E, "ray_viper", "bullet")
tt.image_width = 42
tt.main_script.update = scripts3.ray_simple.update
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.hit_time = fts(5)
tt.bullet.mod = "mod_viper_poison_curse"
tt.bullet.track_damage = false
tt = RT("mod_viper_poison", "mod_poison")
tt.modifier.duration = 1 
tt.dps.damage_max = 5
tt.dps.damage_min = 5
tt.dps.damage_every = 0.2
tt.dps.kill = true
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.render.sprites[1].prefix = "viper"
tt.render.sprites[1].size_names = {
	"poison",
	"poison",
	"poison"
}
tt.render.sprites[1].name = "poison"
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)

tt = RT("mod_viper_poison_curse", "mod_poison")
tt.modifier.duration = 0.5
tt.dps.damage_max = 5
tt.dps.damage_min = 5
tt.dps.damage_every = 0.2
tt.dps.kill = true
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.render.sprites[1].prefix = "viper"
tt.render.sprites[1].size_names = {
	"poison",
	"poison",
	"poison"
}
tt.render.sprites[1].name = "poison"
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)
tt = E:register_t("decal_cg_ground_hit", "decal_timed")
tt.render.sprites[1].name = "cursed_golem_slam"
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_water_fall", "decal_loop")
tt.render.sprites[1].name = "decal_water_fall_idle"
tt = RT("decal_bush1_bl", "decal_loop")
tt.render.sprites[1].name = "decal_bush1_bl"
tt.render.sprites[1].offset = v(0, 40)
tt = RT("decal_bush2_bl", "decal_loop")
tt.render.sprites[1].name = "decal_bush2_bl"
tt.render.sprites[1].offset = v(0, 40)
tt = RT("decal_bush3_bl", "decal_loop")
tt.render.sprites[1].name = "decal_bush3_bl"
tt.render.sprites[1].offset = v(0, 40)
tt = RT("decal_bridge_bl", "decal")
tt.render.sprites[1].prefix = "decal_bridge_bl"
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "open"
tt.render.sprites[1].z = 1399
tt = RT("decal_spikewall_bl", "decal")
tt.render.sprites[1].name = "decal_spikewall_bl"
tt = RT("decal_cavewall_bl", "decal")
tt.render.sprites[1].name = "decal_cavewall_bl"
tt = RT("decal_trashcan_bl", "decal")
tt.render.sprites[1].name = "decal_trashcan_bl"
tt = RT("decal_tape_bl", "decal")
tt.render.sprites[1].name = "decal_tape_bl"
tt = RT("decal_mark_bl", "decal")
tt.render.sprites[1].name = "decal_mark_bl"
tt = RT("decal_dwarf_bl", "decal")
tt.render.sprites[1].name = "decal_dwarf_bl"
tt = RT("decal_knight_bl", "decal")
tt.render.sprites[1].name = "decal_knight_bl"
tt = E:register_t("button_steal_goblin_gold")

E:add_comps(tt, "pos", "main_script", "ui")

tt.main_script.update = scripts.button_steal_bag_gold.update
tt.ui.can_click = true
tt.ui.click_rect = r(0, 0, 20, 20)
tt.gold_to_steal = 10000000
tt.fx = "fx_coin_jump"
tt.delay = fts(15)
tt.gold = 1

tt = E:register_t("button_steal_goblin_gold_iron")

E:add_comps(tt, "pos", "main_script", "ui")

tt.main_script.update = scripts.button_steal_bag_gold_iron.update
tt.ui.can_click = true
tt.ui.click_rect = r(0, 0, 20, 20)
tt.gold_to_steal = 10000000
tt.fx = "fx_coin_jump"
tt.delay = 10
tt.gold = 0
tt.gold_inc = 5
tt.gold_inc_boosted = 10
tt.gold_every = fts(30)
tt.duration = 3

tt = RT("decal_gold_bag_iron_count", "decal_tween")

AC(tt, "texts")

tt.render.sprites[1].hidden = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[2].offset = v(0, -9)
tt.texts.list[1].text = "Hello world"
tt.texts.list[1].size = v(152, 62)
tt.texts.list[1].font_name = "TOONISH"
tt.texts.list[1].font_size = 20
tt.texts.list[1].color = {
	255,
	200,
	114
}
tt.texts.list[1].line_height = 0.8
tt.texts.list[1].sprite_id = 2
tt.texts.list[1].fit_height = true
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1.26, 1.26)
	},
	{
		0.4,
		v(1.24, 1.24)
	},
	{
		0.8,
		v(1.26, 1.26)
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].loop = true
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		1,
		255
	}
}
tt.tween.props[3].sprite_id = 1
tt.tween.props[4] = table.deepclone(tt.tween.props[3])
tt.tween.props[4].sprite_id = 2
tt.tween.remove = false

tt = RT("decal_goldbag_bl", "decal")
tt.render.sprites[1].prefix = "decal_goldbag_bl"
tt.render.sprites[1].loop = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = 2001
tt = RT("decal_spark_bl", "decal")
tt.render.sprites[1].name = "stun_small_loop"

tt = E.register_t(E, "time_wizard_sandstorm", "rock_entwood")
tt.bullet.flight_time = fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_max_inc = 0
tt.bullet.damage_min = 0
tt.bullet.damage_min_inc = tt.bullet.damage_max_inc
tt.bullet.damage_radius = 75
tt.bullet.hit_payload = "aura_time_wizard_sandstorm"
tt.bullet.hit_fx = "fx_fiery_nut_explosion"
tt.bullet.hit_decal = nil
tt.render.sprites[1].name = "time_wizard_sandstorm_proj"
tt.sound_events.hit = "TowerEntwoodFieryExplote"

--从这里开始应该是新塔了
tt = E.register_t(E, "tower_hammerhold", "tower")

E.add_comps(E, tt, "attacks", "powers")

image_y = 90
tt.info.enc_icon = 68
tt.tower.type = "archer_hammerhold"
tt.tower.level = 1
tt.tower.price = 240
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 165
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "arrow_hammerhold"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].bullet_start_offset = {
		v(0, -9),
		v(0, -9)
}
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].animation = "shoot"
tt.attacks.list[2].bullet = "arrow_hammerhold_split"
tt.attacks.list[2].cooldown = 10
tt.attacks.list[2].shoot_time = 0.3
tt.attacks.list[2].bullet_start_offset = {
		v(0, -9),
		v(0, -9)
}
tt.attacks.list[2].min_targets = 2
tt.attacks.list[2].extra_arrows_range = 100
tt.attacks.list[2].vis_flags = bor(F_RANGED)
tt.attacks.list[2].shot_fx = nil
tt.attacks.list[2].sound = nil
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].animation = "shoot"
tt.attacks.list[3].cooldown = 5
tt.attacks.list[3].range = 165
tt.attacks.list[3].bullet = "flare_legion"
tt.attacks.list[3].bullet_start_offset = {
		v(0, -9),
		v(0, -9)
}
tt.attacks.list[3].shoot_time = fts(8)
tt.attacks.list[3].sound = nil
tt.attacks.list[3].sound_args = {
	delay = fts(8)
}
tt.attacks.list[3].excluded_templates = {
	"enemy_demon_flareon"
}
tt.attacks.list[3].vis_flags = bor(F_RANGED, F_BURN)
tt.attacks.list[3].vis_bans = bor(F_BOSS)
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0019"
tt.info.fn = scripts2.tower_hammerhold.get_info
tt.powers.split = E.clone_c(E, "power")
tt.powers.split.attack_idx = 2
tt.powers.split.price_base = 300
tt.powers.split.price_inc = 200
tt.powers.split.enc_icon = 123
tt.powers.split.extra_arrows = {
	3,
	4,
	5
}
tt.powers.flare = E.clone_c(E, "power")
tt.powers.flare.attack_idx = 3
tt.powers.flare.price_base = 250
tt.powers.flare.price_inc = 150
tt.powers.flare.max_level = 2
tt.powers.flare.enc_icon = 122
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_%04i"
tt.render.sprites[1].disabled = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "city_tower"
tt.render.sprites[2].offset = v(0, 28)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooterarcherhammerhold"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	shoot_long = {
		"shootingUp",
		"shootingDown"
	},
}
tt.render.sprites[3].offset = v(0, 59)
tt.main_script.update = scripts2.tower_hammerhold.update
tt.main_script.remove = scripts2.tower_hammerhold.remove
tt.sound_events.insert = "LegionnaireTaunt"

tt = E.register_t(E, "arrow_hammerhold", "arrow")
tt.bullet.damage_min = 34
tt.bullet.damage_max = 46
tt.bullet.reset_to_target_pos = true

tt = E.register_t(E, "ps_flare_legion", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.emission_rate = 40
tt.particle_system.emit_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "legion_archer_flareShotParticle"
tt.particle_system.particle_lifetime = {
	0.35,
	0.7
}
tt.particle_system.scale_same_aspect = true
tt.particle_system.scale_var = {
	0.6,
	0.8
}
tt.particle_system.scales_x = {
	0.8,
	1.6
}
tt.particle_system.scales_y = {
	0.8,
	1.6
}
tt.particle_system.emit_rotation_spread = math.pi

tt = E.register_t(E, "arrow_hammerhold_split", "arrow")
tt.bullet.damage_min = 40
tt.bullet.damage_max = 40
tt.bullet.damage_inc = 20
tt.bullet.flight_time = 0.3
tt.bullet.prediction_error = false
tt.main_script.insert = scripts2.arrow_split.insert
tt.extra_arrows_range = 110
tt.extra_arrows = 4
tt.bullet.particles_name = "ps_bolt_infernal_mage"
tt.sound_events.insert = "TowerGoldenBowFlareHit"
tt.bullet.reset_to_target_pos = true

tt = E.register_t(E, "fx_explosion_legion_flare", "fx")
tt.render.sprites[1].name = "explosion_flare_hammerhold"
tt.render.sprites[1].anchor = v(0.5, 0.25)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2

tt = RT("flare_legion", "arrow")
tt.bullet.damage_max = 46
tt.bullet.damage_min = 34
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.flight_time = fts(16)
tt.bullet.hit_blood_fx = nil
tt.bullet.miss_decal = nil
tt.bullet.hit_fx = "fx_explosion_legion_flare"
tt.bullet.miss_fx = "fx_explosion_legion_flare"
tt.bullet.mod = "mod_legion_burn"
tt.bullet.particles_name = "ps_flare_legion"
tt.bullet.pop = nil
tt.render.sprites[1].name = "legion_archer_flare"
tt.render.sprites[1].animated = true
tt.sound_events.insert = "LegionArcherFlareShot"
tt.bullet.reset_to_target_pos = true

tt = RT("mod_legion_burn", "mod_lava")
tt.dps.damage_flat = {
	2,
	3
}
tt.dps.damage_percent = 0.004
tt.dps.damage_every = 0.2
tt.modifier.allows_duplicates = true
tt.dps.damage_type = DAMAGE_TRUE
tt.health_cap = {
	0.6,
	0.4
}
tt.main_script.update = scripts2.mod_legion_burn.update
tt.modifier.duration = 10
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.modifier.vis_bans = bor(F_BOSS)

tt = E.register_t(E, "fx_arrow_shadow_shot", "fx")
tt.render.sprites[1].name = "arrow_shadow_smoke"

tt = E.register_t(E, "tower_shadow_archer", "tower")

E.add_comps(E, tt, "attacks", "powers")

image_y = 90
tt.info.enc_icon = 18
tt.tower.type = "shadow_archer"
tt.tower.level = 1
tt.tower.price = 260
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 200
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "arrow_shadow_tower"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = 0.2
tt.attacks.list[1].bullet_start_offset = {
		v(9, 4),
		v(6, -5)
}
tt.attacks.list[1].shot_fx = "fx_arrow_shadow_shot"
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].animation = "sentence"
tt.attacks.list[2].bullet = "arrow_blade_demise"
tt.attacks.list[2].chance = 0
tt.attacks.list[2].cooldowns = {
	40,
	30,
	24
}
tt.attacks.list[2].shoot_time = 0.3
tt.attacks.list[2].bullet_start_offset = {
		v(9, 4),
		v(6, -5)
}
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_INSTAKILL)
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_FLYING)
tt.attacks.list[2].shot_fx = nil
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
tt.info.portrait = ((IS_PHONE and "krv_portraits_0001") or "krv_portraits_0001")
tt.info.fn = scripts4.tower_shadow_archer.get_info
tt.powers.blade = E.clone_c(E, "power")
tt.powers.blade.attack_idx = 2
tt.powers.blade.price_base = 300
tt.powers.blade.price_inc = 100
tt.powers.blade.enc_icon = 67
tt.powers.mark = E.clone_c(E, "power")
tt.powers.mark.attack_idx = 3
tt.powers.mark.price_base = 120
tt.powers.mark.price_inc = 120
tt.powers.mark.enc_icon = 66
tt.powers.crow = E.clone_c(E, "power")
tt.powers.crow.price_base = 200
tt.powers.crow.price_inc = 200
tt.powers.crow.max_level = 2
tt.powers.crow.enc_icon = 68
tt.powers.crow.damage_min = 4
tt.powers.crow.damage_max = 4
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_ranger_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_shadow_archer_base_0001"
tt.render.sprites[2].offset = v(0, 28)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_shadow_archer_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootShortUp",
		"shootShortDown"
	},
	mark = {
		"shootSpecialShortUp",
		"shootSpecialShortDown"
	},
	sentence = {
		"instakillUp",
		"instakillDown"
	}
}
tt.render.sprites[3].offset = v(-5, 57)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].animated = false
tt.render.sprites[4].name = "soldier_gargoyle_0045"
tt.render.sprites[4].offset = v(32, 43)
tt.render.sprites[4].disabled = true
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
tt.custom_attack.cooldown = 0.5
tt.custom_attack.damage_type = DAMAGE_PHYSICAL
tt.custom_attack.vis_flags = F_RANGED
tt.custom_attack.vis_bans = 0
tt.custom_attack.sound_chance = 0.3
tt.custom_attack.sound = "ShadowArcherCrowAttack"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "shadow_crow"
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

tt = RT("tower_infernal_mage", "tower_mage_1")

AC(tt, "attacks", "powers")

image_y = 90
tt.tower.type = "infernal_mage"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 15
tt.info.i18n_key = "INFERNAL_MAGE"
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0003") or "krv_portraits_0003"
tt.powers.fissure = CC("power")
tt.powers.fissure.price_base = 200
tt.powers.fissure.price_inc = 200
tt.powers.fissure.cooldown_base = 20
tt.powers.fissure.cooldown_inc = 0
tt.powers.fissure.enc_icon = 73
tt.powers.fissure.name = "FISSURE"
tt.powers.teleport = CC("power")
tt.powers.teleport.price_base = 220
tt.powers.teleport.price_inc = 220
tt.powers.teleport.max_count = {
	4,
	6
}
tt.powers.teleport.enc_icon = 74
tt.powers.teleport.max_level = 2
tt.powers.curse = CC("power")
tt.powers.curse.max_level = 2
tt.powers.curse.price_base = 120 
tt.powers.curse.price_inc = 120
tt.powers.curse.enc_icon = 72
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_infernal_mage"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 35)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_infernal_mage_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	spell = {
		"spellUp",
		"spellDown"
	}
}
tt.render.sprites[3].offset = v(0, 56)
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
tt.main_script.update = scripts4.infernal_mage.update
tt.sound_events.insert = "InfernalMageTaunt"
tt.attacks.range = 175
tt.attacks.min_cooldown = 1.8
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_infernal_mage"
tt.attacks.list[1].cooldown = 1.8
tt.attacks.list[1].node_prediction = fts(5)
tt.attacks.list[1].shoot_time = fts(15)
tt.attacks.list[1].bullet_start_offset = v(-5, 68)
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].bullet = "fissure_infernal_mage"
tt.attacks.list[2].sound = "InfernalMageFissure"
tt.attacks.list[2].shoot_time = fts(8)
tt.attacks.list[2].cooldown = 20
tt.attacks.list[2].vis_flags = bor(F_RANGED)
tt.attacks.list[2].vis_bans = bor(F_FLYING)
tt.attacks.list[2].animation = "spell"
tt.attacks.list[2].loops = 8
tt.attacks.list[2].bullet_start_offset = v(-5, 68)
tt.attacks.list[2].min_spread = 40
tt.attacks.list[2].max_spread = 40
tt.attacks.list[2].range = 150
tt.attacks.list[3] = CC("aura_attack")
tt.attacks.list[3].animation = "shoot"
tt.attacks.list[3].shoot_time = fts(15)
tt.attacks.list[3].cooldown = 22
tt.attacks.list[3].range = 125
tt.attacks.list[3].aura = "aura_teleport_infernal"
tt.attacks.list[3].min_nodes = 15
tt.attacks.list[3].node_prediction = fts(4)
tt.attacks.list[3].vis_flags = bor(F_RANGED, F_MOD, F_TELEPORT)
tt.attacks.list[3].vis_bans = bor(F_BOSS, F_FREEZE)
tt.attacks.list[4] = CC("aura_attack")
tt.attacks.list[4].animation = "spell"
tt.attacks.list[4].shoot_time = fts(8)
tt.attacks.list[4].cooldown = 12
tt.attacks.list[4].range = 150
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
tt.render.sprites[1].name = "decal_infernal_teleport"
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
tt.render.sprites[1].name = "decal_infernal_curse"
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
tt.render.sprites[1].prefix = "infernal_curse_debuff"
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "small"

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
tt.render.sprites[1].prefix = "infernal_curse_debuff"
tt.render.sprites[1].loop = true
tt.render.sprites[1].animated = true
tt.render.sprites[1].name = "small"

tt = RT("fx_teleport_infernal", "fx")
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].prefix = "fx_teleport_arcane"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
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
tt.nodes_offset_min = -21
tt.nodes_offset_max = -21
tt.nodes_offset_inc = 0

tt = RT("ps_bolt_infernal_mage", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 60
tt.particle_system.name = "infernal_mage_bolt_particle"
tt.particle_system.particle_lifetime = {
	fts(7),
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
tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.render.sprites[1].name = "explosion"

tt = RT("bolt_infernal_mage", "bolt")
tt.bullet.damage_max = 134
tt.bullet.damage_min = 78
tt.bullet.hit_fx = "fx_bolt_infernal_mage_hit"
tt.bullet.max_speed = 300
tt.bullet.pop = nil
tt.bullet.particles_name = "ps_bolt_infernal_mage"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.sound_events.insert = "InfernalMageAttack"

tt = RT("tower_rocket_riders", "tower")

AC(tt, "attacks", "powers")

image_y = 120
tt.tower.type = "rocket_riders"
tt.tower.level = 1
tt.tower.price = 320
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 16
tt.info.i18n_key = "TOWER_ROCKET_RIDERS"
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0004") or "krv_portraits_0004"
tt.powers.mine = CC("power")
tt.powers.mine.price_base = 225
tt.powers.mine.price_inc = 225
tt.powers.mine.range_inc_factor = 0
tt.powers.mine.enc_icon = 75
tt.powers.mine.entity = "rr_mine_box"
tt.powers.engine = CC("power")
tt.powers.engine.max_level = 2
tt.powers.engine.price_base = 150
tt.powers.engine.price_inc = 150
tt.powers.engine.fragment_count = {
5,
7
}
tt.powers.engine.enc_icon = 77
tt.powers.engine.fragment_node_spread = {
7,
5
}
tt.powers.nitro = CC("power")
tt.powers.nitro.max_level = 2
tt.powers.nitro.price_base = 150
tt.powers.nitro.price_inc = 150
tt.powers.nitro.enc_icon = 76
tt.powers.nitro.damage_inc = {
100,
180
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_bfg_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_rocket_riders"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 51)
tt.main_script.remove = scripts4.tower_rocket_riders.remove
tt.main_script.update = scripts4.tower_rocket_riders.update
tt.main_script.insert = scripts4.tower_rocket_riders.insert
tt.sound_events.insert = "RocketRidersTaunt"
tt.attacks.min_cooldown = 2.8
tt.attacks.range = 200
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bomb_rr"
tt.attacks.list[1].bullet_start_offset = v(-10, 74)
tt.attacks.list[1].cooldown = 2.8
tt.attacks.list[1].node_prediction = fts(21)
tt.attacks.list[1].range = 200
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].animation = "mine"
tt.attacks.list[2].bullet = "bomb_rr_mine_intial"
tt.attacks.list[2].bullet_start_offset = v(-30, 24)
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
tt.attacks.list[3].cooldown = 20
tt.attacks.list[3].range = 150
tt.attacks.list[3].node_prediction = fts(40)
tt.attacks.list[4] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[4].bullet = "bomb_rr_nitro"
tt.attacks.list[4].cooldown = 12
tt.attacks.list[4].range = 250
tt.attacks.list[4].animation = "nitro"

tt = E.register_t(E, "rr_mine_box", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.render.sprites[1].loop = false
tt.render.sprites[1].draw_order = 3
tt.render.sprites[1].prefix = "rocket_riders_mine_box"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].offset = v(-26, 13)
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "mine"
tt.attacks.list[1].bullet = "bomb_rr_mine_intial"
tt.attacks.list[1].bullet_start_offset = v(-30, 24)
tt.attacks.list[1].cooldown = 8
tt.attacks.list[1].shoot_time = fts(26)
tt.main_script.update = scripts4.mine_box.update

tt = RT("fx_explosion_engine_air", "fx")
tt.render.sprites[1].prefix = "rocket_riders"
tt.render.sprites[1].name = "engine"

tt = RT("fx_explosion_nitro", "fx")
tt.render.sprites[1].prefix = "explosion"
tt.render.sprites[1].name = "big"
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
tt.particle_system.name = "rocket_riders_particle"
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
tt.particle_system.name = "rocket_riders_nitro_particle"
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

tt = RT("bomb_rr", "bomb")
tt.bullet.damage_max = 104
tt.bullet.damage_min = 74
tt.bullet.damage_radius = 45
tt.bullet.flight_time = fts(25)
tt.main_script.update = scripts3.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.render.sprites[1].name = "rocket_riders_proj"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.sound_events.hit_water = nil
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "RocketRidersAttack"
tt.bullet.particles_name = "ps_rocket_riders_rocket"

tt = RT("bomb_rr_nitro", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 50
tt.bullet.flight_time = fts(35)
tt.main_script.update = scripts3.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_nitro"
tt.render.sprites[1].name = "rocket_riders_proj_nitro"
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
tt.bullet.damage_radius = 55
tt.bullet.flight_time = 0
tt.bullet.pop = nil
tt.bullet.hit_payload = "decal_rr_mine"
tt.main_script.insert = scripts.bomb.insert
tt.main_script.update = scripts4.mine_rr.update
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.hide_radius = nil
tt.render.sprites[1].name = "rocket_riders_mine_0001"
tt.render.sprites[1].animated = false
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
tt.render.sprites[1].name = "decal_rr_mine"
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
tt.render.sprites[1].name = "rocket_riders_mine_0001"
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
tt.render.sprites[1].name = "rocket_riders_proj"
tt.sound_events.hit = "RocketRidersEngine"
tt.sound_events.insert = "RocketRidersAttack"

tt = RT("bomb_rr_fragment", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 70
tt.bullet.flight_time = fts(10)
tt.bullet.hide_radius = 2
tt.main_script.update = scripts3.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = nil
tt.render.sprites[1].name = "rocket_riders_fragment_0001"
tt.sound_events.hit_water = nil
tt.sound_events.insert = nil
tt.bullet.particles_name = "ps_missile"

tt = E.register_t(E, "tower_melting_furnace", "tower")

E.add_comps(E, tt, "attacks", "powers")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "krv_portraits_0006") or "krv_portraits_0006")
tt.info.enc_icon = 1
tt.tower.type = "melting_furnace"
tt.tower.price = 300
tt.powers.coal = E.clone_c(E, "power")
tt.powers.coal.price_base = 140
tt.powers.coal.price_inc = 140
tt.powers.coal.enc_icon = 87
tt.powers.coal.fragment_count_base = 1
tt.powers.coal.fragment_count_inc = 2
tt.powers.coal.max_level = 2
tt.powers.fuel = E.clone_c(E, "power")
tt.powers.fuel.price_base = 250
tt.powers.fuel.price_inc = 050
tt.powers.fuel.name = "FUEL"
tt.powers.fuel.enc_icon = 89
tt.powers.fuel.max_level = 1
tt.powers.heat = E.clone_c(E, "power")
tt.powers.heat.price_base = 200
tt.powers.heat.price_inc = 200
tt.powers.heat.name = "HEAT"
tt.powers.heat.enc_icon = 88
tt.powers.heat.max_level = 2
tt.main_script.remove = scripts4.tower_melting_furnace.remove
tt.main_script.insert = scripts4.tower_melting_furnace.insert
tt.main_script.update = scripts4.tower_melting_furnace.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_tesla_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].hidden = true
tt.render.sprites[2].offset = v(0, 40)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_dark_forge"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 40)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].hidden = true
tt.render.sprites[4].loop = true
tt.render.sprites[4].offset = v(1, 76)
tt.render.sprites[4].hidden = true
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].hidden = true
tt.render.sprites[5].loop = true
tt.render.sprites[5].offset = (IS_PHONE_OR_TABLET and v(0, 40)) or v(-3, 40)
tt.render.sprites[5].hidden = true
tt.attacks.range = 160
tt.idle_anim = "idle"
tt.attacks.list[1] = E.clone_c(E, "area_attack")
tt.attacks.list[1].vis_flags = F_RANGED
tt.attacks.list[1].vis_bans = F_FLYING
tt.attacks.list[1].damage_flags = F_AREA
tt.attacks.list[1].damage_type = DAMAGE_PHYSICAL
tt.attacks.list[1].damage_bans = F_FLYING
tt.attacks.list[1].reduce_armor = 0.75
tt.attacks.list[1].cooldown = 4
tt.attacks.list[1].hit_time = 1.83
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].mod = "mod_furnace_stun"
tt.attacks.list[1].damage_min = 44
tt.attacks.list[1].damage_max = 52
tt.attacks.list[1].sound = "MeltingFurnaceAttack"
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].bullet = "lava"
tt.attacks.list[2].cooldown = 30
tt.attacks.list[2].hit_time = 1.3
tt.attacks.list[2].sound = "EarthquakeLavaSmash"
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].vis_flags = bit.bor(F_AREA)
tt.attacks.list[3].vis_bans = bit.bor(F_FLYING, F_CLIFF)
tt.attacks.list[3].sound = "MeltingFurnaceHotCoal"
tt.attacks.list[3].bullet = "furnace_coal_initial"
tt.attacks.list[3].bullet_start_offset = v(0, 64)
tt.attacks.list[3].range = 160
tt.attacks.list[3].cooldown = 15
tt.attacks.list[3].shoot_time = 0
tt.attacks.list[3].hit_time = 1.73
tt.attacks.list[3].node_prediction = 0.9
tt.attacks.list[4] = E.clone_c(E, "mod_attack")
tt.attacks.list[4].mod = "mod_furnace_buff"
tt.attacks.list[4].cooldown = 0.5
tt.attacks.list[4].fly_cooldown = 10
tt.attacks.list[4].range = 265
tt.attacks.list[4].range_inc = 0
tt.attacks.list[4].offrange = 20
tt.attacks.list[4].excluded_templates = {
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
tt.attacks.list[5] = E.clone_c(E, "mod_attack")
tt.attacks.list[5].mod = "mod_furnace_fuel"
tt.attacks.list[5].cooldown = 30
tt.attacks.list[5].fly_cooldown = 10
tt.attacks.list[5].range = 20
tt.attacks.list[5].range_inc = 0
tt.attacks.list[5].excluded_templates = {}
tt.sound_events.insert = "MeltingFurnaceTaunt"

tt = E.register_t(E, "mod_furnace_fuel", "modifier")

E.add_comps(E, tt, "render")
tt.modifier.duration = 10
tt.cooldown = 2
tt.damage_min = 41
tt.damage_max = 50
tt.main_script.update = scripts4.mod_furnace_fuel.update
tt.main_script.remove = scripts4.mod_furnace_fuel.remove
tt.render.sprites[1].name = "dark_forge_fuel"
tt.render.sprites[1].animated = true
tt.render.sprites[1].offset = v(0, 40)
tt.render.sprites[1].draw_order = 5

tt = E.register_t(E, "mod_furnace_buff", "modifier")

E.add_comps(E, tt, "render")

tt.extra_damage = 0.15
tt.main_script.insert = scripts4.mod_furnace_buff.insert
tt.main_script.remove = scripts4.mod_furnace_buff.remove
tt.render.sprites[1].name = "dark_forge_sword_decal"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.21
tt.render.sprites[1].draw_order = 5

tt = RT("furnace_coal_initial", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = 0
tt.bullet.fragment_count = 3
tt.bullet.fragment_name = "furnace_coal"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = nil
tt.bullet.rotation_speed = (FPS*20*math.pi)/180
tt.bullet.fragment_node_spread = 7
tt.bullet.fragment_pos_spread = v(6, 6)
tt.bullet.dest_pos_offset = v(0, 110)
tt.bullet.dest_prediction_time = 1
tt.bullet.align_with_trajectory = false
tt.bullet.particles_name = "ps_rocket_riders_rocket"
tt.bullet.damage_inc = {
0,
0
}
tt.main_script.insert = scripts4.furnace_coal.insert
tt.main_script.update = scripts4.furnace_coal.update
tt.render.sprites[1].animated = nil
tt.render.sprites[1].loop = nil
tt.render.sprites[1].hidden = true
tt.sound_events.hit = nil
tt.sound_events.insert = nil

tt = RT("furnace_coal", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 70
tt.bullet.flight_time = 0.7
tt.bullet.hide_radius = 2
tt.bullet.hit_payload = "lava_furnace"
tt.main_script.update = scripts3.bomb_kro.update
tt.bullet.hit_fx = nil
tt.bullet.pop = nil
tt.render.sprites[1].name = "dark_forge_coal_0001"
tt.sound_events.hit_water = nil
tt.sound_events.insert = nil
tt.bullet.particles_name = nil

tt = E.register_t(E, "lava_furnace", "aura")

E.add_comps(E, tt, "aura", "render", "tween")

tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
  {
    0,
    0
  },
  {
    0.1,
    255
  },
  {
    3,
    255
  },
  {
    3.6,
    0
  }
}
tt.aura.mod = "mod_lava_furnace"
tt.aura.duration = 6
tt.aura.cycle_time = 0.2
tt.aura.radius = 37
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD, F_LAVA)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "furnace_fuel_decal_0001"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].ts = 5.5

tt = E.register_t(E, "mod_lava_furnace", "modifier")

E.add_comps(E, tt, "dps", "render")

tt.modifier.duration = 0.3
tt.dps.damage_min = 2
tt.dps.damage_max = 2
tt.dps.damage_inc = 3
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 0.2
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].hidden = true
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update

tt = RT("mod_furnace_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 0.6
tt.modifier.vis_bans = F_BOSS
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].hidden = true

tt = E.register_t(E, "tower_spectres_mausoleum", "tower")

E.add_comps(E, tt, "attacks", "powers", "barrack")

tt.tower.type = "spectres_mausoleum"
tt.tower.level = 1
tt.tower.price = 230
tt.barrack.soldier_type = "soldier_gargoyle"
tt.barrack.rally_range = 145
tt.barrack.max_soldiers = 0
tt.info.fn = scripts.tower_mage.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "krv_portraits_0010") or "krv_portraits_0010")
tt.info.enc_icon = 16
tt.powers.spectral = E.clone_c(E, "power")
tt.powers.spectral.price_base = 150
tt.powers.spectral.price_inc = 100
tt.powers.spectral.enc_icon = 85
tt.powers.spectral.max_level = 2
tt.powers.spectral.max_bullets = {
4,
5
}
tt.powers.garg = E.clone_c(E, "power")
tt.powers.garg.price_base = 250
tt.powers.garg.price_inc = 250
tt.powers.garg.enc_icon = 84
tt.powers.garg.max_level = 2
tt.powers.poss = E.clone_c(E, "power")
tt.powers.poss.price_base = 200
tt.powers.poss.price_inc = 100
tt.powers.poss.name = "POSS"
tt.powers.poss.enc_icon = 86
tt.main_script.insert = scripts4.tower_spectres_mausoleum.insert
tt.main_script.remove = scripts4.tower_spectres_mausoleum.remove
tt.main_script.update = scripts4.tower_spectres_mausoleum.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_spectres_mausoleum_0001"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[2].loop = false
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_spectres_mausoleum"
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "idle2"
tt.render.sprites[3].angles = {
  idle = {
    "idle2",
    "idle2"
  },
  shoot = {
    "shoot",
    "shoot"
  },
  twister = {
    "possession",
    "possession"
  },
  multiple = {
    "possession",
    "possession"
  }
}
tt.render.sprites[3].offset = v(2, 61)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].disabled = false
tt.render.sprites[4].animated = false
tt.render.sprites[4].loop = false
tt.render.sprites[4].name = "tower_spectres_mausoleum_gargoyles_0001"
tt.render.sprites[4].offset = v(4, 6)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].animated = false
tt.render.sprites[5].disabled = false
tt.render.sprites[5].loop = false
tt.render.sprites[5].name = "tower_spectres_mausoleum_gargoyles_0002"
tt.render.sprites[5].offset = v(37, 14)
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].prefix = "tower_spectres_mausoleum"
tt.render.sprites[6].loop = false
tt.render.sprites[6].name = "idle2"
tt.render.sprites[6].angles = {
  idle = {
    "idle2",
    "idle2"
  },
  shoot = {
    "shoot",
    "shoot"
  },
  twister = {
    "possession",
    "possession"
  },
  multiple = {
    "possession",
    "possession"
  }
}
tt.render.sprites[6].offset = v(30, 14)
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].prefix = "spectres_mausoleum_glow"
tt.render.sprites[7].loop = false
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].angles = {
  idle = {
    "idle",
    "idle"
  },
  shoot = {
    "shoot",
    "shoot"
  },
  twister = {
    "idle",
    "idle"
  },
  multiple = {
    "idle",
    "idle"
  }
}
tt.render.sprites[7].offset = v(-3, 56)
tt.attacks.range = 175
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet_start_offset = {
  v(15, 72),
  v(15, 72)
}
tt.attacks.list[1].bullet = "bolt_spectres"
tt.attacks.list[1].cooldown = 1.45
tt.attacks.list[1].shoot_time = 0.887
tt.attacks.list[1].max_stored_bullets = 3
tt.attacks.list[1].sound = "SpectresMausoleumAttackPreload"
tt.attacks.list[1].storage_offsets = {
  v(3, 71),
  v(-20, 48),
  v(18, 46),
  v(-35, 69),
  v(38, 54)
}
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].animation = "twister"
tt.attacks.list[2].bullet_start_offset = {
  v(30, 14),
  v(30, 14)
}
tt.attacks.list[2].bullet = "bolt_possession"
tt.attacks.list[2].cooldown = 26
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_FLYING)
tt.attacks.list[2].cooldown_inc = -3
tt.attacks.list[2].shoot_time = 0.6
tt.attacks.list[2].range = 150
tt.attacks.list[2].sound = "SpectresMausoleumAttackPreload"
tt.attacks.list[2].wait_time = 1.5
tt.sound_events.insert = "SpectresMausoleumTaunt"
tt.sound_events.change_rally_point = "SpectresMausoleumGargTaunt"

tt = E.register_t(E, "fx_spectres_possession_hit", "fx")
tt.render.sprites[1].name = "spectres_possession_decal"

tt = E.register_t(E, "bolt_possession", "bolt")
tt.main_script.update = scripts4.bolt_poss.update
tt.render.sprites[1].prefix = "spectres_possession_proy"
tt.render.sprites[1].scale = v(-1, 1)
tt.bullet.max_speed = 100
tt.bullet.acceleration_factor = 0.1
tt.bullet.mod = "mod_possession"
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.hit_fx = "fx_spectres_possession_hit"
tt.bullet.pop = {
  "pop_zapow"
}
tt.bullet.store = nil
tt.bullet.store_sort_y_offset = -65
tt.bullet.particles_name = "ps_spectres_trail"
tt.bullet.ignore_rotation = true
tt.sound_events.travel = "SpectresMausoleumPossession"
tt.sound_events.summon = nil
tt.sound_events.insert = nil

tt = E:register_t("soldier_possessed", "unit")

E:add_comps(tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events", "nav_rally", "ranged", "dodge", "timed_attacks", "auras", "death_spawns")

anchor_y = 0.2
image_y = 36
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0011") or "krv_portraits_0011"
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_empty_nuhuh"
tt.death_spawns.delay = 0.11
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_empty_nil"
tt.health.armor = 0
tt.health.hp_inc = 40
tt.health.hp_max = 20
tt.health_bar.offset = v(0, ady(39))
tt.dodge.chance = 0
tt.dodge.silent = true
tt.info.fn = scripts4.soldier_possessed.get_info
tt.info.i18n_key = "SOLDIER_GARGOYLE"
tt.lifespan.duration = nil
tt.main_script.insert = scripts4.soldier_possessed.insert
tt.main_script.update = scripts4.soldier_possessed.update
tt.melee.attacks[1].cooldown = 900000
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[2] = CC("area_attack")
tt.melee.attacks[2].cooldown = 900000
tt.melee.attacks[2].count = 9e+99
tt.melee.attacks[2].damage_inc = 150
tt.melee.attacks[2].damage_max = 200
tt.melee.attacks[2].damage_min = 150
tt.melee.attacks[2].damage_radius = 66.6
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[2].hit_decal = "decal_ground_hit"
tt.melee.attacks[2].hit_fx = "fx_ground_hit"
tt.melee.attacks[2].hit_offset = v(35, 0)
tt.melee.attacks[2].hit_time = fts(14)
tt.melee.attacks[2].mod = nil
tt.melee.attacks[2].sound = "KRVGenericCombat"
tt.melee.range = 64
tt.ranged.attacks[1].bullet = "ray_high_elven_sentinel"
tt.ranged.attacks[1].shoot_time = fts(9)
tt.ranged.attacks[1].cooldown = 9999999
tt.ranged.attacks[1].max_range = 300
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet_start_offset = v(0, 0)
tt.ranged.attacks[1].vis_flags = F_RANGED
tt.ranged.attacks[1].vis_bans = 0
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].cooldown = 9000000
tt.timed_attacks.list[1].damage_max = 0
tt.timed_attacks.list[1].damage_min = 0
tt.timed_attacks.list[1].damage_type = DAMAGE_NONE
tt.timed_attacks.list[1].max_range = 0
tt.timed_attacks.list[1].hits = 0
tt.timed_attacks.list[1].min_count = 0
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_STUN)
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(5)
tt.timed_attacks.list[1].sound = nil
tt.timed_attacks.list[2] = CC("spawn_attack")
tt.timed_attacks.list[2].animation = "summon"
tt.timed_attacks.list[2].cooldown = 9000000000
tt.timed_attacks.list[2].cast_time = fts(15)
tt.timed_attacks.list[2].entity = "soldier_skeleton"
tt.timed_attacks.list[2].sound = "HeroVikingCall"
tt.timed_attacks.list[2].sound_args = {
		delay = fts(5)
	}
tt.timed_attacks.list[2].nodes_offset = {
		4,
		8
	}
tt.motion.max_speed = 60
tt.nav_path.dir = -1
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "soldier_sand_warrior"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = 0.2
tt.render.sprites[2].animated = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].prefix = "spectres_possession_effect"
tt.render.sprites[2].scale = v(0.7, 0.7)
tt.render.sprites[2].offset = v(0, 10)
tt.soldier.melee_slot_offset = v(5,0)
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.flags = F_FRIEND

tt = RT("bomb_swamp_thing_pos", "bomb_swamp_thing")
tt.bullet.damage_bans = F_FRIEND

tt = E.register_t(E, "soldier_skeleton_pos", "soldier_militia")

E.add_comps(E, tt, "count_group")

anchor_y = 0.18
image_y = 38
tt.count_group.name = "skeletons_pos"
tt.health.dead_lifetime = 3
tt.health.hp_max = 120
tt.health_bar.offset = v(0, ady(38))
tt.info.fn = scripts2.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0052") or "info_portraits_sc_0052"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.range = 51.2
tt.regen = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_skeleton"
tt.sound_events.insert = "NecromancerSummon"
tt.vis.bans = bor(F_POLYMORPH, F_CANNIBALIZE, F_POISON, F_LYCAN)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.marker_offset = v(0, ady(7))
tt.unit.mod_offset = v(0, ady(18))

tt = E.register_t(E, "soldier_skeleton_knight_pos", "soldier_skeleton_pos")

E.add_comps(E, tt, "count_group")

anchor_y = 0.18
image_y = 50
tt.count_group.name = "skeletons_pos"
tt.health.armor = 0.3
tt.health.hp_max = 400
tt.health_bar.offset = v(0, ady(47))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0053") or "info_portraits_sc_0053"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.range = 38.4
tt.render.sprites[1].anchor.y = 0.18
tt.render.sprites[1].prefix = "soldier_skeleton_knight"
tt.sound_events.insert = "NecromancerSummon"

tt = E.register_t(E, "soldier_spider_small_pos", "soldier_skeleton_pos")

E.add_comps(E, tt, "count_group")

anchor_y = 0.25
anchor_x = 0.5
image_y = 28
image_x = 36
tt.count_group.name = "spider_pos"
tt.health.magic_armor = 0.65
tt.health_bar.offset = v(0, 22)
tt.health.hp_max = 100
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0022") or "info_portraits_sc_0022"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.5
tt.melee.range = 38.4
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spider_small"
tt.sound_events.insert = nil
tt.vis.bans = bor(F_POISON)

tt = E.register_t(E, "soldier_spider_big_pos", "soldier_skeleton_pos")

E.add_comps(E, tt, "count_group")

anchor_y = 0.25
anchor_x = 0.5
image_y = 40
image_x = 56
tt.count_group.name = "spider_big_pos"
tt.health.magic_armor = 0.8
tt.health_bar.offset = v(0, 32)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.hp_max = 500
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0021") or "info_portraits_sc_0021"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1
tt.melee.range = 38.4
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spider"
tt.sound_events.insert = nil
tt.vis.bans = bor(F_POISON)

tt = RT("aura_spectral_knight_pos", "aura")

AC(tt, "render", "tween")

tt.aura.active = false
tt.aura.allowed_templates = {
"soldier_possessed"
}
tt.aura.cooldown = 0
tt.aura.delay = fts(30)
tt.aura.duration = -1
tt.aura.mod = "mod_spectral_knight"
tt.aura.radius = 106.38297872340426
tt.aura.track_source = true
tt.aura.use_mod_offset = false
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts4.aura_spectral_knight_pos.update
tt.render.sprites[1].alpha = 0
tt.render.sprites[1].anchor = v(0.5, 0.28125)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "CB_DeathKnight_aura_0001"
tt.render.sprites[1].offset = v(0, -16)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].alpha = 0
tt.render.sprites[2].animated = true
tt.render.sprites[2].name = "spectral_knight_aura"
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(20),
		255
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.remove = false

tt = E.register_t(E, "soldier_spectral_knight_pos", "soldier_skeleton_pos")

E.add_comps(E, tt, "count_group", "auras")

image_y = 94
image_x = 128
anchor_y = 0.1595744680851064
anchor_x = 0.5
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_spectral_knight_pos"
tt.count_group.name = "spectralknights"
tt.health.armor = 1
tt.health.hp_max = 400
tt.health.immune_to = bor(DAMAGE_PHYSICAL, DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL, DAMAGE_SHOT)
tt.health_bar.offset = v(0, 61)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.enc_icon = 64
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0088") or "info_portraits_sc_0088"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 76
tt.melee.attacks[1].damage_min = 24
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 75
tt.motion.max_speed = FPS*0.775709219858156
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spectral_knight"
tt.sound_events.death = nil
tt.sound_events.insert = "CBSpectralKnight"
tt.sound_events.insert_args = {
	delay = 0.5
}
tt.ui.click_rect = r(-20, 0, 40, 45)
tt.unit.blood_color = BLOOD_NONE
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 21)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_THORN)

tt = E.register_t(E, "soldier_orc_armored_pos_1", "soldier_skeleton_pos")

E.add_comps(E, tt, "count_group")

anchor_y = 0.14
anchor_x = 0.5
image_y = 48
image_x = 70
tt.count_group.name = "orcrider"
tt.health.armor = 0.8
tt.health.hp_max = 320
tt.health_bar.offset = v(0, 36)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0060") or "info_portraits_sc_0059"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 75
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_orc_armored"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.insert = nil
tt.ui.click_rect.size.y = 28
tt.ui.click_rect.pos.y = 3
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset.y = 2
tt.unit.mod_offset = v(adx(34), ady(21))

tt = RT("soldier_orc_armored_pos_2", "soldier_orc_armored_pos_1")

tt.health.armor = 0.8
tt.health.hp_max = 400

tt = RT("soldier_orc_armored_pos_3", "soldier_orc_armored_pos_1")

tt.health.armor = 0.8
tt.health.hp_max = 480

tt = RT("soldier_orc_armored_pos_4", "soldier_orc_armored_pos_1")

tt.health.armor = 0.95
tt.health.hp_max = 600

tt = E.register_t(E, "aura_goblin_zapper_death_pos", "aura_goblin_zapper_death")
tt.aura.vis_bans = bor(F_FRIEND)

tt = RT("bomb_goblin_zapper_pos", "bomb_goblin_zapper")
tt.bullet.damage_bans = F_FRIEND

tt = E.register_t(E, "aura_rotten_lesser_death_pos", "aura_rotten_lesser_death")
tt.aura.vis_bans = bor(F_FRIEND)

tt = E.register_t(E, "aura_demon_death_pos", "aura_demon_death")
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)

tt = E.register_t(E, "abomination_explosion_aura_pos", "aura_demon_death")
tt.aura.damage_min = 250
tt.aura.damage_max = 250
tt.sound_events.insert = "HWAbominationExplosion"
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.radius = 100

tt = E.register_t(E, "aura_flareon_death_pos", "aura_flareon_death")
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)

tt = E.register_t(E, "aura_gulaemon_death_pos", "aura_gulaemon_death")
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)

tt = E.register_t(E, "aura_demon_mage_death_pos", "aura_demon_mage_death")
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)

tt = E.register_t(E, "aura_demon_wolf_death_pos", "aura_demon_wolf_death")
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)

tt = E.register_t(E, "aura_empty_nuhuh", "aura")
tt.aura.cycles = 0
tt.aura.damage_min = 0
tt.aura.damage_max = 0
tt.aura.damage_type = DAMAGE_NONE
tt.aura.excluded_templates = {
}
tt.aura.radius = 0
tt.aura.track_damage = true
tt.aura.vis_bans = bor(F_ENEMY, F_FLYING)
tt.aura.vis_flags = bor(F_RANGED)
tt.main_script.update = scripts.aura_apply_damage.update

tt = E.register_t(E, "aura_empty_nil", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = nil
tt.aura.cycle_time = 10000000
tt.aura.duration = 0
tt.aura.radius = 0
tt.aura.track_source = true
tt.aura.allowed_templates = {
}
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false

tt = RT("mod_possession", "modifier")
tt.main_script.update = scripts4.mod_possession.update
tt.modifier.bans = {
	"mod_goblirang_slow",
	"mod_slow_dwaarp",
	"mod_slow_oil",
	"mod_forest_eerie_slow",
	"mod_slow_baby_ashbite",
	"mod_elora_bolt_slow",
	"mod_slow",
	"mod_shocking_impact",
	"mod_bolin_slow",
	"mod_slow_curse",
	"mod_elora_chill"
}
tt.modifier.remove_banned = true
tt.entity_name = "soldier_possessed"
tt.fx = "fx_spectres_attack_hit"
tt.doll_duration = 10

tt = RT("soldier_gargoyle", "soldier_militia")

AC(tt, "melee")

image_y = 64
anchor_y = 0.15384615384615385
tt.health.armor = 0.6
tt.health.armor_inc = 0
tt.health.dead_lifetime = 15
tt.health.hp_max = 180
tt.health_bar.offset = v(0, 35)
tt.info.i18n_key = "SOLDIER_GARGOYLE"
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0011") or "krv_portraits_0011"
tt.info.random_name_count = 7
tt.info.random_name_format = "SOLDIER_GARGOYLE_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 24
tt.melee.attacks[1].damage_min = 16
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = 0.47
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].sound_hit = "KRVGenericCombat"
tt.melee.range = 60
tt.motion.max_speed = 50
tt.regen.cooldown = 2
tt.regen.health = 30
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_gargoyle"
tt.soldier.melee_slot_offset = v(7, 0)
tt.sound_events.insert = "RockElementalDeath"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)

tt = E.register_t(E, "fx_spectres_attack_hit", "fx")
tt.render.sprites[1].name = "spectres_proy_decal"

tt = E.register_t(E, "ps_spectres_trail")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "spectres_attack_trail_0001"
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
  0.2,
  0.2
}
tt.particle_system.alphas = {
  255,
  12
}
tt.particle_system.scales_y = {
  0.8,
  0.05
}
tt.particle_system.emission_rate = 60

tt = E.register_t(E, "bolt_spectres", "bolt")

E.add_comps(E, tt, "force_motion")

tt.render.sprites[1].prefix = "spectres_proy"
tt.render.sprites[1].scale = v(-1,-1)
tt.bullet.max_speed = 280
tt.bullet.min_speed = 30
tt.bullet.mod = nil
tt.bullet.damage_min = 48
tt.bullet.damage_max = 71
tt.bullet.hit_fx = "fx_spectres_attack_hit"
tt.bullet.pop = {
  "pop_zapow"
}
tt.bullet.shot_index = 2
tt.bullet.align_with_trajectory = true
tt.bullet.store = nil
tt.bullet.store_sort_y_offset = -65
tt.bullet.particles_name = "ps_spectres_trail"
tt.sound_events.travel = "SpectresMausoleumAttack"
tt.sound_events.summon = nil
tt.sound_events.insert = nil
tt.initial_impulse = 15000
tt.initial_impulse_duration = 0.1
tt.initial_impulse_angle = math.pi/3
tt.force_motion.a_step = 15
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 400
tt.main_script.update = scripts4.bolt_spectres.update

tt = RT("tower_goblirang", "tower_archer_1")

AC(tt, "attacks", "powers")

image_y = 90
tt.tower.type = "goblirang"
tt.tower.level = 1
tt.tower.price = 270
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 13
tt.info.i18n_key = "TOWER_GOBLIRANG"
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0012") or "krv_portraits_0012"
tt.powers.stun = CC("power")
tt.powers.stun.price_base = 130
tt.powers.stun.price_inc = 130
tt.powers.stun.mod = "mod_goblirang_stun"
tt.powers.stun.enc_icon = 79
tt.powers.stun.mod_chance = {
0.05,
0.1,
0.15
}
tt.powers.bees = CC("power")
tt.powers.bees.price_base = 200
tt.powers.bees.price_inc = 200
tt.powers.bees.enc_icon = 80
tt.powers.bees.name = "bees"
tt.powers.big = CC("power")
tt.powers.big.price_base = 200
tt.powers.big.price_inc = 100
tt.powers.big.enc_icon = 78
tt.powers.big.damage_min = {
52,
63,
88
}
tt.powers.big.damage_max = {
78,
91,
105
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_ranger_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_goblirangs_base_0001"
tt.render.sprites[2].offset = v(0, 45)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_goblirangs_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	big = {
		"bigUp",
		"bigDown"
	},
	bees = {
		"beesUp",
		"beesDown"
	}
}
tt.render.sprites[3].offset = v(-8, 60)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset.x = 8
tt.render.sprites[5] = CC("sprite")
tt.render.sprites[5].animated = false
tt.render.sprites[5].name = "tower_goblirangs_base_0002"
tt.render.sprites[5].offset = v(0, 45)
tt.main_script.update = scripts4.tower_goblirang.update
tt.attacks.range = 175
tt.attacks.node_prediction = 0.5
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "goblirang"
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
tt.render.sprites[1].prefix = "goblirangs_bees"
tt.render.sprites[1].name = "decal"

tt = E.register_t(E, "honey_bees_proy", "arrow")
tt.render.sprites[1].name = "goblirangs_bees_proy_0001"
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
tt.render.sprites[1].prefix = "goblirangs_bees"
tt.render.sprites[1].name = "aura"
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
tt.render.sprites[1].prefix = "goblirangs_proy_hit"
tt.render.sprites[1].name = "decal"

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

tt = E.register_t(E, "goblirang", "bullet")
tt.main_script.update = scripts4.goblirang.update
tt.bullet.particles_name = "ps_goblirang"
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 50
tt.bullet.max_speed = 350
tt.bullet.damage_every = 0.01
tt.radius = 30
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.damage_min = 25
tt.bullet.damage_max = 47
tt.bullet.mod2 = "mod_goblirang_slow"
tt.bullet.mod_chance = 0
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_goblirang_hit"
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bounce_range = 150
tt.bullet.rotation_speed = (FPS*60*math.pi)/90
tt.render.sprites[1].name = "goblirangs_proy_0001"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "GoblirangSound"

tt = RT("fx_goblirang_big_hit", "fx")
tt.render.sprites[1].prefix = "goblirangs_proy_big"
tt.render.sprites[1].name = "decal"

tt = RT("ps_goblirang_big", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 10
tt.particle_system.name = "goblirangs_big_proy_0001"
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

tt = E.register_t(E, "goblirang_big", "bullet")
tt.main_script.update = scripts4.goblirang.update
tt.bullet.particles_name = "ps_goblirang_big"
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 50
tt.bullet.max_speed = 250
tt.bullet.mod2 = "mod_goblirang_slow"
tt.bullet.mod_chance = 0
tt.bullet.damage_every = 0.01
tt.radius = 45
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.damage_min = 52
tt.bullet.damage_max = 78
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_goblirang_big_hit"
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bounce_range = 150
tt.bullet.rotation_speed = (FPS*60*math.pi)/90
tt.render.sprites[1].name = "goblirangs_big_proy_0001"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "GoblirangSound"

tt = RT("mod_goblirang_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 1.2
tt.modifier.vis_bans = F_BOSS
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].prefix = "stun"
tt.render.sprites[1].name = "goblirang"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].size_names = {
	"goblirang",
	"goblirang",
	"goblirang"
}
tt.modifier.custom_offsets = {
	default = v(0, 40),
	flying = v(0, 79),
	enemy_gargoyle = v(0, 79),
	enemy_demon_imp = v(0, 79),
	enemy_rocketeer = v(0, 79),
	enemy_witch = v(0, 79),
	enemy_shaman = v(0, 39),
	enemy_troll_chieftain = v(0, 50),
	enemy_necromancer = v(0, 41),
	enemy_demon_legion = v(0, 47),
	enemy_fallen_knight = v(0, 50),
	enemy_spectral_knight_spawn = v(0, 50),
	enemy_spectral_knight = v(0, 50),
	enemy_pillager = v(0, 55),
	enemy_raider = v(0, 50),
	enemy_marauder = v(0, 50),
	enemy_hobgoblin_shield = v(0, 50),
	enemy_hobgoblin_rider = v(0, 50),
	enemy_slayer = v(0, 50),
	enemy_demon_gulaemon = v(0, 55),
	enemy_troll_breaker = v(0, 50),
	enemy_forest_troll = v(0, 55),
	enemy_lava_elemental = v(0, 55),
	enemy_swamp_thing = v(0, 55),
	enemy_sarelgaz_small = v(0, 50),
	enemy_rotten_tree = v(0, 50),
	enemy_orc_rider = v(0, 50),
	enemy_cursed_golem = v(0, 55),
	enemy_abomination = v(0, 55),
	enemy_lycan = v(0, 50),
	enemy_goblin_balloon = v(0, 75)
}

tt = E.register_t(E, "tower_bone_flingers", "tower_archer_1")

E.add_comps(E, tt, "powers", "barrack")

tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0013") or "krv_portraits_0013"
tt.info.enc_icon = 18
tt.info.fn = scripts4.tower_bone_flingers.get_info
tt.tower.type = "bone_flingers"
tt.tower.price = 180
tt.powers.skeleton = E.clone_c(E, "power")
tt.powers.skeleton.price_base = 180
tt.powers.skeleton.price_inc = 180
tt.powers.skeleton.enc_icon = 90
tt.powers.skeleton.max_level = 2
tt.powers.skeleton.cooldown = {
16,
12
}
tt.powers.skeleton.vis_flags = bor(F_BLOCK)
tt.powers.skeleton.vis_bans = bor(F_FLYING)
tt.powers.golem = E.clone_c(E, "power")
tt.powers.golem.price_base = 300
tt.powers.golem.price_inc = 300
tt.powers.golem.name = "GOLEM"
tt.powers.golem.max_level = 1
tt.powers.golem.enc_icon = 92
tt.powers.milk = E.clone_c(E, "power")
tt.powers.milk.price_base = 110
tt.powers.milk.price_inc = 110
tt.powers.milk.enc_icon = 91
tt.powers.milk.damage_inc = {
5,
10,
15
}
tt.barrack.soldier_type = "soldier_bone_golem"
tt.barrack.rally_range = 145
tt.barrack.max_soldiers = 0
tt.main_script.insert = scripts4.tower_bone_flingers.insert
tt.main_script.remove = scripts4.tower_bone_flingers.remove
tt.main_script.update = scripts4.tower_bone_flingers.update
tt.attacks.range = 150
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
tt.render.sprites[1].name = "terrain_archer_ranger_%04i"
tt.render.sprites[1].offset = v(0, 6)
tt.render.sprites[2].name = "tower_bone_flingers_base_0001"
tt.render.sprites[2].offset = v(0, 27)
tt.render.sprites[3].prefix = "tower_bone_flingers_shooter"
tt.render.sprites[3].offset = v(-7, 51)
tt.render.sprites[4].prefix = "tower_bone_flingers_shooter"
tt.render.sprites[4].offset = v(15, 45)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].name = "tower_bone_flingers_base_0002"
tt.render.sprites[5].animated = false
tt.render.sprites[5].offset = v(0, 27)
tt.sound_events.insert = "BoneFlingersTaunt"
tt.sound_events.change_rally_point = "BoneFlingersGolemTaunt"

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
tt.main_script.update = scripts3.bomb_kro.update
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
tt.main_script.update = scripts3.bomb_kro.update
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
tt.render.sprites[1].name = "bone_flingers_proy1_0001"
tt.render.sprites[1].animated = false
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = "bone_flingers_proy1_decal_0001"
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.damage_min = 14
tt.bullet.damage_max = 34
tt.bullet.pop = {
  "pop_thunk"
}
tt.bullet.reset_to_target_pos = true
tt.bullet.pop_chance = 0
tt.bullet.pop_conds = DR_KILL
tt.sound_events.insert = "GoblirangSound"

tt = E.register_t(E, "bone_golem_bone", "arrow")
tt.render.sprites[1].name = "bone_golem_proy_0001"
tt.render.sprites[1].animated = false
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = "bone_golem_proy_decal_0001"
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

tt = RT("soldier_bone_golem", "soldier_militia")

AC(tt, "melee", "ranged")

image_y = 64
anchor_y = 0.15384615384615385
tt.health.armor = 0.3
tt.health.armor_inc = 0.1
tt.health.dead_lifetime = 10
tt.health.hp_max = 300
tt.health.hp_inc = 0
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "SOLDIER_BONE_GOLEM"
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0014") or "krv_portraits_0014"
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
tt.render.sprites[1].prefix = "soldier_bone_golem"
tt.render.sprites[1].offset = v(0, -10)
tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "BoneFlingersSummon"
tt.sound_events.death = "BoneFlingersSummon"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)

tt = E:register_t("soldier_flingers_skeleton", "unit")

E:add_comps(tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events")

anchor_y = 0.2
image_y = 36
tt.info.portrait = IS_PHONE_OR_TABLET and "krv_portraits_0015" or "krv_portraits_0015"
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
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_skeleton"
tt.soldier.melee_slot_offset.x = 5
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_LYCAN)
tt.vis.flags = F_FRIEND
tt.sound_events.insert = "BoneFlingersSummon"
tt.sound_events.death = "DeathSkeleton"

tt = E:register_t("soldier_flingers_skeleton_warrior", "unit")

E:add_comps(tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events")

anchor_y = 0.2
image_y = 36
tt.info.portrait = IS_PHONE_OR_TABLET and "krv_portraits_0016" or "krv_portraits_0016"
tt.health.armor = 0
tt.health.hp_inc = 0
tt.health.hp_max = 160
tt.health_bar.offset = v(0, ady(39))
tt.info.fn = scripts4.soldier_flingers_skeleton.get_info
tt.info.i18n_key = "SOLDIER_FLINGERS_SKELETON_WARRIOR"
tt.main_script.insert = scripts4.soldier_flingers_skeleton.insert
tt.main_script.update = scripts4.soldier_flingers_skeleton.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 60
tt.motion.max_speed = 35
tt.nav_path.dir = -1
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_skeleton_knight"
tt.soldier.melee_slot_offset.x = 5
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_LYCAN)
tt.vis.flags = F_FRIEND
tt.sound_events.insert = "BoneFlingersSummon"
tt.sound_events.death = "DeathSkeleton"

tt = E.register_t(E, "arrow_shadow_tower", "elven_arrow_1")
tt.bullet.flight_time = 0.2
tt.bullet.miss_decal = "tower_shadow_archer_arrow_decal_0001"
tt.bullet.damage_max = 36
tt.bullet.damage_min = 24
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "tower_shadow_archer_arrow_0001"
tt.render.sprites[1].scale = v(-0.7, 0.7)

tt = E.register_t(E, "fx_arrow_blade_demise_hit", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].name = "fx_arrow_blade_demise_hit"
tt.render.sprites[1].offset = v(0, 15)
tt.sound_events.insert = "TowerShadowInstakill"

tt = E.register_t(E, "arrow_blade_demise", "bullet")
tt.bullet.pop = {
  "pop_splat"
}
tt.render.sprites[1].hidden = true
tt.bullet.g = 0
tt.bullet.hit_fx = "fx_arrow_blade_demise_hit"
tt.bullet.flight_time_min = 0
tt.hit_time = 0.8
tt.main_script.update = scripts4.blade_demise.update
tt.sound_events.insert = nil
tt.bullet.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_NOT_EXPLODE)
tt.bullet.prediction_error = false

tt.bullet.pop_conds = DR_KILL

tt = RT("ps_shadow_mark_trail", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 50
tt.particle_system.name = "arrow_shadow_mark_smoke"
tt.particle_system.particle_lifetime = {
	0.2,
	0.3
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

tt = E.register_t(E, "arrow_shadow_mark", "arrow_silver")
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_fx = nil
tt.bullet.mod = "mod_arrow_shadow_mark"
tt.bullet.particles_name = "ps_shadow_mark_trail"
tt.bullet.flight_time = 0.7
tt.bullet.miss_decal = nil
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "shadow_mark_arrow_0001"
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
tt.render.sprites[1].name = "arrow_shadow_mark_particle_1"
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].z = Z_EFFECTS
tt.sound_events.insert = nil

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
tt.bullet.payload = "aura_lava_fissure"
tt.render.sprites[1].hidden = true
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
tt.render.sprites[1].prefix = "decal_lava_fissure_new"
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].z = Z_EFFECTS

tt = E.register_t(E, "soldier_hobgoblin_pos_1", "soldier_skeleton_pos")

E.add_comps(E, tt, "count_group")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.count_group.name = "hobrider"
tt.health.armor = 0.25
tt.health.hp_max = 200
tt.health_bar.offset = v(0, 30)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 75
tt.motion.max_speed = FPS*1.4
tt.render.sprites[1].anchor = v(0.5, 0.19)
tt.render.sprites[1].prefix = "enemy_hobgoblin_small"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.insert = nil
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))

tt = E.register_t(E, "soldier_hobgoblin_pos_2", "soldier_hobgoblin_pos_1")

tt.health.hp_max = 240

tt = E.register_t(E, "soldier_hobgoblin_pos_3", "soldier_hobgoblin_pos_1")

tt.health.hp_max = 280

tt = E.register_t(E, "soldier_hobgoblin_pos_4", "soldier_hobgoblin_pos_1")

tt.health.hp_max = 320

tt = E.register_t(E, "soldier_cursed_shard_pos_1", "soldier_skeleton_pos")

E.add_comps(E, tt, "count_group")

anchor_y = 0.3
anchor_x = 0.5
image_y = 42
image_x = 58
tt.count_group.name = "shard_pos"
tt.health_bar.offset = v(0, 30)
tt.health.hp_max = 187
tt.health.armor = 0.2
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0102") or "info_portraits_sc_0102"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 22
tt.melee.attacks[1].damage_min = 8
tt.melee.attacks[1].hit_time = fts(6)
tt.motion.max_speed = FPS*1.5
tt.melee.range = 38.4
tt.render.sprites[1].anchor = v(0.5, 0.3)
tt.render.sprites[1].prefix = "enemy_cursed_shard"
tt.sound_events.insert = nil
tt.vis.bans = bor(F_POISON)

tt = E.register_t(E, "soldier_cursed_shard_pos_2", "soldier_cursed_shard_pos_1")

tt.health.hp_max = 218

tt = E.register_t(E, "soldier_cursed_shard_pos_3", "soldier_cursed_shard_pos_1")

tt.health.hp_max = 250

tt = E.register_t(E, "soldier_cursed_shard_pos_4", "soldier_cursed_shard_pos_1")

tt.health.hp_max = 281
tt.health.armor = 0.25
tt.health.magic_armor = 0.15

tt = E.register_t(E, "tower_orc_warriors_den", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.fn = scripts4.tower_orc_warriors_den.get_info
tt.main_script.update = scripts4.tower_orc_warriors_den.update
tt.info.enc_icon = 18
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0002") or "krv_portraits_0002"
tt.barrack.soldier_type = "soldier_orc_warrior"
tt.powers.seal = E.clone_c(E, "power")
tt.powers.seal.price_base = 120
tt.powers.seal.price_inc = 120
tt.powers.seal.max_level = 2
tt.powers.seal.enc_icon = 71
tt.powers.seal.heal_inc = {
5,
5
}
tt.powers.promotion = E.clone_c(E, "power")
tt.powers.promotion.price_base = 150
tt.powers.promotion.price_inc = 150
tt.powers.promotion.enc_icon = 70
tt.powers.promotion.max_level = 1
tt.powers.promotion.regen = 30
tt.powers.promotion.damage_min = 16
tt.powers.promotion.damage_max = 23
tt.powers.promotion.hp_max = 300
tt.powers.promotion.armor = 0.5
tt.powers.bloodlust = E.clone_c(E, "power")
tt.powers.bloodlust.price_base = 180
tt.powers.bloodlust.price_inc = 180
tt.powers.bloodlust.max_level = 2
tt.powers.bloodlust.enc_icon = 69
tt.powers.bloodlust.damage_factor = {
1.4,
1.8
}
tt.powers.bloodlust.name = "BLOODLUST"
tt.render.sprites[2].name = "tower_orc_warriors_den_base_0001"
tt.render.sprites[2].offset = v(0, 33)
tt.render.sprites[3].prefix = "tower_orc_warriors_den_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 8)
tt.sound_events.change_rally_point = "Orc_WarmongersTaunt"
tt.sound_events.insert = "Orc_WarmongersBuild"
tt.tower.price = 230
tt.tower.type = "orc_warriors_den"

tt = E.register_t(E, "soldier_orc_warrior", "soldier_militia")

E.add_comps(E, tt, "powers")

image_y = 42
anchor_y = 0.25
tt.health_bar.offset = v(0, 35)
tt.health.armor = 0.2
tt.health.dead_lifetime = 10
tt.health.hp_max = 200
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0008") or "krv_portraits_0008"
tt.info.random_name_count = 9
tt.info.random_name_format = "SOLDIER_ORC_WARRIOR_RANDOM_%i_NAME"
tt.main_script.insert = scripts4.soldier_orc_warrior.insert
tt.main_script.update = scripts4.soldier_orc_warrior.update
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 16
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[1].damage_min = 11
tt.melee.attacks[1].damage_maxbase = 16
tt.melee.attacks[1].damage_minbase = 11
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
tt.regen.health = 20
tt.regen.cooldown = 2
tt.render.sprites[1].prefix = "soldier_orc_warrior"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].animated = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].prefix = "orc_bloodlust_buff"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].hidden = true
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)

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

tt = E.register_t(E, "tower_dark_knights", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0005") or "krv_portraits_0005"
tt.info.enc_icon = 20
tt.tower.type = "dark_knights"
tt.tower.price = 260
tt.powers.instakill = E.clone_c(E, "power")
tt.powers.instakill.price_base = 280
tt.powers.instakill.price_inc = 280
tt.powers.instakill.enc_icon = 81
tt.powers.spike = CC("power")
tt.powers.spike.price_base = 150
tt.powers.spike.price_inc = 150
tt.powers.spike.enc_icon = 82
tt.powers.shield = E.clone_c(E, "power")
tt.powers.shield.price_base = 200
tt.powers.shield.price_inc = 200
tt.powers.shield.enc_icon = 83
tt.powers.shield.max_level = 1
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "soldier_dark_knight"
tt.barrack.rally_range = 145
tt.barrack.rally_angle_offset = -0.4
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "tower_dark_knights_base_0001"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3].prefix = "tower_dark_knights_door"
tt.render.sprites[3].offset = v(0, 15)
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.sound_events.insert = "DarkKnightsTauntBuild"
tt.sound_events.change_rally_point = "DarkKnightsTaunt"

tt = E.register_t(E, "soldier_dark_knight", "soldier_militia")

E.add_comps(E, tt, "powers", "dodge")

anchor_y = 0.19
image_y = 42
tt.dodge.animation = "dodge"
tt.dodge.chance = 0
tt.dodge.chance_inc = 0
tt.dodge.cooldown = 15
tt.dodge.shield = E.clone_c(E, "melee_attack")
tt.dodge.shield.animation_start = "shield_start"
tt.dodge.shield.animation_end = "shield_end"
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
tt.health.hp_max = 260
tt.health.dark_spiked_armor = 0
tt.health.dark_damage_type = DAMAGE_PHYSICAL
tt.health_bar.offset = v(0, 32.86)
tt.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0007") or "krv_portraits_0007"
tt.info.random_name_count = 9
tt.info.random_name_format = "SOLDIER_DARK_KNIGHT_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 1.6
tt.melee.attacks[1].damage_max = 36
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "instakill"
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
tt.melee.attacks[3].animation = "instakill"
tt.melee.attacks[3].chance = 0
tt.melee.attacks[3].chance_inc = 0.02
tt.melee.attacks[3].cooldown = 1.6
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_time = fts(24)
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
tt.regen.cooldown = 2
tt.render.sprites[1].prefix = "soldier_dark_knight"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))

tt = E.register_t(E, "aura_lycan_regen_pos", "aura")

AC(tt, "regen")

tt.main_script.update = scripts.aura_unit_regen.update
tt.regen.cooldown = 0.25
tt.regen.health = 2
tt.regen.ignore_stun = false
tt.regen.ignore_freeze = false

tt = E:register_t("fx_b_volt_hit", "fx")
tt.render.sprites[1].name = "voltaire_toss_decal"
tt.render.sprites[1].offset = v(0, 7)

tt = E:register_t("b_volt", "bomb")
tt.render.sprites[1].name = "voltaire_toss_proj"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.bullet.hit_fx = "fx_b_volt_hit"
tt.bullet.hit_decal = nil
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.mod = "mod_stun_volt"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt = E:register_t("b_coil", "bomb")
tt.render.sprites[1].name = "voltaire_coil_proj_0001"
tt.sound_events.insert = "AxeSound"
tt.bullet.hit_fx = nil
tt.bullet.hit_scripted = "mini_tesla"
tt.main_script.remove = scripts.mini_tesla.remove
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.damage_type = DAMAGE_NONE
tt = E:register_t("b_tesla", "ray_tesla")
tt.bullet.mod = "mod_ray_mini_tesla"
tt.bounces = 0

tt = E:register_t("mod_stun_volt", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt = E:register_t("mod_ray_mini_tesla", "mod_ray_tesla")
tt.dps.cocos_frames = 1
tt.dps.cocos_cycles = 1
tt.dps.pop = nil
tt.dps.pop_chance = nil
tt.dps.pop_conds = nil

tt = E:register_t("mini_tesla", "decal_scripted")
tt.render.sprites[1].prefix = "voltaire_coil"
tt.render.sprites[1].offset = v(0, 8)
tt.sound_insert = "VoltaireCoilInsert"
tt.sound_remove = "VoltaireCoilRemove"
tt.sound_shoot = "TeslaAttack"
tt.sound_charge = "HWFrankensteinChargeLightning"
tt.main_script.update = scripts.mini_tesla.update
tt.bullet = "b_tesla"
tt.bullet_start_offset = v(0, 16)
tt.shoot_time = fts(22)
tt.shoot_duration = fts(17)
tt.duration = 30
tt.damage = 120
tt.cooldown = 2 - tt.shoot_duration
tt.min_range = 0
tt.max_range = 100
tt.vis_flags = F_RANGED
tt.vis_bans = 0
tt = E:register_t("hero_voltaire", "hero")

E:add_comps(tt, "melee", "ranged", "timed_attacks")

tt.hero.fixed_stat_attack = 7
tt.hero.fixed_stat_health = 5
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 3
tt.render.sprites[1].offset = v(0, 12)
tt.soldier.melee_slot_offset = v(10, 0)
tt.render.sprites[1].prefix = "hero_voltaire"
tt.info.portrait = "info_portraits_hero_0017"
tt.info.hero_portrait = "heroPortrait_portraits_0015"
tt.info.i18n_key = "HERO_VOLT"
tt.info.fn = scripts.hero_basic.get_info_melee
tt.hero.fn_level_up = scripts.hero_voltaire.level_up
tt.main_script.update = scripts.hero_voltaire.update
tt.sound_events.hero_room_select = "HeroVoltaireTauntSelect"
tt.sound_events.insert = "HeroSamuraiTauntIntro"
tt.sound_events.respawn = "HeroSamuraiTauntIntro"
tt.sound_events.change_rally_point = "HeroVoltaireTaunt"
tt.sound_events.death = "HeroVoltaireDeath"
tt.health.dead_lifetime = 15
tt.hero.tombstone_show_time = fts(60)
tt.motion.max_speed = FPS * 2.25
tt.melee.range = 60
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].xp_gain_factor = 4.8
tt.melee.attacks[1].sound = "MeleeSword"
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].bullet = "b_volt"
tt.ranged.attacks[1].animation = "toss"
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].bullet_start_offset = {
    v(8, 18)
}
tt.ranged.attacks[1].xp_from_skill = "toss"
tt.ranged.attacks[1].node_prediction = 1.6
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 160
tt.ranged.attacks[1].shoot_time = fts(25)
tt.ranged.attacks[1].max_track_distance = nil
tt.ranged.attacks[1].vis_flags = bor(F_RANGED, F_STUN, F_MOD)
tt.ranged.attacks[1].vis_bans = F_FLYING
tt.ranged.attacks[1].ignore_hit_offset = true
tt.timed_attacks.list[1] = CC("bullet_attack")
tt.timed_attacks.list[1].bullet = "b_coil"
tt.timed_attacks.list[1].animation = "throw"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].bullet_start_offset = v(12, 12)
tt.timed_attacks.list[1].max_range = 100
tt.timed_attacks.list[1].min_range = 20
tt.timed_attacks.list[1].shoot_time = fts(10)
tt.timed_attacks.list[1].cooldown = 12
tt.timed_attacks.list[1].node_offset = {
	-12,
	12
}
tt.hero.level_stats.hp_max = {
	275,
	300,
	325,
	350,
	375,
	400,
	425,
	450,
	475,
	500
}
tt.hero.level_stats.regen_health = {
	69,
	75,
	82,
	88,
	94,
	100,
	107,
	113,
	119,
	125
}
tt.hero.level_stats.melee_damage_max = {
	18,
	21,
	25,
	30,
	33,
	36,
	40,
	45,
	48,
	53
}
tt.hero.level_stats.melee_damage_min = {
	12,
	14,
	17,
	20,
	22,
	24,
	27,
	30,
	32,
	35
}
tt.hero.skills.toss = E:clone_c("hero_skill")
tt.hero.skills.toss.xp_level_steps = {
	[2] = 1,
	[5] = 2,
	[8] = 3
}
tt.hero.skills.toss.damage_min = {
	20,
	40,
	60
}
tt.hero.skills.toss.damage_max = {
	20,
	40,
	60
}
tt.hero.skills.toss.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.toss.radius = {
	80,
	100,
	120
}
tt.hero.skills.toss.stun_duration = {
	3,
	4,
	5
}
tt.hero.skills.toss.cooldown = {
	12,
	12,
	12
}
tt.hero.skills.tesla = E:clone_c("hero_skill")
tt.hero.skills.tesla.xp_level_steps = {
	[4] = 1,
	[7] = 2,
	[10] = 3
}
tt.hero.skills.tesla.attack_count = {
	4,
	7,
	10
}
tt.hero.skills.tesla.xp_gain = {
	150,
	300,
	450
}
tt.regen.cooldown = 1

tt = E.register_t(E, "decal_whiteness", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 5
tt.aura.duration = 10
tt.aura.mods = nil
tt.aura.radius = 80
tt.aura.vis_bans = bor(F_ALL)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.render.sprites[1].name = "whiteness"
tt.render.sprites[1].z = 3901
tt.render.sprites[1].scale = v(20, 80)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(30),
		0
	},
	{
		fts(60),
		255
	}
}

tt = E:register_t("tower_pirate_camp", "tower")

E:add_comps(tt, "user_selection", "attacks", "tween", "powers")

tt.tower.level = 1
tt.sound_events.insert = "PiratesTaunt"
tt.tower.type = "pirate_camp"
tt.tower.can_be_mod = false
tt.tower.can_hover = true
tt.tower.menu_offset = v(6, 20)
tt.tower.terrain_style = nil
tt.tower.price = 260
tt.powers.shoot = CC("power")
tt.powers.shoot.enc_icon = 125
tt.info.enc_icon = 91
tt.info.i18n_key = "TOWER_PIRATE_CAMP"
tt.info.fn = scripts2.tower_pirate_camp_re.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_" or "info_portraits_towers_") .. "0016"
tt.main_script.update = scripts2.tower_pirate_camp_re.update
tt.user_selection.can_select_point_fn = scripts2.tower_pirate_camp_re.can_select_point
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bomb_pirate_camp"
tt.attacks.list[1].price = 25
tt.attacks.list[1].shots = 1
tt.attacks.list[1].max_error = 40
tt.attacks.list[1].min_error = 0
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].price = 45
tt.attacks.list[2].shots = 2
tt.attacks.list[3] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[3].price = 60
tt.attacks.list[3].shots = 3
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].name = "tower_pirate_camp_"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 25)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "tower_pirate_camp_smoke"
tt.render.sprites[2].offset = v(5, 38)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "tower_pirate_camp_sign_0001"
tt.render.sprites[3].animated = false
tt.render.sprites[3].offset = v(-2, 85)
tt.render.sprites[3].hidden = true
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].name = "tower_pirate_camp_sign2_0001"
tt.render.sprites[4].animated = false
tt.render.sprites[4].offset = v(-2, 85)
tt.render.sprites[4].hidden = true
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "pirate_cannon_2"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(-25, 53)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "pirate_cannon_3"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].offset = v(-50, 40)
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].prefix = "pirate_cannon_1"
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].offset = v(-20, 17)
tt.render.sprites[8] = E:clone_c("sprite")
tt.render.sprites[8].prefix = "decal_drinking_pirate"
tt.render.sprites[8].loop = false
tt.render.sprites[8].offset = v(29, 53)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].sprite_id = 3
tt.tween.props[1].keys = {
	{
		0,
		v(0.75, 0.75)
	},
	{
		fts(4),
		v(1.08, 1.08)
	},
	{
		fts(7),
		v(0.95, 0.95)
	},
	{
		fts(9),
		v(1, 1)
	},
	{
		fts(40),
		v(1, 1)
	},
	{
		fts(42),
		v(1.08, 1.08)
	},
	{
		fts(46),
		v(0.75, 0.75)
	}
}
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].sprite_id = 3
tt.tween.props[2].keys = {
	{
		0,
		128
	},
	{
		fts(4),
		255
	},
	{
		fts(42),
		255
	},
	{
		fts(46),
		0
	}
}
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		v(0.75, 0.75)
	},
	{
		fts(4),
		v(1.08, 1.08)
	},
	{
		fts(7),
		v(0.95, 0.95)
	},
	{
		fts(9),
		v(1, 1)
	},
	{
		fts(70),
		v(1, 1)
	},
	{
		fts(72),
		v(1.08, 1.08)
	},
	{
		fts(76),
		v(0.75, 0.75)
	}
}
tt.tween.props[3].sprite_id = 4
tt.tween.props[4] = E:clone_c("tween_prop")
tt.tween.props[4].keys = {
	{
		0,
		128
	},
	{
		fts(4),
		255
	},
	{
		fts(72),
		255
	},
	{
		fts(76),
		0
	}
}
tt.tween.props[4].sprite_id = 4

tt = E:register_t("fx_tower_pirate_camp_cannon_smoke", "fx")
tt.render.sprites[1].name = "tower_pirate_camp_cannon_smoke"

tt = E:register_t("decal_tower_pirate_camp_target", "decal_tween")

E:add_comps(tt, "timed")

tt.render.sprites[1].name = "special_pirate_cannons_crosshair_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "special_pirate_cannons_crosshair_0002"
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor = v(0.5, 0.5)
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].name = "special_pirate_cannons_crosshair_0002"
tt.render.sprites[3].animated = false
tt.render.sprites[3].anchor = v(0.5, 0.5)
tt.render.sprites[3].z = Z_DECALS
tt.timed.duration = fts(39)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(5),
		v(1.05, 1.05)
	},
	{
		fts(10),
		v(1, 1)
	}
}
tt.tween.props[1].loop = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		191
	},
	{
		fts(5),
		170
	},
	{
		fts(10),
		191
	}
}
tt.tween.props[2].loop = true
tt.tween.props[3] = E:clone_c("tween_prop")
tt.tween.props[3].name = "scale"
tt.tween.props[3].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(20),
		v(1.6, 1.6)
	}
}
tt.tween.props[3].loop = true
tt.tween.props[3].sprite_id = 2
tt.tween.props[4] = E:clone_c("tween_prop")
tt.tween.props[4].name = "alpha"
tt.tween.props[4].keys = {
	{
		0,
		255
	},
	{
		fts(20),
		0
	}
}
tt.tween.props[4].loop = true
tt.tween.props[4].sprite_id = 2
tt.tween.props[5] = E:clone_c("tween_prop")
tt.tween.props[5].name = "scale"
tt.tween.props[5].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(20),
		v(1.6, 1.6)
	}
}
tt.tween.props[5].loop = true
tt.tween.props[5].sprite_id = 3
tt.tween.props[5].time_offset = fts(10)
tt.tween.props[6] = E:clone_c("tween_prop")
tt.tween.props[6].name = "alpha"
tt.tween.props[6].keys = {
	{
		0,
		255
	},
	{
		fts(20),
		0
	}
}
tt.tween.props[6].loop = true
tt.tween.props[6].sprite_id = 3
tt.tween.props[6].time_offset = fts(10)

tt = E:register_t("bomb_pirate_camp", "bullet")
tt.render = nil
tt.main_script.update = scripts2.bomb_pirate_cannon.update
tt.bullet.damage_min = 60
tt.bullet.damage_max = 120
tt.bullet.damage_radius = 48
tt.bullet.damage_bans = bor(F_FRIEND)
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.sound_events.hit = "BombExplosionSound"

tt = E.register_t(E, "tower_elite_harassers", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "krv_portraits_") .. "0017"
tt.info.enc_icon = 92
tt.info.i18n_key = "TOWER_ELITE_HARASSERS"
tt.tower.type = "elite_harassers"
tt.tower.price = 250
tt.powers.fury = E.clone_c(E, "power")
tt.powers.fury.price_base = 220
tt.powers.fury.price_inc = 220
tt.powers.fury.enc_icon = 128
tt.powers.fury.max_level = 1
tt.powers.arrow = E.clone_c(E, "power")
tt.powers.arrow.price_base = 140
tt.powers.arrow.price_inc = 140
tt.powers.arrow.enc_icon = 127
tt.powers.backstab = E.clone_c(E, "power")
tt.powers.backstab.price_base = 180
tt.powers.backstab.price_inc = 180
tt.powers.backstab.max_level = 2
tt.powers.backstab.enc_icon = 126
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "soldier_elite_harasser"
tt.barrack.rally_range = 175
tt.barrack.rally_angle_offset = -0.4
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "tower_elite_harassers_0001"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3].prefix = "tower_elite_harassers_door"
tt.render.sprites[3].offset = v(1, 6)
tt.sound_events.insert = "EliteHarassersTaunt"
tt.sound_events.change_rally_point = "EliteHarassersTaunt"

tt = E.register_t(E, "soldier_elite_harasser", "soldier_militia")

E.add_comps(E, tt, "powers", "dodge", "ranged", "revive")

anchor_y = 0.19
image_y = 42
tt.dodge.animation = "dodge"
tt.dodge.chance = 0.3
tt.dodge.chance_inc = 0.1
tt.dodge.cooldown = 0.5
tt.dodge.counter_attack = E.clone_c(E, "melee_attack")
tt.dodge.counter_attack.animation = "backstab"
tt.dodge.counter_attack.cooldown = 0.5
tt.dodge.counter_attack.damage_inc_min = {
10,
20
}
tt.dodge.counter_attack.damage_inc_max = {
15,
30
}
tt.dodge.counter_attack.damage_max = 0
tt.dodge.counter_attack.damage_min = 0
tt.dodge.counter_attack.hit_time = fts(8)
tt.dodge.counter_attack.power_name = "backstab"
tt.dodge.power_name = "backstab"
tt.main_script.update = scripts4.soldier_elite_harasser.update
tt.main_script.insert = scripts4.soldier_elite_harasser.insert
tt.health.armor = 0
tt.health.dead_lifetime = 12
tt.health.hp_max = 220
tt.health_bar.offset = v(0, 34)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0005") or "krv_portraits_0018"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_ELITE_HARASSERS_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 0.8
tt.melee.attacks[1].damage_max = 35
tt.melee.attacks[1].damage_min = 25
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.range = 60
tt.ranged.attacks[1].bullet = "arrow_elite_harasser"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 12)
}
tt.ranged.attacks[1].cooldown = 0.9
tt.ranged.attacks[1].disabled = false
tt.ranged.attacks[1].max_range = 180
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = fts(14)
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 27)
}
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].animations = {
"barrage_start",
"barrage_loop",
"barrage_end"
}
tt.ranged.attacks[2].bullet = "arrow_elite_harasser_barrage"
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].loops = 5
tt.ranged.attacks[2].level = 0
tt.ranged.attacks[2].cooldown = 12
tt.ranged.attacks[2].repeat_cooldown = fts(20)
tt.ranged.attacks[2].shoot_times = {
fts(3)
}
tt.ranged.attacks[2].power_name = "arrow"
tt.motion.max_speed = 85
tt.powers.arrow = E.clone_c(E, "power")
tt.powers.backstab = E.clone_c(E, "power")
tt.powers.fury = E.clone_c(E, "power")
tt.powers.fury.chance = 0.75
tt.powers.fury.duration = 6
tt.powers.fury.health = 250
tt.powers.fury.damage_min = 32
tt.powers.fury.damage_max = 48
tt.powers.fury.speed = 150
tt.powers.fury.cooldown = 0.5
tt.powers.fury.fury_on = nil
tt.run_particles_name = "ps_fury_run"
tt.regen.health = 22
tt.regen.cooldown = 2
tt.revive.chance = 0
tt.revive.disabled = true
tt.revive.health_recover = 1
tt.revive.animation = "transform"
tt.revive.hit_time = fts(15)
tt.revive.sound = "EliteHarassersFuryRise"
tt.render.sprites[1].prefix = "soldier_elite_harassers"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, -3)
tt.soldier.melee_slot_offset = v(12, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))

tt = E.register_t(E, "arrow_elite_harasser", "elven_arrow_1")
tt.bullet.flight_time = fts(15)
tt.bullet.miss_decal = "arrow_elite_harasser_decal_0001"
tt.bullet.damage_max = 35
tt.bullet.damage_min = 25
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "arrow_elite_harasser_0001"
tt.render.sprites[1].offset = v(-2, -5)
tt.sound_events.insert = "GoblirangBeesSound"

tt = E.register_t(E, "arrow_elite_harasser_barrage", "elven_arrow_1")
tt.bullet.flight_time = fts(15)
tt.bullet.miss_decal = "arrow_elite_harasser_barrage_decal_0001"
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min_inc = 16
tt.bullet.damage_max_inc = 24
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "arrow_elite_harasser_barrage_0001"
tt.render.sprites[1].offset = v(-2, -5)
tt.sound_events.insert = "EliteHarassersMultishot"

tt = RT("ps_fury_run")

AC(tt, "pos", "particle_system")
tt.particle_system.anchor = v(0.5, 0.1)
tt.particle_system.animated = true
tt.particle_system.emission_rate = 10
tt.particle_system.loop = false
tt.particle_system.z = Z_DECALS + 1
tt.particle_system.name = "elite_harasser_trail"
tt.particle_system.particle_lifetime = {
	0.6,
	0.8
}

tt = E.register_t(E, "tower_orc_shaman", "tower")

E.add_comps(E, tt, "attacks", "powers")

tt.tower.type = "orc_shaman"
tt.tower.level = 1
tt.tower.price = 320
tt.info.fn = scripts.tower_mage.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "krv_portraits_") .. "0020"
tt.info.enc_icon = 93
tt.powers.meteor = E.clone_c(E, "power")
tt.powers.meteor.price_base = 180
tt.powers.meteor.price_inc = 180
tt.powers.meteor.enc_icon = 130
tt.powers.vines = E.clone_c(E, "power")
tt.powers.vines.price_base = 130
tt.powers.vines.price_inc = 130
tt.powers.vines.enc_icon = 129
tt.powers.shock = E.clone_c(E, "power")
tt.powers.shock.price_base = 180
tt.powers.shock.price_inc = 180
tt.powers.shock.enc_icon = 131
tt.main_script.insert = scripts4.tower_orc_shaman.insert
tt.main_script.update = scripts4.tower_orc_shaman.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_orc_shaman_base_0001"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_orc_shaman_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {
  idle = {
    "idle",
    "idle"
  },
  attack = {
    "attack",
    "attack"
  },
  meteor = {
    "meteor",
    "meteor"
  },
  vines = {
    "vines",
    "vines"
  },
}
tt.render.sprites[3].offset = v(0, 51)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].animated = true
tt.render.sprites[4].prefix = "tower_orc_shaman_fire"
tt.render.sprites[4].offset = v(32, 36)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].animated = true
tt.render.sprites[5].prefix = "tower_orc_shaman_fire"
tt.render.sprites[5].offset = v(30, 52)
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].animated = true
tt.render.sprites[6].prefix = "tower_orc_shaman_fire"
tt.render.sprites[6].offset = v(-30, 36)
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].animated = true
tt.render.sprites[7].prefix = "tower_orc_shaman_fire"
tt.render.sprites[7].offset = v(-29, 52)
tt.render.sprites[8] = E.clone_c(E, "sprite")
tt.render.sprites[8].animated = true
tt.render.sprites[8].prefix = "tower_orc_shaman"
tt.render.sprites[8].name = "idle"
tt.render.sprites[8].offset = v(0, 23)
tt.render.sprites[8].angles = {
  idle = {
    "idle",
    "idle"
  },
  attack = {
    "attack",
    "attack"
  },
  meteor = {
    "attack",
    "attack"
  },
  vines = {
    "attack",
    "attack"
  },
}
tt.attacks.range = 185
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "attack"
tt.attacks.list[1].bullet_start_offset = {
  v(13, 72),
  v(-9, 70)
}
tt.attacks.list[1].bullet = "bolt_orc_shaman"
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
tt.attacks.list[2].range = 140
tt.attacks.list[2].min_health = 0.5
tt.attacks.list[2].target_range = 60
tt.attacks.list[2].shoot_time = 0.266
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].vis_flags = bor(F_RANGED)
tt.attacks.list[3].vis_bans = bor(F_FLYING)
tt.attacks.list[3].animation = "meteor"
tt.attacks.list[3].bullet = "orc_shaman_meteor"
tt.attacks.list[3].cooldown = 20
tt.attacks.list[3].loops = 3
tt.attacks.list[3].loops_inc = 1
tt.attacks.list[3].target_range = 90
tt.attacks.list[3].shoot_time = 0.15
tt.attacks.list[3].bullet_start_offset = v(100, 200)
tt.attacks.list[3].min_spread = 40
tt.attacks.list[3].max_spread = 40
tt.sound_events.insert = "OrcShamanTaunt"

tt = E.register_t(E, "bolt_orc_shaman", "bolt")
tt.render.sprites[1].hidden = true
tt.bullet.mod = "mod_orc_shaman_stun"
tt.bullet.damage_min = 110
tt.bullet.damage_max = 160
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

tt = RT("mod_orc_shaman_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 0.666
tt.modifier.vis_bans = F_BOSS
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].prefix = "stun"
tt.render.sprites[1].name = "orc_shaman"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].size_names = {
	"orc_shaman",
	"orc_shaman",
	"orc_shaman"
}

tt = E.register_t(E, "fx_bolt_orc_shaman_hit", "fx")
tt.render.sprites[1].name = "orc_shaman_bolt"
tt.render.sprites[1].offset = v(-10, 50)

tt = E.register_t(E, "bolt_shock", "bullet")
tt.main_script.insert = scripts.bolt_blast.insert
tt.main_script.update = scripts4.bolt_shock.update
tt.render.sprites[1].prefix = "orc_shaman_aftershock"
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
tt.render.sprites[1].prefix = "orc_shaman_vines"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.sound_events.insert = "OrcShamanVines"

tt = E.register_t(E, "mod_orc_shaman_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 0
tt.hps.heal_max = 0
tt.hps.heal_inc = 1
tt.hps.heal_every = 0.1
tt.render.sprites[1].prefix = "orc_shaman_vines"
tt.render.sprites[1].size_names = {
	"heal",
	"heal",
	"heal"
}
tt.render.sprites[1].name = "heal"
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
tt.main_script.update = scripts3.bomb_kro.update
tt.bullet.hit_fx = "fx_explosion_meteor"
tt.render.sprites[1].name = "orc_shaman_meteor"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].offset = v(0, 40)
tt.sound_events.hit_water = nil
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = "OrcShamanMeteor"
tt.sound_events.hit = "OrcShamanMeteorHit"

tt = E:register_t("fx_explosion_meteor", "fx")

tt.render.sprites[1].prefix = "orc_shaman_meteor"
tt.render.sprites[1].name = "explosion"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].offset = v(0, -10)