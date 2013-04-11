Square = {}
Square.__index = Square

function Square.create(row, column)
  local padded_size = Settings.square.size + Settings.square.padding
  -- Always inset by padding, then space over for previous buttons + paddings
  local instance = {x=Settings.square.padding + ((column-1) * padded_size),
                    y=Settings.square.padding + ((row-1) * padded_size),
                    size=Settings.square.size,
                    color=Settings.colors.empty,
                    row=row,
                    col=column}
  setmetatable(instance, Square)
  return instance
end

function Square:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end
