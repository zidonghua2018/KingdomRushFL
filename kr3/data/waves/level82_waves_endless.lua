-- chunkname: @./kr3/data/waves/level82_waves_endless.lua

return {
	interval_less_needed = 0,
	nextWaveRewardMoneyMultiplier = 3.5,
	gold = 1300,
	interval_less_cut = 0,
	lifes = 10,
	waves_to_increment = 10,
	max_paths = 6,
	bossConfig = {
		powerConfig = {
			powerProgressionWaveStart = 11,
			blockTower = {
				durationIncrement = 1,
				duration = 8,
				durationMax = 12
			},
			shield = {
				durationIncrement = 0.2,
				duration = 5,
				durationMax = 8
			},
			teleport = {
				maxNodes = 30,
				nodesRange = 20,
				minNodes = 15,
				minEnemies = 3,
				maxEnemies = 8
			}
		}
	},
	chancesToUseNextDifficulty = {
		0.1,
		0.15,
		0.2,
		0.25,
		0.5
	},
	difficulties = {
		{
			multiple_paths_chance_increment = 2,
			multiple_paths_chance = 0,
			max_paths = 2,
			bossConfig = {
				powerCooldownMin = 15,
				powerChanceIncrement = 0.02,
				powerMultiChance = 0,
				powerCooldownMax = 20,
				powerChance = 0.15,
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
					0.2,
					0.3,
					0.5
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
							creep = "enemy_twilight_brute",
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
					name = "T0-Har",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 85,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T0-HarSco",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_scourger",
							cant = 2,
							cant_increment = 1,
							interval_next = 85,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T0-Sco",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 3,
							cant_increment = 1,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T0-Ser",
					spawns = {
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_blood_servant",
							cant = 2,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_blood_servant",
							cant = 2,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T0-ScoSer",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_twilight_scourger",
							cant = 2,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_blood_servant",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T0-Har",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 85,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T0-Har",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 85,
							path = 0
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 2,
			multiple_paths_chance = 10,
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
					0.2,
					0.5
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
							creep = "enemy_twilight_brute",
							cant = 1,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 140,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 140,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 140,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T1-Har",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 2,
							cant_increment = 1,
							interval_next = 40,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_avenger",
							cant = 1,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 3,
							cant_increment = 1,
							interval_next = 70,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 70,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T1-Har",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_blood_servant",
							cant = 2,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_avenger",
							cant = 1,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 45,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_avenger",
							cant = 3,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 140,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 140,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 140,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 25,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_avenger",
							cant = 1,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 45,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 3,
			multiple_paths_chance = 20,
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
					0.2,
					0.5
				}
			},
			bossWaves = {
				{
					next_wave_interval = 900,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_twilight_brute",
							cant = 1,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 0,
							interval_next = 0,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 900,
					name = "T1-Boss",
					spawns = {
						{
							interval = 100,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_twilight_brute",
							cant = 1,
							cant_increment = 0,
							interval_next = 300,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_scourger",
							cant = 3,
							cant_increment = 1,
							interval_next = 45,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 200,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_scourger",
							cant = 3,
							cant_increment = 1,
							interval_next = 45,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 1,
							cant_increment = 1,
							interval_next = 200,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T1-Har",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_screecher_bat",
							cant = 5,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 110,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_blood_servant",
							cant = 4,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 1,
							cant_increment = 1,
							interval_next = 200,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 1,
							cant_increment = 1,
							interval_next = 200,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T1-Har",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_evoker",
							cant = 1,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 2,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T1-Har",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 2,
							cant_increment = 1,
							interval_next = 45,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 200,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_blood_servant",
							cant = 4,
							cant_increment = 1,
							interval_next = 35,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 450,
					name = "T1-Har",
					spawns = {
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						},
						{
							interval = 30,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 90,
							path = 0
						}
					}
				}
			}
		},
		{
			multiple_paths_chance_increment = 3,
			multiple_paths_chance = 30,
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
					0.2,
					0.5
				}
			},
			bossWaves = {
				{
					next_wave_interval = 900,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_twilight_brute",
							cant = 1,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 900,
					name = "T1-Boss",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_twilight_avenger",
							cant = 3,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 85,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_mounted_avenger",
							cant = 1,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 5,
							cant_increment = 2,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 700,
					name = "T1-Har",
					spawns = {
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_mounted_avenger",
							cant = 2,
							cant_increment = 0,
							interval_next = 250,
							path = 0
						},
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_mounted_avenger",
							cant = 1,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 650,
					name = "T1-Har",
					spawns = {
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_heretic",
							cant = 1,
							cant_increment = 0,
							interval_next = 180,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 650,
					name = "T1-Har",
					spawns = {
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_heretic",
							cant = 1,
							cant_increment = 0,
							interval_next = 180,
							path = 0
						},
						{
							interval = 40,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 3,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_blood_servant",
							cant = 4,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_twilight_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 120,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 2,
							creep = "enemy_twilight_scourger",
							cant = 3,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_blood_servant",
							cant = 4,
							cant_increment = 1,
							interval_next = 160,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_blood_servant",
							cant = 5,
							cant_increment = 1,
							interval_next = 160,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_heretic",
							cant = 1,
							cant_increment = 1,
							interval_next = 160,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 65,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_avenger",
							cant = 3,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 100,
							path = 0
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
					0.2,
					0.5
				}
			},
			bossWaves = {
				{
					next_wave_interval = 900,
					name = "T1-Boss",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_twilight_brute",
							cant = 1,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 900,
					name = "T1-Boss",
					spawns = {
						{
							interval = 100,
							max_same = 0,
							cant_cicle = 1,
							creep = "enemy_twilight_brute",
							cant = 1,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						}
					}
				}
			},
			waves = {
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 2,
							cant_increment = 1,
							interval_next = 180,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 3,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 2,
							cant_increment = 1,
							interval_next = 50,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 650,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_scourger",
							cant = 4,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_screecher_bat",
							cant = 5,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_screecher_bat",
							cant = 6,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_heretic",
							cant = 2,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_scourger",
							cant = 4,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_avenger",
							cant = 3,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_screecher_bat",
							cant = 5,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_twilight_heretic",
							cant = 1,
							cant_increment = 1,
							interval_next = 220,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_avenger",
							cant = 3,
							cant_increment = 1,
							interval_next = 60,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 650,
					name = "T1-Har",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_avenger",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 600,
					name = "T1-Har",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_avenger",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_blood_servant",
							cant = 3,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 35,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_blood_servant",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 550,
					name = "T1-Har",
					spawns = {
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 8,
							creep = "enemy_mounted_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 3,
							creep = "enemy_twilight_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 80,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 100,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 500,
					name = "T1-Har",
					spawns = {
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_mounted_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_screecher_bat",
							cant = 4,
							cant_increment = 1,
							interval_next = 65,
							path = 0
						},
						{
							interval = 75,
							max_same = 0,
							cant_cicle = 6,
							creep = "enemy_mounted_avenger",
							cant = 2,
							cant_increment = 1,
							interval_next = 65,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 650,
					name = "T1-Har",
					spawns = {
						{
							interval = 0,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_golem",
							cant = 1,
							cant_increment = 0,
							interval_next = 150,
							path = 0
						},
						{
							interval = 45,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_elf_harasser",
							cant = 4,
							cant_increment = 1,
							interval_next = 55,
							path = 0
						},
						{
							interval = 50,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_twilight_evoker",
							cant = 2,
							cant_increment = 1,
							interval_next = 55,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 650,
					name = "T1-Har",
					spawns = {
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 5,
							creep = "enemy_blood_servant",
							cant = 4,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						},
						{
							interval = 55,
							max_same = 0,
							cant_cicle = 4,
							creep = "enemy_blood_servant",
							cant = 5,
							cant_increment = 1,
							interval_next = 150,
							path = 0
						}
					}
				},
				{
					next_wave_interval = 750,
					name = "T1-Har",
					spawns = {
						{
							interval = 250,
							cant_cicle = 8,
							creep = "enemy_twilight_golem",
							cant = 1,
							cant_increment = 1,
							interval_next = 150,
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
		enemy_blood_servant = {
			damage = {
				factor = 1.04,
				limit = 3
			},
			gold = {
				factor = 0.98,
				limit = 0.7
			},
			health = {
				factor = 1.05,
				limit = 3
			}
		},
		enemy_mounted_avenger = {
			damage = {
				factor = 1.04,
				limit = 3
			},
			gold = {
				factor = 0.98,
				limit = 0.6
			},
			health = {
				factor = 1.02,
				limit = 1.5
			},
			magicArmor = {
				factor = 1.025,
				limit_value = 0.9
			}
		},
		enemy_screecher_bat = {
			gold = {
				factor = 0.99,
				limit = 0.6
			},
			health = {
				factor = 1.004,
				limit = 1.5
			}
		},
		enemy_twilight_avenger = {
			armor = {
				factor = 1.025,
				limit_value = 0.9
			},
			damage = {
				factor = 1.01,
				limit = 3
			},
			gold = {
				factor = 0.99,
				limit = 0.7
			},
			health = {
				factor = 1.03,
				limit = 3
			}
		},
		enemy_twilight_brute = {
			damage = {
				factor = 1.01,
				limit = 4
			},
			gold = {
				limit = 4,
				cicle = 1,
				factor = 1.035
			},
			health = {
				limit = 4,
				cicle = 10,
				factor = 1,
				factor_steps = {
					1,
					1.5,
					3.8,
					4.5,
					7.2,
					9.6,
					14.4
				}
			}
		},
		enemy_twilight_elf_harasser = {
			armor = {
				factor = 1.04,
				limit_value = 0.8
			},
			damage = {
				factor = 1.04,
				limit = 2.5
			},
			gold = {
				factor = 0.98,
				limit = 0.6
			},
			health = {
				factor = 1.02,
				limit = 3
			}
		},
		enemy_twilight_evoker = {
			damage = {
				factor = 1.03,
				limit = 3
			},
			gold = {
				factor = 0.982,
				limit = 0.6
			},
			health = {
				factor = 1.02,
				limit = 3
			},
			magicArmor = {
				factor = 1.009,
				limit_value = 0.9
			}
		},
		enemy_twilight_golem = {
			armor = {
				factor = 1.009,
				limit_value = 1.2
			},
			damage = {
				factor = 1.03,
				limit = 3
			},
			gold = {
				factor = 0.98,
				limit = 0.6
			},
			health = {
				factor = 1.015,
				limit = 1.5
			}
		},
		enemy_twilight_heretic = {
			damage = {
				factor = 1.04,
				limit = 3
			},
			gold = {
				factor = 0.99,
				limit = 0.7
			},
			health = {
				factor = 1.02,
				limit = 2
			},
			magicArmor = {
				factor = 1.009,
				limit_value = 1.2
			}
		},
		enemy_twilight_scourger = {
			damage = {
				factor = 1.04,
				limit = 2.5
			},
			gold = {
				factor = 0.98,
				limit = 0.6
			},
			health = {
				factor = 1.015,
				limit = 1.8
			},
			magicArmor = {
				factor = 1.008,
				limit_value = 1
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
			3
		},
		{
			0,
			3
		},
		{
			1,
			2
		},
		{
			5
		},
		{
			4
		},
		{
			0
		}
	},
	score = {
		scorePerWave = 100,
		scoreNextWaveMultiplier = 1,
		scoreEnemyMultiplier = 0.05
	}
}
