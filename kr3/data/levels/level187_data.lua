return {
	level_terrain_type = 411,
	locked_hero = false,
	max_upgrade_level = 5,
	custom_start_pos = {
		zoom = 1.3,
		pos = {x = 512, y = 384}
	},
	custom_spawn_pos = {
		{
			pos = {
				x = 887,
				y = 418
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_437",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 632,
				y = 476
			},
			["tower.default_rally_pos"] = {
				x = 659,
				y = 432
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 433,
				y = 473
			},
			["tower.default_rally_pos"] = {
				x = 429,
				y = 436
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 829,
				y = 478
			},
			["tower.default_rally_pos"] = {
				x = 798,
				y = 432
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 735,
				y = 505
			},
			["tower.default_rally_pos"] = {
				x = 727,
				y = 460
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 348,
				y = 371
			},
			["tower.default_rally_pos"] = {
				x = 367,
				y = 447
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 226,
				y = 329
			},
			["tower.default_rally_pos"] = {
				x = 178,
				y = 394
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 280,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 298,
				y = 449
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 175,
				y = 451
			},
			["tower.default_rally_pos"] = {
				x = 239,
				y = 425
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 735,
				y = 380
			},
			["tower.default_rally_pos"] = {
				x = 646,
				y = 367
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 560,
				y = 343
			},
			["tower.default_rally_pos"] = {
				x = 539,
				y = 420
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 767,
				y = 218
			},
			["tower.default_rally_pos"] = {
				x = 674,
				y = 243
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 411,
			pos = {
				x = 597,
				y = 201
			},
			["tower.default_rally_pos"] = {
				x = 672,
				y = 176
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12",
		},
		{
			["editor.r"] = 3.141592653589793,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -80,
				y = 415
			},
		},
		{
			["editor.r"] = 3.141592653589793,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -80,
				y = 365
			},
		},
		{
			["editor.r"] = -2.356194490192345,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 415,
				y = 346
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 905,
				y = 468
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 968,
				y = 392
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 735,
				y = 55
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 610,
				y = 55
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defend_point5",
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1,
			pos = {
				x = 943,
				y = 440
			},
		},
		{
			template = "decal_defend_point5",
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1,
			pos = {
				x = 672,
				y = 68
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 977,
				y = 424
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.216,
			["render.sprites[1].name"] = "stage37_ship",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 977,
				y = 344
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.216,
			["render.sprites[1].name"] = "stage37_ship_pc",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 535,
				y = 462
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.212,
			["render.sprites[1].name"] = "stage37_house",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 752,
				y = 294
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.212,
			["render.sprites[1].name"] = "stage37_house",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "stage37_barrel1_shifted",
			pos = {
				x = 454,
				y = 587
			},
		},
		{
			template = "stage37_barrel1_shifted",
			pos = {
				x = 520,
				y = 609
			},
		},
		{
			template = "stage37_barrel1_shifted",
			pos = {
				x = 547,
				y = 542
			},
		},
		{
			template = "stage37_barrel1",
			pos = {
				x = 210,
				y = 581
			},
		},
		{
			template = "stage37_barrel1_shifted",
			pos = {
				x = 92,
				y = 218
			},
		},
		{
			template = "stage37_barrel1_shifted",
			pos = {
				x = 135,
				y = 243
			},
		},
		{
			template = "stage37_barrel1",
			pos = {
				x = 370,
				y = 191
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 174,
				y = 568
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 629,
				y = 749
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 842,
				y = 623
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 140,
				y = 209
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 391,
				y = 168
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 76,
				y = 662
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 543,
				y = 688
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 275,
				y = 728
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 497,
				y = 542
			},
		},
		{
			template = "stage37_barrel2_shifted",
			pos = {
				x = 710,
				y = 715
			},
		},
		{
			template = "stage37_barrel2",
			pos = {
				x = 499,
				y = 577
			},
		},
		{
			template = "stage37_chicken1",
			pos = {
				x = 499,
				y = 576
			},
		},
		{
			template = "stage37_chicken1",
			pos = {
				x = 210,
				y = 580
			},
		},
		{
			template = "stage37_chicken1",
			pos = {
				x = 370,
				y = 190
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 601,
				y = 542
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 360,
				y = 499
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 493,
				y = 293
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 894,
				y = 687
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 527,
				y = 313
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 229,
				y = 539
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 673,
				y = 575
			},
		},
		{
			template = "stage37_chicken2",
			pos = {
				x = 323,
				y = 79
			},
		},
		{
			template = "stage37_plank1",
			pos = {
				x = 559,
				y = 602
			},
		},
		{
			template = "stage37_plank1",
			pos = {
				x = 77,
				y = 688
			},
		},
		{
			template = "stage37_plank1",
			pos = {
				x = 193,
				y = 665
			},
		},
		{
			template = "stage37_plank1",
			pos = {
				x = 366,
				y = 145
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 743,
				y = 687
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 105,
				y = 681
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 145,
				y = 606
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 231,
				y = 733
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 163,
				y = 541
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 419,
				y = 597
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 159,
				y = 267
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 845,
				y = 600
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 114,
				y = 236
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 98,
				y = 631
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 263,
				y = 627
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 453,
				y = 560
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 546,
				y = 572
			},
		},
		{
			template = "stage37_plank2",
			pos = {
				x = 357,
				y = 168
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 141,
				y = 678
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage37_watership_prop_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 140,
				y = 676
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage37_prop_animado_ship_",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 573,
				y = 648
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage37_prop_animado_flagbase_",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 573,
				y = 646
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage37_flag_prop_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 572,
				y = 649
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage37_waterflag_prop_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 919,
				y = 734
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 801,
				y = 743
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 683,
				y = 679
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 475,
				y = 619
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 307,
				y = 692
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 174,
				y = 628
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 988,
				y = 176
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 119,
				y = 724
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 289,
				y = 184
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 149,
				y = 174
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 79,
				y = 74
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 229,
				y = 204
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 159,
				y = 124
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 341,
				y = 640
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1107,
				y = 754
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1068,
				y = 696
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 34,
				y = 647
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 46,
				y = 123
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1143,
				y = 203
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1087,
				y = 168
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1156,
				y = 82
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -34,
				y = 707
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage32_water_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 986,
				y = 700
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "Stage32_boatsail_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "touch_garfio",
			pos = {
				x = 957,
				y = 162
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "dlc_pirates_treasure_achievement",
			pos = {
				x = 118,
				y = 324
			},
		},
	},
	nav_mesh = {
		{ 4, nil, 2, 10 },
		{ 1, nil, 7, 5 },
		{ nil, nil, 4, 9 },
		{ 3, nil, 1, 9 },
		{ 10, 2, 6, nil },
		{ 5, 8, nil, nil },
		{ 2, nil, 8, 5 },
		{ 7, nil, nil, 6 },
		{ nil, 4, 1, 11 },
		{ 9, 1, 5, 12 },
		{ nil, 9, 12, nil },
		{ 11, 10, 5, nil },
	}
}