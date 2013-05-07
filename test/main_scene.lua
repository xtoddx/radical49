require("test/helper")

require("src/scenes/main")

MainSceneTest = Test.create("MainSceneTest")
function MainSceneTest:test_creates_instance()
  assert_instance_of(MainScene, MainScene.create())
end

function MainSceneTest:test_creates_seven_rows()
  instance = MainScene.create()
  assert_equal(7, #instance.squares)
end

function MainSceneTest:test_creates_seven_columns()
  instance = MainScene.create()
  for row=1,7 do
    if #instance.squares[row] ~= 7 then
      error("There are " .. #instance.squares[row] .. " squares in row " .. row)
    end
  end
end

function MainSceneTest:test_creates_empty_squares()
  instance = MainScene.create()
  for row=1,7 do
    for col=1,7 do
      if instance.squares[row][col].color ~= Settings.colors.empty then
        error("Square at " .. row .. "," .. col .. " is not empty")
      end
    end
  end
end

function MainSceneTest:test_empty_cell_selector_all_empty()
  instance = MainScene.create()
  assert_equal(49, #instance:empty_cells())
end

function MainSceneTest:test_empty_cell_mixed_group()
  instance = MainScene.create()
  instance.squares[1][1].color = Settings.colors.red
  assert_equal(48, #instance:empty_cells())
end
