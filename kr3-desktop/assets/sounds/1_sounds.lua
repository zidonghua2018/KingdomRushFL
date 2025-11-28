-- chunkname: @./_assets/kr1-desktop/sounds/sounds.lua
return {
    EndlessOrcsTotemDamage = {
        files = {"kr_sfx_endless_flametotem_v3.ogg"},
        gain = 0.8,
        loop = false,
        source_group = "SPECIALS"
    },
    EndlessOrcsTotemHealing = {
        files = {"kr_sfx_endless_healingtotem_v3.ogg"},
        gain = 0.8,
        loop = false,
        source_group = "SPECIALS"
    },
    EndlessOrcsTotemSpeed = {
        files = {"kr_sfx_endless_swiftnesstotem_v3.ogg"},
        gain = 0.8,
        loop = false,
        source_group = "SPECIALS"
    },
    ArcaneRaySound = {
        gain = 0.68,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_RayArcane.ogg"}
    },
    ArcherMusketeerShrapnelTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Muskateer_Event1.ogg"}
    },
    ArcherMusketeerSniperTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Muskateer_Snipe.ogg"}
    },
    ArcherMusketeerTaunt = {
        gain = 0.6,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Muskateer_Ready.ogg", "Muskateer_Event1.ogg", "Muskateer_Event2.ogg"}
    },
    ArcherRangerPoisonTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Ranger_Taunt1.ogg"}
    },
    ArcherRangerTaunt = {
        gain = 0.6,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Ranger_Ready.ogg", "Ranger_Taunt1.ogg", "Ranger_Taunt2.ogg"}
    },
    ArcherRangerThornTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Ranger_Taunt2.ogg"}
    },
    ArcherTaunt = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Archer_Ready.ogg", "Archer_Taunt1.ogg", "Archer_Taunt2.ogg"}
    },
    AreaAttack = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_CommonAreaHit.ogg"}
    },
    ArrowSound = {
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_ArrowRelease2.ogg", "Sound_ArrowRelease3.ogg"}
    },
    AxeSound = {
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_BattleAxe.ogg"}
    },
    BarrackBarbarianDoubleAxesTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Barbarian_Move.ogg"}
    },
    BarrackBarbarianTaunt = {
        gain = 0.6,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Barbarian_Ready.ogg", "Barbarian_Taunt1.ogg", "Barbarian_Taunt2.ogg", "Barbarian_Move.ogg"}
    },
    BarrackBarbarianThrowingAxesTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Barbarian_Ready.ogg"}
    },
    BarrackBarbarianTwisterTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Barbarian_Taunt1.ogg"}
    },
    BarrackPaladinHealingTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Paladin_Ready.ogg"}
    },
    BarrackPaladinHolyStrikeTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Paladin_Taunt1.ogg"}
    },
    BarrackPaladinShieldTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Paladin_Taunt2.ogg"}
    },
    BarrackPaladinTaunt = {
        gain = 0.6,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Paladin_Ready.ogg", "Paladin_Taunt1.ogg", "Paladin_Taunt2.ogg", "Paladin_Move.ogg"}
    },
    BarrackTaunt = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Barrack_Ready.ogg", "Barrack_Taunt1.ogg", "Barrack_Taunt2.ogg", "Barrack_Move.ogg"}
    },
    BlackburnAmbienceBlackburn = {
        gain = 0.8,
        loop = false,
        source_group = "SFX",
        files = {"kr_ambience_cb_aquelarre.ogg", "halloween_werewolf_minormoans.ogg"}
    },
    BlackburnGhosts = {
        gain = 0.8,
        loop = false,
        source_group = "SFX",
        files = {"kr_ambience_cb_ghosts_1.ogg"}
    },
    BoltSorcererSound = {
        gain = 0.68,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_Sorcerer.ogg"}
    },
    BoltSound = {
        gain = 0.68,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_MageShot.ogg"}
    },
    BombExplosionSound = {
        gain = 0.8,
        loop = false,
        source_group = "EXPLOSIONS",
        files = {"Sound_Bomb1.ogg"}
    },
    BombShootSound = {
        gain = 0.75,
        loop = false,
        source_group = "EXPLOSIONS",
        files = {"Sound_EngineerShot.ogg"}
    },
    DeathBig = {
        loop = false,
        source_group = "DEATH",
        files = {"Sound_EnemyBigDead.ogg"}
    },
    DeathEplosion = {
        gain = 0.4,
        loop = false,
        source_group = "DEATH",
        files = {"Sound_EnemyExplode1.ogg"}
    },
    DeathGoblin = {
        loop = false,
        source_group = "DEATH",
        files = {"Sound_EnemyGoblinDead.ogg"}
    },
    DeathHuman = {
        loop = false,
        mode = "random",
        source_group = "DEATH",
        files = {"Sound_HumanDead1.ogg", "Sound_HumanDead2.ogg", "Sound_HumanDead3.ogg", "Sound_HumanDead4.ogg"}
    },
    DeathJuggernaut = {
        gain = 0.9,
        loop = false,
        source_group = "DEATH",
        files = {"Sound_JuggernautDeath.ogg"}
    },
    DeathOrc = {
        loop = false,
        source_group = "DEATH",
        files = {"Sound_EnemyOrcDead.ogg"}
    },
    DeathPuff = {
        gain = 0.8,
        loop = false,
        source_group = "DEATH",
        files = {"Sound_EnemyPuffDead.ogg"}
    },
    DeathSkeleton = {
        loop = false,
        source_group = "DEATH",
        files = {"Sound_EnemySkeletonBreak2.ogg"}
    },
    DeathTroll = {
        loop = false,
        source_group = "DEATH",
        files = {"Sound_EnemyTrollDead.ogg"}
    },
    DesintegrateSound = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_ArcaneDesintegrate.ogg"}
    },
    ElfTaunt = {
        gain = 0.8,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Elf_Taun1.ogg", "Elf_Taun2.ogg"}
    },
    EnemyBlackburnBossDeath = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_lordblackburn_death.ogg"}
    },
    EnemyBlackburnBossSpecialStomp = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_lordblackburn_specialstomp.ogg"}
    },
    EnemyBlackburnBossSwing = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_lordblackburn_swing.ogg"}
    },
    EnemyBlackburnGiantRat = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_giantrats1.ogg", "kr_sfx_cb_giantrats2.ogg"}
    },
    EnemyBlackburnWitch = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_witch_fast.ogg", "kr_sfx_cb_witch_slow.ogg"}
    },
    EnemyBlackburnWitchDeath = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_witchdeath.ogg"}
    },
    EnemyChieftain = {
        gain = 0.6,
        loop = false,
        source_group = "SFX",
        files = {"Sound_Chieftain.ogg"}
    },
    EnemyHealing = {
        gain = 1,
        loop = false,
        source_group = "SFX",
        files = {"Sound_EnemyHealing.ogg"}
    },
    EnemyInfernoBossDeath = {
        gain = 0.9,
        loop = false,
        source_group = "SFX",
        files = {"inferno_boss_death.ogg"}
    },
    EnemyInfernoHorns = {
        gain = 0.9,
        loop = false,
        source_group = "SFX",
        files = {"inferno_boss_horns.ogg"}
    },
    EnemyInfernoStomp = {
        gain = 0.9,
        loop = false,
        source_group = "SFX",
        files = {"inferno_boss_stomp.ogg"}
    },
    EnemyMushroomBorn = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"KR_sfx_mushroomcreep_nacimiento.ogg"}
    },
    EnemyMushroomBossDeath = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"KR_sfx_mushroomboss_muerte.ogg"}
    },
    EnemyMushroomDeath = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"KR_sfx_mushroomcreep_muerte_edit_vanzen.ogg"}
    },
    EnemyMushroomGas = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"KR_sfx_mushroomboss_gas_op1.ogg"}
    },
    EnemyRocketeer = {
        gain = 0.6,
        loop = false,
        source_group = "SFX",
        files = {"Sound_EnemyRocketeer.ogg"}
    },
    EngineerBfgClusterTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"BFG_Taunt1.ogg"}
    },
    EngineerBfgMissileTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"BFG_Taunt2.ogg"}
    },
    EngineerBfgTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"BFG_Ready.ogg"}
    },
    EngineerTaunt = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Artillery_Ready.ogg", "Artillery_Taunt1.ogg", "Artillery_Taunt2.ogg"}
    },
    EngineerTeslaChargedBoltTaunt = {
        gain = 0.6,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Tesla_Taunt2a.ogg", "Tesla_Taunt2b.ogg", "Tesla_Taunt2c.ogg"}
    },
    EngineerTeslaOverchargeTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Tesla_Taunt1.ogg"}
    },
    EngineerTeslaTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Tesla_Ready.ogg"}
    },
    ExtraBlackburnCrow = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_crow.ogg"}
    },
    ExtraBlackburnNessie = {
        gain = 0.5,
        loop = false,
        source_group = "SFX",
        files = {"kr_sfx_cb_nessie.ogg"}
    },
    FireballHit = {
        gain = 0.5,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_FireballHit.ogg"}
    },
    FireballRelease = {
        gain = 0.5,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_FireballUnleash.ogg"}
    },
    GUIAchievementWin = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_AchievementWin.ogg"}
    },
    GUIButtonCommon = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_GUIButtonCommon.ogg"}
    },
    GUIBuyUpgrade = {
        gain = 0.6,
        loop = false,
        source_group = "GUI",
        files = {"Sound_GUIBuyUpgrade.ogg"}
    },
    GUICoins = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_Coins.ogg"}
    },
    GUILooseLife = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_LooseLife.ogg"}
    },
    GUIMapNewFlah = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_MapNewFlag.ogg"}
    },
    GUINextWaveIncoming = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_WaveIncoming.ogg"}
    },
    GUINextWaveReady = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_NextWaveReady.ogg"}
    },
    GUINotificationClose = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_NotificationClose.ogg"}
    },
    GUINotificationOpen = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_NotificationOpen.ogg"}
    },
    GUINotificationPaperOver = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_NotificationPaperOver.ogg"}
    },
    GUINotificationSecondLevel = {
        gain = 0.8,
        loop = false,
        source_group = "GUI",
        files = {"Sound_NotificationSecondLevel.ogg"}
    },
    GUIPlaceRallyPoint = {
        gain = 0.8,
        loop = false,
        source_group = "GUI",
        files = {"Sound_RallyPointPlaced.ogg"}
    },
    GUIQuestCompleted = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_QuestCompleted.ogg"}
    },
    GUIQuestFailed = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_QuestFailed.ogg"}
    },
    GUIQuickMenuOpen = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_GUIOpenTowerMenu.ogg"}
    },
    GUIQuickMenuOver = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_GUIMouseOverTowerIcon.ogg"}
    },
    GUISpellRefresh = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_SpellRefresh.ogg"}
    },
    GUISpellSelect = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_SpellSelect.ogg"}
    },
    GUITowerBuilding = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_TowerBuilding.ogg"}
    },
    GUITowerUpgrade = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_TowerUpgrade.ogg"}
    },     
    GUITowerOpenDoor = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_TowerOpenDoor.ogg"}
    },
    GUITowerSell = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_TowerSell.ogg"}
    },
    GUITransitionClose = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"GUITransitionClose.ogg"}
    },
    GUITransitionOpen = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"GUITransitionOpen.ogg"}
    },
    GUIWinStars = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_WinStars.ogg"}
    },
    GuimapNewRoad = {
        gain = 1,
        loop = false,
        source_group = "GUI",
        files = {"Sound_MapRoad.ogg"}
    },
    HWAbominationExplosion = {
        gain = 1,
        loop = false,
        source_group = "SFX",
        files = {"halloween_abominationexplosion.ogg"}
    },
    HWAlphaWolf = {
        gain = 1,
        loop = false,
        source_group = "SFX",
        files = {"halloween_werewolf_alfawolf.ogg"}
    },
    HWGhosts = {
        gain = 0.8,
        ignore = 10,
        loop = false,
        source_group = "SFX",
        files = {"halloween_werewolf_minormoans.ogg"}
    },
    HWWerewolfTransformation = {
        gain = 1,
        loop = false,
        source_group = "SFX",
        files = {"halloween_werewolf_transformation.ogg"}
    },
    HealingSound = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_PaladinHeal.ogg"}
    },
    HeroArcherDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Female-Elven-Archer-Death_a.ogg"}
    },
    HeroArcherShoot = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Aleria_special_arrow.ogg"}
    },
    HeroArcherSummon = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Aleria_sumon.ogg"}
    },
    HeroArcherTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Female-Elven-Archer-04b.ogg", "Female-Elven-Archer-02c.ogg", "Female-Elven-Archer-03a.ogg",
                 "Female-Elven-Archer-01c.ogg"}
    },
    HeroArcherTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroArcherTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Female-Elven-Archer-02c.ogg"}
    },
    HeroArcherWildCatHit = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Aleria_wildcat_hit.ogg"}
    },
    HeroDenasAttack = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"KingDenas_sfx_attack.ogg"}
    },
    HeroDenasBuff = {
        gain = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"KingDenas_sfx_order1.ogg", "KingDenas_sfx_order3.ogg"}
    },
    HeroDenasDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"KingDenas-05c.ogg"}
    },
    HeroDenasTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"KingDenas-04e.ogg", "KingDenas-02d.ogg", "KingDenas-03g.ogg", "KingDenas-01d.ogg"}
    },
    HeroDenasTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroDenasTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"KingDenas-04e.ogg"}
    },
    HeroFrostDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Frost-Mage-Death_01c.ogg"}
    },
    HeroFrostGroundFreeze = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Elora_GroundFreeze.ogg"}
    },
    HeroFrostIceRainBreak = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Elora_IceShardBreak.ogg"}
    },
    HeroFrostIceRainDrop = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Elora_IceShard.ogg"}
    },
    HeroFrostIceRainSummon = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Elora_IceShardSummon.ogg"}
    },
    HeroFrostTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Frost-Mage-04a.ogg", "Frost-Mage-03d.ogg", "Frost-Mage-02c.ogg", "Frost-Mage-01a.ogg"}
    },
    HeroFrostTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroFrostTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Frost-Mage-01a.ogg"}
    },
    HeroLevelUp = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroMageDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Young-Mage-Death_c.ogg"}
    },
    HeroMageRainCharge = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Mage_blue_rain_charge.ogg"}
    },
    HeroMageRainDrop = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Mage_blue_rain_drop.ogg"}
    },
    HeroMageShadows = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Mage_shadows.ogg"}
    },
    HeroMageTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Young-Mage-04c.ogg", "Young-Mage-02a.ogg", "Young-Mage-03c.ogg", "Young-Mage-01d.ogg"}
    },
    HeroMageTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroMageTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Young-Mage-02a.ogg"}
    },
    HeroPaladinDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Holy-Paladin-Death_b.ogg"}
    },
    HeroPaladinDeflect = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Paladin_deflect.ogg"}
    },
    HeroPaladinTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Holy-Paladin-04a.ogg", "Holy-Paladin-02c.ogg", "Holy-Paladin-03b.ogg", "Holy-Paladin-01c.ogg"}
    },
    HeroPaladinTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroPaladinTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Holy-Paladin-01c.ogg"}
    },
    HeroPaladinValor = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Paladin_shield_buff.ogg"}
    },
    HeroRainOfFireArea = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Cinder_special_area.ogg"}
    },
    HeroRainOfFireDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Elemental-Death_c.ogg"}
    },
    HeroRainOfFireFireball1 = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Cinder_special_fireball_1_start.ogg"}
    },
    HeroRainOfFireFireball2 = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Cinder_special_fireball_2_end.ogg"}
    },
    HeroRainOfFireTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Elemental-01c.ogg", "Elemental-02c.ogg", "Elemental-03b.ogg", "Elemental-04c.ogg"}
    },
    HeroRainOfFireTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroRainOfFireTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Elemental-01c.ogg"}
    },
    HeroReinforcementDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Reinforcement-Death_c.ogg"}
    },
    HeroReinforcementHit = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Motumbo_hit.ogg"}
    },
    HeroReinforcementJump = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Motumbo_jump_special.ogg"}
    },
    HeroReinforcementSpecial = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Motumbo_charge_special.ogg"}
    },
    HeroReinforcementTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Reinforcement-04b.ogg", "Reinforcement-02c.ogg", "Reinforcement-03c.ogg", "Reinforcement-01a.ogg"}
    },
    HeroReinforcementTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroReinforcementTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Reinforcement-01a.ogg"}
    },
    HeroRiflemanBrea = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Dwarf_brea_shot2.ogg"}
    },
    HeroRiflemanBreaHit = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Dwarf_brea_shot_hit.ogg"}
    },
    HeroRiflemanDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Dwarf-Rifleman-Death_c.ogg"}
    },
    HeroRiflemanMine = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Dwarf_mine.ogg"}
    },
    HeroRiflemanTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Dwarf-Rifleman-04c.ogg", "Dwarf-Rifleman-02c.ogg", "Dwarf-Rifleman-03c.ogg", "Dwarf-Rifleman-01a.ogg"}
    },
    HeroRiflemanTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroRiflemanTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Dwarf-Rifleman-01a.ogg"}
    },
    HeroHackDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Hacksaw-Death01c.ogg"}
    },
    HeroHackDrill = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"inferno_lumberjack_drill.ogg"}
    },
    HeroHackShoot = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"inferno_lumberjack_shootSaw.ogg"}
    },
    HeroHackTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Hacksaw-01c.ogg", "Hacksaw-02c.ogg", "Hacksaw-03a.ogg", "Hacksaw-04a.ogg"}
    },
    HeroHackTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroHackTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Hacksaw-01c.ogg"}
    },
    HeroSamuraiDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Oni-Death01a.ogg"}
    },
    HeroSamuraiDeathStrike = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"inferno_oni_instakill.ogg"}
    },
    HeroSamuraiTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Oni-04a.ogg", "Oni-03c.ogg", "Oni-02c.ogg", "Oni-01c.ogg"}
    },
    HeroSamuraiTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroSamuraiTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Oni-03c.ogg"}
    },
    HeroSamuraiTorment = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"inferno_oni_groundSwords.ogg"}
    },
    HeroThorDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Thor_05c.ogg", "KR_sfx_thor_muerte.ogg"}
    },
    HeroThorElectricAttack = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"KR_sfx_thor_ataqueelectrico.ogg"}
    },
    HeroThorHammer = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"KR_sfx_thor_lanzamartillo_op2.ogg"}
    },
    HeroThorTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Thor_01a.ogg", "Thor_02a.ogg", "Thor_03c.ogg", "Thor_04c.ogg"}
    },
    HeroThorTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroThorTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Thor_01a.ogg"}
    },
    HeroThorThunder = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"KR_sfx_thor_thunder.ogg"}
    },
    HeroVikingAttackHit = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Viking_Hit.ogg"}
    },
    HeroVikingBearAttackStart = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Viking_StartAttack.ogg"}
    },
    HeroVikingBearTransform = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Viking_Transform.ogg"}
    },
    HeroVikingCall = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Viking_Call.ogg"}
    },
    HeroVikingDeath = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Viking-Death_01d.ogg"}
    },
    HeroVikingTaunt = {
        gain = 1,
        ignore = 1,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Viking-01b.ogg", "Viking-03b.ogg", "Viking-02c.ogg", "Viking-01b.ogg"}
    },
    HeroVikingTauntIntro = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Level_up.ogg"}
    },
    HeroVikingTauntSelect = {
        gain = 1,
        loop = false,
        source_group = "TAUNTS",
        files = {"Viking-01b.ogg"}
    },
    HitSound = {
        gain = 0.15,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_ArrowHit2.ogg", "Sound_ArrowHit3.ogg"}
    },
    InAppAtomicBomb = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_nuke.ogg"}
    },
    InAppAtomicBombFalling = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_nuke_falling.ogg"}
    },
    InAppAtomicFreezeEnd = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_atfreezeend.ogg"}
    },
    InAppAtomicFreezeStart = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_atfreezestart.ogg"}
    },
    InAppBuyGems = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_cash.ogg"}
    },
    InAppBuyInApp = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_chin.ogg"}
    },
    InAppEarnGems = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_gems.ogg"}
    },
    InAppExtraGold = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_gnome.ogg"}
    },
    InAppExtraHearts = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_hearts.ogg"}
    },
    InAppFreeze = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"inapp_freeze.ogg"}
    },
    JtAttack = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyJtAttack.ogg"}
    },
    JtDeath = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyJtDeath.ogg"}
    },
    JtEat = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyJtEat.ogg"}
    },
    JtExplode = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyJtExplode.ogg"}
    },
    JtHitIce = {
        gain = 1,
        loop = false,
        mode = "sequence",
        source_group = "SFX",
        files = {"Sound_HitIce1.ogg", "Sound_HitIce2.ogg", "Sound_HitIce3.ogg"}
    },
    JtRest = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyJtRest.ogg"}
    },
    MageArcaneDesintegrateTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Arcane_Taunt2.ogg"}
    },
    MageArcaneTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Arcane_Ready.ogg"}
    },
    MageArcaneTeleporthTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Arcane_Taunt1.ogg"}
    },
    MageSorcererAshesToAshesTaunt = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Sorcerer_Taunt2.ogg"}
    },
    MageSorcererTaunt = {
        gain = 0.6,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Sorcerer_Ready.ogg", "Sorcerer_Taunt1.ogg", "Sorcerer_Taunt2.ogg"}
    },
    MageTaunt = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Mage_Ready.ogg", "Mage_Taunt1.ogg", "Mage_Taunt2.ogg"}
    },
    PirateBombShootSound = {
        gain = 1,
        loop = false,
        source_group = "EXPLOSIONS",
        files = {"Sound_EngineerShot.ogg"}
    },
    PolymorphSound = {
        gain = 0.9,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_Polimorph.ogg"}
    },
    ReinforcementTaunt = {
        gain = 0.6,
        loop = false,
        mode = "sequence",
        source_group = "TAUNTS",
        files = {"Reinforcements_Event1.ogg", "Reinforcements_Event2.ogg", "Reinforcements_Event3.ogg",
                 "Reinforcements_Event4.ogg"}
    },
    RockElementalDeath = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Sound_RockElementalDeath.ogg"}
    },
    RockElementalRally = {
        gain = 0.6,
        loop = false,
        source_group = "TAUNTS",
        files = {"Sound_RockElementalRally.ogg"}
    },
    RocketLaunchSound = {
        gain = 0.8,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_RocketLaunt.ogg"}
    },
    SasquashRally = {
        gain = 0.8,
        loop = false,
        source_group = "TAUNTS",
        files = {"Sound_TowerSoldierSasquashReady.ogg"}
    },
    SasquashReady = {
        gain = 0.8,
        loop = false,
        source_group = "TAUNTS",
        files = {"Sound_TowerSoldierSasquashRally.ogg"}
    },
    Sheep = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
        source_group = "TAUNTS",
        files = {"Sound_Sheep.ogg"}
    },
    ShotgunSound = {
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_Shootgun.ogg"}
    },
    ShrapnelSound = {
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_Shrapnel.ogg"}
    },
    SniperSound = {
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_Sniper.ogg"}
    },
    SpiderAttack = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
        mode = "sequence",
        source_group = "BULLETS",
        files = {
			"Sound_SpiderAttack1.ogg",
			"Sound_SpiderAttack2.ogg",
		},
    },
    TeleporthSound = {
        gain = 1,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_Teleport.ogg"}
    },
    TeslaAttack = {
        gain = 0.6,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_Tesla_attack_1.ogg", "Sound_Tesla_attack_2.ogg"}
    },
    ThornSound = {
        gain = 0.8,
        loop = false,
        source_group = "SPECIALS",
        files = {"Sound_Thorn.ogg"}
    },
    VeznanAttack = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyVeznan_attack.ogg"}
    },
    VeznanDeath = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyVeznan_death.ogg"}
    },
    VeznanDemonFire = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyVeznan_demonFire.ogg"}
    },
    VeznanHoldCast = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_SpellTowerHold_Cast.ogg"}
    },
    VeznanHoldDissipate = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_SpellTowerHold_Dissipate.ogg"}
    },
    VeznanHoldHit = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_SpellTowerHold_Hit.ogg"}
    },
    VeznanHoldTrap = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_SpellTowerHold_Trap.ogg"}
    },
    VeznanPortalIn = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_DemonPortal_Telein.ogg"}
    },
    VeznanPortalSummon = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_DemonPortal_Summon.ogg"}
    },
    VeznanToDemon = {
        gain = 1,
        loop = false,
        source_group = "BULLETS",
        files = {"Sound_EnemyVeznan_toDemon.ogg"}
    },
    WolfAttack = {
        gain = 0.6,
        ignore = 1.5,
        loop = false,
        mode = "sequence",
        source_group = "BULLETS",
        files = {"Sound_WolfAttack.ogg", "Sound_WolfAttack2.ogg"}
    },
---时间法师
    AncientGuardSpawn = {
		loop = false,
		gain = 1.5,
		source_group = "TAUNTS",
		files = {
			"ancient_guardian_spawn.ogg"
		}
	},
	AncientGuardDeath = {
		loop = false,
		gain = 1.5,
		source_group = "TAUNTS",
		files = {
			"ancient_guardian_death.ogg"
		}
	},
	AncientGuardRally = {
		loop = false,
		mode = "sequence",
		gain = 1.5,
		source_group = "TAUNTS",
		files = {
			"ancient_guardian_taunt1.ogg",
			"ancient_guardian_taunt2.ogg",
			"ancient_guardian_taunt3.ogg",
			"ancient_guardian_taunt4.ogg",
		}
	},
    MageTimeWizardTaunt = {
		loop = false,
		mode = "sequence",
		gain = 2,
		source_group = "TAUNTS",
		files = {
			"time_wizard_taunt_ready.ogg"
		}
	},
	MageTimeWizardGuardian = {
		loop = false,
		mode = "sequence",
		gain = 2,
		source_group = "TAUNTS",
		files = {
			"time_wizard_taunt_guard.ogg"
		}
	},
	MageTimeWizardSandstorm = {
		loop = false,
		gain = 2,
		ignore = 1.5,
		source_group = "TAUNTS",
		files = {
			"time_wizard_taunt_sandstorm.ogg"
		}
	},
---蒸汽部队    
	SteamTrooperAttack = {
		loop = false,
		gain = 1,
		source_group = "EXPLOSIONS",
		files = {
			"Steam_Troop_Attack.ogg"
		}
	},
	SteamTrooperRally = {
		loop = false,
		mode = "sequence",
		gain = 1.8,
		source_group = "TAUNTS",
		files = {
			"steam_troopers_taunt-1.ogg",
			"steam_troopers_taunt-3.ogg",
			"steam_troopers_taunt-4.ogg",
		}
	},
	SteamTroopSteam = {
		loop = false,
		gain = 1.8,
		source_group = "TAUNTS",
		files = {
			"steam_troopers_taunt-5.ogg",
		}
	},
	SteamTrooperInsert = {
		loop = false,
		gain = 1.8,
		source_group = "TAUNTS",
		files = {
			"steam_troopers_taunt-3.ogg",
		}
	},
	SteamTroopSpeed = {
		loop = false,
		gain = 1.8,
		source_group = "TAUNTS",
		files = {
			"steam_troopers_taunt-2.ogg",
		}
	},
	SteamTroopAirstrike = {
		loop = false,
		gain = 1.8,
		source_group = "TAUNTS",
		files = {
			"steam_troopers_taunt-6.ogg",
		}
	},
    SteamTroopersAirstrike = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"steam_troopers_airstrike.ogg",
		}
	},
---精英军团弓兵    
	LegionArcherFlareShot = {
		loop = false,
		gain = 1,
		source_group = "SPECIALS",
		files = {
			"kre_sfx_arivan_fireballsummon[op2].ogg"
		}
	},
	LegionArcherFlareTaunt = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"legionnaire_taunt_1.ogg"
		}
	},
	LegionArcherMultishotTaunt = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"legionnaire_taunt_2.ogg"
		}
	},
        ---电击手
    HeroVoltaireTaunt = {
		loop = false,
		gain = 0.5,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"hero_voltaire_taunt-1.ogg",
			"hero_voltaire_taunt-2.ogg",
			"hero_voltaire_taunt-3.ogg",
			"hero_voltaire_taunt-4.ogg"
		}
	},
	HeroVoltaireDeath = {
		loop = false,
		gain = 0.5,
		ignore = 1,
		source_group = "TAUNTS",
		files = {
			"hero_voltaire_taunt-5.ogg"
		}
	},
	HeroVoltaireTauntIntro = {
		loop = false,
		gain = 1.5,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg"
		}
	},
	HeroVoltaireTauntSelect = {
		loop = false,
		gain = 0.5,
		source_group = "TAUNTS",
		files = {
			"hero_voltaire_taunt-1.ogg"
		}
	},
    VoltaireCoilInsert = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr4_power_juggernaut_liftoff_transform.ogg"
		}
	},
	VoltaireCoilRemove = {
		loop = false,
		gain = 1,
		source_group = "SFX",
		files = {
			"kr4_hero_tank_groundslam_lift.ogg"
		}
	},
    ---毒蛇
    HeroViperCurse = {
		loop = false,
		gain = 1.5,
		source_group = "SPECIALS",
		files = {
			"hero_viper_curseattack.ogg"
		}
	},
    HeroViperTaunt = {
		loop = false,
		gain = 1,
		ignore = 1,
		mode = "sequence",
		source_group = "TAUNTS",
		files = {
			"hero_viper_taunt_1.ogg",
			"hero_viper_taunt_2.ogg",
			"hero_viper_taunt_3.ogg",
			"hero_viper_taunt_4.ogg"
		}
	},
	HeroViperTauntIntro = {
		loop = false,
		gain = 1.5,
		source_group = "TAUNTS",
		files = {
			"Level_up.ogg"
		}
	},
	HeroViperTauntSelect = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"hero_viper_taunt_3.ogg"
		}
	},
	HeroViperDeath = {
		loop = false,
		gain = 1,
		source_group = "TAUNTS",
		files = {
			"hero_viper_taunt_5.ogg"
		}
	},
	PowerLightning = {
		loop = false,
		gain = 0.8,
		source_group = "SFX",
		files = {
			"80__-3R.wav"
		}
	},    
}
