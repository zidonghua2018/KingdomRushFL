-- chunkname: @./all-desktop/screen_splash.lua
local V = require("klua.vector")
local F = require("klove.font_db")
local timer = require("hump.timer")

require("klove.kui")

local storage = require("storage")
local screen = {}

screen.required_textures = {
	"screen_splash"
}
screen.ref_h = 1080
screen.ref_res = TEXTURE_SIZE_ALIAS.fullhd

function screen:init(w, h, done_callback)
	self.done_callback = done_callback

	local sw = self.ref_h * (w / h)
	local sh = self.ref_h
	local scale = h / self.ref_h

	self.sw = sw
	self.sh = sh

	local window = KWindow:new(V.v(sw, sh))

	window.scale = {
		x = scale,
		y = scale
	}
	window.colors.background = {
		0,
		0,
		0,
		255
	}
	self.window = window

	local content = KView:new(V.v(sw, sh))
	window:add_child(content)
	self.content = content

	local overlay = KView:new(V.v(sw, sh))
	overlay.colors.background = {
		0,
		0,
		0,
		255
	}
	overlay.alpha = 0
	overlay.hidden = true
	window:add_child(overlay)
	self.overlay = overlay

	self:start_animation()
end

function screen:update(dt)
	timer.update(dt)
	self.window:update(dt)
end

function screen:destroy()
	timer.clear()
	self.window:destroy()

	self.window = nil
end

function screen:draw()
	self.window:draw()
end

function screen:keypressed(key, isrepeat)
	if key ~= KEYPRESS_RETURN and key ~= KEYPRESS_SPACE then return end
	self:skip()
end

function screen:mousepressed(x, y, button)
	if button ~= 1 then return end
	self:skip()
end

function screen:skip()
	if self.skipped then
		return
	end

	self.skipped = true

	timer.clear()

	self.overlay.hidden = false
	self.overlay.alpha = 0

	timer.tween(0.25, self.overlay, {
		alpha = 1
	}, "linear", function()
		self.done_callback(nil)
	end)
end

function screen:start_animation()
	if self.skipped then
		return
	end

	local content = self.content
	local sh = self.sh
	local sw = self.sw
	local st = storage:load_settings()
	local img = KImageView:new("logo_image")
	local iso = KImageView:new("logo_text")

	img.pos.y = sh / 2
	img.anchor.y = img.size.y / 2
	iso.pos.y = sh / 2
	iso.anchor.y = iso.size.y / 2

	content:add_child(img)
	content:add_child(iso)

	local img_shine = KImageView:new("logo_image_shine_0001")

	img_shine.animation = {
		to = 16,
		prefix = "logo_image_shine",
		from = 1
	}
	img_shine.ts = -1
	img_shine.hidden = true

	img:add_child(img_shine)

	local function end_logo_shine()
		timer.tween(0.8, img, {
			alpha = 0
		})
		timer.tween(0.8, iso, {
			alpha = 0
		})
		timer.after(1, function()
			self.done_callback(nil)
		end)
	end

	local function start_logo_shine()
		local sound_fx = love.audio.newSource(KR_PATH_GAME_TARGET .. "/assets/sounds/files/logo_shimmer.ogg", "stream")

		sound_fx:setVolume(st and st.volume_fx or 1)
		sound_fx:play()

		img_shine.ts = 0
		img_shine.hidden = false

		timer.after(0.5666666666666667, function()
			img_shine.hidden = true
		end)
		timer.after(1.5, end_logo_shine)
	end

	img.alpha = 0
	iso.alpha = 0

	timer.tween(0.2, img, {
		alpha = 1
	})
	timer.tween(0.2, iso, {
		alpha = 1
	})

	img.scale.x = 2
	iso.scale.x = 2

	timer.tween(0.2, img.scale, {
		x = 1
	})
	timer.tween(0.2, iso.scale, {
		x = 1
	})

	local iw = math.floor(img.size.x + iso.size.x)

	img.anchor.x = img.size.x
	iso.anchor.x = 0

	local cx = self.sw / 2 - iw / 2 + img.size.x
	local pos_img_x_i = cx - img.size.x / 2
	local pos_img_x_f = cx - img.size.x * 0.05
	local pos_iso_x_i = cx + img.size.x / 2
	local pos_iso_x_f = cx + img.size.x * 0.05

	img.pos.x = pos_img_x_i
	iso.pos.x = pos_iso_x_i

	timer.tween(0.6, img.pos, {
		x = pos_img_x_f
	}, "in-bounce")
	timer.tween(0.6, iso.pos, {
		x = pos_iso_x_f
	}, "in-bounce", start_logo_shine)
end

return screen
