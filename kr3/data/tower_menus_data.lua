-- chunkname: @./kr3/data/tower_menus_data.lua

return {
	holder = {
		{
			page = 0,
			pages = {
				{
					-- 3代
					
						{
							check = "main_icons_0019",
							action_arg = "tower_build_archer",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "main_icons_0100",
							place = 1,
							preview = "archer",
							tt_title = _("TOWER_ARCHER_1_NAME"),
							tt_desc = _("TOWER_ARCHER_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "tower_build_barrack",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "main_icons_0101",
							place = 2,
							preview = "barrack",
							tt_title = _("TOWER_BARRACK_1_NAME"),
							tt_desc = _("TOWER_BARRACK_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "tower_build_mage",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "main_icons_0102",
							place = 3,
							preview = "mage",
							tt_title = _("TOWER_MAGE_1_NAME"),
							tt_desc = _("TOWER_MAGE_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "tower_build_rock_thrower",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "main_icons_0103",
							place = 4,
							preview = "rock_thrower",
							tt_title = _("TOWER_ROCK_THROWER_1_NAME"),
							tt_desc = _("TOWER_ROCK_THROWER_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g2_tower_build_archer",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g2_main_icons_0001",
							place = 11,--1,
							preview = "g2_archer",
							tt_title = _("G2_TOWER_ARCHER_1_NAME"),
							tt_desc = _("G2_TOWER_ARCHER_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g2_tower_build_barrack",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g2_main_icons_0002",
							place = 5,--2,
							preview = "g2_barrack",
							tt_title = _("G2_TOWER_BARRACK_1_NAME"),
							tt_desc = _("G2_TOWER_BARRACK_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g2_tower_build_mage",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g2_main_icons_0003",
							place = 9,--3,
							preview = "g2_mage",
							tt_title = _("G2_TOWER_MAGE_1_NAME"),
							tt_desc = _("G2_TOWER_MAGE_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g2_tower_build_engineer",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g2_main_icons_0004",
							place = 12,--4,
							preview = "g2_engineer",
							tt_title = _("G2_TOWER_ENGINEER_1_NAME"),
							tt_desc = _("G2_TOWER_ENGINEER_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g1_tower_build_mage",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g1_main_icons_0003",
							place = 15,
							preview = "g2_mage",
							tt_title = _("G2_TOWER_MAGE_1_NAME"),
							tt_desc = _("G2_TOWER_MAGE_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g1_tower_build_engineer",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g1_main_icons_0004",
							place = 21,
							preview = "g2_engineer",
							tt_title = _("G2_TOWER_ENGINEER_1_NAME"),
							tt_desc = _("G2_TOWER_ENGINEER_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g1_tower_build_archer",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g1_main_icons_0001",
							place = 13,--1,
							preview = "g2_archer",
							tt_title = _("G2_TOWER_ARCHER_1_NAME"),
							tt_desc = _("G2_TOWER_ARCHER_1_DESCRIPTION")
						},
						{
							check = "main_icons_0019",
							action_arg = "g1_tower_build_barrack",
							action = "tw_upgrade",
							halo = "glow_ico_main",
							image = "g1_main_icons_0002",
							place = 19,--2,
							preview = "g2_barrack",
							tt_title = _("G2_TOWER_BARRACK_1_NAME"),
							tt_desc = _("G2_TOWER_BARRACK_1_DESCRIPTION")
						},	
				},
				-- 5代
				{
					{
						check = "kra_main_icons_0019",
						halo = "glow_ico_main",
						action_arg = "tower_build_hermit_toad",
						type = "hermit_toad",
						action = "tw_upgrade",
						image = "kra_main_icons_0034",
						preview = "hermit_toad",
						tt_title = _("TOWER_HERMIT_TOAD_1_NAME"),
						tt_desc = _("TOWER_HERMIT_TOAD_1_DESCRIPTION"),
						place = 1,
					},
					{
						check = "kra_main_icons_0019",
						halo = "glow_ico_main",
						action_arg = "tower_build_ray",
						type = "ray",
						action = "tw_upgrade",
						image = "kra_main_icons_0018",
						preview = "ray",
						tt_title = _("TOWER_RAY_1_NAME"),
						tt_desc = _("TOWER_RAY_1_DESCRIPTION"),
						place = 2,
					},
					{
						check = "kra_main_icons_0019",
						halo = "glow_ico_main",
						action_arg = "tower_build_tricannon",
						type = "tricannon",
						action = "tw_upgrade",
						image = "kra_main_icons_0004",
						preview = "tricannon",
						tt_title = _("TOWER_TRICANNON_1_NAME"),
						tt_desc = _("TOWER_TRICANNON_1_DESCRIPTION"),
						place = 3,
					},
					{
						check = "kra_main_icons_0019",
						halo = "glow_ico_main",
						action_arg = "tower_build_demon_pit",
						type = "demon_pit",
						action = "tw_upgrade",
						image = "kra_main_icons_0007",
						preview = "demon_pit",
						tt_title = _("TOWER_DEMON_PIT_1_NAME"),
						tt_desc = _("TOWER_DEMON_PIT_1_DESCRIPTION"),
						place = 4,
					},
					{
						check = "kra_main_icons_0019",
						halo = "glow_ico_main",
						action_arg = "tower_build_ballista",
						type = "ballista",
						action = "tw_upgrade",
						image = "kra_main_icons_0010",
						preview = "ballista",
						tt_title = _("TOWER_BALLISTA_1_NAME"),
						tt_desc = _("TOWER_BALLISTA_1_DESCRIPTION"),
						place = 5,
					},
				}

			}
		}
	},
	twilight_elves_barrack = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_twilight_elves_barrack_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL2_NAME"),
				tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_twilight_elves_barrack_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL3_NAME"),
				tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_twilight_elves_barrack_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_NAME"),
				tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "backstab",
				action = "upgrade_power",
				image = "towerselect_powers_0048",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"elves_barrack_backstab_upgrade"
				},
				tt_phrase = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_BACKSTAB_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_BACKSTAB_NAME_1"),
						tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_BACKSTAB_NAME_2"),
						tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_SMALL_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "arrow_storm",
				action = "upgrade_power",
				image = "towerselect_powers_0047",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"elves_barrack_multishoot_upgrade"
				},
				tt_phrase = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_ARROW_STORM_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_ARROW_STORM_NAME_1"),
						tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_ARROW_STORM_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_ARROW_STORM_NAME_2"),
						tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_ARROW_STORM_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_ARROW_STORM_NAME_3"),
						tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_ARROW_STORM_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "last_breath",
				action = "upgrade_power",
				image = "towerselect_powers_0049",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"elves_barrack_afterlife_upgrade"
				},
				tt_phrase = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_LAST_BREATH_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_LAST_BREATH_NAME_1"),
						tt_desc = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL4_LAST_BREATH_SMALL_DESCRIPTION_1")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	swamp_monster = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_swamp_monster_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SWAMP_MONSTER_LEVEL2_NAME"),
				tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_swamp_monster_0002",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_swamp_monster_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SWAMP_MONSTER_LEVEL3_NAME"),
				tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_swamp_monster_0002",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_swamp_monster_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_NAME"),
				tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_swamp_monster_0002",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_swamp_monster_0002",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
			{
				check = "special_icons_0020",
				action_arg = "instakill",
				action = "upgrade_power",
				image = "towerselect_powers_0057",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"SwampMonsterSkillATaunt"
				},
				tt_phrase = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_TITLE_1"),
						tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_TITLE_2"),
						tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_TITLE_3"),
						tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "stun",
				action = "upgrade_power",
				image = "towerselect_powers_0056",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"SwampMonsterSkillBTaunt"
				},
				tt_phrase = _("TOWER_SWAMP_MONSTER_LEVEL4_BLINDING_LIQUID_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_BLINDING_LIQUID_TITLE_1"),
						tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_BLINDING_LIQUID_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_BLINDING_LIQUID_TITLE_2"),
						tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_BLINDING_LIQUID_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_BLINDING_LIQUID_TITLE_3"),
						tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_BLINDING_LIQUID_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "eat",
				action = "upgrade_power",
				image = "towerselect_powers_0058",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"SwampMonsterSkillCTaunt"
				},
				tt_phrase = _("TOWER_SWAMP_MONSTER_LEVEL4_CARNIVORE_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_SWAMP_MONSTER_LEVEL4_CARNIVORE_TITLE_1"),
						tt_desc = _("TOWER_SWAMP_MONSTER_LEVEL4_CARNIVORE_DESCRIPTION_1")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	wicked_sisters = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_wicked_sisters_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WICKED_SISTERS_LEVEL2_NAME"),
				tt_desc = _("TOWER_WICKED_SISTERS_LEVEL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_0402",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_wicked_sisters_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WICKED_SISTERS_LEVEL3_NAME"),
				tt_desc = _("TOWER_WICKED_SISTERS_LEVEL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_0402",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_wicked_sisters_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WICKED_SISTERS_LEVEL4_NAME"),
				tt_desc = _("TOWER_WICKED_SISTERS_LEVEL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_0402",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "frog",
				action = "upgrade_power",
				image = "towerselect_powers_0045",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"WickedSistersSkillATaunt"
				},
				tt_phrase = _("TOWER_SWAMP_MONSTER_LEVEL4_SMASH_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WICKED_SISTERS_LEVEL4_FROGGIFICATION_TITLE_1"),
						tt_desc = _("TOWER_WICKED_SISTERS_LEVEL4_FROGGIFICATION_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WICKED_SISTERS_LEVEL4_FROGGIFICATION_TITLE_2"),
						tt_desc = _("TOWER_WICKED_SISTERS_LEVEL4_FROGGIFICATION_DESCRIPTION_2")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "silent",
				action = "upgrade_power",
				image = "towerselect_powers_0044",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"WickedSistersSkillBTaunt"
				},
				tt_phrase = _("TOWER_WICKED_SISTERS_LEVEL4_TOTEM_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WICKED_SISTERS_LEVEL4_TOTEM_TITLE_1"),
						tt_desc = _("TOWER_WICKED_SISTERS_LEVEL4_TOTEM_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "range",
				action = "upgrade_power",
				image = "towerselect_powers_0046",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"WickedSistersSkillCTaunt"
				},
				tt_phrase = _("TOWER_WICKED_SISTERS_LEVEL4_NIMBUS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WICKED_SISTERS_LEVEL4_NIMBUS_TITLE_1"),
						tt_desc = _("TOWER_WICKED_SISTERS_LEVEL4_NIMBUS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WICKED_SISTERS_LEVEL4_NIMBUS_TITLE_2"),
						tt_desc = _("TOWER_WICKED_SISTERS_LEVEL4_NIMBUS_DESCRIPTION_2")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = nil,--"quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quick_icons_select_power_0402",
				place = 3,
				halo = nil,--"quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			},
		}
	},
	grim_cemetery = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_grim_cemetery_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL2_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_grim_cemetery_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL3_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_grim_cemetery_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "hands",
				action = "upgrade_power",
				image = "towerselect_powers_0030",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"GrimCemeteryHandsTaunt"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_COLD_GRIP_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_COLD_GRIP_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_COLD_GRIP_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_COLD_GRIP_TITLE_2"),
						tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_COLD_GRIP_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "big",
				action = "upgrade_power",
				image = "towerselect_powers_0029",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"GrimCemeteryBigTaunt"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BETTER_ZOMBIES_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BETTER_ZOMBIES_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BETTER_ZOMBIES_DESCRIPTION_1")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "pestilence",
				action = "upgrade_power",
				image = "towerselect_powers_0031",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"GrimCemeteryPestilenceTaunt"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BLOATED_ZOMBIES_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BLOATED_ZOMBIES_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BLOATED_ZOMBIES_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BLOATED_ZOMBIES_TITLE_2"),
						tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_LEVEL4_BLOATED_ZOMBIES_DESCRIPTION_2")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
	},
	balloon = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_balloon_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL2_NAME"),
				tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_balloon_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL3_NAME"),
				tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_balloon_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL4_NAME"),
				tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "oil",
				action = "upgrade_power",
				image = "towerselect_powers_0038",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"BalloonSkillATaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_BALLOON_LEVEL4_SPLASH_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL4_SPLASH_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL4_SPLASH_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL4_SPLASH_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL4_SPLASH_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL4_SPLASH_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL4_SPLASH_DESCRIPTION_3")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "watcher",
				action = "upgrade_power",
				image = "towerselect_powers_0040",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"BalloonSkillBTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_BALLOON_LEVEL4_AURA_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL4_AURA_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL4_AURA_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "bomber",
				action = "upgrade_power",
				image = "towerselect_powers_0039",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"BalloonSkillCTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_BALLOON_LEVEL4_PARACHUTE_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_BALLOON_LEVEL4_PARACHUTE_TITLE_1_NAME"),
						tt_desc = _("TOWER_WARMONGER_BALLOON_LEVEL4_PARACHUTE_DESCRIPTION_1")
					},
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		}
	},
	dark_knights = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_dark_knights_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL2_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_dark_knights_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL3_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_dark_knights_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "instakill",
				action = "upgrade_power",
				image = "towerselect_powers_0015",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"DarkKnightsInstakillTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_MERCILESS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_MERCILESS_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_MERCILESS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_MERCILESS_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_MERCILESS_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_MERCILESS_TITLE_3"),
						tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_MERCILESS_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "spike",
				action = "upgrade_power",
				image = "towerselect_powers_0016",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"DarkKnightsSpikeTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_ARMOR_OF_BRUTALITY_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_ARMOR_OF_BRUTALITY_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_ARMOR_OF_BRUTALITY_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_ARMOR_OF_BRUTALITY_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_ARMOR_OF_BRUTALITY_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_ARMOR_OF_BRUTALITY_TITLE_3"),
						tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_ARMOR_OF_BRUTALITY_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "shield",
				action = "upgrade_power",
				image = "towerselect_powers_0014",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"DarkKnightsShield"
				},
				tt_phrase = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_IMPERVIOUS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_IMPERVIOUS_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_BARRACK_LEVEL4_IMPERVIOUS_DESCRIPTION_1")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	orc_warriors_den = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_orc_warriors_den_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL2_NAME"),
				tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_orc_warriors_den_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL3_NAME"),
				tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_orc_warriors_den_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_NAME"),
				tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "bloodlust",
				action = "upgrade_power",
				image = "towerselect_powers_0005",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"Orc_WarmongersBloodlust"
				},
				tt_phrase = _("TOWER_WARMONGER_BARRACK_LEVEL4_BATTLEWITS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_BATTLEWITS_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_BATTLEWITS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_BATTLEWITS_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_BATTLEWITS_DESCRIPTION_2")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "promotion",
				action = "upgrade_power",
				image = "towerselect_powers_0006",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"Orc_WarmongersPromotion"
				},
				tt_phrase = _("TOWER_WARMONGER_BARRACK_LEVEL4_PROMOTION_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_PROMOTION_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_PROMOTION_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "seal",
				action = "upgrade_power",
				image = "towerselect_powers_0007",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"Orc_WarmongersSeal"
				},
				tt_phrase = _("TOWER_WARMONGER_BARRACK_LEVEL4_SEAL_OF_BLOOD_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_SEAL_OF_BLOOD_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_SEAL_OF_BLOOD_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_SEAL_OF_BLOOD_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_SEAL_OF_BLOOD_DESCRIPTION_2")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	deep_devils = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_deep_devils_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DEEP_DEVILS_LEVEL2_NAME"),
				tt_desc = _("TOWER_DEEP_DEVILS_LEVEL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_deep_devils_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DEEP_DEVILS_LEVEL3_NAME"),
				tt_desc = _("TOWER_DEEP_DEVILS_LEVEL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_deep_devils_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DEEP_DEVILS_LEVEL4_NAME"),
				tt_desc = _("TOWER_DEEP_DEVILS_LEVEL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "amph",
				action = "upgrade_power",
				image = "towerselect_powers_0052",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"DeepDevilAmphTaunt"
				},
				tt_phrase = _("TOWER_DEEP_DEVILS_LEVEL4_CHOSEN_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DEEP_DEVILS_LEVEL4_CHOSEN_TITLE_1"),
						tt_desc = _("TOWER_DEEP_DEVILS_LEVEL4_CHOSEN_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "net",
				action = "upgrade_power",
				image = "towerselect_powers_0051",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"DeepDevilNetTaunt"
				},
				tt_phrase = _("TOWER_DEEP_DEVILS_LEVEL4_TENTANGLES_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DEEP_DEVILS_LEVEL4_TENTANGLES_TITLE_1"),
						tt_desc = _("TOWER_DEEP_DEVILS_LEVEL4_TENTANGLES_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DEEP_DEVILS_LEVEL4_TENTANGLES_TITLE_2"),
						tt_desc = _("TOWER_DEEP_DEVILS_LEVEL4_TENTANGLES_DESCRIPTION_2")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "storm",
				action = "upgrade_power",
				image = "towerselect_powers_0050",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"DeepDevilStormTaunt"
				},
				tt_phrase = _("TOWER_DEEP_DEVILS_LEVEL4_STORM_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DEEP_DEVILS_LEVEL4_STORM_TITLE_1"),
						tt_desc = _("TOWER_DEEP_DEVILS_LEVEL4_STORM_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DEEP_DEVILS_LEVEL4_STORM_TITLE_2"),
						tt_desc = _("TOWER_DEEP_DEVILS_LEVEL4_STORM_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_DEEP_DEVILS_LEVEL4_STORM_TITLE_3"),
						tt_desc = _("TOWER_DEEP_DEVILS_LEVEL4_STORM_DESCRIPTION_3")
					},
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	}, 
	sandworm = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_sandworm_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TREMOR_LEVEL2_NAME"),
				tt_desc = _("TOWER_TREMOR_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_sandworm_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TREMOR_LEVEL3_NAME"),
				tt_desc = _("TOWER_TREMOR_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_sandworm_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TREMOR_LEVEL4_NAME"),
				tt_desc = _("TOWER_TREMOR_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "worm",
				action = "upgrade_power",
				image = "towerselect_powers_0062",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"sandwormSkillATaunt"
				},
				tt_phrase = _("TOWER_TREMOR_LEVEL4_TREMORS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_TREMOR_LEVEL4_TREMORS_TITLE_1"),
						tt_desc = _("TOWER_TREMOR_LEVEL4_TREMORS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_TREMOR_LEVEL4_TREMORS_TITLE_2"),
						tt_desc = _("TOWER_TREMOR_LEVEL4_TREMORS_DESCRIPTION_2")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "eat",
				action = "upgrade_power",
				image = "towerselect_powers_0063",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"sandwormSkillBTaunt"
				},
				tt_phrase = _("TOWER_TREMOR_LEVEL4_SAND_WORM_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_TREMOR_LEVEL4_SAND_WORM_TITLE_1"),
						tt_desc = _("TOWER_TREMOR_LEVEL4_SAND_WORM_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "slime",
				action = "upgrade_power",
				image = "towerselect_powers_0064",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"sandwormSkillCTaunt"
				},
				tt_phrase = _("TOWER_TREMOR_LEVEL4_SPITS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_TREMOR_LEVEL4_SPITS_TITLE_1"),
						tt_desc = _("TOWER_TREMOR_LEVEL4_SPITS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_TREMOR_LEVEL4_SPITS_TITLE_2"),
						tt_desc = _("TOWER_TREMOR_LEVEL4_SPITS_DESCRIPTION_2")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	blazing_watcher = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_blazing_watcher_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL2_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_blazing_watcher_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL3_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_blazing_watcher_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "charging",
				action = "upgrade_power",
				image = "towerselect_powers_0035",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"blazing_watcher_charging_upgrade"
				},
				tt_phrase = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_LIMIT_REMOVAL_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_LIMIT_REMOVAL_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_LIMIT_REMOVAL_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "disintegrate",
				action = "upgrade_power",
				image = "towerselect_powers_0037",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"blazing_watcher_disintegrate_upgrade"
				},
				tt_phrase = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_CHARGED_BLAST_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_CHARGED_BLAST_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_CHARGED_BLAST_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_CHARGED_BLAST_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_CHARGED_BLAST_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_CHARGED_BLAST_TITLE_3"),
						tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_CHARGED_BLAST_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "explosion",
				action = "upgrade_power",
				image = "towerselect_powers_0036",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"blazing_watcher_explosive_upgrade"
				},
				tt_phrase = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_INNER_VOLATILITY_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_INNER_VOLATILITY_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_INNER_VOLATILITY_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_INNER_VOLATILITY_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_LEVEL4_INNER_VOLATILITY_DESCRIPTION_2")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	orc_shaman = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_orc_shaman_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_MAGE_LEVEL2_NAME"),
				tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_orc_shaman_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_MAGE_LEVEL3_NAME"),
				tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_orc_shaman_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_NAME"),
				tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "vines",
				action = "upgrade_power",
				image = "towerselect_powers_0026",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"OrcShamanVinesTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_MAGE_LEVEL4_HEALING_ROOTS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_HEALING_ROOTS_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_HEALING_ROOTS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_HEALING_ROOTS_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_HEALING_ROOTS_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_HEALING_ROOTS_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_HEALING_ROOTS_DESCRIPTION_3")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "meteor",
				action = "upgrade_power",
				image = "towerselect_powers_0027",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"OrcShamanMeteorTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_MAGE_LEVEL4_METEORITES_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_METEORITES_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_METEORITES_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_METEORITES_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_METEORITES_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_METEORITES_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_METEORITES_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "shock",
				action = "upgrade_power",
				image = "towerselect_powers_0028",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"OrcShamanShockTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_MAGE_LEVEL4_ELECTROSHOCK_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_ELECTROSHOCK_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_ELECTROSHOCK_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_ELECTROSHOCK_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_ELECTROSHOCK_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_MAGE_LEVEL4_ELECTROSHOCK_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_MAGE_LEVEL4_ELECTROSHOCK_DESCRIPTION_3")
					},
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	rocket_riders = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_rocket_riders_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL2_NAME"),
				tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_rocket_riders_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL3_NAME"),
				tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_rocket_riders_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL4_NAME"),
				tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "mine",
				action = "upgrade_power",
				image = "towerselect_powers_0013",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"RocketRidersMineTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_ROCKET_LEVEL4_MINEFIELD_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL4_MINEFIELD_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL4_MINEFIELD_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL4_MINEFIELD_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL4_MINEFIELD_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL4_MINEFIELD_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL4_MINEFIELD_DESCRIPTION_3")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "nitro",
				action = "upgrade_power",
				image = "towerselect_powers_0012",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"RocketRidersNitroTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_ROCKET_LEVEL4_NITRO_BOOSTERS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL4_NITRO_BOOSTERS_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL4_NITRO_BOOSTERS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_ROCKET_LEVEL4_NITRO_BOOSTERS_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_ROCKET_LEVEL4_NITRO_BOOSTERS_DESCRIPTION_2")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "engine",
				action = "upgrade_power",
				image = "towerselect_powers_0011",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"RocketRidersEngineTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_BARRACK_LEVEL4_DEFECTIVE_ENGINES_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_DEFECTIVE_ENGINES_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_DEFECTIVE_ENGINES_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_BARRACK_LEVEL4_DEFECTIVE_ENGINES_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_BARRACK_LEVEL4_DEFECTIVE_ENGINES_DESCRIPTION_2")
					},
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	infernal_mage = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_infernal_mage_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL2_NAME"),
				tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_infernal_mage_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL3_NAME"),
				tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_infernal_mage_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_NAME"),
				tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "curse",
				action = "upgrade_power",
				image = "towerselect_powers_0009",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"InfernalMageCurseTaunt"
				},
				tt_phrase = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_AFFLICTION_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_AFFLICTION_TITLE_1"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_AFFLICTION_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_AFFLICTION_TITLE_2"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_AFFLICTION_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "fissure",
				action = "upgrade_power",
				image = "towerselect_powers_0008",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"InfernalMageFissureTaunt"
				},
				tt_phrase = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_OVERCHARGE_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_OVERCHARGE_TITLE_1"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_OVERCHARGE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_OVERCHARGE_TITLE_2"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_OVERCHARGE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_OVERCHARGE_TITLE_3"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_OVERCHARGE_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "teleport",
				action = "upgrade_power",
				image = "towerselect_powers_0010",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"InfernalMageTeleportTaunt"
				},
				tt_phrase = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_INFERNAL_PORTAL_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_INFERNAL_PORTAL_TITLE_1"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_INFERNAL_PORTAL_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_INFERNAL_PORTAL_TITLE_2"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_INFERNAL_PORTAL_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_INFERNAL_PORTAL_TITLE_3"),
						tt_desc = _("TOWER_EMBER_LORDS_MAGE_LEVEL4_INFERNAL_PORTAL_DESCRIPTION_3")
					},
					
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	shadow_archer = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_shadow_archer_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL2_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_shadow_archer_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL3_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_shadow_archer_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "mark",
				action = "upgrade_power",
				image = "towerselect_powers_0003",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ShadowArcherMarkTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_SHADOW_MARK_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_SHADOW_MARK_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_SHADOW_MARK_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_SHADOW_MARK_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_SHADOW_MARK_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_SHADOW_MARK_TITLE_3"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_SHADOW_MARK_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "blade",
				action = "upgrade_power",
				image = "towerselect_powers_0002",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ShadowArcherBladeTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_BACKSTAB_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_BACKSTAB_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_BACKSTAB_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_BACKSTAB_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_BACKSTAB_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_BACKSTAB_TITLE_3"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_BACKSTAB_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "crow",
				action = "upgrade_power",
				image = "towerselect_powers_0004",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ShadowArcherCrowTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_CROWS_NEST_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_CROWS_NEST_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_CROWS_NEST_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_CROWS_NEST_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_ARCHER_LEVEL4_CROWS_NEST_DESCRIPTION_2")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	rotten_forest = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_rotten_forest_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROTTEN_FOREST_LEVEL2_NAME"),
				tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_rotten_forest_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROTTEN_FOREST_LEVEL3_NAME"),
				tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_rotten_forest_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROTTEN_FOREST_LEVEL4_NAME"),
				tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "tree",
				action = "upgrade_power",
				image = "towerselect_powers_0043",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"RottenForestSkillATaunt"
				},
				tt_phrase = _("TOWER_ROTTEN_FOREST_LEVEL4_SPAWN_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_ROTTEN_FOREST_LEVEL4_SPAWN_TITLE_1"),
						tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL4_SPAWN_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ROTTEN_FOREST_LEVEL4_SPAWN_TITLE_2"),
						tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL4_SPAWN_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "warp",
				action = "upgrade_power",
				image = "towerselect_powers_0041",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"RottenForestSkillBTaunt"
				},
				tt_phrase = _("TOWER_ROTTEN_FOREST_LEVEL4_STUN_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_ROTTEN_FOREST_LEVEL4_STUN_TITLE_1"),
						tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL4_STUN_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ROTTEN_FOREST_LEVEL4_STUN_TITLE_2"),
						tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL4_STUN_DESCRIPTION_2")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "fog",
				action = "upgrade_power",
				image = "towerselect_powers_0042",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"RottenForestSkillCTaunt"
				},
				tt_phrase = _("TOWER_ROTTEN_FOREST_LEVEL4_FOG_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_ROTTEN_FOREST_LEVEL4_FOG_TITLE_1"),
						tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL4_FOG_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ROTTEN_FOREST_LEVEL4_FOG_TITLE_2"),
						tt_desc = _("TOWER_ROTTEN_FOREST_LEVEL4_FOG_DESCRIPTION_2")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	ogre_shipwreck = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ogre_shipwreck_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_OGRES_BARRACK_LEVEL2_NAME"),
				tt_desc = _("TOWER_OGRES_BARRACK_LEVEL2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ogre_shipwreck_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_OGRES_BARRACK_LEVEL3_NAME"),
				tt_desc = _("TOWER_OGRES_BARRACK_LEVEL3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ogre_shipwreck_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_OGRES_BARRACK_LEVEL4_NAME"),
				tt_desc = _("TOWER_OGRES_BARRACK_LEVEL4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "enhance",
				action = "upgrade_power",
				image = "towerselect_powers_0065",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"OgreShipwreckSkillATaunt"
				},
				tt_phrase = _("TOWER_OGRES_BARRACK_LEVEL4_BETTER_CREW_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_OGRES_LEVEL4_BETTER_CREWS_TITLE_1"),
						tt_desc = _("TOWER_OGRES_BARRACK_LEVEL4_BETTER_CREW_DESCRIPTION_1")
					},

				}
			},
			{
				check = "special_icons_0020",
				action_arg = "multishoot",
				action = "upgrade_power",
				image = "towerselect_powers_0066",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"OgreShipwreckSkillBTaunt"
				},
				tt_phrase = _("TOWER_OGRES_BARRACK_LEVEL4_MUSKET_RAGE_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_OGRES_BARRACK_LEVEL4_MUSKET_RAGE_TITLE_1"),
						tt_desc = _("TOWER_OGRES_BARRACK_LEVEL4_MUSKET_RAGE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_OGRES_BARRACK_LEVEL4_MUSKET_RAGE_TITLE_2"),
						tt_desc = _("TOWER_OGRES_BARRACK_LEVEL4_MUSKET_RAGE_DESCRIPTION_2")
					},

				}
			},
			{
				check = "special_icons_0020",
				action_arg = "goblin",
				action = "upgrade_power",
				image = "towerselect_powers_0067",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"OgreShipwreckSkillCTaunt"
				},
				tt_phrase = _("TOWER_OGRES_BARRACK_LEVEL4_GOBLIN_LAUNCHER_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_OGRES_BARRACK_LEVEL4_GOBLIN_LAUNCHER_TITLE_1"),
						tt_desc = _("TOWER_OGRES_BARRACK_LEVEL4_GOBLIN_LAUNCHER_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_OGRES_BARRACK_LEVEL4_GOBLIN_LAUNCHER_TITLE_2"),
						tt_desc = _("TOWER_OGRES_BARRACK_LEVEL4_GOBLIN_LAUNCHER_DESCRIPTION_2")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	spirit_mausoleum = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_spirit_mausoleum_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL2_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_spirit_mausoleum_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL3_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_spirit_mausoleum_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "gargoyles",
				action = "upgrade_power",
				image = "towerselect_powers_0021",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"fallen_ones_spirit_mausoleum_gargoyles_upgrade"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_GARGOYLES_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_GARGOYLES_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_GARGOYLES_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_GARGOYLES_TITLE_2"),
						tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_GARGOYLES_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "spectral_communion",
				action = "upgrade_power",
				image = "towerselect_powers_0022",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"fallen_ones_spirit_mausoleum_communion_upgrade"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_SPECTRAL_COMMUNION_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_SPECTRAL_COMMUNION_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_SPECTRAL_COMMUNION_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_SPECTRAL_COMMUNION_TITLE_2"),
						tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_SPECTRAL_COMMUNION_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "possession",
				action = "upgrade_power",
				image = "towerselect_powers_0020",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"fallen_ones_spirit_mausoleum_possesion_upgrade"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_POSSESSION_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_POSSESSION_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_POSSESSION_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_POSSESSION_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_POSSESSION_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_POSSESSION_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_LEVEL4_POSSESSION_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	goblirang = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_goblirang_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL2_NAME"),
				tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_goblirang_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL3_NAME"),
				tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_goblirang_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_NAME"),
				tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "big",
				action = "upgrade_power",
				image = "towerselect_powers_0025",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"GoblirangsBigTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_ARCHER_LEVEL4_RICOCHET_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_RICOCHET_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_RICOCHET_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_RICOCHET_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_RICOCHET_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_RICOCHET_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_RICOCHET_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "stun",
				action = "upgrade_power",
				image = "towerselect_powers_0024",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"GoblirangsStunTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_ARCHER_LEVEL4_HEADBANG_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_HEADBANG_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_HEADBANG_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_HEADBANG_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_HEADBANG_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_HEADBANG_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_HEADBANG_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "bees",
				action = "upgrade_power",
				image = "towerselect_powers_0023",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"GoblirangsBeesTaunt"
				},
				tt_phrase = _("TOWER_WARMONGER_ARCHER_LEVEL4_ANGRY_BEES_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_ANGRY_BEES_TITLE_1"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_ANGRY_BEES_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_ANGRY_BEES_TITLE_2"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_ANGRY_BEES_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_WARMONGER_ARCHER_LEVEL4_ANGRY_BEES_TITLE_3"),
						tt_desc = _("TOWER_WARMONGER_ARCHER_LEVEL4_ANGRY_BEES_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	melting_furnace = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_melting_furnace_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL2_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_melting_furnace_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL3_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_melting_furnace_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_NAME"),
				tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "coal",
				action = "upgrade_power",
				image = "towerselect_powers_0018",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"MeltingFurnaceHotCoalTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_FISSURE_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_FISSURE_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_FISSURE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_FISSURE_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_FISSURE_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "heat",
				action = "upgrade_power",
				image = "towerselect_powers_0019",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"MeltingFurnaceAbrasiveHeatTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_ABRASIVE_HEAT_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_ABRASIVE_HEAT_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_ABRASIVE_HEAT_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_ABRASIVE_HEAT_TITLE_2"),
						tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_ABRASIVE_HEAT_DESCRIPTION_2")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "fuel",
				action = "upgrade_power",
				image = "towerselect_powers_0017",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"MeltingFurnaceBurningFuelTaunt"
				},
				tt_phrase = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_BURNING_FUEL_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_BURNING_FUEL_TITLE_1"),
						tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_LEVEL4_BURNING_FUEL_DESCRIPTION_1")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	ignis_altar = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ignis_altar_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL2_NAME"),
				tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ignis_altar_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL3_NAME"),
				tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ignis_altar_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_NAME"),
				tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "golemstone",
				action = "upgrade_power",
				image = "towerselect_powers_0059",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ignis_altar_golemstone_upgrade"
				},
				tt_phrase = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_BURNING_ELEMENTAL_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_BURNING_ELEMENTAL_TITLE_1"),
						tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_BURNING_ELEMENTAL_DESCRIPTION")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "firewheel",
				action = "upgrade_power",
				image = "towerselect_powers_0061",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ignis_altar_firewheel_upgrade"
				},
				tt_phrase = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_SINGLE_EXTINCTION_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_SINGLE_EXTINCTION_TITLE_1"),
						tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_SINGLE_EXTINCTION_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_SINGLE_EXTINCTION_TITLE_2"),
						tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_SINGLE_EXTINCTION_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_SINGLE_EXTINCTION_TITLE_3"),
						tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_SINGLE_EXTINCTION_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "stickylava",
				action = "upgrade_power",
				image = "towerselect_powers_0060",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ignis_altar_stickylava_upgrade"
				},
				tt_phrase = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_TRUE_FIRE_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_TRUE_FIRE_TITLE_1"),
						tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_LEVEL4_TRUE_FIRE_DESCRIPTION_1")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	bone_flingers = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_bone_flingers_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL2_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_bone_flingers_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL3_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_bone_flingers_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_NAME"),
				tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "skeleton",
				action = "upgrade_power",
				image = "towerselect_powers_0033",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"BoneFlingersSkeletonTaunt"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_WALKING_ARMY_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_WALKING_ARMY_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_WALKING_ARMY_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_WALKING_ARMY_TITLE_2"),
						tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_WALKING_ARMY_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "milk",
				action = "upgrade_power",
				image = "towerselect_powers_0034",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"BoneFlingersMilkTaunt"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_GOT_MILK_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_GOT_MILK_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_GOT_MILK_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_GOT_MILK_TITLE_2"),
						tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_GOT_MILK_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_GOT_MILK_TITLE_3"),
						tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_GOT_MILK_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "golem",
				action = "upgrade_power",
				image = "towerselect_powers_0032",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"BoneFlingersGolemTaunt"
				},
				tt_phrase = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_BONE_GOLEM_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_BONE_GOLEM_TITLE_1"),
						tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_LEVEL4_BONE_GOLEM_DESCRIPTION_1")
					},

				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	shaolin = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_shaolin_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL2_NAME"),
				tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_shaolin_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL3_NAME"),
				tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_shaolin_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_NAME"),
				tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "lion",
				action = "upgrade_power",
				image = "towerselect_powers_0053",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ShaolinSkillBTaunt"
				},
				tt_phrase = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_LION_OF_ABUNDANCE_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_LION_OF_ABUNDANCE_TITLE_1"),
						tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_LION_OF_ABUNDANCE_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "dragon",
				action = "upgrade_power",
				image = "towerselect_powers_0054",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ShaolinSkillATaunt"
				},
				tt_phrase = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_DRAGON_WARRIOR_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_DRAGON_WARRIOR_TITLE_1"),
						tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_DRAGON_WARRIOR_DESCRIPTION_1")
					},
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "total",
				action = "upgrade_power",
				image = "towerselect_powers_0055",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ShaolinSkillCTaunt"
				},
				tt_phrase = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_SHAOLIN_MONKS_BOTTOM_TEXT"),
				tt_list = {
					{
						tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_SHAOLIN_MONKS_TITLE_1"),
						tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_SHAOLIN_MONKS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_SHAOLIN_MONKS_TITLE_2"),
						tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_SHAOLIN_MONKS_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_SHAOLIN_MONKS_TITLE_3"),
						tt_desc = _("TOWER_SHAOLIN_TEMPLE_LEVEL4_SHAOLIN_MONKS_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
		
	},
	royal_archers = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_royal_archers_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROYAL_ARCHERS_2_NAME"),
				tt_desc = _("TOWER_ROYAL_ARCHERS_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_royal_archers_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROYAL_ARCHERS_3_NAME"),
				tt_desc = _("TOWER_ROYAL_ARCHERS_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_royal_archers_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROYAL_ARCHERS_4_NAME"),
				tt_desc = _("TOWER_ROYAL_ARCHERS_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "armor_piercer",
				action = "upgrade_power",
				image = "kra_special_icons_0003",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerRoyalArchersSkillATaunt"
				},
				tt_phrase = _("TOWER_ROYAL_ARCHERS_4_ARMOR_PIERCER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ROYAL_ARCHERS_4_ARMOR_PIERCER_1_NAME"),
						tt_desc = _("TOWER_ROYAL_ARCHERS_4_ARMOR_PIERCER_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROYAL_ARCHERS_4_ARMOR_PIERCER_2_NAME"),
						tt_desc = _("TOWER_ROYAL_ARCHERS_4_ARMOR_PIERCER_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROYAL_ARCHERS_4_ARMOR_PIERCER_3_NAME"),
						tt_desc = _("TOWER_ROYAL_ARCHERS_4_ARMOR_PIERCER_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "rapacious_hunter",
				action = "upgrade_power",
				image = "kra_special_icons_0004",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerRoyalArchersSkillBTaunt"
				},
				tt_phrase = _("TOWER_ROYAL_ARCHERS_4_RAPACIOUS_HUNTER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ROYAL_ARCHERS_4_RAPACIOUS_HUNTER_1_NAME"),
						tt_desc = _("TOWER_ROYAL_ARCHERS_4_RAPACIOUS_HUNTER_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROYAL_ARCHERS_4_RAPACIOUS_HUNTER_2_NAME"),
						tt_desc = _("TOWER_ROYAL_ARCHERS_4_RAPACIOUS_HUNTER_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROYAL_ARCHERS_4_RAPACIOUS_HUNTER_3_NAME"),
						tt_desc = _("TOWER_ROYAL_ARCHERS_4_RAPACIOUS_HUNTER_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	paladin_covenant = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_paladin_covenant_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_PALADIN_COVENANT_2_NAME"),
				tt_desc = _("TOWER_PALADIN_COVENANT_2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_paladin_covenant_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_PALADIN_COVENANT_3_NAME"),
				tt_desc = _("TOWER_PALADIN_COVENANT_3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_paladin_covenant_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_PALADIN_COVENANT_4_NAME"),
				tt_desc = _("TOWER_PALADIN_COVENANT_4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "lead",
				action = "upgrade_power",
				image = "kra_special_icons_0002",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerPaladinCovenantSkillATaunt"
				},
				tt_phrase = _("TOWER_PALADIN_COVENANT_4_LEAD_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_PALADIN_COVENANT_4_LEAD_1_NAME"),
						tt_desc = _("TOWER_PALADIN_COVENANT_4_LEAD_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_PALADIN_COVENANT_4_LEAD_2_NAME"),
						tt_desc = _("TOWER_PALADIN_COVENANT_4_LEAD_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_PALADIN_COVENANT_4_LEAD_3_NAME"),
						tt_desc = _("TOWER_PALADIN_COVENANT_4_LEAD_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "healing_prayer",
				action = "upgrade_power",
				image = "kra_special_icons_0001",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerPaladinCovenantSkillBTaunt"
				},
				tt_phrase = _("TOWER_PALADIN_COVENANT_4_HEALING_PRAYER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_PALADIN_COVENANT_4_HEALING_PRAYER_1_NAME"),
						tt_desc = _("TOWER_PALADIN_COVENANT_4_HEALING_PRAYER_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_PALADIN_COVENANT_4_HEALING_PRAYER_2_NAME"),
						tt_desc = _("TOWER_PALADIN_COVENANT_4_HEALING_PRAYER_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_PALADIN_COVENANT_4_HEALING_PRAYER_3_NAME"),
						tt_desc = _("TOWER_PALADIN_COVENANT_4_HEALING_PRAYER_3_DESCRIPTION")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	arcane_wizard5 = {
	--arcane_wizard = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_arcane_wizard_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARCANE_WIZARD_2_NAME"),
				tt_desc = _("TOWER_ARCANE_WIZARD_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_arcane_wizard_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARCANE_WIZARD_3_NAME"),
				tt_desc = _("TOWER_ARCANE_WIZARD_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_arcane_wizard_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARCANE_WIZARD_4_NAME"),
				tt_desc = _("TOWER_ARCANE_WIZARD_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "disintegrate",
				action = "upgrade_power",
				image = "kra_special_icons_0005",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerArcaneWizardSkillATaunt"
				},
				tt_phrase = _("TOWER_ARCANE_WIZARD_4_DISINTEGRATE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCANE_WIZARD_4_DISINTEGRATE_1_NAME"),
						tt_desc = _("TOWER_ARCANE_WIZARD_4_DISINTEGRATE_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_4_DISINTEGRATE_2_NAME"),
						tt_desc = _("TOWER_ARCANE_WIZARD_4_DISINTEGRATE_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_4_DISINTEGRATE_3_NAME"),
						tt_desc = _("TOWER_ARCANE_WIZARD_4_DISINTEGRATE_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "empowerment",
				action = "upgrade_power",
				image = "kra_special_icons_0006",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerArcaneWizardSkillBTaunt"
				},
				tt_phrase = _("TOWER_ARCANE_WIZARD_4_EMPOWERMENT_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCANE_WIZARD_4_EMPOWERMENT_1_NAME"),
						tt_desc = _("TOWER_ARCANE_WIZARD_4_EMPOWERMENT_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_4_EMPOWERMENT_2_NAME"),
						tt_desc = _("TOWER_ARCANE_WIZARD_4_EMPOWERMENT_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_4_EMPOWERMENT_3_NAME"),
						tt_desc = _("TOWER_ARCANE_WIZARD_4_EMPOWERMENT_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	tricannon = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_tricannon_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TRICANNON_2_NAME"),
				tt_desc = _("TOWER_TRICANNON_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_tricannon_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TRICANNON_3_NAME"),
				tt_desc = _("TOWER_TRICANNON_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_tricannon_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_TRICANNON_4_NAME"),
				tt_desc = _("TOWER_TRICANNON_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "bombardment",
				action = "upgrade_power",
				image = "kra_special_icons_0007",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerTricannonSkillATaunt"
				},
				tt_phrase = _("TOWER_TRICANNON_4_BOMBARDMENT_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TRICANNON_4_BOMBARDMENT_1_NAME"),
						tt_desc = _("TOWER_TRICANNON_4_BOMBARDMENT_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_TRICANNON_4_BOMBARDMENT_2_NAME"),
						tt_desc = _("TOWER_TRICANNON_4_BOMBARDMENT_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_TRICANNON_4_BOMBARDMENT_3_NAME"),
						tt_desc = _("TOWER_TRICANNON_4_BOMBARDMENT_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "overheat",
				action = "upgrade_power",
				image = "kra_special_icons_0008",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerTricannonSkillBTaunt"
				},
				tt_phrase = _("TOWER_TRICANNON_4_OVERHEAT_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TRICANNON_4_OVERHEAT_1_NAME"),
						tt_desc = _("TOWER_TRICANNON_4_OVERHEAT_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_TRICANNON_4_OVERHEAT_2_NAME"),
						tt_desc = _("TOWER_TRICANNON_4_OVERHEAT_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_TRICANNON_4_OVERHEAT_3_NAME"),
						tt_desc = _("TOWER_TRICANNON_4_OVERHEAT_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	ballista = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ballista_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BALLISTA_2_NAME"),
				tt_desc = _("TOWER_BALLISTA_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ballista_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BALLISTA_3_NAME"),
				tt_desc = _("TOWER_BALLISTA_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ballista_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BALLISTA_4_NAME"),
				tt_desc = _("TOWER_BALLISTA_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_final_shot",
				action = "upgrade_power",
				image = "kra_special_icons_0019",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerBallistaSkillATaunt"
				},
				tt_phrase = _("TOWER_BALLISTA_4_SKILL_FINAL_SHOT_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BALLISTA_4_SKILL_FINAL_SHOT_1_NAME"),
						tt_desc = _("TOWER_BALLISTA_4_SKILL_FINAL_SHOT_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BALLISTA_4_SKILL_FINAL_SHOT_2_NAME"),
						tt_desc = _("TOWER_BALLISTA_4_SKILL_FINAL_SHOT_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BALLISTA_4_SKILL_FINAL_SHOT_3_NAME"),
						tt_desc = _("TOWER_BALLISTA_4_SKILL_FINAL_SHOT_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_bomb",
				action = "upgrade_power",
				image = "kra_special_icons_0021",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerBallistaSkillBTaunt"
				},
				tt_phrase = _("TOWER_BALLISTA_4_SKILL_BOMB_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BALLISTA_4_SKILL_BOMB_1_NAME"),
						tt_desc = _("TOWER_BALLISTA_4_SKILL_BOMB_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BALLISTA_4_SKILL_BOMB_2_NAME"),
						tt_desc = _("TOWER_BALLISTA_4_SKILL_BOMB_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BALLISTA_4_SKILL_BOMB_3_NAME"),
						tt_desc = _("TOWER_BALLISTA_4_SKILL_BOMB_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	arborean_emissary = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_arborean_emissary_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARBOREAN_EMISSARY_2_NAME"),
				tt_desc = _("TOWER_ARBOREAN_EMISSARY_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_arborean_emissary_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARBOREAN_EMISSARY_3_NAME"),
				tt_desc = _("TOWER_ARBOREAN_EMISSARY_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_arborean_emissary_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARBOREAN_EMISSARY_4_NAME"),
				tt_desc = _("TOWER_ARBOREAN_EMISSARY_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "gift_of_nature",
				action = "upgrade_power",
				image = "kra_special_icons_0010",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerArboreanEmissarySkillATaunt"
				},
				tt_phrase = _("TOWER_ARBOREAN_EMISSARY_4_GIFT_OF_NATURE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARBOREAN_EMISSARY_4_GIFT_OF_NATURE_1_NAME"),
						tt_desc = _("TOWER_ARBOREAN_EMISSARY_4_GIFT_OF_NATURE_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARBOREAN_EMISSARY_4_GIFT_OF_NATURE_2_NAME"),
						tt_desc = _("TOWER_ARBOREAN_EMISSARY_4_GIFT_OF_NATURE_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARBOREAN_EMISSARY_4_GIFT_OF_NATURE_3_NAME"),
						tt_desc = _("TOWER_ARBOREAN_EMISSARY_4_GIFT_OF_NATURE_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "wave_of_roots",
				action = "upgrade_power",
				image = "kra_special_icons_0009",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerArboreanEmissarySkillBTaunt"
				},
				tt_phrase = _("TOWER_ARBOREAN_EMISSARY_4_WAVE_OF_ROOTS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARBOREAN_EMISSARY_4_WAVE_OF_ROOTS_1_NAME"),
						tt_desc = _("TOWER_ARBOREAN_EMISSARY_4_WAVE_OF_ROOTS_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARBOREAN_EMISSARY_4_WAVE_OF_ROOTS_2_NAME"),
						tt_desc = _("TOWER_ARBOREAN_EMISSARY_4_WAVE_OF_ROOTS_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ARBOREAN_EMISSARY_4_WAVE_OF_ROOTS_3_NAME"),
						tt_desc = _("TOWER_ARBOREAN_EMISSARY_4_WAVE_OF_ROOTS_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	barrel = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_barrel_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARREL_2_NAME"),
				tt_desc = _("TOWER_BARREL_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_barrel_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARREL_3_NAME"),
				tt_desc = _("TOWER_BARREL_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_barrel_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARREL_4_NAME"),
				tt_desc = _("TOWER_BARREL_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_warrior",
				action = "upgrade_power",
				image = "kra_special_icons_0026",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerBarrelSkillATaunt"
				},
				tt_phrase = _("TOWER_BARREL_4_SKILL_WARRIOR_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BARREL_4_SKILL_WARRIOR_1_NAME"),
						tt_desc = _("TOWER_BARREL_4_SKILL_WARRIOR_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BARREL_4_SKILL_WARRIOR_2_NAME"),
						tt_desc = _("TOWER_BARREL_4_SKILL_WARRIOR_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BARREL_4_SKILL_WARRIOR_3_NAME"),
						tt_desc = _("TOWER_BARREL_4_SKILL_WARRIOR_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_barrel",
				action = "upgrade_power",
				image = "kra_special_icons_0027",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerBarrelSkillBTaunt"
				},
				tt_phrase = _("TOWER_BARREL_4_SKILL_BARREL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BARREL_4_SKILL_BARREL_1_NAME"),
						tt_desc = _("TOWER_BARREL_4_SKILL_BARREL_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BARREL_4_SKILL_BARREL_2_NAME"),
						tt_desc = _("TOWER_BARREL_4_SKILL_BARREL_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_BARREL_4_SKILL_BARREL_3_NAME"),
						tt_desc = _("TOWER_BARREL_4_SKILL_BARREL_3_DESCRIPTION")
					}
				}
			},
			{
				dynamic_rally = true,
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	demon_pit = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_demon_pit_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DEMON_PIT_2_NAME"),
				tt_desc = _("TOWER_DEMON_PIT_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_demon_pit_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DEMON_PIT_3_NAME"),
				tt_desc = _("TOWER_DEMON_PIT_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_demon_pit_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DEMON_PIT_4_NAME"),
				tt_desc = _("TOWER_DEMON_PIT_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "master_exploders",
				action = "upgrade_power",
				image = "kra_special_icons_0011",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerDemonPitSkillATaunt"
				},
				tt_phrase = _("TOWER_DEMON_PIT_4_MASTER_EXPLODERS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DEMON_PIT_4_MASTER_EXPLODERS_1_NAME"),
						tt_desc = _("TOWER_DEMON_PIT_4_MASTER_EXPLODERS_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DEMON_PIT_4_MASTER_EXPLODERS_2_NAME"),
						tt_desc = _("TOWER_DEMON_PIT_4_MASTER_EXPLODERS_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DEMON_PIT_4_MASTER_EXPLODERS_3_NAME"),
						tt_desc = _("TOWER_DEMON_PIT_4_MASTER_EXPLODERS_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "big_guy",
				action = "upgrade_power",
				image = "kra_special_icons_0012",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerDemonPitSkillBTaunt"
				},
				tt_phrase = _("TOWER_DEMON_PIT_4_BIG_DEMON_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DEMON_PIT_4_BIG_DEMON_1_NAME"),
						tt_desc = _("TOWER_DEMON_PIT_4_BIG_DEMON_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DEMON_PIT_4_BIG_DEMON_2_NAME"),
						tt_desc = _("TOWER_DEMON_PIT_4_BIG_DEMON_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DEMON_PIT_4_BIG_DEMON_3_NAME"),
						tt_desc = _("TOWER_DEMON_PIT_4_BIG_DEMON_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	necromancer5 = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_necromancer_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NECROMANCER_2_NAME"),
				tt_desc = _("TOWER_NECROMANCER_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_necromancer_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NECROMANCER_3_NAME"),
				tt_desc = _("TOWER_NECROMANCER_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_necromancer_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NECROMANCER_4_NAME"),
				tt_desc = _("TOWER_NECROMANCER_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_debuff",
				action = "upgrade_power",
				image = "kra_special_icons_0017",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerNecromancerSkillATaunt"
				},
				tt_phrase = _("TOWER_NECROMANCER_4_SKILL_DEBUFF_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_NECROMANCER_4_SKILL_DEBUFF_1_NAME"),
						tt_desc = _("TOWER_NECROMANCER_4_SKILL_DEBUFF_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_NECROMANCER_4_SKILL_DEBUFF_2_NAME"),
						tt_desc = _("TOWER_NECROMANCER_4_SKILL_DEBUFF_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_NECROMANCER_4_SKILL_DEBUFF_3_NAME"),
						tt_desc = _("TOWER_NECROMANCER_4_SKILL_DEBUFF_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_rider",
				action = "upgrade_power",
				image = "kra_special_icons_0018",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerNecromancerSkillBTaunt"
				},
				tt_phrase = _("TOWER_NECROMANCER_4_SKILL_RIDER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_NECROMANCER_4_SKILL_RIDER_1_NAME"),
						tt_desc = _("TOWER_NECROMANCER_4_SKILL_RIDER_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_NECROMANCER_4_SKILL_RIDER_2_NAME"),
						tt_desc = _("TOWER_NECROMANCER_4_SKILL_RIDER_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_NECROMANCER_4_SKILL_RIDER_3_NAME"),
						tt_desc = _("TOWER_NECROMANCER_4_SKILL_RIDER_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	elven_stargazers = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_elven_stargazers_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_STARGAZER_2_NAME"),
				tt_desc = _("TOWER_STARGAZER_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_elven_stargazers_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_STARGAZER_3_NAME"),
				tt_desc = _("TOWER_STARGAZER_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_elven_stargazers_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_STARGAZER_4_NAME"),
				tt_desc = _("TOWER_STARGAZER_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "teleport",
				action = "upgrade_power",
				image = "kra_special_icons_0013",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerElvenStargazersSkillATaunt"
				},
				tt_phrase = _("TOWER_STARGAZER_4_EVENT_HORIZON_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_STARGAZER_4_EVENT_HORIZON_1_NAME"),
						tt_desc = _("TOWER_STARGAZER_4_EVENT_HORIZON_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_STARGAZER_4_EVENT_HORIZON_2_NAME"),
						tt_desc = _("TOWER_STARGAZER_4_EVENT_HORIZON_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_STARGAZER_4_EVENT_HORIZON_3_NAME"),
						tt_desc = _("TOWER_STARGAZER_4_EVENT_HORIZON_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "stars_death",
				action = "upgrade_power",
				image = "kra_special_icons_0014",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerElvenStargazersSkillBTaunt"
				},
				tt_phrase = _("TOWER_STARGAZER_4_RISING_STAR_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_STARGAZER_4_RISING_STAR_1_NAME"),
						tt_desc = _("TOWER_STARGAZER_4_RISING_STAR_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_STARGAZER_4_RISING_STAR_2_NAME"),
						tt_desc = _("TOWER_STARGAZER_4_RISING_STAR_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_STARGAZER_4_RISING_STAR_3_NAME"),
						tt_desc = _("TOWER_STARGAZER_4_RISING_STAR_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	flamespitter = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_flamespitter_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FLAMESPITTER_2_NAME"),
				tt_desc = _("TOWER_FLAMESPITTER_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_flamespitter_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FLAMESPITTER_3_NAME"),
				tt_desc = _("TOWER_FLAMESPITTER_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_flamespitter_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_FLAMESPITTER_4_NAME"),
				tt_desc = _("TOWER_FLAMESPITTER_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_bomb",
				action = "upgrade_power",
				image = "kra_special_icons_0022",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerFlamespitterSkillATaunt"
				},
				tt_phrase = _("TOWER_FLAMESPITTER_4_SKILL_BOMB_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_FLAMESPITTER_4_SKILL_BOMB_1_NAME"),
						tt_desc = _("TOWER_FLAMESPITTER_4_SKILL_BOMB_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_FLAMESPITTER_4_SKILL_BOMB_2_NAME"),
						tt_desc = _("TOWER_FLAMESPITTER_4_SKILL_BOMB_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_FLAMESPITTER_4_SKILL_BOMB_3_NAME"),
						tt_desc = _("TOWER_FLAMESPITTER_4_SKILL_BOMB_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_columns",
				action = "upgrade_power",
				image = "kra_special_icons_0023",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerFlamespitterSkillBTaunt"
				},
				tt_phrase = _("TOWER_FLAMESPITTER_4_SKILL_COLUMNS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_FLAMESPITTER_4_SKILL_COLUMNS_1_NAME"),
						tt_desc = _("TOWER_FLAMESPITTER_4_SKILL_COLUMNS_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_FLAMESPITTER_4_SKILL_COLUMNS_2_NAME"),
						tt_desc = _("TOWER_FLAMESPITTER_4_SKILL_COLUMNS_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_FLAMESPITTER_4_SKILL_COLUMNS_3_NAME"),
						tt_desc = _("TOWER_FLAMESPITTER_4_SKILL_COLUMNS_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	sand = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_sand_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SAND_2_NAME"),
				tt_desc = _("TOWER_SAND_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_sand_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SAND_3_NAME"),
				tt_desc = _("TOWER_SAND_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_sand_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SAND_4_NAME"),
				tt_desc = _("TOWER_SAND_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_gold",
				action = "upgrade_power",
				image = "kra_special_icons_0028",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerSandSkillATaunt"
				},
				tt_phrase = _("TOWER_SAND_4_SKILL_GOLD_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_SAND_4_SKILL_GOLD_1_NAME"),
						tt_desc = _("TOWER_SAND_4_SKILL_GOLD_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SAND_4_SKILL_GOLD_2_NAME"),
						tt_desc = _("TOWER_SAND_4_SKILL_GOLD_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SAND_4_SKILL_GOLD_3_NAME"),
						tt_desc = _("TOWER_SAND_4_SKILL_GOLD_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_big_blade",
				action = "upgrade_power",
				image = "kra_special_icons_0029",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerSandSkillBTaunt"
				},
				tt_phrase = _("TOWER_SAND_4_SKILL_BIG_BLADE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_SAND_4_SKILL_BIG_BLADE_1_NAME"),
						tt_desc = _("TOWER_SAND_4_SKILL_BIG_BLADE_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SAND_4_SKILL_BIG_BLADE_2_NAME"),
						tt_desc = _("TOWER_SAND_4_SKILL_BIG_BLADE_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SAND_4_SKILL_BIG_BLADE_3_NAME"),
						tt_desc = _("TOWER_SAND_4_SKILL_BIG_BLADE_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	rocket_gunners = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_rocket_gunners_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROCKET_GUNNERS_2_NAME"),
				tt_desc = _("TOWER_ROCKET_GUNNERS_2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0002",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
				tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE"),
				sounds = {
					"TowerRocketGunnersLiftoffTaunt",
					"TowerRocketGunnersTouchdownTaunt"
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_rocket_gunners_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROCKET_GUNNERS_3_NAME"),
				tt_desc = _("TOWER_ROCKET_GUNNERS_3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0002",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
				tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE"),
				sounds = {
					"TowerRocketGunnersLiftoffTaunt",
					"TowerRocketGunnersTouchdownTaunt"
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_rocket_gunners_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROCKET_GUNNERS_4_NAME"),
				tt_desc = _("TOWER_ROCKET_GUNNERS_4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0002",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
				tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE"),
				sounds = {
					"TowerRocketGunnersLiftoffTaunt",
					"TowerRocketGunnersTouchdownTaunt"
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0002",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
				tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE"),
				sounds = {
					"TowerRocketGunnersLiftoffTaunt",
					"TowerRocketGunnersTouchdownTaunt"
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "sting_missiles",
				action = "upgrade_power",
				image = "kra_special_icons_0015",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerRocketGunnersSkillATaunt"
				},
				tt_phrase = _("TOWER_ROCKET_GUNNERS_4_STING_MISSILES_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ROCKET_GUNNERS_4_STING_MISSILES_1_NAME"),
						tt_desc = _("TOWER_ROCKET_GUNNERS_4_STING_MISSILES_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROCKET_GUNNERS_4_STING_MISSILES_2_NAME"),
						tt_desc = _("TOWER_ROCKET_GUNNERS_4_STING_MISSILES_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROCKET_GUNNERS_4_STING_MISSILES_3_NAME"),
						tt_desc = _("TOWER_ROCKET_GUNNERS_4_STING_MISSILES_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "phosphoric",
				action = "upgrade_power",
				image = "kra_special_icons_0016",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerRocketGunnersSkillBTaunt"
				},
				tt_phrase = _("TOWER_ROCKET_GUNNERS_4_PHOSPHORIC_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ROCKET_GUNNERS_4_PHOSPHORIC_1_NAME"),
						tt_desc = _("TOWER_ROCKET_GUNNERS_4_PHOSPHORIC_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROCKET_GUNNERS_4_PHOSPHORIC_2_NAME"),
						tt_desc = _("TOWER_ROCKET_GUNNERS_4_PHOSPHORIC_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_ROCKET_GUNNERS_4_PHOSPHORIC_3_NAME"),
						tt_desc = _("TOWER_ROCKET_GUNNERS_4_PHOSPHORIC_3_DESCRIPTION")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	ray = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ray_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_RAY_2_NAME"),
				tt_desc = _("TOWER_RAY_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ray_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_RAY_3_NAME"),
				tt_desc = _("TOWER_RAY_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ray_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_RAY_4_NAME"),
				tt_desc = _("TOWER_RAY_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "chain",
				action = "upgrade_power",
				image = "kra_special_icons_0030",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerRaySkillATaunt"
				},
				tt_phrase = _("TOWER_RAY_4_CHAIN_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_RAY_4_CHAIN_1_NAME"),
						tt_desc = _("TOWER_RAY_4_CHAIN_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_RAY_4_CHAIN_2_NAME"),
						tt_desc = _("TOWER_RAY_4_CHAIN_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_RAY_4_CHAIN_3_NAME"),
						tt_desc = _("TOWER_RAY_4_CHAIN_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "sheep",
				action = "upgrade_power",
				image = "kra_special_icons_0031",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerRaySkillBTaunt"
				},
				tt_phrase = _("TOWER_RAY_4_SHEEP_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_RAY_4_SHEEP_1_NAME"),
						tt_desc = _("TOWER_RAY_4_SHEEP_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_RAY_4_SHEEP_2_NAME"),
						tt_desc = _("TOWER_RAY_4_SHEEP_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_RAY_4_SHEEP_3_NAME"),
						tt_desc = _("TOWER_RAY_4_SHEEP_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	ghost = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ghost_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_GHOST_2_NAME"),
				tt_desc = _("TOWER_GHOST_2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_swap_mode",
				image = "quickmenu_action_icons_0004",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
				tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ghost_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_GHOST_3_NAME"),
				tt_desc = _("TOWER_GHOST_3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_swap_mode",
				image = "quickmenu_action_icons_0004",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
				tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_ghost_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_GHOST_4_NAME"),
				tt_desc = _("TOWER_GHOST_4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_swap_mode",
				image = "quickmenu_action_icons_0004",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
			    tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_swap_mode",
				image = "quickmenu_action_icons_0004",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NAME"),
				tt_desc_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_GROUND_NOTE"),
				tt_title_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NAME"),
				tt_desc_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_ROCKET_GUNNERS_CHANGE_MODE_FLY_NOTE")
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "extra_damage",
				action = "upgrade_power",
				image = "kra_special_icons_0024",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerGhostSkillATaunt"
				},
				tt_phrase = _("TOWER_GHOST_4_EXTRA_DAMAGE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_GHOST_4_EXTRA_DAMAGE_1_NAME"),
						tt_desc = _("TOWER_GHOST_4_EXTRA_DAMAGE_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_GHOST_4_EXTRA_DAMAGE_2_NAME"),
						tt_desc = _("TOWER_GHOST_4_EXTRA_DAMAGE_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_GHOST_4_EXTRA_DAMAGE_3_NAME"),
						tt_desc = _("TOWER_GHOST_4_EXTRA_DAMAGE_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "soul_attack",
				action = "upgrade_power",
				image = "kra_special_icons_0025",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerGhostSkillBTaunt"
				},
				tt_phrase = _("TOWER_GHOST_4_SOUL_ATTACK_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_GHOST_4_SOUL_ATTACK_1_NAME"),
						tt_desc = _("TOWER_GHOST_4_SOUL_ATTACK_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_GHOST_4_SOUL_ATTACK_2_NAME"),
						tt_desc = _("TOWER_GHOST_4_SOUL_ATTACK_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_GHOST_4_SOUL_ATTACK_3_NAME"),
						tt_desc = _("TOWER_GHOST_4_SOUL_ATTACK_3_DESCRIPTION")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	dark_elf = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_dark_elf_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ELF_2_NAME"),
				tt_desc = _("TOWER_DARK_ELF_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0005",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_dark_elf_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ELF_3_NAME"),
				tt_desc = _("TOWER_DARK_ELF_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0005",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_dark_elf_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DARK_ELF_4_NAME"),
				tt_desc = _("TOWER_DARK_ELF_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0005",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_soldiers",
				action = "upgrade_power",
				image = "kra_special_icons_0032",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerDarkElfSkillATaunt"
				},
				tt_phrase = _("TOWER_DARK_ELF_4_SKILL_SOLDIERS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ELF_4_SKILL_SOLDIERS_1_NAME"),
						tt_desc = _("TOWER_DARK_ELF_4_SKILL_SOLDIERS_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DARK_ELF_4_SKILL_SOLDIERS_2_NAME"),
						tt_desc = _("TOWER_DARK_ELF_4_SKILL_SOLDIERS_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DARK_ELF_4_SKILL_SOLDIERS_3_NAME"),
						tt_desc = _("TOWER_DARK_ELF_4_SKILL_SOLDIERS_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "skill_buff",
				action = "upgrade_power",
				image = "kra_special_icons_0033",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerDarkElfSkillBTaunt"
				},
				tt_phrase = _("TOWER_DARK_ELF_4_SKILL_BUFF_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DARK_ELF_4_SKILL_BUFF_1_NAME"),
						tt_desc = _("TOWER_DARK_ELF_4_SKILL_BUFF_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DARK_ELF_4_SKILL_BUFF_2_NAME"),
						tt_desc = _("TOWER_DARK_ELF_4_SKILL_BUFF_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DARK_ELF_4_SKILL_BUFF_3_NAME"),
						tt_desc = _("TOWER_DARK_ELF_4_SKILL_BUFF_3_DESCRIPTION")
					}
				}
			},
			{
				dynamic_rally = true,
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 4
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0005",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NAME"),
				tt_desc_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_DARK_ELF_CHANGE_MODE_MAXHP_NOTE"),
				tt_title_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NAME"),
				tt_desc_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_DARK_ELF_CHANGE_MODE_FOREMOST_NOTE")
			}
		}
	},
	sparking_geode = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_sparking_geode_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SPARKING_GEODE_2_NAME"),
				tt_desc = _("TOWER_SPARKING_GEODE_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_sparking_geode_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SPARKING_GEODE_3_NAME"),
				tt_desc = _("TOWER_SPARKING_GEODE_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_sparking_geode_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_SPARKING_GEODE_4_NAME"),
				tt_desc = _("TOWER_SPARKING_GEODE_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "crystalize",
				action = "upgrade_power",
				image = "kra_special_icons_0038",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerSparkingGeodeSkillATaunt"
				},
				tt_phrase = _("TOWER_SPARKING_GEODE_4_CRISTALIZE"),
				tt_list = {
					{
						tt_title = _("TOWER_SPARKING_GEODE_4_CRISTALIZE_1_NAME"),
						tt_desc = _("TOWER_SPARKING_GEODE_4_CRISTALIZE_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SPARKING_GEODE_4_CRISTALIZE_2_NAME"),
						tt_desc = _("TOWER_SPARKING_GEODE_4_CRISTALIZE_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SPARKING_GEODE_4_CRISTALIZE_3_NAME"),
						tt_desc = _("TOWER_SPARKING_GEODE_4_CRISTALIZE_3_DESCRIPTION")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "spike_burst",
				action = "upgrade_power",
				image = "kra_special_icons_0039",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerSparkingGeodeSkillBTaunt"
				},
				tt_phrase = _("TOWER_SPARKING_GEODE_4_SPIKE_BURST"),
				tt_list = {
					{
						tt_title = _("TOWER_SPARKING_GEODE_4_SPIKE_BURST_1_NAME"),
						tt_desc = _("TOWER_SPARKING_GEODE_4_SPIKE_BURST_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SPARKING_GEODE_4_SPIKE_BURST_2_NAME"),
						tt_desc = _("TOWER_SPARKING_GEODE_4_SPIKE_BURST_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_SPARKING_GEODE_4_SPIKE_BURST_3_NAME"),
						tt_desc = _("TOWER_SPARKING_GEODE_4_SPIKE_BURST_3_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		}
	},
	pandas = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_pandas_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_PANDAS_2_NAME"),
				tt_desc = _("TOWER_PANDAS_2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ingame_ui_ico_sell_0002",
				action = "tw_sell",
				halo = "ingame_ui_ico_sell_0001_hover",
				image = "ingame_ui_ico_sell_0001",
				place = 9
			},
			{
				check = "special_icons_0020",
				action_arg = "pandas_retreat",
				action = "tw_free_action",
				halo = "glow_ico_main",
				image = "quickmenu_retreat_icons_tower_panda",
				place = 3,
				tt_title = _("TOWER_PANDAS_RETREAT_NAME"),
				tt_desc = _("TOWER_PANDAS_RETREAT_DESCRIPTION")
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_pandas_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_PANDAS_3_NAME"),
				tt_desc = _("TOWER_PANDAS_3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "special_icons_0020",
				action_arg = "pandas_retreat",
				action = "tw_free_action",
				halo = "glow_ico_main",
				image = "quickmenu_retreat_icons_tower_panda",
				place = 3,
				tt_title = _("TOWER_PANDAS_RETREAT_NAME"),
				tt_desc = _("TOWER_PANDAS_RETREAT_DESCRIPTION")
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_pandas_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_PANDAS_4_NAME"),
				tt_desc = _("TOWER_PANDAS_4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "special_icons_0020",
				action_arg = "pandas_retreat",
				action = "tw_free_action",
				halo = "glow_ico_main",
				image = "quickmenu_retreat_icons_tower_panda",
				place = 3,
				tt_title = _("TOWER_PANDAS_RETREAT_NAME"),
				tt_desc = _("TOWER_PANDAS_RETREAT_DESCRIPTION")
			}
		},
		{
			{
				check = "special_icons_0020",
				action_arg = "thunder",
				action = "upgrade_power",
				image = "kra_special_icons_0041",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"TowerPandasSkillATauntZH"--i18n:cjk("TowerPandasSkillATaunt", "TowerPandasSkillATauntZH", nil, nil)
				},
				tt_phrase = _("TOWER_PANDAS_4_THUNDER"),
				tt_list = {
					{
						tt_title = _("TOWER_PANDAS_4_THUNDER_1_NAME"),
						tt_desc = _("TOWER_PANDAS_4_THUNDER_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_PANDAS_4_THUNDER_2_NAME"),
						tt_desc = _("TOWER_PANDAS_4_THUNDER_2_DESCRIPTION")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "hat",
				action = "upgrade_power",
				image = "kra_special_icons_0040",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerPandasSkillBTauntZH"--i18n:cjk("TowerPandasSkillBTaunt", "TowerPandasSkillBTauntZH", nil, nil)
				},
				tt_phrase = _("TOWER_PANDAS_4_HAT"),
				tt_list = {
					{
						tt_title = _("TOWER_PANDAS_4_HAT_1_NAME"),
						tt_desc = _("TOWER_PANDAS_4_HAT_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_PANDAS_4_HAT_2_NAME"),
						tt_desc = _("TOWER_PANDAS_4_HAT_2_DESCRIPTION")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "teleport",
				action = "upgrade_power",
				image = "kra_special_icons_0042",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerPandasSkillCTauntZH"--i18n:cjk("TowerPandasSkillCTaunt", "TowerPandasSkillCTauntZH", nil, nil)
				},
				tt_phrase = _("TOWER_PANDAS_4_FIERY"),
				tt_list = {
					{
						tt_title = _("TOWER_PANDAS_4_FIERY_1_NAME"),
						tt_desc = _("TOWER_PANDAS_4_FIERY_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_PANDAS_4_FIERY_2_NAME"),
						tt_desc = _("TOWER_PANDAS_4_FIERY_2_DESCRIPTION")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "special_icons_0020",
				action_arg = "pandas_retreat",
				action = "tw_free_action",
				halo = "glow_ico_main",
				image = "quickmenu_retreat_icons_tower_panda",
				place = 3,
				tt_title = _("TOWER_PANDAS_RETREAT_NAME"),
				tt_desc = _("TOWER_PANDAS_RETREAT_DESCRIPTION")
			}
		}
	},
	mage = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_mage_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_MAGE_2_NAME"),
				tt_desc = _("TOWER_MAGE_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_pixie_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0002",
				place = 1,
				tt_title = _("ELVES_TOWER_PIXIE_NAME"),
				tt_desc = _("ELVES_TOWER_PIXIE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_faerie_dragon_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0001",
				place = 2,
				tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_NAME"),
				tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_mage_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_MAGE_3_NAME"),
				tt_desc = _("TOWER_MAGE_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_wild_magus",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0106",
				place = 1,
				tt_title = _("TOWER_MAGE_WILD_MAGUS_NAME"),
				tt_desc = _("TOWER_MAGE_WILD_MAGUS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_high_elven",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0107",
				place = 2,
				tt_title = _("TOWER_MAGE_HIGH_ELVEN_NAME"),
				tt_desc = _("TOWER_MAGE_HIGH_ELVEN_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	rock_thrower = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_rock_thrower_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROCK_THROWER_2_NAME"),
				tt_desc = _("TOWER_ROCK_THROWER_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_bastion_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0003",
				place = 1,
				tt_title = _("ELVES_TOWER_BASTION_D_NAME"),
				tt_desc = _("ELVES_TOWER_BASTION_D_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_black_baby_dragon_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0009",
				place = 2,
				tt_title = _("ELVES_BABY_BERESAD_NAME"),
				tt_desc = _("ELVES_BABY_BERESAD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_rock_thrower_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ROCK_THROWER_3_NAME"),
				tt_desc = _("TOWER_ROCK_THROWER_3_DESCRIPTION")
			},			
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_druid",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0111",
				place = 1,
				tt_title = _("TOWER_DRUID_HENGE_NAME"),
				tt_desc = _("TOWER_DRUID_HENGE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_entwood",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0110",
				place = 2,
				tt_title = _("TOWER_ENTWOOD_NAME"),
				tt_desc = _("TOWER_ENTWOOD_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	archer = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_archer_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARCHER_2_NAME"),
				tt_desc = _("TOWER_ARCHER_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ground_archer",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "groundArchers_0001",
				place = 1,--3,
				tt_title = _("TOWER_GROUND_ARCHER_NAME"),
				tt_desc = _("TOWER_GROUND_ARCHER_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_ewok_archer",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0112",
				place = 2,
				tt_title = _("ELVES_EWOK_TOWER_ARCHER_NAME"),
				tt_desc = _("ELVES_EWOK_TOWER_ARCHER_DESCRIPTION")
			},					
			{
				check = "main_icons_0019",
				action_arg = "tower_archer_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARCHER_3_NAME"),
				tt_desc = _("TOWER_ARCHER_3_DESCRIPTION")
			},				
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_green_archer",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "groundArchers_0002",
				place = 3,--3,
				tt_title = _("TOWER_GREEN_ARCHER_NAME"),
				tt_desc = _("TOWER_GREEN_ARCHER_DESCRIPTION")
			},					
			{
				check = "main_icons_0019",
				action_arg = "tower_arcane",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0108",
				place = 1,
				tt_title = _("TOWER_ARCANE_NAME"),
				tt_desc = _("TOWER_ARCANE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_silver",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0109",
				place = 2,
				tt_title = _("TOWER_SILVER_NAME"),
				tt_desc = _("TOWER_SILVER_DESCRIPTION")
			},	
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	---
	ground_archer ={
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_green_archer",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "groundArchers_0002",
				place = 3,--3,
				tt_title = _("TOWER_GREEN_ARCHER_NAME"),
				tt_desc = _("TOWER_GREEN_ARCHER_DESCRIPTION")
			},				
			{
				check = "main_icons_0019",
				action_arg = "tower_arcane",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0108",
				place = 1,
				tt_title = _("TOWER_ARCANE_NAME"),
				tt_desc = _("TOWER_ARCANE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_silver",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0109",
				place = 2,
				tt_title = _("TOWER_SILVER_NAME"),
				tt_desc = _("TOWER_SILVER_DESCRIPTION")
			},				
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	ewok_archer	= {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_green_archer",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "groundArchers_0002",
				place = 3,--3,
				tt_title = _("TOWER_GREEN_ARCHER_NAME"),
				tt_desc = _("TOWER_GREEN_ARCHER_DESCRIPTION")
			},					
			{
				check = "main_icons_0019",
				action_arg = "tower_arcane",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0108",
				place = 1,
				tt_title = _("TOWER_ARCANE_NAME"),
				tt_desc = _("TOWER_ARCANE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_silver",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0109",
				place = 2,
				tt_title = _("TOWER_SILVER_NAME"),
				tt_desc = _("TOWER_SILVER_DESCRIPTION")
			},			
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},		
	---		
	barrack = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARRACK_2_NAME"),
				tt_desc = _("TOWER_BARRACK_2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ewok_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0112",
				place = 1,
				tt_title = _("ELVES_EWOK_NAME"),
				tt_desc = _("ELVES_EWOK_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_elf_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0016",
				place = 2,
				tt_title = _("SPECIAL_ELF_REPAIR1_NAME"),
				tt_desc = _("SPECIAL_ELF_REPAIR1_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARRACK_3_NAME"),
				tt_desc = _("TOWER_BARRACK_3_DESCRIPTION")
			},			
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_drow_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "special_icons_0301",
				place = 3,
				tt_title = _("ELVES_TOWER_SPECIAL_DROW_NAME"),
				tt_desc = _("ELVES_TOWER_SPECIAL_DROW_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_blade",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0104",
				place = 1,
				tt_title = _("TOWER_BARRACKS_BLADE_NAME"),
				tt_desc = _("TOWER_BARRACKS_BLADE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_forest",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0105",
				place = 2,
				tt_title = _("TOWER_FOREST_KEEPERS_NAME"),
				tt_desc = _("TOWER_FOREST_KEEPERS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_3_a",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},			
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	tower_barrack_3_a = {
		{
			{
				check = "main_icons_0020",
				action_arg = "tower_elf_1",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0906",
				place = 3,
				tt_title = _("SPECIAL_ELF_KR1_REPAIR_NAME"),
				tt_desc = _("SPECIAL_ELF_KR1_REPAIR_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_ewok_rework",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0112",
				place = 1,
				tt_title = _("ELVES_EWOK_NAME"),
				tt_desc = _("ELVES_EWOK_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_baby_ashbite_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0113",
				place = 2,
				tt_title = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_NAME"),
				tt_desc = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_3_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	tower_barrack_3_b = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_drow_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "special_icons_0301",
				place = 3,
				tt_title = _("ELVES_TOWER_SPECIAL_DROW_NAME"),
				tt_desc = _("ELVES_TOWER_SPECIAL_DROW_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_blade",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0104",
				place = 1,
				tt_title = _("TOWER_BARRACKS_BLADE_NAME"),
				tt_desc = _("TOWER_BARRACKS_BLADE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_forest",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0105",
				place = 2,
				tt_title = _("TOWER_FOREST_KEEPERS_NAME"),
				tt_desc = _("TOWER_FOREST_KEEPERS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_3_a",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},						
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	blade = {
		{
			{
				check = "special_icons_0020",
				action_arg = "perfect_parry",
				action = "upgrade_power",
				image = "special_icons_0105",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ElvesBarrackBladesingerPerfectParryTaunt"
				},
				tt_phrase = _("TOWER_BLADE_PERFECT_PARRY_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BLADE_PERFECT_PARRY_NAME_1"),
						tt_desc = _("TOWER_BLADE_PERFECT_PARRY_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_BLADE_PERFECT_PARRY_NAME_2"),
						tt_desc = _("TOWER_BLADE_PERFECT_PARRY_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_BLADE_PERFECT_PARRY_NAME_3"),
						tt_desc = _("TOWER_BLADE_PERFECT_PARRY_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "blade_dance",
				action = "upgrade_power",
				image = "special_icons_0104",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ElvesBarrackBladesingerBladeDanceTaunt"
				},
				tt_phrase = _("TOWER_BLADE_BLADE_DANCE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BLADE_BLADE_DANCE_NAME_1"),
						tt_desc = _("TOWER_BLADE_BLADE_DANCE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_BLADE_BLADE_DANCE_NAME_2"),
						tt_desc = _("TOWER_BLADE_BLADE_DANCE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_BLADE_BLADE_DANCE_NAME_3"),
						tt_desc = _("TOWER_BLADE_BLADE_DANCE_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "swirling",
				action = "upgrade_power",
				image = "special_icons_0106",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElvesBarrackBladesingerSwirlingEdge"
				},
				tt_phrase = _("TOWER_BLADE_SWIRLING_EDGE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BLADE_SWIRLING_EDGE_NAME_1"),
						tt_desc = _("TOWER_BLADE_SWIRLING_EDGE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_BLADE_SWIRLING_EDGE_NAME_2"),
						tt_desc = _("TOWER_BLADE_SWIRLING_EDGE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_BLADE_SWIRLING_EDGE_NAME_3"),
						tt_desc = _("TOWER_BLADE_SWIRLING_EDGE_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	forest = {
		{
			{
				check = "special_icons_0020",
				action_arg = "circle",
				action = "upgrade_power",
				image = "special_icons_0107",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ElvesBarrackForestKeeperCircleOfLifeTaunt"
				},
				tt_phrase = _("TOWER_FOREST_KEEPERS_CIRCLE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_FOREST_KEEPERS_CIRCLE_NAME_1"),
						tt_desc = _("TOWER_FOREST_KEEPERS_CIRCLE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FOREST_KEEPERS_CIRCLE_NAME_2"),
						tt_desc = _("TOWER_FOREST_KEEPERS_CIRCLE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_FOREST_KEEPERS_CIRCLE_NAME_3"),
						tt_desc = _("TOWER_FOREST_KEEPERS_CIRCLE_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "eerie",
				action = "upgrade_power",
				image = "special_icons_0109",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElvesBarrackForestKeeperEerieTaunt"
				},
				tt_phrase = _("TOWER_FOREST_KEEPERS_EERIE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_FOREST_KEEPERS_EERIE_NAME_1"),
						tt_desc = _("TOWER_FOREST_KEEPERS_EERIE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FOREST_KEEPERS_EERIE_NAME_2"),
						tt_desc = _("TOWER_FOREST_KEEPERS_EERIE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_FOREST_KEEPERS_EERIE_NAME_3"),
						tt_desc = _("TOWER_FOREST_KEEPERS_EERIE_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "oak",
				action = "upgrade_power",
				image = "special_icons_0110",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ElvesBarrackForestKeeperOakSpearTaunt"
				},
				tt_phrase = _("TOWER_FOREST_KEEPERS_OAK_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_FOREST_KEEPERS_OAK_NAME_1"),
						tt_desc = _("TOWER_FOREST_KEEPERS_OAK_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FOREST_KEEPERS_OAK_NAME_2"),
						tt_desc = _("TOWER_FOREST_KEEPERS_OAK_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_FOREST_KEEPERS_OAK_NAME_3"),
						tt_desc = _("TOWER_FOREST_KEEPERS_OAK_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	druid = {
		{
			{
				check = "special_icons_0020",
				action_arg = "sylvan",
				action = "upgrade_power",
				image = "special_icons_0112",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesRockHengeSylvanCurseTaunt"
				},
				tt_phrase = _("TOWER_STONE_DRUID_SYLVAN_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_STONE_DRUID_SYLVAN_NAME_1"),
						tt_desc = _("TOWER_STONE_DRUID_SYLVAN_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_STONE_DRUID_SYLVAN_NAME_2"),
						tt_desc = _("TOWER_STONE_DRUID_SYLVAN_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_STONE_DRUID_SYLVAN_NAME_3"),
						tt_desc = _("TOWER_STONE_DRUID_SYLVAN_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "nature",
				action = "upgrade_power",
				image = "special_icons_0111",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"SoldierDruidBearRallyChange"
				},
				tt_phrase = _("TOWER_STONE_DRUID_NATURES_FRIEND_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_STONE_DRUID_NATURES_FRIEND_NAME_1"),
						tt_desc = _("TOWER_STONE_DRUID_NATURES_FRIEND_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_STONE_DRUID_NATURES_FRIEND_NAME_2"),
						tt_desc = _("TOWER_STONE_DRUID_NATURES_FRIEND_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_STONE_DRUID_NATURES_FRIEND_NAME_3"),
						tt_desc = _("TOWER_STONE_DRUID_NATURES_FRIEND_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	entwood = {
		{
			{
				check = "special_icons_0020",
				action_arg = "clobber",
				action = "upgrade_power",
				image = "special_icons_0113",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesRockEntwoodClobberingTaunt"
				},
				tt_phrase = _("TOWER_ENTWOOD_CLOBBER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ENTWOOD_CLOBBER_NAME_1"),
						tt_desc = _("TOWER_ENTWOOD_CLOBBER_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ENTWOOD_CLOBBER_NAME_2"),
						tt_desc = _("TOWER_ENTWOOD_CLOBBER_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_ENTWOOD_CLOBBER_NAME_3"),
						tt_desc = _("TOWER_ENTWOOD_CLOBBER_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "fiery_nuts",
				action = "upgrade_power",
				image = "special_icons_0114",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesRockEntwoodFieryNutsTaunt"
				},
				tt_phrase = _("TOWER_FIERY_NUTS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_FIERY_NUTS_NAME_1"),
						tt_desc = _("TOWER_FIERY_NUTS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_FIERY_NUTS_NAME_2"),
						tt_desc = _("TOWER_FIERY_NUTS_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_FIERY_NUTS_NAME_3"),
						tt_desc = _("TOWER_FIERY_NUTS_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	arcane = {
		{
			{
				check = "special_icons_0020",
				action_arg = "burst",
				action = "upgrade_power",
				image = "special_icons_0101",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesArcherArcaneBurstTaunt"
				},
				tt_phrase = _("TOWER_ARCANE_BURST_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCANE_BURST_NAME_1"),
						tt_desc = _("TOWER_ARCANE_BURST_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ARCANE_BURST_NAME_2"),
						tt_desc = _("TOWER_ARCANE_BURST_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_ARCANE_BURST_NAME_3"),
						tt_desc = _("TOWER_ARCANE_BURST_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "slumber",
				action = "upgrade_power",
				image = "special_icons_0100",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesArcherArcaneSleepTaunt"
				},
				tt_phrase = _("TOWER_ARCANE_SLUMBER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCANE_SLUMBER_NAME_1"),
						tt_desc = _("TOWER_ARCANE_SLUMBER_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ARCANE_SLUMBER_NAME_2"),
						tt_desc = _("TOWER_ARCANE_SLUMBER_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_ARCANE_SLUMBER_NAME_3"),
						tt_desc = _("TOWER_ARCANE_SLUMBER_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	silver = {
		{
			{
				check = "special_icons_0020",
				action_arg = "sentence",
				action = "upgrade_power",
				image = "special_icons_0102",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesArcherGoldenBowCrimsonTaunt"
				},
				tt_phrase = _("TOWER_SILVER_SENTENCE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_SILVER_SENTENCE_NAME_1"),
						tt_desc = _("TOWER_SILVER_SENTENCE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_SILVER_SENTENCE_NAME_2"),
						tt_desc = _("TOWER_SILVER_SENTENCE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_SILVER_SENTENCE_NAME_3"),
						tt_desc = _("TOWER_SILVER_SENTENCE_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "mark",
				action = "upgrade_power",
				image = "special_icons_0103",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesArcherGoldenBowMarkTaunt"
				},
				tt_phrase = _("TOWER_SILVER_MARK_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_SILVER_MARK_NAME_1"),
						tt_desc = _("TOWER_SILVER_MARK_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_SILVER_MARK_NAME_2"),
						tt_desc = _("TOWER_SILVER_MARK_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_SILVER_MARK_NAME_3"),
						tt_desc = _("TOWER_SILVER_MARK_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	wild_magus = {
		{
			{
				check = "special_icons_0020",
				action_arg = "eldritch",
				action = "upgrade_power",
				image = "special_icons_0115",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesMageWildMagusDoomTaunt"
				},
				tt_phrase = _("TOWER_MAGE_WILD_MAGUS_ELDRITCH_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MAGE_WILD_MAGUS_ELDRITCH_NAME_1"),
						tt_desc = _("TOWER_MAGE_WILD_MAGUS_ELDRITCH_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_MAGE_WILD_MAGUS_ELDRITCH_NAME_2"),
						tt_desc = _("TOWER_MAGE_WILD_MAGUS_ELDRITCH_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_MAGE_WILD_MAGUS_ELDRITCH_NAME_3"),
						tt_desc = _("TOWER_MAGE_WILD_MAGUS_ELDRITCH_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "ward",
				action = "upgrade_power",
				image = "special_icons_0116",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesMageWildMagusSilenceTaunt"
				},
				tt_phrase = _("TOWER_MAGE_WILD_MAGUS_WARD_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MAGE_WILD_MAGUS_WARD_NAME_1"),
						tt_desc = _("TOWER_MAGE_WILD_MAGUS_WARD_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_MAGE_WILD_MAGUS_WARD_NAME_2"),
						tt_desc = _("TOWER_MAGE_WILD_MAGUS_WARD_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_MAGE_WILD_MAGUS_WARD_NAME_3"),
						tt_desc = _("TOWER_MAGE_WILD_MAGUS_WARD_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	high_elven = {
		{
			{
				check = "special_icons_0020",
				action_arg = "timelapse",
				action = "upgrade_power",
				image = "special_icons_0117",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesMageHighElvenTimelapseTaunt"
				},
				tt_phrase = _("TOWER_MAGE_HIGH_ELVEN_TIMELAPSE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MAGE_HIGH_ELVEN_TIMELAPSE_NAME_1"),
						tt_desc = _("TOWER_MAGE_HIGH_ELVEN_TIMELAPSE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_MAGE_HIGH_ELVEN_TIMELAPSE_NAME_2"),
						tt_desc = _("TOWER_MAGE_HIGH_ELVEN_TIMELAPSE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_MAGE_HIGH_ELVEN_TIMELAPSE_NAME_3"),
						tt_desc = _("TOWER_MAGE_HIGH_ELVEN_TIMELAPSE_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "sentinel",
				action = "upgrade_power",
				image = "special_icons_0118",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesMageHighElvenSentinelTaunt"
				},
				tt_phrase = _("TOWER_MAGE_HIGH_ELVEN_SENTINEL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MAGE_HIGH_ELVEN_SENTINEL_NAME_1"),
						tt_desc = _("TOWER_MAGE_HIGH_ELVEN_SENTINEL_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_MAGE_HIGH_ELVEN_SENTINEL_NAME_2"),
						tt_desc = _("TOWER_MAGE_HIGH_ELVEN_SENTINEL_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_MAGE_HIGH_ELVEN_SENTINEL_NAME_3"),
						tt_desc = _("TOWER_MAGE_HIGH_ELVEN_SENTINEL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	holder_ewok = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ewok",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0015",
				place = 5,
				tt_title = _("ELVES_EWOK_TOWER_BROKEN_NAME"),
				tt_desc = _("ELVES_EWOK_TOWER_BROKEN_DESCRIPTION")
			}
		}
	},
	ewok = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_ewok",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0112",
				place = 5,
				tt_title = _("ELVES_EWOK_NAME"),
				tt_desc = _("ELVES_EWOK_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			}
		}
	},
	ewok_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARRACK_3_NAME"),
				tt_desc = _("TOWER_BARRACK_3_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "soldier_ewok",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0112",
				place = 11,
				tt_title = _("ELVES_EWOK_NAME"),
				tt_desc = _("ELVES_EWOK_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	faerie_dragon = {
		{
			{
				check = "special_icons_0020",
				action_arg = "more_dragons",
				action = "upgrade_power",
				image = "special_icons_0124",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesFaeryDragonDragonBuy"
				},
				tt_phrase = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NAME_1"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NAME_2"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_SMALL_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "improve_shot",
				action = "upgrade_power",
				image = "special_icons_0125",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesFaeryDragonExtraAbility"
				},
				tt_phrase = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NAME_1"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NAME_2"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_SMALL_DESCRIPTION_2")
					}
				}
			}
		}
	},
	faerie_dragon_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "more_dragons",
				action = "upgrade_power",
				image = "special_icons_0124",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesFaeryDragonDragonBuy"
				},
				tt_phrase = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NAME_1"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NAME_2"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_SMALL_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "improve_shot",
				action = "upgrade_power",
				image = "special_icons_0125",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesFaeryDragonExtraAbility"
				},
				tt_phrase = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NAME_1"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NAME_2"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_SMALL_DESCRIPTION_2")
					}
				}
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_faerie_dragon_re",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 10,
				tt_title = _("TOWER_MAGE_3_NAME"),
				tt_desc = _("TOWER_MAGE_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	pixie = {
		{
			{
				check = "special_icons_0020",
				action_arg = "cream",
				action = "upgrade_power",
				image = "special_icons_0122",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesGnomeNew"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE1_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE1_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE1_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE1_NAME_2"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE1_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "total",
				action = "upgrade_power",
				image = "special_icons_0123",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesGnomePower"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE2_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_2"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_3"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_3")
					}
				}
			}
		}
	},
	pixie_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "cream",
				action = "upgrade_power",
				image = "special_icons_0122",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesGnomeNew"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE1_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE1_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE1_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE1_NAME_2"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE1_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "total",
				action = "upgrade_power",
				image = "special_icons_0123",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesGnomePower"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE2_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_2"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_3"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_3")
					}
				}
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_pixie_re",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 10,
				tt_title = _("TOWER_MAGE_3_NAME"),
				tt_desc = _("TOWER_MAGE_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	baby_black_dragon = {
		{
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "main_icons_0114",
				place = 5,
				tt_title = _("ELVES_BABY_BERESAD_SPECIAL_NAME_1"),
				tt_desc = _("ELVES_BABY_BERESAD_SPECIAL_SMALL_DESCRIPTION_1")
			}
		}
	},
	baby_black_dragon_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "main_icons_0114",
				place = 5,
				tt_title = _("ELVES_BABY_BERESAD_SPECIAL_NAME_1"),
				tt_desc = _("ELVES_BABY_BERESAD_SPECIAL_SMALL_DESCRIPTION_1")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	holder_baby_ashbite = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_baby_ashbite",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0113",
				place = 5,
				tt_title = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_NAME"),
				tt_desc = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_DESCRIPTION")
			}
		}
	},
	holder_baby_ashbite_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_baby_ashbite_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0113",
				place = 5,
				tt_title = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_NAME"),
				tt_desc = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	baby_ashbite = {
		{
			{
				check = "special_icons_0020",
				action_arg = "blazing_breath",
				action = "upgrade_power",
				image = "special_icons_0126",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesAshbiteConfirm"
				},
				tt_phrase = _("ELVES_BABY_ASHBITE_FIREBREATH_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_BABY_ASHBITE_FIREBREATH_NAME_1"),
						tt_desc = _("ELVES_BABY_ASHBITE_FIREBREATH_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_BABY_ASHBITE_FIREBREATH_NAME_2"),
						tt_desc = _("ELVES_BABY_ASHBITE_FIREBREATH_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_BABY_ASHBITE_FIREBREATH_NAME_3"),
						tt_desc = _("ELVES_BABY_ASHBITE_FIREBREATH_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "fiery_mist",
				action = "upgrade_power",
				image = "special_icons_0127",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesAshbiteConfirm"
				},
				tt_phrase = _("ELVES_BABY_ASHBITE_SMOKEBREATH_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_BABY_ASHBITE_SMOKEBREATH_NAME_1"),
						tt_desc = _("ELVES_BABY_ASHBITE_SMOKEBREATH_SMALL_DESCRIPTION_1")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			}
		}
	},
	baby_ashbite_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "blazing_breath",
				action = "upgrade_power",
				image = "special_icons_0126",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesAshbiteConfirm"
				},
				tt_phrase = _("ELVES_BABY_ASHBITE_FIREBREATH_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_BABY_ASHBITE_FIREBREATH_NAME_1"),
						tt_desc = _("ELVES_BABY_ASHBITE_FIREBREATH_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_BABY_ASHBITE_FIREBREATH_NAME_2"),
						tt_desc = _("ELVES_BABY_ASHBITE_FIREBREATH_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_BABY_ASHBITE_FIREBREATH_NAME_3"),
						tt_desc = _("ELVES_BABY_ASHBITE_FIREBREATH_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "fiery_mist",
				action = "upgrade_power",
				image = "special_icons_0127",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesAshbiteConfirm"
				},
				tt_phrase = _("ELVES_BABY_ASHBITE_SMOKEBREATH_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_BABY_ASHBITE_SMOKEBREATH_NAME_1"),
						tt_desc = _("ELVES_BABY_ASHBITE_SMOKEBREATH_SMALL_DESCRIPTION_1")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	drow = {
		{
			{
				check = "special_icons_0020",
				action_arg = "life_drain",
				action = "upgrade_power",
				image = "special_icons_0120",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ElvesSpecialDrowLifeDrain"
				},
				tt_phrase = _("ELVES_TOWER_DROW_LIFE_DRAIN_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_DROW_LIFE_DRAIN_NAME_1"),
						tt_desc = _("ELVES_TOWER_DROW_LIFE_DRAIN_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_LIFE_DRAIN_NAME_2"),
						tt_desc = _("ELVES_TOWER_DROW_LIFE_DRAIN_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_LIFE_DRAIN_NAME_3"),
						tt_desc = _("ELVES_TOWER_DROW_LIFE_DRAIN_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "blade_mail",
				action = "upgrade_power",
				image = "special_icons_0119",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ElvesSpecialDrowBlademail"
				},
				tt_phrase = _("ELVES_TOWER_DROW_BLADE_MAIL_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_1"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_2"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_3"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "double_dagger",
				action = "upgrade_power",
				image = "special_icons_0121",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElvesSpecialDrowDaggers"
				},
				tt_phrase = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NAME_1"),
						tt_desc = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NAME_2"),
						tt_desc = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NAME_3"),
						tt_desc = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			}
		}
	},
	drow_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "life_drain",
				action = "upgrade_power",
				image = "special_icons_0120",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ElvesSpecialDrowLifeDrain"
				},
				tt_phrase = _("ELVES_TOWER_DROW_LIFE_DRAIN_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_DROW_LIFE_DRAIN_NAME_1"),
						tt_desc = _("ELVES_TOWER_DROW_LIFE_DRAIN_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_LIFE_DRAIN_NAME_2"),
						tt_desc = _("ELVES_TOWER_DROW_LIFE_DRAIN_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_LIFE_DRAIN_NAME_3"),
						tt_desc = _("ELVES_TOWER_DROW_LIFE_DRAIN_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "blade_mail",
				action = "upgrade_power",
				image = "special_icons_0119",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ElvesSpecialDrowBlademail"
				},
				tt_phrase = _("ELVES_TOWER_DROW_BLADE_MAIL_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_1"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_2"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_3"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "double_dagger",
				action = "upgrade_power",
				image = "special_icons_0121",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElvesSpecialDrowDaggers"
				},
				tt_phrase = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NAME_1"),
						tt_desc = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NAME_2"),
						tt_desc = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_NAME_3"),
						tt_desc = _("ELVES_TOWER_DROW_DOUBLE_DAGGER_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	holder_bastion = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_bastion",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0015",
				place = 5,
				tt_title = _("ELVES_TOWER_BASTION_BROKEN_NAME"),
				tt_desc = _("ELVES_TOWER_BASTION_BROKEN_DESCRIPTION")
			}
		}
	},
	bastion = {
		{
			{
				check = "special_icons_0020",
				action_arg = "razor_edge",
				action = "upgrade_power",
				image = "special_icons_0128",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElvesTowerBastionRazorEdge"
				},
				tt_phrase = _("ELVES_TOWER_BASTION_RAZOR_EDGE_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_BASTION_RAZOR_EDGE_NAME_1"),
						tt_desc = _("ELVES_TOWER_BASTION_RAZOR_EDGE_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_BASTION_RAZOR_EDGE_NAME_2"),
						tt_desc = _("ELVES_TOWER_BASTION_RAZOR_EDGE_SMALL_DESCRIPTION_2")
					}
				}
			}
		}
	},
	bastion_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "razor_edge",
				action = "upgrade_power",
				image = "special_icons_0128",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElvesTowerBastionRazorEdge"
				},
				tt_phrase = _("ELVES_TOWER_BASTION_RAZOR_EDGE_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_BASTION_RAZOR_EDGE_NAME_1"),
						tt_desc = _("ELVES_TOWER_BASTION_RAZOR_EDGE_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_BASTION_RAZOR_EDGE_NAME_2"),
						tt_desc = _("ELVES_TOWER_BASTION_RAZOR_EDGE_SMALL_DESCRIPTION_2")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	--2代
	holder_blocked_jungle = {
		{
			{
				action = "tw_unblock",
				action_arg = "tower_holder",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0037",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_JUNGLE_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_JUNGLE_DESCRIPTION"),
			},
		},
	},
	holder_blocked_underground = {
		{
			{
				action = "tw_unblock",
				action_arg = "tower_holder",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0037",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_UNDERGROUND_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_UNDERGROUND_DESCRIPTION"),
			},
		},
	},

	g1_mage = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_sunray_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0007",
				place = 11,
				tt_title = _("SPECIAL_SUNRAY_NAME"),
				tt_desc = _("SPECIAL_SUNRAY_NOTE")
			},			
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_mage_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_MAGE_2_NAME"),
				tt_desc = _("G2_TOWER_MAGE_2_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_mage_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_MAGE_3_NAME"),
				tt_desc = _("G2_TOWER_MAGE_3_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{			
			{
				check = "main_icons_0019",
				action_arg = "tower_time_wizard",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "bloodlust_icons_0001",
				place = 3,
				tt_title = _("TOWER_TIME_WIZARD_NAME"),
				tt_desc = _("TOWER_TIME_WIZARD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_arcane_wizard",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0006",
				place = 1,--3,
				tt_title = _("TOWER_ARCANE_WIZARD_NAME"),
				tt_desc = _("TOWER_ARCANE_WIZARD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_sorcerer",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0007",
				place = 2,--4,
				tt_title = _("TOWER_SORCERER_NAME"),
				tt_desc = _("TOWER_SORCERER_DESCRIPTION")
			},			
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g1_engineer = {
		{
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_engineer_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ENGINEER_2_NAME"),
				tt_desc = _("G2_TOWER_ENGINEER_2_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_engineer_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ENGINEER_3_NAME"),
				tt_desc = _("G2_TOWER_ENGINEER_3_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_bfg",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0013",
				place = 1,--3,
				tt_title = _("TOWER_BFG_NAME"),
				tt_desc = _("TOWER_BFG_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_tesla",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0012",
				place = 2,--4,
				tt_title = _("TOWER_TESLA_NAME"),
				tt_desc = _("TOWER_TESLA_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g1_archer = {
		{
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_archer_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ARCHER_2_NAME"),
				tt_desc = _("G2_TOWER_ARCHER_2_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_archer_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ARCHER_3_NAME"),
				tt_desc = _("G2_TOWER_ARCHER_3_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_ranger",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0011",
				place = 1,--3,
				tt_title = _("TOWER_RANGERS_NAME"),
				tt_desc = _("TOWER_RANGERS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_musketeer",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0010",
				place = 2,--4,
				tt_title = _("TOWER_MUSKETEERS_NAME"),
				tt_desc = _("TOWER_MUSKETEERS_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g1_barrack = {
		{
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_barrack_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_2_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_2_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
                check = "main_icons_0019",
				action_arg = "tower_imperialguard",
	            action = "tw_upgrade",
	            halo = "glow_ico_main",
				image = "main_icons_00cc",
			    place = 1,
			    tt_title = _("IMPERIALGUARD_NAME"),
			    tt_desc = _("IMPERIALGUARD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_sasquash_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0017",
				place = 2,--4,
				tt_title = _("SPECIAL_SASQUASH_REPAIR1_NAME"),
				tt_desc = _("SPECIAL_SASQUASH_REPAIR1_DESCRIPTION"),
			},			
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_barrack_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_3_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_3_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_steam_troop",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "bloodlust_icons_0004",
				place = 3,--12,
				tt_title = _("TOWER_STEAM_TROOP_NAME"),
				tt_desc = _("TOWER_STEAM_TROOP_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_paladin",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0008",
				place = 1,--11,
				tt_title = _("TOWER_PALADINS_NAME"),
				tt_desc = _("TOWER_PALADINS_DESCRIPTION")
			},						
			{
				check = "main_icons_0019",
				action_arg = "tower_barbarian",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0009",
				place = 2,--3,
				tt_title = _("TOWER_BARBARIANS_NAME"),
				tt_desc = _("TOWER_BARBARIANS_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "g1_tower_barrack_3_a",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g1_tower_barrack_3_a = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_paladin_rider",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "HolyKnight_icons_0001",
				place = 3,--11,
				tt_title = _("TOWER_HOLYRIDE_NAME"),
				tt_desc = _("TOWER_HOLYRIDE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_imperial_patrol_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "HolyKnight_1_icons_0002",
				place = 11,
				tt_title = _("TOWER_IMPERIAL_PATROL_GUARD_NAME"),
				tt_desc = _("TOWER_IMPERIAL_PATROL_GUARD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_imperial_patrol",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0008a",
				place = 1,--13,
				tt_title = _("TOWER_IMPERIAL_GUARD_NAME"),
				tt_desc = _("TOWER_IMPERIAL_GUARD_DESCRIPTION")
			},						
			{
				check = "main_icons_0019",
				action_arg = "tower_sasquash_rework",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_00bb",
				place = 2,--14,
				tt_title = _("TOWER_BARRACK_SASQUATCH_NAME"),
				tt_desc = _("TOWER_BARRACK_SASQUATCH_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g1_tower_barrack_3_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},					
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		}
	},
	g1_tower_barrack_3_b = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_steam_troop",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "bloodlust_icons_0004",
				place = 3,--12,
				tt_title = _("TOWER_STEAM_TROOP_NAME"),
				tt_desc = _("TOWER_STEAM_TROOP_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_paladin",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0008",
				place = 1,--11,
				tt_title = _("TOWER_PALADINS_NAME"),
				tt_desc = _("TOWER_PALADINS_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_barbarian",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0009",
				place = 2,--3,
				tt_title = _("TOWER_BARBARIANS_NAME"),
				tt_desc = _("TOWER_BARBARIANS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g1_tower_barrack_3_a",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	g2_mage = {
		{
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_mage_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_MAGE_2_NAME"),
				tt_desc = _("G2_TOWER_MAGE_2_DESCRIPTION"),
			},							
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{	
			{
				check = "main_icons_0019",
				action_arg = "tower_neptune_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0008",
				place = 11,--12,
				tt_title = _("TOWER_NEPTUNE_HOLDER_NAME"),
				tt_desc = _("TOWER_NEPTUNE_HOLDER_DESCRIPTION"),
			},
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_mage_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_MAGE_3_NAME"),
				tt_desc = _("G2_TOWER_MAGE_3_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},				
		},
		{
			{
				action = "tw_upgrade",
				action_arg = "tower_necromancer",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0021",
				place = 1,
				tt_title = _("TOWER_NECROMANCER_NAME"),
				tt_desc = _("TOWER_NECROMANCER_DESCRIPTION"),
			},
			{
				action = "tw_upgrade",
				action_arg = "tower_archmage",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0022",
				place = 2,
				tt_title = _("TOWER_ARCHMAGE_NAME"),
				tt_desc = _("TOWER_ARCHMAGE_DESCRIPTION"),
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g2_engineer = {
		{
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_engineer_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ENGINEER_2_NAME"),
				tt_desc = _("G2_TOWER_ENGINEER_2_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_frankenstein_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0006",
				place = 1,
				tt_title = _("TOWER_FRANKENSTEIN_NAME"),
				tt_desc = _("TOWER_FRANKENSTEIN_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_pirate_camp_land",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0010",--"main_icons_0034",
				place = 2,
				tt_title = _("TOWER_PIRATE_CAMP_NAME"),
				tt_desc = _("TOWER_PIRATE_CAMP_DESCRIPTION")
			},
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_engineer_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ENGINEER_3_NAME"),
				tt_desc = _("G2_TOWER_ENGINEER_3_DESCRIPTION"),
			},			
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_sandworm",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "sandworm_0004",
				place = 3,
				tt_title = _("SANDWORM_NAME"),
				tt_desc = _("TOWER_SANDWORM_DESCRIPTION")
			},
			{
				action = "tw_upgrade",
				action_arg = "tower_dwaarp",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0027",
				place = 1,--11,
				tt_title = _("TOWER_DWAARP_NAME"),
				tt_desc = _("TOWER_DWAARP_DESCRIPTION"),
			},
			{
				action = "tw_upgrade",
				action_arg = "tower_mech",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0028",
				place = 2,--12,
				tt_title = _("TOWER_MECH_NAME"),
				tt_desc = _("TOWER_MECH_DESCRIPTION"),
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}						
		}
	},
	g2_archer = {
		{
			{
			    check = "main_icons_0019",
			    action_arg = "tower_archer_hammerhold_1",
			    action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_00dd",
				place = 11,
				tt_title = _("TOWER_ARCHER_HAMMERHOLD_NAME"),
				tt_desc = _("TOWER_ARCHER_HAMMERHOLD_DESCRIPTION")
			},	
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_archer_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ARCHER_2_NAME"),
				tt_desc = _("G2_TOWER_ARCHER_2_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},					
		},
		{
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_archer_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_ARCHER_3_NAME"),
				tt_desc = _("G2_TOWER_ARCHER_3_DESCRIPTION"),
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_archer_dwarf_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0005",
				place = 3,--5,
				tt_title = _("TOWER_ARCHER_DWARF_NAME"),
				tt_desc = _("TOWER_ARCHER_DWARF_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_pirate_watchtower_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_tower_icons_0004",
				place = 4,--10,
				tt_title = _("TOWER_PIRATE_WATCHTOWER_NAME"),
				tt_desc = _("TOWER_PIRATE_WATCHTOWER_DESCRIPTION")
			},
			{
				action = "tw_upgrade",
				action_arg = "tower_totem",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0026",
				place = 1,
				tt_title = _("TOWER_TOTEM_NAME"),
				tt_desc = _("TOWER_TOTEM_DESCRIPTION"),
			},
			{
				action = "tw_upgrade",
				action_arg = "tower_crossbow",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0025",
				place = 2,
				tt_title = _("TOWER_CROSSBOW_NAME"),
				tt_desc = _("TOWER_CROSSBOW_DESCRIPTION"),
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_hammerhold_elite",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "legion_icons_0001",
				place = 5,--13,
				tt_title = _("HAMMERHOLD_ARCHER_NAME"),
				tt_desc = _("HAMMERHOLD_ARCHER_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g2_barrack = {
		{
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_barrack_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_2_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_2_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirates_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0031",
				place = 3,
				tt_title = _("TOWER_BARRACK_PIRATES_NAME"),
				tt_desc = _("TOWER_BARRACK_PIRATES_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_amazonas_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0033",
				place = 1,
				tt_title = _("TOWER_BARRACK_AMAZONAS_NAME"),
				tt_desc = _("TOWER_BARRACK_AMAZONAS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_mercenaries_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0029",
				place = 2,
				tt_title = _("TOWER_BARRACK_MERCENARIES_NAME"),
				tt_desc = _("TOWER_BARRACK_MERCENARIES_DESCRIPTION")
			},
			{
				action = "tw_upgrade",
				action_arg = "g2_tower_barrack_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_3_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_3_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_dwarf_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "special_icons_0201",
				place = 3,
				tt_title = _("SPECIAL_DWARF_HALL_NAME"),
				tt_desc = _("SPECIAL_DWARF_HALL_DESCRIPTION")
			},			
			{
				action = "tw_upgrade",
				action_arg = "tower_assassin",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0024",
				place = 1,
				tt_title = _("TOWER_ASSASSIN_NAME"),
				tt_desc = _("TOWER_ASSASSIN_DESCRIPTION"),
			},
			{
				action = "tw_upgrade",
				action_arg = "tower_templar",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0023",
				place = 2,
				tt_title = _("TOWER_TEMPLAR_NAME"),
				tt_desc = _("TOWER_TEMPLAR_DESCRIPTION"),
			},
			{
				check = "main_icons_0019",
				action_arg = "g2_tower_barrack_3_a",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},			
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g2_tower_barrack_3_a = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_amazonas_re",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0033a",
				place = 3,--15,
				tt_title = _("TOWER_BARRACK_AMAZONAS_NAME"),
				tt_desc = _("TOWER_BARRACK_AMAZONAS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_canibal",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "canibal_0004",
				place = 11,
				tt_title = _("TOWER_BARRACK_CANIBAL_NAME"),
				tt_desc = _("TOWER_BARRACK_CANIBAL_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_aladdin_lamp_holder",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_0001",
				place = 12,
				tt_title = _("ALADDIN_LAMP_NAME"),
				tt_desc = _("ALADDIN_LAMP_DESCRIPTION")
			},							
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_mercenaries_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_00aa",
				place = 1,
				tt_title = _("TOWER_BARRACK_MERCENARIES_NAME"),
				tt_desc = _("TOWER_BARRACK_MERCENARIES_DESCRIPTION")
			},							
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_captain",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0031a",
				place = 2,
				tt_title = _("TOWER_BARRACK_PIRATES_NAME"),
				tt_desc = _("TOWER_BARRACK_PIRATES_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = "g2_tower_barrack_3_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},			
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g2_tower_barrack_3_b = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_dwarf_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "special_icons_0201",
				place = 3,
				tt_title = _("SPECIAL_DWARF_HALL_NAME"),
				tt_desc = _("SPECIAL_DWARF_HALL_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_assassin",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0024",
				place = 1,--11,
				tt_title = _("TOWER_ASSASSIN_NAME"),
				tt_desc = _("TOWER_ASSASSIN_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_templar",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0023",
				place = 2,--12,
				tt_title = _("TOWER_TEMPLAR_NAME"),
				tt_desc = _("TOWER_TEMPLAR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g2_tower_barrack_3_a",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_PAGE_NAME"),
				tt_desc = _("TOWER_NEXT_PAGE_DESCRIPTION")
			},			
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	---lamp
	aladdin_lamp_holder = {
	    {
		    {
	            check = "main_icons_0019",
	            action_arg = "tower_aladdin_lamp_2",
	            action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_vampiress_0001",
				place = 3,
				tt_title = _("HERO_VAMPIRESS_NAME"),
				tt_desc = _("HERO_VAMPIRESS_DESCRIPTION")
			},
		    {
	            check = "main_icons_0019",
	            action_arg = "tower_aladdin_lamp_3",
	            action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_steam_frigate_0001",
				place = 4,
				tt_title = _("HERO_STEAM_FRIGATE_NAME"),
				tt_desc = _("HERO_STEAM_FRIGATE_DESCRIPTION")
			},			
			{
	            check = "main_icons_0019",
	            action_arg = "tower_aladdin_lamp_5",
	            action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_baby_malik_0001",
				place = 11,
				tt_title = _("HERO_ELVES_MALIK_NAME"),
				tt_desc = _("HERO_ELVES_MALIK_DESCRIPTION")
			},
			{
	            check = "main_icons_0019",
	            action_arg = "tower_aladdin_lamp_6",
	            action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_bolverk_0001",
				place = 12,
				tt_title = _("HERO_ELVES_BOLVERK_NAME"),
				tt_desc = _("HERO_ELVES_BOLVERK_DESCRIPTION")
			},			
	        {
	            check = "main_icons_0019",
	            action_arg = "tower_aladdin_lamp_1",
	            action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_dwarf_0001",
				place = 1,
				tt_title = _("HERO_DWARF_NAME"),
				tt_desc = _("HERO_DWARF_DESCRIPTION")
			},					
		    {
	            check = "main_icons_0019",
	            action_arg = "tower_aladdin_lamp",
	            action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_munra_0001",
				place = 2,
				tt_title = _("HERO_MUNRA_NAME"),
				tt_desc = _("HERO_MUNRA_DESCRIPTION")
			},							
		    {
	            check = "main_icons_0019",
	            action_arg = "tower_aladdin_lamp_4",
	            action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "aladdin_lamp_alleria_g3_0001",
				place = 5,
				tt_title = _("HERO_ARCHER_NAME"),
				tt_desc = _("HERO_ARCHER_1_DESCRIPTION")
			},																				
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},		
	aladdin_lamp = {
	    {
		    {
	            check = "main_icons_0019",
	            action_arg = "hero_munra_2",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "aladdin_lamp_munra_0001",
				place = 5,
				tt_title = _("HERO_MUNRA_NAME"),
				tt_desc = _("HERO_MUNRA_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},	
	aladdin_lamp_1 = {
	    {
	        {
	            check = "main_icons_0019",
	            action_arg = "hero_dwarf_2",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "aladdin_lamp_dwarf_0001",
				place = 5,
				tt_title = _("HERO_DWARF_NAME"),
				tt_desc = _("HERO_DWARF_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},		
	aladdin_lamp_2 = {
	    {
		    {
	            check = "main_icons_0019",
	            action_arg = "hero_vampiress_2",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "aladdin_lamp_vampiress_0001",
				place = 5,
				tt_title = _("HERO_VAMPIRESS_NAME"),
				tt_desc = _("HERO_VAMPIRESS_DESCRIPTION")
			},		
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	aladdin_lamp_3 = {
	    {
		    {
	            check = "main_icons_0019",
	            action_arg = "hero_steam_frigate_2",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "aladdin_lamp_steam_frigate_0001",
				place = 5,
				tt_title = _("HERO_STEAM_FRIGATE_NAME"),
				tt_desc = _("HERO_STEAM_FRIGATE_DESCRIPTION")
			},		
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	aladdin_lamp_4 = {
	    {	
		    {
	            check = "main_icons_0019",
	            action_arg = "hero_alleria_g3_2",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "aladdin_lamp_alleria_g3_0001",
				place = 5,
				tt_title = _("HERO_ARCHER_NAME"),
				tt_desc = _("HERO_ARCHER_1_DESCRIPTION")
			},		
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},	
	aladdin_lamp_5 = {
	    {	
		    {
	            check = "main_icons_0019",
	            action_arg = "hero_baby_malik_2",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "aladdin_lamp_baby_malik_0001",
				place = 5,
				tt_title = _("HERO_ELVES_MALIK_NAME"),
				tt_desc = _("HERO_ELVES_MALIK_DESCRIPTION")
			},		
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	aladdin_lamp_6 = {
	    {	
		    {
	            check = "main_icons_0019",
	            action_arg = "hero_bolverk_2",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "aladdin_lamp_bolverk_0001",
				place = 5,
				tt_title = _("HERO_ELVES_BOLVERK_NAME"),
				tt_desc = _("HERO_ELVES_BOLVERK_DESCRIPTION")
			},		
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},							
	assassin = {
		{
			{
				action = "upgrade_power",
				action_arg = "sneak",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0024",
				place = 6,
				sounds = {
					"AssassinTauntSneak",
				},
				tt_phrase = _("TOWER_ASSASSIN_SNEAK_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ASSASSIN_SNEAK_NAME_1"),
						tt_desc = _("TOWER_ASSASSIN_SNEAK_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_ASSASSIN_SNEAK_NAME_2"),
						tt_desc = _("TOWER_ASSASSIN_SNEAK_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_ASSASSIN_SNEAK_NAME_3"),
						tt_desc = _("TOWER_ASSASSIN_SNEAK_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "pickpocket",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0022",
				place = 7,
				sounds = {
					"AssassinTauntGold",
				},
				tt_phrase = _("TOWER_ASSASSIN_PICK_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ASSASSIN_PICK_NAME_1"),
						tt_desc = _("TOWER_ASSASSIN_PICK_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_ASSASSIN_PICK_NAME_2"),
						tt_desc = _("TOWER_ASSASSIN_PICK_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_ASSASSIN_PICK_NAME_3"),
						tt_desc = _("TOWER_ASSASSIN_PICK_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "counter",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0023",
				place = 5,
				sounds = {
					"AssassinTauntCounter",
				},
				tt_phrase = _("TOWER_ASSASSIN_COUNTER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ASSASSIN_COUNTER_NAME_1"),
						tt_desc = _("TOWER_ASSASSIN_COUNTER_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_ASSASSIN_COUNTER_NAME_2"),
						tt_desc = _("TOWER_ASSASSIN_COUNTER_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_ASSASSIN_COUNTER_NAME_3"),
						tt_desc = _("TOWER_ASSASSIN_COUNTER_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	templar = {
		{
			{
				action = "upgrade_power",
				action_arg = "holygrail",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0025",
				place = 7,
				sounds = {
					"TemplarTauntTauntOne",
				},
				tt_phrase = _("TOWER_TEMPLAR_HOLY_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TEMPLAR_HOLY_NAME_1"),
						tt_desc = _("TOWER_TEMPLAR_HOLY_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_TEMPLAR_HOLY_NAME_2"),
						tt_desc = _("TOWER_TEMPLAR_HOLY_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_TEMPLAR_HOLY_NAME_3"),
						tt_desc = _("TOWER_TEMPLAR_HOLY_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "extralife",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0027",
				place = 6,
				sounds = {
					"TemplarTauntTauntTwo",
				},
				tt_phrase = _("TOWER_TEMPLAR_TOUGHNESS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TEMPLAR_TOUGHNESS_NAME_1"),
						tt_desc = _("TOWER_TEMPLAR_TOUGHNESS_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_TEMPLAR_TOUGHNESS_NAME_2"),
						tt_desc = _("TOWER_TEMPLAR_TOUGHNESS_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_TEMPLAR_TOUGHNESS_NAME_3"),
						tt_desc = _("TOWER_TEMPLAR_TOUGHNESS_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "blood",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0026",
				place = 5,
				sounds = {
					"TemplarTauntThree",
				},
				tt_phrase = _("TOWER_TEMPLAR_ARTERIAL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TEMPLAR_ARTERIAL_NAME_1"),
						tt_desc = _("TOWER_TEMPLAR_ARTERIAL_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_TEMPLAR_ARTERIAL_NAME_2"),
						tt_desc = _("TOWER_TEMPLAR_ARTERIAL_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_TEMPLAR_ARTERIAL_NAME_3"),
						tt_desc = _("TOWER_TEMPLAR_ARTERIAL_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	dwaarp = {
		{
			{
				action = "upgrade_power",
				action_arg = "drill",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0036",
				place = 1,
				sounds = {
					"EarthquakeTauntDrill",
				},
				tt_phrase = _("TOWER_DWAARP_DRILL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DWAARP_DRILL_NAME_1"),
						tt_desc = _("TOWER_DWAARP_DRILL_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_DWAARP_DRILL_NAME_2"),
						tt_desc = _("TOWER_DWAARP_DRILL_DESCRIPTION_2_NOFMT"),
					},
					{
						tt_title = _("TOWER_DWAARP_DRILL_NAME_3"),
						tt_desc = _("TOWER_DWAARP_DRILL_DESCRIPTION_3_NOFMT"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "lava",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0037",
				place = 2,
				sounds = {
					"EarthquakeTauntScorched",
				},
				tt_phrase = _("TOWER_DWAARP_BLAST_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DWAARP_BLAST_NAME_1"),
						tt_desc = _("TOWER_DWAARP_BLAST_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_DWAARP_BLAST_NAME_2"),
						tt_desc = _("TOWER_DWAARP_BLAST_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_DWAARP_BLAST_NAME_3"),
						tt_desc = _("TOWER_DWAARP_BLAST_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	mecha = {
		{
			{
				action = "upgrade_power",
				action_arg = "missile",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0038",
				place = 1,
				sounds = {
					"MechTauntMissile",
				},
				tt_phrase = _("TOWER_MECH_MISSILE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MECH_MISSILE_NAME_1"),
						tt_desc = _("TOWER_MECH_MISSILE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_MECH_MISSILE_NAME_2"),
						tt_desc = _("TOWER_MECH_MISSILE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_MECH_MISSILE_NAME_2"),
						tt_desc = _("TOWER_MECH_MISSILE_DESCRIPTION_2"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "oil",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0039",
				place = 2,
				sounds = {
					"MechTauntSlow",
				},
				tt_phrase = _("TOWER_MECH_WASTE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MECH_WASTE_NAME_1"),
						tt_desc = _("TOWER_MECH_WASTE_DESCRIPTION_1_NOFMT"),
					},
					{
						tt_title = _("TOWER_MECH_WASTE_NAME_2"),
						tt_desc = _("TOWER_MECH_WASTE_DESCRIPTION_2_NOFMT"),
					},
					{
						tt_title = _("TOWER_MECH_WASTE_NAME_3"),
						tt_desc = _("TOWER_MECH_WASTE_DESCRIPTION_3_NOFMT"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	crossbow = {
		{
			{
				action = "upgrade_power",
				action_arg = "multishot",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0028",
				place = 1,
				sounds = {
					"CrossbowTauntMultishoot",
				},
				tt_phrase = _("TOWER_CROSSBOW_BARRAGE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_CROSSBOW_BARRAGE_NAME_1"),
						tt_desc = _("TOWER_CROSSBOW_BARRAGE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_CROSSBOW_BARRAGE_NAME_2"),
						tt_desc = _("TOWER_CROSSBOW_BARRAGE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_CROSSBOW_BARRAGE_NAME_3"),
						tt_desc = _("TOWER_CROSSBOW_BARRAGE_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "eagle",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0029",
				place = 2,
				sounds = {
					"CrossbowTauntEagle",
				},
				tt_phrase = _("TOWER_CROSSBOW_FALCONER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_CROSSBOW_FALCONER_NAME_1"),
						tt_desc = _("TOWER_CROSSBOW_FALCONER_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_CROSSBOW_FALCONER_NAME_2"),
						tt_desc = _("TOWER_CROSSBOW_FALCONER_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_CROSSBOW_FALCONER_NAME_3"),
						tt_desc = _("TOWER_CROSSBOW_FALCONER_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	totem = {
		{
			{
				action = "upgrade_power",
				action_arg = "weakness",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0030",
				place = 1,
				sounds = {
					"TotemTauntTotemOne",
				},
				tt_phrase = _("TOWER_TOTEM_WEAKNESS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TOTEM_WEAKNESS_NAME_1"),
						tt_desc = _("TOWER_TOTEM_WEAKNESS_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_TOTEM_WEAKNESS_NAME_2"),
						tt_desc = _("TOWER_TOTEM_WEAKNESS_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_TOTEM_WEAKNESS_NAME_3"),
						tt_desc = _("TOWER_TOTEM_WEAKNESS_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "silence",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0031",
				place = 2,
				sounds = {
					"TotemTauntTotemTwo",
				},
				tt_phrase = _("TOWER_TOTEM_SPIRITS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TOTEM_SPIRITS_NAME_1"),
						tt_desc = _("TOWER_TOTEM_SPIRITS_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_TOTEM_SPIRITS_NAME_2"),
						tt_desc = _("TOWER_TOTEM_SPIRITS_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_TOTEM_SPIRITS_NAME_3"),
						tt_desc = _("TOWER_TOTEM_SPIRITS_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	archmage = {
		{
			{
				action = "upgrade_power",
				action_arg = "twister",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0032",
				place = 1,
				sounds = {
					"ArchmageTauntTwister",
				},
				tt_phrase = _("TOWER_ARCHMAGE_TWISTER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCHMAGE_TWISTER_NAME_1"),
						tt_desc = _("TOWER_ARCHMAGE_TWISTER_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_ARCHMAGE_TWISTER_NAME_2"),
						tt_desc = _("TOWER_ARCHMAGE_TWISTER_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_ARCHMAGE_TWISTER_NAME_3"),
						tt_desc = _("TOWER_ARCHMAGE_TWISTER_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "blast",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0033",
				place = 2,
				sounds = {
					"ArchmageTauntExplosion",
				},
				tt_phrase = _("TOWER_ARCHMAGE_CRITICAL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCHMAGE_CRITICAL_NAME_1"),
						tt_desc = _("TOWER_ARCHMAGE_CRITICAL_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_ARCHMAGE_CRITICAL_NAME_2"),
						tt_desc = _("TOWER_ARCHMAGE_CRITICAL_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_ARCHMAGE_CRITICAL_NAME_3"),
						tt_desc = _("TOWER_ARCHMAGE_CRITICAL_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	necromancer = {
		{
			{
				action = "upgrade_power",
				action_arg = "pestilence",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0035",
				place = 1,
				sounds = {
					"NecromancerTauntPestilence",
				},
				tt_phrase = _("TOWER_NECROMANCER_PESTILENCE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_NECROMANCER_PESTILENCE_NAME_1"),
						tt_desc = _("TOWER_NECROMANCER_PESTILENCE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_NECROMANCER_PESTILENCE_NAME_2"),
						tt_desc = _("TOWER_NECROMANCER_PESTILENCE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_NECROMANCER_PESTILENCE_NAME_3"),
						tt_desc = _("TOWER_NECROMANCER_PESTILENCE_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "rider",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0034",
				place = 2,
				sounds = {
					"NecromancerTauntDeath_Knight",
				},
				tt_phrase = _("TOWER_NECROMANCER_RIDER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_NECROMANCER_RIDER_NAME_1"),
						tt_desc = _("TOWER_NECROMANCER_RIDER_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_NECROMANCER_RIDER_NAME_2"),
						tt_desc = _("TOWER_NECROMANCER_RIDER_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_NECROMANCER_RIDER_NAME_3"),
						tt_desc = _("TOWER_NECROMANCER_RIDER_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	archer_hammerhold = {},
	archer_hammerhold_1 = {
		{
	        {
				check = "main_icons_0019",
				action_arg = "g2_tower_archer_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_ARCHER_2_NAME"),
				tt_desc = _("TOWER_ARCHER_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
	},
	mercenaries_desert = {
		{
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_legionnaire",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0029",
				place = 1,
				tt_title = _("SPECIAL_LEGIONNAIRE_NAME"),
				tt_desc = _("SPECIAL_LEGIONNAIRE_DESCRIPTION"),
			},
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_djinn",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0030",
				place = 2,
				tt_title = _("SPECIAL_DJINN_NAME"),
				tt_desc = _("SPECIAL_DJINN_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	mercenaries_desert_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_legionnaire",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0029",
				place = 1,
				tt_title = _("SPECIAL_LEGIONNAIRE_NAME"),
				tt_desc = _("SPECIAL_LEGIONNAIRE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "soldier_djinn",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0030",
				place = 2,
				tt_title = _("SPECIAL_DJINN_NAME"),
				tt_desc = _("SPECIAL_DJINN_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g2_tower_barrack_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_3_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_3_DESCRIPTION"),
			},			
			{
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	mercenaries_pirates_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_pirate_anchor",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0038",
				place = 3,
				tt_title = _("SPECIAL_PIRATE_ANCHOR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_ANCHOR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "soldier_pirate_captain",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0031",
				place = 1,
				tt_title = _("SPECIAL_PIRATE_CORSAIR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_CORSAIR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "soldier_pirate_flamer",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0032",
				place = 2,
				tt_title = _("SPECIAL_PIRATE_FLAMER_NAME"),
				tt_desc = _("SPECIAL_PIRATE_FLAMER_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "g2_tower_barrack_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_3_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_3_DESCRIPTION"),
			},			
			{
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	mercenaries_pirates_w_flamer = {
		{
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_pirate_captain",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0031",
				place = 1,
				tt_title = _("SPECIAL_PIRATE_CORSAIR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_CORSAIR_DESCRIPTION"),
			},
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_pirate_flamer",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0032",
				place = 2,
				tt_title = _("SPECIAL_PIRATE_FLAMER_NAME"),
				tt_desc = _("SPECIAL_PIRATE_FLAMER_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	mercenaries_pirates_w_anchor = {
		{
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_pirate_captain",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0031",
				place = 1,
				tt_title = _("SPECIAL_PIRATE_CORSAIR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_CORSAIR_DESCRIPTION"),
			},
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_pirate_anchor",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0038",
				place = 2,
				tt_title = _("SPECIAL_PIRATE_ANCHOR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_ANCHOR_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	pirate_camp = {
		{
			{
				action = "tw_buy_attack",
				action_arg = 1,
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0034",
				place = 6,
				tt_title = _("SPECIAL_PIRATE_CAP_CANNON_NAME_1"),
				tt_desc = _("SPECIAL_PIRATE_CAP_CANNON_DESCRIPTION_1"),
			},
			{
				action = "tw_buy_attack",
				action_arg = 2,
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0035",
				place = 5,
				tt_title = _("SPECIAL_PIRATE_CAP_CANNON_NAME_2"),
				tt_desc = _("SPECIAL_PIRATE_CAP_CANNON_DESCRIPTION_2"),
			},
			{
				action = "tw_buy_attack",
				action_arg = 3,
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0036",
				place = 7,
				tt_title = _("SPECIAL_PIRATE_CAP_CANNON_NAME_3"),
				tt_desc = _("SPECIAL_PIRATE_CAP_CANNON_DESCRIPTION_3"),
			},
		},
	},
	pirate_camp_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "main_icons_0034",
				place = 6,
				tt_title = _("SPECIAL_PIRATE_CAP_CANNON_NAME_1"),
				tt_desc = _("SPECIAL_PIRATE_CAP_CANNON_DESCRIPTION_1")
			},
			{
				check = "main_icons_0019",
				action_arg = 2,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "main_icons_0035",
				place = 5,
				tt_title = _("SPECIAL_PIRATE_CAP_CANNON_NAME_2"),
				tt_desc = _("SPECIAL_PIRATE_CAP_CANNON_DESCRIPTION_2")
			},
			{
				check = "main_icons_0019",
				action_arg = 3,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "main_icons_0036",
				place = 7,
				tt_title = _("SPECIAL_PIRATE_CAP_CANNON_NAME_3"),
				tt_desc = _("SPECIAL_PIRATE_CAP_CANNON_DESCRIPTION_3")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	mercenaries_amazonas = {
		{
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_amazona",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0033",
				place = 5,
				tt_title = _("SPECIAL_AMAZONAS_WARRIOR_NAME"),
				tt_desc = _("SPECIAL_AMAZONAS_WARRIOR_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	mercenaries_amazonas_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_amazona",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0033",
				place = 11,
				tt_title = _("SPECIAL_AMAZONAS_WARRIOR_NAME"),
				tt_desc = _("SPECIAL_AMAZONAS_WARRIOR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g2_tower_barrack_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_3_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_3_DESCRIPTION"),
			},			
			{
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	archer_dwarf = {
		{
			{
				action = "upgrade_power",
				action_arg = "barrel",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0044",
				place = 1,
				sounds = {
					"DwarfArcherTaunt1",
				},
				tt_phrase = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_DESCRIPTION_2"),
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "extra_damage",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0043",
				place = 2,
				sounds = {
					"DwarfArcherTaunt2",
				},
				tt_phrase = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_DESCRIPTION_2"),
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_DESCRIPTION_3"),
					},
				},
			},
		},
	},
	archer_dwarf_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "barrel",
				action = "upgrade_power",
				image = "special_icons_0044",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"DwarfArcherTaunt1"
				},
				tt_phrase = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_1_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "extra_damage",
				action = "upgrade_power",
				image = "special_icons_0043",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"DwarfArcherTaunt2"
				},
				tt_phrase = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_DWARF_TOWER1_UPGRADE_2_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	barrack_dwarf = {
		{
			{
				action = "upgrade_power",
				action_arg = "hammer",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0040",
				place = 5,
				sounds = {
					"DwarfTaunt",
				},
				tt_phrase = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_2"),
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_3"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "armor",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0041",
				place = 6,
				sounds = {
					"DwarfTaunt",
				},
				tt_phrase = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_DESCRIPTION_2"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "beer",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0042",
				place = 7,
				sounds = {
					"DwarfTaunt",
				},
				tt_phrase = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_DESCRIPTION_2"),
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NAME_3"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	barrack_dwarf_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "hammer",
				action = "upgrade_power",
				image = "special_icons_0040",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"DwarfTaunt"
				},
				tt_phrase = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_3"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "armor",
				action = "upgrade_power",
				image = "special_icons_0041",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"DwarfTaunt"
				},
				tt_phrase = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "beer",
				action = "upgrade_power",
				image = "special_icons_0042",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"DwarfTaunt"
				},
				tt_phrase = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_NAME_3"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_3_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	pirate_watchtower = {
		{
			{
				action = "upgrade_power",
				action_arg = "reduce_cooldown",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0045",
				place = 1,
				sounds = {
					"PirateTowerTaunt1",
				},
				tt_phrase = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_DESCRIPTION_2"),
					},
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "parrot",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0046",
				place = 2,
				sounds = {
					"PirateTowerTaunt2",
				},
				tt_phrase = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_DESCRIPTION_2"),
					},
				},
			},
		},
	},
	pirate_watchtower_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "reduce_cooldown",
				action = "upgrade_power",
				image = "special_icons_0045",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"PirateTowerTaunt1"
				},
				tt_phrase = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_1_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "parrot",
				action = "upgrade_power",
				image = "special_icons_0046",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"PirateTowerTaunt2"
				},
				tt_phrase = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_PIRATES_WATCHTOWER_UPGRADE_2_DESCRIPTION_2")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	holder_neptune = {
		{
			{
				action = "tw_upgrade",
				action_arg = "tower_neptune",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0015",
				place = 5,
				tt_title = _("SPECIAL_NEPTUNE_BROKEN_TOWER_FIX_NAME"),
				tt_desc = _("SPECIAL_NEPTUNE_BROKEN_TOWER_FIX_DESCRIPTION"),
			},
		},
	},
	holder_neptune_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_neptune_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0015",
				place = 5,
				tt_title = _("SPECIAL_NEPTUNE_BROKEN_TOWER_FIX_NAME"),
				tt_desc = _("SPECIAL_NEPTUNE_BROKEN_TOWER_FIX_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	neptune = {
		{
			{
				action = "upgrade_power",
				action_arg = "ray",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0047",
				place = 5,
				tt_list = {
					{
						tt_title = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_DESCRIPTION_1"),
					},
				},
			},
			{
				action = "tw_point",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0002",
				place = 8,
			},
		},
	},
	neptune_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "ray",
				action = "upgrade_power",
				halo = "glow_ico_special",
				image = "special_icons_0047",
				place = 5,
				tt_list = {
					{
						tt_title = _("TOWER_NEPTUNE_DESCRIPTION"),
						tt_desc = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_NEPTUNE_DESCRIPTION"),
						tt_desc = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_NEPTUNE_DESCRIPTION"),
						tt_desc = _("SPECIAL_NEPTUNE_TOWER_UPGRADE_DESCRIPTION_1")
					}
				}
			},
			{
				check = "sub_icons_0002",
				action = "tw_point",
				halo = "glow_ico_sub",
				image = "sub_icons_0002",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	frankenstein = {
		{
			{
				action = "upgrade_power",
				action_arg = "lightning",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0048",
				place = 1,
				sounds = {
					"HWFrankensteinUpgradeLightning",
				},
				tt_phrase = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_DESCRIPTION_2"),
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "frankie",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0049",
				place = 2,
				sounds = {
					"HWFrankensteinUpgradeFrankenstein",
				},
				tt_phrase = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_DESCRIPTION_2"),
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	frankenstein_d = {
		{
			{
				check = "special_icons_0020",
				action_arg = "lightning",
				action = "upgrade_power",
				image = "special_icons_0048",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"HWFrankensteinUpgradeLightning"
				},
				tt_phrase = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_1_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "frankie",
				action = "upgrade_power",
				image = "special_icons_0049",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"HWFrankensteinUpgradeFrankenstein"
				},
				tt_phrase = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_NAME"),
						tt_desc = _("SPECIAL_TOWER_FRANKENSTEIN_UPGRADE_2_DESCRIPTION_3")
					}
				}
			},
			{
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	--1代
	ranger = {
		{
			{
				action = "upgrade_power",
				action_arg = "poison",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0008",
				place = 1,
				sounds = {
					"ArcherRangerPoisonTaunt",
				},
				tt_phrase = _("TOWER_RANGERS_POISON_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_RANGERS_POISON_NAME_1"),
						tt_desc = _("TOWER_RANGERS_POISON_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_RANGERS_POISON_NAME_2"),
						tt_desc = _("TOWER_RANGERS_POISON_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_RANGERS_POISON_NAME_3"),
						tt_desc = _("TOWER_RANGERS_POISON_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "thorn",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0002",
				place = 2,
				sounds = {
					"ArcherRangerThornTaunt",
				},
				tt_phrase = _("TOWER_RANGERS_THORNS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_RANGERS_THORNS_NAME_1"),
						tt_desc = _("TOWER_RANGERS_THORNS_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_RANGERS_THORNS_NAME_2"),
						tt_desc = _("TOWER_RANGERS_THORNS_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_RANGERS_THORNS_NAME_3"),
						tt_desc = _("TOWER_RANGERS_THORNS_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	musketeer = {
		{
			{
				action = "upgrade_power",
				action_arg = "sniper",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0003",
				place = 1,
				sounds = {
					"ArcherMusketeerSniperTaunt",
				},
				tt_phrase = _("TOWER_MUSKETEERS_SNIPER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MUSKETEERS_SNIPER_NAME_1"),
						tt_desc = _("TOWER_MUSKETEERS_SNIPER_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_MUSKETEERS_SNIPER_NAME_2"),
						tt_desc = _("TOWER_MUSKETEERS_SNIPER_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_MUSKETEERS_SNIPER_NAME_3"),
						tt_desc = _("TOWER_MUSKETEERS_SNIPER_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "shrapnel",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0005",
				place = 2,
				sounds = {
					"ArcherMusketeerShrapnelTaunt",
				},
				tt_phrase = _("TOWER_MUSKETEERS_SHRAPNEL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_MUSKETEERS_SHRAPNEL_NAME_1"),
						tt_desc = _("TOWER_MUSKETEERS_SHRAPNEL_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_MUSKETEERS_SHRAPNEL_NAME_2"),
						tt_desc = _("TOWER_MUSKETEERS_SHRAPNEL_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_MUSKETEERS_SHRAPNEL_NAME_3"),
						tt_desc = _("TOWER_MUSKETEERS_SHRAPNEL_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	arcane_wizard = {
		{
			{
				action = "upgrade_power",
				action_arg = "disintegrate",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0015",
				place = 1,
				sounds = {
					"MageArcaneDesintegrateTaunt",
				},
				tt_phrase = _("TOWER_ARCANE_WIZARD_DESINTEGRATE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCANE_WIZARD_DESINTEGRATE_NAME_1"),
						tt_desc = _("TOWER_ARCANE_WIZARD_DESINTEGRATE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_DESINTEGRATE_NAME_2"),
						tt_desc = _("TOWER_ARCANE_WIZARD_DESINTEGRATE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_DESINTEGRATE_NAME_3"),
						tt_desc = _("TOWER_ARCANE_WIZARD_DESINTEGRATE_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "teleport",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0016",
				place = 2,
				sounds = {
					"MageArcaneTeleporthTaunt",
				},
				tt_phrase = _("TOWER_ARCANE_WIZARD_TELEPORT_NOTE_1"),
				tt_list = {
					{
						tt_title = _("TOWER_ARCANE_WIZARD_TELEPORT_NAME_1"),
						tt_desc = _("TOWER_ARCANE_WIZARD_TELEPORT_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_TELEPORT_NAME_2"),
						tt_desc = _("TOWER_ARCANE_WIZARD_TELEPORT_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_ARCANE_WIZARD_TELEPORT_NAME_3"),
						tt_desc = _("TOWER_ARCANE_WIZARD_TELEPORT_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	sorcerer = {
		{
			{
				action = "upgrade_power",
				action_arg = "polymorph",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0001",
				place = 1,
				sounds = {
					"Sheep",
				},
				tt_phrase = _("TOWER_SORCERER_POLIMORPH_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_SORCERER_POLIMORPH_NAME_1"),
						tt_desc = _("TOWER_SORCERER_POLIMORPH_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_SORCERER_POLIMORPH_NAME_2"),
						tt_desc = _("TOWER_SORCERER_POLIMORPH_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_SORCERER_POLIMORPH_NAME_3"),
						tt_desc = _("TOWER_SORCERER_POLIMORPH_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "elemental",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0004",
				place = 2,
				tt_phrase = _("TOWER_SORCERER_ELEMENTAL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_SORCERER_ELEMENTAL_NAME_1"),
						tt_desc = _("TOWER_SORCERER_ELEMENTAL_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_SORCERER_ELEMENTAL_NAME_2"),
						tt_desc = _("TOWER_SORCERER_ELEMENTAL_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_SORCERER_ELEMENTAL_NAME_3"),
						tt_desc = _("TOWER_SORCERER_ELEMENTAL_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	bfg = {
		{
			{
				action = "upgrade_power",
				action_arg = "missile",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0017",
				place = 1,
				sounds = {
					"EngineerBfgMissileTaunt",
				},
				tt_phrase = _("TOWER_BFG_MISSILE_NOTE_1"),
				tt_list = {
					{
						tt_title = _("TOWER_BFG_MISSILE_NAME_1"),
						tt_desc = _("TOWER_BFG_MISSILE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_BFG_MISSILE_NAME_2"),
						tt_desc = _("TOWER_BFG_MISSILE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_BFG_MISSILE_NAME_3"),
						tt_desc = _("TOWER_BFG_MISSILE_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "cluster",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0018",
				place = 2,
				sounds = {
					"EngineerBfgClusterTaunt",
				},
				tt_phrase = _("TOWER_BFG_CLUSTER_NOTE_1"),
				tt_list = {
					{
						tt_title = _("TOWER_BFG_CLUSTER_NAME_1"),
						tt_desc = _("TOWER_BFG_CLUSTER_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_BFG_CLUSTER_NAME_2"),
						tt_desc = _("TOWER_BFG_CLUSTER_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_BFG_CLUSTER_NAME_3"),
						tt_desc = _("TOWER_BFG_CLUSTER_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	tesla = {
		{
			{
				action = "upgrade_power",
				action_arg = "bolt",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0011",
				place = 1,
				sounds = {
					"EngineerTeslaChargedBoltTaunt",
				},
				tt_phrase = _("TOWER_TESLA_CHARGED_BOLT_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TESLA_CHARGED_BOLT_NAME_1"),
						tt_desc = _("TOWER_TESLA_CHARGED_BOLT_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_TESLA_CHARGED_BOLT_NAME_2"),
						tt_desc = _("TOWER_TESLA_CHARGED_BOLT_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_TESLA_CHARGED_BOLT_NAME_3"),
						tt_desc = _("TOWER_TESLA_CHARGED_BOLT_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "overcharge",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0010",
				place = 2,
				sounds = {
					"EngineerTeslaOverchargeTaunt",
				},
				tt_phrase = _("TOWER_TESLA_OVERCHARGE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TESLA_OVERCHARGE_NAME_1"),
						tt_desc = _("TOWER_TESLA_OVERCHARGE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_TESLA_OVERCHARGE_NAME_2"),
						tt_desc = _("TOWER_TESLA_OVERCHARGE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_TESLA_OVERCHARGE_NAME_3"),
						tt_desc = _("TOWER_TESLA_OVERCHARGE_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	paladin = {
		{
			{
				action = "upgrade_power",
				action_arg = "healing",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0007",
				place = 6,
				sounds = {
					"BarrackPaladinHealingTaunt",
				},
				tt_phrase = _("TOWER_PALADINS_HEALING_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_PALADINS_HEALING_NAME_1"),
						tt_desc = _("TOWER_PALADINS_HEALING_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_PALADINS_HEALING_NAME_2"),
						tt_desc = _("TOWER_PALADINS_HEALING_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_PALADINS_HEALING_NAME_3"),
						tt_desc = _("TOWER_PALADINS_HEALING_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "shield",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0009",
				place = 5,
				sounds = {
					"BarrackPaladinShieldTaunt",
				},
				tt_phrase = _("TOWER_PALADINS_SHIELD_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_PALADINS_SHIELD_NAME_1"),
						tt_desc = _("TOWER_PALADINS_SHIELD_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_PALADINS_SHIELD_NAME_2"),
						tt_desc = _("TOWER_PALADINS_SHIELD_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_PALADINS_SHIELD_NAME_3"),
						tt_desc = _("TOWER_PALADINS_SHIELD_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "holystrike",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0006",
				place = 7,
				sounds = {
					"BarrackPaladinHolyStrikeTaunt",
				},
				tt_phrase = _("TOWER_PALADINS_HOLY_STRIKE_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_PALADINS_HOLY_STRIKE_NAME_1"),
						tt_desc = _("TOWER_PALADINS_HOLY_STRIKE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_PALADINS_HOLY_STRIKE_NAME_2"),
						tt_desc = _("TOWER_PALADINS_HOLY_STRIKE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_PALADINS_HOLY_STRIKE_NAME_3"),
						tt_desc = _("TOWER_PALADINS_HOLY_STRIKE_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	barbarian = {
		{
			--[[
			{
				check = "special_icons_0020",
				action_arg = "nets",
				action = "upgrade_power",
				image = "barbarian_net_icon_0001",
				place = 3,
				halo = "glow_ico_special",
				sounds = {
					"BarrackBarbarianTwisterTaunt"
				},
				tt_phrase = _("TOWER_BARBARIANS_HUNTING_NETS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BARBARIANS_HUNTING_NETS_NAME_1"),
						tt_desc = _("TOWER_BARBARIANS_HUNTING_NETS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_BARBARIANS_HUNTING_NETS_NAME_2"),
						tt_desc = _("TOWER_BARBARIANS_HUNTING_NETS_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_BARBARIANS_HUNTING_NETS_NAME_3"),
						tt_desc = _("TOWER_BARBARIANS_HUNTING_NETS_DESCRIPTION_3")
					}
				}
			},
			]]
			{
				action = "upgrade_power",
				action_arg = "dual",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0012",
				place = 6,
				sounds = {
					"BarrackBarbarianDoubleAxesTaunt",
				},
				tt_phrase = _("TOWER_BARBARIANS_DOUBLE_AXE_NOTE_1"),
				tt_list = {
					{
						tt_title = _("TOWER_BARBARIANS_DOUBLE_AXE_NAME_1"),
						tt_desc = _("TOWER_BARBARIANS_DOUBLE_AXE_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_BARBARIANS_DOUBLE_AXE_NAME_2"),
						tt_desc = _("TOWER_BARBARIANS_DOUBLE_AXE_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_BARBARIANS_DOUBLE_AXE_NAME_3"),
						tt_desc = _("TOWER_BARBARIANS_DOUBLE_AXE_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "twister",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0013",
				place = 5,
				sounds = {
					"BarrackBarbarianTwisterTaunt",
				},
				tt_phrase = _("TOWER_BARBARIANS_TWISTER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_BARBARIANS_TWISTER_NAME_1"),
						tt_desc = _("TOWER_BARBARIANS_TWISTER_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_BARBARIANS_TWISTER_NAME_2"),
						tt_desc = _("TOWER_BARBARIANS_TWISTER_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_BARBARIANS_TWISTER_NAME_3"),
						tt_desc = _("TOWER_BARBARIANS_TWISTER_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "throwing",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_0019",
				place = 7,
				sounds = {
					"BarrackBarbarianThrowingAxesTaunt",
				},
				tt_phrase = _("TOWER_BARBARIANS_THROWING_AXES_NOTE_1"),
				tt_list = {
					{
						tt_title = _("TOWER_BARBARIANS_THROWING_AXES_NAME_1"),
						tt_desc = _("TOWER_BARBARIANS_THROWING_AXES_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_BARBARIANS_THROWING_AXES_NAME_2"),
						tt_desc = _("TOWER_BARBARIANS_THROWING_AXES_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_BARBARIANS_THROWING_AXES_NAME_3"),
						tt_desc = _("TOWER_BARBARIANS_THROWING_AXES_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	holder_elf = {
		{
			{
				action = "tw_upgrade",
				action_arg = "tower_elf",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0015",
				place = 5,
				tt_title = _("SPECIAL_ELF_REPAIR_NAME"),
				tt_desc = _("SPECIAL_ELF_REPAIR_DESCRIPTION"),
			},
		},
	},
	elf = {
		{
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_elf",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0016",
				place = 5,
				tt_title = _("SPECIAL_ELF_NAME"),
				tt_desc = _("SPECIAL_ELF_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	elf_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_elf",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_0016",
				place = 11,
				tt_title = _("SPECIAL_ELF_D_NAME"),
				tt_desc = _("SPECIAL_ELF_D_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARRACK_3_NAME"),
				tt_desc = _("TOWER_BARRACK_3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	holder_sasquash = {
		{
			{
				action = "tw_none",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0017",
				place = 5,
				tt_title = _("SPECIAL_ELF_REPAIR_NAME"),
				tt_desc = _("SPECIAL_ELF_REPAIR_DESCRIPTION"),
			},
		},
	},
	sasquash = {
		{
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_sasquash",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0017",
				place = 5,
				tt_title = _("SPECIAL_SASQUASH_NAME"),
				tt_desc = _("SPECIAL_SASQUASH_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
		},
	},
	sasquash_d = {
		{
			{
				action = "tw_buy_soldier",
				action_arg = "soldier_sasquash",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0017",
				place = 11,
				tt_title = _("SPECIAL_SASQUASH_NAME"),
				tt_desc = _("SPECIAL_SASQUASH_DESCRIPTION"),
			},
			{
				action = "tw_upgrade",
				action_arg = "g1_tower_barrack_3",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("G2_TOWER_BARRACK_3_NAME"),
				tt_desc = _("G2_TOWER_BARRACK_3_DESCRIPTION"),
			},			
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	sunray = {
		{
			{
				action = "upgrade_power",
				action_arg = "ray",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0018",
				no_upgrade_lights = true,
				place = 5,
				sounds = {
					"MageSorcererAshesToAshesTaunt",
				},
				tt_phrase = _("SPECIAL_SUNRAY_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1"),
					},
				},
			},
			{
				action = "tw_point",
				check = "sub_icons_0002",
				halo = "glow_ico_sub",
				image = "sub_icons_0002",
				place = 8,
			},
		},
	},
	sunray_d = {
		{
			{
				check = "main_icons_0019",
				action = "upgrade_power",
				no_upgrade_lights = true,
				image = "main_icons_0018",
				action_arg = "ray",
				place = 5,
				halo = "glow_ico_main",
				sounds = {
					"MageSorcererAshesToAshesTaunt"
				},
				tt_phrase = _("SPECIAL_SUNRAY_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_SUNRAY_UPGRADE_NAME"),
						tt_desc = _("SPECIAL_SUNRAY_UPGRADE_DESCRIPTION_1")
					}
				}
			},
			{
				check = "sub_icons_0002",
				action = "tw_point",
				halo = "glow_ico_sub",
				image = "sub_icons_0002",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	goldbuy = {
		{
			{
				check = "main_icons_0019",
				action_arg = "goldenfinger_cheat_3",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_buy3_0019",
				place = 1,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT_3")
			},
			{
				check = "main_icons_0019",
				action_arg = "goldenfinger_cheat",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_buy1_0019",
				place = 5,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT_1")
			},
			{
				check = "main_icons_0019",
				action_arg = "goldenfinger_cheat_2",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_buy2_0019",
				place = 2,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT_2")
			},
			{
				check = "main_icons_0019",
				action_arg = "goldenfinger_cheat_7",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_buy7_0019",
				place = 12,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT_7")
			},
			{
				check = "main_icons_0019",
				action_arg = "goldenfinger_cheat_5",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_buy5_0019",
				place = 11,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT_5")
			},
			{
				check = "main_icons_0019",
				action_arg = "goldenfinger_cheat_4",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_buy4_0019",
				place = 3,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT_4")
			},
			{
				check = "main_icons_0019",
				action_arg = "goldenfinger_cheat_6",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_buy6_0019",
				place = 4,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT_6")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_hero_buy",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 10,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	g5_special_buy = {
		{
			{
				check = "main_icons_0019",
				action_arg = "g5_special_tower",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 3,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g5_special_elemental",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 4,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},		
			{
				check = "main_icons_0019",
				action_arg = "tower_hero_buy_c",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 1,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_hero_buy_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 2,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},	
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},			
		}
		
	},
	---特殊塔
	g5_special_tower = {
		{						
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_17_weirdwood_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0110",
				place = 3,
				tt_title = _("TOWER_ENTWOOD_NAME"),
				tt_desc = _("TOWER_ENTWOOD_DESCRIPTION")
			},								
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_18_elven_barrack_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0033",
				place = 4,
				tt_title = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_1_NAME"),
				tt_desc = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_1_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_28_priests_barrack",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0041",
				place = 11,
				tt_title = _("SPECIAL_PRIESTS_SOLDIERS_NAME"),
				tt_desc = _("TOWER_STAGE_28_PRIESTS_BARRACK_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_13_sunray_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0030",
				place = 12,
				tt_title = _("TOWER_STAGE_13_SUNRAY_REPAIR_NAME"),
				tt_desc = _("TOWER_STAGE_13_SUNRAY_REPAIR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_20_arborean_honey_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0037",
				place = 13,
				tt_title = _("SPECIAL_ARBOREAN_HONEY_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_HONEY_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_20_arborean_oldtree_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0038",
				place = 19,
				tt_title = _("SPECIAL_ARBOREAN_OLDTREE_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_OLDTREE_DESCRIPTION")
			},						
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_22_arborean_mages_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0038",
				place = 1,
				tt_title = _("TOWER_STAGE_22_ARBOREAN_MAGES_NAME"),
				tt_desc = _("TOWER_STAGE_22_ARBOREAN_MAGES_NAME")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_stage_20_arborean_barrack_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0036",
				place = 2,
				tt_title = _("SPECIAL_ARBOREAN_BARRACK_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_BARRACK_DESCRIPTION")
			},							
			{
				check = "main_icons_0019",
				action_arg = "tower_arborean_sentinels_d",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0105",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_SENTINELS_SPEARMEN_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_SENTINELS_SPEARMEN_DESCRIPTION")
			},			
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},			
		}

	},
	---龙魂宝壶
	g5_special_elemental = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_blocked_elemental_water_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0046",
				place = 3,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WATER_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WATER_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_blocked_elemental_metal_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0047",
				place = 4,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_METAL_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_METAL_DESCRIPTION")
			},				
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_blocked_elemental_wood_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0045",
				place = 6,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WOOD_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WOOD_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_blocked_elemental_earth_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0050",
				place = 7,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_EARTH_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_EARTH_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_blocked_elemental_fire_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0044",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_FIRE_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_FIRE_DESCRIPTION")
			},				
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		}
	},
	---
	tower_priests_barrack = {
		{
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
		}
	},
	hero_buy = {
	    {
			{
				check = "main_icons_0019",
				action_arg = 19,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0019",
				place = 24,
				tt_title = _("HERO_ARCHER_NAME"),
				tt_desc = _("HERO_ARCHER_1_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 16,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0016",
				place = 21,
				tt_title = _("HERO_ELVES_BRUCE_NAME"),
				tt_desc = _("HERO_ELVES_BRUCE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 7,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0007",
				place = 4,
				tt_title = _("HERO_ELVES_PIXIE_NAME"),
				tt_desc = _("HERO_ELVES_PIXIE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 13,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0013",
				place = 18,
				tt_title = _("HERO_ELVES_GYRO_NAME"),
				tt_desc = _("HERO_ELVES_GYRO_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 10,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0010",
				place = 15,
				tt_title = _("HERO_ELVES_DURAX_NAME"),
				tt_desc = _("HERO_ELVES_DURAX_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 6,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0006",
				place = 3,
				tt_title = _("HERO_ELVES_PANDA_NAME"),
				tt_desc = _("HERO_ELVES_PANDA_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 18,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0018",
				place = 23,
				tt_title = _("HERO_ELVES_BOLVERK_NAME"),
				tt_desc = _("HERO_ELVES_BOLVERK_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 15,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0015",
				place = 20,
				tt_title = _("HERO_ELVES_FAUSTUS_NAME"),
				tt_desc = _("HERO_ELVES_FAUSTUS_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 5,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0005",
				place = 12,
				tt_title = _("HERO_ELVES_FOREST_ELEMENTAL_NAME"),
				tt_desc = _("HERO_ELVES_FOREST_ELEMENTAL_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 12,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0012",
				place = 17,
				tt_title = _("HERO_ELVES_LYNN_NAME"),
				tt_desc = _("HERO_ELVES_LYNN_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 9,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0009",
				place = 14,
				tt_title = _("HERO_ELVES_VEZNAN_NAME"),
				tt_desc = _("HERO_ELVES_VEZNAN_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 4,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0004",
				place = 11,
				tt_title = _("HERO_ELVES_ELDRITCH_NAME"),
				tt_desc = _("HERO_ELVES_ELDRITCH_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 17,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0017",
				place = 22,
				tt_title = _("HERO_ELVES_MALIK_NAME"),
				tt_desc = _("HERO_ELVES_MALIK_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 14,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0014",
				place = 19,
				tt_title = _("HERO_ELVES_PHOENIX_NAME"),
				tt_desc = _("HERO_ELVES_PHOENIX_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 3,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0003",
				place = 2,
				tt_title = _("HERO_ELVES_ELEMENTALIST_NAME"),
				tt_desc = _("HERO_ELVES_ELEMENTALIST_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 11,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0011",
				place = 16,
				tt_title = _("HERO_ELVES_FALLEN_ANGEL_NAME"),
				tt_desc = _("HERO_ELVES_FALLEN_ANGEL_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 8,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0008",
				place = 13,
				tt_title = _("HERO_ELVES_RAG_NAME"),
				tt_desc = _("HERO_ELVES_RAG_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 2,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0002",
				place = 1,
				tt_title = _("HERO_ELVES_DENAS_NAME"),
				tt_desc = _("HERO_ELVES_DENAS_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0001",
				place = 5,
				tt_title = _("HERO_ELVES_ARCHER_NAME"),
				tt_desc = _("HERO_ELVES_ARCHER_DESCRIPTION")
			},																																														
			{
				check = "main_icons_0019",
				action_arg = "tower_hero_buy_a",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 10,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},						
		}
	},
	hero_buy_a = {
	    {
			{
				check = "main_icons_0019",
				action_arg = 19,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0119",
				place = 24,
				tt_title = _("HERO_VAMPIRESS_NAME"),
				tt_desc = _("HERO_VAMPIRESS_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 16,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0116",
				place = 21,
				tt_title = _("HERO_MONKEY_GOD_NAME"),
				tt_desc = _("HERO_MONKEY_GOD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 7,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0107",
				place = 4,
				tt_title = _("HERO_BEASTMASTER_NAME"),
				tt_desc = _("HERO_BEASTMASTER_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 13,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0113",
				place = 18,
				tt_title = _("HERO_VAN_HELSING_NAME"),
				tt_desc = _("HERO_VAN_HELSING_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 10,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0110",
				place = 15,
				tt_title = _("HERO_DRAGON_NAME"),
				tt_desc = _("HERO_DRAGON_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 6,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0106",
				place = 3,
				tt_title = _("HERO_WIZARD_NAME"),
				tt_desc = _("HERO_WIZARD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 18,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0118",
				place = 23,
				tt_title = _("HERO_DWARF_NAME"),
				tt_desc = _("HERO_DWARF_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 15,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0115",
				place = 20,
				tt_title = _("HERO_MINOTAUR_NAME"),
				tt_desc = _("HERO_MINOTAUR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 5,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0105",
				place = 12,
				tt_title = _("HERO_GIANT_NAME"),
				tt_desc = _("HERO_GIANT_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 12,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0112",
				place = 17,
				tt_title = _("HERO_CRAB_NAME"),
				tt_desc = _("HERO_CRAB_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 9,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0109",
				place = 14,
				tt_title = _("HERO_PRIEST_NAME"),
				tt_desc = _("HERO_PRIEST_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 4,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0104",
				place = 11,
				tt_title = _("HERO_MIRAGE_NAME"),
				tt_desc = _("HERO_MIRAGE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 17,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0117",
				place = 22,
				tt_title = _("HERO_STEAM_FRIGATE_NAME"),
				tt_desc = _("HERO_STEAM_FRIGATE_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 14,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0114",
				place = 19,
				tt_title = _("HERO_VOODOO_WITCH_NAME"),
				tt_desc = _("HERO_VOODOO_WITCH_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 3,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0103",
				place = 2,
				tt_title = _("HERO_MONK_NAME"),
				tt_desc = _("HERO_MONK_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 11,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0111",
				place = 16,
				tt_title = _("HERO_PIRATE_NAME"),
				tt_desc = _("HERO_PIRATE_DESCRIPTION")
			},		
			{
				check = "main_icons_0019",
				action_arg = 8,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0108",
				place = 13,
				tt_title = _("HERO_ALIEN_NAME"),
				tt_desc = _("HERO_ALIEN_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 2,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0102",
				place = 1,
				tt_title = _("HERO_DRACOLICH_NAME"),
				tt_desc = _("HERO_DRACOLICH_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0101",
				place = 5,
				tt_title = _("HERO_ALRIC_NAME"),
				tt_desc = _("HERO_ALRIC_DESCRIPTION")
			},																																											
			{
				check = "main_icons_0019",
				action_arg = "tower_hero_buy_b",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 10,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},			
		}
	},
	hero_buy_b = {
	    {
			---
			{
				check = "main_icons_0019",
				action_arg = 14,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "info_volt_0001",
				place = 22,
				tt_phrase = _("HERO_VOLT_SPECIAL"),
				tt_title = _("HERO_VOLT_NAME"),
				tt_desc = _("HERO_VOLT_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 13,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0213",
				place = 21,
				tt_title = _("HERO_10YR_NAME"),
				tt_desc = _("HERO_10YR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 7,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0207",
				place = 4,
				tt_title = _("HERO_DENAS_NAME"),
				tt_desc = _("HERO_DENAS_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 10,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0210",
				place = 15,
				tt_title = _("HERO_SAMURAI_NAME"),
				tt_desc = _("HERO_SAMURAI_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 6,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0206",
				place = 3,
				tt_title = _("HERO_REINFORCEMENT_NAME"),
				tt_desc = _("HERO_REINFORCEMENT_DESCRIPTION")
			},							
			{
				check = "main_icons_0019",
				action_arg = 15,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "info_viper_0001",
				place = 23,
				tt_phrase = _("HERO_VIPER_SPECIAL"),
				tt_title = _("HERO_VIPER_NAME"),
				tt_desc = _("HERO_VIPER_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 12,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0212",
				place = 20,
				tt_title = _("HERO_THOR_NAME"),
				tt_desc = _("HERO_THOR_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 5,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0205",
				place = 12,
				tt_title = _("HERO_FIRE_NAME"),
				tt_desc = _("HERO_FIRE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 9,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0209",
				place = 14,
				tt_title = _("HERO_FROST_SORCERER_NAME"),
				tt_desc = _("HERO_FROST_SORCERER_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 4,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0204",
				place = 11,
				tt_title = _("HERO_MAGE_NAME"),
				tt_desc = _("HERO_MAGE_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 11,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0211",
				place = 19,
				tt_title = _("HERO_HACK_NAME"),
				tt_desc = _("HERO_HACK_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 3,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0203",
				place = 2,
				tt_title = _("HERO_PALADIN_NAME"),
				tt_desc = _("HERO_PALADIN_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 8,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0208",
				place = 13,
				tt_title = _("HERO_VIKING_NAME"),
				tt_desc = _("HERO_VIKING_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 2,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0202",
				place = 1,
				tt_title = _("HERO_RIFLEMAN_NAME"),
				tt_desc = _("HERO_RIFLEMAN_DESCRIPTION")
			},																						
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "special_hero_icons_0201",
				place = 5,
				tt_title = _("HERO_ARCHER_NAME"),
				tt_desc = _("HERO_ARCHER_DESCRIPTION")
			},			
			{
				check = "main_icons_0019",
				action_arg = "Goldfinger",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 10,
				tt_title = _("CHEAT"),
				tt_desc = _("CHEAT1")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},			
		}
	},
	hero_buy_c = {
	    {	
			{
				check = "main_icons_0019",
				action_arg = 16,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0016",
				place = 21,
				tt_title = _("HERO_LAVA_NAME"),
				tt_desc = _("HERO_LAVA_DESC")
			},	
			{
				check = "main_icons_0019",
				action_arg = 7,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0002",
				place = 4,
				tt_title = _("HERO_SPACE_ELF_NAME"),
				tt_desc = _("HERO_SPACE_ELF_DESC")
			},
			{
				check = "main_icons_0019",
				action_arg = 13,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0013",
				place = 18,
				tt_title = _("HERO_DRAGON_BONE_NAME"),
				tt_desc = _("HERO_DRAGON_BONE_DESC")
			},
			{
				check = "main_icons_0019",
				action_arg = 10,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0010",
				place = 15,
				tt_title = _("HERO_HUNTER_NAME"),
				tt_desc = _("HERO_HUNTER_DESC")
			},	
			{
				check = "main_icons_0019",
				action_arg = 6,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0006",
				place = 3,
				tt_title = _("HERO_ROBOT_NAME"),
				tt_desc = _("HERO_ROBOT_DESC")
			},	
			{
				check = "main_icons_0019",
				action_arg = 15,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0015",
				place = 20,
				tt_title = _("HERO_DRAGON_ARB_NAME"),
				tt_desc = _("HERO_DRAGON_ARB_DESC")
			},	
			{
				check = "main_icons_0019",
				action_arg = 5,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0004",
				place = 12,
				tt_title = _("HERO_BUILDER_NAME"),
				tt_desc = _("HERO_BUILDER_NAME")
			},	
			{
				check = "main_icons_0019",
				action_arg = 12,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0012",
				place = 17,
				tt_title = _("HERO_BIRD_NAME"),
				tt_desc = _("HERO_BIRD_DESC")
			},
			{
				check = "main_icons_0019",
				action_arg = 9,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0007",
				place = 14,
				tt_title = _("HERO_LUMENIR_NAME"),
				tt_desc = _("HERO_LUMENIR_DESC")
			},
			{
				check = "main_icons_0019",
				action_arg = 4,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0008",
				place = 11,
				tt_title = _("HERO_VENOM_NAME"),
				tt_desc = _("HERO_VENOM_DESC")
			},
			{
				check = "main_icons_0019",
				action_arg = 14,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0014",
				place = 19,
				tt_title = _("HERO_WITCH_NAME"),
				tt_desc = _("HERO_WITCH_DESC")
			},
			{
				check = "main_icons_0019",
				action_arg = 17,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0017",
				place = 22,
				tt_title = _("HERO_SPIDER_NAME"),
				tt_desc = _("HERO_SPIDER_NAME")
			},				
			{
				check = "main_icons_0019",
				action_arg = 3,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0005",
				place = 2,
				tt_title = _("HERO_MUYRN_NAME"),
				tt_desc = _("HERO_MUYRN_DESC")
			},	
			{
				check = "main_icons_0019",
				action_arg = 11,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0011",
				place = 16,
				tt_title = _("HERO_DRAGON_GEM_NAME"),
				tt_desc = _("HERO_DRAGON_GEM_DESC")
			},	
			{
				check = "main_icons_0019",
				action_arg = 8,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0009",
				place = 13,
				tt_title = _("HERO_MECHA_NAME"),
				tt_desc = _("HERO_MECHA_DESC")
			},	
			{
				check = "main_icons_0019",
				action_arg = 2,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0003",
				place = 1,
				tt_title = _("HERO_RAELYN_NAME"),
				tt_desc = _("HERO_RAELYN_DESC")
			},																																				
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0001",
				place = 5,
				tt_title = _("HERO_VESPER_NAME"),
				tt_desc = _("HERO_VESPER_DESC")
			},
			{
				check = "main_icons_0019",
				action_arg = "g5_special_buy",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 10,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},					
		}
	},
	hero_buy_d = {
	    {
			{
				check = "main_icons_0019",
				action_arg = 5,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0018",
				place = 4,
				tt_title = _("HERO_DOUZHANSHENGFO_NAME"),
				tt_desc = _("HERO_DOUZHANSHENGFO_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 4,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_gui_heroes_0018",
				place = 3,
				tt_title = _("HERO_WUKONG_NAME"),
				tt_desc = _("HERO_WUKONG_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 3,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0017",
				place = 2,
				tt_title = _("HERO_JACK_O_LANTERN_NAME"),
				tt_desc = _("HERO_JACK_O_LANTERN_DESCRIPTION")
			},	
			{
				check = "main_icons_0019",
				action_arg = 2,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0016",
				place = 1,
				tt_title = _("HERO_DIANYUN_NAME"),
				tt_desc = _("HERO_DIANYUN_DESCRIPTION")
			},							
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0015",
				place = 11,
				tt_title = _("HERO_EISKALT_NAME"),
				tt_desc = _("HERO_EISKALT_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 6,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0014",
				place = 12,
				tt_title = _("HERO_MURGLUN_NAME"),
				tt_desc = _("HERO_MURGLUN_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 7,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0008",
				place = 13,
				tt_title = _("HERO_BERESAD_NAME"),
				tt_desc = _("HERO_BERESAD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 8,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0020",
				place = 15,
				tt_title = _("HERO_LUCERNA_NAME"),
				tt_desc = _("HERO_LUCERNA_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 9,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0009",
				place = 19,
				tt_title = _("HERO_TANK_NAME"),
				tt_desc = _("HERO_TANK_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 10,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0001",
				place = 21,
				tt_title = _("HERO_ORC_NAME"),
				tt_desc = _("HERO_ORC_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 11,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0002",
				place = 14,
				tt_title = _("HERO_ASRA_NAME"),
				tt_desc = _("HERO_ASRA_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = 12,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "krv_gui_heroes_0003",
				place = 20,
				tt_title = _("HERO_OLOCH_NAME"),
				tt_desc = _("HERO_OLOCH_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g5_special_buy",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_NEXT_HERO_NAME"),
				tt_desc = _("TOWER_NEXT_HERO_DESCRIPTION")
			},						
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},			
		}
	},
	hermit_toad = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_hermit_toad_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_HERMIT_TOAD_2_NAME"),
				tt_desc = _("TOWER_HERMIT_TOAD_2_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0007",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NAME"),
				tt_desc_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NOTE"),
				tt_title_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NAME"),
				tt_desc_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NOTE"),
				sounds = {
					"TowerHermitToadSwitchToArtillery",
					"TowerHermitToadSwitchToMage"
				}
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_hermit_toad_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_HERMIT_TOAD_3_NAME"),
				tt_desc = _("TOWER_HERMIT_TOAD_3_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0007",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NAME"),
				tt_desc_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NOTE"),
				tt_title_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NAME"),
				tt_desc_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NOTE"),
				sounds = {
					"TowerHermitToadSwitchToArtillery",
					"TowerHermitToadSwitchToMage"
				}
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_hermit_toad_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_HERMIT_TOAD_4_NAME"),
				tt_desc = _("TOWER_HERMIT_TOAD_4_DESCRIPTION")
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0007",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NAME"),
				tt_desc_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NOTE"),
				tt_title_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NAME"),
				tt_desc_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NOTE"),
				sounds = {
					"TowerHermitToadSwitchToArtillery",
					"TowerHermitToadSwitchToMage"
				}
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "jump",
				action = "upgrade_power",
				image = "kra_special_icons_0035",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerHermitToadSkillATaunt"
				},
				tt_phrase = _("TOWER_HERMIT_TOAD_4_SKILL_JUMP_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_HERMIT_TOAD_4_SKILL_JUMP_1_NAME"),
						tt_desc = _("TOWER_HERMIT_TOAD_4_SKILL_JUMP_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_HERMIT_TOAD_4_SKILL_JUMP_2_NAME"),
						tt_desc = _("TOWER_HERMIT_TOAD_4_SKILL_JUMP_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_HERMIT_TOAD_4_SKILL_JUMP_3_NAME"),
						tt_desc = _("TOWER_HERMIT_TOAD_4_SKILL_JUMP_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "instakill",
				action = "upgrade_power",
				image = "kra_special_icons_0034",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerHermitToadSkillBTaunt"
				},
				tt_phrase = _("TOWER_HERMIT_TOAD_4_SKILL_INSTAKILL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_HERMIT_TOAD_4_SKILL_INSTAKILL_1_NAME"),
						tt_desc = _("TOWER_HERMIT_TOAD_4_SKILL_INSTAKILL_1_DESCRIPTION")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "quickmenu_action_icons_0003",
				action = "tw_change_mode",
				image = "quickmenu_action_icons_0007",
				place = 3,
				halo = "quickmenu_action_icons_0001_hover",
				tt_title_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NAME"),
				tt_desc_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_DESCRIPTION"),
				tt_phrase_mode1 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_MAGE_NOTE"),
				tt_title_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NAME"),
				tt_desc_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_DESCRIPTION"),
				tt_phrase_mode0 = _("TOWER_HERMIT_TOAD_CHANGE_MODE_ENGINEER_NOTE"),
				sounds = {
					"TowerHermitToadSwitchToArtillery",
					"TowerHermitToadSwitchToMage"
				}
			}
		}
	},
	dwarf = {
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_dwarf_lvl2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DWARF_2_NAME"),
				tt_desc = _("TOWER_DWARF_2_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_dwarf_lvl3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DWARF_3_NAME"),
				tt_desc = _("TOWER_DWARF_3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_main_icons_0019",
				action_arg = "tower_dwarf_lvl4",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "kra_main_icons_0005",
				place = 5,
				tt_title = _("TOWER_DWARF_4_NAME"),
				tt_desc = _("TOWER_DWARF_4_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		},
		{
			{
				check = "kra_special_icons_0020",
				action_arg = "formation",
				action = "upgrade_power",
				image = "kra_special_icons_0036",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"TowerDwarfSkillATaunt"
				},
				tt_phrase = _("TOWER_DWARF_4_FORMATION_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DWARF_4_FORMATION_1_NAME"),
						tt_desc = _("TOWER_DWARF_4_FORMATION_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DWARF_4_FORMATION_2_NAME"),
						tt_desc = _("TOWER_DWARF_4_FORMATION_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DWARF_4_FORMATION_3_NAME"),
						tt_desc = _("TOWER_DWARF_4_FORMATION_3_DESCRIPTION")
					}
				}
			},
			{
				check = "kra_special_icons_0020",
				action_arg = "incendiary_ammo",
				action = "upgrade_power",
				image = "kra_special_icons_0037",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"TowerDwarfSkillBTaunt"
				},
				tt_phrase = _("TOWER_DWARF_4_INCENDIARY_AMMO_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_DWARF_4_INCENDIARY_AMMO_1_NAME"),
						tt_desc = _("TOWER_DWARF_4_INCENDIARY_AMMO_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DWARF_4_INCENDIARY_AMMO_2_NAME"),
						tt_desc = _("TOWER_DWARF_4_INCENDIARY_AMMO_2_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_DWARF_4_INCENDIARY_AMMO_3_NAME"),
						tt_desc = _("TOWER_DWARF_4_INCENDIARY_AMMO_3_DESCRIPTION")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	time_wizard = {
		{
			{
				check = "special_icons_0020",
				action_arg = "sandstorm",
				action = "upgrade_power",
				image = "bloodlust_icons_0002",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"MageTimeWizardSandstorm"
				},
				tt_phrase = _("TOWER_TIME_WIZARD_SANDSTORM_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TIME_WIZARD_SANDSTORM_NAME_1"),
						tt_desc = _("TOWER_TIME_WIZARD_SANDSTORM_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_TIME_WIZARD_SANDSTORM_NAME_2"),
						tt_desc = _("TOWER_TIME_WIZARD_SANDSTORM_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_TIME_WIZARD_SANDSTORM_NAME_3"),
						tt_desc = _("TOWER_TIME_WIZARD_SANDSTORM_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action = "upgrade_power",
				halo = "glow_ico_special",
				action_arg = "guardian",
				image = "bloodlust_icons_0003",
				place = 2,
				sounds = {
					"MageTimeWizardGuardian"
				},
				tt_phrase = _("TOWER_TIME_WIZARD_ANCIENT_GUARDIAN_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TIME_WIZARD_ANCIENT_GUARDIAN_NAME_1"),
						tt_desc = _("TOWER_TIME_WIZARD_ANCIENT_GUARDIAN_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_TIME_WIZARD_ANCIENT_GUARDIAN_NAME_2"),
						tt_desc = _("TOWER_TIME_WIZARD_ANCIENT_GUARDIAN_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_TIME_WIZARD_ANCIENT_GUARDIAN_NAME_3"),
						tt_desc = _("TOWER_TIME_WIZARD_ANCIENT_GUARDIAN_DESCRIPTION_3")
					}
				}
			},
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	steam_troop = {
		{
			{
				check = "special_icons_0020",
				action_arg = "steam",
				action = "upgrade_power",
				image = "bloodlust_icons_0007",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"SteamTroopSteam"
				},
				tt_phrase = _("TOWER_STEAM_TROOP_LEAK_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_STEAM_TROOP_LEAK_NAME_1"),
						tt_desc = _("TOWER_STEAM_TROOP_LEAK_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_STEAM_TROOP_LEAK_NAME_2"),
						tt_desc = _("TOWER_STEAM_TROOP_LEAK_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_STEAM_TROOP_LEAK_NAME_3"),
						tt_desc = _("TOWER_STEAM_TROOP_LEAK_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "ball",
				action = "upgrade_power",
				image = "bloodlust_icons_0005",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"SteamTroopSpeed"
				},
				tt_phrase = _("TOWER_STEAM_TROOP_BALL_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_STEAM_TROOP_BALL_NAME_1"),
						tt_desc = _("TOWER_STEAM_TROOP_BALL_DESCRIPTION_1")
					}
				}
			},
						{
				check = "special_icons_0020",
				action_arg = "airstrike",
				action = "upgrade_power",
				image = "bloodlust_icons_0006",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"SteamTroopAirstrike"
				},
				tt_phrase = _("TOWER_STEAM_TROOP_AIRSTRIKE_NOTE_1"),
				tt_list = {
					{
						tt_title = _("TOWER_STEAM_TROOP_AIRSTRIKE_NAME_1"),
						tt_desc = _("TOWER_STEAM_TROOP_AIRSTRIKE_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_STEAM_TROOP_AIRSTRIKE_NAME_2"),
						tt_desc = _("TOWER_STEAM_TROOP_AIRSTRIKE_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_STEAM_TROOP_AIRSTRIKE_NAME_3"),
						tt_desc = _("TOWER_STEAM_TROOP_AIRSTRIKE_DESCRIPTION_3")
					}
				}
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	imperial_patrol = {
		{
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	imperialguard = {
	    {
	        {
	            check = "main_icons_0019",
	            action_arg = "soldier_s6_imperial_guard",
	            action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "main_icons_00cc",
				place = 11,
				tt_title = _("IMPERIALGUARD_NAME"),
				tt_desc = _("IMPERIALGUARD_DESCRIPTION")
			},
			{
				check = "main_icons_0019",
				action_arg = "g1_tower_barrack_3",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("TOWER_BARRACK_3_NAME"),
				tt_desc = _("TOWER_BARRACK_3_DESCRIPTION")
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
						{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	archer_hammerhold_elite = {
		{
			{
				check = "special_icons_0020",
				action_arg = "flare",
				action = "upgrade_power",
				image = "special_icons_0029a",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"LegionArcherFlareTaunt"
				},
				tt_phrase = _("HAMMERHOLD_ARCHER_UPGRADE1_NOTE"),
				tt_list = {
					{
						tt_title = _("HAMMERHOLD_ARCHER_UPGRADE1_NAME_1"),
						tt_desc = _("HAMMERHOLD_ARCHER_UPGRADE1_DESCRIPTION_1")
					},
					{
						tt_title = _("HAMMERHOLD_ARCHER_UPGRADE1_NAME_2"),
						tt_desc = _("HAMMERHOLD_ARCHER_UPGRADE1_DESCRIPTION_2")
					},
					{
						tt_title = _("HAMMERHOLD_ARCHER_UPGRADE1_NAME_3"),
						tt_desc = _("HAMMERHOLD_ARCHER_UPGRADE1_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "split",
				action = "upgrade_power",
				image = "special_icons_0028a",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"LegionArcherMultishotTaunt"
				},
				tt_phrase = _("HAMMERHOLD_ARCHER_UPGRADE2_NOTE"),
				tt_list = {
					{
						tt_title = _("HAMMERHOLD_ARCHER_UPGRADE2_NAME_1"),
						tt_desc = _("HAMMERHOLD_ARCHER_UPGRADE2_DESCRIPTION_1")
					},
					{
						tt_title = _("HAMMERHOLD_ARCHER_UPGRADE2_NAME_2"),
						tt_desc = _("HAMMERHOLD_ARCHER_UPGRADE2_DESCRIPTION_2")
					},
					{
						tt_title = _("HAMMERHOLD_ARCHER_UPGRADE2_NAME_3"),
						tt_desc = _("HAMMERHOLD_ARCHER_UPGRADE2_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	sasquash_re = {
		{
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 8
			}
		}
	},
	mercenaries_amazonas_re = {
		{
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			},
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			}
		}
	},
	elf_1 = {
		{
			{
				check = "main_icons_0020",
				action_arg = "tower_elf_kr1",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0906",
				place = 5,
				tt_title = _("SPECIAL_ELF_KR1_REPAIR_NAME"),
				tt_desc = _("SPECIAL_ELF_KR1_REPAIR_DESCRIPTION")
			},
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	elf_kr1 = {
		{
			{
				check = "special_icons_0020",
				action_arg = "dual",
				action = "upgrade_power",
				image = "special_icons_0950",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ElfTaunt"
				},
				tt_phrase = _("SPECIAL_ELF_KR1_UPGRADE1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE1_NAME_1"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE1_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE1_NAME_2"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE1_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE1_NAME_3"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE1_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "armor",
				action = "upgrade_power",
				image = "special_icons_0951",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElfTaunt"
				},
				tt_phrase = _("SPECIAL_ELF_KR1_UPGRADE2_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE2_NAME_1"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE2_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE2_NAME_2"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE2_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE2_NAME_3"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE2_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "throwing",
				action = "upgrade_power",
				image = "special_icons_0952",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ElfTaunt"
				},
				tt_phrase = _("SPECIAL_ELF_KR1_UPGRADE3_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE3_NAME_1"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE3_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE3_NAME_2"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE3_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_ELF_KR1_UPGRADE3_NAME_3"),
						tt_desc = _("SPECIAL_ELF_KR1_UPGRADE3_DESCRIPTION_3")
					}
				}
			},
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	---海盗酒馆
	tower_barrack_pirate_captain = {
	    {
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_flamer_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0032",
				place = 1,
				tt_title = _("SPECIAL_PIRATE_FLAMER_NAME"),
				tt_desc = _("SPECIAL_PIRATE_FLAMER_DESCRIPTION"),
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_anchor_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0038",
				place = 2,
				tt_title = _("SPECIAL_PIRATE_ANCHOR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_ANCHOR_DESCRIPTION"),
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	tower_barrack_pirate_captain_2 = {
	    {
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_flamer_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0032",
				place = 1,
				tt_title = _("SPECIAL_PIRATE_FLAMER_NAME"),
				tt_desc = _("SPECIAL_PIRATE_FLAMER_DESCRIPTION"),
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_anchor_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0038",
				place = 2,
				tt_title = _("SPECIAL_PIRATE_ANCHOR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_ANCHOR_DESCRIPTION"),
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	tower_barrack_pirate_flamer_2 = {
	    {
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_captain_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0031",
				place = 1,
				tt_title = _("SPECIAL_PIRATE_CORSAIR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_CORSAIR_DESCRIPTION"),
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_anchor_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0038",
				place = 2,
				tt_title = _("SPECIAL_PIRATE_ANCHOR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_ANCHOR_DESCRIPTION"),
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	tower_barrack_pirate_anchor_2 = {
	    {
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_captain_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0031",
				place = 1,
				tt_title = _("SPECIAL_PIRATE_CORSAIR_NAME"),
				tt_desc = _("SPECIAL_PIRATE_CORSAIR_DESCRIPTION"),
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_barrack_pirate_flamer_2",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0032",
				place = 2,
				tt_title = _("SPECIAL_PIRATE_FLAMER_NAME"),
				tt_desc = _("SPECIAL_PIRATE_FLAMER_DESCRIPTION"),
			},
			{
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				action = "tw_rally",
				place = 4
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	---雇佣兵
	mercenaries_desert_2 = {
		{
			{
				action = "tw_upgrade",
				action_arg = "tower_barrack_djinn_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0030",
				place = 5,--2,
				tt_title = _("SPECIAL_DJINN_NAME"),
				tt_desc = _("SPECIAL_DJINN_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	mercenaries_desert_3 = {
		{
			{
				action = "tw_upgrade",
				action_arg = "tower_barrack_djinn_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0030",
				place = 5,--2,
				tt_title = _("SPECIAL_DJINN_NAME"),
				tt_desc = _("SPECIAL_DJINN_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	mercenaries_desert_4 = {
		{
			{
				action = "tw_upgrade",
				action_arg = "tower_barrack_legion_2",
				check = "main_icons_0019",
				halo = "glow_ico_main",
				image = "main_icons_0029",
				place = 5,--1,
				tt_title = _("SPECIAL_LEGIONNAIRE_NAME"),
				tt_desc = _("SPECIAL_LEGIONNAIRE_DESCRIPTION"),
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	worm = {
		{
			{
				action = "upgrade_power",
				action_arg = "polymorph",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_eat",
				place = 1,
				sounds = {
					"SpecialWormBite",
				},
				tt_phrase = _("EATING_TIME_NOTE"),
				tt_list = {
					{
						tt_title = _("EATING_TIME_NAME"),
						tt_desc = _("EATING_TIME_DESCRIPTION"),
					},
					{
						tt_title = _("EATING_TIME_NAME"),
						tt_desc = _("EATING_TIME_DESCRIPTION"),
					},
					{
						tt_title = _("EATING_TIME_NAME"),
						tt_desc = _("EATING_TIME_DESCRIPTION"),
					},
				},
			},
			{
				action = "upgrade_power",
				action_arg = "elemental",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_worm",
				place = 2,
				sounds = {
					"SpiderAttack",
				},
				tt_phrase = _("MINI_SANDWORM_NOTE"),
				tt_list = {
					{
						tt_title = _("MINI_SANDWORM_NAME"),
						tt_desc = _("MINI_SANDWORM_DESCRIPTION"),
					},
					{
						tt_title = _("MINI_SANDWORM_NAME_2"),
						tt_desc = _("MINI_SANDWORM_DESCRIPTION_2"),
					},
					{
						tt_title = _("MINI_SANDWORM_NAME_3"),
						tt_desc = _("MINI_SANDWORM_DESCRIPTION_3"),
					},
				},
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		},
	},
	imperial_patrol_2 = {
		{
			{
				check = "special_icons_0020",
				action_arg = "extralife",
				action = "upgrade_power",
				image = "special_icons_0027",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"TemplarTauntTauntTwo"
				},
				tt_phrase = _("TOWER_TEMPLAR_TOUGHNESS_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_TEMPLAR_TOUGHNESS_NAME_1"),
						tt_desc = _("TOWER_TEMPLAR_TOUGHNESS_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_TEMPLAR_TOUGHNESS_NAME_2"),
						tt_desc = _("TOWER_TEMPLAR_TOUGHNESS_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_TEMPLAR_TOUGHNESS_NAME_3"),
						tt_desc = _("TOWER_TEMPLAR_TOUGHNESS_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "shield",
				action = "upgrade_power",
				image = "special_icons_0009",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"BarrackPaladinShieldTaunt"
				},
				tt_phrase = _("TOWER_PALADINS_SHIELD_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_DESCRIPTION_1"),
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_2_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_PALADINS_SHIELD_NAME_3"),
						tt_desc = _("TOWER_PALADINS_SHIELD_DESCRIPTION_3")
					}
				}
			},
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 4
			},
			{
				check = "special_icons_0020",
				action_arg = "hammer",
				action = "upgrade_power",
				image = "special_icons_0006",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"BarrackPaladinHolyStrikeTaunt"
				},
				tt_phrase = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NOTE"),
				tt_list = {
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_1"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_1")
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_2"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_2")
					},
					{
						tt_title = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_NAME_3"),
						tt_desc = _("SPECIAL_DWARF_BARRACKS_UPGRADE_1_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "counter",
				action = "upgrade_power",
				image = "special_icons_0023",
				place = 11,
				halo = "glow_ico_special",
				sounds = {
					"TemplarTauntTauntOne"
				},
				tt_phrase = _("TOWER_ASSASSIN_COUNTER_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ASSASSIN_COUNTER_NAME_1"),
						tt_desc = _("TOWER_ASSASSIN_COUNTER_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ASSASSIN_COUNTER_NAME_2"),
						tt_desc = _("TOWER_ASSASSIN_COUNTER_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_ASSASSIN_COUNTER_NAME_3"),
						tt_desc = _("TOWER_ASSASSIN_COUNTER_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "blade_mail",
				action = "upgrade_power",
				image = "special_icons_0119",
				place = 12,
				halo = "glow_ico_special",
				sounds = {
					"BarrackPaladinTaunt"
				},
				tt_phrase = _("ELVES_TOWER_DROW_BLADE_MAIL_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_1"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_2"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_DROW_BLADE_MAIL_NAME_3"),
						tt_desc = _("ELVES_TOWER_DROW_BLADE_MAIL_SMALL_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "pickpocket",
				action = "upgrade_power",
				image = "special_icons_0022",
				place = 3,
				halo = "glow_ico_special",
				sounds = {
					"TemplarTauntReady"
				},
				tt_phrase = _("TOWER_ASSASSIN_PICK_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_ASSASSIN_PICK_NAME_1"),
						tt_desc = _("TOWER_ASSASSIN_PICK_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_ASSASSIN_PICK_NAME_2"),
						tt_desc = _("TOWER_ASSASSIN_PICK_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_ASSASSIN_PICK_NAME_3"),
						tt_desc = _("TOWER_ASSASSIN_PICK_DESCRIPTION_3")
					}
				}
			},			
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	ewok_re = {
		{
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "main_icons_0019",
				action_arg = "tower_ewok_archer_re",
				action = "tw_upgrade",
				halo = "glow_ico_main",
				image = "main_icons_0005",
				place = 5,
				tt_title = _("ELVES_EWOK_TOWER_ARCHER_RE_NAME"),
				tt_desc = _("ELVES_EWOK_TOWER_ARCHER_RE_DESCRIPTION")
			},							
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	---精英阿渥克
	ewok_archer_re = {
		{
			{
				check = "sub_icons_0003",
				action = "tw_rally",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8
			},
			{
				check = "special_icons_0020",
				action_arg = "plant_magic_blossom",
				action = "upgrade_power",
				image = "special_icons_plant",--"tower_upgrade_icons_0061",
				place = 3,
				halo = "glow_ico_special",
				sounds = {
					"ElvesPlantReady"
				},
				tt_phrase = _("TOWER_EWOK_PLANT_MAGIC_BLOSSOM_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_EWOK_PLANT_MAGIC_BLOSSOM_1_NAME"),
						tt_desc = _("TOWER_EWOK_PLANT_MAGIC_BLOSSOM_1_DESCRIPTION")
					},
					{
						tt_title = _("TOWER_EWOK_PLANT_MAGIC_BLOSSOM_2_NAME"),
						tt_desc = _("TOWER_EWOK_PLANT_MAGIC_BLOSSOM_2_DESCRIPTION")
					}
				}
			},						
			{
				check = "special_icons_0020",
				action_arg = "armor",
				action = "upgrade_power",
				image = "special_icons_0041",
				place = 6,
				halo = "glow_ico_special",
				sounds = {
					"ElvesEwokTaunt"
				},
				tt_phrase = _("TOWER_EWOK_ARMOR_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_EWOK_ARMOR_NAME_1"),
						tt_desc = _("TOWER_EWOK_ARMOR_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_EWOK_ARMOR_NAME_2"),
						tt_desc = _("TOWER_EWOK_ARMOR_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_EWOK_ARMOR_NAME_3"),
						tt_desc = _("TOWER_EWOK_ARMOR_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "shield",
				action = "upgrade_power",
				image = "special_icons_0009",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"ElvesEwokTaunt"
				},
				tt_phrase = _("TOWER_EWOK_SHIELD_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_EWOK_SHIELD_NAME_1"),
						tt_desc = _("TOWER_EWOK_SHIELD_DESCRIPTION_1"),
					},
					{
						tt_title = _("TOWER_EWOK_SHIELD_NAME_2"),
						tt_desc = _("TOWER_EWOK_SHIELD_DESCRIPTION_2"),
					},
					{
						tt_title = _("TOWER_EWOK_SHIELD_NAME_3"),
						tt_desc = _("TOWER_EWOK_SHIELD_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "tear",
				action = "upgrade_power",
				image = "special_icons_0019",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"ElvesEwokTaunt"
				},
				tt_phrase = _("TOWER_EWOK_TEAR_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_EWOK_TEAR_NAME_1"),
						tt_desc = _("TOWER_EWOK_TEAR_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_EWOK_TEAR_NAME_2"),
						tt_desc = _("TOWER_EWOK_TEAR_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_EWOK_TEAR_NAME_3"),
						tt_desc = _("TOWER_EWOK_TEAR_DESCRIPTION_3")
					}
				}
			},						
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},	
---侏儒花园	
	pixie_re = {
		{
			{
				check = "special_icons_0020",
				action_arg = "cream",
				action = "upgrade_power",
				image = "special_icons_0122",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesGnomeNew"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE1_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE1_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE1_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE1_NAME_2"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE1_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "total",
				action = "upgrade_power",
				image = "special_icons_0123",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesGnomePower"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE2_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_2"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_2")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE2_NAME_3"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE2_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "plant_poison",
				action = "upgrade_power",
				image = "special_icons_plant",
				place = 3,
				halo = "glow_ico_special",
				sounds = {
					"VenomPlantReady"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE3_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE3_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE3_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE3_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE3_DESCRIPTION_1")
					}					
				}
			},			
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},	
	faerie_dragon_re = {
		{
			{
				check = "special_icons_0020",
				action_arg = "more_dragons",
				action = "upgrade_power",
				image = "special_icons_0124",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesFaeryDragonDragonBuy"
				},
				tt_phrase = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NAME_1"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_NAME_2"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_MORE_DRAGONS_SMALL_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "improve_shot",
				action = "upgrade_power",
				image = "special_icons_0125",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesFaeryDragonExtraAbility"
				},
				tt_phrase = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NAME_1"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_SMALL_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_NAME_2"),
						tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_UPGRADE_IMPROVE_SHOT_SMALL_DESCRIPTION_2")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "plant_poison",
				action = "upgrade_power",
				image = "special_icons_plant",
				place = 3,
				halo = "glow_ico_special",
				sounds = {
					"ElvesHeroLynnFateSealed"
				},
				tt_phrase = _("ELVES_TOWER_PIXIE_UPGRADE3_NOTE"),
				tt_list = {
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE3_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE3_DESCRIPTION_1")
					},
					{
						tt_title = _("ELVES_TOWER_PIXIE_UPGRADE3_NAME_1"),
						tt_desc = _("ELVES_TOWER_PIXIE_UPGRADE3_DESCRIPTION_1")
					}					
				}
			},	
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}								
		}
	},		
	---叶脉弓手
	green = {
		{
			{
				check = "special_icons_0020",
				action_arg = "burst",
				action = "upgrade_power",
				image = "special_icons_green",
				place = 1,
				halo = "glow_ico_special",
				sounds = {
					"ElvesArcherArcaneBurstTaunt"
				},
				tt_phrase = _("TOWER_GREEN_ARCHER_GREEN_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_GREEN_ARCHER_GREEN_NAME_1"),
						tt_desc = _("TOWER_GREEN_ARCHER_GREEN_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_GREEN_ARCHER_GREEN_NAME_2"),
						tt_desc = _("TOWER_GREEN_ARCHER_GREEN_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_GREEN_ARCHER_GREEN_NAME_3"),
						tt_desc = _("TOWER_GREEN_ARCHER_GREEN_DESCRIPTION_3")
					}
				}
			},
			{
				check = "special_icons_0020",
				action_arg = "slumber",
				action = "upgrade_power",
				image = "special_icons_leaf",
				place = 2,
				halo = "glow_ico_special",
				sounds = {
					"ElvesArcherArcaneSleepTaunt"
				},
				tt_phrase = _("TOWER_GREEN_ARCHER_LEAF_NOTE"),
				tt_list = {
					{
						tt_title = _("TOWER_GREEN_ARCHER_LEAF_NAME_1"),
						tt_desc = _("TOWER_GREEN_ARCHER_LEAF_DESCRIPTION_1")
					},
					{
						tt_title = _("TOWER_GREEN_ARCHER_LEAF_NAME_2"),
						tt_desc = _("TOWER_GREEN_ARCHER_LEAF_DESCRIPTION_2")
					},
					{
						tt_title = _("TOWER_GREEN_ARCHER_LEAF_NAME_3"),
						tt_desc = _("TOWER_GREEN_ARCHER_LEAF_DESCRIPTION_3")
					}
				}
			},
			{
				check = "ico_sell_0002",
				action = "tw_sell",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9
			}
		}
	},
	---野蛮人巢穴
	tower_barrack_canibal = {
		{
			--[[
			{
				check = "main_icons_0019",
				action = "tw_buy_soldier",
				action_arg = "soldier_cannibal",
				halo = "glow_ico_main",
				image = "main_icons_0033",
				place = 5,
				tt_title = _("SPECIAL_AMAZONAS_WARRIOR_NAME"),
				tt_desc = _("SPECIAL_AMAZONAS_WARRIOR_DESCRIPTION")
			},
			]]--
			{
				action = "upgrade_power",
				action_arg = "eat",
				check = "special_icons_0020",
				halo = "glow_ico_special",
				image = "special_icons_eat",
				place = 6,
				sounds = {
					"BarrackBarbarianThrowingAxesTaunt",
				},
				tt_phrase = _("BLOODLY_EATING_NOTE"),
				tt_list = {
					{
						tt_title = _("BLOODLY_EATING_NAME_1"),
						tt_desc = _("BLOODLY_EATING_DESCRIPTION_1"),
					},
					{
						tt_title = _("BLOODLY_EATING_NAME_2"),
						tt_desc = _("BLOODLY_EATING_DESCRIPTION_2"),
					},
					{
						tt_title = _("BLOODLY_EATING_NAME_3"),
						tt_desc = _("BLOODLY_EATING_DESCRIPTION_3"),
					},
				},
			},
			{
				check = "special_icons_0020",
				action_arg = "extralife",
				action = "upgrade_power",
				image = "special_icons_tree",
				place = 5,
				halo = "glow_ico_special",
				sounds = {
					"BarrackBarbarianTwisterTaunt",
				},
				tt_phrase = _("FOREST_ELITE_NOTE"),
				tt_list = {
					{
						tt_title = _("FOREST_ELITE_NAME_1"),
						tt_desc = _("FOREST_ELITE_DESCRIPTION_1")
					},
					{
						tt_title = _("FOREST_ELITE_NAME_2"),
						tt_desc = _("FOREST_ELITE_DESCRIPTION_2")
					},
					{
						tt_title = _("FOREST_ELITE_NAME_3"),
						tt_desc = _("FOREST_ELITE_DESCRIPTION_3")
					}
				}
			},			
			{
				check = "special_icons_0020",
				action_arg = "spear",
				action = "upgrade_power",
				image = "special_icons_spear",
				place = 7,
				halo = "glow_ico_special",
				sounds = {
					"BarrackBarbarianDoubleAxesTaunt",
				},
				tt_phrase = _("SHARP_SPEAR_NOTE"),
				tt_list = {
					{
						tt_title = _("SHARP_SPEAR_NAME_1"),
						tt_desc = _("SHARP_SPEAR_DESCRIPTION_1")
					},
					{
						tt_title = _("SHARP_SPEAR_NAME_2"),
						tt_desc = _("SHARP_SPEAR_DESCRIPTION_2")
					},
					{
						tt_title = _("SHARP_SPEAR_NAME_3"),
						tt_desc = _("SHARP_SPEAR_DESCRIPTION_3")
					}
				}
			},						
			{
				check = "special_icons_0020",
				action_arg = "carnivorous_plant",
				action = "upgrade_power",
				image = "special_icons_plant",--"tower_upgrade_icons_0055",
				place = 3,
				halo = "glow_ico_special",
				sounds = {
					"SpecialCarnivorePlant"
				},
				tt_phrase = _("CARNIVOROUS_PLANT_NOTE"),
				tt_list = {
					{
						tt_title = _("CARNIVOROUS_PLANT_1_NAME"),
						tt_desc = _("CARNIVOROUS_PLANT_1_DESCRIPTION")
					},
					{
						tt_title = _("CARNIVOROUS_PLANT_2_NAME"),
						tt_desc = _("CARNIVOROUS_PLANT_2_DESCRIPTION")
					}
				}
			},
			{
				action = "tw_rally",
				check = "sub_icons_0003",
				halo = "glow_ico_sub",
				image = "sub_icons_0001",
				place = 8,
			},
			{
				action = "tw_sell",
				check = "ico_sell_0002",
				halo = "glow_ico_sell",
				image = "ico_sell_0001",
				place = 9,
			},
		}
	},		
	--5代其他holder的补充
	holder_blocked_sea_of_trees = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0015",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_SEA_OF_TREES_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_SEA_OF_TREES_DESCRIPTION")
			}
		}
	},
	tower_timed_destroy = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder",
				action = "tw_prevent_timed_destroy",
				halo = "glow_ico_main",
				image = "kra_main_icons_0031",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_OVERSEER_NAME"),
				tt_desc = _("SPECIAL_REPAIR_OVERSEER_DESCRIPTION")
			}
		}
	},
	holder_blocked_halloween = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_sea_of_trees_6",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0015",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_SEA_OF_TREES_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_SEA_OF_TREES_DESCRIPTION")
			}
		}
	},
	tower_broken_stage_25 = {
		{
			{
				check = "main_icons_0019",
				action_arg = "",
				action = "tw_repair",
				halo = "glow_ico_main",
				image = "kra_main_icons_0035",
				place = 5,
				tt_title = _("TOWER_BROKEN_NAME"),
				tt_desc = _("TOWER_BROKEN_DESCRIPTION")
			}
		}
	},
	tower_broken_stage_27 = {
		{
			{
				check = "main_icons_0019",
				action_arg = "",
				action = "tw_repair",
				halo = "glow_ico_main",
				image = "kra_main_icons_0040",
				place = 5,
				tt_title = _("TOWER_BROKEN_NAME"),
				tt_desc = _("TOWER_BROKEN_DESCRIPTION")
			}
		}
	},
	holder_blocked_spiders = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_sea_of_trees_4",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0043",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_SPIDERS_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_SPIDERS_DESCRIPTION")
			}
		}
	},
	weirdwood_d = {
		{
			{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
		}
	},
	tower_arborean_sentinels = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_arborean_sentinels_spearmen",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "kra_main_icons_0105",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_SENTINELS_SPEARMEN_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_SENTINELS_SPEARMEN_DESCRIPTION")
			},
			{
				halo = "ingame_ui_sub_icons_0001_hover",
				image = "ingame_ui_sub_icons_0001",
				action = "tw_rally",
				place = 8
			}
		}
	},
	tower_arborean_sentinels_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_arborean_sentinels_spearmen",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "kra_main_icons_0105",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_SENTINELS_SPEARMEN_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_SENTINELS_SPEARMEN_DESCRIPTION")
			},
			{
				halo = "ingame_ui_sub_icons_0001_hover",
				image = "ingame_ui_sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
		}
	},
	arborean_oldtree = {
		{
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_main_icons_0038",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_OLDTREE_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_OLDTREE_DESCRIPTION")
			}
		}
	},
	arborean_oldtree_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_main_icons_0038",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_OLDTREE_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_OLDTREE_DESCRIPTION")
			},
			{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
		}
	},
	arborean_barrack = {
		{
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_main_icons_0036",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_BARRACK_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_BARRACK_DESCRIPTION")
			}
		}
	},
	arborean_barrack_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = 1,
				action = "tw_buy_attack",
				halo = "glow_ico_main",
				image = "kra_main_icons_0036",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_BARRACK_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_BARRACK_DESCRIPTION")
			},
			{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
		}
	},
	arborean_honey = {
		{
			{
				check = "main_icons_0019",
				action_arg = "",
				action = "tw_repair",
				halo = "glow_ico_main",
				image = "kra_main_icons_0037",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_HONEY_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_HONEY_DESCRIPTION")
			}
		}
	},
	arborean_honey_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "",
				action = "tw_repair",
				halo = "glow_ico_main",
				image = "kra_main_icons_0037",
				place = 5,
				tt_title = _("SPECIAL_ARBOREAN_HONEY_NAME"),
				tt_desc = _("SPECIAL_ARBOREAN_HONEY_DESCRIPTION")
			},
			{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
		}
	},
	tower_broken_stage_22 = {
		{
			{
				check = "main_icons_0019",
				action_arg = "",
				action = "tw_repair",
				halo = "glow_ico_main",
				image = "kra_main_icons_0015",
				place = 5,
				tt_title = _("TOWER_CROCS_EATEN_NAME"),
				tt_desc = _("TOWER_CROCS_EATEN_DESCRIPTION")
			}
		}
	},
	stage_11_veznan = {
		{
			{
				check = "special_icons_0020",
				action_arg = 1,
				action = "tw_free_action",
				halo = "glow_ico_main",
				image = "veznan_skill_icons_ingame_skill_veznan_icon_01",
				place = 6,
				tt_title = _("SPECIAL_STAGE_11_VEZNAN_ABILITY_NAME_1"),
				tt_desc = _("SPECIAL_STAGE_11_VEZNAN_ABILITY_DESCRIPTION_1")
			},
			{
				check = "special_icons_0020",
				action_arg = 2,
				action = "tw_free_action",
				halo = "glow_ico_main",
				image = "veznan_skill_icons_ingame_skill_veznan_icon_02",
				place = 5,
				tt_title = _("SPECIAL_STAGE_11_VEZNAN_ABILITY_NAME_2"),
				tt_desc = _("SPECIAL_STAGE_11_VEZNAN_ABILITY_DESCRIPTION_2")
			},
			{
				check = "special_icons_0020",
				action_arg = 3,
				action = "tw_free_action",
				halo = "glow_ico_main",
				image = "veznan_skill_icons_ingame_skill_veznan_icon_03",
				place = 7,
				tt_title = _("SPECIAL_STAGE_11_VEZNAN_ABILITY_NAME_3"),
				tt_desc = _("SPECIAL_STAGE_11_VEZNAN_ABILITY_DESCRIPTION_3")
			}
		}
	},
	tower_stage_13_sunray = {
		{
			{
				check = "main_icons_0019",
				action_arg = "",
				action = "tw_repair",
				halo = "glow_ico_main",
				image = "kra_main_icons_0030",
				place = 5,
				tt_title = _("TOWER_STAGE_13_SUNRAY_REPAIR_NAME"),
				tt_desc = _("TOWER_STAGE_13_SUNRAY_REPAIR_DESCRIPTION")
			}
		}
	},
	tower_stage_13_sunray_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "",
				action = "tw_repair",
				halo = "glow_ico_main",
				image = "kra_main_icons_0030",
				place = 5,
				tt_title = _("TOWER_STAGE_13_SUNRAY_REPAIR_NAME"),
				tt_desc = _("TOWER_STAGE_13_SUNRAY_REPAIR_DESCRIPTION")
			},
			{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
		}
	},
	tower_stage_18_elven_barrack = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_tower_stage_18_elven_barrack",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "kra_main_icons_0033",
				place = 5,
				tt_list = {
					{
						tt_title = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_1_NAME"),
						tt_desc = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_1_DESCRIPTION")
					},
					{
						tt_title = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_2_NAME"),
						tt_desc = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_2_DESCRIPTION")
					},
					{
						tt_title = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_3_NAME"),
						tt_desc = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_3_DESCRIPTION")
					}
				}
			},
			{
				halo = "ingame_ui_sub_icons_0001_hover",
				image = "ingame_ui_sub_icons_0001",
				action = "tw_rally",
				place = 8
			}
		}
	},
	tower_stage_18_elven_barrack_d = {
		{
			{
				check = "main_icons_0019",
				action_arg = "soldier_tower_stage_18_elven_barrack",
				action = "tw_buy_soldier",
				halo = "glow_ico_main",
				image = "kra_main_icons_0033",
				place = 5,
				tt_list = {
					{
						tt_title = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_1_NAME"),
						tt_desc = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_1_DESCRIPTION")
					},
					{
						tt_title = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_2_NAME"),
						tt_desc = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_2_DESCRIPTION")
					},
					{
						tt_title = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_3_NAME"),
						tt_desc = _("SPECIAL_SOLDIER_TOWER_ELVEN_BARRACK_3_DESCRIPTION")
					}
				}
			},
			{
				halo = "ingame_ui_sub_icons_0001_hover",
				image = "ingame_ui_sub_icons_0001",
				action = "tw_rally",
				place = 8
			},
			{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
		}
	},
	holder_blocked_elemental_wood = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_elemental_wood",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0045",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WOOD_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WOOD_DESCRIPTION")
			}
		}
	},
	holder_blocked_elemental_wood_enhance = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_elemental_wood_enhance",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0045",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WOOD_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WOOD_DESCRIPTION")
			}
		}
	},
	holder_blocked_elemental_fire = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_elemental_fire",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0044",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_FIRE_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_FIRE_DESCRIPTION")
			}
		}
	},
	holder_blocked_elemental_water = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_elemental_water",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0046",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WATER_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_WATER_DESCRIPTION")
			}
		}
	},
	holder_blocked_elemental_earth = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_elemental_earth",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0050",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_EARTH_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_EARTH_DESCRIPTION")
			}
		}
	},
	holder_blocked_elemental_metal = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_holder_elemental_metal",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "kra_main_icons_0047",
				place = 5,
				tt_title = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_METAL_NAME"),
				tt_desc = _("SPECIAL_REPAIR_HOLDER_ELEMENTAL_METAL_DESCRIPTION")
			}
		}
	},
	holder_roots_lands_blocked = {
		{
			{
				check = "main_icons_0019",
				action_arg = "holder_roots_lands_removed",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "main_icons_0037",
				place = 5,
				tt_title = _("HOLDER_ROOTS_LANDS_BLOCKED_NAME"),
				tt_desc = _("HOLDER_ROOTS_LANDS_BLOCKED_DESC")
			}
		}
	},
	tower_roots_lands_blocked = {
		{
			{
				check = "main_icons_0019",
				action_arg = "tower_roots_lands_removed",
				action = "tw_unblock",
				halo = "glow_ico_main",
				image = "main_icons_0037",
				place = 5,
				tt_title = _("HOLDER_ROOTS_LANDS_BLOCKED_NAME"),
				tt_desc = _("HOLDER_ROOTS_LANDS_BLOCKED_DESC")
			}
		}
	},
	random0 = {},
	random1 = {},
	random2 = {},
	random3 = {},
	random4 = {},
	random20 = {},
	random21 = {},
	random22 = {},
	random23 = {},
	random24 = {},
	--[[
	comments = 
	{
	   hero_buy = {
	       {
	   		{
	   			check = "main_icons_0019",
	   			action_arg = "Goldfinger",
	   			action = "tw_upgrade",
	   			halo = "glow_ico_main",
	   			image = "main_icons_0005",
	   			place = 10,
	   			tt_title = _("CHEAT"),
	   			tt_desc = _("CHEAT1")
	   		},
	   		{
	   			check = "ico_sell_0002",
	   			action = "tw_sell",
	   			halo = "glow_ico_sell",
	   			image = "ico_sell_0001",
	   			place = 9
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 1,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0201",
	   			place = 5,
	   			tt_title = _("HERO_ARCHER_NAME"),
	   			tt_desc = _("HERO_ARCHER_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 2,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0202",
	   			place = 1,
	   			tt_title = _("HERO_RIFLEMAN_NAME"),
	   			tt_desc = _("HERO_RIFLEMAN_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 3,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0203",
	   			place = 2,
	   			tt_title = _("HERO_PALADIN_NAME"),
	   			tt_desc = _("HERO_PALADIN_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 4,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0204",
	   			place = 11,
	   			tt_title = _("HERO_MAGE_NAME"),
	   			tt_desc = _("HERO_MAGE_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 5,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0205",
	   			place = 12,
	   			tt_title = _("HERO_FIRE_NAME"),
	   			tt_desc = _("HERO_FIRE_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 6,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0206",
	   			place = 3,
	   			tt_title = _("HERO_REINFORCEMENT_NAME"),
	   			tt_desc = _("HERO_REINFORCEMENT_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 7,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0207",
	   			place = 4,
	   			tt_title = _("HERO_DENAS_NAME"),
	   			tt_desc = _("HERO_DENAS_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 8,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0208",
	   			place = 13,
	   			tt_title = _("HERO_VIKING_NAME"),
	   			tt_desc = _("HERO_VIKING_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 9,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0209",
	   			place = 14,
	   			tt_title = _("HERO_FROST_SORCERER_NAME"),
	   			tt_desc = _("HERO_FROST_SORCERER_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 10,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0210",
	   			place = 15,
	   			tt_title = _("HERO_SAMURAI_NAME"),
	   			tt_desc = _("HERO_SAMURAI_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 11,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0211",
	   			place = 19,
	   			tt_title = _("HERO_ROBOT_NAME"),
	   			tt_desc = _("HERO_ROBOT_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 12,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0212",
	   			place = 20,
	   			tt_title = _("HERO_THOR_NAME"),
	   			tt_desc = _("HERO_THOR_DESCRIPTION")
	   		},
	   		{
	   			check = "main_icons_0019",
	   			action_arg = 13,
	   			action = "tw_buy_attack",
	   			halo = "glow_ico_main",
	   			image = "special_hero_icons_0213",
	   			place = 21,
	   			tt_title = _("HERO_10YR_NAME"),
	   			tt_desc = _("HERO_10YR_DESCRIPTION")
	   		}
	   	}
	   }
	},
	]]--
}
