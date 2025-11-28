-- chunkname: @./kr3-desktop/data/kui_templates/screen_slots.lua

return {
	class = "KWindow",
	id = "99001",
	colors = {
		background = {
			200,
			200,
			200,
			255
		}
	},
	size = {
		x = 1440,
		y = 1080
	},
	children = {
		{
			id = "bg_view",
			class = "KImageView",
			image_name = "main_menu_bg",
			anchor = {
				x = 960,
				y = 540
			},
			pos = {
				x = 720,
				y = 540
			},
			size = {
				x = 1920,
				y = 1080
			},
			children = {
				{
					id = "main_menu_subtitle_cn",
					hidden = true,
					class = "KImageView",
					image_name = "main_menu_subtitle_cn"
				},
				{
					text_key = "LEGAL_ADVICE",
					hidden = true,
					font_size = 20,
					line_height = 0.9,
					class = "GGLabel",
					id = "legal_advice_view",
					font_name = "sans",
					size = {
						x = 960,
						y = 16
					},
					pos = {
						x = 480,
						y = 1020
					},
					colors = {
						text = {
							255,
							255,
							255,
							255
						}
					}
				},
				{
					id = "slot_panel",
					class = "KImageView",
					image_name = "main_menu_slots_bg",
					anchor = {
						x = 0,
						y = 521
					},
					pos = {
						x = 0,
						y = 1100
					},
					size = {
						x = 726,
						y = 521
					},
					children = {
						{
							id = "slot_1",
							class = "SlotView",
							template_name = "slot_view",
							slot_idx = 1,
							pos = {
								x = 427,
								y = 92
							}
						},
						{
							id = "slot_2",
							class = "SlotView",
							template_name = "slot_view",
							slot_idx = 2,
							pos = {
								x = 431,
								y = 191
							}
						},
						{
							id = "slot_3",
							class = "SlotView",
							template_name = "slot_view",
							slot_idx = 3,
							pos = {
								x = 435,
								y = 292
							}
						}
					}
				},
				{
					id = "banner",
					class = "KImageView",
					image_name = "main_menu_banner_bg",
					anchor = {
						x = 0,
						y = 521
					},
					pos = {
						x = 170,
						y = 1100
					},
					size = {
						x = 726,
						y = 521
					},
					children = {
						{
							class = "CSinkButton",
							id = "banner_button_start",
							default_image_name = "main_menu_start_normal",
							click_image_name = "main_menu_start_down",
							pos = {
								x = 160,
								y = 97
							},
							children = {
								{
									hover_image_name = "main_menu_t_start_hover_en",
									default_image_name = "main_menu_t_start_normal_en",
									class = "CHoverImage"
								}
							}
						},
						{
							class = "CSinkButton",
							id = "banner_button_options",
							default_image_name = "main_menu_options_normal",
							click_image_name = "main_menu_options_down",
							pos = {
								x = 174,
								y = 204
							},
							children = {
								{
									hover_image_name = "main_menu_t_options_hover_en",
									default_image_name = "main_menu_t_options_normal_en",
									class = "CHoverImage"
								}
							}
						},
						{
							class = "CSinkButton",
							id = "banner_button_credits",
							default_image_name = "main_menu_credits_normal",
							click_image_name = "main_menu_credits_down",
							pos = {
								x = 202,
								y = 304
							},
							children = {
								{
									hover_image_name = "main_menu_t_credits_hover_en",
									default_image_name = "main_menu_t_credits_normal_en",
									class = "CHoverImage"
								}
							}
						},
						{
							class = "CSinkButton",
							id = "banner_button_quit",
							default_image_name = "main_menu_quit_normal",
							click_image_name = "main_menu_quit_down",
							pos = {
								x = 221,
								y = 383
							},
							children = {
								{
									hover_image_name = "main_menu_t_quit_hover_en",
									default_image_name = "main_menu_t_quit_normal_en",
									class = "CHoverImage"
								}
							}
						}
					}
				},
				{
					class = "PopUpView",
					id = "delete_view",
					colors = {
						background = {
							0,
							0,
							0,
							80
						}
					},
					size = {
						x = 1920,
						y = 1080
					},
					children = {
						{
							id = "99029",
							class = "KImageView",
							image_name = "homeMenu_confirm_menu_0001",
							anchor = {
								x = 360,
								y = 130
							},
							pos = {
								x = 960,
								y = 490
							},
							size = {
								x = 960,
								y = 260
							},
							children = {
								{
									id = "99030",
									font_size = 28.125,
									class = "GGOptionsLabel",
									text_key = "DELETE SLOT?",
									font_name = "h",
									anchor = {
										x = 280,
										y = 15
									},
									pos = {
										x = 360,
										y = 86.666666666667
									},
									size = {
										x = 560,
										y = 30
									}
								},
								{
									id = "delete_button_yes",
									class = "GGOptionsButton",
									label_text_key = "Yes",
									anchor = {
										x = 97,
										y = 0
									},
									pos = {
										x = 250,
										y = 130
									},
									size = {
										x = 194,
										y = 76
									}
								},
								{
									id = "delete_button_no",
									class = "GGOptionsButton",
									label_text_key = "No",
									anchor = {
										x = 97,
										y = 0
									},
									pos = {
										x = 470,
										y = 130
									},
									size = {
										x = 194,
										y = 76
									}
								}
							}
						}
					}
				},
				{
					class = "PopUpView",
					id = "quit_view",
					colors = {
						background = {
							0,
							0,
							0,
							80
						}
					},
					size = {
						x = 1920,
						y = 1080
					},
					children = {
						{
							id = "99036",
							class = "KImageView",
							image_name = "homeMenu_confirm_menu_0001",
							anchor = {
								x = 360,
								y = 130
							},
							pos = {
								x = 960,
								y = 540
							},
							size = {
								x = 960,
								y = 260
							},
							children = {
								{
									id = "99037",
									font_size = 28.125,
									class = "GGOptionsLabel",
									text_key = "ARE YOU SURE YOU WANT TO QUIT?",
									font_name = "h",
									anchor = {
										x = 280,
										y = 15
									},
									pos = {
										x = 360,
										y = 86.666666666667
									},
									size = {
										x = 560,
										y = 30
									}
								},
								{
									id = "quit_button_yes",
									class = "GGOptionsButton",
									label_text_key = "Yes",
									anchor = {
										x = 97,
										y = 0
									},
									pos = {
										x = 250,
										y = 130
									},
									size = {
										x = 194,
										y = 76
									}
								},
								{
									id = "quit_button_no",
									class = "GGOptionsButton",
									label_text_key = "No",
									anchor = {
										x = 97,
										y = 0
									},
									pos = {
										x = 470,
										y = 130
									},
									size = {
										x = 194,
										y = 76
									}
								}
							}
						}
					}
				},
				{
					class = "PopUpView",
					id = "options_view",
					colors = {
						background = {
							0,
							0,
							0,
							80
						}
					},
					size = {
						x = 1920,
						y = 1080
					},
					children = {
						{
							id = "99043",
							class = "KImageView",
							image_name = "main_options_bg_notxt",
							anchor = {
								x = 350,
								y = 185
							},
							pos = {
								x = 960,
								y = 490
							},
							size = {
								x = 700,
								y = 370
							},
							children = {
								{
									vertical_align = "middle-caps",
									text_key = "OPTIONS",
									class = "GGPanelHeader",
									fit_size = true,
									id = "99044",
									pos = {
										x = 232,
										y = 15
									},
									size = {
										x = 242,
										y = 50
									}
								},
								{
									vertical_align = "top",
									text_key = "SFX",
									class = "GGOptionsLabel",
									fit_size = true,
									id = "99045",
									pos = {
										x = 250,
										y = 100
									},
									size = {
										x = 200,
										y = 32
									}
								},
								{
									image_name = "options_barBg",
									style = "sfx",
									class = "VolumeSlider",
									id = "s_sfx",
									pos = {
										x = 139,
										y = 132
									},
									size = {
										x = 422,
										y = 34
									}
								},
								{
									vertical_align = "top",
									text_key = "Music",
									class = "GGOptionsLabel",
									fit_size = true,
									id = "99049",
									pos = {
										x = 250,
										y = 190
									},
									size = {
										x = 200,
										y = 32
									}
								},
								{
									image_name = "options_barBg",
									style = "music",
									class = "VolumeSlider",
									id = "s_music",
									pos = {
										x = 139,
										y = 222
									},
									size = {
										x = 422,
										y = 34
									}
								},
								{
									id = "options_button_done",
									class = "GGOptionsButton",
									label_text_key = "Done",
									anchor = {
										x = 97,
										y = 0
									},
									label_pos = {
										x = 350,
										y = 255
									},
									pos = {
										x = 350,
										y = 273
									},
									size = {
										x = 194,
										y = 76
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
