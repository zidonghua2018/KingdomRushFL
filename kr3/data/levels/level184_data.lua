return {
	level_terrain_type = 410,
	locked_hero = false,
	max_upgrade_level = 5,
	custom_start_pos = {
		zoom = 1.3,
		pos = {x = 512, y = 384}
	},
	custom_spawn_pos = {
		{
			pos = {
				x = 940,
				y = 565
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_434",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			["editor.r"] = 2.6742137186223283,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 644,
				y = 416
			},
		},
		{
			["editor.r"] = 0.43007813505586256,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 376,
				y = 422
			},
		},
		{
			["editor.r"] = -2.4149503129080676,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 146,
				y = 447
			},
		},
		{
			["editor.r"] = 0.9944211062037129,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 319,
				y = 693
			},
		},
		{
			["editor.r"] = -0.11710874456686428,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 848,
				y = 382
			},
		},
		{
			["editor.r"] = 2.3209150165987538,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 114,
				y = 220
			},
		},
		{
			["editor.r"] = 2.7004131731748124,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 144,
				y = 259
			},
		},
		{
			["editor.r"] = 3.0079404062725996,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 165,
				y = 304
			},
		},
		{
			["editor.r"] = 0.0838366420684145,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 849,
				y = 335
			},
		},
		{
			["editor.r"] = -0.5346889039760393,
			["editor.path_id"] = 10,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 359,
				y = 596
			},
		},
		{
			["editor.r"] = 1.7044485741120903,
			["editor.path_id"] = 11,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 373,
				y = 681
			},
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 940,
				y = 173
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 940,
				y = 263
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 940,
				y = 505
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 940,
				y = 615
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
				x = 940,
				y = 570
			},
		},
		{
			template = "decal_defend_point5",
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1,
			pos = {
				x = 930,
				y = 225
			},
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 506,
				y = 377
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.07,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "Stage_34_pyramid_center_mask",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 19,
				y = 210
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.07,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage34_pyramid_left_mask",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 985,
				y = 280
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.2,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage34_pyramid_right_mask",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "touch",
			pos = {
				x = 74,
				y = 574
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
	},
}