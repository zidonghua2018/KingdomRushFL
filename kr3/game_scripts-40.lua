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
local SU = require("script_utils_123")
local U = require("utils_123")
local ULH = require("utils_lh")
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

local scripts = require("scripts_123")

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

--黑弓
scripts.tower_shadow_archer = {}

function scripts.tower_shadow_archer.get_info(this)
	local a = this.attacks.list[1]
	local b = E:get_template(a.bullet)
	local min, max = b.bullet.damage_min, b.bullet.damage_max

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown = a.cooldown

	return {
		type = STATS_TYPE_TOWER,
		damage_min = min,
		damage_max = max,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_shadow_archer.remove(this, store)
	if this.crows then
		for _, e in pairs(this.crows) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_shadow_archer.update(this, store)
	local a = this.attacks
	local aa = this.attacks.list[1]
	local as = this.attacks.list[2]
	local am = this.attacks.list[3]
	local pow_s = this.powers and this.powers.blade
	local pow_m = this.powers and this.powers.mark
	local pow_c = this.powers and this.powers.crow
	local sid = 3
	local shooter = this.render.sprites[sid]
	local fix_nil = {
		soldier = {
			melee_slot_offset = v(0, 0)
		}
	}
	this.crows = {}

	local function y_do_shot(attack, enemy, level)
		S:queue(attack.sound, attack.sound_args)

		local soffset = shooter.offset
		local an, af, ai = U.animation_name_facing_point(this, attack.animation, enemy.pos, sid, soffset)

		U.animation_start(this, an, af, store.tick_ts, false, sid)

		local shoot_time = attack.shoot_time

		U.y_wait(store, shoot_time)

		if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
			local boffset = attack.bullet_start_offset[ai]
			local b = E:create_entity(attack.bullet)

			b.pos.x = this.pos.x + soffset.x + boffset.x * (af and -1 or 1)
			b.pos.y = this.pos.y + soffset.y + boffset.y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			b.bullet.target_id = enemy.id
			b.bullet.level = level or 0
			b.bullet.damage_factor = this.tower.damage_factor

			local dist = V.dist(b.bullet.from.x, b.bullet.from.y, b.bullet.to.x, b.bullet.to.y)
			b.bullet.flight_time = b.bullet.flight_time_min + dist * b.bullet.flight_time_factor

			queue_insert(store, b)

			if attack.shot_fx then
				local fx = E:create_entity(attack.shot_fx)

				fx.pos.x, fx.pos.y = b.bullet.from.x, b.bullet.from.y

				local bb = b.bullet
				
				if bb.to.x > this.pos.x then
				fx.render.sprites[1].offset = v(5, 0)
				else
				fx.render.sprites[1].offset = v(-5, 0)
				end
				fx.render.sprites[1].r = V.angleTo(bb.to.x - bb.from.x, bb.to.y - bb.from.y)
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end
		end

		U.y_animation_wait(this, sid)

		an, af = U.animation_name_facing_point(this, "idle", enemy.pos, sid, soffset)

		U.animation_start(this, an, af, store.tick_ts, true, sid)
	end

	aa.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if as then
				as.cooldown = as.cooldowns[pow_s.level]
			end
			if pow_m and pow_m.changed then
				pow_m.changed = nil

				if pow_m.level == 1 then
					am.ts = store.tick_ts
				end
			end
			if pow_s and pow_s.changed then
				pow_s.changed = nil

				if pow_s.level == 1 then
					as.ts = store.tick_ts
				end
			end
			if pow_c and pow_c.changed then
				pow_c.changed = nil
			end
			if pow_c and pow_c.level > 0 then
				this.render.sprites[4].hidden = false
				for i = 1, pow_c.level - #this.crows do
					if pow_c.level < 2 then
						local e = E:create_entity("shadow_crow")

						e.pos = V.vclone(this.pos)
						e.bombs_pos = V.v(this.pos.x + 12, this.pos.y + 6)
						e.idle_pos = V.v(this.pos.x + 20, this.pos.y)

						queue_insert(store, e)
						table.insert(this.crows, e)

						e.owner = this
						e.owner_idx = #this.crows
					else
						if not this.crows[1] then
						local e = E:create_entity("shadow_crow")

						e.pos = V.vclone(this.pos)
						e.bombs_pos = V.v(this.pos.x + 12, this.pos.y + 6)
						e.idle_pos = V.v(this.pos.x + 20, this.pos.y + 6)

						queue_insert(store, e)
						table.insert(this.crows, e)

						e.owner = this
						e.owner_idx = #this.crows
						end
						local e = this.crows[1]
						e.custom_attack.damage_min = pow_c.damage_min
						e.custom_attack.damage_max = pow_c.damage_max
					end
				end
			end
			
			if pow_s and  pow_s.level > 0 and store.tick_ts - as.ts > as.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, as.vis_flags, as.vis_bans)
				if enemy then
					as.ts = store.tick_ts
					S:queue(as.sound)
					local soffset = shooter.offset
					local ani, flip = U.animation_name_facing_point(this, "teleportOut", enemy.pos, sid, soffset)
					U.y_animation_play(this, ani, flip, store.tick_ts, false, sid)
					local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, as.vis_flags, as.vis_bans)
					if enemy then
						SU.stun_inc(enemy)
						S:queue("TowerShadowInstakill")
						local lpos, lflip = U.melee_slot_position(fix_nil, enemy, 1, true)
						shooter.pos = lpos
						shooter.offset = v(0, 18)
						U.animation_start(this, "teleportInAttack", lflip, store.tick_ts, false, sid)
						U.y_wait(store, as.shoot_time)

						local d = E:create_entity("damage")
						d.source_id = this.id
						d.target_id = enemy.id
						d.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_NOT_EXPLODE)
						queue_damage(store, d)

						U.y_animation_wait(this, sid)
						U.y_animation_play(this, "teleportOutAttack", lflip, store.tick_ts, false, sid)
						shooter.pos = nil
						shooter.offset = soffset
					end

					U.y_animation_play(this, "teleportIn", flip, store.tick_ts, false, sid)
					U.animation_start(this, "idle", flip, store.tick_ts, false, sid)
				end
			end

			if pow_m and pow_m.level > 0 and store.tick_ts - am.ts > am.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, am.vis_flags, false, function(e)
					return not U.has_modifiers(store, e, "mod_arrow_shadow_mark")
				end)

				if enemy then
					am.ts = store.tick_ts
					y_do_shot(am, enemy, pow_m.level)
				end
			end

			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

				if enemy then
					aa.ts = store.tick_ts
					y_do_shot(aa, enemy)
				end
			end

			if store.tick_ts - aa.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, sid)

				U.animation_start(this, an, af, store.tick_ts, true, sid)
			end

			coroutine.yield()
		end
	end
end

scripts.shadow_crow = {}

function scripts.shadow_crow.get_info(this)
	return {
		armor = 0,
		type = STATS_TYPE_SOLDIER,
		damage_min = this.custom_attack.damage_min,
		damage_max = this.custom_attack.damage_max
	}
end

function scripts.shadow_crow.update(this, store)
	local sp = this.render.sprites[1]
	local fm = this.force_motion
	local ca = this.custom_attack
	local dest = V.vclone(this.idle_pos)
	local mytarget = nil
	local npos
	local locked = nil
	local target_id

	local function force_move_step(dest, max_speed, ramp_radius)
		local dx, dy = V.sub(dest.x, dest.y, this.pos.x, this.pos.y)
		local dist = V.len(dx, dy)
		local df = not (ramp_radius and not (ramp_radius < dist)) and 1 or math.max(dist / ramp_radius, 0.1)
		fm.a.x, fm.a.y = V.add(fm.a.x, fm.a.y, V.trim(495, V.mul(10 * df, dx, dy)))
		fm.v.x, fm.v.y = V.add(fm.v.x, fm.v.y, V.mul(store.tick_length, fm.a.x, fm.a.y))
		fm.v.x, fm.v.y = V.trim(max_speed, fm.v.x, fm.v.y)
		this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, V.mul(store.tick_length, fm.v.x, fm.v.y))
		fm.a.x, fm.a.y = V.mul(-0.05 / store.tick_length, fm.v.x, fm.v.y)
		sp.flip_x = this.pos.x < dest.x
	end

	sp.offset.y = this.flight_height

	while true do
		if store.tick_ts - ca.ts > ca.cooldown and not this.owner.tower.blocked then
			local target = mytarget or U.find_nearest_enemy(store.entities, tpos(this.owner), 0, this.owner.attacks.range, ca.vis_flags, ca.vis_bans)

			if not target or target.health.dead then
				SU.delay_attack(store, ca, 0.13333333333333333)
				locked = nil
				npos = nil
				this.pos.x, this.pos.y = this.pos.x, this.pos.y
				goto label_161_0
			else
				mytarget = target
				target_id = target.id
				

				dest = V.vclone(target.pos)
				
				local node_offset = math.ceil(target.motion.max_speed / 6)
				local e_ni =  target.nav_path.ni + node_offset
				npos = P:node_pos(target.nav_path.pi, target.nav_path.spi, e_ni)

				local dist = V.dist(this.pos.x, this.pos.y, dest.x, dest.y)

				while dist > 6 and not locked do
					log.debug("moving")
					force_move_step(npos, this.flight_speed_busy, this.ramp_dist_busy)
					coroutine.yield()

					target = store.entities[target.id]

					if not target or target.health.dead then
						mytarget = nil
						locked = nil
						npos = nil
						ca.ts = store.tick_ts
						this.pos.x, this.pos.y = this.pos.x, this.pos.y
						goto label_161_0
					end

					dist = V.dist(this.pos.x, this.pos.y, npos.x, npos.y)
				end
				
				locked = true
				
				if not target or target.health.dead then
					mytarget = nil
					locked = nil
					npos = nil
					ca.ts = store.tick_ts
					this.pos.x, this.pos.y = this.pos.x, this.pos.y
					goto label_161_0
				end

				dest = V.vclone(target.pos)
				dist = V.dist(this.pos.x, this.pos.y, dest.x, dest.y)
				dest = V.vclone(target.pos)

				log.debug("drop bomb")
				U.animation_start(this, "carry", nil, store.tick_ts, true)
					local d = E:create_entity("damage")

					d.source_id = this.id
					d.target_id = target.id
					d.value = math.random(ca.damage_min, ca.damage_max)
					d.damage_type = ca.damage_type
					queue_damage(store, d)
				ca.ts = store.tick_ts
				if this.custom_attack.sound_chance > math.random() then
						S:queue(this.custom_attack.sound)
					end
				
				dest = V.vclone(target.pos)
			end
		end
		
		if mytarget and not mytarget.health.dead and locked and mytarget.id == target_id then
		if (V.dist(dest.x, dest.y, this.idle_pos.x, this.idle_pos.y) < this.owner.attacks.range) then
		this.pos = V.vclone(mytarget.pos)
		end
		end

		::label_161_0::
		
		if (not mytarget or mytarget.health.dead) or (V.dist(dest.x, dest.y, this.idle_pos.x, this.idle_pos.y) > this.owner.attacks.range) then
		mytarget = nil
		npos = nil
		locked = nil
		this.pos.x, this.pos.y = this.pos.x, this.pos.y
		if (V.dist(dest.x, dest.y, this.idle_pos.x, this.idle_pos.y) > 43 or V.dist(dest.x, dest.y, this.pos.x, this.pos.y) < 10) then
			U.animation_start(this, "fly", nil, store.tick_ts, true)
			dest = U.point_on_ellipse(this.idle_pos, 30, U.frandom(0, 2 * math.pi))
		end
		force_move_step(dest, this.flight_speed_idle, this.ramp_dist_idle)
		end
		
		coroutine.yield()
	end
end

scripts.mod_arrow_shadow_mark = {}

function scripts.mod_arrow_shadow_mark.insert(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or target.health.dead or not target.unit then
		return false
	end
	
	if this.custom_offsets then
		if this.custom_offsets.flying and band(target.vis.flags, F_FLYING) ~= 0 then
			this.render.sprites[1].offset = this.custom_offsets.flying
		end
	end
	
	m.received_damage_factor = m.received_damage_factors[m.level]

	target.health.damage_factor = target.health.damage_factor * m.received_damage_factor

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_arrow_shadow_mark.update(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos
	m.duration = m.durations[m.level]
	
	m.ts = store.tick_ts

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead or store.tick_ts - m.ts > m.duration then
		
			queue_remove(store, this)

			return
		end

		coroutine.yield()
	end
end

function scripts.mod_arrow_shadow_mark.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	
	m.received_damage_factor = m.received_damage_factors[m.level]

	if target and target.health and target.unit then
		target.health.damage_factor = target.health.damage_factor / m.received_damage_factor
	end

	return true
end

--黑骑
scripts.soldier_dark_knight = {}

function scripts.soldier_dark_knight.on_damage(this, store, damage)
	log.debug(" SOLDIER_DARK_KNIGHT DAMAGE:%s type:%x", damage.value, damage.damage_type)
	local ca = this.dodge.shield
	local target = store.entities[this.soldier.target_id]

	if not target or target.health.dead or not this.dodge or this.unit.is_stunned or this.health.dead or store.tick_ts - ca.ts < ca.cooldown or band(damage.damage_type, DAMAGE_ALL_TYPES, bnot(bor(DAMAGE_PHYSICAL, DAMAGE_MAGICAL))) ~= 0 or band(damage.damage_type, DAMAGE_NO_DODGE) ~= 0 or this.powers[this.dodge.power_name].level < 1 or band(ca.vis_bans, target.vis.flags) ~= 0 then
		return true
	end

	log.debug("(%s)soldier_dark_knight dodged damage %s of type %s", this.id, damage.value, damage.damage_type)

	this.dodge.active = true

	return false
end

function scripts.soldier_dark_knight.insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		for pn, p in pairs(this.powers) do

			if pn == "spike" and p.level > 0 then
				this.health.dark_spiked_armor = p.dark_spiked_armor[p.level]
				--this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
			end
		end

		return true
	end

	return false
end

function scripts.soldier_dark_knight.update(this, store)
	local brk, sta
	local tower = store.entities[this.soldier.tower_id]

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	while true do
		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					SU.soldier_power_upgrade(this, pn)

					if pn == "spike" then
						this.health.dark_spiked_armor = p.dark_spiked_armor[p.level]
						--this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
					end
				end
			end
		end

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			SU.y_soldier_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			if this.dodge and this.dodge.active then
				local ca = this.dodge.shield

				this.dodge.active = false

				if this.powers[this.dodge.power_name].level > 0 and store.tick_ts - ca.ts > ca.cooldown then
					local start_ts = store.tick_ts

					ca.ts = 0
					this.health.ignore_damage = true
					this.vis.bans = bor(this.vis.bans, F_NET)

					S:queue(ca.sound)
					U.y_animation_play(this, ca.animation_start, nil, store.tick_ts, 1)
					U.y_wait(store, ca.hit_time)

					while store.tick_ts - start_ts < ca.duration do
						if store.tick_ts - ca.ts > ca.damage_every then
							ca.ts = store.tick_ts
						end
						
						if this.nav_rally.new then
							this.vis.bans = band(this.vis.bans, bnot(F_NET))
							this.health.ignore_damage = false
							goto label_612_1
						end

						coroutine.yield()
					end

					this.vis.bans = band(this.vis.bans, bnot(F_NET))
					
					U.y_animation_play(this, ca.animation_end, nil, store.tick_ts, 1)
					
					this.health.ignore_damage = false

					SU.soldier_idle(store, this)
					signal.emit("soldier-dodge", this)
				end
			end
			::label_612_1::
			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_61_1
				end
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else

				if brk or sta == A_DONE then
					goto label_61_1
				elseif sta == A_IN_COOLDOWN then
					goto label_61_0
				end

				if SU.soldier_go_back_step(store, this) then
					goto label_61_1
				end

				::label_61_0::

				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::label_61_1::

		coroutine.yield()
	end
end

--火法
scripts.infernal_mage = {}

function scripts.infernal_mage.update(this, store)
	local tower_sid = 2
	local shooter_sid = 3
	local teleport_sid = 4
	local curse_sid = 5
	local a = this.attacks
	local ar = this.attacks.list[1]
	local ad = this.attacks.list[2]
	local at = this.attacks.list[3]
	local ac = this.attacks.list[4]
	local pow_d = this.powers and this.powers.fissure
	local pow_t = this.powers and this.powers.teleport
	local pow_c = this.powers and this.powers.curse
	local last_ts = store.tick_ts

	ar.ts = store.tick_ts
	ar.range = a.range
	
	--this.render.sprites[6].ts = store.tick_ts
	--this.render.sprites[7].ts = store.tick_ts + fts(15)
	--this.render.sprites[8].ts = store.tick_ts + fts(30)

	local aura = at and E:get_template(at.aura)
	local aura2 = ac and E:get_template(ac.aura)
	local max_times_applied = aura and E:get_template(aura.aura.mod).max_times_applied
	local aa, pow
	local attacks = {
		ac,
		ad,
		at,
		ar
	}
	local pows = {
		pow_c,
		pow_d,
		pow_t
	}

	local function find_target(aa)
		local max_range = aa.range
		if aa == ar then
			max_range = this.attacks.range
		end
		local target, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, max_range, aa.node_prediction, aa.vis_flags, aa.vis_bans, function(e)
			if aa == at then
				return e.nav_path.ni >= aa.min_nodes and (not e.enemy.counts.mod_teleport or e.enemy.counts.mod_teleport < max_times_applied)
			else
				if aa == ac then
				 return not table.contains(ac.excluded_templates, e.template_name) and not SU.has_modifiers(store, e, "mod_infernal_curse_armor") and not SU.has_modifiers(store, e, "mod_infernal_curse_magic_armor") and (e.health.armor > 0 or e.health.magic_armor > 0) 
				 else
				return true
				end
			end
		end)

		return target, pred_pos
	end

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if this.powers then 
				for k, pow in pairs(this.powers) do
					if pow and pow.changed then
						pow.changed = nil

						if pow == pow_d then
							if pow.level == 1 then
								ad.ts = store.tick_ts
								
							end

							ad.cooldown = pow.cooldown_base + pow.cooldown_inc * pow.level
						end

						if pow == pow_t and pow.level == 1 then
							at.ts = store.tick_ts
						end
						if pow == pow_c and pow.level == 1 then
							ac.ts = store.tick_ts
						end
					end
				end
			end

			for i, aa in pairs(attacks) do
				pow = pows[i]

				if (not pow or pow.level > 0) and store.tick_ts - aa.ts > aa.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local enemy, pred_pos = find_target(aa)

					if not enemy then
						-- block empty
					else
						last_ts = store.tick_ts

						local soffset = this.render.sprites[shooter_sid].offset
						local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

						U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)

						if at and aa == at then
							this.render.sprites[teleport_sid].ts = last_ts
						end
						
						if ac and aa == ac then
							this.render.sprites[curse_sid].ts = last_ts
						end

						U.y_wait(store, aa.shoot_time)

						enemy, pred_pos = find_target(aa)

						if not enemy then
							-- block empty
						else
							aa.ts = last_ts

							local b
							local u = UP:get_upgrade("mage_runes_of_power")

							if aa == at then
								if at then 
									b = E:create_entity(aa.aura)
									b.pos.x, b.pos.y = pred_pos.x, pred_pos.y
									b.aura.target_id = enemy.id
									b.aura.source_id = this.id
									b.aura.max_count = pow_t.max_count[pow_t.level]
									b.aura.level = pow_t.level
								end
							elseif aa == ac then
								if ac then
									b = E:create_entity(aa.aura)
									b.pos.x, b.pos.y = pred_pos.x, pred_pos.y
									b.aura.target_id = enemy.id
									b.aura.source_id = this.id
									b.aura.level = pow_c.level
								end
							elseif aa == ad then
								if ad then 
									local bft = 0
									for i = 1, ad.loops do
										local b = E:create_entity(ad.bullet)
										local btox
										local btoy
										b.bullet.ts = store.tick_ts
										b.bullet.flight_time = bft
										bft = bft + 0.13
										b.pos.x, b.pos.y = this.pos.x + ad.bullet_start_offset.x, this.pos.y + ad.bullet_start_offset.y
										b.bullet.from = V.vclone(b.pos)
										btox = enemy.pos.x + math.random(ad.max_spread * -1, ad.max_spread)
										btoy = enemy.pos.y + math.random(ad.max_spread * -1, ad.max_spread)
										b.bullet.to = V.v(btox, btoy)
										while not U.is_inside_ellipse(b.bullet.to, P:node_pos(enemy.nav_path.pi, 1, enemy.nav_path.ni), ad.max_spread) do
										btox = enemy.pos.x + math.random(ad.max_spread * -1, ad.max_spread)
										btoy = enemy.pos.y + math.random(ad.max_spread * -1, ad.max_spread)
										b.bullet.to = V.v(btox, btoy)
										coroutine.yield()
										end
										b.bullet.level = pow_d.level
										b.bullet.target_id = enemy.id
										b.bullet.source_id = this.id

										queue_insert(store, b)
									end
									S:queue(ad.sound)
								end
							else
								b = E:create_entity(aa.bullet)
								b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.vclone(enemy.pos)
								b.bullet.target_id = enemy.id
								b.bullet.source_id = this.id
								b.bullet.level = this.tower.level --pow_d.level
								if u and math.random() < u.chance then
										b.bullet.damage_factor = b.bullet.damage_factor * u.damage_factor
										b.bullet.pop = {
										"pop_crit_wild_magus"
										}
										b.bullet.pop_conds = DR_DAMAGE
							    end
							end

							queue_insert(store, b)
						end
					end
				end
			end

			coroutine.yield()
		end
	end
end

scripts.lava_fissure = {}

function scripts.lava_fissure.update(this, store, script)
	local b = this.bullet
	local ps
	local s = this.render.sprites[1]

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	while store.tick_ts - b.ts + store.tick_length <= b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.rotation_speed then
			s.r = s.r + b.rotation_speed * store.tick_length
		else
			s.r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)

			if b.asymmetrical and math.abs(s.r) > math.pi / 2 then
				s.flip_y = true
			end
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end

		if b.hide_radius then
			s.hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius

			if ps then
				ps.particle_system.emit = not s.hidden
			end
		end
	end

	local hit = false
	local target = store.entities[b.target_id]

	if target and target.health and not target.health.dead then
		local target_pos = V.vclone(target.pos)

		if target.unit and target.unit.hit_offset and not b.ignore_hit_offset then
			target_pos.x, target_pos.y = target_pos.x + target.unit.hit_offset.x, target_pos.y + target.unit.hit_offset.y
		end

		if V.dist(this.pos.x, this.pos.y, target_pos.x, target_pos.y) < b.hit_distance and not SU.unit_dodges(store, target, true) and (not b.hit_chance or math.random() < b.hit_chance) then
			hit = true

			local d = SU.create_bullet_damage(b, target.id, this.id)

			queue_damage(store, d)

			if b.mod then
				local mods = type(b.mod) == "table" and b.mod or {
					b.mod
				}

				for _, mod_name in pairs(mods) do
					local mod = E:create_entity(mod_name)

					mod.modifier.source_id = this.id
					mod.modifier.target_id = target.id
					mod.modifier.level = b.level
					mod.modifier.source_damage = d

					queue_insert(store, mod)
				end
			end

			if b.hit_fx then
				local fx = E:create_entity(b.hit_fx)

				fx.pos = V.vclone(target_pos)
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.hit_blood_fx and target.unit.blood_color ~= BLOOD_NONE then
				local sfx = E:create_entity(b.hit_blood_fx)

				sfx.pos = V.vclone(target_pos)
				sfx.render.sprites[1].ts = store.tick_ts

				if sfx.use_blood_color and target.unit.blood_color then
					sfx.render.sprites[1].name = target.unit.blood_color
					sfx.render.sprites[1].r = s.r
				end

				queue_insert(store, sfx)
			end
		end
	end

	if not hit then
		if GR:cell_is(this.pos.x, this.pos.y, TERRAIN_WATER) then
			if b.miss_fx_water then
				local water_fx = E:create_entity(b.miss_fx_water)

				water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
				water_fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, water_fx)
			end
		else
			if b.miss_fx then
				local fx = E:create_entity(b.miss_fx)

				fx.pos.x, fx.pos.y = b.to.x, b.to.y
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.miss_decal then
				local decal = E:create_entity("decal_tween")

				decal.pos = V.vclone(b.to)
				decal.tween.props[1].keys = {
					{
						0,
						255
					},
					{
						2.1,
						0
					}
				}
				decal.render.sprites[1].ts = store.tick_ts
				decal.render.sprites[1].name = b.miss_decal
				decal.render.sprites[1].animated = false
				decal.render.sprites[1].z = Z_DECALS

				if b.rotation_speed then
					decal.render.sprites[1].flip_x = b.rotation_speed > 0
				else
					decal.render.sprites[1].r = -math.pi / 2 * (1 + (0.5 - math.random()) * 0.35)
				end

				if b.miss_decal_anchor then
					decal.render.sprites[1].anchor = b.miss_decal_anchor
				end

				queue_insert(store, decal)
			end
		end
	end

	if b.payload then
		local p = E:create_entity(b.payload)

		p.pos.x, p.pos.y = b.to.x, b.to.y
		p.target_id = b.target_id
		p.source_id = this.id

		if p.aura then
			p.aura.level = b.level
			p.aura.damage_min = b.admin[b.level]
			p.aura.damage_max = b.admax[b.level]
		end

		queue_insert(store, p)
	end
	
	if b.hit_decal then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if ps and ps.particle_system.emit then
		s.hidden = true
		ps.particle_system.emit = false

		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end

scripts.aura_lava_fissure = {}

function scripts.aura_lava_fissure.update(this, store)
	local a = this.aura
	local source = store.entities[this.source_id]
	local rand = math.random(1, 3)
	
	if rand == 1 then
		this.render.sprites[1].name = "1"
		elseif rand == 2 then
		this.render.sprites[1].name = "2"
		else
		this.render.sprites[1].name = "3"
	end

	if source and source.bullet then
		a.level = source.bullet.level
	end

	local target = this.target_id and store.entities[this.target_id]
	local hit_pos = V.vclone(this.pos)

	local targets = U.find_enemies_in_range(store.entities, hit_pos, 0, a.radius, a.vis_flags, a.vis_bans)

	if targets then
		for _, e in pairs(targets) do
			local d = E:create_entity("damage")

			d.damage_type = a.damage_type
			d.value = math.random(a.damage_min, a.damage_max)
			d.target_id = e.id
			d.source_id = this.id

			queue_damage(store, d)
		end
	end
	
	
	if target and not target.health.dead and band(target.vis.flags, F_FLYING) == 0 then
		local decal = E:create_entity("decal_lords_mage")

		decal.pos.x, decal.pos.y = target.pos.x, target.pos.y
		decal.tween.ts = store.tick_ts

		queue_insert(store, decal)
	end

	U.y_animation_play(this, nil, nil, store.tick_ts, 1)
	
	queue_remove(store, this)
end

scripts.mod_infernal_armor_buff = {}

function scripts.mod_infernal_armor_buff.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local source = store.entities[this.source_id]

	if source then
		this.modifier.level = source.aura.level
	end

	if not target or target.health.dead or target.enemy and not target.enemy.can_accept_magic then
		return false
	end

	if band(this.modifier.vis_flags, target.vis.bans) ~= 0 or band(this.modifier.vis_bans, target.vis.flags) ~= 0 then
		log.paranoid("mod %s cannot be applied to entity %s:%s because of vis flags/bans", this.template_name, target.id, target.template_name)

		return false
	end
	
	if target and target.unit and this.render then
		local s = this.render.sprites[1]

		s.ts = store.tick_ts

		if s.size_names then
			s.name = s.size_names[target.unit.size]
		end

		if s.size_scales then
			s.scale = s.size_scales[target.unit.size]
		end

		if target.render then
			s.z = target.render.sprites[1].z
		end
	end

	local buff = this.armor_buff
	local inc = buff.max_factor
	
	if this.modifier.level > 1 then
		buff.factor = -1
	end
	
	if buff.magic then
		if buff.factor then
			inc = buff.factor * target.health.magic_armor
		end

		SU.magic_armor_inc(target, inc)
	else
		if buff.factor then
			inc = buff.factor * target.health.armor
		end

		SU.armor_inc(target, inc)
	end

	buff._total_factor = inc

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_infernal_armor_buff.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if target then
		local buff = this.armor_buff

		if buff.magic then
			SU.magic_armor_dec(target, buff._total_factor)
		else
			SU.armor_dec(target, buff._total_factor)
		end
	end

	return true
end

function scripts.mod_infernal_armor_buff.update(this, store, script)
	local buff = this.armor_buff
	local m = this.modifier
	local last_ts = store.tick_ts
	local target = store.entities[m.target_id]
	local source = store.entities[this.source_id]

	if source then
		m.level = source.aura.level
	end

	if not target then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	while true do
		target = store.entities[m.target_id]
		
		if m.level > 1 then
		buff.factor = -0.9
		end

		if not target or target.health.dead or store.tick_ts - m.ts >= m.duration then
			queue_remove(store, this)

			return
		end

		if this.render and m.use_mod_offset and target.unit.mod_offset then
			this.render.sprites[1].offset.x, this.render.sprites[1].offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
		end

		if store.tick_ts - last_ts > buff.cycle_time then
			last_ts = store.tick_ts

			if buff.magic and target.health.magic_armor < buff.max_factor then
				SU.magic_armor_inc(target, buff.step_factor)

				buff._total_factor = buff._total_factor + buff.step_factor
			elseif not buff.magic and target.health.armor < buff.max_factor then
				SU.armor_inc(target, buff.step_factor)

				buff._total_factor = buff._total_factor + buff.step_factor
			end
		end

		coroutine.yield()
	end
end

scripts.aura_infernal_apply_mod = {}

function scripts.aura_infernal_apply_mod.insert(this, store, script)
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

function scripts.aura_infernal_apply_mod.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0

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
				goto label_89_0
			end

			if this.render then
				this.render.sprites[1].hidden = not te.enemy.can_do_magic
			end

			if not te.enemy.can_do_magic then
				goto label_89_0
			end
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_89_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.health and te.health.dead then
				goto label_89_0
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
					
					if new_mod.extra_armor then
					new_mod.extra_armor = new_mod.extra_armor[this.aura.level]
					end
					
					if new_mod.extra_magic_armor then
					new_mod.extra_magic_armor = new_mod.extra_magic_armor[this.aura.level]
					end

					if this.aura.hide_source_fx and target.id == this.aura.source_id then
						new_mod.render = nil
					end

					queue_insert(store, new_mod)

					victims_count = victims_count + 1
				end
			end
		end

		::label_89_0::

		coroutine.yield()
	end

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end

scripts.mod_affliction = {}

function scripts.mod_affliction.insert(this, store)
	local m = this.modifier
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	m.ts = store.tick_ts
	
	if this.extra_armor then
	SU.armor_dec(target, this.extra_armor)
	end
	
	if this.extra_magic_armor then
	SU.magic_armor_dec(target, this.extra_magic_armor)
	end
	
	return true
end

function scripts.mod_affliction.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		if this.extra_armor then
		SU.armor_inc(target, this.extra_armor)
		end
		
		if this.extra_magic_armor then
		SU.magic_armor_inc(target, this.extra_magic_armor)
		end
	end

	return true
end

--熔炉
scripts.tower_melting_furnace = {}

function scripts.tower_melting_furnace.remove(this, store, script)
	local mods = table.filter(store.entities, function(_, e)
		return e.modifier and e.modifier.source_id == this.id
	end)

	for _, m in pairs(mods) do
		queue_remove(store, m)
	end

	if this.eagle_previews then
		for _, decal in pairs(this.eagle_previews) do
			queue_remove(store, decal)
		end

		this.eagle_previews = nil
	end

	return true
end

function scripts.tower_melting_furnace.insert(this, store, script)
	local points = {}
	local inner_fx_radius = 100
	local outer_fx_radius = 115

	for i = 1, 12 do
		local r = outer_fx_radius

		if i % 2 == 0 then
			r = inner_fx_radius
		end

		local p = {}

		p.pos = U.point_on_ellipse(this.pos, r, 2 * math.pi * i / 12)
		p.terrain = GR:cell_type(p.pos.x, p.pos.y)

		if GR:cell_is(p.pos.x, p.pos.y, TERRAIN_WATER) or P:valid_node_nearby(p.pos.x, p.pos.y, 1) and not GR:cell_is(p.pos.x, p.pos.y, TERRAIN_CLIFF) then
			table.insert(points, p)
		end
	end

	this.fx_points = points

	return true
end

function scripts.tower_melting_furnace.update(this, store, script)
	local a = this.attacks
	local smash = this.attacks.list[1]
	local coal = this.attacks.list[2]
	local buff = this.attacks.list[3]
	local fuel = this.attacks.list[4]
	local pow_coal = this.powers and this.powers.coal
	local pow_heat = this.powers and this.powers.heat
	local pow_fuel = this.powers and this.powers.fuel
	local anim_id = 2

	smash.ts = store.tick_ts - smash.cooldown
	if not fuel then
		fuel = { boost = false }
	end
	while true do
		:: label_furnace_continue ::
		if this.tower.blocked then
			coroutine.yield()
			goto label_furnace_continue
		end
		if pow_heat and pow_heat.changed then
			pow_heat.changed = nil

			if pow_heat.level == 1 then
				buff.ts = store.tick_ts
			end
		end
		if pow_fuel and pow_fuel.changed then
			pow_fuel.changed = nil

			if pow_fuel.level == 1 then
				fuel.ts = store.tick_ts
			end
		end
		if pow_coal and pow_coal.changed then
			pow_coal.changed = nil

			if pow_coal.level == 1 then
				coal.ts = store.tick_ts
			end
		end

		if pow_heat and pow_heat.level > 0 and store.tick_ts - buff.ts > buff.cooldown then
			buff.ts = store.tick_ts

			local existing_mods = table.filter(store.entities, function(_, e)
				return e.modifier and e.template_name == buff.mod and e.modifier.level >= pow_heat.level
			end)
			local busy_ids = table.map(existing_mods, function(_, v)
				return v.modifier.target_id
			end)
			local towers = table.filter(store.entities, function(_, e)
				return e.tower and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(buff.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, buff.range) and e.id ~= this.id
			end)

			for _, tower in pairs(towers) do
				local new_mod = E:create_entity(buff.mod)

				new_mod.modifier.level = pow_heat.level
				new_mod.modifier.target_id = tower.id
				new_mod.modifier.source_id = this.id
				new_mod.pos = tower.pos

				queue_insert(store, new_mod)
			end
		end

		if pow_coal and pow_coal.level > 0 and not coal.disabled and store.tick_ts - coal.ts > coal.cooldown then
			local trigger_enemy, _, trigger_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, coal.node_prediction, coal.vis_flags, coal.vis_bans)
			if trigger_enemy then
				coal.ts = store.tick_ts

				S:queue(coal.sound)
				U.animation_start(this, "shootFissure", nil, store.tick_ts)
				this.render.sprites[10].hidden = false
				this.tween.disabled = false
				this.tween.props[1].ts = store.tick_ts
				U.y_wait(store, coal.hit_time)

				local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, coal.node_prediction, coal.vis_flags, coal.vis_bans)
				local dest = enemy and pred_pos or trigger_pos
				local fragment_count = pow_coal.fragment_count_base + pow_coal.fragment_count_inc * pow_coal.level
				local target = enemy or trigger_enemy
				local nearest_nodes = P:nearest_nodes(dest.x, dest.y, { target.nav_path.pi })
				local n_offset = math.ceil(fragment_count / 2)
				local ni_offset = n_offset * coal.fragment_node_spread
				local ni, pi
				if #nearest_nodes > 0 then
					pi, _, ni = unpack(nearest_nodes[1])
					ni_offset = km.clamp(
							fragment_count * coal.fragment_node_spread + 1 - ni,
							coal.fragment_node_spread + #P.paths[pi][1] - ni,
							ni_offset)
				end

				for i = 1, fragment_count do
					local bf_dest
					if #nearest_nodes > 0 then
						bf_dest = P:node_pos(pi, 1, ni + ni_offset - i * coal.fragment_node_spread)
					else
						bf_dest = U.point_on_ellipse(dest, (50 * math.random() + 45) / 2, 2 * math.pi * i / fragment_count)
					end
					bf_dest.x = bf_dest.x + U.frandom(-coal.fragment_pos_spread.x, coal.fragment_pos_spread.x)
					bf_dest.y = bf_dest.y + U.frandom(-coal.fragment_pos_spread.y, coal.fragment_pos_spread.y)

					local b = E:create_entity(coal.bullet)
					b.pos.x = this.pos.x + (n_offset - i) * coal.bullet_start_offset.x
					b.pos.y = this.pos.y + coal.bullet_start_offset.y + math.random(-5, 5)
					b.bullet.damage_factor = this.tower.damage_factor
					b.bullet.from = V.vclone(b.pos)
					b.bullet.to = V.vclone(bf_dest)
					b.bullet.flight_time = b.bullet.flight_time + fts(i) * math.random(1, 2)
					b.bullet.target_id = enemy and enemy.id or trigger_enemy.id
					b.bullet.source_id = this.id
					b.bullet.level = pow_coal.level
					queue_insert(store, b)
				end

				U.y_animation_wait(this, anim_id)
				this.render.sprites[10].hidden = true
				this.tween.disabled = true

				goto label_furnace_continue
			end
		end

		local trigger_enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, smash.vis_flags, smash.vis_bans)
		if pow_fuel and pow_fuel.level > 0 and not fuel.boost and store.tick_ts - fuel.ts > fuel.cooldown and trigger_enemy then
			fuel.ts = store.tick_ts
			fuel.boost = true
			coal.disabled = true
			S:queue("MeltingFurnaceBurningFuel")
			U.animation_start(this, "bfIntro", nil, store.tick_ts)
			U.y_animation_wait(this, anim_id)
			local mod = E:create_entity(fuel.mod)
			mod.pos = this.pos
			for k, v in pairs(mod.effect) do
				this.attacks.list[1][k] = v
			end
			mod.modifier.target_id = this.id
			mod.modifier.source_id = this.id
			queue_insert(store, mod)
			U.animation_start(this, "bfLoop", nil, store.tick_ts, true)
			U.y_wait(store, fts(8))
		end
		if trigger_enemy and store.tick_ts - smash.ts > smash.cooldown then
			smash.ts = store.tick_ts
			S:queue(smash.sound)
			U.animation_start(this, fuel.boost and "bfHit" or "shoot", nil, store.tick_ts)
			U.y_wait(store, smash.hit_time)

			local enemies = U.find_enemies_in_range(store.entities, tpos(this), 0, a.range, smash.damage_flags, smash.damage_bans)
			if enemies then
				for _, enemy in pairs(enemies) do
					local d = E:create_entity("damage")

					d.source_id = this.id
					d.target_id = enemy.id
					d.damage_type = smash.damage_type
					d.value = math.random(smash.damage_min, smash.damage_max)
					d.value = math.ceil(this.tower.damage_factor * d.value)
					d.reduce_armor = smash.reduce_armor

					queue_damage(store, d)

					if smash.mod then
						local mod = E:create_entity(smash.mod)

						mod.modifier.target_id = enemy.id

						queue_insert(store, mod)
					end
				end
			end

			for _, p in pairs(this.fx_points) do
				if band(p.terrain, TERRAIN_WATER) ~= 0 then
					local smoke = E:create_entity("decal_dwaarp_smoke_water")

					smoke.pos.x, smoke.pos.y = p.pos.x, p.pos.y
					smoke.render.sprites[1].ts = store.tick_ts + math.random() * fts(5)

					queue_insert(store, smoke)

					if this.lava_ready then
						local vapor = E:create_entity("decal_dwaarp_scorched_water")

						vapor.render.sprites[1].ts = store.tick_ts + U.frandom(0, 0.5)
						vapor.pos.x, vapor.pos.y = p.pos.x + U.frandom(-5, 5), p.pos.y + U.frandom(-5, 5)

						if math.random() < 0.5 then
							vapor.render.sprites[1].flip_x = true
						end

						queue_insert(store, vapor)
					end
				else
					local decal = E:create_entity("decal_tween")
					decal.pos.x, decal.pos.y = p.pos.x, p.pos.y
					decal.tween.props[1].keys = {
						{ 0, 255 },
						{ 0.8, 255 },
						{ 1.5, 0 }
					}
					decal.tween.props[1].name = "alpha"
					decal.render.sprites[1].name = "darkarmy_melting_furnace_decal"
					decal.render.sprites[1].animated = false
					decal.render.sprites[1].z = Z_DECALS
					decal.render.sprites[1].ts = store.tick_ts

					queue_insert(store, decal)

					local smoke = E:create_entity("decal_melting_furnace_smoke")
					smoke.pos.x, smoke.pos.y = p.pos.x, p.pos.y
					smoke.render.sprites[1].ts = store.tick_ts
					queue_insert(store, smoke)
				end

			end

			U.y_animation_wait(this, anim_id)
			U.animation_start(this, fuel.boost and "bfLoop" or "idle", nil, store.tick_ts, true)
		else
			if not fuel.boost and this.render.sprites[anim_id].name == "bfLoop" then
				U.animation_start(this, "idle", nil, store.tick_ts, true)
			end
			coroutine.yield()
		end
	end
end

scripts.mod_furnace_fuel = {}
function scripts.mod_furnace_fuel.update(this, store, script)
	local m = this.modifier
	local tower = store.entities[m.target_id]
	if not tower or not tower.tower then return end
	U.y_animation_play(this, "fadeIn", nil, store.tick_ts)
	U.animation_start(this, "loop", nil, store.tick_ts, true)
	U.y_wait(store, m.duration - fts(12))
	U.y_animation_play(this, "fadeOut", nil, store.tick_ts)
	queue_remove(store, this)
end

function scripts.mod_furnace_fuel.remove(this, store, script)
	local tower = store.entities[this.modifier.target_id]
	if not tower or not tower.tower then return true end
	local backup = E:get_template("tower_melting_furnace_lvl4").attacks.list[1]
	for k, _ in pairs(this.effect) do
		tower.attacks.list[1][k] = backup[k]
	end
	tower.attacks.list[2].disabled = false
	tower.attacks.list[4].boost = false
	return true
end

scripts.melting_furnace_coal = {}

function scripts.melting_furnace_coal.update(this, store, script)
	local b = this.bullet
	while store.tick_ts - b.ts < b.flight_time do
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)
		this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end
		coroutine.yield()
	end

	local hp = E:create_entity(b.hit_payload)
	hp.pos.x, hp.pos.y = b.to.x, b.to.y
	if hp.aura then
		hp.aura.level = this.bullet.level
	end
	queue_insert(store, hp)

	queue_remove(store, this)

--[[
	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if b.hit_fx_water and band(cell_type, TERRAIN_WATER) ~= 0 then
		S:queue(this.sound_events.hit_water)

		local water_fx = E:create_entity(b.hit_fx_water)

		water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
		water_fx.render.sprites[1].ts = store.tick_ts
		water_fx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, water_fx)
	elseif b.hit_fx then
		S:queue(this.sound_events.hit)

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, sfx)
	end

	if b.hit_decal and band(cell_type, TERRAIN_WATER) == 0 then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end]]
end
function scripts.melting_furnace_coal.lava_update(this, store, script)
	local b = this.aura
	local damage_every = b.cycle_time
	local damage_factor = b.damage_factor or 1
	local dps_ts = b.ts
	while store.tick_ts - b.ts <= this.actual_duration do
		if this.render.sprites[2].name == "start" and U.animation_finished(this, 2) then
			U.animation_start(this, "run", nil, store.ts, true)
		end
		if store.tick_ts - dps_ts > damage_every then
			dps_ts = dps_ts + damage_every
			local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, b.radius, b.vis_flags, b.vis_bans)
			if enemies then
				local d_value = math.random(b.damage_min, b.damage_max) + b.damage_inc * b.level
				d_value = math.ceil(d_value * damage_factor)
				for _, enemy in pairs(enemies) do
					local d = E:create_entity("damage")
					d.source_id = this.id
					d.target_id = enemy.id
					d.value = d_value
					d.damage_type = b.damage_type
					d.track_damage = true
					queue_damage(store, d)
				end
			end
		end
		coroutine.yield()
	end
	queue_remove(store, this)
end

scripts.mod_furnace_buff = {}

function scripts.mod_furnace_buff.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then return false end

	if target.attacks or target.template_name == "tower_mech" then
		target.tower.damage_factor = target.tower.damage_factor * (1 + this.extra_damage * m.level)
	end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_furnace_buff.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and (target.attacks or target.template_name == "tower_mech") then
		target.tower.damage_factor = target.tower.damage_factor / (1 + this.extra_damage * m.level)
	end

	return true
end

--回旋镖
scripts.tower_goblirang = {}

function scripts.tower_goblirang.update(this, store)
	local ellipse = 0.7
	local shooter_sids = {
		3,
		4
	}
	local shooter_idx = 2
	local a = this.attacks
	local aa = this.attacks.list[1]
	local ab = this.attacks.list[2]
	local ah = this.attacks.list[3]
	local pow_p = this.powers and this.powers.stun
	local pow_b = this.powers and this.powers.big
	local pow_t = this.powers and this.powers.bees

	aa.ts = store.tick_ts - aa.cooldown * 0.8

	local function shot_animation(attack, shooter_idx, enemy)
		local ssid = shooter_sids[shooter_idx]
		local soffset = this.render.sprites[ssid].offset
		local s = this.render.sprites[ssid]
		local an, af = U.animation_name_facing_point(this, attack.animation, enemy.pos, ssid, soffset)

		U.animation_start(this, an, af, store.tick_ts, 1, ssid)

		return U.animation_name_facing_point(this, "idle", enemy.pos, ssid, soffset)
	end

	local function shot_bullet(attack, shooter_idx, enemy, level, is_big)
		local ssid = shooter_sids[shooter_idx]
		local shooting_up = this.pos.y < enemy.pos.y
		local shooting_right = this.pos.x < enemy.pos.x

		local soffset = this.render.sprites[ssid].offset
		local boffset = attack.bullet_start_offset[shooting_up and 1 or 2]

		local start_x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
		local start_y = this.pos.y + soffset.y + boffset.y
		local b = E:create_entity(attack.bullet)
		b.pos.x = start_x
		b.pos.y = start_y
		b.bullet.from = V.vclone(b.pos)

		local rate = km.clamp(0.2, 1, V.dist(start_x, start_y, enemy.pos.x, enemy.pos.y) / a.range)
		local epos = P:predict_enemy_pos(enemy, b.bullet.flight_time * rate * rate)
		local dir_x, dir_y = V.normalize(epos.x - start_x, (epos.y - start_y) / ellipse)
		rate = 1 - 0.25 * dir_y
		b.bullet.to = v(
				start_x + a.range * dir_x * rate,
				start_y + a.range * dir_y * rate * ellipse) --椭圆形缘故

		if is_big then
			b.bullet.damage_min = pow_b.damage_min[pow_b.level]
			b.bullet.damage_max = pow_b.damage_max[pow_b.level]
		end
		b.bullet.level = level
		b.bullet.damage_factor = this.tower.damage_factor
		if pow_p and pow_p.level > 0 then
			b.bullet.mod = pow_p.mod
			b.bullet.mod_chance = pow_p.mod_chance[pow_p.level]
		end
		b.owner = this
		queue_insert(store, b)
	end

	local function shot_bullet_bees(attack, shooter_idx, enemy, level)
		local ssid = shooter_sids[shooter_idx]
		local shooting_up = tpos(this).y < enemy.pos.y
		local shooting_right = tpos(this).x < enemy.pos.x
		local soffset = this.render.sprites[ssid].offset
		local boffset = attack.bullet_start_offset[shooting_up and 1 or 2]
		local b = E:create_entity(attack.bullet)

		b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
		b.pos.y = this.pos.y + soffset.y + boffset.y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
		b.bullet.target_id = enemy.id
		b.bullet.level = level

		queue_insert(store, b)
	end

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if this.powers then
				for k, pow in pairs(this.powers) do
					if pow.changed then
						pow.changed = nil

						if pow == pow_t then
							ah.ts = store.tick_ts
						end
						if pow == pow_b then
							ab.ts = store.tick_ts
						end
					end
				end
			end

			if pow_t and pow_t.level > 0 and store.tick_ts - ah.ts > ah.cooldown then
				local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, ah.range, false, ah.vis_flags, ah.vis_bans)

				if not enemy then
					-- block empty
				else

					ah.ts = store.tick_ts
					shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

					local idle_an, idle_af = shot_animation(ah, shooter_idx, enemy)

					U.y_wait(store, ah.shoot_time)

					if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
						shot_bullet_bees(ah, shooter_idx, enemy, pow_t.level)
					end

					U.y_animation_wait(this, shooter_sids[shooter_idx])
					U.animation_start(this, idle_an, idle_af, store.tick_ts, false, shooter_sids[shooter_idx])
				end
			end

			if pow_b and pow_b.level > 0 and store.tick_ts - ab.ts > ab.cooldown then
				local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, ab.vis_flags, ab.vis_bans)

				if not enemy then
					-- block empty
				else

					ab.ts = store.tick_ts
					shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

					local idle_an, idle_af = shot_animation(ab, shooter_idx, enemy)

					U.y_wait(store, ab.shoot_time)

					if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
						shot_bullet(ab, shooter_idx, enemy, pow_b.level, true)
					end

					U.y_animation_wait(this, shooter_sids[shooter_idx])
					U.animation_start(this, idle_an, idle_af, store.tick_ts, false, shooter_sids[shooter_idx])
					U.y_wait(store, fts(36))
				end
			end

			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

				if not enemy then
					-- block empty
				else

					aa.ts = store.tick_ts
					shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

					local idle_an, idle_af = shot_animation(aa, shooter_idx, enemy)

					U.y_wait(store, aa.shoot_time)

					if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
						pow_p_level = pow_p and pow_p.level or 0
						shot_bullet(aa, shooter_idx, enemy, pow_p_level)
					end

					U.y_animation_wait(this, shooter_sids[shooter_idx])
					U.animation_start(this, idle_an, idle_af, store.tick_ts, false, shooter_sids[shooter_idx])
				end
			end

			if store.tick_ts - aa.ts > this.tower.long_idle_cooldown then
				for _, sid in pairs(shooter_sids) do
					local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, sid)

					U.animation_start(this, an, af, store.tick_ts, -1, sid)
				end
			end

			coroutine.yield()
		end
	end
end

scripts.goblirang = {}

function scripts.goblirang.update(this, store)
	local b = this.bullet
	local s = this.render.sprites[1]
	local start_ts
	local hit_enemies = {}
	local flight_time = b.flight_time
	local back = false

	local function quad_pos(from, to, now)
		local t = now / flight_time
		if not back then
			t = 1 - t
		end
		t = 1 - t * t
		this.pos.x = (to.x - from.x) * t + from.x
		this.pos.y = (to.y - from.y) * t + from.y
	end

	U.animation_start(this, "flying", nil, store.tick_ts, true)
	if b.particles_name then
		local ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id
		queue_insert(store, ps)
	end

	::label_193_0::
	start_ts = store.tick_ts
	b.ts = start_ts
	while store.tick_ts - start_ts + store.tick_length <= flight_time do
		s.r = s.r + b.rotation_speed * store.tick_length
		quad_pos(b.from, b.to, store.tick_ts - start_ts)
		if store.tick_ts - b.ts > b.damage_every then
			b.ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, b.vis_flags, b.vis_bans)
			if targets then
				for _, t in ipairs(targets) do
					if not table.contains(hit_enemies, t.id) then
						if b.hit_fx then
							local sfx = E:create_entity(b.hit_fx)

							sfx.pos.x, sfx.pos.y = t.pos.x + t.unit.hit_offset.x, t.pos.y + t.unit.hit_offset.y
							sfx.render.sprites[1].ts = store.tick_ts
							sfx.render.sprites[1].runs = 0

							queue_insert(store, sfx)
						end

						local d = E:create_entity("damage")
						d.damage_type = b.damage_type
						d.source_id = this.id
						d.target_id = t.id
						d.value = math.random(b.damage_min, b.damage_max)
						queue_damage(store, d)

						if b.mod or b.mods then
							if math.random() < b.mod_chance then
								local mods = b.mods or {
									b.mod
								}

								for _, mod_name in pairs(mods) do
									local m = E:create_entity(mod_name)

									m.modifier.target_id = t.id
									m.modifier.level = b.level

									queue_insert(store, m)
								end
							end
						end
						if (b.mod2 or b.mods2) and band(t.vis.flags, bor(F_BOSS)) == 0 then
							local mods = b.mods2 or {
								b.mod2
							}

							for _, mod_name in pairs(mods) do
								local m = E:create_entity(mod_name)

								m.modifier.target_id = t.id
								m.modifier.level = b.level

								queue_insert(store, m)
							end
						end
						table.insert(hit_enemies, t.id)
					end
				end
			end
		end

		coroutine.yield()
	end

	if not back then
		back = true
		hit_enemies = {}
		goto label_193_0
	end

	queue_remove(store, this)
end

scripts.honey_bees = {}

function scripts.honey_bees.update(this, store, script)
	local b = this.bullet
	local ps
	local s = this.render.sprites[1]

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	while store.tick_ts - b.ts + store.tick_length <= b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.rotation_speed then
			s.r = s.r + b.rotation_speed * store.tick_length
		else
			s.r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)

			if b.asymmetrical and math.abs(s.r) > math.pi / 2 then
				s.flip_y = true
			end
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end

		if b.hide_radius then
			s.hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius

			if ps then
				ps.particle_system.emit = not s.hidden
			end
		end
	end

	local hit = false
	local target = store.entities[b.target_id]

	if target and target.health and not target.health.dead then
		local target_pos = V.vclone(target.pos)

		if target.unit and target.unit.hit_offset and not b.ignore_hit_offset then
			target_pos.x, target_pos.y = target_pos.x + target.unit.hit_offset.x, target_pos.y + target.unit.hit_offset.y
		end

		if V.dist(this.pos.x, this.pos.y, target_pos.x, target_pos.y) < b.hit_distance and not SU.unit_dodges(store, target, true) and (not b.hit_chance or math.random() < b.hit_chance) then
			hit = true

			local d = SU.create_bullet_damage(b, target.id, this.id)

			queue_damage(store, d)

			if b.mod then
				local mods = type(b.mod) == "table" and b.mod or {
					b.mod
				}

				for _, mod_name in pairs(mods) do
					local mod = E:create_entity(mod_name)

					mod.modifier.source_id = this.id
					mod.modifier.target_id = target.id
					mod.modifier.level = b.level
					mod.modifier.source_damage = d

					queue_insert(store, mod)
				end
			end

			if b.hit_fx then
				local fx = E:create_entity(b.hit_fx)

				fx.pos = V.vclone(target_pos)
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.hit_blood_fx and target.unit.blood_color ~= BLOOD_NONE then
				local sfx = E:create_entity(b.hit_blood_fx)

				sfx.pos = V.vclone(target_pos)
				sfx.render.sprites[1].ts = store.tick_ts

				if sfx.use_blood_color and target.unit.blood_color then
					sfx.render.sprites[1].name = target.unit.blood_color
					sfx.render.sprites[1].r = s.r
				end

				queue_insert(store, sfx)
			end
		end
	end

	if not hit then
		if GR:cell_is(this.pos.x, this.pos.y, TERRAIN_WATER) then
			if b.miss_fx_water then
				local water_fx = E:create_entity(b.miss_fx_water)

				water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
				water_fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, water_fx)
			end
		else
			if b.miss_fx then
				local fx = E:create_entity(b.miss_fx)

				fx.pos.x, fx.pos.y = b.to.x, b.to.y
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.miss_decal then
				local decal = E:create_entity("decal_tween")

				decal.pos = V.vclone(b.to)
				decal.tween.props[1].keys = {
					{
						0,
						255
					},
					{
						2.1,
						0
					}
				}
				decal.render.sprites[1].ts = store.tick_ts
				decal.render.sprites[1].name = b.miss_decal
				decal.render.sprites[1].animated = false
				decal.render.sprites[1].z = Z_DECALS

				if b.rotation_speed then
					decal.render.sprites[1].flip_x = b.rotation_speed > 0
				else
					decal.render.sprites[1].r = -math.pi / 2 * (1 + (0.5 - math.random()) * 0.35)
				end

				if b.miss_decal_anchor then
					decal.render.sprites[1].anchor = b.miss_decal_anchor
				end

				queue_insert(store, decal)
			end
		end
	end

	if b.payload then
		local p = E:create_entity(b.payload)
		
		if target then
		p.pos.x, p.pos.y = target.pos.x, target.pos.y
		p.target_id = b.target_id
		else
		p.pos.x, p.pos.y = this.pos.x, this.pos.y
		end
		p.source_id = this.id

		if p.aura then
			p.aura.level = b.level
		end

		queue_insert(store, p)
	end

	if ps and ps.particle_system.emit then
		s.hidden = true
		ps.particle_system.emit = false

		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end

scripts.honey_bees_aura = {}

function scripts.honey_bees_aura.insert(this, store, script)
    if not scripts.aura_apply_mod.insert(this, store, script) then
        return false
    end
    local bees = #this.render.sprites
    local offset_x = this.render.sprites[1].offset.x
    local offset_y = this.render.sprites[1].offset.y + 15
    local base_keys = {
        { 0, v(offset_x - 25, offset_y) },
        { fts(30), v(offset_x, offset_y - 10) },
        { fts(60), v(offset_x + 25, offset_y) },
        { fts(90), v(offset_x, offset_y + 10) },
        { fts(120), v(offset_x - 25, offset_y) }
    }
    for i = 1, bees do
        this.tween.props[i].keys = base_keys
        this.tween.props[i].time_offset = -(fts(120) / bees) * (i - 1)
    end
    this.tween.props[bees + 1].keys = {
        { 0, 255 },
        { this.actual_duration - 0.5, 255 },
        { this.actual_duration, 0 }
    }
    this.tween.ts = store.tick_ts
    return true
end

function scripts.honey_bees_aura.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0

	if this.aura.track_target and this.target_id then
		local te = store.entities[this.target_id]

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
				goto label_89_0
			end

			if this.render then
				this.render.sprites[1].hidden = not te.enemy.can_do_magic
			end

			if not te.enemy.can_do_magic then
				goto label_89_0
			end
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_89_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.health and te.health.dead then
				goto label_89_0
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

		::label_89_0::

		coroutine.yield()
	end

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end

--掷骨者
scripts.tower_bone_flingers = {}

function scripts.tower_bone_flingers.get_info(this)
	local a = this.attacks.list[1]
	local b = E:get_template(this.attacks.list[1].bullet)
	local min, max = b.bullet.damage_min, b.bullet.damage_max
	local pow_m = this.powers.milk
	
	if pow_m and pow_m.level > 0 then
	min = min + pow_m.damage_inc[pow_m.level]
	max = max + pow_m.damage_inc[pow_m.level]
	end

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown = a.cooldown

	return {
		type = STATS_TYPE_TOWER,
		damage_min = min,
		damage_max = max,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_bone_flingers.insert(this, store, script)
	local points = {}
	local inner_fx_radius = 100
	local outer_fx_radius = 115
	local aspect = 0.7

	for i = 1, 12 do
		local r = outer_fx_radius

		if i % 2 == 0 then
			r = inner_fx_radius
		end

		local p = {}

		p.pos = U.point_on_ellipse(this.pos, r, 2 * math.pi * i / 12)
		p.terrain = GR:cell_type(p.pos.x, p.pos.y)

		log.debug("i:%i pos:%f,%f type:%i", i, p.pos.x, p.pos.y, p.terrain)

		if GR:cell_is(p.pos.x, p.pos.y, TERRAIN_WATER) or P:valid_node_nearby(p.pos.x, p.pos.y, 1) and not GR:cell_is(p.pos.x, p.pos.y, TERRAIN_CLIFF) then
			table.insert(points, p)
		end
	end

	this.fx_points = points

	return true
end

function scripts.tower_bone_flingers.remove(this, store, script)
	for _, b in pairs(this.barrack.soldiers) do
		queue_remove(store, b)
	end
	return true
end

function scripts.tower_bone_flingers.update(this, store, script)
	local last_target_pos = V.v(0, 0)
	local shots_count = 0
	local shooter_sprite_ids = {
		3,
		4
	}
	local a = this.attacks
	local aa = this.attacks.list[1]
	local attack_ids = {
		2,
		3
	}
	local formation_offset = -0.4
	local soldier_added = false
	local bar = this.barrack
	local pow_g = this.powers and this.powers.golem
	local last_soldier_pos
	local skelet
	local skeletonts = 0
	local pow_s = this.powers and this.powers.skeleton
	local as = #this.attacks.list >= 2 and this.attacks.list[2] or nil
	local pow_m = this.powers and this.powers.milk
	
	last_soldier_pos = {}

	aa.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			-- block empty
		else
			if pow_m and pow_m.changed then
				pow_m.changed = nil
				this.barrack.soldier_type = "soldier_bone_golem_"..pow_m.level
			end
			if pow_g and pow_g.changed then
					pow_g.changed = nil
					this.barrack.max_soldiers = pow_g.level
			end
			if pow_s and as and pow_s.changed then
				pow_s.changed = nil
				as.disabled = false
				skeletonts = store.tick_ts
			end
			if pow_s and pow_s.level > 0 and as and not as.disabled and store.tick_ts - skeletonts > pow_s.cooldown[pow_s.level] then
				skeletonts = store.tick_ts
				if pow_s.level == 1 then
					skelet = "bone_flingers_skelebomb"
				end
				if pow_s.level == 2 then
					skelet = "bone_flingers_skelebomb2"
				end
				local enemy = U.find_random_enemy(store.entities, tpos(this), 0, a.range, pow_s.vis_flags, pow_s.vis_bans)
				local b = E:create_entity(skelet)

							b.pos.x, b.pos.y = this.pos.x, this.pos.y
							b.bullet.damage_factor = this.tower.damage_factor
							b.bullet.from = V.vclone(b.pos)
				local inner_fx_radius = 100
				local outer_fx_radius = 150

				for i = 1, 24 do
					local r = outer_fx_radius

					if i % 2 == 0 then
						r = inner_fx_radius
						end
								b.bullet.target_id = U.point_on_ellipse(this.pos, r/2, 2 * math.pi * math.random(1, 24) / 24)
								if not enemy then
								b.bullet.to = U.point_on_ellipse(this.pos, r/2, 2 * math.pi * math.random(1, 24) / 24)
								while GR:cell_is(b.bullet.to.x, b.bullet.to.y, TERRAIN_NOWALK) do
								b.bullet.to = U.point_on_ellipse(this.pos, r/2, 2 * math.pi * math.random(1, 24) / 24)
								coroutine.yield()
								end
								else
								b.bullet.to = enemy.pos
								end
								b.bullet.level = pow_s.level
					end
								queue_insert(store, b)
			end
			soldier_added = false
			for i = 1, bar.max_soldiers do
				local s = bar.soldiers[i]
				if s and s.health.dead then
					last_soldier_pos[i] = s.pos
				end
				if not s or s.health.dead and not store.entities[s.id] then

					if not this.barrack.rally_pos and this.tower.default_rally_pos then
						this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
					end
					s = E:create_entity(bar.soldier_type)
					s.soldier.tower_id = this.id
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, bar, bar.max_soldiers, formation_offset)
					s.pos = last_soldier_pos[i] or V.vclone(s.nav_rally.pos)
					s.nav_rally.new = true

					queue_insert(store, s)

					bar.soldiers[i] = s

					signal.emit("tower-spawn", this, s)

					soldier_added = true
				end
			end
			if soldier_added then
				soldier_added = false

				for _, s in pairs(bar.soldiers) do
					s.nav_rally.new = true
				end
			end
			if bar.rally_new then
				formation_offset = -0.4
				bar.rally_new = false

				signal.emit("rally-point-changed", this)

				local all_dead = true

				for i, s in pairs(bar.soldiers) do
					local s = bar.soldiers[i]

					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, bar, bar.max_soldiers, formation_offset)
					s.nav_rally.new = true
					all_dead = all_dead and s.health.dead
				end

				if not all_dead then
					S:queue(this.sound_events.change_rally_point)
				end
			end
			

			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy = U.find_random_enemy(store.entities, tpos(this), 0, a.range, aa.vis_flags, aa.vis_bans)

				if not enemy then
					-- block empty
				else
					aa.ts = store.tick_ts
					shots_count = shots_count + 1
					last_target_pos.x, last_target_pos.y = enemy.pos.x, enemy.pos.y

					divider = this.tower.level >= 2 and 2 or 1
					local shooter_idx = shots_count % divider + 1
					local shooter_sid = shooter_sprite_ids[shooter_idx]
					local start_offset = aa.bullet_start_offset[shooter_idx]
					local an, af = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, start_offset)

					U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

					while store.tick_ts - aa.ts < aa.shoot_time do
						coroutine.yield()
					end

					local b1 = E:create_entity(aa.bullet)

					if pow_m and pow_m.level == 1 then
						bone_shape = math.random(1,3)
						b1.render.sprites[1].name = "boneflingers_shooter_proyectiles_big_000"..bone_shape
						b1.bullet.miss_decal = "boneflingers_shooter_proyectiles_big_decals_000"..bone_shape
					end
					if pow_m and pow_m.level == 2 then
						bone_shape = math.random(4,6)
						b1.render.sprites[1].name = "boneflingers_shooter_proyectiles_big_000"..bone_shape
						b1.bullet.miss_decal = "boneflingers_shooter_proyectiles_big_decals_000"..bone_shape
					end
					if pow_m and pow_m.level == 3 then
						bone_shape = math.random(7,9)
						b1.render.sprites[1].name = "boneflingers_shooter_proyectiles_big_000"..bone_shape
						b1.bullet.miss_decal = "boneflingers_shooter_proyectiles_big_decals_000"..bone_shape
					end
					if not pow_m or pow_m.level == 0 then
						bone_shape = math.random(1,4)
						b1.render.sprites[1].name = "boneflingers_shooter_proyectiles_000"..bone_shape
						b1.bullet.miss_decal = "boneflingers_shooter_proyectiles_decals_000"..bone_shape
					end
					if pow_m and pow_m.level > 0 then
					b1.bullet.damage_min = b1.bullet.damage_min + pow_m.damage_inc[pow_m.level]
					b1.bullet.damage_max = b1.bullet.damage_max + pow_m.damage_inc[pow_m.level]
					end
					b1.pos.x, b1.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
					b1.bullet.damage_factor = this.tower.damage_factor
					b1.bullet.from = V.vclone(b1.pos)
					b1.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
					b1.bullet.target_id = enemy.id

					queue_insert(store, b1)

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end

					an, af = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid, start_offset)

					U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
				end
			end

			if store.tick_ts - aa.ts > this.tower.long_idle_cooldown then
				for _, sid in pairs(shooter_sprite_ids) do
					local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, sid)

					U.animation_start(this, an, af, store.tick_ts, -1, sid)
				end
			end
		end

		coroutine.yield()
	end
end

scripts.soldier_flingers_skeleton = {}

function scripts.soldier_flingers_skeleton.get_info(this)
	local t = scripts.soldier_barrack.get_info(this)

	t.respawn = nil

	return t
end

function scripts.soldier_flingers_skeleton.insert(this, store, script)
	this.melee.order = U.attack_order(this.melee.attacks)

	local node_offset = math.random(3, 6)

	this.nav_path.ni = this.nav_path.ni + node_offset
	if not P:is_path_active(this.nav_path.pi) then
	this.nav_path.pi = 9
	end
	this.pos = P:node_pos(this.nav_path.pi, this.nav_path.spi, this.nav_path.ni)

	if not this.pos then
		return false
	end

	return true
end

function scripts.soldier_flingers_skeleton.update(this, store, script)
	local attack = this.melee.attacks[1]
	local target
	local expired = false
	local next_pos = V.vclone(this.pos)
	local brk, sta, nearest

	U.y_animation_play(this, "raise", nil, store.tick_ts, 1)

	while true do
		if this.health.dead then
			this.health.hp = 0

			SU.y_soldier_death(store, this)
			queue_remove(store, this)

			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
		else
			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
					this.nav_path.pi
				}, {
					this.nav_path.spi
				})

				if nearest and nearest[1] and nearest[1][3] < this.nav_path.ni then
					this.nav_path.ni = nearest[1][3]
				end

				while next_pos and not target and not this.health.dead and not this.unit.is_stunned do
					U.set_destination(this, next_pos)

					local an, af = U.animation_name_facing_point(this, "running", this.motion.dest)

					U.animation_start(this, an, af, store.tick_ts, -1)
					U.walk(this, store.tick_length)
					coroutine.yield()

					target = U.find_foremost_enemy(store.entities, this.pos, 0, this.melee.range, false, attack.vis_flags, attack.vis_bans)
					next_pos = P:next_entity_node(this, store.tick_length)

					if not next_pos then
						next_pos = nil
					end
				end

				target = nil

				if this.health.dead or not next_pos then
					this.health.hp = 0

					U.y_animation_play(this, "death", nil, store.tick_ts, 1)
					queue_remove(store, this)
				end
			end
		end

		if false then
			-- block empty
		end

		coroutine.yield()
	end
end

scripts.skeleflingerbomb = {}

function scripts.skeleflingerbomb.update(this, store)
	local b = this.bullet

	this.render.sprites[1].r = 20 * math.pi / 180 * (b.to.x > b.from.x and 1 or -1)

	while store.tick_ts - b.ts < b.flight_time do
		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		elseif b.rotation_speed then
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end

		coroutine.yield()
	end

	if b.hit_fx then
		S:queue(this.sound_events.hit)

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	local pi, ni = this._pred_pi, this._pred_ni
	local ni_offset = b.fragment_node_spread * math.floor(b.fragment_count / 2)
	local dest = b.to

	for i = 1, b.fragment_count do
		local bf_dest
		
		if pi and ni and P:is_path_active(pi) then
			bf_dest = P:node_pos(pi, math.random(1, 3), ni)
		else
			bf_dest = U.point_on_ellipse(dest, (50) / 2, 2 * math.pi * i / b.fragment_count)
		end

		bf_dest.x = bf_dest.x + U.frandom(-b.fragment_pos_spread.x, b.fragment_pos_spread.x)
		bf_dest.y = bf_dest.y + U.frandom(-b.fragment_pos_spread.y, b.fragment_pos_spread.y)

		local bf = E:create_entity(b.fragment_name)

		bf.bullet.from = V.vclone(this.pos)
		bf.bullet.to = bf_dest
		bf.bullet.flight_time = bf.bullet.flight_time + fts(i) * math.random(1, 2)
		bf.render.sprites[1].r = 100 * math.random() * (math.pi / 180)
		bf.bullet.level = this.bullet.level

		queue_insert(store, bf)
	end

	queue_remove(store, this)
end

scripts.enemies_skelespawner = {}

function scripts.enemies_skelespawner.update(this, store, script)
	local sp = this.spawner
	local last_subpath = 0
	local cg

	if sp.count_group_type then
		cg = store.count_groups[sp.count_group_type]
	end

	if not sp.pi then
		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)

		if #nodes < 1 then
			log.error("could not find nodes near spawner:%s at %s,%s", this.pos.x, this.pos.y)
			queue_remove(store, this)

			return
		end

		sp.pi, sp.spi, sp.ni = unpack(nodes[1])
	end

	if sp.animation_start then
		U.y_animation_play(this, sp.animation_start, nil, store.tick_ts, 1)
	end

	if sp.animation_concurrent then
		U.animation_start(this, sp.animation_concurrent, nil, store.tick_ts)
	end

	if sp.animation_loop then
		U.animation_start(this, sp.animation_loop, nil, store.tick_ts, true)
	end

	for i = 1, sp.count do
		if sp.interrupt then
			break
		end

		if sp.owner_id and (not store.entities[sp.owner_id] or store.entities[sp.owner_id].health.dead) then
			break
		end

		if cg and cg[sp.count_group_name] and cg[sp.count_group_name] >= sp.count_group_max then
			break
		end

		local e_pi = sp.pi
		local e_spi = sp.spi
		local e_ni = sp.ni

		if sp.allowed_subpaths then
			if sp.random_subpath then
				e_spi = sp.allowed_subpaths[math.random(1, #sp.allowed_subpaths)]
			else
				last_subpath = km.zmod(last_subpath + 1, #sp.allowed_subpaths)
				e_spi = sp.allowed_subpaths[last_subpath]
			end
		end

		if sp.random_node_offset_range then
			e_ni = sp.ni + math.random(unpack(sp.random_node_offset_range))
		else
			e_ni = sp.ni + sp.node_offset
		end

		if sp.check_node_valid and not P:is_node_valid(e_pi, e_ni) then
			-- block empty
		else
			local spawn = E:create_entity(sp.entity)

			spawn.nav_path.pi = e_pi
			spawn.nav_path.spi = e_spi
			spawn.nav_path.ni = e_ni

			if sp.use_node_pos then
				local npos = P:node_pos(e_pi, e_spi, e_ni)

				spawn.pos.x, spawn.pos.y = npos.x, npos.y
			else
				spawn.pos.x, spawn.pos.y = this.pos.x, this.pos.y + sp.pos_offset.y
			end

			if sp.forced_waypoint_offset then
				spawn.motion.forced_waypoint = V.v(this.pos.x + sp.forced_waypoint_offset.x, this.pos.y + sp.forced_waypoint_offset.y)
			end

			spawn.render.sprites[1].name = sp.initial_spawn_animation

			if spawn.unit then
				spawn.unit.spawner_id = this.id
			end

			if spawn.enemy and not sp.keep_gold then
				spawn.enemy.gold = 0
			end

			if sp.count_group_name then
				E:add_comps(spawn, "count_group")

				spawn.count_group.name = sp.count_group_name
				spawn.count_group.type = sp.count_group_type
			end

			queue_insert(store, spawn)
			S:queue(sp.spawn_sound, sp.spawn_sound_args)

			local wait_time = sp.random_cycle and U.frandom(unpack(sp.random_cycle)) or sp.cycle_time

			U.y_wait(store, wait_time, function()
				return sp.interrupt
			end)
		end
	end

	if sp.animation_end then
		U.y_animation_play(this, sp.animation_end, nil, store.tick_ts, 1)
		queue_remove(store, this)
	elseif this.tween then
		U.animation_start(this, "idle", nil, store.tick_ts)

		this.tween.disabled = false
		this.tween.remove = true
	else
		queue_remove(store, this)
	end
end

scripts.bomb_kro = {}

function scripts.bomb_kro.update(this, store, script)
	local b = this.bullet
	local dmin, dmax = b.damage_min, b.damage_max
	local dradius = b.damage_radius

	if b.level and b.level > 0 then
		if b.damage_radius_inc then
			dradius = dradius + b.level * b.damage_radius_inc
		end

		if b.damage_min_inc then
			dmin = dmin + b.level * b.damage_min_inc
		end

		if b.damage_max_inc then
			dmax = dmax + b.level * b.damage_max_inc
		end
	end

	local ps

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	while store.tick_ts - b.ts + store.tick_length < b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		elseif b.rotation_speed then
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end
	end

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, dradius)
	end)

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.damage_type = b.damage_type
		d.reduce_armor = b.reduce_armor
		d.reduce_magic_armor = b.reduce_magic_armor

			local dist_factor = U.dist_factor_inside_ellipse(enemy.pos, b.to, dradius)

			d.value = math.floor(dmax - (dmax - dmin) * dist_factor)

		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id

		queue_damage(store, d)
		log.paranoid("bomb id:%s, radius:%s, enemy id:%s, dist:%s, damage:%s damage_type:%x", this.id, dradius, enemy.id, V.dist(enemy.pos.x, enemy.pos.y, b.to.x, b.to.y), d.value, d.damage_type)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = enemy.id
			mod.modifier.source_id = this.id

			queue_insert(store, mod)
		end
	end

	local p = SU.create_bullet_pop(store, this)

	queue_insert(store, p)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if b.hit_fx_water and band(cell_type, TERRAIN_WATER) ~= 0 then
		S:queue(this.sound_events.hit_water)

		local water_fx = E:create_entity(b.hit_fx_water)

		water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
		water_fx.render.sprites[1].ts = store.tick_ts
		water_fx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, water_fx)
	elseif b.hit_fx then
		S:queue(this.sound_events.hit)

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, sfx)
	end

	if b.hit_decal and band(cell_type, TERRAIN_WATER) == 0 then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if b.hit_payload then
		local hp

		if type(b.hit_payload) == "string" then
			hp = E:create_entity(b.hit_payload)
		else
			hp = b.hit_payload
		end

		hp.pos.x, hp.pos.y = b.to.x, b.to.y

		if hp.aura then
			hp.aura.level = this.bullet.level
		end

		queue_insert(store, hp)
	end

	queue_remove(store, this)
end

--兽巢
scripts.tower_orc_warriors_den = {}

function scripts.tower_orc_warriors_den.get_info(this)
	local s = E:get_template("soldier_orc_warrior_lvl"..this.tower.level)
	local o = scripts.tower_barrack.get_info(this)
	local pow_b = this.powers.bloodlust

	o.respawn = s.health.dead_lifetime
	o.hp_max = s.health.hp_max
	o.damage_min = s.melee.attacks[1].damage_min
	o.damage_max = s.melee.attacks[1].damage_max
	o.armor = s.health.armor
	
	if pow_b.level > 0 then
		o.damage_min = math.floor(s.melee.attacks[1].damage_min * pow_b.damage_factor[pow_b.level])
		o.damage_max = math.ceil(s.melee.attacks[1].damage_max * pow_b.damage_factor[pow_b.level])
	end

	return o
end

function scripts.tower_orc_warriors_den.update(this, store, script)
	local tower_sid = 2
	local door_sid = 3
	local orcs = E:get_template("soldier_orc_warrior_lvl4")
	local capped = nil
	local blooded = nil
	local blooded2 = nil
	local pow_p = this.powers.promotion
	local pow_b = this.powers.bloodlust

	while true do
		local b = this.barrack
		--local cap = this.barrack.soldiers[1]
		
		if not this.tower.blocked then
			for i = 1, b.max_soldiers do
				local s = b.soldiers[i]

				if not s or s.health.dead and not store.entities[s.id] then
					if not b.door_open then
						S:queue("GUITowerOpenDoor")
						U.animation_start(this, "open", nil, store.tick_ts, 1, door_sid)

						while not U.animation_finished(this, door_sid) do
							coroutine.yield()
						end

						b.door_open = true
						b.door_open_ts = store.tick_ts
					end
					local healthmax = 0
					if s == b.soldiers[1] and pow_p.level == 1 then
					healthmax = 1
					end

					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.id
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers)
					s.nav_rally.new = true
					if healthmax == 1 then
						s.render.sprites[1].prefix = "warmongers_soldier_orc_captain"
						s.info.portrait = "gui4_bottom_info_image_soldiers_0014"
						s.regen.health = pow_p.regen
						s.melee.attacks[1].damage_min = pow_p.damage_min
						s.melee.attacks[1].damage_max = pow_p.damage_max
						s.health.hp_max = pow_p.hp_max
						s.health.armor = pow_p.armor
					end
					
					
					if pow_b.level > 0 then
						if healthmax == 1 then
							s.melee.attacks[1].damage_min = math.ceil(pow_p.damage_min * pow_b.damage_factor[pow_b.level])
							s.melee.attacks[1].damage_max = math.ceil(pow_p.damage_max * pow_b.damage_factor[pow_b.level])
						else
							s.melee.attacks[1].damage_min = math.ceil(s.melee.attacks[1].damage_min * pow_b.damage_factor[pow_b.level])
							s.melee.attacks[1].damage_max = math.ceil(s.melee.attacks[1].damage_max * pow_b.damage_factor[pow_b.level])
						end
					end

					if this.powers then
						for pn, p in pairs(this.powers) do
							s.powers[pn].level = p.level
						end
					end

					queue_insert(store, s)

					b.soldiers[i] = s

					signal.emit("tower-spawn", this, s)
				end
			end
		end

		if b.door_open and store.tick_ts - b.door_open_ts > b.door_hold_time then
			U.animation_start(this, "close", nil, store.tick_ts, 1, door_sid)

			while not U.animation_finished(this, door_sid) do
				coroutine.yield()
			end

			b.door_open = false
		end
		

		if b.rally_new then
			b.rally_new = false

			signal.emit("rally-point-changed", this)

			local all_dead = true

			for i, s in ipairs(b.soldiers) do
				s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, b.rally_angle_offset)
				s.nav_rally.new = true
				all_dead = all_dead and s.health.dead
			end

			if not all_dead then
				S:queue(this.sound_events.change_rally_point)
			end
		end


		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil
					if p == pow_p then
						this.barrack.soldiers[1].health.hp = pow_p.hp_max
					end

					for _, s in pairs(b.soldiers) do
						s.powers[pn].level = p.level
						s.powers[pn].changed = true
					end
				end
			end
		end
		if pow_p.level > 0 and not capped then
			this.barrack.soldiers[1].render.sprites[1].prefix = "warmongers_soldier_orc_captain"
			--cap.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0009") or "krv_portraits_0009"
			this.barrack.soldiers[1].regen.health = pow_p.regen
			this.barrack.soldiers[1].melee.attacks[1].damage_min = pow_p.damage_min
			this.barrack.soldiers[1].melee.attacks[1].damage_max = pow_p.damage_max
			this.barrack.soldiers[1].health.hp_max = pow_p.hp_max
			this.barrack.soldiers[1].health.armor = pow_p.armor
			this.barrack.soldiers[1].is_capped = true
			
			if pow_b.level > 0 then
				this.barrack.soldiers[1].melee.attacks[1].damage_min = math.ceil(pow_p.damage_min * pow_b.damage_factor[pow_b.level])
				this.barrack.soldiers[1].melee.attacks[1].damage_max = math.ceil(pow_p.damage_max * pow_b.damage_factor[pow_b.level])
			end
			
			capped = true
		end

		coroutine.yield()
	end
end

scripts.soldier_orc_warrior = {}

function scripts.soldier_orc_warrior.insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		if this.powers.seal.level > 0 then
		local e = E:create_entity("aura_orc_warrior_regen")

				e.aura.source_id = this.id
				e.aura.ts = store.tick_ts
				e.hps.heal_min = math.ceil(e.hps.heal_min+e.hps.heal_inc[this.powers.seal.level])
				e.hps.heal_max = math.ceil(e.hps.heal_max+e.hps.heal_inc[this.powers.seal.level])
							
		queue_insert(store, e)
		end
		return true
	end

	return false
end

function scripts.soldier_orc_warrior.update(this, store)
	local brk, sta
	local ba = this.melee.attacks[1]
	local sold = E:get_template(this.template_name)
	local tow = E:get_template("tower_orc_warriors_den_lvl4")
	local pow_p = tow.powers.promotion
	local pow_b = tow.powers.bloodlust
	this.is_capped = false
	this.capped = false
	
	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	while true do
		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					SU.soldier_power_upgrade(this, pn)

						if pn == "bloodlust" then
							if this.render.sprites[1].prefix == "warmongers_soldier_orc_captain" then
							ba.damage_min = math.ceil(pow_p.damage_min*pow_b.damage_factor[p.level])
							ba.damage_max = math.ceil(pow_p.damage_max*pow_b.damage_factor[p.level])
							else
							ba.damage_min = math.floor(sold.melee.attacks[1].damage_min*pow_b.damage_factor[p.level])
							ba.damage_max = math.ceil(sold.melee.attacks[1].damage_max*pow_b.damage_factor[p.level])
							end
						else
						if pn == "seal" then
							SU.remove_auras(store, this)
							local e = E:create_entity("aura_orc_warrior_regen")

							e.aura.source_id = this.id
							e.aura.ts = store.tick_ts
							e.hps.heal_min = math.ceil(e.hps.heal_min+e.hps.heal_inc[p.level])
							e.hps.heal_max = math.ceil(e.hps.heal_max+e.hps.heal_inc[p.level])
							
							queue_insert(store, e)
						end
						if pn == "promotion" and this.is_capped == true then
							this.is_capped = false
							this.capped = true
							U.animation_start(this, "spawn", nil, store.tick_ts, false, 1)
							U.y_wait(store, fts(34))
							--U.animation_start(this, "idle", nil, store.tick_ts, false, 1)
						end
					end
				end
			end
		end


		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			SU.y_soldier_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
		
			if this.render.sprites[1].prefix == "soldier_orc_captain" then
				this.info.i18n_key = "SOLDIER_ORC_WARRIOR_CAPTAIN"
				this.info.random_name_format = nil
			end

			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_53_2
				end
			end


			::label_53_1::

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_53_2
				end
			end

			if SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::label_53_2::

		coroutine.yield()
	end
end

scripts.aura_orc_warrior_regen = {}

function scripts.aura_orc_warrior_regen.update(this, store)
	local hps = this.hps
	local hero = store.entities[this.aura.source_id]

	if not hero then
		return
	end

	while true do
		if not hero.health.dead and store.tick_ts - hps.ts >= hps.heal_every then
			hps.ts = store.tick_ts
			hero.health.hp = km.clamp(0, hero.health.hp_max, hero.health.hp + hps.heal_max)
		end

		coroutine.yield()
	end
end

--萨满
scripts.tower_orc_shaman = {}

function scripts.tower_orc_shaman.update(this, store, script)
	local tower_sid = 2
	local shooter_sid = 3
	local eye_sid = 8
	local s_tower = this.render.sprites[tower_sid]
	local s_shooter = this.render.sprites[shooter_sid]
	local a = this.attacks
	local ba = this.attacks.list[1]
	local va = this.attacks.list[2]
	local ma = this.attacks.list[3]
	local pow_s = this.powers.shock
	local pow_m = this.powers.meteor
	local pow_v = this.powers.vines

	ba.ts = store.tick_ts
	
	this.render.sprites[4].ts = store.tick_ts
	this.render.sprites[5].ts = store.tick_ts + fts(2)
	this.render.sprites[6].ts = store.tick_ts + fts(4)
	this.render.sprites[7].ts = store.tick_ts + fts(6)
	
	local function find_soldier_pair(entities, origin, min_range, max_range, pair_range, flags, bans, filter_func)
		local soldiers = U.find_soldiers_in_range(entities, origin, min_range, max_range, flags, bans, filter_func)

		if not soldiers or #soldiers == 0 or #soldiers < 2 then
			return nil
		else
			table.sort(soldiers, function(e1, e2)
				return V.dist(e1.pos.x, e1.pos.y, origin.x, origin.y) < V.dist(e2.pos.x, e2.pos.y, origin.x, origin.y)
			end)
			
			for i = 1, #soldiers do
				if soldiers[i] and soldiers[i + 1] and U.is_inside_ellipse(soldiers[i + 1].pos, soldiers[i].pos, pair_range) then
					return soldiers[i]
				end
				i = i + 1
			end
			return nil
		end
	end
	
	local function find_enemy_pair(entities, origin, min_range, max_range, pair_range, flags, bans, filter_func)
		local enemies = U.find_enemies_in_range(entities, origin, min_range, max_range, flags, bans, filter_func)

		if not enemies or #enemies == 0 or #enemies < 2 then
			return nil
		else
			table.sort(enemies, function(e1, e2)
				return V.dist(e1.pos.x, e1.pos.y, origin.x, origin.y) < V.dist(e2.pos.x, e2.pos.y, origin.x, origin.y)
			end)
			
			for i = 1, #enemies do
				if enemies[i] and enemies[i + 1] and U.is_inside_ellipse(enemies[i + 1].pos, enemies[i].pos, pair_range) then
					return enemies[i]
				else
					i = i + 1
				end
			end
			return nil
		end
	end

	while true do
		if this.tower.blocked then

			coroutine.yield()
		else
			if pow_m.changed then
				pow_m.changed = nil
				
				ma.loops = ma.loops_base + ma.loops_inc * pow_m.level

				if pow_m.level == 1 then
					ma.ts = store.tick_ts
				end
			end
			
			if pow_v.changed then
				pow_v.changed = nil
				
				if pow_v.level == 1 then
					va.ts = store.tick_ts
				end
			end

			if pow_m.level > 0 and store.tick_ts - ma.ts > ma.cooldown then
				local target = find_enemy_pair(store.entities, tpos(this), 0, a.range, ma.target_range, ma.vis_flags, ma.vis_bans)

				if not target then
					-- block empty
				else
					ma.ts = store.tick_ts

					local an, af, ai = U.animation_name_facing_point(this, ma.animation, target.pos, shooter_sid)

					U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

					while store.tick_ts - ma.ts < ma.shoot_time do
						coroutine.yield()
					end
					for i = 1, ma.loops do
						local b = E:create_entity(ma.bullet)
						local u = nil--UP:get_upgrade("mage_runes_of_power")
						local btox
						local btoy
						
						btox = target.pos.x + math.random(ma.max_spread * -1, ma.max_spread)
						btoy = target.pos.y + math.random(ma.max_spread * -1, ma.max_spread)
						b.bullet.to = V.v(btox, btoy)
						while not U.is_inside_ellipse(b.bullet.to, P:node_pos(target.nav_path.pi, 1, target.nav_path.ni), ma.max_spread) do
							btox = target.pos.x + math.random(ma.max_spread * -1, ma.max_spread)
							btoy = target.pos.y + math.random(ma.max_spread * -1, ma.max_spread)
							b.bullet.to = V.v(btox, btoy)
							coroutine.yield()
						end
						b.pos.x, b.pos.y = b.bullet.to.x + ma.bullet_start_offset.x, b.bullet.to.y + ma.bullet_start_offset.y
						b.bullet.from = V.vclone(b.pos)
						b.bullet.level = pow_m.level
						b.bullet.target_id = target.id
						b.bullet.source_id = this.id
						b.render.sprites[1].ts = store.tick_ts
						if u and math.random() < u.chance then
							b.bullet.damage_factor = b.bullet.damage_factor * u.damage_factor
							b.bullet.pop = {
								"pop_crit"
							}
							b.bullet.pop_conds = DR_DAMAGE
						end

						queue_insert(store, b)
						
						U.y_wait(store, 0.2)
					end

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end
				end
			end
			
			if pow_v.level > 0 and store.tick_ts - va.ts > va.cooldown then
				local target = find_soldier_pair(store.entities, tpos(this), 0, va.range, va.target_range, va.vis_flags, va.vis_bans, function(e)
					return e.soldier and e.health.hp < (e.health.hp_max * va.min_health)
				end)

				if not target then
					SU.delay_attack(store, va, 0.13333333333333333)
				else
					va.ts = store.tick_ts

					local an, af, ai = U.animation_name_facing_point(this, va.animation, target.pos, shooter_sid)

					U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

					while store.tick_ts - va.ts < va.shoot_time do
						coroutine.yield()
					end

					local vines = E:create_entity(va.bullet)

					vines.pos = V.vclone(target.pos)
					vines.aura.level = pow_v.level

					queue_insert(store, vines)

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end
				end
			end

			if store.tick_ts - ba.ts > ba.cooldown then
				local target

				target = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, ba.vis_flags, ba.vis_bans)

				if not target then
					-- block empty
				else
					ba.ts = store.tick_ts

					local an, af, ai = U.animation_name_facing_point(this, ba.animation, target.pos, shooter_sid)

					U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)
					U.animation_start(this, an, nil, store.tick_ts, 1, eye_sid)

					while store.tick_ts - ba.ts < ba.shoot_time do
						coroutine.yield()
					end

					if target then
						local start_offset = ba.bullet_start_offset[ai]
						local b = E:create_entity(ba.bullet)
						local u = nil--UP:get_upgrade("mage_runes_of_power")

						b.bullet.damage_factor = this.tower.damage_factor
						b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
						b.pos = V.vclone(b.bullet.from)
						b.bullet.target_id = target.id
						b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
						
						if u and math.random() < u.chance then
							b.bullet.damage_factor = b.bullet.damage_factor * u.damage_factor
							b.bullet.pop = {
								"pop_crit_high_elven"
							}
							b.bullet.pop_conds = DR_DAMAGE
						end

						queue_insert(store, b)

						if pow_s.level > 0 and math.random() < ba.payload_chance and band(target.vis.flags, F_FLYING) == 0 then
							local blast = E:create_entity(ba.payload_bullet)

							blast.bullet.level = pow_s.level
							blast.bullet.init_target_id = target.id
							b.bullet.payload = blast
						end
					end

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end
				end
			end

			if store.tick_ts - math.max(ba.ts, ma.ts, va.ts) > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end

			coroutine.yield()
		end
	end
end

scripts.bolt_shock = {}

function scripts.bolt_shock.update(this, store, script)
	local b = this.bullet
	local dradius = b.damage_radius
	local dmin = b.damage_min + b.damage_inc_min[b.level]
	local dmax = b.damage_max + b.damage_inc_max[b.level]
	local explode_pos = V.v(this.pos.x, this.pos.y - 8)

	U.animation_start(this, "hit", nil, store.tick_ts, 1)

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, explode_pos, dradius) and b.init_target_id ~= v.id
	end)
	local d_value = U.frandom(dmin, dmax)

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = math.ceil(d_value)
		d.damage_type = b.damage_type

		queue_damage(store, d)
	end

	while not U.animation_finished(this) do
		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.aura_orc_shaman_vines = {}

function scripts.aura_orc_shaman_vines.insert(this, store, script)
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
	
	U.animation_start(this, "in", nil, store.tick_ts, 1)

	return true
end

function scripts.aura_orc_shaman_vines.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0

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
				goto label_89_0
			end

			if this.render then
				this.render.sprites[1].hidden = not te.enemy.can_do_magic
			end

			if not te.enemy.can_do_magic then
				goto label_89_0
			end
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_89_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.health and te.health.dead then
				goto label_89_0
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

		::label_89_0::

		coroutine.yield()
	end

	signal.emit("aura-apply-mod-victims", this, victims_count)
	U.animation_start(this, "out", nil, store.tick_ts, 1)
	
	while not U.animation_finished(this) do
		coroutine.yield()
	end
	
	queue_remove(store, this)
end

--火箭
scripts.tower_rocket_riders = {}

function scripts.tower_rocket_riders.remove(this, store)
	if this.boxes then
		for _, e in pairs(this.boxes) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_rocket_riders.insert(this, store, script)
	local points = {}
	local inner_fx_radius = 100
	local outer_fx_radius = 115
	local aspect = 0.7

	for i = 1, 12 do
		local r = outer_fx_radius

		if i % 2 == 0 then
			r = inner_fx_radius
		end

		local p = {}

		p.pos = U.point_on_ellipse(this.pos, r, 2 * math.pi * i / 12)
		p.terrain = GR:cell_type(p.pos.x, p.pos.y)

		log.debug("i:%i pos:%f,%f type:%i", i, p.pos.x, p.pos.y, p.terrain)

		if GR:cell_is(p.pos.x, p.pos.y, TERRAIN_WATER) or P:valid_node_nearby(p.pos.x, p.pos.y, 1) and not GR:cell_is(p.pos.x, p.pos.y, TERRAIN_CLIFF) then
			table.insert(points, p)
		end
	end

	this.fx_points = points

	return true
end

function scripts.tower_rocket_riders.update(this, store, script)
	local tower_sid = 2
	local common_sid = 3
	local nitro_sid = 4
	local a = this.attacks
	local ab = this.attacks.list[1]
	local am = this.attacks.list[2]
	local ac = this.attacks.list[3]
	local an = this.attacks.list[4]
	local pow_m = this.powers.mine
	local pow_c = this.powers.engine
	local pow_n = this.powers.nitro
	local last_ts = store.tick_ts - ab.cooldown / 2
	this.boxes = {}

	ab.ts = last_ts

	local aa, pow
	local attacks = { am, ac, an, ab }
	local pows = { pow_m, pow_c, pow_n }

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow == pow_m then
						if not table.contains(table.map(this.boxes, function(k, v)
						return v.template_name
					end), pow_m.entity) then
						local s = E:create_entity(pow_m.entity)

						s.pos = V.vclone(this.pos)
						s.owner = this

						queue_insert(store, s)
						table.insert(this.boxes, s)
					end
					elseif pow == pow_c and pow.level == 1 then
						ac.ts = store.tick_ts
					elseif pow == pow_n and pow.level == 1 then
						an.ts = store.tick_ts
					end
				end
			end

			for i, aa in pairs(attacks) do
				pow = pows[i]

				if (not pow or pow.level > 0) and store.tick_ts - aa.ts > aa.cooldown and (pow == pow_m or store.tick_ts - last_ts > a.min_cooldown) then
					local trigger, enemies, trigger_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

					if not trigger then
						-- block empty
					else
						aa.ts = store.tick_ts

						if pow ~= pow_m then
							last_ts = aa.ts
						end
						--U.animation_start(this, aa.animation, nil, store.tick_ts, false, tower_sid)
						if this.tower.level == 4 then
							if aa == an then
								this.render.sprites[nitro_sid].hidden = false
								this.render.sprites[common_sid].hidden = true
							else
								this.render.sprites[nitro_sid].hidden = true
								this.render.sprites[common_sid].hidden = false
							end
						end
						U.animation_start_group(this, aa.animation, nil, store.tick_ts, false, "layers")
						U.y_wait(store, aa.shoot_time)

						local enemy, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						local dest = enemy and pred_pos or trigger_pos

						if V.dist(tpos(this).x, tpos(this).y, dest.x, dest.y) <= aa.range then
							local b = E:create_entity(aa.bullet)
							local flip = dest.x > this.pos.x
							
							b.render.sprites[1].flip_y = not flip
							b.render.sprites[1].flip_x = true

							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.damage_factor = this.tower.damage_factor
							b.bullet.from = V.vclone(b.pos)

								b.bullet.to = dest
								
							if aa == an then
							b.bullet.damage_min = pow_n.damage_inc[pow_n.level]
							b.bullet.damage_max = pow_n.damage_inc[pow_n.level]
							end

								if aa == ac then
									b.bullet.fragment_count = pow_c.fragment_count[pow_c.level]
									b.bullet.fragment_node_spread = pow_c.fragment_node_spread[pow_c.level]
									b.bullet.level = pow_c.level
							end

							b.bullet.target_id = enemy and enemy.id or trigger.id
							b.bullet.source_id = this.id

							queue_insert(store, b)
						end
						U.y_animation_wait(this, tower_sid)
					end
				end
			end

			--U.animation_start(this, "idle", nil, store.tick_ts, false, tower_sid)
			U.animation_start_group(this, "idle", nil, store.tick_ts, false, "layers")
			coroutine.yield()
		end
	end
end

scripts.mine_box = {}

function scripts.mine_box.update(this, store)
	local a = this.attacks.list[1]

	a.ts = store.tick_ts
	
	while true do
		if store.tick_ts - a.ts > a.cooldown then
			a.ts = store.tick_ts
			U.animation_start(this, a.animation, nil, store.tick_ts)
			U.y_wait(store, a.shoot_time)
				
			local b = E:create_entity(a.bullet)

			b.pos.x, b.pos.y = this.pos.x + a.bullet_start_offset.x, this.pos.y + a.bullet_start_offset.y
			b.bullet.damage_factor = this.owner.tower.damage_factor
			b.bullet.from = V.vclone(b.pos)
			local inner_fx_radius = 100
			local outer_fx_radius = 150

			for i = 1, 24 do
				local r = outer_fx_radius

				if i % 2 == 0 then
					r = inner_fx_radius
				end
				b.bullet.target_id = U.point_on_ellipse(this.pos, r/2, 2 * math.pi * math.random(1, 24) / 24)
				b.bullet.source_id = this.id
				b.bullet.to = U.point_on_ellipse(this.pos, r/2, 2 * math.pi * math.random(1, 24) / 24)
				while GR:cell_is(b.bullet.to.x, b.bullet.to.y, TERRAIN_NOWALK) do
					b.bullet.to = U.point_on_ellipse(this.pos, r/2, 2 * math.pi * math.random(1, 24) / 24)
					coroutine.yield()
				end
				b.bullet.level = this.owner.powers.mine.level
			end
			queue_insert(store, b)
		end

		coroutine.yield()
	end
end

scripts.mine_rr = {}

function scripts.mine_rr.update(this, store, script)
	local b = this.bullet
	local dmin, dmax = b.damage_min, b.damage_max
	local dradius = b.damage_radius

	if b.level and b.level > 0 then
		if b.damage_radius_inc then
			dradius = dradius + b.level * b.damage_radius_inc
		end

		if b.damage_min_inc then
			dmin = dmin + b.level * b.damage_min_inc
		end

		if b.damage_max_inc then
			dmax = dmax + b.level * b.damage_max_inc
		end
	end

	local ps

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	while store.tick_ts - b.ts + store.tick_length < b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		elseif b.rotation_speed then
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end
	end

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, dradius)
	end)

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.damage_type = b.damage_type
		d.reduce_armor = b.reduce_armor
		d.reduce_magic_armor = b.reduce_magic_armor

		if this.up_alchemical_powder_chance and math.random() < this.up_alchemical_powder_chance or UP:get_upgrade("engineer_efficiency") then
			d.value = dmax
		else
			local dist_factor = U.dist_factor_inside_ellipse(enemy.pos, b.to, dradius)

			d.value = math.floor(dmax - (dmax - dmin) * dist_factor)
		end

		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id

		queue_damage(store, d)
		log.paranoid("bomb id:%s, radius:%s, enemy id:%s, dist:%s, damage:%s damage_type:%x", this.id, dradius, enemy.id, V.dist(enemy.pos.x, enemy.pos.y, b.to.x, b.to.y), d.value, d.damage_type)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = enemy.id
			mod.modifier.source_id = this.id

			queue_insert(store, mod)
		end
	end

	local p = SU.create_bullet_pop(store, this)

	queue_insert(store, p)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if b.hit_fx_water and band(cell_type, TERRAIN_WATER) ~= 0 then
		S:queue(this.sound_events.hit_water)

		local water_fx = E:create_entity(b.hit_fx_water)

		water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
		water_fx.render.sprites[1].ts = store.tick_ts
		water_fx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, water_fx)
	elseif b.hit_fx then
		S:queue(this.sound_events.hit)

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, sfx)
	end

	if b.hit_decal and band(cell_type, TERRAIN_WATER) == 0 then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if b.hit_payload then
		local hp

		if type(b.hit_payload) == "string" then
			hp = E:create_entity(b.hit_payload)
		else
			hp = b.hit_payload
		end

		hp.pos.x, hp.pos.y = b.to.x, b.to.y
		hp.damage_min = this.bullet.damage_inc[this.bullet.level]
		hp.damage_max = this.bullet.damage_inc[this.bullet.level]

		if hp.aura then
			hp.aura.level = this.bullet.level
		end

		queue_insert(store, hp)
	end

	queue_remove(store, this)
end

scripts.mine_rr_initial = {}

function scripts.mine_rr_initial.update(this, store)
	local b = this.bullet

	this.render.sprites[1].r = 20 * math.pi / 180 * (b.to.x > b.from.x and 1 or -1)

	while store.tick_ts - b.ts < b.flight_time do
		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		elseif b.rotation_speed then
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end

		coroutine.yield()
	end

	if b.hit_fx then
		S:queue(this.sound_events.hit)

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	local pi, ni = this._pred_pi, this._pred_ni
	local ni_offset = b.fragment_node_spread * math.floor(b.fragment_count / 2)
	local dest = b.to

	for i = 1, b.fragment_count do
		local bf_dest
		
		::label_39232_1::
		
		if pi and ni then
			bf_dest = P:node_pos(pi, math.random(1, 3), ni + ni_offset - i * b.fragment_node_spread)
		else
			bf_dest = U.point_on_ellipse(dest, (50 * math.random() + 45) / 2, 2 * math.pi * i / b.fragment_count)
		end

		bf_dest.x = bf_dest.x + U.frandom(-b.fragment_pos_spread.x, b.fragment_pos_spread.x)
		bf_dest.y = bf_dest.y + U.frandom(-b.fragment_pos_spread.y, b.fragment_pos_spread.y)

		local bf = E:create_entity(b.fragment_name)

		bf.bullet.from = V.vclone(this.pos)
		bf.bullet.to = bf_dest
		bf.bullet.flight_time = bf.bullet.flight_time + fts(i) * math.random(1, 2)
		bf.render.sprites[1].r = 100 * math.random() * (math.pi / 180)
		bf.bullet.level = this.bullet.level

		queue_insert(store, bf)
	end

	queue_remove(store, this)
end

scripts.decal_rr_mine = {}

function scripts.decal_rr_mine.update(this, store)
	local ts = store.tick_ts

	while true do
		if store.tick_ts - ts >= this.duration then
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, this.vis_flags, this.vis_bans2)
			local dec = E:create_entity(this.hit_decal)

			dec.pos = V.vclone(this.pos)
			dec.render.sprites[1].ts = store.tick_ts

			queue_insert(store, dec)
			S:queue(this.sound)

			local fx = E:create_entity(this.hit_fx)

			fx.pos = V.vclone(this.pos)
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
			if targets and #targets > 0 then
			for _, t in ipairs(targets) do
				local d = E:create_entity("damage")

				d.damage_type = this.damage_type
				d.source_id = this.id
				d.target_id = t.id
				d.value = math.random(this.damage_min, this.damage_max)

				queue_damage(store, d)
			end
		end
		break
		end

		local trigger = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, this.vis_flags, this.vis_bans)
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, this.vis_flags, this.vis_bans2)

		if trigger and #trigger > 0 then
			local dec = E:create_entity(this.hit_decal)

			dec.pos = V.vclone(this.pos)
			dec.render.sprites[1].ts = store.tick_ts

			queue_insert(store, dec)
			S:queue(this.sound)

			local fx = E:create_entity(this.hit_fx)

			fx.pos = V.vclone(this.pos)
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)

			for _, t in ipairs(targets) do
				local d = E:create_entity("damage")

				d.damage_type = this.damage_type
				d.source_id = this.id
				d.target_id = t.id
				d.value = math.random(this.damage_min, this.damage_max)

				queue_damage(store, d)
			end

			break
		end

		U.y_wait(store, this.check_interval)
	end

	queue_remove(store, this)
end

scripts.engine_rr = {}

function scripts.engine_rr.update(this, store)
	local b = this.bullet

	this.render.sprites[1].r = 20 * math.pi / 180 * (b.to.x > b.from.x and 1 or -1)

	while store.tick_ts - b.ts < b.flight_time do
		local ps

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end
		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		elseif b.rotation_speed then
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end

		coroutine.yield()
	end

	if b.hit_fx then
		S:queue(this.sound_events.hit)

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	local pi, ni = this._pred_pi, this._pred_ni
	local ni_offset = b.fragment_node_spread * math.floor(b.fragment_count / 2)
	local dest = b.to

	for i = 1, b.fragment_count do
		local bf_dest

		if pi and ni then
			bf_dest = P:node_pos(pi, math.random(1, 3), ni + ni_offset - i * b.fragment_node_spread)
		else
			bf_dest = U.point_on_ellipse(dest, (50 * math.random() + 45) / 2, 2 * math.pi * i / b.fragment_count)
		end

		bf_dest.x = bf_dest.x + U.frandom(-b.fragment_pos_spread.x, b.fragment_pos_spread.x)
		bf_dest.y = bf_dest.y + U.frandom(-b.fragment_pos_spread.y, b.fragment_pos_spread.y)

		local bf = E:create_entity(b.fragment_name)

		bf.bullet.from = V.vclone(this.pos)
		bf.bullet.to = bf_dest
		bf.bullet.flight_time = bf.bullet.flight_time + fts(i) * math.random(1, 2)
		bf.render.sprites[1].r = 100 * math.random() * (math.pi / 180)
		bf.render.sprites[1].name = bf.render.sprites[1].name..math.random(1,2)
		bf.bullet.damage_min = this.bullet.damage_inc[this.bullet.level]
		bf.bullet.damage_max = this.bullet.damage_inc[this.bullet.level]

		queue_insert(store, bf)
	end

	queue_remove(store, this)
end

--僵尸
scripts.tower_grim_cemetery = {}
--[[
function scripts.tower_grim_cemetery.get_info(this)
	local s = E:get_template("soldier_zombie_lvl"..this.tower.level)
	local ar = E:get_template("grim_cemetery_aura_lvl"..this.tower.level)

	if this.powers then
		for pn, p in pairs(this.powers) do
			for i = 1, p.level do
				SU.soldier_power_upgrade(s, pn)
			end
		end
	end

	local s_info = s.info.fn(s)
	local attacks

	if s.melee and s.melee.attacks then
		attacks = s.melee.attacks
	elseif s.ranged and s.ranged.attacks then
		attacks = s.ranged.attacks
	end

	local min, max

	for _, a in pairs(attacks) do
		if a.damage_min then
			min, max = a.damage_min, a.damage_max

			break
		end
	end

	if min and max then
		min, max = math.ceil(min), math.ceil(max)
	end

	return {
		type = STATS_TYPE_TOWER_BARRACK,
		hp_max = s.health.hp_max,
		damage_min = min,
		damage_max = max,
		armor = s.health.armor,
		respawn = ar.spawn_cooldown
	}
end
]]--
function scripts.tower_grim_cemetery.get_info(this)
	local s = E:get_template("soldier_zombie_lvl"..this.tower.level)
	local ar = E:get_template("grim_cemetery_aura_lvl"..this.tower.level)

	if this.powers then
		for pn, p in pairs(this.powers) do
			for i = 1, p.level do
				SU.soldier_power_upgrade(s, pn)
			end
		end
	end

	local s_info = s.info.fn(s)
    local attacks, damage_type
    local min, max
	local yes_melee = true
    local no_ranged = true
	local dodge_chance
	local dodge = nil

    if s.melee and s.melee.attacks then
        attacks = s.melee.attacks
        for _, a in pairs(attacks) do
            if a.damage_min then
                min, max = a.damage_min, a.damage_max
                damage_type = a.damage_type
                break
            end
        end
        if s.unit and min then
            min, max = min * s.unit.damage_factor, max * s.unit.damage_factor
        end

        if min and max then
            min, max = math.ceil(min), math.ceil(max)
        end
    end

    local ranged_min, ranged_max
    local ranged_damage_type
	local ranged_damage_type
    if s.ranged and s.ranged.attacks then
		ranged_attacks = s.ranged.attacks
        for _, a in pairs(ranged_attacks) do
            if not a.disabled and a.bullet then
                local b = E:get_template(a.bullet)
                local level = a.level
                if b and b.bullet.damage_min and b.bullet.damage_max then
                    if level and b.bullet.damage_inc then
                        ranged_min, ranged_max = b.bullet.damage_min + (b.bullet.damage_inc * level),
                            b.bullet.damage_max + (b.bullet.damage_inc * level)
                    else
                        ranged_min, ranged_max = b.bullet.damage_min,b.bullet.damage_max
                    end
                    ranged_damage_type = b.bullet.damage_type
                    break
                end
            end
        end

        if s.unit and ranged_min then
            ranged_min, ranged_max = ranged_min * s.unit.damage_factor, ranged_max * s.unit.damage_factor
        end

        if ranged_min and ranged_max then
            ranged_min, ranged_max = math.ceil(ranged_min), math.ceil(ranged_max)
        end
    end

    if ranged_damage_type then
        no_ranged = false
    end

    local melee_count = 0
    if s.melee and s.melee.attacks then
        melee_count = #s.melee.attacks
    end

    if no_ranged and melee_count > 1 then
        while melee_count > 1 do
            local a = s.melee.attacks[melee_count]
            if a.damage_min and not a.disabled then
                ranged_min, ranged_max = a.damage_min, a.damage_max
                ranged_damage_type = a.damage_type
                if s.unit then
                    ranged_min, ranged_max = ranged_min * s.unit.damage_factor, ranged_max * s.unit.damage_factor
                end
                ranged_min, ranged_max = math.ceil(ranged_min), math.ceil(ranged_max)
                break
            end
            melee_count = melee_count - 1
        end
    end

	if s.dodge then
		dodge = true
		dodge_chance = s.dodge.chance
	end

	local armor = band(s.health.immune_to, DAMAGE_PHYSICAL) ~= 0 and 1 or s.health.armor
	local magic_armor = band(s.health.immune_to, DAMAGE_MAGICAL) ~= 0 and 1 or s.health.magic_armor

    return {
        type = STATS_TYPE_TOWER_BARRACK,
        hp_max = s.health.hp_max,

        damage_min = min,
        damage_max = max,
        damage_type = damage_type,
		damage_icon = s.info.damage_icon,

        ranged_damage_min = ranged_min,
        ranged_damage_max = ranged_max,
        ranged_damage_type = ranged_damage_type,
		ranged_damage_icon = s.info.ranged_damage_icon,

        armor = armor,
        magic_armor = magic_armor,
		dodge = dodge,
		dodge_chance = dodge_chance,			
        respawn = ar.spawn_cooldown,
        no_ranged = no_ranged,
		yes_melee = yes_melee
    }
end

function scripts.tower_grim_cemetery.insert(this, store, script)


	this.aura_list = {}
	if this.auras then
		for _, a in pairs(this.auras.list) do
			if a.cooldown == 0 then
				local e = E:create_entity(a.name)

				e.pos = V.vclone(this.pos)
				e.aura.level = this.tower.level
				e.aura.source_id = this.id
				e.aura.ts = store.tick_ts
				e.aura.zombie_count = this.tower_upgrade_persistent_data.zombies_count
				e.aura.zombies = this.tower_upgrade_persistent_data.zombies

				table.insert(this.aura_list, e)
				queue_insert(store, e)
			end
		end
	end

	return true
end

function scripts.tower_grim_cemetery.update(this, store, script)
	local shooter_sid = 3
	local skull_glow_sid = 4
	local skull_fx_sid = 5
	local b = this.barrack
	local a = this.attacks
	local ha = this.attacks.list[1]
	local pow_b = this.powers.big
	local pow_p = this.powers.pestilence
	local pow_h = this.powers.hands
	local t_angle = math.pi * 3 / 2
	local hands_raised = false
	
	local function find_enemy_group(entities, origin, min_range, max_range, pair_range, flags, bans, filter_func)
		local enemies = U.find_enemies_in_range(entities, origin, min_range, max_range, flags, bans, filter_func)

		if not enemies or #enemies == 0 or #enemies < 2 then
			return nil
		else
			table.sort(enemies, function(e1, e2)
				return V.dist(e1.pos.x, e1.pos.y, origin.x, origin.y) < V.dist(e2.pos.x, e2.pos.y, origin.x, origin.y)
			end)
			
			for i = 1, #enemies do
				if enemies[i] and enemies[i + 1] and enemies[i + 2] and U.is_inside_ellipse(enemies[i + 1].pos, enemies[i].pos, pair_range) and U.is_inside_ellipse(enemies[i + 2].pos, enemies[i].pos, pair_range) then
					return enemies[i]
				else
					i = i + 1
				end
			end
			return nil
		end
	end

	while true do
		if this.tower.blocked then

			coroutine.yield()
		else

			if pow_h.changed then
				pow_h.changed = nil
				ha.cooldown = pow_h.cooldown[pow_h.level]

				if pow_h.level == 1 then
					ha.ts = store.tick_ts
				end
			end

			if pow_h.level > 0 and store.tick_ts - ha.ts > ha.cooldown then
				local target = find_enemy_group(store.entities, tpos(this), 0, ha.range, ha.target_range, ha.vis_flags, ha.vis_bans)

				if not target then
					-- block empty
				else
					ha.ts = store.tick_ts
					
					S:queue(ha.sound)

					for i = 1, pow_h.count[pow_h.level] do
						local b = E:create_entity(ha.bullet)
						local btox
						local btoy
						
						btox = target.pos.x + math.random(ha.max_spread * -1, ha.max_spread)
						btoy = target.pos.y + math.random(ha.max_spread * -1, ha.max_spread)
						b.bullet.to = V.v(btox, btoy)
						while not U.is_inside_ellipse(b.bullet.to, P:node_pos(target.nav_path.pi, 1, target.nav_path.ni), ha.max_spread) do
							btox = target.pos.x + math.random(ha.max_spread * -1, ha.max_spread)
							btoy = target.pos.y + math.random(ha.max_spread * -1, ha.max_spread)
							b.bullet.to = V.v(btox, btoy)
							coroutine.yield()
						end
						b.pos.x, b.pos.y = b.bullet.to.x, b.bullet.to.y
						b.bullet.from = V.vclone(b.pos)
						b.bullet.level = pow_h.level
						b.bullet.target_id = target.id
						b.bullet.source_id = this.id
						b.render.sprites[1].ts = store.tick_ts

						queue_insert(store, b)
						
						U.y_wait(store, 0.1)
					end
				end
			end

			coroutine.yield()
		end
	end
end

function scripts.tower_grim_cemetery.remove(this, store)
	--不是升级的情况下，需要移除僵尸；否则升级这些僵尸。
	local aura = this.aura_list[1]
	if not this.tower.upgrade_to then
		if aura.zombies then
			for _, s in pairs(aura.zombies) do
				if s.health then
					s.health.dead = true
				end
				queue_remove(store, s)
			end
		end
	else
		if aura.zombies then
			this.tower_upgrade_persistent_data.zombies = aura.zombies
			this.tower_upgrade_persistent_data.zombies_count = #aura.zombies
		else
			this.tower_upgrade_persistent_data.zombies_count = 0
			this.tower_upgrade_persistent_data.zombies = nil
		end
	end

	return true
end

scripts.grim_cemetery_aura = {}

function scripts.grim_cemetery_aura.remove(this, store, script)
	--[[
	if this.zombies then
		--local source = store.entities[this.aura.source_id]
		--if not source or not source.tower.upgrade_to then
			for _, s in pairs(this.zombies) do
				if s.health then
					s.health.dead = true
				end

				queue_remove(store, s)
			end
		--end
	end
	]]
	
	return true
end

function scripts.grim_cemetery_aura.update(this, store, script)
	local last_ts = store.tick_ts
	local tower_skeletons_count = 0
	local spawn_ts = store.tick_ts
	local spawn_time = nil
	local big = nil
	local pestilence = nil
	local pestilence_ts


	this.zombies = {}

	--需要接管僵尸
	local source = store.entities[this.aura.source_id]
	if source and source.tower_upgrade_persistent_data.zombies_count and source.tower_upgrade_persistent_data.zombies_count > 0 then
		tower_skeletons_count = source.tower_upgrade_persistent_data.zombies_count
		this.zombies = source.tower_upgrade_persistent_data.zombies
		for _, s in pairs(this.zombies) do
			local z = E:get_template(this.entity_small)
			if s.render.sprites[1].prefix == "grim_cemetery_zombie_medium" then
				z = E:get_template(this.entity_medium)
			end
			s.health.hp_max = z.health.hp_max
			s.health.hp = s.health.hp_max
			s.info.portrait = z.info.portrait
			s.melee.attacks[1].cooldown = z.melee.attacks[1].cooldown
			s.melee.attacks[1].damage_max = z.melee.attacks[1].damage_max
			s.melee.attacks[1].damage_min = z.melee.attacks[1].damage_min
			s.render.sprites[1].prefix = z.render.sprites[1].prefix

		end
	end
	
	::label_412_0::

	while true do
		local source = store.entities[this.aura.source_id]

		if not source then
			queue_remove(store, this)

			return
		end
		
		if source.powers.big.changed and not big then
			big = true
			if this.zombies then
				local z = E:get_template("soldier_zombie_big")
				for _, s in pairs(this.zombies) do
					s.health.hp_max = z.health.hp_max
					s.health.hp = s.health.hp_max
					s.info.portrait = z.info.portrait
					s.melee.attacks[1].cooldown = z.melee.attacks[1].cooldown
					s.melee.attacks[1].damage_max = z.melee.attacks[1].damage_max
					s.melee.attacks[1].damage_min = z.melee.attacks[1].damage_min
					s.render.sprites[1].prefix = z.render.sprites[1].prefix
				end
			end
		end
		
		if source.powers.pestilence.changed and not pestilence then
			pestilence = true
			pestilence_ts = store.tick_ts
		end

		if store.tick_ts - last_ts >= this.aura.cycle_time then
			last_ts = store.tick_ts
			tower_skeletons_count = 0

			for _, e in pairs(store.entities) do
				if e and e.health and not e.health.dead and e.soldier and e.soldier.tower_id == source.id then
					tower_skeletons_count = tower_skeletons_count + 1
				end
			end
			
			if store.tick_ts - spawn_ts > this.spawn_cooldown then
				spawn_ts = store.tick_ts
				tower_skeletons_count = tower_skeletons_count + 1
				spawn_time = true
			end

			local max_spawns = this.max_skeletons_tower - tower_skeletons_count

			if max_spawns < 1 then
				-- block empty
			else
				local dead_enemies = table.filter(store.entities, function(k, v)
					return v.enemy and v.vis and v.health and v.health.dead and band(v.health.last_damage_types, bor(DAMAGE_EAT)) == 0 and band(v.vis.bans, F_SKELETON) == 0 and store.tick_ts - v.health.death_ts >= v.health.dead_lifetime - this.aura.cycle_time and U.is_inside_ellipse(v.pos, this.pos, source.attacks.range) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and band(v.vis.flags, bor(F_FLYING,F_CLIFF,F_BOSS))==0
				end)

				dead_enemies = table.slice(dead_enemies, 1, max_spawns)

				for _, dead in pairs(dead_enemies) do
					dead.vis.bans = bor(dead.vis.bans, F_SKELETON)
					dead.health.delete_after = 0

					local e
					
					if source.powers.big.level > 0 then
						e = E:create_entity(this.entity_big)
					else
						if dead.health.hp_max > this.min_health_for_knight then
							e = E:create_entity(this.entity_medium)
						else
							e = E:create_entity(this.entity_small)
						end
					end

					e.pos = V.vclone(dead.pos)

					if dead.enemy.necromancer_offset then
						e.pos.x = e.pos.x + dead.enemy.necromancer_offset.x * (dead.render.sprites[1].flip_x and -1 or 1)
						e.pos.y = e.pos.y + dead.enemy.necromancer_offset.y
					end

					e.nav_rally.center = V.vclone(e.pos)
					e.nav_rally.pos = V.vclone(e.pos)
					e.soldier.tower_id = source.id
					e.owner = this
					e.owner_idx = #this.zombies
					
					if source.powers.pestilence.level > 0 and store.tick_ts - pestilence_ts > this.pestilence_cooldown then
						e.pestilence_active = true
						e.render.sprites[2].hidden = nil
						e.render.sprites[2].ts = store.tick_ts
					end
					
					S:queue(this.spawn_sound)

					queue_insert(store, e)
					table.insert(this.zombies, e)
					
					if source.powers.pestilence.level > 0 and store.tick_ts - pestilence_ts > this.pestilence_cooldown then
						pestilence_ts = store.tick_ts
						local m = E:create_entity(this.pestilence_mod)
				
						m.modifier.level = source.powers.pestilence.level
						m.modifier.target_id = e.id
						m.modifier.source_id = this.id
				
						queue_insert(store, m)
					end
					goto label_412_0
				end
				if spawn_time then
					spawn_time = nil
					local e
					
					if source.powers.big.level > 0 then
						e = E:create_entity(this.entity_big)
					else
						e = E:create_entity(this.entity_small)
					end

					local pos
					
					::label_332_0::
					
					pos = U.point_on_ellipse(this.pos, source.attacks.range / 2, 2 * math.pi * math.random(1, 24) / 24)
					local nodes = P:nearest_nodes(pos.x, pos.y, nil, nil, true)
					
					if #nodes < 1 then
					
					else
						local npi, nspi, nni = unpack(nodes[1])
						nspi = math.random(1, 3)
						local npos = P:node_pos(npi, nspi, nni)
						if not U.is_inside_ellipse(this.pos, npos, source.attacks.range) then
							goto label_332_0
						end
						if not P:is_node_valid(npi, nni, NF_RALLY) then
							goto label_332_0
						end

						e.pos = npos

						e.nav_rally.center = V.vclone(e.pos)
						e.nav_rally.pos = V.vclone(e.pos)
						e.soldier.tower_id = source.id
						e.owner = this
						e.owner_idx = #this.zombies
						
						S:queue(this.spawn_sound)

						queue_insert(store, e)
						table.insert(this.zombies, e)
					end
				end
			end
		end

		coroutine.yield()
	end
end

scripts.soldier_zombie = {}

function scripts.soldier_zombie.update(this, store, script)
	local brk, sta
	
	this.idle_flip.ts = store.tick_ts

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	if this.render.sprites[1].name == "raise" then
		this.health_bar.hidden = true

		U.animation_start(this, "raise", nil, store.tick_ts, 1)

		while not U.animation_finished(this) and not this.health.dead do
			coroutine.yield()
		end

		if not this.health.dead then
			this.health_bar.hidden = nil
		end
	end
	
	local function zombie_idle(store, this, force_ts)
		U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, force_ts)

		if this.unit.is_stunned then
			return
		end

		if store.tick_ts - this.idle_flip.ts > 2 * store.tick_length then
			this.idle_flip.ts_counter = 0
		end

		this.idle_flip.ts = store.tick_ts
		this.idle_flip.ts_counter = this.idle_flip.ts_counter + store.tick_length
		
		if this.idle_flip.ts_counter > this.idle_flip.cooldown then
			this.idle_flip.ts_counter = 0

			local new_pos = V.vclone(this.pos)

			this.idle_flip.last_dir = -1 * this.idle_flip.last_dir
			new_pos.x = new_pos.x + this.idle_flip.last_dir * this.idle_flip.walk_dist

			if not GR:cell_is(new_pos.x, new_pos.y, TERRAIN_WATER) then
				this.nav_rally.new = true
				this.nav_rally.pos = new_pos
			end
		end
	end
	
	local function y_zombie_death(store, this)
		U.unblock_target(store, this)

		local h = this.health

		if band(h.last_damage_types, bor(DAMAGE_DISINTEGRATE, DAMAGE_DISINTEGRATE_BOSS)) ~= 0 then
			this.unit.hide_during_death = true

			local fx = E:create_entity("fx_soldier_desintegrate")

			fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		elseif band(h.last_damage_types, bor(DAMAGE_EAT)) ~= 0 then
			this.unit.hide_during_death = true
		elseif band(h.last_damage_types, bor(DAMAGE_HOST)) ~= 0 then
			S:queue(this.sound_events.death_by_explosion)

			this.unit.hide_during_death = true

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
		elseif this.reinforcement and (this.reinforcement.fade or this.reinforcement.fade_out) then
			SU.y_reinforcement_fade_out(store, this)

			return
		else
			if this.pestilence_active then
				S:queue(this.sound_events.death_xplode, this.sound_events.death_xplode_args)
				U.y_animation_play(this, "bloatedDeath", nil, store.tick_ts, 1)
			else
				S:queue(this.sound_events.death, this.sound_events.death_args)
				U.y_animation_play(this, "death", nil, store.tick_ts, 1)
			end

			this.ui.can_select = false
		end

		if this.ui then
			this.ui.can_click = not this.unit.hide_after_death
			this.ui.z = -1
		end

		if this.unit.hide_during_death or this.unit.hide_after_death then
			for _, s in pairs(this.render.sprites) do
				s.hidden = true
			end
		end
	end

	while true do
		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					SU.soldier_power_upgrade(this, pn)
				end
			end
		end

		if this.cloak then
			this.vis.flags = band(this.vis.flags, bnot(this.cloak.flags))
			this.vis.bans = band(this.vis.bans, bnot(this.cloak.bans))
			this.render.sprites[1].alpha = 255
		end

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			y_zombie_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else

			if this.dodge and this.dodge.active then
				this.dodge.active = false

				if this.dodge.counter_attack and this.powers[this.dodge.counter_attack.power_name].level > 0 then
					this.dodge.counter_attack_pending = true
				elseif this.dodge.animation then
					U.animation_start(this, this.dodge.animation, nil, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end
				end

				signal.emit("soldier-dodge", this)
			end

			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_39_1
				end
			end

			if this.timed_actions then
				brk, sta = SU.y_soldier_timed_actions(store, this)

				if brk then
					goto label_39_1
				end
			end

			if this.timed_attacks then
				brk, sta = SU.y_soldier_timed_attacks(store, this)

				if brk then
					goto label_39_1
				end
			end

			if this.ranged and this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					goto label_39_1
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_39_1
				end
			end

			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk or sta == A_DONE then
					goto label_39_1
				elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
					goto label_39_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_39_1
			end

			::label_39_0::

			zombie_idle(store, this)

			if this.cloak then
				this.vis.flags = bor(this.vis.flags, this.cloak.flags)
				this.vis.bans = bor(this.vis.bans, this.cloak.bans)

				if this.cloak.alpha then
					this.render.sprites[1].alpha = this.cloak.alpha
				end
			end

			SU.soldier_regen(store, this)
		end

		::label_39_1::

		coroutine.yield()
	end
end

scripts.aura_grim_cemetery_hand = {}

function scripts.aura_grim_cemetery_hand.insert(this, store, script)
	this.aura.ts = store.tick_ts

	if this.render then
		for _, s in pairs(this.render.sprites) do
			s.ts = store.tick_ts
		end
		
		local rid = math.random(1, 2)
		if rid == 2 then
			this.render.sprites[1].prefix = "fallen_ones_grim_cemetery_hand2"
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

function scripts.aura_grim_cemetery_hand.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0
	

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
	
	U.y_animation_play(this, "in", nil, store.tick_ts, 1)
	
	while not U.animation_finished(this) do
		coroutine.yield()
	end

	while true do
		U.animation_start(this, "run", nil, store.tick_ts, true)
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
				goto label_89_0
			end

			if this.render then
				this.render.sprites[1].hidden = not te.enemy.can_do_magic
			end

			if not te.enemy.can_do_magic then
				goto label_89_0
			end
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_89_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.health and te.health.dead then
				goto label_89_0
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

		::label_89_0::

		coroutine.yield()
	end

	U.y_animation_play(this, "out", nil, store.tick_ts, 1)
	while not U.animation_finished(this) do
		coroutine.yield()
	end
	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end

scripts.mod_grim_cemetery_explode = {}

function scripts.mod_grim_cemetery_explode.remove(this, store)
	local count_soldiers, count_enemies = 0, 0
	local target = store.entities[this.modifier.target_id]

	if this.modifier.removed_by_ban then
		return true
	end

	if not target then
		return true
	end

	if not target.health.dead then
		target.vis.flags = band(target.vis.flags, bnot(F_DARK_ELF))
	else
		local targets = table.filter(store.entities, function(k, v)
			return not v.pending_removal and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.explode_vis_bans) == 0 and band(v.vis.bans, this.explode_vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.explode_range) and not table.contains(this.explode_excluded_templates, v.template_name)
		end)

		if targets and #targets > 0 then
			local count = 0
			for _, target in pairs(targets) do
				if count < this.explode_max_targets then
					count = count + 1
					local is_enemy = band(target.vis.flags, F_ENEMY) ~= 0
					local d = E:create_entity("damage")

					d.damage_type = is_enemy and this.explode_damage_type
					d.value = this.explode_damage[this.modifier.level]
					d.source_id = this.id
					d.target_id = target.id

					queue_damage(store, d)
				
					local m = E:create_entity(this.explode_mod)
				
					m.modifier.level = this.modifier.level
					m.modifier.target_id = target.id
					m.modifier.source_id = this.id
				
					queue_insert(store, m)

					if is_enemy then
						count_enemies = count_enemies + 1
					else
						count_soldiers = count_soldiers + 1
					end
				end
			end
		end

		local p

		if U.flag_has(target.vis.flags, F_FLYING) then
			p = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
		else
			p = V.v(target.pos.x, target.pos.y)
		end

		SU.insert_sprite(store, this.explode_fx, p)
	end

	return true
end

function scripts.mod_grim_cemetery_explode.update(this, store, script)
	local m = this.modifier

	this.modifier.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos then
		U.y_wait(store, this.explode_delay)
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
			U.y_wait(store, this.explode_delay)
			queue_remove(store, this)

			return
		end

		if this.render and target.unit then
			local s = this.render.sprites[1]
			local flip_sign = 1

			if target.render then
				flip_sign = target.render.sprites[1].flip_x and -1 or 1
			end

			if m.health_bar_offset and target.health_bar then
				local hb = target.health_bar.offset
				local hbo = m.health_bar_offset

				s.offset.x, s.offset.y = hb.x + hbo.x * flip_sign, hb.y + hbo.y
			elseif m.use_mod_offset and target.unit.mod_offset then
				s.offset.x, s.offset.y = target.unit.mod_offset.x * flip_sign, target.unit.mod_offset.y
			end
		end

		coroutine.yield()
	end
end

scripts.lava_fissure_cemetery = {}

function scripts.lava_fissure_cemetery.update(this, store, script)
	local b = this.bullet
	local ps
	local s = this.render.sprites[1]

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	while store.tick_ts - b.ts + store.tick_length <= b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.rotation_speed then
			s.r = s.r + b.rotation_speed * store.tick_length
		else
			s.r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)

			if b.asymmetrical and math.abs(s.r) > math.pi / 2 then
				s.flip_y = true
			end
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end

		if b.hide_radius then
			s.hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius

			if ps then
				ps.particle_system.emit = not s.hidden
			end
		end
	end

	local hit = false
	local target = store.entities[b.target_id]

	if target and target.health and not target.health.dead then
		local target_pos = V.vclone(target.pos)

		if target.unit and target.unit.hit_offset and not b.ignore_hit_offset then
			target_pos.x, target_pos.y = target_pos.x + target.unit.hit_offset.x, target_pos.y + target.unit.hit_offset.y
		end

		if V.dist(this.pos.x, this.pos.y, target_pos.x, target_pos.y) < b.hit_distance and not SU.unit_dodges(store, target, true) and (not b.hit_chance or math.random() < b.hit_chance) then
			hit = true

			local d = SU.create_bullet_damage(b, target.id, this.id)

			queue_damage(store, d)

			if b.mod then
				local mods = type(b.mod) == "table" and b.mod or {
					b.mod
				}

				for _, mod_name in pairs(mods) do
					local mod = E:create_entity(mod_name)

					mod.modifier.source_id = this.id
					mod.modifier.target_id = target.id
					mod.modifier.level = b.level
					mod.modifier.source_damage = d

					queue_insert(store, mod)
				end
			end

			if b.hit_fx then
				local fx = E:create_entity(b.hit_fx)

				fx.pos = V.vclone(target_pos)
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.hit_blood_fx and target.unit.blood_color ~= BLOOD_NONE then
				local sfx = E:create_entity(b.hit_blood_fx)

				sfx.pos = V.vclone(target_pos)
				sfx.render.sprites[1].ts = store.tick_ts

				if sfx.use_blood_color and target.unit.blood_color then
					sfx.render.sprites[1].name = target.unit.blood_color
					sfx.render.sprites[1].r = s.r
				end

				queue_insert(store, sfx)
			end
		end
	end

	if not hit then
		if GR:cell_is(this.pos.x, this.pos.y, TERRAIN_WATER) then
			if b.miss_fx_water then
				local water_fx = E:create_entity(b.miss_fx_water)

				water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
				water_fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, water_fx)
			end
		else
			if b.miss_fx then
				local fx = E:create_entity(b.miss_fx)

				fx.pos.x, fx.pos.y = b.to.x, b.to.y
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.miss_decal then
				local decal = E:create_entity("decal_tween")

				decal.pos = V.vclone(b.to)
				decal.tween.props[1].keys = {
					{
						0,
						255
					},
					{
						2.1,
						0
					}
				}
				decal.render.sprites[1].ts = store.tick_ts
				decal.render.sprites[1].name = b.miss_decal
				decal.render.sprites[1].animated = false
				decal.render.sprites[1].z = Z_DECALS

				if b.rotation_speed then
					decal.render.sprites[1].flip_x = b.rotation_speed > 0
				else
					decal.render.sprites[1].r = -math.pi / 2 * (1 + (0.5 - math.random()) * 0.35)
				end

				if b.miss_decal_anchor then
					decal.render.sprites[1].anchor = b.miss_decal_anchor
				end

				queue_insert(store, decal)
			end
		end
	end

	if b.payload then
		local p = E:create_entity(b.payload)

		p.pos.x, p.pos.y = b.to.x, b.to.y
		p.target_id = b.target_id
		p.source_id = this.id

		if p.aura then
			p.aura.level = b.level
			p.aura.damage_min = b.admin[b.level]
			p.aura.damage_max = b.admax[b.level]
			if b.aura_duration then
				p.aura.duration = b.aura_duration[b.level]
			end
		end

		queue_insert(store, p)
	end
	
	if b.hit_decal then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if ps and ps.particle_system.emit then
		s.hidden = true
		ps.particle_system.emit = false

		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end


return scripts