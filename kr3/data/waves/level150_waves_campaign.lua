return {
	cash = 190,
	groups = {
		{
			interval = 800,
			waves = {
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_human_woodcutter",
							path = 1,
							interval_next = 70,
							max = 1
						},
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 0,
							max = 1
						}
					}
				}
			}
		},
		{
			interval = 800,
			waves = {
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 120,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_human_woodcutter",
							path = 1,
							interval_next = 160,
							max = 2
						},
						{
							interval = 80,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 160,
							max = 3
						},
						{
							interval = 50,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 180,
							max = 4
						}
					}
				}
			}
		},
		{
			interval = 900,
			waves = {
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 30,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 160,
							max = 3
						},
						{
							interval = 120,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 30,
							max = 3
						},
						{
							interval = 50,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_worker",
							path = 3,
							interval_next = 30,
							max = 3
						}
					}
				}
			}
		},
		{
			interval = 600,
			waves = {
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 15,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 90,
							max = 4
						},
						{
							interval = 90,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 90,
							max = 8
						},
						{
							interval = 60,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_woodcutter",
							path = 3,
							interval_next = 60,
							max = 3
						},
						{
							interval = 20,
							max_same = 0,
							fixed_sub_path = 0,
							creep = "enemy_human_worker",
							path = 3,
							interval_next = 0,
							max = 5
						}
					}
				}
			}
		}
	}
}