-- chunkname: @./kr3/data/waves/level81_waves_endless.lua

return {
	interval_less_needed = 0,
	nextWaveRewardMoneyMultiplier = 3.5,
	gold = 340,
	interval_less_cut = 0,
	lifes = 10,
	waves_to_increment = 10,
	max_paths = 5,
	bossConfig = {
		powerConfig = {
			powerProgressionWaveStart = 11,
			barrel = {
				multishotChance = 0.1,
				multishotChanceIncrement = 0.02,
				durationMax = 12,
				durationIncrement = 1,
				duration = 8,
				reload = 3,
				pathNodesConfig = {
					{
						nodesBeforeEnd = 50,
						nodesAfterStart = 90
					},
					{
						nodesBeforeEnd = 50,
						nodesAfterStart = 90
					},
					{
						nodesBeforeEnd = 50,
						nodesAfterStart = 90
					},
					{
						nodesBeforeEnd = 50,
						nodesAfterStart = 90
					},
					{
						nodesBeforeEnd = 50,
						nodesAfterStart = 90
					},
					{
						nodesBeforeEnd = 50,
						nodesAfterStart = 90
					}
				}
			},
			catapult = {
				damageRock = 100,
				durationMax = 12,
				duration = 8,
				multishotChance = 0.1,
				multishotChanceIncrement = 0.05,
				spikedBallArea = 120,
				minRange = 150,
				munitionReload = 3,
				durationIncrement = 0.5,
				rockArea = 120,
				damageSpikedBall = 200,
				damageBomb = 300,
				maxRange = 800,
				bombArea = 120
			},
			snare = {
				durationIncrement = 0.2,
				duration = 5,
				durationMax = 8
			}
		}
	},
	chancesToUseNextDifficulty = {
		0.1,
		0.2,
		0.2,
		0.3,
		0.5
	},
	difficulties = {
		{
			multiple_paths_chance_increment = 3,
			multiple_paths_chance = 0,
			max_paths = 2,
			bossConfig = {
				powerCooldownMin = 10,
				powerChanceIncrement = 0.04,
				powerMultiChance = 0,
				powerCooldownMax = 15,
				powerChance = 0.2,
				barrelAmountDistribution = {
					1,
					0,
					0
				},
				barrelTypeDistribution = {
					0.3,
					0.3,
					0.2
				},
				catapultAmountDistribution = {
					1,
					0,
					0
				},
				catapultMunitionTypeDistribution = {
					1,
					0,
					0
				},
				powerDistribution = {
					0.3,
					0,
					0.7
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1000,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_warleader",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 400,
					name = "T0-Reavers",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_reaver",
							cant = 5,
							cant_increment = 1,
							interval_next = 75,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_reaver",
							cant = "5",
							cant_increment = 1,
							interval_next = 35,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T0-BurnReav",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_burner",
							cant = 4,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_reaver",
							cant = 5,
							cant_increment = 1,
							interval_next = 30,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 300,
					name = "T0-Burners",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_burner",
							cant = 9,
							cant_increment = 1,
							interval_next = 20,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 200,
					name = "T0-Spiderling",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_spider_arachnomancer",
							cant = 2,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_spider_arachnomancer",
							cant = 2,
							cant_increment = 1,
							interval_next = 0,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T0-GnollMix",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_reaver",
							cant = 4,
							cant_increment = 1,
							interval_next = 20,
							path = 2
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_burner",
							cant = 3,
							cant_increment = 1,
							interval_next = 20,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_reaver",
							cant = 4,
							cant_increment = 1,
							interval_next = 30,
							path = 2
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 4,
			multiple_paths_chance = 10,
			max_paths = 2,
			bossConfig = {
				powerCooldownMin = 10,
				powerChanceIncrement = 0.04,
				powerMultiChance = 0.2,
				powerCooldownMax = 15,
				powerChance = 0.25,
				barrelAmountDistribution = {
					0.5,
					0.5,
					0
				},
				barrelTypeDistribution = {
					1
				},
				catapultAmountDistribution = {
					0.7,
					0.3
				},
				catapultMunitionTypeDistribution = {
					0.8,
					0.2
				},
				powerDistribution = {
					0.2,
					0.6,
					0.2
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1000,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_warleader",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 400,
					name = "T1-GnawerReav",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_reaver",
							cant = 5,
							cant_increment = 1,
							interval_next = 30,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_gnawer",
							cant = "1",
							cant_increment = 1,
							interval_next = 75,
							path = 1
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_gnoll_gnawer",
							cant = "1",
							cant_increment = 1,
							interval_next = 75,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_reaver",
							cant = 5,
							cant_increment = 1,
							interval_next = 30,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T1-Gnawer",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_gnawer",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_gnawer",
							cant = 2,
							cant_increment = 1,
							interval_next = 75,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 350,
					name = "T1-Perython",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_perython",
							cant = 3,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_perython",
							cant = 4,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 300,
					name = "T1-SpiderMix",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_sword_spider",
							cant = 3,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_spider_arachnomancer",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T1-Burner",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = 7,
							cant_increment = 1,
							interval_next = 90,
							path = 2
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = 7,
							cant_increment = 1,
							interval_next = 20,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T1-BurnGnawer",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_gnoll_gnawer",
							cant = 1,
							cant_increment = 1,
							interval_next = 90,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_burner",
							cant = 5,
							cant_increment = 1,
							interval_next = 30,
							path = 2
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_gnawer",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-GnawPunch",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_gnawer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 5,
			multiple_paths_chance = 20,
			max_paths = 2,
			bossConfig = {
				powerChanceIncrement = 0.04,
				powerCooldownMin = 10,
				powerMultiChance = 0.2,
				powerCooldownMax = 15,
				multishotIncrement = 0.05,
				powerChance = 0.3,
				barrelAmountDistribution = {
					1,
					0,
					0
				},
				barrelTypeDistribution = {
					0.25,
					0.25,
					0.5
				},
				catapultAmountDistribution = {
					0.5,
					0.35,
					0.15
				},
				catapultMunitionTypeDistribution = {
					0.3,
					0.6,
					0.1
				},
				powerDistribution = {
					0.25,
					0.5,
					0.25
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1000,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_warleader",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 600,
					name = "T2-GnollParty",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_gnawer",
							cant = 2,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_burner",
							cant = "7",
							cant_increment = 1,
							interval_next = 30,
							path = 1
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_gnawer",
							cant = "2",
							cant_increment = 1,
							interval_next = 90,
							path = 2
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_reaver",
							cant = "7",
							cant_increment = 1,
							interval_next = 50,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T2-Hyena",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_hyena",
							cant = 3,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_hyena",
							cant = 4,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_hyena",
							cant = 5,
							cant_increment = 1,
							interval_next = 30,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T2-SpiderMix",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_sword_spider",
							cant = 2,
							cant_increment = 1,
							interval_next = 45,
							path = 2
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_webspitting_spider",
							cant = 2,
							cant_increment = 1,
							interval_next = 110,
							path = 2
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_spider_arachnomancer",
							cant = 3,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Websword",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_webspitting_spider",
							cant = 1,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_sword_spider",
							cant = 3,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_webspitting_spider",
							cant = 1,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T2-Spiderling",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_spider_arachnomancer",
							cant = 4,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_spider_arachnomancer",
							cant = 4,
							cant_increment = 1,
							interval_next = 75,
							path = 2
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_spider_arachnomancer",
							cant = 5,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T2-Perython",
					spawns = {
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_perython",
							cant = 4,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_perython",
							cant = 4,
							cant_increment = 1,
							interval_next = 110,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_perython",
							cant = 4,
							cant_increment = 1,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T2-Carrier",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_perython_gnoll_gnawer",
							cant = 1,
							cant_increment = 1,
							interval_next = 40,
							path = 2
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_perython_gnoll_gnawer",
							cant = 1,
							cant_increment = 1,
							interval_next = 40,
							path = 1
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_perython_gnoll_gnawer",
							cant = 1,
							cant_increment = 1,
							interval_next = 40,
							path = 2
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_perython_gnoll_gnawer",
							cant = 1,
							cant_increment = 1,
							interval_next = 40,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 300,
					name = "T2-GnollRain",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = 9,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_reaver",
							cant = "9",
							cant_increment = 1,
							interval_next = 50,
							path = 1
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = "9",
							cant_increment = 1,
							interval_next = 30,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T2-Sword",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_sword_spider",
							cant = 6,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_sword_spider",
							cant = 6,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T2-Ettin",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 1,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						},
						{
							interval = 120,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 2
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 5,
			multiple_paths_chance = 25,
			max_paths = 3,
			bossConfig = {
				powerChanceIncrement = 0.04,
				powerCooldownMin = 10,
				powerMultiChance = 0.3,
				powerCooldownMax = 15,
				multishotIncrement = 0.05,
				powerChance = 0.4,
				barrelAmountDistribution = {
					1,
					0,
					0
				},
				barrelTypeDistribution = {
					0.2,
					0.2,
					0.4,
					0.2
				},
				catapultAmountDistribution = {
					0.3,
					0.4,
					0.3
				},
				catapultMunitionTypeDistribution = {
					0,
					0.7,
					0.3
				},
				powerDistribution = {
					0.3,
					0.4,
					0.3
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1000,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_warleader",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 700,
					name = "T3-GnollMarch",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_burner",
							cant = 8,
							cant_increment = 1,
							interval_next = 10,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_blighter",
							cant = "2",
							cant_increment = 1,
							interval_next = 30,
							path = 1
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_gnawer",
							cant = "5",
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T3-Flying",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_perython",
							cant = 5,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_perython",
							cant = 5,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_perython",
							cant = 5,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T3-SpiderMix",
					spawns = {
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_webspitting_spider",
							cant = 1,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_sword_spider",
							cant = 5,
							cant_increment = 1,
							interval_next = 35,
							path = 2
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_webspitting_spider",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-BlightGuard",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_gnoll_blighter",
							cant = 1,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_reaver",
							cant = 7,
							cant_increment = 1,
							interval_next = 10,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_gnoll_blighter",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_reaver",
							cant = 8,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T3-Ettin",
					spawns = {
						{
							interval = 80,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 2,
							cant_increment = 1,
							interval_next = 250,
							path = 2
						},
						{
							interval = 80,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_ettin",
							cant = 2,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T3-EttinHyena",
					spawns = {
						{
							interval = 150,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_hyena",
							cant = 7,
							cant_increment = 1,
							interval_next = 150,
							path = 2
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_hyena",
							cant = 8,
							cant_increment = 1,
							interval_next = 90,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T3-SwordWave",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_sword_spider",
							cant = 7,
							cant_increment = 1,
							interval_next = 85,
							path = 2
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_sword_spider",
							cant = 7,
							cant_increment = 1,
							interval_next = 85,
							path = 2
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_sword_spider",
							cant = 7,
							cant_increment = 1,
							interval_next = 85,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 700,
					name = "T3-Slow",
					spawns = {
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 1,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 8,
							creep = "enemy_gnoll_blighter",
							cant = "2",
							cant_increment = 1,
							interval_next = 150,
							path = 1
						},
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = "2",
							cant_increment = 1,
							interval_next = 150,
							path = 1
						}
					}
				},
				{
					next_wave_interval = 350,
					name = "T3-GnawLine",
					spawns = {
						{
							interval = 60,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_gnoll_gnawer",
							cant = 9,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T3-GnollHyena",
					spawns = {
						{
							interval = 15,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = 12,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_hyena",
							cant = 15,
							cant_increment = 1,
							interval_next = 90,
							path = 2
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 4,
			multiple_paths_chance = 30,
			max_paths = 3,
			bossConfig = {
				powerChanceIncrement = 0.04,
				powerCooldownMin = 10,
				powerMultiChance = 0.4,
				powerCooldownMax = 12,
				multishotIncrement = 0.05,
				powerChance = 0.5,
				barrelAmountDistribution = {
					0.2,
					0.6,
					0.2
				},
				barrelTypeDistribution = {
					0,
					0.2,
					0.4,
					0.4
				},
				catapultAmountDistribution = {
					0.2,
					0.6,
					0.2
				},
				catapultMunitionTypeDistribution = {
					0,
					0.5,
					0.5
				},
				powerDistribution = {
					0.3,
					0.4,
					0.3
				}
			},
			bossWaves = {
				{
					next_wave_interval = 1000,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_warleader",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 500,
					name = "T4-GnollMarch",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_gnoll_gnawer",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_gnoll_blighter",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 8,
							creep = "enemy_gnoll_blighter",
							cant = 3,
							cant_increment = 1,
							interval_next = 250,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = 6,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T4-Razor",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_razorboar",
							cant = 1,
							cant_increment = 0,
							interval_next = 60,
							path = 0
						},
						{
							interval = 70,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_razorboar",
							cant = 2,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						},
						{
							interval = 70,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_razorboar",
							cant = 1,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T4-EttinPunch",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_gnoll_gnawer",
							cant = 6,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 3,
							cant_increment = 1,
							interval_next = 75,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 8,
							creep = "enemy_gnoll_blighter",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T4-SpiderMix",
					spawns = {
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_webspitting_spider",
							cant = 5,
							cant_increment = 1,
							interval_next = 100,
							path = 2
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_spider_arachnomancer",
							cant = 8,
							cant_increment = 1,
							interval_next = 50,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T4-Carrier",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_perython_gnoll_gnawer",
							cant = 5,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_perython_gnoll_gnawer",
							cant = 5,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 350,
					name = "T4-Hyena",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_hyena",
							cant = 8,
							cant_increment = 1,
							interval_next = 150,
							path = 2
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_hyena",
							cant = 8,
							cant_increment = 1,
							interval_next = 150,
							path = 2
						},
						{
							interval = 18,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_hyena",
							cant = 8,
							cant_increment = 1,
							interval_next = 150,
							path = 2
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T3-RazorForm",
					spawns = {
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_razorboar",
							cant = 1,
							cant_increment = 0,
							interval_next = 55,
							path = 0
						},
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_razorboar",
							cant = 1,
							cant_increment = 0,
							interval_next = 0,
							path = 1
						},
						{
							interval = 20,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_razorboar",
							cant = 1,
							cant_increment = 0,
							interval_next = 75,
							path = 2
						},
						{
							interval = 100,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_razorboar",
							cant = 1,
							cant_increment = 1,
							interval_next = 75,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T4-BlightSpider",
					spawns = {
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 8,
							creep = "enemy_gnoll_blighter",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_sword_spider",
							cant = 6,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_webspitting_spider",
							cant = 4,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 700,
					name = "T4-Ettin",
					spawns = {
						{
							interval = 85,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 85,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 85,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_ettin",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T4-Ranged",
					spawns = {
						{
							interval = 60,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_gnoll_blighter",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_webspitting_spider",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_webspitting_spider",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 400,
					name = "T4-EttinBurner",
					spawns = {
						{
							interval = 100,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_ettin",
							cant = 4,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = 7,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_gnoll_burner",
							cant = 7,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 800,
					name = "T4-Blighter",
					spawns = {
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_gnoll_blighter",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_gnoll_blighter",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_gnoll_blighter",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T4-RazorEttin",
					spawns = {
						{
							interval = 85,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_ettin",
							cant = 3,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 100,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_razorboar",
							cant = 3,
							cant_increment = 1,
							interval_next = 75,
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
				limit = 4,
				cicle = 1,
				factor = 1.05
			},
			gold = {
				limit = 0.7,
				cicle = 1,
				factor = 0.98
			},
			health = {
				limit = 4,
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
		enemy_ettin = {
			basicCooldownTime = {
				limit = 10,
				cicle = 1,
				factor = 1.2
			},
			gold = {
				factor = 0.99,
				limit = 0.8
			},
			health = {
				limit = 5
			}
		},
		enemy_gnoll_blighter = {
			health = {
				factor = 1.04,
				limit = 4
			},
			magicArmor = {
				factor = 1.008,
				limit_value = 0.95
			},
			rangedDamage = {
				limit = 3,
				cicle = 1,
				factor = 1.05
			}
		},
		enemy_gnoll_burner = {
			health = {
				limit = 5
			},
			rangedDamage = {
				limit = 7,
				cicle = 1,
				factor = 1.1
			}
		},
		enemy_gnoll_gnawer = {
			armor = {
				factor = 1.05,
				limit_value = 0.95
			},
			damage = {
				factor = 1.03,
				limit = 5
			},
			health = {
				factor = 1.05,
				limit = 5
			}
		},
		enemy_gnoll_reaver = {
			health = {
				factor = 1.05,
				limit = 5
			}
		},
		enemy_gnoll_warleader = {
			damage = {
				factor = 1.01,
				limit = 5
			},
			gold = {
				limit = 4,
				cicle = 1,
				factor = 1.035
			},
			health = {
				cicle = 10,
				factor = 1,
				factor_steps = {
					1,
					2.4,
					3.8,
					5.3,
					7.2,
					10.4,
					15.2
				}
			}
		},
		enemy_hyena = {
			health = {
				factor = 1.04,
				limit = 2.5
			}
		},
		enemy_perython = {
			health = {
				factor = 1.02,
				limit = 3
			}
		},
		enemy_razorboar = {
			damage = {
				limit = 5
			},
			gold = {
				limit = 0.8
			},
			health = {
				factor = 1.1
			}
		},
		enemy_spider_arachnomancer = {
			health = {
				factor = 1.08,
				limit = 3
			},
			magicArmor = {
				factor = 1.009,
				limit_value = 0.6
			}
		},
		enemy_sword_spider = {
			damage = {
				factor = 1.04,
				limit = 4
			},
			health = {
				limit = 4
			},
			magicArmor = {
				factor = 1.007,
				limit_value = 0.85
			}
		},
		enemy_webspitting_spider = {
			health = {
				factor = 1.08,
				limit = 5
			},
			magicArmor = {
				factor = 1.004,
				limit_value = 0.95
			}
		},
		plant_magic_blossom = {
			damage = {
				factor = 1.025,
				limit = 3
			}
		}
	},
	inapps = {
		atomicBomb = 1,
		bomb = 10,
		atomicFreeze = 5,
		freeze = 10
	},
	pathConfig = {
		{
			0,
			2
		},
		{
			1,
			3
		},
		{
			4,
			5
		}
	},
	score = {
		scorePerWave = 100,
		scoreNextWaveMultiplier = 1,
		scoreEnemyMultiplier = 0.05
	}
}
