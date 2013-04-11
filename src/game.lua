require("src/scenes/main")
require("src/settings")

Game = {default_scene = "main",
        scenes = {main = MainScene}}

function Game.initialize()
  Game.current_scene = Game.scenes[Game.default_scene].create()
  love.graphics.setMode(Settings.window.size, Settings.window.size)
end
