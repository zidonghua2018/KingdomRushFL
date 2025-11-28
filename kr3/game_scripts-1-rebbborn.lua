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

return scripts