-- chunkname: @./kr3/game_settings.lua

local GS = {}

GS.url_strategy_guide = "http://www.kingdomrushorigins.com/strategy.html"
GS.url_twitter = "https://twitter.com/ironhidegames"
GS.url_facebook = "http://www.facebook.com/ironhidegames"
GS.url_policy = "https://www.ironhidegames.com/PrivacyPolicy"
GS.gameplay_tips_count = 84
GS.early_wave_reward_per_second = 1--需要判断是不是5代关卡，是的话需要乘以1.8
GS.early_wave_reward_per_second5 = 1.8
GS.max_stars = 533
GS.max_difficulty = DIFFICULTY_IMPOSSIBLE
GS.difficulty_soldier_hp_max_factor = {
	1.2,
	1,
	1,
	1
}
GS.difficulty_enemy_hp_max_factor = {
	0.8,
	1,
	1.2,
	1.5
}
GS.difficulty_enemy_speed_factor = {
	1,
	1,
	1,
	1.1
}
GS.difficulty_enemy_gold_factor = {
	1,
	0.65,
	0.5,
}
GS.main_campaign_levels = 15
GS.main_campaign_levels3 = 15
GS.main_campaign_levels2 = 37
GS.main_campaign_levels1 = 56
GS.main_campaign_levels5 = 116
GS.last_level = 22
GS.last_level3 = 22
GS.last_level2 = 44
GS.last_level1 = 75---重生--72
GS.last_level5 = 135
GS.jnum1 = 44
GS.max_level1 = 31---重生--28
GS.jnum2 = 22
GS.max_level2 = 22
GS.jnum3 = 0
GS.max_level3 = 22
GS.jnum5 = 100
GS.max_level5 = 35
GS.endless_levels_count = 2
GS.level_ranges = {
	{
		1,
		15
	},
	{
		16,
		18
	},
	{
		19,
		20
	},
	{
		21,
		22
	}
}
GS.level_ranges3 = {
	{
		1,
		15
	},
	{
		16,
		18
	},
	{
		19,
		20
	},
	{
		21,
		22
	}
}
GS.level_ranges2 = {
	{
		23,
		37
	},
	{
		38,
		40
	},
	{
		41,
		43
	},
	{
		44
	}
}
GS.level_ranges1 = {
	{
		45,
		56
	},
	{
		57
	},
	{
		58
	},
	{
		59,
		66,
		list = true
	},
	{
		60,
		61
	},
	{
		62,
		63
	},
	{
		64,
		65
	},
	{
		67,
		70
	},
	{
		71,
		72
	},
}
GS.level_ranges5 = {
	{
		101,
		116
	},
	{
		117,
		119
	},
	{
		120,
		122
	},
	{
		123,
		127
	},
	{
		128,
		130
	},
	{
		131,
		135
	},
}

GS.default_hero = "hero_elves_archer"
GS.hero_xp_thresholds = {
	300,
	900,
	2000,
	4800,
	8000,
	12000,
	16000,
	20000,
	26000
}

GS.hero_level_expected = {
	1,
	1,
	2,
	2,
	3,
	4,
	5,
	5,
	6,
	7,
	8,
	9,
	9,
	10,
	10,
	8,
	9,
	10,
	8,
	9,
	10,
	10
}
GS.hero_level_expected[81] = 1
GS.hero_level_expected[82] = 1
GS.hero_level_expected[83] = 1
GS.hero_level_expected[84] = 1
GS.hero_level_expected[85] = 1
GS.hero_level_expected_multipliers_below = {
	1,
	2
}
GS.hero_level_expected_multipliers_above = {
	0.5,
	0.25
}
GS.hero_xp_gain_per_difficulty_mode = {
	[DIFFICULTY_EASY] = 2,
	[DIFFICULTY_NORMAL] = 1.1,
	[DIFFICULTY_HARD] = 1,
	[DIFFICULTY_IMPOSSIBLE] = 1
}
GS.skill_points_for_hero_level = {
	0,
	4,
	8,
	12,
	16,
	20,
	24,
	28,
	32,
	36
}
GS.endless_gems_for_wave = 1
GS.gems_factor_per_mode = {
	0.8,
	0.48,
	0.48
}
GS.gems_per_level = {
	100,
	150,
	200,
	250,
	250,
	275,
	275,
	300,
	300,
	325,
	325,
	350,
	350,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	100,
	150,
	200,
	250,
	250,
	275,
	275,
	300,
	300,
	325,
	325,
	350,
	350,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400,
	400
}
GS.tower_room_tower_thumb_fmt = "kra_main_icons_%04d"--"quickmenu_main_icons_main_icons_0%03i_0001" -- 5和14缺失
GS.encyclopedia_tower_fmt = "encyclopedia_towers_0%03i"
GS.encyclopedia_tower_thumb_fmt = "encyclopedia_tower_thumbs_0%03i"
GS.encyclopedia_enemy_fmt = "encyclopedia_creeps_0%03i"
GS.encyclopedia_enemy_thumb_fmt = "encyclopedia_creep_thumbs_0%03i"
GS.encyclopedia_enemies = {
	{
		always_shown = true,
		name = "enemy_gnoll_reaver"
	},
	{
		name = "enemy_gnoll_burner"
	},
	{
		name = "enemy_gnoll_gnawer"
	},
	{
		name = "enemy_hyena"
	},
	{
		name = "enemy_perython"
	},
	{
		name = "enemy_gnoll_blighter"
	},
	{
		name = "enemy_ettin"
	},
	{
		name = "enemy_twilight_elf_harasser"
	},
	{
		name = "eb_gnoll"
	},
	{
		name = "enemy_gnoll_warleader"
	},
	{
		name = "enemy_sword_spider"
	},
	{
		name = "enemy_satyr_cutthroat"
	},
	{
		name = "enemy_satyr_hoplite"
	},
	{
		name = "enemy_webspitting_spider"
	},
	{
		name = "enemy_gloomy"
	},
	{
		name = "enemy_twilight_scourger"
	},
	{
		name = "enemy_bandersnatch"
	},
	{
		name = "enemy_redcap"
	},
	{
		name = "enemy_twilight_avenger"
	},
	{
		name = "enemy_boomshrooms"
	},
	{
		name = "enemy_munchshrooms"
	},
	{
		name = "enemy_shroom_breeder"
	},
	{
		name = "eb_drow_queen"
	},
	{
		name = "enemy_razorboar"
	},
	{
		name = "enemy_twilight_evoker"
	},
	{
		name = "enemy_twilight_golem"
	},
	{
		name = "enemy_mantaray"
	},
	{
		name = "enemy_spider_arachnomancer"
	},
	{
		name = "enemy_twilight_heretic"
	},
	{
		name = "enemy_spider_son_of_mactans"
	},
	{
		name = "enemy_arachnomancer"
	},
	{
		name = "enemy_drider"
	},
	{
		name = "eb_spider"
	},
	{
		name = "enemy_gnoll_bloodsydian"
	},
	{
		name = "enemy_bloodsydian_warlock"
	},
	{
		name = "enemy_ogre_magi"
	},
	{
		name = "eb_bram"
	},
	{
		name = "enemy_blood_servant"
	},
	{
		name = "enemy_screecher_bat"
	},
	{
		name = "enemy_mounted_avenger"
	},
	{
		name = "eb_bajnimen"
	},
	{
		name = "enemy_twilight_brute"
	},
	{
		name = "enemy_shadows_spawns"
	},
	{
		name = "enemy_grim_devourers"
	},
	{
		name = "enemy_dark_spitters"
	},
	{
		name = "enemy_shadow_champion"
	},
	{
		name = "eb_balrog"
	},
	--2代
	{
		always_shown = true,
		name = "enemy_bouncer"
	},
	{
		name = "enemy_desert_raider"
	},
	{
		name = "enemy_desert_archer"
	},
	{
		name = "enemy_desert_wolf_small"
	},
	{
		name = "enemy_desert_wolf"
	},
	{
		name = "enemy_immortal"
	},
	{
		name = "enemy_fallen"
	},
	{
		name = "enemy_executioner"
	},
	{
		name = "enemy_scorpion"
	},
	{
		name = "enemy_wasp"
	},
	{
		name = "enemy_wasp_queen"
	},
	{
		name = "enemy_tremor"
	},
	{
		name = "enemy_munra"
	},
	{
		name = "enemy_jungle_spider_small"
	},
	{
		name = "enemy_jungle_spider_big"
	},
	{
		name = "enemy_cannibal"
	},
	{
		name = "enemy_hunter"
	},
	{
		name = "enemy_shaman_priest"
	},
	{
		name = "enemy_shaman_shield"
	},
	{
		name = "enemy_shaman_magic"
	},
	{
		name = "enemy_shaman_necro"
	},
	{
		name = "enemy_cannibal_zombie"
	},
	{
		name = "enemy_gorilla"
	},
	{
		name = "enemy_savage_bird_rider"
	},
	{
		name = "enemy_alien_breeder"
	},
	{
		name = "enemy_alien_reaper"
	},
	{
		name = "enemy_razorwing"
	},
	{
		name = "enemy_quetzal"
	},
	{
		name = "enemy_broodguard"
	},
	{
		name = "enemy_myrmidon"
	},
	{
		name = "enemy_blazefang"
	},
	{
		name = "enemy_nightscale"
	},
	{
		name = "enemy_darter"
	},
	{
		name = "enemy_brute"
	},
	{
		name = "enemy_savant"
	},
	{
		name = "enemy_efreeti_small"
	},
	{
		name = "eb_efreeti"
	},
	{
		name = "enemy_gorilla_small"
	},
	{
		name = "eb_gorilla"
	},
	{
		name = "enemy_umbra_minion"
	},
	{
		name = "eb_umbra"
	},
	{
		name = "enemy_greenfin"
	},
	{
		name = "enemy_deviltide"
	},
	{
		name = "enemy_redspine"
	},
	{
		name = "enemy_blacksurge"
	},
	{
		name = "enemy_bluegale"
	},
	{
		name = "enemy_bloodshell"
	},
	{
		name = "eb_leviathan"
	},
	{
		name = "enemy_halloween_zombie"
	},
	{
		name = "enemy_ghoul"
	},
	{
		name = "enemy_bat"
	},
	{
		name = "enemy_werewolf"
	},
	{
		name = "enemy_abomination"
	},
	{
		name = "enemy_lycan"
	},
	{
		name = "enemy_ghost"
	},
	{
		name = "enemy_phantom_warrior"
	},
	{
		name = "enemy_elvira"
	},
	{
		name = "eb_dracula"
	},
	{
		name = "enemy_sniper"
	},
	{
		name = "eb_saurian_king"
	},
	--1代
	{
		always_shown = true,
		name = "enemy_goblin"
	},
	{
		name = "enemy_fat_orc"
	},
	{
		name = "enemy_shaman"
	},
	{
		name = "enemy_ogre"
	},
	{
		name = "enemy_bandit"
	},
	{
		name = "enemy_brigand"
	},
	{
		name = "enemy_marauder"
	},
	{
		name = "enemy_spider_small"
	},
	{
		name = "enemy_spider_big"
	},
	{
		name = "enemy_gargoyle"
	},
	{
		name = "enemy_shadow_archer"
	},
	{
		name = "enemy_dark_knight"
	},
	{
		name = "enemy_wolf_small"
	},
	{
		name = "enemy_wolf"
	},
	{
		name = "enemy_golem_head"
	},
	{
		name = "enemy_whitewolf"
	},
	{
		name = "enemy_troll"
	},
	{
		name = "enemy_troll_axe_thrower"
	},
	{
		name = "enemy_troll_chieftain"
	},
	{
		name = "enemy_yeti"
	},
	{
		name = "enemy_rocketeer"
	},
	{
		name = "enemy_slayer"
	},
	{
		name = "enemy_demon"
	},
	{
		name = "enemy_demon_mage"
	},
	{
		name = "enemy_demon_wolf"
	},
	{
		name = "enemy_demon_imp"
	},
	{
		name = "enemy_skeleton"
	},
	{
		name = "enemy_skeleton_big"
	},
	{
		name = "enemy_necromancer"
	},
	{
		name = "enemy_lava_elemental"
	},
	{
		name = "enemy_sarelgaz_small"
	},
	{
		name = "eb_juggernaut"
	},
	{
		name = "eb_jt"
	},
	{
		name = "eb_veznan"
	},
	{
		name = "eb_sarelgaz"
	},
	{
		name = "enemy_goblin_zapper"
	},
	{
		name = "enemy_orc_armored"
	},
	{
		name = "enemy_orc_rider"
	},
	{
		name = "enemy_forest_troll"
	},
	{
		name = "eb_gulthak"
	},
	{
		name = "enemy_zombie"
	},
	{
		name = "enemy_spider_rotten"
	},
	{
		name = "enemy_rotten_tree"
	},
	{
		name = "enemy_swamp_thing"
	},
	{
		name = "eb_greenmuck"
	},
	{
		name = "enemy_raider"
	},
	{
		name = "enemy_pillager"
	},
	{
		name = "eb_kingpin"
	},
	{
		name = "enemy_troll_skater"
	},
	{
		name = "enemy_troll_brute"
	},
	{
		name = "eb_ulgukhai"
	},
	{
		name = "enemy_demon_legion"
	},
	{
		name = "enemy_demon_flareon"
	},
	{
		name = "enemy_demon_gulaemon"
	},
	{
		name = "enemy_demon_cerberus"
	},
	{
		name = "eb_moloch"
	},
	{
		name = "enemy_rotten_lesser"
	},
	{
		name = "eb_myconid"
	},
	-- {
	-- 	name = "enemy_halloween_zombie"
	-- },
	{
		name = "enemy_giant_rat"
	},
	{
		name = "enemy_wererat"
	},
	{
		name = "enemy_fallen_knight"
	},
	{
		name = "enemy_spectral_knight"
	},
	-- {
	-- 	name = "enemy_abomination"
	-- },
	{
		name = "enemy_witch"
	},
	-- {
	-- 	name = "enemy_werewolf"
	-- },
	-- {
	-- 	name = "enemy_lycan"
	-- },
	{
		name = "eb_blackburn"
	},
	--5代
	{
		always_shown = false,
		name = "enemy_hog_invader"
	},
	{
		always_shown = false,
		name = "enemy_tusked_brawler"
	},
	{
		always_shown = false,
		name = "enemy_cutthroat_rat"
	},
	{
		always_shown = false,
		name = "enemy_bear_vanguard"
	},
	{
		always_shown = false,
		name = "enemy_turtle_shaman"
	},
	{
		always_shown = false,
		name = "enemy_surveyor_harpy"
	},
	{
		always_shown = false,
		name = "enemy_dreadeye_viper"
	},
	{
		always_shown = false,
		name = "enemy_hyena5"
	},
	{
		always_shown = false,
		name = "enemy_skunk_bombardier"
	},
	{
		always_shown = false,
		name = "enemy_bear_woodcutter"
	},
	{
		always_shown = false,
		name = "enemy_rhino"
	},
	{
		always_shown = false,
		name = "boss_pig"
	},
	{
		always_shown = false,
		name = "enemy_acolyte"
	},
	{
		always_shown = false,
		name = "enemy_acolyte_tentacle"
	},
	{
		always_shown = false,
		name = "enemy_small_stalker"
	},
	{
		always_shown = false,
		name = "enemy_lesser_sister"
	},
	{
		always_shown = false,
		name = "enemy_lesser_sister_nightmare"
	},
	{
		always_shown = false,
		name = "enemy_spiderling"
	},
	{
		always_shown = false,
		name = "enemy_unblinded_priest"
	},
	{
		always_shown = false,
		name = "enemy_unblinded_abomination"
	},
	{
		always_shown = false,
		name = "enemy_unblinded_abomination_stage_8"
	},
	{
		always_shown = false,
		name = "enemy_armored_nightmare"
	},
	{
		always_shown = false,
		name = "enemy_unblinded_shackler"
	},
	{
		always_shown = false,
		name = "enemy_corrupted_stalker"
	},
	{
		always_shown = false,
		name = "enemy_stage_11_cult_leader_illusion"
	},
	{
		always_shown = false,
		name = "enemy_blinker"
	},
	{
		always_shown = false,
		name = "enemy_crystal_golem"
	},
	{
		always_shown = false,
		name = "enemy_glareling"
	},
	{
		always_shown = false,
		name = "boss_corrupted_denas"
	},
	{
		always_shown = false,
		name = "enemy_mindless_husk"
	},
	{
		always_shown = false,
		name = "enemy_vile_spawner"
	},
	{
		always_shown = false,
		name = "enemy_lesser_eye"
	},
	{
		always_shown = false,
		name = "enemy_noxious_horror"
	},
	{
		always_shown = false,
		name = "enemy_hardened_horror"
	},
	{
		always_shown = false,
		name = "enemy_amalgam"
	},
	{
		always_shown = false,
		name = "enemy_evolving_scourge"
	},
	{
		always_shown = false,
		name = "boss_cult_leader"
	},
	{
		always_shown = false,
		name = "controller_stage_16_overseer"
	},
	{
		always_shown = false,
		name = "enemy_corrupted_elf"
	},
	{
		always_shown = false,
		name = "enemy_specter"
	},
	{
		always_shown = false,
		name = "enemy_bane_wolf"
	},
	{
		always_shown = false,
		name = "enemy_dust_cryptid"
	},
	{
		always_shown = false,
		name = "enemy_deathwood"
	},
	{
		always_shown = false,
		name = "enemy_revenant_soulcaller"
	},
	{
		always_shown = false,
		name = "enemy_animated_armor"
	},
	{
		always_shown = false,
		name = "enemy_revenant_harvester"
	},
	{
		always_shown = false,
		name = "boss_navira"
	},
	{
		always_shown = false,
		name = "enemy_crocs_basic"
	},
	{
		always_shown = false,
		name = "enemy_crocs_basic_egg"
	},
	{
		always_shown = false,
		name = "enemy_crocs_ranged"
	},
	{
		always_shown = false,
		name = "enemy_crocs_flier"
	},
	{
		always_shown = false,
		name = "enemy_killertile"
	},
	{
		always_shown = false,
		name = "enemy_quickfeet_gator"
	},
	{
		always_shown = false,
		name = "enemy_crocs_egg_spawner"
	},
	{
		always_shown = false,
		name = "enemy_crocs_shaman"
	},
	{
		always_shown = false,
		name = "enemy_crocs_hydra"
	},
	{
		always_shown = false,
		name = "enemy_crocs_tank"
	},
	{
		always_shown = false,
		name = "boss_crocs_lvl1"
	},
	{
		always_shown = false,
		name = "enemy_darksteel_hammerer"
	},
	{
		always_shown = false,
		name = "enemy_scrap_speedster"
	},
	{
		always_shown = false,
		name = "enemy_darksteel_shielder"
	},
	{
		always_shown = false,
		name = "enemy_darksteel_guardian"
	},
	{
		always_shown = false,
		name = "enemy_surveillance_sentry"
	},
	{
		always_shown = false,
		name = "enemy_rolling_sentry"
	},
	{
		always_shown = false,
		name = "enemy_brute_welder"
	},
	{
		always_shown = false,
		name = "enemy_darksteel_fist"
	},
	{
		always_shown = false,
		name = "enemy_machinist"
	},
	{
		always_shown = false,
		name = "enemy_mad_tinkerer"
	},
	{
		always_shown = false,
		name = "enemy_scrap_drone"
	},
	{
		always_shown = false,
		name = "boss_machinist"
	},
	{
		always_shown = false,
		name = "enemy_darksteel_anvil"
	},
	{
		always_shown = false,
		name = "enemy_common_clone"
	},
	{
		always_shown = false,
		name = "enemy_darksteel_hulk"
	},
	{
		always_shown = false,
		name = "enemy_deformed_grymbeard_clone"
	},
	{
		always_shown = false,
		name = "boss_grymbeard"
	},
	{
		always_shown = false,
		name = "enemy_ballooning_spider"
	},
	{
		always_shown = false,
		name = "enemy_glarenwarden"
	},
	{
		always_shown = false,
		name = "enemy_spider_sister"
	},
	{
		always_shown = false,
		name = "enemy_spider_priest"
	},
	{
		always_shown = false,
		name = "enemy_drainbrood"
	},
	{
		always_shown = false,
		name = "enemy_cultbrood"
	},
	{
		always_shown = false,
		name = "enemy_spidead"
	},
	{
		always_shown = false,
		name = "boss_spider_queen"
	},
	{
		always_shown = false,
		name = "enemy_flame_guard"
	},
	{
		always_shown = false,
		name = "enemy_blaze_raider"
	},
	{
		always_shown = false,
		name = "enemy_fire_fox"
	},
	{
		always_shown = false,
		name = "enemy_fire_phoenix"
	},
	{
		always_shown = false,
		name = "enemy_nine_tailed_fox"
	},
	{
		always_shown = false,
		name = "enemy_wuxian"
	},
	{
		always_shown = false,
		name = "enemy_burning_treant"
	},
	{
		always_shown = false,
		name = "enemy_ash_spirit"
	},
	{
		always_shown = false,
		name = "boss_redboy_teen"
	},
	{
		always_shown = false,
		name = "enemy_citizen_1"
	},
	{
		always_shown = false,
		name = "enemy_citizen_2"
	},
	{
		always_shown = false,
		name = "enemy_citizen_3"
	},
	{
		always_shown = false,
		name = "enemy_citizen_4"
	},
	{
		always_shown = false,
		name = "enemy_gale_warrior"
	},
	{
		always_shown = false,
		name = "enemy_water_spirit"
	},
	{
		always_shown = false,
		name = "enemy_storm_spirit"
	},
	{
		always_shown = false,
		name = "enemy_storm_elemental"
	},
	{
		always_shown = false,
		name = "enemy_qiongqi"
	},
	{
		always_shown = false,
		name = "enemy_water_sorceress"
	},
	{
		always_shown = false,
		name = "enemy_palace_guard"
	},
	{
		always_shown = false,
		name = "enemy_fan_guard"
	},
	{
		always_shown = false,
		name = "boss_princess_iron_fan"
	},
	{
		always_shown = false,
		name = "enemy_doom_bringer"
	},
	{
		always_shown = false,
		name = "enemy_demon_minotaur"
	},
	{
		always_shown = false,
		name = "enemy_golden_eyed"
	},
	{
		always_shown = false,
		name = "enemy_hellfire_warlock"
	},
	{
		always_shown = false,
		name = "boss_bull_king"
	},
	{
		always_shown = false,
		name = "enemy_tower_ray_sheep"
	},
	{
		always_shown = false,
		name = "enemy_pumpkin_witch"
	},
	--4代
	{
		always_shown = false,
		name = "enemy_kr4_ghost"
	},
	{
		always_shown = false,
		name = "enemy_haunted_skeleton"
	},
	{
		always_shown = false,
		name = "enemy_corrosive_soul"
	},
	{
		always_shown = false,
		name = "enemy_lich"
	},
	{
		always_shown = false,
		name = "enemy_bone_carrier"
	},
	---重生
	{
		name = "enemy_hobgoblin_small"
	},
	{
		name = "enemy_cursed_shaman"
	},
	{
		name = "enemy_hobgoblin_shield"
	},
	{
		name = "enemy_hobgoblin_rider"
	},
	{
		name = "enemy_goblin_spear"
	},
	{
		name = "enemy_goblin_balloon"
	},
	{
		name = "enemy_cursed_golem"
	},
	{
		name = "enemy_cursed_shard"
	},
	{
		name = "enemy_hobgoblin_miniboss"
	},
	{
		name = "eb_hobgoblin"
	},
	{
		name = "enemy_goblin_platform"
	},
	---			
}

GS.towers_required_exoskeletons = {
	[23] = {
		"ignis_altar_lava_golem",
		"ignis_altar_lvl1",
		"ignis_altar_lvl2",
		"ignis_altar_lvl3",
		"ignis_altar_lvl4",
		"ignis_altar_decal",
		"ignis_altar_decal_lava",
	}
}

for i = #GS.encyclopedia_enemies, 1, -1 do
	if GS.encyclopedia_enemies[i].target and GS.encyclopedia_enemies[i].target ~= KR_TARGET then
		table.remove(GS.encyclopedia_enemies, i)
	end
end

return GS