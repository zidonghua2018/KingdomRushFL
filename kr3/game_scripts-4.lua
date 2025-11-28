-- chunkname: @./kr1/game_scripts.lua

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
local SU = require("script_utils_4")
local U = require("utils_4")
local LU = require("level_utils")
local UP = require("upgrades")
local V = require("klua.vector")
local W = require("wave_db")
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot

require("i18n")

local scripts = require("scripts")

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

local IS_PHONE = KR_TARGET == "phone"
local IS_CONSOLE = KR_TARGET == "console"

local function tpos(e)
	return e.tower and e.tower.range_offset and V.v(e.pos.x + e.tower.range_offset.x, e.pos.y + e.tower.range_offset.y) or e.pos
end

scripts.tower_shadow_archer = {}

function scripts.tower_shadow_archer.get_info(this)
	local a = this.attacks.list[1]
	local b = E:get_template("arrow_shadow_tower")
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
	local pow_s = this.powers.blade
	local pow_m = this.powers.mark
	local pow_c = this.powers.crow
	local sid = 3
	this.crows = {}

	local function y_do_shot(attack, enemy, level)
		S:queue(attack.sound, attack.sound_args)

		local soffset = this.render.sprites[sid].offset
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
		as.cooldown = as.cooldowns[pow_s.level]
			if pow_m.changed then
					pow_m.changed = nil

					if pow_m.level == 1 then
						am.ts = store.tick_ts
					end
				end
				if pow_s.changed then
					pow_s.changed = nil

					if pow_s.level == 1 then
						as.ts = store.tick_ts
					end
				end
			if pow_c.changed then
				pow_c.changed = nil
			end
			if pow_c.level > 0 then
				this.render.sprites[4].name = "tower_shadow_archer_nest_0001"
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
			
			if pow_s.level > 0 and store.tick_ts - as.ts > as.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, as.vis_flags, as.vis_bans, function(e)
					return not U.has_modifiers(store, e, "mod_arrow_shadow_mark")
				end)
				if enemy then
					as.ts = store.tick_ts
					SU.stun_inc(enemy)
					y_do_shot(as, enemy, pow_s.level)
				end
			end

			if pow_m.level > 0 and store.tick_ts - am.ts > am.cooldown then
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

scripts.blade_demise = {}

function scripts.blade_demise.update(this, store, script)
	local b = this.bullet
	local target = store.entities[b.target_id]
	
	local fx = E:create_entity(b.hit_fx)

	if not target.render.sprites[1].flip_x then
	fx.pos.x, fx.pos.y = b.to.x - 30, b.to.y - target.unit.hit_offset.y
	else
	fx.pos.x, fx.pos.y = b.to.x + 30, b.to.y - target.unit.hit_offset.y
	fx.render.sprites[1].flip_x = true
	end
	fx.render.sprites[1].ts = store.tick_ts

	queue_insert(store, fx)

	if not target or target.health.dead then
		queue_remove(store, this)

		return
	end

	local no = P:predict_enemy_node_advance(target, b.flight_time)
	local pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + no)

	while store.tick_ts - fx.render.sprites[1].ts < this.hit_time do
		coroutine.yield()
	end

	local d = E:create_entity("damage")

	d.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_NOT_EXPLODE)
	d.source_id = this.id
	d.target_id = target.id
	d.pop = b.pop
	d.pop_conds = b.pop_conds
	d.pop_chance = b.pop_chance

	queue_damage(store, d)

	queue_remove(store, this)
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

scripts.tower_orc_warriors_den = {}

function scripts.tower_orc_warriors_den.get_info(this)
	local s = E:get_template("soldier_orc_warrior")
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
	local orcs = E:get_template("soldier_orc_warrior")
	local capped = nil
	local blooded = nil
	local blooded2 = nil
	local pow_p = this.powers.promotion
	local pow_b = this.powers.bloodlust

	while true do
		local b = this.barrack
		local cap = this.barrack.soldiers[1]

		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil
					if p == pow_p then
						cap.health.hp = pow_p.hp_max
					end

					for _, s in pairs(b.soldiers) do
						s.powers[pn].level = p.level
						s.powers[pn].changed = true
					end
				end
			end
		end
		
		if pow_p.level > 0 and not capped then
			cap.render.sprites[1].prefix = "soldier_orc_captain"
			cap.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0009") or "krv_portraits_0009"
			cap.regen.health = pow_p.regen
			cap.melee.attacks[1].damage_min = pow_p.damage_min
			cap.melee.attacks[1].damage_max = pow_p.damage_max
			cap.health.hp_max = pow_p.hp_max
			cap.health.armor = pow_p.armor
			
			if pow_b.level > 0 then
				cap.melee.attacks[1].damage_min = math.ceil(pow_p.damage_min * pow_b.damage_factor[pow_b.level])
				cap.melee.attacks[1].damage_max = math.ceil(pow_p.damage_max * pow_b.damage_factor[pow_b.level])
			end
			
			capped = true
		end
		
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
						s.render.sprites[1].prefix = "soldier_orc_captain"
						s.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0009") or "krv_portraits_0009"
						s.regen.health = pow_p.regen
						s.melee.attacks[1].damage_min = pow_p.damage_min
						s.melee.attacks[1].damage_max = pow_p.damage_max
						s.health.hp_max = pow_p.hp_max
						s.health.armor = pow_p.armor
					end
					
					if pow_b.level > 0 then
						s.melee.attacks[1].damage_min = math.floor(s.melee.attacks[1].damage_min * pow_b.damage_factor[pow_b.level])
						s.melee.attacks[1].damage_max = math.ceil(s.melee.attacks[1].damage_max * pow_b.damage_factor[pow_b.level])
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
	local sold = E:get_template("soldier_orc_warrior")
	local tow = E:get_template("tower_orc_warriors_den")
	local pow_p = tow.powers.promotion
	local pow_b = tow.powers.bloodlust
	
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
							if this.render.sprites[1].prefix == "soldier_orc_captain" then
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
						end
				end
			end
		end
		
		if this.powers.bloodlust.level > 0 then
			this.render.sprites[2].hidden = false
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
	local pow_d = this.powers.fissure
	local pow_t = this.powers.teleport
	local pow_c = this.powers.curse
	local last_ts = store.tick_ts

	ar.ts = store.tick_ts
	ar.range = a.range
	
	this.render.sprites[6].ts = store.tick_ts
	this.render.sprites[7].ts = store.tick_ts + fts(15)
	this.render.sprites[8].ts = store.tick_ts + fts(30)

	local aura = E:get_template(at.aura)
	local aura2 = E:get_template(ac.aura2)
	local max_times_applied = E:get_template(aura.aura.mod).max_times_applied
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
		local target, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans, function(e)
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
			for k, pow in pairs(this.powers) do
				if pow.changed then
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

						if aa == at then
							this.render.sprites[teleport_sid].ts = last_ts
						end
						
						if aa == ac then
							this.render.sprites[curse_sid].ts = last_ts
						end

						U.y_wait(store, aa.shoot_time)

						enemy, pred_pos = find_target(aa)

						if not enemy then
							-- block empty
						else
							aa.ts = last_ts

							local b
							local u = UP:get_upgrade("mage_spell_of_penetration")

							if aa == at then
								b = E:create_entity(aa.aura)
								b.pos.x, b.pos.y = pred_pos.x, pred_pos.y
								b.aura.target_id = enemy.id
								b.aura.source_id = this.id
								b.aura.max_count = pow_t.max_count[pow_t.level]
								b.aura.level = pow_t.level
							else
								if aa == ac then
								b = E:create_entity(aa.aura)
								b.pos.x, b.pos.y = pred_pos.x, pred_pos.y
								b.aura.target_id = enemy.id
								b.aura.source_id = this.id
								b.aura.level = pow_c.level
							else
								if aa == ad then
									local bft = 0
									for i = 1, ad.loops do
										local b = E:create_entity(ad.bullet)
										local btox
										local btoy

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
							else
								b = E:create_entity(aa.bullet)
								b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.vclone(enemy.pos)
								b.bullet.target_id = enemy.id
								b.bullet.source_id = this.id
								b.bullet.level = pow_d.level
								if u and math.random() < u.chance then
									b.bullet.damage_factor = b.bullet.damage_factor * u.damage_factor
									b.bullet.pop = {
									"pop_crit_wild_magus"
								}
								b.bullet.pop_conds = DR_DAMAGE
							end
								end
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
		local decal = E:create_entity("decal_arcane_burst_ground")

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
	local a = this.attacks
	local ab = this.attacks.list[1]
	local am = this.attacks.list[2]
	local ac = this.attacks.list[3]
	local an = this.attacks.list[4]
	local pow_m = this.powers.mine
	local pow_c = this.powers.engine
	local pow_n = this.powers.nitro
	local last_ts = store.tick_ts
	this.boxes = {}

	ab.ts = store.tick_ts

	local aa, pow
	local attacks = {
		am,
		ac,
		an,
		ab
	}
	local pows = {
		pow_m,
		pow_c,
		pow_n
	}

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

						U.animation_start(this, aa.animation, nil, store.tick_ts, false, tower_sid)
						U.y_wait(store, aa.shoot_time)

						local enemy, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						local dest = enemy and pred_pos or trigger_pos

						if V.dist(tpos(this).x, tpos(this).y, dest.x, dest.y) <= aa.range then
							local b = E:create_entity(aa.bullet)
							local flip = dest.x > this.pos.x
							
							b.render.sprites[1].flip_y = not flip

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

			U.animation_start(this, "idle", nil, store.tick_ts, false, tower_sid)
			coroutine.yield()
		end
	end
end

scripts.mine_box = {}

function scripts.mine_box.update(this, store)
	local a = this.attacks.list[1]

	a.ts = store.tick_ts
	
	while true do
		if this.owner.tower.blocked or not this.owner.tower.can_do_magic then
			-- block empty
		elseam.ts = store.tick_ts
				elseif store.tick_ts - a.ts > a.cooldown then
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
		bf.bullet.damage_min = this.bullet.damage_inc[this.bullet.level]
		bf.bullet.damage_max = this.bullet.damage_inc[this.bullet.level]

		queue_insert(store, bf)
	end

	queue_remove(store, this)
end

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
				this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
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
						this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
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

function scripts.tower_melting_furnace.update(this, store, script)
	local a = this.attacks
	local aa = this.attacks.list[1]
	local la = this.attacks.list[2]
	local da = this.attacks.list[3]
	local ea = this.attacks.list[4]
	local fa = this.attacks.list[5]
	local pow_d = this.powers.coal
	local pow_e = this.powers.heat
	local pow_f = this.powers.fuel
	local lava_ready = false
	local drill_ready = false
	local std_ready = false
	local anim_id = 3

	aa.ts = store.tick_ts

	::label_86_0::

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if pow_e.changed then
				pow_e.changed = nil

				if pow_e.level == 1 then
					ea.ts = store.tick_ts
				end
			end

			if pow_e.level > 0 then
				if store.tick_ts - ea.ts > ea.cooldown then
					ea.ts = store.tick_ts

					local eagle_range = ea.range + ea.range_inc * pow_e.level
					local eagle_offrange = ea.offrange
					local existing_mods = table.filter(store.entities, function(_, e)
						return e.modifier and e.template_name == ea.mod and e.modifier.level >= pow_e.level
					end)
					local busy_ids = table.map(existing_mods, function(k, v)
						return v.modifier.target_id
					end)
					local towers = table.filter(store.entities, function(_, e)
						return e.tower and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(ea.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, eagle_range) and not U.is_inside_ellipse(e.pos, this.pos, eagle_offrange)
					end)

					for _, tower in pairs(towers) do
						local new_mod = E:create_entity(ea.mod)

						new_mod.modifier.level = pow_e.level
						new_mod.modifier.target_id = tower.id
						new_mod.modifier.source_id = this.id
						new_mod.pos = tower.pos

						queue_insert(store, new_mod)
					end
				end
			end
			
			if pow_f.changed then
				pow_f.changed = nil

				if pow_f.level == 1 then
					fa.ts = store.tick_ts
				end
			end
			
			if pow_f.level > 0 then
				local trigger_range = (lava_ready and 0.9 or 1) * a.range + 5
				local trigger_enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, trigger_range, false, aa.vis_flags, aa.vis_bans)
					if not trigger_enemy then
						-- block empty
					else
				if store.tick_ts - fa.ts > fa.cooldown then
					fa.ts = store.tick_ts
					S:queue("MeltingFurnaceBurningFuel")
					U.animation_start(this, "fuel", nil, store.tick_ts, 1, anim_id)
					this.attacks.list[1].animation = "fuel_shoot"
					this.attacks.list[1].sound = "MeltingFurnaceAttackFuel"
					this.attacks.list[1].cooldown = 2
					this.attacks.list[1].hit_time = 0.267
					da.disabled = true
					this.idle_anim = "fuel_idle"
					while store.tick_ts - fa.ts < la.hit_time do
					coroutine.yield()
					end
					local eagle_range = fa.range
					local existing_mods = table.filter(store.entities, function(_, e)
						return e.modifier and e.template_name == fa.mod and e.modifier.level >= pow_f.level
					end)
					local busy_ids = table.map(existing_mods, function(k, v)
						return v.modifier.target_id
					end)
					local towers = table.filter(store.entities, function(_, e)
						return e.tower and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(fa.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, eagle_range)
					end)

					for _, tower in pairs(towers) do
						local new_mod = E:create_entity(fa.mod)

						new_mod.modifier.level = pow_f.level
						new_mod.modifier.target_id = tower.id
						new_mod.modifier.source_id = this.id
						new_mod.pos = tower.pos

						queue_insert(store, new_mod)
					end
				end
			end
			end
			
			if pow_d.changed then
				pow_d.changed = nil

				if pow_d.level == 1 then
					da.ts = store.tick_ts
				end
			end

			if pow_d.level > 0 and store.tick_ts - da.ts > da.cooldown then
				drill_ready = true
			end

			if store.tick_ts - aa.ts > aa.cooldown then

				std_ready = true
			end

			if not drill_ready and not lava_ready and not std_ready then
				coroutine.yield()
			else
				if drill_ready and not da.disabled then
					local trigger, enemies, trigger_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, da.node_prediction, da.vis_flags, da.vis_bans)

					if not trigger then
						-- block empty
					else
						drill_ready = false
						da.ts = store.tick_ts

						S:queue(da.sound)
						U.animation_start(this, "coal", nil, store.tick_ts, 1, anim_id)

						while store.tick_ts - da.ts < da.hit_time do
							coroutine.yield()
						end

						local enemy, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, da.node_prediction, da.vis_flags, da.vis_bans)
						local dest = enemy and pred_pos or trigger_pos

						if V.dist(tpos(this).x, tpos(this).y, dest.x, dest.y) <= a.range then
							local b = E:create_entity(da.bullet)

							b.pos.x, b.pos.y = this.pos.x + da.bullet_start_offset.x, this.pos.y + da.bullet_start_offset.y
							b.bullet.damage_factor = this.tower.damage_factor
							b.bullet.from = V.vclone(b.pos)
								b.bullet.to = dest
									b.bullet.fragment_count = pow_d.fragment_count_base + pow_d.fragment_count_inc * pow_d.level

							b.bullet.target_id = enemy and enemy.id or trigger.id
							b.bullet.source_id = this.id
							b.bullet.level = pow_d.level
							b.owner = this

							queue_insert(store, b)
						end

						while not U.animation_finished(this, anim_id) do
							coroutine.yield()
						end

						goto label_86_0
					end
				end

				local trigger_range = (lava_ready and 0.9 or 1) * a.range
				local trigger_enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, trigger_range, false, aa.vis_flags, aa.vis_bans)

				if std_ready and trigger_enemy then
					aa.ts = store.tick_ts

					if lava_ready then
						la.ts = store.tick_ts
					end
					S:queue(aa.sound)
					U.animation_start(this, aa.animation, nil, store.tick_ts, 1, anim_id)

					while store.tick_ts - aa.ts < aa.hit_time do
						coroutine.yield()
					end

					local enemies = table.filter(store.entities, function(k, v)
						return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, aa.damage_bans) == 0 and band(v.vis.bans, aa.damage_flags) == 0 and U.is_inside_ellipse(v.pos, tpos(this), a.range)
					end)

					for _, enemy in pairs(enemies) do
						local d = E:create_entity("damage")

						d.source_id = this.id
						d.target_id = enemy.id
						d.damage_type = aa.damage_type
						d.value = math.random(aa.damage_min, aa.damage_max)
						d.value = math.ceil(this.tower.damage_factor * d.value)
						d.reduce_armor = aa.reduce_armor

						queue_damage(store, d)

						if aa.mod then
							local mod = E:create_entity(aa.mod)

							mod.modifier.target_id = enemy.id

							queue_insert(store, mod)
						end
					end

					for i = 1, #this.fx_points do
						local p = this.fx_points[i]

						if lava_ready then
							local lava = E:create_entity(la.bullet)

							lava.pos.x, lava.pos.y = p.pos.x, p.pos.y
							lava.aura.ts = store.tick_ts
							lava.aura.source_id = this.id

							queue_insert(store, lava)
						end

						if band(p.terrain, TERRAIN_WATER) ~= 0 then
							local smoke = E:create_entity("decal_dwaarp_smoke_water")

							smoke.pos.x, smoke.pos.y = p.pos.x, p.pos.y
							smoke.render.sprites[1].ts = store.tick_ts + math.random() * 5 / FPS

							queue_insert(store, smoke)

							if lava_ready then
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
								{
									0,
									255
								},
								{
									1,
									255
								},
								{
									2.5,
									0
								}
							}
							decal.tween.props[1].name = "alpha"

							if math.random() < 0.5 then
								decal.render.sprites[1].name = "EarthquakeTower_HitDecal1"
							else
								decal.render.sprites[1].name = "EarthquakeTower_HitDecal2"
							end

							decal.render.sprites[1].animated = false
							decal.render.sprites[1].z = Z_DECALS
							decal.render.sprites[1].ts = store.tick_ts

							queue_insert(store, decal)

							local smoke = E:create_entity("decal_dwaarp_smoke")

							smoke.pos.x, smoke.pos.y = p.pos.x, p.pos.y
							smoke.render.sprites[1].ts = store.tick_ts + math.random() * 5 / FPS

							queue_insert(store, smoke)

							if lava_ready then
								local scorch = E:create_entity("decal_dwaarp_scorched")

								if math.random() < 0.5 then
									scorch.render.sprites[1].name = "EarthquakeTower_Lava2"
								end

								scorch.pos.x, scorch.pos.y = p.pos.x, p.pos.y
								scorch.render.sprites[1].ts = store.tick_ts

								queue_insert(store, scorch)
							end
						end
					end

					if lava_ready then
						local tower_scorch = E:create_entity("decal_dwaarp_tower_scorched")

						tower_scorch.pos.x, tower_scorch.pos.y = this.pos.x, this.pos.y + 10
						tower_scorch.render.sprites[1].ts = store.tick_ts

						queue_insert(store, tower_scorch)
					end

					local pulse = E:create_entity("decal_dwaarp_pulse")

					pulse.pos.x, pulse.pos.y = this.pos.x, this.pos.y + 16
					pulse.render.sprites[1].ts = store.tick_ts

					queue_insert(store, pulse)

					if lava_ready then
						S:queue(la.sound)
					end

					while not U.animation_finished(this, anim_id) do
						coroutine.yield()
					end

					std_ready = false
					lava_ready = false
					this.render.sprites[4].hidden = true
					this.render.sprites[5].hidden = true
				end

				U.animation_start(this, this.idle_anim, nil, store.tick_ts, -1, anim_id)
				coroutine.yield()
			end
		end
	end
end

scripts.furnace_coal = {}

function scripts.furnace_coal.insert(this, store)
	local b = this.bullet
	local dest = V.vclone(b.to)
	local target = store.entities[b.target_id]
	local nearest_nodes = P:nearest_nodes(b.to.x, b.to.y, target and {
		target.nav_path.pi
	} or nil)

	if #nearest_nodes > 0 then
		local pi, spi, ni = unpack(nearest_nodes[1])

		this._pred_pi, this._pred_ni = pi, ni
		dest = P:node_pos(pi, 1, ni)
	end

	b.to.x, b.to.y = this.owner.pos.x + 75, this.owner.pos.y + 75

	return scripts.bomb.insert(this, store)
end

function scripts.furnace_coal.update(this, store)
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

		if pi and ni then
			bf_dest = P:node_pos(pi, 1, ni + ni_offset - i * b.fragment_node_spread)
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

scripts.mod_furnace_fuel = {}

function scripts.mod_furnace_fuel.update(this, store, script)

	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert mod_furnace_fuel to entity %s - ", target.id, target.template_name)

		return false
	end
	m.ts = store.tick_ts
		target.attacks.list[1].animation = "fuel_shoot"
		target.attacks.list[1].sound = "MeltingFurnaceAttackFuel"
		target.attacks.list[1].cooldown = this.cooldown
		target.attacks.list[1].hit_time = 0.267
		target.attacks.list[1].damage_min = this.damage_min
		target.attacks.list[1].damage_max = this.damage_max
		target.attacks.list[3].disabled = true
		target.idle_anim = "fuel_idle"

	signal.emit("mod-applied", this, target)
	
	while store.tick_ts - m.ts < m.duration do
		coroutine.yield()
	end
	queue_remove(store, this)
end

function scripts.mod_furnace_fuel.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local fur = E:get_template("tower_melting_furnace")

	if target and target.attacks then
		target.attacks.list[1].ts = 0
		target.attacks.list[1].damage_min = fur.attacks.list[1].damage_min
		target.attacks.list[1].damage_max = fur.attacks.list[1].damage_max
		target.attacks.list[1].cooldown = fur.attacks.list[1].cooldown
		target.attacks.list[1].hit_time = 1.83
		target.attacks.list[1].animation = "shoot"
		target.attacks.list[1].sound = "MeltingFurnaceAttack"
		target.idle_anim = "idle"
			if target.powers.coal.level > 0 then
		target.attacks.list[3].disabled = false
	end
	end

	return true
end

scripts.mod_furnace_buff = {}

function scripts.mod_furnace_buff.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert mod_furnace_buff to entity %s - ", target.id, target.template_name)

		return false
	end

	if target.attacks or target.template_name == "tower_mech" then
		target.tower.damage_factor = target.tower.damage_factor + this.extra_damage * m.level
	end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_furnace_buff.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and (target.attacks or target.template_name == "tower_mech") then
		target.tower.damage_factor = target.tower.damage_factor - this.extra_damage * m.level
	end

	return true
end

scripts.tower_spectres_mausoleum = {}

function scripts.tower_spectres_mausoleum.insert(this, store, script)
	this._last_t_angle = math.pi * 3 / 2
	this._stored_bullets = {}

	return true
end

function scripts.tower_spectres_mausoleum.remove(this, store, script)
	for _, b in pairs(this._stored_bullets) do
		queue_remove(store, b)
	end
	
	for _, b in pairs(this.barrack.soldiers) do
		queue_remove(store, b)
	end

	return true
end

function scripts.tower_spectres_mausoleum.update(this, store, script)
	local tower_sid = 2
	local shooter_sid = 3
	local pos_sid = 6
	local glow_sid = 7
	local s_tower = this.render.sprites[tower_sid]
	local s_shooter = this.render.sprites[shooter_sid]
	local a = this.attacks
	local ba = this.attacks.list[1]
	local ta = this.attacks.list[2]
	local pow_b = this.powers.poss
	local pow_t = this.powers.garg
	local pow_s = this.powers.spectral
	local formation_offset = -0.4
	local soldier_added = false
	local bar = this.barrack
	local gargnum = 1

	ba.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			if #this._stored_bullets then
				for _, b in pairs(this._stored_bullets) do
					queue_remove(store, b)
				end

				this._stored_bullets = {}
			end

			coroutine.yield()
		else
			if pow_t.changed then
					pow_t.changed = nil
					this.barrack.max_soldiers = pow_t.level
			end
			soldier_added = false
			for i = 1, bar.max_soldiers do
				local s = bar.soldiers[i]
				if not s or s.health.dead and not store.entities[s.id] then

					s = E:create_entity(bar.soldier_type)
					s.soldier.tower_id = this
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, bar, bar.max_soldiers, formation_offset)
					if gargnum == 1 then
					s.pos = V.v(this.pos.x - 4, this.pos.y - 6)
					else
					if gargnum == 2 then
					s.pos = V.v(this.pos.x + 33, this.pos.y + 8)
					else
					s.pos = V.vclone(s.nav_rally.pos)
					end
					end
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
			
			if pow_t.level == 1 then
			this.render.sprites[4].name = "soldier_gargoyle_0045"
			gargnum = 2
			end
			
			if pow_t.level == 2 then
			this.render.sprites[4].name = "soldier_gargoyle_0045"
			this.render.sprites[5].name = "soldier_gargoyle_0045"
			gargnum = 0
			end
			
			if pow_s.changed then
			pow_s.changed = nil
			ba.max_stored_bullets = pow_s.max_bullets[pow_s.level]
			end
			
			if pow_b.changed then
			pow_b.changed = nil
			ta.ts = store.tick_ts
			ta.cooldown = ta.cooldown + ta.cooldown_inc
			end
			
			if pow_b.level > 0 and store.tick_ts - ta.ts > ta.cooldown then
				local target

				target = U.find_enemies_in_range(store.entities, tpos(this), 0, ta.range, ta.vis_flags, ta.vis_bans)

				if not target then
					-- block empty
				else
					table.sort(target, function(e1, e2)
						return e1.health.hp > e2.health.hp
					end)
					local targets = {}
					local first_target = target[1]
					table.insert(targets, first_target)
					
					ta.ts = store.tick_ts

					local t_angle

					if first_target then
						local tx, ty = V.sub(first_target.pos.x, first_target.pos.y, this.pos.x, this.pos.y + s_tower.offset.y)

						t_angle = km.unroll(V.angleTo(tx, ty))
						this._last_t_angle = t_angle
					else
						t_angle = this._last_t_angle
					end
					
					local an, _, ai = U.animation_name_for_angle(this, ta.animation, t_angle, pos_sid)
					
					S:queue(ta.sound)
					U.animation_start(this, an, nil, store.tick_ts, 1, pos_sid)

					while store.tick_ts - ta.ts < ta.shoot_time do
						coroutine.yield()
					end
						local start_offset = ta.bullet_start_offset[ai]
						local b = E:create_entity(ta.bullet)

						b.bullet.damage_factor = this.tower.damage_factor
						b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
						b.pos = V.vclone(b.bullet.from)
							b.bullet.target_id = first_target.id
							b.bullet.to = V.v(first_target.pos.x + first_target.unit.hit_offset.x, first_target.pos.y + first_target.unit.hit_offset.y)
						local flip = b.bullet.to.x > this.pos.x
							
							b.render.sprites[1].flip_x = not flip

						queue_insert(store, b)
				end
			end

			if store.tick_ts - ba.ts > ba.cooldown then
				local target

				target = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, ba.vis_flags, ba.vis_bans)

				if not target and (not ba.max_stored_bullets or ba.max_stored_bullets == #this._stored_bullets) then
					-- block empty
				else
					ba.ts = store.tick_ts

					local t_angle

					if target then
						local tx, ty = V.sub(target.pos.x, target.pos.y, this.pos.x, this.pos.y + s_tower.offset.y)

						t_angle = km.unroll(V.angleTo(tx, ty))
						this._last_t_angle = t_angle
					else
						t_angle = this._last_t_angle
					end
					
					local an, _, ai = U.animation_name_for_angle(this, ba.animation, t_angle, shooter_sid)

					if not target or #this._stored_bullets == 0 then
					S:queue(ba.sound)
					U.animation_start(this, "shoot", nil, store.tick_ts, 1, glow_sid)
					U.animation_start(this, an, nil, store.tick_ts, 1, shooter_sid)
					end

					while store.tick_ts - ba.ts < ba.shoot_time do
						coroutine.yield()
					end

					if target and #this._stored_bullets > 0 then
						for _, b in pairs(this._stored_bullets) do
							b.bullet.target_id = target.id
							b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
						end

						this._stored_bullets = {}
					else
						local start_offset = ba.bullet_start_offset[ai]
						local b = E:create_entity(ba.bullet)
						local u = UP:get_upgrade("mage_spell_of_penetration")

						b.bullet.damage_factor = this.tower.damage_factor
						b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
						b.pos = V.vclone(b.bullet.from)

						if target then
							b.bullet.target_id = target.id
							b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
						else
							b.bullet.target_id = nil
							b.bullet.store = true
							if u and math.random() < u.chance then
									b.bullet.damage_factor = b.bullet.damage_factor * u.damage_factor
									b.bullet.pop = {
									"pop_crit_high_elven"
								}
								b.bullet.pop_conds = DR_DAMAGE
							end

							local off = ba.storage_offsets[#this._stored_bullets + 1]

							b.bullet.to = V.v(this.pos.x + off.x, this.pos.y + off.y)

							table.insert(this._stored_bullets, b)
						end

						queue_insert(store, b)
					end
				end
			end

			local an = U.animation_name_for_angle(this, "idle", this._last_t_angle, shooter_sid)

			U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)

			coroutine.yield()
		end
	end
end

scripts.mod_possession = {}

function scripts.mod_possession.update(this, store)
	local function add_fx(target, pos)
		local fx = E:create_entity(this.fx)
		local s = fx.render.sprites[1]

		s.ts = store.tick_ts

		if s.size_scales then
			s.scale = s.size_scales[target.unit.size]
		end

		fx.pos = V.vclone(pos)

		if target.unit.hit_offset then
			fx.pos.x, fx.pos.y = fx.pos.x + target.unit.hit_offset.x, fx.pos.y + target.unit.hit_offset.y
		end

		queue_insert(store, fx)
	end

	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or target.health.dead or band(target.vis.bans, F_RAGGIFY) ~= 0 then
		queue_remove(store, this)

		return
	end

	target.vis.bans = U.flag_set(target.vis.bans, F_RAGGIFY)

	add_fx(target, target.pos)
	SU.remove_modifiers(store, target, nil, "mod_possession")
	SU.remove_auras(store, target)
	queue_remove(store, target)

	target.health.dead = true
	target.main_script.co = nil
	target.main_script.runs = 0

	U.unblock_all(store, target)

	if target.ui then
		target.ui.can_click = false
	end

	if target.count_group then
		target.count_group.in_limbo = true
	end

	local e = E:create_entity(this.entity_name)
	local nodes = P:nearest_nodes(target.pos.x, target.pos.y, {
			target.nav_path.pi
		}, nil)

		if #nodes > 0 then
			e.nav_path.ni = nodes[1][3] - 5
		end
	
	e.pos = V.vclone(target.pos)
	e.health.hp_max = target.health.hp_max
	e.health.hp = target.health.hp
	if target.health.immune_to then
	e.health.immune_to = target.health.immune_to
	end
	e.render.sprites[1].anchor.y = target.render.sprites[1].anchor.y
	e.render.sprites[1].anchor.x = target.render.sprites[1].anchor.x
	e.render.sprites[1].flip_x = target.render.sprites[1].flip_x
	e.render.sprites[1].offset = target.render.sprites[1].offset
	e.render.sprites[1].scale = target.render.sprites[1].scale
	e.lifespan.duration = this.doll_duration
	e.render.sprites[1].flip_x = target.render.sprites[1].flip_x
	e.nav_path.pi = target.nav_path.pi
	e.nav_path.spi = target.nav_path.spi
	e.health.armor = target.health.armor
	if target.render.sprites[1].prefix == "enemy_shaman" then
	e.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
	e.timed_attacks.list[1].animation = target.timed_attacks.list[1].animation
	e.timed_attacks.list[1].cast_time = target.timed_attacks.list[1].cast_time
	e.timed_attacks.list[1].cooldown = target.timed_attacks.list[1].cooldown
	e.timed_attacks.list[1].max_count = target.timed_attacks.list[1].max_count
	e.timed_attacks.list[1].max_range = target.timed_attacks.list[1].max_range
	e.timed_attacks.list[1].mod = target.timed_attacks.list[1].mod
	e.timed_attacks.list[1].sound = target.timed_attacks.list[1].sound
	e.timed_attacks.list[1].vis_flags = target.timed_attacks.list[1].vis_flags
	e.timed_attacks.list[1].disabled = false
	end
	if target.render.sprites[1].prefix == "enemy_cursed_shaman" then
	e.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
	e.timed_attacks.list[1].animation = target.timed_attacks.list[1].animation
	e.timed_attacks.list[1].cast_time = target.timed_attacks.list[1].cast_time
	e.timed_attacks.list[1].cooldown = target.timed_attacks.list[1].cooldown
	e.timed_attacks.list[1].max_count = target.timed_attacks.list[1].max_count
	e.timed_attacks.list[1].max_range = target.timed_attacks.list[1].max_range
	e.timed_attacks.list[1].mod = target.timed_attacks.list[1].mod
	e.timed_attacks.list[1].sound = target.timed_attacks.list[1].sound
	e.timed_attacks.list[1].vis_flags = target.timed_attacks.list[1].vis_flags
	e.timed_attacks.list[1].disabled = false
	end
	if target.render.sprites[1].prefix == "enemy_troll_chieftain" then
	e.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
	e.timed_attacks.list[1].animation = target.timed_attacks.list[1].animation
	e.timed_attacks.list[1].cooldown = target.timed_attacks.list[1].cooldown
	e.timed_attacks.list[1].cast_sound = target.timed_attacks.list[1].cast_sound
	e.timed_attacks.list[1].cast_time = target.timed_attacks.list[1].cast_time
	e.timed_attacks.list[1].loops = target.timed_attacks.list[1].loops
	e.timed_attacks.list[1].max_count = target.timed_attacks.list[1].max_count
	e.timed_attacks.list[1].max_range = target.timed_attacks.list[1].max_range
	e.timed_attacks.list[1].mods = target.timed_attacks.list[1].mods
	e.timed_attacks.list[1].exclude_with_mods = target.timed_attacks.list[1].exclude_with_mods
	e.timed_attacks.list[1].vis_flags = target.timed_attacks.list[1].vis_flags
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].name = target.auras.list[1].name
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	e.timed_attacks.list[1].disabled = false
	end
	if target.render.sprites[1].prefix == "enemy_troll" then
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].name = target.auras.list[1].name
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	end
	if target.render.sprites[1].prefix == "enemy_troll_skater" then
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].name = target.auras.list[1].name
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	end
	if target.render.sprites[1].prefix == "enemy_troll_brute" then
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].name = target.auras.list[1].name
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	end
	if target.render.sprites[1].prefix == "enemy_troll_axe_thrower" then
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	e.auras.list[1].name = target.auras.list[1].name
	end
	if target.render.sprites[1].prefix == "enemy_demon" then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_demon_death_pos"
	e.death_spawns.delay = target.death_spawns.delay
	end
	if target.render.sprites[1].prefix == "enemy_forest_troll" then
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].name = target.auras.list[1].name
	e.auras.list[1].cooldown =  target.auras.list[1].cooldown
	end
	if target.render.sprites[1].prefix == "enemy_demon_mage" then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_demon_mage_death_pos"
	e.death_spawns.delay = 0.11
	e.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
	e.timed_attacks.list[1].animation = target.timed_attacks.list[1].animation
	e.timed_attacks.list[1].cast_time = target.timed_attacks.list[1].cast_time
	e.timed_attacks.list[1].cooldown = target.timed_attacks.list[1].cooldown
	e.timed_attacks.list[1].max_count = target.timed_attacks.list[1].max_count
	e.timed_attacks.list[1].max_range = target.timed_attacks.list[1].max_range
	e.timed_attacks.list[1].mod = target.timed_attacks.list[1].mod
	e.timed_attacks.list[1].sound = target.timed_attacks.list[1].sound
	e.timed_attacks.list[1].vis_flags = target.timed_attacks.list[1].vis_flags
	e.timed_attacks.list[1].disabled = false
	end
	if target.render.sprites[1].prefix == "enemy_demon_wolf" then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_demon_wolf_death_pos"
	e.death_spawns.delay = target.death_spawns.delay
	end
	if target.render.sprites[1].prefix == "enemy_rotten_lesser" then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_rotten_lesser_death_pos"
	end
	if target.render.sprites[1].prefix == "enemy_fallen_knight" then
	e.death_spawns.name = "soldier_spectral_knight_pos"
	e.death_spawns.spawn_animation = "raise"
	e.death_spawns.delay = target.death_spawns.delay
	end
	if target.render.sprites[1].prefix == "enemy_spectral_knight" then
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	e.auras.list[1].name = "aura_spectral_knight_pos"
	end
	if target.render.sprites[1].prefix == "enemy_lycan_werewolf" then
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].name = "aura_lycan_regen_pos"
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	end
	if target.render.sprites[1].prefix == "enemy_demon_legion" then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_demon_death_pos"
	end
	if target.render.sprites[1].prefix == "enemy_demon_flareon" then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_flareon_death_pos"
	end
	if target.render.sprites[1].prefix == "enemy_demon_gulaemon" then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_gulaemon_death_pos"
	end
	if target.render.sprites[1].prefix == "enemy_abomination" then
	e.death_spawns.name = "abomination_explosion_aura_pos"
	e.death_spawns.concurrent_with_death = true
	end
	if target.render.sprites[1].prefix == "enemy_spider" and store.level_difficulty == 4 then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.quantity = target.death_spawns.quantity
	e.death_spawns.name = "soldier_spider_small_pos"
	e.death_spawns.delay = target.death_spawns.delay
	e.death_spawns.spread_nodes = target.death_spawns.spread_nodes
	e.death_spawns.offset = target.death_spawns.offset
	end
	if target.render.sprites[1].prefix == "enemy_sarelgaz_small" and store.level_difficulty == 4 then
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.quantity = target.death_spawns.quantity
	e.death_spawns.name = "soldier_spider_big_pos"
	e.death_spawns.delay = target.death_spawns.delay
	e.death_spawns.spread_nodes = target.death_spawns.spread_nodes
	e.death_spawns.offset = target.death_spawns.offset
	end
	if target.render.sprites[1].prefix == "enemy_cursed_golem" then
	if store.level_difficulty == 1 then
	e.death_spawns.name = "soldier_cursed_shard_pos_1"
	elseif store.level_difficulty == 2 then
	e.death_spawns.name = "soldier_cursed_shard_pos_2"
	elseif store.level_difficulty == 3 then
	e.death_spawns.name = "soldier_cursed_shard_pos_3"
	elseif store.level_difficulty == 4 then
	e.death_spawns.name = "soldier_cursed_shard_pos_4"
	end
	e.death_spawns.quantity = target.death_spawns.quantity
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.delay = target.death_spawns.delay
	e.death_spawns.spread_nodes = target.death_spawns.spread_nodes
	e.death_spawns.offset = target.death_spawns.offset
	end
	if target.render.sprites[1].prefix == "enemy_orc_rider" then
	if store.level_difficulty == 1 then
	e.death_spawns.name = "soldier_orc_armored_pos_1"
	elseif store.level_difficulty == 2 then
	e.death_spawns.name = "soldier_orc_armored_pos_2"
	elseif store.level_difficulty == 3 then
	e.death_spawns.name = "soldier_orc_armored_pos_3"
	elseif store.level_difficulty == 4 then
	e.death_spawns.name = "soldier_orc_armored_pos_4"
	end
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.delay = target.death_spawns.delay
	end
	if target.render.sprites[1].prefix == "enemy_hobgoblin_rider" then
	if store.level_difficulty == 1 then
	e.death_spawns.name = "soldier_hobgoblin_pos_1"
	elseif store.level_difficulty == 2 then
	e.death_spawns.name = "soldier_hobgoblin_pos_2"
	elseif store.level_difficulty == 3 then
	e.death_spawns.name = "soldier_hobgoblin_pos_3"
	elseif store.level_difficulty == 4 then
	e.death_spawns.name = "soldier_hobgoblin_pos_4"
	end
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.delay = target.death_spawns.delay
	end
	if target.render.sprites[1].prefix == "enemy_necromancer" then
	e.timed_attacks.list[2].animation = target.timed_attacks.list[1].animation
	e.timed_attacks.list[2].cooldown = target.timed_attacks.list[1].cooldown
	e.timed_attacks.list[2].cast_time = target.timed_attacks.list[1].cast_time
	e.timed_attacks.list[2].entity2 = "soldier_skeleton_knight_pos"
	e.timed_attacks.list[2].entity = "soldier_skeleton_pos"
	e.timed_attacks.list[2].sound = nil
	e.timed_attacks.list[2].sound_args = {
		delay = fts(5)
	}
	e.timed_attacks.list[2].nodes_offset = {
		4,
		8
	}
	e.timed_attacks.list[2].count = target.timed_attacks.list[1].max_count
	end
	if target.melee then
	if target.melee.attacks[1].damage_radius then
	e.melee.attacks[2].hit_decal = target.melee.attacks[1].hit_decal
	e.melee.attacks[2].hit_fx = target.melee.attacks[1].hit_fx
	e.melee.attacks[2].count = target.melee.attacks[1].count
	e.melee.attacks[2].damage_radius = target.melee.attacks[1].damage_radius
	e.melee.attacks[2].damage_max = target.melee.attacks[1].damage_max
	e.melee.attacks[2].damage_min = target.melee.attacks[1].damage_min
	e.melee.attacks[2].hit_time = target.melee.attacks[1].hit_time
	e.melee.attacks[2].vis_bans = target.melee.attacks[1].vis_bans
	e.melee.attacks[2].vis_flags = target.melee.attacks[1].vis_flags
	e.melee.attacks[2].cooldown = target.melee.attacks[1].cooldown
	e.melee.attacks[2].damage_type = target.melee.attacks[1].damage_type
	e.melee.attacks[2].hit_offset = target.melee.attacks[1].hit_offset
	e.melee.attacks[2].mod = target.melee.attacks[1].mod
	else
	e.melee.attacks[1].damage_max = target.melee.attacks[1].damage_max
	e.melee.attacks[1].damage_min = target.melee.attacks[1].damage_min
	e.melee.attacks[1].hit_time = target.melee.attacks[1].hit_time
	e.melee.attacks[1].vis_bans = target.melee.attacks[1].vis_bans
	e.melee.attacks[1].vis_flags = target.melee.attacks[1].vis_flags
	e.melee.attacks[1].cooldown = target.melee.attacks[1].cooldown
	e.melee.attacks[1].damage_type = target.melee.attacks[1].damage_type
	e.melee.attacks[1].hit_offset = target.melee.attacks[1].hit_offset
	e.melee.attacks[1].mod = target.melee.attacks[1].mod
	e.melee.cooldown = target.melee.attacks[1].cooldown
	end
	end
	if target.dodge then
	e.dodge.chance = target.dodge.chance
	end
	e.motion.max_speed = target.motion.max_speed
	e.vis.bans = target.vis.bans
	e.info.i18n_key = target.info.i18n_key
	e.info.portrait = target.info.portrait
	e.health_bar.type = target.health_bar.type
	e.health_bar.offset = target.health_bar.offset
	e.health.magic_armor = target.health.magic_armor
	e.render.sprites[1].prefix = target.render.sprites[1].prefix
	e.soldier.melee_slot_offset = target.enemy.melee_slot
	e.unit.hit_offset = target.unit.hit_offset
	e.unit.mod_offset = target.unit.mod_offset
	e.ui.click_rect = target.ui.click_rect
	e.unit.blood_color = target.unit.blood_color
	e.unit.marker_offset = target.unit.marker_offset
	e.ui.click_rect.size = target.ui.click_rect.size
	e.ui.click_rect.pos = target.ui.click_rect.pos
	e.unit.can_explode = target.unit.can_explode
	e.unit.size = target.unit.size
	if target.unit.size == UNIT_SIZE_MEDIUM or target.unit.size == UNIT_SIZE_LARGE then
	e.render.sprites[2].scale = v(1, 1)
	e.render.sprites[2].offset = v(-3, 20)
	end
	if target.ranged then
	if target.ranged.attacks[1].hold_advance then
	e.ranged.attacks[1].hold_advance = true
	end
	e.ranged.attacks[1].bullet = target.ranged.attacks[1].bullet
	e.ranged.attacks[1].shoot_time = target.ranged.attacks[1].shoot_time
	e.ranged.attacks[1].cooldown = target.ranged.attacks[1].cooldown
	e.ranged.attacks[1].max_range = target.ranged.attacks[1].max_range
	e.ranged.attacks[1].min_range = target.ranged.attacks[1].min_range
	e.ranged.attacks[1].animation = target.ranged.attacks[1].animation
	e.ranged.attacks[1].bullet_start_offset = target.ranged.attacks[1].bullet_start_offset
	e.ranged.attacks[1].vis_flags = target.ranged.attacks[1].vis_flags
	e.ranged.attacks[1].vis_bans = target.ranged.attacks[1].vis_bans
	end
	if target.render.sprites[1].prefix == "enemy_goblin_zapper" then
	e.ranged.attacks[1].bullet = "bomb_goblin_zapper_pos"
	e.death_spawns.concurrent_with_death = true
	e.death_spawns.name = "aura_goblin_zapper_death_pos"
	e.death_spawns.delay = target.death_spawns.delay
	end
	if target.render.sprites[1].prefix == "enemy_swamp_thing" then
	e.ranged.attacks[1].bullet = "bomb_swamp_thing_pos"
	e.auras.list[1] = E.clone_c(E, "aura_attack")
	e.auras.list[1].name = "aura_swamp_thing_regen"
	e.auras.list[1].cooldown = target.auras.list[1].cooldown
	end
	if target.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
	e.health.armor = 0.3
	end

	queue_insert(store, e)

	local start_ts = store.tick_ts

	while not e.health.dead do
		coroutine.yield()
	end

	if e.lifespan.hp_before_timeout then
		local nodes = P:nearest_nodes(e.pos.x, e.pos.y, {
			target.nav_path.pi
		}, nil)

		if #nodes > 0 then
			target.nav_path.ni = nodes[1][3] + 1
		end

		target.pos = V.vclone(e.pos)
		target.main_script.runs = 1
		target.health.dead = false
		target.health.hp = e.lifespan.hp_before_timeout
		if target.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
		target.health.raw_armor = nil
		target.health.armor = 0.3
		end

		if target.ui then
			target.ui.can_click = true
		end

		if target.count_group then
			target.count_group.in_limbo = nil
		end

		target.vis.bans = U.flag_clear(target.vis.bans, F_RAGGIFY)

		queue_insert(store, target)
	else
		store.player_gold = store.player_gold + target.enemy.gold

		signal.emit("got-enemy-gold", target, target.enemy.gold)
	end

	add_fx(target, e.pos)
	queue_remove(store, this)
end

scripts.soldier_possessed = {}

function scripts.soldier_possessed.get_info(this)
	local t = scripts.soldier_reinforcement.get_info(this)
	local aoe = this.melee.attacks[2]

	if aoe.cooldown < 900000 then
	t.damage_min = aoe.damage_min
	t.damage_max = aoe.damage_max
	end

	return t
end

function scripts.soldier_possessed.on_damage(this, store, damage)
	log.debug(" SOLDIER_POSSESSED DAMAGE:%s type:%x", damage.value, damage.damage_type)
	local ca = this.dodge
	local target = store.entities[this.soldier.target_id]

	if not target or target.health.dead or not this.dodge or this.unit.is_stunned or this.health.dead or store.tick_ts - ca.ts < ca.cooldown or band(damage.damage_type, DAMAGE_ALL_TYPES, bnot(bor(DAMAGE_PHYSICAL, DAMAGE_MAGICAL))) ~= 0 or band(damage.damage_type, DAMAGE_NO_DODGE) ~= 0 or this.powers[this.dodge.power_name].level < 1 then
		return true
	end

	log.debug("(%s)soldier_possessed dodged damage %s of type %s", this.id, damage.value, damage.damage_type)

	this.dodge.active = true

	return false
end

function scripts.soldier_possessed.insert(this, store, script)
	this.melee.order = U.attack_order(this.melee.attacks)
	this.health.hp_max = this.health.hp_max + this.health.hp_inc * this.unit.level
	
	if this.auras then
		for _, a in pairs(this.auras.list) do
			if a.cooldown == 0 then
				local e = E:create_entity(a.name)

				e.pos = V.vclone(this.pos)
				e.aura.level = this.unit.level
				e.aura.source_id = this.id
				e.aura.ts = store.tick_ts

				queue_insert(store, e)
			end
		end
	end

	local node_offset = math.random(3, 6)

	this.nav_path.ni = this.nav_path.ni + node_offset
	this.pos = P:node_pos(this.nav_path.pi, this.nav_path.spi, this.nav_path.ni)

	if not this.pos then
		return false
	end

	return true
end

function scripts.soldier_possessed.update(this, store, script)
	local attack = this.melee.attacks[1]
	local target
	local expired = false
	local next_pos = V.vclone(this.pos)
	local brk, sta, star, nearest
	local ta = this.timed_attacks.list[1]
	local tac = this.timed_attacks.list[2]
	local orc = 0
	local spider = 0
	local coward = false
	local coward_ts = 0
	local shield = false
	
	if this.render.sprites[1].prefix == "enemy_fallen_knight" or this.render.sprites[1].prefix == "enemy_orc_rider" or this.render.sprites[1].prefix == "enemy_hobgoblin_rider"  then
	orc = 1
	end
	
	if (this.render.sprites[1].prefix == "enemy_spider" or this.render.sprites[1].prefix == "enemy_sarelgaz_small") and store.level_difficulty == 4 then
	spider = 1
	end
	
	if this.render.sprites[1].prefix == "enemy_cursed_golem" then
	spider = 1
	end
	
	tac.ts = store.tick_ts
	ta.ts = store.tick_ts

	this.lifespan.ts = store.tick_ts

	local function enable_shield()
		if not shield then
			shield = true

			SU.armor_inc(this, 0.7)
		end
	end

	local function disable_shield()
		if shield then
			shield = false

			SU.armor_dec(this, 0.7)
		end
	end
	
	local function do_death_spawns_orc(store, this)
	if this.death_spawns.fx then
		local fx = E:create_entity(this.death_spawns.fx)

		fx.pos = V.vclone(this.pos)
		fx.render.sprites[1].ts = store.tick_ts

		if this.death_spawns.fx_flip_to_source and this.render and this.render.sprites[1] then
			fx.render.sprites[1].flip_x = this.render.sprites[1].flip_x
		end

		queue_insert(store, fx)
	end

	for i = 1, this.death_spawns.quantity do
		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)
		local pi, spi, ni = unpack(nodes[1])
					local no
						local e_spi, e_ni = math.random(1, 3), ni

						no = 0

						if P:is_node_valid(pi, e_ni + no) then
							e_ni = e_ni + no
						end
		local s = E:create_entity(this.death_spawns.name)

		s.pos = V.vclone(this.pos)
		s.nav_rally.center = P:node_pos(this.nav_path.pi, this.nav_path.spi, this.nav_path.ni)
		s.nav_rally.pos = V.vclone(s.nav_rally.center)
		s.pos = V.vclone(s.nav_rally.center)
		s.owner = this

		if this.death_spawns.spawn_animation and s.render then
			s.render.sprites[1].name = this.death_spawns.spawn_animation
		end

		if s.render and s.render.sprites[1] and this.render and this.render.sprites[1] then
			s.render.sprites[1].flip_x = this.render.sprites[1].flip_x
		end

		if s.nav_path then
			s.nav_path.pi = this.nav_path.pi

			local spread_nodes = this.death_spawns.spread_nodes

			if spread_nodes > 0 then
				s.nav_path.spi = km.zmod(this.nav_path.spi + i, 3)

				local node_offset = spread_nodes * -2 * math.floor(i / 3)

				s.nav_path.ni = this.nav_path.ni + node_offset + spread_nodes
			else
				s.nav_path.spi = this.nav_path.spi
				s.nav_path.ni = this.nav_path.ni + 2
			end
		end

		if this.death_spawns.offset then
			s.pos.x = s.pos.x + this.death_spawns.offset.x
			s.pos.y = s.pos.y + this.death_spawns.offset.y
		end

		queue_insert(store, s)
	end
	end
	
	local function do_death_spawns_spider(store, this)
	if this.death_spawns.fx then
		local fx = E:create_entity(this.death_spawns.fx)

		fx.pos = V.vclone(this.pos)
		fx.render.sprites[1].ts = store.tick_ts

		if this.death_spawns.fx_flip_to_source and this.render and this.render.sprites[1] then
			fx.render.sprites[1].flip_x = this.render.sprites[1].flip_x
		end

		queue_insert(store, fx)
	end

		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)
		local pi, spi, ni = unpack(nodes[1])
					local no
						local e_spi, e_ni = math.random(1, 3), ni

						no = 0

						if P:is_node_valid(pi, e_ni + no) then
							e_ni = e_ni + no
						end
		for i = 1, this.death_spawns.quantity do
		local s = E:create_entity(this.death_spawns.name)

		s.pos = V.vclone(this.pos)
		if i == 1 then
		s.nav_rally.center = P:node_pos(this.nav_path.pi, 1, this.nav_path.ni + 1)
		elseif i == 4 then
		s.nav_rally.center = P:node_pos(this.nav_path.pi, 1, this.nav_path.ni - 1)
		else
		s.nav_rally.center = P:node_pos(this.nav_path.pi, i, this.nav_path.ni)
		end
		s.nav_rally.pos = V.vclone(s.nav_rally.center)
		s.pos = V.vclone(s.nav_rally.center)
		s.owner = this

		if this.death_spawns.spawn_animation and s.render then
			s.render.sprites[1].name = this.death_spawns.spawn_animation
		end

		if s.render and s.render.sprites[1] and this.render and this.render.sprites[1] then
			s.render.sprites[1].flip_x = this.render.sprites[1].flip_x
		end
		
		if this.death_spawns.offset then
			s.pos.x = s.pos.x + this.death_spawns.offset.x + i
			s.pos.y = s.pos.y + this.death_spawns.offset.y + i
		end

		queue_insert(store, s)
		end
	end
	
	::label_10224_0::

	while true do
		if this.health.dead then
					this.health.hp = 0

			U.animation_start(this, "death", store.tick_ts, -1)
			local can_spawn = this.death_spawns and band(this.health.last_damage_types, bor(DAMAGE_EAT, DAMAGE_NO_SPAWNS, this.death_spawns.no_spawn_damage_types or 0)) == 0
			
				if orc == 1 then
					do_death_spawns_orc(store, this)
					coroutine.yield()

					can_spawn = false
				end
				
				if spider == 1 then
					do_death_spawns_spider(store, this)
					coroutine.yield()

					can_spawn = false
				end

				if orc == 0 and can_spawn and this.death_spawns.concurrent_with_death then
					SU.do_death_spawns(store, this)
					coroutine.yield()

					can_spawn = false
				end
			SU.y_soldier_death(store, this)
			queue_remove(store, this)
			return
				end
		if store.tick_ts - this.lifespan.ts > this.lifespan.duration or not next_pos then
		if this.health.hp > 0 then
				this.lifespan.hp_before_timeout = this.health.hp
			end
			this.health.hp = 0

			queue_remove(store, this)

			return
		end

		if this.unit.is_stunned then
			if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
			disable_shield()
			end
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
		else
			if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
			enable_shield()
			end
			if U.get_blocked(store, this) then
			if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
				disable_shield()
				end
			end
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
				this.nav_rally.center = this.pos
				this.nav_rally.pos = this.pos
			
			if this.render.sprites[1].prefix == "enemy_shaman" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
						local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return e.health.hp < e.health.hp_max
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
						return e.health.hp < e.health.hp_max
					end)

					if targets then
						local healed_count = 0

						for _, target in ipairs(targets) do
							if healed_count >= ta.max_count then
								break
							end

							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)

							healed_count = healed_count + 1
						end
					end

					U.y_animation_wait(this)
				end
					end
					
				if this.render.sprites[1].prefix == "enemy_cursed_shaman" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return not e.render.sprites[1].prefix == "enemy_cursed_shaman"
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
						return not e.render.sprites[1].prefix == "enemy_cursed_shaman"
					end)

					if targets then
						local healed_count = 0

						for _, target in ipairs(targets) do
							if healed_count >= ta.max_count then
								break
							end
							
							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)
							healed_count = healed_count + 1
						if not U.has_modifiers(store, target, "mod_cursed_shield") then
							local b = E:create_entity(ta.mod2)

							b.modifier.source_id = this.id
							b.modifier.target_id = target.id

							queue_insert(store, b)
							end
						end
					end

					U.y_animation_wait(this)
				end
			end
					
			if this.render.sprites[1].prefix == "enemy_demon_mage" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
			return (e.render.sprites[1].prefix == "enemy_demon" or e.render.sprites[1].prefix == "enemy_demon_wolf" or e.render.sprites[1].prefix == "enemy_demon_flareon" or e.render.sprites[1].prefix == "enemy_demon_legion" or e.render.sprites[1].prefix == "enemy_demon_gulaemon" or e.render.sprites[1].prefix == "enemy_rotten_lesser")
		end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					if SU.y_enemy_wait(store, this, ta.cast_time) then
						goto label_10224_0
					end

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
			return (e.render.sprites[1].prefix == "enemy_demon" or e.render.sprites[1].prefix == "enemy_demon_wolf" or e.render.sprites[1].prefix == "enemy_demon_flareon" or e.render.sprites[1].prefix == "enemy_demon_legion" or e.render.sprites[1].prefix == "enemy_demon_gulaemon" or e.render.sprites[1].prefix == "enemy_rotten_lesser")
		end)

					if targets then
						local shielded_count = 0

						for _, target in ipairs(targets) do
							if shielded_count >= ta.max_count then
								break
							end

							shielded_count = shielded_count + 1

							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)
						end
					end

					if SU.y_enemy_animation_wait(this) then
						goto label_10224_0
					end
				end
			end
			
			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
				disable_shield()
				end
			else
				if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
				enable_shield()
				end
				nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
					this.nav_path.pi
				}, {
					this.nav_path.spi
				})

				if nearest and nearest[1] and nearest[1][3] < this.nav_path.ni then
					this.nav_path.ni = nearest[1][3]
				end

				while next_pos and not target and not this.health.dead and not expired and not this.unit.is_stunned do
					U.set_destination(this, next_pos)

					local an, af = U.animation_name_facing_point(this, "walkingRightLeft", this.motion.dest)

					U.animation_start(this, an, af, store.tick_ts, -1)
					U.walk(this, store.tick_length)
					coroutine.yield()
					
					if this.render.sprites[1].prefix == "enemy_shaman" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
						local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return e.health.hp < e.health.hp_max
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
						return e.health.hp < e.health.hp_max
					end)

					if targets then
						local healed_count = 0

						for _, target in ipairs(targets) do
							if healed_count >= ta.max_count then
								break
							end

							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)

							healed_count = healed_count + 1
						end
					end

					U.y_animation_wait(this)
				end
					end
					
					if this.render.sprites[1].prefix == "enemy_cursed_shaman" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return not (e.render.sprites[1].prefix == "enemy_cursed_shaman")
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
						return not (e.render.sprites[1].prefix == "enemy_cursed_shaman")
					end)

					if targets then
						local healed_count = 0

						for _, target in ipairs(targets) do
							if healed_count >= ta.max_count then
								break
							end
							
							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)
							healed_count = healed_count + 1
						if not U.has_modifiers(store, target, "mod_cursed_shield") then
							local b = E:create_entity("mod_cursed_shield")

							b.modifier.source_id = this.id
							b.modifier.target_id = target.id

							queue_insert(store, b)
							end
						end
					end

					U.y_animation_wait(this)
				end
			end
					
					if not U.get_blocked(store, this) and this.render.sprites[1].prefix == "enemy_troll_chieftain" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
			return (e.render.sprites[1].prefix == "enemy_troll" or e.render.sprites[1].prefix == "enemy_troll_axe_thrower" or e.render.sprites[1].prefix == "enemy_troll_brute" or e.render.sprites[1].prefix == "enemy_troll_skater") and not U.has_modifier_in_list(store, e, ta.exclude_with_mods) and not U.has_modifier_types(store, e, MOD_TYPE_SLOW)
		end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					for i = 1, ta.loops do
						U.animation_start(this, ta.animation, nil, store.tick_ts, false)

						if SU.y_enemy_wait(store, this, ta.cast_time) then
							goto label_10224_0
						end

						S:queue(ta.cast_sound)
						local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
			return (e.render.sprites[1].prefix == "enemy_troll" or e.render.sprites[1].prefix == "enemy_troll_axe_thrower" or e.render.sprites[1].prefix == "enemy_troll_brute" or e.render.sprites[1].prefix == "enemy_troll_skater") and not U.has_modifier_in_list(store, e, ta.exclude_with_mods) and not U.has_modifier_types(store, e, MOD_TYPE_SLOW)
		end)

		if targets then
			local raged_count = 0

			for _, target in ipairs(targets) do
				if raged_count >= ta.max_count then
					break
				end

				raged_count = raged_count + 1

				for _, name in pairs(ta.mods) do
					local m = E:create_entity(name)

					m.modifier.source_id = this.id
					m.modifier.target_id = target.id

					queue_insert(store, m)
				end
			end
		end
						U.y_animation_wait(this)
					end
				end
			end
			
			if this.render.sprites[1].prefix == "enemy_demon_mage" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
			return (e.render.sprites[1].prefix == "enemy_demon" or e.render.sprites[1].prefix == "enemy_demon_wolf" or e.render.sprites[1].prefix == "enemy_demon_flareon" or e.render.sprites[1].prefix == "enemy_demon_legion" or e.render.sprites[1].prefix == "enemy_demon_gulaemon" or e.render.sprites[1].prefix == "enemy_rotten_lesser")
		end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					if SU.y_enemy_wait(store, this, ta.cast_time) then
						goto label_10224_0
					end

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
			return (e.render.sprites[1].prefix == "enemy_demon" or e.render.sprites[1].prefix == "enemy_demon_wolf" or e.render.sprites[1].prefix == "enemy_demon_flareon" or e.render.sprites[1].prefix == "enemy_demon_legion" or e.render.sprites[1].prefix == "enemy_demon_gulaemon" or e.render.sprites[1].prefix == "enemy_rotten_lesser")
		end)

					if targets then
						local shielded_count = 0

						for _, target in ipairs(targets) do
							if shielded_count >= ta.max_count then
								break
							end

							shielded_count = shielded_count + 1

							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)
						end
					end

					if SU.y_enemy_animation_wait(this) then
						goto label_10224_0
					end
				end
			end
			
			if not U.get_blocked(store, this) and this.render.sprites[1].prefix == "enemy_necromancer" and this.timed_attacks and store.tick_ts - tac.ts > tac.cooldown then
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, tac, 0.4)
				else
					U.animation_start(this, tac.animation, nil, store.tick_ts, 1)
					S:queue(tac.sound, tac.sound_args)

					if SU.y_enemy_wait(store, this, tac.cast_time) then
						goto label_10224_0
					end

					tac.ts = store.tick_ts

					local pi, spi, ni = unpack(nodes[1])
					local no_min, no_max = unpack(tac.nodes_offset)
					local no

					for i = 1, tac.count do
						local e
						if math.random() < 0.05 then
						e = E:create_entity(tac.entity2)
						else
						e = E:create_entity(tac.entity)
						end
						local e_spi, e_ni = math.random(1, 3), ni

						no = math.random(no_min, no_max) * U.random_sign()

						if P:is_node_valid(pi, e_ni + no) then
							e_ni = e_ni + no
						end

						e.nav_rally.center = P:node_pos(pi, e_spi, e_ni)
						e.nav_rally.pos = V.vclone(e.nav_rally.center)
						e.pos = V.vclone(e.nav_rally.center)
						e.render.sprites[1].name = "raise"
						e.owner = this

						queue_insert(store, e)
					end

					SU.y_enemy_animation_wait(this)

					goto label_10224_0
				end
			end
					
					if this.ranged then
						brk, star = SU.y_soldier_ranged_attacks(store, this)
						
						if brk or star == A_DONE then
						elseif star == A_IN_COOLDOWN then
						end
					end

					target = U.find_foremost_enemy(store.entities, this.pos, 0, this.melee.range, false, attack.vis_flags, attack.vis_bans)
					expired = store.tick_ts - this.lifespan.ts > this.lifespan.duration
					next_pos = P:next_entity_node(this, store.tick_length)

					if not next_pos or not P:is_node_valid(this.nav_path.pi, this.nav_path.ni) or GR:cell_is(next_pos.x, next_pos.y, bor(TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK)) then
						next_pos = nil
					end
				end

				target = nil
			end
		end

		if false then
			-- block empty
		end

		coroutine.yield()
	end
end

scripts.tower_goblirang = {}

function scripts.tower_goblirang.update(this, store)
	local shooter_sids = {
		3,
		4
	}
	local shooter_idx = 2
	local a = this.attacks
	local aa = this.attacks.list[1]
	local ab = this.attacks.list[2]
	local ah = this.attacks.list[3]
	local pow_p = this.powers.stun
	local pow_b = this.powers.big
	local pow_t = this.powers.bees

	aa.ts = store.tick_ts

	local function shot_animation(attack, shooter_idx, enemy)
		local ssid = shooter_sids[shooter_idx]
		local soffset = this.render.sprites[ssid].offset
		local s = this.render.sprites[ssid]
		local an, af = U.animation_name_facing_point(this, attack.animation, enemy.pos, ssid, soffset)

		U.animation_start(this, an, af, store.tick_ts, 1, ssid)

		return U.animation_name_facing_point(this, "idle", enemy.pos, ssid, soffset)
	end

	local function shot_bullet(attack, shooter_idx, enemy, level)
		local ssid = shooter_sids[shooter_idx]
		local shooting_up = tpos(this).y < enemy.pos.y
		local shooting_right = tpos(this).x < enemy.pos.x
		local soffset = this.render.sprites[ssid].offset
		local boffset = attack.bullet_start_offset[shooting_up and 1 or 2]
		local b = E:create_entity(attack.bullet)
		local radius = this.attacks.range
		local tox
		local toy
		local txr
		local tx
		local tyr
		local ty
		local eposx = enemy.pos.x + this.attacks.node_prediction * enemy.motion.speed.x
		local eposy = enemy.pos.y + this.attacks.node_prediction * enemy.motion.speed.y
		local shx = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
		local shy = this.pos.y + soffset.y + boffset.y

		b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
		b.pos.y = this.pos.y + soffset.y + boffset.y
		b.bullet.from = V.vclone(b.pos)
		if enemy.pos.x <= shx then
		txr = shx - eposx
		tx = txr * 400
		tox = eposx - tx
		else
		txr = eposx - shx
		tx = txr * 400
		tox = eposx + tx
		end
		if enemy.pos.y <= shy then
		tyr = shy - eposy
		ty = tyr * 400
		toy = eposy - ty
		else
		tyr = eposy - shy
		ty = tyr * 400
		toy = eposy + ty
		end
		b.bullet.to = V.v(tox, toy)
		b.bullet.level = level
		b.bullet.damage_factor = this.tower.damage_factor
		b.bullet.mod = pow_p.level > 0 and pow_p.mod
		b.bullet.mod_chance = pow_p.mod_chance[pow_p.level]
		b.owner = this

		queue_insert(store, b)
	end
	
	local function shot_bullet_big(attack, shooter_idx, enemy, level)
		local ssid = shooter_sids[shooter_idx]
		local shooting_up = tpos(this).y < enemy.pos.y
		local shooting_right = tpos(this).x < enemy.pos.x
		local soffset = this.render.sprites[ssid].offset
		local boffset = attack.bullet_start_offset[shooting_up and 1 or 2]
		local b = E:create_entity(attack.bullet)
		local radius = this.attacks.range
		local tox
		local toy
		local txr
		local tx
		local tyr
		local ty
		local eposx = enemy.pos.x + this.attacks.node_prediction * enemy.motion.speed.x
		local eposy = enemy.pos.y + this.attacks.node_prediction * enemy.motion.speed.y
		local shx = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
		local shy = this.pos.y + soffset.y + boffset.y

		b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
		b.pos.y = this.pos.y + soffset.y + boffset.y
		b.bullet.from = V.vclone(b.pos)
		if enemy.pos.x <= shx then
		txr = shx - eposx
		tx = txr * 400
		tox = eposx - tx
		else
		txr = eposx - shx
		tx = txr * 400
		tox = eposx + tx
		end
		if enemy.pos.y <= shy then
		tyr = shy - eposy
		ty = tyr * 400
		toy = eposy - ty
		else
		tyr = eposy - shy
		ty = tyr * 400
		toy = eposy + ty
		end
		b.bullet.to = V.v(tox, toy)
		b.bullet.level = level
		b.bullet.damage_min = pow_b.damage_min[pow_b.level]
		b.bullet.damage_max = pow_b.damage_max[pow_b.level]
		b.bullet.damage_factor = this.tower.damage_factor
		b.bullet.mod = pow_p.level > 0 and pow_p.mod
		b.bullet.mod_chance = pow_p.mod_chance[pow_p.level]
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
			
			if pow_t.level > 0 and store.tick_ts - ah.ts > ah.cooldown then
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
			
			if pow_b.level > 0 and store.tick_ts - ab.ts > ab.cooldown then
				local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, ab.vis_flags, ab.vis_bans)

				if not enemy then
					-- block empty
				else

					ab.ts = store.tick_ts
					shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

					local idle_an, idle_af = shot_animation(ab, shooter_idx, enemy)

					U.y_wait(store, ab.shoot_time)

					if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
						shot_bullet_big(ab, shooter_idx, enemy, pow_b.level)
					end

					U.y_animation_wait(this, shooter_sids[shooter_idx])
					U.animation_start(this, idle_an, idle_af, store.tick_ts, false, shooter_sids[shooter_idx])
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
						shot_bullet(aa, shooter_idx, enemy, pow_p.level)
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
	local mspeed = b.min_speed
	local target, ps
	local s = this.render.sprites[1]
	local msts = 0
	local mstick = 0.1
	local bounce_count = 0
	local outtable
	local intable
	local back = 0
	outtable = {}
	intable = {}
	b.ts = 0
	this.bounces_max = 1
	
	U.animation_start(this, "flying", nil, store.tick_ts, true)

	b.speed.x, b.speed.y = V.normalize(b.to.x - b.from.x, b.to.y - b.from.y)

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	::label_193_0::
	
	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		local tx = this.pos.x
		local ty = this.pos.y
		local twx = this.owner.pos.x
		local twy = this.owner.pos.y
		local twr = this.owner.attacks.range
		local twa = this.owner.attacks.range * 0.7
		if math.pow((tx - twx) / twr, 2) + math.pow((ty - twy) / twa, 2) >= 1 then
		b.to = b.from
		back = 1
		end
		s.r = s.r + b.rotation_speed * store.tick_length
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		if store.tick_ts - b.ts > b.damage_every then
							b.ts = store.tick_ts
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, b.vis_flags, b.vis_bans)
			if targets and #targets > 0 then
			for _, t in ipairs(targets) do
			if (back == 0 and not table.contains(outtable, t.id)) or (back == 1 and not table.contains(intable, t.id)) then
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
		if back == 0 then
		table.insert(outtable, t.id)
		elseif back == 1 then
		table.insert(intable, t.id)
		end
		end
			end
		end
		end

		coroutine.yield()
	end
	
	if bounce_count < this.bounces_max then

			bounce_count = bounce_count + 1
			b.to = b.from
			back = 1
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

scripts.tower_bone_flingers = {}

function scripts.tower_bone_flingers.get_info(this)
	local a = this.attacks.list[1]
	local b = E:get_template("bone_flingers_bone")
	local min, max = b.bullet.damage_min, b.bullet.damage_max
	local pow_m = this.powers.milk
	
	if pow_m.level > 0 then
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
	local pow_g = this.powers.golem
	local last_soldier_pos
	local skelet
	local skeletonts = 0
	local pow_s = this.powers.skeleton
	local as = this.attacks.list[2]
	local pow_m = this.powers.milk
	
	last_soldier_pos = {}

	aa.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			-- block empty
		else
			if pow_g.changed then
					pow_g.changed = nil
					this.barrack.max_soldiers = pow_g.level
			end
			if pow_s.changed then
				pow_s.changed = nil
				as.disabled = false
				skeletonts = store.tick_ts
			end
			if pow_s.level > 0 and not as.disabled and store.tick_ts - skeletonts > pow_s.cooldown[pow_s.level] then
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

					s = E:create_entity(bar.soldier_type)
					s.soldier.tower_id = this
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
			if pow_m.changed then
				pow_m.changed = nil
			end

			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy = U.find_random_enemy(store.entities, tpos(this), 0, a.range, aa.vis_flags, aa.vis_bans)

				if not enemy then
					-- block empty
				else
					aa.ts = store.tick_ts
					shots_count = shots_count + 1
					last_target_pos.x, last_target_pos.y = enemy.pos.x, enemy.pos.y

					local shooter_idx = shots_count % 2 + 1
					local shooter_sid = shooter_sprite_ids[shooter_idx]
					local start_offset = aa.bullet_start_offset[shooter_idx]
					local an, af = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, start_offset)

					U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

					while store.tick_ts - aa.ts < aa.shoot_time do
						coroutine.yield()
					end

					local b1 = E:create_entity(aa.bullet)

					if pow_m.level == 1 then
						b1.render.sprites[1].name = "bone_flingers_proy2_0001"
					end
					if pow_m.level == 2 then
						b1.render.sprites[1].name = "bone_flingers_proy3_0001"
						b1.bullet.miss_decal = "bone_flingers_proy3_decal_0001"
					end
					if pow_m.level == 3 then
						b1.render.sprites[1].name = "bone_flingers_proy4_0001"
						b1.bullet.miss_decal = "bone_flingers_proy4_decal_0001"
					end
					if pow_m.level > 0 then
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

scripts.aura_spectral_knight_pos = {}

function scripts.aura_spectral_knight_pos.update(this, store)
	U.y_wait(store, this.aura.delay)

	this.tween.disabled = false
	this.tween.ts = store.tick_ts

	return scripts.aura_apply_mod_spectra_pos.update(this, store)
end

scripts.aura_apply_mod_spectra_pos = {}

function scripts.aura_apply_mod_spectra_pos.update(this, store, script)
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
				return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and v.render.sprites[1].prefix == "enemy_fallen_knight" and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
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

scripts.bolt_spectres = {}

function scripts.bolt_spectres.update(this, store, script)
	local b = this.bullet
	local s = this.render.sprites[1]
	local mspeed = b.min_speed
	local target, ps
	local new_target = false
	local target_invalid = false
	local fm = this.force_motion
	
	local function move_step(dest)
		local dx, dy = V.sub(dest.x, dest.y, this.pos.x, this.pos.y)
		local dist = V.len(dx, dy)
		local nx, ny = V.mul(fm.max_v, V.normalize(dx, dy))
		local stx, sty = V.sub(nx, ny, fm.v.x, fm.v.y)

		if dist <= 4 * fm.max_v * store.tick_length then
			stx, sty = V.mul(fm.max_a, V.normalize(stx, sty))
		end

		fm.a.x, fm.a.y = V.add(fm.a.x, fm.a.y, V.trim(fm.max_a, V.mul(fm.a_step, stx, sty)))
		fm.v.x, fm.v.y = V.trim(fm.max_v, V.add(fm.v.x, fm.v.y, V.mul(store.tick_length, fm.a.x, fm.a.y)))
		this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, V.mul(store.tick_length, fm.v.x, fm.v.y))
		fm.a.x, fm.a.y = 0, 0

		return dist <= fm.max_v * store.tick_length
	end

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	::label_75_0::

	if b.store and not b.target_id then
		S:queue(this.sound_events.summon)

		s.z = Z_OBJECTS
		s.sort_y_offset = b.store_sort_y_offset

		U.animation_start(this, "idle", nil, store.tick_ts, true)

		if ps then
			ps.particle_system.emit = false
		end
	else
		S:queue(this.sound_events.travel)

		s.z = Z_BULLETS
		s.sort_y_offset = nil

		U.animation_start(this, "flying", nil, store.tick_ts, s.loop)

		if ps then
			ps.particle_system.emit = true
		end
	end
	
	local pred_pos

	if target then
		pred_pos = P:predict_enemy_pos(target, fts(5))
	else
		pred_pos = b.to
	end

	local iix, iiy = V.normalize(pred_pos.x - this.pos.x, pred_pos.y - this.pos.y)
	local last_pos = V.vclone(this.pos)

	b.ts = store.tick_ts

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		coroutine.yield()

		if not target_invalid then
			target = store.entities[b.target_id]
		end

		if target and not new_target then
			local tpx, tpy = target.pos.x, target.pos.y

			if not b.ignore_hit_offset then
				tpx, tpy = tpx + target.unit.hit_offset.x, tpy + target.unit.hit_offset.y
			end

			local d = math.max(math.abs(tpx - b.to.x), math.abs(tpy - b.to.y))

			if d > b.max_track_distance or band(target.vis.bans, F_RANGED) ~= 0 then
				target_invalid = true
				target = nil
			end
		end

		if target and target.health and not target.health.dead then
			if b.ignore_hit_offset then
				b.to.x, b.to.y = target.pos.x, target.pos.y
			else
				b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			end

			new_target = false
		end
		if target and target.health then
		if this.initial_impulse and store.tick_ts - b.ts < this.initial_impulse_duration then
			local t = store.tick_ts - b.ts

			if this.initial_impulse_angle_abs then
				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(this.initial_impulse_angle_abs, 1, 0))
			else
				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(this.initial_impulse_angle * (b.shot_index % 2 == 0 and 1 or -1), iix, iiy))
			end
		end
		else
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		end

		last_pos.x, last_pos.y = this.pos.x, this.pos.y

		if ps then
			ps.particle_system.emit_direction = s.r
		end
		
		if move_step(b.to) then
			break
		end
		
		this.render.sprites[1].r = V.angleTo(this.pos.x - last_pos.x, this.pos.y - last_pos.y)
	end

	while b.store and not b.target_id do
		coroutine.yield()

		if b.target_id then
			mspeed = b.min_speed
			new_target = true

			goto label_75_0
		end
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)

		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}

			for _, mod_name in pairs(mods) do
				local m = E:create_entity(mod_name)

				m.modifier.target_id = b.target_id
				m.modifier.level = b.level

				queue_insert(store, m)
			end
		end

		if b.hit_payload then
			local hp = b.hit_payload

			hp.pos.x, hp.pos.y = this.pos.x, this.pos.y

			queue_insert(store, hp)
		end
	end

	if b.payload then
		local hp = b.payload

		hp.pos.x, hp.pos.y = b.to.x, b.to.y

		queue_insert(store, hp)
	end

	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)

		sfx.pos.x, sfx.pos.y = b.to.x, b.to.y
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].runs = 0

		if target and sfx.render.sprites[1].size_names then
			sfx.render.sprites[1].name = sfx.render.sprites[1].size_names[target.unit.size]
		end

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

scripts.bolt_poss = {}

function scripts.bolt_poss.update(this, store, script)
	local b = this.bullet
	local s = this.render.sprites[1]
	local mspeed = b.min_speed
	local target, ps
	local new_target = false
	local target_invalid = false

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	::label_75_0::

	if b.store and not b.target_id then
		S:queue(this.sound_events.summon)

		s.z = Z_OBJECTS
		s.sort_y_offset = b.store_sort_y_offset

		U.animation_start(this, "idle", nil, store.tick_ts, true)

		if ps then
			ps.particle_system.emit = false
		end
	else
		S:queue(this.sound_events.travel)

		s.z = Z_BULLETS
		s.sort_y_offset = nil

		U.animation_start(this, "flying", nil, store.tick_ts, s.loop)

		if ps then
			ps.particle_system.emit = true
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		coroutine.yield()

		if not target_invalid then
			target = store.entities[b.target_id]
		end

		if target and not new_target then
			if this.pos.x > b.to.x then
			s.flip_x = true
			elseif this.pos.x < b.to.x then
			s.flip_x = false
			end
			local tpx, tpy = target.pos.x, target.pos.y

			if not b.ignore_hit_offset then
				tpx, tpy = tpx + target.unit.hit_offset.x, tpy + target.unit.hit_offset.y
			end

			local d = math.max(math.abs(tpx - b.to.x), math.abs(tpy - b.to.y))

			if d > b.max_track_distance or band(target.vis.bans, F_RANGED) ~= 0 then
				target_invalid = true
				target = nil
			end
		end

		if target and target.health and not target.health.dead then
			if this.pos.x > b.to.x then
			s.flip_x = true
			elseif this.pos.x < b.to.x then
			s.flip_x = false
			end
			if b.ignore_hit_offset then
				b.to.x, b.to.y = target.pos.x, target.pos.y
			else
				b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			end

			new_target = false
		end

		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length

		if not b.ignore_rotation then
			s.r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end
	end

	while b.store and not b.target_id do
		coroutine.yield()

		if b.target_id then
			mspeed = b.min_speed
			new_target = true

			goto label_75_0
		end
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)

		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}

			for _, mod_name in pairs(mods) do
				local m = E:create_entity(mod_name)

				m.modifier.target_id = b.target_id
				m.modifier.level = b.level

				queue_insert(store, m)
			end
		end

		if b.hit_payload then
			local hp = b.hit_payload

			hp.pos.x, hp.pos.y = this.pos.x, this.pos.y

			queue_insert(store, hp)
		end
	end

	if b.payload then
		local hp = b.payload

		hp.pos.x, hp.pos.y = b.to.x, b.to.y

		queue_insert(store, hp)
	end

	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)

		sfx.pos.x, sfx.pos.y = b.to.x, b.to.y
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].runs = 0

		if target and sfx.render.sprites[1].size_names then
			sfx.render.sprites[1].name = sfx.render.sprites[1].size_names[target.unit.size]
		end

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

scripts.soldier_elite_harasser = {}

function scripts.soldier_elite_harasser.on_damage(this, store, damage)
	log.debug(" SOLDIER_ELITE_HARASSER DAMAGE:%s type:%x", damage.value, damage.damage_type)
	local ca = this.dodge.counter_attack
	local target = store.entities[this.soldier.target_id]

	if not target or target.health.dead or not this.dodge or this.unit.is_stunned or this.health.dead or store.tick_ts - ca.ts < ca.cooldown or band(damage.damage_type, DAMAGE_ALL_TYPES, bnot(bor(DAMAGE_PHYSICAL, DAMAGE_MAGICAL))) ~= 0 or band(damage.damage_type, DAMAGE_NO_DODGE) ~= 0 or this.powers[this.dodge.power_name].level < 1 then
		return true
	end

	log.debug("(%s)soldier_elite_harasser dodged damage %s of type %s", this.id, damage.value, damage.damage_type)

	this.dodge.active = true

	return false
end

function scripts.soldier_elite_harasser.insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		for pn, p in pairs(this.powers) do

			if pn == "backstab" and p.level > 0 then
				this.dodge.animation = this.dodge.counter_attack.animation
				this.dodge.counter_attack.damage_min = this.dodge.counter_attack.damage_inc_min[p.level]
				this.dodge.counter_attack.damage_max = this.dodge.counter_attack.damage_inc_max[p.level]
			end
			if pn == "fury" and p.level > 0 then
				this.revive.disabled = nil
				this.revive.chance = this.powers.fury.chance
				this.powers.fury.fury_on = true
			end
		end

		return true
	end

	return false
end

function scripts.soldier_elite_harasser.update(this, store)
	local brk, sta
	local tower = store.entities[this.soldier.tower_id]
	local pow_f = this.powers.fury
	local undead = nil
	local fury_ts
	local ps = E:create_entity(this.run_particles_name)
	local fury_off = nil

	ps.particle_system.track_id = this.id
	ps.particle_system.emit = false

	queue_insert(store, ps)

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end
	
	local function fury_soldier_revive(store, this)
		if not this.revive or not pow_f.fury_on or this.revive.disabled or this.unit.is_stunned or band(this.health.last_damage_types, bor(DAMAGE_DISINTEGRATE, DAMAGE_EAT, DAMAGE_DISINTEGRATE_BOSS)) ~= 0 then
			return false
		end

		local r = this.revive

		if math.random() < r.chance then
			local r = this.revive

			this.health.ignore_damage = true
			this.health.dead = false
			this.health_bar.hidden = false

			if this.soldier.target_id then
				local enemy = store.entities[this.soldier.target_id]
	
				if enemy then
					U.block_enemy(store, this, enemy)
				end
			end

			if r.fx then
				local fx = E:create_entity(r.fx)

				fx.pos = this.pos
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if r.animation then
				S:queue(r.sound)
				U.animation_start(this, r.animation, nil, store.tick_ts, false)

				r.ts = store.tick_ts

				while store.tick_ts - r.ts < r.hit_time do
					coroutine.yield()
				end
			end

			r.revive_count = (r.revive_count or 0) + 1

			signal.emit("entity-revived", this, r.revive_count)
			
			this.health.hp_max = pow_f.health

			this.health.hp = km.clamp(0, this.health.hp_max, this.health.hp + this.health.hp_max * r.health_recover)

			if r.animation then
				while not U.animation_finished(this) do
					coroutine.yield()
				end
			end
		
			this.ranged.attacks[1].disabled = true
			this.ranged.attacks[2].disabled = true
			this.dodge.disabled = true
			this.dodge = nil
			this.motion.max_speed = pow_f.speed
			this.melee.attacks[1].damage_min = pow_f.damage_min
			this.melee.attacks[1].damage_max = pow_f.damage_max
			this.melee.attacks[1].cooldown = pow_f.cooldown
			this.render.sprites[1].prefix = "soldier_elite_harassers_fury"
			this.info.i18n_key = "SOLDIER_ELITE_HARASSERS_FURY"
			this.info.random_name_format = nil
			this.info.portrait = (IS_PHONE_OR_TABLET and "krv_portraits_0019") or "krv_portraits_0019"
			this.sound_events.death = "EliteHarassersFuryDeath"

			this.health.ignore_damage = false
		
			fury_ts = store.tick_ts
		
			undead = true

			return true
		end

		return false
	end

	while true do
		ps.particle_system.emit = false
		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					SU.soldier_power_upgrade(this, pn)

					if pn == "backstab" then
						this.dodge.animation = this.dodge.counter_attack.animation
						this.dodge.counter_attack.damage_min = this.dodge.counter_attack.damage_inc_min[p.level]
						this.dodge.counter_attack.damage_max = this.dodge.counter_attack.damage_inc_max[p.level]
					end
					if pn == "fury" then
						this.revive.disabled = nil
						this.revive.chance = pow_f.chance
						pow_f.fury_on = true
					end
				end
			end
		end

		if undead and store.tick_ts - fury_ts > pow_f.duration then
			this.health_bar.hidden = true
			this.health.dead = true
			fury_off = true
			SU.y_soldier_death(store, this)
			
			return
		end
		if undead and this.health.dead and not fury_off then
			fury_off = true
			this.health_bar.hidden = true
			this.health.dead = true
			this.health.dead_lifetime = this.health.dead_lifetime - (store.tick_ts - fury_ts)
			this.health.delete_after = store.tick_ts + this.health.dead_lifetime
			SU.y_soldier_death(store, this)
			
			return
		end
		if not this.health.dead or (not undead and fury_soldier_revive(store, this)) then
			--block empty
		else
			SU.y_soldier_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			
			if this.dodge and this.dodge.active and not undead then
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
			::label_612_1::
			while this.nav_rally.new do
				if undead then
					ps.particle_system.emit = true
				end
				if SU.y_soldier_new_rally(store, this) then
					goto label_61_1
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_61_1
				end
			end
			
			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk or sta == A_DONE then
					goto label_61_1
				elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
					goto label_61_0
				end
			end

				if SU.soldier_go_back_step(store, this) then
					goto label_61_1
				end

				::label_61_0::

				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
		end

		::label_61_1::

		coroutine.yield()
	end
end

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
				
				ma.loops = ma.loops + ma.loops_inc

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
						local u = UP:get_upgrade("mage_spell_of_penetration")
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
						local u = UP:get_upgrade("mage_spell_of_penetration")

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
	
	U.animation_start(this, "start", nil, store.tick_ts, 1)

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
	U.animation_start(this, "end", nil, store.tick_ts, 1)
	
	while not U.animation_finished(this) do
		coroutine.yield()
	end
	
	queue_remove(store, this)
end

return scripts
