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

scripts.elves_soldier_harasser_lvl4 = {}
function scripts.elves_soldier_harasser_lvl4.update(this, store, script)
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
		local b = this.barrack
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
			hide_shadow(true)
			local tower = store.entities[this.soldier.tower_id]
			if this.powers.last_breath.level > 0 and tower and this.death_spawns.quantity > 0 then
				local unit = E:create_entity(this.death_spawns.name)
				unit.soldier.tower_id = this.soldier.tower_id
				unit.soldier.tower_soldier_idx = this.soldier.tower_soldier_idx
				unit.pos = V.vclone(this.pos)
				unit.nav_rally.pos, unit.nav_rally.center = U.rally_formation_position(this.soldier.tower_soldier_idx, tower.barrack, tower.barrack.max_soldiers)
				unit.nav_rally.new = true
				queue_insert(store, unit)
				tower.barrack.soldiers[this.soldier.tower_soldier_idx] = unit
				queue_remove(store, this)
			else
				SU.y_soldier_death(store, this)
			end
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
					goto label_44_1
				end
			end

			check_tower_damage_factor()

			if this.ranged and this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					goto label_44_1
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
					goto label_44_1
				end
			end

			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk or sta == A_DONE then
					goto label_44_1
				elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
					goto label_44_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_44_1
			end

			::label_44_0::

			SU.soldier_idle(store, this)
			SU.soldier_regen(store, this)
		end

		::label_44_1::

		coroutine.yield()
	end
end

scripts.elves_soldier_espectral_harasser = {}
function scripts.elves_soldier_espectral_harasser.update(this, store, script)
	local brk, stam, star
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

	this.reinforcement.ts = store.tick_ts
	this.render.sprites[1].ts = store.tick_ts

	if this.reinforcement.fade or this.reinforcement.fade_in then
		SU.y_reinforcement_fade_in(store, this)
	elseif this.render.sprites[1].name == "raise" then
		this.health.ignore_damage = true
		if this.sound_events and this.sound_events.raise then
			S:queue(this.sound_events.raise, this.sound_events.raise_args)
		end
		this.health_bar.hidden = true
		U.y_animation_play(this, "raise", nil, store.tick_ts, 1)
		this.health.ignore_damage = false
		if not this.health.dead then
			this.health_bar.hidden = nil
		end
	end

	local ps = E:create_entity(this.particle)
	ps.particle_system.emit = this.nav_rally.new
	ps.particle_system.track_id = this.id
	queue_insert(store, ps)

	while true do
		if this.health.dead or this.reinforcement.duration and store.tick_ts - this.reinforcement.ts > this.reinforcement.duration then
			ps.particle_system.emit = nil
			if this.health.hp > 0 then
				this.reinforcement.hp_before_timeout = this.health.hp
			end
			this.health.hp = 0
			if IS_KR5 then
				SU.remove_modifiers(store, this)
			end
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
					U.animation_start(this, this.dodge.animation, nil, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end
				end

				signal.emit("soldier-dodge", this)
			end

			while this.nav_rally.new do
				ps.particle_system.emit = true
				if SU.y_hero_new_rally(store, this) then
					goto label_38_1
				end
			end
			ps.particle_system.emit = nil

			check_tower_damage_factor()

			if this.melee then
				brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
					goto label_38_1
				end
			end

			if this.ranged then
				brk, star = SU.y_soldier_ranged_attacks(store, this)

				if brk or star == A_DONE then
					goto label_38_1
				elseif star == A_IN_COOLDOWN then
					goto label_38_0
				end
			end

			if this.melee.continue_in_cooldown and stam == A_IN_COOLDOWN then
				goto label_38_1
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_38_1
			end

			::label_38_0::

			SU.soldier_idle(store, this)
			SU.soldier_regen(store, this)
		end

		::label_38_1::

		coroutine.yield()
	end
end

scripts.tower_blazing_watcher = {}

function scripts.tower_blazing_watcher.get_info(this)
	local b = E:get_template(this.attacks.list[1].bullet)

	if not b.bullet.damage_min or not b.bullet.damage_max then
		b.bullet.damage_min = b.bullet.damage_min_config[this.tower.level]
		b.bullet.damage_max = b.bullet.damage_max_config[this.tower.level]
	end

	local o = scripts.tower_common.get_info(this)

	o.type = STATS_TYPE_TOWER_MAGE
	
	local min = math.ceil(b.bullet.damage_min * this.tower.damage_factor * this.attack_stage)
	local max = math.ceil(b.bullet.damage_max * this.tower.damage_factor * this.attack_stage)

	o.damage_min = min
	o.damage_max = max

	return o
end

function scripts.tower_blazing_watcher.update(this, store)
	--先定义powers
	local a = this.attacks
	local ab = this.attacks.list[1]
	local ad = this.attacks.list[2]--秒杀
	local ae = this.attacks.list[3]--爆炸。目前暂时先不实现，先实现充能和秒杀
	local pow_c = this.powers and this.powers.charging or nil
	local pow_d = this.powers and this.powers.disintegrate or nil
	local pow_e = this.powers and this.powers.explosion or nil
	local last_ts = store.tick_ts - ab.cooldown

	this.attack_stage = 1
	ab.ts = store.tick_ts - ab.cooldown + a.attack_delay_on_spawn

	local attacks = {}
	local pows = {}

	if ab then
		table.insert(attacks, ab)--普攻
		table.insert(pows, nil)
	end

	if ad then
		table.insert(attacks, ad)--秒杀
		table.insert(pows, pow_d)
	end

	if ae then 
		table.insert(attacks, ae)--亡语爆炸
		table.insert(pows, pow_e)
	end

	local function find_target(aa)
		local target, _, _ = ULH.find_backmost_enemy_in_range(store.entities, tpos(this), 0, a.range, aa.node_prediction, aa.vis_flags, aa.vis_bans, function(e, o)
			return not aa.excluded_templates or not table.contains(aa.excluded_templates, e.template_name)
		end)

		return target
	end

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if this.powers then
				for k, pow in pairs(this.powers) do
					if pow.changed then
						pow.changed = nil
						if pow == pow_c then
							if pow.level >= 1 then
								ab.max_rate = 4
							end						
						end

						if pow == pow_d then
							ad.disabled = false
							ad.cooldown = pow.cooldown[pow.level]
							ad.ts = store.tick_ts - ad.cooldown
						end

						if pow == pow_e then
						end

					end
				end
			end

			SU.towers_swaped(store, this, this.attacks.list)

			for _, aa in pairs(attacks) do
				if aa and not aa.disabled and store.tick_ts - aa.ts > aa.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local enemy = find_target(aa)
					if not enemy then
						SU.delay_attack(store, aa, fts(10))
					else
						last_ts = store.tick_ts
						S:queue(aa.sound)
						U.animation_start(this, "in", nil, store.tick_ts, false)

						if aa == ad then --秒杀
							U.animation_start(this, "chargedBlast", nil, store.tick_ts, false, 3)
							U.y_animation_wait(this, 4)
							U.animation_start_group(this, "loop", nil, store.tick_ts, true, "mage")

							U.y_wait(store, fts(18))
							local b = E:create_entity(aa.bullet)
							local start_offset = aa.bullet_start_offset

							enemy = find_target(aa)
							if not enemy then
								goto label_861_2
							end

							aa.ts = last_ts
							b.pos.x, b.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.vclone(enemy.pos)
							b.bullet.target_id = enemy.id
							b.bullet.source_id = this.id
							b.bullet.level = this.tower.level
							b.tower_ref = this
							queue_insert(store, b)

							::label_861_2::
							U.y_animation_wait(this, 3)
							U.animation_start(this, "idle", false, store.tick_ts, true, 3)
						elseif aa == ab then --普攻
							U.y_wait(store, fts(10))

							local b = E:create_entity(aa.bullet)
							local start_offset = aa.bullet_start_offset
							local charge_start = store.tick_ts

							local last_fx = store.tick_ts + fts(3)

							local range_to_stay = a.range + a.extra_range
							local enemy = find_target(aa)

							if not enemy then
								goto label_861_1
							end
							b.pos.x, b.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.vclone(enemy.pos)
							b.bullet.target_id = enemy.id
							b.bullet.source_id = this.id
							b.bullet.level = this.tower.level
							b.bullet.damage_factor = this.tower.damage_factor
							b.tower_ref = this

							queue_insert(store, b)

							U.y_animation_wait(this, 4)
							U.animation_start_group(this, "loop", nil, store.tick_ts, true, "mage")
							U.y_animation_wait(this, 3)
							U.animation_start(this, "loop", nil, store.tick_ts, true, 3)

							while enemy and not enemy.health.dead and not enemy.trigger_deselect and b and not b.force_stop_ray and not this.tower.blocked and not enemy._blazing_deselect and V.dist2(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= range_to_stay * range_to_stay do
								local charge_time = store.tick_ts - charge_start
								if charge_time > 3.6 then
									if pow_c and pow_c.level >= 1 and this.attack_stage < 4 then
										U.animation_start(this, "level4Loop", nil, store.tick_ts, true, 3)
									end
									if pow_c and pow_c.level >= 1 then
										this.attack_stage = math.min(4 + math.floor((charge_time-3.6) / 2.4), this.attack_stage_max)
									end
								elseif charge_time > 2.4 then
									if this.attack_stage < 3 then
										this.attack_stage = 3
									end
									if not pow_c or pow_c.level < 1 then
										charge_start = store.tick_ts - 2.4
									end
								elseif charge_time > 1.2 then
									if this.attack_stage < 2 then
										this.attack_stage = 2
									end
								end

								if store.tick_ts - last_fx > 1 and b.bullet.out_start_fx then
									local fx = E:create_entity(b.bullet.out_start_fx)

									fx.pos.x, fx.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y

									fx.render.sprites[1].ts = store.tick_ts

									queue_insert(store, fx)

									last_fx = store.tick_ts
								end

								if this.tower.blocked or V.dist2(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) > range_to_stay * range_to_stay or enemy._blazing_deselect or band(enemy.vis.bans, bor(F_AREA, F_RANGED))~=0 then
									b.force_stop_ray = true

									log.info("(%s) tower ray target (%s) out of range_to_stay", this.id, enemy.id)
									print(string.format("(%s) tower ray target (%s) out of range_to_stay", this.id, enemy.id))
								end

								if enemy and enemy.template_name == "enemy_tower_ray_sheep_flying" or enemy.template_name == "enemy_tower_ray_sheep" then
									b.force_stop_ray = true
								end

								coroutine.yield()

							end

							b.force_stop_ray = true
							
							:: label_861_1 ::
							aa.ts = last_ts
							if this.attack_stage >= 4 then
								U.animation_start(this, "level4Out", nil, store.tick_ts, false, 3)
							else
								U.animation_start(this, "out", nil, store.tick_ts, false, 3)
							end
							this.attack_stage = 1
						end

                        U.y_animation_play_group(this, "out", nil, store.tick_ts, false, "mage")
                        U.animation_start(this, "idle", nil, store.tick_ts, true)
						if aa.action_time then
							U.y_wait(store, aa.action_time)
						end
					end
				end
			end
			coroutine.yield()
		end
	end
end

--移除额外的射线。但是注意这个射线名字是红法的，需要换成当前的
function scripts.tower_blazing_watcher.remove(this, store)
	if this.ray_fx_start then
		queue_remove(store, this.ray_fx_start)
	end

	return true
end

scripts.bullet_tower_blazing_watcher = {}
function scripts.bullet_tower_blazing_watcher.update(this, store)
	local attack_stage = 0
	local b = this.bullet
	local s = this.render.sprites[1]
	local target = store.entities[b.target_id]
	local dest = V.vclone(b.to)
	local tower = this.tower_ref

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
				this.force_stop_ray = true
			else
				dest.x, dest.y = target.pos.x, target.pos.y

				if target.unit and target.unit.hit_offset then
					dest.x, dest.y = dest.x + target.unit.hit_offset.x, dest.y + target.unit.hit_offset.y
				end
			end

			if target then
				b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			end
		end

		local angle = V.angleTo(dest.x - this.pos.x, dest.y - this.pos.y)

		s.r = angle

		local dist_offset = 0

		if this.dist_offset then
			dist_offset = this.dist_offset
		end

		s.scale.x = (V.dist(dest.x, dest.y, this.pos.x, this.pos.y) + dist_offset) / this.image_width * 2.5
	end

	if not b.ignore_hit_offset and this.track_target and target and target.motion then
		b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
	end

	s.scale = s.scale or V.vv(1)

	U.animation_start(this, "in", nil, store.tick_ts, false, 1)
	update_sprite()

	if b.hit_time > fts(1) then
		while store.tick_ts - s.ts < b.hit_time do
			coroutine.yield()

			if target and U.flag_has(target.vis.bans, F_RANGED) then
				target = nil
			end

			if this.track_target then
				update_sprite()
			end
		end
	end

	local mods_added = {}

	if target and (b.mod or b.mods) then
		local mods = b.mods or {
			b.mod
		}

		for _, mod_name in pairs(mods) do
			local m = E:create_entity(mod_name)
			m.tower_ref = tower
			m.modifier.target_id = b.target_id
			m.modifier.source_id = this.id

			if m.damage_from_bullet then
				local d_mult = this.damage_mult * b.damage_factor

				if m.dps then
					m.dps.damage_min = math.ceil(b.damage_min * d_mult)
					m.dps.damage_max = math.ceil(b.damage_max * d_mult)
				end
			end

			table.insert(mods_added, m)
			queue_insert(store, m)

			if this.mod_start_ts then
				m.forced_start_ts = this.mod_start_ts
			end
		end
	end

	local disable_hit = false

	if this.hit_fx_only_no_target then
		disable_hit = target ~= nil and not target.health.dead
	end

	local fx
	if b.hit_fx and not disable_hit then
		local is_air = target and band(target.vis.flags, F_FLYING) ~= 0

		fx = E:create_entity(b.hit_fx)

		if b.hit_fx_ignore_hit_offset and target and not is_air then
			fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
		else
			fx.pos.x, fx.pos.y = dest.x, dest.y
		end

		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
	end

	this.render.sprites[2].hidden = false
	local source = store.entities[b.source_id]
	while target and not target.health.dead and not this.force_stop_ray and source do
		if attack_stage ~= tower.attack_stage then
			if tower.attack_stage >= 4 then
				U.animation_start(this, "loop4", nil, store.tick_ts, true, 1)
				mods_added[1].render.sprites[1].name = "blazing_watcher_hit_level4Run"
				this.render.sprites[2].name = "level4Run"
			elseif tower.attack_stage == 3 then
				U.animation_start(this, "loop3", nil, store.tick_ts, true, 1)
			elseif tower.attack_stage == 2 then
				U.animation_start(this, "loop2", nil, store.tick_ts, true, 1)
			else
				U.animation_start(this, "loop", nil, store.tick_ts, true, 1)
			end
			attack_stage = tower.attack_stage
		end
		if this.track_target then
			update_sprite()
		end

		if tower and not store.entities[tower.id] then
			break
		end

		target = store.entities[b.target_id]

		if target and band(target.vis.bans, this.vis_flags) ~= 0 then
			this.force_stop_ray = true

			break
		end

		coroutine.yield()

		s.hidden = false
		source = store.entities[b.source_id]

	end

	if not target or target.health.dead or this.force_stop_ray or not source then
		S:stop(this.sound_events.insert)
		S:queue(this.sound_events.interrupt)
	end

	if fx then
		queue_remove(store, fx)
	end

	for _, value in pairs(mods_added) do
		if not value.dps or not tower or this.force_stop_ray then
			queue_remove(store, value)
		end
	end

	this.render.sprites[2].hidden = true
	if attack_stage >= 4 then
		U.y_animation_play(this, "level4Out", nil, store.tick_ts, false, 1)
	else
		U.y_animation_play(this, "out", nil, store.tick_ts, false, 1)
	end

	this.render.sprites[1].hidden = true


	queue_remove(store, this)
end

scripts.mod_tower_blazing_watcher_damage = {}

function scripts.mod_tower_blazing_watcher_damage.update(this, store)
	local cycles, total_damage = 0, 0
	local m = this.modifier
	local factor = 0
	local dps = this.dps
	local target = store.entities[m.target_id]
	local tower = this.tower_ref
	if not target or target.health.dead then
		queue_remove(store, this)
		return
	end

	local source = store.entities[m.source_id]

	local function apply_damage(value)
		local d = E:create_entity("damage")
		local explosion_flag = false
		local pos
		d.source_id = this.id
		d.target_id = target.id
		d.value = value
		d.damage_type = dps.damage_type
		d.pop = dps.pop
		d.pop_chance = dps.pop_chance
		d.pop_conds = dps.pop_conds
		pos = target.pos
		if value * (1-target.health.magic_armor) > target.health.hp then
			explosion_flag = true
			pos = target.pos
		end
		queue_damage(store, d)
		
		if explosion_flag then
			if tower.powers and tower.powers.explosion.level > 0 then
				local blast = E:create_entity(tower.attacks.list[1].payload_bullet)
				blast.pos = pos
				blast.bullet.level = tower.powers.explosion.level * factor
				blast.attack_stage = math.min(tower.attack_stage, 4)
				queue_insert(store, blast)
			end
		end
		--local effective_dmg = U.predict_damage(target, d)

		--total_damage = total_damage + effective_dmg
	end

	local function apply_true_damage(value, add_to_total)
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = target.id
		d.value = value
		d.damage_type = DAMAGE_TRUE
		d.pop = dps.pop
		d.pop_chance = 0

		queue_damage(store, d)

		local effective_dmg = U.predict_damage(target, d)

		if add_to_total then
			total_damage = total_damage + effective_dmg
		end
	end

	local function calculate_dps_damage(tier)
		local current_tier = km.clamp(0, #raw_damage_tiers, tier)
		local cycles_in_tier = m.duration / (#raw_damage_tiers * dps.damage_every)

		dps_damage = math.floor(raw_damage_tiers[current_tier] / cycles_in_tier)
	end

	local function get_expected_true_damage(value)
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = target.id
		d.value = value
		d.damage_type = dps.damage_type

		return U.predict_damage(target, d)
	end

	local function get_expected_true_damage_after_tier(tier)
		local total_acc_dmg = 0

		for i = 1, tier do
			total_acc_dmg = total_acc_dmg + raw_damage_tiers[i]
		end

		return get_expected_true_damage(math.floor(total_acc_dmg))
	end

	this.pos = target.pos
	dps.ts = store.tick_ts
	m.ts = store.tick_ts

	if this.forced_start_ts then
		m.ts = this.forced_start_ts
	end

	while true do
		target = store.entities[m.target_id]
		source = store.entities[m.source_id]
		local raw_damage = 0

		if not target or target.health.dead then
			break
		end

		if this.render and m.use_mod_offset and target.unit.hit_offset then
			for _, s in ipairs(this.render.sprites) do
				s.offset.x, s.offset.y = target.unit.hit_offset.x, target.unit.hit_offset.y
			end
		end

		if dps.damage_every and store.tick_ts - dps.ts >= dps.damage_every then
			cycles = cycles + 1
			dps.ts = dps.ts + dps.damage_every
			
			factor = this.damage_tiers[tower.attack_stage] * tower.tower.damage_factor
			raw_damage = math.random(this.dps.damage_min * factor, this.dps.damage_max * factor)
			apply_damage(raw_damage)
		end

		if not source or source.force_stop_ray then
			break
		end

		coroutine.yield()
	end

	this.tween.disabled = false
	this.tween.ts = store.tick_ts

end

scripts.bullet_tower_blazing_watcher_chargedBlast = {}
function scripts.bullet_tower_blazing_watcher_chargedBlast.update(this, store)
	local b = this.bullet
	local s = this.render.sprites[1]
	local target = store.entities[b.target_id]
	local tower = this.tower_ref

	local function update_sprite()
		if target and target.unit and target.unit.hit_offset then
			b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
		end
		local dest = V.vclone(b.to)
		local angle = V.angleTo(dest.x - this.pos.x, dest.y - this.pos.y)
		s.r = angle

		local dist_offset = 0
		if this.dist_offset then
			dist_offset = this.dist_offset
		end

		s.scale.x = (V.dist(dest.x, dest.y, this.pos.x, this.pos.y) + dist_offset) / this.image_width * 2.6667
	end

	s.scale = s.scale or V.vv(1)

	U.animation_start(this, "chargedBlast", nil, store.tick_ts, false, 1)
	update_sprite()
	this.render.sprites[2].hidden = false

	local mods_added = {}

	if target and (b.mod or b.mods) then
		local mods = b.mods or {
			b.mod
		}

		for _, mod_name in pairs(mods) do
			local m = E:create_entity(mod_name)
			m.tower_ref = tower
			m.modifier.target_id = b.target_id
			m.modifier.source_id = this.id

			table.insert(mods_added, m)
			queue_insert(store, m)

			if this.mod_start_ts then
				m.forced_start_ts = this.mod_start_ts
			end
		end
	end
	U.y_animation_wait(this)
	this.render.sprites[1].hidden = true
	this.render.sprites[2].hidden = true

	queue_remove(store, this)
end

scripts.blazing_watcher_ray_chargedBlast_mod = {}

function scripts.blazing_watcher_ray_chargedBlast_mod.update(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or target.health.dead then
		return
	end

	this.pos = target.pos
	m.ts = store.tick_ts

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead then
			break
		end

		if store.tick_ts - m.ts >= m.duration then

				local d = E:create_entity("damage")
				d.source_id = this.id
				d.target_id = target.id
				d.damage_type = m.damage_type
				d.value = m.damage
				d.pop = m.pop
				d.pop_chance = m.pop_chance
				d.pop_conds = m.pop_conds

				queue_damage(store, d)

				break
			
		end

		if this.render and m.use_mod_offset and target.unit.hit_offset then
			this.render.sprites[1].offset.x, this.render.sprites[1].offset.y = target.unit.hit_offset.x, target.unit.hit_offset.y
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end	

scripts.blazing_watcher_bolt_blast = {}

function scripts.blazing_watcher_bolt_blast.insert(this, store)
	return true
end

function scripts.blazing_watcher_bolt_blast.update(this, store)
	local b = this.bullet
	local dradius = b.damage_radius
	local dmin = b.damage_min * b.level
	local dmax = b.damage_max * b.level
	local explode_pos = V.v(this.pos.x, this.pos.y)

	if this.attack_stage == 4 then
		U.animation_start(this, "level4Run", nil, store.tick_ts, false)
	else
		U.animation_start(this, "run", nil, store.tick_ts, false)
	end
	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, explode_pos, dradius)
	end)
	local d_value = math.ceil(U.frandom(dmin, dmax))
	S:queue(this.sound_events.insert)
	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = d_value
		d.damage_type = b.damage_type
		--d.damage_radius = b.damage_radius
		--d.damage_flags = b.damage_flags
		d.track_damage = true
		queue_damage(store, d)
	end

	U.y_animation_wait(this)

	queue_remove(store, this)
end

scripts.tower_ignis_altar = {}

function scripts.tower_ignis_altar.get_info(this)
	local b = E:get_template(this.attacks.list[1].bullet)

	if not b.bullet.damage_min or not b.bullet.damage_max then
		b.bullet.damage_min = b.bullet.damage_min_config[this.tower.level]
		b.bullet.damage_max = b.bullet.damage_max_config[this.tower.level]
	end

	local o = scripts.tower_common.get_info(this)

	--o.type = STATS_TYPE_TOWER_MAGE
	damage_panel = {20,44,78,152}
	damage_basic = {2,4,6,8}
	damage_times = {10,11,13,19}
	local min = math.ceil(damage_basic[this.tower.level]*this.tower.damage_factor) * damage_times[this.tower.level] --math.ceil(b.bullet.damage_min * this.tower.damage_factor)
	local max = min--math.ceil(b.bullet.damage_max * this.tower.damage_factor)

	o.damage_min = min
	o.damage_max = max

	return o
end

function scripts.tower_ignis_altar.update(this, store)
	local a = this.attacks 
	local ab = this.attacks.list[1]
	local aw = this.attacks.list[2]
	local pow_e = this.powers and this.powers.golemstone or nil
	local pow_w = this.powers and this.powers.firewheel or nil
	local pow_s = this.powers and this.powers.stickylava or nil
	local last_ts = store.tick_ts - ab.cooldown
	local ba = this.barrack

	a._last_target_pos = a._last_target_pos or v(REF_W, 0)
	ab.ts = store.tick_ts - ab.cooldown + a.attack_delay_on_spawn

	local attacks = {}
	local pows = {}
	this.bullet_loaded = false;

	if ab then
		table.insert(attacks, ab)--普攻
		table.insert(pows, nil)
	end

	if aw then
		table.insert(attacks, aw)--易伤
		table.insert(pows, pow_w)
	end

	local function load_bullet()
		if this.bullet_loaded then return end
		U.y_animation_play(this, "carga", nil, store.tick_ts, false, 2)
		this.bullet_loaded = true;
	end
	load_bullet()

	while true do 
		if this.tower.blocked then
			coroutine.yield()
		else
			if this.powers then		

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
						--ns.pos = last_soldier_pos or V.v(ba.rally_pos.x, ba.rally_pos.y)
						ns.pos = V.v(ba.rally_pos.x, ba.rally_pos.y)
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

				if pow_s.level > 0 then
					--empty
				end

				if pow_w.level > 0 and pow_w.changed then 
					pow_w.changed = nil
					aw.disabled = false
					aw.cooldown = pow_w.cooldown
					aw.ts = store.tick_ts - aw.cooldown
				end

			end

			SU.towers_swaped(store, this, this.attacks.list)

			for i, aa in pairs(attacks) do
				if aa and not aa.disabled and store.tick_ts - aa.ts > aa.cooldown then 
					if aa == aw then
						local enemy, _, pred_pos = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						if not enemy then
							SU.delay_attack(store, aa, fts(10))
						else
							local enemy_id = enemy.id
							local shoot_pos = pred_pos

							last_ts = store.tick_ts

							U.y_wait(store, aa.shoot_time, false)
							S:queue(aa.sound)

							enemy, __ = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
							if not enemy or not pred_pos then
								enemy, __ = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
							end

							if enemy then
								enemy_id = enemy.id
								shoot_pos = V.vclone(enemy.pos)
								
							end
							
							local b = E:create_entity(aa.bullet)
							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = shoot_pos
							b.bullet.target_id = enemy_id
							b.bullet.source_id = this.id
							b.bullet.level = this.powers.firewheel.level
							b.bullet.damage_factor = this.tower.damage_factor
							b.bullet.damage_min = this.powers.firewheel.damage[b.bullet.level]
							b.bullet.damage_max = this.powers.firewheel.damage[b.bullet.level]
							queue_insert(store, b)
							
							aa.ts = last_ts
						end
					elseif aa == ab then

						local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						if not enemy then
							SU.delay_attack(store, aa, fts(10))
						else
							last_ts = store.tick_ts

							S:queue(aa.sound)
							U.animation_start(this, "shoot", nil, store.tick_ts, false, 2)
							U.y_wait(store, fts(11))

							a._last_target_pos.x, a._last_target_pos.y = enemy.pos.x, enemy.pos.y

							local trigger_pos = pred_pos
							local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

							if enemy then 
								local ni = enemy.nav_path.ni + P:predict_enemy_node_advance(enemy, aa.node_prediction)
								pred_pos = P:node_pos(enemy.nav_path.pi, 1, ni)
							end

							local b = E:create_entity(aa.bullet)
							b.bullet.damage_factor = this.tower.damage_factor
							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = enemy and pred_pos or trigger_pos
							b.bullet.source_id = this.id

							b.bullet.level = this.level
							b.bullet.damage_factor = this.tower.damage_factor
							b.tower_ref = this

							queue_insert(store, b)
							this.bullet_loaded = false;

							::label_421_1::
							U.y_animation_wait(this, 2)
							load_bullet()
							U.animation_start(this, "idle", nil, store.tick_ts, false, 2)
							aa.ts = last_ts
						end
					end
				end
					
			end
			coroutine.yield()
		end
	end
	return true
end

scripts.ignis_altar_bomb = {}
function scripts.ignis_altar_bomb.update(this, store)
	local b = this.bullet
	local dmin, dmax = b.damage_min, b.damage_max
	local dradius = b.damage_radius
	local tower = this.tower_ref

	if tower.powers and tower.powers.stickylava.level >= 1 then
		b.hit_payload = "aura2_bullet_tower_ignis_altar"
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

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, dradius)
	end)

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.damage_type = DAMAGE_EXPLOSION--b.damage_type
		d.reduce_armor = b.reduce_armor
		d.reduce_magic_armor = b.reduce_magic_armor

		d.value = U.frandom(dmin, dmax)


		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id

		if b.xp_gain_factor and b.xp_dest_id then
			d.xp_gain_factor = b.xp_gain_factor
			d.xp_dest_id = b.source_id
		end

		queue_damage(store, d)
		log.paranoid("bomb id:%s, radius:%s, enemy id:%s, dist:%s, damage:%s damage_type:%x", this.id, dradius, enemy.id, V.dist(enemy.pos.x, enemy.pos.y, b.to.x, b.to.y), d.value, d.damage_type)

		if this.up_shock_and_awe_chance and band(enemy.vis.bans, F_STUN) == 0 and band(enemy.vis.flags, bor(F_BOSS, F_CLIFF, F_FLYING)) == 0 and math.random() < this.up_shock_and_awe_chance then
			local mod = E:create_entity("mod_shock_and_awe")

			mod.modifier.target_id = enemy.id

			queue_insert(store, mod)
		end


	end

	if b.mod then
			local mod = E:create_entity(b.mod)
			--mod.pos.x, mod.pos.y = this.pos.x, this.pos.y
			mod.bullet.dradius = b.damage_radius
			mod.bullet.damage_min = b.damage_min
			mod.bullet.damage_max = b.damage_max
			mod.bullet.damage_every = b.damage_every
			mod.bullet.explode_pos = V.v(this.pos.x, this.pos.y)
			mod.bullet.aura_duration = b.aura_duration
			mod.bullet.damage_type = b.damage_type
			mod.bullet.damage_flags = b.damage_flags
			mod.bullet.damage_factor = b.damage_factor

			queue_insert(store, mod)
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
		hp.source_id = b.source_id
		
		if hp.aura then
			hp.aura.level = 1--this.bullet.level
			hp.aura.duration = this.aura_duration
			hp.tween.props[1].keys = {
				{
					0,
					255
				},
				{
					hp.aura.duration - 0.5,
					255
				},
				{
					hp.aura.duration,
					0
				}
			}
		
		else
			this.aura.mod = nil
		end

		queue_insert(store, hp)
	end

	queue_remove(store, this)
end

scripts.tower_ignis_altar_bolt = {}

function scripts.tower_ignis_altar_bolt.update(this, store)
	local b = this.bullet
	local fm = this.force_motion
	local target = store.entities[b.target_id]
	local ps

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
		ps.particle_system.emit = true
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
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

	while true do
		target = store.entities[b.target_id]

		if target and target.health and not target.health.dead and band(target.vis.bans, F_RANGED) == 0 then
			local hit_offset = V.v(0, 0)

			if not b.ignore_hit_offset then
				hit_offset.x = target.unit.hit_offset.x
				hit_offset.y = target.unit.hit_offset.y
			end

			local d = math.max(math.abs(target.pos.x + hit_offset.x - b.to.x), math.abs(target.pos.y + hit_offset.y - b.to.y))

			if d > b.max_track_distance then
				log.debug("BOLT MAX DISTANCE FAIL. (%s) %s / dist:%s target.pos:%s,%s b.to:%s,%s", this.id, this.template_name, d, target.pos.x, target.pos.y, b.to.x, b.to.y)

				target = nil
				b.target_id = nil
			else
				b.to.x, b.to.y = target.pos.x + hit_offset.x, target.pos.y + hit_offset.y
			end
		end

		if this.initial_impulse and store.tick_ts - b.ts < this.initial_impulse_duration then
			local t = store.tick_ts - b.ts

			if this.initial_impulse_angle_abs then
				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(this.initial_impulse_angle_abs, 1, 0))
			else
				local angle = this.initial_impulse_angle

				if iix < 0 then
					angle = angle * -1
				end

				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(angle, iix, iiy))
			end
		end

		last_pos.x, last_pos.y = this.pos.x, this.pos.y

		if move_step(b.to) then
			break
		end

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - last_pos.x, this.pos.y - last_pos.y)
		end

		coroutine.yield()
	end

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
				m.modifier.level = b.level --根据子弹等级获得易伤

				queue_insert(store, m)
			end
		end
	elseif b.damage_radius and b.damage_radius > 0 then
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, b.damage_radius, b.vis_flags, b.vis_bans)

		if targets then
			for _, target in pairs(targets) do
				local d = SU.create_bullet_damage(b, target.id, this.id)

				queue_damage(store, d)
			end
		end
	end

	this.render.sprites[1].hidden = true

	if b.hit_fx then
		local fx = E:create_entity(b.hit_fx)

		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts
		fx.render.sprites[1].runs = 0

		queue_insert(store, fx)
	end

	if b.hit_decal then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if ps and ps.particle_system.emit then
		ps.particle_system.emit = false

		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end

scripts.mod_ignis_altar_weak = {}

function scripts.mod_ignis_altar_weak.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local target_id = this.modifier.target_id
	local template_name = this.template_name
	local modifiers = table.filter(store.entities, function(k, v)
		return v.modifier and v.modifier.target_id == target_id and v.template_name == template_name
	end)

	if #modifiers > 0 then
		local base_modifier = modifiers[1]

		base_modifier.modifier.ts = store.tick_ts
		this.render = nil

		if base_modifier.render then
			for i = 1, #base_modifier.render.sprites do
				base_modifier.render.sprites[i].ts = store.tick_ts
			end
		end

		if base_modifier.tween then
			base_modifier.tween.ts = store.tick_ts
		end
	end

	if not target or target.health.dead or not target.unit then
		return false
	end

	if this.received_damage_factor_config then
		this.received_damage_factor = this.received_damage_factor_config[this.modifier.level]
	end

	if this.inflicted_damage_factor_config then
		this.inflicted_damage_factor = this.inflicted_damage_factor_config[this.modifier.level]
	end

	this.modifier.duration = this.modifier_duration[this.modifier.level]

	if this.received_damage_factor then
		target.health.damage_factor = target.health.damage_factor * this.received_damage_factor
	end

	if this.inflicted_damage_factor then
		target.unit.damage_factor = target.unit.damage_factor * this.inflicted_damage_factor
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

function scripts.mod_ignis_altar_weak.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if target and target.health and target.unit then
		if this.received_damage_factor then
			target.health.damage_factor = target.health.damage_factor / this.received_damage_factor
		end

		if this.inflicted_damage_factor then
			target.unit.damage_factor = target.unit.damage_factor / this.inflicted_damage_factor
		end
	end

	return true
end

scripts.tower_ignis_altar_lava = {}

function scripts.tower_ignis_altar_lava.update(this, store)
	local b = this.bullet
	local dradius = b.damage_radius
	local dmin = b.damage_min
	local dmax = b.damage_max
	local damage_every = b.damage_every
	local damage_factor = b.damage_factor
	local explode_pos = V.v(b.explode_pos.x, b.explode_pos.y)
	local aura_duration = b.aura_duration
	local damage_type = DAMAGE_EXPLOSION--b.damage_type
	local dps_ts = store.tick_ts
	local init_ts = store.tick_ts
	local count = 0
	local count2 = 0
	while true do
		if (store.tick_ts - dps_ts >= damage_every and store.tick_ts - init_ts <= aura_duration) then
			dps_ts = dps_ts + damage_every
			count = count + 1
			
			local enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, explode_pos, dradius)
			end)
			local d_value = math.ceil(dmax * damage_factor)
		
			for _, enemy in pairs(enemies) do
				local d = E:create_entity("damage")
				count2 = count2 + 1
				d.source_id = this.id
				d.target_id = enemy.id
				d.value = d_value
				d.damage_type = damage_type
				--d.damage_radius = b.damage_radius
				--d.damage_flags = b.damage_flags
				d.track_damage = true
				queue_damage(store, d)
			end
		end
		if store.tick_ts - init_ts > aura_duration then
			dps_ts = dps_ts + damage_every
			count = count + 1
			local enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, explode_pos, dradius)
			end)
			local d_value = U.frandom(dmin, dmax)
		
			for _, enemy in pairs(enemies) do
				local d = E:create_entity("damage")
				count2 = count2 + 1
				d.source_id = this.id
				d.target_id = enemy.id
				d.value = math.ceil(d_value)
				d.damage_type = damage_type
				--d.damage_radius = b.damage_radius
				--d.damage_flags = b.damage_flags
				d.track_damage = true
				queue_damage(store, d)
			end
			break 
		end
	
		coroutine.yield()
	end
	queue_remove(store, this)
end

--食人魔沉船

scripts.tower_ogre_shipwreck = {}

function scripts.tower_ogre_shipwreck.get_info(this)
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
end

function scripts.tower_ogre_shipwreck.soldier_insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		local pow_e = this.powers and this.powers.enhance or nil
		if this.soldier.tower_soldier_idx == 1 then
			if pow_e then
				local b = E:create_entity("cook_ogre_lvl3")
				this.health.armor = b.health.armor
				this.melee.attacks[1].damage_max = b.melee.attacks[1].damage_max
				this.melee.attacks[1].damage_min = b.melee.attacks[1].damage_min
			end
		end
		if this.soldier.tower_soldier_idx == 2 then
			local b = E:create_entity(pow_e and "deckhand_goblin_blue_lvl2" or "deckhand_goblin_blue_lvl1")

			this.health.hp_max = b.health.hp_max
			this.health.hp = this.health.hp_max
			this.regen.health = b.regen.health
			this.regen.cooldown = b.regen.cooldown
			this.health.armor = b.health.armor
			this.melee.attacks[1].damage_min = b.melee.attacks[1].damage_min
			this.melee.attacks[1].damage_max = b.melee.attacks[1].damage_max
			this.melee.attacks[1].hit_time = b.melee.attacks[1].hit_time
			this.melee.attacks[1].hit_decal = nil
			this.melee.attacks[1].hit_fx = nil
			this.melee.attacks[1].count = 1
			this.render.sprites[1].prefix = b.render.sprites[1].prefix
			this.health_bar.type = b.health_bar_size
			this.health_bar.offset.y = this.health_bar.offset.y - 20
			this.health_bar.type  = HEALTH_BAR_SIZE_SMALL
			this.info.portrait = b.info.portrait
			this.info.i18n_key = b.info.i18n_key
			this.motion.max_speed = b.motion.max_speed
			this.health.dead_lifetime = b.health.dead_lifetime
		end


		return true
	end

	return false
end

function scripts.tower_ogre_shipwreck.insert(this, store, script)
	if not this.barrack.rally_pos and this.tower.default_rally_pos then
		this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
	end

	return true
end

function scripts.tower_ogre_shipwreck.remove(this, store, script)
	for _, s in pairs(this.barrack.soldiers) do
		if s.health then
			s.health.dead = true
		end

		queue_remove(store, s)
	end

	return true
end

function scripts.tower_ogre_shipwreck.update(this, store, script)
	local tower_sid = 2
	local door_sid = 3
	local flags_sid = 2
	local shooter_sid = 4
	local bomber_sid = 6
	if this.tower.level == 3 then
		tower_sid = 2
		door_sid = 4
		shooter_sid = 3
	elseif this.tower.level == 4 then
		flags_sid = 2
		tower_sid = 3
		door_sid = 5
		shooter_sid = 4
		bomber_sid = 6
	else
		tower_sid = 2
		door_sid = 3
	end
	local ab = this.attacks and this.attacks.list[1]--射击
	local ae = this.attacks and this.attacks.list[2]--爆炸
	local am = this.attacks and this.attacks.list[4]--连击
	local ag = this.attacks and this.attacks.list[3]--投弹哥布林
	local pow_e = this.powers and this.powers.enhance or nil
	local pow_m = this.powers and this.powers.multishoot or nil
	local pow_g = this.powers and this.powers.goblin or nil
	local last_ts = 0
	if ab then
		last_ts = store.tick_ts - ab.cooldown
		ab.ts = store.tick_ts - ab.cooldown
	end
	local last_target_pos = V.v(0, 0)

	local attacks = {}
	local pows = {}
	this.bullet_loaded = false
	if ab then
		table.insert(attacks, ab)--射击
		--table.insert(pows, nil)
	end

	if ae then
		table.insert(attacks, ae)--爆炸
		--table.insert(pows, nil)
	end

	if am then
		table.insert(attacks, am)--连击
		table.insert(pows, pow_m)
	end

	if ag then
		table.insert(attacks, ag)--投射哥布林
		table.insert(pows, pow_g)
	end

	local dg2 = E:create_entity("deckhand_goblin_blue_lvl2")
	local og3 = E:create_entity("cook_ogre_lvl3")
	
	while true do
		local b = this.barrack

		

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
					s.soldier.tower_soldier_idx = i
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers)
					s.nav_rally.new = true
					--[[
					if this.powers then
						for pn, p in pairs(this.powers) do
							s.powers[pn].level = p.level
						end
					end
					]]--

					queue_insert(store, s)

					b.soldiers[i] = s

					signal.emit("tower-spawn", this, s)
				end
			end
		end

		if this.powers and this.powers.pow_e and this.powers.pow_e.level > 0 then
			if b.soldiers[2].health.armor < dg2.health.armor then
				b.soldiers[2].health.armor = dg2.health.armor
				b.soldiers[2].melee.attacks[1].damage_max = dg2.melee.attacks[1].damage_max
				b.soldiers[2].melee.attacks[1].damage_min = dg2.melee.attacks[1].damage_min
			end
		end

		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil
					if p == pow_g then
						this.attacks.list[3].disabled = false
						this.attacks.list[3].cooldown = p.cooldown[p.level]
						ag.ts = store.tick_ts
					elseif p == pow_m then
						this.attacks.list[4].disabled = false
						am.ts = store.tick_ts
						if p.level == 2 then
							am.bullet = "bullet_tower_ogre_shipwreck_skill2"
						end
					elseif p == pow_e then
						--强化我方单位
						ag.bullet = "skillbomb_tower_ogre_shipwreck_lvl2"
						this.barrack.soldier_type = "cook_ogre_lvl3"
						if this.render.sprites[6].name == "idle" then
							this.render.sprites[6].name = "idleGoblin"
						end
						--local og3 = E:create_entity("cook_ogre_lvl3")
						b.soldiers[1].health.armor = og3.health.armor
					    b.soldiers[1].melee.attacks[1].damage_max = og3.melee.attacks[1].damage_max
						b.soldiers[1].melee.attacks[1].damage_min = og3.melee.attacks[1].damage_min
						if b.soldiers[1].health.hp ~= 0 then
							b.soldiers[1].health.hp = b.soldiers[1].health.hp_max
						end
						--local dg2 = E:create_entity("deckhand_goblin_blue_lvl2")
						b.soldiers[2].health.armor = dg2.health.armor
					    b.soldiers[2].melee.attacks[1].damage_max = dg2.melee.attacks[1].damage_max
						b.soldiers[2].melee.attacks[1].damage_min = dg2.melee.attacks[1].damage_min
						if b.soldiers[2].health.hp ~= 0 then
							b.soldiers[2].health.hp = b.soldiers[2].health.hp_max
						end
						
					end

					--[[
					for _, s in pairs(b.soldiers) do
						s.powers[pn].level = p.level
						s.powers[pn].changed = true
					end
					]]--
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


		if this.tower.blocked then

			coroutine.yield()
		else

			for i, aa in pairs(attacks) do
				if aa and not aa.disabled and store.tick_ts - aa.ts > aa.cooldown then 
					if aa == am then
						local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, false, am.vis_flags, am.vis_bans)
						if not enemy then
							--block empty
						else
							am.ts = store.tick_ts
							last_target_pos.x, last_target_pos.y = enemy.pos.x, enemy.pos.y
							local an, af = U.animation_name_facing_point(this, "skillin", enemy.pos, shooter_sid, start_offset)

							U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

							while not U.animation_finished(this, shooter_sid) do
								coroutine.yield()
							end
							S:queue(aa.sound)
							local start_offset = am.bullet_start_offset
							an, af = U.animation_name_facing_point(this, "skillloop", enemy.pos, shooter_sid, start_offset)

							U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)

							local last_enemy = enemy
							local loop_ts = store.tick_ts
							local torigin = tpos(this)

							for i = 1, am.shots do
								local origin = last_enemy.pos
								local range = am.near_range

								while store.tick_ts - loop_ts < am.shoot_time do
									coroutine.yield()
								end

								enemy = U.find_foremost_enemy(store.entities, origin, 0, range, false, am.vis_flags, am.vis_bans)

								local shoot_pos, target_id

								if enemy then
									last_enemy = enemy
									enemy_id = enemy.id
									shoot_pos = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
								else
									enemy_id = nil
									shoot_pos = V.v(last_enemy.pos.x, last_enemy.pos.y)
								end

								local b = E:create_entity(am.bullet)

								b.bullet.damage_factor = 1
								b.bullet.target_id = enemy_id
								b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
								b.bullet.to = shoot_pos
								b.pos = V.vclone(b.bullet.from)

								queue_insert(store, b)
								AC:inc_check("BOLTOFTHESUN", 1)

								while store.tick_ts - loop_ts < am.cycle_time do
									coroutine.yield()
								end

								loop_ts = 2 * store.tick_ts - (loop_ts + am.cycle_time)
							end

							am.ts = store.tick_ts

							local an, af = U.animation_name_facing_point(this, "skillend", last_enemy.pos, shooter_sid, start_offset)

							U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

							while not U.animation_finished(this, shooter_sid) do
								coroutine.yield()
							end
						end
					elseif aa == ab then
						local enemy
						enemy, __ = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, false, aa.vis_flags, aa.vis_bans)
						if not enemy then
							SU.delay_attack(store, aa, fts(5))
						else
							local enemy_id = enemy.id
							local shoot_pos = pred_pos

							aa.ts = store.tick_ts

							local soffset = this.render.sprites[shooter_sid].offset
							local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

							U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
							if enemy then
								
								local b = E:create_entity(aa.bullet)
								b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.vclone(enemy.pos)
								b.bullet.target_id = enemy.id
								b.bullet.source_id = this.id
								queue_insert(store, b)
							end
							while not U.animation_finished(this, shooter_sid) do
								coroutine.yield()
							end
						end
						
					elseif aa == ae then
						local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

						if enemy then
							aa.ts = store.tick_ts
							last_ts = store.tick_ts
							ani_name = pow_g.level > 0 and "shootGoblin" or "shoot"
							U.animation_start(this, ani_name, nil, store.tick_ts, 1, bomber_sid)
							local trigger_pos = pred_pos
							--while not U.animation_finished(this, bomber_sid) do
							--	coroutine.yield()
							--end
							--while store.tick_ts - last_ts < fts(28) do
							--	coroutine.yield()
							--end
							--U.y_wait(store, fts(20))

							enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

							local b = E:create_entity(aa.bullet)

							b.bullet.damage_factor = this.tower.damage_factor
							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = enemy and pred_pos or trigger_pos
							b.bullet.source_id = this.id

							queue_insert(store, b)
							while not U.animation_finished(this, bomber_sid) do
								coroutine.yield()
							end

						end
						ani_name = pow_g.level > 0 and "idleGoblin" or "idle"
						U.animation_start(this, ani_name, nil, store.tick_ts, -1, bomber_sid)
					elseif aa == ag then
						local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

						if enemy then
							aa.ts = store.tick_ts
							last_ts = store.tick_ts
							U.animation_start(this, "skillGoblin", nil, store.tick_ts, 1, bomber_sid)
							--while not U.animation_finished(this, bomber_sid) do
							--	coroutine.yield()
							--end
							--while store.tick_ts - last_ts < fts(28) do
							--	coroutine.yield()
							--end
							--U.y_wait(store, fts(20))
							local trigger_pos = pred_pos

							enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

							local b = E:create_entity(aa.bullet)

							b.bullet.damage_factor = this.tower.damage_factor
							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = enemy and enemy.pos or trigger_pos
							b.bullet.source_id = this.id

							queue_insert(store, b)

							while not U.animation_finished(this, bomber_sid) do
								coroutine.yield()
							end
						end

						U.animation_start(this, "idleGoblin", nil, store.tick_ts, -1, bomber_sid)
					end
				end
			end
		end
		coroutine.yield()
	end
end

scripts.red_soldier_tower_ogrc_shipwreck = {}

function scripts.red_soldier_tower_ogrc_shipwreck.update(this, store, script)
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

--死灵墓
scripts.tower_spirit_mausoleum_bolt = {}
function scripts.tower_spirit_mausoleum_bolt.update(this, store, script)
	local b = this.bullet
	local fm = this.force_motion
	local target
	if b.target_id then
		target = store.entities[b.target_id]
	end
	local ps
	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id
		queue_insert(store, ps)
	end

	local function move_step(dest)
		local dx, dy = V.sub(dest.x, dest.y, this.pos.x, this.pos.y)
		local dist = V.len(dx, dy)
		local nx, ny, stx, sty
		
		if not target then
			nx, ny = V.mul(b.max_speed, V.normalize(dx, dy))
			stx, sty = V.sub(nx, ny, fm.v.x, fm.v.y)
			if dist <= 4 * b.max_speed * store.tick_length then
				stx, sty = V.mul(this.max_acceleration, V.normalize(stx, sty))
			end
			fm.a.x, fm.a.y = V.add(fm.a.x, fm.a.y, V.trim(this.max_acceleration, V.mul(this.travel_step, stx, sty)))
			fm.v.x, fm.v.y = V.trim(b.max_speed, V.add(fm.v.x, fm.v.y, V.mul(store.tick_length, fm.a.x, fm.a.y)))
			this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, V.mul(store.tick_length, fm.v.x, fm.v.y))
			fm.a.x, fm.a.y = 0, 0
			return dist < b.max_speed * store.tick_length
		else
			nx, ny = V.mul(fm.max_v, V.normalize(dx, dy))
			stx, sty = V.sub(nx, ny, fm.v.x, fm.v.y)
			if dist <= 4 * fm.max_v * store.tick_length then
				stx, sty = V.mul(fm.max_a, V.normalize(stx, sty))
			end
			fm.a.x, fm.a.y = V.add(fm.a.x, fm.a.y, V.trim(fm.max_a, V.mul(fm.a_step, stx, sty)))
			fm.v.x, fm.v.y = V.trim(fm.max_v, V.add(fm.v.x, fm.v.y, V.mul(store.tick_length, fm.a.x, fm.a.y)))
			this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, V.mul(store.tick_length, fm.v.x, fm.v.y))
			fm.a.x, fm.a.y = 0, 0
			return dist <= fm.max_v * store.tick_length
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
	
	this.render.sprites[1].ts = store.tick_ts
	b.ts = store.tick_ts
	this.travel_ts = store.tick_ts

	while true do
		if b.target_id then
			target = store.entities[b.target_id]
			if this.target_found then
				this.target_found = nil
				iix, iiy = V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y)
			end
		end

		if target and target.health and not target.health.dead then
			b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
		end

		if not target and store.tick_ts - this.travel_ts < this.travel_impulse_duration then
			local t = store.tick_ts - this.travel_ts
			fm.a.x, fm.a.y = V.mul((this.travel_peak - t) * this.travel_impulse, V.rotate(this.initial_angle * (b.shot_index % 2 == 0 and 1 or -1), iix, iiy))
		elseif this.initial_impulse and store.tick_ts - b.ts < this.initial_impulse_duration then
			local t = store.tick_ts - b.ts

			if this.initial_impulse_angle_abs then
				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(this.initial_impulse_angle_abs, 1, 0))
			else
				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(this.initial_impulse_angle * (b.shot_index % 2 == 0 and 1 or -1), iix, iiy))
			end
		end

		last_pos.x, last_pos.y = this.pos.x, this.pos.y

		if move_step(b.to) then
			if not target then
				this.pos.x, this.pos.y = b.to.x, b.to.y
				this.travel_ts = store.tick_ts + store.tick_length
				if b.to.x == b.from.x and b.to.y == b.from.y then
					b.shot_index = b.shot_index % #b.destination_offsets + 1
					local offset = b.destination_offsets[(b.shot_index - 1) % #b.destination_offsets + 1]
					b.to.x, b.to.y = b.from.x + offset.x, b.from.y + offset.y
				else
					if this.step_times > 0 then
						if not this._step_times then
							this._step_times = 0
						end
						if this._step_times < this.step_times then
							b.from.y = b.from.y + this.step_y
							this._step_times = this._step_times + 1
						end
					end
					b.to.x, b.to.y = b.from.x, b.from.y
				end
				iix, iiy = V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y)
			else
				break
			end
		end

		if b.flip_x then
			this.render.sprites[1].flip_x = this.pos.x < last_pos.x
		elseif b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - last_pos.x, this.pos.y - last_pos.y)
		end

		if ps then
			ps.particle_system.emit_direction = this.render.sprites[1].r
		end

		coroutine.yield()
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if b.damage_radius and b.damage_radius > 0 then
		local targetPos = target and target.pos or b.to
		local targets = U.find_enemies_in_range(store.entities, targetPos, 0, b.damage_radius, b.vis_flags, b.vis_bans)
		if targets then
			for _, target in ipairs(targets) do
				local d = SU.create_bullet_damage(b, target.id, this.id)
				queue_damage(store, d)
				if b.mod or b.mods then
					local mods = b.mods or {
						b.mod
					}
					for _, mod_name in ipairs(mods) do
						local m = E:create_entity(mod_name)
						m.modifier.target_id = target.id
						m.modifier.level = b.level
						queue_insert(store, m)
					end
				end
			end
		end
	elseif target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)
		queue_damage(store, d)
		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}
			for _, mod_name in ipairs(mods) do
				local m = E:create_entity(mod_name)
				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				queue_insert(store, m)
			end
		end
	end
	
	this.render.sprites[1].hidden = true

	if b.hit_fx then
		local fx = E:create_entity(b.hit_fx)
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts
		fx.render.sprites[1].runs = 0
		if target and fx.render.sprites[1].size_names then
			fx.render.sprites[1].name = fx.render.sprites[1].size_names[target.unit.size]
		end
		queue_insert(store, fx)
	end

	if b.hit_decal then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if b.payload then
		local hp = b.payload
		hp.pos.x, hp.pos.y = b.to.x, b.to.y
		queue_insert(store, hp)
	end

	if this.sound_events and this.sound_events.hit then
		S:queue(this.sound_events.hit)
	end
	
	if ps and ps.particle_system.emit then
		ps.particle_system.emit = false
		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end

scripts.soldier_from_enemy = {}
function scripts.soldier_from_enemy.update(this, store, script)
	local brk, sta

	local function hide_shadow(isHidden)
		for i, sprite in ipairs(this.render.sprites) do
			if sprite.is_shadow then
				sprite.hidden = isHidden
			end
		end
	end

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	if this.ranged and this.ranged.order then
		for _, i in ipairs(this.ranged.order) do
			local ar = this.ranged.attacks[i]
			ar.ts = store.tick_ts
			if this.ranged.cooldown and ar.shared_cooldown then
				ar.cooldown = this.ranged.cooldown
			end
		end
	end

	while true do
        if this.cloak then
			this.vis.flags = band(this.vis.flags, bnot(this.cloak.flags))
			this.vis.bans = band(this.vis.bans, bnot(this.cloak.bans))
			this.render.sprites[1].alpha = 255
		end

		if this.health.dead then
            SU.remove_modifiers(store, this)
            return
		end

		if this.unit.is_stunned then
			SU.y_enemy_stun(store, this)
		else
			if this.dodge and this.dodge.active then
				this.dodge.active = false
				if this.dodge.counter_attack then
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
			end
			
			if this.timed_actions then
				brk, sta = SU.y_soldier_timed_actions(store, this)
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
				elseif sta == A_IN_COOLDOWN then
					local a = this.ranged.attacks[1]
					local cd = a.cooldown - store.tick_ts + a.ts
					if cd <= 1.5 then
						local flip_x = this.motion and this.motion.dest.x < this.pos.x or nil
						U.animation_start(this, "idle", flip_x, store.tick_ts, true)
						goto label_43_1
					end
				end
			end

			if this.cloak then
				this.vis.flags = bor(this.vis.flags, this.cloak.flags)
				this.vis.bans = bor(this.vis.bans, this.cloak.bans)

				if this.cloak.alpha then
					this.render.sprites[1].alpha = this.cloak.alpha
				end
			end

			SU.soldier_regen(store, this)

            local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
                this.nav_path.pi
            }, {
                this.nav_path.spi
            })

            if nearest and nearest[1] and nearest[1][3] < this.nav_path.ni then
                this.nav_path.ni = nearest[1][3]
            end

            local next_pos = P:next_entity_node(this, store.tick_length)
            if not next_pos or not P:is_node_valid(this.nav_path.pi, this.nav_path.ni) or GR:cell_is(next_pos.x, next_pos.y, bor(TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK)) then
                SU.remove_modifiers(store, this)
                return
            end
            U.set_destination(this, next_pos)
            local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)
            U.animation_start(this, an, af, store.tick_ts, -1)
            U.walk(this, store.tick_length)
		end

		::label_43_1::

		coroutine.yield()
	end
end

scripts.soldier_wander = {}
function scripts.soldier_wander.update(this, store, script)
	local brk, sta

	local function hide_shadow(isHidden)
		for i, sprite in ipairs(this.render.sprites) do
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
		hide_shadow(true)
		for i, sprite in ipairs(this.render.sprites) do
			sprite._original_sort_y_offset = sprite.sort_y_offset
			sprite.sort_y_offset = sprite.sort_y_offset - 10
		end
		U.animation_start(this, "raise", nil, store.tick_ts, 1)
		while not U.animation_finished(this) and not this.health.dead do
			coroutine.yield()
		end
		if not this.health.dead then
			hide_shadow(false)
			this.health_bar.hidden = nil
		end
		for i, sprite in ipairs(this.render.sprites) do
			sprite.sort_y_offset = sprite._original_sort_y_offset
			sprite._original_sort_y_offset = nil
		end
	end

	local available_paths = {}
	for k, v in pairs(P.paths) do
		table.insert(available_paths, k)
	end
	if store.level.ignore_walk_backwards_paths then
		available_paths = table.filter(available_paths, function(k, v)
			return not table.contains(store.level.ignore_walk_backwards_paths, v)
		end)
	end
	local nearest = P:nearest_nodes(this.default_rally_pos.x, this.default_rally_pos.y, available_paths)
	local pi, spi, ni
	if #nearest > 1 then
		local index = math.random(1, 2)
		pi, spi, ni = unpack(nearest[index])
		if index ~= 1 then
			local nodePos = P:node_pos(pi, spi, ni)
			local d2 = V.dist2(this.default_rally_pos.x, this.default_rally_pos.y, nodePos.x, nodePos.y)
			if d2 >= 120 * 120 then
				pi, spi, ni = unpack(nearest[1])
			end
		end
	end
	this.nav_path.pi, this.nav_path.ni = pi, ni
	this.nav_path.spi = math.random(1, 3)

	while true do
        if this.cloak then
			this.vis.flags = band(this.vis.flags, bnot(this.cloak.flags))
			this.vis.bans = band(this.vis.bans, bnot(this.cloak.bans))
			this.render.sprites[1].alpha = 255
		end

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			hide_shadow(true)
			U.animation_start(this, "death", nil, store.tick_ts, false, 1)
			if this.sound_events.death then
				S:queue(this.sound_events.death)
			end
			U.y_animation_wait(this, 1)
			queue_remove(store, this)
			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			if this.dodge and this.dodge.active then
				this.dodge.active = false
				if this.dodge.counter_attack then
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
			end
			
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
				elseif sta == A_IN_COOLDOWN then
					local flip_x = this.motion and this.motion.dest.x < this.pos.x or nil
					U.animation_start(this, "idle", flip_x, store.tick_ts, true)
					goto label_43_1
				end
			end

			if this.cloak then
				this.vis.flags = bor(this.vis.flags, this.cloak.flags)
				this.vis.bans = bor(this.vis.bans, this.cloak.bans)

				if this.cloak.alpha then
					this.render.sprites[1].alpha = this.cloak.alpha
				end
			end

			SU.soldier_regen(store, this)

            local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
                this.nav_path.pi
            }, {
                this.nav_path.spi
            })

            if nearest and nearest[1] and nearest[1][3] < this.nav_path.ni then
                this.nav_path.ni = nearest[1][3]
            end

            local next_pos = P:next_entity_node(this, store.tick_length)
            if not next_pos or not P:is_node_valid(this.nav_path.pi, this.nav_path.ni) or GR:cell_is(next_pos.x, next_pos.y, bor(TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK)) then
				hide_shadow(true)
				SU.y_soldier_death(store, this)
				queue_remove(store, this)
                return
            end
            U.set_destination(this, next_pos)
            local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)
            U.animation_start(this, an, af, store.tick_ts, -1)
            U.walk(this, store.tick_length)
		end

		::label_43_1::

		coroutine.yield()
	end
end

scripts.mod_possession = {}
function scripts.mod_possession.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	if target and target.unit and this.render then
		for i = 1, #this.render.sprites do
			local s = this.render.sprites[i]
			s.ts = store.tick_ts
			if s.size_names then
				s.name = s.size_names[target.unit.size]
			end
		end
	end

	this.modifier.duration = this.possession_duration[this.modifier.level]
	this.modifier.ts = store.tick_ts
	signal.emit("mod-applied", this, target)
	return true
end

function scripts.mod_possession.update(this, store, script)
	local m = this.modifier
	local duration = m.duration
	local target = store.entities[m.target_id]
	if not target then
		queue_remove(store, this)
		return
	end
	this.pos = target.pos
	U.animation_start(this, "start", nil, store.tick_ts, false)
	SU.remove_modifiers(store, target, nil, this.template_name)
	U.unblock_all(store, target)
	target.nav_path.dir = -1
	target.vis._original_flags = target.vis.flags
	target.vis.flags = bor(U.flag_clear(target.vis.flags, F_ENEMY), F_FRIEND)
	target.soldier = {}
	target.soldier.melee_slot_offset = V.v(target.enemy.melee_slot.x / 2, target.enemy.melee_slot.y)
	target._original_enemy = target.enemy
	target._blazing_deselect = true
	target.enemy = nil
	if target.melee and target.melee.attacks then
		target.melee.range = 60
		for _, a in pairs(target.melee.attacks) do
			a._original_vis_bans = a.vis_bans
			a.vis_bans = bor(U.flag_clear(a.vis_bans, F_ENEMY), F_FRIEND)
			if a.hit_times and not a.animations then
				a.animations = {
					nil,
					a.animation,
					nil
				}
				a.loops = 1
			end
		end
	end
	if target.ranged and target.ranged.attacks then
		for _, a in pairs(target.ranged.attacks) do
			a._original_vis_bans = a.vis_bans
			a.vis_bans = bor(U.flag_clear(a.vis_bans, F_ENEMY), F_FRIEND, F_NIGHTMARE)
			if a.animations and not a.shoot_times then
				a.shoot_times = {
					a.shoot_time
				}
				a.loops = 1
			end
		end
	end
	target.main_script._original_update = target.main_script.update
	target.main_script.update = scripts.soldier_from_enemy.update
	target.main_script.co = nil
	target.main_script.runs = 1
	target.vis.bans = bor(target.vis.bans, F_LYCAN,F_CANNIBALIZE, F_POISON)

	while true do
		if U.animation_finished(this) then
			U.animation_start(this, "loop", nil, store.tick_ts, true)
		end

		target = store.entities[m.target_id]
		if not target or target.health.dead or duration < store.tick_ts - m.ts then
			U.y_animation_play(this, "end", nil, store.tick_ts, false)
			queue_remove(store, this)
			return
		end

		if this.render and m.use_mod_offset and target.unit.mod_offset then
			for i = 1, #this.render.sprites do
				local s = this.render.sprites[i]

				if not s.exclude_mod_offset then
					s.offset.x, s.offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
				end
			end
		end

		coroutine.yield()
	end
end

function scripts.mod_possession.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]
	if not target then
		return true
	end
	U.unblock_target(store, target)
	target.nav_path.dir = 1
	target.vis.flags = target.vis._original_flags
	target.soldier = nil
	target.enemy = target._original_enemy
	target._blazing_deselect = false
	if target.melee and target.melee.attacks then
		for _, a in pairs(target.melee.attacks) do
			a.vis_bans = a._original_vis_bans
		end
	end
	if target.ranged and target.ranged.attacks then
		for _, a in pairs(target.ranged.attacks) do
			a.vis_bans = a._original_vis_bans
		end
	end
	target.main_script.update = target.main_script._original_update
	target.main_script.co = nil
	target.main_script.runs = 1

	return true
end

scripts.tower_spirit_mausoleum = {}
function scripts.tower_spirit_mausoleum.remove(this, store, script)
	for i, b in ipairs(this.attacks.list[1].stored_bullets) do
		queue_remove(store, b)
	end
	if this.barrack and this.barrack.soldiers then
		for i, s in ipairs(this.barrack.soldiers) do
			if s.health then
				s.health.dead = true
			end
			queue_remove(store, s)
		end
	end
	return true
end

function scripts.tower_spirit_mausoleum.update(this, store, script)
	local spritesGroup = "layers"
	local a = this.attacks
	local a1 = this.attacks.list[1]
	local a2 = this.attacks.list[2]
	--local a3 = this.attacks.list[3]
	local barrack = this.barrack
	local pow_g, pow_p, pow_s
	if this.powers then
		pow_g = this.powers.gargoyles
		pow_p = this.powers.possession
		pow_s = this.powers.spectral_communion
	end
	a1.ts = store.tick_ts
	if a2 then
		a2.ts = store.tick_ts
	end
	--if a3 then
	--	a3.ts = store.tick_ts
	--end

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			if pow_s and pow_s.changed then
				pow_s.changed = nil
				a1.max_charges = pow_s.max_charges[pow_s.level]
				--a3.cooldown = pow_s.cooldown[pow_s.level]
				--a3.entity = pow_s.unit_type[pow_s.level]
				a1.cooldown = 1.45 + pow_s.cooldown_inc * pow_s.level
				a1.bullet = pow_s.bullet_list[pow_s.level]
			end
			if pow_p and pow_p.changed then
				pow_p.changed = nil
				a2.cooldown = pow_p.cooldown[pow_p.level]
			end
			if pow_g and pow_g.changed then
				pow_g.changed = nil
				local level = pow_g.level
				barrack.max_soldiers = level
				local offset, left_gargoyle, right_gargoyle
				if level == 1 then
					if not this.render.sprites[5].hidden then
						local fx = E:create_entity(pow_g.spawn_fx)
						offset = pow_g.spawn_positions[1]
						fx.pos = V.v(this.pos.x + offset.x, this.pos.y + offset.y)
						fx.render.sprites[1].ts = store.tick_ts
						queue_insert(store, fx)
						left_gargoyle = E:create_entity(barrack.soldier_type)
						left_gargoyle.soldier.tower_id = this.id
						left_gargoyle.soldier.tower_soldier_idx = 1
						left_gargoyle.nav_rally.pos, left_gargoyle.nav_rally.center = U.rally_formation_position(1,
							barrack, barrack.max_soldiers, barrack.rally_angle_offset)
						left_gargoyle.pos = V.vclone(fx.pos)
						left_gargoyle.nav_rally.new = true
						barrack.soldiers[1] = left_gargoyle
						signal.emit("tower-spawn", this, left_gargoyle)
					end
				elseif level == 2 then
					if not this.render.sprites[5].hidden then
						local fx = E:create_entity(pow_g.spawn_fx)
						offset = pow_g.spawn_positions[1]
						fx.pos = V.v(this.pos.x + offset.x, this.pos.y + offset.y)
						fx.render.sprites[1].ts = store.tick_ts
						queue_insert(store, fx)
						left_gargoyle = E:create_entity(barrack.soldier_type)
						left_gargoyle.soldier.tower_id = this.id
						left_gargoyle.soldier.tower_soldier_idx = 1
						left_gargoyle.nav_rally.pos, left_gargoyle.nav_rally.center = U.rally_formation_position(1,
							barrack, barrack.max_soldiers, barrack.rally_angle_offset)
						left_gargoyle.pos = V.vclone(fx.pos)
						left_gargoyle.nav_rally.new = true
						barrack.soldiers[1] = left_gargoyle
						signal.emit("tower-spawn", this, left_gargoyle)
					end
					if not this.render.sprites[6].hidden then
						local fx = E:create_entity(pow_g.spawn_fx)
						offset = pow_g.spawn_positions[2]
						fx.pos = V.v(this.pos.x + offset.x, this.pos.y + offset.y)
						fx.render.sprites[1].ts = store.tick_ts
						queue_insert(store, fx)
						right_gargoyle = E:create_entity(barrack.soldier_type)
						right_gargoyle.soldier.tower_id = this.id
						right_gargoyle.soldier.tower_soldier_idx = 2
						right_gargoyle.nav_rally.pos, right_gargoyle.nav_rally.center = U.rally_formation_position(2,
							barrack, barrack.max_soldiers, barrack.rally_angle_offset)
						right_gargoyle.pos = V.vclone(fx.pos)
						right_gargoyle.nav_rally.new = true
						barrack.soldiers[2] = right_gargoyle
						local gargoyle1 = barrack.soldiers[1]
						gargoyle1.nav_rally.pos, gargoyle1.nav_rally.center = U.rally_formation_position(1, barrack,
							barrack.max_soldiers, barrack.rally_angle_offset)
						signal.emit("tower-spawn", this, right_gargoyle)
					end
				end
				U.y_wait(store, pow_g.spawn_time)
				if left_gargoyle then
					queue_insert(store, left_gargoyle)
					this.render.sprites[5].hidden = true
				end
				if right_gargoyle then
					queue_insert(store, right_gargoyle)
					this.render.sprites[6].hidden = true
				end
			end

			if barrack then
				for i = 1, barrack.max_soldiers do
					local s = barrack.soldiers[i]
					if not s or s.health.dead and not store.entities[s.id] then
						local respawnPos = nil
						if s then
							respawnPos = V.vclone(s.pos)
						end
						s = E:create_entity(barrack.soldier_type)
						s.soldier.tower_id = this.id
						s.soldier.tower_soldier_idx = i
						s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, barrack, barrack
						.max_soldiers, barrack.rally_angle_offset)
						if respawnPos then
							s.pos = respawnPos
							s.nav_rally.new = true
						else
							s.pos = V.vclone(s.nav_rally.pos)
							s.nav_rally.new = false
						end
						s.render.sprites[1].name = "raise"
						queue_insert(store, s)
						barrack.soldiers[i] = s
						signal.emit("tower-spawn", this, s)
					end
				end

				if barrack.rally_new then
					barrack.rally_new = false
					signal.emit("rally-point-changed", this)
					local all_dead = true
					for i, s in ipairs(barrack.soldiers) do
						s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, barrack, barrack
						.max_soldiers, barrack.rally_angle_offset)
						s.nav_rally.new = true
						all_dead = all_dead and s.health.dead
					end
					if not all_dead and this.sound_events.change_rally_point then
						S:queue(this.sound_events.change_rally_point)
					end
				end
			end

			if pow_p and pow_p.level > 0 and this.tower.can_do_magic and store.tick_ts - a2.ts >= a2.cooldown then
				local target = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, a.range, a2.node_prediction, a2.vis_flags, a2.vis_bans, function(e)
					return e.nav_path and e.melee and not U.has_modifiers(store, e, "mod_possession") and not U.has_modifiers(store, e, "mod_possession_lucerna") and (not a2.excluded_templates or not table.contains(a2.excluded_templates, e.template_name))
				end)
				if not target then
					SU.delay_attack(store, a2, 0.1)
				else
					local start_ts = store.tick_ts
					local targetPos = V.vclone(target.pos)
					U.animation_start_group(this, a2.animation, nil, store.tick_ts, false, spritesGroup)
					local start_offset = a2.bullet_start_offset[1]
					local fx = E:create_entity(a2.bullet[1])
					fx.pos = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
					fx.render.sprites[1].ts = store.tick_ts
					queue_insert(store, fx)
					U.y_wait(store, a2.shoot_time)
					if target.health.dead then
						local newTarget = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, a.range, a2.node_prediction, a2.vis_flags, a2.vis_bans, function(e)
							return e.nav_path and e.melee and not U.has_modifiers(store, e, "mod_possession") and (not a2.excluded_templates or not table.contains(a2.excluded_templates, e.template_name))
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
					b.bullet.level = pow_p.level
					if target then
						b.bullet.target_id = target.id
					end
					queue_insert(store, b)
					a2.ts = start_ts
				end
			end

			--[[
			if pow_s and pow_s.level > 0 and this.tower.can_do_magic and store.tick_ts - a3.ts >= a3.cooldown then
				local start_ts = store.tick_ts
				U.animation_start_group(this, a3.animation, nil, store.tick_ts, false, spritesGroup)
				local entity = E:create_entity(a3.entity)
				entity.pos = V.v(this.pos.x + a3.spawn_offset.x, this.pos.y + a3.spawn_offset.y)
				entity.health.hp_max = pow_s.hp[pow_s.level]
				local enemy = U.find_random_enemy(store.entities, entity.pos, 0, a3.range, 0, 0, function(e)
					return e.nav_path
				end)
				if enemy then
					local pred_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni)
					entity.default_rally_pos = pred_pos
				elseif V.dist(entity.pos.x, entity.pos.y, this.barrack.rally_pos.x, this.barrack.rally_pos.y) < a3.range then
					entity.default_rally_pos = V.vclone(this.barrack.rally_pos)
				else
					entity.default_rally_pos = V.vclone(this.tower.default_rally_pos)
				end
				queue_insert(store, entity)
				U.y_wait(store, a3.cast_time)
				a3.ts = start_ts
			end
			]]--

			if store.tick_ts - a1.ts >= a1.cooldown then
				local target, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, a1.node_prediction, a1.vis_flags, a1.vis_bans)
				if not target and (a1.max_charges <= 0 or #a1.stored_bullets >= a1.max_charges) then
					SU.delay_attack(store, a1, 0.1)
				else
					local start_ts = store.tick_ts
					if #a1.stored_bullets < a1.max_charges then
						S:queue(a1.sound)
						U.animation_start_group(this, a1.charge_animation, nil, store.tick_ts, false, spritesGroup)
						U.y_wait(store, a1.shoot_time)
						local start_offset = a1.bullet_start_offset
						local b = E:create_entity(a1.bullet)
						b.bullet.damage_factor = this.tower.damage_factor
						b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
						b.pos = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
						table.insert(a1.stored_bullets, b)
						b.bullet.shot_index = math.floor((#a1.stored_bullets - 1) / 3 + 1) % -2 + 2
						local offset = b.bullet.destination_offsets[(b.bullet.shot_index - 1) % #b.bullet.destination_offsets + 1]
						b.bullet.to = V.v(b.pos.x + offset.x, b.pos.y + offset.y)
						queue_insert(store, b)
						target, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, a1.node_prediction, a1.vis_flags, a1.vis_bans)
					end
					if target then
						for i = #a1.stored_bullets, 1, -1 do
							local b = a1.stored_bullets[i]
							b.bullet.shot_index = 2
							b.bullet.target_id = target.id
							b.bullet.to = V.v(pred_pos.x + target.unit.hit_offset.x, pred_pos.y + target.unit.hit_offset.y)
							b.target_found = true
							table.remove(a1.stored_bullets, i)
						end
						S:queue(a1.release_sound)
						U.animation_start_group(this, a1.animation, nil, store.tick_ts, false, spritesGroup)
						U.y_wait(store, a1.shoot_time)
					end
					a1.ts = start_ts
				end
			end

			U.animation_start_group(this, "idle", nil, store.tick_ts, false, spritesGroup)
			coroutine.yield()
		end
	end
end

scripts.mod_track_target_with_fade = {}
function scripts.mod_track_target_with_fade.update(this, store, script)
	local m = this.modifier
	m.ts = store.tick_ts

	local target = store.entities[m.target_id]
	if not target or not target.pos then
		queue_remove(store, this)
		return
	end
	this.pos = target.pos

	if this.tween then
		this.tween.reverse = false
		this.tween.remove = false
		if this.fade_in then
			this.tween.disabled = false
			this.tween.ts = store.tick_ts
		else
			this.tween.disabled = true
		end
	end

	while true do
		target = store.entities[m.target_id]
		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
			if this.tween and this.fade_out then
				this.tween.reverse = true
				this.tween.remove = true
				this.tween.disabled = false
				this.tween.ts = store.tick_ts
			else
				queue_remove(store, this)
			end
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

scripts.mod_promotion = {}
function scripts.mod_promotion.update(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]
	if not target or not target.pos then
		queue_remove(store, this)
		return
	end
	if this.render then
		for _, s in ipairs(this.render.sprites) do
			s.ts = store.tick_ts
			if s.size_names then
				s.name = s.size_names[target.unit.size]
			end
			if s.size_scales then
				s.scale = s.size_scales[target.unit.size]
			end
		end
	end
	m.ts = store.tick_ts
	this.pos = target.pos
	if target.melee then
		target.melee.attacks[1]._original_mod = target.melee.attacks[1].mod
		target.melee.attacks[1].mod = this.mod
	end
	if target.ranged then
		local b = E:get_template(target.ranged.attacks[1].bullet).bullet
		local mods = b.mod and (type(b.mod) == "table" and b.mod or { b.mod }) or {}
		table.insert(mods, this.mod)
		b.mod = mods
	end
	while true do
		target = store.entities[m.target_id]
		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
			if target then
				if target.melee and target.melee.attacks[1].mod == this.mod then
					target.melee.attacks[1].mod = target.melee.attacks[1]._original_mod
				end
				if target.ranged then
					local b = E:get_template(target.ranged.attacks[1].bullet).bullet
					local mods = b.mod
					if mods and type(mods) == "table" then
						for i = #mods, 1, -1 do
							if mods[i] == this.mod then
								table.remove(mods, i)
							end
						end
						if #mods == 0 then
							mods = nil
						end
					end
				end
			end
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

scripts.initial_bolt = {}
function scripts.initial_bolt.update(this, store, script)
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
	this.render.sprites[1].ts = store.tick_ts

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

		if b.flip_x then
			this.render.sprites[1].flip_x = b.to.x < this.pos.x
		elseif not b.ignore_rotation then
			s.r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if b.damage_radius and b.damage_radius > 0 then
		local targetPos = target and target.pos or b.to
		local targets = U.find_enemies_in_range(store.entities, targetPos, 0, b.damage_radius, b.vis_flags, b.vis_bans)
		if targets then
			for _, target in ipairs(targets) do
				local d = SU.create_bullet_damage(b, target.id, this.id)
				queue_damage(store, d)
				if b.mod or b.mods then
					local mods = b.mods or {
						b.mod
					}
					for _, mod_name in ipairs(mods) do
						local m = E:create_entity(mod_name)
						m.modifier.target_id = target.id
						m.modifier.level = b.level
						queue_insert(store, m)
					end
				end
			end
		end
	elseif target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)
		queue_damage(store, d)
		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}
			for _, mod_name in ipairs(mods) do
				local m = E:create_entity(mod_name)
				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				queue_insert(store, m)
			end
		end
	end

	this.render.sprites[1].hidden = true
	
	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)
		sfx.pos.x, sfx.pos.y = b.to.x, b.to.y
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].runs = 0
		if b.flip_x then
			sfx.render.sprites[1].flip_x = this.render.sprites[1].flip_x 
		end
		if target and sfx.render.sprites[1].size_names then
			sfx.render.sprites[1].name = sfx.render.sprites[1].size_names[target.unit.size]
		end
		queue_insert(store, sfx)
	end

	if b.hit_decal then
		local decal = E:create_entity(b.hit_decal)
		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts
		queue_insert(store, decal)
	end

	if b.payload then
		local hp = b.payload
		hp.pos.x, hp.pos.y = b.to.x, b.to.y
		queue_insert(store, hp)
	end

	if this.sound_events and this.sound_events.hit then
		S:queue(this.sound_events.hit)
	end

	if ps and ps.particle_system.emit then
		ps.particle_system.emit = false
		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end

--腐朽森林
scripts.tower_rotten_forest = {}

function scripts.tower_rotten_forest.get_info(this)
	local b = {3,4,5,7}
	local o = scripts.tower_common.get_info(this)

	--o.type = STATS_TYPE_TOWER_MA
	o.damage_min = math.ceil(b[this.tower.level] * this.tower.damage_factor)
	o.damage_max = math.ceil(b[this.tower.level] * this.tower.damage_factor)
	o.cooldown = 0.4

	return o
end

function scripts.tower_rotten_forest.insert(this, store, script)
	
	local points = {}
	local inner_fx_radius = {60,108,156,156}

	for i = 1, 48 do
		local r = inner_fx_radius[i%4+1]

		local p = {}

		p.pos = U.point_on_ellipse(this.pos, r, 2 * math.pi * i / 48)
		p.terrain = GR:cell_type(p.pos.x, p.pos.y)

		if GR:cell_is(p.pos.x, p.pos.y, TERRAIN_WATER) or P:valid_node_nearby(p.pos.x, p.pos.y, 1) and not GR:cell_is(p.pos.x, p.pos.y, TERRAIN_CLIFF) then
			table.insert(points, p)
		end
	end

	this.fx_points = points
	this.aura1 = nil
	this.aura2 = nil
	this.aura_list1 = {}
	this.aura_list2 = {}
	if this.auras then
		for _, a in pairs(this.auras.list) do
			--if a.cooldown == 0 then
			if a.name == "aura_tower_rotten_forest_spike_burst" then
				local e = E:create_entity(a.name)

				e.pos = V.vclone(this.pos)
				e.aura.level = this.tower.level
				e.aura.source_id = this.id
				e.aura.ts = store.tick_ts
				e.aura.basic_range = e.aura.radius
				this.aura1 = e
				for _, p in pairs(this.fx_points) do

					local smoke = E:create_entity("decal_rotten_forest_smoke")
					smoke.pos.x, smoke.pos.y = p.pos.x, p.pos.y
					table.insert(this.aura_list1, smoke)
					queue_insert(store, smoke)
				end
				queue_insert(store, e)
				
			end

			if a.name == "aura_tower_rotten_forest_fog" then
				local e = E:create_entity(a.name)
				e.pos = V.vclone(this.pos)
				e.aura.level = this.powers and this.powers.fog.level or this.tower.level
				e.aura.source_id = this.id
				e.aura.ts = store.tick_ts
				if this.powers and this.powers.fog.level >= 1 then
					e.aura.level = this.powers.fog.level
					this.aura2 = e
					queue_insert(store, e)
					for _, p in pairs(this.fx_points) do

						local smoke = E:create_entity("decal_rotten_forest_fog")
						smoke.pos.x, smoke.pos.y = p.pos.x, p.pos.y
						smoke.render.sprites[1].ts = store.tick_ts
						table.insert(this.aura_list2, smoke)
						if this.powers and this.powers.fog.level >= 1 then
							queue_insert(store, smoke)
						end
					end
					
				end
			end
		end
	end

	return true
end

function scripts.tower_rotten_forest.update(this, store, script)
	local a = this.attacks
	local a_basic = this.attacks.list[1]
	local a_tree = this.attacks.list[2]
	local druid_sid = 4
	local pow_w = this.powers and this.powers.warp or nil
	local pow_t = this.powers and this.powers.tree or nil
	local pow_f = this.powers and this.powers.fog or nil
	local last_ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else		
			if this.powers then
				for k, pow in pairs(this.powers) do
					if pow.changed then
						pow.changed = nil
						if pow == pow_w and this.render.sprites[druid_sid].hidden then
							this.render.sprites[druid_sid].hidden = false
							this.render.sprites[druid_sid - 1].hidden = true

							local ta = E:create_entity(pow_w.aura)

							ta.aura.source_id = this.id
							ta.pos = tpos(this)

							queue_insert(store, ta)
						end
						
						if pow == pow_t then
							a_tree.disabled = false
							a_tree.cooldown = pow_t.cooldown + pow_t.cooldown_inc * pow_t.level
							a_tree.ts = store.tick_ts - a_tree.cooldown
						end
						if pow == pow_f then
							if this.aura2 == nil then
								local e = E:create_entity("aura_tower_rotten_forest_fog")

								e.pos = V.vclone(this.pos)
								e.aura.level = 1
								e.aura.source_id = this.id
								e.aura.ts = store.tick_ts
								
								this.aura2 = e
								
								if this.powers and this.powers.fog.level >= 1 then
									queue_insert(store, e)
									for _, p in pairs(this.fx_points) do

											local smoke = E:create_entity("decal_rotten_forest_fog")
											smoke.pos.x, smoke.pos.y = p.pos.x, p.pos.y
											smoke.render.sprites[1].ts = store.tick_ts
											table.insert(this.aura_list2, smoke)
											if this.powers and this.powers.fog.level >= 1 then
												queue_insert(store, smoke)
											end
									end
									
								end
							else
								queue_remove(store, this.aura2)
								local e = E:create_entity("aura_tower_rotten_forest_fog")
								e.pos = V.vclone(this.pos)
								e.aura.level = 2
								e.aura.source_id = this.id
								e.aura.ts = store.tick_ts
								
								this.aura2 = e
								queue_insert(store, e)
							end
						end

					end
				end
			end
			SU.towers_swaped(store, this, this.attacks.list)
			this.aura1.aura.radius = this.attacks.range
			if this.aura2 then
				this.aura2.aura.radius = this.attacks.range
			end
			if pow_t and pow_t.level > 0 and store.tick_ts - a_tree.ts >= a_tree.cooldown then
				
				local start_ts = store.tick_ts
	
				local enemy = nil
				enemy, __ = U.find_foremost_enemy(store.entities, tpos(this), 0, a_tree.range, a_tree.node_prediction, a_tree.vis_flags, a_tree.vis_bans)

				if not enemy then
					SU.delay_attack(store, a_tree, 0.1)
				else
					for i = 1,2 do
						local entity = E:create_entity(a_tree.entity)
						entity.health.hp_max = pow_t.hp
						local pred_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni)
						entity.default_rally_pos = pred_pos
						entity.pos = pred_pos

						queue_insert(store, entity)
					end
					a_tree.ts = start_ts

				end
				
			end
			coroutine.yield()
		end
	end
end

function scripts.tower_rotten_forest.remove(this, store, script)
	if this.aura1 then
		queue_remove(store, this.aura1)
	end
	for _, smoke in pairs(this.aura_list1) do
		queue_remove(store, smoke)
	end

	if this.aura2 then
		queue_remove(store, this.aura2)
		for _, smoke in pairs(this.aura_list2) do
			queue_remove(store, smoke)
		end
	end
	
	return true
end

scripts.aura_tower_rotten_forest_spike_burst = {}

function scripts.aura_tower_rotten_forest_spike_burst.insert(this, store, script)
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

function scripts.aura_tower_rotten_forest_spike_burst.update(this, store, script)
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

scripts.aura_rotten_forest_thorn = {}

function scripts.aura_rotten_forest_thorn.update(this, store)
	local a = this.aura

	a.ts = store.tick_ts

	local function find_targets()
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.radius, a.vis_flags, a.vis_bans, function(e)
			return not e.enemy.counts[a.mod] or e.enemy.counts[a.mod] < 10000
		end)

		return targets
	end

	while true do
		local owner = store.entities[a.source_id]

		if not owner then
			log.error("aura_ranger_thorn has no parent tower. removing")

		break
		end

		if owner.tower.blocked then
			-- block empty
		elseif store.tick_ts - a.ts >= a.cooldown then
			local targets = find_targets()

			if not targets or #targets < a.min_count then
				-- block empty
			else
				a.ts = store.tick_ts

				--U.animation_start(owner, a.owner_animation, nil, store.tick_ts, false, a.owner_sid)
				--U.y_wait(store, a.hit_time)

				targets = find_targets()

				if not targets or #targets < a.min_count then
					-- block empty
				else
					S:queue(a.hit_sound)

					for i = 1, math.min(#targets, a.max_count + a.max_count_inc * owner.powers.warp.level) do
						local e = targets[i]
						local m = E:create_entity(a.mod)

						m.modifier.target_id = e.id
						m.modifier.source_id = this.id
						m.modifier.level = owner.powers.warp.level
						m.modifier.duration = m.modifier.duration + m.modifier.duration_inc * owner.powers.warp.level

						queue_insert(store, m)
					end

					--U.y_animation_wait(owner, a.owner_sid)
				end
			end
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.aura_tower_rotten_forest_fog = {}

function scripts.aura_tower_rotten_forest_fog.insert(this, store, script)
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

function scripts.aura_tower_rotten_forest_fog.update(this, store, script)
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

scripts.decal_rotten_forest_smoke = {}

function scripts.decal_rotten_forest_smoke.update(this, store, script)
	U.animation_start(this, "intro", nil, store.tick_ts, false)
	U.y_wait(store, fts(6))
	U.animation_start(this, "idle", nil, store.tick_ts, true, 2)
	U.y_wait(store, fts(5))
	U.animation_start(this, "idle", nil, store.tick_ts, true, 1)
	local range = 52
	while true do
		coroutine.yield()
		local enemy, _ = U.find_first_target(store.entities, this.pos, 0, range, 0, this.aura.vis_bans, function(e, _)
			return e.enemy
		end)
		local current = this.render.sprites[2].name
		if not enemy then
			if current == "loop" then
				U.y_animation_play(this, "out", nil, store.tick_ts, false, 2)
				U.animation_start(this, "idle", nil, store.tick_ts, true, 2)
			end
		elseif current == "idle" then
			U.y_animation_play(this, "introLoop", nil, store.tick_ts, false, 2)
			U.animation_start(this, "loop", nil, store.tick_ts, true, 2)
		end
	end

end

scripts.hero_dianyun = {}

function scripts.hero_dianyun.get_info(this)
    local level = this.hero.level
    local min = this.hero.level_stats.ranged_damage_min[level]
    local max = this.hero.level_stats.ranged_damage_max[level]

	min, max = min * this.unit.damage_factor, max * this.unit.damage_factor
	min, max = math.ceil(min), math.ceil(max)

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		damage_type = DAMAGE_MAGICAL,
		damage_icon = this.info.damage_icon,
		armor = this.health.armor,
		respawn = this.health.dead_lifetime
	}
end

function scripts.hero_dianyun.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	local b = E:get_template(this.ranged.attacks[1].bullet)

	b.bullet.damage_max = ls.ranged_damage_max[hl]
	b.bullet.damage_min = ls.ranged_damage_min[hl]

	local s

	s = this.hero.skills.ricochet

	if initial and s.level > 0 then
		local a = this.ranged.attacks[2]
        a.cooldown = s.cooldown[s.level]
        local b = E:get_template(a.bullet)
		local bullet = b.bullet
        bullet.damage_min = s.damage_min[s.level]
        bullet.damage_max = s.damage_max[s.level]
        b.bounce = s.bounce[s.level]
        local bounce_bullet = E:get_template(b.bounce_bullet).bullet
        bounce_bullet.damage_min = s.damage_min[s.level]
        bounce_bullet.damage_max = s.damage_max[s.level]
		a.disabled = nil
	end

	s = this.hero.skills.lord_storm

	if initial and s.level > 0 then
        local a = this.ranged.attacks[1]
        local controller = E:get_template(a.entity)
        controller.max_targets = s.max_targets[s.level]
	end

	s = this.hero.skills.divine_rain

	if initial and s.level > 0 then
		local a = this.timed_attacks.list[1]
        a.cooldown = s.cooldown[s.level]
        local aura = E:get_template(a.aura).aura
        aura.duration = s.duration[s.level]
        local mod = E:get_template(aura.mods[1])
        mod.hps.heal_min = s.healing_points_tick[s.level]
        mod.hps.heal_max = s.healing_points_tick[s.level]
		a.disabled = nil
	end

	s = this.hero.skills.supreme_wave

	if initial and s.level > 0 then
        local a = this.timed_attacks.list[2]
        a.cooldown = s.cooldown[s.level]
        local aura = E:get_template(a.entity).aura
        local mod = E:get_template(aura.mods[1]).modifier
        mod.duration = s.stun[s.level]
        a.disabled = nil
	end

	s = this.hero.skills.ultimate

	if initial and s.level > 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level] or 32

		local entity = E:get_template(u.entity)
        entity.bullets_to_death = s.bullets_to_death[s.level]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_dianyun.insert(this, store)
	this.hero.fn_level_up(this, store, true)

	this.ranged.order = U.attack_order(this.ranged.attacks)

	if this.auras then
		for _, a in ipairs(this.auras.list) do
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

	return true
end

function scripts.hero_dianyun.update(this, store)
	local h = this.health
    local shadow_sprite = this.render.sprites[2]
	local lord_storm_attack = this.ranged.attacks[1]
	local ricochet_attack = this.ranged.attacks[2]
	local divine_rain_attack = this.timed_attacks.list[1]
	local supreme_wave_attack = this.timed_attacks.list[2]
	local attack, skill

	local function hero_death_and_respawn()
		local h = this.health
		local he = this.hero
	
		this.ui.can_click = false
	
		local death_ts = store.tick_ts
		local dead_lifetime = h.dead_lifetime
	
		U.unblock_target(store, this)

		S:queue(this.sound_events.death, this.sound_events.death_args)

		if this.unit.death_animation then
			U.animation_start(this, this.unit.death_animation, nil, store.tick_ts, false, 1)
		else
			U.animation_start(this, "death", nil, store.tick_ts, false, 1)
		end
	
		if not he.tombstone_concurrent_with_death then
			U.y_animation_wait(this)
	
			this.health.death_finished_ts = store.tick_ts
	
			if this.unit.hide_after_death then
				for _, s in pairs(this.render.sprites) do
					s.hidden = true
				end
			end
		end
	
		local tombstone
	
		if he and he.tombstone_show_time then
			while store.tick_ts - death_ts < he.tombstone_show_time do
				coroutine.yield()
			end
	
			tombstone = E:create_entity(he.tombstone_decal)
	
			if he.tombstone_force_over_path then
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, {
					1,
					2,
					3
				}, true)
				local pi, spi, ni = unpack(nodes[1])
				local npos = P:node_pos(pi, spi, ni)
	
				tombstone.pos = npos
			else
				tombstone.pos = this.pos
			end
	
			for _, s in pairs(tombstone.render.sprites) do
				s.ts = store.tick_ts
			end
	
			queue_insert(store, tombstone)
		end
	
		if he.tombstone_concurrent_with_death then
			U.y_animation_wait(this)
	
			this.health.death_finished_ts = store.tick_ts
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
	
		if he and he.tombstone_force_over_path then
			he.respawn_point = tombstone.pos
		end
	
		if tombstone and tombstone.tween then
			tombstone.tween.disabled = false
			tombstone.tween.ts = store.tick_ts
		end
	
		if he and he.tombstone_respawn_animation then
			U.animation_start(tombstone, he.tombstone_respawn_animation, nil, store.tick_ts)
		end
	
		if he and he.respawn_point then
			local p = he.respawn_point
	
			this.pos.x, this.pos.y = p.x, p.y
			this.nav_rally.pos.x, this.nav_rally.pos.y = p.x, p.y
			this.nav_rally.center.x, this.nav_rally.center.y = p.x, p.y
			this.nav_rally.new = false
		end
	
		for _, s in pairs(this.render.sprites) do
			s.hidden = false
		end
	
		h.ignore_damage = true
	
		S:queue(this.sound_events.respawn)
	
		if he.respawn_animation then
			U.y_animation_play(this, he.respawn_animation, nil, store.tick_ts, 1, 1)
		else
			U.y_animation_play(this, "respawn", nil, store.tick_ts, 1, 1)
		end
	
		if tombstone then
			queue_remove(store, tombstone)
		end
	
		this.health_bar.hidden = false
		this.ui.can_click = true
		h.dead = false
		this.force_respawn = nil
		h.hp = h.hp_max
		h.ignore_damage = false
	end

	local function hideSprites(isHidden)
		for i = 2, #this.render.sprites, 1 do
			if i ~= 3 then
				this.render.sprites[i].hidden = isHidden
			end
		end
	end

	local function changeOffsetX(flipX)
		local flipSign = flipX and -1 or 1
		for i = 3, #this.render.sprites, 1 do
			if not this.render.sprites[i]._original_offset then
				this.render.sprites[i]._original_offset = V.vclone(this.render.sprites[i].offset)
			end
			this.render.sprites[i].offset.x = flipSign * this.render.sprites[i]._original_offset.x
		end
	end

    if not ricochet_attack.disabled then
		ricochet_attack.ts = store.tick_ts - ricochet_attack.cooldown
	end
    if not divine_rain_attack.disabled then
		divine_rain_attack.ts = store.tick_ts - divine_rain_attack.cooldown
	end
    if not supreme_wave_attack.disabled then
		supreme_wave_attack.ts = store.tick_ts - supreme_wave_attack.cooldown
	end

    this.health_bar.hidden = false
    U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)

	while true do
        if h.dead then
			hideSprites(true)
			hero_death_and_respawn()
			hideSprites(nil)
            U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)
		end

		SU.heroes_visual_learning_upgrade(store, this)
		SU.heroes_lone_wolves_upgrade(store, this)
		SU.alliance_merciless_upgrade(store, this)
		SU.alliance_corageous_upgrade(store, this)

        if SU.hero_level_up(store, this) then
            U.y_animation_play(this, "lvlUp", nil, store.tick_ts, 1, 1)
		end

        local skip
		local function ranged_attacks()
			if skip then
				return
			end
			for _, i in ipairs(this.ranged.order) do
				attack = this.ranged.attacks[i]
				if attack.disabled or (attack.sync_animation and not this.render.sprites[1].sync_flag) or (store.tick_ts - attack.ts < attack.cooldown) then
					-- block empty
				else
					if i == 2 then
						if store.tick_ts - lord_storm_attack.ts >= attack.min_cooldown then
							local targets = U.find_enemies_in_range(store.entities, this.pos, attack.min_range, attack.max_range, attack.vis_flags, attack.vis_bans)
							local amount = 0
							local crowdsTarget
							if targets and #targets >= attack.min_targets then
								for _, t in ipairs(targets) do
									local enemy, crowds = U.find_foremost_enemy(store.entities, t.pos, 0, attack.crowds_range, nil, attack.vis_flags, attack.vis_bans)
									if crowds and #crowds >= attack.min_targets and #crowds > amount then
										amount = #crowds
										crowdsTarget = crowds
									end
								end
							end
							if crowdsTarget then
								local fx = E:create_entity(attack.start_fx)
								fx.pos = this.pos
								for _, sprite in ipairs(fx.render.sprites) do
									sprite.ts = store.tick_ts
									sprite.flip_x = this.render.sprites[1].flip_x
									sprite.offset = V.vclone(attack.start_offset)
								end
								queue_insert(store, fx)

								local target = crowdsTarget[1]
								local bullet = E:create_entity(attack.bullet)
								bullet.pos = target.pos
								bullet.spawn_pos_offset = attack.spawn_pos_offset
								bullet.bullet.source_id = this.id
								bullet.bullet.target_id = target.id
								if bullet.bullet.use_unit_damage_factor then
									bullet.bullet.damage_factor = this.source.unit.damage_factor
								end
								queue_insert(store, bullet)
								attack.ts = store.tick_ts
								if attack.xp_from_skill then
									SU.hero_gain_xp_from_skill(this, this.hero.skills[attack.xp_from_skill])
								end
								break
							else
								SU.delay_attack(store, attack, fts(10))
							end
						else
							SU.delay_attack(store, attack, fts(10))
						end
					else
						local targets = U.find_enemies_in_range(store.entities, this.pos, attack.min_range, attack.max_range, attack.vis_flags, attack.vis_bans, function(e)
							return not e._lord_storm_ts or store.tick_ts - e._lord_storm_ts >= attack.cooldown
						end)
						if targets then
							local controller = E:create_entity(attack.entity)
							controller.pos = this.pos
							controller.source = this
							controller.xp_gain_factor = attack.xp_gain_factor
							controller.min_range = attack.min_range
							controller.max_range = attack.max_range
							controller.vis_flags = attack.vis_flags
							controller.vis_bans = attack.vis_bans
							controller.cooldown = attack.cooldown
							controller.basic_attack = attack.basic_attack
							queue_insert(store, controller)
							attack.ts = store.tick_ts
							break
						end
					end
				end
			end
		end

		local function hero_walk_waypoints(store, this, animation)
			local animation = animation or "walk"
			local r = this.nav_rally
			local n = this.nav_grid
			local dest = r.pos
			local x_to_flip = KR_GAME == "kr5" and 2 or 0
			local last_af
		
			while not V.veq(this.pos, dest) do
				local w = table.remove(n.waypoints, 1) or dest
				local unsnap = #n.waypoints > 0
		
				U.set_destination(this, w)
		
				local an, af = U.animation_name_facing_point(this, animation, this.motion.dest)
				local new_af = af
		
				if x_to_flip > math.abs(this.pos.x - this.motion.dest.x) then
					new_af = last_af
				end
		
				changeOffsetX(new_af)
				U.animation_start(this, an, new_af, store.tick_ts, true, nil)
				last_af = new_af
				ranged_attacks()

				while not this.motion.arrived do
					if this.health.dead and not this.health.ignore_damage then
						return true
					end
		
					if r.new then
						return false
					end
		
					U.walk(this, store.tick_length, nil, unsnap)

					ranged_attacks()
					coroutine.yield()
		
					this.motion.speed.x, this.motion.speed.y = 0, 0
				end
			end
		end

		local function hero_new_rally(store, this)
			local r = this.nav_rally

			if r.new then
				r.new = false

				U.unblock_target(store, this)

				if this.sound_events then
					S:queue(this.sound_events.change_rally_point)
				end

				local vis_bans = this.vis.bans
				local prev_immune = this.health.immune_to

				this.vis.bans = F_ALL
				this.health.immune_to = r.immune_to

				local out = hero_walk_waypoints(store, this)

				U.animation_start(this, "idle", nil, store.tick_ts, true, nil)

				this.vis.bans = vis_bans
				this.health.immune_to = prev_immune

				return out
			end
		end

        if this.unit.is_stunned then
			SU.soldier_idle(store, this)
            skip = true
		else
            while this.nav_rally.new do
                if hero_new_rally(store, this) then
                    skip = true
				end
				ranged_attacks()
            end
        end

		ranged_attacks()

		if not skip then
			attack = divine_rain_attack
            if not divine_rain_attack.disabled and store.tick_ts - divine_rain_attack.ts > divine_rain_attack.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, attack.min_range, attack.max_range, 
				attack.vis_flags, attack.vis_bans, function(e)
					return e.id ~= this.id
				end)
				local amount = 0
				local crowdsTarget
				if targets and #targets >= attack.min_targets then
					for _, t in ipairs(targets) do
						local crowds = U.find_soldiers_in_range(store.entities, t.pos, 0, attack.crowds_range, 
						attack.vis_flags, attack.vis_bans, function(e)
							return e.id ~= this.id
						end)
						if t.health.hp <= t.health.hp_max * attack.health_trigger_factor and crowds and #crowds >= attack.min_targets and #crowds > amount then
							amount = #crowds
							crowdsTarget = crowds
						end
					end
				end
				if crowdsTarget then
					local aura = E:create_entity(attack.aura)
					local x = 0
					local y = 0
					for _, t in ipairs(crowdsTarget) do
						x = t.pos.x + x
						y = t.pos.y + y
					end
					aura.pos.x = x / #crowdsTarget
					aura.pos.y = y / #crowdsTarget
					local start_ts = store.tick_ts
					local an, af, ai = U.animation_name_facing_point(this, attack.animation, aura.pos)
					U.animation_start(this, an, af, store.tick_ts, nil, 1)
					changeOffsetX(af)
					U.y_wait(store, attack.cast_time)
					queue_insert(store, aura)
					U.y_animation_wait(this)
					attack.ts = start_ts
					if attack.xp_from_skill then
						SU.hero_gain_xp_from_skill(this, this.hero.skills[attack.xp_from_skill])
					end
					skip = true
				else
					SU.delay_attack(store, attack, fts(10))
				end
            end
        end

		if not skip then
			attack = supreme_wave_attack
            if not supreme_wave_attack.disabled and store.tick_ts - supreme_wave_attack.ts > supreme_wave_attack.cooldown then
				local targets = U.find_enemies_in_range(store.entities, this.pos, attack.min_range, attack.max_range, attack.vis_flags, attack.vis_bans)
				local target, nodes
				if targets and #targets >= attack.min_targets then
					for _, t in ipairs(targets) do
						if GR:cell_is(t.pos.x, t.pos.y, TERRAIN_LAND) then
							local crowds = U.find_enemies_in_range(store.entities, t.pos, 0, attack.crowds_range, attack.vis_flags, attack.vis_bans)
							if crowds and #crowds >= attack.min_targets then
								target = crowds[1]
								break
							end
						end
					end
				end
				if target then
					local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
					local available_paths = {}
					for k, v in pairs(P.paths) do
						table.insert(available_paths, k)
					end
					if store.level.ignore_walk_backwards_paths then
						available_paths = table.filter(available_paths, function(k, v)
							return not table.contains(store.level.ignore_walk_backwards_paths, v)
						end)
					end
					nodes = P:nearest_nodes(this.pos.x, this.pos.y, available_paths, nil, nil, NF_RALLY)
					if #nodes < 1 then
						target = nil
					else
						local pi, spi, ni = unpack(nodes[1])
						local nodepos = P:node_pos(pi, spi, ni)
						local dist = V.dist(this.pos.x, this.pos.y, nodepos.x, nodepos.y)
						if dist > attack.distance_to_start_node then
							target = nil
						end
					end
				end

				if target then
					local start_ts = store.tick_ts
					local an, af, ai = U.animation_name_facing_point(this, attack.animation, target.pos)
					U.animation_start(this, an, af, store.tick_ts, nil, 1)
					changeOffsetX(af)
					U.y_wait(store, attack.cast_time)
					
					local positions = {}
					local function positions_too_close(new_pos)
						for _, p in ipairs(positions) do
							local dist = V.dist(new_pos.x, new_pos.y, p.x, p.y)
							if dist < 10 then
								return true
							end
						end
						return false
					end

					for i = 1, #nodes do
						local pi, spi, ni = unpack(nodes[i])
						local nodepos = P:node_pos(pi, spi, ni)
						local dist = V.dist(this.pos.x, this.pos.y, nodepos.x, nodepos.y)
						if dist < attack.distance_to_start_node then
							local ni_backwards = ni - attack.start_nodes_offset
							local ni_forward = ni + attack.start_nodes_offset
							local controller1 = E:create_entity(attack.controller)
							controller1.subpaths = {}
							controller1.pos = V.vclone(this.pos)
							controller1.entity = attack.entity
							controller1.floor_decal = attack.floor_decal
							controller1.delay_between_objects = attack.delay_between_objects
							local controller2 = E:create_entity(attack.controller)
							controller2.subpaths = {}
							controller2.pos = V.vclone(this.pos)
							controller2.entity = attack.entity
							controller2.floor_decal = attack.floor_decal
							controller2.delay_between_objects = attack.delay_between_objects
							local ni_aux
							for j = 1, attack.max_objects do
								local new_pos
								ni_aux = ni_backwards - (j - 1) * attack.nodes_between_objects
								for subpath = 1, 3, 1 do
									new_pos = nil
									if not controller1.subpaths[subpath] then
										controller1.subpaths[subpath] = {}
									end
									if P:is_node_valid(pi, ni_aux) then
										new_pos = P:node_pos(pi, subpath, ni_aux)
										if positions_too_close(new_pos) then
											new_pos = nil
										else
											table.insert(positions, new_pos)
										end
									end
									table.insert(controller1.subpaths[subpath], new_pos)
								end

								ni_aux = ni_forward + (j - 1) * attack.nodes_between_objects
								for subpath = 1, 3, 1 do
									new_pos = nil
									if not controller2.subpaths[subpath] then
										controller2.subpaths[subpath] = {}
									end
									if P:is_node_valid(pi, ni_aux) then
										new_pos = P:node_pos(pi, subpath, ni_aux)
										if positions_too_close(new_pos) then
											new_pos = nil
										else
											table.insert(positions, new_pos)
										end
									end
									table.insert(controller2.subpaths[subpath], new_pos)
								end
							end
							queue_insert(store, controller1)
							queue_insert(store, controller2)
						end
					end
					U.y_animation_wait(this)
					attack.ts = start_ts
					if attack.xp_from_skill then
						SU.hero_gain_xp_from_skill(this, this.hero.skills[attack.xp_from_skill])
					end
					skip = true
				else
					SU.delay_attack(store, attack, fts(10))
				end
            end
        end

        if not skip then
            SU.soldier_idle(store, this)
            SU.soldier_regen(store, this)
        end

		coroutine.yield()
	end
end

scripts.hero_dianyun_ultimate = {}

function scripts.hero_dianyun_ultimate.can_fire_fn(this, x, y, store)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.hero_dianyun_ultimate.update(this, store)
	local e = E:create_entity(this.entity)
	e.pos = V.vclone(this.pos)
	queue_insert(store, e)
	queue_remove(store, this)
end

scripts.controller_lord_storm = {}

function scripts.controller_lord_storm.update(this, store)
	local upg_lf = UP:get_upgrade("heroes_lethal_focus")

	for i = 1, this.max_targets, 1 do
		local _, targets = U.find_foremost_enemy(store.entities, this.pos, this.min_range, this.max_range, nil, 
		this.vis_flags, this.vis_bans, function(e)
			return not e._lord_storm_ts or store.tick_ts - e._lord_storm_ts >= this.cooldown
		end)
	
		if targets and targets[1] then
			local target = targets[1]
			local bullet = E:create_entity(this.bullet)
			bullet.pos = target.pos
			bullet.spawn_pos_offset = this.spawn_pos_offset
			bullet.bullet.source_id = this.source.id
			bullet.bullet.target_id = target.id
			bullet.bullet.xp_dest_id = this.source.id
			bullet.bullet.xp_gain_factor = this.xp_gain_factor
			if bullet.bullet.use_unit_damage_factor then
				bullet.bullet.damage_factor = this.source.unit.damage_factor
			end
			if upg_lf and this.basic_attack then
				if not this._lethal_focus_deck then
					this._lethal_focus_deck = SU.deck_new(upg_lf.trigger_cards, upg_lf.total_cards)
				end
				local triggered_lethal_focus = SU.deck_draw(this._lethal_focus_deck)
				if triggered_lethal_focus then
					bullet.bullet.damage_factor = bullet.bullet.damage_factor * upg_lf.damage_factor
					bullet.bullet.pop = {
						"pop_crit"
					}
					bullet.bullet.pop_chance = 1
					bullet.bullet.pop_conds = DR_DAMAGE
				end
			end
			queue_insert(store, bullet)
			target._lord_storm_ts = store.tick_ts
			if i == this.max_targets then
				break
			else
				U.y_wait(store, this.delay_between_rays)
			end
		else
			break
		end
	end
	queue_remove(store, this)
end

scripts.hero_dianyun_lightning = {}

function scripts.hero_dianyun_lightning.update(this, store, script)
	local bullet = this.bullet
	local sprite = this.render.sprites[1]
	local target = store.entities[bullet.target_id]

	if not target then
		queue_remove(store, this)
		return
	end

	if target.render and target.unit and target.unit.hit_offset then
		local flip_sign = target.render.sprites[1].flip_x and -1 or 1
		sprite.offset.x = target.unit.hit_offset.x * flip_sign + this.spawn_pos_offset.x
		sprite.offset.y = target.unit.hit_offset.y + this.spawn_pos_offset.y
	else
		sprite.offset.x = this.spawn_pos_offset.x
		sprite.offset.y = this.spawn_pos_offset.y
	end

	sprite.ts = store.tick_ts

	while store.tick_ts - sprite.ts < bullet.hit_time do
		coroutine.yield()
		if target and target.health.dead then
			target = nil
		end
	end

	local pop = SU.create_bullet_pop(store, this)
	if pop then
		queue_insert(store, pop)
	end

	if target then
		local damage = E:create_entity("damage")
		damage.source_id = this.id
		damage.target_id = target.id
		local damage_min = math.ceil(bullet.damage_min * bullet.damage_factor)
		local damage_max = math.ceil(bullet.damage_max * bullet.damage_factor)
		damage.value = math.random(damage_min, damage_max)
		damage.damage_type = bullet.damage_type
		damage.xp_gain_factor = bullet.xp_gain_factor
		damage.xp_dest_id = bullet.xp_dest_id
		queue_damage(store, damage)

		if bullet.mod then
			local mod = E:create_entity(bullet.mod)
			mod.modifier.target_id = target.id
			queue_insert(store, mod)
		end
	end

	if bullet.hit_fx then
		local hit_fx_pos = V.vclone(this.pos)
		if target and target.render and target.unit and target.unit.hit_offset then
			local flip_sign = target.render.sprites[1].flip_x and -1 or 1
			hit_fx_pos.x = target.unit.hit_offset.x * flip_sign + hit_fx_pos.x
			hit_fx_pos.y = target.unit.hit_offset.y + hit_fx_pos.y
		end
		SU.insert_sprite(store, bullet.hit_fx, hit_fx_pos)
	end

	while not U.animation_finished(this) do
		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.hero_dianyun_lightning_ricochet_cloud = {}

function scripts.hero_dianyun_lightning_ricochet_cloud.update(this, store, script)
	local bullet = this.bullet
	local sprite = this.render.sprites[1]
	local target = store.entities[bullet.target_id]

	if not target then
		queue_remove(store, this)
		return
	end

	if target.render and target.unit and target.unit.hit_offset then
		local flip_sign = target.render.sprites[1].flip_x and -1 or 1
		sprite.offset.x = target.unit.hit_offset.x * flip_sign + this.spawn_pos_offset.x
		sprite.offset.y = target.unit.hit_offset.y + this.spawn_pos_offset.y
	else
		sprite.offset.x = this.spawn_pos_offset.x
		sprite.offset.y = this.spawn_pos_offset.y
	end

	sprite.ts = store.tick_ts

	while store.tick_ts - sprite.ts < bullet.hit_time do
		coroutine.yield()
		if target and target.health.dead then
			target = nil
		end
	end

	if target then
		local damage = E:create_entity("damage")
		damage.source_id = this.id
		damage.target_id = target.id
		local damage_min = math.ceil(bullet.damage_min * bullet.damage_factor)
		local damage_max = math.ceil(bullet.damage_max * bullet.damage_factor)
		damage.value = math.random(damage_min, damage_max)
		damage.damage_type = bullet.damage_type
		queue_damage(store, damage)

		if bullet.mod then
			local mod = E:create_entity(bullet.mod)
			mod.modifier.target_id = target.id
			queue_insert(store, mod)
		end
	end

	if bullet.hit_fx then
		local hit_fx_pos = V.vclone(this.pos)
		if target and target.render and target.unit and target.unit.hit_offset then
			local flip_sign = target.render.sprites[1].flip_x and -1 or 1
			hit_fx_pos.x = target.unit.hit_offset.x * flip_sign + hit_fx_pos.x
			hit_fx_pos.y = target.unit.hit_offset.y + hit_fx_pos.y
		end
		SU.insert_sprite(store, bullet.hit_fx, hit_fx_pos)
	end

	while store.tick_ts - sprite.ts < this.bounce_delay do
		coroutine.yield()
	end

	if this.bounce and this.bounce > 0 then
		local seen_targets = target and { target.id } or {}
		local bounce_target = U.find_nearest_enemy(store.entities, this.pos, 0, this.bounce_range, this.bounce_vis_flags,
		this.bounce_vis_bans, function(v)
			return not table.contains(seen_targets, v.id)
		end)
		if bounce_target then
			local bounceBullet = E:create_entity(this.bounce_bullet)
			bounceBullet.bullet.damage_factor = bullet.damage_factor
			bounceBullet.pos.x, bounceBullet.pos.y = this.pos.x, this.pos.y
			if target and target.render and target.unit and target.unit.hit_offset then
				local flip_sign = target.render.sprites[1].flip_x and -1 or 1
				bounceBullet.pos.x = target.unit.hit_offset.x * flip_sign + bounceBullet.pos.x
				bounceBullet.pos.y = target.unit.hit_offset.y + bounceBullet.pos.y
			end
			bounceBullet.bullet.from = V.vclone(bounceBullet.pos)
			bounceBullet.bullet.to = V.vclone(bounce_target.pos)
			if target then
				bounceBullet.bullet.source_id = target.id
			end
			bounceBullet.bullet.target_id = bounce_target.id
			bounceBullet.bounce_bullet = this.bounce_bullet
			bounceBullet.bounce_range = this.bounce_range
			bounceBullet.bounce_vis_flags = this.bounce_vis_flags
			bounceBullet.bounce_vis_bans = this.bounce_vis_bans
			bounceBullet.bounce_delay = this.bounce_delay
			bounceBullet.bounce = this.bounce - 1
			bounceBullet.seen_targets = seen_targets
			queue_insert(store, bounceBullet)
		end
	end

	while not U.animation_finished(this) do
		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.hero_dianyun_lightning_ricochet = {}

function scripts.hero_dianyun_lightning_ricochet.update(this, store, script)
	local b = this.bullet
	local s = this.render.sprites[1]
	local target = store.entities[b.target_id]
	local source = store.entities[b.source_id]
	local dest = b.to
	s.scale = V.v(1, 1)
	
	if not target then
		queue_remove(store, this)
		return
	end

	local function update_sprite()
		if target then
			dest.x, dest.y = target.pos.x, target.pos.y
			if target.render and target.unit and target.unit.hit_offset then
				local flip_sign = target.render.sprites[1].flip_x and -1 or 1
				dest.x = target.unit.hit_offset.x * flip_sign + dest.x
				dest.y = target.unit.hit_offset.y + dest.y
			end
		end

		if source then
			this.pos.x, this.pos.y = source.pos.x, source.pos.y
			if source.render and source.unit and source.unit.hit_offset then
				local flip_sign = source.render.sprites[1].flip_x and -1 or 1
				this.pos.x = source.unit.hit_offset.x * flip_sign + this.pos.x
				this.pos.y = source.unit.hit_offset.y + this.pos.y
			end
		end

		local angle = V.angleTo(dest.x - this.pos.x, dest.y - this.pos.y)

		s.r = angle
		s.scale.x = V.dist(dest.x, dest.y, this.pos.x, this.pos.y) / this.image_width
	end

	s.ts = store.tick_ts
	update_sprite()
	while store.tick_ts - s.ts < b.hit_time do
		coroutine.yield()
		update_sprite()
		if target and target.health.dead then
			target = nil
		end
	end

	if target then
		local damage = E:create_entity("damage")
		damage.source_id = this.id
		damage.target_id = target.id
		local damage_min = math.ceil(b.damage_min * b.damage_factor)
		local damage_max = math.ceil(b.damage_max * b.damage_factor)
		damage.value = math.random(damage_min, damage_max)
		damage.damage_type = b.damage_type
		queue_damage(store, damage)

		if b.mod then
			local mod = E:create_entity(b.mod)
			mod.modifier.target_id = target.id
			queue_insert(store, mod)
		end
	end

	if b.hit_fx then
		local hit_fx_pos = V.vclone(dest)
		if target and target.render and target.unit and target.unit.hit_offset then
			local flip_sign = target.render.sprites[1].flip_x and -1 or 1
			hit_fx_pos.x = target.unit.hit_offset.x * flip_sign + hit_fx_pos.x
			hit_fx_pos.y = target.unit.hit_offset.y + hit_fx_pos.y
		end
		SU.insert_sprite(store, b.hit_fx, hit_fx_pos)
	end

	while store.tick_ts - s.ts < this.bounce_delay do
		coroutine.yield()
		update_sprite()
		if target and target.health.dead then
			target = nil
		end
	end

	if target then
		table.insert(this.seen_targets, target.id)		
	end

	if this.bounce and this.bounce > 0 then
		local bounce_target = U.find_nearest_enemy(store.entities, dest, 0, this.bounce_range, this.bounce_vis_flags,
			this.bounce_vis_bans, function(v)
			return not table.contains(this.seen_targets, v.id)
		end)
		if bounce_target then
			local bounceBullet = E:create_entity(this.bounce_bullet)
			bounceBullet.bullet.damage_factor = b.damage_factor
			bounceBullet.pos = V.vclone(dest)
			bounceBullet.bullet.from = V.vclone(bounceBullet.pos)
			bounceBullet.bullet.to = V.vclone(bounce_target.pos)
			if target then
				bounceBullet.bullet.source_id = target.id
			end
			bounceBullet.bullet.target_id = bounce_target.id
			bounceBullet.bounce_bullet = this.bounce_bullet
			bounceBullet.bounce_range = this.bounce_range
			bounceBullet.bounce_vis_flags = this.bounce_vis_flags
			bounceBullet.bounce_vis_bans = this.bounce_vis_bans
			bounceBullet.bounce_delay = this.bounce_delay
			bounceBullet.bounce = this.bounce - 1
			bounceBullet.seen_targets = this.seen_targets
			queue_insert(store, bounceBullet)
		end
	end

	while not U.animation_finished(this) do
		coroutine.yield()
		update_sprite()
	end

	queue_remove(store, this)	
end

scripts.controller_decal_hero_dianyun_supreme_wave_spawner = {}

function scripts.controller_decal_hero_dianyun_supreme_wave_spawner.update(this, store, script)
	local function spawn_objects(pos)
		if not pos then
			return
		end
		pos.x = pos.x + math.random(-4, 4)
		pos.y = pos.y + math.random(-3, 3)
		local aura = E:create_entity(this.entity)
		aura.pos = pos
		queue_insert(store, aura)
		local decal = E:create_entity(this.floor_decal)
		decal.pos = pos
		decal.render.sprites[1].ts = store.tick_ts
		queue_insert(store, decal)
	end

	for i = 1, #this.subpaths[1] do
		spawn_objects(this.subpaths[1][i])
		U.y_wait(store, this.delay_between_objects)
		spawn_objects(this.subpaths[2][i])
		spawn_objects(this.subpaths[3][i])
		U.y_wait(store, this.delay_between_objects)
	end

	queue_remove(store, this)
end

scripts.mod_dianyun_passive = {}

function scripts.mod_dianyun_passive.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]
	if not target or not target.health or target.health.dead or not target.enemy then
		return false
	end
	return true
end

function scripts.mod_dianyun_passive.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local aura = store.entities[m.source_id]
	local source
	if aura then
		source = store.entities[aura.aura.source_id]
	end
	if target and target.health and target.health.dead and target.pos and source and source.health and not source.health.dead then
		local fx = E:create_entity(this.fx)
		fx.pos = V.vclone(target.pos)
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		store.player_gold = store.player_gold + this.gold_reward
	end
	return true
end

scripts.hero_dianyun_electric_son = {}

function scripts.hero_dianyun_electric_son.update(this, store, script)
	local attack = this.ranged.attacks[1]

	local function idle()
		U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, 1)
	
		if store.tick_ts - this.idle_flip.ts > 2 * store.tick_length then
			this.idle_flip.ts_counter = 0
		end
	
		this.idle_flip.ts = store.tick_ts
		this.idle_flip.ts_counter = this.idle_flip.ts_counter + store.tick_length
	
		if this.idle_flip.ts_counter > this.idle_flip.cooldown then
			this.idle_flip.ts_counter = 0
	
			if math.random() < this.idle_flip.chance then
				this.render.sprites[1].flip_x = not this.render.sprites[1].flip_x
			end
	
			if this.idle_flip.animations then
				this.idle_flip.last_animation = table.random(this.idle_flip.animations)
			end
		end
	end

	U.y_animation_play(this, "spawn", nil, store.tick_ts)

	attack.ts = store.tick_ts - attack.cooldown
	local start_ts = store.tick_ts
	local bullets_shot = 0

	while true do
		if store.tick_ts - start_ts > this.duration or bullets_shot >= (this.bullets_to_death or 3) then
			U.y_animation_play(this, "death", nil, store.tick_ts)
			break
		end

		if store.tick_ts - attack.ts >= attack.cooldown then
			local target = U.find_foremost_enemy(store.entities, this.pos, attack.min_range, attack.max_range, nil, 
			attack.vis_flags, attack.vis_bans)

			if target and target.health and not target.health.dead and target.pos then
				local ts = store.tick_ts
				local an, af, ai = U.animation_name_facing_point(this, attack.animation, target.pos)
				U.animation_start(this, an, af, store.tick_ts, false, 1)
				U.y_wait(store, attack.shoot_time)
				local b = E:create_entity(attack.bullet)
				local flipSign = af and -1 or 1
				b.bullet.from = V.v(this.pos.x + attack.bullet_start_offset.x * flipSign, this.pos.y + attack.bullet_start_offset.y)
				b.bullet.to = V.v(target.pos.x, target.pos.y)
				if target.unit and target.unit.hit_offset then
					b.bullet.to.x = target.pos.x + target.unit.hit_offset.x
					b.bullet.to.y = target.pos.y + target.unit.hit_offset.y
				end
				b.bullet.target_id = target.id
				b.bullet.source_id = this.id
				b.pos = V.vclone(b.bullet.from)
				queue_insert(store, b)
				bullets_shot = bullets_shot + 1
				attack.ts = ts
				U.y_animation_wait(this)
			else
				SU.delay_attack(store, attack, 0.2)
			end
		end

		idle()

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.initial_bolt = {}
function scripts.initial_bolt.update(this, store, script)
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
	this.render.sprites[1].ts = store.tick_ts

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

		if b.flip_x then
			this.render.sprites[1].flip_x = b.to.x < this.pos.x
		elseif not b.ignore_rotation then
			s.r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if b.damage_radius and b.damage_radius > 0 then
		local targetPos = target and target.pos or b.to
		local targets = U.find_enemies_in_range(store.entities, targetPos, 0, b.damage_radius, b.vis_flags, b.vis_bans)
		if targets then
			for _, target in ipairs(targets) do
				local d = SU.create_bullet_damage(b, target.id, this.id)
				queue_damage(store, d)
				if b.mod or b.mods then
					local mods = b.mods or {
						b.mod
					}
					for _, mod_name in ipairs(mods) do
						local m = E:create_entity(mod_name)
						m.modifier.target_id = target.id
						m.modifier.level = b.level
						queue_insert(store, m)
					end
				end
			end
		end
	elseif target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)
		queue_damage(store, d)
		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}
			for _, mod_name in ipairs(mods) do
				local m = E:create_entity(mod_name)
				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				queue_insert(store, m)
			end
		end
	end

	this.render.sprites[1].hidden = true
	
	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)
		sfx.pos.x, sfx.pos.y = b.to.x, b.to.y
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].runs = 0
		if b.flip_x then
			sfx.render.sprites[1].flip_x = this.render.sprites[1].flip_x 
		end
		if target and sfx.render.sprites[1].size_names then
			sfx.render.sprites[1].name = sfx.render.sprites[1].size_names[target.unit.size]
		end
		queue_insert(store, sfx)
	end

	if b.hit_decal then
		local decal = E:create_entity(b.hit_decal)
		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts
		queue_insert(store, decal)
	end

	if b.payload then
		local hp = b.payload
		hp.pos.x, hp.pos.y = b.to.x, b.to.y
		queue_insert(store, hp)
	end

	if this.sound_events and this.sound_events.hit then
		S:queue(this.sound_events.hit)
	end

	if ps and ps.particle_system.emit then
		ps.particle_system.emit = false
		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end

scripts.custom_bolt = {}
function scripts.custom_bolt.update(this, store, script)
	local b = this.bullet
	local fm = this.force_motion
	local target = store.entities[b.target_id]
	local ps
	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id
		queue_insert(store, ps)
	end

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

	local pred_pos
	if target then
		pred_pos = P:predict_enemy_pos(target, fts(5))
	else
		pred_pos = b.to
	end

	local iix, iiy = V.normalize(pred_pos.x - this.pos.x, pred_pos.y - this.pos.y)
	local last_pos = V.vclone(this.pos)

	this.render.sprites[1].ts = store.tick_ts
	b.ts = store.tick_ts

	while true do
		target = store.entities[b.target_id]

		if target and target.health and not target.health.dead and band(target.vis.bans, F_RANGED) == 0 then
			local d = math.max(math.abs(target.pos.x + target.unit.hit_offset.x - b.to.x), math.abs(target.pos.y + target.unit.hit_offset.y - b.to.y))

			if d > b.max_track_distance then
				log.debug("BOLT MAX DISTANCE FAIL. (%s) %s / dist:%s target.pos:%s,%s b.to:%s,%s", this.id, this.template_name, d, target.pos.x, target.pos.y, b.to.x, b.to.y)

				target = nil
				b.target_id = nil
			else
				b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			end
		end

		if this.initial_impulse and store.tick_ts - b.ts < this.initial_impulse_duration then
			local t = store.tick_ts - b.ts

			if this.initial_impulse_angle_abs then
				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(this.initial_impulse_angle_abs, 1, 0))
			else
				fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(this.initial_impulse_angle * (b.shot_index % 2 == 0 and 1 or -1), iix, iiy))
			end
		end

		last_pos.x, last_pos.y = this.pos.x, this.pos.y

		if move_step(b.to) then
			break
		end

		if b.flip_x then
			this.render.sprites[1].flip_x = this.pos.x < last_pos.x
		elseif b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - last_pos.x, this.pos.y - last_pos.y)
		end

		if ps then
			ps.particle_system.emit_direction = this.render.sprites[1].r
		end

		coroutine.yield()
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if b.damage_radius and b.damage_radius > 0 then
		local targetPos = target and target.pos or b.to
		local targets = U.find_enemies_in_range(store.entities, targetPos, 0, b.damage_radius, b.vis_flags, b.vis_bans)
		if targets then
			for _, target in ipairs(targets) do
				local d = SU.create_bullet_damage(b, target.id, this.id)
				queue_damage(store, d)
				if b.mod or b.mods then
					local mods = b.mods or {
						b.mod
					}
					for _, mod_name in ipairs(mods) do
						local m = E:create_entity(mod_name)
						m.modifier.target_id = target.id
						m.modifier.level = b.level
						queue_insert(store, m)
					end
				end
			end
		end
	elseif target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)
		queue_damage(store, d)
		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}
			for _, mod_name in ipairs(mods) do
				local m = E:create_entity(mod_name)
				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				queue_insert(store, m)
			end
		end
	end
	
	this.render.sprites[1].hidden = true

	if b.hit_fx then
		local fx = E:create_entity(b.hit_fx)
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts
		fx.render.sprites[1].runs = 0
		if target and fx.render.sprites[1].size_names then
			fx.render.sprites[1].name = fx.render.sprites[1].size_names[target.unit.size]
		end
		queue_insert(store, fx)
	end

	if b.hit_decal then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if b.payload then
		local hp = b.payload
		hp.pos.x, hp.pos.y = b.to.x, b.to.y
		queue_insert(store, hp)
	end

	if this.sound_events and this.sound_events.hit then
		S:queue(this.sound_events.hit)
	end

	if ps and ps.particle_system.emit then
		ps.particle_system.emit = false
		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end

--女巫(高达改)
scripts.tower_wicked_sisters = {}

function scripts.tower_wicked_sisters.get_info(this)
	local sm = E:get_template(this.barrack.soldier_type)
	--local b = E:get_template(sm.attacks.list[1].bullet)
	--local min, max = b.bullet.damage_min, b.bullet.damage_max
	min_table2 = {36,90,153,252}
	max_table2 = {36,90,153,252}

	min_table1 = {13,32,58,94}
	max_table1 = {30,76,135,220}

	local min, max = min_table2[1],max_table2[1]
	if this.tower.level and this.tower.level > 0 then
		if this.tower_upgrade_persistent_data.current_mode and this.tower_upgrade_persistent_data.current_mode == 1 then
			min, max = math.ceil(min_table1[this.tower.level] * this.tower.damage_factor),math.ceil(max_table1[this.tower.level] * this.tower.damage_factor)
		else
			min, max = min_table2[this.tower.level],max_table2[this.tower.level]
		end
	end

	local cooldown = sm.attacks.list[1].cooldown
	local range = sm.attacks.list[1].max_range

	return {
		type = STATS_TYPE_TOWER_MAGE,
		damage_min = min,
		damage_max = max,
		range = range,
		cooldown = cooldown
	}
end

function scripts.tower_wicked_sisters.insert(this, store, script)
	return scripts.tower_barrack.insert(this, store, script)
end

function scripts.tower_wicked_sisters.update(this, store, script)
	if not this.tower_upgrade_persistent_data.current_mode then
		this.tower_upgrade_persistent_data.current_mode = 2
	end
	if this.tower_upgrade_persistent_data.current_mode == 1 then
		this.render.sprites[4].name = "Violet"
		this.render.sprites[6].name = "violet"
	end

	local b = this.barrack
	local witch = b.soldiers[1]
	if not witch or witch.health.dead and not store.entities[witch.id] then
		this.tower_upgrade_persistent_data.initialized = false
		witch = E:create_entity(this.barrack.soldier_type)
		witch.pos.x, witch.pos.y = this.pos.x, this.pos.y + 16
		witch.nav_rally.pos.x, witch.nav_rally.pos.y = this.barrack.rally_pos.x, this.barrack.rally_pos.y
		witch.nav_rally.center = V.vclone(witch.nav_rally.pos)
		witch.soldier.tower_id = this.id
		queue_insert(store, witch)
		b.soldiers[1] = witch
	end
	witch.nav_rally.new = true
	witch.wick_mode = this.tower_upgrade_persistent_data.current_mode

	local function check_change_mode()
		if this.change_mode then
			this.change_mode = false
			--S:queue(this.sound_events.change_rally_point)
			if this.tower_upgrade_persistent_data.current_mode == 2 then
				this.tower_upgrade_persistent_data.current_mode = 1
				witch.wick_mode = 1
				--然后播放切换动画
				this.render.sprites[6].hidden = true
				U.animation_start(this, "toViolet", nil, store.tick_ts, false, 5)
				U.y_animation_play(this, "toViolet", nil, store.tick_ts, false, 4)
				U.animation_start(this, "Violet", nil, store.tick_ts, true, 4)
				this.render.sprites[6].name = "violet"
				this.render.sprites[6].hidden = false
				U.y_animation_wait(this, 5)
				U.animation_start(this, "stir", nil, store.tick_ts, true, 5)
			else
				this.tower_upgrade_persistent_data.current_mode = 2
				witch.wick_mode = 2
				--然后播放切换动画
				this.render.sprites[6].hidden = true
				U.animation_start(this, "toGreen", nil, store.tick_ts, false, 5)
				U.y_wait(store, fts(4))
				U.y_animation_play(this, "toGreen", nil, store.tick_ts, false, 4)
				U.animation_start(this, "Green", nil, store.tick_ts, true, 4)
				this.render.sprites[6].name = "green"
				this.render.sprites[6].hidden = false
				U.y_animation_wait(this, 5)
				U.animation_start(this, "stir", nil, store.tick_ts, true, 5)
			end
			return true
		end

		return false
	end

	while true do

		if b.rally_new then
			b.rally_new = false

			signal.emit("rally-point-changed", this)
			S:queue(this.sound_events.change_rally_point)

			for i, s in ipairs(b.soldiers) do
				s.nav_rally.pos = V.vclone(b.rally_pos)
				s.nav_rally.center = V.vclone(b.rally_pos)
				s.nav_rally.new = true
			end
		end

		if this.powers and this.powers.silent.changed then
			this.powers.silent.changed = nil

			for i, s in ipairs(b.soldiers) do
				s.powers.silent.changed = true
				s.powers.silent.level = this.powers.silent.level
			end
		end

		if this.powers and this.powers.frog.changed then
			this.powers.frog.changed = nil

			for i, s in ipairs(b.soldiers) do
				s.powers.frog.changed = true
				s.powers.frog.level = this.powers.frog.level
			end
		end

		if this.powers and this.powers.range.changed then
			this.powers.range.changed = nil

			for i, s in ipairs(b.soldiers) do
				s.powers.range.changed = true
				s.powers.range.level = this.powers.range.level
			end
			this.barrack.rally_range = this.powers.range.range[this.powers.range.level]
		end
		
		--图腾攻击，封塔则无法施法
		if this.tower.blocked or not this.powers or this.powers.silent.level == 0 then
			-- block empty
		else
			local name = "silent"
			do
				local pow = this.powers[name]
				local ta = this.attacks.list[1]

				if pow.level < 1 or store.tick_ts - ta.ts < ta.cooldown then
					-- block empty
				else
					local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, ta.max_range[this.powers.range.level], false, ta.vis_flags, ta.vis_bans)

					if not enemy then
						-- block empty
					else
						ta.ts = store.tick_ts

						local node_offset = math.random(-4, 8)
						local totem_node = enemy.nav_path.ni

						if P:is_node_valid(enemy.nav_path.pi, enemy.nav_path.ni + node_offset) then
							totem_node = totem_node + node_offset
						end

						local totem_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, totem_node)
						local b = E:create_entity(ta.bullet)

						b.pos.x, b.pos.y = totem_pos.x, totem_pos.y
						b.aura.level = pow.level
						b.aura.ts = store.tick_ts
						b.aura.source_id = this.id
						b.render.sprites[1].ts = store.tick_ts
						b.render.sprites[2].ts = store.tick_ts
						b.render.sprites[3].ts = store.tick_ts

						queue_insert(store, b)
					end
				end
			end

		end

		--查形态
		check_change_mode()
		coroutine.yield()
	end
end

scripts.soldier_wicked_sisters = {}

function scripts.soldier_wicked_sisters.insert(this, store, script)
	this.attacks.order = U.attack_order(this.attacks.list)
	this.idle_flip.ts = store.tick_ts

	return true
end

function scripts.soldier_wicked_sisters.remove(this, store, script)
	--S:stop("MechWalk")
	--S:stop("MechSteam")

	return true
end

function scripts.soldier_wicked_sisters.update(this, store, script)
	local ab = this.attacks.list[1]
	local am = this.attacks.list[2]
	local pow_m = this.powers and this.powers.frog
	if not this.wick_mode then
		this.wick_mode = 2
	end
	local owner = store.entities[this.soldier.tower_id];
	ab.ts = store.tick_ts - ab.cooldown / 2

	this.render.sprites[1].hidden = false
	if not owner.tower_upgrade_persistent_data.initialized then
		U.y_animation_play(this, "spawn", nil, store.tick_ts, false, 1)
		owner.tower_upgrade_persistent_data.initialized = true
	end

	:: label_64_0 ::
	while true do
		local r = this.nav_rally
		while r.new do
			r.new = false

			U.set_destination(this, r.pos)

			local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)

			U.animation_start(this, an, af, store.tick_ts, true, 1)
			--S:queue("MechWalk")

			local ts = store.tick_ts

			while not this.motion.arrived and not r.new do
				if store.tick_ts - ts > 1 then
					ts = store.tick_ts

					--S:queue("MechSteam")
				end

				U.walk(this, store.tick_length)
				coroutine.yield()

				this.motion.speed.x, this.motion.speed.y = 0, 0
			end

			--S:stop("MechWalk")
			coroutine.yield()
		end

		--只有变形是塔外女巫释放的，参照黄法
		if pow_m and pow_m.level > 0 then
			if pow_m.changed then
				pow_m.changed = nil

				if pow_m.level == 1 then
					am.ts = store.tick_ts
				end
				am.cooldown = pow_m.cooldown[pow_m.level]
				am.disabled = false
			end

			if store.tick_ts - am.ts > am.cooldown then
				local target = ULH.find_first_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)
				if not target then
					-- block empty
				else
					am.ts = store.tick_ts

					local an, af = U.animation_name_facing_point(this, am.animations, target.pos)
					U.animation_start(this, an, af, store.tick_ts, false, 1)
					U.y_wait(store, am.hit_times)

					if target then
						local b = E:create_entity(am.bullet)
						b.bullet.damage_factor = owner.tower.damage_factor
						b.pos.x = this.pos.x + (af and -1 or 1) * am.start_offset.x
						b.pos.y = this.pos.y + am.start_offset.y
						b.bullet.from = V.vclone(b.pos)
						b.bullet.to =  V.vclone(target.pos)
						if target.unit and target.unit.hit_offset then
							b.bullet.to.x, b.bullet.to.y = b.bullet.to.x + target.unit.hit_offset.x, b.bullet.to.y + target.unit.hit_offset.y
						end
						b.bullet.target_id = target.id
						b.bullet.source_id = this.id

						queue_insert(store, b)
					end
					U.y_animation_wait(this)

					goto label_64_0
				end
			end
		end

		if store.tick_ts - ab.ts > ab.cooldown then
			--local target ,enemies  = ULH.find_idmost_enemy_in_range(store.entities, this.pos, ab.min_range, ab.max_range, ab.node_prediction, ab.vis_flags, ab.vis_bans)
			local trigger, trigger_pos = ULH.find_first_enemy(store.entities, this.pos, ab.min_range, ab.max_range, false, ab.vis_flags, ab.vis_bans)
			if trigger then
				ab.ts = store.tick_ts
				local wick_mode = this.wick_mode
				local an, af = U.animation_name_facing_point(this, ab.animations[wick_mode], trigger.pos)
				U.animation_start(this, an, af, store.tick_ts, false, 1)
				U.y_wait(store, ab.hit_times[wick_mode])

				local target, target_pos = ULH.find_first_enemy(store.entities, this.pos, ab.min_range, ab.max_range, false, ab.vis_flags, ab.vis_bans)
				local b = E:create_entity(ab.bullet[wick_mode])
				b.bullet.damage_factor = owner.tower.damage_factor
				b.pos.x = this.pos.x + (af and -1 or 1) * ab.start_offsets[wick_mode].x
				b.pos.y = this.pos.y + ab.start_offsets[wick_mode].y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.source_id = this.id
				if target then
					b.bullet.to = target_pos
					if target.unit and target.unit.hit_offset then
						b.bullet.to.x, b.bullet.to.y = b.bullet.to.x + target.unit.hit_offset.x, b.bullet.to.y + target.unit.hit_offset.y
					end
					b.bullet.target_id = target.id
				else
					b.bullet.to = trigger_pos
					b.bullet.target_id = trigger.id
				end
				if wick_mode == 1 and math.random() < 0.6 then
					b.bullet.mod = "mod_wicked_sisters_stun_lvl"..owner.tower.level
				end
				queue_insert(store, b)

				while not U.animation_finished(this) do
					if this.nav_rally.new then
						break
					end

					coroutine.yield()
				end

				goto label_64_0
			end
		end

		if store.tick_ts - this.idle_flip.ts > this.idle_flip.cooldown then
			this.idle_flip.ts = store.tick_ts

			local new_pos = V.vclone(this.pos)

			this.idle_flip.last_dir = -1 * this.idle_flip.last_dir
			new_pos.x = new_pos.x + this.idle_flip.last_dir * this.idle_flip.walk_dist

			if not GR:cell_is(new_pos.x, new_pos.y, TERRAIN_WATER) then
				r.new = true
				r.pos = new_pos

				goto label_64_0
			end
		end

		U.animation_start(this, "idle", nil, store.tick_ts, true, 1)
		coroutine.yield()
	end
end

scripts.enemy_frog = {}

function scripts.enemy_frog.update(this, store)
	local clicks = 0

	while true do
		if this.health.dead then
			SU.y_enemy_death(store, this)

			return
		end

		if this.ui.clicked then
			this.ui.clicked = nil
			clicks = clicks + 1
		end

		if clicks >= this.clicks_to_destroy then
			this.health.hp = 0
			this.health.last_damage_types = DAMAGE_EXPLOSION
			coroutine.yield()
		elseif this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			SU.y_enemy_walk_until_blocked(store, this, true, function(store, this)
				return this.ui.clicked
			end)
		end
	end
end

scripts.aura_totem_wicked_sisters = {}

function scripts.aura_totem_wicked_sisters.update(this, store, script)
	local last_hit_ts = 0
	local a = this.aura
	local ring_sid = 1
	local ground_sid = 2
	local totem_sid = 3

	if GR:cell_is(this.pos.x, this.pos.y, TERRAIN_WATER) then
		local fx = E:create_entity("fx")

		fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
		fx.render.sprites[1].name = "totem_water_fx_enter"
		fx.render.sprites[1].anchor.y = 0.09
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
	end

	this.render.sprites[ring_sid].ts = store.tick_ts

	U.animation_start(this, "start", nil, store.tick_ts, 1, totem_sid)

	while not U.animation_finished(this, totem_sid) do
		coroutine.yield()
	end

	while store.tick_ts - this.aura.ts < a.duration + a.duration_inc * a.level do
		local enemies = table.filter(store.entities, function(k, e)
			return e.enemy and e.vis and e.health and not e.health.dead and band(e.vis.flags, this.aura.vis_bans) == 0 and band(e.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(e.pos, this.pos, this.aura.radius)
		end)

		for _, enemy in pairs(enemies) do
			local new_mod = E:create_entity(this.aura.mod)

			new_mod.modifier.level = this.aura.level
			new_mod.modifier.target_id = enemy.id
			new_mod.modifier.source_id = this.id

			queue_insert(store, new_mod)
		end

		last_hit_ts = store.tick_ts

		while store.tick_ts - last_hit_ts < this.aura.cycle_time do
			coroutine.yield()
		end
	end

	if GR:cell_is(this.pos.x, this.pos.y, TERRAIN_WATER) then
		local fx = E:create_entity("fx")

		fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
		fx.render.sprites[1].name = "totem_water_fx_exit"
		fx.render.sprites[1].anchor.y = 0.09
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
	end

	this.render.sprites[ground_sid].hidden = true
	this.render.sprites[ring_sid].hidden = true

	S:queue("TotemVanish")
	U.animation_start(this, "end", nil, store.tick_ts, 1, totem_sid)

	while not U.animation_finished(this, totem_sid) do
		coroutine.yield()
	end

	queue_remove(store, this)
end

--飞艇(女巫改)
scripts.tower_balloon = {}

function scripts.tower_balloon.get_info(this)
	local sm = E:get_template(this.barrack.soldier_type)
	local b = E:get_template(sm.attacks.list[1].bullet)
	local min, max = math.ceil(b.bullet.damage_min*this.tower.damage_factor*this.tower.damage_factor), math.ceil(b.bullet.damage_max*this.tower.damage_factor*this.tower.damage_factor)

	local cooldown = sm.attacks.list[1].cooldown
	local range = sm.attacks.list[1].max_range

	return {
		type = STATS_TYPE_TOWER_MAGE,
		damage_min = min,
		damage_max = max,
		range = range,
		cooldown = cooldown
	}
end

function scripts.tower_balloon.insert(this, store, script)
	return true
end

function scripts.tower_balloon.update(this, store, script)
	local wts
	local is_open = false

	local balloon = E:create_entity(this.barrack.soldier_type)

	balloon.pos.x, balloon.pos.y = this.pos.x, this.pos.y + 16
	balloon.nav_rally.pos.x, balloon.nav_rally.pos.y = this.tower.default_rally_pos.x, this.tower.default_rally_pos.y
	balloon.nav_rally.new = true
	balloon.owner = this
	balloon.wick_mode = 1

	queue_insert(store, balloon)
	table.insert(this.barrack.soldiers, balloon)
	coroutine.yield()


	wts = store.tick_ts
	is_open = true

	local b = this.barrack

	local pow_e = this.powers and this.powers.watcher
	local eagle_ts = 0
	local eagle_sid = 3

	this.eagle_previews = nil

	local eagle_previews_level
	--local ea = this.attacks and this.attacks.list[1]



	while true do


		if b.rally_new then
			b.rally_new = false

			signal.emit("rally-point-changed", this)
			S:queue(this.sound_events.change_rally_point)

			for i, s in ipairs(b.soldiers) do
				s.nav_rally.pos = V.vclone(b.rally_pos)
				s.nav_rally.center = V.vclone(b.rally_pos)
				s.nav_rally.new = true
			end
		end

		if this.powers and this.powers.oil.changed then
			this.powers.oil.changed = nil

			for i, s in ipairs(b.soldiers) do
				s.powers.oil.changed = true
				s.powers.oil.level = this.powers.oil.level
			end
		end

		if this.powers and this.powers.watcher.changed then
			this.powers.watcher.changed = nil

			for i, s in ipairs(b.soldiers) do
				s.powers.watcher.changed = true
				s.powers.watcher.level = this.powers.watcher.level
			end

			--eagle
			--U.animation_start(this, "fly", nil, store.tick_ts, 1, eagle_sid)
		end

		if this.powers and this.powers.bomber.changed then
			this.powers.bomber.changed = nil

			for i, s in ipairs(b.soldiers) do
				s.powers.bomber.changed = true
				s.powers.bomber.level = this.powers.bomber.level
			end
		end
		
		--提升射程技能

		if this.tower.blocked then
			--empty
		else

			--[[
			if pow_e and pow_e.level > 0 then
				if store.tick_ts - ea.ts > ea.cooldown then
					ea.ts = store.tick_ts

					local eagle_range = ea.range + ea.range_inc * pow_e.level
					local existing_mods = table.filter(store.entities, function(_, e)
						return e.modifier and e.template_name == ea.mod and e.modifier.level >= pow_e.level
					end)
					local busy_ids = table.map(existing_mods, function(k, v)
						return v.modifier.target_id
					end)
					local towers = table.filter(store.entities, function(_, e)
						return e.tower and e ~= this.owner and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(ea.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, eagle_range)
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

				if store.tick_ts - eagle_ts > ea.fly_cooldown then
					this.render.sprites[eagle_sid].hidden = false
					eagle_ts = store.tick_ts

					U.animation_start(this, "fly", nil, store.tick_ts, 1, eagle_sid)
					S:queue("CrossbowEagle")
				end
				
			end
			]]--
		end
		coroutine.yield()
	end
end

function scripts.tower_balloon.remove(this, store, script)
	for _, s in pairs(this.barrack.soldiers) do
		if s.health then
			s.health.dead = true
		end

		queue_remove(store, s)
	end

	return true
end

scripts.soldier_balloon = {}

function scripts.soldier_balloon.insert(this, store, script)
	this.attacks.order = U.attack_order(this.attacks.list)
	this.idle_flip.ts = store.tick_ts

	return true
end

function scripts.soldier_balloon.remove(this, store, script)
	--S:stop("MechWalk")
	--S:stop("MechSteam")

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

function scripts.soldier_balloon.update(this, store, script)
	local ab = this.attacks.list[1]
	local ea = this.attacks and this.attacks.list[2]
	local ao = this.attacks and this.attacks.list[3]
	local aa = this.attacks and this.attacks.list[4]
	local pow_o = this.powers and this.powers.oil
	local pow_b = this.powers and this.powers.bomber
	local pow_e = this.powers and this.powers.watcher
	--local pow_o = this.powers and this.powers.oil

	
	this.wick_mode = 1
	ab.ts = store.tick_ts

	this.render.sprites[1].hidden = false
	::label_64_0::


	this.eagle_previews = nil

	local eagle_previews_level
	
	while true do
		--注意system的818行。这可能是导致不能拖动的原因。（女巫、飞艇的代码都是高达复制的）
		local r = this.nav_rally

		--调集。目前还没有做完动画
		while r.new do
			r.new = false
			--首先需要移除所有范围加成
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
			--然后是移动
			U.set_destination(this, r.pos)

			local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)

			if this.owner.tower.level == 4 then
				U.animation_start_group(this, an, af, store.tick_ts, true, "layers")
			else
				U.animation_start(this, an, af, store.tick_ts, true, 1)
			end
			--同时塔台开始
			U.animation_start_group(this.owner, "flags", nil, store.tick_ts, true, "layers")
			--S:queue("MechWalk")

			local ts = store.tick_ts

			while not this.motion.arrived and not r.new do
				if store.tick_ts - ts > 1 then
					ts = store.tick_ts

					--S:queue("MechSteam")
				end

				U.walk(this, store.tick_length)
				coroutine.yield()

				this.motion.speed.x, this.motion.speed.y = 0, 0
			end

			--U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
			if this.owner.tower.level == 4 then
				U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
			else
				U.animation_start(this, "idle", nil, store.tick_ts, true, 1)
			end
			U.animation_start_group(this.owner, "idle", nil, store.tick_ts, true, "layers")

			--S:stop("MechWalk")
			coroutine.yield()
		end

		--对科技的补充
		if this.powers and this.powers.watcher.changed then
			this.powers.watcher.changed = nil
			ea.ts = store.tick_ts
		end

		if this.powers and this.powers.bomber.changed then
			this.powers.bomber.changed = nil
			if this.powers.bomber.level == 1 then
				aa.ts = store.tick_ts
			end
				
		end

		if this.powers and this.powers.oil.changed then
			this.powers.oil.changed = nil
			if this.powers.oil.level == 1 then
				ao.ts = store.tick_ts
			end
				
		end

		--投手
		if pow_b and pow_b.level > 0 then
			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.max_range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

				if enemy then
						aa.ts = store.tick_ts
						last_ts = store.tick_ts
						U.animation_start_group(this, "paratrooper", nil, store.tick_ts, false, "layers")
						--while not U.animation_finished(this, bomber_sid) do
						--	coroutine.yield()
						--end
						--while store.tick_ts - last_ts < fts(28) do
						--	coroutine.yield()
						--end
						--U.y_wait(store, fts(20))
						local trigger_pos = pred_pos

						enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.max_range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

						local b = E:create_entity(aa.bullet)

						b.bullet.damage_factor = this.owner.tower.damage_factor * this.owner.tower.damage_factor
						b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
						b.bullet.from = V.vclone(b.pos)
						b.bullet.to = this.pos--enemy and enemy.pos or trigger_pos
						b.bullet.source_id = this.id

						queue_insert(store, b)

						while not U.animation_finished(this, 2) do
							coroutine.yield()
						end
				end

				U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
			end
		end

		--漏油
		if pow_o and pow_o.level > 0 then
		    if store.tick_ts - ao.ts > ao.cooldown then
				local _, targets = U.find_foremost_enemy(store.entities, this.pos, ao.min_range, ao.max_range, true, ao.vis_flags, ao.vis_bans)

				if not targets then
					-- block empty
				else
					local target = table.random(targets)

					ao.ts = store.tick_ts

					local an, af = U.animation_name_facing_point(this, ao.animation, target.pos)

					U.animation_start(this, an, af, store.tick_ts, false, 1)
					U.y_wait(store, ao.hit_time)

					local b = E:create_entity(ao.bullet)

					b.pos.x = this.pos.x + (af and -1 or 1) * ao.start_offset.x
					b.pos.y = this.pos.y + ao.start_offset.y
					b.bullet.hit_payload = b.bullet.hit_payload..pow_o.level
					b.render.sprites[1].ts = store.tick_ts
					b.bullet.from = V.v(b.pos.x,b.pos.y)
					b.bullet.to = this.pos

					queue_insert(store, b)

					while not U.animation_finished(this, 1) do
						coroutine.yield()
					end

					goto label_64_0
				end
			end
		end

		--普攻
		if store.tick_ts - ab.ts > ab.cooldown then
			local target ,enemies  = U.find_foremost_enemy(store.entities, this.pos, ab.min_range, ab.max_range, ab.node_prediction, ab.vis_flags, ab.vis_bans)

			if not target then
				-- block empty
			else
				local pred_pos = P:predict_enemy_pos(target, ab.node_prediction)

				ab.ts = store.tick_ts
				this.wick_mode = km.zmod(this.wick_mode + 1, 2)
				local an, af = U.animation_name_facing_point(this, ab.animations[this.wick_mode], target.pos)

				U.animation_start(this, an, af, store.tick_ts, false, this.owner.tower.level == 4 and this.wick_mode + 4 or 2)
				U.y_wait(store, ab.hit_times[this.wick_mode])

				
				local b = E:create_entity(ab.bullet)
				b.bullet.damage_factor = this.owner.tower.damage_factor
				b.pos.x = this.pos.x + (af and -1 or 1) * ab.start_offsets[this.wick_mode].x
				b.pos.y = this.pos.y + ab.start_offsets[this.wick_mode].y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = pred_pos
				b.bullet.target_id = target.id
				b.bullet.source_id = this.id
				queue_insert(store, b)

				while not U.animation_finished(this) do
					if this.nav_rally.new then
						break
					end

					coroutine.yield()
				end

				goto label_64_0
			end
		end

		if store.tick_ts - this.idle_flip.ts > this.idle_flip.cooldown then
			this.idle_flip.ts = store.tick_ts

			local new_pos = V.vclone(this.pos)

			this.idle_flip.last_dir = -1 * this.idle_flip.last_dir
			new_pos.x = new_pos.x + this.idle_flip.last_dir * this.idle_flip.walk_dist

			if not GR:cell_is(new_pos.x, new_pos.y, TERRAIN_WATER) then
				r.new = true
				r.pos = new_pos

				goto label_64_0
			end
		end

		--增强范围
		if pow_e and pow_e.level > 0 and ea.ts ~= nil then
				if store.tick_ts - ea.ts > ea.cooldown then
					ea.ts = store.tick_ts

					local eagle_range = ea.range + ea.range_inc * pow_e.level
					local existing_mods = table.filter(store.entities, function(_, e)
						return e.modifier and e.template_name == ea.mod and e.modifier.level >= pow_e.level
					end)
					local busy_ids = table.map(existing_mods, function(k, v)
						return v.modifier.target_id
					end)
					local towers = table.filter(store.entities, function(_, e)
						return e.tower and e ~= this.owner and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(ea.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, eagle_range)
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

				--[[
				if store.tick_ts - eagle_ts > ea.fly_cooldown then
					this.render.sprites[eagle_sid].hidden = false
					eagle_ts = store.tick_ts

					U.animation_start(this, "fly", nil, store.tick_ts, 1, eagle_sid)
					S:queue("CrossbowEagle")
				end
				]]--
				
		end

		--U.animation_start(this, "idle", nil, store.tick_ts, true, 1)

		if this.owner.tower.level == 4 then
			U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
		else
			U.animation_start(this, "idle", nil, store.tick_ts, true, 1)
		end
		coroutine.yield()
	end
end

scripts.balloon_oil_bomb = {}
function scripts.balloon_oil_bomb.update(this,store,script)
end

scripts.soldier_balloon_goblin = {}

function scripts.soldier_balloon_goblin.update(this, store, script)
	local brk, stam

	this.reinforcement.ts = store.tick_ts
	this.render.sprites[1].ts = store.tick_ts
	this.nav_rally.center = nil
	this.nav_rally.pos = V.vclone(this.pos)

	local damage_factor = 1


	if this.sound_events and this.sound_events.raise then
		S:queue(this.sound_events.raise)
	end

	this.health_bar.hidden = true

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
		::label_706_1::
		if this.health.dead or (this.reinforcement.duration and store.tick_ts - this.reinforcement.ts > this.reinforcement.duration) then
			if this.health.hp > 0 then
				this.reinforcement.hp_before_timeout = this.health.hp
			end

			this.health.hp = 0
			queue_remove(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)

			idle_ts = store.tick_ts
			patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)
		else

			--不允许melee
			--[[
			if this.melee then
				brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
					idle_ts = store.tick_ts
					patrol_cd = math.random(this.patrol_min_cd, this.patrol_max_cd)

					goto label_706_0
				end
			end
			]]--

			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk or sta == A_DONE then
					goto label_706_1
				elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
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

scripts.range_mod_balloon = {}

function scripts.range_mod_balloon.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert range_mod_balloon to entity %s - ", target.id, target.template_name)

		return false
	end

	if target.attacks then
		target.attacks.range = target.attacks.range * (this.range_factor + m.level * this.range_factor_inc)
	end

	if target.barrack then
		target.barrack.rally_range = target.barrack.rally_range * (this.range_factor + m.level * this.range_factor_inc)
	end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.range_mod_balloon.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and target.attacks then
		target.attacks.range = target.attacks.range / (this.range_factor + m.level * this.range_factor_inc)
	end

	if target and target.barrack then
		target.barrack.rally_range = target.barrack.rally_range / (this.range_factor + m.level * this.range_factor_inc)
	end

	return true
end


--鱼人
scripts.tower_deep_devils = {}

function scripts.tower_deep_devils.get_info(this)
	--local sm = E:get_template(this.barrack.soldier_type)
	local b = E:get_template(this.attacks.list[1].bullet)
	local min, max = b.bullet.damage_min, b.bullet.damage_max

	min, max = math.ceil(min * this.tower.damage_factor),math.ceil(max * this.tower.damage_factor)

	local cooldown = this.attacks.list[1].cooldown
	local range = this.attacks.list[1].max_range

	return {
		type = STATS_TYPE_TOWER_MAGE,
		damage_min = min,
		damage_max = max,
		range = range,
		cooldown = cooldown
	}
end


function scripts.tower_deep_devils.insert(this, store, script)
	if not this.barrack.rally_pos and this.tower.default_rally_pos then
		this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
	end

	return true
end

function scripts.tower_deep_devils.soldier_insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		local pow_n = this.powers and this.powers.net or nil
		if pow_n.level > 0 then

			if pow_n.level == 1 then
				s.ranged.attacks[2].disabled = false
			else
				s.ranged.attacks[2].bullet = "net_deep_devils_lvl2"
			end
		end
		return true
	end

	return false
end

function scripts.tower_deep_devils.remove(this, store, script)
	for _, s in pairs(this.barrack.soldiers) do
		if s.health then
			s.health.dead = true
		end
		queue_remove(store, s)
	end
	if #this.sentinels > 0 then
		queue_remove(store, this.sentinels[1])
	end

	return true
end

function scripts.tower_deep_devils.update(this, store, script)
	local tower_sid = 2
	local door_sid = 3
	local shooter_sid = 4

	local ab = this.attacks and this.attacks.list[1]--射击
	--local as = this.attacks and this.attacks.list[2]--乌云

	local pow_a = this.powers and this.powers.amph or nil
	local pow_n = this.powers and this.powers.net or nil
	local pow_s = this.powers and this.powers.storm or nil
	local last_ts = 0
	if ab then
		last_ts = store.tick_ts - ab.cooldown
		ab.ts = store.tick_ts - ab.cooldown
	end
	local last_target_pos = V.v(0, 0)

	local attacks = {}
	local pows = {}
	this.bullet_loaded = false
	if ab then
		table.insert(attacks, ab)--射击
		--table.insert(pows, nil)
	end

	if as then
		table.insert(attacks, as)--乌云
		--table.insert(pows, nil)
	end

	this.sentinels = {}
	local dg2 = E:create_entity("soldier_deep_devils_lvl5")
	
	while true do
		local b = this.barrack
		if not this.tower.blocked then
			for i = 1, b.max_soldiers do
				local s = b.soldiers[i]

				if not s or s.health.dead and not store.entities[s.id] then
					if this.tower.level < 4 then
						if not b.door_open then
							S:queue("GUITowerOpenDoor")
							U.animation_start(this, "open", nil, store.tick_ts, 1, door_sid)

							while not U.animation_finished(this, door_sid) do
								coroutine.yield()
							end

							b.door_open = true
							b.door_open_ts = store.tick_ts
						end
					end

					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.id
					s.soldier.tower_soldier_idx = i
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers)
					s.nav_rally.new = true
					--[[
					if this.powers then
						for pn, p in pairs(this.powers) do
							s.powers[pn].level = p.level
						end
					end
					]]--

					queue_insert(store, s)

					b.soldiers[i] = s

					signal.emit("tower-spawn", this, s)
				end
			end
		end

		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil
					--乌云
					if p == pow_s then
						if #this.sentinels == 0 then
							local s = E:create_entity("high_elven_sentinel_dd")

							s.pos = V.vclone(this.pos)

							queue_insert(store, s)
							table.insert(this.sentinels, s)

							s.owner = this
							s.owner_idx = 1
						end
						this.sentinels[1].ranged.attacks[1].bullet = "ray_high_elven_sentinel_dd"..pow_s.level
					--强化
					elseif p == pow_a then
						b.soldier_type = "soldier_deep_devils_lvl5"
						for _, s in pairs(b.soldiers) do
							s.health.armor = dg2.health.armor
							s.health.hp_max = dg2.health.hp_max
							s.health.hp = dg2.health.hp_max
							s.melee.attacks[1].damage_max = dg2.melee.attacks[1].damage_max
							s.melee.attacks[1].damage_min = dg2.melee.attacks[1].damage_min
							s.ranged.attacks[1].bullet = dg2.ranged.attacks[1].bullet
						end
					--投网
					elseif p == pow_n then
						for _, s in pairs(b.soldiers) do
							if pow_n.level == 1 then
								s.ranged.attacks[2].disabled = false
							else
								s.ranged.attacks[2].bullet = "net_deep_devils_lvl2"
							end
							s.ranged.attacks[2].cooldown = pow_n.cooldown[pow_n.level]
							
						end		
					end
					for _, s in pairs(b.soldiers) do
						s.powers[pn].level = p.level
						s.powers[pn].changed = true
						if pow_n.level == 1 then
							s.ranged.attacks[2].disabled = false
							s.ranged.attacks[2].bullet = "net_deep_devils_lvl1"
						elseif pow_n.level == 2 then
							s.ranged.attacks[2].disabled = false
							s.ranged.attacks[2].bullet = "net_deep_devils_lvl2"
						end
					end
				end
			end
		end
		if this.tower.level < 4 then

			if b.door_open and store.tick_ts - b.door_open_ts > b.door_hold_time then
				U.animation_start(this, "close", nil, store.tick_ts, 1, door_sid)

				while not U.animation_finished(this, door_sid) do
					coroutine.yield()
				end

				b.door_open = false
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


		if this.tower.blocked then
			coroutine.yield()
		else
			for i, aa in pairs(attacks) do
				if aa and not aa.disabled and store.tick_ts - aa.ts > aa.cooldown then 
					if aa == ab then
						local target
						target = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, false, aa.vis_flags, aa.vis_bans)
						if not target then
							--SU.delay_attack(store, aa, fts(5))
						else
							local enemy_id = target.id
							local shoot_pos = pred_pos

							aa.ts = store.tick_ts

							local soffset = this.render.sprites[shooter_sid].offset
							local an, af, ai = U.animation_name_facing_point(this, aa.animation, target.pos, shooter_sid, soffset)
							local start_offset = aa.bullet_start_offset[ai]

							U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
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
								queue_insert(store, b)
							end
							while not U.animation_finished(this, shooter_sid) do
								coroutine.yield()
							end
						end		
					end
				end
			end
		end
		coroutine.yield()
	end
end

scripts.mod_deep_devils_net = {}

function scripts.mod_deep_devils_net.insert(this, store, script)
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

	target.motion.max_speed = target.motion.max_speed * this.slow.factor[level]
	this.modifier.ts = store.tick_ts
	
	if target.render.sprites[1].prefix == "enemy_rocketeer" then
	SU.remove_modifiers(store, target, "mod_rocketeer_speed_buff")
	end

	signal.emit("mod-applied", this, target)

	if target.melee then
		if target.melee.forced_cooldown then
			target.melee.forced_cooldown = target.melee.forced_cooldown + this.increase
		end
		if target.melee.cooldown then
			target.melee.cooldown = target.melee.cooldown + this.increase
		end
		if target.melee.attacks then
			if target.melee.attacks[1] then
				target.melee.attacks[1].cooldown = target.melee.attacks[1].cooldown + this.increase
			end
		end
	end
	if target.ranged then
		if target.ranged.forced_cooldown then
			target.ranged.forced_cooldown = target.ranged.forced_cooldown + this.increase
		end
		if target.ranged.cooldown then
			target.ranged.cooldown = target.ranged.cooldown + this.increase
		end
		if target.ranged.attacks then
			if target.ranged.attacks[1] then
				target.ranged.attacks[1].cooldown = target.ranged.attacks[1].cooldown + this.increase
			end
		end
	end

	return true
end

function scripts.mod_deep_devils_net.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local level = this.modifier.level

	if target and target.health and target.motion then
		target.motion.max_speed = target.motion.max_speed / this.slow.factor[level]
	--	target.motion.max_speed = target.motion.max_speed / this.slow.factor

		log.paranoid("mod_barbarian_net.remove (%s)-%s for (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	else
		log.debug("mod_barbarian_net.remove target is nil for id %s", this.modifier.target_id)
	end

	if target.melee then
		if target.melee.forced_cooldown then
			target.melee.forced_cooldown = target.melee.forced_cooldown - this.increase
		end
		if target.melee.cooldown then
			target.melee.cooldown = target.melee.cooldown - this.increase
		end
		if target.melee.attacks then
			if target.melee.attacks[1] then
				target.melee.attacks[1].cooldown = target.melee.attacks[1].cooldown - this.increase
			end
		end
	end
	if target.ranged then
		if target.ranged.forced_cooldown then
			target.ranged.forced_cooldown = target.ranged.forced_cooldown - this.increase
		end
		if target.ranged.cooldown then
			target.ranged.cooldown = target.ranged.cooldown - this.increase
		end
		if target.ranged.attacks then
			if target.ranged.attacks[1] then
				target.ranged.attacks[1].cooldown = target.ranged.attacks[1].cooldown - this.increase
			end
		end
	end

	return true
end

scripts.high_elven_sentinel_dd = {}

function scripts.high_elven_sentinel_dd.update(this, store)
	local sb_sid, ss_sid = 1, 2
	local sb = this.render.sprites[sb_sid]
	--local ss = this.render.sprites[ss_sid]
	local ra = this.ranged.attacks[1]
	local fm = this.force_motion

	local function move_step(dest)
		local dx, dy = V.sub(dest.x, dest.y, this.pos.x, this.pos.y)
		local dist = V.len(dx, dy)
		local ramp_radius = fm.ramp_radius
		local df = (not ramp_radius or ramp_radius < dist) and 1 or math.max(dist / ramp_radius, 0.1)

		fm.a.x, fm.a.y = V.add(fm.a.x, fm.a.y, V.trim(fm.max_a, V.mul(fm.a_step * df, dx, dy)))
		fm.v.x, fm.v.y = V.add(fm.v.x, fm.v.y, V.mul(store.tick_length, fm.a.x, fm.a.y))
		fm.v.x, fm.v.y = V.trim(fm.max_v, fm.v.x, fm.v.y)
		this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, V.mul(store.tick_length, fm.v.x, fm.v.y))
		fm.a.x, fm.a.y = V.mul(-1 * fm.fr / store.tick_length, fm.v.x, fm.v.y)
	end

	local function find_target(range)
		if this.owner.tower.blocked then
			return nil
		end

		local target, targets = U.find_foremost_enemy(store.entities, this.pos, 0, range, false, ra.vis_flags, ra.vis_bans)

		if target and #this.owner.sentinels > 1 then
			local other_target_id = this.owner.sentinels[this.owner_idx == 1 and 2 or 1].chasing_target_id

			if target.id == other_target_id and #targets > 1 then
				target = targets[2]
			end
		end

		return target
	end

	local charge_ts, wait_ts, shoot_ts, search_ts, shots = 0, 0, 0, 0, 0
	local target, targets, dist
	local dest = V.v(0, 0)
	local ps = E:create_entity(this.particles_name)

	ps.particle_system.track_id = this.id
	ps.particle_system.track_offset = V.v(0, this.flight_height)

	queue_insert(store, ps)

	while true do
		U.animation_start(this, "small", nil, store.tick_ts, true, sb_sid)

		--ss.hidden = true
		sb.hidden = true
		sb.z = Z_OBJECTS
		sb.sort_y = this.owner.pos.y
		ps.particle_system.emit = true
		ps.particle_system.sort_y = this.owner.pos.y
		this.tween.reverse = false
		this.tween.ts = store.tick_ts
		shots = 0
		charge_ts = store.tick_ts

		while true do
			local p = V.v(this.tower_rotation_radius, 0)

			p.x, p.y = V.rotate(store.tick_ts * this.tower_rotation_speed + (this.owner_idx - 1) * math.pi, p.x, p.y)
			p.y = 0.5 * p.y
			this.pos.x = this.owner.pos.x + this.tower_rotation_offset.x + p.x
			this.pos.y = this.owner.pos.y + this.tower_rotation_offset.y + p.y

			if store.tick_ts - charge_ts > this.charge_time then
				if sb.name == "small" then
					U.animation_start(this, "big", nil, store.tick_ts, true, sb_sid)
				end

				target = find_target(ra.launch_range)

				if target then
					S:queue("TowerHighMageSentinelActivate")

					break
				end
			end

			coroutine.yield()
		end

		::label_29_0::

		sb.z = Z_BULLETS
		sb.sort_y_offset = 0
		--ss.hidden = true
		sb.hidden = false
		ps.particle_system.emit = false
		this.chasing_target_id = target.id
		dest.x, dest.y = target.pos.x, target.pos.y

		repeat
			dist = V.dist(this.pos.x, this.pos.y, dest.x, dest.y)

			move_step(dest)
			coroutine.yield()
		until dist < ra.shoot_range or target.health.dead or band(ra.vis_flags, target.vis.bans) ~= 0

		if shots < ra.max_shots and store.entities[target.id] and not target.health.dead and band(ra.vis_flags, target.vis.bans) == 0 then
			if store.tick_ts - shoot_ts > ra.cooldown then
				shoot_ts = store.tick_ts
				shots = shots + 1

				U.animation_start(this, "shoot", nil, store.tick_ts, false, sb_sid)
				--U.y_wait(store, ra.shoot_time)

				local b = E:create_entity(ra.bullet)

				b.pos.x, b.pos.y = this.pos.x + sb.offset.x, this.pos.y + sb.offset.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
				b.bullet.target_id = target.id
				b.bullet.source_id = this.id

				queue_insert(store, b)
				U.y_animation_wait(this, sb_sid)
				U.animation_start(this, "big", nil, store.tick_ts, true, sb_sid)
			end

			goto label_29_0
		end

		wait_ts = store.tick_ts
		this.chasing_target_id = nil

		U.animation_start(this, "big", nil, store.tick_ts, true, sb_sid)

		local wait_time = shots < ra.max_shots and this.wait_time or this.wait_spent_time

		::label_29_1::

		search_ts = store.tick_ts

		if shots < ra.max_shots then
			target = find_target(ra.max_range)

			if target then
				goto label_29_0
			end
		end

		while store.tick_ts - search_ts < ra.search_cooldown do
			move_step(dest)
			coroutine.yield()
		end

		if wait_time > store.tick_ts - wait_ts then
			goto label_29_1
		end

		this.tween.ts = store.tick_ts
		this.tween.reverse = true

		U.y_wait(store, this.tween.props[1].keys[2][1])
	end
end

--沙虫巢穴
scripts.tower_sandworm = {}

function scripts.tower_sandworm.get_info(this)
	local b = E:get_template(this.attacks.list[1].bullet)

	if not b.bullet.damage_min or not b.bullet.damage_max then
		b.bullet.damage_min = b.bullet.damage_min_config[this.tower.level]
		b.bullet.damage_max = b.bullet.damage_max_config[this.tower.level]
	end

	local o = scripts.tower_common.get_info(this)

	--o.type = STATS_TYPE_TOWER_MAGE
	damage_basic = {4,9,14,19}
	damage_times = {14,16,18,20}
	local min = math.ceil(damage_basic[this.tower.level]*this.tower.damage_factor) * damage_times[this.tower.level] --math.ceil(b.bullet.damage_min * this.tower.damage_factor)
	local max = min--math.ceil(b.bullet.damage_max * this.tower.damage_factor)

	o.damage_min = min
	o.damage_max = max

	return o
end

function scripts.tower_sandworm.update(this, store)
	local a = this.attacks 
	local ab = this.attacks.list[1]--普攻
	local as = this.attacks.list[3]--粘液
	local ae = this.attacks.list[2]--吃
	local aw = this.attacks.list[4]--召唤
	local pow_e = this.powers and this.powers.eat or nil
	local pow_s = this.powers and this.powers.slime or nil
	local pow_w = this.powers and this.powers.worm or nil
	local last_ts = store.tick_ts - ab.cooldown

	a._last_target_pos = a._last_target_pos or v(REF_W, 0)
	ab.ts = store.tick_ts - ab.cooldown + a.attack_delay_on_spawn

	local attacks = {}
	local pows = {}
	--local skeletonts = store.tick_ts
	this.bullet_loaded = false;

	if aw then
		table.insert(attacks, aw)--普攻
		table.insert(pows, pow_w)
	end

	if as then
		table.insert(attacks, as)--粘液
		table.insert(pows, pow_s)
	end

	if ae then
		table.insert(attacks, ae)--秒杀
		table.insert(pows, pow_e)
	end

	if ab then
		table.insert(attacks, ab)--沙虫
		table.insert(pows, nil)
	end


	while true do 
		if this.tower.blocked then
			coroutine.yield()
		else
			if this.powers then		

				if pow_s.level > 0 and pow_s.changed then
					pow_s.changed = nil
					as.disabled = false
					as.cooldown = pow_s.cooldown[pow_s.level]
					as.ts = store.tick_ts - as.cooldown
				end

				if pow_e.level > 0 and pow_e.changed then
					pow_e.changed = nil
					ae.disabled = false
					ae.cooldown = pow_e.cooldown
					ae.ts = store.tick_ts - ae.cooldown
				end

				if pow_w.level > 0 and pow_w.changed then
					pow_w.changed = nil
					aw.disabled = false
					aw.cooldown = pow_w.cooldown[pow_w.level]
					aw.ts = store.tick_ts - aw.cooldown
				end

			end

			SU.towers_swaped(store, this, this.attacks.list)

			for i, aa in pairs(attacks) do
				if aa and not aa.disabled and store.tick_ts - aa.ts > aa.cooldown then 
					if aa == aw then
						aw.ts = store.tick_ts
						local skelet = "sandworm_skelebomb"
						if pow_w.level == 2 then
							skelet = "sandworm_skelebomb2"
						end
						local enemy = U.find_random_enemy(store.entities, tpos(this), 0, aw.range, pow_w.vis_flags, pow_w.vis_bans)
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
							b.bullet.level = pow_w.level
						end
						queue_insert(store, b)
					elseif aa == ab then
						local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						if not enemy then
							SU.delay_attack(store, aa, fts(10))
						else
							last_ts = store.tick_ts

							S:queue(aa.sound)
							U.animation_start(this, "shoot", nil, store.tick_ts, false, 2)
							U.y_wait(store, fts(11))

							a._last_target_pos.x, a._last_target_pos.y = enemy.pos.x, enemy.pos.y

							local trigger_pos = pred_pos
							local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

							if enemy then 
								local ni = enemy.nav_path.ni + P:predict_enemy_node_advance(enemy, aa.node_prediction)
								pred_pos = P:node_pos(enemy.nav_path.pi, 1, ni)
							end

							local b = E:create_entity(aa.bullet)
							b.bullet.damage_factor = this.tower.damage_factor
							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = enemy and pred_pos or trigger_pos
							b.bullet.source_id = this.id

							b.bullet.level = this.tower.level
							b.bullet.damage_factor = this.tower.damage_factor
							b.tower_ref = this

							queue_insert(store, b)
							this.bullet_loaded = false;

							::label_421_1::
							U.y_animation_wait(this, 2)

							U.animation_start(this, "idle", nil, store.tick_ts, false, 2)
							aa.ts = last_ts
						end
					elseif aa == ae then
						local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						if not enemy then
							SU.delay_attack(store, aa, fts(10))
						else
							last_ts = store.tick_ts

							U.animation_start(this, "instakill", nil, store.tick_ts, false, 2)
							S:queue("sandwormEatIn")
							U.y_wait(store, fts(20))

							a._last_target_pos.x, a._last_target_pos.y = enemy.pos.x, enemy.pos.y

							local trigger_pos = pred_pos
							local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

							if enemy then 
								local ni = enemy.nav_path.ni + P:predict_enemy_node_advance(enemy, aa.node_prediction)
								pred_pos = P:node_pos(enemy.nav_path.pi, 1, ni)
							end

							local b = E:create_entity(aa.bullet)
							b.bullet.damage_factor = this.tower.damage_factor
							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = enemy and pred_pos or trigger_pos
							b.bullet.source_id = this.id

							b.bullet.level = this.tower.level
							b.bullet.damage_factor = this.tower.damage_factor
							b.tower_ref = this

							queue_insert(store, b)
							this.bullet_loaded = false

							::label_421_1::
							U.y_wait(store, fts(20))
							S:queue("sandwormEatOut")
							U.y_animation_wait(this, 2)
							U.animation_start(this, "idle", nil, store.tick_ts, false, 2)
							aa.ts = last_ts
						end
					elseif aa == as then
						local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						if not enemy then
							SU.delay_attack(store, aa, fts(10))
						else
							last_ts = store.tick_ts

							--S:queue(aa.sound)
							U.animation_start(this, "spit", nil, store.tick_ts, false, 2)
							U.y_wait(store, fts(11))

							a._last_target_pos.x, a._last_target_pos.y = enemy.pos.x, enemy.pos.y

							local trigger_pos = pred_pos
							local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

							if enemy then 
								local ni = enemy.nav_path.ni + P:predict_enemy_node_advance(enemy, aa.node_prediction)
								pred_pos = P:node_pos(enemy.nav_path.pi, 1, ni)
							end

							local b = E:create_entity(aa.bullet)
							b.bullet.damage_factor = this.tower.damage_factor
							b.pos.x, b.pos.y = this.pos.x + aa.bullet_start_offset.x, this.pos.y + aa.bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = enemy and pred_pos or trigger_pos
							b.bullet.source_id = this.id

							b.bullet.level = pow_s.level
							b.bullet.damage_factor = this.tower.damage_factor
							b.tower_ref = this

							queue_insert(store, b)
							this.bullet_loaded = false;

							::label_421_1::
							U.y_animation_wait(this, 2)

							U.animation_start(this, "idle", nil, store.tick_ts, false, 2)
							aa.ts = last_ts
						end
					end
				end
			end
			coroutine.yield()
		end
	end
	return true
end

scripts.tower_sandworm_bomb = {}
function scripts.tower_sandworm_bomb.update(this, store)
	local b = this.bullet
	local dmin, dmax = b.damage_min, b.damage_max
	local dradius = b.damage_radius
	local tower = this.tower_ref


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

		d.value = U.frandom(dmin, dmax)


		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id

		if b.xp_gain_factor and b.xp_dest_id then
			d.xp_gain_factor = b.xp_gain_factor
			d.xp_dest_id = b.source_id
		end

		if band(d.damage_type,DAMAGE_INSTAKILL) ~= 0 and ((band(enemy.vis.flags, bor(F_BOSS, F_MINIBOSS)) ~= 0 or band(enemy.vis.bans, bor(F_INSTAKILL, F_DISINTEGRATED, F_EAT) ~= 0))) then
			--empty block
		else
			queue_damage(store, d)
		end
		log.paranoid("bomb id:%s, radius:%s, enemy id:%s, dist:%s, damage:%s damage_type:%x", this.id, dradius, enemy.id, V.dist(enemy.pos.x, enemy.pos.y, b.to.x, b.to.y), d.value, d.damage_type)

		if this.up_shock_and_awe_chance and band(enemy.vis.bans, F_STUN) == 0 and band(enemy.vis.flags, bor(F_BOSS, F_CLIFF, F_FLYING)) == 0 and math.random() < this.up_shock_and_awe_chance then
			local mod = E:create_entity("mod_shock_and_awe")

			mod.modifier.target_id = enemy.id

			queue_insert(store, mod)
		end


	end

	if b.mod then
			local mod = E:create_entity(b.mod)
			--mod.pos.x, mod.pos.y = this.pos.x, this.pos.y
			mod.bullet.dradius = b.damage_radius
			mod.bullet.damage_min = b.damage_min
			mod.bullet.damage_max = b.damage_max
			mod.bullet.damage_every = b.damage_every
			mod.bullet.explode_pos = V.v(this.pos.x, this.pos.y)
			mod.bullet.aura_duration = this.bullet.aura_duration[b.level]
			mod.bullet.damage_type = b.damage_type
			mod.bullet.damage_flags = b.damage_flags
			mod.bullet.damage_factor = b.damage_factor

			queue_insert(store, mod)
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
		hp.source_id = b.source_id
		
		if hp.aura then
			hp.aura.duration = this.aura_duration[this.bullet.level]
			hp.tween.props[1].keys = {
				{
					0,
					255
				},
				{
					hp.aura.duration - 0.5,
					255
				},
				{
					hp.aura.duration,
					0
				}
			}
		
		else
			this.aura.mod = nil
		end

		queue_insert(store, hp)
	end

	queue_remove(store, this)
end

scripts.tower_sandworm_lava = {}

function scripts.tower_sandworm_lava.update(this, store)
	local b = this.bullet
	local dradius = b.damage_radius
	local dmin = b.damage_min
	local dmax = b.damage_max
	local damage_every = b.damage_every
	local damage_factor = b.damage_factor
	local explode_pos = V.v(b.explode_pos.x, b.explode_pos.y)
	local aura_duration = b.aura_duration
	local damage_type = b.damage_type
	local dps_ts = store.tick_ts
	local init_ts = store.tick_ts
	local count = 0
	local count2 = 0
	while true do
		if (store.tick_ts - dps_ts >= damage_every and store.tick_ts - init_ts <= aura_duration) then
			dps_ts = dps_ts + damage_every
			count = count + 1
			
			local enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, explode_pos, dradius)
			end)
			local d_value = math.ceil(dmax * damage_factor)
		
			for _, enemy in pairs(enemies) do
				local d = E:create_entity("damage")
				count2 = count2 + 1
				d.source_id = this.id
				d.target_id = enemy.id
				d.value = d_value
				d.damage_type = damage_type
				--d.damage_radius = b.damage_radius
				--d.damage_flags = b.damage_flags
				d.track_damage = true
				queue_damage(store, d)
			end
		end
		if store.tick_ts - init_ts > aura_duration then
			dps_ts = dps_ts + damage_every
			count = count + 1
			local enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, explode_pos, dradius)
			end)
			local d_value = U.frandom(dmin, dmax)
		
			for _, enemy in pairs(enemies) do
				local d = E:create_entity("damage")
				count2 = count2 + 1
				d.source_id = this.id
				d.target_id = enemy.id
				d.value = math.ceil(d_value)
				d.damage_type = damage_type
				--d.damage_radius = b.damage_radius
				--d.damage_flags = b.damage_flags
				d.track_damage = true
				queue_damage(store, d)
			end
			break 
		end
	
		coroutine.yield()
	end
	queue_remove(store, this)
end

scripts.aura_sandworm_apply_mod = {}

function scripts.aura_sandworm_apply_mod.insert(this, store, script)
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

function scripts.aura_sandworm_apply_mod.update(this, store, script)
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
	

	U.animation_start(this, "in", nil, store.tick_ts, false, 1)
	U.y_animation_wait(this, 1)

	U.animation_start(this, "run", nil, store.tick_ts, true, 1)

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

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end

scripts.sandworm_skeleflingerbomb = {}

function scripts.sandworm_skeleflingerbomb.update(this, store)
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

scripts.enemies_skelespawner_sw = {}

function scripts.enemies_skelespawner_sw.update(this, store, script)
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

scripts.bomb_kro_sw = {}

function scripts.bomb_kro_sw.update(this, store, script)
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

scripts.soldier_flingers_skeleton_sw = {}

function scripts.soldier_flingers_skeleton_sw.get_info(this)
	local t = scripts.soldier_barrack.get_info(this)

	t.respawn = nil

	return t
end

function scripts.soldier_flingers_skeleton_sw.insert(this, store, script)
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

function scripts.soldier_flingers_skeleton_sw.update(this, store, script)
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

scripts.hero_jack_o_lantern = {}
function scripts.hero_jack_o_lantern.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

	local s

	s = this.hero.skills.explosive_head

	if initial and s.level > 0 then
		local a = this.timed_attacks.list[1]
		local b = E:get_template(a.bullet)
		b.bullet.damage_min = s.damage[s.level]
		b.bullet.damage_max = s.damage[s.level]
		a.disabled = nil
	end

	s = this.hero.skills.haunted_blade

	if initial and s.level > 0 then
		local a = this.melee.attacks[2]
		a.cooldown = s.cooldown[s.level]
		a.disabled = nil
	end

	s = this.hero.skills.hero_jacko_melee

	if initial and s.level > 0 then
		this.health.accumulated_damage_factor = s.accumulated_damage_factor[s.level]
	end

	s = this.hero.skills.hero_jacko_thriller

	if initial and s.level > 0 then
		local a = this.timed_attacks.list[2]
		a.max_bullets = s.max_bullets[s.level]
		a.disabled = nil
	end

	s = this.hero.skills.ultimate

	if initial and s.level > 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		local e = E:get_template(u.entity)
		e.aura.damage_min = s.damage_over_time[s.level]
		e.aura.damage_max = s.damage_over_time[s.level]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_jack_o_lantern.update(this, store, script)
	local h = this.health
	local hero = this.hero
	local explosive_head_attack = this.timed_attacks.list[1]
	local hero_jacko_thriller_attack = this.timed_attacks.list[2]
	local skill_ultimate = this.hero.skills.ultimate
	local ultimate_controller = E:get_template(skill_ultimate.controller_name)
	local attack, skill

	this.melee.attacks[1].ts = store.tick_ts
	this.melee.attacks[2].ts = store.tick_ts
	explosive_head_attack.ts = store.tick_ts
	hero_jacko_thriller_attack.ts = store.tick_ts
	skill_ultimate.ts = store.tick_ts - ultimate_controller.cooldown

	this.health_bar.hidden = true
	U.y_animation_play(this, "respawn", nil, store.tick_ts)
	this.health_bar.hidden = false
	U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)

	local function y_hero_death_and_respawn(store, this)
		this.ui.can_click = false
		local death_ts = store.tick_ts
		local dead_lifetime = h.dead_lifetime
	
		U.unblock_target(store, this)
		S:queue(this.sound_events.death, this.sound_events.death_args)
		SU_PLD.hide_shadow(this, true)
		if this.unit.death_animation then
			U.y_animation_play(this, this.unit.death_animation, nil, store.tick_ts, 1, 1)
		else
			U.y_animation_play(this, "death", nil, store.tick_ts, 1, 1)
		end
		U.animation_start(this, this.hero.death_loop_animation, nil, store.tick_ts, true, 1)

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
	
		if hero and hero.respawn_point then
			local p = he.respawn_point
			this.pos.x, this.pos.y = p.x, p.y
			this.nav_rally.pos.x, this.nav_rally.pos.y = p.x, p.y
			this.nav_rally.center.x, this.nav_rally.center.y = p.x, p.y
			this.nav_rally.new = false
		end
	
		h.ignore_damage = true
		S:queue(this.sound_events.respawn)
		SU_PLD.hide_shadow(this, false)
		if hero.respawn_animation then
			U.y_animation_play(this, hero.respawn_animation, nil, store.tick_ts, 1, 1)
		else
			U.y_animation_play(this, "respawn", nil, store.tick_ts, 1, 1)
		end
	
		this.health_bar.hidden = false
		this.ui.can_click = true
		h.dead = false
		this.force_respawn = nil
		h.hp = h.hp_max
		h.ignore_damage = false
	end

	while true do
		if h.dead then
			y_hero_death_and_respawn(store, this)
			U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)
		end

		-- SU.heroes_visual_learning_upgrade(store, this)
		-- SU.heroes_lone_wolves_upgrade(store, this)
		SU.alliance_merciless_upgrade(store, this)
		SU.alliance_corageous_upgrade(store, this)

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelUp", nil, store.tick_ts)
		end

		local skip
		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
			skip = true
		else
			while this.nav_rally.new do
				if SU.hero_will_teleport(this, this.nav_rally.pos) then
					SU_PLD.hide_shadow(this, true)
				end
				skip = SU.y_hero_new_rally(store, this)
				SU_PLD.hide_shadow(this, false)
			end
		end

		if not skip then
			attack = explosive_head_attack
			if SU_PLD.check_unit_attack_available(store, this, attack) then
				local done = nil
				skip, done = SU_PLD.entity_attacks(store, this, attack)
				if not skip then
					SU.delay_attack(store, attack, fts(10))
				elseif done == A_DONE then
					hero_jacko_thriller_attack.ts = hero_jacko_thriller_attack.ts + attack.extra_cooldown
				end
			end
		end

		if not skip then
			attack = hero_jacko_thriller_attack
			if SU_PLD.check_unit_attack_available(store, this, attack) then
				skip = SU_PLD.entity_attacks(store, this, attack)
				if not skip then
					SU.delay_attack(store, attack, fts(10))
				end
			end
		end

		--自动放大招的代码
		if false and not skip and store.tick_ts - skill_ultimate.ts >= ultimate_controller.cooldown then
			local entity = E:get_template(ultimate_controller.entity)
			local target, ultimatePos, targets_info
			target = U.find_foremost_enemy(store.entities, this.pos, 0, skill_ultimate.max_range)
			if target then
				targets_info = U.find_enemies_in_paths(store.entities, target.pos, 0, skill_ultimate.range_nodes_max, nil, entity.aura.vis_flags, entity.aura.vis_bans, true)
			end
			if targets_info and #targets_info >= skill_ultimate.min_targets then
				target = targets_info[1].enemy
				if not target.nav_path then
					target = nil
				else
					ultimatePos = V.vclone(target.pos)
					if not ultimate_controller.can_fire_fn(nil, ultimatePos.x, ultimatePos.y) then
						target = nil
						ultimatePos = nil
					end
				end
			end
			if not target or not ultimatePos then
				skill_ultimate.ts = store.tick_ts - ultimate_controller.cooldown + 0.1
			else
				U.animation_start(this, "levelUp", nil, store.tick_ts)
				local u = E:create_entity(ultimate_controller)
				u.pos = ultimatePos
				u.level = skill_ultimate.level
				queue_insert(store, u)
				skill_ultimate.ts = store.tick_ts
				while not U.animation_finished(this) do
					if SU.hero_interrupted(this) then
						skip = true
						break
					end
					coroutine.yield()
				end
			end
		end

		if not skip then
			local brk, sta = y_hero_melee_block_and_attacks(store, this)
			if not brk and sta == A_NO_TARGET and not SU.soldier_go_back_step(store, this) then
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		coroutine.yield()
	end
end

scripts.hero_jack_o_lantern_ultimate = {}
function scripts.hero_jack_o_lantern_ultimate.update(this, store, script)
	local pi, spi, ni
	local function insert_entity()
		local npos = P:node_pos(pi, spi, ni)
		local e = E:create_entity(this.entity)
		e.pos = npos
		if e.nav_path then
			e.nav_path.pi = pi
			e.nav_path.spi = spi
			e.nav_path.ni = ni
		end
		queue_insert(store, e)
	end

	local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, { 1 }, true)
	if #nodes < 1 then
		queue_remove(store, this)
		return
	end
	pi, spi, ni = unpack(nodes[1])
	insert_entity()
	for i = 2, 3 do
		spi = i
		-- nodes = P:nearest_nodes(this.pos.x, this.pos.y, { pi }, { spi }, true)
		-- if #nodes < 1 then
		-- 	goto label_continue
		-- end
		-- pi, spi, ni = unpack(nodes[1])
		insert_entity()
		-- ::label_continue::
	end
	queue_remove(store, this)
end

scripts.mod_track_target_with_fade = {}
function scripts.mod_track_target_with_fade.update(this, store, script)
	local m = this.modifier
	m.ts = store.tick_ts

	local target = store.entities[m.target_id]
	if not target or not target.pos then
		queue_remove(store, this)
		return
	end
	this.pos = target.pos

	if this.tween then
		this.tween.reverse = false
		this.tween.remove = false
		if this.fade_in then
			this.tween.disabled = false
			this.tween.ts = store.tick_ts
		else
			this.tween.disabled = true
		end
	end

	while true do
		target = store.entities[m.target_id]
		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
			if this.tween and this.fade_out then
				this.tween.reverse = true
				this.tween.remove = true
				this.tween.disabled = false
				this.tween.ts = store.tick_ts
			else
				queue_remove(store, this)
			end
			return
		end

		if this.render and target.unit then
			local s = this.render.sprites[1]
			local flip_sign = 1

			if not s._original_offset then
				s._original_offset = V.vclone(s.offset)
			end
			if target.render then
				flip_sign = target.render.sprites[1].flip_x and -1 or 1
			end

			if m.health_bar_offset and target.health_bar then
				local hb = target.health_bar.offset
				local hbo = m.health_bar_offset
				s.offset.x, s.offset.y = hb.x + (s._original_offset.x + hbo.x) * flip_sign, hb.y + hbo.y + s._original_offset.y
			elseif m.use_mod_offset and target.unit.mod_offset then
				s.offset.x, s.offset.y = (s._original_offset.x + target.unit.mod_offset.x) * flip_sign, target.unit.mod_offset.y + s._original_offset.y
			end
		end

		coroutine.yield()
	end
end

scripts.summoning_hero_ultimate = {}
function scripts.summoning_hero_ultimate.can_fire_fn(this, x, y, store)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.summoning_hero_ultimate.update(this, store, script)
	local e = E:create_entity(this.entity)
	if this.use_center or e.nav_rally or e.nav_path or e.path_index then
		local pi, spi, ni
		spi = this.use_center and 1 or nil
		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, { spi }, true)
		if #nodes < 1 then
			queue_remove(store, this)
			return
		end
		pi, spi, ni = unpack(nodes[1])
		local npos = P:node_pos(pi, spi, ni)
		e.pos = V.vclone(npos)
		if e.nav_rally then
			e.nav_rally.center = npos
			e.nav_rally.pos = npos
		end
		if e.nav_path then
			e.nav_path.pi = pi
			e.nav_path.spi = spi
			e.nav_path.ni = ni
		end
		if e.path_index then
			e.path_index = pi
		end
	else
		e.pos = this.pos
	end
	queue_insert(store, e)
	queue_remove(store, this)
end


scripts.KR5Bomb = {}
function scripts.KR5Bomb.insert(this, store, script)
	local b = this.bullet
	b.speed = SU.initial_parabola_speed(b.from, b.to, b.flight_time, b.g)
	b.ts = store.tick_ts
	b.last_pos = V.vclone(b.from)

	if b.rotation_speed then
		b.rotation_speed = b.rotation_speed * (b.to.x > b.from.x and -1 or 1)
	end

	if b.hide_radius then
		this.render.sprites[1].hidden = true
	end

	local s = this.render.sprites[1]
	s.flip_x = b.to.x < b.from.x
	if s.animated then
		s.ts = store.tick_ts
	end

	return true
end

function scripts.KR5Bomb.update(this, store, script)
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

	if b.damages_min and b.damages_max and b.level then
		dmin = b.damages_min[b.level]
		dmax = b.damages_max[b.level]
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

	--return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, V.v(b.to.x, b.to.y - b.target_unit_hit_offset_y or 0), dradius)

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, V.v(b.to.x, b.to.y - (b.target_unit_hit_offset_y or 0)), dradius)
	end)

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.damage_type = b.damage_type
		d.reduce_armor = b.reduce_armor
		d.reduce_magic_armor = b.reduce_magic_armor

		if b.damage_decay_random then
			d.value = U.frandom(dmin, dmax)
		else
			local upg = UP:get_upgrade("towers_improved_formulas")
			local source = store.entities[b.source_id]

			if upg and (source and source.tower or this.from_tower) then
				d.value = dmax
			else
				local dist_factor = U.dist_factor_inside_ellipse(enemy.pos, b.to, dradius)

				d.value = math.floor(dmax - (dmax - dmin) * dist_factor)
			end
		end

		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id

		if b.xp_gain_factor and b.xp_dest_id then
			d.xp_gain_factor = b.xp_gain_factor
			d.xp_dest_id = b.source_id
		end

		queue_damage(store, d)

		if this.up_shock_and_awe_chance and band(enemy.vis.bans, F_STUN) == 0 and band(enemy.vis.flags, bor(F_BOSS, F_CLIFF, F_FLYING)) == 0 and math.random() < this.up_shock_and_awe_chance then
			local mod = E:create_entity("mod_shock_and_awe")

			mod.modifier.target_id = enemy.id

			queue_insert(store, mod)
		end

		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}
			for i, mod_name in ipairs(mods) do
				local mod = E:create_entity(mod_name)
				mod.modifier.target_id = enemy.id
				mod.modifier.source_id = this.id
				mod.modifier.level = b.level
				queue_insert(store, mod)
			end
		end
	end

	local p = SU.create_bullet_pop(store, this)
	if p then
		queue_insert(store, p)
	end

	local s = this.render.sprites[1]
	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if b.hit_fx_water and band(cell_type, TERRAIN_WATER) ~= 0 then
		S:queue(this.sound_events.hit_water)
		local water_fx = E:create_entity(b.hit_fx_water)
		water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
		water_fx.render.sprites[1].ts = store.tick_ts
		water_fx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset
		water_fx.render.sprites[1].flip_x = s.flip_x
		queue_insert(store, water_fx)
	elseif b.hit_fx then
		S:queue(this.sound_events.hit)
		local sfx = E:create_entity(b.hit_fx)
		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset
		sfx.render.sprites[1].flip_x = s.flip_x
		queue_insert(store, sfx)
	end

	if b.hit_decal and band(cell_type, TERRAIN_WATER) == 0 then
		SU_PLD.create_bullet_hit_decal(this, store, s.flip_x)
	end

	SU_PLD.create_bullet_hit_payload(this, store, s.flip_x)

	queue_remove(store, this)
end

scripts.soldier_hover = {}
function scripts.soldier_hover.update(this, store, script)
	local brk, sta

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	this.hover.oni = this.nav_path.ni
	this.hover.ts = store.tick_ts
	this.hover.cooldown = U.frandom(this.hover.cooldown_min, this.hover.cooldown_max + 1e-9)
	if this.reinforcement then
		this.reinforcement.ts = store.tick_ts
	end
	U.set_destination(this, this.pos)

	if this.tween then
		this.tween.reverse = false
		this.tween.remove = false
		if this.fade_in then
			this.tween.disabled = false
			this.tween.ts = store.tick_ts
		else
			this.tween.disabled = true
		end
	end

	if this.render.sprites[1].name == "raise" then
		this.health_bar.hidden = true
		SU_PLD.hide_shadow(this, true)
		U.animation_start(this, "raise", nil, store.tick_ts)
		while not U.animation_finished(this) and not this.health.dead do
			coroutine.yield()
		end
		if not this.health.dead then
			SU_PLD.hide_shadow(this, false)
			this.health_bar.hidden = nil
		end
	end

	while true do
		if this.cloak then
			this.vis.flags = band(this.vis.flags, bnot(this.cloak.flags))
			this.vis.bans = band(this.vis.bans, bnot(this.cloak.bans))
			this.render.sprites[1].alpha = 255
		end

		if this.health.dead or this.reinforcement and this.reinforcement.duration and store.tick_ts - this.reinforcement.ts > this.reinforcement.duration then
			U.unblock_target(store, this)
			if this.health.hp > 0 then
				this.reinforcement.hp_before_timeout = this.health.hp
			end
			this.health.hp = 0
			this.ui.can_click = false
			SU.remove_modifiers(store, this)
			S:queue(this.sound_events.death, this.sound_events.death_args)
			SU_PLD.hide_shadow(this, true)
			U.animation_start(this, "death", nil, store.tick_ts)
			U.y_animation_wait(this)
			if this.tween and this.fade_out then
				this.tween.reverse = true
				this.tween.remove = true
				this.tween.disabled = nil
				this.tween.ts = store.tick_ts
			else
				queue_remove(store, this)
			end
			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			if this.dodge and this.dodge.active then
				this.dodge.active = false
				if this.dodge.counter_attack then
					this.dodge.counter_attack_pending = true
				elseif this.dodge.animation then
					if this.dodge.hide_shadow then
						SU_PLD.hide_shadow(this, true)
					end
					U.animation_start(this, this.dodge.animation, nil, store.tick_ts, 1)
					while not U.animation_finished(this) do
						coroutine.yield()
					end
					SU_PLD.hide_shadow(this, false)
				end
			end
			
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
					SU_PLD.hide_shadow(this, true)
				end
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)
				if this.dodge and this.dodge.hide_shadow then
					SU_PLD.hide_shadow(this, false)
				end
				if brk or sta ~= A_NO_TARGET then
					goto label_43_1
				end
			end

			if this.ranged and not this.ranged.range_while_blocking then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)
				if brk or sta == A_DONE then
					goto label_43_1
				elseif sta == A_IN_COOLDOWN then
					local flip_x = this.motion and this.motion.dest.x < this.pos.x or nil
					U.animation_start(this, "idle", flip_x, store.tick_ts, true)
					goto label_43_1
				end
			end

			if this.cloak then
				this.vis.flags = bor(this.vis.flags, this.cloak.flags)
				this.vis.bans = bor(this.vis.bans, this.cloak.bans)

				if this.cloak.alpha then
					this.render.sprites[1].alpha = this.cloak.alpha
				end
			end

			if V.veq(this.pos, this.motion.dest) then
				this.motion.arrived = true
			elseif not U.walk(this, store.tick_length) then
				local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)
				U.animation_start(this, an, af, store.tick_ts, true)
			end
			if this.motion.arrived then
				U.animation_start(this, "idle", nil, store.tick_ts, true)
				SU.soldier_regen(store, this)
				if store.tick_ts - this.hover.ts >= this.hover.cooldown then
					this.hover.ts = store.tick_ts
					this.hover.cooldown = U.frandom(this.hover.cooldown_min, this.hover.cooldown_max + 1e-9)
					this.nav_path.spi = this.hover.random_subpath and math.random(1, 3) or this.nav_path.spi
					this.nav_path.ni = this.hover.oni + math.random(this.hover.random_ni * -1, this.hover.random_ni)
					local next_pos = P:node_pos(this.nav_path.pi, this.nav_path.spi, this.nav_path.ni)
					if next_pos and P:is_node_valid(this.nav_path.pi, this.nav_path.ni) and GR:cell_is(next_pos.x, next_pos.y, TERRAIN_LAND) and 
					not GR:cell_is(next_pos.x, next_pos.y, TERRAIN_NOWALK) then
						U.set_destination(this, next_pos)
					end
				end
			end
		end

		::label_43_1::

		coroutine.yield()
	end
end

scripts.aura_wander = {}
function scripts.aura_wander.update(this, store, script)
	this.aura.ts = store.tick_ts
	local last_hit_ts = store.tick_ts - this.aura.cycle_time

	local function wander()
		local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
			this.nav_path.pi
		}, {
			this.nav_path.spi
		})
		if nearest and nearest[1] and nearest[1][3] < this.nav_path.ni then
			this.nav_path.ni = nearest[1][3]
		end
		local next_pos = P:next_entity_node(this, store.tick_length)
		if not next_pos or not P:is_node_valid(this.nav_path.pi, this.nav_path.ni) or not GR:cell_is(next_pos.x, next_pos.y, TERRAIN_LAND) or 
		GR:cell_is(next_pos.x, next_pos.y, TERRAIN_NOWALK) then
			return true
		end
		U.set_destination(this, next_pos)
		local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)
		U.animation_start(this, an, af, store.tick_ts, true)
		U.walk(this, store.tick_length)
		return false
	end

	if this.tween then
		this.tween.reverse = false
		this.tween.remove = false
		if this.fade_in then
			this.tween.disabled = false
			this.tween.ts = store.tick_ts
		else
			this.tween.disabled = true
		end
	end

	if this.spawn_animation then
		U.y_animation_play(this, this.spawn_animation, nil, store.tick_ts)
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

	while true do
		if this.aura.duration >= 0 and store.tick_ts - this.aura.ts >= this.aura.duration + this.aura.level * this.aura.duration_inc then
			break
		end

		if store.tick_ts - last_hit_ts >= this.aura.cycle_time then
			last_hit_ts = store.tick_ts

			local targets = table.filter(store.entities, function(k, v)
				return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.excluded_entities or not table.contains(this.aura.excluded_entities, v.id))
			end)

			for _, target in pairs(targets) do
				local d = E:create_entity("damage")
				d.source_id = this.id
				d.target_id = target.id
				local dmin, dmax = this.aura.damage_min, this.aura.damage_max
				if this.aura.damage_inc then
					dmin = dmin + this.aura.damage_inc * this.aura.level
					dmax = dmax + this.aura.damage_inc * this.aura.level
				end
				d.value = math.random(dmin, dmax)
				d.damage_type = this.aura.damage_type
				d.track_damage = this.aura.track_damage
				d.xp_dest_id = this.aura.xp_dest_id
				d.xp_gain_factor = this.aura.xp_gain_factor
				queue_damage(store, d)

				local mods = this.aura.mods or {
					this.aura.mod
				}
				for _, mod_name in pairs(mods) do
					local m = E:create_entity(mod_name)
					m.modifier.level = this.aura.level
					m.modifier.target_id = target.id
					m.modifier.source_id = this.id
					queue_insert(store, m)
				end

				if this.aura.hit_blood_fx then
					local hit_fx_pos = V.vclone(target.pos)
					local flip_x = nil
					if target.render and target.unit and target.unit.hit_offset then
						flip_x = target.render.sprites[1].flip_x
						local flip_sign = target.render.sprites[1].flip_x and -1 or 1
						hit_fx_pos.x = target.unit.hit_offset.x * flip_sign + hit_fx_pos.x
						hit_fx_pos.y = target.unit.hit_offset.y + hit_fx_pos.y
					end
					local hit_fx = SU.insert_sprite(store, this.aura.hit_blood_fx, hit_fx_pos, flip_x)
					if hit_fx.use_blood_color and target.unit and target.unit.blood_color then
						hit_fx.render.sprites[1].name = target.unit.blood_color
					end
				end
			end
		end

		if wander() then
			break
		end
		coroutine.yield()
	end

	S:queue(this.sound_events.death, this.sound_events.death_args)
	if ps then
		for i, p in ipairs(ps) do
			p.particle_system.emit = nil
		end
	end
	SU_PLD.hide_shadow(this, true)
	if this.death_animation then
		U.y_animation_play(this, this.death_animation, nil, store.tick_ts)
	end
	if this.dead_lifetime and this.dead_lifetime > 0 then
		if this.death_animation then
			U.y_wait(store, this.dead_lifetime)
		else
			U.y_wait(store, this.dead_lifetime, wander())
		end
	end
	if this.tween and this.fade_out then
		this.tween.reverse = true
		this.tween.remove = true
		this.tween.disabled = nil
		this.tween.ts = store.tick_ts
		if not this.death_animation then
			while not wander() do
				coroutine.yield()
			end
		end
	else
		queue_remove(store, this)
	end
end

scripts.mod_intimidation = {}
function scripts.mod_intimidation.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if not target or target.health.dead or not target.unit then
		return false
	end
	
	if band(this.modifier.vis_flags, target.vis.bans) ~= 0 or band(this.modifier.vis_bans, target.vis.flags) ~= 0 then
		return false
	end

	if this.speed_factor and target.motion then
		target.motion.max_speed = target.motion.max_speed * this.speed_factor
	end

	if target.nav_path and target.vis and target.vis.flags then
		if band(target.vis.flags, F_FRIEND) ~= 0 then
			target.nav_path.dir = 1
		else
			target.nav_path.dir = -1
		end
		if target.vis.bans then
			target.vis._original_bans = target.vis.bans
			target.vis.bans = U.flag_set(target.vis.bans, F_BLOCK)
		end
		if target and target.enemy then
			U.unblock_all(store, target)
		end
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

function scripts.mod_intimidation.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if target then
		if this.speed_factor and target.motion then
			target.motion.max_speed = target.motion.max_speed / this.speed_factor
		end

		if target.nav_path and target.vis and target.vis.flags then
			if band(target.vis.flags, F_FRIEND) ~= 0 then
				target.nav_path.dir = -1
			else
				target.nav_path.dir = 1
			end
			if target.vis.bans then
				target.vis.bans = target.vis._original_bans
			end
		end
	end

	return true
end

scripts.entities_delay_controller = {}
function scripts.entities_delay_controller.update(this, store, script)
	if not this.delays or not this.entities or #this.delays ~= #this.entities then
		queue_remove(store, this)
		return
	end

	local start_ts = this.start_ts or store.tick_ts
	local function insert_entity()
		local delay = this.delays[1]
		if delay + start_ts <= store.tick_ts then
			local entity = this.entities[1]
			table.remove(this.delays, 1)
			table.remove(this.entities, 1)
			if entity.render then
				for i, s in pairs(entity.render.sprites) do
					s.ts = store.tick_ts
				end
			end
			if entity.tween then
				entity.tween.ts = store.tick_ts
			end
			if entity.pos and entity.pos.x == 0 and entity.pos.y == 0 then
				entity.pos.x, entity.pos.y = this.pos.x, this.pos.y
			end
			queue_insert(store, entity)
			if #this.delays > 0 then
				this.delays[1] = delay + this.delays[1]
				insert_entity()
			end
		end
	end

	while #this.delays > 0 do
		insert_entity()
		coroutine.yield()
	end
	queue_remove(store, this)
end

return scripts