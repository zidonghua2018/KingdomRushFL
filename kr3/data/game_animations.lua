-- chunkname: @./kr3/data/game_animations.lua

local d1 = require("data.game_animations-rebbborn")
local d4 = require("data.game_animations-1")
local d2 = require("data.game_animations-2")
local d3 = require("data.game_animations-3")
local d5 = require("data.game_animations-5")
--local dre = require("data.game_animations-4")

local FS = love.filesystem


local path = string.format("%s/data/animations", KR_PATH_GAME)
local files = FS.getDirectoryItems(path)
for i = 1, #files do
	local name = files[i]
	--local f = path .. "/" .. name

	--if FS.isFile(f) and string.match(f, ".lua$") then
	--	load_ani_file(f)
	--end
    local d7 = require(string.format("data.animations.%s",string.sub(name, 1, -5)))
	if d7.animations ~= nil then
 		d1 = table.deepmerge(d1, d7)
	else
		local d6 = {}
		d6.animations = d7
		d1 = table.deepmerge(d1, d6)
	end
    
end

d1 = table.deepmerge(d1, d4)
d1 = table.deepmerge(d1, d2)
d1 = table.deepmerge(d1, d3)
d1 = table.deepmerge(d1, d5)

--[[
local tower_royal_archers = require("data.animations.tower_royal_archers")
d1 = table.deepmerge(d1, tower_royal_archers)
local game_animations_new = require("data.animations.game_animations_new")
d1 = table.deepmerge(d1, game_animations_new)
local paladin_soldier_lvl4 = require("data.animations.paladin_soldiers_lvl4")
d1 = table.deepmerge(d1, paladin_soldier_lvl4)

--arcane_arborean_emissary
--arcane_wizard_tower
local arcane_arborean_emissary = require("data.animations.arcane_arborean_emissary")
d1 = table.deepmerge(d1, arcane_arborean_emissary)
local arcane_wizard_tower = require("data.animations.arcane_wizard_tower")
d1 = table.deepmerge(d1, arcane_wizard_tower)
local tower_ballista = require("data.animations.tower_ballista")
d1 = table.deepmerge(d1, tower_ballista)

local tower_barrel = require("data.animations.tower_barrel")
d1 = table.deepmerge(d1, tower_barrel)
local tower_dark_elf = require("data.animations.tower_dark_elf")
d1 = table.deepmerge(d1, tower_dark_elf)


local tower_elven_barrack = require("data.animations.tower_elven_barrack")
d1 = table.deepmerge(d1, tower_elven_barrack)
local tower_demon_pit = require("data.animations.tower_demon_pit")
d1 = table.deepmerge(d1, tower_demon_pit)
local tower_flamespitter = require("data.animations.tower_flamespitter")
d1 = table.deepmerge(d1, tower_flamespitter)
local tower_ghost = require("data.animations.tower_ghost")
d1 = table.deepmerge(d1, tower_ghost)
local tower_necromancer = require("data.animations.tower_necromancer")
d1 = table.deepmerge(d1, tower_necromancer)
local tower_ray = require("data.animations.tower_ray")
d1 = table.deepmerge(d1, tower_ray)

local tower_rocket_gunners = require("data.animations.tower_rocket_gunners")
d1 = table.deepmerge(d1, tower_rocket_gunners)
local tower_sand = require("data.animations.tower_sand")
d1 = table.deepmerge(d1, tower_sand)
local tower_stargazers = require("data.animations.tower_stargazers")
d1 = table.deepmerge(d1, tower_stargazers)
local hermit_toad = require("data.animations.tower_hermit_toad")
d1 = table.deepmerge(d1, hermit_toad)
local tower_dwarf = require("data.animations.tower_dwarf")
d1 = table.deepmerge(d1, tower_dwarf)
local sparking_geode = require("data.animations.tower_sparking_geode")
d1 = table.deepmerge(d1, sparking_geode)
local stage28_decos = require("data.animations.stage28_decos")
d1 = table.deepmerge(d1, stage28_decos)


local twilight_elves_barrack = require("data.animations.tower_twilight_elves_barrack")
d1 = table.deepmerge(d1, twilight_elves_barrack)
local kr4_tower_blazing_watcher = require("data.animations.kr4_tower_blazing_watcher")
d1 = table.deepmerge(d1, kr4_tower_blazing_watcher)
local kr4_tower_ignis_altar = require("data.animations.kr4_tower_ignis_altar")
d1 = table.deepmerge(d1, kr4_tower_ignis_altar)
local kr4_tower_shadow_archer = require("data.animations.kr4_tower_shadow_archer")
d1 = table.deepmerge(d1, kr4_tower_shadow_archer)
local kr4_tower_dark_knight = require("data.animations.kr4_tower_dark_knight")
d1 = table.deepmerge(d1, kr4_tower_dark_knight)
local kr4_tower_infernal_mage = require("data.animations.kr4_tower_infernal_mage")
d1 = table.deepmerge(d1, kr4_tower_infernal_mage)
local kr4_tower_melting_furnace = require("data.animations.kr4_tower_melting_furnace")
d1 = table.deepmerge(d1, kr4_tower_melting_furnace)

local kr4_tower_goblirang = require("data.animations.kr4_tower_goblirang")
d1 = table.deepmerge(d1, kr4_tower_goblirang)
local kr4_tower_ogre_shipwreck = require("data.animations.kr4_tower_ogre_shipwreck")
d1 = table.deepmerge(d1, kr4_tower_ogre_shipwreck)
]]--
return d1