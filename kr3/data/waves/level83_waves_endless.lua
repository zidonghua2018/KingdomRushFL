-- chunkname: @/var/folders/r9/xbxmw8n51957gv9ggzrytvf80000gp/T/com.ironhidegames.frontiers.windows.steam.ep3S4swo/kr2/data/waves/level81_waves_endless.lua

return {
	interval_less_needed = 0,
	nextWaveRewardMoneyMultiplier = 3.5,
	gold = 520,
	interval_less_cut = 0,
	lifes = 10,
	waves_to_increment = 10,
	max_paths = 7,
	bossConfig = {
		powerConfig = {
			powerProgressionWaveStart = 11,
			invisibility = {
				durationIncrement = 0.2,
				range = 150,
				reapearBeforeEndNodes = 40,
				duration = 5,
				pathNodesConfig = {
					{
						nodesBeforeEnd = 84,
						nodesAfterStart = 32
					},
					{
						nodesBeforeEnd = 88,
						nodesAfterStart = 27
					},
					{
						nodesBeforeEnd = 65,
						nodesAfterStart = 27
					},
					{
						nodesBeforeEnd = 64,
						nodesAfterStart = 24
					},
					{
						nodesBeforeEnd = 70,
						nodesAfterStart = 23
					},
					{
						nodesBeforeEnd = 72,
						nodesAfterStart = 19
					},
					{
						nodesBeforeEnd = 61,
						nodesAfterStart = 19
					}
				}
			},
			obelysk = {
				durationIncrement = 0.2,
				autoSpawnMinInterval = 0.8,
				range = 15,
				duration = 8,
				autoSpawnMaxInterval = 1.6,
				pathNodesConfig = {
					{
						nodesBeforeEnd = 84,
						nodesAfterStart = 32
					},
					{
						nodesBeforeEnd = 88,
						nodesAfterStart = 27
					},
					{
						nodesBeforeEnd = 65,
						nodesAfterStart = 27
					},
					{
						nodesBeforeEnd = 64,
						nodesAfterStart = 24
					},
					{
						nodesBeforeEnd = 70,
						nodesAfterStart = 23
					},
					{
						nodesBeforeEnd = 72,
						nodesAfterStart = 19
					},
					{
						nodesBeforeEnd = 61,
						nodesAfterStart = 19
					}
				}
			},
			teleport = {
				minNodesToTeleport = 25,
				range = 85,
				maxTeleports = 6,
				maxTeleportsIncrement = 0.25,
				teleportDelay = 0.1,
				durationIncrement = 0.15,
				duration = 6,
				maxNodesToTeleport = 35,
				pathNodesConfig = {
					{
						nodesBeforeEnd = 84,
						nodesAfterStart = 32
					},
					{
						nodesBeforeEnd = 88,
						nodesAfterStart = 27
					},
					{
						nodesBeforeEnd = 65,
						nodesAfterStart = 27
					},
					{
						nodesBeforeEnd = 64,
						nodesAfterStart = 24
					},
					{
						nodesBeforeEnd = 70,
						nodesAfterStart = 23
					},
					{
						nodesBeforeEnd = 72,
						nodesAfterStart = 19
					},
					{
						nodesBeforeEnd = 61,
						nodesAfterStart = 19
					}
				}
			}
		}
	},
	chancesToUseNextDifficulty = {
		0,
		0.1,
		0.2,
		0.3,
		0.3
	},
	difficulties = {
		{
			multiple_paths_chance_increment = 6,
			multiple_paths_chance = 5,
			max_paths = 2,
			bossConfig = {
				powerCooldownMin = 10,
				powerCooldownMax = 15,
				powerMultiChance = 0,
				powerChance = 0,
				powerChanceIncrement = 0,
				powerDistribution = {
					0.4,
					0.3,
					0.3
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1000,
					name = "T0-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 250,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 350,
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 5,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = "5",
							cant_increment = 1,
							interval_next = 35,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 350,
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_raider",
							cant = 2,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 30,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_tremor",
							cant = 5,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 250,
					name = "T0-Wulf",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_wolf_small",
							cant = 6,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_raider",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 350,
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 5,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = "5",
							cant_increment = 1,
							interval_next = 35,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 350,
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 5,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = "5",
							cant_increment = 1,
							interval_next = 35,
							path = 0
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 4,
			multiple_paths_chance = 20,
			max_paths = 3,
			bossConfig = {
				powerCooldownMin = 7,
				powerCooldownMax = 12,
				powerMultiChance = 0.1,
				powerChance = 0.1,
				powerChanceIncrement = 0.02,
				powerDistribution = {
					0.5,
					0.5,
					0
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1500,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 1500,
					name = "T1-Boss",
					spawns = {
						{
							interval = 200,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 380,
					name = "T1-Bouncer",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 300,
					name = "T1-Tremors",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_tremor",
							cant = 5,
							cant_increment = 1,
							interval_next = 70,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_tremor",
							cant = 5,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T1-RaidBounc",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_raider",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_bouncer",
							cant = 8,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 300,
					name = "T1-Wulf",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_wolf_small",
							cant = 5,
							cant_increment = 1,
							interval_next = 70,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf_small",
							cant = 5,
							cant_increment = 2,
							interval_next = 40,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Raiders",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 40,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 80,
							path = 2
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_raider",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-RaidArch",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_raider",
							cant = 2,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_raider",
							cant = 2,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_raider",
							cant = 2,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T2-Wasps",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_wasp",
							cant = 6,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 380,
					name = "T1-Bouncer",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 4,
			multiple_paths_chance = 25,
			max_paths = 3,
			bossConfig = {
				powerCooldownMin = 7,
				powerCooldownMax = 12,
				powerMultiChance = 0.2,
				powerChance = 0.2,
				powerChanceIncrement = 0.02,
				powerDistribution = {
					0.4,
					0.4,
					0.2
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1500,
					name = "T2-Boss-Imm",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 1500,
					name = "T2-Boss-Imm",
					spawns = {
						{
							interval = 200,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 450,
					name = "T2-RaidArch",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_desert_raider",
							cant = 3,
							cant_increment = 0,
							interval_next = 50,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_desert_archer",
							cant = 2,
							cant_increment = 1,
							interval_next = 20,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_raider",
							cant = 5,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_desert_archer",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T2-ImmArchRaid",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_immortal",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_desert_archer",
							cant = 2,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_raider",
							cant = 6,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 260,
					name = "T2-Wolves",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_wolf_small",
							cant = 8,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_wolf",
							cant = 3,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_wolf",
							cant = 5,
							cant_increment = 2,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T2-BounArchImmRaid",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 6,
							cant_increment = 1,
							interval_next = 40,
							path = 2
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_archer",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_bouncer",
							cant = 8,
							cant_increment = 1,
							interval_next = 20,
							path = 2
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_raider",
							cant = 5,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-ImmRaidBounc",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_immortal",
							cant = 3,
							cant_increment = 1,
							interval_next = 125,
							path = 2
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_raider",
							cant = 4,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_bouncer",
							cant = 8,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 350,
					name = "T2-Wasp",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_wasp",
							cant = 5,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_wasp",
							cant = 7,
							cant_increment = 2,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 350,
					name = "T2-BouncerRaid",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 10,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_archer",
							cant = 2,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 10,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_archer",
							cant = 2,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 350,
					name = "T2-Tremors",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_tremor",
							cant = 4,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_tremor",
							cant = 5,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_tremor",
							cant = 6,
							cant_increment = 2,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 300,
					name = "T2-Archers",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_archer",
							cant = 5,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_archer",
							cant = 5,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 4,
			multiple_paths_chance = 30,
			max_paths = 4,
			bossConfig = {
				powerCooldownMin = 8,
				powerCooldownMax = 14,
				powerMultiChance = 0.3,
				powerChance = 0.4,
				powerChanceIncrement = 0.02,
				powerDistribution = {
					0.4,
					0.3,
					0.3
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1500,
					name = "T2-Boss-Imm",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 1500,
					name = "T2-Boss-Imm",
					spawns = {
						{
							interval = 200,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 1500,
					name = "T1-Boss",
					spawns = {
						{
							interval = 400,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_raider",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 600,
					name = "T3-ImmBouncArch",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_bouncer",
							cant = 12,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_immortal",
							cant = 6,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_archer",
							cant = 3,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 700,
					name = "T3-Scorps",
					spawns = {
						{
							interval = 70,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_scorpion",
							cant = 3,
							cant_increment = 0,
							interval_next = 100,
							path = 0
						},
						{
							interval = 60,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_scorpion",
							cant = 3,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 60,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_scorpion",
							cant = 2,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T3-Wolves",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 6,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 10,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf_small",
							cant = 15,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 8,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T3-ImmRaidArch",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_raider",
							cant = 5,
							cant_increment = 1,
							interval_next = 25,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_archer",
							cant = 3,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_archer",
							cant = 3,
							cant_increment = 1,
							interval_next = 30,
							path = 2
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_immortal",
							cant = 4,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 800,
					name = "T3-RaiderWraith",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_raider",
							cant = 5,
							cant_increment = 1,
							interval_next = 20,
							path = 2
						},
						{
							interval = 80,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_munra",
							cant = 1,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T3-TremorScorp",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_tremor",
							cant = 6,
							cant_increment = 1,
							interval_next = 30,
							path = 2
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_tremor",
							cant = 6,
							cant_increment = 1,
							interval_next = 20,
							path = 2
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_scorpion",
							cant = 4,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T3-ArchImm",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_immortal",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 1
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_archer",
							cant = 6,
							cant_increment = 1,
							interval_next = 30,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_immortal",
							cant = 3,
							cant_increment = 1,
							interval_next = 80,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T3-Wasps",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_wasp",
							cant = 4,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 150,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_wasp_queen",
							cant = 1,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_wasp",
							cant = 6,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 950,
					name = "T3-WraithArch",
					spawns = {
						{
							interval = 80,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_munra",
							cant = 3,
							cant_increment = 1,
							interval_next = 200,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T3-Exec",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_raider",
							cant = 6,
							cant_increment = 1,
							interval_next = 0,
							path = 0
						},
						{
							interval = 250,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_executioner",
							cant = 1,
							cant_increment = 1,
							interval_next = 0,
							path = 0
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 3,
			multiple_paths_chance = 40,
			max_paths = 4,
			bossConfig = {
				powerCooldownMin = 6,
				powerCooldownMax = 12,
				powerMultiChance = 0.3,
				powerChance = 0.6,
				powerChanceIncrement = 0.02,
				powerDistribution = {
					0.4,
					0.3,
					0.3
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1500,
					name = "T2-Boss-Imm",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 1500,
					name = "T2-Boss-Imm",
					spawns = {
						{
							interval = 200,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 35,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_desert_archer",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 1500,
					name = "T1-Boss",
					spawns = {
						{
							interval = 400,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_anoobis",
							cant = 1,
							cant_increment = 0,
							interval_next = 200,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_munra",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_munra",
							cant = 1,
							cant_increment = 0,
							interval_next = 300,
							path = 1
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 650,
					name = "T4-ImmArchExec",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_immortal",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_desert_archer",
							cant = 4,
							cant_increment = 1,
							interval_next = 30,
							path = 2
						},
						{
							interval = 150,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_executioner",
							cant = 1,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_raider",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T4-RaiderImmMunra",
					spawns = {
						{
							interval = 18,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_raider",
							cant = 8,
							cant_increment = 1,
							interval_next = 25,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_immortal",
							cant = 6,
							cant_increment = 1,
							interval_next = 25,
							path = 2
						},
						{
							interval = 100,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_munra",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 700,
					name = "T4-WolfExecRaider",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_wolf",
							cant = 6,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_raider",
							cant = 6,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 100,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_executioner",
							cant = 1,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T4-Exec",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_executioner",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						},
						{
							interval = 120,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_executioner",
							cant = 1,
							cant_increment = 1,
							interval_next = 0,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 850,
					name = "T4-MunraImmo",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_immortal",
							cant = 8,
							cant_increment = 1,
							interval_next = 25,
							path = 2
						},
						{
							interval = 80,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_munra",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 850,
					name = "T4-ImmScorp",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 30,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 0,
							creep = "enemy_immortal",
							cant = 1,
							cant_increment = 0,
							interval_next = 60,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_scorpion",
							cant = 6,
							cant_increment = 2,
							interval_next = 200,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_immortal",
							cant = 6,
							cant_increment = 2,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T4-Wolves",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 6,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 8,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 18,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 10,
							cant_increment = 2,
							interval_next = 120,
							path = 0
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_wolf",
							cant = 12,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 650,
					name = "T4-Wasps",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_wasp",
							cant = 8,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 150,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_wasp_queen",
							cant = 1,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_wasp",
							cant = 12,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 850,
					name = "T4-Scorps",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_scorpion",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_scorpion",
							cant = 3,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_scorpion",
							cant = 5,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T4-TremorsArchers",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_tremor",
							cant = 8,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_tremor",
							cant = 8,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_archer",
							cant = 10,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 700,
					name = "T4-WolfRaider",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 8,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_raider",
							cant = 8,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 8,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T4-WolfsmWolf",
					spawns = {
						{
							interval = 12,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_desert_wolf_small",
							cant = 10,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_desert_wolf",
							cant = 8,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_desert_wolf",
							cant = 8,
							cant_increment = 2,
							interval_next = 80,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T4-BouncerMunra",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_bouncer",
							cant = 10,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 80,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_munra",
							cant = 3,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						}
					}
				}
			}
		}
	},
	enemyProgression = {
		DEFAULT = {
			armor = {
				factor = 1,
				cicle = 1
			},
			damage = {
				limit = 3,
				cicle = 1,
				factor = 1.04
			},
			gold = {
				limit = 0.4,
				cicle = 1,
				factor = 0.975,
				base = 1
			},
			health = {
				limit = 3,
				cicle = 1,
				factor = 1.05
			},
			magicArmor = {
				factor = 1,
				cicle = 1
			},
			megaHealth = {
				activeAfterWave = 50,
				cicle = 1,
				factor = 1.05
			}
		},
		enemy_anoobis = {
			damage = {
				factor = 1.05,
				limit = 5
			},
			gold = {
				factor = 1.035,
				limit = 2
			},
			health = {
				cicle = 10,
				factor = 1,
				factor_steps = {
					1,
					1.5,
					3,
					4.5,
					9.6,
					14.4
				}
			}
		},
		enemy_bouncer = {
			gold = {
				factor = 0.98,
				limit = 0.5
			},
			health = {
				limit = 5
			}
		},
		enemy_desert_archer = {
			health = {
				factor = 1.03,
				limit = 2
			},
			magicArmor = {
				factor = 1.015,
				limit_value = 0.8
			},
			rangedDamage = {
				limit = 2.5,
				cicle = 1,
				factor = 1.03
			}
		},
		enemy_desert_raider = {
			armor = {
				factor = 1.025,
				limit_value = 0.7
			},
			gold = {
				factor = 0.98,
				limit = 0.5
			},
			health = {
				limit = 2.5
			}
		},
		enemy_desert_wolf = {
			gold = {
				factor = 0.98,
				limit = 0.5
			},
			health = {
				factor = 1.035
			},
			magicArmor = {
				factor = 1.015,
				limit_value = 0.85
			}
		},
		enemy_desert_wolf_small = {
			gold = {
				factor = 0.98,
				limit = 0.5
			},
			health = {
				factor = 1.03,
				limit = 2.5
			}
		},
		enemy_executioner = {
			health = {
				factor = 1.03
			}
		},
		enemy_fallen = {
			health = {
				factor = 1.03,
				limit = 4
			}
		},
		enemy_immortal = {
			armor = {
				factor = 1.015,
				limit_value = 0.95
			},
			health = {
				factor = 1.035,
				limit = 2.5
			}
		},
		enemy_munra = {
			healPoints = {
				limit = 3,
				cicle = 1,
				factor = 1.05
			},
			health = {
				factor = 1.03,
				limit = 2
			},
			rangedDamage = {
				limit = 4,
				cicle = 1,
				factor = 1.05
			}
		},
		enemy_scorpion = {
			armor = {
				factor = 1.01,
				limit_value = 0.95
			},
			health = {
				factor = 1.035,
				limit = 2.5
			}
		},
		enemy_wasp = {
			health = {
				factor = 1.02
			}
		},
		enemy_wasp_queen = {
			health = {
				factor = 1.02
			}
		}
	},
	pathConfig = {
		{
			0,
			1
		},
		{
			2,
			3
		},
		{
			4,
			5
		},
		{
			6
		}
	},
	score = {
		scorePerWave = 100,
		scoreNextWaveMultiplier = 1,
		scoreEnemyMultiplier = 0.05
	}
}
