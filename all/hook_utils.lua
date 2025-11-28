local hook_utils = {}

function hook_utils.HOOK(obj, fn_name, handler)
    if not obj._hook_origin_fn then -- 若没有 hook 给定的函数
        obj._hook_origin_fn = {}
    elseif obj._hook_origin_fn[fn_name] then    -- 若已 hook 给定的函数直接返回
        return
    end

    local hook_fn = obj[fn_name]    -- 存储原函数

    obj._hook_origin_fn[fn_name] = hook_fn  -- 标记已 hook

    obj[fn_name] = function(...)
        return handler(hook_fn, ...)    -- 替换原函数
    end
end

function hook_utils.UNHOOK(obj, fn_name)    -- 移除 hook
    if not obj._hook_origin_fn then -- 若对应函数未 hook 直接返回
        return
    end

    local hook_fn = obj._hook_origin_fn[fn_name]    -- 存储 hook 后的函数

    if not hook_fn then
        return
    end

    obj[fn_name] = hook_fn  -- 还原
    obj._hook_origin_fn[fn_name] = nil  -- 移除标记
end

return hook_utils