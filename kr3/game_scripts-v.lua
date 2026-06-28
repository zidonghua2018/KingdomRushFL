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
local SU = require("script_utils_v")
local U = require("utils_v")--"utils_v"
local LU = require("level_utils")
local UP = require("upgrades")
--local UP = require("upgrades")
local V = require("klua.vector")
local W = require("wave_db")
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot

require("i18n")

local scripts = require("game_scripts_v1")

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

---蜥蜴人狙击塔
scripts.arrow_v = {}

function scripts.arrow_v.update(this, store, script)
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
			
			table.insert(b.seen_targets, target.id)

			local d = SU.create_bullet_damage(b, target.id, this.id)
			
			local u = UP:get_upgrade("archer_precision")
			
			if u and math.random() < u.chance and b.can_split then
				local u = UP:get_upgrade_info("archer_precision_v")
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, u.bounce_range, false, this.visflags, this.visbans, function(e)
				return e.id ~= b.target_id and e.health and not e.health.dead and not table.contains(b.seen_targets, e.id)
			end)
				if enemy then	
					local b2 = E:create_entity(u.bullet)
					
					b2.bullet.damage_factor = b.damage_factor
					b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
					b2.bullet.from = V.vclone(b2.pos)
					b2.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
					b2.bullet.target_id = enemy.id
					b2.bullet.seen_targets = b.seen_targets
					b2.bullet.damage_min = b.damage_min
					b2.bullet.damage_max = b.damage_max
					
					queue_insert(store, b2)
				end
			end
			
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
scripts.tower_archer_v = {}

function scripts.tower_archer_v.insert(this, store, script)
	return true
end

function scripts.tower_archer_v.update(this, store, script)
	local at = this.attacks
	local a = this.attacks.list[1]
	local last_enemy, last_enemy_shots
	local shooter_sprite_ids = table.slice({
		3,
		4,
		5
	}, 1, #a.bullet_start_offset)
	local last_target_pos = V.v(0, 0)

	a.ts = store.tick_ts

	while true do
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

				enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

				if enemy then
					last_target_pos = enemy.pos

					local an, af = U.animation_name_facing_point(this, "shoot", enemy.pos, shooter_sid, start_offset)

					this.render.sprites[shooter_sid].flip_x = af

					local bullet = E:create_entity(a.bullet)

					bullet.bullet.damage_factor = this.tower.damage_factor
					bullet.pos.x, bullet.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
					bullet.bullet.from = V.vclone(bullet.pos)
					bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
					bullet.bullet.target_id = enemy.id
					bullet.visbans = a.vis_bans
					bullet.visflags = a.vis_flags

					if bullet.bullet.flight_time_min and bullet.bullet.flight_time_factor then
						local dist = V.dist(bullet.bullet.to.x, bullet.bullet.to.y, bullet.bullet.from.x, bullet.bullet.from.y)

						bullet.bullet.flight_time = bullet.bullet.flight_time_min + dist / at.range * bullet.bullet.flight_time_factor
					end

					local u = UP:get_upgrade("archer_piercing")

					if u and enemy.health and enemy.health.armor > 0 then
						if last_enemy and last_enemy == enemy then
							last_enemy_shots = last_enemy_shots + 1

							local dmg_inc = km.clamp(0, bullet.bullet.armor_damage_max, last_enemy_shots * bullet.bullet.armor_damage_inc)

							bullet.bullet.reduce_armor = bullet.bullet.reduce_armor + dmg_inc
						else
							last_enemy = enemy
							last_enemy_shots = 0
						end
					end

					queue_insert(store, bullet)
				end
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
scripts.tower_deathcoil = {}

function scripts.tower_deathcoil.get_info(this)
	local t = scripts.tower_common.get_info(this)
	local pow_c = this.powers.charged

	if pow_c.level > 0 then
		t.damage_min = t.damage_min + pow_c.charged_damage
		t.damage_max = t.damage_max + pow_c.charged_damage
	end

	return t
end

function scripts.tower_deathcoil.remove(this, store)
	local a = this.attacks.list[1]
	local crosshair = store.entities[a.crosshair_id]
								
	if crosshair then
		queue_remove(store, crosshair)
	end
	
	local aim_ray_id = store.entities[a.ray_id]
	
	if aim_ray_id then
		queue_remove(store, aim_ray_id)
	end

	return true
end

function scripts.tower_deathcoil.update(this, store, script)
	local at = this.attacks
	local a = this.attacks.list[1]
	local as = this.attacks.list[2]
	local last_enemy, last_enemy_shots, last_seen_enemy
	local shooter_sprite_id = 5
	local last_target_pos = V.v(0, 0)
	local shooting = nil
	local last_reduce_armor = 0
	local idle_ts
	local pow_c = this.powers.charged
	local pow_s = this.powers.stun
	local charged = nil
	local reaim = nil
	
	idle_ts = store.tick_ts

	a.ts = store.tick_ts
	as.ts = store.tick_ts

	while true do
		local enemy
		
		::label_5123_0::

		if this.tower.blocked then
			coroutine.yield()
		else
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow == pow_c then
						-- block empty
					elseif pow == pow_s then
						as.disabled = false
					end
				end
			end
			
			if pow_c.charged_damage > 0 then
				this.render.sprites[6].hidden = false
				if charged then
					S:queue("SaurianSniperCharge")
					charged = nil
				end
			else
				charged = nil
				this.render.sprites[6].hidden = true
			end
			
			if pow_s.level > 0 and store.tick_ts - as.ts >= as.cooldown then
				enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, as.vis_flags, as.vis_bans, function(e)
--						return e and not e.health.dead and band(e.vis.flags, F_SPELLCASTER) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
						return e and not e.health.dead and band(e.vis.flags) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
					end)

				if enemy then
					as.ts = store.tick_ts
					
					if not shooting and (not last_seen_enemy or last_seen_enemy ~= enemy) then
						local an, af, aidx = U.animation_name_facing_point(this, "shoot_start", enemy.pos, shooter_sprite_id)
					
						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
					end

					while store.tick_ts - as.ts < as.shoot_time do
						coroutine.yield()
					end
					
					if enemy then
					
						S:queue("SaurianSniperStunAim")
						
						this.render.sprites[7].hidden = false
							
						local an, af = U.animation_name_facing_point(this, "shoot_aim", enemy.pos, shooter_sprite_id)
						
						U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
						local start_ts = store.tick_ts
						
						while store.tick_ts - start_ts < as.aim_time do
							coroutine.yield()
						end

						enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, as.vis_flags, as.vis_bans, function(e)
--							return e and not e.health.dead and band(e.vis.flags, F_SPELLCASTER) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
							return e and not e.health.dead and band(e.vis.flags) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
						end)

						if enemy then
							
							shooting = true

							local an, af, aidx = U.animation_name_facing_point(this, "shoot_loop", enemy.pos, shooter_sprite_id)
						
							U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
							U.y_wait(store, as.shoot_time)
							
							if enemy then

								this.render.sprites[shooter_sprite_id].flip_x = af
								
								if af then
									aidx = aidx + 3
								end
								
								local bullet = E:create_entity(as.bullet)
								
								bullet.pos.x, bullet.pos.y = this.pos.x + as.bullet_start_offset[aidx].x, this.pos.y + as.bullet_start_offset[aidx].y
								bullet.bullet.from = V.vclone(bullet.pos)
								bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
								bullet.bullet.target_id = enemy.id
								bullet.visbans = as.vis_bans
								bullet.visflags = as.vis_flags
								bullet.bullet.level = pow_s.level
								bullet.bullet.source_id = this.id

								if bullet.bullet.flight_time_min and bullet.bullet.flight_time_factor then
									local dist = V.dist(bullet.bullet.to.x, bullet.bullet.to.y, bullet.bullet.from.x, bullet.bullet.from.y)

									bullet.bullet.flight_time = bullet.bullet.flight_time_min + dist / at.range * bullet.bullet.flight_time_factor
								end

								queue_insert(store, bullet)
								
								last_seen_enemy = enemy
							end
						end
							
						this.render.sprites[7].hidden = true
						
						U.y_animation_wait(this, shooter_sprite_id)
					end
					
					idle_ts = store.tick_ts
				end

				if store.tick_ts - idle_ts > this.tower.long_idle_cooldown then
					
					if shooting then
						local an, af = U.animation_name_facing_point(this, "shoot_end", this.tower.long_idle_pos, shooter_sprite_id)
						if this.render.sprites[shooter_sprite_id].flip_x then
							af = true
						end

						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
						
						shooting = nil
					end
				
					an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sprite_id)
					
					if this.render.sprites[shooter_sprite_id].flip_x then
						af = true
					end

					U.animation_start(this, an, af, store.tick_ts, -1, shooter_sprite_id)
				end
			end
		
			if store.tick_ts - a.ts >= a.cooldown or reaim then
				
				enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

				if enemy then
					a.ts = store.tick_ts
					
					if not shooting and (not last_seen_enemy or last_seen_enemy ~= enemy) then
						local an, af, aidx = U.animation_name_facing_point(this, "shoot_start", enemy.pos, shooter_sprite_id)
					
						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
					end

					while store.tick_ts - a.ts < a.shoot_time do
						coroutine.yield()
					end

					enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

					if enemy then
						
						local m = E:create_entity(a.crosshair_name)

						m.modifier.source_id = this.id
						m.modifier.target_id = enemy.id
						m.render.sprites[1].ts = store.tick_ts

						queue_insert(store, m)
						
						a.crosshair_id = m.id
						
						local ray = E:create_entity(a.ray)
						
						local an, af, aidx = U.animation_name_facing_point(this, "shoot_aim", enemy.pos, shooter_sprite_id)
						
						if af then
							aidx = aidx + 3
						end

						ray.pos.x, ray.pos.y = this.pos.x + a.bullet_start_offset[aidx].x, this.pos.y + a.bullet_start_offset[aidx].y
						ray.bullet.from = V.vclone(ray.pos)
						ray.bullet.to = V.vclone(enemy.pos)
						ray.bullet.target_id = enemy.id

						queue_insert(store, ray)
						
						a.ray_id = ray.id
						
						shooting = true
						last_target_pos = enemy.pos
						
						local b = E:get_template(a.bullet)
						
						local d = E:create_entity("damage")
						
						d.value = math.max(1, math.ceil(this.tower.damage_factor * b.bullet.damage_min))
						d.damage_type = b.bullet.damage_type
						
						local damage_max = math.max(1, math.ceil(this.tower.damage_factor * b.bullet.damage_max))
						
						if pow_c.level > 0 then
							d.value = d.value + pow_c.charged_damage
							damage_max = damage_max + pow_c.charged_damage
						end
						
						local u = UP:get_upgrade("archer_piercing")

						if u and enemy.health and enemy.health.armor > 0 then
							if last_enemy and last_enemy == enemy then

								local dmg_inc = km.clamp(0, b.bullet.armor_damage_max, last_enemy_shots * b.bullet.armor_damage_inc)
								last_reduce_armor = b.bullet.reduce_armor + dmg_inc
							else
								last_reduce_armor = 0
							end
						end
						
						d.reduce_armor = last_reduce_armor
						
						local charge_ts = store.tick_ts
			
						if reaim then
							reaim = nil
						end
						
						while d.value < damage_max and not this.tower.blocked and U.is_inside_ellipse(enemy.pos, this.pos, at.range + 15) do
							if store.tick_ts - charge_ts > a.charge_tick then
								charge_ts = store.tick_ts
								d.value = math.max(1, math.ceil(d.value * 1.1))
							end
							local an, af, aidx = U.animation_name_facing_point(this, "shoot_aim", enemy.pos, shooter_sprite_id)
					
							U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
							
							if af then
								aidx = aidx + 3
							end
							
							local aim_ray_id = store.entities[a.ray_id]
							
							if aim_ray_id then
								aim_ray_id.pos.x, aim_ray_id.pos.y = this.pos.x + a.bullet_start_offset[aidx].x, this.pos.y + a.bullet_start_offset[aidx].y
								aim_ray_id.bullet.from = V.vclone(aim_ray_id.pos)
							end
							
							local next = P:next_entity_node(enemy, store.tick_length)
							
							if not enemy or enemy.health.dead or enemy.health.hp == 0 or not next then
								
								local crosshair = store.entities[a.crosshair_id]
								
								if crosshair then
									queue_remove(store, crosshair)
								end
								
								local aim_ray_id = store.entities[a.ray_id]
								
								if aim_ray_id then
									queue_remove(store, aim_ray_id)
								end
								
								reaim = true
								
								goto label_5123_0
							end
							
							if U.predict_damage(enemy, d) >= enemy.health.hp then
								break
							end
							
							coroutine.yield()
						end
						
						local damage_total 
						
						if pow_c.level > 0 then
							damage_total =  math.min(b.bullet.damage_max + pow_c.charged_damage, d.value)
						else
							damage_total =  math.min(b.bullet.damage_max, d.value)
						end

						local an, af, aidx = U.animation_name_facing_point(this, "shoot_loop", enemy.pos, shooter_sprite_id)
					
						U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
						U.y_wait(store, a.shoot_time)

						last_target_pos = enemy.pos

						this.render.sprites[shooter_sprite_id].flip_x = af
						
						if af then
							aidx = aidx + 3
						end
						
						local bullet = E:create_entity(a.bullet)

						bullet.bullet.damage_min = damage_total
						bullet.bullet.damage_max = damage_total
						bullet.bullet.damage_factor = this.tower.damage_factor
						bullet.pos.x, bullet.pos.y = this.pos.x + a.bullet_start_offset[aidx].x, this.pos.y + a.bullet_start_offset[aidx].y
						bullet.bullet.from = V.vclone(bullet.pos)
						bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
						bullet.bullet.target_id = enemy.id
						bullet.visbans = a.vis_bans
						bullet.visflags = a.vis_flags
						
						if pow_c.charged_damage > 0 then
							bullet.render.sprites[1].prefix = "tower_deathcoil_charged"
							bullet.bullet.hit_fx = "fx_deathcoil_charged_hit"
							bullet.sound_events.insert = "SaurianSniperChargedBullet"
						end

						if bullet.bullet.flight_time_min and bullet.bullet.flight_time_factor then
							local dist = V.dist(bullet.bullet.to.x, bullet.bullet.to.y, bullet.bullet.from.x, bullet.bullet.from.y)

							bullet.bullet.flight_time = bullet.bullet.flight_time_min + dist / at.range * bullet.bullet.flight_time_factor
						end

						local u = UP:get_upgrade("archer_piercing")

						if u and enemy.health and enemy.health.armor > 0 then
							if last_enemy and last_enemy == enemy then
								last_enemy_shots = last_enemy_shots + 1

								local dmg_inc = km.clamp(0, bullet.bullet.armor_damage_max, last_enemy_shots * bullet.bullet.armor_damage_inc)

								bullet.bullet.reduce_armor = bullet.bullet.reduce_armor + dmg_inc
							else
								last_enemy = enemy
								last_enemy_shots = 0
							end
						end

						queue_insert(store, bullet)
						
						local next = P:next_entity_node(enemy, store.tick_length)
						
						if pow_c.level > 0 and damage_total < damage_max then
							if next then
								pow_c.charged_damage = math.ceil((damage_max - damage_total) * pow_c.factor[pow_c.level])
							end
							if this.render.sprites[6].hidden then
								charged = true
							end
						else
							pow_c.charged_damage = 0
						end
						
						local crosshair = store.entities[a.crosshair_id]
						
						if crosshair then
							queue_remove(store, crosshair)
						end
						
						local aim_ray_id = store.entities[a.ray_id]
						
						if aim_ray_id then
							queue_remove(store, aim_ray_id)
						end
						
						last_seen_enemy = enemy
					end
					
					U.y_animation_wait(this, shooter_sprite_id)
					
					idle_ts = store.tick_ts
				end

				if store.tick_ts - idle_ts > this.tower.long_idle_cooldown then
					
					if shooting then
						local an, af = U.animation_name_facing_point(this, "shoot_end", this.tower.long_idle_pos, shooter_sprite_id)
						if this.render.sprites[shooter_sprite_id].flip_x then
							af = true
						end

						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
						
						shooting = nil
					end
				
					an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sprite_id)
					
					if this.render.sprites[shooter_sprite_id].flip_x then
						af = true
					end

					U.animation_start(this, an, af, store.tick_ts, -1, shooter_sprite_id)
				end
			end

			coroutine.yield()
		end
	end
end

scripts.bolt_deathcoil = {}

function scripts.bolt_deathcoil.update(this, store, script)
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
		
		local u = UP:get_upgrade("archer_precision")
			
		if u and math.random() < u.chance and b.can_split then
			local u = UP:get_upgrade_info("archer_precision_v")
			local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, u.bounce_range, false, this.vis_flags, this.vis_bans, function(e)
			return e.id ~= b.target_id and e.health and not e.health.dead and not table.contains(b.seen_targets, e.id)
		end)
			if enemy then	
				local b2 = E:create_entity(u.bullet)
				
				b2.bullet.damage_factor = b.damage_factor
				b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
				b2.bullet.from = V.vclone(b2.pos)
				b2.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
				b2.bullet.target_id = enemy.id
				b2.bullet.seen_targets = b.seen_targets
				b2.bullet.damage_min = b.damage_min
				b2.bullet.damage_max = b.damage_max
				
				queue_insert(store, b2)
			end
		end

		queue_damage(store, d)

		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}

			for _, mod_name in pairs(mods) do
				local m = E:create_entity(mod_name)

				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				m.modifier.source_id = b.source_id

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

scripts.mod_deathcoil_crosshair = {}

function scripts.mod_deathcoil_crosshair.update(this, store, script)
	local m = this.modifier
	local started = nil
	local looping = nil

	this.modifier.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	while true do
		
		if not started then
			U.animation_start(this, "start", nil, store.tick_ts)
		elseif not looping then
			U.animation_start(this, "loop", nil, store.tick_ts, true)
			looping = true
		end
		
		if this.finished then
			queue_remove(store, this)
		end
		
		target = store.entities[m.target_id]

		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
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
		
		if not started then
			U.y_animation_wait(this)
			started = true
		end

		coroutine.yield()
	end
end

scripts.mod_deathcoil_stun = {}

function scripts.mod_deathcoil_stun.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or target.health.dead then
		return false
	end

	if target.vis and not U.flags_pass(target.vis, this.modifier) then
		log.paranoid("mod %s cannot be applied to entity %s:%s because of vis flags/bans", this.template_name, target.id, target.template_name)

		return false
	end

	if target and target.unit and this.render then
		for i = 1, #this.render.sprites do
			local s = this.render.sprites[i]
			
			if s.size_scales then
				s.scale = s.size_scales[target.unit.size]
			end

			if m.use_mod_offset and target.unit.mod_offset then
				s.offset.x, s.offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
			end
		end
	end

	m.ts = store.tick_ts
	
	if m.level > 1 and not this.duplicate then
		local enemy = U.find_foremost_enemy(store.entities, target.pos, 30, m.range, false, m.vis_flags, m.vis_bans, function(e)
			return e.id ~= target.id and e.health and not e.health.dead
		end)
		if enemy and enemy.health and not enemy.health.dead then
			local m2 = E:clone_entity(this)

			m2.modifier.target_id = enemy.id
			m2.modifier.level = m.level
			m2.duplicate = true

			queue_insert(store, m2)
			
			local ray = E:create_entity(m.ray)

			ray.pos.x, ray.pos.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			ray.bullet.from = V.vclone(ray.pos)
			ray.bullet.to = V.vclone(enemy.pos)
			ray.bullet.target_id = enemy.id
			ray.render.sprites[1].ts = store.tick_ts

			queue_insert(store, ray)
			
			this.ray_id = ray.id
			m2.ray_id = ray.id
			
			if m.level > 2 then
				local bind = E:create_entity(m.bind)

				bind.pos.x, bind.pos.y = target.pos.x, target.pos.y
				bind.bullet.from = V.vclone(bind.pos)
				bind.bullet.to = V.vclone(enemy.pos)
				bind.bullet.target_id = enemy.id
				bind.bullet.source_id = m.source_id
				bind.first_id = target.id
				bind.second_id = enemy.id
				
				if V.dist(target.pos.x, target.pos.y, enemy.pos.x, enemy.pos.y) < m.range / 2 then
					bind.bullet.min_speed = bind.bullet.min_speed / 2
					bind.bullet.max_speed = bind.bullet.max_speed / 2
				end

				queue_insert(store, bind)
				
				this.bind_id = bind.id
			end
		end
	end

	SU.stun_inc(target)
	log.paranoid("mod_stun.insert (%s)-%s for target (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_deathcoil_stun.update(this, store, script)
	local start_ts, target_hidden
	local m = this.modifier
	local target = store.entities[this.modifier.target_id]
	local ray = store.entities[this.ray_id]
	local bind = store.entities[this.bind_id]
	local target2 
	
	if bind then
		target2 = store.entities[bind.second_id]
	end

	if not target then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos
	start_ts = store.tick_ts

	if m.animation_phases then
		U.animation_start(this, "start", nil, store.tick_ts)

		while not U.animation_finished(this) do
			if not target_hidden and m.hide_target_delay and store.tick_ts - start_ts > m.hide_target_delay then
				target_hidden = true

				if target.ui then
					target.ui.can_click = false
				end

				if target.health_bar then
					target.health_bar.hidden = true
				end

				U.sprites_hide(target, nil, nil, true)
				SU.hide_modifiers(store, target, true, this)
				SU.hide_auras(store, target, true)
			end

			coroutine.yield()
		end
	end

	U.animation_start(this, "loop", nil, store.tick_ts, true)

	while store.tick_ts - m.ts < m.duration and target and not target.health.dead do
		if this.render and m.use_mod_offset and target.unit.mod_offset and not m.custom_offsets then
			for i = 1, #this.render.sprites do
				local s = this.render.sprites[i]

				s.offset.x, s.offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
			end
		end
		
		if ray and bind then
			if (target2 and target2.health.dead) or (V.dist(target.pos.x, target.pos.y, target2.pos.x, target2.pos.y) > m.range) then
				queue_remove(store, ray)
				queue_remove(store, bind)
			end
		end

		coroutine.yield()
	end

	if m.animation_phases then
		U.animation_start(this, "end", nil, store.tick_ts)

		if target_hidden then
			if target.ui then
				target.ui.can_click = true
			end

			if target.health_bar and not target.health.dead then
				target.health_bar.hidden = nil
			end

			U.sprites_show(target, nil, nil, true)
			SU.show_modifiers(store, target, true, this)
			SU.show_auras(store, target, true)
		end

		while not U.animation_finished(this) do
			coroutine.yield()
		end
	end

	queue_remove(store, this)
end

function scripts.mod_deathcoil_stun.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local ray = store.entities[this.ray_id]
	local bind = store.entities[this.bind_id]
	
	if ray then
		queue_remove(store, ray)
	end
	
	if bind then
		queue_remove(store, bind)
	end

	if target then
		SU.stun_dec(target)
		log.paranoid("mod_stun.remove (%s)-%s for target (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	else
		log.paranoid("mod_stun.remove target is nil for id %s", this.modifier.target_id)
	end

	return true
end
scripts.bolt_deathcoil = {}

function scripts.bolt_deathcoil.update(this, store, script)
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
		
		local u = UP:get_upgrade("archer_precision")
			
		if u and math.random() < u.chance and b.can_split then
			local u = UP:get_upgrade_info("archer_precision_v")
			local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, u.bounce_range, false, this.vis_flags, this.vis_bans, function(e)
			return e.id ~= b.target_id and e.health and not e.health.dead and not table.contains(b.seen_targets, e.id)
		end)
			if enemy then	
				local b2 = E:create_entity(u.bullet)
				
				b2.bullet.damage_factor = b.damage_factor
				b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
				b2.bullet.from = V.vclone(b2.pos)
				b2.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
				b2.bullet.target_id = enemy.id
				b2.bullet.seen_targets = b.seen_targets
				b2.bullet.damage_min = b.damage_min
				b2.bullet.damage_max = b.damage_max
				
				queue_insert(store, b2)
			end
		end

		queue_damage(store, d)

		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}

			for _, mod_name in pairs(mods) do
				local m = E:create_entity(mod_name)

				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				m.modifier.source_id = b.source_id

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
scripts.deathcoil_bind = {}

function scripts.deathcoil_bind.update(this, store)
	local b = this.bullet
	local mspeed = b.min_speed
	local target, ps
	local bounce_count = 0
	local tower = store.entities[b.source_id]
	b.ts = 0
	outtable = {}
	intable = {}

	b.speed.x, b.speed.y = V.normalize(b.to.x - b.from.x, b.to.y - b.from.y)

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	::label_193_0::

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		target = store.entities[b.target_id]

		if target and target.health and not target.health.dead then
			b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
		end

		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		
		if store.tick_ts - b.ts > b.damage_every then
			b.ts = store.tick_ts
			
			local target_check = store.entities[this.first_id]
			
			if target_check and this.first_id then
				local d = E:create_entity("damage")

				d.damage_type = b.damage_type
				d.source_id = this.id
				d.target_id = this.first_id
				d.value = math.random(b.damage_min * tower.tower.damage_factor, b.damage_max * tower.tower.damage_factor)

				queue_damage(store, d)
			end
			
			target_check = store.entities[this.second_id]
			
			if target_check and this.second_id then
				local d = E:create_entity("damage")

				d.damage_type = b.damage_type
				d.source_id = this.id
				d.target_id = this.second_id
				d.value = math.random(b.damage_min * tower.tower.damage_factor, b.damage_max * tower.tower.damage_factor)

				queue_damage(store, d)
			end
			
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, b.vis_flags, b.vis_bans, function(e)
				return e.id ~= this.first_id and e.id ~= this.second_id and e.health and not e.health.dead
			end)
			if targets and #targets > 0 then
				for _, t in ipairs(targets) do
					if (back == 0 and not table.contains(outtable, t.id)) or (back == 1 and not table.contains(intable, t.id)) then
					
						local d = E:create_entity("damage")

						d.damage_type = b.damage_type
						d.source_id = this.id
						d.target_id = t.id
						d.value = math.random(b.damage_min * tower.tower.damage_factor, b.damage_max * tower.tower.damage_factor)

						queue_damage(store, d)
						
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
	
	if target and not target.health.dead then
		if target.id == this.first_id then
			local newtarget = store.entities[this.second_id]
			outtable = {}
			
			if newtarget then
				b.to.x, b.to.y = newtarget.pos.x + newtarget.unit.hit_offset.x, newtarget.pos.y + newtarget.unit.hit_offset.y
				b.target_id = newtarget.id
				back = 0
				
				goto label_193_0
			else
				queue_remove(store, this)
			end
		elseif target.id == this.second_id then
			local newtarget = store.entities[this.first_id]
			intable = {}
			
			if newtarget then
				b.to.x, b.to.y = newtarget.pos.x + newtarget.unit.hit_offset.x, newtarget.pos.y + newtarget.unit.hit_offset.y
				b.target_id = newtarget.id
				back = 1
				
				goto label_193_0
			else
				queue_remove(store, this)
			end
		end
	end

	queue_remove(store, this)
end
---腐毒菇林
scripts.tower_artillery = {}

function scripts.tower_artillery.insert(this, store, script)
	return true
end

function scripts.tower_artillery.update(this, store, script)
	local a = this.attacks
	local ba = this.attacks.list[1]
	local shooter_sid = this.render.sid_shooter

	ba.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		elseif store.tick_ts - ba.ts < ba.cooldown then
			coroutine.yield()
		else
			local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, ba.node_prediction, ba.vis_flags, ba.vis_bans)

			if enemy then
				ba.ts = store.tick_ts

				local soffset = this.render.sprites[shooter_sid].offset
				local an, af, ai = U.animation_name_facing_point(this, ba.animation, enemy.pos, shooter_sid, soffset)

				U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)

				while store.tick_ts - ba.ts < ba.shoot_time do
					coroutine.yield()
				end

				local trigger_pos = pred_pos

				enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, ba.node_prediction, ba.vis_flags, ba.vis_bans)

				local b = E:create_entity(ba.bullet)

				b.bullet.damage_factor = this.tower.damage_factor

				local start_offset
				
				if this.render.sprites[3].flip_x == true then
					start_offset = ba.bullet_start_offset[1]
				else
					start_offset = ba.bullet_start_offset[2]
				end
				b.pos.x, b.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = enemy and pred_pos or trigger_pos
				b.bullet.source_id = this.id

				queue_insert(store, b)

				while not U.animation_finished(this, shooter_sid) do
					coroutine.yield()
				end
				
				local last_target_pos =V.vclone(b.bullet.to)

				local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid, ba.bullet_start_offset[1])

				U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
			end
			
			if store.tick_ts - ba.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end

			coroutine.yield()
		end
	end
end

scripts.bomb_v = {}

function scripts.bomb_v.update(this, store, script)
	local b = this.bullet
	local dmin, dmax = b.damage_min, b.damage_max
	local dradius = b.damage_radius
	
	if this.tween then
		this.tween.disabled = false
		this.tween.ts = store.tick_ts
		this.tween.props[1].ts = store.tick_ts
	end

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
	
	local u = UP:get_upgrade("engineer_field_logistics")
			
	if u and not this.mini and b.can_do_mini then
		local u = UP:get_upgrade_info("engineer_field_logistics_v")
		for i = 1, u.count do
			local b2 = E:create_entity(this.template_name)
			
			if i == 1 then
				b2.bullet.to = V.v(this.pos.x + 20, this.pos.y + 20)
			elseif i == 2 then
				b2.bullet.to = V.v(this.pos.x - 20, this.pos.y + 20)
			else
				b2.bullet.to = V.v(this.pos.x, this.pos.y - 15)
			end
			b2.bullet.damage_factor = b.damage_factor
			b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
			b2.bullet.from = V.vclone(b2.pos)
			b2.bullet.damage_min = math.ceil(b.damage_min * u.damage_factor)
			b2.bullet.damage_max = math.ceil(b.damage_max * u.damage_factor)
			b2.bullet.damage_radius = b.damage_radius - 20
			b2.bullet.hit_fx = "fx_explosion_tiny"
			b2.render.sprites[1].scale.x = this.render.sprites[1].scale.x * 0.7
			b2.render.sprites[1].scale.y = this.render.sprites[1].scale.y * 0.7
			b2.bullet.pop = nil
			b2.mini = true
			b2.sound_events.insert = nil
			b2.sound_events.hit_args = {
				gain = 0.75
			}
			
			if i ~= 1 then
				b2.sound_events.hit = nil
			end
					
			queue_insert(store, b2)
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
		
		u = UP:get_upgrade("engineer_efficiency")
		
		if u and not this.mini then
			u = UP:get_upgrade_info("engineer_efficiency_v")
			local bonus_damage_factor = math.min(1 + (u.bonus * #enemies), u.max_bonus)
			d.value = math.ceil(bonus_damage_factor * d.value)
		end

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
		if not this.mini then
			S:queue(this.sound_events.hit)
		else
			S:queue(this.sound_events.hit, this.sound_events.hit_args)
		end

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
scripts.tower_rotshroom = {}

function scripts.tower_rotshroom.remove(this, store) 
	if #this.attacks.list[1].shrooms > 0 then
		for i = 1, #this.attacks.list[1].shrooms do
			queue_remove(store, this.attacks.list[1].shrooms[i])
		end
	end

	return true
end

function scripts.tower_rotshroom.insert(this, store, script)
	return true
end

function scripts.tower_rotshroom.get_info(this)
	local min, max, d_type

	local mine = E:get_template(this.attacks.list[1].mine)

	min = mine.damage_min * 2
	max = mine.damage_max * 2
	d_type = mine.damage_type

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown

	if this.attacks and this.attacks.list[1].cooldown then
		cooldown = this.attacks.list[1].cooldown
	end

	return {
		type = STATS_TYPE_TOWER,
		damage_min = min,
		damage_max = max,
		damage_type = d_type,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_rotshroom.update(this, store, script)
	local a = this.attacks
	local ba = this.attacks.list[1]
	local pa = this.attacks.list[2]
	local pow_p = this.powers.punch
	local pow_r = this.powers.rot
	local shroom_sid = 2
	local face_sid = 3
	local hand_sid_1 = 4
	local hand_sid_2 = 6
	local idle_ts, secondary_idle_ts
	local idle_animations = {}
	local flip = nil
	
	idle_animations = {
		"idle_anim_1",
		"idle_anim_2",
		"idle_anim_3"
	}
	
	secondary_idle_ts = store.tick_ts
	idle_ts = store.tick_ts

	ba.ts = store.tick_ts
	pa.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
		
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow == pow_p then
						pa.disabled = false
					elseif pow == pow_r then
						if pow_r.level == 1 then
							local e = E:create_entity(this.auras.list[1].name)

							e.pos = V.vclone(this.pos)
							e.aura.level = this.tower.level
							e.aura.source_id = this.id
							e.aura.ts = store.tick_ts

							queue_insert(store, e)
						end
					end
				end
			end
		
			if not pa.disabled and store.tick_ts - pa.ts >= pa.cooldown then
				local target = U.find_foremost_enemy(store.entities, this.pos, 0, a.range, nil, pa.vis_flags, pa.vis_bans)
				
				if target then
					
					local prev_node = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + pa.node_offset)
					
					if target.pos.x > this.pos.x then
						this.render.sprites[4].flip_x = false
						this.render.sprites[4].offset = pow_p.offsets[1]
						this.render.sprites[6].flip_x = false
						this.render.sprites[6].offset = pow_p.offsets[3]
						flip = nil
					else
						this.render.sprites[4].flip_x = true
						this.render.sprites[4].offset = pow_p.offsets[2]
						this.render.sprites[6].flip_x = true
						this.render.sprites[6].offset = pow_p.offsets[4]
						flip = true
					end
					
					pa.ts = store.tick_ts
					
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, hand_sid_1)
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, hand_sid_2)
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, shroom_sid)
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, face_sid)
					
					while store.tick_ts - pa.ts < pa.shoot_time do
						coroutine.yield()
					end
					
					local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, pa.vis_flags, pa.vis_bans, function(e)
						return e and e.enemy and e.health and not e.health.dead and ((not flip and e.pos.x >= this.pos.x) or (flip and e.pos.x <= this.pos.x))
					end)
					
					if targets then
					
						S:queue(pa.sound)
						
						for _, t in ipairs(targets) do
							local damage = E:create_entity("damage")
						
							damage.value = math.random((pa.damage_min + pa.damage_inc * pow_p.level) * this.tower.damage_factor, (pa.damage_max + pa.damage_inc * pow_p.level) * this.tower.damage_factor)
							damage.damage_type = pa.damage_type
							if U.predict_damage(t, damage) < t.health.hp then
								local d = E:create_entity("damage")

								d.damage_type = pa.damage_type
								d.source_id = this.ia
								d.target_id = t.id
								d.value = damage.value
								
								queue_damage(store, d)
								
								local m = E:create_entity(pa.mod_throw)
							
								m.pos = t.pos
								m.modifier.target_id = t.id
								m.modifier.source_id = this.id
								m.modifier.node_offset = pa.node_offset

								queue_insert(store, m)
							else
								local m = E:create_entity(pa.mod_kill)
							
								m.pos = t.pos
								m.modifier.target_id = t.id
								m.modifier.source_id = this.id
								m.modifier.node_offset = pa.node_offset

								queue_insert(store, m)
							end
						end
					end
					
					while not U.animation_finished(this, shroom_sid) and not U.animation_finished(this, face_sid) and not U.animation_finished(this, hand_sid_1) and not U.animation_finished(this, hand_sid_2) do
						coroutine.yield()
					end
					
					idle_ts = store.tick_ts
				end
			end
		
			if store.tick_ts - ba.ts >= ba.cooldown then
				if #ba.shrooms < ba.max_count then
					local nodes = U.find_nodes_in_range(this.pos, 0, a.range, true)

					if nodes then
						ba.ts = store.tick_ts

						U.animation_start(this, ba.animation, nil, store.tick_ts, 1, shroom_sid)
						U.animation_start(this, ba.animation, nil, store.tick_ts, 1, face_sid)

						while store.tick_ts - ba.ts < ba.shoot_time do
							coroutine.yield()
						end
						
						for i = 1, ba.count do
							
							if #ba.shrooms < ba.max_count then
								local b = E:create_entity(ba.mine)

								b.damage_factor = this.tower.damage_factor
								
								local id = math.random(1, #nodes)
								local node_pos = nodes[id]
								
								b.pos.x, b.pos.y = node_pos.x + math.random(ba.offset_min, ba.offset_max), node_pos.y + math.random(ba.offset_min, ba.offset_max)
								b.source_id = this.id

								queue_insert(store, b)
								
								table.insert(ba.shrooms, b)
								
								U.y_wait(store, ba.interval)
							else
								break
							end
						end

						while not U.animation_finished(this, shroom_sid) and not U.animation_finished(this, face_sid) do
							coroutine.yield()
						end
						
						idle_ts = store.tick_ts
					end
				end
			end
			
			if store.tick_ts - idle_ts > this.tower.long_idle_cooldown and store.tick_ts - secondary_idle_ts > this.tower.long_idle_cooldown_secondary then
				local rand = math.random(1, 3)
				U.animation_start(this, idle_animations[rand], nil, store.tick_ts, 1, shroom_sid)
				U.animation_start(this, idle_animations[rand], nil, store.tick_ts, 1, face_sid)
				secondary_idle_ts = store.tick_ts
			end
		end
		coroutine.yield()
	end
end

scripts.rotshroom_aura = {}

function scripts.rotshroom_aura.update(this, store, script)
	local last_ts = store.tick_ts

	while true do
		local source = store.entities[this.aura.source_id]

		if not source then
			if #this.mini_shrooms > 0 then
				for i = 1, #this.mini_shrooms do
					queue_remove(store, this.mini_shrooms[i])
				end
			end
			queue_remove(store, this)

			return
		end

		if store.tick_ts - last_ts >= this.aura.cycle_time then
			last_ts = store.tick_ts
			
			local dead_enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.vis and v.health and v.health.dead and band(v.health.last_damage_types, bor(DAMAGE_EAT)) == 0 and band(v.vis.bans, F_SKELETON) == 0 and store.tick_ts - v.health.death_ts >= v.health.dead_lifetime - this.aura.cycle_time and U.is_inside_ellipse(v.pos, this.pos, source.attacks.range)
			end)

			dead_enemies = table.slice(dead_enemies, 1)

			for _, dead in pairs(dead_enemies) do
				dead.vis.bans = bor(dead.vis.bans, F_SKELETON)
				dead.health.delete_after = 0

				local e = E:create_entity("decal_rotshroom_mine_mini")

				e.pos = V.vclone(dead.pos)
				e.damage_min = source.powers.rot.damage_min[source.powers.rot.level]
				e.damage_max = source.powers.rot.damage_max[source.powers.rot.level]
				e.damage_factor = source.tower.damage_factor
				e.source_id = this.aura.source_id

				if dead.enemy.necromancer_offset then
					e.pos.x = e.pos.x + dead.enemy.necromancer_offset.x * (dead.render.sprites[1].flip_x and -1 or 1)
					e.pos.y = e.pos.y + dead.enemy.necromancer_offset.y
				end

				queue_insert(store, e)
				
				table.insert(this.mini_shrooms, e)
			end
		end

		coroutine.yield()
	end
end

scripts.mod_rotshroom_throw = {}

function scripts.mod_rotshroom_throw.update(this, store)

	local m = this.modifier
	local target = store.entities[m.target_id]
	local source = store.entities[m.source_id]
	local ability_active = nil

	if not target or target.health.dead then
		queue_remove(store, this)

		return
	end
	
	
	if target.beer and target.beer.done then
		ability_active = true
	end

	target.vis.bans = U.flag_set(target.vis.bans, F_ALL)
	
	SU.remove_modifiers(store, target, nil, "mod_rotshroom_throw")
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
	
	local prev_node = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + m.node_offset)
					
	local b = E:create_entity("bullet_rotshroom_throw")

	b.render.sprites[1].prefix = target.render.sprites[1].prefix
	b.render.sprites[1].flip_x = target.render.sprites[1].flip_x
	b.render.sprites[1].scale = target.render.sprites[1].scale
	b.pos.x, b.pos.y = target.pos.x, target.pos.y
	b.bullet.from = V.vclone(b.pos)
	b.bullet.to = V.vclone(prev_node)
	b.bullet.target_id = m.target_id
	b.bullet.source_id = m.source_id
	
	queue_insert(store, b)

	local start_ts = store.tick_ts

	while not b.bullet.arrived do
		coroutine.yield()
	end
		
	local nodes = P:nearest_nodes(b.pos.x, b.pos.y, {
		target.nav_path.pi
	}, nil)

	if #nodes > 0 then
		target.nav_path.ni = nodes[1][3] + 1
	end

	target.pos = V.vclone(b.pos)
	target.main_script.runs = 1
	target.health.dead = false

	if target.ui then
		target.ui.can_click = true
	end

	if target.count_group then
		target.count_group.in_limbo = nil
	end

	target.vis.bans = U.flag_clear(target.vis.bans, F_ALL)
	
	if target.beer and ability_active then
		target.beer.done = true
	end

	queue_insert(store, target)
	
	local m2 = E:create_entity(m.mod)
				
	m2.pos = target.pos
	m2.modifier.target_id = target.id
	m2.modifier.source_id = m.source_id

	queue_insert(store, m2)
	
	queue_remove(store, this)
end

scripts.mod_rotshroom_kill = {}

function scripts.mod_rotshroom_kill.update(this, store)

	local m = this.modifier
	local target = store.entities[m.target_id]
	local source = store.entities[m.source_id]

	if not target or target.health.dead then
		queue_remove(store, this)

		return
	end

	target.vis.bans = U.flag_set(target.vis.bans, F_ALL)
	
	local prev_node = V.vclone(P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + m.node_offset))
	
	SU.remove_modifiers(store, target, nil, "mod_rotshroom_kill")
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
	
	store.player_gold = store.player_gold + target.enemy.gold

	signal.emit("got-enemy-gold", target, target.enemy.gold)
					
	local b = E:create_entity("bullet_rotshroom_kill")

	b.render.sprites[1].prefix = target.render.sprites[1].prefix
	b.render.sprites[1].flip_x = target.render.sprites[1].flip_x
	b.render.sprites[1].scale = target.render.sprites[1].scale
	b.pos.x, b.pos.y = target.pos.x, target.pos.y
	b.bullet.from = V.vclone(b.pos)
	b.bullet.to = V.vclone(prev_node)
	b.bullet.target_id = m.target_id
	b.bullet.source_id = m.source_id
	
	if target.unit.size == UNIT_SIZE_MEDIUM or target.unit.size == UNIT_SIZE_LARGE then
		b.bullet.big = true
	else
		b.bullet.big = nil
	end
	
	queue_insert(store, b)
	
	queue_remove(store, this)
end

scripts.bullet_rotshroom_throw = {}

function scripts.bullet_rotshroom_throw.update(this, store, script)
	local b = this.bullet
	local dradius
	local damage
	
	if b.big then
		dradius = b.damage_radius_big
		damage = b.damage_big
	else
		dradius = b.damage_radius_small
		damage = b.damage_small
	end
	
	U.animation_start(this, "idle", nil, store.tick_ts, 1)

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

		local dist_factor = U.dist_factor_inside_ellipse(enemy.pos, b.to, dradius)

		d.value = damage

		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id

		queue_damage(store, d)
		log.paranoid("bomb id:%s, radius:%s, enemy id:%s, dist:%s, damage:%s damage_type:%x", this.id, dradius, enemy.id, V.dist(enemy.pos.x, enemy.pos.y, b.to.x, b.to.y), d.value, d.damage_type)
	end

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if b.hit_fx_water and band(cell_type, TERRAIN_WATER) ~= 0 then
		S:queue(this.sound_events.hit_water)

		local water_fx = E:create_entity(b.hit_fx_water)

		water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
		water_fx.render.sprites[1].ts = store.tick_ts
		water_fx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, water_fx)
	elseif b.hit_fx then
		if not this.mini then
			S:queue(this.sound_events.hit)
		else
			S:queue(this.sound_events.hit, this.sound_events.hit_args)
		end

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
	
	b.arrived = true

	queue_remove(store, this)
end

scripts.decal_rotshroom_mine = {}

function scripts.decal_rotshroom_mine.update(this, store)
	local ts = store.tick_ts
	local source = store.entities[this.source_id]
	
	S:queue(this.sound_events.insert)
	
	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)

	while true do

		local trigger = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, this.vis_flags, this.vis_bans)
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.damage_radius, this.vis_flags, this.vis_bans2)

		if trigger and #trigger > 0 then
		
			U.y_animation_play(this, "arm", nil, store.tick_ts, 1)
			
			S:queue(this.sound)

			local fx = E:create_entity(this.hit_fx)

			fx.pos = V.vclone(this.pos)
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
			
			local damage = math.random(this.damage_min * this.damage_factor, this.damage_max * this.damage_factor)

			for _, t in ipairs(targets) do
				local dvalue
				local d = E:create_entity("damage")

				d.damage_type = this.damage_type
				d.source_id = this.source_id
				d.target_id = t.id
				d.value = damage
				
				u = UP:get_upgrade("engineer_efficiency")
		
				if u then
					u = UP:get_upgrade_info("engineer_efficiency_v")
					local bonus_damage_factor = math.min(1 + (u.bonus * #targets), u.max_bonus)
					d.value = math.ceil(bonus_damage_factor * d.value)
				end
				
				dvalue = d.value

				queue_damage(store, d)
				
				local m = E:create_entity(this.mod)
				
				m.pos = t.pos
				m.modifier.target_id = t.id
				m.modifier.source_id = this.source_id
				m.dps.damage_max = (dvalue * m.dps.damage_every) / m.modifier.duration
				m.dps.damage_min = (dvalue * m.dps.damage_every) / m.modifier.duration

				queue_insert(store, m)
			end

			break
		end

		U.y_wait(store, this.check_interval)
	end
	
	if source.tower then
		table.removeobject(source.attacks.list[1].shrooms, this)
	else
		table.removeobject(source.mini_shrooms, this)
	end

	queue_remove(store, this)
end
---红帽地精
scripts.soldier_redcap = {}

function scripts.soldier_redcap.fn_chance_instakill(this, store, attack, target)
--	return math.random() < (math.min((((target.health.hp_max - target.health.hp) / target.health.hp_max) / attack.percentage), attack.max_chance))
	return math.random() < (math.min((((target.health.hp_max - target.health.hp) / target.health.hp_max)), attack.max_chance))
end

function scripts.soldier_redcap.fn_chance_antiboss(this, store, attack, target)
	return math.random() < (math.min((((target.health.hp_max - target.health.hp) / target.health.hp_max) / attack.percentage), attack.max_chance))
end

function scripts.soldier_redcap.update(this, store, script)
	local brk, sta
	local pow_r = this.powers.reap
	local pow_h = this.powers.harvest
	local pow_r_changed = nil
	local pow_h_changed = nil

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
				end
			end
		end
		
		if pow_r.level == 2 and not pow_r_changed then
			pow_r_changed = true
			this.melee.attacks[2].max_chance = 1--0.2
			this.melee.attacks[3].max_chance = 1--0.2
		end
		
		if pow_h.level > 0 and not pow_h_changed then
			pow_h_changed = true
			for i = 1, #this.melee.attacks do
				this.melee.attacks[i].mod_on_kill = pow_h.mod
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
				this.dodge.active = false

				signal.emit("soldier-dodge", this)
			end

			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
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

scripts.mod_redcap_heal = {}

function scripts.mod_redcap_heal.insert(this, store)
	local target = store.entities[this.modifier.target_id]
	local source = store.entities[this.modifier.source_id]

	this.modifier.target_id = this.modifier.source_id
	
	this.modifier.level = source.powers.harvest.level
	
	if U.has_modifiers(store, source, this.template_name) then
		SU.remove_modifiers(store, source, this.template_name)
	end
	
	return scripts.mod_hps.insert(this, store)
end
---哥布林萨满
scripts.mod_shrine_bolin = {}

function scripts.mod_shrine_bolin.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert mod_shrine_bolin to entity %s - ", target.id, target.template_name)

		return false
	end
	
	for _, s in pairs(this.render.sprites) do
		s.ts = store.tick_ts
	end

	if target.attacks then
		target.tower.damage_factor = target.tower.damage_factor + this.extra_damage
	end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_shrine_bolin.update(this, store, script)
	local m = this.modifier

	this.modifier.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	if m.pos_offset then
		this.pos = V.v(target.pos.x + m.pos_offset.x, target.pos.y + m.pos_offset.y)
	else
		this.pos = target.pos
	end
	
	if m.use_shooter_pos then
		if target.render.sid_shooter or target.render.sids_shooter then
			local sid = this.sid
			this.render.sprites[1].offset = V.v(target.render.sprites[sid].offset.x, target.render.sprites[sid].offset.y)
		else
			this.render.sprites[1].offset = V.v(0, 20)
		end
	end
		
	while true do
		target = store.entities[m.target_id]

		if not target or m.duration >= 0 and store.tick_ts - m.ts > m.duration then
			queue_remove(store, this)

			return
		end

		coroutine.yield()
	end
end

function scripts.mod_shrine_bolin.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and target.attacks then
		target.tower.damage_factor = target.tower.damage_factor - this.extra_damage
	end

	return true
end

scripts.mod_shrine_denas = {}

function scripts.mod_shrine_denas.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	if target.melee then
		if target.melee.forced_cooldown then
			target.melee.forced_cooldown = target.melee.forced_cooldown * this.factor
		end
		if target.melee.cooldown then
			target.melee.cooldown = target.melee.cooldown * this.factor
		end
		if target.melee.attacks then
			for i = 1, #target.melee.attacks do
				if target.melee.attacks[i].cooldown then
					target.melee.attacks[i].cooldown = target.melee.attacks[i].cooldown * this.factor
				end
			end
		end
	end
	
	if target.motion and target.motion.max_speed then
		target.motion.max_speed = target.motion.max_speed * this.speed_factor
	end
	
	if target.ranged then
		if target.ranged.attacks then
			for i = 1, #target.ranged.attacks do
				if target.ranged.attacks[i].cooldown then
					target.ranged.attacks[i].cooldown = target.ranged.attacks[i].cooldown * this.factor
				end
			end
		end
	end
	
	if target.timed_attacks then
		if target.timed_attacks.list then
			for i = 1, #target.timed_attacks.list do
				if target.timed_attacks.list[i].cooldown then
					target.timed_attacks.list[i].cooldown = target.timed_attacks.list[i].cooldown * this.factor
				end
			end
		end
	end

	return true
end

function scripts.mod_shrine_denas.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		if target.melee then
			if target.melee.forced_cooldown then
				target.melee.forced_cooldown = target.melee.forced_cooldown / this.factor
			end
			if target.melee.cooldown then
				target.melee.cooldown = target.melee.cooldown / this.factor
			end
			if target.melee.attacks then
				for i = 1, #target.melee.attacks do
					if target.melee.attacks[i].cooldown then
						target.melee.attacks[i].cooldown = target.melee.attacks[i].cooldown / this.factor
					end
				end
			end
		end
		
		if target.motion and target.motion.max_speed then
			target.motion.max_speed = target.motion.max_speed / this.speed_factor
		end
		
		if target.ranged then
			if target.ranged.attacks then
				for i = 1, #target.ranged.attacks do
					if target.ranged.attacks[i].cooldown then
						target.ranged.attacks[i].cooldown = target.ranged.attacks[i].cooldown / this.factor
					end
				end
			end
		end
		
		if target.timed_attacks then
			if target.timed_attacks.list then
				for i = 1, #target.timed_attacks.list do
					if target.timed_attacks.list[i].cooldown then
						target.timed_attacks.list[i].cooldown = target.timed_attacks.list[i].cooldown / this.factor
					end
				end
			end
		end
	end

	return true
end

scripts.mod_shrine_denas_tower = {}

function scripts.mod_shrine_denas_tower.insert(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local source = store.entities[m.source_id]

	if not target or not target.tower then
		log.error("error inserting mod_shrine_denas_tower %s", this.id)

		return true
	end

	if this.cooldown_factor then
		if target.attacks then
			if target.attacks.list then
				for i = 1, #target.attacks.list do
					if target.attacks.list[i].cooldown then
						target.attacks.list[i].cooldown = target.attacks.list[i].cooldown * this.cooldown_factor
					end
					if target.attacks.list[i].charge_tick then
						target.attacks.list[i].charge_tick = target.attacks.list[i].charge_tick * this.cooldown_factor
					end
				end
			end
		
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown * this.cooldown_factor
			end
			
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown * this.cooldown_factor
			end
		end
	end
	
	if this.boost_factor then
		if target.attacks then
			if target.attacks.list then
				if target.attacks.list[1].cooldown then
					target.attacks.list[1].cooldown = target.attacks.list[1].cooldown * this.boost_factor[m.level]
				end
				if target.attacks.list[1].charge_tick then
					target.attacks.list[1].charge_tick = target.attacks.list[1].charge_tick * this.boost_factor[m.level]
				end
			end
		
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown * this.boost_factor[m.level]
			end
			
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown * this.boost_factor[m.level]
			end
		end
	end

	if this.render then
		for i = 1, #this.render.sprites do
			local s = this.render.sprites[i]

			s.ts = store.tick_ts
		end
	end
	
	if this.tween then
		this.tween.ts = store.tick_ts
		for i = 1, #this.tween.props do
			this.tween.props[i].ts = store.tick_ts
		end
	end

	return true
end

function scripts.mod_shrine_denas_tower.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("error removing mod_shrine_denas_tower %s", this.id)

		return false
	end

	if this.cooldown_factor then
		if target.attacks then
			if target.attacks.list then
				for i = 1, #target.attacks.list do
					if target.attacks.list[i].cooldown then
						target.attacks.list[i].cooldown = target.attacks.list[i].cooldown / this.cooldown_factor
					end
					if target.attacks.list[i].charge_tick then
						target.attacks.list[i].charge_tick = target.attacks.list[i].charge_tick / this.cooldown_factor
					end
				end
			end
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown / this.cooldown_factor
			end
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown / this.cooldown_factor
			end
		end
	end
	
	if this.boost_factor then
		if target.attacks then
			if target.attacks.list then
				if target.attacks.list[1].cooldown then
					target.attacks.list[1].cooldown = target.attacks.list[1].cooldown / this.boost_factor[m.level]
				end
				if target.attacks.list[1].charge_tick then
					target.attacks.list[1].charge_tick = target.attacks.list[1].charge_tick / this.boost_factor[m.level]
				end
			end
		
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown / this.boost_factor[m.level]
			end
			
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown / this.boost_factor[m.level]
			end
		end
	end

	return true
end

scripts.tower_mage_v = {}

function scripts.tower_mage_v.remove(this, store)
	if this.auras then
		for _, e in pairs(this.auras) do
			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_mage_v.insert(this, store, script)

	local u = UP:get_upgrade("mage_slow_curse")
	
	if u then
	
	local e = E:create_entity("mage_slow_aura_v")

		e.aura.source_id = this.id
		e.aura.ts = store.tick_ts
		e.aura.radius = this.attacks.range
		e.pos = this.pos
		table.insert(this.auras, e)

		queue_insert(store, e)
	end

	return true
end

function scripts.tower_mage_v.update(this, store, script)
	local tower_sid = this.render.sid_tower
	local shooter_sid = this.render.sid_shooter
	local last_target_pos
	local a = this.attacks
	local aa = this.attacks.list[1]
	local shots = aa.loops or 1

	aa.ts = store.tick_ts

	while true do
		local enemy, enemies

		if this.tower.blocked then
			-- block empty
		elseif store.tick_ts - aa.ts <= aa.cooldown then
			-- block empty
		else
			enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

			if enemy then
				aa.ts = store.tick_ts

				local shooter_offset_y = aa.bullet_start_offset[1].y
				local tx, ty = V.sub(enemy.pos.x, enemy.pos.y, this.pos.x, this.pos.y + shooter_offset_y)
				local t_angle = km.unroll(V.angleTo(tx, ty))
				local shooter = this.render.sprites[shooter_sid]
				local an, _, ai = U.animation_name_for_angle(this, aa.animation, t_angle, shooter_sid)

				local soffset = this.render.sprites[shooter_sid].offset
				local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

				U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
				U.animation_start(this, "shoot", nil, store.tick_ts, 1, tower_sid)

				last_target_pos = V.vclone(enemy.pos)

				while store.tick_ts - aa.ts < aa.shoot_time do
					coroutine.yield()
				end

				for i = 1, shots do
					enemy = enemies[km.zmod(i, #enemies)]

					local in_range = U.is_inside_ellipse(tpos(this), enemy.pos, a.range * 1.1)
					local bullet = E:create_entity(aa.bullet)

					bullet.bullet.shot_index = i
					bullet.bullet.damage_factor = this.tower.damage_factor

					if in_range then
						bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
						bullet.bullet.target_id = enemy.id
					else
						bullet.bullet.to = last_target_pos
						bullet.bullet.target_id = nil
					end

					local start_offset
					
					if this.render.sprites[3].flip_x == true then
						start_offset = aa.bullet_start_offset[1]
					else
						start_offset = aa.bullet_start_offset[2]
					end

					bullet.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
					bullet.pos = V.vclone(bullet.bullet.from)
					
					local u = UP:get_upgrade("mage_arcane_shatter")

					if u and math.random() < u.chance and enemy.health and enemy.health.magic_armor > 0 then
						local u = UP:get_upgrade_info("mage_arcane_shatter_v")
						bullet.bullet.mod = u.mod
					end
					
					u = UP:get_upgrade("mage_empowered_magic")
					
					if u and math.random() < u.chance then
						u = UP:get_upgrade_info("mage_empowered_magic_v")
						bullet.bullet.damage_factor = bullet.bullet.damage_factor * u.damage_factor
						bullet.bullet.pop = {
							"pop_crit_v"
						}
						bullet.bullet.pop_conds = DR_DAMAGE
						bullet.bullet.pop_chance = 1
					end

					queue_insert(store, bullet)
				end

				while not U.animation_finished(this, shooter_sid) do
					coroutine.yield()
				end

				U.animation_start(this, "idle", nil, store.tick_ts, -1, tower_sid)

				local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid, aa.bullet_start_offset[1])

				U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
			end

			if store.tick_ts - aa.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end
		end

		coroutine.yield()
	end
end
scripts.aura_totem_shaman = {}

function scripts.aura_totem_shaman.update(this, store)
	local a = this.aura
	local s = this.render.sprites
	local ring_sid = 1
	local ground_sid = 2
	local totem_sid = 3
	local fx_sid = 4

	s[ring_sid].ts = store.tick_ts

	U.y_animation_play(this, "start", nil, store.tick_ts, 1, totem_sid)

	s[fx_sid].hidden = false
	this.aura.ts = store.tick_ts

	while store.tick_ts - this.aura.ts < a.duration[a.level] do
		if this.aura.target_towers then
			local towers = U.find_towers_in_range(store.entities, this.pos, this.aura, function(t)
				return t.tower.can_be_mod and not t.barrack
			end)
			
			if towers then
				for _, tower in pairs(towers) do
					local e = E:create_entity(this.aura.mod)

					e.modifier.target_id = tower.id
					e.modifier.source_id = this.id
					e.modifier.level = this.aura.level

					queue_insert(store, e)
				end
			end
		elseif this.aura.shooter then
			local target = U.find_foremost_enemy(store.entities, this.pos, 0, this.aura.radius, nil, this.aura.vis_flags, this.aura.vis_bans)
			
			if target then
				local b = E:create_entity(a.bullet)
							
				b.pos.x, b.pos.y = this.pos.x + this.bullet_start_offset.x, this.pos.y + this.bullet_start_offset.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to =  V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
				b.bullet.source_id = this.id
				b.bullet.target_id = target.id
				b.bullet.damage_factor = this.aura.damage_factor
			
				local u = UP:get_upgrade("mage_arcane_shatter")

				if u and math.random() < u.chance and target.health and target.health.magic_armor > 0 then
					local u = UP:get_upgrade_info("mage_arcane_shatter_v")
					b.bullet.mod = u.mod
				end
				
				u = UP:get_upgrade("mage_empowered_magic")
						
				if u and math.random() < u.chance then
					u = UP:get_upgrade_info("mage_empowered_magic_v")
					b.bullet.damage_factor = b.bullet.damage_factor * u.damage_factor
					b.bullet.pop = {
						"pop_crit_v"
					}
					b.bullet.pop_conds = DR_DAMAGE
					b.bullet.pop_chance = 1
				end

				queue_insert(store, b)
			end
		else
			local targets = U.find_targets_in_range(store.entities, this.pos, 0, this.aura.radius, this.aura.vis_flags, this.aura.vis_bans)

			if targets then
				for _, target in pairs(targets) do
					local e = E:create_entity(this.aura.mod)

					e.modifier.target_id = target.id
					e.modifier.source_id = this.id
					e.modifier.level = this.aura.level

					queue_insert(store, e)
				end
			end
		end

		U.y_wait(store, a.cycle_time)
	end

	s[ground_sid].hidden = true
	s[ring_sid].hidden = true
	s[fx_sid].hidden = true

	U.y_animation_play(this, "end", nil, store.tick_ts, 1, totem_sid)
	queue_remove(store, this)
end

scripts.tower_shaman = {}

function scripts.tower_shaman.get_info(this)
	local min, max, d_type
	local b = E:get_template("bolt_shaman_totem")
	local t = E:get_template(this.attacks.list[1].bullet)

	min, max = b.bullet.damage_min, b.bullet.damage_max
	d_type = b.bullet.damage_type

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown = t.aura.cycle_time

	return {
		type = STATS_TYPE_TOWER_MAGE,
		damage_min = min,
		damage_max = max,
		damage_type = d_type,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_shaman.update(this, store, script)
	local tower_sid = this.render.sid_tower
	local shooter_sid = this.render.sid_shooter
	local last_target_pos
	local a = this.attacks
	local aa = this.attacks.list[1]
	local ha = this.attacks.list[2]
	local sa = this.attacks.list[3]
	local pow_h = this.powers.healing
	local pow_s = this.powers.speed

	aa.ts = 0
	ha.ts = store.tick_ts
	sa.ts = store.tick_ts

	while true do

		if this.tower.blocked then
			-- block empty
		else
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow == pow_h then
						ha.disabled = false
						if pow_h.level == 1 then
							this.render.sprites[5].hidden = false
							U.animation_start(this, "light", nil, store.tick_ts, false, 5)
						end
					elseif pow == pow_s then
						sa.disabled = false
						if pow_s.level == 1 then
							this.render.sprites[4].hidden = false
							U.animation_start(this, "light", nil, store.tick_ts, false, 4)
						end
					end
				end
			end
			
			if not sa.disabled and pow_s.level > 0 and store.tick_ts - sa.ts > sa.cooldown then
				local towers = U.find_towers_in_range(store.entities, this.pos, sa, function(t)
					return t.tower.can_be_mod and not t.barrack
				end)

				if towers and #towers > 0 then
					sa.ts = store.tick_ts

					local tx, ty = V.sub(towers[1].pos.x, towers[1].pos.y, this.pos.x, this.pos.y)
					local t_angle = km.unroll(V.angleTo(tx, ty))
					local shooter = this.render.sprites[shooter_sid]
					local an, _, ai = U.animation_name_for_angle(this, sa.animation, t_angle, shooter_sid)
					
					local soffset = this.render.sprites[shooter_sid].offset
					local an, af, ai = U.animation_name_facing_point(this, sa.animation, towers[1].pos, shooter_sid, soffset)

					U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
					
					U.animation_start(this, "buff", nil, store.tick_ts, 1, tower_sid)
					
					local nodes = U.find_nodes_in_range(this.pos, 0, a.range)
					if nodes and #nodes > 0 then
						local id = math.random(1, #nodes)
						local node_pos = nodes[id]

						last_target_pos = V.vclone(towers[1].pos)

						while store.tick_ts - sa.ts < sa.shoot_time do
							coroutine.yield()
						end
						
						S:queue("EnemyHealing")

						local in_range = U.is_inside_ellipse(tpos(this), towers[1].pos, a.range * 1.1)
						local bullet = E:create_entity(sa.bullet)
						
						bullet.aura.level = pow_s.level
						bullet.pos = V.vclone(node_pos)

						queue_insert(store, bullet)

						while not U.animation_finished(this, shooter_sid) do
							coroutine.yield()
						end

						local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid)

						U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
					end
				end
			end
			
			if not ha.disabled and pow_h.level > 0 and store.tick_ts - ha.ts > ha.cooldown then
				local soldiers = U.find_soldiers_in_range(store.entities, tpos(this), 0, a.range, ha.vis_flags, ha.vis_bans, function(e)
					return e and e.soldier and e.health and not e.health.dead and e.health.hp < (e.health.hp_max * ha.threshold)
				end)

				if soldiers and #soldiers > 0 then
					ha.ts = store.tick_ts

					local tx, ty = V.sub(soldiers[1].pos.x, soldiers[1].pos.y, this.pos.x, this.pos.y)
					local t_angle = km.unroll(V.angleTo(tx, ty))
					local shooter = this.render.sprites[shooter_sid]
					local an, _, ai = U.animation_name_for_angle(this, ha.animation, t_angle, shooter_sid)

					local soffset = this.render.sprites[shooter_sid].offset
					local an, af, ai = U.animation_name_facing_point(this, ha.animation, soldiers[1].pos, shooter_sid, soffset)

					U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
					U.animation_start(this, "heal", nil, store.tick_ts, 1, tower_sid)
					
					local nodes = P:nearest_nodes(soldiers[1].pos.x, soldiers[1].pos.y, nil, nil, nil, NF_RALLY)
					if nodes and #nodes > 0 then
						local pi, spi, ni = unpack(nodes[1])
						local e_spi, e_ni = math.random(1, 3), ni
						
						last_target_pos = V.vclone(soldiers[1].pos)

						while store.tick_ts - ha.ts < ha.shoot_time do
							coroutine.yield()
						end
						
						S:queue("EnemyHealing")

						local in_range = U.is_inside_ellipse(tpos(this), soldiers[1].pos, a.range * 1.1)
						local bullet = E:create_entity(ha.bullet)
						
						bullet.aura.level = pow_h.level
						bullet.pos = P:node_pos(pi, 1, e_ni)

						queue_insert(store, bullet)

						while not U.animation_finished(this, shooter_sid) do
							coroutine.yield()
						end

						local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid)

						U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
					end
				end
			end
			
			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

				if enemy then
					aa.ts = store.tick_ts
					
					local tx, ty = V.sub(enemy.pos.x, enemy.pos.y, this.pos.x, this.pos.y)
					local t_angle = km.unroll(V.angleTo(tx, ty))
					local shooter = this.render.sprites[shooter_sid]
					local an, _, ai = U.animation_name_for_angle(this, aa.animation, t_angle, shooter_sid)

					local soffset = this.render.sprites[shooter_sid].offset
					local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

					U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
					U.animation_start(this, "shoot", nil, store.tick_ts, 1, tower_sid)
					
					local nodes = P:nearest_nodes(enemy.pos.x, enemy.pos.y, nil, nil, nil, NF_RALLY)
					local pi, spi, ni = unpack(nodes[1])
					local e_spi, e_ni = math.random(1, 3), ni
					local no = aa.spawn_offset_nodes

					if P:is_node_valid(pi, e_ni + no) then
						e_ni = e_ni + no
					end

					last_target_pos = V.vclone(enemy.pos)

					while store.tick_ts - aa.ts < aa.shoot_time do
						coroutine.yield()
					end
					
					S:queue("EnemyHealing")

					local in_range = U.is_inside_ellipse(tpos(this), enemy.pos, a.range * 1.1)
					local bullet = E:create_entity(aa.bullet)
					
					bullet.aura.damage_factor = this.tower.damage_factor
					bullet.pos = P:node_pos(pi, 1, e_ni)

					queue_insert(store, bullet)

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end

					local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid)

					U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
				end
			end

			if store.tick_ts - aa.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end
		end

		coroutine.yield()
	end
end
return scripts