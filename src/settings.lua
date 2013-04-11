Settings = {
  square = {size = 80, padding = 3},
  window = {},
  colors = {
    red = {255, 0, 0},
    green = {0, 255, 0},
    blue = {0, 0, 255},
    yellow = {255, 255, 0},
    purple = {255, 0, 255},
    aqua = {0, 255, 255},
    occupied = {"red", "green", "blue", "purple", "yellow", "aqua"},
    empty = {255, 255, 255}
  }
}

Settings.window.size = Settings.square.size * 7 + Settings.square.padding * 8
