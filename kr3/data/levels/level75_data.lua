return {
	locked_hero = false,
	level_terrain_type = 1,
	max_upgrade_level = 5,
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_31",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.exit_id"] = 1,
			template = "decal_defend_point",
			pos = {
				x = 0,
				y = 545
			}
		},
		{
			["editor.exit_id"] = 2,
			template = "decal_defend_point",
			pos = {
				x = 0,
				y = 265
			}
		},
		{
			["editor.exit_id"] = 3,
			template = "decal_defend_point",
			pos = {
				x = 315,
				y = 80
			}
		},
		{
			["editor.r"] = 0.017453292519903,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 794,
				y = 400
			}
		},
		{
			["editor.r"] = 0.017453292519903,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 794,
				y = 500
			}
		},
		{
			["editor.r"] = 1.5882496193148,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 300,
				y = 737
			}
		},
		{
			["editor.r"] = 1.5882496193148,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 310,
				y = 737
			}
		},
		{
			["editor.r"] = 1.5882496193148,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 370,
				y = 737
			}
		},
		{
			["editor.r"] = 0.017453292519903,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 250,
			pos = {
				x = 794,
				y = 450
			}
		},
		{
			["render.sprites[1].z"] = 3000,
			template = "decal_spikewall_bl",
			["render.sprites[1].r"] = 0,
			pos = {
				x = 95,
				y = 130
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		},
		{
			["render.sprites[1].z"] = 3500,
			template = "decal_cavewall_bl",
			["render.sprites[1].r"] = 0,
			pos = {
				x = 1116,
				y = 433
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 1,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 70,
				y = 600
			},
			["tower.default_rally_pos"] = {
				x = 50,
				y = 540
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 350,
				y = 630
			},
			["tower.default_rally_pos"] = {
				x = 310,
				y = 550
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 565,
				y = 635
			},
			["tower.default_rally_pos"] = {
				x = 475,
				y = 590
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 815,
				y = 490
			},
			["tower.default_rally_pos"] = {
				x = 740,
				y = 450
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 480,
				y = 490
			},
			["tower.default_rally_pos"] = {
				x = 475,
				y = 590
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 420,
				y = 410
			},
			["tower.default_rally_pos"] = {
				x = 345,
				y = 455
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 1,
			template = "tower_holder_grass",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 630,
				y = 430
			},
			["tower.default_rally_pos"] = {
				x = 550,
				y = 360
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 210,
				y = 460
			},
			["tower.default_rally_pos"] = {
				x = 315,
				y = 460
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 185,
				y = 345
			},
			["tower.default_rally_pos"] = {
				x = 170,
				y = 280
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 380,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 320,
				y = 370
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 430,
				y = 190
			},
			["tower.default_rally_pos"] = {
				x = 350,
				y = 130
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 560,
				y = 265
			},
			["tower.default_rally_pos"] = {
				x = 550,
				y = 170
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 725,
				y = 270
			},
			["tower.default_rally_pos"] = {
				x = 750,
				y = 205
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 785,
				y = 370
			},
			["tower.default_rally_pos"] = {
				x = 860,
				y = 425
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 190,
				y = 155
			},
			["tower.default_rally_pos"] = {
				x = 295,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 645,
				y = 105
			},
			["tower.default_rally_pos"] = {
				x = 650,
				y = 200
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 4,
			template = "tower_holder_desert",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 950,
				y = 335
			},
			["tower.default_rally_pos"] = {
				x = 940,
				y = 425
			}
		}
	},
	invalid_path_ranges = {},
	level_mode_overrides = {
		[3] = {
			max_upgrade_level = 5,
			locked_hero = false,
			locked_towers = {
				"tower_build_tree_archer",
				"tower_build_elven_barrack",
				"tower_build_archer_krf",
				"tower_build_barrack_krf",
				"tower_build_archer",
				"tower_build_barrack"
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
		"music_stage75",
		"VeznanEffects",
		"VeznanAttack",
		"VeznanPortalSummon",
		"ElvesHeroVeznanArcaneNova"
	},
	required_textures = {
		"go_enemies_acaroth",
		"go_enemies_grass",
		"go_stage75_bg",
		"go_stage75",
		"go_stage85",
		"go_stage56",
		"go_stage66",
		"go_stage50",
		"go_hero_dracolich",
		"go_hero_giant",
		"go_stages_grass",
		"go_enemies_bloodlust",
		"go_stage56",
		
	}
}
