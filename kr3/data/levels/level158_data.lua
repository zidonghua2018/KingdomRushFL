return {
	level_terrain_type = 401,
	locked_hero = false,
	max_upgrade_level = 5,
	custom_start_pos = {
		zoom = 1.3,
		pos = {x = 512, y = 384}
	},
	custom_spawn_pos = {
		{
			pos = {
				x = 966,
				y = 338
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_48",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 440,
				y = 525
			},
			["tower.default_rally_pos"] = {
				x = 490,
				y = 471
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 670,
				y = 331
			},
			["tower.default_rally_pos"] = {
				x = 595,
				y = 290
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 589,
				y = 627
			},
			["tower.default_rally_pos"] = {
				x = 524,
				y = 587
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 221,
				y = 347
			},
			["tower.default_rally_pos"] = {
				x = 218,
				y = 294
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 266,
				y = 195
			},
			["tower.default_rally_pos"] = {
				x = 307,
				y = 307
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 362,
				y = 617
			},
			["tower.default_rally_pos"] = {
				x = 465,
				y = 636
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 626,
				y = 523
			},
			["tower.default_rally_pos"] = {
				x = 540,
				y = 560
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 860,
				y = 264
			},
			["tower.default_rally_pos"] = {
				x = 751,
				y = 281
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 494,
				y = 248
			},
			["tower.default_rally_pos"] = {
				x = 572,
				y = 307
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 572,
				y = 405
			},
			["tower.default_rally_pos"] = {
				x = 512,
				y = 340
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 138,
				y = 218
			},
			["tower.default_rally_pos"] = {
				x = 146,
				y = 300
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			["editor.r"] = 3.141592653589793,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -83,
				y = 379
			},
		},
		{
			["editor.r"] = 1.5769312191527725,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 459,
				y = 716
			},
		},
		{
			["editor.r"] = -1.1034173918274317,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 650,
				y = 70
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 966,
				y = 264
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 966,
				y = 398
			},
			["render.sprites[1].z"] = Z_DECALS,
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
				x = 966,
				y = 338
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 10,
				y = 774
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 183,
				y = 702
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 355,
				y = 632
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -11,
				y = 641
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -170,
				y = 680
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 149,
				y = 559
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 321,
				y = 486
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -33,
				y = 509
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -200,
				y = 530
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 120,
				y = 430
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 289,
				y = 355
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 983,
				y = 788
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 787,
				y = 727
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 948,
				y = 646
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 765,
				y = 596
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 920,
				y = 515
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 687,
				y = 480
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1030,
				y = 339
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 857,
				y = 409
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1130,
				y = 620
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1155.0,
				y = 720
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 83,
				y = 135
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 55,
				y = 5
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 256,
				y = 64
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 224,
				y = -66
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 448,
				y = 129
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 426,
				y = -5
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 620,
				y = 57
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 587,
				y = -87
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 793,
				y = 133
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 792,
				y = -14
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 965,
				y = 61
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 963,
				y = -84
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1150,
				y = 60
			},
			["render.sprites[1].name"] = "stage7_water_run",
			["render.sprites[1].animated"] = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 274.5,
				y = 440
			},
			["render.sprites[1].name"] = "Stage8_ship_mask",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "seal",
			pos = {
				x = 785,
				y = 592
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "seal",
			pos = {
				x = 357,
				y = 100
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 278,
				y = 706
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 792,
				y = 477
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 830,
				y = 490
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 180,
				y = 178
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 140,
				y = 161
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 330,
				y = 690
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 270,
				y = 670
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 822,
				y = 470
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 110,
				y = 590
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage8_fish_run",
			["render.sprites[1].animated"] = true,
			max_delay = "15",
			min_delay = "5",
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 770,
				y = 640
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage8_fish_run",
			["render.sprites[1].animated"] = true,
			max_delay = "15",
			min_delay = "5",
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 748,
				y = 560
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage8_fish_run",
			["render.sprites[1].animated"] = true,
			max_delay = "15",
			min_delay = "5",
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 430,
				y = 30
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage8_fish_run",
			["render.sprites[1].animated"] = true,
			max_delay = "15",
			min_delay = "5",
		},
		{
			template = "penguin",
			pos = {
				x = 140,
				y = 666
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 880,
				y = 110
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 140,
				y = 430
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 940,
				y = 245
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "penguin",
			pos = {
				x = 450,
				y = 135
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
	},
	nav_mesh = {
		{ 10, 6, 4, 9 },
		{ 8, 7, 10, nil },
		{ nil, nil, 1, 7 },
		{ 1, 6, nil, 11 },
		{ 9, 4, 11, nil },
		{ 3, nil, nil, 1 },
		{ nil, 3, 1, 10 },
		{ nil, 7, 2, nil },
		{ 2, 10, 5, nil },
		{ 2, 7, 1, 9 },
		{ 5, 4, nil, nil },
	}
}