require("src/settings")
require("src/elements/square")
require("src/actions/drop")
require("src/actions/user_input")
require("src/actions/move")

MainScene = {}
MainScene.__index = MainScene

function MainScene.create()
  local instance = {squares_per_drop=3}
  setmetatable(instance, MainScene)
  instance.action = DropAction
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

function MainScene:cell_at(x, y)
  local relative_x = x - Settings.square.padding
  local cell_distance = Settings.square.padding + Settings.square.size
  local column = 1
  while relative_x > cell_distance do
    relative_x = relative_x - cell_distance
    column = column + 1
  end
  local relative_y = y - Settings.square.padding
  local row = 1
  while relative_y > cell_distance do
    relative_y = relative_y - cell_distance
    row = row + 1
  end
  return self.squares[row][column]
end
