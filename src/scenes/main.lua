require("src/settings")
require("src/elements/square")

MainScene = {name="MainSceneClass"}
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

function MainScene.UserInputAction:mousepressed(scene, x, y, _button)
  if self.source_cell then
    self:get_destination_cell(scene, x, y)
  else
    self:get_source_cell(scene, x, y)
  end
  if self.source_cell and self.destination_cell then
    scene.action = scene.MoveAction.create(self.source_cell,
                                           self.destination_cell)
  end
end

function MainScene.UserInputAction:get_source_cell(scene, x, y)
  local cell = scene:cell_at(x,y)
  if cell.color ~= Settings.colors.empty then
    self.source_cell = cell
  else
    print("clicked empty cell")
  end
end

function MainScene.UserInputAction:get_destination_cell(scene, x, y)
  local cell = scene:cell_at(x,y)
  if cell.color == Settings.colors.empty then
    self.destination_cell = cell
  else
    print("clicked colored cell")
  end
end

MainScene.MoveAction = {}
MainScene.MoveAction.__index = MainScene.MoveAction

function MainScene.MoveAction.create(source, dest)
  local instance = {source = source, dest = dest, color = source.color,
                    time = 0}
  setmetatable(instance, MainScene.MoveAction)
  return instance
end

function MainScene.MoveAction:update(scene, dt)
  self.time = self.time + dt
  if self.time >= 1 then
    self.source.color = Settings.colors.empty
    self.dest.color = self.color
    self.action = scene.DropAction
    return
  end
  for i=1,3 do
    if self.source.color[i] ~= 255 then
      -- transition toward white over 1 second
      self.source.color[i] = 255 * self.time
      if self.source.color[i] > 255 then
        self.source.color[i] = 255
      end
    end
    if self.dest.color[i] ~= self.color[i] then
      -- transition toward target over 1 second
      self.dest.color[i] = self.color[i] * self.time
    end
    if self.dest.color[i] > self.color[i] then
      self.dest.color[i] = self.color[i]
    end
  end
end
