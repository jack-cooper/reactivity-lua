local effectPackage = require 'effect'
local effect, track, trigger = effectPackage.effect, effectPackage.track,
                               effectPackage.trigger

local symbol = {}

local metatable = {
  __index = function(table, key)
    track(table, key)
    return table[symbol][key]
  end,
  __newindex = function(table, key, value)
    local oldValue = table[symbol][key]
    table[symbol][key] = value
    if oldValue ~= value then
      trigger(table, key)
    end
  end
}

local function reactive(table)
  local proxy = {}
  proxy[symbol] = table
  setmetatable(proxy, metatable)
  return proxy
end

local function ref(initialValue)
  return reactive({ value = initialValue })
end

local function computed(getter)
  local result = ref()
  effect(function()
    result.value = getter()
  end)

  return result
end

return { computed = computed, reactive = reactive, ref = ref }
