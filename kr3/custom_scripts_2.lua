local log = require("klua.log"):new("custom_scripts_2")

require("klua.table")

local km = require("klua.macros")
local signal = require("hump.signal")
local AC = require("achievements")
local E = require("entity_db")
local GR = require("grid_db")
local GS = require("game_settings")
local P = require("path_db")
local S = require("sound_db")
local SU = require("script_utils_pld")
local U = require("utils_pld")
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

local scripts = require("custom_scripts_0")

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

scripts.holder_roots_lands_blocked = {}
function scripts.holder_roots_lands_blocked.update(this, store, script)
	U.y_animation_play_group(this, "in", nil, store.tick_ts, nil, this.animation_group)
	U.animation_start_group(this, "idle", nil, store.tick_ts, true, this.animation_group)
end

scripts.holder_roots_lands_removed = {}
function scripts.holder_roots_lands_removed.update(this, store, script)
	U.y_animation_play_group(this, "out", nil, store.tick_ts, nil, this.animation_group)
	local controller = E:create_entity(this.controller)
	controller.holder_id = this.tower.holder_id
	controller.terrain_style = this.tower.terrain_style
	controller.default_rally_pos = this.tower.default_rally_pos
	controller.nav_mesh_id = this.ui.nav_mesh_id
	controller.pos.x, controller.pos.y = this.pos.x, this.pos.y
	queue_insert(store, controller)
	if this.upgrade_to then
		this.tower.upgrade_to = this.upgrade_to
		return
	end
	queue_remove(store, this)
end

scripts.tower_roots_lands_blocked = {}
function scripts.tower_roots_lands_blocked.update(this, store, script)
	local towers = table.filter(store.entities, function(k, v)
		return  v.tower and v.tower.holder_id == this.tower.holder_id and v.pos.x == this.pos.x and v.pos.y == this.pos.y and v.vis
	end)
	if #towers > 0 then
		local tower = towers[1]
		tower.tower.blocked = nil
	end
	towers = nil
	U.y_animation_play_group(this, "in", nil, store.tick_ts, nil, this.animation_group)
	U.animation_start_group(this, "idle", nil, store.tick_ts, true, this.animation_group)
	local last_hit_ts = 0
	while true do
		if store.tick_ts - last_hit_ts >= this.cycle_time then
			last_hit_ts = store.tick_ts
			local targets = table.filter(store.entities, function(k, v)
				return  v.tower and v.tower.holder_id == this.tower.holder_id and v.pos.x == this.pos.x and v.pos.y == this.pos.y and v.vis
			end)
			if targets then
				local target = targets[1]
				local mods = this.mods or {
					this.mod
				}
				for _, mod_name in pairs(mods) do
					local m = E:create_entity(mod_name)
					m.modifier.target_id = target.id
					m.modifier.source_id = this.id
					queue_insert(store, m)
				end
			end
		end
		coroutine.yield()
	end
end

scripts.controller_holder_roots_lands_blocked = {}
function scripts.controller_holder_roots_lands_blocked.update(this, store, script)
	local towers, tower
	local i = 0
	local spawn_ts = U.frandom(this.cooldown_min, this.cooldown_max + 1e-09) + store.tick_ts
	while spawn_ts > store.tick_ts do
		if i < 10 then
			i = i + 1
			towers = table.filter(store.entities, function(k, v)
				return v.tower and v.tower.holder_id == this.holder_id and v.pos.x == this.pos.x and v.pos.y == this.pos.y
			end)
			if #towers > 0 then
				tower = towers[1]
				tower.ui.clicked = nil
				tower.ui.can_select = true
				tower.ui.can_click = true
				tower = nil
				i = 10
			end
			towers = nil
		end
		coroutine.yield()
	end
	towers = table.filter(store.entities, function(k, v)
		return v.tower and v.tower.holder_id == this.holder_id and v.pos.x == this.pos.x and v.pos.y == this.pos.y
	end)
	local holder
	if #towers > 0 then
		tower = towers[1]
		tower.tower.blocked = true
		tower.ui.can_select = nil
		tower.ui.can_click = nil
		tower.ui.clicked = nil
		if tower.vis then
			holder = E:create_entity("tower_roots_lands_blocked")
			print("this tower has vis 325")
			tower = nil
		else
			holder = E:create_entity("holder_roots_lands_blocked")
			print("this tower donot has vis 329")
			tower = nil
		end
	else
		holder = E:create_entity("holder_roots_lands_blocked")
	end
	holder.pos.x, holder.pos.y = this.pos.x, this.pos.y
	holder.tower.holder_id = this.holder_id
	holder.tower.terrain_style = this.terrain_style
	holder.tower.default_rally_pos = this.default_rally_pos
	holder.ui.nav_mesh_id = this.nav_mesh_id
	holder.render.sprites[1].name = string.format(holder.render.sprites[1].name, holder.tower.terrain_style)
	holder.render.sprites[2].name = string.format(holder.render.sprites[2].name, holder.tower.terrain_style)
	queue_insert(store, holder)
	if tower then
		queue_remove(store, tower)
	end
	queue_remove(store, this)
end

scripts.swamp_spawner = {}
function scripts.swamp_spawner.update(this, store, script)
	local sp = this.spawner

	while true do
		if sp.spawn_data == false then
			break
		elseif sp.spawn_data then
			sp.spawn_data = nil
			S:queue(this.spawn_sound, this.spawn_sound_args)
			for _, s in pairs(this.render.sprites) do
				if s.group == this.animation_group then
					s.hidden = nil
				end
			end
			U.y_animation_play_group(this, this.spawn_animation, nil, store.tick_ts, nil, this.animation_group)
			for _, s in pairs(this.render.sprites) do
				if s.group == this.animation_group then
					s.hidden = true
				end
			end
		end
		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.decal_spider_rotten_egg_shooter = {}
function scripts.decal_spider_rotten_egg_shooter.update(this, store, script)
	local sp = this.spawner
	local a = this.ranged.attacks[1]

	while true do
		local spawn_data = sp.spawn_data
		if sp.spawn_data == false then
			break
		elseif spawn_data and type(spawn_data) == "table" then
			sp.spawn_data = nil
			for i, data in ipairs(spawn_data) do
				local b = E:create_entity(a.bullet)
				b.pos.x, b.pos.y = this.pos.x, this.pos.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = P:node_pos(data[1], data[2], data[3])
				b.bullet.source_id = this.id
				local hp = E:create_entity(b.bullet.hit_payload)
				hp.spawner.pi, hp.spawner.spi, hp.spawner.ni = unpack(data)
				b.bullet.hit_payload = hp
				queue_insert(store, b)
				if i < #spawn_data then
					U.y_wait(store, a.cooldown)
				end
			end
		end
		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.eb_greenmuck = {}

function scripts.eb_greenmuck.get_info(this)
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

function scripts.eb_greenmuck.update(this, store)
	local ba = this.timed_attacks.list[1]

	local function ready_to_shoot()
		return store.tick_ts - ba.ts > ba.cooldown
	end

	ba.ts = store.tick_ts

	::label_155_0::

	while true do
		if this.health.dead then
			U.y_animation_play(this, "death", nil, store.tick_ts)
			signal.emit("boss-killed", this)
			SU.fade_out_entity(store, this, this.unit.fade_time_after_death)

			local spawner = LU.list_entities(store.entities, "s15_rotten_spawner")[1]

			if spawner then
				spawner.interrupt = true
			end

			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if ready_to_shoot() then
				local targets = table.filter(store.entities, function(_, e)
					return not e.pending_removal and e.soldier and e.vis and e.health and not e.health.dead and band(e.vis.flags, ba.vis_bans) == 0 and band(e.vis.bans, ba.vis_flags) == 0
				end)

				if #targets < 1 then
					SU.delay_attack(store, ba, 0.5)
				else
					U.animation_start(this, ba.animation, nil, store.tick_ts, false)
					U.y_wait(store, ba.shoot_time)

					local af = this.render.sprites[1].flip_x
					local o = ba.bullet_start_offset
					local random_targets = table.random_order(targets)

					for i, t in ipairs(random_targets) do
						if i > ba.count then
							break
						end

						local b = E:create_entity(ba.bullet)

						b.bullet.source_id = this.id
						b.bullet.target_id = t
						b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
						b.bullet.to = V.vclone(t.pos)
						b.pos = V.vclone(b.bullet.from)

						queue_insert(store, b)
					end

					U.y_animation_wait(this)

					ba.ts = store.tick_ts
				end
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

scripts.enemy_greenmuck = {}
function scripts.enemy_greenmuck.update(this, store)
	local ba = this.timed_attacks.list[1]

	local function ready_to_shoot()
		return store.tick_ts - ba.ts > ba.cooldown
	end

	ba.ts = store.tick_ts

	::label_155_0::

	while true do
		if this.health.dead then
			S:queue(this.sound_events.death)
			U.y_animation_play(this, "death", nil, store.tick_ts)
			SU.fade_out_entity(store, this, this.unit.fade_time_after_death)
			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if ready_to_shoot() then
				local targets = table.filter(store.entities, function(_, e)
					return not e.pending_removal and e.soldier and e.vis and e.health and not e.health.dead and band(e.vis.flags, ba.vis_bans) == 0 and band(e.vis.bans, ba.vis_flags) == 0
				end)

				if #targets < 1 then
					SU.delay_attack(store, ba, 0.5)
				else
					U.animation_start(this, ba.animation, nil, store.tick_ts, false)
					U.y_wait(store, ba.shoot_time)

					local af = this.render.sprites[1].flip_x
					local o = ba.bullet_start_offset
					local random_targets = table.random_order(targets)

					for i, t in ipairs(random_targets) do
						if i > ba.count then
							break
						end

						local b = E:create_entity(ba.bullet)

						b.bullet.source_id = this.id
						b.bullet.target_id = t
						b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
						b.bullet.to = V.vclone(t.pos)
						b.pos = V.vclone(b.bullet.from)

						queue_insert(store, b)
					end

					U.y_animation_wait(this)

					ba.ts = store.tick_ts
				end
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


scripts.enemy_basic = {}

function scripts.enemy_basic.get_info(this)
	local min, max, attacks

	if this.melee and this.melee.attacks then
		for _, a in pairs(this.melee.attacks) do
			if a.damage_min then
				min, max = a.damage_min, a.damage_max

				break
			end
		end

		if this.unit and min then
			min, max = min * this.unit.damage_factor, max * this.unit.damage_factor
		end
	elseif this.ranged and this.ranged.attacks then
		for _, a in pairs(this.ranged.attacks) do
			if a.bullet then
				local b = E:get_template(a.bullet)

				if b and b.bullet.damage_min and b.bullet.damage_max then
					min, max = b.bullet.damage_min, b.bullet.damage_max

					break
				end
			end
		end
	end

	if min and max then
		min, max = math.ceil(min), math.ceil(max)
	end

	local armor = band(this.health.immune_to, DAMAGE_PHYSICAL) ~= 0 and 1 or this.health.armor
	local magic_armor = band(this.health.immune_to, DAMAGE_MAGICAL) ~= 0 and 1 or this.health.magic_armor

	return {
		type = STATS_TYPE_ENEMY,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		damage_icon = this.info.damage_icon,
		armor = armor,
		magic_armor = magic_armor,
		lives = this.enemy and this.enemy.lives_cost or this._original_enemy and this._original_enemy.lives_cost,
		immune = this.health.immune_to == DAMAGE_ALL_TYPES
	}
end

function scripts.enemy_basic.insert(this, store, script)
	local next, new = P:next_entity_node(this, store.tick_length)

	if not next then
		log.debug("(%s) %s has no valid next node", this.id, this.template_name)

		return false
	end

	U.set_destination(this, next)
	U.set_heading(this, next)

	if not this.pos or this.pos.x == 0 and this.pos.y == 0 then
		this.pos = P:node_pos(this.nav_path.pi, this.nav_path.spi, this.nav_path.ni)
	end

	if this.render then
		for _, s in pairs(this.render.sprites) do
			s.ts = store.tick_ts
		end
	end

	if this.melee then
		this.melee.order = U.attack_order(this.melee.attacks)

		for _, a in pairs(this.melee.attacks) do
			a.ts = store.tick_ts
		end
	end

	if this.ranged then
		this.ranged.order = U.attack_order(this.ranged.attacks)

		for _, a in pairs(this.ranged.attacks) do
			a.ts = store.tick_ts
		end
	end

	if this.auras then
		for _, a in pairs(this.auras.list) do
			a.ts = store.tick_ts

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

	this.enemy.gold_bag = math.ceil(this.enemy.gold * 1.0)

	if this.water and this.spawn_data and this.spawn_data.water_ignore_pi then
		this.water.ignore_pi = this.spawn_data.water_ignore_pi
	end

	return true
end

function scripts.enemy_basic.remove(this, store, script)
	return true
end

scripts.enemy_bomb = {}

function scripts.enemy_bomb.insert(this, store, script)
	local b = this.bullet

	if b.flight_time_base and b.flight_time_factor then
		local dist = V.dist(b.to.x, b.to.y, b.from.x, b.from.y)

		b.flight_time = b.flight_time_base + dist * b.flight_time_factor
	end

	b.speed = SU.initial_parabola_speed(b.from, b.to, b.flight_time, b.g)
	b.ts = store.tick_ts
	b.last_pos = V.vclone(b.from)
	this.render.sprites[1].r = (math.random() - 0.5) * math.pi

	if b.hide_radius then
		this.render.sprites[1].hidden = true
	end

	return true
end

function scripts.enemy_bomb.update(this, store, script)
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

return scripts