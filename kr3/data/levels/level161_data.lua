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
				x = 721,
				y = 39
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_411",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 275,
				y = 174
			},
			["tower.default_rally_pos"] = {
				x = 350,
				y = 233
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 286,
				y = 332
			},
			["tower.default_rally_pos"] = {
				x = 203,
				y = 302
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 554,
				y = 287
			},
			["tower.default_rally_pos"] = {
				x = 582,
				y = 227
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 433,
				y = 285
			},
			["tower.default_rally_pos"] = {
				x = 464,
				y = 227
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 600,
				y = 125
			},
			["tower.default_rally_pos"] = {
				x = 698,
				y = 150
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 482,
				y = 125
			},
			["tower.default_rally_pos"] = {
				x = 380,
				y = 140
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 137,
				y = 426
			},
			["tower.default_rally_pos"] = {
				x = 224,
				y = 417
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 243,
				y = 559
			},
			["tower.default_rally_pos"] = {
				x = 186,
				y = 507
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 660,
				y = 355
			},
			["tower.default_rally_pos"] = {
				x = 737,
				y = 327
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 755,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 665,
				y = 271
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 401,
			pos = {
				x = 784,
				y = 545
			},
			["tower.default_rally_pos"] = {
				x = 866,
				y = 529
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 752,
				y = 466
			},
			["tower.default_rally_pos"] = {
				x = 827,
				y = 428
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12",
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 401,
			pos = {
				x = 844,
				y = 335
			},
			["tower.default_rally_pos"] = {
				x = 776,
				y = 404
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13",
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 308,
				y = 23
			},
			["render.sprites[1].z"] = Z_DECALS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 445,
				y = 23
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
				x = 378,
				y = 39
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 654,
				y = 23
			},
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 796,
				y = 23
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
				x = 721,
				y = 39
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 483,
				y = 300
			},
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "dragon_camouflage_mask",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 66,
				y = 319
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0,
			["render.sprites[1].z"] = Z_DECALS,
			["render.sprites[1].name"] = "Stage_11_old_mask_0003",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 40,
				y = 517
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "Stage_11_CaveMask1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 23,
				y = 512
			},
			["render.sprites[1].anchor.x"] = 0.565,
			["render.sprites[1].anchor.y"] = 0.074,
			["render.sprites[1].name"] = "Stage_11_mask_0",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 67,
				y = 273
			},
			["render.sprites[1].anchor.x"] = 0.508,
			["render.sprites[1].anchor.y"] = 0.003,
			["render.sprites[1].name"] = "Stage_11_mask_1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 730,
				y = 610
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.048,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "Stage_11_CaveMask2",
			["render.sprites[1].animated"] = false,
		},
	},
	nav_mesh = {
		{ 4, 2, nil, nil },
		{ 4, 8, 7, 1 },
		{ 9, 11, 4, 5 },
		{ 3, 8, 2, 6 },
		{ 10, 3, 6, nil },
		{ 5, 4, 1, nil },
		{ 2, 8, nil, 1 },
		{ 3, nil, nil, 7 },
		{ 13, 12, 3, 10 },
		{ nil, 13, 5, nil },
		{ nil, nil, 4, 12 },
		{ nil, 11, 3, 9 },
		{ nil, 12, 9, 10 },
	}
}