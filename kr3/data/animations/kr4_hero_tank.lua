return {
	hero_tank_idle = {
		prefix = "hero_tank",
		to = 1,
		from = 1
	},
	hero_tank_walkDown = {
		prefix = "hero_tank",
		to = 7,
		from = 2
	},
	hero_tank_moreDownWalk = {
		prefix = "hero_tank",
		to = 13,
		from = 8
	},
	hero_tank_downWalk = {
		prefix = "hero_tank",
		to = 19,
		from = 14
	},
	--实际用的时候用这个走路动画就行了
	hero_tank_walk = {
		prefix = "hero_tank",
		to = 25,
		from = 20
	},
	hero_tank_running = {
		prefix = "hero_tank",
		to = 25,
		from = 20
	},
	hero_tank_upWalk = {
		prefix = "hero_tank",
		to = 31,
		from = 26
	},
	hero_tank_moreUpWalk = {
		prefix = "hero_tank",
		to = 37,
		from = 32
	},
	hero_tank_walkUp = {
		prefix = "hero_tank",
		to = 43,
		from = 38
	},
	--普攻
	hero_tank_shoot = {
		prefix = "hero_tank",
		to = 92,
		from = 44
	},
	--2技能捶地
	hero_tank_GroundSlam = {
		prefix = "hero_tank",
		to = 148,
		from = 93
	},
	--1技能发射导弹
	hero_tank_HeatMissilesIn = {
		prefix = "hero_tank",
		to = 186,
		from = 149
	},
	hero_tank_HeatMissilesLoop = {
		prefix = "hero_tank",
		to = 191,
		from = 187
	},
	hero_tank_HeatMissilesLastLoop = {
		prefix = "hero_tank",
		to = 204,
		from = 192
	},
	hero_tank_HeatMissilesOut = {
		prefix = "hero_tank",
		to = 227,
		from = 205
	},
	--4技能喷火
	hero_tank_scorchingCannonIn = {
		prefix = "hero_tank",
		to = 243,
		from = 228
	},
	hero_tank_scorchingCannonLoop = {
		prefix = "hero_tank",
		to = 279,
		from = 244
	},
	hero_tank_scorchingCannonOut = {
		prefix = "hero_tank",
		to = 297,
		from = 280
	},
	--召唤援军。
	--说明：参考兵营塔。
	hero_tank_theExpendablesIn = {
		prefix = "hero_tank",
		to = 317,
		from = 298
	},
	hero_tank_theExpendablesSpawn = {
		prefix = "hero_tank",
		to = 341,
		from = 318
	},
	hero_tank_theExpendablesOut = {
		prefix = "hero_tank",
		to = 349,
		from = 342
	},
	--阵亡、重生与升级
	hero_tank_death = {
		prefix = "hero_tank",
		to = 473,
		from = 350
	},
	hero_tank_deathloop = {
		prefix = "hero_tank",
		to = 475,
		from = 474
	},
	hero_tank_respawn = {
		prefix = "hero_tank",
		to = 500,
		from = 476
	},
	hero_tank_levelup = {
		prefix = "hero_tank",
		to = 551,
		from = 501
	},
	--idle，也许可以替换
	hero_tank_boredIn = {
		prefix = "hero_tank",
		to = 569,
		from = 552
	},
	hero_tank_boredLoop = {
		prefix = "hero_tank",
		to = 577,
		from = 570
	},
	hero_tank_boredOut = {
		prefix = "hero_tank",
		to = 605,
		from = 578
	},
	--尾焰系统，计入本体的pryoectile
	hero_tank_dust_run = {
		prefix = "hero_tank_dust",
		to = 22,
		from = 1
	},
	hero_tank_dust_out = {
		prefix = "hero_tank_dust",
		to = 33,
		from = 23
	},
	hero_tank_smoke_run = {
		prefix = "hero_tank_smoke",
		to = 22,
		from = 1
	},
	--近战兵
	hero_tank_expendable1_idle = {
		prefix = "hero_tank_expendable1",
		to = 1,
		from = 1
	},
	hero_tank_expendable1_spawn = {
		prefix = "hero_tank_expendable1",
		to = 14,
		from = 2
	},
	hero_tank_expendable1_walk = {
		prefix = "hero_tank_expendable1",
		to = 28,
		from = 15
	},
	hero_tank_expendable1_running = {
		prefix = "hero_tank_expendable1",
		to = 28,
		from = 15
	},
	hero_tank_expendable1_melee = {
		prefix = "hero_tank_expendable1",
		to = 47,
		from = 29
	},
	hero_tank_expendable1_death = {
		prefix = "hero_tank_expendable1",
		to = 63,
		from = 48
	},
	--远程兵
	hero_tank_expendable2_idle = {
		prefix = "hero_tank_expendable2",
		to = 1,
		from = 1
	},
	hero_tank_expendable2_spawn = {
		prefix = "hero_tank_expendable2",
		to = 14,
		from = 2
	},
	hero_tank_expendable2_walk = {
		prefix = "hero_tank_expendable2",
		to = 28,
		from = 15
	},
	hero_tank_expendable2_running = {
		prefix = "hero_tank_expendable2",
		to = 28,
		from = 15
	},
	hero_tank_expendable2_melee = {
		prefix = "hero_tank_expendable2",
		to = 47,
		from = 29
	},
	hero_tank_expendable2_rangedSide = {
		prefix = "hero_tank_expendable2",
		to = 79,
		from = 48
	},
	hero_tank_expendable2_rangedDown = {
		prefix = "hero_tank_expendable2",
		to = 111,
		from = 80
	},
	hero_tank_expendable2_rangedUp = {
		prefix = "hero_tank_expendable2",
		to = 143,
		from = 112
	},
	hero_tank_expendable2_shoot = {
		prefix = "hero_tank_expendable2",
		to = 143,
		from = 112
	},
	hero_tank_expendable2_death = {
		prefix = "hero_tank_expendable2",
		to = 159,
		from = 144
	},
	--4技能火焰buff和地面效果
	hero_tank_fire_run = {
		prefix = "hero_tank_fire",
		to = 20,
		from = 1
	},
	hero_tank_fire_loop_in = {
		prefix = "hero_tank_fire_loop",
		to = 19,
		from = 1
	},
	hero_tank_fire_loop_run = {
		prefix = "hero_tank_fire_loop",
		to = 47,
		from = 20
	},
	hero_tank_fire_loop_out = {
		prefix = "hero_tank_fire_loop",
		to = 71,
		from = 48
	},
	--2技能捶地效果
	hero_tank_GroundSlam_decal_run = {
		prefix = "hero_tank_GroundSlam_decal",
		to = 19,
		from = 1
	},
	hero_tank_GroundSlam_effect_run = {
		prefix = "hero_tank_GroundSlam_effect",
		to = 2,
		from = 1
	},
	--普攻/导弹的对地/对空爆炸效果。
	hero_tank_hit_air_run = {
		prefix = "hero_tank_hit",
		to = 18,
		from = 1
	},
	hero_tank_hit_run = {
		prefix = "hero_tank_hit",
		to = 18,
		from = 1
	},
	--导弹的尾焰
	hero_tank_missile_particle_run = {
		prefix = "hero_tank_missile_particle",
		to = 6,
		from = 1
	},
	--大招的燃烧效果
	hero_tank_ultimate_fire_in = {
		prefix = "hero_tank_ultimate_fire",
		to = 24,
		from = 1
	},
	hero_tank_ultimate_fire_run = {
		prefix = "hero_tank_ultimate_fire",
		to = 49,
		from = 25
	},
	hero_tank_ultimate_fire_out = {
		prefix = "hero_tank_ultimate_fire",
		to = 67,
		from = 50
	},
	--大招的debuff效果
	hero_tank_ultimate_fire_modifier_in = {
		prefix = "hero_tank_ultimate_fire_modifier",
		to = 8,
		from = 1
	},
	hero_tank_ultimate_fire_modifier_run = {
		prefix = "hero_tank_ultimate_fire_modifier",
		to = 21,
		from = 9
	},
	hero_tank_ultimate_fire_modifier_out = {
		prefix = "hero_tank_ultimate_fire_modifier",
		to = 36,
		from = 22
	},
	--大招的飞机
	hero_tank_ultimate_plane_fly_idle = {
		prefix = "hero_tank_ultimate_plane",
		to = 4,
		from = 1
	},
	--大招爆炸效果
	hero_tank_ultimate_proyectile_explosion_run = {
		prefix = "hero_tank_ultimate_proyectile_explosion",
		to = 13,
		from = 1
	},
}
