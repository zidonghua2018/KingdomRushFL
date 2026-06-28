-- chunkname: @./_assets/kr1-desktop/sounds/sounds.lua
return {
---初级塔
	DarkShardHit = {
		loop = false,
		gain = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kra_sfx_tower_duneSentinels_basicAttack_var1_v1.ogg",
			"kra_sfx_tower_duneSentinels_basicAttack_var2_v1.ogg",
			"kra_sfx_tower_duneSentinels_basicAttack_var3_v1.ogg",
			"kra_sfx_tower_duneSentinels_basicAttack_var4_v1.ogg",
			"kra_sfx_tower_duneSentinels_basicAttack_var5_v1.ogg"
		}
	},
	ArcherVTaunt = {
		loop = false,
		gain = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr4_dark_army_archer_backstab_upg.ogg",
			"kr4_dark_army_archer_shadow_mark_upg.ogg"
		}
	},
	BarrackVTaunt = {
		loop = false,
		gain = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr4_dark_army_barrack_taunt_1.ogg",
			"kr4_dark_army_barrack_impervious_upg.ogg",
			"kr4_dark_army_barrack_taunt_3.ogg"
		}
	},
	MageVTaunt = {
		loop = false,
		gain = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr4_ember_lords_mage_taunt_1.ogg",
			"kr4_ember_lords_mage_taunt_2.ogg",
			"kr4_ember_lords_mage_taunt_3.ogg"
		}
	},
	MageVAttack = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"kr4_ember_lords_mage_attack.ogg"
		}
	},
	ArtilleryTaunt = {
		loop = false,
		gain = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kr4_hero_tramin_taunt_2.ogg",
			"kr4_hero_tramin_taunt_3.ogg",
			"kr4_hero_tramin_taunt_4.ogg"
		}
	},
---蜥蜴人狙击塔
	TowerDeathcoilTaunt = {
		loop = false,
		gain = 2,
		source_group = "TAUNTS",
		files = {
			"tower_deathcoil_taunt_1.ogg"
		}
	},
	TowerDeathcoilChargedTaunt = {
		loop = false,
		gain = 2,
		source_group = "TAUNTS",
		files = {
			"tower_deathcoil_taunt_2.ogg"
		}
	},
	TowerDeathcoilStunTaunt = {
		loop = false,
		gain = 2,
		source_group = "TAUNTS",
		files = {
			"tower_deathcoil_taunt_3.ogg"
		}
	},
	SaurianSniperBullet = {
		loop = false,
		gain = 1,
		source_group = "BULLETS",
		files = {
			"KRF_sfx_suarian_sniper.ogg"
		}
	},
	SaurianSniperChargedBullet = {
		loop = false,
		gain = 1,
		source_group = "BULLETS",
		files = {
			"krc_deathcoil_charged_shot.ogg"
		}
	},
	SaurianSniperCharge = {
		loop = false,
		gain = 1,
		source_group = "BULLETS",
		files = {
			"krc_deathcoil_charge.ogg"
		}
	},
	SaurianSniperAim = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"im_sfx_supressor_aim.wav"
		}
	},
	SaurianSniperStunAim = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"krc_deathcoil_stun_charge.ogg"
		}
	},
	SaurianSniperStunBullet = {
		loop = false,
		gain = 1,
		source_group = "BULLETS",
		files = {
			"im_sfx_drgraaf_attackassault-descarga.wav"
		}
	},  
---腐毒菇林	 
	EnemyMushroomBorn = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"KR_sfx_mushroomcreep_nacimiento.ogg"
		}
	},
	EnemyMushroomBossDeath = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"KR_sfx_mushroomboss_muerte.ogg"
		}
	},
	EnemyMushroomDeath = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"KR_sfx_mushroomcreep_muerte_edit_vanzen.ogg"
		}
	},
	EnemyMushroomGas = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"KR_sfx_mushroomboss_gas_op1.ogg"
		}
	},
	RotshroomPunch = {
		loop = false,
		gain = 0.5,
		source_group = "SFX",
		files = {
			"kro_sfx_bram_sopapo[conwhoosh].ogg"
		}
	},   
	TowerRotshroomTaunt = {
		loop = false,
		gain = 3,
		source_group = "TAUNTS",
		files = {
			"tower_rotshroom_taunt-1.ogg"
		}
	},
	TowerRotshroomRotTaunt = {
		loop = false,
		gain = 3,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"tower_rotshroom_rot_taunt-1.ogg",
			"tower_rotshroom_rot_taunt-2.ogg"
		}
	},
	TowerRotshroomPunchTaunt = {
		loop = false,
		gain = 3,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"tower_rotshroom_punch_taunt-1.ogg",
			"tower_rotshroom_punch_taunt-2.ogg"
		}
	},
---红帽地精
	TowerRedcapTaunt = {
		loop = false,
		gain = 0.8,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"tower_redcap_taunt-1.ogg",
			"tower_redcap_taunt-2.ogg",
			"tower_redcap_taunt-3.ogg",
			"tower_redcap_taunt-4.ogg",
		}
	},
	TowerRedcapTauntDodge = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"tower_redcap_taunt_dodge.ogg",
		}
	},
	TowerRedcapTauntHarvest = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"tower_redcap_taunt_harvest.ogg",
		}
	},
	TowerRedcapTauntReap = {
		loop = false,
		gain = 0.8,
		source_group = "TAUNTS",
		files = {
			"tower_redcap_taunt_reap.ogg",
		}
	},	 
---哥布林萨满
	ElvesHeroVeznanDemonFireballHit = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_demonfireball_hit_v3.1.ogg"
		}
	},
	ElvesHeroVeznanDemonFireballThrow = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_demonfireball_throw_v3.ogg"
		}
	},
	EndlessOrcsTotemHealing = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr_sfx_endless_healingtotem_v3.ogg"
		}
	},
	EndlessOrcsTotemDamage = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr_sfx_endless_flametotem_v3.ogg"
		}
	},
	EndlessOrcsTotemSpeed = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr_sfx_endless_swiftnesstotem_v3.ogg"
		}
	},
	TowerShamanTaunt = {
		loop = false,
		gain = 1.2,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"tower_shaman_taunt-1.ogg",
			"tower_shaman_taunt-2.ogg"
		}
	},
	TowerShamanHealTaunt = {
		loop = false,
		gain = 1.2,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"tower_shaman_heal_taunt-1.ogg",
			"tower_shaman_heal_taunt-2.ogg"
		}
	},
	TowerShamanSpeedTaunt = {
		loop = false,
		gain = 1.2,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"tower_shaman_speed_taunt-1.ogg",
			"tower_shaman_speed_taunt-2.ogg"
		}
	},		
}
