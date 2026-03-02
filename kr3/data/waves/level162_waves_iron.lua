return {
	cash = 1500.0,
	groups = {
		{
			interval = 800,
			waves = {
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 80,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_footman",
							path = 3,
							interval_next = 200,
							max = 15
						},
						{
							interval = 65,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_footman",
							path = 3,
							interval_next = 200,
							max = 25
						},
						{
							interval = 150,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_guardian_eagle",
							path = 3,
							interval_next = 150,
							max = 10
						},
						{
							interval = 100,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_elite_footman",
							path = 3,
							interval_next = 200,
							max = 10
						}
					}
				},
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 700,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_guardian_eagle",
							path = 3,
							interval_next = 700,
							max = 4
						},
						{
							interval = 90,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_hunting_dog",
							path = 3,
							interval_next = 200,
							max = 20
						},
						{
							interval = 50,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_footman",
							path = 3,
							interval_next = 200,
							max = 20
						}
					}
				},
				{
					delay = 0,
					path_index = 3,
					spawns = {
						{
							interval = 70,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_hunting_dog",
							path = 3,
							interval_next = 200,
							max = 20
						},
						{
							interval = 220,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_banner_bearer",
							path = 3,
							interval_next = 200,
							max = 7
						},
						{
							interval = 150,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_guardian_eagle",
							path = 3,
							interval_next = 150,
							max = 10
						},
						{
							interval = 200,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_banner_bearer",
							path = 3,
							interval_next = 200,
							max = 5
						}
					}
				}
			}
		}
	}
}