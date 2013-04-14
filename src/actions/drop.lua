DropAction = {}
function DropAction:update(scene, dt)
  local empties = scene:empty_cells()
  local placements = self.select_cells_for_placement(empties,
                                                     scene.squares_per_drop)
  self.assign_colors_to_cells(placements)
  if scene:is_game_over() then
    scene.action = GameOverAction
  else
    scene.action = UserInputAction
  end
end

function DropAction.select_cells_for_placement(empties, count)
  local placements = {}
  for placement=1,count do
    if #empties > 0 then
      placements[#placements+1] = table.remove(empties, math.random(#empties))
    end
  end
  return placements
end

function DropAction.assign_colors_to_cells(placements)
  for placement=1,#placements do
    local color_index = math.random(#Settings.colors.occupied)
    local color_name = Settings.colors.occupied[color_index]
    placements[placement].color = Settings.colors[color_name]
  end
end
