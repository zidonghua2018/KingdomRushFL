-- chunkname: @./all/wave_db.lua

local log = require("klua.log"):new("wave_db")
local km = require("klua.macros")
local FS = love.filesystem
local storage = require("storage")

require("constants")

local wave_db = {}

wave_db.db = nil
wave_db.game_mode = nil

local gms = {
	[GAME_MODE_CAMPAIGN] = "campaign",
	[GAME_MODE_HEROIC] = "heroic",
	[GAME_MODE_IRON] = "iron",
	[GAME_MODE_ENDLESS] = "endless"
}

function wave_db:load(level_name, game_mode)
	self.game_mode = game_mode

	local suffix = gms[game_mode]
	local wn = string.format("%s/data/waves/%s_waves_%s", KR_PATH_GAME, level_name, suffix)
	local wf = string.format("%s.lua", wn)

	log.debug("Loading %s", wn)

	local custom = string.format("/custom/%s_waves_%s.lua", level_name, suffix)
	if FS.isFile(custom) then
		print("**** use custom: ", custom)
		wf = custom
	end

	local ok, wchunk = pcall(FS.load, wf)

	if not ok then
		log.error("Failed to load %s: error: %s", wf, wchunk)

		return
	end

	local ok, wtable = pcall(wchunk)

	if not ok then
		log.error("Failed to eval chunk for %s: error: %s", wf, wtable)

		return
	end

	wave_db.db = wtable
	--新增：双倍出怪模式
	self.endless_level = {"level81","level82","level83","level84","level85"}
	self.user_data = storage:load_slot()
	if self.user_data.liuhui.enemy_count and self.user_data.liuhui.enemy_count >= 2 and table.contains(self.endless_level, level_name) == false then
		for i, waves in pairs(wave_db.db.groups) do
			for j, path_list in pairs(waves.waves) do
				local spawns = {}
				for k, creeps in pairs(path_list.spawns) do 
					table.insert(spawns, creeps)
				end
				for k, creeps in pairs(spawns) do 
					if creeps.interval_next ~= nil then
						creeps.interval_next = math.ceil(creeps.interval_next * (1 - self.user_data.liuhui.enemy_count * 0.25))
					end
				end
				for k, creeps in pairs(spawns) do 
					table.insert(path_list.spawns, k * 2, creeps)
				end
				if self.user_data.liuhui.enemy_count >= 3 then
					for k, creeps in pairs(spawns) do 
						table.insert(path_list.spawns, k * 3, creeps)
					end
				end
			end
		end
	end

	local wen = string.format("%s_extra", wn)
	local wef = string.format("%s.lua", wen)

	if FS.isFile(wef) then
		log.info("Found extra waves: %s", wef)

		local ok, wchunk = pcall(FS.load, wef)

		if not ok then
			log.error("Failed to load %s: error: %s", wef, wchunk)

			return
		end

		local ok, extraw = pcall(wchunk)

		if not ok then
			log.error("Failed to eval extra waves chunk for %s: error: %s", wef, extraw)

			return
		end

		self:add_waves_to_groups(extraw)
	end
end

function wave_db:add_waves_to_groups(gwaves)
	if self.db.groups then
		for g, more_waves in pairs(gwaves) do
			log.info("adding %d extra waves to group %d", #more_waves.waves, g)

			if not self.db.groups[g] then
				log.warning("Adding waves to inexistent group %d")

				self.db.groups[g] = {
					waves = {}
				}
			end

			for _, w in pairs(more_waves.waves) do
				table.insert(self.db.groups[g].waves, w)
			end
		end
	else
		log.error("Unable to add waves. No wave groups have been loaded yet.")
	end
end

function wave_db:groups()
	return self.db.groups
end

function wave_db:group(group_number)
	return self.db.groups[group_number]
end

function wave_db:initial_gold()
	return self.db.cash or self.db.gold
end

function wave_db:initial_lives()
	return self.db.lifes
end

function wave_db:groups_count()
	if self.game_mode == GAME_MODE_ENDLESS then
		return 0
	else
		return #self.db.groups
	end
end

function wave_db:waves_count()
	if self.game_mode == GAME_MODE_ENDLESS then
		return 0
	else
		local result = 0

		for __, group in pairs(self.db.groups) do
			result = result + #group.waves
		end

		return result
	end
end

function wave_db:has_group(i)
	if self.game_mode == GAME_MODE_ENDLESS then
		return i > 0
	else
		return i <= #self.db.groups
	end
end

function wave_db:get_group(i)
	if self.game_mode == GAME_MODE_ENDLESS then
		return self:get_endless_group(i)
	else
		return self.db.groups[i]
	end
end

function wave_db:get_endless_early_wave_reward_factor()
	if self.db and self.db.nextWaveRewardMoneyMultiplier then
		return self.db.nextWaveRewardMoneyMultiplier
	else
		return 1
	end
end

function wave_db:get_endless_score_config()
	if self.db and self.db.score then
		return table.deepclone(self.db.score)
	else
		return nil
	end
end

function wave_db:stop_manual_wave(wave_name)
end

function wave_db:start_manual_wave(wave_name)
	--[[
	if not wave_name or wave_name == "main" or wave_name == "" then
		log.error("cannot start main waves")

		return
	end

	local s = self:get_wave_status(wave_name)

	if not s then
		log.error("manual wave %s does not exist", wave_name)

		return
	end

	if table.contains({
		WS_PENDING,
		WS_RUNNING,
		WS_DONE
	}, s.state) then
		log.error("manual wave %s pending or still running. cannot have more than one at a time.", wave_name)

		return
	end

	s.state = WS_PENDING
	s.current_idx = s.first_idx
	s.repeat_remaining = s.repeat_count
	]]
	return
end

function wave_db:get_endless_boss_config(i)
	local out = {}
	local db = self.db
	local dif_max = #db.difficulties
	local dif_level = math.ceil(i / 10)
	local dif_idx = km.clamp(1, dif_max, dif_level)
	local dif = db.difficulties[dif_idx]
	local dbc = dif.bossConfig

	out.chance = dbc.powerChance + dbc.powerChanceIncrement * dif_level
	out.cooldown = math.random(dbc.powerCooldownMin, dbc.powerCooldownMax)
	out.multiple_attacks_chance = dbc.powerMultiChance
	out.power_chances = dbc.powerDistribution
	out.powers_config_dif = dbc.powerConfig
	out.boss_config_dif = dbc
	out.powers_config = db.bossConfig.powerConfig

	return out
end

function wave_db:get_endless_group(i)
	local db = self.db

	if not db.vars then
		db.vars = {
			dif_idx = 1,
			next_dif_uses = 0,
			used_waves = {},
			first_entity_wave = {}
		}
	end

	local paths_order = {}

	for _, v in pairs(table.random_order(db.pathConfig)) do
		local rv, rvi = table.random(v)

		table.insert(paths_order, rv + 1)
	end

	local waves_per_load = 10
	local used_waves = db.vars.used_waves
	local dif_idx = db.vars.dif_idx
	local dif_max = #db.difficulties
	local dif = db.difficulties[dif_idx]
	local dif_next = db.difficulties[km.clamp(1, dif_max, dif_idx + 1)]
	local max_paths = dif.max_paths
	local boss_waves_count = i % waves_per_load ~= 0 and 0 or #dif.bossWaves
	local multipath_chance = i == 1 and 0 or (dif.multiple_paths_chance + dif.multiple_paths_chance_increment * i) / 100
	local next_dif_chances = db.chancesToUseNextDifficulty
	local next_dif_uses = db.vars.next_dif_uses
	local o_group = {
		waves = {}
	}
	local wave_interval = 0

	for pi = 1, max_paths do
		if pi > 1 and boss_waves_count == 0 and multipath_chance < math.random() then
			-- block empty
		else
			local cycle_index = km.zmod(i, waves_per_load)
			local waves

			if boss_waves_count > 0 then
				waves = dif.bossWaves
				boss_waves_count = boss_waves_count - 1
			else
				local next_dif_chance = next_dif_chances[cycle_index - waves_per_load + #next_dif_chances] or 0

				next_dif_chance = next_dif_chance * math.pow(0.5, next_dif_uses)

				log.paranoid("  ENDLESS NORMAL WAVE. next_dif_chance:%s next_dif_uses:%s  chances:%s", next_dif_chance, next_dif_uses, getfulldump(next_dif_chances))

				if next_dif_chance > math.random() then
					next_dif_uses = next_dif_uses + 1
					waves = dif_next.waves
					cycle_index = 1
				else
					waves = dif.waves
				end
			end

			local candidate_waves = table.filter(waves, function(k, v)
				return not table.contains(used_waves, v)
			end)

			if #candidate_waves == 0 then
				candidate_waves = waves
				used_waves = {}
			end

			local wave = table.random(candidate_waves)

			table.insert(used_waves, wave)

			wave_interval = math.max(wave_interval, wave.next_wave_interval)

			local o_wave = {
				delay = 0,
				spawns = {}
			}

			for _, spawn in pairs(wave.spawns) do
				local o_spawn = {
					creep = spawn.creep,
					creep_aux = spawn.creep_aux,
					max_same = spawn.max_same,
					max = spawn.cant + (spawn.cant_cicle == 0 and 0 or spawn.cant_increment * math.floor(math.min(cycle_index, waves_per_load) / spawn.cant_cicle)),
					interval = spawn.interval,
					interval_next = spawn.interval_next,
					fixed_sub_path = spawn.use_fixed_path,
					path = spawn.path + 1
				}

				table.insert(o_wave.spawns, o_spawn)
				log.paranoid("   ENDLESS SPAWN index:%03i - max:%03i creep:%s  maxSame:%i interval:%i interval_next:%i path:%i cycle_index:%i", i, o_spawn.max, o_spawn.creep, o_spawn.max_same, o_spawn.interval, o_spawn.interval_next, o_spawn.path, cycle_index)
			end

			o_wave.path_index = paths_order[km.zmod(pi, #paths_order)]

			table.insert(o_group.waves, o_wave)
		end
	end

	o_group.interval = wave_interval == 0 and 100 or wave_interval

	if i > 0 and i % waves_per_load == 0 then
		dif_idx = km.clamp(1, dif_max, dif_idx + 1)
		next_dif_uses = 0
		used_waves = {}
	end

	db.vars.dif_idx = dif_idx
	db.vars.next_dif_uses = next_dif_uses
	db.vars.used_waves = used_waves

	log.paranoid("group %s:\n %s", i, getfulldump(o_group))

	return o_group
end

function wave_db:set_entity_progression(e, wave_idx)
	local function prog_value(key, raw_value)
		local t
		local tall = self.db.enemyProgression
		local tdefault = self.db.enemyProgression.DEFAULT

		if string.find(key, ".", 1, true) ~= nil then
			local parts = string.split(key, ".")

			t = self.db.enemyProgression

			for i = 1, #parts do
				t = t[parts[i]]
			end

			if not t then
				log.error("entity progression not found for key %s", key)

				return raw_value
			end
		elseif tall[e.template_name] and tall[e.template_name][key] then
			t = table.merge(tdefault[key] or {}, tall[e.template_name][key], true)
		else
			t = tdefault[key] or {}
		end

		if not self.db.vars.first_entity_wave[e.template_name] then
			self.db.vars.first_entity_wave[e.template_name] = wave_idx
		end

		local waves_count = wave_idx

		if t.activeAfterWave then
			if wave_idx < t.activeAfterWave then
				log.paranoid("(%s)%s - %s activeAfterWave %s", e.id, e.template_name, key, t.activeAfterWave)

				return raw_value
			end

			waves_count = waves_count - t.activeAfterWave
		else
			waves_count = waves_count - self.db.vars.first_entity_wave[e.template_name]
		end

		local mult, val

		if t.factor_steps and #t.factor_steps > 0 then
			local cycle = t.cicle or 1
			local step_idx = math.ceil(waves_count / cycle)

			step_idx = km.clamp(1, #t.factor_steps, step_idx)
			mult = t.factor_steps[step_idx]
			val = mult * raw_value
		else
			local factor = t.factor or 1
			local base = t.base or 1
			local cycle = t.cicle or 1

			mult = base * math.pow(factor, math.floor(waves_count / cycle))

			local limit = t.limit or factor > 1 and 99999 or -99999

			if factor > 1 then
				mult = math.min(mult, limit)
			elseif factor < 1 then
				mult = math.max(mult, limit)
			end

			val = mult * raw_value

			if t.limit_value then
				if factor < 1 then
					val = math.max(val, t.limit_value)
				else
					val = math.min(val, t.limit_value)
				end
			end
		end

		return val
	end

	local function prog_factor(key)
		return prog_value(key, 1)
	end

	if e.enemy then
		e.enemy.gold = km.clamp(0, e.enemy.gold, km.round(prog_value("gold", e.enemy.gold)))

		if e.health then
			e.health.hp_max = km.round(prog_value("health", e.health.hp_max))
			e.health.hp_max = km.round(prog_factor("megaHealth") * e.health.hp_max)
			e.health.armor = prog_value("armor", e.health.armor)
			e.health.magic_armor = prog_value("magicArmor", e.health.magic_armor)
		end

		if e.melee and e.melee.attacks[1] then
			local damage_factor = prog_factor("damage")

			e.melee.attacks[1].damage_max = km.round(damage_factor * e.melee.attacks[1].damage_max)
			e.melee.attacks[1].damage_min = km.round(damage_factor * e.melee.attacks[1].damage_min)
		end
	end

	if e.endless and e.endless.factor_map then
		for _, item in pairs(e.endless.factor_map) do
			local fmt

			fmt = item[3] and "e.%s = round(prog_value('%s', e.%s))" or "e.%s = prog_value('%s', e.%s)"

			local n = string.format(fmt, item[2], item[1], item[2])
			local nf = loadstring(n)
			local env = {}

			env.e = e
			env.wave_idx = wave_idx
			env.prog_value = prog_value
			env.round = km.round

			setfenv(nf, env)
			nf()
			log.paranoid("  ENDLESS - factor_map: %s", n)
		end
	end

	log.paranoid("ENDLESS - w:%s (%s)%s | factors - health:%s damage:%s gold:%s armor:%s magic_armor:%s megaHealth:%s ", wave_idx, e.id, e.template_name, prog_factor("health"), prog_factor("damage"), prog_factor("gold"), prog_factor("armor"), prog_factor("magicArmor"), prog_factor("megaHealth"))
end

return wave_db
