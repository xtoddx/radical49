require("src/game")

function love.load()
  Game.initialize()
end

function love.draw()
  Game.current_scene:draw()
end

function love.update(dt)
  Game.current_scene:update(dt)
end

function love.mousepressed(x, y, button)
  Game.current_scene:mousepressed(x, y, button)
end
