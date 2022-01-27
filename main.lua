require("loadTiledMap")

--scale of the game
_G.scale=3

function love.load()
    --scale pixels without blur
    love.graphics.setDefaultFilter("nearest", "nearest")
    _G.map=loadTiledMap('assets/testMap')
end

function love.update(dt)
end

function love.draw()
    love.graphics.scale(_G.scale)
    _G.map:drawTiles()
end