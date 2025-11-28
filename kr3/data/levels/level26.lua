-- chunkname: @/var/folders/r9/xbxmw8n51957gv9ggzrytvf80000gp/T/com.ironhidegames.frontiers.windows.steam.ep3S4swo/kr2/data/levels/level04.lua

local log = require("klua.log"):new("level04")
local signal = require("hump.signal")
local E = require("entity_db")
local U = require("utils")
local LU = require("level_utils")
local V = require("klua.vector")

require("constants")

local level = {}

level.required_sounds = {
	"music_stage26",
	"LegionnaireSounds",
	"GenieSounds",
	"SpecialWorm"
}
level.required_textures = {
	"go_enemies_desert",
	"go_stages_desert",
	"go_stage26",
	"go_stage26_bg"
}

function level:init(store)
	if store.level_mode == GAME_MODE_CAMPAIGN then
		self.max_upgrade_level = 5
		self.locked_towers = {
			"tower_totem",
			"tower_templar",
			"tower_dwaarp",
			"tower_mech",
			"tower_archmage",
			"tower_necromancer"
		}
	elseif store.level_mode == GAME_MODE_HEROIC then
		self.locked_hero = true
		self.max_upgrade_level = 2
		self.locked_towers = {
			"tower_totem",
			"tower_templar",
			"tower_dwaarp",
			"tower_mech",
			"tower_archmage",
			"tower_necromancer"
		}
	elseif store.level_mode == GAME_MODE_IRON then
		self.locked_hero = true
		self.max_upgrade_level = 2
		self.locked_towers = {
			"tower_totem",
			"tower_templar",
			"g2_tower_build_engineer",
			"g2_tower_build_mage",
			"tower_build_rock_thrower",
			"tower_build_mage"
		}
	end

	self.locked_powers = {}
	store.level_terrain_type = TERRAIN_STYLE_DESERT
	self.locations = LU.load_locations(store, self)
end

function level:load(store)
	LU.insert_background(store, "Stage04_0001", Z_BACKGROUND)
	LU.insert_defend_points(store, self.locations.exits, store.level_terrain_type)

	if store.level_mode == GAME_MODE_CAMPAIGN or store.level_mode == GAME_MODE_HEROIC then
		for _, h in pairs(self.locations.holders) do
			if h.id == "12" then
				LU.insert_tower(store, "tower_barrack_mercenaries", h.style, h.pos, h.rally_pos, nil, h.id)
			else
				LU.insert_tower(store, "tower_holder", h.style, h.pos, h.rally_pos, nil, h.id)
			end
		end
	elseif store.level_mode == GAME_MODE_IRON then
		for _, h in pairs(self.locations.holders) do
			if table.contains({
				"3",
				"13",
				"14"
			}, h.id) then
				LU.insert_tower(store, "tower_barrack_mercenaries", h.style, h.pos, h.rally_pos, nil, h.id)
			else
				LU.insert_tower(store, "tower_holder", h.style, h.pos, h.rally_pos, nil, h.id)
			end
		end
	end

	local x

	self.nav_mesh = {
		{
			2,
			9,
			x,
			x
		},
		{
			3,
			14,
			1,
			x
		},
		{
			15,
			8,
			2,
			x
		},
		{
			x,
			5,
			15,
			x
		},
		{
			6,
			6,
			15,
			4
		},
		{
			x,
			12,
			7,
			5
		},
		{
			6,
			12,
			8,
			15
		},
		{
			7,
			13,
			14,
			3
		},
		{
			14,
			10,
			x,
			1
		},
		{
			11,
			x,
			x,
			9
		},
		{
			13,
			x,
			10,
			14
		},
		{
			x,
			16,
			13,
			6
		},
		{
			12,
			16,
			11,
			8
		},
		{
			8,
			11,
			9,
			2
		},
		{
			5,
			7,
			3,
			4
		},
		{
			12,
			x,
			x,
			13
		}
	}
	self.custom_spawn_pos = V.v(226, 500)

	LU.insert_background(store, "Stage04_0002", Z_OBJECTS_COVERS)

	local e

	e = E:create_entity("decal_vulture")
	e.pos.x, e.pos.y = 937, 683

	LU.queue_insert(store, e)

	e = E:create_entity("decal_camel")
	e.render.sprites[1].ts = 0
	e.pos.x, e.pos.y = 207, 103

	LU.queue_insert(store, e)

	e = E:create_entity("decal_snake")
	e.pos.x, e.pos.y = 446, 129

	LU.queue_insert(store, e)

	if store.level_mode ~= GAME_MODE_CAMPAIGN then
		e = E:create_entity("decal")
		e.render.sprites[1].name = "Stage3_Worm"
		e.render.sprites[1].animated = false
		e.render.sprites[1].z = Z_DECALS
		e.pos.x, e.pos.y = 330, 139

		LU.queue_insert(store, e)
	end
end

function level:update(store)
	local storage = require("storage")
	local user_data = storage:load_slot()
		--插入默认英雄。这里判定是否进入双英雄系统
		map_data = require("data.map_data")
		local hero_data = map_data.hero_data
		if (not user_data.liuhui_hero) or (not user_data.liuhui_hero.usedoublehero) then
			LU.insert_hero(store)
		else
			name1 = hero_data[user_data.liuhui_hero.herolist[1]].name
			name2 = hero_data[user_data.liuhui_hero.herolist[2]].name
			LU.insert_double_hero(store, name1, name2)
		end

	if store.level_mode == GAME_MODE_CAMPAIGN then
		while store.wave_group_number < 1 do
			coroutine.yield()
		end

		log.debug("-- sandworm released")

		e = E:create_entity("sand_worm")

		LU.queue_insert(store, e)
	end

	while not store.waves_finished or LU.has_alive_enemies(store) do
		coroutine.yield()
	end
end

return level
