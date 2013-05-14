love = {}
love.graphics = {}

function love.graphics.setMode(...)
  love.graphics._mode = ...
end

function love.graphics.rectangle(...)
  love.graphics._rectangle = ...
end

function love.graphics.setColor(color)
  love.graphics._color = color
end
