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
---
return scripts