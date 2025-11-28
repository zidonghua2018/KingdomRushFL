local a = {
--塔
    worm_nest_level1_build = {
        prefix = "worm_nest_level1",
        from = 1,
        to = 29
    },
    worm_nest_level1_idle = {
        prefix = "worm_nest_level1",
        from = 30,
        to = 106
    },
    worm_nest_level1_shoot = {
        prefix = "worm_nest_level1",
        from = 107,
        to = 154
    },
    worm_nest_level2_idle = {
        prefix = "worm_nest_level2",
        from = 1,
        to = 76
    },
    worm_nest_level2_shoot = {
        prefix = "worm_nest_level2",
        from = 77,
        to = 124
    },
    worm_nest_level3_idle = {
        prefix = "worm_nest_level3",
        from = 1,
        to = 76
    },
    worm_nest_level3_shoot = {
        prefix = "worm_nest_level3",
        from = 77,
        to = 124
    },
    worm_nest_level4_idle = {
        prefix = "worm_nest_level4",
        from = 1,
        to = 76
    },
    worm_nest_level4_shoot = {
        prefix = "worm_nest_level4",
        from = 77,
        to = 124
    },
    worm_nest_level4_spit = {
        prefix = "worm_nest_level4",
        from = 125,
        to = 166
    },
    worm_nest_level4_instakill = {
        prefix = "worm_nest_level4",
        from = 167,
        to = 296
    },
--秒杀
    worm_nest_level4_instakill_run = {
        prefix = "worm_nest_level4_instakill",
        from = 1,
        to = 51
    },
    worm_nest_level4_instakill_decal_run = {
        prefix = "worm_nest_level4_instakill_decal",
        from = 1,
        to = 14
    },
    worm_nest_level4_instakill_dust_run = {
        prefix = "worm_nest_level4_instakill_dust",
        from = 1,
        to = 11
    },
--普攻
    worm_nest_attack_in = {
        prefix = "worm_nest_attack",
        from = 1,
        to = 26
    },
    worm_nest_attack_run = {
        prefix = "worm_nest_attack",
        from = 27,
        to = 77
    },
    worm_nest_attack_out = {
        prefix = "worm_nest_attack",
        from = 78,
        to = 103
    },
--召唤物
     worm_nest_level4_tremor_idle = {
        prefix = "worm_nest_level4_tremor",
        from = 43,
        to = 43
    },
    worm_nest_level4_tremor_in = {
        prefix = "worm_nest_level4_tremor",
        from = 64,
        to = 79
    },
    worm_nest_level4_tremor_running = {
        prefix = "worm_nest_level4_tremor",
        from = 1,
        to = 14
    },
    worm_nest_level4_tremor_walk = {
        prefix = "worm_nest_level4_tremor",
        from = 1,
        to = 14
    },
    worm_nest_level4_tremor_walkUp = {
        prefix = "worm_nest_level4_tremor",
        from = 15,
        to = 28
    },
    worm_nest_level4_tremor_walkDown = {
        prefix = "worm_nest_level4_tremor",
        from = 29,
        to = 42
    },
    worm_nest_level4_tremor_death = {
        prefix = "worm_nest_level4_tremor",
        from = 80,
        to = 98
    },
    worm_nest_level4_tremor_attack = {
        prefix = "worm_nest_level4_tremor",
        from = 43,
        to = 63
    },
    worm_nest_level4_tremor_raise = {
        prefix = "worm_nest_level4_tremor",
        from = 99,
        to = 109
    },
--粘液
    worm_nest_level4_spit_decal_in = {
        prefix = "worm_nest_level4_spit_decal",
        from = 1,
        to = 18
    },
    worm_nest_level4_spit_decal_run = {
        prefix = "worm_nest_level4_spit_decal",
        from = 19,
        to = 19
    },
    worm_nest_level4_spit_hit_run = {
        prefix = "worm_nest_level4_spit_hit",
        from = 1,
        to = 7
    },
    worm_nest_level4_spit_trail_run = {
        prefix = "worm_nest_level4_spit_trail",
        from = 1,
        to = 11
    },
    
}

local o = {}

o.animations = a

return o