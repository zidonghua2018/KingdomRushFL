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

local scripts = require("scripts_4")

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



scripts.tower_time_wizard = {}

function scripts.tower_time_wizard.update(this, store)
	local tower_sid = 2
	local shooter_sid = 3
	local polymorph_sid = 4
	local a = this.attacks
	local ab = this.attacks.list[1]
	local ap = this.attacks.list[2]
	local ab_mod = E:get_template(ab.bullet).mod
	local pow_p = this.powers.sandstorm
	local pow_e = this.powers.guardian
	local ba = this.barrack
	local last_ts = store.tick_ts
	local last_soldier_pos
	local s = ba.soldiers[1]

	ab.ts = store.tick_ts

	local aa, pow
	local attacks = {
		ap,
		ab
	}
	local pows = {
		pow_p
	}

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if pow_p.level > 0 and pow_p.changed then
				pow_p.changed = nil

				if pow_p.level == 1 then
					ap.ts = store.tick_ts
				end

				ap.cooldown = pow_p.cooldown_base + pow_p.cooldown_inc * pow_p.level
			end

			if pow_e.level > 0 then
				if pow_e.changed then
					pow_e.changed = nil

					local s = ba.soldiers[1]

					if s and store.entities[s.id] then
						s.unit.level = pow_e.level
						s.health.armor = s.health.armor + s.health.armor_inc
						s.health.hp_max = s.health.hp_max + s.health.hp_inc
						s.health.hp = s.health.hp_max

						local ma = s.melee.attacks[1]

						ma.damage_min = ma.damage_min + ma.damage_inc
						ma.damage_max = ma.damage_max + ma.damage_inc
					end
				end

				local s = ba.soldiers[1]

				if s and s.health.dead then
					last_soldier_pos = s.pos
				end

				if not s or s.health.dead and store.tick_ts - s.health.death_ts > s.health.dead_lifetime then
					local ns = E:create_entity(ba.soldier_type)

					ns.soldier.tower_id = this.id
					ns.pos = last_soldier_pos or V.v(ba.rally_pos.x, ba.rally_pos.y)
					ns.nav_rally.pos = V.vclone(ba.rally_pos)
					ns.nav_rally.center = V.vclone(ba.rally_pos)
					ns.nav_rally.new = true
					ns.unit.level = pow_e.level
					ns.health.armor = ns.health.armor + ns.health.armor_inc * ns.unit.level
					ns.health.hp_max = ns.health.hp_max + ns.health.hp_inc * ns.unit.level

					local ma = ns.melee.attacks[1]

					ma.damage_min = ma.damage_min + ma.damage_inc * ns.unit.level
					ma.damage_max = ma.damage_max + ma.damage_inc * ns.unit.level

					queue_insert(store, ns)

					ba.soldiers[1] = ns
					s = ns
				end
				
				if pow_e.level > 1 then
					s.auras.list[1].cooldown = 0
				end
				
				if pow_e.level > 2 then
					s.melee.attacks[1].mod = "mod_teleport_ancient_guardian"
				end

				if ba.rally_new then
					ba.rally_new = false

					signal.emit("rally-point-changed", this)

					if s then
						s.nav_rally.pos = V.vclone(ba.rally_pos)
						s.nav_rally.center = V.vclone(ba.rally_pos)
						s.nav_rally.new = true

						if not s.health.dead then
							S:queue(this.sound_events.change_rally_point)
						end
					end
				end
			end

			for i, aa in pairs(attacks) do
				pow = pows[i]

				if (not pow or pow.level > 0) and store.tick_ts - aa.ts > aa.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

					if not enemy then
						-- block empty
					else
						if aa == ab then
							for _, e in pairs(enemies) do
								if not U.has_modifier_types(store, e, MOD_TYPE_SLOW) then
									enemy = e

									break
								end
							end
						end

						last_ts = store.tick_ts
						aa.ts = last_ts

						local soffset = this.render.sprites[shooter_sid].offset
						local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

						U.animation_start(this, an, nil, store.tick_ts, false, shooter_sid)
						U.animation_start(this, aa.animation, nil, store.tick_ts, false, tower_sid)

						if aa == ap then
							local s_poly = this.render.sprites[polymorph_sid]

							s_poly.hidden = false
							s_poly.ts = last_ts
						end

						U.y_wait(store, aa.shoot_time)

						if aa == ap and not store.entities[enemy.id] or enemy.health.dead then
							enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

							if not enemy or enemy.health.dead then
								goto label_18_0
							end
						end

						if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
							local b
							local boffset = aa.bullet_start_offset[ai]

							b = E:create_entity(aa.bullet)
							b.pos.x, b.pos.y = this.pos.x + boffset.x, this.pos.y + boffset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.vclone(enemy.pos)
							b.bullet.target_id = enemy.id
							b.bullet.source_id = this.id
							b.bullet.level = pow_p.level

							queue_insert(store, b)
						end

						::label_18_0::

						if aa == ap then
						U.y_animation_wait(this, tower_sid)
						end
					end
				end
			end

			if store.tick_ts - ab.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, true, shooter_sid)
				U.animation_start(this, "idle", nil, store.tick_ts, true, tower_sid)
			end

			coroutine.yield()
		end
	end
end

scripts.ancient_guardian = {}

function scripts.ancient_guardian.insert(this, store, script)
	if this.melee then
		this.melee.order = U.attack_order(this.melee.attacks)
	end

	if this.ranged then
		this.ranged.order = U.attack_order(this.ranged.attacks)
	end

	if this.track_kills and this.track_kills.mod then
		local e = E:create_entity(this.track_kills.mod)

		e.pos = V.vclone(this.pos)
		e.modifier.target_id = this.id
		e.modifier.source_id = this.id

		queue_insert(store, e)
	end

	if this.track_damage and this.track_damage.mod then
		local e = E:create_entity(this.track_damage.mod)

		e.pos = V.vclone(this.pos)
		e.modifier.target_id = this.id
		e.modifier.source_id = this.id

		queue_insert(store, e)
	end

	if this.powers then
		for pn, p in pairs(this.powers) do
			for i = 1, p.level do
				SU.soldier_power_upgrade(this, pn)
			end
		end
	end

	if this.info and this.info.random_name_format then
		this.info.i18n_key = string.format(string.gsub(this.info.random_name_format, "_NAME", ""), math.random(this.info.random_name_count))
	end

	this.vis._bans = this.vis.bans
	this.vis.bans = F_ALL

	if this.render then
		for _, s in pairs(this.render.sprites) do
			s.ts = store.tick_ts - U.frandom(0, 1)
		end
	end

	return true
end

function scripts.ancient_guardian.update(this, store, script)
	local brk, sta
	local aon = false

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

	while true do
		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					SU.soldier_power_upgrade(this, pn)
				end
			end
		end
		
		if this.auras and not aon and this.auras.list[1].cooldown == 0 then
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
		aon = true
	end

		if this.cloak then
			this.vis.flags = band(this.vis.flags, bnot(this.cloak.flags))
			this.vis.bans = band(this.vis.bans, bnot(this.cloak.bans))
			this.render.sprites[1].alpha = 255
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

			SU.soldier_idle(store, this)

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

scripts.mod_ancient_guard = {}

function scripts.mod_ancient_guard.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	if target.melee then
		if target.melee.forced_cooldown then
			target.melee.forced_cooldown = target.melee.forced_cooldown - this.increase
		end
		if target.melee.cooldown then
			target.melee.cooldown = target.melee.cooldown - this.increase
		end
		if target.melee.attacks then
			if target.melee.attacks[1] and  target.melee.attacks[1].cooldown then
				target.melee.attacks[1].cooldown = target.melee.attacks[1].cooldown - this.increase
			end
		end
	end

	return true
end
function scripts.mod_ancient_guard.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		if target.melee then
			if target.melee.forced_cooldown then
				target.melee.forced_cooldown = target.melee.forced_cooldown + this.increase
			end
			if target.melee.cooldown then
				target.melee.cooldown = target.melee.cooldown + this.increase
			end
			if target.melee.attacks then
				if target.melee.attacks[1] and target.melee.attacks[1].cooldown then
					target.melee.attacks[1].cooldown = target.melee.attacks[1].cooldown + this.increase
				end
			end
		end
	end

	return true
end
scripts.aura_ancient_guardian = {}

function scripts.aura_ancient_guardian.update(this, store, script)
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
				return v.unit and v.vis and v.health and v.soldier and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
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

scripts.airstrike = {}

function scripts.airstrike.update(this, store, script)
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
	
	if b.hit_fx then
		S:queue(this.sound_events.hit)

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset
		sfx.render.sprites[2].ts = store.tick_ts
		sfx.render.sprites[2].sort_y_offset = b.hit_fx_sort_y_offset
		sfx.render.sprites[3].ts = store.tick_ts
		sfx.render.sprites[3].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, sfx)
	end
	
	U.y_wait(store, fts(30))

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, dradius)
	end)

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.damage_type = b.damage_type
		d.reduce_armor = b.reduce_armor
		d.reduce_magic_armor = b.reduce_magic_armor

		if UP:get_upgrade("engineer_efficiency") then
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

scripts.soldier_steam_trooper = {}

function scripts.soldier_steam_trooper.update(this, store)
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

					if pn == "ball" and p.level == 1 then
						this.melee.attacks[1].disabled = true
						this.melee.attacks[2].ts = store.tick_ts
					end
					if pn == "airstrike" then
						this.ranged.attacks[2].disabled = true
						this.ranged.attacks[2].ts = store.tick_ts
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
			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_61_1
				end
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

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

scripts.tower_steam_troop = {}

function scripts.tower_barrack.insert(this, store, script)
	if not this.barrack.rally_pos and this.tower.default_rally_pos then
		this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
	end

	return true
end

function scripts.tower_steam_troop.update(this, store, script)
	local tower_sid = 2
	local door_sid = 3

	while true do
		local b = this.barrack
		local sol1 = this.barrack.soldiers[1]
		local sol2 = this.barrack.soldiers[2]
		local sol3 = this.barrack.soldiers[3]
		local pow_a = this.powers.airstrike
		local marked = nil

		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					for _, s in pairs(b.soldiers) do
						s.powers[pn].level = p.level
						s.powers[pn].changed = true
					end
				end
			end
		end
		
		if pow_a.level > 0 and not marked then
			if sol1 and sol1.health and not sol1.health.dead then
			sol1.ranged.attacks[2].disabled = false
			sol2.ranged.attacks[2].disabled = true
			sol3.ranged.attacks[2].disabled = true
			elseif sol2 and sol2.health and not sol2.health.dead then
			sol2.ranged.attacks[2].disabled = false
			sol3.ranged.attacks[2].disabled = true
			elseif sol3 then
			sol3.ranged.attacks[2].disabled = false
			end
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

					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.id
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers)
					s.nav_rally.new = true
					s.ranged.attacks[2].ts = store.tick_ts

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

scripts.mod_steam_soldier_explode = {}

function scripts.mod_steam_soldier_explode.remove(this, store)
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
			for _, target in pairs(targets) do
				local is_enemy = band(target.vis.flags, F_ENEMY) ~= 0
				local d = E:create_entity("damage")

				d.damage_type = is_enemy and DAMAGE_EXPLOSION
				d.value = this.explode_damage
				d.source_id = this.id
				d.target_id = target.id

				queue_damage(store, d)

				if is_enemy then
					count_enemies = count_enemies + 1
				else
					count_soldiers = count_soldiers + 1
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
---精英军团弓兵
scripts.tower_hammerhold = {}

function scripts.tower_hammerhold.get_info(this)
	local a = this.attacks.list[1]
	local b = E:get_template("arrow_hammerhold_elite")
	local min, max = b.bullet.damage_min, b.bullet.damage_max
	local d_type = b.bullet.damage_type	

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown = a.cooldown

	return {
		type = STATS_TYPE_TOWER,
		damage_min = min,
		damage_max = max,
		damage_type = d_type,		
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_hammerhold.remove(this, store)
	if this.crows then
		for _, e in pairs(this.crows) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_hammerhold.update(this, store)
	local a = this.attacks
	local aa = this.attacks.list[1]
	local as = this.attacks.list[2]
	local am = this.attacks.list[3]
	local pow_s = this.powers.split
	local pow_f = this.powers.flare
	local sid = 3
	local mints
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
			
			if attack == as then
			b.extra_arrows = pow_s.extra_arrows[pow_s.level]
			end

			queue_insert(store, b)
			
			local u = UP:get_upgrade("archer_twin_shot")

			if attack == aa and u and math.random() < u.chance then
				b2 = E:clone_entity(b)
				b2.bullet.flight_time = b2.bullet.flight_time - 1 / FPS

				queue_insert(store, b2)

				b.bullet.flight_time = b.bullet.flight_time + 1 / FPS
			end

			if attack.shot_fx then
				local fx = E:create_entity(attack.shot_fx)

				fx.pos.x, fx.pos.y = b.bullet.from.x, b.bullet.from.y

				local bb = b.bullet

				fx.render.sprites[1].r = V.angleTo(bb.to.x - bb.from.x, bb.to.y - bb.from.y)
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end
		end

		U.y_animation_wait(this, sid)

		an, af = U.animation_name_facing_point(this, "idle", enemy.pos, sid, soffset)

		U.animation_start(this, an, af, store.tick_ts, true, sid)
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
				end
				i = i + 1
			end
			return nil
		end
	end

	mints = store.tick_ts
	aa.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if pow_f.changed then
					pow_f.changed = nil

					if pow_f.level == 1 then
						am.ts = store.tick_ts
					end
				end
				if pow_s.changed then
					pow_s.changed = nil

					if pow_s.level == 1 then
						as.ts = store.tick_ts
					end
				end
			
			if pow_s.level > 0 and store.tick_ts - as.ts > as.cooldown and store.tick_ts - mints > aa.cooldown then
				local target = find_enemy_pair(store.entities, tpos(this), 0, a.range, as.extra_arrows_range, as.vis_flags, F_NONE)
				if target then
					as.ts = store.tick_ts
					mints = store.tick_ts
					y_do_shot(as, target, pow_s.level)
				end
			end

			if pow_f.level > 0 and store.tick_ts - am.ts > am.cooldown and store.tick_ts - mints > aa.cooldown then
				local enemy = U.find_enemies_in_range(store.entities, tpos(this), 0, a.range, am.vis_flags, am.vis_bans, function(v)
				return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, am.vis_bans) == 0 and band(v.vis.bans, am.vis_flags) == 0 and not table.contains(am.excluded_templates, v.template_name)
			end)

				if enemy then
					table.sort(enemy, function(e1, e2)
						return e1.health.hp > e2.health.hp
					end)
					local targets = {}
					local first_target = enemy[1]
					table.insert(targets, first_target)
					
					am.ts = store.tick_ts
					mints = store.tick_ts
					y_do_shot(am, first_target, pow_f.level)
				end
			end

			if store.tick_ts - aa.ts > aa.cooldown and store.tick_ts - mints > aa.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

				if enemy then
					aa.ts = store.tick_ts
					mints = store.tick_ts
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

scripts.mod_legion_burn = {}

function scripts.mod_legion_burn.update(this, store, script)
	local cycles, total_damage = 0, 0
	local m = this.modifier
	local dps = this.dps
	local fx_ts = 0

	local function do_damage(target, value)
		total_damage = total_damage + value

		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = target.id
		d.value = value
		d.damage_type = dps.damage_type
		d.pop = dps.pop
		d.pop_chance = dps.pop_chance
		d.pop_conds = dps.pop_conds

		queue_damage(store, d)
	end

	local target = store.entities[m.target_id]

	if not target then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead then
			break
		end

		if store.tick_ts - m.ts >= m.duration - 1e-09 then
			if dps.damage_last then
				do_damage(target, dps.damage_last)
			end

			break
		end

		if this.render and m.use_mod_offset and target.unit.mod_offset then
			local so = this.render.sprites[1].offset

			so.x, so.y = target.unit.mod_offset.x, target.unit.mod_offset.y
		end

		if dps.damage_every and store.tick_ts - dps.ts >= dps.damage_every then
			cycles = cycles + 1
			dps.ts = dps.ts + dps.damage_every
			
			local damage_value
			if target and not target.health.dead and (target.health.hp > (target.health.hp_max * this.health_cap[m.level])) then
			damage_value = math.ceil(target.health.hp_max * dps.damage_percent)
			else
			damage_value = dps.damage_flat[m.level]
			end

			if cycles == 1 and dps.damage_first then
				damage_value = dps.damage_first
			end

			if not dps.kill then
				damage_value = km.clamp(0, target.health.hp - 1, damage_value)
			end

			do_damage(target, damage_value)

			if dps.fx and (not dps.fx_every or store.tick_ts - fx_ts >= dps.fx_every) then
				fx_ts = store.tick_ts

				local fx = E:create_entity(dps.fx)

				if dps.fx_tracks_target then
					fx.pos = target.pos

					if m.use_mod_offset and target.unit.mod_offset then
						fx.render.sprites[1].offset.x = target.unit.mod_offset.x
						fx.render.sprites[1].offset.y = target.unit.mod_offset.y
					end
				else
					fx.pos = V.vclone(this.pos)

					if m.use_mod_offset and target.unit.mod_offset then
						fx.pos.x, fx.pos.y = fx.pos.x + target.unit.mod_offset.x, fx.pos.y + target.unit.mod_offset.y
					end
				end

				fx.render.sprites[1].ts = store.tick_ts
				fx.render.sprites[1].runs = 0

				if fx.render.sprites[1].size_names then
					fx.render.sprites[1].name = fx.render.sprites[1].size_names[target.unit.size]
				end

				if fx.render.sprites[1].use_blood_color and target.unit.blood_color then
					fx.render.sprites[1].name = fx.render.sprites[1].name .. "_" .. target.unit.blood_color
				end

				if dps.fx_target_flip and target and target.render then
					fx.render.sprites[1].flip_x = target.render.sprites[1].flip_x
				end

				queue_insert(store, fx)
			end
		end

		coroutine.yield()
	end

	log.paranoid(">>>>> id:%s - mod_dps cycles:%s total_damage:%s", this.id, cycles, total_damage)
	queue_remove(store, this)
end

scripts.arrow_split = {}

function scripts.arrow_split.insert(this, store)
	if this.extra_arrows > 0 then
		local targets = U.find_enemies_in_range(store.entities, this.bullet.to, 0, this.extra_arrows_range, F_RANGED, F_NONE, function(e)
			return e.id ~= this.bullet.target_id
		end)
		if targets then
		for i = 1, this.extra_arrows do
			if targets[i] then
			local b = E:clone_entity(this)

			b.extra_arrows = 0

			if targets and targets[i] then
				local t = targets[i]

				b.bullet.target_id = t.id
				b.bullet.to = V.v(t.pos.x + t.unit.hit_offset.x, t.pos.y + t.unit.hit_offset.y)
			end

			queue_insert(store, b)
		end
		end
		end
	end

	return scripts.arrow.insert(this, store)
end
---准星
scripts.tower_musketeer = {}

function scripts.tower_musketeer.update(this, store)
	local shooter_sids = {
		3,
		4
	}
	local shooter_idx = 2
	local a = this.attacks
	local aa = this.attacks.list[1]
	local asn = this.attacks.list[2]
	local asi = this.attacks.list[3]
	local ash = this.attacks.list[4]
	local pow_sn = this.powers.sniper
	local pow_sh = this.powers.shrapnel

	aa.ts = store.tick_ts

	local function shot_animation(attack, shooter_idx, enemy, animation)
		local ssid = shooter_sids[shooter_idx]
		local soffset = this.render.sprites[ssid].offset
		local s = this.render.sprites[ssid]
		local an, af, ai = U.animation_name_facing_point(this, animation or attack.animation, enemy.pos, ssid, soffset)

		U.animation_start(this, an, af, store.tick_ts, 1, ssid)

		return an, af, ai
	end

	local function shot_bullet(attack, shooter_idx, ani_idx, enemy, level)
		local ssid = shooter_sids[shooter_idx]
		local shooting_right = tpos(this).x < enemy.pos.x
		local soffset = this.render.sprites[ssid].offset
		local boffset = attack.bullet_start_offset[ani_idx]
		
		local b = E:create_entity(attack.bullet)

		b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
		b.pos.y = this.pos.y + soffset.y + boffset.y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
		b.bullet.target_id = enemy.id
		b.bullet.level = level
		b.bullet.damage_factor = this.tower.damage_factor

		if attack == asn then
			local extra_damage = pow_sn.damage_factor_inc * pow_sn.level * enemy.health.hp_max

			b.bullet.damage_max = b.bullet.damage_max + extra_damage
			b.bullet.damage_min = b.bullet.damage_min + extra_damage
		end

		queue_insert(store, b)

		return b
	end

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow.level == 1 then
						for _, ax in pairs(a.list) do
							if ax.power_name and this.powers[ax.power_name] == pow then
								ax.ts = store.tick_ts
							end
						end
					end

					if pow == pow_sn then
						asi.chance = pow_sn.instakill_chance_inc * pow_sn.level
					end
				end
			end

			if pow_sn.level > 0 then
				for _, ax in pairs({
					asi,
					asn
				}) do
					if (ax.chance == 1 or math.random() < ax.chance) and store.tick_ts - ax.ts > ax.cooldown then
						local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, ax.range, false, ax.vis_flags, ax.vis_bans)

						if not enemy then
							break
						end

						for _, axx in pairs({
							aa,
							asi,
							asn
						}) do
							axx.ts = store.tick_ts
						end

						shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

						local seeker_idx = km.zmod(shooter_idx + 1, #shooter_sids)
						local an, af, ai = shot_animation(ax, shooter_idx, enemy)
						
						local m = E:create_entity(ax.crosshair_name)

						m.modifier.source_id = this.id
						m.modifier.target_id = enemy.id
						m.render.sprites[1].ts = store.tick_ts

						queue_insert(store, m)


						shot_animation(ax, seeker_idx, enemy, ax.animation_seeker)
						U.y_wait(store, ax.shoot_time)

						if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= ax.range then
							shot_bullet(ax, shooter_idx, ai, enemy, pow_sn.level)
						end

						U.y_animation_wait(this, shooter_sids[shooter_idx])
					end
				end
			end

			if pow_sh.level > 0 and store.tick_ts - ash.ts > ash.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, ash.range, false, ash.vis_flags, ash.vis_bans)

				if not enemy then
					-- block empty
				else
					ash.ts = store.tick_ts
					aa.ts = store.tick_ts
					shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

					local fuse_idx = km.zmod(shooter_idx + 1, #shooter_sids)
					local ssid = shooter_sids[shooter_idx]
					local fsid = shooter_sids[fuse_idx]
					local an, af, ai = shot_animation(ash, shooter_idx, enemy)

					shot_animation(ash, fuse_idx, enemy, ash.animation_seeker)

					this.render.sprites[fsid].flip_x = fuse_idx < shooter_idx
					this.render.sprites[ssid].draw_order = 5

					U.y_wait(store, ash.shoot_time)

					local shooting_right = tpos(this).x < enemy.pos.x
					local soffset = this.render.sprites[ssid].offset
					local boffset = ash.bullet_start_offset[ai]
					local dest_pos = P:predict_enemy_pos(enemy, ash.node_prediction)
					local src_pos = V.v(this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1), this.pos.y + soffset.y + boffset.y)
					local fx = SU.insert_sprite(store, ash.shoot_fx, src_pos)

					fx.render.sprites[1].r = V.angleTo(dest_pos.x - src_pos.x, dest_pos.y - src_pos.y)

					for i = 1, ash.loops do
						local b = E:create_entity(ash.bullet)

						b.bullet.flight_time = U.frandom(b.bullet.flight_time_min, b.bullet.flight_time_max)
						b.pos = V.vclone(src_pos)
						b.bullet.from = V.vclone(src_pos)
						b.bullet.to = U.point_on_ellipse(dest_pos, U.frandom(ash.min_spread, ash.max_spread), (i - 1) * 2 * math.pi / ash.loops)
						b.bullet.level = pow_sh.level

						queue_insert(store, b)
					end

					U.y_animation_wait(this, shooter_sids[shooter_idx])

					this.render.sprites[ssid].draw_order = nil
				end
			end

			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

				if not enemy then
					-- block empty
				else
					aa.ts = store.tick_ts
					shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

					local an, af, ai = shot_animation(aa, shooter_idx, enemy)

					U.y_wait(store, aa.shoot_time)

					if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
						shot_bullet(aa, shooter_idx, ai, enemy, 0)
					end

					U.y_animation_wait(this, shooter_sids[shooter_idx])
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
---投网
scripts.soldier_barbarian = {}

function scripts.soldier_barbarian.update(this, store, script)
	local brk, sta

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end
	
	local function barbarian_pick_ranged_target_and_attack(store, this)
	local in_range = false
	local awaiting_target

	for _, i in pairs(this.ranged.order) do
		local a = this.ranged.attacks[i]

		if a.disabled then
			-- block empty
		elseif a.sync_animation and not this.render.sprites[1].sync_flag then
			-- block empty
		else
			local target, _, pred_pos
			if a == this.ranged.attacks[1] then
				target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)
			else
				target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, function(e)
					return band(e.vis.flags, F_FLYING) ~= 0 and not U.has_modifiers(store, e, "mod_barbarian_net") and not U.has_modifier_types(store, e, MOD_TYPE_SLOW)
				end)
			end

			if target then
				if pred_pos then
					log.paranoid(" target.pos:%s,%s  pred_pos:%s,%s", target.pos.x, target.pos.y, pred_pos.x, pred_pos.y)
				end

				local ready = store.tick_ts - a.ts >= a.cooldown

				if not ready then
					awaiting_target = target
				elseif math.random() <= a.chance then
					return target, a, pred_pos
				else
					a.ts = store.tick_ts
				end
			end
		end
	end

	return awaiting_target, nil
	end
	
	local function y_barbarian_ranged_attacks(store, this)
	local target, attack, pred_pos = barbarian_pick_ranged_target_and_attack(store, this)

	if not target then
		return false, A_NO_TARGET
	end

	if not attack then
		return false, A_IN_COOLDOWN
	end

	local start_ts = store.tick_ts
	local attack_done

	U.set_destination(this, this.pos)
		attack_done = SU.y_soldier_do_ranged_attack(store, this, target, attack, pred_pos)

	if attack_done then
		attack.ts = start_ts

		if attack.shared_cooldown then
			for _, aa in pairs(this.ranged.attacks) do
				if aa ~= attack and aa.shared_cooldown then
					aa.ts = attack.ts
				end
			end
		end
	end

	if attack_done then
		return false, A_DONE
	else
		return true
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

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			SU.y_soldier_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else

			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_39_1
				end
			end

			if this.ranged and this.ranged.range_while_blocking then
				brk, sta = y_barbarian_ranged_attacks(store, this)

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

			if SU.soldier_go_back_step(store, this) then
				goto label_39_1
			end

			::label_39_0::

			SU.soldier_idle(store, this)

			SU.soldier_regen(store, this)
		end

		::label_39_1::

		coroutine.yield()
	end
end
scripts.bolt_net = {}

function scripts.bolt_net.insert(this, store)
	if this.extra_bolt > 0 then
		local targets = U.find_enemies_in_range(store.entities, this.bullet.to, 0, this.extra_bolt_range, F_RANGED, F_NONE, function(e)
			return e.id ~= this.bullet.target_id
		end)

		for i = 1, this.extra_bolt do
			local b = E:clone_entity(this)

			b.extra_bolt = 0

			if targets and targets[i] then
				local t = targets[i]

				b.bullet.target_id = t.id
				b.bullet.to = V.v(t.pos.x + t.unit.hit_offset.x, t.pos.y + t.unit.hit_offset.y)
				b.bullet.flight_time = U.frandom(fts(15), fts(25))
			end

			queue_insert(store, b)
		end
	end

	return scripts.bolt.insert(this, store)
end
scripts.mod_barbarian_net = {}

function scripts.mod_barbarian_net.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local level = this.modifier.level

	if not target or target.health.dead or not target.motion or target.motion.invulnerable then
		return false
	end

	if this.modifier.excluded_templates and table.contains(this.modifier.excluded_templates, target.template_name) then
		log.paranoid("mod_barbarian_net.insert not inserted to %s because of excluded_templates", target.id)

		return false
	end

	log.paranoid("mod_barbarian_net.insert (%s)-%s for (%s)-%s", this.id, this.template_name, target.id, target.template_name)

	if target.motion then
		target.motion.max_speed = target.motion.max_speed * this.slow.factor[level]
	end
	this.modifier.ts = store.tick_ts
	
	if target.render.sprites[1].prefix == "enemy_rocketeer" then
	SU.remove_modifiers(store, target, "mod_rocketeer_speed_buff")
	end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_barbarian_net.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local level = this.modifier.level

	if target and target.health and target.motion then
		target.motion.max_speed = target.motion.max_speed / this.slow.factor[level]
	--	target.motion.max_speed = target.motion.max_speed / this.slow.factor

		log.paranoid("mod_barbarian_net.remove (%s)-%s for (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	else
		log.debug("mod_barbarian_net.remove target is nil for id %s", this.modifier.target_id)
	end

	return true
end
---网克火箭骑兵
scripts.enemy_rocketeer = {}

function scripts.enemy_rocketeer.on_damage(this, store, damage)
	if not this.health.dead and not U.has_modifier_types(store, this, MOD_TYPE_FREEZE) and not U.has_modifiers(store, this, "mod_barbarian_net") and not this.already_speed_up then
		local speed_buff = E:create_entity("mod_rocketeer_speed_buff")

		speed_buff.modifier.source_id = this.id
		speed_buff.modifier.target_id = this.id

		queue_insert(store, speed_buff)
	end

	return true
end

scripts.mod_rocketeer_speed_buff = {}

function scripts.mod_rocketeer_speed_buff.insert(this, store)
	local m = this.modifier
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead or U.has_modifiers(store, this, "mod_barbarian_net") then
		return false
	end

	m.ts = store.tick_ts
	target._angles_walk = target.render.sprites[1].angles.walk
	target.already_speed_up = true
	target.render.sprites[1].angles.walk = this.walk_angles
	target.motion.max_speed = target.motion.max_speed * this.fast.factor

	return true
end

function scripts.mod_rocketeer_speed_buff.update(this, store, script)
	local m = this.modifier

	this.modifier.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
			queue_remove(store, this)

			return
		end
		
		if U.has_modifiers(store, target, "mod_barbarian_net") then
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
---旧版维兹南

scripts.eb_veznan = {}

function scripts.eb_veznan.update(this, store)
	local ba = this.timed_attacks.list[1]
	local pa = this.timed_attacks.list[2]
	local taunt_ts
	local portals = LU.list_entities(store.entities, pa.portal_name)
	local initial_hp = this.health.hp_max

	local function y_taunt(idx, set)
		U.animation_start(this, "laugh", nil, store.tick_ts, true)
		SU.y_show_taunt_set(store, this.taunts, set or this.phase, idx, nil, nil, true)
		U.y_animation_wait(this)
		U.animation_start(this, "idleDown", nil, store.tick_ts, true)
	end

	local function y_block_towers()
		local towers = table.filter(store.entities, function(_, e)
			return e.tower and e.tower.can_be_mod and not U.has_modifiers(store, e, ba.mod)
		end)

		if not towers or #towers == 0 then
			SU.delay_attack(store, ba, 0.5)

			return
		end

		local start_ts = store.tick_ts

		U.animation_start(this, ba.animation, nil, store.tick_ts)
		U.y_wait(store, ba.hit_time)
		S:queue(ba.sound)

		local random_towers = table.random_order(towers)

		for i, t in ipairs(random_towers) do
			if i > ba.count then
				break
			end

			local m = E:create_entity(ba.mod)

			m.modifier.target_id = t.id
			m.modifier.source_id = this.id

			queue_insert(store, m)
		end

		U.y_animation_wait(this)
		U.y_wait(store, ba.attack_duration - (store.tick_ts - start_ts))

		ba.ts = store.tick_ts

		if this.phase == "castle" then
			U.animation_start(this, "idleDown", nil, store.tick_ts, true)
		end
	end

	local function y_portal()
		local start_ts = store.tick_ts

		U.animation_start(this, pa.animation, nil, store.tick_ts)
		U.y_wait(store, pa.hit_time)
		S:queue(pa.sound)

		pa.count = pa.count + 1

		for _, p in pairs(portals) do
			if pa.portals[p.portal_idx] ~= 1 then
				-- block empty
			else
				p.spawn_signal = true
			end
		end

		U.y_animation_wait(this)
		U.y_wait(store, pa.attack_duration - (store.tick_ts - start_ts))

		pa.ts = store.tick_ts

		if this.phase == "castle" then
			U.animation_start(this, "idleDown", nil, store.tick_ts, true)
		end
	end

	local function signal_ready()
		return this.phase_signal
	end

	local function battle_started()
		return store.wave_group_number >= 1
	end

	local function ready_to_block()
		return not ba.disabled and store.tick_ts - ba.ts >= ba.cooldown
	end

	local function ready_to_portal()
		return not pa.disabled and store.tick_ts - pa.ts >= pa.cooldown and pa.count < pa.max_count
	end

	local function can_break_battle_walk()
		return ready_to_block() or ready_to_portal() or this.phase_signal
	end

	this.phase_signal = nil
	this.phase_signal = nil

	while not this.phase_signal do
		coroutine.yield()
	end

	this.phase = "welcome"

	for i, d in ipairs(this.taunts.sets.welcome.delays) do
		if U.y_wait(store, d, battle_started) then
			break
		end

		y_taunt(i)
	end

	while not battle_started() do
		coroutine.yield()
	end

	y_taunt(5)

	this.phase = "castle"

	local last_lives = store.lives
	local last_wave
	local taunt_cooldown = math.random(this.taunts.delay_min, this.taunts.delay_max)

	ba.ts = store.tick_ts
	pa.ts = store.tick_ts
	taunt_ts = store.tick_ts
	this.phase_signal = nil

	while not this.phase_signal do
		if store.wave_group_number ~= last_wave and not this.phase_signal then
			local ba_wave_data = ba.data[store.wave_group_number]

			ba.disabled = not ba_wave_data

			if not ba.disabled then
				ba.cooldown = ba_wave_data and ba_wave_data[1] or 0
				ba.count = ba_wave_data and ba_wave_data[2] or 0
			end

			local pa_wave_data = pa.data[store.wave_group_number]

			pa.disabled = not pa_wave_data

			if not pa.disabled then
				pa.cooldown, pa.max_count, pa.portals = unpack(pa_wave_data)
				pa.count = 0
			end

			last_wave = store.wave_group_number
		end

		if taunt_cooldown <= store.tick_ts - taunt_ts and not this.phase_signal then
			y_taunt(nil, last_lives > store.lives and "damage" or nil)

			last_lives = store.lives
			taunt_ts = store.tick_ts
			taunt_cooldown = math.random(this.taunts.delay_min, this.taunts.delay_max)
		end

		if ready_to_block() and not this.phase_signal then
			y_block_towers()
		end

		if ready_to_portal() and not this.phase_signal then
			y_portal()
		end

		coroutine.yield()
	end

	this.phase = "pre_battle"

	local battle_ts = store.tick_ts

	pa.cooldown = this.battle.pa_cooldown
	pa.max_count = this.battle.pa_max_count
	pa.animation = this.battle.pa_animation
	ba.animation = this.battle.ba_animation

	U.y_wait(store, fts(24))
	y_taunt()
	U.y_wait(store, battle_ts + fts(115) - store.tick_ts)
	U.y_animation_play(this, "walkAway", nil, store.tick_ts)

	this.nav_path.pi, this.nav_path.spi, this.nav_path.ni = 1, 1, 1
	this.pos = P:node_pos(this.nav_path)
	pa.ts = store.tick_ts
	ba.ts = store.tick_ts
	this.vis.bans = U.flag_clear(this.vis.bans, F_ALL)
	this.health.ignore_damage = false
	this.health_bar.hidden = nil
	this.phase_signal = nil
	this.phase = "battle"

	while not this.phase_signal do
		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if ready_to_block() and not this.phase_signal then
				y_block_towers()
			end

			if ready_to_portal() and not this.phase_signal then
				y_portal()
			end

			if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, can_break_battle_walk, can_break_battle_walk) then
				-- block empty
			else
				coroutine.yield()
			end
		end
	end

	this.health_bar.hidden = true
	this.vis.bans = U.flag_set(this.vis.bans, F_ALL)

	SU.remove_modifiers(store, this)
	S:queue(this.demon.transform_sound)
	U.y_animation_play(this, "demonTransform", nil, store.tick_ts, 1)

	this.enemy.melee_slot = this.demon.melee_slot
	this.health.hp = initial_hp
	this.health.hp_max = initial_hp
	this.health_bar.offset = this.demon.health_bar_offset
	this.health_bar.frames[1].bar_width = this.health_bar.frames[1].bar_width * this.demon.health_bar_scale
	this.health_bar.frames[2].bar_width = this.health_bar.frames[2].bar_width * this.demon.health_bar_scale
	this.health_bar.frames[1].scale.x = this.health_bar.frames[1].scale.x * this.demon.health_bar_scale
	this.health_bar.frames[2].scale.x = this.health_bar.frames[2].scale.x * this.demon.health_bar_scale
	this.melee.attacks[1].disabled = true
	this.melee.attacks[2].disabled = false
	this.ranged.attacks[1].disabled = true
	this.motion.max_speed = this.demon.speed
	this.render.sprites[1].prefix = this.demon.sprites_prefix
	this.ui.click_rect = this.demon.ui_click_rect
	this.unit.hit_offset = this.demon.unit_hit_offset
	this.unit.mod_offset = this.demon.unit_mod_offset
	this.unit.size = this.demon.unit_size
	this.info.portrait = this.demon.info_portrait
	this.health_bar.hidden = nil
	this.vis.bans = U.flag_clear(this.vis.bans, F_ALL)
	this.phase_signal = nil
	this.phase = "demon"

	while not this.phase_signal do
		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		elseif not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, signal_ready, signal_ready) then
			-- block empty
		else
			coroutine.yield()
		end
	end

	this.phase = "death"
	this.health_bar.hidden = true
	this.health.ignore_damage = true
	this.ui.can_click = false
	this.vis.bans = U.flag_set(this.vis.bans, F_ALL)

	SU.remove_modifiers(store, this)
	LU.kill_all_enemies(store, true)
	S:stop_all()
	S:queue(this.sound_events.death)
	signal.emit("boss-killed", this)
	U.animation_start(this, "death", nil, store.tick_ts, 1)
	signal.emit("hide-gui")
	U.y_wait(store, fts(110))
	LU.kill_all_enemies(store, true)

	local sc = E:create_entity(this.souls_aura)

	sc.pos = V.vclone(this.pos)
	sc.pos.y = sc.pos.y + 14

	queue_insert(store, sc)
	U.y_animation_wait(this)
	U.animation_start(this, "deathLoop", nil, store.tick_ts, true)
	U.y_wait(store, fts(90))

	sc.interrupt = true

	LU.kill_all_enemies(store, true)
	U.animation_start(this, "deathEnd", nil, store.tick_ts, true)

	local circle = E:create_entity(this.white_circle)

	circle.pos.x, circle.pos.y = this.pos.x + 6, this.pos.y + 12
	circle.tween.ts = store.tick_ts
	circle.render.sprites[1].ts = store.tick_ts

	queue_insert(store, circle)
	U.y_wait(store, fts(65) + 2)

	this.phase = "death-end"

	queue_remove(store, this)
end

scripts.mod_veznan_soul_drain = {}

function scripts.mod_veznan_soul_drain.insert(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and target.health and not target.health.dead then
		return true
	else
		return false
	end
end

function scripts.mod_veznan_soul_drain.update(this, store)
	local target
	local m = this.modifier

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead then
			queue_remove(store, this)

			return
		end
		
		local d = E:create_entity("damage")

				d.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_DISINTEGRATE_BOSS, DAMAGE_NO_DODGE)
				d.source_id = this.id
				d.target_id = target.id
				d.value = 10000

				queue_damage(store, d)
				
			queue_remove(store, this)

		coroutine.yield()
	end
end

function scripts.mod_veznan_soul_drain.remove(this, store, script)
	local m = this.modifier
	local t = store.entities[m.target_id]

	local bullet = E:create_entity(m.bullet)

					bullet.pos = t.pos
					bullet.bullet.from = V.vclone(bullet.pos)
					bullet.bullet.to = V.vclone(m.vez)
					bullet.bullet.target_id = t.id

					queue_insert(store, bullet)

	return true
end

scripts.eb_veznan_soul = {}

function scripts.eb_veznan_soul.insert(this, store)
	if this.extra_souls > 0 then
		local targets = U.find_soldiers_in_range(store.entities, this.bullet.to, 0, this.extra_souls_range, bor(F_RANGED, F_INSTAKILL), bor(F_FLYING, F_HERO, F_ENEMY), function(e)
			return e.id ~= this.bullet.target_id and not table.contains(this.excluded_templates, e.template_name)
		end)

		for i = 1, this.extra_souls do
			local b = E:clone_entity(this)

			b.extra_souls = 0

			if targets and targets[i] then
				local t = targets[i]

				b.bullet.target_id = t.id
				b.bullet.to = V.v(t.pos.x + t.unit.hit_offset.x, t.pos.y + t.unit.hit_offset.y)
			end

			queue_insert(store, b)
		end
	end

	return scripts.bolt_enemy.insert(this, store)
end

function scripts.eb_veznan_soul.update(this, store, script)
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
			local tpx, tpy = target.pos.x, target.pos.y

			if not b.ignore_hit_offset then
				tpx, tpy = tpx + target.unit.hit_offset.x, tpy + target.unit.hit_offset.y
			end

			local d = math.max(math.abs(tpx - b.to.x), math.abs(tpy - b.to.y))

			if d > b.max_track_distance or band(target.vis.bans, F_RANGED) ~= 0 or target.health.ignore_damage then
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
				m.modifier.source_id = this.id
				m.modifier.vez = V.vclone(this.bullet.from)

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
---帝国卫兵
scripts.tower_imperialguard_holder = {}

function scripts.tower_imperialguard_holder.get_info()
	local tpl = E:get_template("tower_imperialguard")
	local o = scripts.tower_barrack.get_info(tpl)

	o.respawn = nil

	return o
end
scripts.soldier_imper = {}

function scripts.soldier_imper.insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		for pn, p in pairs(this.powers) do
			if pn == "blade_mail" and p.level > 0 then
				this.health.spiked_armor = p.spiked_armor[p.level]
				this.render.sprites[2].hidden = nil
			end
		end

		return true
	end

	return false
end

function scripts.soldier_imper.update(this, store, script)
	local brk, sta
	local aura = this.render.sprites[2]

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

	while true do
		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					SU.soldier_power_upgrade(this, pn)

					if pn == "blade_mail" then
						this.health.spiked_armor = p.spiked_armor[p.level]
						aura.hidden = nil
					end
				end
			end
		end

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			aura.hidden = true

			SU.y_soldier_death(store, this)

			return
		end

		if this.cloak then
			this.vis.flags = band(this.vis.flags, bnot(this.cloak.flags))
			this.vis.bans = band(this.vis.bans, bnot(this.cloak.bans))
			this.render.sprites[1].alpha = 255
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			local barrack_list = {
				"soldier_militia",
					"soldier_footmen",
					"soldier_knight",
					"soldier_templar",
					"soldier_assassin",
			}
			--if table.contains(barrack_list,this.template_name) then
			SU.soldier_courage_upgrade(store, this)
			--end

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
					goto label_38_1
				end
			end

			if this.timed_actions then
				brk, sta = SU.y_soldier_timed_actions(store, this)

				if brk then
					goto label_38_1
				end
			end

			if this.timed_attacks then
				brk, sta = SU.y_soldier_timed_attacks(store, this)

				if brk then
					goto label_38_1
				end
			end

			if this.ranged and this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					goto label_38_1
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_38_1
				end
			end

			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk or sta == A_DONE then
					goto label_38_1
				elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
					goto label_38_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_38_1
			end

			::label_38_0::

			SU.soldier_idle(store, this)

			if this.cloak then
				this.vis.flags = bor(this.vis.flags, this.cloak.flags)
				this.vis.bans = bor(this.vis.bans, this.cloak.bans)

				if this.cloak.alpha then
					this.render.sprites[1].alpha = this.cloak.alpha
				end
			end

			SU.soldier_regen(store, this)
		end

		::label_38_1::

		coroutine.yield()
	end
end
---海盗大炮
scripts.tower_pirate_camp_re = {}

function scripts.tower_pirate_camp_re.get_info(this)
	local b = E:get_template("bomb_pirate_camp")
	local min, max = b.bullet.damage_min, b.bullet.damage_max
	
	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)
	
	local cooldown = 0
	local range = 9999
	
	return {
		desc = "TOWER_PIRATE_CAMP_DESCRIPTION",
		type = STATS_TYPE_TEXT,
		damage_min = min,
		damage_max = max,
		range = range,
		cooldown = cooldown
		
	}
end

function scripts.tower_pirate_camp_re.can_select_point(this, x, y)
	return P:valid_node_nearby(x, y)
end

function scripts.tower_pirate_camp_re.update(this, store, script)
	local cannon_sids = {
		5,
		6,
		7
	}
	local sign_cannon = this.render.sprites[3]
	local sign_tap_the_road = this.render.sprites[4]
	local sign_cannon_last_ts = store.tick_ts
	local pirate_drink_ts = store.tick_ts
	local pirate_drink_time = math.random(fts(100), fts(300))

	local function fire_animation(id)
		U.animation_start(this, "shoot", nil, store.tick_ts, false, cannon_sids[id])
	end

	local function add_bullet(id, dest)
		local a = this.attacks.list[1]
		local b = E:create_entity("bomb_pirate_camp")

		b.pos = V.v(dest.x + U.random_sign() * math.random(a.min_error, a.max_error), dest.y + U.random_sign() * math.random(a.min_error, a.max_error))
		b.bullet.to = b.pos

		queue_insert(store, b)
	end

	while true do
		if pirate_drink_time < store.tick_ts - pirate_drink_ts then
			U.animation_start(this, "drink", nil, store.tick_ts, false, 8)

			pirate_drink_ts = store.tick_ts
		end

		if this.user_selection.new_pos then
			local shots = this.user_selection.arg
			local dest = this.user_selection.new_pos

			this.user_selection.new_pos = nil

			local attack = this.attacks.list[shots]

			store.player_gold = store.player_gold - attack.price

			local decal = E:create_entity("decal_tower_pirate_camp_target")

			decal.pos = V.vclone(dest)
			decal.render.sprites[1].ts = store.tick_ts

			queue_insert(store, decal)

			local start_ts = store.tick_ts

			for i = 1, 3 do
				if i <= shots then
					fire_animation(i)
					U.y_wait(store, fts(5))
					S:queue("PirateBombShootSound")
				end
			end

			U.y_wait(store, fts(30) - (store.tick_ts - start_ts))

			for i = 1, 3 do
				if i <= shots then
					add_bullet(i, dest)
				end

				U.y_wait(store, fts(6))
			end

			U.y_animation_wait(this, cannon_sids[1])
		end

		coroutine.yield()
	end
end
---绿箭
scripts.tower_green_archer = {}

function scripts.tower_green_archer.get_info(this)
	local o = scripts.tower_common.get_info(this)

	o.damage_max = o.damage_max * 2
	o.damage_min = o.damage_min * 2

	return o
end

function scripts.tower_green_archer.insert(this, store)
	return true
end

function scripts.tower_green_archer.update(this, store)
	local shooter_sids = {
		3,
		4
	}
	local shooter_idx = 2
	local a = this.attacks
	local aa = this.attacks.list[1]
	local as = this.attacks.list[2]
	local az = this.attacks.list[3]
	local pow_s = this.powers.burst
	local pow_z = this.powers.slumber

	local function shot_animation(attack, shooter_idx, enemy)
		local ssid = shooter_sids[shooter_idx]
		local soffset = this.render.sprites[ssid].offset
		local s = this.render.sprites[ssid]
		local an, af = U.animation_name_facing_point(this, attack.animation, enemy.pos, ssid, soffset)

		U.animation_start(this, an, af, store.tick_ts, 1, ssid)
	end

	local function shot_bullet(attack, shooter_idx, enemy, level)
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
		b.bullet.damage_factor = this.tower.damage_factor

		if attack == as then
			b.extra_arrows = pow_s.extra_arrows[pow_s.level]
		end
		if attack == az then
			b.extra_arrows = pow_z.extra_arrows[pow_z.level]
		end

		local dist = V.dist(b.bullet.to.x, b.bullet.to.y, b.bullet.from.x, b.bullet.from.y)

		b.bullet.flight_time = b.bullet.flight_time_min + dist / a.range * b.bullet.flight_time_factor

		local u = UP:get_upgrade("archer_el_obsidian_heads")

		if u and enemy.health and enemy.health.armor == 0 then
			b.bullet.damage_min = b.bullet.damage_max
		end

		queue_insert(store, b)
	end

	aa.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			for k, pow in pairs(this.powers) do
				local sa = this.attacks.list[pow.attack_idx]

				if pow.changed then
					pow.changed = nil

					if pow.level == 1 then
						sa.ts = store.tick_ts
					end
				end

				if pow.level < 1 or store.tick_ts - sa.ts < sa.cooldown + pow.level * sa.cooldown_inc then
					-- block empty
				else
					local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, sa.vis_flags, sa.vis_bans)

					if not enemy then
						-- block empty
					else
						sa.ts = store.tick_ts
						shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)

						shot_animation(sa, shooter_idx, enemy)

						while store.tick_ts - sa.ts < sa.shoot_time do
							coroutine.yield()
						end

						if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range * 1.1 then
							shot_bullet(sa, shooter_idx, enemy, pow.level)
						end

						U.y_animation_wait(this, shooter_sids[shooter_idx])
					end
				end
			end

			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

				if not enemy then
					-- block empty
				else
					aa.ts = store.tick_ts

					for i = 1, #shooter_sids do
						shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)
						enemy = enemies[km.zmod(shooter_idx, #enemies)]

						shot_animation(aa, shooter_idx, enemy)

						if i == 1 then
							U.y_wait(store, aa.shooters_delay)
						end
					end

					while store.tick_ts - aa.ts < aa.shoot_time do
						coroutine.yield()
					end

					for i = 1, #shooter_sids do
						shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)
						enemy = enemies[km.zmod(shooter_idx, #enemies)]

						if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
							shot_bullet(aa, shooter_idx, enemy, 0)
						end

						if i == 1 then
							U.y_wait(store, aa.shooters_delay)
						end
					end

					U.y_animation_wait(this, shooter_sids[shooter_idx])
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
scripts.arrow_green = {}

function scripts.arrow_green.insert(this, store)
	if this.extra_arrows > 0 then
		local targets = U.find_enemies_in_range(store.entities, this.bullet.to, 0, this.extra_arrows_range, F_RANGED, F_NONE, function(e)
			return e.id ~= this.bullet.target_id
		end)
		if targets then
		for i = 1, this.extra_arrows do
			if targets[i] then
			local b = E:clone_entity(this)

			b.extra_arrows = 0

			if targets and targets[i] then
				local t = targets[i]

				b.bullet.target_id = t.id
				b.bullet.to = V.v(t.pos.x + t.unit.hit_offset.x, t.pos.y + t.unit.hit_offset.y)
			end

			queue_insert(store, b)
		end
		end
		end
	end

	return scripts.arrow.insert(this, store)
end
scripts.arrow_green_tower_green_archer = {}

function scripts.arrow_green_tower_green_archer.insert(this, store)
	if this.extra_arrows > 0 then
		local targets = U.find_enemies_in_range(store.entities, this.bullet.to, 0, this.extra_arrows_range, F_RANGED, F_NONE, function(e)
			return e.id ~= this.bullet.target_id
		end)

		for i = 1, this.extra_arrows do
			local b = E:clone_entity(this)

			b.extra_arrows = 0

			if targets and targets[i] then
				local t = targets[i]

				b.bullet.target_id = t.id
				b.bullet.to = V.vclone(t.pos)
			end

			queue_insert(store, b)
		end
	end

	return scripts.arrow.insert(this, store)
end
---
scripts.mod_damage_factors2 = {
	insert = function (this, store, script)
		local target = store.entities[this.modifier.target_id]

		if not target or target.health.dead or not target.unit and band(this.modifier.vis_flags, target.vis.bans) ~= 0 then
			return false
		end

		if this.received_damage_factor then
			target.health.damage_factor = target.health.damage_factor*this.received_damage_factor
		end

		if this.inflicted_damage_factor then
			target.unit.damage_factor = target.unit.damage_factor*this.inflicted_damage_factor
		end

		if this.render then
			for _, s in pairs(this.render.sprites) do
				s.ts = store.tick_ts

				if s.size_names then
					s.name = s.size_names[target.unit.size]
				end

				if s.size_scales then
					s.scale = s.size_scales[target.unit.size]
				end
			end
		end

		signal.emit("mod-applied", this, target)

		return true
	end
}
---精英阿渥克
scripts.tower_ewok = {}
function scripts.tower_ewok.update(this, store, script)
	local tower_sid = 2
	local door_sid = 5
	local at = this.attacks
	local a = this.attacks.list[1]
	local shooter_sprite_ids = table.slice({
		3,
		4,
	}, 1, #a.bullet_start_offset)
	local last_target_pos = V.v(0, 0)
	
	a.ts = store.tick_ts	

	local pow_plant = this.powers.plant_magic_blossom
	local plants = pow_plant.plants

	for i, pos in ipairs(pow_plant.pos) do
		pos.x = pos.x + this.pos.x
		pos.y = pos.y + this.pos.y
	end

	while true do

		if pow_plant.changed then
			pow_plant.changed = nil

			for i = 1, pow_plant.level do
				if not plants[i] then
					local plant = E:create_entity(pow_plant.template)

					plant.pos = V.vclone(pow_plant.pos[i])
					plant.owner = this
					plants[i] = plant

					queue_insert(store, plant)
				end
			end
		end		

		local b = this.barrack

		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					if p == this.powers.tear  then
						for _, s in pairs(b.soldiers) do
							s.powers[pn].level = p.level
							s.powers[pn].changed = true
						end
					end
					if p == this.powers.shield then
						for _, s in pairs(b.soldiers) do
							s.powers[pn].level = p.level
							s.powers[pn].changed = true
						end
					end
					if p == this.powers.armor then
						for _, s in pairs(b.soldiers) do
							s.powers[pn].level = p.level
							s.powers[pn].changed = true
						end
					end										
				end
			end
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

					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.id
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers)
					s.nav_rally.new = true

					if this.powers then
						for pn, p in pairs(this.powers) do
							if p == this.powers.tear and p.level > 0 then
								s.powers[pn].level = p.level
								s.powers[pn].changed = true
							end	
							if p == this.powers.shield and p.level > 0 then
								s.powers[pn].level = p.level
								s.powers[pn].changed = true
							end	
							if p == this.powers.armor and p.level > 0 then
								s.powers[pn].level = p.level
								s.powers[pn].changed = true
							end	
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
		local enemy

		if this.tower.blocked then
			-- block empty
		elseif store.tick_ts - a.ts < a.cooldown then
			-- block empty
		else
			enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

			if enemy then
				a.ts = store.tick_ts
				a.count = a.count + 1

				local shooter_idx = a.count % #a.bullet_start_offset + 1
				local shooter_sid = shooter_sprite_ids[shooter_idx]
				local start_offset = a.bullet_start_offset[shooter_idx]
				local s = this.render.sprites[shooter_sid]
				local an, af = U.animation_name_facing_point(this, "shoot", enemy.pos, shooter_sid, start_offset)

				U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

				last_target_pos = enemy.pos

				while store.tick_ts - a.ts < a.shoot_time do
					coroutine.yield()
				end

				if U.is_inside_ellipse(tpos(this), enemy.pos, at.range) then
					local bullet = E:create_entity(a.bullet)

					bullet.bullet.damage_factor = this.tower.damage_factor
					bullet.pos.x, bullet.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
					bullet.bullet.from = V.vclone(bullet.pos)
					bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
					bullet.bullet.target_id = enemy.id

					if bullet.bullet.flight_time_min and bullet.bullet.flight_time_factor then
						local dist = V.dist(bullet.bullet.to.x, bullet.bullet.to.y, bullet.bullet.from.x, bullet.bullet.from.y)

						bullet.bullet.flight_time = bullet.bullet.flight_time_min + dist / at.range * bullet.bullet.flight_time_factor
					end

					local u = UP:get_upgrade("archer_el_obsidian_heads")
					local table_g3 = {"arrow_1",
					"arrow_2",
					"arrow_3",
					"arrow_arcane",
					"arrow_arcane_burst",
					"arrow_arcane_slumber",
					"arrow_silver",
					"arrow_silver_long",
					"arrow_silver_mark",
					"arrow_silver_mark_long",
					---
					"arrow_ground_archer",
					"spear_ewok",
				    "arrow_green_archer",}
					if u and enemy.health and enemy.health.armor == 0 and table.contains(table_g3, a.bullet) then
						--print("apply g3")
						bullet.bullet.damage_min = bullet.bullet.damage_max
					end

					u = UP:get_upgrade("archer_precision")
					local table_g1 = {"g1_arrow_1",
					"g1_arrow_2",
					"g1_arrow_3",
					"arrow_ranger",
					"shotgun_musketeer",
					"shotgun_musketeer_sniper"}
					if u and math.random() < u.chance and table.contains(table_g1, a.bullet) then
						--print("apply g1")
						bullet.bullet.damage_min = bullet.bullet.damage_min * u.damage_factor
						bullet.bullet.damage_max = bullet.bullet.damage_max * u.damage_factor
						bullet.bullet.pop = {
							"pop_crit"
						}
						bullet.bullet.pop_conds = DR_DAMAGE
					end

					queue_insert(store, bullet)

					u = UP:get_upgrade("archer_twin_shot")
					local table_g2 = {
						"g2_arrow_1",
						"g2_arrow_2",
						"g2_arrow_3",
						"arrow_crossbow",
						"axe_totem",
						"arrow_hammerhold_elite",
						"arrow_hammerhold_split"
					}
					if u and math.random() < u.chance and table.contains(table_g2, a.bullet) then
						--print("apply g2")
						local b2 = E:clone_entity(bullet)

						b2.bullet.flight_time = b2.bullet.flight_time - 1 / FPS

						queue_insert(store, b2)

						bullet.bullet.flight_time = bullet.bullet.flight_time + 1 / FPS
					end
				end

				while not U.animation_finished(this, shooter_sid) do
					coroutine.yield()
				end

				an, af = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid, start_offset)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end

			if store.tick_ts - a.ts > this.tower.long_idle_cooldown then
				for _, sid in pairs(shooter_sprite_ids) do
					local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, sid)

					U.animation_start(this, an, af, store.tick_ts, -1, sid)
				end
			end
		end		

		coroutine.yield()
	end
end
-- 恢复生命值
scripts.heal = function(this, amount)
    this.health.hp = this.health.hp + amount
    if this.health.hp > this.health.hp_max then
        this.health.hp = this.health.hp_max
    end
end
scripts.soldier_ewok_re = {}

function scripts.soldier_ewok_re.update(this, store)
    local brk, sta

    if this.vis._bans then
        this.vis.bans = this.vis._bans
        this.vis._bans = nil
    end

    while true do
        for pn, p in pairs(this.powers) do
            if p.changed then
                p.changed = nil
                SU.soldier_power_upgrade(this, pn)
            end
        end

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			SU.y_soldier_death(store, this)

			return
		end
--[[
        if this.health.dead then
            SU.y_soldier_death(store, this)
            return
        end
]]--
        if this.unit.is_stunned then
            SU.soldier_idle(store, this)
        else
            if this.dodge and this.dodge.active then
                local start_ts = store.tick_ts

                U.y_animation_play(this, this.dodge.animation_start, nil, store.tick_ts, 1)

                this.dodge.last_hit_ts = nil
                this.health.immune_to = F_ALL
                scripts.heal(this, this.dodge.heal)
                while store.tick_ts - start_ts < this.dodge.duration and not this.health.dead and
                    not this.unit.is_stunned do
                    SU.soldier_regen(store, this)

                    if this.dodge.last_hit_ts then
                        U.y_animation_play(this, this.dodge.animation_hit, nil, store.tick_ts, 1)

                        this.dodge.last_hit_ts = nil
                    end

                    coroutine.yield()
                end

                U.y_animation_play(this, this.dodge.animation_end, nil, store.tick_ts, 1)

                this.dodge.active = false
                this.health.immune_to = 0
                this.dodge.ts = store.tick_ts

                goto label_519_1
            end

            while this.nav_rally.new do
                if SU.y_soldier_new_rally(store, this) then
                    goto label_519_1
                end
            end

            brk, sta = SU.y_soldier_ranged_attacks(store, this)

            if brk then
                goto label_519_1
            end

            brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

            if brk or sta ~= A_NO_TARGET then
                goto label_519_1
            end

            brk, sta = SU.y_soldier_ranged_attacks(store, this)

            if brk or sta == A_DONE then
                goto label_519_1
            elseif sta == A_IN_COOLDOWN then
                goto label_519_0
            end

            if SU.soldier_go_back_step(store, this) then
                goto label_519_1
            end

            ::label_519_0::

            SU.soldier_idle(store, this)
            SU.soldier_regen(store, this)
        end

        ::label_519_1::

        coroutine.yield()
    end
end
---魔法阿渥克
scripts.plant_magic_blossom_ewok = {}

function scripts.plant_magic_blossom_ewok.update(this, store)
	local ca = this.custom_attack
	local fx_loading = E:create_entity("fx_plant_magic_blossom_loading")
	local fx_idle1 = E:create_entity("fx_plant_magic_blossom_idle1")
	local fx_idle2 = E:create_entity("fx_plant_magic_blossom_idle2")

	fx_loading.pos.x, fx_loading.pos.y = this.pos.x, this.pos.y
	fx_idle1.pos.x, fx_idle1.pos.y = this.pos.x, this.pos.y
	fx_idle2.pos.x, fx_idle2.pos.y = this.pos.x, this.pos.y

	queue_insert(store, fx_loading)
	queue_insert(store, fx_idle1)
	queue_insert(store, fx_idle2)

	::label_411_0::

	fx_loading.render.sprites[1].hidden = true
	fx_idle1.render.sprites[1].hidden = true
	fx_idle2.render.sprites[1].hidden = true

	U.animation_start(this, "loading", nil, store.tick_ts, true)

	while (this.plant.blocked or store.wave_group_number < 1) and not this.force_ready do
		coroutine.yield()
	end

	::label_411_1::

	fx_loading.render.sprites[1].hidden = false
	fx_idle1.render.sprites[1].hidden = true
	fx_idle2.render.sprites[1].hidden = true

	U.animation_start(this, "loading", nil, store.tick_ts, true)

	ca.ts = store.tick_ts

	while store.tick_ts - ca.ts < ca.cooldown and not this.force_ready do
		if this.is_removed then
			break
		end

		if this.plant.blocked then
			goto label_411_0
		end

		coroutine.yield()
	end

	fx_loading.render.sprites[1].hidden = true

	U.y_animation_play(this, "ready", nil, store.tick_ts)

	fx_idle1.render.sprites[1].hidden = false
	fx_idle2.render.sprites[1].hidden = false
	this.force_ready = nil

	U.animation_start(this, "idle", nil, store.tick_ts, true)

	this.ui.clicked = nil

	while true do
		if this.is_removed then
			break
		end

		if this.plant.blocked then
			goto label_411_0
		end

		if this.ui.clicked then
			this.ui.clicked = nil

			S:queue(ca.sound)
			U.animation_start(this, "shoot", nil, store.tick_ts, false)
			U.y_wait(store, ca.shoot_time)

			local first, targets = U.find_foremost_enemy(store.entities, this.pos, 0, ca.range, true, ca.vis_flags, ca.vis_bans)

			for i = 1, ca.bullet_count do
				local b = E:create_entity(ca.bullet)

				b.bullet.shot_index = i
				b.bullet.source_id = this.id
				b.pos.x, b.pos.y = this.pos.x + ca.bullet_start_offset.x, this.pos.y + ca.bullet_start_offset.y
				b.bullet.from = V.vclone(b.pos)

				if targets and #targets > 0 then
					local target

					if i <= #targets then
						target = targets[i]
					else
						target = first
					end

					b.bullet.target_id = target.id
					b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
				else
					b.bullet.to = V.v(this.pos.x + ca.bullet_start_offset.x + math.random(-50, 50), this.pos.y + ca.bullet_start_offset.y + math.random(30, 100))
				end

				b.initial_impulse_angle_abs = math.pi / 2 + U.frandom(-math.pi / 2, math.pi / 2)
				b.initial_impulse = U.frandom(0.3, 1) * b.initial_impulse

				queue_insert(store, b)
			end

			U.y_animation_wait(this)

			goto label_411_1
		end

		coroutine.yield()
	end

	queue_remove(store, fx_loading)
	queue_remove(store, fx_idle1)
	queue_remove(store, fx_idle2)
	queue_remove(store, this)
end
---魔法侏儒花园
scripts.tower_pixie_re = {}

function scripts.tower_pixie_re.remove(this, store)
	local pow_plant = this.powers.plant_poison

	for i, p in ipairs(pow_plant.plants) do
		queue_remove(store, p)

		for _, f in ipairs(p.fxs_idle) do
			queue_remove(store, f)
		end
	end

	if this.pixies then
		for _, e in pairs(this.pixies) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_pixie_re.get_info(this)
	return {
		type = STATS_TYPE_TOWER,
		damage_min = 0,
		damage_max = 0,
		range = this.attacks.range,
		cooldown = this.attacks.pixie_cooldown / this.powers.cream.level
	}
end

function scripts.tower_pixie_re.update(this, store)
	local a = this.attacks

	a.ts = store.tick_ts

	local pow_c = this.powers.cream
	local pow_t = this.powers.total
	local pow_plant = this.powers.plant_poison
	local plants = pow_plant.plants
	local available_paths = {}
	local enemy_cooldowns = {}

	this.pixies = {}
---new
	for k, v in pairs(P.paths) do
		table.insert(available_paths, k)
	end

	if store.level.ignore_walk_backwards_paths then
		available_paths = table.filter(available_paths, function(k, v)
			return not table.contains(store.level.ignore_walk_backwards_paths, v)
		end)
	end

	local posAndDist2 = {}

	for i, pos in ipairs(pow_plant.pos) do
		pos.x = pos.x + this.pos.x
		pos.y = pos.y + this.pos.y

		local nearest = P:nearest_nodes(pos.x, pos.y, available_paths, nil, true)
		local pi, spi, ni = unpack(nearest[1])

		spi = 1

		local nodePos = P:node_pos(pi, spi, ni)
		local d2 = V.dist2(pos.x, pos.y, nodePos.x, nodePos.y)
		local e = {}

		e.pos = pos
		e.d2 = d2

		table.insert(posAndDist2, e)
	end

	table.sort(posAndDist2, function(e1, e2)
		return e1.d2 < e2.d2
	end)

	for i = 1, #posAndDist2 do
		pow_plant.pos[i] = posAndDist2[i].pos
	end	
---
	local function spawn_pixie()
		local e = E:create_entity("decal_pixie")
		local po = pow_c.idle_offsets[#this.pixies + 1]

		e.idle_pos = po
		e.pos.x, e.pos.y = this.pos.x + po.x, this.pos.y + po.y
		e.owner = this

		table.insert(this.pixies, e)
		queue_insert(store, e)
	end

	spawn_pixie()

	while true do
		if this.tower.blocked then
			-- block empty
		else
			if pow_c.changed and #this.pixies < 3 then
				pow_c.changed = nil

				spawn_pixie()
			end

			if pow_t.changed then
				pow_t.changed = nil

				for i, ch in ipairs(pow_t.chances) do
					a.list[i].chance = ch[pow_t.level]
				end
			end

			if pow_plant.changed then
				pow_plant.changed = nil

				for i = 1, pow_plant.level do
					if not plants[i] then
						local plant = E:create_entity(pow_plant.template)

						plant.pos = V.vclone(pow_plant.pos[i])
						plant.force_ready = true
						plants[i] = plant

						queue_insert(store, plant)
					end
				end
			end

			for k, v in pairs(enemy_cooldowns) do
				if v <= store.tick_ts then
					enemy_cooldowns[k] = nil
				end
			end

			if store.tick_ts - a.ts > a.cooldown then
				for _, pixie in pairs(this.pixies) do
					local target, attack
					local rnd, acc = math.random(), 0

					if pixie.target or store.tick_ts - pixie.attack_ts <= a.pixie_cooldown then
						-- block empty
					else
						for ii, aa in ipairs(a.list) do
							if aa.chance > 0 and rnd <= aa.chance + acc then
								attack = aa

								break
							else
								acc = acc + aa.chance
							end
						end

						if not attack then
							-- block empty
						else
							target = U.find_random_enemy(store.entities, this.pos, 0, a.range, attack.vis_flags, attack.vis_bans, function(e)
								return not table.contains(a.excluded_templates, e.template_name) and not enemy_cooldowns[e.id] and (not attack.check_gold_bag or e.enemy.gold_bag > 0)
							end)

							if not target then
								-- block empty
							else
								enemy_cooldowns[target.id] = store.tick_ts + a.enemy_cooldown
								pixie.attack_ts = store.tick_ts
								pixie.target_id = target.id
								pixie.attack = attack
								pixie.attack_level = pow_t.level
								a.ts = store.tick_ts

								break
							end
						end
					end
				end
			end
		end

		coroutine.yield()
	end
end
scripts.plant_poison_pumpkin_pixie = {}

function scripts.plant_poison_pumpkin_pixie.update(this, store)
	local smokes1 = {
		{
			"left",
			-74,
			21,
			false,
			false
		},
		{
			"left",
			75,
			20,
			true,
			false
		},
		{
			"down",
			-4,
			-18,
			false,
			false
		},
		{
			"down",
			-4,
			62,
			false,
			true
		}
	}
	local smokes2 = {
		{
			"fill",
			24,
			0,
			false,
			false
		},
		{
			"fill",
			29,
			42,
			false,
			false
		},
		{
			"fill",
			-34,
			43,
			true,
			false
		},
		{
			"fill",
			-34,
			0,
			true,
			false
		}
	}
	local smokes3 = {
		{
			"fill",
			48,
			-4,
			false,
			false
		},
		{
			"fill",
			45,
			52,
			false,
			false
		},
		{
			"fill",
			-43,
			-3,
			true,
			false
		},
		{
			"fill",
			-45,
			56,
			true,
			false
		}
	}

	local function add_smokes(t)
		for _, item in pairs(t) do
			local name, x, y, flip_x, flip_y = unpack(item)
			local fx = E:create_entity("fx_plant_poison_pumpkin_smoke_" .. name)

			fx.pos.x, fx.pos.y = this.pos.x + x, this.pos.y + y
			fx.render.sprites[1].flip_x = flip_x
			fx.render.sprites[1].flip_y = flip_y
			fx.render.sprites[1].ts = store.tick_ts

			if name == "fill" and flip_x then
				fx.tween.props[3].keys[2][2].x = -1 * fx.tween.props[3].keys[2][2].x
				fx.tween.props[3].keys[3][2].x = -1 * fx.tween.props[3].keys[3][2].x
			end

			queue_insert(store, fx)
		end
	end

	local ca = this.custom_attack
	local fx_idle_l = E:create_entity("fx_plant_poison_pumpkin_idle")
	local fx_idle_c = E:create_entity("fx_plant_poison_pumpkin_idle")
	local fx_idle_r = E:create_entity("fx_plant_poison_pumpkin_idle")

	fx_idle_l.pos.x, fx_idle_l.pos.y = this.pos.x, this.pos.y
	fx_idle_c.pos.x, fx_idle_c.pos.y = this.pos.x, this.pos.y
	fx_idle_r.pos.x, fx_idle_r.pos.y = this.pos.x, this.pos.y
	fx_idle_l.render.sprites[1].offset = V.v(-30, 30)
	fx_idle_c.render.sprites[1].offset = V.v(-5, 28)
	fx_idle_r.render.sprites[1].offset = V.v(32, 30)
	fx_idle_l.render.sprites[1].flip_x = true
	fx_idle_c.render.sprites[1].flip_x = true

	queue_insert(store, fx_idle_l)
	queue_insert(store, fx_idle_c)
	queue_insert(store, fx_idle_r)

	this.fxs_idle = {
		fx_idle_l,
		fx_idle_c,
		fx_idle_r
	}

	local fxs_idle = this.fxs_idle

	::label_412_0::

	for _, fx in pairs(fxs_idle) do
		fx.render.sprites[1].hidden = true
	end

	U.animation_start(this, "loading", nil, store.tick_ts, true)

	while this.plant.blocked and not this.force_ready do
		coroutine.yield()
	end

	::label_412_1::

	for _, fx in pairs(fxs_idle) do
		fx.render.sprites[1].hidden = true
	end

	U.animation_start(this, "loading", nil, store.tick_ts, true)

	ca.ts = store.tick_ts

	while store.tick_ts - ca.ts < ca.cooldown and not this.force_ready do
		if this.plant.blocked then
			goto label_412_0
		end

		coroutine.yield()
	end

	S:queue("VenomPlantReady")
	U.y_animation_play(this, "ready", nil, store.tick_ts)

	for _, fx in pairs(fxs_idle) do
		fx.render.sprites[1].hidden = nil
	end

	this.force_ready = nil

	U.animation_start(this, "idle", nil, store.tick_ts, true)

	this.ui.clicked = nil

	while true do
		if this.plant.blocked then
			goto label_412_0
		end

		if this.ui.clicked then
			this.ui.clicked = nil

			S:queue(ca.sound)
			U.animation_start(this, "shoot", nil, store.tick_ts, false)

			for _, fx in pairs(fxs_idle) do
				fx.render.sprites[1].hidden = true
			end

			U.y_wait(store, fts(9))
			add_smokes(smokes1)
			U.y_wait(store, fts(6))
			add_smokes(smokes2)
			U.y_wait(store, fts(2))
			add_smokes(smokes3)

			local first, targets = U.find_foremost_enemy(store.entities, this.pos, 0, ca.range, false, ca.vis_flags, ca.vis_bans)

			if first then
				for _, target in pairs(targets) do
					for _, mod_name in pairs(ca.mods) do
						local m = E:create_entity(mod_name)

						m.modifier.target_id = target.id
						m.modifier.source_id = this.id

						queue_insert(store, m)
					end
				end
			end

			U.y_animation_wait(this)

			goto label_412_1
		end

		coroutine.yield()
	end

	for _, fx in pairs(fxs_idle) do
		queue_remove(store, fx)
	end

	queue_remove(store, this)
end
---仙女龙
scripts.tower_faerie_dragon_re = {}
function scripts.tower_faerie_dragon_re.remove(this, store)
	local pow_plant = this.powers.plant_poison

	for i, p in ipairs(pow_plant.plants) do
		queue_remove(store, p)

--		for _, f in ipairs(p.fxs_idle) do
--			queue_remove(store, f)
--		end
	end

	if this.dragons then
		for _, e in pairs(this.dragons) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_faerie_dragon_re.update(this, store)
	local a = this.attacks.list[1]
	local pow_m = this.powers.more_dragons
	local pow_i = this.powers.improve_shot
	local pow_plant = this.powers.plant_poison
	local plants = pow_plant.plants
	local available_paths = {}

	for k, v in pairs(P.paths) do
		table.insert(available_paths, k)
	end

	if store.level.ignore_walk_backwards_paths then
		available_paths = table.filter(available_paths, function(k, v)
			return not table.contains(store.level.ignore_walk_backwards_paths, v)
		end)
	end

	local posAndDist2 = {}

	for i, pos in ipairs(pow_plant.pos) do
		pos.x = pos.x + this.pos.x
		pos.y = pos.y + this.pos.y

		local nearest = P:nearest_nodes(pos.x, pos.y, available_paths, nil, true)
		local pi, spi, ni = unpack(nearest[1])

		spi = 1

		local nodePos = P:node_pos(pi, spi, ni)
		local d2 = V.dist2(pos.x, pos.y, nodePos.x, nodePos.y)
		local e = {}

		e.pos = pos
		e.d2 = d2

		table.insert(posAndDist2, e)
	end

	table.sort(posAndDist2, function(e1, e2)
		return e1.d2 < e2.d2
	end)

	for i = 1, #posAndDist2 do
		pow_plant.pos[i] = posAndDist2[i].pos
	end	
	
	this.dragons = {}
	local egg_sids = {
		3,
		4
	}

	while true do


		if this.tower.blocked then
			-- block empty
		else
			if pow_m.changed and #this.dragons < 2 then
				pow_m.changed = nil

				log.debug("pow_m:%s", getdump(pow_m))

				local egg_sid = egg_sids[pow_m.level]
				local egg_s = this.render.sprites[egg_sid]

				U.animation_start(this, "open", nil, store.tick_ts, false, egg_sid)
				U.y_wait(store, fts(5))

				local o = pow_m.idle_offsets[pow_m.level]
				local e = E:create_entity("faerie_dragon")

				e.idle_pos = 0
				e.pos.x, e.pos.y = this.pos.x + o.x, this.pos.y + o.y
				e.idle_pos = V.vclone(e.pos)
				
				queue_insert(store, e)
				table.insert(this.dragons, e)
				e.owner = this
			end
			
			if pow_plant.changed then
				pow_plant.changed = nil

				for i = 1, pow_plant.level do
					if not plants[i] then
						local plant = E:create_entity(pow_plant.template)

						plant.pos = V.vclone(pow_plant.pos[i])
						plant.force_ready = true
						plants[i] = plant

						queue_insert(store, plant)
					end
				end
			end

			if pow_i.changed then
				pow_i.changed = nil
			end

			if #this.dragons > 0 and store.tick - a.ts > a.cooldown then
				a.ts = store.tick_ts

				local assigned_target_ids = {}

				for _, dragon in pairs(this.dragons) do
					if dragon.custom_attack.target_id then
						table.insert(assigned_target_ids, dragon.custom_attack.target_id)
					end
				end

				for _, dragon in pairs(this.dragons) do
					if dragon.custom_attack.target_id then
						-- block empty
					else
						local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.attacks.range, a.vis_flags, a.vis_bans, function(e)
							return not table.contains(assigned_target_ids, e.id)
						end)

						if not targets then
							goto label_539_0
						end

						table.sort(targets, function(e1, e2)
							local f1 = e1.unit.is_stunned
							local f2 = e2.unit.is_stunned

							if f1 ~= 0 then
								return false
							end

							if f2 ~= 0 then
								return true
							end

							return V.dist(e1.pos.x, e1.pos.y, origin.x, origin.y) < V.dist(e2.pos.x, e2.pos.y, origin.x, origin.y)
						end)

						dragon.custom_attack.target_id = targets[1].id

						table.insert(assigned_target_ids, targets[1].id)
					end
				end
			end
					
		end

		::label_539_0::

		coroutine.yield()
	end
end
---野蛮人巢穴
scripts.tower_barrack_canibal = {}
--[[
function scripts.tower_barrack_canibal.update(this, store, script)
	local b = this.barrack
	local door_sid = this.render.door_sid or 2

	if this.tower_upgrade_persistent_data.max_soldiers then
		b.max_soldiers = this.tower_upgrade_persistent_data.max_soldiers
	end

	local pow_plant = this.powers.carnivorous_plant
	local plants = pow_plant.plants
	local available_paths = {}

	for k, v in pairs(P.paths) do
		table.insert(available_paths, k)
	end

	if store.level.ignore_walk_backwards_paths then
		available_paths = table.filter(available_paths, function(k, v)
			return not table.contains(store.level.ignore_walk_backwards_paths, v)
		end)
	end

	local posAndDist2 = {}

	for i, pos in ipairs(pow_plant.pos) do
		pos.x = pos.x + this.pos.x
		pos.y = pos.y + this.pos.y

		local nearest = P:nearest_nodes(pos.x, pos.y, available_paths, nil, true)
		local pi, spi, ni = unpack(nearest[1])

		spi = 1

		local nodePos = P:node_pos(pi, spi, ni)
		local d2 = V.dist2(pos.x, pos.y, nodePos.x, nodePos.y)
		local e = {}

		e.pos = pos
		e.d2 = d2

		table.insert(posAndDist2, e)
	end

	table.sort(posAndDist2, function(e1, e2)
		return e1.d2 < e2.d2
	end)

	for i = 1, #posAndDist2 do
		pow_plant.pos[i] = posAndDist2[i].pos
	end

	while true do
		if pow_plant.changed then
			pow_plant.changed = nil

			for i = 1, pow_plant.level do
				if not plants[i] then
					local plant = E:create_entity(pow_plant.template)

					plant.pos = V.vclone(pow_plant.pos[i])
					plant.owner = this
					plants[i] = plant

					queue_insert(store, plant)
				end
			end
		end

		local old_count = #b.soldiers

		b.soldiers = table.filter(b.soldiers, function(_, s)
			return store.entities[s.id] ~= nil
		end)

		if #b.soldiers > 0 and #b.soldiers ~= old_count then
			for i, s in ipairs(b.soldiers) do
				s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, b.rally_angle_offset)
			end
		end

		if b.unit_bought then
			b.max_soldiers = b.max_soldiers + 1
			this.tower_upgrade_persistent_data.max_soldiers = b.max_soldiers

			for i, ss in ipairs(b.soldiers) do
				ss.nav_rally.pos, ss.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, b.rally_angle_offset)
			end

			b.unit_bought = nil

			local price = E:get_template(b.soldier_type).unit.price[this.barrack.max_soldiers]

			store.player_gold = store.player_gold - price
		end

		if b.rally_new then
			b.rally_new = false

			signal.emit("rally-point-changed", this)

			local sounds = {}
			local all_dead = true

			for i, s in ipairs(b.soldiers) do
				s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, b.rally_angle_offset)
				s.nav_rally.new = true

				if s.sound_events.change_rally_point then
					table.insert(sounds, s.sound_events.change_rally_point)
				end

				all_dead = all_dead and s.health.dead
			end

			if not all_dead then
				if #sounds > 0 then
					S:queue(sounds[math.random(1, #sounds)])
				else
					S:queue(this.sound_events.change_rally_point)
				end
			end
		end

		if not this.tower.blocked then
			for i = 1, this.barrack.max_soldiers do
				local s = b.soldiers[i]

				if not s or s.health.dead and not store.entities[s.id] then
					if b.has_door and not b.door_open then
						U.animation_start(this, "open", nil, store.tick_ts, false, door_sid)
						U.y_animation_wait(this, door_sid)

						b.door_open = true
						b.door_open_ts = store.tick_ts
					end

					S:queue(this.spawn_sound)

					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.id
					s.soldier.tower_soldier_idx = i
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, b.rally_angle_offset)
					s.nav_rally.new = true
					s.render.sprites[1].flip_x = true
					s.spawned_from_tower = true

					queue_insert(store, s)

					b.soldiers[i] = s
				end
			end
		end

		if b.has_door and b.door_open and store.tick_ts - b.door_open_ts > b.door_hold_time then
			U.animation_start(this, "close", nil, store.tick_ts, false, door_sid)
			U.y_animation_wait(this, door_sid)

			b.door_open = false
		end

		coroutine.yield()
	end
end
]]--
function scripts.tower_barrack_canibal.update(this, store, script)
	local tower_sid = 2
	local door_sid = 3

	local pow_plant = this.powers.carnivorous_plant
	local plants = pow_plant.plants

	for i, pos in ipairs(pow_plant.pos) do
		pos.x = pos.x + this.pos.x
		pos.y = pos.y + this.pos.y
	end
	
	while true do
		if pow_plant.changed then
			pow_plant.changed = nil

			for i = 1, pow_plant.level do
				if not plants[i] then
					local plant = E:create_entity(pow_plant.template)

					plant.pos = V.vclone(pow_plant.pos[i])
					plant.owner = this
					plants[i] = plant

					queue_insert(store, plant)
				end
			end
		end

		local b = this.barrack

		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					for _, s in pairs(b.soldiers) do
						s.powers[pn].level = p.level
						s.powers[pn].changed = true
					end
				end
			end
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

					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.id
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers)
					s.nav_rally.new = true

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

scripts.cannibal_carnivorous_plant = {}

function scripts.cannibal_carnivorous_plant.insert(this, store, script)
	for i, pos in ipairs(this.attack_pos) do
		this.attack_pos[i].x = pos.x + this.pos.x
		this.attack_pos[i].y = pos.y + this.pos.y
	end

	return true
end

function scripts.cannibal_carnivorous_plant.update(this, store, script)
	local a = this.area_attack
	local isIdle = false

	U.animation_start(this, "inactive", nil, store.tick_ts, true)

	local attack_ts = store.tick_ts - a.cooldown

	while true do
		if not this.owner or not store.entities[this.owner.id] then
			queue_remove(store, this)

			return
		end

		while store.tick_ts - attack_ts < a.cooldown do
			if not this.owner or not store.entities[this.owner.id] then
				queue_remove(store, this)

				return
			end

			coroutine.yield()
		end

		if not isIdle then
			U.y_animation_play(this, "activate", nil, store.tick_ts)

			isIdle = true

			U.animation_start(this, "idle", nil, store.tick_ts, true)
		end

		local attackPos

		for _, e in pairs(store.entities) do
			for i, pos in ipairs(this.attack_pos) do
				if e.enemy and e.health and not e.health.dead and band(e.vis.bans, a.vis_flags) == 0 and band(e.vis.flags, a.vis_bans) == 0 and U.is_inside_ellipse(e.pos, pos, a.damage_radius) then
					attackPos = V.vclone(pos)

					break
				end
			end

			if attackPos then
				break
			end
		end

		if not attackPos then
			attack_ts = store.tick_ts - a.cooldown + 0.2
		else
			local start_ts = store.tick_ts
			local attack_animation = attackPos.y > this.pos.y and "attack_up" or "attack_down"
			local flipX = attackPos.x < this.pos.x

			U.animation_start(this, attack_animation, flipX, store.tick_ts)
			U.y_wait(store, a.hit_time)
			S:queue("SpecialCarnivorePlant")

			local e = E:create_entity("pop_slurp")
			local x_off = this.render.sprites[1].flip_x and -40 or 40
			local y_off = attackPos.y > this.pos.y and 40 or -50

			e.pos = V.v(this.pos.x + x_off, this.pos.y + e.pop_y_offset + y_off)
			e.render.sprites[1].r = math.random(-21, 21) * math.pi / 180
			e.render.sprites[1].ts = store.tick_ts

			queue_insert(store, e)

			local targets = table.filter(store.entities, function(_, e)
--				return (e.enemy or e.soldier) and e.health and not e.health.dead and e.vis and band(e.vis.bans, a.vis_flags) == 0 and band(e.vis.flags, a.vis_bans) == 0 and U.is_inside_ellipse(e.pos, attackPos, a.damage_radius)
				return e.enemy and e.health and not e.health.dead and e.vis and band(e.vis.bans, a.vis_flags) == 0 and band(e.vis.flags, a.vis_bans) == 0 and U.is_inside_ellipse(e.pos, attackPos, a.damage_radius)				
			end)

			if #targets > 0 then
				attack_ts = start_ts

				for _, target in pairs(targets) do
					local d = E:create_entity("damage")

					d.damage_type = a.damage_type
					d.source_id = this.id
					d.target_id = target.id

					queue_damage(store, d)
				end
			end

			U.y_animation_wait(this)

			if #targets > 0 then
				U.y_animation_play(this, "toBeInactive", nil, store.tick_ts)

				isIdle = false

				U.animation_start(this, "inactive", nil, store.tick_ts, true)
			else
				isIdle = true

				U.animation_start(this, "idle", nil, store.tick_ts, true)
			end
		end
	end
end
---矮人电击手
scripts.hero_voltaire = {}

function scripts.hero_voltaire.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

	local s, l, a, y

	s = this.hero.skills.toss
	l = s.xp_level_steps[hl]
	a = this.ranged.attacks[1]
	y = E:get_template("b_volt")

	if l then
		s.level = l
		a.disabled = nil
		a.cooldown = s.cooldown[l]
		y.bullet.damage_max = s.damage_max[l]
		y.bullet.damage_min = s.damage_min[l]
		y.bullet.xp_gain_factor = s.xp_gain[l]
		y.bullet.damage_radius = s.radius[l]
		E:get_template(y.bullet.mod).modifier.duration = s.stun_duration[l]
		local r = y.bullet.damage_radius / 40
		E:get_template(y.bullet.hit_fx).render.sprites[1].scale = v(r, r)
	end

	s = this.hero.skills.tesla
	l = s.xp_level_steps[hl]
	a = this.timed_attacks.list[1]
	y = E:get_template("mini_tesla")

	if l then
		s.level = sl
		a.disabled = nil
		y.attack_count = s.attack_count[l]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_voltaire.update(this, store, initial)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta
	this.tesla_count = 0

	U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_88_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
			end

			skill = this.hero.skills.tesla
			a = this.timed_attacks.list[1]

			if this.tesla_count < 3 and not a.disabled and store.tick_ts - a.ts >= a.cooldown then
				local pos = nil
				local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)

				if target then
					pos = V.vclone(target.pos)
				else
					target = P:nearest_nodes(this.pos.x, this.pos.y)


					if target and #target > 0 then
						local pi, spi, ni = unpack(target[1])

						local no = math.random(a.node_offset[1], a.node_offset[2])

						ni = ni + no

						if not P:is_node_valid(pi, ni) then
							ni = ni - no
						end

						spi = math.random(1, 3)
						pos = P:node_pos(pi, spi, ni)
					end
				end

				if pos then
					local start_ts = store.tick_ts
					local flip = pos.x < this.pos.x

					U.animation_start(this, "throw", flip, store.tick_ts)
					SU.hero_gain_xp_from_skill(this, skill)

					if not U.y_wait(store, a.shoot_time, function()
						return SU.hero_interrupted(this)
					end) then
						a.ts = start_ts

						local af = this.render.sprites[1].flip_x
						local b = E:create_entity(a.bullet)
						local o = a.bullet_start_offset

						b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
						b.bullet.to = pos
						b.pos = V.vclone(b.bullet.from)
						b.bullet.source_id = this.id

						queue_insert(store, b)

						this.tesla_count = this.tesla_count + 1

						if not U.y_animation_wait(this) then
							goto label_88_0
						end
					end
				else
					SU.delay_attack(store, a, 0.5)
				end
			end

			brk, sta = SU.y_soldier_ranged_attacks(store, this)

			if not brk then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if not brk and sta == A_NO_TARGET and not SU.soldier_go_back_step(store, this) then
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_88_0::

		coroutine.yield()
	end
end

scripts.mini_tesla = {}

function scripts.mini_tesla.remove(this, store, initial)
	local t = E:create_entity(this.bullet.hit_scripted)
	t.pos = this.pos
	t.owner_id = this.bullet.source_id
	queue_insert(store, t)
	return true
end

function scripts.mini_tesla.update(this, store, initial)
	S:queue(this.sound_insert)
	U.y_animation_play(this, "raise", nil, store.tick_ts)
	local i = 0
	local pos = V.v(this.pos.x + this.bullet_start_offset.x, this.pos.y + this.bullet_start_offset.y)
	local ts = store.tick_ts
	while true do
		if U.find_enemies_in_range(store.entities, this.pos, this.min_range, this.max_range, this.vis_flags, this.vis_bans) then
			S:queue(this.sound_charge)
			U.animation_start(this, "attack", nil, store.tick_ts)
			U.y_wait(store, this.shoot_time)
			local targets = U.find_enemies_in_range(store.entities, this.pos, this.min_range, this.max_range, this.vis_flags, this.vis_bans)
			if targets then
				S:queue(this.sound_shoot)
				local d = math.floor(this.damage / #targets)
				for _, e in pairs(targets) do
					b = E:create_entity(this.bullet)
					b.pos = pos
					b.bullet.from = pos
					b.bullet.to = V.v(e.pos.x + e.unit.hit_offset.x, e.pos.y + e.unit.hit_offset.y)
					b.bullet.target_id = e.id
					b.bullet.source_id = this.id
					b.bounce_damage_min = d
					b.bounce_damage_max = d
					queue_insert(store, b)
				end
				i = i + 1
				if i < this.attack_count then
					U.y_wait(store, this.cooldown)
				else
					U.y_animation_wait(this)
				break
				end
			end
		end
		if store.tick_ts - ts >= this.duration then
		break
		end
	coroutine.yield()
	end
	if this.owner_id then
		local e = store.entities[this.owner_id]
		if e then
		e.tesla_count = e.tesla_count - 1
		end
	end
	S:queue(this.sound_remove)
	U.y_animation_play(this, "death", nil, store.tick_ts)
	queue_remove(store, this)
end
---毒蛇
scripts.viper_shuriken_goblirang = {}

function scripts.viper_shuriken_goblirang.update(this, store)
	local b = this.bullet
	local mspeed = b.min_speed
	local target, ps
	local s = this.render.sprites[1]
	local msts = 0
	local mstick = 0.1
	local bounce_count = 0
	local back = 0
	local viper = store.entities[b.source_id]
	local targetid = store.entities[b.target_id]
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
		if back == 0 then
		if targetid then
		b.to = V.vclone(targetid.pos)
		else
		back = 1
		end
		end
		if back == 1 then
		b.target_id = viper
		b.to = V.vclone(viper.pos)
		end
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		if store.tick_ts - b.ts > b.damage_every then
							b.ts = store.tick_ts
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, b.vis_flags, b.vis_bans)
			if targets and #targets > 0 then
			for _, t in ipairs(targets) do
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
		end
		end

		coroutine.yield()
	end

	if bounce_count < this.bounces_max then

			bounce_count = bounce_count + 1
			b.target_id = viper
			b.to = V.vclone(viper.pos)
			back = 1
			goto label_193_0
	end

	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)

		sfx.pos.x, sfx.pos.y = this.pos.x, this.pos.y
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].runs = 0

		queue_insert(store, sfx)
				end
	queue_remove(store, this)
end

scripts.hero_viper = {}

function scripts.hero_viper.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats
	local poison = E:get_template("mod_viper_poison")

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	this.melee.attacks[3].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[3].damage_max = ls.melee_damage_max[hl]
	poison.dps.damage_min = ls.poison_damage_min[hl]
	poison.dps.damage_max = ls.poison_damage_max[hl]

	local s, sl

	s = this.hero.skills.shuriken
	sl = s.xp_level_steps[hl]

	if sl then
		s.level = sl

		local a = this.ranged.attacks[1]

		a.disabled = nil

		local b = E:get_template(a.bullet)
		b.bullet.damage_min = s.damage_min[sl]
		b.bullet.damage_max = s.damage_max[sl]
		b.bounces_max = s.bounces[sl]
		b.source_id = this.id
		b.owner = this
	end

	s = this.hero.skills.curse
	sl = s.xp_level_steps[hl]

	if sl then
		s.level = sl

		local a = this.melee.attacks[2]
		local cur = E:get_template("mod_viper_debuff_new")
		local poison2 = E:get_template("mod_viper_poison_curse")

		a.disabled = nil
		a.cooldown = s.cooldown[sl]
		cur.modifier.duration = s.duration[sl]
		poison2.dps.damage_min = s.poison[sl]
		poison2.dps.damage_max = s.poison[sl]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_viper.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta

	U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	while true do
		if h.dead then
			S:queue(this.sound_events.death2)
			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_64_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
			end

			if this.ranged and this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					goto label_64_0
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_64_0
				end
			end

			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk or sta == A_DONE then
					goto label_64_0
				elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
					goto label_664_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_64_0
			end

			::label_664_0::

			SU.soldier_idle(store, this)
			SU.soldier_regen(store, this)
		end

		::label_64_0::

		coroutine.yield()
	end
end

scripts.viper_debuff_new = {}

function scripts.viper_debuff_new.update(this, store)
	local m = this.modifier
	local a = this.attack
	local s = this.render.sprites[1]
	local target = store.entities[m.target_id]
	local mdur = 0

	if not target or not target.health or target.health.dead then
		queue_remove(store, this)

		return
	end

	if s.size_names then
		s.name = s.size_names[target.unit.size]
	end

	local last_hp = target.health.hp
	local ray_ts = 0

	this.pos = target.pos

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead or store.tick_ts - m.ts > m.duration then
			queue_remove(store, this)

			return
		end

		local dhp = target.health.hp - last_hp

		if store.tick_ts - mdur > m.cycle then
			mdur = store.tick_ts
			last_hp = target.health.hp

			local targets = U.find_enemies_in_range(store.entities, target.pos, 0, a.max_range, a.vis_flags, a.vis_bans)

			if targets then
				for _, t in pairs(targets) do
					if t ~= target then
						local m2 = E:create_entity(a.mod)

						m2.modifier.target_id = t.id
						m2.modifier.source_id = this.id
						m2.pos = V.vclone(t.pos)

						queue_insert(store, m2)
					end
				end

				if store.tick_ts - ray_ts > this.ray_cooldown then
					ray_ts = store.tick_ts
				end
			end
		end

		coroutine.yield()
	end
end
---闪电
scripts.lightning_spell = {}

function scripts.lightning_spell.update(this, store, script)
	U.animation_start(this, "attack", nil, store.tick_ts)

	local d = E:create_entity("damage")

	d.source_id = this.id
	d.target_id = this.target_id
	d.damage_type = this.damage_type
	d.value = math.random(this.damage_min, this.damage_max)

	queue_damage(store, d)

	U.y_animation_wait(this)

	queue_remove(store, this)
end
---重生
scripts.enemy_cursed_shaman = {}

function scripts.enemy_cursed_shaman.update(this, store)
	local a = this.timed_attacks.list[1]

	a.ts = store.tick_ts

	local function ready_to_heal()
		return this.enemy.can_do_magic and store.tick_ts - a.ts > a.cooldown
	end

	::label_95_0::

	while true do
		if this.health.dead then
			SU.y_enemy_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.y_enemy_stun(store, this)
		else
			if ready_to_heal() then
				local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags, a.vis_bans, function(e)
					return not a.excluded_templates or not table.contains(a.excluded_templates, e.template_name)
				end)

				if not targets then
					SU.delay_attack(store, a, 0.5)
				else
					a.ts = store.tick_ts

					U.animation_start(this, a.animation, nil, store.tick_ts, false)
					S:queue(a.sound)

					if SU.y_enemy_wait(store, this, a.cast_time) then
						goto label_95_0
					end

					targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags, a.vis_bans, function(e)
						return not a.excluded_templates or not table.contains(a.excluded_templates, e.template_name)
					end)

					if targets then
						local healed_count = 0

						for _, target in ipairs(targets) do
							if healed_count >= a.max_count then
								break
							end
							
							local m = E:create_entity(a.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)
							healed_count = healed_count + 1
						if not U.has_modifiers(store, target, "mod_cursed_shield") then
							local b = E:create_entity(a.mod2)

							b.modifier.source_id = this.id
							b.modifier.target_id = target.id

							queue_insert(store, b)
							end
						end
					end

					U.y_animation_wait(this)
				end
			end

			if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, ready_to_heal, ready_to_heal) then
				-- block empty
			else
				coroutine.yield()
			end
		end
	end
end

scripts.hobgoblin_spawner_aura = {}

function scripts.hobgoblin_spawner_aura.update(this, store)
	local spawn_ts = {}

	for i = 1, #this.spawn_data do
		spawn_ts[i] = store.tick_ts
	end

	local owner = store.entities[this.aura.source_id]

	if not owner then
		log.error("owner %s was not found. baling out", this.aura.source_id)
	else
		while not owner.health.dead do
			for i, v in ipairs(this.spawn_data) do
				local template, cooldown, delay, pi, spi = unpack(v)

				if store.tick_ts - spawn_ts[i] >= cooldown + delay then
					local e = E:create_entity(template)

					e.nav_path.pi = pi
					e.nav_path.spi = math.random(1,3)
					e.nav_path.ni = P:get_start_node(pi)

					queue_insert(store, e)

					spawn_ts[i] = store.tick_ts - delay
				end
			end

			coroutine.yield()
		end
	end

	queue_remove(store, this)
end

scripts.button_steal_bag_gold = {}

function scripts.button_steal_bag_gold.update(this, store, script)
	this.already_stolen = false

	while true do
		if this.ui.clicked then
			this.ui.clicked = nil

			if store.wave_group_number > 0 and not this.already_stolen then
				this.already_stolen = false

				local gold_inc = this.gold

				for i = 1, 1 do
					local fx = E:create_entity(this.fx)

					fx.pos.x, fx.pos.y = this.pos.x + this.ui.click_rect.size.x / 2, this.pos.y + this.ui.click_rect.size.y / 2
					fx.render.sprites[1].ts = store.tick_ts
					fx.tween.props[2] = E:clone_c("tween_prop")
					fx.tween.props[2].name = "offset"
					fx.tween.props[2].keys = {
						{
							0,
							V.v(0, 0)
						},
						{
							0.8,
							V.v(10, 0)
						}
					}

					queue_insert(store, fx)

					store.player_gold = store.player_gold + gold_inc
					
					if this.template_name == "button_steal_goblin_gold" then
					AC:inc_check("GOLD_BAG")
					end

					U.y_wait(store, this.delay)
				end
			end
		end

		coroutine.yield()
	end
end

scripts.button_steal_bag_gold_iron = {}

function scripts.button_steal_bag_gold_iron.update(this, store, script)
	this.already_stolen = false
	
	local text = E:create_entity("decal_gold_bag_iron_count")
	text.pos = v(this.pos.x + 10, this.pos.y + 40)
	text.texts.list[1].text = this.gold
	text.render.sprites[2].hidden = true

	queue_insert(store, text)

	text.tween.props[1].disabled = true
	text.tween.props[2].disabled = true
	text.tween.ts = store.tick_ts
	text.tween.reverse = true
	text.tween.remove = true
	
	local this_ts = 0
	local start_ts = 0
	local started = nil

	while true do
		if store.wave_group_number > 0 then
			text.render.sprites[2].hidden = nil
			if not started then
				start_ts = store.tick_ts
				started = true
			end
		end
		if store.wave_group_number > 0 and store.tick_ts - this_ts > this.gold_every then
			this_ts = store.tick_ts
			if store.tick_ts - start_ts < this.duration then
				this.gold = this.gold + this.gold_inc_boosted
			else
				this.gold = this.gold + this.gold_inc
			end
			
			local text = E:create_entity("decal_gold_bag_iron_count")
			text.pos = v(this.pos.x + 10, this.pos.y + 40)
			text.texts.list[1].text = this.gold
			text.render.sprites[2].hidden = nil

			queue_insert(store, text)

			text.tween.props[1].disabled = true
			text.tween.props[2].disabled = true
			text.tween.ts = store.tick_ts
			text.tween.reverse = true
			text.tween.remove = true
		end
		
		if this.ui.clicked then

			if store.wave_group_number > 0 and not this.already_stolen then
				this.already_stolen = false

				local gold_inc = this.gold
				
				this.gold = 0
				
				local text = E:create_entity("decal_gold_bag_iron_count")
				text.pos = v(this.pos.x + 10, this.pos.y + 40)
				text.texts.list[1].text = this.gold
				text.render.sprites[2].hidden = nil

				queue_insert(store, text)

				text.tween.props[1].disabled = true
				text.tween.props[2].disabled = true
				text.tween.ts = store.tick_ts
				text.tween.reverse = true
				text.tween.remove = true
				
				this_ts = store.tick_ts

				for i = 1, 1 do
					local fx = E:create_entity(this.fx)

					fx.pos.x, fx.pos.y = this.pos.x + this.ui.click_rect.size.x / 2, this.pos.y + this.ui.click_rect.size.y / 2
					fx.render.sprites[1].ts = store.tick_ts
					fx.tween.props[2] = E:clone_c("tween_prop")
					fx.tween.props[2].name = "offset"
					fx.tween.props[2].keys = {
						{
							0,
							V.v(0, 0)
						},
						{
							0.8,
							V.v(10, 0)
						}
					}

					queue_insert(store, fx)

					store.player_gold = store.player_gold + gold_inc

					U.y_wait(store, this.delay)
					this.ui.clicked = nil
					start_ts = store.tick_ts
				end
			end
		end

		coroutine.yield()
	end
end

scripts.eb_hobgob2 = {}

function scripts.eb_hobgob2.get_info(this)
	local ma = this.melee.attacks[1]
	local min, max = ma.damage_min, ma.damage_max

	return {
		type = STATS_TYPE_ENEMY,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		armor = this.health.armor,
		magic_armor = this.health.magic_armor,
		lives = this.enemy.lives_cost
	}
end

function scripts.eb_hobgob2.update(this, store)
	local ba = this.timed_attacks.list[1]
	local path1
	local path2

	local function ready_to_shoot()
		return store.tick_ts - ba.ts > ba.cooldown
	end
	
	local function get_portal_position(margin, node_flags, margin_from_defend, path_id)
		if margin and type(margin) == "number" then
			margin = {
				margin,
				margin
			}
		end

		local available_paths = {
			1,
			2,
			5
		}

		local pi = available_paths[path_id]
		local spi = math.random(1, 3)
		local valid_nodes = P:get_valid_nodes(pi, node_flags)

		if #valid_nodes < 1 then
			return nil
		end

		local ni, found, tries = nil, false, 0

		while not found and tries < 5 do
			tries = tries + 1
			found = true
			ni = valid_nodes[math.random(70, (#valid_nodes * 0.6))]

			if margin and #margin > 0 then
				if not P:is_node_valid(pi, ni - margin[1], node_flags) then
					found = false
				end
	
				if P:is_node_valid(pi, ni + margin[2], node_flags) then
					if margin_from_defend and (not P:get_defend_point_node(pi) or ni + margin[2] > P:get_defend_point_node(pi)) then
						found = false
					end
				else
					found = false
				end
			end
		end

		if not found then
			log.debug("could not find random node")

			return nil
		else
			return P:node_pos(pi, spi, ni), pi, spi, ni
		end
	end

	ba.ts = store.tick_ts

	::label_155_0::

	while true do
		if this.health.dead then
			S:stop_all()
			signal.emit("hide-gui")
			LU.kill_all_enemies(store, true)
			S:queue(this.sound_events.death)
			U.y_animation_play(this, "death", nil, store.tick_ts)
			signal.emit("boss-killed", this)
			this.phase = "death-end"
			SU.fade_out_entity(store, this, this.unit.fade_time_after_death)
			LU.kill_all_enemies(store, true)

			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if ready_to_shoot() then
				local target

				S:queue(this.sound_events.shoot)
				U.animation_start(this, ba.animation, nil, store.tick_ts, false)
				U.y_wait(store, ba.shoot_time)

				local af = this.render.sprites[1].flip_x
				local o = ba.bullet_start_offset
				for i = 1, ba.count do
					local b = E:create_entity(ba.bullet)

					b.bullet.source_id = this.id
					b.bullet.target_id = target and target.id
					b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
					b.pos = V.vclone(b.bullet.from)
					if i == 1 then
						path1 = math.random(1, 3)
						b.bullet.to = get_portal_position(20, NF_RANGE, true, path1)
					else
						path2 = math.random(1, 3)
						while path1 == path2 do
							path2 = math.random(1, 3)
						end
						b.bullet.to = get_portal_position(20, NF_RANGE, true, path2)
					end
					b.bullet.hit_payload = E:create_entity(b.bullet.hit_payload)
					b.bullet.hit_payload.spawner.owner_id = this.id

					if b.bullet.to then
						queue_insert(store, b)
					else
						log.debug("could not find random position to shoot juggernaut bomb. skipping...")
					end
					
				end

				U.y_animation_wait(this)

				ba.ts = store.tick_ts
			end

			local cont, blocker = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_shoot)

			if not cont then
				-- block empty
			else
				if blocker then
					if not SU.y_wait_for_blocker(store, this, blocker) then
						goto label_155_0
					end

					while SU.can_melee_blocker(store, this, blocker) and not ready_to_shoot() do
						if not SU.y_enemy_melee_attacks(store, this, blocker) then
							goto label_155_0
						end

						coroutine.yield()
					end
				end

				coroutine.yield()
			end
		end
	end
end

scripts.eb_hobgob = {}

function scripts.eb_hobgob.update(this, store, script)
	local ma = this.timed_attacks.list[1]
	local ba = this.timed_attacks.list[2]

	local function ready_to_shoot()
		for _, a in pairs(this.timed_attacks.list) do
			if store.tick_ts - a.ts > a.cooldown then
				return true
			end
		end

		return false
	end
	local function get_portal_position(margin, node_flags, margin_from_defend)
	if margin and type(margin) == "number" then
		margin = {
			margin,
			margin
		}
	end

	local available_paths = {
		1,
		2,
		5
	}

	local pi = available_paths[math.random(1, #available_paths)]
	local spi = math.random(1, 3)
	local valid_nodes = P:get_valid_nodes(pi, node_flags)

	if #valid_nodes < 1 then
		return nil
	end

	local ni, found, tries = nil, false, 0

	while not found and tries < 5 do
		tries = tries + 1
		found = true
		ni = valid_nodes[math.random(1, #valid_nodes)]

		if margin and #margin > 0 then
			if not P:is_node_valid(pi, ni - margin[1], node_flags) then
				found = false
			end

			if P:is_node_valid(pi, ni + margin[2], node_flags) then
				if margin_from_defend and (not P:get_defend_point_node(pi) or ni + margin[2] > P:get_defend_point_node(pi)) then
					found = false
				end
			else
				found = false
			end
		end
	end

	if not found then
		log.debug("could not find random node")

		return nil
	else
		return P:node_pos(pi, spi, ni), pi, spi, ni
	end
end

	ma.ts = store.tick_ts
	ba.ts = store.tick_ts

	::label_129_0::

	while true do
		if this.health.dead then
			LU.kill_all_enemies(store, true)
			S:queue(this.sound_events.death)
			U.y_animation_play(this, "death", nil, store.tick_ts)
			signal.emit("boss-killed", this)

			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			for _, a in pairs(this.timed_attacks.list) do
				if store.tick_ts - a.ts < a.cooldown then
					-- block empty
				else
					local target

					if a == ma then
						local targets = U.find_soldiers_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

						if not targets then
							SU.delay_attack(store, a, 0.5)

							goto label_129_1
						end

						target = targets[1]
					end

					U.animation_start(this, a.animation, nil, store.tick_ts, false)
					U.y_wait(store, a.shoot_time)

					local af = this.render.sprites[1].flip_x
					local o = a.bullet_start_offset
					local b = E:create_entity(a.bullet)

					b.bullet.source_id = this.id
					b.bullet.target_id = target and target.id
					b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
					b.pos = V.vclone(b.bullet.from)

					if a == ma then
						b.bullet.to = V.v(b.pos.x + a.launch_vector.x, b.pos.y + a.launch_vector.y)
					else
						b.bullet.to = get_portal_position(30, NF_RANGE, true)
						b.bullet.hit_payload = E:create_entity(b.bullet.hit_payload)
						b.bullet.hit_payload.spawner.owner_id = this.id
					end

					if b.bullet.to then
						queue_insert(store, b)
					else
						log.debug("could not find random position to shoot juggernaut bomb. skipping...")
					end

					U.y_animation_wait(this)

					a.ts = store.tick_ts
				end

				::label_129_1::
			end

			local cont, blocker = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_shoot)

			if not cont then
				-- block empty
			else
				if blocker then
					if not SU.y_wait_for_blocker(store, this, blocker) then
						goto label_129_0
					end

					while SU.can_melee_blocker(store, this, blocker) and not ready_to_shoot() do
						if not SU.y_enemy_melee_attacks(store, this, blocker) then
							goto label_129_0
						end

						coroutine.yield()
					end
				end

				coroutine.yield()
			end
		end
	end
end

scripts.platform_bomb = {}

function scripts.platform_bomb.update(this, store, script)
	local b = this.bullet
	local ps

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	local warp_factor = b.warp_time and b.warp_time or 1

	while (store.tick_ts - b.ts + store.tick_length) * warp_factor < b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola((store.tick_ts - b.ts) * warp_factor, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		else
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end
	end

	local targets
	local target = b.target_id and store.entities[b.target_id]

	if target and target.vis and U.flag_has(target.vis.flags, F_FLYING) then
		targets = {
			target
		}
	else
		targets = table.filter(store.entities, function(_, e)
			return e and e.health and not e.health.dead and e.vis and band(e.vis.flags, b.damage_bans) == 0 and band(e.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(e.pos, b.to, b.damage_radius)
		end)
	end

	for _, target in pairs(targets) do
		local d = E:create_entity("damage")

		d.damage_type = b.damage_type

		if b.damage_decay_random then
			d.value = math.ceil(U.frandom(b.damage_min, b.damage_max))
		else
			local dist_factor = U.dist_factor_inside_ellipse(target.pos, this.pos, b.damage_radius)

			d.value = math.floor(b.damage_max - (b.damage_max - b.damage_min) * dist_factor)
		end

		d.source_id = this.id
		d.target_id = target.id

		queue_damage(store, d)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = target.id
			mod.modifier.source_id = this.id

			queue_insert(store, mod)
		end
	end

	local p = SU.create_bullet_pop(store, this)

	queue_insert(store, p)
	S:queue(this.sound_events.hit)

	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end
	
	for i = 0, 16 do
		if i % 3 == 0 then
			S:queue("BombExplosionSound")
		end

		local x, y = math.random(50, 900), math.random(50, 700)
		local cell_type = GR:cell_type(x, y)
		local fx

		if band(cell_type, TERRAIN_WATER) ~= 0 then
			fx = E:create_entity("fx_explosion_water")
		else
			fx = E:create_entity("fx_explosion_small")
		end

		fx.pos.x, fx.pos.y = x, y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
		U.y_wait(store, fts(3))
	end

	if b.hit_decal then
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

scripts.enemy_hobgoblin_rider = {}

function scripts.enemy_hobgoblin_rider.update(this, store)
	local coward = false
	local coward_ts = 0
	local ach_count = 0

	::label_228_0::

	while true do
		if this.health.dead then
		
			if ach_count == 0 then
				AC:inc_check("HOB_RIDERS")
			end
			
			SU.y_enemy_death(store, this)

			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if not coward then
				local blocker = #this.enemy.blockers > 0 and store.entities[this.enemy.blockers[1]] or nil

				if blocker then
					U.unblock_all(store, this)

					coward_ts = store.tick_ts
					coward = true
					ach_count = 1
					this.vis.bans = F_BLOCK
					this.motion.max_speed = this.motion.max_speed * this.coward_speed_factor

					goto label_228_0
				end
			elseif store.tick_ts - coward_ts > this.coward_duration then
				coward = false
				this.vis.bans = 0
				this.motion.max_speed = this.motion.max_speed / this.coward_speed_factor

				goto label_228_0
			end

			SU.y_enemy_walk_step(store, this, coward and "run" or "walk")
		end
	end
end

scripts.enemy_hobgoblin_shield = {}

function scripts.enemy_hobgoblin_shield.update(this, store, script)
	local a = this.timed_attacks.list[1]
	local achcount = 0

	a.ts = store.tick_ts

	local shield = false

	local function ready_to_cast()
		return store.tick_ts - a.ts > a.cooldown and this.enemy.can_do_magic
	end

	local function enable_shield()
		if not shield then
			shield = true

			SU.armor_inc(this, this.shield_extra_armor)
		end
	end

	local function disable_shield()
		if shield then
			shield = false

			SU.armor_dec(this, this.shield_extra_armor)
		end
	end

	::label_256_0::

	while true do
		if this.health.dead then
			if achcount == 0 then
				AC:inc_check("HOB_SHIELD")
			end
			SU.y_enemy_death(store, this)

			return
		end

		if this.unit.is_stunned then
			disable_shield()
			SU.y_enemy_stun(store, this)
		else
			enable_shield()

			if ready_to_cast() then
				local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags, a.vis_bans)

				if targets then
					local target = targets[1]

					target.vis.flags = bor(target.vis.flags, F_DARK_ELF)
					a.ts = store.tick_ts

					U.animation_start(this, a.animation, nil, store.tick_ts, false)

					if SU.y_enemy_wait(store, this, a.cast_time) then
						goto label_256_0
					end

					S:queue(a.sound)

					local m = E:create_entity(a.mod)

					m.modifier.source_id = this.id
					m.modifier.target_id = target.id

					queue_insert(store, m)
					U.y_animation_wait(this)

					a.ts = store.tick_ts

					goto label_256_0
				end

				SU.delay_attack(store, a, fts(10))
			end

			local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, function(this, store)
				return ready_to_cast()
			end)

			if not cont then
				-- block empty
			else
				if blocker then
					achcount = 1
					disable_shield()

					if not SU.y_wait_for_blocker(store, this, blocker) then
						goto label_256_0
					end

					while SU.can_melee_blocker(store, this, blocker) do
						if not SU.y_enemy_melee_attacks(store, this, blocker) then
							goto label_256_0
						end

						coroutine.yield()
					end
				end

				coroutine.yield()
			end
		end
	end
end
--重生的路径
scripts.decal_path_marching_ant = {}

function scripts.decal_path_marching_ant.insert(this, store)
	this.render.sprites[1].alpha = 0
	this.pos = P:node_pos(this.nav_path)

	return true
end

function scripts.decal_path_marching_ant.update(this, store)
	this.tween.disabled = nil
	this.tween.ts = store.tick_ts
	this.done = nil

	while true do
		local next_pos, new = P:next_entity_node(this, store.tick_length)

		if not next_pos then
			queue_remove(store, this)

			return
		end

		if this.owner.done and not this.done then
			this.done = true
			this.tween.reverse = true
			this.tween.remove = true
			this.tween.ts = store.tick_ts
		end

		U.set_destination(this, next_pos)
		U.walk(this, store.tick_length)

		this.render.sprites[1].r = this.heading.angle

		coroutine.yield()

		this.motion.speed.x, this.motion.speed.y = 0, 0
	end
end

scripts.path_marching_ants_controller = {}

function scripts.path_marching_ants_controller.update(this, store)
	local function insert_ant(pi, ni)
		local e = E:create_entity(this.ant_template)

		e.nav_path.pi = pi
		e.nav_path.spi = 1
		e.nav_path.ni = ni
		e.owner = this

		queue_insert(store, e)
	end

	local path_pis = P:get_connected_paths(this.pi)
	local ni_reminder = 0

	for _, pi in pairs(path_pis) do
		ni_reminder = 0

		local sni = P:get_start_node(pi)

		sni = sni + ni_reminder

		local eni = P:get_end_node(pi)
		local last_ni = 0

		for ii = sni, eni, this.skip_nodes do
			insert_ant(pi, ii)

			last_ni = ii
		end

		ni_reminder = km.zmod(last_ni - sni, this.skip_nodes)
	end

	local start_node = P:get_start_node(this.pi)
	local ant_speed = E:get_template(this.ant_template).motion.max_speed
	local ant_dist = P.average_node_dist * this.skip_nodes

	while not this.done do
		U.y_wait(store, ant_dist / ant_speed)

		path_pis = P:get_connected_paths(this.pi)

		for _, pi in pairs(path_pis) do
			local sni = P:get_start_node(pi)

			insert_ant(pi, sni)
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end
return scripts