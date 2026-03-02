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
				x = 683,
				y = 70
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_410",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 406,
				y = 408
			},
			["tower.default_rally_pos"] = {
				x = 316,
				y = 385
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 230,
				y = 465
			},
			["tower.default_rally_pos"] = {
				x = 310,
				y = 531
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 412,
				y = 296
			},
			["tower.default_rally_pos"] = {
				x = 317,
				y = 282
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 222,
				y = 287
			},
			["tower.default_rally_pos"] = {
				x = 247,
				y = 221
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 727,
				y = 465
			},
			["tower.default_rally_pos"] = {
				x = 622,
				y = 443
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 551,
				y = 535
			},
			["tower.default_rally_pos"] = {
				x = 642,
				y = 520
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 400,
				y = 555
			},
			["tower.default_rally_pos"] = {
				x = 327,
				y = 467
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 295,
				y = 610
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 565
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 543,
				y = 363
			},
			["tower.default_rally_pos"] = {
				x = 650,
				y = 366
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 765,
				y = 380
			},
			["tower.default_rally_pos"] = {
				x = 748,
				y = 322
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 793,
				y = 213
			},
			["tower.default_rally_pos"] = {
				x = 695,
				y = 184
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 926,
				y = 264
			},
			["tower.default_rally_pos"] = {
				x = 880,
				y = 362
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 610,
				y = 253
			},
			["tower.default_rally_pos"] = {
				x = 705,
				y = 254
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13",
		},
		{
			["editor.r"] = -2.9441970937399127,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 199,
				y = 604
			},
		},
		{
			["editor.r"] = 0.5244092235441183,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 814,
				y = 627
			},
		},
		{
			["editor.r"] = -0.18061861058426748,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1142,
				y = 438
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 60,
				y = 270
			},
			["render.sprites[1].z"] = Z_DECALS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 60,
				y = 134
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
				x = 60,
				y = 205
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 610,
				y = 73
			},
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 754,
				y = 73
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
				x = 683,
				y = 70
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 463,
				y = 104
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.251,
			["render.sprites[1].name"] = "Stage_10_mask_2",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 901,
				y = 562
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.068,
			["render.sprites[1].name"] = "Stage_10_mask_1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 33,
				y = 472
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.0,
			["render.sprites[1].name"] = "Stage_10_mask_0",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 921,
				y = 580
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.074,
			["render.sprites[1].name"] = "Stage10_mask1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 113,
				y = 497
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.15,
			["render.sprites[1].name"] = "Stage10_mask_bones",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 815,
				y = 543
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.07,
			["render.sprites[1].name"] = "Stage10_cuernos_1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 815,
				y = 550
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.204,
			["render.sprites[1].name"] = "Stage10_cuernos_2",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 815,
				y = 568
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.488,
			["render.sprites[1].name"] = "Stage10_cuernos_3",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 494,
				y = 111
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0,
			["render.sprites[1].name"] = "Stage10_mask_drogon",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "boneheart_bone",
			pos = {
				x = 824,
				y = 444
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "boneheart_bone",
			pos = {
				x = 526,
				y = 320
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "boneheart_bone",
			pos = {
				x = 875,
				y = 246
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "boneheart_bone",
			pos = {
				x = 223,
				y = 395
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "boneheart_bone",
			pos = {
				x = 456,
				y = 566
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "boneheart_bone",
			pos = {
				x = 510,
				y = 577
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
	},
	nav_mesh = {
		{ 9, 7, 2, 3 },
		{ 1, 8, nil, 4 },
		{ 9, 1, 4, nil },
		{ 3, 2, nil, nil },
		{ nil, nil, 6, 10 },
		{ 5, nil, 7, 9 },
		{ 6, nil, 8, 1 },
		{ 7, nil, nil, 2 },
		{ 5, 6, 1, 13 },
		{ 12, 5, 13, 11 },
		{ 12, 10, 13, nil },
		{ nil, 5, 11, nil },
		{ 11, 9, 3, nil },
	}
}