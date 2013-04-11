require("src/settings")
require("src/elements/square")

MainScene = {}
MainScene.__index = MainScene

function MainScene.create()
  local instance = {squares_per_drop=3}
  setmetatable(instance, MainScene)
  instance.action = instance.DropAction
  instance.squares = {}
  for row=1,7 do
    instance.squares[row] = {}
    for col=1,7 do
      instance.squares[row][col] = Square.create(row, col)
    end
  end
  return instance
end

function MainScene:draw()
  for row=1,7 do
    for col=1,7 do
      self.squares[row][col]:draw()
    end
  end
end

function MainScene:update(dt)
  self.action:update(self, dt)
end

function MainScene:mousepressed(x, y, button)
  if self.action.mousepressed then
    self.action:mousepressed(self, x, y, button)
  end
end

function MainScene:is_game_over()
  if #self:empty_cells() == 0 then
    return true
  else
    return false
  end
end

function MainScene:select_cells(test)
  local rv = {}
  for row=1,7 do
    for col=1,7 do
      if test(self.squares[row][col]) then
        rv[#rv+1] = self.squares[row][col]
      end
    end
  end
  return rv
end

function MainScene.empty_selector(cell)
  if cell.color == Settings.colors.empty then
    return true
  else
    return false
  end
end

function MainScene:empty_cells()
  return self:select_cells(self.empty_selector)
end

MainScene.DropAction = {}
function MainScene.DropAction:update(scene, dt)
  local empties = scene:empty_cells()
  local placements = self.select_cells_for_placement(empties,
                                                     scene.squares_per_drop)
  self.assign_colors_to_cells(placements)
  if scene:is_game_over() then
    scene.action = scene.GameOverAction
  else
    scene.action = scene.UserInputAction
  end
end

function MainScene.DropAction.select_cells_for_placement(empties, count)
  local placements = {}
  for placement=1,count do
    if #empties > 0 then
      placements[#placements+1] = table.remove(empties, math.random(#empties))
    end
  end
  return placements
end

function MainScene.DropAction.assign_colors_to_cells(placements)
  for placement=1,#placements do
    local color_index = math.random(#Settings.colors.occupied)
    local color_name = Settings.colors.occupied[color_index]
    placements[placement].color = Settings.colors[color_name]
  end
end

MainScene.UserInputAction = {}
function MainScene.UserInputAction:update(scene, dt)
end

function MainScene.UserInputAction:mousepressed(scene, x, y, button)
  print("mousepressed: " .. x .. ', ' .. y .. ' (' .. button .. ')')
end
