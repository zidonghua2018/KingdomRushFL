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

--少林
scripts.tower_shaolin = {}

function scripts.tower_shaolin.get_info(this)
	local a = this.attacks.list[1]
	local b = E:get_template(a.bullet)
	local min, max = b.bullet.damage_min, b.bullet.damage_max

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown = this.attacks.enemy_cooldown

	return {
		type = STATS_TYPE_TOWER,
		damage_min = min,
		damage_max = max,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_shaolin.insert(this, store)
	this.aura1 = nil
	if this.auras then
		for _, a in pairs(this.auras.list) do
			local e = E:create_entity(a.name)
			e.pos = V.vclone(this.pos)
			e.aura.level = 1
			e.aura.source_id = this.id
			e.aura.ts = store.tick_ts
			if this.powers and this.powers.lion.level >= 1 then
				this.aura1 = e
				queue_insert(store, e)
			end
		end
	end
	if this.tower.level == 4 then
		if not this.barrack.rally_pos and this.tower.default_rally_pos then
			this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
		end
	end

	return true
end

function scripts.tower_shaolin.remove(this, store)
	
	if this.pixies then
		for _, e in pairs(this.pixies) do
			if e.is_stun == true then
				SU.stun_dec(e.target_stun)
			end
			e.owner = nil

			queue_remove(store, e)
		end
	end
	
	if this.aura1 then
		queue_remove(store, this.aura1)
	end

	if this.tower.level == 4 then
		for _, s in pairs(this.barrack.soldiers) do
			if s.health then
				s.health.dead = true
			end

			queue_remove(store, s)
		end
	end

	return true
end

function scripts.tower_shaolin.update(this, store)
	local a = this.attacks
	this.pixies = {}
	a.ts = store.tick_ts
	this.idle_offsets = {v(-18, -1),v(21, -3),v(5, -9),
		v(-18, -1),v(21, -3),v(5, -9)}
	local pow_d = this.powers and this.powers.dragon
	local pow_l = this.powers and this.powers.lion
	local pow_t = this.powers and this.powers.total
	local enemy_cooldowns = {}
	local ba = this.barrack

	local function spawn_pixie()
		local e = E:create_entity("decal_shaolin_lvl"..this.tower.level)
		local po = this.idle_offsets[#this.pixies + 1]

		e.idle_pos = po
		e.pos.x, e.pos.y = this.pos.x + po.x, this.pos.y + po.y

		queue_insert(store, e)
		table.insert(this.pixies, e)
		e.render.sprites[1].hidden = true

		e.owner = this
	end

	spawn_pixie()
	spawn_pixie()
	spawn_pixie()

	this.anim_play_out = false
	this.anim_play_in = false
	while true do
		if this.tower.blocked then
			-- block empty
		else
			if pow_t and pow_t.changed and #this.pixies < 6 then
				pow_t.changed = nil

				spawn_pixie()
			end

			if pow_l and pow_l.changed then
				pow_l.changed = nil
				this.render.sprites[5].hidden = false
				if this.aura1 == nil then
					local e = E:create_entity("aura_tower_shaolin_gold")
					e.pos = V.vclone(this.pos)
					e.aura.level = 1
					e.aura.source_id = this.id
					e.aura.ts = store.tick_ts
								
					this.aura1 = e
								
					if this.powers and this.powers.lion.level >= 1 then
						queue_insert(store, e)				
					end
				end
			end
			

			if pow_d and pow_d.level > 0 then
					if pow_d.changed then
						pow_d.changed = nil
	
						local s = ba.soldiers[1]
	
						if s and store.entities[s.id] then
							s.unit.level = pow_d.level
							s.health.armor = s.health.armor
							s.health.hp_max = s.health.hp_max
							s.health.hp = s.health.hp_max
	
							local ma = s.melee.attacks[1]
	
							ma.damage_min = ma.damage_min
							ma.damage_max = ma.damage_max
						end
					end
	
					local s = ba.soldiers[1]
	
					if s and s.health.dead then
						last_soldier_pos = s.pos
					end
	
					if not s or s.health.dead and store.tick_ts - s.health.death_ts > s.health.dead_lifetime then
						local ns = E:create_entity(ba.soldier_type)
	
						ns.soldier.tower_id = this.id
						--ns.pos = last_soldier_pos or V.v(ba.rally_pos.x, ba.rally_pos.y)
						if not ba.rally_pos and this.tower.default_rally_pos then
							ba.rally_pos = V.vclone(this.tower.default_rally_pos)
						end
						ns.pos = V.v(ba.rally_pos.x, ba.rally_pos.y)
						ns.nav_rally.pos = V.vclone(ba.rally_pos)
						ns.nav_rally.center = V.vclone(ba.rally_pos)
						ns.nav_rally.new = true
						ns.unit.level = 1
						ns.health.armor = ns.health.armor
						ns.health.hp_max = ns.health.hp_max
	
						local ma = ns.melee.attacks[1]
	
						ma.damage_min = ma.damage_min
						ma.damage_max = ma.damage_max
	
						queue_insert(store, ns)
	
						ba.soldiers[1] = ns
						s = ns
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

			if store.tick_ts - a.ts > a.cooldown then
				for pixie_count, pixie in pairs(this.pixies) do
					local target, attack

					if pixie.target or store.tick_ts - pixie.attack_ts <= a.pixie_cooldown then
						-- block empty
					else
						attack = a.list[1]

						if not attack then
							-- block empty
						else
							target = U.find_foremost_enemy(store.entities, this.pos, 0, a.range,false, attack.vis_flags, attack.vis_bans, function(e)
								return not table.contains(a.excluded_templates, e.template_name) and (not enemy_cooldowns[e.id] or enemy_cooldowns[e.id] < store.tick_ts)
							end)

							if not target then
								-- block empty
							else
								if pixie_count == 1 then
									this.anim_play_out = true
								end
								enemy_cooldowns[target.id] = store.tick_ts + a.enemy_cooldown
								pixie.attack_ts = store.tick_ts
								pixie.target_id = target.id
								pixie.attack = attack
								pixie.attack_level = pixie_count
								a.ts = store.tick_ts

								break
							end
						end
					end
				end
			end
			if this.anim_play_in == true then 
				U.y_animation_play(this, "in", nil, store.tick_ts, false, 3)
				U.y_animation_play(this, "in", nil, store.tick_ts, false, 4)
				this.anim_play_in = false
			end

			if this.anim_play_out == true then 
				U.y_animation_play(this, "out", nil, store.tick_ts, false, 3)
				U.y_animation_play(this, "out", nil, store.tick_ts, false, 4)
				this.anim_play_out = false
			end
		end

		coroutine.yield()
	end
end

scripts.decal_shaolin = {}

function scripts.decal_shaolin.update(this, store)
	local iflip = this.idle_flip
	local o, slot_pos, slot_flip, enemy_flip
	local punchInName = {"punchIn", "kickIn"}
	local punchOutName = {"punchOut", "kickOut"}
	--U.y_animation_play(this, "punchIn", slot_flip, store.tick_ts)
	this.is_stun = false
	this.target_stun = nil

	while true do
		if this.target_id ~= nil then
			local target = store.entities[this.target_id]

			if not target or target.health.dead then
				-- block empty
			else

				if band(target.vis.bans, F_STUN) == 0 and band(target.vis.flags, F_BOSS) == 0 and (not target.enemy.blockers or #target.enemy.blockers == 0) then
					SU.stun_inc(target)
					this.is_stun = true
					this.target_stun = target
				end

				this.render.sprites[1].hidden = false
				local is_air = band(target.vis.flags, F_FLYING) ~= 0
				local random_action = 1
				if is_air then
					this.pos.x, this.pos.y = target.pos.x + target.unit.hit_offset.x, target.pos.y
					this.tween.disabled = false
					this.tween.props[1].disabled = false
					this.tween.props[1].ts = store.tick_ts
					this.tween.props[1].keys[2][2].y = math.max(target.unit.hit_offset.y - 20, 5)
					U.animation_start(this, "dragonPunchUp", nil, store.tick_ts)
				else
					slot_pos, slot_flip, enemy_flip = U.melee_slot_position(this, target, 1)
					this.pos.x, this.pos.y = slot_pos.x, slot_pos.y
					random_action = math.random(1, 2)
					U.animation_start(this, punchInName[random_action], slot_flip, store.tick_ts)
				end
				U.y_wait(store, fts(6))

				if target and not target.health.dead then
					local bullet = E:get_template(this.attack.bullet).bullet
					local fx = E:create_entity(bullet.hit_fx)
					if is_air then
						fx.pos.x = target.pos.x + target.unit.hit_offset.x
						fx.pos.y = target.pos.y + target.unit.hit_offset.y
					else
						fx.render.sprites[1].hidden = true
					end
					fx.render.sprites[1].ts = store.tick_ts
					queue_insert(store, fx)
					local d = SU.create_bullet_damage(bullet, target.id, this.id)
					queue_damage(store, d)
				end

				if is_air then
					U.animation_start(this, "dragonPunchDown", nil, store.tick_ts)
					U.y_wait(store, fts(5))
					this.tween.disabled = true
					this.tween.props[1].disabled = true
					U.y_animation_play(this, "dragonPunchOut", nil, store.tick_ts)
				else
					U.y_animation_wait(this)
					U.y_animation_play(this, punchOutName[random_action], slot_flip, store.tick_ts)
				end

				if this.is_stun then
					SU.stun_dec(target)
					this.is_stun = false
					this.target_stun = nil
				end

				if this.attack_level == 1 then
					this.owner.anim_play_in = true
				end
				
				this.render.sprites[1].hidden = true

				o = this.idle_pos
				this.pos.x, this.pos.y = this.owner.pos.x + o.x, this.owner.pos.y + o.y

				--U.y_animation_play(this, "punchIn", slot_flip, store.tick_ts)
			end

			this.target_id = nil
		elseif store.tick_ts - iflip.ts > iflip.cooldown then
			U.animation_start(this, table.random(iflip.animations), math.random() < 0.5, store.tick_ts, iflip.loop)

			iflip.ts = store.tick_ts
		end

		coroutine.yield()
	end
end

scripts.mod_gold = {}

function scripts.mod_gold.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if not target or target.health.dead or not target.motion or target.motion.invulnerable or not target.enemy then
		return false
	end

	if this.modifier.excluded_templates and table.contains(this.modifier.excluded_templates, target.template_name) then
		log.paranoid("mod_slow.insert not inserted to %s because of excluded_templates", target.id)

		return false
	end

	log.paranoid("mod_slow.insert (%s)-%s for (%s)-%s", this.id, this.template_name, target.id, target.template_name)

	--target.motion.max_speed = target.motion.max_speed * this.slow.factor
	if not target._gold_factor then
		target._gold_factor = 1
		if target.enemy.gold then
			target._gold_origin = target.enemy.gold
		else
			target._gold_origin = 20
		end
	end
	target._gold_factor = target._gold_factor * this.slow.factor
	target.enemy.gold = math.floor(target._gold_origin * target._gold_factor)
	this.modifier.ts = store.tick_ts

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_gold.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if target and target.health and target.motion and target.enemy then
		--target.motion.max_speed = target.motion.max_speed / this.slow.factor
		target._gold_factor = target._gold_factor / this.slow.factor
		target.enemy.gold = math.floor(target._gold_origin * target._gold_factor)

		log.paranoid("mod_slow.remove (%s)-%s for (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	else
		log.debug("mod_slow.remove target is nil for id %s", this.modifier.target_id)
	end

	return true
end

scripts.aura_tower_shaolin_gold = {}

function scripts.aura_tower_shaolin_gold.insert(this, store, script)
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

function scripts.aura_tower_shaolin_gold.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0

	for _, ps_n in pairs(this.ps_names) do
		local ps = E:create_entity(ps_n)

		ps.particle_system.emit_area_spread = V.vv(this.aura.radius)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

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

		if this.aura.stop_on_max_count and this.aura.max_count and victims_count >= this.aura.max_count then
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
				goto label_1060_0
			end

			if this.render then
				this.render.sprites[1].hidden = not te.enemy.can_do_magic
			end

			if not te.enemy.can_do_magic then
				goto label_1060_0
			end
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_1060_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.health and te.health.dead then
				goto label_1060_0
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

		::label_1060_0::

		coroutine.yield()
	end

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end


--冰龙
scripts.hero_eiskalt = {}
--[[
function scripts.hero_eiskalt.get_info(this)
	local m = E:get_template("fireball_eiskalt")
	local min, max = m.bullet.damage_min, m.bullet.damage_max

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		damage_type = DAMAGE_MAGICAL,
		armor = this.health.armor,
		respawn = this.health.dead_lifetime
	}
end
]]--
function scripts.hero_eiskalt.get_info(this)
	local t = scripts.hero_basic.get_info_ranged(this)
	local m = E:get_template(this.ranged.attacks[1].bullet)
    	t.ranged_damage_max = m.bullet.damage_max * this.unit.damage_factor
		t.ranged_damage_min = m.bullet.damage_min * this.unit.damage_factor
		t.ranged_damage_type = m.bullet.damage_type
		t.damage_max = 0--3 * m.bullet.damage_max
		t.damage_min = 0--3 * m.bullet.damage_min
		t.damage_type = m.bullet.damage_type

	return t
end

function scripts.hero_eiskalt.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	local b = E:get_template("fireball_eiskalt")

	b.bullet.damage_max = ls.ranged_damage_max[hl]
	b.bullet.damage_min = ls.ranged_damage_min[hl]

	--确定科技等级和数值
	--local m = E:get_template("mod_dracolich_disease")

	--m.dps.damage_min = ls.disease_damage[hl]
	--m.dps.damage_max = ls.disease_damage[hl]

	local s

	--普攻爆炸
	s = this.hero.skills.explosion
	if initial and s.level >= 0 then
		b = E:get_template("fireball_eiskalt")
		b.bullet.damage_radius = s.damage_radius[s.level]
	end


	--冻土
	s = this.hero.skills.coldfury
	if initial and s.level > 0 then
		this.timed_attacks.list[3].disabled = nil
		this.timed_attacks.list[3].cooldown = s.cooldown_time[s.level]
	end

	--雪球
	s = this.hero.skills.frosty
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[1]
		a.disabled = nil
		e = E:get_template("aura_eiskalt_rider")
		a.damage_min = s.damage_min[s.level]
		a.damage_max = s.damage_max[s.level]
	end

	--冰刺
	s = this.hero.skills.icepeak
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[2]
		a.disabled = nil
		b = E:get_template("eiskalt_icepeaks")
		b.damage_min = s.damage_min[s.level]
		b.damage_max = s.damage_max[s.level]
	end

	--冰龙大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template("hero_eiskalt_ultimate")
		u.duration = s.duration[s.level]
	end



	this.health.hp = this.health.hp_max
end

function scripts.hero_eiskalt.insert(this, store)
	this.hero.fn_level_up(this, store, true)

	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_eiskalt.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts


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


		--4技能：冰刺（原脊骨雨），召唤物从骨头换成冰刺且固定8根
		a = this.timed_attacks.list[2]
		skill = this.hero.skills.icepeak
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

					U.animation_start(this, "icePeaks", flip, store.tick_ts)
					--skeleton_glow_fx()
					U.y_wait(store, a.spawn_time)

					local delay = 0
					--local n_step = ni < s_ni and -2 or 2
					local n_step = ni < s_ni and -4 or 4

					ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

					for i = 1, skill.count[skill.level] do
						local e = E:create_entity(a.entity)

						e.pos = P:node_pos(pi, spi, ni)
						e.render.sprites[1].prefix = e.render.sprites[1].prefix
						e.render.sprites[1].flip_x = not flip
						e.delay = delay
						e.bullet.source_id = this.id
						e.bullet.level = this.hero.skills.icepeak.level

						queue_insert(store, e)

						delay = delay + fts(U.frandom(1, 3))
						ni = ni + n_step
						spi = km.zmod(spi + math.random(1, 2), 3)
					end

					U.y_animation_wait(this)

					force_idle_ts = true
					a.ts = store.tick_ts

					SU.hero_gain_xp_from_skill(this, skill)

					goto label_386_1
				end
			end
		end

		--2技能：永恒冻土（原撞击地面）
		--抄了1代冰女的代码
		a = this.timed_attacks.list[3]
		skill = this.hero.skills.coldfury
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not target then
				SU.delay_attack(store, a, 0.13333333333333333)
			else
				local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, {	pi}, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, a, 0.4)
				else
					local s_pi, s_spi, s_ni = unpack(nodes[1])
					local flip = target.pos.x < this.pos.x
					local start_ts = store.tick_ts

					U.animation_start(this, "coldFury", flip, store.tick_ts)
					S:queue(a.sound)

					if SU.y_hero_wait(store, this, a.cast_time) then
						goto label_61_0
					end

					a.ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					local delay = 0
					local n_step = ni < s_ni and -a.step or a.step

					ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + a.nodes_offset or ni)

					for i = 1, 8 do
						local b = E:create_entity(a.bullet)

						b.pos = P:node_pos(pi, spi, ni)
						b.render.sprites[1].prefix = b.render.sprites[1].prefix
						b.render.sprites[1].flip_x = not flip
						b.delay = delay

						queue_insert(store, b)

						delay = delay + 0.05
						ni = ni + n_step
						spi = km.zmod(spi + 1, 3)
					end

					SU.y_hero_animation_wait(this)

					goto label_61_0
				end
			end
		end

		::label_61_0::

		--3技能：大雪球（原瘟疫载体）
		a = this.timed_attacks.list[1]
		skill = this.hero.skills.frosty
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local targets_info = U.find_enemies_in_paths(store.entities, this.pos, a.range_nodes_min, a.range_nodes_max, nil, a.vis_flags, a.vis_bans)

			if not targets_info then
				SU.delay_attack(store, a, 0.4)
			else
				local target

				for _, ti in pairs(targets_info) do
					if GR:cell_is(ti.enemy.pos.x, ti.enemy.pos.y, TERRAIN_LAND) then
						target = ti.enemy

						break
					end
				end

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
						local dir = ni < s_ni and -1 or 1
						local offset = math.random(a.range_nodes_min, a.range_nodes_min + 5)

						s_ni = km.clamp(1, #P:path(s_pi), s_ni + (dir > 0 and offset or -offset))

						local flip = P:node_pos(s_pi, s_spi, s_ni, true).x < this.pos.x

						S:queue(a.sound)
						U.animation_start(this, "frosty", flip, store.tick_ts)
						U.y_wait(store, a.spawn_time)

						local delay = 0

						for i = 1, a.count do
							local e = E:create_entity(a.entity)

							e.pos.x, e.pos.y = this.pos.x + (flip and -1 or 1) * a.spawn_offset.x, this.pos.y + a.spawn_offset.y
							e.nav_path.pi = s_pi
							e.nav_path.spi = math.random(1, 3)
							e.nav_path.ni = s_ni
							e.nav_path.dir = dir
							e.delay = delay
							e.aura.source_id = this.id
							e.aura.level = this.hero.skills.frosty.level

							queue_insert(store, e)

							delay = delay + fts(U.frandom(1, 3))
						end

						U.y_animation_wait(this)

						force_idle_ts = true
						a.ts = store.tick_ts

						SU.hero_gain_xp_from_skill(this, skill)

						goto label_386_1
					end
				end
			end
		end

		--普攻，可直接沿用骨龙的
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
							goto label_386_0
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
					--print("damage radius"..b.bullet.damage_radius)
					--b.bullet.damage_radius = 20 + 20 * this.hero.skills.explosion.level

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_386_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_386_0::

					goto label_386_1
				end
			end
		end

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)

		force_idle_ts = nil

		::label_386_1::

		coroutine.yield()
	end
end

--冰刺
scripts.eiskalt_icepeaks = {}

function scripts.eiskalt_icepeaks.update(this, store)
	local b = this.bullet

	U.sprites_hide(this)

	if this.delay then
		U.y_wait(store, this.delay)
	end

	U.sprites_show(this)

	local start_ts = store.tick_ts

	this.pos.x = this.pos.x + math.random(-4, 4)
	this.pos.y = this.pos.y + math.random(-5, 5)

	S:queue(this.sound_events.delayed_insert)
	U.animation_start(this, "in", nil, store.tick_ts, false)

	this.tween.ts = store.tick_ts

	U.y_wait(store, b.hit_time)

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, b.damage_radius, b.damage_flags, b.damage_bans)

	if targets then
		for _, target in pairs(targets) do
			local d = E:create_entity("damage")

			d.damage_type = b.damage_type
			d.source_id = this.id
			d.target_id = target.id
			d.value = 0 
			if band(target.vis.flags, F_BOSS) == 0 then
				d.value = target.health.hp_max * 0.1 * b.level--百分比伤害
			end
			queue_damage(store, d)

			if b.mod then
				local m = E:create_entity(b.mod)

				m.modifier.source_id = this.id
				m.modifier.target_id = target.id
				m.modifier.xp_dest_id = b.source_id

				queue_insert(store, m)
			end
		end
	end

	U.y_wait(store, b.duration - (store.tick_ts - start_ts))
	U.y_animation_play(this, "out", nil, store.tick_ts, false)
	queue_remove(store, this)
end

--冰球
scripts.hero_eiskalt_frosty = {}

function scripts.hero_eiskalt_frosty.insert(this, store)
	next_pos = P:node_pos(this.nav_path)

	if not next_pos then
		return false
	end

	return true
end

function scripts.hero_eiskalt_frosty.update(this, store)
	local y_off = 20
	local a = this.aura
	local m = this.motion
	local nav = this.nav_path
	local dt = store.tick_length
	local start_ni = nav.ni
	local start_ts = store.tick_ts
	local hit_ts = 0

	a.duration = a.duration + U.frandom(-a.duration_var, 0)
	m.max_speed = m.max_speed + math.random(0, m.max_speed_var)

	local step = m.max_speed * dt
	local next_pos = P:node_pos(nav)

	next_pos.y = next_pos.y + y_off

	U.set_destination(this, next_pos)

	local v_heading = V.v(0, 0)

	v_heading.x, v_heading.y = V.normalize(next_pos.x - this.pos.x, next_pos.y - this.pos.y)

	local th_dist = 25
	local turn_speed = math.pi * 1.5
	local enemies_hit = {}

	if this.delay then
		this.render.sprites[1].hidden = true

		U.y_wait(store, this.delay)

		this.render.sprites[1].hidden = nil
	end

	--local ps = E:create_entity("ps_dracolich_plague")

	--ps.particle_system.track_id = this.id

	--queue_insert(store, ps)

	while true do
		if this.tween.disabled and store.tick_ts - start_ts > a.duration then
			this.tween.disabled = nil
			this.tween.ts = store.tick_ts
			--ps.particle_system.emit = false
		end

		if th_dist > V.len(m.dest.x - this.pos.x, m.dest.y - this.pos.y) then
			nav.ni = nav.ni + math.random(6, 11) * nav.dir

			local p_len = #P:path(nav.pi)

			if nav.ni <= 1 or p_len <= nav.ni then
				a.duration = 0
			end

			nav.ni = km.clamp(1, p_len, nav.ni)
			nav.spi = km.zmod(nav.spi + math.random(1, 2), 3)
			next_pos = P:node_pos(nav)
			next_pos.y = next_pos.y + y_off

			U.set_destination(this, next_pos)
		end

		local dx, dy = V.sub(m.dest.x, m.dest.y, this.pos.x, this.pos.y)
		local sa = km.short_angle(V.angleTo(dx, dy), V.angleTo(v_heading.x, v_heading.y))
		local angle_step = math.min(turn_speed * dt, math.abs(sa)) * km.sign(sa) * -1

		v_heading.x, v_heading.y = V.rotate(angle_step, v_heading.x, v_heading.y)

		local sx, sy = V.mul(step, v_heading.x, v_heading.y)

		this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, sx, sy)
		m.speed.x, m.speed.y = sx / dt, sy / dt
		this.render.sprites[1].r = V.angleTo(v_heading.x, v_heading.y)

		if store.tick_ts - hit_ts > a.damage_cycle then
			hit_ts = store.tick_ts

			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.damage_radius, a.damage_flags, a.damage_bans, function(v)
				return not table.contains(enemies_hit, v)
			end)

			if not targets then
				-- block empty
			else
				for _, e in pairs(targets) do
					local d = E:create_entity("damage")

					d.source_id = this.id
					d.target_id = e.id
					d.value = math.random(a.damage_min, a.damage_max)
					d.damage_type = a.damage_type

					queue_damage(store, d)

					if a.mod then
						local m = E:create_entity(a.mod)

						m.modifier.source_id = this.id
						m.modifier.target_id = e.id
						m.modifier.xp_dest_id = a.source_id

						queue_insert(store, m)
					end

					table.insert(enemies_hit, e)
				end
			end
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end

--冰球 5代死灵版

scripts.aura_eiskalt_skill_rider = {}

function scripts.aura_eiskalt_skill_rider.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local sid_rider = 1
	local sid_fx = 2
	local target_pos = this.pos
	local fading = false
	local spawned_fx = false
	local path_ni = 1
	local path_spi = 1
	local path_pi = 1
	local available_paths = {}

	for k, v in pairs(P.paths) do
		table.insert(available_paths, k)
	end

	if store.level.ignore_walk_backwards_paths then
		available_paths = table.filter(available_paths, function(k, v)
			return not table.contains(store.level.ignore_walk_backwards_paths, v)
		end)
	end

	local nearest = P:nearest_nodes(this.pos.x, this.pos.y, available_paths)

	if #nearest > 0 then
		path_pi, path_spi, path_ni = unpack(nearest[1])

		for _, n in pairs(nearest) do
			local _path_pi, _path_spi, _path_ni = unpack(n)

			if _path_pi == this.path_id then
				path_pi, path_spi, path_ni = _path_pi, _path_spi, _path_ni

				break
			end
		end
	end

	path_spi = 1
	path_ni = path_ni - 3

	local distance = 0

	last_hit_ts = store.tick_ts - this.aura.cycle_time

	if this.aura.apply_delay then
		last_hit_ts = last_hit_ts + this.aura.apply_delay
	end

	local function hit_enemies()
		local targets = table.filter(store.entities, function(k, v)
			return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
		end)

		for i, target in ipairs(targets) do
			local already_hit_target = false
			local has_mod, mods = U.has_modifiers(store, target, this.aura.mod)

			if has_mod then
				for _, mod in pairs(mods) do
					if mod.modifier.source_id == this.id then
						already_hit_target = true

						break
					end
				end
			end

			if already_hit_target then
				-- block empty
			else
				this.damage_max = this.damage_max_config[this.aura.level]
				this.damage_min = this.damage_min_config[this.aura.level]

				if target and not target.health.dead and target.enemy then
					queue_damage(store, SU.create_attack_damage(this, target.id, this.id))

					local hit_fx = E:create_entity(this.hit_fx)

					hit_fx.pos = V.vclone(target.pos)
					hit_fx.pos.x, hit_fx.pos.y = hit_fx.pos.x + target.unit.hit_offset.x, hit_fx.pos.y + target.unit.hit_offset.y
					hit_fx.render.sprites[1].ts = store.tick_ts

					queue_insert(store, hit_fx)

					local new_mod = E:create_entity(this.aura.mod)

					new_mod.modifier.target_id = target.id
					new_mod.modifier.source_id = this.id

					if this.aura.hide_source_fx and target.id == this.aura.source_id then
						new_mod.render = nil
					end

					queue_insert(store, new_mod)
				end
			end
		end
	end

	path_ni = path_ni - 3
	target_pos = P:node_pos(path_pi, path_spi, path_ni)

	local flip_x = target_pos.x < this.pos.x

	U.animation_start(this, "spawn", flip_x, store.tick_ts, 1, sid_rider)
	--U.y_wait(store, fts(21))
	hit_enemies()
	--U.y_wait(store, fts(10))

	this.tween.props[1].disabled = true
	this.tween.props[1].ts = store.tick_ts

	local psA = E:create_entity(this.particles_name_A)

	psA.particle_system.track_id = this.id
	psA.particle_system.emit = true

	queue_insert(store, psA)

	local psB = E:create_entity(this.particles_name_B)

	psB.particle_system.track_id = this.id
	psB.particle_system.emit = true

	queue_insert(store, psB)

	local function rider_go_back_step()
		if V.veq(this.pos, target_pos) then
			this.motion.arrived = true

			return false
		else
			U.set_destination(this, target_pos)

			if U.walk(this, store.tick_length) then
				return false
			else
				local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)

				U.animation_start(this, an, af, store.tick_ts, -1, sid_rider)

				return true
			end
		end
	end

	local function run_backwards()
		local last_pos = this.pos

		distance = V.dist2(target_pos.x, target_pos.y, this.pos.x, this.pos.y)

		if distance < 25 then
			path_ni = path_ni - 3
			target_pos = P:node_pos(path_pi, path_spi, path_ni)
		end

		rider_go_back_step()

		--[[
		if not spawned_fx then
			local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)
			local hit_fx

			if an == "walk_side" then
				hit_fx = E:create_entity(this.spawn_side_fx)
			elseif an == "walk_front" then
				hit_fx = E:create_entity(this.spawn_front_fx)
			else
				hit_fx = E:create_entity(this.spawn_back_fx)
			end

			hit_fx.pos = V.vclone(this.pos)
			hit_fx.render.sprites[1].ts = store.tick_ts
			hit_fx.render.sprites[1].flip_x = af

			queue_insert(store, hit_fx)

			spawned_fx = true
		end
		]]--

		local r = V.angleTo(target_pos.x - last_pos.x, target_pos.y - last_pos.y)

		psA.particle_system.emit_offset.x, psA.particle_system.emit_offset.y = V.rotate(r, psA.emit_offset_relative.x, psA.emit_offset_relative.y)
		psB.particle_system.emit_offset.x, psB.particle_system.emit_offset.y = V.rotate(r, psB.emit_offset_relative.x, psB.emit_offset_relative.y)
	end

	local function check_start_fade()
		if fading then
			return false
		end

		local fade_duration = this.tween.props[1].keys[2][1]

		if this.aura.duration >= 0 and store.tick_ts - this.aura.ts + fade_duration > this.actual_duration then
			return true
		end

		local nearest = P:nearest_nodes(this.pos.x, this.pos.y, available_paths)

		if #nearest > 0 then
			path_pi, path_spi, path_ni = unpack(nearest[1])

			return path_ni < 10
		end

		return false
	end

	while true do
		if this.interrupt then
			last_hit_ts = 1e+99
		end

		this.render.sprites[1].offset.y = 0
		if this.aura.duration >= 0 and store.tick_ts - this.aura.ts > this.actual_duration or fading and this.render.sprites[1].alpha <= 0 then
			break
		end

		if check_start_fade() then
			fading = true
			this.tween.props[1].disabled = false
			this.tween.reverse = true
			this.tween.props[1].ts = store.tick_ts
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_651_0
			end
		end

		if store.tick_ts - last_hit_ts >= this.aura.cycle_time then
			if this.aura.apply_duration and first_hit_ts and store.tick_ts - first_hit_ts > this.aura.apply_duration then
				goto label_651_0
			end

			first_hit_ts = first_hit_ts or store.tick_ts
			last_hit_ts = store.tick_ts

			hit_enemies()
		end

		run_backwards()

		::label_651_0::

		coroutine.yield()
	end

	queue_remove(store, this)
end

--普攻
scripts.fireball_eiskalt = {}

function scripts.fireball_eiskalt.update(this, store)
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

	queue_remove(store, this)
end

--冰龙大招
scripts.hero_eiskalt_ultimate = {}
function scripts.hero_eiskalt_ultimate.can_fire_fn(this, x, y, store)
	return not GR:cell_is(x, y, TERRAIN_FAERIE) and P:valid_node_nearby(x, y, 1.4285714285714286, NF_POWER_3)
end

function scripts.hero_eiskalt_ultimate.insert(this, store, script)
	for _, e in pairs(store.entities) do
		if e.template_name == this.template_name then
			log.debug("atomic_freeze already exists, force silent removal")
			queue_remove(store, e)

			this.skip_ice_slabs = true
		end
	end

	return true
end

function scripts.hero_eiskalt_ultimate.update(this, store, script)
	local this_ts = store.tick_ts

	--signal.emit("atomic-freeze-starts")

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, 9999, this.vis_flags, this.vis_bans, function(e)
		return not table.contains(this.excluded_templates, e.template_name)
	end)

	local mod 
	if targets then
		for _, target in pairs(targets) do

			if band(target.vis.flags, F_BOSS) == 0 and band(target.vis.bans, F_FREEZE) == 0 then
				mod = E:create_entity(this.mod)
				mod.modifier.target_id = target.id
				mod.modifier.duration = this.duration

				queue_insert(store, mod)
			end

			
		end
	end

	if this.skip_ice_slabs then
		for _, e in pairs(store.entities) do
			if e.template_name == "decal_user_item_atomic_freeze_slab" then
				e.render.sprites[1].ts = store.tick_ts
			end
		end
	else
		for i = 1, 10 do
			local rpos = P:get_random_position(20, bor(TERRAIN_LAND, TERRAIN_WATER))

			if not rpos then
				log.debug("user_item_atomic_freeze: could not find random position for slab decal. i:%s", i)
			else
				local e = E:create_entity("decal_user_item_atomic_freeze_slab")

				e.duration = this.duration
				e.pos = rpos
				e.render.sprites[1].ts = store.tick_ts
				e.render.sprites[1].name = string.format(e.render.sprites[1].name, math.random(1, e.decals_count))
				e.render.sprites[1].scale = V.v(U.random_sign(), 1)

				queue_insert(store, e)
			end
		end
	end
	if mod then
		while this_ts + mod.modifier.duration > store.ts do
			this.rain.ts = store.tick_ts
				local r = this.rain
				r.ts = store.tick_ts

				local angle = U.frandom(r.angle_min, r.angle_max)

				for i = 1, r.count do
					angle = angle + U.frandom(-r.angle_between, r.angle_between)

					local dist = math.random(r.distance_min, r.distance_max)
					local ox, oy = V.rotate(angle, dist, 0)
					local delay = U.frandom(0.001, r.delay_max)
					local pos = V.v(math.random(-REF_OX, REF_W + REF_OX), math.random(0, REF_H))
					local e = E:create_entity("fx_power_eiskalt_drop")

					e.pos.x, e.pos.y = pos.x, pos.y
					e.render.sprites[1].offset = V.v(-ox, -oy)
					e.render.sprites[1].r = angle
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

					--[[
					local e = E:create_entity("fx_power_thunder_rain_splash")

					e.pos.x, e.pos.y = pos.x, pos.y
					e.render.sprites[1].ts = store.tick_ts + delay + r.duration

					queue_insert(store, e)
					]]--
				end
			coroutine.yield()
		end
	end
	U.y_wait(store, this.duration)
	--signal.emit("atomic-freeze-ends")
	queue_remove(store, this)
end

--沼巨
scripts.tower_swamp_monster = {}

function scripts.tower_swamp_monster.get_info(this)
	if not this.tower_upgrade_persistent_data.current_mode or this.tower_upgrade_persistent_data.current_mode == 0 then
		local s = E:create_entity(this.barrack.soldier_type)

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
			respawn = s.health.dead_lifetime
		}
	else
		local b = E:create_entity(this.attacks.list[1].bullet)
		return {
			damage_min = math.ceil(b.bullet.damage_min * this.tower.damage_factor),
			damage_max = math.ceil(b.bullet.damage_max * this.tower.damage_factor),
			range = this.attacks.range,
			type = STATS_TYPE_TOWER,
			cooldown = this.attacks.list[1].cooldown
		}
	end
end

function scripts.tower_swamp_monster.insert(this, store, script)
	if not this.barrack.rally_pos and this.tower.default_rally_pos then
		this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
	end

	return true
end

function scripts.tower_swamp_monster.remove(this, store, script)
	for _, s in pairs(this.barrack.soldiers) do
		if s.health then
			s.health.dead = true
		end

		queue_remove(store, s)
	end

	return true
end

function scripts.tower_swamp_monster.update(this, store, script)
	local shooter_sid = this.tower.level == 4 and 4 or 2
	local ab = this.attacks and this.attacks.list[1]

	if this.tower_upgrade_persistent_data.current_mode == nil then
		this.tower_upgrade_persistent_data.current_mode = 0
	end

	b_type = this.barrack.soldier_type
	this.tower_upgrade_persistent_data.collect_hp = this.tower_upgrade_persistent_data.current_mode == 1 and E:get_template(b_type).health.hp_max or 0
	if this.tower.level < 4 then
		if this.tower_upgrade_persistent_data.current_mode == 0 then 
			this.render.sprites[2].hidden = true
			this.barrack.max_soldiers = 1
		else
			this.render.sprites[2].hidden = false
			this.barrack.max_soldiers = 0
		end
	else
		if this.tower_upgrade_persistent_data.current_mode == 0 then 
			this.render.sprites[2].hidden = false
			this.render.sprites[3].hidden = false
			this.render.sprites[4].hidden = true
			this.render.sprites[5].hidden = true
			this.render.sprites[6].hidden = true
			this.barrack.max_soldiers = 1
		else
			this.render.sprites[2].hidden = true
			this.render.sprites[3].hidden = true
			this.render.sprites[4].hidden = false
			this.render.sprites[5].hidden = false
			this.render.sprites[6].hidden = false
			this.barrack.max_soldiers = 0
		end
	end


	local attacks = {}
	if ab then
		table.insert(attacks, ab)--射击
		--table.insert(pows, nil)
	end
	local check_hp_store = false

	local function check_change_mode()
		if this.change_mode then
			this.change_mode = false
			--死亡状态下不能切换
			if this.tower_upgrade_persistent_data.current_mode == 0 and this.barrack.soldiers[1].health.dead then
				return false
			end

			if this.tower_upgrade_persistent_data.current_mode == 0 then
				this.tower_upgrade_persistent_data.collect_hp = math.max(this.barrack.soldiers[1].health.hp, 1)
				this.barrack.max_soldiers = 0
				if this.barrack.soldiers[1] and this.barrack.soldiers[1].health then
					this.barrack.soldiers[1].health.dead = true
				end

				queue_remove(store, this.barrack.soldiers[1])
				this.tower_upgrade_persistent_data.current_mode = 1
			else
				this.barrack.max_soldiers = 1
				this.tower_upgrade_persistent_data.current_mode = 0
				check_hp_store = true
			end

			if this.tower.level < 4 then
				if this.tower_upgrade_persistent_data.current_mode == 0 then 
					this.render.sprites[2].hidden = true
				else
					this.render.sprites[2].hidden = false
				end
			else
				if this.tower_upgrade_persistent_data.current_mode == 0 then 
					this.render.sprites[2].hidden = false
					this.render.sprites[3].hidden = false
					this.render.sprites[4].hidden = true
					this.render.sprites[5].hidden = true
					this.render.sprites[6].hidden = true
				else
					this.render.sprites[2].hidden = true
					this.render.sprites[3].hidden = true
					this.render.sprites[4].hidden = false
					this.render.sprites[5].hidden = false
					this.render.sprites[6].hidden = false
				end
			end
			S:queue("SwampMonsterTaunt")
			return true
		end

		return false
	end

	while true do
		
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

		check_change_mode()

		if not this.tower.blocked then
			for i = 1, b.max_soldiers do
				local s = b.soldiers[i]

				if not s or s.health.dead and not store.entities[s.id] then
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

		if check_hp_store == true and b.soldiers[1] then 
			check_hp_store = false
			b.soldiers[1].health.hp = math.min(b.soldiers[1].health.hp_max, this.tower_upgrade_persistent_data.collect_hp)
			this.tower_upgrade_persistent_data.collect_hp = 0
		end

		if this.tower.blocked or this.tower_upgrade_persistent_data.current_mode == 0 then
			coroutine.yield()
		else
			for i, aa in pairs(attacks) do
				if aa and not aa.disabled and store.tick_ts - aa.ts > aa.cooldown then 
					if aa == ab then
						local target
						target = U.find_foremost_enemy(store.entities, tpos(this), 0, this.attacks.range, false, aa.vis_flags, aa.vis_bans)
						if not target then
							--SU.delay_attack(store, aa, fts(5))
						else
							local enemy_id = target.id
							local shoot_pos = pred_pos

							aa.ts = store.tick_ts

							local soffset = this.render.sprites[shooter_sid].offset
							local an, af, ai = U.animation_name_facing_point(this, aa.animation, target.pos, shooter_sid, soffset)
							local start_offset = aa.bullet_start_offset

							if this.tower.level == 4 then
								U.animation_start_group(this, an, af, store.tick_ts, false, "layers")
							else
								U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
							end
							U.y_wait(store, ab.shoot_time)
							if target then
								local b = E:create_entity(aa.bullet)
								b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
								b.pos = V.vclone(b.bullet.from)
								b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
								b.bullet.target_id = target.id
								b.bullet.source_id = this.id
								b.bullet.damage_min = math.ceil(b.bullet.damage_min * this.tower.damage_factor)
								b.bullet.damage_max = math.ceil(b.bullet.damage_max * this.tower.damage_factor)

								--投手的额外mod
								if this.powers and this.powers.stun.level > 0 and math.random() < this.powers.stun.mod_chance[this.powers.stun.level] then
									b.bullet.mod = "mod_swamp_stun"
								end
								if this.powers and this.powers.instakill.level > 0 and math.random() < this.powers.instakill.mod_chance[this.powers.instakill.level] and bor(target.vis.flags, bor(F_BOSS, F_MINIBOSS)) == 0 then
									b.render.sprites[1].name = "Swamp_monster_tower_proyectile_instakill_lvl4"
									b.bullet.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS)
								end
								if this.powers and this.powers.eat.level > 0 then
									local d = SU.create_bullet_damage(b.bullet, target.id, this.id)
									--queue_damage(store, d)
									local will_kill = U.predict_damage(target, d) >= target.health.hp
									if will_kill then
										this.tower_upgrade_persistent_data.collect_hp = this.tower_upgrade_persistent_data.collect_hp + this.powers.eat.hp
									end
								end
								queue_insert(store, b)
							end
							while not U.animation_finished(this, shooter_sid) do
								coroutine.yield()
							end
							local an2 = an == "shootUp" and "idleUp" or "idle" 
							if this.tower.level == 4 then
								U.animation_start_group(this, an2, af, store.tick_ts, true, "layers")
							else
								U.animation_start(this, an2, af, store.tick_ts, true, shooter_sid)
							end
						end		
					end
				end
			end

		end
		coroutine.yield()
	end
end

--沼巨战士
scripts.soldier_swamp_monster = {}

function scripts.soldier_swamp_monster.insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		if this.powers then
			for pn, p in pairs(this.powers) do

				if pn == "instakill" then
						--this.health.dark_spiked_armor = p.dark_spiked_armor[p.level]
						--this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
				end
					if pn == "stun" then
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						
					end
			end
		end

		return true
	end

	return false
end

function scripts.soldier_swamp_monster.update(this, store)
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

					if pn == "instakill" then
						--this.health.dark_spiked_armor = p.dark_spiked_armor[p.level]
						--this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
					end
					if pn == "stun" then
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						
					end
					--print(this.melee.attacks[1].chance.." "..this.melee.attacks[2].chance.." "..this.melee.attacks[3].chance)
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
			--[[
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
			]]--
			::label_612_1::
			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_61_1
				end
			end

			--brk, sta = SU.y_soldier_melee_block_and_attacks(store, this) --y_swamp_melee_block_and_attacks
			brk, sta = SU.y_swamp_melee_block_and_attacks(store, this)

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



return scripts
