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
				x = 58,
				y = 474
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_153",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 134,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 226,
				y = 228
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 309,
				y = 436
			},
			["tower.default_rally_pos"] = {
				x = 229,
				y = 393
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 365.0,
				y = 285
			},
			["tower.default_rally_pos"] = {
				x = 373,
				y = 228
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 272,
				y = 169
			},
			["tower.default_rally_pos"] = {
				x = 305,
				y = 236
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 378,
				y = 140
			},
			["tower.default_rally_pos"] = {
				x = 405,
				y = 228
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 578,
				y = 287
			},
			["tower.default_rally_pos"] = {
				x = 493,
				y = 310
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 545,
				y = 192
			},
			["tower.default_rally_pos"] = {
				x = 464,
				y = 238
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 206,
				y = 490
			},
			["tower.default_rally_pos"] = {
				x = 194,
				y = 442
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 130,
				y = 366
			},
			["tower.default_rally_pos"] = {
				x = 120,
				y = 453
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 440,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 523,
				y = 461
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 573,
				y = 386
			},
			["tower.default_rally_pos"] = {
				x = 487,
				y = 402
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 763,
				y = 371
			},
			["tower.default_rally_pos"] = {
				x = 673,
				y = 378
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 682,
				y = 237
			},
			["tower.default_rally_pos"] = {
				x = 729,
				y = 318
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 400,
			pos = {
				x = 702,
				y = 496
			},
			["tower.default_rally_pos"] = {
				x = 687,
				y = 443
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14",
		},
		{
			["editor.r"] = 0.9272952180016122,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 909,
				y = 569
			},
		},
		{
			["editor.r"] = 0.9272952180016122,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 871,
				y = 597
			},
		},
		{
			["editor.r"] = 0.511937176307204,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1146,
				y = 248
			},
		},
		{
			["editor.r"] = 0.511937176307204,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1146,
				y = 298
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 58,
				y = 526
			},
			["render.sprites[1].z"] = Z_DECALS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 58,
				y = 424
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 58,
				y = 203
			},
			["render.sprites[1].z"] = Z_DECALS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 58,
				y = 102
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
				x = 58,
				y = 474
			},
		},
		{
			template = "decal_defend_point5",
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1,
			pos = {
				x = 58,
				y = 152
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 890,
				y = 574
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.308,
			["render.sprites[1].name"] = "Stage3_tunnelMask",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 881,
				y = 595
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.444,
			["render.sprites[1].name"] = "Stage3_tunnelShadow",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 258,
				y = 535
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.156,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage2_firepit_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 785,
				y = 564
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.156,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage3_firepit_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 931,
				y = 492
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.156,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage3_firepit_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 697,
				y = 589
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0,
			["render.sprites[1].name"] = "Stage3_mask2",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 377,
				y = 551
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0,
			["render.sprites[1].name"] = "Stage3_mask1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "multiple_objects",
			pos = {
				x = 0,
				y = 0
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 988,
				y = 554
			},
			["render.sprites[1].anchor.x"] = 0.119,
			["render.sprites[1].anchor.y"] = 0.166,
			["render.sprites[1].name"] = "Stage_3_mask_1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1106.0,
				y = -9
			},
			["render.sprites[1].anchor.x"] = 0.538,
			["render.sprites[1].anchor.y"] = 0.0,
			["render.sprites[1].name"] = "Stage_3_mask_0",
			["render.sprites[1].animated"] = false,
		},
	},
	nav_mesh = {
		{ 4, 9, nil, nil },
		{ 10, nil, 8, 3 },
		{ 7, 2, 1, 5 },
		{ 5, 3, 1, nil },
		{ 7, 3, 4, nil },
		{ 13, 11, 3, 7 },
		{ 13, 6, 5, nil },
		{ 2, nil, nil, 9 },
		{ 2, 8, nil, 1 },
		{ 11, nil, 2, 3 },
		{ 14, nil, 10, 6 },
		{ nil, 14, 11, 13 },
		{ nil, 12, 6, nil },
		{ nil, nil, 11, 12 },
	}
}