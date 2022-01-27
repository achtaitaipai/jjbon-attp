require("loadTiledMap")
require("player")

--scale of the game
_G.scale=2

function love.load()
    --scale pixels without blur
    love.graphics.setDefaultFilter("nearest", "nearest")
    _G.map=loadTiledMap('assets/testMap')
    _G.player=createPlayer(15,15)
end

function love.update(dt)
    _G.player:update(dt)
end

function love.draw()
    love.graphics.scale(_G.scale)
    _G.map:drawTiles()
    _G.player:draw()
end