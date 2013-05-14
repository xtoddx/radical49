require("test/lovemock")

function assert_sets_color(target_color, lambda)
  old_setColor = love.graphics.setColor
  colors = {}
  love.graphics.setColor = function(color) colors[#colors + 1] = color end
  lambda()
  love.graphics.setColor = old_setColor
  assert_in_set(target_color, colors)
end
