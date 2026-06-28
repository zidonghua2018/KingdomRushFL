local log = require("klua.log"):new("game_gui")
local km = require("klua.macros")

require("klua.table")
require("klove.kui")

local timer = require("hump.timer"):new()
local signal = require("hump.signal")
local class = require("middleclass")
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot
local AC = require("achievements")
local F = require("klove.font_db")
local I = require("klove.image_db")
local S = require("sound_db")
local SU = require("screen_utils")
local E = require("entity_db")
local U = require("utils")
local V = require("klua.vector")
local v = V.v
local r = V.r
local P = require("path_db")
local GR = require("grid_db")
local GS = require("game_settings")
local GU = require("gui_utils_5") -- 这个不能乱用 流辉349
local LU = require("level_utils")
local storage = require("storage")
local UP = require("upgrades")
local G = love.graphics
local i18n = require("i18n")
local balance = require("balance/balance")
local UPGR = require("upgrades")
local map_data = require("data.map_data")
local tower_menus = require("data.tower_menus_data")
local high_level_towers = {}

CriketMenuButton = class("CriketMenuButton", KView)
function CriketMenuButton:initialize(item)
    CriketMenuButton.super.initialize(self)

    self.item_image = item.image

    local b = KImageView:new(item.image)

    b.pos = v(0, 0)
    b.propagate_on_click = true
    b.disabled_tint_color = nil
    self.button = b

    self:add_child(b)

    local halo = KImageView:new(item.halo)

    halo.pos = v(math.floor(-0.5 * (halo.size.x - b.size.x)), math.floor(-0.5 * (halo.size.y - b.size.y)))

    halo.propagate_on_click = true
    halo.hidden = true
    self.halo = halo

    self:add_child(halo, 1)

    if table.contains({"tw_upgrade", "tw_buy_soldier", "tw_buy_attack","tw_page",}, item.action) then
        local bo = KImageView:new("main_icons_over")

        bo.pos = v(math.floor(-0.5 * (bo.size.x - b.size.x)), math.floor(-0.5 * (bo.size.y - b.size.y)))
        bo.propagate_on_click = true
        bo.disabled_tint_color = nil

        self:add_child(bo)
    end

    local ufx = KImageView:new("effect_powerbuy_0001")

    ufx.animation = {
        to = 23,
        prefix = "effect_powerbuy",
        from = 1
    }
    ufx.pos = v(4, -4)
    ufx.hidden = true
    ufx.propagate_on_click = true
    self.ufx = ufx

    self:add_child(ufx)

    self.size = V.vclone(b.size)
end

CriketMenu = class("CriketMenu", KImageView)

function CriketMenu:initialize(game_gui_instance)
    CriketMenu.super.initialize(self, "gui_ring")
    self.can_drag = false
    self.game_gui = game_gui_instance
    self.propagate_on_click = true
    self.propagate_on_down = true
    self.propagate_on_up = true
    self.propagate_on_enter = true
    self.anchor = v(self.size.x / 2, self.size.y / 2)
    self.clip = false
    self.replace = false
end

function CriketMenu:calculate_button_position(item_index)
    local circle_volume = 6
    local radius_mod = 65
    local radius = radius_mod -- 默认半径
    while item_index > circle_volume do
        item_index = item_index - circle_volume
        radius = radius + radius_mod -- 每圈增加80像素的半径
        circle_volume = circle_volume + 6 -- 每圈增加6个按钮
    end

    -- 计算每个按钮之间的角度间隔
    local angle_step = (2 * math.pi) / circle_volume

    -- 计算当前按钮的角度（从顶部开始，顺时针）
    local angle = (item_index - 1) * angle_step - math.pi / 2

    -- 计算相对于圆心的位置
    local x = math.cos(angle) * radius
    local y = math.sin(angle) * radius

    -- 返回相对于菜单中心的位置
    return V.v(self.size.x / 2 + x, self.size.y / 2 + y)
end
function CriketMenu:show()
    self:remove_children()
    for index, item in pairs(high_level_towers) do
        local b = CriketMenuButton:new(item)
        b.pos = self:calculate_button_position(index)
        b.pos.x, b.pos.y = b.pos.x - b.size.x / 2, b.pos.y - b.size.y / 2
        b.item_props = item

        local stm = self

        if item.action == "tw_none" then
            b:disable()
        else
            function b.on_click(this, button, x, y)
                log.debug("CLICK")
                if not self.tweening and not this.click_disabled then
                    stm:button_callback(this, item)
                end
            end

            function b.on_enter(this, drag_view)
                if not self.tweening then
                    stm:button_enter(this)
                end
            end

            function b.on_exit(this, drag_view)
                stm:button_exit(this)
            end
        end

        self:add_child(b)
    end

    self.pos = v(self.game_gui.sw * 0.5, self.game_gui.sh * 0.5)
    self.scale = v(1, 1)
    self.alpha = 1
    self.hidden = false
    -- self.tweening = true
    -- self.tweening = false
    -- self.tweeners = {timer:tween(0.12, self.scale, {
    --     x = 1,
    --     y = 1
    -- }, "out-quad"), timer:tween(0.12, self, {
    --     alpha = 1
    -- }, "out-quad", function()
    --     self.tweening = nil
    --     self.tweeners = {}
    -- end)}

    S:queue("GUIQuickMenuOpen")
end

function CriketMenu:hide()
    -- if self.tweeners then
    --     for _, t in pairs(self.tweeners) do
    --         timer:cancel(t)
    --     end
    -- end

    -- self.tweening = true
    -- self.tweeners = {timer:tween(0.12, self, {
    --     alpha = 0
    -- }, "out-quad"), timer:tween(0.12, self.scale, {
    --     x = 0.6,
    --     y = 0.6
    -- }, "out-quad", function()
    --     self.hidden = true
    --     self.tweening = false
    --     self.tweeners = {}
    -- end)}
    self.hidden = true
end

function CriketMenu:update(dt)
    CriketMenu.super.update(self, dt)

    if self.hidden then
        return
    end

    local store = self.game_gui.game.store

    for _, c in pairs(self.children) do
        if c:isInstanceOf(CriketMenuButton) and c.item_props then
            if c.item_props.action == "tw_upgrade" then
                local nt = E:get_template(c.item_props.action_arg)

                if nt.build_name then
                    nt = E:get_template(nt.build_name)
                end
            end
        end
    end
end

function CriketMenu:button_enter(button)
    if button.halo then
        button.halo.hidden = false
    end
end

function CriketMenu:button_exit(button)
    if button.halo then
        button.halo.hidden = true
    end
end

function CriketMenu:button_callback(button, item, entity, mouse_button, x, y)

    if item.action == "tw_upgrade" then
        local towers = table.filter(self.game_gui.game.store.entities, function(k, v)
            return v.tower
        end)
        for k, v in pairs(towers) do
            local new_tower = E:create_entity(item.action_arg)
            new_tower.pos = V.vclone(v.pos)
            new_tower.tower.holder_id = v.tower.holder_id
            new_tower.tower.flip_x = v.tower.flip_x
            if v.tower.default_rally_pos then
                new_tower.tower.default_rally_pos = V.vclone(v.tower.default_rally_pos)
            end
            if v.tower.terrain_style then
                new_tower.tower.terrain_style = v.tower.terrain_style
                new_tower.render.sprites[1].name =
                    string.format(new_tower.render.sprites[1].name, v.tower.terrain_style)
            end

            if new_tower.ui and v.ui then
                new_tower.ui.nav_mesh_id = v.ui.nav_mesh_id
            end
            if self.replace or v.tower.type == "holder" or (v.tower_holder and v.tower_holder.blocked == true) then
                self.game_gui.game.simulation:queue_remove_entity(v)
                self.game_gui.game.simulation:queue_insert_entity(new_tower)

                self.game_gui.game.store.entities[v.id] = new_tower
                if new_tower.powers then
                    for _, p in pairs(new_tower.powers) do
                        p.level = p.max_level
                        p.changed = true
                    end
                end

                if new_tower.barrack then
                    new_tower.barrack.rally_pos = V.vclone(new_tower.tower.default_rally_pos)
                end
                -- if new_tower.mercenary then
                --     for i = 1, new_tower.barrack.max_soldiers do
                --         new_tower.barrack.soldiers[i] = E:create_entity(new_tower.barrack.soldier_type)
                --         new_tower.barrack.soldiers[i].health.dead = true
                --         new_tower.barrack.soldiers[i].id = -1
                --     end
                -- end
            end
        end
    end
    self:hide()
end

local g1_to_g3_towers = {
    {
        check = "main_icons_0019",
        action_arg = "tower_blade",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0104",
        place = 1,
        tt_title = _("TOWER_BARRACKS_BLADE_NAME"),
        tt_desc = _("TOWER_BARRACKS_BLADE_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_forest",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0105",
        place = 2,
        tt_title = _("TOWER_FOREST_KEEPERS_NAME"),
        tt_desc = _("TOWER_FOREST_KEEPERS_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_drow_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "special_icons_0301",
        place = 3,
        tt_title = _("ELVES_TOWER_SPECIAL_DROW_NAME"),
        tt_desc = _("ELVES_TOWER_SPECIAL_DROW_DESCRIPTION")
    }, {
        check = "main_icons_0020",
        action_arg = "tower_elf_kr1",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0906",
        place = 3,
        tt_title = _("SPECIAL_ELF_KR1_REPAIR_NAME"),
        tt_desc = _("SPECIAL_ELF_KR1_REPAIR_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_holder_baby_ashbite_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0113",
        place = 2,
        tt_title = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_NAME"),
        tt_desc = _("ELVES_BABY_ASHBITE_TOWER_BROKEN_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_ewok_archer_re",--"tower_ewok_rework",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0112",
        place = 1,
        tt_title = _("ELVES_EWOK_NAME"),
        tt_desc = _("ELVES_EWOK_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_arcane",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0108",
        place = 1,
        tt_title = _("TOWER_ARCANE_NAME"),
        tt_desc = _("TOWER_ARCANE_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_silver",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0109",
        place = 2,
        tt_title = _("TOWER_SILVER_NAME"),
        tt_desc = _("TOWER_SILVER_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_green_archer",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "groundArchers_0002",
        place = 3, -- 3,
        tt_title = _("TOWER_GREEN_ARCHER_NAME"),
        tt_desc = _("TOWER_GREEN_ARCHER_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_druid",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0111",
        place = 1,
        tt_title = _("TOWER_DRUID_HENGE_NAME"),
        tt_desc = _("TOWER_DRUID_HENGE_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_entwood",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0110",
        place = 2,
        tt_title = _("TOWER_ENTWOOD_NAME"),
        tt_desc = _("TOWER_ENTWOOD_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_bastion_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_tower_icons_0003",
        place = 11,
        tt_title = _("ELVES_TOWER_BASTION_D_NAME"),
        tt_desc = _("ELVES_TOWER_BASTION_D_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_wild_magus",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0106",
        place = 1,
        tt_title = _("TOWER_MAGE_WILD_MAGUS_NAME"),
        tt_desc = _("TOWER_MAGE_WILD_MAGUS_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_high_elven",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0107",
        place = 2,
        tt_title = _("TOWER_MAGE_HIGH_ELVEN_NAME"),
        tt_desc = _("TOWER_MAGE_HIGH_ELVEN_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_pixie_re",--"tower_pixie_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_tower_icons_0002",
        place = 11,
        tt_title = _("ELVES_TOWER_PIXIE_NAME"),
        tt_desc = _("ELVES_TOWER_PIXIE_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_faerie_dragon_re",--"tower_faerie_dragon_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_tower_icons_0001",
        place = 12,
        tt_title = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_NAME"),
        tt_desc = _("ELVES_TOWER_SPECIAL_FAERIE_DRAGONS_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_bfg",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0013",
        place = 1, -- 3,
        tt_title = _("TOWER_BFG_NAME"),
        tt_desc = _("TOWER_BFG_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_tesla",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0012",
        place = 2, -- 4,
        tt_title = _("TOWER_TESLA_NAME"),
        tt_desc = _("TOWER_TESLA_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_ranger",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0011",
        place = 1, -- 3,
        tt_title = _("TOWER_RANGERS_NAME"),
        tt_desc = _("TOWER_RANGERS_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_musketeer",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0010",
        place = 2, -- 4,
        tt_title = _("TOWER_MUSKETEERS_NAME"),
        tt_desc = _("TOWER_MUSKETEERS_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_barbarian",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0009",
        place = 2, -- 3,
        tt_title = _("TOWER_BARBARIANS_NAME"),
        tt_desc = _("TOWER_BARBARIANS_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_paladin",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0008",
        place = 1, -- 11,
        tt_title = _("TOWER_PALADINS_NAME"),
        tt_desc = _("TOWER_PALADINS_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_necromancer",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0021",
        place = 1,
        tt_title = _("TOWER_NECROMANCER_NAME"),
        tt_desc = _("TOWER_NECROMANCER_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_archmage",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0022",
        place = 2,
        tt_title = _("TOWER_ARCHMAGE_NAME"),
        tt_desc = _("TOWER_ARCHMAGE_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_dwaarp",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0027",
        place = 1, -- 11,
        tt_title = _("TOWER_DWAARP_NAME"),
        tt_desc = _("TOWER_DWAARP_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_mech",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0028",
        place = 2, -- 12,
        tt_title = _("TOWER_MECH_NAME"),
        tt_desc = _("TOWER_MECH_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_totem",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0026",
        place = 1,
        tt_title = _("TOWER_TOTEM_NAME"),
        tt_desc = _("TOWER_TOTEM_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_crossbow",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0025",
        place = 2,
        tt_title = _("TOWER_CROSSBOW_NAME"),
        tt_desc = _("TOWER_CROSSBOW_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_archer_dwarf_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_tower_icons_0005",
        place = 3, -- 5,
        tt_title = _("TOWER_ARCHER_DWARF_NAME"),
        tt_desc = _("TOWER_ARCHER_DWARF_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_pirate_watchtower_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_tower_icons_0004",
        place = 4, -- 10,
        tt_title = _("TOWER_PIRATE_WATCHTOWER_NAME"),
        tt_desc = _("TOWER_PIRATE_WATCHTOWER_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_assassin",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0024",
        place = 1,
        tt_title = _("TOWER_ASSASSIN_NAME"),
        tt_desc = _("TOWER_ASSASSIN_DESCRIPTION")
    }, {
        action = "tw_upgrade",
        action_arg = "tower_templar",
        check = "main_icons_0019",
        halo = "glow_ico_main",
        image = "main_icons_0023",
        place = 2,
        tt_title = _("TOWER_TEMPLAR_NAME"),
        tt_desc = _("TOWER_TEMPLAR_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_barrack_dwarf_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "special_icons_0201",
        place = 3,
        tt_title = _("SPECIAL_DWARF_HALL_NAME"),
        tt_desc = _("SPECIAL_DWARF_HALL_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_barrack_amazonas_re",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0033a",
        place = 3, -- 15,
        tt_title = _("TOWER_BARRACK_AMAZONAS_NAME"),
        tt_desc = _("TOWER_BARRACK_AMAZONAS_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_barrack_mercenaries_d",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0029",
        place = 2,
        tt_title = _("TOWER_BARRACK_MERCENARIES_NAME"),
        tt_desc = _("TOWER_BARRACK_MERCENARIES_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_barrack_mercenaries_2",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_00aa",
        place = 1,
        tt_title = _("TOWER_BARRACK_MERCENARIES_NAME"),
        tt_desc = _("TOWER_BARRACK_MERCENARIES_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_barrack_pirate_captain",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0031a",
        place = 2,
        tt_title = _("TOWER_BARRACK_PIRATES_NAME"),
        tt_desc = _("TOWER_BARRACK_PIRATES_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_arcane_wizard",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0006",
        place = 1, -- 3,
        tt_title = _("TOWER_ARCANE_WIZARD_NAME"),
        tt_desc = _("TOWER_ARCANE_WIZARD_DESCRIPTION")
    }, {
        check = "main_icons_0019",
        action_arg = "tower_sorcerer",
        action = "tw_upgrade",
        halo = "glow_ico_main",
        image = "main_icons_0007",
        place = 2, -- 4,
        tt_title = _("TOWER_SORCERER_NAME"),
        tt_desc = _("TOWER_SORCERER_DESCRIPTION")
    }
}

local function patch_cricket_ui(game_gui)
    local original_init = game_gui.init

    function game_gui:init(w, h, game)
        -- 调用原始的初始化逻辑
        original_init(self, w, h, game)
        tower_menus = require("data.tower_menus_data")
        high_level_towers = {}
        -- user_data.liuhui.cheathero

        local user_data = storage:load_slot()

        local selected_holders = user_data.towers

        -- 加载5代防御塔
        local tower_5_data = map_data.tower_5_data
        local tower_menu_json = map_data.tower_menu_json
        local tower3_menu_json = map_data.tower3_menu_json
        local tower123_menu_json = tower_menus.holder_123
        local rank = 2
        --if user_data.liuhui.use3tower ~= nil and user_data.liuhui.use3tower == false then
        if (user_data.liuhui.use3tower ~= nil and user_data.liuhui.use3tower_count == 2) or (user_data.liuhui.use3tower ~= nil and user_data.liuhui.use3tower_count == 1) then
            table.remove(tower_menus["holder"][1]["pages"], 1)
            rank = 1         
        else
            tower_menus["holder"][1]["pages"][1] = tower123_menu_json[1]--tower3_menu_json[1]
            if #tower_menus["holder"][1]["pages"] == 1 then
                local empty_table = {}
                table.insert(tower_menus["holder"][1]["pages"], empty_table)
            end
            rank = 2
        end

        tower_menus["holder"][1]["pages"][rank] = {}
		if user_data.liuhui.use3tower_count == 1 then
            tower_menus["holder"][1]["pages"][rank] = tower123_menu_json[1]
		else        
        	if user_data.tower_pick < 6 then
        	    for i = 1, user_data.tower_pick do
        	        table.insert(tower_menus["holder"][1]["pages"][rank], tower_menu_json[selected_holders[i]])
        	        tower_menus["holder"][1]["pages"][rank][i]["place"] = i
        	    end
        	else
        	    local place_list = {1, 2, 3, 4, 11, 12, 5, 9, 13, 19}
        	    for i = 1, user_data.tower_pick do
        	        table.insert(tower_menus["holder"][1]["pages"][rank], tower_menu_json[selected_holders[i]])
        	        tower_menus["holder"][1]["pages"][rank][i]["place"] = place_list[i]
        	    end
        	end
        end    

        if user_data.liuhui.cheat or user_data.liuhui.cheathero then
            table.insert(tower_menus["holder"][1]["pages"][rank], map_data.gold_json)
            local cheat_rank = #tower_menus["holder"][1]["pages"][rank]--user_data.tower_pick+1
            tower_menus["holder"][1]["pages"][rank][cheat_rank]["place"] = 15
            if (user_data.liuhui.cheat or user_data.liuhui.cheathero) and user_data.tower_pick >= 11 and (screen_map.user_data.liuhui.rand_tower == nil or screen_map.user_data.liuhui.rand_tower == 0) then
                tower_menus["holder"][1]["pages"][rank][cheat_rank]["place"] = 14
            end
		    if (user_data.liuhui.use3tower_count == 1) and (screen_map.user_data.liuhui.rand_tower == nil or screen_map.user_data.liuhui.rand_tower == 0)  then
		    	tower_menus["holder"][1]["pages"][rank][cheat_rank]["place"] = 18
		    end	            
            if screen_map.user_data.liuhui.rand_tower and screen_map.user_data.liuhui.rand_tower >= 3 and screen_map.user_data.liuhui.rand_tower_mode == 4 then
                tower_menus["holder"][1]["pages"][rank][cheat_rank]["place"] = 14
            end
        end
        if user_data.liuhui.cheat5 or liuhui.cheat5_dragon then
            table.insert(tower_menus["holder"][1]["pages"][rank], map_data.cheat_g5_json)
            local cheat5_rank_inc = user_data.liuhui.cheat and 2 or 1
            local cheat5_rank = #tower_menus["holder"][1]["pages"][rank]--cheat5_rank_inc + user_data.tower_pick
            tower_menus["holder"][1]["pages"][rank][cheat5_rank]["place"] = 21
            if (user_data.liuhui.cheat5 or liuhui.cheat5_dragon) and user_data.tower_pick == 12 and (screen_map.user_data.liuhui.rand_tower == nil or screen_map.user_data.liuhui.rand_tower == 0) then
                tower_menus["holder"][1]["pages"][rank][cheat5_rank]["place"] = 20
            end
		    if (user_data.liuhui.use3tower_count == 1) and (screen_map.user_data.liuhui.rand_tower == nil or screen_map.user_data.liuhui.rand_tower == 0) then
		    	tower_menus["holder"][1]["pages"][rank][cheat5_rank]["place"] = 24
		    end	            
            if screen_map.user_data.liuhui.rand_tower and screen_map.user_data.liuhui.rand_tower >= 3 and screen_map.user_data.liuhui.rand_tower_mode == 4 then
                tower_menus["holder"][1]["pages"][rank][cheat5_rank]["place"] = 20
            end
        end

        local pages = tower_menus["holder"][1]["pages"]
        local none_g1_to_g3_towers = pages[#pages]
        for _, tower_menu in pairs(none_g1_to_g3_towers) do
            if tower_menu["action"] == "tw_upgrade" then
                local tower_menu_transformed = {}
                for k, v in pairs(tower_menu) do
                    tower_menu_transformed[k] = v
                    if k == "action_arg" then
                        if v == "tower_build_arcane_wizard" then
                            tower_menu_transformed[k] = "tower_arcane_wizard_lvl4"
                        elseif v == "tower_build_necromancer" then
                            tower_menu_transformed[k] = "tower_necromancer_lvl4"
                        elseif string.sub(v, 1, 12) == "tower_build_" then
                            local tower_type = string.sub(v, 13)
                            local tower_menu_indexed_by_type = tower_menus[tower_type]
                            if tower_menu_indexed_by_type then
                                local tower_menu_lvl3 = tower_menu_indexed_by_type[3]
                                if tower_menu_lvl3 then
                                    for _, v2 in pairs(tower_menu_lvl3) do
                                        if v2["action"] == "tw_upgrade" then
                                            tower_menu_transformed[k] = v2["action_arg"]
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                table.insert(high_level_towers, tower_menu_transformed)
            end
        end

        for _, tower_menu in pairs(g1_to_g3_towers) do
            table.insert(high_level_towers, tower_menu)
        end

        local criketmenu = CriketMenu:new(self)
        criketmenu.hidden = true

        -- 将criketmenu添加到layer_gui_game中（与towermenu同级）
        self.layer_gui_game:add_child(criketmenu)
        self.layer_gui:add_child(self.layer_gui_game)
        self.window:add_child(self.layer_gui)
        -- 存储引用
        self.criketmenu = criketmenu

    end

    local original_key_pressed = game_gui.keypressed

    function game_gui:keypressed(key, isrepeat)
        original_key_pressed(self, key, isrepeat)
        if key == SELF_DEFINED_KEY_OPEN_MENU then
            self.criketmenu:show()
        elseif key == SELF_DEFINED_KEY_COLSE_MENU then
            self.criketmenu:hide()
        elseif key == SELF_DEFINED_KEY_SWITCH_MENU then
            self.criketmenu.replace = not self.criketmenu.replace
        end
    end

end

return patch_cricket_ui

