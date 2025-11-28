-- chunkname: @./kr3-desktop/data/kui_templates/slot_view.lua

return {
	id = "slot_3",
	class = "SlotView",
	pos = {
		x = 503,
		y = 357
	},
	children = {
		{
			id = "slot_used",
			class = "KView",
			children = {
				{
					class = "CSinkButton",
					id = "button_slot",
					default_image_name = "main_menu_slot_normal",
					click_image_name = "main_menu_slot_down",
					down_offset = v(-4, 4),
					children = {
						{
							class = "KView",
							propagate_on_down = true,
							propagate_on_enter = true,
							propagate_on_up = true,
							propagate_on_click = true,
							children = {
								{
									hover_image_name = "main_menu_slot_close_hover",
									class = "KImageButton",
									image_name = "main_menu_slot_close_normal",
									id = "button_slot_delete",
									default_image_name = "main_menu_slot_close_normal",
									click_image_name = "main_menu_slot_close_down",
									pos = {
										x = 159,
										y = 10
									}
								},
								{
									hover_image_name = "main_menu_t_slot_3_hover_en",
									image_name = "main_menu_t_slot_3_normal_en",
									class = "CHoverImage",
									id = "l_slot",
									default_image_name = "main_menu_t_slot_3_normal_en",
									pos = {
										x = 16,
										y = 15
									}
								},
								{
									class = "KView",
									r = 0.06,
									pos = {
										x = 20,
										y = 62
									},
									size = {
										x = 193,
										y = 0
									},
									children = {
										{
											class = "KImageView",
											image_name = "main_menu_icon_star",
											pos = {
												x = 0,
												y = 1
											}
										},
										{
											class = "KImageView",
											image_name = "main_menu_icon_heroic",
											pos = {
												x = 82,
												y = 2
											}
										},
										{
											class = "KImageView",
											image_name = "main_menu_icon_iron",
											pos = {
												x = 130,
												y = 1
											}
										},
										{
											text = "0/110",
											font_size = 12,
											class = "KLabel",
											text_align = "left",
											id = "l_stars",
											font_name = "numbers_italic",
											pos = {
												x = 26,
												y = 6
											},
											size = {
												x = 64,
												y = 27
											}
										},
										{
											text = "0",
											font_size = 12,
											class = "KLabel",
											text_align = "left",
											id = "l_heroic",
											font_name = "numbers_italic",
											pos = {
												x = 108,
												y = 6
											},
											size = {
												x = 64,
												y = 27
											}
										},
										{
											text = "0",
											font_size = 12,
											class = "KLabel",
											text_align = "left",
											id = "l_iron",
											font_name = "numbers_italic",
											pos = {
												x = 154,
												y = 6
											},
											size = {
												x = 64,
												y = 27
											}
										}
									}
								}
							}
						}
					}
				}
			}
		},
		{
			id = "slot_empty",
			class = "KView",
			children = {
				{
					class = "CSinkButton",
					id = "button_slot_new",
					default_image_name = "main_menu_slot_normal",
					click_image_name = "main_menu_slot_down",
					children = {
						{
							class = "KView",
							children = {
								{
									hover_image_name = "main_menu_t_new_game_hover_en",
									image_name = "main_menu_t_new_game_normal_en",
									class = "CHoverImage",
									id = "l_slot_new",
									default_image_name = "main_menu_t_new_game_normal_en",
									pos = {
										x = 24,
										y = 30
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
