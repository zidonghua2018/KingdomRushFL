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
local SULH = require("script_utils_lh")
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

scripts.hero_orc = {}

function scripts.hero_orc.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = math.ceil(ls.melee_damage_min[hl] * this.unit.damage_factor)
		this.melee.attacks[1].damage_max = math.ceil(ls.melee_damage_max[hl] * this.unit.damage_factor)
	end

	s = this.hero.skills.duelist
	if initial and s.level > 0 then
		this.melee.attacks[2].disabled = nil
		this.melee.attacks[2].damage_min = s.damage_config[s.level]
		this.melee.attacks[2].damage_max = s.damage_config[s.level]
		this.melee.attacks[2].cooldown = s.cooldown[s.level]
	end

	s = this.hero.skills.brute_force
	if initial and s.level > 0 then
		this.melee.attacks[3].disabled = nil
		e = E:get_template(this.melee.attacks[3].mod)
		e.modifier.duration = 1		
		this.melee.attacks[3].cooldown = s.cooldown[s.level]
	end

	s = this.hero.skills.inspiring_leader
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = nil
		this.timed_attacks.list[1].cooldown = s.cooldown[s.level]
		e = E:get_template(this.timed_attacks.list[1].bullet)
		e.bullet.hit_payload = s.instance[s.level]
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		u.entity = s.instance[s.level]
	end
end

function scripts.hero_orc.update(this, store, script)
	local h = this.health
	local hero = this.hero
	--local explosive_head_attack = this.timed_attacks.list[1]
	local hero_orc_thriller_attack = this.timed_attacks.list[1]
	local attack, skill
	local consist_count = 0
	local consist_mul = 0
	this.hero.courage_ts = 0

	this.melee.attacks[1].ts = store.tick_ts
	this.melee.attacks[2].ts = store.tick_ts
	this.melee.attacks[3].ts = store.tick_ts
	--explosive_head_attack.ts = store.tick_ts
	hero_orc_thriller_attack.ts = store.tick_ts

	this.health_bar.hidden = true
	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = false
	--U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
			U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)
		end

		-- SU.heroes_visual_learning_upgrade(store, this)
		-- SU.heroes_lone_wolves_upgrade(store, this)
		SU.alliance_merciless_upgrade(store, this)
		SU.alliance_corageous_upgrade(store, this)

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts)
		end

		local skip
		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
			skip = true
		else
			-- # 无条件回血
			if this.health and this.health.hp > 0 and store.tick_ts - this.hero.courage_ts > 1 then
				this.hero.courage_ts = store.tick_ts
				this.health.hp = km.clamp(0, this.health.hp_max, km.round(this.health.hp + math.ceil(this.hero.level / 4)))
			end
			while this.nav_rally.new do
				--if SU.hero_will_teleport(this, this.nav_rally.pos) then
				--	SU_PLD.hide_shadow(this, true)
				--end
				skip = SU.y_hero_new_rally(store, this)
				--SU_PLD.hide_shadow(this, false)
			end
		end


		if not skip then
			attack = hero_orc_thriller_attack
			if SU_PLD.check_unit_attack_available(store, this, attack) then
				skip = SU_PLD.entity_attacks(store, this, attack)
				if skip == false then
					SU.delay_attack(store, attack, fts(10))
				end
			end
		end

		-- 3技能的伤害加成，注意。
		if this.hero.skills.aimed_slash.level > 0 then
			consist_mul = math.min(math.ceil(consist_count / 5), 3)
			this.melee.attacks[1].damage_min = math.ceil(this.hero.level_stats.melee_damage_min[this.hero.level] * (1+consist_mul * this.hero.skills.aimed_slash.damage_inc[this.hero.skills.aimed_slash.level]))
			this.melee.attacks[1].damage_max = math.ceil(this.hero.level_stats.melee_damage_max[this.hero.level] * (1+consist_mul * this.hero.skills.aimed_slash.damage_inc[this.hero.skills.aimed_slash.level]))
		end
		if not skip then
			local brk, sta = y_hero_melee_block_and_attacks(store, this)
			if brk == true then
				consist_count = consist_count + 1
			elseif sta == A_IN_COOLDOWN or sta == A_DONE then
				-- pass
			else
				consist_count = 0
			end
			if not brk and sta == A_NO_TARGET and not SU.soldier_go_back_step(store, this) then
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		coroutine.yield()
	end
end

--维鲁克大招
scripts.controller_orc_ultimate = {}
function scripts.controller_orc_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

scripts.orc_ultimate = {}
function scripts.orc_ultimate.update(this, store)
	--仿照援兵
	--e.pos = V.v(this.pos.x, this.pos.y) 
	local wx, wy = this.pos.x, this.pos.y
	local e = E:create_entity(this.entity)
	
	e.pos.x = wx + 10
	e.pos.y = wy - 10
	e.nav_rally.center = V.v(wx, wy)
	e.nav_rally.pos = V.vclone(e.pos)
	
	queue_insert(store, e)

	e = E:create_entity(this.entity)
	e.pos.x = wx - 10
	e.pos.y = wy + 10
	e.nav_rally.center = V.v(wx, wy)
	e.nav_rally.pos = V.vclone(e.pos)
	
	queue_insert(store, e)
end

scripts.hero_asra = {}

function scripts.hero_asra.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	s = this.hero.skills.spider_bite
	if initial and s.level > 0 then
		this.melee.attacks[2].disabled = false
		this.melee.attacks[2].xp_gain = s.xp_gain[s.level]
		local e = E:get_template(this.melee.attacks[2].mod)
		e.dps.damage_max = s.damage_config[s.level]
		e.dps.damage_min = s.damage_config[s.level]
	end

	s = this.hero.skills.onix_arrows
	if initial and s.level > 0 then
		this.ranged.attacks[2].disabled = false
		this.ranged.attacks[2].max_loops = s.loops[s.level]
		this.ranged.attacks[2].loops = s.loops[s.level]
		this.ranged.attacks[2].xp_gain = s.xp_gain[s.level]
		local e = E:get_template(this.ranged.attacks[2].bullet)
		e.bullet.damage_max = s.damage_max[s.level]
		e.bullet.damage_min = s.damage_min[s.level]
	end

	s = this.hero.skills.quiver_of_sorrow
	if initial and s.level > 0 then
		local e = E:get_template("mod_arrow_asra")
		e.damage_min = s.damage_armor[s.level]
		e.damage_max = s.damage_armor[s.level]
	end

	s = this.hero.skills.shield_of_shadows
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		this.timed_attacks.list[1].xp_gain = s.xp_gain[s.level]
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		local e = E:get_template("mod_hero_asra_ultimate_poison")
		e.dps.damage_min = s.damage_config[s.level]
		e.dps.damage_max = s.damage_config[s.level]
	end
end

function scripts.hero_asra.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta
	local unbreakable_attack = this.timed_attacks.list[1]
	unbreakable_attack.ts = 0
	this.melee.attacks[1].ts = 0
	this.melee.attacks[2].ts = 0
	this.ranged.attacks[1].ts = 0
	this.ranged.attacks[2].ts = 0


	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

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
					goto label_40243_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			skill = this.hero.skills.shield_of_shadows
			a = unbreakable_attack
			if not a.disabled and store.tick_ts - a.ts > a.cooldown and not U.has_modifiers(store, this, a.mod) then
				local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range_trigger, a.vis_flags, a.vis_bans)

				if not enemies or #enemies < a.min_targets then
					SU.delay_attack(store, a, fts(10))
				else
					local start_ts = store.tick_ts

					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts, 1)

					if SU.y_hero_wait(store, this, a.cast_time) then
						-- block empty
					else
						if a.mod_decal then
							local d = E:create_entity(a.mod_decal)

							d.modifier.source_id = this.id
							d.modifier.target_id = this.id

							queue_insert(store, d)
						end

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range_effect, a.vis_flags, a.vis_bans)

						if enemies and #enemies > 0 then
							enemies = table.slice(enemies, 1, a.max_targets)

							local m = E:create_entity(a.mod)
							local shield_max_damage = skill.shield_max_damage[skill.level]

							m.modifier.source_id = this.id
							m.modifier.target_id = this.id
							m.shield_max_damage = shield_max_damage

							local mod_prefix

							if #enemies <= #m.sprites_per_enemies then
								mod_prefix = m.sprites_per_enemies[#enemies]
							else
								mod_prefix = m.sprites_per_enemies[#m.sprites_per_enemies]
							end

							m.render.sprites[1].prefix = mod_prefix

							queue_insert(store, m)
						end

						SU.y_hero_animation_wait(this)
					end

					goto label_40243_0
				end
			end

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_40243_0::

		coroutine.yield()
	end
end

scripts.hero_asra_unbreakable_mod = {}

function scripts.hero_asra_unbreakable_mod.insert(this, store)
	local m = this.modifier
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	m.ts = store.tick_ts
	target.health._on_damage = target.health.on_damage
	target.health.on_damage = scripts.hero_asra_unbreakable_mod.on_damage
	this._hit_sources = {}
	this._blood_color = target.unit.blood_color
	target.unit.blood_color = BLOOD_NONE
	target._shield_mod = this
	this.health.hp = this.shield_max_damage
	this.health.hp_max = this.shield_max_damage

	return true
end

function scripts.hero_asra_unbreakable_mod.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		target.health.on_damage = target.health._on_damage
		target._shield_mod = nil
		target.unit.blood_color = this._blood_color
	end

	return true
end

function scripts.hero_asra_unbreakable_mod.update(this, store)
	local m = this.modifier

	this.modifier.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	U.y_animation_play(this, this.animation_start, nil, store.tick_ts, 1)

	while true do
		target = store.entities[m.target_id]

		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
			U.y_animation_play(this, this.animation_end, nil, store.tick_ts, 1)
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

		U.y_animation_play(this, this.animation_loop, nil, store.tick_ts, 1)
		coroutine.yield()
	end
end

function scripts.hero_asra_unbreakable_mod.on_damage(this, store, damage)
	local mod = this._shield_mod

	if not mod then
		log.error("hero_asra_unbreakable_mod.on_damage for enemy %s has no mod pointer", this.id)

		return true
	end

	if mod.shield_broken then
		return true
	end

	if U.flag_has(damage.damage_type, bor(DAMAGE_INSTAKILL, DAMAGE_DISINTEGRATE, DAMAGE_EAT, DAMAGE_IGNORE_SHIELD)) then
		mod.shield_broken = true

		queue_remove(store, mod)

		return true
	else
		mod.damage_taken = mod.damage_taken + damage.value
	end

	mod.health.hp = mod.shield_max_damage - mod.damage_taken

	if mod.damage_taken >= mod.shield_max_damage then
		mod.shield_broken = true

		queue_remove(store, mod)

		if mod.damage_taken - mod.shield_max_damage > 0 then
			damage.value = mod.damage_taken - mod.shield_max_damage

			return true
		end
	end

	return false
end

scripts.hero_asra_ultimate = {}

function scripts.hero_asra_ultimate.can_fire_fn(this, x, y)
	return not GR:cell_is(x, y, TERRAIN_FAERIE) and P:valid_node_nearby(x, y, 1.4285714285714286, NF_POWER_3)
end

function scripts.hero_asra_ultimate.update(this, store)
	local function spawn_arrow(pi, spi, ni)
		spi = spi or math.random(1, 3)

		local pos = P:node_pos(pi, spi, ni)

		pos.x = pos.x + math.random(-4, 4)
		pos.y = pos.y + math.random(-5, 5)

		local b = E:create_entity(this.bullet)

		b.bullet.damage_max = this.damage[this.level]
		b.bullet.damage_min = this.damage[this.level]
		b.bullet.from = V.v(pos.x + math.random(-170, -140), pos.y + REF_H)
		b.bullet.to = pos
		b.pos = V.vclone(b.bullet.from)

		queue_insert(store, b)
	end
	S:queue(this.sound)

	local nearest = P:nearest_nodes(this.pos.x, this.pos.y)

	if #nearest > 0 then
		local pi, spi, ni = unpack(nearest[1])

		spawn_arrow(pi, spi, ni)

		local count = this.spread[this.level]
		local sequence = {}

		for i = 1, count do
			sequence[i] = i
		end

		while #sequence > 0 do
			local i = table.remove(sequence, math.random(1, #sequence))
			local delay = U.frandom(0, 1 / count)

			U.y_wait(store, delay / 2)

			if P:is_node_valid(pi, ni + i) then
				spawn_arrow(pi, nil, ni + i)
			else
				spawn_arrow(pi, nil, ni - i)
			end

			U.y_wait(store, delay / 2)

			if P:is_node_valid(pi, ni - i) then
				spawn_arrow(pi, nil, ni - i)
			else
				spawn_arrow(pi, nil, ni + i)
			end
		end
	end

	queue_remove(store, this)
end

scripts.arrow_hero_asra_ultimate = {}

function scripts.arrow_hero_asra_ultimate.update(this, store)
	local b = this.bullet
	local speed = b.max_speed

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) >= 2 * (speed * store.tick_length) do
		b.speed.x, b.speed.y = V.mul(speed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	local targets = U.find_targets_in_range(store.entities, b.to, 0, b.damage_radius, b.damage_flags, b.damage_bans)

	if targets then
		for _, target in pairs(targets) do
			local d = E:create_entity("damage")

			d.damage_type = b.damage_type
			d.value = b.damage_max
			d.source_id = this.id
			d.target_id = target.id

			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = target.id

				queue_insert(store, mod)
			end
		end
	end

	if b.hit_fx then
		SU.insert_sprite(store, b.hit_fx, this.pos)
	end

	if b.arrive_decal then
		local decal = E:create_entity(b.arrive_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	queue_remove(store, this)
end

scripts.decal_hero_asra_ultimate = {}

function scripts.decal_hero_asra_ultimate.insert(this, store)
	this.render.sprites[1].ts = store.tick_ts
	this.render.sprites[1].r = U.frandom(-10, 5) * math.pi / 180
	this.render.sprites[2].ts = store.tick_ts

	return true
end

scripts.hero_oloch = {}

function scripts.hero_oloch.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	if this.selfdestruct then
		this.selfdestruct.damage_min = ls.selfdestruct_damage_config[hl]
		this.selfdestruct.damage_max = ls.selfdestruct_damage_config[hl]
	end

	s = this.hero.skills.duplication
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		local e = E:get_template("bolt_oloch_duplication")
		e.bullet.damage_max = s.damage_max[s.level]
		e.bullet.damage_min = s.damage_min[s.level]
	end

	s = this.hero.skills.magma_eruption
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = false
		local e = E:get_template(this.timed_attacks.list[2].entity)
		e.bullet.damage_min = s.damage_config[s.level]
		e.bullet.damage_max = s.damage_config[s.level]
		local p = E:get_template(e.bullet.hit_payload)
		local a = E:get_template(p.aura.mod)
		a.dps.damage_min = s.damage_aura_config[s.level]
		a.dps.damage_max = s.damage_aura_config[s.level]
	end

	s = this.hero.skills.hellish_infusion
	if initial and s.level > 0 then
		this.auras.list[1].disabled = false
		this.auras.list[1].cooldown = s.cooldown[s.level]
		this.auras.list[1].damage_inc = s.damage_factor_config[s.level]
		local m = E:get_template(this.auras.list[1].mod)
		m.range_factor = s.damage_factor_config[s.level]
	end

	s = this.hero.skills.demonic_blast
	if initial and s.level > 0 then
		this.ranged.attacks[2].disabled = false
		this.ranged.attacks[2].xp_gain = s.xp_gain[s.level]
		local b = E:get_template(this.ranged.attacks[2].bullet)
		b.bullet.damage_max = s.damage_max[s.level]
		b.bullet.damage_min = s.damage_min[s.level]
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		u.max_targets = s.max_targets[s.level]
		local e = E:get_template("mod_hero_oloch_ultimate_teleport")
		e.nodes_offset = s.offset_config[s.level]
	end
end

function scripts.hero_oloch.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta
	local heat_aura_attack = this.auras.list[1]
	this.melee.attacks[1].ts = 0
	this.ranged.attacks[1].ts = 0
	this.ranged.attacks[2].ts = 0
	this.timed_attacks.list[1].ts = 0
	this.timed_attacks.list[2].ts = 0
	heat_aura_attack.ts = 0
	
	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	local function explosion(r, damage, dty)
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, r, 0, bit.bor(F_FLYING, F_CLIFF))

		if targets then
			for _, target in pairs(targets) do
				local d = E:create_entity("damage")

				d.value = damage
				d.damage_type = dty
				d.target_id = target.id
				d.source_id = this.id

				queue_damage(store, d)
			end
		end
	end

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_40884_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			--1技能 分身
			skill = this.hero.skills.duplication
			a = this.timed_attacks.list[1]
			if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
				local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)
				if target then
					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts)

					if U.y_wait(store, a.cast_time, function()
						return SU.hero_interrupted(this)
					end) then
						goto label_40884_0
					end

					SU.hero_gain_xp_from_skill(this, skill)

					a.ts = store.tick_ts

					local rotations = a.entity_rotations[a.count]

					for i = 1, a.count do
						local angle = rotations[i]
						local o = V.v(V.rotate(angle, a.initial_pos.x, a.initial_pos.y))
						local r = V.v(V.rotate(angle, a.initial_rally.x, a.initial_rally.y))
						local e = E:create_entity(a.entity)
						local rx, ry = this.pos.x + r.x, this.pos.y + r.y

						e.nav_rally.center = V.v(rx, ry)
						e.nav_rally.pos = V.v(rx, ry)
						e.pos.x, e.pos.y = this.pos.x + o.x, this.pos.y + o.y
						e.tween.ts = store.tick_ts
						e.tween.props[1].keys[1][2].x = -o.x
						e.tween.props[1].keys[1][2].y = -o.y
						e.render.sprites[1].flip_x = this.render.sprites[1].flip_x
						e.owner = this

						queue_insert(store, e)
					end

					if not U.y_animation_wait(this) then
						goto label_40884_0
					end
				else
					SU.delay_attack(store, a, 0.4)
				end
			end

			--2技能：岩浆池
			a = this.timed_attacks.list[2]
			skill = this.hero.skills.magma_eruption
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

						U.animation_start(this, a.animation, flip, store.tick_ts)
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
							e.bullet.level = skill.level

							queue_insert(store, e)

							delay = delay + fts(U.frandom(1, 3))
							ni = ni + n_step
							spi = km.zmod(spi + math.random(1, 2), 3)
							U.y_wait(store, fts(5))
						end

						U.y_animation_wait(this)

						force_idle_ts = true
						a.ts = store.tick_ts

						SU.hero_gain_xp_from_skill(this, skill)

						goto label_40884_0
					end
				end
			end

			--3技能加伤害
			if store.tick_ts - heat_aura_attack.ts > heat_aura_attack.cooldown and he.skills.hellish_infusion.level >= 1 then
				heat_aura_attack.ts = store.tick_ts
				local eagle_range = heat_aura_attack.range
				U.y_animation_play(this, heat_aura_attack.animation, nil, store.tick_ts, 1)
				SU.hero_gain_xp_from_skill(this, he.skills.hellish_infusion)
				local existing_mods = table.filter(store.entities, function(_, e)
					return e.modifier and e.template_name == heat_aura_attack.mod and e.modifier.level >= he.skills.hellish_infusion.level
				end)
				local busy_ids = table.map(existing_mods, function(k, v)
					return v.modifier.target_id
				end)
				local towers = table.filter(store.entities, function(_, e)
					return e.tower and e ~= this.owner and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(heat_aura_attack.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, eagle_range)
				end)

				for _, tower in pairs(towers) do
					local new_mod = E:create_entity(heat_aura_attack.mod)

					new_mod.modifier.level = he.skills.hellish_infusion.level
					new_mod.modifier.target_id = tower.id
					new_mod.modifier.source_id = this.id
					new_mod.modifier.duration = 1
					new_mod.pos = tower.pos

					queue_insert(store, new_mod)
				end
			end


			--近战普攻
			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)
			
			--远程普攻
			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_40884_0::

		coroutine.yield()
	end
end

scripts.soldier_oloch_illusion = {}

function scripts.soldier_oloch_illusion.get_info(this)
	local t = scripts.soldier_barrack.get_info(this)

	t.respawn = nil

	return t
end

scripts.oloch_magma = {}

function scripts.oloch_magma.update(this, store)
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
	if not this.render.sprites[1].hidden then
		U.animation_start(this, "run", nil, store.tick_ts, false, 1)
	end
	this.tween.ts = store.tick_ts

	U.y_wait(store, fts(15))

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, b.damage_radius, b.damage_flags, b.damage_bans)

	if targets then
		for _, target in pairs(targets) do
			local d = E:create_entity("damage")

			d.damage_type = b.damage_type
			d.source_id = this.id
			d.target_id = target.id
			d.value = b.damage_min
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

	

	if b.hit_payload then
		p = E:create_entity(b.hit_payload)
		p.pos.x, p.pos.y = this.pos.x, this.pos.y
		p.render.sprites[1].ts = 0

		queue_insert(store, p)
	end

	if not this.render.sprites[1].hidden then
		U.y_wait(store, fts(10))
	end
	
	queue_remove(store, this)
end

scripts.range_mod_oloch = {}

function scripts.range_mod_oloch.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert range_mod_balloon to entity %s - ", target.id, target.template_name)

		return false
	end

	if target.tower and target.tower.damage_factor then
		target.tower.damage_factor = target.tower.damage_factor * this.range_factor
	end

	--if target.barrack then
	--	target.barrack.rally_range = target.barrack.rally_range * (this.range_factor + m.level * this.range_factor_inc)
	--end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.range_mod_oloch.update(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		this.pos = target.pos
	end

	m.ts = store.tick_ts

	if this.tween then
		this.tween.ts = store.tick_ts
	end

	U.animation_start(this, "run", nil, store.tick_ts, true, 1)

	while store.tick_ts - m.ts < 7 do
		coroutine.yield()
	end

	queue_remove(store, this)
end

function scripts.range_mod_oloch.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and target.tower and target.tower.damage_factor then
		target.tower.damage_factor = target.tower.damage_factor / this.range_factor 
	end

	--if target and target.barrack then
	--	target.barrack.rally_range = target.barrack.rally_range / (this.range_factor + m.level * this.range_factor_inc)
	--end

	return true
end

scripts.hero_oloch_ultimate = {}

function scripts.hero_oloch_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.hero_oloch_ultimate.update(this, store)
	local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, {
		1
	}, true)

	if #nodes < 1 then
		return false
	end

	local pi, spi, ni = unpack(nodes[1])
	local npos = P:node_pos(pi, spi, ni)

	S:queue(this.sound_cast)

	local d = E:create_entity(this.teleport_decal)

	d.pos = V.vclone(npos)
	d.render.sprites[1].ts = store.tick_ts

	queue_insert(store, d)
	U.y_wait(store, fts(5))

	local target, targets = U.find_nearest_enemy(store.entities, npos, 0, this.radius, this.vis_flags, this.vis_bans)

	if not target or not targets or #targets < 1 then
		return true
	end

	local num_targets = math.min(#targets, this.max_targets)

	for i = 1, num_targets do
		local t = targets[i]
		local mod_mark = E:create_entity(this.mod_mark)

		mod_mark.modifier.target_id = t.id
		mod_mark.modifier.source_id = this.id

		queue_insert(store, mod_mark)
		S:queue(this.sound_teleport_in)

		local mod_teleport = E:create_entity(this.mod_teleport)

		mod_teleport.modifier.target_id = t.id
		mod_teleport.modifier.source_id = this.id

		queue_insert(store, mod_teleport)
		S:queue(this.sound_teleport_out, {
			delay = mod_teleport.hold_time
		})
	end

	queue_remove(store, this)
end

scripts.mod_hero_oloch_ultimate_teleport = {}

function scripts.mod_hero_oloch_ultimate_teleport.remove(this, store)
	local target = store.entities[this.modifier.target_id]

	if target then
		target.health.ignore_damage = false

		SU.stun_dec(target)

		--local mod_sleep = E:create_entity(this.end_mod)

		--mod_sleep.modifier.target_id = target.id
		--mod_sleep.modifier.source_id = this.source_id

		--queue_insert(store, mod_sleep)
	end

	return true
end

scripts.hero_jigou = {}

function scripts.hero_jigou.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = math.ceil(ls.melee_damage_min[hl] * this.unit.damage_factor)
		this.melee.attacks[1].damage_max = math.ceil(ls.melee_damage_max[hl] * this.unit.damage_factor)
	end

	s = this.hero.skills.ice_shard
	if initial and s.level > 0 then
		this.ranged.attacks[1].disabled = nil
		e = E:get_template(this.ranged.attacks[1].bullet)
		e.bullet.damage_min = s.damage_min[s.level]
		e.bullet.damage_max = s.damage_max[s.level]
	end

	s = this.hero.skills.frozen_breath
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = nil
		this.timed_attacks.list[2].step = s.count[s.level]
	end

	s = this.hero.skills.earthshake
	if initial and s.level > 0 then
		this.melee.attacks[2].disabled = nil
		this.melee.attacks[2].loops = s.loops[s.level]
	end

	s = this.hero.skills.glacial_form
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = nil
		local m = E:get_template("jigou_healing_mod")
		m.modifier.duration = s.duration[s.level]
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		local a = E:get_template(u.aura)
		a.aura.damage_min = s.damage_config[s.level]
		a.aura.damage_max = s.damage_config[s.level]
		u.cooldown = s.cooldown[s.level]
		local a2 = E:get_template("mod_jigou_ultimate_slow")
		a2.slow.factor = s.slow_factor[s.level]
	end
end

function scripts.hero_jigou.update(this, store, script)
	local h = this.health
	local hero = this.hero
	--local explosive_head_attack = this.timed_attacks.list[1]
	local attack_healing = this.timed_attacks.list[1]
	local chill_attack = this.timed_attacks.list[2]
	local attack, skill
	local consist_count = 0
	local consist_mul = 0
	this.hero.courage_ts = 0

	this.melee.attacks[1].ts = store.tick_ts
	this.melee.attacks[2].ts = store.tick_ts
	this.ranged.attacks[1].ts = store.tick_ts
	--explosive_head_attack.ts = store.tick_ts
	attack_healing.ts = store.tick_ts
	chill_attack.ts = store.tick_ts

	this.health_bar.hidden = true
	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = false
	--U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
			U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop, nil, true)
		end

		-- SU.heroes_visual_learning_upgrade(store, this)
		-- SU.heroes_lone_wolves_upgrade(store, this)
		SU.alliance_merciless_upgrade(store, this)
		SU.alliance_corageous_upgrade(store, this)

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts)
		end

		local skip
		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
			skip = true
		else
			-- # 无条件回血
			if this.health and this.health.hp > 0 and store.tick_ts - this.hero.courage_ts > 1 then
				this.hero.courage_ts = store.tick_ts
				this.health.hp = km.clamp(0, this.health.hp_max, km.round(this.health.hp + math.ceil(this.hero.level * 3)))
			end
			while this.nav_rally.new do
				--if SU.hero_will_teleport(this, this.nav_rally.pos) then
				--	SU_PLD.hide_shadow(this, true)
				--end
				skip = SU.y_hero_new_rally(store, this)
				--SU_PLD.hide_shadow(this, false)
			end
		end

		--4技能
				do
					local a = attack_healing

					if not a.disabled and this.health.hp <= this.health.hp_max * a.lost_health and store.tick_ts - a.ts > a.cooldown then
						local needs_cleanup = false

						U.animation_start(this, a.animation .. "_start", nil, store.tick_ts)
						S:queue(a.sound)

						if SU.y_soldier_wait(store, this, a.hit_time[this.unit.is_captain and 2 or 1]) then
							-- block empty
						else
							a.ts = store.tick_ts
							needs_cleanup = true
							mods = {}

							for _, m in ipairs(a.mods) do
								local mod = E:create_entity(m)

								mod.modifier.target_id = this.id
								mod.modifier.source_id = this.id
								mod.modifier.level = this.hero.skills.glacial_form.level

								queue_insert(store, mod)
								table.insert(mods, mod)
							end

							this.health._damage_factor = this.health.damage_factor
							this.health.damage_factor = 0

							if SU.y_soldier_animation_wait(this) then
								-- block empty
							else
								U.animation_start(this, a.animation .. "_loop", nil, store.tick_ts, true)

								if SU.y_soldier_wait(store, this, a.duration - (store.tick_ts - a.ts)) then
									-- block empty
								else
									U.animation_start(this, a.animation .. "_end", nil, store.tick_ts)

									fx = E:create_entity("fx_jigou_igloo_explosion")
									fx.pos.x = this.pos.x
									fx.pos.y = this.pos.y


									if SU.y_soldier_animation_wait(this) then
										-- block empty
									end
								end
							end
						end
					end
				end
		
		--2技能
			local a = chill_attack
			skill = this.hero.skills.frozen_breath

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

				if not target then
					SU.delay_attack(store, a, 0.13333333333333333)
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
						local start_ts = store.tick_ts

						U.animation_start(this, "frozenBreath", flip, store.tick_ts)
						S:queue(a.sound)
						U.y_wait(store, a.cast_time)

						--SU.y_hero_wait(store, this, a.cast_time)

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local delay = 0
						local n_step = ni < s_ni and -a.step or a.step

						ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + a.nodes_offset or ni)

						for i = 1, skill.count[skill.level] do
							local b = E:create_entity(a.bullet)

							b.pos = P:node_pos(pi, spi, ni)
							b.render.sprites[1].prefix = b.render.sprites[1].prefix .. math.random(1, 3)
							b.render.sprites[1].flip_x = not flip
							b.delay = delay

							queue_insert(store, b)

							delay = delay + 0.05
							ni = ni + n_step
							spi = km.zmod(spi + 1, 3)
						end
					end
				end
			end

		--近战普攻/3技能
		brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)
			
		--远程1技能
		if brk or sta ~= A_NO_TARGET then
			-- block empty
		else
			brk, sta = SU.y_soldier_ranged_attacks(store, this)

			if brk then
					-- block empty
			elseif SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end
		::label_1561_0::

		coroutine.yield()
	end
end

scripts.aura_chill_jigou = {}

function scripts.aura_chill_jigou.update(this, store)
	local last_hit_ts = 0

	U.sprites_hide(this)

	if this.delay then
		U.y_wait(store, this.delay)
	end

	for _, s in pairs(this.render.sprites) do
		s.ts = store.tick_ts
	end

	U.sprites_show(this)

	last_hit_ts = store.tick_ts - this.aura.cycle_time

	while true do
		if this.interrupt then
			last_hit_ts = 1e+99
		end

		if this.aura.duration >= 0 and store.tick_ts - this.aura.ts > this.aura.duration then
			this.tween.disabled = false
			this.tween.ts = store.tick_ts

			return
		end

		if store.tick_ts - last_hit_ts >= this.aura.cycle_time then
			last_hit_ts = store.tick_ts

			local targets = table.filter(store.entities, function(k, v)
				return v.unit and v.vis and v.health and not v.health.dead and not v._last_on_ice and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
			end)

			for i, target in ipairs(targets) do
				if not U.has_modifiers(store, target, this.aura.mod) then
					SU.remove_modifiers_by_type(store, target, MOD_TYPE_SLOW, this.aura.mod)
				end

				local new_mod = E:create_entity(this.aura.mod)

				new_mod.modifier.level = this.aura.level
				new_mod.modifier.target_id = target.id
				new_mod.modifier.source_id = this.id

				queue_insert(store, new_mod)
			end
		end

		coroutine.yield()
	end
end

scripts.controller_jigou_ultimate = {}

function scripts.controller_jigou_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

scripts.controller_jigou_ultimate = {}
function scripts.controller_jigou_ultimate.update(this, store)
	e = E:create_entity(this.aura)
	e.pos = V.v(this.pos.x, this.pos.y) 
	queue_insert(store,e)
	S:queue(this.sound)
end

scripts.aura_jigou_ultimate = {}

function scripts.aura_jigou_ultimate.update(this, store)
	local a = this.aura

	local function do_attack(pos, last_attack)
		local fx = E:create_entity(a.fx)

		fx.pos.x, fx.pos.y = pos.x, pos.y

		if not last_attack then
			fx.render.sprites[2].scale = V.v(0.8, 0.8)
		end

		fx.render.sprites[2].name = fx.render.sprites[2].name .. "_" .. math.random(1, 4)

		fx.render.sprites[2].ts = store.tick_ts
		fx.tween.ts = store.tick_ts

		queue_insert(store, fx)

		local radius = last_attack and a.last_attack_damage_radius or a.damage_radius
		local targets = U.find_enemies_in_range(store.entities, pos, 0, radius, a.vis_flags, a.vis_bans)

		if targets then
			S:queue(this.sound)
			for _, t in pairs(targets) do
				local d = E:create_entity("damage")

				d.value = math.random(a.damage_min, a.damage_max)
				d.damage_type = a.damage_type
				d.source_id = this.id
				d.target_id = t.id

				queue_damage(store, d)

				if (last_attack or math.random() < a.stun_chance) and U.flags_pass(t.vis, this.stun) then
					local m = E:create_entity(this.stun.mod)

					m.modifier.source_id = this.id
					m.modifier.target_id = t.id

					queue_insert(store, m)
				end
			end

			log.paranoid(">>>> aura_10yr_bomb POS:%s,%s  damaged:%s", pos.x, pos.y, table.concat(table.map(targets, function(k, v)
				return v.id
			end), ","))
		end
	end

	local pi, spi, ni, tni, target, origin
	local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes, nil, a.vis_flags, a.vis_bans)

	if not target_info or #target_info < a.min_count then
		log.error("aura_10yr_bomb could not find valid enemies in the hero paths")
	else
		target = target_info[1].enemy
		origin = target_info[1].origin
		pi, spi, ni = unpack(origin)
		tni = target.nav_path.ni

		for i = 1, a.steps do
			local nni = ni + i * a.step_nodes * km.sign(tni - ni)
			local oni = ni + i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end

			local nni = ni - i * a.step_nodes * km.sign(tni - ni)
			local oni = ni - i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end
		end
	end

	queue_remove(store, this)
end

scripts.mod_jigou_slash = {}

function scripts.mod_jigou_slash.update(this, store)
	local m = this.modifier
	local sp = this.render.sprites[1]
	local target = store.entities[m.target_id]

	if not target or not target.pos or target.health.dead then
		queue_remove(store, this)

		return
	end

	sp.hidden = true
	m.ts = store.tick_ts
	this.pos = target.pos

	if target.unit and target.unit.mod_offset then
		sp.offset.x, sp.offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y + 5
		sp.flip_x = not target.render.sprites[1].flip_x
	end

	local delay = (m.target_idx or 0) * this.delay_per_idx

	U.y_wait(store, delay)

	sp.hidden = nil

	U.animation_start(this, this.name, nil, store.tick_ts)
	U.y_wait(store, this.hit_time)

	local d = E:create_entity("damage")

	d.source_id = this.id
	d.target_id = target.id
	d.damage_type = this.damage_type
	d.value = math.random(this.damage_min, this.damage_max)

	queue_damage(store, d)

	local mod = E:create_entity(this.mod)
	mod.modifier.target_id = target.id
	queue_insert(store, mod)
	U.y_animation_wait(this)
	queue_remove(store, this)
end


scripts.hero_tramin_seventh = {}

function scripts.hero_tramin_seventh.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	s = this.hero.skills.long_strike
	if initial and s.level > 0 then
		this.ranged.attacks[1].max_range = this.ranged.attacks[1].max_range * s.rate[s.level]
		this.ranged.attacks[2].max_range = this.ranged.attacks[2].max_range * s.rate[s.level]
		this.timed_attacks.list[2].max_range = this.timed_attacks.list[2].max_range * s.rate[s.level]
		this.timed_attacks.list[1].max_range = this.timed_attacks.list[1].max_range * s.rate[s.level]
	end

	s = this.hero.skills.suppression
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = false
		local e = E:get_template(this.timed_attacks.list[2].aura)
		e.damage_min_config = s.damage_min[s.level]
		e.damage_max_config = s.damage_max[s.level]
		e.damage_extra = s.damage_extra[s.level]
	end

	s = this.hero.skills.grenade
	if initial and s.level > 0 then
		this.ranged.attacks[2].disabled = false
		local e = E:get_template(this.ranged.attacks[2].bullet)
		e.bullet.damage_min = s.damage_config[s.level]
		e.bullet.damage_max = s.damage_config[s.level]
		local e2 = E:get_template(e.bullet.mod)
		e2.slow.factor = s.slow_factor[s.level]
	end

	s = this.hero.skills.shark_mouth_cannon
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		local e = E:get_template(this.timed_attacks.list[1].bullet)
		e.bullet.damage_min = s.damage_min[s.level]
		e.bullet.damage_max = s.damage_max[s.level]
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local e = E:get_template(this.hero.skills.ultimate.controller_name)
		e.cooldown = s.cooldown[s.level]
		local e2 = E:get_template(e.entity)
		e2.ranged.attacks[1].damage_min_config = s.damage_config[s.level]
		e2.ranged.attacks[1].damage_max_config = s.damage_config[s.level]
	end
end

function scripts.hero_tramin_seventh.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta, am, ad
	local missle_attack = this.timed_attacks.list[1]
	missle_attack.ts = 0
	local attack_basic = this.timed_attacks.list[2]
	attack_basic.ts = 0
	this.melee.attacks[1].ts = 0
	this.ranged.attacks[1].ts = 0
	this.ranged.attacks[2].ts = 0


	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

	this.health_bar.hidden = false
	local r = this.nav_rally

	local function find_target(attack, custom_node_pred)
		local target, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, attack.max_range, custom_node_pred and custom_node_pred or attack.node_prediction, attack.vis_flags, attack.vis_bans)

		return target, pred_pos
	end

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while r.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_40245_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			--2技能 扫射
			if not attack_basic.disabled and store.tick_ts - attack_basic.ts > attack_basic.cooldown then
				target, pred_pos = find_target(attack_basic)

				if not target then
					SU.delay_attack(store, attack_basic, fts(10))

					goto label_40245_0
				end

				local last_pred_pos = pred_pos
				local a_name, a_flip, angle_idx
				local start_ts = store.tick_ts

				attack_basic.ts = store.tick_ts
				last_ts = start_ts

				U.animation_start(this, "shoot", nil, store.tick_ts, false, 1)
				local offset = V.vclone(attack_basic.bullet_start_offset[1])

				this.flame_fx = E:create_entity(attack_basic.flame_fx)
				this.flame_fx.render.sprites[1].ts = store.tick_ts
				this.flame_fx.pos.x = this.pos.x-- + offset.x
				this.flame_fx.pos.y = this.pos.y-- + offset.y
				this.flame_fx.render.sprites[1].r = V.angleTo(this.pos.x - last_pred_pos.x, this.pos.y - last_pred_pos.y)
				this.flame_fx.render.sprites[1].scale = v(1, 1)
				this.flame_fx.render.sprites[1].scale.x = attack_basic.flame_fx_scale_x[1]

				queue_insert(store, this.flame_fx)
				U.y_animation_play(this.flame_fx, "in", false, store.tick_ts)

				local flame_id = this.flame_fx.id

				U.animation_start(this.flame_fx, "loop", false, store.tick_ts, true)

				local aura_delay = 0

				U.y_wait(store, aura_delay)

				local nearest = P:nearest_nodes(last_pred_pos.x, last_pred_pos.y)
				local pi, spi, ni = unpack(nearest[1])
				local aura_pos = P:node_pos(pi, 1, ni)
				local aura = E:create_entity(attack_basic.aura)

				aura.pos = V.vclone(aura_pos)
				aura.aura.source_id = this.id
				aura.aura.ts = store.tick_ts
				aura.aura.level = 1
				aura.aura.damage_min = 1
				aura.aura.damage_max = 1

				queue_insert(store, aura)
				--U.y_wait(store, fts(14))
				U.y_wait(store, attack_basic.duration - aura_delay)
				U.y_animation_play(this.flame_fx, "out", false, store.tick_ts)
				queue_remove(store, this.flame_fx)

				U.animation_start(this, "idle", nil, store.tick_ts, false, this.render.sid_dwarf)
			end

			--4技能 导弹
			am = missle_attack
			skill = this.hero.skills.shark_mouth_cannon
			if not am.disabled and store.tick_ts - am.ts > am.cooldown then
				local _, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

				if not targets then
					-- block empty
				else
					local target = targets[1]

					am.ts = store.tick_ts

					local an, af = U.animation_name_facing_point(this, am.animation_pre, target.pos)

					U.animation_start(this, an, af, store.tick_ts, false, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end

					local burst_count = skill.count[skill.level]
					local fire_loops = burst_count / #am.hit_times

					for i = 1, fire_loops do
						local an, af 
						if i == fire_loops then
							an, af = U.animation_name_facing_point(this, am.animation, target.pos)
						else
							an, af = U.animation_name_facing_point(this, am.animation_last, target.pos)
						end

						U.animation_start(this, an, af, store.tick_ts, false, 1)

						for hi, ht in ipairs(am.hit_times) do
							while ht > store.tick_ts - this.render.sprites[1].ts do
								if this.nav_rally.new then
									goto label_40245_1
								end

								coroutine.yield()
							end

							local b = E:create_entity(am.bullet)

							b.pos.x = this.pos.x + (af and -1 or 1) * am.start_offsets[km.zmod(hi, #am.start_offsets)].x
							b.pos.y = this.pos.y + am.start_offsets[hi].y
							b.bullet.level = skill.level
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.v(b.pos.x + (af and -1 or 1) * am.launch_vector.x, b.pos.y + am.launch_vector.y)
							b.bullet.target_id = target.id

							queue_insert(store, b)

							_, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

							if not targets then
								goto label_40245_1
							end

							target = targets[1]
						end

						SU.hero_gain_xp_from_skill(this, skill)

						U.y_wait(store, fts(3))
					end

					::label_40245_1::

					U.animation_start(this, am.animation_post, nil, store.tick_ts, false, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end

					am.ts = store.tick_ts

					goto label_40245_0
				end
			end

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_40245_0::

		coroutine.yield()
	end
end

scripts.aura_hero_tramin_seventh = {}

function scripts.aura_hero_tramin_seventh.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0

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

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_831_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local tower = store.entities[this.aura.source_id]

			if not tower then
				goto label_831_0
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

				local d = E:create_entity("damage")

				d.source_id = this.id
				d.target_id = target.id

				local dmin, dmax = this.damage_min_config, this.damage_min_config

				local damage_extra = target.health.hp_max * this.damage_extra

				if target and bor(target.vis.flags, bor(F_BOSS, F_MINIBOSS)) then
					damage_extra = math.min(damage_extra, 200)
				end

				d.value = math.random(dmin+damage_extra, dmax+damage_extra)

				local tower = store.entities[this.aura.source_id]

				d.damage_type = this.aura.damage_type
				d.track_damage = this.aura.track_damage
				d.xp_dest_id = this.aura.xp_dest_id
				d.xp_gain_factor = this.aura.xp_gain_factor

				queue_damage(store, d)
			end
		end

		::label_831_0::

		coroutine.yield()
	end

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end

scripts.hero_tramin = {}

function scripts.hero_tramin.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	s = this.hero.skills.bombots
	if initial and s.level > 0 then
		this.ranged.attacks[2].disabled = false
		local e = E:get_template("aura_bomb_tramin_skill1")
		e.aura.damage_max = s.damage_max[s.level]
		e.aura.damage_min = s.damage_min[s.level]
		local e = E:get_template("bullet_tramin_robot")
		e.bullet.damage_min = s.damage_min[s.level]
		e.bullet.damage_max = s.damage_max[s.level]
	end

	s = this.hero.skills.nitro_rush
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = false
	end

	s = this.hero.skills.flashbang
	if initial and s.level > 0 then
		this.ranged.attacks[3].disabled = false
		local e = E:get_template("mod_tramin_stun")
		e.modifier.duration = s.duration[s.level]
	end

	s = this.hero.skills.rocket_barrage
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		local e = E:get_template(this.timed_attacks.list[1].bullet)
		e.bullet.damage_min = s.damage_max[s.level]
		e.bullet.damage_min = s.damage_min[s.level]
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local e = E:get_template("aura_box_tramin")
		e.spawner.count = s.entity_count[s.level]
		local e = E:get_template("aura_bomb_tramin_ultimate")
		e.aura.damage_min = s.damage_config[s.level]
		e.aura.damage_max = s.damage_config[s.level]
	end
end

function scripts.hero_tramin.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta, am, ad
	local missle_attack = this.timed_attacks.list[1]
	local drink_attack = this.timed_attacks.list[2]
	local drink_stage = 0
	missle_attack.ts = 0
	drink_attack.ts = 0
	this.melee.attacks[1].ts = 0
	this.ranged.attacks[1].ts = 0
	this.ranged.attacks[2].ts = 0
	this.ranged.attacks[3].ts = 0


	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

	this.health_bar.hidden = false
	local r = this.nav_rally

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end
		if drink_stage == 0 then
			this.ranged.attacks[1].cooldown = 2
		else
			this.ranged.attacks[1].cooldown = 0.5
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			--[[
			while r.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_40244_0
				end
			end
			]]
			if r.new then
				r.new = false

				U.unblock_target(store, this)
				U.set_destination(this, r.pos)

				if r.delay_max then
					U.animation_start(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop)

					local index = this.soldier.tower_soldier_idx or 0
					local tower = store.entities[this.soldier.tower_id]
					local total = tower and tower.barrack.max_soldiers or 1

					if SU.y_soldier_wait(store, this, index / total * r.delay_max) then
						goto label_40244_0
					end
				end

				local offset = V.v(r.pos.x - r.center.x, r.pos.y - r.center.y)
				local old_center = V.v(this.pos.x - offset.x, this.pos.y - offset.y)

				if V.dist2(r.center.x, r.center.y, old_center.x, old_center.y) < this.max_dist_walk * this.max_dist_walk or first_walk then
					local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)

					U.animation_start(this, an, af, store.tick_ts, -1)

					while not this.motion.arrived do
						if this.health.dead or this.unit.is_stunned then
							out = true

							break
						end

						if r.new then
							out = false

							break
						end

						--if break_fn() then
						--	out = false

						--	break
						--end

						if r._first_time then
							r._first_time = false

							local target = U.find_foremost_enemy(store.entities, r.center, 0, this.melee.range, false, F_BLOCK, bit.bor(F_CLIFF), function(e)
								return (not e.enemy.max_blockers or #e.enemy.blockers == 0) and band(GR:cell_type(e.pos.x, e.pos.y), TERRAIN_NOWALK) == 0 and (not this.melee.fn_can_pick or this.melee.fn_can_pick(this, e))
							end)

							if target then
								out = false

								break
							end
						end

						U.walk(this, store.tick_length)
						coroutine.yield()

						this.motion.speed.x, this.motion.speed.y = 0, 0
					end
				else
					S:queue(this.sound_jump)

					local an, af = U.animation_name_facing_point(this, "toJetpack2", this.motion.dest)

					U.y_animation_play(this, "toJetpack2", not af, store.tick_ts, 1)

					--local d = E:create_entity(this._jump_explosion)

					--d.pos = V.v(this.pos.x, this.pos.y)
					--d.render.sprites[1].ts = store.tick_ts

					--queue_insert(store, d)

					local prefix = this.render.sprites[1].prefix

					--this.render.sprites[1].prefix = "name"
					this.render.sprites[1].name = this._jump_asset_name
					this.render.sprites[1].animated = false

					local g = -2 / (fts(1) * fts(1))
					local flight_time = 1
					local speed = SU.initial_parabola_speed(this.pos, this.nav_rally.pos, flight_time, g)
					local from = V.vclone(this.pos)
					local flying = true
					local ts = store.tick_ts
					local fpos = V.vclone(this.nav_rally.pos)
					local rotation_dir = this.nav_rally.pos.x - this.pos.x > 0 and -1 or 1
					local dist = V.dist(fpos.x, fpos.y, from.x, from.y)
					local dir = V.v((fpos.x - from.x) / dist, (fpos.y - from.y) / dist)

					this.motion.speed.x, this.motion.speed.y = 0, 0

					local shadow = this.render.sprites[2]

					while flying do
						coroutine.yield()

						this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - ts, from, speed, g)
						this.render.sprites[1].r = store.tick_ts * 0 * rotation_dir

						local dis_floor = (this.pos.x - from.x) / dir.x
						local height = this.pos.y - (dir.y * dis_floor + from.y)

						this.render.sprites[1].sort_y_offset = -height
						shadow.hidden = false
						shadow.offset.y = -height

						local s = km.clamp(0.5, 1, 40 / height)

						shadow.scale.x = s
						shadow.scale.y = s

						if flight_time - 0.05 < store.tick_ts - ts then
							shadow.hidden = true
							this.pos.x = fpos.x
							this.pos.y = fpos.y
							flying = false
							this.render.sprites[1].sort_y_offset = 0
						end
					end

					S:queue(this.sound_land)
					this.render.sprites[1].r = 0
					this.render.sprites[1].prefix = prefix
					this.render.sprites[1].animated = true
					shadow.hidden = false
					shadow.offset.y = 16
					U.y_animation_play(this, "outJetpack", nil, store.tick_ts, 1)
					U.animation_start(this, "idle", nil, store.tick_ts, 1)
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			ad = drink_attack
			skill = this.hero.skills.nitro_rush
			if not ad.disabled and store.tick_ts - ad.ts > ad.cooldown then
				local _, targets = U.find_foremost_enemy(store.entities, this.pos, ad.min_range, ad.max_range, false, ad.vis_flags, ad.vis_bans)

				if not targets then
					-- block empty
				else
					local target = targets[1]
					S:queue(ad.sound)
					local an, af = U.animation_name_facing_point(this, ad.animation, target.pos)

					U.animation_start(this, an, af, store.tick_ts, false, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end
					drink_stage = 1
					ad.ts = store.tick_ts
				end

			end
			if drink_stage == 1 and skill.level > 0 and store.tick_ts - ad.ts >= skill.duration[skill.level] then
				drink_stage = 0
			end

			--1技能 导弹
			am = missle_attack
			skill = this.hero.skills.rocket_barrage
			if not am.disabled and store.tick_ts - am.ts > am.cooldown then
				local _, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

				if not targets then
					-- block empty
				else
					local target = targets[1]

					am.ts = store.tick_ts

					local an, af = U.animation_name_facing_point(this, am.animation_pre, target.pos)

					U.animation_start(this, an, af, store.tick_ts, false, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end

					local burst_count = skill.count[skill.level]
					local fire_loops = burst_count / #am.hit_times

					for i = 1, fire_loops do
						local an, af 
						if i == fire_loops then
							an, af = U.animation_name_facing_point(this, am.animation, target.pos)
						else
							an, af = U.animation_name_facing_point(this, am.animation_last, target.pos)
						end

						U.animation_start(this, an, af, store.tick_ts, false, 1)

						for hi, ht in ipairs(am.hit_times) do
							while ht > store.tick_ts - this.render.sprites[1].ts do
								if this.nav_rally.new then
									goto label_40244_1
								end

								coroutine.yield()
							end

							local b = E:create_entity(am.bullet)

							b.pos.x = this.pos.x + (af and -1 or 1) * am.start_offsets[km.zmod(hi, #am.start_offsets)].x
							b.pos.y = this.pos.y + am.start_offsets[hi].y
							b.bullet.level = skill.level
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.v(b.pos.x + (af and -1 or 1) * am.launch_vector.x, b.pos.y + am.launch_vector.y)
							b.bullet.target_id = target.id

							queue_insert(store, b)

							_, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

							if not targets then
								goto label_40244_1
							end

							target = targets[1]
						end

						SU.hero_gain_xp_from_skill(this, skill)

						U.y_wait(store, fts(3))
					end

					::label_40244_1::

					U.animation_start(this, am.animation_post, nil, store.tick_ts, false, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end

					am.ts = store.tick_ts

					goto label_40244_0
				end
			end

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_40244_0::

		coroutine.yield()
	end
end


scripts.hero_tramin_ultimate = {}

function scripts.hero_tramin_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.hero_tramin_ultimate.update(this, store)
	local target_info = U.find_enemies_in_paths(store.entities, this.pos, this.range_nodes_min, this.range_nodes_max, this.max_path_dist, this.vis_flags, this.vis_bans, true, function(e)
		return not U.flag_has(P:path_terrain_props(e.nav_path.pi), TERRAIN_FAERIE)
	end)

	local target, origin

	if not target_info then
		--SU.delay_attack(store, a, 0.16666666666666666)
		local nearest_nodes = P:nearest_nodes(this.pos.x, this.pos.y)
		origin = nearest_nodes[1]
	else
		target = target_info[1].enemy
		origin = target_info[1].origin
	end
		local start_ts = store.tick_ts
		local bullet_to_ni = origin[3] - math.random(8, 13)

		bullet_to_ni = km.clamp(5, P:get_end_node(origin[1]), bullet_to_ni)

		local bullet_to = P:node_pos(origin[1], 1, bullet_to_ni)
		local flip = bullet_to.x < this.pos.x

		S:queue(this.sound)
		--U.animation_start(this, a.animation, flip, store.tick_ts)

		--if SU.y_hero_wait(store, this, a.shoot_time) then
		--	goto label_199_0
		--end

		--SU.hero_gain_xp_from_skill(this, skill)

		local e = E:create_entity(this.payload)

		e.spawner.pi = origin[1]
		e.spawner.ni = bullet_to_ni
		e.pos = bullet_to

		local b = E:create_entity(this.bullet)

		b.pos.x = this.pos.x + (flip and -1 or 1) * this.bullet_start_offset.x
		b.pos.y = this.pos.y + this.bullet_start_offset.y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.vclone(e.pos)
		b.bullet.hit_payload = e
		queue_insert(store, b)
		--SU.y_hero_animation_wait(this)
end

scripts.aura_box_tramin = {}

function scripts.aura_box_tramin.update(this, store)
	local sp = this.spawner

	this.render.sprites[1].ts = store.tick_ts

	SU.insert_sprite(store, "decal_rock_crater", this.pos)
	U.y_wait(store, sp.spawn_time)

	this.render.sprites[1].z = Z_DECALS

	S:queue(sp.sound)

	for i = 1, sp.count do
		local e = E:create_entity(sp.entity)

		e.pos.x, e.pos.y = this.pos.x, this.pos.y
		e.nav_path.pi = sp.pi
		e.nav_path.spi = km.zmod(i, sp.count)
		e.nav_path.ni = sp.ni

		queue_insert(store, e)
	end

	SU.insert_sprite(store, "fx_box_wilbur_smoke_b", V.v(this.pos.x + 33 - 40, this.pos.y + 32 - 20))
	SU.insert_sprite(store, "fx_box_wilbur_smoke_a", V.v(this.pos.x + 60 - 40, this.pos.y + 32 - 22))
	SU.insert_sprite(store, "fx_box_wilbur_smoke_a", V.v(this.pos.x + 10 - 40, this.pos.y + 32 - 22), true)
	U.y_wait(store, fts(10))
	U.y_ease_key(store, this.render.sprites[1], "alpha", 255, 0, 1)
	queue_remove(store, this)
end

scripts.hero_margosa = {}

function scripts.hero_margosa.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	s = this.hero.skills.bat_familiar
	if initial and s.level > 0 then
		local t = E:get_template(this.crow_entity)
		t.custom_attack.damage_min =  s.damage_min_config[s.level]
		t.custom_attack.damage_max = s.damage_max_config[s.level]
	end

	s = this.hero.skills.myst_form
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		local e = E:get_template("mod_dmg_fog_hero_margosa")
		e.dps.damage_min = s.damage_config[s.level]
		e.dps.damage_max = s.damage_config[s.level]
		local e2 = E:get_template("mod_err_fog_hero_margosa")
		e2.damage_reduction = s.damage_deduction[s.level]
		e2.modifier.level = s.level
	end

	s = this.hero.skills.dark_call
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = false
		local e = E:get_template("mod_hero_margosa_stun")
		e.modifier.duration = s.duration[s.level]
	end

	s = this.hero.skills.vampiric_touch
	if initial and s.level > 0 then
		local m = E:get_template("mod_life_drain_drow_margosa")
		m.heal_factor = s.track_rate[s.level]
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		--empty block
	end
end

function scripts.hero_margosa.update(this, store)
	local h = this.health
	local he = this.hero
	local am = this.timed_attacks.list[1]
	local ad = this.timed_attacks.list[2]
	local a1 = this.melee.attacks[1]
	local a, skill, brk, sta
	local hl = this.hero.level
	local ls = this.hero.level_stats
	am.ts = 0
	a1.ts = 0
	ad.ts = 0

	local function go_buffed()
		--this.sound_events.change_rally_point = this.sound_events.change_rally_point_buffed

		s = this.hero.skills.ultimate
		this.health.hp_max = s.hp_max_config
		this.melee.attacks[1].damage_min = s.damage_min_config[s.level]
		this.melee.attacks[1].damage_max = s.damage_max_config[s.level]
		this.melee.attacks[1].cooldown = 0.8
		this.track_damage.mod = "mod_life_drain_drow_margosa_ultimate"
		this.track_damage.rate = 0.8
		this.health.hp = this.health.hp_max

		U.y_animation_play(this, "toBeast", nil, store.tick_ts, 1)
		U.y_animation_wait(this, 1)

		this.render.sprites[1].prefix = "hero_lady_margosa_beast"
		--ba.ts = store.tick_ts
		this.is_buffed = true
		this.health_bar.offset = this.health_bar.offset_buffed
		this.motion.max_speed = this.motion.max_speed_buffed
		this._attack_1_disabled = this.timed_attacks.list[1].disabled
		this._attack_2_disabled = this.timed_attacks.list[2].disabled
		this.timed_attacks.list[1].disabled = true
		this.timed_attacks.list[2].disabled = true
	end

	local function go_normal()
		--this.sound_events.change_rally_point = this.sound_events.change_rally_point_normal
		this.health.hp_max = this.hero.level_stats.hp_max[hl]
		if this.health.hp_max < this.health.hp then
			this.health.hp = this.health.hp_max
		end
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
		this.track_damage.mod = "mod_life_drain_drow_margosa_ultimate"
		this.track_damage.rate = this.hero.skills.vampiric_touch.track_rate[this.hero.skills.vampiric_touch.level]
		this.melee.attacks[1].cooldown = 1.2
		this.is_buffed = false

		U.y_animation_play(this, "toMargosa", nil, store.tick_ts, 1)
		U.y_animation_wait(this, 1)

		this.render.sprites[1].prefix = "hero_lady_margosa"
		this.health_bar.offset = this.health_bar.offset_normal
		this.motion.max_speed = this.motion.max_speed_normal
		this.timed_attacks.list[1].disabled = this._attack_1_disabled
		this.timed_attacks.list[2].disabled = this._attack_2_disabled
		
		--ba.ts = store.tick_ts
	end

	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	if this.hero.skills.bat_familiar.level > 0 then
		local e = E:create_entity(this.crow_entity)

		e.pos = V.vclone(this.pos)
		e.bombs_pos = V.v(this.pos.x + 12, this.pos.y + 6)
		e.idle_pos = V.v(this.pos.x + 20, this.pos.y + 6)

		queue_insert(store, e)

		e.owner = this

		e.owner = this
		e.owner_idx = 1

		queue_insert(store, e)
	end

	while true do
		if h.dead then
			if this.is_buffed then
				go_normal()
			end

			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				local r = this.nav_rally
				local tw = this.treewalk
				local force_treewalk = false

				for _, p in pairs(this.nav_grid.waypoints) do
					if GR:cell_is(p.x, p.y, bor(TERRAIN_WATER, TERRAIN_SHALLOW, TERRAIN_NOWALK)) then
						force_treewalk = true
						break
					end
				end

				if (force_treewalk or V.dist(this.pos.x, this.pos.y, r.pos.x, r.pos.y) > tw.min_distance) and not this.is_buffed then
					r.new = false

					U.unblock_target(store, this)

					local vis_bans = this.vis.bans

					this.vis.bans = F_ALL
					this.health.immune_to = F_ALL

					local original_speed = this.motion.max_speed

					this.motion.max_speed = this.motion.max_speed + tw.extra_speed
					this.unit.marker_hidden = true
					this.health_bar.hidden = true

					S:queue(this.sound_events.change_rally_point)
					U.y_animation_play(this, tw.animations[1], nil, store.tick_ts)
					U.y_animation_wait(this, 1)

					::label_45283_0::

					local dest = r.pos
					local n = this.nav_grid

					while not V.veq(this.pos, dest) do
						local w = table.remove(n.waypoints, 1) or dest

						U.set_destination(this, w)

						local an, af = U.animation_name_facing_point(this, tw.animations[2], this.motion.dest)

						U.animation_start(this, an, af, store.tick_ts, true)

						while not this.motion.arrived do
							if r.new then
								r.new = false

								goto label_45283_0
							end

							U.walk(this, store.tick_length)
							coroutine.yield()

							this.motion.speed.x, this.motion.speed.y = 0, 0
						end
					end
					SU.hide_modifiers(store, this, true)
					U.y_animation_play(this, tw.animations[3], nil, store.tick_ts)
					U.y_animation_wait(this, 1)
					SU.show_modifiers(store, this, true)

					this.motion.max_speed = original_speed
					this.vis.bans = vis_bans
					this.health.immune_to = 0
					this.unit.marker_hidden = nil
					this.health_bar.hidden = nil
				elseif SU.y_hero_new_rally(store, this) then
					goto label_4590_1
				end
			end

			if SU.hero_level_up(store, this) and not this.is_buffed then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			--2技能 雾
			skill = this.hero.skills.vampiric_touch
			if not am.disabled and store.tick_ts - am.ts > am.cooldown then
				local _, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

				if not targets then
					-- block empty
				else
					local target = targets[1]

					am.ts = store.tick_ts
					
					while not U.animation_finished(this) do
						coroutine.yield()
					end
					
					U.animation_start(this, am.animation, nil, store.tick_ts, false, 1)
					S:queue(am.sound)
		
					local points = {}
					local inner_fx_radius = 35

					for i = 1, 6 do
						local r = inner_fx_radius

						local p = {}

						p.pos = U.point_on_ellipse(this.pos, r, 2 * math.pi * (6-i) / 6)
						p.terrain = GR:cell_type(p.pos.x, p.pos.y)

						if GR:cell_is(p.pos.x, p.pos.y, TERRAIN_WATER) or P:valid_node_nearby(p.pos.x, p.pos.y, 1) and not GR:cell_is(p.pos.x, p.pos.y, TERRAIN_CLIFF) then
							table.insert(points, p)
						end
					end

					local ts_e = store.tick_ts

					for _, p in pairs(points) do

						--local smoke = E:create_entity("decal_rotten_forest_smoke")
						local e = E:create_entity(am.entity)

						e.pos = V.vclone(p.pos)
						e.aura.source_id = this.id
						e.aura.ts = ts_e
						queue_insert(store, e)
					end


					while not U.animation_finished(this) do
						coroutine.yield()
					end

					SU.hero_gain_xp_from_skill(this, skill)

					am.ts = store.tick_ts
				end
			end

			--3技能 传送
			skill = this.hero.skills.myst_form
			if not ad.disabled and store.tick_ts - ad.ts > ad.cooldown then
				local target = U.find_foremost_enemy(store.entities, tpos(this), 0, 999999, nil, ad.vis_flags, ad.vis_bans)
				if not target then
					--empty block
				else
					local nearest = P:nearest_nodes(this.pos.x, this.pos.y)
					local pi, spi, ni
					if nearest and nearest[1] then
						pi, spi, ni = unpack(nearest[1])
					end
					if pi and P:nodes_to_goal(pi, spi, ni) - P:nodes_to_goal(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni) > 15 then
						ad.ts = store.tick_ts
						local offset = P:nodes_to_goal(pi, spi, ni) - P:nodes_to_goal(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni)

						print(P:nodes_to_goal(pi, spi, ni), P:nodes_to_goal(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni), offset)

						local mod_teleport = E:create_entity(ad.mod_teleport)

						mod_teleport.nodes_offset = -offset
						mod_teleport.modifier.target_id = target.id
						mod_teleport.modifier.source_id = this.id

						queue_insert(store, mod_teleport)
					end
					--[[
					local target = targets[1].enemy

					for _, t in pairs(targets) do
						print(P:nodes_to_goal(t.enemy.nav_path.pi, t.enemy.nav_path.spi, t.enemy.nav_path.ni))
						if t and t.health and t.health.hp > 0  and P:nodes_to_goal(target.enemy.nav_path.pi, target.enemy.nav_path.spi, target.enemy.nav_path.ni) > P:nodes_to_goal(t.enemy.nav_path.pi, t.enemy.nav_path.spi, t.enemy.nav_path.ni) then
							target = t.enemy
						end
					end

					local nearest = P:nearest_nodes(this.pos.x, this.pos.y)
					local pi, spi, ni
					if nearest and nearest[1] then
						pi, spi, ni = unpack(nearest[1])
					end

					if target and not target.dead and pi and (P:nodes_to_goal(pi, spi, ni) - P:nodes_to_goal(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni) > 15) then
						ad.ts = store.tick_ts
						local offset = P:nodes_to_goal(pi, spi, ni) - P:nodes_to_goal(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni)

						print(P:nodes_to_goal(pi, spi, ni), P:nodes_to_goal(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni), offset)

						local mod_teleport = E:create_entity(ad.mod_teleport)

						mod_teleport.nodes_offset = -offset
						mod_teleport.modifier.target_id = target.id
						mod_teleport.modifier.source_id = this.id

						queue_insert(store, mod_teleport)
					end
					]]
				end
			end

			skill = this.hero.skills.ultimate
			if not this.is_buffed and store.tick_ts - skill.ts >= skill.cooldown[skill.level] and this.template_name == "hero_margosa_2" then
				local targets = U.find_enemies_in_range(store.entities, this.pos, 0, skill.range, skill.vis_flags, skill.vis_bans)

				if targets and #targets >= skill.min_count then
					--SU.hero_gain_xp_from_skill(this, skill)
					skill.ts = store.tick_ts
					go_buffed()
				end
			end

			if not this.is_buffed and this.fn_go_buff == true then
				this.fn_go_buff = false
				skill.ts = store.tick_ts
				go_buffed()
			elseif this.is_buffed and store.tick_ts - skill.ts >= skill.duration[skill.level] then
				go_normal()
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk == false and sta == A_DONE and this.hero.skills.vampiric_touch.level > 0 then
				random = math.random(this.melee.attacks[1].damage_min, this.melee.attacks[1].damage_max)
				this.health.hp = math.min(math.floor(random) * this.hero.skills.vampiric_touch.track_rate[this.hero.skills.vampiric_touch.level] + this.health.hp, this.health.hp_max)
			end

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			elseif SU.soldier_go_back_step(store, this) then
				-- block empty 
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::label_4590_1::

		coroutine.yield()
	end
end

scripts.mod_hero_margosa_teleport = {}
function scripts.mod_hero_margosa_teleport.remove(this, store)
	local target = store.entities[this.modifier.target_id]

	if target then
		target.health.ignore_damage = false

		SU.stun_dec(target)

		local mod_stun = E:create_entity(this.end_mod)

		mod_stun.modifier.target_id = target.id
		mod_stun.modifier.source_id = this.source_id

		queue_insert(store, mod_stun)
	end

	return true
end

scripts.controller_hero_margosa_ultimate = {}
function scripts.controller_hero_margosa_ultimate.can_fire_fn(this, x, y)
	local margosa 
	local heroes = table.filter(store.entities, function(_, e)
						return e.hero ~= nil
					end)
	for _, t in pairs(heroes) do 
		if t.template_name == "hero_margosa" then
			margosa = t
			break
		end
	end
	return margosa and not margosa.health.dead and margosa.health.hp > 0
end

scripts.controller_hero_margosa_ultimate = {}
function scripts.controller_hero_margosa_ultimate.update(this, store)
	local margosa 
	local heroes = table.filter(store.entities, function(_, e)
						return e.hero ~= nil
					end)
	for _, t in pairs(heroes) do 
		if t.template_name == "hero_margosa" then
			margosa = t
			break
		end
	end
	margosa.fn_go_buff = true
	S:queue(this.sound)
end

scripts.shadow_bat = {}

function scripts.shadow_bat.update(this, store)
	local sp = this.render.sprites[1]
	local fm = this.force_motion
	local ca = this.custom_attack
	local dest = V.vclone(this.idle_pos)
	local mytarget = nil
	local npos
	local locked = nil
	local target_id
	this.dead = false

	U.y_animation_play(this, "summon", nil, store.tick_ts, 1)
	U.y_animation_wait(this, 1)

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
		this.idle_pos = V.vclone(this.owner.pos)
		if (this.owner.health.dead or this.owner.health.hp == 0) and this.dead == false then
			U.y_animation_play(this, "death", nil, store.tick_ts, 1)
			U.y_animation_wait(this, 1)
			this.dead = true
		end

		if not this.owner.health.dead and this.dead == true then
			U.y_animation_play(this, "summon", nil, store.tick_ts, 1)
			U.y_animation_wait(this, 1)
			this.dead = false
		end

		if not this.dead then
			if store.tick_ts - ca.ts > ca.cooldown then
				local target = mytarget or U.find_nearest_enemy(store.entities, tpos(this.owner), 0, ca.range, ca.vis_flags, ca.vis_bans)

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
					U.animation_start(this, "attack", nil, store.tick_ts, true)
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
			if (V.dist(dest.x, dest.y, this.idle_pos.x, this.idle_pos.y) < ca.range) then
			this.pos = V.vclone(mytarget.pos)
			end
			end

			::label_161_0::
			
			if (not mytarget or mytarget.health.dead) or (V.dist(dest.x, dest.y, this.idle_pos.x, this.idle_pos.y) > ca.range) then
			mytarget = nil
			npos = nil
			locked = nil
			this.pos.x, this.pos.y = this.pos.x, this.pos.y
			if (V.dist(dest.x, dest.y, this.idle_pos.x, this.idle_pos.y) > 43 or V.dist(dest.x, dest.y, this.pos.x, this.pos.y) < 10) then
				U.animation_start(this, "idle", nil, store.tick_ts, true)
				dest = U.point_on_ellipse(this.idle_pos, 30, U.frandom(0, 2 * math.pi))
			end
			force_move_step(dest, this.flight_speed_idle, this.ramp_dist_idle)
			end

		end
		
		coroutine.yield()
	end
end

scripts.hero_mortemis = {}

function scripts.hero_mortemis.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	s = this.hero.skills.call_haunted
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		local e = E:get_template(this.timed_attacks.list[1].entity)
		e.modifier.duration = s.duration[s.level]
	end

	s = this.hero.skills.deadly_fumes
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = false
		local e = E:get_template("mod_mortemis_magma")
		e.dps.damage_min = s.damage_config[s.level]
		e.dps.damage_max = s.damage_config[s.level]
	end

	s = this.hero.skills.grim_presence
	if initial and s.level > 0 then
		this.render.sprites[2].name = "hero_mortemis_aura"
		this.render.sprites[2].offset = v(0, 0)
		this.auras.list[1].disabled = false
		this.auras.list[2].disabled = false
		local e1 = E:get_template(this.auras.list[1].mod)
		e1.armor_buff.max_factor = s.armor_reduction[s.level]
		local e2 = E:get_template(this.auras.list[2].mod)
		e2.armor_buff.max_factor = s.armor_reduction[s.level]
	end

	s = this.hero.skills.undead_servitude
	if initial and s.level > 0 then
		this.auras.list[3].disabled = false
		local e3 = E:get_template(this.auras.list[3].mod)
		e3.max_skeletons_tower = s.max_skeletons_tower[s.level]
		e3.level = s.level
	end

	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local e = E:get_template("hero_mortemis_spawner_seed")
		e.bullet.hit_payload = s.entity[s.level]
		local e2 = E:get_template("hero_mortemis_ultimate")
		e2.cooldown = s.cooldown[s.level]
	end
end

function scripts.hero_mortemis.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta
	--local unbreakable_attack = this.timed_attacks.list[1]
	--unbreakable_attack.ts = 0
	this.timed_attacks.list[1].ts = 0
	this.timed_attacks.list[2].ts = 0
	this.auras.list[1].ts = 0
	this.auras.list[2].ts = 0
	this.melee.attacks[1].ts = 0
	this.ranged.attacks[1].ts = 0

	if this.auras.list[3].disabled == false then
		local e3 = E:create_entity(this.auras.list[3].mod)
		e3.aura.source_id = this.id
		queue_insert(store, e3)
	end

	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	while true do
		if h.dead then
			local ds = this.death_spawns
			for i = 1,ds.quantity do
				e = E:create_entity(ds.name)
				e.pos = V.v(this.pos.x, this.pos.y) 
				e.bullet.from = V.v(this.pos.x, this.pos.y)
				e.bullet.to = V.v(this.pos.x +ds.pos_list[i][1] , this.pos.y+ds.pos_list[i][2]) 
				queue_insert(store, e)
			end
			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					local mods = table.filter(store.entities, function(_, e)
						return e.modifier and e.modifier.source_id == this.id
					end)

					for _, m in pairs(mods) do
						queue_remove(store, m)
					end
					goto label_2791_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			--1技能 恐吓
		local a = this.timed_attacks.list[1]
		local skill = this.hero.skills.call_haunted
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local start_ts, bdy, bdt, au
			local fired_aura = false
			local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not targets then
				SU.delay_attack(store, a, 0.2)
			else
				local cnt = 0
				a.ts = store.tick_ts
				U.animation_start(this, a.animation, nil, store.tick_ts, false)
				S:queue(a.sound)
				U.y_wait(store, fts(25))
				for _, e in pairs(targets) do
					cnt = cnt + 1
					local mod = E:create_entity(a.entity)
					mod.modifier.target_id = e.id
					mod.modifier.source_id = this.id
					mod.modifier.level = skill.level
					queue_insert(store, mod)
					if cnt == a.max_target then
						break
					end
				end
				U.y_animation_wait(this, 1)
				U.y_animation_play(this, "idle", nil, store.tick_ts, 1)

				SU.hero_gain_xp_from_skill(this, skill)

				goto label_2791_0
			end

		end

			--2技能：毒池
			a = this.timed_attacks.list[2]
			skill = this.hero.skills.deadly_fumes

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
						S:queue(a.sound)

						U.animation_start(this, a.animation, flip, store.tick_ts)
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
							e.bullet.level = skill.level

							queue_insert(store, e)

							delay = delay + fts(U.frandom(1, 3))
							ni = ni + n_step
							spi = km.zmod(spi + math.random(1, 2), 3)
							U.y_wait(store, fts(5))
						end

						U.y_animation_wait(this, 1)

						force_idle_ts = true
						a.ts = store.tick_ts

						SU.hero_gain_xp_from_skill(this, skill)

						goto label_2791_0
					end
				end
			end

			--3技能：削甲
			local a = this.auras.list[1]
			local a2 = this.auras.list[2]
			if not a.disabled and store.tick_ts - a.ts > a.cooldown and he.skills.grim_presence.level >= 1 then
				a.ts = store.tick_ts
				local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a.vis_bans)

				if targets then
					for _, t in pairs(targets) do
						local new_mod = E:create_entity(a.mod)

						new_mod.modifier.level = he.skills.grim_presence.level
						new_mod.modifier.target_id = t.id
						new_mod.modifier.source_id = this.id
						new_mod.modifier.duration = 120
						--new_mod.pos = t.pos

						queue_insert(store, new_mod)

						local new_mod = E:create_entity(a2.mod)

						new_mod.modifier.level = he.skills.grim_presence.level
						new_mod.modifier.target_id = t.id
						new_mod.modifier.source_id = this.id
						new_mod.modifier.duration = 120
						--new_mod.pos = t.pos

						queue_insert(store, new_mod)
					end
				else
					U.y_wait(store, fts(5))
				end
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					-- block empty
					SU.hero_gain_xp_from_skill(this, this.hero.skills.deadly_fumes)
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_2791_0::

		coroutine.yield()
	end
end

scripts.bolt_mortemis = {}

function scripts.bolt_mortemis.update(this, store, script)
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
		d.xp_dest_id = b.source_id
		local damage_value = d.value

		


		local u = UP:get_upgrade("mage_spell_of_penetration")

		queue_damage(store, d)

		local source_entity = store.entities[b.source_id]
		if source_entity.track_damage and not source_entity.health.dead then
			source_entity.health.hp = math.min(source_entity.health.hp_max, source_entity.health.hp + damage_value * source_entity.track_damage.heal_factor)
		end

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

scripts.mortemis_zombie_aura = {}

function scripts.mortemis_zombie_aura.update(this, store, script)
	local last_ts = store.tick_ts
	local tower_skeletons_count = 0
	local cg = store.count_groups[this.count_group_type]

	while true do
		local source = store.entities[this.aura.source_id]
		this.pos.x, this.pos.y = source.pos.x, source.pos.y

		if not source then
			queue_remove(store, this)

			return
		end

		if store.tick_ts - last_ts >= this.aura.cycle_time then
			last_ts = store.tick_ts
			tower_skeletons_count = 0

			for _, e in pairs(store.entities) do
				if e and e.health and not e.health.dead and e.soldier and e.soldier.tower_id == source.id and e.template_name ~= "soldier_death_rider" then
					tower_skeletons_count = tower_skeletons_count + 1
				end
			end

			local max_spawns = math.min(this.max_skeletons_tower - tower_skeletons_count, this.count_group_max - (cg[this.count_group_name] or 0))

			if max_spawns < 1 then
				-- block empty
			elseif source.dead then
				-- block empty 阵亡期间不生成任何僵尸
			else
				local dead_enemies = table.filter(store.entities, function(k, v)
					return v.enemy and v.vis and v.health and v.health.dead and band(v.health.last_damage_types, bor(DAMAGE_EAT)) == 0 and band(v.vis.bans, F_SKELETON) == 0 and store.tick_ts - v.health.death_ts >= v.health.dead_lifetime - this.aura.cycle_time and U.is_inside_ellipse(v.pos, this.pos, source.auras.list[3].range)
				end)

				dead_enemies = table.slice(dead_enemies, 1, max_spawns)

				for _, dead in pairs(dead_enemies) do
					dead.vis.bans = bor(dead.vis.bans, F_SKELETON)
					dead.health.delete_after = 0

					local e = E:create_entity(this.spawn_name..this.level) 

					e.pos = V.vclone(dead.pos)

					if dead.enemy.necromancer_offset then
						e.pos.x = e.pos.x + dead.enemy.necromancer_offset.x * (dead.render.sprites[1].flip_x and -1 or 1)
						e.pos.y = e.pos.y + dead.enemy.necromancer_offset.y
					end

					e.nav_rally.center = V.vclone(e.pos)
					e.nav_rally.pos = V.vclone(e.pos)
					e.soldier.tower_id = source.id

					queue_insert(store, e)
				end
			end
		end

		coroutine.yield()
	end
end

scripts.controller_hero_mortemis_ultimate = {}

function scripts.controller_hero_mortemis_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

scripts.controller_hero_mortemis_ultimate = {}
function scripts.controller_hero_mortemis_ultimate.update(this, store)
	e = E:create_entity(this.bullet)
	e.pos = V.v(this.pos.x, this.pos.y) 
	e.bullet.from = V.v(this.pos.x, this.pos.y)
	e.bullet.to = V.v(this.pos.x, this.pos.y) 
	queue_insert(store, e)
	S:queue(this.sound)
end

scripts.controller_overwhelm_tank = {}
function scripts.controller_overwhelm_tank.update(this, store, script)
	local a = this.ranged.attacks[1]
	local a_ts = store.tick_ts

	while true do
		if a.cooldown < store.tick_ts - a_ts and this.owner.health.dead == false then
			a_ts = store.tick_ts
			local b = E:create_entity(a.bullet)
			local tx = this.owner.pos.x
			local ty = this.owner.pos.y
			
			b.pos.x, b.pos.y = tx, ty + a.start_offset_y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(tx, ty)

			queue_insert(store, b)
		end
		coroutine.yield()
	end
end

scripts.hero_tank = {}

function scripts.hero_tank.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	local bt = E:get_template(this.ranged.attacks[1].bullet)
	bt.bullet.damage_min = ls.ranged_damage_min[hl]
	bt.bullet.damage_max = ls.ranged_damage_max[hl]

	--1技能 导弹
	s = this.hero.skills.heat_missiles
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = nil
		e1 = E:get_template(this.timed_attacks.list[1].bullet)
		e1.bullet.damage_min = s.damage_max_config[s.level]
		e1.bullet.damage_max = s.damage_max_config[s.level]
	end

	--2技能 捶地
	s = this.hero.skills.ground_slam
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = nil
		e1 = E:get_template(this.timed_attacks.list[2].hit_aura)
		e1.aura.damage_min = s.damage_min_config[s.level]
		e1.aura.damage_max = s.damage_max_config[s.level]
	end

	--4技能 大招
	s = this.hero.skills.scorching_cannon
	if initial and s.level > 0 then
		this.timed_attacks.list[3].disabled = nil
		this.timed_attacks.list[3].cooldown = s.cooldown[s.level]
		local mod = E:get_template("mod_roundfire_hero_tank")
		mod.dps.damage_min = s.damage_config[s.level]
		mod.dps.damage_max = s.damage_config[s.level]
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		local mod = E:get_template("mod_bullet_zeppelin_hero_tank")
		mod.dps.damage_min = s.damage_config[s.level]
		mod.dps.damage_max = s.damage_config[s.level]
	end

end

function scripts.hero_tank.insert(this, store)
	this.hero.fn_level_up(this, store, true)
	S:queue("HeroPaladinTauntIntro")

	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_tank.update(this, store)
	local h = this.health
	local he = this.hero
	local a, am, skill, force_idle_ts
	local soldier_available = false
	local zhu_apprentice_soldier_list = {}
	local zhu_offset = {{-15,-10}, {-15,10}, {15,0}}

	local missle_attack = this.timed_attacks.list[1] --1技能  导弹
	local shake_attack = this.timed_attacks.list[2] --2技能  震地
	local fire_attack = this.timed_attacks.list[3] --4技能  喷火
	missle_attack.ts = 0
	shake_attack.ts = 0
	fire_attack.ts = 0

	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

	this.health_bar.hidden = false
	force_idle_ts = true

	local overwhelm = E:create_entity(this.overwhelm_entity)
	overwhelm.owner = this
	overwhelm.owner_id = this.id
	queue_insert(store, overwhelm)

	local function rally_zhu_apprentice()
		if not soldier_available then
			return
		else
			local nearest = P:nearest_nodes(this.nav_rally.pos.x, this.nav_rally.pos.y, nil, nil, true)
			local rally_position
			if nearest then
				pi, spi, ni = unpack(nearest[1])
				rally_position = P:node_pos(pi, spi, ni - 6)
			else
				rally_position = V.vclone(this.nav_rally.pos)
			end

			for count, zhu_apprentice_soldier in pairs(zhu_apprentice_soldier_list) do
				zhu_apprentice_soldier.nav_rally.new = true
				--zhu_apprentice_soldier.nav_rally.center = V.v(this.nav_rally.pos.x + zhu_offset[count][1], this.nav_rally.pos.y + zhu_offset[count][2])
				zhu_apprentice_soldier.nav_rally.center = V.v(rally_position.x + zhu_offset[count][1], rally_position.y + zhu_offset[count][2])
				zhu_apprentice_soldier.nav_rally.pos = V.vclone(zhu_apprentice_soldier.nav_rally.center)
				zhu_apprentice_soldier.nav_grid.waypoints = table.deepclone(this.nav_grid.waypoints)

				table.remove(zhu_apprentice_soldier.nav_grid.waypoints, #zhu_apprentice_soldier.nav_grid.waypoints)
			end
		end
	end

	local function create_soldier(e_template, pos)
		local e = E:create_entity(e_template)

		e.pos = V.vclone(pos)
		e.nav_rally.center = V.vclone(e.pos)
		e.nav_rally.pos = V.vclone(e.pos)

		queue_insert(store, e)

		return e
	end

	if this.hero.skills.expendables.level > 0 then
		local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)
		local rally_position
		if nearest then
			local pi, spi, ni = unpack(nearest[1])
			rally_position = P:node_pos(pi, spi, ni - 6)
		else
			rally_position = V.vclone(this.nav_rally.pos)
		end
		local zhu_apprentice_soldier1 = create_soldier(this.hero.skills.expendables.entity[this.hero.skills.expendables.level], V.v(rally_position.x + zhu_offset[1][1], rally_position.y + zhu_offset[1][2]))
		table.insert(zhu_apprentice_soldier_list, zhu_apprentice_soldier1)

		local zhu_apprentice_soldier2 = create_soldier(this.hero.skills.expendables.entity[this.hero.skills.expendables.level], V.v(rally_position.x + zhu_offset[2][1], rally_position.y + zhu_offset[2][2]))
		table.insert(zhu_apprentice_soldier_list, zhu_apprentice_soldier2)

		if this.hero.skills.expendables.level >= 2 then
			local zhu_apprentice_soldier3 = create_soldier(this.hero.skills.expendables.entity[this.hero.skills.expendables.level], V.v(rally_position.x + zhu_offset[3][1], rally_position.y + zhu_offset[3][2]))
			table.insert(zhu_apprentice_soldier_list, zhu_apprentice_soldier3)
		end
		soldier_available = true
	end

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			rally_zhu_apprentice()
			SU.y_hero_new_rally(store, this)
		end

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		end

		--1技能 导弹
		am = missle_attack
		skill = this.hero.skills.heat_missiles
		if not am.disabled and store.tick_ts - am.ts > am.cooldown then
			local _, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

			if not targets then
				-- block empty
			else
				local target = targets[1]

				am.ts = store.tick_ts

				local an, af = U.animation_name_facing_point(this, am.animation_pre, target.pos)

				U.animation_start(this, an, af, store.tick_ts, false, 1)

				while not U.animation_finished(this) do
					coroutine.yield()
				end

				local burst_count = skill.count[skill.level]
				local fire_loops = burst_count / #am.hit_times

				for i = 1, fire_loops do
					local an, af 
					if i == fire_loops then
						an, af = U.animation_name_facing_point(this, am.animation, target.pos)
					else
						an, af = U.animation_name_facing_point(this, am.animation_last, target.pos)
					end

					U.animation_start(this, an, af, store.tick_ts, false, 1)

					for hi, ht in ipairs(am.hit_times) do
						while ht > store.tick_ts - this.render.sprites[1].ts do
							if this.nav_rally.new then
								goto label_3064_1
							end

							coroutine.yield()
						end

						local b = E:create_entity(am.bullet)

						b.pos.x = this.pos.x + (af and -1 or 1) * am.start_offsets[km.zmod(hi, #am.start_offsets)].x
						b.pos.y = this.pos.y + am.start_offsets[hi].y
						b.bullet.level = skill.level
						b.bullet.from = V.vclone(b.pos)
						b.bullet.to = V.v(b.pos.x + (af and -1 or 1) * am.launch_vector.x, b.pos.y + am.launch_vector.y)
						b.bullet.target_id = target.id

						queue_insert(store, b)

						_, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

						if not targets then
							goto label_3064_1
						end

						target = targets[1]
					end

					SU.hero_gain_xp_from_skill(this, skill)

					U.y_wait(store, fts(3))
				end

				::label_3064_1::

				U.animation_start(this, am.animation_post, nil, store.tick_ts, false, 1)

				while not U.animation_finished(this) do
					coroutine.yield()
				end

				am.ts = store.tick_ts

				goto label_3064_0
			end
		end

		--2技能 捶地
		a = shake_attack
		skill = this.hero.skills.heat_missiles
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes, nil, a.vis_flags, a.vis_bans)

			if not target_info or #target_info < a.min_count then
				SU.delay_attack(store, a, 0.2)
			else
				local target = target_info[1].enemy
				SU.hero_gain_xp_from_skill(this, skill)

				--log.error("yy picked target:%s at:%s,%s", target.id, target.pos.x, target.pos.y)
				S:queue(a.sound_pre)
				if not SU.y_soldier_do_single_area_attack(store, this, target, a) then
					goto label_3064_0
				end
			end
		end

		--4技能 喷火
		am = fire_attack
		skill = this.hero.skills.scorching_cannon
		if not am.disabled and store.tick_ts - am.ts > am.cooldown then
			local _, targets = U.find_foremost_enemy(store.entities, this.pos, am.min_range, am.max_range, false, am.vis_flags, am.vis_bans)

			if not targets then
				-- block empty
			else
				local target = targets[1]

				am.ts = store.tick_ts

				U.animation_start(this, am.animation_pre, nil, store.tick_ts, false, 1)
				S:queue(a.sound_pre)
				
				while not U.animation_finished(this) do
					coroutine.yield()
				end
				
				U.animation_start(this, am.animation, nil, store.tick_ts, false, 1)
				S:queue(a.sound)
	
				local points = {}
				local inner_fx_radius = 35

				for i = 1, 12 do
					local r = inner_fx_radius

					local p = {}

					p.pos = U.point_on_ellipse(this.pos, r, 2 * math.pi * (12-i) / 12)
					p.terrain = GR:cell_type(p.pos.x, p.pos.y)

					if GR:cell_is(p.pos.x, p.pos.y, TERRAIN_WATER) or P:valid_node_nearby(p.pos.x, p.pos.y, 1) and not GR:cell_is(p.pos.x, p.pos.y, TERRAIN_CLIFF) then
						table.insert(points, p)
					end
				end

				local ts_e = store.tick_ts

				for _, p in pairs(points) do

					--local smoke = E:create_entity("decal_rotten_forest_smoke")
					local e = E:create_entity(am.entity)

					e.pos = V.vclone(p.pos)
					e.aura.source_id = this.id
					e.aura.ts = ts_e
					queue_insert(store, e)
					U.y_wait(store, fts(3))
				end


				while not U.animation_finished(this) do
					coroutine.yield()
				end


				U.animation_start(this, am.animation_post, nil, store.tick_ts, false, 1)
				S:queue(a.sound_post)
				while not U.animation_finished(this) do
					coroutine.yield()
				end
				SU.hero_gain_xp_from_skill(this, skill)

				am.ts = store.tick_ts

				goto label_3064_0
			end
		end
		

		--普攻
		--普攻/hit_payload
		a = ranged_attack
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

				local target, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans)

				if target then
					local start_ts = store.tick_ts
					local b, emit_fx, emit_ps, emit_ts
					local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)
					local node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
					local t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
					local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

					--U.animation_start(this, an, af, store.tick_ts)
					U.animation_start(this, an, af, store.tick_ts, false, 1)

					SU.hero_gain_xp_from_skill(this, this.hero.skills.heat_missiles)

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
						end

						coroutine.yield()
					end

					--S:queue(a.sound)
					b = E:create_entity(a.bullet)
					b.bullet.target_id = target.id
					b.bullet.source_id = this.id
					b.pos = V.vclone(this.pos)
					b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
					b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
					b.bullet.from = V.vclone(b.pos)
					local target, __, trigger_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans)
					b.bullet.to = target and trigger_pos or pred_pos

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_32530_0::

					--goto label_32530_1
				end
			end
		end


		::label_3064_0::

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)

		force_idle_ts = nil

		coroutine.yield()
	end
end

scripts.missile_tank = {}

function scripts.missile_tank.insert(this, store, script)
	local b = this.bullet
	local ps = E:create_entity(b.particles_name)

	ps.particle_system.track_id = this.id

	queue_insert(store, ps)

	return true
end

function scripts.missile_tank.update(this, store, script)
	local b = this.bullet
	local target = store.entities[b.target_id]
	local mspeed = b.min_speed
	local rot_dir = 1
	local follow = false
	local max_seek_angle = b.max_seek_angle or 0.38 --b.max_seek_angle or 0.2

	if this.render.sprites[1].animated then
		U.animation_start(this, "flying", nil, store.tick_ts, -1)
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		if b.rot_dir_from_long_angle and target then
			rot_dir = target.pos.x < this.pos.x and -1 or 1
		elseif b.speed.x < 0 then
			rot_dir = -1
		end

		coroutine.yield()
	end

	if not target or target.health and target.health.dead then
		local ref_pos = target and target.pos or this.pos

		target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
		--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
	end

	if target then
		b.to.x, b.to.y = target.pos.x, target.pos.y

		if target.unit.hit_offset then
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		if not target or target.health and target.health.dead or band(target.vis.bans, b.vis_flags) ~= 0 then
			local ref_pos = target and target.pos or this.pos

			--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
			target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
			if b.rot_dir_from_long_angle and target then
				rot_dir = target.pos.x < this.pos.x and -1 or 1
			end
		end

		if target then
			b.to.x, b.to.y = target.pos.x, target.pos.y

			if target.unit.hit_offset then
				b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
			end
		end

		local d_angle = V.angleTo(b.speed.x, b.speed.y, b.to.x - this.pos.x, b.to.y - this.pos.y)

		if max_seek_angle < math.abs(d_angle) then
			local rot = b.turn_speed * store.tick_length * rot_dir
			local dir = V.angleTo(b.speed.x, b.speed.y)

			if dir > math.pi / 3 and dir < 2 * math.pi / 3 then
				rot = rot * (b.turn_helicoidal_factor or 1.5)
			end

			b.speed.x, b.speed.y = V.rotate(rot, b.speed.x, b.speed.y)
		else
			mspeed = mspeed + 30 * math.ceil(mspeed * 0.03333333333333333 * b.acceleration_factor)
			mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
			b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		end

		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		coroutine.yield()
	end

	if b.damage_radius and b.damage_radius > 0 then
		local enemies = table.filter(store.entities, function(k, v)
			return v.enemy and v.vis and v.unit and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(V.v(v.pos.x + v.unit.hit_offset.x, v.pos.y + v.unit.hit_offset.y), b.to, b.damage_radius)
		end)
		local alchemical_powder = UP:get_upgrade("engineer_alchemical_powder")
		local alchemical_powder_on = alchemical_powder and math.random() < alchemical_powder.chance
		local shock_and_awe = nil -- = UP:get_upgrade("engineer_shock_and_awe")

		for _, enemy in pairs(enemies) do
			local enemy_pos = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			local d = E:create_entity("damage")
			d.xp_dest_id = b.source_id
			d.source_id = this.id
			d.target_id = enemy.id
			d.damage_type = b.damage_type
			d.reduce_armor = b.reduce_armor
			d.reduce_magic_armor = b.reduce_magic_armor

			if alchemical_powder_on then
				d.value = b.damage_max
			else
				local dist_factor = U.dist_factor_inside_ellipse(enemy_pos, this.pos, b.damage_radius)

				d.value = math.floor(b.damage_max - (b.damage_max - b.damage_min) * dist_factor)
			end
			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end

			if shock_and_awe and band(enemy.vis.bans, F_STUN) == 0 and band(enemy.vis.flags, bor(F_BOSS, F_CLIFF, F_FLYING)) == 0 and math.random() < shock_and_awe.chance then
				local mod = E:create_entity("mod_shock_and_awe")

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end
		end
	elseif target then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = target.id

			queue_insert(store, mod)
		end
	end

	local fx

	if b.hit_fx_air and target and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = b.hit_fx_air

		S:queue(this.sound_events.hit)
	elseif b.hit_fx_water and not target and band(GR:cell_type(b.to.x, b.to.y), TERRAIN_WATER) ~= 0 then
		fx = b.hit_fx_water

		S:queue(this.sound_events.hit_water)
	elseif b.hit_fx then
		fx = b.hit_fx

		S:queue(this.sound_events.hit)
	end

	if fx then
		local is_air = target and band(target.vis.flags, F_FLYING) ~= 0
		local sfx = E:create_entity(fx)

		if b.hit_fx_ignore_hit_offset and target and not is_air then
			sfx.pos.x, sfx.pos.y = target.pos.x, target.pos.y
		else
			sfx.pos.x, sfx.pos.y = this.pos.x, this.pos.y
		end

		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

scripts.aura_tank_skill2_bomb = {}

function scripts.aura_tank_skill2_bomb.update(this, store)
	local a = this.aura

	local function do_attack(pos, last_attack)
		local fx = E:create_entity(a.fx)

		fx.pos.x, fx.pos.y = pos.x, pos.y

		if not last_attack then
			fx.render.sprites[2].scale = V.v(0.8, 0.8)
		end

		fx.render.sprites[2].ts = store.tick_ts
		fx.tween.ts = store.tick_ts

		queue_insert(store, fx)

		local radius = last_attack and a.last_attack_damage_radius or a.damage_radius
		local targets = U.find_enemies_in_range(store.entities, pos, 0, radius, a.vis_flags, a.vis_bans)

		if targets then
			S:queue(this.sound)
			for _, t in pairs(targets) do
				local d = E:create_entity("damage")

				d.value = math.random(a.damage_min, a.damage_max)
				d.damage_type = a.damage_type
				d.source_id = this.id
				d.target_id = t.id

				queue_damage(store, d)

				if (last_attack or math.random() < a.stun_chance) and U.flags_pass(t.vis, this.stun) then
					local m = E:create_entity(this.stun.mod)

					m.modifier.source_id = this.id
					m.modifier.target_id = t.id

					queue_insert(store, m)
				end
			end

			log.paranoid(">>>> aura_10yr_bomb POS:%s,%s  damaged:%s", pos.x, pos.y, table.concat(table.map(targets, function(k, v)
				return v.id
			end), ","))
		end
	end

	local pi, spi, ni, tni, target, origin
	local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes, nil, a.vis_flags, a.vis_bans)

	if not target_info or #target_info < a.min_count then
		log.error("aura_10yr_bomb could not find valid enemies in the hero paths")
	else
		target = target_info[1].enemy
		origin = target_info[1].origin
		pi, spi, ni = unpack(origin)
		tni = target.nav_path.ni

		for i = 1, a.steps do
			local nni = ni + i * a.step_nodes * km.sign(tni - ni)
			local oni = ni + i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end

			local nni = ni - i * a.step_nodes * km.sign(tni - ni)
			local oni = ni - i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end
		end
	end

	queue_remove(store, this)
end

scripts.soldier_hero_tank_expendables_apprentice = {}

function scripts.soldier_hero_tank_expendables_apprentice.insert(this, store, script)
	this.melee.order = U.attack_order(this.melee.attacks)

	if this.ranged then
		this.ranged.order = U.attack_order(this.ranged.attacks)
	end

	return true
end

function scripts.soldier_hero_tank_expendables_apprentice.update(this, store, script)
	local brk, stam, star, a

	this.render.sprites[1].ts = store.tick_ts

	local function y_zhu_apprentice_death_and_respawn(store, this)
		local h = this.health

		this.ui.can_click = false

		local death_ts = store.tick_ts
		local dead_lifetime = h.dead_lifetime

		U.unblock_target(store, this)

		if band(h.last_damage_types, bor(DAMAGE_DISINTEGRATE_BOSS)) ~= 0 then
			this.unit.hide_after_death = true

			local fx = E:create_entity("fx_soldier_desintegrate")

			fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		elseif band(h.last_damage_types, bor(DAMAGE_EAT)) ~= 0 then
			this.unit.hide_after_death = true
		elseif band(h.last_damage_types, bor(DAMAGE_HOST)) ~= 0 then
			this.unit.hide_after_death = true

			S:queue("DeathEplosion")

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
		else
			S:queue(this.sound_events.death, this.sound_events.death_args)

			if this.unit.death_animation then
				U.animation_start(this, this.unit.death_animation, nil, store.tick_ts, false)
			else
				U.animation_start(this, "death", nil, store.tick_ts, false)
			end
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

		for _, s in pairs(this.render.sprites) do
			if this.use_hidden_count_on_respawn and s.hidden_count then
				s.hidden = s.hidden_count > 0
			else
				s.hidden = false
			end
		end

		h.ignore_damage = true

		S:queue(this.sound_events.respawn)

		local respawn_fx = E:create_entity(this.respawn_fx)

		respawn_fx.pos = V.vclone(this.pos)
		respawn_fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, respawn_fx)
		U.y_wait(store, this.respawn_fx_timing)

		this.health_bar.hidden = false
		this.ui.can_click = true
		h.dead = false
		this.force_respawn = nil
		h.hp = h.hp_max
		h.ignore_damage = false
	end

	while true do
		if this.health.dead then
			y_zhu_apprentice_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			SU.soldier_courage_upgrade(store, this)

			while this.nav_rally.new do
				if this.nav_rally.move_order then
					U.y_wait(store, this.nav_rally.move_order * math.random() * 0.3)
				end

				if SU.y_hero_new_rally(store, this) then
					goto label_895_0
				end
			end

			if this.dodge and this.dodge.active then
				this.dodge.active = false

				if this.dodge.animation then
					U.animation_start(this, this.dodge.animation, nil, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end
				end

				signal.emit("soldier-dodge", this)
			end

			if this.melee then
				brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
					goto label_895_1
				end
			end

			if this.ranged then
				brk, star = SU.y_soldier_ranged_attacks(store, this)

				if brk or star == A_DONE then
					goto label_895_1
				elseif star == A_IN_COOLDOWN then
					goto label_895_0
				end
			end

			if this.melee.continue_in_cooldown and stam == A_IN_COOLDOWN then
				goto label_895_1
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_895_1
			end

			::label_895_0::

			SU.soldier_idle(store, this)
			SU.soldier_regen(store, this)
		end

		::label_895_1::

		coroutine.yield()
	end
end

scripts.hero_tank_ultimate = {}

function scripts.hero_tank_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.hero_tank_ultimate.update(this, store)
	local function spawn_zeppelin(pi, spi, ni)
		local pos = P:node_pos(pi, spi, ni)
		local x_center = (store.visible_coords.left + store.visible_coords.right) / 2
		local spawn_pos = V.vclone(pos)
		local exit_pos = V.vclone(pos)
		local out_of_screen_offset = 100

		if x_center > spawn_pos.x then
			spawn_pos.x = store.visible_coords.left - out_of_screen_offset
			exit_pos.x = store.visible_coords.right + out_of_screen_offset
		else
			spawn_pos.x = store.visible_coords.right + out_of_screen_offset
			exit_pos.x = store.visible_coords.left - out_of_screen_offset
		end

		local zep = E:create_entity(this.entity)

		zep.pos = V.vclone(spawn_pos)
		zep.target_pos = V.vclone(pos)
		zep.exit_pos = V.vclone(exit_pos)
		zep.sound = this.sound
		zep.level = this.level

		queue_insert(store, zep)
	end

	local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)

	if #nearest > 0 then
		local pi, spi, ni = unpack(nearest[1])

		if P:is_node_valid(pi, ni) then
			S:queue(this.sound)
			spawn_zeppelin(pi, 1, ni)
		end
	end

	queue_remove(store, this)
end

scripts.zeppelin_hero_tank = {}

function scripts.zeppelin_hero_tank.update(this, store)
	local a = this.ranged.attacks[1]
	local shoot_ts = store.tick_ts
	local fps_normal = 30
	local fps_slow = 20
	--[[
	local d = E:create_entity(this.decal)

	d.render.sprites[1].ts = store.tick_ts
	d.pos = V.vclone(this.target_pos)

	queue_insert(store, d)
	]]

	local margin = this.flight_height + 100

	if this.pos.y > 768 - margin then
		this.pos.y = 768 - margin
		this.exit_pos.y = 768 - margin
		this.target_pos.y = 768 - margin
	end

	U.animation_start_group(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, "layers")

	while math.abs(this.pos.x - this.target_pos.x) > this.attack_radius * 1.75 do
		U.force_motion_step(this, store.tick_length, this.target_pos)
		coroutine.yield()
	end
	--[[

	while this.render.sprites[1].offset.y > this.flight_height_attack + 5 do
		local height_factor = (this.render.sprites[1].offset.y - this.flight_height_attack) / (this.flight_height - this.flight_height_attack)

		this.force_motion.max_v = this.speed_in_range + (this.speed_out_of_range - this.speed_in_range) * height_factor * 0.5

		U.force_motion_step(this, store.tick_length, this.exit_pos)
		coroutine.yield()
	end
	]]

	--[[

	while math.abs(this.pos.x - this.target_pos.x) <= this.attack_radius do

		if store.tick_ts - shoot_ts > a.cooldown then
			local flight_time = E:get_template(a.bullet).bullet.flight_time
			local target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, flight_time + a.shoot_time, a.vis_flags, a.vis_bans)

			if target and not target.health.dead and pred_pos then
				local an, af = U.animation_name_facing_point(this, a.animation, this.exit_pos, 1)

				U.animation_start(this, an, af, store.tick_ts, false, 1)

				local a_ts = store.tick_ts

				while store.tick_ts - a_ts < a.shoot_time do
					U.force_motion_step(this, store.tick_length, this.exit_pos)
					coroutine.yield()
				end
				]]

				local b = E:create_entity(a.bullet)

				b.bullet.from = V.v(this.pos.x + a.bullet_start_offset[1].x, this.pos.y + a.bullet_start_offset[1].y + this.render.sprites[1].offset.y)
				--b.bullet.to = V.vclone(pred_pos)
				b.bullet.to = V.vclone(this.target_pos)
				
				b.bullet.source_id = this.id
				--b.bullet.target_id = target.id
				b.pos = V.vclone(b.bullet.from)
				b.bullet.level = this.level
				b.bullet.source_id = this.id

				queue_insert(store, b)

				while not U.animation_finished(this, 1) do
					U.force_motion_step(this, store.tick_length, this.exit_pos)
					coroutine.yield()
				end

				U.animation_start(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, 1)
		--[[
				shoot_ts = store.tick_ts
			end
		end

		
		if (not this.render.sprites[1].fps or this.render.sprites[5].fps == fps_normal) and this.render.sprites[1].sync_flag then
			this.render.sprites[1].fps = fps_slow

			for i = 1, #this.render.sprites do
				if this.render.sprites[i].group == "layers" then
					U.animation_start(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, i, true)
				end
			end
		end

		local height_factor = (this.render.sprites[1].offset.y - this.flight_height_attack) / (this.flight_height - this.flight_height_attack)

		this.force_motion.max_v = this.speed_in_range + (this.speed_out_of_range - this.speed_in_range) * height_factor

		U.force_motion_step(this, store.tick_length, this.exit_pos)
		coroutine.yield()
	end
	]]

	this.force_motion.max_v = this.speed_out_of_range * 0.7

	while math.abs(this.pos.x - this.exit_pos.x) > 10 do
		if this.render.sprites[1].fps == fps_slow and this.render.sprites[1].sync_flag then
			this.render.sprites[1].fps = fps_normal

			for i = 1, #this.render.sprites do
				if this.render.sprites[i].group == "layers" then
					U.animation_start(this, "idle", this.exit_pos.x < this.pos.x, store.tick_ts, true, i, true)
				end
			end
		end

		U.force_motion_step(this, store.tick_length, this.exit_pos)

		local height_factor = (this.render.sprites[1].offset.y - this.flight_height_attack) / (this.flight_height - this.flight_height_attack)

		this.force_motion.max_v = this.speed_in_range + (this.speed_out_of_range - this.speed_in_range) * height_factor

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.decal_bullet_zeppelin_hero_tank = {}

function scripts.decal_bullet_zeppelin_hero_tank.update(this, store)
	local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)
	local pi, spi, ni = unpack(nearest[1])
	local s_pi, s_spi, s_ni = unpack(nearest[1])

	local delay = 0
	local n_step = ni < s_ni and -2 or 2

	base_ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)
	ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

	for i = 1, this.entity_count do
		local e = E:create_entity(this.aura_entity)
		ni = base_ni + n_step * (i-1)
		ni = km.clamp(1, #P:path(s_pi), ni)

		e.pos = P:node_pos(pi, spi, ni)
		e.aura.source_id = this.id
		e.delay = delay

		queue_insert(store, e)

		delay = delay + fts(U.frandom(2, 5))
		spi = km.zmod(spi + math.random(1, 2), 3)

		local e = E:create_entity(this.aura_entity)
		ni = base_ni - n_step * i
		ni = km.clamp(1, #P:path(s_pi), ni)

		e.pos = P:node_pos(pi, spi, ni)
		e.aura.source_id = this.id
		e.delay = delay

		queue_insert(store, e)

		delay = delay + fts(U.frandom(2, 5))
		spi = km.zmod(spi + math.random(1, 2), 3)
	end
end

scripts.aura_apply_mod_tank = {}

function scripts.aura_apply_mod_tank.insert(this, store, script)
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

function scripts.aura_apply_mod_tank.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0

	U.animation_start(this, "in", false, store.tick_ts, false, 1)
	while not U.animation_finished(this) do
		coroutine.yield()
	end

	U.animation_start(this, "run", false, store.tick_ts, true, 1)

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

	U.animation_start(this, "out", false, store.tick_ts, false, 1)

	U.y_wait(store, fts(17))

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end


scripts.hero_beresad = {}

function scripts.hero_beresad.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	--普攻
	local b = E:get_template(this.ranged.attacks[1].bullet)

	b.bullet.damage_max = ls.ranged_damage_max[hl]
	b.bullet.damage_min = ls.ranged_damage_min[hl]

	local s 

	--1技能 绿火
	s = this.hero.skills.conflagration
	if initial and s.level > 0 then
		local a = this.ranged.attacks[2]
		a.disabled = false
		a.cooldown = s.cooldown[s.level]
		local b = E:get_template(a.bullet)
		local payload = E:get_template(b.bullet.hit_payload[1])
		m = E:get_template(payload.aura.mod)
		m.dps.damage_min = s.damage[s.level]
		m.dps.damage_max = s.damage[s.level]
	end

	--2技能 恐吓
	s = this.hero.skills.fear_dragon
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = false
		local b = E:get_template(this.timed_attacks.list[1].entity)
		b.modifier.duration = s.duration[s.level]
	end

	--3技能 傀儡
	s = this.hero.skills.dragon_spawn
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[2]
		a.disabled = false
		e = E:get_template(a.entity)
		e.aura.entity = s.entity[s.level]
	end

	--4技能 秒杀
	s = this.hero.skills.remove_existence
	if initial and s.level > 0 then
		local a = this.ranged.attacks[3]
		a.cooldown = s.cooldown[s.level]
		a.disabled = false
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		local m = E:get_template(u.mod)
		m.dps.damage_min = s.damage[s.level]
		m.dps.damage_max = s.damage[s.level]
	end

end

function scripts.hero_beresad.insert(this, store)
	this.hero.fn_level_up(this, store, true)

	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_beresad.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts

	local golem_attack = this.timed_attacks.list[2]
	local fear_attack = this.timed_attacks.list[1]
	local fire_attack = this.ranged.attacks[2]
	local instakill_attack = this.ranged.attacks[3]
	fear_attack.ts = 0
	golem_attack.ts = 0

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

		--2技能 恐吓
		local a = fear_attack
		local skill = this.hero.skills.fear_dragon
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local start_ts, bdy, bdt, au
			local fired_aura = false
			local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not targets then
				SU.delay_attack(store, a, 0.2)
			else
				local cnt = 0
				a.ts = store.tick_ts
				U.animation_start(this, a.animation, nil, store.tick_ts, false)
				S:queue(a.sound)
				U.y_wait(store, fts(25))
				for _, e in pairs(targets) do
					cnt = cnt + 1
					local mod = E:create_entity(a.entity)
					mod.modifier.target_id = e.id
					mod.modifier.source_id = this.id
					mod.modifier.level = skill.level
					queue_insert(store, mod)
					if cnt == a.max_target then
						break
					end
				end
				U.y_animation_wait(this, 1)
				U.y_animation_play(this, "idle", nil, store.tick_ts, 1)
			end
		end

		--3技能 傀儡
		local a = golem_attack
		local skill = this.hero.skills.dragon_spawn
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
				local start_ts, bdy, bdt, au
				local fired_aura = false
				local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

				if not targets then
					SU.delay_attack(store, a, 0.2)
				else
					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts, false)

					while not U.animation_finished(this) do
						if SU.hero_interrupted(this) then
							goto label_90_0
						end

						coroutine.yield()
					end

					start_ts = store.tick_ts

					au = E:create_entity(a.entity)
					au.aura.source_id = this.id

					queue_insert(store, au)

					fired_aura = true

					::label_90_0::

					if fired_aura then
						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)
					end
					U.y_animation_wait(this, 1)
					U.y_animation_play(this, "idle", nil, store.tick_ts, 1)
				end
		end

		--4技能 秒杀
		--[[
		local a = instakill_attack
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			enemy = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false, a.vis_flags, a.vis_bans)
			if not enemy then
				SU.delay_attack(store, a, 0.2)
			else
				a.ts = store.tick_ts
				local b, emit_fx, emit_ps, emit_ts, node_offset

				local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
				local bullet_t = E:get_template(a.bullet)
				local bullet_speed = bullet_t.bullet.min_speed or 390
				local flight_time = bullet_t.bullet.flight_time
				if flight_time then
					node_offset = P:predict_enemy_node_advance(target, flight_time + a.shoot_time)
				else
					local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)

					node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
				end
				local t_pos

				if a.name == "conflagration" or a.name == "remove" then
					t_pos = P:node_pos(enemy.nav_path.pi, 1, enemy.nav_path.ni + node_offset)
				else
					t_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + node_offset)
				end

				local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

				U.animation_start(this, an, af, store.tick_ts)
				U.y_wait(store, fts(12))
				b = E:create_entity(a.bullet)
				b.pos.x, b.pos.y = this.pos.x + a.bullet_start_offset.x, this.pos.y + a.bullet_start_offset.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = V.vclone(enemy.pos)
				b.bullet.target_id = enemy.id
				b.bullet.source_id = this.id
				SU.stun_inc(enemy)
				queue_insert(store, b)
				U.y_animation_wait(this, 1)
			end
		end
		]]

		--普攻
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
				local bullet_speed = bullet_t.bullet.min_speed or 390
				local flight_time = bullet_t.bullet.flight_time
				local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false, a.vis_flags, a.vis_bans, function(v)
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

						if a.name == "fierymist" or a.name == "blazingbreath" then
							v_pos = P:node_pos(v.nav_path.pi, 1, v.nav_path.ni + node_offset)
						else
							v_pos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + node_offset)
						end
					end

					local dist_x = math.abs(v_pos.x - this.pos.x)
					local dist_y = math.abs(v_pos.y - this.pos.y)

					if a.name == "fierymist" or a.name == "blazingbreath" then
						return dist_x > a.min_range and dist_y < 80
					else
						return dist_x > 65
					end
				end)

				if target then
					local start_ts = store.tick_ts
					local b, emit_fx, emit_ps, emit_ts, node_offset

					if flight_time then
						node_offset = P:predict_enemy_node_advance(target, flight_time + a.shoot_time)
					else
						local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)

						node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
					end

					local t_pos

					if a.name == "conflagration" or a.name == "remove" then
						t_pos = P:node_pos(target.nav_path.pi, 1, target.nav_path.ni + node_offset)
					else
						t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
					end

					local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

					U.animation_start(this, an, af, store.tick_ts)

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_592_0
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

					queue_insert(store, b)

					if a.xp_from_skill then
						SU.hero_gain_xp_from_skill(this, this.hero.skills[a.xp_from_skill])
					end

					a.ts = start_ts

					if a.emit_ps and b.bullet.flight_time then
						local dest = V.vclone(b.bullet.to)

						if a.name == "conflagration" or a.name == "remove" then
							dest.y = dest.y + 15
						end

						emit_ts = store.tick_ts

						local ps = E:create_entity(a.emit_ps)
						local mspeed = V.dist(dest.x, dest.y, b.bullet.from.x, b.bullet.from.y) / b.bullet.flight_time

						ps.particle_system.emit_direction = V.angleTo(dest.x - b.bullet.from.x, dest.y - b.bullet.from.y)
						ps.particle_system.emit_speed = {
							mspeed,
							mspeed
						}
						ps.particle_system.flip_x = af
						ps.pos.x, ps.pos.y = b.bullet.from.x, b.bullet.from.y

						queue_insert(store, ps)

						emit_ps = ps
					end

					if a.emit_fx then
						local fx = E:create_entity(a.emit_fx)

						fx.pos.x, fx.pos.y = b.bullet.from.x, b.bullet.from.y
						fx.render.sprites[1].ts = store.tick_ts
						fx.render.sprites[1].flip_x = af

						if af and fx.render.sprites[1].offset.x then
							fx.render.sprites[1].offset.x = -1 * fx.render.sprites[1].offset.x
						end

						queue_insert(store, fx)

						emit_fx = fx
					end

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_592_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_592_0::
					if emit_ps then
						emit_ps.particle_system.emit = false
						emit_ps.particle_system.source_lifetime = 0
					end

					if emit_fx then
						emit_fx.render.sprites[1].hidden = true
					end
				end
			end
		end


		

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)

		force_idle_ts = nil

		coroutine.yield()
	end
end

--贝雷萨德普攻
scripts.fireball_beresad = {}
function scripts.fireball_beresad.update(this, store)
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

			--击杀给金币
			queue_damage(store, d)
			will_kill = U.predict_damage(e, d) >= e.health.hp
			if will_kill then
				queue_insert(store, sfx)
				signal.emit("got-gold", V.vclone(e.pos) or V.v(0,0), b.got_gold)
			end

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = e.id
				mod.xp_dest_id = b.source_id

				queue_insert(store, mod)
			end
			break
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

	SU_PLD.create_bullet_hit_payload(this, store)

	queue_remove(store, this)
end

--贝雷萨德1技能
scripts.flame = {}
function scripts.flame.insert(this, store, script)
	local b = this.bullet
	b.speed = SU.initial_parabola_speed(b.from, b.to, b.flight_time, 0)
	b.ts = store.tick_ts

	if this.flame_bullet then
		this.flame_bullets = {}
		local flip_x = b.to.x < b.from.x
		b.r = V.angleTo(b.to.x - b.from.x, b.to.y - b.from.y) - (flip_x and math.pi or 0)
		for i = 1, this.flames_count do
			local flame_bullet = E:create_entity(this.flame_bullet)
			for _, s in pairs(flame_bullet.render.sprites) do
				s.r = b.r
			end
			flame_bullet.start_ts = b.ts + this.delay_betweeen_flames * (i - 1)
			flame_bullet.ts = nil
			flame_bullet.pos.x, flame_bullet.pos.y = b.from.x, b.from.y
			table.insert(this.flame_bullets, flame_bullet)
		end
	end

	return true
end

function scripts.flame.update(this, store, script)
	local b = this.bullet

	while true do
		for i, flame_bullet in ipairs(this.flame_bullets) do
			if flame_bullet.ts == false then
				if i == #this.flame_bullets then
					queue_remove(store, this)
					return
				end
			elseif flame_bullet.ts then
				if store.tick_ts - flame_bullet.ts <= b.flight_time then
					flame_bullet.pos.x, flame_bullet.pos.y = SU_PLD.position_in_parabola(store.tick_ts - flame_bullet.ts, b.from, b.speed, 0)
				else
					queue_remove(store, flame_bullet)
					flame_bullet.ts = false
					if i == 1 then
						SU_PLD.make_bullet_damage_targets(this, store, nil)
						SU_PLD.create_bullet_hit_payload(this, store)
					end
				end
			elseif flame_bullet.start_ts and store.tick_ts >= flame_bullet.start_ts then
				flame_bullet.ts = store.tick_ts
				flame_bullet.start_ts = nil
				for _, s in pairs(flame_bullet.render.sprites) do
					s.ts = store.tick_ts + store.tick_length
				end
				queue_insert(store, flame_bullet)
			end
		end

		coroutine.yield()
	end
end

--贝雷萨德3技能
scripts.power_beresad_fireball = {}
function scripts.power_beresad_fireball.update(this, store, script)
	local b = this.bullet
	local mspeed = 10 * FPS
	local particle = E:create_entity("ps_power_fireball")

	particle.particle_system.track_id = this.id

	queue_insert(store, particle)

	local shadow = E:create_entity("decal_fireball_shadow")

	shadow.pos.x, shadow.pos.y = b.to.x, b.to.y
	shadow.render.sprites[1].ts = store.tick_ts

	queue_insert(store, shadow)

	local shadow_tracks = b.from.x ~= b.to.x

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		if shadow_tracks then
			shadow.pos.x = this.pos.x
		end

		coroutine.yield()
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y
	particle.particle_system.source_lifetime = 0

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, b.damage_radius)
	end)
	local damage_value = math.ceil(b.damage_factor * math.random(b.damage_min, b.damage_max))

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = damage_value
		d.damage_type = b.damage_type

		queue_damage(store, d)
	end

	S:queue(this.sound_events.hit)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if band(cell_type, TERRAIN_WATER) ~= 0 then
		local fx = E:create_entity("fx_explosion_water")

		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_water")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	else
		if b.hit_decal then
			local decal = E:create_entity(b.hit_decal)

			decal.pos = V.vclone(b.to)
			decal.render.sprites[1].ts = store.tick_ts

			queue_insert(store, decal)
		end

		if b.hit_fx then
			local fx = E:create_entity(b.hit_fx)

			fx.pos.x, fx.pos.y = b.to.x, b.to.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		end

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_earth")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	end

	SU_PLD.create_bullet_hit_payload(this, store)
	queue_remove(store, shadow)
	queue_remove(store, this)
end

scripts.soldier_golem_beresad = {}
function scripts.soldier_golem_beresad.update(this, store, script)
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

	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)
	U.y_wait(store,fts(41))

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
			U.y_animation_play(this, "death", nil, store.tick_ts, 1)
			U.y_wait(store,fts(15))
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

--贝雷萨德大招

scripts.controller_beresad_ultimate = {}

function scripts.controller_beresad_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.controller_beresad_ultimate.update(this, store)

	local function flash_screen(fx)
		if store.tick_ts - fx.ts > fx.cooldown then
			local duration = U.frandom(this.flash_duration_min, this.flash_duration_max)
			local delay = U.frandom(this.flash_delay_min, this.flash_delay_max)
			local a1 = math.random(this.flash_l1_max_alphas[1], this.flash_l1_max_alphas[2])
			local a2 = this.flash_l2_max_alpha
			local a22 = this.flash_l2_min_alpha
			local delta = this.flash_delta
			local t1, t2, t3 = 0, delta, delta + duration

			fx.tween.props[1].keys = {
				{
					t1,
					0
				},
				{
					t2,
					a1
				},
				{
					t3,
					0
				}
			}
			fx.tween.ts = store.tick_ts
			fx.ts = store.tick_ts
			fx.cooldown = duration + U.frandom(0, 0.4)
		end
	end
	local a_ts = 0
	local target_id_list = {}
	local u_ts = store.tick_ts
	--S:queue(this.sound_events.insert)

	local overlay = E:create_entity("overlay_power_thunder_flash")

	overlay.pos.x, overlay.pos.y = REF_W / 2, REF_H / 2
	overlay.tween.props[2].keys = {
		{
			0,
			0
		},
		{
			0.5,
			this.flash_l2_max_alpha
		}
	}
	overlay.tween.props[2].ts = store.tick_ts

	queue_insert(store, overlay)
	flash_screen(overlay)

	while store.tick_ts - u_ts < this.duration do

		if store.tick_ts - a_ts > this.mod_cooldown then
			a_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.damage_radius, F_MOD, 0, function(v) 
				return not table.contains(target_id_list, v.id)
			end)

			if targets then
				for _, e in pairs(targets) do

					local mod = E:create_entity(this.mod)
					mod.modifier.target_id = e.id
					mod.modifier.source_id = this.id
					table.insert(target_id_list, e.id)
					queue_insert(store, mod)
				end
			end
		end

		if store.tick_ts - this.rain.ts > this.rain.cooldown then
			local r = this.rain

			r.ts = store.tick_ts

			local angle = U.frandom(r.angle_min, r.angle_max)

			for i = 1, r.count do
				angle = angle + U.frandom(-r.angle_between, r.angle_between)

				local dist = math.random(r.distance_min, r.distance_max)
				local ox, oy = V.rotate(angle, dist, 0)
				local delay = U.frandom(0.001, r.delay_max)
				local pos = V.v(math.random(-REF_OX, REF_W + REF_OX), math.random(0, REF_H))
				local e = E:create_entity(this.rain.drop)

				e.pos.x, e.pos.y = pos.x, pos.y
				e.render.sprites[1].name = e.render.sprites[1].name..(math.random(8,16))
				e.render.sprites[1].offset = V.v(-ox, -oy)
				e.render.sprites[1].keep_flip_x = true
				--原图角度左下倾斜45°，需要扭正
				e.render.sprites[1].r = angle + 45 * math.pi / 180
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

				local e = E:create_entity(this.rain.splash)

				e.pos.x, e.pos.y = pos.x, pos.y
				e.render.sprites[1].ts = store.tick_ts + delay + r.duration

				queue_insert(store, e)
			end
		end
		coroutine.yield()
	end

	U.y_wait(store, overlay.cooldown)

	overlay.tween.remove = true
	overlay.tween.props[1].keys = {
		{
			0,
			overlay.render.sprites[1].alpha
		},
		{
			0.5,
			0
		}
	}
	overlay.tween.props[2].keys = {
		{
			0,
			overlay.render.sprites[2].alpha
		},
		{
			0.5,
			0
		}
	}
	overlay.tween.ts = store.tick_ts
	overlay.tween.props[2].ts = nil

	queue_remove(store, this)
end

scripts.hero_naga = {}

function scripts.hero_naga.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)
		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	--1技能 浪
	s = this.hero.skills.wave
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[2]
		a.disabled = false
		a.count = s.count[s.level]
		local e = E:get_template(a.hit_aura)
		e.aura.damage_min = s.damage_config[s.level]
		e.aura.damage_max = s.damage_config[s.level]
	end

	--2技能 图腾
	s = this.hero.skills.banner_allies
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[3]
		a.disabled = false
		local e = E:get_template(a.entity)
		e.aura.duration = s.duration[s.level]
		local m = E:get_template(e.aura.mod)
		m.hps.heal_min = s.heal[s.level]
		m.hps.heal_max = s.heal[s.level]
	end

	--3技能 沉默
	s = this.hero.skills.gaze
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[1]
		a.disabled = false
		local e = E:get_template("mod_naga_gaze_slow")
		e.modifier.duration = s.duration[s.level]
		a.max_targets = s.max_targets[s.level]
	end

	--4技能 拍地板
	s = this.hero.skills.splash
	if initial and s.level > 0 then
		local a = this.melee.attacks[2]
		a.damage_min = s.damage_config[s.level]
		a.damage_max = s.damage_config[s.level]
		a.disabled = false
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		u.damage = s.damage_config[s.level]
	end
end

function scripts.hero_naga.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta
	local gaze_attack = this.timed_attacks.list[1]
	gaze_attack.ts = 0
	local wave_attack = this.timed_attacks.list[2]
	wave_attack.ts = 0
	local totem_attack = this.timed_attacks.list[3]
	totem_attack.ts = 0
	this.melee.attacks[1].ts = 0
	this.ranged.attacks[1].ts = 0


	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

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
					goto label_46144_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			--3技能 沉默
			skill = this.hero.skills.gaze
			a = gaze_attack
			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range_trigger, a.vis_flags, a.vis_bans)

				if not enemies or #enemies < a.min_targets then
					SU.delay_attack(store, a, fts(10))
				else
					local start_ts = store.tick_ts
					SU.hero_gain_xp_from_skill(this, skill)

					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts, 1)

					U.y_wait(store, a.cast_time)
					do
						enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range_effect, a.vis_flags, a.vis_bans)
						a.ts = start_ts

						if enemies then
							for i = 1,#enemies do
								for _, mod in pairs(a.mods) do 
									local m = E:create_entity(mod)
									m.modifier.source_id = this.id
									m.modifier.target_id = enemies[i].id
									queue_insert(store, m)
								end

								if i >= a.max_targets then
									break
								end
							end
						end
						
						--SU.y_animation_wait(this, 1)
						SU.y_hero_animation_wait(this)
					end

					goto label_46144_0
				end
			end

			--1技能 捶地
			a = wave_attack
			skill = this.hero.skills.wave
			if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
				local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes, nil, a.vis_flags, a.vis_bans)

				if not target_info or #target_info < a.min_count then
					SU.delay_attack(store, a, 0.2)
				else
					local target = target_info[1].enemy
					SU.hero_gain_xp_from_skill(this, skill)

					--log.error("yy picked target:%s at:%s,%s", target.id, target.pos.x, target.pos.y)
					S:queue(a.sound_pre)
					if not SU.y_soldier_do_single_area_attack(store, this, target, a) then
						goto label_46144_0
					end
				end
			end

			--2技能 图腾
			skill = this.hero.skills.banner_allies
			a = totem_attack
			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local soldiers = U.find_soldiers_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags, a.vis_bans)

				if not soldiers or #soldiers < a.min_targets then
					SU.delay_attack(store, a, fts(10))
				else
					local start_ts = store.tick_ts
					SU.hero_gain_xp_from_skill(this, skill)

					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts, 1)

					U.y_wait(store, a.cast_time)
					do
						a.ts = start_ts
						local e = E:create_entity(a.entity)

						local nearest_node = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, false)[1]
						local pi, spi, ni = unpack(nearest_node)

						e.pos = P:node_pos(pi, spi, ni)
						queue_insert(store, e)

						SU.y_hero_animation_wait(this)
					end

					goto label_46144_0
				end
			end
 
			if not this.health.dead and this.health.hp / this.health.hp_max < this.hp_threshold then
				this.unit.damage_factor = this.damage_factor_config
			else
				this.unit.damage_factor = 1
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_46144_0::

		coroutine.yield()
	end
end

scripts.controller_hero_naga_ultimate = {}

function scripts.controller_hero_naga_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.controller_hero_naga_ultimate.update(this, store)
	local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true, NF_POWER_3)

	if #nodes < 1 then
		log.error("controller_hero_wukong_ultimate: could not find valid node")
		queue_remove(store, this)

		return
	end

	local pi, spi, ni = unpack(nodes[1])

	this.pos = P:node_pos(pi, 1, ni)

	U.animation_start_group(this, "in", nil, store.tick_ts, false, "layers")

	U.y_animation_wait(this)

	U.animation_start_group(this, "run", nil, store.tick_ts, true, "layers")

	local start_ts = store.tick_ts
	S:queue(this.sound_events.insert)

	for t = 1, this.duration * 5 do
		while store.tick_ts < start_ts + 0.2 * t do
			coroutine.yield()
		end

		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.damage_radius, this.damage_flags, this.damage_bans)

		if targets then
			for _, e in pairs(targets) do
				local d = E:create_entity("damage")

				d.value = this.damage
				d.damage_type = this.damage_type
				d.source_id = this.id
				d.target_id = e.id

				queue_damage(store, d)
			end
		end
	end

	U.animation_start_group(this, "out", nil, store.tick_ts, false, "layers")

	U.y_animation_wait(this)

	queue_remove(store, this)
end

scripts.aura_naga_skill1_bomb = {}

function scripts.aura_naga_skill1_bomb.update(this, store)
	local a = this.aura

	local function do_attack(pos, last_attack)
		local fx = E:create_entity(a.fx)

		fx.pos.x, fx.pos.y = pos.x, pos.y

		if not last_attack then
			fx.render.sprites[2].scale = V.v(0.8, 0.8)
		end

		fx.render.sprites[2].ts = store.tick_ts
		fx.tween.ts = store.tick_ts

		queue_insert(store, fx)

		local radius = last_attack and a.last_attack_damage_radius or a.damage_radius
		local targets = U.find_enemies_in_range(store.entities, pos, 0, radius, a.vis_flags, a.vis_bans)

		if targets then
			S:queue(this.sound)
			for _, t in pairs(targets) do
				local d = E:create_entity("damage")

				d.value = math.random(a.damage_min, a.damage_max)
				d.damage_type = a.damage_type
				d.source_id = this.id
				d.target_id = t.id

				queue_damage(store, d)

				if (last_attack or math.random() < a.stun_chance) and U.flags_pass(t.vis, this.stun) then
					local m = E:create_entity(this.stun.mod)

					m.modifier.source_id = this.id
					m.modifier.target_id = t.id

					queue_insert(store, m)
				end
			end

			log.paranoid(">>>> aura_10yr_bomb POS:%s,%s  damaged:%s", pos.x, pos.y, table.concat(table.map(targets, function(k, v)
				return v.id
			end), ","))
		end
	end

	local pi, spi, ni, tni, target, origin
	local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes, nil, a.vis_flags, a.vis_bans)

	if not target_info or #target_info < a.min_count then
		log.error("aura_10yr_bomb could not find valid enemies in the hero paths")
	else
		target = target_info[1].enemy
		origin = target_info[1].origin
		pi, spi, ni = unpack(origin)
		tni = target.nav_path.ni

		for i = 1, a.steps do
			local nni = ni + i * a.step_nodes * km.sign(tni - ni)
			local oni = ni + i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end
			--[[

			local nni = ni - i * a.step_nodes * km.sign(tni - ni)
			local oni = ni - i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				local opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end
			]]
		end
	end

	queue_remove(store, this)
end

scripts.aura_totem_naga = {}

function scripts.aura_totem_naga.update(this, store, script)
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

	U.animation_start(this, "run", nil, store.tick_ts, true, totem_sid)

	this.aura.ts = store.tick_ts

	while store.tick_ts - this.aura.ts < a.duration do
		local soldier = table.filter(store.entities, function(k, e)
			return e.soldier and e.health and not e.health.dead and band(e.vis.flags, this.aura.vis_bans) == 0 and band(e.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(e.pos, this.pos, this.aura.radius)
		end)

		for _, soldier in pairs(soldier) do
			local new_mod = E:create_entity(this.aura.mod)

			new_mod.modifier.level = this.aura.level
			new_mod.modifier.target_id = soldier.id
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

scripts.hero_murglun = {}

function scripts.hero_murglun.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	--普攻
	local b = E:get_template(this.ranged.attacks[1].bullet)

	b.bullet.damage_max = ls.ranged_damage_max[hl]
	b.bullet.damage_min = ls.ranged_damage_min[hl]

	local s 

	--1技能 普攻增强
	s = this.hero.skills.magma_pool
	if initial and s.level > 0 then
		local b = E:get_template(this.ranged.attacks[1].bullet)
		b.bullet.hit_payload = s.pay_load_name
		p = E:get_template(s.pay_load_name)
		p.aura.duration = s.duration[s.level]
		m = E:get_template(p.aura.mod)
		m.dps.damage_min = s.damage[s.level]
		m.dps.damage_max = s.damage[s.level]
	end

	--2技能 增伤
	s = this.hero.skills.tar_maker
	if initial and s.level > 0 then
		local a = this.auras.list[1]
		a.disabled = false
		a.damage_inc = s.rate[s.level]
		mod = E:get_template(a.mod)
		mod.range_factor = s.rate[s.level]
	end

	--3技能 秒杀
	s = this.hero.skills.geyser
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[1]
		a.cooldown = s.cooldown[s.level]
		a.disabled = false
	end

	--4技能 岩浆池
	s = this.hero.skills.infernal_heat
	if initial and s.level > 0 then
		local a = this.ranged.attacks[2]
		a.cooldown = s.cooldown[s.level]
		a.disabled = false
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		a = E:get_template(u.aura.entity)
		a.bullet.damage_min = s.boss_damage[s.level]
		a.bullet.damage_max = s.boss_damage[s.level]
	end

end

function scripts.hero_murglun.update(this, store, script)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts

	local ranged_attack = this.ranged.attacks[1] --普攻
	local lava_pool_attack = this.ranged.attacks[2] --岩浆池
	local instakill_attack = this.timed_attacks.list[1] --秒杀
	--被动应该需要新创造一个entity，因为需要走A、跟踪
	--local lava_blood_attack = this.timed_attacks.list[2]--被动技能
	local heat_aura_attack =  this.auras.list[1] --增伤

	local attack, skill
	this.ranged.order = {2,1}
	ranged_attack.ts = store.tick_ts
	instakill_attack.ts = store.tick_ts
	lava_pool_attack.ts = store.tick_ts
	heat_aura_attack.ts = store.tick_ts
	--lava_blood_attack = store.tick_ts

	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = false
	force_idle_ts = true

	local lava_blood = E:create_entity("decal_lava_blood_murglun")
	lava_blood.owner = this
	lava_blood.owner_id = this.id
	queue_insert(store, lava_blood)


	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			--需要移除mod
			SU.y_hero_new_rally(store, this)
			local mods = table.filter(store.entities, function(_, e)
				return e.modifier and e.modifier.source_id == this.id
			end)

			for _, m in pairs(mods) do
				queue_remove(store, m)
			end
		end

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		end

		--3技能秒杀
		a = instakill_attack
		skill = this.hero.skills.geyser
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_nearest_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not target then
				SU.delay_attack(store, a, 0.13333333333333333)
			else
				SU.hero_gain_xp_from_skill(this, skill)

				a.ts = store.tick_ts

				--[[
				local steps = math.floor(fts(9) / store.tick_length)
				local step_x, step_y = V.mul(1 / steps, target.pos.x - this.pos.x, target.pos.y - this.pos.y - 1)

				for i = 1, steps do
					this.pos.x, this.pos.y = this.pos.x + step_x, this.pos.y + step_y

					coroutine.yield()
				end
				]]--

				--[[
				local fx = E:create_entity("fx_dragon_feast")

				fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
				fx.render.sprites[1].ts = store.tick_ts
				]]

				queue_insert(store, fx)

				local d = E:create_entity("damage")

				d.damage_type = DAMAGE_INSTAKILL
				d.value = 0
				d.target_id = target.id
				d.source_id = this.id

				local actual_damage = U.predict_damage(target, d)

				if band(target.vis.bans, DAMAGE_INSTAKILL) == 0 and band(target.vis.flags, bor(F_BOSS,F_MINIBOSS)) == 0 then
					SU.stun_inc(target)
					S:queue(a.sound)
					U.y_animation_play(this, "geiser", nil, store.tick_ts, 1)
					if target.pos then
						d.damage_type = DAMAGE_INSTAKILL

						local fxn, default_fx

						--if target.unit.explode_fx and target.unit.explode_fx ~= "fx_unit_explode" then
						--	fxn = target.unit.explode_fx
						--	default_fx = false
						--else
						fxn = "fx_dragon_geiser_explode"
						
						--default_fx = true
						--end

						local fx = E:create_entity(fxn)
						local fxs = fx.render.sprites[1]

						fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
						fxs.ts = store.tick_ts

						--if default_fx then
							--fxs.scale = fxs.size_scales[target.unit.size]
						--else
						--	fxs.name = fxs.size_names[target.unit.size]
						--end

						queue_insert(store, fx)

						fxn = "fx_dragon_geiser_explode_ash"
						local fx2 = E:create_entity(fxn)
						local fxs2 = fx2.render.sprites[1]

						fx2.pos.x, fx2.pos.y = target.pos.x, target.pos.y
						fxs2.ts = store.tick_ts
						queue_insert(store, fx2)
					else
						d.damage_type = DAMAGE_INSTAKILL
					end
				end

				queue_damage(store, d)
				SU.stun_dec(target)
				U.y_animation_wait(this)

				force_idle_ts = true

				--goto label_38611_1
			end
		end

		--普攻/hit_payload
		local a = ranged_attack
		--普攻，直接沿用2代骨龙
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
							goto label_38611_0
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
					if i == 2 then
						local nearest_node = P:nearest_nodes(t_pos.x, t_pos.y, nil, nil, false)[1]
						local pi, spi, ni = unpack(nearest_node)
						local npos = P:node_pos(pi, spi, ni)
						b.bullet.to = npos
					end
					
					--print("damage radius"..b.bullet.damage_radius)
					--b.bullet.damage_radius = 20 + 20 * this.hero.skills.explosion.level

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_38611_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_38611_0::

					--goto label_38611_1
				end
			end
		end

		--2技能加伤害
		if store.tick_ts - heat_aura_attack.ts > heat_aura_attack.cooldown and he.skills.tar_maker.level >= 1 then
			heat_aura_attack.ts = store.tick_ts
			local eagle_range = heat_aura_attack.range
			local existing_mods = table.filter(store.entities, function(_, e)
				return e.modifier and e.template_name == heat_aura_attack.mod and e.modifier.level >= he.skills.tar_maker.level
			end)
			local busy_ids = table.map(existing_mods, function(k, v)
				return v.modifier.target_id
			end)
			local towers = table.filter(store.entities, function(_, e)
				return e.tower and e ~= this.owner and e.tower.can_be_mod and not table.contains(busy_ids, e.id) and not table.contains(heat_aura_attack.excluded_templates, e.template_name) and U.is_inside_ellipse(e.pos, this.pos, eagle_range)
			end)

			for _, tower in pairs(towers) do
				local new_mod = E:create_entity(heat_aura_attack.mod)

				new_mod.modifier.level = he.skills.tar_maker.level
				new_mod.modifier.target_id = tower.id
				new_mod.modifier.source_id = this.id
				new_mod.modifier.duration = 1
				new_mod.pos = tower.pos

				queue_insert(store, new_mod)
			end
		end

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)
		force_idle_ts = nil

		::label_38611_1::
		
		coroutine.yield()
	end

	queue_remove(store, lava_blood)
end

scripts.fireball_murglun = {}

function scripts.fireball_murglun.update(this, store)
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
			break
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

	SU_PLD.create_bullet_hit_payload(this, store)

	queue_remove(store, this)
end

scripts.hero_murglun_ultimate = {}
function scripts.hero_murglun_ultimate.can_fire_fn(this, x, y, store)
	return not GR:cell_is(x, y, TERRAIN_FAERIE) and P:valid_node_nearby(x, y, 1.4285714285714286, NF_POWER_3)
end

function scripts.hero_murglun_ultimate.update(this, store)
	local start_y = store.visible_coords and store.visible_coords.top or REF_H
	local bdt
	local a = this.aura
	local owner_pos = V.vclone(this.pos)

	print(a.loops)
	print("insert ultimate, owner_pos is "..this.pos.x..this.pos.y)
	if not owner_pos then
		log.error("owner %s was not found. bailing out", a.source_od)
	else
		do
			local bdy = math.abs(owner_pos.y - start_y)
			local tpl = E:get_template(a.entity)

			bdt = bdy / tpl.bullet.max_speed
		end

		for i = 1, a.loops do
			local b = E:create_entity(a.entity)

			local tx = owner_pos.x + math.random(-35, 35)
			local ty = owner_pos.y + math.random(-35, 35)
			local dh = start_y - ty
			local dx = dh * 0.4

			b.pos.x, b.pos.y = tx + dx, start_y
			b.bullet.to = V.v(tx, ty)

			b.bullet.from = V.vclone(b.pos)

			queue_insert(store, b)
			U.y_wait(store, a.delay)
		end
	end

	queue_remove(store, this)
end

scripts.power_murglun_fireball = {}

function scripts.power_murglun_fireball.update(this, store, script)
	local b = this.bullet
	local mspeed = 10 * FPS
	local particle = E:create_entity("ps_power_fireball")

	particle.particle_system.track_id = this.id

	queue_insert(store, particle)

	local shadow = E:create_entity("decal_fireball_shadow")

	shadow.pos.x, shadow.pos.y = b.to.x, b.to.y
	shadow.render.sprites[1].ts = store.tick_ts

	queue_insert(store, shadow)

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	particle.particle_system.source_lifetime = 0

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, b.damage_radius)
	end)
	local damage_value = math.ceil(b.damage_factor * math.random(b.damage_min, b.damage_max))

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = damage_value
		d.damage_type = b.damage_type 
		if enemy.vis.flags and band(enemy.vis.flags, bor(F_BOSS, F_MINIBOSS)) ~= 0 then
			d.damage_type = DAMAGE_TRUE
		end

		queue_damage(store, d)
	end

	S:queue(this.sound_events.hit)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if band(cell_type, TERRAIN_WATER) ~= 0 then
		local fx = E:create_entity("fx_explosion_water")

		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_water")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	else
		if b.hit_decal then
			local decal = E:create_entity(b.hit_decal)

			decal.pos = V.vclone(b.to)
			decal.render.sprites[1].ts = store.tick_ts

			queue_insert(store, decal)
		end

		if b.hit_fx then
			local fx = E:create_entity(b.hit_fx)

			fx.pos.x, fx.pos.y = b.to.x, b.to.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		end

		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_earth")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
	end

	queue_remove(store, shadow)
	queue_remove(store, this)
end

scripts.controller_lava_blood_murglun = {}
function scripts.controller_lava_blood_murglun.update(this, store, script)
	local a = this.ranged.attacks[1]
	local a_ts = store.tick_ts

	while true do
		if a.cooldown < store.tick_ts - a_ts and this.owner.health.dead == false then
			a_ts = store.tick_ts
			local b = E:create_entity(a.bullet)
			local tx = this.owner.pos.x + math.random(-20, 20)
			local ty = this.owner.pos.y
			
			b.pos.x, b.pos.y = tx, ty + a.start_offset_y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(tx, ty)

			queue_insert(store, b)
		end
		coroutine.yield()
	end
end

scripts.lava_blood_murglun = {}

function scripts.lava_blood_murglun.update(this, store, script)
	local b = this.bullet
	local mspeed = 10 * FPS

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, b.damage_radius)
	end)
	local damage_value = math.ceil(b.damage_factor * math.random(b.damage_min, b.damage_max))

	for _, enemy in pairs(enemies) do
		local d = E:create_entity("damage")

		d.source_id = this.id
		d.target_id = enemy.id
		d.value = damage_value
		d.damage_type = b.damage_type 

		queue_damage(store, d)
	end

	S:queue(this.sound_events.hit)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if band(cell_type, TERRAIN_WATER) ~= 0 then
		local fx = E:create_entity("fx_explosion_water")

		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)

		--[[
		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_water")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
		]]
	else
		if b.hit_decal then
			local decal = E:create_entity(b.hit_decal)

			decal.pos = V.vclone(b.to)
			decal.render.sprites[1].ts = store.tick_ts

			queue_insert(store, decal)
		end

		if b.hit_fx then
			local fx = E:create_entity(b.hit_fx)

			fx.pos.x, fx.pos.y = b.to.x, b.to.y
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		end

		--[[
		if this.scorch_earth then
			local scorched = E:create_entity("power_scorched_earth")

			scorched.pos.x, scorched.pos.y = b.to.x, b.to.y

			for i = 1, #scorched.render.sprites do
				scorched.render.sprites[i].ts = store.tick_ts
			end

			queue_insert(store, scorched)
		end
		]]
	end

	queue_remove(store, shadow)
	queue_remove(store, this)
end

scripts.range_mod_murglun = {}

function scripts.range_mod_murglun.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert range_mod_balloon to entity %s - ", target.id, target.template_name)

		return false
	end

	if target.tower and target.tower.damage_factor then
		target.tower.damage_factor = target.tower.damage_factor * this.range_factor
	end

	--if target.barrack then
	--	target.barrack.rally_range = target.barrack.rally_range * (this.range_factor + m.level * this.range_factor_inc)
	--end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.range_mod_murglun.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and target.tower and target.tower.damage_factor then
		target.tower.damage_factor = target.tower.damage_factor / this.range_factor 
	end

	--if target and target.barrack then
	--	target.barrack.rally_range = target.barrack.rally_range / (this.range_factor + m.level * this.range_factor_inc)
	--end

	return true
end

scripts.hero_mammoth = {}

local function mammoth_set_lone_wolf(this, active)
	if this.mammoth_lone_wolf_active == active or not this.mammoth_base_hp_max then
		return
	end

	local h = this.health
	local old_hp_max = h.hp_max
	local hp_factor = active and this.mammoth_lone_wolf.health_factor or 1
	local damage_factor = active and this.mammoth_lone_wolf.damage_factor or 1

	h.hp_max = math.floor(this.mammoth_base_hp_max * hp_factor)
	if active and not h.dead then
		h.hp = math.min(h.hp_max, h.hp + h.hp_max - old_hp_max)
	else
		h.hp = math.min(h.hp, h.hp_max)
	end

	this.melee.attacks[1].damage_min = math.floor(this.mammoth_base_damage_min * damage_factor)
	this.melee.attacks[1].damage_max = math.floor(this.mammoth_base_damage_max * damage_factor)
	this.mammoth_lone_wolf_active = active
end

local function mammoth_has_nearby_ally(this, store)
	local range_sq = this.mammoth_lone_wolf.range * this.mammoth_lone_wolf.range

	for _, entity in pairs(store.entities) do
		if entity.id ~= this.id and entity.soldier and not entity.enemy and entity.health and not entity.health.dead then
			local dx = entity.pos.x - this.pos.x
			local dy = entity.pos.y - this.pos.y

			if dx * dx + dy * dy <= range_sq then
				return true
			end
		end
	end

	return false
end

local function mammoth_start_all_sprites(this, animation, loop, ts)
	for i = 1, #this.render.sprites do
		U.animation_start(this, animation, nil, ts, loop, i)
	end
end

function scripts.hero_mammoth.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats
	local was_lone_wolf = this.mammoth_lone_wolf_active
	local s, a

	this.mammoth_lone_wolf_active = false
	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.mammoth_base_hp_max = ls.hp_max[hl]
	this.mammoth_base_damage_min = ls.melee_damage_min[hl]
	this.mammoth_base_damage_max = ls.melee_damage_max[hl]
	this.melee.attacks[1].damage_min = this.mammoth_base_damage_min
	this.melee.attacks[1].damage_max = this.mammoth_base_damage_max

	s = this.hero.skills.fissure
	a = this.timed_attacks.list[1]
	if s.level > 0 then
		a.disabled = false
		a.damage = s.damage[s.level]
		a.stun_duration = s.stun_duration[s.level]
		a.tech_damage_factor = s.tech_damage_factor
	end

	s = this.hero.skills.frenzy
	a = this.timed_attacks.list[2]
	if s.level > 0 then
		a.disabled = false
		a.duration = s.duration[s.level]
		a.attack_cooldown = s.attack_cooldown[s.level]
	end

	s = this.hero.skills.whirlwind
	a = this.timed_attacks.list[3]
	if s.level > 0 then
		a.disabled = false
		a.hit_count = s.hit_count[s.level]
		a.damage_bonus = s.damage_bonus[s.level]
		a.tech_damage_factor = s.tech_damage_factor
	end

	s = this.hero.skills.ultimate
	local controller = E:get_template(s.controller_name)

	controller.cooldown = s.cooldown[s.level]
	controller.damage = s.damage

	if was_lone_wolf then
		mammoth_set_lone_wolf(this, true)
	end

	if initial then
		this.health.hp = this.health.hp_max
	end
end

function scripts.hero_mammoth.insert(this, store)
	if this.sound_group and not S.sounds_uses[this.sound_group] then
		S:load_group(this.sound_group, false)
	end

	return scripts.hero_basic.insert(this, store)
end

function scripts.hero_mammoth_on_damage(this, store, damage)
	local damage_type = damage.damage_type or 0
	local bypasses_frenzy = band(damage_type, bor(DAMAGE_INSTAKILL, DAMAGE_EAT)) ~= 0

	local frenzy = this.timed_attacks and this.timed_attacks.list[2]
	local predicted_damage = damage.value and U.predict_damage(this, damage) or 0
	if frenzy and not frenzy.disabled and not bypasses_frenzy and store.tick_ts - (frenzy.ts or 0) >= frenzy.cooldown and predicted_damage >= this.health.hp then
		damage.value = math.max(0, this.health.hp - 1)
		this.mammoth_frenzy_pending = true
	end

	return true
end

function scripts.hero_mammoth.update(this, store)
	local h = this.health
	local fissure = this.timed_attacks.list[1]
	local frenzy = this.timed_attacks.list[2]
	local whirlwind = this.timed_attacks.list[3]
	local whirlwind_hits = 0
	local last_lone_wolf_check = -math.huge
	local brk, sta

	local lone_wolf_fx = E:create_entity(this.mammoth_lone_wolf.controller)
	lone_wolf_fx.source_id = this.id
	lone_wolf_fx.pos = V.vclone(this.pos)
	queue_insert(store, lone_wolf_fx)

	this.mammoth_lone_wolf_active = false
	this.mammoth_frenzy_active = false
	this.mammoth_frenzy_pending = false
	this.mammoth_base_attack_cooldown = this.melee.attacks[1].cooldown
	this.health_bar.hidden = false
	this.melee.attacks[1].ts = store.tick_ts
	fissure.ts = store.tick_ts
	frenzy.ts = store.tick_ts
	whirlwind.ts = store.tick_ts
	U.animation_start(this, "idle", nil, store.tick_ts, true)

	while true do
		if h.dead then
			mammoth_set_lone_wolf(this, false)

			local legacy_skill = this.hero.skills.legacy
			if legacy_skill.level > 0 then
				local legacy = E:create_entity(this.mammoth_legacy.entity)

				legacy.pos = V.vclone(this.pos)
				legacy.source_id = this.id
				legacy.activation_delay = this.mammoth_legacy.activation_delay
				legacy.damage = legacy_skill.damage[legacy_skill.level]
				legacy.damage_type = this.mammoth_legacy.damage_type
				legacy.range = this.mammoth_legacy.range
				legacy.slow_factor = legacy_skill.slow_factor[legacy_skill.level]
				legacy.tick_time = this.mammoth_legacy.tick_time
				queue_insert(store, legacy)
			end

			SU.y_hero_death_and_respawn(store, this)
			fissure.ts = store.tick_ts
			frenzy.ts = store.tick_ts
			whirlwind_hits = 0
		end

		if store.tick_ts - last_lone_wolf_check >= this.mammoth_lone_wolf.check_time then
			last_lone_wolf_check = store.tick_ts
			mammoth_set_lone_wolf(this, not h.dead and not mammoth_has_nearby_ally(this, store))
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			if SU.hero_level_up(store, this) then
				S:queue("HeroLevelUp")
				U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
			end

			if this.nav_rally.new then
				SU.y_hero_new_rally(store, this)
				goto label_mammoth_end
			end

			if not frenzy.disabled and not this.mammoth_frenzy_active and store.tick_ts - frenzy.ts >= frenzy.cooldown and (this.mammoth_frenzy_pending or h.hp / h.hp_max < frenzy.health_threshold) then
				frenzy.ts = store.tick_ts
				this.mammoth_frenzy_pending = false
				this.mammoth_frenzy_active = true
				this.melee.attacks[1].cooldown = frenzy.attack_cooldown
				SU.hero_gain_xp_from_skill(this, this.hero.skills.frenzy)
				S:queue(frenzy.sound, {delay = frenzy.sound_delay})

				local controller = E:create_entity(frenzy.controller)
				controller.source_id = this.id
				controller.duration = frenzy.duration
				controller.base_attack_cooldown = this.mammoth_base_attack_cooldown
				controller.pos = V.vclone(this.pos)
				controller.added_immunity = band(controller.immunity, bnot(h.immune_to))
				h.immune_to = bor(h.immune_to, controller.immunity)
				queue_insert(store, controller)
				U.y_animation_play(this, frenzy.animation, nil, store.tick_ts, 1)
				goto label_mammoth_end
			end

			if not fissure.disabled and store.tick_ts - fissure.ts >= fissure.cooldown then
				local enemies = U.find_enemies_in_range(store.entities, this.pos, fissure.min_range, fissure.max_range, fissure.vis_flags, fissure.vis_bans)
				local target

				if enemies then
					for _, enemy in pairs(enemies) do
						if enemy.enemy and enemy.enemy.blocker_id == this.id then
							target = enemy
							break
						end
					end
				end

				if target then
					fissure.ts = store.tick_ts
					SU.hero_gain_xp_from_skill(this, this.hero.skills.fissure)
					S:queue(fissure.sound, {delay = fissure.sound_delay})
					local flip = target.pos.x < this.pos.x

					U.animation_start(this, fissure.animation, flip, store.tick_ts, false)
					if not SU.y_hero_wait(store, this, fissure.cast_time) then
						local fx = E:create_entity(fissure.fx)
						fx.pos = V.vclone(this.pos)
						for _, sprite in pairs(fx.render.sprites) do
							sprite.flip_x = flip
						end
						queue_insert(store, fx)

						local hit_fx = E:create_entity(fissure.hit_fx)
						hit_fx.pos = V.vclone(target.pos)
						queue_insert(store, hit_fx)

						local passive_factor = this.mammoth_lone_wolf_active and this.mammoth_lone_wolf.damage_factor or 1
						local damage = E:create_entity("damage")
						damage.source_id = this.id
						damage.target_id = target.id
						damage.value = math.floor(fissure.damage * fissure.tech_damage_factor * passive_factor)
						damage.damage_type = fissure.damage_type
						queue_damage(store, damage)

						local stun = E:create_entity(fissure.stun_mod)
						stun.modifier.source_id = this.id
						stun.modifier.target_id = target.id
						stun.modifier.duration = fissure.stun_duration
						queue_insert(store, stun)

						local feared = U.find_enemies_in_range(store.entities, this.pos, 0, fissure.fear_range, fissure.vis_flags, fissure.vis_bans)
						if feared then
							for _, enemy in pairs(feared) do
								if enemy.id ~= target.id then
									local mod = E:create_entity(fissure.fear_mod)
									mod.modifier.source_id = this.id
									mod.modifier.target_id = enemy.id
									mod.modifier.level = this.hero.skills.fissure.level
									queue_insert(store, mod)
								end
							end
						end
						SU.y_hero_animation_wait(this)
					end
					goto label_mammoth_end
				end
			end

			if not whirlwind.disabled and whirlwind_hits >= whirlwind.hit_count then
				local targets = U.find_enemies_in_range(store.entities, this.pos, 0, whirlwind.range, whirlwind.vis_flags, whirlwind.vis_bans)

				if targets then
					whirlwind_hits = 0
					SU.hero_gain_xp_from_skill(this, this.hero.skills.whirlwind)
					S:queue(whirlwind.sound, {delay = whirlwind.sound_delay})
					U.animation_start(this, whirlwind.animation, nil, store.tick_ts, false)
					if not SU.y_hero_wait(store, this, whirlwind.cast_time) then
						local passive_factor = this.mammoth_lone_wolf_active and this.mammoth_lone_wolf.damage_factor or 1
						local tech_bonus = whirlwind.damage_bonus * whirlwind.tech_damage_factor
						local scaled_min = (this.mammoth_base_damage_min + tech_bonus) * passive_factor
						local scaled_max = (this.mammoth_base_damage_max + tech_bonus) * passive_factor
						local damage_min = this.mammoth_lone_wolf_active and math.ceil(scaled_min) or math.floor(scaled_min + 0.5)
						local damage_max = this.mammoth_lone_wolf_active and math.ceil(scaled_max) or math.floor(scaled_max + 0.5)

						for _, target in pairs(targets) do
							local damage = E:create_entity("damage")
							damage.source_id = this.id
							damage.target_id = target.id
							damage.value = math.random(damage_min, damage_max)
							damage.damage_type = whirlwind.damage_type
							queue_damage(store, damage)

							local fx = E:create_entity(whirlwind.hit_fx)
							fx.pos = V.vclone(target.pos)
							queue_insert(store, fx)
						end
						SU.y_hero_animation_wait(this)
					end
					goto label_mammoth_end
				end
			end

			brk, sta = y_hero_melee_block_and_attacks(store, this)
			if not brk and sta == A_DONE and not whirlwind.disabled then
				whirlwind_hits = whirlwind_hits + 1
			end

			if not brk and sta == A_NO_TARGET then
				if not SU.soldier_go_back_step(store, this) then
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_mammoth_end::
		coroutine.yield()
	end
end

scripts.controller_mammoth_lone_wolf = {}

function scripts.controller_mammoth_lone_wolf.update(this, store)
	while true do
		local source = store.entities[this.source_id]
		if not source then
			queue_remove(store, this)
			return
		end

		this.pos.x, this.pos.y = source.pos.x, source.pos.y
		this.render.sprites[1].hidden = source.health.dead or not source.mammoth_lone_wolf_active
		coroutine.yield()
	end
end

scripts.controller_mammoth_frenzy = {}

function scripts.controller_mammoth_frenzy.update(this, store)
	local start_ts = store.tick_ts
	local running = false
	local source = store.entities[this.source_id]
	local added_immunity = this.added_immunity or 0

	if source then
		if not this.added_immunity then
			added_immunity = band(this.immunity, bnot(source.health.immune_to))
		end
		source.health.immune_to = bor(source.health.immune_to, this.immunity)
	end

	U.animation_start(this, "start", nil, store.tick_ts, false)
	while store.tick_ts - start_ts < this.duration do
		source = store.entities[this.source_id]
		if not source or source.health.dead then
			break
		end

		this.pos.x, this.pos.y = source.pos.x, source.pos.y
		this.render.sprites[1].flip_x = source.render.sprites[1].flip_x
		if not running and store.tick_ts - start_ts >= 0.25 then
			running = true
			U.animation_start(this, "run", nil, store.tick_ts, true)
		end
		coroutine.yield()
	end

	source = store.entities[this.source_id]
	if source then
		source.health.immune_to = band(source.health.immune_to, bnot(added_immunity))
		source.mammoth_frenzy_active = false
		source.melee.attacks[1].cooldown = this.base_attack_cooldown
	end
	S:queue(this.sound_off)
	U.animation_start(this, "end", nil, store.tick_ts, false)
	U.y_wait(store, 0.3)
	queue_remove(store, this)
end

scripts.mammoth_timed_fx = {}

function scripts.mammoth_timed_fx.update(this, store)
	for i, sprite in ipairs(this.render.sprites) do
		U.animation_start(this, sprite.name, sprite.flip_x, store.tick_ts, sprite.loop, i)
	end

	U.y_wait(store, this.duration)
	queue_remove(store, this)
end

scripts.fx_mammoth_fissure = {}

function scripts.fx_mammoth_fissure.update(this, store)
	U.animation_start(this, "start", nil, store.tick_ts, false, 1)
	U.animation_start(this, "run", nil, store.tick_ts, false, 2)
	U.animation_start(this, "run", nil, store.tick_ts, false, 3)
	U.y_wait(store, 0.2)
	U.animation_start(this, "run", nil, store.tick_ts, true, 1)
	U.y_wait(store, math.max(0, this.duration - 0.4))
	U.animation_start(this, "end", nil, store.tick_ts, false, 1)
	U.y_wait(store, 0.2)
	queue_remove(store, this)
end

scripts.aura_mammoth_legacy = {}

function scripts.aura_mammoth_legacy.update(this, store)
	local source = store.entities[this.source_id]
	if not source then
		queue_remove(store, this)
		return
	end

	local activation_ts = store.tick_ts + this.activation_delay
	while store.tick_ts < activation_ts do
		if not store.entities[this.source_id] or not source.health.dead then
			queue_remove(store, this)
			return
		end
		coroutine.yield()
	end

	S:queue(this.sound)
	mammoth_start_all_sprites(this, "start", false, store.tick_ts)
	U.y_wait(store, 0.25)
	mammoth_start_all_sprites(this, "run", true, store.tick_ts)

	local next_tick = store.tick_ts + this.tick_time
	while source and source.health.dead do
		if store.tick_ts >= next_tick then
			next_tick = next_tick + this.tick_time
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.range, bor(F_AREA, F_BLOCK), bor(F_FLYING, F_CLIFF))

			if targets then
				for _, target in pairs(targets) do
					local damage = E:create_entity("damage")
					damage.source_id = this.source_id
					damage.target_id = target.id
					damage.value = this.damage
					damage.damage_type = this.damage_type
					queue_damage(store, damage)

					local mod = E:create_entity(this.slow_mod)
					mod.modifier.source_id = this.source_id
					mod.modifier.target_id = target.id
					mod.slow.factor = this.slow_factor
					queue_insert(store, mod)
				end
			end
		end

		coroutine.yield()
		source = store.entities[this.source_id]
	end

	mammoth_start_all_sprites(this, "end", false, store.tick_ts)
	U.y_wait(store, 0.3)
	queue_remove(store, this)
end

scripts.controller_hero_mammoth_ultimate = {}

function scripts.controller_hero_mammoth_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.controller_hero_mammoth_ultimate.update(this, store)
	local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true, NF_RALLY)
	if not nodes or #nodes < 1 then
		queue_remove(store, this)
		return
	end

	-- 点击位置只负责选择路径。骨浪始终从该路径的防守端出发，
	-- 再沿中心子路径反向推进到出怪口。
	local pi = nodes[1][1]
	local spi = 1
	local ni = P:get_end_node(pi)
	local start_ni = P:get_start_node(pi)
	local level = this.level or 0
	local damage_value = this.damage[level]
	local last_hit_ts = {}

	S:queue(this.sound)
	while ni >= start_ni do
		local wave_pos = P:node_pos(pi, spi, ni)
		if not wave_pos then
			break
		end

		local fx = E:create_entity(this.wave_fx)
		fx.pos = V.vclone(wave_pos)
		queue_insert(store, fx)

		local targets = U.find_enemies_in_range(store.entities, wave_pos, 0, this.radius, this.damage_flags, this.damage_bans)
		if targets then
			for _, target in pairs(targets) do
				if not last_hit_ts[target.id] or store.tick_ts - last_hit_ts[target.id] >= this.hit_interval then
					last_hit_ts[target.id] = store.tick_ts

					local damage = E:create_entity("damage")
					damage.source_id = this.id
					damage.target_id = target.id
					damage.value = damage_value
					damage.damage_type = this.damage_type
					queue_damage(store, damage)

					local stun = E:create_entity(this.stun_mod)
					stun.modifier.source_id = this.id
					stun.modifier.target_id = target.id
					stun.modifier.duration = this.stun_duration
					queue_insert(store, stun)
				end
			end
		end

		local next_step_ts = store.tick_ts + this.step_delay
		while store.tick_ts < next_step_ts do
			coroutine.yield()
		end
		ni = ni - this.step_distance
	end

	queue_remove(store, this)
end

scripts.hero_isfet = {}

function scripts.hero_isfet.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats
	local s, a

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	if this.melee then
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
	end

	if this.ranged then
		local bt = E:get_template(this.ranged.attacks[1].bullet)

		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]
	end

	s = this.hero.skills.black_cloud
	a = this.timed_attacks.list[1]
	if s.level > 0 then
		a.disabled = false
		local damage_mod = E:get_template("mod_isfet_locust_damage")

		damage_mod.dps.damage_min = s.damage[s.level]
		damage_mod.dps.damage_max = s.damage[s.level]
	end

	s = this.hero.skills.frog_curse
	a = this.timed_attacks.list[2]
	if s.level > 0 then
		a.disabled = false
		a.health_threshold = s.health_threshold[s.level]
	end

	s = this.hero.skills.rain
	a = this.timed_attacks.list[3]
	if s.level > 0 then
		a.disabled = false
		a.count = s.count[s.level]
	end

	s = this.hero.skills.blood_pool
	a = this.timed_attacks.list[4]
	if s.level > 0 then
		a.disabled = false
		a.damage_factor = s.damage_factor[s.level]
		E:get_template(a.entity).aura.level = s.level
		E:get_template(E:get_template(a.entity).aura.mod).received_damage_factor = a.damage_factor
	end

	s = this.hero.skills.ultimate
	local controller = E:get_template(s.controller_name)

	controller.cooldown = s.cooldown[s.level]

	if initial then
		this.health.hp = this.health.hp_max
	end
end

local function isfet_frog_target(this, store, attack)
	if attack.disabled or store.tick_ts - attack.ts < attack.cooldown or not attack.health_threshold then
		return nil
	end

	local targets = U.find_enemies_in_range(store.entities, this.pos, attack.min_range, attack.max_range, attack.vis_flags, attack.vis_bans, function(e)
		return e.health.hp < attack.health_threshold
	end)

	if not targets then
		return nil
	end

	table.sort(targets, function(e1, e2)
		return e1.health.hp > e2.health.hp
	end)

	return targets[1]
end

local function isfet_blood_pool_target(this, store, attack)
	local candidates = U.find_enemies_in_range(store.entities, this.pos, attack.min_range, attack.max_range, attack.vis_flags, attack.vis_bans)

	if not candidates then
		return nil
	end

	local best, best_count

	for _, candidate in pairs(candidates) do
		local crowd = U.find_enemies_in_range(store.entities, candidate.pos, 0, attack.crowd_range, attack.vis_flags, attack.vis_bans)
		local count = crowd and #crowd or 0

		if count >= attack.min_targets and (not best_count or count > best_count) then
			best = candidate
			best_count = count
		end
	end

	return best
end

function scripts.hero_isfet.update(this, store)
	local h = this.health
	local black_cloud_attack = this.timed_attacks.list[1]
	local frog_attack = this.timed_attacks.list[2]
	local rain_attack = this.timed_attacks.list[3]
	local blood_pool_attack = this.timed_attacks.list[4]
	local brk, sta

	local necromancy = E:create_entity("aura_isfet_necromancy")

	necromancy.source_id = this.id
	necromancy.range = this.isfet_necromancy.range
	necromancy.chance = this.isfet_necromancy.chance
	necromancy.max_units = this.isfet_necromancy.max_units
	necromancy.cycle_time = this.isfet_necromancy.cycle_time
	necromancy.entity = this.isfet_necromancy.entity
	queue_insert(store, necromancy)

	this.melee.attacks[1].ts = store.tick_ts
	this.ranged.attacks[1].ts = store.tick_ts
	black_cloud_attack.ts = store.tick_ts
	frog_attack.ts = store.tick_ts
	rain_attack.ts = store.tick_ts
	blood_pool_attack.ts = store.tick_ts

	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
	this.health_bar.hidden = false

	local function cast_frog(target)
		local start_ts = store.tick_ts
		local skill = this.hero.skills.frog_curse

		frog_attack.ts = start_ts
		SU.hero_gain_xp_from_skill(this, skill)
		S:queue(frog_attack.sound)
		U.animation_start(this, frog_attack.animation, target.pos.x < this.pos.x, store.tick_ts, false)
		U.y_wait(store, frog_attack.cast_time)

		local projectile = E:create_entity(frog_attack.projectile)
		local offset = target.pos.x < this.pos.x and V.v(-13, 27) or V.v(13, 27)

		projectile.pos = V.v(this.pos.x + offset.x, this.pos.y + offset.y)
		projectile.source_id = this.id
		projectile.target_id = target.id
		queue_insert(store, projectile)
		SU.y_hero_animation_wait(this)
	end

	-- 普通英雄的移动协程会一直占用到抵达目的地。这里增加青蛙诅咒检查，
	-- 使技能能打断当前一步，施法后再继续原来的移动命令。
	local function y_move_until_frog()
		local rally = this.nav_rally
		local grid = this.nav_grid
		local destination = rally.pos
		local vis_bans = this.vis.bans
		local immune_to = this.health.immune_to

		rally.new = false
		U.unblock_target(store, this)
		S:queue(this.sound_events.change_rally_point)
		this.vis.bans = F_ALL
		this.health.immune_to = rally.immune_to

		while not V.veq(this.pos, destination) do
			local waypoint = table.remove(grid.waypoints, 1) or destination
			local unsnap = #grid.waypoints > 0

			U.set_destination(this, waypoint)
			local animation, flip = U.animation_name_facing_point(this, "walk", this.motion.dest)

			U.animation_start(this, animation, flip, store.tick_ts, true)

			while not this.motion.arrived do
				if h.dead and not h.ignore_damage then
					this.vis.bans = vis_bans
					this.health.immune_to = immune_to
					return "dead"
				end

				if rally.new then
					this.vis.bans = vis_bans
					this.health.immune_to = immune_to
					return "new_rally"
				end

				if isfet_frog_target(this, store, frog_attack) then
					rally.new = true
					this.vis.bans = vis_bans
					this.health.immune_to = immune_to
					return "frog"
				end

				U.walk(this, store.tick_length, nil, unsnap)
				coroutine.yield()
				this.motion.speed.x, this.motion.speed.y = 0, 0
			end
		end

		U.animation_start(this, "idle", nil, store.tick_ts, true)
		this.vis.bans = vis_bans
		this.health.immune_to = immune_to

		return "arrived"
	end

	while true do
		if h.dead then
			--this.render.sprites[3].hidden = true
			SU.y_hero_death_and_respawn(store, this)
			--this.render.sprites[3].hidden = false
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			if SU.hero_level_up(store, this) then
				S:queue("HeroLevelUp")
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			local frog_target = isfet_frog_target(this, store, frog_attack)

			if frog_target then
				cast_frog(frog_target)
				goto label_isfet_end
			end

			if this.nav_rally.new then
				local move_result = y_move_until_frog()

				if move_result == "frog" then
					frog_target = isfet_frog_target(this, store, frog_attack)
					if frog_target then
						cast_frog(frog_target)
					end
				end

				goto label_isfet_end
			end

			-- 1技能：蝗灾
			if not black_cloud_attack.disabled and store.tick_ts - black_cloud_attack.ts >= black_cloud_attack.cooldown then
				local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, black_cloud_attack.trigger_range, black_cloud_attack.vis_flags, black_cloud_attack.vis_bans)

				if not enemies or #enemies < black_cloud_attack.min_targets then
					SU.delay_attack(store, black_cloud_attack, 0.2)
				else
					local start_ts = store.tick_ts
					local skill = this.hero.skills.black_cloud
					local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true, NF_RALLY)
					local cast_flip = false

					if nodes and nodes[1] then
						local pi, spi, ni = unpack(nodes[1])
						local road_pos = P:node_pos(pi, spi, math.max(1, ni - 1))

						cast_flip = road_pos and road_pos.x < this.pos.x or false
					end

					black_cloud_attack.ts = start_ts
					SU.hero_gain_xp_from_skill(this, skill)
					S:queue(black_cloud_attack.sound, {delay = black_cloud_attack.sound_delay})
					U.animation_start(this, black_cloud_attack.animation, cast_flip, store.tick_ts, false)
					if not SU.y_hero_wait(store, this, black_cloud_attack.cast_time) then
						local cloud = E:create_entity(black_cloud_attack.entity)
						local offset = black_cloud_attack.spawn_offset

						cloud.pos = V.v(this.pos.x + (cast_flip and -1 or 1) * offset.x, this.pos.y + offset.y)
						cloud.source_id = this.id
						cloud.aura.level = skill.level
						if nodes and nodes[1] then
							cloud.nav_path.pi, cloud.nav_path.spi, cloud.nav_path.ni = unpack(nodes[1])
						end
						queue_insert(store, cloud)
						SU.y_hero_animation_wait(this)
					end
					goto label_isfet_end
				end
			end

			-- 3技能：炽霜落
			if not rain_attack.disabled and store.tick_ts - rain_attack.ts >= rain_attack.cooldown then
				local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, rain_attack.range, rain_attack.vis_flags, rain_attack.vis_bans)

				if not enemies then
					SU.delay_attack(store, rain_attack, 0.2)
				else
					rain_attack.ts = store.tick_ts
					SU.hero_gain_xp_from_skill(this, this.hero.skills.rain)
					S:queue(rain_attack.sound, {delay = rain_attack.sound_delay})
					U.y_animation_play(this, rain_attack.animation_in, nil, store.tick_ts, 1)
					U.animation_start(this, rain_attack.animation_loop, nil, store.tick_ts, true)

					local controller = E:create_entity(rain_attack.entity)

					controller.pos = V.vclone(this.pos)
					controller.source_id = this.id
					controller.count = rain_attack.count
					queue_insert(store, controller)
					U.y_wait(store, rain_attack.loop_duration)
					U.y_animation_play(this, rain_attack.animation_out, nil, store.tick_ts, 1)
					goto label_isfet_end
				end
			end

			-- 4技能：折磨血池
			if not blood_pool_attack.disabled and store.tick_ts - blood_pool_attack.ts >= blood_pool_attack.cooldown then
				local target = isfet_blood_pool_target(this, store, blood_pool_attack)

				if not target then
					SU.delay_attack(store, blood_pool_attack, 0.2)
				else
					blood_pool_attack.ts = store.tick_ts
					SU.hero_gain_xp_from_skill(this, this.hero.skills.blood_pool)
					S:queue(blood_pool_attack.sound, {delay = blood_pool_attack.sound_delay})
					U.animation_start(this, blood_pool_attack.animation, target.pos.x < this.pos.x, store.tick_ts, false)
					if not SU.y_hero_wait(store, this, blood_pool_attack.cast_time) then
						local pool = E:create_entity(blood_pool_attack.entity)

						pool.pos = V.vclone(target.pos)
						pool.aura.source_id = this.id
						pool.aura.level = this.hero.skills.blood_pool.level
						S:queue(pool.sound)
						queue_insert(store, pool)
						SU.y_hero_animation_wait(this)
					end
					goto label_isfet_end
				end
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if not brk and sta == A_NO_TARGET then
				brk, sta = SU.y_soldier_ranged_attacks(store, this)
				if not brk and not SU.soldier_go_back_step(store, this) then
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
		end

		::label_isfet_end::
		coroutine.yield()
	end
end

scripts.hero_isfet_bolt = {}

function scripts.hero_isfet_bolt.update(this, store)
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
				m.modifier.level = b.level

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

scripts.aura_isfet_necromancy = {}

function scripts.aura_isfet_necromancy.update(this, store)
	local last_ts = store.tick_ts - this.cycle_time

	while true do
		local source = store.entities[this.source_id]

		if not source or source.pending_removal then
			queue_remove(store, this)
			return
		end

		this.pos = source.pos

		if not source.health.dead and store.tick_ts - last_ts >= this.cycle_time then
			last_ts = store.tick_ts
			local mummy_count = 0

			for _, entity in pairs(store.entities) do
				if entity.owner_id == source.id and entity.template_name == this.entity and entity.health and not entity.health.dead then
					mummy_count = mummy_count + 1
				end
			end

			if mummy_count < this.max_units then
				for _, dead in pairs(store.entities) do
					local damage_types = dead.health and dead.health.last_damage_types or 0
					local valid = dead.enemy and dead.health and dead.health.dead and dead.vis and not dead.pending_removal and
						not dead._isfet_necromancy_checked and band(dead.vis.flags, bor(F_FLYING, F_BOSS)) == 0 and
						band(damage_types, bor(DAMAGE_EAT, DAMAGE_NO_SPAWNS)) == 0 and U.is_inside_ellipse(dead.pos, source.pos, this.range)

					if valid then
						dead._isfet_necromancy_checked = true

						if math.random() < this.chance then
							dead.vis.bans = bor(dead.vis.bans, F_SKELETON)
							dead.health.delete_after = 0

							local mummy = E:create_entity(this.entity)

							mummy.pos = V.vclone(dead.pos)
							mummy.default_rally_pos = V.vclone(dead.pos)
							mummy.nav_rally.center = V.vclone(dead.pos)
							mummy.nav_rally.pos = V.vclone(dead.pos)
							mummy.owner_id = source.id
							mummy.health.hp = mummy.health.hp_max
							queue_insert(store, mummy)

							mummy_count = mummy_count + 1
							if mummy_count >= this.max_units then
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

scripts.hero_isfet_mummy = {}

function scripts.hero_isfet_mummy.update(this, store)
	local spawn_ts = store.tick_ts
	local nearest = P:nearest_nodes(this.pos.x, this.pos.y)

	if nearest and nearest[1] then
		this.nav_path.pi, this.nav_path.spi, this.nav_path.ni = unpack(nearest[1])
	end

	this.health_bar.hidden = true
	S:queue(this.spawn_sound, {delay = this.spawn_sound_delay})
	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = false

	while true do
		if not this.health.dead and store.tick_ts - spawn_ts >= this.lifetime then
			this.health.dead = true
			this.health.death_ts = store.tick_ts
		end

		if this.health.dead then
			U.unblock_target(store, this)
			this.health_bar.hidden = true
			this.render.sprites[2].hidden = true
			U.y_animation_play(this, "death", nil, store.tick_ts, 1)
			queue_remove(store, this)
			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			local brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if not brk and sta == A_NO_TARGET then
				local next_pos = this.nav_path.pi and P:next_entity_node(this, store.tick_length)

				if not next_pos or not P:is_node_valid(this.nav_path.pi, this.nav_path.ni) then
					this.health.dead = true
					this.health.death_ts = store.tick_ts
				else
					U.set_destination(this, next_pos)
					local animation, flip = U.animation_name_facing_point(this, "walk", this.motion.dest)

					U.animation_start(this, animation, flip, store.tick_ts, true)
					U.walk(this, store.tick_length)
					this.motion.speed.x, this.motion.speed.y = 0, 0
				end
			end
		end

		coroutine.yield()
	end
end

scripts.aura_isfet_locust_swarm = {}

function scripts.aura_isfet_locust_swarm.update(this, store)
	local start_ts = store.tick_ts

	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)

	local infection = E:create_entity(this.infection_aura)
	infection.aura.source_id = this.id
	infection.aura.level = this.aura.level
	queue_insert(store, infection)

	while store.tick_ts - start_ts < this.aura.duration do
		if this.nav_path.pi then
			local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {this.nav_path.pi}, {this.nav_path.spi})

			if nearest and nearest[1] and nearest[1][3] < this.nav_path.ni then
				this.nav_path.ni = nearest[1][3]
			end

			local next_pos = P:next_entity_node(this, store.tick_length)

			if next_pos and P:is_node_valid(this.nav_path.pi, this.nav_path.ni) then
				U.set_destination(this, next_pos)
				local animation, flip = U.animation_name_facing_point(this, "walk", this.motion.dest)

				U.animation_start(this, animation, flip, store.tick_ts, true)
				U.walk(this, store.tick_length)
				this.motion.speed.x, this.motion.speed.y = 0, 0
			end
		end

		coroutine.yield()
	end

	U.y_animation_play(this, "death", nil, store.tick_ts, 1)
	queue_remove(store, this)
end

scripts.projectile_isfet_frog_curse = {}

function scripts.projectile_isfet_frog_curse.update(this, store)
	local target = store.entities[this.target_id]

	if not target or target.health.dead then
		queue_remove(store, this)
		return
	end

	local start_ts = store.tick_ts
	local from = V.vclone(this.pos)

	while store.tick_ts - start_ts < this.duration do
		target = store.entities[this.target_id]
		if not target or target.health.dead then
			queue_remove(store, this)
			return
		end

		local to = V.v(target.pos.x, target.pos.y + (target.unit and target.unit.hit_offset.y or 0))
		local phase = km.clamp(0, 1, (store.tick_ts - start_ts) / this.duration)

		this.pos.x = from.x + (to.x - from.x) * phase
		this.pos.y = from.y + (to.y - from.y) * phase
		this.render.sprites[1].r = V.angleTo(to.x - from.x, to.y - from.y)
		coroutine.yield()
	end

	target = store.entities[this.target_id]
	if target and not target.health.dead then
		S:queue(this.sound_hit)
		S:queue(this.sound_frog)

		local damage = E:create_entity("damage")

		damage.source_id = this.source_id
		damage.target_id = target.id
		damage.value = target.health.hp_max
		damage.damage_type = DAMAGE_INSTAKILL
		queue_damage(store, damage)

		local smoke = E:create_entity("fx_isfet_frog_smoke")
		smoke.pos = V.vclone(target.pos)
		queue_insert(store, smoke)

		local frog = E:create_entity("decal_isfet_frog")
		frog.pos = V.vclone(target.pos)
		if target.render then
			frog.render.sprites[1].flip_x = target.render.sprites[1].flip_x
		end
		queue_insert(store, frog)
	end

	queue_remove(store, this)
end

scripts.decal_isfet_frog = {}

function scripts.decal_isfet_frog.update(this, store)
	local start_ts = store.tick_ts

	U.animation_start(this, "idle", nil, store.tick_ts, true)
	while store.tick_ts - start_ts < this.lifetime do
		if store.tick_ts - start_ts > this.lifetime * 0.5 and this.render.sprites[1].name ~= "talk" then
			U.animation_start(this, "talk", nil, store.tick_ts, true)
		end
		coroutine.yield()
	end

	U.y_animation_play(this, "death", nil, store.tick_ts, 1)
	queue_remove(store, this)
end

scripts.controller_isfet_fire_ice_rain = {}

function scripts.controller_isfet_fire_ice_rain.update(this, store)
	for i = 1, this.count do
		local angle = math.random() * math.pi * 2
		local radius = math.sqrt(math.random()) * this.radius
		local destination = V.v(this.pos.x + math.cos(angle) * radius, this.pos.y + math.sin(angle) * radius)
		local projectile = E:create_entity(this.projectiles[math.random(1, #this.projectiles)])
		local scale = this.scale_min + math.random() * (this.scale_max - this.scale_min)

		projectile.pos = V.v(destination.x + math.random(-40, 40), destination.y + 120)
		projectile.to = destination
		projectile.source_id = this.source_id
		projectile.render.sprites[1].scale = V.v(scale, scale)
		S:queue(projectile.release_sound)
		queue_insert(store, projectile)
		U.y_wait(store, this.spawn_delay)
	end

	queue_remove(store, this)
end

scripts.projectile_isfet_rain = {}

function scripts.projectile_isfet_rain.update(this, store)
	local start_ts = store.tick_ts
	local from = V.vclone(this.pos)

	this.render.sprites[1].r = V.angleTo(this.to.x - from.x, this.to.y - from.y)
	while store.tick_ts - start_ts < this.flight_time do
		local phase = km.clamp(0, 1, (store.tick_ts - start_ts) / this.flight_time)

		this.pos.x = from.x + (this.to.x - from.x) * phase
		this.pos.y = from.y + (this.to.y - from.y) * phase
		coroutine.yield()
	end

	this.pos = V.vclone(this.to)
	S:queue(this.hit_sound)
	local fx = E:create_entity(this.hit_fx)
	fx.pos = V.vclone(this.to)
	queue_insert(store, fx)

	local targets = U.find_enemies_in_range(store.entities, this.to, 0, this.damage_radius, this.vis_flags, this.vis_bans)
	if targets then
		for _, target in pairs(targets) do
			local damage = E:create_entity("damage")

			damage.source_id = this.source_id
			damage.target_id = target.id
			damage.value = this.damage
			damage.damage_type = this.damage_type
			damage.xp_dest_id = this.source_id
			queue_damage(store, damage)

			local mod = E:create_entity(this.mod)
			mod.modifier.source_id = this.source_id
			mod.modifier.target_id = target.id
			mod.modifier.level = 1
			queue_insert(store, mod)
		end
	end

	queue_remove(store, this)
end

scripts.controller_hero_isfet_ultimate = {}

function scripts.controller_hero_isfet_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

function scripts.controller_hero_isfet_ultimate.update(this, store)
	local level = this.level or 0
	local damage_value = this.damage[level]
	local ticks = math.floor(this.duration / this.tick_time + 0.5)

	S:queue(this.sound)
	U.y_animation_play(this, "in", nil, store.tick_ts, 1)
	U.animation_start(this, "run", nil, store.tick_ts, true)

	local slow_aura = E:create_entity(this.slow_aura)
	slow_aura.aura.source_id = this.id
	queue_insert(store, slow_aura)

	local start_ts = store.tick_ts
	for tick = 1, ticks do
		while store.tick_ts < start_ts + tick * this.tick_time do
			coroutine.yield()
		end

		local cloud_targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.cloud_radius, this.damage_flags, this.damage_bans)
		local impact_pos

		if cloud_targets then
			impact_pos = V.vclone(cloud_targets[math.random(1, #cloud_targets)].pos)
		else
			local angle = math.random() * math.pi * 2
			local radius = math.sqrt(math.random()) * this.cloud_radius

			impact_pos = V.v(this.pos.x + math.cos(angle) * radius, this.pos.y + math.sin(angle) * radius)
		end

		local lightning = E:create_entity(this.lightning_fx)
		lightning.pos = V.v(impact_pos.x, impact_pos.y + this.lightning_origin_y)
		queue_insert(store, lightning)

		local hit_fx = E:create_entity(this.lightning_hit_fx)
		hit_fx.pos = V.v(impact_pos.x, impact_pos.y + this.lightning_destination_y)
		queue_insert(store, hit_fx)

		local damaged_targets = U.find_enemies_in_range(store.entities, impact_pos, 0, this.damage_radius, this.damage_flags, this.damage_bans)
		if damaged_targets then
			for _, target in pairs(damaged_targets) do
				local damage = E:create_entity("damage")

				damage.source_id = this.id
				damage.target_id = target.id
				damage.value = damage_value
				damage.damage_type = this.damage_type
				queue_damage(store, damage)
			end
		end
	end

	U.y_animation_play(this, "out", nil, store.tick_ts, 1)
	queue_remove(store, this)
end

--卢塞尔娜

scripts.hero_lucerna = {}

--[[
function scripts.hero_lucerna.get_info(this)
	local m = E:get_template("bullet_lucerna")
	local min, max = m.bullet.damage_min, m.bullet.damage_max

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		damage_type = DAMAGE_MAGICAL,
		armor = this.health.armor,
		magic_armor = this.health.magic_armor,
		respawn = this.health.dead_lifetime
	}
end
]]
function scripts.hero_lucerna.get_info(this)
	local t = scripts.hero_basic.get_info_ranged(this)
	local m = E:get_template(this.ranged.attacks[1].bullet)
    	t.ranged_damage_max = m.bullet.damage_max * this.unit.damage_factor
		t.ranged_damage_min = m.bullet.damage_min * this.unit.damage_factor
		t.ranged_damage_type = m.bullet.damage_type
		t.damage_max = 0
		t.damage_min = 0
		t.damage_type = m.bullet.damage_type

	return t
end

function scripts.hero_lucerna.insert(this, store)
	this.hero.fn_level_up(this, store, true)
	S:queue("HeroPaladinTauntIntro")
	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_lucerna.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.health.magic_armor = ls.magic_armor[hl]

	local b = E:get_template(this.ranged.attacks[1].bullet)
	b.bullet.damage_min = ls.ranged_damage_min[hl]
	b.bullet.damage_max = ls.ranged_damage_max[hl]

	--1技能 恐惧
	s = this.hero.skills.scurvy_vissage
	if initial and s.level > 0 then
		this.timed_attacks.list[3].disabled = nil
		e1 = E:get_template(this.timed_attacks.list[3].entity)
		e2 = E:get_template(this.timed_attacks.list[3].damage_entity)
		e1.modifier.duration = s.duration[s.level]
		e2.modifier.duration = s.damage_duration[s.level]
	end

	--2技能 弹幕
	s = this.hero.skills.fire_at_will
	if initial and s.level > 0 then
		this.timed_attacks.list[2].disabled = nil
		e = E:get_template(this.timed_attacks.list[2].entity)
		e.bullet.damage_min = s.damage_config[s.level]
		e.bullet.damage_max = s.damage_config[s.level]
	end

	--3技能 召唤
	s = this.hero.skills.damned_crew
	if initial and s.level > 0 then
		this.timed_attacks.list[1].disabled = nil
		this.timed_attacks.list[1].cooldown = s.cooldown[s.level]
	end
	
	--4技能 普攻增强
	s = this.hero.skills.pirates_pillage
	if initial and s.level > 0 then
		local b = E:get_template(this.ranged.attacks[1].bullet)
		b.bullet.pirates_pillage_rate = s.rate[s.level]
	end

	--5技能 大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template(s.controller_name)
		u.cooldown = s.cooldown[s.level]
		
		local e = E:get_template(u.entity)
		e.level = s.level

	end


end

function scripts.hero_lucerna.update(this, store, script)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts

	local ranged_attack = this.ranged.attacks[1] --普攻
	local golem_attack = this.timed_attacks.list[1] --召唤
	local ability_attack = this.timed_attacks.list[2] --弹幕
	local fear_attack = this.timed_attacks.list[3] --恐惧
	local ultimate_ts = 0
	local ultimate_auto = false
	if this.template_name == "hero_lucerna_2" then
		ultimate_auto = true
	end

	local attack, skill
	ranged_attack.ts = 0--store.tick_ts
	golem_attack.ts = 0--store.tick_ts
	ability_attack.ts = 0--store.tick_ts
	fear_attack.ts = 0--store.tick_ts

	U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
	this.health_bar.hidden = false
	force_idle_ts = true

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			--需要移除mod
			SU.y_hero_new_rally(store, this)
			local mods = table.filter(store.entities, function(_, e)
				return e.modifier and e.modifier.source_id == this.id
			end)

			for _, m in pairs(mods) do
				queue_remove(store, m)
			end
		end

		if SU.hero_level_up(store, this) then
			--U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			U.animation_start_group(this, "levelup", nil, store.tick_ts, false, "layers")
		end

		--1技能 恐惧
		local a = fear_attack
		local skill = this.hero.skills.scurvy_vissage
		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local start_ts, bdy, bdt, au
			local fired_aura = false
			local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not targets then
				SU.delay_attack(store, a, 0.2)
			else
				a.ts = store.tick_ts
				U.animation_start_group(this, "fear", nil, store.tick_ts, false, "layers")

				local fx = E:create_entity(a.lucerna_animation)
				fx.pos = V.v(this.pos.x, this.pos.y)
				fx.render.sprites[1].ts = store.tick_ts
				queue_insert(store, fx)

				S:queue(a.sound)
				U.y_wait(store, a.cast_time)
				for _, e in pairs(targets) do
					local mod = E:create_entity(a.entity)
					mod.modifier.target_id = e.id
					mod.modifier.source_id = this.id
					mod.modifier.level = skill.level
					queue_insert(store, mod)

					local mod2 = E:create_entity(a.damage_entity)
					mod2.modifier.target_id = e.id
					mod2.modifier.source_id = this.id
					mod2.modifier.level = skill.level
					queue_insert(store, mod2)
					
				end
				U.y_animation_wait(this, 1)
				SU.hero_gain_xp_from_skill(this, skill)
				U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
				--goto label_32530_1
			end
		end

		--2技能 轰炸
		a = this.timed_attacks.list[2]
		skill = this.hero.skills.fire_at_will
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
					U.animation_start_group(this, "ability", nil, store.tick_ts, false, "layers")
					--skeleton_glow_fx()
					U.y_wait(store, a.spawn_time)

					local delay = 0
					local n_step = ni < s_ni and -2 or 2

					ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

					for i = 1, skill.count[skill.level] do
						local e = E:create_entity(a.entity)

						e.pos = P:node_pos(pi, spi, ni)
						e.bullet.from = V.vclone(e.pos)
						e.bullet.to = V.vclone(e.pos)
						--e.render.sprites[1].prefix = e.render.sprites[1].prefix
						e.render.sprites[1].flip_x = not flip
						e.delay = delay
						e.bullet.source_id = this.id
						e.bullet.level = this.hero.skills.fire_at_will.level

						queue_insert(store, e)

						delay = delay + fts(U.frandom(1, 3))
						ni = ni + n_step
						spi = km.zmod(spi + math.random(1, 2), 3)
					end

					U.y_animation_wait(this)

					force_idle_ts = true
					a.ts = store.tick_ts

					SU.hero_gain_xp_from_skill(this, skill)
					U.animation_start_group(this, "idle", nil, store.tick_ts, true, "layers")
					--goto label_32530_1
				end
			end

		end

		--3技能
		a = this.timed_attacks.list[1]
		skill = this.hero.skills.damned_crew

		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range * 1.5, a.vis_flags, a.vis_bans, function(v)
				local offset = P:predict_enemy_node_advance(v, a.spawn_time)
				local ppos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + offset)

				return P:is_node_valid(v.nav_path.pi, v.nav_path.ni + offset, NF_RALLY) and GR:cell_is_only(ppos.x, ppos.y, TERRAIN_LAND)
			end)
			local spawn_pos

			if target then
				local offset = P:predict_enemy_node_advance(target, a.spawn_time)

				spawn_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + offset)
			else
				--local positions = P:get_all_valid_pos(this.pos.x, this.pos.y, a.min_range, a.max_range, TERRAIN_LAND, nil, NF_RALLY)

				--spawn_pos = table.random(positions)
			end

			if not spawn_pos then
				SU.delay_attack(store, a, 0.4)
			else
				S:queue(a.sound)
				U.animation_start_group(this, "summon", nil, store.tick_ts, false, "layers")
				--skeleton_glow_fx()
				U.y_wait(store, a.spawn_time)

				local offset_spawn_pos = {{0,-20},{-20,10},{20,10}}
				for i = 1, 2 do
					local e = E:create_entity(a.entity)

					spawn_pos.x = spawn_pos.x + offset_spawn_pos[i][1]
					spawn_pos.y = spawn_pos.y + offset_spawn_pos[i][2]
					e.pos = V.vclone(spawn_pos)
					e.nav_rally.pos = V.vclone(spawn_pos)
					e.nav_rally.center = V.vclone(spawn_pos)
					e.render.sprites[1].flip_x = math.random() < 0.5

					queue_insert(store, e)

					e.owner = this

					U.y_animation_wait(this)
				end

				force_idle_ts = true
				a.ts = store.tick_ts

				SU.hero_gain_xp_from_skill(this, skill)

				--goto label_32530_1
			end
		end

		--大招
		if ultimate_auto and store.tick_ts - ultimate_ts > 48 then
			targets = U.find_enemies_in_range(store.entities, this.pos, 0, 150, fear_attack.vis_flags, fear_attack.vis_bans)
			if targets and #targets >= 2 then
				e = E:create_entity("totem_lucerna")
				e.pos = V.vclone(this.pos) 
				queue_insert(store, e)
			end
			ultimate_ts = store.tick_ts
		end

		--普攻/hit_payload
		local a = ranged_attack
		--普攻，直接沿用2代骨龙
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
				--local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans, function(v)
				local target = ULH.find_first_enemy(store.entities, this.pos, 0, a.max_range, false, a.vis_flags, a.vis_bans, function(v)
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

					--U.animation_start(this, an, af, store.tick_ts)
					U.animation_start_group(this, an, af, store.tick_ts, false, "layers")

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
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
					--b.bullet.to = V.v(t_pos.x + (af and -1 or 1) * math.random(20, 80), t_pos.y + math.random(10, 40))
					b.bullet.to = V.v(t_pos.x, t_pos.y)
					if i == 2 then
						local nearest_node = P:nearest_nodes(t_pos.x, t_pos.y, nil, nil, false)[1]
						local pi, spi, ni = unpack(nearest_node)
						local npos = P:node_pos(pi, spi, ni)
						b.bullet.to = npos
					end
					
					--print("damage radius"..b.bullet.damage_radius)
					--b.bullet.damage_radius = 20 + 20 * this.hero.skills.explosion.level

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_32530_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_32530_0::

					--goto label_32530_1
				end
			end
		end

		::label_32530_1::

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)
		force_idle_ts = nil
		
		coroutine.yield()
	end

end

scripts.missile_lucerna = {}

function scripts.missile_lucerna.insert(this, store, script)
	local b = this.bullet
	local ps = E:create_entity(b.particles_name)

	ps.particle_system.track_id = this.id

	queue_insert(store, ps)

	return true
end

function scripts.missile_lucerna.update(this, store, script)
	local b = this.bullet
	local target = store.entities[b.target_id]
	local mspeed = b.min_speed
	local rot_dir = 1
	local follow = false
	local max_seek_angle = b.max_seek_angle or 0.38 --b.max_seek_angle or 0.2

	if this.render.sprites[1].animated then
		U.animation_start(this, "flying", nil, store.tick_ts, -1)
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		if b.rot_dir_from_long_angle and target then
			rot_dir = target.pos.x < this.pos.x and -1 or 1
		elseif b.speed.x < 0 then
			rot_dir = -1
		end

		coroutine.yield()
	end

	if not target or target.health and target.health.dead then
		local ref_pos = target and target.pos or this.pos

		target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
		--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
	end

	if target then
		b.to.x, b.to.y = target.pos.x, target.pos.y

		if target.unit.hit_offset then
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length * 5 do
		if not target or target.health and target.health.dead or band(target.vis.bans, b.vis_flags) ~= 0 then
			local ref_pos = target and target.pos or this.pos

			--target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
			target = ULH.find_first_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags, b.vis_bans)
			if b.rot_dir_from_long_angle and target then
				rot_dir = target.pos.x < this.pos.x and -1 or 1
			end
		end

		if target then
			b.to.x, b.to.y = target.pos.x, target.pos.y

			if target.unit.hit_offset then
				b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
			end
		end

		local d_angle = V.angleTo(b.speed.x, b.speed.y, b.to.x - this.pos.x, b.to.y - this.pos.y)

		if max_seek_angle < math.abs(d_angle) then
			local rot = b.turn_speed * store.tick_length * rot_dir
			local dir = V.angleTo(b.speed.x, b.speed.y)

			if dir > math.pi / 3 and dir < 2 * math.pi / 3 then
				rot = rot * (b.turn_helicoidal_factor or 1.5)
			end

			b.speed.x, b.speed.y = V.rotate(rot, b.speed.x, b.speed.y)
		else
			mspeed = mspeed + 30 * math.ceil(mspeed * 0.03333333333333333 * b.acceleration_factor)
			mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
			b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		end

		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		coroutine.yield()
	end

	if b.damage_radius and b.damage_radius > 0 then
		local enemies = table.filter(store.entities, function(k, v)
			return v.enemy and v.vis and v.unit and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(V.v(v.pos.x + v.unit.hit_offset.x, v.pos.y + v.unit.hit_offset.y), b.to, b.damage_radius)
		end)
		local alchemical_powder = UP:get_upgrade("engineer_alchemical_powder")
		local alchemical_powder_on = alchemical_powder and math.random() < alchemical_powder.chance
		local shock_and_awe = nil -- = UP:get_upgrade("engineer_shock_and_awe")

		for _, enemy in pairs(enemies) do
			local enemy_pos = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			local d = E:create_entity("damage")
			d.xp_dest_id = b.source_id
			d.source_id = this.id
			d.target_id = enemy.id
			d.damage_type = b.damage_type
			d.reduce_armor = b.reduce_armor
			d.reduce_magic_armor = b.reduce_magic_armor

			--每命中一个敌人，有一定几率奖励金币
			if math.random() < b.pirates_pillage_rate then
				signal.emit("got-gold", V.vclone(enemy.pos) or V.v(0,0), b.got_gold)
			end

			if alchemical_powder_on then
				d.value = b.damage_max
			else
				local dist_factor = U.dist_factor_inside_ellipse(enemy_pos, this.pos, b.damage_radius)

				d.value = math.floor(b.damage_max - (b.damage_max - b.damage_min) * dist_factor)
			end
			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end

			if shock_and_awe and band(enemy.vis.bans, F_STUN) == 0 and band(enemy.vis.flags, bor(F_BOSS, F_CLIFF, F_FLYING)) == 0 and math.random() < shock_and_awe.chance then
				local mod = E:create_entity("mod_shock_and_awe")

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end
		end
	elseif target then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = target.id

			queue_insert(store, mod)
		end
	end

	local fx

	if b.hit_fx_air and target and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = b.hit_fx_air

		S:queue(this.sound_events.hit)
	elseif b.hit_fx_water and not target and band(GR:cell_type(b.to.x, b.to.y), TERRAIN_WATER) ~= 0 then
		fx = b.hit_fx_water

		S:queue(this.sound_events.hit_water)
	elseif b.hit_fx then
		fx = b.hit_fx

		S:queue(this.sound_events.hit)
	end

	if fx then
		local is_air = target and band(target.vis.flags, F_FLYING) ~= 0
		local sfx = E:create_entity(fx)

		if b.hit_fx_ignore_hit_offset and target and not is_air then
			sfx.pos.x, sfx.pos.y = target.pos.x, target.pos.y
		else
			sfx.pos.x, sfx.pos.y = this.pos.x, this.pos.y
		end

		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

--卢塞尔娜大招
scripts.controller_lucerna_ultimate = {}
function scripts.controller_lucerna_ultimate.can_fire_fn(this, x, y)
	return GR:cell_is_only(x, y, TERRAIN_LAND) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

scripts.lucerna_ultimate = {}
function scripts.lucerna_ultimate.update(this, store)
	e = E:create_entity(this.entity)
	e.pos = V.v(this.pos.x, this.pos.y) 
	queue_insert(store,e)
end


scripts.totem_lucerna = {}
function scripts.totem_lucerna.update(this, store)
	local a2 = this.attacks.list[1]
	this.tick_ts = store.tick_ts
	a2.ts = store.tick_ts
	local start_ts = store.tick_ts
	--每个怪物只能被选中一次,瞄准后需要
	local selected_id_table = {}
	U.animation_start(this, "spawn", nil, store.tick_ts, false, 2)
	S:queue(this.sound_events.sound_in)
	U.y_wait(store, fts(15))
	this.render.sprites[1].hidden = false

	U.animation_start(this, "run", nil, store.tick_ts, true, 1)
	U.animation_start(this, "idle", nil, store.tick_ts, true, 2)

	while true do
		if store.tick_ts - start_ts > this.duration then
			break
		else
			if store.tick_ts - a2.ts >= a2.cooldown then
				local target = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, a2.range, a2.node_prediction, a2.vis_flags, a2.vis_bans, function(e)
					return e.nav_path and e.melee and not U.has_modifiers(store, e, "mod_possession") and not U.has_modifiers(store, e, "mod_possession_lucerna") and (not a2.excluded_templates or not table.contains(a2.excluded_templates, e.template_name)) and not table.contains(selected_id_table, e.id)
				end)
				if not target then
					SU.delay_attack(store, a2, 0.1)
				else
					local start_ts = store.tick_ts
					local targetPos = V.vclone(target.pos)
					U.animation_start(this, a2.animation, nil, store.tick_ts, false, 2)
					local start_offset = a2.bullet_start_offset[1]
					local fx = E:create_entity(a2.bullet[1])
					fx.pos = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
					fx.render.sprites[1].ts = store.tick_ts
					queue_insert(store, fx)
					U.y_wait(store, a2.shoot_time)
					if target.health.dead then
						local newTarget = ULH.find_strongest_enemy_in_range(store.entities, tpos(this), 0, a2.range, a2.node_prediction, a2.vis_flags, a2.vis_bans, function(e)
							return e.nav_path and e.melee and not U.has_modifiers(store, e, "mod_possession") and not U.has_modifiers(store, e, "mod_possession_lucerna") and (not a2.excluded_templates or not table.contains(a2.excluded_templates, e.template_name)) and not table.contains(selected_id_table, e.id)
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
					b.bullet.level = this.level
					if target then
						b.bullet.target_id = target.id
						table.insert(selected_id_table, target.id)
					end
					queue_insert(store, b)
					a2.ts = start_ts
					U.y_animation_wait(this, 2)
					U.animation_start(this, "idle", nil, store.tick_ts,true, 2)
				end
			end
		end
		coroutine.yield()
	end

	

	U.animation_start(this, "death", nil, store.tick_ts, false, 2)
	this.render.sprites[1].hidden = true
	S:queue(this.sound_events.sound_out)
	U.y_wait(store, fts(18))
	this.render.sprites[2].hidden = true

end

--卢塞尔娜3技能
scripts.soldier_golem_lucerna = {}
function scripts.soldier_golem_lucerna.update(this, store, script)
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

	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)

	if not this.health.dead then
		this.health_bar.hidden = nil
	end

	U.y_animation_play(this, "idle", nil, store.tick_ts, 1)

	

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
			U.y_animation_play(this, "death", nil, store.tick_ts, 1)
			U.y_wait(store,fts(21))
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

					goto label_2806_0
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

		::label_2806_0::

		coroutine.yield()
	end
	U.y_animation_play(this, "death", nil, store.tick_ts, 1)
	U.y_wait(store,fts(21))

end

return scripts
