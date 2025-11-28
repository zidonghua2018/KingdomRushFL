local log = require("klua.log"):new("utils_pld")

require("klua.table")

local km = require("klua.macros")
local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local V = require("klua.vector")
local P = require("path_db")
local GS = require("game_settings")
local U = require("utils_5")

require("constants")

local ULH = {}

-- customization
--[[makes a shallow copy of an array]]
local function shallow_copy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

--[[returns sorted array of enemies by curret health. if same health, then by foremost]]
function ULH.sort_by_strongest_enemy(valid_enemies, origin)
	local sorted_enemies = shallow_copy(valid_enemies)
	table.sort(sorted_enemies, function(enemy1, enemy2)
		local hp1 = enemy1.health.hp
		local hp2 = enemy2.health.hp
		--[[if the health of the enemies is the same, then return the distance of the enemies to the origin]]
		if hp1 == hp2 then
			return V.dist(enemy1.pos.x, enemy1.pos.y, origin.x, origin.y) < V.dist(enemy2.pos.x, enemy2.pos.y, origin.x, origin.y)
	  	end
		--[[if the health of the enemies is not the same, then return the enemy with the higher health]]
		return hp1 > hp2
	end)
   
	return sorted_enemies
end

--[[finds the strongest enemy in range, returns the strongest enemy and a sorted list of all enemies by strongest]]
function ULH.find_strongest_enemy_in_range(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
	flags = flags or 0
	bans = bans or 0
	min_override_flags = min_override_flags or 0
 
	--[[gets the array of enemies in range, sorted by the distance to the goal]]
	local _, valid_enemies = U.find_foremost_enemy(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
	--[[if the array enemies doesn't exist, or the number of enemies is 0, then return nil]]
	if not valid_enemies or #valid_enemies == 0 then
		return nil, nil
	end

	--[[returns the first strongest enemy, which makes it so that among equal hp strong enemies, it chooses the one closest to the goal]]
	if(valid_enemies and #valid_enemies > 0) then
		valid_enemies = ULH.sort_by_strongest_enemy(valid_enemies, origin)
	end
 
	return valid_enemies[1], valid_enemies, valid_enemies[1].__ffe_pos
end


--[[returns sorted array of enemies by distance.]]
function ULH.sort_by_backmost_enemy(valid_enemies, origin)
	local sorted_enemies = shallow_copy(valid_enemies)
	table.sort(sorted_enemies, function(e1, e2)
		local p1 = e1.nav_path
		local p2 = e2.nav_path
		return P:nodes_to_goal(p1.pi, p1.spi, p1.ni) > P:nodes_to_goal(p2.pi, p2.spi, p2.ni)
		
	end)
   
	return sorted_enemies
end

--[[finds the backmost enemy in range, returns the backmost enemy and a sorted list of all enemies by backmost]]
function ULH.find_backmost_enemy_in_range(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
	flags = flags or 0
	bans = bans or 0
	min_override_flags = min_override_flags or 0
 
	--[[gets the array of enemies in range, sorted by the distance to the goal]]
	local _, valid_enemies = U.find_foremost_enemy(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
	--[[if the array enemies doesn't exist, or the number of enemies is 0, then return nil]]
	if not valid_enemies or #valid_enemies == 0 then
		return nil, nil
	end

	--[[returns the backmost enemy, which makes it so that among equal hp strong enemies, it chooses the one closest to the goal]]
	if(valid_enemies and #valid_enemies > 0) then
		valid_enemies = ULH.sort_by_backmost_enemy(valid_enemies, origin)
	end
 
	return valid_enemies[1], valid_enemies, valid_enemies[1].__ffe_pos
end

function ULH.sort_by_idmost_enemy(valid_enemies, origin)
	local sorted_enemies = shallow_copy(valid_enemies)
	table.sort(sorted_enemies, function(e1, e2)
		local p1 = e1.id
		local p2 = e2.id
		return p1 < p2
		
	end)
   
	return sorted_enemies
end

--[[finds the backmost enemy in range, returns the backmost enemy and a sorted list of all enemies by backmost]]
function ULH.find_idmost_enemy_in_range(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
	flags = flags or 0
	bans = bans or 0
	min_override_flags = min_override_flags or 0
 
	--[[gets the array of enemies in range, sorted by the distance to the goal]]
	local _, valid_enemies = U.find_foremost_enemy(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
	--[[if the array enemies doesn't exist, or the number of enemies is 0, then return nil]]
	if not valid_enemies or #valid_enemies == 0 then
		return nil, nil
	end

	--[[returns the backmost enemy, which makes it so that among equal hp strong enemies, it chooses the one closest to the goal]]
	if(valid_enemies and #valid_enemies > 0) then
		valid_enemies = ULH.sort_by_idmost_enemy(valid_enemies, origin)
	end
 
	return valid_enemies[1], valid_enemies, valid_enemies[1].__ffe_pos
end

function ULH.find_first_enemy(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func)
	flags = flags or 0
	bans = bans or 0
	local enemy
	for _, e in pairs(entities) do
		if not e.pending_removal and e.enemy and e.health and not e.health.dead and e.vis and band(e.vis.flags, bans) == 0 and band(e.vis.bans, flags) == 0 and U.is_inside_ellipse(e.pos, origin, max_range) and (min_range == 0 or not U.is_inside_ellipse(e.pos, origin, min_range)) and (not filter_func or filter_func(e, origin)) then
			if not enemy or enemy.id > e.id then enemy = e end
		end
	end
	if not enemy then return nil, nil end
	local e_pos, e_ni
	if prediction_time and enemy.motion and enemy.motion.speed then
		if enemy.motion.forced_waypoint then
			local dt = prediction_time == true and 1 or prediction_time
			e_pos = V.v(enemy.pos.x + dt * enemy.motion.speed.x, enemy.pos.y + dt * enemy.motion.speed.y)
			e_ni = enemy.nav_path.ni
		else
			local node_offset = P:predict_enemy_node_advance(enemy, prediction_time)
			e_ni = enemy.nav_path.ni + node_offset
			e_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, e_ni)
		end
		if not U.is_inside_ellipse(e_pos, origin, max_range) or not P:is_node_valid(enemy.nav_path.pi, e_ni) or (min_range ~= 0 and U.is_inside_ellipse(e_pos, origin, min_range)) then
			e_pos = enemy.pos
		end
	else
		e_pos = enemy.pos
	end
	return enemy, V.vclone(e_pos)
end

--排序算法
local bit = require("bit")
local ffi = require("ffi")

local function calc_minrun(n)
    local r = 0
    while n >= 64 do
        r = bit.bor(r, bit.band(n, 1))
        n = bit.rshift(n, 1)
    end
    return n + r
end

local function insertionSort(arr, left, right, cmp)
    for i = left + 1, right do
        local key = arr[i]
        local j = i - 1
        while j >= left and cmp(key, arr[j]) do
            arr[j + 1] = arr[j]
            j = j - 1
        end
        arr[j + 1] = key
    end
end

local function merge(arr, l, m, r, cmp)
    local n1, n2 = m - l + 1, r - m
    local left  = ffi.new(ffi.typeof(arr), n1)
    local right = ffi.new(ffi.typeof(arr), n2)
    for i = 0, n1 - 1 do left[i] = arr[l + i] end
    for j = 0, n2 - 1 do right[j] = arr[m + 1 + j] end

    local i, j, k = 0, 0, l
    while i < n1 and j < n2 do
        if not cmp(right[j], left[i]) then
            arr[k] = left[i]; i = i + 1
        else
            arr[k] = right[j]; j = j + 1
        end
        k = k + 1
    end
    while i < n1 do arr[k] = left[i]; i = i + 1; k = k + 1 end
    while j < n2 do arr[k] = right[j]; j = j + 1; k = k + 1 end
end

function ULH.ffi_timsort(arr, n, cmp)
    --n   = n   or #arr
    --cmp = cmp or function(a, b) return a < b end
    if n <= 1 then return end

    local minrun = calc_minrun(n)
    local runs = {}

    local i = 0
    while i < n do
        local start = i
        if i < n - 1 and cmp(arr[i + 1], arr[i]) then
            while i < n - 1 and cmp(arr[i + 1], arr[i]) do i = i + 1 end
            local l, r_ = start, i
            while l < r_ do
                arr[l], arr[r_] = arr[r_], arr[l]
                l = l + 1; r_ = r_ - 1
            end
        else
            while i < n - 1 and not cmp(arr[i + 1], arr[i]) do i = i + 1 end
        end

        local run_len = i - start + 1
        if run_len < minrun then
            local end_ = math.min(start + minrun - 1, n - 1)
            insertionSort(arr, start, end_, cmp)
            i = end_
        end
        runs[#runs + 1] = {start, i}
        i = i + 1
    end

    while #runs > 1 do
        local newRuns = {}
        for j = 1, #runs, 2 do
            local r1, r2 = runs[j], runs[j + 1]
            if r2 then
                merge(arr, r1[1], r1[2], r2[2], cmp)
                newRuns[#newRuns + 1] = {r1[1], r2[2]}
            else
                newRuns[#newRuns + 1] = r1
            end
        end
        runs = newRuns
    end
end


return ULH