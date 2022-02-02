require("modules/utils")
require("modules/loadTiledMap")
require("modules/player")
require("modules/spriteSheet")
require("modules/anim")
require("modules/camera")
require("modules/dialogBox")
require("modules/objects")
require("modules/city")

function love.load()
    --scale pixels without blur
    love.graphics.setDefaultFilter("nearest", "nearest")

    local font = love.graphics.newImageFont( "assets/abcmin.png", "'abcdefghijklmnopqrstuvwxyz[!]~ " )
    love.graphics.setFont(font)
    scene={createCity()}
end

function love.update(dt)
    if scene[1].update~= nil then
        scene[1]:update(dt)
    end
end

function love.draw()
    if scene[1].draw ~= nil then
        scene[1]:draw()
    end
end

function love.keypressed( key )
    if scene[1].keyPressed ~= nil then
        scene[1]:keyPressed(key)
    end
 end