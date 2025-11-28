local a = {
--1级塔
    warmongers_rocket_towers_lvl1_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl1_layerX_build = {
        layer_prefix = "warmongers_rocket_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 64,
        to = 64
    },
    warmongers_rocket_towers_lvl1_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 1,
        to = 62
    },
--2级塔
    warmongers_rocket_towers_lvl2_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl2_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 1,
        to = 62
    },
--3级塔
    warmongers_rocket_towers_lvl3_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl3_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 1,
        to = 62
    },
--4级塔
    warmongers_rocket_towers_lvl4_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl4_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 1,
        to = 62
    },
--炸弹
    warmongers_rocket_missile_lvl1_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl1",
        from = 1,
        to = 10
    },
    warmongers_rocket_missile_lvl2_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl2",
        from = 1,
        to = 10
    },
    warmongers_rocket_missile_lvl3_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl3",
        from = 1,
        to = 10
    },
    warmongers_rocket_missile_lvl4_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl4",
        from = 1,
        to = 5
    },
    warmongers_rocket_missile_lvl4_special_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl4_special",
        from = 1,
        to = 5
    },
--4级普攻/强化普攻的尾焰
    warmongers_rocket_missile_lvl4_particle_special_run = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl4_special_particle",
        from = 1,
        to = 11
    },
    warmongers_rocket_missile_lvl4_particle1_run = {
        prefix = "warmongers_rocket_shooter_proyectile_particle1_lvl4",
        from = 1,
        to = 11
    },
    warmongers_rocket_missile_lvl4_particle2_run = {
        prefix = "warmongers_rocket_shooter_proyectile_particle2_lvl4",
        from = 1,
        to = 11
    },
--蓝色爆炸特效
    warmongers_rocket_tower_lvl4_blue_explosion_run = {
        prefix = "warmongers_rocket_tower_lvl4_blue_explosion",
        from = 1,
        to = 18
    },
--炸弹盒子
    warmongers_rocket_tower_lvl4_box_goblin_mine_floor_out = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_mine_floor",
        from = 1,
        to = 7
    },
    warmongers_rocket_tower_lvl4_box_goblin_mine_floor_loop = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_mine_floor",
        from = 8,
        to = 30
    },
    warmongers_rocket_tower_lvl4_box_goblin_idle = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_right",
        from = 1,
        to = 1
    },
    warmongers_rocket_tower_lvl4_box_goblin_shootRight = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_right",
        from = 1,
        to = 79
    },
    warmongers_rocket_tower_lvl4_box_goblin_shootLeft = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_left",
        from = 1,
        to = 79
    },
    warmongers_rocket_tower_lvl4_box_idle = {
        prefix = "warmongers_rocket_tower_lvl4_box",
        from = 79,
        to = 79
    },
    warmongers_rocket_tower_lvl4_box_shootLeft = {
        prefix = "warmongers_rocket_tower_lvl4_box",
        from = 1,
        to = 78
    },
--群簇轰炸
    warmongers_rocket_tower_lvl4_cluster_blue_air_explosion_run = {
        prefix = "warmongers_rocket_tower_lvl4_cluster_blue_air_explosion",
        from = 1,
        to = 31
    },
    warmongers_rocket_tower_lvl4_air_explosion_run = {
        prefix = "warmongers_rocket_tower_lvl4_cluster_air_explosion",
        from = 1,
        to = 31
    },



}

local o = {}

o.animations = a

return o