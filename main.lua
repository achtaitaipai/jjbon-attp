require("loadTiledMap")
require("player")
require("spriteSheet")
require("anim")

--scale of the game
_G.scale=2

function love.load()
    --scale pixels without blur
    love.graphics.setDefaultFilter("nearest", "nearest")

    --create spriteSheet
    -- path to the file, width of each sprite, height of each sprite
    local spriteSheet=createSpriteSheet("assets/attpjjbon.png",8,8)

    --define the anims of the player
    local playerSpriteSheet=createSpriteSheet('assets/playerAnim.png',8,8)
    local fps =8
    playerAnims={
        top=createAnim(playerSpriteSheet,{1,2,3},fps,false,1),
        bottom=createAnim(playerSpriteSheet,{1,2,3},fps,false,1),
        left=createAnim(playerSpriteSheet,{4,5,6},fps,true,2),
        right=createAnim(playerSpriteSheet,{4,5,6},fps,false,2)
    }

    --create the map
    _G.map=loadTiledMap('assets/testMap', spriteSheet)
    --create the player
    _G.player=createPlayer(15,15,playerAnims)
end

function love.update(dt)
    _G.player:update(dt)
end

function love.draw()
    love.graphics.scale(_G.scale)
    _G.map:drawTiles()
    _G.player:draw()
end