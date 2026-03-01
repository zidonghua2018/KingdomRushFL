return {
	level_terrain_type = 400,
	locked_hero = false,
	max_upgrade_level = 5,
	custom_start_pos = {
		zoom = 1.3,
		pos = {x = 512, y = 384}
	},
	custom_spawn_pos = {
		{
			pos = {
				x = 56,
				y = 393
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_44",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 423,
				y = 414
			},
			["tower.default_rally_pos"] = {
				x = 394,
				y = 494
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 589,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 588,
				y = 587
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 590,
				y = 327
			},
			["tower.default_rally_pos"] = {
				x = 588,
				y = 422
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 710,
				y = 447
			},
			["tower.default_rally_pos"] = {
				x = 675,
				y = 401
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 840,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 840,
				y = 314
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 836,
				y = 370
			},
			["tower.default_rally_pos"] = {
				x = 762,
				y = 328
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 436,
				y = 559
			},
			["tower.default_rally_pos"] = {
				x = 487,
				y = 520
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 246,
				y = 454
			},
			["tower.default_rally_pos"] = {
				x = 261,
				y = 404
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 513,
				y = 265
			},
			["tower.default_rally_pos"] = {
				x = 523,
				y = 206
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 665,
				y = 282
			},
			["tower.default_rally_pos"] = {
				x = 717,
				y = 224
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 395,
				y = 227
			},
			["tower.default_rally_pos"] = {
				x = 446,
				y = 164
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 167,
				y = 323
			},
			["tower.default_rally_pos"] = {
				x = 159,
				y = 407
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 271,
				y = 310
			},
			["tower.default_rally_pos"] = {
				x = 199,
				y = 390
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 338,
				y = 155
			},
			["tower.default_rally_pos"] = {
				x = 427,
				y = 108
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14",
		},
		{
			["editor.r"] = 1.5791294672350324,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 783,
				y = 716
			},
		},
		{
			["editor.r"] = 1.5791294672350324,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 839,
				y = 716
			},
		},
		{
			["editor.r"] = -0.00826427465965116,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1139,
				y = 358
			},
		},
		{
			["editor.r"] = -0.00826427465965116,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1139,
				y = 304
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 348,
				y = 23
			},
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 498,
				y = 23
			},
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 56,
				y = 329
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 56,
				y = 452
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
				x = 425,
				y = 39
			},
		},
		{
			template = "decal_defend_point5",
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1,
			pos = {
				x = 56,
				y = 393
			},
		},
		{
			template = "touch",
			pos = {
				x = 563,
				y = 690
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 181,
				y = 683
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "fire_deco_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 128,
				y = 664
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "fire_deco_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 78,
				y = 640
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "fire_deco_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 174,
				y = 552
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "fire_deco_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 223,
				y = 575
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "fire_deco_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 261,
				y = 596
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "fire_deco_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 322,
				y = 766
			},
			["render.sprites[1].scale.x"] = 1.18,
			["render.sprites[1].scale.y"] = 1.18,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 488,
				y = 783
			},
			["render.sprites[1].scale.x"] = 1.18,
			["render.sprites[1].scale.y"] = 1.18,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1019,
				y = 728
			},
			["render.sprites[1].scale.x"] = 1.18,
			["render.sprites[1].scale.y"] = 1.18,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1016.0,
				y = 480
			},
			["render.sprites[1].scale.x"] = 1.1,
			["render.sprites[1].scale.y"] = 1.1,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 865,
				y = 190
			},
			["render.sprites[1].scale.x"] = 0.61,
			["render.sprites[1].scale.y"] = 0.61,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 983,
				y = 156
			},
			["render.sprites[1].scale.x"] = 1.1,
			["render.sprites[1].scale.y"] = 1.1,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 983,
				y = 156
			},
			["render.sprites[1].scale.x"] = 1.1,
			["render.sprites[1].scale.y"] = 1.1,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 730,
				y = -15
			},
			["render.sprites[1].scale.x"] = 1.1,
			["render.sprites[1].scale.y"] = 1.1,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 133,
				y = 144
			},
			["render.sprites[1].scale.x"] = 0.9,
			["render.sprites[1].scale.y"] = 0.9,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage4_smoke_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
	},
	nav_mesh = {
		{ 2, 7, 8, 9 },
		{ 4, nil, 7, 3 },
		{ 10, 2, 9, nil },
		{ 6, nil, 2, 10 },
		{ nil, 6, 10, nil },
		{ nil, nil, 4, 5 },
		{ 2, nil, 8, 1 },
		{ 1, nil, nil, 13 },
		{ 3, 1, 11, nil },
		{ 5, 4, 3, nil },
		{ 9, 1, 13, 14 },
		{ 13, 8, nil, nil },
		{ 11, 8, 12, 14 },
		{ 9, 11, 12, nil },
	}
}