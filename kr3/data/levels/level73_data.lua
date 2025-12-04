return {
	locked_hero = false,
	level_terrain_type = 1,
	max_upgrade_level = 5,
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_29",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.exit_id"] = 1,
			template = "decal_defend_point",
			pos = {
				x = 325,
				y = 730
			}
		},
		{
			["editor.exit_id"] = 2,
			template = "decal_defend_point",
			pos = {
				x = -121,
				y = 590
			}
		},
		{
			["editor.exit_id"] = 3,
			template = "decal_defend_point",
			pos = {
				x = -121,
				y = 200
			}
		},
		{
			["editor.r"] = 0.017453292519903,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 974,
				y = 550
			}
		},
		{
			["editor.r"] = 0.017453292519903,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 974,
				y = 225
			}
		},
		{
			["editor.r"] = 0.017453292519903,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 974,
				y = 275
			}
		},
		{
			["editor.r"] = 0.017453292519903,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 974,
				y = 500
			}
		},
		{
			["render.sprites[1].z"] = 3000,
			template = "decal_fish",
			["render.sprites[1].r"] = 0,
			pos = {
				x = 485,
				y = 405
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 495,
				y = 402
			},
			["render.sprites[1].scale"] = {
				x = 0.4,
				y = 0.4
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 490,
				y = 486
			},
			["render.sprites[1].scale"] = {
				x = 0.3,
				y = 0.3
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 360,
				y = 41
			},
			["render.sprites[1].scale"] = {
				x = 0.2,
				y = 0.2
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 460,
				y = 63
			},
			["render.sprites[1].scale"] = {
				x = 0.2,
				y = 0.2
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 655,
				y = 62
			},
			["render.sprites[1].scale"] = {
				x = 0.2,
				y = 0.2
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = -120,
				y = 708
			},
			["render.sprites[1].scale"] = {
				x = 0.2,
				y = 0.2
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 625,
				y = 735
			},
			["render.sprites[1].scale"] = {
				x = 0.2,
				y = 0.2
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 455,
				y = 415
			},
			["render.sprites[1].scale"] = {
				x = 0.5,
				y = 0.5
			}
		},
		{
			["render.sprites[1].z"] = 2000,
			template = "decal_water_spark",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_spark_play",
			pos = {
				x = 520,
				y = 410
			},
			["render.sprites[1].scale"] = {
				x = 0.5,
				y = 0.5
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 80,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 200,
				y = 450
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 55,
				y = 304
			},
			["tower.default_rally_pos"] = {
				x = 200,
				y = 275
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 55,
				y = 304
			},
			["tower.default_rally_pos"] = {
				x = 200,
				y = 275
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_time_wizard",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 55,
				y = 304
			},
			["tower.default_rally_pos"] = {
				x = 200,
				y = 275
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 175,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 250,
				y = 500
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 175,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 250,
				y = 500
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 1,
			template = "tower_time_wizard",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 175,
				y = 544
			},
			["tower.default_rally_pos"] = {
				x = 250,
				y = 500
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 260,
				y = 594
			},
			["tower.default_rally_pos"] = {
				x = 360,
				y = 600
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 480,
				y = 634
			},
			["tower.default_rally_pos"] = {
				x = 500,
				y = 560
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 685,
				y = 604
			},
			["tower.default_rally_pos"] = {
				x = 700,
				y = 550
			}
		},
		{
			["tower.holder_id"] = "7",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "7",
			pos = {
				x = 215,
				y = 174
			},
			["tower.default_rally_pos"] = {
				x = 215,
				y = 250
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 400,
				y = 122
			},
			["tower.default_rally_pos"] = {
				x = 440,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 810,
				y = 182
			},
			["tower.default_rally_pos"] = {
				x = 710,
				y = 260
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 1,
			template = "tower_time_wizard",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 315,
				y = 399
			},
			["tower.default_rally_pos"] = {
				x = 220,
				y = 420
			}
		},
		
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 2,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 315,
				y = 399
			},
			["tower.default_rally_pos"] = {
				x = 220,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 3,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 315,
				y = 399
			},
			["tower.default_rally_pos"] = {
				x = 220,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 575,
				y = 474
			},
			["tower.default_rally_pos"] = {
				x = 600,
				y = 570
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 9,
			template = "tower_holder_lozagon",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 745,
				y = 444
			},
			["tower.default_rally_pos"] = {
				x = 750,
				y = 540
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 655,
				y = 299
			},
			["tower.default_rally_pos"] = {
				x = 700,
				y = 250
			}
		},
		{
			["tower.holder_id"] = "15",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "15",
			pos = {
				x = 485,
				y = 259
			},
			["tower.default_rally_pos"] = {
				x = 500,
				y = 200
			}
		},
		{
			["render.sprites[1].z"] = 3000,
			template = "decal_water_fall",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_fall_idle",
			pos = {
				x = 490,
				y = 456
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		}
	},
	invalid_path_ranges = {},
	level_mode_overrides = {
		[3] = {
			max_upgrade_level = 5,
			locked_hero = false,
			locked_towers = {
				"tower_build_mage",
				"tower_build_barrack",
				"tower_build_engineer",
				"tower_build_engineer_krf",
				"tower_build_barrack_krf",
				"tower_build_mage_krf",
				"tower_goblirang",
				"tower_build_elven_barrack",
				"tower_build_eldritch_mage",
				"tower_build_rock_thrower"
			}
		}
	},
	nav_mesh = {
		{
			4,
			6,
			5
		},
		{
			3,
			7,
			4,
			1
		},
		{
			nil,
			8,
			2,
			1
		},
		{
			2,
			7,
			6,
			1
		},
		{
			6,
			10,
			9,
			1
		},
		{
			4,
			10,
			5,
			1
		},
		{
			8,
			13,
			10,
			4
		},
		{
			nil,
			12,
			7,
			3
		},
		{
			10,
			15,
			nil,
			5
		},
		{
			7,
			11,
			9,
			6
		},
		{
			14,
			16,
			15,
			10
		},
		{
			[3.0] = 13,
			[4.0] = 8
		},
		{
			12,
			nil,
			14,
			7
		},
		{
			13,
			nil,
			16,
			11
		},
		{
			16,
			nil,
			nil,
			9
		},
		{
			14,
			nil,
			15,
			11
		}
	},
	required_sounds = {
		"music_stage73"
	},
	required_textures = {
		"go_enemies_acaroth",
		"go_enemies_grass",
		"go_stage73_bg",
		"go_stage73",
		"go_stages_grass",
		"go_enemies_bloodlust"
		
	}
}
