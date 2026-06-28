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
local SU = require("script_utils_pld")
local U = require("utils_pld")
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

scripts.kr4_soldier_barrack = {}
function scripts.kr4_soldier_barrack.update(this, store, script)
	local brk, sta

	local function check_tower_damage_factor()
		local tower = store.entities[this.soldier.tower_id]
		if tower then
			for _, a in ipairs(this.melee.attacks) do
				if not a._original_damage_min then
					a._original_damage_min = a.damage_min
				end

				if not a._original_damage_max then
					a._original_damage_max = a.damage_max
				end

				a.damage_min = a._original_damage_min * tower.tower.damage_factor
				a.damage_max = a._original_damage_max * tower.tower.damage_factor
			end
		end
	end

	local function hide_shadow(isHidden)
		for i, sprite in pairs(this.render.sprites) do
			if sprite.is_shadow then
				sprite.hidden = isHidden
			end
		end
	end

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
			hide_shadow(true)
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
			hide_shadow(true)
			SU.y_soldier_death(store, this)
			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			SU.soldier_courage_upgrade(store, this)

			if this.dodge and this.dodge.active then
				this.dodge.active = false

				if this.dodge.counter_attack and this.powers[this.dodge.counter_attack.power_name].level > 0 then
					this.dodge.counter_attack_pending = true
				elseif this.dodge.animation then
					if this.dodge.hide_shadow then
						hide_shadow(true)
					end
					U.animation_start(this, this.dodge.animation, nil, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end
					hide_shadow(false)
				end

				signal.emit("soldier-dodge", this)
			end

			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_43_1
				end
			end

			check_tower_damage_factor()
			
			if this.timed_actions then
				brk, sta = SU.y_soldier_timed_actions(store, this)

				if brk then
					goto label_43_1
				end
			end

			if this.timed_attacks then
				brk, sta = SU.y_soldier_timed_attacks(store, this)

				if brk then
					goto label_43_1
				end
			end

			if this.ranged and this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					goto label_43_1
				end
			end

			if this.melee then
				if this.dodge and this.dodge.hide_shadow and this.dodge.counter_attack_pending then
					hide_shadow(true)
				end
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)
				if this.dodge and this.dodge.hide_shadow then
					hide_shadow(false)
				end

				if brk or sta ~= A_NO_TARGET then
					goto label_43_1
				end
			end

			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk or sta == A_DONE then
					goto label_43_1
				elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
					goto label_43_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_43_1
			end

			::label_43_0::

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

		::label_43_1::

		coroutine.yield()
	end
end

scripts.kr4_enemy_mixed = {}
function scripts.kr4_enemy_mixed.update(this, store, script)
	local function check_unit_attack(store, this, a)
		if SU.check_unit_attack_available(store, this, a) then
			return SU.entity_attacks(store, this, a)
		end
		return false
	end

	local walk_break_fn = function(store, this)
		if this.timed_attacks then
			for i, a in ipairs(this.timed_attacks.list) do
				if check_unit_attack(store, this, a) then
					return true
				end
			end
		end
		return false
	end

	local melee_break_fn = function(store, this)
		if this.timed_attacks then
			for i, a in ipairs(this.timed_attacks.list) do
				if a.melee_break and check_unit_attack(store, this, a) then
					return true
				end
			end
		end
		return false
	end

	local ranged_break_fn = function(store, this)
		if this.timed_attacks then
			for i, a in ipairs(this.timed_attacks.list) do
				if a.ranged_break and check_unit_attack(store, this, a) then
					return true
				end
			end
		end
		return false
	end

	if this.timed_attacks then
		for i, a in ipairs(this.timed_attacks.list) do
			a.ts = store.tick_ts
		end
	end

	if this.render.sprites[1].name == "raise" then
		if this.sound_events and this.sound_events.raise then
			S:queue(this.sound_events.raise, this.sound_events.raise_args)
		end
		this.health_bar.hidden = true
		local an, af = U.animation_name_facing_point(this, "raise", this.motion.dest)
		SU.hide_shadow(this, true)
		U.y_animation_play(this, an, af, store.tick_ts, 1)
		SU.hide_shadow(this, false)
		if not this.health.dead then
			this.health_bar.hidden = nil
		end
	end

	local ps
	if this.particle then
		ps = {}
		if type(this.particle) == "table" then
			for i, value in ipairs(this.particle) do
				local p = E:create_entity(value)
				p.particle_system.emit = true
				p.particle_system.track_id = this.id
				queue_insert(store, p)
				table.insert(ps, p)
			end
		else
			local p = E:create_entity(this.particle)
			p.particle_system.emit = true
			p.particle_system.track_id = this.id
			queue_insert(store, p)
			table.insert(ps, p)
		end
	end

	::label_29_0::

	while true do
		if this.health.dead then
			if ps then
				for i, p in ipairs(ps) do
					p.particle_system.emit = nil
				end
			end

			SU.hide_shadow(this, true)
			SU.y_enemy_death(store, this)

			if this.deadth_fn then
				this.deadth_fn(this, store, script)
			end

			return
		end

		if this.unit.is_stunned then
			SU.y_enemy_stun(store, this)
		else
			SU.y_enemy_mixed_walk_melee_ranged(store, this, false, walk_break_fn, melee_break_fn, ranged_break_fn)
			
			if ps and this.render then
				for i, p in ipairs(ps) do
					p.particle_system.flip_x = this.render.sprites[1].flip_x
				end
			end

			coroutine.yield()
		end
	end
end

scripts.enemy_crystal_demolisher = {}
function scripts.enemy_crystal_demolisher.death_fn(this, store, script)
	local death = this.death
	local targets = U.find_enemies_in_range(store.entities, this.pos, death.min_range, death.max_range, death.vis_flags, death.vis_bans)

	if targets then
		for i, t in pairs(targets) do
			if death.count and i > death.count then
				break
			end

			local d = E:create_entity("damage")

			d.source_id = this.id
			d.target_id = t.id
			d.damage_type = death.damage_type
			d.value = math.ceil(this.unit.damage_factor * death.damage)

			queue_damage(store, d)
		end
	end
end

scripts.enemy_bullywags_erudite = {}
function scripts.enemy_bullywags_erudite.remove(this, store, script)
	local ba = this.ranged.attacks[1]
	
	for i, b in pairs(ba._stored_bullets) do
		queue_remove(store, b)
	end
	return true
end

scripts.infuser_cast_shield_mod = {}
function scripts.infuser_cast_shield_mod.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or target.health.dead then
		return false
	end

	m.ts = store.tick_ts
	target._shield_mod = this
	target.health._origin_on_damage = target.health.on_damage
	target.health.on_damage = scripts.infuser_cast_shield_mod.on_damage
	this._hit_sources = {}
	this._blood_color = target.unit.blood_color
	target.unit.blood_color = BLOOD_NONE
	this.health.hp = this.modifier.shield_hp
	this.health.hp_max = this.modifier.shield_hp

	return true
end

function scripts.infuser_cast_shield_mod.update(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]
	m.ts = store.tick_ts
	local s = this.render.sprites[1]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	SU.set_mod_offset(store, this, m.target_id)

	U.y_animation_play(this, this.animations[1], nil, store.tick_ts)

	while true do
		if not target or target.health.dead then
			U.y_animation_play(this, this.animations[3], nil, store.tick_ts)
			queue_remove(store, this)

			return
		end

		SU.set_mod_offset(store, this, m.target_id)

		U.y_animation_play(this, this.animations[2], nil, store.tick_ts)

		if this.ready_removed then
			U.y_animation_play(this, this.animations[3], nil, store.tick_ts)

			queue_remove(store, this)
		end

		coroutine.yield()
	end
end

function scripts.infuser_cast_shield_mod.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		target.health.on_damage = target.health._origin_on_damage
		target._shield_mod = nil
		target.unit.blood_color = this._blood_color
	end

	return true
end

function scripts.infuser_cast_shield_mod.on_damage(this, store, damage)
	local mod = this._shield_mod

	if not mod then
		log.error("infuser_cast_shield_mod.on_damage for enemy %s has no mod pointer", this.id)

		return true
	end

	local pd = U.predict_damage(this, damage)

	if pd >= this.health.hp then
		mod.ready_removed = true

		return false
	end

	mod.health.hp = mod.health.hp - pd

	return false
end

scripts.infuser_cast_speed_mod = {}
function scripts.infuser_cast_speed_mod.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if scripts.mod_slow.insert(this, store, script) then
		if not (target.render and target.render.sprites[1].angles) then
			return false
		end

		this.origin_walk_animations = target.render.sprites[1].angles.walk
		target.render.sprites[1].angles.walk = this.walk_animations

		return true
	end

	return false
end

function scripts.infuser_cast_speed_mod.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if scripts.mod_slow.remove(this, store, script) then
		if not target or target.health.dead then
			return false
		end
		
		target.render.sprites[1].angles.walk = this.origin_walk_animations

		return true
	end

	return false
end

scripts.bullywag_bubble_crystal = {}
function scripts.bullywag_bubble_crystal.update(this, store, script)
	local a1 = this.attacks.list[1]
	local bullets = {}
	a1.ts = store.tick_ts
	this.ui.clicked = nil
	this.ui.can_click = nil
	U.animation_start_group(this, "cooldown", nil, store.tick_ts, true, this.animation_group1)
	while true do
		if this.ui.clicked then
			this.ui.clicked = nil
			this.ui.can_click = nil
			targets = U.find_soldiers_in_range(store.entities, this.pos, 0, a1.range, a1.vis_flags, a1.vis_bans)
			if targets then
				S:queue(a1.sound, a1.sound_args)
				U.animation_start_group(this, a1.animation, nil, store.tick_ts, true, this.animation_group1)
				for i, target in ipairs(targets) do
					if i > a1.max_targets then
						break
					end
					local mod = E:create_entity(a1.mod)

					mod.modifier.target_id = target.id

					queue_insert(store, mod)

					local mod2 = E:create_entity(a1.mod2)

					mod2.modifier.target_id = target.id

					queue_insert(store, mod2)
					a1.ts = store.tick_ts
				end

				local pulse = E:create_entity("decal_bubble_crystal_pulse")

				pulse.pos.x, pulse.pos.y = this.pos.x, this.pos.y
				pulse.render.sprites[1].ts = store.tick_ts

				queue_insert(store, pulse)
				
				U.animation_start_group(this, "cooldown", nil, store.tick_ts, true, this.animation_group1)
			else
				this.tween.disabled = true
				this.ui.can_click = true
			end
		end
		
		if store.tick_ts - a1.ts >= a1.cooldown then
			U.animation_start_group(this, "ready", nil, store.tick_ts, true, this.animation_group1)
			this.ui.can_click = true
		end

		coroutine.yield()
	end	
end

scripts.multi_sprite_fx = {}

function scripts.multi_sprite_fx.update(this, store)
	local start_ts = store.tick_ts
	local this_sprites = this.render.sprites
	local finished_anims = {}
	local delayed_sprites = {}

	for i = 1, #this_sprites do
		local s = this_sprites[i]

		if s.animated then
			if s.delay_start then
				delayed_sprites[i] = s.delay_start + start_ts
			else
				U.animation_start(this, s.name, nil, store.tick_ts, false, i, true)
			end

			finished_anims[i] = false
		else
			finished_anims[i] = true
		end
	end

	if this.tween then
		this.tween.ts = store.tick_ts
	end

	local function handle_finished_anim(index)
		if delayed_sprites[index] then
			if store.tick_ts > delayed_sprites[index] then
				this_sprites[index].hidden = false

				U.animation_start(this, this_sprites[index].name, nil, store.tick_ts, false, index, true)

				delayed_sprites[index] = nil
			end

			return false
		end

		if finished_anims[index] then
			return false
		end

		if not U.animation_finished(this, index, 1) then
			return false
		end

		this_sprites[index].hidden = true
		finished_anims[index] = true

		for i = 1, #this_sprites do
			if not finished_anims[i] then
				return false
			end
		end

		return true
	end

	while true do
		for i = 1, #this_sprites do
			if handle_finished_anim(i) then
				if not this.tween or not this.tween.remove then
					queue_remove(store, this)
				end

				return
			end
		end

		coroutine.yield()
	end
end

scripts.bullywag_spawner = {}
function scripts.bullywag_spawner.update(this, store, script)
	local sp = this.spawner

	while true do
		SU.mixed_entity_play_animation(this, sp.animations[1], store.tick_ts,
		sp.facing_point, true)
		if sp.spawn_data then

			sp.spawn_data = nil

			SU.mixed_entity_play_animation(this, sp.animations[2], store.tick_ts,
				sp.facing_point)
			SU.mixed_entity_play_animation(this, sp.animations[3], store.tick_ts, sp.facing_point)
			SU.mixed_entity_play_animation(this, sp.animations[4], store.tick_ts, sp.facing_point)
		else
			SU.mixed_entity_animation_wait(this, sp.animations[1])
			SU.mixed_entity_animation_wait(this, sp.animations[4])
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.overcharge_crystal = {}
function scripts.overcharge_crystal.update(this, store, script)
	local a1 = this.attacks.list[1]
	this.charging = false
	this.charged = false
	this.decharge = false
	this.charging_stage = 0
	local bullets = {}
	a1.ts = store.tick_ts

	local charging_ts = store.tick_ts
	U.animation_start_group(this, "idle", nil, store.tick_ts, true, this.animation_group1)
	while true do
		--受到注能，进入充能状态
		if this.charging_stage == 0 and this.charging == true then
			this.charging = false
			this.charging_stage = 1
			U.animation_start_group(this, "charging", nil, store.tick_ts, true, this.animation_group1)
			charging_ts = store.tick_ts
			goto label_745_0
		end

		--充能被打断，进入休眠状态
		if this.charging_stage == 1 and this.decharge == true then
			this.decharge = false
			U.animation_start_group(this, "idle", nil, store.tick_ts, true, this.animation_group1)
			goto label_745_0
		end

		--充能充满，开始攻击
		if this.charging_stage == 1 and this.charged == true then
			this.charging_stage = 2
			this.chaged = false
			--S:queue("frog_infuser_crystal_charged")
			U.animation_start_group(this, "charged", nil, store.tick_ts, true, animation_group1)
			U.y_wait(store, fts(48))

			--找地图上是否有塔。如果有则攻击。

			local targets = table.filter(store.entities, function(k, v)
				return v.tower and v.tower.type ~= "holder" and v.ui.can_click and U.is_inside_ellipse(v.pos, this.pos, a1.max_range) or v.tower and not v.pending_removal and not v.tower.blocked and (not a1.excluded_templates or not table.contains(a1.excluded_templates, v.template_name)) and U.is_inside_ellipse(v.pos, this.pos, a1.max_range) and (a1.min_range == 0 or not U.is_inside_ellipse(v.pos, this.pos, a1.min_range)) and v.vis and band(v.vis.flags, a1.vis_bans) == 0 and band(v.vis.bans, a1.vis_flags) == 0 and not table.contains(a1.exclude_tower_kind, v.tower.kind) and not U.has_modifiers(store, v, a1.mod) and v.tower.can_be_mod
			end)
			if targets and #targets > 0 then
				target = table.random(targets)

				U.y_animation_play_group(this, "shoot", nil, store.tick_ts, 1, animation_group1)
				--S:queue("frog_infuser_crystal_bolt-loopstart")

				local fx = E:create_entity("fx_lightining_soldier_tower_pandas_blue")
				fx.pos = V.v(target.pos.x, target.pos.y)
				fx.render.sprites[1].ts = store.tick_ts
				queue_insert(store, fx)

				local mod = E:create_entity(a1.mod)
				mod.modifier.target_id = target.id
				mod.modifier.source_id = this.id
				mod.pos = target.pos
				queue_insert(store, mod)

				U.y_animation_wait(this)

				U.animation_start_group(this, "idle", nil, store.tick_ts, true, this.animation_group1)

			end
			U.animation_start_group(this, "idle", nil, store.tick_ts, true, this.animation_group1)
			this.charging = false
			this.charged = false
			this.decharge = false
			this.charging_stage = 0
			goto label_745_0
		end
	
		::label_745_0::
		coroutine.yield()
	end	
end

scripts.ray_simple_silent = {}

function scripts.ray_simple_silent.update(this, store)
	local b = this.bullet
	local s = this.render.sprites[1]
	local target = store.entities[b.target_id]
	local dest = V.vclone(b.to)
	local source = store.entities[b.source_id]


	local interrupt = false

	local function update_sprite()
		if this.track_target and target and target.motion then
			local tpx, tpy = target.pos.x, target.pos.y

			if not b.ignore_hit_offset then
				tpx, tpy = tpx + target.unit.hit_offset.x, tpy + target.unit.hit_offset.y
			end

			local d = math.max(math.abs(tpx - b.to.x), math.abs(tpy - b.to.y))

			if d > b.max_track_distance then
				log.paranoid("(%s) ray_simple target (%s) out of max_track_distance", this.id, target.id)

				target = nil
			else
				dest.x, dest.y = target.pos.x, target.pos.y

				if target.unit and target.unit.hit_offset then
					dest.x, dest.y = dest.x + target.unit.hit_offset.x, dest.y + target.unit.hit_offset.y
				end
			end
		end

		local angle = V.angleTo(dest.x - this.pos.x, dest.y - this.pos.y)

		s.r = angle
		s.scale.x = V.dist(dest.x, dest.y, this.pos.x, this.pos.y) / this.image_width
		s.scale.x = s.scale.x * 1.28
	end

	local function interrupt_judge()
		interrupt = (source.health.dead == true or source.unit.is_stunned == true)
	end

	if not b.ignore_hit_offset and this.track_target and target and target.motion then
		b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
	end

	s.scale = s.scale or V.v(1, 1)
	s.ts = store.tick_ts

	update_sprite()

	if target.charging_stage == 0 then
		target.charging = true
	else
		goto label_1076_0
	end

	while store.tick_ts - s.ts < b.hit_time and interrupt == false do
		interrupt_judge()

		if target and U.flag_has(target.vis.bans, F_RANGED) then
			target = nil
		end

		if this.track_target then
			update_sprite()
		end
		coroutine.yield()
	end
	if interrupt == true then
		goto label_1076_1
	end

	--[[
	if target and b.damage_type ~= DAMAGE_NONE then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)
	end

	if target and (b.mod or b.mods) then
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
		local hp

		if type(b.hit_payload) == "string" then
			hp = E:create_entity(b.hit_payload)
		else
			hp = b.hit_payload
		end

		if hp.aura then
			hp.aura.level = this.bullet.level
			hp.aura.source_id = this.id

			if target then
				hp.pos.x, hp.pos.y = target.pos.x, target.pos.y
			else
				hp.pos.x, hp.pos.y = dest.x, dest.y
			end
		else
			hp.pos.x, hp.pos.y = dest.x, dest.y
		end

		queue_insert(store, hp)
	end

	if b.hit_fx then
		local is_air = target and band(target.vis.flags, F_FLYING) ~= 0
		local fx = E:create_entity(b.hit_fx)

		if b.hit_fx_ignore_hit_offset and target and not is_air then
			fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
		else
			fx.pos.x, fx.pos.y = dest.x, dest.y
		end

		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
	end

	if this.ray_duration then
		while store.tick_ts - s.ts < this.ray_duration and target and not target.health.dead do
			if this.track_target then
				update_sprite()
			end
			coroutine.yield()
		end
	else
		U.y_animation_wait(this)
	end
	]]--
	::label_1076_1::

	if interrupt == false then 
		target.charged = true
	else
		target.decharge = true
	end

	::label_1076_0::
	this.skip_charging = true
	S:stop(this.sound_events.insert)
	queue_remove(store, this)
end

scripts.mod_erudite_buff = {}

function scripts.mod_erudite_buff.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if not target or target.health.dead or target.enemy and not target.enemy.can_accept_magic then
		return false
	end

	if band(this.modifier.vis_flags, target.vis.bans) ~= 0 or band(this.modifier.vis_bans, target.vis.flags) ~= 0 then
		log.paranoid("mod %s cannot be applied to entity %s:%s because of vis flags/bans", this.template_name, target.id, target.template_name)

		return false
	end

	local buff = this.armor_buff
	local inc = buff.max_factor

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

	target.ranged.attacks[1].bullet = "enemy_bullywags_erudite_upgrade_bolt"

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_erudite_buff.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if target then
		local buff = this.armor_buff

		if buff.magic then
			SU.magic_armor_dec(target, buff._total_factor)
		else
			SU.armor_dec(target, buff._total_factor)
		end
		target.ranged.attacks[1].bullet = "enemy_bullywags_erudite_bolt"
	end

	return true
end

function scripts.mod_erudite_buff.update(this, store, script)
	local buff = this.armor_buff
	local m = this.modifier
	local last_ts = store.tick_ts
	local target = store.entities[m.target_id]

	if not target then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	while true do
		target = store.entities[m.target_id]

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

return scripts