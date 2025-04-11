local Constants = require('lua.constants')

local Player = {}
Player.__index = Player

function Player.new(x, y)
    local self = setmetatable({}, Player)

    self.x = x
    self.y = y
    self.width = Constants.PLAYER.WIDTH
    self.height = Constants.PLAYER.HEIGHT
    self.speed = Constants.PLAYER.SPEED
    self.jumpForce = Constants.PLAYER.JUMP_FORCE
    self.velocityY = Constants.PLAYER.INITIAL_VELOCITY_Y
    self.isJumping = Constants.PLAYER.INITIAL_IS_JUMPING
    self.facingRight = Constants.PLAYER.INITIAL_FACING_RIGHT
    self.eyeDirection = Constants.PLAYER.INITIAL_EYE_DIRECTION

    return self
end

function Player:update(dt, platforms, gravity)
    -- Handle eye movement
    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        self.eyeDirection = -1
    elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        self.eyeDirection = 1
    end

    -- Handle horizontal movement
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.x = self.x - self.speed * dt
        self.facingRight = false
    end

    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.x = self.x + self.speed * dt
        self.facingRight = true
    end

    -- Apply gravity
    self.velocityY = self.velocityY + gravity * dt
    self.y = self.y + self.velocityY * dt

    -- Check for collisions with platforms
    for _, platform in ipairs(platforms) do
        if self:checkCollision(platform) then
            -- If player is falling (velocityY > 0)
            if self.velocityY > 0 then
                self.y = platform.y - self.height
                self.velocityY = 0
                self.isJumping = false
            end
        end
    end

    -- Keep player in bounds
    if self.x < 0 then self.x = 0 end
    if self.x > Constants.SCREEN_WIDTH - self.width then
        self.x = Constants.SCREEN_WIDTH - self.width
    end
    if self.y < 0 then self.y = 0 end
end

function Player:jump()
    if not self.isJumping then
        self.velocityY = self.jumpForce
        self.isJumping = true
    end
end

function Player:resetEyeDirection()
    self.eyeDirection = 0
end

function Player:checkCollision(platform)
    return self.x < platform.x + platform.width and
        self.x + self.width > platform.x and
        self.y < platform.y + platform.height and
        self.y + self.height > platform.y
end

function Player:draw(colors)
    local x, y = self.x, self.y
    local direction = self.facingRight and 1 or -1

    -- Body
    love.graphics.setColor(unpack(colors.PLAYER_BODY))
    love.graphics.rectangle('fill', x + 8, y + 8, 16, 24)

    -- Head
    love.graphics.setColor(unpack(colors.PLAYER_HEAD))
    love.graphics.rectangle('fill', x + 4, y, 24, 16)

    -- Horns
    love.graphics.setColor(unpack(colors.PLAYER_BODY))
    love.graphics.polygon('fill',
        x + 3, y + 4,
        x + 5, y - 2,
        x + 4, y - 10,
        x + 6, y - 14,
        x + 8, y - 10,
        x + 7, y - 2,
        x + 9, y + 4
    )
    love.graphics.polygon('fill',
        x + 19, y + 4,
        x + 21, y - 2,
        x + 20, y - 10,
        x + 22, y - 14,
        x + 24, y - 10,
        x + 23, y - 2,
        x + 25, y + 4
    )

    -- Eyes
    love.graphics.setColor(unpack(colors.PLAYER_EYES))
    local eyeOffset = direction * 4
    local eyeVerticalOffset = self.eyeDirection * 2

    love.graphics.rectangle('fill', x + 8 + eyeOffset, y + 4 + eyeVerticalOffset, 4, 4)
    love.graphics.rectangle('fill', x + 16 + eyeOffset, y + 4 + eyeVerticalOffset, 4, 4)

    -- Pupils
    love.graphics.setColor(unpack(colors.PLAYER_PUPILS))
    love.graphics.rectangle('fill', x + 9 + eyeOffset, y + 5 + eyeVerticalOffset, 2, 2)
    love.graphics.rectangle('fill', x + 17 + eyeOffset, y + 5 + eyeVerticalOffset, 2, 2)

    -- Arms
    love.graphics.setColor(unpack(colors.PLAYER_ARMS))
    love.graphics.rectangle('fill', x + 4, y + 12, 4, 12)
    love.graphics.rectangle('fill', x + 24, y + 12, 4, 12)

    -- Legs
    love.graphics.setColor(unpack(colors.PLAYER_LEGS))
    love.graphics.rectangle('fill', x + 8, y + 32, 6, 16)
    love.graphics.rectangle('fill', x + 18, y + 32, 6, 16)
end

return Player
