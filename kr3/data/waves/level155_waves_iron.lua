return {
	cash = 750,
	groups = {
		{
			interval = 0,
			waves = {
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 160,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_warhammer_guard",
							path = 3,
							interval_next = 320,
							max = 10
						},
						{
							interval = 110,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_warhammer_guard",
							path = 3,
							interval_next = 300,
							max = 10
						},
						{
							interval = 45,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_bruiser",
							path = 3,
							interval_next = 2600.0,
							max = 60
						},
						{
							interval = 100,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_quarry_worker",
							path = 3,
							interval_next = 300,
							max = 40
						}
					}
				},
				{
					delay = 160,
					path_index = 2,
					spawns = {
						{
							interval = 300,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_sulfur_alchemist",
							path = 3,
							interval_next = 640,
							max = 5
						},
						{
							interval = 220,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_sulfur_alchemist",
							path = 3,
							interval_next = 700,
							max = 5
						},
						{
							interval = 450,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_tinbeard_gunman",
							path = 3,
							interval_next = 6000.0,
							max = 10
						},
						{
							interval = 550,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_smokebeard_engineer",
							path = 3,
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
							interval = 120,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_cyclopter_pilot",
							path = 2,
							interval_next = 1000.0,
							max = 30
						},
						{
							interval = 400,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_tinbeard_gunman",
							path = 2,
							interval_next = 1200.0,
							max = 10
						},
						{
							interval = 280,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_sulfur_alchemist",
							path = 2,
							interval_next = 1150.0,
							max = 10
						},
						{
							interval = 600,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_smokebeard_engineer",
							path = 2,
							interval_next = 0,
							max = 6
						}
					}
				},
				{
					delay = 2000,
					path_index = 4,
					spawns = {
						{
							interval = 120,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_warhammer_guard",
							path = 3,
							interval_next = 300,
							max = 10
						},
						{
							interval = 40,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_bruiser",
							path = 3,
							interval_next = 4800,
							max = 60
						},
						{
							interval = 60,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_warhammer_guard",
							path = 3,
							interval_next = 300,
							max = 40
						}
					}
				}
			}
		}
	}
}