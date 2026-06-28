-- chunkname: @./kr5/data/levels/level36_data.lua

return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 5,
	custom_spawn_pos = {
		{
			pos = {
				x = -93,
				y = 233
			}
		},
		{
			pos = {
				x = 100,
				y = 233
			}
		}
	},
	custom_start_pos = {
		zoom = 1,
		pos = {
			x = 400,
			y = 200
		}
	},
	entities_list = {
		{
			template = "controller_stage_36_portal_splash",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "debug_path_renderer",
			["path_debug.background_color"] = {
				46,
				193,
				142,
				0
			},
			["path_debug.path_color"] = {
				168,
				199,
				169,
				0
			},
			pos = {
				x = -300,
				y = 868
			}
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "Stage36_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 1,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = -93,
				y = 233
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 1,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = -95,
				y = 508
			}
		},
		{
			["editor.flip"] = -1,
			template = "decal_defense_flag5",
			extra_trigger_dist = 15,
			pos = {
				x = -96,
				y = 166
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -96,
				y = 296
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -96,
				y = 448
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = -96,
				y = 562
			}
		},
		{
			template = "decal_stage_36_easter_egg_ranger_verde",
			pos = {
				x = 783,
				y = 117
			}
		},
		{
			template = "decal_stage_36_easter_egg_spyro",
			pos = {
				x = 249,
				y = 703
			}
		},
		{
			template = "decal_stage_36_mask_1",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_36_mask_islas",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_36_mask_path_main",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_36_mask_portal",
			pos = {
				x = 1040,
				y = 517
			}
		},
		{
			["editor.r"] = -5.5850536063819,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 149,
			pos = {
				x = 1018,
				y = 461
			}
		},
		{
			["editor.r"] = -5.5850536063819,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 149,
			pos = {
				x = 985,
				y = 489
			}
		},
		{
			["editor.r"] = -5.5850536063819,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 149,
			pos = {
				x = 1027,
				y = 504
			}
		},
		{
			["editor.r"] = -5.5850536063819,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 149,
			pos = {
				x = 991,
				y = 531
			}
		},
		{
			["editor.r"] = -5.0789081233036,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 149,
			pos = {
				x = 427,
				y = 696
			}
		},
		{
			template = "stage_41_paths_controller",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 429,
				y = 175
			},
			["tower.default_rally_pos"] = {
				x = 367,
				y = 248
			}
		},
		{
			["tower.holder_id"] = "29",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "29",
			pos = {
				x = 429,
				y = 175
			},
			["tower.default_rally_pos"] = {
				x = 367,
				y = 248
			}
		},
		{
			["tower.holder_id"] = "49",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "49",
			pos = {
				x = 429,
				y = 175
			},
			["tower.default_rally_pos"] = {
				x = 367,
				y = 248
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 893,
				y = 190
			},
			["tower.default_rally_pos"] = {
				x = 844,
				y = 272
			}
		},
		{
			["tower.holder_id"] = "34",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "34",
			pos = {
				x = 893,
				y = 190
			},
			["tower.default_rally_pos"] = {
				x = 844,
				y = 272
			}
		},
		{
			["tower.holder_id"] = "54",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "54",
			pos = {
				x = 893,
				y = 190
			},
			["tower.default_rally_pos"] = {
				x = 844,
				y = 272
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 663,
				y = 235
			},
			["tower.default_rally_pos"] = {
				x = 736,
				y = 301
			}
		},
		{
			["tower.holder_id"] = "27",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "27",
			pos = {
				x = 663,
				y = 235
			},
			["tower.default_rally_pos"] = {
				x = 736,
				y = 301
			}
		},
		{
			["tower.holder_id"] = "47",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "47",
			pos = {
				x = 663,
				y = 235
			},
			["tower.default_rally_pos"] = {
				x = 736,
				y = 301
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 168,
				y = 306
			},
			["tower.default_rally_pos"] = {
				x = 165,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "31",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "31",
			pos = {
				x = 168,
				y = 306
			},
			["tower.default_rally_pos"] = {
				x = 165,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "51",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "51",
			pos = {
				x = 168,
				y = 306
			},
			["tower.default_rally_pos"] = {
				x = 165,
				y = 240
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 297,
				y = 307
			},
			["tower.default_rally_pos"] = {
				x = 294,
				y = 243
			}
		},
		{
			["tower.holder_id"] = "30",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "30",
			pos = {
				x = 297,
				y = 307
			},
			["tower.default_rally_pos"] = {
				x = 294,
				y = 243
			}
		},
		{
			["tower.holder_id"] = "50",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "50",
			pos = {
				x = 297,
				y = 307
			},
			["tower.default_rally_pos"] = {
				x = 294,
				y = 243
			}
		},
		{
			["tower.holder_id"] = "48",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "48",
			pos = {
				x = 555,
				y = 322
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 387
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 38,
				y = 444
			},
			["tower.default_rally_pos"] = {
				x = 81,
				y = 522
			}
		},
		{
			["tower.holder_id"] = "22",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "22",
			pos = {
				x = 38,
				y = 444
			},
			["tower.default_rally_pos"] = {
				x = 81,
				y = 522
			}
		},
		{
			["tower.holder_id"] = "42",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "42",
			pos = {
				x = 38,
				y = 444
			},
			["tower.default_rally_pos"] = {
				x = 81,
				y = 522
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 475,
				y = 461
			},
			["tower.default_rally_pos"] = {
				x = 527,
				y = 409
			}
		},
		{
			["tower.holder_id"] = "33",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "33",
			pos = {
				x = 475,
				y = 461
			},
			["tower.default_rally_pos"] = {
				x = 527,
				y = 409
			}
		},
		{
			["tower.holder_id"] = "53",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "53",
			pos = {
				x = 475,
				y = 461
			},
			["tower.default_rally_pos"] = {
				x = 527,
				y = 409
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 263,
				y = 521
			},
			["tower.default_rally_pos"] = {
				x = 244,
				y = 473
			}
		},
		{
			["tower.holder_id"] = "32",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "32",
			pos = {
				x = 263,
				y = 521
			},
			["tower.default_rally_pos"] = {
				x = 244,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "52",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "52",
			pos = {
				x = 263,
				y = 521
			},
			["tower.default_rally_pos"] = {
				x = 244,
				y = 485
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 504,
				y = 557
			},
			["tower.default_rally_pos"] = {
				x = 580,
				y = 538
			}
		},
		{
			["tower.holder_id"] = "24",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "24",
			pos = {
				x = 504,
				y = 557
			},
			["tower.default_rally_pos"] = {
				x = 580,
				y = 538
			}
		},
		{
			["tower.holder_id"] = "44",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "44",
			pos = {
				x = 504,
				y = 557
			},
			["tower.default_rally_pos"] = {
				x = 580,
				y = 538
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 156,
				y = 561
			},
			["tower.default_rally_pos"] = {
				x = 169,
				y = 512
			}
		},
		{
			["tower.holder_id"] = "23",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "23",
			pos = {
				x = 156,
				y = 561
			},
			["tower.default_rally_pos"] = {
				x = 169,
				y = 512
			}
		},
		{
			["tower.holder_id"] = "43",
			["tower.terrain_style"] = 36,
			template = "tower_holder_sea_of_trees_17",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "43",
			pos = {
				x = 156,
				y = 561
			},
			["tower.default_rally_pos"] = {
				x = 169,
				y = 512
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 17,
				y = 305
			},
			["tower.default_rally_pos"] = {
				x = 16,
				y = 247
			}
		},
		{
			["tower.holder_id"] = "21",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "21",
			pos = {
				x = 17,
				y = 305
			},
			["tower.default_rally_pos"] = {
				x = 16,
				y = 247
			}
		},
		{
			["tower.holder_id"] = "41",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "41",
			pos = {
				x = 17,
				y = 305
			},
			["tower.default_rally_pos"] = {
				x = 16,
				y = 247
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 555,
				y = 322
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 387
			}
		},
		{
			["tower.holder_id"] = "28",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "28",
			pos = {
				x = 555,
				y = 322
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 387
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 842,
				y = 341
			},
			["tower.default_rally_pos"] = {
				x = 952,
				y = 338
			}
		},
		{
			["tower.holder_id"] = "26",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "26",
			pos = {
				x = 842,
				y = 341
			},
			["tower.default_rally_pos"] = {
				x = 952,
				y = 338
			}
		},
		{
			["tower.holder_id"] = "46",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "46",
			pos = {
				x = 842,
				y = 341
			},
			["tower.default_rally_pos"] = {
				x = 952,
				y = 338
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 701,
				y = 506
			},
			["tower.default_rally_pos"] = {
				x = 696,
				y = 589
			}
		},
		{
			["tower.holder_id"] = "25",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "25",
			pos = {
				x = 701,
				y = 506
			},
			["tower.default_rally_pos"] = {
				x = 696,
				y = 589
			}
		},
		{
			["tower.holder_id"] = "45",
			["tower.terrain_style"] = 33,
			template = "tower_holder_sea_of_trees_18",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "45",
			pos = {
				x = 701,
				y = 506
			},
			["tower.default_rally_pos"] = {
				x = 696,
				y = 589
			}
		}
	},
	ignore_walk_backwards_paths = {},
	invalid_path_ranges = {},
	level_mode_overrides = {
		{
			max_upgrade_level = 5,
			locked_powers = {},
			locked_towers = {}
		},
		{
			nav_mesh = {
				[21] = {
					31,
					22
				},
				[22] = {
					32,
					23,
					nil,
					21
				},
				[23] = {
					24,
					nil,
					22,
					32
				},
				[24] = {
					25,
					nil,
					23,
					33
				},
				[25] = {
					26,
					nil,
					24,
					28
				},
				[26] = {
					nil,
					25,
					28,
					34
				},
				[27] = {
					26,
					28,
					29,
					34
				},
				[28] = {
					26,
					24,
					29,
					27
				},
				[29] = {
					27,
					28,
					30
				},
				[30] = {
					28,
					32,
					31,
					29
				},
				[31] = {
					30,
					23,
					21
				},
				[32] = {
					24,
					nil,
					23,
					30
				},
				[33] = {
					25,
					24,
					32,
					28
				},
				[34] = {
					[2] = 26,
					[3] = 27
				}
			}
		},
		{
			available_towers = {
				"tower_build_sand",
				"tower_build_dark_elf"
			},
			locked_towers = {
				"tower_build_hermit_toad",
				"tower_build_ballista",
				"tower_build_paladin_covenant",
				"tower_build_tricannon",
				"tower_build_demon_pit",
				"tower_build_rocket_gunners",
				"tower_build_arcane_wizard",
				"tower_build_barrel",
				"tower_build_royal_archers",
				"tower_build_ghost",
				"tower_build_ray",
				"tower_build_necromancer",
				"tower_build_elven_stargazers",
				"tower_build_arborean_emissary"
			},
			nav_mesh = {
				[41] = {
					51,
					42
				},
				[42] = {
					52,
					43,
					nil,
					41
				},
				[43] = {
					44,
					nil,
					42,
					52
				},
				[44] = {
					45,
					nil,
					43,
					53
				},
				[45] = {
					46,
					nil,
					44,
					48
				},
				[46] = {
					nil,
					45,
					48,
					54
				},
				[47] = {
					46,
					48,
					49,
					54
				},
				[48] = {
					46,
					44,
					49,
					47
				},
				[49] = {
					47,
					48,
					50
				},
				[50] = {
					48,
					52,
					51,
					49
				},
				[51] = {
					50,
					43,
					41
				},
				[52] = {
					44,
					43,
					42,
					50
				},
				[53] = {
					45,
					44,
					52,
					48
				},
				[54] = {
					[2] = 46,
					[3] = 47
				}
			}
		}
	},
	nav_mesh = {
		{
			11,
			2
		},
		{
			12,
			3,
			nil,
			1
		},
		{
			12,
			nil,
			2,
			11
		},
		{
			5,
			nil,
			3,
			13
		},
		{
			6,
			nil,
			4,
			8
		},
		{
			nil,
			5,
			8,
			14
		},
		{
			6,
			8,
			9,
			14
		},
		{
			6,
			4,
			9,
			7
		},
		{
			7,
			8,
			10
		},
		{
			8,
			12,
			11,
			9
		},
		{
			10,
			3,
			1
		},
		{
			4,
			3,
			2,
			10
		},
		{
			5,
			4,
			12,
			8
		},
		{}
	},
	required_exoskeletons = {
		"mecanica_camino_1_stage_1Def",
		"mecanica_camino_2_stage_1Def",
		"mecanica_camino_3_stage_1Def",
		"mecanica_camino_4_stage_1Def",
		"stage_1_portalDef"
	},
	required_sounds = {
		"enemies_terrain_dragons_1",
		"music_stage141",
		"stage_141"
	},
	required_textures = {

	},
	scale_required_textures = {
		"go_stage141_bg",
		"go_stage141",
		"go_enemies_terrain_9_1"
	}
}
