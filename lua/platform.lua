local Platform = {}
Platform.__index = Platform

function Platform.new(x, y, width, height)
    local self = setmetatable({}, Platform)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    return self
end

function Platform:draw(colors)
    -- Platform body
    love.graphics.setColor(unpack(colors.PLATFORM))
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    -- Platform edge
    love.graphics.setColor(unpack(colors.PLATFORM_EDGE))
    love.graphics.rectangle('fill', self.x, self.y, self.width, 4)
end

return Platform
