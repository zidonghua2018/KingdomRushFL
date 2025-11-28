-- chunkname: @./all-desktop/data/font_subst.lua

local NOTO_REGULAR = "NotoSansCJKkr-Regular"--"NotoSansCJKkr-Regular"
local NOTO_BOLD = "NotoSansCJKkr-Bold"
local JIMOJW = "JIMOJW"
return {
	global = {
		{
			"numbers",
			"Comic Book Italic"
		},
		{
			"numbers_italic",
			"Comic Book Italic"
		},
		{
			"numbers_bold",
			"TOONISH"
		}
	},
	default = {
		{
			"body",
			"Comic Book Italic"
		},
		{
			"body_bold",
			"Comic Book Italic"
		},
		{
			"body_slides",
			"Comic Book Italic"
		},
		{
			"button",
			"ObelixPro"
		},
		{
			"capitals",
			"Heuristica_Italic"
		},
		{
			"h",
			"ObelixPro"
		},
		{
			"h_book",
			"Heuristica_Italic"
		},
		{
			"h_noti",
			"YIKES"
		},
		{
			"h_popup",
			"YIKES-kr-ios"
		},
		{
			"hero_name_label_kr1",
			"ObelixPro"
		},
		{
			"hero_name_label",
			"ObelixPro"
		},
		{
			"hud",
			"Comic Book Italic"
		},
		{
			"infobar_name",
			"ObelixPro"
		},
		{
			"infobar_stats",
			"Comic Book Italic"
		},
		{
			"sans",
			NOTO_REGULAR
		},
		{
			"sans_bold",
			NOTO_BOLD
		},
		{
			"taunts",
			"Comic Book Italic",
			{
				["middle-caps"] = 0,
				size = 1
			}
		}
	},
	["zh-Hans"] = {
		{
			"body",
			NOTO_REGULAR,
			{
				size = 1.2
			}
		},
		{
			"body_bold",
			NOTO_BOLD,
			{
				size = 1.2
			}
		},
		{
			"body_slides",
			NOTO_REGULAR,
			{
				size = 1.1
			}
		},
		{
			"button",
			JIMOJW,
			{
				middle = -0.07,
				size = 1.2
			}
		},
		{
			"capitals",
			JIMOJW
		},
		{
			"h",
			JIMOJW,
			{
				middle = 0,
				size = 1.2,
				bottom = 0.1
			}
		},
		{
			"h_book",
			"Sun Yun He Xuan Li Ti"
		},
		{
			"h_noti",
			JIMOJW,
			{
				middle = 0.05,
				size = 1.2
			}
		},
		{
			"h_popup",
			JIMOJW,
			{
				middle = 0.1,
				size = 1.2
			}
		},
		{
			"hero_name_label_kr1",
			JIMOJW,
			{
				top = -0.1,
				size = 1
			}
		},
		{
			"hero_name_label",
			JIMOJW,
			{
				top = -0.1,
				size = 1
			}
		},
		{
			"hud",
			NOTO_BOLD,
			{
				size = 1.4
			}
		},
		{
			"infobar_name",
			NOTO_REGULAR,
			{
				bottom = 0.15,
				size = 1
			}
		},
		{
			"infobar_stats",
			NOTO_REGULAR,
			{
				size = 1
			}
		},
		{
			"sans",
			NOTO_REGULAR
		},
		{
			"sans_bold",
			NOTO_BOLD
		},
		{
			"taunts",
			NOTO_BOLD,
			{
				["middle-caps"] = -0.05,
				size = 1.2
			}
		}
	},
	["zh-Hant"] = {
		{
			"body",
			NOTO_REGULAR,
			{
				size = 1.2,
				["bottom-caps"] = 0,
				["middle-caps"] = -0.1,
				base = 0,
				top = -0.05,
				middle = -0.025,
				bottom = 0.05
			}
		},
		{
			"body_bold",
			NOTO_BOLD,
			{
				size = 1.2,
				["bottom-caps"] = 0,
				["middle-caps"] = -0.1,
				base = 0,
				top = -0.05,
				middle = -0.025,
				bottom = 0.05
			}
		},
		{
			"body_slides",
			NOTO_REGULAR,
			{
				size = 1,
				["bottom-caps"] = 0,
				["middle-caps"] = -0.1,
				base = 0,
				top = -0.05,
				middle = -0.025,
				bottom = 0.05
			}
		},
		{
			"button",
			NOTO_BOLD,
			{
				top = -0.1,
				size = 1,
				middle = -0.1
			}
		},
		{
			"capitals",
			NOTO_BOLD
		},
		{
			"h",
			NOTO_BOLD,
			{
				middle = -0.1,
				size = 1
			}
		},
		{
			"h_book",
			NOTO_BOLD
		},
		{
			"h_noti",
			NOTO_BOLD
		},
		{
			"h_popup",
			NOTO_BOLD,
			{
				middle = 0,
				size = 1
			}
		},
		{
			"hero_name_label_kr1",
			NOTO_BOLD,
			{
				top = -0.2,
				size = 0.8
			}
		},
		{
			"hero_name_label",
			NOTO_BOLD,
			{
				top = -0.2,
				size = 0.8
			}
		},
		{
			"hud",
			NOTO_BOLD,
			{
				size = 1.4
			}
		},
		{
			"infobar_name",
			NOTO_REGULAR,
			{
				bottom = 0.15,
				size = 1
			}
		},
		{
			"infobar_stats",
			NOTO_REGULAR,
			{
				size = 1
			}
		},
		{
			"sans",
			NOTO_REGULAR
		},
		{
			"sans_bold",
			NOTO_BOLD
		},
		{
			"taunts",
			NOTO_BOLD,
			{
				["middle-caps"] = -0.05,
				size = 1.2
			}
		}
	},
	ja = {
		{
			"body",
			"ZinPenCiro_B"
		},
		{
			"body_bold",
			"ZinPenCiro_B"
		},
		{
			"body_slides",
			"ZinPenCiro_B"
		},
		{
			"button",
			"tetsubin_gothic",
			{
				middle = -0.05,
				size = 1
			}
		},
		{
			"capitals",
			"ZinHenaBokuryu_CRF"
		},
		{
			"h",
			"tetsubin_gothic"
		},
		{
			"h_book",
			"ZinHenaBokuryu_CRF"
		},
		{
			"h_noti",
			"tetsubin_gothic",
			{
				middle = 0.15,
				size = 1
			}
		},
		{
			"h_popup",
			"tetsubin_gothic",
			{
				middle = 0.25,
				size = 1
			}
		},
		{
			"hero_name_label_kr1",
			"tetsubin_gothic"
		},
		{
			"hero_name_label",
			"tetsubin_gothic"
		},
		{
			"hud",
			"ZinPenCiro_B"
		},
		{
			"infobar_name",
			"tetsubin_gothic"
		},
		{
			"infobar_stats",
			"ZinPenCiro_B"
		},
		{
			"sans",
			"NotoSansCJKjp-Regular"
		},
		{
			"sans_bold",
			"NotoSansCJKjp-Bold"
		},
		{
			"taunts",
			"ZinPenCiro_B",
			{
				["middle-caps"] = 0,
				size = 1
			}
		}
	},
	ko = {
		{
			"body",
			"NanumPen",
			{
				size = 1.6
			}
		},
		{
			"body_bold",
			"NanumPen",
			{
				size = 1.6
			}
		},
		{
			"body_slides",
			"NanumPen",
			{
				size = 1.6
			}
		},
		{
			"button",
			"JejuHallasan_Regular",
			{
				bottom = 0.2,
				size = 1.3
			}
		},
		{
			"capitals",
			"BMYEONSUNG"
		},
		{
			"h",
			"JejuHallasan_Regular",
			{
				bottom = 0.2,
				size = 1.3
			}
		},
		{
			"h_book",
			"BMYEONSUNG"
		},
		{
			"h_noti",
			"JejuHallasan_Regular",
			{
				middle = 0.1,
				size = 1.3,
				bottom = 0.2
			}
		},
		{
			"h_popup",
			"JejuHallasan_Regular",
			{
				middle = 0.1,
				size = 1.3,
				bottom = 0.2
			}
		},
		{
			"hero_name_label_kr1",
			"JejuHallasan_Regular",
			{
				top = 0,
				size = 1
			}
		},
		{
			"hero_name_label",
			"JejuHallasan_Regular",
			{
				top = -0.05,
				size = 1.3
			}
		},
		{
			"hud",
			"NanumPen",
			{
				size = 2
			}
		},
		{
			"infobar_name",
			"JejuHallasan_Regular",
			{
				bottom = 0,
				size = 1.2
			}
		},
		{
			"infobar_stats",
			"NanumPen",
			{
				size = 1.6
			}
		},
		{
			"sans",
			NOTO_REGULAR
		},
		{
			"sans_bold",
			NOTO_BOLD
		},
		{
			"taunts",
			"NanumPen",
			{
				["middle-caps"] = 0,
				size = 1.5
			}
		}
	}
}
