-- chunkname: @./all-desktop/platform_services_steam.lua

local log = require("klua.log"):new("platform_services_steam")
local PSU = require("platform_services_utils")
local signal = require("hump.signal")
local steam = {}

steam.can_be_paused = false
steam.update_interval = 2
steam.signal_handlers = {
	achievements = {
		["got-achievement"] = function(ach_id)
			steam:unlock_achievement(ach_id)
		end
	}
}
steam.lib = nil
steam.client_ptr = nil
steam.userstats_ptr = nil
steam.apps_ptr = nil
steam.inited = false
steam.USERSTATS_INTERFACE_VERSION = "STEAMUSERSTATS_INTERFACE_VERSION011"
steam.STEAMAPPS_INTERFACE_VERSION = "STEAMAPPS_INTERFACE_VERSION008"

local ffi = require("ffi")

ffi.cdef("    /* Types */\n    typedef int32_t int32;               // type aliases so we can just use steam_api_flat.h copy declarations verbatim\n    typedef uint32_t uint32;\n    typedef uint64_t uint64;\n\n    typedef int32 AppId_t;\n    typedef int32 HSteamPipe;\n    typedef int32 HSteamUser;\n    typedef uint64 SteamAPICall_t;\n    \n    /* Function prototypes */\n    bool SteamAPI_Init();                // native lib init and shutdown  \n    void SteamAPI_Shutdown(); \n    bool SteamAPI_RestartAppIfNecessary(uint32 unOwnAppID);\n    \n    intptr_t SteamClient();              // returns reference to SteamClient singleton\n    \n    HSteamPipe SteamAPI_GetHSteamPipe(); // handle to communication pipe for client communication\n    HSteamUser SteamAPI_GetHSteamUser(); \n\n    intptr_t SteamAPI_ISteamClient_GetISteamApps(intptr_t instancePtr, HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char * pchVersion);\n    uint32   SteamAPI_ISteamApps_GetAppInstallDir(intptr_t instancePtr, AppId_t appID, char * pchFolder, uint32 cchFolderBufferSize);\n\n    /* SteamClient function which returns a reference to SteamUserStats object */\n    intptr_t SteamAPI_ISteamClient_GetISteamUserStats(intptr_t instancePtr, HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char * pchVersion);\n    bool SteamAPI_ISteamClient_BReleaseSteamPipe(intptr_t instancePtr, HSteamPipe hSteamPipe);\n    void SteamAPI_ISteamClient_ReleaseUser(intptr_t instancePtr, HSteamPipe hSteamPipe, HSteamUser hUser);\n    \n    /* SteamUserStats functions (isteamuserstats.h). The instancePtr is the reference to the SteamUsersStats object returned by GetISteamUserStats  */\n    bool SteamAPI_ISteamUserStats_SetAchievement(intptr_t instancePtr, const char * pchName);  // unlock achievement by name\n    bool SteamAPI_ISteamUserStats_RequestCurrentStats(intptr_t instancePtr);                   // request current stats and achievements for the game\n    void SteamAPI_RunCallbacks();                                                              // must be called periodically to pump requests callbacks\n    bool SteamAPI_ISteamUserStats_StoreStats(intptr_t instancePtr);                            // stores any changes to stats and achievements\n    bool SteamAPI_ISteamUserStats_GetAchievement(intptr_t instancePtr, const char * pchName, bool * pbAchieved); // query status for named achievement and return it in pbAchieved\n    bool SteamAPI_ISteamUserStats_ResetAllStats(intptr_t instancePtr, bool bAchievementsToo);  // Development only: reset stats and (optional) achievements\n")

function steam:init(name, params)
	local lib_name, lib, sclient, ustats, astats

	if self.initied then
		log.debug("service %s already inited", name)
	else
		if not params or not params.app_id or type(params.app_id) ~= "number" then
			log.error("platform_services_steam requires app_id param of type number")

			return
		end

		self.app_id = params.app_id
		lib_name = PSU:get_library_file("steam_api")
		self.lib = ffi.load(lib_name)
		lib = self.lib

		if not lib then
			log.error("Steam library %s could not be loaded", lib_name)

			return
		end

		self.inited = lib.SteamAPI_Init()

		if not self.inited then
			log.error("SteamAPI_Init() failed")
			self:restart_app_if_necessary(self.app_id)

			return
		end

		sclient = lib.SteamClient()

		if sclient == nil then
			log.error("SteamClient() returned NULL")
			self:restart_app_if_necessary(self.app_id)

			return
		end

		self.pipe = lib.SteamAPI_GetHSteamPipe()
		self.user = lib.SteamAPI_GetHSteamUser()
		ustats = lib.SteamAPI_ISteamClient_GetISteamUserStats(sclient, self.user, self.pipe, self.USERSTATS_INTERFACE_VERSION)

		if ustats == nil then
			log.error("GetISteamUserStats() returned NULL")
			self:restart_app_if_necessary(self.app_id)

			return
		end

		astats = lib.SteamAPI_ISteamClient_GetISteamApps(sclient, self.user, self.pipe, self.STEAMAPPS_INTERFACE_VERSION)

		if astats == nil then
			log.error("GetISteamApps() returned NULL")
			self:restart_app_if_necessary(self.app_id)

			return
		end

		self:restart_app_if_necessary(self.app_id)

		self.client_ptr = sclient
		self.userstats_ptr = ustats
		self.apps_ptr = astats

		lib.SteamAPI_ISteamUserStats_RequestCurrentStats(self.userstats_ptr)
		lib.SteamAPI_RunCallbacks()

		if KR_GAME == "kr1" then
			local ids = require("data.platform_services_ids")

			if not ids or not ids.steam then
				log.error("data.platform_services_ids for steam not found")

				return nil
			end

			self.ach_mappings = ids.steam.achievements
		end

		log.debug("init true")

		self.inited = true
	end

	for sn, fn in pairs(self.signal_handlers) do
		for sn, fn in pairs(self.signal_handlers[name]) do
			log.debug("registering signal %s", sn)
			signal.register(sn, fn)
		end
	end

	if not self.names then
		self.names = {}
	end

	if not table.contains(self.names, name) then
		table.insert(self.names, name)
	end

	return true
end

function steam:shutdown()
	log.info("Shutting down steam lib")

	local lib = steam.lib

	if lib then
		lib.SteamAPI_Shutdown()
	end

	steam.client_ptr = nil
	steam.userstats_ptr = nil
	steam.lib = nil
	steam.pipe = nil
	steam.user = nil
	steam.inited = false
end

function steam:get_status()
	return self.inited
end

function steam:update(dt)
	local lib = steam.lib

	if steam.inited then
		lib.SteamAPI_RunCallbacks()
	end
end

function steam:get_install_dir()
	local lib = steam.lib

	if not steam.inited then
		return nil
	end

	local folder_len = 1024
	local folder_c = ffi.new("char[?]", folder_len)
	local len = lib.SteamAPI_ISteamApps_GetAppInstallDir(steam.apps_ptr, self.app_id, folder_c, folder_len)
	local folder = ffi.string(folder_c)

	return folder
end

function steam:do_signin()
	return
end

function steam:do_signout()
	return
end

function steam:unlock_achievement(ach_id, defer_store)
	if self.ach_mappings then
		ach_id = self.ach_mappings[ach_id]
	end

	log.debug("unlock achievement %s", ach_id)

	local lib = steam.lib
	local sus = steam.userstats_ptr

	if steam.inited then
		lib.SteamAPI_ISteamUserStats_SetAchievement(sus, ach_id)

		if not defer_store then
			steam:store_stats()
		end
	else
		log.error("SteamAPI not inited yet. Ignoring achievement unlock: %s", tostring(ach_id))

		return false
	end
end

function steam:show_achievements()
	return
end

function steam:achievement_unlocked(ach_id)
	local lib = steam.lib
	local sus = steam.userstats_ptr

	if self.ach_mappings then
		ach_id = self.ach_mappings[ach_id]
	end

	if steam.inited then
		local achieved = ffi.new("bool [1]", {
			false
		})

		lib.SteamAPI_ISteamUserStats_GetAchievement(sus, ach_id, achieved)

		return achieved[0] == true
	else
		log.error("SteamAPI not inited yet. Can't query achievement status: %s", tostring(ach_id))
	end
end

function steam:store_stats()
	local lib = steam.lib
	local sus = steam.userstats_ptr

	if steam.inited then
		lib.SteamAPI_ISteamUserStats_StoreStats(sus)
	else
		log.error("SteamAPI not inited yet. Ignoring store_stats(): ")
	end
end

function steam:reset_stats(achievements_too)
	log.error("RESETTING ALL STATS AND ACHIEVEMENTS!")

	local lib = steam.lib
	local sus = steam.userstats_ptr

	if steam.inited then
		lib.SteamAPI_ISteamUserStats_ResetAllStats(sus, achievements_too)
		steam:store_stats()
	end
end

function steam:restart_app_if_necessary(appid)
	local lib = steam.lib

	if lib.SteamAPI_RestartAppIfNecessary(appid) then
		log.error("SteamAPI_RestartAppIfNecessary() returned true! Steam should soon launch automatically.")

		if DEBUG then
			log.error("DEBUG mode. Skipping restart")
		else
			love.event.quit()
		end

		return true
	else
		return false
	end
end

return steam
