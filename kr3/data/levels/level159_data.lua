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
				x = 459,
				y = 50
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_49",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 670,
				y = 157
			},
			["tower.default_rally_pos"] = {
				x = 776,
				y = 140
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 419,
				y = 237
			},
			["tower.default_rally_pos"] = {
				x = 525,
				y = 253
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 708,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 732,
				y = 355
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 410,
				y = 152
			},
			["tower.default_rally_pos"] = {
				x = 506,
				y = 132
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 838,
				y = 401
			},
			["tower.default_rally_pos"] = {
				x = 785,
				y = 347
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 799,
				y = 235
			},
			["tower.default_rally_pos"] = {
				x = 897,
				y = 236
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 193,
				y = 183
			},
			["tower.default_rally_pos"] = {
				x = 225,
				y = 264
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 239,
				y = 329
			},
			["tower.default_rally_pos"] = {
				x = 327,
				y = 306
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 888,
				y = 476
			},
			["tower.default_rally_pos"] = {
				x = 800,
				y = 500
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 628,
				y = 418
			},
			["tower.default_rally_pos"] = {
				x = 740,
				y = 420
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 130,
				y = 397
			},
			["tower.default_rally_pos"] = {
				x = 120,
				y = 310
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 415,
				y = 412
			},
			["tower.default_rally_pos"] = {
				x = 340,
				y = 400
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 520,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 500,
				y = 325
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13",
		},
		{
			["editor.r"] = 3.141592653589793,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -83,
				y = 338
			},
		},
		{
			["editor.r"] = 3.141592653589793,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 131,
				y = 649
			},
		},
		{
			["editor.r"] = 0.3743336160075839,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 897,
				y = 620
			},
		},
		{
			["editor.r"] = 0.9797634294924663,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 955,
				y = 429
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 814,
				y = 50
			},
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 663,
				y = 50
			},
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
				x = 459,
				y = 50
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 540,
				y = 50
			},
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 372,
				y = 50
			},
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
				x = 739,
				y = 50
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 51,
				y = 462
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.024,
			["render.sprites[1].name"] = "Stage9_house_left",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1020,
				y = 515
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.033,
			["render.sprites[1].name"] = "Stage9_house_right",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -16,
				y = 532
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.0,
			["render.sprites[1].name"] = "Stage_9_mask_1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1065,
				y = 514
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.0,
			["render.sprites[1].name"] = "Stage_9_mask_0",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1037,
				y = 470
			},
			["render.sprites[1].anchor.x"] = 0.444,
			["render.sprites[1].anchor.y"] = 0.226,
			["render.sprites[1].name"] = "Stage_9_mask_2",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1023.0,
				y = 444
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.052,
			["render.sprites[1].name"] = "Stage_9_tavern_top",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1023.0,
				y = 444
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.052,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage_9_tavern_floor",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 531,
				y = 491
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage_9_fire_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "hodor",
			pos = {
				x = 790,
				y = 610
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 790,
				y = 610
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.34,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage_9_hodor_mask",
			["render.sprites[1].animated"] = false,
		},
	},
	nav_mesh = {
		{ 6, 3, 4, nil },
		{ 1, 12, 8, 4 },
		{ 6, 10, 13, 1 },
		{ 1, 2, 7, nil },
		{ nil, 9, 10, 6 },
		{ nil, 5, 3, nil },
		{ 4, 8, nil, nil },
		{ 12, nil, 11, 7 },
		{ nil, nil, 10, 5 },
		{ 5, nil, 13, 3 },
		{ 8, nil, nil, 7 },
		{ 13, nil, 8, 2 },
		{ 10, nil, 12, 2 },
	}
}