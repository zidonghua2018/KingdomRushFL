return {
	--下船恐惧
	Lucerna_run = {
		prefix = "Lucerna",
		to = 56,
		from = 1
	},
	--普攻爆炸
	Lucerna_explosion_run = {
		prefix = "Lucerna_explosion",
		to = 22,
		from = 1
	},
	--恐惧伤害效果
	Lucerna_fearDecal_run = {
		prefix = "Lucerna_fearDecal",
		to = 28,
		from = 1
	},
	--恐惧效果
	Lucerna_fearModifier_run = {
		prefix = "Lucerna_fearModifier",
		to = 4,
		from = 1
	},
	--策反效果
	Lucerna_possession_decal_start = {
		prefix = "Lucerna_possession_decal",
		to = 21,
		from = 1
	},
	Lucerna_possession_decal_loop = {
		prefix = "Lucerna_possession_decal",
		to = 49,
		from = 22
	},
	Lucerna_possession_decal_end = {
		prefix = "Lucerna_possession_decal",
		to = 74,
		from = 50
	},
	--策反弹
	Lucerna_possession_projectile_spawn = {
		prefix = "Lucerna_possession_projectile",
		to = 15,
		from = 1
	},
	Lucerna_possession_projectile_travel = {
		prefix = "Lucerna_possession_projectile",
		to = 27,
		from = 16
	},
	Lucerna_possession_projectile_hit = {
		prefix = "Lucerna_possession_projectile",
		to = 37,
		from = 28
	},
	--导弹的尾焰
	Lucerna_projectileTrail_run = {
		prefix = "Lucerna_projectileTrail",
		to = 16,
		from = 1
	},
	--导弹本体
	Lucerna_projectile_flying = {
		prefix = "Lucerna_projectile",
		to = 12,
		from = 1
	},
	--2技能 弹幕轰炸
	Lucerna_Ship_ability_run = {
		prefix = "Lucerna_Ship_ability",
		to = 28,
		from = 1
	},
	--静止
	Lucerna_Ship_layerX_idle = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 28,
		from = 1
	},
	--普攻
	Lucerna_Ship_layerX_attack = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 56,
		from = 29
	},
	--2技能
	Lucerna_Ship_layerX_ability = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 84,
		from = 57
	},
	--传送动画
	Lucerna_Ship_layerX_teleportOut = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 112,
		from = 85
	},
	Lucerna_Ship_layerX_teleportIn = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 140,
		from = 113
	},
	--阵亡动画
	Lucerna_Ship_layerX_death = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 190,
		from = 141
	},
	--阵亡期间的效果，不是普通的墓碑，有额外的动画。
	Lucerna_Ship_layerX_deathloop = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 225,
		from = 191
	},
	--复活/开局召唤效果
	Lucerna_Ship_layerX_respawn = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 252,
		from = 226
	},
	Lucerna_Ship_layerX_lvlup = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 279,
		from = 253
	},
	--3技能
	Lucerna_Ship_layerX_summon = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 307,
		from = 280
	},
	--1技能
	Lucerna_Ship_layerX_fear = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 363,
		from = 308
	},
	--叠加动画-升级
	Lucerna_Ship_lvlup_run = {
		prefix = "Lucerna_Ship_lvlup",
		to = 27,
		from = 1
	},
	--叠加动画-旗帜
	Lucerna_Ship_flag_run = {
		prefix = "Lucerna_Ship_flag",
		to = 50,
		from = 1
	},
	--叠加动画-船桨1
	Lucerna_Ship_remosBack_run = {
		prefix = "Lucerna_Ship_remosBack",
		to = 28,
		from = 1
	},
	--叠加动画-船桨2
	Lucerna_Ship_remos_run = {
		prefix = "Lucerna_Ship_remos",
		to = 28,
		from = 1
	},
	--叠加动画-传送出
	Lucerna_Ship_teleport_teleportOut = {
		prefix = "Lucerna_Ship_teleport",
		to = 28,
		from = 1
	},
	--叠加动画-传送进
	Lucerna_Ship_teleport_teleportIn = {
		prefix = "Lucerna_Ship_teleport",
		to = 56,
		from = 29
	},
	--图腾环绕效果
	Lucerna_totemDecal_idle = {
		prefix = "Lucerna_totemDecal",
		to = 38,
		from = 1
	},
	Lucerna_totemDecal_run = {
		prefix = "Lucerna_totemDecal",
		to = 38,
		from = 1
	},
	Lucerna_totemDecal_death = {
		prefix = "Lucerna_totemDecal",
		to = 38,
		from = 1
	},
	Lucerna_totem_spawn = {
		prefix = "Lucerna_totem",
		to = 15,
		from = 1
	},
	Lucerna_totem_idle = {
		prefix = "Lucerna_totem",
		to = 43,
		from = 16
	},
	Lucerna_totem_summon = {
		prefix = "Lucerna_totem",
		to = 63,
		from = 44
	},
	Lucerna_totem_death = {
		prefix = "Lucerna_totem",
		to = 81,
		from = 64
	},
	--召唤物
	lucerna_unitghosts_walk = {
		prefix = "lucerna_unitghosts",
		to = 28,
		from = 1
	},
	lucerna_unitghosts_idle = {
		prefix = "lucerna_unitghosts",
		to = 28,
		from = 1
	},
	lucerna_unitghosts_running = {
		prefix = "lucerna_unitghosts",
		to = 28,
		from = 1
	},
	lucerna_unitghosts_attack = {
		prefix = "lucerna_unitghosts",
		to = 54,
		from = 29
	},
	lucerna_unitghosts_death = {
		prefix = "lucerna_unitghosts",
		to = 75,
		from = 55
	},
	lucerna_unitghosts_spawn = {
		prefix = "lucerna_unitghost_vfxs",
		to = 28,
		from = 1
	},
}
