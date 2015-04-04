require("test/helper")

require("src/actions/user_input")
require("src/scenes/main")

UserInputTest = Test.create("UserInputTest")

function UserInputTest:test_selects_colored_cell()
  scene = MainScene.create()
  square = scene.squares[1][1]
  -- see DropAction.assign_colors_to_cells for how we fill cells
  square.color = Settings.colors[color_name]
  _button = "left"
  UserInputAction:mousepressed(scene, square.x + 1, square.y + 1, _button)
  assert_not_nil(UserInputAction.source_cell)
end

function UserInputTest:test_doesnt_select_empty_cell()
  scene = MainScene.create()
  empty = scene.squares[1][2]
  _button = "left"
  UserInputAction:mousepressed(scene, empty.x + 1, empty.y + 1, _button)
  assert_equal(nil, UserInputAction.source_cell)
end

function UserInputTest:test_selects_empty_destination()
end

function UserInputTest:test_doesnt_select_colored_destination()
end

function UserInputTest:test_transitions_to_move_action()
end
