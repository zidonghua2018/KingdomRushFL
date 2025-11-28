local a = {
--攻击动画
    --buff
    darkarmy_melting_furnace_tower_swords_run = {
        prefix = "darkarmy_melting_furnace_tower_swords",
        from = 1,
        to = 24
    },
    --攻击烟雾
    darkarmy_melting_furnace_smoke_run = {
        prefix = "darkarmy_melting_furnace_smoke",
        from = 1,
        to = 14
    },
    --煤块
    darkarmy_melting_furnace_decal_fissure = {
        prefix = "darkarmy_melting_furnace_decal_fissure",
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl4_fissure_hit_start = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_fissure_hit",
        from = 1,
        to = 13
    },
    darkarmy_melting_furnace_tower_lvl4_fissure_hit_run = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_fissure_hit",
        from = 14,
        to = 21
    },
    --加速攻击
    darkarmy_melting_furnace_tower_lvl4_flames_fadeIn = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_flames",
        from = 1,
        to = 4
    },
    darkarmy_melting_furnace_tower_lvl4_flames_loop = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_flames",
        from = 5,
        to = 19
    },
    darkarmy_melting_furnace_tower_lvl4_flames_fadeOut = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_flames",
        from = 20,
        to = 27
    },
--防御塔建造/1级
    darkarmy_melting_furnace_tower_lvl1_layerX_build = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl1_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 2,
        to = 2
    },
    darkarmy_melting_furnace_tower_lvl1_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 3,
        to = 75
    },
--防御塔2级
    darkarmy_melting_furnace_tower_lvl2_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl2_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 2,
        to = 75
    },
--防御塔3级
    darkarmy_melting_furnace_tower_lvl3_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl3_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 2,
        to = 75
    },
--防御塔4级
    darkarmy_melting_furnace_tower_lvl4_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 1,
        to = 74
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 75,
        to = 75
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_bfIntro = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 76,
        to = 115
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_bfLoop = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 116,
        to = 120
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_bfHit = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 121,
        to = 149
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_shootFissure = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 150,
        to = 223
    }
}

local o = {}

o.animations = a

return o