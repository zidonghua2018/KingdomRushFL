-- chunkname: @./kr5/balance/balance_tmpoverride_example.lua.example

local function fts(v)
	return v / FPS
end

local balance = require("balance/balance")

balance.towers.balance_artillery_new.basic_attack.damage_max = {
	0,
	0,
	0,
	0
}
balance.towers.balance_artillery_new.basic_attack.damage_max[2] = 3
balance.towers.balance_artillery_new.basic_attack.range = 999
