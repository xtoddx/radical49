require("test/helper")

require("src/actions/drop")
require("src/scenes/main")

DropActionTest = Test.create("DropActionTest")
function DropActionTest:test_drops_on_blank_board()
  scene = MainScene.create()
  cell_count = #scene:empty_cells()
  _update_time = 100
  DropAction:update(scene, _update_time)
  assert_equal(cell_count - 3, #scene:empty_cells())
end

function DropActionTest:test_fills_nearly_full_board()
  scene = MainScene.create()
  for row=1,6 do
    for col=1,7 do
      scene.squares[row][col] = Settings.colors.red
    end
  end
  for col=1,6 do
    scene.squares[7][col] = Settings.colors.red
  end

  -- (one empty left)
  _update_timer = 100
  DropAction:update(scene, _update_timer)

  assert_equal(0, #scene:empty_cells())
end

function DropActionTest:test_writes_correct_number_of_squares()
  scene = MainScene.create()
  scene.squares_per_drop = 10
  cell_count = #scene:empty_cells()
  DropAction:update(scene, _update_time)
  assert_equal(cell_count - 10, #scene:empty_cells())
end
