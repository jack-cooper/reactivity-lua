local reactivity = require('reactivity')

local computed, ref = reactivity.computed, reactivity.ref

local celsius = ref(10)

local fahrenheit = computed(function()
  print('Running!')
  return celsius.value * 1.8 + 32
end)

print(fahrenheit.value)
celsius.value = 37.5
print(fahrenheit.value)
