local log = require("klua.log"):new("game_scripts")

require("klua.table")

local km = require("klua.macros")
local signal = require("hump.signal")
local AC = require("achievements")
local E = require("entity_db")
local GR = require("grid_db")
local GS = require("game_settings")
local P = require("path_db")
local S = require("sound_db")
local SU = require("script_utils_5")
local SU_PLD = require("script_utils_pld")
local U = require("utils_5")
local ULH = require("utils_lh")
local SULH = require("script_utils_lh")
local LU = require("level_utils")
local UP = require("upgrades")
local V = require("klua.vector")
local W = require("wave_db")
local F = require("klove.font_db")
local I = require("klove.image_db")
local G = love.graphics
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot

require("i18n")

local scripts = require("scripts_5")

local function queue_insert(store, e)
	simulation:queue_insert_entity(e)
end

local function queue_remove(store, e)
	simulation:queue_remove_entity(e)
end

local function queue_damage(store, damage)
	table.insert(store.damage_queue, damage)
end

local function fts(v)
	return v / FPS
end

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local function r(x, y, w, h)
	return {
		pos = v(x, y),
		size = v(w, h)
	}
end

local function tpos(e)
	return e.tower and e.tower.range_offset and V.v(e.pos.x + e.tower.range_offset.x, e.pos.y + e.tower.range_offset.y) or e.pos
end

local function y_show_taunt_set(store, taunts, set_name, index, wait)
	local set = taunts.sets[set_name]

	index = index or set.idxs and table.random(set.idxs) or math.random(set.start_idx, set.end_idx)

	local duration = taunts.duration
	local taunt_id = _(string.format(set.format, index))

	log.info("show taunt " .. taunt_id)
	signal.emit("show-balloon_tutorial", taunt_id, false)

	if wait then
		U.y_wait(store, duration)
	end
end

local function y_hero_melee_block_and_attacks(store, hero)
	local target = SU.soldier_pick_melee_target(store, hero)

	if not target then
		return false, A_NO_TARGET
	end

	if SU.soldier_move_to_slot_step(store, hero, target) then
		return true
	end

	local attack = SU.soldier_pick_melee_attack(store, hero, target)

	if not attack then
		return false, A_IN_COOLDOWN
	end

	local upg = UP:get_upgrade("heroes_lethal_focus")
	local triggered_lethal_focus = false
	local attack_pop = attack.pop
	local attack_pop_chance = attack.pop_chance

	if attack.basic_attack and upg then
		if not hero._lethal_focus_deck then
			hero._lethal_focus_deck = SU.deck_new(upg.trigger_cards, upg.total_cards)
		end

		triggered_lethal_focus = SU.deck_draw(hero._lethal_focus_deck)
	end

	if triggered_lethal_focus then
		hero.unit.damage_factor = hero.unit.damage_factor * upg.damage_factor
		attack.pop = {
			"pop_crit_heroes"
		}
		attack.pop_chance = 1
	end

	if attack.xp_from_skill then
		SU.hero_gain_xp_from_skill(hero, hero.hero.skills[attack.xp_from_skill])
	end

	local attack_done

	if attack.loops then
		attack_done = SU.y_soldier_do_loopable_melee_attack(store, hero, target, attack)
	elseif attack.type == "area" then
		attack_done = SU.y_soldier_do_single_area_attack(store, hero, target, attack)
	else
		attack_done = SU.y_soldier_do_single_melee_attack(store, hero, target, attack)
	end

	if triggered_lethal_focus then
		hero.unit.damage_factor = hero.unit.damage_factor / upg.damage_factor
		attack.pop = attack_pop
		attack.pop_chance = attack_pop_chance
	end

	if attack_done then
		return false, A_DONE
	else
		return true
	end
end

local function y_hero_ranged_attacks(store, hero)
	local target, attack, pred_pos = SU.soldier_pick_ranged_target_and_attack(store, hero)

	if not target then
		return false, A_NO_TARGET
	end

	if not attack then
		return false, A_IN_COOLDOWN
	end

	local upg = UP:get_upgrade("heroes_lethal_focus")
	local triggered_lethal_focus = false
	local bullet_t = E:get_template(attack.bullet)
	local bullet_use_unit_damage_factor = bullet_t.bullet.use_unit_damage_factor
	local bullet_pop = bullet_t.bullet.pop
	local bullet_pop_conds = bullet_t.bullet.pop_conds

	if attack.basic_attack and upg then
		if not hero._lethal_focus_deck then
			hero._lethal_focus_deck = SU.deck_new(upg.trigger_cards, upg.total_cards)
		end

		triggered_lethal_focus = SU.deck_draw(hero._lethal_focus_deck)
	end

	if triggered_lethal_focus then
		if bullet_t.bullet.damage_radius > 0 then
			hero.unit.damage_factor = hero.unit.damage_factor * upg.damage_factor_area
		else
			hero.unit.damage_factor = hero.unit.damage_factor * upg.damage_factor
		end

		bullet_t.bullet.use_unit_damage_factor = true
		bullet_t.bullet.pop = {
			"pop_crit"
		}
		bullet_t.bullet.pop_conds = DR_DAMAGE
	end

	local start_ts = store.tick_ts
	local attack_done

	U.set_destination(hero, hero.pos)

	if attack.loops then
		attack_done = SU.y_soldier_do_loopable_ranged_attack(store, hero, target, attack)
	else
		attack_done = SU.y_soldier_do_ranged_attack(store, hero, target, attack, pred_pos)
	end

	if attack_done then
		attack.ts = start_ts

		if attack.shared_cooldown then
			for _, aa in pairs(hero.ranged.attacks) do
				if aa ~= attack and aa.shared_cooldown then
					aa.ts = attack.ts
				end
			end
		end

		if hero.ranged.forced_cooldown then
			hero.ranged.forced_ts = start_ts
		end
	end

	if triggered_lethal_focus then
		if bullet_t.bullet.damage_radius > 0 then
			hero.unit.damage_factor = hero.unit.damage_factor / upg.damage_factor_area
		else
			hero.unit.damage_factor = hero.unit.damage_factor / upg.damage_factor
		end
		bullet_t.bullet.use_unit_damage_factor = bullet_use_unit_damage_factor
		bullet_t.bullet.pop = bullet_pop
		bullet_t.bullet.pop_conds = bullet_pop_conds
	end

	if attack_done then
		return false, A_DONE
	else
		return true
	end
end

scripts.hero_orc = {}

function scripts.hero_orc.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_asra = {}

function scripts.hero_asra.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_oloch = {}

function scripts.hero_oloch.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_tramin = {}

function scripts.hero_tramin.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_jigou = {}

function scripts.hero_jigou.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_margosa = {}

function scripts.hero_margosa.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_mortemis = {}

function scripts.hero_mortemis.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.controller_overwhelm_tank = {}
function scripts.controller_overwhelm_tank.update(this, store, script)
	local a = this.ranged.attacks[1]
	local a_ts = store.tick_ts

	while true do
		if a.cooldown < store.tick_ts - a_ts and this.owner.health.dead == false then
			a_ts = store.tick_ts
			local b = E:create_entity(a.bullet)
			local tx = this.owner.pos.x
			local ty = this.owner.pos.y
			
			b.pos.x, b.pos.y = tx, ty + a.start_offset_y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(tx, ty)

			queue_insert(store, b)
		end
		coroutine.yield()
	end
end

scripts.hero_tank = {}

function scripts.hero_tank.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	local bt = E:get_template(this.ranged.attacks[1].bullet)
	bt.bullet.damage_min = ls.ranged_damage_min[hl]
	bt.bullet.damage_max = ls.ranged_damage_max[hl]

	--1技能 导弹
	s = this.hero.skills.heat_missiles
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = nil
		e1 = E:get_template(this.timed_attacks.list[1].bullet)
		e1.bullet.damage_min = s.damage_max_config[s.level]
		e1.bullet.damage_max = s.damage_max_config[s.level]
	end

	--2技能 捶地
	s = this.hero.skills.ground_slam
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = nil
		e1 = E:get_template(this.timed_attacks.list[2].hit_aura)
		e1.aura.damage_min = s.damage_min_config[s.level]
		e1.aura.damage_max = s.damage_max_config[s.level]
	end

	--4技能 大招
	s = this.hero.skills.scorching_cannon
	if initial and s.level > 0 then
		this.timed_attacks.list[3].disabled = nil
		this.timed_attacks.list[3].cooldown = s.cooldown[s.level]
		local mod = E:get_template("mod_roundfire_hero_tank")
		mod.dps.damage_min = s.damage_config[s.level]
		mod.dps.damage_max = s.damage_config[s.level]
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		local mod = E:get_template("mod_bullet_zeppelin_hero_tank")
		mod.dps.damage_min = s.damage_config[s.level]
		mod.dps.damage_max = s.damage_config[s.level]
	end

end

function scripts.hero_tank.insert(this, store)
	this.hero.fn_level_up(this, store, true)
	S:queue("HeroPaladinTauntIntro")

	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_tank.update(this, store)
	local h = this.health
	local he = this.hero
	local a, am, skill, force_idle_ts
	local soldier_available = false
	local zhu_apprentice_soldier_list = {}
	local zhu_offset = {{-15,-10}, {-15,10}, {15,0}}

	local missle_attack = this.timed_attacks.list[1] --1技能  导弹
	local shake_attack = this.timed_attacks.list[2] --2技能  震地
	local fire_attack = this.timed_attacks.list[3] --4技能  喷火
	missle_attack.ts = 0
	shake_attack.ts = 0
	fire_attack.ts = 0

	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

	this.health_bar.hidden = false
	force_idle_ts = true

	local overwhelm = E:create_entity(this.overwhelm_entity)
	overwhelm.owner = this
	overwhelm.owner_id = this.id
	queue_insert(store, overwhelm)

	local function rally_zhu_apprentice()
		if not soldier_available then
			return
		else
			local nearest = P:nearest_nodes(this.nav_rally.pos.x, this.nav_rally.pos.y, nil, nil, true)
			local rally_position
			if nearest then
				pi, spi, ni = unpack(nearest[1])
				rally_position = P:node_pos(pi, spi, ni - 6)
			else
				rally_position = V.vclone(this.nav_rally.pos)
			end

			for count, zhu_apprentice_soldier in pairs(zhu_apprentice_soldier_list) do
				zhu_apprentice_soldier.nav_rally.new = true
				--zhu_apprentice_soldier.nav_rally.center = V.v(this.nav_rally.pos.x + zhu_offset[count][1], this.nav_rally.pos.y + zhu_offset[count][2])
				zhu_apprentice_soldier.nav_rally.center = V.v(rally_position.x + zhu_offset[count][1], rally_position.y + zhu_offset[count][2])
				zhu_apprentice_soldier.nav_rally.pos = V.vclone(zhu_apprentice_soldier.nav_rally.center)
				zhu_apprentice_soldier.nav_grid.waypoints = table.deepclone(this.nav_grid.waypoints)

				table.remove(zhu_apprentice_soldier.nav_grid.waypoints, #zhu_apprentice_soldier.nav_grid.waypoints)
			end
		end
	end

	local function create_soldier(e_template, pos)
		local e = E:create_entity(e_template)

		e.pos = V.vclone(pos)
		e.nav_rally.center = V.vclone(e.pos)
		e.nav_rally.pos = V.vclone(e.pos)

		queue_insert(store, e)

		return e
	end

	if this.hero.skills.expendables.level > 0 then
		local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)
		local rally_position
		if nearest then
			local pi, spi, ni = unpack(nearest[1])
			rally_position = P:node_pos(pi, spi, ni - 6)
		else
			rally_position = V.vclone(this.nav_rally.pos)
		end
		local zhu_apprentice_soldier1 = create_soldier(this.hero.skills.expendables.entity[this.hero.skills.expendables.level], V.v(rally_position.x + zhu_offset[1][1], rally_position.y + zhu_offset[1][2]))
		table.insert(zhu_apprentice_soldier_list, zhu_apprentice_soldier1)

		local zhu_apprentice_soldier2 = create_soldier(this.hero.skills.expendables.entity[this.hero.skills.expendables.level], V.v(rally_position.x + zhu_offset[2][1], rally_position.y + zhu_offset[2][2]))
		table.insert(zhu_apprentice_soldier_list, zhu_apprentice_soldier2)

		if this.hero.skills.expendables.level >= 2 then
			local zhu_apprentice_soldier3 = create_soldier(this.hero.skills.expendables.entity[this.hero.skills.expendables.level], V.v(rally_position.x + zhu_offset[3][1], rally_position.y + zhu_offset[3][2]))
			table.insert(zhu_apprentice_soldier_list, zhu_apprentice_soldier3)
		end
		soldier_available = true
	end

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			rally_zhu_apprentice()
			SU.y_hero_new_rally(store, this)
		end

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		end

		--1技能 导弹
		am = missle_attack
		skill = this.hero.skills.heat_missiles
		if not am.disabled and store.tick_ts - am.ts > am.cooldown then
			local _, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

			if not targets then
				-- block empty
			else
				local target = targets[1]

				am.ts = store.tick_ts

				local an, af = U.animation_name_facing_point(this, am.animation_pre, target.pos)

				U.animation_start(this, an, af, store.tick_ts, false, 1)

				while not U.animation_finished(this) do
					coroutine.yield()
				end

				local burst_count = skill.count[skill.level]
				local fire_loops = burst_count / #am.hit_times

				for i = 1, fire_loops do
					local an, af 
					if i == fire_loops then
						an, af = U.animation_name_facing_point(this, am.animation, target.pos)
					else
						an, af = U.animation_name_facing_point(this, am.animation_last, target.pos)
					end

					U.animation_start(this, an, af, store.tick_ts, false, 1)

					for hi, ht in ipairs(am.hit_times) do
						while ht > store.tick_ts - this.render.sprites[1].ts do
							if this.nav_rally.new then
								goto label_3064_1
							end

							coroutine.yield()
						end

						local b = E:create_entity(am.bullet)

						b.pos.x = this.pos.x + (af and -1 or 1) * am.start_offsets[km.zmod(hi, #am.start_offsets)].x
						b.pos.y = this.pos.y + am.start_offsets[hi].y
						b.bullet.level = skill.level
						b.bullet.from = V.vclone(b.pos)
						b.bullet.to = V.v(b.pos.x + (af and -1 or 1) * am.launch_vector.x, b.pos.y + am.launch_vector.y)
						b.bullet.target_id = target.id

						queue_insert(store, b)

						_, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

						if not targets then
							goto label_3064_1
						end

						target = targets[1]
					end

					SU.hero_gain_xp_from_skill(this, skill)

					U.y_wait(store, fts(3))
				end

				::label_3064_1::

				U.animation_start(this, am.animation_post, nil, store.tick_ts, false, 1)

				while not U.animation_finished(this) do
					coroutine.yield()
				end

				am.ts = store.tick_ts

				goto label_3064_0
			end
		end

		--2技能 捶地
		a = shake_attack
		skill = this.hero.skills.heat_missiles
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes, nil, a.vis_flags, a.vis_bans)

			if not target_info or #target_info < a.min_count then
				SU.delay_attack(store, a, 0.2)
			else
				local target = target_info[1].enemy
				SU.hero_gain_xp_from_skill(this, skill)

				--log.error("yy picked target:%s at:%s,%s", target.id, target.pos.x, target.pos.y)
				S:queue(a.sound_pre)
				if not SU.y_soldier_do_single_area_attack(store, this, target, a) then
					goto label_3064_0
				end
			end
		end

		--4技能 喷火
		am = fire_attack
		skill = this.hero.skills.scorching_cannon
		if not am.disabled and store.tick_ts - am.ts > am.cooldown then
			local _, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

			if not targets then
				-- block empty
			else
				local target = targets[1]

				am.ts = store.tick_ts

				U.animation_start(this, am.animation_pre, nil, store.tick_ts, false, 1)
				S:queue(a.sound_pre)
				
				while not U.animation_finished(this) do
					coroutine.yield()
				end
				
				U.animation_start(this, am.animation, nil, store.tick_ts, false, 1)
				S:queue(a.sound)
	
				local points = {}
				local inner_fx_radius = 35

				for i = 1, 12 do
					local r = inner_fx_radius

					local p = {}

					p.pos = U.point_on_ellipse(this.pos, r, 2 * math.pi * (12-i) / 12)
					p.terrain = GR:cell_type(p.pos.x, p.pos.y)

					if GR:cell_is(p.pos.x, p.pos.y, TERRAIN_WATER) or P:valid_node_nearby(p.pos.x, p.pos.y, 1) and not GR:cell_is(p.pos.x, p.pos.y, TERRAIN_CLIFF) then
						table.insert(points, p)
					end
				end

				local ts_e = store.tick_ts

				for _, p in pairs(points) do

					--local smoke = E:create_entity("decal_rotten_forest_smoke")
					local e = E:create_entity(am.entity)

					e.pos = V.vclone(p.pos)
					e.aura.source_id = this.id
					e.aura.ts = ts_e
					queue_insert(store, e)
					U.y_wait(store, fts(3))
				end


				while not U.animation_finished(this) do
					coroutine.yield()
				end


				U.animation_start(this, am.animation_post, nil, store.tick_ts, false, 1)
				S:queue(a.sound_post)
				while not U.animation_finished(this) do
					coroutine.yield()
				end
				SU.hero_gain_xp_from_skill(this, skill)

				am.ts = store.tick_ts

				goto label_3064_0
			end
		end
		

		--普攻
		--普攻/hit_payload
		a = ranged_attack
		for _, i in pairs(this.ranged.order) do
			local a = this.ranged.attacks[i]

			if a.disabled then
				-- block empty
			elseif a.sync_animation and not this.render.sprites[1].sync_flag then
				-- block empty
			elseif store.tick_ts - a.ts < a.cooldown then
				-- block empty
			elseif math.random() > a.chance then
				-- block empty
			else
				local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
				local bullet_t = E:get_template(a.bullet)
				local bullet_speed = bullet_t.bullet.min_speed
				local flight_time = bullet_t.bullet.flight_time

				local target, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans)

				if target then
					local start_ts = store.tick_ts
					local b, emit_fx, emit_ps, emit_ts
					local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)
					local node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
					local t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
					local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

					--U.animation_start(this, an, af, store.tick_ts)
					U.animation_start(this, an, af, store.tick_ts, false, 1)

					SU.hero_gain_xp_from_skill(this, this.hero.skills.heat_missiles)

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
						end

						coroutine.yield()
					end

					--S:queue(a.sound)
					b = E:create_entity(a.bullet)
					b.bullet.target_id = target.id
					b.bullet.source_id = this.id
					b.pos = V.vclone(this.pos)
					b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
					b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
					b.bullet.from = V.vclone(b.pos)
					local target, __, trigger_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans)
					b.bullet.to = target and trigger_pos or pred_pos

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_32530_0::

					--goto label_32530_1
				end
			end
		end


		::label_3064_0::

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)

		force_idle_ts = nil

		coroutine.yield()
	end
end

scripts.missile_tank = {}

function scripts.missile_tank.insert(this, store, script)
	local b = this.bullet
	local ps = E:create_entity(b.particles_name)

	ps.particle_system.track_id = this.id

	queue_insert(store, ps)

	return true
end

function scripts.missile_tank.update(this, store, script)
	local b = this.bullet
	local target = store.entities[b.target_id]
	local mspeed = b.min_speed
	local rot_dir = 1
	local follow = false
	local max_seek_angle = b.max_seek_angle or 0.38 --b.max_seek_angle or 0.2

	if this.render.sprites[1].animated then
		U.animation_start(this, "flying", nil, store.tick_ts, -1)
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		if b.rot_dir_from_long_angle and target then
			rot_dir = target.pos.x < this.pos.x and -1 or 1
		elseif b.speed.x < 0 then
			rot_dir = -1
		end

		coroutine.yield()
	end

	if not target or target.health and target.health.dead then
		local ref_pos = target and target.pos or this.pos

		target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
		--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
	end

	if target then
		b.to.x, b.to.y = target.pos.x, target.pos.y

		if target.unit.hit_offset then
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		if not target or target.health and target.health.dead or band(target.vis.bans, b.vis_flags) ~= 0 then
			local ref_pos = target and target.pos or this.pos

			--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
			target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
			if b.rot_dir_from_long_angle and target then
				rot_dir = target.pos.x < this.pos.x and -1 or 1
			end
		end

		if target then
			b.to.x, b.to.y = target.pos.x, target.pos.y

			if target.unit.hit_offset then
				b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
			end
		end

		local d_angle = V.angleTo(b.speed.x, b.speed.y, b.to.x - this.pos.x, b.to.y - this.pos.y)

		if max_seek_angle < math.abs(d_angle) then
			local rot = b.turn_speed * store.tick_length * rot_dir
			local dir = V.angleTo(b.speed.x, b.speed.y)

			if dir > math.pi / 3 and dir < 2 * math.pi / 3 then
				rot = rot * (b.turn_helicoidal_factor or 1.5)
			end

			b.speed.x, b.speed.y = V.rotate(rot, b.speed.x, b.speed.y)
		else
			mspeed = mspeed + 30 * math.ceil(mspeed * 0.03333333333333333 * b.acceleration_factor)
			mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
			b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		end

		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		coroutine.yield()
	end

	if b.damage_radius and b.damage_radius > 0 then
		local enemies = table.filter(store.entities, function(k, v)
			return v.enemy and v.vis and v.unit and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(V.v(v.pos.x + v.unit.hit_offset.x, v.pos.y + v.unit.hit_offset.y), b.to, b.damage_radius)
		end)
		local alchemical_powder = UP:get_upgrade("engineer_alchemical_powder")
		local alchemical_powder_on = alchemical_powder and math.random() < alchemical_powder.chance
		local shock_and_awe = nil -- = UP:get_upgrade("engineer_shock_and_awe")

		for _, enemy in pairs(enemies) do
			local enemy_pos = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			local d = E:create_entity("damage")
			d.xp_dest_id = b.source_id
			d.source_id = this.id
			d.target_id = enemy.id
			d.damage_type = b.damage_type
			d.reduce_armor = b.reduce_armor
			d.reduce_magic_armor = b.reduce_magic_armor

			if alchemical_powder_on then
				d.value = b.damage_max
			else
				local dist_factor = U.dist_factor_inside_ellipse(enemy_pos, this.pos, b.damage_radius)

				d.value = math.floor(b.damage_max - (b.damage_max - b.damage_min) * dist_factor)
			end
			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end

			if shock_and_awe and band(enemy.vis.bans, F_STUN) == 0 and band(enemy.vis.flags, bor(F_BOSS, F_CLIFF, F_FLYING)) == 0 and math.random() < shock_and_awe.chance then
				local mod = E:create_entity("mod_shock_and_awe")

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end
		end
	elseif target then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = target.id

			queue_insert(store, mod)
		end
	end

	local fx

	if b.hit_fx_air and target and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = b.hit_fx_air

		S:queue(this.sound_events.hit)
	elseif b.hit_fx_water and not target and band(GR:cell_type(b.to.x, b.to.y), TERRAIN_WATER) ~= 0 then
		fx = b.hit_fx_water

		S:queue(this.sound_events.hit_water)
	elseif b.hit_fx then
		fx = b.hit_fx

		S:queue(this.sound_events.hit)
	end

	if fx then
		local is_air = target and band(target.vis.flags, F_FLYING) ~= 0
		local sfx = E:create_entity(fx)

		if b.hit_fx_ignore_hit_offset and target and not is_air then
			sfx.pos.x, sfx.pos.y = target.pos.x, target.pos.y
		else
			sfx.pos.x, sfx.pos.y = this.pos.x, this.pos.y
		end

		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

scripts.aura_tank_skill2_bomb = {}

function scripts.aura_tank_skill2_bomb.update(this, store)
	local a = this.aura

	local function do_attack(pos, last_attack)
		local fx = E:create_entity(a.fx)

		fx.pos.x, fx.pos.y = pos.x, pos.y

		if not last_attack then
			fx.render.sprites[2].scale = V.v(0.8, 0.8)
		end

		fx.render.sprites[2].ts = store.tick_ts
		fx.tween.ts = store.tick_ts

		queue_insert(store, fx)

		local radius = last_attack and a.last_attack_damage_radius or a.damage_radius
		local targets = U.find_enemies_in_range(store.entities, pos, 0, radius, a.vis_flags, a.vis_bans)

		if targets then
			S:queue(this.sound)
			for _, t in pairs(targets) do
				local d = E:create_entity("damage")

				d.value = math.random(a.damage_min, a.damage_max)
				d.damage_type = a.damage_type
				d.source_id = this.id
				d.target_id = t.id

				queue_damage(store, d)

				if (last_attack or math.random() < a.stun_chance) and U.flags_pass(t.vis, this.stun) then
					local m = E:create_entity(this.stun.mod)

					m.modifier.source_id = this.id
					m.modifier.target_id = t.id

					queue_insert(store, m)
				end
			end

			log.paranoid(">>>> aura_10yr_bomb POS:%s,%s  damaged:%s", pos.x, pos.y, table.concat(table.map(targets, function(k, v)
				return v.id
			end), ","))
		end
	end

	local pi, spi, ni, tni, target, origin
	local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes, nil, a.vis_flags, a.vis_bans)

	if not target_info or #target_info < a.min_count then
		log.error("aura_10yr_bomb could not find valid enemies in the hero paths")
	else
		target = target_info[1].enemy
		origin = target_info[1].origin
		pi, spi, ni = unpack(origin)
		tni = target.nav_path.ni

		for i = 1, a.steps do
			local nni = ni + i * a.step_nodes * km.sign(tni - ni)
			local oni = ni + i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end

			local nni = ni - i * a.step_nodes * km.sign(tni - ni)
			local oni = ni - i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end
		end
	end

	queue_remove(store, this)
end

scripts.soldier_hero_tank_expendables_apprentice = {}

function scripts.soldier_hero_tank_expendables_apprentice.insert(this, store, script)
	this.melee.order = U.attack_order(this.melee.attacks)

	if this.ranged then
		this.ranged.order = U.attack_order(this.ranged.attacks)
	end

	return true
end

function scripts.soldier_hero_tank_expendables_apprentice.update(this, store, script)
	local brk, stam, star, a

	this.render.sprites[1].ts = store.tick_ts

	local function y_zhu_apprentice_death_and_respawn(store, this)
		local h = this.health

		this.ui.can_click = false

		local death_ts = store.tick_ts
		local dead_lifetime = h.dead_lifetime

		U.unblock_target(store, this)

		if band(h.last_damage_types, bor(DAMAGE_DISINTEGRATE_BOSS)) ~= 0 then
			this.unit.hide_after_death = true

			local fx = E:create_entity("fx_soldier_desintegrate")

			fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		elseif band(h.last_damage_types, bor(DAMAGE_EAT)) ~= 0 then
			this.unit.hide_after_death = true
		elseif band(h.last_damage_types, bor(DAMAGE_HOST)) ~= 0 then
			this.unit.hide_after_death = true

			S:queue("DeathEplosion")

			local fx = E:create_entity("fx_unit_explode")

			fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
			fx.render.sprites[1].ts = store.tick_ts
			fx.render.sprites[1].name = fx.render.sprites[1].size_names[this.unit.size]

			queue_insert(store, fx)

			if this.unit.show_blood_pool and this.unit.blood_color ~= BLOOD_NONE then
				local decal = E:create_entity("decal_blood_pool")

				decal.pos = V.vclone(this.pos)
				decal.render.sprites[1].ts = store.tick_ts
				decal.render.sprites[1].name = this.unit.blood_color

				queue_insert(store, decal)
			end
		else
			S:queue(this.sound_events.death, this.sound_events.death_args)

			if this.unit.death_animation then
				U.animation_start(this, this.unit.death_animation, nil, store.tick_ts, false)
			else
				U.animation_start(this, "death", nil, store.tick_ts, false)
			end
		end

		if this.unit.hide_after_death then
			for _, s in pairs(this.render.sprites) do
				s.hidden = true
			end
		end

		while dead_lifetime > store.tick_ts - death_ts do
			if this.force_respawn then
				this.force_respawn = nil

				break
			end

			coroutine.yield()
		end

		this.health.death_finished_ts = nil

		for _, s in pairs(this.render.sprites) do
			if this.use_hidden_count_on_respawn and s.hidden_count then
				s.hidden = s.hidden_count > 0
			else
				s.hidden = false
			end
		end

		h.ignore_damage = true

		S:queue(this.sound_events.respawn)

		local respawn_fx = E:create_entity(this.respawn_fx)

		respawn_fx.pos = V.vclone(this.pos)
		respawn_fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, respawn_fx)
		U.y_wait(store, this.respawn_fx_timing)

		this.health_bar.hidden = false
		this.ui.can_click = true
		h.dead = false
		this.force_respawn = nil
		h.hp = h.hp_max
		h.ignore_damage = false
	end

	while true do
		if this.health.dead then
			y_zhu_apprentice_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			SU.soldier_courage_upgrade(store, this)

			while this.nav_rally.new do
				if this.nav_rally.move_order then
					U.y_wait(store, this.nav_rally.move_order * math.random() * 0.3)
				end

				if SU.y_hero_new_rally(store, this) then
					goto label_895_0
				end
			end

			if this.dodge and this.dodge.active then
				this.dodge.active = false

				if this.dodge.animation then
					U.animation_start(this, this.dodge.animation, nil, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end
				end

				signal.emit("soldier-dodge", this)
			end

			if this.melee then
				brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
					goto label_895_1
				end
			end

			if this.ranged then
				brk, star = SU.y_soldier_ranged_attacks(store, this)

				if brk or star == A_DONE then
					goto label_895_1
				elseif star == A_IN_COOLDOWN then
					goto label_895_0
				end
			end

			if this.melee.continue_in_cooldown and stam == A_IN_COOLDOWN then
				goto label_895_1
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_895_1
			end

			::label_895_0::

			SU.soldier_idle(store, this)
			SU.soldier_regen(store, this)
		end

		::label_895_1::

		coroutine.yield()
	end
end

scripts.hero_tank_ultimate = {}

function scripts.hero_tank_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.hero_tank_ultimate.update(this, store)
	local function spawn_zeppelin(pi, spi, ni)
		local pos = P:node_pos(pi, spi, ni)
		local x_center = (store.visible_coords.left + store.visible_coords.right) / 2
		local spawn_pos = V.vclone(pos)
		local exit_pos = V.vclone(pos)
		local out_of_screen_offset = 100

		if x_center > spawn_pos.x then
			spawn_pos.x = store.visible_coords.left - out_of_screen_offset
			exit_pos.x = store.visible_coords.right + out_of_screen_offset
		else
			spawn_pos.x = store.visible_coords.right + out_of_screen_offset
			exit_pos.x = store.visible_coords.left - out_of_screen_offset
		end

		local zep = E:create_entity(this.entity)

		zep.pos = V.vclone(spawn_pos)
		zep.target_pos = V.vclone(pos)
		zep.exit_pos = V.vclone(exit_pos)
		zep.sound = this.sound
		zep.level = this.level

		queue_insert(store, zep)
	end

	local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)

	if #nearest > 0 then
		local pi, spi, ni = unpack(nearest[1])

		if P:is_node_valid(pi, ni) then
			S:queue(this.sound)
			spawn_zeppelin(pi, 1, ni)
		end
	end

	queue_remove(store, this)
end

scripts.zeppelin_hero_tank = {}

function scripts.zeppelin_hero_tank.update(this, store)
	local a = this.ranged.attacks[1]
	local shoot_ts = store.tick_ts
	local fps_normal = 30
	local fps_slow = 20
	--[[
	local d = E:create_entity(this.decal)

	d.render.sprites[1].ts = store.tick_ts
	d.pos = V.vclone(this.target_pos)

	queue_insert(store, d)
	]]

	local margin = this.flight_height + 100

	if this.pos.y > 768 - margin then
		this.pos.y = 768 - margin
		this.exit_pos.y = 768 - margin
		this.target_pos.y = 768 - margin
	end

	U.animation_start_group(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, "layers")

	while math.abs(this.pos.x - this.target_pos.x) > this.attack_radius * 1.75 do
		U.force_motion_step(this, store.tick_length, this.target_pos)
		coroutine.yield()
	end
	--[[

	while this.render.sprites[1].offset.y > this.flight_height_attack + 5 do
		local height_factor = (this.render.sprites[1].offset.y - this.flight_height_attack) / (this.flight_height - this.flight_height_attack)

		this.force_motion.max_v = this.speed_in_range + (this.speed_out_of_range - this.speed_in_range) * height_factor * 0.5

		U.force_motion_step(this, store.tick_length, this.exit_pos)
		coroutine.yield()
	end
	]]

	--[[

	while math.abs(this.pos.x - this.target_pos.x) <= this.attack_radius do

		if store.tick_ts - shoot_ts > a.cooldown then
			local flight_time = E:get_template(a.bullet).bullet.flight_time
			local target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, flight_time + a.shoot_time, a.vis_flags, a.vis_bans)

			if target and not target.health.dead and pred_pos then
				local an, af = U.animation_name_facing_point(this, a.animation, this.exit_pos, 1)

				U.animation_start(this, an, af, store.tick_ts, false, 1)

				local a_ts = store.tick_ts

				while store.tick_ts - a_ts < a.shoot_time do
					U.force_motion_step(this, store.tick_length, this.exit_pos)
					coroutine.yield()
				end
				]]

				local b = E:create_entity(a.bullet)

				b.bullet.from = V.v(this.pos.x + a.bullet_start_offset[1].x, this.pos.y + a.bullet_start_offset[1].y + this.render.sprites[1].offset.y)
				--b.bullet.to = V.vclone(pred_pos)
				b.bullet.to = V.vclone(this.target_pos)
				
				b.bullet.source_id = this.id
				--b.bullet.target_id = target.id
				b.pos = V.vclone(b.bullet.from)
				b.bullet.level = this.level
				b.bullet.source_id = this.id

				queue_insert(store, b)

				while not U.animation_finished(this, 1) do
					U.force_motion_step(this, store.tick_length, this.exit_pos)
					coroutine.yield()
				end

				U.animation_start(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, 1)
		--[[
				shoot_ts = store.tick_ts
			end
		end

		
		if (not this.render.sprites[1].fps or this.render.sprites[5].fps == fps_normal) and this.render.sprites[1].sync_flag then
			this.render.sprites[1].fps = fps_slow

			for i = 1, #this.render.sprites do
				if this.render.sprites[i].group == "layers" then
					U.animation_start(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, i, true)
				end
			end
		end

		local height_factor = (this.render.sprites[1].offset.y - this.flight_height_attack) / (this.flight_height - this.flight_height_attack)

		this.force_motion.max_v = this.speed_in_range + (this.speed_out_of_range - this.speed_in_range) * height_factor

		U.force_motion_step(this, store.tick_length, this.exit_pos)
		coroutine.yield()
	end
	]]

	this.force_motion.max_v = this.speed_out_of_range * 0.7

	while math.abs(this.pos.x - this.exit_pos.x) > 10 do
		if this.render.sprites[1].fps == fps_slow and this.render.sprites[1].sync_flag then
			this.render.sprites[1].fps = fps_normal

			for i = 1, #this.render.sprites do
				if this.render.sprites[i].group == "layers" then
					U.animation_start(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, i, true)
				end
			end
		end

		U.force_motion_step(this, store.tick_length, this.exit_pos)

		local height_factor = (this.render.sprites[1].offset.y - this.flight_height_attack) / (this.flight_height - this.flight_height_attack)

		this.force_motion.max_v = this.speed_in_range + (this.speed_out_of_range - this.speed_in_range) * height_factor

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.decal_bullet_zeppelin_hero_tank = {}

function scripts.decal_bullet_zeppelin_hero_tank.update(this, store)
	print("insert bomb zippin")
	local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)
	local pi, spi, ni = unpack(nearest[1])
	local s_pi, s_spi, s_ni = unpack(nearest[1])

	local delay = 0
	local n_step = ni < s_ni and -2 or 2

	base_ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)
	ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

	for i = 1, this.entity_count do
		local e = E:create_entity(this.aura_entity)
		ni = base_ni + n_step * (i-1)
		ni = km.clamp(1, #P:path(s_pi), ni)

		e.pos = P:node_pos(pi, spi, ni)
		e.aura.source_id = this.id
		e.delay = delay

		queue_insert(store, e)

		delay = delay + fts(U.frandom(2, 5))
		spi = km.zmod(spi + math.random(1, 2), 3)

		local e = E:create_entity(this.aura_entity)
		ni = base_ni - n_step * i
		ni = km.clamp(1, #P:path(s_pi), ni)

		e.pos = P:node_pos(pi, spi, ni)
		e.aura.source_id = this.id
		e.delay = delay

		queue_insert(store, e)

		delay = delay + fts(U.frandom(2, 5))
		spi = km.zmod(spi + math.random(1, 2), 3)
	end
end

scripts.aura_apply_mod_tank = {}

function scripts.aura_apply_mod_tank.insert(this, store, script)
	this.aura.ts = store.tick_ts

	if this.render then
		for _, s in pairs(this.render.sprites) do
			s.ts = store.tick_ts
		end
		
	end

	if this.aura.source_id then
		local target = store.entities[this.aura.source_id]

		if target and this.render and this.aura.use_mod_offset and target.unit and target.unit.mod_offset then
			this.render.sprites[1].offset.x, this.render.sprites[1].offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
		end
	end

	this.actual_duration = this.aura.duration

	if this.aura.duration_inc then
		this.actual_duration = this.actual_duration + this.aura.level * this.aura.duration_inc
	end

	return true
end

function scripts.aura_apply_mod_tank.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0

	U.animation_start(this, "in", false, store.tick_ts, false, 1)
	while not U.animation_finished(this) do
		coroutine.yield()
	end

	U.animation_start(this, "run", false, store.tick_ts, true, 1)

	if this.aura.track_source and this.aura.source_id then
		local te = store.entities[this.aura.source_id]

		if te and te.pos then
			this.pos = te.pos
		end
	end

	last_hit_ts = store.tick_ts - this.aura.cycle_time

	if this.aura.apply_delay then
		last_hit_ts = last_hit_ts + this.aura.apply_delay
	end

	while true do
		if this.interrupt then
			last_hit_ts = 1e+99
		end

		if this.aura.cycles and cycles_count >= this.aura.cycles or this.aura.duration >= 0 and store.tick_ts - this.aura.ts > this.actual_duration then
			break
		end

		if this.aura.track_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if not te or te.health and te.health.dead and not this.aura.track_dead then
				break
			end
		end

		if this.aura.requires_magic then
			local te = store.entities[this.aura.source_id]

			if not te or not te.enemy then
				goto label_88_0
			end

			if this.render then
				this.render.sprites[1].hidden = not te.enemy.can_do_magic
			end

			if not te.enemy.can_do_magic then
				goto label_88_0
			end
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_88_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.health and te.health.dead then
				goto label_88_0
			end
		end

		if not (store.tick_ts - last_hit_ts >= this.aura.cycle_time) or this.aura.apply_duration and first_hit_ts and store.tick_ts - first_hit_ts > this.aura.apply_duration then
			-- block empty
		else
			if this.render and this.aura.cast_resets_sprite_id then
				this.render.sprites[this.aura.cast_resets_sprite_id].ts = store.tick_ts
			end

			first_hit_ts = first_hit_ts or store.tick_ts
			last_hit_ts = store.tick_ts
			cycles_count = cycles_count + 1

			local targets = table.filter(store.entities, function(k, v)
				return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
			end)

			for i, target in ipairs(targets) do
				if this.aura.targets_per_cycle and i > this.aura.targets_per_cycle then
					break
				end

				if this.aura.max_count and victims_count >= this.aura.max_count then
					break
				end

				local mods = this.aura.mods or {
					this.aura.mod
				}

				for _, mod_name in pairs(mods) do
					local new_mod = E:create_entity(mod_name)

					new_mod.modifier.level = this.aura.level
					new_mod.modifier.target_id = target.id
					new_mod.modifier.source_id = this.id

					if this.aura.hide_source_fx and target.id == this.aura.source_id then
						new_mod.render = nil
					end

					queue_insert(store, new_mod)

					victims_count = victims_count + 1
				end
			end
		end

		::label_88_0::

		coroutine.yield()
	end

	U.animation_start(this, "out", false, store.tick_ts, false, 1)

	U.y_wait(store, fts(17))

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end


scripts.hero_beresad = {}

function scripts.hero_beresad.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	--普攻
	local b = E:get_template(this.ranged.attacks[1].bullet)

	b.bullet.damage_max = ls.ranged_damage_max[hl]
	b.bullet.damage_min = ls.ranged_damage_min[hl]

	local s 

	--1技能 绿火
	s = this.hero.skills.conflagration
	if initial and s.level > 0 then
		local a = this.ranged.attacks[2]
		a.disabled = false
		a.cooldown = s.cooldown[s.level]
		local b = E:get_template(a.bullet)
		local payload = E:get_template(b.bullet.hit_payload[1])
		m = E:get_template(payload.aura.mod)
		m.dps.damage_min = s.damage[s.level]
		m.dps.damage_max = s.damage[s.level]
	end

	--2技能 恐吓
	s = this.hero.skills.fear_dragon
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		local b = E:get_template(this.timed_attacks.list[1].entity)
		b.modifier.duration = s.duration[s.level]
	end

	--3技能 傀儡
	s = this.hero.skills.dragon_spawn
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[2]
		a.disabled = false
		e = E:get_template(a.entity)
		e.aura.entity = s.entity[s.level]
	end

	--4技能 秒杀
	s = this.hero.skills.remove_existence
	if initial and s.level > 0 then
		local a = this.ranged.attacks[3]
		a.cooldown = s.cooldown[s.level]
		a.disabled = false
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		local m = E:get_template(u.mod)
		m.dps.damage_min = s.damage[s.level]
		m.dps.damage_max = s.damage[s.level]
	end

end

function scripts.hero_beresad.insert(this, store)
	this.hero.fn_level_up(this, store, true)

	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_beresad.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts

	local golem_attack = this.timed_attacks.list[2]
	local fear_attack = this.timed_attacks.list[1]
	local fire_attack = this.ranged.attacks[2]
	local instakill_attack = this.ranged.attacks[3]
	fear_attack.ts = 0
	golem_attack.ts = 0

	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

	this.health_bar.hidden = false
	force_idle_ts = true

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			SU.y_hero_new_rally(store, this)
		end

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		end

		--2技能 恐吓
		local a = fear_attack
		local skill = this.hero.skills.fear_dragon
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local start_ts, bdy, bdt, au
			local fired_aura = false
			local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not targets then
				SU.delay_attack(store, a, 0.2)
			else
				local cnt = 0
				a.ts = store.tick_ts
				U.animation_start(this, a.animation, nil, store.tick_ts, false)
				S:queue(a.sound)
				U.y_wait(store, fts(25))
				for _, e in pairs(targets) do
					cnt = cnt + 1
					local mod = E:create_entity(a.entity)
					mod.modifier.target_id = e.id
					mod.modifier.source_id = this.id
					mod.modifier.level = skill.level
					queue_insert(store, mod)
					if cnt == a.max_target then
						break
					end
				end
				U.y_animation_wait(this, 1)
				U.y_animation_play(this, "idle", nil, store.tick_ts, 1)
			end
		end

		--3技能 傀儡
		local a = golem_attack
		local skill = this.hero.skills.dragon_spawn
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
				local start_ts, bdy, bdt, au
				local fired_aura = false
				local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

				if not targets then
					SU.delay_attack(store, a, 0.2)
				else
					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts, false)

					while not U.animation_finished(this) do
						if SU.hero_interrupted(this) then
							goto label_90_0
						end

						coroutine.yield()
					end

					start_ts = store.tick_ts

					au = E:create_entity(a.entity)
					au.aura.source_id = this.id

					queue_insert(store, au)

					fired_aura = true

					::label_90_0::

					if fired_aura then
						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)
					end
					U.y_animation_wait(this, 1)
					U.y_animation_play(this, "idle", nil, store.tick_ts, 1)
				end
		end

		--4技能 秒杀
		--[[
		local a = instakill_attack
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			enemy = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false, a.vis_flags, a.vis_bans)
			if not enemy then
				SU.delay_attack(store, a, 0.2)
			else
				a.ts = store.tick_ts
				local b, emit_fx, emit_ps, emit_ts, node_offset

				local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
				local bullet_t = E:get_template(a.bullet)
				local bullet_speed = bullet_t.bullet.min_speed or 390
				local flight_time = bullet_t.bullet.flight_time
				if flight_time then
					node_offset = P:predict_enemy_node_advance(target, flight_time + a.shoot_time)
				else
					local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)

					node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
				end
				local t_pos

				if a.name == "conflagration" or a.name == "remove" then
					t_pos = P:node_pos(enemy.nav_path.pi, 1, enemy.nav_path.ni + node_offset)
				else
					t_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + node_offset)
				end

				local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

				U.animation_start(this, an, af, store.tick_ts)
				U.y_wait(store, fts(12))
				b = E:create_entity(a.bullet)
				b.pos.x, b.pos.y = this.pos.x + a.bullet_start_offset.x, this.pos.y + a.bullet_start_offset.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = V.vclone(enemy.pos)
				b.bullet.target_id = enemy.id
				b.bullet.source_id = this.id
				SU.stun_inc(enemy)
				queue_insert(store, b)
				U.y_animation_wait(this, 1)
			end
		end
		]]

		--普攻
		for _, i in pairs(this.ranged.order) do
			local a = this.ranged.attacks[i]

			if a.disabled then
				-- block empty
			elseif a.sync_animation and not this.render.sprites[1].sync_flag then
				-- block empty
			elseif store.tick_ts - a.ts < a.cooldown then
				-- block empty
			elseif math.random() > a.chance then
				-- block empty
			else
				local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
				local bullet_t = E:get_template(a.bullet)
				local bullet_speed = bullet_t.bullet.min_speed or 390
				local flight_time = bullet_t.bullet.flight_time
				local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false, a.vis_flags, a.vis_bans, function(v)
					local v_pos = v.pos

					if not v.nav_path then
						return false
					end

					local n_pos = P:node_pos(v.nav_path)

					if V.dist(n_pos.x, n_pos.y, v_pos.x, v_pos.y) > 5 then
						return false
					end

					if a.nodes_limit and (P:get_start_node(v.nav_path.pi) + a.nodes_limit > v.nav_path.ni or P:get_end_node(v.nav_path.pi) - a.nodes_limit < v.nav_path.ni) then
						return false
					end

					if v.motion and v.motion.speed then
						local node_offset

						if flight_time then
							node_offset = P:predict_enemy_node_advance(v, flight_time + a.shoot_time)
						else
							local dist = V.dist(origin.x, origin.y, v.pos.x, v.pos.y)

							node_offset = P:predict_enemy_node_advance(v, dist / bullet_speed)
						end

						if a.name == "fierymist" or a.name == "blazingbreath" then
							v_pos = P:node_pos(v.nav_path.pi, 1, v.nav_path.ni + node_offset)
						else
							v_pos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + node_offset)
						end
					end

					local dist_x = math.abs(v_pos.x - this.pos.x)
					local dist_y = math.abs(v_pos.y - this.pos.y)

					if a.name == "fierymist" or a.name == "blazingbreath" then
						return dist_x > a.min_range and dist_y < 80
					else
						return dist_x > 65
					end
				end)

				if target then
					local start_ts = store.tick_ts
					local b, emit_fx, emit_ps, emit_ts, node_offset

					if flight_time then
						node_offset = P:predict_enemy_node_advance(target, flight_time + a.shoot_time)
					else
						local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)

						node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
					end

					local t_pos

					if a.name == "conflagration" or a.name == "remove" then
						t_pos = P:node_pos(target.nav_path.pi, 1, target.nav_path.ni + node_offset)
					else
						t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
					end

					local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

					U.animation_start(this, an, af, store.tick_ts)

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_592_0
						end

						coroutine.yield()
					end

					S:queue(a.sound)

					b = E:create_entity(a.bullet)
					b.bullet.target_id = target.id
					b.bullet.source_id = this.id
					b.pos = V.vclone(this.pos)
					b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
					b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
					b.bullet.from = V.vclone(b.pos)
					b.bullet.to = V.v(t_pos.x, t_pos.y)

					queue_insert(store, b)

					if a.xp_from_skill then
						SU.hero_gain_xp_from_skill(this, this.hero.skills[a.xp_from_skill])
					end

					a.ts = start_ts

					if a.emit_ps and b.bullet.flight_time then
						local dest = V.vclone(b.bullet.to)

						if a.name == "conflagration" or a.name == "remove" then
							dest.y = dest.y + 15
						end

						emit_ts = store.tick_ts

						local ps = E:create_entity(a.emit_ps)
						local mspeed = V.dist(dest.x, dest.y, b.bullet.from.x, b.bullet.from.y) / b.bullet.flight_time

						ps.particle_system.emit_direction = V.angleTo(dest.x - b.bullet.from.x, dest.y - b.bullet.from.y)
						ps.particle_system.emit_speed = {
							mspeed,
							mspeed
						}
						ps.particle_system.flip_x = af
						ps.pos.x, ps.pos.y = b.bullet.from.x, b.bullet.from.y

						queue_insert(store, ps)

						emit_ps = ps
					end

					if a.emit_fx then
						local fx = E:create_entity(a.emit_fx)

						fx.pos.x, fx.pos.y = b.bullet.from.x, b.bullet.from.y
						fx.render.sprites[1].ts = store.tick_ts
						fx.render.sprites[1].flip_x = af

						if af and fx.render.sprites[1].offset.x then
							fx.render.sprites[1].offset.x = -1 * fx.render.sprites[1].offset.x
						end

						queue_insert(store, fx)

						emit_fx = fx
					end

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_592_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_592_0::
					if emit_ps then
						emit_ps.particle_system.emit = false
						emit_ps.particle_system.source_lifetime = 0
					end

					if emit_fx then
						emit_fx.render.sprites[1].hidden = true
					end
				end
			end
		end


		

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)

		force_idle_ts = nil

		coroutine.yield()
	end
end

--贝雷萨德普攻
scripts.fireball_beresad = {}
function scripts.fireball_beresad.update(this, store)
	local b = this.bullet
	local mspeed = b.min_speed
	local tl = store.tick_length
	local ps
	local targeted_hit_offset = false

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	local target = store.entities[b.target_id]

	if target then
		local dist = V.dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y)
		local node_offset = P:predict_enemy_node_advance(target, dist / mspeed)

		b.to = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)

		if band(target.vis.flags, F_FLYING) ~= 0 and target.unit and target.unit.hit_offset then
			targeted_hit_offset = true
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * tl do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * tl, this.pos.y + b.speed.y * tl
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	local hit_center = V.vclone(b.to)

	if target and target.unit and target.unit.hit_offset and targeted_hit_offset then
		hit_center.y = hit_center.y - target.unit.hit_offset.y
	end

	local targets = U.find_enemies_in_range(store.entities, hit_center, 0, b.damage_radius, b.vis_flags, b.vis_bans)

	if targets then
		for _, e in pairs(targets) do
			local d = SU.create_bullet_damage(b, e.id, this.id)

			d.xp_dest_id = b.source_id

			--击杀给金币
			queue_damage(store, d)
			will_kill = U.predict_damage(e, d) >= e.health.hp
			if will_kill then
				queue_insert(store, sfx)
				signal.emit("got-gold", V.vclone(e.pos) or V.v(0,0), b.got_gold)
			end

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = e.id
				mod.xp_dest_id = b.source_id

				queue_insert(store, mod)
			end
			break
		end
	end

	S:queue(this.sound_events.hit)

	local fx, air_hit

	if b.hit_fx_air and target and target.vis and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = E:create_entity(b.hit_fx_air)
		air_hit = true
	elseif b.hit_fx then
		fx = E:create_entity(b.hit_fx)
	end

	if fx then
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
	end

	if b.hit_decal and not air_hit then
		fx = E:create_entity(b.hit_decal)
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = 0

		queue_insert(store, fx)
	end

	SU_PLD.create_bullet_hit_payload(this, store)

	queue_remove(store, this)
end

--贝雷萨德1技能
scripts.flame = {}
function scripts.flame.insert(this, store, script)
	local b = this.bullet
	b.speed = SU.initial_parabola_speed(b.from, b.to, b.flight_time, 0)
	b.ts = store.tick_ts

	if this.flame_bullet then
		this.flame_bullets = {}
		local flip_x = b.to.x < b.from.x
		b.r = V.angleTo(b.to.x - b.from.x, b.to.y - b.from.y) - (flip_x and math.pi or 0)
		for i = 1, this.flames_count do
			local flame_bullet = E:create_entity(this.flame_bullet)
			for _, s in pairs(flame_bullet.render.sprites) do
				s.r = b.r
			end
			flame_bullet.start_ts = b.ts + this.delay_betweeen_flames * (i - 1)
			flame_bullet.ts = nil
			flame_bullet.pos.x, flame_bullet.pos.y = b.from.x, b.from.y
			table.insert(this.flame_bullets, flame_bullet)
		end
	end

	return true
end

function scripts.flame.update(this, store, script)
	local b = this.bullet

	while true do
		for i, flame_bullet in ipairs(this.flame_bullets) do
			if flame_bullet.ts == false then
				if i == #this.flame_bullets then
					queue_remove(store, this)
					return
				end
			elseif flame_bullet.ts then
				if store.tick_ts - flame_bullet.ts <= b.flight_time then
					flame_bullet.pos.x, flame_bullet.pos.y = SU_PLD.position_in_parabola(store.tick_ts - flame_bullet.ts, b.from, b.speed, 0)
				else
					queue_remove(store, flame_bullet)
					flame_bullet.ts = false
					if i == 1 then
						SU_PLD.make_bullet_damage_targets(this, store, nil)
						SU_PLD.create_bullet_hit_payload(this, store)
					end
				end
			elseif flame_bullet.start_ts and store.tick_ts >= flame_bullet.start_ts then
				flame_bullet.ts = store.tick_ts
				flame_bullet.start_ts = nil
				for _, s in pairs(flame_bullet.render.sprites) do
					s.ts = store.tick_ts + store.tick_length
				end
				queue_insert(store, flame_bullet)
			end
		end

		coroutine.yield()
	end
end

--贝雷萨德3技能
scripts.power_beresad_fireball = {}
function scripts.power_beresad_fireball.update(this, store, script)
	local b = this.bullet
	local mspeed = 10 * FPS
	local particle = E:create_entity("ps_power_fireball")

	particle.particle_system.track_id = this.id

	queue_insert(store, particle)

	local shadow = E:create_entity("decal_fireball_shadow")

	shadow.pos.x, shadow.pos.y = b.to.x, b.to.y
	shadow.render.sprites[1].ts = store.tick_ts

	queue_insert(store, shadow)

	local shadow_tracks = b.from.x ~= b.to.x

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		if shadow_tracks then
			shadow.pos.x = this.pos.x
		end

		coroutine.yield()
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y
	particle.particle_system.source_lifetime = 0

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, b.damage_radius)
	end)
	local damage_value = math.ceil(b.damage_factor * math.random(b.damage_min, b.damage_max))

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = damage_value
		d.damage_type = b.damage_type

		queue_damage(store, d)
	end

	S:queue(this.sound_events.hit)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if band(cell_type, TERRAIN_WATER) ~= 0 then
		local fx = E:create_entity("fx_explosion_water")

		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_water")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	else
		if b.hit_decal then
			local decal = E:create_entity(b.hit_decal)

			decal.pos = V.vclone(b.to)
			decal.render.sprites[1].ts = store.tick_ts

			queue_insert(store, decal)
		end

		if b.hit_fx then
			local fx = E:create_entity(b.hit_fx)

			fx.pos.x, fx.pos.y = b.to.x, b.to.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		end

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_earth")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	end

	SU_PLD.create_bullet_hit_payload(this, store)
	queue_remove(store, shadow)
	queue_remove(store, this)
end

scripts.soldier_golem_beresad = {}
function scripts.soldier_golem_beresad.update(this, store, script)
	local brk, stam

	this.reinforcement.ts = store.tick_ts
	this.render.sprites[1].ts = store.tick_ts
	this.nav_rally.center = nil
	this.nav_rally.pos = V.vclone(this.pos)

	local damage_factor = 1
	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	if this.sound_events and this.sound_events.raise then
		S:queue(this.sound_events.raise)
	end

	this.health_bar.hidden = true

	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)
	U.y_wait(store,fts(41))

	U.y_animation_play(this, "idle", nil, store.tick_ts, 1)

	if not this.health.dead then
		this.health_bar.hidden = nil
	end

	local starting_pos = V.vclone(this.pos)

	this.nav_rally.pos = starting_pos

	local patrol_pos = V.vclone(this.pos)

	patrol_pos.x, patrol_pos.y = patrol_pos.x + this.patrol_pos_offset.x, patrol_pos.y + this.patrol_pos_offset.y

	local nearest_node = P:nearest_nodes(patrol_pos.x, patrol_pos.y, nil, nil, false)[1]
	local pi, spi, ni = unpack(nearest_node)
	local npos = P:node_pos(pi, spi, ni)
	local patrol_pos_2 = V.vclone(this.pos)

	patrol_pos_2.x, patrol_pos_2.y = patrol_pos_2.x - this.patrol_pos_offset.x, patrol_pos_2.y - this.patrol_pos_offset.y

	local nearest_node = P:nearest_nodes(patrol_pos_2.x, patrol_pos_2.y, nil, nil, false)[1]
	local pi, spi, ni = unpack(nearest_node)
	local npos_2 = P:node_pos(pi, spi, ni)

	if V.dist2(patrol_pos.x, patrol_pos.y, npos.x, npos.y) > V.dist2(patrol_pos_2.x, patrol_pos_2.y, npos_2.x, npos_2.y) then
		patrol_pos = V.vclone(patrol_pos_2)
	end

	local idle_ts = store.tick_ts
	local patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)

	while true do
		if this.health.dead or this.reinforcement.duration and store.tick_ts - this.reinforcement.ts > this.reinforcement.duration then
			if this.health.hp > 0 then
				this.reinforcement.hp_before_timeout = this.health.hp
			end

			this.health.hp = 0
			U.y_animation_play(this, "death", nil, store.tick_ts, 1)
			U.y_wait(store,fts(15))
			queue_remove(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)

			idle_ts = store.tick_ts
			patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)
		else

			if this.melee then
				brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
					idle_ts = store.tick_ts
					patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)

					goto label_706_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)

				if patrol_cd < store.tick_ts - idle_ts then
					if this.nav_rally.pos == starting_pos then
						this.nav_rally.pos = patrol_pos
					else
						this.nav_rally.pos = starting_pos
					end

					idle_ts = store.tick_ts
					patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)
				end
			end
		end

		::label_706_0::

		coroutine.yield()
	end
end

--贝雷萨德大招

scripts.controller_beresad_ultimate = {}

function scripts.controller_beresad_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.controller_beresad_ultimate.update(this, store)

	local function flash_screen(fx)
		if store.tick_ts - fx.ts > fx.cooldown then
			local duration = U.frandom(this.flash_duration_min, this.flash_duration_max)
			local delay = U.frandom(this.flash_delay_min, this.flash_delay_max)
			local a1 = math.random(this.flash_l1_max_alphas[1], this.flash_l1_max_alphas[2])
			local a2 = this.flash_l2_max_alpha
			local a22 = this.flash_l2_min_alpha
			local delta = this.flash_delta
			local t1, t2, t3 = 0, delta, delta + duration

			fx.tween.props[1].keys = {
				{
					t1,
					0
				},
				{
					t2,
					a1
				},
				{
					t3,
					0
				}
			}
			fx.tween.ts = store.tick_ts
			fx.ts = store.tick_ts
			fx.cooldown = duration + U.frandom(0, 0.4)
		end
	end
	local a_ts = 0
	local target_id_list = {}
	local u_ts = store.tick_ts
	--S:queue(this.sound_events.insert)

	local overlay = E:create_entity("overlay_power_thunder_flash")

	overlay.pos.x, overlay.pos.y = REF_W / 2, REF_H / 2
	overlay.tween.props[2].keys = {
		{
			0,
			0
		},
		{
			0.5,
			this.flash_l2_max_alpha
		}
	}
	overlay.tween.props[2].ts = store.tick_ts

	queue_insert(store, overlay)
	flash_screen(overlay)

	while store.tick_ts - u_ts < this.duration do

		if store.tick_ts - a_ts > this.mod_cooldown then
			a_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.damage_radius, F_MOD, 0, function(v) 
				return not table.contains(target_id_list, v.id)
			end)

			if targets then
				for _, e in pairs(targets) do

					local mod = E:create_entity(this.mod)
					mod.modifier.target_id = e.id
					mod.modifier.source_id = this.id
					table.insert(target_id_list, e.id)
					queue_insert(store, mod)
				end
			end
		end

		if store.tick_ts - this.rain.ts > this.rain.cooldown then
			local r = this.rain

			r.ts = store.tick_ts

			local angle = U.frandom(r.angle_min, r.angle_max)

			for i = 1, r.count do
				angle = angle + U.frandom(-r.angle_between, r.angle_between)

				local dist = math.random(r.distance_min, r.distance_max)
				local ox, oy = V.rotate(angle, dist, 0)
				local delay = U.frandom(0.001, r.delay_max)
				local pos = V.v(math.random(-REF_OX, REF_W + REF_OX), math.random(0, REF_H))
				local e = E:create_entity(this.rain.drop)

				e.pos.x, e.pos.y = pos.x, pos.y
				e.render.sprites[1].name = e.render.sprites[1].name..(math.random(8,16))
				e.render.sprites[1].offset = V.v(-ox, -oy)
				e.render.sprites[1].keep_flip_x = true
				--原图角度左下倾斜45°，需要扭正
				e.render.sprites[1].r = angle + 45 * math.pi / 180
				e.render.sprites[1].alpha = math.random(r.alpha_min, r.alpha_max)
				e.tween.props[1].keys = {
					{
						0,
						0
					},
					{
						0.001,
						255
					}
				}
				e.tween.props[2] = E:clone_c("tween_prop")
				e.tween.props[2].keys = {
					{
						0,
						V.v(-ox, -oy)
					},
					{
						0.001,
						V.v(-ox, -oy)
					},
					{
						r.duration,
						V.v(0, 0)
					}
				}
				e.tween.props[2].name = "offset"
				e.tween.ts = store.tick_ts + delay

				queue_insert(store, e)

				local e = E:create_entity(this.rain.splash)

				e.pos.x, e.pos.y = pos.x, pos.y
				e.render.sprites[1].ts = store.tick_ts + delay + r.duration

				queue_insert(store, e)
			end
		end
		coroutine.yield()
	end

	U.y_wait(store, overlay.cooldown)

	overlay.tween.remove = true
	overlay.tween.props[1].keys = {
		{
			0,
			overlay.render.sprites[1].alpha
		},
		{
			0.5,
			0
		}
	}
	overlay.tween.props[2].keys = {
		{
			0,
			overlay.render.sprites[2].alpha
		},
		{
			0.5,
			0
		}
	}
	overlay.tween.ts = store.tick_ts
	overlay.tween.props[2].ts = nil

	queue_remove(store, this)
end

scripts.hero_naga = {}

function scripts.hero_naga.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_murglun = {}

function scripts.hero_murglun.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	--普攻
	local b = E:get_template(this.ranged.attacks[1].bullet)

	b.bullet.damage_max = ls.ranged_damage_max[hl]
	b.bullet.damage_min = ls.ranged_damage_min[hl]

	local s 

	--1技能 普攻增强
	s = this.hero.skills.magma_pool
	if initial and s.level > 0 then
		local b = E:get_template(this.ranged.attacks[1].bullet)
		b.bullet.hit_payload = s.pay_load_name
		p = E:get_template(s.pay_load_name)
		p.aura.duration = s.duration[s.level]
		m = E:get_template(p.aura.mod)
		m.dps.damage_min = s.damage[s.level]
		m.dps.damage_max = s.damage[s.level]
	end

	--2技能 增伤
	s = this.hero.skills.tar_maker
	if initial and s.level > 0 then
		local a = this.auras.list[1]
		a.disabled = false
		a.damage_inc = s.rate[s.level]
		mod = E:get_template(a.mod)
		mod.range_factor = s.rate[s.level]
	end

	--3技能 秒杀
	s = this.hero.skills.geyser
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[1]
		a.cooldown = s.cooldown[s.level]
		a.disabled = false
	end

	--4技能 岩浆池
	s = this.hero.skills.infernal_heat
	if initial and s.level > 0 then
		local a = this.ranged.attacks[2]
		a.cooldown = s.cooldown[s.level]
		a.disabled = false
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		a = E:get_template(u.aura.entity)
		a.bullet.damage_min = s.boss_damage[s.level]
		a.bullet.damage_max = s.boss_damage[s.level]
	end

end

function scripts.hero_murglun.update(this, store, script)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts

	local ranged_attack = this.ranged.attacks[1] --普攻
	local lava_pool_attack = this.ranged.attacks[2] --岩浆池
	local instakill_attack = this.timed_attacks.list[1] --秒杀
	--被动应该需要新创造一个entity，因为需要走A、跟踪
	--local lava_blood_attack = this.timed_attacks.list[2]--被动技能
	local heat_aura_attack =  this.auras.list[1] --增伤

	local attack, skill
	this.ranged.order = {2,1}
	ranged_attack.ts = store.tick_ts
	instakill_attack.ts = store.tick_ts
	lava_pool_attack.ts = store.tick_ts
	heat_aura_attack.ts = store.tick_ts
	--lava_blood_attack = store.tick_ts

	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = false
	force_idle_ts = true

	local lava_blood = E:create_entity("decal_lava_blood_murglun")
	lava_blood.owner = this
	lava_blood.owner_id = this.id
	queue_insert(store, lava_blood)


	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			--需要移除mod
			SU.y_hero_new_rally(store, this)
			local mods = table.filter(store.entities, function(_, e)
				return e.modifier and e.modifier.source_id == this.id
			end)

			for _, m in pairs(mods) do
				queue_remove(store, m)
			end
		end

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		end

		--3技能秒杀
		a = instakill_attack
		skill = this.hero.skills.geyser
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_nearest_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not target then
				SU.delay_attack(store, a, 0.13333333333333333)
			else
				SU.hero_gain_xp_from_skill(this, skill)

				a.ts = store.tick_ts

				--[[
				local steps = math.floor(fts(9) / store.tick_length)
				local step_x, step_y = V.mul(1 / steps, target.pos.x - this.pos.x, target.pos.y - this.pos.y - 1)

				for i = 1, steps do
					this.pos.x, this.pos.y = this.pos.x + step_x, this.pos.y + step_y

					coroutine.yield()
				end
				]]--

				--[[
				local fx = E:create_entity("fx_dragon_feast")

				fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
				fx.render.sprites[1].ts = store.tick_ts
				]]

				queue_insert(store, fx)

				local d = E:create_entity("damage")

				d.damage_type = DAMAGE_INSTAKILL
				d.value = 0
				d.target_id = target.id
				d.source_id = this.id

				local actual_damage = U.predict_damage(target, d)

				if band(target.vis.bans, DAMAGE_INSTAKILL) == 0 and band(target.vis.flags, bor(F_BOSS,F_MINIBOSS)) == 0 then
					SU.stun_inc(target)
					S:queue(a.sound)
					U.y_animation_play(this, "geiser", nil, store.tick_ts, 1)
					if target.pos then
						d.damage_type = DAMAGE_INSTAKILL

						local fxn, default_fx

						--if target.unit.explode_fx and target.unit.explode_fx ~= "fx_unit_explode" then
						--	fxn = target.unit.explode_fx
						--	default_fx = false
						--else
						fxn = "fx_dragon_geiser_explode"
						
						--default_fx = true
						--end

						local fx = E:create_entity(fxn)
						local fxs = fx.render.sprites[1]

						fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
						fxs.ts = store.tick_ts

						--if default_fx then
							--fxs.scale = fxs.size_scales[target.unit.size]
						--else
						--	fxs.name = fxs.size_names[target.unit.size]
						--end

						queue_insert(store, fx)

						fxn = "fx_dragon_geiser_explode_ash"
						local fx2 = E:create_entity(fxn)
						local fxs2 = fx2.render.sprites[1]

						fx2.pos.x, fx2.pos.y = target.pos.x, target.pos.y
						fxs2.ts = store.tick_ts
						queue_insert(store, fx2)
					else
						d.damage_type = DAMAGE_INSTAKILL
					end
				end

				queue_damage(store, d)
				SU.stun_dec(target)
				U.y_animation_wait(this)

				force_idle_ts = true

				--goto label_38611_1
			end
		end

		--普攻/hit_payload
		local a = ranged_attack
		--普攻，直接沿用2代骨龙
		for _, i in pairs(this.ranged.order) do
			local a = this.ranged.attacks[i]

			if a.disabled then
				-- block empty
			elseif a.sync_animation and not this.render.sprites[1].sync_flag then
				-- block empty
			elseif store.tick_ts - a.ts < a.cooldown then
				-- block empty
			elseif math.random() > a.chance then
				-- block empty
			else
				local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
				local bullet_t = E:get_template(a.bullet)
				local bullet_speed = bullet_t.bullet.min_speed
				local flight_time = bullet_t.bullet.flight_time
				local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans, function(v)
					local v_pos = v.pos

					if not v.nav_path then
						return false
					end

					local n_pos = P:node_pos(v.nav_path)

					if V.dist(n_pos.x, n_pos.y, v_pos.x, v_pos.y) > 5 then
						return false
					end

					if a.nodes_limit and (P:get_start_node(v.nav_path.pi) + a.nodes_limit > v.nav_path.ni or P:get_end_node(v.nav_path.pi) - a.nodes_limit < v.nav_path.ni) then
						return false
					end

					if v.motion and v.motion.speed then
						local node_offset

						if flight_time then
							node_offset = P:predict_enemy_node_advance(v, flight_time + a.shoot_time)
						else
							local dist = V.dist(origin.x, origin.y, v.pos.x, v.pos.y)

							node_offset = P:predict_enemy_node_advance(v, dist / bullet_speed)
						end

						v_pos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + node_offset)
					end

					local dist_x = math.abs(v_pos.x - this.pos.x)
					local dist_y = math.abs(v_pos.y - this.pos.y)

					return dist_x > 45
				end)

				if target then
					local start_ts = store.tick_ts
					local b, emit_fx, emit_ps, emit_ts
					local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)
					local node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
					local t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
					local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

					U.animation_start(this, an, af, store.tick_ts)

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_38611_0
						end

						coroutine.yield()
					end

					S:queue(a.sound)

					b = E:create_entity(a.bullet)
					b.bullet.target_id = target.id
					b.bullet.source_id = this.id
					b.pos = V.vclone(this.pos)
					b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
					b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
					b.bullet.from = V.vclone(b.pos)
					
					b.bullet.to = V.v(t_pos.x, t_pos.y)
					if i == 2 then
						local nearest_node = P:nearest_nodes(t_pos.x, t_pos.y, nil, nil, false)[1]
						local pi, spi, ni = unpack(nearest_node)
						local npos = P:node_pos(pi, spi, ni)
						b.bullet.to = npos
					end
					
					--print("damage radius"..b.bullet.damage_radius)
					--b.bullet.damage_radius = 20 + 20 * this.hero.skills.explosion.level

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_38611_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_38611_0::

					--goto label_38611_1
				end
			end
		end

		--2技能加伤害
		if store.tick_ts - heat_aura_attack.ts > heat_aura_attack.cooldown and he.skills.tar_maker.level >= 1 then
			heat_aura_attack.ts = store.tick_ts
			local eagle_range = heat_aura_attack.range
			local existing_mods = table.filter(store.entities, function(_, e)
				return e.modifier and e.template_name == heat_aura_attack.mod and e.modifier.level >= he.skills.tar_maker.level
			end)
			local busy_ids = table.map(existing_mods, function(k, v)
				return v.modifier.target_id
			end)
			local towers = table.filter(store.entities, function(_, e)
				return e.tower and e ~= this.owner and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(heat_aura_attack.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, eagle_range)
			end)

			for _, tower in pairs(towers) do
				local new_mod = E:create_entity(heat_aura_attack.mod)

				new_mod.modifier.level = he.skills.tar_maker.level
				new_mod.modifier.target_id = tower.id
				new_mod.modifier.source_id = this.id
				new_mod.modifier.duration = 1
				new_mod.pos = tower.pos

				queue_insert(store, new_mod)
			end
		end

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)
		force_idle_ts = nil

		::label_38611_1::
		
		coroutine.yield()
	end

	queue_remove(store, lava_blood)
end

scripts.fireball_murglun = {}

function scripts.fireball_murglun.update(this, store)
	local b = this.bullet
	local mspeed = b.min_speed
	local tl = store.tick_length
	local ps
	local targeted_hit_offset = false

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	local target = store.entities[b.target_id]

	if target then
		local dist = V.dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y)
		local node_offset = P:predict_enemy_node_advance(target, dist / mspeed)

		b.to = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)

		if band(target.vis.flags, F_FLYING) ~= 0 and target.unit and target.unit.hit_offset then
			targeted_hit_offset = true
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * tl do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * tl, this.pos.y + b.speed.y * tl
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	local hit_center = V.vclone(b.to)

	if target and target.unit and target.unit.hit_offset and targeted_hit_offset then
		hit_center.y = hit_center.y - target.unit.hit_offset.y
	end

	local targets = U.find_enemies_in_range(store.entities, hit_center, 0, b.damage_radius, b.vis_flags, b.vis_bans)

	if targets then
		for _, e in pairs(targets) do
			local d = SU.create_bullet_damage(b, e.id, this.id)

			d.xp_dest_id = b.source_id

			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = e.id
				mod.xp_dest_id = b.source_id

				queue_insert(store, mod)
			end
			break
		end
	end

	S:queue(this.sound_events.hit)

	local fx, air_hit

	if b.hit_fx_air and target and target.vis and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = E:create_entity(b.hit_fx_air)
		air_hit = true
	elseif b.hit_fx then
		fx = E:create_entity(b.hit_fx)
	end

	if fx then
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
	end

	if b.hit_decal and not air_hit then
		fx = E:create_entity(b.hit_decal)
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = 0

		queue_insert(store, fx)
	end

	SU_PLD.create_bullet_hit_payload(this, store)

	queue_remove(store, this)
end

scripts.hero_murglun_ultimate = {}
function scripts.hero_murglun_ultimate.can_fire_fn(this, x, y, store)
	return not GR:cell_is(x, y, TERRAIN_FAERIE) and P:valid_node_nearby(x, y, 1.4285714285714286, NF_POWER_3)
end

function scripts.hero_murglun_ultimate.update(this, store)
	local start_y = store.visible_coords and store.visible_coords.top or REF_H
	local bdt
	local a = this.aura
	local owner_pos = V.vclone(this.pos)

	print(a.loops)
	print("insert ultimate, owner_pos is "..this.pos.x..this.pos.y)
	if not owner_pos then
		log.error("owner %s was not found. bailing out", a.source_od)
	else
		do
			local bdy = math.abs(owner_pos.y - start_y)
			local tpl = E:get_template(a.entity)

			bdt = bdy / tpl.bullet.max_speed
		end

		for i = 1, a.loops do
			local b = E:create_entity(a.entity)

			local tx = owner_pos.x + math.random(-35, 35)
			local ty = owner_pos.y + math.random(-35, 35)
			local dh = start_y - ty
			local dx = dh * 0.4

			b.pos.x, b.pos.y = tx + dx, start_y
			b.bullet.to = V.v(tx, ty)

			b.bullet.from = V.vclone(b.pos)

			queue_insert(store, b)
			U.y_wait(store, a.delay)
		end
	end

	queue_remove(store, this)
end

scripts.power_murglun_fireball = {}

function scripts.power_murglun_fireball.update(this, store, script)
	local b = this.bullet
	local mspeed = 10 * FPS
	local particle = E:create_entity("ps_power_fireball")

	particle.particle_system.track_id = this.id

	queue_insert(store, particle)

	local shadow = E:create_entity("decal_fireball_shadow")

	shadow.pos.x, shadow.pos.y = b.to.x, b.to.y
	shadow.render.sprites[1].ts = store.tick_ts

	queue_insert(store, shadow)

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	particle.particle_system.source_lifetime = 0

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, b.damage_radius)
	end)
	local damage_value = math.ceil(b.damage_factor * math.random(b.damage_min, b.damage_max))

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = damage_value
		d.damage_type = b.damage_type 
		if enemy.vis.flags and band(enemy.vis.flags, bor(F_BOSS, F_MINIBOSS)) ~= 0 then
			d.damage_type = DAMAGE_TRUE
		end

		queue_damage(store, d)
	end

	S:queue(this.sound_events.hit)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if band(cell_type, TERRAIN_WATER) ~= 0 then
		local fx = E:create_entity("fx_explosion_water")

		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_water")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	else
		if b.hit_decal then
			local decal = E:create_entity(b.hit_decal)

			decal.pos = V.vclone(b.to)
			decal.render.sprites[1].ts = store.tick_ts

			queue_insert(store, decal)
		end

		if b.hit_fx then
			local fx = E:create_entity(b.hit_fx)

			fx.pos.x, fx.pos.y = b.to.x, b.to.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		end

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_earth")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	end

	queue_remove(store, shadow)
	queue_remove(store, this)
end

scripts.controller_lava_blood_murglun = {}
function scripts.controller_lava_blood_murglun.update(this, store, script)
	local a = this.ranged.attacks[1]
	local a_ts = store.tick_ts

	while true do
		if a.cooldown < store.tick_ts - a_ts and this.owner.health.dead == false then
			a_ts = store.tick_ts
			local b = E:create_entity(a.bullet)
			local tx = this.owner.pos.x + math.random(-20, 20)
			local ty = this.owner.pos.y
			
			b.pos.x, b.pos.y = tx, ty + a.start_offset_y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(tx, ty)

			queue_insert(store, b)
		end
		coroutine.yield()
	end
end

scripts.lava_blood_murglun = {}

function scripts.lava_blood_murglun.update(this, store, script)
	local b = this.bullet
	local mspeed = 10 * FPS

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, b.damage_radius)
	end)
	local damage_value = math.ceil(b.damage_factor * math.random(b.damage_min, b.damage_max))

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = damage_value
		d.damage_type = b.damage_type 

		queue_damage(store, d)
	end

	S:queue(this.sound_events.hit)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if band(cell_type, TERRAIN_WATER) ~= 0 then
		local fx = E:create_entity("fx_explosion_water")

		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)

		--[[
		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_water")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
		]]
	else
		if b.hit_decal then
			local decal = E:create_entity(b.hit_decal)

			decal.pos = V.vclone(b.to)
			decal.render.sprites[1].ts = store.tick_ts

			queue_insert(store, decal)
		end

		if b.hit_fx then
			local fx = E:create_entity(b.hit_fx)

			fx.pos.x, fx.pos.y = b.to.x, b.to.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		end

		--[[
		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_earth")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
		]]
	end

	queue_remove(store, shadow)
	queue_remove(store, this)
end

scripts.range_mod_murglun = {}

function scripts.range_mod_murglun.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert range_mod_balloon to entity %s - ", target.id, target.template_name)

		return false
	end

	if target.tower and target.tower.damage_factor then
		target.tower.damage_factor = target.tower.damage_factor * this.range_factor
	end

	--if target.barrack then
	--	target.barrack.rally_range = target.barrack.rally_range * (this.range_factor + m.level * this.range_factor_inc)
	--end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.range_mod_murglun.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and target.tower and target.tower.damage_factor then
		target.tower.damage_factor = target.tower.damage_factor / this.range_factor 
	end

	--if target and target.barrack then
	--	target.barrack.rally_range = target.barrack.rally_range / (this.range_factor + m.level * this.range_factor_inc)
	--end

	return true
end

scripts.hero_mammoth = {}

function scripts.hero_mammoth.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

scripts.hero_isfet = {}

function scripts.hero_isfet.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end
end

--卢塞尔娜

scripts.hero_lucerna = {}

function scripts.hero_lucerna.get_info(this)
	local m = E:get_template("bullet_lucerna")
	local min, max = m.bullet.damage_min, m.bullet.damage_max

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		damage_type = DAMAGE_MAGICAL,
		armor = this.health.armor,
		magic_armor = this.health.magic_armor,
		respawn = this.health.dead_lifetime
	}
end

function scripts.hero_lucerna.insert(this, store)
	this.hero.fn_level_up(this, store, true)
	S:queue("HeroPaladinTauntIntro")
	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_lucerna.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.health.magic_armor = ls.magic_armor[hl]

	local b = E:get_template(this.ranged.attacks[1].bullet)
	b.bullet.damage_min = ls.ranged_damage_min[hl]
	b.bullet.damage_max = ls.ranged_damage_max[hl]

	--1技能 恐惧
	s = this.hero.skills.scurvy_vissage
	if initial and s.level > 0 then
		this.timed_attacks.list[3].disabled = nil
		e1 = E:get_template(this.timed_attacks.list[3].entity)
		e2 = E:get_template(this.timed_attacks.list[3].damage_entity)
		e1.modifier.duration = s.duration[s.level]
		e2.modifier.duration = s.damage_duration[s.level]
	end

	--2技能 弹幕
	s = this.hero.skills.fire_at_will
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = nil
		e = E:get_template(this.timed_attacks.list[2].entity)
		e.bullet.damage_min = s.damage_config[s.level]
		e.bullet.damage_max = s.damage_config[s.level]
	end

	--3技能 召唤
	s = this.hero.skills.damned_crew
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = nil
		this.timed_attacks.list[1].cooldown = s.cooldown[s.level]
	end
	
	--4技能 普攻增强
	s = this.hero.skills.pirates_pillage
	if initial and s.level > 0 then
		local b = E:get_template(this.ranged.attacks[1].bullet)
		b.bullet.pirates_pillage_rate = s.rate[s.level]
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		
		local e = E:get_template(u.entity)
		e.level = s.level

	end


end

function scripts.hero_lucerna.update(this, store, script)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts

	local ranged_attack = this.ranged.attacks[1] --普攻
	local golem_attack = this.timed_attacks.list[1] --召唤
	local ability_attack = this.timed_attacks.list[2] --弹幕
	local fear_attack = this.timed_attacks.list[3] --恐惧
	local ultimate_ts = 0
	local ultimate_auto = false
	if this.template_name == "hero_lucerna_2" then
		ultimate_auto = true
	end

	local attack, skill
	ranged_attack.ts = 0--store.tick_ts
	golem_attack.ts = 0--store.tick_ts
	ability_attack.ts = 0--store.tick_ts
	fear_attack.ts = 0--store.tick_ts

	U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
	this.health_bar.hidden = false
	force_idle_ts = true

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			--需要移除mod
			SU.y_hero_new_rally(store, this)
			local mods = table.filter(store.entities, function(_, e)
				return e.modifier and e.modifier.source_id == this.id
			end)

			for _, m in pairs(mods) do
				queue_remove(store, m)
			end
		end

		if SU.hero_level_up(store, this) then
			--U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			U.animation_start_group(this, "levelup", nil, store.tick_ts, false, "layers")
		end

		--1技能 恐惧
		local a = fear_attack
		local skill = this.hero.skills.scurvy_vissage
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local start_ts, bdy, bdt, au
			local fired_aura = false
			local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not targets then
				SU.delay_attack(store, a, 0.2)
			else
				a.ts = store.tick_ts
				U.animation_start_group(this, "fear", nil, store.tick_ts, false, "layers")

				local fx = E:create_entity(a.lucerna_animation)
				fx.pos = V.v(this.pos.x, this.pos.y)
				fx.render.sprites[1].ts = store.tick_ts
				queue_insert(store, fx)

				S:queue(a.sound)
				U.y_wait(store, a.cast_time)
				for _, e in pairs(targets) do
					local mod = E:create_entity(a.entity)
					mod.modifier.target_id = e.id
					mod.modifier.source_id = this.id
					mod.modifier.level = skill.level
					queue_insert(store, mod)

					local mod2 = E:create_entity(a.damage_entity)
					mod2.modifier.target_id = e.id
					mod2.modifier.source_id = this.id
					mod2.modifier.level = skill.level
					queue_insert(store, mod2)
					
				end
				U.y_animation_wait(this, 1)
				SU.hero_gain_xp_from_skill(this, skill)
				U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
				--goto label_32530_1
			end
		end

		--2技能 轰炸
		a = this.timed_attacks.list[2]
		skill = this.hero.skills.fire_at_will
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not target then
				SU.delay_attack(store, a, 0.4)
			else
				local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, {
					pi
				}, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, a, 0.4)
				else
					local s_pi, s_spi, s_ni = unpack(nodes[1])
					local flip = target.pos.x < this.pos.x
					U.animation_start_group(this, "ability", nil, store.tick_ts, false, "layers")
					--skeleton_glow_fx()
					U.y_wait(store, a.spawn_time)

					local delay = 0
					local n_step = ni < s_ni and -2 or 2

					ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

					for i = 1, skill.count[skill.level] do
						local e = E:create_entity(a.entity)

						e.pos = P:node_pos(pi, spi, ni)
						e.bullet.from = V.vclone(e.pos)
						e.bullet.to = V.vclone(e.pos)
						--e.render.sprites[1].prefix = e.render.sprites[1].prefix
						e.render.sprites[1].flip_x = not flip
						e.delay = delay
						e.bullet.source_id = this.id
						e.bullet.level = this.hero.skills.fire_at_will.level

						queue_insert(store, e)

						delay = delay + fts(U.frandom(1, 3))
						ni = ni + n_step
						spi = km.zmod(spi + math.random(1, 2), 3)
					end

					U.y_animation_wait(this)

					force_idle_ts = true
					a.ts = store.tick_ts

					SU.hero_gain_xp_from_skill(this, skill)
					U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
					--goto label_32530_1
				end
			end

		end

		--3技能
		a = this.timed_attacks.list[1]
		skill = this.hero.skills.damned_crew

		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range * 1.5, a.vis_flags, a.vis_bans, function(v)
				local offset = P:predict_enemy_node_advance(v, a.spawn_time)
				local ppos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + offset)

				return P:is_node_valid(v.nav_path.pi, v.nav_path.ni + offset, NF_RALLY) and GR:cell_is_only(ppos.x, ppos.y, TERRAIN_LAND)
			end)
			local spawn_pos

			if target then
				local offset = P:predict_enemy_node_advance(target, a.spawn_time)

				spawn_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + offset)
			else
				--local positions = P:get_all_valid_pos(this.pos.x, this.pos.y, a.min_range, a.max_range, TERRAIN_LAND, nil, NF_RALLY)

				--spawn_pos = table.random(positions)
			end

			if not spawn_pos then
				SU.delay_attack(store, a, 0.4)
			else
				S:queue(a.sound)
				U.animation_start_group(this, "summon", nil, store.tick_ts, false, "layers")
				--skeleton_glow_fx()
				U.y_wait(store, a.spawn_time)

				local offset_spawn_pos = {{0,-20},{-20,10},{20,10}}
				for i = 1, 2 do
					local e = E:create_entity(a.entity)

					spawn_pos.x = spawn_pos.x + offset_spawn_pos[i][1]
					spawn_pos.y = spawn_pos.y + offset_spawn_pos[i][2]
					e.pos = V.vclone(spawn_pos)
					e.nav_rally.pos = V.vclone(spawn_pos)
					e.nav_rally.center = V.vclone(spawn_pos)
					e.render.sprites[1].flip_x = math.random() < 0.5

					queue_insert(store, e)

					e.owner = this

					U.y_animation_wait(this)
				end

				force_idle_ts = true
				a.ts = store.tick_ts

				SU.hero_gain_xp_from_skill(this, skill)

				--goto label_32530_1
			end
		end

		--大招
		if ultimate_auto and store.tick_ts - ultimate_ts > 48 then
			targets = U.find_enemies_in_range(store.entities, this.pos, 0, 150, fear_attack.vis_flags, fear_attack.vis_bans)
			if targets and #targets >= 2 then
				e = E:create_entity("totem_lucerna")
				e.pos = V.vclone(this.pos) 
				queue_insert(store, e)
			end
			ultimate_ts = store.tick_ts
		end

		--普攻/hit_payload
		local a = ranged_attack
		--普攻，直接沿用2代骨龙
		for _, i in pairs(this.ranged.order) do
			local a = this.ranged.attacks[i]

			if a.disabled then
				-- block empty
			elseif a.sync_animation and not this.render.sprites[1].sync_flag then
				-- block empty
			elseif store.tick_ts - a.ts < a.cooldown then
				-- block empty
			elseif math.random() > a.chance then
				-- block empty
			else
				local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
				local bullet_t = E:get_template(a.bullet)
				local bullet_speed = bullet_t.bullet.min_speed
				local flight_time = bullet_t.bullet.flight_time
				--local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans, function(v)
				local target = ULH.find_first_enemy(store.entities, this.pos, 0, a.max_range, false, a.vis_flags, a.vis_bans, function(v)
					local v_pos = v.pos

					if not v.nav_path then
						return false
					end

					local n_pos = P:node_pos(v.nav_path)

					if V.dist(n_pos.x, n_pos.y, v_pos.x, v_pos.y) > 5 then
						return false
					end

					if a.nodes_limit and (P:get_start_node(v.nav_path.pi) + a.nodes_limit > v.nav_path.ni or P:get_end_node(v.nav_path.pi) - a.nodes_limit < v.nav_path.ni) then
						return false
					end

					if v.motion and v.motion.speed then
						local node_offset

						if flight_time then
							node_offset = P:predict_enemy_node_advance(v, flight_time + a.shoot_time)
						else
							local dist = V.dist(origin.x, origin.y, v.pos.x, v.pos.y)

							node_offset = P:predict_enemy_node_advance(v, dist / bullet_speed)
						end

						v_pos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + node_offset)
					end

					local dist_x = math.abs(v_pos.x - this.pos.x)
					local dist_y = math.abs(v_pos.y - this.pos.y)

					return dist_x > 45
				end)

				if target then
					local start_ts = store.tick_ts
					local b, emit_fx, emit_ps, emit_ts
					local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)
					local node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
					local t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
					local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

					--U.animation_start(this, an, af, store.tick_ts)
					U.animation_start_group(this, an, af, store.tick_ts, false, "layers")

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
						end

						coroutine.yield()
					end

					S:queue(a.sound)

					b = E:create_entity(a.bullet)
					b.bullet.target_id = target.id
					b.bullet.source_id = this.id
					b.pos = V.vclone(this.pos)
					b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
					b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
					b.bullet.from = V.vclone(b.pos)
					--b.bullet.to = V.v(t_pos.x + (af and -1 or 1) * math.random(20, 80), t_pos.y + math.random(10, 40))
					b.bullet.to = V.v(t_pos.x, t_pos.y)
					if i == 2 then
						local nearest_node = P:nearest_nodes(t_pos.x, t_pos.y, nil, nil, false)[1]
						local pi, spi, ni = unpack(nearest_node)
						local npos = P:node_pos(pi, spi, ni)
						b.bullet.to = npos
					end
					
					--print("damage radius"..b.bullet.damage_radius)
					--b.bullet.damage_radius = 20 + 20 * this.hero.skills.explosion.level

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_32530_0::

					--goto label_32530_1
				end
			end
		end

		::label_32530_1::

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)
		force_idle_ts = nil
		
		coroutine.yield()
	end

end

scripts.missile_lucerna = {}

function scripts.missile_lucerna.insert(this, store, script)
	local b = this.bullet
	local ps = E:create_entity(b.particles_name)

	ps.particle_system.track_id = this.id

	queue_insert(store, ps)

	return true
end

function scripts.missile_lucerna.update(this, store, script)
	local b = this.bullet
	local target = store.entities[b.target_id]
	local mspeed = b.min_speed
	local rot_dir = 1
	local follow = false
	local max_seek_angle = b.max_seek_angle or 0.38 --b.max_seek_angle or 0.2

	if this.render.sprites[1].animated then
		U.animation_start(this, "flying", nil, store.tick_ts, -1)
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		if b.rot_dir_from_long_angle and target then
			rot_dir = target.pos.x < this.pos.x and -1 or 1
		elseif b.speed.x < 0 then
			rot_dir = -1
		end

		coroutine.yield()
	end

	if not target or target.health and target.health.dead then
		local ref_pos = target and target.pos or this.pos

		target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
		--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
	end

	if target then
		b.to.x, b.to.y = target.pos.x, target.pos.y

		if target.unit.hit_offset then
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		if not target or target.health and target.health.dead or band(target.vis.bans, b.vis_flags) ~= 0 then
			local ref_pos = target and target.pos or this.pos

			--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
			target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
			if b.rot_dir_from_long_angle and target then
				rot_dir = target.pos.x < this.pos.x and -1 or 1
			end
		end

		if target then
			b.to.x, b.to.y = target.pos.x, target.pos.y

			if target.unit.hit_offset then
				b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
			end
		end

		local d_angle = V.angleTo(b.speed.x, b.speed.y, b.to.x - this.pos.x, b.to.y - this.pos.y)

		if max_seek_angle < math.abs(d_angle) then
			local rot = b.turn_speed * store.tick_length * rot_dir
			local dir = V.angleTo(b.speed.x, b.speed.y)

			if dir > math.pi / 3 and dir < 2 * math.pi / 3 then
				rot = rot * (b.turn_helicoidal_factor or 1.5)
			end

			b.speed.x, b.speed.y = V.rotate(rot, b.speed.x, b.speed.y)
		else
			mspeed = mspeed + 30 * math.ceil(mspeed * 0.03333333333333333 * b.acceleration_factor)
			mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
			b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		end

		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		coroutine.yield()
	end

	if b.damage_radius and b.damage_radius > 0 then
		local enemies = table.filter(store.entities, function(k, v)
			return v.enemy and v.vis and v.unit and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(V.v(v.pos.x + v.unit.hit_offset.x, v.pos.y + v.unit.hit_offset.y), b.to, b.damage_radius)
		end)
		local alchemical_powder = UP:get_upgrade("engineer_alchemical_powder")
		local alchemical_powder_on = alchemical_powder and math.random() < alchemical_powder.chance
		local shock_and_awe = nil -- = UP:get_upgrade("engineer_shock_and_awe")

		for _, enemy in pairs(enemies) do
			local enemy_pos = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			local d = E:create_entity("damage")
			d.xp_dest_id = b.source_id
			d.source_id = this.id
			d.target_id = enemy.id
			d.damage_type = b.damage_type
			d.reduce_armor = b.reduce_armor
			d.reduce_magic_armor = b.reduce_magic_armor

			--每命中一个敌人，有一定几率奖励金币
			if math.random() < b.pirates_pillage_rate then
				signal.emit("got-gold", V.vclone(enemy.pos) or V.v(0,0), b.got_gold)
			end

			if alchemical_powder_on then
				d.value = b.damage_max
			else
				local dist_factor = U.dist_factor_inside_ellipse(enemy_pos, this.pos, b.damage_radius)

				d.value = math.floor(b.damage_max - (b.damage_max - b.damage_min) * dist_factor)
			end
			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end

			if shock_and_awe and band(enemy.vis.bans, F_STUN) == 0 and band(enemy.vis.flags, bor(F_BOSS, F_CLIFF, F_FLYING)) == 0 and math.random() < shock_and_awe.chance then
				local mod = E:create_entity("mod_shock_and_awe")

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end
		end
	elseif target then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = target.id

			queue_insert(store, mod)
		end
	end

	local fx

	if b.hit_fx_air and target and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = b.hit_fx_air

		S:queue(this.sound_events.hit)
	elseif b.hit_fx_water and not target and band(GR:cell_type(b.to.x, b.to.y), TERRAIN_WATER) ~= 0 then
		fx = b.hit_fx_water

		S:queue(this.sound_events.hit_water)
	elseif b.hit_fx then
		fx = b.hit_fx

		S:queue(this.sound_events.hit)
	end

	if fx then
		local is_air = target and band(target.vis.flags, F_FLYING) ~= 0
		local sfx = E:create_entity(fx)

		if b.hit_fx_ignore_hit_offset and target and not is_air then
			sfx.pos.x, sfx.pos.y = target.pos.x, target.pos.y
		else
			sfx.pos.x, sfx.pos.y = this.pos.x, this.pos.y
		end

		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

--卢塞尔娜大招
scripts.controller_lucerna_ultimate = {}
function scripts.controller_lucerna_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

scripts.lucerna_ultimate = {}
function scripts.lucerna_ultimate.update(this, store)
	e = E:create_entity(this.entity)
	e.pos = V.v(this.pos.x, this.pos.y) 
	queue_insert(store,e)
end


scripts.totem_lucerna = {}
function scripts.totem_lucerna.update(this, store)
	local a2 = this.attacks.list[1]
	this.tick_ts = store.tick_ts
	a2.ts = store.tick_ts
	local start_ts = store.tick_ts
	--每个怪物只能被选中一次,瞄准后需要
	local selected_id_table = {}
	U.animation_start(this, "spawn", nil, store.tick_ts, false, 2)
	S:queue(this.sound_events.sound_in)
	U.y_wait(store, fts(15))
	this.render.sprites[1].hidden = false

	U.animation_start(this, "run", nil, store.tick_ts, true, 1)
	U.animation_start(this, "idle", nil, store.tick_ts, true, 2)

	while true do
		if store.tick_ts - start_ts > this.duration then
			break
		else
			if store.tick_ts - a2.ts >= a2.cooldown then
				local target = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, a2.range, a2.node_prediction, a2.vis_flags, a2.vis_bans, function(e)
					return e.nav_path and e.melee and not U.has_modifiers(store, e, "mod_possession") and not U.has_modifiers(store, e, "mod_possession_lucerna") and (not a2.excluded_templates or not table.contains(a2.excluded_templates, e.template_name)) and not table.contains(selected_id_table, e.id)
				end)
				if not target then
					SU.delay_attack(store, a2, 0.1)
				else
					local start_ts = store.tick_ts
					local targetPos = V.vclone(target.pos)
					U.animation_start(this, a2.animation, nil, store.tick_ts, false, 2)
					local start_offset = a2.bullet_start_offset[1]
					local fx = E:create_entity(a2.bullet[1])
					fx.pos = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
					fx.render.sprites[1].ts = store.tick_ts
					queue_insert(store, fx)
					U.y_wait(store, a2.shoot_time)
					if target.health.dead then
						local newTarget = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, a2.range, a2.node_prediction, a2.vis_flags, a2.vis_bans, function(e)
							return e.nav_path and e.melee and not U.has_modifiers(store, e, "mod_possession") and not U.has_modifiers(store, e, "mod_possession_lucerna") and (not a2.excluded_templates or not table.contains(a2.excluded_templates, e.template_name)) and not table.contains(selected_id_table, e.id)
						end)
						if newTarget then
							targetPos = V.vclone(newTarget.pos)
						end
						target = newTarget
					end
					start_offset = a2.bullet_start_offset[2]
					local b = E:create_entity(a2.bullet[2])
					b.pos = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
					b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
					b.bullet.to = V.v(targetPos.x, targetPos.y)
					b.bullet.level = this.level
					if target then
						b.bullet.target_id = target.id
						table.insert(selected_id_table, target.id)
					end
					queue_insert(store, b)
					a2.ts = start_ts
					U.y_animation_wait(this, 2)
					U.animation_start(this, "idle", nil, store.tick_ts,true, 2)
				end
			end
		end
		coroutine.yield()
	end

	

	U.animation_start(this, "death", nil, store.tick_ts, false, 2)
	this.render.sprites[1].hidden = true
	S:queue(this.sound_events.sound_out)
	U.y_wait(store, fts(18))
	this.render.sprites[2].hidden = true

end

--卢塞尔娜3技能
scripts.soldier_golem_lucerna = {}
function scripts.soldier_golem_lucerna.update(this, store, script)
	local brk, stam

	this.reinforcement.ts = store.tick_ts
	this.render.sprites[1].ts = store.tick_ts
	this.nav_rally.center = nil
	this.nav_rally.pos = V.vclone(this.pos)

	local damage_factor = 1
	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	if this.sound_events and this.sound_events.raise then
		S:queue(this.sound_events.raise)
	end

	this.health_bar.hidden = true

	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)

	if not this.health.dead then
		this.health_bar.hidden = nil
	end

	U.y_animation_play(this, "idle", nil, store.tick_ts, 1)

	

	local starting_pos = V.vclone(this.pos)

	this.nav_rally.pos = starting_pos

	local patrol_pos = V.vclone(this.pos)

	patrol_pos.x, patrol_pos.y = patrol_pos.x + this.patrol_pos_offset.x, patrol_pos.y + this.patrol_pos_offset.y

	local nearest_node = P:nearest_nodes(patrol_pos.x, patrol_pos.y, nil, nil, false)[1]
	local pi, spi, ni = unpack(nearest_node)
	local npos = P:node_pos(pi, spi, ni)
	local patrol_pos_2 = V.vclone(this.pos)

	patrol_pos_2.x, patrol_pos_2.y = patrol_pos_2.x - this.patrol_pos_offset.x, patrol_pos_2.y - this.patrol_pos_offset.y

	local nearest_node = P:nearest_nodes(patrol_pos_2.x, patrol_pos_2.y, nil, nil, false)[1]
	local pi, spi, ni = unpack(nearest_node)
	local npos_2 = P:node_pos(pi, spi, ni)

	if V.dist2(patrol_pos.x, patrol_pos.y, npos.x, npos.y) > V.dist2(patrol_pos_2.x, patrol_pos_2.y, npos_2.x, npos_2.y) then
		patrol_pos = V.vclone(patrol_pos_2)
	end

	local idle_ts = store.tick_ts
	local patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)

	while true do
		if this.health.dead or this.reinforcement.duration and store.tick_ts - this.reinforcement.ts > this.reinforcement.duration then
			if this.health.hp > 0 then
				this.reinforcement.hp_before_timeout = this.health.hp
			end

			this.health.hp = 0
			U.y_animation_play(this, "death", nil, store.tick_ts, 1)
			U.y_wait(store,fts(21))
			queue_remove(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)

			idle_ts = store.tick_ts
			patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)
		else

			if this.melee then
				brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
					idle_ts = store.tick_ts
					patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)

					goto label_2806_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)

				if patrol_cd < store.tick_ts - idle_ts then
					if this.nav_rally.pos == starting_pos then
						this.nav_rally.pos = patrol_pos
					else
						this.nav_rally.pos = starting_pos
					end

					idle_ts = store.tick_ts
					patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)
				end
			end
		end

		::label_2806_0::

		coroutine.yield()
	end
	U.y_animation_play(this, "death", nil, store.tick_ts, 1)
	U.y_wait(store,fts(21))

end

return scripts