local Set = {}

function Set:new()
  local set = {}
  setmetatable(set, self)
  self.__index = self

  return set
end

function Set:add(element)
  self[element] = true
end

function Set:contains(element)
  return self[element] ~= nil
end

function Set:remove(element)
  self[element] = nil
end

return Set
