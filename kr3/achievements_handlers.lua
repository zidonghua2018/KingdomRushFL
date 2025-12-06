-- chunkname: @./kr3/achievements_handlers.lua

local log = require("klua.log"):new("achievements_handlers")
local signal = require("hump.signal")
local bit = require("bit")
local E = require("entity_db")
local GS = require("game_settings")
local storage = require("storage")
local P = require("path_db")
local U = require("utils")
local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local special_templates = {
	"tower_arcane",
	"tower_silver",
	"tower_wild_magus",
	"tower_high_elven",
	"tower_druid",
	"tower_entwood",
	"tower_blade",
	"tower_forest"
}
local ah = {}

function ah:register_handlers(A)
	self.A = A

	local function reg(name, fn)
		signal.register(name, function(...)
			fn(ah, ...)
		end)
	end

	reg("boss-killed", ah.h_boss_killed)
	reg("count-group-changed", ah.h_count_group_changed)
	reg("early-wave-called", ah.h_early_wave_called)
	reg("entity-damaged", ah.h_entity_damaged)
	reg("entity-killed", ah.h_entity_killed)
	reg("game-victory", ah.h_game_victory)
	reg("hero-level-increased", ah.h_hero_level_increased)
	reg("mod-applied", ah.h_mod_applied)
	reg("notification-shown", ah.h_notification_shown)
	reg("power-used", ah.h_power_used)
	reg("tower-upgraded", ah.h_tower_upgraded)
	reg("next-wave-sent", ah.h_next_wave_sent)
	
	reg("aura-apply-mod-victims", ah.h_aura_apply_mod_victims)
	reg("entity-healed", ah.h_entity_healed)
	reg("health-regen", ah.h_health_regen)
	reg("next-wave-ready", ah.h_next_wave_ready)
	reg("rally-point-changed", ah.h_rally_point_changed)
	reg("soldier-attack", ah.h_soldier_attack)
	reg("tower-power-upgraded", ah.h_tower_power_upgraded)
	reg("tower-removed", ah.h_tower_removed)
	reg("tower-spawn", ah.h_tower_spawn)
	
	reg("entity-revived", ah.h_entity_revived)
	reg("soldier-dodge", ah.h_soldier_dodge)
	reg("soldier-pickpocket", ah.h_soldier_pickpocket)
	reg("moon-changed", ah.h_moon_changed)
	reg("enemy-reached-goal", ah.h_enemy_reached_goal)
end

function ah:h_boss_killed(entity)
	if entity.template_name == "eb_gnoll" then
		self.A:got("SERIOUS")
	elseif entity.template_name == "eb_drow_queen" then
		self.A:got("MALICIA")
	elseif entity.template_name == "eb_spider" then
		self.A:got("WE_ARE_CHAMPIONS")
	elseif entity.template_name == "eb_bram" then
		self.A:got("OFF_HEAD")
	elseif entity.template_name == "eb_bajnimen" then
		self.A:got("BAG_OF_RICE")
	elseif entity.template_name == "eb_balrog" then
		self.A:got("KILL_BALROG")
	elseif entity.template_name == "eb_juggernaut" then
		self.A:got("DEFEAT_JUGGERNAUT")
	elseif entity.template_name == "eb_jt" then
		self.A:got("DEFEAT_MOUNTAIN_BOSS")
	elseif entity.template_name == "eb_veznan" then
		self.A:got("DEFEAT_END_BOSS")
	elseif entity.template_name == "eb_kingpin" then
		self.A:got("DEFEAT_KINGPING_BOSS")
	elseif entity.template_name == "eb_ulgukhai" then
		self.A:got("DEFEAT_TROLL_BOSS")
	elseif entity.template_name == "eb_moloch" then
		self.A:got("HELL_O")
	elseif entity.template_name == "eb_myconid" then
		self.A:got("SUPER_MUSHROOM")
	elseif entity.template_name == "eb_blackburn" then
		self.A:got("GOC")
	elseif entity.template_name == "eb_efreeti" then
		self.A:got("GENIEINABOTTLE")
	elseif entity.template_name == "eb_gorilla" then
		self.A:got("KONGICIDE")
	elseif entity.template_name == "eb_umbra" then
		self.A:got("YOUSHALLNOTPASS")
	elseif entity.template_name == "eb_leviathan" then
		self.A:got("SQUIDINITSINK")
	elseif entity.template_name == "eb_dracula" then
		self.A:got("DEAD_AND_LOVING_IT")
	elseif entity.template_name == "eb_saurian_king" then
		self.A:got("LIZARD_KING")
	end
end

function ah:h_count_group_changed(entity, group_count, increment)
	if entity.count_group.name == "mod_arrow_silver_mark" and increment > 0 then
		self.A:high_check("VALAR_MORGHULIS", group_count)
	elseif entity.count_group.name == "soldier_druid_bear" and increment > 0 then
		self.A:high_check("BEORNINGS", group_count)
	end
	if entity.count_group.name == "skeletons" and increment > 0 then
		local count = #table.filter(game.store.entities, function(k, e)
			return (e.template_name == "soldier_skeleton" or e.template_name == "soldier_skeleton_knight") and e.health and not e.health.dead
		end)

		if entity.health and not entity.health.dead then
			count = count + 1
		end

		self.A:high_check("NECROPOLIS", count)
	end
end

function ah:h_early_wave_called(group, reward, remaining_time)
	self.A:inc_check("TRUTH_DARE")
	local count, ad = self.A:inc("FEARLESS", 1)

	if game.store and game.store.wave_group_total > 1 and count == game.store.wave_group_total - 1 then
		self.A:got(ad.name)
	end

	self.A:lap_check("IMPATIENT")
	self.A:inc_check("DARING", 1)
end

function ah:h_entity_damaged(entity, damage)
	if damage and damage.source_id then
		local s = game.store.entities[damage.source_id]

		if s and s.template_name == "ray_druid_sylvan" then
			self.A:inc_check("NOPAINGAIN", damage.value)
		elseif s and s.template_name == "bolt_blast" then
			self.A:inc_check("OVERCHARGED", damage.value)
		end
		
		if entity.health and entity.health.hp > 0 and s and table.contains({
			"aura_demon_death",
			"aura_demon_mage_death",
			"aura_demon_wolf_death",
			"aura_flareon_death",
			"aura_gulaemon_death",
			"aura_demon_cerberus_death"
		}, s.template_name) then
			self.A:inc_check("WE_DINE_IN_HELL")
		elseif s and s.template_name == "soldier_elf" then
			self.A:inc_check("STILL_COUNTS_AS_ONE", damage.value)
		end
	end
end

function ah:h_entity_healed(mod, entity, amount)
	if entity.template_name == "soldier_dwarf" then
		self.A:high_check("OAKENSHIELD", entity.health.hp_healed)
	end
	if mod.template_name == "mod_healing_paladin" then
		self.A:inc_check("MEDIC", amount)
	end
end

function ah:h_entity_killed(entity, damage)
	if not entity then
		log.debug("nil entity")

		return
	end

	if table.contains({
		"enemy_gnoll_blighter",
		"enemy_gnoll_burner",
		"enemy_gnoll_reaver",
		"enemy_gnoll_gnawer"
	}, entity.template_name) then
		self.A:inc_check("GNOLLBUSTER", 1)
	elseif entity.template_name == "enemy_gloomy" and entity._clones_count == 0 then
		self.A:inc_check("GLOOMICIDE", 1)
	elseif entity.template_name == "enemy_twilight_golem" then
		if P:nodes_to_goal(entity.nav_path) > entity.nav_path.ni then
			self.A:inc_check("BIGGER_THEY_ARE")
		end
	elseif entity.template_name == "enemy_bandersnatch" then
		local h = entity.health

		if not U.flag_has(h.last_damage_types, bor(DAMAGE_INSTAKILL, DAMAGE_EAT, DAMAGE_MODIFIER)) then
			self.A:inc_check("VORPAL_BLADE")
		end
	elseif entity.template_name == "enemy_gnoll_bloodsydian" then
		self.A:inc_check("GNOLLUM", 1)
	elseif entity.template_name == "enemy_mounted_avenger" then
		self.A:inc_check("PEST_CONTROL", 1)
	elseif entity.template_name == "enemy_twilight_brute" then
		self.A:inc_check("DOESNT_COUNT")
	end
	
	if entity.template_name == "enemy_alien_breeder" or entity.template_name == "enemy_alien_reaper" then
		self.A:inc_check("COLONIALMARINE", 1)
	end

	if entity.template_name == "enemy_cannibal_zombie" then
		self.A:inc_check("THEWALKINGDEAD", 1)
	end

	if entity.template_name == "enemy_gunboat" then
		self.A:inc_check("INTHENAVY", 1)
	end

	if entity.template_name == "enemy_bluegale" then
		for _, e in pairs(game.store.entities) do
			if e.template_name == "mod_bluegale_heal" and e.modifier.target_id == entity.id then
				self.A:inc_check("PERFECTSTORM", 1)

				break
			end
		end
	end

	if entity.template_name == "enemy_deviltide_shark" then
		self.A:inc_check("JAWS", 1)
	end

	if entity.water and entity.water.last_terrain_type and entity.water.last_terrain_type == TERRAIN_WATER and entity.template_name ~= "enemy_cannibal" and entity.template_name ~= "enemy_hunter" then
		self.A:inc_check("WATERWORLD", 1)
	end

	if entity.cliff and entity.cliff.last_terrain_type == TERRAIN_CLIFF then
		self.A:inc_check("ISTHATWILHELM", 1)
	end

	if entity.enemy then
		self.A:inc_check("FIRST_BLOOD", 1)
		self.A:inc_check("BLOODLUST", 1)
		self.A:inc_check("SLAYER", 1)
		self.A:inc_check("MULTIKILL", 1)
	end

	if entity.hero then
		entity._death_count = (entity._death_count or 0) + 1
		self.A:inc("SANDWARRIOR")
		self.A:inc("TARZANBOY")
		self.A:inc("CAVEMAN")
	end

	if entity.soldier then
		if not entity.hero then
			self.A:inc_check("WAR_NEVER_CHANGES", 1)
			self.A:inc_check("CANNON_FODDER", 1)
		end
	elseif entity.enemy then
		if entity.enemy.gold > 0 then
			self.A:inc_check("BONE_COLLECTOR", entity.enemy.gold)
		end

		if entity.unit and entity.unit.is_stunned and U.has_modifiers(game.store, entity, "mod_arrow_arcane_slumber") then
			self.A:inc_check("SLUMBER_ARROWS")
		end

		if not entity.enemy.can_do_magic and U.has_modifiers(game.store, entity, "mod_ward") then
			self.A:inc_check("COUNTERMASTER")
		end
	end
	
	if entity.template_name == "enemy_phantom_warrior" and not entity.aura_applied then
		self.A:inc_check("DEAD_PEOPLE")
	end

	if damage and damage.source_id then
		local s = game.store.entities[damage.source_id]

		if s then
			if entity.soldier and s.template_name == "sand_worm" then
					self.A:inc("MUADIB")
			end
			
			if entity.hero then
				if s.template_name == "enemy_ettin" then
					self.A:inc("BRAVE_TAILOR")
				end
			elseif entity.enemy then
				if s.template_name == "bolt_plant_magic_blossom" then
					self.A:inc_check("GATHERING_MAGIC")
				end

				if s.template_name == "mod_plant_poison_pumpkin" then
					self.A:inc_check("KILLER_TOMATOES")
				end

				if s.template_name == "mod_razorboar_rampage_enemy" then
					self.A:inc_check("CALL_ME_PIG")
				end

				if s.template_name == "fireball_baby_ashbite" then
					self.A:inc_check("DND")
				end

				if s.template_name == "aura_breath_baby_ashbite" then
					self.A:inc_check("DND")
				end

				if s.template_name == "mod_black_baby_dragon" then
					self.A:inc_check("DND")
				end

				if s.template_name == "power_thunder_control" then
					self.A:inc_check("LIGHTNING_KILL")
				end

				if s.template_name == "hero_bolverk" then
					self.A:inc_check("KILL_BOLJARK")
				end
				
				if s.template_name == "power_fireball" then
					self.A:inc_check("DEATH_FROM_ABOVE")
				end

				if s.template_name == "bomb_pirate_camp" then
					self.A:inc_check("THEBLACKPEARL")
				end

				if s.template_name == "drill" then
					self.A:inc_check("DEADFROMBELOW")
				end

				if s.template_name == "soldier_death_rider" then
					self.A:inc_check("GRIMREAPER")
				end

				if s.template_name == "bomb_mecha" then
					self.A:inc_check("OPTIMUSPRIME")
				end

				if s.template_name == "missile_mecha" then
					self.A:inc_check("OPTIMUSPRIME")
				end

				if s.template_name == "carnivorous_plant" then
					self.A:inc_check("FEEDMESEYMOUR")
				end

				if s.template_name == "mod_blood" then
					self.A:inc_check("LETITBLEED")
				end

				if s.template_name == "mod_beastmaster_lash" then
					self.A:inc_check("LETITBLEED")
				end

				if string.starts(s.template_name, "arrow_soldier_re_") then
					self.A:inc_check("GREEN_ARROW")
				end

				if string.starts(s.template_name, "arrow_silver_sentence") then
					self.A:inc_check("KILLTACULAR")
				end

				if U.flag_has(entity.vis.flags, F_FLYING) and (s.template_name == "arrow_arcane_burst" or s.template_name == "aura_arcane_burst") then
					self.A:inc_check("ARCANE_BURST")
				end
				
				if s.template_name == "power_fireball" then
					self.A:inc_check("DEATH_FROM_ABOVE")
				end

				if s.template_name == "shotgun_musketeer_sniper_instakill" then
					self.A:inc_check("SNIPER")
				end

				if s.template_name == "mod_ranger_poison" then
					self.A:inc_check("TOXICITY")
				end

				if s.template_name == "mod_ray_arcane_disintegrate" then
					self.A:inc_check("DUST_TO_DUST")
				end

				if s.template_name == "mod_ray_tesla" then
					self.A:inc_check("ACDC")
				end

				if s.template_name == "mod_tesla_overcharge" then
					self.A:inc_check("ACDC")
				end

				if s.template_name == "soldier_barbarian" then
					s._barbarian_rush_counter = 1 + (s._barbarian_rush_counter or 0)

					self.A:high_check("BARBARIAN_RUSH", s._barbarian_rush_counter)
				end
---重生
				if entity.template_name == "enemy_goblin_spear" and (s.template_name == "axe_barbarian" or s.template_name == "arrow_elf" or s.template_name == "bomb_steam_troop" or s.template_name == "airstrike_steam_troop" or s.template_name == "bomb_molotov_2" or s.template_name == "spear_forest_oak" or s.template_name == "spear_forest" or s.template_name == "dagger_drow" or s.template_name == "arrow_soldier_barrack_2" or s.template_name == "arrow_soldier_barrack_3" or s.template_name == "bone_golem_bone" or s.template_name == "bomb_goblin_zapper_pos" or s.template_name == "bomb_swamp_thing_pos" or s.template_name == "spell_djinn" or s.template_name == "bullet_soldier_ewok" or s.template_name == "arrow_elite_harasser" or s.template_name == "arrow_elite_harasser_barrage") then
					self.A:inc_check("HOB_SPEAR")
				end
---				
				if table.contains({
					"soldier_drow",
					"dagger_drow"
				}, s.template_name) and table.contains({
					"enemy_arachnomancer",
					"enemy_twilight_avenger",
					"enemy_twilight_elf_harasser",
					"enemy_twilight_evoker",
					"enemy_twilight_heretic",
					"enemy_twilight_scourger"
				}, entity.template_name) then
					self.A:inc_check("JAGGED_ALLIANCE")
				end

				if string.starts(entity.template_name, "enemy_perython") and s.template_name == "bullet_gryphon" then
					self.A:inc_check("DOGFIGHT")
				end
			end
		end
	end

	if game.store.level_idx == 81 then
		if entity.enemy then
			self.A:inc_check("COME_AND_GET_THEM")
		elseif entity.soldier and not entity.hero then
			self.A:inc_check("WITH_YOUR_SHIELD")
		end
	end
	
	if entity.template_name == "enemy_halloween_zombie" and entity.moon and entity.moon.active then
		self.A:inc_check("ZOMBIE_WALK", 1)
	end
	
	if entity.template_name == "enemy_troll_skater" and entity._last_on_ice then
		self.A:inc_check("DEFEAT_COOL_RUNNING")
	elseif entity.template_name == "enemy_demon_legion" then
		local a = entity.timed_attacks.list[1]

		if not entity._summoned and a and a.count == a.generation then
			self.A:inc_check("ARMY_OF_ONE")
		end
	elseif entity.template_name == "enemy_wererat" and not entity._has_infected_soldiers then
		self.A:inc_check("RATATOUILLE")
---重生		
	elseif entity.template_name == "enemy_goblin_balloon" then
		self.A:inc_check("GOBLIN_BLOON")
	elseif entity.template_name == "eb_hobgoblin_two" then
		self.A:got("DEFEAT_HOBGOBLIN_BOSS")	
---					
	end

	if game.store.level_idx == 84 and (entity.template_name == "enemy_alien_reaper" or entity.template_name == "enemy_alien_breeder") then
		self.A:inc_check("WANT_PIECE_OF_ME")
	end
end

function ah:h_entity_revived(entity, count)
	if entity.template_name == "soldier_templar" then
		self.A:high_check("HIGHLANDER", count)
	end
end

function ah:h_game_victory(store)
	local slot = storage:load_slot()
	local go = store.game_outcome

	if store.level_idx == 1 and store.game_outcome and store.game_outcome.stars == 3 then
		self.A:got("GET_PARTY_STARTED")
	elseif store.level_idx == 3 and store.level_mode == GAME_MODE_CAMPAIGN then
		if self.A:get_count("SHEZI_BANZAI_ED") < 3 then
			self.A:got("SHEZI_BANZAI_ED")
		end
	elseif store.level_idx == 4 and store.level_mode == GAME_MODE_CAMPAIGN then
		if self.A:get_count("BRAVE_TAILOR") == 0 then
			self.A:got("BRAVE_TAILOR")
		end
	elseif store.level_idx == 5 and store.level_mode == GAME_MODE_CAMPAIGN and self.A:get_count("ACE_SPADES") == 0 then
		self.A:got("ACE_SPADES")
	end
	
	if store.level_idx == 23 then
		self.A:got("ANDSOITBEGINS")
	end

	if store.level_idx == 26 and store.level_mode == GAME_MODE_CAMPAIGN and self.A:get_count("MUADIB") == 0 then
		self.A:got("MUADIB")
	end

	if store.level_idx == 42 and store.level_mode == GAME_MODE_CAMPAIGN and self.A:get_count("GHOSTBUSTERS") == 0 then
		self.A:got("GHOSTBUSTERS")
	end
	
	if store.level_idx == 50 then
		local count = 0

		for _, e in pairs(store.entities) do
			if e.template_name == "soldier_s6_imperial_guard" and not e.health.dead then
				count = count + 1
			end
		end

		self.A:high_check("IMPERIAL_SAVIOUR", count)
	elseif store.level_idx == 57 then
		self.A:got("DEFEAT_SARELGAZ")
	elseif store.level_idx == 58 then
		self.A:got("DEFEAT_GULTHAK_BOSS")
	elseif store.level_idx == 59 then
		self.A:got("DEFEAT_TREANT_BOSS")
	end

	local sentinels = table.filter(store.entities, function(_, e)
		return e.template_name == "high_elven_sentinel"
	end)

	self.A:high_check("SENTINEL", #sentinels)

	if store.main_hero and not store.main_hero._death_count then
		self.A:inc_check("HOLDING_OUT")
		self.A:inc_check("NOT_TODAY")
	end

	if store.level_terrain_type == TERRAIN_STYLE_DESERT then
		if self.A:get_count("SANDWARRIOR") == 0 then
			self.A:got("SANDWARRIOR")
		end
	elseif store.level_terrain_type == TERRAIN_STYLE_JUNGLE then
		if self.A:get_count("TARZANBOY") == 0 then
			self.A:got("TARZANBOY")
		end
	elseif store.level_terrain_type == TERRAIN_STYLE_UNDERGROUND and self.A:get_count("CAVEMAN") == 0 then
		self.A:got("CAVEMAN")
	end

	local stars = 0

	if slot and slot.levels then
		for i = 1, GS.last_level do
			local l = slot.levels[i]

			if not l then
				log.debug("level %i missing in slot.levels", i)
			elseif i == go.level_idx then
				local l_stars = l.stars or 0
				local go_stars = go.stars or 0

				stars = stars + (go.level_mode == GAME_MODE_CAMPAIGN and math.max(l_stars, go_stars) or l_stars) + (not (go.level_mode ~= GAME_MODE_HEROIC and not l[GAME_MODE_HEROIC]) and 1 or 0) + (not (go.level_mode ~= GAME_MODE_IRON and not l[GAME_MODE_IRON]) and 1 or 0)
			else
				stars = stars + (l.stars or 0) + (l[GAME_MODE_HEROIC] and 1 or 0) + (l[GAME_MODE_IRON] and 1 or 0)
			end

			log.paranoid("level:%s stars:%s", i, stars)
		end
	end

	self.A:ge_check("STARGAZER", stars)
	self.A:ge_check("STARDUST", stars)
	self.A:ge_check("ROCKSTAR", stars)
	
	if slot and slot.levels and go.level_mode == GAME_MODE_CAMPAIGN then
		local areas = {
			{
				ach = "ROBIN_OF_SHERWOOD",
				to = 6,
				from = 1
			},
			{
				ach = "TINKERBELL",
				to = 11,
				from = 7
			},
			{
				ach = "FORBIDDEN_RUINS",
				to = 15,
				from = 12
			},
			{
				ach = "STARFIELD",
				to = 15,
				from = 1
			}
		}

		for _, area in pairs(areas) do
			if not self.A:have(area.ach) then
				local passes = true

				for i = area.from, area.to do
					local l = slot.levels[i]

					if not l then
						log.debug("level %i missing in slot.levels", i)

						passes = false
					elseif i == go.level_idx then
						passes = passes and math.max(l.stars or 0, go.stars or 0) == 3
					else
						passes = passes and l.stars == 3
					end
				end

				if passes then
					self.A:got(area.ach)
				end
			end
		end
	end

	local done_c, done_h, done_i, done_g, done_imp = true, true, true, true, true

	if slot and slot.levels then
		for i = 1, GS.main_campaign_levels do
			local lv = table.deepclone(slot.levels[i])

			if not lv then
				done_c, done_h, done_i, done_g = false, false, false, false

				break
			end

			if i == store.level_idx then
				lv[store.level_mode] = store.level_difficulty
			end

			done_c = done_c and lv[GAME_MODE_CAMPAIGN] ~= nil
			done_h = done_h and lv[GAME_MODE_HEROIC] ~= nil
			done_i = done_i and lv[GAME_MODE_IRON] ~= nil
			done_g = done_g and lv[GAME_MODE_CAMPAIGN] and lv[GAME_MODE_CAMPAIGN] >= DIFFICULTY_HARD
			done_imp = done_imp and lv[GAME_MODE_CAMPAIGN] == DIFFICULTY_IMPOSSIBLE
		end
	end

	if store.level_mode == GAME_MODE_CAMPAIGN then
		if done_c then
			self.A:got("GREAT_DEFENDER")
		end

		if done_g then
			self.A:got("HARD_MODE")
		end

		if done_imp then
			self.A:got("IMPOSSIBLE_MODE")
---重生			
			self.A:got("DEFEAT_COMPLETE_IMPOSSIBLE")
---					
		end
	elseif store.level_mode == GAME_MODE_HEROIC and done_h then
		self.A:got("GREAT_DEFENDER_HEROIC")
	elseif store.level_mode == GAME_MODE_IRON and done_i then
		self.A:got("GREAT_DEFENDER_IRON")
	end
end

function ah:h_health_regen(entity, amount)
	if entity and entity.soldier then
		self.A:inc_check("DIE_HARD", amount)
	end
end

function ah:h_hero_level_increased(entity)
	self.A:got("HEROLEVELUP")

	if entity.hero then
		self.A:high_check("HERO_OF_THE_DAY", entity.hero.level)
	end

	if entity.hero then
		self.A:high_check("LEGENDARY", entity.hero.level)
		self.A:high_check("HERO_MEDIUM", entity.hero.level)
		self.A:high_check("HERO_HARD", entity.hero.level)
	end
	
	if not self.A:have("DING_DING") then
		local slot = storage:load_slot()
		local list = {
			"hero_elves_archer",
			"hero_arivan",
			"hero_catha"
		}
		local pass = true

		for _, hn in pairs(list) do
			local xp

			if entity.template_name == hn then
				xp = entity.hero.xp or 0
			else
				local h = slot.heroes.status[hn]

				xp = h and h.xp or 0
			end

			local hl = U.get_hero_level(xp, GS.hero_xp_thresholds)

			if hl < 10 then
				pass = false

				break
			end
		end

		if pass then
			self.A:got("DING_DING")
		end
	end
end

function ah:h_mod_applied(mod, target)
	if not self.A:have("DARK_CRYSTAL") and string.starts(mod.template_name, "mod_faerie_dragon_l") then
		target._mod_faerie_dragon_total = (target._mod_faerie_dragon_total or 0) + mod.modifier.duration

		self.A:high_check("DARK_CRYSTAL", target._mod_faerie_dragon_total)
	end

	if mod.template_name == "mod_crystal_arcane_freeze" then
		self.A:inc_check("FROZEN")
	end

	if mod.template_name == "mod_forest_circle" then
		target._mod_forest_circle_count = (target._mod_forest_circle_count or 0) + 1

		self.A:high_check("KINGSFOIL", target._mod_forest_circle_count)
	end

	if mod.template_name == "mod_timelapse" then
		self.A:inc_check("PHANTOMZONED", mod.modifier.duration)
	end

	if mod.template_name == "mod_eldritch" then
		self.A:inc_check("ELDRITCH_DOOM")
	end

	if mod.template_name == "mod_paralyzing_tree" then
		self.A:inc_check("NIMLOTH")
	end
	
	if mod.template_name == "mod_weakness_totem" then
		self.A:inc_check("NOCOUNTRYFORWEAKMAN", 1)
	end
	
	if mod.template_name == "mod_thorn" then
		self.A:inc_check("ENTANGLED")
	elseif mod.template_name == "mod_teleport_arcane" then
		self.A:inc_check("BEAM_ME_UP")
	elseif mod.template_name == "mod_polymorph_sorcerer" then
		self.A:inc_check("SHEPARD")
	elseif mod.template_name == "mod_wererat_poison" then
		local s = game.store.entities[mod.modifier.source_id]

		if s then
			s._has_infected_soldiers = true
		end
---重生		
	elseif mod.template_name == "mod_sandstorm_slow" then
		self.A:inc_check("TIME_WIZARD_SLOW")
	elseif mod.template_name == "mod_teleport_ancient_guardian" then
		self.A:inc_check("ANCIENT_GUARD_TELE")
	elseif mod.template_name == "mod_steam_troop_freeze" then
		self.A:inc_check("STEAM_TROOP_FREEZE")	
---			
	end

	if mod.template_name == "mod_silence_totem" then
		local names = {
			"enemy_munra",
			"enemy_shaman_shield",
			"enemy_shaman_magic",
			"enemy_shaman_priest",
			"enemy_shaman_necro",
			"enemy_darter",
			"enemy_nightscale",
			"enemy_savant"
		}

		if target and table.contains(names, target.template_name) then
			self.A:inc_check("SILENCEPLEASE", 1)
		end
	end

	if mod.template_name == "mod_crossbow_eagle" then
		local active = self.A:count_active_mods("mod_crossbow_eagle", function(m)
			return m.modifier.source_id == mod.modifier.source_id
		end)

		self.A:high_check("HAWKEYE", active + 1 - 1)
	end

	if mod.template_name == "mod_lava" and not self.A:have("POPULARBBQ") then
		self.A:high_check("POPULARBBQ", self.A:count_active_mods("mod_lava") + 1)
	end
	
end

function ah:h_next_wave_ready(group)
	if group.group_idx > 1 then
		self.A:lap_start("IMPATIENT")
	end
end

function ah:h_notification_shown(n)
	if n.ach_id and n.ach_flag then
		self.A:flag_check(n.ach_id, n.ach_flag)
	end
	if n.layout == N_ENEMY or n.template == "enemy" then
		self.A:inc_check("WHATS_THAT", 1)
	end
end

function ah:h_power_used(power_id)
	if power_id == 1 then
		self.A:reset_counters(P_POWER_1)
		self.A:inc_check("ARMAGGEDON", 1)
	elseif power_id == 2 then
		self.A:inc_check("VOLUNTEER_TRIBUTE", 2)
	end
end

function ah:h_rally_point_changed(tower)
	self.A:inc_check("TACTICIAN", 1)
end

function ah:h_soldier_attack(entity, attack, signal_prop)
	if not self.A:have("TWISTANDSHOUT") and signal_prop == "whirlwind" then
		self.A:inc_check("TWISTANDSHOUT", 1)
	end
	if signal_prop == "holystrike" then
		self.A:inc_check("HOLY_CHORUS")
	end
end

function ah:h_soldier_dodge(entity)
	self.A:inc_check("DODGETHIS", 1)
end

function ah:h_soldier_pickpocket(entity, amount)
	if entity.template_name == "soldier_assassin" then
		self.A:inc_check("ALIBABA", amount)
	end
end

function ah:h_tower_removed(tower)
	if tower.tower and tower.tower.sell then
		self.A:inc_check("REAL_STATE")
		self.A:inc_check("INDECISIVE")
	end
end

function ah:h_tower_spawn(tower, entity)
	if entity and entity.soldier then
		self.A:inc_check("GI_JOE", 1)
	end

	if not self.A:have("MONEYTALKS") and string.find(tower.tower.type, "mercenaries_") then
		self.A:inc_check("MONEYTALKS", 1)
	end
	
	if tower.template_name == "tower_elf" and #tower.barrack.soldiers == tower.barrack.max_soldiers then
		self.A:got("MAX_ELVES")
	end
end

function ah:h_tower_upgraded(new_tower, old_tower)
	if not self.A:have("ACE_SPADES") and new_tower.template_name == "tower_barrack_1" then
		self.A:inc("ACE_SPADES")
	end
	
	if new_tower.template_name == "tower_tesla" then
		self.A:inc_check("ENERGY_NETWORK")
	end
---重生
	if new_tower.template_name == "tower_steam_troop" then
		self.A:inc_check("STEAM_TROOP_IND")
	end
---	
	if not self.A:have("SIMCITY") then
		local excluded_templates = {
			"tower_faerie_dragon",
			"tower_faerie_dragon_d",
			"tower_pixie",
			"tower_pixie_d",
			"tower_black_baby_dragon",
			"tower_black_baby_dragon_d",
			"tower_holder_baby_ashbite",
			"tower_holder_baby_ashbite_d",
			"tower_baby_ashbite",
			"tower_baby_ashbite_d",
			"tower_drow",
			"tower_drow_d",
			"tower_bastion_holder",
			"tower_bastion",
			"tower_bastion_d"
		}
		local towers = E:filter(game.store.entities, "tower")

		table.insert(towers, new_tower)

		local pass = true

		for _, t in pairs(towers) do
			if t.id ~= old_tower.id and not table.contains(excluded_templates, t.template_name) and not table.contains(special_templates, t.template_name) then
				pass = false

				break
			end
		end

		if pass then
			self.A:got("SIMCITY")
		end
	end
	
	if not self.A:have("LANDOWNER") then
		local holders = E:filter(game.store.entities, "tower_holder")

		if #holders == 1 and holders[1].id == old_tower.id then
			self.A:got("LANDOWNER")
		end
	end

	if old_tower.tower_holder and not new_tower.tower_holder then
		self.A:inc_check("EASY_TOWER_BUILDER", 1)
		self.A:inc_check("MEDIUM_TOWER_BUILDER", 1)
		self.A:inc_check("HARD_TOWER_BUILDER", 1)
	end

	if not self.A:have("UPGRADE_LEVEL3") then
		if new_tower.template_name == "g2_tower_archer_3" then
			self.A:flag_check("UPGRADE_LEVEL3", 1)
		end

		if new_tower.template_name == "g2_tower_barrack_3" then
			self.A:flag_check("UPGRADE_LEVEL3", 2)
		end

		if new_tower.template_name == "g2_tower_engineer_3" then
			self.A:flag_check("UPGRADE_LEVEL3", 4)
		end

		if new_tower.template_name == "g2_tower_mage_3" then
			self.A:flag_check("UPGRADE_LEVEL3", 8)
		end
	end

	if not self.A:have("SPECIALIZATION") then
		if new_tower.template_name == "tower_archmage" or new_tower.template_name == "tower_arcane_wizard" then
			self.A:flag_check("SPECIALIZATION", 1)
		end

		if new_tower.template_name == "tower_assassin" or new_tower.template_name == "tower_sorcerer" then
			self.A:flag_check("SPECIALIZATION", 2)
		end

		if new_tower.template_name == "tower_crossbow" or new_tower.template_name == "tower_bfg" then
			self.A:flag_check("SPECIALIZATION", 4)
		end

		if new_tower.template_name == "tower_dwaarp" or new_tower.template_name == "tower_tesla" then
			self.A:flag_check("SPECIALIZATION", 8)
		end

		if new_tower.template_name == "tower_mech" or new_tower.template_name == "tower_ranger" then
			self.A:flag_check("SPECIALIZATION", 16)
		end

		if new_tower.template_name == "tower_necromancer" or new_tower.template_name == "tower_musketeer" then
			self.A:flag_check("SPECIALIZATION", 32)
		end

		if new_tower.template_name == "tower_templar" or new_tower.template_name == "tower_paladin" then
			self.A:flag_check("SPECIALIZATION", 64)
		end

		if new_tower.template_name == "tower_totem" or new_tower.template_name == "tower_barbarian" then
			self.A:flag_check("SPECIALIZATION", 128)
		end
		
	end

	if not self.A:have("DIVIDEANDCONQUER") then
		if new_tower.template_name == "tower_archmage" then
			self.A:flag_check("DIVIDEANDCONQUER", 1)
		end

		if new_tower.template_name == "tower_assassin" then
			self.A:flag_check("DIVIDEANDCONQUER", 2)
		end

		if new_tower.template_name == "tower_crossbow" then
			self.A:flag_check("DIVIDEANDCONQUER", 4)
		end

		if new_tower.template_name == "tower_dwaarp" then
			self.A:flag_check("DIVIDEANDCONQUER", 8)
		end

		if new_tower.template_name == "tower_mech" then
			self.A:flag_check("DIVIDEANDCONQUER", 16)
		end

		if new_tower.template_name == "tower_necromancer" then
			self.A:flag_check("DIVIDEANDCONQUER", 32)
		end

		if new_tower.template_name == "tower_templar" then
			self.A:flag_check("DIVIDEANDCONQUER", 64)
		end

		if new_tower.template_name == "tower_totem" then
			self.A:flag_check("DIVIDEANDCONQUER", 128)
		end
	end

	if not self.A:have("LANDMANAGER") and old_tower.tower_holder and old_tower.tower_holder.blocked then
		self.A:inc_check("LANDMANAGER", 1)
	end

	if new_tower.template_name == "tower_mech" then
		self.A:inc_check("MECHWARRIOR")
	end
end

function ah:h_tower_power_upgraded(tower, power)
	if tower.template_name == "tower_sorcerer" and tower.powers.elemental == power and power.level == 1 then
		self.A:inc_check("ELEMENTALIST")
	end
end

function ah:h_moon_changed(moon_active, store)
	if moon_active then
		self._moon_start_lives = store.lives
	elseif self._moon_start_lives == store.lives and store.lives > 0 then
		self.A:inc_check("MOONWALKER", 1)
	end
end

function ah:h_enemy_reached_goal(entity)
	if entity.template_name == "enemy_ghost" then
		self.A:inc("GHOSTBUSTERS")
	end
end

function ah:h_next_wave_sent(group)
	if game.store.level_idx == 81 then
		self.A:inc_check("HOLD_THE_LINE")
		self.A:inc_check("NOT_YET")
		self.A:inc_check("THE_ODDS")
	elseif game.store.level_idx == 82 then
		self.A:inc_check("STAND_YOUR_GROUND")
		self.A:inc_check("RED_SUN")
	elseif game.store.level_idx == 84 then
		self.A:inc_check("COME_ON_YOU_APES")
	end
end

function ah:h_aura_apply_mod_victims(aura, victims_count)
	if aura.template_name == "aura_rotten_lesser_death" and victims_count == 0 then
		self.A:inc_check("SPORE")
	end
end

return ah