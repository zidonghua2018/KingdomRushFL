return {
	level_terrain_type = 14,
	locked_hero = false,
	max_upgrade_level = 5,
	custom_start_pos = {
		zoom = 1.3,
		pos = {x = 512, y = 384}
	},
	custom_spawn_pos = {
		{
			pos = {
				x = -250,
				y = 284
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_150",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 14,
			pos = {
				x = 396,
				y = 199
			},
			["tower.default_rally_pos"] = {
				x = 386,
				y = 290
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 14,
			pos = {
				x = 337,
				y = 355
			},
			["tower.default_rally_pos"] = {
				x = 320,
				y = 448
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 14,
			pos = {
				x = 590,
				y = 199
			},
			["tower.default_rally_pos"] = {
				x = 585,
				y = 296
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 14,
			pos = {
				x = 494,
				y = 199
			},
			["tower.default_rally_pos"] = {
				x = 486,
				y = 290
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 14,
			pos = {
				x = 691,
				y = 199
			},
			["tower.default_rally_pos"] = {
				x = 606,
				y = 302
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 14,
			pos = {
				x = 430,
				y = 355
			},
			["tower.default_rally_pos"] = {
				x = 429,
				y = 448
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6",
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 14,
			pos = {
				x = 527,
				y = 355
			},
			["tower.default_rally_pos"] = {
				x = 541,
				y = 448
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7",
		},
		{
			["editor.r"] = -0.01694752980640491,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 316,
				y = 608
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 58,
				y = 327
			},
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 58,
				y = 229
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
				x = 58,
				y = 284
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 352,
				y = 554
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.294,
			["render.sprites[1].name"] = "Stage_106_door",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 279,
				y = 183
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.173,
			["render.sprites[1].name"] = "Stage_106_signal",
			["render.sprites[1].animated"] = false,
		},
		--fade_loop为光照效果
		{
			template = "fade_loop",
			pos = {
				x = 421,
				y = 746
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 618,
				y = 662
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 430,
				y = 618
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 612,
				y = 741
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 438,
				y = 703
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 613,
				y = 566
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 402,
				y = 603
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 596,
				y = 703
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 408,
				y = 556
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 624,
				y = 619
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 412,
				y = 666
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 944,
				y = 753
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 937,
				y = 737
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 933,
				y = 731
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 933,
				y = 725
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 921,
				y = 719
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 987,
				y = 746
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 993,
				y = 739
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 978,
				y = 716
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 1019.0,
				y = 703
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 985,
				y = 627
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 989,
				y = 619
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 993,
				y = 329
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 1001,
				y = 324
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 1009,
				y = 322
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 1015,
				y = 315
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 924,
				y = 277
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 916,
				y = 204
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 925,
				y = 214
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 955,
				y = 195
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 968,
				y = 191
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 983,
				y = 216
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 991,
				y = 212
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 1007.0,
				y = 165
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 1010.0,
				y = 152
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "fade_loop",
			pos = {
				x = 1009.0,
				y = 144
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
	invalid_path_ranges = {},
	nav_mesh = {
		{ 4, 6, nil, nil },
		{ 6, nil, nil, 1 },
		{ 5, 7, 4, nil },
		{ 3, 7, 1, nil },
		{ nil, nil, 3, nil },
		{ 7, nil, 2, 1 },
		{ 5, nil, 6, 4 },
	},
	required_sounds = {
		"sounds_stage150",
		"enemies_terrain_6"
	},
	required_textures = {
	},
	scale_required_textures = {
		"kr4_humans",
		"go_stage150",
	}
}