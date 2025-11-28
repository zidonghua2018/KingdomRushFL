-- chunkname: @./globals.lua
local log = require("klua.log"):new("mod")

--[[
使用说明：
将你的 hook 模块名称以键值对形式增加到 globals，键值为 true，然后初始化函数会执行模块的初始化函数
键值为 false 则不进行初始化

hook 函数见 all/hook_utils 模块
使用方法：
1. 预先加载需要的模块，以及 hook_utils 模块

2. 初始化函数中调用函数 HOOK(模块, 要修改的函数, 修改为的目标函数)

3. 目标函数定义： function 函数名(origin, self, ...)
需要注意增加形式参数，其中 origin 为要修改的函数，self 用来传递 self

函数内使用 origin(self, ...) 调用原函数

示例：
local E = require("entity_db")
local HOOK = require("hook_utils").HOOK

my_hook = {}

function my_hook:init()
    HOOK(E, "load", self.E_load)
end

function my_hook:E_load(origin, self, ...)
    print("前")
    origin(self, ...)   -- 只能修改前后
    print("后")
end

return my_hook
--]]

local mod = {}
mod.globals = {
    UH = true,
}

function mod:init()
    for i, v in pairs(self.globals) do  -- 遍历 globals
        if v then   -- 如果键值为 true
            local success, hook = pcall(require, i) -- 初始化
            if success then
                hook:init()

            elseif not string.find(hook, string.format("package.preload['%s']", i), 1, true) then
                -- 若找不到模块则不进行初始化与抛出错误
                error(hook)
            end
        end
    end
end

return mod