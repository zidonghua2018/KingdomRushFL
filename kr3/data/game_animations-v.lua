local a = {
---征服
	tower_archer_1_shooter_idle = {
		prefix = "tower_archer_1_shooter",
		to = 1,
		from = 1
	},
	tower_archer_1_shooter_shoot = {
		prefix = "tower_archer_1_shooter",
		to = 15,
		from = 2
	},
	tower_archer_3_shooter_idle = {
		prefix = "shadowArcher",
		to = 67,
		from = 67
	},
	tower_archer_3_shooter_shoot = {
		prefix = "shadowArcher",
		to = 88,
		from = 75
	},
	tower_archer_2_shooter_idle = {
		prefix = "desertArcher",
		to = 67,
		from = 67
	},
	tower_archer_2_shooter_shoot = {
		prefix = "desertArcher",
		to = 88,
		from = 75
	},
	tower_barrack_door_open = {
		prefix = "tower_barrack_door",
		to = 15,
		from = 1
	},
	tower_barrack_door_close = {
		prefix = "tower_barrack_door",
		to = 1,
		from = 15
	},
	enemy_bandit_attack = {
		to = 74,
		from = 68,
		prefix = "bandit",
		post = {
			74,
			74,
			74,
			67
		}
	},
	enemy_bandit_death = {
		prefix = "bandit",
		to = 110,
		from = 99
	},
	enemy_bandit_idle = {
		prefix = "bandit",
		to = 67,
		from = 67
	},
	enemy_bandit_running = {
		prefix = "bandit",
		to = 22,
		from = 1
	},
	enemy_desertthug_idle = {
		prefix = "desertThug",
		to = 67,
		from = 67
	},
	enemy_desertthug_running = {
		prefix = "desertThug",
		to = 22,
		from = 1
	},
	enemy_desertthug_attack = {
		prefix = "desertThug",
		to = 77,
		from = 67
	},
	enemy_desertthug_death = {
		prefix = "desertThug",
		to = 106,
		from = 101
	},	
	enemy_brigand_attack = {
		prefix = "brigand",
		to = 80,
		from = 67,
		post = {
			67
		}
	},
	enemy_brigand_death = {
		prefix = "brigand",
		to = 111,
		from = 104
	},
	enemy_brigand_idle = {
		prefix = "brigand",
		to = 67,
		from = 67
	},
	enemy_brigand_running = {
		prefix = "brigand",
		to = 22,
		from = 1
	},
	tower_mage_1_shooter_idle = {
		prefix = "tower_mage_1_shooter",
		to = 1,
		from = 1
	},
	tower_mage_1_shooter_shoot = {
		prefix = "tower_mage_1_shooter",
		to = 29,
		from = 2
	},
	tower_mage_2_shooter_idle = {
		prefix = "demonMage",
		to = 67,
		from = 67
	},
	tower_mage_2_shooter_shoot = {
		prefix = "demonMage",
		to = 114,
		from = 87
	},
	tower_mage_3_shooter_idle = {
		prefix = "tower_infernal_mage_shooter",
		to = 1,
		from = 1
	},
	tower_mage_3_shooter_shoot = {
		prefix = "tower_infernal_mage_shooter",
		to = 27,
		from = 1
	},
	infernal_mage_bolt = {
		prefix = "infernal_mage_bolt",
		to = 10,
		from = 1
	},
	infernal_mage_bolt_idle = {
		prefix = "infernal_mage_bolt",
		to = 10,
		from = 1
	},
	infernal_mage_bolt_flying = {
		prefix = "infernal_mage_bolt",
		to = 10,
		from = 1
	},
	infernal_mage_bolt_explosion = {
		prefix = "infernal_mage_bolt_explosion",
		to = 13,
		from = 1
	},
	infernal_mage_bolt_particle = {
		prefix = "infernal_mage_bolt_particle",
		to = 10,
		from = 1
	},
	tower_mage_1_v_idle = {
		prefix = "tower_mage_1_base",
		to = 1,
		from = 1
	},
	tower_mage_1_v_shoot = {
		prefix = "tower_mage_1_base",
		to = 1,
		from = 1
	},
	tower_mage_2_v_idle = {
		prefix = "tower_mage_2_base",
		to = 1,
		from = 1
	},
	tower_mage_2_v_shoot = {
		prefix = "tower_mage_2_base",
		to = 1,
		from = 1
	},
	tower_mage_3_v_idle = {
		prefix = "tower_mage_3_base",
		to = 1,
		from = 1
	},
	tower_mage_3_v_shoot = {
		prefix = "tower_mage_3_base",
		to = 1,
		from = 1
	},
	tower_artillery_1_shooter_idle = {
		prefix = "tower_artillery_1_shooter",
		to = 1,
		from = 1
	},
	tower_artillery_1_shooter_shoot = {
		prefix = "tower_artillery_1_shooter",
		to = 14,
		from = 1
	},
	tower_artillery_2_shooter_idle = {
		prefix = "tower_artillery_2_shooter",
		to = 1,
		from = 1
	},
	tower_artillery_2_shooter_shoot = {
		prefix = "tower_artillery_2_shooter",
		to = 14,
		from = 1
	},
	tower_artillery_3_shooter_idle = {
		prefix = "goblin_zapper",
		to = 67,
		from = 67
	},
	tower_artillery_3_shooter_shoot = {
		prefix = "goblin_zapper",
		to = 81,
		from = 67
	},		
---蜥蜴人狙击塔
	tower_deathcoil_base_charged = {
		prefix = "tower_deathcoil_base_charged",
		to = 31,
		from = 1
	},
	tower_deathcoil_base_flash = {
		prefix = "tower_deathcoil_base_flash",
		to = 3,
		from = 1,
		post = {
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
			3,
		}
	},
	tower_deathcoil_proj_stun_flying = {
		prefix = "tower_deathcoil_proj_stun",
		to = 10,
		from = 1
	},
	tower_deathcoil_proj_stun_fx_loop = {
		prefix = "tower_deathcoil_proj_stun_fx",
		to = 6,
		from = 1
	},
	tower_deathcoil_shooter_fx = {
		prefix = "tower_deathcoil_shooter_fx",
		to = 17,
		from = 1
	},
	tower_deathcoil_crosshair_start = {
		prefix = "tower_deathcoil_crosshair",
		to = 20,
		from = 1
	},
	tower_deathcoil_crosshair_loop = {
		prefix = "tower_deathcoil_crosshair",
		to = 32,
		from = 21
	},
	tower_deathcoil_charged_flying = {
		prefix = "tower_deathcoil_proj_charged",
		to = 1,
		from = 1
	},
	tower_deathcoil_charged_hit = {
		prefix = "tower_deathcoil_hit_fx",
		to = 7,
		from = 1
	},
	tower_deathcoil_stun_ray = {
		prefix = "tower_deathcoil_stun_ray",
		to = 12,
		from = 1
	},
	tower_deathcoil_aim_ray = {
		prefix = "tower_deathcoil_aim_ray",
		to = 2,
		from = 1
	},
	enemy_sniper_idle = {
		prefix = "saurianSniper",
		to = 67,
		from = 67
	},
	enemy_sniper_ranged_loop_side = {
		prefix = "saurianSniper",
		to = 113,
		from = 90
	},
	enemy_sniper_ranged_loop_up = {
		prefix = "saurianSniper",
		to = 175,
		from = 152
	},
	enemy_sniper_ranged_loop_down = {
		prefix = "saurianSniper",
		to = 144,
		from = 121
	},
	enemy_sniper_ranged_start_side = {
		prefix = "saurianSniper",
		to = 89,
		from = 83
	},
	enemy_sniper_ranged_start_up = {
		prefix = "saurianSniper",
		to = 151,
		from = 145
	},
	enemy_sniper_ranged_start_down = {
		prefix = "saurianSniper",
		to = 120,
		from = 114
	},
	enemy_sniper_ranged_aim_side = {
		prefix = "saurianSniper",
		to = 89,
		from = 89
	},
	enemy_sniper_ranged_aim_up = {
		prefix = "saurianSniper",
		to = 151,
		from = 151
	},
	enemy_sniper_ranged_aim_down = {
		prefix = "saurianSniper",
		to = 120,
		from = 120
	},
	enemy_sniper_ranged_end_side = {
		prefix = "saurianSniper",
		to = 83,
		from = 89
	},
	enemy_sniper_ranged_end_up = {
		prefix = "saurianSniper",
		to = 145,
		from = 151
	},
	enemy_sniper_ranged_end_down = {
		prefix = "saurianSniper",
		to = 114,
		from = 120
	},
	bolt_sniper_deathcoil_flying = {
		prefix = "saurianSniper_proy",
		to = 1,
		from = 1
	},
	bolt_sniper_deathcoil_hit = {
		prefix = "saurianSniper_proy",
		to = 9,
		from = 2
	},
---腐毒菇林	
	tower_rotshroom_layer_1_idle = {
		prefix = "tower_rotshroom_layer_1",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_1_idle_anim_1 = {
		prefix = "tower_rotshroom_layer_1",
		frames = {
			1,
			1,
			2,
			3,
			3,
			4,
			5,
			5,
			6,
			7,
			7,
			8,
			9
		}
	},
	tower_rotshroom_layer_1_idle_anim_2 = {
		prefix = "tower_rotshroom_layer_1",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_1_idle_anim_3 = {
		prefix = "tower_rotshroom_layer_1",
		to = 32,
		from = 9
	},
	tower_rotshroom_layer_1_punch = {
		prefix = "tower_rotshroom_layer_1",
		to = 93,
		from = 32
	},
	tower_rotshroom_layer_1_shoot = {
		prefix = "tower_rotshroom_layer_1",
		to = 122,
		from = 93
	},
	tower_rotshroom_layer_2_idle = {
		prefix = "tower_rotshroom_layer_2",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_2_idle_anim_1 = {
		prefix = "tower_rotshroom_layer_2",
		to = 13,
		from = 1
	},
	tower_rotshroom_layer_2_idle_anim_2 = {
		prefix = "tower_rotshroom_layer_2",
		to = 24,
		from = 13
	},
	tower_rotshroom_layer_2_idle_anim_3 = {
		prefix = "tower_rotshroom_layer_2",
		to = 53,
		from = 24
	},
	tower_rotshroom_layer_2_punch = {
		prefix = "tower_rotshroom_layer_2",
		to = 114,
		from = 53
	},
	tower_rotshroom_layer_2_shoot = {
		prefix = "tower_rotshroom_layer_2",
		to = 143,
		from = 114
	},
	tower_rotshroom_layer_3_idle = {
		prefix = "tower_rotshroom_layer_3",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_3_idle_anim_1 = {
		prefix = "tower_rotshroom_layer_3",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_3_idle_anim_2 = {
		prefix = "tower_rotshroom_layer_3",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_3_idle_anim_3 = {
		prefix = "tower_rotshroom_layer_3",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_3_punch = {
		prefix = "tower_rotshroom_layer_3",
		to = 51,
		from = 1
	},
	tower_rotshroom_layer_3_shoot = {
		prefix = "tower_rotshroom_layer_3",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_4_idle = {
		prefix = "tower_rotshroom_layer_4",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_4_idle_anim_1 = {
		prefix = "tower_rotshroom_layer_4",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_4_idle_anim_2 = {
		prefix = "tower_rotshroom_layer_4",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_4_idle_anim_3 = {
		prefix = "tower_rotshroom_layer_4",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_4_punch = {
		prefix = "tower_rotshroom_layer_4",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_4_shoot = {
		prefix = "tower_rotshroom_layer_4",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_5_idle = {
		prefix = "tower_rotshroom_layer_5",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_5_idle_anim_1 = {
		prefix = "tower_rotshroom_layer_5",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_5_idle_anim_2 = {
		prefix = "tower_rotshroom_layer_5",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_5_idle_anim_3 = {
		prefix = "tower_rotshroom_layer_5",
		to = 1,
		from = 1
	},
	tower_rotshroom_layer_5_punch = {
		prefix = "tower_rotshroom_layer_5",
		to = 65,
		from = 1
	},
	tower_rotshroom_layer_5_shoot = {
		prefix = "tower_rotshroom_layer_5",
		to = 1,
		from = 1
	},
	mushroom_mine_small_spawn = {
		prefix = "mushroom_mine",
		to = 9,
		from = 1
	},
	mushroom_mine_small_idle = {
		prefix = "mushroom_mine",
		to = 9,
		from = 9
	},
	mushroom_mine_small_explode = {
		prefix = "mushroom_mine",
		to = 47,
		from = 33
	},
	mushroom_mine_spawn = {
		prefix = "mushroom_mine",
		to = 15,
		from = 1
	},
	mushroom_mine_idle = {
		prefix = "mushroom_mine",
		to = 15,
		from = 15
	},
	mushroom_mine_explode = {
		prefix = "mushroom_mine",
		to = 32,
		from = 16
	},
	mushroom_mine_arm = {
		prefix = "mushroom_mine",
		to = 57,
		from = 48
	},
	mushroom_mine_small_arm = {
		prefix = "mushroom_mine",
		to = 67,
		from = 58
	},
---红帽地精
	tower_redcap_door_open = {
		to = 7,
		from = 1,
		prefix = "tower_redcap_door"
	},
	tower_redcap_door_close = {
		to = 1,
		from = 7,
		prefix = "tower_redcap_door"
	},
	redcap_idle = {
		prefix = "redcap",
		to = 1,
		from = 1
	},
	redcap_running = {
		prefix = "redcap",
		to = 23,
		from = 2
	},
	redcap_attack = {
		prefix = "redcap",
		to = 91,
		from = 68
	},
	redcap_special = {
		prefix = "redcap",
		to = 123,
		from = 92
	},
	redcap_death = {
		prefix = "redcap",
		to = 148,
		from = 124
	},
	fx_redcap_death_blow = {
		prefix = "redcap_hitFx",
		to = 15,
		from = 1
	},	
---哥布林萨满
	enemy_shaman_attack = {
		prefix = "shaman",
		to = 84,
		from = 67
	},
	enemy_shaman_death = {
		prefix = "shaman",
		to = 142,
		from = 136
	},
	enemy_shaman_idle = {
		prefix = "shaman",
		to = 67,
		from = 67
	},
	enemy_shaman_heal = {
		prefix = "shaman",
		to = 111,
		from = 88
	},
	enemy_shaman_shoot = {
		prefix = "shaman",
		to = 132,
		from = 112,
		pre = {
			88,
			89
		}
	},
	enemy_shaman_buff = {
		prefix = "shaman",
		to = 154,
		from = 133,
		pre = {
			88,
			89
		}
	},
	enemy_shaman_thorn = {
		prefix = "shaman",
		to = 130,
		from = 112
	},
	enemy_shaman_thornFree = {
		prefix = "shaman",
		to = 135,
		from = 131
	},
	enemy_shaman_walkingDown = {
		prefix = "shaman",
		to = 66,
		from = 45
	},
	enemy_shaman_walkingRightLeft = {
		prefix = "shaman",
		to = 22,
		from = 1
	},
	enemy_shaman_walkingUp = {
		prefix = "shaman",
		to = 44,
		from = 23
	},
	eb_elder_shaman_cast = {
		prefix = "endless_boss",
		to = 36,
		from = 2
	},
	eb_elder_shaman_idle = {
		prefix = "endless_boss",
		to = 1,
		from = 2
	},
	elder_shaman_totem_orange_start = {
		prefix = "totem_orange",
		to = 10,
		from = 1
	},
	elder_shaman_totem_orange_end = {
		prefix = "totem_orange",
		to = 30,
		from = 11
	},
	elder_shaman_totem_orange_fx = {
		prefix = "totem_orange_fx",
		to = 37,
		from = 1
	},
	elder_shaman_totem_blue_start = {
		prefix = "totem_lightBlue",
		to = 10,
		from = 1
	},
	elder_shaman_totem_blue_end = {
		prefix = "totem_lightBlue",
		to = 30,
		from = 11
	},
	elder_shaman_totem_blue_fx = {
		prefix = "totem_lightBlue_fx",
		to = 18,
		from = 1
	},
	elder_shaman_totem_red_start = {
		prefix = "totem_red",
		to = 10,
		from = 1
	},
	elder_shaman_totem_red_end = {
		prefix = "totem_red",
		to = 30,
		from = 11
	},
	elder_shaman_totem_red_fx = {
		prefix = "totem_red_fx",
		to = 12,
		from = 1
	},
	mod_elder_shaman_speed = {
		prefix = "buff_magic",
		to = 22,
		from = 1
	},
	tower_shaman_layer2_shoot = {
		prefix = "tower_shaman_base",
		to = 33,
		from = 2,
		post = {
			162
		}
	},
	tower_shaman_layer2_idle = {
		prefix = "tower_shaman_base",
		to = 162,
		from = 162
	},
	tower_shaman_layer2_buff = {
		prefix = "tower_shaman_base",
		to = 97,
		from = 66,
		post = {
			162
		}
	},
	tower_shaman_layer2_heal = {
		prefix = "tower_shaman_base",
		to = 65,
		from = 34,
		post = {
			162
		}
	},
	tower_shaman_layer3_light = {
		prefix = "tower_shaman_base",
		to = 129,
		from = 98
	},
	tower_shaman_layer4_light = {
		prefix = "tower_shaman_base",
		to = 161,
		from = 130
	},
	tower_shaman_fire_idle = {
		prefix = "TemplarTower_Fire",
		to = 12,
		from = 1
	},
	demon_flareon_flare = {
		prefix = "Inferno_Flareon_proy",
		to = 12,
		from = 1
	},
	demon_flareon_flare_flying = {
		prefix = "Inferno_Flareon_proy",
		to = 12,
		from = 1
	},
	demon_flareon_flare_idle = {
		prefix = "Inferno_Flareon_proy",
		to = 12,
		from = 1
	},									
}

local o = {}

o.animations = a

return o
