-- chunkname: @./kr1/data/game_animations.lua

local a = {
	re1_farmer_1_idle = {
		prefix = "g1_reinforce_A0",
		to = 1,
		from = 1
	},
	re1_farmer_1_running = {
		prefix = "g1_reinforce_A0",
		to = 6,
		from = 2
	},
	re1_farmer_1_attack = {
		prefix = "g1_reinforce_A0",
		to = 17,
		from = 7
	},
	re1_farmer_2_idle = {
		prefix = "g1_reinforce_B0",
		to = 1,
		from = 1
	},
	re1_farmer_2_running = {
		prefix = "g1_reinforce_B0",
		to = 6,
		from = 2
	},
	re1_farmer_2_attack = {
		prefix = "g1_reinforce_B0",
		to = 17,
		from = 7
	},
	re1_farmer_3_idle = {
		prefix = "g1_reinforce_C0",
		to = 1,
		from = 1
	},
	re1_farmer_3_running = {
		prefix = "g1_reinforce_C0",
		to = 6,
		from = 2
	},
	re1_farmer_3_attack = {
		prefix = "g1_reinforce_C0",
		to = 17,
		from = 7
	},
	re1_farmer_well_fed_1_idle = {
		prefix = "g1_reinforce_A0",
		to = 1,
		from = 1
	},
	re1_farmer_well_fed_1_running = {
		prefix = "g1_reinforce_A0",
		to = 6,
		from = 2
	},
	re1_farmer_well_fed_1_attack = {
		prefix = "g1_reinforce_A0",
		to = 17,
		from = 7
	},
	re1_farmer_well_fed_2_idle = {
		prefix = "g1_reinforce_B0",
		to = 1,
		from = 1
	},
	re1_farmer_well_fed_2_running = {
		prefix = "g1_reinforce_B0",
		to = 6,
		from = 2
	},
	re1_farmer_well_fed_2_attack = {
		prefix = "g1_reinforce_B0",
		to = 17,
		from = 7
	},
	re1_farmer_well_fed_3_idle = {
		prefix = "g1_reinforce_C0",
		to = 1,
		from = 1
	},
	re1_farmer_well_fed_3_running = {
		prefix = "g1_reinforce_C0",
		to = 6,
		from = 2
	},
	re1_farmer_well_fed_3_attack = {
		prefix = "g1_reinforce_C0",
		to = 17,
		from = 7
	},
	re1_conscript_1_idle = {
		prefix = "g1_reinforce_A1",
		to = 1,
		from = 1
	},
	re1_conscript_1_running = {
		prefix = "g1_reinforce_A1",
		to = 6,
		from = 2
	},
	re1_conscript_1_attack = {
		prefix = "g1_reinforce_A1",
		to = 17,
		from = 7
	},
	re1_conscript_2_idle = {
		prefix = "g1_reinforce_B1",
		to = 1,
		from = 1
	},
	re1_conscript_2_running = {
		prefix = "g1_reinforce_B1",
		to = 6,
		from = 2
	},
	re1_conscript_2_attack = {
		prefix = "g1_reinforce_B1",
		to = 17,
		from = 7
	},
	re1_conscript_3_idle = {
		prefix = "g1_reinforce_C1",
		to = 1,
		from = 1
	},
	re1_conscript_3_running = {
		prefix = "g1_reinforce_C1",
		to = 6,
		from = 2
	},
	re1_conscript_3_attack = {
		prefix = "g1_reinforce_C1",
		to = 17,
		from = 7
	},
	re1_warrior_1_idle = {
		prefix = "g1_reinforce_A2",
		to = 1,
		from = 1
	},
	re1_warrior_1_running = {
		prefix = "g1_reinforce_A2",
		to = 6,
		from = 2
	},
	re1_warrior_1_attack = {
		prefix = "g1_reinforce_A2",
		to = 17,
		from = 7
	},
	re1_warrior_2_idle = {
		prefix = "g1_reinforce_B2",
		to = 1,
		from = 1
	},
	re1_warrior_2_running = {
		prefix = "g1_reinforce_B2",
		to = 6,
		from = 2
	},
	re1_warrior_2_attack = {
		prefix = "g1_reinforce_B2",
		to = 17,
		from = 7
	},
	re1_warrior_3_idle = {
		prefix = "g1_reinforce_C2",
		to = 1,
		from = 1
	},
	re1_warrior_3_running = {
		prefix = "g1_reinforce_C2",
		to = 6,
		from = 2
	},
	re1_warrior_3_attack = {
		prefix = "g1_reinforce_C2",
		to = 17,
		from = 7
	},
	--[[
	re1_legionnaire_1_idle = {
		prefix = "re_skin_2_1",
		to = 1,
		from = 1
	},
	re1_legionnaire_1_running = {
		prefix = "re_skin_2_1",
		to = 6,
		from = 2
	},
	re1_legionnaire_1_attack = {
		prefix = "re_skin_2_1",
		to = 17,
		from = 7
	},
	re1_legionnaire_2_idle = {
		prefix = "re_skin_2_2",
		to = 1,
		from = 1
	},
	re1_legionnaire_2_running = {
		prefix = "re_skin_2_2",
		to = 6,
		from = 2
	},
	re1_legionnaire_2_attack = {
		prefix = "re_skin_2_2",
		to = 17,
		from = 7
	},
	re1_legionnaire_3_idle = {
		prefix = "re_skin_2_3",
		to = 1,
		from = 1
	},
	re1_legionnaire_3_running = {
		prefix = "re_skin_2_3",
		to = 6,
		from = 2
	},
	re1_legionnaire_3_attack = {
		prefix = "re_skin_2_3",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_1_idle = {
		prefix = "re_skin_2_1",
		to = 1,
		from = 1
	},
	re1_legionnaire_ranged_1_running = {
		prefix = "re_skin_2_1",
		to = 6,
		from = 2
	},
	re1_legionnaire_ranged_1_attack = {
		prefix = "re_skin_2_1",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_1_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_2_1",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_1_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "re_skin_2_1",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_2_idle = {
		prefix = "re_skin_2_2",
		to = 1,
		from = 1
	},
	re1_legionnaire_ranged_2_running = {
		prefix = "re_skin_2_2",
		to = 6,
		from = 2
	},
	re1_legionnaire_ranged_2_attack = {
		prefix = "re_skin_2_2",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_2_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_2_2",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_2_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "re_skin_2_2",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_3_idle = {
		prefix = "re_skin_2_3",
		to = 1,
		from = 1
	},
	re1_legionnaire_ranged_3_running = {
		prefix = "re_skin_2_3",
		to = 6,
		from = 2
	},
	re1_legionnaire_ranged_3_attack = {
		prefix = "re_skin_2_3",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_3_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_2_3",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_3_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "re_skin_2_3",
		post = {
			1
		}
	},
	]]--
	re_skin_1_1_idle = {
		prefix = "re_skin_1_1",
		to = 1,
		from = 1
	},
	re_skin_1_1_running = {
		prefix = "re_skin_1_1",
		to = 6,
		from = 2
	},
	re_skin_1_1_attack = {
		prefix = "re_skin_1_1",
		to = 17,
		from = 7
	},
	re_skin_1_1_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_1_1",
		post = {
			1
		}
	},
	re_skin_1_2_idle = {
		prefix = "re_skin_1_2",
		to = 1,
		from = 1
	},
	re_skin_1_2_running = {
		prefix = "re_skin_1_2",
		to = 6,
		from = 2
	},
	re_skin_1_2_attack = {
		prefix = "re_skin_1_2",
		to = 17,
		from = 7
	},
	re_skin_1_2_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_1_2",
		post = {
			1
		}
	},
	re_skin_1_3_idle = {
		prefix = "re_skin_1_3",
		to = 1,
		from = 1
	},
	re_skin_1_3_running = {
		prefix = "re_skin_1_3",
		to = 6,
		from = 2
	},
	re_skin_1_3_attack = {
		prefix = "re_skin_1_3",
		to = 17,
		from = 7
	},
	re_skin_1_3_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_1_3",
		post = {
			1
		}
	},
	re_skin_1_4_idle = {
		prefix = "re_skin_1_4",
		to = 1,
		from = 1
	},
	re_skin_1_4_running = {
		prefix = "re_skin_1_4",
		to = 6,
		from = 2
	},
	re_skin_1_4_attack = {
		prefix = "re_skin_1_4",
		to = 17,
		from = 7
	},
	re_skin_1_4_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_1_4",
		post = {
			1
		}
	},
	re_skin_2_1_idle = {
		prefix = "re_skin_2_1",
		to = 1,
		from = 1
	},
	re_skin_2_1_running = {
		prefix = "re_skin_2_1",
		to = 6,
		from = 2
	},
	re_skin_2_1_attack = {
		prefix = "re_skin_2_1",
		to = 17,
		from = 7
	},
	re_skin_2_1_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_2_1",
		post = {
			1
		}
	},
	re_skin_2_2_idle = {
		prefix = "re_skin_2_2",
		to = 1,
		from = 1
	},
	re_skin_2_2_running = {
		prefix = "re_skin_2_2",
		to = 6,
		from = 2
	},
	re_skin_2_2_attack = {
		prefix = "re_skin_2_2",
		to = 17,
		from = 7
	},
	re_skin_2_2_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_2_2",
		post = {
			1
		}
	},
	re_skin_2_3_idle = {
		prefix = "re_skin_2_3",
		to = 1,
		from = 1
	},
	re_skin_2_3_running = {
		prefix = "re_skin_2_3",
		to = 6,
		from = 2
	},
	re_skin_2_3_attack = {
		prefix = "re_skin_2_3",
		to = 17,
		from = 7
	},
	re_skin_2_3_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_2_3",
		post = {
			1
		}
	},
	re_skin_2_4_idle = {
		prefix = "re_skin_2_4",
		to = 1,
		from = 1
	},
	re_skin_2_4_running = {
		prefix = "re_skin_2_4",
		to = 6,
		from = 2
	},
	re_skin_2_4_attack = {
		prefix = "re_skin_2_4",
		to = 17,
		from = 7
	},
	re_skin_2_4_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_2_4",
		post = {
			1
		}
	},
	re_skin_3_1_idle = {
		prefix = "re_skin_3_1",
		to = 1,
		from = 1
	},
	re_skin_3_1_running = {
		prefix = "re_skin_3_1",
		to = 6,
		from = 2
	},
	re_skin_3_1_attack = {
		prefix = "re_skin_3_1",
		to = 17,
		from = 7
	},
	re_skin_3_1_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_3_1",
		post = {
			1
		}
	},
	re_skin_3_2_idle = {
		prefix = "re_skin_3_2",
		to = 1,
		from = 1
	},
	re_skin_3_2_running = {
		prefix = "re_skin_3_2",
		to = 6,
		from = 2
	},
	re_skin_3_2_attack = {
		prefix = "re_skin_3_2",
		to = 17,
		from = 7
	},
	re_skin_3_2_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_3_2",
		post = {
			1
		}
	},
	re_skin_3_3_idle = {
		prefix = "re_skin_3_3",
		to = 1,
		from = 1
	},
	re_skin_3_3_running = {
		prefix = "re_skin_3_3",
		to = 6,
		from = 2
	},
	re_skin_3_3_attack = {
		prefix = "re_skin_3_3",
		to = 17,
		from = 7
	},
	re_skin_3_3_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_3_3",
		post = {
			1
		}
	},
	re_skin_3_4_idle = {
		prefix = "re_skin_3_4",
		to = 1,
		from = 1
	},
	re_skin_3_4_running = {
		prefix = "re_skin_3_4",
		to = 6,
		from = 2
	},
	re_skin_3_4_attack = {
		prefix = "re_skin_3_4",
		to = 17,
		from = 7
	},
	re_skin_3_4_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "re_skin_3_4",
		post = {
			1
		}
	},	
	re1_legionnaire_1_idle = {
		prefix = "g1_reinforce_A3",
		to = 1,
		from = 1
	},
	re1_legionnaire_1_running = {
		prefix = "g1_reinforce_A3",
		to = 6,
		from = 2
	},
	re1_legionnaire_1_attack = {
		prefix = "g1_reinforce_A3",
		to = 17,
		from = 7
	},
	re1_legionnaire_2_idle = {
		prefix = "g1_reinforce_B3",
		to = 1,
		from = 1
	},
	re1_legionnaire_2_running = {
		prefix = "g1_reinforce_B3",
		to = 6,
		from = 2
	},
	re1_legionnaire_2_attack = {
		prefix = "g1_reinforce_B3",
		to = 17,
		from = 7
	},
	re1_legionnaire_3_idle = {
		prefix = "g1_reinforce_C3",
		to = 1,
		from = 1
	},
	re1_legionnaire_3_running = {
		prefix = "g1_reinforce_C3",
		to = 6,
		from = 2
	},
	re1_legionnaire_3_attack = {
		prefix = "g1_reinforce_C3",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_1_idle = {
		prefix = "g1_reinforce_A3",
		to = 1,
		from = 1
	},
	re1_legionnaire_ranged_1_running = {
		prefix = "g1_reinforce_A3",
		to = 6,
		from = 2
	},
	re1_legionnaire_ranged_1_attack = {
		prefix = "g1_reinforce_A3",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_1_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "g1_reinforce_A3",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_1_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "g1_reinforce_A3",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_2_idle = {
		prefix = "g1_reinforce_B3",
		to = 1,
		from = 1
	},
	re1_legionnaire_ranged_2_running = {
		prefix = "g1_reinforce_B3",
		to = 6,
		from = 2
	},
	re1_legionnaire_ranged_2_attack = {
		prefix = "g1_reinforce_B3",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_2_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "g1_reinforce_B3",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_2_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "g1_reinforce_B3",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_3_idle = {
		prefix = "g1_reinforce_C3",
		to = 1,
		from = 1
	},
	re1_legionnaire_ranged_3_running = {
		prefix = "g1_reinforce_C3",
		to = 6,
		from = 2
	},
	re1_legionnaire_ranged_3_attack = {
		prefix = "g1_reinforce_C3",
		to = 17,
		from = 7
	},
	re1_legionnaire_ranged_3_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "g1_reinforce_C3",
		post = {
			1
		}
	},
	re1_legionnaire_ranged_3_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "g1_reinforce_C3",
		post = {
			1
		}
	},
	blood_pool_red = {
		prefix = "decal_blood",
		to = 1,
		from = 1
	},
	blood_pool_green = {
		prefix = "decal_blood",
		to = 2,
		from = 2
	},
	blood_pool_violet = {
		prefix = "decal_blood",
		to = 3,
		from = 3
	},
	blood_pool_gray = {
		prefix = "decal_blood",
		to = 4,
		from = 4
	},
	ground_hit_decal = {
		prefix = "decal_smoke_hitground",
		to = 12,
		from = 1
	},
	freeze_creep_ground_start = {
		prefix = "freeze_creep",
		to = 7,
		from = 1
	},
	freeze_creep_ground_end = {
		prefix = "freeze_creep",
		to = 23,
		from = 8
	},
	freeze_creep_air_start = {
		prefix = "freeze_creepFlying",
		to = 9,
		from = 1
	},
	freeze_creep_air_end = {
		prefix = "freeze_creepFlying",
		to = 21,
		from = 10
	},
	ps_shotgun_musketeer = {
		prefix = "particle_sniper_bullet",
		to = 13,
		from = 1
	},
	blood_splat_red = {
		prefix = "fx_blood_splat_red",
		to = 10,
		from = 1
	},
	blood_splat_green = {
		prefix = "fx_blood_splat_green",
		to = 10,
		from = 1
	},
	blood_splat_gray = {
		prefix = "fx_blood_splat_gray",
		to = 10,
		from = 1
	},
	blood_splat_violet = {
		prefix = "fx_blood_splat_violet",
		to = 10,
		from = 1
	},
	explode_small = {
		prefix = "states_small",
		to = 32,
		from = 22
	},
	explode_big = {
		prefix = "states_big",
		to = 32,
		from = 22
	},
	desintegrate_soldier = {
		prefix = "states_soldiers",
		to = 15,
		from = 1
	},
	desintegrate_enemy_small = {
		prefix = "states_small",
		to = 47,
		from = 33
	},
	desintegrate_enemy_big = {
		prefix = "states_big",
		to = 47,
		from = 33
	},
	desintegrate_enemy_air_small = {
		prefix = "states_small",
		to = 72,
		from = 59
	},
	explosion_big = {
		prefix = "explosion_big",
		to = 20,
		from = 3
	},
	explosion_fragment = {
		prefix = "explosion_fragment",
		to = 18,
		from = 1
	},
	explosion_air = {
		prefix = "explosion_air",
		to = 18,
		from = 1
	},
	explosion_shrapnel = {
		prefix = "explosion_shrapnel",
		to = 20,
		from = 1
	},
	explosion_rotten_shot = {
		prefix = "Explosion_RottenShot",
		to = 11,
		from = 1
	},
	explosion_flare_flareon = {
		prefix = "Inferno_Flareon_Explosion",
		to = 13,
		from = 1
	},
	tower_build_dust = {
		prefix = "effect_buildSmoke",
		to = 12,
		from = 1
	},
	tower_sell_dust = {
		prefix = "effect_sellSmoke",
		to = 12,
		from = 1
	},
	coin_jump = {
		prefix = "nextwave_coin",
		to = 14,
		from = 1
	},
	fx_coin_jump = {
		prefix = "fx_coin_jump",
		to = 14,
		from = 1
	},
	smoke_bullet = {
		prefix = "fx_bullet_smoke",
		to = 12,
		from = 1
	},
	fx_rifle_smoke = {
		prefix = "fx_rifle_smoke",
		to = 11,
		from = 1
	},
	fx_teleport_arcane_small = {
		prefix = "states_small",
		to = 10,
		from = 1
	},
	fx_teleport_arcane_big = {
		prefix = "states_big",
		to = 10,
		from = 1
	},
	fx_mod_polymorph_sorcerer_small = {
		prefix = "states_small",
		to = 21,
		from = 11
	},
	fx_mod_polymorph_sorcerer_big = {
		prefix = "states_big",
		to = 21,
		from = 11
	},
	ground_hit_smoke = {
		prefix = "fx_smoke_hitground",
		to = 14,
		from = 1
	},
	fx_shield_small = {
		prefix = "shield_small",
		to = 11,
		from = 1
	},
	fx_demon_portal_out_small = {
		prefix = "states_small",
		to = 82,
		from = 73
	},
	fx_demon_portal_out_big = {
		prefix = "states_big",
		to = 68,
		from = 59
	},
	healing_small = {
		prefix = "healing_small",
		to = 24,
		from = 1
	},
	healing_medium = {
		prefix = "healing_big",
		to = 24,
		from = 1
	},
	healing_large = {
		prefix = "healing_boss_type1",
		to = 24,
		from = 1
	},
	bleeding_small_red = {
		prefix = "bleeding_small_red",
		to = 12,
		from = 1
	},
	bleeding_small_gray = {
		prefix = "bleeding_small_gray",
		to = 12,
		from = 1
	},
	bleeding_small_green = {
		prefix = "bleeding_small_green",
		to = 12,
		from = 1
	},
	bleeding_small_violet = {
		prefix = "bleeding_small_violet",
		to = 12,
		from = 1
	},
	bleeding_big_red = {
		prefix = "bleeding_big_red",
		to = 12,
		from = 1
	},
	bleeding_big_gray = {
		prefix = "bleeding_big_gray",
		to = 12,
		from = 1
	},
	bleeding_big_green = {
		prefix = "bleeding_big_green",
		to = 12,
		from = 1
	},
	bleeding_big_violet = {
		prefix = "bleeding_big_violet",
		to = 12,
		from = 1
	},
	stun_big_loop = {
		prefix = "stun_big",
		to = 26,
		from = 1
	},
	stun_small_loop = {
		prefix = "stun_small",
		to = 26,
		from = 1
	},
	poison_small = {
		prefix = "poison_small",
		to = 12,
		from = 1
	},
	poison_big = {
		prefix = "poison_big",
		to = 12,
		from = 1
	},
	poison_violet_small = {
		prefix = "poison_small_violet",
		to = 12,
		from = 1
	},
	mod_thorn_small_start = {
		prefix = "thorn_small",
		to = 18,
		from = 1
	},
	mod_thorn_small_loop = {
		prefix = "thorn_small",
		to = 18,
		from = 18
	},
	mod_thorn_small_end = {
		prefix = "thorn_small",
		to = 24,
		from = 19
	},
	mod_thorn_big_start = {
		prefix = "thorn_big",
		to = 18,
		from = 1
	},
	mod_thorn_big_loop = {
		prefix = "thorn_big",
		to = 18,
		from = 18
	},
	mod_thorn_big_end = {
		prefix = "thorn_big",
		to = 24,
		from = 19
	},
	mod_gerald_courage = {
		prefix = "hero_barracks_buff",
		to = 28,
		from = 1
	},
	fire_medium = {
		prefix = "fire_big",
		to = 10,
		from = 1
	},
	fire_small = {
		prefix = "fire_small",
		to = 10,
		from = 1
	},
	fire_large = {
		prefix = "fire_boss_type1",
		to = 10,
		from = 1
	},
	mod_troll_rage = {
		prefix = "rage_small",
		to = 27,
		from = 1
	},
	fireball_proyectile = {
		prefix = "fireball_proyectile",
		to = 6,
		from = 1
	},
	fireball_shadow = {
		prefix = "fireball_shadow",
		to = 20,
		from = 1
	},
	fireball_explosion = {
		prefix = "fireball_explosion",
		to = 18,
		from = 1
	},
	fireball_particle = {
		prefix = "fireball_particle",
		to = 4,
		from = 1
	},
	enemy_sheep_ground_death = {
		prefix = "sheep",
		to = 59,
		from = 49
	},
	enemy_sheep_ground_idle = {
		prefix = "sheep",
		to = 25,
		from = 25
	},
	enemy_sheep_ground_walkingRightLeft = {
		prefix = "sheep",
		to = 8,
		from = 1
	},
	enemy_sheep_ground_walkingDown = {
		prefix = "sheep",
		to = 24,
		from = 17
	},
	enemy_sheep_ground_walkingUp = {
		prefix = "sheep",
		to = 16,
		from = 9
	},
	enemy_sheep_fly_death = {
		prefix = "sheep_flying",
		to = 44,
		from = 34
	},
	enemy_sheep_fly_idle = {
		prefix = "sheep_flying",
		to = 11,
		from = 1
	},
	enemy_sheep_fly_walkingRightLeft = {
		prefix = "sheep_flying",
		to = 11,
		from = 1
	},
	enemy_sheep_fly_walkingDown = {
		prefix = "sheep_flying",
		to = 33,
		from = 23
	},
	enemy_sheep_fly_walkingUp = {
		prefix = "sheep_flying",
		to = 22,
		from = 12
	},
	goblin_attack = {
		prefix = "goblin",
		to = 82,
		from = 70
	},
	goblin_death = {
		prefix = "goblin",
		to = 120,
		from = 106
	},
	goblin_idle = {
		prefix = "goblin",
		to = 67,
		from = 67
	},
	goblin_thorn = {
		prefix = "goblin",
		to = 101,
		from = 83
	},
	goblin_thornFree = {
		prefix = "goblin",
		to = 106,
		from = 102
	},
	goblin_walkingDown = {
		prefix = "goblin",
		to = 66,
		from = 45
	},
	goblin_walkingRightLeft = {
		prefix = "goblin",
		to = 22,
		from = 1
	},
	goblin_walkingUp = {
		prefix = "goblin",
		to = 44,
		from = 23
	},
	enemy_fat_orc_attack = {
		prefix = "orc",
		to = 77,
		from = 68
	},
	enemy_fat_orc_death = {
		prefix = "orc",
		to = 108,
		from = 102
	},
	enemy_fat_orc_idle = {
		prefix = "orc",
		to = 67,
		from = 67
	},
	enemy_fat_orc_thorn = {
		prefix = "orc",
		to = 96,
		from = 78
	},
	enemy_fat_orc_thornFree = {
		prefix = "orc",
		to = 101,
		from = 97
	},
	enemy_fat_orc_walkingDown = {
		prefix = "orc",
		to = 66,
		from = 45
	},
	enemy_fat_orc_walkingRightLeft = {
		prefix = "orc",
		to = 22,
		from = 1
	},
	enemy_fat_orc_walkingUp = {
		prefix = "orc",
		to = 44,
		from = 23
	},
	enemy_wolf_small_attack = {
		prefix = "wulf",
		to = 44,
		from = 31
	},
	enemy_wolf_small_death = {
		prefix = "wulf",
		to = 85,
		from = 69
	},
	enemy_wolf_small_idle = {
		prefix = "wulf",
		to = 31,
		from = 31
	},
	enemy_wolf_small_thorn = {
		prefix = "wulf",
		to = 63,
		from = 44
	},
	enemy_wolf_small_thornFree = {
		prefix = "wulf",
		to = 69,
		from = 65
	},
	enemy_wolf_small_walkingDown = {
		prefix = "wulf",
		to = 30,
		from = 21
	},
	enemy_wolf_small_walkingRightLeft = {
		prefix = "wulf",
		to = 10,
		from = 1
	},
	enemy_wolf_small_walkingUp = {
		prefix = "wulf",
		to = 20,
		from = 11
	},
	enemy_wolf_attack = {
		prefix = "worg",
		to = 44,
		from = 31
	},
	enemy_wolf_death = {
		prefix = "worg",
		to = 84,
		from = 69
	},
	enemy_wolf_idle = {
		prefix = "worg",
		to = 31,
		from = 31
	},
	enemy_wolf_thorn = {
		prefix = "worg",
		to = 63,
		from = 44
	},
	enemy_wolf_thornFree = {
		prefix = "worg",
		to = 69,
		from = 65
	},
	enemy_wolf_walkingDown = {
		prefix = "worg",
		to = 30,
		from = 21
	},
	enemy_wolf_walkingRightLeft = {
		prefix = "worg",
		to = 10,
		from = 1
	},
	enemy_wolf_walkingUp = {
		prefix = "worg",
		to = 20,
		from = 11
	},
	enemy_shadow_archer_attack = {
		to = 74,
		from = 68,
		prefix = "shadowArcher",
		post = {
			74,
			74,
			74
		}
	},
	enemy_shadow_archer_death = {
		prefix = "shadowArcher",
		to = 119,
		from = 112
	},
	enemy_shadow_archer_idle = {
		prefix = "shadowArcher",
		to = 67,
		from = 67
	},
	enemy_shadow_archer_shoot = {
		prefix = "shadowArcher",
		to = 88,
		from = 75
	},
	enemy_shadow_archer_thorn = {
		prefix = "shadowArcher",
		to = 86,
		from = 67
	},
	enemy_shadow_archer_thornFree = {
		prefix = "shadowArcher",
		to = 113,
		from = 108
	},
	enemy_shadow_archer_walkingDown = {
		prefix = "shadowArcher",
		to = 66,
		from = 45
	},
	enemy_shadow_archer_walkingRightLeft = {
		prefix = "shadowArcher",
		to = 22,
		from = 1
	},
	enemy_shadow_archer_walkingUp = {
		prefix = "shadowArcher",
		to = 44,
		from = 23
	},
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
	enemy_gargoyle_death = {
		prefix = "gargoyle",
		to = 54,
		from = 43
	},
	enemy_gargoyle_idle = {
		prefix = "gargoyle",
		to = 14,
		from = 1
	},
	enemy_gargoyle_walkingDown = {
		prefix = "gargoyle",
		to = 42,
		from = 29
	},
	enemy_gargoyle_walkingRightLeft = {
		prefix = "gargoyle",
		to = 14,
		from = 1
	},
	enemy_gargoyle_walkingUp = {
		prefix = "gargoyle",
		to = 28,
		from = 15
	},
	enemy_ogre_attack = {
		prefix = "ogre",
		to = 106,
		from = 80
	},
	enemy_ogre_death = {
		prefix = "ogre",
		to = 145,
		from = 130
	},
	enemy_ogre_idle = {
		prefix = "ogre",
		to = 80,
		from = 80
	},
	enemy_ogre_thorn = {
		prefix = "ogre",
		to = 125,
		from = 107
	},
	enemy_ogre_thornFree = {
		prefix = "ogre",
		to = 129,
		from = 126
	},
	enemy_ogre_walkingDown = {
		prefix = "ogre",
		to = 78,
		from = 53
	},
	enemy_ogre_walkingRightLeft = {
		prefix = "ogre",
		to = 26,
		from = 1
	},
	enemy_ogre_walkingUp = {
		prefix = "ogre",
		to = 52,
		from = 27
	},
	enemy_spider_tiny_attack = {
		prefix = "spider_tiny",
		to = 46,
		from = 28
	},
	enemy_spider_tiny_death = {
		prefix = "spider_tiny",
		to = 84,
		from = 70
	},
	enemy_spider_tiny_idle = {
		prefix = "spider_tiny",
		to = 28,
		from = 28
	},
	enemy_spider_tiny_thorn = {
		prefix = "spider_tiny",
		to = 65,
		from = 47
	},
	enemy_spider_tiny_thornFree = {
		prefix = "spider_tiny",
		to = 70,
		from = 66
	},
	enemy_spider_tiny_walkingDown = {
		prefix = "spider_tiny",
		to = 27,
		from = 19
	},
	enemy_spider_tiny_walkingRightLeft = {
		prefix = "spider_tiny",
		to = 9,
		from = 1
	},
	enemy_spider_tiny_walkingUp = {
		prefix = "spider_tiny",
		to = 18,
		from = 10
	},
	enemy_spider_attack = {
		prefix = "spider_medium",
		to = 46,
		from = 28
	},
	enemy_spider_death = {
		prefix = "spider_medium",
		to = 84,
		from = 70
	},
	enemy_spider_idle = {
		prefix = "spider_medium",
		to = 28,
		from = 28
	},
	enemy_spider_thorn = {
		prefix = "spider_medium",
		to = 65,
		from = 47
	},
	enemy_spider_thornFree = {
		prefix = "spider_medium",
		to = 70,
		from = 66
	},
	enemy_spider_walkingDown = {
		prefix = "spider_medium",
		to = 27,
		from = 19
	},
	enemy_spider_walkingRightLeft = {
		prefix = "spider_medium",
		to = 9,
		from = 1
	},
	enemy_spider_walkingUp = {
		prefix = "spider_medium",
		to = 18,
		from = 10
	},
	enemy_spider_egg_start = {
		prefix = "spider_egg",
		to = 89,
		from = 1
	},
	enemy_spider_egg_idle = {
		prefix = "spider_egg",
		to = 89,
		from = 89
	},
	spider_explode_small = {
		prefix = "states_small",
		to = 58,
		from = 49
	},
	spider_explode_big = {
		prefix = "states_big",
		to = 58,
		from = 49
	},
	enemy_brigand_attack = {
		prefix = "brigand",
		to = 80,
		from = 67
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
	enemy_brigand_thorn = {
		prefix = "brigand",
		to = 99,
		from = 81
	},
	enemy_brigand_thornFree = {
		prefix = "brigand",
		to = 104,
		from = 100
	},
	enemy_brigand_walkingDown = {
		prefix = "brigand",
		to = 66,
		from = 45
	},
	enemy_brigand_walkingRightLeft = {
		prefix = "brigand",
		to = 22,
		from = 1
	},
	enemy_brigand_walkingUp = {
		prefix = "brigand",
		to = 44,
		from = 23
	},
	enemy_dark_knight_attack = {
		prefix = "darkKnight",
		to = 78,
		from = 67
	},
	enemy_dark_knight_death = {
		prefix = "darkKnight",
		to = 109,
		from = 102
	},
	enemy_dark_knight_idle = {
		prefix = "darkKnight",
		to = 67,
		from = 67
	},
	enemy_dark_knight_thorn = {
		prefix = "darkKnight",
		to = 97,
		from = 79
	},
	enemy_dark_knight_thornFree = {
		prefix = "darkKnight",
		to = 102,
		from = 98
	},
	enemy_dark_knight_walkingDown = {
		prefix = "darkKnight",
		to = 66,
		from = 45
	},
	enemy_dark_knight_walkingRightLeft = {
		prefix = "darkKnight",
		to = 22,
		from = 1
	},
	enemy_dark_knight_walkingUp = {
		prefix = "darkKnight",
		to = 44,
		from = 23
	},
	enemy_marauder_attack = {
		prefix = "marauder",
		to = 79,
		from = 67
	},
	enemy_marauder_death = {
		prefix = "marauder",
		to = 121,
		from = 114
	},
	enemy_marauder_idle = {
		prefix = "marauder",
		to = 67,
		from = 67
	},
	enemy_marauder_thorn = {
		prefix = "marauder",
		to = 99,
		from = 81
	},
	enemy_marauder_thornFree = {
		prefix = "marauder",
		to = 104,
		from = 100
	},
	enemy_marauder_walkingDown = {
		prefix = "marauder",
		to = 66,
		from = 45
	},
	enemy_marauder_walkingRightLeft = {
		prefix = "marauder",
		to = 22,
		from = 1
	},
	enemy_marauder_walkingUp = {
		prefix = "marauder",
		to = 44,
		from = 23
	},
	enemy_bandit_attack = {
		to = 74,
		from = 68,
		prefix = "bandit",
		post = {
			74,
			74,
			74
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
	enemy_bandit_thorn = {
		prefix = "bandit",
		to = 93,
		from = 75
	},
	enemy_bandit_thornFree = {
		prefix = "bandit",
		to = 98,
		from = 94
	},
	enemy_bandit_walkingDown = {
		prefix = "bandit",
		to = 66,
		from = 45
	},
	enemy_bandit_walkingRightLeft = {
		prefix = "bandit",
		to = 22,
		from = 1
	},
	enemy_bandit_walkingUp = {
		prefix = "bandit",
		to = 44,
		from = 23
	},
	enemy_spider_small_attack = {
		prefix = "spider_small",
		to = 46,
		from = 28
	},
	enemy_spider_small_death = {
		prefix = "spider_small",
		to = 84,
		from = 70
	},
	enemy_spider_small_idle = {
		prefix = "spider_small",
		to = 28,
		from = 28
	},
	enemy_spider_small_thorn = {
		prefix = "spider_small",
		to = 65,
		from = 47
	},
	enemy_spider_small_thornFree = {
		prefix = "spider_small",
		to = 70,
		from = 66
	},
	enemy_spider_small_walkingDown = {
		prefix = "spider_small",
		to = 27,
		from = 19
	},
	enemy_spider_small_walkingRightLeft = {
		prefix = "spider_small",
		to = 9,
		from = 1
	},
	enemy_spider_small_walkingUp = {
		prefix = "spider_small",
		to = 18,
		from = 10
	},
	enemy_slayer_attack = {
		prefix = "darkSlayer",
		to = 85,
		from = 67
	},
	enemy_slayer_death = {
		prefix = "darkSlayer",
		to = 124,
		from = 110
	},
	enemy_slayer_idle = {
		prefix = "darkSlayer",
		to = 67,
		from = 67
	},
	enemy_slayer_thorn = {
		prefix = "darkSlayer",
		to = 88,
		from = 68
	},
	enemy_slayer_thornFree = {
		prefix = "darkSlayer",
		to = 110,
		from = 106
	},
	enemy_slayer_walkingDown = {
		prefix = "darkSlayer",
		to = 66,
		from = 45
	},
	enemy_slayer_walkingRightLeft = {
		prefix = "darkSlayer",
		to = 22,
		from = 1
	},
	enemy_slayer_walkingUp = {
		prefix = "darkSlayer",
		to = 44,
		from = 23
	},
	enemy_rocketeer_death = {
		prefix = "rocketeer",
		to = 66,
		from = 49
	},
	enemy_rocketeer_idle = {
		prefix = "rocketeer",
		to = 8,
		from = 1
	},
	enemy_rocketeer_walkingDown = {
		prefix = "rocketeer",
		to = 40,
		from = 33
	},
	enemy_rocketeer_walkingRightLeft = {
		prefix = "rocketeer",
		to = 8,
		from = 1
	},
	enemy_rocketeer_walkingUp = {
		prefix = "rocketeer",
		to = 24,
		from = 17
	},
	enemy_rocketeer_walkingDown_fast = {
		prefix = "rocketeer",
		to = 48,
		from = 41
	},
	enemy_rocketeer_walkingRightLeft_fast = {
		prefix = "rocketeer",
		to = 16,
		from = 9
	},
	enemy_rocketeer_walkingUp_fast = {
		prefix = "rocketeer",
		to = 32,
		from = 25
	},
	enemy_troll_attack = {
		prefix = "troll",
		to = 76,
		from = 67
	},
	enemy_troll_death = {
		prefix = "troll",
		to = 106,
		from = 101
	},
	enemy_troll_idle = {
		prefix = "troll",
		to = 67,
		from = 67
	},
	enemy_troll_thorn = {
		prefix = "troll",
		to = 95,
		from = 77
	},
	enemy_troll_thornFree = {
		prefix = "troll",
		to = 100,
		from = 96
	},
	enemy_troll_walkingDown = {
		prefix = "troll",
		to = 66,
		from = 45
	},
	enemy_troll_walkingRightLeft = {
		prefix = "troll",
		to = 22,
		from = 1
	},
	enemy_troll_walkingUp = {
		prefix = "troll",
		to = 44,
		from = 23
	},
	enemy_whitewolf_attack = {
		prefix = "winterwolf",
		to = 44,
		from = 31
	},
	enemy_whitewolf_death = {
		prefix = "winterwolf",
		to = 84,
		from = 69
	},
	enemy_whitewolf_idle = {
		prefix = "winterwolf",
		to = 31,
		from = 31
	},
	enemy_whitewolf_thorn = {
		prefix = "winterwolf",
		to = 63,
		from = 44
	},
	enemy_whitewolf_thornFree = {
		prefix = "winterwolf",
		to = 69,
		from = 65
	},
	enemy_whitewolf_walkingDown = {
		prefix = "winterwolf",
		to = 30,
		from = 21
	},
	enemy_whitewolf_walkingRightLeft = {
		prefix = "winterwolf",
		to = 10,
		from = 1
	},
	enemy_whitewolf_walkingUp = {
		prefix = "winterwolf",
		to = 20,
		from = 11
	},
	enemy_yeti_attack = {
		prefix = "yeti",
		to = 100,
		from = 73
	},
	enemy_yeti_death = {
		prefix = "yeti",
		to = 160,
		from = 126
	},
	enemy_yeti_idle = {
		prefix = "yeti",
		to = 73,
		from = 73
	},
	enemy_yeti_thorn = {
		prefix = "yeti",
		to = 93,
		from = 73
	},
	enemy_yeti_thornFree = {
		prefix = "yeti",
		to = 126,
		from = 122
	},
	enemy_yeti_walkingDown = {
		prefix = "yeti",
		to = 72,
		from = 50
	},
	enemy_yeti_walkingRightLeft = {
		prefix = "yeti",
		to = 25,
		from = 1
	},
	enemy_yeti_walkingUp = {
		prefix = "yeti",
		to = 49,
		from = 26
	},
	enemy_forest_troll_attack = {
		prefix = "forest_troll",
		to = 103,
		from = 73
	},
	enemy_forest_troll_death = {
		prefix = "forest_troll",
		to = 159,
		from = 126
	},
	enemy_forest_troll_idle = {
		prefix = "forest_troll",
		to = 73,
		from = 73
	},
	enemy_forest_troll_thorn = {
		prefix = "forest_troll",
		to = 92,
		from = 73
	},
	enemy_forest_troll_thornFree = {
		prefix = "forest_troll",
		to = 127,
		from = 122
	},
	enemy_forest_troll_walkingDown = {
		prefix = "forest_troll",
		to = 72,
		from = 50
	},
	enemy_forest_troll_walkingRightLeft = {
		prefix = "forest_troll",
		to = 25,
		from = 1
	},
	enemy_forest_troll_walkingUp = {
		prefix = "forest_troll",
		to = 49,
		from = 26
	},
	enemy_orc_armored_attack = {
		prefix = "orc_armored",
		to = 77,
		from = 67
	},
	enemy_orc_armored_death = {
		prefix = "orc_armored",
		to = 115,
		from = 102
	},
	enemy_orc_armored_idle = {
		prefix = "orc_armored",
		to = 67,
		from = 67
	},
	enemy_orc_armored_thorn = {
		prefix = "orc_armored",
		to = 96,
		from = 78
	},
	enemy_orc_armored_thornFree = {
		prefix = "orc_armored",
		to = 102,
		from = 97
	},
	enemy_orc_armored_walkingDown = {
		prefix = "orc_armored",
		to = 66,
		from = 45
	},
	enemy_orc_armored_walkingRightLeft = {
		prefix = "orc_armored",
		to = 22,
		from = 1
	},
	enemy_orc_armored_walkingUp = {
		prefix = "orc_armored",
		to = 44,
		from = 23
	},
	enemy_orc_rider_attack = {
		prefix = "orc_wolfrider",
		to = 44,
		from = 31
	},
	enemy_orc_rider_death = {
		prefix = "worg",
		to = 84,
		from = 69
	},
	enemy_orc_rider_idle = {
		prefix = "orc_wolfrider",
		to = 31,
		from = 31
	},
	enemy_orc_rider_thorn = {
		prefix = "orc_wolfrider",
		to = 50,
		from = 31
	},
	enemy_orc_rider_thornFree = {
		prefix = "orc_wolfrider",
		to = 69,
		from = 65
	},
	enemy_orc_rider_walkingDown = {
		prefix = "orc_wolfrider",
		to = 30,
		from = 21
	},
	enemy_orc_rider_walkingRightLeft = {
		prefix = "orc_wolfrider",
		to = 10,
		from = 1
	},
	enemy_orc_rider_walkingUp = {
		prefix = "orc_wolfrider",
		to = 20,
		from = 11
	},
	enemy_troll_axe_thrower_attack = {
		prefix = "troll_thrower",
		to = 97,
		from = 82
	},
	enemy_troll_axe_thrower_death = {
		prefix = "troll_thrower",
		to = 140,
		from = 124
	},
	enemy_troll_axe_thrower_idle = {
		prefix = "troll_thrower",
		to = 67,
		from = 67
	},
	enemy_troll_axe_thrower_shoot = {
		prefix = "troll_thrower",
		to = 82,
		from = 67
	},
	enemy_troll_axe_thrower_thorn = {
		prefix = "troll_thrower",
		to = 86,
		from = 67
	},
	enemy_troll_axe_thrower_thornFree = {
		prefix = "troll_thrower",
		to = 124,
		from = 120
	},
	enemy_troll_axe_thrower_walkingDown = {
		prefix = "troll_thrower",
		to = 66,
		from = 45
	},
	enemy_troll_axe_thrower_walkingRightLeft = {
		prefix = "troll_thrower",
		to = 22,
		from = 1
	},
	enemy_troll_axe_thrower_walkingUp = {
		prefix = "troll_thrower",
		to = 44,
		from = 23
	},
	enemy_raider_attack = {
		prefix = "Raider",
		to = 84,
		from = 70
	},
	enemy_raider_death = {
		prefix = "Raider",
		to = 150,
		from = 133
	},
	enemy_raider_idle = {
		prefix = "Raider",
		to = 67,
		from = 67
	},
	enemy_raider_shoot = {
		prefix = "Raider",
		to = 108,
		from = 85
	},
	enemy_raider_thorn = {
		prefix = "Raider",
		to = 86,
		from = 67
	},
	enemy_raider_thornFree = {
		prefix = "Raider",
		to = 133,
		from = 129
	},
	enemy_raider_walkingDown = {
		prefix = "Raider",
		to = 66,
		from = 45
	},
	enemy_raider_walkingRightLeft = {
		prefix = "Raider",
		to = 22,
		from = 1
	},
	enemy_raider_walkingUp = {
		prefix = "Raider",
		to = 44,
		from = 23
	},
	enemy_pillager_attack = {
		prefix = "Pillager",
		to = 103,
		from = 80
	},
	enemy_pillager_death = {
		prefix = "Pillager",
		to = 144,
		from = 127
	},
	enemy_pillager_idle = {
		prefix = "Pillager",
		to = 79,
		from = 79
	},
	enemy_pillager_thorn = {
		prefix = "Pillager",
		to = 122,
		from = 104
	},
	enemy_pillager_thornFree = {
		prefix = "Pillager",
		to = 127,
		from = 123
	},
	enemy_pillager_walkingDown = {
		prefix = "Pillager",
		to = 78,
		from = 53
	},
	enemy_pillager_walkingRightLeft = {
		prefix = "Pillager",
		to = 26,
		from = 1
	},
	enemy_pillager_walkingUp = {
		prefix = "Pillager",
		to = 52,
		from = 27
	},
	enemy_troll_brute_attack = {
		prefix = "troll_brute",
		to = 96,
		from = 68
	},
	enemy_troll_brute_death = {
		prefix = "troll_brute",
		to = 138,
		from = 120
	},
	enemy_troll_brute_idle = {
		prefix = "troll_brute",
		to = 67,
		from = 67
	},
	enemy_troll_brute_thorn = {
		prefix = "troll_brute",
		to = 115,
		from = 97
	},
	enemy_troll_brute_thornFree = {
		prefix = "troll_brute",
		to = 120,
		from = 116
	},
	enemy_troll_brute_walkingDown = {
		prefix = "troll_brute",
		to = 64,
		from = 45
	},
	enemy_troll_brute_walkingRightLeft = {
		prefix = "troll_brute",
		to = 22,
		from = 1
	},
	enemy_troll_brute_walkingUp = {
		prefix = "troll_brute",
		to = 44,
		from = 23
	},
	enemy_troll_chieftain_attack = {
		prefix = "troll_chieftain",
		to = 106,
		from = 79
	},
	enemy_troll_chieftain_death = {
		prefix = "troll_chieftain",
		to = 163,
		from = 145
	},
	enemy_troll_chieftain_idle = {
		prefix = "troll_chieftain",
		to = 79,
		from = 79
	},
	enemy_troll_chieftain_special = {
		prefix = "troll_chieftain",
		to = 121,
		from = 107
	},
	enemy_troll_chieftain_thorn = {
		prefix = "troll_chieftain",
		to = 140,
		from = 122
	},
	enemy_troll_chieftain_thornFree = {
		prefix = "troll_chieftain",
		to = 145,
		from = 141
	},
	enemy_troll_chieftain_walkingDown = {
		prefix = "troll_chieftain",
		to = 78,
		from = 53
	},
	enemy_troll_chieftain_walkingRightLeft = {
		prefix = "troll_chieftain",
		to = 26,
		from = 1
	},
	enemy_troll_chieftain_walkingUp = {
		prefix = "troll_chieftain",
		to = 52,
		from = 27
	},
	enemy_golem_head_attack = {
		prefix = "golemHead",
		to = 63,
		from = 45
	},
	enemy_golem_head_death = {
		prefix = "golemHead",
		to = 100,
		from = 89
	},
	enemy_golem_head_idle = {
		prefix = "golemHead",
		to = 45,
		from = 45
	},
	enemy_golem_head_thorn = {
		prefix = "golemHead",
		to = 65,
		from = 46
	},
	enemy_golem_head_thornFree = {
		prefix = "golemHead",
		to = 88,
		from = 84
	},
	enemy_golem_head_walkingRightLeft = {
		prefix = "golemHead",
		to = 13,
		from = 1
	},
	enemy_golem_head_walkingUp = {
		prefix = "golemHead",
		to = 44,
		from = 23
	},
	enemy_goblin_zapper_attack = {
		prefix = "goblin_zapper",
		to = 102,
		from = 81
	},
	enemy_goblin_zapper_death = {
		prefix = "goblin_zapper",
		to = 142,
		from = 125
	},
	enemy_goblin_zapper_idle = {
		prefix = "goblin_zapper",
		to = 67,
		from = 67
	},
	enemy_goblin_zapper_shoot = {
		prefix = "goblin_zapper",
		to = 81,
		from = 67
	},
	enemy_goblin_zapper_thorn = {
		prefix = "goblin_zapper",
		to = 120,
		from = 102
	},
	enemy_goblin_zapper_thornFree = {
		prefix = "goblin_zapper",
		to = 125,
		from = 121
	},
	enemy_goblin_zapper_walkingDown = {
		prefix = "goblin_zapper",
		to = 66,
		from = 45
	},
	enemy_goblin_zapper_walkingRightLeft = {
		prefix = "goblin_zapper",
		to = 22,
		from = 1
	},
	enemy_goblin_zapper_walkingUp = {
		prefix = "goblin_zapper",
		to = 44,
		from = 23
	},
	enemy_demon_attack = {
		prefix = "demonEvil",
		to = 76,
		from = 67
	},
	enemy_demon_death = {
		prefix = "demonDeath_small",
		to = 12,
		from = 1
	},
	enemy_demon_idle = {
		prefix = "demonEvil",
		to = 67,
		from = 67
	},
	enemy_demon_thorn = {
		prefix = "demonEvil",
		to = 95,
		from = 77
	},
	enemy_demon_thornFree = {
		prefix = "demonEvil",
		to = 100,
		from = 96
	},
	enemy_demon_walkingDown = {
		prefix = "demonEvil",
		to = 66,
		from = 45
	},
	enemy_demon_walkingRightLeft = {
		prefix = "demonEvil",
		to = 22,
		from = 1
	},
	enemy_demon_walkingUp = {
		prefix = "demonEvil",
		to = 44,
		from = 23
	},
	enemy_demon_mage_attack = {
		prefix = "demonMage",
		to = 86,
		from = 67
	},
	enemy_demon_mage_death = {
		prefix = "demonDeath_big",
		to = 12,
		from = 1
	},
	enemy_demon_mage_idle = {
		prefix = "demonMage",
		to = 67,
		from = 67
	},
	enemy_demon_mage_special = {
		prefix = "demonMage",
		to = 114,
		from = 87
	},
	enemy_demon_mage_thorn = {
		prefix = "demonMage",
		to = 133,
		from = 115
	},
	enemy_demon_mage_thornFree = {
		prefix = "demonMage",
		to = 138,
		from = 134
	},
	enemy_demon_mage_walkingDown = {
		prefix = "demonMage",
		to = 66,
		from = 45
	},
	enemy_demon_mage_walkingRightLeft = {
		prefix = "demonMage",
		to = 22,
		from = 1
	},
	enemy_demon_mage_walkingUp = {
		prefix = "demonMage",
		to = 44,
		from = 23
	},
	enemy_demon_wolf_attack = {
		prefix = "demonWolf",
		to = 45,
		from = 31
	},
	enemy_demon_wolf_death = {
		prefix = "demonDeath_small",
		to = 12,
		from = 1
	},
	enemy_demon_wolf_idle = {
		prefix = "demonWolf",
		to = 44,
		from = 44
	},
	enemy_demon_wolf_thorn = {
		prefix = "demonWolf",
		to = 64,
		from = 46
	},
	enemy_demon_wolf_thornFree = {
		prefix = "demonWolf",
		to = 69,
		from = 65
	},
	enemy_demon_wolf_walkingDown = {
		prefix = "demonWolf",
		to = 30,
		from = 21
	},
	enemy_demon_wolf_walkingRightLeft = {
		prefix = "demonWolf",
		to = 10,
		from = 1
	},
	enemy_demon_wolf_walkingUp = {
		prefix = "demonWolf",
		to = 20,
		from = 11
	},
	enemy_demon_imp_death = {
		prefix = "demonFlying",
		to = 54,
		from = 43
	},
	enemy_demon_imp_idle = {
		prefix = "demonFlying",
		to = 14,
		from = 1
	},
	enemy_demon_imp_walkingDown = {
		prefix = "demonFlying",
		to = 42,
		from = 29
	},
	enemy_demon_imp_walkingRightLeft = {
		prefix = "demonFlying",
		to = 14,
		from = 1
	},
	enemy_demon_imp_walkingUp = {
		prefix = "demonFlying",
		to = 28,
		from = 15
	},
	enemy_lava_elemental_attack = {
		prefix = "lavaElemental",
		to = 102,
		from = 73
	},
	enemy_lava_elemental_death = {
		prefix = "lavaElemental",
		to = 155,
		from = 126
	},
	enemy_lava_elemental_idle = {
		prefix = "lavaElemental",
		to = 73,
		from = 73
	},
	enemy_lava_elemental_raise = {
		prefix = "lavaElemental",
		to = 182,
		from = 156
	},
	enemy_lava_elemental_thorn = {
		prefix = "lavaElemental",
		to = 121,
		from = 103
	},
	enemy_lava_elemental_thornFree = {
		prefix = "lavaElemental",
		to = 125,
		from = 122
	},
	enemy_lava_elemental_walkingDown = {
		prefix = "lavaElemental",
		to = 72,
		from = 50
	},
	enemy_lava_elemental_walkingRightLeft = {
		prefix = "lavaElemental",
		to = 25,
		from = 1
	},
	enemy_lava_elemental_walkingUp = {
		prefix = "lavaElemental",
		to = 49,
		from = 26
	},
	enemy_sarelgaz_small_attack = {
		prefix = "spider_sonofsarelgaz",
		to = 58,
		from = 40
	},
	enemy_sarelgaz_small_death = {
		prefix = "spider_sonofsarelgaz",
		to = 102,
		from = 88
	},
	enemy_sarelgaz_small_idle = {
		prefix = "spider_sonofsarelgaz",
		to = 40,
		from = 40
	},
	enemy_sarelgaz_small_thorn = {
		prefix = "spider_sonofsarelgaz",
		to = 59,
		from = 40
	},
	enemy_sarelgaz_small_thornFree = {
		prefix = "spider_sonofsarelgaz",
		to = 88,
		from = 84
	},
	enemy_sarelgaz_small_walkingDown = {
		prefix = "spider_sonofsarelgaz",
		to = 39,
		from = 27
	},
	enemy_sarelgaz_small_walkingRightLeft = {
		prefix = "spider_sonofsarelgaz",
		to = 13,
		from = 1
	},
	enemy_sarelgaz_small_walkingUp = {
		prefix = "spider_sonofsarelgaz",
		to = 26,
		from = 14
	},
	enemy_rotten_lesser_attack = {
		prefix = "mushroom",
		to = 49,
		from = 34
	},
	enemy_rotten_lesser_death = {
		prefix = "mushroom",
		to = 122,
		from = 107
	},
	enemy_rotten_lesser_idle = {
		prefix = "mushroom",
		to = 1,
		from = 1
	},
	enemy_rotten_lesser_thorn = {
		prefix = "mushroom",
		to = 102,
		from = 84
	},
	enemy_rotten_lesser_thornFree = {
		prefix = "mushroom",
		to = 106,
		from = 103
	},
	enemy_rotten_lesser_walkingDown = {
		prefix = "mushroom",
		to = 33,
		from = 18
	},
	enemy_rotten_lesser_walkingRightLeft = {
		prefix = "mushroom",
		to = 17,
		from = 2
	},
	enemy_rotten_lesser_walkingUp = {
		prefix = "mushroom",
		to = 17,
		from = 2
	},
	enemy_rotten_lesser_raise = {
		prefix = "mushroom",
		to = 83,
		from = 50
	},
	enemy_swamp_thing_attack = {
		prefix = "rotten_thing",
		to = 102,
		from = 72
	},
	enemy_swamp_thing_death = {
		prefix = "rotten_thing",
		to = 179,
		from = 151
	},
	enemy_swamp_thing_idle = {
		prefix = "rotten_thing",
		to = 73,
		from = 73
	},
	enemy_swamp_thing_shoot = {
		to = 127,
		from = 102,
		prefix = "rotten_thing",
		post = {
			127
		}
	},
	enemy_swamp_thing_thorn = {
		prefix = "rotten_thing",
		to = 146,
		from = 128
	},
	enemy_swamp_thing_thornFree = {
		prefix = "rotten_thing",
		to = 151,
		from = 147
	},
	enemy_swamp_thing_walkingDown = {
		prefix = "rotten_thing",
		to = 71,
		from = 49
	},
	enemy_swamp_thing_walkingRightLeft = {
		prefix = "rotten_thing",
		to = 24,
		from = 1
	},
	enemy_swamp_thing_walkingUp = {
		prefix = "rotten_thing",
		to = 47,
		from = 25
	},
	enemy_swamp_thing_raise = {
		prefix = "rotten_thing",
		to = 213,
		from = 180
	},
	enemy_spider_rotten_tiny_attack = {
		prefix = "rotten_spider_tiny",
		to = 46,
		from = 28
	},
	enemy_spider_rotten_tiny_death = {
		prefix = "rotten_spider_tiny",
		to = 84,
		from = 70
	},
	enemy_spider_rotten_tiny_idle = {
		prefix = "rotten_spider_tiny",
		to = 28,
		from = 28
	},
	enemy_spider_rotten_tiny_thorn = {
		prefix = "rotten_spider_tiny",
		to = 65,
		from = 47
	},
	enemy_spider_rotten_tiny_thornFree = {
		prefix = "rotten_spider_tiny",
		to = 70,
		from = 66
	},
	enemy_spider_rotten_tiny_walkingDown = {
		prefix = "rotten_spider_tiny",
		to = 27,
		from = 19
	},
	enemy_spider_rotten_tiny_walkingRightLeft = {
		prefix = "rotten_spider_tiny",
		to = 9,
		from = 1
	},
	enemy_spider_rotten_tiny_walkingUp = {
		prefix = "rotten_spider_tiny",
		to = 18,
		from = 10
	},
	enemy_spider_rotten_attack = {
		prefix = "rotten_spider",
		to = 58,
		from = 40
	},
	enemy_spider_rotten_death = {
		prefix = "rotten_spider",
		to = 96,
		from = 82
	},
	enemy_spider_rotten_idle = {
		prefix = "rotten_spider",
		to = 40,
		from = 40
	},
	enemy_spider_rotten_thorn = {
		prefix = "rotten_spider",
		to = 77,
		from = 59
	},
	enemy_spider_rotten_thornFree = {
		prefix = "rotten_spider",
		to = 82,
		from = 78
	},
	enemy_spider_rotten_walkingDown = {
		prefix = "rotten_spider",
		to = 39,
		from = 27
	},
	enemy_spider_rotten_walkingRightLeft = {
		prefix = "rotten_spider",
		to = 13,
		from = 1
	},
	enemy_spider_rotten_walkingUp = {
		prefix = "rotten_spider",
		to = 26,
		from = 14
	},
	enemy_spider_rotten_egg_start = {
		prefix = "rotten_egg",
		to = 89,
		from = 1
	},
	enemy_spider_rotten_egg_idle = {
		prefix = "rotten_egg",
		to = 89,
		from = 89
	},
	enemy_rotten_tree_attack = {
		prefix = "rotten_treant",
		to = 70,
		from = 49
	},
	enemy_rotten_tree_death = {
		prefix = "rotten_treant",
		to = 136,
		from = 127
	},
	enemy_rotten_tree_idle = {
		prefix = "rotten_treant",
		to = 49,
		from = 49
	},
	enemy_rotten_tree_thorn = {
		prefix = "rotten_treant",
		to = 86,
		from = 71
	},
	enemy_rotten_tree_thornFree = {
		prefix = "rotten_treant",
		to = 91,
		from = 87
	},
	enemy_rotten_tree_walkingDown = {
		prefix = "rotten_treant",
		to = 46,
		from = 33
	},
	enemy_rotten_tree_walkingRightLeft = {
		prefix = "rotten_treant",
		to = 16,
		from = 1
	},
	enemy_rotten_tree_walkingUp = {
		prefix = "rotten_treant",
		to = 32,
		from = 17
	},
	enemy_rotten_tree_raise = {
		prefix = "rotten_treant",
		to = 126,
		from = 91
	},
	enemy_giant_rat_attack = {
		prefix = "CB_Rat",
		to = 42,
		from = 25
	},
	enemy_giant_rat_death = {
		prefix = "CB_Rat",
		to = 66,
		from = 43
	},
	enemy_giant_rat_idle = {
		prefix = "CB_Rat",
		to = 47,
		from = 47
	},
	enemy_giant_rat_thorn = {
		prefix = "CB_Rat",
		to = 85,
		from = 67
	},
	enemy_giant_rat_thornFree = {
		prefix = "CB_Rat",
		to = 89,
		from = 86
	},
	enemy_giant_rat_walkingDown = {
		prefix = "CB_Rat",
		to = 16,
		from = 9
	},
	enemy_giant_rat_walkingRightLeft = {
		prefix = "CB_Rat",
		to = 8,
		from = 1
	},
	enemy_giant_rat_walkingUp = {
		prefix = "CB_Rat",
		to = 24,
		from = 17
	},
	enemy_giant_rat_raise = {
		prefix = "CB_Rat",
		to = 104,
		from = 90
	},
	enemy_wererat_attack = {
		prefix = "CB_Ratman",
		to = 60,
		from = 43
	},
	enemy_wererat_death = {
		prefix = "CB_Ratman",
		to = 83,
		from = 61
	},
	enemy_wererat_idle = {
		prefix = "CB_Ratman",
		to = 60,
		from = 60
	},
	enemy_wererat_thorn = {
		prefix = "CB_Ratman",
		to = 102,
		from = 84
	},
	enemy_wererat_thornFree = {
		prefix = "CB_Ratman",
		to = 106,
		from = 103
	},
	enemy_wererat_walkingDown = {
		prefix = "CB_Ratman",
		to = 28,
		from = 15
	},
	enemy_wererat_walkingRightLeft = {
		prefix = "CB_Ratman",
		to = 14,
		from = 1
	},
	enemy_wererat_walkingUp = {
		prefix = "CB_Ratman",
		to = 42,
		from = 29
	},
	-- enemy_abomination_idle = {
	-- 	prefix = "CB_Abomination",
	-- 	to = 85,
	-- 	from = 85
	-- },
	-- enemy_abomination_walkingRightLeft = {
	-- 	prefix = "CB_Abomination",
	-- 	to = 28,
	-- 	from = 1
	-- },
	-- enemy_abomination_walkingUp = {
	-- 	prefix = "CB_Abomination",
	-- 	to = 56,
	-- 	from = 29
	-- },
	-- enemy_abomination_walkingDown = {
	-- 	prefix = "CB_Abomination",
	-- 	to = 84,
	-- 	from = 57
	-- },
	-- enemy_abomination_attack = {
	-- 	prefix = "CB_Abomination",
	-- 	to = 116,
	-- 	from = 86
	-- },
	-- enemy_abomination_death = {
	-- 	prefix = "CB_Abomination",
	-- 	to = 144,
	-- 	from = 117
	-- },
	-- enemy_werewolf_idle = {
	-- 	prefix = "CB_Werewolf",
	-- 	to = 1,
	-- 	from = 1
	-- },
	-- enemy_werewolf_walkingRightLeft = {
	-- 	prefix = "CB_Werewolf",
	-- 	to = 34,
	-- 	from = 21
	-- },
	-- enemy_werewolf_walkingUp = {
	-- 	prefix = "CB_Werewolf",
	-- 	to = 48,
	-- 	from = 35
	-- },
	-- enemy_werewolf_walkingDown = {
	-- 	prefix = "CB_Werewolf",
	-- 	to = 62,
	-- 	from = 49
	-- },
	-- enemy_werewolf_attack = {
	-- 	prefix = "CB_Werewolf",
	-- 	to = 20,
	-- 	from = 2
	-- },
	-- enemy_werewolf_death = {
	-- 	prefix = "CB_Werewolf",
	-- 	to = 91,
	-- 	from = 63
	-- },
	-- enemy_werewolf_raise = {
	-- 	prefix = "CB_Werewolf",
	-- 	to = 126,
	-- 	from = 92
	-- },
	-- enemy_halloween_zombie_idle = {
	-- 	prefix = "CB_Zombie",
	-- 	to = 72,
	-- 	from = 72
	-- },
	-- enemy_halloween_zombie_walkingRightLeft = {
	-- 	prefix = "CB_Zombie",
	-- 	to = 23,
	-- 	from = 1
	-- },
	-- enemy_halloween_zombie_walkingUp = {
	-- 	prefix = "CB_Zombie",
	-- 	to = 47,
	-- 	from = 24
	-- },
	-- enemy_halloween_zombie_walkingDown = {
	-- 	prefix = "CB_Zombie",
	-- 	to = 71,
	-- 	from = 48
	-- },
	-- enemy_halloween_zombie_attack = {
	-- 	prefix = "CB_Zombie",
	-- 	to = 93,
	-- 	from = 73
	-- },
	-- enemy_halloween_zombie_death = {
	-- 	prefix = "CB_Zombie",
	-- 	to = 114,
	-- 	from = 94
	-- },
	-- enemy_halloween_zombie_raise = {
	-- 	prefix = "CB_Zombie",
	-- 	to = 148,
	-- 	from = 115
	-- },
	-- enemy_lycan_idle = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 67,
	-- 	from = 67
	-- },
	-- enemy_lycan_walkingRightLeft = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 22,
	-- 	from = 1
	-- },
	-- enemy_lycan_walkingUp = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 44,
	-- 	from = 23
	-- },
	-- enemy_lycan_walkingDown = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 66,
	-- 	from = 45
	-- },
	-- enemy_lycan_attack = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 86,
	-- 	from = 68
	-- },
	-- enemy_lycan_death = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 215,
	-- 	from = 181
	-- },
	-- enemy_lycan_werewolf_idle = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 114,
	-- 	from = 114
	-- },
	-- enemy_lycan_werewolf_walkingRightLeft = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 128,
	-- 	from = 115
	-- },
	-- enemy_lycan_werewolf_walkingUp = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 142,
	-- 	from = 129
	-- },
	-- enemy_lycan_werewolf_walkingDown = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 156,
	-- 	from = 143
	-- },
	-- enemy_lycan_werewolf_attack = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 180,
	-- 	from = 157
	-- },
	-- enemy_lycan_werewolf_death = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 215,
	-- 	from = 181
	-- },
	-- enemy_lycan_werewolf_raise = {
	-- 	prefix = "CB_Lycan",
	-- 	to = 113,
	-- 	from = 87
	-- },
	enemy_skeleton_attack = {
		prefix = "enemy_skeleton",
		to = 67,
		from = 48
	},
	enemy_skeleton_death = {
		prefix = "enemy_skeleton",
		to = 113,
		from = 93
	},
	enemy_skeleton_idle = {
		prefix = "enemy_skeleton",
		to = 48,
		from = 48
	},
	enemy_skeleton_thorn = {
		prefix = "enemy_skeleton",
		to = 87,
		from = 67
	},
	enemy_skeleton_thornFree = {
		prefix = "enemy_skeleton",
		to = 93,
		from = 89
	},
	enemy_skeleton_walkingDown = {
		prefix = "enemy_skeleton",
		to = 47,
		from = 33
	},
	enemy_skeleton_walkingRightLeft = {
		prefix = "enemy_skeleton",
		to = 16,
		from = 1
	},
	enemy_skeleton_walkingUp = {
		prefix = "enemy_skeleton",
		to = 32,
		from = 17
	},
	enemy_skeleton_raise = {
		prefix = "enemy_skeleton",
		to = 146,
		from = 114
	},
	enemy_skeleton_big_attack = {
		prefix = "enemy_skeleton_warrior",
		to = 67,
		from = 48
	},
	enemy_skeleton_big_death = {
		prefix = "enemy_skeleton_warrior",
		to = 113,
		from = 93
	},
	enemy_skeleton_big_idle = {
		prefix = "enemy_skeleton_warrior",
		to = 48,
		from = 48
	},
	enemy_skeleton_big_thorn = {
		prefix = "enemy_skeleton_warrior",
		to = 67,
		from = 48
	},
	enemy_skeleton_big_thornFree = {
		prefix = "enemy_skeleton_warrior",
		to = 93,
		from = 89
	},
	enemy_skeleton_big_walkingDown = {
		prefix = "enemy_skeleton_warrior",
		to = 47,
		from = 33
	},
	enemy_skeleton_big_walkingRightLeft = {
		prefix = "enemy_skeleton_warrior",
		to = 16,
		from = 1
	},
	enemy_skeleton_big_walkingUp = {
		prefix = "enemy_skeleton_warrior",
		to = 32,
		from = 17
	},
	enemy_skeleton_big_raise = {
		prefix = "enemy_skeleton_warrior",
		to = 146,
		from = 114
	},
	enemy_zombie_attack = {
		prefix = "rotten_zombie",
		to = 93,
		from = 72
	},
	enemy_zombie_death = {
		prefix = "rotten_zombie",
		to = 137,
		from = 117
	},
	enemy_zombie_idle = {
		prefix = "rotten_zombie",
		to = 72,
		from = 72
	},
	enemy_zombie_thorn = {
		prefix = "rotten_zombie",
		to = 112,
		from = 94
	},
	enemy_zombie_thornFree = {
		prefix = "rotten_zombie",
		to = 117,
		from = 113
	},
	enemy_zombie_walkingDown = {
		prefix = "rotten_zombie",
		to = 71,
		from = 48
	},
	enemy_zombie_walkingRightLeft = {
		prefix = "rotten_zombie",
		to = 23,
		from = 1
	},
	enemy_zombie_walkingUp = {
		prefix = "rotten_zombie",
		to = 47,
		from = 24
	},
	enemy_zombie_raise = {
		prefix = "rotten_zombie",
		to = 170,
		from = 138
	},
	enemy_demon_flareon_attack = {
		prefix = "Inferno_Flareon",
		to = 102,
		from = 74
	},
	enemy_demon_flareon_death = {
		prefix = "demonDeath_small",
		to = 12,
		from = 1
	},
	enemy_demon_flareon_idle = {
		prefix = "Inferno_Flareon",
		to = 138,
		from = 126
	},
	enemy_demon_flareon_walkingDown = {
		prefix = "Inferno_Flareon",
		to = 36,
		from = 25
	},
	enemy_demon_flareon_walkingRightLeft = {
		prefix = "Inferno_Flareon",
		to = 12,
		from = 1
	},
	enemy_demon_flareon_walkingUp = {
		prefix = "Inferno_Flareon",
		to = 24,
		from = 13
	},
	enemy_demon_flareon_shoot = {
		prefix = "Inferno_Flareon",
		to = 73,
		from = 38
	},
	demon_flareon_flare = {
		prefix = "Inferno_Flareon_proy",
		to = 12,
		from = 1
	},
	enemy_demon_legion_attack = {
		prefix = "Inferno_Legion",
		to = 123,
		from = 96
	},
	enemy_demon_legion_death = {
		prefix = "Inferno_Legion",
		to = 237,
		from = 220
	},
	enemy_demon_legion_idle = {
		prefix = "Inferno_Legion",
		to = 93,
		from = 75
	},
	enemy_demon_legion_walkingDown = {
		prefix = "Inferno_Legion",
		to = 48,
		from = 25
	},
	enemy_demon_legion_walkingRightLeft = {
		prefix = "Inferno_Legion",
		to = 24,
		from = 1
	},
	enemy_demon_legion_walkingUp = {
		prefix = "Inferno_Legion",
		to = 72,
		from = 49
	},
	enemy_demon_legion_summon = {
		prefix = "Inferno_Legion",
		to = 162,
		from = 124
	},
	enemy_demon_legion_raise = {
		prefix = "Inferno_Legion",
		to = 194,
		from = 163
	},
	enemy_demon_gulaemon_attack = {
		prefix = "Inferno_FatDemon",
		to = 145,
		from = 130
	},
	enemy_demon_gulaemon_death = {
		prefix = "Inferno_FatDemon",
		to = 161,
		from = 146
	},
	enemy_demon_gulaemon_idle = {
		prefix = "Inferno_FatDemon",
		to = 73,
		from = 73
	},
	enemy_demon_gulaemon_walkingDown = {
		prefix = "Inferno_FatDemon",
		to = 48,
		from = 25
	},
	enemy_demon_gulaemon_walkingRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 24,
		from = 1
	},
	enemy_demon_gulaemon_walkingUp = {
		prefix = "Inferno_FatDemon",
		to = 72,
		from = 49
	},
	enemy_demon_gulaemon_fly_initFlyRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 77,
		from = 74
	},
	enemy_demon_gulaemon_fly_endFlyRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 91,
		from = 86
	},
	enemy_demon_gulaemon_fly_initFlyDown = {
		prefix = "Inferno_FatDemon",
		to = 96,
		from = 93
	},
	enemy_demon_gulaemon_fly_endFlyDown = {
		prefix = "Inferno_FatDemon",
		to = 110,
		from = 105
	},
	enemy_demon_gulaemon_fly_initFlyUp = {
		prefix = "Inferno_FatDemon",
		to = 115,
		from = 112
	},
	enemy_demon_gulaemon_fly_endFlyUp = {
		prefix = "Inferno_FatDemon",
		to = 129,
		from = 124
	},
	enemy_demon_gulaemon_fly_death = {
		prefix = "Inferno_FatDemon",
		to = 177,
		from = 162
	},
	enemy_demon_gulaemon_fly_idle = {
		prefix = "Inferno_FatDemon",
		to = 85,
		from = 78
	},
	enemy_demon_gulaemon_fly_walkingDown = {
		prefix = "Inferno_FatDemon",
		to = 104,
		from = 97
	},
	enemy_demon_gulaemon_fly_walkingRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 85,
		from = 78
	},
	enemy_demon_gulaemon_fly_walkingUp = {
		prefix = "Inferno_FatDemon",
		to = 123,
		from = 116
	},
	enemy_necromancer_attack = {
		prefix = "necromancer",
		to = 91,
		from = 74
	},
	enemy_necromancer_death = {
		prefix = "necromancer",
		to = 200,
		from = 187
	},
	enemy_necromancer_idle = {
		prefix = "necromancer",
		to = 72,
		from = 72
	},
	enemy_necromancer_shoot = {
		prefix = "necromancer",
		to = 115,
		from = 92
	},
	enemy_necromancer_summon = {
		prefix = "necromancer",
		to = 163,
		from = 117
	},
	enemy_necromancer_thorn = {
		prefix = "necromancer",
		to = 182,
		from = 164
	},
	enemy_necromancer_thornFree = {
		prefix = "necromancer",
		to = 187,
		from = 183
	},
	enemy_necromancer_walkingDown = {
		prefix = "necromancer",
		to = 70,
		from = 49
	},
	enemy_necromancer_walkingRightLeft = {
		prefix = "necromancer",
		to = 24,
		from = 1
	},
	enemy_necromancer_walkingUp = {
		prefix = "necromancer",
		to = 48,
		from = 25
	},
	bolt_necromancer_enemy_idle = {
		prefix = "necromancer_bolt",
		to = 2,
		from = 1
	},
	bolt_necromancer_enemy_flying = {
		prefix = "necromancer_bolt",
		to = 2,
		from = 1
	},
	bolt_necromancer_enemy_hit = {
		prefix = "necromancer_bolt",
		to = 10,
		from = 3
	},
	enemy_demon_cerberus_attack = {
		prefix = "Inferno_Cerberus",
		to = 60,
		from = 44
	},
	enemy_demon_cerberus_death = {
		prefix = "Inferno_Cerberus",
		to = 92,
		from = 77
	},
	enemy_demon_cerberus_idle = {
		prefix = "Inferno_Cerberus",
		to = 43,
		from = 43
	},
	enemy_demon_cerberus_raise = {
		prefix = "Inferno_Cerberus",
		to = 189,
		from = 130
	},
	enemy_demon_cerberus_sleeping = {
		prefix = "Inferno_Cerberus",
		to = 129,
		from = 94
	},
	enemy_demon_cerberus_walkingDown = {
		prefix = "Inferno_Cerberus",
		to = 42,
		from = 29
	},
	enemy_demon_cerberus_walkingRightLeft = {
		prefix = "Inferno_Cerberus",
		to = 14,
		from = 1
	},
	enemy_demon_cerberus_walkingUp = {
		prefix = "Inferno_Cerberus",
		to = 28,
		from = 15
	},
	enemy_witch_shoot = {
		prefix = "CB_Witch",
		to = 89,
		from = 55
	},
	enemy_witch_death = {
		prefix = "CB_Witch",
		to = 104,
		from = 90
	},
	enemy_witch_idle = {
		prefix = "CB_Witch",
		to = 18,
		from = 1
	},
	enemy_witch_walkingDown = {
		prefix = "CB_Witch",
		to = 54,
		from = 37
	},
	enemy_witch_walkingRightLeft = {
		prefix = "CB_Witch",
		to = 18,
		from = 1
	},
	enemy_witch_walkingUp = {
		prefix = "CB_Witch",
		to = 36,
		from = 19
	},
	bolt_witch_idle = {
		prefix = "CB_Witch_proy",
		to = 1,
		from = 1
	},
	bolt_witch_flying = {
		prefix = "CB_Witch_proy",
		to = 1,
		from = 1
	},
	fx_bolt_witch_hit = {
		prefix = "CB_Witch_explosion",
		to = 19,
		from = 1
	},
	mod_witch_frog_idle = {
		prefix = "CB_Witch_frog",
		to = 19,
		from = 19
	},
	mod_witch_frog_jump = {
		prefix = "CB_Witch_frog",
		to = 30,
		from = 20
	},
	mod_witch_frog_puff = {
		prefix = "CB_Witch_frog",
		to = 50,
		from = 31
	},
	enemy_spectral_knight_attack = {
		prefix = "CB_DeathKnight",
		to = 221,
		from = 200
	},
	enemy_spectral_knight_death = {
		prefix = "CB_DeathKnight",
		to = 246,
		from = 222
	},
	enemy_spectral_knight_idle = {
		prefix = "CB_DeathKnight",
		to = 163,
		from = 146
	},
	enemy_spectral_knight_raise = {
		prefix = "CB_DeathKnight",
		to = 145,
		from = 105
	},
	enemy_spectral_knight_walkingDown = {
		prefix = "CB_DeathKnight",
		to = 199,
		from = 182
	},
	enemy_spectral_knight_walkingRightLeft = {
		prefix = "CB_DeathKnight",
		to = 163,
		from = 146
	},
	enemy_spectral_knight_walkingUp = {
		prefix = "CB_DeathKnight",
		to = 181,
		from = 164
	},
	spectral_knight_aura = {
		prefix = "CB_DeathKnight_aura",
		to = 30,
		from = 1
	},
	spectral_knight_aura_fx = {
		prefix = "CB_DeathKnight_aura",
		to = 1,
		from = 1
	},
	mod_spectral_knight_fx = {
		prefix = "CB_DeathKnight_buffedFx",
		to = 16,
		from = 1
	},
	enemy_fallen_knight_attack = {
		prefix = "CB_DeathKnight",
		to = 25,
		from = 1
	},
	enemy_fallen_knight_death = {
		prefix = "CB_DeathKnight",
		to = 104,
		from = 93
	},
	enemy_fallen_knight_idle = {
		prefix = "CB_DeathKnight",
		to = 26,
		from = 26
	},
	enemy_fallen_knight_raise = {
		prefix = "CB_DeathKnight",
		to = 145,
		from = 105
	},
	enemy_fallen_knight_walkingDown = {
		prefix = "CB_DeathKnight",
		to = 92,
		from = 71
	},
	enemy_fallen_knight_walkingRightLeft = {
		prefix = "CB_DeathKnight",
		to = 48,
		from = 27
	},
	enemy_fallen_knight_walkingUp = {
		prefix = "CB_DeathKnight",
		to = 70,
		from = 49
	},
	enemy_troll_skater_attack = {
		prefix = "troll_skater",
		to = 99,
		from = 68
	},
	enemy_troll_skater_death = {
		prefix = "troll_skater",
		to = 143,
		from = 136
	},
	enemy_troll_skater_idle = {
		prefix = "troll_skater",
		to = 67,
		from = 67
	},
	enemy_troll_skater_skateDown = {
		prefix = "troll_skater",
		to = 111,
		from = 106
	},
	enemy_troll_skater_skateRightLeft = {
		prefix = "troll_skater",
		to = 105,
		from = 100
	},
	enemy_troll_skater_skateUp = {
		prefix = "troll_skater",
		to = 111,
		from = 106
	},
	enemy_troll_skater_walkingDown = {
		prefix = "troll_skater",
		to = 64,
		from = 45
	},
	enemy_troll_skater_walkingRightLeft = {
		prefix = "troll_skater",
		to = 22,
		from = 1
	},
	enemy_troll_skater_walkingUp = {
		prefix = "troll_skater",
		to = 44,
		from = 23
	},
	enemy_hobgoblin_attack = {
		prefix = "hobgoblin",
		to = 85,
		from = 51
	},
	enemy_hobgoblin_death = {
		prefix = "hobgoblin",
		to = 110,
		from = 86
	},
	enemy_hobgoblin_idle = {
		prefix = "hobgoblin",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_walkingDown = {
		prefix = "hobgoblin",
		to = 50,
		from = 26
	},
	enemy_hobgoblin_walkingRightLeft = {
		prefix = "hobgoblin",
		to = 25,
		from = 2
	},
	enemy_hobgoblin_walkingUp = {
		prefix = "hobgoblin",
		to = 25,
		from = 2
	},
	fx_hobgoblin_ground_hit = {
		prefix = "hobgoblin_decal_smoke",
		to = 16,
		from = 1
	},
	eb_juggernaut_attack = {
		prefix = "bossJuggernaut",
		to = 78,
		from = 49
	},
	eb_juggernaut_death = {
		prefix = "bossJuggernaut",
		to = 152,
		from = 127
	},
	eb_juggernaut_idle = {
		prefix = "bossJuggernaut",
		to = 78,
		from = 78
	},
	eb_juggernaut_shoot = {
		prefix = "bossJuggernaut",
		to = 125,
		from = 78
	},
	eb_juggernaut_walkingRightLeft = {
		prefix = "bossJuggernaut",
		to = 24,
		from = 1
	},
	eb_juggernaut_walkingUp = {
		prefix = "bossJuggernaut",
		to = 48,
		from = 25
	},
	fx_juggernaut_smoke = {
		prefix = "bossJuggernaut_smoke",
		to = 14,
		from = 1
	},
	bomb_juggernaut_spawner_open = {
		prefix = "bossJuggernaut_bombDecal",
		to = 35,
		from = 1
	},
	bomb_juggernaut_spawner_idle = {
		prefix = "bossJuggernaut_bombDecal",
		to = 35,
		from = 35
	},
	eb_jt_attack = {
		prefix = "boss_JT",
		to = 105,
		from = 66
	},
	eb_jt_breath = {
		prefix = "boss_JT",
		to = 165,
		from = 137
	},
	eb_jt_death_end = {
		prefix = "boss_JT",
		to = 261,
		from = 234
	},
	eb_jt_death = {
		prefix = "boss_JT",
		to = 210,
		from = 166
	},
	eb_jt_freeze = {
		prefix = "boss_JT",
		to = 136,
		from = 108
	},
	eb_jt_idle = {
		prefix = "boss_JT",
		to = 66,
		from = 66
	},
	eb_jt_walkingDown = {
		prefix = "boss_JT",
		to = 65,
		from = 34
	},
	eb_jt_walkingRightLeft = {
		prefix = "boss_JT",
		to = 33,
		from = 1
	},
	fx_jt_ground_hit = {
		prefix = "boss_JT_hitground_smoke",
		to = 14,
		from = 1
	},
	decal_jt_ground_hit = {
		prefix = "boss_JT_hitground_decal",
		to = 12,
		from = 1
	},
	decal_jt_tap = {
		prefix = "boss_JT_tap_notxt",
		to = 7,
		from = 1
	},
	mod_jt_start = {
		prefix = "boss_jt_tower_freeze",
		to = 10,
		from = 1
	},
	mod_jt_end = {
		prefix = "boss_jt_tower_unfreeze",
		to = 23,
		from = 1
	},
	fx_jt_tower_click = {
		prefix = "boss_JT_tapFeedback",
		to = 10,
		from = 1
	},
	eb_sarelgaz_attack = {
		prefix = "boss_sarelgaz",
		to = 66,
		from = 41
	},
	eb_sarelgaz_death = {
		prefix = "boss_sarelgaz",
		to = 94,
		from = 68
	},
	eb_sarelgaz_idle = {
		prefix = "boss_sarelgaz",
		to = 67,
		from = 67
	},
	eb_sarelgaz_walkingDown = {
		prefix = "boss_sarelgaz",
		to = 40,
		from = 21
	},
	eb_sarelgaz_walkingRightLeft = {
		prefix = "boss_sarelgaz",
		to = 20,
		from = 1
	},
	eb_gulthak_attack = {
		prefix = "boss_GulThak",
		to = 53,
		from = 35
	},
	eb_gulthak_death = {
		prefix = "boss_GulThak",
		to = 123,
		from = 89
	},
	eb_gulthak_heal = {
		prefix = "boss_GulThak",
		to = 86,
		from = 55
	},
	eb_gulthak_idle = {
		prefix = "boss_GulThak",
		to = 35,
		from = 35
	},
	eb_gulthak_walkingDown = {
		prefix = "boss_GulThak",
		to = 34,
		from = 18
	},
	eb_gulthak_walkingRightLeft = {
		prefix = "boss_GulThak",
		to = 17,
		from = 1
	},
	eb_gulthak_walkingUp = {
		prefix = "boss_GulThak",
		to = 17,
		from = 1
	},
	eb_greenmuck_attack = {
		prefix = "BossRotten",
		to = 53,
		from = 34
	},
	eb_greenmuck_death = {
		prefix = "BossRotten",
		to = 98,
		from = 87
	},
	eb_greenmuck_idle = {
		prefix = "BossRotten",
		to = 34,
		from = 34
	},
	eb_greenmuck_shoot = {
		prefix = "BossRotten",
		from = 56,
		to = 75,
		pre = {
			34,
			35
		},
		post = {
			34,
			34,
			34,
			34,
			34,
			34,
			34,
			34,
			34,
			34
		}
	},
	eb_greenmuck_walkingDown = {
		prefix = "BossRotten",
		to = 32,
		from = 17
	},
	eb_greenmuck_walkingRightLeft = {
		prefix = "BossRotten",
		to = 16,
		from = 1
	},
	eb_greenmuck_walkingUp = {
		prefix = "BossRotten",
		to = 32,
		from = 17
	},
	eb_kingpin_death = {
		prefix = "BossBandit",
		to = 41,
		from = 25
	},
	eb_kingpin_eat = {
		to = 84,
		from = 43,
		prefix = "BossBandit",
		post = {
			42,
			42,
			42,
			42,
			42
		}
	},
	eb_kingpin_heal = {
		to = 113,
		from = 88,
		prefix = "BossBandit",
		post = {
			42,
			42
		}
	},
	eb_kingpin_idle = {
		prefix = "BossBandit",
		to = 42,
		from = 42
	},
	eb_kingpin_walkingRightLeft = {
		prefix = "BossBandit",
		to = 24,
		from = 1
	},
	eb_ulgukhai_attack = {
		prefix = "TrollBoss",
		to = 98,
		from = 66
	},
	eb_ulgukhai_death = {
		prefix = "TrollBoss",
		to = 128,
		from = 99
	},
	eb_ulgukhai_idle = {
		prefix = "TrollBoss",
		to = 65,
		from = 65
	},
	eb_ulgukhai_walkingDown = {
		prefix = "TrollBoss",
		to = 64,
		from = 33
	},
	eb_ulgukhai_walkingRightLeft = {
		prefix = "TrollBoss",
		to = 32,
		from = 1
	},
	eb_ulgukhai_walkingUp = {
		prefix = "TrollBoss",
		to = 64,
		from = 33
	},
	eb_moloch_attack = {
		prefix = "Inferno_Moloch",
		to = 109,
		from = 84
	},
	eb_moloch_death = {
		prefix = "Inferno_Moloch",
		to = 232,
		from = 153
	},
	eb_moloch_horn_attack = {
		prefix = "Inferno_Moloch",
		to = 152,
		from = 110
	},
	eb_moloch_idle = {
		prefix = "Inferno_Moloch",
		to = 79,
		from = 79
	},
	eb_moloch_sitting = {
		prefix = "Inferno_Moloch",
		to = 65,
		from = 65
	},
	eb_moloch_raise = {
		prefix = "Inferno_Moloch",
		to = 78,
		from = 65
	},
	eb_moloch_walkingDown = {
		prefix = "Inferno_Moloch",
		to = 64,
		from = 33
	},
	eb_moloch_walkingRightLeft = {
		prefix = "Inferno_Moloch",
		to = 32,
		from = 1
	},
	eb_moloch_walkingUp = {
		prefix = "Inferno_Moloch",
		to = 32,
		from = 1
	},
	fx_moloch_rocks = {
		prefix = "Inferno_Moloch_Rocks",
		to = 17,
		from = 1
	},
	fx_moloch_ring = {
		prefix = "Inferno_Moloch_Ring",
		to = 11,
		from = 1
	},
	eb_myconid_attack = {
		prefix = "mushroomBoss",
		to = 74,
		from = 50
	},
	eb_myconid_death = {
		prefix = "mushroomBoss",
		to = 170,
		from = 104
	},
	eb_myconid_idle = {
		prefix = "mushroomBoss",
		to = 1,
		from = 1
	},
	eb_myconid_spores = {
		prefix = "mushroomBoss",
		to = 103,
		from = 75
	},
	eb_myconid_walkingDown = {
		prefix = "mushroomBoss",
		to = 49,
		from = 26
	},
	eb_myconid_walkingRightLeft = {
		prefix = "mushroomBoss",
		to = 25,
		from = 2
	},
	eb_myconid_walkingUp = {
		prefix = "mushroomBoss",
		to = 25,
		from = 2
	},
	fx_myconid_spores = {
		prefix = "mushroomBossCloud",
		to = 46,
		from = 1
	},
	eb_blackburn_attack = {
		prefix = "CB_Boss",
		to = 69,
		from = 29
	},
	eb_blackburn_death = {
		prefix = "CB_Boss",
		to = 186,
		from = 132
	},
	eb_blackburn_death_end = {
		prefix = "CB_Boss",
		to = 201,
		from = 187
	},
	eb_blackburn_idle = {
		prefix = "CB_Boss",
		to = 1,
		from = 1
	},
	eb_blackburn_smash = {
		prefix = "CB_Boss",
		to = 117,
		from = 70
	},
	eb_blackburn_walkingDown = {
		prefix = "CB_Boss",
		to = 27,
		from = 2
	},
	eb_blackburn_walkingRightLeft = {
		prefix = "CB_Boss",
		to = 27,
		from = 2
	},
	eb_blackburn_walkingUp = {
		prefix = "CB_Boss",
		to = 27,
		from = 2
	},
	fx_blackburn_smash = {
		prefix = "CB_Boss_groundHitFx",
		to = 16,
		from = 1
	},
	fx_blackburn_smash_ground = {
		prefix = "CB_Boss_groundHitDecal",
		to = 18,
		from = 1
	},
	mod_blackburn_tower = {
		prefix = "CB_Boss_towerDebuff",
		to = 18,
		from = 1
	},
	eb_veznan_attack = {
		prefix = "boss_veznan",
		to = 124,
		from = 87
	},
	eb_veznan_idle = {
		prefix = "boss_veznan",
		to = 85,
		from = 85
	},
	eb_veznan_idleDown = {
		prefix = "boss_veznan",
		to = 86,
		from = 86
	},
	eb_veznan_laugh = {
		prefix = "boss_veznan",
		to = 385,
		from = 379
	},
	eb_veznan_spell = {
		prefix = "boss_veznan",
		to = 154,
		from = 127
	},
	eb_veznan_spellDown = {
		prefix = "boss_veznan",
		to = 185,
		from = 158
	},
	eb_veznan_walkAway = {
		prefix = "boss_veznan",
		to = 378,
		from = 343
	},
	eb_veznan_walkingDown = {
		prefix = "boss_veznan",
		to = 56,
		from = 29
	},
	eb_veznan_walkingRightLeft = {
		prefix = "boss_veznan",
		to = 28,
		from = 1
	},
	eb_veznan_walkingUp = {
		prefix = "boss_veznan",
		to = 84,
		from = 57
	},
	eb_veznan_demonTransform = {
		prefix = "boss_veznan",
		to = 244,
		from = 224,
		pre = {
			127,
			127,
			129,
			129,
			131,
			131,
			220,
			220,
			135,
			135
		}
	},
	eb_veznan_demon_attack = {
		prefix = "boss_veznan",
		to = 342,
		from = 295
	},
	eb_veznan_demon_idle = {
		prefix = "boss_veznan",
		to = 296,
		from = 296
	},
	eb_veznan_demon_walkingDown = {
		prefix = "boss_veznan",
		to = 294,
		from = 271
	},
	eb_veznan_demon_walkingRightLeft = {
		prefix = "boss_veznan",
		to = 270,
		from = 247
	},
	eb_veznan_demon_walkingUp = {
		prefix = "boss_veznan",
		to = 270,
		from = 247
	},
	eb_veznan_demon_death = {
		prefix = "boss_veznan",
		to = 536,
		from = 386
	},
	eb_veznan_demon_deathLoop = {
		prefix = "boss_veznan",
		to = 543,
		from = 537
	},
	eb_veznan_demon_deathEnd = {
		prefix = "boss_veznan",
		to = 537,
		from = 537
	},
	decal_veznan_strike = {
		prefix = "boss_veznan_unholystrike",
		to = 14,
		from = 1
	},
	fx_veznan_demon_fire = {
		to = 11,
		from = 1,
		prefix = "boss_veznan_demonFire",
		post = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			23,
			23,
			25,
			26
		}
	},
	veznan_portal_idle = {
		prefix = "boss_veznan_infernalPortal",
		to = 1,
		from = 1
	},
	veznan_portal_start = {
		prefix = "boss_veznan_infernalPortal",
		to = 11,
		from = 1
	},
	veznan_portal_active = {
		prefix = "boss_veznan_infernalPortal",
		to = 20,
		from = 12
	},
	veznan_portal_end = {
		to = 10,
		from = 10,
		prefix = "boss_veznan_infernalPortal",
		post = {
			9,
			8,
			7,
			6,
			5,
			4,
			3,
			2,
			1,
			1
		}
	},
	mod_veznan_start = {
		prefix = "boss_veznan_towerHold",
		to = 32,
		from = 1
	},
	mod_veznan_preHold = {
		prefix = "boss_veznan_towerHold",
		to = 40,
		from = 33
	},
	mod_veznan_hold = {
		prefix = "boss_veznan_towerHold",
		to = 54,
		from = 41
	},
	mod_veznan_remove = {
		prefix = "boss_veznan_towerHold",
		to = 64,
		from = 55
	},
	decal_veznan_tap = {
		prefix = "boss_veznan_tap",
		to = 7,
		from = 1
	},
	decal_veznan_soul = {
		prefix = "boss_veznan_soul",
		to = 19,
		from = 11
	},
	decal_veznan_white_circle = {
		prefix = "boss_veznan_deathExplotion",
		to = 65,
		from = 1
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
	soldiermilitia_idle = {
		prefix = "soldier_lvl1",
		to = 1,
		from = 1
	},
	soldiermilitia_running = {
		prefix = "soldier_lvl1",
		to = 6,
		from = 2
	},
	soldiermilitia_attack = {
		prefix = "soldier_lvl1",
		to = 17,
		from = 7
	},
	soldiermilitia_death = {
		prefix = "soldier_lvl1",
		to = 23,
		from = 18
	},
	soldierfootmen_idle = {
		prefix = "soldier_lvl2",
		to = 1,
		from = 1
	},
	soldierfootmen_running = {
		prefix = "soldier_lvl2",
		to = 6,
		from = 2
	},
	soldierfootmen_attack = {
		prefix = "soldier_lvl2",
		to = 17,
		from = 7
	},
	soldierfootmen_death = {
		prefix = "soldier_lvl2",
		to = 23,
		from = 18
	},
	soldierknight_idle = {
		prefix = "soldier_lvl3",
		to = 1,
		from = 1
	},
	soldierknight_running = {
		prefix = "soldier_lvl3",
		to = 6,
		from = 2
	},
	soldierknight_attack = {
		prefix = "soldier_lvl3",
		to = 17,
		from = 7
	},
	soldierknight_death = {
		prefix = "soldier_lvl3",
		to = 23,
		from = 18
	},
	soldier_elemental_idle = {
		prefix = "soldier_elemental",
		to = 1,
		from = 1
	},
	soldier_elemental_running = {
		prefix = "soldier_elemental",
		to = 26,
		from = 2
	},
	soldier_elemental_attack = {
		prefix = "soldier_elemental",
		to = 55,
		from = 27
	},
	soldier_elemental_death = {
		prefix = "soldier_elemental",
		to = 71,
		from = 56
	},
	soldier_elemental_raise = {
		prefix = "soldier_elemental",
		to = 91,
		from = 72
	},
	soldier_paladin_idle = {
		prefix = "soldier_lvl4_paladin",
		to = 1,
		from = 1
	},
	soldier_paladin_running = {
		prefix = "soldier_lvl4_paladin",
		to = 6,
		from = 2
	},
	soldier_paladin_attack = {
		prefix = "soldier_lvl4_paladin",
		to = 17,
		from = 7
	},
	soldier_paladin_attack2 = {
		prefix = "soldier_lvl4_paladin",
		to = 28,
		from = 18
	},
	soldier_paladin_death = {
		prefix = "soldier_lvl4_paladin",
		to = 97,
		from = 91
	},
	soldier_paladin_holystrike = {
		prefix = "soldier_lvl4_paladin",
		to = 59,
		from = 31
	},
	soldier_paladin_healing = {
		prefix = "soldier_lvl4_paladin",
		to = 90,
		from = 60
	},
	decal_paladin_holystrike = {
		prefix = "decal_holystrike",
		to = 12,
		from = 1
	},
	soldier_barbarian_idle = {
		prefix = "soldier_lvl4_barbarian",
		to = 1,
		from = 1
	},
	soldier_barbarian_idle2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 2,
		from = 2
	},
	soldier_barbarian_running = {
		prefix = "soldier_lvl4_barbarian",
		to = 7,
		from = 3
	},
	soldier_barbarian_running2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 12,
		from = 8
	},
	soldier_barbarian_attack = {
		prefix = "soldier_lvl4_barbarian",
		to = 23,
		from = 13
	},
	soldier_barbarian_attack2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 42,
		from = 24
	},
	soldier_barbarian_shoot = {
		prefix = "soldier_lvl4_barbarian",
		to = 88,
		from = 73
	},
	soldier_barbarian_shoot2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 72,
		from = 57
	},
	soldier_barbarian_net = {
		prefix = "soldier_lvl4_barbarian",
		to = 103,
		from = 97,
		post = {
		80,
		81,
		82,
		83,
		84,
		85,
		86,
		87,
		88
		}
	},
	soldier_barbarian_net2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 110,
		from = 104,
		post = {
		64,
		65,
		66,
		67,
		68,
		69,
		70,
		71,
		72
		}
	},
	barbarian_net = {
		prefix = "barbarian_net",
		to = 1,
		from = 1
	},
	barbarian_net_idle = {
		prefix = "barbarian_net",
		to = 1,
		from = 1
	},
	barbarian_net_flying = {
		prefix = "barbarian_net",
		to = 1,
		from = 1
	},
	barbarian_net_hit = {
		prefix = "barbarian_net",
		to = 1,
		from = 1
	},
	barbarian_net_effect = {
		prefix = "barbarian_net_effect",
		to = 1,
		from = 1
	},
	soldier_barbarian_twister = {
		to = 56,
		from = 43,
		prefix = "soldier_lvl4_barbarian",
		post = {
			1
		}
	},
	soldier_barbarian_twister2 = {
		to = 56,
		from = 43,
		prefix = "soldier_lvl4_barbarian",
		post = {
			2
		}
	},
	soldier_barbarian_death = {
		prefix = "soldier_lvl4_barbarian",
		to = 95,
		from = 89
	},
	soldier_elf_idle = {
		prefix = "elfSoldier",
		to = 1,
		from = 1
	},
	soldier_elf_running = {
		prefix = "elfSoldier",
		to = 6,
		from = 1
	},
	soldier_elf_attack = {
		prefix = "elfSoldier",
		to = 24,
		from = 7
	},
	soldier_elf_death = {
		prefix = "elfSoldier",
		to = 47,
		from = 40
	},
	soldier_elf_shoot = {
		prefix = "elfSoldier",
		to = 36,
		from = 25
	},
	soldier_sasquash_idle = {
		prefix = "sasquash",
		to = 1,
		from = 1
	},
	soldier_sasquash_running = {
		prefix = "sasquash",
		to = 26,
		from = 2
	},
	soldier_sasquash_attack = {
		prefix = "sasquash",
		to = 55,
		from = 29
	},
	soldier_sasquash_death = {
		prefix = "sasquash",
		to = 80,
		from = 56
	},
	soldier_s6_imperial_guard_idle = {
		prefix = "imperialGuard",
		to = 17,
		from = 17
	},
	soldier_s6_imperial_guard_running = {
		prefix = "imperialGuard",
		to = 6,
		from = 1
	},
	soldier_s6_imperial_guard_attack = {
		prefix = "imperialGuard",
		to = 17,
		from = 7
	},
	soldier_s6_imperial_guard_attack2 = {
		prefix = "imperialGuard",
		to = 28,
		from = 18
	},
	soldier_s6_imperial_guard_death = {
		prefix = "imperialGuard",
		to = 40,
		from = 29
	},
	shooterarcherlvl1_idleDown = {
		prefix = "tower_archer_lvl1_shooter",
		to = 1,
		from = 1
	},
	shooterarcherlvl1_idleUp = {
		prefix = "tower_archer_lvl1_shooter",
		to = 2,
		from = 2
	},
	shooterarcherlvl1_shootingDown = {
		prefix = "tower_archer_lvl1_shooter",
		to = 10,
		from = 3
	},
	shooterarcherlvl1_shootingUp = {
		prefix = "tower_archer_lvl1_shooter",
		to = 18,
		from = 11
	},
	shooterarcherlvl2_idleDown = {
		prefix = "tower_archer_lvl2_shooter",
		to = 1,
		from = 1
	},
	shooterarcherlvl2_idleUp = {
		prefix = "tower_archer_lvl2_shooter",
		to = 2,
		from = 2
	},
	shooterarcherlvl2_shootingDown = {
		prefix = "tower_archer_lvl2_shooter",
		to = 10,
		from = 3
	},
	shooterarcherlvl2_shootingUp = {
		prefix = "tower_archer_lvl2_shooter",
		to = 18,
		from = 11
	},
	shooterarcherlvl3_idleDown = {
		prefix = "tower_archer_lvl3_shooter",
		to = 1,
		from = 1
	},
	shooterarcherlvl3_idleUp = {
		prefix = "tower_archer_lvl3_shooter",
		to = 2,
		from = 2
	},
	shooterarcherlvl3_shootingDown = {
		prefix = "tower_archer_lvl3_shooter",
		to = 10,
		from = 3
	},
	shooterarcherlvl3_shootingUp = {
		prefix = "tower_archer_lvl3_shooter",
		to = 18,
		from = 11
	},
	towerbarracklvl1_door_open = {
		prefix = "tower_barracks_lvl1_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl2_door_open = {
		prefix = "tower_barracks_lvl2_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl3_door_open = {
		prefix = "tower_barracks_lvl3_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl1_door_close = {
		prefix = "tower_barracks_lvl1_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl2_door_close = {
		prefix = "tower_barracks_lvl2_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl3_door_close = {
		prefix = "tower_barracks_lvl3_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl4_paladin_door_open = {
		prefix = "tower_barracks_lvl4_Paladins_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl4_paladin_door_close = {
		prefix = "tower_barracks_lvl4_Paladins_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl4_barbarian_door_open = {
		prefix = "tower_barrack_lvl4_Barbarians_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl4_barbarian_door_close = {
		prefix = "tower_barrack_lvl4_Barbarians_layer2",
		to = 25,
		from = 22
	},
	tower_elf_door_open = {
		prefix = "elfTower_layer2",
		to = 5,
		from = 1
	},
	tower_elf_door_close = {
		prefix = "elfTower_layer2",
		to = 25,
		from = 22
	},
	shootermage_idleDown = {
		prefix = "mage_shooter",
		to = 1,
		from = 1
	},
	shootermage_idleUp = {
		prefix = "mage_shooter",
		to = 2,
		from = 2
	},
	shootermage_shootingDown = {
		prefix = "mage_shooter",
		to = 15,
		from = 3
	},
	shootermage_shootingUp = {
		prefix = "mage_shooter",
		to = 30,
		from = 17
	},
	towermagelvl1_idle = {
		prefix = "mage_lvl1",
		to = 1,
		from = 1
	},
	towermagelvl1_shoot = {
		prefix = "mage_lvl1",
		to = 12,
		from = 1
	},
	towermagelvl2_idle = {
		prefix = "mage_lvl2",
		to = 1,
		from = 1
	},
	towermagelvl2_shoot = {
		prefix = "mage_lvl2",
		to = 12,
		from = 1
	},
	towermagelvl3_idle = {
		prefix = "mage_lvl3",
		to = 1,
		from = 1
	},
	towermagelvl3_shoot = {
		prefix = "mage_lvl3",
		to = 12,
		from = 1
	},
	bolt_idle = {
		prefix = "magebolt",
		to = 2,
		from = 1
	},
	bolt_flying = {
		prefix = "magebolt",
		to = 2,
		from = 1
	},
	bolt_hit = {
		prefix = "magebolt",
		to = 10,
		from = 3
	},
	towerengineerlvl1_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl1_layer%i",
		to = 1,
		layer_from = 1
	},
	towerengineerlvl1_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl1_layer%i",
		to = 35,
		layer_from = 1
	},
	towerengineerlvl2_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl2_layer%i",
		to = 1,
		layer_from = 1
	},
	towerengineerlvl2_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl2_layer%i",
		to = 35,
		layer_from = 1
	},
	towerengineerlvl3_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl3_layer%i",
		to = 1,
		layer_from = 1
	},
	towerengineerlvl3_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl3_layer%i",
		to = 35,
		layer_from = 1
	},
	tower_ranger_shooter_idleDown = {
		prefix = "tower_archer_ranger_shooter",
		to = 1,
		from = 1
	},
	tower_ranger_shooter_idleUp = {
		prefix = "tower_archer_ranger_shooter",
		to = 2,
		from = 2
	},
	tower_ranger_shooter_shootingDown = {
		prefix = "tower_archer_ranger_shooter",
		to = 10,
		from = 3
	},
	tower_ranger_shooter_shootingUp = {
		prefix = "tower_archer_ranger_shooter",
		to = 18,
		from = 11
	},
	tower_ranger_druid_idle = {
		prefix = "tower_archer_druid",
		to = 1,
		from = 1
	},
	tower_ranger_druid_shoot = {
		prefix = "tower_archer_druid",
		to = 41,
		from = 1
	},
	tower_musketeer_shooter_idleDown = {
		prefix = "tower_archer_musketeer_shooter",
		to = 1,
		from = 1
	},
	tower_musketeer_shooter_idleUp = {
		prefix = "tower_archer_musketeer_shooter",
		to = 2,
		from = 2
	},
	tower_musketeer_shooter_shootingDown = {
		to = 26,
		from = 1,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			1
		}
	},
	tower_musketeer_shooter_shootingUp = {
		to = 50,
		from = 27,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			2
		}
	},
	tower_musketeer_shooter_cannonShootDown = {
		to = 225,
		from = 194,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			1
		}
	},
	tower_musketeer_shooter_cannonShootUp = {
		to = 257,
		from = 226,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			2
		}
	},
	tower_musketeer_shooter_cannonFuseDown = {
		to = 161,
		from = 130,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			1
		}
	},
	tower_musketeer_shooter_cannonFuseUp = {
		to = 193,
		from = 162,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			2
		}
	},
	tower_musketeer_shooter_sniperShootDown = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				51,
				56
			},
			{
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56
			},
			{
				57,
				74
			},
			{
				1
			}
		}
	},
	tower_musketeer_shooter_sniperShootUp = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				75,
				80
			},
			{
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80
			},
			{
				81,
				98
			},
			{
				2
			}
		}
	},
	tower_musketeer_shooter_sniperSeekDown = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				99,
				107
			},
			{
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107
			},
			{
				116,
				121
			},
			{
				1
			}
		}
	},
	tower_musketeer_shooter_sniperSeekUp = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				108,
				115
			},
			{
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115
			},
			{
				123,
				129
			},
			{
				2
			}
		}
	},
	musketeer_crosshair = {
		prefix = "musketeer_crosshair",
		to = 16,
		from = 1
	},
	tower_arcane_wizard_idle = {
		prefix = "arcane_tower",
		to = 1,
		from = 1
	},
	tower_arcane_wizard_shoot = {
		prefix = "arcane_tower",
		to = 39,
		from = 1
	},
	tower_arcane_wizard_teleport = {
		to = 49,
		from = 40,
		prefix = "arcane_tower",
		post = {
			1
		}
	},
	fx_tower_arcane_wizard_teleport = {
		prefix = "arcane_teleport_effect",
		to = 22,
		from = 1
	},
	tower_arcane_wizard_shooter_idleDown = {
		prefix = "arcane_shooter",
		to = 1,
		from = 1
	},
	tower_arcane_wizard_shooter_idleUp = {
		prefix = "arcane_shooter",
		to = 2,
		from = 2
	},
	tower_arcane_wizard_shooter_shootingDown = {
		to = 36,
		from = 3,
		prefix = "arcane_shooter",
		post = {
			1
		}
	},
	tower_arcane_wizard_shooter_shootingUp = {
		to = 69,
		from = 37,
		prefix = "arcane_shooter",
		post = {
			2
		}
	},
	tower_arcane_wizard_shooter_teleportDown = {
		prefix = "arcane_shooter",
		frames = {
			3,
			4,
			5,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			5,
			4,
			3,
			1
		}
	},
	tower_arcane_wizard_shooter_teleportUp = {
		prefix = "arcane_shooter",
		frames = {
			37,
			38,
			39,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			39,
			38,
			37,
			2
		}
	},
	ray_arcane = {
		prefix = "ray_arcane",
		to = 6,
		from = 1
	},
	ray_arcane_disintegrate = {
		prefix = "ray_desintegrate",
		to = 9,
		from = 1
	},
	mod_ray_arcane = {
		prefix = "arcanehit",
		to = 12,
		from = 1
	},
	aura_teleport_arcane = {
		prefix = "decal_teleportal",
		to = 23,
		from = 1
	},
	tower_sorcerer_idle = {
		prefix = "sorcerer_tower",
		to = 1,
		from = 1
	},
	tower_sorcerer_shoot = {
		prefix = "sorcerer_tower",
		to = 26,
		from = 1
	},
	tower_sorcerer_polymorph = {
		prefix = "sorcerer_tower",
		to = 26,
		from = 1
	},
	fx_tower_sorcerer_polymorph = {
		prefix = "fx_polymorph",
		to = 20,
		from = 1
	},
	tower_sorcerer_shooter_idleDown = {
		prefix = "sorcerer_shooter",
		to = 1,
		from = 1
	},
	tower_sorcerer_shooter_idleUp = {
		prefix = "sorcerer_shooter",
		to = 2,
		from = 2
	},
	tower_sorcerer_shooter_shootingDown = {
		prefix = "sorcerer_shooter",
		to = 22,
		from = 3
	},
	tower_sorcerer_shooter_shootingUp = {
		prefix = "sorcerer_shooter",
		to = 43,
		from = 23
	},
	tower_sorcerer_shooter_polymorphUp = {
		prefix = "sorcerer_shooter",
		to = 68,
		from = 44
	},
	tower_sorcerer_shooter_polymorphDown = {
		prefix = "sorcerer_shooter",
		to = 93,
		from = 69
	},
	bolt_sorcerer_idle = {
		prefix = "sorcererbolt_star",
		to = 8,
		from = 1
	},
	bolt_sorcerer_flying = {
		prefix = "sorcererbolt_star",
		to = 8,
		from = 1
	},
	bolt_sorcerer_hit = {
		prefix = "sorcererbolt",
		to = 16,
		from = 9
	},
	bolt_sorcerer_idle_over = {
		prefix = "sorcererbolt_star",
		to = 1,
		from = 1
	},
	ray_sorcerer_polymorph = {
		prefix = "ray_polymorph",
		to = 10,
		from = 1
	},
	mod_sorcerer_curse_small = {
		prefix = "curse_small",
		to = 15,
		from = 1
	},
	mod_sorcerer_curse_medium = {
		prefix = "curse_big",
		to = 15,
		from = 1
	},
	mod_sorcerer_curse_large = {
		prefix = "curse_boss_type1",
		to = 15,
		from = 1
	},
	tower_bfg_idle = {
		prefix = "artillery_lvl4_bfg",
		to = 1,
		from = 1
	},
	tower_bfg_shoot = {
		prefix = "artillery_lvl4_bfg",
		to = 49,
		from = 1
	},
	tower_bfg_missile = {
		to = 77,
		from = 50,
		prefix = "artillery_lvl4_bfg",
		post = {
			1
		}
	},
	missile_bfg_flying = {
		prefix = "missile",
		to = 3,
		from = 1
	},
	tower_tesla_idle = {
		prefix = "artillery_lvl4_tesla",
		to = 1,
		from = 1
	},
	tower_tesla_shoot = {
		prefix = "artillery_lvl4_tesla",
		to = 65,
		from = 1
	},
	ray_tesla = {
		prefix = "ray_tesla",
		to = 13,
		from = 1
	},
	mod_tesla_hit_small = {
		prefix = "teslahit_small",
		to = 18,
		from = 1
	},
	mod_tesla_hit_medium = {
		prefix = "teslahit_big",
		to = 18,
		from = 1
	},
	mod_tesla_hit_large = {
		prefix = "teslahit_boss_type1",
		to = 18,
		from = 1
	},
	decal_tesla_overcharge = {
		prefix = "static_particle",
		to = 6,
		from = 1
	},
	tower_paladin_flag = {
		prefix = "paladinFlag",
		to = 9,
		from = 1
	},
	tower_sasquash_frozen = {
		prefix = "sasquash_frozen",
		to = 1,
		from = 1
	},
	tower_sasquash_unfreeze = {
		prefix = "sasquash_frozen",
		to = 42,
		from = 2
	},
	tower_sunray_layerX_disabled = {
		layer_to = 5,
		from = 1,
		layer_prefix = "sunrayTower_layer%i",
		to = 1,
		layer_from = 2
	},
	tower_sunray_layerX_charging = {
		layer_to = 5,
		from = 2,
		layer_prefix = "sunrayTower_layer%i",
		to = 21,
		layer_from = 2
	},
	tower_sunray_layerX_ready_start = {
		layer_to = 5,
		from = 22,
		layer_prefix = "sunrayTower_layer%i",
		to = 31,
		layer_from = 2
	},
	tower_sunray_layerX_ready_idle = {
		layer_to = 5,
		from = 32,
		layer_prefix = "sunrayTower_layer%i",
		to = 51,
		layer_from = 2
	},
	tower_sunray_layerX_shoot = {
		layer_to = 5,
		from = 52,
		layer_prefix = "sunrayTower_layer%i",
		to = 67,
		layer_from = 2
	},
	tower_sunray_shooter_up_idle = {
		prefix = "sorcerer_shooter",
		to = 2,
		from = 2
	},
	tower_sunray_shooter_up_charge = {
		prefix = "sorcerer_shooter",
		to = 93,
		from = 69
	},
	tower_sunray_shooter_down_idle = {
		prefix = "sorcerer_shooter",
		to = 1,
		from = 1
	},
	tower_sunray_shooter_down_charge = {
		prefix = "sorcerer_shooter",
		to = 68,
		from = 44
	},
	ray_sunray = {
		prefix = "sunray_Ray",
		to = 9,
		from = 1
	},
	fx_ray_sunray_hit = {
		prefix = "sunray_RayHit",
		to = 22,
		from = 1
	},
	hero_gerald_attack = {
		to = 17,
		from = 7,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_attack2 = {
		to = 28,
		from = 18,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_counter = {
		to = 76,
		from = 56,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_courage = {
		to = 132,
		from = 80,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_death = {
		prefix = "hero_barracks",
		to = 140,
		from = 133
	},
	hero_gerald_idle = {
		prefix = "hero_barracks",
		to = 1,
		from = 1
	},
	hero_gerald_levelup = {
		to = 55,
		from = 32,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_respawn = {
		to = 55,
		from = 37,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_running = {
		prefix = "hero_barracks",
		to = 6,
		from = 2
	},
	hero_archer_attack = {
		prefix = "hero_archer",
		to = 34,
		from = 19
	},
	hero_archer_callofwild = {
		prefix = "hero_archer",
		to = 118,
		from = 80
	},
	hero_archer_death = {
		prefix = "hero_archer",
		to = 125,
		from = 119
	},
	hero_archer_idle = {
		prefix = "hero_archer",
		to = 1,
		from = 1
	},
	hero_archer_levelup = {
		prefix = "hero_archer",
		to = 53,
		from = 36
	},
	hero_archer_multishot = {
		prefix = "hero_archer",
		to = 79,
		from = 54
	},
	hero_archer_respawn = {
		prefix = "hero_archer",
		to = 53,
		from = 36
	},
	hero_archer_running = {
		prefix = "hero_archer",
		to = 6,
		from = 2
	},
	hero_archer_shoot = {
		prefix = "hero_archer",
		to = 18,
		from = 7
	},
	soldier_alleria_attack = {
		prefix = "hero_archer_wildcat",
		to = 27,
		from = 14
	},
	soldier_alleria_death = {
		prefix = "hero_archer_wildcat",
		to = 64,
		from = 47
	},
	soldier_alleria_idle = {
		prefix = "hero_archer_wildcat",
		to = 1,
		from = 1
	},
	soldier_alleria_running = {
		prefix = "hero_archer_wildcat",
		to = 11,
		from = 2
	},
	soldier_alleria_spawn = {
		prefix = "hero_archer_wildcat",
		to = 46,
		from = 28
	},
	hero_malik_attack = {
		prefix = "hero_reinforce",
		to = 25,
		from = 8
	},
	hero_malik_attack2 = {
		prefix = "hero_reinforce",
		to = 42,
		from = 26
	},
	hero_malik_death = {
		prefix = "hero_reinforce",
		to = 139,
		from = 131
	},
	hero_malik_idle = {
		prefix = "hero_reinforce",
		to = 1,
		from = 1
	},
	hero_malik_levelup = {
		prefix = "hero_reinforce",
		to = 130,
		from = 108
	},
	hero_malik_respawn = {
		prefix = "hero_reinforce",
		to = 130,
		from = 112
	},
	hero_malik_running = {
		prefix = "hero_reinforce",
		to = 6,
		from = 2
	},
	hero_malik_smash = {
		prefix = "hero_reinforce",
		to = 106,
		from = 80
	},
	hero_malik_fissure = {
		prefix = "hero_reinforce",
		to = 79,
		from = 43
	},
	decal_malik_ring = {
		prefix = "hero_reinforce_ring",
		to = 11,
		from = 1
	},
	decal_malik_earthquake = {
		prefix = "hero_reinforce_rocks",
		to = 17,
		from = 1
	},
	hero_hacksaw_attack = {
		prefix = "Inferno_hero_Lumberjack",
		to = 52,
		from = 22
	},
	hero_hacksaw_death = {
		prefix = "Inferno_hero_Lumberjack",
		to = 157,
		from = 137
	},
	hero_hacksaw_idle = {
		prefix = "Inferno_hero_Lumberjack",
		to = 1,
		from = 1
	},
	hero_hacksaw_levelUp = {
		prefix = "Inferno_hero_Lumberjack",
		to = 136,
		from = 120
	},
	hero_hacksaw_respawn = {
		prefix = "Inferno_hero_Lumberjack",
		to = 136,
		from = 120
	},
	hero_hacksaw_running = {
		prefix = "Inferno_hero_Lumberjack",
		to = 21,
		from = 2
	},
	hero_hacksaw_sawblade = {
		prefix = "Inferno_hero_Lumberjack",
		to = 84,
		from = 53
	},
	hero_hacksaw_timber = {
		prefix = "Inferno_hero_Lumberjack",
		to = 119,
		from = 85
	},
	hacksaw_sawblade_idle = {
		prefix = "Inferno_hero_Lumberjack_proy",
		to = 1,
		from = 1
	},
	hacksaw_sawblade_flying = {
		prefix = "Inferno_hero_Lumberjack_proy",
		to = 4,
		from = 1
	},
	fx_hacksaw_sawblade_hit = {
		prefix = "Inferno_hero_Lumberjack_proyHit",
		to = 7,
		from = 1
	},
	ps_hacksaw_sawblade = {
		prefix = "Inferno_hero_Lumberjack_proyParticle",
		to = 12,
		from = 1
	},
	hero_thor_attack = {
		prefix = "thor",
		to = 68,
		from = 43
	},
	hero_thor_death = {
		prefix = "thor",
		to = 42,
		from = 8
	},
	hero_thor_idle = {
		prefix = "thor",
		to = 8,
		from = 8
	},
	hero_thor_levelUp = {
		prefix = "thor",
		to = 147,
		from = 131
	},
	hero_thor_respawn = {
		prefix = "thor",
		to = 147,
		from = 131
	},
	hero_thor_running = {
		prefix = "thor",
		to = 7,
		from = 1
	},
	hero_thor_chain = {
		prefix = "thor",
		to = 102,
		from = 69
	},
	hero_thor_thunderclap = {
		prefix = "thor",
		to = 130,
		from = 103
	},
	ray_hero_thor = {
		prefix = "HalloweenTesla_ray",
		to = 13,
		from = 1
	},
	hammer_hero_thor_idle = {
		prefix = "thor_hammer",
		to = 1,
		from = 1
	},
	hammer_hero_thor_flying = {
		prefix = "thor_hammer",
		to = 1,
		from = 1
	},
	mod_hero_thor_thunderclap = {
		prefix = "thor_lightening_layer2",
		to = 24,
		from = 1
	},
	mod_hero_thor_thunderclap_explosion = {
		prefix = "thor_lightening_layer1",
		to = 24,
		from = 1
	},
	fx_hero_thor_thunderclap_disipate = {
		prefix = "thor_lightening_layer0",
		to = 24,
		from = 1
	},
	hero_oni_attack = {
		prefix = "hero_oni",
		to = 45,
		from = 17
	},
	hero_oni_death = {
		prefix = "hero_oni",
		to = 236,
		from = 179
	},
	hero_oni_idle = {
		prefix = "hero_oni",
		to = 10,
		from = 1
	},
	hero_oni_levelUp = {
		prefix = "hero_oni",
		to = 178,
		from = 161
	},
	hero_oni_respawn = {
		prefix = "hero_oni",
		to = 178,
		from = 161
	},
	hero_oni_running = {
		prefix = "hero_oni",
		to = 16,
		from = 11
	},
	hero_oni_deathStrike = {
		prefix = "hero_oni",
		to = 160,
		from = 113
	},
	hero_oni_torment = {
		prefix = "hero_oni",
		to = 112,
		from = 45
	},
	decal_oni_torment_sword_1_in = {
		prefix = "hero_oni_sword1",
		to = 44,
		from = 1
	},
	decal_oni_torment_sword_1_out = {
		prefix = "hero_oni_sword1",
		to = 52,
		from = 46
	},
	decal_oni_torment_sword_2_in = {
		prefix = "hero_oni_sword2",
		to = 44,
		from = 1
	},
	decal_oni_torment_sword_2_out = {
		prefix = "hero_oni_sword2",
		to = 52,
		from = 46
	},
	decal_oni_torment_sword_3_in = {
		prefix = "hero_oni_sword3",
		to = 44,
		from = 1
	},
	decal_oni_torment_sword_3_out = {
		prefix = "hero_oni_sword3",
		to = 52,
		from = 46
	},
	hero_elora_attack = {
		prefix = "hero_frost",
		to = 30,
		from = 8
	},
	hero_elora_death = {
		prefix = "hero_frost",
		to = 133,
		from = 125
	},
	hero_elora_idle = {
		prefix = "hero_frost",
		to = 1,
		from = 1
	},
	hero_elora_levelUp = {
		prefix = "hero_frost",
		to = 152,
		from = 134
	},
	hero_elora_respawn = {
		prefix = "hero_frost",
		to = 152,
		from = 134
	},
	hero_elora_running = {
		prefix = "hero_frost",
		to = 7,
		from = 2
	},
	hero_elora_shoot = {
		prefix = "hero_frost",
		to = 57,
		from = 31
	},
	hero_elora_chill = {
		prefix = "hero_frost",
		to = 85,
		from = 58
	},
	hero_elora_iceStorm = {
		prefix = "hero_frost",
		to = 124,
		from = 86
	},
	ps_hero_elora_run = {
		prefix = "hero_frost_runParticle",
		to = 13,
		from = 1
	},
	hero_elora_frostEffect = {
		prefix = "hero_frost_idleEffect",
		to = 38,
		from = 1
	},
	bolt_elora_idle = {
		prefix = "hero_frost_bolt",
		to = 1,
		from = 1
	},
	bolt_elora_flying = {
		prefix = "hero_frost_bolt",
		to = 4,
		from = 1
	},
	fx_bolt_elora_hit = {
		prefix = "hero_frost_bolt",
		to = 12,
		from = 5
	},
	elora_ice_spike_1_start = {
		prefix = "hero_frost_spikes_1",
		to = 53,
		from = 1
	},
	elora_ice_spike_2_start = {
		prefix = "hero_frost_spikes_2",
		to = 53,
		from = 1
	},
	decal_elora_chill_1_start = {
		prefix = "hero_frost_groundFreeze_1",
		to = 11,
		from = 1
	},
	decal_elora_chill_2_start = {
		prefix = "hero_frost_groundFreeze_2",
		to = 11,
		from = 1
	},
	decal_elora_chill_3_start = {
		prefix = "hero_frost_groundFreeze_3",
		to = 11,
		from = 1
	},
	hero_bolin_attack = {
		prefix = "hero_artillery",
		to = 206,
		from = 191
	},
	hero_bolin_death = {
		prefix = "hero_artillery",
		to = 214,
		from = 207
	},
	hero_bolin_idle = {
		prefix = "hero_artillery",
		to = 1,
		from = 1
	},
	hero_bolin_levelUp = {
		prefix = "hero_artillery",
		to = 125,
		from = 109
	},
	hero_bolin_respawn = {
		prefix = "hero_artillery",
		to = 125,
		from = 109
	},
	hero_bolin_running = {
		prefix = "hero_artillery",
		to = 6,
		from = 2
	},
	hero_bolin_tar = {
		prefix = "hero_artillery",
		to = 171,
		from = 148
	},
	decal_bolin_tar_start = {
		prefix = "hero_artillery_brea_decal",
		to = 11,
		from = 1
	},
	decal_bolin_tar_end = {
		prefix = "hero_artillery_brea_decal",
		to = 17,
		from = 13
	},
	hero_bolin_mine = {
		prefix = "hero_artillery",
		to = 188,
		from = 173
	},
	decal_bolin_mine = {
		prefix = "hero_artillery_mine",
		to = 30,
		from = 1
	},
	hero_bolin_shootAimRightLeft = {
		prefix = "hero_artillery",
		to = 16,
		from = 7
	},
	hero_bolin_shootRightLeft = {
		prefix = "hero_artillery",
		to = 30,
		from = 20,
		pre = {
			13,
			13,
			13
		}
	},
	hero_bolin_shootAimDown = {
		prefix = "hero_artillery",
		to = 66,
		from = 58,
		pre = {
			1
		}
	},
	hero_bolin_shootDown = {
		prefix = "hero_artillery",
		to = 79,
		from = 67
	},
	hero_bolin_shootAimUp = {
		prefix = "hero_artillery",
		to = 41,
		from = 32,
		pre = {
			1
		}
	},
	hero_bolin_shootUp = {
		prefix = "hero_artillery",
		to = 56,
		from = 42
	},
	hero_bolin_reload = {
		prefix = "hero_artillery",
		to = 102,
		from = 82
	},
	hero_magnus_attack = {
		prefix = "hero_magnus_mage",
		to = 39,
		from = 18
	},
	hero_magnus_death = {
		prefix = "hero_magnus_mage",
		to = 169,
		from = 162
	},
	hero_magnus_idle = {
		prefix = "hero_magnus_mage",
		to = 1,
		from = 1
	},
	hero_magnus_levelUp = {
		prefix = "hero_magnus_mage",
		to = 68,
		from = 40
	},
	hero_magnus_respawn = {
		prefix = "hero_magnus_mage",
		to = 67,
		from = 51
	},
	hero_magnus_shoot = {
		prefix = "hero_magnus_mage",
		to = 93,
		from = 69
	},
	hero_magnus_running = {
		prefix = "hero_magnus_mage",
		to = 17,
		from = 2
	},
	hero_magnus_mirage = {
		prefix = "hero_magnus_mage",
		from = 143,
		to = 153,
		pre = {
			40
		},
		post = {
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			151,
			151,
			149,
			147,
			147,
			159,
			159,
			143
		}
	},
	hero_magnus_arcaneRain = {
		prefix = "hero_magnus_mage",
		to = 141,
		from = 103
	},
	hero_magnus_teleport_out = {
		prefix = "hero_magnus_mage",
		to = 179,
		from = 170,
		pre = {
			40,
			40,
			97,
			97,
			99,
			99,
			101,
			101
		}
	},
	hero_magnus_teleport_in = {
		prefix = "hero_magnus_mage",
		to = 179,
		from = 170
	},
	bolt_magnus_idle = {
		prefix = "hero_magnus_mage_bolt",
		to = 2,
		from = 1
	},
	bolt_magnus_flying = {
		prefix = "hero_magnus_mage_bolt",
		to = 2,
		from = 1
	},
	bolt_magnus_hit = {
		prefix = "hero_magnus_mage_bolt",
		to = 10,
		from = 3
	},
	magnus_arcane_rain_idle = {
		prefix = "hero_magnus_mage_rain",
		to = 1,
		from = 1
	},
	magnus_arcane_rain_drop = {
		prefix = "hero_magnus_mage_rain",
		to = 17,
		from = 1
	},
	soldier_magnus_illusion_attack = {
		prefix = "hero_magnus_mage",
		to = 39,
		from = 18
	},
	soldier_magnus_illusion_death = {
		prefix = "states_small",
		to = 72,
		from = 59
	},
	soldier_magnus_illusion_idle = {
		prefix = "hero_magnus_mage",
		to = 1,
		from = 1
	},
	soldier_magnus_illusion_running = {
		prefix = "hero_magnus_mage",
		to = 17,
		from = 2
	},
	soldier_magnus_illusion_shoot = {
		prefix = "hero_magnus_mage",
		to = 93,
		from = 69
	},
	soldier_magnus_illusion_raise = {
		to = 152,
		from = 151,
		prefix = "hero_magnus_mage",
		post = {
			149,
			147,
			147,
			159,
			159,
			143
		}
	},
	hero_denas_attack = {
		prefix = "hero_king",
		to = 25,
		from = 7
	},
	hero_denas_attackBarrell = {
		prefix = "hero_king",
		from = 189,
		to = 194,
		pre = {
			7,
			7
		},
		post = {
			15,
			15,
			17,
			17,
			19,
			19,
			21,
			21,
			21,
			24,
			7
		}
	},
	hero_denas_attackChicken = {
		prefix = "hero_king",
		from = 183,
		to = 188,
		pre = {
			7,
			7
		},
		post = {
			15,
			15,
			17,
			17,
			19,
			19,
			21,
			21,
			21,
			24,
			7
		}
	},
	hero_denas_attackBottle = {
		prefix = "hero_king",
		from = 195,
		to = 200,
		pre = {
			7,
			7
		},
		post = {
			15,
			15,
			17,
			17,
			19,
			19,
			21,
			21,
			21,
			24,
			7
		}
	},
	hero_denas_buffTowers = {
		prefix = "hero_king",
		frames = {
			24,
			7,
			7,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			7
		}
	},
	hero_denas_catapult = {
		prefix = "hero_king",
		to = 118,
		from = 80
	},
	hero_denas_death = {
		prefix = "hero_king",
		to = 155,
		from = 143
	},
	hero_denas_idle = {
		prefix = "hero_king",
		to = 1,
		from = 1
	},
	hero_denas_levelUp = {
		prefix = "hero_king",
		to = 182,
		from = 156
	},
	hero_denas_respawn = {
		prefix = "hero_king",
		to = 182,
		from = 162
	},
	hero_denas_shoot = {
		prefix = "hero_king",
		to = 25,
		from = 7
	},
	hero_denas_running = {
		prefix = "hero_king",
		to = 6,
		from = 2
	},
	hero_denas_cursing = {
		prefix = "hero_king_cursing",
		to = 7,
		from = 1
	},
	mod_denas_tower = {
		prefix = "hero_king_towerBuff",
		to = 18,
		from = 1
	},
	hero_ignus_attack = {
		prefix = "hero_elemental",
		to = 32,
		from = 14
	},
	hero_ignus_death = {
		prefix = "hero_elemental",
		to = 110,
		from = 95
	},
	hero_ignus_idle = {
		prefix = "hero_elemental",
		to = 1,
		from = 1
	},
	hero_ignus_levelUp = {
		prefix = "hero_elemental",
		to = 56,
		from = 33
	},
	hero_ignus_respawn = {
		prefix = "hero_elemental",
		to = 80,
		from = 67
	},
	hero_ignus_running = {
		prefix = "hero_elemental",
		to = 13,
		from = 2
	},
	hero_ignus_flamingFrenzy = {
		prefix = "hero_elemental",
		to = 56,
		from = 41
	},
	hero_ignus_surgeOfFlame = {
		prefix = "hero_elemental",
		to = 85,
		from = 81
	},
	hero_ignus_surgeOfFlame_end = {
		prefix = "hero_elemental",
		to = 94,
		from = 86
	},
	ps_hero_ignus_run = {
		prefix = "hero_elemental_particle",
		to = 14,
		from = 1
	},
	ps_hero_ignus_idle = {
		prefix = "hero_elemental_particle_idle",
		to = 13,
		from = 1
	},
	fx_burn_small = {
		prefix = "burn_small",
		to = 15,
		from = 1
	},
	fx_burn_big = {
		prefix = "burn_big",
		to = 15,
		from = 1
	},
	decal_ignus_flaming = {
		prefix = "hero_elemental_blast",
		to = 12,
		from = 1
	},
	ps_hero_ignus_smoke = {
		to = 2,
		from = 1,
		prefix = "fireball_particle",
		post = {
			2,
			2,
			3,
			4
		}
	},
	hero_ingvar_ancestors = {
		prefix = "hero_viking",
		to = 216,
		from = 175
	},
	hero_ingvar_attack = {
		prefix = "hero_viking",
		to = 38,
		from = 8
	},
	hero_ingvar_attack2 = {
		prefix = "hero_viking",
		to = 76,
		from = 39
	},
	hero_ingvar_death = {
		prefix = "hero_viking",
		to = 247,
		from = 240
	},
	hero_ingvar_idle = {
		prefix = "hero_viking",
		to = 1,
		from = 1
	},
	hero_ingvar_levelup = {
		prefix = "hero_viking",
		to = 239,
		from = 217
	},
	hero_ingvar_respawn = {
		prefix = "hero_viking",
		to = 239,
		from = 221
	},
	hero_ingvar_running = {
		prefix = "hero_viking",
		to = 7,
		from = 2
	},
	hero_ingvar_toBear = {
		prefix = "hero_viking",
		to = 96,
		from = 77
	},
	hero_ingvar_bear_attack = {
		to = 168,
		from = 112,
		prefix = "hero_viking",
		post = {
			97
		}
	},
	hero_ingvar_bear_idle = {
		prefix = "hero_viking",
		to = 97,
		from = 97
	},
	hero_ingvar_bear_running = {
		prefix = "hero_viking",
		to = 174,
		from = 169
	},
	hero_ingvar_bear_toViking = {
		prefix = "hero_viking",
		to = 111,
		from = 98
	},
	soldier_ingvar_ancestor_attack = {
		prefix = "hero_viking_ancestor",
		to = 33,
		from = 8
	},
	soldier_ingvar_ancestor_death = {
		prefix = "hero_viking_ancestor",
		to = 85,
		from = 69
	},
	soldier_ingvar_ancestor_idle = {
		prefix = "hero_viking_ancestor",
		to = 1,
		from = 1
	},
	soldier_ingvar_ancestor_raise = {
		prefix = "hero_viking_ancestor",
		to = 68,
		from = 34
	},
	soldier_ingvar_ancestor_running = {
		prefix = "hero_viking_ancestor",
		to = 7,
		from = 2
	},
	ps_hero_10yr_particle_fire = {
		prefix = "10yr_particle_fire",
		to = 13,
		from = 1
	},
	decal_10yr_bomb_spike = {
		prefix = "10yr_bomb_rocks",
		to = 17,
		from = 1
	},
	hero_10yr_respawn = {
		prefix = "hero_10yr_levelup",
		to = 14,
		from = 1
	},
	hero_10yr_idle = {
		prefix = "hero_10yr_idle",
		to = 1,
		from = 1
	},
	hero_10yr_running = {
		prefix = "hero_10yr_running",
		to = 14,
		from = 1
	},
	hero_10yr_death = {
		prefix = "hero_10yr_death",
		to = 58,
		from = 1
	},
	hero_10yr_levelup = {
		prefix = "hero_10yr_levelup",
		to = 14,
		from = 1
	},
	hero_10yr_teleport_out = {
		prefix = "hero_10yr_teleport_out",
		to = 14,
		from = 1
	},
	hero_10yr_teleport_in = {
		prefix = "hero_10yr_teleport_in",
		to = 14,
		from = 1
	},
	hero_10yr_attack = {
		prefix = "hero_10yr_attack",
		to = 39,
		from = 1
	},
	hero_10yr_attack2 = {
		prefix = "hero_10yr_attack2",
		to = 37,
		from = 1
	},
	hero_10yr_power_rain_start = {
		prefix = "hero_10yr_power_rain_start",
		to = 17,
		from = 1
	},
	hero_10yr_power_rain_loop = {
		prefix = "hero_10yr_power_rain_loop",
		to = 10,
		from = 1
	},
	hero_10yr_power_rain_end = {
		prefix = "hero_10yr_power_rain_end",
		to = 21,
		from = 1
	},
	hero_10yr_buffed_idle = {
		prefix = "hero_10yr_buffed_idle",
		to = 1,
		from = 1
	},
	hero_10yr_buffed_running = {
		prefix = "hero_10yr_buffed_running",
		to = 24,
		from = 1
	},
	hero_10yr_buffed_spin_start = {
		prefix = "hero_10yr_buffed_spin_start",
		to = 16,
		from = 1
	},
	hero_10yr_buffed_spin_loop = {
		prefix = "hero_10yr_buffed_spin_loop",
		to = 8,
		from = 1
	},
	hero_10yr_buffed_spin_end = {
		prefix = "hero_10yr_buffed_spin_end",
		to = 22,
		from = 1
	},
	hero_10yr_buffed_bomb = {
		prefix = "hero_10yr_buffed_bomb",
		to = 47,
		from = 1
	},
	hero_10yr_normal_to_buffed = {
		prefix = "hero_10yr_normal_to_buffed",
		to = 28,
		from = 1
	},
	hero_10yr_buffed_to_normal = {
		prefix = "hero_10yr_buffed_to_normal",
		to = 31,
		from = 1
	},
	decal_sheep_big_idle = {
		prefix = "sheep_big",
		to = 1,
		from = 1
	},
	decal_sheep_big_play = {
		prefix = "sheep_big",
		to = 27,
		from = 2
	},
	decal_sheep_small_idle = {
		prefix = "sheep_small",
		to = 1,
		from = 1
	},
	decal_sheep_small_play = {
		prefix = "sheep_small",
		to = 27,
		from = 2
	},
	decal_mill_big = {
		prefix = "molino_big",
		to = 16,
		from = 1
	},
	decal_mill_small = {
		prefix = "molino_small",
		to = 16,
		from = 1
	},
	decal_boat_small_idle = {
		prefix = "boat1",
		to = 33,
		from = 1
	},
	decal_boat_big_idle = {
		prefix = "boat2",
		to = 35,
		from = 1
	},
	decal_fish_jump = {
		prefix = "fish",
		to = 22,
		from = 1
	},
	decal_water_spark_play = {
		prefix = "water_sparks",
		to = 25,
		from = 1
	},
	decal_water_wave_play = {
		prefix = "water_wave",
		to = 13,
		from = 1
	},
	decal_goat_idle = {
		prefix = "goat",
		to = 1,
		from = 1
	},
	decal_goat_play = {
		prefix = "goat",
		to = 30,
		from = 2
	},
	decal_burner_big_idle = {
		prefix = "stage12_burnerBig",
		to = 12,
		from = 1
	},
	decal_burner_small_idle = {
		prefix = "stage12_burnerSmall",
		to = 12,
		from = 1
	},
	decal_fredo_idle = {
		prefix = "stage13_fredo",
		to = 1,
		from = 1
	},
	decal_fredo_release = {
		prefix = "stage13_fredo",
		to = 139,
		from = 11
	},
	decal_fredo_clicked = {
		prefix = "stage13_fredo",
		to = 10,
		from = 1
	},
	decal_orc_burner_idle = {
		prefix = "orc_burner",
		to = 12,
		from = 1
	},
	decal_orc_flag_idle = {
		prefix = "orc_flag",
		to = 17,
		from = 1
	},
	decal_swamp_bubble_jump = {
		prefix = "stage15_bubble",
		to = 48,
		from = 1
	},
	decal_demon_portal_big_active = {
		prefix = "stage15_portal",
		to = 24,
		from = 1
	},
	decal_s17_barricade_idle = {
		prefix = "stage17_barricade",
		to = 1,
		from = 1
	},
	decal_s17_barricade_destroy = {
		prefix = "stage17_barricade",
		to = 10,
		from = 2
	},
	decal_bandits_flag_idle = {
		prefix = "stage17_flag",
		to = 15,
		from = 1
	},
	decal_scrat_idle = {
		prefix = "Stage18_squirrel",
		ranges = {
			{
				1,
				15
			},
			{
				1,
				15
			},
			{
				20,
				44
			}
		}
	},
	decal_scrat_play = {
		prefix = "Stage18_squirrel",
		to = 139,
		from = 45
	},
	decal_scrat_ice_idle = {
		prefix = "Stage18_squirrel_ice",
		to = 1,
		from = 1
	},
	decal_scrat_ice_play = {
		prefix = "Stage18_squirrel_ice",
		to = 139,
		from = 45
	},
	decal_scrat_ice_end = {
		prefix = "Stage18_squirrel_ice",
		to = 139,
		from = 139
	},
	decal_scrat_touch_fx = {
		prefix = "Stage18_squirrel_touchFx",
		to = 12,
		from = 1
	},
	decal_troll_flag_idle = {
		prefix = "Stage19_flag",
		to = 18,
		from = 1
	},
	decal_troll_burner_idle = {
		prefix = "Stage19_burner",
		to = 11,
		from = 1
	},
	decal_frozen_mushroom_idle = {
		prefix = "FrozenMushroom",
		to = 1,
		from = 1
	},
	decal_frozen_mushroom_clicked = {
		prefix = "FrozenMushroom",
		to = 18,
		from = 2
	},
	decal_lava_fall_idle = {
		prefix = "Inferno_Stg20_LavaFall",
		to = 21,
		from = 1
	},
	decal_inferno_bubble_jump = {
		prefix = "Inferno_LavaBubble",
		to = 47,
		from = 1
	},
	decal_lava_splash_jump = {
		prefix = "Inferno_Lava",
		to = 30,
		from = 1
	},
	decal_inferno_portal_active = {
		prefix = "InfernoPortal",
		to = 24,
		from = 1
	},
	decal_inferno_ground_portal_active = {
		prefix = "InfernoGroundPortal",
		to = 16,
		from = 1
	},
	decal_s21_hellboy_idle = {
		prefix = "Inferno_Stg21_HellBoy",
		to = 8,
		from = 1
	},
	decal_s23_splinter_idle = {
		prefix = "splinter_noPizza",
		to = 1,
		from = 1
	},
	decal_s23_splinter_clicked = {
		prefix = "splinter_noPizza",
		to = 30,
		from = 2
	},
	decal_s23_splinter_pizza_idle = {
		prefix = "splinter",
		to = 1,
		from = 1
	},
	decal_s23_splinter_pizza_clicked = {
		prefix = "splinter",
		to = 47,
		from = 2
	},
	decal_bat_flying_play = {
		prefix = "Bat",
		to = 8,
		from = 1
	},
	decal_s24_nevermore_idle = {
		prefix = "neverMore",
		to = 1,
		from = 1
	},
	decal_s24_nevermore_clicked = {
		prefix = "neverMore",
		to = 50,
		from = 2
	},
	decal_s24_nevermore_fly = {
		prefix = "neverMore",
		to = 56,
		from = 51
	},
	decal_blackburn_weed_idle = {
		prefix = "CB_yuyo",
		to = 34,
		from = 1
	},
	decal_blackburn_waves_jump = {
		prefix = "CB_water_wave",
		to = 24,
		from = 1
	},
	decal_blackburn_bubble_jump = {
		prefix = "CB_bubble",
		to = 46,
		from = 1
	},
	decal_blackburn_smoke_jump = {
		prefix = "CB_smoke",
		to = 21,
		from = 1
	},
	decal_s25_nessie_idle = {
		prefix = "nessMonster",
		to = 1,
		from = 1
	},
	decal_s25_nessie_bubble_in = {
		prefix = "nessMonster",
		to = 9,
		from = 1
	},
	decal_s25_nessie_bubble_out = {
		prefix = "nessMonster",
		to = 41,
		from = 32
	},
	decal_s25_nessie_bubble_play = {
		prefix = "nessMonster",
		to = 31,
		from = 10
	},
	decal_s25_nessie_clicked = {
		prefix = "nessMonster",
		to = 168,
		from = 42
	},
	decal_s26_cage_idle = {
		prefix = "CB_Stg26_cage",
		to = 1,
		from = 1
	},
	decal_s26_cage_play = {
		prefix = "CB_Stg26_cage",
		to = 21,
		from = 1
	},
	decal_s26_hangmen_idle = {
		prefix = "CB_Stg26_hanged",
		to = 1,
		from = 1
	},
	decal_s26_hangmen_play = {
		prefix = "CB_Stg26_hanged",
		to = 35,
		from = 1
	},
	decal_s81_percussionist_idle = {
		prefix = "endless_boss_percusion",
		to = 1,
		from = 1
	},
	decal_s81_percussionist_play = {
		prefix = "endless_boss_percusion",
		to = 11,
		from = 2
	},
	mod_elder_shaman_speed = {
		prefix = "buff_magic",
		to = 22,
		from = 1
	},
	small_freeze_explosion = {
		prefix = "small_freeze_explosion",
		to = 21,
		from = 1
	},
	atomic_bomb_plane_wing = {
		prefix = "atomicBomb_plane_wing",
		to = 11,
		from = 1
	},
	atomic_bomb_plane_engine = {
		prefix = "atomicBomb_plane_engine",
		to = 6,
		from = 1
	},
---皇家护卫	
	tower_imperial_flag = {
		prefix = "royalFlag",
		to = 9,
		from = 1
	},
---精英军团弓兵	
	explosion_flare_hammerhold = {
		prefix = "hammerhold_flare_explosion",
		to = 13,
		from = 1
	},
	legion_archer_flare = {
		prefix = "legion_archer_flare_proy",
		to = 12,
		from = 1
	},
	explosion_flare_legion_archer = {
		prefix = "legion_archer_flare_explosion",
		to = 13,
		from = 1
	},
---初代法师塔
	g1_towermagelvl1_idle = {
		prefix = "g1_mage_lvl1",
		to = 1,
		from = 1
	},
	g1_towermagelvl1_shoot = {
		prefix = "g1_mage_lvl1",
		to = 12,
		from = 1
	},
	g1_towermagelvl2_idle = {
		prefix = "g1_mage_lvl2",
		to = 1,
		from = 1
	},
	g1_towermagelvl2_shoot = {
		prefix = "g1_mage_lvl2",
		to = 12,
		from = 1
	},
	g1_towermagelvl3_idle = {
		prefix = "g1_mage_lvl3",
		to = 1,
		from = 1
	},
	g1_towermagelvl3_shoot = {
		prefix = "g1_mage_lvl3",
		to = 12,
		from = 1
	},
---初代炮塔
	g1_towerengineerlvl1_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "g1_tower_artillery_lvl1_layer%i",
		to = 1,
		layer_from = 1
	},
	g1_towerengineerlvl1_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "g1_tower_artillery_lvl1_layer%i",
		to = 35,
		layer_from = 1
	},
	g1_towerengineerlvl2_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "g1_tower_artillery_lvl2_layer%i",
		to = 1,
		layer_from = 1
	},
	g1_towerengineerlvl2_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "g1_tower_artillery_lvl2_layer%i",
		to = 35,
		layer_from = 1
	},
	g1_towerengineerlvl3_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "g1_tower_artillery_lvl3_layer%i",
		to = 1,
		layer_from = 1
	},
	g1_towerengineerlvl3_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "g1_tower_artillery_lvl3_layer%i",
		to = 35,
		layer_from = 1
	},
---初代弓箭塔
	g1_shooterarcherlvl1_idleDown = {
		prefix = "g1_tower_archer_lvl1_shooter",
		to = 1,
		from = 1
	},
	g1_shooterarcherlvl1_idleUp = {
		prefix = "g1_tower_archer_lvl1_shooter",
		to = 2,
		from = 2
	},
	g1_shooterarcherlvl1_shootingDown = {
		prefix = "g1_tower_archer_lvl1_shooter",
		to = 10,
		from = 3
	},
	g1_shooterarcherlvl1_shootingUp = {
		prefix = "g1_tower_archer_lvl1_shooter",
		to = 18,
		from = 11
	},
	g1_shooterarcherlvl2_idleDown = {
		prefix = "g1_tower_archer_lvl2_shooter",
		to = 1,
		from = 1
	},
	g1_shooterarcherlvl2_idleUp = {
		prefix = "g1_tower_archer_lvl2_shooter",
		to = 2,
		from = 2
	},
	g1_shooterarcherlvl2_shootingDown = {
		prefix = "g1_tower_archer_lvl2_shooter",
		to = 10,
		from = 3
	},
	g1_shooterarcherlvl2_shootingUp = {
		prefix = "g1_tower_archer_lvl2_shooter",
		to = 18,
		from = 11
	},
	g1_shooterarcherlvl3_idleDown = {
		prefix = "g1_tower_archer_lvl3_shooter",
		to = 1,
		from = 1
	},
	g1_shooterarcherlvl3_idleUp = {
		prefix = "g1_tower_archer_lvl3_shooter",
		to = 2,
		from = 2
	},
	g1_shooterarcherlvl3_shootingDown = {
		prefix = "g1_tower_archer_lvl3_shooter",
		to = 10,
		from = 3
	},
	g1_shooterarcherlvl3_shootingUp = {
		prefix = "g1_tower_archer_lvl3_shooter",
		to = 18,
		from = 11
	},
---初代兵营
	g1_towerbarracklvl1_door_open = {
		prefix = "g1_tower_barracks_lvl1_layer2",
		to = 5,
		from = 1
	},
	g1_towerbarracklvl2_door_open = {
		prefix = "g1_tower_barracks_lvl2_layer2",
		to = 5,
		from = 1
	},
	g1_towerbarracklvl3_door_open = {
		prefix = "g1_tower_barracks_lvl3_layer2",
		to = 5,
		from = 1
	},
	g1_towerbarracklvl1_door_close = {
		prefix = "g1_tower_barracks_lvl1_layer2",
		to = 25,
		from = 22
	},
	g1_towerbarracklvl2_door_close = {
		prefix = "g1_tower_barracks_lvl2_layer2",
		to = 25,
		from = 22
	},
	g1_towerbarracklvl3_door_close = {
		prefix = "g1_tower_barracks_lvl3_layer2",
		to = 25,
		from = 22
	},
	g1_soldiermilitia_idle = {
		prefix = "g1_soldier_lvl1",
		to = 1,
		from = 1
	},
	g1_soldiermilitia_running = {
		prefix = "g1_soldier_lvl1",
		to = 6,
		from = 2
	},
	g1_soldiermilitia_attack = {
		prefix = "g1_soldier_lvl1",
		to = 17,
		from = 7
	},
	g1_soldiermilitia_death = {
		prefix = "g1_soldier_lvl1",
		to = 23,
		from = 18
	},
	g1_soldierfootmen_idle = {
		prefix = "g1_soldier_lvl2",
		to = 1,
		from = 1
	},
	g1_soldierfootmen_running = {
		prefix = "g1_soldier_lvl2",
		to = 6,
		from = 2
	},
	g1_soldierfootmen_attack = {
		prefix = "g1_soldier_lvl2",
		to = 17,
		from = 7
	},
	g1_soldierfootmen_death = {
		prefix = "g1_soldier_lvl2",
		to = 23,
		from = 18
	},
	g1_soldierknight_idle = {
		prefix = "g1_soldier_lvl3",
		to = 1,
		from = 1
	},
	g1_soldierknight_running = {
		prefix = "g1_soldier_lvl3",
		to = 6,
		from = 2
	},
	g1_soldierknight_attack = {
		prefix = "g1_soldier_lvl3",
		to = 17,
		from = 7
	},
	g1_soldierknight_death = {
		prefix = "g1_soldier_lvl3",
		to = 23,
		from = 18
	},
	---沙虫巢穴
	tower_sandworm_idle = {
		prefix = "sandworm_attack",
		to = 4,
		from = 4
	},
	tower_sandworm_shoot = {
		prefix = "sandworm_attack",
		to = 3,
		from = 21
	},
	tower_sandworm_eat = {
		prefix = "sandworm_attack",
		to = 95,
		from = 29
	},
	tower_sandworm_shooter_shoot = {
		prefix = "sandworm_attack",
		to = 3,
		from = 21
	},	
	tower_sandworm_shooter_eat = {
		prefix = "sandworm_attack",
		to = 95,
		from = 29
	},
	tower_sandworm_shooter_idleDown = {
		prefix = "SaurianBroodguard",
			to = 67,
			from = 67
		},
	tower_sandworm_shooter_idleUp = {
		prefix = "SaurianBroodguard",
			to = 67,
			from = 67
		},
	tower_sandworm_shooter_shootingDown = {
		prefix = "SaurianBroodguard",
			to = 67,
			from = 67
		},
	tower_sandworm_shooter_shootingUp = {
		prefix = "SaurianBroodguard",
			to = 67,
			from = 67
		},
	tower_sandworm_shooter_polymorphUp = {
		prefix = "SaurianBroodguard",
			to = 67,
			from = 67
		},
	tower_sandworm_shooter_polymorphDown = {
		prefix = "SaurianBroodguard",
			to = 67,
			from = 67
		},
	fx_tower_sandworm = {
		prefix = "SaurianBroodguard",
			to = 67,
			from = 67
		},
	decal_teeth = {
		prefix = "sandworm_decal",
		to = 10,
		from = 1
	},
	decal_worm = {
		prefix = "sandworm_attack",
			to = 41,
			from = 1
	},
	soldier_tremor_idle = {
		prefix = "tremor",
			to = 44,
			from = 44
	},
	soldier_tremor_running = {
		prefix = "tremor",
			to = 14,
			from = 1
	},
	soldier_tremor_attack = {
		prefix = "tremor",
			to = 62,
			from = 43
	},
	soldier_tremor_death = {
		prefix = "tremor",
			to = 97,
			from = 83
	},
	soldier_tremor_raise = {
		prefix = "tremor",
			to = 75,
			from = 64
	},
	sand_wormteeth = {
		prefix = "sandworm_decal_teeth",
			to = 1,
			from = 5
	},
	---圣骑兵
	soldier_paladin_rider_idle = {
		prefix = "HolyKnight",
		to = 1,
		from = 1
	},
	soldier_paladin_rider_running = {
		prefix = "HolyKnight",
		to = 6,
		from = 1
	},
	soldier_paladin_rider_attack = {
		to = 15,
		from = 7,
		prefix = "HolyKnight",
		post = {
			1
		}
	},
	soldier_paladin_rider_raise = {
		prefix = "HolyKnight",
		to = 34,
		from = 16
	},
	soldier_paladin_rider_death = {
		prefix = "HolyKnight",
		to = 55,
		from = 35
	},
	soldier_paladin_rider_holystrike = {
		prefix = "HolyKnight",
		to = 50,
		from = 35
	},
	tower_HolyFlag = {
		prefix = "HolyFlag",
		to = 9,
		from = 1
	},
    ---矮人电击手
	hero_voltaire_idle = {
		prefix = "hero_voltaire",
		to = 32,
		from = 1
	},
	hero_voltaire_running = {
		prefix = "hero_voltaire",
		frames = {
		33,
		35,
		37,
		39,
		41,
		43,
		45,
		47
		}
	},
	hero_voltaire_levelUp = {
		prefix = "hero_voltaire",
		to = 72,
		from = 49
	},
	hero_voltaire_respawn = {
		prefix = "hero_voltaire",
		to = 72,
		from = 49
	},
	hero_voltaire_attack = {
		prefix = "hero_voltaire",
		to = 86,
		from = 73,
		post = {
			1
		}
	},
	hero_voltaire_toss = {
		prefix = "hero_voltaire",
		frames = {
		87,
		73,
		88,
		89,
		90,
		91,
		92,
		93,
		94,
		89,
		90,
		91,
		92,
		93,
		94,
		89,
		90,
		91,
		92,
		93,
		94,
		95,
		96,
		97,
		98,
		99,
		100,
		101,
		102,
		103,
		104,
		105,
		106,
		107,
		108,
		109,
		110,
		111,
		112,
		1
		}
	},
	hero_voltaire_throw = {
		prefix = "hero_voltaire",
		to = 128,
		from = 113,
		post = {
			1
		}
	},
	hero_voltaire_death = {
		prefix = "hero_voltaire",
		to = 170,
		from = 129,
	},
	voltaire_toss_proj = {
		prefix = "voltaire_toss_proj",
		to = 10,
		from = 1,
	},
	voltaire_toss_decal = {
		prefix = "voltaire_toss_decal",
		to = 17,
		from = 1,
	},
	voltaire_coil_idle = {
		prefix = "voltaire_coil",
		to = 1,
		from = 1,
	},
	voltaire_coil_raise = {
		prefix = "voltaire_coil",
		to = 14,
		from = 3,
		post = {
			1
		}
	},
	voltaire_coil_attack = {
		prefix = "voltaire_coil",
		to = 42,
		from = 15,
		post = {
			37,
			38,
			39,
			40,
			41,
			42,
			43,
			44,
			45,
			46,
			1
		}
	},
	voltaire_coil_death = {
		prefix = "voltaire_coil",
		to = 57,
		from = 47,
	},
	voltaire_toss_proj_idle = {
		prefix = "voltaire_toss_proj",
		to = 10,
		from = 1,
	},
	voltaire_toss_proj_flying = {
		prefix = "voltaire_toss_proj",
		to = 10,
		from = 1,
	},
	---毒蛇
	hero_viper_attack1 = {
		prefix = "hero_viper",
		to = 113,
		from = 100
	},
	hero_viper_attack2 = {
		prefix = "hero_viper",
		to = 127,
		from = 114
	},
	hero_viper_death = {
		prefix = "hero_viper",
		to = 170,
		from = 154
	},
	hero_viper_idle = {
		prefix = "hero_viper",
		to = 63,
		from = 1
	},
	hero_viper_levelUp = {
		prefix = "hero_viper",
		to = 87,
		from = 64
	},
	hero_viper_respawn = {
		prefix = "hero_viper",
		to = 87,
		from = 64
	},
	hero_viper_running = {
		prefix = "hero_viper",
		to = 99,
		from = 88
	},
	hero_viper_sawblade = {
		prefix = "hero_viper",
		to = 137,
		from = 128
	},
	hero_viper_timber = {
		prefix = "hero_viper",
		to = 153,
		from = 138
	},
	viper_shuriken_idle = {
		prefix = "viper_shuriken",
		to = 1,
		from = 1
	},
	viper_shuriken_flying = {
		prefix = "viper_shuriken",
		to = 8,
		from = 1
	},
	viper_curse = {
		prefix = "viper_curse",
		to = 22,
		from = 1
	},
	bolt_necromancer_idle = {
			prefix = "proy_Necromancer",
			to = 1,
			from = 1
		},
	bolt_necromancer_flying = {
			prefix = "proy_Necromancer",
			to = 1,
			from = 1
		},
	bolt_necromancer_hit = {
			prefix = "proy_Necromancer",
			to = 6,
			from = 2
		},
		viper_poison = {
		prefix = "viper_poison",
		to = 12,
		from = 1
	},
	fx_dracolich_fireball_explosion_ground = {
			prefix = "Halloween_hero_bones_proyExplosion",
			to = 14,
			from = 1
		},
	dracolich_fireball_particle_1 = {
			prefix = "Halloween_hero_bones_proyParticle",
			to = 8,
			from = 1
		},
	lightning_attack = {
		prefix = "power_lightning",
		to = 10,
		from = 1
	},
---沙漠幽魂
	hero_munra_attack = {
		prefix = "desertMunra",
		to = 94,
		from = 73
	},
	hero_munra_callofwild = {
		prefix = "desertMunra",
		to = 142,
		from = 119
	},
	hero_munra_death = {
		prefix = "desertMunra",
		to = 200,
		from = 189
	},
	hero_munra_idle = {
		prefix = "desertMunra",
		to = 74,
		from = 74
	},
	hero_munra_levelup = {
		prefix = "desertMunra",
		to = 117,
		from = 95
	},
	hero_munra_multishot = {
		prefix = "desertMunra",
		to = 117,
		from = 95
	},
	hero_munra_respawn = {
		prefix = "desertMunra",
		to = 117,
		from = 95
	},
	hero_munra_running = {
		prefix = "desertMunra",
		to = 24,
		from = 1
	},
	hero_munra_shoot = {
		prefix = "desertMunra",
		to = 117,
		from = 95
	},
	ray_eb_spider = {
		prefix = "spiderQueen_ray",
		to = 14,
		from = 1
	},
	soldier_fallen_attack = {
		prefix = "fallen",
		to = 67,
		from = 48
	},
	soldier_fallen_death = {
		prefix = "fallen",
		to = 113,
		from = 93
	},
	soldier_fallen_idle = {
		prefix = "fallen",
		to = 67,
		from = 67
	},
	soldier_fallen_running = {
		prefix = "fallen",
		to = 16,
		from = 1
	},
	soldier_fallen_spawn = {
		prefix = "fallen",
		to = 146,
		from = 114
	},	
---	重生
	enemy_cursed_shaman_attack = {
		prefix = "cursed_shaman",
		to = 69,
		from = 56,
		post = {
			19
		}
	},
	enemy_cursed_shaman_death = {
		prefix = "cursed_shaman",
		to = 85,
		from = 70
	},
	enemy_cursed_shaman_idle = {
		prefix = "cursed_shaman",
		to = 19,
		from = 19
	},
	enemy_cursed_shaman_shoot = {
		prefix = "cursed_shaman",
		to = 115,
		from = 104
	},
	enemy_cursed_shaman_heal = {
		prefix = "cursed_shaman",
		to = 103,
		from = 86
	},
	enemy_cursed_shaman_thorn = {
		prefix = "cursed_shaman",
		to = 130,
		from = 112
	},
	enemy_cursed_shaman_thornFree = {
		prefix = "cursed_shaman",
		to = 135,
		from = 131
	},
	enemy_cursed_shaman_walkingDown = {
		prefix = "cursed_shaman",
		to = 55,
		from = 38
	},
	enemy_cursed_shaman_walk = {
		prefix = "cursed_shaman",
		to = 18,
		from = 1
	},
	enemy_cursed_shaman_walkingRightLeft = {
		prefix = "cursed_shaman",
		to = 18,
		from = 1
	},
	enemy_cursed_shaman_walkingUp = {
		prefix = "cursed_shaman",
		to = 37,
		from = 20
	},
	bolt_cursed_shaman_idle = {
		prefix = "cursed_shaman_bolt",
		to = 2,
		from = 1
	},
	bolt_cursed_shaman_flying = {
		prefix = "cursed_shaman_bolt",
		to = 2,
		from = 1
	},
	bolt_cursed_shaman_hit = {
		prefix = "cursed_shaman_bolt",
		to = 10,
		from = 3
	},
	enemy_hobgoblin_small_attack = {
		prefix = "hobgoblin_small",
		to = 10,
		from = 2,
		post = {
			1,
		}
	},
	enemy_hobgoblin_small_death = {
		prefix = "hobgoblin_small",
		to = 83,
		from = 77
	},
	enemy_hobgoblin_small_idle = {
		prefix = "hobgoblin_small",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_small_thorn = {
		prefix = "hobgoblin_small",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_small_thornFree = {
		prefix = "hobgoblin_small",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_small_walkingDown = {
		prefix = "hobgoblin_small",
		to = 76,
		from = 55
	},
	enemy_hobgoblin_small_walk = {
		prefix = "hobgoblin_small",
		to = 32,
		from = 11
	},
	enemy_hobgoblin_small_walkingRightLeft = {
		prefix = "hobgoblin_small",
		to = 32,
		from = 11
	},
	enemy_hobgoblin_small_walkingUp = {
		prefix = "hobgoblin_small",
		to = 54,
		from = 33
	},
	enemy_hobgoblin_rider_attack = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_death = {
		prefix = "worg",
		to = 84,
		from = 69
	},
	enemy_hobgoblin_rider_idle = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_thorn = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_thornFree = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_walkingDown = {
		prefix = "hobgoblin_rider",
		to = 30,
		from = 21
	},
	enemy_hobgoblin_rider_walk = {
		prefix = "hobgoblin_rider",
		to = 10,
		from = 2
	},
	enemy_hobgoblin_rider_walkingRightLeft = {
		prefix = "hobgoblin_rider",
		to = 10,
		from = 2
	},
	enemy_hobgoblin_rider_walkingUp = {
		prefix = "hobgoblin_rider",
		to = 20,
		from = 11
	},
	enemy_hobgoblin_rider_runningDown = {
		prefix = "hobgoblin_rider",
		to = 48,
		from = 44
	},
	enemy_hobgoblin_rider_running = {
		prefix = "hobgoblin_rider",
		to = 38,
		from = 31
	},
	enemy_hobgoblin_rider_runningRightLeft = {
		prefix = "hobgoblin_rider",
		to = 38,
		from = 31
	},
	enemy_hobgoblin_rider_runningUp = {
		prefix = "hobgoblin_rider",
		to = 43,
		from = 39
	},
	enemy_hobgoblin_shield_attack = {
		prefix = "hobgoblin_shield",
		to = 124,
		from = 105,
		post = {
			105,
		}
	},
	enemy_hobgoblin_shield_death = {
		prefix = "hobgoblin_shield",
		to = 104,
		from = 87
	},
	enemy_hobgoblin_shield_idle = {
		prefix = "hobgoblin_shield",
		to = 105,
		from = 105
	},
	enemy_hobgoblin_shield_thorn = {
		prefix = "hobgoblin_shield",
		to = 105,
		from = 105
	},
	enemy_hobgoblin_shield_thornFree = {
		prefix = "hobgoblin_shield",
		to = 105,
		from = 105
	},
	enemy_hobgoblin_shield_walkingDown = {
		prefix = "hobgoblin_shield",
		to = 70,
		from = 53
	},
	enemy_hobgoblin_shield_walk = {
		prefix = "hobgoblin_shield",
		to = 52,
		from = 19
	},
	enemy_hobgoblin_shield_walkingRightLeft = {
		prefix = "hobgoblin_shield",
		to = 52,
		from = 19
	},
	enemy_hobgoblin_shield_walkingUp = {
		prefix = "hobgoblin_shield",
		to = 86,
		from = 71
	},
	enemy_hobgoblin_shield_raise = {
			prefix = "hobgoblin_shield",
			to = 105,
			from = 105
	},
		enemy_hobgoblin_shield_burrow = {
			prefix = "hobgoblin_shield",
			to = 105,
			from = 105
	},
		enemy_hobgoblin_shield_teleport = {
			prefix = "states_flying_small",
			to = 10,
			from = 1
	},
	enemy_goblin_spear_attack = {
		to = 98,
		from = 91,
		prefix = "goblin_spear",
		post = {
			1,
		}
	},
	enemy_goblin_spear_death = {
		prefix = "goblin_spear",
		to = 90,
		from = 84
	},
	enemy_goblin_spear_idle = {
		prefix = "goblin_spear",
		to = 1,
		from = 1
	},
	enemy_goblin_spear_shoot = {
		prefix = "goblin_spear",
		to = 17,
		from = 8
	},
	enemy_goblin_spear_thorn = {
		prefix = "goblin_spear",
		to = 86,
		from = 67
	},
	enemy_goblin_spear_thornFree = {
		prefix = "goblin_spear",
		to = 113,
		from = 108
	},
	enemy_goblin_spear_walkingDown = {
		prefix = "goblin_spear",
		to = 83,
		from = 62
	},
	enemy_goblin_spear_walkingRightLeft = {
		prefix = "goblin_spear",
		to = 39,
		from = 18
	},
	enemy_goblin_spear_walk = {
		prefix = "goblin_spear",
		to = 39,
		from = 18
	},
	enemy_goblin_spear_walkingUp = {
		prefix = "goblin_spear",
		to = 61,
		from = 40
	},
	enemy_goblin_balloon_death = {
		prefix = "goblin_balloon",
		to = 105,
		from = 72
	},
	enemy_goblin_balloon_idle = {
		prefix = "goblin_balloon",
		to = 17,
		from = 1
	},
	enemy_goblin_balloon_walkingDown = {
		prefix = "goblin_balloon",
		to = 53,
		from = 36
	},
	enemy_goblin_balloon_walkingRightLeft = {
		prefix = "goblin_balloon",
		to = 17,
		from = 1
	},
	enemy_goblin_balloon_walkingUp = {
		prefix = "goblin_balloon",
		to = 71,
		from = 54
	},
	enemy_goblin_balloon_shoot = {
		prefix = "goblin_balloon",
		to = 35,
		from = 18
	},
	enemy_goblin_platform_death = {
		prefix = "goblin_platform",
		to = 105,
		from = 72
	},
	enemy_goblin_platform_idle = {
		prefix = "goblin_platform",
		to = 17,
		from = 1
	},
	enemy_goblin_platform_walkingDown = {
		prefix = "goblin_platform",
		to = 53,
		from = 36
	},
	enemy_goblin_platform_walkingRightLeft = {
		prefix = "goblin_platform",
		to = 17,
		from = 1
	},
	enemy_goblin_platform_walkingUp = {
		prefix = "goblin_platform",
		to = 71,
		from = 54
	},
	enemy_goblin_platform_shoot = {
		prefix = "goblin_platform",
		to = 35,
		from = 18
	},
	enemy_cursed_golem_attack = {
		prefix = "cursed_golem",
		to = 101,
		from = 76,
		post = {
			1,
		}
	},
	cursed_golem_slam = {
		prefix = "cursed_golem_slam",
		to = 15,
		from = 1
	},
	enemy_cursed_golem_death = {
		prefix = "cursed_golem",
		to = 139,
		from = 102
	},
	enemy_cursed_golem_idle = {
		prefix = "cursed_golem",
		to = 1,
		from = 1
	},
	enemy_cursed_golem_raise = {
		prefix = "cursed_golem",
		to = 173,
		from = 142
	},
	enemy_cursed_golem_thorn = {
		prefix = "cursed_golem",
		to = 121,
		from = 103
	},
	enemy_cursed_golem_thornFree = {
		prefix = "cursed_golem",
		to = 125,
		from = 122
	},
	enemy_cursed_golem_walkingDown = {
		prefix = "cursed_golem",
		to = 75,
		from = 54
	},
	enemy_cursed_golem_walk = {
		prefix = "cursed_golem",
		to = 31,
		from = 2
	},
	enemy_cursed_golem_walkingRightLeft = {
		prefix = "cursed_golem",
		to = 31,
		from = 2
	},
	enemy_cursed_golem_walkingUp = {
		prefix = "cursed_golem",
		to = 53,
		from = 32
	},
	enemy_cursed_shard_idle = {
		prefix = "cursed_shard",
		to = 1,
		from = 1
	},
	enemy_cursed_shard_walkingRightLeft = {
		prefix = "cursed_shard",
		to = 7,
		from = 2
	},
	enemy_cursed_shard_running = {
		prefix = "cursed_shard",
		to = 7,
		from = 2
	},
	enemy_cursed_shard_walk = {
		prefix = "cursed_shard",
		to = 7,
		from = 2
	},
	enemy_cursed_shard_walkingUp = {
		prefix = "cursed_shard",
		to = 13,
		from = 8
	},
	enemy_cursed_shard_walkingDown = {
		prefix = "cursed_shard",
		to = 19,
		from = 14
	},
	enemy_cursed_shard_attack = {
		prefix = "cursed_shard",
		frames = {
		20,
		20,
		21,
		21,
		22,
		22,
		23,
		23,
		24,
		24,
		25,
		25,
		26,
		26,
		27,
		27,
		28,
		28,
		1
		}
	},
	enemy_cursed_shard_death = {
		prefix = "cursed_shard",
		to = 42,
		from = 29
	},
	enemy_cursed_shard_raise = {
		prefix = "cursed_shard",
		to = 29,
		from = 42
	},
	cursed_shield = {
		prefix = "cursed_shield",
		to = 11,
		from = 1
	},
	cursed_heal = {
		prefix = "cursed_heal",
		to = 25,
		from = 1
	},		
	eb_hobgoblin_attack = {
		prefix = "eb_hobgoblin",
		to = 124,
		from = 90
	},
	eb_hobgoblin_death = {
		prefix = "eb_hobgoblin",
		to = 183,
		from = 125
	},
	eb_hobgoblin_idle = {
		prefix = "eb_hobgoblin",
		to = 1,
		from = 1
	},
	eb_hobgoblin_shoot = {
		prefix = "eb_hobgoblin",
		to = 89,
		from = 74
	},
	eb_hobgoblin_walkingRightLeft = {
		prefix = "eb_hobgoblin",
		to = 25,
		from = 2
	},
	eb_hobgoblin_walkingUp = {
		prefix = "eb_hobgoblin",
		to = 49,
		from = 26
	},
	eb_hobgoblin_walkingDown = {
		prefix = "eb_hobgoblin",
		to = 73,
		from = 50
	},
	missile_hobgoblin_flying = {
		prefix = "boss_veznan_soul",
		to = 10,
		from = 1
	},
	missile_hobgoblin_hit = {
		prefix = "boss_veznan_soul",
		to = 14,
		from = 7
	},
	missile_hobgoblin_trail = {
		prefix = "boss_veznan_soul",
		to = 19,
		from = 11
	},
	missile_hobgoblin_sparks1 = {
		prefix = "boss_veznan_soul",
		to = 10,
		from = 1
	},
	missile_hobgoblin_sparks2 = {
		prefix = "boss_veznan_soul",
		to = 10,
		from = 1
	},
	missile_hobgoblin_sparks3 = {
		prefix = "boss_veznan_soul",
		to = 10,
		from = 1
	},
	hobgoblin_teleport = {
		prefix = "hobport",
		to = 28,
		from = 1
	},
	eb_hobgoblin2_attack = {
		prefix = "eb_hobgoblin2",
		to = 53,
		from = 28
	},
	eb_hobgoblin2_attack2 = {
		prefix = "eb_hobgoblin2",
		to = 53,
		from = 28
	},
	eb_hobgoblin2_attack3 = {
		prefix = "eb_hobgoblin2",
		to = 101,
		from = 76
	},
	eb_hobgoblin2_death = {
		prefix = "eb_hobgoblin2",
		to = 149,
		from = 102
	},
	eb_hobgoblin2_idle = {
		prefix = "eb_hobgoblin2",
		to = 1,
		from = 1
	},
	eb_hobgoblin2_shoot = {
		prefix = "eb_hobgoblin2",
		to = 75,
		from = 54
	},
	eb_hobgoblin2_walkingRightLeft = {
		prefix = "eb_hobgoblin2",
		to = 27,
		from = 2
	},
	eb_hobgoblin2_walkingUp = {
		prefix = "eb_hobgoblin2",
		to = 27,
		from = 2
	},
	eb_hobgoblin2_walkingDown = {
		prefix = "eb_hobgoblin2",
		to = 27,
		from = 2
	},
	fx_teleport_hobgoblin_small = {
		prefix = "hobportfx_small",
		to = 11,
		from = 1
	},
	fx_teleport_hobgoblin_big = {
		prefix = "hobportfx_big",
		to = 11,
		from = 1
	},
	eb_hobtransform_death = {
		prefix = "eb_hobtransform",
		to = 106,
		from = 1
	},
	decal_water_fall_idle = {
		prefix = "Stg29_WaterFall",
		to = 9,
		from = 1
	},
	decal_bush1_bl = {
		prefix = "Stg30_FirstBush",
		to = 96,
		from = 1
	},
	decal_bush2_bl = {
		prefix = "Stg30_SecondBush",
		to = 66,
		from = 1
	},
	decal_bush3_bl = {
		prefix = "Stg30_ThirdBush",
		to = 76,
		from = 1
	},
	decal_bridge_bl_close = {
		prefix = "Stg30_Bridge",
		to = 30,
		from = 29
	},
	decal_bridge_bl_open = {
		prefix = "Stg30_Bridge",
		to = 30,
		from = 1
	},
	decal_spikewall_bl = {
		prefix = "Stg31_PikeWall",
		to = 1,
		from = 1
	},
	decal_cavewall_bl = {
		prefix = "Stg31_CaveWall",
		to = 1,
		from = 1
	},
	decal_trashcan_bl = {
		prefix = "bl_trashcan",
		to = 1,
		from = 1
	},
	decal_tape_bl = {
		prefix = "bl_tape",
		to = 1,
		from = 1
	},
	decal_mark_bl = {
		prefix = "bl_mark",
		to = 1,
		from = 1
	},
	decal_dwarf_bl = {
		prefix = "bl_dwarf",
		to = 1,
		from = 1
	},
	decal_knight_bl = {
		prefix = "bl_knight",
		to = 1,
		from = 1
	},
	decal_goldbag_bl_idle = {
		prefix = "bl_goldbag",
		to = 1,
		from = 1
	},
	decal_goldbag_bl_death = {
		prefix = "bl_goldbag",
		to = 8,
		from = 1
	},
	totem_violet_death = {
		prefix = "soldier_gargoyle",
		to = 45,
		from = 45
	},
	totem_violet_walkingRightLeft = {
		prefix = "soldier_gargoyle",
		to = 45,
		from = 45
	},
	bomb_hobgoblin_spawner_open = {
		prefix = "soldier_gargoyle",
		to = 45,
		from = 45
	},
	bomb_hobgoblin_spawner_idle = {
		prefix = "soldier_gargoyle",
		to = 45,
		from = 45
	},
	eb_hobtransform_walkingRightLeft = {
		prefix = "soldier_gargoyle",
		to = 45,
		from = 45
	},
	tower_imperial_flag = {
		prefix = "royalFlag",
		to = 9,
		from = 1
	},
---			
}
local o = {}

o.animations = a

return o
