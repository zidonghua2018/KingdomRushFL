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
				x = 75,
				y = 408
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_152",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 707,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 661,
				y = 567
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 455,
				y = 587
			},
			["tower.default_rally_pos"] = {
				x = 508,
				y = 542
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 503,
				y = 367
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 347
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 564,
				y = 475
			},
			["tower.default_rally_pos"] = {
				x = 457,
				y = 485
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 342,
				y = 249
			},
			["tower.default_rally_pos"] = {
				x = 426,
				y = 309
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 524,
				y = 264
			},
			["tower.default_rally_pos"] = {
				x = 430,
				y = 268
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 350,
				y = 462
			},
			["tower.default_rally_pos"] = {
				x = 349,
				y = 409
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 248,
				y = 320
			},
			["tower.default_rally_pos"] = {
				x = 231,
				y = 407
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 155,
				y = 464
			},
			["tower.default_rally_pos"] = {
				x = 131,
				y = 407
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 633,
				y = 211
			},
			["tower.default_rally_pos"] = {
				x = 637,
				y = 160
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 387,
				y = 168
			},
			["tower.default_rally_pos"] = {
				x = 482,
				y = 195
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 798,
				y = 142
			},
			["tower.default_rally_pos"] = {
				x = 731,
				y = 198
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12",
		},
		{
			["editor.r"] = 1.46288383797822,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 720,
				y = 706
			},
		},
		{
			["editor.r"] = -0.007246249979897152,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1110,
				y = 163
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 74,
				y = 460
			},
			["render.sprites[1].z"] = Z_DECALS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 74,
				y = 350
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
				x = 74,
				y = 408
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -188,
				y = 318
			},
			["render.sprites[1].anchor.x"] = 0,
			["render.sprites[1].anchor.y"] = 0,
			["render.sprites[1].name"] = "Stage2_chain_pc",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -20,
				y = 343
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.144,
			["render.sprites[1].name"] = "Stage2_chain",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 238,
				y = 712
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "fire_deco_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 338,
				y = 301
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.156,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage2_firepit_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 735,
				y = 288
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
				x = 606,
				y = 614
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.156,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "stage2_firepit_run",
			["render.sprites[1].animated"] = true,
			random_shift = true,
		},
		{
			template = "armadillo",
			pos = {
				x = 344,
				y = 558
			},
		},
		{
			template = "armadillo",
			pos = {
				x = 589,
				y = 430
			},
		},
		{
			template = "armadillo",
			pos = {
				x = 495,
				y = 92
			},
		},
	},
	nav_mesh = {
		{ nil, nil, 4, 10 },
		{ 1, nil, 9, 4 },
		{ 1, 4, 7, 6 },
		{ 1, 2, 7, 3 },
		{ 6, 7, 8, 11 },
		{ 10, 3, 11, nil },
		{ 3, 2, 9, 8 },
		{ 5, 9, nil, 11 },
		{ 7, nil, nil, 8 },
		{ 12, 3, 6, nil },
		{ 6, 5, nil, nil },
		{ nil, 1, 10, nil },
	},
	level_mode_overrides = {
        [3] = {
            locked_hero = false,
            locked_towers = {
            },
            max_upgrade_level = 5
        }
    },
	required_sounds = {
		"sounds_stage152",
		"enemies_terrain_6"
	},
	required_textures = {
	},
	scale_required_textures = {
		"kr4_dwarven_empire",
		"go_stage152",
	}
}