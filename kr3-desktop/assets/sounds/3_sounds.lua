-- chunkname: @./kr3-desktop/assets/sounds/sounds.lua

return {
	AreaAttack = {
		gain = 1,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_CommonAreaHit.ogg",
		},
	},
	ArrowSound = {
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_ArrowRelease2.ogg",
			"Sound_ArrowRelease3.ogg",
		},
	},
	AxeSound = {
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_BattleAxe.ogg",
		},
	},
	BoltSorcererSound = {
		gain = 0.68,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_Sorcerer.ogg",
		},
	},
	BoltSound = {
		gain = 0.68,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_MageShot.ogg",
		},
	},
	BombExplosionSound = {
		gain = 0.8,
		loop = false,
		source_group = "EXPLOSIONS",
		files = {
			"Sound_Bomb1.ogg",
		},
	},
	BombShootSound = {
		gain = 0.75,
		loop = false,
		source_group = "EXPLOSIONS",
		files = {
			"Sound_EngineerShot.ogg",
		},
	},
	CommonLightning = {
		gain = 1,
		loop = false,
		mode = "sequence",
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_lightning_op1.ogg",
			"kr3_sfx_lightning_op2.ogg",
			"kr3_sfx_lightning_op3.ogg",
		},
	},
	DeathBig = {
		loop = false,
		source_group = "DEATH",
		files = {
			"Sound_EnemyBigDead.ogg",
		},
	},
	DeathEplosion = {
		gain = 0.4,
		loop = false,
		source_group = "DEATH",
		files = {
			"Sound_EnemyExplode1.ogg",
		},
	},
	DeathGoblin = {
		loop = false,
		source_group = "DEATH",
		files = {
			"Sound_EnemyGoblinDead.ogg",
		},
	},
	DeathHuman = {
		loop = false,
		mode = "random",
		source_group = "DEATH",
		files = {
			"Sound_HumanDead1.ogg",
			"Sound_HumanDead2.ogg",
			"Sound_HumanDead3.ogg",
			"Sound_HumanDead4.ogg",
		},
	},
	DeathOrc = {
		loop = false,
		source_group = "DEATH",
		files = {
			"Sound_EnemyOrcDead.ogg",
		},
	},
	DeathPuff = {
		gain = 0.8,
		loop = false,
		source_group = "DEATH",
		files = {
			"Sound_EnemyPuffDead.ogg",
		},
	},
	DeathSkeleton = {
		loop = false,
		source_group = "DEATH",
		files = {
			"Sound_EnemySkeletonBreak2.ogg",
		},
	},
	DeathTroll = {
		loop = false,
		source_group = "DEATH",
		files = {
			"Sound_EnemyTrollDead.ogg",
		},
	},
	ElvenWoodsAmbienceSound = {
		gain = 0.3,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kre_sfx_ambience_singlebirdandstream.ogg",
			"kro_sfx_ambience_wardrums[op1].ogg",
			"kro_sfx_ambience_wardrums[op2].ogg",
			"kro_sfx_ambience_wardrums[op3].ogg",
			"kre_sfx_ambience_singlebirdandstream.ogg",
			"kro_sfx_hulkingrage_mining_v2[op1].ogg",
			"kro_sfx_hulkingrage_mining_v2[op2].ogg",
			"kro_sfx_hulkingrage_mining_v2[op1].ogg",
			"kro_sfx_hulkingrage_mining_v2[op2].ogg",
			"kre_sfx_ambience_singlebirdandstream.ogg",
		},
	},
	ElvesAchievementDwarfFall = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_dwarfdeath[barrel].ogg",
		},
	},
	ElvesAchievementHobbit = {
		gain = 0.2,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_achievement_mario.ogg",
		},
	},
	ElvesAchievementScissorFingers = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_achievement_scissorfingers_v2.ogg",
		},
	},
	ElvesAchievementSorcapprenticeBook = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_sorcapprentice_book[op1].ogg",
		},
	},
	ElvesAchievementSorcapprenticeBroom = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_sorcapprentice_broom.ogg",
		},
	},
	ElvesAchievementSorcapprenticeHat = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_sorcapprentice_hat[sinexplo].ogg",
		},
	},
	ElvesAchievementWilson = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_wilson[op1].ogg",
		},
	},
	ElvesAchievementYellowSubmarine = {
		gain = 0.6,
		loop = false,
		source_group = "SFX",
		files = {
			"kr_yellow_submarine_custom.ogg",
		},
	},
	ElvesArcherArcaneBurstTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"ArcaneArcher_BurstArrow-01a.ogg",
		},
	},
	ElvesArcherArcaneSleepTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"ArcaneArcher_SleepArrow-01c.ogg",
		},
	},
	ElvesArcherArcaneTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"ArcaneArcher_Ready-01a.ogg",
		},
	},
	ElvesArcherGoldenBowCrimsonTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"GoldenBows_Crimson-01b.ogg",
		},
	},
	ElvesArcherGoldenBowMarkTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"GoldenBows_Mark-01b.ogg",
		},
	},
	ElvesArcherGoldenBowTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"GoldenBows_Ready[2]-01d.ogg",
		},
	},
	ElvesArcherTaunt = {
		gain = 0.6,
		ignore = 1.5,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Archers_Taunt-01a.ogg",
			"Archers_Taunt-02a.ogg",
			"Archers_Taunt-03e.ogg",
		},
	},
	ElvesAshbiteConfirm = {
		gain = 0.6,
		loop = false,
		mode = "sequence",
		source_group = "SPECIALS",
		files = {
			"kro_sfx_ashbite_confirm_v1[op1].ogg",
			"kro_sfx_ashbite_confirm_v1[op2].ogg",
		},
	},
	ElvesAshbiteDeath = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"hero_dragon_death.ogg",
		},
	},
	ElvesAshbiteFireball = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"hero_dragon_fireball_explode.ogg",
		},
	},
	ElvesAshbiteFlameThrower = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"hero_dragon_flamethrower.ogg",
		},
	},
	ElvesAshbiteSmoke = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"hero_dragon_smoke.ogg",
		},
	},
	ElvesAshbiteSpit = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"hero_dragon_spit.ogg",
		},
	},
	ElvesBajNimenBossDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_boss-death[conriser].ogg",
		},
	},
	ElvesBajNimenBossHeal = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_boss-heal.ogg",
		},
	},
	ElvesBajNimenBossRangedAttack = {
		gain = 1,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kro_sfx_bitteringrancor_boss-rangedattack[op2].ogg",
		},
	},
	ElvesBajNimenBossShadowCast = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_boss-shadowstorm[cast].ogg",
		},
	},
	ElvesBajNimenBossShadowImpact = {
		gain = 0.3,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kro_sfx_bitteringrancor_boss-shadowstorm[impact].ogg",
		},
	},
	ElvesBajNimenBossShadowTravel = {
		gain = 0.5,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kro_sfx_bitteringrancor_boss-shadowstorm[travel].ogg",
		},
	},
	ElvesBajNimenBossTail = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_boss-tailwhip.ogg",
		},
	},
	ElvesBalrogAttack = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_godieth_attack.ogg",
		},
	},
	ElvesBalrogBloodpool = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_godieth_bloodpool.ogg",
		},
	},
	ElvesBalrogDeath = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_godieth_death[op2].ogg",
		},
	},
	ElvesBalrogSpit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_godieth_spit.ogg",
		},
	},
	ElvesBarrackBladesingerBladeDanceTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Bladesinger_BladeDance[2]-01a.ogg",
		},
	},
	ElvesBarrackBladesingerPerfectParryTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Bladesinger_PerfectParry[2]-01d.ogg",
		},
	},
	ElvesBarrackBladesingerSwirlingEdge = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Bladesinger_SwirlingEdge[2]-01a.ogg",
		},
	},
	ElvesBarrackBladesingerSwirlingTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"ForestProtector_Ancient[2]-01c.ogg",
		},
	},
	ElvesBarrackBladesingerTaunt = {
		gain = 0.6,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Bladesinger_Ready[2]-01b.ogg",
			"Bladesinger_PerfectParry[2]-01d.ogg",
			"Bladesinger_BladeDance[2]-01a.ogg",
			"Bladesinger_SwirlingEdge[2]-01a.ogg",
		},
	},
	ElvesBarrackForestKeeperCircleOfLifeTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"ForestProtector_Circle[2]-01g.ogg",
		},
	},
	ElvesBarrackForestKeeperEerieTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"ForestProtector_Eerie[2]-01a.ogg",
		},
	},
	ElvesBarrackForestKeeperOakSpearTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"ForestProtector_Ancient[2]-01c.ogg",
		},
	},
	ElvesBarrackForestKeeperTaunt = {
		gain = 0.6,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"ForestProtector_Ready[2]-01c.ogg",
			"ForestProtector_Eerie[2]-01a.ogg",
			"ForestProtector_Circle[2]-01g.ogg",
			"ForestProtector_Ancient[2]-01c.ogg",
		},
	},
	ElvesBarrackTaunt = {
		gain = 0.6,
		ignore = 1.5,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Barrack_Taunt[2]-01c.ogg",
			"Barrack_Taunt[2]-02c.ogg",
			"Barrack_Taunt[2]-03c.ogg",
			"Barrack_Taunt[2]-04e.ogg",
		},
	},
	ElvesBeanGrow = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bean.ogg",
		},
	},
	ElvesBeanGrowLoop = {
		gain = 1,
		loop = true,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bean_loop.ogg",
		},
	},
	ElvesBlackBabyFirebreathLoop = {
		gain = 0.2,
		loop = true,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_barezad_firebreath_v2[loop].ogg",
		},
	},
	ElvesBlackBabyFirebreathLoopEnd = {
		gain = 0.2,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_barezad_firebreath_v2[end].ogg",
		},
	},
	ElvesBlackBabyFirebreathLoopStart = {
		gain = 0.2,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_barezad_firebreath_v2[starter].ogg",
		},
	},
	ElvesBlackBabyFlyLoop = {
		gain = 0.2,
		loop = true,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_barezad_fly[loop-op2].ogg",
		},
	},
	ElvesBossBramCharge = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bram_fistcharge.ogg",
		},
	},
	ElvesBossBramDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bram_death[conexplo].ogg",
		},
	},
	ElvesBossBramGroundStomp = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bram_groundstomp.ogg",
		},
	},
	ElvesBossBramSlap = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bram_sopapo[conwhoosh].ogg",
		},
	},
	ElvesCreepArachnomancerSpiderSpawn = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_arachnomancer_spiderspawn[op1].ogg",
		},
	},
	ElvesCreepAvenger = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_avenger_lastservice_v2[op2].ogg",
		},
	},
	ElvesCreepEvokerHeal = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_evoker_heal[sinshaker].ogg",
		},
	},
	ElvesCreepGolemAreaAttack = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_elemental_areaattack.ogg",
		},
	},
	ElvesCreepGolemDeath = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_elemental_death.ogg",
		},
	},
	ElvesCreepHoplite = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_hoplite_summon_v3[singrowl].ogg",
		},
	},
	ElvesCreepHyena = {
		gain = 0.2,
		ignore = 1,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kre_sfx_hyena_ambience_v4[op1_heavysnors].ogg",
			"kre_sfx_hyena_ambience_v4[op2_consnors].ogg",
		},
	},
	ElvesCreepMountedAvengerDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_mountedavanger-death[conexplo].ogg",
		},
	},
	ElvesCreepRazorboarCharge = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_razorboar_charge[sinpisadas].ogg",
		},
	},
	ElvesCreepScreecherDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_screecher-death.ogg",
		},
	},
	ElvesCreepScreecherScream = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_screecher-scream[op5].ogg",
		},
	},
	ElvesCreepServantDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_servant-death[op2].ogg",
		},
	},
	ElvesCreepSonOfMactansLanding = {
		gain = 0.2,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_sonofmactans[sinlanding].ogg",
		},
	},
	ElvesCrystalBuff = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalbuff.ogg",
		},
	},
	ElvesCrystalIce = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalice.ogg",
		},
	},
	ElvesCrystalRay = {
		gain = 0.3,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalray[op1].ogg",
		},
	},
	ElvesCrystalSerpentAttack = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalserpent_serpentsattack.ogg",
		},
	},
	ElvesCrystalSerpentBreakingCrystal = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalserpent_crystalshatter.ogg",
		},
	},
	ElvesCrystalSerpentEmerge = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalserpent_emerge.ogg",
		},
	},
	ElvesCrystalSerpentPassby = {
		gain = 0.3,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalserpent_passby[sinsublows]_B.ogg",
		},
	},
	ElvesCrystalSerpentScream = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalserpent_scream[op4_pocodelay].ogg",
		},
	},
	ElvesCrystalSerpentSubmerge = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_crystalserpent_submerge_B.ogg",
		},
	},
	ElvesCrystalSkull = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_crystalskull_touch[conrisa].ogg",
		},
	},
	ElvesCrystallizedGnoll = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_crystallizedgnoll_v2.ogg",
		},
	},
	ElvesCrystallizingGnoll = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_unstablecrystal_crystallize[op1].ogg",
		},
	},
	ElvesDarkSpitterDeath = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_darkspitter_death[op2-sincaida].ogg",
		},
	},
	ElvesDarkSpitterSpit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"krf_sfx_darkspitter_spit.ogg",
		},
	},
	ElvesDeathGnolls = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_crystallizedgnoll_v2.ogg",
		},
	},
	ElvesDrowTaunt = {
		gain = 0.6,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "SPECIALS",
		files = {
			"Drow_01c.ogg",
			"Drow_02c.ogg",
			"Drow_03b.ogg",
		},
	},
	ElvesEwokAttack = {
		gain = 0.4,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Awok_02c.ogg",
		},
	},
	ElvesEwokTaunt = {
		gain = 0.4,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "SPECIALS",
		files = {
			"Awok_01b.ogg",
			"Awok_02c.ogg",
		},
	},
	ElvesFaeryDragonAttack = {
		gain = 0.2,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_faerydragon_sfx_attack[op2][soloattack]_B.ogg",
		},
	},
	ElvesFaeryDragonAttackCristalization = {
		gain = 0.2,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_faerydragon_attack[solocristalizacion].ogg",
		},
	},
	ElvesFaeryDragonDragonBuy = {
		gain = 0.2,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_faerydragon_buydragon[op1].ogg",
		},
	},
	ElvesFaeryDragonExtraAbility = {
		gain = 0.2,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_faerydragon_extraability[solochimes].ogg",
		},
	},
	ElvesFinalBossCastSpell = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_castspell.ogg",
		},
	},
	ElvesFinalBossCastSpellWithLaugh = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_castspellwithlaughter.ogg",
		},
	},
	ElvesFinalBossDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_death_v2[larga].ogg",
		},
	},
	ElvesFinalBossGemCrystalBreak = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_gemcrystalbreak[solo]_v1.ogg",
		},
	},
	ElvesFinalBossGemattackMalicia = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_gemattack_v1B.ogg",
		},
	},
	ElvesFinalBossGemattackSpider = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_mactans_gemattack[op1].ogg",
		},
	},
	ElvesFinalBossJump = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_finalboss_jump.ogg",
		},
	},
	ElvesFinalBossMactansTouch = {
		gain = 0.6,
		loop = false,
		source_group = "SFX",
		files = {
			"kr3_sfx_mactans_touch.ogg",
		},
	},
	ElvesFinalBossSpiderGoddessFall = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_fall_v2.ogg",
		},
	},
	ElvesFinalBossSpiderGoddessMorph = {
		gain = 0.6,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_morph_v1.ogg",
		},
	},
	ElvesFinalBossSpiderIn = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_spiderin.ogg",
		},
	},
	ElvesFinalBossSpiderOut = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_spiderout.ogg",
		},
	},
	ElvesFinalBossSpiderSuperrayCharge = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_superray_v4[carga].ogg",
		},
	},
	ElvesFinalBossSpiderSuperrayDischarge = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_superray_v3[descarga].ogg",
		},
	},
	ElvesFinalBossWebground = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_mactans_webground[conhissing].ogg",
		},
	},
	ElvesFinalBossWebspin = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_mactans_webspin[towers].ogg",
		},
	},
	ElvesFinalBosskillray = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_spidergoddess_killray[conprecarga].ogg",
		},
	},
	ElvesForgottenTreasureAmbienceSound = {
		gain = 0.8,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kro_sfx_bubblinglava-AMB.ogg",
			"kro_sfx_wingflaps-AMB.ogg",
			"kro_sfx_dripping[conbichos]-AMB.ogg",
		},
	},
	ElvesGnollTrailOut = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_gnoll_outofbush_modif.ogg",
		},
	},
	ElvesGnomeDeathTaunt = {
		gain = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"kro_sfx_gnome_death[op1].ogg",
			"kro_sfx_gnome_death[op4].ogg",
			"kro_sfx_gnome_death[op7].ogg",
		},
	},
	ElvesGnomeDesintegrate = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_gnome_desintegrate_v2[comic].ogg",
		},
	},
	ElvesGnomeNew = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Gnome_02a.ogg",
		},
	},
	ElvesGnomePoison = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_gnome_poison_v2[confrasco].ogg",
		},
	},
	ElvesGnomePolymorf = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_gnome_polymorf[conchimes].ogg",
		},
	},
	ElvesGnomePower = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Gnome_01d.ogg",
		},
	},
	ElvesGnomeSteal = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_gnome_polymorf[conchimes].ogg",
		},
	},
	ElvesGnomeTeleport = {
		gain = 0.2,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_teleport_v1.ogg",
		},
	},
	ElvesGrimDevourerConsume = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_grimdevourer_consume.ogg",
		},
	},
	ElvesGrimDevourerDeath = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_grimdevourer_death.ogg",
		},
	},
	ElvesGryphonsLand = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_gryphon_land_v3[op1].ogg",
		},
	},
	ElvesGryphonsShoot = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_gryphon_shot_v2[op3].ogg",
		},
	},
	ElvesGryphonsShootEnd = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_gryphon_shot_v2[end].ogg",
		},
	},
	ElvesGryphonsShootStart = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_gryphon_shot_v2[end].ogg",
		},
	},
	ElvesGryphonsTakeOff = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_gryphon_takeoff_v2.ogg",
		},
	},
	ElvesHanselAndGretelEscape = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_hanselandgretel_escape[arpayrisas].ogg",
		},
	},
	ElvesHeroAlleriaDeath = {
		gain = 0.3,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Female-Elven-Archer-Death_a.ogg",
		},
	},
	ElvesHeroAlleriaTaunt = {
		gain = 0.3,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Female-Elven-Archer-01c.ogg",
			"Female-Elven-Archer-02c.ogg",
			"Female-Elven-Archer-03a.ogg",
			"Female-Elven-Archer-04b.ogg",
		},
	},
	ElvesHeroAlleriaTauntIntro = {
		gain = 0.3,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroAlleriaTauntSelect = {
		gain = 0.3,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Female-Elven-Archer-04b.ogg",
		},
	},
	ElvesHeroArivanDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Arivan_Death-01a.ogg",
		},
	},
	ElvesHeroArivanFireball = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_fireballshot_v2.ogg",
		},
	},
	ElvesHeroArivanFireballExplode = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_fireballhit_v3.ogg",
		},
	},
	ElvesHeroArivanFireballSummon = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_fireballsummon[op2].ogg",
		},
	},
	ElvesHeroArivanIceShoot = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_iceboltshot_v2[contono].ogg",
		},
	},
	ElvesHeroArivanIceShootHit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_icebolt[hit].ogg",
		},
	},
	ElvesHeroArivanLightingBolt = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_lightningbolt_v2.ogg",
		},
	},
	ElvesHeroArivanStorm = {
		gain = 0.3,
		loop = true,
		source_group = "GUI",
		files = {
			"kre_sfx_arivan_elementalstorm_v2_op3.ogg",
		},
	},
	ElvesHeroArivanSummonRocks = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_stonesummon_v2.ogg",
		},
	},
	ElvesHeroArivanTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Arivan_Confirm-01b.ogg",
			"Arivan_Confirm-02c.ogg",
			"Arivan_Confirm-03a.ogg",
			"Arivan_Confirm04-01a.ogg",
		},
	},
	ElvesHeroArivanTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroArivanTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Arivan_Confirm04-01a.ogg",
		},
	},
	ElvesHeroBolverkCry = {
		gain = 0.8,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_bolverk_bearcry[op1].ogg",
		},
	},
	ElvesHeroBolverkDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"VarlBerserker_death-01c.ogg",
		},
	},
	ElvesHeroBolverkSlash = {
		gain = 0.8,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_bolverk_doubleslash[gore].ogg",
		},
	},
	ElvesHeroBolverkTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"VarlBerserker_confirm-01a.ogg",
			"VarlBerserker_confirm-02a.ogg",
			"VarlBerserker_confirm-03c.ogg",
			"VarlBerserker_confirm-04a.ogg",
		},
	},
	ElvesHeroBolverkTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroBruceDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Bruce_death[2]-01g.ogg",
		},
	},
	ElvesHeroBruceGriveousBites = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bruce_griveousbites.ogg",
		},
	},
	ElvesHeroBruceGuardianLionsCast = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bruce_guardianlions[spell+roar].ogg",
		},
	},
	ElvesHeroBruceGuardianLionsLoop = {
		gain = 0.3,
		loop = true,
		source_group = "SFX",
		files = {
			"kro_sfx_bruce_guardianlions[loop-v2-op1].ogg",
		},
	},
	ElvesHeroBruceGuardianLionsLoopEnd = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bruce_guardianlions-hit[loop-end].ogg",
		},
	},
	ElvesHeroBruceGuardianLionsLoopStart = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bruce_guardianlions-hit[loop-start].ogg",
		},
	},
	ElvesHeroBruceKingsRoar = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bruce_kingsroar[op1-conimpacto].ogg",
		},
	},
	ElvesHeroBruceTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Bruce_confirm[2]-01b.ogg",
			"Bruce_confirm[2]-02c.ogg",
			"Bruce_confirm_03d.ogg",
			"Bruce_confirm[2]-04c.ogg",
		},
	},
	ElvesHeroBruceTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroBruceTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Bruce_confirm[2]-04c.ogg",
		},
	},
	ElvesHeroCathaDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Catha_Death-01c.ogg",
		},
	},
	ElvesHeroCathaDust = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_catha_fairydust.ogg",
		},
	},
	ElvesHeroCathaFuryHit = {
		gain = 0.1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_catha_fairyfury[hit]_v2.ogg",
		},
	},
	ElvesHeroCathaFurySummon = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_catha_fairyfury[summon].ogg",
		},
	},
	ElvesHeroCathaSoul = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_catha_fairysoul_v1.ogg",
		},
	},
	ElvesHeroCathaTaleDeath = {
		gain = 0.1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_catha_fairytale[death].ogg",
		},
	},
	ElvesHeroCathaTaleSummon = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_catha_fairytale[summon].ogg",
		},
	},
	ElvesHeroCathaTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Catha_Confirm-01c.ogg",
			"Catha_Confirm-02a.ogg",
			"Catha_Confirm-03c.ogg",
			"Catha_Confirm-04d.ogg",
		},
	},
	ElvesHeroCathaTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroCathaTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Catha_Confirm-02a.ogg",
		},
	},
	ElvesHeroDenasCelebrity = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_princedenas_celebrity_v1[severalshots].ogg",
		},
	},
	ElvesHeroDenasDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"PrinceDenas-death_01a.ogg",
		},
	},
	ElvesHeroDenasKingsguardTaunt = {
		gain = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Kingsguard_01d.ogg",
			"Kingsguard_02c.ogg",
		},
	},
	ElvesHeroDenasMighty = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_princedenas_mighty_v3[convoz_op3].ogg",
		},
	},
	ElvesHeroDenasSworn = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Eridan_Death-01a.ogg",
		},
	},
	ElvesHeroDenasSybarite = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_princedenas_sybarite_v1[op1].ogg",
		},
	},
	ElvesHeroDenasTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"PrinceDenas-confirm_01a.ogg",
			"PrinceDenas-confirm_02c.ogg",
			"PrinceDenas-confirm_03b.ogg",
			"PrinceDenas-confirm_04a.ogg",
		},
	},
	ElvesHeroDenasTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroDenasTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"PrinceDenas-confirm_04a.ogg",
		},
	},
	ElvesHeroDenasWealthy = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_princedenas_wealthy_v1[op2].ogg",
		},
	},
	ElvesHeroDuraxArmblade = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_armblade.ogg",
		},
	},
	ElvesHeroDuraxCrystallites = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_crystallites.ogg",
		},
	},
	ElvesHeroDuraxDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_durax_death[op1].ogg",
		},
	},
	ElvesHeroDuraxLethalPrismShoot = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_lethalprism_shot_v2.ogg",
		},
	},
	ElvesHeroDuraxShardSpearHit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_shardspear[impact].ogg",
		},
	},
	ElvesHeroDuraxShardSpearThrow = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_shardspear[throw].ogg",
		},
	},
	ElvesHeroDuraxTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Durax_01a[wet].ogg",
			"Durax_02a[wet].ogg",
			"Durax_03a[wet].ogg",
			"Durax_04c[wet].ogg",
		},
	},
	ElvesHeroDuraxTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroDuraxTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Durax_04c[wet].ogg",
		},
	},
	ElvesHeroDuraxUltimate = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_ultimate.ogg",
		},
	},
	ElvesHeroDuraxWalkLoop = {
		gain = 0.3,
		loop = true,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_movement[loop_op1].ogg",
		},
	},
	ElvesHeroDuraxWalkLoopEnd = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_durax_movement[loop_end].ogg",
		},
	},
	ElvesHeroEldritchBlade = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_regson_bladescast_v3[conenergia].ogg",
		},
	},
	ElvesHeroEldritchBladeCharge = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_regson_bladescast_v3[sinenergia].ogg",
		},
	},
	ElvesHeroEldritchDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Reg'son-death_01c.ogg",
		},
	},
	ElvesHeroEldritchShield = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Eridan_Death-01a.ogg",
		},
	},
	ElvesHeroEldritchSlash = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_regson_slash_v1.ogg",
		},
	},
	ElvesHeroEldritchTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Reg'son-confirm_01a.ogg",
			"Reg'son-confirm_02c.ogg",
			"Reg'son-confirm_03d.ogg",
			"Reg'son-confirm_04a.ogg",
		},
	},
	ElvesHeroEldritchTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroEldritchTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Reg'son-confirm_04a.ogg",
		},
	},
	ElvesHeroEldritchVindicator = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_regson_vindicator_v3.ogg",
		},
	},
	ElvesHeroEridanDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Eridan_Death-01a.ogg",
		},
	},
	ElvesHeroEridanDoubleStrike = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_eridan_doublestrike_v2[mid].ogg",
		},
	},
	ElvesHeroEridanNimbleFencing = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_eridan_nimblefencing.ogg",
		},
	},
	ElvesHeroEridanTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Eridan_Confirm-01d.ogg",
			"Eridan_Confirm-03b.ogg",
			"Eridan_Confirm03-01a.ogg",
			"Eridan_confirmextra-01a.ogg",
		},
	},
	ElvesHeroEridanTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroEridanTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Eridan_Confirm-03b.ogg",
		},
	},
	ElvesHeroFaustusAttack = {
		gain = 0.3,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_faustus_normalattack_v1.ogg",
		},
	},
	ElvesHeroFaustusDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Faustus-death_01e2.ogg",
		},
	},
	ElvesHeroFaustusEnervation = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_faustus_enervation_v2_[op1].ogg",
		},
	},
	ElvesHeroFaustusFire = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_faustus_liquidfire_v2_sinchimes.ogg",
		},
	},
	ElvesHeroFaustusFireLoop = {
		gain = 0.3,
		loop = true,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_faustus_fireloop_v1.ogg",
		},
	},
	ElvesHeroFaustusRayKill = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_veznan_faustus_killray_v3.ogg",
		},
	},
	ElvesHeroFaustusTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Faustus-confirm_04b2.ogg",
			"Faustus-confirm_02b2.ogg",
			"Faustus-confirm_03a2.ogg",
			"Faustus-confirm_01b2.ogg",
		},
	},
	ElvesHeroFaustusTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroFaustusTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Faustus-confirm_01b2.ogg",
		},
	},
	ElvesHeroFaustusTeleport = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_faustus_teleport_v1[sinarpa].ogg",
		},
	},
	ElvesHeroFaustusUltimate = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"kro_sfx_faustus_activate[op2].ogg",
		},
	},
	ElvesHeroForestElementalAttack = {
		gain = 0.3,
		loop = false,
		source_group = "DEATH",
		files = {
			"kre_sfx_hyena_specialstomp.ogg",
		},
	},
	ElvesHeroForestElementalDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Bravebark-death_01a.ogg",
		},
	},
	ElvesHeroForestElementalHealing = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bravebark_healing_v1.ogg",
		},
	},
	ElvesHeroForestElementalHomerun = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bravebark_branchball_v1[op1].ogg",
		},
	},
	ElvesHeroForestElementalSpikes = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bravebark_rootspikes_v1.ogg",
		},
	},
	ElvesHeroForestElementalTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Bravebark-confirm_01c.ogg",
			"Bravebark-confirm_02b.ogg",
			"Bravebark-confirm_03d.ogg",
			"Bravebark-confirm_04d.ogg",
		},
	},
	ElvesHeroForestElementalTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroForestElementalTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Bravebark-confirm_04d.ogg",
		},
	},
	ElvesHeroForestElementalTeleportIn = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bravebark_teleport-in_v1.ogg",
		},
	},
	ElvesHeroForestElementalTeleportOut = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bravebark_teleport-out_v1.ogg",
		},
	},
	ElvesHeroForestElementalTrees = {
		gain = 0.3,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bravebark_oakseeds_v1.ogg",
		},
	},
	ElvesHeroForestElementalUltimate = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bravebark_v2[spikesbajos].ogg",
		},
	},
	ElvesHeroGyroAttack = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_wilbur_attack[concasquillos].ogg",
		},
	},
	ElvesHeroGyroBombsMarch = {
		gain = 0.8,
		loop = true,
		source_group = "SFX",
		files = {
			"kro_sfx_wilbur_bombsmarch[op1].ogg",
		},
	},
	ElvesHeroGyroBoombBox = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_wilbur_boombox.ogg",
		},
	},
	ElvesHeroGyroBoombBoxTouchdown = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_wilbur_boombox_box.ogg",
		},
	},
	ElvesHeroGyroDeath = {
		gain = 0.8,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Gyro_death-01d.ogg",
		},
	},
	ElvesHeroGyroDronesAttack = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_wilbur_dronesattack[metralla]_cut.ogg",
		},
	},
	ElvesHeroGyroDronesSpawn = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_wilbur_calldrones.ogg",
		},
	},
	ElvesHeroGyroSmokeLaunch = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_wilbur_smokespit.ogg",
		},
	},
	ElvesHeroGyroTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Gyro_confirm-01c.ogg",
			"Gyro_confirm-02c.ogg",
			"Gyro_confirm-03c.ogg",
			"Gyro_confirm-04b.ogg",
		},
	},
	ElvesHeroGyroTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroGyroTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Gyro_confirm-01c.ogg",
		},
	},
	ElvesHeroLilithAngelsCast = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_lilith_ultimate[darkangels-cast].ogg",
		},
	},
	ElvesHeroLilithAngelsHit = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_lilith_ultimate[darkangels-hit].ogg",
		},
	},
	ElvesHeroLilithDeath = {
		gain = 0.8,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Lilith_death-01a[wet].ogg",
		},
	},
	ElvesHeroLilithInfernalWheel = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_lilith_infernalwheel.ogg",
		},
	},
	ElvesHeroLilithMeteorsHit = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_lilith_ultimate[meteors-impact-op1_singlehit].ogg",
		},
	},
	ElvesHeroLilithRangeShoot = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_veznan_range_shoot_v1.ogg",
		},
	},
	ElvesHeroLilithReapersHarvest = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_lilith_reaperharvest.ogg",
		},
	},
	ElvesHeroLilithResurrection = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_lilith_resurrection[op2-conchime].ogg",
		},
	},
	ElvesHeroLilithSoulEater = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_lilith_soulreaper[op1].ogg",
		},
	},
	ElvesHeroLilithTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Lilith_confirm-01d[wet].ogg",
			"Lilith_confirm-02d[wet].ogg",
			"Lilith_confirm-03f[wet].ogg",
			"Lilith_confirm-04a[wet].ogg",
		},
	},
	ElvesHeroLilithTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroLilithTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Lilith_confirm-01d[wet].ogg",
		},
	},
	ElvesHeroLynnCurseDespair = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bitteringrancor_lynn-curseofdispair[conprecarga].ogg",
		},
	},
	ElvesHeroLynnDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Lynn_death_01b.ogg",
		},
	},
	ElvesHeroLynnFateSealed = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bitteringrancor_lynn-fatesealed.ogg",
		},
	},
	ElvesHeroLynnHexfury = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bitteringrancor_lynn-hexfury[op3].ogg",
		},
	},
	ElvesHeroLynnTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Lynn_confirm_01a.ogg",
			"Lynn_confirm_02c.ogg",
			"Lynn_confirm_03a.ogg",
			"Lynn_confirm_04d.ogg",
		},
	},
	ElvesHeroLynnTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroLynnTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Lynn_confirm_01a.ogg",
		},
	},
	ElvesHeroLynnWeakening = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_bitteringrancor_lynn-weakeningcurse[sincrackle].ogg",
		},
	},
	ElvesHeroPhoenixAttack = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_phoenix_basicattack.ogg",
		},
	},
	ElvesHeroPhoenixBlazingOffspringHit = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_blazingoffspring_hit_v2.ogg",
		},
	},
	ElvesHeroPhoenixBlazingOffspringShoot = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_blazingoffspring_shot[op1].ogg",
		},
	},
	ElvesHeroPhoenixDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Phoenix2-death_01a.ogg",
		},
	},
	ElvesHeroPhoenixFireEggActivate = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_fireegg_activate_v2.ogg",
		},
	},
	ElvesHeroPhoenixFireEggDrop = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_fireegg_v3.ogg",
		},
	},
	ElvesHeroPhoenixFireEggExplosion = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_eggexplosion.ogg",
		},
	},
	ElvesHeroPhoenixImmolation = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_immolation_v2.ogg",
		},
	},
	ElvesHeroPhoenixRingOfFireExplode = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_ringoffire_explode_v2.ogg",
		},
	},
	ElvesHeroPhoenixRingOfFireSpawn = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_phoenix_ringoffire_spawn[op2].ogg",
		},
	},
	ElvesHeroPhoenixTaunt = {
		gain = 0.8,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Phoenix2-death_01b.ogg",
			"Phoenix2-death_01a.ogg",
		},
	},
	ElvesHeroPhoenixTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroPhoenixTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Phoenix2-death_01b.ogg",
		},
	},
	ElvesHeroRagAttack = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_raggified_attack.ogg",
		},
	},
	ElvesHeroRagDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"RazzAndRags-death_01a.ogg",
		},
	},
	ElvesHeroRagGnomeShot = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_gnome_shot[op1_conchime].ogg",
		},
	},
	ElvesHeroRagGroundStomp = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_raggified_groundstomp[medium].ogg",
		},
	},
	ElvesHeroRagHammer = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_hammertime[op2].ogg",
		},
	},
	ElvesHeroRagHammerTime = {
		gain = 0.3,
		loop = true,
		source_group = "GUI",
		files = {
			"kro_sfx_hammertime[op1_12bits].ogg",
		},
	},
	ElvesHeroRagKamihare = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_gnome_kamihare[sinpops].ogg",
		},
	},
	ElvesHeroRagSpawn = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_angrygnome_objectspawn[op2].ogg",
		},
	},
	ElvesHeroRagTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"RazzAndRags_01b.ogg",
			"RazzAndRags_02b.ogg",
			"RazzAndRags_03d.ogg",
			"RazzAndRags_04c.ogg",
		},
	},
	ElvesHeroRagTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroRagTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"RazzAndRags_02b.ogg",
		},
	},
	ElvesHeroRagTransform = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_raggified_transform[op2].ogg",
		},
	},
	ElvesHeroVeznanArcaneNova = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_arcanenova_v1.ogg",
		},
	},
	ElvesHeroVeznanDarkPact = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_darkpact_v1.ogg",
		},
	},
	ElvesHeroVeznanDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Veznan_death-[new]01b.ogg",
		},
	},
	ElvesHeroVeznanDemonDeath = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_demondeath_v3.ogg",
		},
	},
	ElvesHeroVeznanDemonFireballHit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_demonfireball_hit_v3.1.ogg",
		},
	},
	ElvesHeroVeznanDemonFireballThrow = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_demonfireball_throw_v3.ogg",
		},
	},
	ElvesHeroVeznanMagicSchackles = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_magicshackles_v1[op2]-01.ogg",
		},
	},
	ElvesHeroVeznanRangeShoot = {
		gain = 0.6,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_range_shoot_v1.ogg",
		},
	},
	ElvesHeroVeznanSoulBurn = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_soulburn_v8[sinimpacto].ogg",
		},
	},
	ElvesHeroVeznanTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Veznan-confirm_01e.ogg",
			"Veznan-confirm_02f.ogg",
			"Veznan-confirm_03_custom_fb.ogg",
			"Veznan-confirm_04_custom_ec.ogg",
		},
	},
	ElvesHeroVeznanTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroVeznanTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Veznan-confirm_03_custom_fb.ogg",
		},
	},
	ElvesHeroVeznanTeleport = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_veznan_teleport_v1.ogg",
		},
	},
	ElvesHeroXinAfterTeleportIn = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_tele-in_v3[op1].ogg",
		},
	},
	ElvesHeroXinAfterTeleportOut = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_tele-out_v3.ogg",
		},
	},
	ElvesHeroXinDaringStrikeHit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_daringstrikehit_v1.ogg",
		},
	},
	ElvesHeroXinDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Xin-death_01a.ogg",
		},
	},
	ElvesHeroXinInspire = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_inspire_v3[op1].ogg",
		},
	},
	ElvesHeroXinMindOverBody = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_mindoverbody.ogg",
		},
	},
	ElvesHeroXinPandaStyle = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_pandastyle_v3[op2].ogg",
		},
	},
	ElvesHeroXinPandamonium = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_pandamonium_[op1].ogg",
		},
	},
	ElvesHeroXinPandamoniumHit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_pandamonium-hit1_v1.ogg",
			"kro_sfx_xin_pandamonium-hit2_v1.ogg",
		},
	},
	ElvesHeroXinPoleHit = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_xin_polehit1_v3[conhoo].ogg",
			"kro_sfx_xin_polehit2_v3[conhoo].ogg",
		},
	},
	ElvesHeroXinTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Xin-confirm_01c.ogg",
			"Xin-confirm_02b.ogg",
			"Xin-confirm_03a.ogg",
			"Xin-confirm_04c.ogg",
		},
	},
	ElvesHeroXinTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	ElvesHeroXinTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Xin-confirm_02b.ogg",
		},
	},
	ElvesHyenaDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_hyena_death.ogg",
		},
	},
	ElvesHyenaGrowl = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_hyena_howl[op1_singrowl].ogg",
		},
	},
	ElvesHyenaStomp = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_hyena_specialstomp.ogg",
		},
	},
	ElvesHyenaWagonEnd = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_hyena_wagonloop[ending].ogg",
		},
	},
	ElvesHyenaWagonExplosion = {
		gain = 0.6,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_hyena_wagonexplosion.ogg",
		},
	},
	ElvesHyenaWagonLoop = {
		gain = 0.6,
		loop = true,
		source_group = "SFX",
		files = {
			"kre_sfx_hyena_wagonloop[concadenas].ogg",
		},
	},
	ElvesInAppHandOfMidas = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_inapp-handofmidas[op1].ogg",
		},
	},
	ElvesInAppHandOfMidasLoop = {
		gain = 0.6,
		loop = true,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_inapp-handofmidas-active[op3]C.ogg",
		},
	},
	ElvesInAppHornOfHeroism = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_inapp_hornofheroism[op2].ogg",
		},
	},
	ElvesInAppRodDragon = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_fireballhit_v3.ogg",
		},
	},
	ElvesInAppTearOfElynie = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_inapp-tearofelynie_v2[conlacrimosa].ogg",
		},
	},
	ElvesInAppTeleportGemEnemiesIn = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_inapp-teleportgem_v2[enemiesin].ogg",
		},
	},
	ElvesInAppTeleportGemEnemiesOut = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_inapp-teleportgem_v2[enemiesout].ogg",
		},
	},
	ElvesInAppTeleportScroll = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_inapp-teleportscroll_v2[sinslam].ogg",
		},
	},
	ElvesMageHighElvenSentinelTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"HighMage_ArcaneSentinel-01c.ogg",
		},
	},
	ElvesMageHighElvenTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"HighMage_Ready-01a.ogg",
		},
	},
	ElvesMageHighElvenTimelapseTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"HighMage_Timelapse-01c.ogg",
		},
	},
	ElvesMageTaunt = {
		gain = 0.6,
		ignore = 1.5,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Mage_Taunt-01e.ogg",
			"Mage_Taunt-03d.ogg",
			"Mage_Taunt[2]-02a.ogg",
		},
	},
	ElvesMageWildMagusDoomTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"WildMagus_Doom[2]-01b.ogg",
		},
	},
	ElvesMageWildMagusSilenceTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"WildMagus_Silence-01c.ogg",
		},
	},
	ElvesMageWildMagusTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"WildMagus_Ready-01a.ogg",
		},
	},
	ElvesMaliciaCastSummon = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_maliciazealot_summon[wololo_op1].ogg",
		},
	},
	ElvesMaliciaDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_death.ogg",
		},
	},
	ElvesMaliciaShieldBreak = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_shieldbreak[op1].ogg",
		},
	},
	ElvesMaliciaSpellCast = {
		gain = 1,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_spellcast_[op2].ogg",
			"kro_sfx_malicia_spellcast_[op2]_nolaugh.ogg",
		},
	},
	ElvesMaliciaTransformIn = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_comet-start_v3[sinfuego].ogg",
		},
	},
	ElvesMaliciaTransformOut = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malicia_comet-end_v3.ogg",
		},
	},
	ElvesMalikHammer = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_malik_hammer[concaida].ogg",
		},
	},
	ElvesObelix = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_obelix_feed[comic].ogg",
		},
	},
	ElvesPeekaboo = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_peekaboo_v2[op2].ogg",
		},
	},
	ElvesPlantMissile = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_plant_magicmissile.ogg",
		},
	},
	ElvesPlantReady = {
		gain = 0.8,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_plant_ready_conchime.ogg",
		},
	},
	ElvesRoadRunner = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_roadrunner_meepmeep_modif.ogg",
		},
	},
	ElvesRockEntwoodClobberingTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"PapaTree_Clobberin[2]-01e.ogg",
		},
	},
	ElvesRockEntwoodFieryNutsTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"PapaTree_Fiery[2]-01d.ogg",
		},
	},
	ElvesRockEntwoodTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"PapaTree_Ready[2]-01d.ogg",
		},
	},
	ElvesRockHengeNatureFriendTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"DruidHenge_Sylvan[2]-01b.ogg",
		},
	},
	ElvesRockHengeSylvanCurseTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"DruidHenge_Sylvan[2]-01b.ogg",
		},
	},
	ElvesRockHengeTaunt = {
		gain = 0.6,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"DruidHenge_Ready-01a.ogg",
		},
	},
	ElvesRockTaunt = {
		gain = 0.6,
		ignore = 1.5,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"StoneDruid_Taunt-01b.ogg",
			"StoneDruid_Taunt-02b.ogg",
			"StoneDruid_Taunt-03a.ogg",
		},
	},
	ElvesScourgerDeath = {
		gain = 0.3,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_scourger_death.ogg",
		},
	},
	ElvesShadowChampionAttack = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_shadowchampion_attack[confuego].ogg",
		},
	},
	ElvesShadowChampionDeath = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_shadowchampion_death.ogg",
		},
	},
	ElvesShadowSpawnDeath = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_shadowspawn_death[op1].ogg",
		},
	},
	ElvesShadowSpawnSpawn = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_shadowspawn_spawn[op2].ogg",
		},
	},
	ElvesSimonActivate = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_simon_activate_v2.ogg",
		},
	},
	ElvesSimonBlue = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_simon_blue_v2.ogg",
		},
	},
	ElvesSimonGreen = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_simon_green_v2.ogg",
		},
	},
	ElvesSimonRed = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_simon_red_v2.ogg",
		},
	},
	ElvesSimonWrong = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_simon_wrong_v2.ogg",
		},
	},
	ElvesSimonYellow = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_simon_yellow_v2.ogg",
		},
	},
	ElvesSpecialDrowBlademail = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Drow_03b.ogg",
		},
	},
	ElvesSpecialDrowDaggers = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Drow_02c.ogg",
		},
	},
	ElvesSpecialDrowLifeDrain = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Drow_01c.ogg",
		},
	},
	ElvesSpecialExplosionPath = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_tree_path_explosion.ogg",
		},
	},
	ElvesSpecialGeorgeFall = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_georgefall_v1.ogg",
		},
	},
	ElvesSpecialSpiderEggs = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_spidereggs[huevo+aranias].ogg",
		},
	},
	ElvesTowerBastionShot = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bastion_shot[op1]_modif.ogg",
		},
	},
	ElvesUnstableCrystalHealing = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_unstablecrystal_healing_modif.ogg",
		},
	},
	ElvesUnstableCrystalReady = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_unstablecrystal_ready[op4]_modif.ogg",
		},
	},
	ElvesWaterfallStrong = {
		gain = 0.6,
		loop = false,
		source_group = "SFX",
		files = {
			"kre_sfx_waterfall_strong.ogg",
		},
	},
	ElvesWhiteTreeActivate = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_whitetree-activate.ogg",
		},
	},
	ElvesWhiteTreeTap = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bitteringrancor_whitetree-tap.ogg",
		},
	},
	ElvesWitchDeath = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_witchdeath_v1[op2].ogg",
		},
	},
	ElvesWitchOutside = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_witch_outsidecurse[op2].ogg",
		},
	},
	ElvesWitchTouch = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_witch_touch[op1].ogg",
		},
	},
	EndlessAinylDisable = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_ainyl_disable.ogg",
		},
	},
	EndlessAinylShield = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_ainyl_shield.ogg",
		},
	},
	EndlessAinylTeleport = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_ainyl_teleport[op2].ogg",
		},
	},
	EndlessAmbience = {
		gain = 1,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kro_sfx_ambience_wardrums[op1].ogg",
			"kro_sfx_ambience_wardrums[op2].ogg",
			"kro_sfx_ambience_wardrums[op3].ogg",
		},
	},
	EndlessBruteDeath = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_bannerbearer_death[op1-SD].ogg",
		},
	},
	EndlessHeeHawCall = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_heehaw_call[op2].ogg",
		},
	},
	EndlessHeeHawNetFalling = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_heehaw_netfalling_v2[op3].ogg",
		},
	},
	EndlessHeeHawNetHit = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_heehaw_nethitsfloor.ogg",
		},
	},
	EndlessTwilightAmbience = {
		gain = 1,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kro_sfx_twlightinvasionambience-2.ogg",
			"kro_sfx_twlightinvasionambience-3.ogg",
		},
	},
	EndlessWarleaderDeath = {
		gain = 0.5,
		loop = false,
		source_group = "DEATH",
		files = {
			"kro_sfx_creep_death[op1].ogg",
		},
	},
	EndlessWarleaderDoubleSword = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kro_sfx_creep_doublesword[op1].ogg",
		},
	},
	EnemyHealing = {
		gain = 1,
		loop = false,
		source_group = "SFX",
		files = {
			"Sound_EnemyHealing.ogg",
		},
	},
	FaerieGroveAmbienceSound = {
		gain = 0.8,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kro_sfx_ambience_windandowls1.ogg",
			"kro_sfx_ambience_branchesandfaery1.ogg",
			"kro_sfx_ambience_branchesandfaery2.ogg",
		},
	},
	FireballHit = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Sound_FireballHit.ogg",
		},
	},
	FireballRelease = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"Sound_FireballUnleash.ogg",
		},
	},
	GUIAchievementWin = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_AchievementWin.ogg",
		},
	},
	GUIButtonCommon = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_GUIButtonCommon.ogg",
		},
	},
	GUIBuyUpgrade = {
		gain = 0.6,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_GUIBuyUpgrade.ogg",
		},
	},
	GUICoins = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_Coins.ogg",
		},
	},
	GUILooseLife = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_LooseLife.ogg",
		},
	},
	GUIMapNewFlah = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_MapNewFlag.ogg",
		},
	},
	GUINextWaveIncoming = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_WaveIncoming.ogg",
		},
	},
	GUINextWaveReady = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_NextWaveReady.ogg",
		},
	},
	GUINotificationClose = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_NotificationClose.ogg",
		},
	},
	GUINotificationOpen = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_NotificationOpen.ogg",
		},
	},
	GUINotificationPaperOver = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_NotificationPaperOver.ogg",
		},
	},
	GUINotificationSecondLevel = {
		gain = 0.8,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_NotificationSecondLevel.ogg",
		},
	},
	GUIPlaceRallyPoint = {
		gain = 0.8,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_RallyPointPlaced.ogg",
		},
	},
	GUIQuestCompleted = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_QuestCompleted.ogg",
		},
	},
	GUIQuestFailed = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_QuestFailed.ogg",
		},
	},
	GUIQuickMenuOpen = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_GUIOpenTowerMenu.ogg",
		},
	},
	GUIQuickMenuOver = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_GUIMouseOverTowerIcon.ogg",
		},
	},
	GUISpellRefresh = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_SpellRefresh.ogg",
		},
	},
	GUISpellSelect = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_SpellSelect.ogg",
		},
	},
	GUITowerBuilding = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_TowerBuilding.ogg",
		},
	},
	GUITowerOpenDoor = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_TowerOpenDoor.ogg",
		},
	},
	GUITowerSell = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_TowerSell.ogg",
		},
	},
	GUITransitionClose = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"GUITransitionClose.ogg",
		},
	},
	GUITransitionOpen = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"GUITransitionOpen.ogg",
		},
	},
	GUIWinStars = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_WinStars.ogg",
		},
	},
	GuimapNewRoad = {
		gain = 1,
		loop = false,
		source_group = "GUI",
		files = {
			"Sound_MapRoad.ogg",
		},
	},
	HeroLevelUp = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	HeroReinforcementDeath = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Reinforcement-Death_c.ogg",
		},
	},
	HeroReinforcementHit_g3 = {
		gain = 1,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Motumbo_hit.ogg",
		},
	},
	HeroReinforcementJump_g3 = {
		gain = 1,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Motumbo_jump_special.ogg",
		},
	},
	HeroReinforcementSpecial_g3 = {
		gain = 1,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Motumbo_charge_special.ogg",
		},
	},
	HeroReinforcementTaunt = {
		gain = 1,
		ignore = 1,
		loop = false,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"Reinforcement-04b.ogg",
			"Reinforcement-02c.ogg",
			"Reinforcement-03c.ogg",
			"Reinforcement-01a.ogg",
		},
	},
	HeroReinforcementTauntIntro = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg",
		},
	},
	HeroReinforcementTauntSelect = {
		gain = 1,
		loop = false,
		source_group = "TAUNTS",
		files = {
			"Reinforcement-01a.ogg",
		},
	},
	HitSound = {
		gain = 0.15,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_ArrowHit2.ogg",
			"Sound_ArrowHit3.ogg",
		},
	},
	InAppBuyGems = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"inapp_cash.ogg",
		},
	},
	InAppBuyInApp = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"inapp_chin.ogg",
		},
	},
	InAppEarnGems = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"inapp_gems.ogg",
		},
	},
	InAppExtraGold = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"inapp_gnome.ogg",
		},
	},
	MetropolisAmbienceSound = {
		gain = 0.3,
		loop = false,
		mode = "random",
		source_group = "SFX",
		files = {
			"kro_sfx_ambience_winds[op1].ogg",
			"kro_sfx_ambience_winds[op2].ogg",
			"kro_sfx_ambience_spiders_v2[op1].ogg",
		},
	},
	PirateBombShootSound = {
		gain = 1,
		loop = false,
		source_group = "EXPLOSIONS",
		files = {
			"Sound_EngineerShot.ogg",
		},
	},
	RocketLaunchSound = {
		gain = 0.8,
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_RocketLaunt.ogg",
		},
	},
	ShotgunSound = {
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_Shootgun.ogg",
		},
	},
	ShrapnelSound = {
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_Shrapnel.ogg",
		},
	},
	SniperSound = {
		loop = false,
		source_group = "BULLETS",
		files = {
			"Sound_Sniper.ogg",
		},
	},
    SpiderAttack = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
		mode = "sequence",
        source_group = "BULLETS",
        files = {
			"Sound_SpiderAttack1.ogg",
			"Sound_SpiderAttack2.ogg"
		},
    },
	TowerArcaneExplotion = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_archanearcher_arcaneexplotion_v3.ogg",
		},
	},
	TowerArcanePreloadAndTravel = {
		gain = 0.3,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_highmage_preload_and_travel.ogg",
		},
	},
	TowerArcaneWaterEnergyBlast = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_arcanearcher_sleepingarrow-op1.ogg",
		},
	},
	TowerBarracksBasic = {
		gain = 0.3,
		loop = false,
		source_group = "SWORDS",
		files = {
			"kr3_sfx_basicbarracks_fight.ogg",
		},
	},
	TowerBladesingerBladedance = {
		gain = 0.3,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_bladesinger_bladedance_v2-op2.ogg",
		},
	},
	TowerBladesingerPerfectParry = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_bladesinger_perfectparry_v2-op2-faded.ogg",
		},
	},
	TowerDruidHengeBearAttack = {
		gain = 0.3,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_druidhenge_bearattack_v4-op1.ogg",
		},
	},
	TowerDruidHengeBearDeath = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_druidhenge_beardeath_v3_op1-condesplome.ogg",
		},
	},
	TowerDruidHengeBearSummon = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_druidhenge_bearsummon_v3-op2.ogg",
		},
	},
	TowerDruidHengeRockSummon = {
		gain = 0.5,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_druidhenge_bouldersummon.ogg",
		},
	},
	TowerDruidHengeRockThrow = {
		gain = 0.5,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_druidhenge_rockthrow_v2-op2-medio.ogg",
		},
	},
	TowerDruidHengeSylvanCurseCast = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_druidhenge_sylvancursecast_v4-op2.ogg",
		},
	},
	TowerEntwoodClobber = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_tree_clobber_v2.ogg",
		},
	},
	TowerEntwoodCocoExplosion = {
		gain = 0.8,
		loop = false,
		source_group = "EXPLOSIONS",
		files = {
			"kr3_sfx_tree_cocoexplosion[explofuerte].ogg",
		},
	},
	TowerEntwoodCocoThrow = {
		gain = 0.5,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_tree_cocothrow.ogg",
		},
	},
	TowerEntwoodFieryExplote = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_tree_fierynutexplotion.ogg",
		},
	},
	TowerEntwoodFieryThrow = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_tree_fierynutthrow.ogg",
		},
	},
	TowerEntwoodLeaves = {
		gain = 0.1,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_tree_leaves.ogg",
		},
	},
	TowerForestKeeperAncientSpear = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_forestkeeper_ancientoakspear_LOW_v1+3db.ogg",
		},
	},
	TowerForestKeeperCircleOfHealing = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_forestkeeper_circleofhealing-CONGAITA_HI.ogg",
		},
	},
	TowerForestKeeperEerieGarden = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_forestkeeper_eeriegarden_SINPOPS.ogg",
		},
	},
	TowerForestKeeperNormalSpear = {
		gain = 0.5,
		loop = false,
		source_group = "SFX",
		files = {
			"kr3_sfx_forestkeeper_normalspear_v2-op1.ogg",
		},
	},
	TowerGoldenBowArrowShot = {
		gain = 0.3,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_goldenbow_arrowshot.ogg",
		},
	},
	TowerGoldenBowFlareHit = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_goldenbow_flarehit_v2.5.ogg",
		},
	},
	TowerGoldenBowFlareShot = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_goldenbow_flareshot_v2-convoz.ogg",
		},
	},
	TowerGoldenBowInstakill = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_goldenbow_instakill_v2_conchime.ogg",
		},
	},
	TowerGoldenBowInstakillArrowShot = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_goldenbow_instakillarrowshot_v2.ogg",
		},
	},
	TowerHighMageBoltCast = {
		gain = 0.3,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_highmage_shot.ogg",
		},
	},
	TowerHighMageSentinelActivate = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_elvenhighmage_sentinelactivate.ogg",
		},
	},
	TowerHighMageSentinelShot = {
		gain = 0.1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_elvenhighmage_sentinelshot_v2-op1.ogg",
		},
	},
	TowerHighMageTimeCastEnd = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_highmage_timecastend.ogg",
		},
	},
	TowerHighMageTimecast = {
		gain = 0.8,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_highmage_timecast.ogg",
		},
	},
	TowerStoneDruidBoulderExplote = {
		gain = 0.5,
		loop = false,
		source_group = "EXPLOSIONS",
		files = {
			"kr3_sfx_stonedruid_boulderexplosion.ogg",
		},
	},
	TowerStoneDruidBoulderSummon = {
		gain = 0.3,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_stonedruid_bouldersummon.ogg",
		},
	},
	TowerStoneDruidBoulderThrow = {
		gain = 0.5,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_stonedruid_boulderthrow-op2.ogg",
		},
	},
	TowerWildMagusBoltcast = {
		gain = 0.3,
		ignore = 0.3,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_wildmagus_boltcast_v2-op1.ogg",
		},
	},
	TowerWildMagusDisruptionCast = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_wildmagus_disruptioncast_v2.ogg",
		},
	},
	TowerWildMagusDoomCast = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_wildmagus_doomcast_v2.ogg",
		},
	},
	TowerWildMagusDoomExplote = {
		gain = 0.5,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_wildmagus_doomexplotion_v3-op1.ogg",
		},
	},
	TowerWildMagusDoomLoop = {
		gain = 0.5,
		loop = true,
		source_group = "SPECIALS",
		files = {
			"kr3_sfx_wildmagus_doomloop_v2-op1.ogg",
		},
	},
	TowerWizardBasicBolt = {
		gain = 0.1,
		loop = false,
		source_group = "BULLETS",
		files = {
			"kr3_sfx_basicwizard_doublebolt-op1.ogg",
		},
	},
	VenomPlantDischarge = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_poisonplant_discharge[conacido]_B.ogg",
		},
	},
	VenomPlantReady = {
		gain = 1,
		loop = false,
		source_group = "SPECIALS",
		files = {
			"kro_sfx_poisonplant_ready_v2B.ogg",
		},
	},
	WolfAttack = {
		gain = 0.6,
		ignore = 1.5,
		loop = false,
		mode = "sequence",
		source_group = "BULLETS",
		files = {
			"Sound_WolfAttack.ogg",
			"Sound_WolfAttack2.ogg",
		},
	},
}
