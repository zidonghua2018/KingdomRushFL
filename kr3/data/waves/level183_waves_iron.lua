return {
	cash = 3300,
	groups = {
		{
			interval = 0,
			waves = {
				{
					delay = 300,
					path_index = 1,
					spawns = {
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_djini",
							path = 1,
							interval_next = 3000.0,
							max = 1
						},
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_legion_nomad",
							path = 2,
							interval_next = 45,
							max = 1
						},
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_legion_nomad",
							path = 3,
							interval_next = 45,
							max = 1
						}
					}
				},
				{
					delay = 1500,
					path_index = 2,
					spawns = {
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_djini",
							path = 1,
							interval_next = 0,
							max = 1
						}
					}
				}
			}
		}
	}
}