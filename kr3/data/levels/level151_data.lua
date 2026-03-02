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
				x = 57,
				y = 343
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_151",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 518,
				y = 156
			},
			["tower.default_rally_pos"] = {
				x = 504,
				y = 235
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 350,
				y = 189
			},
			["tower.default_rally_pos"] = {
				x = 423,
				y = 240
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 728,
				y = 208
			},
			["tower.default_rally_pos"] = {
				x = 654,
				y = 268
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 560,
				y = 286
			},
			["tower.default_rally_pos"] = {
				x = 589,
				y = 235
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 161,
				y = 253
			},
			["tower.default_rally_pos"] = {
				x = 184,
				y = 337
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 136,
				y = 395
			},
			["tower.default_rally_pos"] = {
				x = 105,
				y = 337
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 290,
				y = 305
			},
			["tower.default_rally_pos"] = {
				x = 254,
				y = 377
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 18,
			pos = {
				x = 478,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 383,
				y = 299
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8",
		},
		{
			["editor.r"] = 0.9660976866767411,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 868,
				y = 491
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 57,
				y = 285
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 57,
				y = 393
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
				x = 57,
				y = 343
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 859,
				y = 487
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.232,
			["render.sprites[1].name"] = "Stage1_PortalShadow",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 605,
				y = 390
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.196,
			["render.sprites[1].name"] = "Stage1_firepit",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 802,
				y = 301
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.196,
			["render.sprites[1].name"] = "Stage1_firepit",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 871,
				y = 261
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.2,
			["render.sprites[1].name"] = "Stage1_statue",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "bilbo",
			pos = {
				x = 598,
				y = 607
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 295,
				y = 639
			},
			["render.sprites[1].name"] = "stage_1_sky",
			["render.sprites[1].animated"] = false,
			["render.sprites[1].z"] = 998,
		},
		{
			template = "moving_cloud",
			pos = {
				x = -481,
				y = 649
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "moving_cloud",
			pos = {
				x = 37,
				y = 732
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "moving_cloud",
			pos = {
				x = 3,
				y = 582
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "moving_cloud",
			pos = {
				x = 364,
				y = 649
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "moving_cloud",
			pos = {
				x = 765,
				y = 582
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "condor",
			pos = {
				x = -50,
				y = 250
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "condor",
			pos = {
				x = 254,
				y = 800
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "condor",
			pos = {
				x = 1050.0,
				y = 290
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
	},
	level_mode_overrides = {
        [3] = {
            locked_hero = false,
            locked_towers = {
            },
            max_upgrade_level = 5
        }
    },
	nav_mesh = {
		{ 3, 4, 2, nil },
		{ 8, 7, 5, nil },
		{ nil, nil, 4, nil },
		{ 3, nil, 8, 1 },
		{ 7, 6, nil, nil },
		{ 7, nil, nil, 5 },
		{ 8, nil, 5, 2 },
		{ 4, nil, 2, 1 },
	},
	required_sounds = {
		"sounds_stage151",
		"enemies_terrain_6"
	},
	required_textures = {
	},
	scale_required_textures = {
		"kr4_dwarven_empire",
		"go_stage151",
	}
}