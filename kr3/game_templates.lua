package.loaded["game_templates-1"] = nil
package.loaded["game_templates-2"] = nil
package.loaded["game_templates-3"] = nil
package.loaded["game_templates-5"] = nil
package.loaded["game_templates-40"] = nil
package.loaded["game_templates-43"] = nil
package.loaded["game_templates-45"] = nil
package.loaded["game_templates-45h"] = nil
package.loaded["game_templates-45e"] = nil
package.loaded["game_templates-51"] = nil
package.loaded["game_templates-55"] = nil
package.loaded["game_templates-56"] = nil
package.loaded["game_templates-57"] = nil
package.loaded["game_templates_hero_boss"] = nil
package.loaded["custom_templates_0"] = nil
package.loaded["custom_templates_1"] = nil
package.loaded["custom_templates_2"] = nil
package.loaded["game_templates-v"] = nil
--package.loaded["game_templates-4"] = nil

local d3 = require("game_templates-3")
local d2 = require("game_templates-2")
local d1 = require("game_templates-1")
local d5 = require("game_templates-5")
local d40 = require("game_templates-40")
local d43 = require("game_templates-43")
local d45 = require("game_templates-45")
local d45h = require("game_templates-45h")
local d45e = require("game_templates-45e")
local d51 = require("game_templates-51")
local d55 = require("game_templates-55")
local d56 = require("game_templates-56")
local d57 = require("game_templates-57")
local dc0 = require("custom_templates_0")
local dc1 = require("custom_templates_1")
local dc2 = require("custom_templates_2")
local dhb = require("game_templates_hero_boss")
local dhd = require("game_templates-v")
--local d4 = require("game_templates-4")

-- 拖拽功能，实体字段补充
-- if KR_FL_EXPERIMENTAL then
if true then
    local E = require("entity_db")
    local function T(name)
        return E:get_template(name)
    end
    local items = {
        -- 1代
        "g1_soldier_militia", "g1_soldier_footmen", "g1_soldier_knight",
        "soldier_paladin", "soldier_barbarian",
        "soldier_elf","soldier_elf_1", "soldier_sasquash", "soldier_sasquash_2",
        -- 2代
        "soldier_militia", "soldier_footmen", "soldier_knight",
        "soldier_templar", "soldier_assassin",
        "soldier_frankenstein", "soldier_djinn", "soldier_djinn_2",
        "soldier_legionnaire", "soldier_legionnaire_2",
        "soldier_pirate_captain", "soldier_pirate_captain_2",
        "soldier_pirate_flamer", "soldier_pirate_flamer_2",
        "soldier_pirate_anchor", "soldier_pirate_anchor_2",
        "soldier_dwarf", "soldier_amazona", "soldier_amazona_re","soldier_cannibal",
        "soldier_mecha", 
        -- 3代
        "soldier_barrack_1", "soldier_barrack_2", "soldier_barrack_3",
        "soldier_blade", "soldier_forest", "soldier_drow",
        "soldier_ewok", "soldier_druid_bear","soldier_ewok_re",
        -- extra
        "soldier_ancient_guardian", "soldier_steam_troop",
        "soldier_s6_imperial_guard", "soldier_s6_imperial_guard_2",
        "soldier_imperial_guard", "soldier_tremor", "soldier_elf_kr1",
        "soldier_ewok_re_1","tower_barrack_1_v","tower_barrack_2_v","tower_barrack_3_v",
        "tower_redcap","tower_barrack_canibal",
    }
    for _, item in pairs(items) do
        local e = T(item)
        E:add_comps(e, "nav_grid")
    end
end
