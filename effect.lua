local Set = require('set')

local targets = {}
setmetatable(targets, { __mode = 'k' })

local activeEffect

local function effect(func)
  activeEffect = func
  activeEffect()
  activeEffect = nil
end

local function track(target, key)
  if not activeEffect then
    return
  end

  local dependencies = targets[target]

  if not dependencies then
    local initialDependencies = {}
    targets[target] = initialDependencies
    dependencies = initialDependencies
  end

  local dependency = dependencies[key]

  if not dependency then
    local initialDependency = Set:new()
    dependencies[key] = initialDependency
    dependency = dependencies[key]
  end

  dependency:add(activeEffect)
end

local function trigger(target, key)
  local dependencies = targets[target]

  if not dependencies then
    return
  end

  local dependency = dependencies[key]

  if dependency then
    for effectFunction in pairs(dependency) do
      effectFunction()
    end
  end
end

return { effect = effect, track = track, trigger = trigger }
