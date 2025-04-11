local M = {}

-- Game constants
M.GRAVITY = 800
M.SCREEN_WIDTH = 800
M.SCREEN_HEIGHT = 600

-- Player configuration
M.PLAYER = {
    INITIAL_X = 100,
    INITIAL_Y = 100,
    WIDTH = 32,
    HEIGHT = 48,
    SPEED = 200,
    JUMP_FORCE = -400,
    INITIAL_VELOCITY_Y = 0,
    INITIAL_IS_JUMPING = false,
    INITIAL_FACING_RIGHT = true,
    -- -1 for down, 0 for center, 1 for up
    INITIAL_EYE_DIRECTION = 0,
}

-- Platform configuration
M.PLATFORMS = {
    GROUND = {
        x = 0,
        y = 500,
        width = 800,
        height = 20
    },
    FLOATING = {
        { x = 200, y = 400, width = 100, height = 20 },
        { x = 400, y = 300, width = 100, height = 20 },
        { x = 600, y = 200, width = 100, height = 20 },
        { x = 800, y = 300, width = 100, height = 20 }
    }
}

-- Color configuration
M.COLORS = {
    BACKGROUND = { 0.1, 0.1, 0.15 },
    PLATFORM = { 0.3, 0.6, 0.3 },
    PLATFORM_EDGE = { 0.2, 0.5, 0.2 },
    PLAYER_BODY = { 0.8, 0.2, 0.2 },
    PLAYER_HEAD = { 0.9, 0.3, 0.3 },
    PLAYER_EYES = { 1, 1, 1 },
    PLAYER_PUPILS = { 0.1, 0.1, 0.1 },
    PLAYER_ARMS = { 0.7, 0.1, 0.1 },
    PLAYER_LEGS = { 0.6, 0.1, 0.1 }
}

-- Helper function to get all platforms including ground
function M.get_all_platforms()
    local all_platforms = { M.PLATFORMS.GROUND }
    for _, platform in ipairs(M.PLATFORMS.FLOATING) do
        table.insert(all_platforms, platform)
    end
    return all_platforms
end

return M
