-- chunkname: @./kr3/data/levels/level82_data.lua

return {
	locked_hero = false,
	level_terrain_type = 1,
	max_upgrade_level = 5,
	entities_list = {
		{
			template = "background_sounds",
			sounds = {
				"EndlessTwilightAmbience"
			}
		},
		{
			template = "decal",
			["render.sprites[1].flip_x"] = false,
			["render.sprites[1].name"] = "",
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "decal",
			["render.sprites[1].anchor.y"] = 0.3050847457627119,
			["render.sprites[1].name"] = "decal_s82_house_fire",
			pos = {
				x = 60.75,
				y = 91.25
			}
		},
		{
			template = "decal",
			["render.sprites[1].anchor.y"] = 0.3050847457627119,
			["render.sprites[1].name"] = "decal_s82_house_fire",
			pos = {
				x = 964.5,
				y = 625.25
			}
		},
		{
			["render.sprites[1].anchor.y"] = 0.3050847457627119,
			["render.sprites[1].flip_x"] = true,
			template = "decal",
			["render.sprites[1].name"] = "decal_s82_house_fire",
			pos = {
				x = 275,
				y = 634
			}
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "Stage82_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.exit_id"] = 2,
			template = "decal_defend_point",
			pos = {
				x = 310,
				y = 70
			}
		},
		{
			["editor.exit_id"] = 3,
			template = "decal_defend_point",
			pos = {
				x = 710,
				y = 70
			}
		},
		{
			["editor.exit_id"] = 1,
			template = "decal_defend_point",
			pos = {
				x = 38,
				y = 289
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 640,
				y = 68
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 779,
				y = 68
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 244,
				y = 74
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 367,
				y = 74
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 31,
				y = 232
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 31,
				y = 334
			}
		},
		{
			["render.sprites[1].anchor.y"] = 0.28888888888888886,
			template = "decal_static",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "stage_endless_2_house",
			pos = {
				x = 438,
				y = 72
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		},
		{
			["render.sprites[1].anchor.y"] = 0.07142857142857142,
			template = "decal_static",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "stage_endless_2_wood_arrow",
			pos = {
				x = 980,
				y = 253
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18
			}
		},
		{
			["render.sprites[1].anchor.y"] = 0.15625,
			template = "decal_static",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "stage_endless_2_palitroque_",
			pos = {
				x = 730,
				y = 271
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		},
		{
			["render.sprites[1].anchor.y"] = 0.28888888888888886,
			template = "decal_static",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "stage_endless_2_house",
			pos = {
				x = 966,
				y = 402
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		},
		{
			["render.sprites[1].anchor.y"] = 0.25,
			template = "decal_static",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "stage_endless_2_bush",
			pos = {
				x = 1000,
				y = 450
			},
			["render.sprites[1].scale"] = {
				x = 1,
				y = 1
			}
		},
		{
			["render.sprites[1].anchor.y"] = 0.07142857142857142,
			["render.sprites[1].flip_x"] = true,
			template = "decal_static",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "stage_endless_2_wood_arrow",
			pos = {
				x = 973,
				y = 559
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18
			}
		},
		{
			template = "eb_ainyl",
			["render.sprites[1].flip_x"] = true,
			pos = {
				x = 618,
				y = 660
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 10,
			pos = {
				x = 486,
				y = 726.25
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 10,
			pos = {
				x = 739.5,
				y = 726.5
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 10,
			pos = {
				x = 459.5,
				y = 751.5
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 10,
			pos = {
				x = 512.5,
				y = 751.5
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 10,
			pos = {
				x = 712.5,
				y = 751.5
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 10,
			pos = {
				x = 766.5,
				y = 751.5
			}
		},
		{
			["tower.holder_id"] = "16",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "16",
			pos = {
				x = 395,
				y = 152
			},
			["tower.default_rally_pos"] = {
				x = 396,
				y = 239
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 488,
				y = 152
			},
			["tower.default_rally_pos"] = {
				x = 576,
				y = 168
			}
		},
		{
			["tower.holder_id"] = "15",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "15",
			pos = {
				x = 216,
				y = 174
			},
			["tower.default_rally_pos"] = {
				x = 308,
				y = 168
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 669,
				y = 199
			},
			["tower.default_rally_pos"] = {
				x = 671,
				y = 148
			}
		},
		{
			["tower.holder_id"] = "05",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "05",
			pos = {
				x = 779,
				y = 200
			},
			["tower.default_rally_pos"] = {
				x = 775,
				y = 149
			}
		},
		{
			["tower.holder_id"] = "17",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "17",
			pos = {
				x = 122,
				y = 216
			},
			["tower.default_rally_pos"] = {
				x = 93,
				y = 299
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "13",
			pos = {
				x = 308,
				y = 296
			},
			["tower.default_rally_pos"] = {
				x = 316,
				y = 231
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 477,
				y = 297
			},
			["tower.default_rally_pos"] = {
				x = 486,
				y = 243
			}
		},
		{
			["tower.holder_id"] = "06",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "06",
			pos = {
				x = 769,
				y = 308
			},
			["tower.default_rally_pos"] = {
				x = 874,
				y = 269
			}
		},
		{
			["tower.holder_id"] = "09",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "09",
			pos = {
				x = 666,
				y = 320
			},
			["tower.default_rally_pos"] = {
				x = 663,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "18",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "18",
			pos = {
				x = 216,
				y = 329
			},
			["tower.default_rally_pos"] = {
				x = 122,
				y = 350
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "14",
			pos = {
				x = 394,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 423,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "03",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "03",
			pos = {
				x = 843,
				y = 381
			},
			["tower.default_rally_pos"] = {
				x = 899,
				y = 327
			}
		},
		{
			["tower.holder_id"] = "19",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "19",
			pos = {
				x = 216,
				y = 428
			},
			["tower.default_rally_pos"] = {
				x = 122,
				y = 442
			}
		},
		{
			["tower.holder_id"] = "04",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "04",
			pos = {
				x = 767,
				y = 430
			},
			["tower.default_rally_pos"] = {
				x = 772,
				y = 517
			}
		},
		{
			["tower.holder_id"] = "01",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "01",
			pos = {
				x = 583,
				y = 466
			},
			["tower.default_rally_pos"] = {
				x = 590,
				y = 412
			}
		},
		{
			["tower.holder_id"] = "02",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "02",
			pos = {
				x = 395,
				y = 474
			},
			["tower.default_rally_pos"] = {
				x = 361,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "20",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "20",
			pos = {
				x = 841,
				y = 565
			},
			["tower.default_rally_pos"] = {
				x = 836,
				y = 519
			}
		},
		{
			["tower.holder_id"] = "07",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "07",
			pos = {
				x = 385,
				y = 571
			},
			["tower.default_rally_pos"] = {
				x = 489,
				y = 587
			}
		},
		{
			["tower.holder_id"] = "08",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "08",
			pos = {
				x = 279,
				y = 572
			},
			["tower.default_rally_pos"] = {
				x = 270,
				y = 517
			}
		}
	},
	invalid_path_ranges = {},
	level_mode_overrides = {
		{
			max_upgrade_level = 5,
			locked_towers = {}
		},
		{
			max_upgrade_level = 5,
			locked_towers = {}
		},
		{
			max_upgrade_level = 5,
			locked_towers = {}
		},
		{
			max_upgrade_level = 5,
			locked_towers = {}
		}
	},
	nav_mesh = {
		{
			4,
			nil,
			2,
			9
		},
		{
			1,
			7,
			19,
			14
		},
		{
			nil,
			20,
			4,
			6
		},
		{
			3,
			20,
			1,
			6
		},
		{
			nil,
			6,
			10
		},
		{
			3,
			4,
			9,
			5
		},
		{
			20,
			nil,
			8,
			2
		},
		{
			7,
			nil,
			nil,
			19
		},
		{
			6,
			4,
			11,
			10
		},
		{
			5,
			9,
			12
		},
		{
			9,
			2,
			14,
			12
		},
		{
			10,
			11,
			16
		},
		{
			14,
			19,
			18,
			15
		},
		{
			11,
			2,
			13,
			16
		},
		{
			16,
			13,
			17
		},
		{
			12,
			14,
			15
		},
		{
			15,
			18
		},
		{
			13,
			19,
			nil,
			17
		},
		{
			2,
			8,
			nil,
			18
		},
		{
			nil,
			nil,
			7,
			4
		}
	},
	pan_extension = {
		bottom = -40,
		top = 40
	},
	required_sounds = {
		"music_stage82",
		"ElvenWoodsAmbienceSounds",
		"EndlessTwilightSounds",
		"ElvesScourger",
		"ElvesCreepAvenger",
		"ElvesCreepGolem",
		"ElvesCreepEvoker",
		"ElvesCreepScreecher",
		"ElvesCreepServant"
	},
	required_textures = {
		"go_stage82",
		"go_stage82_bg",
		"go_stages_elven_woods",
		"go_enemies_ancient_metropolis",
		"go_enemies_bittering_rancor",
	}
}
