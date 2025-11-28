-- chunkname: @./all/platform_services_utils.lua

local signal = require("hump.signal")
local psu = {}

function psu:new_prq()
	local t = {}
	local mt = {}

	mt.__index = {
		add = function(this, rid, kind, callback)
			local item = {
				id = rid,
				kind = kind,
				callback = callback,
				ts = love.timer.getTime()
			}

			rawset(this, rid, item)

			return item
		end,
		remove = function(this, rid)
			local item = rawget(this, rid)

			rawset(this, rid, nil)

			return item
		end,
		contains = function(this, rid)
			return rawget(this, rid) ~= nil
		end
	}

	setmetatable(t, mt)

	return t
end

function psu:get_library_path()
	if love.filesystem.isFused() then
		return ""
	else
		local osname = love.system.getOS()
		local path = love.filesystem.getSourceBaseDirectory() .. "/platform/bin"

		if osname == "Windows" then
			return string.format("%s/%s.%s", path, osname, jit.arch)
		elseif osname == "OS X" or osname == "iOS" then
			return string.format("%s/macOS", path)
		elseif osname == "Linux" or osname == "Android" then
			return string.format("%s/%s", path, osname)
		else
			return name
		end
	end
end

function psu:get_library_file(name)
	if love.filesystem.isFused() then
		return name
	else
		local path = self:get_library_path()
		local osname = love.system.getOS()

		if osname == "Windows" then
			return string.format("%s/%s.dll", path, name)
		elseif osname == "OS X" or osname == "iOS" then
			return string.format("%s/lib%s.dylib", path, name)
		elseif osname == "Linux" or osname == "Android" then
			return string.format("%s/lib%s.so", path, name)
		else
			--return name
			--return string.format("%s/%s.dll", path, name)
		end
	end
end

return psu
