-- chunkname: @./kr1/game_templates.lua

local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local E = require("entity_db")
local i18n = require("i18n")

require("constants")

local anchor_y = 0
local image_x, image_y, tt = 0
local scripts = require("game_scripts_v1")
--local scripts_c = require("game_scripts_conquest")
local scripts_c = require("game_scripts-v")
local mylua = require("my_lua")

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
---偷猎者箭塔
tt = RT("tower_build_archer_v", "tower_build")
tt.build_name = "tower_archer_1_v"
tt.render.sprites[2].name = "tower_archer_construct_0001"
tt.render.sprites[2].offset = v(0, 29)

tt = RT("tower_archer_1_v", "tower")

AC(tt, "attacks")

tt.tower.type = "archer_v"
tt.tower.level = 1
tt.tower.price = 70
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_" or "info_portraits_sc_") .. "0025"
tt.info.enc_icon = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_archer_1_base_0001"
tt.render.sprites[2].offset = v(0, 27)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_archer_1_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {}
tt.render.sprites[3].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[3].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[3].offset = v(9, 55)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "tower_archer_1_shooter"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].angles = {}
tt.render.sprites[4].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[4].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[4].offset = v(-9, 51)
tt.main_script.insert = scripts_c.tower_archer_v.insert
tt.main_script.update = scripts_c.tower_archer_v.update
tt.main_script.remove = scripts_c.tower_archer_v.remove
tt.attacks.range = 150
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "arrow_1_v"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(10, 54),
	v(-10, 54)
}
tt.sound_events.insert = "ArcherVTaunt"
tt.render.sid_tower = 2
tt.render.sids_shooter = {
	3,
	4
}

tt = RT("tower_archer_2_v", "tower_archer_1_v")
tt.info.enc_icon = 5
tt.tower.level = 2
tt.tower.price = 110
tt.render.sprites[2].name = "tower_archer_2_base_0001"
tt.render.sprites[3].prefix = "tower_archer_2_shooter"
tt.render.sprites[3].offset = v(14, 55)
tt.render.sprites[4].prefix = "tower_archer_2_shooter"
tt.render.sprites[4].offset = v(-4, 51)
tt.attacks.range = 170
tt.attacks.list[1].bullet = "arrow_2_v"
tt.attacks.list[1].cooldown = 0.6

tt = RT("tower_archer_3_v", "tower_archer_1_v")
tt.info.enc_icon = 9
tt.tower.level = 3
tt.tower.price = 150
tt.render.sprites[2].name = "tower_archer_3_base_0001"
tt.render.sprites[3].prefix = "tower_archer_3_shooter"
tt.render.sprites[3].offset = v(14, 58)
tt.render.sprites[4].prefix = "tower_archer_3_shooter"
tt.render.sprites[4].offset = v(-4, 54)
tt.attacks.range = 190
tt.attacks.list[1].bullet = "arrow_3_v"
tt.attacks.list[1].cooldown = 0.5
tt.attacks.list[1].bullet_start_offset = {
	v(10, 57),
	v(-10, 57)
}

tt = RT("arrow_1_v", "arrow")
tt.main_script.update = scripts_c.arrow_v.update
tt.bullet.armor_damage_max = 0.3
tt.bullet.armor_damage_inc = 0.05
tt.bullet.can_split = true
tt.bullet.damage_min = 3
tt.bullet.damage_max = 5
tt.bullet.seen_targets = {}
tt.bullet.pop_chance = 0.1
tt.bullet.pop = {
	"pop_shunt_violet"
}

tt = RT("arrow_2_v", "arrow_1_v")
tt.bullet.damage_min = 5
tt.bullet.damage_max = 10

tt = RT("arrow_3_v", "arrow_1_v")
tt.bullet.damage_min = 10
tt.bullet.damage_max = 15

tt = RT("tower_build_barrack_v", "tower_build_archer")
tt.build_name = "tower_barrack_1_v"
tt.render.sprites[2].name = "tower_barrack_construct_0001"
tt.render.sprites[2].offset = v(0, 33)

tt = RT("ps_dark_shard_trail", "particle_system")
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

tt = RT("fx_dark_shard_hit", "fx")

E:add_comps(tt, "sound_events")

tt.render.sprites[1].name = "bolt_magnus_hit"
tt.sound_events.insert = "DarkShardHit"

tt = RT("dark_shard", "arrow_1_v")
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.hit_fx = "fx_dark_shard_hit"
tt.bullet.g = 0
tt.bullet.flight_time = 0.2
tt.bullet.hit_blood_fx = nil
tt.bullet.particles_name = "ps_dark_shard_trail"
tt.render.sprites[1].name = "proy_dark_shard_0001"

---盗贼公会
tt = RT("tower_barrack_1_v", "tower")

AC(tt, "barrack")

tt.tower.type = "barrack_v"
tt.tower.level = 1
tt.tower.price = 70
tt.tower.menu_offset = v(0, 10)
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0019" or "info_portraits_sc_0019"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_barrack_1_base_0001"
tt.render.sprites[2].offset = v(-2, 33)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_barrack_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 13)
tt.barrack.soldier_type = "soldier_thug"
tt.barrack.rally_range = 145
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts_c.tower_barrack.insert
tt.main_script.update = scripts_c.tower_barrack.update
tt.main_script.remove = scripts_c.tower_barrack.remove
tt.sound_events.insert = "BarrackVTaunt"
tt.sound_events.change_rally_point = "BarrackVTaunt"

tt = RT("tower_barrack_2_v", "tower_barrack_1_v")
tt.info.enc_icon = 6
tt.tower.level = 2
tt.tower.price = 120
tt.barrack.rally_range = 150
tt.render.sprites[2].name = "tower_barrack_2_base_0001"
tt.render.sprites[3].prefix = "tower_barrack_door"
tt.barrack.soldier_type = "soldier_bandit"

tt = RT("tower_barrack_3_v", "tower_barrack_1_v")
tt.info.enc_icon = 10
tt.tower.level = 3
tt.tower.price = 170
tt.barrack.rally_range = 160
tt.render.sprites[2].name = "tower_barrack_3_base_0001"
tt.render.sprites[3].prefix = "tower_barrack_door"
tt.barrack.soldier_type = "soldier_brigand"

tt = RT("mod_life_drain_v", "modifier")

tt.heal_factor = 0.1
tt.heal_remove_modifiers = {}
tt.main_script.insert = scripts_c.mod_heal_on_damage.insert
tt.main_script.update = scripts_c.mod_heal_on_damage.update
tt.modifier.use_mod_offset = false

tt = E:register_t("soldier_thug", "soldier")

E:add_comps(tt, "melee", "pickpocket", "track_damage")

image_y = 52
anchor_y = 0.17
tt.health.dead_lifetime = 10
tt.health.hp_max = 60
tt.health_bar.offset = v(0, ady(38))
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.pickpocket.chance = 0
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.sound = "AssassinGold"
tt.pickpocket.steal_max = 1
tt.pickpocket.steal_min = 1
tt.track_damage.mod = "mod_life_drain_v"
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0027" or IS_KR1 and "info_portraits_enemies_0001" or "info_portraits_enemies_0001"
tt.info.random_name_count = 15
tt.info.random_name_format = "SOLDIER_V_RANDOM_%i_NAME"
tt.main_script.insert = scripts_c.soldier_barrack.insert
tt.main_script.remove = scripts_c.soldier_barrack.remove
tt.main_script.update = scripts_c.soldier_barrack.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 5
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, -3)
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].prefix = "enemy_desertthug"
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = IS_PHONE_OR_TABLET and r(-20, -5, 40, 40) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))

tt = E:register_t("soldier_bandit", "soldier_thug")

E:add_comps(tt, "dodge")

tt.dodge.chance = 0.25
tt.dodge.silent = true
tt.dodge.pop = {
	"pop_miss_v"
}
tt.dodge.pop_offset = 40
tt.health_bar.offset = v(0, 30)
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0008" or IS_KR1 and "info_portraits_sc_0008" or "info_portraits_sc_0008"
tt.render.sprites[1].prefix = "enemy_bandit"
tt.health.hp_max = 94
tt.health.armor = 0
tt.regen.health = 7
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.range = 60

tt = E:register_t("soldier_brigand", "soldier_thug")

tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0018" or IS_KR1 and "info_portraits_sc_0018" or "info_portraits_sc_0018"
tt.render.sprites[1].prefix = "enemy_brigand"
tt.regen.health = 10
tt.health.hp_max = 160
tt.health.armor = 0.3
tt.health_bar.offset = v(0, 31)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 60

tt = RT("tower_build_mage_v", "tower_build_archer")
tt.build_name = "tower_mage_1_v"
tt.render.sprites[2].name = "tower_mage_construct"
tt.render.sprites[2].offset = v(0, 30)
---恶魔法师

tt = RT("mod_slow_curse_v", "mod_slow")
tt.main_script.insert = scripts_c.mod_slow_curse.insert
tt.modifier.excluded_templates = {
	"enemy_demon_cerberus"
}

tt = RT("mod_v_shatter", "mod_damage")
tt.damage_min = 0.1
tt.damage_max = 0.1
tt.damage_type = bor(DAMAGE_MAGICAL_ARMOR, DAMAGE_NO_SHIELD_HIT)

tt = E.register_t(E, "pop_crit_v", "pop")
tt.render.sprites[1].name = "elven_pops_0024"

tt = E:register_t("mage_slow_aura_v", "aura")

tt.main_script.insert = scripts_c.aura_apply_mod.insert
tt.main_script.update = scripts_c.aura_apply_mod.update
tt.aura.mod = "mod_slow_v"
tt.aura.cycle_time = fts(10)
tt.aura.duration = -1
tt.aura.radius = nil
tt.aura.vis_flags = F_MOD
tt.aura.vis_bans = F_FRIEND

tt = RT("mod_slow_v", "mod_slow")
tt.modifier.duration = 1
tt.modifier.duplicates_by_id = true
tt.slow.factor = 0.95

tt = RT("tower_mage_1_v", "tower")

AC(tt, "attacks", "auras")

tt.tower.type = "mage_v"
tt.tower.level = 1
tt.tower.price = 100
tt.tower.menu_offset = v(0, 10)
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "slow_aura_v"
tt.auras.list[1].cooldown = 0
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0049" or "info_portraits_sc_0049"
tt.info.enc_icon = 3
tt.auras = {}
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.remove = scripts_c.tower_mage_v.remove
tt.main_script.insert = scripts_c.tower_mage_v.insert
tt.main_script.update = scripts_c.tower_mage_v.update
tt.attacks.range = 140
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_1_v"
tt.attacks.list[1].cooldown = 1 + fts(20)
tt.attacks.list[1].shoot_time = fts(15)
tt.attacks.list[1].bullet_start_offset = {
	v(6, 63),
	v(-7, 63)
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "tower_mage_1_v"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_mage_1_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {}
tt.render.sprites[3].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[3].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[3].offset = v(0, 50)
tt.render.sid_tower = 2
tt.render.sid_shooter = 3
tt.sound_events.insert = "MageVTaunt"

tt = RT("tower_mage_2_v", "tower_mage_1_v")
tt.info.enc_icon = 7
tt.tower.level = 2
tt.tower.price = 160
tt.attacks.range = 160
tt.attacks.list[1].bullet = "bolt_2_v"
tt.attacks.list[1].bullet_start_offset = {
	v(6, 66),
	v(-7, 66)
}
tt.render.sprites[2].prefix = "tower_mage_2_v"
tt.render.sprites[3].prefix = "tower_mage_2_shooter"
tt.render.sprites[3].scale = v(0.7, 0.7)
tt.render.sprites[3].offset = v(0, 53)

tt = RT("tower_mage_3_v", "tower_mage_1_v")
tt.info.enc_icon = 11
tt.tower.level = 3
tt.tower.price = 220
tt.attacks.range = 180
tt.attacks.list[1].bullet = "bolt_3_v"
tt.attacks.list[1].bullet_start_offset = {
	v(6, 69),
	v(-7, 69)
}
tt.render.sprites[2].prefix = "tower_mage_3_v"
tt.render.sprites[3].prefix = "tower_mage_3_shooter"
tt.render.sprites[3].offset = v(0, 56)

tt = RT("bolt_1_v", "bolt")
tt.bullet.damage_min = 7
tt.bullet.damage_max = 15
tt.bullet.hit_fx = "fx_bolt_infernal_mage_hit_v"
tt.bullet.max_speed = 300
tt.bullet.pop_chance = 0.1
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.bullet.particles_name = "ps_bolt_infernal_mage_v"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.sound_events.insert = "MageVAttack"

tt = RT("bolt_2_v", "bolt_1_v")
tt.bullet.damage_min = 15
tt.bullet.damage_max = 30

tt = RT("bolt_3_v", "bolt_1_v")
tt.bullet.damage_min = 30
tt.bullet.damage_max = 75

tt = RT("ps_bolt_infernal_mage_v", "particle_system")
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

tt = RT("fx_bolt_infernal_mage_hit_v", "fx")
tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.render.sprites[1].name = "explosion"

tt = RT("tower_build_engineer_v", "tower_build_archer")
tt.build_name = "tower_artillery_1"
tt.render.sprites[2].name = "tower_artillery_construct"
tt.render.sprites[2].offset = v(0, 30)
---哥布林投弹手
tt = RT("tower_artillery_1", "tower")

AC(tt, "attacks")

tt.tower.type = "artillery"
tt.tower.level = 1
tt.tower.price = 125
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0061" or "info_portraits_sc_0061"
tt.info.enc_icon = 4
tt.main_script.insert = scripts_c.tower_artillery.insert
tt.main_script.update = scripts_c.tower_artillery.update
tt.attacks.range = 165
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bomb_v"
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].cooldown = 1.8
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 50),
	v(0, 50)
}
tt.attacks.list[1].node_prediction = true
tt.render.sid_shooter = 3
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "tower_artillery_1_base_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_artillery_1_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {}
tt.render.sprites[3].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[3].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[3].offset = v(0, 46)
tt.sound_events.insert = "ArtilleryTaunt"
tt.render.sid_tower = 2
tt.render.sid_shooter = 3

tt = RT("tower_artillery_2", "tower_artillery_1")
tt.info.enc_icon = 8
tt.tower.level = 2
tt.tower.price = 225
tt.attacks.range = 175
tt.attacks.list[1].bullet = "bomb_dynamite_v"
tt.attacks.list[1].cooldown = 1.6
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 53),
	v(0, 53)
}
tt.render.sprites[2].name = "tower_artillery_2_base_0001"
tt.render.sprites[3].prefix = "tower_artillery_2_shooter"
tt.render.sprites[3].offset = v(0, 53)

tt = RT("tower_artillery_3", "tower_artillery_1")
tt.info.enc_icon = 12
tt.tower.level = 3
tt.tower.price = 325
tt.attacks.range = 185
tt.attacks.list[1].bullet = "bomb_black_v"
tt.attacks.list[1].cooldown = 1.4
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 57),
	v(0, 57)
}
tt.render.sprites[2].name = "tower_artillery_3_base_0001"
tt.render.sprites[3].prefix = "tower_artillery_3_shooter"
tt.render.sprites[3].offset = v(0, 64)

tt= E:register_t("bomb_v", "bullet")

E:add_comps(tt, "sound_events")

tt.bullet.flight_time = fts(25)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 4
tt.bullet.damage_max = 7
tt.bullet.damage_radius = 65.5
tt.bullet.can_do_mini = true
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "bombs_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.main_script.insert = scripts_c.bomb.insert
tt.main_script.update = scripts_c.bomb_v.update
tt.sound_events.insert = "AxeSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"

tt = E:register_t("bomb_dynamite_v", "bomb_v")

tt.render.sprites[1].name = "v_artillery_2_bomb_0001"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.bullet.damage_min = 10
tt.bullet.damage_max = 20
tt.bullet.damage_radius = 66.5

tt = E:register_t("bomb_black_v", "bomb_v")

tt.render.sprites[1].name = "zapperbomb"
tt.render.sprites[1].scale = v(1, 1)
tt.bullet.damage_min = 15
tt.bullet.damage_max = 30
tt.bullet.damage_radius = 67.5

tt = E:register_t("fx_explosion_tiny", "fx")

tt.render.sprites[1].prefix = "explosion"
tt.render.sprites[1].name = "fragment"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].scale = v(0.5, 0.5)

---蜥蜴人狙击塔
tt = RT("tower_deathcoil", "tower")

AC(tt, "attacks", "powers")

image_y = 0
tt.tower.type = "deathcoil"
tt.tower.level = 1
tt.tower.price = 240
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = IS_PHONE_OR_TABLET and "info_portraits_enemies_0041" or "info_portraits_enemies_0041"
tt.info.enc_icon = 1
tt.info.fn = scripts_c.tower_deathcoil.get_info
tt.powers.charged = E:clone_c("power")
tt.powers.charged.price_base = 300
tt.powers.charged.price_inc = 200
tt.powers.charged.enc_icon = 8
tt.powers.charged.id = 1
tt.powers.charged.charged_damage = 0
tt.powers.charged.factor = {
	1,
	1.5,
	2
}
tt.powers.stun = E:clone_c("power")
tt.powers.stun.price_base = 200
tt.powers.stun.price_inc = 160
tt.powers.stun.id = 2
tt.powers.stun.enc_icon = 9
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_deathcoil_base_0001"
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[2].scale = v(1.1, 1.1)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].random_ts = fts(10)
tt.render.sprites[3].loop = true
tt.render.sprites[3].prefix = "tower_deathcoil_base"
tt.render.sprites[3].name = "flash"
tt.render.sprites[3].animated = true
tt.render.sprites[3].offset = v(-1, 82)
tt.render.sprites[3].scale = v(1.1, 1.1)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].random_ts = fts(7)
tt.render.sprites[4].loop = true
tt.render.sprites[4].amimated = true
tt.render.sprites[4].prefix = "tower_deathcoil_base"
tt.render.sprites[4].name = "flash"
tt.render.sprites[4].offset = v(22, 50)
tt.render.sprites[4].scale = v(1.1, 1.1)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "enemy_sniper"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].scale = v(0.85, 0.85)
tt.render.sprites[5].angles = {}
tt.render.sprites[5].angles.idle = {
	"idle",
	"idle",
	"idle"
}
tt.render.sprites[5].angles.shoot_start = {
	"ranged_start_side",
	"ranged_start_up",
	"ranged_start_down"
}
tt.render.sprites[5].angles.shoot_loop = {
	"ranged_loop_side",
	"ranged_loop_up",
	"ranged_loop_down"
}
tt.render.sprites[5].angles.shoot_end = {
	"ranged_end_side",
	"ranged_end_up",
	"ranged_end_down"
}
tt.render.sprites[5].angles.shoot_aim = {
	"ranged_aim_side",
	"ranged_aim_up",
	"ranged_aim_down"
}
tt.render.sprites[5].angles_flip_vertical = {
	shoot_start = true,
	shoot_loop = true,
	shoot_end = true,
	shoot_aim = true
}
tt.render.sprites[5].angles_custom = {
	ranged = {
		35,
		145,
		210,
		335
	}
}
tt.render.sprites[5].offset = v(0, 71)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].loop = true
tt.render.sprites[6].amimated = true
tt.render.sprites[6].prefix = "tower_deathcoil_base"
tt.render.sprites[6].name = "charged"
tt.render.sprites[6].hidden = true
tt.render.sprites[6].offset = v(0, 37)
tt.render.sprites[6].scale = v(1.1, 1.1)
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].loop = true
tt.render.sprites[7].amimated = true
tt.render.sprites[7].prefix = "tower_deathcoil_shooter"
tt.render.sprites[7].name = "fx"
tt.render.sprites[7].hidden = true
tt.render.sprites[7].offset = v(0, 71)
tt.render.sprites[7].scale = v(1.1, 1.1)
tt.main_script.insert = scripts_c.tower_archer_v.insert
tt.main_script.update = scripts_c.tower_deathcoil.update
tt.main_script.remove = scripts_c.tower_deathcoil.remove
tt.attacks.range = 400
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bolt_sniper_deathcoil"
tt.attacks.list[1].cooldown = 2
tt.attacks.list[1].crosshair_name = "mod_deathcoil_crosshair"
tt.attacks.list[1].ray = "ray_deathcoil"
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].charge_tick = fts(10)
tt.attacks.list[1].bullet_start_offset = {
	v(6, ady(70)),
	v(8, ady(76)),
	v(3, ady(67)),
	v(-6, ady(70)),
	v(-8, ady(76)),
	v(-3, ady(67))	
}
--[[
tt.attacks.list[1].bullet_start_offset = {
	v(6, ady(104)),
	v(8, ady(110)),
	v(3, ady(101)),
	v(-6, ady(104)),
	v(-8, ady(110)),
	v(-3, ady(101))

	v(6, ady(79)),
	v(10, ady(85)),
	v(3, ady(76)),
	v(-6, ady(79)),
	v(-10, ady(85)),
	v(-3, ady(76))	
}
]]--
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].bullet = "bolt_sniper_stun"
tt.attacks.list[2].cooldown = 20
tt.attacks.list[2].shoot_time = fts(5)
tt.attacks.list[2].aim_time = 1
tt.attacks.list[2].vis_flags = 0--bor(F_MOD, F_STUN)
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING)
tt.attacks.list[2].bullet_start_offset = {
	v(6, ady(70)),
	v(8, ady(76)),
	v(3, ady(67)),
	v(-6, ady(70)),
	v(-8, ady(76)),
	v(-3, ady(67))		
}
tt.sound_events.insert = "TowerDeathcoilTaunt"
tt.tower.long_idle_cooldown = 3
tt.render.sid_tower = 2
tt.render.sid_shooter = 5

tt = E.register_t(E, "mod_deathcoil_crosshair", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].prefix = "tower_deathcoil_crosshair"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.render.sprites[1].loop = false
tt.finished = nil
tt.modifier.duration = -1
tt.main_script.update = scripts_c.mod_deathcoil_crosshair.update

tt = E:register_t("bolt_sniper_deathcoil", "bolt")
tt.bullet.armor_damage_max = 0.3
tt.bullet.armor_damage_inc = 0.05
tt.bullet.can_split = true
tt.bullet.seen_targets = {}
tt.render.sprites[1].prefix = "bolt_sniper_deathcoil"
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 100 * 2
tt.bullet.damage_min = 44 * 2
tt.bullet.max_speed = 30 * FPS
tt.bullet.hit_fx = "fx_deathcoil_hit"
tt.main_script.update = scripts_c.bolt_deathcoil.update
tt.bullet.damage_type = bor(DAMAGE_TRUE)--bor(DAMAGE_PHYSICAL)
tt.bullet.max_track_distance = 50
tt.sound_events.insert = "SaurianSniperBullet"

tt = E:register_t("bolt_sniper_stun", "bolt")
tt.bullet.armor_damage_max = 0
tt.bullet.armor_damage_inc = 0
tt.bullet.can_split = nil
tt.bullet.seen_targets = {}
tt.render.sprites[1].prefix = "tower_deathcoil_proj_stun"
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 0 + 200
tt.bullet.damage_min = 0 + 88
tt.bullet.mod = "mod_deathcoil_stun"
tt.bullet.max_speed = 30 * FPS
tt.bullet.hit_fx = "fx_deathcoil_charged_hit"
tt.bullet.miss_decal = nil
tt.main_script.update = scripts_c.bolt_deathcoil.update
tt.bullet.damage_type = bor(DAMAGE_TRUE)--bor(DAMAGE_NONE)
tt.bullet.max_track_distance = 50
tt.sound_events.insert = "SaurianSniperStunBullet"

tt = RT("mod_deathcoil_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 4
tt.modifier.vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING)
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.range = 150
tt.ray_id = nil
tt.bind_id = nil
tt.modifier.ray = "ray_deathcoil_stun"
tt.modifier.bind = "deathcoil_bind"
tt.duplicate = nil
tt.main_script.insert = scripts_c.mod_deathcoil_stun.insert
tt.main_script.update = scripts_c.mod_deathcoil_stun.update
tt.main_script.remove = scripts_c.mod_deathcoil_stun.remove
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].prefix = "tower_deathcoil_proj_stun_fx"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.15),
	vv(1.25)
}
tt.modifier.use_mod_offset = true

tt = RT("ray_deathcoil_stun", "bullet")
tt.bullet.damage_type = bor(DAMAGE_NONE)
tt.bullet.hit_time = 10--fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.ignore_hit_offset = nil
tt.image_width = 80
tt.main_script.update = scripts_c.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "tower_deathcoil_stun_ray"
tt.render.sprites[1].loop = true
tt.sound_events.insert = nil
tt.track_target = true
tt.looping = true
tt.bullet.max_track_distance = 1e+99
tt.ray_duration = nil

tt = E:register_t("deathcoil_bind", "bullet")
tt.main_script.update = scripts_c.deathcoil_bind.update
tt.bullet.particles_name = nil
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 300
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.damage_min = 5
tt.bullet.damage_max = 5
tt.bullet.damage_every = 0.2
tt.radius = 30
tt.bullet.max_speed = 300
tt.bullet.damage_type = DAMAGE_TRUE
tt.bounces_max = 1e+99
tt.bounce_range = 150
tt.render.sprites[1].prefix = "tower_deathcoil_proj_stun"
tt.render.sprites[1].hidden = true
tt.sound_events.insert = nil
tt.sound_events.bounce = nil

tt = RT("fx_deathcoil_hit", "fx")
tt.render.sprites[1].name = "bolt_sniper_hit"

tt = RT("fx_deathcoil_charged_hit", "fx")
tt.render.sprites[1].name = "tower_deathcoil_charged_hit"

tt = RT("ray_deathcoil", "bullet")
tt.bullet.damage_type = bor(DAMAGE_NONE)
tt.bullet.hit_time = 10--fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.image_width = 60
tt.main_script.update = scripts_c.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "tower_deathcoil_aim_ray"
tt.render.sprites[1].loop = true
tt.sound_events.insert = nil
tt.track_target = true
tt.looping = true
tt.bullet.max_track_distance = 1e+99
tt.ray_duration = nil
---腐毒菇林
tt = RT("tower_rotshroom", "tower")

AC(tt, "attacks", "powers", "auras")

tt.tower.type = "rotshroom"
tt.tower.level = 1
tt.tower.price = 345
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = IS_PHONE_OR_TABLET and "info_portraits_sc_0082" or "info_portraits_sc_0082"
tt.info.enc_icon = 2
tt.info.fn = scripts_c.tower_rotshroom.get_info
tt.main_script.insert = scripts_c.tower_rotshroom.insert
tt.main_script.update = scripts_c.tower_rotshroom.update
tt.main_script.remove = scripts_c.tower_rotshroom.remove
tt.powers.rot = E:clone_c("power")
tt.powers.rot.price_base = 200
tt.powers.rot.price_inc = 180
tt.powers.rot.id = 1
tt.powers.rot.enc_icon = 6
tt.powers.rot.damage_min = {
	5,
	10,
	15
}
tt.powers.rot.damage_max = {
	14,
	18,
	22
}
tt.powers.punch = E:clone_c("power")
tt.powers.punch.price_base = 240
tt.powers.punch.price_inc = 180
tt.powers.punch.id = 2
tt.powers.punch.enc_icon = 7
tt.powers.punch.offsets = {
	v(36, 25),
	v(-33, 25),
	v(40, 25),
	v(-37, 25),
}
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "rotshroom_aura"
tt.auras.list[1].cooldown = 0
tt.attacks.range = 165
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].mine = "decal_rotshroom_mine"
tt.attacks.list[1].offset_min = -7
tt.attacks.list[1].offset_max = 7
tt.attacks.list[1].count = 3
tt.attacks.list[1].max_count = 12
tt.attacks.list[1].interval = 0.5
tt.attacks.list[1].shrooms = {}
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].cooldown = 5
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[2] = E:clone_c("custom_attack")
tt.attacks.list[2].animation = "punch"
tt.attacks.list[2].cooldown = 30
tt.attacks.list[2].damage_min = 0
tt.attacks.list[2].damage_max = 50
tt.attacks.list[2].damage_inc = 50
tt.attacks.list[2].damage_type = DAMAGE_PHYSICAL
tt.attacks.list[2].mod_throw = "mod_rotshroom_throw"
tt.attacks.list[2].mod_kill = "mod_rotshroom_kill"
tt.attacks.list[2].shoot_time = fts(50)
tt.attacks.list[2].node_offset = -20
tt.attacks.list[2].disabled = true
tt.attacks.list[2].sound = "RotshroomPunch"
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_FLYING, F_MINIBOSS)
tt.attacks.list[2].vis_flags = bor(F_STUN)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "tower_rotshroom_layer_1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 42)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_rotshroom_layer_2"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(2, 24)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "tower_rotshroom_layer_3"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(0, 30)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "tower_rotshroom_layer_4"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(0, 20)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "tower_rotshroom_layer_5"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].offset = v(0, 30)
tt.render.sprites[6].scale = v(1.2, 1.2)
tt.sound_events.insert = "TowerRotshroomTaunt"
tt.tower.long_idle_cooldown = 3
tt.tower.long_idle_cooldown_secondary = 6

tt = E.register_t(E, "rotshroom_aura", "aura")
tt.main_script.update = scripts_c.rotshroom_aura.update
tt.aura.cycle_time = 0.5
tt.aura.duration = -1
tt.mini_shrooms = {}

tt = RT("mod_rotshroom_kill", "modifier")
tt.main_script.update = scripts_c.mod_rotshroom_kill.update

tt = RT("mod_rotshroom_throw", "modifier")
tt.main_script.update = scripts_c.mod_rotshroom_throw.update
tt.modifier.mod = "mod_rotshroom_stun"
tt.modifier.bans = {
	"mod_slow",
	"mod_goblin_leap_slow",
	"mod_slow_v"
}
tt.modifier.remove_banned = true

tt = RT("mod_rotshroom_stun", "mod_stun")

tt.modifier.use_mod_offset = true
tt.modifier.duration = 2
tt.modifier.vis_bans = bor(F_BOSS)

tt= E:register_t("bullet_rotshroom_throw", "bullet")

E:add_comps(tt, "sound_events")

tt.bullet.flight_time = fts(25)
tt.bullet.rotation_speed = 30 * FPS * math.pi / 180
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = nil
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.damage_small = 40
tt.bullet.damage_big = 80
tt.bullet.big = nil
tt.bullet.damage_radius_big = 60
tt.bullet.damage_radius_small = 40
tt.bullet.pop = nil
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.bullet.arrived = nil
tt.main_script.insert = scripts_c.bomb.insert
tt.main_script.update = scripts_c.bullet_rotshroom_throw.update
tt.sound_events.insert = "AxeSound"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil

tt= E:register_t("bullet_rotshroom_kill", "bullet")

E:add_comps(tt, "sound_events", "tween")

tt.bullet.flight_time = fts(25)
tt.bullet.g = -2 / (fts(1) * fts(1))
tt.bullet.rotation_speed = 30 * FPS * math.pi / 180
tt.bullet.hit_fx = nil
tt.bullet.hit_decal =  nil
tt.bullet.hit_fx_water = nil
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_radius = 0
tt.bullet.pop = nil
tt.bullet.damage_flags = F_NONE
tt.bullet.hide_radius = 8
tt.bullet.arrived = nil
tt.tween.run_once = true
tt.tween.props[1].name = "alpha"
tt.tween.props[1].loop = false
tt.tween.props[1].keys = {
	{
		fts(0),
		255
	},
	{
		fts(5),
		255
	},
	{
		fts(10),
		0
	}
}
tt.bullet.can_do_mini = nil
tt.main_script.insert = scripts_c.bomb.insert
tt.main_script.update = scripts_c.bomb_v.update
tt.sound_events.insert = "AxeSound"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil

tt = RT("decal_rotshroom_mine", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.check_interval = fts(3)
tt.damage_max = 45
tt.damage_min = 30
tt.damage_type = DAMAGE_PHYSICAL
tt.duration = 1e+99
tt.hit_decal = nil
tt.mod = "mod_rotshroom_poison"
tt.hit_fx = "fx_explosion_shroom"
tt.main_script.update = scripts_c.decal_rotshroom_mine.update
tt.damage_radius = 47
tt.radius = 32
tt.render.sprites[1].loop = false
tt.render.sprites[1].prefix = "mushroom_mine"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[1].z = Z_OBJECTS
tt.sound = "EnemyMushroomDeath"
tt.sound_events.insert = "EnemyMushroomBorn"
tt.vis_bans = bor(F_FRIEND, F_FLYING)
tt.vis_bans2 = bor(F_FRIEND)
tt.vis_flags = bor(F_ENEMY)

tt = RT("decal_rotshroom_mine_mini", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.check_interval = fts(3)
tt.damage_max = 23
tt.damage_min = 15
tt.damage_type = DAMAGE_PHYSICAL
tt.duration = 1e+99
tt.hit_decal = nil
tt.mod = "mod_rotshroom_poison"
tt.hit_fx = "fx_explosion_shroom"
tt.main_script.update = scripts_c.decal_rotshroom_mine.update
tt.damage_radius = 37
tt.radius = 22
tt.render.sprites[1].loop = false
tt.render.sprites[1].prefix = "mushroom_mine_small"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[1].z = Z_OBJECTS
tt.sound = "EnemyMushroomDeath"
tt.sound_events.insert = "EnemyMushroomBorn"
tt.vis_bans = bor(F_FRIEND, F_FLYING)
tt.vis_bans2 = bor(F_FRIEND)
tt.vis_flags = bor(F_ENEMY)

tt = E:register_t("mod_rotshroom_poison", "mod_poison")
tt.dps.damage_every = fts(8)
tt.dps.damage_max = 1
tt.dps.damage_min = 1
tt.modifier.duration = 2
tt.modifier.use_mod_offset = true
tt.render.sprites[1].prefix = "poison_violet"
tt.render.sprites[1].size_names = {
	"small",
	"small",
	"small"
}
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.25),
	vv(1.5)
}

tt = E:register_t("fx_explosion_shroom", "fx")

tt.render.sprites[1].prefix = "mushroom_mine"
tt.render.sprites[1].name = "explode"
tt.render.sprites[1].z = Z_OBJECTS
---红帽地精
tt = RT("tower_redcap", "tower")

AC(tt, "barrack", "powers")

tt.tower.type = "redcap"
tt.tower.level = 1
tt.tower.price = 230
tt.tower.menu_offset = v(0, 10)
tt.powers.reap = E:clone_c("power")
tt.powers.reap.price_base = 300
tt.powers.reap.price_inc = 200
tt.powers.reap.id = 1
tt.powers.reap.max_level = 2
tt.powers.reap.enc_icon = 5
tt.powers.dodge = E:clone_c("power")
tt.powers.dodge.price_base = 150
tt.powers.dodge.price_inc = 150
tt.powers.dodge.id = 2
tt.powers.dodge.enc_icon = 16
tt.powers.harvest = E:clone_c("power")
tt.powers.harvest.price_base = 150
tt.powers.harvest.price_inc = 150
tt.powers.harvest.id = 3
tt.powers.harvest.enc_icon = 15
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0024" or "portraits_sc_0024"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_redcap_base_0001"
tt.render.sprites[2].offset = v(-2, 36)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_redcap_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(-1, 12)
tt.barrack.soldier_type = "soldier_redcap"
tt.barrack.rally_range = 160
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts_c.tower_barrack.insert
tt.main_script.update = scripts_c.tower_barrack.update
tt.main_script.remove = scripts_c.tower_barrack.remove
tt.sound_events.insert = "TowerRedcapTaunt"
tt.sound_events.change_rally_point = "TowerRedcapTaunt"

tt = E:register_t("soldier_redcap", "soldier_thug")

E:add_comps(tt, "melee", "pickpocket", "track_damage", "dodge", "powers")

tt.dodge.chance = 0.3
tt.dodge.chance_inc = 0.1
tt.dodge.power_name = "dodge"
tt.dodge.silent = true
tt.dodge.ranged = true
tt.dodge.pop = {
	"pop_miss_v"
}
tt.dodge.pop_offset = 40
image_y = 52
anchor_y = 0.17
tt.powers.dodge = E:clone_c("power")
tt.powers.reap = E:clone_c("power")
tt.powers.harvest = E:clone_c("power")
tt.powers.harvest.mod = "mod_redcap_heal_v"
tt.health.dead_lifetime = 10
tt.health.hp_max = 200
tt.health_bar.offset = v(0, 28)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.pickpocket.chance = 0
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.sound = "AssassinGold"
tt.pickpocket.steal_max = 1
tt.pickpocket.steal_min = 1
tt.track_damage.mod = "mod_life_drain_v"
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0024" or IS_KR1 and "portraits_sc_0024" or "portraits_sc_0024"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_REDCAP_RANDOM_%i_NAME"
tt.main_script.insert = scripts_c.soldier_barrack.insert
tt.main_script.remove = scripts_c.soldier_barrack.remove
tt.main_script.update = scripts_c.soldier_redcap.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].order_id = 3
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].pop = {
	"pop_bladesinger_v"
}
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].animation = "special"
tt.melee.attacks[2].power_name = "reap"
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].max_chance = 0.5--0.1
tt.melee.attacks[2].level = 0
tt.melee.attacks[2].pop = {
	"pop_splat"
}
tt.melee.attacks[2].pop_chance = 1
tt.melee.attacks[2].hit_fx = "fx_redcap_death_blow_v"
tt.melee.attacks[2].use_target_pos = true
tt.melee.attacks[2].flip_fx = true
tt.melee.attacks[2].percentage = 5
tt.melee.attacks[2].vis_bans = bor(F_CLIFF, F_BOSS, F_MINIBOSS)
tt.melee.attacks[2].order_id = 2
tt.melee.attacks[2].fn_can = function(t, s, a, target)
	return band(target.vis.flags, a.vis_bans) == 0
end
tt.melee.attacks[2].fn_chance =  scripts_c.soldier_redcap.fn_chance_instakill
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].hit_offset = v(24, 10)
tt.melee.attacks[2].instakill = true
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[2])
tt.melee.attacks[3].damage_max = 100
tt.melee.attacks[3].damage_min = 100
tt.melee.attacks[3].order_id = 1
tt.melee.attacks[3].level = 0
tt.melee.attacks[3].hit_fx = "fx_redcap_death_blow_v"
tt.melee.attacks[3].use_target_pos = true
tt.melee.attacks[3].flip_fx = true
tt.melee.attacks[3].damage_type = DAMAGE_TRUE
tt.melee.attacks[3].power_name = "reap"
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].flags = bor(F_BOSS, F_MINIBOSS)
tt.melee.attacks[3].vis_bans = F_CLIFF
tt.melee.attacks[3].fn_can = function(t, s, a, target)
	return band(target.vis.flags, a.flags) ~= 0
end
tt.melee.attacks[3].fn_chance =  scripts_c.soldier_redcap.fn_chance_antiboss
tt.melee.attacks[3].instakill = nil
tt.melee.cooldown = 1.2
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 25
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].anchor = v(0.5, 0.20833333333333334)
tt.render.sprites[1].prefix = "redcap"
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = IS_PHONE_OR_TABLET and r(-20, -5, 40, 40) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 10)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 12)

tt = E:register_t("fx_redcap_death_blow_v", "fx")
tt.render.sprites[1].name = "fx_redcap_death_blow"
tt.render.sprites[1].z = Z_EFFECTS

tt = E:register_t("mod_redcap_heal_v", "modifier")

E:add_comps(tt, "hps", "render")

tt.main_script.insert = scripts_c.mod_redcap_heal.insert
tt.main_script.update = scripts_c.mod_hps.update
tt.hps.heal_min = 25
tt.hps.heal_max = 25
tt.hps.heal_every = fts(30)
tt.modifier.duration = 0
tt.modifier.duration_inc = 2
tt.modifier.keep_on_max = true
tt.render.sprites[1].name = "fx_twilight_heretic_consume"
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].loop = true

tt = E:register_t("pop_miss_v", "pop")
tt.render.sprites[1].name = "pop_conquest_0001"
tt.pop_y_offset = 40

tt = E:register_t("pop_bladesinger_v", "pop")
tt.render.sprites[1].name = "elven_pops_0014"
---哥布林萨满
tt = RT("tower_shaman", "tower")

AC(tt, "attacks", "auras", "powers")

tt.tower.type = "shaman"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.menu_offset = v(0, 10)
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "slow_aura_v"
tt.auras.list[1].cooldown = 0
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0009" or "info_portraits_sc_0009"
tt.info.enc_icon = 3
tt.auras = {}
tt.powers.healing = E:clone_c("power")
tt.powers.healing.price_base = 180
tt.powers.healing.price_inc = 150
tt.powers.healing.id = 1
tt.powers.healing.enc_icon = 1
tt.powers.speed = E:clone_c("power")
tt.powers.speed.price_base = 250
tt.powers.speed.price_inc = 220
tt.powers.speed.id = 2
tt.powers.speed.enc_icon = 2
tt.info.fn = scripts_c.tower_shaman.get_info
tt.main_script.remove = scripts_c.tower_mage_v.remove
tt.main_script.insert = scripts_c.tower_mage_v.insert
tt.main_script.update = scripts_c.tower_shaman.update
tt.attacks.range = 200
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "aura_shaman_damage"
tt.attacks.list[1].cooldown = 12
tt.attacks.list[1].spawn_offset_nodes = 5
tt.attacks.list[1].shoot_time = fts(14)
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].bullet = "aura_shaman_healing"
tt.attacks.list[2].cooldown = 12
tt.attacks.list[2].animation = "heal"
tt.attacks.list[2].disabled = true
tt.attacks.list[2].threshold = 0.75
tt.attacks.list[2].shoot_time = fts(14)
tt.attacks.list[3] = E:clone_c("bullet_attack")
tt.attacks.list[3].bullet = "aura_shaman_speed"
tt.attacks.list[3].disabled = true
tt.attacks.list[3].animation = "buff"
tt.attacks.list[3].cooldown = 12
tt.attacks.list[3].max_range = 200
tt.attacks.list[3].shoot_time = fts(14)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "tower_shaman_base_0001"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[2].animated = false
tt.render.sprites[2].scale = v(1.1, 1.1)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].prefix = "tower_shaman_layer2"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 30)
tt.render.sprites[3].scale = v(1.1, 1.1)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].hidden = true
tt.render.sprites[4].loop = false
tt.render.sprites[4].prefix = "tower_shaman_layer3"
tt.render.sprites[4].name = "light"
tt.render.sprites[4].offset = v(-37, 19)
tt.render.sprites[4].scale = v(1.1, 1.1)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "tower_shaman_layer4"
tt.render.sprites[5].name = "light"
tt.render.sprites[5].hidden = true
tt.render.sprites[5].loop = false
tt.render.sprites[5].offset = v(35, 21)
tt.render.sprites[5].scale = v(1.1, 1.1)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "enemy_shaman"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].angles = {}
tt.render.sprites[6].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[6].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[6].offset = v(0, 60)
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].prefix = "tower_shaman_fire"
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].loop = true
tt.render.sprites[7].offset = v(30, 39)
tt.render.sprites[7].random_ts = fts(1)
tt.render.sprites[7].ignore_start = true
tt.render.sprites[7].scale = v(1.1, 1.1)
tt.render.sprites[8] = E:clone_c("sprite")
tt.render.sprites[8].prefix = "tower_shaman_fire"
tt.render.sprites[8].name = "idle"
tt.render.sprites[8].loop = true
tt.render.sprites[8].offset = v(22, 60)
tt.render.sprites[8].random_ts = fts(7)
tt.render.sprites[8].scale = v(1.1, 1.1)
tt.render.sprites[8].ignore_start = true
tt.render.sprites[9] = E:clone_c("sprite")
tt.render.sprites[9].prefix = "tower_shaman_fire"
tt.render.sprites[9].name = "idle"
tt.render.sprites[9].loop = true
tt.render.sprites[9].offset = v(-28, 38)
tt.render.sprites[9].random_ts = fts(13)
tt.render.sprites[9].ignore_start = true
tt.render.sprites[9].scale = v(1.1, 1.1)
tt.render.sprites[10] = E:clone_c("sprite")
tt.render.sprites[10].prefix = "tower_shaman_fire"
tt.render.sprites[10].name = "idle"
tt.render.sprites[10].loop = true
tt.render.sprites[10].offset = v(-19, 61)
tt.render.sprites[10].random_ts = fts(19)
tt.render.sprites[10].ignore_start = true
tt.render.sprites[10].scale = v(1.1, 1.1)
tt.render.sid_tower = 3
tt.render.sid_shooter = 6
tt.sound_events.insert = "TowerShamanTaunt"

tt = RT("mod_shaman_tower_heal", "mod_shaman_heal")
tt.hps.heal_min = 7
tt.hps.heal_max = 8

tt = RT("mod_shaman_speed", "modifier")

AC(tt, "render", "tween")

tt.boost_factor = {
	0.8,
	0.7,
	0.6
}
tt.main_script.insert = scripts_c.mod_shrine_denas_tower.insert
tt.main_script.remove = scripts_c.mod_shrine_denas_tower.remove
tt.main_script.update = scripts_c.mod_shrine_bolin.update
tt.modifier.duration = 0.5
tt.modifier.use_mod_offset = false
tt.render.sprites[1].alpha = 50
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "totem_groundeffect-lightBlue_0002"
tt.render.sprites[1].scale = v(0.64, 0.64)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
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
tt.tween.props[1].loop = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
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
tt.tween.props[2].loop = true

tt = RT("aura_shaman_healing", "aura")

AC(tt, "render", "tween")

tt.aura.mod = "mod_shaman_tower_heal"
tt.aura.cycle_time = 0.5
tt.aura.duration = {
	6,
	8,
	10
}
tt.aura.radius = 95
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = F_MOD
tt.render.sprites[1].alpha = 50
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "totem_groundeffect-orange_0002"
tt.render.sprites[1].scale = v(0.64, 0.64)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "totem_groundeffect-orange_0001"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].anchor = v(0.5, 0.12264150943396226)
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "start"
tt.render.sprites[3].prefix = "elder_shaman_totem_orange"
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].anchor = v(0.5, 0.12264150943396226)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].loop = true
tt.render.sprites[4].name = "elder_shaman_totem_orange_fx"
tt.main_script.update = scripts_c.aura_totem_shaman.update
tt.sound_events.insert = "EndlessOrcsTotemHealing"
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
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
tt.tween.props[1].loop = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
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
tt.tween.props[2].loop = true

tt = RT("aura_shaman_damage", "aura_shaman_healing")
tt.aura.cycle_time = 0.25
tt.aura.shooter = true
tt.aura.bullet = "bolt_shaman_totem"
tt.aura.duration = {
	10,
	10,
	10
}
tt.bullet_start_offset = v(0, 30)
tt.aura.radius = 120
tt.aura.vis_bans = bor(F_FRIEND)
tt.render.sprites[1].name = "totem_groundeffect-red_0002"
tt.render.sprites[2].name = "totem_groundeffect-red_0001"
tt.render.sprites[3].prefix = "elder_shaman_totem_red"
tt.render.sprites[4].name = "elder_shaman_totem_red_fx"
tt.sound_events.insert = "EndlessOrcsTotemDamage"

tt = RT("aura_shaman_speed", "aura_shaman_healing")
tt.aura.target_towers = true
tt.aura.mod = "mod_shaman_speed"
tt.aura.cycle_time = 0.2
tt.aura.radius = 200
tt.render.sprites[1].name = "totem_groundeffect-lightBlue_0002"
tt.render.sprites[2].name = "totem_groundeffect-lightBlue_0001"
tt.render.sprites[3].prefix = "elder_shaman_totem_blue"
tt.render.sprites[4].name = "elder_shaman_totem_blue_fx"
tt.sound_events.insert = "EndlessOrcsTotemSpeed"

tt = RT("bolt_shaman_totem", "bolt")
tt.bullet.damage_max = 15
tt.bullet.damage_min = 5
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "fx_bolt_infernal_mage_hit_v"
tt.bullet.max_speed = 300
tt.bullet.pop_chance = 0.1
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.bullet.particles_name = "ps_bolt_infernal_mage_v"
tt.render.sprites[1].prefix = "demon_flareon_flare"
tt.render.sprites[1].animated = true
tt.sound_events.insert = "ElvesHeroVeznanDemonFireballThrow"
tt.sound_events.insert_args = {
	gain = 0.6
}
tt.sound_events.hit = "ElvesHeroVeznanDemonFireballHit"