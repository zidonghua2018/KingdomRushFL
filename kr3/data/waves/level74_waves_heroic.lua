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
							interval = 10,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 10,
							max = 12
						},
						
					}
				},
				{
					delay = 300,
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
							interval = 50,
							path = 0,
							fixed_sub_path = 0,
							creep = "enemy_wolf",
							max_same = 0,
							interval_next = 100,
							max = 12
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
					path_index = 5,
					spawns = {
						{
							interval = 20,
							path = 0,
							fixed_sub_path = 2,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 100,
							max = 40
						},
					
					}
				},
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 20,
							path = 0,
							fixed_sub_path = 3,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 100,
							max = 40
						},
					
					}
				},
				{
					delay = 100,
					path_index = 7,
					spawns = {
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 200,
							max = 4
						},
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 200,
							max = 4
						},
						
					}
				},
				{
					delay = 0,
					path_index = 8,
					spawns = {
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_wolf_small",
							max_same = 0,
							interval_next = 10,
							max = 8
						},
						

					}
				}
			}
		},
		{
			interval = 1500,
			waves = {
				{
					delay = 70,
					path_index = 2,
					spawns = {
						{
							interval = 80,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 13
						}
					}
				},
				{
					delay = 0,
					path_index = 3,
					spawns = {
						{
							interval = 100,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 300,
							max = 5
						},
						{
							interval = 70,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 90,
							max = 5
						},
						
					}
				},
				{
					delay = 800,
					path_index = 7,
					spawns = {
						{
							interval = 50,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 0,
							max = 1
						}
					}
				},
				{
					delay = 800,
					path_index = 8,
					spawns = {
						{
							interval = 50,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 0,
							max = 1
						}
					}
				},
				{
					delay = 100,
					path_index = 6,
					spawns = {
						{
							interval = 180,
							path = 4,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_rider",
							max_same = 0,
							interval_next = 600,
							max = 1
						},
					}
				},
			}
		},
		--4wave
		{
			interval = 1500,
			waves = {
				{
					delay = 600,
					path_index = 6,
					spawns = {
						{
							interval = 110,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 0,
							max = 5
						}
					}
				},
				
				
				{
					delay = 0,
					path_index = 8,
					spawns = {
						{
							interval = 35,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 2
						}
					}
				}, 
				{
					delay = 200,
					path_index = 7,
					spawns = {
						{
							interval = 35,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_goblin_zapper",
							max_same = 0,
							interval_next = 0,
							max = 6
						}
					}
				}, 
				{
					delay = 0,
					path_index = 3,
					spawns = {
						{
							interval = 80,
							path = 2,
							fixed_sub_path = 2,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 100,
							max = 15
						},
						{
							interval = 80,
							path = 2,
							fixed_sub_path = 2,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 100,
							max = 6
						},				
					}
				},
				{
					delay = 0,				
					path_index = 3,
					some_flying = true,
					spawns = {
						{
							interval = 250,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_gargoyle",
							max_same = 0,
							interval_next = 0,
							max = 6
						}
					}
				},
				{
					delay = 100,
					path_index = 2,
					spawns = {
						{
							interval = 80,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_wolf_small",
							max_same = 0,
							interval_next = 0,
							max = 20
						}
					}
				},
				
				
			}
		},
		{
			interval = 900,
			waves = {
				{
					delay = 50,
					path_index = 3,
					spawns = {
						{
							interval = 90,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_rider",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 180,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 10
						},
						{
							interval = 40,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_wolf",
							max_same = 0,
							interval_next = 50,
							max = 15
						},

					}
				},
				{
					delay = 25,
					path_index = 1,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 10
						},
						
					}
				},
				
				{
					delay = 0,
					path_index = 5,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 60,
							max = 1
						},
						
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin_zapper",
							max_same = 0,
							interval_next = 0,
							max = 12
						},
						{
							interval = 90,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 2
						},
					}
				},
				{
					delay = 0,
					path_index = 6,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_wolf_small",
							max_same = 0,
							interval_next = 0,
							max = 6
						}
					}
				},
				{
					delay = 0,
					path_index = 8,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_wolf_small",
							max_same = 0,
							interval_next = 0,
							max = 4
						}
					}
				},
				{
					delay = 200,
					path_index = 4,
					some_flying = true,
					spawns = {
						{
							interval = 600,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin_balloon",
							max_same = 0,
							interval_next = 0,
							max = 1
						}
					}
				},
				{
					delay = 0,
					path_index = 8,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 0,
							max = 25
						}
					}
				},
				{
					delay = 0,
					path_index = 7,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin",
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
					delay = 270,
					path_index = 5,
					some_flying = true,
					spawns = {
						{
							interval = 550,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin_balloon",
							max_same = 0,
							interval_next = 50,
							max = 6
						},
						

					}
				},
				{
					delay = 50,
					path_index = 2,
					spawns = {
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 50,
							max = 20
						},
						

					}
				},
				{
					delay = 50,
					path_index = 5,
					spawns = {
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 50,
							max = 20
						},
						

					}
				},
				{
					delay = 50,
					path_index = 3,
					spawns = {
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 50,
							max = 5
						},
						
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 50,
							max = 5
						},
						{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 50,
							max = 2
						},{
							interval = 60,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 50,
							max = 5
						},
						
						

					}
				},
				
				{
					delay = 150,
					path_index = 5,
					some_flying = true,
					spawns = {
						{
							interval = 65,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 50,
							max = 60
						},
						

					}
				},
				{
					delay = 150,
					path_index = 5,
					some_flying = true,
					spawns = {
						{
							interval = 300,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shaman",
							max_same = 0,
							interval_next = 50,
							max = 6
						},
						

					}
				},
				{
					delay = 300,
					path_index = 6,
					spawns = {
						{
							interval = 70,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 150,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 400,
							max = 4
						},
						{
							interval = 70,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 2000,
							max = 2
						},
						
					}
				},
				{
					delay = 300,
					path_index = 6,
					spawns = {
						
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 400,
							max = 4
						},
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_wolf",
							max_same = 0,
							interval_next = 1200,
							max = 5
						},
						{
							interval = 30,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 200,
							max = 6
						},
					
					}
				},
				{
					delay = 400,
					path_index = 7,
					spawns = {
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 3
						},
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 600,
							max = 1
						},
						
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 6
						},
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						
					}
				},
				{
					delay = 200,
					path_index = 7,
					spawns = {
						{
							interval = 60,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 100,
							max = 3
						},
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 60,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 1200,
							max = 3
						},
						{
							interval = 60,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_wolf",
							max_same = 0,
							interval_next = 1200,
							max = 12
						},
					}
				},
				{
					delay = 100,
					path_index = 8,
					spawns = {
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 60,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 0,
							max = 3
						},
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 100,
							max = 2
						},
						{
							interval = 100,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 2
						},
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 500,
							max = 2
						},
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_shaman",
							max_same = 0,
							interval_next = 0,
							max = 4
						},
					}
				},
			}
		},
		
	}
}