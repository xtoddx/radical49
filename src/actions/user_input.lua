UserInputAction = {}
function UserInputAction:update(scene, dt)
end

function UserInputAction:mousepressed(scene, x, y, _button)
  if self.source_cell then
    self:get_destination_cell(scene, x, y)
  else
    self:get_source_cell(scene, x, y)
  end
  if self.source_cell and self.destination_cell then
    scene.action = MoveAction.create(self.source_cell, self.destination_cell)
  end
end

function UserInputAction:get_source_cell(scene, x, y)
  local cell = scene:cell_at(x,y)
  if cell.color ~= Settings.colors.empty then
    self.source_cell = cell
  else
    print("clicked empty cell")
  end
end

function UserInputAction:get_destination_cell(scene, x, y)
  local cell = scene:cell_at(x,y)
  if cell.color == Settings.colors.empty then
    self.destination_cell = cell
  else
    print("clicked colored cell")
  end
end
