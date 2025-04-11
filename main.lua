local Game = require('lua.game')
local Constants = require('lua.constants')

local game = Game.new()

function love.load()
	love.graphics.setBackgroundColor(Constants.COLORS.BACKGROUND)
	game:initialize()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.keypressed(key)
	game:handleKeyPressed(key)
end

function love.keyreleased(key)
	game:handleKeyReleased(key)
end
