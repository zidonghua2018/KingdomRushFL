return {
	lives = 1,
	cash = 3500,
	groups = {
        {
			interval = 2000,
			waves = {
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 120,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 3000,
							max = 1
						},

						
						
					},
					
				},
				
			}
		},
		{
			interval = 1600,
			waves = {
				
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 80,
							path = 0,
							fixed_sub_path = 3,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 100,
							max = 1
						},
					
					}
				},
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 50,
							max = 4
						},
						
						
					}
				},
				{
					delay = 0,
					path_index = 6,
					spawns = {
						
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_rider",
							max_same = 0,
							interval_next = 200,
							max = 3
						},
						
					}
				},
				
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
							interval = 480,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_golem",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 40,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_cursed_shard",
							max_same = 0,
							interval_next = 0,
							max = 10
						},
					}
				},
				
				{
					delay = 800,
					path_index = 1,
					spawns = {
						{
							interval = 50,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 0,
							max = 1
						}
					}
				},
				
				{
					delay = 300,
					path_index = 6,
					spawns = {
						{
							interval = 20,
							path = 4,
							fixed_sub_path = 0,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 300,
							max = 6
						},
						{
							interval = 20,
							path = 4,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 300,
							max = 1
						},

						
					}
				},
			}
		},
		--4wave
		{
			interval = 3000,
			waves = {
				{
					delay = 600,
					path_index = 6,
					spawns = {
						{
							interval = 70,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_wolf",
							max_same = 0,
							interval_next = 0,
							max = 14
						},
						
					}
				},
				{
					delay = 600,
					path_index = 3,
					spawns = {
						
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 0,
							max = 5
						},
					}
				},
				
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 800,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 0,
							max = 2
						}
					}
				}, 
				{
					delay = 400,
					path_index = 1,
					spawns = {
						{
							interval = 500,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 50,
							max = 3
						},
						{
							interval = 500,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_shield",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						{
							interval = 50,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_goblin_spear",
							max_same = 0,
							interval_next = 300,
							max = 3
						},
					}
				}, 
				{
					delay = 0,
					path_index = 5,
					spawns = {
						{
							interval = 90,
							path = 2,
							fixed_sub_path = 2,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 400,
							max = 15
						},
							
					}
				},
				
				
				
			}
		},
		{
			interval = 3600,
			waves = {
				{
					delay = 400,
					path_index = 1,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
						
					}
				},
				
				{
					delay = 800,
					path_index = 5,
					spawns = {
						
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 260,
							max = 1
						},
						
					}
				},
				
				
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_goblin",
							max_same = 0,
							interval_next = 200,
							max = 25
						},
						{
							interval = 80,
							path = 1,
							fixed_sub_path = 0,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 0,
							max = 1
						},
					}
				},
				
			}
		},
		{
			interval = 1300,
			waves = {
				{
					delay = 190,
					path_index = 5,
					spawns = {
						{
							interval = 40,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 1600,
							max = 1
						},
						
						{
							interval = 40,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 1600,
							max = 1
						},
						{
							interval = 40,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 100,
							max = 1
						},			
						

					}
				},
				{
					delay = 100,
					path_index = 2,
					spawns = {
						{
							interval = 40,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 1600,
							max = 1
						},
						
						{
							interval = 40,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 1600,
							max = 1
						},
						{
							interval = 40,
							path = 1,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 100,
							max = 1
						},	
						

					}
				},
				{
					delay = 190,
					path_index = 1,
					spawns = {
						{
							interval = 40,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 1600,
							max = 1
						},
						
						{
							interval = 40,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 1600,
							max = 1
						},
						{
							interval = 40,
							path = 3,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_miniboss",
							max_same = 0,
							interval_next = 100,
							max = 1
						},	
						

					}
				},
				{
					delay = 750,
					path_index = 3,
					some_flying = true,
					spawns = {
						{
							interval = 400,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_goblin_balloon",
							max_same = 0,
							interval_next = 50,
							max = 1
						},
						

					}
				},
				{
					delay = 100,
					path_index = 6,
					spawns = {
						{
							interval = 150,
							path = 2,
							fixed_sub_path = 1,
							creep = "enemy_hobgoblin_small",
							max_same = 0,
							interval_next = 750,
							max = 6
						},
						
						

					}
				},
				
			}
		},
		
	}
}