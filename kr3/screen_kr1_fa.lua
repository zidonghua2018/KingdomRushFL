-- chunkname: @./kr1/screen_kr1_end.lua

require("klove.kui")

local S = require("sound_db")
local timer = require("hump.timer").new()
local screen_comics = require("screen_comics")
local screen_credits = require("screen_credits")
local screen = {}

screen.required_sounds = {
	"common",
	"music_screen_kr1_end_fa"
}
screen.required_textures = {
	"screen_credits",
	"comic_end",
	"comic_end_fa"
}
screen.ref_h = GUI_REF_H

if KR_TARGET == "console" then
	screen.ref_res = TEXTURE_SIZE_ALIAS.fullhd / 2
elseif KR_TARGET == "phone" then
	screen.ref_res = TEXTURE_SIZE_ALIAS.iphone
else
	screen.ref_res = TEXTURE_SIZE_ALIAS.ipad
end

function screen:init(sw, sh, done_callback)
	self.sw = sw
	self.sh = sh
	self.done_callback = done_callback
	self.phase = "comic1"

	self:next_item()
end

function screen:update(dt)
	timer:update(dt)
	if self.active_screen then
		self.active_screen:update(dt)
	end
end

function screen:destroy()
	screen_comics:destroy()
	screen_credits:destroy()
end

function screen:draw()
	if self.active_screen then
		self.active_screen:draw()
	end
end

function screen:keypressed(key, isrepeat)
	if self.active_screen then
		self.active_screen:keypressed(key, isrepeat)
	end
end

function screen:mousepressed(x, y, button)
	if self.active_screen then
		self.active_screen:mousepressed(x, y, button)
	end
end

function screen:mousereleased(x, y, button)
	if self.active_screen then
		self.active_screen:mousereleased(x, y, button)
	end
end

function screen:gamepadpressed(joystick, button)
	if self.active_screen and self.active_screen.gamepadpressed then
		self.active_screen:gamepadpressed(joystick, button)
	end
end

function screen:next_item()
	local function cb()
		self:next_item()
	end
	if self.phase == "comic1" then
		S:queue("MusicEndCreditsFA")

		screen_comics.comic_data = love.filesystem.read(KR_PATH_GAME_TARGET .. "/data/comics/21.csv")
		screen_comics.fade_in = {
			1,
			{
				0,
				0,
				0,
				0
			}
		}

		screen_comics:init(self.sw, self.sh, cb)

		self.active_screen = screen_comics
		self.phase = "credits"
	elseif self.phase == "credits" then
		
		screen_credits.credits_data = require("data.credits_data_fa")
		screen_credits:init(self.sw, self.sh, cb, true)

		self.active_screen = screen_credits
		self.phase = "done"
	else
		S:stop_all()

		self.active_screen = nil

		self.done_callback({
			level_idx = 33,
			next_item_name = "map"
		})
	end
end

return screen
