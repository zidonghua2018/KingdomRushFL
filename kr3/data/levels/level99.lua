-- chunkname: @/var/folders/r9/xbxmw8n51957gv9ggzrytvf80000gp/T/com.ironhidegames.frontiers.windows.steam.ep3S4swo/kr2/data/levels/level99.lua

local E = require("entity_db")
local U = require("utils")
local V = require("klua.vector")

require("constants")

local function queue_insert(store, e)
	table.insert(store.pending_inserts, e)
end

local function queue_remove(store, e)
	table.insert(store.pending_removals, e)
end

local function fish_insert(this, store, script)
	this.render.sprites[1].flip_x = math.random() > 0.5
	this.render.sprites[1].hidden = true
	this.render.sprites[1].loop = false
	this._jump_time = U.frandom(5, 10)

	return true
end

local function fish_update(this, store, script)
	local s = this.render.sprites[1]

	while true do
		if store.tick_ts - s.ts > this._jump_time then
			if math.random() < 0.3 then
				s.flip_x = not s.flip_x
			end

			s.ts = store.tick_ts
			s.runs = 0
			s.hidden = false

			while s.runs < 1 do
				coroutine.yield()
			end

			s.hidden = true
		end

		coroutine.yield()
	end
end

local function wave_update(this, store, script)
	local s = this.render.sprites[1]
	local delay = U.frandom(1, 3)

	while true do
		if delay < store.tick_ts - s.ts then
			s.ts = store.tick_ts
			s.runs = 0
			s.hidden = false

			while s.runs < 1 do
				coroutine.yield()
			end

			s.hidden = true
		end

		coroutine.yield()
	end
end

local level = {}

function level:init(store)
	store.level_terrain_type = TERRAIN_BEACH

	local e

	e = E:create_entity("decal")
	e.name = "background"
	e.pos.x, e.pos.y = 0, 0
	e.render.sprites[1].anchor = V.v(0, 0)
	e.render.sprites[1].animated = false
	e.render.sprites[1].name = "Stage_17"
	e.render.sprites[1].layer = LAYER_BACKGROUND

	queue_insert(store, e)

	e = E:create_entity("decal")
	e.render.sprites[1].animated = false
	e.render.sprites[1].name = "Stage17_boat_top_0001"
	e.render.sprites[1].anchor = V.v(0.5, 0.1)
	e.render.sprites[1].layer = LAYER_GAME_OBJECTS
	e.pos.x, e.pos.y = 84, 129

	queue_insert(store, e)

	e = E:create_entity("decal")
	e.render.sprites[1].animated = false
	e.render.sprites[1].name = "Stage17_boat_top_0002"
	e.render.sprites[1].anchor = V.v(0.5, 0.1)
	e.render.sprites[1].layer = LAYER_GAME_OBJECTS
	e.pos.x, e.pos.y = 84, 129

	queue_insert(store, e)

	self.ship_cover = e
	e = E:create_entity("decal")
	e.render.sprites[1].animation = {
		prefix = "Stage17_boat",
		to = 26,
		from = 1
	}
	e.render.sprites[1].hidden = true
	e.render.sprites[1].loop = false
	e.render.sprites[1].layer = LAYER_DECALS
	e.pos.x, e.pos.y = 182, 160

	queue_insert(store, e)

	self.ship_blown = e
	e = E:create_entity("decal")
	e.render.sprites[1].animation = {
		prefix = "Stage17_waterFall",
		to = 9,
		from = 1
	}
	e.render.sprites[1].layer = LAYER_DECALS
	e.pos.x, e.pos.y = 447, 737

	queue_insert(store, e)

	e = E:create_entity("decal")
	e.render.sprites[1].animation = {
		prefix = "Stage17_waterFall_waves",
		to = 27,
		from = 1
	}
	e.render.sprites[1].layer = LAYER_DECALS
	e.pos.x, e.pos.y = 447, 737

	queue_insert(store, e)

	local fish_pos = {
		{
			37,
			400
		},
		{
			93,
			557
		},
		{
			313,
			309
		},
		{
			373,
			683
		},
		{
			429,
			530
		},
		{
			613,
			395
		},
		{
			805,
			619
		},
		{
			704,
			688
		},
		{
			1003,
			143
		}
	}
	local fish = E:create_entity("decal_scripted")

	fish.render.sprites[1].animation = {
		prefix = "Stage16_fish",
		to = 22,
		from = 1
	}
	fish.render.sprites[1].layer = LAYER_DECALS
	fish.main_script.insert = fish_insert
	fish.main_script.update = fish_update

	for _, p in pairs(fish_pos) do
		e = E:clone_entity(fish)
		e.pos.x, e.pos.y = p[1], p[2]

		queue_insert(store, e)
	end

	local sparkles_pos = {
		{
			97,
			642
		},
		{
			110,
			570
		},
		{
			20,
			512
		},
		{
			137,
			502
		},
		{
			358,
			446
		},
		{
			355,
			293
		},
		{
			514,
			362
		},
		{
			404,
			583
		},
		{
			422,
			514
		},
		{
			469,
			459
		},
		{
			539,
			426
		},
		{
			405,
			360
		},
		{
			216,
			295
		},
		{
			90,
			316
		},
		{
			22,
			380
		},
		{
			394,
			646
		},
		{
			7,
			620
		},
		{
			621,
			369
		},
		{
			620,
			479
		},
		{
			652,
			306
		},
		{
			707,
			568
		},
		{
			787,
			615
		},
		{
			721,
			672
		},
		{
			944,
			153
		},
		{
			1011,
			102
		}
	}
	local sparkle = E:create_entity("decal")

	sparkle.render.sprites[1].animation = {
		prefix = "Stage16_waterSparks",
		to = 22,
		from = 1
	}
	sparkle.render.sprites[1].layer = LAYER_DECALS

	for _, p in pairs(sparkles_pos) do
		e = E:clone_entity(sparkle)
		e.pos.x, e.pos.y = p[1], p[2]
		e.render.sprites[1].ts = U.frandom(0, 1)

		queue_insert(store, e)
	end

	local wave_pos = {
		{
			158,
			634,
			70
		},
		{
			881,
			84,
			-175
		},
		{
			990,
			190,
			-5
		},
		{
			306,
			254,
			-169
		},
		{
			398,
			232,
			180
		},
		{
			535,
			326,
			180
		},
		{
			694,
			390,
			126
		},
		{
			751,
			540,
			180
		},
		{
			635,
			550,
			-19
		},
		{
			732,
			715,
			0
		},
		{
			653,
			663,
			-76
		},
		{
			484,
			551,
			26
		},
		{
			456,
			637,
			103
		},
		{
			337,
			628,
			-88
		},
		{
			341,
			488,
			-17
		},
		{
			232,
			503,
			27
		},
		{
			259,
			345,
			0
		}
	}
	local wave = E:create_entity("decal_scripted")

	wave.render.sprites[1].animation = {
		prefix = "Stage16_waterWave",
		to = 15,
		from = 1
	}
	wave.render.sprites[1].loop = false
	wave.render.sprites[1].layer = LAYER_DECALS
	wave.render.sprites[1].hidden = true
	wave.main_script.update = wave_update

	for _, p in pairs(wave_pos) do
		e = E:clone_entity(wave)
		e.pos.x, e.pos.y = p[1], p[2]
		e.render.sprites[1].r = math.pi * -1 * p[3] / 180

		queue_insert(store, e)
	end

	self.wave_flags = {
		{
			pos = {
				x = 277,
				y = 19
			},
			pointer = {
				x = 225,
				y = -91
			}
		},
		{
			pos = {
				x = 53,
				y = 535
			},
			pointer = {
				x = -64,
				y = 500
			}
		},
		{
			pos = {
				x = 53,
				y = 479
			},
			pointer = {
				x = -64,
				y = 479
			}
		},
		{
			pos = {
				x = 53,
				y = 321
			},
			pointer = {
				x = -64,
				y = 321
			}
		},
		{
			pos = {
				x = -811,
				y = 145
			},
			pointer = {
				x = 76,
				y = 175
			}
		}
	}

	local water_flag = E:create_entity("decal")

	water_flag.render.sprites[1].animation = {
		prefix = "DefenseFlag_water",
		to = 45,
		from = 1
	}
	water_flag.render.sprites[1].anchor = V.v(0.5, 0.12962962962962962)
	water_flag.render.sprites[1].layer = LAYER_GAME_OBJECTS
	e = E:clone_entity(water_flag)
	e.render.sprites[1].ts = U.frandom(0, 1)
	e.pos.x, e.pos.y = 1000, 177

	queue_insert(store, e)

	e = E:clone_entity(water_flag)
	e.render.sprites[1].ts = U.frandom(0, 1)
	e.pos.x, e.pos.y = 1000, 85

	queue_insert(store, e)

	local tholders = {
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 240,
				y = 40
			},
			rally_pos = {
				x = 320,
				y = 40
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 330,
				y = 208
			},
			rally_pos = {
				x = 356,
				y = 166
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 395,
				y = 208
			},
			rally_pos = {
				x = 356,
				y = 166
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 460,
				y = 238
			},
			rally_pos = {
				x = 356,
				y = 166
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 590,
				y = 238
			},
			rally_pos = {
				x = 356,
				y = 166
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 911,
				y = 396
			},
			rally_pos = {
				x = 832,
				y = 396
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 911,
				y = 366
			},
			rally_pos = {
				x = 832,
				y = 366
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 911,
				y = 336
			},
			rally_pos = {
				x = 832,
				y = 336
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 911,
				y = 306
			},
			rally_pos = {
				x = 832,
				y = 306
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 900,
				y = 276
			},
			rally_pos = {
				x = 832,
				y = 276
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 890,
				y = 246
			},
			rally_pos = {
				x = 832,
				y = 246
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 750,
				y = 382
			},
			rally_pos = {
				x = 832,
				y = 382
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 507,
				y = 694
			},
			rally_pos = {
				x = 507,
				y = 660
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 602,
				y = 694
			},
			rally_pos = {
				x = 602,
				y = 660
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 247,
				y = 521
			},
			rally_pos = {
				x = 247,
				y = 550
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 206,
				y = 652
			},
			rally_pos = {
				x = 206,
				y = 630
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 293,
				y = 652
			},
			rally_pos = {
				x = 293,
				y = 630
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 761,
				y = 94
			},
			rally_pos = {
				x = 761,
				y = 130
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 911,
				y = 426
			},
			rally_pos = {
				x = 832,
				y = 400
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 749,
				y = 500
			},
			rally_pos = {
				x = 835,
				y = 462
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 881,
				y = 207
			},
			rally_pos = {
				x = 790,
				y = 257
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 750,
				y = 351
			},
			rally_pos = {
				x = 832,
				y = 307
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 538,
				y = 137
			},
			rally_pos = {
				x = 618,
				y = 193
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 524,
				y = 276
			},
			rally_pos = {
				x = 530,
				y = 217
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 508,
				y = 578
			},
			rally_pos = {
				x = 513,
				y = 653
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 308,
				y = 510
			},
			rally_pos = {
				x = 271,
				y = 592
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 275,
				y = 208
			},
			rally_pos = {
				x = 356,
				y = 166
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 604,
				y = 573
			},
			rally_pos = {
				x = 594,
				y = 653
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 980,
				y = 426
			},
			rally_pos = {
				x = 832,
				y = 400
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 720,
				y = 137
			},
			rally_pos = {
				x = 735,
				y = 217
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 660,
				y = 137
			},
			rally_pos = {
				x = 660,
				y = 160
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 600,
				y = 137
			},
			rally_pos = {
				x = 600,
				y = 160
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 480,
				y = 137
			},
			rally_pos = {
				x = 400,
				y = 160
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 420,
				y = 137
			},
			rally_pos = {
				x = 400,
				y = 160
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 420,
				y = 100
			},
			rally_pos = {
				x = 400,
				y = 100
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 420,
				y = 70
			},
			rally_pos = {
				x = 400,
				y = 70
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 420,
				y = 40
			},
			rally_pos = {
				x = 400,
				y = 40
			}
		},
		{
			style = TERRAIN_STYLE_BEACH,
			pos = {
				x = 240,
				y = 70
			},
			rally_pos = {
				x = 320,
				y = 70
			}
		}
	}
	local tower_names = {
		"tower_mage_1",
		"tower_mage_2",
		"tower_mage_3",
		"tower_engineer_1",
		"tower_engineer_2",
		"tower_engineer_3",
		"tower_mech",
		"tower_archer_1",
		"tower_archer_2",
		"tower_archer_3",
		"tower_barrack_1",
		"tower_barrack_2",
		"tower_barrack_3",
		"tower_templar",
		"tower_assassin",
		"tower_dwaarp"
	}

	for i, th in pairs(tholders) do
		local tname = tower_names[(i - 1) % #tower_names + 1]
		local e = E:create_entity("tower_holder")

		e.pos = V.v(th.pos.x, th.pos.y)
		e.tower.terrain_style = th.style
		e.tower.default_rally_pos = V.v(th.rally_pos.x, th.rally_pos.y)
		e.render.sprites[1].name = string.format(e.render.sprites[1].name, th.style)
		e.tower.upgrade_to = tname

		queue_insert(store, e)
	end

	level.enemy_templates = table.filter(E.entities, function(tn, t)
		return t.enemy and tn ~= "enemy"
	end)
	store.pending_enemies = {}
end

function level:update(dt, ts, store)
	if store.wave_number == 5 and store.last_wave_number ~= store.wave_number then
		self.ship_cover.render.sprites[1].hidden = true
		self.ship_blown.render.sprites[1].hidden = false
		self.ship_blown.render.sprites[1].ts = store.tick_ts
		self.ship_blown.render.sprites[1].runs = 0
	end
end

return level
