require("test/helper")

require("src/elements/square")

SquareTest = Test.create("SquareTest")
function SquareTest:test_creates_square()
  square = Square.create(3, 3)
  assert_instance_of(Square, square)
end

function SquareTest:test_records_grid_position()
  square = Square.create(3, 4)
  assert_equal(3, square.row)
  assert_equal(4, square.col)
end

function SquareTest:test_sets_screen_position()
  square = Square.create(3, 4)
  -- This assumes a width of 80 and padding of 3 (see src/settings.lua)
  assert_equal(3 * 4 + 80 * 3, square.x)
  assert_equal(3 * 3 + 80 * 2, square.y)
end

function SquareTest:test_initialize_to_empty_color()
  square = Square.create(1, 1)
  assert_equal(Settings.colors.empty, square.color)
end

function SquareTest:test_draws_in_current_color()
  clr = {0, 255, 0}
  square.color = clr
  assert_sets_color(clr, function() square:draw() end)
end

function SquareTest:test_draws_rectangle()
  love.graphics._rectanle = nil
  square = Square.create(1, 1)
  square:draw()
  assert_not_nil(love.graphics._rectangle)
end
