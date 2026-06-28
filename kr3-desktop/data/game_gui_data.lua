-- chunkname: @./kr3-desktop/data/game_gui_data.lua

local V = require("klua.vector")
local v = V.v
local i18n = require("i18n")

local function CJK(default, zh, ja, kr)
	return i18n.cjk(i18n, default, zh, ja, kr)
end

return {
	notifications = {
		enemy_gnoll_reaver = {
			image = "encyclopedia_creeps_0001",
			icon = "alert_creep_notxt_0001",
			layout = N_ENEMY,
			icon_signals = {
				{
					"show-balloon",
					"TB_NOTI",
					1
				}
			}
		},
		enemy_gnoll_burner = {
			image = "encyclopedia_creeps_0002",
			icon = "alert_creep_notxt_0002",
			layout = N_ENEMY
		},
		enemy_gnoll_gnawer = {
			image = "encyclopedia_creeps_0003",
			icon = "alert_creep_notxt_0003",
			layout = N_ENEMY
		},
		enemy_hyena = {
			image = "encyclopedia_creeps_0007",
			icon = "alert_creep_notxt_0007",
			layout = N_ENEMY
		},
		enemy_perython = {
			image = "encyclopedia_creeps_0006",
			icon = "alert_creep_notxt_0006",
			layout = N_ENEMY
		},
		enemy_gnoll_blighter = {
			image = "encyclopedia_creeps_0004",
			icon = "alert_creep_notxt_0004",
			layout = N_ENEMY
		},
		enemy_ettin = {
			image = "encyclopedia_creeps_0005",
			icon = "alert_creep_notxt_0005",
			layout = N_ENEMY
		},
		enemy_twilight_elf_harasser = {
			image = "encyclopedia_creeps_0008",
			icon = "alert_creep_notxt_0008",
			layout = N_ENEMY
		},
		enemy_sword_spider = {
			image = "encyclopedia_creeps_0010",
			icon = "alert_creep_notxt_0010",
			layout = N_ENEMY
		},
		enemy_satyr_cutthroat = {
			image = "encyclopedia_creeps_0012",
			icon = "alert_creep_notxt_0012",
			layout = N_ENEMY
		},
		enemy_satyr_hoplite = {
			image = "encyclopedia_creeps_0013",
			icon = "alert_creep_notxt_0013",
			layout = N_ENEMY
		},
		enemy_webspitting_spider = {
			image = "encyclopedia_creeps_0018",
			icon = "alert_creep_notxt_0018",
			layout = N_ENEMY
		},
		enemy_gloomy = {
			image = "encyclopedia_creeps_0017",
			icon = "alert_creep_notxt_0017",
			layout = N_ENEMY
		},
		enemy_twilight_scourger = {
			image = "encyclopedia_creeps_0011",
			icon = "alert_creep_notxt_0011",
			layout = N_ENEMY
		},
		enemy_bandersnatch = {
			image = "encyclopedia_creeps_0016",
			icon = "alert_creep_notxt_0016",
			layout = N_ENEMY
		},
		enemy_redcap = {
			image = "encyclopedia_creeps_0014",
			icon = "alert_creep_notxt_0014",
			layout = N_ENEMY
		},
		enemy_twilight_avenger = {
			image = "encyclopedia_creeps_0009",
			icon = "alert_creep_notxt_0009",
			layout = N_ENEMY
		},
		enemy_boomshrooms = {
			image = "encyclopedia_creeps_0032",
			icon = "alert_creep_notxt_0030",
			layout = N_ENEMY
		},
		enemy_munchshrooms = {
			image = "encyclopedia_creeps_0031",
			icon = "alert_creep_notxt_0029",
			layout = N_ENEMY
		},
		enemy_shroom_breeder = {
			image = "encyclopedia_creeps_0015",
			icon = "alert_creep_notxt_0015",
			layout = N_ENEMY
		},
		enemy_razorboar = {
			image = "encyclopedia_creeps_0023",
			icon = "alert_creep_notxt_0023",
			layout = N_ENEMY
		},
		enemy_twilight_evoker = {
			image = "encyclopedia_creeps_0021",
			icon = "alert_creep_notxt_0021",
			layout = N_ENEMY
		},
		enemy_twilight_golem = {
			image = "encyclopedia_creeps_0025",
			icon = "alert_creep_notxt_0025",
			layout = N_ENEMY
		},
		enemy_mantaray = {
			image = "encyclopedia_creeps_0028",
			icon = "alert_creep_notxt_0026",
			layout = N_ENEMY
		},
		enemy_spider_arachnomancer = {
			image = "encyclopedia_creeps_0030",
			icon = "alert_creep_notxt_0028",
			layout = N_ENEMY
		},
		enemy_twilight_heretic = {
			image = "encyclopedia_creeps_0024",
			icon = "alert_creep_notxt_0024",
			layout = N_ENEMY
		},
		enemy_spider_son_of_mactans = {
			image = "encyclopedia_creeps_0029",
			icon = "alert_creep_notxt_0027",
			layout = N_ENEMY
		},
		enemy_arachnomancer = {
			image = "encyclopedia_creeps_0022",
			icon = "alert_creep_notxt_0022",
			layout = N_ENEMY
		},
		enemy_drider = {
			image = "encyclopedia_creeps_0020",
			icon = "alert_creep_notxt_0020",
			layout = N_ENEMY
		},
		enemy_gnoll_bloodsydian = {
			image = "encyclopedia_creeps_0035",
			icon = "alert_creep_notxt_0031",
			layout = N_ENEMY
		},
		enemy_bloodsydian_warlock = {
			image = "encyclopedia_creeps_0037",
			icon = "alert_creep_notxt_0033",
			layout = N_ENEMY
		},
		enemy_ogre_magi = {
			image = "encyclopedia_creeps_0036",
			icon = "alert_creep_notxt_0032",
			layout = N_ENEMY
		},
		enemy_blood_servant = {
			image = "encyclopedia_creeps_0039",
			icon = "alert_creep_notxt_0034",
			layout = N_ENEMY
		},
		enemy_screecher_bat = {
			image = "encyclopedia_creeps_0041",
			icon = "alert_creep_notxt_0036",
			layout = N_ENEMY
		},
		enemy_mounted_avenger = {
			image = "encyclopedia_creeps_0040",
			icon = "alert_creep_notxt_0035",
			layout = N_ENEMY
		},
		enemy_shadows_spawns = {
			image = "encyclopedia_creeps_0044",
			icon = "alert_creep_notxt_0037",
			layout = N_ENEMY
		},
		enemy_grim_devourers = {
			image = "encyclopedia_creeps_0046",
			icon = "alert_creep_notxt_0039",
			layout = N_ENEMY
		},
		enemy_dark_spitters = {
			image = "encyclopedia_creeps_0045",
			icon = "alert_creep_notxt_0038",
			layout = N_ENEMY
		},
		enemy_shadow_champion = {
			image = "encyclopedia_creeps_0047",
			icon = "alert_creep_notxt_0040",
			layout = N_ENEMY
		},
		--2代
		enemy_bouncer = {
			image = "encyclopedia_creeps_0201",
			icon = "alert_creep_notxt_0201",
			layout = N_ENEMY,
		},
		enemy_desert_raider = {
			image = "encyclopedia_creeps_0202",
			icon = "alert_creep_notxt_0202",
			layout = N_ENEMY
		},
		enemy_immortal = {
			image = "encyclopedia_creeps_0203",
			icon = "alert_creep_notxt_0203",
			layout = N_ENEMY
		},
		enemy_desert_wolf = {
			image = "encyclopedia_creeps_0209",
			icon = "alert_creep_notxt_0208",
			layout = N_ENEMY
		},
		enemy_desert_wolf_small = {
			image = "encyclopedia_creeps_0208",
			icon = "alert_creep_notxt_0207",
			layout = N_ENEMY
		},
		enemy_executioner = {
			image = "encyclopedia_creeps_0205",
			icon = "alert_creep_notxt_0205",
			layout = N_ENEMY
		},
		enemy_scorpion = {
			image = "encyclopedia_creeps_0211",
			icon = "alert_creep_notxt_0210",
			layout = N_ENEMY
		},
		enemy_wasp = {
			image = "encyclopedia_creeps_0212",
			icon = "alert_creep_notxt_0211",
			layout = N_ENEMY
		},
		enemy_wasp_queen = {
			image = "encyclopedia_creeps_0213",
			icon = "alert_creep_notxt_0212",
			layout = N_ENEMY
		},
		enemy_munra = {
			image = "encyclopedia_creeps_0206",
			icon = "alert_creep_notxt_0206",
			layout = N_ENEMY
		},
		enemy_tremor = {
			image = "encyclopedia_creeps_0210",
			icon = "alert_creep_notxt_0209",
			layout = N_ENEMY
		},
		enemy_desert_archer = {
			image = "encyclopedia_creeps_0204",
			icon = "alert_creep_notxt_0204",
			layout = N_ENEMY
		},
		enemy_jungle_spider_small = {
			image = "encyclopedia_creeps_0216",
			icon = "alert_creep_notxt_0213",
			layout = N_ENEMY
		},
		enemy_jungle_spider_big = {
			image = "encyclopedia_creeps_0217",
			icon = "alert_creep_notxt_0214",
			layout = N_ENEMY
		},
		enemy_jungle_spider_tiny = {
			image = "encyclopedia_creeps_0217",
			icon = "alert_creep_notxt_0201",
			layout = N_ENEMY
		},
		enemy_gorilla = {
			image = "encyclopedia_creeps_0225",
			icon = "alert_creep_notxt_0221",
			layout = N_ENEMY
		},
		enemy_savage_bird = {
			image = "encyclopedia_creeps_0226",
			icon = "alert_creep_notxt_0222",
			layout = N_ENEMY
		},
		enemy_savage_bird_rider = {
			image = "encyclopedia_creeps_0226",
			icon = "alert_creep_notxt_0222",
			layout = N_ENEMY
		},
		enemy_cannibal = {
			image = "encyclopedia_creeps_0218",
			icon = "alert_creep_notxt_0215",
			layout = N_ENEMY
		},
		enemy_hunter = {
			image = "encyclopedia_creeps_0219",
			icon = "alert_creep_notxt_0216",
			layout = N_ENEMY
		},
		enemy_shaman_necro = {
			image = "encyclopedia_creeps_0223",
			icon = "alert_creep_notxt_0220",
			layout = N_ENEMY
		},
		enemy_shaman_priest = {
			image = "encyclopedia_creeps_0220",
			icon = "alert_creep_notxt_0217",
			layout = N_ENEMY
		},
		enemy_shaman_magic = {
			image = "encyclopedia_creeps_0222",
			icon = "alert_creep_notxt_0219",
			layout = N_ENEMY
		},
		enemy_shaman_shield = {
			image = "encyclopedia_creeps_0221",
			icon = "alert_creep_notxt_0218",
			layout = N_ENEMY
		},
		enemy_alien_breeder = {
			image = "encyclopedia_creeps_0227",
			icon = "alert_creep_notxt_0223",
			layout = N_ENEMY
		},
		enemy_alien_reaper = {
			image = "encyclopedia_creeps_0228",
			icon = "alert_creep_notxt_0224",
			layout = N_ENEMY
		},
		enemy_brute = {
			image = "encyclopedia_creeps_0232",
			icon = "alert_creep_notxt_0228",
			layout = N_ENEMY
		},
		enemy_broodguard = {
			image = "encyclopedia_creeps_0229",
			icon = "alert_creep_notxt_0225",
			layout = N_ENEMY
		},
		enemy_darter = {
			image = "encyclopedia_creeps_0231",
			icon = "alert_creep_notxt_0227",
			layout = N_ENEMY
		},
		enemy_myrmidon = {
			image = "encyclopedia_creeps_0233",
			icon = "alert_creep_notxt_0229",
			layout = N_ENEMY
		},
		enemy_razorwing = {
			image = "encyclopedia_creeps_0236",
			icon = "alert_creep_notxt_0233",
			layout = N_ENEMY
		},
		enemy_quetzal = {
			image = "encyclopedia_creeps_0235",
			icon = "alert_creep_notxt_0231",
			layout = N_ENEMY
		},
		enemy_nightscale = {
			image = "encyclopedia_creeps_0234",
			icon = "alert_creep_notxt_0230",
			layout = N_ENEMY
		},
		enemy_savant = {
			image = "encyclopedia_creeps_0237",
			icon = "alert_creep_notxt_0232",
			layout = N_ENEMY
		},
		enemy_blazefang = {
			image = "encyclopedia_creeps_0230",
			icon = "alert_creep_notxt_0226",
			layout = N_ENEMY
		},
		enemy_greenfin = {
			image = "encyclopedia_creeps_0244",
			icon = "alert_creep_notxt_0234",
			layout = N_ENEMY
		},
		enemy_redspine = {
			image = "encyclopedia_creeps_0246",
			icon = "alert_creep_notxt_0238",
			layout = N_ENEMY
		},
		enemy_blacksurge = {
			image = "encyclopedia_creeps_0245",
			icon = "alert_creep_notxt_0237",
			layout = N_ENEMY
		},
		enemy_deviltide_shark = {
			image = "encyclopedia_creeps_0247",
			icon = "alert_creep_notxt_0239",
			layout = N_ENEMY
		},
		enemy_bluegale = {
			image = "encyclopedia_creeps_0243",
			icon = "alert_creep_notxt_0236",
			layout = N_ENEMY
		},
		enemy_bloodshell = {
			image = "encyclopedia_creeps_0242",
			icon = "alert_creep_notxt_0235",
			layout = N_ENEMY
		},
		enemy_halloween_zombie = {
			image = "encyclopedia_creeps_0253",
			icon = "alert_creep_notxt_0245",
			layout = N_ENEMY
		},
		enemy_ghoul = {
			image = "encyclopedia_creeps_0256",
			icon = "alert_creep_notxt_0248",
			layout = N_ENEMY
		},
		enemy_bat = {
			image = "encyclopedia_creeps_0249",
			icon = "alert_creep_notxt_0241",
			layout = N_ENEMY
		},
		enemy_werewolf = {
			image = "encyclopedia_creeps_0250",
			icon = "alert_creep_notxt_0242",
			layout = N_ENEMY
		},
		enemy_abomination = {
			image = "encyclopedia_creeps_0254",
			icon = "alert_creep_notxt_0246",
			layout = N_ENEMY
		},
		enemy_lycan = {
			image = "encyclopedia_creeps_0255",
			icon = "alert_creep_notxt_0247",
			layout = N_ENEMY
		},
		enemy_ghost = {
			image = "encyclopedia_creeps_0252",
			icon = "alert_creep_notxt_0244",
			layout = N_ENEMY
		},
		enemy_phantom_warrior = {
			image = "encyclopedia_creeps_0251",
			icon = "alert_creep_notxt_0243",
			layout = N_ENEMY
		},
		enemy_elvira = {
			image = "encyclopedia_creeps_0258",
			icon = "alert_creep_notxt_0249",
			layout = N_ENEMY
		},
		enemy_sniper = {
			image = "encyclopedia_creeps_0259",
			icon = "alert_creep_notxt_0250",
			layout = N_ENEMY
		},
		--1代
		enemy_goblin = {
			icon = "alert_creep_notxt_0101",
			image = "encyclopedia_creeps_0101",
			i18n_key = "ENEMY_GOBLIN",
			layout = N_ENEMY,
		},
		enemy_fat_orc = {
			icon = "alert_creep_notxt_0102",
			i18n_key = "ENEMY_FAT_ORC",
			image = "encyclopedia_creeps_0102",
			layout = N_ENEMY
		},
		enemy_shaman = {
			icon = "alert_creep_notxt_0103",
			i18n_key = "ENEMY_SHAMAN",
			image = "encyclopedia_creeps_0103",
			layout = N_ENEMY
		},
		enemy_ogre = {
			icon = "alert_creep_notxt_0104",
			i18n_key = "ENEMY_OGRE",
			image = "encyclopedia_creeps_0104",
			layout = N_ENEMY
		},
		enemy_bandit = {
			icon = "alert_creep_notxt_0105",
			i18n_key = "ENEMY_BANDIT",
			image = "encyclopedia_creeps_0105",
			layout = N_ENEMY
		},
		enemy_brigand = {
			icon = "alert_creep_notxt_0106",
			i18n_key = "ENEMY_BRIGAND",
			image = "encyclopedia_creeps_0106",
			layout = N_ENEMY
		},
		enemy_marauder = {
			icon = "alert_creep_notxt_0107",
			i18n_key = "ENEMY_MARAUDER",
			image = "encyclopedia_creeps_0107",
			layout = N_ENEMY
		},
		enemy_spider_small = {
			icon = "alert_creep_notxt_0108",
			i18n_key = "ENEMY_SPIDERSMALL",
			image = "encyclopedia_creeps_0108",
			layout = N_ENEMY
		},
		enemy_spider_big = {
			icon = "alert_creep_notxt_0109",
			i18n_key = "ENEMY_SPIDER",
			image = "encyclopedia_creeps_0109",
			layout = N_ENEMY
		},
		enemy_gargoyle = {
			icon = "alert_creep_notxt_0110",
			i18n_key = "ENEMY_GARGOYLE",
			image = "encyclopedia_creeps_0110",
			layout = N_ENEMY
		},
		enemy_shadow_archer = {
			icon = "alert_creep_notxt_0111",
			i18n_key = "ENEMY_SHADOW_ARCHER",
			image = "encyclopedia_creeps_0111",
			layout = N_ENEMY
		},
		enemy_dark_knight = {
			icon = "alert_creep_notxt_0112",
			i18n_key = "ENEMY_DARK_KNIGHT",
			image = "encyclopedia_creeps_0112",
			layout = N_ENEMY
		},
		enemy_wolf_small = {
			icon = "alert_creep_notxt_0113",
			i18n_key = "ENEMY_WULF",
			image = "encyclopedia_creeps_0113",
			layout = N_ENEMY
		},
		enemy_wolf = {
			icon = "alert_creep_notxt_0114",
			i18n_key = "ENEMY_WORG",
			image = "encyclopedia_creeps_0114",
			layout = N_ENEMY
		},
		enemy_whitewolf = {
			icon = "alert_creep_notxt_0115",
			i18n_key = "ENEMY_WHITE_WOLF",
			image = "encyclopedia_creeps_0116",
			layout = N_ENEMY
		},
		enemy_troll = {
			icon = "alert_creep_notxt_0116",
			i18n_key = "ENEMY_TROLL",
			image = "encyclopedia_creeps_0117",
			layout = N_ENEMY
		},
		enemy_troll_axe_thrower = {
			icon = "alert_creep_notxt_0117",
			i18n_key = "ENEMY_TROLL_AXE_THROWER",
			image = "encyclopedia_creeps_0118",
			layout = N_ENEMY
		},
		enemy_troll_chieftain = {
			icon = "alert_creep_notxt_0118",
			i18n_key = "ENEMY_TROLL_CHIEFTAIN",
			image = "encyclopedia_creeps_0119",
			layout = N_ENEMY
		},
		enemy_yeti = {
			icon = "alert_creep_notxt_0119",
			i18n_key = "ENEMY_YETI",
			image = "encyclopedia_creeps_0120",
			layout = N_ENEMY
		},
		enemy_rocketeer = {
			icon = "alert_creep_notxt_0120",
			i18n_key = "ENEMY_ROCKETEER",
			image = "encyclopedia_creeps_0121",
			layout = N_ENEMY
		},
		enemy_slayer = {
			icon = "alert_creep_notxt_0121",
			i18n_key = "ENEMY_SLAYER",
			image = "encyclopedia_creeps_0122",
			layout = N_ENEMY
		},
		enemy_demon = {
			icon = "alert_creep_notxt_0122",
			i18n_key = "ENEMY_DEMON",
			image = "encyclopedia_creeps_0123",
			layout = N_ENEMY
		},
		enemy_demon_mage = {
			icon = "alert_creep_notxt_0123",
			i18n_key = "ENEMY_DEMON_MAGE",
			image = "encyclopedia_creeps_0124",
			layout = N_ENEMY
		},
		enemy_demon_wolf = {
			icon = "alert_creep_notxt_0124",
			i18n_key = "ENEMY_DEMON_WOLF",
			image = "encyclopedia_creeps_0125",
			layout = N_ENEMY
		},
		enemy_demon_imp = {
			icon = "alert_creep_notxt_0125",
			i18n_key = "ENEMY_DEMON_IMP",
			image = "encyclopedia_creeps_0126",
			layout = N_ENEMY
		},
		enemy_necromancer = {
			icon = "alert_creep_notxt_0128",
			i18n_key = "ENEMY_NECROMANCER",
			image = "encyclopedia_creeps_0129",
			layout = N_ENEMY
		},
		enemy_lava_elemental = {
			icon = "alert_creep_notxt_0129",
			i18n_key = "ENEMY_LAVA_ELEMENTAL",
			image = "encyclopedia_creeps_0130",
			layout = N_ENEMY
		},
		enemy_sarelgaz_small = {
			icon = "alert_creep_notxt_0130",
			i18n_key = "ENEMY_SARELGAZ_SMALL",
			image = "encyclopedia_creeps_0131",
			layout = N_ENEMY
		},
		enemy_orc_armored = {
			icon = "alert_creep_notxt_0131",
			i18n_key = "ENEMY_ORC_ARMORED",
			image = "encyclopedia_creeps_0136",
			layout = N_ENEMY
		},
		enemy_orc_rider = {
			icon = "alert_creep_notxt_0132",
			i18n_key = "ENEMY_ORC_RIDER",
			image = "encyclopedia_creeps_0137",
			layout = N_ENEMY
		},
		enemy_goblin_zapper = {
			icon = "alert_creep_notxt_0133",
			i18n_key = "ENEMY_GOBLIN_ZAPPER",
			image = "encyclopedia_creeps_0138",
			layout = N_ENEMY
		},
		enemy_forest_troll = {
			icon = "alert_creep_notxt_0134",
			i18n_key = "ENEMY_FOREST_TROLL",
			image = "encyclopedia_creeps_0139",
			layout = N_ENEMY
		},
		enemy_zombie = {
			icon = "alert_creep_notxt_0135",
			i18n_key = "ENEMY_ZOMBIE",
			image = "encyclopedia_creeps_0141",
			layout = N_ENEMY
		},
		enemy_spider_rotten = {
			icon = "alert_creep_notxt_0136",
			i18n_key = "ENEMY_SPIDER_ROTTEN",
			image = "encyclopedia_creeps_0142",
			layout = N_ENEMY
		},
		enemy_rotten_tree = {
			icon = "alert_creep_notxt_0137",
			i18n_key = "ENEMY_ROTTEN_TREE",
			image = "encyclopedia_creeps_0143",
			layout = N_ENEMY
		},
		enemy_swamp_thing = {
			icon = "alert_creep_notxt_0138",
			i18n_key = "ENEMY_SWAMP_THING",
			image = "encyclopedia_creeps_0144",
			layout = N_ENEMY
		},
		enemy_raider = {
			icon = "alert_creep_notxt_0139",
			i18n_key = "ENEMY_RAIDER",
			image = "encyclopedia_creeps_0146",
			layout = N_ENEMY
		},
		enemy_pillager = {
			icon = "alert_creep_notxt_0140",
			i18n_key = "ENEMY_PILLAGER",
			image = "encyclopedia_creeps_0147",
			layout = N_ENEMY
		},
		enemy_troll_skater = {
			icon = "alert_creep_notxt_0141",
			i18n_key = "ENEMY_TROLL_SKATER",
			image = "encyclopedia_creeps_0150",
			layout = N_ENEMY
		},
		enemy_troll_brute = {
			icon = "alert_creep_notxt_0142",
			i18n_key = "ENEMY_TROLL_BRUTE",
			image = "encyclopedia_creeps_0151",
			layout = N_ENEMY
		},
		enemy_demon_gulaemon = {
			icon = "alert_creep_notxt_0143",
			i18n_key = "ENEMY_DEMON_GULAEMON",
			image = "encyclopedia_creeps_0153",
			layout = N_ENEMY
		},
		enemy_demon_flareon = {
			icon = "alert_creep_notxt_0144",
			i18n_key = "ENEMY_DEMON_FLAREON",
			image = "encyclopedia_creeps_0154",
			layout = N_ENEMY
		},
		enemy_demon_cerberus = {
			icon = "alert_creep_notxt_0145",
			i18n_key = "ENEMY_DEMON_CERBERUS",
			image = "encyclopedia_creeps_0155",
			layout = N_ENEMY
		},
		enemy_demon_legion = {
			icon = "alert_creep_notxt_0146",
			i18n_key = "ENEMY_DEMON_LEGION",
			image = "encyclopedia_creeps_0156",
			layout = N_ENEMY
		},
		enemy_rotten_lesser = {
			icon = "alert_creep_notxt_0147",
			i18n_key = "ENEMY_ROTTEN_LESSER",
			image = "encyclopedia_creeps_0158",
			layout = N_ENEMY
		},
		enemy_giant_rat = {
			icon = "alert_creep_notxt_0149",
			i18n_key = "ENEMY_GIANT_RAT",
			image = "encyclopedia_creeps_0161",
			layout = N_ENEMY
		},
		enemy_wererat = {
			icon = "alert_creep_notxt_0150",
			i18n_key = "ENEMY_WERERAT",
			image = "encyclopedia_creeps_0162",
			layout = N_ENEMY
		},
		enemy_fallen_knight = {
			icon = "alert_creep_notxt_0151",
			i18n_key = "ENEMY_FALLEN_KNIGHT",
			image = "encyclopedia_creeps_0163",
			layout = N_ENEMY
		},
		enemy_spectral_knight = {
			icon = "alert_creep_notxt_0152",
			i18n_key = "ENEMY_SPECTRAL_KNIGHT",
			image = "encyclopedia_creeps_0164",
			layout = N_ENEMY
		},
		enemy_witch = {
			icon = "alert_creep_notxt_0154",
			i18n_key = "ENEMY_WITCH",
			image = "encyclopedia_creeps_0166",
			layout = N_ENEMY
		},
---重生
		enemy_hobgoblin_small = {
			icon = "alert_creep_notxt_0057",
			i18n_key = "ENEMY_HOBGOBLIN",
			image = "encyclopedia_creeps_0070",
			layout = N_ENEMY
		},
		enemy_cursed_shaman = {
			icon = "alert_creep_notxt_0058",
			i18n_key = "ENEMY_CURSED_SHAMAN",
			image = "encyclopedia_creeps_0071",
			layout = N_ENEMY
		},
		enemy_hobgoblin_shield = {
			icon = "alert_creep_notxt_0059",
			i18n_key = "ENEMY_HOBGOBLIN_SHIELD",
			image = "encyclopedia_creeps_0072",
			layout = N_ENEMY
		},
		enemy_hobgoblin_rider = {
			icon = "alert_creep_notxt_0060",
			i18n_key = "ENEMY_HOBGOBLIN_RIDER",
			image = "encyclopedia_creeps_0073",
			layout = N_ENEMY
		},
		enemy_goblin_spear = {
			icon = "alert_creep_notxt_0061",
			i18n_key = "ENEMY_GOBLIN_SPEAR",
			image = "encyclopedia_creeps_0074",
			layout = N_ENEMY
		},
		enemy_goblin_balloon = {
			icon = "alert_creep_notxt_0062",
			i18n_key = "ENEMY_GOBLIN_BALLOON",
			image = "encyclopedia_creeps_0075",
			layout = N_ENEMY
		},
		enemy_goblin_platform = {
			icon = "alert_creep_notxt_0062",
			i18n_key = "ENEMY_GOBLIN_PLATFORM",
			image = "encyclopedia_creeps_0075",
			layout = N_ENEMY
		},
		enemy_cursed_golem = {
			icon = "alert_creep_notxt_0063",
			i18n_key = "ENEMY_CURSED_GOLEM",
			image = "encyclopedia_creeps_0076",
			layout = N_ENEMY
		},
		enemy_cursed_shard = {
			icon = "alert_creep_notxt_0064",
			i18n_key = "ENEMY_CURSED_SHARDM",
			image = "encyclopedia_creeps_0077",
			layout = N_ENEMY
		},
		enemy_hobgoblin_miniboss = {
			icon = "alert_creep_notxt_0065",
			i18n_key = "ENEMY_HOBGOBLIN_MINIBOSS",
			image = "encyclopedia_creeps_0078",
			layout = N_ENEMY
		},
		eb_hobgoblin = {
			icon = "alert_creep_notxt_0066",
			i18n_key = "EB_HOBGOBLIN",
			image = "encyclopedia_creeps_0079",
			layout = N_ENEMY
		},
---				
		TOWER_ARCHER_ARCANE = {
			prefix = "TOWER_ARCANE",
			always = true,
			sub = "TOWER_ARCHERS_SUBTITLE",
			image = "encyclopedia_towers_0017",
			layout = N_TOWER,
			seen = {
				"tower_arcane"
			}
		},
		TOWER_BARRACK_BLADE = {
			prefix = "TOWER_BARRACKS_BLADE",
			always = true,
			sub = "TOWER_BARRACKS_SUBTITLE",
			image = "encyclopedia_towers_0020",
			layout = N_TOWER,
			seen = {
				"tower_blade"
			}
		},
		TOWER_MAGE_WILD_MAGUS = {
			prefix = "TOWER_MAGE_WILD_MAGUS",
			always = true,
			sub = "TOWER_MAGES_SUBTITLE",
			image = "encyclopedia_towers_0016",
			layout = N_TOWER,
			seen = {
				"tower_wild_magus"
			}
		},
		TOWER_ROCK_THROWER_STONE_DRUID = {
			prefix = "TOWER_STONE_DRUID",
			always = true,
			sub = "TOWER_ROCK_THROWER_SUBTITLE",
			image = "encyclopedia_towers_0013",
			layout = N_TOWER,
			seen = {
				"tower_druid"
			}
		},
		TOWER_MAGE_HIGH_ELVEN = {
			prefix = "TOWER_MAGE_HIGH_ELVEN",
			always = true,
			sub = "TOWER_MAGES_SUBTITLE",
			image = "encyclopedia_towers_0015",
			layout = N_TOWER,
			seen = {
				"tower_high_elven"
			}
		},
		TOWER_ROCK_THROWER_ENTWOOD = {
			prefix = "TOWER_ENTWOOD",
			always = true,
			sub = "TOWER_ROCK_THROWER_SUBTITLE",
			image = "encyclopedia_towers_0014",
			layout = N_TOWER,
			seen = {
				"tower_entwood"
			}
		},
		TOWER_ARCHER_SILVER = {
			always = true,
			layout = N_TOWER_2,
			images = {
				"encyclopedia_towers_0018",
				"encyclopedia_towers_0019"
			},
			prefixes = {
				"TOWER_SILVER",
				"TOWER_FOREST_KEEPERS"
			},
			subs = {
				"TOWER_ARCHERS_SUBTITLE",
				"TOWER_BARRACKS_SUBTITLE"
			},
			seen = {
				"tower_silver",
				"tower_forest"
			}
		},
		TOWER_LEVEL2 = {
			always = true,
			level = 2,
			layout = N_TOWER_4,
			images = {
				"encyclopedia_towers_0006",
				"encyclopedia_towers_0005",
				"encyclopedia_towers_0007",
				"encyclopedia_towers_0008"
			},
			seen = {
				"tower_barrack_2",
				"tower_archer_2",
				"tower_mage_2",
				"tower_rock_thrower_2"
			}
		},
		TOWER_LEVEL3 = {
			always = true,
			level = 3,
			layout = N_TOWER_4,
			images = {
				"encyclopedia_towers_0010",
				"encyclopedia_towers_0009",
				"encyclopedia_towers_0011",
				"encyclopedia_towers_0012"
			},
			seen = {
				"tower_barrack_3",
				"tower_archer_3",
				"tower_mage_3",
				"tower_rock_thrower_3"
			}
		},
		TIP_ARMOR = {
			paper = "notifications_tips_slides_notxt_0001",
			always = true,
			ach_id = "ART_OF_WAR",
			ach_flag = 1,
			icon = "alert_tip_notxt_0002",
			layout = N_TIP
		},
		TIP_RALLY = {
			paper = "notifications_tips_slides_notxt_0003",
			always = true,
			ach_id = "ART_OF_WAR",
			ach_flag = 2,
			icon = "alert_tip_notxt_0001",
			layout = N_TIP
		},
		TIP_ARMOR_MAGIC = {
			paper = "notifications_tips_slides_notxt_0002",
			always = true,
			ach_id = "ART_OF_WAR",
			ach_flag = 4,
			icon = "alert_tip_notxt_0003",
			layout = N_TIP
		},
		TIP_STRATEGY = {
			paper = "notifications_tips_slides_notxt_0004",
			always = true,
			ach_id = "ART_OF_WAR",
			ach_flag = 8,
			icon = "alert_tip_notxt_0004",
			layout = N_TIP
		},
		TIP_HEROES = {
			icon = "alert_tip_notxt_0006",
			paper = "notifications_tips_slides_notxt_0006",
			always = true,
			layout = N_TIP
		},
		TIP_UPGRADES = {
			icon = "alert_tip_notxt_0005",
			paper = "notifications_tips_slides_notxt_0005",
			layout = N_TIP
		},
		PLANT_MAGIC_BLOSSOM = {
			icon = "alert_tip_notxt_0007",
			image = "tutorial_magicBlosom",
			prefix = "PLANT_1",
			layout = N_POWER
		},
		PLANT_VENOM = {
			icon = "alert_tip_notxt_0008",
			image = "tutorial_venomPlant",
			prefix = "PLANT_2",
			layout = N_POWER
		},
		ARCANE_CRYSTAL = {
			icon = "alert_tip_notxt_0009",
			image = "tutorial_arcaneCrystal",
			prefix = "PLANT_3",
			layout = N_POWER
		},
		PARALYZING_TREE = {
			icon = "alert_tip_notxt_0010",
			image = "tutorial_paralyzingTree",
			prefix = "PLANT_4",
			layout = N_POWER
		},
		POWER_THUNDERBOLT = {
			prefix = "POWER_THUNDER",
			always = true,
			image = "tutorial_powers_polaroids_0002",
			layout = N_POWER,
			signals = {
				{
					"show-balloon",
					"TB_POWER1"
				},
				{
					"unlock-user-power",
					1
				}
			}
		},
		POWER_REINFORCEMENT = {
			prefix = "POWER_SUMMON",
			always = true,
			image = "tutorial_powers_polaroids_0001",
			layout = N_POWER,
			signals = {
				{
					"show-balloon",
					"TB_POWER2"
				},
				{
					"unlock-user-power",
					2
				}
			}
		},
		POWER_HERO = {
			prefix = "POWER_HERO",
			always = true,
			image = "tutorial_powers_polaroids_0003",
			layout = N_POWER,
			signals = {
				{
					"show-balloon",
					"TB_POWER3"
				},
				{
					"unlock-user-power",
					3
				}
			}
		},
		TUTORIAL_1 = {
			next = "TUTORIAL_2",
			paper = "tutorial_slide1_notxt",
			always = true,
			layout = N_TUTORIAL
		},
		TUTORIAL_2 = {
			next = "TUTORIAL_3",
			paper = "tutorial_slide2_notxt",
			always = true,
			layout = N_TUTORIAL
		},
		TUTORIAL_3 = {
			always = true,
			paper = "tutorial_slide3_notxt",
			layout = N_TUTORIAL
		},
		--2代
		TOWER_DWAARP = {
			prefix = "TOWER_DWAARP",
			always = true,
			sub = "TOWER_ENGINEERS_SUBTITLE",
			image = "encyclopedia_towers_0216",
			layout = N_TOWER,
			seen = {
				"tower_dwaarp"
			}
		},
		TOWER_ARCHMAGE = {
			prefix = "TOWER_ARCHMAGE",
			always = true,
			sub = "TOWER_MAGES_SUBTITLE",
			image = "encyclopedia_towers_0215",
			layout = N_TOWER,
			seen = {
				"tower_archmage"
			}
		},
		TOWER_TEMPLARS = {
			prefix = "TOWER_TEMPLAR",
			always = true,
			sub = "TOWER_BARRACKS_SUBTITLE",
			image = "encyclopedia_towers_0218",
			layout = N_TOWER,
			seen = {
				"tower_templar"
			}
		},
		TOWER_TOTEM = {
			prefix = "TOWER_TOTEM",
			always = true,
			sub = "TOWER_ARCHERS_SUBTITLE",
			image = "encyclopedia_towers_0217",
			layout = N_TOWER,
			seen = {
				"tower_totem"
			}
		},
		TOWER_NECROMANCER = {
			prefix = "TOWER_NECROMANCER",
			always = true,
			sub = "TOWER_MAGES_SUBTITLE",
			image = "encyclopedia_towers_0219",
			layout = N_TOWER,
			seen = {
				"tower_necromancer"
			}
		},
		TOWER_MECH = {
			prefix = "TOWER_MECH",
			always = true,
			sub = "TOWER_ENGINEERS_SUBTITLE",
			image = "encyclopedia_towers_0220",
			layout = N_TOWER,
			seen = {
				"tower_mech"
			}
		},
		TOWER_ASSASINS_CROSSBOW = {
			always = true,
			layout = N_TOWER_2,
			images = {
				"encyclopedia_towers_0214",
				"encyclopedia_towers_0213"
			},
			prefixes = {
				"TOWER_ASSASSIN",
				"TOWER_CROSSBOW"
			},
			subs = {
				"TOWER_BARRACKS_SUBTITLE",
				"TOWER_ARCHERS_SUBTITLE"
			},
			seen = {
				"tower_assassin",
				"tower_crossbow"
			}
		},
		G2_TOWER_LEVEL2 = {
			always = true,
			level = 2,
			layout = N_TOWER_4,
			images = {
				"encyclopedia_towers_0206",
				"encyclopedia_towers_0205",
				"encyclopedia_towers_0207",
				"encyclopedia_towers_0208"
			},
			seen = {
				"g2_tower_barrack_2",
				"g2_tower_archer_2",
				"g2_tower_mage_2",
				"g2_tower_engineer_2"
			}
		},
		G2_TOWER_LEVEL3 = {
			always = true,
			level = 3,
			layout = N_TOWER_4,
			images = {
				"encyclopedia_towers_0210",
				"encyclopedia_towers_0209",
				"encyclopedia_towers_0211",
				"encyclopedia_towers_0212"
			},
			seen = {
				"g2_tower_barrack_3",
				"g2_tower_archer_3",
				"g2_tower_mage_3",
				"g2_tower_engineer_3"
			}
		},
		TIP_SURVIVAL = {
			icon = "alert_tip_notxt_0005",
			paper = "notifications_tips_slides_notxt_0007",
			always = false,
			layout = N_TIP
		},
		--1代
		TOWER_MUSKETEER = {
			prefix = "TOWER_MUSKETEERS",
			always = true,
			sub = "TOWER_ARCHERS_SUBTITLE",
			image = "encyclopedia_towers_0117",
			layout = N_TOWER,
			seen = {
				"tower_musketeer"
			}
		},
		TOWER_RANGER = {
			prefix = "TOWER_RANGERS",
			always = true,
			sub = "TOWER_ARCHERS_SUBTITLE",
			image = "encyclopedia_towers_0113",
			layout = N_TOWER,
			seen = {
				"tower_ranger"
			}
		},
		TOWER_SORCERER = {
			prefix = "TOWER_SORCERER",
			always = true,
			sub = "TOWER_MAGES_SUBTITLE",
			image = "encyclopedia_towers_0119",
			layout = N_TOWER,
			seen = {
				"tower_sorcerer"
			}
		},
		TOWER_TESLA = {
			prefix = "TOWER_TESLA",
			always = true,
			sub = "TOWER_ENGINEERS_SUBTITLE",
			image = "encyclopedia_towers_0120",
			layout = N_TOWER,
			seen = {
				"tower_tesla"
			}
		},
		TOWER_BARBARIAN_BGF = {
			always = true,
			layout = N_TOWER_2,
			images = {
				"encyclopedia_towers_0118",
				"encyclopedia_towers_0116"
			},
			prefixes = {
				"TOWER_BARBARIANS",
				"TOWER_BFG"
			},
			subs = {
				"TOWER_BARRACKS_SUBTITLE",
				"TOWER_ENGINEERS_SUBTITLE"
			},
			seen = {
				"tower_barbarian",
				"tower_bgf"
			}
		},
		TOWER_PALADIN = {
			always = true,
			layout = N_TOWER_2,
			images = {
				"encyclopedia_towers_0115",
				"encyclopedia_towers_0114"
			},
			prefixes = {
				"TOWER_ARCANE_WIZARD",
				"TOWER_PALADINS"
			},
			subs = {
				"TOWER_MAGES_SUBTITLE",
				"TOWER_BARRACKS_SUBTITLE"
			},
			seen = {
				"tower_arcane",
				"tower_paladins"
			}
		},
	},
	tutorial_balloons = {
		TB_BUILD = {
			origin = "world",
			image = "balloon_buildhere_bg",
			hide_cond = "tower_built",
			offset = v(598, 410)
		},
		TB_POWER1 = {
			hide_cond = "power_selected_1",
			balloon = "TB_ROAD",
			origin = "bottom-left",
			image = "balloon_newpower_bg",
			offset = v(221, -104)
		},
		TB_POWER2 = {
			hide_cond = "power_selected_2",
			balloon = "TB_ROAD",
			origin = "bottom-left",
			image = "balloon_newpower_bg",
			offset = v(287, -104)
		},
		TB_POWER3 = {
			hide_cond = "power_selected_3",
			balloon = "TB_ROAD",
			origin = "bottom-left",
			image = "balloon_newpower_bg",
			offset = v(353, -104)
		},
		TB_ROAD = {
			origin = "world",
			image = "balloon_taphere_bg",
			hide_cond = "power_used",
			offset = v(680, 310)
		},
		TB_NOTI = {
			origin = "top-left",
			image = "balloon_clickhere_bg",
			hide_cond = "noti_shown",
			offset = v(238, 105)
		},
		TB_START = {
			origin = "bottom-right",
			image = "balloon_startbattle_bg",
			hide_cond = "wave_sent",
			offset = v(-90, -88)
		},
		TB_WAVE = {
			origin = "top-right",
			image = "balloon_nextwave_bg",
			hide_cond = "wave_sent",
			offset = v(-158, 80)
		}
	},
	notification_slides = {
		TB_BUILD = {
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "BUILD HERE!",
				text_align = "center",
				pos = v(10, 6),
				size = v(160, 36),
				font_size = CJK(20, 24, nil, 28)
			}
		},
		TB_POWER1 = {
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "NEW POWER!",
				text_align = "center",
				pos = v(13, 6),
				size = v(156, 36),
				font_size = CJK(20, 24, nil, 28)
			}
		},
		TB_POWER2 = {
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "NEW POWER!",
				text_align = "center",
				pos = v(13, 6),
				size = v(156, 36),
				font_size = CJK(20, 24, nil, 28)
			}
		},
		TB_POWER3 = {
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "NEW POWER!",
				text_align = "center",
				pos = v(13, 6),
				size = v(156, 36),
				font_size = CJK(20, 24, nil, 28)
			}
		},
		TB_ROAD = {
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "CLICK ON THE ROAD",
				text_align = "center",
				pos = v(7, 6),
				size = v(176, 36),
				font_size = CJK(18, 21, nil, 25)
			}
		},
		TB_NOTI = {
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "CLICK HERE!",
				text_align = "center",
				pos = v(27, 7),
				size = v(155, 36),
				font_size = CJK(20, 24, nil, 28)
			}
		},
		TB_START = {
			{
				vertical_align = "middle",
				fit_lines = 2,
				line_height = 0.8,
				text_align = "center",
				text = "START BATTLE!",
				pos = v(8, 6),
				size = v(150, 36),
				font_size = CJK(18, 21, nil, 25)
			}
		},
		TB_WAVE = {
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "INCOMING NEXT WAVE!",
				text_align = "left",
				pos = v(12, 9),
				size = v(224, 26),
				font_size = CJK(18, 21, nil, 25)
			},
			{
				vertical_align = "middle",
				fit_lines = 1,
				text = "CLICK TO CALL IT EARLY",
				text_align = "left",
				pos = v(12, 35),
				size = v(224, 23),
				font_size = CJK(10, 14, nil, 20)
			}
		},
		TUTORIAL_1 = {
			{
				vertical_align = "middle",
				text = "Objective",
				font_size = 22,
				text_align = "center",
				pos = v(52, 60),
				size = v(380, 30),
				anchor = {
					y = 30
				}
			},
			{
				vertical_align = "middle",
				line_height = 0.8,
				color = "gray",
				font_size = 16,
				text_align = "center",
				text = "protect your lands from the enemy attacks.",
				pos = v(47, 56),
				size = v(390, 22)
			},
			{
				vertical_align = "middle",
				line_height = 0.8,
				color = "gray",
				font_size = 12,
				text_align = "center",
				text = "build defensive towers along the road to stop them.",
				pos = v(47, 78),
				size = v(390, 22)
			},
			{
				vertical_align = "middle",
				color = "black",
				font_size = 12,
				text_align = "center",
				text = "don't let enemies past this point.",
				pos = v(116, 124),
				size = v(135, 30),
				line_height = CJK(0.8, nil, 1.1)
			},
			{
				vertical_align = "middle",
				color = "black",
				font_size = 11,
				text_align = "center",
				text = "build towers to defend the road.",
				pos = v(271, 273),
				size = v(109, 32),
				line_height = CJK(0.8, nil, 1.1)
			},
			{
				vertical_align = "middle",
				color = "black",
				font_size = 11,
				text_align = "center",
				text = "earn gold by killing enemies.",
				pos = v(285, 205),
				size = v(106, 32),
				line_height = CJK(0.8, nil, 1.1)
			}
		},
		TUTORIAL_2 = {
			{
				text = "Tower construction",
				text_align = "center",
				r = 0,
				font_size = 22,
				pos = v(38, 50),
				size = v(389, 30),
				anchor = {
					y = 30
				}
			},
			{
				text = "Build towers on strategic points to stop the enemy hordes from getting through.",
				color = "gray",
				text_align = "center",
				r = 0,
				font_size = 14,
				pos = v(46, 52),
				size = v(373, 52)
			},
			{
				vertical_align = "middle",
				text_align = "center",
				text = "click these!",
				r = 0.17453292519943,
				font_size = 13,
				color = "dark_red",
				pos = v(26, 126),
				size = v(135, 30),
				line_height = CJK(0.8, nil, 1.1)
			},
			{
				vertical_align = "middle",
				text_align = "center",
				text = "this is a strategic point.",
				r = 0,
				font_size = 11,
				line_height = 0.8,
				color = "dark_red",
				pos = v(35, 195),
				size = v(123, 30)
			},
			{
				vertical_align = "middle",
				text_align = "center",
				text = "select the tower you want to build!",
				r = 0.087266462599716,
				font_size = 10,
				line_height = 0.8,
				color = "dark_red",
				pos = v(154, 244),
				size = v(154, 34)
			},
			{
				vertical_align = "middle",
				text_align = "center",
				text = "wOOt!",
				r = 0.17453292519943,
				font_size = 11,
				line_height = 0.8,
				color = "dark_red",
				pos = v(310, 115),
				size = v(135, 30)
			},
			{
				vertical_align = "middle",
				text_align = "center",
				text = "ready for action!",
				r = 0.17453292519943,
				font_size = 12,
				line_height = 0.8,
				color = "dark_red",
				pos = v(310, 221),
				size = v(135, 30)
			}
		},
		TUTORIAL_3 = {
			{
				text = "Basic Tower Types",
				font_size = 22,
				text_align = "center",
				pos = v(54, 55),
				size = v(482, 28),
				anchor = {
					y = 30
				}
			},
			{
				text = "There are four basic types of towers available.",
				color = "gray",
				fit_lines = 1,
				font_size = 16,
				text_align = "center",
				pos = v(54, 55),
				size = v(482, 22)
			},
			{
				text = "ARCHER TOWER",
				color = "dark_red",
				fit_lines = 1,
				font_size = 14,
				text_align = "center",
				pos = v(24, 94),
				size = v(127, 30)
			},
			{
				text = "BARRACKS",
				color = "dark_red",
				fit_lines = 1,
				font_size = 14,
				text_align = "center",
				pos = v(162, 94),
				size = v(127, 30)
			},
			{
				text = "MYSTIC MAGES",
				color = "dark_red",
				fit_lines = 1,
				font_size = 14,
				text_align = "center",
				pos = v(301, 94),
				size = v(127, 30)
			},
			{
				text = "STONE DRUIDS",
				color = "dark_red",
				fit_lines = 1,
				font_size = 14,
				text_align = "center",
				pos = v(441, 94),
				size = v(126, 30)
			},
			{
				vertical_align = "middle",
				fit_lines = 3,
				text = "good rate of fire",
				font_size = 12,
				text_align = "center",
				color = "gray",
				pos = v(33, 219),
				size = v(108, 30),
				line_height = CJK(0.7, nil, 1)
			},
			{
				vertical_align = "middle",
				fit_lines = 3,
				text = "soldiers block enemies",
				font_size = 12,
				text_align = "center",
				color = "gray",
				pos = v(170, 218),
				size = v(113, 33),
				line_height = CJK(0.7, nil, 1)
			},
			{
				vertical_align = "middle",
				fit_lines = 3,
				text = "multi-shot, armor piercing",
				font_size = 12,
				text_align = "center",
				color = "gray",
				pos = v(308, 219),
				size = v(113, 31),
				line_height = CJK(0.7, nil, 1)
			},
			{
				vertical_align = "middle",
				fit_lines = 3,
				text = "deals area damage",
				font_size = 12,
				text_align = "center",
				color = "gray",
				pos = v(448, 218),
				size = v(112, 31),
				line_height = CJK(0.7, nil, 1)
			}
		},
		TIP_ARMOR = {
			{
				text = "ARMORED ENEMIES!",
				fit_lines = 1,
				font_size = 24,
				pos = v(130, 50),
				size = v(320, 30)
			},
			{
				text = "some enemies wear armor of different strengths that protects them against non-magical attacks.",
				font_size = 16,
				fit_lines = 4,
				color = "gray",
				pos = v(130, CJK(80, nil, nil, 91)),
				size = v(320, 80)
			},
			{
				text = "resists damage from",
				text_align = "center",
				font_size = 15,
				color = "red",
				pos = v(151, 166),
				size = v(117, 42)
			},
			{
				text = "Armored enemies take less damage from archers, soldiers and stone druids.",
				text_align = "center",
				fit_lines = 3,
				font_size = 18,
				color = "gray",
				pos = v(44, 286),
				size = v(416, 70)
			}
		},
		TIP_ARMOR_MAGIC = {
			{
				text = "MAGIC RESISTANT ENEMIES!",
				fit_lines = 1,
				font_size = 24,
				pos = v(118, 81),
				size = v(337, 30),
				anchor = {
					y = 30
				}
			},
			{
				color = "gray",
				fit_lines = 4,
				text = "some enemies enjoy different levels of magic resistance that protects them against magical attacks.",
				font_size = 16,
				pos = v(118, CJK(78, 84, nil, 91)),
				size = v(338, 80),
				line_height = CJK(0.9, nil, 1)
			},
			{
				text = "resist damage from",
				text_align = "center",
				font_size = 15,
				color = "red",
				pos = v(196, 169),
				size = v(117, 42)
			},
			{
				text = "Magic resistant enemies take less damage from mages.",
				text_align = "center",
				fit_lines = 3,
				font_size = 18,
				color = "gray",
				pos = v(54, 286),
				size = v(400, 70)
			}
		},
		TIP_RALLY = {
			{
				text = "COMMAND YOUR TROOPS!",
				fit_lines = 1,
				font_size = 24,
				pos = v(118, 83),
				size = v(337, 30),
				anchor = {
					y = 30
				}
			},
			{
				color = "gray",
				fit_lines = 4,
				text = "you can adjust your soldiers rally point to make them defend a different area.",
				font_size = 16,
				pos = v(118, CJK(80, 86, nil, 91)),
				size = v(338, 80),
				line_height = CJK(0.9, nil, 1.1)
			},
			{
				text = "rally range",
				color = "blue",
				font_size = 12,
				text_align = "center",
				pos = v(254, 157),
				size = v(168, 21)
			},
			{
				color = "red",
				text = "select the rally point control",
				font_size = 12,
				text_align = "center",
				pos = v(71, 319),
				size = v(202, 42),
				line_height = CJK(0.9, nil, 1.1)
			},
			{
				color = "red",
				text = "select where you want to move your soldiers",
				font_size = 12,
				text_align = "center",
				pos = v(292, 319),
				size = v(173, 42),
				line_height = CJK(0.9, nil, 1.1)
			}
		},
		TIP_STRATEGY = {
			{
				text = "STRATEGY BASICS!",
				font_size = 24,
				text_align = "center",
				pos = v(53, 64),
				size = v(408, 34),
				anchor = {
					y = 34
				}
			},
			{
				color = "gray",
				fit_lines = 4,
				text = "Barracks are good for blocking the enemy but lack in attack power. Make sure you have enough firepower to support them!",
				font_size = 16,
				pos = v(60, 66),
				size = v(399, 66),
				line_height = CJK(0.9, nil, 1.1)
			},
			{
				vertical_align = "middle",
				color = "black",
				font_size = 12,
				text_align = "center",
				text = "Support your soldiers with ranged towers!",
				pos = v(268, 293),
				size = v(126, 52),
				line_height = CJK(0.8, nil, 1.1)
			}
		},
		TIP_HEROES = {
			{
				vertical_align = "middle",
				text = "Hero at your command!",
				font_size = 23,
				text_align = "center",
				pos = v(53, 60),
				size = v(408, 38),
				anchor = {
					y = 38
				}
			},
			{
				fit_lines = 3,
				color = "gray",
				font_size = 15,
				text_align = "center",
				text = "Heroes are elite units that can face strong enemies and support your forces.",
				pos = v(50, 62),
				size = v(408, 44),
				line_height = CJK(0.75, nil, 1.1)
			},
			{
				vertical_align = "middle",
				color = "black",
				font_size = 13,
				text_align = "center",
				text = "Select by clicking on the portrait or hero unit. Hotkey: space bar",
				pos = v(139, 113),
				size = v(205, 52),
				line_height = CJK(0.8, nil, 1.1)
			},
			{
				vertical_align = "middle",
				color = "black",
				font_size = 13,
				text_align = "center",
				text = "Click on the path to move the hero.",
				pos = v(297, 256),
				size = v(155, 43),
				line_height = CJK(0.8, nil, 1.1)
			},
			{
				color = "black",
				text = "Shows level, health and experience.",
				font_size = 15,
				text_align = "center",
				pos = v(34, 223),
				size = v(109, 69),
				line_height = CJK(0.8, nil, 1.1)
			},
			{
				fit_lines = 2,
				color = "gray",
				font_size = 17,
				text_align = "center",
				text = "Heroes gain experience every time they damage an enemy or use an ability.",
				pos = v(54, 310),
				size = v(400, 69),
				line_height = CJK(0.75, nil, 1.1)
			}
		},
		TIP_UPGRADES = {
			{
				vertical_align = "middle",
				text = "UPGRADES AND HEROES RESTRICTIONS!",
				font_size = 22,
				text_align = "left",
				pos = v(135, 35),
				size = v(310, 44)
			},
			{
				text = "iron and heroic challenges may have restrictions on upgrades!",
				font_size = 18,
				text_align = "center",
				pos = v(40, 108),
				size = v(194, 100)
			},
			{
				text = "check the stage description to see:",
				font_size = 17,
				text_align = "left",
				pos = v(48, 288),
				size = v(314, 26)
			},
			{
				text = "- max upgrade level allowed",
				font_size = 16,
				text_align = "left",
				pos = v(50, 310),
				size = v(286, 24)
			},
			{
				text = "- if heroes are allowed",
				font_size = 16,
				text_align = "left",
				pos = v(50, 328),
				size = v(286, 24)
			},
			{
				color = "red",
				text = "max lvl allowed",
				font_size = 10,
				text_align = "center",
				pos = v(396, 309),
				size = v(68, 20),
				line_height = CJK(0.8, nil, 1.1)
			},
			{
				color = "red",
				text = "no heroes",
				font_size = 10,
				text_align = "center",
				pos = v(405, 334),
				size = v(50, 20),
				line_height = CJK(0.8, nil, 1.1)
			}
		},
		TIP_SURVIVAL = {
			{
				vertical_align = "middle",
				text = "Survival mode!",
				font_size = 28,
				text_align = "center",
				pos = v(62, 41),
				size = v(380, 44)
			},
			{
				text = "Face an endless unrelenting enemy force and try to defeat as many as possible to compete for the best score!",
				font_size = 18,
				text_align = "center",
				pos = v(178, 103),
				size = v(274, 91)
			},
			{
				text = "Earn huge bonus points and gold by calling waves earlier!",
				font_size = 18,
				text_align = "center",
				pos = v(230, 210),
				size = v(216, 79)
			},
			{
				vertical_align = "middle-caps",
				text = "+1000",
				font_size = 24,
				text_align = "left",
				font_name = "numbers_bold",
				pos = v(394, 287),
				size = v(50, 25),
				colors = {
					text = {
						0,
						0,
						0,
						200
					}
				}
			},
			{
				vertical_align = "middle-caps",
				text = "+1000",
				font_size = 24,
				text_align = "left",
				font_name = "numbers_bold",
				pos = v(392, 285),
				size = v(50, 25),
				colors = {
					text = {
						255,
						255,
						255,
						255
					}
				}
			}
		}
	},
	tower_menu_button_places_galaxy = {
		v(24, 15),
		v(124, 15),
		v(24, 130),
		v(124, 130),
		v(74, 2),
		v(12, 34),
		v(136, 34),
		v(128, 118),
		v(74, 140),
		--改
		v(74, 72.5),
		v(14, 72.5),
		v(134, 72.5),
		v(-28, 15),
		v(-38, 72.5),
		v(-28, 130),
		v(-80, 15),
		v(-90, 72.5),
		v(-80, 130),
		v(176, 15),
		v(186, 72.5),
		v(176, 130),
		v(228, 15),
		v(238, 72.5),
		v(228, 130),
	},
	tower_menu_button_places_ago = {
		v(24, 20),
		v(124, 20),
		v(24, 120),
		v(124, 120),
		v(74, 2),
		v(12, 34),
		v(136, 34),
		v(128, 118),
		v(74, 140),
		--改
		v(74, 70),
		v(0, 70),
		v(148, 70),
		v(-33, 15),
		v(-57, 70),
		v(-33, 125),
		v(-85, 15),
		v(-109, 70),
		v(-85, 125),
		v(181, 15),
		v(205, 70),
		v(181, 125),
		v(233, 15),
		v(257, 70),
		v(233, 125),
	},	
	tower_menu_button_places = {
		v(24, 15),
		v(124, 15),
		v(24, 130),
		v(124, 130),
		v(74, 2),
		v(12, 34),
		v(136, 34),
		v(128, 118),
		v(74, 140),
		--改
		v(74, 72.5),
		v(-2, 72.5),
		v(150, 72.5),
		v(-28, 15),
		v(-54, 72.5),
		v(-28, 130),
		v(-80, 15),
		v(-106, 72.5),
		v(-80, 130),
		v(176, 15),
		v(202, 72.5),
		v(176, 130),
		v(228, 15),
		v(254, 72.5),
		v(228, 130),
	},
	tower_menu_power_places = {
		v(29, 3),
		v(47, 10),
		v(53, 27)
	},
	range_center_offset = v(0, -12),
--[[	
	damage_icons = {
		default = "base_info_icons_0001",
		magic = "base_info_icons_0002",
		sword = "base_info_icons_0001",
		fireball = "base_info_icons_0012",
		arrow = "base_info_icons_0010",
		shot = "base_info_icons_0011",
		[DAMAGE_TRUE] = "base_info_icons_0001",
		[DAMAGE_PHYSICAL] = "base_info_icons_0001",
		[DAMAGE_MAGICAL] = "base_info_icons_0002",
		[DAMAGE_EXPLOSION] = "base_info_icons_0001"
	},
]]--
	damage_icons = {
		default = "base_info_icons_0001",
		magic = "base_info_icons_0002",
		meleemagic = "base_info_icons_0020",
		sword = "base_info_icons_0001",
		fireball = "base_info_icons_0012",
		arrow = "base_info_icons_0010",
		shot = "base_info_icons_0011",
		electrical = "base_info_icons_0018",
		meleeelectrical = "base_info_icons_0015",
		explosion = "base_info_icons_0019",
		meleeexplosion = "base_info_icons_0016",
		meleetrue = "base_info_icons_0014",
		rangedtrue = "base_info_icons_0017",
		[DAMAGE_TRUE] = "base_info_icons_0017",
        -- 远程的物理攻击在 game_gui 中额外处理，显示为箭伤
		[DAMAGE_PHYSICAL] = "base_info_icons_0001",
		[DAMAGE_MAGICAL] = "base_info_icons_0002",
		[DAMAGE_EXPLOSION] = "base_info_icons_0019",
        [DAMAGE_ELECTRICAL] = "base_info_icons_0018",
		[DAMAGE_SHOT] = "base_info_icons_0011",
		[DAMAGE_FIREBALL] = "base_info_icons_0012",
	},	
	power_button_block_styles = {
		drow_queen = {
			image = "malicia_powerNet_0001",
			animations = {
				block = {
					to = 14,
					prefix = "malicia_powerNet",
					from = 1
				},
				unblock = {
					to = 20,
					prefix = "malicia_powerNet",
					from = 15
				}
			}
		},
		eb_spider = {
			image = "spiderQueen_powerNet_0001",
			animations = {
				block = {
					to = 14,
					prefix = "spiderQueen_powerNet",
					from = 1
				},
				unblock = {
					to = 20,
					prefix = "spiderQueen_powerNet",
					from = 15
				}
			}
		}
	}
}
