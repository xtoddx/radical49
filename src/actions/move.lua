MoveAction = {}
MoveAction.__index = MoveAction

function MoveAction.create(source, dest)
  local instance = {source = source, dest = dest, color = source.color,
                    time = 0}
  setmetatable(instance, MoveAction)
  return instance
end

function MoveAction:update(scene, dt)
  self.time = self.time + dt
  if self.time >= 1 then
    self.source.color = Settings.colors.empty
    self.dest.color = self.color
    self.action = DropAction
    return
  end
  for i=1,3 do
    if self.source.color[i] ~= 255 then
      -- transition toward white over 1 second
      self.source.color[i] = 255 * self.time
      if self.source.color[i] > 255 then
        self.source.color[i] = 255
      end
    end
    if self.dest.color[i] ~= self.color[i] then
      -- transition toward target over 1 second
      self.dest.color[i] = self.color[i] * self.time
    end
    if self.dest.color[i] > self.color[i] then
      self.dest.color[i] = self.color[i]
    end
  end
end
