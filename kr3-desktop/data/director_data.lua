-- chunkname: @./kr3-desktop/data/director_data.lua

local d = {}

d.item_props = {
	splash = {
		next = "slots",
		src = "screen_splash",
		type = "screen",
	},
	slots = {
		show_loading = false,
		src = "screen_slots",
		type = "screen",
	},
	credits = {
		next = "slots",
		src = "screen_credits",
		type = "screen",
	},
	map = {
		show_loading = true,
		src = "screen_map",
		type = "screen",
	},
	game = {
		next = "map",
		show_loading = true,
		type = "game",
	},
	kr1_end = {
		next = "map",
		src = "screen_kr1_end",
		type = "screen",
	},
	kr2_end = {
		next = "map",
		src = "screen_kr2_end",
		type = "screen",
	},
	kr3_end = {
		next = "map",
		src = "screen_kr3_end",
		type = "screen",
	},
	comic = {
		next = "map",
		show_loading = false,
		type = "comic",
	},
	game_editor = {
		scissor = false,
		show_loading = false,
		src = "game_editor",
		type = "screen",
	},
	boss_fight_1_end = {
		src = "screen_boss_fight_1_end",
		next = "map",
		type = "screen"
	},
	boss_fight_2_end = {
		src = "screen_boss_fight_2_end",
		next = "map",
		type = "screen"
	},
	boss_fight_3_end = {
		src = "screen_boss_fight_3_end",
		next = "map",
		type = "screen"
	},
	kr5_end = {
		src = "screen_kr5_end",
		next = "map",
		type = "screen"
	},
	boss_fight_5_end = {
		src = "screen_boss_fight_5_end",
		next = "map",
		type = "screen"
	},
	boss_fight_6_end = {
		src = "screen_boss_fight_6_end",
		next = "map",
		type = "screen"
	},
	boss_fight_7_end = {
		src = "screen_boss_fight_7_end",
		next = "map",
		type = "screen"
	},
	boss_fight_8_end = {
		src = "screen_boss_fight_8_end",
		next = "map",
		type = "screen"
	},
	boss_fight_9_end = {
		src = "screen_boss_fight_9_end",
		next = "map",
		type = "screen"
	},
	boss_fight_10_end = {
		src = "screen_boss_fight_10_end",
		next = "map",
		type = "screen"
	},
}
d.loading_image_name = {
	{
		"loading_elven_woods",
		{
			1,
			2,
			3,
			4,
			5,
			6,
			82,
		},
	},
	{
		"loading_faerie_grove",
		{
			7,
			8,
			9,
			10,
			11,
		},
	},
	{
		"loading_ancient_metropolis",
		{
			12,
			13,
			14,
			15,
		},
	},
	{
		"loading_hulking_rage",
		{
			16,
			17,
			18,
		},
	},
	{
		"loading_bittering_rancor",
		{
			19,
			20,
			81,
		},
	},
	{
		"loading_forgotten_treasures",
		{
			21,
			22,
		},
	},
	{
		"loading_desert",
		{
			23,
			24,
			25,
			26,
			27,
			28,
			83,
		},
	},
	{
		"loading_jungle",
		{
			29,
			30,
			31,
			32,
			33,
			84,
		},
	},
	{
		"loading_underground",
		{
			34,
			35,
			36,
			37,
			44,
		},
	},
	{
		"loading_beach",
		{
			38,
			39,
			40,
		},
	},
	{
		"loading_halloween",
		{
			41,
			42,
			43,
		},
	},
	{
		"loading_grass",
		{
			45,
			46,
			47,
			48,
			49,
			50,
			58,
			60,
			61,
			85,
		},
	},
	{
		"loading_ice",
		{
			51,
			52,
			53,
			57,
			62,
			63,
		},
	},
	{
		"loading_wasteland",
		{
			54,
			55,
			56,
			59,
			64,
			65,
			66,
			71,
			72
		},
	},
	{
		"loading_blackburn",
		{
			67,
			68,
			69,
			70,
		},
	},
	{
		"loading_images_desktop_1",
		{
			116
		},
	},
	{
		"loading_images_desktop_2",
		{
			101,
			102,
			103,
			104,
			105,
			106
		},
	},
	{
		"loading_images_desktop_3",
		{
			107,
			108,
			109,
			110,
			111,
		},
	},
	{
		"loading_images_desktop_4",
		{
			112,
			113,
			114,
			115,
		},
	},
	{
		"loading_images_desktop_5",
		{
			117,
			118,
			119,
		},
	},
	{
		"loading_images_desktop_6",
		{
			120,
			121,
			122,
		},
	},
	{
		"loading_images_desktop_7",
		{
			123,
			124,
			125,
			126,
			127
		},
	},
	{
		"loading_images_desktop_8",
		{
			128,
			129,
			130,
		},
	},
	{
		"loading_images_desktop_9",
		{
			131,
			132,
			133,
			134,
			135
		},
	},
	default = "loading_elven_woods",
}

return d
