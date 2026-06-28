-- chunkname: @./kr3-desktop/assets/strings/zh-Hans.lua

local z1 = require("assets.strings." .. "zh-Hans_1")
local z2 = require("assets.strings." .. "zh-Hans_2")
local z3 = require("assets.strings." .. "zh-Hans_3")
local z4 = require("assets.strings." .. "zh-Hans_4")
local z4h = require("assets.strings." .. "zh-Hans_4h")
local z5 = require("assets.strings." .. "zh-Hans_5")
local z0 = require("assets.strings." .. "zh-Hans_0")
local z5sp = require("assets.strings." .. "zh-Hans_5sp")
local zv4 = require("assets.strings." .. "zh-Hans_v")
local z4local = require("assets.strings." .. "Localized_zh-cn")


local z={}
local count = 0

for k, v in pairs(z1) do
	z[k] = v
end

for k, v in pairs(z5) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z4) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z4local) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z4h) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z2) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z3) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end


for k, v in pairs(z0) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z5sp) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(zv4) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

z["START HERE!!"] = "按Tab隐藏UI,可上下滑动"
z["START HERE!!!"] = "当前仅移植8关，其他关卡敬请期待"

z["BUTTON_NEXT_PAGE"] = "下一页"
z["BUTTON_PREV_PAGE"] = "上一页"
z["MAP_DOUBLE_HERO_ROOM_SELECT"] = "选择双英雄"
z["Rush"] = "初代"
z["Frontier"] = "前线"
z["Origin"] = "起源"
z["Vegnance"] = "复仇"
z["Alliance"] = "联盟"
z["Tower"] = "防御塔"
z["TowerList_G5"] = "联盟防御塔"
z["TowerList_G4"] = "复仇防御塔"
z["SELECTED_HINT"] = "4/5代已选择（前3代塔可在右侧配置）"
z["ImpossibleHPRate"] = "设置不可能难度血量"
z["PICK123"] = "设置携带123代防御塔"
z["PICK12"]= "携带12"
z["UNPICK12"]= "不携带12"
z["PICK3"]= "携带前3代"
z["UNPICK3"]= "不携带前3代"
z["G3_STANDARD"]= "标准不可能"
z["G3_CALRATE"]= "计算倍率"
z["G3_IMPOSSIBLE"] = "3代不可能难度血量"
z["IS_CHEAT"]= "设置启用金手指与局内召唤"
z["IS_RAND"]= "设置随机模式（详细介绍可见新手教程）"
z["MAGIC_ARMOR_DESC"] = "魔抗"
z["RAND_CREEP_0"]= "关闭随机怪物"
z["RAND_CREEP_1"]= "小幅随机"
z["RAND_CREEP_2"]= "中幅随机"
z["RAND_CREEP_3"]= "大幅随机"
z["RAND_TOWER_0"]= "关闭随机塔"
z["RAND_TOWER_1"]= "随机4塔"
z["RAND_TOWER_2"]= "随机8塔"
z["RAND_TOWER_3"]= "随机12塔"
z["RAND_TOWER_4"]= "随机16塔"
z["RAND_TOWER_5"]= "随机20塔"
z["RAND_TOWER_MODE_0"]= "1级分类随机"
z["RAND_TOWER_MODE_1"]= "2级分类随机"
z["RAND_TOWER_MODE_2"]= "1级全随机"
z["RAND_TOWER_MODE_3"]= "2级全随机"
z["RAND_TOWER_MODE_4"]= "开局随机"
z["RAND_HERO_0"]= "关闭随机英雄"
z["RAND_HERO_1"]= "随机英雄"
z["RANDOM_DESC"] = "听从命运的安排！"
z["RANDOM0_LVL1"] = "随机1级塔"
z["RANDOM1_LVL1"] = "随机1级箭塔"
z["RANDOM2_LVL1"] = "随机1级兵营"
z["RANDOM3_LVL1"] = "随机1级法师"
z["RANDOM4_LVL1"] = "随机1级炮塔"
z["RANDOM0_LVL2"] = "随机2级塔"
z["RANDOM1_LVL2"] = "随机2级箭塔"
z["RANDOM2_LVL2"] = "随机2级兵营"
z["RANDOM3_LVL2"] = "随机2级法师"
z["RANDOM4_LVL2"] = "随机2级炮塔"
z["CHEAT_GOLD"]= "启用金手指"
z["NO_CHEAT_GOLD"]= "不用金手指"
z["CHEAT_HERO"]= "启用召唤"
z["NO_CHEAT_HERO"]= "不启用召唤"
z["G5_SELECT"] = "启用5代召唤"
z["G5_DESELECT"] = "不启用5代"
z["G5_SPECIAL"] = "5代英雄召唤"
z["G5_DRAGON_DESELECT"] = "不启用龙魂"
z["G5_DRAGON_SPECIAL"] = "已启用龙魂"
z["BALANCE_MODE"] = "防御塔增强"
z["FLBALANCE"] = "开启补强"
z["FLSTANDARD"] = "关闭补强"
z["FL_RANGE_BALANCE"] = "调整4代范围"
z["FL_RANGE_STD"] = "原版4代范围"
z["HINT_STR"] = "(仅兼容模式下)英雄召唤非常吃内存，如果频繁蓝屏，\n请关闭召唤，并降低防御塔携带数量。小于3070Ti/\n32GB的设备建议不超过6种，其余请根据配置调整。"
z["HINT_STR2"] = "有关兼容模式/防御塔携带量的详细说明请参照新手教程"
z["CPMODE_ON"] = "已开启"
z["CPMODE_OFF"] = "已关闭"
z["COMPATIBILITY_MODE"] = "兼容模式(非兼容能玩则别开)"
z["SETTINGS_MAX_THREADS"] = "最大线程数"
z["DOUBLE HERO ROOM"] = "双英雄系统"
z["HERO5_MODE_ON"] = "已启用双英雄"
z["HERO5_MODE_OFF"] = "已关闭双英雄"
z["LH349_ENEMY_COUNT"] = "设置出怪数量"
z["LH349_ENEMY_COUNT_1"] = "正常出怪"
z["LH349_ENEMY_COUNT_2"] = "双倍出怪"
z["LH349_ENEMY_COUNT_3"] = "三倍出怪"
z["G5_HERO_DARK_COUNT"] = "5代援军/羁绊"
z["G5_HERO_DARK_COUNT_0"] = "双王国军"
z["G5_HERO_DARK_COUNT_1"] = "单王单黑"
z["G5_HERO_DARK_COUNT_2"] = "双黑暗军"
z["G5_REINFORCEMENT_1"] = "王国军援军"
z["G5_REINFORCEMENT_2"] = "黑暗军援军"
z["LH349_REINFORCEMENT_SKIN"] = "设置1代援军皮肤"
z["LH349_REINFORCEMENT_SKIN_0"] = "原版皮肤"
z["LH349_REINFORCEMENT_SKIN_1"] = "星球大战"
z["LH349_REINFORCEMENT_SKIN_2"] = "真人快打"
z["LH349_REINFORCEMENT_SKIN_3"] = "街头霸王"
z["TOWER_G45_PICK"] = "携带%i塔"
z["HERO_G1_LEVEL10_ON"] = "1代初始满级"
z["HERO_G1_LEVEL10_OFF"] = "1代初始1级"
z["HERO_BALANCE_ON"] = "英雄补强已开启"
z["HERO_BALANCE_OFF"] = "英雄补强已关闭"
z["TRANSPLANTING"] = "移植中\n敬请期待"
z["REINFORCEMENT_0"] = "三援兵(关)"
z["REINFORCEMENT_1"] = "三援兵(开)"
z["FLBALANCE_1"] = "怪物增强(开)"
z["FLSTANDARD_2"] = "怪物增强(关)"
z["BUTTON_MELEE_RANGE"] = "显示拦截"
z["MAP_EDITOR"] = "地图编辑器"
z["USE3TOOWER_COUNT_0"] = "全代"
z["USE3TOOWER_COUNT_1"] = "前三代"
z["USE3TOOWER_COUNT_2"] = "四五代"

z["FLBALANCE_ENEMY"] = "怪物增强"
z["THIS_YES_0"] = "否"
z["THIS_YES_1"] = "是"
z["THIS_YES"] = "是"
z["THIS_NO"] = "否"
z["G5_KINGDOM_DARK"] = "5代英雄羁绊"
z["G5_KINGDOM_DARK_REINFORCE"] = "王国援兵/黑暗援兵"
z["G5_KINGDOM_DARK_REINFORCEMENT_1"] = "王国援兵"
z["G5_KINGDOM_DARK_REINFORCEMENT_2"] = "黑暗援兵"
z["LH349_REINFORCEMENT_COUNT"] = "前三代援兵数量"
z["LH349_REINFORCEMENT_COUNT_0"] = "二"
z["LH349_REINFORCEMENT_COUNT_1"] = "三"
z["G123PICK"]= "携带几代的防御塔"
z["TOWER_G45_PICK_COUNT"] = "四五代塔携带数量"
z["TOWER_45_PICK_COUNT"] = "%i"
z["BALANCE_MODE_BETTER"] = "防御塔补强"
z["BALANCE_MODE_BETTER_4"] = "四代索敌范围"
z["FL_RANGE_BALANCE_RANGE"] = "调整"
z["FL_RANGE_STD_RANGE"] = "原版"
z["IS_CHEAT_GOLD"]= "启用金手指"
z["IS_CHEAT_LOONG"]= "启用龙魂"
z["IS_CHEAT_HERO"]= "一二三代英雄召唤"
z["IS_CHEAT_HERO_5"]= "四五代英雄召唤"
z["IS_RAND_ENEMY"]= "随机怪物等级"
z["IS_RAND_TOWER"]= "随机防御塔数量"
z["IS_RAND_MODE"]= "防御塔随机等级"
z["IS_RAND_HERO"]= "随机英雄"
z["RAND_CREEP_ENEMY_0"]= "关闭"
z["RAND_CREEP_ENEMY_1"]= "小幅随机"
z["RAND_CREEP_ENEMY_2"]= "中幅随机"
z["RAND_CREEP_ENEMY_3"]= "大幅随机"
z["RAND_TOWER_COUNT_0"]= "关闭"
z["RAND_TOWER_COUNT_1"]= "随机4塔"
z["RAND_TOWER_COUNT_2"]= "随机8塔"
z["RAND_TOWER_COUNT_3"]= "随机12塔"
z["RAND_TOWER_COUNT_4"]= "随机16塔"
z["RAND_TOWER_COUNT_5"]= "随机20塔"
return z
