local Player = require('lua.player')
local Platform = require('lua.platform')
local Constants = require('lua.constants')

local Game = {}
Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)

    self.score = 0
    self.gravity = Constants.GRAVITY
    self.platforms = {}
    self.player = nil

    return self
end

function Game:initialize()
    self.player = Player.new(
        Constants.PLAYER.INITIAL_X,
        Constants.PLAYER.INITIAL_Y
    )

    table.insert(self.platforms, Platform.new(
        Constants.PLATFORMS.GROUND.x,
        Constants.PLATFORMS.GROUND.y,
        Constants.PLATFORMS.GROUND.width,
        Constants.PLATFORMS.GROUND.height
    ))

    for _, platform in ipairs(Constants.PLATFORMS.FLOATING) do
        table.insert(self.platforms, Platform.new(
            platform.x,
            platform.y,
            platform.width,
            platform.height
        ))
    end
end

function Game:update(dt)
    self.score = self.score + dt
    self.player:update(dt, self.platforms, self.gravity)
end

function Game:draw()
    for _, platform in ipairs(self.platforms) do
        platform:draw(Constants.COLORS)
    end

    self.player:draw(Constants.COLORS)
    love.graphics.setColor(1, 1, 1)
    local font = love.graphics.newFont(14)
    love.graphics.setFont(font)
    love.graphics.print(string.format("Score: %.0f", self.score * 10), 10, 10)
end

function Game:handleKeyPressed(key)
    if key == 'space' then
        self.player:jump()
    end
end

function Game:handleKeyReleased(key)
    if key == 'w' or key == 'up' or key == 's' or key == 'down' then
        self.player:resetEyeDirection()
    end
end

return Game
