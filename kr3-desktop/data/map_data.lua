-- chunkname: @./kr3-desktop/data/map_data.lua

local V = require("klua.vector")
local v = V.v
local r = V.r
local deco_fn = require("map_decos_functions")
local ani_paths = require("data.map_animations_paths")
local ani_paths2 = require("data.map_animations_paths2")
local i18n = require("i18n")
require("gg_views")

local function CJK(default, zh, ja, kr)
	return i18n.cjk(i18n, default, zh, ja, kr)
end

local function fc(r, g, b, a)
	return {
		r / 255,
		g / 255,
		b / 255,
		a / 255
	}
end

local p11, p12 = 0, CJK(0.45, 0.55, 0.5, 0.5)
local p21, p22 = CJK(0.3, 0.35, 0.35, 0.35), CJK(0.5, 0.55, 0.55, 0.55)
local rs = GGLabel.static.ref_h / REF_H

--判断英雄所在版本
local _hero_game_ver = {
	hero_elves_archer = 3,
	hero_arivan = 3,
	hero_catha = 3,
	hero_regson = 3,
	hero_elves_denas = 3,
	hero_rag = 3,
	hero_bravebark = 3,
	hero_veznan = 3,
	hero_xin = 3,
	hero_phoenix = 3,
	hero_durax = 3,
	hero_lynn = 3,
	hero_bruce = 3,
	hero_lilith = 3,
	hero_wilbur = 3,
	hero_faustus = 3,

	hero_alric = 2,
	hero_mirage = 2,
	hero_pirate = 2,
	hero_beastmaster = 2,
	hero_voodoo_witch = 2,
	hero_wizard = 2,
	hero_priest = 2,
	hero_giant = 2,
	hero_alien = 2,
	hero_dragon = 2,
	hero_crab = 2,
	hero_monk = 2,
	hero_van_helsing = 2,
	hero_dracolich = 2,
	hero_minotaur = 2,
	hero_monkey_god = 2,

	hero_gerald = 1,
	hero_alleria = 1,
	hero_malik = 1,
	hero_bolin = 1,
	hero_magnus = 1,
	hero_ignus = 1,
	hero_denas = 1,
	hero_elora = 1,
	hero_ingvar = 1,
	hero_hacksaw = 1,
	hero_oni = 1,
	hero_thor = 1,
	hero_10yr = 1,
	hero_viper = 1,
	hero_voltaire = 1,

	hero_vesper = 5,
	hero_raelyn = 5,
	hero_muyrn = 5,
	hero_venom = 5,
	hero_builder = 5,
	hero_robot = 5,
	hero_space_elf = 5,
	hero_mecha = 5,
	hero_lumenir = 5,
	hero_hunter = 5,
	hero_dragon_gem = 5,
	hero_bird = 5,
	hero_dragon_bone = 5,
	hero_witch = 5,
	hero_dragon_arb = 5,
	hero_lava = 5,
	hero_spider = 5,
	hero_wukong = 5,
	hero_douzhanshengfo = 5,

	hero_orc = 4,
	hero_asra = 4,
	hero_oloch = 4,
	hero_tramin = 4,
	hero_jigou = 4,
	hero_margosa = 4,
	hero_mortemis = 4,
	hero_tank = 4,
	hero_beresad = 4,
	hero_naga = 4,
	hero_murglun = 4,
	hero_eiskalt = 4,
	hero_dianyun = 4,
	hero_jack_o_lantern = 4,
	hero_mammoth = 4,
	hero_isfet = 4,
	hero_lucerna = 4,
}

local _hero_group_ver = {
	hero_vesper = 1,
	hero_raelyn = 2,
	hero_muyrn = 1,
	hero_venom = 2,
	hero_builder = 1,
	hero_robot = 2,
	hero_space_elf = 2,
	hero_mecha = 2,
	hero_lumenir = 1,
	hero_hunter = 1,
	hero_dragon_gem = 2,
	hero_bird = 1,
	hero_dragon_bone = 2,
	hero_witch = 1,
	hero_dragon_arb = 1,
	hero_lava = 2,
	hero_spider = 2,
	hero_wukong = 1,
	hero_douzhanshengfo = 1,
}
local function hero_game_ver(name)
	return _hero_game_ver[name] or 0
end

local function hero_group_ver(name)
	return _hero_group_ver[name] or 0
end

return {
	--label如果没有可以default，这里暂时不用改
	hero_names_config = {
		default = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 183, 95, 255),
					c3 = fc(255, 98, 0, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(88, 19, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(88, 19, 0, 255)
				},
				{}
			}
		},
		hero_elves_archer = {
			shader_args = {
				{
					sharpness = 20,
					margin = 2.5 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(253, 255, 222, 255),
					c2 = fc(221, 236, 110, 255),
					c3 = fc(124, 156, 43, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(32, 41, 8, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(32, 41, 8, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_arivan = {
			shader_args = {
				{
					sharpness = 10,
					margin = 2 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 215, 154, 255),
					c2 = fc(255, 141, 98, 255),
					c3 = fc(175, 45, 0, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(91, 24, 0, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(91, 24, 0, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_catha = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1.5 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(253, 243, 212, 255),
					c2 = fc(245, 242, 128, 255),
					c3 = fc(213, 119, 44, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(89, 29, 0, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(89, 29, 0, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_regson = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(212, 225, 255, 255),
					c2 = fc(156, 165, 255, 255),
					c3 = fc(76, 74, 224, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(47, 31, 124, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(47, 31, 124, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_elves_denas = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 252, 222, 255),
					c2 = fc(250, 224, 76, 255),
					c3 = fc(209, 138, 48, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(107, 65, 0, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(107, 65, 0, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_bravebark = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 249, 180, 255),
					c2 = fc(202, 216, 78, 255),
					c3 = fc(114, 113, 34, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(60, 56, 0, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(60, 56, 0, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_veznan = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(230, 216, 247, 255),
					c2 = fc(176, 148, 248, 255),
					c3 = fc(94, 78, 204, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(51, 22, 127, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(51, 22, 127, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_faustus = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(206, 204, 249, 255),
					c2 = fc(169, 135, 245, 255),
					c3 = fc(96, 68, 153, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(56, 38, 80, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(56, 38, 80, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_xin = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(252, 240, 196, 255),
					c2 = fc(242, 176, 65, 255),
					c3 = fc(187, 86, 34, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(89, 29, 0, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(89, 29, 0, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_rag = {
			single_line = true,
			shader_args = {
				{
					sharpness = 10,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 204, 241, 255),
					c2 = fc(255, 132, 186, 255),
					c3 = fc(206, 0, 119, 255)
				},
				{
					thickness = 1.5 * rs,
					outline_color = fc(140, 0, 81, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(140, 0, 81, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_durax = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1.5 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(160, 255, 252, 255),
					c2 = fc(0, 156, 189, 255),
					c3 = fc(0, 74, 90, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(165, 235, 233, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(165, 235, 233, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_lilith = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 225, 177, 255),
					c2 = fc(255, 171, 51, 255),
					c3 = fc(207, 73, 19, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(107, 12, 3, 255)
				},
				{
					thickness = 0.2 * rs,
					glow_color = fc(89, 29, 0, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_bruce = {
			shader_args = {
				{
					sharpness = 20,
					margin = 1.5 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 255, 255, 255),
					c2 = fc(192, 253, 254, 255),
					c3 = fc(90, 168, 186, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(30, 72, 88, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(30, 72, 88, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_lynn = {
			shader_args = {
				{
					sharpness = 10,
					p1 = 0.5,
					p2 = 0.5,
					margin = 2.5 * rs,
					c1 = fc(252, 239, 254, 255),
					c2 = fc(229, 118, 246, 255),
					c3 = fc(252, 239, 254, 255)
				},
				{
					thickness = 3 * rs,
					outline_color = fc(104, 21, 127, 255)
				},
				{
					thickness = 2 * rs,
					glow_color = fc(150, 135, 190, 155)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_phoenix = {
			shader_args = {
				{
					sharpness = 10,
					p1 = 0.5,
					p2 = 0.5,
					margin = 2.5 * rs,
					c1 = fc(255, 255, 218, 255),
					c2 = fc(255, 254, 104, 255),
					c3 = fc(255, 255, 218, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(236, 121, 48, 255)
				},
				{
					thickness = 3 * rs,
					glow_color = fc(112, 42, 15, 200)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_wilbur = {
			shader_args = {
				{
					sharpness = 10,
					margin = 2 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 255, 203, 255),
					c2 = fc(255, 254, 84, 255),
					c3 = fc(237, 132, 50, 255)
				},
				{
					thickness = 3 * rs,
					outline_color = fc(67, 20, 5, 255)
				},
				{
					thickness = 0.4 * rs,
					glow_color = fc(67, 20, 5, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 3 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		--2代  16
		hero_alric = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(255, 183, 95, 255),
					c3 = fc(255, 98, 0, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(88, 19, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(88, 19, 0, 255)
				},
				{}
			}
		},
		hero_mirage = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(255, 177, 252, 255),
					c3 = fc(140, 46, 212, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(77, 0, 75, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(77, 0, 75, 255)
				},
				{}
			}
		},
		hero_pirate = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(215, 253, 255, 255),
					c3 = fc(29, 203, 217, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(0, 81, 84, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(0, 81, 84, 255)
				},
				{}
			}
		},
		hero_beastmaster = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(228, 255, 95, 255),
					c3 = fc(107, 189, 0, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(32, 58, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(32, 58, 0, 255)
				},
				{}
			}
		},
		hero_voodoo_witch = {
			shader_args = {
				{
					margin = 2 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(231, 192, 255, 0),
					c2 = fc(209, 136, 255, 255),
					c3 = fc(128, 68, 190, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(61, 27, 86, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(61, 27, 86, 255)
				},
				{}
			}
		},
		hero_wizard = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(255, 246, 83, 255),
					c3 = fc(255, 129, 5, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(79, 44, 26, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(79, 44, 26, 255)
				},
				{}
			}
		},
		hero_priest = {
			shader_args = {
				{
					margin = 2 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(215, 251, 255, 255),
					c3 = fc(81, 202, 255, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(0, 97, 121, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(0, 97, 121, 255)
				},
				{}
			}
		},
		hero_giant = {
			shader_args = {
				{
					margin = 2 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(187, 251, 255, 255),
					c3 = fc(0, 177, 172, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(0, 83, 86, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(0, 83, 86, 255)
				},
				{}
			}
		},
		hero_alien = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(222, 180, 255, 255),
					c3 = fc(117, 65, 215, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(70, 20, 109, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(70, 20, 109, 255)
				},
				{}
			}
		},
		hero_dragon = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 210, 0, 0),
					c2 = fc(255, 151, 25, 255),
					c3 = fc(222, 77, 22, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(98, 20, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(98, 20, 0, 255)
				},
				{}
			}
		},
		hero_crab = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(226, 255, 123, 255),
					c3 = fc(133, 170, 0, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(56, 72, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(56, 72, 0, 255)
				},
				{}
			}
		},
		hero_monk = {
			shader_args = {
				{
					margin = 2 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(251, 255, 184, 0),
					c2 = fc(255, 214, 28, 255),
					c3 = fc(255, 126, 0, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(98, 47, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(98, 47, 0, 255)
				},
				{}
			}
		},
		hero_van_helsing = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(255, 179, 175, 255),
					c3 = fc(212, 68, 83, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(100, 0, 16, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(100, 0, 16, 255)
				},
				{}
			}
		},
		hero_dracolich = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(228, 255, 95, 255),
					c3 = fc(107, 173, 0, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(29, 51, 1, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(29, 51, 1, 255)
				},
				{}
			}
		},
		hero_minotaur = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 0),
					c2 = fc(255, 170, 88, 255),
					c3 = fc(255, 42, 0, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(81, 17, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(81, 17, 0, 255)
				},
				{}
			}
		},
		hero_monkey_god = {
			shader_args = {
				{
					margin = 2 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 255, 255, 0),
					c2 = fc(212, 255, 133, 255),
					c3 = fc(109, 212, 3, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(49, 107, 6, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(49, 107, 6, 255)
				},
				{}
			}
		},
		--1代 13
		hero_gerald = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(182, 232, 255, 255),
					c3 = fc(65, 178, 229, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(0, 69, 100, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(0, 69, 100, 255)
				},
				{}
			}
		},
		hero_alleria = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(238, 255, 93, 255),
					c3 = fc(145, 215, 0, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(37, 93, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(37, 93, 0, 255)
				},
				{}
			}
		},
		hero_malik = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 246, 126, 255),
					c3 = fc(255, 168, 0, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(135, 74, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(135, 74, 0, 255)
				},
				{}
			}
		},
		hero_bolin = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 194, 79, 255),
					c3 = fc(255, 113, 25, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(98, 37, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(98, 37, 0, 255)
				},
				{}
			}
		},
		hero_magnus = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 222, 254, 255),
					c3 = fc(200, 86, 255, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(69, 0, 112, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(69, 0, 112, 255)
				},
				{}
			}
		},
		hero_ignus = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 242, 63, 255),
					c3 = fc(255, 126, 0, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(105, 40, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(105, 40, 0, 255)
				},
				{}
			}
		},
		hero_denas = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 252, 219, 255),
					c3 = fc(255, 224, 0, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(107, 65, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(107, 65, 0, 255)
				},
				{}
			}
		},
		hero_elora = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 255, 255, 255),
					c3 = fc(150, 237, 245, 255)
				},
				{
					thickness = 1.5 * rs,
					outline_color = fc(17, 108, 119, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(17, 108, 119, 255)
				},
				{}
			}
		},
		hero_ingvar = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 211, 159, 255),
					c3 = fc(255, 111, 0, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(102, 33, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(102, 33, 0, 255)
				},
				{}
			}
		},
		hero_hacksaw = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(205, 255, 70, 255),
					c3 = fc(85, 156, 11, 255)
				},
				{
					thickness = 1.5 * rs,
					outline_color = fc(45, 88, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(45, 88, 0, 255)
				},
				{}
			}
		},
		hero_oni = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 167, 98, 255),
					c3 = fc(224, 44, 0, 255)
				},
				{
					thickness = 1.5 * rs,
					outline_color = fc(114, 18, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(114, 18, 0, 255)
				},
				{}
			}
		},
		hero_thor = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(222, 248, 255, 255),
					c3 = fc(34, 185, 210, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(0, 69, 93, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(0, 69, 93, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_10yr = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 242, 63, 255),
					c3 = fc(255, 126, 0, 255)
				},
				{
					thickness = 2.5 * rs,
					outline_color = fc(105, 40, 0, 255)
				},
				{
					thickness = 1 * rs,
					glow_color = fc(105, 40, 0, 255)
				},
				{}
			}
		},
		hero_voltaire = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(222, 248, 255, 255),
					c3 = fc(34, 185, 210, 255)
				},
				{
					thickness = 2 * rs,
					outline_color = fc(0, 69, 93, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(0, 69, 93, 255)
				},
				{
					shadow_width = 0.5 * rs,
					shadow_height = 2 * rs,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_viper = {
			shader_args = {
				{
					margin = 2 * rs,
					p1 = p21,
					p2 = p22,
					c1 = fc(255, 255, 255, 0),
					c2 = fc(212, 255, 133, 255),
					c3 = fc(109, 212, 3, 255)
				},
				{
					thickness = 4.5 * rs,
					outline_color = fc(49, 107, 6, 255)
				},
				{
					thickness = 1.5 * rs,
					glow_color = fc(49, 107, 6, 255)
				},
				{}
			}
		},
		hero_vesper = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(130, 206, 241, 255),
                    c3 = fc(60, 145, 183, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(0, 84, 125, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(0, 84, 125, 255)
                    },
					{}

			}
		},
		hero_raelyn = {
			shader_args = {
				{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(234, 59, 57, 255),
                    c3 = fc(173, 35, 38, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(111, 11, 19, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(111, 11, 19, 255)
                    },
				{}
			}
		},
		hero_muyrn = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(230, 255, 50, 255),
                    c3 = fc(139, 201, 23, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(48, 121, 0, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(48, 121, 0, 255)
                    },
				{}
			}
		},
		hero_venom =  {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 113, 207, 255),
                    c3 = fc(180, 75, 180, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(91, 37, 153, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(91, 37, 153, 255)
                    },
				{}
			}
		},
		hero_builder = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(112, 217, 96, 255),
                    c3 = fc(45, 162, 76, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(0, 106, 56, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(0, 106, 56, 255)
                    },
				{}
			}
		},
		--4-05
		hero_robot = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 115, 47, 255),
                    c3 = fc(189, 71, 28, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(123, 27, 9, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(123, 27, 9, 255)
                    },
				{}
			}
		},
		hero_space_elf = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(207, 84, 255, 255),
                    c3 = fc(137, 47, 212, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(66, 10, 148, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(66, 10, 148, 255)
                    },
				{}
			}
		},
		hero_mecha = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(252, 142, 18, 255),
                    c3 = fc(194, 102, 30, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(136, 61, 42, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(136, 61, 42, 255)
                    },
				{}
			}
		},
		hero_lumenir = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(113, 246, 255, 255),
                    c3 = fc(61, 146, 200, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(9, 45, 117, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(9, 45, 117, 255)
                    },
				{}
			}
		},
		--9
		hero_hunter = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(153, 150, 255, 255),
                    c3 = fc(112, 95, 203, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(71, 40, 149, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(71, 40, 149, 255)
                    },
				{}
			}
		},
		hero_dragon_gem = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 79, 94, 255),
                    c3 = fc(185, 43, 82, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(113, 7, 70, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(113, 7, 70, 255)
                    },
				{}
			}
		},
		hero_bird = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 81, 59, 255),
                    c3 = fc(201, 43, 46, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(133, 5, 33, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(133, 5, 33, 255)
                    },
				{}
			}
		},
		hero_dragon_bone = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(189, 255, 60, 255),
                    c3 = fc(116, 189, 44, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(43, 99, 27, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(43, 99, 27, 255)
                    },
				{}
			}
		},
		--13
		hero_witch = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 93, 255, 255),
                    c3 = fc(192, 55, 202, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(105, 17, 122, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(105, 17, 122, 255)
                    },

				{}
			}
		},
		hero_dragon_arb = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(80, 255, 198, 255),
                    c3 = fc(52, 204, 179, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(23, 127, 160, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(23, 127, 160, 255)
                    },
				{}
			}
		},
		hero_lava = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 140, 16, 255),
                    c3 = fc(207, 76, 16, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(135, 12, 16, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(135, 12, 16, 255)
                    },
				{}
			}
		},
		hero_spider = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 73, 240, 255),
                    c3 = fc(174, 48, 162, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(89, 23, 84, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(89, 23, 84, 255)
                    },
				{}
			}
		},
		--17
		hero_wukong = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(72, 238, 221, 255),
                    c3 = fc(45, 157, 175, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(18, 76, 129, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(18, 76, 129, 255)
                    },
				{}
			}
		},
		hero_douzhanshengfo = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(72, 238, 221, 255),
                    c3 = fc(45, 157, 175, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(18, 76, 129, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(18, 76, 129, 255)
                    },
				{}
			}
		},

		hero_orc = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(165, 212, 58, 255),
                    c3 = fc(130, 172, 30, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(95, 132, 1, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(95, 132, 1, 255)
                    },
				{}
			}
		},
		hero_asra = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(188, 100, 242, 255),
                    c3 = fc(148, 69, 196, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(107, 38, 149, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(107, 38, 149, 255)
                    },
				{}
			}
		},
		--21
		hero_oloch = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 94, 71, 255),
                    c3 = fc(230, 66, 38, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(193, 38, 5, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(193, 38, 5, 255)
                    },
				{}
			}
		},
		hero_tramin = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(251, 151, 87, 255),
                    c3 = fc(227, 111, 48, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(203, 71, 9, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(203, 71, 9, 255)
                    },
				{}
			}
		},
		hero_jigou = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(83, 229, 237, 255),
                    c3 = fc(40, 197, 200, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(0, 165, 163, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(0, 165, 163, 255)
                    },
				{}
			}
		},
		hero_margosa = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(241, 90, 121, 255),
                    c3 = fc(203, 36, 73, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(165, 0, 25, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(165, 0, 25, 255)
                    },
				{}
			}
		},
		--25
		hero_mortemis = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(110, 217, 100, 255),
                    c3 = fc(44, 162, 77, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(0, 106, 54, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(0, 106, 54, 255)
                    },
				{}
			}
		},
		hero_tank = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 66, 1, 255),
                    c3 = fc(209, 50, 0, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(140, 33, 0, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(140, 33, 0, 255)
                    },
				{}
			}
		},
		hero_beresad = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(71, 225, 65, 255),
                    c3 = fc(28, 172, 66, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(0, 119, 67, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(0, 119, 67, 255)
                    },
				{}
			}
		},
		hero_naga = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(10, 221, 230, 255),
                    c3 = fc(4, 154, 181, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(0, 86, 131, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(0, 86, 131, 255)
                    },
				{}
			}
		},
		--29
		hero_murglun = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 108, 0, 255),
                    c3 = fc(206, 70, 0, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(147, 32, 0, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(147, 32, 0, 255)
                    },
				{}
			}
		},
		hero_eiskalt = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(131, 255, 255, 255),
                    c3 = fc(57, 173, 172, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(0, 79, 81, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(0, 79, 81, 255)
                    },
				{}
			}
		},
		hero_dianyun = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(255, 143, 78, 255),
                    c3 = fc(222, 88, 31, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(172, 33, 0, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(172, 33, 0, 255)
                    },
				{}
			}
		},
		hero_jack_o_lantern = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(156, 83, 255, 255),
                    c3 = fc(113, 55, 175, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(69, 27, 95, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(69, 27, 95, 255)
                    },
				{}
			}
		},
		--33
		hero_mammoth = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(252, 160, 51, 255),
                    c3 = fc(211, 119, 20, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(170, 78, 0, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(170, 78, 0, 255)
                    },
				{}
			}
		},
		hero_isfet = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(158, 83, 255, 255),
                    c3 = fc(112, 55, 178, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(66, 27, 99, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(66, 27, 99, 255)
                    },
				{}
			}
		},
		hero_lucerna = {
			shader_args = {
					{
					margin = 0 * rs,
					p1 = p11,
					p2 = p12,
					c1 = fc(0,0,0,255),
					c2 = fc(46, 231, 191, 255),
                    c3 = fc(38, 182, 145, 255),
                    },
                    {
                        thickness = 2.5 * rs,
                        outline_color = fc(30, 133, 99, 255)
                    },
                    {
                        thickness = 1 * rs,
                        glow_color = fc(30, 133, 99, 255)
                    },
				{}
			}
		},
	},
	hero_game_ver = hero_game_ver,
	hero_group_ver = hero_group_ver,
	--hero_room加载的这里
	hero_data = {
		--3代
		{
			portrait = 1,
			thumb = 1,
			name = "hero_elves_archer",
			available_level = 0,
			starting_level = 1,
			icon = 1
		},
		{
			portrait = 2,
			thumb = 2,
			name = "hero_arivan",
			available_level = 0,--3,
			starting_level = 3,
			icon = 2
		},
		{
			portrait = 3,
			thumb = 3,
			name = "hero_catha",
			available_level = 0,--6,
			starting_level = 4,
			icon = 3
		},
		{
			portrait = 4,
			thumb = 4,
			name = "hero_regson",
			available_level = 0,--8,
			starting_level = 5,
			icon = 4
		},
		{
			portrait = 5,
			thumb = 5,
			name = "hero_elves_denas",
			available_level = 0,--8,
			starting_level = 5,
			icon = 5
		},
		{
			portrait = 10,
			thumb = 10,
			name = "hero_rag",
			available_level = 0,--10,
			starting_level = 5,
			icon = 10
		},
		{
			portrait = 7,
			thumb = 7,
			name = "hero_bravebark",
			available_level = 0,--11,
			starting_level = 5,
			icon = 7
		},
		{
			portrait = 6,
			thumb = 6,
			name = "hero_veznan",
			available_level = 0,--15,
			starting_level = 5,
			icon = 6
		},
		{
			portrait = 8,
			thumb = 8,
			name = "hero_xin",
			available_level = 0,--15,
			starting_level = 5,
			icon = 8
		},
		{
			portrait = 11,
			thumb = 11,
			name = "hero_phoenix",
			available_level = 0,--15,
			starting_level = 5,
			icon = 11
		},
		{
			portrait = 12,
			thumb = 12,
			name = "hero_durax",
			available_level = 0,--15,
			starting_level = 5,
			icon = 12
		},
		{
			portrait = 13,
			thumb = 13,
			name = "hero_lynn",
			available_level = 0,--15,
			starting_level = 5,
			icon = 13
		},
		{
			portrait = 14,
			thumb = 14,
			name = "hero_bruce",
			available_level = 0,--15,
			starting_level = 5,
			icon = 14
		},
		{
			portrait = 15,
			thumb = 15,
			name = "hero_lilith",
			available_level = 0,--15,
			starting_level = 5,
			icon = 15
		},
		{
			portrait = 16,
			thumb = 16,
			name = "hero_wilbur",
			available_level = 0,--15,
			starting_level = 5,
			icon = 16
		},
		{
			portrait = 9,
			thumb = 9,
			name = "hero_faustus",
			available_level = 0,--15,
			starting_level = 5,
			icon = 9
		},
		--2代
		{
			available_level = 0,--0,
			coming_soon = false,
			icon = 17,
			name = "hero_alric",
			portrait = 17,
			starting_level = 1,
			thumb = 17,
		},
		{
			available_level = 0,--4,
			coming_soon = false,
			icon = 18,
			name = "hero_mirage",
			portrait = 18,
			starting_level = 2,
			thumb = 18,
		},
		{
			available_level = 0,--5,
			coming_soon = false,
			icon = 20,
			name = "hero_pirate",
			portrait = 20,
			starting_level = 3,
			thumb = 20,
		},
		{
			available_level = 0,--7,
			coming_soon = false,
			icon = 21,
			name = "hero_beastmaster",
			portrait = 21,
			starting_level = 4,
			thumb = 19,
		},
		{
			available_level = 0,--8,
			coming_soon = false,
			icon = 31,
			name = "hero_voodoo_witch",
			portrait = 31,
			starting_level = 4,
			thumb = 31,
		},
		{
			available_level = 0,--9,
			coming_soon = false,
			icon = 23,
			name = "hero_wizard",
			portrait = 23,
			starting_level = 4,
			thumb = 22,
		},
		{
			available_level = 0,--10,
			coming_soon = false,
			icon = 19,
			name = "hero_priest",
			portrait = 19,
			starting_level = 4,
			thumb = 21,
		},
		{
			available_level = 0,--12,
			coming_soon = false,
			icon = 22,
			name = "hero_giant",
			portrait = 22,
			starting_level = 5,
			thumb = 24,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 24,
			name = "hero_alien",
			portrait = 24,
			starting_level = 6,
			thumb = 23,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 25,
			name = "hero_dragon",
			portrait = 25,
			starting_level = 6,
			thumb = 25,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 26,
			name = "hero_crab",
			portrait = 26,
			starting_level = 5,
			thumb = 26,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 27,
			name = "hero_monk",
			portrait = 27,
			starting_level = 5,
			thumb = 27,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 28,
			name = "hero_van_helsing",
			portrait = 28,
			starting_level = 5,
			thumb = 28,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 29,
			name = "hero_dracolich",
			portrait = 29,
			starting_level = 6,
			thumb = 29,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 30,
			name = "hero_minotaur",
			portrait = 30,
			starting_level = 5,
			thumb = 30,
		},
		{
			available_level = 0,--15,
			coming_soon = false,
			icon = 32,
			name = "hero_monkey_god",
			portrait = 32,
			starting_level = 5,
			thumb = 32,
		},
		--1代
		{
			portrait = 33,
			thumb = 33,
			name = "hero_gerald",
			generation = 1,
			available_level = 0,--4,
			starting_level = 1,
			icon = 33,
			stats = {
				6,
				5,
				0,
				4
			}
		},
		{
			portrait = 35,
			thumb = 35,
			name = "hero_alleria",
			generation = 1,
			available_level = 0,--6,
			starting_level = 1,
			icon = 35,
			stats = {
				4,
				3,
				5,
				7
			}
		},
		{
			portrait = 34,
			thumb = 34,
			name = "hero_malik",
			generation = 1,
			available_level = 0,--8,
			starting_level = 1,
			icon = 34,
			stats = {
				8,
				6,
				0,
				3
			}
		},
		{
			portrait = 36,
			thumb = 36,
			name = "hero_bolin",
			generation = 1,
			available_level = 0,--8,
			starting_level = 1,
			icon = 36,
			stats = {
				7,
				5,
				4,
				3
			}
		},
		{
			portrait = 37,
			thumb = 37,
			name = "hero_magnus",
			generation = 1,
			available_level = 0,--9,
			starting_level = 1,
			icon = 37,
			stats = {
				3,
				2,
				7,
				8
			}
		},
		{
			portrait = 38,
			thumb = 38,
			name = "hero_ignus",
			generation = 1,
			available_level = 0,--11,
			starting_level = 1,
			icon = 38,
			stats = {
				7,
				7,
				0,
				7
			}
		},
		{
			portrait = 39,
			thumb = 39,
			name = "hero_denas",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 39,
			stats = {
				5,
				5,
				8,
				3
			}
		},
		{
			portrait = 40,
			thumb = 40,
			name = "hero_elora",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 40,
			stats = {
				4,
				3,
				6,
				7
			}
		},
		{
			portrait = 41,
			thumb = 41,
			name = "hero_ingvar",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 41,
			stats = {
				8,
				6,
				0,
				5
			}
		},
		{
			portrait = 42,
			thumb = 42,
			name = "hero_hacksaw",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 42,
			stats = {
				6,
				5,
				0,
				2
			}
		},
		{
			portrait = 43,
			thumb = 43,
			name = "hero_oni",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 43,
			stats = {
				7,
				8,
				0,
				6
			}
		},
		{
			portrait = 44,
			thumb = 44,
			name = "hero_thor",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 44,
			stats = {
				7,
				5,
				0,
				6
			}
		},
		{
			portrait = 45,
			thumb = 45,
			name = "hero_10yr",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 45,
			stats = {
				6,
				5,
				0,
				8
			}
		},
		{
			portrait = 46,
			thumb = 46,
			name = "hero_viper",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 46,
			stats = {
				6,
				5,
				0,
				8
			}
		},
		{
			portrait = 47,
			thumb = 47,
			name = "hero_voltaire",
			generation = 1,
			available_level = 0,--12,
			starting_level = 1,
			icon = 47,
			stats = {
				7,
				5,
				0,
				6
			}
		},
		--5代
		{
			name = "hero_vesper",
			starting_level = 1,
			available_level = 0,
			icon = 48,
			icon = 48,
			portrait = 48,
			coming_soon = false
		},
		{
			name = "hero_raelyn",
			starting_level = 2,
			available_level = 0,
			icon = 49,
			thumb = 49,
			portrait = 49,
			coming_soon = false
		},
		{
			name = "hero_muyrn",
			starting_level = 3,
			available_level = 0,
			icon = 50,
			thumb = 50,
			portrait = 50,
			coming_soon = false
		},
		{
			name = "hero_venom",
			starting_level = 5,
			available_level = 0,
			icon = 51,
			thumb = 51,
			portrait = 51,
			coming_soon = false
		},
		{
			name = "hero_builder",
			starting_level = 5,
			available_level = 0,
			icon = 52,
			thumb = 52,
			portrait = 52,
			coming_soon = false
		},
		{
			name = "hero_robot",
			starting_level = 5,
			available_level = 0,
			icon = 53,
			thumb = 53,
			portrait = 53,
			coming_soon = false
		},
		{
			name = "hero_space_elf",
			starting_level = 5,
			available_level = 0,
			icon = 54,
			thumb = 54,
			portrait = 54,
			coming_soon = false
		},
		{
			name = "hero_mecha",
			starting_level = 5,
			available_level = 0,
			icon = 55,
			thumb = 55,
			portrait = 55,
			coming_soon = false
		},
		{
			name = "hero_lumenir",
			starting_level = 5,
			available_level = 0,
			icon = 56,
			thumb = 56,
			portrait = 56,
			coming_soon = false
		},
		{
			name = "hero_hunter",
			starting_level = 5,
			available_level = 0,
			icon = 57,
			thumb = 57,
			portrait = 57,
			coming_soon = false
		},
		{
			name = "hero_dragon_gem",
			starting_level = 5,
			available_level = 0,
			icon = 58,
			thumb = 58,
			portrait = 58,
			coming_soon = false
		},
		{
			name = "hero_bird",
			starting_level = 5,
			available_level = 0,
			icon = 59,
			thumb = 59,
			portrait = 59,
			coming_soon = false
		},
		{
			name = "hero_dragon_bone",
			starting_level = 5,
			available_level = 0,
			icon = 60,
			thumb = 60,
			portrait = 60,
			coming_soon = false
		},
		{
			name = "hero_witch",
			starting_level = 5,
			available_level = 0,
			icon = 61,
			thumb = 61,
			portrait = 61,
			coming_soon = false
		},
		{
			name = "hero_dragon_arb",
			starting_level = 5,
			available_level = 0,
			icon = 62,
			thumb = 62,
			portrait = 62,
			coming_soon = false
		},
		{
			name = "hero_lava",
			coming_soon = false,
			starting_level = 5,
			icon = 63,
			thumb = 63,
			portrait = 63,
			available_level = 0
		},
		{
			name = "hero_spider",
			starting_level = 5,
			available_level = 0,
			icon = 64,
			thumb = 64,
			portrait = 64,
			coming_soon = false
		},
		{
			name = "hero_wukong",
			starting_level = 5,
			available_level = 0,
			icon = 65,
			thumb = 65,
			portrait = 65,
			coming_soon = false
		},
		{
			name = "hero_douzhanshengfo",
			starting_level = 5,
			available_level = 0,
			icon = 65,
			thumb = 65,
			portrait = 65,
			coming_soon = false
		},
		--4代
		{
			name = "hero_orc",
			starting_level = 1,
			available_level = 0,
			icon = 401,
			thumb = 401,
			portrait = 401,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_asra",
			starting_level = 3,
			available_level = 0,
			icon = 402,
			thumb = 402,
			portrait = 402,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_oloch",
			starting_level = 4,
			available_level = 0,
			icon = 403,
			thumb = 403,
			portrait = 403,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_tramin",
			starting_level = 5,
			available_level = 0,
			icon = 404,
			thumb = 404,
			portrait = 404,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_jigou",
			starting_level = 5,
			available_level = 0,
			icon = 405,
			thumb = 405,
			portrait = 405,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_margosa",
			starting_level = 5,
			available_level = 0,
			icon = 406,
			thumb = 406,
			portrait = 406,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_mortemis",
			starting_level = 5,
			available_level = 0,
			icon = 407,
			thumb = 407,
			portrait = 407,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_tank",
			starting_level = 5,
			available_level = 0,
			icon = 408,
			thumb = 408,
			portrait = 408,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_beresad",
			starting_level = 5,
			available_level = 0,
			icon = 409,
			thumb = 409,
			portrait = 409,
			--transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_naga",
			starting_level = 5,
			available_level = 0,
			icon = 410,
			thumb = 410,
			portrait = 410,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_murglun",
			starting_level = 5,
			available_level = 0,
			icon = 411,
			thumb = 411,
			portrait = 411,
			--transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_eiskalt",
			starting_level = 5,
			available_level = 0,
			icon = 412,
			thumb = 412,
			portrait = 412,
			coming_soon = false
		},
		{
			name = "hero_dianyun",
			starting_level = 5,
			available_level = 0,
			icon = 413,
			thumb = 413,
			portrait = 413,
			coming_soon = false
		},
		{
			name = "hero_jack_o_lantern",
			starting_level = 5,
			available_level = 0,
			icon = 414,
			thumb = 414,
			portrait = 414,
			coming_soon = false
		},
		{
			name = "hero_mammoth",
			starting_level = 5,
			available_level = 0,
			icon = 415,
			thumb = 415,
			portrait = 415,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_isfet",
			starting_level = 5,
			available_level = 0,
			icon = 416,
			thumb = 416,
			portrait = 416,
			transplanting = true,
			coming_soon = false
		},
		{
			name = "hero_lucerna",
			starting_level = 5,
			available_level = 0,
			icon = 417,
			thumb = 417,
			portrait = 417,
			transplanting = true,
			coming_soon = false
		},
		--{
		--	coming_soon = true,
		--},
	},
	level_data = {
		{
			upgrades = {
				heroe = true,
				level = 1
			},
			iron = {
				"archers",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 2
			},
			iron = {
				"mages",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 2
			},
			iron = {
				"archers",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 2
			},
			iron = {
				"barracks",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 2
			},
			iron = {
				"barracks",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 3
			},
			iron = {
				"archers",
				"barracks"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 3
			},
			iron = {
				"mages",
				"barracks"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 3
			},
			iron = {
				"mages",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 4
			},
			iron = {
				"barracks",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 4
			},
			iron = {
				"archers",
				"barracks"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 4
			},
			iron = {
				"barracks",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"mages",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"barracks",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"mages",
				"archers"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"mages",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"mages",
				"archers"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"barracks",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"mages",
				"druids",
				"artillery",
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"druids",
				"artillery",
			}
		},
		--2代
		{
			upgrades = {
				heroe = false,
				level = 1,
			},
			iron = {
				"archers",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 2,
			},
			iron = {
				"archers",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 2,
			},
			iron = {
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 2,
			},
			iron = {
				"artillery",
				"druids",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 2,
			},
			iron = {
				"barracks",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 3,
			},
			iron = {
				"barracks",
				"archers",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 3,
			},
			iron = {
				"artillery",
				"druids",
				"archers",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 3,
			},
			iron = {
				"mages",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 4,
			},
			iron = {
				"barracks",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 4,
			},
			iron = {
				"artillery",
				"druids",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 4,
			},
			iron = {
				"barracks",
				"archers",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"artillery",
				"druids",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"mages",
				"archers",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"artillery",
				"druids",
				"barracks",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"mages",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"barracks",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"artillery",
				"druids",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"barracks",
				"mages",
			},
		},
		--1代
		{
			upgrades = {
				heroe = false,
				level = 1,
			},
			iron = {
				"archers",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 2,
			},
			iron = {
				"barracks",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 2,
			},
			iron = {
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 2,
			},
			iron = {
				"mages",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 3,
			},
			iron = {
				"barracks",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 3,
			},
			iron = {
				"archers",
				"mages",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 3,
			},
			iron = {
				"barracks",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 4,
			},
			iron = {
				"archers",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = false,
				level = 4,
			},
			iron = {
				"archers",
				"barracks",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 4,
			},
			iron = {
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"artillery",
				"druids",
				"archers",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"artillery",
				"druids",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"mages",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"barracks",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"barracks",
				"artillery",
				"druids",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"mages",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
			},
		},
		{
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"artillery",
				"druids",
			},
		},
		[71] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[72] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
---重生		
		[73] = {
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"barracks",
				"artillery",
				"mages"
			}
		},
		[74] = {
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"artillery",
				"mages"
			}
		},
		[75] = {
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"barracks",
			}
		},
---				
		--5代
		[101] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[102] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[103] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[104] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[105] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[106] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[107] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[108] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[109] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[110] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[111] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[112] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[113] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[114] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[115] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[116] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[117] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[118] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[119] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[120] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[121] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[122] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[123] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[124] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[125] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[126] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[127] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[128] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[129] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[130] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[131] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[132] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[133] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[134] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
		[135] = {
			upgrades = {
				heroe = true,
				level = 5,
			},
			iron = {
				"archers",
				"barracks",
				"mages",
				"artillery",
				"druids",
			},
		},
	},
	tower_data = {
		--3代
		{
			name = "tower_archer_1"
		},
		{
			name = "tower_barrack_1"
		},
		{
			name = "tower_mage_1"
		},
		{
			name = "tower_rock_thrower_1"
		},
		{
			name = "tower_archer_2"
		},
		{
			name = "tower_barrack_2"
		},
		{
			name = "tower_mage_2"
		},
		{
			name = "tower_rock_thrower_2"
		},
		{
			name = "tower_archer_3"
		},
		{
			name = "tower_barrack_3"
		},
		{
			name = "tower_mage_3"
		},
		{
			name = "tower_rock_thrower_3"
		},
		{
			icon = 17,
			name = "tower_arcane"
		},
		{
			icon = 20,
			name = "tower_blade"
		},
		{
			icon = 16,
			name = "tower_wild_magus"
		},
		{
			icon = 13,
			name = "tower_druid"
		},
		{
			icon = 18,
			name = "tower_silver"
		},
		{
			icon = 19,
			name = "tower_forest"
		},
		{
			icon = 15,
			name = "tower_high_elven"
		},
		{
			icon = 14,
			name = "tower_entwood"
		},
		--2代
		{
			icon = 201,
			name = "g2_tower_archer_1"
		},
		{
			icon = 202,
			name = "g2_tower_barrack_1"
		},
		{
			icon = 203,
			name = "g2_tower_mage_1"
		},
		{
			icon = 204,
			name = "g2_tower_engineer_1"
		},
		{
			icon = 205,
			name = "g2_tower_archer_2"
		},
		{
			icon = 206,
			name = "g2_tower_barrack_2"
		},
		{
			icon = 207,
			name = "g2_tower_mage_2"
		},
		{
			icon = 208,
			name = "g2_tower_engineer_2"
		},
		{
			icon = 209,
			name = "g2_tower_archer_3"
		},
		{
			icon = 210,
			name = "g2_tower_barrack_3"
		},
		{
			icon = 211,
			name = "g2_tower_mage_3"
		},
		{
			icon = 212,
			name = "g2_tower_engineer_3"
		},
		{
			icon = 213,
			name = "tower_crossbow"
		},
		{
			icon = 214,
			name = "tower_assassin"
		},
		{
			icon = 215,
			name = "tower_archmage"
		},
		{
			icon = 216,
			name = "tower_dwaarp"
		},
		{
			icon = 217,
			name = "tower_totem"
		},
		{
			icon = 218,
			name = "tower_templar"
		},
		{
			icon = 219,
			name = "tower_necromancer"
		},
		{
			icon = 220,
			name = "tower_mech"
		},
		--1代
		{
			icon = 101,
			name = "g1_tower_archer_1"
		},
		{
			icon = 102,
			name = "g1_tower_barrack_1"
		},
		{
			icon = 103,
			name = "g1_tower_mage_1"
		},
		{
			icon = 104,
			name = "g1_tower_engineer_1"
		},
		{
			icon = 105,
			name = "g1_tower_archer_2"
		},
		{
			icon = 106,
			name = "g1_tower_barrack_2"
		},
		{
			icon = 107,
			name = "g1_tower_mage_2"
		},
		{
			icon = 108,
			name = "g1_tower_engineer_2"
		},
		{
			icon = 109,
			name = "g1_tower_archer_3"
		},
		{
			icon = 110,
			name = "g1_tower_barrack_3"
		},
		{
			icon = 111,
			name = "g1_tower_mage_3"
		},
		{
			icon = 112,
			name = "g1_tower_engineer_3"
		},
		{
			icon = 113,
			name = "tower_ranger"
		},
		{
			icon = 114,
			name = "tower_paladin"
		},
		{
			icon = 115,
			name = "tower_arcane_wizard"
		},
		{
			icon = 116,
			name = "tower_bfg"
		},
		{
			icon = 117,
			name = "tower_musketeer"
		},
		{
			icon = 118,
			name = "tower_barbarian"
		},
		{
			icon = 119,
			name = "tower_sorcerer"
		},
		{
			icon = 120,
			name = "tower_tesla"
		},
		--5代
		{
			icon = 505,
			name = "tower_paladin_covenant_lvl1"
		},
		{
			icon = 506,
			name = "tower_paladin_covenant_lvl2"
		},
		{
			icon = 507,
			name = "tower_paladin_covenant_lvl3"
		},
		{
			icon = 508,
			name = "tower_paladin_covenant_lvl4"
		},
		{
			icon = 509,
			name = "tower_royal_archers_lvl1"
		},
		{
			icon = 510,
			name = "tower_royal_archers_lvl2"
		},
		{
			icon = 511,
			name = "tower_royal_archers_lvl3"
		},
		{
			icon = 512,
			name = "tower_royal_archers_lvl4"
		},
		{
			icon = 501,
			name = "tower_arcane_wizard_lvl1"
		},
		{
			icon = 502,
			name = "tower_arcane_wizard_lvl2"
		},
		{
			icon = 503,
			name = "tower_arcane_wizard_lvl3"
		},
		{
			icon = 504,
			name = "tower_arcane_wizard_lvl4"
		},
		{
			icon = 513,
			name = "tower_tricannon_lvl1"
		},
		{
			icon = 514,
			name = "tower_tricannon_lvl2"
		},
		{
			icon = 515,
			name = "tower_tricannon_lvl3"
		},
		{
			icon = 516,
			name = "tower_tricannon_lvl4"
		},
		{
			icon = 521,
			name = "tower_arborean_emissary_lvl1"
		},
		{
			icon = 522,
			name = "tower_arborean_emissary_lvl2"
		},
		{
			icon = 523,
			name = "tower_arborean_emissary_lvl3"
		},
		{
			icon = 524,
			name = "tower_arborean_emissary_lvl4"
		},
		{
			icon = 525,
			name = "tower_demon_pit_lvl1"
		},
		{
			icon = 526,
			name = "tower_demon_pit_lvl2"
		},
		{
			icon = 527,
			name = "tower_demon_pit_lvl3"
		},
		{
			icon = 528,
			name = "tower_demon_pit_lvl4"
		},
		{
			icon = 537,
			name = "tower_elven_stargazers_lvl1"
		},
		{
			icon = 538,
			name = "tower_elven_stargazers_lvl2"
		},
		{
			icon = 539,
			name = "tower_elven_stargazers_lvl3"
		},
		{
			icon = 540,
			name = "tower_elven_stargazers_lvl4"
		},
		{
			icon = 549,
			name = "tower_rocket_gunners_lvl1"
		},
		{
			icon = 550,
			name = "tower_rocket_gunners_lvl2"
		},
		{
			icon = 551,
			name = "tower_rocket_gunners_lvl3"
		},
		{
			icon = 552,
			name = "tower_rocket_gunners_lvl4"
		},
		{
			icon = 533,
			name = "tower_necromancer_lvl1"
		},
		{
			icon = 534,
			name = "tower_necromancer_lvl2"
		},
		{
			icon = 535,
			name = "tower_necromancer_lvl3"
		},
		{
			icon = 536,
			name = "tower_necromancer_lvl4"
		},
		{
			icon = 517,
			name = "tower_ballista_lvl1"
		},
		{
			icon = 518,
			name = "tower_ballista_lvl2"
		},
		{
			icon = 519,
			name = "tower_ballista_lvl3"
		},
		{
			icon = 520,
			name = "tower_ballista_lvl4"
		},
		{
			icon = 541,
			name = "tower_flamespitter_lvl1"
		},
		{
			icon = 542,
			name = "tower_flamespitter_lvl2"
		},
		{
			icon = 543,
			name = "tower_flamespitter_lvl3"
		},
		{
			icon = 544,
			name = "tower_flamespitter_lvl4"
		},
		{
			icon = 529,
			name = "tower_barrel_lvl1"
		},
		{
			icon = 530,
			name = "tower_barrel_lvl2"
		},
		{
			icon = 531,
			name = "tower_barrel_lvl3"
		},
		{
			icon = 532,
			name = "tower_barrel_lvl4"
		},
		{
			icon = 545,
			name = "tower_sand_lvl1"
		},
		{
			icon = 546,
			name = "tower_sand_lvl2"
		},
		{
			icon = 547,
			name = "tower_sand_lvl3"
		},
		{
			icon = 548,
			name = "tower_sand_lvl4"
		},
		{
			icon = 557,
			name = "tower_ghost_lvl1"
		},
		{
			icon = 558,
			name = "tower_ghost_lvl2"
		},
		{
			icon = 559,
			name = "tower_ghost_lvl3"
		},
		{
			icon = 560,
			name = "tower_ghost_lvl4"
		},
		{
			icon = 553,
			name = "tower_ray_lvl1"
		},
		{
			icon = 554,
			name = "tower_ray_lvl2"
		},
		{
			icon = 555,
			name = "tower_ray_lvl3"
		},
		{
			icon = 556,
			name = "tower_ray_lvl4"
		},
		{
			icon = 561,
			name = "tower_dark_elf_lvl1"
		},
		{
			icon = 562,
			name = "tower_dark_elf_lvl2"
		},
		{
			icon = 563,
			name = "tower_dark_elf_lvl3"
		},
		{
			icon = 564,
			name = "tower_dark_elf_lvl4"
		},
		{
			icon = 565,
			name = "tower_hermit_toad_lvl1"
		},
		{
			icon = 566,
			name = "tower_hermit_toad_lvl2"
		},
		{
			icon = 567,
			name = "tower_hermit_toad_lvl3"
		},
		{
			icon = 568,
			name = "tower_hermit_toad_lvl4"
		},
		{
			icon = 569,
			name = "tower_hermit_toad_lvl1"
		},
		{
			icon = 570,
			name = "tower_hermit_toad_lvl2"
		},
		{
			icon = 571,
			name = "tower_hermit_toad_lvl3"
		},
		{
			icon = 572,
			name = "tower_hermit_toad_lvl4"
		},
		{
			icon = 577,
			name = "tower_dwarf_lvl1"
		},
		{
			icon = 578,
			name = "tower_dwarf_lvl2"
		},
		{
			icon = 579,
			name = "tower_dwarf_lvl3"
		},
		{
			icon = 580,
			name = "tower_dwarf_lvl4"
		},
		{
			icon = 573,
			name = "tower_sparking_geode_lvl1"
		},
		{
			icon = 574,
			name = "tower_sparking_geode_lvl2"
		},
		{
			icon = 575,
			name = "tower_sparking_geode_lvl3"
		},
		{
			icon = 576,
			name = "tower_sparking_geode_lvl4"
		},
		{
			icon = 581,
			name = "tower_pandas_lvl1"
		},
		{
			icon = 582,
			name = "tower_pandas_lvl2"
		},
		{
			icon = 583,
			name = "tower_pandas_lvl3"
		},
		{
			icon = 584,
			name = "tower_pandas_lvl4"
		},
		--4代 P9
		{
			icon = 329,
			name = "tower_twilight_elves_barrack_lvl1"
		},
		{
			icon = 330,
			name = "tower_twilight_elves_barrack_lvl2"
		},
		{
			icon = 331,
			name = "tower_twilight_elves_barrack_lvl3"
		},
		{
			icon = 332,
			name = "tower_twilight_elves_barrack_lvl4"
		},
		{
			icon = 353,
			name = "tower_blazing_watcher_lvl1"
		},
		{
			icon = 354,
			name = "tower_blazing_watcher_lvl2"
		},
		{
			icon = 355,
			name = "tower_blazing_watcher_lvl3"
		},
		{
			icon = 356,
			name = "tower_blazing_watcher_lvl4"
		},
		{
			icon = 377,
			name = "tower_ignis_altar_lvl1"
		},
		{
			icon = 378,
			name = "tower_ignis_altar_lvl2"
		},
		{
			icon = 379,
			name = "tower_ignis_altar_lvl3"
		},
		{
			icon = 380,
			name = "tower_ignis_altar_lvl4"
		},
		{
			icon = 325,
			name = "tower_shadow_archer_lvl1"
		},
		{
			icon = 326,
			name = "tower_shadow_archer_lvl2"
		},
		{
			icon = 327,
			name = "tower_shadow_archer_lvl3"
		},
		{
			icon = 328,
			name = "tower_shadow_archer_lvl4"
		},
		{
			icon = 321,
			name = "tower_dark_knights_lvl1"
		},
		{
			icon = 322,
			name = "tower_dark_knights_lvl2"
		},
		{
			icon = 323,
			name = "tower_dark_knights_lvl3"
		},
		{
			icon = 324,
			name = "tower_dark_knights_lvl4"
		},
		{
			icon = 337,
			name = "tower_infernal_mage_lvl1"
		},
		{
			icon = 338,
			name = "tower_infernal_mage_lvl2"
		},
		{
			icon = 339,
			name = "tower_infernal_mage_lvl3"
		},
		{
			icon = 340,
			name = "tower_infernal_mage_lvl4"
		},
		{
			icon = 357,
			name = "tower_melting_furnace_lvl1"
		},
		{
			icon = 358,
			name = "tower_melting_furnace_lvl2"
		},
		{
			icon = 359,
			name = "tower_melting_furnace_lvl3"
		},
		{
			icon = 360,
			name = "tower_melting_furnace_lvl4"
		},
		{
			icon = 301,
			name = "tower_goblirang_lvl1"
		},
		{
			icon = 302,
			name = "tower_goblirang_lvl2"
		},
		{
			icon = 303,
			name = "tower_goblirang_lvl3"
		},
		{
			icon = 304,
			name = "tower_goblirang_lvl4"
		},
		{
			icon = 385,
			name = "tower_ogre_shipwreck_lvl1"
		},
		{
			icon = 386,
			name = "tower_ogre_shipwreck_lvl2"
		},
		{
			icon = 387,
			name = "tower_ogre_shipwreck_lvl3"
		},
		{
			icon = 388,
			name = "tower_ogre_shipwreck_lvl4"
		},
		{
			icon = 345,
			name = "tower_spirit_mausoleum_lvl1"
		},
		{
			icon = 346,
			name = "tower_spirit_mausoleum_lvl2"
		},
		{
			icon = 347,
			name = "tower_spirit_mausoleum_lvl3"
		},
		{
			icon = 348,
			name = "tower_spirit_mausoleum_lvl4"
		},
		{
			icon = 333,
			name = "tower_rotten_forest_lvl1"
		},
		{
			icon = 334,
			name = "tower_rotten_forest_lvl2"
		},
		{
			icon = 335,
			name = "tower_rotten_forest_lvl3"
		},
		{
			icon = 336,
			name = "tower_rotten_forest_lvl4"
		},
		{
			icon = 373,
			name = "tower_shaolin_lvl1"
		},
		{
			icon = 374,
			name = "tower_shaolin_lvl2"
		},
		{
			icon = 375,
			name = "tower_shaolin_lvl3"
		},
		{
			icon = 376,
			name = "tower_shaolin_lvl4"
		},
		{
			icon = 369,
			name = "tower_swamp_monster_lvl1"
		},
		{
			icon = 370,
			name = "tower_swamp_monster_lvl2"
		},
		{
			icon = 371,
			name = "tower_swamp_monster_lvl3"
		},
		{
			icon = 372,
			name = "tower_swamp_monster_lvl4"
		},
		{
			icon = 369,
			name = "tower_swamp_monster_lvl1"
		},
		{
			icon = 370,
			name = "tower_swamp_monster_lvl2"
		},
		{
			icon = 371,
			name = "tower_swamp_monster_lvl3"
		},
		{
			icon = 372,
			name = "tower_swamp_monster_lvl4"
		},
		{
			icon = 365,
			name = "tower_wicked_sisters_lvl1"
		},
		{
			icon = 366,
			name = "tower_wicked_sisters_lvl2"
		},
		{
			icon = 367,
			name = "tower_wicked_sisters_lvl3"
		},
		{
			icon = 368,
			name = "tower_wicked_sisters_lvl4"
		},
		{
			icon = 365,
			name = "tower_wicked_sisters_lvl1"
		},
		{
			icon = 366,
			name = "tower_wicked_sisters_lvl2"
		},
		{
			icon = 367,
			name = "tower_wicked_sisters_lvl3"
		},
		{
			icon = 368,
			name = "tower_wicked_sisters_lvl4"
		},
		{
			icon = 305,
			name = "tower_balloon_lvl1"
		},
		{
			icon = 306,
			name = "tower_balloon_lvl2"
		},
		{
			icon = 307,
			name = "tower_balloon_lvl3"
		},
		{
			icon = 308,
			name = "tower_balloon_lvl4"
		},
		{
			icon = 341,
			name = "tower_bone_flingers_lvl1"
		},
		{
			icon = 342,
			name = "tower_bone_flingers_lvl2"
		},
		{
			icon = 343,
			name = "tower_bone_flingers_lvl3"
		},
		{
			icon = 344,
			name = "tower_bone_flingers_lvl4"
		},
		{
			icon = 309,
			name = "tower_orc_warriors_den_lvl1"
		},
		{
			icon = 310,
			name = "tower_orc_warriors_den_lvl2"
		},
		{
			icon = 311,
			name = "tower_orc_warriors_den_lvl3"
		},
		{
			icon = 312,
			name = "tower_orc_warriors_den_lvl4"
		},
		{
			icon = 313,
			name = "tower_orc_shaman_lvl1"
		},
		{
			icon = 314,
			name = "tower_orc_shaman_lvl2"
		},
		{
			icon = 315,
			name = "tower_orc_shaman_lvl3"
		},
		{
			icon = 316,
			name = "tower_orc_shaman_lvl4"
		},
		{
			icon = 317,
			name = "tower_rocket_riders_lvl1"
		},
		{
			icon = 318,
			name = "tower_rocket_riders_lvl2"
		},
		{
			icon = 319,
			name = "tower_rocket_riders_lvl3"
		},
		{
			icon = 320,
			name = "tower_rocket_riders_lvl4"
		},
		{
			icon = 349,
			name = "tower_grim_cemetery_lvl1"
		},
		{
			icon = 350,
			name = "tower_grim_cemetery_lvl2"
		},
		{
			icon = 351,
			name = "tower_grim_cemetery_lvl3"
		},
		{
			icon = 352,
			name = "tower_grim_cemetery_lvl4"
		},
		{
			icon = 361,
			name = "tower_deep_devils_lvl1"
		},
		{
			icon = 362,
			name = "tower_deep_devils_lvl2"
		},
		{
			icon = 363,
			name = "tower_deep_devils_lvl3"
		},
		{
			icon = 364,
			name = "tower_deep_devils_lvl4"
		},
		{
			icon = 381,
			name = "tower_sandworm_lvl1"
		},
		{
			icon = 382,
			name = "tower_sandworm_lvl2"
		},
		{
			icon = 383,
			name = "tower_sandworm_lvl3"
		},
		{
			icon = 384,
			name = "tower_sandworm_lvl4"
		},
	},
	tower_3_data = {
		{
			icon = 203,
			name = "g1_tower_mage_1"
		},
		{
			icon = 204,
			name = "g1_tower_engineer_1"
		},
		{
			name = "tower_mage_1"
		},
		{
			name = "tower_rock_thrower_1"
		},
		{
			icon = 201,
			name = "g2_tower_archer_1"
		},
		{
			icon = 204,
			name = "g2_tower_engineer_1"
		},
		{
			icon = 201,
			name = "g1_tower_archer_1"
		},
		{
			icon = 202,
			name = "g1_tower_barrack_1"
		},

		{
			name = "tower_archer_1"
		},
		{
			name = "tower_barrack_1"
		},
		{
			icon = 202,
			name = "g2_tower_barrack_1"
		},
		{
			icon = 203,
			name = "g2_tower_mage_1"
		},
		
	},
	tower_5_data = {
		{
			name = "paladin_covenant"
		},
		{
			name = "royal_archers"
		},
		{
			name = "arcane_wizard"
		},
		{
			name = "tricannon"
		},
		{
			name = "arborean_emissary"
		},
		{
			name = "demon_pit"
		},
		{
			name = "elven_stargazers"
		},
		{
			name = "rocket_gunners"
		},
		{
			name = "ballista"
		},
		{
			name = "necromancer"
		},
		{
			name = "flamespitter"
		},
		{
			name = "sand"
		},
		{
			name = "ghost"
		},
		{
			name = "barrel"
		},
		{
			name = "ray"
		},
		{
			name = "dark_elf"
		},
		{
			name = "hermit_toad"
		},
		{
			name = "dwarf"
		},
		{
			name = "sparking_geode"
		},
		{
			name = "pandas"
		},
		--4代防御塔
		{
			name = "twilight_elves_barrack"
		},
		{
			name = "blazing_watcher"
		},
		{
			name = "ignis_altar"
		},
		{
			name = "shadow_archer"
		},
		{
			name = "dark_knights"
		},
		{
			name = "infernal_mage"
		},
		{
			name = "melting_furnace"
		},
		{
			name = "goblirang"
		},
		{
			name = "ogre_shipwreck"
		},
		{
			name = "spirit_mausoleum"
		},
		{
			name = "rotten_forest"
		},
		{
			name = "shaolin"
		},
		{
			name = "swamp_monster"
		},
		{
			name = "wicked_sisters"
		},
		{
			name = "balloon"
		},
		{
			name = "bone_flingers"
		},
		{
			name = "orc_warriors_den"
		},
		{
			name = "orc_shaman"
		},
		{
			name = "rocket_riders"
		},
		{
			name = "grim_cemetery"
		},
		{
			name = "deep_devils"
		},
		{
			name = "sandworm"
		},
	},
	random = {
		require_texture = {
			"shadow_archer",
			"goblirang",
			"shaolin",
			"swamp_monster",
			"bone_flingers",	
			"royal_archers",
			"ballista",
			"sand",
			"dark_elf",

			"twilight_elves_barrack",
			"dark_knights",
			"ogre_shipwreck",
			"orc_warriors_den",
			"grim_cemetery",
			"paladin_covenant",
			"demon_pit",
			"rocket_gunners",
			"ghost",
			"dwarf",
			"pandas",

			"blazing_watcher",
			"infernal_mage",
			"spirit_mausoleum",
			"wicked_sisters",
			"orc_shaman",
			"deep_devils",
			"arcane_wizard",
			"arborean_emissary",
			"elven_stargazers",
			"necromancer",
			"ray",

			"ignis_altar",
			"melting_furnace",
			"rotten_forest",
			"balloon",
			"rocket_riders",
			"sandworm",
			"tricannon",
			"flamespitter",
			"barrel",
			"hermit_toad",
			"sparking_geode",
		},
		archer = {
			"tower_archer_1",
			"g2_tower_archer_1",
			"g1_tower_archer_1",

			"shadow_archer",
			"goblirang",
			"shaolin",
			"swamp_monster",
			"bone_flingers",
			
			"royal_archers",
			"ballista",
			"sand",
			"dark_elf",

			"tower_archer_1",
			"g2_tower_archer_1",
			"g1_tower_archer_1",
		},
		barrack = {
			"tower_barrack_1",
			"g2_tower_barrack_1",
			"g1_tower_barrack_1",

			"twilight_elves_barrack",
			"dark_knights",
			"ogre_shipwreck",
			"orc_warriors_den",
			"grim_cemetery",

			"paladin_covenant",
			"demon_pit",
			"rocket_gunners",
			"ghost",
			"dwarf",
			"pandas",

			"tower_barrack_1",
			"g2_tower_barrack_1",
			"g1_tower_barrack_1",
		},
		mage = {
			"tower_mage_1",
			"g2_tower_mage_1",
			"g1_tower_mage_1",

			"blazing_watcher",
			"infernal_mage",
			"spirit_mausoleum",
			"wicked_sisters",
			"orc_shaman",
			"deep_devils",

			"arcane_wizard",
			"arborean_emissary",
			"elven_stargazers",
			"necromancer",
			"ray",

			"tower_mage_1",
			"g2_tower_mage_1",
			"g1_tower_mage_1",
		},
		engineer = {
			"tower_rock_thrower_1",
			"g2_tower_engineer_1",
			"g1_tower_engineer_1",

			"ignis_altar",
			"melting_furnace",
			"rotten_forest",
			"balloon",
			"rocket_riders",
			"sandworm",

			"tricannon",
			"flamespitter",
			"barrel",
			"hermit_toad",
			"sparking_geode",

			"tower_rock_thrower_1",
			"g2_tower_engineer_1",
			"g1_tower_engineer_1",
		},	
	},
	tower_menu_json = {
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_paladin_covenant",
			type = "paladin_covenant",
			action = "tw_upgrade",
			image = "kra_main_icons_0001",
			preview = "paladin_covenant",
			tt_title = _("TOWER_PALADIN_COVENANT_1_NAME"),
			tt_desc = _("TOWER_PALADIN_COVENANT_1_DESCRIPTION"),
			place = 2,
		},
		{
			check = "kra_main_icons_0019",
			action_arg = "tower_build_royal_archers",
			type = "royal_archers",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "kra_main_icons_0002",
			preview = "royal_archers",
			tt_title = _("TOWER_ROYAL_ARCHERS_1_NAME"),
			tt_desc = _("TOWER_ROYAL_ARCHERS_1_DESCRIPTION"),
			place = 1,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_arcane_wizard",
			type = "arcane_wizard",
			action = "tw_upgrade",
			image = "kra_main_icons_0003",
			preview = "arcane_wizard",
			tt_title = _("TOWER_ARCANE_WIZARD_1_NAME"),
			tt_desc = _("TOWER_ARCANE_WIZARD_1_DESCRIPTION"),
			place = 3,
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
			place = 4,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_arborean_emissary",
			type = "arborean_emissary",
			action = "tw_upgrade",
			image = "kra_main_icons_0006",
			preview = "arborean_emissary",
			tt_title = _("TOWER_ARBOREAN_EMISSARY_1_NAME"),
			tt_desc = _("TOWER_ARBOREAN_EMISSARY_1_DESCRIPTION"),
			place = 12,
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
			place = 1,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_elven_stargazers",
			type = "elven_stargazers",
			action = "tw_upgrade",
			image = "kra_main_icons_0008",
			preview = "elven_stargazers",
			tt_title = _("TOWER_STARGAZER_1_NAME"),
			tt_desc = _("TOWER_STARGAZER_1_DESCRIPTION"),
			place = 4,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_rocket_gunners",
			type = "rocket_gunners",
			action = "tw_upgrade",
			image = "kra_main_icons_0009",
			preview = "rocket_gunners",
			tt_title = _("TOWER_ROCKET_GUNNERS_1_NAME"),
			tt_desc = _("TOWER_ROCKET_GUNNERS_1_DESCRIPTION"),
			place = 1,
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
			place = 11,
		},		
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_necromancer",
			type = "necromancer",
			action = "tw_upgrade",
			image = "kra_main_icons_0011",
			preview = "necromancer",
			tt_title = _("TOWER_NECROMANCER_1_NAME"),
			tt_desc = _("TOWER_NECROMANCER_1_DESCRIPTION"),
			place = 3,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_flamespitter",
			type = "flamespitter",
			action = "tw_upgrade",
			image = "kra_main_icons_0012",
			preview = "flamespitter",
			tt_title = _("TOWER_FLAMESPITTER_1_NAME"),
			tt_desc = _("TOWER_FLAMESPITTER_1_DESCRIPTION"),
			place = 11,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_sand",
			type = "sand",
			action = "tw_upgrade",
			image = "kra_main_icons_0013",
			preview = "sand",
			tt_title = _("TOWER_SAND_1_NAME"),
			tt_desc = _("TOWER_SAND_1_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_ghost",
			type = "ghost",
			action = "tw_upgrade",
			image = "kra_main_icons_0016",
			preview = "ghost",
			tt_title = _("TOWER_GHOST_1_NAME"),
			tt_desc = _("TOWER_GHOST_1_DESCRIPTION"),
			place = 2,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_barrel",
			type = "barrel",
			action = "tw_upgrade",
			image = "kra_main_icons_0017",
			preview = "barrel",
			tt_title = _("TOWER_BARREL_1_NAME"),
			tt_desc = _("TOWER_BARREL_1_DESCRIPTION"),
			place = 2,
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
			place = 3,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_dark_elf",
			type = "dark_elf",
			action = "tw_upgrade",
			image = "kra_main_icons_0032",
			preview = "dark_elf",
			tt_title = _("TOWER_DARK_ELF_1_NAME"),
			tt_desc = _("TOWER_DARK_ELF_1_DESCRIPTION"),
			place = 4,
		},
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
			place = 11,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_dwarf",
			type = "dwarf",
			action = "tw_upgrade",
			image = "kra_main_icons_0039",
			preview = "dwarf",
			tt_title = _("TOWER_DWARF_1_NAME"),
			tt_desc = _("TOWER_DWARF_1_DESCRIPTION"),
			place = 12,
		},
		{
			check = "main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_sparking_geode",
			type = "sparking_geode",
			action = "tw_upgrade",
			image = "kra_main_icons_0042",
			preview = "sparking_geode",
			tt_title = _("TOWER_SPARKING_GEODE_1_NAME"),
			tt_desc = _("TOWER_SPARKING_GEODE_1_DESCRIPTION"),
			place = 12,
		},
		{
			check = "main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_pandas",
			type = "pandas",
			action = "tw_upgrade",
			image = "kra_main_icons_0049",
			preview = "pandas",
			tt_title = _("TOWER_PANDAS_1_NAME"),
			tt_desc = _("TOWER_PANDAS_1_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_twilight_elves_barrack",
			type = "twilight_elves_barrack",
			action = "tw_upgrade",
			image = "krv_main_icons_0017",
			preview = "twilight_elves_barrack",
			tt_title = _("TOWER_TWILIGHT_ELVES_BARRACK_LVL1_NAME"),
			tt_desc = _("TOWER_ELVES_BARRACK_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_blazing_watcher",
			type = "blazing_watcher",
			action = "tw_upgrade",
			image = "krv_main_icons_0014",
			preview = "blazing_watcher",
			tt_title = _("TOWER_DARK_ARMY_BLAZING_WATCHER_MENU_TITLE"),
			tt_desc = _("TOWER_DARK_ARMY_BLAZING_WATCHER_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_ignis_altar",
			type = "ignis_altar",
			action = "tw_upgrade",
			image = "krv_main_icons_0021",
			preview = "ignis_altar",
			tt_title = _("TOWER_DINOS_IGNIS_ALTAR_MENU_TITLE"),
			tt_desc = _("TOWER_DINOS_IGNIS_ALTAR_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_shadow_archer",
			type = "shadow_archer",
			action = "tw_upgrade",
			image = "krv_main_icons_0008",
			preview = "shadow_archer",
			tt_title = _("TOWER_DARK_ARMY_ARCHER_MENU_TITLE"),
			tt_desc = _("TOWER_DARK_ARMY_ARCHER_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_dark_knights",
			type = "dark_knights",
			action = "tw_upgrade",
			image = "krv_main_icons_0011",
			preview = "dark_knights",
			tt_title = _("TOWER_DARK_ARMY_BARRACK_MENU_TITLE"),
			tt_desc = _("TOWER_DARK_ARMY_BARRACK_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_infernal_mage",
			type = "infernal_mage",
			action = "tw_upgrade",
			image = "krv_main_icons_0007",
			preview = "infernal_mage",
			tt_title = _("TOWER_EMBER_LORDS_MAGE_MENU_TITLE"),
			tt_desc = _("TOWER_EMBER_LORDS_MAGE_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_melting_furnace",
			type = "melting_furnace",
			action = "tw_upgrade",
			image = "krv_main_icons_0009",
			preview = "melting_furnace",
			tt_title = _("TOWER_DARK_ARMY_MELTING_FURNACE_MENU_TITLE"),
			tt_desc = _("TOWER_DARK_ARMY_MELTING_FURNACE_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_goblirang",
			type = "goblirang",
			action = "tw_upgrade",
			image = "krv_main_icons_0004",
			preview = "goblirang",
			tt_title = _("TOWER_WARMONGER_ARCHER_MENU_TITLE"),
			tt_desc = _("TOWER_WARMONGER_ARCHER_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_ogre_shipwreck",
			type = "ogre_shipwreck",
			action = "tw_upgrade",
			image = "krv_main_icons_0023",
			preview = "ogre_shipwreck",
			tt_title = _("TOWER_OGRES_MENU_TITLE"),
			tt_desc = _("TOWER_OGRES_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_spirit_mausoleum",
			type = "spirit_mausoleum",
			action = "tw_upgrade",
			image = "krv_main_icons_0010",
			preview = "spirit_mausoleum",
			tt_title = _("TOWER_FALLEN_ONES_SPIRITS_MENU_TITLE"),
			tt_desc = _("TOWER_FALLEN_ONES_SPIRITS_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_rotten_forest",
			type = "rotten_forest",
			action = "tw_upgrade",
			image = "krv_main_icons_0015",
			preview = "rotten_forest",
			tt_title = _("TOWER_ROTTEN_FOREST_MENU_TITLE"),
			tt_desc = _("TOWER_ROTTEN_FOREST_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_shaolin",
			type = "shaolin",
			action = "tw_upgrade",
			image = "krv_main_icons_0019",
			preview = "shaolin",
			tt_title = _("TOWER_SHAOLIN_TEMPLE_MENU_TITLE"),
			tt_desc = _("TOWER_SHAOLIN_TEMPLE_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_swamp_monster",
			type = "swamp_monster",
			action = "tw_upgrade",
			image = "krv_main_icons_0020",
			preview = "swamp_monster",
			tt_title = _("TOWER_SWAMP_MONSTER_MENU_TITLE"),
			tt_desc = _("TOWER_SWAMP_MONSTER_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_wicked_sisters",
			type = "wicked_sisters",
			action = "tw_upgrade",
			image = "krv_main_icons_0016",
			preview = "wicked_sisters",
			tt_title = _("TOWER_WICKED_SISTERS_MENU_TITLE"),
			tt_desc = _("TOWER_WICKED_SISTERS_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_balloon",
			type = "balloon",
			action = "tw_upgrade",
			image = "krv_main_icons_0006",
			preview = "balloon",
			tt_title = _("TOWER_WARMONGER_BALLOON_MENU_TITLE"),
			tt_desc = _("TOWER_WARMONGER_BALLOON_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_bone_flingers",
			type = "bone_flingers",
			action = "tw_upgrade",
			image = "krv_main_icons_0013",
			preview = "bone_flingers",
			tt_title = _("TOWER_FALLEN_ONES_BONE_FLINGERS_MENU_TITLE"),
			tt_desc = _("TOWER_FALLEN_ONES_BONE_FLINGERS_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_orc_warriors_den",
			type = "orc_warriors_den",
			action = "tw_upgrade",
			image = "krv_main_icons_0003",
			preview = "orc_warriors_den",
			tt_title = _("TOWER_WARMONGER_BARRACK_MENU_TITLE"),
			tt_desc = _("TOWER_WARMONGER_BARRACK_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_orc_shaman",
			type = "orc_shaman",
			action = "tw_upgrade",
			image = "krv_main_icons_0002",
			preview = "orc_shaman",
			tt_title = _("TOWER_WARMONGER_MAGE_MENU_TITLE"),
			tt_desc = _("TOWER_WARMONGER_MAGE_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_rocket_riders",
			type = "rocket_riders",
			action = "tw_upgrade",
			image = "krv_main_icons_0005",
			preview = "rocket_riders",
			tt_title = _("TOWER_WARMONGER_ROCKET_MENU_TITLE"),
			tt_desc = _("TOWER_WARMONGER_ROCKET_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_grim_cemetery",
			type = "grim_cemetery",
			action = "tw_upgrade",
			image = "krv_main_icons_0012",
			preview = "grim_cemetery",
			tt_title = _("TOWER_FALLEN_ONES_CEMETERY_MENU_TITLE"),
			tt_desc = _("TOWER_FALLEN_ONES_CEMETERY_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_deep_devils",
			type = "deep_devils",
			action = "tw_upgrade",
			image = "krv_main_icons_0018",
			preview = "deep_devils",
			tt_title = _("TOWER_DEEP_DEVILS_MENU_TITLE"),
			tt_desc = _("TOWER_DEEP_DEVILS_MENU_DESCRIPTION"),
			place = 12,
		},
		{
			check = "kra_main_icons_0019",
			halo = "glow_ico_main",
			action_arg = "tower_build_sandworm",
			type = "sandworm",
			action = "tw_upgrade",
			image = "krv_main_icons_0022",
			preview = "sandworm",
			tt_title = _("TOWER_TREMOR_MENU_TITLE"),
			tt_desc = _("TOWER_TREMOR_LEVEL1_DESCRIPTION"),
			place = 12,
		},

	},
	tower_random_json = {
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_0",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0005",
			place = 5,
			tt_title = _("RANDOM0_LVL1"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_1",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0100",
			place = 1,
			tt_title = _("RANDOM1_LVL1"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_2",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0101",
			place = 2,
			tt_title = _("RANDOM2_LVL1"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_3",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0102",
			place = 3,
			tt_title = _("RANDOM3_LVL1"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_4",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0103",
			place = 4,
			tt_title = _("RANDOM4_LVL1"),
			tt_desc = _("RANDOM_DESC")
		},

		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_20",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0005",
			place = 5,
			tt_title = _("RANDOM0_LVL2"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_21",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0100",
			place = 1,
			tt_title = _("RANDOM1_LVL2"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_22",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0101",
			place = 2,
			tt_title = _("RANDOM2_LVL2"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_23",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0102",
			place = 3,
			tt_title = _("RANDOM3_LVL2"),
			tt_desc = _("RANDOM_DESC")
		},
		{
			check = "main_icons_0019",
			action_arg = "tower_build_random_24",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0103",
			place = 4,
			tt_title = _("RANDOM4_LVL2"),
			tt_desc = _("RANDOM_DESC")
		},
	},
	--本列表严格排序，不能变动
	tower3_menu_json = {
		{
			-- 3代		
				{
					check = "main_icons_0019",
					action_arg = "g1_tower_build_mage",
					action = "tw_upgrade",
					halo = "glow_ico_main",
					image = "g1_main_icons_0003",
					place = 15,
					preview = "g1_mage",
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
					preview = "g1_engineer",
					tt_title = _("G2_TOWER_ENGINEER_1_NAME"),
					tt_desc = _("G2_TOWER_ENGINEER_1_DESCRIPTION")
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
					action_arg = "g1_tower_build_archer",
					action = "tw_upgrade",
					halo = "glow_ico_main",
					image = "g1_main_icons_0001",
					place = 13,--1,
					preview = "g1_archer",
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
					preview = "g1_barrack",
					tt_title = _("G2_TOWER_BARRACK_1_NAME"),
					tt_desc = _("G2_TOWER_BARRACK_1_DESCRIPTION")
				},																				
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

		},
	},
	cheat_json = {
		check = "main_icons_0019",
		action_arg = "tower_hero_buy",
		action = "tw_upgrade",
		halo = "glow_ico_main",
		image = "main_icons_0005",
		place = 9,
		tt_title = _("CHEAT"),
		tt_desc = _("CHEAT")
	},
	gold_json = {
			check = "main_icons_0019",
			action_arg = "Goldfinger",
			action = "tw_upgrade",
			halo = "glow_ico_main",
			image = "main_icons_0005",
			place = 9,
			tt_title = _("CHEAT"),
			tt_desc = _("CHEAT1")
	},
	cheat_g5_json = {
		check = "main_icons_0019",
		action_arg = "g5_special_buy",
		action = "tw_upgrade",
		halo = "glow_ico_main",
		image = "main_icons_0005",
		place = 9,
		tt_title = _("CHEAT_8"),
		tt_desc = _("CHEAT1")
	},
	map_animations3 = {
		{
			id = "ma_george_shout_1",
			layer = 1,
			wait = {
				2,
				6
			},
			animation = {
				to = 103,
				prefix = "ma_george_shout",
				from = 1
			},
			pos_list = {
				v(153, 484),
				v(153, 528),
				v(97, 490),
				v(210, 511),
				v(439, 553),
				v(152, 690)
			},
			scale_list = {
				v(-1, 1),
				v(1, 1),
				v(1, 1),
				v(-1, 1),
				v(1, 1),
				v(-1, 1)
			}
		},
		{
			id = "ma_venom_vine_1",
			layer = 1,
			pos = v(785, 664),
			wait = {
				8,
				12
			},
			action_animation = {
				to = 79,
				prefix = "ma_venom_vine",
				from = 49
			},
			idle_animation = {
				to = 48,
				prefix = "ma_venom_vine",
				from = 1
			}
		},
		{
			id = "ma_ft_bubbles",
			layer = 1,
			pos = v(1364, 263),
			wait = {
				1,
				3
			},
			animation = {
				to = 74,
				prefix = "ma_ft_bubbles",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_ft_smoke",
			layer = 1,
			pos = v(1369, 218),
			animation = {
				to = 60,
				prefix = "ma_ft_smoke",
				from = 1
			}
		},
		{
			id = "ma_hr_crystals",
			layer = 1,
			pos = v(793, 196),
			wait = {
				8,
				12
			},
			animation = {
				to = 32,
				prefix = "ma_hr_crystals",
				from = 1
			}
		},
		{
			id = "ma_hr_sparks",
			layer = 1,
			pos = v(793, 194),
			wait = {
				4,
				8
			},
			animation = {
				to = 42,
				prefix = "ma_hr_sparks",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_lake_water_sparks",
			layer = 1,
			pos = v(845, 503),
			animation = {
				to = 24,
				prefix = "ma_lake_water_sparks",
				from = 1
			}
		},
		{
			id = "ma_lake_crystals",
			layer = 1,
			pos = v(848, 495),
			wait = {
				8,
				12
			},
			animation = {
				to = 43,
				prefix = "ma_lake_crystals",
				from = 1
			}
		},
		{
			id = "ma_lake_sparks",
			layer = 1,
			pos = v(845, 495),
			wait = {
				4,
				8
			},
			animation = {
				to = 45,
				prefix = "ma_lake_sparks",
				from = 1
			}
		},
		{
			id = "ma_lake_serpent",
			layer = 1,
			wait = {
				6,
				12
			},
			pos_list = {
				v(846, 496),
				v(846, 496)
			},
			scale_list = {
				v(1, 1),
				v(-1, 1)
			},
			animation = {
				to = 66,
				prefix = "ma_lake_serpent",
				from = 1
			}
		},
		{
			id = "ma_metro_spider_1",
			layer = 2,
			pos = v(1721, 632),
			wait = {
				3,
				5
			},
			animation = {
				to = 35,
				prefix = "ma_metro_spider_1",
				from = 1
			}
		},
		{
			id = "ma_metro_spider_2",
			layer = 2,
			pos = v(1783, 671),
			wait = {
				3,
				5
			},
			animation = {
				to = 36,
				prefix = "ma_metro_spider_2",
				from = 1
			}
		},
		{
			id = "ma_metro_spider_3",
			layer = 2,
			pos = v(1721, 753),
			wait = {
				3,
				5
			},
			animation = {
				to = 34,
				prefix = "ma_metro_spider_3",
				from = 1
			}
		},
		{
			id = "ma_br_tree",
			layer = 1,
			pos = v(1541, 375),
			wait = {
				4,
				8
			},
			action_animation = {
				to = 89,
				prefix = "ma_br_tree",
				from = 40
			},
			idle_animation = {
				to = 39,
				prefix = "ma_br_tree",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_br_castle_flame",
			layer = 1,
			pos = v(1767, 231),
			animation = {
				to = 14,
				prefix = "ma_br_castle_flame",
				from = 1
			}
		},
		{
			id = "ma_br_castle_glow",
			layer = 1,
			pos = v(1769, 266),
			wait = {
				1,
				3
			},
			animation = {
				to = 90,
				prefix = "ma_br_castle_glow",
				from = 1
			}
		},
		{
			id = "ma_broom",
			layer = 1,
			pos = v(1662, 480),
			wait = {
				4,
				10
			},
			animation = {
				to = 166,
				prefix = "ma_broom",
				from = 1
			}
		},
		{
			layer = 3,
			id = "ma_gryphon",
			move = {
				time = 8,
				from = v(-30, 700),
				to = v(1000, 1200)
			},
			wait = {
				10,
				20
			},
			animation = {
				to = 16,
				prefix = "ma_gryphon",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_hr_worker",
			layer = 1,
			pos = v(724, 231),
			animation = {
				to = 34,
				prefix = "ma_hr_worker",
				from = 1
			}
		},
		{
			id = "ma_hr_worker_2",
			layer = 1,
			pos = v(804, 227),
			wait = {
				4,
				10
			},
			animation = {
				to = 143,
				prefix = "ma_hr_worker_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_lake_waterfall",
			layer = 1,
			pos = v(801, 503),
			animation = {
				to = 20,
				prefix = "ma_lake_waterfall",
				from = 1
			}
		},
		{
			id = "ma_magic_flower_1",
			layer = 2,
			pos = v(498, 831),
			wait = {
				3,
				6
			},
			action_animation = {
				to = 66,
				prefix = "ma_magic_flower",
				from = 36
			},
			idle_animation = {
				to = 35,
				prefix = "ma_magic_flower",
				from = 1
			}
		},
		{
			id = "ma_magic_flower_2",
			template = "ma_magic_flower_1",
			pos = v(380, 279),
			wait = {
				4,
				8
			}
		},
		{
			loop = true,
			id = "ma_metro_diamond",
			layer = 1,
			pos = v(1798, 508),
			animation = {
				to = 147,
				prefix = "ma_metro_diamond",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_metro_ducks",
			move = {
				time = 10,
				from = v(800, 1100),
				to = v(1950, 500)
			},
			wait = {
				10,
				30
			},
			animation = {
				to = 8,
				prefix = "ma_metro_ducks",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_pixie_1",
			layer = 1,
			pos = v(1107, 408),
			animation = {
				to = 21,
				prefix = "ma_pixie_1",
				from = 1
			}
		},
		{
			id = "ma_pixie_2",
			layer = 1,
			pos = v(1042, 425),
			wait = {
				5,
				15
			},
			animation = {
				to = 77,
				prefix = "ma_pixie_2",
				from = 1
			}
		},
		{
			loop = true,
			alpha = 1,
			id = "ma_waterfall1_foam",
			layer = 1,
			pos = v(86, 439),
			animation = {
				to = 20,
				prefix = "ma_waterfall1_foam",
				from = 1
			}
		},
		{
			loop = true,
			alpha = 0.5,
			id = "ma_waterfall1_sparks",
			layer = 1,
			pos = v(67, 394),
			animation = {
				to = 20,
				prefix = "ma_waterfall1_sparks",
				from = 1
			}
		},
		{
			loop = true,
			alpha = 0.5,
			id = "ma_waterfall1_sparks_top",
			layer = 1,
			pos = v(45, 334),
			animation = {
				to = 20,
				prefix = "ma_waterfall1_sparks_top",
				from = 1
			}
		},
		{
			loop = true,
			alpha = 1,
			id = "ma_waterfall2_foam",
			layer = 1,
			pos = v(170, 470),
			animation = {
				to = 20,
				prefix = "ma_waterfall2_foam",
				from = 1
			}
		},
		{
			loop = true,
			alpha = 0.5,
			id = "ma_waterfall2_sparks",
			layer = 1,
			pos = v(167, 419),
			animation = {
				to = 20,
				prefix = "ma_waterfall2_sparks",
				from = 1
			}
		},
		{
			id = "ma_wolf",
			layer = 1,
			pos = v(920, 661),
			wait = {
				4,
				10
			},
			animation = {
				to = 45,
				prefix = "ma_wolf",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_f_castle_glows",
			layer = 1,
			pos = v(1343, 535),
			animation = {
				to = 120,
				prefix = "ma_f_casle_glows",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_f_castle_spotlights",
			layer = 1,
			pos = v(1349, 536),
			animation = {
				to = 120,
				prefix = "ma_f_casle_spotlights",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_wisps_1_1",
			layer = 1,
			pos = v(1000, 552),
			animation = {
				to = 84,
				prefix = "wisps_1",
				from = 1
			}
		},
		{
			id = "ma_wisps_1_2",
			template = "ma_wisps_1_1",
			pos = v(900, 628)
		},
		{
			id = "ma_wisps_1_3",
			template = "ma_wisps_1_1",
			pos = v(1312, 407)
		},
		{
			id = "ma_wisps_1_4",
			template = "ma_wisps_1_1",
			pos = v(1140, 449)
		},
		{
			id = "ma_wisps_1_5",
			template = "ma_wisps_1_1",
			pos = v(1155, 908)
		},
		{
			loop = true,
			id = "ma_wisps_2_1",
			layer = 1,
			pos = v(1018, 462),
			animation = {
				to = 84,
				prefix = "wisps_2",
				from = 1
			}
		},
		{
			id = "ma_wisps_2_2",
			template = "ma_wisps_2_1",
			pos = v(1258, 338)
		},
		{
			id = "ma_wisps_2_3",
			template = "ma_wisps_2_1",
			pos = v(976, 348)
		},
		{
			id = "ma_wisps_2_4",
			template = "ma_wisps_2_1",
			pos = v(1139, 723)
		},
		{
			id = "ma_wisps_2_5",
			template = "ma_wisps_2_1",
			pos = v(886, 928)
		},
		{
			loop = true,
			id = "ma_wisps_3_1",
			layer = 1,
			pos = v(1177, 608),
			animation = {
				to = 84,
				prefix = "wisps_3",
				from = 1
			}
		},
		{
			id = "ma_wisps_3_2",
			template = "ma_wisps_3_1",
			pos = v(940, 1005)
		},
		{
			id = "ma_wisps_3_3",
			template = "ma_wisps_3_1",
			pos = v(1063, 747)
		},
		{
			id = "ma_wisps_3_4",
			template = "ma_wisps_3_1",
			pos = v(1376, 361)
		},
		{
			id = "ma_wisps_3_5",
			template = "ma_wisps_3_1",
			pos = v(1086, 313)
		},
		{
			loop = true,
			id = "ma_wisps_4_1",
			layer = 1,
			pos = v(1238, 556),
			animation = {
				to = 84,
				prefix = "wisps_4",
				from = 1
			}
		},
		{
			id = "ma_wisps_4_2",
			template = "ma_wisps_4_1",
			pos = v(1161, 812)
		},
		{
			id = "ma_wisps_4_3",
			template = "ma_wisps_4_1",
			pos = v(1048, 901)
		},
		{
			id = "ma_wisps_4_4",
			template = "ma_wisps_4_1",
			pos = v(856, 418)
		},
		{
			id = "ma_wisps_4_5",
			template = "ma_wisps_4_1",
			pos = v(885, 816)
		},
		{
			id = "ma_wisps_5_1",
			layer = 1,
			pos = v(1256, 679),
			wait = {
				2,
				6
			},
			animation = {
				to = 58,
				prefix = "wisps_5",
				from = 1
			}
		},
		{
			id = "ma_wisps_5_2",
			template = "ma_wisps_5_1",
			pos = v(1082, 641)
		},
		{
			id = "ma_wisps_6_1",
			layer = 1,
			pos = v(1194, 332),
			wait = {
				2,
				6
			},
			animation = {
				to = 26,
				prefix = "wisps_6",
				from = 1
			}
		},
		{
			id = "ma_wisps_6_2",
			template = "ma_wisps_6_1",
			pos = v(1179, 421)
		},
		{
			id = "ma_wisps_7_1",
			layer = 1,
			pos = v(975, 396),
			wait = {
				2,
				6
			},
			animation = {
				to = 40,
				prefix = "wisps_7",
				from = 1
			}
		},
		{
			id = "ma_wisps_7_2",
			template = "ma_wisps_7_1",
			pos = v(801, 460)
		},
		{
			id = "ma_wisps_8_1",
			layer = 1,
			pos = v(1074, 414),
			wait = {
				2,
				6
			},
			animation = {
				to = 26,
				prefix = "wisps_8",
				from = 1
			}
		},
		{
			id = "ma_wisps_8_2",
			template = "ma_wisps_8_1",
			pos = v(885, 780)
		},
		{
			id = "ma_wisps_9_1",
			layer = 1,
			pos = v(899, 747),
			wait = {
				2,
				6
			},
			animation = {
				to = 22,
				prefix = "wisps_9",
				from = 1
			}
		},
		{
			id = "ma_wisps_9_2",
			template = "ma_wisps_9_1",
			pos = v(1097, 603)
		},
		{
			id = "ma_wisps_10_1",
			layer = 1,
			pos = v(1080, 838),
			wait = {
				2,
				6
			},
			animation = {
				to = 24,
				prefix = "wisps_10",
				from = 1
			}
		},
		{
			id = "ma_wisps_10_2",
			template = "ma_wisps_10_1",
			pos = v(1367, 424)
		},
		{
			loop = true,
			id = "ma_river_ne_1",
			layer = 1,
			pos = v(862, 367),
			animation = {
				to = 20,
				prefix = "ma_river_ne_1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_river_ne_2",
			layer = 1,
			pos = v(1014, 301),
			animation = {
				to = 20,
				prefix = "ma_river_ne_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_river_ne_3",
			layer = 1,
			pos = v(1153, 261),
			animation = {
				to = 20,
				prefix = "ma_river_ne_3",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_river_ne_4",
			layer = 1,
			pos = v(1266, 193),
			animation = {
				to = 20,
				prefix = "ma_river_ne_4",
				from = 1
			}
		},
		{
			loop = true,
			alpha = 0.6,
			id = "ma_river_nw_1",
			layer = 1,
			pos = v(637, 357),
			animation = {
				to = 20,
				prefix = "ma_river_nw_1",
				from = 1
			}
		},
		{
			loop = true,
			alpha = 0.4,
			id = "ma_river_nw_2",
			layer = 1,
			pos = v(550, 218),
			animation = {
				to = 20,
				prefix = "ma_river_nw_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_river_s_1",
			layer = 1,
			pos = v(730, 677),
			animation = {
				to = 20,
				prefix = "ma_river_s_1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_river_s_2",
			layer = 1,
			pos = v(804, 846),
			animation = {
				to = 20,
				prefix = "ma_river_s_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_river_s_3",
			layer = 1,
			pos = v(807, 976),
			animation = {
				to = 20,
				prefix = "ma_river_s_3",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_0",
			layer = 1,
			pos = v(100, 122),
			wait = {
				0,
				1
			},
			animation = {
				to = 143,
				prefix = "ma_sea_bounce_0",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_1",
			layer = 1,
			pos = v(119, 120),
			wait = {
				0,
				1
			},
			animation = {
				to = 133,
				prefix = "ma_sea_bounce_1",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_2",
			layer = 1,
			pos = v(311, 82),
			wait = {
				0,
				1
			},
			animation = {
				to = 137,
				prefix = "ma_sea_bounce_2",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_3",
			layer = 1,
			pos = v(447, 114),
			wait = {
				0,
				1
			},
			animation = {
				to = 120,
				prefix = "ma_sea_bounce_3",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_4",
			layer = 1,
			pos = v(625, 89),
			wait = {
				0,
				1
			},
			animation = {
				to = 120,
				prefix = "ma_sea_bounce_4",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_5",
			layer = 1,
			pos = v(821, 73),
			wait = {
				0,
				1
			},
			animation = {
				to = 120,
				prefix = "ma_sea_bounce_5",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_6",
			layer = 1,
			pos = v(1005, 62),
			wait = {
				0,
				1
			},
			animation = {
				to = 141,
				prefix = "ma_sea_bounce_6",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_7",
			layer = 1,
			pos = v(1203, 68),
			wait = {
				0,
				1
			},
			animation = {
				to = 120,
				prefix = "ma_sea_bounce_7",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_8",
			layer = 1,
			pos = v(1323, 143),
			wait = {
				0,
				1
			},
			animation = {
				to = 137,
				prefix = "ma_sea_bounce_8",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_9",
			layer = 1,
			pos = v(1505, 121),
			wait = {
				0,
				1
			},
			animation = {
				to = 193,
				prefix = "ma_sea_bounce_9",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_10",
			layer = 1,
			pos = v(1636, 150),
			wait = {
				0,
				1
			},
			animation = {
				to = 140,
				prefix = "ma_sea_bounce_10",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_11",
			layer = 1,
			pos = v(1840, 195),
			wait = {
				0,
				1
			},
			animation = {
				to = 120,
				prefix = "ma_sea_bounce_11",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_12",
			layer = 1,
			pos = v(309, 135),
			wait = {
				0,
				1
			},
			animation = {
				to = 121,
				prefix = "ma_sea_bounce_12",
				from = 1
			}
		},
		{
			id = "ma_sea_bounce_13",
			layer = 1,
			pos = v(300, 27),
			wait = {
				0,
				1
			},
			animation = {
				to = 157,
				prefix = "ma_sea_bounce_13",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_sea_sparks_1",
			layer = 1,
			pos = v(31, 22),
			animation = {
				to = 24,
				prefix = "ma_sea_sparks_1",
				from = 1
			}
		},
		{
			id = "ma_sea_sparks_2",
			template = "ma_sea_sparks_1",
			pos = v(1409, 10)
		},
		{
			id = "ma_sea_sparks_3",
			template = "ma_sea_sparks_1",
			pos = v(276, 133)
		},
		{
			id = "ma_sea_sparks_4",
			template = "ma_sea_sparks_1",
			pos = v(1481, 44)
		},
		{
			id = "ma_sea_sparks_5",
			template = "ma_sea_sparks_1",
			pos = v(1890, 22)
		},
		{
			id = "ma_sea_sparks_6",
			template = "ma_sea_sparks_1",
			pos = v(1870, 123)
		},
		{
			id = "ma_sea_sparks_7",
			template = "ma_sea_sparks_1",
			pos = v(1628, 13)
		},
		{
			id = "ma_sea_sparks_8",
			template = "ma_sea_sparks_1",
			pos = v(1570, 146)
		},
		{
			id = "ma_sea_sparks_9",
			template = "ma_sea_sparks_1",
			pos = v(1751, 176)
		},
		{
			id = "ma_sea_sparks_10",
			template = "ma_sea_sparks_1",
			pos = v(990, 5)
		},
		{
			id = "ma_sea_sparks_11",
			template = "ma_sea_sparks_1",
			pos = v(778, 40)
		},
		{
			id = "ma_sea_sparks_12",
			template = "ma_sea_sparks_1",
			pos = v(1288, 37)
		},
		{
			id = "ma_sea_sparks_13",
			template = "ma_sea_sparks_1",
			pos = v(1149, 6)
		},
		{
			id = "ma_sea_sparks_14",
			template = "ma_sea_sparks_1",
			pos = v(847, 17)
		},
		{
			id = "ma_sea_sparks_15",
			template = "ma_sea_sparks_1",
			pos = v(690, 25)
		},
		{
			id = "ma_sea_sparks_16",
			template = "ma_sea_sparks_1",
			pos = v(592, 8)
		},
		{
			id = "ma_sea_sparks_17",
			template = "ma_sea_sparks_1",
			pos = v(515, 55)
		},
		{
			id = "ma_sea_sparks_18",
			template = "ma_sea_sparks_1",
			pos = v(442, 25)
		},
		{
			id = "ma_sea_sparks_19",
			template = "ma_sea_sparks_1",
			pos = v(131, 22)
		},
		{
			id = "ma_sea_sparks_20",
			template = "ma_sea_sparks_1",
			pos = v(169, 82)
		},
		{
			loop = true,
			layer = 1,
			id = "ma_metro_c1",
			move = {
				time = 6,
				permanent = true,
				pingpong = true,
				interp = "in-out-sine",
				from = v(953, 539),
				to = v(967, 541)
			},
			wait = {
				0,
				0
			},
			animation = {
				to = 11,
				prefix = "map_background",
				from = 11
			}
		},
		{
			id = "ma_metro_c2",
			template = "ma_metro_c1",
			move = {
				time = 7,
				from = v(966, 538),
				to = v(954, 542)
			},
			animation = {
				from = 12,
				to = 12
			}
		},
		{
			loop = true,
			id = "ma_metro_0",
			layer = 1,
			pos = v(960, 540),
			animation = {
				to = 4,
				prefix = "map_background",
				from = 4
			}
		},
		{
			loop = true,
			layer = 1,
			id = "ma_metro_1",
			move = {
				time = 3,
				permanent = true,
				pingpong = true,
				interp = "in-out-sine",
				from = v(960, 538),
				to = v(960, 542)
			},
			wait = {
				0,
				0
			},
			animation = {
				to = 5,
				prefix = "map_background",
				from = 5
			}
		},
		{
			id = "ma_metro_2",
			template = "ma_metro_1",
			move = {
				time = 1,
				from = {
					y = 539
				},
				to = {
					y = 542
				}
			},
			animation = {
				from = 6,
				to = 6
			}
		},
		{
			id = "ma_metro_3",
			template = "ma_metro_1",
			move = {
				time = 2,
				from = {
					y = 538
				},
				to = {
					y = 541
				}
			},
			animation = {
				from = 7,
				to = 7
			}
		},
		{
			id = "ma_metro_4",
			template = "ma_metro_1",
			move = {
				time = 3,
				from = {
					y = 539
				},
				to = {
					y = 542
				}
			},
			animation = {
				from = 8,
				to = 8
			}
		},
		{
			id = "ma_metro_5",
			template = "ma_metro_1",
			move = {
				time = 1,
				from = {
					y = 538
				},
				to = {
					y = 542
				}
			},
			animation = {
				from = 9,
				to = 9
			}
		},
		{
			id = "ma_metro_6",
			template = "ma_metro_1",
			move = {
				time = 2.2,
				from = {
					y = 538
				},
				to = {
					y = 542
				}
			},
			animation = {
				from = 10,
				to = 10
			}
		},
		{
			id = "ma_hood_l",
			layer = 2,
			pos = v(1010, 658),
			fns = {
				prepare = deco_fn.ani_seq.prepare
			},
			animations = {
				default = {
					to = 1,
					prefix = "ma_hood",
					from = 1
				},
				left = {
					to = 77,
					prefix = "ma_hood",
					from = 1
				},
				right = {
					to = 156,
					prefix = "ma_hood",
					from = 78
				}
			},
			sequence = {
				{
					"default",
					3,
					6
				},
				{
					"left",
					1,
					3
				},
				{
					"right",
					1,
					3
				}
			}
		},
		{
			id = "ma_ewok",
			layer = 1,
			pos = v(160, 600),
			fns = {
				prepare = deco_fn.ani_seq.prepare
			},
			sequence = {
				{
					"default",
					3,
					5
				},
				{
					"go_out",
					1,
					3
				},
				{
					"left",
					1,
					3
				},
				{
					"right",
					1,
					3
				},
				{
					"left",
					1,
					2
				},
				{
					"right",
					1,
					2
				},
				{
					"go_in",
					0,
					0
				}
			},
			animations = {
				default = {
					to = 89,
					prefix = "ma_ewok",
					from = 89
				},
				go_out = {
					to = 46,
					prefix = "ma_ewok",
					from = 1
				},
				go_in = {
					to = 89,
					prefix = "ma_ewok",
					from = 50
				},
				right = {
					to = 46,
					prefix = "ma_ewok",
					from = 49
				},
				left = {
					to = 49,
					prefix = "ma_ewok",
					from = 46
				}
			}
		},
		{
			id = "ma_hr_dragon",
			layer = 2,
			pos = v(1120, 66),
			fns = {
				prepare = deco_fn.ani_seq.prepare
			},
			animations = {
				default = {
					to = 1,
					prefix = "ma_hr_dragon",
					from = 1
				},
				flame = {
					to = 50,
					prefix = "ma_hr_dragon",
					from = 1
				},
				tail = {
					to = 74,
					prefix = "ma_hr_dragon",
					from = 51
				},
				blink = {
					to = 87,
					prefix = "ma_hr_dragon",
					from = 75
				},
				move = {
					to = 140,
					prefix = "ma_hr_dragon",
					from = 88
				}
			},
			sequence = {
				{
					"blink",
					2,
					3
				},
				{
					"blink",
					2,
					3
				},
				{
					"move",
					1,
					2
				},
				{
					"blink",
					2,
					3
				},
				{
					"tail",
					1,
					2
				},
				{
					"blink",
					2,
					3
				},
				{
					"blink",
					2,
					3
				},
				{
					"tail",
					1,
					2
				},
				{
					"move",
					1,
					2
				},
				{
					"blink",
					2,
					3
				},
				{
					"flame",
					1,
					2
				},
				{
					"blink",
					2,
					3
				},
				{
					"move",
					1,
					2
				},
				{
					"blink",
					2,
					3
				},
				{
					"tail",
					1,
					2
				}
			}
		},
		{
			speed_x = 50,
			loop = true,
			id = "ma_waterfall1_barrel",
			layer = 1,
			pos = v(-10, 307),
			fns = {
				prepare = deco_fn.ma_waterfall1_barrel.prepare
			},
			wait_out = {
				8,
				12
			},
			sequence = {
				{
					"idle",
					v(88, 337)
				},
				{
					"fall",
					v(110, 418)
				},
				{
					"crash",
					v(105, 418)
				}
			},
			animations = {
				default = {
					to = 30,
					prefix = "ma_waterfall1_barrel",
					from = 1
				},
				idle = {
					to = 30,
					prefix = "ma_waterfall1_barrel",
					from = 1
				},
				fall = {
					to = 60,
					prefix = "ma_waterfall1_barrel",
					from = 31
				},
				crash = {
					to = 80,
					prefix = "ma_waterfall1_barrel",
					from = 61
				}
			}
		},
		{
			sail_time = 10,
			id = "ma_ship",
			wait_in = 12.5,
			loop = true,
			wait_out = 15,
			layer = 1,
			pos = v(253, 153),
			fns = {
				prepare = deco_fn.ma_ship.prepare
			},
			pos_in = v(194, 114),
			pos_out = v(-90, -90),
			animations = {
				in_sail = {
					to = 45,
					prefix = "ma_ship_in",
					from = 1
				},
				in_idle = {
					to = 120,
					prefix = "ma_ship_in",
					from = 46
				},
				in_trail = {
					to = 45,
					prefix = "ma_ship_trail_in",
					from = 1
				},
				out_sail = {
					to = 45,
					prefix = "ma_ship_out",
					from = 1
				},
				out_idle = {
					to = 120,
					prefix = "ma_ship_out",
					from = 46
				},
				out_trail = {
					to = 45,
					prefix = "ma_ship_trail_out",
					from = 1
				}
			}
		}
	},
	map_decos3 = {
		{
			layer = 3,
			id = "md_ft_mountain",
			image = "map_background_0002",
			trigger_level = 21,
			pos = v(960, 540),
			hit_rect = r(1240, 110, 300, 240),
			fns = {
				unlock = deco_fn.md_ft_mountain.unlock
			}
		}
	},
	--1代
	map_animations1 = {
		{
			sail_time = 15,
			id = "ma_big_boat",
			wait_in = 12.5,
			loop = true,
			wait_out = 15,
			layer = 2,
			pos = v(216, 900),
			fns = {
				prepare = deco_fn.ma_big_boat.prepare
			},
			pos_in = v(216, 900),
			pos_out = v(-80, 1000),
			animations = {
				in_sail = {
					to = 301,
					prefix = "bigBoat",
					from = 245
				},
				in_idle = {
					to = 167,
					prefix = "bigBoat",
					from = 85
				},
				out_sail = {
					to = 244,
					prefix = "bigBoat",
					from = 189
				},
				out_idle = {
					to = 84,
					prefix = "bigBoat",
					from = 1
				}
			}
		},
		{
			loop = true,
			id = "ma_boats",
			layer = 2,
			pos = v(423, 955),
			animation = {
				to = 110,
				prefix = "boats",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_fire",
			layer = 3,
			pos = v(1735, 673),
			animation = {
				to = 24,
				prefix = "darkTower_fire",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_glow",
			layer = 3,
			pos = v(1735, 673),
			animation = {
				to = 96,
				prefix = "darkTower_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_fog",
			layer = 3,
			pos = v(1735, 705),
			scale = v(1.8, 1.8),
			animation = {
				to = 118,
				prefix = "darktower_fog",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_left_glow",
			layer = 1,
			pos = v(1625, 794),
			animation = {
				to = 96,
				prefix = "darkTower_river_left_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_left_lava",
			layer = 1,
			pos = v(1627, 794),
			animation = {
				to = 52,
				prefix = "darkTower_river_left_lava",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_right_glow",
			layer = 1,
			pos = v(1818, 794),
			animation = {
				to = 96,
				prefix = "darkTower_river_right_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_right_lava",
			layer = 1,
			pos = v(1819, 796),
			animation = {
				to = 52,
				prefix = "darkTower_river_right_lava",
				from = 1
			}
		},
		{
			id = "ma_eagle",
			layer = 2,
			pos = v(958, 85),
			wait = {
				2,
				3
			},
			animation = {
				to = 203,
				prefix = "eagle_1",
				from = 1
			}
		},
		{
			id = "ma_fisher man",
			layer = 2,
			pos = v(456, 898),
			wait = {
				1,
				5
			},
			animation = {
				to = 172,
				prefix = "fisherMan",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_flags",
			layer = 2,
			pos = v(771, 558),
			animation = {
				to = 15,
				prefix = "flags",
				from = 1
			}
		},
		{
			id = "ma_ghost",
			layer = 2,
			pos = v(1485, 455),
			wait = {
				3,
				12
			},
			animation = {
				to = 188,
				prefix = "ghost",
				from = 1
			}
		},
		{
			id = "ma_north_lights",
			layer = 2,
			pos = v(1423, 272),
			wait = {
				8,
				15
			},
			scale = v(0.8, 0.8),
			animation = {
				to = 25,
				prefix = "ma_north_lights",
				from = 1
			}
		},
		{
			id = "ma_hacker",
			layer = 2,
			pos = v(378, 431),
			wait = {
				1,
				3
			},
			animation = {
				to = 255,
				prefix = "hacker",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_light tower",
			layer = 2,
			pos = v(655, 948),
			animation = {
				to = 119,
				prefix = "lighTower",
				from = 1
			}
		},
		{
			id = "ma_mobiDick",
			layer = 2,
			pos = v(1099, 55),
			wait = {
				2,
				10
			},
			animation = {
				to = 224,
				prefix = "mobiDick",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_molinos1",
			layer = 2,
			pos = v(111, 781),
			animation = {
				to = 24,
				prefix = "molino",
				from = 1
			}
		},
		{
			id = "ma_molinos2",
			template = "ma_molinos1",
			pos = v(145, 765)
		},
		{
			id = "ma_molinos3",
			template = "ma_molinos1",
			pos = v(694, 805)
		},
		{
			id = "ma_molinos4",
			template = "ma_molinos1",
			pos = v(721, 834)
		},
		{
			id = "ma_molinos5",
			template = "ma_molinos1",
			pos = v(747, 799)
		},
		{
			id = "ma_rottenBubbles1",
			layer = 2,
			pos = v(1757, 309),
			wait = {
				3,
				12
			},
			animation = {
				to = 47,
				prefix = "rottenBubble",
				from = 1
			}
		},
		{
			id = "ma_rottenBubbles2",
			template = "ma_rottenBubbles1",
			pos = v(1780, 313)
		},
		{
			id = "ma_rottenBubbles3",
			template = "ma_rottenBubbles1",
			pos = v(1796, 283)
		},
		{
			id = "ma_rottenBubbles4",
			template = "ma_rottenBubbles1",
			pos = v(1798, 300)
		},
		{
			id = "ma_rottenBubbles5",
			template = "ma_rottenBubbles1",
			pos = v(1821, 304)
		},
		{
			loop = true,
			id = "ma_rottenFog01",
			layer = 2,
			pos = v(1828, 208),
			animation = {
				to = 110,
				prefix = "rottenFogClip",
				from = 1
			}
		},
		{
			id = "ma_rottenFog02",
			template = "ma_rottenFog01",
			pos = v(1880, 173)
		},
		{
			id = "ma_rottenFog03",
			template = "ma_rottenFog01",
			pos = v(1807, 212),
			scale = v(1.5, 1.5)
		},
		{
			id = "ma_rottenFog04",
			template = "ma_rottenFog01",
			pos = v(1695, 212),
			scale = v(1.7, 1.7)
		},
		{
			id = "ma_rottenFog05",
			template = "ma_rottenFog01",
			pos = v(1743, 158),
			scale = v(1.5, 1.5)
		},
		{
			id = "ma_rottenFog06",
			template = "ma_rottenFog01",
			pos = v(1699, 248),
			scale = v(1, 1)
		},
		{
			id = "ma_rottenFog07",
			template = "ma_rottenFog01",
			pos = v(1637, 189),
			scale = v(1.3, 1.3)
		},
		{
			id = "ma_rottenFog08",
			template = "ma_rottenFog01",
			pos = v(1581, 260),
			scale = v(1.5, 1.5)
		},
		{
			id = "ma_rottenFog09",
			template = "ma_rottenFog01",
			pos = v(1600, 332),
			scale = v(1.1, 1.1)
		},
		{
			id = "ma_rottenFog10",
			template = "ma_rottenFog01",
			pos = v(1642, 288),
			scale = v(1.3, 1.3)
		},
		{
			id = "ma_rottenFog11",
			template = "ma_rottenFog01",
			pos = v(1700, 331),
			scale = v(1.4, 1.4)
		},
		{
			id = "ma_rottenFog12",
			template = "ma_rottenFog01",
			pos = v(1794, 384),
			scale = v(1.6, 1.6)
		},
		{
			id = "ma_rottenFog13",
			template = "ma_rottenFog01",
			pos = v(1862, 333),
			scale = v(1.7, 1.7)
		},
		{
			id = "ma_sheep1",
			layer = 2,
			pos = v(240, 758),
			wait = {
				1,
				8
			},
			animation = {
				to = 18,
				prefix = "sheep",
				from = 1
			}
		},
		{
			id = "ma_sheep2",
			template = "ma_sheep1",
			pos = v(250, 775),
			scale = v(-1, 1)
		},
		{
			id = "ma_sheep3",
			template = "ma_sheep1",
			pos = v(362, 807)
		},
		{
			id = "ma_sheep4",
			template = "ma_sheep1",
			pos = v(664, 797),
			scale = v(-1, 1)
		},
		{
			id = "ma_sheep5",
			template = "ma_sheep1",
			pos = v(757, 835)
		},
		{
			id = "ma_sheepSmall1",
			layer = 2,
			pos = v(380, 817),
			wait = {
				1,
				8
			},
			animation = {
				to = 18,
				prefix = "sheepSmall",
				from = 1
			}
		},
		{
			id = "ma_sheepSmall2",
			template = "ma_sheepSmall1",
			pos = v(776, 845)
		},
		{
			id = "ma_sheepSmall3",
			template = "ma_sheepSmall1",
			pos = v(227, 774),
			scale = v(-1, 1)
		},
		{
			loop = true,
			id = "ma_smoke1",
			layer = 2,
			pos = v(436, 742),
			animation = {
				to = 30,
				prefix = "smoke",
				from = 1
			}
		},
		{
			id = "ma_smoke2",
			template = "ma_smoke1",
			pos = v(534, 183)
		},
		{
			loop = true,
			id = "ma_snow01",
			layer = 2,
			pos = v(1098, 136),
			animation = {
				to = 35,
				prefix = "snowClip",
				from = 1
			}
		},
		{
			id = "ma_snow02",
			template = "ma_snow01",
			pos = v(1216, 155)
		},
		{
			id = "ma_snow03",
			template = "ma_snow01",
			pos = v(1190, 281)
		},
		{
			id = "ma_snow04",
			template = "ma_snow01",
			pos = v(1221, 362)
		},
		{
			id = "ma_snow05",
			template = "ma_snow01",
			pos = v(1295, 226)
		},
		{
			id = "ma_spider1",
			layer = 2,
			pos = v(431, 123),
			wait = {
				3,
				6
			},
			animation = {
				to = 87,
				prefix = "spider_1",
				from = 1
			}
		},
		{
			id = "ma_spider2",
			layer = 2,
			pos = v(431, 123),
			wait = {
				3,
				6
			},
			animation = {
				to = 79,
				prefix = "spider_2",
				from = 1
			}
		},
		{
			id = "ma_spider3",
			layer = 2,
			pos = v(431, 123),
			wait = {
				3,
				6
			},
			animation = {
				to = 85,
				prefix = "spider_3",
				from = 1
			}
		},
		{
			id = "ma_treant",
			layer = 2,
			pos = v(1869, 255),
			anchor = v(60, 40),
			fns = {
				prepare = deco_fn.ani_seq1.prepare
			},
			animations = {
				default = {
					to = 1,
					prefix = "treant",
					from = 1
				},
				left = {
					to = 123,
					prefix = "treant",
					from = 1
				},
				right = {
					to = 246,
					prefix = "treant",
					from = 124
				}
			},
			sequence = {
				{
					"default",
					3,
					6
				},
				{
					"left",
					3,
					6
				},
				{
					"right",
					3,
					6
				}
			}
		},
		{
			id = "ma_twister",
			layer = 2,
			pos = v(1409, 914),
			wait = {
				5,
				15
			},
			animation = {
				to = 119,
				prefix = "twister",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_volcanoSmokes",
			layer = 2,
			pos = v(1448, 601),
			animation = {
				to = 52,
				prefix = "volcanoSmokes",
				from = 1
			}
		},
		{
			id = "ma_volcanoes1",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_1",
				from = 1
			}
		},
		{
			id = "ma_volcanoes2",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_2",
				from = 1
			}
		},
		{
			id = "ma_volcanoes3",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_3",
				from = 1
			}
		},
		{
			id = "ma_volcanoes4",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_4",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterFall_1",
			layer = 2,
			pos = v(454, 290),
			animation = {
				to = 18,
				prefix = "waterFall_1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterFall_2",
			layer = 2,
			pos = v(58, 304),
			animation = {
				to = 32,
				prefix = "waterFall_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterFall_3",
			layer = 2,
			pos = v(1040, 835),
			animation = {
				to = 27,
				prefix = "waterFall_3",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterWheel",
			layer = 2,
			pos = v(734, 891),
			animation = {
				to = 64,
				prefix = "waterWheel",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves1",
			layer = 1,
			pos = v(216, 930),
			animation = {
				to = 116,
				prefix = "waves1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves2",
			layer = 1,
			pos = v(563, 929),
			animation = {
				to = 116,
				prefix = "waves2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves3",
			layer = 1,
			pos = v(897, 1047),
			animation = {
				to = 116,
				prefix = "waves3",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves4",
			layer = 1,
			pos = v(713, 60),
			animation = {
				to = 116,
				prefix = "waves4",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves5",
			layer = 1,
			pos = v(1183, 70),
			animation = {
				to = 116,
				prefix = "waves5",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_wavesBeach",
			layer = 1,
			pos = v(822, 967),
			animation = {
				to = 126,
				prefix = "wavesBeach",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_spark_01",
			layer = 1,
			pos = v(169, 938),
			animation = {
				to = 33,
				prefix = "waterSparks",
				from = 1
			}
		},
		{
			id = "ma_spark_02",
			template = "ma_spark_01",
			pos = v(77, 972)
		},
		{
			id = "ma_spark_03",
			template = "ma_spark_01",
			pos = v(239, 1019)
		},
		{
			id = "ma_spark_04",
			template = "ma_spark_01",
			pos = v(368, 1015)
		},
		{
			id = "ma_spark_05",
			template = "ma_spark_01",
			pos = v(345, 1074)
		},
		{
			id = "ma_spark_06",
			template = "ma_spark_01",
			pos = v(515, 906)
		},
		{
			id = "ma_spark_07",
			template = "ma_spark_01",
			pos = v(594, 932)
		},
		{
			id = "ma_spark_08",
			template = "ma_spark_01",
			pos = v(536, 954)
		},
		{
			id = "ma_spark_09",
			template = "ma_spark_01",
			pos = v(475, 994)
		},
		{
			id = "ma_spark_10",
			template = "ma_spark_01",
			pos = v(431, 1049)
		},
		{
			id = "ma_spark_11",
			template = "ma_spark_01",
			pos = v(579, 994)
		},
		{
			id = "ma_spark_12",
			template = "ma_spark_01",
			pos = v(536, 1033)
		},
		{
			id = "ma_spark_13",
			template = "ma_spark_01",
			pos = v(644, 1040)
		},
		{
			id = "ma_spark_14",
			template = "ma_spark_01",
			pos = v(734, 1033)
		},
		{
			id = "ma_spark_15",
			template = "ma_spark_01",
			pos = v(786, 1071)
		},
		{
			id = "ma_spark_16",
			template = "ma_spark_01",
			pos = v(766, 1116)
		},
		{
			id = "ma_spark_17",
			template = "ma_spark_01",
			pos = v(857, 762)
		},
		{
			id = "ma_spark_18",
			template = "ma_spark_01",
			pos = v(489, 1082)
		},
		{
			id = "ma_spark_19",
			template = "ma_spark_01",
			pos = v(594, 1076)
		},
		{
			id = "ma_spark_20",
			template = "ma_spark_01",
			pos = v(697, 1085)
		},
		{
			id = "ma_spark_21",
			template = "ma_spark_01",
			pos = v(631, 1119)
		},
		{
			id = "ma_spark_22",
			template = "ma_spark_01",
			pos = v(550, 1116)
		},
		{
			id = "ma_spark_23",
			template = "ma_spark_01",
			pos = v(421, 1108)
		},
		{
			id = "ma_spark_24",
			template = "ma_spark_01",
			pos = v(271, 1119)
		},
		{
			id = "ma_spark_25",
			template = "ma_spark_01",
			pos = v(197, 1074)
		},
		{
			id = "ma_spark_26",
			template = "ma_spark_01",
			pos = v(156, 1116)
		},
		{
			id = "ma_spark_27",
			template = "ma_spark_01",
			pos = v(41, 1100)
		},
		{
			id = "ma_spark_28",
			template = "ma_spark_01",
			pos = v(731, -35)
		},
		{
			id = "ma_spark_29",
			template = "ma_spark_01",
			pos = v(825, -18)
		},
		{
			id = "ma_spark_30",
			template = "ma_spark_01",
			pos = v(788, 35)
		},
		{
			id = "ma_spark_31",
			template = "ma_spark_01",
			pos = v(1042, -35)
		},
		{
			id = "ma_spark_32",
			template = "ma_spark_01",
			pos = v(1078, 31)
		},
		{
			id = "ma_spark_33",
			template = "ma_spark_01",
			pos = v(1155, 25)
		},
		{
			id = "ma_spark_34",
			template = "ma_spark_01",
			pos = v(1221, -39)
		},
		{
			id = "ma_spark_35",
			template = "ma_spark_01",
			pos = v(1130, -28)
		},
		{
			random_start = true,
			alpha = 0.9,
			loop = true,
			id = "ma_cloud_1",
			layer = 3,
			scale = v(0.8, 0.8),
			move = {
				time = 60,
				from = v(-250, 1000),
				to = v(2250, 1020)
			},
			wait = {
				1,
				60
			},
			animation = {
				to = 1,
				prefix = "ma_cloud",
				from = 1
			}
		},
		{
			id = "ma_cloud_2",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, 1040),
				to = v(2100, 1040)
			}
		},
		{
			id = "ma_cloud_3",
			template = "ma_cloud_1",
			alpha = 0.4,
			scale = v(0.7, 0.7),
			move = {
				time = 80,
				from = v(-200, 1090),
				to = v(2100, 1090)
			}
		},
		{
			id = "ma_cloud_4",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(-0.4, 0.4),
			move = {
				time = 83,
				from = v(-200, 1050),
				to = v(2100, 1050)
			}
		},
		{
			id = "ma_cloud_5",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.4, 0.4),
			move = {
				time = 90,
				from = v(-200, 1070),
				to = v(2100, 1070)
			}
		},
		{
			id = "ma_cloud_6",
			template = "ma_cloud_1",
			alpha = 0.7,
			scale = v(-0.5, 0.5),
			move = {
				time = 60,
				from = v(-200, 990),
				to = v(2100, 1020)
			}
		},
		{
			id = "ma_cloud_7",
			template = "ma_cloud_1",
			alpha = 0.5,
			scale = v(-0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, 1030),
				to = v(2100, 1030)
			}
		},
		{
			id = "ma_cloud_8",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.7, 0.7),
			move = {
				time = 65,
				from = v(-200, 1040),
				to = v(2100, 1040)
			}
		},
		{
			id = "ma_cloud_t1",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.7, 0.7),
			move = {
				time = 60,
				from = v(-200, 0),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t2",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, -20),
				to = v(2100, -20)
			}
		},
		{
			id = "ma_cloud_t3",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.8, 0.8),
			move = {
				time = 80,
				from = v(-200, 10),
				to = v(2100, 10)
			}
		},
		{
			id = "ma_cloud_t4",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.9, 0.9),
			move = {
				time = 90,
				from = v(-200, -5),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t5",
			template = "ma_cloud_1",
			alpha = 0.5,
			scale = v(0.7, 0.7),
			move = {
				time = 70,
				from = v(-200, 0),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t6",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.8, 0.8),
			move = {
				time = 80,
				from = v(-200, 10),
				to = v(2100, 10)
			}
		}
	},
	map_decos1 = {
		{
			id = "md_muelle",
			image = "muelle",
			layer = 2,
			pos = v(297, 965)
		},
		{
			id = "md_compass",
			image = "compass",
			layer = 1,
			pos = v(75, 1000)
		},
		{
			id = "md_darkTower",
			image = "darkTower",
			layer = 2,
			pos = v(1735, 673)
		},
		{
			id = "md_cover_swamp",
			image = "map_overFlags_0001",
			layer = 3,
			pos = v(1803, 305)
		},
		{
			id = "md_cover_woods",
			image = "map_overFlags_0002",
			layer = 3,
			pos = v(647, 365)
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_01",
			image = "map_path_1_0010",
			trigger_level = 2,
			pos = v(322, 821),
			animations = {
				to = 10,
				prefix = "map_path_1",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_02",
			image = "map_path_2_0010",
			trigger_level = 3,
			pos = v(415, 783),
			animations = {
				to = 10,
				prefix = "map_path_2",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_03",
			image = "map_path_3_0025",
			trigger_level = 4,
			pos = v(559, 772),
			animations = {
				to = 25,
				prefix = "map_path_3",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_04",
			image = "map_path_4_0030",
			trigger_level = 5,
			pos = v(488, 650),
			animations = {
				to = 30,
				prefix = "map_path_4",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_05",
			image = "map_path_5_0059",
			trigger_level = 6,
			pos = v(426, 394),
			animations = {
				to = 59,
				prefix = "map_path_5",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_06",
			image = "map_path_6_0050",
			trigger_level = 7,
			pos = v(568, 209),
			animations = {
				to = 50,
				prefix = "map_path_6",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_07",
			image = "map_path_7_0034",
			trigger_level = 8,
			pos = v(815, 194),
			animations = {
				to = 34,
				prefix = "map_path_7",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_08",
			image = "map_path_8_0116",
			trigger_level = 9,
			pos = v(953, 185),
			animations = {
				to = 116,
				prefix = "map_path_8",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_09",
			image = "map_path_9_0090",
			trigger_level = 10,
			pos = v(1289, 357),
			animations = {
				to = 90,
				prefix = "map_path_9",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_10",
			image = "map_path_10_0025",
			trigger_level = 11,
			pos = v(1612, 528),
			animations = {
				to = 25,
				prefix = "map_path_10",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_11",
			image = "map_path_11_0071",
			trigger_level = 12,
			pos = v(1747, 668),
			animations = {
				to = 71,
				prefix = "map_path_11",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_23",
			image = "map_path_23_0026",
			trigger_level = 24,
			pos = v(1378, 238),
			animations = {
				to = 26,
				prefix = "map_path_23",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_24",
			image = "map_path_24_0021",
			trigger_level = 25,
			pos = v(1380, 164),
			animations = {
				to = 21,
				prefix = "map_path_24",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_25",
			image = "map_path_25_0016",
			trigger_level = 26,
			pos = v(1448, 138),
			animations = {
				to = 16,
				prefix = "map_path_25",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
---重生
		{
			layer = 1,
			hidden = true,
			id = "md_path_74",
			image = "map_path_30_0033",
			trigger_level = 30,
			pos = v(765, 687),
			animations = {
				to = 33,
				prefix = "map_path_30",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_75",
			image = "map_path_31_0041",
			trigger_level = 31,
			pos = v(839, 863),
			animations = {
				to = 41,
				prefix = "map_path_31",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		}
---				
	},
	--2代
	map_animations2 = {
		{
			loop = true,
			id = "ma_waterfall_left",
			layer = 1,
			pos = v(32, 192),
			animation = {
				to = 18,
				prefix = "ma_waterfall_left",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_oasis",
			layer = 1,
			pos = v(495, 514),
			animation = {
				to = 33,
				prefix = "ma_waterSparks",
				from = 1
			}
		},
		{
			id = "ma_twister_1",
			layer = 1,
			pos = v(312, 183),
			wait = {
				10,
				20
			},
			animation = {
				to = 119,
				prefix = "ma_twister_1",
				from = 1
			}
		},
		{
			id = "ma_twister_2",
			layer = 1,
			pos = v(97, 467),
			wait = {
				10,
				20
			},
			animation = {
				to = 119,
				prefix = "ma_twister_2",
				from = 1
			}
		},
		{
			id = "ma_twister_3",
			layer = 1,
			pos = v(259, 386),
			wait = {
				10,
				20
			},
			animation = {
				to = 119,
				prefix = "ma_twister_3",
				from = 1
			}
		},
		{
			id = "ma_sandworm",
			layer = 1,
			pos = v(283, 490),
			wait = {
				20,
				40
			},
			animation = {
				to = 81,
				prefix = "ma_sandworm",
				from = 1
			}
		},
		{
			id = "ma_bantha_1",
			layer = 1,
			pos = v(53, 323),
			wait = {
				2,
				4
			},
			animation = {
				to = 54,
				prefix = "ma_bantha",
				from = 1
			}
		},
		{
			id = "ma_goat_1",
			layer = 1,
			pos = v(522, 642),
			wait = {
				3,
				7
			},
			animation = {
				to = 32,
				prefix = "ma_goat",
				from = 1
			}
		},
		{
			id = "ma_goat_2",
			template = "ma_goat_1",
			pos = v(464, 516),
			scale = v(-1, 1)
		},
		{
			id = "ma_mini_volcano_a_1",
			layer = 1,
			pos = v(556, 16),
			wait = {
				5,
				10
			},
			animation = {
				to = 60,
				prefix = "ma_mini_volcano_1",
				from = 1
			}
		},
		{
			id = "ma_mini_volcano_a_2",
			template = "ma_mini_volcano_a_1",
			pos = v(954, 32)
		},
		{
			id = "ma_mini_volcano_a_3",
			template = "ma_mini_volcano_a_1",
			pos = v(1043, 18)
		},
		{
			loop = true,
			id = "ma_mini_volcano_a_smoke_1",
			layer = 1,
			pos = v(555, -5),
			animation = {
				to = 52,
				prefix = "ma_mini_volcano_smoke_1",
				from = 1
			}
		},
		{
			id = "ma_mini_volcano_a_smoke_2",
			template = "ma_mini_volcano_a_smoke_1",
			pos = v(953, 10)
		},
		{
			id = "ma_mini_volcano_a_smoke_3",
			template = "ma_mini_volcano_a_smoke_1",
			pos = v(1042, -3)
		},
		{
			id = "ma_mini_volcano_a_smoke_4",
			template = "ma_mini_volcano_a_smoke_1",
			pos = v(370, 33)
		},
		{
			id = "ma_mini_volcano_a_smoke_5",
			template = "ma_mini_volcano_a_smoke_1",
			pos = v(417, 11)
		},
		{
			id = "ma_mini_volcano_b_1",
			layer = 1,
			pos = v(321, 33),
			wait = {
				5,
				10
			},
			animation = {
				to = 60,
				prefix = "ma_mini_volcano_2",
				from = 1
			}
		},
		{
			id = "ma_mini_volcano_b_2",
			template = "ma_mini_volcano_b_1",
			pos = v(997, 29)
		},
		{
			loop = true,
			id = "ma_mini_volcano_b_smoke_1",
			layer = 1,
			pos = v(323, 6),
			animation = {
				to = 52,
				prefix = "ma_mini_volcano_smoke_2",
				from = 1
			}
		},
		{
			id = "ma_mini_volcano_b_smoke_2",
			template = "ma_mini_volcano_b_smoke_1",
			pos = v(999, 2)
		},
		{
			loop = true,
			id = "ma_north_river",
			layer = 1,
			pos = v(1119, 197),
			animation = {
				to = 30,
				prefix = "ma_north_river",
				from = 1
			}
		},
		{
			id = "ma_north_lights",
			layer = 1,
			pos = v(986, 171),
			wait = {
				8,
				15
			},
			animation = {
				to = 25,
				prefix = "ma_north_lights",
				from = 1
			}
		},
		{
			id = "ma_skeleton",
			layer = 1,
			pos = v(1094, 222),
			wait = {
				10,
				30
			},
			animation = {
				to = 129,
				prefix = "ma_skeleton",
				from = 1
			}
		},
		{
			id = "ma_castle_window_1",
			toggle = true,
			layer = 1,
			pos = v(1269, 89),
			wait = {
				8,
				25
			},
			animation = {
				to = 1,
				prefix = "ma_castle_window_1",
				from = 1
			}
		},
		{
			id = "ma_castle_window_2",
			toggle = true,
			layer = 1,
			pos = v(1275, 100),
			wait = {
				8,
				25
			},
			animation = {
				to = 1,
				prefix = "ma_castle_window_2",
				from = 1
			}
		},
		{
			id = "ma_castle_window_3",
			toggle = true,
			layer = 1,
			pos = v(1303, 99),
			wait = {
				8,
				25
			},
			animation = {
				to = 1,
				prefix = "ma_castle_window_3",
				from = 1
			}
		},
		{
			id = "ma_castle_window_4",
			toggle = true,
			layer = 1,
			pos = v(1276, 126),
			wait = {
				8,
				25
			},
			animation = {
				to = 1,
				prefix = "ma_castle_window_4",
				from = 1
			}
		},
		{
			id = "ma_castle_window_5",
			toggle = true,
			layer = 1,
			pos = v(1286, 83),
			wait = {
				8,
				25
			},
			animation = {
				to = 1,
				prefix = "ma_castle_window_5",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_castle_flame_1",
			layer = 1,
			pos = v(1258, 138),
			animation = {
				to = 12,
				prefix = "ma_castle_flame",
				from = 1
			}
		},
		{
			id = "ma_castle_flame_2",
			template = "ma_castle_flame_1",
			pos = v(1282, 148)
		},
		{
			id = "ma_lava_1_glow",
			layer = 1,
			pos = v(585, 133),
			wait = {
				5,
				10
			},
			animation = {
				to = 96,
				prefix = "ma_lava_1_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_lava_1",
			layer = 1,
			pos = v(593, 127),
			animation = {
				to = 45,
				prefix = "ma_lava_1",
				from = 1
			}
		},
		{
			id = "ma_lava_2_glow",
			layer = 1,
			pos = v(759, 126),
			wait = {
				5,
				10
			},
			animation = {
				to = 96,
				prefix = "ma_lava_2_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_lava_2",
			layer = 1,
			pos = v(747, 107),
			animation = {
				to = 46,
				prefix = "ma_lava_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_lava_sparks_1",
			layer = 1,
			pos = v(1219, 430),
			animation = {
				to = 81,
				prefix = "ma_lava_sparks",
				from = 1
			}
		},
		{
			id = "ma_lava_sparks_2",
			template = "ma_lava_sparks_1",
			pos = v(1302, 358),
			scale = v(0.8, 0.8)
		},
		{
			id = "ma_lava_sparks_3",
			template = "ma_lava_sparks_1",
			pos = v(1242, 362),
			scale = v(0.7, 0.7)
		},
		{
			loop = true,
			id = "ma_lava_smoke",
			layer = 1,
			pos = v(1257, 375),
			animation = {
				to = 66,
				prefix = "ma_lava_smoke",
				from = 1
			}
		},
		{
			id = "ma_diamond",
			layer = 1,
			pos = v(1522, 349),
			wait = {
				3,
				6
			},
			animation = {
				to = 70,
				prefix = "ma_diamond",
				from = 1
			}
		},
		{
			id = "ma_mountain_lava_1",
			layer = 1,
			pos = v(1539, 142),
			wait = {
				3,
				6
			},
			animation = {
				to = 80,
				prefix = "ma_mountain_lava_1",
				from = 1
			}
		},
		{
			alpha = 0.8,
			id = "ma_mountain_lava_2",
			layer = 1,
			pos = v(1520, 187),
			wait = {
				3,
				6
			},
			animation = {
				to = 60,
				prefix = "ma_mountain_lava_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_mountain_sparks",
			layer = 1,
			pos = v(1542, 142),
			animation = {
				to = 80,
				prefix = "ma_mountain_sparks",
				from = 1
			}
		},
		{
			id = "ma_mountain_sparks_2",
			template = "ma_mountain_sparks",
			alpha = 0.8,
			pos = v(1542, 130),
			scale = v(0.8, 0.8)
		},
		{
			loop = true,
			id = "ma_river_l",
			layer = 1,
			pos = v(1231, 797),
			animation = {
				to = 18,
				prefix = "ma_river_l",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_river_r",
			layer = 1,
			pos = v(1561, 636),
			animation = {
				to = 18,
				prefix = "ma_river_r",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_falls_left",
			layer = 1,
			pos = v(1064, 578),
			animation = {
				to = 18,
				prefix = "ma_falls_left",
				from = 1
			}
		},
		{
			loop = true,
			layer = 1,
			id = "ma_bottle_1",
			path = ani_paths2.ma_bottle_1,
			wait = {
				10,
				20
			},
			animation = {
				to = 27,
				prefix = "ma_bottle_loop",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_bottle_cover",
			layer = 1,
			pos = v(1217, 722),
			animation = {
				to = 1,
				prefix = "ma_bottle_cover",
				from = 1
			}
		},
		{
			id = "ma_monkey_vine_1",
			layer = 1,
			pos = v(977, 602),
			wait = {
				15,
				30
			},
			animation = {
				to = 82,
				prefix = "ma_monkey_vine_1",
				from = 1
			}
		},
		{
			id = "ma_monkey_vine_2",
			layer = 1,
			pos = v(1131, 686),
			wait = {
				25,
				25
			},
			animation = {
				to = 56,
				prefix = "ma_monkey_vine_2",
				from = 1
			}
		},
		{
			id = "ma_monkey_vine_3",
			layer = 1,
			pos = v(1593, 636),
			wait = {
				30,
				45
			},
			animation = {
				to = 55,
				prefix = "ma_monkey_vine_3",
				from = 1
			}
		},
		{
			id = "ma_monkey_shout_1",
			layer = 1,
			pos = v(971, 854),
			scale = v(-1, 1),
			wait = {
				20,
				45
			},
			animation = {
				to = 85,
				prefix = "ma_monkey_shout",
				from = 1
			}
		},
		{
			id = "ma_monkey_shout_2",
			layer = 1,
			pos = v(1303, 731),
			wait = {
				20,
				45
			},
			animation = {
				to = 85,
				prefix = "ma_monkey_shout",
				from = 1
			}
		},
		{
			id = "ma_monkey_shout_3",
			layer = 1,
			pos = v(1745, 546),
			wait = {
				20,
				45
			},
			animation = {
				to = 85,
				prefix = "ma_monkey_shout",
				from = 1
			}
		},
		{
			id = "ma_volcano_bubble",
			layer = 1,
			pos = v(1440, 610),
			wait = {
				1,
				2
			},
			animation = {
				to = 70,
				prefix = "ma_volcano_bubble",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_volcano_smoke",
			layer = 1,
			pos = v(1441, 535),
			animation = {
				to = 52,
				prefix = "ma_volcano_smoke",
				from = 1
			}
		},
		{
			id = "ma_alien_ship",
			layer = 1,
			pos = v(1565, 783),
			wait = {
				1,
				3
			},
			animation = {
				to = 80,
				prefix = "ma_alien_ship",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_1",
			layer = 1,
			pos = v(66, 658),
			animation = {
				to = 120,
				prefix = "ma_waves_1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_2",
			layer = 1,
			pos = v(111, 797),
			animation = {
				to = 120,
				prefix = "ma_waves_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_3",
			layer = 1,
			pos = v(120, 987),
			animation = {
				to = 120,
				prefix = "ma_waves_3",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_4",
			layer = 1,
			pos = v(513, 1014),
			animation = {
				to = 120,
				prefix = "ma_waves_4",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_5",
			layer = 1,
			pos = v(373, 865),
			animation = {
				to = 120,
				prefix = "ma_waves_5",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_6",
			layer = 1,
			pos = v(328, 647),
			animation = {
				to = 120,
				prefix = "ma_waves_6",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_7",
			layer = 1,
			pos = v(339, 775),
			animation = {
				to = 120,
				prefix = "ma_waves_7",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves_8",
			layer = 1,
			pos = v(107, 910),
			animation = {
				to = 120,
				prefix = "ma_waves_8",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_beach_1",
			layer = 1,
			pos = v(502, 924),
			wait = {
				5,
				5
			},
			animation = {
				to = 135,
				prefix = "ma_beach_1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_beach_2",
			layer = 1,
			pos = v(269, 636),
			wait = {
				5,
				5
			},
			animation = {
				to = 131,
				prefix = "ma_beach_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_beach_3",
			layer = 1,
			pos = v(301, 990),
			wait = {
				5,
				5
			},
			animation = {
				to = 131,
				prefix = "ma_beach_3",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_beach_4",
			layer = 1,
			pos = v(173, 966),
			wait = {
				5,
				5
			},
			animation = {
				to = 131,
				prefix = "ma_beach_4",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_water_sparks_1",
			layer = 1,
			pos = v(66, 706),
			animation = {
				to = 33,
				prefix = "ma_waterSparks",
				from = 1
			}
		},
		{
			id = "ma_water_sparks_2",
			template = "ma_water_sparks_1",
			pos = v(3, 764)
		},
		{
			id = "ma_water_sparks_3",
			template = "ma_water_sparks_1",
			pos = v(17, 891)
		},
		{
			id = "ma_water_sparks_4",
			template = "ma_water_sparks_1",
			pos = v(7, 1006)
		},
		{
			id = "ma_water_sparks_5",
			template = "ma_water_sparks_1",
			pos = v(63, 933)
		},
		{
			id = "ma_water_sparks_6",
			template = "ma_water_sparks_1",
			pos = v(65, 829)
		},
		{
			id = "ma_water_sparks_7",
			template = "ma_water_sparks_1",
			pos = v(35, 1077)
		},
		{
			id = "ma_water_sparks_8",
			template = "ma_water_sparks_1",
			pos = v(105, 1031)
		},
		{
			id = "ma_water_sparks_9",
			template = "ma_water_sparks_1",
			pos = v(179, 1070)
		},
		{
			id = "ma_water_sparks_10",
			template = "ma_water_sparks_1",
			pos = v(260, 1020)
		},
		{
			id = "ma_water_sparks_11",
			template = "ma_water_sparks_1",
			pos = v(288, 1080)
		},
		{
			id = "ma_water_sparks_12",
			template = "ma_water_sparks_1",
			pos = v(396, 1058)
		},
		{
			id = "ma_water_sparks_13",
			template = "ma_water_sparks_1",
			pos = v(458, 964)
		},
		{
			id = "ma_water_sparks_14",
			template = "ma_water_sparks_1",
			pos = v(179, 670)
		},
		{
			id = "ma_water_sparks_15",
			template = "ma_water_sparks_1",
			pos = v(475, 1030)
		},
		{
			id = "ma_water_sparks_16",
			template = "ma_water_sparks_1",
			pos = v(223, 834)
		},
		{
			id = "ma_water_sparks_17",
			template = "ma_water_sparks_1",
			pos = v(307, 787)
		},
		{
			id = "ma_water_sparks_18",
			template = "ma_water_sparks_1",
			pos = v(325, 936)
		},
		{
			id = "ma_tentacle",
			layer = 1,
			pos = v(351, 1012),
			wait = {
				22,
				45
			},
			animation = {
				to = 140,
				prefix = "ma_tentacle",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_lighthouse_light",
			layer = 1,
			pos = v(122, 965),
			animation = {
				to = 119,
				prefix = "ma_lighthouse_light",
				from = 1
			}
		},
		{
			id = "ma_ship_left",
			layer = 2,
			pos = v(115, 742),
			wait = {
				15,
				30
			},
			animation = {
				to = 505,
				prefix = "ma_ship",
				from = 1
			}
		},
		{
			id = "ma_snapvine",
			layer = 2,
			pos = v(1345, 867),
			wait = {
				15,
				30
			},
			animation = {
				to = 20,
				prefix = "ma_snapvine",
				from = 1
			}
		},
		{
			id = "ma_vulture",
			layer = 3,
			pos = v(80, 480),
			wait = {
				20,
				40
			},
			animation = {
				to = 160,
				prefix = "ma_vulture",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_bat_1",
			path = ani_paths2.ma_bat_1,
			wait = {
				3,
				10
			},
			animation = {
				to = 8,
				prefix = "ma_bat_loop",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_bat_2",
			path = ani_paths2.ma_bat_2,
			wait = {
				3,
				10
			},
			animation = {
				to = 8,
				prefix = "ma_bat_loop",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_bat_3",
			path = ani_paths2.ma_bat_3,
			wait = {
				3,
				10
			},
			animation = {
				to = 8,
				prefix = "ma_bat_loop",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_bat_4",
			path = ani_paths2.ma_bat_4,
			wait = {
				3,
				10
			},
			animation = {
				to = 8,
				prefix = "ma_bat_loop",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_bat_5",
			path = ani_paths2.ma_bat_5,
			wait = {
				3,
				10
			},
			animation = {
				to = 8,
				prefix = "ma_bat_loop",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_big_bird",
			path = ani_paths2.ma_big_bird_1,
			wait = {
				10,
				20
			},
			animation = {
				to = 24,
				prefix = "ma_big_bird_loop",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_jungle_bird_1",
			path = ani_paths2.ma_jungle_bird_1,
			wait = {
				10,
				20
			},
			scale = v(0.6, 0.6),
			animation = {
				to = 8,
				prefix = "ma_jungle_bird_1",
				from = 1
			}
		},
		{
			loop = true,
			layer = 3,
			id = "ma_jungle_bird_2",
			path = ani_paths2.ma_jungle_bird_2,
			wait = {
				10,
				20
			},
			scale = v(0.6, 0.6),
			animation = {
				to = 8,
				prefix = "ma_jungle_bird_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_emberspike_cloud",
			layer = 3,
			pos = v(1535, 150),
			scale = v(1.4, 1.4),
			animation = {
				to = 118,
				prefix = "darktower_fog",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_cloud_1",
			layer = 3,
			alpha = 0.8,
			scale = v(0.8, 0.8),
			move = {
				time = 60,
				from = v(-250, 1020),
				to = v(2250, 1020)
			},
			wait = {
				1,
				60
			},
			animation = {
				to = 1,
				prefix = "ma_cloud",
				from = 1
			}
		},
		{
			id = "ma_cloud_2",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, 1040),
				to = v(2100, 1040)
			}
		},
		{
			id = "ma_cloud_3",
			template = "ma_cloud_1",
			alpha = 0.4,
			scale = v(0.7, 0.7),
			move = {
				time = 80,
				from = v(-200, 1090),
				to = v(2100, 1090)
			}
		},
		{
			id = "ma_cloud_4",
			template = "ma_cloud_1",
			alpha = 0.4,
			scale = v(-0.4, 0.4),
			move = {
				time = 83,
				from = v(-200, 1050),
				to = v(2100, 1050)
			}
		},
		{
			id = "ma_cloud_5",
			template = "ma_cloud_1",
			alpha = 0.5,
			scale = v(0.4, 0.4),
			move = {
				time = 90,
				from = v(-200, 1070),
				to = v(2100, 1070)
			}
		},
		{
			id = "ma_cloud_6",
			template = "ma_cloud_1",
			alpha = 0.7,
			scale = v(-0.5, 0.5),
			move = {
				time = 60,
				from = v(-200, 1020),
				to = v(2100, 1020)
			}
		},
		{
			id = "ma_cloud_7",
			template = "ma_cloud_1",
			alpha = 0.5,
			scale = v(-0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, 1030),
				to = v(2100, 1030)
			}
		},
		{
			id = "ma_cloud_8",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.7, 0.7),
			move = {
				time = 65,
				from = v(-200, 1040),
				to = v(2100, 1040)
			}
		},
		{
			id = "ma_cloud_t1",
			template = "ma_cloud_1",
			alpha = 0.4,
			scale = v(0.7, 0.7),
			move = {
				time = 60,
				from = v(-200, 0),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t2",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, -20),
				to = v(2100, -20)
			}
		},
		{
			id = "ma_cloud_t3",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.8, 0.8),
			move = {
				time = 80,
				from = v(-200, 10),
				to = v(2100, 10)
			}
		},
		{
			id = "ma_cloud_t4",
			template = "ma_cloud_1",
			alpha = 0.4,
			scale = v(0.9, 0.9),
			move = {
				time = 90,
				from = v(-200, -5),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t5",
			template = "ma_cloud_1",
			alpha = 0.5,
			scale = v(0.7, 0.7),
			move = {
				time = 70,
				from = v(-200, 0),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t6",
			template = "ma_cloud_1",
			alpha = 0.4,
			scale = v(0.8, 0.8),
			move = {
				time = 80,
				from = v(-200, 10),
				to = v(2100, 10)
			}
		}
	},
	map_decos2 = {
		{
			layer = 3,
			id = "md_m1",
			image = "map_background2_cover_1",
			trigger_level = 12,
			pos = v(1250, 378),
			fns = {
				unlock = deco_fn.m1.unlock
			}
		},
		{
			layer = 3,
			id = "md_m2",
			image = "map_background2_cover_2",
			trigger_level = 14,
			pos = v(1460, 335),
			fns = {
				unlock = deco_fn.m2.unlock
			}
		},
		{
			layer = 2,
			id = "md_gate",
			image = "ma_gate_0001",
			trigger_level = 7,
			pos = v(680, 836),
			fns = {
				unlock = deco_fn.gate.unlock
			}
		},
		{
			loop = true,
			layer = 2,
			id = "ship",
			image = "big_ship_0001",
			trigger_level = 6,
			pos = v(0, 0),
			fns = {
				prepare = deco_fn.ship.prepare,
				unlock = deco_fn.ship.unlock,
				update = deco_fn.ship.update
			},
			animations = {
				down_stopped = {
					to = 225,
					prefix = "big_ship",
					from = 181
				},
				down = {
					to = 45,
					prefix = "big_ship",
					from = 1
				},
				down_side = {
					to = 90,
					prefix = "big_ship",
					from = 46
				},
				side = {
					to = 135,
					prefix = "big_ship",
					from = 91
				},
				side_stopped = {
					to = 180,
					prefix = "big_ship",
					from = 136
				}
			}
		}
	},
	--5代
	map_animations5 = {
	},
	map_decos5 = {

	},
}
