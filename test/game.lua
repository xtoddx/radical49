require("test/helper")

require("src/game")

GameTest = Test.create("GameTest")
function GameTest:test_has_default_scene()
  assert_not_nil(Game.default_scene)
end

function GameTest:test_default_scene_is_in_list_of_scenes()
  assert_not_nil(Game.scenes[Game.default_scene])
end

function GameTest:test_initialized_to_default_scene()
  Game.initialize()
  assert_instance_of(Game.scenes[Game.default_scene], Game.current_scene)
end
