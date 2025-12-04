return {
	lives = 1,
	cash = 1000,
	groups = {
        {
			interval = 2000,
			waves = {
				{
					delay = 0,
					path_index = 3,
					spawns = {
						{
							interval = 120,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 100,
							max = 5
						},
						{
							interval = 25,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 10,
							max = 3
						},
						
					}
				},
				{
					delay = 60,
					path_index = 2,
					some_flying = true,
					spawns = {
						{
							interval = 20,
							path = 0,
							fixed_sub_path = 0,
							creep = "enemy_gargoyle",
							max_same = 0,
							interval_next = 100,
							max = 15
						},
						
					}
				}
			}
		},
		{
			interval = 1000,
			waves = {
				{
					delay = 0,
					path_index = 4,
					spawns = {
						{
							interval = 0,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 100,
							max = 1
						},
						{
							interval = 170,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 2
						},
					}
				},
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 30,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 0,
							max = 15
						}
					}
				},
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 60,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_wolf",
							max_same = 0,
							interval_next = 0,
							max = 12
						},
						{
							interval = 60,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 0,
							max = 10
						},

					}
				}
			}
		},
		{
			interval = 1600,
			waves = {
				{
					delay = 70,
					path_index = 2,
					spawns = {
						{
							interval = 90,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin_zapper",
							max_same = 0,
							interval_next = 0,
							max = 13
						}
					}
				},
				{
					delay = 70,
					path_index = 3,
					spawns = {
						{
							interval = 100,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 10,
							max = 3
						},
						{
							interval = 200,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 10,
							max = 1
						},
						{
							interval = 70,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 90,
							max = 3
						},
						{
							interval = 100,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 2
						},
					}
				},
				{
					delay = 230,
					path_index = 1,
					spawns = {
						{
							interval = 50,
							path = 4,
							fixed_sub_path = 0,
							creep = "enemy_wolf_small",
							max_same = 0,
							interval_next = 0,
							max = 20
						},
					}
				},
				{
					delay = 0,
					path_index = 4,
					spawns = {
						{
							interval = 180,
							path = 4,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 4
						}
					}
				},
			}
		},
		--4wave
		{
			interval = 2000,
			waves = {
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 110,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_goblin_zapper",
							max_same = 0,
							interval_next = 0,
							max = 10
						}
					}
				},
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 35,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 0,
							max = 30
						}
					}
				}, 
				{
					delay = 0,
					path_index = 3,
					spawns = {
						{
							interval = 300,
							path = 2,
							fixed_sub_path = 2,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 100,
							max = 1
						},
						{
							interval = 100,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 70,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 3
						},
						{
							interval = 190,
							path = 2,
							fixed_sub_path = 3,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 0,
							max = 1
						},

					}
				},
				{
					delay = 100,
					path_index = 2,
					spawns = {
						{
							interval = 160,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_rider",
							max_same = 0,
							interval_next = 0,
							max = 8
						}
					}
				},
				
				
			}
		},
		{
			interval = 2500,
			waves = {
				{
					delay = 50,
					path_index = 3,
					spawns = {
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 50,
							max = 1
						},
						{
							interval = 180,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 50,
							max = 15
						},
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 50,
							max = 1
						},

					}
				},
				{
					delay = 25,
					path_index = 1,
					spawns = {
						{
							interval = 350,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 0,
							max = 5
						},
						{
							interval = 70,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_rider",
							max_same = 0,
							interval_next = 0,
							max = 2
						},
					}
				},
				{
					delay = 0,
					path_index = 2,
					some_flying = true,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_gargoyle",
							max_same = 0,
							interval_next = 0,
							max = 25
						}
					}
				},
				
			}
		},
		{
			interval = 1200,
			waves = {
				{
					delay = 50,
					path_index = 2,
					spawns = {
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 200,
							max = 1
						},
						{
							interval = 260,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 100,
							max = 1
						},
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 50,
							max = 4
						},

					}
				},
				{
					delay = 25,
					path_index = 1,
					spawns = {
						{
							interval = 70,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_rider",
							max_same = 0,
							interval_next = 0,
							max = 4
						},
						{
							interval = 150,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 100,
							max = 4
						},
						{
							interval = 110,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_rider",
							max_same = 0,
							interval_next = 0,
							max = 4
						},
					}
				},
				{
					delay = 0,
					path_index = 4,
					spawns = {
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 400,
							max = 6
						},
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 10
						},
					}
				},
				{
					delay = 0,
					path_index = 3,
					spawns = {
						{
							interval = 400,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 0,
							max = 3
						},
					}
				},
			}
		},
		
	}
}