return {
	level_terrain_type = 409,
	locked_hero = false,
	max_upgrade_level = 5,
	custom_start_pos = {
		zoom = 1.3,
		pos = {x = 512, y = 384}
	},
	custom_spawn_pos = {
		{
			pos = {
				x = 73,
				y = 297
			}
		},
	},
	entities_list = {
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_430",
			pos = {
				x = 512,
				y = 384
			},
		},
		{
			["editor.r"] = 0.0,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1129,
				y = 279
			},
		},
		{
			["editor.r"] = -0.016665123713940747,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1129,
				y = 332
			},
		},
		{
			["editor.r"] = -0.008333140440135918,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 902,
				y = 462
			},
		},
		{
			["editor.r"] = 1.5625320521352455,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 346,
				y = 666
			},
		},
		{
			template = "touch",
			pos = {
				x = -15,
				y = 140
			},
			["render.sprites[1].z"] = Z_DECALS,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 367,
				y = 649
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.15,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage30_cave1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 685.75,
				y = -57
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage30_cave2",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 25,
				y = 412
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.2,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage30_tunel1",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 991,
				y = 421
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.25,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage30_tunel2",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 367,
				y = 649
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.15,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "stage30_cave1_pc",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -47,
				y = 427
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.2,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "Stage30_tunel1_pc",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = 1052,
				y = 405
			},
			["render.sprites[1].anchor.x"] = 0.5,
			["render.sprites[1].anchor.y"] = 0.2,
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].name"] = "Stage30_tunel2_pc",
			["render.sprites[1].animated"] = false,
		},
		{
			template = "touch",
			pos = {
				x = 59,
				y = 629
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "touch",
			pos = {
				x = 466,
				y = 714
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "touch",
			pos = {
				x = 779,
				y = 724
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "touch",
			pos = {
				x = 926,
				y = 606
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "touch",
			pos = {
				x = 687,
				y = 135
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 94,
				y = 395
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 120,
				y = 522
			},
			["render.sprites[1].z"] = Z_DECALS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 58,
				y = 232
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0,
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 84,
				y = 354
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
				x = 73,
				y = 297
			},
		},
		{
			template = "decal_defend_point5",
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1,
			pos = {
				x = 110,
				y = 467
			},
		},
		{
			template = "miner",
			pos = {
				x = 768,
				y = 628
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "miner",
			pos = {
				x = 668,
				y = 589
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "multiple_loop",
			pos = {
				x = 182,
				y = 660
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "multiple_loop",
			pos = {
				x = 143,
				y = 742
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "multiple_loop",
			pos = {
				x = 429,
				y = 717
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "multiple_loop",
			pos = {
				x = 582,
				y = 718
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "multiple_loop",
			pos = {
				x = 749,
				y = 674
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "multiple_loop",
			pos = {
				x = 885,
				y = 707
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
		{
			template = "multiple_loop",
			pos = {
				x = 27,
				y = 98
			},
			["render.sprites[1].z"] = Z_OBJECTS,
		},
	},
}