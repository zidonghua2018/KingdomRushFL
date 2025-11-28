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
local SU = require("script_utils")
local U = require("utils")
local LU = require("level_utils")
local game_gui = require("game_gui")
require("game_gui")
require("klove.kui")
local UP = require("upgrades")
local V = require("klua.vector")
local W = require("wave_db")
local bit = require("bit")
local storage = require("storage")
local GSC = require("game_scripts")
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

local function tpos(e)
	return e.tower and e.tower.range_offset and V.v(e.pos.x + e.tower.range_offset.x, e.pos.y + e.tower.range_offset.y) or
	e.pos
end

scripts.a_hero = {
	on_damage = function(this, store, damage)
		local h = this.health
		local da = damage
		local pd = U.predict_damage(this, damage)

		if band(da.damage_type, bor(DAMAGE_EAT)) ~= 0 then
			return true
		end
		this.brave_max_times = this.brave_max_times or 1
		if not this.brave_times then
			this.brave_times = this.brave_max_times
		end
		if this.brave_times and this.brave_times > 0 and pd >= h.hp then
			this.brave_times = this.brave_times - 1
			h.hp = 1
			if this.brave_heal then
				h.hp = this.brave_heal
				local m = E:create_entity("mod_shaman_heal")
				m.modifier.target_id = this.id
				m.modifier.source_id = this.id
				m.hps.heal_min = 0
				m.hps.heal_max = 0
				if this.unit.size and m.render.sprites[1].size_names then
					m.render.sprites[1].name = m.render.sprites[1].size_names[this.unit.size]
				end
				queue_insert(store, m)
			end
			if this.brave_mod then
				local m = E:create_entity(this.brave_mod)
				m.modifier.target_id = this.id
				m.modifier.source_id = this.id
				queue_insert(store, m)
			end
			if this.brave_heal_factor then
				h.hp = h.hp_max * this.brave_heal_factor
			end
			if this.brave_hp_inc then
				h.hp_max = h.hp_max + this.brave_hp_inc
			end
			h.hp = km.clamp(0, h.hp_max, h.hp)
			return false
		end

		if this.brave_times and this.brave_times <= 0 and pd >= h.hp then
			this.brave_times = nil
		end

		return true
	end,
	insert = function(this, store)
		if this.auras then
			local aura = {}
			for i = 1, #this.auras.list do
				::again::
				aura[i] = E:create_entity(this.auras.list[i].name)
				aura[i].aura.source_id = this.id
				aura[i].pos = this.pos
				queue_insert(store, aura[i])
				if not aura[i] then
					goto again
				end
			end
		end
		this.health_bar.hidden = false
		if this.render.sprites[1] then
			this.render.sprites[1].fps = this.render.sprites[1].fps or FPS
			this.render.sprites[1].alpha = this.render.sprites[1].alpha or 255
		end
		this.melee.order = U.attack_order(this.melee.attacks)
		this.nav_rally.pos = this.nav_rally.pos or V.vclone(this.pos)
		this.nav_rally.center = this.nav_rally.center or V.vclone(this.pos)
		this.health.dead_lifetime = this.health.dead_lifetime or 3

		return true
	end,
	update = function(this, store, script)
		local h = this.health
		local he = this.hero
		local brk, sta = nil
		local idle_cooldown = this.idle_flip.cooldown or 3
		local idle_chance = this.idle_flip.chance or 0.5
		local idle_ts = store.tick_ts

		this.health_bar.hidden = false
		this.melee.order = U.attack_order(this.melee.attacks)


		while true do
			::loop::
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, -1)
				SU.soldier_idle(store, this)
				coroutine.yield()
			else
				::rally::
				if this.nav_rally.new then
					SU.y_hero_new_rally(store, this)
				else
					--nothing
				end
				::net::
				if this.nav_rally.new then
					goto rally
				end
				if h.dead or this.unit.is_stunned then
					goto loop
				end
				if this.melee then
					brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

					if sta == A_IN_COOLDOWN and U.animation_finished(this) then
						U.animation_start(this, "idle", nil, store.tick_ts, true)
					end
					if sta ~= A_NO_TARGET then
						coroutine.yield()
						goto net
					else
						coroutine.yield()
						goto out
					end
				end
				::out::
				if SU.soldier_go_back_step(store, this) then
					coroutine.yield()
					SU.soldier_go_back_step(store, this)
					this.motion.change = true
					goto net
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
					if idle_cooldown < store.tick_ts - idle_ts then
						if math.random() < idle_chance then
							this.render.sprites[1].flip_x = not this.render.sprites[1].flip_x
						end
						idle_ts = store.tick_ts
					end
					this.motion.change = nil
					coroutine.yield()
				end
			end
		end
	end
}

scripts.a_dwarf = {
	update = function(this, store)
		local function no_hero_can()
			if store.level.locked_hero then
				return false
			end
			return store.selected_hero
		end
		if this.hero_insert and no_hero_can() then
			local hero = LU.insert_hero(store, this.template_name, this.nav_rally.pos)
			hero.hero_insert = false
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		elseif this.hero_insert then
			local so = E:create_entity(this.template_name)
			so.pos = this.nav_rally.pos
			so.hero_insert = false
			so.nav_rally.pos = V.vclone(this.nav_rally.pos)
			so.nav_rally.center = V.vclone(so.nav_rally.pos)
			queue_insert(store, so)
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		end
		if this.cheat_game_2 then
			store.player_gold = store.player_gold + 6666
			storage:load_slot().gems = storage:load_slot().gems + 99
			signal.emit("show-gems-reward", this, 99)
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		end
		if this.cheat_game_3 then
			store.lives = 999
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		end
		if this.cheat_game_4 then
			for _, e in pairs(store.entities) do
				if e.enemy and e.nav_path then
					e.motion.max_speed = 0
				end
			end
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		end
		if this.cheat_game_5 then
			for _, e in pairs(store.entities) do
				if e.soldier and e.nav_rally then
					e.health.armor = 0.8
					e.health.damage_factor = 0.5
				end
			end
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		end
		if this.cheat_game_6 then
			for _, e in pairs(store.entities) do
				if e.enemy and e.nav_path then
					local d = E:create_entity("damage")
					d.damage_type = DAMAGE_INSTAKILL
					d.target_id = e.id
					queue_damage(store, d)
				end
			end
			queue_remove(store, this)
			return
		end
		if this.cheat_game_7 then
			for _, e in pairs(store.entities) do
				if e.enemy and e.nav_path then
					e.health.armor = 0
					e.health.damage_factor = 2
				end
			end
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		end
		if this.cheat_game then
			LU.kill_all_enemies(store, true)
			game.store.force_next_wave = true
			U.sprites_hide(this)
			queue_remove(store, this)
			return
		end
		::twice::
		if this.auras then
			local aura = {}
			for i = 1, #this.auras.list do
				::again::
				aura[i] = E:create_entity(this.auras.list[i].name)
				aura[i].aura.source_id = this.id
				aura[i].pos = this.pos
				queue_insert(store, aura[i])
				if not aura[i] then
					goto again
				end
			end
			return scripts.a_hero.update(this, store, script)
		else
			return scripts.a_hero.update(this, store, script)
		end
	end
}

scripts.tower_buy_soldiers = {
	get_info = function (this)
	return {
				type = STATS_TYPE_TEXT,
				desc = _((this.info.i18n_key or string.upper(this.template_name)) .. "_DESCRIPTION")
			}
	end,
	can_select_point = function (this, x, y, store)

		return P:valid_node_nearby(x, y) and GR:cell_is(x, y, bor(TERRAIN_ALL_MASK))

	end,
	update = function (this, store)
		local sell_id = 9
		local us = this.user_selection
		local a = this.attacks
		local tow = this.tower
		local us_args = {}
		local us_poses = {}

local function set_attacks()

		if this.ui and this.ui.args == "tower_level_up" then
			tow.level = tow.level + 1
			this.ui.args = nil
			if this == game_gui.selected_entity then
				game_gui:deselect_entity()
			end
		end
				if us and us.arg and us.new_pos then
					table.insert(us_args, us.arg)
					table.insert(us_poses, us.new_pos)
					us.new_pos = nil
					us.arg = nil
				end
			end
local function cast_attacks(arg, rpos)

	if us then
			
				if arg and rpos then
				local aa = a.list
				local group = nil
				local rx = rpos.x
				local ry = rpos.y
					if aa[arg] and aa[arg].entities then
					local fx = E:create_entity("fx_bullet_rod_dragon_fire_hit")
					fx.render.sprites[1].ts = store.tick_ts
					fx.pos = V.vclone(rpos)

					queue_insert(store, fx)
					store.player_gold = store.player_gold -  aa[arg].price
						for _, so in pairs(aa[arg].entities) do
						so.chance = so.chance or so[1] or 1
						so.soldiers = so.soldiers or so[2]
						so.fx_list = so.fx_list or so[3]
						so.auras = so.auras or so[4]
						so.offsets = so.offsets or nil
						so.func = so.func or nil
						so.func_clicks = so.func_clicks or nil

						if so.func and so.func (this, store, rx, ry) then
						--nothing
						elseif so.func then
						goto finish
						end
							if (not so.chance or so.chance == 1 or math.random() < so.chance) then
							group = so
							break
							end
							::finish::
						end

					local so = group
					if group then
								if so.func_clicks then
									if so.can_func_clicks then
										if so.func_clicks (this, store, rx, ry) then
										so.can_func_clicks = nil
										goto more
										else
										goto more
										end
									end
									so.can_func_clicks = true
								end
							if so.soldiers then
								local num = #so.soldiers
								local center = nil
								if so.soldiers[#so.soldiers] == center then
									num = num - 1
									center = true
								end
								for i = 1, num do
									local sr = so.soldiers[i]
									local s = E:create_entity(sr)
									s.nav_rally.center = V.vclone(rpos)
									s.nav_rally.pos = V.vclone(rpos)
									if so.offsets then
										s.nav_rally.pos.x = s.nav_rally.pos.x + so.offsets[km.zmod(i, #so.offsets)].x
										s.nav_rally.pos.y = s.nav_rally.pos.y + so.offsets[km.zmod(i, #so.offsets)].y
										if center then
											s.nav_rally.center.x = s.nav_rally.pos.x
											s.nav_rally.center.y = s.nav_rally.pos.y
										end
									end
									s.nav_rally.new = true
									s.pos = V.vclone(s.nav_rally.pos)
									-- if store.main_hero then
										-- s.info.ultimate_icon = store.main_hero.info.ultimate_icon
									-- elseif s.info.ultimate_icon then
										-- s.info.ultimate_icon = "0017"
									-- end
									queue_insert(store, s)

									local result = game_gui.getPrivateVar()
									if #result < 2 then
										signal.emit("hero-added", s)
									end
									-- print(string.format("(%s) %s", result, #result))
									-- game_gui:add_hero(s)
									-- signal.emit("hero-added", s)
								end
								-- for i = 1, num do
									-- local sr = so.soldiers[i]
									-- local hero = LU.insert_hero(store, sr, rpos)
								-- end
							end
							if so.fx_list then
								for i = 1, #so.fx_list do
								local sr = so.fx_list[i]
									local s = E:create_entity(sr)
									s.pos = V.vclone(rpos)
									s.render.sprites[1].ts = store.tick_ts
									if so.offsets then
									s.pos.x = s.pos.x + so.offsets[km.zmod(i, #so.offsets)].x
									s.pos.y = s.pos.y + so.offsets[km.zmod(i, #so.offsets)].y
									end
									queue_insert(store, s)
									end
								end
							if so.auras then
							local num = #so.auras
							local source = nil
							if so.auras[#so.auras] == true then
							num = num - 1
							source = true
							end
								for i = 1, num do
								local sr = so.auras[i]
									local s = E:create_entity(sr)
									s.pos = V.vclone(rpos)
									if s.render.sprites[1] then
									s.render.sprites[1].ts = store.tick_ts
									end
									if so.offsets then
									s.pos.x = s.pos.x + so.offsets[km.zmod(i, #so.offsets)].x
									s.pos.y = s.pos.y + so.offsets[km.zmod(i, #so.offsets)].y
									end
									local target = U.find_entity_at_pos(store.entities, s.pos.x, s.pos.y, function (e)
									return e.unit and e.health and (e.soldier or e.enemy) and (e.nav_rally or e.nav_path)
									end)
									if target and s.aura and source then
									s.aura.source_id = target.id
									end
									queue_insert(store, s)
									end
								end
::more::
							end
						end
					end
				end
			end

		while true do
		
		if us then
			set_attacks()
			if #us_args > 0 and #us_poses > 0 then
			for i = 1, #us_args do
				cast_attacks(us_args[i], us_poses[i])
				us_args[i] = nil
				us_poses[i] = nil
			end
			end
		end

			coroutine.yield()
		end
	end
}

-- 死亡生成怪物
scripts.mod_dark_spitters99 = {}

function scripts.mod_dark_spitters99.update(this, store)
	local m = this.modifier
	local dps = this.dps
	local target, generation

	while store.tick_ts - m.ts < m.duration do
		target = store.entities[m.target_id]

		if not target then
			break
		end

		this.pos = target.pos

		if this.render and m.use_mod_offset and target.unit.mod_offset then
			local flip_sign = target.render.sprites[1].flip_x and -1 or 1

			this.render.sprites[1].offset.x = target.unit.mod_offset.x * flip_sign
			this.render.sprites[1].offset.y = target.unit.mod_offset.y
		end

		if target.health.dead then
			coroutine.yield()
			coroutine.yield()

			if target.hero or not target.health.dead or target.reinforcement and target.reinforcement.hp_before_timeout then
				break
			end

			if this.excluded_templates and table.contains(this.excluded_templates, target.template_name) then
				break
			end

			U.sprites_hide(target)
			SU.insert_sprite(store, this.explode_fx, target.pos)

			local nodes = P:nearest_nodes(target.pos.x, target.pos.y, nil, nil, true, NF_RALLY)

			if #nodes < 1 then
				log.error("(%s) mod_dark_spitters: could not find valid node nearby to spawn enemy. %s,%s", this.id, target.pos.x, target.pos.y)

				break
			end

			local pi, spi, ni = nodes[1][1], nodes[1][2], nodes[1][3]

			if P:nodes_to_defend_point(pi, spi, ni) < this.nodes_limit then
				break
			end

			local e = E:create_entity(this.spawn_entity)
			local n = e.nav_path

			e.pos.x, e.pos.y = target.pos.x, target.pos.y
			n.pi, n.spi, n.ni = pi, spi, ni + 2
			e.render.sprites[1].name = "raise"
			e.enemy.gold = 0
			e.enemy.gold_bag = 0
			e.enemy.gems = 0

			queue_insert(store, e)

			break
		end

		if store.tick_ts - dps.ts >= dps.damage_every then
			dps.ts = store.tick_ts

			local d = E:create_entity("damage")

			d.source_id = this.id
			d.target_id = target.id
			d.value = dps.damage_max
			d.damage_type = dps.damage_type

			queue_damage(store, d)
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end
--同上
scripts.mod_drider_poison99 = {}

function scripts.mod_drider_poison99.update(this, store)
	local m = this.modifier
	local dps = this.dps
	local target
	local source = store.entities[m.source_id]
	local generation = source and source.generation + 1 or 1

	while store.tick_ts - m.ts < m.duration do
		target = store.entities[m.target_id]

		if not target then
			break
		end

		this.pos = target.pos

		if this.render and m.use_mod_offset and target.unit.mod_offset then
			this.render.sprites[1].offset.x, this.render.sprites[1].offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
		end

		if target.health.dead then
			coroutine.yield()
			coroutine.yield()

			if target.hero or not target.health.dead or target.reinforcement and target.reinforcement.hp_before_timeout then
				break
			end

			if this.excluded_templates and table.contains(this.excluded_templates, target.template_name) then
				break
			end

			local ec = E:create_entity("decal_drider_clone")

			ec.render = table.deepclone(target.render)
			ec.pos.x, ec.pos.y = target.pos.x, target.pos.y

			queue_insert(store, ec)
			coroutine.yield()
			U.sprites_hide(target)

			local e = E:create_entity("decal_drider_cocoon")
			local se = e.render.sprites[1]

			e.pos.x, e.pos.y = target.pos.x, target.pos.y - 1
			se.flip_x = ec.render.sprites[1].flip_x
			se.scale = se.size_scales[target.unit.size]
			e.generation = generation

			queue_insert(store, e)

			break
		end

		if store.tick_ts - dps.ts >= dps.damage_every then
			dps.ts = store.tick_ts

			local d = E:create_entity("damage")

			d.source_id = this.id
			d.target_id = target.id
			d.value = dps.damage_max
			d.damage_type = dps.damage_type

			queue_damage(store, d)
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.hero_wilbur_ultimate99 = {
	update = function (this, store)
		for i, o in ipairs(this.spawn_offsets) do
			local e = E:create_entity(this.entity)
			e.pos.y = this.pos.y + o.y
			e.pos.x = this.pos.x + o.x
			e.spawn_index = i
			e.nav_rally.center = V.vclone(e.pos)
			e.nav_rally.pos = V.vclone(e.pos)

			queue_insert(store, e)
		end

		queue_remove(store, this)

		return 
	end
}
--伊利丹大招问题
scripts.hero_elves_archer_ultimate99 = {
	update = function (this, store)
		local function spawn_arrow(pi,ni)
			-- spi = spi or math.random(1, 3)
			local b = E:create_entity(this.bullet)
			local pos = this.pos
			pos.x = pos.x + pi
			pos.y = pos.y + ni
			b.bullet.damage_max = 60
			b.bullet.damage_min = 60
			b.bullet.from = V.v(pos.x + math.random(-170, -140), pos.y + REF_H)
			b.bullet.to = pos
			b.pos = V.vclone(b.bullet.from)

			queue_insert(store, b)

			return 
		end

		local nearest = P:nearest_nodes(this.pos.x, this.pos.y)
		if 0 < #nearest then
			local count = 5
			for i = 1, count, 1 do
				local spi = 4*i-12
				spawn_arrow(spi,-8)
				U.y_wait(store, 0.1)
				spawn_arrow(spi,-4)
				U.y_wait(store, 0.1)
				spawn_arrow(spi,0)
				U.y_wait(store, 0.1)
				spawn_arrow(spi,4)
				U.y_wait(store, 0.1)
				spawn_arrow(spi,8)
				U.y_wait(store, 0.1)
			end
		end

		queue_remove(store, this)

		return 
	end
}
--浮士德与飞机伤害类型显示问题
scripts.hero_faustus99 = {
	get_info = function (this)
		local m = E:get_template("bolt_faustus_2")
		local min = m.bullet.damage_min*3
		local max = m.bullet.damage_max*3

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
}
scripts.hero_wilbur99 = {
	get_info = function (this)
		local m = E:get_template("shot_wilbur_2")
		local min = m.bullet.damage_min*3
		local max = m.bullet.damage_max*3

		return {
			type = STATS_TYPE_SOLDIER,
			hp = this.health.hp,
			hp_max = this.health.hp_max,
			damage_min = min,
			damage_max = max,
			damage_type = m.bullet.damage_type,
			damage_icon = this.info.damage_icon,
			armor = this.health.armor,
			respawn = this.health.dead_lifetime
		}
	end
}
--侏儒塔售卖后侏儒不消失
scripts.tower_pixie99 = {}
function scripts.tower_pixie99.remove(this, store)
	if this.pixies then
		for _, e in pairs(this.pixies) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end
function scripts.tower_pixie99.update(this, store)
	local a = this.attacks
	this.pixies = {}
	a.ts = store.tick_ts

	local pow_c = this.powers.cream
	local pow_t = this.powers.total
	local enemy_cooldowns = {}

	local function spawn_pixie()
		local e = E:create_entity("decal_pixie")
		local po = pow_c.idle_offsets[#this.pixies + 1]

		e.idle_pos = po
		e.pos.x, e.pos.y = this.pos.x + po.x, this.pos.y + po.y

		queue_insert(store, e)
		table.insert(this.pixies, e)

		e.owner = this
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
--仙女龙塔售卖后仙女龙不消失
scripts.tower_faerie_dragon99 = {}
function scripts.tower_faerie_dragon99.remove(this, store)
	if this.dragons then
		for _, e in pairs(this.dragons) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_faerie_dragon99.update(this, store)
	local a = this.attacks.list[1]
	local pow_m = this.powers.more_dragons
	local pow_i = this.powers.improve_shot
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
--海盗瞭望塔售卖后鹦鹉不消失
scripts.tower_pirate_watchtower99 = {}
function scripts.tower_pirate_watchtower99.remove(this, store)
	if this.parrots then
		for _, e in pairs(this.parrots) do
			e.owner = nil

			queue_remove(store, e)
		end
	end

	return true
end
function scripts.tower_pirate_watchtower99.update(this, store)
	local at = this.attacks
	local a = this.attacks.list[1]
	local pow_c = this.powers.reduce_cooldown
	local pow_p = this.powers.parrot
	local shooter_sid = 3
	local last_target_pos = V.v(0, 0)
	this.parrots = {}

	while true do
		if this.tower.blocked then
			-- block empty
		else
			if pow_c.changed then
				pow_c.changed = nil
				a.cooldown = pow_c.values[pow_c.level]
			end

			if pow_p.changed and #this.parrots < 2 then
				pow_p.changed = nil

				local e = E:create_entity("pirate_watchtower_parrot")

				e.bombs_pos = V.v(this.pos.x + 12, this.pos.y + 6)
				e.idle_pos = V.v(this.pos.x + (#this.parrots == 0 and -20 or 20), this.pos.y)
				e.pos = V.vclone(e.idle_pos)
				
				queue_insert(store, e)
				table.insert(this.parrots, e)
				e.owner = this
				if pow_p.level == 2 and #this.parrots < 2 then
					local e = E:create_entity("pirate_watchtower_parrot")
					e.bombs_pos = V.v(this.pos.x + 12, this.pos.y + 6)
					e.idle_pos = V.v(this.pos.x + (#this.parrots == 0 and -20 or 20), this.pos.y)
					e.pos = V.vclone(e.idle_pos)
					e.owner = this
					queue_insert(store, e)
					table.insert(this.parrots, e)
				end
			end

			if store.tick_ts - a.ts > a.cooldown then
				local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, a.node_prediction, a.vis_flags, a.vis_bans)

				if not enemy then
					-- block empty
				else
					last_target_pos.x, last_target_pos.y = enemy.pos.x, enemy.pos.y
					a.ts = store.tick_ts

					local start_offset = a.bullet_start_offset[1]
					local an, af = U.animation_name_facing_point(this, a.animation, enemy.pos, shooter_sid, start_offset)

					U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)

					while store.tick_ts - a.ts < a.shoot_time do
						coroutine.yield()
					end

					local b1 = E:create_entity(a.bullet)

					b1.pos.x, b1.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
					b1.bullet.damage_factor = this.tower.damage_factor
					b1.bullet.from = V.vclone(b1.pos)
					b1.bullet.to = pred_pos
					b1.bullet.target_id = enemy.id
					b1.bullet.source_id = this.id

					queue_insert(store, b1)
--
					local u = UP:get_upgrade("archer_twin_shot")

					if u and math.random() < u.chance then
						b2 = E:clone_entity(b1)
--						b2.bullet.flight_time = b2.bullet.flight_time - 1 / FPS

						queue_insert(store, b2)

--						b1.bullet.flight_time = b1.bullet.flight_time + 1 / FPS
					end
--
					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end

					an, af = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid, start_offset)

					U.animation_start(this, an, af, store.tick_ts, true, shooter_sid)
				end
			end
		end

		coroutine.yield()
	end
end

--迪纳斯国王buff导致蓝屏
scripts.mod_denas_tower99 = {}
function scripts.mod_denas_tower99.insert(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower or (this.excluded_templates and table.contains(this.excluded_templates, target.template_name)) then
		log.error("error inserting mod_denas_tower %s", this.id)

		return false
	end

	if this.range_factor then
		target.attacks.range = target.attacks.range * this.range_factor
	end

	if this.cooldown_factor and target.attacks.list[1] and target.attacks.list[1].cooldown then
		target.attacks.list[1].cooldown = target.attacks.list[1].cooldown * this.cooldown_factor

		if target.attacks.min_cooldown then
			target.attacks.min_cooldown = target.attacks.min_cooldown * this.cooldown_factor
		end
	end

	if this.render then
		for i = 1, #this.render.sprites do
			local s = this.render.sprites[i]

			s.ts = store.tick_ts
		end
	end

	return true
end
--海盗炮大炮贴图动画去除
scripts.tower_pirate_camp99 = {}
function scripts.tower_pirate_camp99.update(this, store, script)

	local sign_cannon = this.render.sprites[3]
	local sign_tap_the_road = this.render.sprites[4]
	local sign_cannon_last_ts = store.tick_ts
	local pirate_drink_ts = store.tick_ts
	local pirate_drink_time = math.random(fts(100), fts(300))

	local function add_bullet(id, dest)
		local a = this.attacks.list[1]
		local b = E:create_entity("bomb_pirate_camp")

		b.pos = V.v(dest.x + U.random_sign() * math.random(a.min_error, a.max_error), dest.y + U.random_sign() * math.random(a.min_error, a.max_error))
		b.bullet.to = b.pos

		queue_insert(store, b)
	end

	while true do
		if pirate_drink_time < store.tick_ts - pirate_drink_ts then
			U.animation_start(this, "drink", nil, store.tick_ts, false, 5)

			pirate_drink_ts = store.tick_ts
		end

		if store.tick_ts - sign_cannon_last_ts > 10 then
			sign_cannon_last_ts = store.tick_ts
			sign_cannon.ts = store.tick_ts
			sign_cannon.hidden = false
		end

		if this.user_selection.menu_shown or this.user_selection.in_progress then
			sign_cannon_last_ts = store.tick_ts + 10
			sign_cannon.hidden = true
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

		end

		coroutine.yield()
	end
end
--黑龙售卖后无法消失
scripts.tower_black_baby_dragon99 = {}
function scripts.tower_black_baby_dragon99.remove(this, store)
	if this.black_baby_dragon then
		for _, e in pairs(this.black_baby_dragon) do
			e.owner = nil
			queue_remove(store, e)
		end
	end

	return true
end
function scripts.tower_black_baby_dragon99.update(this, store)
	this.black_baby_dragon = {}
	local e = E:create_entity("decal_black_baby_dragon_d")

	e.pos.x, e.pos.y = this.pos.x, this.pos.y
	e.sleep_pos = V.vclone(e.pos)

	queue_insert(store, e)
	table.insert(this.black_baby_dragon, e)
	e.owner = this

	while true do
		this.ui.can_select = not e.attack_requested

		if this.user_selection.arg and not e.attack_requested then
			this.user_selection.arg = nil

			local attack = this.attacks.list[1]

			store.player_gold = store.player_gold - attack.price
			e.attack_requested = true
		end

		coroutine.yield()
	end
end
--英雄技能无法在冰面释放
scripts.hero_elves_denas_ultimate99 = {}
function scripts.hero_elves_denas_ultimate99.can_fire_fn(this, x, y)
	return P:valid_node_nearby(x, y, nil, NF_RALLY) and GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE))
end

scripts.hero_arivan_ultimate99 = {}
function scripts.hero_arivan_ultimate99.can_fire_fn(this, x, y)
	return P:valid_node_nearby(x, y, nil, NF_TWISTER) and GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE))
end

scripts.hero_rag_ultimate99 = {}
function scripts.hero_rag_ultimate99.can_fire_fn(this, x, y, store)
	if not P:valid_node_nearby(x, y, nil, NF_RALLY) or not GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) then
		return false
	end

	local targets = U.find_enemies_in_range(store.entities, V.v(x, y), 0, this.range, this.vis_flags, this.vis_bans, function(e)
		return GR:cell_is_only(e.pos.x, e.pos.y, bor(TERRAIN_LAND, TERRAIN_ICE))
	end)

	return targets ~= nil
end

scripts.hero_veznan_ultimate99 = {}
function scripts.hero_veznan_ultimate99.can_fire_fn(this, x, y, store)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

scripts.hero_bruce_ultimate99 = {}
function scripts.hero_bruce_ultimate99.can_fire_fn(this, x, y, store)
	return GR:cell_is_only(x, y, bor(TERRAIN_LAND, TERRAIN_ICE)) and P:valid_node_nearby(x, y, nil, NF_RALLY)
end

--巨灵导致游戏卡死
scripts.spell_djinn99 = {}
function scripts.spell_djinn99.insert(this, store, script)
	local target = store.entities[this.spell.target_id]

	if not target or band(target.vis.bans, F_POLYMORPH) ~= 0 or target.health.dead then
		return false
	end

	local d = E:create_entity("damage")

	--d.damage_type = DAMAGE_EAT
	d.damage_type = bor(DAMAGE_EAT, DAMAGE_NO_LIFESTEAL)
	d.source_id = this.id
	d.target_id = target.id

	queue_damage(store, d)

	--target.vis.bans = F_POLYMORPH
	target.vis.bans = F_ALL

	local fx = E:create_entity(this.fx_options[math.random(1, #this.fx_options)])

	fx.pos = V.vclone(target.pos)
	fx.render.sprites[1].ts = store.tick_ts

	queue_insert(store, fx)

	fx = E:create_entity("fx")
	fx.pos = V.vclone(target.pos)
	fx.render.sprites[1].ts = store.tick_ts
	fx.render.sprites[1].draw_order = 2
	fx.render.sprites[1].name = "fx_djinn_smoke"

	queue_insert(store, fx)
	AC:inc_check("STUFFOMAKER", 1)
	queue_remove(store, this)

	return true
end
-- 巨蟹无法在冰面行走
scripts.hero_crab99 = {}
function scripts.hero_crab99.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

	local s

	s = this.hero.skills.battlehardened

	if initial and s.level > 0 then
		this.invuln.disabled = nil
		this.invuln.chance = s.chance[s.level]
	end

	s = this.hero.skills.pincerattack

	if initial and s.level > 0 then
		local pa = this.timed_attacks.list[1]

		pa.disabled = nil
		pa.damage_min = s.damage_min[s.level]
		pa.damage_max = s.damage_max[s.level]
	end

	s = this.hero.skills.shouldercannon

	if initial and s.level > 0 then
		local a = this.ranged.attacks[1]

		a.disabled = nil

		local b = E:get_template("crab_water_bomb")

		b.bullet.damage_max = s.damage[s.level]
		b.bullet.damage_min = s.damage[s.level]

		local m = E:get_template("mod_slow_water_bomb")

		m.modifier.duration = s.slow_duration[s.level]
		m.slow.factor = s.slow_factor[s.level]
	end

	s = this.hero.skills.burrow

	if initial and s.level > 0 then
		this.burrow.disabled = nil
		this.burrow.extra_speed = s.extra_speed[s.level]
		this.burrow.damage_radius = s.damage_radius[s.level]
		this.nav_grid.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER, TERRAIN_SHALLOW, TERRAIN_ICE)
	end

	s = this.hero.skills.hookedclaw

	if initial and s.level > 0 then
		local pa = this.timed_attacks.list[1]

		if not pa.disabled then
			pa.damage_min = pa.damage_min + s.extra_damage[s.level]
			pa.damage_max = pa.damage_max + s.extra_damage[s.level]
		end
	end

	if s.level > 0 then
		this.melee.attacks[1].damage_min = this.melee.attacks[1].damage_min + s.extra_damage[s.level]
		this.melee.attacks[1].damage_max = this.melee.attacks[1].damage_max + s.extra_damage[s.level]
	end

	this.health.hp = this.health.hp_max
end
--黑女巫能把恶魔变青蛙
scripts.mod_witch_frog99 = {}
function scripts.mod_witch_frog99.update(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.health or target.health.dead then
		queue_remove(store, this)

		return
	end

	local damage_type = (target.hero or table.contains(m.excluded_templates, target.template_name)) and m.hero_damage_type or m.damage_type

	if band(target.health.immune_to, damage_type) ~= 0 then
		queue_remove(store, this)

		return
	end

	local d = E:create_entity("damage")

	d.damage_type = (target.hero or table.contains(m.excluded_templates, target.template_name)) and m.hero_damage_type or m.damage_type
	d.value = math.random(m.damage_min, m.damage_max)
	d.source_id = m.source_id
	d.target_id = target.id

	queue_damage(store, d)

	if target.hero or table.contains(m.excluded_templates, target.template_name) then
		queue_remove(store, this)

		return
	end

	U.y_wait(store, this.frog_delay)

	local af = target.render.sprites[1].flip_x
	local t = this.tween
	local t_end = t.props[1].keys[2]

	this.render.sprites[1].flip_x = af
	this.render.sprites[1].hidden = false

	U.y_wait(store, this.fx_delay + this.animation_delay - this.frog_delay)
	U.animation_start(this, "jump", nil, store.tick_ts, true)

	t_end[2].x = t_end[2].x * (af and -1 or 1)
	t.disabled = false
	t.ts = store.tick_ts

	U.y_wait(store, t_end[1])
	U.y_animation_wait(this)
	U.animation_start(this, "idle", nil, store.tick_ts, true)
	U.y_wait(store, this.animation_delay)
	U.y_animation_play(this, "puff", nil, store.tick_ts, 1)
	queue_remove(store, this)
end

--德鲁伊巨熊bug
scripts.druid_shooter_nature99 = {}

function scripts.druid_shooter_nature99.update(this, store)
	local b = this.owner.barrack
	local a = this.attacks.list[1]
	local formation_offset = U.frandom(math.pi / 4, 2 * math.pi / 5)
	local soldier_added = false

	a.ts = store.tick_ts

	while true do
		if this.owner.tower.blocked or not this.owner.tower.can_do_magic then
			-- block empty
		else
			soldier_added = false

			for i = 1, b.max_soldiers do
				local s = b.soldiers[i]

				if not s or s.health.dead and not store.entities[s.id] then
					U.animation_start(this, a.animation, nil, store.tick_ts)
					U.y_wait(store, a.spawn_time)

					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.owner
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, formation_offset)
					s.pos = V.vclone(s.nav_rally.pos)
					s.nav_rally.new = true

					queue_insert(store, s)

					b.soldiers[i] = s

					--signal.emit("tower-spawn", this, s)

					soldier_added = true
				end
			end

			if soldier_added then
				soldier_added = false

				for _, s in pairs(b.soldiers) do
					s.nav_rally.new = true
				end
			end

			if b.rally_new then
				formation_offset = U.frandom(math.pi / 4, 2 * math.pi / 5)
				b.rally_new = false

				signal.emit("rally-point-changed", this)

				local all_dead = true

				for i, s in pairs(b.soldiers) do
					local s = b.soldiers[i]

					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, formation_offset)
					s.nav_rally.new = true
					all_dead = all_dead and s.health.dead
				end

				if not all_dead then
					S:queue(this.owner.sound_events.change_rally_point)
				end
			end
		end

		coroutine.yield()
	end
end
--蜘蛛吐丝导致逐光者卡主bug
scripts.enemy_webspitting_spider99 = {
	update = function (this, store, script)
		local a = this.timed_attacks.list[1]
		a.ts = store.tick_ts

		local function ready_to_cast()
			if store.tick_ts - a.ts <= a.cooldown then
				return false
			end

			for _, id in pairs(this.enemy.blockers) do
				local target = store.entities[id]

				if target and U.flags_pass(target.vis, a) and not target.unit.is_stunned and (not (a.excluded_templates and table.contains(a.excluded_templates, target.template_name))) then
					return true
				end
			end

			return false
		end

		while true do
			if this.health.dead then
				SU.y_enemy_death(store, this)

				return 
			end

			if this.unit.is_stunned then
				SU.y_enemy_stun(store, this)
			else
				local cont, blocker = SU.y_enemy_walk_until_blocked(store, this, false)

				if (cont or false) and blocker and (SU.y_wait_for_blocker(store, this, blocker) or false) then
					while SU.can_melee_blocker(store, this, blocker) do
						if not SU.y_enemy_melee_attacks(store, this, blocker) then
							break
						end

						if ready_to_cast() then
							a.ts = store.tick_ts

							U.animation_start(this, a.animation, nil, store.tick_ts, false)

							if SU.y_enemy_wait(store, this, a.cast_time) then
								break
							end

							local targets_hit = {}

							for _, id in pairs(this.enemy.blockers) do
								local target = store.entities[id]

								if target and (not (a.excluded_templates and table.contains(a.excluded_templates, target.template_name))) and U.flags_pass(target.vis, a) and not target.unit.is_stunned and (not target.dodge or not SU.unit_dodges(store, target, false, a, this)) then
									local m = E:create_entity(a.mod)
									m.modifier.source_id = this.id
									m.modifier.target_id = target.id

									queue_insert(store, m)
									table.insert(targets_hit, target)
								end
							end

							U.y_animation_wait(this)

							a.ts = store.tick_ts

							for _, e in pairs(targets_hit) do
								U.unblock_target(store, e)
							end

							break
						end

						coroutine.yield()
					end
				end
			end

			coroutine.yield()
		end

		return 
	end
}
--禁忌实验室伤害显示
scripts.tower_frankenstein99 = {}
function scripts.tower_frankenstein99.get_info(this)
	local l = this.powers.lightning.level
	local m = E:get_template("mod_ray_frankenstein")
	local min, max = m.dps.damage_min + l * m.dps.damage_inc, m.dps.damage_max + l * m.dps.damage_inc

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown

	if this.attacks and this.attacks.list[1].cooldown then
		cooldown = this.attacks.list[1].cooldown
	end

	return {
		type = STATS_TYPE_TOWER_MAGE,
		damage_icon = this.info.damage_icon,
		damage_min = min,
		damage_max = max,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

--3代小公主召唤在水上会蓝屏
scripts.hero_alleria99 = {}
function scripts.hero_alleria99.update(this, store)
	local h = this.health
	local he = this.hero
	local brk, sta, a, skill

	local function find_cat_pos(pos)
		local nodes = P:nearest_nodes(pos.x, pos.y, nil, nil, true, NF_RALLY)

		if #nodes < 1 then
			log.error("cannot insert alleria cat. no valid nodes near %s,%s", pos.x, pos.y)

			return nil
		end

		local n = nodes[1]

		if not P:is_node_valid(n[1], n[3] - 5) then
			return nil
		end

		local npos = P:node_pos(n[1], n[2], n[3] - 5)

		if band(GR:cell_type(npos.x, npos.y), bor(TERRAIN_CLIFF, TERRAIN_NOWALK)) ~= 0 then
			return nil
		end

		return npos
	end

	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	local cat = E:create_entity("alleria_cat")

	cat.owner = this

	if this.fixed_mode then
		cat.pos = this.cat_pos
		cat.fixed_mode = true
	else
		cat.pos = find_cat_pos(this.pos)
	end

	cat.nav_rally.center = pos
	cat.nav_rally.pos = pos
	cat.render.sprites[1].z = this.render.sprites[1].z

	queue_insert(store, cat)

	while true do
		if this.fixed_mode then
			brk, sta = SU.y_soldier_ranged_attacks(store, this)

			if brk then
				-- block empty
			else
				SU.soldier_idle(store, this)
			end
		else
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					local cat_pos = find_cat_pos(this.nav_rally.pos)

					if cat_pos then
						cat.nav_rally.center = cat_pos
						cat.nav_rally.pos = cat_pos
						cat.nav_rally.new = true
					end

					if SU.y_hero_new_rally(store, this) then
						goto label_212_0
					end
				end

				if this.melee then
					brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

					if brk or sta ~= A_NO_TARGET then
						goto label_212_0
					end
				end

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

		::label_212_0::

		coroutine.yield()
	end
end

--卡兹传送导致的贴图问题
scripts.mod_minotaur_daedalus99 = {
	queue = function (this, store, insertion)
		local target = store.entities[this.modifier.target_id]

		if not target then
			return 
		end

		if insertion then
			if U.flags_pass(target.vis, this.modifier) then
				this._target_prev_bans = target.vis.bans
				target.vis.bans = F_ALL
				target.health.ignore_damage = true

				SU.stun_inc(target)

				local s = this.render.sprites[1]
				local m = this.modifier

				if s.size_names then
					s.prefix = s.prefix .. "_" .. s.size_names[target.unit.size]
				end

				if s.size_anchor then
					s.anchor = s.size_anchors[target.unit.size]
				end

				if m.custom_offsets then
					s.offset = m.custom_offsets[target.template_name] or m.custom_offsets.default
				elseif m.use_mod_offset and target.unit.mod_offset then
					s.offset.y = target.unit.mod_offset.y
					s.offset.x = target.unit.mod_offset.x
				end
			end
		else
			SU.stun_dec(target)

			if this._target_prev_bans then
				target.vis.bans = this._target_prev_bans
				-- target.vis._bans = nil
				target.health.ignore_damage = true
			end
		end

		return 
	end,
	dequeue = function (this, store, insertion)
		local target = store.entities[this.modifier.target_id]

		if not target then
			return 
		end

		if insertion then
			if this._target_prev_bans then
				target.vis.bans = this._target_prev_bans
			end
		end

		return 
	end,
	insert = function (this, store)
		local target = store.entities[this.modifier.target_id]

		if target and target.health and not target.health.dead and this._target_prev_bans ~= nil then
			target.health.ignore_damage = true

			SU.stun_inc(target)

			return true
		else
			return false
		end

		return 
	end,
	remove = function (this, store)
		local target = store.entities[this.modifier.target_id]

		if target then
			target.health.ignore_damage = false

			SU.stun_dec(target)
		end

		return true
	end,
	update = function (this, store)
		local m = this.modifier
		local target = store.entities[m.target_id]

		if not target or not target.health or target.health.dead then
			queue_remove(store, this)

			return 
		end

		local fx = E:create_entity("decal_minotaur_daedalus")
		fx.pos = V.vclone(target.pos)
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
		U.y_wait(store, 0.5)

		local es = E:create_entity("daedalus_enemy_decal")
		es.pos.y = target.pos.y
		es.pos.x = target.pos.x
		es.render = table.deepclone(target.render)
		es.tween.ts = store.tick_ts

		queue_insert(store, es)
		coroutine.yield()
		U.sprites_hide(target)

		target.health_bar.hidden = true

		U.y_wait(store, 0.5)

		target.nav_path.pi = this.dest_pi
		target.nav_path.spi = this.dest_spi
		target.nav_path.ni = this.dest_ni
		local pos = P:node_pos(target.nav_path)
		target.pos.y = pos.y
		target.pos.x = pos.x
		es.pos = V.vclone(pos)
		this.pos = V.vclone(pos)
		es.tween.reverse = true
		es.tween.ts = store.tick_ts
		fx = E:create_entity("decal_minotaur_daedalus")
		fx.pos = V.vclone(target.pos)
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
		U.y_wait(store, 0.5)
		queue_remove(store, es)
		U.sprites_show(target)

		target.health_bar.hidden = nil
		target.health.ignore_damage = nil

		-- if target.vis._bans then
		-- 	target.vis.bans = target.vis._bans
		-- 	target.vis._bans = nil
		-- end
		if this._target_prev_bans then
			target.vis.bans = this._target_prev_bans
			-- target.vis._bans = nil
			-- target.health.ignore_damage = true
		end

		local s = this.render.sprites[1]
		s.hidden = nil
		s.flip_x = target.render.sprites[1].flip_x
		m.ts = store.tick_ts

		while store.tick_ts - m.ts < m.duration and target and target.health and not target.health.dead do
			coroutine.yield()
		end

		queue_remove(store, this)

		return 
	end
}
-- 特斯拉连锁问题
scripts.ray_tesla99 = {}

function scripts.ray_tesla99.update(this, store)
	local b = this.bullet
	local s = this.render.sprites[1]
	local target = store.entities[b.target_id]
	local source = store.entities[b.source_id]
	local dest = b.to
	local l_src, l_dst = V.vclone(this.pos), V.vclone(b.to)

	s.scale = V.v(1, 1)

	local function update_sprite()
		if target and target.motion then
			dest.x, dest.y = target.pos.x, target.pos.y

			if target.unit and target.unit.hit_offset then
				dest.x, dest.y = dest.x + target.unit.hit_offset.x, dest.y + target.unit.hit_offset.y
			end
		end

		if source and source.motion then
			this.pos.x, this.pos.y = source.pos.x, source.pos.y

			if source.unit and source.unit.hit_offset then
				this.pos.x, this.pos.y = this.pos.x + source.unit.hit_offset.x, this.pos.y + source.unit.hit_offset.y
			end
		end

		local dsrc = math.max(math.abs(this.pos.x - l_src.x), math.abs(this.pos.y - l_src.y))
		local ddst = math.max(math.abs(dest.x - l_dst.x), math.abs(dest.y - l_dst.y))

		if dsrc > b.max_track_distance or ddst > b.max_track_distance*1.33 then
			log.paranoid("(%s) ray_tesla jumped out of max_track_distance", this.id)

			s.hidden = true
			target = nil

			return false
		end

		l_src.x, l_src.y = this.pos.x, this.pos.y
		l_dst.x, l_dst.y = dest.x, dest.y

		local angle = V.angleTo(dest.x - this.pos.x, dest.y - this.pos.y)

		s.r = angle
		s.scale.x = V.dist(dest.x, dest.y, this.pos.x, this.pos.y) / this.image_width
		s.scale.y = 0.4 + km.clamp(0, 0.6, s.scale.x * 0.6)
		s.scale.y = s.scale.y * this.bounce_scale_y

		return true
	end

	if target then
		if U.flag_has(target.vis.flags, F_FLYING) then
			this.bounce_range = this.bounce_range + 10
		end

		s.ts = store.tick_ts

		local l_bounce_start = V.vclone(target.pos)

		if not update_sprite() then
			-- block empty
		else
			if not this.excluded_templates or not table.contains(this.excluded_templates, target.template_name) then
				local mod = E:create_entity(b.mod)
				local bounce_factor = UP:get_upgrade("engineer_efficiency") and 1 or this.bounce_damage_factor
				local damage_factor = b.damage_factor
				local total_damage = math.floor(math.random(this.bounce_damage_min * damage_factor, this.bounce_damage_max * damage_factor) * bounce_factor)
				local actual_damage = math.min(total_damage, target.health.hp)
				local last_damage = total_damage - actual_damage
				local frame_damage = math.floor(actual_damage / mod.dps.cocos_frames)
				local mod_damage = frame_damage * mod.dps.cocos_cycles
				local dps_hits = math.floor(mod.modifier.duration / mod.dps.damage_every)
				local dps_damage = math.floor(mod_damage / dps_hits)
				local first_damage = mod_damage - dps_damage * dps_hits
				
				mod.modifier.level = b.level
				mod.modifier.source_id = b.source_id
				mod.modifier.target_id = target.id
				mod.dps.damage_max = dps_damage
				mod.dps.damage_min = dps_damage
				mod.dps.damage_last = last_damage
				mod.dps.damage_first = dps_damage + first_damage
				--print("tesla damage:"..mod.dps.damage_first.." "..mod.dps.damage_last.." ".." "..mod_damage.." "..dps_hits)
				queue_insert(store, mod)
			end

			table.insert(this.seen_targets, target.id)

			if not this.bounces then
				this.bounces = this.bounces_lvl[b.level]
			end

			if this.bounces > 0 then
				U.y_wait(store, this.bounce_delay)

				local bounce_target = U.find_nearest_enemy(store.entities, l_bounce_start, 0, this.bounce_range, this.bounce_vis_flags, this.bounce_vis_bans, function(v)
					return not table.contains(this.seen_targets, v.id)
				end)

				if bounce_target then
					log.paranoid("ray_tesla bounce from %s to %s dist:%s", target.id, bounce_target.id, V.dist(dest.x, dest.y, bounce_target.pos.x, bounce_target.pos.y))

					local r = E:create_entity(this.template_name)

					r.pos = V.vclone(dest)
					r.bullet.to = V.vclone(bounce_target.pos)
					r.bullet.target_id = bounce_target.id
					r.bullet.source_id = target.id
					r.bullet.damage_factor = b.damage_factor
					r.bounces = this.bounces - 1
					r.bounce_scale_y = r.bounce_scale_y * r.bounce_scale_y_factor
					r.seen_targets = this.seen_targets
					r.bounce_damage_factor = math.max(this.bounce_damage_factor + this.bounce_damage_factor_inc, this.bounce_damage_factor_min)

					queue_insert(store, r)
				end
			end

			while not U.animation_finished(this) do
				if target then
					update_sprite()
				end

				coroutine.yield()
			end
		end
	end

	queue_remove(store, this)
end

scripts.ray_frankenstein99 = {}
--[[
function scripts.ray_frankenstein99.update(this, store)
	local b = this.bullet
	local s = this.render.sprites[1]
	local target = store.entities[b.target_id]
	local source = store.entities[b.source_id]
	local dest = b.to

	s.scale = V.v(1, 1)

	local function update_sprite()
		
		if target and target.motion then
			dest.x, dest.y = target.pos.x, target.pos.y
			if target.unit and target.unit.hit_offset then
				dest.x, dest.y = dest.x + target.unit.hit_offset.x, dest.y + target.unit.hit_offset.y
			end
		end

		if source and source.motion then
			this.pos.x, this.pos.y = source.pos.x, source.pos.y

			if source.unit and source.unit.hit_offset then
				this.pos.x, this.pos.y = this.pos.x + source.unit.hit_offset.x, this.pos.y + source.unit.hit_offset.y
			end
		end

		local angle = V.angleTo(dest.x - this.pos.x, dest.y - this.pos.y)

		s.r = angle
		s.scale.x = V.dist(dest.x, dest.y, this.pos.x, this.pos.y) / this.image_width
		s.scale.y = 0.4 + km.clamp(0, 0.6, s.scale.x * 0.6)
	end

	if target then
		s.ts = store.tick_ts

		local l_bounce_start = V.vclone(target.pos)

		update_sprite()

		if U.flag_has(target.vis.flags, F_FLYING) then
			this.bounce_range = this.bounce_range + 10
		end

		if target.template_name == "soldier_frankenstein" and not target.health.dead then
			target.health.hp = target.health.hp + this.frankie_heal_hp
		else
			local mod = E:create_entity(b.mod)

			mod.modifier.level = b.level
			mod.modifier.source_id = b.source_id
			mod.modifier.target_id = target.id
			mod.dps.damage_max = mod.dps.damage_max * this.bounce_damage_factor * b.damage_factor
			mod.dps.damage_min = mod.dps.damage_min * this.bounce_damage_factor * b.damage_factor
			mod.dps.damage_inc = mod.dps.damage_inc * this.bounce_damage_factor * b.damage_factor

			queue_insert(store, mod)
		end

		table.insert(this.seen_targets, target.id)

		if not this.bounces then
			this.bounces = this.bounces_lvl[b.level]
		end

		if this.bounces > 0 then
			U.y_wait(store, this.bounce_delay)

			local bounce_target = U.find_nearest_enemy(store.entities, l_bounce_start, 0, this.bounce_range, this.bounce_vis_flags, this.bounce_vis_bans, function(v)
				return not table.contains(this.seen_targets, v.id)
			end)

			bounce_target = bounce_target or U.find_nearest_soldier(store.entities, dest, 0, this.bounce_range, this.bounce_vis_flags, this.bounce_vis_bans, function(v)
				return v.template_name == "soldier_frankenstein" and not v.health.dead and not table.contains(this.seen_targets, v.id)
			end)

			if bounce_target then
				log.paranoid("bounce from %s to %s dist:%s", target.id, bounce_target.id, V.dist(dest.x, dest.y, bounce_target.pos.x, bounce_target.pos.y))

				local r = E:create_entity(this.template_name)

				r.pos = V.vclone(dest)
				r.bullet.level = b.level
				r.bullet.to = V.vclone(target.pos)
				r.bullet.target_id = bounce_target.id
				r.bullet.source_id = target.id
				r.bounces = this.bounces - 1
				r.seen_targets = this.seen_targets
				r.bounce_damage_factor = math.max(this.bounce_damage_factor + this.bounce_damage_factor_inc, this.bounce_damage_factor_min)

				queue_insert(store, r)
			end
		end

		while not U.animation_finished(this) do
			update_sprite()
			coroutine.yield()
		end
	end

	queue_remove(store, this)
end
]]--
function scripts.ray_frankenstein99.update(this, store)
	local b = this.bullet
	local s = this.render.sprites[1]
	local target = store.entities[b.target_id]
	local source = store.entities[b.source_id]
	local dest = b.to

	s.scale = V.v(1, 1)

	local function update_sprite()
		
		if target and target.motion then
			dest.x, dest.y = target.pos.x, target.pos.y
			if target.unit and target.unit.hit_offset then
				dest.x, dest.y = dest.x + target.unit.hit_offset.x, dest.y + target.unit.hit_offset.y
			end
		end

		if source and source.motion then
			this.pos.x, this.pos.y = source.pos.x, source.pos.y

			if source.unit and source.unit.hit_offset then
				this.pos.x, this.pos.y = this.pos.x + source.unit.hit_offset.x, this.pos.y + source.unit.hit_offset.y
			end
		end

		local angle = V.angleTo(dest.x - this.pos.x, dest.y - this.pos.y)

		s.r = angle
		s.scale.x = V.dist(dest.x, dest.y, this.pos.x, this.pos.y) / this.image_width
		s.scale.y = 0.4 + km.clamp(0, 0.6, s.scale.x * 0.6)
	end

	if target then
		s.ts = store.tick_ts

		local l_bounce_start = V.vclone(target.pos)

		update_sprite()

		if U.flag_has(target.vis.flags, F_FLYING) then
			this.bounce_range = this.bounce_range + 10
		end

		if target.template_name == "soldier_frankenstein" and not target.health.dead then
			target.health.hp = target.health.hp + this.frankie_heal_hp
		else
			local mod = E:create_entity(b.mod)

			mod.modifier.level = b.level
			mod.modifier.source_id = b.source_id
			mod.modifier.target_id = target.id
			mod.dps.damage_max = mod.dps.damage_max * this.bounce_damage_factor * b.damage_factor
			mod.dps.damage_min = mod.dps.damage_min * this.bounce_damage_factor * b.damage_factor
			mod.dps.damage_inc = mod.dps.damage_inc * this.bounce_damage_factor * b.damage_factor
---麻痹			
			local shock_and_awe = UP:get_upgrade("engineer_shock_and_awe")
				if shock_and_awe and band(target.vis.bans, F_STUN) == 0 and band(target.vis.flags, bor(F_BOSS, F_CLIFF)) == 0 and math.random() < shock_and_awe.chance then
					local mod = E:create_entity("mod_shock_and_awe")

					mod.modifier.target_id = target.id

					queue_insert(store, mod)
				end	
---
			queue_insert(store, mod)
		end

		table.insert(this.seen_targets, target.id)

		if not this.bounces then
			this.bounces = this.bounces_lvl[b.level]
		end

		if this.bounces > 0 then
			U.y_wait(store, this.bounce_delay)

			local bounce_target = U.find_nearest_enemy(store.entities, l_bounce_start, 0, this.bounce_range, this.bounce_vis_flags, this.bounce_vis_bans, function(v)
				return not table.contains(this.seen_targets, v.id)
			end)

			bounce_target = bounce_target or U.find_nearest_soldier(store.entities, dest, 0, this.bounce_range, this.bounce_vis_flags, this.bounce_vis_bans, function(v)
				return v.template_name == "soldier_frankenstein" and not v.health.dead and not table.contains(this.seen_targets, v.id)
			end)

			if bounce_target then
				log.paranoid("bounce from %s to %s dist:%s", target.id, bounce_target.id, V.dist(dest.x, dest.y, bounce_target.pos.x, bounce_target.pos.y))

				local r = E:create_entity(this.template_name)

				r.pos = V.vclone(dest)
				r.bullet.level = b.level
				r.bullet.to = V.vclone(target.pos)
				r.bullet.target_id = bounce_target.id
				r.bullet.source_id = target.id
				r.bounces = this.bounces - 1
				r.seen_targets = this.seen_targets
				r.bounce_damage_factor = math.max(this.bounce_damage_factor + this.bounce_damage_factor_inc, this.bounce_damage_factor_min)

				queue_insert(store, r)
			end
		end

		while not U.animation_finished(this) do
			update_sprite()
			coroutine.yield()
		end
	end

	queue_remove(store, this)
end
-- 逐光者被蝎子攻击时会卡住
scripts.hero_gerald99 = {}
function scripts.hero_gerald99.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta

	U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			skill = this.hero.skills.block_counter

			if skill.level > 0 and this.dodge and this.dodge.active then
				this.dodge.active = false
				this.dodge.counter_attack_pending = true

				local la = this.dodge.last_attack
				local ca = this.dodge.counter_attack

				if la then
					if la.damage_max == nil or la.damage_min == nil then
						 la.damage_min = math.random(20, 25)
						 la.damage_max = math.random(35, 45)
					end
					ca.damage_max = la.damage_max * (ca.reflected_damage_factor + ca.reflected_damage_factor_inc * skill.level)
					ca.damage_min = la.damage_min * (ca.reflected_damage_factor + ca.reflected_damage_factor_inc * skill.level)
				end

				SU.hero_gain_xp_from_skill(this, skill)

				goto label_39_0
			end

			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_39_1
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
			end

			a = this.timed_attacks.list[1]
			skill = this.hero.skills.courage

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local triggers = U.find_soldiers_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a.vis_bans, function(e)
					return e.soldier and e.soldier.target_id
				end)

				if not triggers or #triggers < a.min_count then
					SU.delay_attack(store, a, 0.13333333333333333)
				else
					local start_ts = store.tick_ts

					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts)

					if SU.y_hero_wait(store, this, a.shoot_time) then
						-- block empty
					else
						local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a.vis_bans, function(e)
							return e.soldier and e.soldier.target_id
						end)

						if not targets then
							-- block empty
						else
							a.ts = start_ts

							SU.hero_gain_xp_from_skill(this, skill)

							for _, e in pairs(targets) do
								local mod = E:create_entity(a.mod)

								mod.modifier.target_id = e.id
								mod.modifier.source_id = this.id
								mod.modifier.level = skill.level

								queue_insert(store, mod)
							end

							SU.y_hero_animation_wait(this)

							goto label_39_1
						end
					end
				end
			end

			::label_39_0::

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			elseif SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::label_39_1::

		coroutine.yield()
	end
end

--以下为 --流辉一枪349 的增补
--五代死灵卖出或者升级后，原先的储存子弹不消。后续可能需要修改逻辑，保证升级后能从0开始存储子弹，不然的话这个bug估计不能彻底解决。
scripts.bullet_tower_necromancer99 = {}
function scripts.bullet_tower_necromancer99.remove(this, store)
	if this.bullet then
		for _, e in pairs(this.bullet) do
			e.source.tower = nil

			queue_remove(store, e)
		end
	end

	return true
end

function scripts.bullet_tower_necromancer99.insert(this, store, script)
	local b = this.bullet

	if b.target_id then
		local target = store.entities[b.target_id]

		if not target or band(target.vis.bans, F_RANGED) ~= 0 then
			return false
		end
	end

	b.speed.x, b.speed.y = V.normalize(b.to.x - b.from.x, b.to.y - b.from.y)

	local s = this.render.sprites[1]

	if not b.ignore_rotation then
		s.r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)
	end

	this.source = store.entities[b.source_id]

	if not this.source then
		return false
	end

	U.animation_start(this, "flying", nil, store.tick_ts, s.loop)

	return true
end

function scripts.bullet_tower_necromancer99.update(this, store)
	local b = this.bullet
	local target
	local fm = this.force_motion

	local function find_target()
		local attack = this.source.attacks.list[1]
		local target, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this.source), 0, this.source.attacks.range, attack.node_prediction, attack.vis_flags, attack.vis_bans)

		return target, pred_pos
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

	U.animation_start(this, "idle", nil, store.tick_ts, false, 1)

	local recalculate_spawn_pos = false

	if not this.source then
		queue_remove(store, this)

		return
	end

	if this.source.tower.is_blocked then
		this.fire_directly = false
		recalculate_spawn_pos = true
	end

	local enemy, pred_pos = find_target()

	if this.fire_directly and enemy then
		if enemy then
			goto label_636_0
		else
			recalculate_spawn_pos = true
		end
	else
		S:queue(this.summon_sound)
	end

	if recalculate_spawn_pos then
		local start_offset = table.safe_index(this.source.attacks.list[1].bullet_spawn_offset, this.source.tower_upgrade_persistent_data.current_skulls + 1)

		this.pos.x, this.pos.y = this.source.pos.x + start_offset.x, this.source.pos.y + start_offset.y
	end

	U.animation_start(this, "idle", nil, store.tick_ts, false, 2)
	U.y_wait(store, fts(math.random(0, 10)))
	U.animation_start(this, "idle", nil, store.tick_ts, true, 1)

	while not U.animation_finished(this, 2) do
		coroutine.yield()
	end

	this.render.sprites[2].hidden = true

	while not this.source or not this.source.tower_upgrade_persistent_data.fire_skulls or not enemy or not pred_pos do
		if b.source_id ~= this.source.id and store.entities[b.source_id] ~= nil then
			this.source = store.entities[b.source_id]
		end

		if this.source and not this.source.tower.is_blocked then
			enemy, pred_pos = find_target()
		else
			enemy = nil
		end

		coroutine.yield()
	end

	::label_636_0::

	if b.source_id ~= this.source.id and store.entities[b.source_id] ~= nil then
		this.source = store.entities[b.source_id]
	end

	this.render.sprites[1].z = Z_BULLETS
	this.source.tower_upgrade_persistent_data.skulls_ref[this.source.tower_upgrade_persistent_data.current_skulls] = nil
	this.source.tower_upgrade_persistent_data.current_skulls = this.source.tower_upgrade_persistent_data.current_skulls - 1
	b.to = V.v(pred_pos.x + enemy.unit.hit_offset.x, pred_pos.y + enemy.unit.hit_offset.y)
	b.target_id = enemy.id
	target = store.entities[enemy.id]

	local ps

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.emit = true
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	local iix, iiy = V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y)
	local last_pos = V.vclone(this.pos)

	b.ts = store.tick_ts
	this.render.sprites[1].flip_x = pred_pos.x < this.source.pos.x

	S:queue(this.shoot_sound)

	while true do
		target = store.entities[b.target_id]

		if target and target.health and not target.health.dead and band(target.vis.bans, F_RANGED) == 0 then
			local d = math.max(math.abs(target.pos.x + target.unit.hit_offset.x - b.to.x), math.abs(target.pos.y + target.unit.hit_offset.y - b.to.y))

			if d > b.max_track_distance then
				log.info("BOLT MAX DISTANCE FAIL. (%s) %s / dist:%s target.pos:%s,%s b.to:%s,%s", this.id, this.template_name, d, target.pos.x, target.pos.y, b.to.x, b.to.y)

				target = nil
				b.target_id = nil
			else
				b.to.x, b.to.y = pred_pos.x + target.unit.hit_offset.x, pred_pos.y + target.unit.hit_offset.y
			end
		end

		if this.initial_impulse and store.tick_ts - b.ts < this.initial_impulse_duration then
			local t = store.tick_ts - b.ts

			fm.a.x, fm.a.y = V.mul((1 - t) * this.initial_impulse, V.rotate(0, iix, iiy))
		end

		last_pos.x, last_pos.y = this.pos.x, this.pos.y

		if move_step(b.to) then
			break
		end

		coroutine.yield()
	end

	if target and not target.health.dead then
		local mod = E:create_entity(b.mod)

		mod.modifier.target_id = target.id
		mod.modifier.source_id = this.source.id

		queue_insert(store, mod)

		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)
		S:queue(this.hit_sound)
	end

	U.animation_start(this, "hit_FX_idle", nil, store.tick_ts, 1, 1)

	if ps and ps.particle_system.emit then
		ps.particle_system.emit = false
	end

	while not U.animation_finished(this, 1) do
		coroutine.yield()
	end

	this.render.sprites[1].hidden = true

	queue_remove(store, this)
	coroutine.yield()
end
---圣骑兵
scripts.walk_soldier = {
	insert = function(this, store)
		local np = this.nav_path or nil
		if this.auras then
			local aura = {}
			for i = 1, #this.auras.list do
				:: again ::
				aura[i] = E:create_entity(this.auras.list[i].name)
				aura[i].aura.source_id = this.id
				aura[i].pos = this.pos
				queue_insert(store, aura[i])
				if not aura[i] then
					goto again
				end
			end
		end
		if this.info and this.info.random_name_format then
			this.info.i18n_key = string.format(string.gsub(this.info.random_name_format, "_NAME", ""), math.random(this.info.random_name_count))
		end
		this.health_bar.hidden = false
		if this.render.sprites[1] then
			this.render.sprites[1].fps = this.render.sprites[1].fps or FPS
			this.render.sprites[1].alpha = this.render.sprites[1].alpha or 255
		end
		this.melee.order = U.attack_order(this.melee.attacks)
		this.nav_rally.pos = this.nav_rally.pos or V.vclone(this.pos)
		this.nav_rally.center = this.nav_rally.center or V.vclone(this.pos)
		if this.render.sprites[1].name then
			U.animation_start(this, this.render.sprites[1].name, nil, store.tick_ts, 1)
		end
		return true
	end,
	update = function(this, store, script)
		local h = this.health
		local brk, sta = nil
		local next_pos, new = V.vclone(this.pos), nil
		local np = this.nav_path
		local gnp = nil
		local ranged = false
		local YX = nil
		local vis_bans = this.vis.bans
		local vis_flags = this.vis.flags
		local blo = this.melee.range
		local prev_immune = this.health.immune_to

		local function hold_advance()
			:: loop ::
			for _, aa in pairs(this.ranged.attacks) do
				enemy = U.find_nearest_enemy(store.entities, this.pos, aa.min_range, aa.max_range, aa.vis_flags, aa.vis_bans)
				blocker = U.find_foremost_enemy(store.entities, this.pos, 0, this.melee.range, false, bor(F_BLOCK), bor(F_FLYING, F_CLIFF, F_WATER))
				if aa.hold_advance and enemy and not this.soldier.target_id and (aa.ignore_blocker or not blocker) then
					if this.unit.is_stunned or this.health.dead or this.nav_rally.new then
						return true
					end
					local an, ann = U.animation_name_facing_point(this, "idle", enemy.pos)
					U.animation_start(this, an, ann, store.tick_ts, true)
					U.unblock_target(store, this)
					this.motion.speed.y = 0
					this.motion.speed.x = 0

					coroutine.yield()
					goto loop
				end
			end
		end
		this.health_bar.hidden = false
		this.melee.order = U.attack_order(this.melee.attacks)

		if this.ranged and this.ranged.attacks then
			ranged = true
		end

		if not P:is_node_valid(np.pi, np.ni) then
			np.spi = nil
			np.ni = nil
			np.pi = nil
		else
			next_pos = P:next_entity_node(this, store.tick_length)
			if not next_pos then
				np.spi = nil
				np.ni = nil
				np.pi = nil
				next_pos = nil
			else
				if GR:cell_is(next_pos.x, next_pos.y, bor(TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK)) then
					np.spi = nil
					np.ni = nil
					np.pi = nil
				end
				next_pos = nil
			end
		end
		if this.nav_path then
			:: againa ::
			local nearest = P:nearest_nodes(this.nav_rally.pos.x or this.pos.x, this.nav_rally.pos.y or this.pos.y, nil, nil, true)

			if #nearest > 0 then
				--nothing
			else
				coroutine.yield()
				goto againa
			end
			local pi, spi, ni = unpack(nearest[1])
			local pos = P:node_pos(pi, spi, ni)
			spi = math.random(1, 3)

			if not np.pi then
				np.pi = pi
			end

			if not np.ni then
				np.ni = ni
			end

			if not np.spi then
				np.spi = spi
			end
		end

		U.y_animation_wait(this)
		U.animation_start(this, "idle", nil, store.tick_ts, -1)

		while true do
			:: loop ::

			if h.dead then
				if this == game_gui.selected_entity then
					game_gui:deselect_entity()
				end
				this.health.hp = -9e+99

				SU.y_soldier_death(store, this)
				U.y_wait(store, this.health.dead_lifetime)
				queue_remove(store, this)

				return
			end
			if np.dead then
				if this == game_gui.selected_entity then
					game_gui:deselect_entity()
				end
				this.health.hp = -9e+99

				queue_remove(store, this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, -1)
				coroutine.yield()
			else
				:: net ::

				if this.nav_rally.new then
					if this.hero then
						SU.y_hero_new_rally(store, this)
						:: again2 ::
						local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)

						if #nearest > 0 then
							--nothing
						else
							coroutine.yield()
							goto again2
						end

						np.pi = nearest[1][1]
						np.ni = nearest[1][3]
						np.spi = math.random(1, 3)
						goto loop
					end
					this.nav_rally.new = nil
				end
				if h.hp <= 0 or h.dead or this.unit.is_stunned or this.nav_rally.new then
					coroutine.yield()
					goto loop
				end

				if this.melee then
					brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

					if ranged and this.ranged.range_while_blocking then
						brk, sta = SU.y_soldier_ranged_attacks(store, this)
						hold_advance()
					end
					if sta and sta == A_IN_COOLDOWN then
						U.animation_start(this, "idle", nil, store.tick_ts, true)
					end
					if sta ~= A_NO_TARGET then
						coroutine.yield()
						goto out
					end
				end
				:: out ::
				local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
					this.nav_path.pi
				}, {
					this.nav_path.spi
				})
				local function set()
					if not np.can_loop then
						h.ignore_damage = false
						this.vis.bans = vis_bans
						this.vis.flags = vis_flags
						this.melee.range = blo
						U.unblock_target(store, this)
						h.ignore_damage = false
						local es = E:create_entity("abducted_enemy_decal")
						es.pos.y = this.pos.y
						es.pos.x = this.pos.x
						es.render = table.deepclone(this.render)
						es.tween.disabled = nil
						es.tween.ts = store.tick_ts
						if this.render.sprites[1].alpha <= 0 then
							U.sprites_hide(es)
						end

						queue_insert(store, es)
						U.sprites_hide(this)
						np.dead = true
						coroutine.yield()
					end
					if not gnp then
						np.dir = -np.dir
						gnp = true
					end
					next_pos = P:next_entity_node(this, store.tick_length)
				end
				if nearest then
					--nothing
				else
					coroutine.yield()
					goto out
				end
				if nearest[1] then
					--nothing
				else
					set()
				end

				if np.dir < 0 then
					if nearest[1][3] < np.ni then
						np.ni = nearest[1][3]
						next_pos = nil
					end
				elseif np.dir > 0 then
					if nearest[1][3] > np.ni then
						np.ni = nearest[1][3]
						next_pos = nil
					end
				end
				local gpos = P:node_pos(np.pi, np.spi, np.ni)
				this.nav_rally.center = gpos

				if next_pos then
					--nothing
				else
					goto re
				end
				if h.hp <= 0 or h.dead or this.unit.is_stunned or this.nav_rally.new then
					coroutine.yield()
					goto loop
				end
				if (not this.melee or sta == A_NO_TARGET) then

					if ranged then
						brk, sta = SU.y_soldier_ranged_attacks(store, this)
						hold_advance()
					end
					U.set_destination(this, next_pos)

					local an, af = U.animation_name_facing_point(this, "walk" or "running", this.motion.dest)

					U.animation_start(this, an, af, store.tick_ts, -1)
					U.walk(this, store.tick_length)
					coroutine.yield()
				end
				:: re ::
				next_pos = P:next_entity_node(this, store.tick_length)

				if next_pos then
					--nothing
				else
					set()
					if not np.can_loop then
						goto loop
					end
				end
				if np.dir < 0 then
					if np.ni <= P:get_start_node(np.pi) then
						set()
						if not np.can_loop then
							goto loop
						end
					end
				elseif np.dir > 0 then
					if np.ni >= P:get_end_node(np.pi) then
						set()
						if not np.can_loop then
							goto loop
						end
					end
				end
				if np.can_hide_self then
					if GR:cell_is(next_pos.x, next_pos.y, bor(TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK)) then
						if not YX then
							U.animation_start(this, "idle", nil, store.tick_ts, true)
							while true do
								if this.render.sprites[1].alpha <= 0 then
									break
								end
								h.ignore_damage = true
								this.vis.bans = bor(F_ALL)
								this.vis.flags = bor(F_ALL)
								if this.ranged and this.ranged.attacks then
									for _, aa in pairs(this.ranged.attacks) do
										aa.ts = 9e+99
									end
								end
								this.health_bar.hidden = true
								this.melee.range = 0
								U.unblock_target(store, this)
								this.render.sprites[1].alpha = this.render.sprites[1].alpha - 15
								coroutine.yield()
							end
							this.render.sprites[1].alpha = 0
							YX = true
						end
					elseif GR:cell_is(next_pos.x, next_pos.y, bor(TERRAIN_LAND)) then
						if YX then
							U.animation_start(this, "idle", nil, store.tick_ts, true)
							while true do
								if this.render.sprites[1].alpha >= 255 then
									break
								end
								if this.ranged and this.ranged.attacks then
									for _, aa in pairs(this.ranged.attacks) do
										aa.ts = store.tick_ts
									end
								end
								h.ignore_damage = false
								this.vis.bans = vis_bans
								this.vis.flags = vis_flags
								this.health_bar.hidden = false
								this.melee.range = blo
								U.unblock_target(store, this)
								this.render.sprites[1].alpha = this.render.sprites[1].alpha + 15
								coroutine.yield()
							end
							this.render.sprites[1].alpha = 255
							YX = nil
						end
						gnp = nil
					else
						gnp = nil
					end
				elseif not np.can_hide_self then
					if GR:cell_is(next_pos.x, next_pos.y, bor(TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK)) then
						set()
						if not np.can_loop then
							goto loop
						end
					else
						gnp = nil
					end
				end
				if P:is_node_valid(np.pi, np.ni) then
					--nothing
				else
					--set()
					if not np.can_loop then
						--goto loop
					end
				end

				if h.hp <= 0 or h.dead or this.unit.is_stunned or this.nav_rally.new then
					coroutine.yield()
					goto loop
				end

				goto loop
				coroutine.yield()
			end
		end
	end
}
return scripts