-- chunkname: @./all-desktop/platform_services_gamecenter.lua

require("klua.string")

local log = require("klua.log"):new("platform_services_gamecenter")
local PSU = require("platform_services_utils")
local signal = require("hump.signal")
local gamecenter = {}

gamecenter.can_be_paused = false
gamecenter.update_interval = 2
gamecenter.signal_handlers = {
	achievements = {
		["got-achievement"] = function(ach_id)
			gamecenter:unlock_achievement(ach_id)
		end
	}
}
gamecenter.lib = nil
gamecenter.inited = false

local ffi = require("ffi")

ffi.cdef("bool  gkw_initialize(void);\nvoid  gkw_shutdown(void);\nint   gkw_get_status(void);\nint   gkw_get_request_status(int rid);\nvoid  gkw_delete_request(int rid);\nbool  gkw_ach_unlock(const char* name);\nbool  gkw_ach_reset_all(void);\nconst char* gkw_ach_get_cached(void);\nint   gkw_create_request_ach_sync(void);\n")

function gamecenter:init(name, params)
	local lib_name, lib, ids

	if self.initied then
		log.debug("service %s already inited", name)
	else
		lib_name = PSU:get_library_file("kgamekit")
		self.lib = ffi.load(lib_name)

		if not self.lib then
			log.error("Error loading kgamekit library")

			return false
		end

		self.inited = self.lib.gkw_initialize()

		if not self.inited then
			log.error("Error initializing kgamekit")

			return false
		end

		ids = require("data.platform_services_ids")

		if not ids or not ids.gamecenter then
			log.error("data.platform_services_ids for gamecenter not found")

			return nil
		end

		self.ids = ids.gamecenter
		self.prq = PSU:new_prq()
	end

	for sn, fn in pairs(self.signal_handlers) do
		for sn, fn in pairs(self.signal_handlers[name]) do
			log.debug("registering signal %s", sn)
			signal.register(sn, fn)
		end
	end

	return true
end

function gamecenter:shutdown()
	log.debug("Shutting down ")

	if self.inited then
		self.lib.gkw_shutdown()
	end

	self.lib = nil
	self.inited = false
end

function gamecenter:get_status()
	return self.inited
end

function gamecenter:update(dt)
	return
end

function gamecenter:get_install_dir()
	local o = love.filesystem.getUserDirectory() .. ".config"

	return o
end

function gamecenter:get_pending_requests()
	return self.prq
end

function gamecenter:get_request_status(rid)
	if self.inited then
		local result = self.lib.gkw_get_request_status(rid)

		log.paranoid("get_request_status(%s) = %s", rid, result)

		return result
	end

	return -1
end

function gamecenter:cancel_request(rid)
	if not rid then
		return
	end

	self.prq:remove(rid)

	if self.inited then
		self.lib.gkw_delete_request(rid)
	end
end

function gamecenter:do_signin()
	return
end

function gamecenter:do_signout()
	return
end

function gamecenter:unlock_achievement(ach_id, defer_store)
	if not self.inited then
		log.error("kgamekit not initialized")

		return
	end

	local gkw_ach_id = self.ids.achievements[ach_id]

	if not gkw_ach_id then
		log.error("gkw achievement id missing for %s", ach_id)

		return
	end

	self.lib.gkw_ach_unlock(gkw_ach_id)
	log.debug("Unlocked achievement %s (%s)", ach_id, gkw_ach_id)
end

function gamecenter:sync_achievements()
	local function cb_sync_achievements(status, req)
		if not self.prq:contains(req.id) then
			return
		end

		local success

		if status == 0 then
			success = true
			self.sync_times.achievements = os.time()
		else
			success = false
			self.sync_times.achievements = false
		end

		signal.emit(SGN_PS_SYNC_ACHIEVEMENTS_FINISHED, "achievements", success, req.id)
	end

	local rid = self.lib.gkw_create_request_ach_sync()

	if rid < 0 then
		log.error("error creating request to sync achievements")

		return nil
	end

	self.prq:add(rid, "sync_achievements", cb_sync_achievements)

	return rid
end

function gamecenter:list_achievements()
	local achs = {}
	local achs_cd = self.lib.gkw_ach_get_cached()

	if achs_cd then
		local achs_str = ffi.string(achs_cd)

		if achs_str and achs_str ~= "" then
			achs = string.split(achs_str, ",")
		end
	end

	return achs
end

function gamecenter:reset_achievements()
	if not self.inited then
		log.error("kgamekit not initialized")

		return
	end

	self.lib.gkw_ach_reset_all()
	log.debug("reset all achievements")
end

return gamecenter
