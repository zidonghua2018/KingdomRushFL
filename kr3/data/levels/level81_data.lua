-- chunkname: @./kr3/data/levels/level81_data.lua

return {
	locked_hero = false,
	level_terrain_type = 1,
	max_upgrade_level = 5,
	entities_list = {
		{
			template = "background_sounds",
			sounds = {
				"EndlessAmbience"
			}
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "Stage81_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["render.sprites[1].sort_y"] = 200,
			template = "decal_background",
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "Stage81_0003",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].sort_y"] = 350,
			template = "decal_background",
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "Stage81_0004",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].sort_y"] = 84,
			template = "decal_background",
			["render.sprites[1].z"] = 3000,
			["render.sprites[1].name"] = "Stage81_0002",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_catapult_endless",
			x_inside = 955,
			pos = {
				x = 1295.05,
				y = 250
			}
		},
		{
			template = "decal_catapult_endless",
			x_inside = 955,
			pos = {
				x = 1295.25,
				y = 306
			}
		},
		{
			["editor.exit_id"] = 3,
			template = "decal_defend_point",
			pos = {
				x = 355,
				y = 76
			}
		},
		{
			["editor.exit_id"] = 2,
			template = "decal_defend_point",
			pos = {
				x = 55,
				y = 189
			}
		},
		{
			["editor.exit_id"] = 1,
			template = "decal_defend_point",
			pos = {
				x = 55,
				y = 393
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 296,
				y = 53
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 422,
				y = 53
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 27,
				y = 118
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 27,
				y = 250
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 26,
				y = 317
			}
		},
		{
			["editor.tag"] = 0,
			template = "decal_defense_flag",
			pos = {
				x = 26,
				y = 449
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 352,
				y = 370.25
			},
			["render.sprites[1].animation"] = {
				to = 36,
				prefix = "stage_endless_1_waterfall_9",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 508.25,
				y = 382.75
			},
			["render.sprites[1].animation"] = {
				to = 15,
				prefix = "stage_endless_1_waterfall_2_layer1",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 507,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_1_layer5",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 508,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 12,
				prefix = "stage_endless_1_waterfall_3_layer2",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_1_layer3",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 33,
				prefix = "stage_endless_1_waterfall_5",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 12,
				prefix = "stage_endless_1_waterfall_3_layer4",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 15,
				prefix = "stage_endless_1_waterfall_6_layer1",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 36,
				prefix = "stage_endless_1_waterfall_7",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 15,
				prefix = "stage_endless_1_waterfall_2_layer3",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 12,
				prefix = "stage_endless_1_waterfall_3_layer3",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 15,
				prefix = "stage_endless_1_waterfall_6_layer2",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 15,
				prefix = "stage_endless_1_waterfall_6_layer3",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 12,
				prefix = "stage_endless_1_waterfall_3_layer5",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_1_layer1",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_1_layer4",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 36,
				prefix = "stage_endless_1_waterfall_9",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 42,
				prefix = "stage_endless_1_waterfall_8",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_1_layer6",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_1_layer2",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_4_layer1",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_4_layer3",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 512,
				y = 384
			},
			["render.sprites[1].animation"] = {
				to = 9,
				prefix = "stage_endless_1_waterfall_4_layer2",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 507,
				y = 385
			},
			["render.sprites[1].animation"] = {
				to = 12,
				prefix = "stage_endless_1_waterfall_3_layer1",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["render.sprites[1].r"] = 0,
			template = "decal_loop",
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "idle",
			pos = {
				x = 513,
				y = 388
			},
			["render.sprites[1].animation"] = {
				to = 15,
				prefix = "stage_endless_1_waterfall_2_layer2",
				from = 1
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_stage81_burner",
			pos = {
				x = 1004,
				y = 583
			}
		},
		{
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 377,
				y = 685
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["editor.device_profile"] = 3,
			["render.sprites[1].flip_x"] = true,
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 270,
				y = 698
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["editor.device_profile"] = 3,
			["render.sprites[1].flip_x"] = true,
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 499,
				y = 701
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 583,
				y = 704
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 389,
				y = 712
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["editor.device_profile"] = 3,
			["render.sprites[1].flip_x"] = true,
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 270,
				y = 716
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["editor.device_profile"] = 3,
			["render.sprites[1].flip_x"] = true,
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 482,
				y = 716
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["editor.device_profile"] = 3,
			["render.sprites[1].flip_x"] = true,
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 144.5,
				y = 719
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 174,
				y = 724
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["editor.device_profile"] = 3,
			["render.sprites[1].flip_x"] = true,
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 472,
				y = 726
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 588,
				y = 727
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			["editor.device_profile"] = 3,
			["render.sprites[1].flip_x"] = true,
			template = "decal_water_splash",
			["render.sprites[1].r"] = 0,
			["render.sprites[1].name"] = "decal_water_splash_play",
			pos = {
				x = 118,
				y = 733
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_wave_3",
			["render.sprites[1].r"] = -2.6005405854716,
			["render.sprites[1].name"] = "decal_water_wave_3_play",
			pos = {
				x = -78,
				y = 601.5
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_wave_3",
			["render.sprites[1].r"] = -2.600540585471551,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_wave_3_play",
			pos = {
				x = 80,
				y = 622
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_wave_3",
			["render.sprites[1].r"] = -0.19198621771938,
			["render.sprites[1].name"] = "decal_water_wave_3_play",
			pos = {
				x = -130.5,
				y = 640.25
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_wave_3",
			["render.sprites[1].r"] = -5.8841820305133e-15,
			["render.sprites[1].name"] = "decal_water_wave_3_play",
			pos = {
				x = -185.5,
				y = 641.5
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_wave_3",
			["render.sprites[1].r"] = -0.19198621771937624,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_wave_3_play",
			pos = {
				x = 37,
				y = 654
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "decal_water_wave_3",
			["render.sprites[1].r"] = -0.06981317007977318,
			["editor.device_profile"] = 3,
			["render.sprites[1].name"] = "decal_water_wave_3_play",
			pos = {
				x = 374,
				y = 806
			},
			["render.sprites[1].scale"] = {
				x = 1.18,
				y = 1.18,
			}
		},
		{
			template = "eb_hee_haw",
			pos = {
				x = 939,
				y = 544
			}
		},
		{
			["editor.r"] = 3.3861802251067e-15,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 240,
			pos = {
				x = 983.25,
				y = 155.25
			}
		},
		{
			["editor.r"] = 3.3861802251067e-15,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 240,
			pos = {
				x = 983.25,
				y = 195.25
			}
		},
		{
			["editor.r"] = 3.3861802251067e-15,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 240,
			pos = {
				x = 983.25,
				y = 405.25
			}
		},
		{
			["editor.r"] = 3.3861802251067e-15,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 240,
			pos = {
				x = 983.25,
				y = 445.25
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 20,
			pos = {
				x = 712,
				y = 744
			}
		},
		{
			["editor.r"] = 1.5707963267949,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 20,
			pos = {
				x = 752,
				y = 744
			}
		},
		{
			template = "plant_magic_blossom",
			pos = {
				x = 728,
				y = 67
			}
		},
		{
			template = "plant_magic_blossom",
			pos = {
				x = 447,
				y = 103
			}
		},
		{
			template = "plant_magic_blossom",
			pos = {
				x = 158,
				y = 117
			}
		},
		{
			template = "plant_magic_blossom",
			pos = {
				x = 79,
				y = 320
			}
		},
		{
			template = "plant_magic_blossom",
			pos = {
				x = 654,
				y = 403
			}
		},
		{
			template = "plant_magic_blossom",
			pos = {
				x = 181,
				y = 549
			}
		},
		{
			["tower.holder_id"] = "09",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 801,
				y = 118
			},
			["tower.default_rally_pos"] = {
				x = 709,
				y = 147
			}
		},
		{
			["tower.holder_id"] = "20",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 282,
				y = 159
			},
			["tower.default_rally_pos"] = {
				x = 348,
				y = 226
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 628,
				y = 167
			},
			["tower.default_rally_pos"] = {
				x = 624,
				y = 120
			}
		},
		{
			["tower.holder_id"] = "14",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 448,
				y = 188
			},
			["tower.default_rally_pos"] = {
				x = 366,
				y = 171
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 719,
				y = 246
			},
			["tower.default_rally_pos"] = {
				x = 743,
				y = 190
			}
		},
		{
			["tower.holder_id"] = "18",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 137,
				y = 252
			},
			["tower.default_rally_pos"] = {
				x = 147,
				y = 197
			}
		},
		{
			["tower.holder_id"] = "13",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 436,
				y = 279
			},
			["tower.default_rally_pos"] = {
				x = 426,
				y = 356
			}
		},
		{
			["tower.holder_id"] = "19",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 240,
				y = 282
			},
			["tower.default_rally_pos"] = {
				x = 256,
				y = 236
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 623,
				y = 289
			},
			["tower.default_rally_pos"] = {
				x = 529,
				y = 312
			}
		},
		{
			["tower.holder_id"] = "17",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 161,
				y = 342
			},
			["tower.default_rally_pos"] = {
				x = 254,
				y = 375
			}
		},
		{
			["tower.holder_id"] = "05",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 757,
				y = 360
			},
			["tower.default_rally_pos"] = {
				x = 772,
				y = 452
			}
		},
		{
			["tower.holder_id"] = "06",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 354,
				y = 402
			},
			["tower.default_rally_pos"] = {
				x = 324,
				y = 346
			}
		},
		{
			["tower.holder_id"] = "16",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 480,
				y = 407
			},
			["tower.default_rally_pos"] = {
				x = 490,
				y = 359
			}
		},
		{
			["tower.holder_id"] = "08",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 143,
				y = 472
			},
			["tower.default_rally_pos"] = {
				x = 161,
				y = 422
			}
		},
		{
			["tower.holder_id"] = "07",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 323,
				y = 484
			},
			["tower.default_rally_pos"] = {
				x = 236,
				y = 495
			}
		},
		{
			["tower.holder_id"] = "15",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 443,
				y = 511
			},
			["tower.default_rally_pos"] = {
				x = 537,
				y = 519
			}
		},
		{
			["tower.holder_id"] = "03",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 637,
				y = 520
			},
			["tower.default_rally_pos"] = {
				x = 607,
				y = 470
			}
		},
		{
			["tower.holder_id"] = "02",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 377,
				y = 586
			},
			["tower.default_rally_pos"] = {
				x = 282,
				y = 593
			}
		},
		{
			["tower.holder_id"] = "01",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 476,
				y = 606
			},
			["tower.default_rally_pos"] = {
				x = 565,
				y = 593
			}
		},
		{
			["tower.holder_id"] = "04",
			["tower.terrain_style"] = 1,
			template = "tower_holder_elven_woods",
			["editor.game_mode"] = 0,
			pos = {
				x = 669,
				y = 612
			},
			["tower.default_rally_pos"] = {
				x = 762,
				y = 593
			}
		},
		{
			["tunnel.pick_fx"] = "fx_waterfall_splash",
			["tunnel.place_pi"] = 7,
			template = "tunnel",
			["tunnel.place_fx"] = "fx_waterfall_splash",
			["tunnel.pick_pi"] = 1,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			["tunnel.pick_fx"] = "fx_waterfall_splash",
			["tunnel.place_pi"] = 8,
			template = "tunnel",
			["tunnel.place_fx"] = "fx_waterfall_splash",
			["tunnel.pick_pi"] = 3,
			pos = {
				x = 0,
				y = 0
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
			15
		},
		{
			1,
			nil,
			8,
			7
		},
		{
			nil,
			4,
			15,
			5
		},
		{
			nil,
			nil,
			1,
			3
		},
		{
			nil,
			3,
			11,
			10
		},
		{
			16,
			7,
			17,
			19
		},
		{
			15,
			2,
			8,
			6
		},
		{
			7,
			2,
			nil,
			17
		},
		{
			nil,
			10,
			12
		},
		{
			nil,
			5,
			11,
			9
		},
		{
			10,
			5,
			16,
			12
		},
		{
			9,
			11,
			14
		},
		{
			11,
			16,
			19,
			14
		},
		{
			12,
			13,
			20
		},
		{
			3,
			1,
			7,
			16
		},
		{
			11,
			15,
			6,
			13
		},
		{
			6,
			8,
			nil,
			18
		},
		{
			19,
			17,
			nil,
			20
		},
		{
			13,
			6,
			18,
			20
		},
		{
			14,
			19,
			18
		}
	},
	pan_extension = {
		bottom = -40,
		top = 40
	},
	required_sounds = {
		"music_stage81",
		"ElvesPlants",
		"EndlessGnollSounds",
		"ElvesCreepHyena",
		"ElvesCreepRazorboar",
		"ElvenWoodsAmbienceSounds",
		"ElvesLevelThreeSounds",
	},
	required_textures = {
		"go_stage81",
		"go_stage81_bg",
		"go_stages_elven_woods",
		"go_enemies_elven_woods",
		"go_enemies_ancient_metropolis",
	}
}
